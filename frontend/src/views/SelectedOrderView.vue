<template>
  <div class="position-wrapper">
    <template v-if="order">
      <div class="control-wrapper">
        <Button v-if="textChangeStatus" @click="changeStatus"
          ><span class="p-button-label"
            >Изменить статус на {{ textChangeStatus }}</span
          ></Button
        >
        <Button
          v-if="order.status == 'Принят' || order.status == 'Готовится'"
          label="Добавить позицию"
          @click="isAddPositionDialog = true"
        />
      </div>
      <div class="order-content-wrapper">
        <p class="information-order">{{ order.table }}</p>
        <p class="information-order">Официант: {{ order.shift_workers }}</p>
        <p class="information-order">Статус: {{ order.status }}</p>
      </div>
      <div class="card-wrapper">
        <Card
          v-for="position of order.positions"
          :key="position.id"
          class="cards__item cards__item--large"
        >
          <template #title>Позиция {{ position.id }}</template>
          <template #content>
            <ul>
              <li>Позиция: {{ position.position }}</li>
              <li>Количество: {{ position.count }}</li>
              <li>Количество: {{ position.price }}</li>
            </ul>
          </template>
          <template #footer>
            <Button
              v-if="order.status == 'Принят'"
              label="Удалить"
              @click="delPosition(order.id, position.id)"
            />
          </template>
        </Card>
      </div>
      <div class="control-wrapepr"></div>
    </template>
    <ProgressSpinner v-else ria-label="Loading" class="progress-spiner" />
  </div>
  <Dialog
    v-model:visible="isAddPositionDialog"
    modal
    header="Добавление новой позиции"
  >
    <AddNewPosition
      :idOrder="+orderId"
      @addNewPosition="handleAddNewPosition"
    />
  </Dialog>
  <Toast />
</template>

<script>
import Card from "primevue/card";
import Button from "primevue/button";
import Dropdown from "primevue/dropdown";
import Dialog from "primevue/dialog";
import ProgressSpinner from "primevue/progressspinner";
import OrderService from "@/services/order.service.js";
import AddNewPosition from "@/components/AddNewPosition.vue";
import showError from "@/mixins/showError";
import { useAuthStore } from "@/stores/auth";

export default {
  components: {
    Card,
    Button,
    Dropdown,
    Dialog,
    ProgressSpinner,
    AddNewPosition,
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
      orderId: this.$route.params.id,
      order: null,
      textChangeStatus: null,
      isAddPositionDialog: false,
    };
  },

  mounted() {
    if (this.userData.user.role != "Официант") {
      this.$router.push("/");
      return;
    }
    this.loadOrder();
  },

  methods: {
    loadOrder() {
      return OrderService.showOrder(this.orderId)
        .then((res) => {
          this.order = res.details[0];
          this.textChangeStatus =
            this.order.status == "Принят"
              ? "Отменить"
              : this.order.status == "Готов"
              ? "Оплачен"
              : null;
        })
        .catch((err) => {
          this.showError(err);
        });
    },

    async handleAddNewPosition() {
      await this.loadOrder();
      this.isAddPositionDialog = false;
    },

    delPosition(idOrder, idPosition) {
      OrderService.delPositionToOrder(idOrder, idPosition)
        .then((res) => {
          this.loadOrder();
        })
        .catch((err) => {
          this.showError(err);
        });
    },

    changeStatus() {
      let status = "";
      if (this.order.status == "Принят") status = "canceled";
      if (this.order.status == "Готов") status = "paid-up";
      if (status) {
        OrderService.changeOrderStatus(this.orderId, status)
          .then(() => {
            this.loadOrder();
          })
          .catch((err) => {
            this.showError(err);
          });
      } else {
        this.showError(new Error("Вы не можете изменить статус этого заказа"));
      }
    },
  },
};
</script>

<style scoped>
.order-content-wrapper {
  margin-top: 20px;
  padding: 0 20px;
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

.information-order {
  font-size: 18px;
  margin-bottom: 10px;
  font-weight: 600;
}

.position-wrapper {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 20px;
  position: relative;
  height: 90vh;
}

@media (max-width: 620px) {
  .position-wrapper {
    max-width: none;
  }
}
</style>
