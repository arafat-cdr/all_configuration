select *, count(property_id) AS property_id_count from `favourite_properties` group by `property_id` order by property_id_count desc

-- You must need to turn off strick mode if u get any errors here