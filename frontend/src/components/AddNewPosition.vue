<template>
  <form @submit.prevent class="form-container">
    <label class="form-label" for="dateStart">Выбор позиции</label>
    <Dropdown
      name="tables"
      v-model="selectedMenu"
      :options="menu"
      optionLabel="name"
      placeholder="Выбор позиции"
      class="w-full md:w-14rem form-input"
    />
    <label class="form-label" for="countOfIngredients"
      >Количество игредиентов</label
    >
    <InputNumber
      name="countOfIngredients"
      class="form-input"
      v-model="countOfIngredients"
      inputId="integeronly"
      :min="1"
      :max="10"
    />
    <Button
      class="form-button"
      :disabled="isLoading"
      @click="addNewPosition()"
      label="Добавить"
    />
  </form>
</template>

<script>
import Button from "primevue/button";
import InputNumber from "primevue/inputnumber";
import Dropdown from "primevue/dropdown";
import OrderService from "@/services/order.service.js";
import WorkShiftService from "@/services/workshift.service.js";
import showError from "@/mixins/showError";

export default {
  name: "AddNewPosition",
  emits: ["addNewPosition"],
  props: {
    idOrder: Number,
  },

  components: {
    InputNumber,
    Button,
    Dropdown,
  },

  mixins: [showError],

  data() {
    return {
      isLoading: false,
      countOfIngredients: 1,
      selectedMenu: null,
      menu: null,
    };
  },

  mounted() {
    this.loadMenu();
  },

  methods: {
    loadMenu() {
      WorkShiftService.getMenu()
        .then((res) => {
          this.menu = res;
        })
        .catch((err) => {
          this.showError(err);
        });
    },

    async addNewPosition() {
      this.isLoading = true;
      try {
        if (this.selectedMenu) {
          await OrderService.addPositionToOrder(
            this.idOrder,
            this.selectedMenu.id,
            this.countOfIngredients
          );
          this.$emit("addNewPosition");
        } else {
          this.showError(new Error("Выберите столик"));
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
