SELECT code, COUNT(*) as count
FROM users
GROUP BY code
HAVING COUNT(*) > 1;

# in laravel way
$res = DB::select('select *, count(property_id) AS property_id_count from `favourite_properties` group by `property_id` order by property_id_count desc');


SELECT code, COUNT(*) as count
FROM users
GROUP BY code
HAVING COUNT(*) > 1;