Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F3E4C7E
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 03:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987790; cv=none; b=XlS8CnWcWFpwMrA75tu7LsX4MZG/MX6PeWkNCLpl1rff2Z/AWDxyTZS5Z9wfNkCWCdGvBqkykpDlzZzbTqCHF3rK9g5xoyzJLZQB405lcIV7TqTQWE7TFWdkJpVA0DoNYcmjFGCJZQ+OfTFHNyt2ai9frKDVX2MmlEm2vmOATe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987790; c=relaxed/simple;
	bh=0QWnkl1io9aaEahkCbNn6F9h1e4CRz7E5uAQ232pRn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QORgWh9q4GpRDoF/gf2asM8OFEsRsU5eWstaouosLJOmDQN9S3jVqjwdK3U7Gp0vz9FZ4cOA8+YDlhsgHrcI6N01lQvldAToJw3881ZsPzZ/KymAlwbiU4ZH8PQYgBqvYWxHaj+1cDLJabFGURRCL+inu2oXbtctWR5nGNOhXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwC3vCSDOdFm4J6AAg--.18330S2;
	Fri, 30 Aug 2024 11:16:19 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwAnVLRyOdFmhaMpAA--.16473S5;
	Fri, 30 Aug 2024 11:16:15 +0800 (CST)
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
Subject: [RFC PATCH edk2-platforms 2/2] SbsaQemu: AcpiTables: Add CEDT Table
Date: Fri, 30 Aug 2024 11:15:45 +0800
Message-Id: <20240830031545.548789-3-wangyuquan1236@phytium.com.cn>
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
X-CM-TRANSID:AQAAfwAnVLRyOdFmhaMpAA--.16473S5
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWbQ2MkCEAAAs4
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF4kWr47CFWktw1kXF17GFg_yoWrKry3pF
	1IvFZYkr4kA343tr4xGanYvF4YkFya9F4DCa9xXr1UCrsxJF1UXa15Ka4IvFy7J3Z3Zw4D
	GF4Iv34jvr4fu3DanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Provide CXL Early Discovery Table that describes the static CXL
Platform Components of sbsa-ref.

This adds a static CXL Host Bridge structure and a CXL Fixed Memory
Window structure which are implemented as two independent space on
sbsa-ref: [SBSA_CXL_HOST] & [SBSA_CXL_FIXED_WINDOW].

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  6 +-
 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    | 70 +++++++++++++++++++
 Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  7 ++
 3 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc

diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
index b4d5aa807bd9..f39b06d708d5 100644
--- a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
@@ -21,7 +21,7 @@
   Fadt.aslc
   Mcfg.aslc
   Spcr.aslc
-
+  Cedt.aslc
 [Packages]
   ArmPlatformPkg/ArmPlatformPkg.dec
   ArmPkg/ArmPkg.dec
@@ -78,6 +78,10 @@
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit
 
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsBase
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsSize
+
   gEfiMdeModulePkgTokenSpaceGuid.PcdSerialRegisterBase
 
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPlatformAhciBase
diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc b/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
new file mode 100644
index 000000000000..66c9dc8858bc
--- /dev/null
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
@@ -0,0 +1,70 @@
+/** @file
+*  CXL Early Discovery Table (CEDT)
+*
+*  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
+*
+**/
+
+#include <IndustryStandard/CXLEarlyDiscoveryTable.h>
+#include <IndustryStandard/Acpi64.h>
+#include <IndustryStandard/SbsaQemuAcpi.h>
+
+#pragma pack(1)
+
+typedef struct
+{
+  EFI_ACPI_6_4_CXL_Early_Discovery_TABLE           Header;
+  EFI_ACPI_6_4_CXL_Host_Bridge_Structure           Chbs;
+  EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure   Cfmws;
+} SBSA_REF_CEDT;
+
+
+SBSA_REF_CEDT Cedt =
+{
+  // EFI_ACPI_6_4_CXL_Early_Discovery_TABLE(Header)
+  {
+     SBSAQEMU_ACPI_HEADER  // EFI_ACPI_DESCRIPTION_HEADER
+     (
+       EFI_ACPI_6_4_CXL_EARLY_DISCOVERY_TABLE_SIGNATURE,
+       SBSA_REF_CEDT,
+       EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_01
+     ),
+  },
+  // EFI_ACPI_6_4_CXL_Host_Bridge_Structure
+  {
+    // EFI_ACPI_6_4_CEDT_Structure
+    {
+        EFI_ACPI_CEDT_TYPE_CHBS,                                 // Type
+        0,                                                       // Reserved
+        sizeof (EFI_ACPI_6_4_CXL_Host_Bridge_Structure),         // Length
+    },
+    FixedPcdGet32 (PcdCxlBusMin),          // UID
+    0x1,                                   // CXLVersion
+    0,                                     // Reserved
+    FixedPcdGet32 (PcdChbcrBase),          // CHBCR Base
+    0X10000,                               // Length
+  },
+  // EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure
+  {
+    // EFI_ACPI_6_4_CEDT_Structure
+    {
+        EFI_ACPI_CEDT_TYPE_CFMWS,                                // Type
+        0,                                                       // Reserved
+        sizeof (EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure), // Length
+    },
+    0,                                     // Reserved
+    FixedPcdGet32 (PcdCfmwsBase),          // BaseHPA
+    FixedPcdGet32 (PcdCfmwsSize),          // WindowSize
+    0,                                     // InterleaveMembers
+    0,                                     // InterleaveArithmetic
+    0,                                     // Reserved1
+    0,                                     // Granularity
+    0xF,                                   // Restrictions
+    0,                                     // QtgId
+    FixedPcdGet32 (PcdCxlBusMin),          // FirstTarget
+  }
+};
+
+#pragma pack ()
+
+VOID* CONST ReferenceAcpiTable = &Cedt;
diff --git a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
index 7d8c7997160b..dff838315d06 100644
--- a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
+++ b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
@@ -65,6 +65,13 @@ HardwareInfoLib|Include/Library/HardwareInfoLib.h
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin|254|UINT32|0x00000019
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax|255|UINT32|0x00000020
 
+  # PCDs complementing base address for CXL CHBCR (CXL Host Bridge Component Registers)
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase|0x60120000|UINT64|0x00000021
+
+  # CXL Fixed Memory Window
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsBase|0xA0000000000|UINT64|0x00000022
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsSize|0x10000000000|UINT64|0x00000023
+
 [PcdsDynamic.common]
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemManufacturer|L""|VOID*|0x00000110
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemSerialNumber|L""|VOID*|0x00000111
-- 
2.34.1

