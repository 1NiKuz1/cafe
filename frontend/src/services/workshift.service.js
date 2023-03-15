import api from "./api.js";

class WorkShiftService {
  async createWorkShift({ start, end }) {
    try {
      const res = await api.post("/work-shift", { start, end });
      return res.data.data;
    } catch (error) {
      return Promise.reject(error);
    }
  }

  async openWorkShift(id) {
    try {
      const res = await api.get(`/work-shift/${id}/open`);
      return res.data.data;
    } catch (error) {
      return Promise.reject(error);
    }
  }

  async closeWorkShift(id) {
    try {
      const res = await api.get(`/work-shift/${id}/close`);
      return res.data.data;
    } catch (error) {
      return Promise.reject(error);
    }
  }

  async addUserOnWorkShift({ id, user_id }) {
    try {
      const res = await api.post(`/work-shift/${id}/user`, { user_id });
      return res.data.data;
    } catch (error) {
      return Promise.reject(error);
    }
  }

  async showOrderByWorkShift(id) {
    try {
      const res = await api.get(`/work-shift/${id}/order`);
      return res.data;
    } catch (error) {
      return Promise.reject(error);
    }
  }
}

export default new WorkShiftService();
