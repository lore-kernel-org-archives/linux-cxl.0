Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B45B376
	for <linux-cxl@vger.kernel.org>; Mon, 25 Nov 2024 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523690; cv=none; b=J8mV2lb0e5Ac7vm9z0T0OlFBQEi7Hwx3JIrthxLaMW02NhqqB8Pcw1r/SD1rP68UPAhvB5ZAv8eIU3oQgT84czl2+UXcwhkQO4ga6T+a0FetccwsyUXtz0WMYhQByNfKHOQQRzZcLlSw/ahFjd6z2eIEHYuX6kAxU8MBQ65wP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523690; c=relaxed/simple;
	bh=sbpto9/ym3G8ccBgVAiTEFuG2T0NqXLn9GDTt7SEZNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oXY4HIG+WBi4T6B+pAZCyXV8LFgPXOLHCfqk+ZKqOHxGluRS9eBcJxiNNj0QG0rFtVlU6em+syAQxQjQGu3q5lcny9c4ArHPWxgOIQrFOFjcXikUa9lJM9PHJyociduRZ9IeM356IebWffiDekhaZIvgzd+YTP6DlpxkBUakz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDXzqmUNkRn9vAdBw--.28304S2;
	Mon, 25 Nov 2024 16:34:28 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwA3jnqJNkRnr8FZAA--.8389S3;
	Mon, 25 Nov 2024 16:34:18 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: marcin.juszkiewicz@linaro.org,
	ardb+tianocore@kernel.org,
	quic_llindhol@quicinc.com,
	Jonathan.Cameron@Huawei.com
Cc: chenbaozi@phytium.com.cn,
	devel@edk2.groups.io,
	linux-cxl@vger.kernel.org,
	asa-dev@op-lists.linaro.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH edk2-platforms v3 0/1] add basic support for CXL on sbsa-ref
Date: Mon, 25 Nov 2024 16:34:13 +0800
Message-Id: <20241125083414.53044-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwA3jnqJNkRnr8FZAA--.8389S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWdDg3QCaAACs7
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Ar1kWF4DCw1UWr4UtFyUtrb_yoW3Cw4UpF
	1UtFs0gr4kA347Cr4xuF17Aw13u34SyF4UJr9rJryj9F15Xw15XrZ5JryjgryUAr4kGr1j
	qFnrtw10q348GaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

v2 -> v3:
- PCDs values of pio, mmio32, mmio64 & ecam space for the independent cxl host
- CXL Bus range: 0x00 ~ 0xff
- Mcfg ecam structure for cxl
- Iort RC node for cxl

RFC because
- Many contents are ported from Jonathan' patch on qemu virt design

- Bring plenty of PCDs values

- Less experience and not particularly confident in ACPI area

This series leverages Jonathan's patches[1] to add acpi0016 & acpi0017 objects into the
previous DSDT table of sbsa-ref. Since my latest acpi0016 implementation model on qemu
side is a new host bridge qemu object rather than pxb-cxl, the cxl host(Segment 0001)
would have its own ECAM sapce. Meanwhile, this adds exclusive pio, mmio32 & mmio64 space
for cxl host.

As sbsa-ref cxl host has its own ecam space, this defines the bus range of cxl host from
0x0 to 0xff. Therefore, this adds relevant BASE_ADDRESS_ALLOCATION_STRUCTURE for cxl in Mcfg.
And to enable msi of cxl components, this add a new RC node in Iort.

Based on the new CEDT definitions patch on edk2[2], this series adds a static Cedt.aslc to
support the [SBSA_CXL_CHBCR] & [SBSA_CXL_FIXED_WINDOW] space on sbsa-ref.

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-2-Jonathan.Cameron@huawei.com/
[2]: https://edk2.groups.io/g/devel/topic/rfc_edk2_patch_v3_0_1/109403423#

Below are the new result of acpi tables (the DSDT contents could see the patch itself):

1) MCFG
[000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
[004h 0004 004h]                Table Length : 0000004C
[008h 0008 001h]                    Revision : 01
[009h 0009 001h]                    Checksum : 5A
[00Ah 0010 006h]                      Oem ID : "LINARO"
[010h 0016 008h]                Oem Table ID : "SBSAQEMU"
[018h 0024 004h]                Oem Revision : 20240625
[01Ch 0028 004h]             Asl Compiler ID : "LNRO"
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 008h]                    Reserved : 0000000000000000

