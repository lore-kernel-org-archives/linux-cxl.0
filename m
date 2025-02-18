Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419412698B4;
	Tue, 18 Feb 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885106; cv=fail; b=PRXwtsVDytWFmKlwHIcLbhjMyB7Tc1GmfzaRQBEI4n5Mh2YUXvvcsUyktu/le6gGH9nvAsT0Kgof1ZSm7e/+U8Vug1EQGw/MMuwiZ3vrW0Wh5Adrtv0OpkrZbwyXhUnZCOXu3OJ5UE6Bs1yw1adyNYpBJAAQPJgEkGDLsMyxm3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885106; c=relaxed/simple;
	bh=DmOj6bxlOcnAgJyPe23G9p8H8DcgfEo0wLGmudgRwg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdeJNB7aLmna/Hybta3FO9NFm/n16HOn5K5tzJerhU7i6njKLbdu5M2t+UWyy3AJ631KCpVe6XMq6Zr8RyaE+YkepR1oiVuxA6J28aPF5IEZT00qQaNIVrVoHyeYErorGdhMuPWjzkUmeBOuVCSpEEUEpFUNLazadJduHQ72tm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RNfhlZIv; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RNfhlZIv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA7UK81IBQqX9nsTUgOTy+X/zjfq/cu4hELavPZTkua8Z2cJY2BY1h6TuEriRvrEajSDxvNR5XOsSyFP4JEDDNLCf9Ksnjf6ycm2QeXlUFCGDOpf25BrVlJ0cqnCDNNmDkeFAaeo8+4iLOPUvgoopCxsan9q9s9+MIP2DGlWKd2Dc2U1UjCorlFAMxhn1dahXw1Lc3JM7lWnwe4FMBIqmVHz3lGwG3nbtNfoMRkRIQqXjyQ9FeGaT7wIFAwC9aEMtiG9hDWhbOYne85VCbHiZEa7mp47nzWGeUhPfYfsQgDWREBmVMvbI0cqUiQqZ4wVHPkDOnOh5EkeKM1Pg5XLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lZFSF8Zn30b+OGJskdoEtUM61yr0geVRzvVXtg2vSw=;
 b=tSX+G/Hp7EBnMiQ77pEwLfRv0fGybgri1CDzof1xkY2VnxYXZDXjLEcJoh2ZC55I8+fgG70uGkGAlqUBNrD4vWcjvx6fYKzXq42ft5VbrYlxZ3gtVLaGotPVOuUOz3DVP85bz7ZvZuNZa5QzrLwpnaMm4/M7iNSa9DqmHwwVwq5TUKhUqgZYBsaaf/bPTDpq5eTL1b6JB5hhLOART7CtDXKHbXZacuCMFjJv2POGvmJLaWPlYLzrO6HYgw6Elut8y5qPFzn0JKQfQDOc4xVe+qkjcbewH+S8oxp8n4B0SCx1fPObZTH58uJ9acttZmaYeVaXCFJxIbF7O2WRi2izcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lZFSF8Zn30b+OGJskdoEtUM61yr0geVRzvVXtg2vSw=;
 b=RNfhlZIvc1OkVIW9qmvxyyfbW6NJ/YPmbHrSmo2vdU3Ube/ylTnW+yJY0kxP17DIFTIsqZcARMbG0dwnD+xY38fShTbkZ6wU+Vq3ge2sFNwx0xLW73M88Jlda/B9IystHgflc9etdLl739QF5pAqeEo2Yab3i3hAZkLUVuZGl8s=
Received: from BL1P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::15)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 13:25:01 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::e5) by BL1P221CA0004.outlook.office365.com
 (2603:10b6:208:2c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 13:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:25:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:24:57 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 08/15] cxl/region: Use the endpoint's SPA range to find a region
