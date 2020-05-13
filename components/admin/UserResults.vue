<template>
  <div class="flex flex-col">
    <div v-if="!focusedUser">
      <div
        v-for="user in filteredUsers"
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
        <h1 class="font-bold my-2">Recent Posts:</h1>
        <div class="flex flex-col">
          <div v-for="post in focusedUser.posts" class="flex h-24 shadow-md bg-white mb-4">
            <img class="h-24 w-24" :src="post.url" />
            <div class="flex flex-col p-4">{{ post.caption }}</div>
          </div>
        </div>
      </div>
      <div class="flex flex-col">
        <h1 class="font-bold my-2">Recent Comments:</h1>
        <div class="flex flex-col">
          <div
            v-for="comment in focusedUser.comments"
            class="flex flex-col h-24 shadow-md bg-white mb-4 p-4 rounded-lg"
          >
            <span>{{ comment.comment }}</span>
            <small class="text-gray-500">{{ formatDate(comment.c_date) }}</small>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { formatRelative } from 'date-fns'

export default {
  props: {
    users: Array,
    searchString: String
  },
  computed: {
    filteredUsers() {
      if (this.searchString) {
        return this.users.filter(user =>
          `${user.fname} ${user.lname}`.includes(this.searchString)
        )
      }
      return this.users
    },
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
    formatDate(date) {
      return formatRelative(new Date(date), new Date())
    },
    async focusUser(user) {
      try {
        const profileUrl = `/api/users/${user.user_id}/profile`
        const friendsUrl = `/api/users/${user.user_id}/friends`
        const postsUrl = `/api/users/${user.user_id}/posts`
        const commentsUrl = `/api/users/${user.user_id}/comments`

        const profileResult = await this.$axios.$get(profileUrl)
        const friendsResult = await this.$axios.$get(friendsUrl)
        const postsResult = await this.$axios.$get(postsUrl)
        const commentsResult = await this.$axios.$get(commentsUrl)

        this.previousUsers.push(this.focusedUser)
        this.focusedUser = {
          ...user,
          ...profileResult.data[0],
          friends: friendsResult.data,
          posts: postsResult.data,
          comments: commentsResult.data
        }

        console.log(this.focusedUser)
      } catch (e) {
        console.log(e)
      }
    },

    async focusFriend(friend) {
      try {
        const url = `/api/users/${friend.user_id}`
        const profileUrl = `/api/users/${friend.user_id}/profile`
        const friendsUrl = `/api/users/${friend.user_id}/friends`
        const postsUrl = `/api/users/${friend.user_id}/posts`
        const commentsUrl = `/api/users/${friend.user_id}/comments`

        const userResult = await this.$axios.$get(url)
        const profileResult = await this.$axios.$get(profileUrl)
        const friendsResult = await this.$axios.$get(friendsUrl)
        const postsResult = await this.$axios.$get(postsUrl)
        const commentsResult = await this.$axios.$get(commentsUrl)

        this.previousUsers.push(this.focusedUser)
        this.focusedUser = {
          ...userResult.data[0],
          ...profileResult.data[0],
          friends: friendsResult.data,
          posts: postsResult.data,
          comments: commentsResult.data
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
