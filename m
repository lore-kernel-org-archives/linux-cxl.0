Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A499246781;
	Tue, 23 Jun 2026 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205852; cv=fail; b=SfdIspwAV6v6ob0dYcSDHhtPcSw71ecrDHtjjwaImoI/3ExWOgJo3LsNnzcTReobjxL2bkcMju1JFNjQpO78N78RPGimaI/zWplMUcQLO8QRSktqGSo5pFpdBrui31Rn/+beyBu+F/R5OUqmRRsS7RzfWxRvjYIU9o/NhbOGDXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205852; c=relaxed/simple;
	bh=dN79/4RPwvZqetstndpjSHqoWUfQnS1f4FAm4w21TaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cgclGEc+OgJLBWtrDwM3v/ATzyyRAdhy0ILTDKzVMIg30fB6bPzIltaITSXrrin0t+mOpUkWxUryvp8CX+lCKD/ktNtZjV0+cY4yQ/uVrC2japMXd1GZpZlnberMPylwCUF4QvWPyy4EErqicngyGtNkrqAvtiNjINDzdbNpZYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O0wusLcX; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O0wusLcX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9eji8al1I65jBAKthG4+YJt0nlVwpJ6oPtiUo4lccqnW7f2+jxAV8YkMIXemfxkUOxmCaxYJ8Hp+rp6ZJA7EjJnWvdXfkRFnh6CCw9edQsdItmNb2hXoALQhTsK5/I6FJyKWA3C7LxYxTttOj7vyJdSKG7uO41lc93IyKtDejjXVhUIIeCvhft/BPLh29RnsbutobegrX0YDw2pw39l9GfKpu6+KqQvvVLVqaXS3uHLez+tWUgxYD/fWhA8MDsrH7ITyxjQK1kJD/WCwsNJnFJ/njnFCg8SQWFRiyOt4UaeEZ4eLT3H4ow2EOkezge1hz/scZHNG4pb+fp8XyhsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIukXqH4f3rdYXhVTOEGTUo/aExReN4lbKn4W+R/VEc=;
 b=gpaOnA58DJFmPsuIg0KUthiAN8hYlzrYDXgfYwq53ATiyxah4mIuzlPQuX3lqjhRzrvEI2OTA+zPaObuw7e02+0Llqsmm3Es/nMT2AZX0T/iH8z9V9J2CBhCkgci4b4I/OLEPvqPLcF827UF3rEW7aPdxh7zp2c5giPpmhFgN2XcuYDJ5KTnt0qsyWWDN29A4myjDztEjaxaAB/4c2jScuru6WZEgIMMgaGE8n6QjbykXoqBtH0YAfHMDOC3TCVpRIWMWFxMyqIA6Bak7szwD4chFrpY56b+Cx6o9JJXNlwgvXQWICu1ihjjkX1/eMeO/YUgnqSzR9blcOwzYDD1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIukXqH4f3rdYXhVTOEGTUo/aExReN4lbKn4W+R/VEc=;
 b=O0wusLcXvcBhs2zO1zUPFKlTaCNy3K1JGDspZkkeAT4DAF5Qqv4T3Z1c2qr5AKyRiaWu2k856F8dVuD8b5hMWPdTz7r8ofGyzmnYnG86FGbh3dUHUr0nrmXLyOL1WlI4/0m9o6liM7n3t3hK/4Cglk4a04ja+WVlzq8OpMF0C2zo81Mrb+U+foIB9PrSUxFO0p28JWEcx06I31W+UDAwJzZLhYgNDnCnxnpkVdOPPZvroIo8+cAm0dY9fXol3q5YKl+MKuCGxdOg7fD1MAiLwl23pymYrmALOA52xIzw4itYWNH3RNsyAQTnvaBb4fccj5Mg/T9fm4XJBm7TOzTV3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 09:10:46 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 09:10:45 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	iweiny@kernel.org,
	danwilliams@nvidia.com
Cc: ming.li@zohomail.com,
	terry.bowman@amd.com,
	alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>
