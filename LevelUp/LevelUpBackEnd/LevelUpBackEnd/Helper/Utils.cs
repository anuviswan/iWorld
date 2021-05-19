﻿using System;
using System.Collections.Generic;
using System.Text;

namespace LevelUpBackEnd.Helper
{
    public static class Utils
    {
        public const string Key_Partition = "Key";
        public const string Key_User = "User";
        public const string Key_CategoryRow = "Category";
        public const string Key_ItemRow = "Value";
        public const string Key_FileToken = "FileToken";

        public const string FunctionName_GetNextQuestion = "GetNextQuestion";
        public const string FunctionName_GetScores = "GetScores";

        public const string App_Parition = "AppMetadata";
        public const string Category_Partition_Key_Suffix = "CategoryName";
        public const string Table_Name = "levelUp";
        public const string Blob_Container_Name = "genericimagestore";

        public const string QueryString_AppId = "AppId";
        public const string QueryString_CategoryId = "Cid";
        public const string QueryString_AppName = "AppName";
        public const string QueryString_DisplayName = "DisplayName";
    }
}