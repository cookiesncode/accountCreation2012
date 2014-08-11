using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AccountCreation
{
    public static class Record
    {
        public static AccountRequest QueryRecords(string edipi, string accountType, string requestType)
        {
            var context = new CarsonAccountEntities();
            var query = from request in context.AccountRequests
                        where request.Edipi == edipi
                            && request.AccountType == accountType
                            && request.RequestType == requestType
                        select request;
            return query.First();
        }
    }
}