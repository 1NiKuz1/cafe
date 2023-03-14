import api from "./api.js";

class AuthService {
  async login() {
    const res = await api.post("/", {});
    return res.data;
  }
}

export default new AuthService();
