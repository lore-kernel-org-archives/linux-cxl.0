Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921E1F4E5F;
	Tue, 11 Feb 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267730; cv=fail; b=LBZIWSEqSdY83Dnku6n08ayyUmwbv8z8sRNZrvLWXNui0Dw8Cq6W53Iybrcpe5nunbiA0NCadvT+Ao3A1+eNDrHWzLMDC3nxBygOnhj0MdD2Kusn6t7w7guqFZEDBt79YfENHjVqvsTsb2nipz+xtrPqNAY34wnV7MosFINYeV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267730; c=relaxed/simple;
	bh=1kVylbdxdkNkBTiX6QnuectspACoYt9+1zMeWNQwH4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8UgBxIfHDBEHpe23CuxQfLdugnSjQdN+xP+SKJRsXZBNu71Xbpy0f4rVSWAfSr+va37qVBboB7iZmj/aCK8U/TWnrjxM4o+iIRkGHHPe61M+VSZ02ljNTv/Xmf2RRJHKjsYjelJQHb6g8j2T1179o4qsEktNg1C0KUSErgaxck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qZ1O7f0/; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZ1O7f0/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMr66qjw5wssJZ/GwhL7GMzlaRa7vERb45s2jORNQj9CnET6OaKBnE3XMg1la1NbH+YAgKq+Jc821wnZuK9D10VovaoGqKwVxuPwKU3j+DRy9Si4102hFcyqjUSdf3L249EAF3wnGqm+3VJ3lCnDgTpXlOPI1wnol6mtsOHPwzaICNZRK8zT1iTkV5JEEj6hF+G4VBKBjtZboPq2eTxbPjSp6RqFf3a0NdKKnJjbgeAWYCBvWbGnceRsvpIJdDEDULIugXT0DQVZmT8ZMWEyeEZL0Qcy/bPVMLCo09UGg4LzucvPA+k4n+JFMf0Jh1gRGk1+bAJ1AS3+S6T2ABxezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzXV2rnwBqKKQY2rRJbtDQaYsk3OKUNOB3yeZ02G70E=;
 b=UkL9eHoH92Of6pxA8Qxe89LK9rSljCjP0ZhLDr5WJXnkqb2g1/tSkPGcP5IVQbW+nxrNsZclsHBTYkpSmcU3ZqACEbfAQ9KZZKBTjgaUMoCecrmbqw0kijE4M1+vzjcHpn9tIa4Cvi4BXpRkwnwO0eLwo1B8fAXW5ymahy8TkN/0MFpxf8mdZii9VdyY6fU9q+4G9jDg/mxYBVg/W8cpOXqWTOLpm1Rdi0TBN1GIFKHmQAANgfx5DC7WiQ416jsV+SmeiJVOHogBd2bEPrWA0kg8DGeyBvKhqUHivsoOhEY5eYV8IA7z2zZCSftrQXK6Ec6d4AbFwYc9uNhVLqsH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzXV2rnwBqKKQY2rRJbtDQaYsk3OKUNOB3yeZ02G70E=;
 b=qZ1O7f0/jOTlvycjjcvJBxmeqEsfabl3tKKz70QhoriuUsmnd2WG4VB7l/2xM7GeqY6UJbUppVprHh3nkdZlWAg6miz2zpmedjvPDNYcXf6/lapZhUJ24g6t7lHfOON9ry4cmh7Nq9Cd/bq8Vw4d4ThC8+42aY/mZphgTfAblKw=
Received: from MW4PR04CA0245.namprd04.prod.outlook.com (2603:10b6:303:88::10)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:55:24 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::18) by MW4PR04CA0245.outlook.office365.com
 (2603:10b6:303:88::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:55:24 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:55:20 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 18/18] cxl/acpi: Unify CFMWS memory log messages with SRAT messages
