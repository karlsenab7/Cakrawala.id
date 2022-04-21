import { Navigate, useRoutes } from "react-router-dom";
// layouts
import DashboardLayout from "./layouts/dashboard";
import LogoOnlyLayout from "./layouts/LogoOnlyLayout";
//
import DashboardApp from "./pages/DashboardApp";
import Hadiah from "./pages/Hadiah";
import User from "./pages/User";
import NotFound from "./pages/Page404";
import TopUp from "./pages/TopUp";
import Merchant from "./pages/Merchant";

// ----------------------------------------------------------------------

export default function Router() {
  return useRoutes([
    {
      path: "/dashboard",
      element: <DashboardLayout />,
      children: [
        { path: "app", element: <DashboardApp /> },
        { path: "user", element: <User /> },
        { path: "topup", element: <TopUp /> },
        { path: "merchant", element: <Merchant /> },
        { path: "hadiah", element: <Hadiah /> },
      ],
    },
    {
      path: "/",
      element: <LogoOnlyLayout />,
      children: [
        { path: "/", element: <Navigate to="/dashboard/app" /> },
        { path: "404", element: <NotFound /> },
        { path: "*", element: <Navigate to="/404" /> },
      ],
    },
    { path: "*", element: <Navigate to="/404" replace /> },
  ]);
}
