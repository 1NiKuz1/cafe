<template>
  <div class="card-wrapper">
    <Card
      v-for="employee in employees"
      :key="employee.id"
      class="employee-card"
    >
      <template #title>{{ employee.name }}</template>
      <template #content>
        <ul>
          <li>Должность: {{ employee.role }}</li>
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
    const employees = reactive([
      {
        id: 1,
        name: "Ваня",
        role: "Администратор",
      },
      {
        id: 2,
        name: "Ваня",
        role: "Администратор",
      },
      {
        id: 3,
        name: "Ваня",
        role: "Администратор",
      },
      {
        id: 4,
        name: "Ваня",
        role: "Администратор",
      },
      {
        id: 5,
        name: "Ваня",
        role: "Администратор",
      },
      {
        id: 6,
        name: "Ваня",
        role: "Администратор",
      },
      {
        id: 7,
        name: "Ваня",
        role: "Администратор",
      },
    ]);

    return {
      employees,
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

.employee-card {
  flex: 1 0 280px;
  max-width: 330px;
}

@media (max-width: 620px) {
  .employee-card {
    max-width: none;
  }
}
</style>
