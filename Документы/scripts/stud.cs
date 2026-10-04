using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;

namespace DBConnect
{
    public static class StudentFunctions
    {
        // Строка подключения — одна на весь файл
        public static string ConnectionString =
            "Data Source=(localdb)\\MSSQLLocalDB;" +
            "Initial Catalog=TraineeDB;" +
            "Integrated Security=True;" +
            "TrustServerCertificate=True;";

        // ---------- READ: все студенты ----------
        public static void ShowAll()
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT s.StudentId, s.FirstName, s.LastName, s.Age, g.GroupName " +
                    "FROM Students s " +
                    "LEFT JOIN Groups g ON s.GroupId = g.GroupId " +
                    "ORDER BY s.StudentId", conn);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string group = reader["GroupName"] == DBNull.Value
                            ? "—"
                            : reader["GroupName"].ToString();

                        Console.WriteLine(
                            $"{reader["StudentId"]}: {reader["FirstName"]} " +
                            $"{reader["LastName"]}, {reader["Age"]} лет, гр. {group}");
                    }
                }
            }
        }

        // ---------- READ: один по ID ----------
        public static void FindById(int id)
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT s.FirstName, s.LastName, s.Age, g.GroupName " +
                    "FROM Students s " +
                    "LEFT JOIN Groups g ON s.GroupId = g.GroupId " +
                    "WHERE s.StudentId = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);

                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string group = reader["GroupName"] == DBNull.Value
                            ? "—"
                            : reader["GroupName"].ToString();

                        Console.WriteLine(
                            $"Найден: {reader["FirstName"]} {reader["LastName"]}, " +
                            $"{reader["Age"]} лет, группа {group}");
                    }
                    else
                    {
                        Console.WriteLine("Студент не найден.");
                    }
                }
            }
        }

        // ---------- CREATE ----------
        public static void Add(string firstName, string lastName, int age, int? groupId)
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "INSERT INTO Students (FirstName, LastName, Age, GroupId) " +
                    "VALUES (@f, @l, @a, @g); " +
                    "SELECT CAST(SCOPE_IDENTITY() AS INT);", conn);

                cmd.Parameters.AddWithValue("@f", firstName);
                cmd.Parameters.AddWithValue("@l", lastName);
                cmd.Parameters.AddWithValue("@a", age);
                cmd.Parameters.AddWithValue("@g", (object)groupId ?? DBNull.Value);

                int newId = (int)cmd.ExecuteScalar();
                Console.WriteLine($"Добавлен студент с ID {newId}.");
            }
        }

        // ---------- UPDATE ----------
        public static void Edit(int id, string firstName, string lastName, int age, int? groupId)
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "UPDATE Students SET FirstName = @f, LastName = @l, " +
                    "Age = @a, GroupId = @g WHERE StudentId = @id", conn);

                cmd.Parameters.AddWithValue("@f", firstName);
                cmd.Parameters.AddWithValue("@l", lastName);
                cmd.Parameters.AddWithValue("@a", age);
                cmd.Parameters.AddWithValue("@g", (object)groupId ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@id", id);

                int rows = cmd.ExecuteNonQuery();
                Console.WriteLine(rows > 0 ? "Обновлено." : "Студент не найден.");
            }
        }

        // ---------- DELETE ----------
        public static void Delete(int id)
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                // Сначала оценки студента, потом его самого
                var delGrades = new SqlCommand(
                    "DELETE FROM Grades WHERE StudentId = @id", conn);
                delGrades.Parameters.AddWithValue("@id", id);
                delGrades.ExecuteNonQuery();

                var delStudent = new SqlCommand(
                    "DELETE FROM Students WHERE StudentId = @id", conn);
                delStudent.Parameters.AddWithValue("@id", id);

                int rows = delStudent.ExecuteNonQuery();
                Console.WriteLine(rows > 0 ? "Удалено." : "Студент не найден.");
            }
        }

        // ---------- Вспомогательное: список групп для меню ----------
        public static List<(int Id, string Name)> GetGroups()
        {
            var result = new List<(int, string)>();

            using (var conn = new SqlConnection(ConnectionString))
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT GroupId, GroupName FROM Groups ORDER BY GroupName", conn);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        result.Add((
                            reader.GetInt32(0),
                            reader.GetString(1)
                        ));
                    }
                }
            }

            return result;
        }
    }
}
