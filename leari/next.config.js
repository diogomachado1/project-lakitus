/** @type {import('next').NextConfig} */
module.exports = {
  reactStrictMode: true,
  images: {
    domains: ['assets.nintendo.com', 'cdn01.nintendo-europe.com'],
  },
  async redirects() {
    return [
      {
        source: '/',
        destination: '/games',
        permanent: true,
      },
    ]
  },
}
