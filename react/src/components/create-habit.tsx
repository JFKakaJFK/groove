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
import { FiPlus } from "react-icons/fi";
import { z } from "zod";
import { useCreateHabit } from "../api/habit";
import { ColorInput } from "./color-input";
import { ErrorMessage } from "./error-message";

const schema = z.object({
  name: z.string().nonempty("Required"),
  description: z.string().optional(),
  color: z.string().optional(),
});

export function CreateHabit() {
  const form = useForm({
    initialValues: {
      name: "",
      description: "",
      color: "",
    },
    schema: zodResolver(schema),
  });
  const [open, setOpen] = useState<boolean>(false);
  const create = useCreateHabit();

  return (
    <>
      <ActionIcon
        size="lg"
        variant="filled"
        radius="xl"
        onClick={() => setOpen(true)}
      >
        <FiPlus size={16} />
      </ActionIcon>

      <Modal
        centered
        opened={open}
        onClose={() => setOpen(false)}
        title="Add a new Habit"
      >
        <form
          onSubmit={form.onSubmit((values) =>
            create.mutate(values, {
              onSuccess() {
                setOpen(false);
              },
            })
          )}
        >
          {create.isError && <ErrorMessage error={create.error} />}

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
            <Button type="submit" loading={create.isLoading}>
              Create Habit
            </Button>
          </Group>
        </form>
      </Modal>
    </>
  );
}
