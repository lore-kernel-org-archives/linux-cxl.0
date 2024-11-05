Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D302EB1F
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802973; cv=none; b=q0CCd2Rs6pHhrbSZSp/1kR7VarD5KCr5ob8MqxNpM0u1w7l6M2tut+GVHI2+Emk1KJLhNmVq03pctTmvTOLe5c8g/UoamOCB63SB9GUn6i4Lz8RgAQC3udu/Nogno+S2pKvCHSxxjPsK5uUYj/+H1y0fLTgsJh6N5IFCeRdsgiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802973; c=relaxed/simple;
	bh=ZfQEkNQ7iBPfqY4vjAbtzmlESkaH7pKHYMmBVRnhTwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCbE3Cmaw+uzC2tL784qH1cMfUuncwbWzSBta1m6RiSlPnWRwyhlXkE6cVgjHY+Zqrlxlm8Dthdn37LCNwTpAiGdbbFLQGFOC0XxGz1Gu46vWDuOWZbxmZgK16rpuXs5ktkwuyzJE13optnt0f5ogW8+AKPuMjODqNFjenKUrlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAnaAwM9SlnNsOHAw--.38496S2;
	Tue, 05 Nov 2024 18:35:56 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwCH3nr99ClnV4xHAA--.23012S4;
	Tue, 05 Nov 2024 18:35:50 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com,
	marcin.juszkiewicz@linaro.org,
	ardb+tianocore@kernel.org,
	quic_llindhol@quicinc.com,
	peter.maydell@linaro.org
Cc: chenbaozi@phytium.com.cn,
	devel@edk2.groups.io,
	linux-cxl@vger.kernel.org,
	asa-dev@op-lists.linaro.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH edk2-platforms v2 1/1] SbsaQemu: Support basic CXL enablement
Date: Tue,  5 Nov 2024 18:35:23 +0800
Message-Id: <20241105103523.415774-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105103523.415774-1-wangyuquan1236@phytium.com.cn>
References: <20241105103523.415774-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCH3nr99ClnV4xHAA--.23012S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWcpJZAFgAAAs+
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfuw1xKw13ZrWDJr4fArWDurg_yoW8KryxCo
	WUGry5uFs7WF1UZw18CrZFgFn2vFnxA3WI9w1SyFyUZayIvr97Jry8tw43Gr98JwnFqrnI
	vr4xXas8Jas5ZFZ5n29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
	J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
	UUUUUUU==

This adds relevant definitions and descriptions of acpi0016, acpi0017
and CEDT to support CXL.

1) To prevent breaking the original pcie mmio space, this adds
exclusive mmio32 & mmio64 space for cxl host.

2) This defines the pcie bus range of cxl host is 0xc0 ~ 0xff, since
the pxb-cxl-host as well as cxl components on it would occupy the
original pcie buses, the original pcie ecam space should divided
some range for pxb-cxl-host.

3) Provide CXL Early Discovery Table that describes the static CXL
Platform Components of sbsa-ref, which includes a static CXL Host
Bridge structure and a CXL Fixed Memory Window structure which
are implemented as two independent space on sbsa-ref:
[SBSA_CXL_HOST] & [SBSA_CXL_FIXED_WINDOW].

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 Platform/Qemu/SbsaQemu/SbsaQemu.dsc           |  23 +-
 .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  19 +
 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    |  69 +++
 Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl     | 401 +++++++++++++++++-
 Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc    |   2 +-
 Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  34 +-
 6 files changed, 537 insertions(+), 11 deletions(-)
 create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc

diff --git a/Platform/Qemu/SbsaQemu/SbsaQemu.dsc b/Platform/Qemu/SbsaQemu/SbsaQemu.dsc
index 4441f5f101fc..bf37f52f4953 100644
--- a/Platform/Qemu/SbsaQemu/SbsaQemu.dsc
+++ b/Platform/Qemu/SbsaQemu/SbsaQemu.dsc
@@ -446,7 +446,7 @@ DEFINE NETWORK_HTTP_BOOT_ENABLE       = FALSE
   #
   # ECAM size == 0x10000000
   gArmTokenSpaceGuid.PcdPciBusMin|0
