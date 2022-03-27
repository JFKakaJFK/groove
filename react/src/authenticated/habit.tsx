import {
  Card,
  Group,
  RingProgress,
  SimpleGrid,
  Skeleton,
  Text,
  Title,
} from "@mantine/core";
import { useNavigate, useParams } from "react-router-dom";
import { APIError } from "../api/client";
import { Habit as HabitT, useHabit } from "../api/habit";
import { DeleteHabit } from "../components/delete-habit";
import { EditHabit } from "../components/edit-habit";
import { ErrorMessage } from "../components/error-message";
import { Completions } from "../components/completions";

function HabitMeta({ habit }: { habit: HabitT }) {
  return (
    <Card>
      <Group position="apart" spacing="md">
        <div>
          <Title order={2}>{habit.name}</Title>
          <Text size="sm" color="dimmed">
            {habit.description}
          </Text>
        </div>

        <Group spacing="xs">
          <EditHabit habit={habit} />
          <DeleteHabit habit={habit} to="/" />
        </Group>
      </Group>
    </Card>
  );
}

function HabitStats({ habit }: { habit: HabitT }) {
  return (
    <SimpleGrid spacing="md" cols={3}>
      <Card>
        <div>
          <Text
            align="center"
            size="lg"
            weight={700}
            sx={{ fontSize: 16, lineHeight: 1 }}
          >
            {habit.info.current}
          </Text>
          <Text size="xs" color="dimmed" align="center">
            Active streak
          </Text>
        </div>
      </Card>
      <Card>
        <div>
          <Text
            align="center"
            size="lg"
            weight={700}
            sx={{ fontSize: 16, lineHeight: 1 }}
          >
            {habit.info.longest}
          </Text>
          <Text size="xs" color="dimmed" align="center">
            Longest streak
          </Text>
        </div>
      </Card>
      <Card>
        <Group spacing="xs" position="center">
          {/* //TODO stats in three separate boxes below? */}
          <RingProgress
            roundCaps
            thickness={4}
            size={42}
            sections={[
              {
                value: habit.info.completionRate,
                color: habit.color,
              },
            ]}
          />
          <div>
            <Text
              align="center"
              size="lg"
              weight={700}
              sx={{ fontSize: 16, lineHeight: 1 }}
            >
              {habit.info.completionRate}%
            </Text>
            <Text align="center" size="xs" color="dimmed">
              Completed
            </Text>
          </div>
        </Group>
      </Card>
    </SimpleGrid>
  );
}

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

  return habit ? (
    <>
      <HabitMeta habit={habit} />
      <HabitStats habit={habit} />
      {/* <Outlet context={habit} /> */}
      <Completions habit={habit} />
    </>
  ) : null;
}
