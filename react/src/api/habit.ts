import { useMutation, useQuery, UseQueryOptions } from "react-query";
import { YearMonth } from "../utils";
import { api, CREATE, DELETE, QUERY, queryClient, UPDATE, wrapRequest } from "./client";

export interface StreakInfo {
  longest: number;
  avg: number;
  current: number;
  completionRate: number;
}

export interface Habit {
  id: string;
  user: string;
  name: string;
  description: string;
  color: string;
  info: StreakInfo;
}

const habits = () => wrapRequest<Habit[]>(api.post("habits"));

export const useHabits = (options?: Omit<UseQueryOptions<Habit[], unknown, Habit[], "habits">, "queryKey" | "queryFn"> | undefined) => useQuery("habits", habits, options);

const getHabit = (id: string) => wrapRequest<Habit>(api.post("habit", {
  json: QUERY({
    id
  })
}));

export const useHabit = (
  id: string,
  options?: Omit<UseQueryOptions<Habit, unknown, Habit, string[]>, "queryKey" | "queryFn"> | undefined
) => useQuery(["habit", id], () => getHabit(id), options);


export interface UpdateHabitData {
  id: string
  name?: string
  description?: string
  color?: string
}
const updateHabit = (data: UpdateHabitData) => wrapRequest<Habit>(api.post("habit", {
  json: UPDATE(data)
}));

export const useUpdateHabit = () => useMutation(updateHabit, {
  onSuccess(habit) {
    queryClient.setQueryData(['habit', habit.id], habit)
    queryClient.invalidateQueries('habits')
  }
});

export interface CreateHabitData {
  name: string
  description?: string
  color?: string
}
const createHabit = (data: CreateHabitData) => wrapRequest<Habit>(api.post("habit", {
  json: CREATE(data)
}));

export const useCreateHabit = () => useMutation(createHabit, {
  onSuccess(habit) {
    queryClient.setQueryData(['habit', habit.id], habit)
    queryClient.invalidateQueries('habits')
  }
});

const deleteHabit = (id: string) => wrapRequest<Habit>(api.post("habit", {
  json: DELETE({ id })
}));

export const useDeleteHabit = () => useMutation(deleteHabit, {
  onSuccess(_, id) {
    queryClient.removeQueries(['habit', id])
    queryClient.invalidateQueries('habits')
  }
});

export type HabitColor = string

// -- color stuff ---
const colors = () => wrapRequest<HabitColor[]>(api.post("colors"));

export const useColors = () => useQuery("colors", colors, {
  staleTime: Infinity // currently the colors never change
});

// --- completion stuff ---

export interface CompletionQuery {
  habit: string
  date: Date
}

export interface CompletionUpdate extends CompletionQuery {
  completed: boolean
}

export interface Completion {
  date: Date
  completed: boolean
}

export const fmtDate = (d: Date) => `${d.getFullYear().toString().padStart(4, '0')}-${(d.getMonth() + 1).toString().padStart(2, '0')}-${d.getDate().toString().padStart(2, '0')}`

const restoreDates = (key: string, value: any) => key === "date" ? new Date(Date.parse(value)) : value

const getCompleted = ({ habit, date }: CompletionQuery) => wrapRequest<Completion>(api.post("completion", {
  json: QUERY({ habit, date: fmtDate(date) }),
  parseJson: data => JSON.parse(data, restoreDates)
}));

const setCompleted = (data: CompletionUpdate) => wrapRequest<Completion>(api.post("completion", {
  json: UPDATE(data),
  parseJson: data => JSON.parse(data, restoreDates)
}));


function onCompletionMutateSuccess(data: Completion, vars: CompletionUpdate) {
  queryClient.invalidateQueries(["habit", vars.habit])
  queryClient.setQueryData(["completion", vars.habit, fmtDate(vars.date)], data)
  const ym = YearMonth.fromDate(vars.date)
  // update the corresponding queries instead of invalidating them, saving one request
  // other months get invalidated though
  // queryClient.invalidateQueries(["completions", vars.habit, fmtDate(ym.start), fmtDate(ym.end)])
  if (queryClient.getQueryState(["completions", vars.habit, fmtDate(ym.start), fmtDate(ym.end)]))
    queryClient.setQueryData<Completion[] | undefined>(["completions", vars.habit, fmtDate(ym.start), fmtDate(ym.end)],
      entries => entries?.map(c => c.date.getTime() === vars.date.getTime() ? data : c))
  queryClient.invalidateQueries(["completions", vars.habit, fmtDate(ym.prev.start), fmtDate(ym.prev.end)])
  // queryClient.setQueryData<Completion[] | undefined>(["completions", vars.habit, fmtDate(ym.prev.start), fmtDate(ym.prev.end)],
  //   entries => entries?.map(c => c.date.getTime() === vars.date.getTime() ? data : c))
  queryClient.invalidateQueries(["completions", vars.habit, fmtDate(ym.next.start), fmtDate(ym.next.end)])
  // queryClient.setQueryData<Completion[] | undefined>(["completions", vars.habit, fmtDate(ym.next.start), fmtDate(ym.next.end)],
  //   entries => entries?.map(c => c.date.getTime() === vars.date.getTime() ? data : c))
}

export const useSetCompleted = () => useMutation(setCompleted, {
  onSuccess(data, vars) {
    onCompletionMutateSuccess(data, vars)
  }
})

export function useCompletion(query: CompletionQuery, options?: Omit<UseQueryOptions<Completion, unknown, Completion, string[]>, "queryKey" | "queryFn"> | undefined) {
  const q = useQuery(["completion", query.habit, fmtDate(query.date)], () => getCompleted(query), {
    ...options,
    retryOnMount: false
  })
  const m = useMutation(() => setCompleted({ ...query, completed: !q.data?.completed ?? true }), {
    onSuccess(data) {
      onCompletionMutateSuccess(data, { ...query, completed: !q.data?.completed ?? true })
    }
  })

  return {
    ...m,
    ...q,
    isLoading: q.isLoading || m.isLoading,
  }
}

export interface CompletionsRangeQuery {
  habit: string
  start: Date
  end: Date
}

const completions = ({ habit, start, end }: CompletionsRangeQuery) => wrapRequest<Completion[]>(api.post("completions", {
  json: QUERY({
    habit,
    start: fmtDate(start),
    end: fmtDate(end)
  }),
  parseJson: data => JSON.parse(data, restoreDates)
}))

export const useCompletions = (habit: string, ym: YearMonth) => useQuery(["completions", habit, fmtDate(ym.start), fmtDate(ym.end)], () => completions({
  habit,
  start: ym.start,
  end: ym.end
}))