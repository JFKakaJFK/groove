import { Card, Text } from "@mantine/core";
import { Link } from "react-router-dom";

export function Root() {
  return (
    <Card>
      <Text weight={500} size="lg">
        Hi
      </Text>
      <Text size="sm">
        Hello there{" "}
        <Text inherit variant="link" component={Link} to="/a">
          Aaaaa
        </Text>
      </Text>
    </Card>
  );
}
