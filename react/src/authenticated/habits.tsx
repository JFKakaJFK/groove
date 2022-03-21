import { Card, Group, Skeleton, Text, Title } from "@mantine/core";
import { Link } from "react-router-dom";
import { Habit, useHabits } from "../api/habit";
import { ErrorMessage } from "../components/error-message";

function HabitItem({ habit }: { habit: Habit }) {
  return (
    <Link to={`/habits/${habit.id}`}>
      <Group>
        <div>
          <Text weight={500} size="lg">
            {habit?.name}
          </Text>
          <Text size="sm">{habit?.description}</Text>
        </div>
        {/* TODO stats? */}
      </Group>
    </Link>
  );
}

function HabitList({ habits }: { habits: Habit[] }) {
  return (
    <Group direction="column" mt="md">
      {habits.map((h) => (
        <HabitItem key={h.id} habit={h} />
      ))}
    </Group>
  );
}

function randInt(a: number, b?: number) {
  let [min, max] = b === undefined ? [0, a] : [a, b];
  return min + Math.round(Math.random() * Math.max(max - min, 0));
}

function HabitSkeleton() {
  return (
    <div style={{ width: "100%" }}>
      <Skeleton height={16} width={`${randInt(25, 45)}%`} radius="xl" />
      <Skeleton height={8} mt={16} radius="xl" />
      <Skeleton height={8} mt={8} radius="xl" />
      <Skeleton height={8} mt={8} width={`${randInt(30, 70)}%`} radius="xl" />
    </div>
  );
}

function HabitSkeletonList() {
  return (
    <Group direction="column" spacing="xl" mt="md">
      <HabitSkeleton />
      <HabitSkeleton />
      <HabitSkeleton />
    </Group>
  );
}

export function Habits() {
  const { isLoading, isError, error, data: habits } = useHabits();

  // TODO create habit

  return (
    <Card>
      <Title order={2}>Habits</Title>

      {isError && <ErrorMessage error={error} />}

      {isLoading || !habits ? (
        <HabitSkeletonList />
      ) : (
        <HabitList habits={habits} />
      )}
    </Card>
  );
}
