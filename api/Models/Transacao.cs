using api.DAO;
using MySql.Data.MySqlClient;
using System.Data;

namespace api.Models
{
    public class Transacao
    {
        public int Id { get; set; }
        public int IdCliente { get; set; }
        public TipoTransacao Tipo { get; set; }
        public double Valor { get; set; }
        public DateTime? DtTransacao { get; set; }

        public static List<Transacao> DataTableConvert(DataTable tb)
        {
            List<Transacao> transacoes =
            (from row in tb.AsEnumerable()
             select new Transacao()
             {
                 Id = int.Parse(row["id"].ToString()!),
                 Valor = double.Parse(row["valor"].ToString()!),
                 DtTransacao = DateTime.Parse(row["dt_transacao"].ToString()!),
                 IdCliente = int.Parse(row["cliente_id"].ToString()!),
                 Tipo = (TipoTransacao)int.Parse(row["tipo"].ToString()!)
             }).ToList();

            return transacoes;
        }
    }
}
