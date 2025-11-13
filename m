Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5533BBCC;
	Thu, 13 Nov 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032555; cv=fail; b=Y1SXI839Yw+j41L2DrJklZd3/6N2iblghYOVqpOWsheD3vZ14IVNtxAVwFe28MNwFU1KtePQosoXc6R1aH9l0f/IAbrcraFAPyI+Q1evXXQ+pQjlL8xxtytnd/2qcpSn1JxOjArRcJ8utTFsRA1d4H2ZL/cVR1Q+fWtXI6BBpDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032555; c=relaxed/simple;
	bh=WItC/hG5rrxfzjRCgIB435+TTqUfAGWD55SatRNdhBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7G8eMvsxav7pvVGkwn31gjKbMDcqZ/av2tg75galJGk5EDyaSt5JXrxQXK3beMBvzaX3g1nAoPnMrNes1iNJ03rUTDYGQY//HB3yD0YC/LPB2qagyXasDhdLVFg+XHVJ1s3gaX0eFBTNZcF2HZjwuZQqSX/1qpxSCpFp28mb40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UeGhIUDm; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UeGhIUDm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlaQpyh2NuabFIMIuREsTmxcvFDyRdJ1XIsgsoxa++BwuRVowlAAuTnzzd0f40lMNa0rHN8tkORzsyBTBkhCIfxUVA8aphvcXV0l3r9fCpkUo953iKJsuqWVFX0xJLPgPj2SV6F/F8C7fDKQHE+hUW/gVCgaZLd6379mKh2NwRV0dTlw/YpLQI0kiZ0JQnImoFJffy3Lptj49wSGmWBtpL1blKxCy3zbHj86whOFwnkGDP5/zMgcWqNDnqnS+onOb8J5jG4vkkcFL1l42/WD1OhBQRBhbjPC32AqmtHX1Om/acyyaJe1RUzUn1kXhJ8J0E9dOdat5H2ZepTLSzp57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63Pofpz0696zaHZEu6dehAsi43ddkmPTZwmSw5SaiaQ=;
 b=Ktxh+ivqjcjHXTwRNJuc2Zrf+8X+JBC9Zjb3cIHZ/D+dyK84kBnogYgtmbJTYxILScS00m4/lyP6GfI3+ddwGINgn9mCO54ITiTC66st2gKKp/MX5lH0jHRceh3flEil9ntylTiHGkken5Aca/EGkKTlUTv7qZf0iy9Lu/jl35L/0ikBA+JRCVWS2IILelUSpj15a2DcyjRBsH+p2q7sgo+S9tya0CpWnuim63Dm68Le4EL9Q1/R+zva55QhYFbQ+TUfCFNxoATYPht0zKSmXzUC9D4mw6KmywX2vIw0A34iib6y3oiHhfLdbSSaTerg3Mg2ePGqahUHWJen0Qrbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63Pofpz0696zaHZEu6dehAsi43ddkmPTZwmSw5SaiaQ=;
 b=UeGhIUDmbmOy4uYi6yIk0cBxMyYCfJbQwOleQpO7hXcEx+cs4sLozh4nBoh1+ws+iwwM0yi1HT6EG/GsCisvy5OqhQH0nMsGBDMt06nNWbuLYKkqH67ovKSW0BwCSXTx/9PtcZvHo/JfoNe+GnPyGd/GAv+ZOUWLXNvYT+AusRQ=
Received: from SA1P222CA0187.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::14)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 11:15:50 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:3c4:cafe::da) by SA1P222CA0187.outlook.office365.com
 (2603:10b6:806:3c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 11:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 11:15:50 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 03:15:47 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 2/3] cxl/acpi: Group xor arithmetric setup code in a single block
