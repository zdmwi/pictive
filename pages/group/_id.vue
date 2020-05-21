<template>
  <div class="container flex justify-between px-8 py-4">
    <div class="mr-8">
      <GroupInfoCard :identity="identity" :isInGroup="isInGroup"/>
      <UserCollection title="Group Members" :collection="groupMembers" class="mt-4" />
    </div>
    <div class="flex flex-col flex-1">
      <PostForm />
      <div v-for="post in posts" class="w-full h-32 bg-white shadow-sm rounded-lg mt-4"></div>
    </div>
    <div class="ml-8">
      <Gallery title="Group Photos" :photos="profilePhotos" />
    </div>
  </div>
</template>

<script>
import UserCollection from '@/components/profile/UserCollection.vue'
import PostForm from '@/components/shared/PostForm.vue'
import Gallery from '@/components/profile/Gallery.vue'
import GroupInfoCard from '@/components/group/GroupInfoCard.vue'

export default {
  validate({ params }) {
    return /^\d+/.test(params.id)
  },
  components: {
    GroupInfoCard,
    PostForm,
    Gallery,
    UserCollection
  },
  async created() {
    const { id } = this.$route.params

    const groupUrl = `/api/groups/${id}` // we get the user_id of creator
    const groupMembersUrl = `/api/groups/${id}/members` // we get the member ids

    const groupResult = await this.$axios.$get(groupUrl)
    const groupMemberResult = await this.$axios.$get(groupMembersUrl)

    this.groupMembers = groupMemberResult.data
    this.identity = groupResult.data

    const memberIds = this.groupMembers.map(m => m.user_id);
    const user_id = localStorage.getItem('user')
    console.log('user id ', user_id);
    console.log('meembers', memberIds)

    const fin = memberIds.includes(parseInt(user_id, 10));
    console.log('is member ', fin);

    this.isInGroup = fin
  },
  data() {
    return {
      groupMembers: [],
      profileImages: [1, 2, 3, 4, 5, 6, 7, 8, 9],
      isInGroup: false,
      posts: [1, 2, 3, 4, 5, 6, 7, 8, 9],
      identity: {
        displayName: 'Group 1',
        metadata: 'Created May 8th, 2020'
      }
    }
  }
}
</script>

<style>
</style>
