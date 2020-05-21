<template>
  <div class="shadow-md h-64 w-64 p-4 bg-white flex flex-col items-center justify-center rounded-lg">

    <h1 class="text-lg font-bold text-gray-800">{{ identity.name}}</h1>
    <div class="my-5" v-if="!isOwner && !isInGroup">
      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        @click="joinGroup()"
      >
        Join Group!
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    identity: Object,
    isInGroup: Boolean
  },
  data () {
    return {
      edit: false
    }
  },
  computed: {
    isOwner () {
      return this.identity && process.browser ? parseInt(this.identity.id) == localStorage.getItem('user') : false
    },
  },
  methods: {
    async joinGroup() {
      const group_id = this.identity.group_id;
      const user_id = localStorage.getItem('user');
      try {
        const results = await this.$axios.get(`/api/groups/${group_id}/users/${user_id}`)
      } catch (e) {
        console.error(e);
      }

    }
  }
}
</script>

<style>
</style>
