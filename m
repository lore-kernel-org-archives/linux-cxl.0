Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB53A1F37AC;
	Tue,  7 Jan 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259095; cv=fail; b=TCrlc3AO5igcfQVK9zr3DmfYN6U47VuBlBKAcJihzBfPdQ05W8SjnEfY44i/FK/v7FsyQxUiHOMhoSIjOXS6tjZC08HXQy7eQuhaS7aS7FlujI/5nN+iM8sbXtnkTCjU67+FdAJJR1aCXY/+yC1zxR7MxwzgBK+9Imyl5yTPxHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259095; c=relaxed/simple;
	bh=49Owqhvzi7EBaz/dnOUBa3eElXPvEEPe8lpANlLDeoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kv9sqSTaOln6JMlEXpsgSnO3aXC9O6XM8VYqJgBJtTc1kcC9XdRe1/cCcf10GlVH0dJDO0+s+OWu+r3oI7gGvej3GbPe8KfcXs69mVa9e4tLccSmOqspVIxvMuM03J8zj4moFoO/m+mzEySLf96MV3351eYA4Dj6xmToYugTbX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Hr/FdfM; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Hr/FdfM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSxACFmKg09Ksp56pKloT/V4XyLDLjjkLEZGIUuGoSVM0eLVlZS1p8Q45S3ihto7w1ZK8inuWRJxBTVRgB4QZH8bwwLY3CKTD2zzxNOtVfJu3bMqUx2mE54ut9YBdu0JhAyBeBliH1czXw7arvcHGbycAzKMlWA2AqLPZQ8iLMhei/VRHtrJZouzLA3ML+MQpDRORy/dYjt0sGDhlndcq1PhhlGwuzZ5Zb8PL+YXGzJC7pNrz16ra836yqficPmBbkcmBIVJ0m6F8DuDQY/hpH7Hvzaw5oL49xdsUqt/xYILVVPr6XF9H+pl+RVoRJV4g3K9RrcVm2gG4J2AssABBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLlcVoJAeuAuIcaXLHZQryzisSbU/vw7VG+Btw8kGlg=;
 b=oUHYTjnVT/bG0UzPW6c5+ZZlTtJ3xO72CYxqRo0lGH1TeaOL3QR+H7sU9vhe3y1mkPubr/KP2CH3w4AVsaJAOl0wcw5cSURLotcWapcFZ1pg0uU6qOIPhJRqMwyZV7BkkTGVnpl1PxU+tNBPVRrkyI9YgjICLOR7uoDiE7vkfqj63CkC1SVs0IbAw8dEVsAsqThPK6KDjYt+3ffSUkpqYUIE7gU1gpQ4GxGuSA10MwoXu1llNZLXDBzu+uTtF8hz76eXDd91P2V90RMfl1qgLeee9N7ygT/bgOJmq+VCBQEhzOWjLfNGdRMqzApdfXY64Rr+IenkBPZ76Xp9Bx0wZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLlcVoJAeuAuIcaXLHZQryzisSbU/vw7VG+Btw8kGlg=;
 b=5Hr/FdfMIcgT91fha6kEjiWIXp/gsxVYXgtWIWTYLfrgMJk2bJVabhcbvBjOy3FDVOwYzbn40GnZZHM/r13oh5oYZnA91hRfUsnLPeJVj1pprTlvXqxYcjEgJhLkrR8NZOrccAMKOv0XDfNWUudDq/u2G2fo9e7+i1UyK2tOf+4=
Received: from MW3PR06CA0025.namprd06.prod.outlook.com (2603:10b6:303:2a::30)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:11:29 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::a0) by MW3PR06CA0025.outlook.office365.com
 (2603:10b6:303:2a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:28 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:25 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 13/29] cxl: Introduce callback to translate an HPA range from a port to its parent
