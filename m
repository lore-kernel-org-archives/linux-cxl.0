Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328C55E73
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545296; cv=none; b=TkOm1f1Aukm4Q7inBDYoHPdFUusZaraZ6gxBGv4juRcIvFTSoLfUmoVmFE5vFCZ7Q2chTNCx3zeD9tZEQ/dFIk3W45YGS7PLV700Z52zbBedz74s840U/0ubJt5lbMmoNUjO76j5fVOKOBuwYsMGauXxWEucPKekKBGEPt34xos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545296; c=relaxed/simple;
	bh=OgpbG//JhGm05YA73XD/4zicAgcNaQSJlwAQHvCWZ7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4+4PjZSxM4XAoQy2Tq7BKPVUhmPIsj2uwtg75hcVbDQ5kyL+EFbJYMu/AHxm5ICUx0V2/n8vaLwGnWCtgIixykijMrwysPQs6X7H2nBTrb5do6YG4QEicCjOnKQTWzLuKzo8XKpYJyHjaJjxhSa6+PgvwxHvXFp57WU+eWY8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vm0xp5FNQz6K5xc;
	Fri, 24 May 2024 18:04:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4ABF0140B54;
	Fri, 24 May 2024 18:08:12 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 11:08:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
	<imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 6/6] bios-tables-test: Add data for complex numa test (GI, GP etc)
Date: Fri, 24 May 2024 11:05:07 +0100
Message-ID: <20240524100507.32106-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
References: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

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

[000h 0000 004h]                   Signature : "SRAT"    [System Resource A=
ffinity Table]

[030h 0048 001h]               Subtable Type : 00 [Processor Local APIC/SAP=
IC Affinity]
[032h 0050 001h]     Proximity Domain Low(8) : 00
[033h 0051 001h]                     Apic ID : 00

[040h 0064 001h]               Subtable Type : 00 [Processor Local APIC/SAP=
IC Affinity]
[042h 0066 001h]     Proximity Domain Low(8) : 03                          =
                                                                           =
                                                                           =
                                                      [043h 0067 001h]     =
                Apic ID : 01

[050h 0080 001h]               Subtable Type : 00 [Processor Local APIC/SAP=
IC Affinity]
[052h 0082 001h]     Proximity Domain Low(8) : 05
[053h 0083 001h]                     Apic ID : 02

[060h 0096 001h]               Subtable Type : 01 [Memory Affinity]
[062h 0098 004h]            Proximity Domain : 00000000
[068h 0104 008h]                Base Address : 0000000000000000
[070h 0112 008h]              Address Length : 00000000000A0000

[088h 0136 001h]               Subtable Type : 01 [Memory Affinity]
[08Ah 0138 004h]            Proximity Domain : 00000000
[090h 0144 008h]                Base Address : 0000000000100000
[098h 0152 008h]              Address Length : 0000000003F00000
[0A8h 0168 008h]                   Reserved3 : 0000000000000000

[0B0h 0176 001h]               Subtable Type : 01 [Memory Affinity]
[0B2h 0178 004h]            Proximity Domain : 00000004
[0B8h 0184 008h]                Base Address : 0000000004000000
[0C0h 0192 008h]              Address Length : 0000000004000000

//Comment in hw/i386/aml-build.c on why these exist - not part of
//ACPI requirements.
[0D8h 0216 001h]               Subtable Type : 01 [Memory Affinity]
[0DAh 0218 004h]            Proximity Domain : 00000000
[0E0h 0224 008h]                Base Address : 0000000000000000
[0E8h 0232 008h]              Address Length : 0000000000000000

[100h 0256 001h]               Subtable Type : 01 [Memory Affinity]
[102h 0258 004h]            Proximity Domain : 00000000
[108h 0264 008h]                Base Address : 0000000000000000
[110h 0272 008h]              Address Length : 0000000000000000

[128h 0296 001h]               Subtable Type : 01 [Memory Affinity]
[12Ah 0298 004h]            Proximity Domain : 00000000
[130h 0304 008h]                Base Address : 0000000000000000
[138h 0312 008h]              Address Length : 0000000000000000

[150h 0336 001h]               Subtable Type : 01 [Memory Affinity]
[152h 0338 004h]            Proximity Domain : 00000000
[158h 0344 008h]                Base Address : 0000000000000000
[160h 0352 008h]              Address Length : 0000000000000000

[178h 0376 001h]               Subtable Type : 01 [Memory Affinity]
[17Ah 0378 004h]            Proximity Domain : 00000000
[180h 0384 008h]                Base Address : 0000000000000000
[188h 0392 008h]              Address Length : 0000000000000000
// End of strange empty Memory Affinity structures.

