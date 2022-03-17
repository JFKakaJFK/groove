import React from "react";
import ReactDOM from "react-dom";
import { QueryClientProvider } from "react-query";
import { BrowserRouter } from "react-router-dom";
import { ReactQueryDevtools } from "react-query/devtools";

import * as serviceWorkerRegistration from "./serviceWorkerRegistration";
import App from "./app";
import { ThemeProvider } from "./context/theme";
import { queryClient } from "./api/client";

ReactDOM.render(
  <React.StrictMode>
    <BrowserRouter>
      <QueryClientProvider client={queryClient}>
        <ThemeProvider>
          <App />
        </ThemeProvider>
        <ReactQueryDevtools initialIsOpen={false} />
      </QueryClientProvider>
    </BrowserRouter>
  </React.StrictMode>,
  document.getElementById("root")
);

// Learn more about service workers: https://cra.link/PWA
serviceWorkerRegistration.unregister();
