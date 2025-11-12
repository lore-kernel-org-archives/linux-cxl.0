Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE72D1911;
	Wed, 12 Nov 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980706; cv=fail; b=WIPFTTeq/FW+a+f7KHXHfu/cGaHU2JrjaWXanQ+DlLNbAJEeumVVUWRtdSkn6xsJX50s0p79yPpr/UAbGhjaZFGg69Rd+RqRDvizJxEByKiJXGADkGl/IgbA81pMpy9Pd1jVDz8GCHmkTk5ujKHlsG/xT44UYvA9I4tRm+8H4Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980706; c=relaxed/simple;
	bh=gN7x0oa+rbBshHwtvs8lsCmY52Uw1jjP/TX3GGggcLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtfpIBmhqLmEpesk5Qxmjq0AeQKlIR7ncOqMBdtEEIT+c4kJHYCPM1djQ7XqvV2pmmF8wcqkCXo6FO5m/m6yOkNQ5k3u+DNqvmZBMc3IZcAMvtNOgvXYbohXmTarjWrmdngklg8qyf7Y8pFM9gwmPZH5sRCPyd++5+lT49XKmdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b7zW/owQ; arc=fail smtp.client-ip=40.93.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b7zW/owQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVnbjoCRiUK1yxV/6/pNeEHk15ddMqdMyqdgcqgctoxMKD2bLU6H3989F6UyHjiA6b4EeOe6zO6tTaQPrLGlS41GFTJI62cKSNK9wGojvg+GNku0wG33uirejHW2oLH4jCfLQGbmmuPInT01/eXpGuedP0pqTVtiQHlnA52pHmknJ7psYuITEBPBzCO1NKxctWuvfOfcSEPNfnQ+OU8VYLnw3Sc+XHw5hKKuvZk1bXPG94Y5YNG1v8umvDYDAXzl6UTU2OE9smLzD3hv8sWBt+JDGFjZht65CPuTrg9JloQlTEagmutoQrI1k+RXIQaew/rk2InUHLHEUSNCkY0mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGrU34xpgctCEm9xcDMNzjwiKygTHHz8xeRzigkvAps=;
 b=kmQCvl1onpTHnHUPn4f8lMluoLafjUwaOvRYVpVsOnfA4y/eSH0sng9c4hvMI0E/HHVFtPQRvHdLmkJfp0b1lvyK4IGWmBrYBSGJ6wntkXBaN6CcZH5UOyJ5zjUNlYqhhNILZWUEhj7Qxp4x2jmkV7U82aXZWfVxBCmq0vHknoVv1G5se534j7LilQOcFPIapjbbjqHvO/lxA3vvNBCbPuwSUMroO6ZP8xnQ6oDb+w3C1RSoWV4QvRmB0dqkRHOaGM72obAK49kFoqw6x7iH6f+JuC0JK1PTzw2r9i2RSZf9wluYQdPukPFeKpyoyOqpVUDavV34jeLNyExJdYowzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGrU34xpgctCEm9xcDMNzjwiKygTHHz8xeRzigkvAps=;
 b=b7zW/owQ/xGLMaQ7RlPu9sLCX4Cqe2/1EPoD9xIsKIUM5hWI4pxQqHj4EURCDhMhxOqHXpvBb9mQo23D/6oowNy0Cp3GvDtA53UGv5GfUv6qeytMhDhZGTzxfgh8UPp3bVWtk2w5QbFKDxCAYwMoon64uLBacKacBV3QQRAUmlQ=
Received: from PH8PR02CA0033.namprd02.prod.outlook.com (2603:10b6:510:2da::6)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 20:51:36 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::8a) by PH8PR02CA0033.outlook.office365.com
 (2603:10b6:510:2da::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 20:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:51:34 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:51:31 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH 3/3] cxl/region: Remove local variable @inc in cxl_port_setup_targets()
