import api from "./api.js";
import TokenService from "./token.service.js"

class AuthService {
  async login({login, password}) {
    try {
      const res = await api.post("/login", {login, password});
      console.log(res.data.data.user_token)
      // TokenService.setUser(res.data.data);
      return res.data.data;
    } catch(error) {
      return Promise.reject(error?.response?.data?.error);
    }
    
  }

  async logout() {
    try {
      const res = await api.get("/logout");
      TokenService.removeUser()
      return res.data;
    } catch(error) {
      return Promise.reject(error);
    }
    
  }
}

export default new AuthService();
