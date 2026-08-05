Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687231A6836;
	Wed,  5 Aug 2026 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915766; cv=fail; b=Y/RHMwr987g5AWamr9seo2JtrtiKXUsz8vFRe3cat//HdXZwxePnM79R0O6uvek1JbEymvsuPnCjl0mZEVIuS9HapviN8sv2UyfXECAvtfXSNqMgO27nITmUy5FVLi51j04QR4F/yQcZt+PtGQ35a13qX74Mb8hCsgTlZVxhrKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915766; c=relaxed/simple;
	bh=KP3dzmNNzusEoHhBBJbG4Bk6EiuiAIjMN9VqE6VmTDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRBq9oM5zUmEH5B6Ix0gLLViQRkGLResC1sGWYqhTkpg09xROkHueY3kKNoL5KjzTsaoA8kHucN/Oh9hQpLHcmtsqx42V7n/VEGICsYyravyStaB0CzPH7F1tYCVbJSsHDDg5tz1R7RIkLwmz2ved4AHhmDKLFhCtXKVWeSXxVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uYdPAZ2J; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uYdPAZ2J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP+d/aqbANxYNcsOvU4DHt+gnkslFaba9pwixtaRf3TPuB3OaHZbntBzNO4kqxtvaMfG4l+9L0rjdeEh7qFBdtL5ymPErQKrmRPdifZhzmINjjsyoctqOgVhOjxGpR44ypRXj0Uzs6txgleDWMJ1aARb3jIEcLKds7/857Zh1ZMofTwUogiFVKclC1ON5Qwb0C3R4aPfYwOWw4Wgi+tF9d++243q78Rr4no44sYA8eu3qEkr2cVbJNrCSlrZvRF1coDfTfnOCTZS6Hb6mDqmQlxdlbPU1+t5kgn2fba/UFIUWtzEOyRmtBWgu7pfBWmsaoQTNEHlzzlZ+A4j4qG0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHRBwOggPoMUs34nxjUN6DWfnq5WVb4zwVPYOdxeDdk=;
 b=bEcRCRwITHHcjjQA+ooE7jDAj0GrXi9flf4zQJxQjFCuG3o8zlpYot+u2VxR8YBWIQhdlbehY19qsGxL9LI8YDOJYD0VVT7QksyfW0knd26AWRzzavKCeGj3WmI7GiUCZySU/7DgXck5Ww9D80ArtJkyUTP3g0IGn4HWtKAyWjmkvj+6EwqrSduPk6f7+MwD80R37cgDcAFoa3mEqJeyz0IMniukxxVnT2ToE0aAio6H994OKqka7SKbsOurqsOqWSbWeklPbgLnAjwsIwONa66K+rbvEVG6aCy2fhR4UQ8UPI+gzg7FJ/nrsplnxXAwcTAqnWIvrJ9k84q09xCVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHRBwOggPoMUs34nxjUN6DWfnq5WVb4zwVPYOdxeDdk=;
 b=uYdPAZ2Jstd9UCT3oT+6s3mVPa3wVxD+CAKgeEsxAN0DSIXlN2PbuXrBWalzkPw3nQw3cUlA2FuWAILX2D1HYEzur00Nhwel1hLXcVvR6LvBOrJn0/wECFGHwf+cpvT90nglarzZDtU8wGlIL2FQpXOoZ6kkqO0gieSp6dvXsgaEaygQR017g9ggX0Tp2kQMcl2ymGepZ06Yu2O3/en9UO+YW6Yp8uejsT+JLd3TPmRrSadm79m5jaMwET2MSfoQ4sVXbGXvr2DDNFAdUnWsJqCcpBM1CRXLvRpES2rzZULIK3v9LmzktaC96LXknr43Dk2MwbhhLKC3mLSWPH+utw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.20; Wed, 5 Aug
 2026 07:42:38 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 07:42:38 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [RFC PATCH 2/3] cxl/region: Auto-create a region for memdev attach
