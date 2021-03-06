﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCafe
{
    static public class WindowHandler
    {
        public static Controller controllerObj;
        public static Login login;
        public static Register register;
        public static CMain cmain;
        public static CFeedback cfeedback;
        public static CSUBS csubs;
        public static EMain emain;
        public static EGames egames;
        public static EFood efood;
        public static MMain mmain;
        public static MFood mfood;
        public static MManage mManage;
        public static MCyper mcyper;
        public static MOT mot;
        public static ReserveReceipt rreceipt;

        public static void Intialaize()
        {
            controllerObj = new Controller();
            login = new Login();
            register = new Register();
            cmain = new CMain();
            cfeedback = new CFeedback();
            csubs = new CSUBS();
            emain = new EMain();
            egames = new EGames();
            efood = new EFood();
            mmain = new MMain();
            mfood = new MFood();
            mManage = new MManage();
            mcyper = new MCyper();
            mot = new MOT();
            rreceipt = new ReserveReceipt();
        }
    }
}
