Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BBF359A7B;
	Wed, 11 Mar 2026 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261354; cv=fail; b=syveazfpG6//aibicxGWcT2n2VTNPYw5Ww3qX+ar92deP9jYUqiCDSt8dcKh9hgehrQ++6FxA6nJCI1o5Y9aboTcIK3MZx8zInGnZrWQa0QQ/tDOTP2+z3tQsmxbqbXslFn1YFLcvxjKqR0oogsp54m1uyiBKd0Gtuumi9dnYx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261354; c=relaxed/simple;
	bh=94+aV+edETR7Q+XmNp5Ed5W9sSqdkR5LlBL+zCIJXXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsG+kuHHY0Al4ZsxDIGg61zz4BAGrs3qgTyGMPm4bpJF4VoSv295D7NMRGDEUnqz1pOzPth/JuBjbPTTu1eLw5256j94I2cTTffbwLI+rVHvLyYdZDAGrUM/VTxra2xM3OPRGgpBnf9l/ydZqyI6voiiG0q4a2PLcWHp2KLo/7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0SwD7rh; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0SwD7rh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFOsVco+FbWdCXEIVjM6a7zU/miRMJ5AzuivdUG1mkGSgLT8oq/7VkikyVPkB5eowHFKQb5o1IbLbv18E5chyFyK4pzLfVEEmk4qwKUiSY6oVinQTN4eFOKfPuv7eXQbciAg1dSZIaPwYGxYFn4RT1tM6mLgdL2VlM1fYr6j/1mQMDuOI7fOLH2FqBbnhP0KkuCKy6urPmRde02gGBFBy3f5hBVVSWdggNwtKduC2kv786+56tqz3kW1TbOwDI0fORM/db8Dyo8dAn2vnIitDPMzJn81VYpXYgg1t4jTzMwk/ZyMPBCleAGeVgMvB+wwzdpWAeM7xeqbv0ZiPQzYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8QHt4U1h+QCVajNxwjjHy2sS8GW7Gsrn0vEHBbQNTM=;
 b=yX1E3nmjl8AYWNl0rQSXGDER5JVDuLSCBIR/Q1bPj+GtCzLZhdgIMtQmJMa9FXTS1XzUCvomgwIAFmZZe09F2rgvdq13ton3Q+uovd6rw+TWnCSbNMupLQng7T2GL4TINypTsEk1BXDlc19xgM26TXnY+sDVaUl6P4A702U0X3ZQaj6H87F4rFbSfFPNt1bGzD+KfUJX0RGMdZFvFaUoXVW8QW16Plu4/3q2dRKlkpEeM856vIWusb/Jz12KnF9V/odzGzsm1iwcA8aWeu8/aJQzk1rVHExHAwVe6eAZRDCwlmScoZ+N71qxCR8UyqHYw3uqElJz5B6pcQ6PnTZx3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8QHt4U1h+QCVajNxwjjHy2sS8GW7Gsrn0vEHBbQNTM=;
 b=R0SwD7rh6R3WcOiNJbeF83b+xnnTvrwjik5W2UxDp088hoaXjjTNh3uUu7Kv5IowLjezsCzsRxAsYMrbemDNk13mfqY94Xv9kp4igmNYHro/GQYyYSeqZ1jIdOLy9vCjI3rpoZPQXTv5IaIau4IAN5MNWhYBkd/AwgITO5WmxVRl8ZKh2clC2zO/0Y996Fye/JLufDHjPXLxsdEJrK6japu9lFGqB8LEE0OsZkW5fIMToh1nFvnGSeMCn0ZC1j+g1l2reWBpWcvrcpERFn4S9ZTMWB7W9XJJeZSjhPLxUN3tKYI3aWo2ZTNknrBy2CDGqahHP+ck3sTXND/aQBM2eQ==
Received: from SN7PR04CA0079.namprd04.prod.outlook.com (2603:10b6:806:121::24)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 11 Mar
 2026 20:35:44 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::40) by SN7PR04CA0079.outlook.office365.com
 (2603:10b6:806:121::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 20:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:35:44 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:19 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:35:12 -0700
From: <mhonap@nvidia.com>
To: <aniketa@nvidia.com>, <ankita@nvidia.com>, <alwilliamson@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jgg@ziepe.ca>,
	<yishaih@nvidia.com>, <kevin.tian@intel.com>
CC: <cjia@nvidia.com>, <targupta@nvidia.com>, <zhiw@nvidia.com>,
	<kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH 03/20] cxl: Move CXL spec defines to public header
