import { Route, Routes } from "react-router-dom";

import { Layout } from "../components/layout";
import { Login } from "./login";
import { Root } from "./root";

export default function UnauthenticatedApp() {
  return (
    <Routes>
      <Route element={<Layout />}>
        <Route path="/login" element={<Login />} />
        <Route path="*" element={<Root />} />
      </Route>
    </Routes>
  );
}
