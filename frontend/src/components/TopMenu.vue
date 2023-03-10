<template>
    <div class="card">
        <MegaMenu :model="items">
            <template #start>
                <p class="logo">Cafe</p>
            </template>
        </MegaMenu>
    </div>
</template>

<script>
import MegaMenu from 'primevue/megamenu';
export default {
    components: {
        MegaMenu,
    },
    data() {
        return {
            items: [
                {
                    label: 'Сотрудники',
                    to: '/',
                },
                {
                    label: 'Смены',
                    to: '/',
                },
                {
                    label: 'Заказы',
                    to: '/',
                },
                {
                    label: 'Вход',
                    to: '/',
                },
                {
                    label: 'Выход',
                    to: '/',
                },
            ]
        }
    },
}
</script>

<style scoped>
.logo {
    font-size: 24px;
    font-weight: 700;
    margin: 0 40px;
    color: var(--color-accent);
}
</style>