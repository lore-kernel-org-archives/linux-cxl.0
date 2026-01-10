Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE63101DD;
	Sat, 10 Jan 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045685; cv=fail; b=qYilTEGHvBn0sUzEcAQo42/jV4Y7Uyfdt8m4asIDE6USl27Va0+T4bR7csK46pFCquAKFzGFQMaw7cVXvwWr3hm9o5jcooHi1jz8EsiqLkzF5cbPdGotyhpXHxuY4Savb96wSHz7wRZXnhxfh4LdpUwaDShgi0JSmXuN1IyLHOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045685; c=relaxed/simple;
	bh=05wJI6lhyUz9iwBIepTaueGsVLX2Na22ym+TnlLKt0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPqhqCaamS3CVgl0K2+mQM7vGUYwX0ssbj9U+6hDIqdrP85I8pifvwANPZyFa3OXOHLSwpYHBSTNd6dqP58rhZQ9+wh9C3mVYxCdBg3/O8X7eltSc3XcefIR+vrP2zZdJeQbuSvBPsoVQXtRBjAqoF5cWFLOaEO8BtiUNSx59xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M7y+ZTyV; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M7y+ZTyV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GexGlUnRt+1iSyjOvvHy2jW9ciDkgqwouKoZ+cFrdHWeaSHRXBT1Uko9X1n1eLQxYlGlxO2HjnR4rB/bZNQy7gQd4pHtlBMGAC1DQCd+GknJvOz/mwoxJu6nMu4hSoZ36JqKomddoEZ8ucFeoPo5vOsAvIHzZ3rsAY8EtfSUklmvCKasK89Vj1EYunVNFSe8npWyEqWLv81rnoqCJ9vW3h+YnU1fbhbqcAy+BaEj18XcdgD44mOld5gcs2NybD8UpEEN+NYyAsJvvVIJhykUxkbVWKl8jvfI5fT1fTK3jN8lC56JH6BwnfsXBbyzGtYV5K+SlvgHvj+gfNtyGaWsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/JfCeqJNEgyfyaR+ts6GseDqfj857h5TPCuIeXhUxM=;
 b=xfXkBkrsJq/RQJYeFaaHAZ7ZlasFjNl5r6SW+tHkYrh078qf6SmQSRzS1BI8mdZFWmPlBTFFqR2zL/RZyVRYUUpgGpVlZvzN+ijPmnwaoinlti+L2Zdwyl3d6UScuWnUsITZ5zVlJira1jUYu8Jp7ufjvBqKqM2R8Z0EKGObQXYDlKUI6hs8wZ62fekacSGmuf8RfLiqZR9e63iHVZ2MP3ux3egtu1dlt1t5NI4y/zjvQ/geewI+wPaIQe11GxFWOZVwYt/1Lg8lpK/9nAAYT2QJmhDcUdr3zuiKVWfhupa8e3g+LPwxsPu2cBBAC4yZE2f1fjHm8z6Rnu+Sv0b++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/JfCeqJNEgyfyaR+ts6GseDqfj857h5TPCuIeXhUxM=;
 b=M7y+ZTyV3zgXCVJbu3nOr/z7V4VZMUSvOiiIj5m2Q3blpOEyoH0k6SjEOImyd1YnOapBt8UvMGm80L3SvwqeLV0iaO5VY+4e2FpSFREXEh2TRyTE4mTriVtkblxD2C3CfmVbHLJiEmmxUGj+Pf3YSKpwW4DNhB6CBk58tHzKvJU=
Received: from BN0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:408:ec::21)
 by IA0PPFB6B4D32F9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 11:48:00 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::c7) by BN0PR04CA0106.outlook.office365.com
 (2603:10b6:408:ec::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sat,
 10 Jan 2026 11:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Sat, 10 Jan 2026 11:48:00 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:47:55 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 08/13] cxl: Introduce callback for HPA address ranges translation