-  gArmTokenSpaceGuid.PcdPciBusMax|255
+  gArmTokenSpaceGuid.PcdPciBusMax|191
   gArmTokenSpaceGuid.PcdPciIoBase|0x0
   gArmTokenSpaceGuid.PcdPciIoSize|0x00010000
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciIoLimit|0x0000ffff
@@ -457,12 +457,29 @@ DEFINE NETWORK_HTTP_BOOT_ENABLE       = FALSE
   gArmTokenSpaceGuid.PcdPciMmio64Size|0xFF00000000
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio64Limit|0xFFFFFFFFFF
 
+  #
+  # CXL Host Bridge (pxb-cxl on PCI Root Complex)
+  #
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin|192
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax|255
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Base|0x60130000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Size|0x02000000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Base|0x90000000000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Size|0x00100000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Limit|0x6212FFFF
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Limit|0x900000FFFFF
+
   # set PcdPciExpressBaseAddress to MAX_UINT64, which signifies that this
   # PCD and PcdPciDisableBusEnumeration have not been assigned yet
   # TODO: PcdPciExpressBaseAddress set to max_uint64
   gEfiMdePkgTokenSpaceGuid.PcdPciExpressBaseAddress|0xf0000000
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize|0x10000000
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit|0xFFFFFFFF
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize|0x0C000000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit|0xFBFFFFFF
+
+  # PCDs complementing CXL ECAM Base & Size
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBaseAddress|0xFC000000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize|0x04000000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit|0xFFFFFFFF
 
   gEfiMdePkgTokenSpaceGuid.PcdPciIoTranslation|0x7fff0000
   gEfiMdePkgTokenSpaceGuid.PcdPciMmio32Translation|0x0
diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
index 8d4905362edc..7a692e1b25d7 100644
--- a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
@@ -16,6 +16,7 @@
   VERSION_STRING                 = 1.0
 
 [Sources]
+  Cedt.aslc
   Dbg2.aslc
   Dsdt.asl
   Fadt.aslc
@@ -44,6 +45,8 @@
 
   gArmTokenSpaceGuid.PcdPciBusMin
   gArmTokenSpaceGuid.PcdPciBusMax
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax
 
   gArmTokenSpaceGuid.PcdPciIoBase
   gArmTokenSpaceGuid.PcdPciIoSize
@@ -60,10 +63,26 @@
   gEfiMdePkgTokenSpaceGuid.PcdPciMmio64Translation
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio64Limit
 
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Base
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Size
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Limit
+
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Base
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Size
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Limit
+
   gEfiMdePkgTokenSpaceGuid.PcdPciExpressBaseAddress
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit
 
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBaseAddress
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit
+
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmws0Base
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmws0Size
+
   gEfiMdeModulePkgTokenSpaceGuid.PcdSerialRegisterBase
 
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPlatformAhciBase
diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc b/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
new file mode 100644
index 000000000000..56d6cf8f48b0
--- /dev/null
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
@@ -0,0 +1,69 @@
+/** @file
+*  CXL Early Discovery Table (CEDT)
+*
+*  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
+*
+**/
+
+#include <IndustryStandard/Cxl30.h>
+#include <IndustryStandard/SbsaQemuAcpi.h>
+
+#pragma pack(1)
+
+typedef struct
+{
+  CXL_EARLY_DISCOVERY_TABLE           Header;
+  CXL_HOST_BRIDGE_STRUCTURE           Chbs;
+  CXL_FIXED_MEMORY_WINDOW_STRUCTURE   Cfmws;
+} SBSA_REF_CEDT;
+
+
+SBSA_REF_CEDT Cedt =
+{
+  // CXL_EARLY_DISCOVERY_TABLE(CEDT Header)
+  {
+     SBSAQEMU_ACPI_HEADER  // EFI_ACPI_DESCRIPTION_HEADER
+     (
+       CXL_EARLY_DISCOVERY_TABLE_SIGNATURE,
+       SBSA_REF_CEDT,
+       CXL_EARLY_DISCOVERY_TABLE_REVISION_01
+     ),
+  },
+  // CXL_HOST_BRIDGE_STRUCTURE
+  {
+    // CEDT_STRUCTURE
+    {
+        CEDT_TYPE_CHBS,                                     // Type
+        0,                                                  // Reserved
+        sizeof (CXL_HOST_BRIDGE_STRUCTURE),                 // Length
+    },
+    0x1,                                   // UID
+    0x1,                                   // CXLVersion
+    0,                                     // Reserved
+    FixedPcdGet32 (PcdChbcrBase),          // CHBCR Base
+    0X10000,                               // Length
+  },
+  // CXL_FIXED_MEMORY_WINDOW_STRUCTURE
+  {
+    // CEDT_STRUCTURE
+    {
+        CEDT_TYPE_CFMWS,                                     // Type
+        0,                                                   // Reserved
+        sizeof (CXL_FIXED_MEMORY_WINDOW_STRUCTURE),          // Length
+    },
+    0,                                     // Reserved
+    FixedPcdGet32 (PcdCfmws0Base),         // BaseHPA
+    FixedPcdGet32 (PcdCfmws0Size),         // WindowSize
+    0,                                     // InterleaveMembers
+    0,                                     // InterleaveArithmetic
+    0,                                     // Reserved1
+    0,                                     // Granularity
+    0xF,                                   // Restrictions
+    1,                                     // QtgId
+    {0x1},                                 // TargetList
+  }
+};
+
+#pragma pack ()
+
+VOID* CONST ReferenceAcpiTable = &Cedt;
diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl b/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
index c134fb66e860..dd53ca42be8e 100644
--- a/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
@@ -182,6 +182,372 @@ DefinitionBlock ("DsdtTable.aml", "DSDT",
         } // USB0_RHUB
     } // USB0
 