Date: Wed,  5 Aug 2026 15:40:41 +0800
Message-ID: <20260805074042.30173-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260805074042.30173-1-icheng@nvidia.com>
References: <20260805074042.30173-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c5d3b7-21d0-4cb1-eeea-08def2c51f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Lf5Oxevuc37L9zjpDwXh+opJJgWd6V/VR3OcRGQm0byPRS3NqkqiBK0+IpD1nnzUaBllFA3srlX//yA/BibfvZRjAw86BC0Kj53j6OiXwPHi615Q+5yNlxrg0s5ShP2vMJsbMa/m8jxcV/BLn0n02YFuWLJXw6UHBud+p0BZc0Yyua4kIzb9TzUFMKbiV/5siQY+AV21eYVomgL3QAZ1JiASKIYTxqFdnbH/QvXOq1n15c0YBzKpenCnq19Bowr++H+yl4TAAh2vzgETEf7VtGV32k3IpVgvjiaMyH1Lcd7i0kVYrE/K0Ri2yKW/13SKomGQlkmx7jEv1n6J3SS+qijoPw27zUELWqaxNS2ugmZFYoqapFvMegx5pJIhheOzMZ4u89bLfszp07ETGVhzlqlOfz9DMAGph2IIlmojyHW6nh/DreqNWf96Ex19c5SYMKT1AJ82xvIK1Wez7XGBHVkvs0BUN2EP6BFqXqSW6aaZe1wiKY5lOHVrUfqzDyyToLNU2dPDObzyTBVsdkMs968m9KxAgyZiNiYvzBss9XCDZgOe5+t8babc2BHjQS/73iFKoa0dZCHPBdgm+1DVw3G1xzolaCKMx73e13krT3BMupA7z6jJg8bkdEL9IBscnfr6k8ERoMFRcRvmonQiakHBstW9XAku0bgaDSHtLqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TAlcnEIbpTm5+sPmzDpAJAVIg8zaJvxiU3MZjuov+dmRCbCKI46hBPVg3Xw+?=
 =?us-ascii?Q?8eGAhNeKy1Osuvi9CBD/rnwjscWKey0YrbXZA1h7Arb4c6jfEEGF1LiJpKL/?=
 =?us-ascii?Q?jySwix4zi8oBgDTtxcNUnwbs7dlXJYi+dlLrNszLy3hP8e5T0UtNhI4JDI83?=
 =?us-ascii?Q?YsS0g2qTMmlANw3+3K6ChexgF8FbPrOjDX5oGLAwWZGCpp18PPLft7L2Wif7?=
 =?us-ascii?Q?/GqXl5OZ/oREWWR9btHK1qFPjsYAhWt84MQqw/KUp4T1vsBFdFy2uGW1PNwz?=
 =?us-ascii?Q?YVnb8Mtty6s7EbVLdZ7v0Ptt4VIsI44YK5LJqghSuAJ8TsHKWhNPXbenPaBl?=
 =?us-ascii?Q?kOJwKSChSqdMivMwiAz6WivsKdlLfree9T5IPQSgKGxR3EZYgwEb6cXX7Luc?=
 =?us-ascii?Q?nPhaYj6TUZDZFlkTgoPL7GySNDlwBP+wzOJ6TJeYQ+uygAYae8E0rH4PCM5X?=
 =?us-ascii?Q?H9oOUd6DfKcIVG1rm/E/qWNU3Oh2FESaXOoRL2e3q5tT+YDvrD04MFaYyYpz?=
 =?us-ascii?Q?WiMY2qMNTmZinVFsMSalEvb+0RaTOD4rypvPDmXxPLso8mmjNpFNMw3ZaNgp?=
 =?us-ascii?Q?bgYP+VTDwKhefZ1dp067HWmPwT6kzEdRmQaz0XWjDyXxLb+TA8geh/7OPVbY?=
 =?us-ascii?Q?U71f7c9iyPBYSnVM5mE0BV6JHwQQIsY+wnQDj2x15tJJs8rz5Uwro+f0QqfJ?=
 =?us-ascii?Q?iAEIbL+NJq3eJGv922Zkhh6lpDpED4SNKYlLxTQfuk9ZKE53ZgHvDfSnSO07?=
 =?us-ascii?Q?kk/jUeY8R9Fz2P3LJfHYxCLDqwMtRF5NZsRJwh700P4czTbGPNnuTM6clvkd?=
 =?us-ascii?Q?04eglw7c1ig+Qt837Wg/sKY951BJn2gE9GizgOFU82wSuJ9GFsva1cYiMhiI?=
 =?us-ascii?Q?1fr8rtFZ/RC8uJiN6452+BtdRUb9WVy/R3FpIk+NcapqeirM2UgVA3c2J34S?=
 =?us-ascii?Q?77sYXfXraBbMjzMPgxomLK5ory391CusRLIFLDTqKAqNEhu98GeRjqG8xbbd?=
 =?us-ascii?Q?WJ152/DK0H6SmRvzCgYCeQhV9mIu+5rwLXIMHyHzGQUsBm4OFwlBW8qCQHyF?=
 =?us-ascii?Q?C43+l7Zu+MaT456yORjXkW0+TvXTPGmcBsF55amkjSJFHSo8UPvULEjECaAa?=
 =?us-ascii?Q?jFmCc/5cS2Ur4Z7ZGWNyA16UHWkur8wWWyfq9f8EzU4peGs9vN3wSBGc8AtD?=
 =?us-ascii?Q?raWCEHzcoMz0IMnq85789Nr/c/c6wJGyCdmt4UF5u7pR/+Zw2jEjmLXJ0sK8?=
 =?us-ascii?Q?blsetZzL22MJLF0HwwJ8pkPNxhgtDALcYp+fjuJLtPriMl6wZVJKCR8i3XqS?=
 =?us-ascii?Q?WmRwSpS535tKRXvcLRPsK415lFnRCkipjgmCB1+GTQg/k89GZDsXqTac8C6f?=
 =?us-ascii?Q?f2S/nIsh+6y0gRNFrOT4tkBSG/96fsW5ga5h0N5gyJRqmemWlISK6YPIaJdZ?=
 =?us-ascii?Q?cE55CCdF0cpmoxTE4I6nXu94Kr9NMjKinvTN38ylDF0aVQEbdEXH1yv2aVqU?=
 =?us-ascii?Q?LBn3GGdE4uea9Z6z/hR+EXA4iX7y5c2jhlwCKdfQnBnDGg8V+iPF/PdBDiJr?=
 =?us-ascii?Q?ZE94qpN0FLECoXz4cSh6ac5eQH1fsRXdDlaKOYJVpa+2zrK2sdK7eS7B7oxE?=
 =?us-ascii?Q?LXotq7NMdV0qUgDr2XQC8A/WgE21MCorv4UqqUni71HJz0xvET8Ru3D+sXDK?=
 =?us-ascii?Q?/+Yx7U4oeEIDbHTONEkgpVYK+Za05VA4pe6PjLLIcfZ4f2EVrdhH5GQm/FJV?=
 =?us-ascii?Q?djy9dGtgGw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c5d3b7-21d0-4cb1-eeea-08def2c51f14
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 07:42:38.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeoKGtuNcbQ623jvfufPRe/S0jQz6jW3kQ9xpR8DsIMvD+2RocJVh0VyF79jT/o5aVlL4+VzBid4apU3qrGUQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

