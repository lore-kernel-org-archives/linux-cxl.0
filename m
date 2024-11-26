Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FB127735
	for <linux-cxl@vger.kernel.org>; Tue, 26 Nov 2024 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590148; cv=none; b=pOn0aTmIabqtTNSD2ZsBvCOgJivIIGNbHYacoFtlGts8fdbypoGYWz1nAEM2EyetltJjW7GTIAqdBVewY3wC49SNrVBdiRAsq/dFzAEk6rbyQPPgPcvg/xi4x95KsVv9a3fzKB8pO+M2CFksD98CrSiBuW5nOt8NSkyORiTsS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590148; c=relaxed/simple;
	bh=VCAEU5tQ78gEPaSrT8gWP2Lp6wHcLtKAsPlGQbf+hqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AxIzo41EzMQiHY8WqlyuT2aigC22LIT5a1qvNxCZVT/d05CkRI8c/g1WM1Im0RciJrJ1CBVA7ckeh8+l7L5+1ucaUpJFak0HwWfh/B5TFJK6IhLzsNTYumaQID47vx7ohQDtCKl7BmY9OwjGxgMfUJ8LtS59R1C/0eGz72JwfzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBXuPE5OkVnybJ9BA--.60072S2;
	Tue, 26 Nov 2024 11:02:17 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwC3DnsqOkVn9vhaAA--.10060S4;
	Tue, 26 Nov 2024 11:02:07 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: AbdulLateef.Attar@amd.com,
	gaoliming@byosoft.com.cn,
	zhiguang.liu@intel.com,
	michael.d.kinney@intel.com
Cc: Jonathan.Cameron@Huawei.com,
	marcin.juszkiewicz@linaro.org,
	chenbaozi@phytium.com.cn,
	devel@edk2.groups.io,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC EDK2 PATCH v4 1/1] MdePkg/IndustryStandard: add definitions for
 CXL CEDT
Date: Tue, 26 Nov 2024 11:01:59 +0800
Message-Id: <20241126030159.72111-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126030159.72111-1-wangyuquan1236@phytium.com.cn>
References: <20241126030159.72111-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwC3DnsqOkVn9vhaAA--.10060S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQABAWdE1PMBxgAAsC
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFWrtFy3JFWkuFWrCrykZrb_yoW7Jr45pF
	4kAayYgayDJFWfuw4Sva15Zr1fAFs7Kw1DGF9xZry3ZFWUtw1kWF4DAr1jqrykAr40k342
	grn2q34UuFnrC3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

This adds #defines and struct typedefs for the various structure
types in the CXL Early Discovery Table (CEDT).

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 MdePkg/Include/IndustryStandard/Cxl20.h | 38 ++++++++++++++++++++
 MdePkg/Include/IndustryStandard/Cxl30.h | 46 +++++++++++++++++++++++++
 MdePkg/Include/IndustryStandard/Cxl31.h | 45 ++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 MdePkg/Include/IndustryStandard/Cxl31.h

diff --git a/MdePkg/Include/IndustryStandard/Cxl20.h b/MdePkg/Include/IndustryStandard/Cxl20.h
index 574f78688180..55ad8105a7bc 100755
--- a/MdePkg/Include/IndustryStandard/Cxl20.h
+++ b/MdePkg/Include/IndustryStandard/Cxl20.h
@@ -14,6 +14,7 @@
 #define CXL20_H_
 
 #include <IndustryStandard/Cxl11.h>
+#include <IndustryStandard/Acpi.h>
 
 //
 // CXL DVSEC IDs
@@ -102,6 +103,15 @@
 #define CXL_MEM_DEVICE_MEDIA_STATUS_ERROR      0x2
 #define CXL_MEM_DEVICE_MEDIA_STATUS_DISABLED   0x3
 
+///
+/// "CEDT" CXL Early Discovery Table
+///
+#define CXL_EARLY_DISCOVERY_TABLE_SIGNATURE  SIGNATURE_32 ('C', 'E', 'D', 'T')
+
+#define CXL_EARLY_DISCOVERY_TABLE_REVISION_01  0x1
+
+#define CEDT_TYPE_CHBS     0x0
+
 //
 // Ensure proper structure formats
 //
