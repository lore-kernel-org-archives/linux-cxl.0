Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED231283E;
	Fri, 12 Sep 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688358; cv=fail; b=FyDLdgXHLWJAyVxT9LImUzqZws/KQsI+ZCwICUX78gW9ZJBX9e9iBIhuwF+lm/ZAk4DvUSpPZvs/HVWuz7mNzRrr+e9vZhy2iHATKpfWFpsLPK2zZjq/5z/qc50Rcx0RsoKfgxXW6p6yfWnXYIUVrgeIhon5E4OaFk7hSk6n0PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688358; c=relaxed/simple;
	bh=wBxkrSZ0j5cdV9Du4Qjh5X2gYuECDZ5lF+jxTcKVKE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKj8EggTs3+KZLbpftto1f1/ePVMPspCw/+jvCVr1M7egN9X46DO5EE49WkN0VFCS2b+gXugYvwSL9tYrBBtLv6G6Z1c8tB7FIafhcUhEvb2LeOzvCXBaPufnFadRhoEwgdUDDZOIP+iBFDRS+YylaUKIibYdXcDoMCUxXlD9+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PEcCDySU; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEcCDySU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olM3z7VnZAxUa6TTLgQJ7wmjr/1QUTU/y46f1cpCDs10o4yGI6GnRSdYeGg2+kibe3B3Fl5pXb/bJZYq8o57b5ac0g+KI0Dz/lVNBE2OrrWgV6e0C2VTpI1JdnE+H2fqrV+rIQGUTU6PFeT36g/c2OQQGd977CGtOUZKzxKX2WGBQmOxlfTiOROocIHD3GU6s6EpHDD3CwXJ5iqpPwp3+h3YCnWwpP4nrNfH8MtfeTvDXfhYGvis3eQJvd78JKPNhOdygc0W+Az/uZD6FGwR/JvTiXrGaS36eNlol3GQS5Vf7JU9QgudsNfEaxytqjppblmrhJLlglEDsZi/h+zXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZbhJ0ekFNIEmNdEeorAezYIerGe8lNwsbtkgJo4A2w=;
 b=EwXwaBlcwjE6mZnJ6Ibg02dhXcpkTDk9ne48Lk+a0m0lNJWTIcOozDZJKOrbzUJIdPsRKiSucLavaNO+wQA3XgSAOv9aoONth34RRB4SpvQ2ABgosoK4ay6FTtTWyK5rWdNksh3wuAOt0neSS34R2nshPc10KrimcVGOQLJar4P0ODCoj0HW1JlkIyLzvTG7Cdybj9hIFzabIy1eKf4SLXT7PE83kqaXKVEA+dCp7mEww77U8K5PCE5cVeVT91OAS2pG0XEiWGeOy7DdRsgfrH0nV/XtBIFw9zTF47qLE+kf0OQXUVdSm1zEgIggGvxlxFk4LwdngknYbkkGW7Wy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZbhJ0ekFNIEmNdEeorAezYIerGe8lNwsbtkgJo4A2w=;
 b=PEcCDySUZJxGW3gaM9sqM9X0i2Gmq3SFu1gZFjuhGoatiLXh+sghuyM+T9NnySLrZoX9lwfOR4VAlMoXxRZtGFR9xokieI2+8/8DD3PCRnZhHTTNaY5V0hLPWid8jJnH4yXFw2Jo5UJo9p9PuLzgflmnMeDkAzoBKc7dgPzYPA0=
Received: from SN4PR0501CA0103.namprd05.prod.outlook.com
 (2603:10b6:803:42::20) by DM4PR12MB8450.namprd12.prod.outlook.com
 (2603:10b6:8:188::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 14:45:50 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::3f) by SN4PR0501CA0103.outlook.office365.com
 (2603:10b6:803:42::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Fri,
 12 Sep 2025 14:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:45:50 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:45:47 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 04/11] cxl/region: Add @range argument to function cxl_find_root_decoder()
