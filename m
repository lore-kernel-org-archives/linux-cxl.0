Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9D1EB1BC;
	Fri,  7 Feb 2025 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942708; cv=fail; b=bvQWnhn1YnJXxLK9ReEj3HFLigt1eFZXD+0hm13Dbwd/I37ELyaKugLQ6PEjCQHRzalb0nGt34z+y2TKD482LxOfZqabV14oI67iJl8viA/yNI9MIACPS88jj40LbMZaeBEH51uPfHwQE9m40/VDUMrTMZ9tNW/euLQ/Hu+OJsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942708; c=relaxed/simple;
	bh=bwBlUWWMnrtkAPrv7yKe4Dk0UuDBMyJxk2pS8tSad8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJ/bv9j9oZqUvCCkHO1X8idxdSe13xwsv6iy5qeO6kR5uKJyVRSISCX+A6W6cu0zllNyLW9kcAmOcku4HAJerHFaQCxhyS6aIsEU3pMMio8xHU9MWS+q//Ymzf5flPj2XgPIuQ2yDTQBWULCa7GmTSqQbuTvj8qt5KrdS3P6eb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CCvRwZYe; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CCvRwZYe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/fjvBWWfeV8XykQyHjSxdQv5JPAy9p3cWkzXQTETP1Mnl7Unb0SgKDkoF3Gu+Wf8+yoXpWPe5ArIizb5EFIt7YOqxA2iDBNXb6TzdlX5lAJyxBM/CBmVPi5mfTpQwHnJjxpaFjwQB++DKP8L7LvZpK8xj4ZCHZR5WZROtzxTP+zMKXILgX+IJX6yfeg2yUaK+zQlwAgNLAuGj8xkHPz9W/lme9A718slNt/5rJC8mNLsfLz3sR73+D61EMghPckSMYjIQJI+kRpEzRZDkqkw7K/8K9XJqnjwzdVFMPyfrDWnFoceZWA8Tb6maXG5LT+F2aWgTlbJjJ/qKkzmvEwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71KkKeMlT4BF5LAfOyJ7yieDTWSd003EzEmqvttsqpE=;
 b=C0TpEUXOsPv0mQGeiYjHwQqakCWfuUTA93tYiihumcQA7N0HgGja/n3POjG4sCalSDzVzxhzJOr9LgHOdHLtuX/gy5ZIFhDIVhakizbX4+L3sE5sJyNiFdshRSvCOc7mpioAU992qGTJqAvxz96Fywh5IkJdQ309i3lMFDrNeVn9GIKWjLvub78vNz8PoLWU8jIf/PUOWNe9po9nplp0LIOj9f96rXdSnfE5ZoRSfERZn2sbOsd8w8ffteJ1NkGv3jloa1ihM/4lCH8FYzI1sJWUAemqpYHVkvmKn2EgpZ3+Qqihc69c0HOArfq4UIlpPjdWa52nZRs4vsNBULrasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71KkKeMlT4BF5LAfOyJ7yieDTWSd003EzEmqvttsqpE=;
 b=CCvRwZYeS++v2NBw9ZM7I1MBupikhhDDCnXtVeLMNmPXDywmp3sKBfF8Vp6RA24gBI2Hy993Kz4kDqkNCxUIRvbCxnwp7u5uIeB+nuA/t3AUKHznFcJKkJIUDE+wRSGSoUX3Ub5mZq3Q7ewTkd/twXA5MUEWZoZujjOsGgNMXOo=
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:38:22 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::71) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Fri,
 7 Feb 2025 15:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:20 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:16 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 01/18] cxl: Remove else after return