@@ -458,6 +468,34 @@ typedef union {
   UINT64    Uint64;
 } CXL_MEMORY_DEVICE_STATUS_REGISTER;
 
+///
+/// CEDT header
+///
+typedef struct {
+  EFI_ACPI_DESCRIPTION_HEADER    Header;
+} CXL_EARLY_DISCOVERY_TABLE;
+
+///
+/// Node header definition shared by all CEDT structure types
+///
+typedef struct {
+  UINT8     Type;
+  UINT8     Reserved;
+  UINT16    Length;
+} CEDT_STRUCTURE;
+
+///
+/// Definition for CXL Host Bridge Structure (CHBS)
+///
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
index 7a9a6d69405d..63e56aea8254 100644
--- a/MdePkg/Include/IndustryStandard/Cxl30.h
+++ b/MdePkg/Include/IndustryStandard/Cxl30.h
@@ -45,6 +45,13 @@
 #define CXL_HDM_6_WAY_INTERLEAVING   0x9
 #define CXL_HDM_12_WAY_INTERLEAVING  0xA
 
+///
+/// "CEDT" CXL Early Discovery Table
+///
+#define CEDT_TYPE_CFMWS    0x1
+#define CEDT_TYPE_CXIMS    0x2
+#define CEDT_TYPE_RDPAS    0x3
+
 //
 // Ensure proper structure formats
 //
@@ -311,6 +318,45 @@ typedef struct {
   CXL_3_0_CXL_TIMEOUT_AND_ISOLATION_STATUS        TimeoutAndIsolationStatus;
 } CXL_3_0_CXL_TIMEOUT_AND_ISOLATION_CAPABILITY_STRUCTURE;
 
+///
+/// Definition for CXL Fixed Memory Window Structure (CFMWS)
+///
+typedef struct {
+  CEDT_STRUCTURE                       Header;
+  UINT32                               Reserved;
+  UINT64                               BaseHpa;
+  UINT64                               WindowSize;
+  UINT8                                InterleaveMembers;
+  UINT8                                InterleaveArithmetic;
+  UINT16                               Reserved1;
+  UINT32                               Granularity;
+  UINT16                               Restrictions;
+  UINT16                               QtgId;
+  UINT32                               TargetList[16];
+} CXL_FIXED_MEMORY_WINDOW_STRUCTURE;
+
+///
+/// Definition for CXL XOR Interleave Math Structure (CXIMS)
+///
+typedef struct {
+  CEDT_STRUCTURE                       Header;
+  UINT16                               Reserved;
+  UINT8                                HBIG;
+  UINT8                                NIB;
+  UINT64                               XORMAPLIST[4];
+} CXL_XOR_INTERLEAVE_MATH_STRUCTURE;
+
+///
+/// Definition for RCEC Downstream Port Association Structure (RDPAS)
+///
+typedef struct {
+  CEDT_STRUCTURE                       Header;
+  UINT16                               SegmentNumber;
+  UINT16                               Bdf;
+  UINT8                                ProtocolType;
+  UINT64                               BaseAddress;
+} RCEC_DOWNSTREAM_PORT_ASSOCIATION_STRUCTURE;
+
 #pragma pack()
 
 #endif
diff --git a/MdePkg/Include/IndustryStandard/Cxl31.h b/MdePkg/Include/IndustryStandard/Cxl31.h
new file mode 100644
index 000000000000..4a62c971b045
--- /dev/null
+++ b/MdePkg/Include/IndustryStandard/Cxl31.h
@@ -0,0 +1,45 @@
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
+///
+/// "CEDT" CXL Early Discovery Table
+///
+#define CXL_EARLY_DISCOVERY_TABLE_REVISION_02  0x2
+
+#define CEDT_TYPE_CSDS     0x4
+
+//
+// Ensure proper structure formats
+//
+#pragma pack(1)
+
+///
+/// Definition for CXL System Description Structure (CSDS)
+///
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