Date: Tue, 11 Feb 2025 10:53:48 +0100
Message-ID: <20250211095349.981096-19-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: fdae945b-78f6-4b15-e9a4-08dd4a82346d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8kxdX897lqOYbETey6DAV5o7XXJecvDbUS1XCYywmIQHP4fwWzykoTc/5+Kz?=
 =?us-ascii?Q?7jqowdmRwFg/73NDJ3mPGbSRKESf7XoigLJYnpQQCZwBJ/SukEPNFBzzV2l9?=
 =?us-ascii?Q?M2RwydSF1IXtoFNv7/Jeeod7mYNVT8nKNcE2H+stcX8Ou6elDw+B+wDUWqi3?=
 =?us-ascii?Q?cg1YoZun9oK7oF7rMyyBFl2FlpfGrWFnfBAI4TK8Z0okE7MNFp1qatYoxxU2?=
 =?us-ascii?Q?WSlvPuKUYZwVeyWP4erLrc6Ksy6xUoTEKTbSl3XpdL228+Mc4WMer/gsRz5H?=
 =?us-ascii?Q?mVqjhQFnWgsnqyBhG+vmsp5TY5tmh7kqrSuUn06sPIoWHbqfoi7w7SA8YkeS?=
 =?us-ascii?Q?ssHVFiQwAw+2zAj/MX7iy1lYsQlPoLNHszlXusDpbfAbgqAner1wx4oz4jwa?=
 =?us-ascii?Q?D71rvMaBrSJn+3XLf9vKXFE8gWmd8NQr60hYTCblzXjmDfAXCKC0N1wWVSZM?=
 =?us-ascii?Q?zcprvgAV/YwJpxzckioqVvuZt0F9VcGFRVWpQ885dWL+wA87XvuIB3ihxnNF?=
 =?us-ascii?Q?GDKDIdfmd2Elqwee2L4BzcHD6smtCLPJR3K/dZ2suTuzvJw/6DTkQTMXe0Ij?=
 =?us-ascii?Q?KDIbUQGslEqsmHhRDcQCmngIPfHCypBj0eKnAln3/mg+Q5eszOXzKa4LY+D1?=
 =?us-ascii?Q?Ma8RHzFYef4SL4AwAHyleJaGDOnLV9WhVf/SMOveYSsIWjLvKun2OEQAA+mK?=
 =?us-ascii?Q?ySqFHX2vXAOBsBp/nl5t8fCumLtugDt5nIkBb+1GJDbUBSq5cgou71VrvpGc?=
 =?us-ascii?Q?Nm1uKL0uKE8L4A4xAEpJGtPim5fQvrdPyHu+juGhSbDYEERPgxPqHi+x5k0N?=
 =?us-ascii?Q?pITFQ6Ks4XURhyRKDfgLL6DysOhUebwhox5Q1ZCcBlV1pg2oyMmp98jKz5Gk?=
 =?us-ascii?Q?GKEb03eXduZPpjhUpTddxW4xDEpYR+E9qbNqS6F8Dc4hS1yoRR1NvrPnnX4k?=
 =?us-ascii?Q?atvwyR6jTIHtSNqRFyzvbZKXzORX1Av8eAgcaIXfb1K6j/3IeJWXDnBTAXAy?=
 =?us-ascii?Q?tu6vO4LcGJUAesPlkdcty52M2Qctl/rqQzhEnxHvX8XdwX1FJn3dwxrMpCkh?=
 =?us-ascii?Q?7hoqS5ou1MsYua46KHkZlij3uzbKLWaVELBFGUb2pYWIScBzddG2CMCUN1td?=
 =?us-ascii?Q?T7DEwb9Q8L0BxknjT6R6GWyZktXXwGH1zgfkulljjZ9vlgH8mkLzXuycsSOU?=
 =?us-ascii?Q?S9hzokjrDII0gvh7UMeX0JzOVyXi9F0jeBrfpw9tMb1BnXCUQk2xC1Na3SjR?=
 =?us-ascii?Q?RPKrx1VyUipBLcEUiOQWa19PvPSPD7IpoD2jwV4pSnYo2KkA5X5j7341mLUh?=
 =?us-ascii?Q?L89VzOwQpnyiTm1UlYLTUf5P0Xk3ubU7sgDdtvncSxJHX3IXbvWSiEbtvng6?=
 =?us-ascii?Q?mxnGBAw824rs3tG3gs33hEjNP4qVmOd4fIGUoDfdtys5M48jB9fQloGRll0P?=
 =?us-ascii?Q?gX3vFjBEpW1mrdAj0GjiCCJEUVGMBwNzmGjFyTj7wr1lMgDMId9Iu+ICqgbn?=
 =?us-ascii?Q?xj7S3FAOMSEsgTE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:55:24.1363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdae945b-78f6-4b15-e9a4-08dd4a82346d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753

CFMWS entries have a similar importance as SRAT table entries to
describe memory regions. For CXL error analysis and memory debugging
information of both is needed. Unify output of both messages to
improve logging. Change the style of CFMWS message according to SRAT
output. Also, turn messages into a dev_info() same as for SRAT.

SRAT pr_info() for reference:

drivers/acpi/numa/srat.c:
  pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3e75e612cbc4..93c73b163c28 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -447,7 +447,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 			cfmws->base_hpa,
 			cfmws->base_hpa + cfmws->window_size - 1, rc);
 	else
-		dev_dbg(dev, "decode range: node: %d range [%#llx - %#llx]\n",
+		dev_info(dev, "ACPI: CFMWS: Node %u [mem %#010Lx-%#010Lx]\n",
 			phys_to_target_node(cfmws->base_hpa), cfmws->base_hpa,
 			cfmws->base_hpa + cfmws->window_size - 1);
 
-- 
2.39.5

