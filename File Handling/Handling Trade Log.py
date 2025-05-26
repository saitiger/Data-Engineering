import os 
from collections import defaultdict

def extract_exchange_name(process_name):
    """Extract exchange name from process name"""
    return process_name.split('_')[0]

def parse_csv_with_dynamic_columns(file_path):
    """Parse CSV file handling different column orders dynamically"""
    
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    # Parse headers and create column mapping
    headers = [h.strip().lower() for h in lines[0].strip().split(',')]
    print(f"Detected columns: {headers}")
    
    # Create mapping of column names to indices
    col_indices = {header: idx for idx, header in enumerate(headers)}
    
    # Verify required columns exist
    required_cols = ['date', 'process', 'bytes']
    missing_cols = [col for col in required_cols if col not in col_indices]
    if missing_cols:
        raise ValueError(f"Missing required columns: {missing_cols}")
    
    # Get column indices
    date_idx = col_indices['date']
    process_idx = col_indices['process'] 
    bytes_idx = col_indices['bytes']
    
    # print(f"Column positions - Date: {date_idx}, Process: {process_idx}, Bytes: {bytes_idx}")
    
    # Initialize data structures
    daily_totals = defaultdict(int)
    exchange_daily_totals = defaultdict(lambda: defaultdict(int))
    
    # Process each data line
    for line_num, line in enumerate(lines[1:], start=2):
        if not line.strip():
            continue
            
        fields = [field.strip() for field in line.strip().split(',')]
        
        if len(fields) != len(headers):
            print(f"Warning: Line {line_num} has {len(fields)} fields, expected {len(headers)}")
            continue
        
        try:
            date = fields[date_idx]
            process = fields[process_idx]
            bytes_val = int(fields[bytes_idx])
            
            # Extract exchange name from process
            exchange = extract_exchange_name(process)
            
            # Accumulate totals
            daily_totals[date] += bytes_val
            exchange_daily_totals[date][exchange] += bytes_val
            
        except (ValueError, IndexError) as e:
            print(f"Warning: Error processing line {line_num}: {e}")
            continue
    
    return daily_totals, exchange_daily_totals

def print_results(daily_totals, exchange_daily_totals):    
    print("\nDaily Totals:")
    for date in sorted(daily_totals.keys()):
        print(f"{date}: {daily_totals[date]} bytes")
    
    print("\nExchange Daily Totals:")
    for date in sorted(exchange_daily_totals.keys()):
        for exchange in sorted(exchange_daily_totals[date].keys()):
            bytes_val = exchange_daily_totals[date][exchange]
            print(f"{date},{exchange}: {bytes_val} bytes")

if __name__ == "__main__":
    try:
        os.chdir("Logs/Trade Log")
    except FileNotFoundError:
        print("Directory 'Logs/Trade Log' not found, using current directory")
    
    if os.path.exists('tradelog.csv'):
        try:
            daily_totals, exchange_daily_totals = parse_csv_with_dynamic_columns('tradelog.csv')
            print_results(daily_totals, exchange_daily_totals)
        except Exception as e:
            print(f"Error processing tradelog.csv: {e}")
    else:
        print("tradelog.csv not found in current directory")
        print("Available files:", os.listdir('.') if os.path.exists('.') else "Cannot list directory")
