Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD9214A61;
	Mon, 28 Apr 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876670; cv=fail; b=IDDA2QGVIDvwP1iQNbu8F62ImyJjdphtghTmbmu6ZsuAYxFPFcwyF7Zn8ZTdXps42shvLFdCViaGc/IB94HQtYabbCN1Fd/04fAob6bxujCf/ChyGpKN7ZGuohAcjdd4ED3QsdJkv3Qpa8eQhbbswyy7j6w5OdeEl8bp4Vt9G1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876670; c=relaxed/simple;
	bh=o2FYbs8K0XCEy1QTlBwcfYPirS0qM0ezh2DC35W1Bc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbwSMBO1qytwcyTq5PMJlWnWeiOyCo1FSZ+cqT1Xg4sfrgOvRadt1bMUz2QiWes6fEiuRev43OzbO/PXo+gWwe8sGGlvGLEGIWvPrvuSKgA7yKxX0lnEIjgwGJR0VtHYIyPDOE2j+yBTdp65HOyksyzr8ukp/pgzAYCN9MAsghg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BYJs7Big; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BYJs7Big"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE6v8l4y1jCfZ2+B1joaicNwr2spafCbsJnfVSoLC2uF8EMJWg0wPbKW0p4ruxUepQRdvBENFiZS5fOQAjYAw1t50/nuAGwpvatYVqAVEAjVhTGE5poUa73M6qui0UfK0kbPbHevScWxhSZGTDCCchgWmf7CltomK9QDj2dbNtJZh4Zavs/ZtKjMssESLwQiFsjsPG0aOdjUKj8r5QR9aMhaifHOqXytTEKT6joxW3lNMzGGILbgJLPlUD/k4GiToeF8DEtC9ODQZk0kjKTSy42s0dz5vwpIWVd8mTC8iqtE60KFg4r02BKYp2Svm4idZ8krmCTOgA8YhU47Z+w9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=US+TsgI/VGh0C3HSQl6f1nHZjbMhBcFdpqZWmRQdNi0=;
 b=tp7k0NQaaMn54fDFjMdJ4TNORif4Ci4bevSD6AVT3ctA6OKSJ0WyM+QznCaGXHEVshJ+elyeyDOHm5cFJ8munAdRnxhpR8e1R6dRHkMkOTuM3RmemkO2XUWbFA6d7gEcZrjqwiwMHKfQkAtlSa6HyXrCuOeilCq8Es8s8IhOHdD8QnOIAXS32W0qYchsi/1Zudp+NP3bp6FL03XzSIYN8DDS5f62hkNavgWTTdGIeYHpdZv2QWCDvfRAeFvPoH6+mX09auX9BeDoiUoU8qTv/KbYQXp2RILMlDjyvf+09+9bNH+HVQKWC/FUkx1LqNMM91OdlqBIDm8zsdgNHK5PXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=US+TsgI/VGh0C3HSQl6f1nHZjbMhBcFdpqZWmRQdNi0=;
 b=BYJs7BigybUjlNJgUupaBOmli8M6+ooZkGmKeFqgBfYlK/cuV7p0UKA4yw+sH3Fj8V3s7vYqtJ0z5QHOonPwZ6KkbV5NYtrZ1rNNInUbsdNKoCU7dy4w7hnXHxvjptiXEm9wpxLoB+LG9TXb2KwmP62UclZGvOJDUkQMGCwmXGY=
Received: from MW4P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::22)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:44:25 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::eb) by MW4P220CA0017.outlook.office365.com
 (2603:10b6:303:115::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:44:24 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:44:19 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 11/14] cxl/region: Add function to find a port's switch decoder by range
