import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import EmployeesView from "../views/EmployeesView.vue";
import LoginView from "../views/LoginView.vue";
import OrdersView from "../views/OrdersView.vue";
import ShiftsView from "../views/ShiftsView.vue";
import WaiterOrdersView from "../views/WaiterOrdersView.vue";
import CookOrdersView from "../views/CookOrdersView.vue";
import SelectedOrderView from "../views/SelectedOrderView.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
    },
    {
      path: "/employees",
      name: "employees",
      component: EmployeesView,
    },
    {
      path: "/login",
      name: "login",
      component: LoginView,
    },
    {
      path: "/orders",
      name: "orders",
      component: OrdersView,
    },
    {
      path: "/shift-orders",
      name: "shift-orders",
      component: WaiterOrdersView,
    },
    {
      path: "/cook-orders",
      name: "cook-orders",
      component: CookOrdersView,
    },
    {
      path: "/order/:id",
      name: "order",
      component: SelectedOrderView,
    },
    {
      path: "/shifts",
      name: "shifts",
      component: ShiftsView,
    },
  ],
});

export default router;
