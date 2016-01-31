/* What was the highest original price in the Dillard’s database of the item with SKU 3631365? */
SELECT SKU, ORGPRICE
FROM TRNSACT
WHERE SKU='3631365'
ORDER BY ORGPRICE DESC;
/* Answer = 17,50$ */

/* What is the color of the Liz Claiborne brand item with the highest SKU # in the Dillard’s database
 (the Liz Claiborne brand is abbreviated “LIZ CLAI” in the Dillard’s database)? */
SELECT SKU, BRAND, COLOR
FROM SKUINFO
WHERE BRAND='LIZ CLAI'
ORDER BY SKU DESC;
/* Answer = TEAK CBO */

/* What is the sku number of the item in the Dillard’s database that had the highest original sales price? */
SELECT TOP 10 SKU, ORGPRICE
FROM TRNSACT
ORDER BY ORGPRICE DESC;
/* Answer = 6200173 */

/* According to the strinfo table, in how many states within the United States are Dillard’s stores located? */
SELECT DISTINCT state
FROM STRINFO;
/* Answer = 31 */

/* How many Dillard’s departments start with the letter “e” */
SELECT deptdesc
FROM DEPTINFO
WHERE deptdesc LIKE 'e%';
/* Answer = 5 */

/* What was the date of the earliest sale in the database where the sale price of the item did not equal the original 
price of the item, and what was the largest margin (original price minus sale price) of an item sold on that earliest date? */
SELECT TOP 10 saledate, sprice, orgprice
FROM TRNSACT
WHERE sprice <> orgprice
ORDER BY saledate ASC, orgprice-sprice DESC;
/* Answer = 04/08/01, $510.00 */

/* What register number made the sale with the highest original price and highest sale price between the dates of August 1, 2004
 and August 10, 2004? Make sure to sort by original price first and sale price second. */
 SELECT TOP 10 saledate, register, sprice, orgprice
FROM TRNSACT
WHERE saledate>'2004_07_31' AND saledate<'2004_08_11'
ORDER BY orgprice DESC , sprice DESC;
/* Answer = 621 */

/* Which of the following brand names with the word/letters “liz” in them exist in the Dillard’s database? Select all that apply. */
SELECT DISTINCT brand
FROM skuinfo
WHERE brand LIKE '%liz%';
/* Answer = BELIZA CIVILIZE */

/* What is the lowest store number of all the stores in the STORE_MSA table that are in the city of “little rock”,”Memphis”, or “tulsa”? */
SELECT store, city
FROM STORE_MSA
WHERE city IN ('little rock','Memphis','tulsa')
ORDER BY store ASC;
/* Answer = 504 */

