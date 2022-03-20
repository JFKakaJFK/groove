import {
  QueryClient,
} from 'react-query'
import ky, { ResponsePromise } from 'ky'

export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      // 10sec in cache before we try to get new data unless invalidated
      staleTime: 10 * 1000, // 10s
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

export interface APIError {
  status: number;
  message: string;
}

export interface APIResponse<T> {
  error: APIError[]
  data: T
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
  if (res.error?.length > 0) {
    throw new Error(res.error[0]?.message);
  }
  console.log(res) // TODO remove
  return res.data
}