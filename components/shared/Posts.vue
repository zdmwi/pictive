<template>
  <div>
  <div
    class="rounded-lg bg-white h-auto overflow-hidden shadow-lg mb-4 cursor-pointer"
    @click="isOpen=true;"
  >
    <div class="flex justify-start px-6 pt-4">
      <div class="bg-gray-300 h-12 w-12 rounded-full cursor-pointer"></div>
      <p class="text-gray-800 text-sm leading-none pl-4 pt-4">{{fname}} {{lname}}</p>
      <p class="text-xs justify end ml-auto pt-4">{{date}}</p>
    </div>
    <div class="px-6 py-4">
      <p v-if="caption" class="text-gray-700 text-base">{{caption}}</p>
      <p v-else class="text-gray-700 text-base">{{body}}</p>
    </div>
    <img v-if="url" class="w-full h-64" :src="url" alt="Sunset in the mountains" />
  </div>
      <PostDetails
      v-bind:p_id="p_id"
      v-bind:url="url"
      v-bind:caption="caption"
      v-bind:body="body"
      v-bind:date="date"
      v-bind:fname="fname"
      v-bind:lname="lname"
      v-if="isOpen"
      @close="isOpen = false"
      ></PostDetails>
  </div>
</template>

<script>
import PostDetails from './PostDetails.vue'

export default {
  props: ['p_id', 'url', 'caption', 'body', 'date', 'fname', 'lname',],
  components: {
        PostDetails
    },
    data() {
        return {
            isOpen: false
        }
    }
}
</script>