[02Ch 0044 008h]                Base Address : 00000000F0000000
[034h 0052 002h]        Segment Group Number : 0000
[036h 0054 001h]            Start Bus Number : 00
[037h 0055 001h]              End Bus Number : FF
[038h 0056 004h]                    Reserved : 00000000

[03Ch 0060 008h]                Base Address : 0000000068140000
[044h 0068 002h]        Segment Group Number : 0001
[046h 0070 001h]            Start Bus Number : 00
[047h 0071 001h]              End Bus Number : FF
[048h 0072 004h]                    Reserved : 00000000

2) IORT
[000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
[004h 0004 004h]                Table Length : 00000118
[008h 0008 001h]                    Revision : 06
[009h 0009 001h]                    Checksum : D3
[00Ah 0010 006h]                      Oem ID : "LINARO"
[010h 0016 008h]                Oem Table ID : "SBSAQEMU"
[018h 0024 004h]                Oem Revision : 20240625
[01Ch 0028 004h]             Asl Compiler ID : "LNRO"
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 004h]                  Node Count : 00000004
[028h 0040 004h]                 Node Offset : 00000030
[02Ch 0044 004h]                    Reserved : 00000000

[030h 0048 001h]                        Type : 00
[031h 0049 002h]                      Length : 0018
[033h 0051 001h]                    Revision : 00
[034h 0052 004h]                  Identifier : 00000000
[038h 0056 004h]               Mapping Count : 00000000
[03Ch 0060 004h]              Mapping Offset : 00000000

[040h 0064 004h]                    ItsCount : 00000001
[044h 0068 004h]                 Identifiers : 00000000

[048h 0072 001h]                        Type : 04
[049h 0073 002h]                      Length : 0058
[04Bh 0075 001h]                    Revision : 05
[04Ch 0076 004h]                  Identifier : 00000000
[050h 0080 004h]               Mapping Count : 00000001
[054h 0084 004h]              Mapping Offset : 00000044

[058h 0088 008h]                Base Address : 0000000060050000
[060h 0096 004h]       Flags (decoded below) : 00000001
                             COHACC Override : 1
                               HTTU Override : 0
                      Proximity Domain Valid : 0
                              DeviceID Valid : 0
[064h 0100 004h]                    Reserved : 00000000
[068h 0104 008h]               VATOS Address : 0000000000000000
[070h 0112 004h]                       Model : 00000000
[074h 0116 004h]                  Event GSIV : 0000004A
[078h 0120 004h]                    PRI GSIV : 0000004B
[07Ch 0124 004h]                   GERR GSIV : 0000004D
[080h 0128 004h]                   Sync GSIV : 0000004C
[084h 0132 004h]            Proximity Domain : 00000000
[088h 0136 004h]     Device ID Mapping Index : 00000001

[08Ch 0140 004h]                  Input base : 00000000
[090h 0144 004h]                    ID Count : 0000FFFF
[094h 0148 004h]                 Output Base : 00000000
[098h 0152 004h]            Output Reference : 00000030
[09Ch 0156 004h]       Flags (decoded below) : 00000000
                              Single Mapping : 0

[0A0h 0160 001h]                        Type : 02
[0A1h 0161 002h]                      Length : 003C
[0A3h 0163 001h]                    Revision : 00
[0A4h 0164 004h]                  Identifier : 00000000
[0A8h 0168 004h]               Mapping Count : 00000001
[0ACh 0172 004h]              Mapping Offset : 00000028

