import React, { useEffect, useRef, useState } from 'react';
import CryptoData from '../data/CryptoData.json';

const CryptoTicker = () => {
  const containerRef = useRef(null);
  const sliderRef = useRef(null);
  const cardWidth = 250; // Width + gap
  const transitionTime = 500; // ms
  const intervalTime = 3000; // ms

  const [startIndex, setStartIndex] = useState(0);
  const [visibleCount, setVisibleCount] = useState(3);
  const [visibleItems, setVisibleItems] = useState([]);

  const getVisibleCount = () => {
    if (!containerRef.current) return 3;
    const width = containerRef.current.offsetWidth;
    return Math.floor(width / cardWidth);
  };

  const getItems = (start, count) => {
    const items = [];
    for (let i = 0; i < count + 1; i++) {
      items.push(CryptoData[(start + i) % CryptoData.length]);
    }
    return items;
  };

  // Resize logic
  useEffect(() => {
    const updateSize = () => {
      const count = getVisibleCount();
      setVisibleCount(count);
      setVisibleItems(getItems(startIndex, count));
    };
    updateSize();
    window.addEventListener('resize', updateSize);
    return () => window.removeEventListener('resize', updateSize);
  }, [startIndex]);

  // Rotation logic
  useEffect(() => {
    const interval = setInterval(() => {
      if (!sliderRef.current) return;

      // Slide left
      sliderRef.current.style.transition = `transform ${transitionTime}ms ease-in-out`;
      sliderRef.current.style.transform = `translateX(-${cardWidth}px)`;

      setTimeout(() => {
        // Reset (jump to start with updated data)
        sliderRef.current.style.transition = 'none';
        sliderRef.current.style.transform = 'translateX(0)';
        const newStartIndex = (startIndex + 1) % CryptoData.length;
        setStartIndex(newStartIndex);
        setVisibleItems(getItems(newStartIndex, visibleCount));
      }, transitionTime);
    }, intervalTime);

    return () => clearInterval(interval);
  }, [visibleCount, startIndex]);

  const getIconUrl = (symbol) =>
    `https://assets.coincap.io/assets/icons/${symbol.toLowerCase()}@2x.png`;

  return (
    <div
      ref={containerRef}
      className="w-full overflow-hidden bg-[#fdf6f2] py-6 px-4 rounded-xl shadow-md"
    >
      <div
        ref={sliderRef}
        className="flex gap-4"
        style={{ transform: 'translateX(0)' }}
      >
        {visibleItems.map((coin, idx) => (
          <div
            key={idx}
            className="flex items-center gap-3 bg-white rounded-xl shadow p-4 min-w-[230px] max-w-[230px] hover:scale-105 transition"
          >
            <img
              src={getIconUrl(coin.symbol)}
              alt={coin.name}
              className="w-10 h-10 rounded-full border border-gray-200"
            />
            <div className="flex-1">
              <h2 className="font-semibold text-base">{coin.name}</h2>
              <p className="text-xs text-gray-500">{coin.pair}</p>
            </div>
            <div className="text-right">
              <h3 className="font-bold text-sm">{coin.price}</h3>
              <p className={`text-xs ${coin.changeColor}`}>{coin.change}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default CryptoTicker;
