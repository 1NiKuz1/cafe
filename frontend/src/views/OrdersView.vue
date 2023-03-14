<template>
  <div class="card-wrapper">
    <Card v-for="order in orders" :key="order.id" class="order-card">
      <template #title>{{ order.title }}</template>
      <template #content>
        <ul>
          <li>Официант: {{ order.server }}</li>
          <li>Статус: {{ order.status }}</li>
          <li>Цена: {{ order.ptice }}</li>
        </ul>
      </template>
      <template #footer>
        <Button icon="pi pi-cog" label="Edit" />
      </template>
    </Card>
  </div>
</template>

<script>
import Card from "primevue/card";
import Button from "primevue/button";
import { ref, reactive } from "vue";
export default {
  components: {
    Card,
    Button,
  },
  setup() {
    const orders = reactive([
      {
        id: 1,
        title: "Столик 1",
        server: "Jhon",
        status: "Отмена",
        price: 9238,
      },
      {
        id: 2,
        title: "Столик 2",
        server: "Jhon",
        status: "Отмена",
        price: 9238,
      },
      {
        id: 3,
        title: "Столик 3",
        server: "Jhon",
        status: "Отмена",
        price: 9238,
      },
      {
        id: 4,
        title: "Столик 4",
        server: "Jhon",
        status: "Отмена",
        price: 9238,
      },
      {
        id: 5,
        title: "Столик 5",
        server: "Jhon",
        status: "Отмена",
        price: 9238,
      },
      {
        id: 6,
        title: "Столик 6",
        server: "Jhon",
        status: "Отмена",
        price: 9238,
      },
      {
        id: 7,
        title: "Столик 7",
        server: "Jhon",
        status: "Отмена",
        price: 9238,
      },
      {
        id: 8,
        title: "Столик 8",
        server: "Jhon",
        status: "Отмена",
        price: 9238,
      },
      {
        id: 9,
        title: "Столик 9",
        server: "Jhon",
        status: "Отмена",
        price: 9238,
      },
    ]);

    return {
      orders,
    };
  },
  data() {
    return {};
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

.order-card {
  flex: 1 0 200px;
  max-width: 250px;
}

@media (max-width: 460px) {
  .order-card {
    max-width: none;
  }
}
</style>