Date: Thu, 13 Nov 2025 12:15:22 +0100
Message-ID: <20251113111525.1291608-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113111525.1291608-1-rrichter@amd.com>
References: <20251113111525.1291608-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5d36ee-8eb4-402b-e5f5-08de22a600c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0f2+IoROmAPbWJyTtSNim9Ru69or7TmUVfdiUIXCmsl+u7DMhgdauM5m6qUB?=
 =?us-ascii?Q?I2XiCYPkOTWjryqZsXeWTRke1adt2DZfjflsuK5EqhKsygewaNC/4Yu2+pbh?=
 =?us-ascii?Q?nTG6znSdjPgIrIVW3+XhmAwzq1mtcuOoN5gQMK1JUm+zcTfD9kscjz3K9+8Y?=
 =?us-ascii?Q?0lMcOeU3hE0CGre6kjClNplIIg+5292RZIpaA2BTjxsLsdUKdFnemGf7zP1W?=
 =?us-ascii?Q?Ul3DXMA1EyYtigywsPPe68tW8YiGlu0seRnxsTdkUzipMASDPAb4fkyYei8w?=
 =?us-ascii?Q?7TUoFrl/k8b0HfNn1zrfrZwu4qIipxxh0t3VF/DdF4qeuYtbTHrXxfVQn/9n?=
 =?us-ascii?Q?heaC9TrY+SJrDdq6ieYP6YQiUEifrUctFVgoFnkWW8rZVYmXVSdIJzeqjQRn?=
 =?us-ascii?Q?kJmht+boRymA0LD9xIlJBXK7/564BkBZrxkRLNLZLS1wP9dn/wnDHjgYyPmN?=
 =?us-ascii?Q?GnIbYMWGcXPNijs3T0edgTYuspdxE/HMNJzyibVg8Ybj7im6YNwRzBXxey9k?=
 =?us-ascii?Q?K7aMdwpqZ9wb9BnKhEgyOj//oFXBA5CZMYXdn//Ib4wewlFkCRo3M9CXRyBi?=
 =?us-ascii?Q?IzkfAYCzNBX8hTlbxN/QFBZES4JuV8DFDGhUepsGy5iOF+oT4m/gm1BXk/z+?=
 =?us-ascii?Q?Y38wuwJg6JMUtb9kuy9FebfsjDCIpwoLcCGtwlTTvoUrYKhopnWkz9Gp3MlF?=
 =?us-ascii?Q?7v3FeZCyGqkN9XMUN0AZQetFyck1JJLlNN/tdysi8ud1SUpYFT78BU7RoZ4o?=
 =?us-ascii?Q?5hPxgqxs54qXS2Lw5ANxLX1RYlnfU2oDbjuXiKNS9zs4IlGUKyVUDiNV1PUl?=
 =?us-ascii?Q?aeZJImXsevkOijDCTd+zOwr9trdUmE/ZCW2VV74utCu1ZHjn7casAutcOqWK?=
 =?us-ascii?Q?5XvzYTXIOiw+0vmr85hXV4iXxJ++V9FKQt3waTvS/EVnX9p5L8UP+0WGYQq+?=
 =?us-ascii?Q?Fr79AWvlrB++67nLYVMNqExM0CiraVakrJf7NZfvMORW82ADoTxLaxflB5ot?=
 =?us-ascii?Q?tmhy3BRMFn+bUwUAg2m5BHihVIn0yOsCVGryMzi55bFUoIDC2A79B+qc1xpc?=
 =?us-ascii?Q?Ry1lTfKiV7+H8Z3RtdOyOa9DcONYk0S/C85bzAjg6J6dwosRAryL+Qnt8wfH?=
 =?us-ascii?Q?SsJrapFCrTDrDPrvfu5wrtNkITeG3IFvMPf+bk8rwrGwBF3k2FVPy1WMg0p9?=
 =?us-ascii?Q?ZdU+3Yp0qeZ2JPhMr7ACXSpUSak4dtI+lgGsVH1jJoWSQnZ17dHOcpjNroCU?=
 =?us-ascii?Q?07jI6vizhiuXAFhdBE2E4USXYqdVby9ClOBgmuGjLaDIEqLA1YgyZx7ftzK2?=
 =?us-ascii?Q?rfHIB9jGV2+bVY5VfiR6Du29U4veB3cWkp/wdayqjT7yABcz22JWZGDXG/NQ?=
 =?us-ascii?Q?t8L/aA0cogmouaXf/d8eOa57NheZiN4Y17gB8wbwANPxrCU7GVHFyiYHTi7H?=
 =?us-ascii?Q?/gPJC3BPknOLA1anRxpiUZCDGpBUqOjpIgt4iwZVMhPX6fiBsUKfbFsOJ7VJ?=
 =?us-ascii?Q?rnHMWo3TQyh/5a26U2KNcerBpHoEPBbKh1twqVRzu9Pbpln2Q1/fV5/sbdsl?=
 =?us-ascii?Q?lSMgZ7K2uQCFUb76y04=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:15:50.5323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5d36ee-8eb4-402b-e5f5-08de22a600c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450

Simplify the xor arithmetric setup code by grouping it in a single
block. No need to split the block for QoS setup.

It is safe to reorder the call of cxl_setup_extended_linear_cache()
because there are no dependencies.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fab736aa77dc..50c2987e0459 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -465,8 +465,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
-	cxl_setup_extended_linear_cache(cxlrd);
-
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		if (ways != 1 && ways != 3) {
 			cxims_ctx = (struct cxl_cxims_context) {
@@ -482,15 +480,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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

