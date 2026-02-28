Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F83824FC
	for <linux-cxl@vger.kernel.org>; Sat, 28 Feb 2026 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300178; cv=fail; b=keOAXBXblLm648ue/J3Jg0AQXvjXITno9JT9K4dDVSt0IneceuUHUZGw9O5yIx9aX6zf5UVFGxJFECyAuYiR16SpeV+oUidLvLDqsA7OBYWne5eUzhXEnyk7T9c4j05MybbiaaP1sjS8l/P0KEQ9ae4dHByDXCSO9npihg+DkJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300178; c=relaxed/simple;
	bh=7jUkkwCAHjcpsQR6ZCH7UG5ZUMB29JXDk8rehzVaJ7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eb6XlF3sLw48b+QU9tcE8BKsCEKfhIhLuepF9OSYv6t16DC40CgwIdeZb0pHmQMbaRRarmavGmfJryuZ+rb22tTr+pReZ6bSEDT8DlJ76mBfJeYRl9QcGy4svLHipqpGqsOmXu0OVbs3qBc/Hqe1XpjHCV9Zo16ugP3gADn8FQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LrtObIc2; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LrtObIc2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhjfhiLM6b8C1pu3Hebm4ZrKrSsnX2RwyFqUdBOBbM8fQFZlxi57cim6pUyGVrlYjfOzv/1sOfShdVbP0YEi1DwhufXUQrl3gacCVn2f45/akuKyZ5/EKf+gi65u1d7icX1Z2kPhT9KJGBFZDDfMjDwRVugBTnUkghMo+wkZmHl9/dudR50w0mvbazbA/lfB1hMsFdDxYaJrVI9+kWjWmExdmgz58WZSQ14iZXLpLSb6R95RI5TL4593yB+nQxXenLTDkTtViIdR03HjOGMTX9GB3VXtXmeZDGzwFJegYN2J0s6ZFxfQGXk44GSO/HWb5WxLFFqEOm6VGuTM6cZvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq46jwzUGpGetO1BMgfj5kV2txojjmN/BaSnHPeU7m0=;
 b=T9mAiGeR4+wX8Vb7o9YIramVkAuGpH1AXZ1Hod7yMTOkaP4ND+RLatpkmtGMcVWaTjB5Plk8mb/BBazjXlx0mbpPi/U3tIbO5njt3UpMsAygvrcRFk+QBu1ZPsFBGACWjdeakChX/2VHvNypSr85kJYUSE0EJmtgatgRc36hjnjufT/A3MeS0IO3SQ9ukaVj9dvuwFASbUIWtE+bwsBUIAp6nwNed3daMLT8biqF6raCGOCCh0FALvZWO6VYUlTQtmed+bYgUZQyXYX1oW6CJk+oOv6s2kgqTC/ghUqroKTiV7uk731kZD+eA/YqRP/NTWJ/J7wrsxQxEIwL1cS1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq46jwzUGpGetO1BMgfj5kV2txojjmN/BaSnHPeU7m0=;
 b=LrtObIc2eM2v8RD1H6Ki8grT9A9lzhO1QPFiM6fj9150eJttyJPqiMq0lCUnA2HeYUoxq5ER2ZGTCOnkJo/YPEuCj5U/VycvGlA7GBsM7I9EHOqmqgy2Z47Q1BUNN9OcGkFM+c2BNFpbxV+rG8auiGHVfkXI8SJes5OEaQ4U69I=
Received: from SN6PR16CA0065.namprd16.prod.outlook.com (2603:10b6:805:ca::42)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 17:36:14 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::bb) by SN6PR16CA0065.outlook.office365.com
 (2603:10b6:805:ca::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Sat,
 28 Feb 2026 17:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 17:36:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 28 Feb
 2026 11:36:12 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 28 Feb
 2026 11:36:12 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 28 Feb 2026 11:36:11 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <daves@stgolabs.net>, Gregory Price <gourry@gourry.net>
Subject: [PATCH v3 1/3] cxl: Make region type based on endpoint type
Date: Sat, 28 Feb 2026 17:36:01 +0000
Message-ID: <20260228173603.1125109-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228173603.1125109-1-alejandro.lucero-palau@amd.com>
References: <20260228173603.1125109-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0b1042-e8de-43c3-33a3-08de76efde46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	SOSbz6p0mZd4lNTnaVtuAa6K8/O1qqKr1uMumU78tFIL3lB543ZPtPkzjx0c5e4Y1bOxSN8lLTeeXlB9vw/02JkyBXtX9fK9I1izInrYfPbGy9hGHjWnNyXYoqnfMnogpgqLk4MvYobCHKmncZOcGXkN4uP/4j6iq60cHuIbAzH4aMmCUIAf65kgPLrLPAGWNUqT+oxEnwMyff4kbK1KxM/pQQhx/6fkJu4uPb6Ex/AMFsi445j1R91cn1kXAZXYgp3NL1n0FSkVnet0amS7PV4dpDPIKIo0QvLWx7TNb73UHde2PF4h6u43TNpYg3TNe41ljeuwG5K6H21gjZe8um/tS9emnTI7WoR0MO1ueVmF6epFWAYBusO/FJSSv1tEb4LHsxKyJxZixse3JFJFId1YF4EA3nptUj+3AJ/a4q8HHblUi5Bx1D6Yp2re4QbJW7YnxZwznSPXBBhmUPulBEEAtytS6d8mkfy3GQ8pFdc9rVHH5lJ9qgeln1qGpIm84BWVLImQtMnS2/Q86TKsk+KJhORvJmbzuPen+pCfiVUriIPl1fuUi4kLnfJSBPMI7P7pVJH676VFlybxWSwF51A/GbRfLiIzJQW6Mt3HKHiWyCJV0x2HDKEN2TQh0W3Dp06+AaLQLH5kWP4lt/Ck1QKv14u2ERGT1g6iudjA5YePlPp0j2oocKEHHwuIvcREFzMouxp8HA5mJ2kMADWXzwu6zVVRJ7MRebQnKjHhGjkP0TcU2iRWfg+WVu6TJ0C3jzvdIX4G3r0tKMxFELAowO685dWtUFDhriQUx0HSaGys3Dg2wHMMdUh9LHSyDbygkSacp1g8Ow9PgE9tpUrq/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mUr7IMxppi1fq6SWktv/QDPqG1UGWJrHjXqnuSKRf3NrCem79oCp8MP2JC8X/X7inHn5uvioKdNf0aLZQy+miyIgRT0ndPPMjFDL+u1L5AuYeWfcU1N7qaTR43qCNFbCfprHoWhz30gMBSN1K9TFKiksz+d318d09PEXVecyNJqAvF0PTKVaJ41joxCqXac/k1gDV+tZMSXZ8nIWUtUiuW4sfFzwle8+6sgPAa/ZU6rRfkI2v8GX2D5ToTNGtrx5KnQxQuDCNRb8fLwuCFn6QU3QukoFU+ayUGLDDEMWVDanS2oG7NSNTrQqBAP2lza1frWLAPJ6ebLPhIAGkyURPE2R7TRyDFbcMDKHsuv2mU6jrgIQ0M4n5B+l67/tB1R21juciUGlBlJWFcOwJlhJAHwhMlSagi/JYxjanSWEkeydM1myj+rGq9MZ4i2lYtiX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 17:36:13.0943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0b1042-e8de-43c3-33a3-08de76efde46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type HDM-D[B] instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fec37af1dfbf..cac33c99fe6a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2650,7 +2650,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2672,7 +2673,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2686,7 +2687,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3902,7 +3903,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1

