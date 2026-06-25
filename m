Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC721A9F87;
	Thu, 25 Jun 2026 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406525; cv=fail; b=jF7vleKY8ZDK92i2gcU1JVaeK1Z2rOUPPTjndPY7hmamhP6cyaodj+0zVB7wcLHiW0W5T322YKKqOts1JmuMX1Y0qZCKAdBb1gWlolvnS/Hv7YqBdVRiByUvgJoE32KnCAlSSzt2k6ufiSLJwfGfyxN+RqrIkfUMGMEGekVbtyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406525; c=relaxed/simple;
	bh=qea8FvHxJDRg+VlMhEls2+CIfp9VBXKvmmLcv+dZ5wA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNc4iolzVfJlGj0ZK1DceXw958Dc0+/5FeNmD7eqRlYFMbsKloQe8q7ERftCT4VZXOzz+9ZPyZZHp4+ZJkikzy5CQHRGlDhRCKFvGm9Kz89d4A9Tjraeuq+0gFjzNA6ASoHWmArR2f1fRAAihZ2YQkfQcrKXHF0LykiA4MjhXes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g5pcIQc5; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g5pcIQc5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O86An+oe7V4H57LNcuOrZXPSlhUInfBmG6F6SuBGHgAoFdeX2bO7UCdSa7m61kYnPWltT0KPUUcGkJXlC3/LKhCU2CJTiuIbfcGpIKkqom3j9d76fyeWJyok42VPIKt2ULstcF/VjESmNiIDJlz8ZZt5vOJZwicDdkj17cWkobG+mhUVxQYCpkt1dCBlcKtgEogXuYOLPTLxowEuwvFr5g0HcmfevihLwHwUVhyI7+2CMUFUW1CBts34RiuED7jTupxO5JmxRfIwIjn0cR/Vp9Kz5RdeRoZFcct/rhRXD5RiyHjMrXM7X0mWT4iDNycgLnuoeveSJ+246PMQaLubLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CqcGcEv1QVpJQu7IwPMuon11ZZLpSxZfQSZEs1wPpo=;
 b=wjvFLQw+ttO0EMKR8luqE05adP8N1Ub7p7/Gbd0FpvOZ1/43YaguGXfPIxBnemE9xmVpbUX8hPq8KArRnTfffBLJ1p43+b+sW9Ewl/1QPHElxvifAfv1VtmHXXmhS6Oem8X+oYZqO8Dshah40ZjXBtoJRCZJ+vhva+tJ4/1LgQPNFoMeQ9YjHSHkWgIIOo9MSadxawUjSS4LX+KBlQN2cfjedOgnDhg0JYNK2ro1wxjzaC9ctSrO7RtrJLcga8YPI+5FX3OgjnzV/gllMKoxofn7ci6msgy3i5vQKAPPAw/u6HpGW4JmpbDAN5lozQSqfIT+BtPgjfMbRjoq+u7Qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CqcGcEv1QVpJQu7IwPMuon11ZZLpSxZfQSZEs1wPpo=;
 b=g5pcIQc5Z4v0PGW0Lw7k0UjymTPqeG4fcZCHP5/BgJH0joa7Q8HSJudTTK/PKvLKjf3HdPPUom0IBr/m9dZP/gYIEj1/rl0c5tgqbRjiBIiybOevKdwOaKmzQSEe6IRdfzcoSqJU4K/TTlB58NhrEsdtHC0xFxMzwok7TzHa+JLZ2Chm6vlY53l5LxfWkIzQQwftF1H49xuPtC2HmmegU65S6KZ1h6uBn/AD3/sDoIwvUrI9xt0Co5mDbit4DLodGcPNjmZDl76VYYXp5OEyTuczcaEWOD4c5i1LME7SebaD7Wka+I/Q135Osa+EUUd2RC9vwndAaCzyYmfHnPgJlw==
