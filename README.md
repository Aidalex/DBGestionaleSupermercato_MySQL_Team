# DBGestionaleSupermercato_MySQL_Team

**IT**  
# **Database Gestionale VendiCose SpA**  
*(Sistema di gestione ordini e stock per supermercati)*  

Il progetto in **team** ha riguardato la progettazione e implementazione di un database relazionale per VendiCose SpA, società che gestisce supermercati, per ottimizzare il flusso degli ordini tra magazzini e punti vendita associati. Partendo da uno schema E/R strutturato, si è creato un sistema che collega 3 magazzini con i rispettivi negozi per il monitoraggio dinamico dello stock.  
Durante lo sviluppo del database, sono state implementate sei entità principali con le relative relazioni: Category, Product, Warehouses, Stores, Stocklevels (tabella di correlazione) e Sales. Sono stati creati trigger BEFORE INSERT per il controllo automatico delle quantità vendute e dei livelli di stock, garantendo che le transazioni rispettino i parametri di sicurezza (quantità massima per vendita e soglie di restock).  
Sono state sviluppate *viste dinamiche* per il monitoraggio giornaliero: daily_product_sales per il controllo delle vendite per negozio, daily_flag per identificare i prodotti sotto soglia di restock e daily_total_sales per il fatturato giornaliero. Il sistema utilizza la funzione CURDATE() per garantire aggiornamenti in tempo reale.  
Il risultato è un database normalizzato che automatizza il controllo dello stock e segnala quando effettuare nuovi ordini, trasformando la gestione manuale in un sistema intelligente di monitoraggio delle scorte con analisi di mercato integrate.  

**Tecnologie utilizzate:**  

- 🗄️ **MySQL Workbench** (Database design e implementazione)
- 📊 **SQL** (Query, Trigger, Viste dinamiche)
- 🔄 **DDL/DML** (Creazione struttura e popolamento dati)

**EN**  
# **VendiCose SpA Management Database**  
*(Order and stock management system for supermarkets | Team Project)*  

This team project involved designing and implementing a relational database for VendiCose SpA, a company managing supermarkets, to optimize order flow between warehouses and associated retail stores. Starting from a structured E/R schema, we created a system connecting 3 warehouses with their respective stores for dynamic stock monitoring.  

**Data Preparation Highlights**  
  - Implemented six main entities with relationships:
    - Category, Product, Warehouses, Stores, Stocklevels (correlation table), and Sales
    - BEFORE INSERT triggers for automatic control of sold quantities and stock levels
    - Security parameters enforcement (maximum quantity per sale and restock thresholds)
    
**Key Features**  
  - Dynamic views for daily monitoring:
    - daily_product_sales for store sales control
    - daily_flag to identify products below restock threshold
    - daily_total_sales for daily revenue tracking
  - Real-time updates using CURDATE() function
  - Automated stock control and reorder alerts

**Insights Uncovered**  
The database reveals critical patterns by transforming manual stock management into an intelligent monitoring system with integrated market analysis, automatically signaling when to place new orders.  

**Technical Stack:**

- 🗄️ **MySQL Workbench** (Database design and implementation)
- 📊 **SQL** (Queries, Triggers, Dynamic Views)
- 🔄 **DDL/DML** (Structure creation and data population)
