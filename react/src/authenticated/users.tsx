import {
  Badge,
  Button,
  Card,
  Center,
  Checkbox,
  Group,
  LoadingOverlay,
  Pagination,
  ScrollArea,
  Table,
  Text,
  TextInput,
  Title,
} from "@mantine/core";
import { useMemo, useState } from "react";
import { User } from "../api/auth";
import { usePromoteUser, useUsers } from "../api/user";
import { Authorized } from "../components/authenticated";
import { ErrorMessage } from "../components/error-message";

/**
 * So I heard react-table is a nice and mature data table library.
 * The cool thing is that it is headless so you can do bla bla bla...
 *
 * Hence I tried the library, found it to be unecessarily boilerplatey.
 * Ahh so there are no complete typescript declarations for the current release
 *
 * But there is a rewrite from the ground up in typescript so lets go
 * Ohh there is no documentation yet, stuff doesn't work and the type declarations
 * are in random places?
 *
 * Summing up, my experience with react-table was a lot worse than expected,
 * the new api is an improvement but this thing is still far from production
 * ready...
 *
 */
import {
  createTable,
  paginateRowsFn,
  columnFilterRowsFn,
  globalFilterRowsFn,
  sortRowsFn,
  Column,
  ReactTable,
} from "@tanstack/react-table";
import { SortingState } from "@tanstack/react-table/build/types/features/Sorting";
import { PaginationState } from "@tanstack/react-table/build/types/features/Pagination";
import { ColumnFiltersState } from "@tanstack/react-table/build/types/features/Filters";

/// <reference types="@tanstack/react-table/build/types/utils" />
import { functionalUpdate } from "@tanstack/react-table/build/cjs/utils";
import { FiAward, FiChevronDown, FiChevronUp, FiSearch } from "react-icons/fi";
import { DeleteUser } from "../components/delete-user";

function UserFilter({
  column,
  instance,
}: {
  column: Column<User, unknown, unknown, unknown, unknown>;
  instance: ReactTable<User, unknown, unknown, unknown, unknown>;
}) {
  const firstValue =
    instance.getPreColumnFilteredFlatRows()[0].values[column.id];

  return typeof firstValue === "boolean" ? (
    <Checkbox
      checked={(column.getColumnFilterValue() ?? true) as boolean}
      indeterminate={typeof column.getColumnFilterValue() !== "boolean"}
      onChange={(e) => {
        const prev = column.getColumnFilterValue();
        column.setColumnFilterValue(
          prev
            ? false // true -> false
            : prev === false
            ? undefined // false -> no filter
            : true // no filter -> true
        );
      }}
    />
  ) : (
    <TextInput
      radius="xs"
      size="xs"
      value={(column.getColumnFilterValue() ?? "") as string}
      onChange={(e) => column.setColumnFilterValue(e.currentTarget.value)}
    />
  );
}

const allUsersTable = createTable<User, unknown, unknown, unknown, unknown>();

