<template>
  <div class="card">
    <MegaMenu :model="items">
      <template #start>
        <p @click="$router.push('/')" class="logo">Cafe</p>
      </template>
    </MegaMenu>
  </div>
</template>

<script>
import MegaMenu from "primevue/megamenu";
export default {
  components: {
    MegaMenu,
  },
  setup() {
    const items = [
      {
        label: "Сотрудники",
        to: "/employees",
      },
      {
        label: "Смены",
        to: "/shifts",
      },
      {
        label: "Заказы",
        to: "/orders",
      },
      {
        label: "Вход",
        to: "/login",
      },
      {
        label: "Выход",
      },
    ];

    return {
      items,
    };
  },
  data() {
    return {};
  },
};
</script>

<style scoped>
.logo {
  font-size: 24px;
  font-weight: 700;
  margin: 0 40px;
  color: var(--color-accent);
}

p {
  cursor: pointer;
}

.card,
.p-megamenu {
  border-radius: 0px;
}
</style>
