import { useMutation, useQuery, UseQueryOptions } from "react-query";
import { User } from "./auth";
import { api, DELETE, QUERY, queryClient, UPDATE, wrapRequest } from "./client";

const users = () => wrapRequest<User[]>(api.post("users", { json: QUERY({}) }));

export const useUsers = (options?: Omit<UseQueryOptions<User[], unknown, User[], "users">, "queryKey" | "queryFn"> | undefined) => useQuery("users", users, options);

export interface UserUpdateRequest {
  id: string
  name?: string
  email?: string
  password?: string
  newsletter?: boolean
  isPremium?: boolean
  isAdmin?: boolean
}

const updateUser = (data: UserUpdateRequest) => wrapRequest<User>(api.post("user", { json: UPDATE(data) }));

const deleteUser = (id: string) => wrapRequest<null>(api.post("user", { json: DELETE({ id }) }));

export const usePromoteUser = () => useMutation((id: string) => updateUser({ id, isPremium: true }), {
  onSuccess(user, id) {
    if (queryClient.getQueryState("users"))
      queryClient.setQueryData<User[] | undefined>("users", entries => entries?.map(u => u.id === id ? user : u))
  }
})

export const useDeleteUser = () => useMutation(deleteUser, {
  onSuccess(_, id) {
    if (queryClient.getQueryState("users"))
      queryClient.setQueryData<User[] | undefined>("users", entries => entries?.filter(u => u.id !== id))
  }
})