+    // CXL Host Bridge (pxb-cxl)
+    Device (CXL0)
+    {
+        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
+        Name (_CID, Package (0x02)  // _CID: Compatible ID
+        {
+            EisaId ("PNP0A08"), /* PCI Express Bus */
+            EisaId ("PNP0A03")  /* PCI Bus */
+        })
+        Name (_BBN, 0xC0)  // _BBN: BIOS Bus Number
+        Name (_UID, 0x01)  // _UID: Unique ID
+        Name (_STR, Unicode ("pxb Device"))  // _STR: Description String
+        Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+        Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
+        {
+         PRT_ENTRY(0x0000FFFF, 0, GSI0),
+         PRT_ENTRY(0x0000FFFF, 1, GSI1),
+         PRT_ENTRY(0x0000FFFF, 2, GSI2),
+         PRT_ENTRY(0x0000FFFF, 3, GSI3),
+
+         PRT_ENTRY(0x0001FFFF, 0, GSI1),
+         PRT_ENTRY(0x0001FFFF, 1, GSI2),
+         PRT_ENTRY(0x0001FFFF, 2, GSI3),
+         PRT_ENTRY(0x0001FFFF, 3, GSI0),
+
+         PRT_ENTRY(0x0002FFFF, 0, GSI2),
+         PRT_ENTRY(0x0002FFFF, 1, GSI3),
+         PRT_ENTRY(0x0002FFFF, 2, GSI0),
+         PRT_ENTRY(0x0002FFFF, 3, GSI1),
+
+         PRT_ENTRY(0x0003FFFF, 0, GSI3),
+         PRT_ENTRY(0x0003FFFF, 1, GSI0),
+         PRT_ENTRY(0x0003FFFF, 2, GSI1),
+         PRT_ENTRY(0x0003FFFF, 3, GSI2),
+
+         PRT_ENTRY(0x0004FFFF, 0, GSI0),
+         PRT_ENTRY(0x0004FFFF, 1, GSI1),
+         PRT_ENTRY(0x0004FFFF, 2, GSI2),
+         PRT_ENTRY(0x0004FFFF, 3, GSI3),
+
+         PRT_ENTRY(0x0005FFFF, 0, GSI1),
+         PRT_ENTRY(0x0005FFFF, 1, GSI2),
+         PRT_ENTRY(0x0005FFFF, 2, GSI3),
+         PRT_ENTRY(0x0005FFFF, 3, GSI0),
+
+         PRT_ENTRY(0x0006FFFF, 0, GSI2),
+         PRT_ENTRY(0x0006FFFF, 1, GSI3),
+         PRT_ENTRY(0x0006FFFF, 2, GSI0),
+         PRT_ENTRY(0x0006FFFF, 3, GSI1),
+
+         PRT_ENTRY(0x0007FFFF, 0, GSI3),
+         PRT_ENTRY(0x0007FFFF, 1, GSI0),
+         PRT_ENTRY(0x0007FFFF, 2, GSI1),
+         PRT_ENTRY(0x0007FFFF, 3, GSI2),
+
+         PRT_ENTRY(0x0008FFFF, 0, GSI0),
+         PRT_ENTRY(0x0008FFFF, 1, GSI1),
+         PRT_ENTRY(0x0008FFFF, 2, GSI2),
+         PRT_ENTRY(0x0008FFFF, 3, GSI3),
+
+         PRT_ENTRY(0x0009FFFF, 0, GSI1),
+         PRT_ENTRY(0x0009FFFF, 1, GSI2),
+         PRT_ENTRY(0x0009FFFF, 2, GSI3),
+         PRT_ENTRY(0x0009FFFF, 3, GSI0),
+
+         PRT_ENTRY(0x000AFFFF, 0, GSI2),
+         PRT_ENTRY(0x000AFFFF, 1, GSI3),
+         PRT_ENTRY(0x000AFFFF, 2, GSI0),
+         PRT_ENTRY(0x000AFFFF, 3, GSI1),
+
+         PRT_ENTRY(0x000BFFFF, 0, GSI3),
+         PRT_ENTRY(0x000BFFFF, 1, GSI0),
+         PRT_ENTRY(0x000BFFFF, 2, GSI1),
+         PRT_ENTRY(0x000BFFFF, 3, GSI2),
+
+         PRT_ENTRY(0x000CFFFF, 0, GSI0),
+         PRT_ENTRY(0x000CFFFF, 1, GSI1),
+         PRT_ENTRY(0x000CFFFF, 2, GSI2),
+         PRT_ENTRY(0x000CFFFF, 3, GSI3),
+
+         PRT_ENTRY(0x000DFFFF, 0, GSI1),
+         PRT_ENTRY(0x000DFFFF, 1, GSI2),
+         PRT_ENTRY(0x000DFFFF, 2, GSI3),
+         PRT_ENTRY(0x000DFFFF, 3, GSI0),
+
+         PRT_ENTRY(0x000EFFFF, 0, GSI2),
+         PRT_ENTRY(0x000EFFFF, 1, GSI3),
+         PRT_ENTRY(0x000EFFFF, 2, GSI0),
+         PRT_ENTRY(0x000EFFFF, 3, GSI1),
+
+         PRT_ENTRY(0x000FFFFF, 0, GSI3),
+         PRT_ENTRY(0x000FFFFF, 1, GSI0),
+         PRT_ENTRY(0x000FFFFF, 2, GSI1),
+         PRT_ENTRY(0x000FFFFF, 3, GSI2),
+
+         PRT_ENTRY(0x0010FFFF, 0, GSI0),
+         PRT_ENTRY(0x0010FFFF, 1, GSI1),
+         PRT_ENTRY(0x0010FFFF, 2, GSI2),
+         PRT_ENTRY(0x0010FFFF, 3, GSI3),
+
+         PRT_ENTRY(0x0011FFFF, 0, GSI1),
+         PRT_ENTRY(0x0011FFFF, 1, GSI2),
+         PRT_ENTRY(0x0011FFFF, 2, GSI3),
+         PRT_ENTRY(0x0011FFFF, 3, GSI0),
+
+         PRT_ENTRY(0x0012FFFF, 0, GSI2),
+         PRT_ENTRY(0x0012FFFF, 1, GSI3),
+         PRT_ENTRY(0x0012FFFF, 2, GSI0),
+         PRT_ENTRY(0x0012FFFF, 3, GSI1),
+
+         PRT_ENTRY(0x0013FFFF, 0, GSI3),
+         PRT_ENTRY(0x0013FFFF, 1, GSI0),
+         PRT_ENTRY(0x0013FFFF, 2, GSI1),
+         PRT_ENTRY(0x0013FFFF, 3, GSI2),
+
+         PRT_ENTRY(0x0014FFFF, 0, GSI0),
+         PRT_ENTRY(0x0014FFFF, 1, GSI1),
+         PRT_ENTRY(0x0014FFFF, 2, GSI2),
+         PRT_ENTRY(0x0014FFFF, 3, GSI3),
+
+         PRT_ENTRY(0x0015FFFF, 0, GSI1),
+         PRT_ENTRY(0x0015FFFF, 1, GSI2),
+         PRT_ENTRY(0x0015FFFF, 2, GSI3),
+         PRT_ENTRY(0x0015FFFF, 3, GSI0),
+
+         PRT_ENTRY(0x0016FFFF, 0, GSI2),
+         PRT_ENTRY(0x0016FFFF, 1, GSI3),
+         PRT_ENTRY(0x0016FFFF, 2, GSI0),
+         PRT_ENTRY(0x0016FFFF, 3, GSI1),
+
+         PRT_ENTRY(0x0017FFFF, 0, GSI3),
+         PRT_ENTRY(0x0017FFFF, 1, GSI0),
+         PRT_ENTRY(0x0017FFFF, 2, GSI1),
+         PRT_ENTRY(0x0017FFFF, 3, GSI2),
+
+         PRT_ENTRY(0x0018FFFF, 0, GSI0),
+         PRT_ENTRY(0x0018FFFF, 1, GSI1),
+         PRT_ENTRY(0x0018FFFF, 2, GSI2),
+         PRT_ENTRY(0x0018FFFF, 3, GSI3),
+
+         PRT_ENTRY(0x0019FFFF, 0, GSI1),
+         PRT_ENTRY(0x0019FFFF, 1, GSI2),
+         PRT_ENTRY(0x0019FFFF, 2, GSI3),
+         PRT_ENTRY(0x0019FFFF, 3, GSI0),
+
+         PRT_ENTRY(0x001AFFFF, 0, GSI2),
+         PRT_ENTRY(0x001AFFFF, 1, GSI3),
+         PRT_ENTRY(0x001AFFFF, 2, GSI0),
+         PRT_ENTRY(0x001AFFFF, 3, GSI1),
+
+         PRT_ENTRY(0x001BFFFF, 0, GSI3),
+         PRT_ENTRY(0x001BFFFF, 1, GSI0),
+         PRT_ENTRY(0x001BFFFF, 2, GSI1),
+         PRT_ENTRY(0x001BFFFF, 3, GSI2),
+
+         PRT_ENTRY(0x001CFFFF, 0, GSI0),
+         PRT_ENTRY(0x001CFFFF, 1, GSI1),
+         PRT_ENTRY(0x001CFFFF, 2, GSI2),
+         PRT_ENTRY(0x001CFFFF, 3, GSI3),
+
+         PRT_ENTRY(0x001DFFFF, 0, GSI1),
+         PRT_ENTRY(0x001DFFFF, 1, GSI2),
+         PRT_ENTRY(0x001DFFFF, 2, GSI3),
+         PRT_ENTRY(0x001DFFFF, 3, GSI0),
+
+         PRT_ENTRY(0x001EFFFF, 0, GSI2),
+         PRT_ENTRY(0x001EFFFF, 1, GSI3),
+         PRT_ENTRY(0x001EFFFF, 2, GSI0),
+         PRT_ENTRY(0x001EFFFF, 3, GSI1),
+
+         PRT_ENTRY(0x001FFFFF, 0, GSI3),
+         PRT_ENTRY(0x001FFFFF, 1, GSI0),
+         PRT_ENTRY(0x001FFFFF, 2, GSI1),
+         PRT_ENTRY(0x001FFFFF, 3, GSI2),
+        })
+        Device (GSI0)
+        {
+            Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
+            Name (_UID, Zero)  // _UID: Unique ID
+            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000023,
+                }
+            })
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000023,
+                }
+            })
+            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+            {
+            }
+        }
+
+        Device (GSI1)
+        {
+            Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
+            Name (_UID, One)  // _UID: Unique ID
+            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000024,
+                }
+            })
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000024,
+                }
+            })
+            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+            {
+            }
+        }
+
+        Device (GSI2)
+        {
+            Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
+            Name (_UID, 0x02)  // _UID: Unique ID
+            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000025,
+                }
+            })
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000025,
+                }
+            })
+            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+            {
+            }
+        }
+
+        Device (GSI3)
+        {
+            Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
+            Name (_UID, 0x03)  // _UID: Unique ID
+            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000026,
+                }
+            })
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000026,
+                }
+            })
+            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+            {
+            }
+        }
+
+        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+        {
+            DWordMemory ( // 32-bit BAR Windows
+              ResourceProducer, PosDecode,
+              MinFixed, MaxFixed,
+              Cacheable, ReadWrite,
+              0x00000000,                              // Granularity
+              FixedPcdGet32 (PcdCxlMmio32Base),        // Min Base Address
+              FixedPcdGet32 (PcdCxlMmio32Limit),       // Max Base Address
+              FixedPcdGet32 (PcdPciMmio32Translation), // Translate
+              FixedPcdGet32 (PcdCxlMmio32Size)         // Length
+              )
+
+            QWordMemory ( // 64-bit BAR Windows
+              ResourceProducer, PosDecode,
+              MinFixed, MaxFixed,
+              Cacheable, ReadWrite,
+              0x00000000,                              // Granularity
+              FixedPcdGet64 (PcdCxlMmio64Base),        // Min Base Address
+              FixedPcdGet64 (PcdCxlMmio64Limit),       // Max Base Address
+              FixedPcdGet64 (PcdPciMmio64Translation), // Translate
+              FixedPcdGet64 (PcdCxlMmio64Size)         // Length
+              )
+
+            WordBusNumber ( // Bus numbers assigned to this root
+                ResourceProducer,
+                MinFixed, MaxFixed, PosDecode,
+                0,   // AddressGranularity
+                FixedPcdGet32 (PcdCxlBusMin),   // AddressMinimum - Minimum Bus Number
+                FixedPcdGet32 (PcdCxlBusMax),   // AddressMaximum - Maximum Bus Number
+                0,    // AddressTranslation - Set to 0
+                64    // RangeLength - Number of Busses
+                )
+        })
+
+        Device (RES0)
+        {
+          Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
+          Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+          {
+             QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
+             0x0000000000000000,                       // Granularity
+             FixedPcdGet64 (PcdCxlBaseAddress), // Range Minimum
+             FixedPcdGet64 (PcdCxlBarLimit),    // Range Maximum
+             0x0000000000000000,                       // Translation Offset
+             FixedPcdGet64 (PcdCxlBarSize),     // Length
+             ,, , AddressRangeMemory, TypeStatic)
+          })
+          Method (_STA) {
+            Return (0xF)
+          }
+        }
+
+        Name (SUPP, Zero)
+        Name (CTRL, Zero)
+        Name (SUPC, Zero)
+        Name (CTRC, Zero)
+
+        Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
+        {
+            CreateDWordField (Arg3, Zero, CDW1)
+            If (((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */) || (Arg0 == ToUUID ("68f2d50b-c469-4d8a-bd3d-941a103fd3fc") /* Unknown UUID */)))
+            {
+                CreateDWordField (Arg3, 0x04, CDW2)
+                CreateDWordField (Arg3, 0x08, CDW3)
+                Local0 = CDW3 /* \_SB_.PC0C._OSC.CDW3 */
+                Local0 &= 0x1F
+                If ((Arg1 != One))
+                {
+                    CDW1 |= 0x08
+                }
+
+                If ((CDW3 != Local0))
+                {
+                    CDW1 |= 0x10
+                }
+
+                SUPP = CDW2 /* \_SB_.PC0C._OSC.CDW2 */
+                CTRL = CDW3 /* \_SB_.PC0C._OSC.CDW3 */
+                CDW3 = Local0
+                If ((Arg0 == ToUUID ("68f2d50b-c469-4d8a-bd3d-941a103fd3fc") /* Unknown UUID */))
+                {
+                    CreateDWordField (Arg3, 0x0C, CDW4)
+                    CreateDWordField (Arg3, 0x10, CDW5)
+                    SUPC = CDW4 /* \_SB_.PC0C._OSC.CDW4 */
+                    CTRC = CDW5 /* \_SB_.PC0C._OSC.CDW5 */
+                    CDW5 |= One
+                }
+
+                Return (Arg3)
+            }
+            Else
+            {
+                CDW1 |= 0x04
+                Return (Arg3)
+            }
+        }
+    }
+
     Device (PCI0)
     {
       Name (_HID, EISAID ("PNP0A08")) // PCI Express Root Bridge
@@ -376,7 +742,7 @@ DefinitionBlock ("DsdtTable.aml", "DSDT",
         FixedPcdGet32 (PcdPciBusMin),   // AddressMinimum - Minimum Bus Number
         FixedPcdGet32 (PcdPciBusMax),   // AddressMaximum - Maximum Bus Number
         0,   // AddressTranslation - Set to 0
-        256  // RangeLength - Number of Busses
+        192  // RangeLength - Number of Busses
         )
 
         DWordMemory ( // 32-bit BAR Windows
@@ -416,7 +782,7 @@ DefinitionBlock ("DsdtTable.aml", "DSDT",
           )
       }) // Name(_CRS)
 
