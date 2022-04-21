// component
import Iconify from "../../components/Iconify";

// ----------------------------------------------------------------------

const getIcon = (name) => <Iconify icon={name} width={22} height={22} />;

const sidebarConfig = [
  {
    title: "dashboard",
    path: "/dashboard/app",
    icon: getIcon("eva:pie-chart-2-fill"),
  },
  {
    title: "user",
    path: "/dashboard/user",
    icon: getIcon("eva:people-fill"),
  },
  {
    title: "top up",
    path: "/dashboard/topup",
    icon: getIcon("akar-icons:circle-chevron-up-fill"),
  },
  {
    title: "merchant",
    path: "/dashboard/merchant",
    icon: getIcon("bxs:store"),
  },
  {
    title: "Reward",
    path: "/dashboard/hadiah",
    icon: getIcon("bxs:gift"),
  },
];

export default sidebarConfig;
