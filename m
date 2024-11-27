Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4266B188A0D
	for <linux-cxl@vger.kernel.org>; Wed, 27 Nov 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698791; cv=none; b=Hl9tvILet7i7Ff012L2X9qTb0H3A1ueuVHNfKgS6zWbqUjh9+8oZQz2g3b2TyM3LEWQkqB8Z+rR789T9X9dI03wnTfNT8NIp2xSkkb+aRjgNyl1SoKZWTEs2pbw3Egf5SYjzLuYEE0HZrjztjJrBs8GILHzG72r9Hjco3IMMlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698791; c=relaxed/simple;
	bh=cGgvGnaVmC65WvpHLA1BhrWx6jcIYqPsL3N1IAAchLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MlDl7nAtlXeQmRq0v174E5HqEcoZD1LkCcakc5w5pHN5jK/9X6TzwRuQwW5DZFUc9Ml38F31zHlzjqdaj9rLXdoRTUgqfPbniMhKcWrjgH99lBVK/I8N/VOjTRDsCmsFCcAy2WfzKYrb8vN/enakbvJ6EcJzUpAN6CjRsXAVGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3Wpmc4kZnK5HjBw--.49232S2;
	Wed, 27 Nov 2024 17:13:00 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwCn_nqR4kZnVcRcAA--.11074S4;
	Wed, 27 Nov 2024 17:12:52 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: AbdulLateef.Attar@amd.com,
	gaoliming@byosoft.com.cn,
	michael.d.kinney@intel.com,
	zhiguang.liu@intel.com
Cc: Jonathan.Cameron@Huawei.com,
	marcin.juszkiewicz@linaro.org,
	chenbaozi@phytium.com.cn,
	devel@edk2.groups.io,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC EDK2 PATCH v5 1/1] MdePkg/IndustryStandard: add definitions for
 CXL CEDT
Date: Wed, 27 Nov 2024 17:12:29 +0800
Message-Id: <20241127091229.112833-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127091229.112833-1-wangyuquan1236@phytium.com.cn>
References: <20241127091229.112833-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCn_nqR4kZnVcRcAA--.11074S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQACAWdGJokDzwAAsA
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3GFWDWw18Kw4rZF18Xr4Utwb_yoW7tr4kpF
	n5AayYga98JFy3u3yfZa1F9r1fuFs7Gw1DGF9xZrya9FWUtwn7uFs8Ar1UXrykAr4UC347
	WF42q3yru3W7C3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

This adds #defines and struct typedefs for the various structure
types in the CXL Early Discovery Table (CEDT).

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 MdePkg/Include/IndustryStandard/Cxl20.h | 41 +++++++++++++++++
 MdePkg/Include/IndustryStandard/Cxl30.h | 59 +++++++++++++++++++++++++
 MdePkg/Include/IndustryStandard/Cxl31.h | 47 ++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 MdePkg/Include/IndustryStandard/Cxl31.h

diff --git a/MdePkg/Include/IndustryStandard/Cxl20.h b/MdePkg/Include/IndustryStandard/Cxl20.h
index 574f78688180..ae8e4fab9e7c 100755
--- a/MdePkg/Include/IndustryStandard/Cxl20.h
+++ b/MdePkg/Include/IndustryStandard/Cxl20.h
@@ -14,6 +14,7 @@
 #define CXL20_H_
 
 #include <IndustryStandard/Cxl11.h>
+#include <IndustryStandard/Acpi.h>
 
 //
 // CXL DVSEC IDs
@@ -102,6 +103,16 @@
 #define CXL_MEM_DEVICE_MEDIA_STATUS_ERROR      0x2
 #define CXL_MEM_DEVICE_MEDIA_STATUS_DISABLED   0x3
 
+//
+// "CEDT" CXL Early Discovery Table
+// Compute Express Link Specification Revision 2.0  - Chapter 9.14.1
+//
+#define CXL_EARLY_DISCOVERY_TABLE_SIGNATURE  SIGNATURE_32 ('C', 'E', 'D', 'T')
+
+#define CXL_EARLY_DISCOVERY_TABLE_REVISION_01  0x1
+
+#define CEDT_TYPE_CHBS     0x0
+
 //
 // Ensure proper structure formats
 //
@@ -458,6 +469,36 @@ typedef union {
   UINT64    Uint64;
 } CXL_MEMORY_DEVICE_STATUS_REGISTER;
 
+//
+// CEDT header
+// Compute Express Link Specification Revision 2.0  - Chapter 9.14.1.1
+//
+typedef struct {
+  EFI_ACPI_DESCRIPTION_HEADER    Header;
+} CXL_EARLY_DISCOVERY_TABLE;
+
+//
+// Node header definition shared by all CEDT structure types
+//
+typedef struct {
+  UINT8     Type;
+  UINT8     Reserved;
+  UINT16    Length;
+} CEDT_STRUCTURE;
+
+//
+// Definition for CXL Host Bridge Structure (CHBS)
+// Compute Express Link Specification Revision 2.0  - Chapter 9.14.1.2
+//
+typedef struct {
+  CEDT_STRUCTURE                   Header;
+  UINT32                           Uid;
+  UINT32                           CxlVersion;
+  UINT32                           Reserved;
+  UINT64                           Base;
+  UINT64                           Length;
+} CXL_HOST_BRIDGE_STRUCTURE;
+
 #pragma pack()
 
 #endif
