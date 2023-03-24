<template>
  <div class="content-wrapper">
    <div class="control-wrapper">
      <Button
        v-if="shifts.length"
        label="Добавить новую смену"
        @click="isShowAddNewShiftDialog = true"
      />
    </div>
    <!--If there are shifts show them-->
    <template v-if="shifts.length">
      <div class="cards">
        <Card
          v-for="shift in shifts"
          :key="shift.id"
          class="cards__item cards__item--large"
        >
          <template #title>Смена {{ shift.id }}</template>

          <template #content>
            <ul>
              <li>Начало смены:</li>
              <li>{{ shift.start }}</li>
              <li>Конец смены:</li>
              <li>{{ shift.end }}</li>
              <li>Статус: {{ shift.active ? "Активна" : "Не активна" }}</li>
            </ul>
          </template>

          <template #footer>
            <Button
              label="Добавить"
              style="margin-right: 10px"
              @click="handleAddEmployeeDialog(shift.id)"
            />
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
      </div>
    </template>
    <!--Else show the ProgressSpinner-->
    <ProgressSpinner v-else ria-label="Loading" class="progress-spiner" />
    <Toast />
  </div>

  <Dialog
    v-model:visible="isShowAddNewShiftDialog"
    modal
    header="Добавление новой смены"
  >
    <AddNewWorkShift @addNewShift="handleAddNewShift" />
  </Dialog>
  <Dialog
    v-model:visible="isShowAddNewUserDialog"
    modal
    header="Добавление нового пользователя на смену"
  >
    <AddEmployeeOnWorkShift :idShift="selectedShift" />
  </Dialog>
  <Toast />
</template>

<script>
import Card from "primevue/card";
import Button from "primevue/button";
import ProgressSpinner from "primevue/progressspinner";
import Dialog from "primevue/dialog";
import AddNewWorkShift from "@/components/AddNewWorkShift.vue";
import AddEmployeeOnWorkShift from "@/components/AddEmployeeOnWorkShift.vue";
import WorkShiftService from "@/services/workshift.service.js";
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
    AddNewWorkShift,
    AddEmployeeOnWorkShift,
  },

  mixins: [showError],

  setup() {
    const auth = useAuthStore();
    const data = useDataStore();
    const { shifts } = storeToRefs(data);
    const { getWorkShifts } = data;
    const { userData } = auth;
    return {
      userData,
      shifts,
      getWorkShifts,
    };
  },

  data() {
    return {
      selectedShift: null,
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
    if (!this.shifts.length) {
      this.getWorkShifts()
        .then(() => {
          this.checkShiftsForOpenness();
        })
        .catch((err) => {
          this.showError(err);
        });
    }
  },

  methods: {
    handleAddEmployeeDialog(shiftId) {
      this.selectedShift = shiftId;
      this.isShowAddNewUserDialog = true;
    },

    handleAddNewShift() {
      //Handling the event of adding a new shift
      this.getWorkShifts()
        .then(() => {
          this.checkShiftsForOpenness();
        })
        .catch((err) => {
          this.showError(err);
        });
      this.isShowAddNewShiftDialog = false;
    },

    async changeStatusWorkShift(id, status) {
      try {
        //Changing the shift status
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

<style scoped></style>