devm_cxl_probe_mem() currently fails when FW has not committed a region,
even when a Type-2 accelerator has usable CXL.mem capacity.

When no mapped decoder exists, select a pristine manual DEVMEM decoder
and the first compatible unlocked Type-2 RAM root decoder. Create a
non-AUTO, single-target region, allocate HPA and the full volatile DPA
partition, attach and commit the decoder path, then return the resulting
HPA range.

Use provider-managed reset for partial-commit rollback and unwind
region, HPA, DPA, and partition state in reverse order on failure.
Preserve the existing FW-precommitted path.

This support is limited to decoder 0, IW=1, and first-compatible root
selection.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 312 ++++++++++++++++++++++++++++++++++----
 1 file changed, 284 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7fcaddc61180..4ceabdfdd3b6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -363,7 +363,8 @@ static int commit_decoder(struct cxl_decoder *cxld)
 	return 0;
 }
 
-static int cxl_region_decode_commit(struct cxl_region *cxlr)
+static int cxl_region_decode_commit(
+	struct cxl_region *cxlr, enum cxl_region_reset_context context)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	int i, rc = 0;
@@ -405,7 +406,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 
 err:
 	/* undo the targets that were successfully committed */
-	cxl_region_decode_reset(cxlr, i, CXL_REGION_RESET_DEFAULT);
+	cxl_region_decode_reset(cxlr, i, context);
 	return rc;
 }
 
