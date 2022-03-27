import { UnstyledButton, useMantineTheme } from "@mantine/core";
import { ReactNode, SVGProps } from "react";
import { Habit, useSetCompleted } from "../api/habit";
import { ExtendedCompletion } from "./completions";
import { YearMonth } from "../utils";

interface IconProps extends SVGProps<SVGSVGElement> {
  size: number;
  children?: ReactNode;
}

const Single = ({ size, children, ...props }: IconProps) => (
  <svg
    width={size}
    height={size}
    viewBox="0 0 32 32"
    fill="currentColor"
    {...props}
  >
    {children}
    <path d="M28 16C28 22.6274 22.6274 28 16 28C9.37258 28 4 22.6274 4 16C4 9.37258 9.37258 4 16 4C22.6274 4 28 9.37258 28 16Z" />
  </svg>
);

const Start = ({ size, children, ...props }: IconProps) => (
  <svg
    width={size}
    height={size}
    viewBox="0 0 32 32"
    fill="currentColor"
    {...props}
  >
    {children}
    <path d="M7 24C9.55328 26.8765 13 28 16 28C19 28 22 27 25 24C28 21 30 20 32 20V12C30 12 28 11 25 8C22 5 19 4 16 4C13 4 9.55328 5.12352 7 8C4.785 10.4954 4 14 4 16C4 18 4.785 21.5046 7 24Z" />
  </svg>
);

const Middle = ({ size, children, ...props }: IconProps) => (
  <svg
    width={size}
    height={size}
    viewBox="0 0 32 32"
    fill="currentColor"
    {...props}
  >
    {children}
    <path d="M25 8C22 5 19 4 16 4C13 4 10 5 7 8C4 11 2 12 0 12V20C2 20 4 21 7 24C10 27 13 28 16 28C19 28 22 27 25 24C28 21 30 20 32 20V12C30 12 28 11 25 8Z" />
  </svg>
);

const End = ({ size, children, ...props }: IconProps) => (
  <svg
    width={size}
    height={size}
    viewBox="0 0 32 32"
    fill="currentColor"
    {...props}
  >
    {children}
    <path d="M25 8C22.4467 5.12352 19 4 16 4C13 4 10 5 7 8C4 11 2 12 0 12V20C2 20 4 21 7 24C10 27 13 28 16 28C19 28 22.4467 26.8765 25 24C27.215 21.5046 28 18 28 16C28 14 27.215 10.4954 25 8Z" />
  </svg>
);

export interface CompletionProps {
  habit: Habit;
  completion: ExtendedCompletion;
  ym: YearMonth;
  size?: number;
}

export function Completion({
  completion,
  habit,
  ym,
  ...props
}: CompletionProps) {
  const theme = useMantineTheme();
  const setCompleted = useSetCompleted();
  const { size = 24 } = props;
  const { date, completed, before, after, streak, streakLength } = completion;
  const { id, color } = habit;

  const gid = date.toISOString().replace(" ", "-");

  const grad = (
    <defs>
      <linearGradient id={gid}>
        <stop
          offset="0%"
          stopColor={
            streak <= 5
              ? theme.fn.rgba(
                  color,
                  0.5 + (0.5 * (streak - 1)) / Math.min(streakLength, 5)
                )
              : color
          }
        />
        <stop
          offset="100%"
          stopColor={
            streak <= 5
              ? theme.fn.rgba(
                  color,
                  0.5 + (0.5 * streak) / Math.min(streakLength, 5)
                )
              : color
          }
        />
      </linearGradient>
    </defs>
  );

  const today = new Date();

  return (
    <UnstyledButton
      title={date.toDateString()}
      disabled={date > today || setCompleted.isLoading}
      onClick={() => {
        setCompleted.mutate({
          date,
          habit: id,
          completed: !completed,
        });
      }}
      sx={(theme) => ({
        "&:first-of-type": {
          gridColumnStart: 1 + ym.offset,
        },
        opacity: date <= today ? (completed ? 1 : 0.25) : 0.1,
        cursor: date > new Date() ? "not-allowed" : "cursor",
      })}
    >
      {completed ? (
        before && date.getDay() !== 1 ? (
          after && date.getDay() !== 0 ? (
            <Middle size={size} fill={`url(#${gid})`}>
              {grad}
            </Middle>
          ) : (
            <End size={size} fill={`url(#${gid})`}>
              {grad}
            </End>
          )
        ) : after && date.getDay() !== 0 ? (
          <Start size={size} fill={`url(#${gid})`}>
            {grad}
          </Start>
        ) : (
          <Single size={size} fill={`url(#${gid})`}>
            {grad}
          </Single>
        )
      ) : (
        <Single size={size} />
      )}
    </UnstyledButton>
  );
}