Date: Sat, 10 Jan 2026 12:46:53 +0100
Message-ID: <20260110114705.681676-9-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|IA0PPFB6B4D32F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4136f6-6762-470d-d4a8-08de503e1af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmlIUGJvaGFFenVZYU11SUM0eFlMRTI4cHp3aFJaV25yRUoxVUJmUjF4cWsw?=
 =?utf-8?B?dWs0S1NiRlF3MVY1blZRTU40cmZEQmFLL1lzdXZ3ZzZPUFdNT3pmR3UwZkFz?=
 =?utf-8?B?YkdaNGxJOU5meWt1WjdxdkVDMWMrb0lwcTJKTHJrdGpjalQzWlZtT3dOU1Vl?=
 =?utf-8?B?RVM0Yjc0ZFZ4RmVDcW1EeFZNM0RGRjlGZnUzYWlWbEZxVmQvVG1GYnF5OElz?=
 =?utf-8?B?V2tiU1hUTkdvSFh0WTJEQUtYREZWaElCTjE3VVV5UEhvSUVEb09YREVKbExn?=
 =?utf-8?B?cEJ0Q0FRSVFmTE9pZGNrVXdPNy9oMWl0VE5xTnR3Mk1ReGtYTUFMVkg3bmY1?=
 =?utf-8?B?anJ4M1lVSnJ2a0E4MWVzU2hhYVY0d0NSRkRpbXRhanRLSVJqZ25zMHlKeU5l?=
 =?utf-8?B?UmRLZEk0c2d5SjJiZW8xZzZJemlyVUJhc1RjUW1kRlBwQmRLaFc4VzVwRS9T?=
 =?utf-8?B?RGpjbklIR0dRbXFKZ3pTMUlHSmQ2MlRDNXJQN1IrNHpNNjg1R013aUkyYi9o?=
 =?utf-8?B?aTlKK2plVEUrSW5KYTRidXIzV0pORTZpT0NDZUNOUDFTeGx6M0tYZ29zOWh4?=
 =?utf-8?B?VFFxcUppNUwwV2piQ1psRkdaU2V4bWRNVVVMcDEwbkpIT081VG9KUDBrbWtH?=
 =?utf-8?B?ZGptdlgvMDEwOFF3OEhBS2NGMXNOb2FHZHExSU5WNDYrM016ekZZZEZCNDha?=
 =?utf-8?B?SGMrWkhEejZBSkJUQzRDcWxQd0FmV2hXWlp6MjdsL1VSQWZrQUJOSnRsSHNF?=
 =?utf-8?B?S1YrY096SUNENTRVZi9LUSs0RzRsQ2ZJTHdFNXZXay9Va2VFU3R4MWJtWnRh?=
 =?utf-8?B?UGVpTERaNE1BWWlaOUxORTRtcnRtRGttK0paaVZ1ZEdCRHpWSzZnK1VwbEdu?=
 =?utf-8?B?TEJoNkY3MTJ1cCszUE1mRXptS0FkSmNPMGpndTB4M1B0U1ZFS1kzSXB3cFgx?=
 =?utf-8?B?V3d5dzZSeUpIcWF1VEFMSnl6QmVCUUk0UGhjdllpN3NlUUlpQU9vU3M2Zm1i?=
 =?utf-8?B?TGFEWVd4QytnNElSSXUyK0Fsc1gxNVFFb1JWSXR0MkZRNEI2QXdFZERLVGxQ?=
 =?utf-8?B?WkZsbDdqaTA3T0xQRklSb3Z1Z3dPcGRvck03YUtQblpsWE1kTjU3cHM5Rmt2?=
 =?utf-8?B?OVgwZ3lPcDJpdExYRDIrWGhwUjlFUlM5bEpmVDExN2Q4K2RGZDlyeDMrUXI5?=
 =?utf-8?B?OTkxTkd1ZUtBNU5aUDJzWDc3K2ozWFdnSUNiK0JMS2FyN00vODhuOGo1clJR?=
 =?utf-8?B?eHJKRGkxVHdidTVWTFhmNEFZRWJLaTk3QjdCUUpPSWxkcjd2eXBqWlZ6Yloy?=
 =?utf-8?B?Z09sL3lhYU1qZ3pxaVpwWmgvWVhjaVg5azQxVXpwVUxENVlTcGlpaDZNNHZB?=
 =?utf-8?B?OXdaRjQ0bW40YWo1eXorVVoybFJXYnI2ejZObjRBK0pPdTN0SXQ1Tk9Samlk?=
 =?utf-8?B?WjRFWUpXNjZ3TElNZXBlM01yOUIycGRpTC9KQ01YNlhGM3g4UERLZDFNUS91?=
 =?utf-8?B?STBZeXB3MC9odzBZNVJNd1ZyWW9TMkR5UEM0K2ZCZXJmK3RoZlR3aFFGQkQw?=
 =?utf-8?B?RTBhWkF5Vm16YVFCZVpQL3hrcGd4d1BLbEc1Sktkc3hJOU8rZkRrSG1rbmxz?=
 =?utf-8?B?U0ZPdUcvYnZTZ3VVeVkvakhoeUlXTG02ZFJOTmRhNUxrWFA0dmlSWDAvby9D?=
 =?utf-8?B?amQ0dVJnSXlKdGNpT0ZxQ0RlekRGQnJjbDM0Z2ZYWXJrWHBOMlJkejJmL0FG?=
 =?utf-8?B?OWdaMi9aQWx6dTRxeTJmWk9BTnNrWGpQaTNDNytSYzlWdnRMWDVlWU5sdlo2?=
 =?utf-8?B?cWZCaC9LdElLNUEvSG53aDB0VWsyR05FNHhCUFVtV1RJV2VoQnFMZHpZTUhC?=
 =?utf-8?B?ZEVmb1R2WnFxME0wOGQzTmRYeUFoZmc1cTlaK1EraFErNE5ydVo0WUJka2dE?=
 =?utf-8?B?VmFFMzNpbzFEck1mZkpkRXMrdGJUR1pFcXFkQzkvaXFJR0x4U1V5MDdSb0N1?=
 =?utf-8?B?akVlV1RjUWlTN3lncFMxaElGbjVTamp4OHpsTGh0QUg2dncxSHRxY2xtcHEx?=
 =?utf-8?B?QmZQbGJyN3dCZEtBNVA5eDBLOWN5aWozVyt3dlNsL0dYZ3hZQ29SQ3F5dFdQ?=
 =?utf-8?Q?Akvw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:48:00.3402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4136f6-6762-470d-d4a8-08de503e1af7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB6B4D32F9

