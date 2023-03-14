<template>
  <div class="form-wrapper">
    <Form
      @submit="handlSubmit"
      :validation-schema="schema"
      class="form-container"
    >
      <div class="form-fields-wrapper">
        <label for="email" class="form-label">E-mail</label>
        <Field
          name="email"
          type="email"
          class="form-input p-inputtext p-component"
        />
        <ErrorMessage name="email" class="form-error" />
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
export default {
  components: {
    Field,
    Form,
    ErrorMessage,
    Button,
  },
  data() {
    return { errorMessage: "", isLoading: false };
  },
  computed: {
    schema() {
      return yup.object({
        email: yup
          .string()
          .trim()
          .required("Обязательное поле")
          .email("Не верный формат"),
        password: yup.string().trim().min(8).required("Обязательное поле"),
      });
    },
  },
  methods: {
    async handlSubmit(values) {
      console.log(values);
      this.isLoading = true;
      setTimeout(() => {
        this.errorMessage = "Error: Database was not found";
        this.showError();
      }, 2000);

      //try {
      //  await this.login({ email: values.email, password: values.password });
      //  this.$emit("hideDialog");
      //} catch (error) {
      //  this.errorMessage =
      //    (error.response &&
      //      error.response.data &&
      //      error.response.data.message) ||
      //    error.message ||
      //    error.toString();
      //  console.log(this.message);
      //}
      this.isLoading = false;
    },
    showError() {
      this.$toast.add({
        severity: "error",
        summary: "Error Message",
        detail: this.errorMessage,
        life: 5000,
      });
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
