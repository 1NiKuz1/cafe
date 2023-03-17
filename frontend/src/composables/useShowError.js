export default function showError(err, context) {
  context.$toast.add({
    severity: "error",
    summary: err.code ? `Error ${err.code}` : `Error Message`,
    detail: `Message: ${err.message}`,
    life: 5000,
  });
}
