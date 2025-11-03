Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D232038B;
	Mon,  3 Nov 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195752; cv=fail; b=ZzvlKWlUhMdiB6OnWSruGcrLgyGqxalb3FArgq1AtXlzy/oni0vljmeMZw8C1/4AePrnzOBJyOgM13w1auR9LVE6KIheQk4IaMc8FIB2lFPhQV3A7czZSbpmyo3fGqZ4+JgnPyjue7IKQtLTmOCGWlXbb6iN+avZHXojYQN6Tfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195752; c=relaxed/simple;
	bh=05v37g4gXOc3EU80zVmoge4xG0aOLxos0GdVE1h+Tls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0hb/fFpOPX1uNNA5koekMeOr61DsZJl/pDz33ULIuD06nGGaONv2SEBV/4hNqfqToGRXB1rLkHBnaJDLbKFHkBmpPlXdYUxuZCmk30bdDrRxiQRHHIklDH/C/QWLy+c4VErCFmBRYBKMYszvf/bMx1a6TaHqKxXfJBJdJn7aPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XUjnItWQ; arc=fail smtp.client-ip=52.101.46.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XUjnItWQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zN8uH8rAPySW1Da4YtZNGUnT/uvHDJ6myidVjeMDBcahc43pjOyo4wu5lbUsJGYgz//up3aPiyjxoKg4ra2D7UxgGQDwrcWNcjgfCbbtTq5YRkAHHCWkebZufeNgk82nIHJC6TKAFXJyWcPLE3RW1iHZx3jYy2kIH9dC3xxfQD25h/WYy1PQCnHSzyQUZOeq0SuNcbIZ9M9LfcHwa9FNQwYSRluGi+kErNIZHMkzZOvrSd/xsva5A9AXoFcLUVxYyQ3erPynUspSle+Cf2ECPZmr7ZsCEkAM9niCztNMjnoiHFXVge25jDaPv9D82dKpOaoElOFmXxL17GrCQwzTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9eimCGyLheHTcMecu8NVTMHqj76NALZCDpYBSG5fHE=;
 b=HdUt8mzYPw9n5WZtUasGvBc0Wl9GxEQ/i9KItAykbq72N42tDNDXy88nld0AVZX453lbZtsKz4mtuSgzjviGqIiDODxp71GgotSQHCf6sLLLPEhFStXJBrDXtweF26krPRLcFPsA5tfrL9UlfiGWbtzFMFcJvyDONdUdGXXgKnhDffFFXkTIKWc4bRS8We/TN+Uuex5Ni91AFRXNmxVdT1wXfLkFYSvsAJ6NlJ7zLxz4MBpKZf4/qYUyhkk/S87rOdPFG7xr4h5KCK4u6/WMdxQyZepPYq/9qmQT2VSC9ib3y+PJMpFPlr/1LSsh/D0zYvvRqO9dIDjmxroq0GIpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9eimCGyLheHTcMecu8NVTMHqj76NALZCDpYBSG5fHE=;
 b=XUjnItWQzSFf2frdzkqpSst/gshJQlqX8bGLG6HKqz43AJFgtz60W88pES+NOZ8gh51hYRs1P0wZFKFrrg3iyGms5eKhAkg0L2g5z5wSNws1JTQj9pUK2TIXkmBbJbWmPWzNpM5sWO5DIkH8vOAXozalSO1KSEmccFZO4yLBfnk=
Received: from BLAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:32b::9)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:48:57 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::a6) by BLAPR03CA0004.outlook.office365.com
 (2603:10b6:208:32b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:48:57 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:48:51 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 04/14] cxl/region: Add @hpa_range argument to function cxl_calc_interleave_pos()
