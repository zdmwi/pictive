<template>
  <div class="shadow-md h-auto w-64 p-4 bg-white rounded-lg">
    <h1 class="text-gray-800 font-bold">{{ title }}</h1>
    <div class="flex flex-wrap justify-center items-center">
      <nuxt-link
        v-for="(item, index) in collection"
        :key="index"
        :to="'/user/' + item.user_id"
        class="w-1/3 flex justify-center items-center"
      >
        <img class="h-16 w-16 bg-gray-300 rounded-lg mt-2" :src="item.profile_photo" />
      </nuxt-link>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: String,
    collection: Array
  }
}
</script>

<style>
</style>