Received: from MN0P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::20)
 by PH0PR12MB999090.namprd12.prod.outlook.com (2603:10b6:510:38c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 16:55:19 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::74) by MN0P221CA0029.outlook.office365.com
 (2603:10b6:208:52a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 16:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:55:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:54:52 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:54:44 -0700
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
Subject: [PATCH v3 01/11] cxl: Add cxl_get_hdm_info() helper for HDM decoder metadata
Date: Thu, 25 Jun 2026 22:23:57 +0530
Message-ID: <20260625165407.1769572-2-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH0PR12MB999090:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d9d030-af4e-4bb3-92d1-08ded2da89e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|7416014|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	gAKeqKexU4ctVM/3bdF8+X8Ws4gxjGbYhMfCV2wEI0nlAI5+Et6zXHDbE4z3RhMXrGmvI09LIcCu9suNQZaEExFoY+e54v6dx7uXgbplJUffeYxuipoaYCQtRRyJiI0gWyzz8/MKxhRIzVpoLebySv+53OQlLLuRb9YTYKrDIXVU/T62yPKpLri2zfwJaaD+yIhrYzHKPcns7D/P1vWRF5ATVpos7tPukEHhayb5lXMLGzfpvdkEJqEmeSlYW/MvMeDIyNgJgcdH8OK6HwaCkNWyqWKQ8rtu1VbyuuVUQLpDTl7VGt/1jukga3DXYB0aQKyZ2q/ZrSMStbnocHUF47EckLd4cx/Y5CGeopraKZElQicalU/fF4yVKn8r97hBWzE/bqnbzZA5K8O08xk/cOaFZ1ZkFnOFtBFpU74tFQJTWWYvV9euv8xGWvZVmE/eWizXagAt5P6RlpzlxrpO23t4GrfNg1BnmhdlsQywGzvbLsNoeaBDvrucTaBN4uAOuP2gwP5H5r7FslrrLOStpQ8rt2zrjOvi7Qo/tEHR0RznI++oAffVEdHwybPXkKJelduojnhIM+gS6mvof9cWPG1KCNhlx/l16/ivJSRibR+ic1zMK0AxkXAq1VeZJ8CffF3m1qyMOvaVXXIRVcUK3zxeKD4dkuVB9KSNXUIK7ETiMk4r/CjRL1yUUUcJhPt4kfLK20WoKBvEX/GlvCGIenigFTT04AY7PPUVd91p7LCHfcsLA+dbmKJLbPSt1l6h
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	boB3cjDyAxyvdXhyTa7ivlxL5unlUGeeiMZGazaEYAmdIm+kz3Rr9paX4Q0mw85wZSTmNSgHtU5JMTNJXydiQ5kqesKADdeAS0GdsjCW3qMcz3etGIX8H8yje6TMOgN4Q2rqnwkg2bYXi0NHirbLRaNpm94HVmesPwUrK0bMuZWnamT/BRTkxPLs5xRlCvVB9abDrh6/R7j+gnCtDzGeo0Bw1EWCZa76NUuYLFT+m0irEfCha0U5XaAXCbrJ3vh2gGGzaOOOVIzLGaAARy7oIhMkdyRZqiG+a8BLMmCc2XNLiM7ghqLBLtiDe+k6xj1kuXxN9q+vHIyWwdSeRnSGS2cKMdK/vphL6NnG0Znz1sgnid81ABEgF1fOsJFg7uie/2UnODBDkdWADn3tS8Pz3tfvV+efbWOeKW+B9ijGvzf06OiiGdczA3Bo3W724de4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:55:18.9577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d9d030-af4e-4bb3-92d1-08ded2da89e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999090

From: Manish Honap <mhonap@nvidia.com>

cxl_probe_component_regs() finds the HDM decoder block during device
probe and caches its location, but does not record the decoder count
and does not expose the result outside drivers/cxl/.

In-kernel cxl drivers (Type-2 accelerator drivers, vfio-cxl) need the
decoder count and the byte offset and size of the HDM block without
re-running the probe sequence.

Record decoder_cnt in rmap->count when parsing the HDM capability in
cxl_probe_component_regs(), extend struct cxl_reg_map with a count
member, and add cxl_get_hdm_info() to return offset, size, and count
from the cached map.  Export under the CXL namespace.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/pci.c  | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 +
 include/cxl/cxl.h       |  4 ++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2bcd683aa286..c917608c16f9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -449,6 +449,39 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
 
+/**
+ * cxl_get_hdm_info - Get HDM decoder register block location and count
+ * @cxlds: CXL device state (must have component regs enumerated via
+ *	   cxl_probe_component_regs())
+ * @count:  number of HDM decoders (from HDM Capability bits [3:0])
+ * @offset: byte offset of HDM decoder block within the component register BAR
+ * @size:   size in bytes of the HDM decoder block
+ *
+ * Exported for cxl drivers (in-kernel accelerator drivers, vfio-cxl) that
+ * need HDM decoder metadata from the cached component-register map without
+ * re-running the probe sequence.
+ *
+ * Return: 0 on success. -ENODEV if the HDM decoder block is not present.
+ */
+int cxl_get_hdm_info(struct cxl_dev_state *cxlds, u8 *count,
+		     resource_size_t *offset, resource_size_t *size)
+{
+	struct cxl_reg_map *hdm = &cxlds->reg_map.component_map.hdm_decoder;
+
+	if (WARN_ON(!count || !offset || !size))
+		return -EINVAL;
+
+	if (!hdm->valid)
+		return -ENODEV;
+
+	*count	= hdm->count;
+	*offset = hdm->offset;
+	*size	= hdm->size;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_hdm_info, "CXL");
+
 #define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
 #define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
 #define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 20c2d9fbcfe7..e828df0629d0 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -85,6 +85,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			rmap->count = decoder_cnt;
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 802b143de83d..440ab09c640e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -75,6 +75,7 @@ struct cxl_reg_map {
 	int id;
 	unsigned long offset;
 	unsigned long size;
+	u8 count;
 };
 
 struct cxl_component_reg_map {
@@ -228,4 +229,7 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 				      struct range *range);
 
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+
+int cxl_get_hdm_info(struct cxl_dev_state *cxlds, u8 *count,
+		     resource_size_t *offset, resource_size_t *size);
 #endif /* __CXL_CXL_H__ */
-- 
2.25.1

