<template>
  <div class="container flex justify-between px-8 py-4">
    <div class="mr-8">
      <ProfileCard :identity="identity" />
      <UserCollection title="Friends" :collection="friends" class="mt-4" />
    </div>
    <div class="flex flex-col flex-1">
      <PostForm />
      <div v-for="post in posts" class="w-full h-32 bg-white shadow-sm rounded-lg mt-4"></div>
    </div>
    <div class="ml-8">
      <Gallery title="Gallery" :images="images" />
    </div>
  </div>
</template>

<script>
import ProfileCard from '@/components/profile/ProfileCard.vue'
import UserCollection from '@/components/profile/UserCollection.vue'
import PostForm from '@/components/shared/PostForm.vue'
import Gallery from '@/components/shared/Gallery.vue'

export default {
  layout: 'profile',
  validate({ params }) {
    return /^\d+/.test(params.id)
  },
  components: {
    ProfileCard,
    PostForm,
    Gallery,
    UserCollection
  },
  data() {
    return {
      friends: [1, 2, 3, 4, 5, 6, 7, 8, 9],
      images: [1, 2, 3, 4, 5, 6, 7, 8, 9],
      posts: [1, 2, 3, 4, 5, 6, 7, 8, 9],
      identity: {
        displayName: 'John Doe',
        metadata: 'Joined May 4th, 2020'
      }
    }
  }
}
</script>

<style>
</style>
