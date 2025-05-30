const axios = require('axios');
const { Client } = require('pg');

const client = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'postgres',
    password: '12345678',
    port: 5432, // default PostgreSQL port
});
 
client.connect((err)=>{
    if(err){
        console.log(err);
    }
    else {
        console.log("connected successfully");
    }
});


const getdata = async () => {
    try {

        const instrument_key = BSE_INDEX|SENSEX; 
        const url = `https://api.upstox.com/v2/historical-candle/${instrument_key}/1minute/2024-04-05/2024-04-01`;
        const headers = {
            'Accept': 'application/json'
        };
        const response = await axios.get(url, { headers });
        main(response.data.data.candles);
    } catch (error) {
        console.error(`Error: ${error}`);
    }
};

const insertQuery = `
  INSERT INTO investpro.stock_group_history
    (time_stamp, group_symbol, inc_dec, price, open_price, previous_close)
  VALUES ($1, $2, $3, $4, $5, $6);
`;
getdata(); 

function main(stock_history){ 
        let prev = stock_history[stock_history.length-1][2] ; 
        for(let i=stock_history.length -1 ; i>=-1 ; i--){
            
            dataValues = [stock_history[i][0] , 'SENSEX'/*add you stock symbol here*/ , stock_history[i][2] - prev, stock_history[i][2] , stock_history[i][1] , stock_history[i][4]] ;
            prev  = stock_history[i][2]; 
    
            client.query(insertQuery, dataValues, (err, res) => {
                if (err) {
                    console.error('Error inserting data:', err);
                } else {
                    console.log('Data inserted successfully');
                }
            });

            if( i == -1 ){
                client.end(); 
            }
        }
}



