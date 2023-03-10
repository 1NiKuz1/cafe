import { createApp } from "vue";
import { createPinia } from "pinia";

import App from "./App.vue";
import router from "./router";

//styles
import "./assets/main.css";
import "bootstrap/dist/css/bootstrap.css"; //bootstrap
//primevue
import "primevue/resources/themes/lara-light-indigo/theme.css"; //theme
import "primevue/resources/primevue.min.css"; //core
import "primeicons/primeicons.css"; //icons

const app = createApp(App);

app.use(createPinia());
app.use(router);

app.mount("#app");
