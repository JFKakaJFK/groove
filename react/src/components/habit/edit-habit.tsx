import {
  ActionIcon,
  Button,
  Group,
  Modal,
  Textarea,
  TextInput,
} from "@mantine/core";
import { useForm, zodResolver } from "@mantine/form";
import { useState } from "react";
import { FiEdit3 } from "react-icons/fi";
import { z } from "zod";
import { Habit as HabitT, useUpdateHabit } from "../../api/habit";
import { ColorInput } from "../color-input";
import { ErrorMessage } from "../error-message";

const schema = z.object({
  name: z.string().nonempty("Required"),
  description: z.string().optional(),
  color: z.string().optional(),
});

export function EditHabit({ habit }: { habit: HabitT }) {
  const form = useForm({
    initialValues: {
      name: habit.name,
      description: habit.description,
      color: habit.color,
    },
    schema: zodResolver(schema),
  });
  const [open, setOpen] = useState<boolean>(false);
  const update = useUpdateHabit();

  return (
    <>
      <ActionIcon
        size="lg"
        variant="filled"
        radius="xl"
        onClick={() => setOpen(true)}
      >
        <FiEdit3 size={16} />
      </ActionIcon>

      <Modal
        centered
        opened={open}
        onClose={() => setOpen(false)}
        title="Update Habit"
      >
        <form
          onSubmit={form.onSubmit((values) =>
            update.mutate(
              { ...values, id: habit.id },
              {
                onSuccess() {
                  setOpen(false);
                },
              }
            )
          )}
        >
          {update.isError && <ErrorMessage error={update.error} />}

          <Group align="end">
            <TextInput
              required
              label="Name"
              placeholder="Learn Dutch"
              style={{
                flex: 1,
              }}
              {...form.getInputProps("name")}
            />

            <ColorInput {...form.getInputProps("color")} />
          </Group>

          <Textarea
            label="Description"
            {...form.getInputProps("description")}
          />

          <Group position="right" spacing="sm" mt="md">
            <Button
              type="button"
              variant="default"
              onClick={() => setOpen(false)}
            >
              Back
            </Button>
            <Button type="submit" loading={update.isLoading}>
              Update Habit
            </Button>
          </Group>
        </form>
      </Modal>
    </>
  );
}
