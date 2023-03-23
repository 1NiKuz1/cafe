<template>
  <div class="content-wrapper">
    <div class="control-wrapper">
      <Button
        v-if="shift"
        label="Добавить нового заказа"
        @click="isShowAddNewOrderDialog = true"
      />
    </div>
    <template v-if="!shift"
      ><p class="default-response">Нет активных смен</p></template
    >
    <template v-else-if="orders.length">
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
            <Button
              icon="pi pi-cog"
              label="Edit"
              @click="$router.push(`/order/${order.id}`)"
            />
          </template>
        </Card>
      </div>
    </template>
    <ProgressSpinner v-else ria-label="Loading" class="progress-spiner" />
  </div>

  <Dialog
    v-model:visible="isShowAddNewOrderDialog"
    modal
    header="Добавление нового заказа"
  >
    <AddNewOrder :idShift="shift.id" @addNewOrder="handleAddNewOrder" />
  </Dialog>
  <Toast />
</template>

<script>
import Card from "primevue/card";
import Button from "primevue/button";
import Dropdown from "primevue/dropdown";
import Dialog from "primevue/dialog";
import WorkShiftService from "@/services/workshift.service.js";
import AddNewOrder from "@/components/AddNewOrder.vue";
import ProgressSpinner from "primevue/progressspinner";
import showError from "@/mixins/showError";
import { useAuthStore } from "@/stores/auth";

export default {
  components: {
    Card,
    Button,
    Dropdown,
    Dialog,
    AddNewOrder,
    ProgressSpinner,
  },

  mixins: [showError],

  setup() {
    const auth = useAuthStore();
    const { userData } = auth;
    return {
      userData,
    };
  },

  data() {
    return {
      orders: [],
      shift: null,
      isShowAddNewOrderDialog: false,
    };
  },

  mounted() {
    if (this.userData.user.role != "Официант") {
      this.$router.push("/");
      return;
    }
    this.loadData();
  },

  methods: {
    async handleAddNewOrder() {
      await this.loadOrders(this.shift.id);
      this.isShowAddNewOrderDialog = false;
    },

    async loadData() {
      await this.loadShifts();
      if (!this.shift) return;
      await this.loadOrders(this.shift.id);
    },

    loadShifts() {
      return WorkShiftService.showAllWorkShifts()
        .then((res) => {
          res.forEach((el) => {
            if (el.active) this.shift = el;
          });
        })
        .catch((err) => {
          this.showError(err);
        });
    },

    loadOrders(id) {
      return WorkShiftService.showOrderByWorkShift(id)
        .then((res) => {
          this.orders = res[0].orders;
        })
        .catch((err) => {
          this.showError(err);
        });
    },
  },
  watch: {
    selectedShift(newVal, oldVal) {
      this.loadOrders(newVal.id);
    },
  },
};
</script>

<style scoped></style>
