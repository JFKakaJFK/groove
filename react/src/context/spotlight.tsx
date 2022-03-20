import { SpotlightProvider, useSpotlight } from "@mantine/spotlight";
import type { SpotlightAction } from "@mantine/spotlight";
import { ReactNode, useEffect } from "react";
import { FiHome, FiSearch } from "react-icons/fi";
import { useNavigate } from "react-router-dom";
import { useAuth, useLogout } from "../api/auth";
import { Dashboard } from "tabler-icons-react";

export interface SpotlightProps {
  children: ReactNode;
}

type ActionWithId = SpotlightAction & { id: string };

function SpotlightControls() {
  const spotlight = useSpotlight();
  const { isAuthenticated, user } = useAuth();
  const logout = useLogout();
  const navigate = useNavigate();

  const unauthenticatedActions: ActionWithId[] = [
    {
      id: "login",
      group: "Navigation",
      title: "Sign in",
      //description: "Sign ",
      onTrigger: () => navigate("/login"),
      //icon: <FiHome size={18} />,
    },
    {
      id: "register",
      group: "Navigation",
      title: "Sign up",
      //description: "Get to home page",
      onTrigger: () => navigate("/register"),
      //icon: <FiHome size={18} />,
    },
  ];
  const authenticatedActions: ActionWithId[] = [
    {
      id: "logout",
      title: "Logout",
      //description: "Get to home page",
      onTrigger: () => logout.mutate(),
      //icon: <FiHome size={18} />,
    },
  ];
  const premiumActions: ActionWithId[] = [];
  const adminActions: ActionWithId[] = [
    {
      id: "manage",
      group: "Navigation",
      // TODO??
      title: "Dashboard",
      description: "Get full information about current system status",
      onTrigger: () => console.log("Dashboard"),
      icon: <Dashboard size={18} />,
    },
  ];

  useEffect(() => {
    // adjust available spotlight actions
    if (isAuthenticated) {
      spotlight.registerActions(authenticatedActions);
      spotlight.removeActions(unauthenticatedActions.map((a) => a.id));
    } else {
      spotlight.registerActions(unauthenticatedActions);
      spotlight.removeActions(authenticatedActions.map((a) => a.id));
    }
    if (user?.isPremium) {
      spotlight.registerActions(premiumActions);
    } else {
      spotlight.removeActions(premiumActions.map((a) => a.id));
    }
    if (user?.isAdmin) {
      spotlight.registerActions(adminActions);
    } else {
      spotlight.removeActions(adminActions.map((a) => a.id));
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAuthenticated, user]);

  return null;
}

export function Spotlight({ children }: SpotlightProps) {
  const navigate = useNavigate();

  const defaultActions: SpotlightAction[] = [
    {
      group: "Navigation",
      title: "Home",
      description: "Get to home page",
      onTrigger: () => navigate("/"),
      icon: <FiHome size={18} />,
    },
  ];

  return (
    <SpotlightProvider
      actions={defaultActions}
      searchPlaceholder="Search..."
      shortcut={["mod + P", "mod + K", "/"]}
      searchIcon={<FiSearch size={18} />}
      highlightQuery
      nothingFoundMessage="Nothing found..."
    >
      <SpotlightControls />
      {children}
    </SpotlightProvider>
  );
}