[1A0h 0416 001h]               Subtable Type : 05 [Generic Initiator Affini=
ty]
[1A3h 0419 001h]          Device Handle Type : 01
[1A4h 0420 004h]            Proximity Domain : 00000001
[1A8h 0424 010h]               Device Handle : 00 00 10 00 00 00 00 00 00 0=
0 00 00 00 00 00 00

[1C0h 0448 001h]               Subtable Type : 06 [Generic Port Affinity]
[1C3h 0451 001h]          Device Handle Type : 00
[1C4h 0452 004h]            Proximity Domain : 00000002
[1C8h 0456 010h]               Device Handle : 41 43 50 49 30 30 31 36 40 0=
0 00 00 00 00 00 00

[1E0h 0480 001h]               Subtable Type : 01 [Memory Affinity]
[1E2h 0482 004h]            Proximity Domain : 00000005
[1E8h 0488 008h]                Base Address : 0000000100000000
[1F0h 0496 008h]              Address Length : 0000000090000000
[1FCh 0508 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0

Example block from HMAT:
[0F0h 0240 002h]              Structure Type : 0001 [System Locality Latenc=
y and Bandwidth Information]                                               =
                                                                           =
                                                       [0F2h 0242 002h]    =
                Reserved : 0000                                            =
                                                                           =
                                                                           =
                                   [0F4h 0244 004h]                      Le=
ngth : 00000078                                                            =
                                                                           =
                                                                           =
               [0F8h 0248 001h]       Flags (decoded below) : 00           =
                                                                           =
                                                                           =
                                                                           =
                       Memory Hierarchy : 0                                =
                                                                           =
                                                                           =
                                                                     Use Mi=
nimum Transfer Size : 0                                                    =
                                                                           =
                                                                           =
                                                  Non-sequential Transfers =
: 0
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
 tests/qtest/bios-tables-test-allowed-diff.h |   5 -----
 tests/data/acpi/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 tests/data/acpi/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 tests/data/acpi/q35/DSDT.acpihmat-generic-x | Bin 0 -> 10400 bytes
 tests/data/acpi/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 tests/data/acpi/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 6 files changed, 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios=
-tables-test-allowed-diff.h
index a5aa801c99..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/APIC.acpihmat-generic-x",
-"tests/data/acpi/q35/CEDT.acpihmat-generic-x",
-"tests/data/acpi/q35/DSDT.acpihmat-generic-x",
-"tests/data/acpi/q35/HMAT.acpihmat-generic-x",
-"tests/data/acpi/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/q35/APIC.acpihmat-generic-x b/tests/data/acpi/=
q35/APIC.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..317ddb3fbed94e4f49a87976fdc=
7f23b1a6c3fdc 100644
GIT binary patch
literal 136
zcmZ<^@O18AU|?WQaPoKd2v%^42yj*a0!E-1hz+6{7#{os(;N&85Soz@LNhUeXht58
ongjnpBoh}9gBTzdD=3DU!Z1+h3eVJt470*DwlH<-o3_8({j09efo0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/=
q35/CEDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..31c9011663639b4a0f4816f3b2b=
06398f94682f7 100644
GIT binary patch
literal 68
zcmZ>EbqR4{U|?Xhb@F%i2v%^42yj*a0!E-1hz+6{7!(*BfFy(s;xkNuupuM>Q<et-

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/=
q35/DSDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a04451374d1b95764d34fbda1ec=
791a89ffdcc46 100644
GIT binary patch
literal 10400
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
N*0k6;sNmDM{|8%*0ha&(

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/=
q35/HMAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0e5765f6ee4c07638c70647ae14=
5e968718b67cd 100644
GIT binary patch
literal 360
zcmeb9bqvX1WME+Ock*}k2v%^42yj*a0-z8Bhz+7)Km*7?=3DEKC%X^=3DV)XaHgs5CaPU
znNtB32dQC$vIW$k3?Kzk!wkf%P$3YX2`UEC0}=3D;`ae=3DW2gAr7W703dq;{anOBsL>h
pJ=3Dk8L!N~R^yOS7uPXNsZ*=3DNL%!XOExQ-JsckOiV);t2K$1^{D&4*>uG

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/=
q35/SRAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..cbf45a31ba6d2c06f2bb0e203d4=
b40100522ac08 100644
GIT binary patch
literal 520
zcmWFzatz^MVqjoQbMklg2v%^42yj*a0!9V~1`r!WgD@Njp!1m-QRP{gkok-naGg*F
z7hC|lI-mt$@PQeo5LF!uOc=3D(1(J1c3v=3D^ogl^*QsSQQwc;R_2Fi2Gq-!luB$0E|8c
gN9O=3Df0|P@d2Z%I0EEqLdp(5~jn*bAl2QW|o04j0}0RR91

literal 0
HcmV?d00001

--=20
2.39.2

