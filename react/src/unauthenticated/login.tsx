import {
  Alert,
  Button,
  Card,
  Checkbox,
  Group,
  PasswordInput,
  TextInput,
} from "@mantine/core";
import { useForm, zodResolver } from "@mantine/form";
import { FiAlertCircle } from "react-icons/fi";
import { useLocation, useNavigate } from "react-router-dom";
import { z } from "zod";
import { useLogin } from "../api/auth";

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
    <Card sx={{ maxWidth: 340 }} mx="auto">
      {isError && error instanceof Error && (
        <Alert icon={<FiAlertCircle size={16} />} title="Error!" color="red">
          {error?.message}
        </Alert>
      )}

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
          description="Password must include at least one letter, number and special character"
          required
          mt="sm"
          {...form.getInputProps("password")}
        />

        <Checkbox label="Remember me" {...form.getInputProps("stayLoggedIn")} />

        <Group position="right" mt="xl">
          <Button type="submit" loading={isLoading}>
            Submit
          </Button>
        </Group>
      </form>
    </Card>
  );
}
