import api from "./api.js";

class UserService {
  async getUsers() {
    try {
      const res = await api.get("/user");
      return res.data.details;
    } catch (error) {
      return Promise.reject(error);
    }
  }

  async createUser({
    name,
    surname,
    patronymic,
    login,
    password,
    photo_file,
    role_id,
  }) {
    try {
      const res = await api.post("/user", {
        name,
        surname,
        patronymic,
        login,
        password,
        photo_file,
        role_id,
      });
      return res.data;
    } catch (error) {
      return Promise.reject(error);
    }
  }
}

export default new UserService();
