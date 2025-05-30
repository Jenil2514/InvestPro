import Watchlist from "../components/watchlist";
import CryptoTicker from "../components/CryptoTicker";
import StockChart from "../components/stockCharts";
// import CompanyCard from "../components/companyCard";
import React from 'react';

const Dashboard = () => {
    return (
        <>

            
            <CryptoTicker/>
            {/* <CompanyCard/> */}
            <StockChart />
            <Watchlist />

        </>
    );
}

export default Dashboard;
