import { Route, Routes } from "react-router-dom";
import { Authenticated } from "../components/authenticated";

import { Layout } from "../components/layout";
import { Root } from "./root";

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
        <Route path="*" element={<Root />} />
      </Route>
    </Routes>
  );
}