Subject: [PATCH v5 2/2] tools/testing/cxl: Enable zero sized decoders under hb0
Date: Tue, 23 Jun 2026 17:10:19 +0800
Message-ID: <20260623091019.33417-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260623091019.33417-1-icheng@nvidia.com>
References: <20260623091019.33417-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0068.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:23::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac8ddea-312e-487c-3223-08ded1074ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|18002099003|3023799007|56012099006|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Egb3sHBcoNIw1lrEWf7ny8ae9PTtd1gOft4s3xzIq/E+Sp8bvRmw0VeE/efKhFh+BBTT1/FuMBvvOdb+5RGQJYIPMwVlTUjGgFcoDa3RUujJNIKGxfJiOEMnlDLr/F5F4/shT4EcX5pFrOgJ02jgSs3PKnfk9dV6/J0O3WpqJbThgDO2TaGrt51rgT0U8Tz6QRI5RM6iAo6FimBtgzA+cDEpTDxXQ+wb+4KZKHEpnefDdmMRnCIoUo8P97gB8UwOhV9odDgOtVyztawdnsCUEBHl2lEDjJM4jVrjKiNodN6uTJm3ZJwd3c2tiX9+NCII4RJ6J2fojd5ZXS4RdKAGaiKXPkcVfWRkRRwE11kNoGB4RERGcq/Ko08rTnCFc1D5zgec8M9LXvugm0VGWwY/JBsgryGgER4je8vk0oE+0B6bqfuZL6PDwKzGCg6gg2/qIm7grtnSCvRVsRagYbaLjndKGwA+moidrQmWqTDnIAELGkiR8V3MVk60sqLpC0V3m9asHQ3261aIl4xcy2wn+N7QS86E3fgXVtrKRmzqmWy1iGGbRdQKLqu3FYAics2qgivmh3X6IL87fjMDD0n+nKDsr2PX6+5uwdd3bkNAHbvlQfeKnJM+sbpjMGs5fXgbyZAyNCMxVM2D3tKskV233j1dwAvl9N7M6qV/JRaFYMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(18002099003)(3023799007)(56012099006)(22082099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rg25dmbx/2y4LnD+jJaAl4D2Sxk2B5fetOj+S1KP6HLWrnwmS1CRUbCveFTc?=
 =?us-ascii?Q?483o3bHtVb+8YCGrEN6lNT27eJdcgC7fdpzTjsBmSYKDo5yn9Qff70+rNF7K?=
 =?us-ascii?Q?vWhtjwn5ReECjzxVLBYqPL2u4g9VzQJQ1gUI5UTgL2It/q9WpuKpmIHysZ+k?=
 =?us-ascii?Q?SzMDVmrqq5SqkkftUFiGbu4OQg6U57lwJK8sJC4ELRXEajGE5Q1NPdEQdLj9?=
 =?us-ascii?Q?V4rU2+QsYj36++gEKHSbcEsxCHuYb+nZooRPchawftBEby3zr+IlFimzfafv?=
 =?us-ascii?Q?RyAcZH5PI+gh60N9psngPJQmeUetztfboNTurDJpkTTRwFtsyvCLiTY2tzXw?=
 =?us-ascii?Q?vVOur9uuE4M34WqGss0FquUUmboPjM+PVX94pUd+V6XpV8pbEa0CnypCi4mB?=
 =?us-ascii?Q?RolsVEERxlv6hn/eZgeoNWiapjHcSdl8ct11T6O4xGAh/lFKYGEubzdOjjhI?=
 =?us-ascii?Q?D++7uTAIcCmuY4yRvsl5OAxN1kLCXQIgYteFkKIcukeiofXe0W89X0oC5cZF?=
 =?us-ascii?Q?7ybqohy2WJLD8/5dO0d2vvhd31Wq0PvR/OUSZTp2sahYJW/tcmjcQZ4utqak?=
 =?us-ascii?Q?gB/I9TusUBrUr9b4WCIrVtN84tYI8xC3vkYVfF51kA8c6wAvNsBp/yX/Le6Z?=
 =?us-ascii?Q?sYL1zV7R5MD2tObNeIPzJnvVDq+tYH9HlAJaee8OqgBDod43xLB786rjxi4h?=
 =?us-ascii?Q?0QUp3MsK3GWvJgW7YmfYyzGinCetRAg1Uq1cyWtk6oQNLJBzCN4ofS0fDH0z?=
 =?us-ascii?Q?UKvZ8SWlk5lEnukPX74uvfDD5qnXykcgoB3sWG6qBunr+xH5TQn2scD47zHV?=
 =?us-ascii?Q?m7tI3x4xF04N+giK63wLjoWRCt6Du3m+3DSGV5eBPNcDMUDuMyA1IBnfuEtD?=
 =?us-ascii?Q?tlkhFZf/sBDoyHe34w/Sb96YS71bRHVedMWUXzkhcjOsbgQDNeUESJ1q++AR?=
 =?us-ascii?Q?wmHwmjxAgRBP/NCkM70xzXyU83KDP9xUKK86B2LJQxi1mRbgh/kgAaoYg6N4?=
 =?us-ascii?Q?06cVw52MGW1dx1M1aivv7E+cfo/FObubqgw8WhhTQvsrJx1JIg6uWr4FqqKk?=
 =?us-ascii?Q?O6i9ixa5Ymw/nOGO4kVHsQqTQg4gw7+WMvOx/LnMg7m6ZxOiXqZ2hXGipFH+?=
 =?us-ascii?Q?+edreObvwCH6oKwefTJy1hALA5M4pCgZtzpuDtzc6GRaFebTt6KEMzXW1r1a?=
 =?us-ascii?Q?Sep/vRVR/kpLw9SvwgQ/9CPTcqq1CAtzJsAH/F7WLZHaKkpvcjQz7/WAmN8U?=
 =?us-ascii?Q?b/wrNQlTL9gX35rQtkCS3nuHwRCAs+zpCaS88OY/gfbd57y12BN+B7kKUqAT?=
 =?us-ascii?Q?rgmBHcehpShnwo2h5U/hE3IbzxS4wS5/bYpW99GLl9PA7VF2lk8k8hAQspFE?=
 =?us-ascii?Q?UTDr2+I6qzr3Y3VdkREOpU6WwcZjDDiyCjV9dXlFRHa2DwqyXOW2zOj7oALv?=
 =?us-ascii?Q?gn8/9Y7Dwhzj/75xRaW/po5RV40et09siJGq4cG9w9eNJFoW8ofpa7LdtN0l?=
 =?us-ascii?Q?pWYg5BImmDZBa1IpBZg6wVLLu1fRSi8ZFcvNJPYN8Y5+BI9Bj82K2dp26cLo?=
 =?us-ascii?Q?P6OyD4GGRqsCs2Gr6py3yngjZB9iGTFjQwHIhm/O6ZUnh3IxT4BVofpcSrvI?=
 =?us-ascii?Q?eQHRgoKEZtylrsxzpjBBeuv/ngPMkP413fRNbRJ8ACzNIx43Z95nuCG9iGra?=
 =?us-ascii?Q?kGUANAg2JrhD9IQL6N/T8O8+N0FUfd+A7x9gExY0NthAebJKpYzDqea6oldL?=
 =?us-ascii?Q?iguHPtFXDQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac8ddea-312e-487c-3223-08ded1074ef1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:10:45.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCVBMF+lDUJKodCh4+V64021UAiryK5y9Cd9FnmIfS6kT9uDxFVnUKnY1Od6t8Jc3/nZ/ne+jxkKGQzGRQAlIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591

The kernel now allows committed zero-size HDM decoders so BIOS can lock
empty decoders; cxl_test needs to exercise that path.

Add a mock_zero_size_decoders module parameter (default off). When set,
the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4)
commit decoders 1 and 2 as zero-size + locked above the decoder[0]
auto-region, mirrored on the parent switch and host bridge. The mocks
take a real zero-size DPA reservation, like enumeration of real
hardware, so commit_end lands on a zero-size decoder and the
reservation, poison-by-endpoint, and teardown paths all run.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
v4->v5:
      - Mirror the v5 core semantics: mock zero-size decoders take a real
        zero-size DPA reservation via devm_cxl_dpa_reserve() so
        dpa_res/hdm_end/cxled->part match real hardware enumeration and
        the poison-by-endpoint walk reaches commit_end.
      - Set cxled->state = CXL_DECODER_STATE_AUTO to match
        init_hdm_decoder()'s fall-through (undoes the v2 switch to
        MANUAL).
      - cxld_registry_restore(): reserve unconditionally for enabled
        endpoint decoders; enabled now implies reserved, sized or not.

