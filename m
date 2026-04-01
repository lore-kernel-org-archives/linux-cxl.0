Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8046AED8;
	Wed,  1 Apr 2026 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054425; cv=fail; b=pBvtAGgeMuWOorD840Gy3nSGbOTx34OXUao2qM9e+Q0qNpri8h0dVblu1XOyHPCmX7GFKaM8XxzHzqNsCC6N8GGe4AKYt6HW5FamK12G1aZpteN6O2UwsgzzwikhmGR2UgvVMV6hO5Z+xvCmn9rUI2aelzsLY/OwV1nfBNbVYOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054425; c=relaxed/simple;
	bh=Z+Fh5jVuPP0BfbV/y/d/4akbCuV8sU6WbZkCYMnB8OY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Di46eTaDgw9MhfejWSN+GJjy2Bkd5unLzDXmRD1nh507OQFl0wGHFt+5u+6Khu6wczAoJI0HlN6z5wBjf7D5Vv/c3gwW1bmt7dnr3m4ymyAjnfGth0in+WhNMGTfPxSoFVh8Glugcs+NVryee626tPcaOGhkmpuO+1VqgqEd5O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B/LSvh5U; arc=fail smtp.client-ip=52.101.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/LSvh5U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+H9dxXlBklILO8kUR/uim6HYDqVjvU0MQXkCh4fo0TGVZ/sRPIV2dw1oZKlOHIouzXC7mzg69W/53WvFpObCz2yA9mdiLEB1CIsJMCgojNq5jUh0t8stQhYiiqhfpFNvCC4MGTiCrshHcs7rY95fBFSICd454tFbz47ZVXrH4YG16lsVtKeJVJ7ErgtZbNAcQfiMbc0iY9qNx/oYC5iKGZhslk663fHLWxGwEK29IqnjWinwlKFuFR4lqwy3MZz41fRWtMbQxhIwBtkgRl1NApD15tnsKZZmqXzhWgzhHXA+rJXjBgiHyQoe/Z6XfWTaXZEoS6vgjb95oWauvm5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W33yyWvx4735N0IT9MZcNIjK0Y/PjuH37OLW0pmeWHM=;
 b=RnbNfBYprZsg+Rk40ghfwzeDmjQcUOiEjvNGzV7cMMAXre/+oFfQGynUEwvlrtdaC1nr/on5nqt2knT9QNK8atDvEkpDgOM8t80FoE/F+t07HPP5aEGnjcqm1rk7mxoJ9yfDv+/tKV8YDWpNakCnBvYv+wy0/18yONmJ9SnkOptqUEZuc+hGGChJUDeQ+BnnX0j5K2NUYVxkMjZ5E8kYZeMonp5fXQzxQUzsiNwDbrS0pYq3t6H3RE/cyG0vWg027nlZdkFFuN1+5KoIAczWf2+LaAOZqyuVsIhsDXTVNqvMpeFek1YyqD369r9WxZC8i0QwAgM6qKMsjZNbmfulyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W33yyWvx4735N0IT9MZcNIjK0Y/PjuH37OLW0pmeWHM=;
 b=B/LSvh5Uofpm8we5YrdmubA0g60M+RVJzp+CinTqQa1Mj1xd5pQBrvJPnXWp8aJNbXXnfIBd7IbgRLPvbp/hy8SLTQvb8k7d7oWEIc8XQtRycOxgusM66La+vZlgiy4ergm4WRT6VV55qCJtWCQUOl0cDOVNjBMv5oqOReQoDDyADu7ueD9Wo4bQ8WbkPGkKNfLJOyMuNDlZLA1SFicRuIGEyIJ4ZXi3mCajp3aMzH0jmOmYTnjDW/aca8RtuM46osBmp39rYTPR3QY5c2f4d8vh7gnuWPZTl8wSMhhgk7b7AShKXaQ7iwiRzz8e/keOiCY5K4ebv0/jCC3suhKoFA==
