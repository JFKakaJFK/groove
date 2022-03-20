import { Card, Text } from "@mantine/core";
import { Link } from "react-router-dom";
import { useAuth } from "../api/auth";

export function Root() {
  const { user } = useAuth();

  return (
    <Card>
      <Text weight={500} size="lg">
        Hello {user?.name}
      </Text>
      <Text size="sm">Root auth</Text>

      <Link to="/">Home</Link>
    </Card>
  );
}
