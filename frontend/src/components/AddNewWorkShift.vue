<template>
  <form @submit.prevent class="form-container">
    <label class="form-label" for="dateStart">Дата начала</label>
    <Calendar
      class="form-input"
      name="dateStart"
      v-model="dateStart"
      showTime
      dateFormat="yy-mm-dd"
      hourFormat="24"
    />
    <label class="form-label" for="dateEnd">Дата окончания</label>
    <Calendar
      class="form-input"
      name="dateEnd"
      v-model="dateEnd"
      showTime
      dateFormat="yy-mm-dd"
      hourFormat="24"
    />
    <Button
      class="form-button"
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
import showError from "@/mixins/showError";

export default {
  name: "AddNewWorkShift",
  emits: ["addNewShift"],
  components: {
    Calendar,
    Button,
  },

  mixins: [showError],

  data() {
    return {
      dateStart: null,
      dateEnd: null,
      isLoading: false,
    };
  },

  methods: {
    async addNewShift() {
      this.isLoading = true;
      try {
        if (this.dateStart && this.dateEnd) {
          //Creating a new shift
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
          this.$emit("addNewShift");
        } else {
          this.showError(new Error("Заполните дату начала и окончания смены"));
        }
      } catch (err) {
        this.showError(err);
      }
      this.isLoading = false;
    },
  },
};
</script>

<style scoped></style>