Date: Fri, 7 Feb 2025 16:37:36 +0100
Message-ID: <20250207153753.418849-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f4f369-0d01-44be-f4e1-08dd478d7335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fu4PXAlHO1LWpeL9teVzcUuYaO5CAq3Sbt8KkWRJHJgyJBd3yU4nn6UUJYry?=
 =?us-ascii?Q?sygAJt5twGEF9YJVjcB/A64oSfuR6WLYd3wXoVxTFiSJTC7BfgTaMAXpcyL8?=
 =?us-ascii?Q?nahD0VewOLYTBnhAQjuhLwe4y48e9Xb9XhR1uae4LhWhxYzR8e4iZn+GpKwa?=
 =?us-ascii?Q?2nxXit9lDB9Oqrd6JP5uO5xrZfwv4wX/8EAnmW9ygWo6M0kLdsJZT4Gkx3Ga?=
 =?us-ascii?Q?C1op3sMBOUpRuGf5+lAaw4DIIsqvNqeo941U9LYYOxYN1cyxU04exbRqgMCc?=
 =?us-ascii?Q?vXhSjVenTRJ3MYDEO1njXdYmqPds5MvB73R57uzP6oT0iIPmfwFuCyS1YpoU?=
 =?us-ascii?Q?mVKHT2tJRWoP5CmGe4iNNO3A+PEu4/l6I1S+qXOQeK7cpRWWpui4CyppJ+cO?=
 =?us-ascii?Q?+cpXCZ0n7Zo5lB/EDkk0C7FM2DmFYY8tdiglRAG8dWrt4n36ppexQPpY4tPK?=
 =?us-ascii?Q?e4N55cJE41jScQ+7wiiPbEhc0I9gWZeWzFP4pmOfweIetkfkGAq0CtkGFFkx?=
 =?us-ascii?Q?skLhm7/2k2YBsu2XUxCFgkaIH2mIgUk3qP9R1oTeL+ggyjVtfx/dnosU+cgq?=
 =?us-ascii?Q?Fu87iReRyZLfiOZANK6haOU0IUi9tjWJcfMAQr6TL56UT7b2L/CWPx2eg7rC?=
 =?us-ascii?Q?85Y75a7Vg8DDOJex5uONY1hCiwVfRbaCPTnjxvTXYstRQPq4m+uVlKfzCt2M?=
 =?us-ascii?Q?2zl74t3OysckqxbKSZVvGcFBMTT4xBmv92oe43y/DeInCHRvd8pfQ1jM0ItP?=
 =?us-ascii?Q?BmxDR63GzhUAe/UJugCYTFiNGtCctKSB4eshxqDFnaQeYtHnYKI1UK2ApjNR?=
 =?us-ascii?Q?Z6imdrk0WUzCv7TmVxKZ97uXZVYfIOp6sXhnPvs+MLVeC4qb+3isqrfw/exm?=
 =?us-ascii?Q?CT1rjGdBWa/qM32iENWVGHJxBX44rtc1WE1/DSbNOVhXJi7bl18y0LXbXkrL?=
 =?us-ascii?Q?VM1JYQN325b0t0g0/9birBAHjfchQQL5BVdCHsBYf1bgeByQOnLen9JccC+i?=
 =?us-ascii?Q?3bg+yZ2utNP1N5hEtO/ngd1ZEKpL+CQ/IQTqvbUNkrVt/gkA5l+AW1Fylc7A?=
 =?us-ascii?Q?NAQpXjx2MXlRSI0W1KA6NLQyZaznw0hQzx154GKWUHAMA2Ukqv29M3S60RSG?=
 =?us-ascii?Q?dBHELrGEO+TdTY2IRZiup7aCPkIHhGWtheE/9foybcS8gQbxH4PByWtBE7vq?=
 =?us-ascii?Q?oeqUATw5Gb+geOhfZVDtj2fHtQIs0OkWewXLemV7BvWARWz6smOCmGrkkyWv?=
 =?us-ascii?Q?uohHlO1Vn/f3Mi4BvVWic/U0ett3qX4Im9i9x1+KB1Bo1JtKFnLX3PuKcgdz?=
 =?us-ascii?Q?vQZM3a5gHxtWIJdaJjzRJ5sd8SKzcUO1RW1Rv8HrOTIi2jEKaUOf0oehvrMR?=
 =?us-ascii?Q?9Im4bvtWoJ29lIh95nxA2DcFoWNwvXIyscPWzFREHBIk/iu0IBkthaBWbECY?=
 =?us-ascii?Q?xRaySF5wDw7CGr3ocD1QsW1xmr2io6brV4kJ++PhX+CPWLAC+GOpUw0gB+4H?=
 =?us-ascii?Q?dty8nGf/jsmUw4A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:20.3792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f4f369-0d01-44be-f4e1-08dd478d7335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067

Remove unnecessary 'else' after return. Improves readability of code.
It is easier to place comments. Check and fix all occurrences under
drivers/cxl/.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c   | 2 +-
 drivers/cxl/core/pci.c    | 3 ++-
 drivers/cxl/core/region.c | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bfba7f5019cf..0a09add46d5c 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -28,7 +28,7 @@ static u32 cdat_normalize(u16 entry, u64 base, u8 type)
 	 */
 	if (entry == 0xffff || !entry)
 		return 0;
-	else if (base > (UINT_MAX / (entry)))
+	if (base > (UINT_MAX / (entry)))
 		return 0;
 
 	/*
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a5c65f79db18..2ec8c97ab160 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -415,7 +415,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 */
 	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
 		return devm_cxl_enable_mem(&port->dev, cxlds);
-	else if (!hdm)
+
+	if (!hdm)
 		return -ENODEV;
 
 	root = to_cxl_port(port->dev.parent);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 84ce625b8591..5d252dfae138 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1926,7 +1926,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_dbg(&cxlr->dev, "region already active\n");
 		return -EBUSY;
-	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
+	}
+
+	if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_dbg(&cxlr->dev, "interleave config missing\n");
 		return -ENXIO;
 	}
-- 
2.39.5

