<template>
  <form @submit.prevent>
    <label class="from-label" for="employee">Список сотрудников</label>
    <Dropdown
      name="employee"
      v-model="selectedEmployee"
      :options="employees"
      optionLabel="login"
      placeholder="Выбор сотрудника"
      class="w-full md:w-14rem"
    />
    <Button
      class="from-button"
      :disabled="isLoading || !employees"
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
import useShowError from "../composables/useShowError.js";
import UserService from "@/services/user.service.js";

export default {
  name: "AddNewWorkShift",
  emits: ["addNewShift"],
  props: {
    idShift: Number,
  },
  components: {
    Dropdown,
    Button,
  },
  data() {
    return {
      employees: null,
      selectedEmployee: null,
      isLoading: false,
    };
  },
  mounted() {
    this.loadEmployess();
  },
  methods: {
    showError(err) {
      useShowError(err, this);
    },

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
          this.showError(new Error("Выберете сотрдуника"));
          this.isLoading = false;
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