Received: from SJ0PR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:332::15)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:40:15 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::de) by SJ0PR05CA0070.outlook.office365.com
 (2603:10b6:a03:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Wed,
 1 Apr 2026 14:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:40:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:40:01 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:39:54 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dmatlack@google.com>, <shuah@kernel.org>,
	<jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH v2 03/20] cxl: Move component/HDM register defines to uapi/cxl/cxl_regs.h
Date: Wed, 1 Apr 2026 20:09:00 +0530
Message-ID: <20260401143917.108413-4-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401143917.108413-1-mhonap@nvidia.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: e86ed2bc-7e62-4c7e-e55c-08de8ffc9681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SgGyIeBdOi/hpABe+Ih0GS4aFKq1Pw2yEP4AQc+SAj7S7fhfeVjULHPlqxhyZ3oWC/x/xf/Cw/4bcrAYrQhtfXubGi2LpPQfNPbXHAmkx/EIekwhgqy4OsTYBGi4EA/nZ3ZY7L0cHG9d2TSBwydmCX/HmK0WUBjE+rmo3H6mTvLmaf17xpuc0uh3iZmiMHEWz+cxUPvw1C4xiSGkl2R+uUHZJsjiSQEuE6Gejc34B2Wu4dKLvvRnoHYEnQ3jxP0UTNDJMHL7RdU30/HjyK8ve6do9cvyK0WdbCMteRK3MlOfsKj/54sSka5/Dj6/TzqPgguLI7t2ouRHO/aWuBPVbXhmbYvgcEWbK+nx/eIlyvvVnF9DOSgoHm3KD2E0dsphJ+vGhd8QYAs7U5DQ2AM/1wE0aH8X+qaauUq2DSmotx+aQkQ1jBSnBztkYpxl7Lt8gkV47yBI8dhmxPGmos7nhi3YWvd8vjNlbZxHqtl9dE6Cd90yiNvz5HVLUpIfsQa1WfRb0pdBup57AVDpUdKOWBxBCteSMOzKyOtJZV6v3GtN6FIE9sC5m+kwpPws3dJTvZLN586qRdEakQqzc3jW6tqc8TLaVnQnW9de3IeeeUINitSWbGSog/7TU9r9n0+aiO+tpyVZMQG6+49uHqCKmpm/VCujmdx3Q8fNpMAlokVyftpnH3tQLPtLr8x0DuHHKzWAhh0e5mVuLgYGMrA36CnCqvGSFexxjdDF9dBGPc6eEMxtezrf7NE9IsTzQhTnKl7bif60qgjPXkOkCQDzRNH/F7489Cixq8tvhQI7pr3o7pMq/KP+UrIaHiTlY4pJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V6bKbM5DYHOjJ5/I7uIjWFiui/R3HZ8fDLeYyv8h90PaubD9EUcP3tBPpXl3Aq4ydQVYVKBsFOhnt8HG2n4LpwgR4lzeQ26b3mq8R56ybnew1pRfUQLl5sPG7aH/leLwsNjr3HrkGW/tPCgUnF9j6LJPOqKkbo/mS/t23GP1YZhG8BFmTi9w29pk/mWeqKdbuoD4vI0dSpTdfsOnj1usAGPLBPOacYDhEQzMZkjExKclZInw1MjcGRgOPh0BNKxE0/ruVJyLKeoYU8rLle6t8ZduAHI6x8UGuOgyYKdpqbx1CVo+c58/YQ0fZl6lcv5XbTU5QzLi17Km0eIpcSCWGn4C16Y1NIcbSpMVgDZyb/Lb8CrKQeRyCOE3r1oCKGR7ZOrG6QHy1eJLSiUMHnYeFRtiff82k9K3x6hfiqSjbtS+8GFCDv+i+aRKjmnmNW2i
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:40:15.1525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86ed2bc-7e62-4c7e-e55c-08de8ffc9681
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678

From: Manish Honap <mhonap@nvidia.com>

VFIO and other code outside the CXL core needs the same offset/mask
constants the core uses for the component register block and HDM
decoders.

