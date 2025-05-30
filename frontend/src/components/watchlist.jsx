import React from 'react';
import Paper from '@mui/material/Paper';
import Watchlistdata from '../data/watchlist.json';
import { green, red } from '@mui/material/colors';

const Watchlist = () => {
    return (
        <>
            <Paper elevation={3} style={{ padding: '20px', margin: '20px' }}>
                <div className="watchlist-container space-y-4">
                    <div className='flex items-center justify-between'> 

                    <h1 className="text-2xl font-semibold mb-4">My Watchlist</h1>
                    <h1 className='text-right text-4xl'>+</h1>
                    </div>
                    {Watchlistdata.map((stock) => (
                        <Paper key={stock.symbol} elevation={2} style={{ padding: '10px', margin: '10px' }}>
                            <div className="flex items-center justify-between">
                                <div>
                                    <h4 className="text-lg font-medium">{stock.symbol}</h4>
                                </div>
                                <div className="text-right">
                                    <p className="text-sm">Price: ${stock.price}</p>
                                    <p
                                        className="text-sm font-semibold"
                                        style={{ color: stock.changePercent > 0 ? green[500] : red[500] }}
                                    >
                                        Change: {stock.changePercent}%
                                    </p>
                                </div>
                            </div>
                        </Paper>
                    ))}
                </div>
            </Paper>
        </>
    );
};

export default Watchlist;
