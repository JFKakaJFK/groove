import React, { Suspense } from "react";
import ReactDOM from "react-dom";
import { QueryClientProvider } from "react-query";
import { BrowserRouter } from "react-router-dom";
import { ReactQueryDevtools } from "react-query/devtools";

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
