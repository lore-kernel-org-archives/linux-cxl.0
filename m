Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D5325702;
	Mon,  3 Nov 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195797; cv=fail; b=EdCHfxR7tUL21TLJG1/51ICynJmqgBftRKFcxwNsyyjhs1Sr9hOpOVihO/Rj0d9tf/NMaqverGZonoDYuvFXuu8JFZx/WehAYWUlN8iqftP7XiGoowWntjD96QKtRa9YaucwafPCJUy8XRv25bHzJZWVjFFUje5RlYpBmrW1Fr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195797; c=relaxed/simple;
	bh=+/hzSmAVDDzzRU9/R1hGnKy3Hd2JwRyI4/wLJxnab34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgKKMfe+RF/K7fiq+uAwyeF1P+UyEYQ7zP9g6A2BnlibAllTIPhYELT9fCdcO1eE2csPKq/In/e2xV4sETs7ldfkHBnwJhNa4oleIluv43u73ofy4wCLURX+sM2i9C4RFBJzwM8UXyLdaM4O9HXdy0+swKL9Xs5/YlB8lYpxtvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wzaoZEzo; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wzaoZEzo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g73BwxtNd8ky1KPL99VpkpVzfviBQwBuZpPLT+g9YF6Ry4WoMriq2ZnibskUrVKzhug6yzEy5JNAedHIz/tDMS0rghqow0L2A47EGHnguANtq0uTgKeV2RzVsDS4Gj//nkhUP7ti6HioFi9ea3BvcXf9cijwYhpmTMPKO/ZsD9uLbtF7h0jf3MiPxl/VNcAeoeCx3n/noUZNAPdjUYW/GGLuZKOaJMEOxae5gRrgsmPKby7Y/gXQS3DQMS+e3g+oHgRJRJf5YFKK2pC+qXp6nUV+BIkvAX0X8d00okp+7Ri2aU1BFTACRxWO87rj7pxgSq5vJgxMiGzMFTqFLt5Hgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83b0yIPEe2ZHcQof5JZ3eXfHPZeUzVXh32AojpnqCic=;
 b=r9YttHiP6w9c10RlcGRN9t3Cy3pAxo4tqePQ1g5X0x6Hnf1O1AOFTQwWs5SLb4RZKCx/TL4yspV+Rl1bUzFO6Hlt/8X+d8tqhuB0a6EMfdAC/EK/maZqNL05CBfwuK2y4NQ2WHLGtjGGe5hGj4PLNWWo2S74OXa6mhFgyb6f55H6mux3RSw8ZXgB1kjHgFjm0kAuBkaDfDOnL5VFrILgoNMfJ1rou3LIMQqSMwvfLZbhL49GnPeo9eOGB5CG1xzUdfSvJa3AZ8PokdGO5BMKTYz4PNRoebePmXzbMv+KAuFINgZHH403vooQZthMQxKSZrVTSJeBLkXvpaL4IdA2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83b0yIPEe2ZHcQof5JZ3eXfHPZeUzVXh32AojpnqCic=;
 b=wzaoZEzoVlm2UA7JimYg4VRnbPBz8p6JCbXQRld73z1gopBw06kh0qRiakIgEyv4HtAJLXXAgFV1c+oIwKr8WvS0H+lne8UUUOY5ahV4wSVqIaJA2YitvF4pO8vTxQZu6RyWHAUoZ5dinPgNETdA95rJ8PtZW3I4FpIcp9cx1K4=
