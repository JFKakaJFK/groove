import {
  Alert,
  Button,
  Card,
  Center,
  Checkbox,
  Group,
  PasswordInput,
  Space,
  Text,
  TextInput,
} from "@mantine/core";
import { useForm, zodResolver } from "@mantine/form";
import { FiAlertCircle } from "react-icons/fi";
import { useLocation, useNavigate } from "react-router-dom";
import { z } from "zod";
import { useLogin } from "../api/auth";
import { ErrorMessage } from "../components/error-message";

const schema = z.object({
  email: z.string().email({ message: "Invalid email" }),
  password: z.string().nonempty("Required"),
  stayLoggedIn: z.boolean(),
});

export function Login() {
  const navigate = useNavigate();
  const location = useLocation();

  let from = (location.state as { from?: Location })?.from?.pathname || "/";

  const { isLoading, isError, error, mutate: login } = useLogin();

  const form = useForm({
    initialValues: {
      email: "",
      password: "",
      stayLoggedIn: true,
    },
    schema: zodResolver(schema),
  });

  return (
    <Center style={{ flex: 1 }}>
      <Card sx={{ maxWidth: 340 }} mx="auto">
        <Text weight={500} size="lg" mb="sm">
          Sign in
        </Text>

        {isError && <ErrorMessage error={error} />}

        <form
          onSubmit={form.onSubmit((creds) =>
            login(creds, {
              onSuccess() {
                navigate(from, { replace: true });
              },
            })
          )}
        >
          <TextInput
            required
            label="Email"
            placeholder="example@mail.com"
            {...form.getInputProps("email")}
          />
          <PasswordInput
            placeholder="Password"
            label="Password"
            description="For development purposes no password rules are enforced"
            required
            mt="sm"
            {...form.getInputProps("password")}
          />

          <Space h="xs" />

          <Checkbox
            label="Remember me"
            size="xs"
            {...form.getInputProps("stayLoggedIn")}
          />

          <Group position="right" mt="xl">
            <Button type="submit" loading={isLoading}>
              Sign in
            </Button>
          </Group>
        </form>
      </Card>
    </Center>
  );
}
