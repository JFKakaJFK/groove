import { Alert } from "@mantine/core";
import { HTTPError } from "ky";
import { FiAlertCircle } from "react-icons/fi";
import { APIError } from "../api/client";

export function ErrorMessage({ error: e }: { error: unknown }) {
  let title = "Error!";
  let message = "Something went wrong :/";

  if (e instanceof APIError) {
    title = `Error Code ${e.status}`;
    message = e.message;
  } else if (e instanceof HTTPError) {
    title = `Network error`;
    message = e.message;
  } else if (e instanceof Error) {
    message = e.message;
  }

  return (
    <Alert
      icon={<FiAlertCircle size={16} />}
      title={title}
      color="red"
      variant="outline"
    >
      {message}
    </Alert>
  );
}