diff --git a/MdePkg/Include/IndustryStandard/Cxl30.h b/MdePkg/Include/IndustryStandard/Cxl30.h
index 7a9a6d69405d..27b20ab8198f 100644
--- a/MdePkg/Include/IndustryStandard/Cxl30.h
+++ b/MdePkg/Include/IndustryStandard/Cxl30.h
@@ -45,6 +45,14 @@
 #define CXL_HDM_6_WAY_INTERLEAVING   0x9
 #define CXL_HDM_12_WAY_INTERLEAVING  0xA
 
+//
+// "CEDT" CXL Early Discovery Table
+// Compute Express Link Specification Revision 3.0  - Chapter 9.17.1
+//
+#define CEDT_TYPE_CFMWS    0x1
+#define CEDT_TYPE_CXIMS    0x2
+#define CEDT_TYPE_RDPAS    0x3
+
 //
 // Ensure proper structure formats
 //
@@ -311,6 +319,57 @@ typedef struct {
   CXL_3_0_CXL_TIMEOUT_AND_ISOLATION_STATUS        TimeoutAndIsolationStatus;
 } CXL_3_0_CXL_TIMEOUT_AND_ISOLATION_CAPABILITY_STRUCTURE;
 
+//
+// Definition for CXL Fixed Memory Window Structure (CFMWS)
+// Compute Express Link Specification Revision 3.0  - Chapter 9.17.1.3
+//
+// The number of entries in TargetList (Interleave Target List) shall
+// match the Number of Interleave Ways (NIW). The current maximum is 16.
+//
+typedef struct {
+  CEDT_STRUCTURE                       Header;
+  UINT32                               Reserved;
+  UINT64                               BaseHpa;
+  UINT64                               WindowSize;
+  UINT8                                EncodedInterleaveWays;
+  UINT8                                InterleaveArithmetic;
+  UINT16                               Reserved1;
+  UINT32                               Granularity;
+  UINT16                               Restrictions;
+  UINT16                               QtgId;
+  UINT32                               TargetList[16];
+} CXL_FIXED_MEMORY_WINDOW_STRUCTURE;
+
+//
+// Definition for CXL XOR Interleave Math Structure (CXIMS)
+// Compute Express Link Specification Revision 3.0  - Chapter 9.17.1.4
+//
+// The number of entries in XORMAPList depends on NIB. 4 is the current
+// maximum for 16-way interleaving.
+//
+typedef struct {
+  CEDT_STRUCTURE                       Header;
+  UINT16                               Reserved;
+  UINT8                                HBIG;
+  UINT8                                NIB;
+  UINT64                               XORMAPList[4];
+} CXL_XOR_INTERLEAVE_MATH_STRUCTURE;
+
+//
+// Definition for RCEC Downstream Port Association Structure (RDPAS)
+// Compute Express Link Specification Revision 3.0  - Chapter 9.17.1.5
+//
+// The errata released at CXL 3.2 fixed that RCEC BDF field overlaps
+// Protocol Type field.
+//
+typedef struct {
+  CEDT_STRUCTURE                       Header;
+  UINT16                               SegmentNumber;
+  UINT16                               Bdf;
+  UINT64                               BaseAddress;
+  UINT8                                ProtocolType;
+} RCEC_DOWNSTREAM_PORT_ASSOCIATION_STRUCTURE;
+
 #pragma pack()
 
 #endif
diff --git a/MdePkg/Include/IndustryStandard/Cxl31.h b/MdePkg/Include/IndustryStandard/Cxl31.h
new file mode 100644
index 000000000000..768a9e9fafef
--- /dev/null
+++ b/MdePkg/Include/IndustryStandard/Cxl31.h
@@ -0,0 +1,47 @@
+/** @file
+  CXL 3.1 definitions
+
+  This file contains the register definitions and firmware interface based
+  on the Compute Express Link (CXL) Specification Revision 3.1.
+
+  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
+
+  SPDX-License-Identifier: BSD-2-Clause-Patent
+
+  @par Reference(s):
+  - Compute Express Link (CXL) Specification Revision 3.1.
+    (https://computeexpresslink.org/cxl-specification/)
+
+**/
+
+#ifndef CXL31_H_
+#define CXL31_H_
+
+#include <IndustryStandard/Cxl30.h>
+
+//
+// "CEDT" CXL Early Discovery Table
+// Compute Express Link Specification Revision 3.1  - Chapter 9.18.1
+//
+#define CXL_EARLY_DISCOVERY_TABLE_REVISION_02  0x2
+
+#define CEDT_TYPE_CSDS     0x4
+
+//
+// Ensure proper structure formats
+//
+#pragma pack(1)
+
+//
+// Definition for CXL System Description Structure (CSDS)
+// Compute Express Link Specification Revision 3.1  - Chapter 9.18.6
+//
+typedef struct {
+  CEDT_STRUCTURE                       Header;
+  UINT16                               Capabilities;
+  UINT16                               Reserved;
+} CXL_DOWNSTREAM_PORT_ASSOCIATION_STRUCTURE;
+
+#pragma pack()
+
+#endif
-- 
2.34.1

