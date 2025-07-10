-- Bonus SQL

-- 1. Trouver les 3 auteurs dont les livres ont généré le plus de chiffre d’affaires total.
SELECT a.first_name, a.last_name
FROM author a
JOIN book b ON a.author_id = b.author_id
JOIN customer_order co ON co.book_id = b.book_id
GROUP BY a.author_id
ORDER BY SUM(co.total_amount) DESC
LIMIT 3;

-- 2. Calculer le total des ventes par thème de livre, classé du plus au moins vendu (en montant).
SELECT t.theme_name, SUM(co.total_amount)
FROM theme t
JOIN book b ON t.theme_id = b.theme_id
JOIN customer_order co ON b.book_id = co.book_id
GROUP BY t.theme_id
ORDER BY SUM(co.total_amount) DESC;

-- 3. Afficher pour chaque mois de l’année 2024 le nombre de commandes passées et le chiffre d’affaires total.
SELECT strftime('%m', order_date), COUNT(order_id), SUM(total_amount)
FROM customer_order WHERE strftime('%Y', order_date) = '2024'
GROUP BY strftime('%m', order_date);

-- 4. Pour chaque auteur, calculer la moyenne des notes des livres écrits, y compris les auteurs dont livres n’ont pas encore d’avis (afficher NULL dans ce cas).
SELECT a.first_name, a.last_name, AVG(r.rating)
FROM author a
JOIN book b ON a.author_id = b.author_id
LEFT JOIN review r ON b.book_id = r.book_id
GROUP BY a.author_id;

-- 5. Afficher les commandes les plus récentes pour chaque client (1 commande max par client).
SELECT c.email, co.order_id, co.book_id, MAX(co.order_date)
FROM customer c
JOIN customer_order co ON c.customer_id = co.customer_id
GROUP BY c.customer_id;