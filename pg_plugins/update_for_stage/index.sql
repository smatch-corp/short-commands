START TRANSACTION;
TRUNCATE TABLE smatch.notification;
-- UPDATE "user" u1
-- SET "phone_number" = '010XXXXXXXX', "email" = REGEXP_REPLACE(u2.email, '.....$', 'XXXXX')
-- FROM "user" u2
-- WHERE u1.user_id = u2.user_id
--     AND u1."phone_number"
--     NOT IN ('010EXAMPLE');
-- UPDATE "customer" c1
-- SET "phone" = '010XXXXXXXX', "email" = REGEXP_REPLACE(c2.email, '.....$', 'XXXXX')
-- FROM "customer" c2
-- WHERE c1.user_id = c2.user_id
--     AND c1."phone"
--     NOT IN ('010EXAMPLE');
COMMIT;
