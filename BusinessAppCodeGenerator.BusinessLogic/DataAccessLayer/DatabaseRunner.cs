using BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer.Interfaces;
using BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer.Models;
using InvoiceOffice.DataAccessLayer.Providers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer
{
    public class DatabaseRunner : IDatabaseRunner
    {
        private readonly IDbConnectionProvider _dbConnectionProvider;

        protected IDbConnection GetDbConnection(string databaseName) => _dbConnectionProvider.GetConnection(databaseName);

        public DatabaseRunner(IDbConnectionProvider dbConnectionProvider)
        {
            _dbConnectionProvider = dbConnectionProvider;
        }

        // Method should read database schema from client's ran script and return it as MsSqlDbSchemaDomainModel
        public MsSqlDbSchemaDomainModel ReadSchema(string databaseName)
        {
            throw new NotImplementedException();
        }

        // Method should run given sql script to create a client's database (for further read)
        public Task RunScript()
        {
            throw new NotImplementedException();
        }
    }
}
