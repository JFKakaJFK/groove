import { useState, useMemo, useEffect, useRef } from "react";

export interface PromiseState<T> {
  // Promise was not yet called
  isIdle: boolean;
  // Promise was called and is pending
  isLoading: boolean;
  // Promise was rejected with an error
  isError: boolean;
  // Promise was successfully resolved
  isSuccess: boolean;
  data?: Awaited<T>;
  error?: Error;
}

/**
 * A hook to make react play nice with promises
 *
 * @param asyncFn Function returning a promise
 * @returns
 */
export function usePromise<F extends (...args: any[]) => any>(
  asyncFn: F
): [PromiseState<ReturnType<F>>, (...args: Parameters<F>) => ReturnType<F>] {
  const [state, setState] = useState<PromiseState<ReturnType<F>>>({
    isIdle: true,
    isLoading: false,
    isError: false,
    isSuccess: false,
  });
  const isUnmounted = useRef(false);

  const callAsyncFn = useMemo(
    () =>
      (...args: Parameters<F>): ReturnType<F> => {
        const promise = asyncFn(...args);

        if (promise instanceof Promise) {
          return new Promise((resolve) => {
            const fulfillPromise = async () => {
              try {
                const data: Awaited<ReturnType<F>> = await promise;

                if (!isUnmounted.current) {
                  setState({
                    isIdle: false,
                    isLoading: false,
                    isError: false,
                    isSuccess: true,
                    data,
                  });

                  resolve(data);
                }
              } catch (error) {
                if (!isUnmounted.current) {
                  setState(({ data }) => ({
                    isIdle: false,
                    isLoading: false,
                    isError: true,
                    isSuccess: false,
                    data,
                    error:
                      error instanceof Error
                        ? error
                        : new Error(error as string),
                  }));
                }
              }
            };

            setState(({ data }) => ({
              isIdle: false,
              isLoading: true,
              isError: false,
              isSuccess: false,
              data,
            }));

            fulfillPromise();
          }) as ReturnType<F>;
        } else {
          setState({
            isIdle: false,
            isLoading: false,
            isError: false,
            isSuccess: true,
            data: promise,
          });

          return promise;
        }
      },
    [asyncFn]
  );

  useEffect(() => {
    return () => {
      isUnmounted.current = true;
    };
  }, []);

  return [state, callAsyncFn];
}
