import {
  Header,
  Text,
  Code,
  Group,
  useMantineColorScheme,
  Center,
  Menu,
  Space,
  Container,
  Button,
} from "@mantine/core";
import { useOs } from "@mantine/hooks";
import { useSpotlight } from "@mantine/spotlight";
import { FiSearch, FiSun, FiMoon } from "react-icons/fi";
import { Link, Outlet, useNavigate } from "react-router-dom";
import { GhostButton } from "./ghost-btn";
import { DotsVertical } from "tabler-icons-react";
import { useAuth, useLogout } from "../api/auth";

function SpotlightInput() {
  const spotlight = useSpotlight();
  const os = useOs();

  return (
    <GhostButton onClick={spotlight.openSpotlight}>
      <Group spacing="xs" color={"dimmed"} pl={3}>
        <FiSearch size={14} />
        <Text color="dimmed" pr={80} size="sm">
          Search
        </Text>
        <Code>{os.endsWith("os") ? "⌘" : "CTRL"} + K</Code>
      </Group>
    </GhostButton>
  );
}

function ThemeToggle() {
  const { colorScheme, toggleColorScheme } = useMantineColorScheme();
  const dark = colorScheme === "dark";

  return (
    <GhostButton
      title="Toggle color scheme"
      onClick={() => toggleColorScheme()}
    >
      <Center p={3}>{dark ? <FiSun size={16} /> : <FiMoon size={16} />}</Center>
    </GhostButton>
  );
}

function Navigation() {
  const navigate = useNavigate();
  const { isAuthenticated, user } = useAuth();
  const { mutate: logout } = useLogout();

  if (!isAuthenticated) {
    return (
      <>
        <Button component={Link} to="/login">
          Login
        </Button>
      </>
    );
  }

  return (
    <Menu
      control={
        <GhostButton>
          <Center p={3}>
            <DotsVertical size={16} />
          </Center>
        </GhostButton>
      }
    >
      <Menu.Item component={Link} to="/">
        Home
      </Menu.Item>

      <Menu.Item
        onClick={() =>
          logout(undefined, {
            onSuccess() {
              navigate("/");
            },
          })
        }
      >
        Logout
      </Menu.Item>
    </Menu>
  );
}

export function Layout() {
  return (
    <>
      <Header height={64}>
        <div
          style={{
            display: "flex",
            alignItems: "center",
            height: "100%",
            justifyContent: "space-between",
            flexWrap: "wrap",
          }}
        >
          <div>Logo</div>
          <Group spacing="sm">
            <SpotlightInput />
            <ThemeToggle />
            <Navigation />
          </Group>
        </div>
      </Header>
      <Space h="md" />
      <Container>
        <Outlet />
      </Container>
      <Space h="md" />
    </>
  );
}
