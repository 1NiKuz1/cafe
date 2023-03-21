<template>
  <Form
    @submit="handlSubmit"
    :validation-schema="schema"
    class="form-container"
    id="formElem"
  >
    <div class="form-fields-wrapper">
      <label for="name" class="form-label">Имя</label>
      <Field name="name" type="text" class="p-inputtext p-component" />
      <ErrorMessage name="name" class="form-error" />
    </div>

    <div class="form-fields-wrapper">
      <label for="login" class="form-label">Логин</label>
      <Field name="login" type="text" class="p-inputtext p-component" />
      <ErrorMessage name="login" class="form-error" />
    </div>

    <div class="form-fields-wrapper">
      <label for="password" class="form-label">Пароль</label>
      <Field name="password" type="password" class="p-inputtext p-component" />
      <ErrorMessage name="password" class="form-error" />
    </div>

    <div class="form-fields-wrapper">
      <label for="photo" class="form-label">Фото</label>
      <FileUpload
        mode="basic"
        name="photo"
        accept="image/png, image/jpeg, image/jpg"
        ref="imageInput"
        :maxFileSize="1000000"
      />
      <ErrorMessage name="photo" class="form-error" />
    </div>

    <div class="form-fields-wrapper">
      <label for="role" class="form-label">Роль</label>
      <Dropdown
        name="role"
        v-model="selectedRole"
        :options="roles"
        optionLabel="name"
        placeholder="Выбор роли"
        class="w-full md:w-14rem"
      />
      <ErrorMessage name="role" class="form-error" />
    </div>

    <Button
      :disabled="isLoading"
      class="form-button"
      label="Добавить"
      type="submit"
    />
  </Form>
</template>

<script>
import { Field, Form, ErrorMessage } from "vee-validate";
import * as yup from "yup";
import Button from "primevue/button";
import Dropdown from "primevue/dropdown";
import FileUpload from "primevue/fileupload";
import UserService from "@/services/user.service.js";
import useShowError from "../composables/useShowError.js";

export default {
  name: "AddNewEmployee",
  emits: ["addNewEmployee"],
  components: {
    Field,
    Form,
    ErrorMessage,
    Button,
    Dropdown,
    FileUpload,
  },
  data() {
    return {
      isLoading: false,
      selectedRole: { name: "Администратор", id: "1" },
      roles: [
        { name: "Администратор", id: "1" },
        { name: "Официант", id: "2" },
        { name: "Повар", id: "3" },
      ],
    };
  },
  computed: {
    schema() {
      return yup.object({
        name: yup.string().trim().required("Обязательное поле"),
        login: yup.string().trim().required("Обязательное поле"),
        password: yup.string().trim().min(1).required("Обязательное поле"),
      });
    },
  },
  methods: {
    showError(err) {
      useShowError(err, this);
    },
    async handlSubmit(values) {
      //const photo = this.$refs.imageInput.files[0];
      const role = this.selectedRole.id;
      //if (!photo) return;
      //values.file = photo;
      values.role_id = role;
      this.isLoading = true;
      try {
        await UserService.createUser(values);
        this.$emit("addNewEmployee");
      } catch (error) {
        this.showError(error);
      }
      this.isLoading = false;
    },
  },
};
</script>

<style scoped>
.form-container {
  display: flex;
  flex-direction: column;
}

.form-fields-wrapper {
  display: flex;
  flex-direction: column;
  margin-bottom: 10px;
}
.form-error {
  color: red;
}

.form-label {
  margin-bottom: 5px;
}

.form-button {
  align-self: flex-start;
  margin-top: 20px;
}
</style>
