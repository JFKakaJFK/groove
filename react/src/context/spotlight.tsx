import { SpotlightProvider } from "@mantine/spotlight";
import type { SpotlightAction } from "@mantine/spotlight";
import { ReactNode } from "react";
import { FiSearch } from "react-icons/fi";

const actions: SpotlightAction[] = [
  {
    title: "Home",
    description: "Get to home page",
    onTrigger: () => console.log("Home"),
    //icon: <Home size={18} />,
  },
  {
    title: "Dashboard",
    description: "Get full information about current system status",
    onTrigger: () => console.log("Dashboard"),
    //icon: <Dashboard size={18} />,
  },
  {
    title: "Documentation",
    description: "Visit documentation to lean more about all features",
    onTrigger: () => console.log("Documentation"),
    //icon: <FileText size={18} />,
  },
];

export interface SpotlightProps {
  children: ReactNode;
}

export function Spotlight({ children }: SpotlightProps) {
  return (
    <SpotlightProvider
      actions={actions}
      searchPlaceholder="Search..."
      shortcut={["ctrl + k", "meta + k"]}
      searchIcon={<FiSearch size={18} />}
      nothingFoundMessage="Nothing found..."
    >
      {children}
    </SpotlightProvider>
  );
}