-      Device (RES0)
+      Device (RES1)
       {
         Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
         Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
@@ -483,5 +849,36 @@ DefinitionBlock ("DsdtTable.aml", "DSDT",
         }
       } // End _OSC
     }
+
+    Scope (\_SB)
+    {
+        // CXL Root for OS Driver
+        Device (CXLM)
+        {
+            Name (_HID, "ACPI0017")  // _HID: Hardware ID
+            Method (_STA, 0, NotSerialized)  // _STA: Status
+            {
+                Return (0x0B)
+            }
+
+            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
+            {
+                If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52") /* Retrieve QTG ID */))
+                {
+                    If ((Arg2 == One))
+                    {
+                        Return (Package (0x02)
+                        {
+                            One,
+                            Package (0x01)
+                            {
+                                One
+                            }
+                        })
+                    }
+                }
+            }
+        }
+    }
   } // Scope (_SB)
 }
diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc b/Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc
index 289f4ad4ea3a..4fc03558b2b3 100644
--- a/Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc
@@ -30,7 +30,7 @@ EFI_ACPI_MEMORY_MAPPED_CONFIGURATION_SPACE_ACCESS_DESCRIPTION_TABLE Mcfg = {
       FixedPcdGet32 (PcdPciExpressBaseAddress),
       0,
       FixedPcdGet32 (PcdPciBusMin),
-      FixedPcdGet32 (PcdPciBusMax),
+      FixedPcdGet32 (PcdCxlBusMax),
       EFI_ACPI_RESERVED_DWORD
     }
   }
