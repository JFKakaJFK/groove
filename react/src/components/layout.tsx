import {
  Header,
  Text,
  Code,
  Group,
  useMantineColorScheme,
  Center,
  Menu,
  Container,
  Button,
  Image,
} from "@mantine/core";
import { useOs } from "@mantine/hooks";
import { useSpotlight } from "@mantine/spotlight";
import {
  FiSearch,
  FiSun,
  FiMoon,
  FiHome,
  FiLogOut,
  FiUsers,
} from "react-icons/fi";
import { Link, Outlet, useNavigate } from "react-router-dom";
import { GhostButton } from "./ghost-btn";
import { DotsVertical } from "tabler-icons-react";
import { useAuth, useLogout } from "../api/auth";

import logoLight from "../assets/logoLight.png";
import logoDark from "../assets/logoDark.png";

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
        <Button component={Link} to="/login" variant="outline">
          Sign in
        </Button>
        <Button component={Link} to="/register">
          Sign up
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
      <Menu.Label>Application</Menu.Label>
      <Menu.Item component={Link} to="/" icon={<FiHome size={14} />}>
        Home
      </Menu.Item>
      {user?.isAdmin && (
        <Menu.Item component={Link} to="/users" icon={<FiUsers size={14} />}>
          Manage Users
        </Menu.Item>
      )}

      <Menu.Label>Other</Menu.Label>
      <Menu.Item
        icon={<FiLogOut size={14} />}
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
  const { colorScheme } = useMantineColorScheme();
  const dark = colorScheme === "dark";

  return (
    <div
      style={{ minHeight: "100vh", display: "flex", flexDirection: "column" }}
    >
      <Header
        height={64}
        px="md"
        style={{ position: "sticky", left: 0, right: 0, top: 0 }}
      >
        <div
          style={{
            display: "flex",
            alignItems: "center",
            height: "100%",
            justifyContent: "space-between",
            flexWrap: "wrap",
          }}
        >
          <Link to="/">
            <Image src={dark ? logoDark : logoLight} height={32} />
          </Link>

          <Group spacing="sm">
            <SpotlightInput />
            <ThemeToggle />
            <Navigation />
          </Group>
        </div>
      </Header>

      <Container
        py="md"
        style={{
          width: "100%",
          flex: 1,
          display: "flex",
          flexDirection: "column",
        }}
      >
        <Group
          direction="column"
          spacing="md"
          style={{ alignItems: "stretch", justifyContent: "center", flex: 1 }}
        >
          <Outlet />
        </Group>
      </Container>
    </div>
  );
}
