<template>
  <form @submit.prevent class="form-container">
    <label class="form-label" for="dateStart">Выбор столика</label>
    <Dropdown
      name="tables"
      v-model="selectedTable"
      :options="tables"
      optionLabel="name"
      placeholder="Выбор столика"
      class="w-full md:w-14rem form-input"
    />
    <label class="form-label" for="countOfPersons">Количество человек</label>
    <InputNumber
      name="countOfPersons"
      class="form-input"
      v-model="countOfPersons"
      inputId="integeronly"
      :min="1"
      :max="1000"
    />
    <Button
      class="form-button"
      :disabled="isLoading"
      @click="addNewOrder()"
      label="Добавить"
    />
  </form>
</template>

<script>
import Button from "primevue/button";
import InputNumber from "primevue/inputnumber";
import Dropdown from "primevue/dropdown";
import OrderService from "@/services/order.service.js";
import showError from "@/mixins/showError";
import { useDataStore } from "@/stores/data";
import { storeToRefs } from "pinia";

export default {
  name: "AddNewOrder",
  emits: ["addNewOrder"],
  props: {
    idShift: Number,
  },

  components: {
    InputNumber,
    Button,
    Dropdown,
  },

  mixins: [showError],

  setup() {
    const data = useDataStore();
    const { tables } = storeToRefs(data);
    const { getTables } = data;
    return {
      getTables,
      tables,
    };
  },

  data() {
    return {
      isLoading: false,
      countOfPersons: 1,
      selectedTable: null,
    };
  },

  mounted() {
    if (!this.tables.length) {
      this.getTables().catch((err) => {
        this.showError(err);
      });
    }
  },

  methods: {
    async addNewOrder() {
      this.isLoading = true;
      try {
        if (this.selectedTable) {
          //Creating a new order
          await OrderService.createOrder(
            this.idShift,
            this.selectedTable.id,
            this.countOfPersons
          );
          this.$emit("addNewOrder");
        } else {
          this.showError(new Error("Выберите столик"));
        }
      } catch (err) {
        this.showError(err);
      }
      this.isLoading = false;
    },
  },
};
</script>

<style scoped></style>
