import { ActionIcon, Button, Group, Modal } from "@mantine/core";
import { useState } from "react";
import { FiTrash2 } from "react-icons/fi";
import { To, useNavigate } from "react-router-dom";
import { Habit as HabitT, useDeleteHabit } from "../../api/habit";

export function DeleteHabit({ habit, to }: { habit: HabitT; to: To }) {
  const [open, setOpen] = useState<boolean>(false);
  const del = useDeleteHabit();
  const navigate = useNavigate();

  return (
    <>
      <ActionIcon
        size="lg"
        variant="filled"
        radius="xl"
        onClick={() => setOpen(true)}
      >
        <FiTrash2 size={16} />
      </ActionIcon>

      <Modal
        centered
        opened={open}
        onClose={() => setOpen(false)}
        title="Are you sure?"
      >
        <Group position="right" spacing="sm" mt="md">
          <Button
            type="button"
            variant="default"
            onClick={() => setOpen(false)}
          >
            Back
          </Button>
          <Button
            type="submit"
            color="red"
            loading={del.isLoading}
            onClick={() =>
              del.mutate(habit.id, {
                onSuccess() {
                  navigate(to);
                },
              })
            }
          >
            Delete
          </Button>
        </Group>
      </Modal>
    </>
  );
}
