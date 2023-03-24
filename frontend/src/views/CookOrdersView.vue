<template>
  <div class="content-wrapper">
    <!--If there are orders show them-->
    <template v-if="orders.length">
      <div class="cards">
        <Card v-for="order in orders" :key="order.id" class="cards__item">
          <template #title>{{ order.table }}</template>
          <template #content>
            <ul>
              <li>Официант: {{ order.shift_workers }}</li>
              <li>Статус: {{ order.status }}</li>
              <li>Цена: {{ order.price || "Нет позиций" }}</li>
            </ul>
          </template>
          <template #footer>
            <Button label="Изменить статус" @click="changeStatus(order)" />
          </template>
        </Card>
      </div>
    </template>
    <!--Else show the ProgressSpinner-->
    <ProgressSpinner v-else ria-label="Loading" class="progress-spiner" />
  </div>
  <Toast />
</template>

<script>
import Card from "primevue/card";
import Button from "primevue/button";
import ProgressSpinner from "primevue/progressspinner";
import OrderService from "@/services/order.service.js";
import showError from "@/mixins/showError";
import { useAuthStore } from "@/stores/auth";
import { useDataStore } from "@/stores/data";
import { storeToRefs } from "pinia";

export default {
  components: {
    Card,
    Button,
    ProgressSpinner,
  },

  mixins: [showError],

  setup() {
    const auth = useAuthStore();
    const data = useDataStore();
    const { ordersForCook } = storeToRefs(data);
    const { getOrdersForCook } = data;
    const { userData } = auth;
    return {
      userData,
      orders: ordersForCook,
      getOrdersForCook,
    };
  },

  mounted() {
    if (this.userData.user.role != "Повар") {
      this.$router.push("/");
      return;
    }
    if (!this.orders.length) {
      this.getOrdersForCook().catch((err) => {
        this.showError(err);
      });
    }
  },

  methods: {
    changeStatus(order) {
      let status = "";
      if (order.status == "Принят") status = "preparing";
      if (order.status == "Готовится") status = "ready";
      if (status) {
        //Changing the order status
        OrderService.changeOrderStatus(order.id, status)
          .then(() => {
            this.getOrdersForCook().catch((err) => {
              this.showError(err);
            });
          })
          .catch((err) => {
            this.showError(err);
          });
      } else {
        this.showError(new Error("Вы не можете изменить статус этого заказа"));
      }
    },
  },
};
</script>

<style scoped></style>
