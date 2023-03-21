<template>
  <template v-if="order">
    <Button
      label="Изменить статус заказа"
      class="change-status-button"
      @click="changeStatus"
    />
    <div class="content-wrapper">
      <p class="information-order">{{ order.table }}</p>
      <p class="information-order">Официант: {{ order.shift_workers }}</p>
      <p class="information-order">Статус: {{ order.status }}</p>
    </div>
    <div class="card-wrapper">
      <Card
        v-for="position of order.positions"
        :key="position.id"
        class="position-card"
      >
        <template #title>Позиция {{ position.id}}</template>
        <template #content>
          <ul>
            <li>Позиция: {{ position.position }}</li>
            <li>Количество: {{ position.count }}</li>
            <li>Количество: {{ position.price }}</li>
          </ul>
        </template>
        <template #footer>
          <div class="button-wrapper">
            <Button
              label="Добавить позицию"
              @click=""
            />
            <Button
              label="Удалить позицию"
              @click=""
            />
          </div>
        </template>
      </Card>
    </div>
    <div class="control-wrapepr">
      
    </div>
  </template>
  <ProgressSpinner v-else ria-label="Loading" class="progress-spiner" />
</template>

<script>
import Card from "primevue/card";
import Button from "primevue/button";
import Dropdown from "primevue/dropdown";
import Dialog from "primevue/dialog";
import ProgressSpinner from "primevue/progressspinner";
import WorkShiftService from "@/services/workshift.service.js";
import OrderService from "@/services/order.service.js";
import useShowError from "@/composables/useShowError.js";

export default {
  components: {
    Card,
    Button,
    Dropdown,
    Dialog,
    ProgressSpinner
  },

  data() {
    return {
      orderId: this.$route.params.id,
      order: null,
    };
  },

  mounted() {
    this.loadOrder();
  },

  methods: {
    showError(err) {
      useShowError(err, this);
    },

    loadOrder() {
      OrderService.showOrder(this.orderId).then(res => {
        this.order = res.details[0];
      }).catch(err => {
        showError(err);
      })
    },

    changeStatus() {
      let status = "";
      if (this.order.status == "Принят") status = "canceled"
      if (this.order.status == "Готов") status = "paid-up"
      if (status) {
        OrderService.changeOrderStatus(this.orderId, status).then(() => {
          this.loadOrder();
        }).catch(err => {
          this.showError(err);
        })
      } else {
        this.showError(new Error("Проблема со статусом заказа"));
      }
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

p {
 margin-bottom: 0;
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

.progress-spiner {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
}

.position-card {
  flex: 1 0 280px;
  max-width: 330px;
}

.change-status-button {
  margin-top: 20px;
  left: 50%;
  transform: translateX(-50%);
}

.content-wrapper {
  max-width: 1280px;
  margin: 60px auto;
  padding: 0 20px;
}

.button-wrapper {
  margin-top: auto;
  display: flex;
  gap: 5px;
}

@media (max-width: 620px) {
  .position-card {
    max-width: none;
  }

  .content-wrapper {
    max-width: none;
  }
}
</style>