Received: from BL0PR02CA0077.namprd02.prod.outlook.com (2603:10b6:208:51::18)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:49:53 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::5e) by BL0PR02CA0077.outlook.office365.com
 (2603:10b6:208:51::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:49:53 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:49:47 -0800
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
Subject: [PATCH v4 13/14] cxl/acpi: Group xor arithmetric setup code in a single block
Date: Mon, 3 Nov 2025 19:47:54 +0100
Message-ID: <20251103184804.509762-14-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0d926f-ab67-425a-e0da-08de1b09c683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zaL5oGITVdUfJ6E7IN/rasqBkbSA561zxmbA/0imH7F92f8lQbSS/HTG2oxt?=
 =?us-ascii?Q?DLrWN9qxxICfcQRCehFcAQGCkwGAZNsr5uTDf53voQhXpEJ8RGJE+wsbNRsu?=
 =?us-ascii?Q?E9e8N21vfUx1XxYQ9PKm90Zf0PWdYuZ8V7e1RA+K4ryGwT/VHT/+UGqoMdqK?=
 =?us-ascii?Q?QXjjQNpNBtDPWaRgfxS3GJPyWKxCfWbCsKJykjkshdzAE/JuK/PDI+PUazuE?=
 =?us-ascii?Q?EW8i9Z0kUagLUzjEsy3kA+ZAs/qDHI+AQ5ZjH/WmCMypsw6qJjNGXf9VArYC?=
 =?us-ascii?Q?G6mnZ/4gJUjHkqM7+qmXqy9Ud9XAuHaosoowaEwNHnuhmklyI/DkqF/N9oj9?=
 =?us-ascii?Q?Dl0Lx2LtjnkryicIAQy3pc3sGiCsrEn5e6pTa/h6M41G8ftotigZdoPqVPyc?=
 =?us-ascii?Q?5WBN/ay1xbuFKeKNKzBh7YhG9F/dajOwrRy2ruYouJ8S+rUJq+/b1p+PQ6Rb?=
 =?us-ascii?Q?/lKo/5qndmWdCdG5SpsHvsVOopgHtFfJaycBvAAXUK6SAiM/wDIOxMHAJSnX?=
 =?us-ascii?Q?ScxyyIHDGa/omgO44/cRI0+2+xi7meY6fiIGALyvJdwEY3seIuzTQc4FqXrx?=
 =?us-ascii?Q?MxpofEqBnrQohUGPd1mf5P4cG2JtEt1inc3/3mSGU425fhh+ROtMAwuPqXdW?=
 =?us-ascii?Q?Y9deldktURRKf1m6terK2bZ+jW4Gpom9Al8kty2Ez6stZlrj0pX8Ew3Hjz0N?=
 =?us-ascii?Q?fs1C1Crgs00p4cyyorS30ZXHL/TEnd5DEiQWJMXiltTKy9R6qore3PcPuHP6?=
 =?us-ascii?Q?5LBZy+6I+CTjdkr6O8GImcnSm7sN5X7tN1NidSdTAiZtn43X0N+O/iEXqXWx?=
 =?us-ascii?Q?Ke/ugxSFpnxIoh+hT4nbwsawxP94x6+OyzCPBhtjH6PbnxXfs0PuMYYaEtjf?=
 =?us-ascii?Q?61Hcp45m/y/Hn+1/gEimNRgc21sIrOFEj6Eh+V0PfiLnxkFJsnvpvFLG15ql?=
 =?us-ascii?Q?hHtV+fHsjGY0+tuC58HisTYOnTT5HampDUcGigBsn7WlJnCl86HaabB9gsir?=
 =?us-ascii?Q?vN+FWNEDx83+GGcBYsU3dfHKjMXnc+06NTRKenxci9e8CAWwwS9+6rB8AzR8?=
 =?us-ascii?Q?c4xMQ7tkYRmiRyTQYRN5gyUxJWDrf3WYtrW4rpcJrSBeMLreKIRztWpRNgiE?=
 =?us-ascii?Q?pf090YBhCpfLB9EHg6+GJdXtpIU3CeBk431V43lE3p6nfaMLjElqktqKDkDe?=
 =?us-ascii?Q?YqC5CcgnlpwYmcpwsvQqyU7nYN2vrpq3JH9wIzLx3t1ar7sSmS1igqssldNC?=
 =?us-ascii?Q?mE2j+QLGThVTgcPTSvZ8agRE/XjQpbulMGUDgLMlTbEPoYxYXzGF3AWbseLu?=
 =?us-ascii?Q?wDKoxddMNEJp/aBRrgWH0kyWI9YbKhO1dglcu9WI+CGmAHjJopt5kf9YGKBr?=
 =?us-ascii?Q?2ouD7nF51kDfZdgbb0xZG+ez4DNDTggp0UOL0uWSBUKYzhP57/TSIGyhbQRq?=
 =?us-ascii?Q?hzHc0/r3E5muMAqugbMqu+jlFpu4r4vjoE9fR2OkGRwV62qloxL1sbdbSRto?=
 =?us-ascii?Q?R8vV9mg2Tln80cANr8RmIs39ER1jH0Av2qgVrczww5F/oDTbQH8m2SblCZCJ?=
 =?us-ascii?Q?4drEgFHrdMlSRNqfsKY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:49:53.1941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0d926f-ab67-425a-e0da-08de1b09c683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545

Simplify the xor arithmetric setup code by grouping it in a single
block. No need to split the block for QoS setup.

It is save to reorder the call of cxl_setup_extended_linear_cache()
because there are no dependencies.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 778ee29430ea..40894e2156ce 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -449,8 +449,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
-	cxl_setup_extended_linear_cache(cxlrd);
-
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		if (ways != 1 && ways != 3) {
 			cxims_ctx = (struct cxl_cxims_context) {
@@ -466,15 +464,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 				return -EINVAL;
 			}
 		}
-	}
-
-	cxlrd->qos_class = cfmws->qtg_id;
-
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		cxlrd->ops.hpa_to_spa = cxl_apply_xor_maps;
 		cxlrd->ops.spa_to_hpa = cxl_apply_xor_maps;
 	}
 
+	cxl_setup_extended_linear_cache(cxlrd);
+
+	cxlrd->qos_class = cfmws->qtg_id;
+
 	rc = cxl_decoder_add(cxld);
 	if (rc)
 		return rc;
-- 
2.47.3