Date: Tue, 7 Jan 2025 15:09:59 +0100
Message-ID: <20250107141015.3367194-14-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: d00c7a3a-520f-4c05-5965-08dd2f252de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PoBo8k89JIptD0CmXJ5w/0UQz4Vcf+EVmjOY8TTHhQmHK+n3vpvtiJ+6FRXf?=
 =?us-ascii?Q?Z1ERRSqSpKPrfEwM7/ZTxQq34+gN1aORIFDmXe/gPJgeWDHPizc9t6TDHIlS?=
 =?us-ascii?Q?n4nXpSlWSLCsFGvXH5xrA5ysmt1cHyVi9uOK0PGw/fh87bJ6qlPJ0a9JjKqd?=
 =?us-ascii?Q?bpkdqfBl2FkdBFm2QNLaq+oVv60TQ9oZjSuV+yRzYbUDjYBgi119dhYMWDZ9?=
 =?us-ascii?Q?6L96un49louNl5SOZnpHYLOEkT8mSJN482roq4w8NIbqH/c6zv6ZpebVcE0m?=
 =?us-ascii?Q?awEKL47C2AjJZcVrt3LIhjBAifWC4hfHP9Z5hxEgCXtumhD+bUeCNN0x07zX?=
 =?us-ascii?Q?hskRX65JztGlRlJWQKhOIe5kvql1rDXJpfDUjvAP8S5+s01fj8XZMElX+QMw?=
 =?us-ascii?Q?OdpynHum4SbkeQmihGiRpwyNdtwt7eGMKEpkMDqAiN9VBggcoiTRmN15LoXS?=
 =?us-ascii?Q?+kqTduaUVKeHFNGwIiZ8Nx6nEsfAXJfsfhMK5ZhCBQ8zrZ03yNbdhmQFg7YV?=
 =?us-ascii?Q?cz8SF/vOeqWfLg4eqgvn0SL9ayylWG7N+6Qaut89U4DIfPmoOJ7VK4bFGLdM?=
 =?us-ascii?Q?Dw3riTYF6zPNVWta1hXfrGoricB6d1E1wkAeZDSp2ukJdRL9pJ6ynwj3htJ5?=
 =?us-ascii?Q?jIDalufEi3JUWl3GRHoe5SiNuETbmP/RaGykSrZZAEmazK0h51BPNSaHSXjI?=
 =?us-ascii?Q?HYy20FGpfCq3n6jPId/rstxtnY4U3TY+80pNVf9oCf9DhpbwYOZF3fLu/Mcp?=
 =?us-ascii?Q?39z0VLjEPcCbDwqgSqZf+wDYcCqsCrT4MlEAWM/wyDaFzbW2+gCliML5nyiD?=
 =?us-ascii?Q?xyz3LgowBjbSamnYCTksM2Nzaygk/rtGu281MIsFE1gXKZrcWwZickoYx5cb?=
 =?us-ascii?Q?OkDWfWqKCG1oIMSrh8vELGuLGC7TukuGxmr4vmkJgf6DEY+SSGDkHdAeqtKF?=
 =?us-ascii?Q?TBNbYlc5g8yCDfdaeSICiKcBUohNVH25A/EUi0cUX+/rmSD/XLsIeuDlgIL5?=
 =?us-ascii?Q?xJ+QPrG48UHI0HnZT/8go6wHiP9IY2ckkFpnkRacR6GBmmKo2ePVWPbnAczC?=
 =?us-ascii?Q?xm5APMuGF1EUGeCN/pO0rASQsCQHvFWX38R0zI1tzcVVl3xs80CIveec01Y/?=
 =?us-ascii?Q?8plSIzCoWiZk8UCElY9SL9rQ2texP+CxdWq+5hNNK68fcDBYhcTLAc8zlhwg?=
 =?us-ascii?Q?670G3GtObFEb9bd0e1bl7evNu4LtoY7LbpPcUuy6vKCREpY3rSjF197hB0DG?=
 =?us-ascii?Q?nhWvXGeq1/UR7jJjxevelZJTUn8DxPFZDyorXweko8O7+66nK4NONprgsL0U?=
 =?us-ascii?Q?aRogXhGhJQLK57c6iIYSoL6RnwoRqnSLW7M6kIW0Hi1iPyB/lR9oX02Z9NUJ?=
 =?us-ascii?Q?L/b54gf1qRD+p3fvHOa3t4AjP+W0WC/uul9en/2hXgpmMZvcYM+E5pwWd+YO?=
 =?us-ascii?Q?MYk54ZX3vmfOPwxsrBibpzMQTsjDvVHxo1mjz7YdPILNs2p+P51yAlGLKzAq?=
 =?us-ascii?Q?cWizKeNlzN602ng=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:28.5020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d00c7a3a-520f-4c05-5965-08dd2f252de2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

To enable address translation, the endpoint's HPA range must be
translated to each of the parent port's address ranges up to the root
decoder. Traverse the decoder and port hierarchy from the endpoint up
to the root port and apply platform specific translation functions to
determine the next HPA range of the parent port where needed:

  if (cxl_port->to_hpa)
    hpa = cxl_port->to_hpa(cxl_decoder, hpa)

The root port's HPA range is equivalent to the system's SPA range.

Introduce a callback to translate an HPA range from a port to its
parent.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/cxl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be7685fe8a23..49280e0f8840 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -601,6 +601,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @to_hpa: Callback to translate a child port's decoder address to the port's HPA address range
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -621,6 +622,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	cxl_to_hpa_fn to_hpa;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-- 
2.39.5