Date: Mon, 28 Apr 2025 23:43:14 +0200
Message-ID: <20250428214318.1682212-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bc4dca-fa9c-452c-38a4-08dd869dd80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jw3fCDSi9+93yZuG4fdoVo0I5Bk2TwXEKlAIz1RSanEPo15eTK1lTBTSY7DO?=
 =?us-ascii?Q?sBqAxaePlKKFL1gqdfK8v+mU8MwavXF0VMAnu/cr3L1AujwU1sgiwSf/c+P+?=
 =?us-ascii?Q?JUDkHx68b/zsRyEd2cDO+bcgINRx77nE1lefxV6O6MmrZb7q/dmldUVEcYT0?=
 =?us-ascii?Q?Rpl2ja4YAzb5R4oqClcGCVjyk/immyFABN8xq0DESk7LLn2yd5rxsBwDrliT?=
 =?us-ascii?Q?jmtoho4LUnSJ2jzGlDCpU+oRO2iJc3SZVPShYBdKoqCOOZn8RiAVKFKbicUj?=
 =?us-ascii?Q?Ot3LUbZPhq3ry4cYc2WLkKNy4S4YJZUL7AWWyK5CH1Maskj30iO401FEOysO?=
 =?us-ascii?Q?/S5nvm0Clop0a47Z+s6XRAqLv33aTJ/4t7X2zjMJsqOt0dPQy3E19mv6Xnt1?=
 =?us-ascii?Q?MDDAgTDljDYpW5CJtlkH+XMDtvtXYO6R4w4MuRWvckpFoANFAOQq+o8UTG0h?=
 =?us-ascii?Q?+NTbiVfYbEu9wNObEQVwugOYAzl8NpJGfonN5GOctW9M9QIfSfYJfoL38iWx?=
 =?us-ascii?Q?mKFANBJKqsz0ipd3IORotxwPXdGZU3khZ9Jdm1E7oBc5pehP0XszOP7DzHqq?=
 =?us-ascii?Q?CTuZXLlO8rguj17AYI1RlT9w1ATvjkENdFKhXwpSq9+T7YmCf34NBPntiySb?=
 =?us-ascii?Q?CxmtZcZ6wwC1pAhFtCPhzkHxMHypfXuXX00xWBKEvdUQamdtgVH0AoFGKJXh?=
 =?us-ascii?Q?iiZR3OdwgawMvtCqWhuMdnjckXnXsxGfk0T6YOWz240d20g9Om6gGNrIXheB?=
 =?us-ascii?Q?Zl2g/CSJAzeeDjvsV9WZ2BJylECFumQOKKYqEEax8wmslygbyBBdDRzdnIau?=
 =?us-ascii?Q?2m8sGzdtG2455Je/CcFKIXni3qTel87tTdB7iTydEmTTx7qvEcBjmt2nP8ME?=
 =?us-ascii?Q?aELVpCpQDV/+UycrmwM5vLA1dTLucb9NsNSointAT1W7fEb7RcQf8qzCy8qH?=
 =?us-ascii?Q?lA13wg2bOD76/7gXhF5yZGVo/2HJdOJ4DD59yzspBVP/wi2kZC+glQRSTiOe?=
 =?us-ascii?Q?Wc2FrL6bSMnwFIyWdt8BoemAHk4Umvrg0sbLAaSEkYcUSyf0Rucw/tM1RFNi?=
 =?us-ascii?Q?zShxfCXp9RRK5a3RsxmxMyQb99rq5zkNVgJuKGB3wHJTCfjIYqVzZK3FfnMb?=
 =?us-ascii?Q?J/VW9g6D3JkbHBJGw3Qm9s8CrgbDWc2eWmbPxs8WXzxFVEhD/tjvD8NEMUDj?=
 =?us-ascii?Q?d4ywt+VUCKRU3Ros4Uyj1bfUeXu8mVWJgDRUFVVziToeYbOY7We6lv5dDrpJ?=
 =?us-ascii?Q?0PQxrU605Y7MfIQ6KOAY9VXnKz06OhHd/Wri/ZgyfTzof1lNaJ4BOSnLxwjj?=
 =?us-ascii?Q?ftK7c7wz64GymC8/+sxFYZCWlISjiEtLHhoKIDwI7Co5y1POFxVUMmUbzZLZ?=
 =?us-ascii?Q?ZNz+gnx41rrzYLEjxsBSeBDjQK4ecUhi23/8b9k9UIH3GJldyQjl+vZ0l962?=
 =?us-ascii?Q?BvELjDRIWyTdykVUFhbRMZZuvc+mKVNjHdmrZEuRPtjfey0DeJMr/xiMTgGR?=
 =?us-ascii?Q?O2yANyQHJXfMNpmiTNNVME06VrWcGuSFl9sj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:44:24.7612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bc4dca-fa9c-452c-38a4-08dd869dd80c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759

Factor out code to find the switch decoder of a port for a specific
address range. Reuse the code to search a root decoder, create the
function cxl_port_find_switch_decoder() and rework
match_root_decoder_by_range() to be usable for switch decoders too.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a292d5c4c4a9..ef5408301714 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3205,33 +3205,39 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_root_decoder_by_range(struct device *dev,
-				       const void *data)
+static int match_decoder_by_range(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-	struct cxl_root_decoder *cxlrd;
+	struct cxl_decoder *cxld;
 
-	if (!is_root_decoder(dev))
+	if (!is_switch_decoder(dev))
 		return 0;
 
-	cxlrd = to_cxl_root_decoder(dev);
-	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	cxld = to_cxl_decoder(dev);
+	r1 = &cxld->hpa_range;
 	return range_contains(r1, r2);
 }
 
+static struct cxl_decoder *
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+{
+	struct device *cxld_dev = device_find_child(&port->dev, hpa,
+						    match_decoder_by_range);
+
+	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
+}
+
 static struct cxl_root_decoder *
 cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_decoder *root, *cxld = &cxled->cxld;
 	struct range *hpa = &cxld->hpa_range;
-	struct device *cxlrd_dev;
 
-	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
+	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
+	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
@@ -3239,7 +3245,7 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 		return NULL;
 	}
 
-	return to_cxl_root_decoder(cxlrd_dev);
+	return to_cxl_root_decoder(&root->dev);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
-- 
2.39.5

