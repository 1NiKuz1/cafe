<template>
  <div class="form-wrapper">
    <Form
      @submit="handlSubmit"
      :validation-schema="schema"
      class="form-container"
    >
      <div class="form-fields-wrapper">
        <label for="login" class="form-label">Логин</label>
        <Field
          name="login"
          type="text"
          class="form-input p-inputtext p-component"
        />
        <ErrorMessage name="login" class="form-error" />
      </div>

      <div class="form-fields-wrapper">
        <label for="password" class="form-label">Пароль</label>
        <Field
          name="password"
          type="password"
          class="form-input p-inputtext p-component"
        />
        <ErrorMessage name="password" class="form-error" />
      </div>

      <Button
        :disabled="isLoading"
        label="Submit"
        class="form-button"
        type="submit"
      />
    </Form>
  </div>
  <Toast class="p-toast-bottom-right" />
</template>

<script>
import { Field, Form, ErrorMessage } from "vee-validate";
import * as yup from "yup";
import Button from "primevue/button";
import { useAuthStore } from "@/stores/auth";
export default {
  components: {
    Field,
    Form,
    ErrorMessage,
    Button,
  },
  setup() {
    const auth = useAuthStore();
    const { login } = auth;
    return {
      login,
    }
  },
  data() {
    return { serverError: "", isLoading: false };
  },
  computed: {
    schema() {
      return yup.object({
        login: yup
          .string()
          .trim()
          .required("Обязательное поле"),
        password: yup.string().trim().min(1).required("Обязательное поле"),
      });
    },
  },
  methods: {
    async handlSubmit(values) {
      this.isLoading = true;
      try {
        await this.login({ login: values.login, password: values.password });
        this.showInfo();
      } catch (error) {
        this.serverError = error;
        this.showError();
      }
      this.isLoading = false;
    },
    showError() {
      this.$toast.add({
        severity: "error",
        summary: "Error message",
        detail: `Error code: ${this.serverError.code}
        Message: ${this.serverError.message}`,
        life: 5000,
      });
    },
    showInfo() {
        this.$toast.add({ severity: 'info', summary: 'Info Message', detail: 'User is authorized', life: 3000 });
    },
  },
};
</script>

<style scoped>
.form-wrapper {
  margin-top: 60px;
  display: flex;
  justify-content: center;
}
.form-container {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  min-width: 300px;
}

.form-fields-wrapper {
  display: flex;
  width: 100%;
  flex-direction: column;
  margin-bottom: 15px;
}
.form-label {
  margin-bottom: 10px;
}
.form-input {
  padding: 0.4rem 0.75rem;
  align-self: stretch;
}
.form-error {
  color: red;
}

.p-button {
  margin-top: 10px;
  padding: 0.4rem 1.25rem;
}
</style>
