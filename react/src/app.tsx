import { Route, Routes } from "react-router-dom";

import { Layout } from "./components/layout";
import { Root, A } from "./routes";

function App() {
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        <Route path="/" element={<Root />} />
        <Route path="/a" element={<A />} />
      </Route>
    </Routes>
  );
}

export default App;
