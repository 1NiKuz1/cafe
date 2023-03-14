<template>
  <div class="card-wrapper">
    <Card v-for="shift in shifts" :key="shift.id" class="shift-card">
      <template #title>{{ shift.title }}</template>
      <template #content>
        <ul>
          <li>Начало смены: {{ shift.start }}</li>
          <li>Конец смены: {{ shift.end }}</li>
          <li>Статус: {{ shift.status }}</li>
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
    const shifts = reactive([
      {
        id: 1,
        title: "Смена 1",
        start: "2021-09-19 08:00",
        end: "2021-09-19 18:00",
        status: "Открыта",
      },
      {
        id: 2,
        title: "Смена 2",
        start: "2021-09-19 08:00",
        end: "2021-09-19 18:00",
        status: "Открыта",
      },
      {
        id: 3,
        title: "Смена 3",
        start: "2021-09-19 08:00",
        end: "2021-09-19 18:00",
        status: "Открыта",
      },
      {
        id: 4,
        title: "Смена 4",
        start: "2021-09-19 08:00",
        end: "2021-09-19 18:00",
        status: "Открыта",
      },
      {
        id: 5,
        title: "Смена 5",
        start: "2021-09-19 08:00",
        end: "2021-09-19 18:00",
        status: "Открыта",
      },
      {
        id: 6,
        title: "Смена 6",
        start: "2021-09-19 08:00",
        end: "2021-09-19 18:00",
        status: "Открыта",
      },
      {
        id: 7,
        title: "Смена 7",
        start: "2021-09-19 08:00",
        end: "2021-09-19 18:00",
        status: "Открыта",
      },
      {
        id: 8,
        title: "Смена 8",
        start: "2021-09-19 08:00",
        end: "2021-09-19 18:00",
        status: "Открыта",
      },
      {
        id: 9,
        title: "Смена 9",
        start: "2021-09-19 08:00",
        end: "2021-09-19 18:00",
        status: "Открыта",
      },
    ]);

    return {
      shifts,
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

.shift-card {
  flex: 1 0 280px;
  max-width: 330px;
}

@media (max-width: 620px) {
  .shift-card {
    max-width: none;
  }
}
</style>
