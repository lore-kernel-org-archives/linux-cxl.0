Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE026A08F;
	Tue, 18 Feb 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885103; cv=fail; b=S24hvs58aZFViHOTI2+iK9tYETplQzuHPoS4hoaQ3uJFMKC5lzuP8DMiEx/0SlyPeNFCe3WpYSzPO8TG888ad9HoKca2bHnq06+NwODduWtfl/8Z9obe1Iru8q2QkqIlWhDx2m1CC6Izp91XVlOoTYjeKP3QJ12u6QDp7CRHxzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885103; c=relaxed/simple;
	bh=zT++EimYlPbeKLmMwtpWzaJ9+KzQHIenk0Kd5wMNrZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9i1cNfTYY79iVCRJS5FJgBWXEqVcdeik6acm//BXPMpvSsAUleLVX0ZNd3m013QNcRLrUrz6skyUi0XYrzAMt+sUje+mwxWopBfklkQ5bl3KCBTX8P4GCN5Z3riOAM9CbaC7kSz2irJDNcuYT+ip6AL9T5dZ0e5ByrWJj6vJKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O/2KWvPL; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O/2KWvPL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZ61cEAGa7W4WJhjP7kifVB0eFNtrRYRecPIWDIQh6vBdQOa2Ww6u0WvuyJT32klZ1YqUwNttyXvrEtvq4JTQZxH1Vk5+aLF8fwDGH15iYs2tvzPeOQyoWvudi2EGGyNurxPMiwwunOCaOMek1A2XkLavar3yXg8H7GZrZNFx4bdEU+xIccvcEckodTyQ0Qqt/Kr5yaqHyVt2vQYXY0Lt8Nl6/kRvHPIKpZk5z9HjtdTAtzvByEWGtbHgnRwr2FQZHtn7gI7J4/hrrBqA85MOqTmWNWRp6joo/WYF4Zw4NJ8SgJvsIeuCwe4d6i2WnE6AsATAD95zpdC3VaOCr8ljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuHFKg4YFyKB2cMbJGgohggrGdBD84dGFsLK6w6UbwY=;
 b=ZElPCK2+r/6xFnGiM5RvosnPhhpi3PlkjW5KXy+oZKXWg2J1LSqtbbUmWhNJOUDkD3SeSTUZ8wjwcq4GczGX4g+WplNJyYow/kY1yrePHSGbKz//+w4J8dllk78hCllwZLUjQWuTVFg1hDBsHisKJ+ZyO6BYktKXgIbJrJevX/b5RrWbeyhoCPkb2rPrpWBYoD+MoXKW7/n6v6aAo7Fef+rfl8qhGWksY7oYdamcawlEh9HKEKF3zbe/REnLFIUWaH7qIb1NGgal4SWZkmN3LNdI08tNhVLpUrjd+Fbo+lwc/osKTAPL9+FoKVFVDxp2MGc7mxBg7S79+9MSgKHH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuHFKg4YFyKB2cMbJGgohggrGdBD84dGFsLK6w6UbwY=;
 b=O/2KWvPLTCnSo2345Q8hPcJ+UnCZ5e+8gnUK8O2ln1jkVPFScoyZ6GbR8ibd+siOWL+dint5gFJUoVrGlS8+exRrfgJVFDDayxpfN3g0N4NbHEByDyr2TgpVszdr/LXoHUjxIxGU6SwPYSRa/TOxz+WNPzJ7dvXwlpsJqUTpoxc=
Received: from BN8PR15CA0024.namprd15.prod.outlook.com (2603:10b6:408:c0::37)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 13:24:57 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::41) by BN8PR15CA0024.outlook.office365.com
 (2603:10b6:408:c0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 13:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:24:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:24:54 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 07/15] cxl/region: Use translated HPA ranges to find the port's decoder
