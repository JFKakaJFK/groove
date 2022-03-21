import { Button, Center, Divider, Group, Title } from "@mantine/core";
import { Link } from "react-router-dom";

export function PageNotFound() {
  return (
    <Center style={{ flex: 1 }}>
      <div style={{ textAlign: "center" }}>
        <Group>
          <Title order={1}>404</Title>
          <div style={{ alignSelf: "stretch" }}>
            <Divider orientation="vertical" />
          </div>
          <Title order={1}>Page not found</Title>
        </Group>

        <Button component={Link} to="/" mt="md">
          Go Home
        </Button>
      </div>
    </Center>
  );
}
