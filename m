Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57243101DD;
	Sat, 10 Jan 2026 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045692; cv=fail; b=tPwxyjLwBE58hawgWst5ULdBhKBUuETvEVbF4f6wPSaf889VvZB+uw0mMcm4XTWu9jhHhG4hskAhwHEfZIZwVjNWVjOjDIoXL2Fml6GtzNqPboWuIJi/bn2rokqpY9wZzIv6Hu+0mFgDaZz8a/y+4tr1YQoa4yjrW+riSQA8ot4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045692; c=relaxed/simple;
	bh=qyyseSAGmUDBFvA5yNM8iK8z0TcjhT6VxbNBmEltT38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onLpNtW3DIQpfk4+h3LeTrxntLZJkcpiExsx7mWwCKXYwU2TqeeRe1rWCi8Cc3dvGWAtrW0/cMcwQhJdcXVXLY0ktAhXcOS94kBzlq30O1Ph/UjPqKjvSLDdKixXklJ1IfY04LaKzMpDnFpeFFOX/M9HiR3fyMUQ8sE4hWdAQIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YoZp6U9w; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YoZp6U9w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNAE/zaTh1Ovy6m1qFLytl5thYCezvyAGU99FekhHwYw1yg22mg+zlA23C0wbfrdi8DVXXnTbsLnAGA8adtTz34hWV22OyYe+OXHUEkYagyvd0gG5GOHrbzIM5FCZwTLwHI+kShebCUNCZQWp3nTLAIJPz02BOucWJ5f1lV2G+XyeiVdmzAw3TYEgcD4qvOz8l+5Egp3MPPUnmE6xek25gyK1ORCqT3lTcn/XT8tuTbUZKmDcTV9IYicuqU2B4omPfW60AJXwmn2FNAIdYFmL0y/+qq5MCPyqile8uAfG9NjLmOiQPfF9MTDhZpqhIHn3kYObmX1vhHxIdbNWGWIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL8rqwNCbyR5hhSvyHdVG915YX46Qaro80cAShOyJLE=;
 b=a+TRlZekkB0M1LLFFVc1hhTGNCAwglNw01rHXMG5LmNMqb8tVg7+y+qpxLGSRPBawoNY7OHUYtq2cWipaaudk8+DCheH5BtGjHVOtM7UKXEnSnIYGaND5BoT7wXud3k6SM02C45vuY8iQni0hYb4VL/uAMvOE8hodjkQyjNtw83WvMeAgYJKdBGe34krTMSzCjX2O+z1YXMlW8g5kamaocDBmhZBRVId7uJD7kRsDCwDgJKa2dbxLYi2rjz7Uh2tL1kNg9Y95Lx0+aXTvFcNgObolWYY3d2TTtpLjuqMI59VFE0C7DDbzWcEskw7JnzBrTzFVe9hFbbPmifoCGLfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL8rqwNCbyR5hhSvyHdVG915YX46Qaro80cAShOyJLE=;
 b=YoZp6U9w2ykW4YL9faAWAlB8/Y9en+mWk8ZcwIQ4yLfkDn7NFzSVUiBIBu760irHue35tbX8C+b0Sf4TPnMTdnzyrS6v9VdpwkwXX4kH+aqKseqqENzRjuIws95rFCl1499f+TKRtWjNJ6EXpTM25A3FwR+TekZPP6rxUMb0B+w=
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 11:48:05 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::ed) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sat,
 10 Jan 2026 11:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Sat, 10 Jan 2026 11:48:05 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:47:59 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 09/13] cxl/acpi: Prepare use of EFI runtime services
