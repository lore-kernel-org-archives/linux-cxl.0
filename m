Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013066.outbound.protection.outlook.com [40.107.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA73EB116;
	Thu, 25 Jun 2026 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406553; cv=fail; b=VFIUtRwq43YLvwyXtDQIVQj4s6+b5Z4UAe/PpEcWnWAooCGQZfkU+DFGSsyxOQPQeKxW9f+5wlxmisuOOhBDCNRYoPKxaW5HINfwsYOkIURrrJbFir42BE1xmJuV6ieNbr+CsAXp7ZskVeEqhMQrwMFo+VE4i6DkDXWt2D9bRVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406553; c=relaxed/simple;
	bh=WKhaTrUcZhpMLTu7Hd7sBTvXkssBO60vO8rmnmehguY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rv4WZvlfNjajSz8W5a3bm04LiuJErRO+v4jzAZxueHTIwQqXrAsTMBro2vqDn97ctPHp6XQx8/Xwhq1euupgZla63gHgddhIJXVxVBGg0icLjdhQhyC9rdKZDSl+AbkPKuVxe0fqTVoErtPYu7sGq2az2DP3nNtvorUmnWTpQ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VcRRc9a6; arc=fail smtp.client-ip=40.107.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VcRRc9a6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBgqayikkr/CbDCT3IPS8Up7pv6srnpnlhHqLADQokfTkOhR5nvuIJxcXF7BLkiyrrvFChJTpH3acRXEQkdsMnWP7NhlMYqa3pvIJHkaWkuy2oSgZKD717LAhEq5e+NDoN/vgZjcsLnsbxSNsk2bDTGsscyH6M/h/9YL2re/Pk4/LGyPkBY9D3MkjldDCVVSFpB3rYaqfKiEIKbF/IXhXWGG9E2D47EIk9R5HPSfM5ZQYaKliIro6qClnSemUPoeFePcu5JmQC0GhxGhGYjq0B+yL0rXFbV6r7yg0L2yaLb5ETWXhsWYhIFQtK6x+FPc4gDPoXosb9IC642ITt/u5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo0+6Gjm/6ad5AeO59rS9ESgqpd9NcK6iMjVP2cfuqs=;
 b=ckCS9rs0x3msZF1izDxZvzjKU6MiY2W+xrHBwsheT7dDit52PFOUkjEQk06XCtRqim64F3N15M2dlSezEsNk7kHYFAQNQV3gVlOFcm5JX1XIFTMqI+u+3LNVErJUtLB+hI5G+q1R3IuUWAJqhLpwFJSPwtKmli8Fx/VXz6YTZ9JFX3e8L5h7Upzh927xBaeNL3E+vtCW/mjvj2Zq0R1DTLXbWal38KVFFG7jR2Fa32qzsogeDiBpQz5uXZ/P3PUwOSvm6RN7+Qn5PYVJcBK/YQ+HDWImZalAqzXO2/OabPFXrBnKSnIpWtm2nI//K5BDK+H9SUOFtICm89HZcpiI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo0+6Gjm/6ad5AeO59rS9ESgqpd9NcK6iMjVP2cfuqs=;
 b=VcRRc9a6q00ZJzld7cS6BgMRKBoUyIC1Jd63twSYVMZFBym8tXHn36/PqV3OadCHjPqDgbjDy6NfptpIejoOqH5XR9joGTxcdRsd+9eJw8v2TKmcnRDOpn/f7D7qK2/TEK58LJ/QXTANbAAcxg+fJx4OBMOrTgVu/ZTsLBfD93vI18O+pQi5HpF5udgiBQ58c40EJkdylc2K1YoD1p4QwOJGtg7qFHEuFQ0M4LOnplTpy8ZeHgU3v+EEcic4wtgUNNL/ojRNKeDaTid87C7s6yoqRc5SAmMb3+iE6rYuKWRNQoDyxzuv2CWCk2dGPgcEadktDtb23Tvtw23Xfccbfw==
Received: from SJ0PR13CA0087.namprd13.prod.outlook.com (2603:10b6:a03:2c4::32)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 16:55:33 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::41) by SJ0PR13CA0087.outlook.office365.com
 (2603:10b6:a03:2c4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via Frontend Transport; Thu, 25
 Jun 2026 16:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:55:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:55:15 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:55:07 -0700
From: <mhonap@nvidia.com>
To: <djbw@kernel.org>, <alex@shazbot.org>, <jgg@ziepe.ca>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <ankita@nvidia.com>,
	<alejandro.lucero-palau@amd.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <dmatlack@google.com>, <gourry@gourry.net>,
	<ira.weiny@intel.com>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 04/11] cxl: Move component/HDM register defines to uapi/cxl/cxl_regs.h