Date: Tue, 18 Feb 2025 14:23:49 +0100
Message-ID: <20250218132356.1809075-9-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b485be-534b-4767-a577-08dd501fa589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NpHHNeKB/9Pu8b/i6Hhoza4qgOgbhi4Uh72EaLviS5QXbYaKI1omNKRLCU+d?=
 =?us-ascii?Q?PgemA+sk+ayjovQXoor4uuHATh56w44dRLELCWhXSSgdV+JlURPvuRboiNp6?=
 =?us-ascii?Q?dVHhRSrTVdqj07xLtUsCO9cHcbsr9yJ3KqWxYkO1FketkkBqkfNAUHvCaB2g?=
 =?us-ascii?Q?aI3zy2gOqpIw8f2kyTaD4KHgJHxgA8m5mgLPuQ/kqwKmHQimsQCozSk0ho3T?=
 =?us-ascii?Q?lKakLtPXLODfqh8EsxqvX7tb0dr96QkkIrz08IA50x5qmwqHfUn8H2zXr9J8?=
 =?us-ascii?Q?DZsVsMoQsbYnWG9OWIRJplfNEqE3zB5VDjOSUd3njIQTLnZFJGB5BMEF6QGX?=
 =?us-ascii?Q?SPgwHXGui+pdsKaxBYUJhzhSzP3DH5ExG9xE1JG4Scuwm7Y8a2T8X0XMPTrW?=
 =?us-ascii?Q?qZMX16HM1R71Gf7kkv57Dw90pGQsLU/4p51OiNuf0zXOK77r4+5Nfk+WcYgF?=
 =?us-ascii?Q?tBqrJ96nMdoM/262pVNXpYkW2i5OdzpmI3faCVPImwCXmTvveH7WdOPiUbbK?=
 =?us-ascii?Q?iD/yHijEgObj/RAgIgko3HMc+3S2VfehecmJaEWaXGmNFAUBsksCQXedta8x?=
 =?us-ascii?Q?z/JJxgnNw+mWg2O7MGy33lP7padpGpYyudOHoixwY9PyFGKZQSsDgbUlS8TA?=
 =?us-ascii?Q?PRpzFj/JbT3H2HXWd9mJ3G5rURxlksWbStOMXvRpLcsEAcwTnn2LjyZHkrI9?=
 =?us-ascii?Q?WoIfMbTmkjxlvNALyzyT9V9MeVs1n9QZ0bTLf5uMQK9GdzIJ8IeOr8cS883p?=
 =?us-ascii?Q?raXKl6o3kdXvk4p1auS0vACs+rO/nn3lVtEVhywgM93kFVhuiQf6yjWICAIl?=
 =?us-ascii?Q?4G5FJ9x8DRYNC5gcyEiCTawSNdS6X9P/MJ2J7/jieOFk/YTBhegkGaR4Qoip?=
 =?us-ascii?Q?c5U74l1OyIGmZGDE863VH+71gXoGuOjsLufyIKKfcK13kTyBI3kSbIonZNGd?=
 =?us-ascii?Q?gntKlpubuLsmFhD5yN73CdMJx5ZPOvP+3QkAMbJ3SecJylzrOPyAOS3OnhTF?=
 =?us-ascii?Q?GOc/SVjQV/iiDQ01DvZnKPZSuCtuFfApIxGZ9CSacMjacc1ZAP+2bxakGFxk?=
 =?us-ascii?Q?50rVzCKFmKWX6uuuaY9j7KK1BcCc22sVI+XDjkAAYnuuLFjjBiAhdrsIvVPK?=
 =?us-ascii?Q?AEYELPJmxrIW1BWPyzMXkUhbXG1dQyJc1Cys8GmpI3ZXPYfbC/lcnRvq5oNS?=
 =?us-ascii?Q?tEPKr77oQlYILRwB3kz5+ym5JFV7pBltsTD6CX7zXfoqz/4uS9SJKCbefnJK?=
 =?us-ascii?Q?529dFgCzNg2BQWvXBzCQfMOaCK4Mnq3rvEXbYIpunahk3wUlFg3P0qLZKOkJ?=
 =?us-ascii?Q?ELR9ajFjvrf5HaiVA7s1ipcUA9TqUm7QHBePd7fFohnYniVX3jjEtnV5B2m5?=
 =?us-ascii?Q?h5sY/5T+d7//8E4jNuHgXaZKSxvq1nRE28wbHbxqA5gGL3+Q4KVf7IWXVS/7?=
 =?us-ascii?Q?zXQOEWPherB6JVcioB+893VAPJUNEFQJZcVIx7V3ErbsmzlYPjprPJpbbTKF?=
 =?us-ascii?Q?rldDD8fAOfX8q+s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:25:00.7479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b485be-534b-4767-a577-08dd501fa589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325

To find the correct region and root port of an endpoint of a system
needing address translation, the endpoint's HPA range must be
translated to each of the parent port address ranges up to the root
decoder.

Use the calculated SPA range of an endpoint to find the endpoint's
region.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6d5ede5b4c43..ffe6038249ed 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3535,7 +3535,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_root_decoder *cxlrd = cxled->cxlrd;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
@@ -3547,7 +3546,7 @@ static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
 	 * one does the construction and the others add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
-	cxlr = cxl_find_region_by_range(cxlrd, hpa);
+	cxlr = cxl_find_region_by_range(cxlrd, &cxled->spa_range);
 	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
 	mutex_unlock(&cxlrd->range_lock);
-- 
2.39.5

