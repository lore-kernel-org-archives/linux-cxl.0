Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C751EE7A8;
	Tue,  7 Jan 2025 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259131; cv=fail; b=hJRaGbiaya3sO4/oypDT++zw7c3t7nyEdqOoPEAdsYLxGcsIstR2AR7svRbeRWqfg3KApSXjc9nactjTt5rtKXMs7QQ0dQ04KZ5YK6Ka91VsBXsaIOak4IjfHSdwZ24+bBi533ilhpNJZXhrH0Bq14L+AiGygmjAOnjYbwl/+zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259131; c=relaxed/simple;
	bh=X+DieYdriYVGSYpsKWhikTVsPwBNyj7C7guC8LSgnLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTYX9/FyPaUHJzCbYIiMvZ4E5hAxcFsvmQ5yKe7VJLJNrFJ1T3XII0akykDVsSHA1Aiz6f+218Nk1+6ZTwq2KeZuUv9ckE4IcDfhDNp/C2cYCftvjr/GVZg1Nd+hjsumfy89DiW2cTZFtOg77IWuvvdXOrorunNbHuEShgeui4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Raudx93O; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Raudx93O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3YCjQUvcfMdDNJQCSFKgOL1fEipapzexYaODlnviVkPiORiYOHJvMcpft3pAuJjqJT205WL/o9SVZyTrXDVnveFpatVp20HO3aifGtPkzmkvop/h+bIuvdOC8G+WjaZxlH0frgz90rmxYovaFsc4VKHwFhc4pwJB1P8L3YM0YILLNWPa3CF6N32eQfF5WBHlkhJ0Fmqmg6dma+ZolRocMMF0piPfH6NLA5j1gVNi8VNhAuhpBfNsyaP1nmXlfMbSvuICp8+1Ch8VF79OWzmsLe5PBmD1FOg+25C1kdiKSUPX1ntc79U1I6tgAQu4Lm/R3nEIQAcaC074HFF8RUuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl8pz2MxoWjv/4KsxoK38+ZmjZeiEwV9FnJofb5gRzE=;
 b=puU/qoZObW/UYluxHnsf/cFjDjVTSf2QwHmWOgW5j5TURKZAfvoV4LjCBxDeD6yteUNJ4RQHpZiVWuCOvy8jI6IhIACy4IyQcO9QXtjG9lp0i9v/My7X4FoZyD42xjxWcaQmcBTZoUrwH+mylYVT4WZB8dgphf926pWz49GueUvPQxAGK5rxuQjLWL9ieNtEb9g4Fo95C1NUsFjG2YtZTb0FouSIKAC6NkIX8EU73NqowkLP2gU0Et0YiDi6JuChwCcz6gvl/wWtsB/wcinDzYtCn682r1VZLhTy0RzxkkqyDu5EhvPT/t4ObpGhtE4vdPjFQMzGuW/m+15TLzaRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl8pz2MxoWjv/4KsxoK38+ZmjZeiEwV9FnJofb5gRzE=;
 b=Raudx93OfC6UFTQ0hEFV3syY+e/ff254YLdXRBEu3X+v0VALbnMJQUpQc+YV8z+gwDZQugRIptfTNlDqMWqTpfH3YO3gSXltNsR/qBCPbT7ozarl53FunlU4TvbHluGt1C2uZUIn0crFbwEShdZyfIxspCUeCj4nH8tjPkojVIk=
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 14:12:01 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::d6) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 14:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:12:01 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:57 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 22/29] cxl/region: Use translated HPA ranges to create a region
Date: Tue, 7 Jan 2025 15:10:08 +0100
Message-ID: <20250107141015.3367194-23-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 4568c495-b854-44ac-ab47-08dd2f254150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFLD1JheIBC9q4n9XLbZU51QsnSOeLNTCQSbcSqNEhYiwMNHD+RCXvE4XCAF?=
 =?us-ascii?Q?Lki3CyQdq1ufIZ2HztbrXUEs1cjRNgDI9ATzkvOw5kVblSn40mIcNvROCCG4?=
 =?us-ascii?Q?J88R5CON4WZH/BvV7T+jHTDZVrzXYn0pXMzBVd0yKp9gWNuoRRo7C+x1z5Kv?=
 =?us-ascii?Q?pjICazzst3Ncx57KeeYeidPY6NuKgRtL+oz+Ggfmc/IyNW0X8wRbIJqY5Gx5?=
 =?us-ascii?Q?NfKdSowttQwYZTP+S7A9CLgyPhz0B0o9ZUeJu+dlSvv3Z3hYRVesvfs3QLrJ?=
 =?us-ascii?Q?vzDLyhTegpjYawIyZbaYjKOo5+57KinG/vwTKcSGEIAqpPM8y+ilaZ4kcjwh?=
 =?us-ascii?Q?y5hTDkpSDOI31JrV7cVL/+h6lFqoUCOas4S31oaooyJmM6/SUSIbj0HqMHY1?=
 =?us-ascii?Q?vZoLIJrb7IkluZtljIURTzql/QMTPrOAUp0t+3zSahotxkl8wAYRl7DWzFfv?=
 =?us-ascii?Q?sqT88yk7rqOWkSKq2qbMMtmX94yqB1zRDvTViF4/oBQNtTbi/32+Jx32x31y?=
 =?us-ascii?Q?/xK4/xEzfgK5pJFH8tz6+AdeqWcnkcpje7Duyybpb8wCkN+vwwPcepliOvN1?=
 =?us-ascii?Q?oKskb3MiwpYnFC2KC6imsTQKcsqiwHOQ5SARm/BPH8ArEMXdQg535+rRGK+F?=
 =?us-ascii?Q?a9Kp2jQ7aKsqTwkWR/AgJSeBoyZ8MgrfnPM8iw7pX6YZuf93LDXV9qai8WLW?=
 =?us-ascii?Q?/aYBT4ogs4OJtACI/KaE4aNUjbUvPVZS4jygFR+X8MbSdqzLNNh+7twNDmpq?=
 =?us-ascii?Q?uDU69FUBlimziKxrXn5uePTgCP7JE9PGRQCPLKJdF5I3AArfpn6lLnWnIzr+?=
 =?us-ascii?Q?17/HF1Db8aaqKWVzld5dA4VNG4f06NdBc7BIA/BQKwFSU2m530UzkJ4NvHyt?=
 =?us-ascii?Q?tpQLJSPIppyJBajbGqupsKT5VzDfv5OjxYChQOt7vxqKKBdtCgdeMqAP5vPq?=
 =?us-ascii?Q?lcyMsMFbNDfi/ShpXggBiIRVbZxhyjGZoTDd1erZEYv/TBycw1NlFtXKb5C5?=
 =?us-ascii?Q?sKt7uJ/2UyArmWmWAWd3rfGbTOq3luB7IL3v3u9zrOU4fD6RCpHjhk0Va/Wa?=
 =?us-ascii?Q?ouhPzAiCGs76cnu8tNdSG/sqRzr3SDaEgt9CXfiFHuMpBzkmAmGc77iLrwLx?=
 =?us-ascii?Q?WO+cIOdTvfimyFxl+P/+cF9KAlRBbUuKl9/Dv2cCmGHY7PMyGyb27AbW1t5F?=
 =?us-ascii?Q?aaD+pSEySZRIKH4vprP8U1PV283GmSm4LtEaf5GHfn8+wDHoTyOkcCiWmYUe?=
 =?us-ascii?Q?LhW9vwYXAl800aYt1ymeTb61xsMWBS52nY7aiqh4g86yAfWPkIPkog0LOtSs?=
 =?us-ascii?Q?53UWjaN6pC5XN1hk0l+z/IdzW2mp1/tSUJZKLeupn6uV9X7h+Uy6jcjfCJix?=
 =?us-ascii?Q?+A1Ch58iLydvLKCr+p2ab5wG0jtL7C6gURqu+EZkWgxOJXJvK//Y1g+qlw1U?=
 =?us-ascii?Q?iStRgYD6py3k5pfA7DZbTFTRKGyYasFDj7ZFYW6j0/HaYi6XfRmMjpODT/ea?=
 =?us-ascii?Q?0A4yRKMjJbOZ8DI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:12:01.1017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4568c495-b854-44ac-ab47-08dd2f254150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

To create a region, SPA ranges must be used. With address translation
the endpoint's HPA range is not the same as the SPA range. Use the
previously calculated SPA range instead.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 681c26abc26e..e218f0be2409 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3424,7 +3424,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *spa = &cxled->spa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	struct resource *res;
@@ -3462,7 +3462,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		goto err;
 	}
 
-	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+	*res = DEFINE_RES_MEM_NAMED(spa->start, range_len(spa),
 				    dev_name(&cxlr->dev));
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
-- 
2.39.5

