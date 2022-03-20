import { Navigate, useLocation } from "react-router-dom";
import { useAuth } from "../api/auth";

export function Authenticated({ children }: { children: JSX.Element }) {
  const { isAuthenticated } = useAuth();
  let location = useLocation();

  if (!isAuthenticated) {
    // Redirect unauthenticated users to the /login page
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  return children;
}

type AdminOrPremium =
  | {
      admin: true;
    }
  | {
      premium: true;
    };
export type AuthorizedProps = AdminOrPremium & {
  children: JSX.Element;
};

export function Authorized({ children, ...props }: AuthorizedProps) {
  const { isAuthenticated, user } = useAuth();
  let location = useLocation();

  if (!isAuthenticated) {
    // Redirect unauthenticated users to the /login page
    return <Navigate to="/login" state={{ from: location }} replace />;
  } else if (
    (props.hasOwnProperty("admin") && !user?.isAdmin) ||
    (props.hasOwnProperty("premium") && !user?.isPremium)
  ) {
    return <Navigate to="/" replace />;
  }

  return children;
}