v3->v4:
     - No change.

v2->v3:
      - Gate the zero-size + locked decoder injection behind a new
        mock_zero_size_decoders module parameter (default off). v2
        applied it unconditionally on the host-bridge0 auto-region
        endpoints, which the region test suite reuses, regressing 7 of
        17 cxl unit tests; defaulting off leaves the shared topology
        untouched.

v1->v2:
      - Replace second_decoder(), third_decoder() with a single
        match_decoder_by_index() helper, so all lookups share one
        matcher.
      - Use DEFINE_RANGE() for the empty range instead of an open-coded
        struct.
      - Set cxled->state = CXL_DECODER_STATE_MANUAL rather than
        STATE_AUTO.
      - Set CXL_DECODER_F_LOCK on the mock zero-size decoders to model
        the BIOS-burns-slots case.
---
 tools/testing/cxl/test/cxl.c | 100 ++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 14 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 418669927fb0..33cea0116a71 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -17,6 +17,7 @@
 static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
+static bool mock_zero_size_decoders;
 
 #define FAKE_QTG_ID	42
 
@@ -841,14 +842,13 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
 		cxld_copy(cxld, &td->cxled.cxld);
 		cxled->state = td->cxled.state;
 		cxled->skip = td->cxled.skip;
-		if (range_len(&td->dpa_range)) {
-			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
-						  range_len(&td->dpa_range),
-						  td->cxled.skip);
-			if (rc) {
-				init_disabled_mock_decoder(cxld);
-				return rc;
-			}
+		/* enabled endpoint decoders hold a reservation, sized or not */
+		rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
+					  range_len(&td->dpa_range),
+					  td->cxled.skip);
+		if (rc) {
+			init_disabled_mock_decoder(cxld);
+			return rc;
 		}
 		port->commit_end = cxld->id;
 	}
