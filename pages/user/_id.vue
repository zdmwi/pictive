<template>
  <div class="container flex justify-between px-8 py-4">
    <div class="mr-8">
      <ProfileCard :identity="identity" />
      <UserCollection title="Friends" :collection="friends" class="mt-4" />
    </div>
    <div class="flex flex-col flex-1">
      <PostForm v-if="isUser" class="mb-2" />
      <Posts
        v-for="post in posts"
        :fname="fname"
        :lname="lname"
        :p_id="post.id"
        :url="post.url"
        :caption="post.caption"
        :body="post.body"
        :date="post.date"
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
    console.log(profileResult)
    const { fname, lname } = userResult.data[0]
    this.fname = fname
    this.lname = lname
    this.identity = {
      id: profileResult.data[0].user_id,
      displayName: `${fname} ${lname}`,
      photo: profileResult.data[0].profile_photo,
      status: profileResult.data[0].status
    }
  },
  mounted() {
    const userId = localStorage.getItem('user') || 1
    this.isUser = parseInt(userId) === parseInt(this.$route.params.id)
  },
  data() {
    return {
      friends: [],
      photos: [],
      posts: [],
      identity: {},
      isUser: false,
      fname: '',
      lname: ''
    }
  }
}
</script>

<style>
</style>
