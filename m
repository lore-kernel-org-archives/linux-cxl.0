Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D5531DDA0;
	Mon,  3 Nov 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195808; cv=fail; b=pOu/MlIfpkt68yr4OwkyMIsUgyVbhMFAIlV5YwNXMmnqGBSvqer8uPTitcML41jHG9HAUSDxvqxFIRneT9ck/uS40Xg/oN5VxPltZJOUvCrr0jslyt08f91TkdfyYN7DBTqPw21sYiN9G+WfwQjUiYfTWWGS7hIYIsqr1fVQ7n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195808; c=relaxed/simple;
	bh=7cA/b1aqJWCr1YiM1dCLs2Lj2/XpOA6O/Y97yf+Af/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNIz2phsvvgHGXC8O7NrYKX4wL2ywXt5c+kdOkiBoPxHHebXVmIsupJodfZ0HpgweQAHU40Sm1DaApF1V0rldDoeU+UOQzz5uuBSgwmbDh03KlxTb7W6P8koDpnUcBgRfZ8LS465gXAWph17ppQbGmcFUtPkyuV+TUjbdrUVwr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0+iYQrXT; arc=fail smtp.client-ip=52.101.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0+iYQrXT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWBeXpWbRKvVvNP43WNioO+szBYKnEK16eRUz2YhSVZRclHGyKsyGyR38Og+dPfBr34u95TG6l87Tks5RIFVfnlTDeOXE++nKn7BrPV5l1X8DRKmEER2QPw1Oo7duzKGWWQ2HPo0GHHNDuPSVw7JnFyTrKYc32UjW0m8fMR60OZr8X7S0L/SayXCYxLNrLlO27faNNMJWd/umy289fb9yfKO7xTznNcRrUhoMDBGl+fGZ+qE5K3nCJhs+QM+Yug0nn2b7IeewcROLsj4z+z+juGskBoHrkbXcFLuiq1cA2FrB6pj6378roKFYVvLoqQWsS7UztvnuroLzYcOcYkWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IanQgCfir8fuHJRIuDZvDzxeFl7UI85WxuYwmzAX1IU=;
 b=DX0MbalJMVql/JeHh+up8wUVnMYgxdiuHDC5+eAR7gFVSS2RaOVqkbo3ZFLmmak2WPzeRHwvMWEBDVLZPapMWRA13IjCG4b5F8yZf7Jf+JfmI0sxa7VUrwNlvBs35o4VsO+mhcE0aOCDsOlAXUx8TygUzRl9hvc9ii35HJIsHi3SOYCEglFZpSp2UYnwWROQv4h9DX3PEipfFpi672tGD8qCoG5iI4ri9sMGWz3LuDb1UP159bUIPWdt7rUaL8HRJf2+eYDbfajs/pKORQrYTykE4LLQkaGVp4jysCbp9rGEIHBHiQh4f/TeKiD3JA+DCyfS9WlKA6MPeWsH8xgGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IanQgCfir8fuHJRIuDZvDzxeFl7UI85WxuYwmzAX1IU=;
 b=0+iYQrXTJXhwDIyyB0AMchfc3Osa52/RPkMCMjhksDrA1b2VAoRBHzC0wVU/hHYFNlsmNDUzxLRJSAsr81GuIZrqLwXdbtPoa85myipQzTWsirMU1921udFkMM3EzskYk1njE6N6MIr8VsM0MY2rhl/YpPOt2WuqiPV05KnlS5s=
