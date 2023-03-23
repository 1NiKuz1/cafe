export default {
  methods: {
    showError(err) {
      this.$toast.add({
        severity: "error",
        summary: err.code ? `Error ${err.code}` : `Error Message`,
        detail: `Message: ${err.message}`,
        life: 5000,
      });
    },
  },
};
