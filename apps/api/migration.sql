-- Wstawianie firm
INSERT INTO "Company" (id, name, description, address, website, "phoneNumber", "createdAt", "updatedAt", "isActive")
VALUES 
  (gen_random_uuid(), 'TechCorp Solutions', 'Innovative technology solutions provider', '123 Tech Street, Silicon Valley', 'www.techcorp.com', '+1 (555) 123-4567', NOW(), NOW(), true),
  (gen_random_uuid(), 'Green Energy Inc', 'Sustainable energy solutions', '456 Green Avenue, Solar City', 'www.greenenergy.com', '+1 (555) 234-5678', NOW(), NOW(), true),
  (gen_random_uuid(), 'Digital Marketing Pro', 'Digital marketing and branding experts', '789 Digital Lane, Web City', 'www.digitalmarketingpro.com', '+1 (555) 345-6789', NOW(), NOW(), true);

-- Wstawianie pracowników dla TechCorp Solutions
WITH company1 AS (SELECT id FROM "Company" WHERE name = 'TechCorp Solutions')
INSERT INTO "User" (id, email, password, "firstName", "lastName", role, position, "phoneNumber", "createdAt", "updatedAt", "isActive", department, "companyId")
VALUES
  (gen_random_uuid(), 'head.admin@techcorp.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'John', 'Doe', 'HEAD_ADMIN', 'Director', '+1 (555) 111-1111', NOW(), NOW(), true, 'IT', (SELECT id FROM company1)),
  (gen_random_uuid(), 'admin@techcorp.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Jane', 'Smith', 'ADMIN', 'Team Lead', '+1 (555) 111-2222', NOW(), NOW(), true, 'Marketing', (SELECT id FROM company1)),
  (gen_random_uuid(), 'manager@techcorp.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Mike', 'Johnson', 'MANAGER', 'Senior Specialist', '+1 (555) 111-3333', NOW(), NOW(), true, 'Sales', (SELECT id FROM company1)),
  (gen_random_uuid(), 'employee@techcorp.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Sarah', 'Wilson', 'EMPLOYEE', 'Specialist', '+1 (555) 111-4444', NOW(), NOW(), true, 'HR', (SELECT id FROM company1)),
  (gen_random_uuid(), 'readonly@techcorp.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Tom', 'Brown', 'READONLY', 'Junior Specialist', '+1 (555) 111-5555', NOW(), NOW(), true, 'Operations', (SELECT id FROM company1));

-- Wstawianie pracowników dla Green Energy Inc
WITH company2 AS (SELECT id FROM "Company" WHERE name = 'Green Energy Inc')
INSERT INTO "User" (id, email, password, "firstName", "lastName", role, position, "phoneNumber", "createdAt", "updatedAt", "isActive", department, "companyId")
VALUES
  (gen_random_uuid(), 'head.admin@greenenergy.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Robert', 'Green', 'HEAD_ADMIN', 'Director', '+1 (555) 222-1111', NOW(), NOW(), true, 'IT', (SELECT id FROM company2)),
  (gen_random_uuid(), 'admin@greenenergy.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Emma', 'Davis', 'ADMIN', 'Team Lead', '+1 (555) 222-2222', NOW(), NOW(), true, 'Marketing', (SELECT id FROM company2)),
  (gen_random_uuid(), 'manager@greenenergy.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'David', 'Miller', 'MANAGER', 'Senior Specialist', '+1 (555) 222-3333', NOW(), NOW(), true, 'Sales', (SELECT id FROM company2)),
  (gen_random_uuid(), 'employee@greenenergy.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Lisa', 'Taylor', 'EMPLOYEE', 'Specialist', '+1 (555) 222-4444', NOW(), NOW(), true, 'HR', (SELECT id FROM company2)),
  (gen_random_uuid(), 'readonly@greenenergy.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Chris', 'Anderson', 'READONLY', 'Junior Specialist', '+1 (555) 222-5555', NOW(), NOW(), true, 'Operations', (SELECT id FROM company2));

-- Wstawianie pracowników dla Digital Marketing Pro
WITH company3 AS (SELECT id FROM "Company" WHERE name = 'Digital Marketing Pro')
INSERT INTO "User" (id, email, password, "firstName", "lastName", role, position, "phoneNumber", "createdAt", "updatedAt", "isActive", department, "companyId")
VALUES
  (gen_random_uuid(), 'head.admin@digitalmarketingpro.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Mark', 'Digital', 'HEAD_ADMIN', 'Director', '+1 (555) 333-1111', NOW(), NOW(), true, 'IT', (SELECT id FROM company3)),
  (gen_random_uuid(), 'admin@digitalmarketingpro.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Sophie', 'White', 'ADMIN', 'Team Lead', '+1 (555) 333-2222', NOW(), NOW(), true, 'Marketing', (SELECT id FROM company3)),
  (gen_random_uuid(), 'manager@digitalmarketingpro.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Peter', 'Black', 'MANAGER', 'Senior Specialist', '+1 (555) 333-3333', NOW(), NOW(), true, 'Sales', (SELECT id FROM company3)),
  (gen_random_uuid(), 'employee@digitalmarketingpro.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'Anna', 'Gray', 'EMPLOYEE', 'Specialist', '+1 (555) 333-4444', NOW(), NOW(), true, 'HR', (SELECT id FROM company3)),
  (gen_random_uuid(), 'readonly@digitalmarketingpro.com', '$2b$10$xLrv0mXUVE4WqXUVzwQYz.4Ry9H1h3nJH1h3h3h3h3h3h3h3h3h', 'James', 'Blue', 'READONLY', 'Junior Specialist', '+1 (555) 333-5555', NOW(), NOW(), true, 'Operations', (SELECT id FROM company3));

-- Ustawienie head adminów dla firm
WITH 
  company1 AS (SELECT id FROM "Company" WHERE name = 'TechCorp Solutions'),
  company2 AS (SELECT id FROM "Company" WHERE name = 'Green Energy Inc'),
  company3 AS (SELECT id FROM "Company" WHERE name = 'Digital Marketing Pro'),
  head1 AS (SELECT id FROM "User" WHERE email = 'head.admin@techcorp.com'),
  head2 AS (SELECT id FROM "User" WHERE email = 'head.admin@greenenergy.com'),
  head3 AS (SELECT id FROM "User" WHERE email = 'head.admin@digitalmarketingpro.com')
UPDATE "Company" c
SET "headAdminId" = CASE 
  WHEN c.name = 'TechCorp Solutions' THEN (SELECT id FROM head1)
  WHEN c.name = 'Green Energy Inc' THEN (SELECT id FROM head2)
  WHEN c.name = 'Digital Marketing Pro' THEN (SELECT id FROM head3)
END
WHERE c.name IN ('TechCorp Solutions', 'Green Energy Inc', 'Digital Marketing Pro');

