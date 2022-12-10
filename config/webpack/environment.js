const { environment } = require('@rails/webpacker');
const customConfig = require('./custom');
const webpack = require('webpack');

environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
  }));

const aliasConfig = {
    'jquery': 'jquery-ui-dist/external/jquery/jquery.js',
    'jquery-ui': 'jquery-ui-dist/jquery-ui.js'
};

environment.config.set('resolve.alias', aliasConfig);

environment.config.merge(customConfig);

module.exports = environment
