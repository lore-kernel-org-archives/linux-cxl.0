Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127523FC5C;
	Fri,  7 Feb 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942711; cv=fail; b=KdYk21AY+6GELZ7qteMK7w8cjFyNQZlHWjMaT5SQMFPoErpA6x76H/N76dnr7NWdt2nyiJQJT5EaTE3Wsqa5bpWdZGt3LgR+1gg1CaZb3456SJeis7p+zRDvWT5oMMdxppCyjYaIai4xDu9HC69OSXQKNwhvZOxa77Zj+RaBvZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942711; c=relaxed/simple;
	bh=Hgo2mJan26bzpQKhmqL9yTFcJQmaQeLw19Fr0mTQu5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvCxoaNukCpTBsAlWGcSKIqRrP3+uUAWe9T/7831qZVp0phKqBmtoEdS1BxH6cGDB/fK8ZSHdPRRDSM2MrTKm9BQZqKWBMZdD3j9IVPNj1YcUweKdejgbTp+BqkjSgO8nrZq9LmpvziZ2I2rl1gR86S+MA3NYwODlLo/DNS/GSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qNsmpYbg; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qNsmpYbg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vy7oI+bEn2XNDKK3Ui+b+70NoVMONAXetA2BEf5DjyU4RuND2wFIyIjj8taHNeIy7XCk+dNHcjY8R7CeSQmVIfphtOEMRtD94LYSSYmizQDL2ZLI2aMDz4pfVXfcmgPfmYMcY8352g7dHfWIS7Xdv6AZ3/w0b0qrSkkHSGSnSJi4sPTiDRN4I+ueyp2PPGOlYUdjTPQ5e7D3aQuzTPGcFbI/SZ2K3QG3RGYA7fSncH7mgcjeWAErWn37TXxSZvS9wbjRcEzfwHG8ihQ7m6PvyCBekF49nF1/C452UdwULtBUZ6Kkhu3oA0UMwmd07z/KHid7RBfncLPjkfFSZGrzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQRYcZ2CQSotKxtRSZwQlkHx6ZLG1H2OcqNqr0Bgwc4=;
 b=yJh5NzFleGEtFq6UUr+nsUaPeyybtfe/6J7CDXvCTVcnfS8BgpVhaUP5Ed7i+lsGkhIzuM/BdE1GO/yZjCmETSXnsXBD8909PqOKsYlmBaQosbK4Sns+1KbkswUv07NMWZ0nRA+zbzuIqGNAJmVLFI878cQGV3DJREkZ1r09RI9O5vFp0k6plesYP9vQVv0Q2Jadsfkplt6f5vQIyJD6Vn4UqJe0UjOcc9cvdDzPbgo2ocptjD5rTyz4M8cf1NyieUD7TozOfuc7ussYUHT8T8oA/8IptP4w34VBHv7/4RvZ9tU2JOJWoTkAr+PhOaS4uYbVEUL9ez1xGzwyV1MrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQRYcZ2CQSotKxtRSZwQlkHx6ZLG1H2OcqNqr0Bgwc4=;
 b=qNsmpYbgHls71Lmh3Vo++/SNeKv1ecXRyKmbGgbDsKIiJovobEHan0v8L8DpQCPqJR5SFyBAjLES/vjxvTsRx1akwqbjBd4EnCVk/dtLtbFUdYuCBY/sEZFXkBQn6ZangrKnVNwLhCYH99xUz5rHqKU5J+P8JGtRA21avL3ExuE=
