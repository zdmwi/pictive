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
      >{{ previousBtnText }}</button>
      <h1 class="text-lg font-bold text-gray-800">{{ focusedUser.lname }}, {{ focusedUser.fname }}</h1>
      <img class="w-32 h-32 my-2" :src="focusedUser.profile_photo" />
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
  computed: {
    previousBtnText() {
      const lastUser = this.previousUsers[this.previousUsers.length - 1]
      if (lastUser !== null) {
        return `Back to ${lastUser.lname}, ${lastUser.fname}`
      }
      return 'Go back to results'
    }
  },
  data() {
    return {
      focusedUser: null,
      previousUsers: []
    }
  },
  methods: {
    async focusUser(user) {
      try {
        const profileUrl = `/api/users/${user.user_id}/profile`
        const friendsUrl = `/api/users/${user.user_id}/friends`
        const textPostsUrl = `/api/users/${user.user_id}/texts`
        const photoPostsUrl = `/api/users/${user.user_id}/photos`

        const profileResult = await this.$axios.$get(profileUrl)
        const friendsResult = await this.$axios.$get(friendsUrl)
        const postsResult = await this.$axios.$get(textPostsUrl)
        const photosResult = await this.$axios.$get(photoPostsUrl)

        this.previousUsers.push(this.focusedUser)
        this.focusedUser = {
          ...user,
          ...profileResult.data[0],
          friends: friendsResult.data
        }

        console.log(this.focusedUser)

        console.log(postsResult, photosResult)
      } catch (e) {
        console.log(e)
      }
    },

    async focusFriend(friend) {
      try {
        const url = `/api/users/${friend.user_id}`
        const profileUrl = `/api/users/${friend.user_id}/profile`
        const friendsUrl = `/api/users/${friend.user_id}/friends`
        const textPostsUrl = `/api/users/${friend.user_id}/texts`
        const photoPostsUrl = `/api/users/${friend.user_id}/photos`

        const userResult = await this.$axios.$get(url)
        const profileResult = await this.$axios.$get(profileUrl)
        const friendsResult = await this.$axios.$get(friendsUrl)
        const postsResult = await this.$axios.$get(textPostsUrl)
        const photosResult = await this.$axios.$get(photoPostsUrl)

        this.previousUsers.push(this.focusedUser)
        this.focusedUser = {
          ...userResult.data[0],
          ...profileResult.data[0],
          friends: friendsResult.data
        }
      } catch (e) {
        console.log(e)
      }
    },

    unfocusUser() {
      const last = this.previousUsers.pop()
      this.focusedUser = last
    }
  }
}
</script>

<style>
</style>
