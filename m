Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CCE57D
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508753; cv=none; b=LVMuCvQQTuYuAE5wcjM+E1ZSwnbZLptJGCg1bp0LP+4JGIbr1f8/BjvsFlFpxSv7uv0d72YW5TB8aXGyrmrwBukiN/pRpRND4afshLUF3X0VMiLcD6Ji1sWth4QbTn5pkDRwU6+jW848g/OJSRB3PxKg06NgdWv8x/8KQArJyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508753; c=relaxed/simple;
	bh=4BBySxzL2kwxgQBYkK5RabwQYlarT9iVRfpo3Q2OEhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pgv/OtT4Ynrb0F/dO/kGAGNTKBGd2UeUZq9XzLZQQP+TQQG2iNtYyPGgvWo7aQxTU+/ilVTJwu9b2dHeOuyP1OktiAjdrmrX9g3TVzAVrgJu3Wu+R4+xOebsXaxD7UQ9uv5FpODwVA68YCEZWf6UCrw5MgeJk0xo3TxvzIWs7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sfz26wbz6LD8B;
	Tue, 17 Sep 2024 01:42:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E33C140AB8;
	Tue, 17 Sep 2024 01:45:48 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:45:44 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v6 15/15] bios-tables-test: Add data for complex numa test (GI, GP etc)
Date: Mon, 16 Sep 2024 18:45:43 +0100
Message-ID: <20240916174543.1843276-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
References: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

Given this is a new configuration, there are affects on APIC, CEDT
and DSDT, but the key elements are in SRAT (plus related data in
HMAT).  The configuration has node to exercise many different combinations.

0) CPUs + Memory
1) GI only
2) GP only
3) CPUS only
4) Memory only
5) CPUs + HP memory

GI node, GP Node, Memory only node, hotplug memory
only node, latency and bandwidth such that in Linux Access0
(any initiator) and Access1 (CPU initiators only) given different
answers.  Following cropped to remove details of each entry.

