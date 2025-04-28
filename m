Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23702135DD;
	Mon, 28 Apr 2025 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876643; cv=fail; b=rILkqbMtZKCHp7Js76QWLC2Fr7M7DVnQzic2uaZgjNgr9dUXRMUqOfoMEI1kIhbuWYWEubYX5L5e6mvxxHRzmJQUIovVVZGQW2znyADHE+ytoDvJ3mfoQOIzNMIrOWOcYJBfy6LpNOZgr4wO6s4FZ+UM3ZhujMMcmd80vn4Qsz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876643; c=relaxed/simple;
	bh=T5iiKSvfCOTdtebElhE9QcBC+b/yo+nkYGEtWBABThA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0ly9AtdBxSGknbvfM8Dp5osKpHlhAKNDgzfOsNB13NO41sLMzNXEHqxusO+F8IjAoa6DFBX4DoCcOms9bygK1qyb8BXs1xuzJ9iu1n3WiT8KqXZ0wDpQAP67KWJCfPb11iA1xDUWv9A1j/YsaqTmrWO+NFKAuEHGwyH0wejrPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O3I2YO80; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O3I2YO80"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXELecGfn3DhMKgvinne7u7PfBsgapJ/iuJIalLZiU+0XWkS8ixQOWN3jMMM/8GCi3eooA/g05bhjZztevfe8eBiBhzlhGCxVdUsWplF4GHq1Ou8X8htGb77xoLsoDj8nyYpwykYylOckVkeXoVfGzpJno2nCtZfEdquF5671ODeWC047DiVqIsl3U8fciS3RxA8VYC83bZ+UuYrGX4BPMzyNQP+5rf0NA9I+sk1QShHKIALpilXoP25kZBtQbCXj87/A8U1VS/QLxITpuBXs4ZlVLxAcsfSOMSG36ZTvcM36qRzsSN5X83Udweqg3Iw5C+3bqhHbyyf2eLTbkN+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5U/x81CQi74EKrZ7hZIcR0p77btfsbAjnHq74yXtmc=;
 b=bfAFGF3k3dHUPyHpi5LZiagWsV7YboEFxhfaREUxCU/HACU4L9eXIlgLSrD4iF1ysv4Efw3fTszzHiq5HfZPx8MQ/Ai0lkOouBz5uNo/JkiC32RujcQm+7ueWNZdwV83uAPr1u1lSd5pTAWTz82QL9G++qNOplS5MAf+1jRMHbbOKfWeEu+cGv63Re48dGC1fAJRW6TjOyyKdS1LR2pdLVY9CUD1R7Fe8a0rAZdjAMU+yRNDGKNlYacrIJMTy5ucEWbQFbcwZJ9RKXyOvSyh99w3jQ7G9sLbl2A5zpbBL/Bcaai5To9P6BxeaMcfKQO3mu0ifUXCNK/WzK9tQsq39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5U/x81CQi74EKrZ7hZIcR0p77btfsbAjnHq74yXtmc=;
 b=O3I2YO80r4xPzqteucF5zdDi3j/uLLd0Avn9bJbmlytMrcwR5gBS2LIkAFl8cJFzJcUpnA8/TR3zdRLf2b7SdVRCn13vy8dfQpgbBMwLthjBkgVoTxGo3F7EuYzQCOCdo8rEPfIHsdOoOTLVJtoaabTcHGjfoZU6jn8JuFxOpYQ=
Received: from BY3PR10CA0021.namprd10.prod.outlook.com (2603:10b6:a03:255::26)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 21:43:58 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::47) by BY3PR10CA0021.outlook.office365.com
 (2603:10b6:a03:255::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 21:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:43:58 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:43:54 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 06/14] cxl/region: Avoid duplicate call of cxl_port_pick_region_decoder()
