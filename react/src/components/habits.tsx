import {
  RingProgress,
  Card,
  Group,
  Skeleton,
  Text,
  Title,
  ScrollArea,
  Table,
  ThemeIcon,
  ActionIcon,
  UnstyledButton,
} from "@mantine/core";
import { SyntheticEvent } from "react";
import { FiCheckCircle, FiCircle } from "react-icons/fi";
import { useNavigate } from "react-router-dom";
import { Habit, useCompletion, useHabit, useHabits } from "../api/habit";
import { ErrorMessage } from "./error-message";
import { CreateHabit } from "./create-habit";

function HabitRow({ habit }: { habit: Habit }) {
  const { data } = useHabit(habit.id, {
    initialData: habit,
    refetchOnMount: false,
  });
  const navigate = useNavigate();
  const today = useCompletion({ habit: habit.id, date: new Date() });

  const h = data ?? habit;

  return (
    <tr
      onClick={(e) => navigate(`/habits/${habit.id}`)}
      style={{ cursor: "pointer" }}
    >
      <td>
        <Group spacing="sm">
          <ThemeIcon radius="xl" size="md" style={{ backgroundColor: h.color }}>
            {/* <FiBarChart2 size={16} /> */}
          </ThemeIcon>
          <div>
            <Text size="lg" weight={700} sx={{ fontSize: 16, lineHeight: 1 }}>
              {h.name}
            </Text>
            <Text size="xs" color="dimmed">
              {h.description}
            </Text>
          </div>
        </Group>
      </td>

      <td>
        <Text
          align="center"
          size="lg"
          weight={700}
          sx={{ fontSize: 16, lineHeight: 1 }}
        >
          {h.info.current}
        </Text>
        <Text size="xs" color="dimmed" align="center">
          Active streak
        </Text>
      </td>

      <td>
        <Text
          align="center"
          size="lg"
          weight={700}
          sx={{ fontSize: 16, lineHeight: 1 }}
        >
          {h.info.longest}
        </Text>
        <Text size="xs" color="dimmed" align="center">
          Longest streak
        </Text>
      </td>

      <td>
        <Group spacing="xs">
          <RingProgress
            roundCaps
            thickness={4}
            size={42}
            sections={[{ value: h.info.completionRate, color: h.color }]}
          />
          <div>
            <Text
              align="center"
              size="lg"
              weight={700}
              sx={{ fontSize: 16, lineHeight: 1 }}
            >
              {h.info.completionRate}%
            </Text>
            <Text align="center" size="xs" color="dimmed">
              Completed
            </Text>
          </div>
        </Group>
      </td>

      <td>
        <UnstyledButton
          onClick={(e: SyntheticEvent) => {
            today.mutate();
            e.stopPropagation();
          }}
          disabled={today.isLoading}
        >
          <Group spacing="xs">
            <ActionIcon
              component="div"
              radius="xl"
              size="md"
              style={{ backgroundColor: h.color }}
              variant="filled"
              loading={today.isLoading}
            >
              {today.data?.completed ? (
                <FiCheckCircle size={16} />
              ) : (
                <FiCircle size={16} />
              )}
            </ActionIcon>
            <div>
              <Text
                align="center"
                size="lg"
                weight={700}
                sx={{ fontSize: 16, lineHeight: 1 }}
              >
                {""}
              </Text>
              <Text align="center" size="xs" color="dimmed">
                Today
              </Text>
            </div>
          </Group>
        </UnstyledButton>
      </td>
    </tr>
  );
}

function HabitList({ habits }: { habits: Habit[] }) {
  return (
    <ScrollArea>
      <Table sx={{ minWidth: 512 }} verticalSpacing="sm" highlightOnHover>
        <thead>
          <tr>
            <th>Habit</th>
            <th>Active streak</th>
            <th>Longest streak</th>
            <th>Completion rate</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {habits.map((h) => (
            <HabitRow key={h.id} habit={h} />
          ))}
        </tbody>
      </Table>
    </ScrollArea>
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

  return (
    <Card>
      <Group position="apart" spacing="md">
        <Title order={2}>Habits</Title>
        <CreateHabit />
      </Group>

      {isError && <ErrorMessage error={error} />}

      {isLoading || !habits ? (
        <HabitSkeletonList />
      ) : (
        <HabitList habits={habits} />
      )}
    </Card>
  );
}