Date: Fri, 12 Sep 2025 16:45:06 +0200
Message-ID: <20250912144514.526441-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e732600-0222-41b2-cfe8-08ddf20b1125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?elZJ81x+Nvar/HcSmZBAso5+Nbvw18vxCTsMHM+vSsqwB2fVqagG7Lc+VrJz?=
 =?us-ascii?Q?C3p+Gala0xqKYPBNdbfqsAr3Id0S1x5oQHuuq904ca6nIlQHOAopW0mIJM5N?=
 =?us-ascii?Q?zS2rA88HqG/GzSqPapZcwZdagXK/Ak+GGj+0T297/qJHWIN13UUzStPHGXxU?=
 =?us-ascii?Q?Avde2tQ8DR1i5TBZYjmW9bTbAUPS1iiRoIUs+4H8FyDg8aO7/VMawSdh7M92?=
 =?us-ascii?Q?UpqWpj5X4F+ra8u+vevsLXWxZHETFv0uYIpdIafVuv2eHnRA0XNszNc68Jwv?=
 =?us-ascii?Q?WObN6sMWJmK8jUkBX5cB65U1laSufbKrubv2YNVlWK5Zb4x7e4Ljpu00KCic?=
 =?us-ascii?Q?ydzwrKcNqFHSZFCTngZCWC/Rxc05YmVfx8s407SULvHBXk9qkAgSlW1F4Z4c?=
 =?us-ascii?Q?LHEvfMfbnDqTqk4YOQjanC1T8NvVeyxE1nNdhDRU5vxPfs3gPRWozrirtNx7?=
 =?us-ascii?Q?lnMtn0J3WnMJQf8qihXYEO+k9iphndpqvV/yu0jq0kL64r+kMIOPb+r7GLre?=
 =?us-ascii?Q?ASXgGGL007Dg5wkid68M6Fw93qs6+dUBd/cKW584+juQ1cPbHsKMDgyLpKXR?=
 =?us-ascii?Q?nFy7c35bepcCvWlnsnc31OvipiTAMAKU/ADJPNzVD19IfWLfDFWYvcmtZpaT?=
 =?us-ascii?Q?ZhMRYfbpknvwr/6Q2HB2AXk5pXGOMf6rE7Dh7cPMW0itGgHsRnlCwEpwcV+N?=
 =?us-ascii?Q?WK2G+CW34yZjRUTyQZtEhvROOEx8cSzt+SxR0o59KKDbIVtpQ41I0cvZIYVF?=
 =?us-ascii?Q?USLXkUGyyyi0S4qGjEkoMmPQnclRN9mKpLbxgGSVb1R4Vz78KJ28Nf4ujzhZ?=
 =?us-ascii?Q?RSRcCvJPeFO10CkrgKEWFHCt6RnrDihXFM0t9brXNjmcicxwyBQbv27dHh2Y?=
 =?us-ascii?Q?oP2CS8sL5yLX1KOIba51Xn49GZgzKVOydjB9ATP2NoY55vC4byeXYKK2u0gm?=
 =?us-ascii?Q?fsuB1wNeJIXIbi/1mJ+2rLVJK7zTwwuLLtmIyxUWUSPVcc8YVLAF/p7yc0sF?=
 =?us-ascii?Q?xwfar+hb5EZFT0oRXiC86NIPpWZ218E/UeOs4gZSmvEAm8sYpcM9XsTUzOxR?=
 =?us-ascii?Q?z9Qyvp5tRjJFZiWVycsZHHNGYxIrh0kwluQkt3FD1kdUgv/ytpUpgh2tcoSr?=
 =?us-ascii?Q?3TesxAYCVFjV+YKA40RVvEzcLHTkvzd3eWqSklyoltdGZ0Xi5IbYb1KKmGHQ?=
 =?us-ascii?Q?8cpjm2cm47DWyFvg6WCooKiZ9IH1JoJVVUpOAEHTZjgoSYEt38fnMQ5fuVw+?=
 =?us-ascii?Q?zqV2OkC4yEzQxFiKL1IUfzFtUQ3RdbMfh2jBXmCAJzLtzjKjuyNm/ngc4v+m?=
 =?us-ascii?Q?GxI12lOhFXNdEUQZDJ8SRG36TnTmNkuVlk+vkLU8fLqFvqM5OGZlDYNWKdL+?=
 =?us-ascii?Q?c7HdpXtXsuEAoti2l6mUh928DL0+1dQbuLKG4df/gNCsQB0ZwL+/EPnsj41z?=
 =?us-ascii?Q?dVcY+/H+Z3hWrdm078nAATFLS9u6FLJRDVF5zAV2OlLiLiXFP0tMJyEsS+7z?=
 =?us-ascii?Q?TU96xDSPsZx7QaR2v/QaRNRstG72jbrNi26E?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:45:50.2025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e732600-0222-41b2-cfe8-08ddf20b1125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450

cxl_find_root_decoder() uses the endpoint decoder's HPA range to find
the root decoder. This requires endpoints and root decoders to be in
the same memory domain, which is not the case for systems that need
address translation.

Add a separate @range argument to function cxl_find_root_decoder() to
specify the root decoder's address range. Now it is possible to pass a
translated address range of an endpoint decoder to function
cxl_find_root_decoder().

Patch is a prerequisite to implement address translation.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 13113920aba7..8ccc171ac724 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3376,19 +3376,18 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *range)
 }
 
 static struct cxl_root_decoder *
-cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled, struct range *range)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *range = &cxld->hpa_range;
+	struct cxl_decoder *root;
 
 	root = cxl_port_find_switch_decoder(&cxl_root->port, range);
 	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			range->start, range->end);
 		return NULL;
 	}
@@ -3579,7 +3578,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	int rc;
 
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
-		cxl_find_root_decoder(cxled);
+		cxl_find_root_decoder(cxled, range);
 	if (!cxlrd)
 		return -ENXIO;
 
-- 
2.39.5