Introduce a callback to translate an endpoint's HPA range to the
address range of the root port which is the System Physical Address
(SPA) range used by a region. The callback can be set if a platform
needs to handle address translation.

The callback is attached to the root port. An endpoint's root port can
easily be determined in the PCI hierarchy without any CXL specific
knowledge. This allows the early use of address translation for CXL
enumeration. Address translation is esp. needed for the detection of
the root decoders. Thus, the callback is embedded in struct
cxl_root_ops instead of struct cxl_rd_ops.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 24 ++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 912796fd708e..ed8469fa55a9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3483,6 +3483,15 @@ static int match_root_decoder(struct device *dev, const void *data)
 	return range_contains(r1, r2);
 }
 
+static int cxl_root_setup_translation(struct cxl_root *cxl_root,
+				      struct cxl_region_context *ctx)
+{
+	if (!cxl_root->ops.translation_setup_root)
+		return 0;
+
+	return cxl_root->ops.translation_setup_root(cxl_root, ctx);
+}
+
 /*
  * Note, when finished with the device, drop the reference with
  * put_device() or use the put_cxl_root_decoder helper.
@@ -3495,6 +3504,21 @@ get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct device *cxlrd_dev;
+	int rc;
+
+	/*
+	 * Adjust the endpoint's HPA range and interleaving
+	 * configuration to the root decoder’s memory space before
+	 * setting up the root decoder.
+	 */
+	rc = cxl_root_setup_translation(cxl_root, ctx);
+	if (rc) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s Failed to setup translation for address range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(rc);
+	}
 
 	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
 				      match_root_decoder);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0e15dc6e169f..8ea334d81edf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -652,6 +652,7 @@ struct cxl_root_ops {
 	int (*qos_class)(struct cxl_root *cxl_root,
 			 struct access_coordinate *coord, int entries,
 			 int *qos_class);
+	int (*translation_setup_root)(struct cxl_root *cxl_root, void *data);
 };
 
 /**
-- 
2.47.3

