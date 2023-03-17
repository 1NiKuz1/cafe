<template>
  <form @submit.prevent>
    <label class="from-label" for="dateStart">Дата начала</label>
    <Calendar
      class="from-input"
      name="dateStart"
      v-model="dateStart"
      showTime
      dateFormat="yy-mm-dd"
      hourFormat="24"
    />
    <label class="from-label" for="dateEnd">Дата окончания</label>
    <Calendar
      class="from-input"
      name="dateEnd"
      v-model="dateEnd"
      showTime
      dateFormat="yy-mm-dd"
      hourFormat="24"
    />
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
import Calendar from "primevue/calendar";
import Button from "primevue/button";
import WorkShiftService from "@/services/workshift.service.js";
import useShowError from "../composables/useShowError.js";
import { useAuthStore } from "@/stores/auth";
import { storeToRefs } from "pinia";
export default {
  name: "WorkShiftAddNew",
  emits: ["addNewShift"],
  components: {
    Calendar,
    Button,
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
      dateStart: null,
      dateEnd: null,
      isLoading: false,
    };
  },
  methods: {
    showError(err) {
      useShowError(err, this);
    },
    async addNewShift() {
      try {
        this.isLoading = true;
        if (this.dateStart && this.dateEnd)
          await WorkShiftService.createWorkShift({
            start: `${this.dateStart.getFullYear()}-${
              this.dateStart.getMonth() > 8
                ? this.dateStart.getMonth() + 1
                : "0" + (this.dateStart.getMonth() + 1)
            }-${this.dateStart.getDate()} ${this.dateStart.getHours()}:${this.dateStart.getMinutes()}`,
            end: `${this.dateEnd.getFullYear()}-${
              this.dateEnd.getMonth() > 8
                ? this.dateEnd.getMonth() + 1
                : "0" + (this.dateEnd.getMonth() + 1)
            }-${this.dateEnd.getDate()} ${this.dateEnd.getHours()}:${this.dateEnd.getMinutes()}`,
          });
        else this.showError(new Error("Должны быть заполнены все поля"));

        this.isLoading = false;
        this.$emit("addNewShift");
      } catch (err) {
        this.showError(err);
        this.isLoading = false;
      }
    },
  },
};
</script>

<style scoped>
form {
  display: flex;
  align-items: start;
  flex-direction: column;
}
.from-label {
  margin-bottom: 5px;
}
.from-input {
  margin-bottom: 10px;
}
.from-button {
  margin-top: 20px;
}
</style>
