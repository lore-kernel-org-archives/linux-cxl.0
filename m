Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FE25C6F6;
	Thu,  6 Mar 2025 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279568; cv=fail; b=SYhC4FiYOHkxJjZdfdVcuv6Coie4+8Hk9Iokwvw5ULvNZ6ClRkWVz3CP3YIgskNT5dVq3SGhbhZexBXtrs6xy9N7OfO3bQN9HF/bPR/kUGuUQjt4H5mwM135r+rtKuGB9G31L9A/23JkodG+Wpcy3TqAuzHLsqyNaaL/1VQgHyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279568; c=relaxed/simple;
	bh=q68rvYXccMhnMN9whFw9DLYKUKZJISHBMsSpyc/META=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3+Ut408PBKAVW3eQjM8UUr3ibk/l2ME4LpzhxNLPYKyITmMYNeS2zTnolpQc6LsZyKV4rZgsK5CqPFW64eeceB5mbknGdwe19sbtVnkeCsT9iJQpf8KY24PF1jzYa0A3nUVvmbGRk5sGoUrENwVTHz3k0c+AKV8dXjODRZzk7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C3c4/UnH; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C3c4/UnH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrHNBHuDdK1wFuEoZZOhXdp0iT3b3ogb6QMWTKuBY1KI32q8/W42vXIbiF7LqhQIxNbhptDyfpEb2x+/avs1Y1KOWWNvgxDg0HOfh3eJtPmoGRHJ6+yooPo758IF0zW/9lLSX9TwPX6L1wKFv+mvS+f6SLYniDJB+SQEFJxin7NJA7dxKUIr9BdnZ6v7A/k+teeqb6wumLFQSCOodMIPOOxLWdFGa8eIoiJqO0ALEOYaAHJgksyHtNVz8mTEc85WV9aHM6qRGv8Sn7PF9qIuUJLLL5zbXVYjy94cDCyaee1UUZh2TWGL6uzs/42y/vQcBGE8wMbjwGM+AEX7BAf6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH2eEhoqySD5sLD+wp42rTKAEOvnJqS0yXkr1HBWN1o=;
 b=dxym5Ur3DAYgQdF6iClXJ+7awPiSksQXREIg42I6So1Hw3HfjJn9SJBOoXstYnP5Q2PIpLxvMj1TCbkeU7gg1vZb0kQvs53vSMj5RlukBJ2EAyfPUyp/zOW7benkTqMZEliWq106Wbi3F42l+Npb9Fmj5FJJCgjo/KYDn93DgJOORO1LlVPNeqvblaWpnPOTdxVAZS+Zp7+LtG9ihwoBu3CNYWzkXEGlE7jFeTAScG8bJzOSxJ8llPU3WYdyU8sacgO9SL4YMGMIOQtzVSfBS19pkpbOt7fLIXxO3Vb62E4DZoTcrQdarBsiD/ed1beh8nVkWAPyuefUDBZYd3571g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH2eEhoqySD5sLD+wp42rTKAEOvnJqS0yXkr1HBWN1o=;
 b=C3c4/UnHAYhcs9Xkll4cMFKrTRqsjxyktGHqD1c06xjqF54mEHGlMhaYqc5sS3xTD+Wt7WHiP5NkZFpJ13x8qDNTsBwqmkWWCegky5b0JCYWnfrsyUdFbuDAcvRRf9hfjmxm4CpWqG2DioAdjgGfj9daRGtYrDFBDQFb43jV6XU=
Received: from MW4PR03CA0350.namprd03.prod.outlook.com (2603:10b6:303:dc::25)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:46:03 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::55) by MW4PR03CA0350.outlook.office365.com
 (2603:10b6:303:dc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Thu,
 6 Mar 2025 16:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:46:02 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:58 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 14/14] cxl/acpi: Unify CFMWS memory log messages with SRAT messages
