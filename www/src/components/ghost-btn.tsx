import { UnstyledButton, UnstyledButtonProps } from "@mantine/core";
import { forwardRef } from "react";

export const GhostButton = forwardRef<HTMLButtonElement, UnstyledButtonProps>(
  ({ children, ...props }, ref) => {
    return (
      <UnstyledButton
        p={5}
        sx={(theme) => ({
          background:
            theme.colorScheme === "light" ? "initial" : theme.colors.dark[5],
          borderWidth: 1,
          borderStyle: "solid",
          borderColor:
            theme.colorScheme === "light"
              ? theme.colors.gray[3]
              : theme.colors.dark[5],
          borderRadius: theme.radius.md,
        })}
        {...props}
        ref={ref}
      >
        {children}
      </UnstyledButton>
    );
  }
);
