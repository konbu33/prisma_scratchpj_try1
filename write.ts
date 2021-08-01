import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

async function main() {
	await prisma.user.create({
		data: {
			name: 'Mike',
			email: 'mike@prisma.io',
			posts: {
				create: { title : 'Hello world' },
			},
			profile: {
				create: { bio: 'I like turtles' },
			},
		},
	})

	const allUsers = await prisma.user.findMany({
		include: {
			posts: true,
			profile: true,
		},
	})
	console.dir(allUsers, { depth: null } )
}

main()
	.catch( e => {
		throw e
	})
	.finally( async () => {
		await prisma.$disconnect()
	})


