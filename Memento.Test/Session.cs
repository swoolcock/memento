﻿namespace Memento.Test
{
    /// <summary>
    /// The same mementor instance is usually used throughout the application 
    /// or editor session, therefore there should be some centralized way to 
    /// get that instance.
    /// </summary>
    static class Session
    {
        public static Mementor Mementor;

        public static Mementor New()
        {
            return Mementor = Mementor.Create();
        }

        public static void End()
        {
            Mementor.Dispose();
            Mementor = null;
        }
    }
}