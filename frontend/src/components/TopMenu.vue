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
import { useAuthStore } from "@/stores/auth";
import { storeToRefs } from "pinia";
export default {
  components: {
    MegaMenu,
  },
  setup() {
    const auth = useAuthStore();
    const { isLogged } = storeToRefs(auth);
    const { logout } = auth;

    return {
      isLogged,
      logout
    };
  },
  data() {
    return {
      items: [
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
        visible: !this.isLogged,
      },
      {
        label: "Выход",
        command: this.logout,
        visible: this.isLogged,
      },
    ],
    };
  },
  watch: {
    isLogged(newVal, oldVal) {
      location.reload()
    }
  }
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