Date: Wed, 12 Nov 2025 21:51:04 +0100
Message-ID: <20251112205105.1271726-4-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112205105.1271726-1-rrichter@amd.com>
References: <20251112205105.1271726-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1c5bbb-a794-4e84-d04b-08de222d4473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kre4SVb4QV/+Mhh5V7eDpObdgg+fG7u6Q1qOFekhUq5fGrcrvX2tyLdJpf/S?=
 =?us-ascii?Q?kmwivtSp/cEE2UB/Y6qBoOdiFFCD9xevfLvEDeFKQHXq7VecblN/UOwI+9SV?=
 =?us-ascii?Q?82SuEM4kxXkVbWFu5JmPHONH8ypdTmzVM45twRGGpc4ly7+VlkJd0F+NXY1X?=
 =?us-ascii?Q?qUA5F01d47O0I1iAT3kvrm5uLB3q5wdNKQH/zUUzMpT+MYNr0vMbhKcz6vab?=
 =?us-ascii?Q?/SCAXn0Q6nXbUkzvamBU7JzuewfSQPirFytHjAlvZ8I549qul/tkogZNj7nn?=
 =?us-ascii?Q?e/TfnYLy5jk7fdHPY1Tzqc5KNeV8QoZqjlx2ejaIKg34y0oYE8qiks754ShS?=
 =?us-ascii?Q?rkXYdnPCSwSF1Euz8TdFMO7uZ3oIJW6gm5CybKQCWQOv2nqT8dMpaEAwJ3pz?=
 =?us-ascii?Q?6klAO2QenIUYEvU0ArruX2Yblb6Z1+UuMqliEzEy4FPQh0R9LDlAHRjkh1sm?=
 =?us-ascii?Q?TJxhWF9SyVkah+yc8d4q8sg4uJwi8kNDwcQimyQav3255W97njbO/SPyMTmr?=
 =?us-ascii?Q?k3KJVvySIEIym5/2FUzAq4tRi2/BIe3IIImSwac7Yx5JQWtIYrLHzb5bzzsx?=
 =?us-ascii?Q?/s+W36Mlr0we6TGpsnAgMLle80qWmeTtdFj1On+u0iormEAxAnkC2vnmtZ0V?=
 =?us-ascii?Q?yHWLZS+da5e89Jwia6auEFVX07o2cm81JY72iQ7gi+Ff4rw8We65q+6sTfQQ?=
 =?us-ascii?Q?8IrSEGJoFliBicf3B0dKtJ3GmWz2VQ6rnadTOfWT8lvCB4sco7NdtiChY/Lf?=
 =?us-ascii?Q?V5t1hXglreq9ne+L/X4vY8Fa67NPrUKwaofN5JKu2rCrneU6ItQ8wXovCFV1?=
 =?us-ascii?Q?nhNPeNw9A2Tw9PnWGWhd1t0IVc7UA533zx8DfZf+xxI1OEv1VNNG3qBq9UbQ?=
 =?us-ascii?Q?cPGyYcOp+aefKs5iMUMicQprnJYbI3RsH7PL5BAWnWBHkQG88Cznz2DNfQk0?=
 =?us-ascii?Q?gYr8GY/b3VLPglMpHNFNvDqt1gXoU9jy+3UrmTtexl4oqYJebFe9Zv+kAQ2K?=
 =?us-ascii?Q?Pk9y88sdthtXvjDhD8qKP31ASwvIuKyIo2UTzNIo8qD+n7EaCaYKjGDAFxO3?=
 =?us-ascii?Q?TR22reasdN3BCYuPoAO67v3zzqIPA22XSPx2DrpTnraMfc2tE9FazU4bNV4n?=
 =?us-ascii?Q?a4DxzYiKOiwW09/9CCEAQjd0ZnrYhsUWKAR/EDByTk/aRWkGpqRXdPws/Xw+?=
 =?us-ascii?Q?H7yzRBHq9tHG8EzJ6PabmixYT9fp42khZgzaEf5MfHh1fbgqdbBkkuMt7jwk?=
 =?us-ascii?Q?ckNl9vjXe2x2kR9rEmjkhTLAThySamlJ8nAp43g5jInA+OzbrGwl8tHd5amR?=
 =?us-ascii?Q?49FrO7GhamR+rBvR3fmAbOVfhHUtKJu+IvQNnIZ+5Gw2/UMvr7vQD/73mvZj?=
 =?us-ascii?Q?S7sZIPthmKYyOMscrDcTznZZDO9rZCJB/x1DEgR8bTVfUFSAngGDekr+imcQ?=
 =?us-ascii?Q?A6zV7Mr10DfDxpT9oc+embM8sSHEahL3l5XWOtdJ8uwQvMNAEQDvH/e0Esk4?=
 =?us-ascii?Q?o3eZHUEkw8mDyKM9TTvbZ6bRK0NDcfJQAM0NYcve4a9nlWFsMJUt/Y50qJ1t?=
 =?us-ascii?Q?btvReAEGtqT/3rNHEqY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:51:34.9906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1c5bbb-a794-4e84-d04b-08de222d4473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577

Simplify the code by removing local variable @inc. The variable is not
used elsewhere, remove it and directly increment the target number.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2b5ae5d9a4b6..e577b11bd889 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1357,7 +1357,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
+	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1549,9 +1549,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
 		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
 	}
-	inc = 1;
+	cxl_rr->nr_targets_set++;
 out_target_set:
-	cxl_rr->nr_targets_set += inc;
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
 		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
-- 
2.47.3

