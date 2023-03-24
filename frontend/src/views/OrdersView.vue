<template>
  <div class="content-wrapper">
    <div class="control-wrapper">
      <Dropdown
        name="shifts"
        v-model="selectedShift"
        :options="ShiftsForDrop"
        optionLabel="title"
        placeholder="Выбор смены"
        class="w-full md:w-14rem"
      />
    </div>
    <!--If no shift is selected-->
    <template v-if="!selectedShift"
      ><p class="default-response">
        Выберете смену по которой хотите получить информацию.
      </p></template
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
              <li>Цена: {{ order.price }}</li>
            </ul>
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
import Dropdown from "primevue/dropdown";
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
    ProgressSpinner,
  },

  mixins: [showError],

  setup() {
    const auth = useAuthStore();
    const { userData } = auth;
    const data = useDataStore();
    const { shifts, orders, selectedShift } = storeToRefs(data);
    const { getWorkShifts, getOrdersById } = data;
    return {
      userData,
      shifts,
      orders,
      selectedShift,
      getWorkShifts,
      getOrdersById,
    };
  },

  mounted() {
    if (this.userData.user.role != "Администратор") {
      this.$router.push("/");
      return;
    }
    if (!this.shifts.length) {
      this.getWorkShifts().catch((err) => {
        this.showError(err);
      });
    }
  },

  computed: {
    ShiftsForDrop() {
      return this.shifts.map((el) => {
        return { id: el.id, title: `Смена ${el.id}` };
      });
    },
  },

  watch: {
    selectedShift(newVal) {
      this.getOrdersById(newVal.id).catch((err) => {
        this.showError(err);
      });
    },
  },
};
</script>

<style scoped></style>
