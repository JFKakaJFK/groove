import {
  Card,
  LoadingOverlay,
  Popper,
  SimpleGrid,
  Text,
  UnstyledButton,
} from "@mantine/core";
import { GetInputPropsPayload } from "@mantine/form/lib/types";
import { useClickOutside } from "@mantine/hooks";
import { SyntheticEvent, useEffect, useState } from "react";
import { useColors } from "../api/habit";
import { ErrorMessage } from "./error-message";

/**
 * Custom intput with the interface of an input type string
 *
 * Mantine supports color inputs already out of the box, but not
 * in a way that I wanted it and I wanted to play with custom inputs
 * and dropdowns a bit anyway...
 */
export function ColorInput({ value, onChange }: GetInputPropsPayload) {
  // the library interestingly 1. does not have nice support for dropdowns
  // and 2. needs useState instead of useRef here...
  const [referenceElement, setReferenceElement] =
    useState<HTMLElement | null>();
  const [open, setOpen] = useState(false);
  const popupRef = useClickOutside(
    () => {
      setOpen(false);
    },
    null,
    [referenceElement as HTMLElement]
  );
  const colors = useColors();

  useEffect(() => {
    if (colors.data && !colors.data.includes(value)) {
      onChange(colors.data[Math.floor(Math.random() * colors.data.length)]);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [colors.data]);

  return (
    <UnstyledButton
      ref={setReferenceElement}
      onClick={(e: SyntheticEvent) => {
        e.stopPropagation();
        setOpen((o) => !o);
      }}
      sx={(theme) => ({
        width: 36,
        height: 36,
        backgroundColor: value,
        borderRadius: 4,
        position: "relative",
      })}
      disabled={colors.isLoading}
    >
      <LoadingOverlay visible={colors.isLoading} />
      <Popper
        position="bottom"
        placement="end"
        mounted={open}
        withinPortal
        referenceElement={referenceElement as HTMLElement}
      >
        <Card
          shadow="xl"
          ref={popupRef}
          style={{ position: "relative", pointerEvents: "all" }}
          onMouseDown={(e: SyntheticEvent) => e.stopPropagation()}
          onClick={(e: SyntheticEvent) => e.stopPropagation()}
        >
          <LoadingOverlay visible={colors.isLoading} />
          {colors.isError && <ErrorMessage error={colors.error} />}

          <Text weight={500} size="md" mb="xs">
            Select color
          </Text>

          <SimpleGrid cols={5} spacing="sm">
            {colors.data?.map((c) => (
              <UnstyledButton
                key={c}
                onClick={(e) => {
                  e.stopPropagation();
                  onChange(c);
                }}
                sx={{
                  width: 24,
                  height: 24,
                  backgroundColor: c,
                  borderRadius: 4,
                  cursor: "pointer",
                }}
              />
            ))}
          </SimpleGrid>
        </Card>
      </Popper>
    </UnstyledButton>
  );
}
