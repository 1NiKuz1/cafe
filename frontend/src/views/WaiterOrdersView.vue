<template>
  <div class="control-wrapper">
    <!-- <Dropdown
      name="shifts"
      v-model="selectedShift"
      :options="shift"
      optionLabel="title"
      placeholder="Выбор смены"
      class="w-full md:w-14rem add-shift-drop"
    /> -->
    <Button
      :disabled="!shift"
      label="Добавить нового заказа"
      class="add-shift-button"
      @click="isShowAddNewOrderDialog = true"
    />
  </div>
  <div class="card-wrapper">
    <template v-if="orders?.length">
      <Card v-for="order in orders" :key="order.id" class="order-card">
        <template #title>{{ order.table }}</template>
        <template #content>
          <ul>
            <li>Официант: {{ order.shift_workers }}</li>
            <li>Статус: {{ order.status }}</li>
            <li>Цена: {{ order.price }}</li>
          </ul>
        </template>
        <template #footer>
          <Button icon="pi pi-cog" label="Edit" @click="$router.push(`/order/${order.id}`)" />
        </template>
      </Card>
    </template>
    <template v-else-if="!orders"
      ><p class="order-message">
        Нет активных смен
      </p></template
    >
    <template v-else><p class="order-message">Заказы не найдены.</p></template>
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
import useShowError from "@/composables/useShowError.js";

export default {
  components: {
    Card,
    Button,
    Dropdown,
    Dialog,
    AddNewOrder,
  },

  data() {
    return {
      orders: null,
      shift: null,
      isShowAddNewOrderDialog: false,
    };
  },

  mounted() {
    this.loadData();
  },

  methods: {
    showError(err) {
      useShowError(err, this);
    },

    handleAddNewOrder() {
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

<style scoped>
ul {
  margin: 0;
  padding: 0;
  list-style: none;
}
.card-wrapper {
  margin: 60px auto;
  padding: 0 20px;
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  max-width: 1280px;
  justify-content: center;
}

.order-card {
  flex: 1 0 200px;
  max-width: 250px;
}

.control-wrapper {
  margin-top: 20px;
  display: flex;
  column-gap: 10px;
  justify-content: center;
}
/* .add-shift-drop {
  margin-top: 20px;
  left: 50%;
  transform: translateX(-50%);
}
.add-shift-button {
  margin-top: 20px;
  left: 50%;
  transform: translateX(-50%);
} */

.order-message {
  font-size: 18px;
  font-weight: 500;
}

@media (max-width: 460px) {
  .order-card {
    max-width: none;
  }
}
</style>
