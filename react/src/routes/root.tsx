import {
  Box,
  Button,
  Card,
  Checkbox,
  Group,
  PasswordInput,
  Text,
  TextInput,
} from "@mantine/core";
import { useForm, zodResolver } from "@mantine/form";
import ky from "ky";
import { useMutation } from "react-query";
import { Link } from "react-router-dom";
import { z } from "zod";
import { api } from "../api/client";

export interface LoginRequest {
  email: string;
  password: string;
  stayLoggedIn?: boolean;
}

export interface APIError {
  status: number;
  msg: string;
}

export interface APIResponse {
  error: [APIError];
}

export interface LoginResponse extends APIResponse {
  data?: {
    id: string;
  };
}

function restoreAPIErrors<T extends APIResponse>(res: T) {
  if (res.error?.length > 0) {
    throw new Error(res.error[0]?.msg);
  }
}

async function loginReq(req: LoginRequest): Promise<LoginResponse> {
  const res = (await api.post("/login", { json: req }).json()) as LoginResponse;
  restoreAPIErrors(res);
  return res;
}

const schema = z.object({
  email: z.string().email({ message: "Invalid email" }),
  password: z.string().nonempty("Required"),
  stayLoggedIn: z.boolean(),
});

function Login() {
  const login = useMutation(loginReq);

  const form = useForm({
    initialValues: {
      email: "",
      password: "",
      stayLoggedIn: true,
    },
    schema: zodResolver(schema),
  });

  function handleSubmit(values: LoginRequest) {
    console.log(values);
    login.mutate(values);
  }

  if (login.isLoading) {
    return <div>loading ...</div>;
  }

  // if (login.isError) {
  //   return <div>{login.error.message}</div>;
  // }

  if (login.isSuccess) {
    return <div>success??</div>;
  }

  return (
    <Box sx={{ maxWidth: 340 }} mx="auto">
      <form onSubmit={form.onSubmit(handleSubmit)}>
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
          <Button type="submit">Submit</Button>
        </Group>
      </form>
    </Box>
  );
}

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

      <Login />
    </Card>
  );
}