Date: Mon, 28 Apr 2025 23:43:09 +0200
Message-ID: <20250428214318.1682212-7-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428214318.1682212-1-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7e2380-e06b-4aa9-e953-08dd869dc818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zAk5v3s6ag/rPRt2oQ7vcFN4/X4NXJuu3mYwjJAzX/Q34+mJxvwkjvuQIKDb?=
 =?us-ascii?Q?BT4TdJU1ZwcdGo6WAtZ6PpHkQV/kfXeUd31nxsql9RCCt+tQJotWLS0Bv/zH?=
 =?us-ascii?Q?xXAB2kW7h5LSB48W+gJ38XEP1Tz0u0IcIwnMX6+f1Vv6RIN7fTL1UWF0i4Pa?=
 =?us-ascii?Q?bFWWzUKRDc5TR/lDnqZWLd+cAgRIvHLblIR2s1nayEvwK4+qBDaVXyVbdvND?=
 =?us-ascii?Q?IPvBunfJJzrc66oVNrsPmpTYgQE/dxHQ+CzGlA2c1XysuO0nFc3NyX5MXLjB?=
 =?us-ascii?Q?ZW3bMt7ddaYwSF1ltj5dYpT9GkasZlpe6ir1TVPFAAJQrRy4W/U8Bh3mvFOd?=
 =?us-ascii?Q?aav5dX9L1w8h127s+z+7oidalvcfhB3gh9amida12+OKhdgWy126l2yLrlM7?=
 =?us-ascii?Q?nBdNyrxAEcLx6CSuVaNODP3L+Gf86p18B8+w5wLWdjtVwMLc7imlEjP/wN88?=
 =?us-ascii?Q?KZnZoyueEMjO9q8QY+OOp+J1jXQMnCKjwyZN8vsFUeVJOgrDxvbnZ4Lt1zS0?=
 =?us-ascii?Q?i7j4V48ZrEW2pPH+cOfhYaWrnk3yM3QTFRD55qALg4pqJJJ6OrPuh+/phQHq?=
 =?us-ascii?Q?BYwUoaqRwZOg83cH/Pw917Rs/25+K2b7cJ3eqGwGc/rC+VI1/pX9xXaOXB8b?=
 =?us-ascii?Q?yMpS+l08mcxTdSHPkz/Jmtm2Q6dNrad3kWIULCSrioHMUwfAWa7FKfZaZ+e4?=
 =?us-ascii?Q?iwLYocE6Pk98vngJgoTXev/zsl0QaiLzuxCD5mR+7JmWp+v8RYKG3F/hWrCZ?=
 =?us-ascii?Q?jwbIO5JCyBJWhGb5cp9GUzIbweo+5uuNFtN2nY6KwO1vkeQ3zsCiC7hwiG5j?=
 =?us-ascii?Q?aSVUYCWfCqH4aeUBq6AgU7kF6QyGLA8YeThEC6JlUU2/+gXEXQeSRPFrlXWv?=
 =?us-ascii?Q?Q4oo3oVIe1BC60DqC9PuYN1Nkj0qhhstgu+MmdiSOZgaEeWfEAbvk3yik/rG?=
 =?us-ascii?Q?vbRQ3iJDwcHH/vkb8+ZLuKIjg5LS7Ga76wL+jnzcGXFOCEK1sLE6EkzZViTF?=
 =?us-ascii?Q?pcRYT43wT9cRA1boJBXpwIuNumEAvuVgkYCIrpZWmpWHWrLM5MhOQKKLz4yU?=
 =?us-ascii?Q?itdEWhVBq5vULHXuXSqP7BcrqvnG/3dgAQGgBRrbkrqnVqBAs59nZli0dDCQ?=
 =?us-ascii?Q?p8kxtCa3Ba2cYVdM2BsMIF8QKaVejXHzH8a3Wqh38nO69u+OpFRGlP6mrcUw?=
 =?us-ascii?Q?O1N3E83HoEoRWaoox2RdWUhHs5/2545Bp52uIwuC1iVDJAKQui/C9uJjcAyt?=
 =?us-ascii?Q?TjKK6MHhykm/hu2GIMdriPSl30hoS1/oHPMqnRnoKWzmMDbtns1mjfB3Tfsw?=
 =?us-ascii?Q?Fz4AbhkwJzJbFiM1WWcgN/gewsFc7UIQBCWGHDmedK9gd8H8CdNBpcmAETpU?=
 =?us-ascii?Q?oSFY9DScPcCyWtgqLtUHpoaVm+hCNikQjX13w8szDALJ4c8QNwHIQgy9pHMK?=
 =?us-ascii?Q?L8OYZyMcSxobaYB5RyKR8xCRu8BGCEwAFgApj0O7uvxkHqCYqzCWImrhsbsv?=
 =?us-ascii?Q?0mLb/hI7Q+DELLimV+OvGzCVJ3z02Ae21W3B?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:43:58.0008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7e2380-e06b-4aa9-e953-08dd869dc818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

