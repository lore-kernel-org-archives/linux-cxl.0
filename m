Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0449AA20;
	Wed,  7 Oct 2026 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364318; cv=fail; b=lCt25as+dGCWUpsgAbN0yOKCRrK5GPk/S6EXpzJj/p9Pj8B36nUDSeoyn6V8PswCjIRqZ6kuCpqCPMyFw2IJ0d+yOvlpKjSNbBkGw4/wSuRKQZFz02dsU2pc7Zam7MAB6FcDKVi50pAG6EhOO++JgwX00R4s4GFZ4K9YHrE9c9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364318; c=relaxed/simple;
	bh=0MCjkbJvY5HM5rupeadbL87qV+vphwDc3tOh6dNlLCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UT3NI/KLP0XM66az4DL78MU/7PseV+CNEFI34Dq20HnwOYr6p7iwHOU6E4MiqF1N6KFkh+JajnvoCAvLF6yt9HyACS6km0GTaBRxK4RzIWR3OCsFt2364c3eqO6yMSnJFJCkUgCFY6x6Jm/0hkGLX8ONPOEnoYX8aMND2Wg7yxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I4YR7dqd; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I4YR7dqd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emMlfGD5KuAJHyZ/BVMQMDh5nCQPR9dYOxEoZG8Sne8BxwssaNxtdXN3GP4xXoWtg42/R2zPn/fD/xMydcJHSyMaPK8njhQCSjS6Qrz/JQY+weBxD8CvLiWqA1IaOLqZiJw2g1XaHsk/7RcmDXtlBsBrccIxkLlMZHlfhjLtBlSiuM+bpBsbpq/ujMbn+c+F1i3LxoIMNcsQhMGn38RjpjYeELbaGHlEGO8KRJ1oFdMXFPkMi9BGwDsLNkkPrUx8o8qt7TwuchX5VZFhiPet0SSvEO4YhpEYum2X7F7EGY+Q+ajJU1eqqbOzrQqZy+YypvSdTH7Zxhz96/IXAWg78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXghb++XGspmkcYgPLdLyfvqUy1CX+DtnGG7uZi0x6I=;
 b=IWBb5lWtVeecjlIMn8CamO1ietDU1N4FcEbkxvwZdUJF3O0bNno0VxgM8+nM6ZQ2Jujo+wjTC6K6o5G4zIjHrPV0i8y4GprWB+1ISeXBG+Q/gCUbVtjWIy3fr2K/E2CeMZ+XpndbMsfb2uYS1rwXwWPZ7IpPJ3aHFlj6Hn7pBd/vtw2H+NmJxSVy9TXxj8eC4hMmM6PZcGnR+iURqS7nS8g/L0o9VqV8olsB6qd5XTDEZCR4LpltogqBtIfUFr5C5m+QIg8Yr/ol+JIaErmRKRYJh2yHuV6OTq1kTj64R760nJA//oDx9Dyj3HaMCyKXstwvkTycPBiI4bOIUgQjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXghb++XGspmkcYgPLdLyfvqUy1CX+DtnGG7uZi0x6I=;
 b=I4YR7dqdJWgVZvdHw906RcK3xBTEYgvaos5SJ0fsnDp29wh7pqpKU1PArvC3ub3btea1U9h0S2Y40GnnqY4mFAZiTvxHWzuF6WOPNl1cPZtlKfVkPgeOou89+QOPqGljJFqX7qLtf0piMN+RGvo+Rag3HG3vojEVMaLGvEF0Tsbv9glKZmOtZIsyMIGBDf1yLsKi+FZOqhFQ3+wJE/h7Or847kRpXuYgyzGh4z3MGgbGvj5armJxiRzP0Q9Jo4oJRKdvY1jWijmxFSxovCO+q5LCYnxgfvPzfLItZOYO4VeVlrqF5tDt+xoFqm8SPaljYzjAitFmfr8AwTIYPBf2pg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 09:06:08 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 09:06:08 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com
