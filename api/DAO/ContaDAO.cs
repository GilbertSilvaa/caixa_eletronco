using api.DataBase;
using api.Helpers;
using api.Models;
using MySql.Data.MySqlClient;

namespace api.DAO
{
    public class ContaDAO
    {
        private readonly MySqlConnection _connection;

        public ContaDAO()
        {
            _connection = Connection.GetInstance().GetConnection;
        }

        public void GetSaldo()
        {
            string query = "SELECT * FROM Caixa";
            SqlHelper sql = new(_connection);

            var rm_contas = sql.Query(query);
            var contas = Conta.DataReaderConvert(rm_contas);

            foreach (Conta conta in contas)
            {
                var test = conta.Nome;
                Console.WriteLine(test);
            }
            _connection.Close();
        }
    }
}
