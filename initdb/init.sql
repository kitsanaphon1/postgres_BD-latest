-- Create table if not exists
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert multiple users
INSERT INTO users (name, email) VALUES
  ('Alice Smith', 'alice@example.com'),
  ('Bob Johnson', 'bob@example.com'),
  ('Charlie Brown', 'charlie@example.com'),
  ('Diana Prince', 'diana@example.com'),
  ('Ethan Hunt', 'ethan@example.com'),
  ('Fiona Glenanne', 'fiona@example.com'),
  ('George Clark', 'george@example.com'),
  ('Hannah Ray', 'hannah@example.com'),
  ('Ivan Petrov', 'ivan@example.com'),
  ('Jane Doe', 'jane@example.com'),
  ('Kevin Lee', 'kevin@example.com'),
  ('Luna Park', 'luna@example.com'),
  ('Michael Fox', 'michael@example.com'),
  ('Nina Hart', 'nina@example.com'),
  ('Oscar Wilde', 'oscar@example.com'),
  ('Paula Green', 'paula@example.com'),
  ('Quentin Marsh', 'quentin@example.com'),
  ('Rachel Bloom', 'rachel@example.com'),
  ('Steve Nash', 'steve@example.com'),
  ('Tina Fey', 'tina@example.com'),
  ('Uma Thurman', 'uma@example.com'),
  ('Victor Stone', 'victor@example.com'),
  ('Wendy Wu', 'wendy@example.com'),
  ('Xander Cage', 'xander@example.com'),
  ('Yasmine Ali', 'yasmine@example.com'),
  ('Zack Morris', 'zack@example.com')
ON CONFLICT DO NOTHING;
