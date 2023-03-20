using BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer.Interfaces;
using BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer.Models;
using System.Data.Common;
using System.Text;

namespace BusinessAppCodeGenerator.BusinessLogic
{
    public class SqlScriptDecomposer
    {
        private readonly IDbConnectionProvider _dbConnectionProvider;

        public SqlScriptDecomposer(IDbConnectionProvider dbConnectionProvider)
        {
            _dbConnectionProvider = dbConnectionProvider;
        }

        public async Task MapDatabase(string databaseName)
        {
            using (var connection = _dbConnectionProvider.GetConnection(databaseName))
            {
                

                //await connection.OpenAsync();

                //var tables = await GetTables(connection);
                //var columns = await GetColumns(connection);
                //var foreignKeys = await GetForeignKeys(connection);

                //var dbSchema = new MsSqlDbSchemaDomainModel
                //{
                //    Tables = tables
                //};

                //foreach (var table in dbSchema.Tables)
                //{
                //    table.Columns = columns.Where(c => c.TableName == table.Name).ToList();
                //    table.ForeignKeys = foreignKeys.Where(fk => fk.TableName == table.Name).ToList();
                //}

                //var sb = new StringBuilder();

                //foreach (var table in dbSchema.Tables)
                //{
                //    sb.AppendLine($"public class {table.Name} : Entity");
                //    sb.AppendLine("{");

                //    foreach (var column in table.Columns)
                //    {
                //        sb.AppendLine($"    public {column.DataType} {column.Name} {{ get; set; }}");
                //    }

                //    sb.AppendLine("}");
                //    sb.AppendLine();
                //}

                //var code = sb.ToString();
            }
        }

        private Task<ICollection<TableDomainModel>> GetTables(DbConnection connection)
        {
            throw new NotImplementedException();
        }

        //public async Task DecomposeScript(string sqlScriptFilePath)
        //{
        //    using (var sr = new StreamReader(sqlScriptFilePath))
        //    {
        /*
            SELECT 
                TABLE_NAME as TableName 
            FROM 
                INFORMATION_SCHEMA.TABLES 
            WHERE 
                TABLE_TYPE='BASE TABLE'
                AND TABLE_NAME NOT IN ('__RefactorLog')



            SELECT
                TABLE_NAME as Name, ORDINAL_POSITION as OrdinalPosition, COLUMN_DEFAULT as DefaultValue, IS_NULLABLE as IsNullable, 
                DATA_TYPE as DataType, CHARACTER_MAXIMUM_LENGTH as CharacterMaximumLenght, NUMERIC_PRECISION as NumericPrecision
            FROM 
                INFORMATION_SCHEMA.COLUMNS 
            WHERE 
                TABLE_NAME = 'PurchaseInvoices'

            --select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS

            SELECT  
                --obj.name AS FK_NAME,
                --sch.name AS [schema_name],
                --tab1.name AS [table],
                col1.name AS [column],
                tab2.name AS [referenced_table],
                col2.name AS [referenced_column]
            FROM sys.foreign_key_columns fkc
            INNER JOIN sys.objects obj
                ON obj.object_id = fkc.constraint_object_id
            INNER JOIN sys.tables tab1
                ON tab1.object_id = fkc.parent_object_id
            INNER JOIN sys.schemas sch
                ON tab1.schema_id = sch.schema_id
            INNER JOIN sys.columns col1
                ON col1.column_id = parent_column_id AND col1.object_id = tab1.object_id
            INNER JOIN sys.tables tab2
                ON tab2.object_id = fkc.referenced_object_id
            INNER JOIN sys.columns col2
                ON col2.column_id = referenced_column_id AND col2.object_id = tab2.object_id
            WHERE
                tab1.name = 'PurchaseInvoices'

            EXEC sp_fkeys 'Programs'
        */



        //        //bool createStatementFound = false;
        //        //var phraseStringBuilder = new StringBuilder();

        //        //while (!sr.EndOfStream)
        //        //{
        //        //    var line = await sr.ReadLineAsync();

        //        //    if (line == null) continue;

        //        //    if(createStatementFound)
        //        //    {
        //        //        if (line.Contains(';'))
        //        //        {
        //        //            createStatementFound = false;
        //        //            phraseStringBuilder.Clear();
        //        //        }
        //        //    }
        //        //    else if (line.Contains("CREATE"))
        //        //    {
        //        //        createStatementFound = true;
        //        //    }

        //        //} 
        //    }
        //}

        //IEnumerable<TokenInfo> ParseSql(string sql)
        //{
        //    ParseOptions parseOptions = new ParseOptions();
        //    Scanner scanner = new Scanner(parseOptions);

        //    int state = 0,
        //        start,
        //        end,
        //        lastTokenEnd = -1,
        //        token;

        //    bool isPairMatch, isExecAutoParamHelp;

        //    List<TokenInfo> tokens = new List<TokenInfo>();

        //    scanner.SetSource(sql, 0);

        //    while ((token = scanner.GetNext(ref state, out start, out end, out isPairMatch, out isExecAutoParamHelp)) != (int)Tokens.EOF)
        //    {
        //        TokenInfo tokenInfo =
        //            new TokenInfo()
        //            {
        //                Start = start,
        //                End = end,
        //                IsPairMatch = isPairMatch,
        //                IsExecAutoParamHelp = isExecAutoParamHelp,
        //                Sql = sql.Substring(start, end - start + 1),
        //                Token = (Tokens)token,
        //            };

        //        tokens.Add(tokenInfo);

        //        lastTokenEnd = end;
        //    }

        //    return tokens;
        //}
    }
}