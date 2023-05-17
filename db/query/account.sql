-- name: CreateAccount :one
INSERT INTO accounts (
  user_id,
  category_id,
  title,
  type,
  description
  value,
  date
) VALUES (
  $1, $2, $3, $4, $5, $6, $7
) RETURNING *;


-- name: GetAccount :one
SELECT * FROM accounts
WHERE id = $1 LIMIT 1;

-- name: GetAccounts :many
SELECT 
a.id,
a.user_id,
a.title,
a.type,
a.description,
a.value,
a.date,
a.created_at,

FROM accounts a
LEFT JOIN categories c ON c.id = a.category_id
WHERE a.user_id = $1
AND a.type = $2
AND a.category_id = $3
AND a.title like $4
AND a.description like $5
AND a.date = $6;

-- name: UpdateAccount :one
UPDATE accounts SET title = $2, description = $3 WHERE id = $1 RETURNING *;

-- name: DeleteAccount :exec
DELETE FROM accounts WHERE id = $1;
