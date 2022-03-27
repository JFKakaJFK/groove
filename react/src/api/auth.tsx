import { createContext, useContext } from "react";
import { useMutation, useQuery } from "react-query";
import { FullPageLoader } from "../components/full-page-loader";
import { api, queryClient, wrapRequest } from "./client";

export interface HabitInfo {
  count: number;
  totalCompletions: number;
  longestStreak: number;
  longestActiveStreak: number;
}

export interface User {
  id: string;
  name: string;
  email: string;
  isAdmin: boolean;
  isPremium: boolean;
  verified: boolean;
  newsletter: boolean;
  //habitInfo: HabitInfo;
}

const currentUser = () => wrapRequest<User>(api.post("currentUser"));

const login = (creds: Credentials) =>
  wrapRequest<User>(api.post("login", { json: creds }));

const register = (data: RegistrationData) =>
  wrapRequest<User>(api.post("register", { json: data }));

const logout = () => wrapRequest<undefined>(api.post("logout"));

// So I was not sure how to best utilize react-query for the auth flow...
// I kind of want an AuthContext providing the auth state that allows me not to think about
// the query lifecycle (promise state) and have the convenience around the lifecycle of the
// login/register/logout requests I would get with useMutation.
// Currently I'm hiding the auth state in the provider and use the mutation hooks direcly
// instead of passing providing them in the authcontext since that feels like an unneccessary
// obfuscation... yet conceptually I feel that the methods mutating the auth state should be
// contained in the auth provider

/* as in I do 1) instead of 2)

// 1)

// where login is needed
const { isLoading, isError, error, mutate } = useLogin()

// 2)
// context
...
const login = useLogin()
...
value={{
  ...
  login
}}

// where login is needed
const {..., login } = useAuth()
const { isLoading, isError, error, mutate } = login

*/

export const useLogin = () =>
  useMutation(login, {
    onSuccess(user) {
      queryClient.setQueryData("currentUser", user);
    },
  });

export interface RegistrationData {
  name: string;
  email: string;
  password: string;
  newsletter?: boolean;
}

export const useRegister = () =>
  useMutation(register, {
    onSuccess(user) {
      queryClient.setQueryData("currentUser", user);
    },
  });

export const useLogout = () =>
  useMutation(logout, {
    onSuccess(user) {
      queryClient.setQueryData("currentUser", user);
    },
    onError() {
      queryClient.invalidateQueries("currentUser");
    },
  });

export interface AuthContext {
  isAuthenticated: boolean;
  user?: User;
  //login(creds: Credentials): Promise<void>;
  //logout(): Promise<void>;
  //register(data: RegistrationData): Promise<void>;
}

const authContext = createContext({} as unknown as AuthContext);

// queryClient.prefetchQuery("currentUser", currentUser);

export function AuthProvider({ children }: { children: JSX.Element }) {
  const { isLoading, data: user } = useQuery("currentUser", currentUser, {
    retry: false,
    // retryOnMount: false,
    // check every 8hrs
    staleTime: 8 * 60 * 60 * 1000,
    // TODO persist?
    // initialData:
    //   JSON.parse(localStorage.getItem("currentUser") ?? "false") ?? undefined,
    // onSuccess(user) {
    //   localStorage.setItem("currentUser", JSON.stringify(user ?? null));
    // },
  });

  if (isLoading) {
    return <FullPageLoader />;
  }

  return (
    <authContext.Provider
      value={{
        isAuthenticated: !!user,
        user,
      }}
    >
      {children}
    </authContext.Provider>
  );
}

export const useAuth = () => useContext(authContext);

export interface Credentials {
  email: string;
  password: string;
  stayLoggedIn?: boolean;
}
