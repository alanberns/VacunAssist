const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient()

async function main() {
	const paciente1 = await prisma.paciente.findUnique({
		where: {id:2}
	});

	if (paciente1){
		console.log('tiene contenido y dice true')
	}
}
	

main()
  .catch((e) => {
    throw e
  })
  .finally(async () => {
    await prisma.$disconnect()
  })