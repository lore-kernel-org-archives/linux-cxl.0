Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539B3ACA5A
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022164; cv=fail; b=fb11tBXS608/HnE3QDrWutmlhgesVmFdzKCVTVRtB2sFUEllnfWms8/WXFugZrf3ARfS3WXOD1BCfBFDXrvnZyK0MEjCjOyIcNofZg8t9m8gQqUvzi1PB4CQ1UgEfD/4oyo+mm6n/ElBrAxIrV2Cf62LAhlHmDdIUOStUBu8LA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022164; c=relaxed/simple;
	bh=R6EgRAo6srYJVUxRe/0CKgQ4R8ZJbMiBV/qEZDkZ0vA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UORMciQgY7lAMPmauf5Za5F74zmGTMvx7Pw/ccnXHf43LXBvfOaaQX4Tn6+FLi05MCkmz1ry+yuCaANb5cUSjMS8yW6gOeJ0WtS8ibPfrXvALG8tRqEshfk7w/bdac0zI8CN0SGGVVqHIgVvNf4jNjTgkyQ2VzBuloVFtGlEWOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X6vsAT2V; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X6vsAT2V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJpA5BH+SOoKvcoDlI5OUuSjUuMMjiCUkPUNbyL/oE3irJ8ta4xcm/km6c7LUzy4p//WZXJuRO2RqPc+YR1PKapvba3EARu3BFFV61eBU93P23xCbjKRe9Ztni3WsrePMAB24Elw6A+Nuh4c+bIqVxsXRbelgUmO5Uprf5GnE5MVtnXuN4KfefdGR/Tn98DAZeNwuiOH1oxlKM26ftJ2phEvvuhTExFa1tpCDGbUIzdD/RqgRMNs3npxPI/auY8duk3kHcn+eZcknLgB0PpLIXULWZjj9Rc3DFoR6WEjezBVmYsDdwnpEgnwIlaHPAKYk6g+fJ3eDWWqfwFSydAJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rrPT6fBzjfBflYMrr0D5NcrAToVYoDVNqKECFoJ0Dk=;
 b=AwyQ/ykZmIqM6yHsfb4pZiudRKVel5izDoytdS6rIU7FEODfdqgZR008Lp/++xOBCpmjiSnI+LtFohoj3PVHAKYs0wNBc3kwfbMFkwgzS9UJIMJRUcCQWHtW2stz82PtlxqlleuaN7EbTeMUQA0/utHYu31QzRBZR85WiNNw23Qj+Fr1CcWSKNXn28ZqXOr7670gxmc6yzp/Wlsueo/VfDpO5zYl9+dQjvoIP0gUBLLEbIdypM3snmnc4mBaBcFZ+ABwqEtTS9Tqw8ZGkV6uEfZA8+tQFm+1gv0jKYOOlTVkLMKLV+TX+B5Fi9z/6PovXuvnjZArajq9FNwwQo+WNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rrPT6fBzjfBflYMrr0D5NcrAToVYoDVNqKECFoJ0Dk=;
 b=X6vsAT2VM6oO0/wpdHTjySmqwVgNaaugt4bKWzJl38WDy2xuHlP7jOP8lYg4DG+F8I36L4IBJsQd0QNpEfeCdj2hTyEEckNSz1yMctWaI0jV05q+z+1qJcICXC0//BIzRAqgh+0q6HJkH0lMCbK3d7v9kuhk15WQXUgLs+/urew=
