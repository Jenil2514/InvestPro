import React, { useState } from 'react';
import Chart from 'react-apexcharts';

const StockInfo = () => {
  const [stockData] = useState([
    { date: '2025-06-14', open: 150, high: 155, low: 148, close: 153 },
    { date: '2025-06-15', open: 153, high: 157, low: 151, close: 154 },
    { date: '2025-06-16', open: 154, high: 160, low: 152, close: 158 },
    { date: '2025-06-17', open: 158, high: 162, low: 157, close: 160 },
    { date: '2025-06-18', open: 160, high: 165, low: 159, close: 104 },
  ]);

  const candlestickSeries = [
    {
      data: stockData.map((item) => ({
        x: new Date(item.date),
        y: [item.open, item.high, item.low, item.close],
      })),
    },
  ];

  const lineSeries = [
    {
      name: 'Closing Price',
      data: stockData.map((item) => ({
        x: new Date(item.date),
        y: item.close,
      })),
    },
  ];

  const candlestickOptions = {
    chart: { type: 'candlestick', height: 350 },
    title: { text: 'Candlestick Chart', align: 'left' },
    xaxis: { type: 'datetime' },
    yaxis: { tooltip: { enabled: true } },
  };

  const lineOptions = {
    chart: { type: 'line', height: 350 },
    title: { text: 'Closing Price Chart', align: 'left' },
    xaxis: { type: 'datetime' },
  };

  return (
    <div className="max-w-4xl mx-auto p-4 space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center border-b pb-3">
        <div>
          <h2 className="text-2xl font-bold">Infosys Ltd (INFY)</h2>
          <p className="text-sm text-gray-500">NSE</p>
        </div>
        <div>
          <p className="text-xl font-semibold text-green-600">₹1452.20</p>
          <p className="text-sm text-green-500">+12.30 (0.85%)</p>
        </div>
      </div>

      {/* Price Stats */}
      <div className="grid grid-cols-2 sm:grid-cols-3 gap-4 text-sm">
        <div>Open: <strong>₹1440</strong></div>
        <div>Prev Close: <strong>₹1440</strong></div>
        <div>Day High: <strong>₹1460</strong></div>
        <div>Day Low: <strong>₹1430</strong></div>
        <div>52W High: <strong>₹1600</strong></div>
        <div>52W Low: <strong>₹1200</strong></div>
        <div>Volume: <strong>3.5M</strong></div>
      </div>

      {/* Chart Section */}
      <div className="bg-gray-100 p-4 rounded-lg">
        <div className="mb-6">
          <h2 className="text-lg font-semibold mb-2">Candlestick Chart</h2>
          <Chart options={candlestickOptions} series={candlestickSeries} type="candlestick" height={350} />
        </div>

        <div className="mb-6">
          <h2 className="text-lg font-semibold mb-2">Line Chart (Close Price)</h2>
          <Chart options={lineOptions} series={lineSeries} type="line" height={350} />
        </div>

        <div className="flex justify-center space-x-2 mb-4">
          <button className="px-3 py-1 bg-white border rounded">1D</button>
          <button className="px-3 py-1 bg-white border rounded">1W</button>
          <button className="px-3 py-1 bg-white border rounded">1M</button>
        </div>
      </div>

      {/* Action Buttons */}
      <div className="flex flex-wrap gap-4 justify-start">
        <button className="px-4 py-2 border rounded hover:bg-gray-100">☆ Add to Watchlist</button>
        <button className="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">Buy</button>
        <button className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">Sell</button>
      </div>

      {/* News Section */}
      <div>
        <h3 className="text-lg font-semibold mb-2">Recent News</h3>
        <ul className="space-y-2 text-sm list-disc list-inside">
          <li>Infosys Q4 profit beats estimates...</li>
          <li>Infosys signs $100M cloud deal...</li>
          <li>Broker upgrades Infosys to Buy...</li>
        </ul>
      </div>

      {/* Raw Data Table */}
      <div>
        <h2 className="text-lg font-semibold mt-6 mb-2">Raw Stock Data</h2>
        <table className="w-full border-collapse border text-sm">
          <thead>
            <tr className="bg-gray-200">
              <th className="border px-4 py-2">Date</th>
              <th className="border px-4 py-2">Open</th>
              <th className="border px-4 py-2">High</th>
              <th className="border px-4 py-2">Low</th>
              <th className="border px-4 py-2">Close</th>
            </tr>
          </thead>
          <tbody>
            {stockData.map((row, index) => (
              <tr key={index} className="text-center">
                <td className="border px-4 py-2">{row.date}</td>
                <td className="border px-4 py-2">{row.open}</td>
                <td className="border px-4 py-2">{row.high}</td>
                <td className="border px-4 py-2">{row.low}</td>
                <td className="border px-4 py-2">{row.close}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default StockInfo;
