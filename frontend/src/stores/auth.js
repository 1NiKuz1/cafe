import { ref, computed, reactive, readonly } from 'vue'
import { defineStore } from 'pinia'
import TokenService from "@/services/token.service.js"
import AuthService from "@/services/auth.service.js"

export const useAuthStore = defineStore('auth', () => {
  let token = ref(TokenService.getToken() ?? null);
  let user = readonly({token});
  let isLogged = ref(user.token ? true : false);

  async function login(user) {
    try {
      const res = await AuthService.login(user);
      token.value = TokenService.getToken();
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

  return { isLogged, user, login, logout }
})
