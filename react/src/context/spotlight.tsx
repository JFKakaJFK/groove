import { SpotlightProvider, useSpotlight } from "@mantine/spotlight";
import type { SpotlightAction } from "@mantine/spotlight";
import { ReactNode, useEffect, useRef } from "react";
import {
  FiBarChart2,
  FiHome,
  FiList,
  FiLogIn,
  FiLogOut,
  FiSearch,
} from "react-icons/fi";
import { useNavigate } from "react-router-dom";
import { useAuth, useLogout } from "../api/auth";
import { Dashboard } from "tabler-icons-react";
import { useHabits } from "../api/habit";

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
      description: "Go to the sign in page",
      onTrigger: () => navigate("/login"),
      icon: <FiLogIn size={18} />,
    },
    {
      id: "register",
      group: "Navigation",
      title: "Sign up",
      description: "Go to the sign up page",
      onTrigger: () => navigate("/register"),
      icon: <FiLogIn size={18} />,
    },
  ];
  const authenticatedActions: ActionWithId[] = [
    {
      id: "habits",
      group: "Navigation",
      title: "Habits",
      description: "Go to the habit page",
      onTrigger: () => navigate("/habits"),
      icon: <FiList size={18} />,
    },
    {
      id: "logout",
      group: "other",
      title: "Logout",
      //description: "Get to home page",
      onTrigger: () => logout.mutate(),
      icon: <FiLogOut size={18} />,
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

function SpotlightHabits() {
  const spotlight = useSpotlight();
  const navigate = useNavigate();
  const { isAuthenticated } = useAuth();
  const habits = useHabits({ enabled: isAuthenticated });
  const habitIdsRef = useRef<string[]>([]);

  useEffect(() => {
    if (Array.isArray(habits.data)) {
      spotlight.removeActions(habitIdsRef.current);
      spotlight.registerActions(
        habits.data.map<ActionWithId>((h) => ({
          id: h.id,
          group: "Habits",
          title: h.name,
          description: h.description,
          onTrigger: () => navigate(`/habits/${h.id}`),
          icon: <FiBarChart2 size={18} style={{ color: h.color }} />,
        }))
      );
      habitIdsRef.current = habits.data.map((h) => h.id);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [habits.data]);

  useEffect(() => {
    if (!isAuthenticated) {
      spotlight.removeActions(habitIdsRef.current);
      habitIdsRef.current = [];
      habits.remove();
    } else {
      habits.refetch();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAuthenticated]);

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
      <SpotlightHabits />
      {children}
    </SpotlightProvider>
  );
}
