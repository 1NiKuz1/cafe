<template>
  <div class="card-wrapper">
    <template v-if="isLoading">
      <Card
        v-for="employee in employees"
        :key="employee.id"
        class="employee-card"
      >
        <template #title>{{ employee.name }}</template>
        <template #content>
          <ul>
            <li>Статус: {{ employee.status }}</li>
          </ul>
        </template>
        <template #footer>
          <Button icon="pi pi-cog" label="Edit" />
        </template>
      </Card>
    </template>
    <ProgressSpinner v-else ria-label="Loading" class="progress-spiner" />
  </div>
  <Toast />
</template>

<script>
import Card from "primevue/card";
import Button from "primevue/button";
import ProgressSpinner from "primevue/progressspinner";
import { ref, reactive } from "vue";
import UserService from "@/services/user.service.js";
import { useAuthStore } from "@/stores/auth";
export default {
  components: {
    Card,
    Button,
    ProgressSpinner,
  },
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
      isLoading: false,
    };
  },
  mounted() {
    if (this.userData.user.role != "Администратор") {
      this.$router.push("/");
      return;
    }
    UserService.getUsers()
      .then((res) => {
        this.employees = res;
        this.isLoading = true;
      })
      .catch((err) => {
        this.showError(err);
      });
  },
  methods: {
    showError(err) {
      this.$toast.add({
        severity: "error",
        summary: "Error message",
        detail: `Error code: ${err.code}
        Message: ${err.message}`,
        life: 5000,
      });
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
  position: relative;
  margin: 60px auto;
  padding: 0 20px;
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  max-width: 1280px;
  justify-content: center;
}

.employee-card {
  flex: 1 0 280px;
  max-width: 330px;
}

.progress-spiner {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
}

@media (max-width: 620px) {
  .employee-card {
    max-width: none;
  }
}
</style>
