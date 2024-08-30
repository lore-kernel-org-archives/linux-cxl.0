Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E071742
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 03:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987794; cv=none; b=l8AR1mXf+sFXevR/P/UECZSUvwhZ4QcHHaGoOi/HYdmC8dq0GnCGej+d2DQ0qRM9Uxo9+Lq+Ssmx01byP/DxG8+D0NVuJIoU1c1D9jouDMVmiPylNGijrOhehmyHcmD4sCivTuJylKn4MGXFSz/XVTJEVS39FPSYSTVYY52EaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987794; c=relaxed/simple;
	bh=/0qKPlW6gQYg1M4ThFhBe+VDSD456OoHipgnYfaDkxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WU+luj29zVQeCDIVbxE5+h4B+98ux1tmH3UH9UA646eb/g8YsZTnqjPFcIec9eEZpOKOuNDn76XVJDQOxWHJwd2N2ffWA1ZqU0igeyWh2Olf+pjuGToDlDAGq97tQcRO2aod/jrlOG79k3Ld8upqEV05fQ4Vje2JUxjIG0m9MVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3vx+BOdFmHbhAAg--.51613S2;
	Fri, 30 Aug 2024 11:16:17 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwAnVLRyOdFmhaMpAA--.16473S4;
	Fri, 30 Aug 2024 11:16:11 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com,
	ardb+tianocore@kernel.org,
	quic_llindhol@quicinc.com,
	peter.maydell@linaro.org
Cc: devel@edk2.groups.io,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	wangyinfeng@phytium.com.cn,
	shuyiqi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH edk2-platforms 1/2] SbsaQemu: Add acpi0016 & acpi0017
 objects into DSDT
Date: Fri, 30 Aug 2024 11:15:44 +0800
Message-Id: <20240830031545.548789-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830031545.548789-1-wangyuquan1236@phytium.com.cn>
References: <20240830031545.548789-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnVLRyOdFmhaMpAA--.16473S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWbQ2MkCDgAAsm
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfCFyfJw17tFWrWFWrXFW8JFb_yoW8Kr43Go
	WUJ345uFsrWF1UZw18CrZFgFn2vFn3A3WI9w1FyFyUZay0vryxJry8tw13Gr98JwnFqrnI
	9r4xXa4UJas09FZ5n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
	J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
	UUUUUUU==

This adds relevant definitions and descriptions of acpi0016 and
acpi0017 to support CXL.

With the implementation of pxb-cxl on the original pcie host bridge,
the previous space layout of mmio32 & mmio64 have to be divided to
provide the mmio space for cxl host bridge.

I'm not sure if the new space layout would bring a series of bad
influence, but it seems that the base address and size of cxl host
bridge is ok.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 Platform/Qemu/SbsaQemu/SbsaQemu.dsc           |  30 +-
 .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  14 +
 Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl     | 410 +++++++++++++++++-
 Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc    |   2 +-
 .../SbsaQemuPciHostBridgeLib.c                |   4 +-
 .../SbsaQemuPciHostBridgeLib.inf              |   3 +
 Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  27 +-
 7 files changed, 473 insertions(+), 17 deletions(-)

diff --git a/Platform/Qemu/SbsaQemu/SbsaQemu.dsc b/Platform/Qemu/SbsaQemu/SbsaQemu.dsc
index 9f54a8915707..5694c0bc8b01 100644
--- a/Platform/Qemu/SbsaQemu/SbsaQemu.dsc
+++ b/Platform/Qemu/SbsaQemu/SbsaQemu.dsc
@@ -452,23 +452,39 @@ DEFINE NETWORK_HTTP_BOOT_ENABLE       = FALSE
   #
   # ECAM size == 0x10000000
   gArmTokenSpaceGuid.PcdPciBusMin|0
-  gArmTokenSpaceGuid.PcdPciBusMax|255
+  gArmTokenSpaceGuid.PcdPciBusMax|253
   gArmTokenSpaceGuid.PcdPciIoBase|0x0
   gArmTokenSpaceGuid.PcdPciIoSize|0x00010000
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciIoLimit|0x0000ffff
   gArmTokenSpaceGuid.PcdPciMmio32Base|0x80000000
-  gArmTokenSpaceGuid.PcdPciMmio32Size|0x70000000
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio32Limit|0xEFFFFFFF
+  gArmTokenSpaceGuid.PcdPciMmio32Size|0x6FE00000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio32Limit|0xEFDFFFFF
   gArmTokenSpaceGuid.PcdPciMmio64Base|0x100000000