Cc: kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] cxl/test: Exercise explicit Type-2 RAM region creation
Date: Wed,  7 Oct 2026 17:05:39 +0800
Message-ID: <20261007090540.43817-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261007090540.43817-1-icheng@nvidia.com>
References: <20261007090540.43817-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f3d035-35dc-49a3-24dd-08df24523999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	DhqyV05zreIRchOt4claMVBtl1MyLtwsYS/5rH12IY80NvxoSMCIqBdFWelPlc0GSXbr2gxkWyOuxQT+EtAMGSVHxGOxKnUHukL3CXinHSvvpHQLmfwAToclfkX3IwtiMq1n2Zzo7F8GSHrAEwjYRnzQEHJ0qmVIHiIqP48RrE9HLtdDhIBIC+q/acE/OWtNtk8ChvRXPv5OM1cFe7QqROqZGIiA7B5VB3y3uOy53rLkp3etf61bVwBdmWEZuDobC/halO4FiaItcJL53oUeE4QIhL7f0bwo8Kg+vEWxbh5jzp7hUnND3tv3tYT7zdHx5zBP41bvKUJMhLyS52LSpXHsAFiQ71YfhE7ZfeQOYNEEMmWnEfBPPErCkg8SNlhPEqvN34luzR+WKFWRoplfnGRomOCV01jjdc2giShQeNDUxtnf/6OjqnP0NylQmTcwXrpP+WhtqzT9Mn9edABboysqJt1nK+Fxh9VIAOFYZWtQJH/qvtQ/+9coJHGVtA5J8JCaDN1tID0X7XUBvjzlTlB80nYqccgtQaEbbKeN9VgtHlu7EBSRCH1pkusPRiROX3cE2WT8GQF5zr63kdnL7WtS+g1XVmcxD8+sg5SjSp7hxJqJVc0qnSpCdFNpRPMKK0Jrso3YqtHna0Hgyz829NaXId3E9QQLzjCy1kzfaSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DiW41Xw8kVj5YHmciPTP0YG2OyHeKOvJ04ntF6D19zQpfaNp8T51CoH5iQa+?=
 =?us-ascii?Q?wqueaQBIELZ/vL1HHBsroYtbS/ltokBu9MZ0ETpl8J9A2JEdWIb85DQn+u3o?=
 =?us-ascii?Q?9dImEyTE0zEMsRPJXz/wBfKh3bAnl6PCkI4ifv3fB/nNgZew+GGSAYerrkB+?=
 =?us-ascii?Q?pc73rcOVccZhPnkMm7UIA+FZ7D4tzfKSf6iW0CcivqvbOgGiKx2sZuolA9Xh?=
 =?us-ascii?Q?hPeg98xDerzAX+P5JDxF2Gv5EYeYzaks7hd9A9yalBgcftC3naIJpUEAaSQW?=
 =?us-ascii?Q?j/CxU5b+aHktrpO3o6m1yDS7PMLC3+AnCSYqwDApTsi7OkFfQaS0hv7DswSj?=
 =?us-ascii?Q?UPbMeQKxYjYyt7YClUaZwq/4PHQYqtZ3lpkK9Yh/tTFjPYt53VcGkw85xWch?=
 =?us-ascii?Q?Xi4hyL0qFTK5LfhfC45ipMtcYHn1FNrlRV2vPUbQIRSoBVqpaU7QjVdFtVUN?=
 =?us-ascii?Q?m4/3id7UfwkO0YcSKjM134dx5rt5h9EF99sR1CSdwbkWNO7f2ccuEz9qc/RF?=
 =?us-ascii?Q?W8wd8UOXNFWyFSI26QYZ4xgoTbTla1NqcXbAV5QeUmGeIKnZoOCW6NBIuS4L?=
 =?us-ascii?Q?XyP5NflLwlSi+tjhTEYOqnVKYWrXeHVsVnF1S6kdbjWBH6ZnnbwKDOU/pCoG?=
 =?us-ascii?Q?6+yiTgmdWF/ND8eakhBvJiarAX/YvUzlq2pflWYjuglvbqLhIZ0IFvQC7pf0?=
 =?us-ascii?Q?I6Hk1VKk33CLa/WDGXJm6OL5L3niyntvVMt8q1PE1qFejLeE4bxfHjGEI30M?=
 =?us-ascii?Q?bxTXMbRZ8EmQ7myd1u2IShn0ZKg76wBgAW9uGpqjt1NTzkoOl7MgZcc+dS1a?=
 =?us-ascii?Q?z/ihyKKkPpzMxucVYY1vZne9T6+CLXMeOi3I2WJ3xhR7NHpes/Jyfr+Q9qHT?=
 =?us-ascii?Q?ZWQumiWW3flY66HvyNLEUiSwrtekNwIjEowkv/juKwZGk1BLpN/UdrBibpgc?=
 =?us-ascii?Q?+OQ3ejv8eLoKcduAdIMjmpwHhdzuYMftCXPWw9e3qZTFsgM6jxmQQoGJ2dtk?=
 =?us-ascii?Q?c2xA1F4lXgbksaTV9cLB8pIVf51yTTjXaPgJddBhjgKu2sC8UwH+/KlAzvTv?=
 =?us-ascii?Q?rJpstxWGNz1W5OnrQRrA+hexgJNLwgwwypLH5wxdSwArZaCeKu7EDIZcS52b?=
 =?us-ascii?Q?6CbTdNhQb2noH4GMjhTLqFpoDnFwVgwhr8XOPKCtWhaZ6AkALlcBtCudDonQ?=
 =?us-ascii?Q?55JPrXWiYMyWRm0jFUSUjm7QU2TpKPPF7n8/Jc0rTrBek/eizWf4Np5pPqji?=
 =?us-ascii?Q?TdpoocMF8GaIqjxZXVgTox5zO/of/XSFgeFiaLurRe3ejUAtyEe6J14m80OK?=
 =?us-ascii?Q?F9JBXesN1OHEGUEfa9nJWHRiZX7C0g9YTVXO6hxWalINDPpUW9ctJ4GIDe49?=
 =?us-ascii?Q?ndDQycOlP8fyrSIB1yTcK9Cmu6IC+RiS6/YJ7TYtrCcQP/VgnKjzqwPkTtPJ?=
 =?us-ascii?Q?u92yZVf3hxQMgEHr7IzWgwatd09QdmF9a82DNVwACgWs6E9CvhlzPTQmKK2W?=
 =?us-ascii?Q?qTBQxQeXlg4dLlki/NOVNUl5wJs7r/v/nnc9zHgzELwahpxGPbXPe/sAYdSV?=
 =?us-ascii?Q?3FqoywM7epsfUda9ypOWd6IvQTKXYNCfxokDtOe56+SJthorhSZ/hrqVasyt?=
 =?us-ascii?Q?xX6ECqOkoZdh6VGUNGV6wlT03BHbRT3HXfEe4iPH9p4Yrp7lKTTSHqL3dxxs?=
 =?us-ascii?Q?4JgJ2FoTuAGayOu6K52Juf/F1LqFvyjedr8EP4V19zm06RtItJARF/WK+xYt?=
 =?us-ascii?Q?4U/+t/uYBQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f3d035-35dc-49a3-24dd-08df24523999
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:06:08.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eSydje+huPMYla8+bTA79jU/MnMqwAj9D2RSJQBT5iZqafaRNAy2GRaqA/SlHEKmi5PGlYcjQsCahfAjew4Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

