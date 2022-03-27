import { Route, Routes } from "react-router-dom";
import { Authenticated } from "../components/authenticated";

import { Layout } from "../components/layout";
import { PageNotFound } from "../page-not-found";
import { PermissonDenied } from "../permission-denied";
import { Habit } from "./habit";
import { Home } from "./home";
import { Users } from "./users";

function AuthenticatedLayout() {
  return (
    <Authenticated>
      <Layout />
    </Authenticated>
  );
}

export default function AuthenticatedApp() {
  return (
    <Routes>
      <Route element={<AuthenticatedLayout />}>
        <Route path="/habits/:habitId" element={<Habit />} />

        {/* Admin only */}
        <Route path="/users" element={<Users />} />

        <Route path="/404" element={<PageNotFound />} />
        <Route path="/403" element={<PermissonDenied />} />
        <Route path="*" element={<Home />} />
      </Route>
    </Routes>
  );
}
