<template>
  <Button
    v-if="isLoading"
    label="Добавить новую смену"
    class="add-user-button"
    @click="isShowAddNewShiftDialog = true"
  />
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
          <Button label="Добавить" style="margin-right: 10px" />
          <Button
            v-if="shift.active"
            @click="changeStatusWorkShift(shift.id, false)"
            severity="danger"
            label="Закрыть"
          />
          <Button
            v-else
            :disabled="isShiftOpen"
            @click="changeStatusWorkShift(shift.id, true)"
            severity="success"
            label="Открыть"
          />
        </template>
      </Card>
    </template>
    <ProgressSpinner v-else ria-label="Loading" class="progress-spiner" />
    <Dialog
      v-model:visible="isShowAddNewShiftDialog"
      modal
      header="Добавление новой смены"
    >
      <WorkShiftAddNew @addNewShift="loadShidts()" />
    </Dialog>
    <Dialog
      v-model:visible="isShowAddNewUserDialog"
      modal
      header="Добавление нового пользователя на смену"
    >
      <WorkShiftAddNew />
    </Dialog>
  </div>
  <Toast />
</template>

<script>
import Card from "primevue/card";
import Button from "primevue/button";
import ProgressSpinner from "primevue/progressspinner";
import Dialog from "primevue/dialog";
import WorkShiftAddNew from "@/components/WorkShiftAddNew.vue";
import WorkShiftService from "@/services/workshift.service.js";
import useShowError from "../composables/useShowError.js";
import { useAuthStore } from "@/stores/auth";
import { ref, reactive, toRefs } from "vue";

export default {
  components: {
    Card,
    Button,
    ProgressSpinner,
    Dialog,
    WorkShiftAddNew,
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
      isShiftOpen: false,
      isShowAddNewShiftDialog: false,
      isShowAddNewUserDialog: false,
    };
  },

  mounted() {
    if (this.userData.user.role != "Администратор") {
      this.$router.push("/");
      return;
    }
    this.loadShidts();
  },

  methods: {
    showError(err) {
      useShowError(err, this);
    },

    loadShidts() {
      WorkShiftService.showAllWorkShifts()
        .then((res) => {
          res.forEach((el) => {
            el.title = `Смена ${el.id}`;
            el.status = el.active ? "Активна" : "Не активна";
          });
          this.shifts = res;
          this.isLoading = true;
          this.checkShiftsForOpenness();
        })
        .catch((err) => {
          this.showError(err);
        });
    },

    async changeStatusWorkShift(id, status) {
      try {
        if (status) await WorkShiftService.openWorkShift(id);
        else await WorkShiftService.closeWorkShift(id);
        this.shifts.forEach((el) => {
          if (el.id === id) {
            el.active = status;
            el.status = status ? "Активна" : "Не активна";
          }
        });
        this.checkShiftsForOpenness();
      } catch (err) {
        this.showError(err);
      }
    },

    checkShiftsForOpenness() {
      let isActive = false;
      this.shifts.forEach((el) => {
        if (el.active) isActive = true;
      });
      this.isShiftOpen = isActive;
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