-  gArmTokenSpaceGuid.PcdPciMmio64Size|0xFF00000000
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio64Limit|0xFFFFFFFFFF
+  gArmTokenSpaceGuid.PcdPciMmio64Size|0xFEFFFF0000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio64Limit|0xFFFFFEFFFF
+
+  #
+  # CXL Host Bridge (pxb-cxl on PCI Root Complex)
+  #
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin|254
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax|255
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Base|0xEFE00000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Size|0x00200000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Base|0xFFFFFF0000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Size|0x000010000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Limit|0xEFFFFFFF
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Limit|0xFFFFFFFFFF
 
   # set PcdPciExpressBaseAddress to MAX_UINT64, which signifies that this
   # PCD and PcdPciDisableBusEnumeration have not been assigned yet
   # TODO: PcdPciExpressBaseAddress set to max_uint64
   gEfiMdePkgTokenSpaceGuid.PcdPciExpressBaseAddress|0xf0000000
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize|0x10000000
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit|0xFFFFFFFF
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize|0x0FE00000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit|0xFFDFFFFF
+  # PCDs complementing CXL ECAM Base & Size
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBaseAddress|0xFFE00000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize|0x00200000
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit|0xFFFFFFFF
 
   gEfiMdePkgTokenSpaceGuid.PcdPciIoTranslation|0x7fff0000
   gEfiMdePkgTokenSpaceGuid.PcdPciMmio32Translation|0x0
diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
index 8d4905362edc..b4d5aa807bd9 100644
--- a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
@@ -44,6 +44,8 @@
 
   gArmTokenSpaceGuid.PcdPciBusMin
   gArmTokenSpaceGuid.PcdPciBusMax
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax
 
   gArmTokenSpaceGuid.PcdPciIoBase
   gArmTokenSpaceGuid.PcdPciIoSize
@@ -60,10 +62,22 @@
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
   gEfiMdeModulePkgTokenSpaceGuid.PcdSerialRegisterBase
 
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPlatformAhciBase
diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl b/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
index c134fb66e860..94d0b2cbb118 100644
--- a/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
@@ -182,6 +182,372 @@ DefinitionBlock ("DsdtTable.aml", "DSDT",
         } // USB0_RHUB
     } // USB0
 
