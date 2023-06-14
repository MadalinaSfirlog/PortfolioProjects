#Creare un conto bancario dove si possa depositare, prelevare e visualizzare il saldo corrente 


class Conto:
    
    def __init__(self, proprietario, saldo=0):
       
        self.proprietario = proprietario            
        self.saldo = saldo          
    
    def deposit (self, quantita_deposito): 
  
        self.saldo = self.saldo + quantita_deposito
        print(" E' stato aggiunto {} al saldo corrente".format(quantita_deposito))

    
    def ritirare(self, quantita_ritiro): 
        if self.saldo >= quantita_ritiro:

            self.saldo = self.saldo - quantita_ritiro
            print("Effettuato ritiro con successo")
        else: 
            print("Ritiro non permesso, riprovare")  


    #metodo magico ( dunder method ): rappresentazione del saldo 
    def __str__(self): 
        return "Il saldo attuale è di: {}".format(self.saldo)



#inizializzazione del conto di Madalina
conto = Conto("Madalina",100)

#rappresentazione del proprietario
print(conto.proprietario)   

#rappresentazione del saldo 
print(conto.saldo)

#aggiungere al deposito
conto.deposit(100)    

#visionare il deposito
print(conto)

#effettuare un ritiro
conto.ritirare(50)

#visionare l'ammontare del conto dopo il ritiro
print(conto)

#effettuare un ritiro maggiore del saldo 
conto.ritirare(100)
