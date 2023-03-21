<template>
  <form @submit.prevent>
    <label class="from-label" for="dateStart">Выбор столика</label>
    <Dropdown
      name="tables"
      v-model="selectedTable"
      :options="tables"
      optionLabel="name"
      placeholder="Выбор столика"
      class="w-full md:w-14rem add-shift-drop"
    />
    <label class="from-label" for="countOfPersons">Количество человек</label>
    <InputNumber name="countOfPersons" v-model="countOfPersons" inputId="integeronly" />
    <Button
      class="from-button"
      :disabled="isLoading"
      @click="addNewShift()"
      label="Добавить"
      dateFormat="yy/mm/dd"
    />
  </form>
</template>

<script>
import Button from "primevue/button";
import InputNumber from 'primevue/inputnumber';
import Dropdown from "primevue/dropdown";
import OrderService from "@/services/order.service.js";
import useShowError from "@/composables/useShowError.js";

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
  data() {
    return {
      isLoading: false,
      countOfPersons: 0,
      selectedTable: null,
      tables: null,
    };
  },
  methods: {
    showError(err) {
      useShowError(err, this);
    },
    async addNewShift() {
      this.isLoading = true;
      try {
        console.log("add");
      } catch (err) {
        this.showError(err);
      }
      this.isLoading = false;
    },
  },
};
</script>

<style scoped>
form {
  display: flex;
  flex-direction: column;
}
.from-label {
  margin-bottom: 5px;
}
.from-input {
  margin-bottom: 10px;
}
.from-button {
  align-self: flex-start;
  margin-top: 20px;
}
</style>
