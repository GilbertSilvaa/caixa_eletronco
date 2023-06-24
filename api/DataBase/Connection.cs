using MySql.Data.MySqlClient;

namespace api.DataBase
{
    public class Connection
    {
        private readonly string _connString = "server=localhost;userid=root;password=Ringkyu777#;database=caixa";
        private static MySqlConnection? _conn;
        private static Connection? _instance;

        public Connection()
        {
            _conn = new MySqlConnection(_connString);
        }

        public MySqlConnection GetConnection
        {
            get { return _conn!; }
        }

        public static Connection GetInstance()
        {
            _instance ??= new Connection();
            return _instance;
        }
    }
}
