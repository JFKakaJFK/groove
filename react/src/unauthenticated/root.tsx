import { Card, Text } from "@mantine/core";
import { Link } from "react-router-dom";

export function Root() {
  return (
    <Card>
      <Text weight={500} size="lg">
        Aaaaaaaa
      </Text>
      <Text size="sm">Aaaaaaaa</Text>

      <Link to="/">Home</Link>
    </Card>
  );
}