Date: Sat, 10 Jan 2026 12:46:54 +0100
Message-ID: <20260110114705.681676-10-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 26abe3d7-b941-4001-4886-08de503e1dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fScBP70H+BFm5+rAWTe++Ohgu6aGLvsgHCqUqn5tfsC431DEOW+Tycx4nQ2K?=
 =?us-ascii?Q?8asxRUgEckY7FoKH/6wb+LlKL8h/CM1BPh3WUIQkJE+BFPtgrqNUHOm79I+e?=
 =?us-ascii?Q?L6cfrq6Q+Qvgghg+R+51enr5ah+J4XfVpiZvme0rp2QoiUXq85NJhHwvr43k?=
 =?us-ascii?Q?6ZGFsq1JcE0GvrkRwdln6avNaMcAFxuS95t9lrBqoIvrWlOPmIxShqk1eG+B?=
 =?us-ascii?Q?JpODZqrsg9f7YD9GOrEM4BX4NcInMjwqIwP6Xo/3ImxgRh4DEQFcQRJBgwX3?=
 =?us-ascii?Q?0Gms+3aYUDSnYS3DUM1pCP5E6Q2wKh5OiiykzQHhPVkJwBzuvzgGPVDOgULP?=
 =?us-ascii?Q?nmErM/Aa13M8VyQAY4aLWB9W5tkcxRBUnoh6MATnWMDzZ6lMYFHQSJ9GX1J/?=
 =?us-ascii?Q?pA9JIAclTQ7ImI29TX1dsjG1ItoRwEX5avKrzlnzy0OCRFLWV7rUZQKfNQWH?=
 =?us-ascii?Q?xlby2pxGmWOisfN4Pb+37ipQwEqICNDS+iRBh0pQSKnTYSS7TpcdzSEK+/Pd?=
 =?us-ascii?Q?UXZpiUVX1QAlBhkmf/e4jz19s99M+OR2kKs9N0X7DtUwzhacro0uGlXr4kj7?=
 =?us-ascii?Q?dZxygwgdeiVrACqpdoZtKNa2Br8OAkHCERly/umjmxX5sFhj7dnn+9+xlmsp?=
 =?us-ascii?Q?ujc23XbpSbjt+Id2kZe66wre/YeNqKX5wW8XEJqVhWplhd7t3ppBFH5nDvqI?=
 =?us-ascii?Q?Lhif0mNLc/hM8MxkjqE8946AQQfQnvkqrVTo7zmKO4FV0xQxSPKO5qh3tZZ9?=
 =?us-ascii?Q?WMJqcRoHemgEeq5ojYpYbdP+vtyRkCgRnhtIflq56NiSNLPpaI2nmsEaljdE?=
 =?us-ascii?Q?yotJjPfK8eUA94NyCFjUMUWSyMzCCtmawNNHNmOryPXelLnFRu5l11QGCLMC?=
 =?us-ascii?Q?5mJP95kdPMm5rcv9EgHPNsnTiZhibHvAbOxzD7RWVDJJrSORhMD0qU1RFXbE?=
 =?us-ascii?Q?osBxjPzqfPa4Ibkg7dxUCkzwuLSEa1oAzAKJLa7qEBDOBjCiVwRsRRFxEdwk?=
 =?us-ascii?Q?0pp35QlebIE+6tZneyfhkcXAxw05KGqOMr+4WcEq0RneSzmusUQ0AO6er3ys?=
 =?us-ascii?Q?3LX0rWeQnTBBkRXTms0tYbcq2lrC68rC1gnx1qEw9R/NVUxPIJUi8sgsqlPg?=
 =?us-ascii?Q?PZ2nJaJdrDqA+H4Xwn8qeVWti72C9oFcYRe6aXn/2CMBMf3uq9KXwzQfxSBE?=
 =?us-ascii?Q?1k4ZfeW41MLQPP3xD6+jskhDhRoDGaJXK8OsQ1xq+JIgHa2bDvq2F/5n5i7k?=
 =?us-ascii?Q?7HuSSZHVcTkgD7eKNQd0q2XRpTpeopgpzENl9KD+LKGJyASG71xTjPlBFudG?=
 =?us-ascii?Q?++qtn0ZIhFdOjsue/aBCbeJazoF/bC3LE08GX1LcdLcKVeEUgKFys+hTyMYr?=
 =?us-ascii?Q?/1O9THN12T23K+aaqKaoh9t4VdnIFRdt2Ti3axMiyUWIOeh23agNdgJp85Q9?=
 =?us-ascii?Q?734mdxM6vKggH5mkeNDnKSqY2FDFhQKno6+0yDMacivbJBmoCBVrUW3qJhPU?=
 =?us-ascii?Q?KDg1jIj3FuC/3oh7t08J8u0Nu/sn+sgnPHGI3nt854Xh5YXNUis30/c/fjDJ?=
 =?us-ascii?Q?RGxCNxaEHeHgFIGEBmo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:48:05.0051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26abe3d7-b941-4001-4886-08de503e1dbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042

In order to use EFI runtime services, esp. ACPI PRM which uses the
efi_rts_wq workqueue, initialize EFI before CXL ACPI.

There is a subsys_initcall order dependency if driver is builtin:

 subsys_initcall(cxl_acpi_init);
 subsys_initcall(efisubsys_init);

Prevent the efi_rts_wq workqueue being used by cxl_acpi_init() before
its allocation. Use subsys_initcall_sync(cxl_acpi_init) to always run
efisubsys_init() first.

Reported-by: Gregory Price <gourry@gourry.net>
Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index b4bed40ef7c0..a31d0f97f916 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -1005,8 +1005,12 @@ static void __exit cxl_acpi_exit(void)
 	cxl_bus_drain();
 }
 
-/* load before dax_hmem sees 'Soft Reserved' CXL ranges */
-subsys_initcall(cxl_acpi_init);
+/*
+ * Load before dax_hmem sees 'Soft Reserved' CXL ranges. Use
+ * subsys_initcall_sync() since there is an order dependency with
+ * subsys_initcall(efisubsys_init), which must run first.
+ */
+subsys_initcall_sync(cxl_acpi_init);
 
 /*
  * Arrange for host-bridge ports to be active synchronous with
-- 
2.47.3