Date: Tue, 18 Feb 2025 14:23:48 +0100
Message-ID: <20250218132356.1809075-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6cdeab-767c-4ff3-f67c-08dd501fa35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xMh+SdTfkbWLaGwIbtM6uDzZwUqIcpQv5SlfqYVd6bhYtklCXo9hweaKykON?=
 =?us-ascii?Q?biT8QHC5c5l6luU8K0y0QHXCIgBCw//mUq9xuIIjTOaSM7FrmQdsRNGRp86T?=
 =?us-ascii?Q?WvuPIMoMiYuLsF6CFDLvqDP84fBO311vN2XJtc0wdMiIfGYCaxgZWG4LndVK?=
 =?us-ascii?Q?fYiQuryeSi47/o+ee4/K3zBJNLnBQwnTCnpP2fcAVkcwqzQa4lL5Gxom2r0J?=
 =?us-ascii?Q?pTvwbge+mUiBMYJXLzphDrRB7TpEe3fiGxyN0gz/4M7t/CNC/qHUH5EYpjV8?=
 =?us-ascii?Q?XMYVnFi7bS+NSGiPEjTrUzGkeq1/rNB2JNQGXTvUml3j6CpaEuF71OsnkBiP?=
 =?us-ascii?Q?FVcK0PIGCXApTJyR4Fhp27aWReBp4HgrI68mjVaobtgH3Ze2AocD0CUUaM5i?=
 =?us-ascii?Q?HG6HzAxvP5+pZ2Fb+jf24E0ChltowAB7VgnK6xp4FFGgeY5s0WO4HbHz7ANS?=
 =?us-ascii?Q?1MIt1DHewbA1hlvu1Ar3h6iMd5ZPw/UStfCLAV/2E+6Jpw7Ry1MdiJ/RxJki?=
 =?us-ascii?Q?XSRXzNMl0PAa61vMMp9kh09D+m9OO9fe6AuZdHntZdoXKxTUqeEi572IU9zb?=
 =?us-ascii?Q?etMT89pJqxlgIlZspWRjPA4BUWdGgYf/sRDehNkNIWjqz0iCQlS6QbaQT8pJ?=
 =?us-ascii?Q?5B4IaA7Nx7WIpKVTGNLNGvwR29MCgJdSTr1wN7xWUh1IV6qP7JQS3vxwFPt+?=
 =?us-ascii?Q?hj5D5QlvPRBdUOmNAuMpQIDtL4iHW5XFyUWOYxBJI29stKMXCqteNbYRjkzO?=
 =?us-ascii?Q?I/wY1PaFx+uft+hhjf+mJovIg+UYLBshh+d5vZ90g7i2/is9tKYdYnpVlypA?=
 =?us-ascii?Q?nvn5OqbhZ2gr8p+79oASkNEiStmL1Z80OlsFXMJfVB4/y77ZftT69vVGN2BR?=
 =?us-ascii?Q?MWD06QrgF3Y84Sy8t1IhwRuoXdGQlMwIiQCSIqTUz/6mZ+GvIYLFSfMGx7b0?=
 =?us-ascii?Q?ieZQPWlfwH9abR6MNjT7RM/H0wY0AgrDl7WSrlEvdSTV2h7zPJFz2aebUXjH?=
 =?us-ascii?Q?dPyKQliDnC4xdjRLjEQBgvnmOfABqqWOD+/zBmEwMmBnq67a+iA72hDD+TT3?=
 =?us-ascii?Q?qc7BdSm8uYR2t8UPKCqD3e4gsjPL4506Q3c9/BLZL76H2KOpc0MD3Rr8LGEW?=
 =?us-ascii?Q?gFqMnuYK8JPJcC1irSqVyWFAhwP9c2K47ByfmhrftyzC3PRK9u7lFCvxMUs8?=
 =?us-ascii?Q?kbdiGcG/17B+VdBqsDDekS/pbrWGEhuNvSHylgEk406FDi7sgjU5ln8VF50V?=
 =?us-ascii?Q?Rs4MsAgqtCAP03mlbgUFqmxA8Rnpe1q1+GxxEOJrVwd7jZE0nyGbJp3UPpq1?=
 =?us-ascii?Q?sQNa41uhPl6U8AFBCSLLAv/Try7CA2vzxx09TDbOkm3tQSJuKeyAOIARyfQp?=
 =?us-ascii?Q?rnatpKaqsiC/jqUv0JyjijH3Ra0hGNT7xiaeZB/OU7v/iwowwNL/fRGm9sOm?=
 =?us-ascii?Q?ReJFNjOidN99h/0OC4XOLdVNevFuW+9mK6TUksQ3MMpfKxq6DyXOpJcVDBjr?=
 =?us-ascii?Q?7Mp6orTCOsjFX/g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:24:57.1021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6cdeab-767c-4ff3-f67c-08dd501fa35a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