Pull them into a new include/uapi/cxl/cxl_regs.h
(GPL-2.0 WITH Linux-syscall-note) and include it from
include/cxl/cxl.h. Use the uapi-friendly __GENMASK helpers where
needed. Section comments in the new file reference CXL spec r4.0 numbering.

For UAPI change, replaced the SZ_64K with actual size as the macro
will not be available for userspace programs.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/cxl.h           | 42 ---------------------------
 include/cxl/cxl.h           |  1 +
 include/uapi/cxl/cxl_regs.h | 57 +++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 42 deletions(-)
 create mode 100644 include/uapi/cxl/cxl_regs.h

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 10ddab3949ee..172e38d58c50 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -24,48 +24,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
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
-
 /* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
 #define CXL_DECODER_MIN_GRANULARITY 256
 #define CXL_DECODER_MAX_ENCODED_IG 6
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 8ef7915a51f7..f48274673b1b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -9,6 +9,7 @@
 #include <linux/ioport.h>
 #include <linux/range.h>
 #include <cxl/mailbox.h>
+#include <uapi/cxl/cxl_regs.h>
 
 /**
  * enum cxl_devtype - delineate type-2 from a generic type-3 device
diff --git a/include/uapi/cxl/cxl_regs.h b/include/uapi/cxl/cxl_regs.h
new file mode 100644
index 000000000000..1a48a3805f52
--- /dev/null
+++ b/include/uapi/cxl/cxl_regs.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * CXL Standard defines
+ *
+ * Hardware register offsets and bit-field masks for the CXL Component
+ * Register block, as defined by the CXL Specification r4.0.
+ */
+
+#ifndef _UAPI_CXL_REGS_H_
+#define _UAPI_CXL_REGS_H_
+
+#include <linux/const.h>   /* _BITUL(), _BITULL() */
+#include <linux/bits.h>    /* __GENMASK() */
+
+/* CXL 4.0 8.2.3 CXL Component Register Layout and Definition */
+#define CXL_COMPONENT_REG_BLOCK_SIZE 0x00010000
+
+/* CXL 4.0 8.2.4 CXL.cache and CXL.mem Registers*/
+#define CXL_CM_OFFSET 0x1000
+#define CXL_CM_CAP_HDR_OFFSET 0x0
+#define   CXL_CM_CAP_HDR_ID_MASK __GENMASK(15, 0)
+#define     CM_CAP_HDR_CAP_ID 1
+#define   CXL_CM_CAP_HDR_VERSION_MASK __GENMASK(19, 16)
+#define     CM_CAP_HDR_CAP_VERSION 1
+#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK __GENMASK(23, 20)
+#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
+#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK __GENMASK(31, 24)
+#define CXL_CM_CAP_PTR_MASK __GENMASK(31, 20)
+
+/* HDM decoders CXL 4.0 8.2.4.20 CXL HDM Decoder Capability Structure */
+#define CXL_HDM_DECODER_CAP_OFFSET 0x0
+#define   CXL_HDM_DECODER_COUNT_MASK __GENMASK(3, 0)
+#define   CXL_HDM_DECODER_TARGET_COUNT_MASK __GENMASK(7, 4)
+#define   CXL_HDM_DECODER_INTERLEAVE_11_8 _BITUL(8)
+#define   CXL_HDM_DECODER_INTERLEAVE_14_12 _BITUL(9)
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY _BITUL(11)
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY _BITUL(12)
+#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
+#define   CXL_HDM_DECODER_ENABLE _BITUL(1)
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
+#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
+#define   CXL_HDM_DECODER0_CTRL_IG_MASK __GENMASK(3, 0)
+#define   CXL_HDM_DECODER0_CTRL_IW_MASK __GENMASK(7, 4)
+#define   CXL_HDM_DECODER0_CTRL_LOCK _BITUL(8)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT _BITUL(9)
+#define   CXL_HDM_DECODER0_CTRL_COMMITTED _BITUL(10)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR _BITUL(11)
+#define   CXL_HDM_DECODER0_CTRL_HOSTONLY _BITUL(12)
+#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
+#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
+#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
+#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
+
+#endif /* _UAPI_CXL_REGS_H_ */
-- 
2.25.1

