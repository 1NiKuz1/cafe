<template>
  <div class="content-wrapper">
    <div class="control-wrapper">
      <Button
        v-if="shift"
        label="Добавить нового заказа"
        @click="isShowAddNewOrderDialog = true"
      />
    </div>
    <!--If there is an active shift-->
    <template v-if="!shift"
      ><p class="default-response">Нет активных смен</p></template
    >
    <!--If there are orders show them-->
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
    <!--Else show the ProgressSpinner-->
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
import AddNewOrder from "@/components/AddNewOrder.vue";
import ProgressSpinner from "primevue/progressspinner";
import showError from "@/mixins/showError";
import { useAuthStore } from "@/stores/auth";
import { useDataStore } from "@/stores/data";
import { storeToRefs } from "pinia";

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
    const data = useDataStore();
    const { shifts, orders } = storeToRefs(data);
    const { getWorkShifts, getOrdersById } = data;
    const { userData } = auth;
    return {
      userData,
      shifts,
      orders,
      getWorkShifts,
      getOrdersById,
    };
  },

  data() {
    return {
      shift: null,
      isShowAddNewOrderDialog: false,
    };
  },

  mounted() {
    if (this.userData.user.role != "Официант") {
      this.$router.push("/");
      return;
    }
    if (!this.orders.length) {
      this.loadData();
    } else {
      this.findActiveShift();
    }
  },

  methods: {
    handleAddNewOrder() {
      //Handling the event of adding a new order
      this.getOrdersById(this.shift.id)
        .catch((err) => {
          this.showError(err);
        })
        .finally(() => {
          this.isShowAddNewOrderDialog = false;
        });
    },

    async loadData() {
      try {
        if (!this.shifts.length) await this.getWorkShifts();
        this.findActiveShift();
        if (!this.shift) return;
        await this.getOrdersById(this.shift.id);
      } catch (error) {
        this.showError(error);
      }
    },

    findActiveShift() {
      this.shift = this.shifts.find((el) => el.active);
    },
  },
};
</script>

<style scoped></style>
