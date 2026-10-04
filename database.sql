CREATE TABLE IF NOT EXISTS pathfinder_paths (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    target_name VARCHAR(255) NOT NULL,
    speed FLOAT NOT NULL,
    tween_time INT NOT NULL,
    fly_height FLOAT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO pathfinder_paths (player_id, target_name, speed, tween_time, fly_height) VALUES
(1, 'example_target', 1.0, 5000, 10.0);