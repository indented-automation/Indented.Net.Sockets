namespace Indented.Net
{
    using NUnit.Framework;

    [TestFixture]
    public class EndianBitConverterTest
    {
        [Test(Description="Gets bytes of ushort")]
        public void GetBytesUShort()
        {
            ushort value = 0x0102;

            byte[] leBytes = EndianBitConverter.GetBytes(value, false);
            byte[] beBytes = EndianBitConverter.GetBytes(value, true);

            Assert.That(leBytes, Is.EqualTo(new byte[] { 0x02, 0x01 }));
            Assert.That(beBytes, Is.EqualTo(new byte[] { 0x01, 0x02 }));
        }

        [Test(Description = "Gets bytes of uint")]
        public void GetBytesUInt()
        {
            uint value = 0x01020304;

            byte[] leBytes = EndianBitConverter.GetBytes(value, false);
            byte[] beBytes = EndianBitConverter.GetBytes(value, true);

            Assert.That(leBytes, Is.EqualTo(new byte[] { 0x04, 0x03, 0x02, 0x01 }));
            Assert.That(beBytes, Is.EqualTo(new byte[] { 0x01, 0x02, 0x03, 0x04 }));
        }

        [Test(Description = "Convert bytes to a binary string")]
        public void BytesToBinary()
        {
            byte[] bytes = new byte[] { 0x01, 0x02, 0x03, 0x04 };
            Assert.That(EndianBitConverter.ToBinary(bytes), Is.EqualTo("00000001000000100000001100000100"));
        }

        [Test(Description = "Convert bytes to a hexadecimal string")]
        public void BytesToString()
        {
            byte[] bytes = new byte[] { 0x01, 0x02, 0x03, 0x04 };
            Assert.That(EndianBitConverter.ToString(bytes), Is.EqualTo("01020304"));
        }
    }
}