Received: from DS7PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:3bb::23)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:22:39 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::e0) by DS7PR03CA0078.outlook.office365.com
 (2603:10b6:5:3bb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 12:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:22:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:22:38 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 25 Feb 2026 06:22:38 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Gregory Price <gourry@gourry.net>
Subject: [PATCH v2 2/3] cxl/region: Factor out interleave ways setup
Date: Wed, 25 Feb 2026 12:22:22 +0000
Message-ID: <20260225122223.3841889-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
References: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c302f47-80e4-4924-88e1-08de74689125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	cyr+1KF/sNJe00k7RY0M3rs05SM4odJOhiUNHMPTPNP9KQwsEYVgTag636BSTr5JPSSaceoQGGqnJ82yjVZaipY9yGXsaKmnHbdOBjp8x4G9zVbkKKmoaXblaETgpH5Ji6qBP4wk73F9lFzgys1z389tny95OdgZE4gEQSdAMsMSQmFfrteg91pZsXmH29fvyVFp8E1y0ee2sKBfl4FMuWFz9g1XCZExVjVcmv3iEesTK8F1fHmouti9EbryRAuGNUpGEuw9CMxCShpKbw95j6KW+8OHw48htSxNEEGjuDG6PQWIYsXyJQhEW7zaMQeM3mj1NWaHM6unfrFSrep9Lt2Irr8Lhdz5ZQbAh/mu/6Zi269QH7hub2fCYYDq7YJLslcpnkIV5XNwuflL3c9z1oYH5h/a0sJdA0icg+eHCoCG8LK98W9XPqX49SgUQey8p3P0anKi3qyESCNmZbif3JTtYTPIjzSwunL4kswSe3r/OlemXUAwTNyhcGSz+2s7L/TT9VP0mn1sq/pGSJRET3E4iL1jnvGa3YnFRQ3Pgjn35kdiEdQswlEkqtbzc4eFl4ib2hkEwbYYs4GnpX9uY/l/MCUWdTE5A44Z02LYKQpuoREvC9oDBVV9xRPVxUpSM5rl4lvC8ujd9YdHf+TBmTS9F1nkCxDbUwONsms39LNvKPxaT486i/vPmQb6nGJjewW+BqKPkCjI23unkrSX7RbHhITu96OThQAOlWF7ZVSrhZIG7yq0xTH4shti80dQ3HjPBmKnnczFMDQo+wVaCHHwY7JSbWPf0v6+Di2L+SdmEKT8gqKjHkfrzdjChO8ltgE+ONL69avoTc8CNJ2f0A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tjh+5/cnyd4hm5TodTPD0Y7d3Q12j6qHhxp7bAcHgXDGQ926am53oBUdvbnZHFq7bLQNiGD+FPbBAD0nVTsbhbW25Tfuom0u4cmGp5uMn5i3GqjfHazD8Bkx4N7UDGexWrrFuB2wXDb7WiwpGwORrdH+eGeAXq071hbviGa/lA5+qmvUyqlFaqxmb8DFbMep32x3PnBWEFgGcIb4PxaZeM09QSb/dVCKHOxOOrKjWo2GLrLbpREnkJQcNM8XQflnbp7HvNYg7izKMwjHHpxCVHodZi7peYYvqTx1oKehRrQFtxaskfih2E36620vdYkDiGZwAdxehwGcm2+BoWGq8I+tgtywMToSun0hBLCVxVGUJsoB94HfqByQ2H2EwYqenjtKsZWZmHkmKtf/Tm66O0uS+o+kGaj51CjoExUyTVn0/2n1j0lTxMkHyl2uIDhY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:22:39.3045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c302f47-80e4-4924-88e1-08de74689125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices can be triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 41 +++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cac33c99fe6a..3ef4ccf1c92b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -485,22 +485,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static const struct attribute_group *get_cxl_region_target_group(void);
 
-static ssize_t interleave_ways_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+static int set_interleave_ways(struct cxl_region *cxlr, int val)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
-	unsigned int val, save;
-	int rc;
+	int save, rc;
 	u8 iw;
 
-	rc = kstrtouint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = ways_to_eiw(val, &iw);
 	if (rc)
 		return rc;
@@ -515,9 +507,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
@@ -525,10 +515,31 @@ static ssize_t interleave_ways_store(struct device *dev,
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-	if (rc) {
+	if (rc)
 		p->interleave_ways = save;
+
+	return rc;
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
+	if (rc)
 		return rc;
-	}
 
 	return len;
 }
-- 
2.34.1

