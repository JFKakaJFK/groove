import {
  ActionIcon,
  Card,
  Group,
  LoadingOverlay,
  Title,
  ScrollArea,
  Text,
  useMantineTheme,
} from "@mantine/core";
import { useMemo } from "react";
import { FiChevronLeft, FiChevronRight } from "react-icons/fi";
import { useSearchParams } from "react-router-dom";
import {
  AxisLinearOptions,
  AxisTimeOptions,
  Chart,
  UserSerie,
} from "react-charts";
import {
  Completion as CompletionT,
  fmtDate,
  Habit,
  useCompletions,
} from "../api/habit";
import { curveBumpX } from "d3-shape";
import { Completion } from "./completion";
import { ErrorMessage } from "./error-message";
import { YearMonth } from "../utils";

export interface ExtendedCompletion extends CompletionT {
  before: boolean;
  after: boolean;
  streak: number;
  streakLength: number;
}

function CompletionsChart({
  cs,
  habit,
  ym,
}: {
  cs: ExtendedCompletion[];
  habit: Habit;
  ym: YearMonth;
}) {
  const theme = useMantineTheme();
  const data = useMemo<UserSerie<ExtendedCompletion>[]>(
    () => [
      {
        data: cs,
        label: ym.toString(),
        color: habit.color,
      },
    ],
    [cs, ym, habit]
  );

  const primaryAxis = useMemo<AxisTimeOptions<ExtendedCompletion>>(
    () => ({
      scaleType: "localTime",
      getValue(c) {
        return c.date;
      },
      showGrid: false,
      shouldNice: true,
      formatters: {
        scale(d) {
          if (!d) return "";
          return fmtDate(d);
        },
        cursor(d) {
          if (!d) return null;
          return <div>{fmtDate(d)}</div>;
        },
      },
    }),
    []
  );

  const secondaryAxes = useMemo<AxisLinearOptions<ExtendedCompletion>[]>(
    () => [
      {
        scaleType: "linear",
        shouldNice: true,
        curve: curveBumpX,
        hardMin: 0,
        getValue(c) {
          return c.streak;
        },
        formatters: {
          scale(v) {
            return v.toFixed(0);
          },
          tooltip() {
            return <div>Hi there</div>;
          },
          cursor(v) {
            return <div>{v}</div>;
          },
        },
        elementType: "area",
      },
    ],
    []
  );

  return (
    <Card sx={{ position: "relative", flex: 1 }}>
      <Title order={4}>Streak length</Title>
      <LoadingOverlay visible={data.length < 1} />
      <div style={{ width: "100%", height: 260 }}>
        {cs.length > 0 && (
          <Chart
            options={{
              data,
              primaryAxis,
              secondaryAxes,
              tooltip: false,
              dark: theme.colorScheme === "dark",
              getSeriesStyle(series) {
                return {
                  color: `url(#${habit.id})`,
                };
              },
              renderSVG() {
                return (
                  <defs>
                    <linearGradient id={habit.id} x1="0" x2="0" y1="1" y2="0">
                      <stop
                        offset="0%"
                        stopColor={theme.fn.lighten(habit.color, 0.5)}
                      />
                      <stop offset="100%" stopColor={habit.color} />
                    </linearGradient>
                  </defs>
                );
              },
            }}
          />
        )}
      </div>
    </Card>
  );
}

function CompletionsList({
  cs,
  habit,
  ym,
}: {
  cs: ExtendedCompletion[];
  habit: Habit;
  ym: YearMonth;
}) {
  return (
    <ScrollArea>
      <div
        style={{
          display: "grid",
          textAlign: "center",
          gridTemplateColumns: "repeat(7, auto)",
          placeContent: "start",
          placeItems: "center",
          gap: 0,
        }}
      >
        <Text size="xs">Mon</Text>
        <Text size="xs">Tue</Text>
        <Text size="xs">Wed</Text>
        <Text size="xs">Thu</Text>
        <Text size="xs">Fri</Text>
        <Text size="xs">Sat</Text>
        <Text size="xs">Sun</Text>
        {cs.map((c, i, all) => (
          <Completion
            key={c.date.toISOString()}
            habit={habit}
            completion={c}
            size={36}
            ym={ym}
          />
        ))}
      </div>
    </ScrollArea>
  );
}

export function Completions({ habit }: { habit: Habit }) {
  //const habit = useOutletContext<Habit>();
  const [searchParams, setSearchParams] = useSearchParams();
  const ym = new YearMonth(searchParams.get("year"), searchParams.get("month"));

  const completions = useCompletions(habit.id, ym);

  const cs: ExtendedCompletion[] = useMemo(() => {
    if (!Array.isArray(completions.data)) return [];
    const cs = completions.data as ExtendedCompletion[];
    const last = cs.length - 1;
    for (let i = 0; i <= last; i++) {
      cs[i].before = i > 0 && cs[i - 1].completed;
      cs[i].after = i < last && cs[i + 1].completed;
      cs[i].streak = cs[i].completed ? (i > 0 ? cs[i - 1].streak + 1 : 1) : 0;
    }
    cs[last].streakLength = cs[last].streak;
    for (let i = last - 1; i >= 0; i--) {
      cs[i].streakLength = cs[i].completed
        ? Math.max(cs[i].streak, cs[i + 1].streakLength)
        : 0;
    }
    return cs;
  }, [completions.data]);

  return (
    <Group spacing="md" align="stretch" sx={{ justifyContent: "stretch" }}>
      <Card sx={{ position: "relative" }}>
        <LoadingOverlay visible={completions.isLoading} />
        <Group spacing={2} align="center" mb="md">
          <ActionIcon
            onClick={() => {
              setSearchParams(ym.prev.ym);
            }}
          >
            <FiChevronLeft size={16} />
          </ActionIcon>
          <Title order={4}>{ym.toString()}</Title>
          <ActionIcon
            disabled={!ym.hasNext}
            onClick={() => {
              setSearchParams(ym.next.ym);
            }}
          >
            <FiChevronRight size={16} />
          </ActionIcon>
        </Group>

        {completions.isError && <ErrorMessage error={completions.error} />}

        <CompletionsList cs={cs} habit={habit} ym={ym} />
      </Card>

      <CompletionsChart cs={cs} habit={habit} ym={ym} />
    </Group>
  );
}
