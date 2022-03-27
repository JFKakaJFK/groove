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
import { useNavigate } from "react-router-dom";
import { z } from "zod";
import { useRegister } from "../api/auth";
import { ErrorMessage } from "../components/error-message";

const schema = z
  .object({
    email: z.string().email({ message: "Invalid email" }),
    name: z.string().nonempty("Required"),
    password: z.string().nonempty("Required"),
    repeatPassword: z.string(),
    newsletter: z.boolean(),
  })
  .refine((data) => data.password === data.repeatPassword, {
    message: "Passwords don't match",
    path: ["repeatPassword"],
  });

export function Register() {
  const navigate = useNavigate();

  const { isLoading, isError, error, mutate: register } = useRegister();

  const form = useForm({
    initialValues: {
      email: "",
      name: "",
      password: "",
      repeatPassword: "",
      newsletter: true,
    },
    schema: zodResolver(schema),
  });

  return (
    <Center style={{ flex: 1 }}>
      <Card sx={{ maxWidth: 340 }} mx="auto">
        <Text weight={500} size="lg" mb="sm">
          Sign up
        </Text>

        {isError && <ErrorMessage error={error} />}

        <form
          onSubmit={form.onSubmit((data) =>
            register(data, {
              onSuccess() {
                navigate("/");
              },
            })
          )}
        >
          <TextInput
            required
            label="Name"
            placeholder="John Doe"
            {...form.getInputProps("name")}
          />
          <TextInput
            required
            label="Email"
            placeholder="doe@mail.com"
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
          <PasswordInput
            label="Repeat Password"
            required
            mt="sm"
            {...form.getInputProps("repeatPassword")}
          />

          <Space h="xs" />

          <Checkbox
            label="Subscribe to the newsletter"
            size="xs"
            {...form.getInputProps("newsletter")}
          />

          <Group position="right" mt="xl">
            <Button type="submit" loading={isLoading}>
              Sign up
            </Button>
          </Group>
        </form>
      </Card>
    </Center>
  );
}
