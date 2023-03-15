import { ref, computed, reactive, readonly } from "vue";
import { defineStore } from "pinia";
import TokenService from "@/services/token.service.js";
import AuthService from "@/services/auth.service.js";

export const useAuthStore = defineStore("auth", () => {
  // Проверить работу ствойства
  let _user = reactive(JSON.parse(localStorage.getItem("user")));
  let user = readonly(_user);
  let isLogged = ref(user ? true : false);

  async function login(user) {
    try {
      const res = await AuthService.login(user);
      // Протестировать реактивность
      _user = JSON.parse(localStorage.getItem("user"));
      isLogged.value = true;
      return res;
    } catch (error) {
      return Promise.reject(error);
    }
  }

  async function logout() {
    try {
      const res = await AuthService.logout();
      isLogged.value = false;
      return res;
    } catch (error) {
      return Promise.reject(error);
    }
  }

  return { isLogged, user, login, logout };
});