@@ -427,7 +428,8 @@ static int queue_reset(struct cxl_region *cxlr)
 	return 0;
 }
 
-static int __commit(struct cxl_region *cxlr)
+static int __commit_context(struct cxl_region *cxlr,
+			    enum cxl_region_reset_context context)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
@@ -452,7 +454,7 @@ static int __commit(struct cxl_region *cxlr)
 	if (rc)
 		return rc;
 
-	rc = cxl_region_decode_commit(cxlr);
+	rc = cxl_region_decode_commit(cxlr, context);
 	if (rc)
 		return rc;
 
@@ -461,6 +463,11 @@ static int __commit(struct cxl_region *cxlr)
 	return 0;
 }
 
+static int __commit(struct cxl_region *cxlr)
+{
+	return __commit_context(cxlr, CXL_REGION_RESET_DEFAULT);
+}
+
 static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
@@ -4177,45 +4184,271 @@ static int first_mapped_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
+static int first_attach_decoder(struct device *dev, const void *data)
+{
+	struct cxl_port *endpoint = (struct cxl_port *)data;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_decoder *cxld;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxld = &cxled->cxld;
+	if (cxld->id != 0 || cxled->state != CXL_DECODER_STATE_MANUAL ||
+	    cxld->target_type != CXL_DECODER_DEVMEM || cxld->region ||
+	    cxled->dpa_res ||
+	    (cxld->flags & (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)))
+		return 0;
+
+	if (endpoint->hdm_end != -1 || cxl_num_decoders_committed(endpoint))
+		return 0;
+
+	return 1;
+}
+
+static int first_attach_root_decoder(struct device *dev, const void *data)
+{
+	struct cxl_port *endpoint = (struct cxl_port *)data;
+	unsigned long required = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_RAM |
+				 CXL_DECODER_F_ENABLE;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_decoder *cxld;
+	struct cxl_dport *dport;
+
+	if (!is_root_decoder(dev) || !device_is_registered(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxlsd = &cxlrd->cxlsd;
+	cxld = &cxlsd->cxld;
+	if (cxlrd->dead || !cxlrd->res ||
+	    (cxld->flags & required) != required ||
+	    (cxld->flags & CXL_DECODER_F_LOCK) ||
+	    cxld->interleave_ways != 1 || cxlsd->nr_targets < 1)
+		return 0;
+
+	dport = cxl_find_dport_by_dev(cxlrd_to_port(cxlrd),
+				       endpoint->host_bridge);
+	return dport && cxlsd->target[0] == dport;
+}
+
+static struct cxl_root_decoder *
+find_attach_root_decoder(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *endpoint = cxled_to_port(cxled);
+	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
+	struct device *dev;
+
+	if (!root)
+		return ERR_PTR(-ENXIO);
+
+	/* First compatible x1 Type-2 window is strict v1 policy. */
+	dev = device_find_child(&root->port.dev, endpoint,
+				first_attach_root_decoder);
+	if (!dev)
+		return ERR_PTR(-ENXIO);
+
+	return to_cxl_root_decoder(dev);
+}
+
+static void restore_attach_decoder_part(struct cxl_endpoint_decoder *cxled,
+					int old_part)
+{
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	cxled->part = old_part;
+}
+
+static int select_attach_ram(struct cxl_endpoint_decoder *cxled,
+			     int *old_part, resource_size_t *size)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct resource *res;
+	int part, rc;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		*old_part = cxled->part;
+
+	rc = cxl_dpa_set_part(cxled, CXL_PARTMODE_RAM);
+	if (rc)
+		return rc;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	part = cxled->part;
+	if (part < 0 || part >= cxlds->nr_partitions)
+		return -ENXIO;
+
+	res = &cxlds->part[part].res;
+	if (res->child)
+		return -EBUSY;
+
+	*size = resource_size(res);
+	if (!*size || !IS_ALIGNED(*size, SZ_256M))
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct cxl_region *
+create_attach_region(struct cxl_endpoint_decoder *cxled,
+		     struct cxl_root_decoder *cxlrd, resource_size_t size)
+{
+	struct cxl_region *cxlr;
+	int rc;
+
+	guard(mutex)(&cxlrd->regions_lock);
+	do {
+		cxlr = __create_region(cxlrd, CXL_PARTMODE_RAM,
+				       atomic_read(&cxlrd->region_id),
+				       CXL_DECODER_DEVMEM);
+	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.region) {
+		/* Single-target IW=1 is strict v1 policy. */
+		rc = set_interleave_ways(cxlr, 1);
+		if (!rc)
+			rc = set_interleave_granularity(
+				cxlr, CXL_DECODER_MIN_GRANULARITY);
+		if (!rc)
+			rc = alloc_hpa(cxlr, size);
+	}
+	if (rc)
+		goto err_unregister;
+
+	rc = cxl_dpa_alloc(cxled, size);
+	if (rc)
+		goto err_unregister;
+
+	rc = attach_target(cxlr, cxled, 0, TASK_UNINTERRUPTIBLE);
+	if (rc)
+		goto err_unregister;
+
+	rc = __commit_context(cxlr, CXL_REGION_RESET_MANAGED_DETACH);
+	if (rc)
+		goto err_unregister;
+
+	rc = device_attach(&cxlr->dev);
+	if (rc <= 0) {
+		if (!rc)
+			rc = -ENXIO;
+		goto err_unregister;
+	}
+
+	get_device(&cxlr->dev);
+	return cxlr;
+
+err_unregister:
+	unregister_region(cxlr, CXL_REGION_RESET_MANAGED_DETACH);
+	return ERR_PTR(rc);
+}
+
+static void cleanup_attach_dpa(struct cxl_endpoint_decoder *cxled,
+			       int old_part, int setup_rc)
+{
+	int rc;
+
+	rc = cxl_dpa_free(cxled);
+	if (rc)
+		dev_err(&cxled->cxld.dev,
+			"failed to clean up DPA after attach error %d: %d\n",
+			setup_rc, rc);
+	restore_attach_decoder_part(cxled, old_part);
+}
+
+static int create_memdev_attach_region(struct cxl_memdev *cxlmd,
+				       struct cxl_attach_region *attach)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct device *decoder_dev __free(put_device) = NULL;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_region *cxlr;
+	struct range hpa_range;
+	resource_size_t size;
+	int old_part, rc;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.region) {
+		guard(rwsem_read)(&cxl_rwsem.dpa);
+		decoder_dev = device_find_child(&endpoint->dev, endpoint,
+						first_attach_decoder);
+	}
+	if (!decoder_dev) {
+		dev_dbg(cxlmd->cxlds->dev,
+			"no free manual DEVMEM decoder to auto-create a region for %s\n",
+			dev_name(&cxlmd->dev));
+		return -ENXIO;
+	}
+	cxled = to_cxl_endpoint_decoder(decoder_dev);
+
+	rc = select_attach_ram(cxled, &old_part, &size);
+	if (rc) {
+		restore_attach_decoder_part(cxled, old_part);
+		return rc;
+	}
+
+	cxlrd = find_attach_root_decoder(cxled);
+	if (IS_ERR(cxlrd)) {
+		rc = PTR_ERR(cxlrd);
+		dev_dbg(cxlmd->cxlds->dev,
+			"no compatible Type-2 root decoder to auto-create a region for %s: %d\n",
+			dev_name(&cxlmd->dev), rc);
+		goto err_cleanup_dpa;
+	}
+
+	cxlr = create_attach_region(cxled, cxlrd, size);
+	put_device(&cxlrd->cxlsd.cxld.dev);
+	if (IS_ERR(cxlr)) {
+		rc = PTR_ERR(cxlr);
+		goto err_cleanup_dpa;
+	}
+
+	hpa_range = (struct range) {
+		.start = cxlr->params.res->start,
+		.end = cxlr->params.res->end,
+	};
+	rc = devm_add_action_or_reset(&endpoint->dev,
+				      endpoint_unregister_region, cxlr);
+	if (rc)
+		goto err_cleanup_dpa;
+
+	attach->hpa_range = hpa_range;
+	return 0;
+
+err_cleanup_dpa:
+	cleanup_attach_dpa(cxled, old_part, rc);
+	return rc;
+}
+
 /*
- * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
- * simple case of single mapped decoder per memdev.
+ * Attach to a firmware-precommitted region already mapped to the endpoint.
+ * Return 0 on success, -ENODEV when no region is present (the caller then
+ * auto-creates one), or a negative errno for a present-but-unusable region.
  */
