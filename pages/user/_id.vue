<template>
  <div class="container flex justify-between px-8 py-4">
    <div class="mr-8">
      <ProfileCard :identity="identity" />
      <UserCollection title="Friends" :collection="friends" class="mt-4" />
    </div>
    <div class="flex flex-col flex-1">
      <PostForm class="mb-2" />
      <Posts
        v-for="post in posts"
        v-bind:p_id="post.id"
        v-bind:url="post.url"
        v-bind:caption="post.caption"
        v-bind:body="post.body"
        v-bind:date="post.date"
        :key="post.id"
      ></Posts>
    </div>
    <div class="ml-8">
      <Gallery title="Gallery" :photos="photos" />
    </div>
  </div>
</template>

<script>
import ProfileCard from '@/components/profile/ProfileCard.vue'
import UserCollection from '@/components/profile/UserCollection.vue'
import PostForm from '@/components/shared/PostForm.vue'
import Gallery from '@/components/profile/Gallery.vue'
import Posts from '@/components/shared/Posts.vue'

export default {
  validate({ params }) {
    return /^\d+/.test(params.id)
  },
  components: {
    ProfileCard,
    PostForm,
    Gallery,
    UserCollection,
    Posts
  },
  async created() {
    const { id } = this.$route.params

    const userUrl = `/api/users/${id}`
    const profileUrl = `/api/users/${id}/profile`
    const friendsUrl = `/api/users/${id}/friends`
    const photosUrl = `/api/users/${id}/photos`
    const postsUrl = `/api/users/${id}/posts`

    const userResult = await this.$axios.$get(userUrl)
    const postsResult = await this.$axios.$get(postsUrl)
    const profileResult = await this.$axios.$get(profileUrl)
    const friendsResult = await this.$axios.$get(friendsUrl)
    const photosResult = await this.$axios.$get(photosUrl)

    this.posts = postsResult.data
    this.photos = photosResult.data
    this.friends = friendsResult.data
    this.photos = photosResult.data

    const { fname, lname } = userResult.data[0]
    this.identity = {
      displayName: `${fname} ${lname}`,
      status: profileResult.data[0].status
    }
  },
  data() {
    return {
      friends: [],
      photos: [],
      posts: [],
      identity: {}
    }
  }
}
</script>

<style>
</style>
