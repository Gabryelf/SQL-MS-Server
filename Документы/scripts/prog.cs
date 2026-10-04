using System;

namespace DBConnect
{
    class Program
    {
        static void Main()
        {
            bool running = true;

            while (running)
            {
                Console.Clear();
                Console.WriteLine("=== База студентов ===");
                Console.WriteLine("1. Показать всех студентов");
                Console.WriteLine("2. Найти студента по ID");
                Console.WriteLine("3. Добавить студента");
                Console.WriteLine("4. Редактировать студента");
                Console.WriteLine("5. Удалить студента");
                Console.WriteLine("0. Выход");
                Console.Write("Ваш выбор: ");

                string choice = Console.ReadLine();

                switch (choice)
                {
                    case "1": StudentFunctions.ShowAll(); break;
                    case "2": FindStudent();              break;
                    case "3": AddStudent();               break;
                    case "4": EditStudent();              break;
                    case "5": DeleteStudent();            break;
                    case "0": running = false;            break;
                    default:
                        Console.WriteLine("Неверный выбор.");
                        break;
                }

                if (running)
                {
                    Console.WriteLine("\nНажмите любую клавишу...");
                    Console.ReadKey();
                }
            }
        }

        // ---------- Обёртки, которые собирают ввод и зовут функции ----------

        static void FindStudent()
        {
            int id = ReadInt("ID студента: ");
            StudentFunctions.FindById(id);
        }

        static void AddStudent()
        {
            string first = ReadString("Имя: ");
            string last  = ReadString("Фамилия: ");
            int age      = ReadInt("Возраст: ");
            int? groupId = ChooseGroup();

            StudentFunctions.Add(first, last, age, groupId);
        }

        static void EditStudent()
        {
            int id = ReadInt("ID для редактирования: ");
            string first = ReadString("Новое имя: ");
            string last  = ReadString("Новая фамилия: ");
            int age      = ReadInt("Новый возраст: ");
            int? groupId = ChooseGroup();

            StudentFunctions.Edit(id, first, last, age, groupId);
        }

        static void DeleteStudent()
        {
            int id = ReadInt("ID для удаления: ");
            StudentFunctions.Delete(id);
        }

        // ---------- Вспомогательные ----------

        static int ReadInt(string prompt)
        {
            while (true)
            {
                Console.Write(prompt);
                if (int.TryParse(Console.ReadLine(), out int value))
                    return value;
                Console.WriteLine("Нужно число. Попробуйте снова.");
            }
        }

        static string ReadString(string prompt)
        {
            while (true)
            {
                Console.Write(prompt);
                string input = Console.ReadLine();
                if (!string.IsNullOrWhiteSpace(input))
                    return input;
                Console.WriteLine("Пустое значение недопустимо.");
            }
        }

        // Спрашивает группу: 0 — без группы, иначе ID из списка
        static int? ChooseGroup()
        {
            var groups = StudentFunctions.GetGroups();

            if (groups.Count == 0)
            {
                Console.WriteLine("(Групп в базе нет — студент будет без группы)");
                return null;
            }

            Console.WriteLine("Доступные группы:");
            foreach (var g in groups)
                Console.WriteLine($"  {g.Id}. {g.Name}");
            Console.Write("ID группы (0 — без группы): ");

            if (!int.TryParse(Console.ReadLine(), out int gid) || gid == 0)
                return null;

            return gid;
        }
    }
}
