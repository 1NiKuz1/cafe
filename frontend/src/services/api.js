import axios from "axios";

const instance = axios.create({
  baseURL: "http://sxpbfdd-m2.wsr.ru/api-cafe",
  headers: {
    "Content-Type": "application/json",
  },
});

export default instance;
