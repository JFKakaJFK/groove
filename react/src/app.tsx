import { lazy } from "react";
import { useAuth } from "./api/auth";

// So this time I tried doing something along the lines of this article
// https://kentcdodds.com/blog/authentication-in-react-applications
const AuthenticatedApp = lazy(() => import("./authenticated"));
const UnauthenticatedApp = lazy(() => import("./unauthenticated"));

function App() {
  const { isAuthenticated } = useAuth();

  return isAuthenticated ? <AuthenticatedApp /> : <UnauthenticatedApp />;
}

export default App;