+    // CXL Host Bridge (pxb-cxl)
+    Device (PC0C)
+    {
+        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
+        Name (_CID, Package (0x02)  // _CID: Compatible ID
+        {
+            EisaId ("PNP0A08"), /* PCI Express Bus */
+            EisaId ("PNP0A03")  /* PCI Bus */
+        })
+        Name (_BBN, 0xFE)  // _BBN: BIOS Bus Number
+        Name (_UID, 0xFE)  // _UID: Unique ID
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
+                0,   // AddressTranslation - Set to 0
+                2    // RangeLength - Number of Busses
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
+        254  // RangeLength - Number of Busses
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
@@ -483,5 +849,45 @@ DefinitionBlock ("DsdtTable.aml", "DSDT",
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
+                If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52") /* Unknown UUID */))
+                {
+                    If ((Arg2 == Zero))
+                    {
+                        Return (Buffer (One)
+                        {
+                         0x01                                             // .
+                        })
+                    }
+
+                    If ((Arg2 == One))
+                    {
+                        Return (Package (0x02)
+                        {
+                            One,
+                            Package (0x02)
+                            {
+                                Zero,
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
diff --git a/Silicon/Qemu/SbsaQemu/Library/SbsaQemuPciHostBridgeLib/SbsaQemuPciHostBridgeLib.c b/Silicon/Qemu/SbsaQemu/Library/SbsaQemuPciHostBridgeLib/SbsaQemuPciHostBridgeLib.c
index 8994a5226289..33808fa1f388 100644
--- a/Silicon/Qemu/SbsaQemu/Library/SbsaQemuPciHostBridgeLib/SbsaQemuPciHostBridgeLib.c
+++ b/Silicon/Qemu/SbsaQemu/Library/SbsaQemuPciHostBridgeLib/SbsaQemuPciHostBridgeLib.c
@@ -99,7 +99,7 @@ STATIC PCI_ROOT_BRIDGE  mRootBridge = {
      (gEfiMdePkgTokenSpaceGuid.PcdPciMmio32Translation as 0x0) */
   {
     FixedPcdGet32 (PcdPciMmio32Base),
-    FixedPcdGet32 (PcdPciMmio32Base) + FixedPcdGet32 (PcdPciMmio32Size) - 1,
+    FixedPcdGet32 (PcdCxlMmio32Limit),
   },
 
   /* PCI_ROOT_BRIDGE_APERTURE MemAbove4G; MMIO aperture above 4GB which can be
@@ -107,7 +107,7 @@ STATIC PCI_ROOT_BRIDGE  mRootBridge = {
      (gEfiMdePkgTokenSpaceGuid.PcdPciMmio64Translation as 0x0) */
   {
     FixedPcdGet64 (PcdPciMmio64Base),
-    FixedPcdGet64 (PcdPciMmio64Base) + FixedPcdGet64 (PcdPciMmio64Size) - 1
+    FixedPcdGet64 (PcdCxlMmio64Limit)
   },
 
   /* PCI_ROOT_BRIDGE_APERTURE PMem; Prefetchable MMIO aperture below 4GB which
diff --git a/Silicon/Qemu/SbsaQemu/Library/SbsaQemuPciHostBridgeLib/SbsaQemuPciHostBridgeLib.inf b/Silicon/Qemu/SbsaQemu/Library/SbsaQemuPciHostBridgeLib/SbsaQemuPciHostBridgeLib.inf
index 9d6791ff7dc2..7e7e36fd87bd 100644
--- a/Silicon/Qemu/SbsaQemu/Library/SbsaQemuPciHostBridgeLib/SbsaQemuPciHostBridgeLib.inf
+++ b/Silicon/Qemu/SbsaQemu/Library/SbsaQemuPciHostBridgeLib/SbsaQemuPciHostBridgeLib.inf
@@ -29,6 +29,7 @@
   ArmPkg/ArmPkg.dec
   MdeModulePkg/MdeModulePkg.dec
   MdePkg/MdePkg.dec
+  Silicon/Qemu/SbsaQemu/SbsaQemu.dec
 
 [LibraryClasses]
   DebugLib
@@ -42,6 +43,8 @@
   gArmTokenSpaceGuid.PcdPciMmio32Size
   gArmTokenSpaceGuid.PcdPciMmio64Base
   gArmTokenSpaceGuid.PcdPciMmio64Size
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Limit
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Limit
 
 [Depex]
   TRUE
diff --git a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
index 60daeff915c5..7d8c7997160b 100644
--- a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
+++ b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
@@ -39,14 +39,31 @@ HardwareInfoLib|Include/Library/HardwareInfoLib.h
 
   # PCDs complementing PCIe layout pulled into ACPI tables
   # Limit = Base + Size - 1
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciIoLimit|0x0000ffff|UINT32|0x00000006
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio32Limit|0xEFFFFFFF|UINT32|0x00000007
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio64Limit|0xFFFFFFFFFF|UINT64|0x00000008
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciIoLimit|0x0000ffff|UINT32|0x00000005
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio32Limit|0xEFDFFFFF|UINT32|0x00000006
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciMmio64Limit|0xFFFFFEFFFF|UINT64|0x00000007
 
   # PCDs complementing gEfiMdePkgTokenSpaceGuid.PcdPciExpressBaseAddress
   # BarLimit = BaseAddress + BarSize - 1
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize|0x10000000|UINT64|0x00000009
-  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit|0xFFFFFFFF|UINT64|0x00000010
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarSize|0x0FE00000|UINT64|0x00000008
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPciExpressBarLimit|0xFFDFFFFF|UINT64|0x00000009
+
+  # PCDs complementing CXL layout pulled into ACPI tables
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Base|0xEFE00000|UINT32|0x00000010
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Size|0x00200000|UINT32|0x00000011
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Base|0xFFFFFF0000|UINT64|0x00000012
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Size|0x000010000|UINT32|0x00000013
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio32Limit|0xEFFFFFFF|UINT32|0x00000014
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlMmio64Limit|0xFFFFFFFFFF|UINT64|0x00000015
+
+  # PCDs complementing CXL ECAM Base & Size
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBaseAddress|0xFFE00000|UINT64|0x00000016
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize|0x00200000|UINT64|0x00000017
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit|0xFFFFFFFF|UINT64|0x00000018
+
+  # PCDs complementing CXL Bus Range
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin|254|UINT32|0x00000019
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax|255|UINT32|0x00000020
 
 [PcdsDynamic.common]
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemManufacturer|L""|VOID*|0x00000110
-- 
2.34.1