diff --git a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
index 60daeff915c5..052a215f2583 100644
--- a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
+++ b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
@@ -39,14 +39,38 @@ HardwareInfoLib|Include/Library/HardwareInfoLib.h
 
   # PCDs complementing PCIe layout pulled into ACPI tables
   # Limit = Base + Size - 1
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciIoLimit|0x0000ffff|UINT32|0x00000006
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio32Limit|0xEFFFFFFF|UINT32|0x00000007
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio64Limit|0xFFFFFFFFFF|UINT64|0x00000008
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciIoLimit|0x0000ffff|UINT32|0x00000005
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio32Limit|0xEFFFFFFF|UINT32|0x00000006
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio64Limit|0xFFFFFFFFFF|UINT64|0x00000007
 
   # PCDs complementing gEfiMdePkgTokenSpaceGuid.PcdPciExpressBaseAddress
   # BarLimit = BaseAddress + BarSize - 1
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize|0x10000000|UINT64|0x00000009
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit|0xFFFFFFFF|UINT64|0x00000010
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize|0x0C000000|UINT64|0x00000008
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit|0xFBFFFFFF|UINT64|0x00000009
+
+  # PCDs complementing CXL layout pulled into ACPI tables
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Base|0x60130000|UINT32|0x00000010
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Size|0x02000000|UINT32|0x00000011
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Base|0x90000000000|UINT64|0x00000012
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Size|0x00100000|UINT32|0x00000013
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Limit|0x6212FFFF|UINT32|0x00000014
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Limit|0x900000FFFFF|UINT64|0x00000015
+
+  # PCDs complementing CXL ECAM Base & Size
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBaseAddress|0xFC000000|UINT64|0x00000016
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize|0x04000000|UINT64|0x00000017
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit|0xFFFFFFFF|UINT64|0x00000018
+
+  # PCDs complementing CXL Bus Range
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin|192|UINT32|0x00000019
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax|255|UINT32|0x00000020
+
+  # PCDs complementing base address for CXL CHBCR (CXL Host Bridge Component Registers)
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase|0x60120000|UINT64|0x00000021
+
+  # CXL Fixed Memory Window
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmws0Base|0xA0000000000|UINT64|0x00000022
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmws0Size|0x10000000000|UINT64|0x00000023
 
 [PcdsDynamic.common]
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemManufacturer|L""|VOID*|0x00000110
-- 
2.34.1

