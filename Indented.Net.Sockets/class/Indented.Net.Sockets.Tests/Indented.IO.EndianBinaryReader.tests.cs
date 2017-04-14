using System;
using System.IO;
using System.Net;

namespace Indented.IO
{
    using NUnit.Framework;

    [TestFixture]
    class EndianBinaryReaderTest
    {
        EndianBinaryReader reader;

        [SetUp]
        public void Init()
        {
            byte[] bytes = new byte[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
            MemoryStream stream = new MemoryStream(bytes);
            reader = new EndianBinaryReader(stream);
        }

        [Test(Description = "Maintains stream position information")]
        public void StreamPositionMarker()
        {
            Assert.That(reader.Marker, Is.EqualTo(0));
            reader.ReadByte();
            Assert.That(reader.MarkerOffset, Is.EqualTo(1));
            reader.SetMarker();
            Assert.That(reader.Marker, Is.EqualTo(1));
            reader.ReadBytes(10);
            Assert.That(reader.MarkerOffset, Is.EqualTo(10));
        }
   
        [Test(Description = "Can examine the next byte without advancing the stream position")]
        public void Peek()
        {
            Assert.That(reader.BaseStream.Position, Is.EqualTo(0));
            reader.ReadByte();
            Assert.That(reader.BaseStream.Position, Is.EqualTo(1));
            reader.PeekByte();
            Assert.That(reader.BaseStream.Position, Is.EqualTo(1));
        }

        [Test(Description = "It reads a Int16 value from a stream ordering bytes as big endian")]
        public void ReadBigEndianInt16()
        {
            short expectedResult = 1 << 8 | 2;
            var result = reader.ReadInt16(true);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<Int16>());
        }

        [Test(Description = "It reads a Int16 value from a stream ordering bytes as little endian")]
        public void ReadLittleEndianInt16()
        {
            short expectedResult = 1 | 2 << 8;
            var result = reader.ReadInt16(false);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<Int16>());
        }

        [Test(Description = "It reads a Int32 value from a stream ordering bytes as big endian")]
        public void ReadBigEndianInt32()
        {
            int expectedResult = 1 << 24 | 2 << 16 | 3 << 8 | 4;
            var result = reader.ReadInt32(true);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<Int32>());
        }

        [Test(Description = "It reads a Int32 value from a stream ordering bytes as little endian")]
        public void ReadLittleEndianInt32()
        {
            int expectedResult = 1 | 2 << 8 | 3 << 16 | 4 << 24;
            var result = reader.ReadInt32(false);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<Int32>());
        }
    
        [Test(Description = "It reads a Int64 value from a stream ordering bytes as big endian")]
        public void ReadBigEndianInt64()
        {
            long lowOrder = (long)(5 << 24 | 6 << 16 | 7 << 8 | 8);
            long highOrder = (long)(1 << 24 | 2 << 16 | 3 << 8 | 4);
            long expectedResult = lowOrder | highOrder << 32;
            var result = reader.ReadInt64(true);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<Int64>());
        }

        [Test(Description = "It reads a Int64 value from a stream ordering bytes as little endian")]
        public void ReadLittleEndianInt64()
        {
            long lowOrder = (long)(1 | 2 << 8 | 3 << 16 | 4 << 24);
            long highOrder = (long)(5 | 6 << 8 | 7 << 16 | 8 << 24);
            long expectedResult = lowOrder | highOrder << 32;
            var result = reader.ReadInt64(false);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<Int64>());
        }

        [Test(Description = "It reads a UInt16 value from a stream ordering bytes as big endian")]
        public void ReadBigEndianUInt16()
        {
            ushort expectedResult = 1 << 8 | 2;
            var result = reader.ReadUInt16(true);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<UInt16>());
        }

        [Test(Description = "It reads a UInt16 value from a stream ordering bytes as little endian")]
        public void ReadLittleEndianUInt16()
        {
            ushort expectedResult = 1 | 2 << 8;
            var result = reader.ReadUInt16(false);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<UInt16>());
        }

        [Test(Description = "It reads a UInt32 value from a stream ordering bytes as big endian")]
        public void ReadBigEndianUInt32()
        {
            uint expectedResult = 1 << 24 | 2 << 16 | 3 << 8 | 4;
            var result = reader.ReadUInt32(true);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<UInt32>());
        }

        [Test(Description = "It reads a UInt32 value from a stream ordering bytes as little endian")]
        public void ReadLittleEndianUInt32()
        {
            uint expectedResult = 1 | 2 << 8 | 3 << 16 | 4 << 24;
            var result = reader.ReadUInt32(false);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<UInt32>());
        }

        [Test(Description = "It reads a UInt48 (as UInt64) value from a stream ordering bytes as big endian")]
        public void ReadBigEndianUInt48()
        {
            ulong lowOrder = (ulong)(3 << 24 | 4 << 16 | 5 << 8 | 6);
            ulong highOrder = (ulong)(1 << 8 | 2);
            ulong expectedResult = lowOrder | highOrder << 32;
            var result = reader.ReadUInt48(true);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<UInt64>());
        }

        [Test(Description = "It reads a UInt48 (as UInt64) value from a stream ordering bytes as little endian")]
        public void ReadLittleEndianUInt48()
        {
            ulong lowOrder = (ulong)(1 | 2 << 8 | 3 << 16 | 4 << 24);
            ulong highOrder = (ulong)(5 | 6 << 8);
            ulong expectedResult = lowOrder | highOrder << 32;
            var result = reader.ReadUInt48(false);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<UInt64>());
        }

        [Test(Description = "It reads a UInt64 value from a stream ordering bytes as big endian")]
        public void ReadBigEndianUInt64()
        {
            ulong lowOrder = (ulong)(5 << 24 | 6 << 16 | 7 << 8 | 8);
            ulong highOrder = (ulong)(1 << 24 | 2 << 16 | 3 << 8 | 4);
            ulong expectedResult = lowOrder | highOrder << 32;
            var result = reader.ReadUInt64(true);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<UInt64>());
        }

        [Test(Description = "It reads a UInt64 value from a stream ordering bytes as little endian")]
        public void ReadLittleEndianUInt64()
        {
            ulong lowOrder = (ulong)(1 | 2 << 8 | 3 << 16 | 4 << 24);
            ulong highOrder = (ulong)(5 | 6 << 8 | 7 << 16 | 8 << 24);
            ulong expectedResult = lowOrder | highOrder << 32;
            var result = reader.ReadUInt64(false);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<UInt64>());
        }

        [Test(Description = "It reads an IPAddress (v4) value from a stream")]
        public void ReadIPv4Address()
        {
            IPAddress expectedResult = new IPAddress(new byte[] { 1, 2, 3, 4 });
            var result = reader.ReadIPAddress();

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<IPAddress>());
        }

        [Test(Description = "It reads an IPAddress (v4) value from a stream using the boolean overload")]
        public void ReadIPv4AddressOverload()
        {
            IPAddress expectedResult = new IPAddress(new byte[] { 1, 2, 3, 4 });
            var result = reader.ReadIPAddress(false);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<IPAddress>());
        }

        [Test(Description = "It reads an IPAddress (v6) value from a stream")]
        public void ReadIPv6Address()
        {
            IPAddress expectedResult = new IPAddress(new byte[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
            var result = reader.ReadIPAddress(true);

            Assert.That(result, Is.EqualTo(expectedResult));
            Assert.That(result, Is.TypeOf<IPAddress>());
        }
    }
}