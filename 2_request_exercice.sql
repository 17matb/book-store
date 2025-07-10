-- 1. Affichez la somme totale des stocks de livres.
SELECT SUM(stock) AS 'Somme totale des stocks de livres' FROM book;

-- 2. Affichez pour chaque auteur le nombre de livres écrits.
SELECT a.first_name, a.last_name, COUNT(b.book_id) FROM author a JOIN book b ON a.author_id = b.author_id GROUP BY a.author_id;

-- 3. Affichez le titre du livre, nom complet de l’auteur, et nom du thème.
SELECT b.title, a.first_name, a.last_name, t.theme_name FROM book b JOIN author a ON b.author_id = a.author_id JOIN theme t ON b.theme_id = t.theme_id;

-- 4. Affichez toutes les commandes d’un client donné avec titre du livre et date de commande.
SELECT b.title, co.order_date FROM book b JOIN customer_order co ON b.book_id = co.book_id JOIN customer c ON co.customer_id = c.customer_id WHERE c.customer_id = 1; /* si l'on veut afficher les commandes d'un client donné, on cherche son customer_id */

-- 5. Affichez la moyenne des notes pour chaque livre ayant au moins 3 avis.
SELECT b.title, AVG(r.rating)
FROM book b
JOIN review r ON b.book_id = r.book_id
GROUP BY b.book_id, b.title
HAVING COUNT(r.book_id) >= 3;

-- 6. Affichez le nombre total de commandes passées par chaque client (email+nb commandes.
SELECT c.email, COUNT(co.customer_id)
FROM customer c
JOIN customer_order co ON c.customer_id = co.customer_id
GROUP BY c.customer_id;

-- 7. Affichez les titres des livres qui n’ont jamais été commandés.
SELECT b.title
FROM book b
LEFT JOIN customer_order co ON b.book_id = co.book_id
WHERE co.book_id IS NULL;

-- 8. Affichez le chiffre d’affaires total généré par chaque auteur (somme des prix des livres commandés).
SELECT a.first_name, a.last_name, SUM(co.total_amount)
FROM author a
JOIN book b ON a.author_id = b.author_id
JOIN customer_order co ON b.book_id = co.book_id
GROUP BY a.author_id;
