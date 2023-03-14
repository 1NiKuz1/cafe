import { createApp } from "vue";
import { createPinia } from "pinia";

import App from "./App.vue";
import router from "./router";

import "bootstrap/dist/css/bootstrap.css"; //bootstrap
//primevue
import "primevue/resources/themes/lara-light-indigo/theme.css"; //theme
import "primevue/resources/primevue.min.css"; //core
import "primeicons/primeicons.css"; //icons
//styles
import "./assets/main.css";

import PrimeVue from "primevue/config";
import Toast from "primevue/toast";
import ToastService from "primevue/toastservice";

import setupInterceptors from "./services/setupInterceptors";

const app = createApp(App);

app.use(createPinia());
app.use(router);
app.use(PrimeVue);
app.use(ToastService);

app.component("Toast", Toast);

app.mount("#app");
setupInterceptors();