function AllUsersTable() {
  const users = useUsers();
  const promote = usePromoteUser();

  const columns = useMemo(
    () =>
      allUsersTable.createColumns([
        allUsersTable.createDataColumn("name", { header: "Name" }),
        allUsersTable.createDataColumn("email", { header: "Email" }),
        allUsersTable.createDataColumn("verified", {
          header: "Verified",
          cell({ value }) {
            return <Checkbox checked={value} disabled readOnly />;
          },
        }),
        allUsersTable.createDataColumn("newsletter", {
          header: "Subscribed",
          cell({ value }) {
            return <Checkbox checked={value} disabled readOnly />;
          },
        }),
        allUsersTable.createDataColumn("isPremium", {
          header: "Premium",
          cell({ value, row }) {
            return value ? (
              <Center>
                <Badge size="sm">Premium</Badge>
              </Center>
            ) : (
              <Button
                leftIcon={<FiAward size={12} />}
                variant="subtle"
                radius="xl"
                size="xs"
                loading={promote.isLoading}
                onClick={() => {
                  if (row.original?.id) promote.mutate(row.original?.id);
                }}
              >
                Promote
              </Button>
            );
          },
        }),
        allUsersTable.createDataColumn("isAdmin", {
          header: "Admin",
          cell({ value }) {
            return value ? <Badge size="sm">Admin</Badge> : null;
          },
        }),
      ]),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    []
  );

  const data = useMemo(() => {
    if (Array.isArray(users.data)) {
      return users.data;
    } else {
      return [];
    }
  }, [users.data]);

  const [pagination, setPagination] = useState<PaginationState>({
    pageIndex: 0,
    pageSize: 10,
  });

  const [sorting, setSorting] = useState<SortingState>([]);

  const [columnFilters, setColumnFilters] = useState<ColumnFiltersState>([]);
  const [globalFilter, setGlobalFilter] = useState("");

  const instance = allUsersTable.useTable({
    data,
    columns,
    state: {
      pagination,
      sorting,
      columnFilters,
      globalFilter,
    },
    onSortingChange: setSorting,
    sortRowsFn,
    onPaginationChange(updater) {
      setPagination((old) => {
        const newValue = functionalUpdate(updater, old);
        return newValue;
      });
    },
    paginateRowsFn,
    onColumnFiltersChange: setColumnFilters,
    onGlobalFilterChange: setGlobalFilter,
    columnFilterRowsFn,
    globalFilterRowsFn,
  });

  return (
    <div style={{ position: "relative", minHeight: 250, maxWidth: "100%" }}>
      <LoadingOverlay visible={users.isLoading} />
      {users.isError && <ErrorMessage error={users.error} />}

      <TextInput
        icon={<FiSearch size={14} />}
        value={globalFilter ?? ""}
        onChange={(e) => setGlobalFilter(e.currentTarget.value)}
        placeholder="Search all columns..."
      />

      {users.data?.length && (
        <>
          <ScrollArea sx={{ maxWidth: "100%" }}>
            <Table {...instance.getTableProps()}>
              <thead>
                {instance.getHeaderGroups().map((g) => (
                  <tr {...g.getHeaderGroupProps()}>
                    {g.headers.map((c) => (
                      <th
                        {...c.getHeaderProps()}
                        style={{ verticalAlign: "baseline" }}
                      >
                        {c.isPlaceholder ? null : (
                          <Group
                            direction="column"
                            sx={{ alignItems: "stretch" }}
                          >
                            <Group
                              align="center"
                              position="apart"
                              sx={{ flexWrap: "nowrap" }}
                            >
                              <Text size="sm" weight={500}>
                                {c.renderHeader()}
                              </Text>
                              <Group
                                direction="column"
                                spacing={0}
                                {...(c.column.getCanSort()
                                  ? c.column.getToggleSortingProps({
                                      className: "cursor-pointer select-none",
                                    })
                                  : {})}
                              >
                                <FiChevronUp
                                  size={14}
                                  style={{
                                    opacity:
                                      c.column.getIsSorted() === "asc"
                                        ? 1
                                        : 0.5,
                                  }}
                                />
                                <FiChevronDown
                                  size={14}
                                  style={{
                                    opacity:
                                      c.column.getIsSorted() === "desc"
                                        ? 1
                                        : 0.5,
                                  }}
                                />
                              </Group>
                            </Group>

                            {c.column.getCanColumnFilter() ? (
                              <div>
                                <UserFilter
                                  column={c.column}
                                  instance={instance}
                                />
                              </div>
                            ) : null}
                          </Group>
                        )}
                      </th>
                    ))}
                    <th></th>
                  </tr>
                ))}
              </thead>
              <tbody {...instance.getTableBodyProps()}>
                {instance.getRowModel().rows.map((r) => (
                  <tr {...r.getRowProps()}>
                    {r.getVisibleCells().map((c) => {
                      return <td {...c.getCellProps()}>{c.renderCell()}</td>;
                    })}
                    <td>
                      <DeleteUser user={r.original} />
                    </td>
                  </tr>
                ))}
              </tbody>
            </Table>
          </ScrollArea>
          <Center pt="sm">
            <Pagination
              page={pagination.pageIndex}
              total={
                Math.ceil(
                  instance.getPrePaginationRows().length / pagination.pageSize
                ) - 1
              }
              onChange={instance.setPageIndex}
            />
          </Center>
        </>
      )}
    </div>
  );
}

export function Users() {
  return (
    <Authorized admin>
      <Card sx={{ alignSelf: "top", maxWidth: "100%" }}>
        <Title order={2} mb="md">
          Manage Users
        </Title>

        <AllUsersTable />
      </Card>
    </Authorized>
  );
}