Received: from BL0PR02CA0101.namprd02.prod.outlook.com (2603:10b6:208:51::42)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:50:00 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::d5) by BL0PR02CA0101.outlook.office365.com
 (2603:10b6:208:51::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:49:59 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:49:53 -0800
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
Subject: [PATCH v4 14/14] cxl/region: Remove local variable @inc in cxl_port_setup_targets()
Date: Mon, 3 Nov 2025 19:47:55 +0100
Message-ID: <20251103184804.509762-15-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f49f10-7383-49d6-66c3-08de1b09ca6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GL0LL8YEEF0N82okCEz3Lkb1ihW3zuLH1NdjBx4IREBEJk3wSb2DapgUzlb6?=
 =?us-ascii?Q?Uxh7qD2umtz8tkFC3pBA4QrOyh60S0ZzgT8gWcOEtnGaE6ntR/gNY3ZFg27H?=
 =?us-ascii?Q?kdE/gcml5fW1JZCfyDxmP53HpKRdbSYSMR/0RRDxrCE6kSbMCXcxNgPj4kWv?=
 =?us-ascii?Q?yoF/jSPSTTXif02sD+K6ofiV96254ynel+fgroDsZrs+T9Po+9dmmjfrK9E5?=
 =?us-ascii?Q?PT/pL+/iD6cKdqghuBmVPDuYW2k19W3KJS8SD6OXkmXgOzQ0Bft0r3BC+h7L?=
 =?us-ascii?Q?7ZK1PQNvFGnfCFReTtZ961tk5iJb1NyOVMh8diD7KSAApHlp/Tm8N4326+PY?=
 =?us-ascii?Q?lV5LJ2cKJBm+MXwMdehmVMifMfYQHg3R58cPWI7jBbP9up0O/L1ZPMRP6mLB?=
 =?us-ascii?Q?cZ3jH+yxxPNELfeWIPpnHf1jMz5Vy4wtxKP5chnaoscPro4jDcAYxNDuPT8a?=
 =?us-ascii?Q?EdqBuNGXaLtou/8ma8TqvuGk1wcHO5jrAQSwvEFtn+wVRI62n0phuUmaFeG+?=
 =?us-ascii?Q?6Y0YZ34Loy7713krZSFNFIxK0vdaI6pUCgzkh6FxG7FUqd5mMpuYXTEBgzg6?=
 =?us-ascii?Q?Z15vqvfIwB4zVeCvpVpZ3cbYdwM3T9cYJmpJxg2KUENkdL4ELLFnZEk+hPa7?=
 =?us-ascii?Q?dIq047X4Lesuk6QoIPzEjKrzHOzx27CtVPJs7bF+IgkBQhnXB8wcyFwL/3uI?=
 =?us-ascii?Q?2QaCGurF0nXMRnUglqkZG13MeezPydq71PpLCI8UNZjBH9owX6Jj+qAIMmXR?=
 =?us-ascii?Q?Nam8TarzpuuDlJVJL5orBJ3HYBF6+pQfKmKjrnp7IYsrJ6ZLD183UHbxYeWg?=
 =?us-ascii?Q?XKC4VNoWW2w49hfdTLSeH72CfwUZ+aZmbAO677EmPGgoHUIiNfo74CUG6egs?=
 =?us-ascii?Q?ixjirX/3EmRrrnJwzooUej8KOeIq8PfjGb7VIHvOWmk5q5xaPSUE8BvVwC8o?=
 =?us-ascii?Q?wDzAGbsLJ168frMokp8x3EdexH+Of4idrbqk6xghRqGquF3LfKZT+3Jru0b8?=
 =?us-ascii?Q?9cqBt9x8/8ujpBT++Qx2o+RE27u0BkUKM4e3QOt0EYGliTnl43oU6MGINmBv?=
 =?us-ascii?Q?Aq+bH48N2D4AT/t8TclhcRb6PHWJtkgKxVQFUdr+EZS42Wk0jc9IHdo4BJvh?=
 =?us-ascii?Q?YanmiSDv24dbdsX5iIgQi/nZQbFbw9YfXjf/ah92ruy1b76ata4WrWKFHu8d?=
 =?us-ascii?Q?pZJSsnite+xi3VB9kKXAewW0gQIyqFFV7f7mXR3eYMwH1w9phexZ4B+/UsWc?=
 =?us-ascii?Q?C3G0img57hxToThGnllSLLUF6MvXzcpsXhgdgsAgFhpezz073xpYXQrJWLwG?=
 =?us-ascii?Q?HuczeXwBkf1QJ+eo0e9FYhvZg8ovBV5QKK3B0YMOeUwTJwTqi68DYWgW3Ug8?=
 =?us-ascii?Q?cJIAQicgkHlMEGPJd9O8qvQmiXYgfF+yoFELTYORPYqctTw1iWHMq31SN6PW?=
 =?us-ascii?Q?6rEfL53LtVyTEZ0YufDfVyr5JoJOeEbiwgVFu27GKVtzQU0kN9y9zwG9S8yM?=
 =?us-ascii?Q?9qbTSc3VtbqGxSZsM+C2Lpx3wyy4SSAxJpzDAFfK7ZSgn1yaNKnaY2RYeWyQ?=
 =?us-ascii?Q?EykosiNLO8Oq1iQBUuA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:49:59.7378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f49f10-7383-49d6-66c3-08de1b09ca6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123

Simplify the code by removing local variable @inc. The variable is not
used elsewhere, remove it and directly increment the target number.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dec003084521..a81fbe9cedae 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1332,7 +1332,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
+	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1524,9 +1524,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
 		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
 	}
-	inc = 1;
+	cxl_rr->nr_targets_set++;
 out_target_set:
-	cxl_rr->nr_targets_set += inc;
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
 		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
-- 
2.47.3

