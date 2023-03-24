<template>
  <div class="content-wrapper">
    <div class="control-wrapper">
      <Button
        v-if="employees.length"
        label="Добавить нового пользователя"
        @click="isShowAddNewUserDialog = true"
      />
    </div>
    <!--If there are employees show them-->
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
    <!--Else show the ProgressSpinner-->
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
import showError from "@/mixins/showError";
import { useAuthStore } from "@/stores/auth";
import { useDataStore } from "@/stores/data";
import { storeToRefs } from "pinia";

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
    const data = useDataStore();
    const { employees } = storeToRefs(data);
    const { getUsers } = data;
    const { userData } = auth;
    return {
      userData,
      getUsers,
      employees,
    };
  },

  data() {
    return {
      isLoading: false,
      isShowAddNewUserDialog: false,
    };
  },

  mounted() {
    if (this.userData.user.role != "Администратор") {
      this.$router.push("/");
      return;
    }
    if (!this.employees.length) {
      this.getUsers().catch((err) => {
        this.showError(err);
      });
    }
  },

  methods: {
    handleAddNewEmployee() {
      //Handling the event of adding a new user
      this.getUsers().catch((err) => {
        this.showError(err);
      });
      this.isShowAddNewUserDialog = false;
    },
  },
};
</script>

<style scoped></style>
