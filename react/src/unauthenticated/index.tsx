import { Route, Routes } from "react-router-dom";

import { Layout } from "../components/layout";
import { PageNotFound } from "../page-not-found";
import { Login } from "./login";
import { Register } from "./register";
import { Root } from "./root";

export default function UnauthenticatedApp() {
  return (
    <Routes>
      <Route element={<Layout />}>
        <Route path="/" element={<Root />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="*" element={<PageNotFound />} />
      </Route>
    </Routes>
  );
}
