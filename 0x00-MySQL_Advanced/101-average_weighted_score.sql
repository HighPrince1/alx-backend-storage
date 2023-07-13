-- Create the stored procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    -- Variable to store the user ID
    DECLARE user_id INT;
    
    -- Cursor to iterate over user IDs
    DECLARE cur CURSOR FOR SELECT id FROM users;
    
    -- Variables to store the weighted average score
    DECLARE weighted_avg_score DECIMAL(10, 2);
    DECLARE total_weight DECIMAL(10, 2);

    -- Declare exit handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @finished = TRUE;

    -- Open the cursor
    OPEN cur;
    
    -- Start fetching user IDs
    FETCH cur INTO user_id;
    
    -- Loop through each user
    WHILE (@finished = FALSE) DO
        -- Calculate the weighted average score for the current user
        SET weighted_avg_score = (SELECT SUM(score * weight) / SUM(weight) FROM scores WHERE user_id = user_id);
        SET total_weight = (SELECT SUM(weight) FROM scores WHERE user_id = user_id);
        
        -- Insert or update the weighted average score in the user_scores table
        INSERT INTO user_scores (user_id, weighted_average_score)
        VALUES (user_id, weighted_avg_score)
        ON DUPLICATE KEY UPDATE weighted_average_score = weighted_avg_score;
        
        -- Fetch the next user ID
        FETCH cur INTO user_id;
    END WHILE;

    -- Close the cursor
    CLOSE cur;
END //

DELIMITER ;