Date: Thu, 25 Jun 2026 22:24:00 +0530
Message-ID: <20260625165407.1769572-5-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625165407.1769572-1-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: c04b8df2-6016-433c-b59f-08ded2da9235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	0Mb07G3YPjV2sjXbFP4uU+xn1ne5hDM3B3y2Ugjs3YoW24z+Xkuzj8/1fmjxn8UfN336JkQk9q9MTfhJ7KVzl70lYTn0sHxnPW2JBiMpTL7+I9bTkdYtV/uIlkpmetO/wYd44/ds6mrMZmqtMHauslTSw9YEm9g9ehV0qTF0BBBZpYh5Ty7cVKPdHfXtYtc3iZJKeYHXqDAseZJCYeSJ5Mah/17k3wdfnOt5B2ooeUWNDFyMTGbSiX9VcIUURUpp9DfcgTnGU/ANji0sZpYnfeMj5AeRrYPAWtUKJV30lex2Nsq5YMSjNb4d1ZB0eWjH4T2QLFd1Q0UjHeLiMj2WdStNx2xWNF4UlLCel48S+61lVAfTtA9UsKNOya9rTquM+sey3MKcFNfSbhkGKXI6Bvu4oX75I93S2m9igFLZW9kY8qKW7PRC0jFkSysQT5RlITJs8Jt7BZD9H5OV+IjD4JexdDc3lrcEFqLWuCHf9jChHgLgkWQ+a7OgKdno4uS0EIr5lN2oILRSslR0IiTXRCSTmELdc8YTWZA0wp6qKRU439kJ7iUTgGtuZcETmZZ06ZsKUc95BIO4ZHY1IaK7PbMkMfAaI8kAZQm0f4BiIeFZFLYRTN31bX48nltKQFu4CCKs67cKWJJyYkBH92nERjSRKLZSJpZEkRwNEzP0oIK2Y3CNvmU/Nn86zHbNzOAnXWltM+p9YDc+pb+8SnzO2K/9pAdXAy+3y/2hdxUPhNQ2nRTIE2k54ggtfTPD7S8W
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iRig8xqduwUfMYQKiJwHgKuD2n+7sxkpr4AGMROcJyaI8kMVzTEiMYJY4blw7nokaWXEDJWN9TSltmq4v4HV2c48CG9aNNEP9PepA2vqzkW1m3953Ngm995WFA5hyMWKvdotBxQJCGJvk4BGTpkpvJ6LmLfZqD19ZV9Pv5o82pJdrXopkgpwlaJQA/86rskwDYJcd6GeghZ4w01zLunJjsoQyX5eUNgEpGpZw0wdr8W1lR8fU6NGpeaSHtzyNKd6w06vqFCFtLxamYgp7Yl46837Bc4TPGmV6pa42pSe4xZe5q7kDUOnHzld83rfG0T1vJzJL+iEh8Lz1yVO2me7V9LANvUXPWmYhY3c1LsA14MOqWYfZ0F2bb7rjMXVQP0uvdYetF2vZJ563Hbfw6uihO+i1rx0qECXUEf2jZvDIpMwxB5oVaW3vTTApGasblBY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:55:33.0621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04b8df2-6016-433c-b59f-08ded2da9235
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

From: Manish Honap <mhonap@nvidia.com>

The CXL component register layout and the HDM Decoder Capability
Structure defines live in drivers/cxl/cxl.h, where userspace
consumers cannot include them without depending on kernel-only
headers.  A VMM that owns a vfio-cxl COMP_REGS shadow region needs
these defines to interpret the shadow contents.

Move the spec-defined register layout, capability identifiers, and
HDM decoder field masks to a new public uapi header,
include/uapi/cxl/cxl_regs.h.  Use __GENMASK() and _BITUL() (not
GENMASK() / BIT()) so the header is uapi-clean.  Include
<asm/bitsperlong.h> for the __BITS_PER_LONG that __GENMASK() needs.

drivers/cxl/cxl.h now includes <uapi/cxl/cxl_regs.h>; the values
are identical, so kernel callers see no change.  Static inline
helpers that use FIELD_GET stay in drivers/cxl/cxl.h.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/cxl.h           | 52 +++++-------------------------
 include/uapi/cxl/cxl_regs.h | 63 +++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 45 deletions(-)
 create mode 100644 include/uapi/cxl/cxl_regs.h

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f43abd1903ce..583a27b6659e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -24,51 +24,13 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
  * (port-driver, region-driver, nvdimm object-drivers... etc).
  */
 
