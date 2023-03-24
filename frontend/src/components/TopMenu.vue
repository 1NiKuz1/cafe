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
import { useDataStore } from "@/stores/data";

export default {
  name: "TopMenu",
  components: {
    MegaMenu,
  },

  setup() {
    const auth = useAuthStore();
    const data = useDataStore();
    const { userData } = auth;
    const { isLogged } = storeToRefs(auth);
    const { logout } = auth;

    return {
      isLogged,
      logout,
      userData,
      data,
    };
  },

  data() {
    return {
      menuItems: [
        {
          name: "employees",
          label: "Сотрудники",
          to: "/employees",
          visible: false,
        },
        {
          name: "shifts",
          label: "Смены",
          to: "/shifts",
          visible: false,
        },
        {
          name: "orders",
          label: "Заказы",
          to: "/orders",
          visible: false,
        },
        {
          name: "waiter-orders",
          label: "Заказы",
          to: "/shift-orders",
          visible: false,
        },
        {
          name: "cook-orders",
          label: "Заказы",
          to: "/cook-orders",
          visible: false,
        },
        {
          name: "login",
          label: "Вход",
          to: "/login",
          visible: !this.isLogged,
        },
        {
          name: "logout",
          label: "Выход",
          command: this.logoutWithReset,
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
    async logoutWithReset() {
      await this.logout();
      this.data.$reset();
    },

    createListMenu() {
      this.menuItems.forEach((el) => {
        if (!this.isLogged) {
          switch (el.name) {
            case "login":
              el.visible = true;
              break;
            case "logout":
              el.visible = false;
              break;
            default:
              el.visible = false;
          }
          return;
        }
        if (this.userData.user.role === "Администратор") {
          switch (el.name) {
            case "employees":
              el.visible = true;
              break;
            case "shifts":
              el.visible = true;
              break;
            case "orders":
              el.visible = true;
              break;
            case "login":
              el.visible = false;
              break;
            case "logout":
              el.visible = true;
              break;
          }
        }
        if (this.userData.user.role === "Официант") {
          switch (el.name) {
            case "waiter-orders":
              el.visible = true;
              break;
            case "login":
              el.visible = false;
              break;
            case "logout":
              el.visible = true;
              break;
          }
        }
        if (this.userData.user.role === "Повар") {
          switch (el.name) {
            case "cook-orders":
              el.visible = true;
              break;
            case "login":
              el.visible = false;
              break;
            case "logout":
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
