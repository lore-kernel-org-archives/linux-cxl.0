Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA4123DEAC
	for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827031; cv=none; b=WyEOFomLrTfeaarBKGJaobId3eT5aY68fOkh8d7K7Gw8mpkr0Tm9G2Q9P88zjdgbML3uhSXdOfd4cG83mb37cwflps/TM3P3qmLbUO9FdXmU8emQpBqF40UXJaT319BHGriKD5E3YuOJ3Iw5sG0fUUT6vXT1U/fgGESXGqj23u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827031; c=relaxed/simple;
	bh=BQ09va8v4Gbk7CBKdqjBsF0mGMo7kBIO02QYoj+ZQ4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/gNje/CL2lFWsfZKL7Lufj680gFlovj6hsV42oCHsFVgk5UN/kz40dtFhuLw5YR4hW942VtJUbJqbedtXsDy69qu64GjxjV9hQOyqHwa0YYkfQYcpNCEuKwO0JInh2ux9CJdUs3jTx9G99uUlefo4Jzkj1Y1kUMxUsMWFv9K5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHjR3GGVhnI_WwCg--.17397S2;
	Tue, 10 Dec 2024 18:36:54 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwCX6na4GVhn1pdmAA--.2065S4;
	Tue, 10 Dec 2024 18:36:49 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: marcin.juszkiewicz@linaro.org,
	ardb+tianocore@kernel.org,
	quic_llindhol@quicinc.com
Cc: Jonathan.Cameron@Huawei.com,
	chenbaozi@phytium.com.cn,
	devel@edk2.groups.io,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH edk2-platforms v4 1/1] SbsaQemu: Support basic CXL enablement
Date: Tue, 10 Dec 2024 18:36:32 +0800
Message-Id: <20241210103632.95960-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210103632.95960-1-wangyuquan1236@phytium.com.cn>
References: <20241210103632.95960-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCX6na4GVhn1pdmAA--.2065S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAPAWdXSfIEuQAAs5
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfuw1fGFW7Gr4UCFWxCr1Utrb_yoW8KF4Uto
	WUt345uF47uF4UZw18CrZFgFn3ZFsxZ3WIkw1SyFyUAa409ryxJry8twnxGr98ArnrtFnI
	vr4xJas8J3Z5uFZ5n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
	J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
	UUUUUUU==

This adds relevant definitions and descriptions of acpi0016, acpi0017
and CEDT to support CXL.

1) With the independent cxl host, this supplies exclusive pio, mmio32,
mmio64 & ecam space descriptions for cxl host.

2) sbsa-ref cxl host has its own ecam space, so this defines the bus
range of cxl host from 0x0 to 0xff. Therefore, this adds relevant
structure in Mcfg.

3) To enable msi of cxl components, this add relevant descriptions in
Iort.

4) Provide CXL Early Discovery Table that describes the static CXL
Platform Components of sbsa-ref, which includes a static CXL Host
Bridge structure and a CXL Fixed Memory Window structure.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 Platform/Qemu/SbsaQemu/SbsaQemu.dsc           |  21 ++
 .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  24 ++
 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    |  69 ++++
 Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl     | 327 ++++++++++++++++++
 Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc    |   9 +-
 .../Drivers/SbsaQemuAcpiDxe/SbsaQemuAcpiDxe.c |  40 ++-
 Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  28 ++
 7 files changed, 515 insertions(+), 3 deletions(-)
 create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc

diff --git a/Platform/Qemu/SbsaQemu/SbsaQemu.dsc b/Platform/Qemu/SbsaQemu/SbsaQemu.dsc
index b2cd2529a966..e743bd30910e 100644
--- a/Platform/Qemu/SbsaQemu/SbsaQemu.dsc
+++ b/Platform/Qemu/SbsaQemu/SbsaQemu.dsc
@@ -454,6 +454,21 @@ DEFINE NETWORK_HTTP_BOOT_ENABLE       = FALSE
   gArmTokenSpaceGuid.PcdPciMmio64Size|0xFF00000000
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio64Limit|0xFFFFFFFFFF
 
