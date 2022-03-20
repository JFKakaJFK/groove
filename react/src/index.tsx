import React, { Suspense } from "react";
import ReactDOM from "react-dom";
import { QueryClientProvider } from "react-query";
import { BrowserRouter } from "react-router-dom";
import { ReactQueryDevtools } from "react-query/devtools";
import { Global } from "@mantine/core";

import * as serviceWorkerRegistration from "./serviceWorkerRegistration";
import App from "./app";
import { ThemeProvider } from "./context/theme";
import { queryClient } from "./api/client";
import { FullPageLoader } from "./components/full-page-loader";
import { AuthProvider } from "./api/auth";

ReactDOM.render(
  <React.StrictMode>
    <BrowserRouter>
      <QueryClientProvider client={queryClient}>
        <AuthProvider>
          <ThemeProvider>
            <Global
              styles={(theme) => ({
                "*, *::before, *::after": {
                  boxSizing: "border-box",
                },
                body: {
                  margin: 0,
                  ...theme.fn.fontStyles(),
                  backgroundColor:
                    theme.colorScheme === "dark"
                      ? theme.colors.dark[7]
                      : theme.colors.gray[1],
                  color:
                    theme.colorScheme === "dark"
                      ? theme.colors.dark[0]
                      : theme.black,
                  lineHeight: theme.lineHeight,
                },
              })}
            />
            <Suspense fallback={<FullPageLoader />}>
              <App />
            </Suspense>
          </ThemeProvider>
        </AuthProvider>
        <ReactQueryDevtools initialIsOpen={false} />
      </QueryClientProvider>
    </BrowserRouter>
  </React.StrictMode>,
  document.getElementById("root")
);

// Learn more about service workers: https://cra.link/PWA
serviceWorkerRegistration.unregister();
