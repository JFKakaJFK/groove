import { Button, Card, Center, Space, Text, Title } from "@mantine/core";
import { Link } from "react-router-dom";

export function Root() {
  return (
    <Center style={{ flex: 1 }}>
      <div style={{ textAlign: "center" }}>
        <Title order={1} mb="md">
          Get in the Groove!
        </Title>
        <Text size="md">
          Hypatia colonies network of wormholes emerged into consciousness
          encyclopaedia galactica shores of the cosmic ocean. Sea of Tranquility
          rich in mystery Vangelis star stuff harvesting star light stirred by
          starlight the sky calls to us?
        </Text>
        <Space h="md" />
        <Button component={Link} to="/register">
          Get started
        </Button>
      </div>
    </Center>
  );
}
