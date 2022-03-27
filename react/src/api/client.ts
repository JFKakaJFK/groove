import {
  QueryClient,
} from 'react-query'
import ky, { ResponsePromise } from 'ky'

export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      // time in cache before we try to get newer data instead of relying on the cache
      staleTime: 60 * 1000, // 1min
      cacheTime: 24 * 60 * 60 * 1000 // 24h
    }
  }
})

// TODO persist cache https://react-query.tanstack.com/plugins/persistQueryClient

export const api = ky.create({
  // Without proxy this would be something like
  // https://localhost:8080/mainappfile/api
  prefixUrl: '/api'
})

export interface APIErrorResponse {
  status: number;
  message: string;
}

export interface APIResponse<T> {
  error: APIErrorResponse[]
  data: T
}

export class APIError extends Error {
  status: number

  constructor(status: number, message: string) {
    super(message)
    this.status = status
    this.name = "APIError"
  }
}

/**
 * Wraps API requests with custom error handling since WebDSL does not support
 * returning the corresponding HTTP status code...
 * 
 * @param req the API request
 * @returns 
 */
export async function wrapRequest<T>(req: ResponsePromise): Promise<T> {
  const res = await req.json() as APIResponse<T>
  if (Array.isArray(res.error) && res.error.length > 0) {
    throw new APIError(res.error[0].status, res.error[0].message);
  }
  return res.data
}

export function CREATE<T extends object>(data: T) {
  return { ...data, "_method": "CREATE" }
}
export function QUERY<T extends object>(data: T) {
  return { ...data, "_method": "QUERY" }
}
export function UPDATE<T extends object>(data: T) {
  return { ...data, "_method": "UPDATE" }
}
export function DELETE<T extends object>(data: T) {
  return { ...data, "_method": "DELETE" }
}