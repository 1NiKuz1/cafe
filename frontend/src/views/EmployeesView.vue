<template>
  <div class="content-wrapper">
    <div class="control-wrapper">
      <Button
        v-if="employees.length"
        label="Добавить нового пользователя"
        @click="isShowAddNewUserDialog = true"
      />
    </div>
    <template v-if="employees.length">
      <div class="cards">
        <Card
          v-for="employee in employees"
          :key="employee.id"
          class="cards__item"
        >
          <template #title>{{ employee.name }}</template>
          <template #content>
            <ul>
              <li>Статус: {{ employee.status }}</li>
              <li>Должность: {{ employee.group }}</li>
            </ul>
          </template>
        </Card>
      </div>
    </template>
    <ProgressSpinner v-else ria-label="Loading" class="progress-spiner" />
  </div>
  <Dialog
    v-model:visible="isShowAddNewUserDialog"
    modal
    header="Добавление новой смены"
  >
    <AddNewEmployee @addNewEmployee="handleAddNewEmployee" />
  </Dialog>
  <Toast />
</template>

<script>
import Card from "primevue/card";
import Button from "primevue/button";
import ProgressSpinner from "primevue/progressspinner";
import Dialog from "primevue/dialog";
import AddNewEmployee from "@/components/AddNewEmployee.vue";
import UserService from "@/services/user.service.js";
import showError from "@/mixins/showError";
import { useAuthStore } from "@/stores/auth";

export default {
  components: {
    Card,
    Button,
    ProgressSpinner,
    Dialog,
    AddNewEmployee,
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
      employees: [],
      isShowAddNewUserDialog: false,
    };
  },

  mounted() {
    if (this.userData.user.role != "Администратор") {
      this.$router.push("/");
      return;
    }
    this.loadEmployess();
  },

  methods: {
    handleAddNewEmployee() {
      this.getUsers().catch((err) => {
        this.showError(err);
      });
      this.loadEmployess();
      this.isShowAddNewUserDialog = false;
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
  },
};
</script>

<style scoped></style>
