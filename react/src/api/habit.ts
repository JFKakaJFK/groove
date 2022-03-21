import { useMutation, useQuery, UseQueryOptions } from "react-query";
import { api, CREATE, DELETE, QUERY, queryClient, UPDATE, wrapRequest } from "./client";

export interface StreakInfo {
  longest: number;
  avg: number;
  current: number;
  completionRage: number;
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
}
const updateHabit = (data: UpdateHabitData) => wrapRequest<Habit>(api.post("habit", {
  json: UPDATE(data)
}));

export const useUpdateHabit = () => useMutation(updateHabit, {
  onSuccess(habit) {
    queryClient.setQueryData(['habit', habit.id], habit)
  }
});

export interface CreateHabitData {
  name: string
  description?: string
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
  json: DELETE(id)
}));

export const useDeleteHabit = () => useMutation(deleteHabit, {
  onSuccess(habit) {
    queryClient.removeQueries(['habit', habit.id]) // TODO test if works correctly
    queryClient.invalidateQueries('habits')
  }
});