-int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
+static int find_committed_attach_region(struct cxl_memdev *cxlmd,
+					struct cxl_attach_region *attach)
 {
-	struct cxl_attach_region *attach =
-		container_of(cxlmd->attach, typeof(*attach), attach);
 	struct cxl_port *endpoint = cxlmd->endpoint;
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_region *cxlr;
 	int rc;
 
-	/* hold endpoint lock to setup autoremove of the region */
-	guard(device)(&endpoint->dev);
-	if (!endpoint->dev.driver)
-		return -ENXIO;
 	guard(rwsem_read)(&cxl_rwsem.region);
 	guard(rwsem_read)(&cxl_rwsem.dpa);
-
-	/*
-	 * TODO auto-instantiate a region, for now assume this will find an
-	 * auto-region
-	 */
 	struct device *dev __free(put_device) =
 		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
 
-	if (!dev) {
-		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
-			dev_name(&cxlmd->dev));
-		return -ENXIO;
-	}
+	if (!dev)
+		return -ENODEV;
 
 	cxled = to_cxl_endpoint_decoder(dev);
 	cxlr = cxled->cxld.region;
 
 	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
-		dev_dbg(cxlmd->cxlds->dev,
-			"region %s not committed for memdev %s\n",
+		dev_dbg(cxlmd->cxlds->dev, "region %s not committed for memdev %s\n",
 			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
 		return -ENXIO;
 	}
@@ -4226,10 +4459,10 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 		return -ENXIO;
 	}
 
-	/* Only teardown regions that pass validation, ignore the rest */
+	/* Only teardown regions that pass validation. */
 	get_device(&cxlr->dev);
-	rc = devm_add_action_or_reset(&endpoint->dev,
-				      endpoint_unregister_region, cxlr);
+	rc = devm_add_action_or_reset(&endpoint->dev, endpoint_unregister_region,
+				      cxlr);
 	if (rc)
 		return rc;
 
@@ -4239,6 +4472,29 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 	};
 	return 0;
 }
+
+/*
+ * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
+ * simple case of single mapped decoder per memdev.
+ */
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
+{
+	struct cxl_attach_region *attach =
+		container_of(cxlmd->attach, typeof(*attach), attach);
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	int rc;
+
+	/* hold endpoint lock to setup autoremove of the region */
+	guard(device)(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		return -ENXIO;
+
+	rc = find_committed_attach_region(cxlmd, attach);
+	if (rc != -ENODEV)
+		return rc;
+
+	return create_memdev_attach_region(cxlmd, attach);
+}
 EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
 
 /*
-- 
2.43.0

