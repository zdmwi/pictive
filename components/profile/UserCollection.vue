<template>
  <div class="shadow-md h-auto w-64 p-4 bg-white rounded-lg">
    <h1 class="text-gray-800 font-bold">{{ title }}</h1>
    <div class="flex flex-wrap justify-center items-center">
      <div v-for="item in collection" class="w-1/3 flex justify-center items-center">
        {{ item.user_id }}
        <img class="h-16 w-16 bg-gray-300 rounded-lg mt-2" :src="getUrl(item.user_id)" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: String,
    collection: Array
  },
  methods: {
    async getUrl(userId) {
      console.log(userId)
      const result = await this.$axios.$get(`/api/users/${userId}/profile`)
      console.log("RESULT:", result)
      return result.data[0].profile_photo
    }
  }
}
</script>

<style>
</style>
