using api.Models;
using Google.Protobuf.WellKnownTypes;
using MySql.Data.MySqlClient;
using MySqlX.XDevAPI.Relational;
using System.Data;

namespace api.Helpers
{
    public class SqlHelper
    {
        private readonly MySqlConnection _conn;

        public SqlHelper(MySqlConnection conn) 
        { 
            _conn = conn;
        }

        public void Execute(string query)
        {
            try
            {
                _conn.Open();
                MySqlCommand _command = new(query, _conn);
                _command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw;
            }
            finally 
            { 
                _conn.Close(); 
            }
        }

        public DataTable Query(string query)
        {
            try
            {           
                _conn.Open();
                MySqlCommand _command = new(query, _conn);
                MySqlDataReader results = _command.ExecuteReader();

                var table = new DataTable();
                table.Load(results);

                return table;
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw;
            }
            finally 
            { 
                _conn.Close(); 
            }
        }
    }
}
