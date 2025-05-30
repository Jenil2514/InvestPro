import React from 'react';
import appleLogo from '../assets/apple-logo.png'; // Replace with your actual logo file

const CompanyCard = ({ name, ticker, price }) => {
  return (
    <div style={{
      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      padding: '10px 20px', background: '#fff', borderRadius: '10px',
      boxShadow: '0 1px 5px rgba(0,0,0,0.1)', marginBottom: '10px'
    }}>
      <div style={{ display: 'flex', alignItems: 'center' }}>
        <img src={appleLogo} alt="logo" style={{ width: '40px', marginRight: '10px' }} />
        <div>
          <strong>{name}</strong>
          <div style={{ fontSize: '12px', color: '#666' }}>{ticker}</div>
        </div>
      </div>
      <div>
        <span style={{ fontWeight: 'bold', color: '#e74c3c' }}>${price.toFixed(2)}</span>
      </div>
    </div>
  );
};

export default CompanyCard;
