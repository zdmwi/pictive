<template>
  <div class="container flex justify-between px-8 py-4">
    <div class="mr-8">
      <ProfileCard />
      <FriendCollection class="mt-4" />
    </div>
    <div class="flex flex-col flex-1">
      <PostForm />
      <div
        v-for="num in [1,2,3,4,5,6,7,8,9]"
        class="w-full h-32 bg-white shadow-sm rounded-lg mt-4"
      ></div>
    </div>
    <div class="ml-8">
      <Gallery />
    </div>
  </div>
</template>

<script>
import ProfileCard from '@/components/profile/ProfileCard.vue'
import FriendCollection from '@/components/profile/FriendCollection.vue'
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
    FriendCollection
  }
}
</script>

<style>
</style>
