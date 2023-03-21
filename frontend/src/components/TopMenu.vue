<template>
  <div class="card">
    <MegaMenu :model="menuItems">
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
  name: "TopMenu",
  components: {
    MegaMenu,
  },

  setup() {
    const auth = useAuthStore();
    const { userData } = auth;
    const { isLogged } = storeToRefs(auth);
    const { logout } = auth;

    return {
      isLogged,
      logout,
      userData,
    };
  },

  data() {
    return {
      menuItems: [
        {
          label: "Сотрудники",
          to: "/employees",
          visible: false,
        },
        {
          label: "Смены",
          to: "/shifts",
          visible: false,
        },
        {
          label: "Заказы",
          to: "/orders",
          visible: false,
        },
        {
          label: "Обработка заказов",
          to: "/shift-orders",
          visible: false,
        },
        {
          label: "Заказы за смену",
          to: "/orders-for-shift",
          visible: false,
        },
        {
          label: "Заказы активной смены",
          to: "/orders-for-active-shift",
          visible: false,
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

  mounted() {
    this.createListMenu();
  },

  watch: {
    isLogged() {
      this.createListMenu();
      this.$router.push("/");
    },
  },

  methods: {
    createListMenu() {
      this.menuItems.forEach((el) => {
        if (!this.isLogged) {
          switch (el.label) {
            case "Вход":
              el.visible = true;
              break;
            case "Выход":
              el.visible = false;
              break;
            default:
              el.visible = false;
          }
          return;
        }
        if (this.userData.user.role === "Администратор") {
          switch (el.label) {
            case "Сотрудники":
              el.visible = true;
              break;
            case "Смены":
              el.visible = true;
              break;
            case "Заказы":
              el.visible = true;
              break;
            case "Вход":
              el.visible = false;
              break;
            case "Выход":
              el.visible = true;
              break;
          }
        }
        if (this.userData.user.role === "Официант") {
          switch (el.label) {
            case "Обработка заказов":
              el.visible = true;
              break;
            case "Заказы за смену":
              el.visible = true;
              break;
            case "Вход":
              el.visible = false;
              break;
            case "Выход":
              el.visible = true;
              break;
          }
        }
        if (this.userData.user.role === "Повар") {
          switch (el.label) {
            case "Заказы активной смены":
              el.visible = true;
              break;
            case "Вход":
              el.visible = false;
              break;
            case "Выход":
              el.visible = true;
              break;
          }
        }
      });
    },
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