+  #
+  # CXL Host Bridge (pxb-cxl on PCI Root Complex)
+  #
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin|0
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax|255
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoBase|0x0
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoSize|0x00010000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoLimit|0x0000ffff
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Base|0x60400000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Size|0x08000000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Limit|0x683FFFFF
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Base|0x90000000000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Size|0x100000000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Limit|0x900FFFFFFFF
+
   # set PcdPciExpressBaseAddress to MAX_UINT64, which signifies that this
   # PCD and PcdPciDisableBusEnumeration have not been assigned yet
   # TODO: PcdPciExpressBaseAddress set to max_uint64
@@ -461,9 +476,15 @@ DEFINE NETWORK_HTTP_BOOT_ENABLE       = FALSE
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize|0x10000000
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit|0xFFFFFFFF
 
+  # PCDs complementing CXL ECAM Base & Size
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBaseAddress|0x68500000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize|0x10000000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit|0x784FFFFF
+
   gEfiMdePkgTokenSpaceGuid.PcdPciIoTranslation|0x7fff0000
   gEfiMdePkgTokenSpaceGuid.PcdPciMmio32Translation|0x0
   gEfiMdePkgTokenSpaceGuid.PcdPciMmio64Translation|0x0
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoTranslation|0x60300000
   ## If TRUE, OvmfPkg/AcpiPlatformDxe will not wait for PCI
   #  enumeration to complete before installing ACPI tables.
   gEfiMdeModulePkgTokenSpaceGuid.PcdPciDisableBusEnumeration|FALSE
diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
index 8d4905362edc..fa1cca0ed16e 100644
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
@@ -60,10 +63,31 @@
   gEfiMdePkgTokenSpaceGuid.PcdPciMmio64Translation
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio64Limit
 
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoBase
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoSize
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoTranslation
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoLimit
+
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
index 000000000000..89ae4d95366f
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
index c134fb66e860..ec6decb79df5 100644
--- a/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
@@ -483,5 +483,332 @@ DefinitionBlock ("DsdtTable.aml", "DSDT",
         }
       } // End _OSC
     }
+
+    // CXL Host Bridge (pxb-cxl)
+    Device (CXL0)
+    {
+        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
+        Name (_CID, Package (0x02)  // _CID: Compatible ID
+        {
+            EisaId ("PNP0A08"), /* PCI Express Bus */
+            EisaId ("PNP0A03")  /* PCI Bus */
+        })
+        Name (_SEG, 0x1)  // PCI Segment Group number
+        Name (_BBN, 0x0)  // _BBN: BIOS Bus Number
+        Name (_UID, 0x1)  // _UID: Unique ID
+        Name (_STR, Unicode ("pxb Device"))  // _STR: Description String
+        Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+
+        LINK_DEVICE(0, GSI0, 0x31)
+        LINK_DEVICE(1, GSI1, 0x32)
+        LINK_DEVICE(2, GSI2, 0x33)
+        LINK_DEVICE(3, GSI3, 0x34)
+
+        Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
+        {
+         PRT_ENTRY(0x0000FFFF, 0, GSI0),
+         PRT_ENTRY(0x0000FFFF, 0, GSI1),
+         PRT_ENTRY(0x0000FFFF, 0, GSI2),
+         PRT_ENTRY(0x0000FFFF, 0, GSI3),
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
+                256    // RangeLength - Number of Busses
+                )
+
+            DWordIo ( // IO window
+                ResourceProducer,
+                MinFixed,
+                MaxFixed,
+                PosDecode,
+                EntireRange,
+                0x00000000,                              // Granularity
+                FixedPcdGet32 (PcdCxlIoBase),            // Min Base Address
+                FixedPcdGet32 (PcdCxlIoLimit),           // Max Base Address
+                FixedPcdGet32 (PcdCxlIoTranslation),     // Translate
+                FixedPcdGet32 (PcdCxlIoSize),            // Length
+                ,,,TypeTranslation
+          )
+        })
+
+        Device (RES1)
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
index 289f4ad4ea3a..c8b9a00a4eae 100644
--- a/Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc
@@ -14,7 +14,7 @@
 
 typedef struct {
   EFI_ACPI_MEMORY_MAPPED_CONFIGURATION_BASE_ADDRESS_TABLE_HEADER Header;
-  EFI_ACPI_MEMORY_MAPPED_ENHANCED_CONFIGURATION_SPACE_BASE_ADDRESS_ALLOCATION_STRUCTURE Structure[1];
+  EFI_ACPI_MEMORY_MAPPED_ENHANCED_CONFIGURATION_SPACE_BASE_ADDRESS_ALLOCATION_STRUCTURE Structure[2];
 } EFI_ACPI_MEMORY_MAPPED_CONFIGURATION_SPACE_ACCESS_DESCRIPTION_TABLE;
 
 EFI_ACPI_MEMORY_MAPPED_CONFIGURATION_SPACE_ACCESS_DESCRIPTION_TABLE Mcfg = {
@@ -32,6 +32,13 @@ EFI_ACPI_MEMORY_MAPPED_CONFIGURATION_SPACE_ACCESS_DESCRIPTION_TABLE Mcfg = {
       FixedPcdGet32 (PcdPciBusMin),
       FixedPcdGet32 (PcdPciBusMax),
       EFI_ACPI_RESERVED_DWORD
+    },
+    {
+      FixedPcdGet32 (PcdCxlBaseAddress),
+      1,
+      FixedPcdGet32 (PcdCxlBusMin),
+      FixedPcdGet32 (PcdCxlBusMax),
+      EFI_ACPI_RESERVED_DWORD
     }
   }
 };
