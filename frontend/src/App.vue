<template>
  <TopMenu></TopMenu>
  <RouterView />
</template>

<script>
import { RouterLink, RouterView } from "vue-router";
import TopMenu from "@/components/TopMenu.vue"
export default {
  components: {
    TopMenu
  },
  data() {
    return {
      
    }
  },
}
</script>

<style scoped></style>
