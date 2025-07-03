/*
  Warnings:

  - You are about to drop the column `company` on the `Contact` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `Contact` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `Contact` table. All the data in the column will be lost.
  - You are about to drop the column `firstName` on the `Contact` table. All the data in the column will be lost.
  - You are about to drop the column `lastName` on the `Contact` table. All the data in the column will be lost.
  - You are about to drop the column `notes` on the `Contact` table. All the data in the column will be lost.
  - You are about to drop the column `phone` on the `Contact` table. All the data in the column will be lost.
  - You are about to drop the column `position` on the `Contact` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Contact` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Contact` table. All the data in the column will be lost.
  - You are about to drop the column `contactId` on the `Deal` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `Deal` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Deal` table. All the data in the column will be lost.
  - You are about to drop the column `notes` on the `Deal` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `Deal` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Deal` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Deal` table. All the data in the column will be lost.
  - You are about to drop the column `value` on the `Deal` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - The `role` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Added the required column `assignedToId` to the `Contact` table without a default value. This is not possible if the table is not empty.
  - Added the required column `createdById` to the `Contact` table without a default value. This is not possible if the table is not empty.
  - Added the required column `assignedToId` to the `Deal` table without a default value. This is not possible if the table is not empty.
  - Added the required column `createdById` to the `Deal` table without a default value. This is not possible if the table is not empty.
  - Added the required column `firstName` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lastName` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'MANAGER', 'EMPLOYEE', 'READONLY');

-- DropForeignKey
ALTER TABLE "Contact" DROP CONSTRAINT "Contact_userId_fkey";

-- DropForeignKey
ALTER TABLE "Deal" DROP CONSTRAINT "Deal_contactId_fkey";

-- DropForeignKey
ALTER TABLE "Deal" DROP CONSTRAINT "Deal_userId_fkey";

-- AlterTable
ALTER TABLE "Contact" DROP COLUMN "company",
DROP COLUMN "createdAt",
DROP COLUMN "email",
DROP COLUMN "firstName",
DROP COLUMN "lastName",
DROP COLUMN "notes",
DROP COLUMN "phone",
DROP COLUMN "position",
DROP COLUMN "updatedAt",
DROP COLUMN "userId",
ADD COLUMN     "assignedToId" TEXT NOT NULL,
ADD COLUMN     "createdById" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Deal" DROP COLUMN "contactId",
DROP COLUMN "createdAt",
DROP COLUMN "name",
DROP COLUMN "notes",
DROP COLUMN "status",
DROP COLUMN "updatedAt",
DROP COLUMN "userId",
DROP COLUMN "value",
ADD COLUMN     "assignedToId" TEXT NOT NULL,
ADD COLUMN     "createdById" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "name",
ADD COLUMN     "avatar" TEXT,
ADD COLUMN     "department" TEXT,
ADD COLUMN     "firstName" TEXT NOT NULL,
ADD COLUMN     "isActive" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "lastLoginAt" TIMESTAMP(3),
ADD COLUMN     "lastName" TEXT NOT NULL,
ADD COLUMN     "phoneNumber" TEXT,
ADD COLUMN     "position" TEXT,
DROP COLUMN "role",
ADD COLUMN     "role" "UserRole" NOT NULL DEFAULT 'EMPLOYEE';

-- DropEnum
DROP TYPE "DealStatus";

-- DropEnum
DROP TYPE "Role";

-- CreateTable
CREATE TABLE "Note" (
    "id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Note_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Deal" ADD CONSTRAINT "Deal_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Deal" ADD CONSTRAINT "Deal_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contact" ADD CONSTRAINT "Contact_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contact" ADD CONSTRAINT "Contact_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Note" ADD CONSTRAINT "Note_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
