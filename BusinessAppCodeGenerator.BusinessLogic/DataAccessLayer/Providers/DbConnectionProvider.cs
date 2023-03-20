using BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer.Configuration;
using BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer.Interfaces;
using Microsoft.Extensions.Options;
using System.Data.Common;
using System.Data.SqlClient;

namespace InvoiceOffice.DataAccessLayer.Providers
{
    public class DbConnectionProvider : IDbConnectionProvider
    {
        private readonly string connectionString;

        public DbConnectionProvider(IOptionsMonitor<DbConnectionConfiguration> dbConnectionConfiguration)
        {
            connectionString = dbConnectionConfiguration.CurrentValue.ConnectionString;
        }

        public DbConnection GetConnection(string databaseName)
        {
            return new SqlConnection(connectionString);
        }
    }
}
