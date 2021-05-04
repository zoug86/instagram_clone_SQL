-- 1. find the 5 oldest users:

select username, created_at from users order by created_at limit 5;

-- 2. Most popular registration date:

select dayname(created_at) as days, count(*) as total from users group by days order by total desc limit 1;

-- 3. Inactive users: users with no photos:

select username from users left join photos on users.id = photos.user_id where image_url is null;

-- 4. The user with the most liked photo:

select username, image_url, count(*) as total from likes left join photos on likes.photo_id = photos.id left join users on photos.user_id = users.id group by photo_id order by total desc limit 1; 

-- 5. average user post:

select (select count(*) from photos) / (select count(*) from users) as average;

-- 6. top 5 most commonly used hashtags:

select tag_name, count(*) as total from tags left join photo_tags on tags.id = photo_tags.tag_id group by tag_id order by total desc limit 5;

-- 7. users who have liked every single photo:

select username, count(*) as total
    from users
    left join likes
    on users.id = likes.user_id
    group by users.id
    having total = (select count(*) from photos);
