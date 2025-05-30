import { Routes, Route } from 'react-router-dom';
import Dashboard from '../Pages/Dashboard';

const Approutes = () => {
    return (
        <Routes>
            <Route path="/" element={<Dashboard />} />
        </Routes>
    );
}

export default Approutes;