Date: Thu, 12 Mar 2026 02:04:23 +0530
Message-ID: <20260311203440.752648-4-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260311203440.752648-1-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f071d7-c21c-4745-8a49-08de7fadc533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	0OuxRZwhcf3hGLhvXp23BA/6vF+x37iqAC1XKRh1z6HcDGHOW5WYVoHkM/dWMU6z8R+07KpVI3iT4E3CNiczj9wHbNnCVC7rCwWyOurQfLP80VTt2x300yoVd3/gbFEoww1wv4NZMJ2nSTVvtDQ9ljM/GFHzMWYuo/Qt5UBY3UdJmhK/tJ/PNNPZKAVvGR8lbEruzU5I2B3lWmTLQEsFKqP+VdLMucs9NPMsixZmbVJxZ5kni9joO/0vudrCAJpav5t9srB0+mMRp1HZIPZyZhB89TAyLhnBDUMicgtJhxgLXLiHAOBbuwMrx3372PxogscnEd/d5h2dRnPF5d9zI+KKt4zBDiIFFAC5gGSg/Qwz5Adta77j8pkYWo0rkAbZVSgEkhYJVQqSJedgZjrSOPageRYKmZGDDg+BbOKHAdjeY3CB2cdjtzISaN4rMzJOevvx1VRcpmCWnFagqUieQ61bm4umH0DpYuBMmAKh7BfchgELX07Y1lZLTqLu4ASB5+9fyJvfcbNS7iMqS1lJNwegba1QXVOa5qzmEMEK6h8J/0fb1Iu/YEnWSUDYDDgvNit9uFXxNuudeji5i9xHZMut50MsthAGPqZ1ylvSLSyOn/e+/N0irAAyFHvqsvLWv3A+34RXIau6pbb49VxTvG955t7/iUmICfEL7n2ZGww5OHOhigXTdgywRByY7SsZ8XZic+H4PU3MTvKnXqyzlfETBqLK6DUNKv53z4e53qU9vpeziPy3dRm24iQyq3s36n0Uya3E1V+gWvcwwBlK9gL6CUtJ05BjDGc3LadTZxT9qmLWg6yq35jhUASjLJR3
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wxr0rLIxIfMweAepsI0S7AKRRPP0yVDjzYI1wo/oStlI84sayJHmU0Y+5E+TfrvM3CQlP1VBuW9GTZKl8ZtlbFkocAU/VxYgSUzBlH9/iaP0JuGfI/N5I2oLTFxvntxBIS8iv1NCXXZhqrxeYsqumtzhpiIA9hOSKAQCX/KpsTmSO6UWtfyGiuUmgKyVjvm2GymL0AxSE+JA+9I/XN5oge8TpaKHKPn4hAscFFLs6pPaNEgpbv1cJKIaLj0+u6t57d3jsofvYoxrohSEuIwMHMQUXdKG9xT4Nm2nz1COgRVGhC3kCu5rvCZxz9Mml2o9S0fvHMZYxQ0ip3CuoPzWSKmoeaRyiOUOja0IYrZLIjXwg1MELKlLY4nMgjvx8ZYHfvGGwXQoizZllKrj3mkPFZvgq5kbGEyuYFig39GiXnKju25iCgvHYU1swkedt3oR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:35:44.6282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f071d7-c21c-4745-8a49-08de7fadc533
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739

From: Manish Honap <mhonap@nvidia.com>

HDM decoder capability structure and component reg block size
needs to be used by VFIO subsystem. Move the macros from private
CXL header to public one.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/cxl.h | 30 ------------------------------
 include/cxl/cxl.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 10ddab3949ee..7146059e0dae 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -24,9 +24,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
  * (port-driver, region-driver, nvdimm object-drivers... etc).
  */
 
-/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
-#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
-
 /* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
 #define CXL_CM_OFFSET 0x1000
 #define CXL_CM_CAP_HDR_OFFSET 0x0
@@ -39,33 +36,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
 
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
index 610711e861d4..27c006fa53c3 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -75,6 +75,36 @@ struct cxl_regs {
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
+/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
+#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
+
+/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
+#define CXL_HDM_DECODER_CAP_OFFSET 0x0
+#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
+#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
+#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
+#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
+#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
+#define   CXL_HDM_DECODER_ENABLE BIT(1)
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
+#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
+#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
+#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
+#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
+#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
+#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
+#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
+#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
+#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
+#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
-- 
2.25.1

