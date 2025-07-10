-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('HEAD_ADMIN', 'ADMIN', 'MANAGER', 'EMPLOYEE', 'READONLY');

-- CreateTable
CREATE TABLE "Company" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "address" TEXT,
    "website" TEXT,
    "phoneNumber" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "headAdminId" TEXT,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "role" "UserRole" NOT NULL DEFAULT 'EMPLOYEE',
    "position" TEXT,
    "phoneNumber" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastLoginAt" TIMESTAMP(3),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "avatar" TEXT,
    "department" TEXT,
    "companyId" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Deal" (
    "id" TEXT NOT NULL,
    "assignedToId" TEXT NOT NULL,
    "createdById" TEXT NOT NULL,

    CONSTRAINT "Deal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contact" (
    "id" TEXT NOT NULL,
    "assignedToId" TEXT NOT NULL,
    "createdById" TEXT NOT NULL,

    CONSTRAINT "Contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Note" (
    "id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Note_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Company_name_key" ON "Company"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Company_headAdminId_key" ON "Company"("headAdminId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_headAdminId_fkey" FOREIGN KEY ("headAdminId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

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

-- Migrate existing data
DO $$
DECLARE
    v_company_name TEXT;
    v_company_id TEXT;
    v_first_user_id TEXT;
BEGIN
    -- For each unique company name
    FOR v_company_name IN 
        SELECT DISTINCT "companyName" 
        FROM "User" 
        WHERE "companyName" IS NOT NULL
    LOOP
        -- Check if company already exists
        SELECT id INTO v_company_id
        FROM "Company"
        WHERE name = v_company_name;
        
        -- If company doesn't exist, create it
        IF v_company_id IS NULL THEN
            v_company_id := gen_random_uuid();
            
            INSERT INTO "Company" (
                id, 
                name, 
                "createdAt", 
                "updatedAt", 
                "isActive"
            )
            VALUES (
                v_company_id,
                v_company_name,
                CURRENT_TIMESTAMP,
                CURRENT_TIMESTAMP,
                true
            );
            
            -- Get first user from this company to make them HEAD_ADMIN
            SELECT id INTO v_first_user_id
            FROM "User"
            WHERE "companyName" = v_company_name
            ORDER BY "createdAt"
            LIMIT 1;
            
            -- Update user role and company's headAdmin
            IF v_first_user_id IS NOT NULL THEN
                UPDATE "User"
                SET role = 'HEAD_ADMIN'
                WHERE id = v_first_user_id;
                
                UPDATE "Company"
                SET "headAdminId" = v_first_user_id
                WHERE id = v_company_id;
            END IF;
        END IF;
        
        -- Link all users to their company
        UPDATE "User"
        SET "companyId" = v_company_id
        WHERE "companyName" = v_company_name;
    END LOOP;
END $$; 