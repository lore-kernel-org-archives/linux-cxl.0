Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A43DA5B6;
	Wed,  5 Aug 2026 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909356; cv=fail; b=U9tmjxquX4+eMXqNJgECj1URGSP7XOM+wpRrU+ru5dg4jadstSHu3HPytMPFpHeUpyT1o43NxK0TkVSWtmcQE8jay4GvLtu1+vsps7NNIUMJl2M2VQMOaIDoOa5mce4YlFRK86/b+SLP3JkZ1PRbs/6vBkifuK7KkAqWc1yFI2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909356; c=relaxed/simple;
	bh=lsVlNwRsuNnRz5xVYUcAKVQPmiTGkHjieoiAKfpClBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6HDHMdNmUHb86eotB69nZ5aqsB7vMGDnRKLAMxRyEYI+E8QfAd7+WjlUGXMCYXGYHbk3m25XHCDIGV9Whz/2vibLdc5ICvOblqHjRjv2GvEdCLaHV41XqNk+JViMYnSh7P3ikUMTiELg5IWnTbep1niYtjA3gUBgbCrt9rgLWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O8YVttZo; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O8YVttZo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/bEqfytcpZuuc14yeBVAv/VfFzqZ8gBwooreYQRJn5IeUO6wh4AZ0KSGSGwqDl+odiLkzLfI/VtXG9yDiaAOmB7CNVtzywcYhzuJ1ajNtjDz7IBmP/o8YkWKWSgiRaxHpoA0kQQd5xU46e3ZXSIZs0+5/aF/8VQK5KpxYfwV1au939sHPjP9uvoipnaeGKdyaRNz2bka0PU/+TPROUeetsWiMzPp1HT3DNz/WSTs9rY27UouRTX4jJBGXK3mily18doVVD5r6AnlL+kjD2+rYdS5FWNC81yx8TRVI3EX02X8/WIU39MGf7nyyruppkSqcsWFVSMQHdTN+V8dLQTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTBdrT4fF6gGRMEj6R7X5aCIvPg6Sj9KEds/aX5tYPM=;
 b=ID/7HcDfGrE5WF//IbQxzdEKO6jSkcUvQeNMZMEamcr5/ZQFAq37mG+s2w3MAOfecbE+Pig+Uc/tN09WqbrGiscyl6NS9J9b+B7dIkAmGuqQ6NyEqx+Liecpiqf0DKL1Ib5oEfY+uoT15D1E0Dz9ssFQ2l0rcX/SW13hh6RCDsePFN42HFj11D96C2l+3yCZ2wfyy4KBPrttxEX7m6u1ymlJxwfOweLz9tjkYaFG9B8+uD+P2siLOGarO04+G9mBtkHSjzxe2smKH2DhwX09uu4Z9D52x3yJ8JbSDrCy85CA2br7yci7FytrgoS8dDXCb/0t6QrzPzqEuWjKFl1X8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTBdrT4fF6gGRMEj6R7X5aCIvPg6Sj9KEds/aX5tYPM=;
 b=O8YVttZo41HJ0JKimq7TC0ZYYTynytyUE1KDl/U0lz39ISNO3+ULBWTpADDqwDqjIbhKNNSyYIXuwMeLMwErbi1NevmSp4P6qJaHyHSuXzSTw3nmPlGw0BJDT/gfroeYomX1R1yMFEh78YCZRgkyTmLuWRo/vUVm7LBv/sE5TObAA/r6JpHYEhI4/q33y2K8WnInYRkELGv3QgfkFNJREavrYSwX/5jx8zjHGaGod6j36HT+JYfkBxmkjLPodS4WMlnmF2p3glH402NCU2FO/CmJzEjSBNotXQfKh+5pzF5o7U/Yv4QVTmPPEdVvafBobfVT/rWQwZwnpjbtrxiDmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 05:55:49 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 05:55:49 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com,
	alison.schofield@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	mochs@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 3/3] tools/testing/cxl: Enable zero sized decoders under hb0
