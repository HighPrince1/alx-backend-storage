-- Create the stored procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    -- Variable to store the weighted average score
    DECLARE weighted_avg_score DECIMAL(10, 2);

    -- Calculate the weighted average score using the user_id
    SELECT SUM(score * weight) / SUM(weight) INTO weighted_avg_score
    FROM scores
    WHERE user_id = user_id;

    -- Insert or update the weighted average score in the user_scores table
    INSERT INTO user_scores (user_id, weighted_average_score)
    VALUES (user_id, weighted_avg_score)
    ON DUPLICATE KEY UPDATE weighted_average_score = weighted_avg_score;
END //

DELIMITER ;
