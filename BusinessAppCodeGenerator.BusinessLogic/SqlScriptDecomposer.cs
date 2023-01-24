using System.Text;

namespace BusinessAppCodeGenerator.BusinessLogic
{
    public class SqlScriptDecomposer
    {
        public SqlScriptDecomposer()
        {

        }

        public async Task DecomposeScript(string sqlScriptFilePath)
        {
            using (var sr = new StreamReader(sqlScriptFilePath))
            {
                bool createStatementFound = false;
                var phraseStringBuilder = new StringBuilder();

                while (!sr.EndOfStream)
                {
                    var line = await sr.ReadLineAsync();

                    if (line == null) continue;

                    if(createStatementFound)
                    {
                        if (line.Contains(';'))
                        {
                            createStatementFound = false;
                            phraseStringBuilder.Clear();
                        }
                    }
                    else if (line.Contains("CREATE"))
                    {
                        createStatementFound = true;
                    }

                } 
            }
        }
    }
}