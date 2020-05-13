<template>
  <div class="flex flex-col">
    <div
      v-for="user in users"
      @click="emitFocusUser(user.id)"
      class="shadow-md rounded-lg mb-2 p-4 bg-white hover:shadow-lg hover:bg-gray-200 cursor-pointer"
    >{{ user.fname }}, {{ user.lname }}</div>
  </div>
</template>

<script>
export default {
  props: {
    users: Array
  },
  methods: {
    async emitFocusUser(userId) {
      try {
        const result = await this.$axios.$get(`/api/users/${userId}`)
        this.$emit('focus-user', result.data)
        console.log(result)
      } catch (e) {
        console.log(e)
      }
    }
  }
}
</script>

<style>
</style>
