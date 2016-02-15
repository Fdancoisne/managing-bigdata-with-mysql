/* Exercise 1: (a) Use COUNT and DISTINCT to determine how many distinct skus there are
 in the skuinfo, skstinfo, and trnsact tables. Which skus are common to all tables,
  or unique to specific tables? */
SELECT COUNT(DISTINCT sku)
FROM skstinfo;
/* 760212 */
SELECT COUNT(DISTINCT sku)
FROM skuinfo;
/* 1564178 */
SELECT COUNT(DISTINCT sku)
FROM trnsact;
/* 714499 */
SELECT DISTINCT a.sku
FROM SKSTINFO a, SKUINFO b, TRNSACT c
WHERE a.sku = b.sku
AND a.sku = c.sku;

/* (b) Use COUNT to determine how many instances there are of each sku associated with each
 store in the skstinfo table and the trnsact table? */
 SELECT sku, store, COUNT (sku)
FROM TRNSACT
GROUP BY store, sku;
SELECT sku, store, COUNT (sku)
FROM SKSTINFO
GROUP BY store, sku;

/* Exercise 2: Use COUNT and DISTINCT to determine how many distinct stores there are in the
 strinfo, store_msa, skstinfo, and trnsact tables. Which stores are common to all tables, or
  unique to specific tables? */
SELECT COUNT(DISTINCT store)
FROM strinfo;
/* 453 */
SELECT COUNT(DISTINCT store)
FROM store_msa;
/* 333 */
SELECT COUNT(DISTINCT store)
FROM skstinfo;
/* 357 */
SELECT COUNT(DISTINCT store)
FROM trnsact;
/* 332 */
SELECT DISTINCT a.store
FROM strinfo a, store_msa b, skstinfo c, trnsact d
WHERE a.store = b.store
AND a.store = c.store
AND a.store = d.store;

/*
Exercise 3: It turns out that there are many skus in the trnsact table that are not skstinfo
 table. As a consequence, we will not be able to complete many desirable analyses of Dillard’s
 profit, as opposed to revenue, because we do not have the cost information for all the skus
 in the transact table. Examine some of the rows in the trnsact table that are not in the
 skstinfo table...can you find any common features that could explain why the cost 
 information is missing? */
SELECT TOP 10 *
FROM trnsact a, skstinfo b 
WHERE a.sku <> b.sku;
















