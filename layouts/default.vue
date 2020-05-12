<template>
<div>
  <Header></Header>
  <div class="text-white flex justify-center items-center">
    <nuxt />
  </div>
</div>
</template>

<script>
import Header from '@/components/Header.vue'

export default {
  components: {
    Header
  }
}
</script>

<style>
</style>