Add a second mock Type-2 accelerator without a FW-provided region.
Register its memdev, try attachment, and explicitly create a 256 MB RAM
region when needed.

Check the returned HPA range and retain the original accelerator on
devm_cxl_probe_mem(). Preserve MANUAL DEVMEM configuration after
disabled reply or failed saved-state restoration.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1 -> v2:
- Use separate registration, creation and attachment APIs
- Request 256 MB from 512 MB capacity
- Preserve DEVMEM config after failed restoration
---
 tools/testing/cxl/test/accel.c | 28 +++++++++++++++++++-
 tools/testing/cxl/test/cxl.c   | 47 +++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
index 8e6f4687ca02..83962702145d 100644
--- a/tools/testing/cxl/test/accel.c
+++ b/tools/testing/cxl/test/accel.c
@@ -20,6 +20,7 @@ static int cxl_mock_accel_probe(struct platform_device *pdev)
 	struct cxl_dev_state *cxlds;
 	struct cxl_memdev *cxlmd;
 	struct range mock_range;
+	u64 region_size = pdev->id == 0 ? SZ_512M : SZ_256M;
 	int rc;
 
 	cxl_accel = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
@@ -35,9 +36,34 @@ static int cxl_mock_accel_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	cxlmd = devm_cxl_probe_mem(cxlds, &mock_range);
+	/* Keep the firmware-configured accelerator on the legacy API. */
+	if (pdev->id == 0)
+		cxlmd = devm_cxl_probe_mem(cxlds, &mock_range);
+	else
+		cxlmd = devm_cxl_register_mem(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
+
+	if (pdev->id != 0) {
+		rc = devm_cxl_attach_mem_region(cxlmd, &mock_range);
+		if (rc == -ENXIO) {
+			/* The provider chooses to map half its volatile capacity. */
+			rc = devm_cxl_create_ram_region(cxlmd, region_size);
+			if (rc)
+				return rc;
+			rc = devm_cxl_attach_mem_region(cxlmd, &mock_range);
+		}
+		if (rc)
+			return rc;
+	}
+
+	if (mock_range.start > mock_range.end ||
+	    range_len(&mock_range) != region_size) {
+		dev_err(dev,
+			"accelerator%d returned invalid HPA range %pra (expected %llu bytes)\n",
+			pdev->id, &mock_range, region_size);
+		return -ERANGE;
+	}
 	cxl_accel->cxlmd = cxlmd;
 
 	dev_dbg(dev, "Probed mock accelerator with range %pra\n", &mock_range);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3eb1051b1ee8..4fab2572a1aa 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -29,7 +29,7 @@ static bool mock_zero_size_decoders;
 #define NR_CXL_SWITCH_PORTS 2
 #define NR_CXL_PORT_DECODERS 8
 #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
-#define NR_CXL_TYPE2_ACCEL 1
+#define NR_CXL_TYPE2_ACCEL 2
 
 #define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
 static int mock_auto_region_size = MOCK_AUTO_REGION_SIZE_DEFAULT;
@@ -494,7 +494,17 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
 
 static void update_type2_cfmws(void)
 {
+	struct acpi_cedt_cfmws *window = &mock_cedt.cfmws1.cfmws;
+
 	memcpy(&mock_cedt.cfmws0.cfmws, &type2_cfmws0, sizeof(type2_cfmws0));
+
+	/* Give the unconfigured accelerator its own single-target window. */
+	window->header.length = sizeof(*window) +
+				sizeof(mock_cedt.cfmws1.target[0]);
+	window->interleave_ways = 0;
+	window->restrictions = ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
+			       ACPI_CEDT_CFMWS_RESTRICT_VOLATILE;
+	mock_cedt.cfmws1.target[0] = 1;
 }
 
 static int populate_cedt(void)
@@ -1122,6 +1132,7 @@ enum cxld_init_type {
 	MOCK_DECODER_INIT_SAVED,
 	MOCK_DECODER_INIT_TYPE3_AUTO,
 	MOCK_DECODER_INIT_TYPE2_AUTO,
+	MOCK_DECODER_INIT_TYPE2_MANUAL,
 };
 
 static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
@@ -1131,12 +1142,13 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 {
 	struct cxl_test_decoder *found_td = cxld_registry_find(cxld);
 
-	if (found_td) {
-		*td = found_td;
-		return MOCK_DECODER_INIT_SAVED;
-	}
+	*td = found_td;
+	if (type2_test && is_endpoint_decoder(&cxld->dev) && pdev->id == 1 &&
+	    cxld->id == 0)
+		return MOCK_DECODER_INIT_TYPE2_MANUAL;
 
-	*td = NULL;
+	if (found_td)
+		return MOCK_DECODER_INIT_SAVED;
 
 	/*
 	 * The first decoder on the first 2 devices on the first switch
@@ -1170,6 +1182,27 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
 	return false;
 }
 
+static bool mock_init_hdm_type2_manual(struct cxl_endpoint_decoder *cxled,
+				       struct cxl_test_decoder *td)
+{
+	struct cxl_decoder *cxld = &cxled->cxld;
+
+	if (td) {
+		if (mock_decoder_handle_saved(cxld, td))
+			return true;
+	} else {
+		init_disabled_mock_decoder(cxld);
+	}
+
+	/* Preserve DEVMEM on disabled replay and failed saved-state restore. */
+	cxld->target_type = CXL_DECODER_DEVMEM;
+	cxld->interleave_granularity = CXL_DECODER_MIN_GRANULARITY;
+	if (!td)
+		WARN_ON_ONCE(!cxld_registry_new(cxld));
+
+	return false;
+}
+
 static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 				      struct cxl_port *port)
 {
@@ -1445,6 +1478,8 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	case MOCK_DECODER_INIT_TYPE2_AUTO:
 		mock_init_hdm_type2_cxled(cxled, port);
 		return false;
+	case MOCK_DECODER_INIT_TYPE2_MANUAL:
+		return mock_init_hdm_type2_manual(cxled, td);
 	default:
 		return false;
 	}
-- 
2.43.0

