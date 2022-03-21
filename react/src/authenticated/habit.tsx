import { Anchor, Breadcrumbs, Card, Skeleton, Text } from "@mantine/core";
import { Link, useNavigate, useParams } from "react-router-dom";
import { APIError } from "../api/client";
import { useHabit } from "../api/habit";
import { ErrorMessage } from "../components/error-message";

export function Habit() {
  const navigate = useNavigate();
  const params = useParams();
  const {
    isLoading,
    isError,
    error,
    data: habit,
  } = useHabit(params?.habitId ?? "", {
    retry: (count, err) =>
      (!(err instanceof APIError) ||
        ![403, 404].includes((err as APIError).status)) &&
      count < 2,
    onError(err) {
      if (
        err instanceof APIError &&
        (err.status === 404 || err.status === 403)
      ) {
        navigate(`/${err.status}`);
      }
    },
  });

  if (isLoading) {
    <Card>
      <Skeleton />
      <Skeleton />
      <Skeleton />
    </Card>;
  }

  if (isError) {
    <Card>
      <ErrorMessage error={error} />
    </Card>;
  }

  // TODO update habit

  return (
    <Card>
      <Text weight={500} size="lg">
        {habit?.name}
      </Text>
      <Text size="sm">{habit?.description}</Text>
    </Card>
  );
}
