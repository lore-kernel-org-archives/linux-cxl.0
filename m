Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DFE21147C;
	Mon, 28 Apr 2025 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876652; cv=fail; b=sAXun7Se6pHFipUHXxZYl2p9uglEKQ7S4rSmCKIncOU5dZHy2Cs4utPbP+iwpdtt97DnVJewfO1FOfBcgC0nDAe2lVfizInK3H1QKll4ofYFD6uJk6zYGWGNtEjrG5kCE+MpAwOywQZbeVrFUFpCWUe0z+mt8uxX9qDDw0CXLwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876652; c=relaxed/simple;
	bh=JgjiCycvwpo1sP2fDM3qbTIM6NT5cwNRfTnScdIvqSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETxChFczYbl15gak9A/ZIXc7NGfdjr0Nk6tPM7EWZg7B0lTjM4hpk7+6b2ZZ1/kX+9pUoAHlnwe3kMfgM4qm9tV0ovQnCwzXBFLkqIk5zJi/LeCfLDPxWRnRkcbSGdSP4E1fIjBp3led3QTS/zm5YuICTSLch8RDIHi8Zxf8iVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e3bhT5O8; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e3bhT5O8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPsicUgrt8YaoVwd6oFKKo+fa/JhMQNsUet63L7mP2s1F5p5YSe0X6bUmx7joigUdPUvvlL3Q74RVSIeuADsxj75+Qhgh1NIhT3pYKdHNfLj6jBvaHLZUIMNoCwZuyj4BbitRvBH/2LNY5kAYQakE4ykxlgG1q7igFAgPTemVVok5w23BXherRm0W4o24PqWvJFnJFpAsnmLTqEAwwYTng0IPN44+p/1/WijuyYaeSKR2wX4eoRak8kYoPZOp8KFzncGmoImiZN4N22I0pedO7WIbZ1rg0/CXTx9bRp27xWJIdqInWaSr7nm7gS73ykkDb0YL1XrWeVzUOLnGPWEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rJFfPT1Nf2V/qPwpmuxQ9z4wQnHoE/ofbScDZ4Fb8g=;
 b=Hn+byW7zWMTMSl1VYp//P0uwkr5x/PqCNr0H6o438vXsnfEGk4Itv6OxMnxZLqH2vjg05+bLatPs84B08E+tRrKjBOEi5DG5+M/A6PMi5sqCE6bF0ENlAEolCVdm7gEFP9Qvzg8BTFvUUbEYau5JDbYZrmKetfQBlXwrS58NbTwthZkl9fHN6AZUMsOdleJm0nVtwayLDTMKY8gw2eOCe5GZLPvqQGUrg9X9adqVf/o9X7TiXH3lv1i1oA5E/e5KSl6BCo+lTdZKxHVKez3sxJHm9xV3E7lkLIZnR//keleejZ3nyh5fLEs1ZMJyoCBlxxdN+i7zBMWd9mpmyPTOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rJFfPT1Nf2V/qPwpmuxQ9z4wQnHoE/ofbScDZ4Fb8g=;
 b=e3bhT5O8Pq8m0OXe0O8LJGpjTsZ0Xg01eR47HJjTVbsfm6iamyIXnKa0vPEUVTZ2QuD2IcuSXG5e3WbPI639B1IsfXb59VNcjMcVocBKy8y1e+w7unb09q7I0qa3eApfM3kC/uVcz/5t3vRv6qFTF4sFTYpN+P5fdpzGAdOXm/c=
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 21:44:08 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::f7) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Mon,
 28 Apr 2025 21:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:44:07 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:44:02 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 08/14] cxl/port: Replace put_cxl_root() by a cleanup helper