[0B0h 0176 008h]           Memory Properties : [IORT Memory Access Properties]
[0B0h 0176 004h]             Cache Coherency : 00000001
[0B4h 0180 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[0B5h 0181 002h]                    Reserved : 0000
[0B7h 0183 001h] Memory Flags (decoded below) : 01
                                   Coherency : 1
                            Device Attribute : 0
               Ensured Coherency of Accesses : 0
[0B8h 0184 004h]               ATS Attribute : 00000000
[0BCh 0188 004h]          PCI Segment Number : 00000000
[0C0h 0192 001h]           Memory Size Limit : 00
[0C1h 0193 002h]          PASID Capabilities : 0000
[0C3h 0195 001h]                    Reserved : 00

[0C8h 0200 004h]                  Input base : 00000000
[0CCh 0204 004h]                    ID Count : 0000FFFF
[0D0h 0208 004h]                 Output Base : 00000000
[0D4h 0212 004h]            Output Reference : 00000048
[0D8h 0216 004h]       Flags (decoded below) : 00000000
                              Single Mapping : 0

[0DCh 0220 001h]                        Type : 02
[0DDh 0221 002h]                      Length : 003C
[0DFh 0223 001h]                    Revision : 00
[0E0h 0224 004h]                  Identifier : 00000001
[0E4h 0228 004h]               Mapping Count : 00000001
[0E8h 0232 004h]              Mapping Offset : 00000028

[0ECh 0236 008h]           Memory Properties : [IORT Memory Access Properties]
[0ECh 0236 004h]             Cache Coherency : 00000001
[0F0h 0240 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[0F1h 0241 002h]                    Reserved : 0000
[0F3h 0243 001h] Memory Flags (decoded below) : 01
                                   Coherency : 1
                            Device Attribute : 0
               Ensured Coherency of Accesses : 0
[0F4h 0244 004h]               ATS Attribute : 00000000
[0F8h 0248 004h]          PCI Segment Number : 00000001
[0FCh 0252 001h]           Memory Size Limit : 00
[0FDh 0253 002h]          PASID Capabilities : 0000
[0FFh 0255 001h]                    Reserved : 00

[104h 0260 004h]                  Input base : 00000000
[108h 0264 004h]                    ID Count : 0000FFFF
[10Ch 0268 004h]                 Output Base : 00010000
[110h 0272 004h]            Output Reference : 00000030
[114h 0276 004h]       Flags (decoded below) : 00000000
                              Single Mapping : 0

3) CEDT
[000h 0000 004h]                   Signature : "CEDT"    [CXL Early Discovery Table]
[004h 0004 004h]                Table Length : 000000A8
[008h 0008 001h]                    Revision : 01
[009h 0009 001h]                    Checksum : 50
[00Ah 0010 006h]                      Oem ID : "LINARO"
[010h 0016 008h]                Oem Table ID : "SBSAQEMU"
[018h 0024 004h]                Oem Revision : 20240625
[01Ch 0028 004h]             Asl Compiler ID : "LNRO"
[020h 0032 004h]       Asl Compiler Revision : 00000001


[024h 0036 001h]               Subtable Type : 00 [CXL Host Bridge Structure]
[025h 0037 001h]                    Reserved : 00
[026h 0038 002h]                      Length : 0020
[028h 0040 004h]      Associated host bridge : 00000001
[02Ch 0044 004h]       Specification version : 00000001
[030h 0048 004h]                    Reserved : 00000000
[034h 0052 008h]               Register base : 0000000060120000
[03Ch 0060 008h]             Register length : 0000000000010000

[044h 0068 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[045h 0069 001h]                    Reserved : 00
[046h 0070 002h]                      Length : 0064
[048h 0072 004h]                    Reserved : 00000000
[04Ch 0076 008h]         Window base address : 00000A0000000000
[054h 0084 008h]                 Window size : 0000010000000000
[05Ch 0092 001h]          Interleave Members : 00
[05Dh 0093 001h]       Interleave Arithmetic : 00
[05Eh 0094 002h]                    Reserved : 0000
[060h 0096 004h]                 Granularity : 00000000
[064h 0100 002h]                Restrictions : 000F
[066h 0102 002h]                       QtgId : 0001
[068h 0104 004h]                First Target : 00000001

Yuquan Wang (1):
  SbsaQemu: Support basic CXL enablement

 Platform/Qemu/SbsaQemu/SbsaQemu.dsc           |  21 ++
 .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  24 ++
 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    |  69 ++++
 Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl     | 327 ++++++++++++++++++
 Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc    |   9 +-
 .../Drivers/SbsaQemuAcpiDxe/SbsaQemuAcpiDxe.c |  40 ++-
 Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  28 ++
 7 files changed, 515 insertions(+), 3 deletions(-)
 create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc

-- 
2.34.1