Date: Wed,  5 Aug 2026 13:55:24 +0800
Message-ID: <20260805055524.22311-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260805055524.22311-1-icheng@nvidia.com>
References: <20260805055524.22311-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: c6040d7d-bcc5-426b-0211-08def2b63334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|56012099006|10067099003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nBEqvVIiWdkdVE8qIpUO7HbvBfSSdZb//DQvE5VbO9XAObUVaSp21tmJ3FpaiW5IiU4BvsYOjWA9Fnch27YFRb7QSwgqjx1CHDqGWJxjBX9F1CnWeuh8OkpDZpZV9rDZOzqF7NBDrL8QSSkhOD/idWDWZyTk1VUkbUDmN508LkilmTH7yRZw4fptva+YLnmvcu34y789PQOJh4JXqVWEnaevnGDvpsn9pIngQgUKgiiPpUNpLucSRnsmq3a7qQev0godbtgBVtdYv7ESoiOFU766IXuhViolAvZlH2yZjlMwDInJE8lfn0kTu+bPaCx/r+Cm30dWw55Rx2gSfxVWVYjNJvZ+JvkO8RRPQJBmPWCusFs7ZsRzLha9TvlmNSKQQTYSCW7cWjK7hHK/fm9MUPLaQQ6CIPCoirYlbfG0nk3ztPQYYR67MGYbPuMaebzYmX2+jF9F1NatvR/FrpPNAz3iozGJBPWxlO484Q1saCY0wuWP1/UWBe8Io8M4QvNNJQMcpLp+ik7DIdcQQaYFuKyGrZYH1Et0muIZ1wXrU+p04R6ZivYW0CG2VD+WGaGU4xIZxnDP7pagPMQ50vgW7NZ4XzGeCseauMnCeDuYa+Yf61U/hYjFZuIvdK35GrurcvqgojMncAoHD0oi64lnhfqWJH8jhTJDUQg5cmzlcLY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5GTn5DlPQZOO4F8IxDPuo2ypFB+GJtrbJLxCjVzVatjMvlLrCtl1MhPa0vnS?=
 =?us-ascii?Q?Mo8W18RZoNbnwcxhX7VPEFWrV1Ovyyu5R9MW90e7ijHA1rP+H81I568ByV1x?=
 =?us-ascii?Q?jI52ycdna1NotY7yVVRz8lx+HNjwIyoIgbSJHD47j4N8Ra2OWoWfq1JB3+B3?=
 =?us-ascii?Q?P6chk5DW7aUP2bvy0bymQ1Q60p9+N8MuvQw+MTSfumVQYcJogOYLgbDRycwn?=
 =?us-ascii?Q?/nSwahCdsgqkaZyw/dWP6hZWem82NLRt6IKxPdDdJYct61/Q2oXAD2fvyFqB?=
 =?us-ascii?Q?ohl38SupwK9vIVdN2ProMv7nnvSi26p4rwS7KgHBf6e03b+seM9Ef0PQEpgZ?=
 =?us-ascii?Q?KEgPzl2OsXDriu3m7tQ7KggizgulwnXgK4dn31CVor6GSYzvKI3LBlxG4Zuf?=
 =?us-ascii?Q?FP41eJ9iK0F1cU5p5jXeNuHuLe4wGPIi/YpTZSj4ZEzFJ/e5NUqeewuI6Xt9?=
 =?us-ascii?Q?GpgfvSp9V1KQ2MfG9yqjr18PF/i4MMWRQ2kGkUxH9ijuuneX6lT5UP++7zUE?=
 =?us-ascii?Q?Jhchy39Xe27nQA+NhT8c5jUn4SMFzv3hC4cwzRh/rRTEOv33YNKLz/rhoL3J?=
 =?us-ascii?Q?Hyzus+fpsSdmbuEjbzPuRV2IGdvIr8SUVTaN9C+CKspC/xAP0nlp2X+/Tpas?=
 =?us-ascii?Q?UJ2ziUzuz48F+gTxAq1pgI/AJEGeLjU/4cENF2+3hsQiW8KwGA4T0ygSZXar?=
 =?us-ascii?Q?YhgqBZV+oWZ1LP5rJUXbxz4RBHEzCzom5DoItJobsGuGASO5QWyJsLlOPrIt?=
 =?us-ascii?Q?wOZ7evV541L5hOAxWvb7VkpwX+oYWE/AwoibpvklO2rfoZIIyL6Kl39JwR1B?=
 =?us-ascii?Q?QrwDj8IbKVhjiX9yfw5KnMFAQIBgK9GFF9wrp9QgdeCPenXWdzuP+X1P2HQm?=
 =?us-ascii?Q?z6RZ/Ep2Gr8D4i9N3YW3uNKmJtsMXLVwSpw9+6d0jDoUY4XujPda4KtMDX4w?=
 =?us-ascii?Q?UKqk6wL0D4GL8CmtHHK9b7PqVj8XL9D8LBqyxcmxF0Y84Okj/YulA1yJgNsI?=
 =?us-ascii?Q?oKxVuTBZgVlWPVFcTBtlRtLgkL31Q/XxoFZFUlh4tQWWjp3s0bQYWg573SlC?=
 =?us-ascii?Q?k+LAE9ctsvNWBqp09FNMZXuRiI2AHyw8JEFe5I8Zn1gOwJxR1YDbO8SaJyeO?=
 =?us-ascii?Q?5Ix8GWiWQMLl4RkEO0Dosd9tDE9XlJaSvj+O+vLwEqQeBJDO2iNafcQJXV1e?=
 =?us-ascii?Q?VKyBRCop3xCEeiKhhnmzTHpjZUO+k1l4gY5bxWpW/njpTCsfPmRUlW983Dkw?=
 =?us-ascii?Q?eqU/LxPiIldspKYG2zeU3KuvIIV3HKbXBXgShbKY1Lvh6tpZARTxQGIKiDqS?=
 =?us-ascii?Q?HrAUr4OdvkTOu/lrE1c8zNTYcJSXoI0A+I0gSz1wyiGtB4h5blwNc+JodOaL?=
 =?us-ascii?Q?D3e6pmyBVdxHckSln4Ta+mQSbsEPfZ+LNSKFy0N6xBuQ8tJQA3eypCHbXNew?=
 =?us-ascii?Q?X6HNxaY51BdjgB00gQmvqO+haNO7Kkb7Oe+hXFG7EmjU3HT0EBTqip6CMPFi?=
 =?us-ascii?Q?ghOyU8n6h7aDpuoQsTwRxJWO/5j1BuFWhQjXXx8eyzyDLXMpXdSp9KUlvuP2?=
 =?us-ascii?Q?oYYxTzYc/U+UkrhCctl2kefsW/GZH45K0loM+5BZghVr/OnuOYaFWc3J+xgM?=
 =?us-ascii?Q?WzOXCJzDSQbfWYLOJhvL2SrYKXeBlAqNsb/JMZAVSA2gGbTyZ9xiygErs7Tj?=
 =?us-ascii?Q?Ncgjj+WukiJEc3DtMXXt80S3U2t/F+8FNu45hOikLPbLgsqOHTBE1BqWxodx?=
 =?us-ascii?Q?PWLvXfvi0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6040d7d-bcc5-426b-0211-08def2b63334
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:55:49.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoevkkOt26EyqYEK9bqKZZcw97yjneitCZatubElveIw9k09yb3S8V4sU2Tr9xGYk2k5oi1KXMJWarQBUAxLYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
Changelog:

