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
import UserService from "@/services/user.service.js";

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

  data() {
    return {
      employees: [],
      selectedEmployee: null,
      isLoading: false,
    };
  },
  mounted() {
    this.loadEmployess();
  },
  methods: {
    loadEmployess() {
      UserService.getUsers()
        .then((res) => {
          this.employees = res;
        })
        .catch((err) => {
          this.showError(err);
        });
    },

    async addEmployeeOnShift() {
      this.isLoading = true;
      try {
        if (!this.selectedEmployee) {
          this.showError(new Error("Выберите сотрудника"));
          return;
        }
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
