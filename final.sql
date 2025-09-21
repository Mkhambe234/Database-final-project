/*SPORTS CLUB MANAGEMENT SYSTEM*/
-- 1. Members Table
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE,
    join_date DATE DEFAULT (CURRENT_DATE()),  -- Fixed
    membership_type ENUM('Basic', 'Premium', 'VIP') DEFAULT 'Basic',
    status ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active'
);

-- 2. Sports Table
CREATE TABLE sports (
    sport_id INT PRIMARY KEY AUTO_INCREMENT,
    sport_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    equipment_needed TEXT
);

-- 3. Coaches Table (created before teams due to foreign key constraint)
CREATE TABLE coaches (
    coach_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    expertise VARCHAR(100),
    hire_date DATE DEFAULT (CURRENT_DATE())  -- Fixed
);

-- 4. Teams Table
CREATE TABLE teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(100) NOT NULL,
    sport_id INT,
    coach_id INT,
    created_date DATE DEFAULT (CURRENT_DATE()),  -- Fixed
    FOREIGN KEY (sport_id) REFERENCES sports(sport_id),
    FOREIGN KEY (coach_id) REFERENCES coaches(coach_id)
);

-- 5. Team Members (Junction Table)
CREATE TABLE team_members (
    team_member_id INT PRIMARY KEY AUTO_INCREMENT,
    team_id INT,
    member_id INT,
    join_date DATE DEFAULT (CURRENT_DATE()),  -- Fixed
    position VARCHAR(50),
    jersey_number INT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    UNIQUE(team_id, member_id)
);

-- 6. Facilities Table
CREATE TABLE facilities (
    facility_id INT PRIMARY KEY AUTO_INCREMENT,
    facility_name VARCHAR(100) NOT NULL,
    location VARCHAR(200),
    capacity INT,
    amenities TEXT
);

-- 7. Events/Matches Table
CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_type ENUM('Match', 'Tournament', 'Practice', 'Friendly') DEFAULT 'Practice',
    sport_id INT,
    facility_id INT,
    team1_id INT,
    team2_id INT NULL, -- For matches against other teams
    event_date DATETIME,
    duration_minutes INT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    score_team1 INT DEFAULT 0,
    score_team2 INT DEFAULT 0,
    FOREIGN KEY (sport_id) REFERENCES sports(sport_id),
    FOREIGN KEY (facility_id) REFERENCES facilities(facility_id),
    FOREIGN KEY (team1_id) REFERENCES teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES teams(team_id)
);

-- 8. Attendance Table
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    member_id INT,
    attendance_status ENUM('Present', 'Absent', 'Late') DEFAULT 'Present',
    minutes_played INT DEFAULT 0,
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 9. Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE DEFAULT (CURRENT_DATE()),  -- Fixed
    payment_type ENUM('Membership', 'Event', 'Equipment') DEFAULT 'Membership',
    status ENUM('Paid', 'Pending', 'Failed') DEFAULT 'Pending',
    description TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);
