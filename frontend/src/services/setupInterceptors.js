import axiosInstance from "./api";
import TokenService from "./token.service";

const setup = () => {
  axiosInstance.interceptors.request.use(
    (config) => {
      const token = TokenService.getLocalAccessToken();
      if (token) {
        config.headers["x-access-token"] = token;
      }
      return config;
    },
    (error) => {
      return Promise.reject(error);
    }
  );

  //axiosInstance.interceptors.response.use(
  //  (res) => {
  //    return res;
  //  },
  //  async (err) => {
  //    return err;
  //  }
  //);
};

export default setup;