Received: from MW4PR02CA0010.namprd02.prod.outlook.com (2603:10b6:303:16d::8)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 15:38:27 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::14) by MW4PR02CA0010.outlook.office365.com
 (2603:10b6:303:16d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Fri,
 7 Feb 2025 15:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:27 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:23 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Date: Fri, 7 Feb 2025 16:37:38 +0100
Message-ID: <20250207153753.418849-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: aae177df-84e6-48b2-577c-08dd478d7760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p5VT/j+FthnCOwPzbAVD38p/qN2xX9pigRNm8DPrK+WX+EHDUoejm5HKwXt8?=
 =?us-ascii?Q?fPRaE97R9ga5LdcW9ZrDZkrrVR7uJQrFyvGXB+Yp02FBIOFzzY/sbmEBWmhI?=
 =?us-ascii?Q?dANJWuv/Ec1Yf6EIgsVUiwE1pBCuwj/z9cu9JHqOuSbFbVOBCUcnWmAHhj3z?=
 =?us-ascii?Q?2JQpT+Xct5bnVxMP++UF9goUEzP9lK6snd5x8YHE2abdmuFDsGsQeOvIp4ei?=
 =?us-ascii?Q?aFz+JyDk8h+Wmg9S12MnAKfijo/4qKexX7DBxC1AWEycw7QLDHxP1prNDGoy?=
 =?us-ascii?Q?7DpjmddfZkvI0LMYj4YmAhvax4G/yzrAeBXlJ6v4/GX0FlpYyMTOgGtGhHiT?=
 =?us-ascii?Q?oWXk8VbSerMpMqC675EJTR3SYMoH536ME/Mo9ttwsUk+DVYFQ6joCbGfMnHD?=
 =?us-ascii?Q?gmfRqd+Lt7rv+mwYDYREgLSkLtJ2eo1GnCR0LYYQMyO3ZlnNn15D3egJWMp8?=
 =?us-ascii?Q?A0IoAKJpzuESNgBu9Pfi3h/oKJzeAhGUnUJKNQJC/Zh5fxRWeJkxULdNjh7r?=
 =?us-ascii?Q?nFL+tDBz1XPYw7E6knciGPxh+F/yWlQh/eArMnnvq6MT4++fHNPlXG0YwCax?=
 =?us-ascii?Q?UhTC6TdzKPLcfeGt5GYH+Spi33eCU092TKdPD5ecSJaOELFR4QoWpGKPEEEa?=
 =?us-ascii?Q?Kj6bX25SJ0quacHk6rloHRYcuTOd3S74EpwBhLIGZiDPkDBAs3bgUvyyvBU9?=
 =?us-ascii?Q?SrcsqMdoW9bkPYunaLF3g5cwE5MLevN6ug2nXaRneI4DYj5uIxDrvTpgPCjF?=
 =?us-ascii?Q?C/wc+fxxmAvLSBNhis+Uf4e6vG+yDOX57IMw4KAeo/n5DADABrUdCJxEz595?=
 =?us-ascii?Q?UkZiDm9Jm0WM35qR8RLx/xRvbxJl8IjfhrMe0LaSY3qV3FeXzIrbciX3jrK1?=
 =?us-ascii?Q?0cFO/apjcghZd8UXGTuN5uf+GhF/25BNLoye9O2J7VJb0n5caBXJQM8isX7l?=
 =?us-ascii?Q?m6gzoTSokW+KnCJIhqzH+aN3+FreOXh7kr4MU5IbyUTtRQKxSw3GPzFDalsg?=
 =?us-ascii?Q?mzDW/PNHQhGNErSzVrlHKllTewa1fn3KZQawDpm7TEWPMq6MHILeUtQk5Et/?=
 =?us-ascii?Q?NT5diq08UZ2Xz031uTWZxzAeHkdKRWDgjvoDe0RdUj74MN6roocUf+1YXfZt?=
 =?us-ascii?Q?VuhBoSmzsKC9AbWFLERcu7uI2EtKLVoUm07FyGbpLA0acjoKVackClmfbcpp?=
 =?us-ascii?Q?CTTz3yCUcVwbl6ciDz0BbioNM8qRLn99pvYQ4TODpCNirBmg91afudUnQCOF?=
 =?us-ascii?Q?R2fSdLHCQY1wDanbHTblzjZIOy5ZIOWt4fUnj33FMOKDd4P7/VDo0T1ML+Hn?=
 =?us-ascii?Q?lffwdwTW5A/hsnV4BM3w/sR5iLgteKxhF1LMSfnqiPytfdEIHKOkqSeqGyfI?=
 =?us-ascii?Q?R3d2HwjLyfdprZaVatltYvOB9nbOM2ETZG2btZZMFlKKhw5FL1qk3Tk3PISJ?=
 =?us-ascii?Q?azQl2RF7vFnPzwqm7wpieJS4rpzaYx3o8+pLzcQbY01qgIDN/wB3fnyRYbVB?=
 =?us-ascii?Q?1esz6nHBoZXmCH8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:27.3679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aae177df-84e6-48b2-577c-08dd478d7760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549

The comment applies to the check, move it there.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f8e22bc278c3..c49efc419285 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -419,6 +419,15 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (!hdm)
 		return -ENODEV;
 
+	/*
+	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
+	 * [High,Low] when HDM operation is enabled the range register values
+	 * are ignored by the device, but the spec also recommends matching the
+	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
+	 * are expected even though Linux does not require or maintain that
+	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
+	 * Decoder Capability Enable.
+	 */
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 		if (rc)
@@ -454,15 +463,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return -ENXIO;
 	}
 
-	/*
-	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
-	 * [High,Low] when HDM operation is enabled the range register values
-	 * are ignored by the device, but the spec also recommends matching the
-	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
-	 * are expected even though Linux does not require or maintain that
-	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
-	 * Decoder Capability Enable.
-	 */
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
-- 
2.39.5