@@ -1041,16 +1041,49 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 	WARN_ON_ONCE(!cxld_registry_new(cxld));
 }
 
-static int first_decoder(struct device *dev, const void *data)
+static int match_decoder_by_index(struct device *dev, const void *data)
 {
+	int target_id = *(const int *)data;
 	struct cxl_decoder *cxld;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 	cxld = to_cxl_decoder(dev);
-	if (cxld->id == 0)
-		return 1;
-	return 0;
+	return cxld->id == target_id;
+}
+
+/*
+ * Mock a committed, locked, empty decoder
+ * (CXL r4.0 8.2.4.20.12). Gated by the mock_zero_size_decoders module
+ * param so the default cxl_test topology, shared by the region test
+ * suite, is left undisturbed.
+ */
+static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
+	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
+	cxld->interleave_ways = 2;
+	cxld->interleave_granularity = 4096;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	cxled->state = CXL_DECODER_STATE_AUTO;
+	/* decoder[0] reserved [0, size/2); empty decoders sit at that watermark */
+	devm_cxl_dpa_reserve(cxled, mock_auto_region_size / 2, 0, 0);
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
+}
+
+static void size_zero_mock_decoder_sw(struct cxl_decoder *cxld, u64 base,
+				      int level)
+{
+	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->interleave_ways = level == 0 ? 2 : 1;
+	cxld->interleave_granularity = 4096;
+	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
 }
 
 /*
@@ -1131,7 +1164,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > 0) {
+	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0)) {
 		default_mock_decoder(cxld);
 		return false;
 	}
@@ -1145,6 +1178,20 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	base = window->base_hpa;
 	if (extended_linear_cache)
 		base += mock_auto_region_size;
+
+	/*
+	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
+	 * endpoints mock committed, locked, empty decoders above the
+	 * decoder[0] auto-region (CXL r4.0 8.2.4.20.12). commit_end then
+	 * points at a zero-size decoder, exercising the zero-size
+	 * reservation and poison-by-endpoint code paths.
+	 */
+	if (cxld->id == 1 || cxld->id == 2) {
+		size_zero_mock_decoder_ep(cxld, base);
+		port->commit_end = cxld->id;
+		WARN_ON_ONCE(!cxld_registry_new(cxld));
+		return false;
+	}
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
@@ -1168,9 +1215,11 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	 */
 	iter = port;
 	for (i = 0; i < 2; i++) {
+		int id = 0;
+
 		dport = iter->parent_dport;
 		iter = dport->port;
-		dev = device_find_child(&iter->dev, NULL, first_decoder);
+		dev = device_find_child(&iter->dev, &id, match_decoder_by_index);
 		/*
 		 * Ancestor ports are guaranteed to be enumerated before
 		 * @port, and all ports have at least one decoder.
@@ -1214,6 +1263,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 
 		cxld_registry_update(cxld);
 		put_device(dev);
+
+		if (!mock_zero_size_decoders)
+			continue;
+
+		/*
+		 * Mirror the endpoint: commit the next two switch decoders
+		 * as zero-size + locked so the empty-decoder layout extends
+		 * end-to-end through the switch and host bridge.
+		 */
+		for (id = 1; id <= 2; id++) {
+			dev = device_find_child(&iter->dev, &id,
+						match_decoder_by_index);
+			if (WARN_ON(!dev))
+				continue;
+			cxld = to_cxl_decoder(dev);
+			size_zero_mock_decoder_sw(cxld, base, i);
+			iter->commit_end = id;
+			cxld_registry_update(cxld);
+			put_device(dev);
+		}
 	}
 
 	return false;
@@ -2049,6 +2118,9 @@ module_param(extended_linear_cache, bool, 0444);
 MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
 module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
+module_param(mock_zero_size_decoders, bool, 0444);
+MODULE_PARM_DESC(mock_zero_size_decoders,
+		 "Mock committed, locked, empty decoders under host-bridge0");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

