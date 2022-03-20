import {
  MantineProvider,
  ColorSchemeProvider,
  ColorScheme,
} from "@mantine/core";
import { useHotkeys, useLocalStorageValue } from "@mantine/hooks";
import { useColorScheme } from "@mantine/hooks";
import { ReactNode } from "react";

import { Spotlight } from "./spotlight";

/**
 * Provides color theme, persistent wrapper around mantine provider
 * @returns
 */
export function ThemeProvider({ children }: { children: ReactNode }) {
  const preferredColorScheme = useColorScheme();
  const [colorScheme, setColorScheme] = useLocalStorageValue<ColorScheme>({
    key: "mantine-color-scheme",
    defaultValue: preferredColorScheme,
  });

  const toggleColorScheme = (value?: ColorScheme) =>
    setColorScheme(value || (colorScheme === "dark" ? "light" : "dark"));

  useHotkeys([["mod+J", () => toggleColorScheme()]]);

  return (
    <ColorSchemeProvider
      colorScheme={colorScheme}
      toggleColorScheme={toggleColorScheme}
    >
      <MantineProvider theme={{ colorScheme }} withGlobalStyles>
        <Spotlight>{children}</Spotlight>
      </MantineProvider>
    </ColorSchemeProvider>
  );
}
