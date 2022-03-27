import { ActionIcon, Button, Group, Modal } from "@mantine/core";
import { useState } from "react";
import { FiTrash2 } from "react-icons/fi";
import { useAuth, User } from "../api/auth";
import { useDeleteUser } from "../api/user";

export function DeleteUser({ user }: { user: User | undefined }) {
  const { user: principal } = useAuth();
  const [open, setOpen] = useState<boolean>(false);
  const del = useDeleteUser();

  if (!user || user.id === principal?.id) {
    return null;
  }

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
              del.mutate(user.id, {
                onSuccess() {
                  setOpen(false);
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