Date: Mon, 3 Nov 2025 19:47:45 +0100
Message-ID: <20251103184804.509762-5-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103184804.509762-1-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a017247-bba5-4fb5-587d-08de1b09a538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lbcpAzIRRpgCHAIhBg6OFp68Nirkq/LkwVpfBf5d330CVNvbNykC3Nw1NNd7?=
 =?us-ascii?Q?n1fe+86dd/8pBNvjsaF6QIlocGWUN2sDUs43sde/N1DnBfzMXSVQzsdfZ12j?=
 =?us-ascii?Q?ClBw/oBhQv32H//nT5kXb9oUPWX1y8b2F7E//Lz5qVkjsA+WvThTpZRKLQ1+?=
 =?us-ascii?Q?KxbRuCnOgxrCu3PR4f6EEnfqUZ0h8aU3yq5gK80fS9rNipap653pbUBZzgyn?=
 =?us-ascii?Q?PwZGXdh12fzNRqeKX6rYu4cyJJYWrIm75uUmYxwFzk3gOQslM1nKOZgbGmUc?=
 =?us-ascii?Q?3gHesnLoEal0jmOjT857SrPHXXnddtsNbVFzalYrYTpl6Zj+X1FxC+ON1ASa?=
 =?us-ascii?Q?OLBkfTANi+NEXwQ5LHa16Gaj5erpigGXEZ6pu/3RJa54VYoG9vHpSF+3Go23?=
 =?us-ascii?Q?tnPmDX7fo6r7qUpqOi91ej3VndcvUbGqMJdmLb9Qx5zKLS4YQAs+lKEpEGhZ?=
 =?us-ascii?Q?EiTs2prjEYvMaYd0lhz3minbbrabqgPkWG7A2qRuRbVZT4cRnjZ1kCrQEZF1?=
 =?us-ascii?Q?G+xLzngP6PTLi8cako2+FsDttjYAEvzOMzGCa8RDNkr97Ns+QjsmD8BS67kE?=
 =?us-ascii?Q?KFIpOm/olwNZKb5VZEOVzETmuI6KoALvG1g47om6kHA8Ot9sc/L7w68Kvj+3?=
 =?us-ascii?Q?dF9qhJ0vb2pLgcKF19/rbccwCbM3+GeI/spOH5IFAz/5AMgjdnn9vo1e1oII?=
 =?us-ascii?Q?Orqn4qJSOsbg18VIR8DtOmZ7IMQ9plE1nZEgV3eCpu0kNOoINdrtpubTvs9f?=
 =?us-ascii?Q?aw/BfGxBf51s6Jc1upbMeiNEW5IWKEVmF1ZOMQ2Zi36Tl3GEk0uPEsqnOaQa?=
 =?us-ascii?Q?CacU/ukxr2QvTW4Q5BKvtp6PlVO284KPQfKYi1whCeFI7BaxMDesNTLYnE0V?=
 =?us-ascii?Q?HS4mF8oc4FlbggT2fEcR4oLBnBa4ACliiGMyN2zMf6xUw0Q9HBSTN3RWFUOX?=
 =?us-ascii?Q?bIux9cDZIME1sAin9bD2iiSGF1kWoHGEzJMCUcBSLLIbhOlSNQku664jWzut?=
 =?us-ascii?Q?WSchzWz486qlSoVqo5sV3jmuLXrS9FMDj1ePwl6KLxFUJDf2hhgxREEc900X?=
 =?us-ascii?Q?HAuKY+65S12cAbq4zHEqTPdY+oIo5XnNQNsfhibVnugYNWKlFJ8/F92WxEIZ?=
 =?us-ascii?Q?jeveJ7DRg5EPFMgcwYpbr5na5j0D8KWcOj/rjpzOHcWF4iZRWxM0ylzez/10?=
 =?us-ascii?Q?wrjZwrJrXOgG7sCZUwsGqoumuiIpCxKiagaBmYVBcJe6KL+LfsE4PV84VG+3?=
 =?us-ascii?Q?b6kvnk47VL71COKuN1AvSvxCIAlS9K97eBeKDCkjDV44+kEalX5OHbFaBoJg?=
 =?us-ascii?Q?rpOEJUlJOgUiwvtGD3XiwVXfaqV2syhXpRxwpDfgMcwGXtN0tljTiiY8dkvj?=
 =?us-ascii?Q?/gYUIxUcRs5Jq5C/8CszX7Gt8mB0683HNZmk58emSNeSGMxkC+H4JmGhkSIX?=
 =?us-ascii?Q?lH5AEvySVSSSz1cC1cUznufWG9kFAxB2MDWsBzyld34vXFV/YlFiedacMa6K?=
 =?us-ascii?Q?DxBj+YIIueoDkb1FqN4A65x8aRpcsNiO07EUscgaxvmlXBHlrJaGZvhNLmuG?=
 =?us-ascii?Q?kFL07xlgJJ7w7MMhg1U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:48:57.3338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a017247-bba5-4fb5-587d-08de1b09a538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
determine its interleaving position. This requires the endpoint
decoders to be an SPA, which is not the case for systems that need
address translation.

Add a separate @hpa_range argument to function
cxl_calc_interleave_pos() to specify the address range. Now it is
possible to pass the SPA translated address range of an endpoint
decoder to function cxl_calc_interleave_pos().

Refactor only, no functional changes.

Patch is a prerequisite to implement address translation.

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bb889c891cf7..d3557d9d5b0f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1845,11 +1845,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
+				   struct range *hpa_range)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *range = &cxled->cxld.hpa_range;
 	int parent_ways = 0, parent_pos = 0, pos = 0;
 	int rc;
 
@@ -1887,7 +1887,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
+				       &parent_ways);
 		if (rc)
 			return rc;
 
@@ -1897,7 +1898,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
-		dev_name(&port->dev), range->start, range->end, pos);
+		dev_name(&port->dev), hpa_range->start, hpa_range->end, pos);
 
 	return pos;
 }
@@ -1910,7 +1911,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -2094,7 +2095,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled);
+		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",
-- 
2.47.3

