<template>
  <Button  label="Добавить новую смену" class="add-user-button"  />
  <div class="card-wrapper">
    <template v-if="isLoading">
      <Card v-for="shift in shifts" :key="shift.id" class="shift-card">
        <template #title>{{ shift.title }}</template>
        <template #content>
          <ul>
            <li>Начало смены:</li>
            <li>{{ shift.start }}</li>
            <li>Конец смены:</li>
            <li>{{ shift.end }}</li>
            <li>Статус: {{ shift.status }}</li>
          </ul>
        </template>
        <template #footer>
          <Button  label="Добавить" style="margin-right: 10px;" />
          <Button v-if="shift.active" @click="closeWorkShift(shift.id)" severity="danger" label="Закрыть" />
          <Button v-else :disabled="isAllClose" @click="openWorkShift(shift.id)" severity="success" label="Открыть" />
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
import WorkShiftService from "@/services/workshift.service.js";
import { useAuthStore } from "@/stores/auth";
import { ref, reactive, toRefs } from "vue";

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
      shifts: [],
      isLoading: false,
      isAllClose: false,
    };
  },

  mounted() {
    if (this.userData.user.role != "Администратор") {
      this.$router.push("/");
      return;
    }

    WorkShiftService.showAllWorkShifts()
      .then((res) => {
        res.forEach((el) => {
          el.title = `Смена ${el.id}`;
          el.status = el.active ? "Активна" : "Не активна";
        });
        this.checkShiftsForOpenness();
        this.shifts = res;
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

    closeWorkShift(id) {
      WorkShiftService.closeWorkShift(id).then(() => {
        this.shifts.forEach(el => {
          if (el.id === id) {
            el.active = 0;
            el.status = "Не активна";
          }
        })
        this.checkShiftsForOpenness();
      }).catch(err => this.showError(err));
    },

    async openWorkShift(id) {
      try {
        WorkShiftService.openWorkShift(id);
        this.shifts.forEach(el => {
          if (el.id === id) {
            el.active = 1;
            el.status = "Активна";
          }
        })
        this.checkShiftsForOpenness();
      } catch(err) {
        this.showError(err)
      }
    },

    checkShiftsForOpenness() {
      let isActive = false;
      this.shifts.forEach(el => {
        if (el.active) isActive = true;
      })
      console.log(this.shifts)
      this.isAllClose = isActive;
    }
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

.shift-card {
  flex: 1 0 280px;
  max-width: 330px;
}

.progress-spiner {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
}

.add-user-button {
  margin-top: 20px;
  left: 50%;
  transform: translateX(-50%);
}

@media (max-width: 620px) {
  .shift-card {
    max-width: none;
  }
}
</style>
