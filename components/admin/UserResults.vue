<template>
  <div class="flex flex-col">
    <div v-if="!focusedUser">
      <div
        v-for="user in users"
        @click="focusUser(user)"
        class="shadow-md rounded-lg mb-2 p-4 bg-white hover:shadow-lg hover:bg-gray-200 cursor-pointer w-auto"
      >{{ user.fname }}, {{ user.lname }}</div>
    </div>
    <div v-else>
      <button
        class="flex justify-center py-2 px-4 border border-transparent text-sm leading-5 font-medium rounded-lg text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition duration-150 ease-in-out shadow-md mb-4"
        @click="unfocusUser"
      >Go Back To Results</button>
      <h1 class="text-lg font-bold text-gray-800">{{ focusedUser.lname }}, {{ focusedUser.fname }}</h1>
      <img
        v-if="focusedUser.profile"
        class="w-32 h-32 my-2"
        :src="focusedUser.profile.profile_photo"
      />
      <div class="flex flex-col">
        <h1 class="font-bold">They are friends with:</h1>
        <div class="flex flex-wrap">
          <div
            v-for="friend in focusedUser.friends"
            @click="focusFriend(friend)"
            class="h-12 w-auto bg-gray-300 rounded-lg font-medium text-gray-800 mr-2 mt-2 flex items-center justify-center p-4 cursor-pointer hover:bg-indigo-600 hover:text-white"
          >{{ friend.lname }}, {{ friend.fname }}</div>
        </div>
      </div>
      <div class="flex flex-col">
        <h1>Recent Posts:</h1>
        <div class="flex flex-col"></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    users: Array
  },
  data() {
    return {
      focusedUser: null
    }
  },
  methods: {
    async focusUser(user) {
      try {
        this.focusedUser = user
        const profileUrl = `/api/users/${user.user_id}/profile`
        const friendsUrl = `/api/users/${user.user_id}/friends`
        // const postsUrl = `/api/users/${user.user_id}/posts`

        const profileResult = await this.$axios.$get(profileUrl)
        const friendsResult = await this.$axios.$get(friendsUrl)
        // const postsResult = await this.$axios.$get(postsUrl)

        this.focusedUser.profile = profileResult.data[0]
        this.focusedUser.friends = friendsResult.data

        console.log(this.focusedUser)
      } catch (e) {
        console.log(e)
      }
    },

    async focusFriend(friend) {
      try {
        console.log(friend)
      } catch (e) {
        console.log(e)
      }
    },

    unfocusUser() {
      this.focusedUser = null
    }
  }
}
</script>

<style>
</style>