Date: Thu, 6 Mar 2025 17:44:48 +0100
Message-ID: <20250306164448.3354845-15-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306164448.3354845-1-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 90889276-e85a-4fba-df69-08dd5cce615b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t8xkCRvlazIE82uEWG5om0ryuJ+RS+ZpRySAn9yNoK4lumdiC2m0kI6KXF+Q?=
 =?us-ascii?Q?3NHgOWd+2YRSk3ppCVS3cdoMeybPF/eWoFJnBeFqjQlnnBMX7/atbRdPaWhR?=
 =?us-ascii?Q?xKIMXoBeyNjPhVtY4uGkG0srCWXu7Or/qsekgTOrk6TClScQaNTQCyj4D6uD?=
 =?us-ascii?Q?zq89xRXYNjJHQdeRlDgNPCqvTbAe7ns7dviBcsJwT8PYsred0ZsTqTE9LlMW?=
 =?us-ascii?Q?S/NnmkspGVMjf9qvnKFykDHBcJH+ebGYTO152Kkz4FghQ+TdsVSDZEOy4ro/?=
 =?us-ascii?Q?WRLAPJc3BntX+8tBf++kM+ohwlw8wG4oLqFdNgXpS3+Zy5iTOqdfkCRXisE6?=
 =?us-ascii?Q?DuOTzjeJQXgHlr+z67GSJe2lmooUKTKWU5YHrunrb7jpExlU2oxz0qNZavEm?=
 =?us-ascii?Q?cdZo+khruf74mVhMES5i3bJwinqaokfcePUYuhsF5bj1fFZITH1jECaFzbvq?=
 =?us-ascii?Q?Iq8YumSt7pZRd54IbMg3VGjL/w/SKMdjy0B7rr2xVinG2QbRglBPbMwvKleM?=
 =?us-ascii?Q?PrxE2a1ea96s3VP36DIAdyJ0ldduYMEJie7gFwrPsVaPaf5hjOE9hlOCp0Su?=
 =?us-ascii?Q?dOMFJpa6MdAcRXgQD9r6Vm1SDNDPsXywZPRtaWebXhZtgBfLV4tSjHhSyyfn?=
 =?us-ascii?Q?92ZEEDmuVp6wCzvW6L7U8Htj14MyLxyGSrpB70prLT0FHT+G4uwWYN988ih6?=
 =?us-ascii?Q?wN5viA5BXaCAWur4TNFHk3Xq2ztQZw5IoGjzrWvTeK9BlHXJWKJKEq/fEYpv?=
 =?us-ascii?Q?SVC77Zxm8kSffiHSwUsBPj+Xn9VLxSYGXar6+b6/Rx88eCc2Y2/DB567GvmJ?=
 =?us-ascii?Q?jrPGtMhibFr1VGxZ7UuONdZdyJAIaCmWodvmDK9BmyO4dXTTQLZVuxovqBbr?=
 =?us-ascii?Q?qLR1XOVLNIQ0ybY2ZNNUaF5lYnQ6NDbS/vCV5S/fBhNG50cuJx1FeQnAAL7R?=
 =?us-ascii?Q?LDzl9pLss2sF1WKDCJwSUJXtbScApC9FxkooW4+RACFLL6GSQRANbtkVh+Kt?=
 =?us-ascii?Q?XREKVnL3m235nODe4weQvJqsFFnSaOrCg31bhzpeBg2a7Qmu9fbscRABsWrq?=
 =?us-ascii?Q?q56zPRRs52gZoIVB6SkEAH3uSGrMfyL+3NB8vFCqBYph02iEzk9rlopWya1q?=
 =?us-ascii?Q?tUaoFGuIMtpxKGHbPW3kZ6uPmEbJwn9OrnS/fzEPMobbnXzpsenaLF/m/m2J?=
 =?us-ascii?Q?FelxGgsRT0WWaOJfS0ms/p+Xvb0vmqRmz6Tlyz+7mWU7ZMEidCPmWJErjybM?=
 =?us-ascii?Q?PbMJllVoTkBUenuC0ZKH/jGqpVyn8YLflBEWMNRX6NkOEh49DyF0w6RdwlrA?=
 =?us-ascii?Q?EC16tdzixNq2W1PEjyW1PBa+0JpbzkFGMXFwlMGyjR5QmqYJ9GaXls96MS5F?=
 =?us-ascii?Q?lAAK8/Dtg5Z3EROkIPuP0/5mwA9FXYfyGKKC6nBw/hP2a26uj90bRpt534jb?=
 =?us-ascii?Q?WLaiNIn0yj7M1yG6DUovYoc/dT12zD3yKfXCRg1JtEM1xvzG/2vZHvj8m4xM?=
 =?us-ascii?Q?eFkSV2ePzXaNyhc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:46:02.1188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90889276-e85a-4fba-df69-08dd5cce615b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402

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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