diff --git a/Silicon/Qemu/SbsaQemu/Drivers/SbsaQemuAcpiDxe/SbsaQemuAcpiDxe.c b/Silicon/Qemu/SbsaQemu/Drivers/SbsaQemuAcpiDxe/SbsaQemuAcpiDxe.c
index ddf4acdb7032..ffe10caf11c9 100644
--- a/Silicon/Qemu/SbsaQemu/Drivers/SbsaQemuAcpiDxe/SbsaQemuAcpiDxe.c
+++ b/Silicon/Qemu/SbsaQemu/Drivers/SbsaQemuAcpiDxe/SbsaQemuAcpiDxe.c
@@ -78,7 +78,7 @@ AddIortTable (
       SBSA_IO_REMAPPING_STRUCTURE,
       EFI_ACPI_IO_REMAPPING_TABLE_REVISION_06
       ),
-    3,
+    4,
     sizeof (EFI_ACPI_6_0_IO_REMAPPING_TABLE),        // NodeOffset
     0
   };
@@ -115,6 +115,7 @@ AddIortTable (
     }
   };
 
+  // Initialize Gpex Rc Structure
   SBSA_EFI_ACPI_6_0_IO_REMAPPING_RC_NODE  Rc = {
     {
       {
@@ -145,6 +146,37 @@ AddIortTable (
     }
   };
 
+  // Initialize Cxl Rc Structure
+  SBSA_EFI_ACPI_6_0_IO_REMAPPING_RC_NODE  cxlRc = {
+    {
+      {
+        EFI_ACPI_IORT_TYPE_ROOT_COMPLEX,                            // Type
+        sizeof (SBSA_EFI_ACPI_6_0_IO_REMAPPING_RC_NODE),            // Length
+        0,                                                          // Revision
+        1,                                                          // Identifier
+        1,                                                          // NumIdMappings
+        OFFSET_OF (SBSA_EFI_ACPI_6_0_IO_REMAPPING_RC_NODE, RcIdMap) // IdReference
+      },
+      1,                                          // CacheCoherentAttribute
+      0,                                          // AllocationHints
+      0,                                          // Reserved
+      1,                                          // MemoryAccessFlags
+      EFI_ACPI_IORT_ROOT_COMPLEX_ATS_UNSUPPORTED, // AtsAttribute
+      0x1,                                        // PciSegmentNumber
+      0,                                          // MemoryAddressSize
+      0,                                          // PasidCapabilities
+      { 0 },                                      // Reserved1[1]
+      0,                                          // Flags
+    },
+    {
+      0x0000,                                             // InputBase
+      0xffff,                                             // NumIds
+      0x10000,                                            // OutputBase
+      OFFSET_OF (SBSA_IO_REMAPPING_STRUCTURE, ItsNode),   // OutputReference
+      0,                                                  // Flags
+    }
+  };
+
   SBSA_EFI_ACPI_6_0_IO_REMAPPING_ITS_NODE  Its = {
     // EFI_ACPI_6_0_IO_REMAPPING_ITS_NODE
     {
@@ -166,7 +198,7 @@ AddIortTable (
   TableSize = sizeof (EFI_ACPI_6_0_IO_REMAPPING_TABLE) +
               sizeof (SBSA_EFI_ACPI_6_0_IO_REMAPPING_ITS_NODE) +
               sizeof (SBSA_EFI_ACPI_6_0_IO_REMAPPING_SMMU3_NODE) +
-              sizeof (SBSA_EFI_ACPI_6_0_IO_REMAPPING_RC_NODE);
+              2 * sizeof (SBSA_EFI_ACPI_6_0_IO_REMAPPING_RC_NODE);
 
   Status = gBS->AllocatePages (
                   AllocateAnyPages,
@@ -199,6 +231,10 @@ AddIortTable (
   CopyMem (New, &Rc, sizeof (SBSA_EFI_ACPI_6_0_IO_REMAPPING_RC_NODE));
   New += sizeof (SBSA_EFI_ACPI_6_0_IO_REMAPPING_RC_NODE);
 
+  // CXL RC Node
+  CopyMem (New, &cxlRc, sizeof (SBSA_EFI_ACPI_6_0_IO_REMAPPING_RC_NODE));
+  New += sizeof (SBSA_EFI_ACPI_6_0_IO_REMAPPING_RC_NODE);
+
   AcpiPlatformChecksum ((UINT8 *)PageAddress, TableSize);
 
   Status = AcpiTable->InstallAcpiTable (
diff --git a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
index 60daeff915c5..63a4f7a2066b 100644
--- a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
+++ b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
@@ -48,6 +48,34 @@ HardwareInfoLib|Include/Library/HardwareInfoLib.h
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize|0x10000000|UINT64|0x00000009
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit|0xFFFFFFFF|UINT64|0x00000010
 
+  # PCDs complementing CXL layout pulled into ACPI tables
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoBase|0x0|UINT32|0x00000011
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoTranslation|0x60300000|UINT32|0x00000012
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoSize|0x00010000|UINT32|0x00000013
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Base|0x60400000|UINT32|0x00000014
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Size|0x08000000|UINT32|0x00000015
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Base|0x90000000000|UINT64|0x00000016
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Size|0x100000000|UINT64|0x00000017
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlIoLimit|0x0000ffff|UINT32|0x00000018
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Limit|0x683FFFFF|UINT32|0x00000019
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Limit|0x900FFFFFFFF|UINT64|0x0000001a
+
+  # PCDs complementing CXL ECAM Base & Size
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBaseAddress|0x68500000|UINT64|0x0000001b
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize|0x10000000|UINT64|0x0000001c
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit|0x784FFFFF|UINT64|0x0000001d
+
+  # PCDs complementing CXL Bus Range
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin|0|UINT32|0x0000001e
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax|255|UINT32|0x0000001f
+
+  # PCDs complementing base address for CXL CHBCR (CXL Host Bridge Component Registers)
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase|0x60200000|UINT64|0x00000020
+
+  # CXL Fixed Memory Window
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmws0Base|0xA0000000000|UINT64|0x00000021
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmws0Size|0x10000000000|UINT64|0x00000022
+
 [PcdsDynamic.common]
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemManufacturer|L""|VOID*|0x00000110
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemSerialNumber|L""|VOID*|0x00000111
-- 
2.34.1