This is the second step to find the port's decoder with address
translation enabled. The translated HPA range must be used to find a
decoder. The port's HPA range is determined by applying address
translation when crossing memory domains for the HPA range to each
port while traversing the topology from the endpoint up to the port.

Introduce a function cxl_find_auto_decoder() that calculates the
port's translated address range to determine the corresponding
decoder. Use the existing helper function cxl_port_calc_hpa() for HPA
range calculation.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 60 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5048511f9de5..6d5ede5b4c43 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -887,6 +887,63 @@ static int match_auto_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
+static struct device *
+cxl_find_auto_decoder(struct cxl_port *port, struct cxl_endpoint_decoder *cxled,
+		      struct cxl_region *cxlr)
+{
+	struct cxl_port *parent, *iter = cxled_to_port(cxled);
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct range hpa = cxld->hpa_range;
+	struct cxl_region_ref *rr;
+
+	while (iter != port) {
+		parent = parent_port_of(iter);
+		if (!parent) {
+			dev_warn(&port->dev,
+				"port not a parent of endpoint decoder %s\n",
+				dev_name(&cxled->cxld.dev));
+			return NULL;
+		}
+
+		if (!parent->to_hpa) {
+			iter = parent;
+			continue;
+		}
+
+		/* Lower domain decoders are already attached. */
+		rr = cxl_rr_load(iter, cxlr);
+		cxld = rr ? rr->decoder : NULL;
+		if (!cxld) {
+			dev_warn(&iter->dev,
+				"no decoder found for region %s\n",
+				dev_name(&cxlr->dev));
+			return NULL;
+		}
+
+		/* Check switch decoder range. */
+		if (cxld != &cxled->cxld &&
+		    !match_auto_decoder(&cxld->dev, &hpa)) {
+			dev_warn(&iter->dev,
+				"decoder %s out of range %#llx-%#llx:%#llx-%#llx(%s)\n",
+				dev_name(&cxld->dev), cxld->hpa_range.start,
+				cxld->hpa_range.end, hpa.start, hpa.end,
+				dev_name(&cxled->cxld.dev));
+			return NULL;
+		}
+
+		if (cxl_port_calc_hpa(parent, cxld, &hpa) < 0)
+			return NULL;
+
+		iter = parent;
+	}
+
+	dev_dbg(cxld->dev.parent, "%s: range: %#llx-%#llx iw: %d ig: %d\n",
+		dev_name(&cxld->dev), hpa.start, hpa.end,
+		cxld->interleave_ways, cxld->interleave_granularity);
+
+	return device_find_child(&port->dev, &hpa, match_auto_decoder);
+}
+
 /*
  * Use cxl_find_decoder_early() only during region setup in the early
  * setup stage. Once a port is attached to a region, the region
@@ -905,8 +962,7 @@ cxl_find_decoder_early(struct cxl_port *port,
 		return &cxled->cxld;
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
-		dev = device_find_child(&port->dev, &cxled->cxld.hpa_range,
-					match_auto_decoder);
+		dev = cxl_find_auto_decoder(port, cxled, cxlr);
 	else
 		dev = device_find_child(&port->dev, NULL, match_free_decoder);
 	if (!dev)
-- 
2.39.5