Date: Mon, 28 Apr 2025 23:43:11 +0200
Message-ID: <20250428214318.1682212-9-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bea1738-b076-49ca-f1c5-08dd869dcde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ihhusdSEQZCaShc7klmoyKJS5wBACy8merbBja/WGyvB189uSOSSuEmnL4Hm?=
 =?us-ascii?Q?cik17WTGxeEf1UrTUzBbIw3FhKv2lWXYVDvaCg/lmbyDpUvdRhMiZJwepK5b?=
 =?us-ascii?Q?+BOk2kp7VFgGzEluAjHr0HOKT8Y3yUCR2V3bj17t1SCXF7rYr3pRrTtFiok9?=
 =?us-ascii?Q?0rxZezO7aTxqH8ABPxqfAKelNiZoF5SSWpWv6seFAqNb8qfjKeGkC3jWFj95?=
 =?us-ascii?Q?5agbIpEecDW9UmyuWke6+vPsw+nqEZYYCyHOkSEakx2FuVsBRHl7s8PpPNMF?=
 =?us-ascii?Q?1fbz1nFJUugo9fwN7xAoUhKxmJZm2Gw8yRvwCAeXF7FG2gpEw5retH51hLNC?=
 =?us-ascii?Q?lyuTMF1D8Sddhiusu6FvQ04irKvSrg3qQZm/mMponEX3q+np3BYZVnrH/Tc1?=
 =?us-ascii?Q?EyKutHY5htSnVvkYWOhchvJt+WtHaH1tu+jfIaPSSS0X0+9A5l/LnaNGy70O?=
 =?us-ascii?Q?7T2FKjL8m1KieIurR1WuwYR4QYn4WjJDpfnZ9qz8awF2Y92hbtxI84sLFJ8i?=
 =?us-ascii?Q?DW25LdOokjCfyuBBsk6vnhecmnC1XoYu5sYMlEnqbzVu5xtAhS02LoN6Xs6r?=
 =?us-ascii?Q?O+jPVLEQafTgVZg7X/1vRm+xMktRd76N6P6vQl4QWVH3VQRlfGZqlDJ6w0lP?=
 =?us-ascii?Q?0/oWYDKBoKeIXsmmyIygtuK+sRGg2pNTpGX01hgK6tffiXWcW+VXHg51bgzZ?=
 =?us-ascii?Q?QZ9DpjTP/u1Wy+wxCfalX1kexyY7RKfFDD3MgyLw7LD8QseHzdz7JeH1OfQX?=
 =?us-ascii?Q?tUNtDAEYguNcghQRC4retQCqX4jyPxCXC0N5CeSeg7d+lfRwawLv0QXZNTHj?=
 =?us-ascii?Q?nxuxnOwOZfqkdwr2ZINgJXKXsGfYm/ijkNgNbHM+vKtVcmwZUo6WbslBoG/b?=
 =?us-ascii?Q?GUjN0CCmEbivv9OOeMv0uOHYcb6xEX9hMUp004y7duLKNJXY5NTYwejCteWs?=
 =?us-ascii?Q?XaUZDBC+8rX1LFlcqxRi7xCcJOzfemXY3I9nTHcD5197NJC047w8LSw3DcO7?=
 =?us-ascii?Q?WtXtTnMD1XEsy79J2K+H4Yo10Eg0S2QYMXzU1Qp5m1hHgWB183g5OfaaSXn7?=
 =?us-ascii?Q?EVwZp5WoW2lJ0UogSv5L49QI6PZB8d//w8HVzGFjfcvRNvRIuBYxSq1kdAje?=
 =?us-ascii?Q?ejukoeXQA4EmDK6l1TOc7pxD/aOvIHL9OyDQ5i47WqEqZvw+IvvzrIcwz+SJ?=
 =?us-ascii?Q?NsnFlM44QJEpKmBEgb8fz2j/t91zKTHzZx2Z5HfIZHAD0vTFv7vzLni3Z4rb?=
 =?us-ascii?Q?vjLstdnds/rAP8d2k+lHP1A8Fv6rRn2dNST+IltQhDQj1M/pJs/SoFsfgd1N?=
 =?us-ascii?Q?jnmGyzAhsxrvolgmniWvaocz1GdD0t7GGjZYlXW9uvKOCUlpS4HG/Z/R6Jav?=
 =?us-ascii?Q?fCN/lY9GhT/ybt7awqF+0m2M87LPHUaufRZsZXFqPQwmb3H5p1Eo13Qg4dbZ?=
 =?us-ascii?Q?eOpdmOAtUn3OFgCxj4O8rAQMUvQ11IPsQurftPcl/CVX8ztZIDxw/jx0gn1m?=
 =?us-ascii?Q?oNX+9y/jpvf6HeJLqLaZ44dcZtNV/HyYIOHV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:44:07.7140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bea1738-b076-49ca-f1c5-08dd869dcde2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550

Function put_cxl_root() is only used by its cleanup helper. Remove the
function entirely and only use the helper.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 9 ---------
 drivers/cxl/cxl.h       | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c9087515d743..e325f08aaf32 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1037,15 +1037,6 @@ struct cxl_root *find_cxl_root(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(find_cxl_root, "CXL");
 
-void put_cxl_root(struct cxl_root *cxl_root)
-{
-	if (!cxl_root)
-		return;
-
-	put_device(&cxl_root->port.dev);
-}
-EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
-
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 960efcc60476..ea06850ecaea 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -737,10 +737,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
 struct cxl_root *find_cxl_root(struct cxl_port *port);
-void put_cxl_root(struct cxl_root *cxl_root);
-DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
 
+DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
-- 
2.39.5