-/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
-#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
-
-/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
-#define CXL_CM_OFFSET 0x1000
-#define CXL_CM_CAP_HDR_OFFSET 0x0
-#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
-#define     CM_CAP_HDR_CAP_ID 1
-#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
-#define     CM_CAP_HDR_CAP_VERSION 1
-#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
-#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
-#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
-#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
-
-#define   CXL_CM_CAP_CAP_ID_RAS 0x2
-#define   CXL_CM_CAP_CAP_ID_HDM 0x5
-#define   CXL_CM_CAP_CAP_HDM_VERSION 1
-
-/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
-#define CXL_HDM_DECODER_CAP_OFFSET 0x0
-#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
-#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
-#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
-#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
-#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
-#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
-#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
-#define   CXL_HDM_DECODER_ENABLE BIT(1)
-#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
-#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
-#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
-#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
-#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
-#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
-#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
-#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
-#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
-#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
-#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
-#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
-#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
-#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
-#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
-#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
+/*
+ * Spec-defined CXL component register layout and HDM Decoder
+ * Capability Structure constants live in <uapi/cxl/cxl_regs.h> so a
+ * userspace VMM that owns a vfio-cxl COMP_REGS shadow region can
+ * consume them without depending on kernel-only headers.
+ */
+#include <uapi/cxl/cxl_regs.h>
 
 /* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
 #define CXL_DECODER_MIN_GRANULARITY 256
diff --git a/include/uapi/cxl/cxl_regs.h b/include/uapi/cxl/cxl_regs.h
new file mode 100644
index 000000000000..b284b7ad2d42
--- /dev/null
+++ b/include/uapi/cxl/cxl_regs.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * CXL component register layout and HDM Decoder Capability Structure
+ * defines.  Userspace consumers (e.g. a VMM that owns a vfio-cxl
+ * COMP_REGS shadow region) need these without kernel-only header
+ * dependencies.
+ *
+ * Spec references: CXL r4.0 sections 8.2.3 and 8.2.4.20.
+ */
+#ifndef _UAPI_CXL_REGS_H_
+#define _UAPI_CXL_REGS_H_
+
+#include <asm/bitsperlong.h>	/* __BITS_PER_LONG; needed by __GENMASK() */
+#include <linux/const.h>	/* _BITUL(), _BITULL() */
+#include <linux/bits.h>		/* __GENMASK() */
+
+/* CXL r4.0 8.2.3 CXL Component Register Layout and Definition */
+#define CXL_COMPONENT_REG_BLOCK_SIZE		0x00010000
+
+/* CXL r4.0 8.2.4 CXL.cache and CXL.mem Registers */
+#define CXL_CM_OFFSET				0x1000
+#define CXL_CM_CAP_HDR_OFFSET			0x0
+#define   CXL_CM_CAP_HDR_ID_MASK		__GENMASK(15, 0)
+#define     CM_CAP_HDR_CAP_ID			1
+#define   CXL_CM_CAP_HDR_VERSION_MASK		__GENMASK(19, 16)
+#define     CM_CAP_HDR_CAP_VERSION		1
+#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK	__GENMASK(23, 20)
+#define     CM_CAP_HDR_CACHE_MEM_VERSION	1
+#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK	__GENMASK(31, 24)
+#define CXL_CM_CAP_PTR_MASK			__GENMASK(31, 20)
+
+#define   CXL_CM_CAP_CAP_ID_RAS			0x2
+#define   CXL_CM_CAP_CAP_ID_HDM			0x5
+#define   CXL_CM_CAP_CAP_HDM_VERSION		1
+
+/* HDM decoders, CXL r4.0 8.2.4.20 */
+#define CXL_HDM_DECODER_CAP_OFFSET		0x0
+#define   CXL_HDM_DECODER_COUNT_MASK		__GENMASK(3, 0)
+#define   CXL_HDM_DECODER_TARGET_COUNT_MASK	__GENMASK(7, 4)
+#define   CXL_HDM_DECODER_INTERLEAVE_11_8	_BITUL(8)
+#define   CXL_HDM_DECODER_INTERLEAVE_14_12	_BITUL(9)
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY	_BITUL(11)
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY	_BITUL(12)
+#define CXL_HDM_DECODER_CTRL_OFFSET		0x4
+#define   CXL_HDM_DECODER_ENABLE		_BITUL(1)
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)	(0x20 * (i) + 0x10)
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)	(0x20 * (i) + 0x14)
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)	(0x20 * (i) + 0x18)
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)	(0x20 * (i) + 0x1c)
+#define CXL_HDM_DECODER0_CTRL_OFFSET(i)		(0x20 * (i) + 0x20)
+#define   CXL_HDM_DECODER0_CTRL_IG_MASK		__GENMASK(3, 0)
+#define   CXL_HDM_DECODER0_CTRL_IW_MASK		__GENMASK(7, 4)
+#define   CXL_HDM_DECODER0_CTRL_LOCK		_BITUL(8)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT		_BITUL(9)
+#define   CXL_HDM_DECODER0_CTRL_COMMITTED	_BITUL(10)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR	_BITUL(11)
+#define   CXL_HDM_DECODER0_CTRL_HOSTONLY	_BITUL(12)
+#define CXL_HDM_DECODER0_TL_LOW(i)		(0x20 * (i) + 0x24)
+#define CXL_HDM_DECODER0_TL_HIGH(i)		(0x20 * (i) + 0x28)
+#define CXL_HDM_DECODER0_SKIP_LOW(i)		CXL_HDM_DECODER0_TL_LOW(i)
+#define CXL_HDM_DECODER0_SKIP_HIGH(i)		CXL_HDM_DECODER0_TL_HIGH(i)
+
+#endif /* _UAPI_CXL_REGS_H_ */
-- 
2.25.1