[000h 0000 004h]                   Signature : "SRAT"    [System Resource Affinity Table]
...
[030h 0048 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[032h 0050 001h]     Proximity Domain Low(8) : 00
[033h 0051 001h]                     Apic ID : 00
...
[040h 0064 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[042h 0066 001h]     Proximity Domain Low(8) : 03
[043h 0067 001h]                     Apic ID : 01
...
[050h 0080 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[052h 0082 001h]     Proximity Domain Low(8) : 05
[053h 0083 001h]                     Apic ID : 02
...
[060h 0096 001h]               Subtable Type : 01 [Memory Affinity]
...
[062h 0098 004h]            Proximity Domain : 00000000
...
[068h 0104 008h]                Base Address : 0000000000000000
[070h 0112 008h]              Address Length : 00000000000A0000
...
[088h 0136 001h]               Subtable Type : 01 [Memory Affinity]
...
[08Ah 0138 004h]            Proximity Domain : 00000000
...
[090h 0144 008h]                Base Address : 0000000000100000
[098h 0152 008h]              Address Length : 0000000003F00000
...
[0B0h 0176 001h]               Subtable Type : 01 [Memory Affinity]
...
[0B2h 0178 004h]            Proximity Domain : 00000004
...
[0B8h 0184 008h]                Base Address : 0000000004000000
[0C0h 0192 008h]              Address Length : 0000000004000000
... some zero length entries follow...

[1A0h 0416 001h]               Subtable Type : 05 [Generic Initiator Affinity]
[1A1h 0417 001h]                      Length : 20

[1A2h 0418 001h]                   Reserved1 : 00
[1A3h 0419 001h]          Device Handle Type : 01
[1A4h 0420 004h]            Proximity Domain : 00000001
[1A8h 0424 010h]               Device Handle : 00 00 01 02 00 00 00 00 00 00 00 00 00 00 00 00
[1B8h 0440 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                  Architectural Transactions : 0
[1BCh 0444 004h]                   Reserved2 : 00000000

[1C0h 0448 001h]               Subtable Type : 06 [Generic Port Affinity]
[1C1h 0449 001h]                      Length : 20

[1C2h 0450 001h]                   Reserved1 : 00
[1C3h 0451 001h]          Device Handle Type : 00
[1C4h 0452 004h]            Proximity Domain : 00000002
[1C8h 0456 010h]               Device Handle : 41 43 50 49 30 30 31 36 40 00 00 00 00 00 00 00
[1D8h 0472 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                  Architectural Transactions : 0
[1DCh 0476 004h]                   Reserved2 : 00000000

[1E0h 0480 001h]               Subtable Type : 01 [Memory Affinity]
...
[1E2h 0482 004h]            Proximity Domain : 00000005
...
[1E8h 0488 008h]                Base Address : 0000000100000000
[1F0h 0496 008h]              Address Length : 0000000090000000

Example block from HMAT:
[0F0h 0240 002h]              Structure Type : 0001 [System Locality Latency and Bandwidth Information]
[0F2h 0242 002h]                    Reserved : 0000
[0F4h 0244 004h]                      Length : 00000078
[0F8h 0248 001h]       Flags (decoded below) : 00
                            Memory Hierarchy : 0
                   Use Minimum Transfer Size : 0
                    Non-sequential Transfers : 0
[0F9h 0249 001h]                   Data Type : 03
[0FAh 0250 001h]       Minimum Transfer Size : 00
[0FBh 0251 001h]                   Reserved1 : 00
[0FCh 0252 004h] Initiator Proximity Domains # : 00000004
[100h 0256 004h]  Target Proximity Domains # : 00000006
[104h 0260 004h]                   Reserved2 : 00000000
[108h 0264 008h]             Entry Base Unit : 0000000000000004
[110h 0272 004h] Initiator Proximity Domain List : 00000000
[114h 0276 004h] Initiator Proximity Domain List : 00000001
[118h 0280 004h] Initiator Proximity Domain List : 00000003
[11Ch 0284 004h] Initiator Proximity Domain List : 00000005
[120h 0288 004h] Target Proximity Domain List : 00000000
[124h 0292 004h] Target Proximity Domain List : 00000001
[128h 0296 004h] Target Proximity Domain List : 00000002
[12Ch 0300 004h] Target Proximity Domain List : 00000003
[130h 0304 004h] Target Proximity Domain List : 00000004
[134h 0308 004h] Target Proximity Domain List : 00000005
[138h 0312 002h]                       Entry : 00C8
[13Ah 0314 002h]                       Entry : 0000
[13Ch 0316 002h]                       Entry : 0032
[13Eh 0318 002h]                       Entry : 0000
[140h 0320 002h]                       Entry : 0032
[142h 0322 002h]                       Entry : 0064
[144h 0324 002h]                       Entry : 0019
[146h 0326 002h]                       Entry : 0000
[148h 0328 002h]                       Entry : 0064
[14Ah 0330 002h]                       Entry : 0000
[14Ch 0332 002h]                       Entry : 00C8
[14Eh 0334 002h]                       Entry : 0019
[150h 0336 002h]                       Entry : 0064
[152h 0338 002h]                       Entry : 0000
[154h 0340 002h]                       Entry : 0032
[156h 0342 002h]                       Entry : 0000
[158h 0344 002h]                       Entry : 0032
[15Ah 0346 002h]                       Entry : 0064
[15Ch 0348 002h]                       Entry : 0064
[15Eh 0350 002h]                       Entry : 0000
[160h 0352 002h]                       Entry : 0032
[162h 0354 002h]                       Entry : 0000
[164h 0356 002h]                       Entry : 0032
[166h 0358 002h]                       Entry : 00C8

Note the zeros represent entries where the target node has no
memory.  These could be surpressed but it isn't 'wrong' to provide
them and it is (probably) permissible under ACPI to hotplug memory
into these nodes later.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v6: Rebased - required data update.
---
 tests/qtest/bios-tables-test-allowed-diff.h     |   5 -----
 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 0 -> 12566 bytes
 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 6 files changed, 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3c0967078f..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/APIC.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x b/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..317ddb3fbed94e4f49a87976fdc7f23b1a6c3fdc 100644
GIT binary patch
literal 136
zcmZ<^@O18AU|?WQaPoKd2v%^42yj*a0!E-1hz+6{7#{os(;N&85Soz@LNhUeXht58
ongjnpBoh}9gBTzdD=U!Z1+h3eVJt470*DwlH<-o3_8({j09efo0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..31c9011663639b4a0f4816f3b2b06398f94682f7 100644
GIT binary patch
literal 68
zcmZ>EbqR4{U|?Xhb@F%i2v%^42yj*a0!E-1hz+6{7!(*BfFy(s;xkNuupuM>Q<et-

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..109cd7cb8d290ede75f2e1720461fa63d627b332 100644
GIT binary patch
literal 12566
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

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0e5765f6ee4c07638c70647ae145e968718b67cd 100644
GIT binary patch
literal 360
zcmeb9bqvX1WME+Ock*}k2v%^42yj*a0-z8Bhz+7)Km*7?=EKC%X^=V)XaHgs5CaPU
znNtB32dQC$vIW$k3?Kzk!wkf%P$3YX2`UEC0}=;`ae=W2gAr7W703dq;{anOBsL>h
pJ=k8L!N~R^yOS7uPXNsZ*=NL%!XOExQ-JsckOiV);t2K$1^{D&4*>uG

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b45838adb7d304f8a36c38c90d89f3629ec48353 100644
GIT binary patch
literal 520
zcmWFzatz^MVqjn_cJg=j2v%^42yj*a0!9V~1`r!WgD@Njp!1m-QRP{gkok-naGg*F
z7hC|lI-mt$@PQeo5LF!uOc=(1(J1c3v=^ogl^*QsSQQwc;mZh&B?N$l37Y}~14zQr
eIl$Avz|hPAsstv_sKE*qfydhfm;gM0fdT+OoeTj0

literal 0
HcmV?d00001

-- 
2.43.0