v8 -> v9:
    - No change.

v7 -> v8:
    - No change.

v6->v7:
    - Rebase onto cxl/for-7.3/cxl-type2-test.
    - Integrate mock_zero_size_decoders with special-topology parameter
      validation and reject its incompatible use with fail_autoassemble.

v5->v6:
     - Reword a mock comment, no functional change.

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
 tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8ab2ce1262f3..fff2004a08c8 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -18,6 +18,7 @@ static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
 static bool type2_test;
+static bool mock_zero_size_decoders;
 
 #define FAKE_QTG_ID	42
 
@@ -872,14 +873,13 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
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
@@ -1072,16 +1072,49 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
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
+	/* decoder[0] reserved [0, size/2), empty decoders sit at that watermark */
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
 
 enum cxld_init_type {
@@ -1114,7 +1147,7 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > 0)
+	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0))
 		return MOCK_DECODER_INIT_DEFAULT;
 
 	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
@@ -1147,6 +1180,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *root_port;
 	struct device *dev;
 	u64 base;
+	int id = 0;
 
 	base = window->base_hpa;
 	cxld->hpa_range = (struct range) {
@@ -1172,7 +1206,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 	 */
 	dport = port->parent_dport;
 	root_port = dport->port;
-	dev = device_find_child(&root_port->dev, NULL, first_decoder);
+	dev = device_find_child(&root_port->dev, &id, match_decoder_by_index);
 	/*
 	 * Ancestor ports are guaranteed to be enumerated before
 	 * @port, and all ports have at least one decoder.
@@ -1232,6 +1266,20 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
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
+		return;
+	}
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
@@ -1255,9 +1303,11 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
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
@@ -1307,6 +1357,26 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 
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
 }
 
@@ -2085,6 +2155,12 @@ static bool __init have_multiple_modparms(void)
 		count++;
 	if (type2_test)
 		count++;
+	if (mock_zero_size_decoders)
+		count++;
+
+	/* Zero-size decoders require decoder[0] to preserve commit order. */
+	if (fail_autoassemble && mock_zero_size_decoders)
+		return true;
 
 	return count > 1;
 }
@@ -2493,6 +2569,9 @@ module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
 module_param(type2_test, bool, 0444);
 MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
+module_param(mock_zero_size_decoders, bool, 0444);
+MODULE_PARM_DESC(mock_zero_size_decoders,
+		 "Mock committed, locked, empty decoders under host-bridge0");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

