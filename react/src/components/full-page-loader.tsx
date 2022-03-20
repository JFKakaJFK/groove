import { Center, Loader } from "@mantine/core";

export function FullPageLoader() {
  return (
    <Center style={{ width: "100%", minHeight: "100vh" }}>
      <Loader variant="bars" />
    </Center>
  );
}
