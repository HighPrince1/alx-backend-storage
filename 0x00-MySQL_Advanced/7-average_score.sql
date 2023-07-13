-- Create the stored procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    -- Variable to store the average score
    DECLARE avg_score DECIMAL(10, 2);

    -- Compute the average score using the user_id
    SELECT AVG(score) INTO avg_score
    FROM scores
    WHERE user_id = user_id;

    -- Insert or update the average score in the user_scores table
    INSERT INTO user_scores (user_id, average_score)
    VALUES (user_id, avg_score)
    ON DUPLICATE KEY UPDATE average_score = avg_score;
END //

DELIMITER ;
