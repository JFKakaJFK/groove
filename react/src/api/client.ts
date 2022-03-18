import {
  useQuery,
  useMutation,
  useQueryClient,
  QueryClient,
  QueryClientProvider,
} from 'react-query'
import ky from 'ky'

// Create a client
export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      // 10sec in cache before we try to get new data unless invalidated
      staleTime: 1000 * 10,
    }
  }
})
export const api = ky.create({
  // not really needed in our case thanks to the proxy...
  //prefixUrl: 'api' //https://localhost:8080/mainappfile
})

// TODO define useQueryName for all queries to get the best out of react query