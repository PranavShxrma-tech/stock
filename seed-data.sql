-- Sample data for testing (run this after schema.sql)

-- Insert sample courses
INSERT INTO courses (title, slug, description, image_url) VALUES
  ('Fundamentals of Stock Trading', 'stock-trading-101', 'Learn the essential strategies and technical skills required to succeed in stock trading.', 'https://via.placeholder.com/300x200?text=Stock+Trading'),
  ('Technical Analysis Mastery', 'technical-analysis', 'Deep dive into charts, indicators, and market trends to predict price movements.', 'https://via.placeholder.com/300x200?text=Technical+Analysis'),
  ('Options Trading Explained', 'options-trading', 'Understand options terminology, strategies, and risk management techniques.', 'https://via.placeholder.com/300x200?text=Options+Trading'),
  ('Cryptocurrency & Blockchain', 'crypto-blockchain', 'Explore digital assets, blockchain technology, and cryptocurrency trading fundamentals.', 'https://via.placeholder.com/300x200?text=Crypto'),
  ('Risk Management for Traders', 'risk-management', 'Master the art of protecting your capital and managing trading risks wisely.', 'https://via.placeholder.com/300x200?text=Risk+Management')
ON CONFLICT (slug) DO NOTHING;

-- Insert sample blog posts
INSERT INTO blog_posts (title, slug, summary, content, image_url) VALUES
  ('Understanding Market Sentiment', 'market-sentiment', 'How trader psychology affects market trends and decision-making in trading.', 
   'Market sentiment is a crucial factor in trading success. It refers to the overall attitude of investors and traders toward a particular financial asset or market. Understanding and analyzing market sentiment can help you make better trading decisions.\n\nMost traders rely on technical and fundamental analysis, but often overlook the psychological aspect of trading. Market sentiment can turn a well-planned trade into a losing one, or vice versa.\n\nKey points:\n- Fear and greed are the two strongest emotions driving market movements\n- Social media and news significantly influence trader sentiment\n- Contrarian indicators can help you identify overbought/oversold conditions\n- Sentiment analysis tools can measure market psychology\n\nBy mastering market sentiment analysis, you can gain an edge in your trading.',
   'https://via.placeholder.com/300x200?text=Market+Sentiment'),
  
  ('Top 5 Technical Indicators', 'technical-indicators', 'A beginner''s guide to the most effective technical indicators for trading success.', 
   'Technical indicators are mathematical calculations based on historical price and volume data. They help traders identify trading opportunities and trend reversals.\n\nHere are the top 5 most effective technical indicators for beginners:\n\n1. Moving Averages (MA) - Smooths price data and identifies trends\n2. Relative Strength Index (RSI) - Measures momentum and overbought/oversold conditions\n3. MACD (Moving Average Convergence Divergence) - Identifies trend changes\n4. Bollinger Bands - Shows volatility and support/resistance levels\n5. Stochastic Oscillator - Measures price momentum and potential reversals\n\nTip: Combine multiple indicators for more reliable signals rather than relying on just one.',
   'https://via.placeholder.com/300x200?text=Technical+Indicators'),
  
  ('Risk Management in Trading', 'risk-management', 'Explore key principles to protect your capital and manage trading risks wisely.',
   'Risk management is the foundation of successful trading. Many traders focus on making profits but neglect the critical aspect of protecting their capital.\n\nEssential Risk Management Principles:\n\n1. Position Sizing - Risk only 1-2% of your account per trade\n2. Stop Loss Orders - Always set stop losses to limit downside risk\n3. Risk-Reward Ratio - Aim for 1:2 or better risk-to-reward ratios\n4. Diversification - Spread risk across different assets and timeframes\n5. Emotional Control - Stick to your trading plan and avoid impulsive decisions\n\nRemember: It''s better to preserve capital than to risk it all for big profits. The traders who last longest are those who manage risk effectively.',
   'https://via.placeholder.com/300x200?text=Risk+Management')
ON CONFLICT (slug) DO NOTHING;