Function cxl_port_pick_region_decoder() is called twice, in
alloc_region_ref() and cxl_rr_alloc_decoder(). Both functions are
subsequently called from cxl_port_attach_region(). Make the decoder a
function argument to both which avoids a duplicate call of
cxl_port_pick_region_decoder().

Now, cxl_rr_alloc_decoder() no longer allocates the decoder. Instead,
the previously picked decoder is assigned to the region reference.
Hence, rename the function to cxl_rr_assign_decoder().

Moving the call out of alloc_region_ref() also moves it out of the
xa_for_each() loop in there. Now, cxld is determined no longer only
for each auto-generated region, but now once for all regions
regardless of auto-generated or not. This is fine as the cxld argument
is needed for all regions in cxl_rr_assign_decoder() and an error would
be returned otherwise anyway. So it is better to determine the decoder
in front of all this and fail early if missing instead of running
through all that code with multiple calls of
cxl_port_pick_region_decoder().

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e104035e0855..fa3d50982d04 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -931,7 +931,8 @@ static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
 
 static struct cxl_region_ref *
 alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
-		 struct cxl_endpoint_decoder *cxled)
+		 struct cxl_endpoint_decoder *cxled,
+		 struct cxl_decoder *cxld)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_region_ref *cxl_rr, *iter;
@@ -945,9 +946,6 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 			continue;
 
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-			struct cxl_decoder *cxld;
-
-			cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1029,19 +1027,11 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 	return 0;
 }
 
-static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
-				struct cxl_endpoint_decoder *cxled,
-				struct cxl_region_ref *cxl_rr)
+static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
+				 struct cxl_endpoint_decoder *cxled,
+				 struct cxl_region_ref *cxl_rr,
+				 struct cxl_decoder *cxld)
 {
-	struct cxl_decoder *cxld;
-
-	cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
-	if (!cxld) {
-		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
-			dev_name(&port->dev));
-		return -EBUSY;
-	}
-
 	if (cxld->region) {
 		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
 			dev_name(&port->dev), dev_name(&cxld->dev),
@@ -1132,7 +1122,16 @@ static int cxl_port_attach_region(struct cxl_port *port,
 			nr_targets_inc = true;
 		}
 	} else {
-		cxl_rr = alloc_region_ref(port, cxlr, cxled);
+		struct cxl_decoder *cxld;
+
+		cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
+		if (!cxld) {
+			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
+				dev_name(&port->dev));
+			return -EBUSY;
+		}
+
+		cxl_rr = alloc_region_ref(port, cxlr, cxled, cxld);
 		if (IS_ERR(cxl_rr)) {
 			dev_dbg(&cxlr->dev,
 				"%s: failed to allocate region reference\n",
@@ -1141,7 +1140,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 		nr_targets_inc = true;
 
-		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
+		rc = cxl_rr_assign_decoder(port, cxlr, cxled, cxl_rr, cxld);
 		if (rc)
 			goto out_erase;
 	}
-- 
2.39.5

