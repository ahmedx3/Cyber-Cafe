﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CCafe
{
    static class Program
    {
        public static int UserID;
        public static int UserType;
        public static string UserName;
        public static Controller ctrl;
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            ctrl = new Controller();
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            WindowHandler.Intialaize();
            Application.Run(WindowHandler.login);
        }
    }
}
