import axios from "axios";

const BASE_URL = "http://sxpbfdd-m2.wsr.ru/api-cafe";
// const BASE_URL = "http://cafe/api-cafe";

const instance = axios.create({
  baseURL: BASE_URL,
  headers: {
    "Content-Type": "application/json",
  },
});

export default instance;
