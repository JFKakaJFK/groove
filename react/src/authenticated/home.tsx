import { Button, Card, Group, Text } from "@mantine/core";
import { Link } from "react-router-dom";
import { useAuth } from "../api/auth";
import { Habits } from "../components/habits";

export function Home() {
  const { user } = useAuth();

  return (
    <>
      {user?.isAdmin && (
        <Card>
          <Group spacing="md" position="apart">
            <Text weight={500} size="lg">
              Hello {user?.name}
            </Text>
            <Button component={Link} to="/users">
              Manage Users
            </Button>
          </Group>
        </Card>
      )}

      <Habits />
    </>
  );
}
