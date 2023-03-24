<template>
  <form @submit.prevent class="form-container">
    <label class="form-label" for="employee">Список сотрудников</label>
    <Dropdown
      name="employee"
      v-model="selectedEmployee"
      :options="employees"
      optionLabel="login"
      placeholder="Выбор сотрудника"
      class="w-full md:w-14rem"
    />
    <Button
      class="form-button"
      :disabled="isLoading || !employees.length"
      @click="addEmployeeOnShift()"
      label="Добавить"
      dateFormat="yy/mm/dd"
    />
  </form>
</template>

<script>
import Button from "primevue/button";
import Dropdown from "primevue/dropdown";
import WorkShiftService from "@/services/workshift.service.js";
import showError from "@/mixins/showError";
import { useDataStore } from "@/stores/data";
import { storeToRefs } from "pinia";

export default {
  name: "AddNewEmployeeOnWorkShift",
  emits: ["addNewShift"],
  props: {
    idShift: Number,
  },
  components: {
    Dropdown,
    Button,
  },

  mixins: [showError],

  setup() {
    const data = useDataStore();
    const { employees } = storeToRefs(data);
    const { getUsers } = data;
    return {
      getUsers,
      employees,
    };
  },

  data() {
    return {
      selectedEmployee: null,
      isLoading: false,
    };
  },

  mounted() {
    if (!this.employees.length) {
      this.getUsers().catch((err) => {
        this.showError(err);
      });
    }
  },

  methods: {
    async addEmployeeOnShift() {
      this.isLoading = true;
      try {
        if (!this.selectedEmployee) {
          this.showError(new Error("Выберите сотрудника"));
          return;
        }
        //Adding a new employee to the shift
        await WorkShiftService.addUserOnWorkShift(
          this.idShift,
          this.selectedEmployee.id
        );
      } catch (err) {
        this.showError(err);
      }
      this.isLoading = false;
    },
  },
};
</script>

<style scoped></style>
