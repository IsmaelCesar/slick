const path    = require("path")
const webpack = require("webpack")

// Extracts CSS into .css file
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
// Removes exported JavaScript files from CSS-only entries
// in this example, entry.custom will create a corresponding empty custom.js file
const RemoveEmptyScriptsPlugin = require('webpack-remove-empty-scripts');

const mode = process.env.NODE_ENV === 'development' ? 'development' : 'production';

module.exports = {
  mode,
  optimization: {
    moduleIds: 'deterministic',
  },
  entry: {
    application: [
      "./app/javascript/packs/application.js",
    ],
    presentation: [
      "./app/javascript/packs/presentation/main.js",
      "./app/javascript/packs/presentation/user.js",
    ],
    messaging:[
      "./app/javascript/packs/messaging.js"
    ],
    messaging_users: [
      "./app/javascript/packs/messaging/users.js",
    ],
    messaging_groups: [
      "./app/javascript/packs/messaging/groups.js",
    ],
    messaging_chats: [
      "./app/javascript/packs/messaging/chats.js",
    ],
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, '..', '..', 'app/assets/builds'),
  },
  module: {
    rules:[{
      test: /\.(js)$/ ,
      exclude: /node_modules/,
      use: ['babel-loader'],
      },
      {
        test: /\.(?:sa|sc|c)ss$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader'],
      }
    ],
  },
  resolve: {
    extensions: ['.js', '.jsx', '.scss', '.css'],
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    }), 
    new RemoveEmptyScriptsPlugin(),
    new MiniCssExtractPlugin(),
  ]
}
