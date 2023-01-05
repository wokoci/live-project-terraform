output "db_config" {
  value = {
    password = aws_db_instance.database.password
    user     = aws_db_instance.database.username
    database = aws_db_instance.database.db_name
    hostname = aws_db_instance.database.address
    port     = aws_db_instance.database.port
  }
}

