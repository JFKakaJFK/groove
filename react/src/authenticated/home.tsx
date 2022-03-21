import { Card, Text } from "@mantine/core";
import { Link } from "react-router-dom";
import { useAuth } from "../api/auth";

export function Home() {
  const { user } = useAuth();

  return (
    <Card>
      <Text weight={500} size="lg">
        Hello {user?.name}
      </Text>
      <Text size="sm">You are authenticated</Text>

      <Link to="/habits">Habits</Link>
    </Card>
  );
}
