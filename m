Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7530C175;
	Sun,  7 Jun 2026 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820054; cv=fail; b=BT7cE7OK8rFALjZ7a1aEYFsL1ZkFck8H2XfooLYqjgQ7S0cHmnzexyHBCH7nUQ5lQb78blymiA8SOlnqm7+oOM8d6VZWKOjtnz2J/xPyrbC2VrHCX0QJKEbwGAveRQ1qTlsdC4dNvfliUdNV5UY639Pad/4IKnZOQdK33qjfoAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820054; c=relaxed/simple;
	bh=G2h/f7tNz8I/L5c7xra+yXkIMFqpkc82YifhJaVKPdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=apDXONzLZNHt9avjvBR5YYOEVHzeE4D1FWXsXErPzquAoGPj4SgTS3jOdyjmf0trYPf0WVZgNwmxXAf0A3CP90TDntHGgB9YOYII2YVTj1N+KVFC4inRbPAjULRu6FHzHZJHxTbdPEauRk40YBUQ0YxtcR1vJNi8y4lTREu6ytc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ce33MLV4; arc=fail smtp.client-ip=40.93.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ce33MLV4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOHaCzpxRPw3RJCx6OTvG3lZtPCI32HhfRMfBcgDOFpbadjYKhQeAPoOyTtQJH4TSV9o73AjENeadGWG3spnhMBPIYd3wXuK+I+CGyX3mKhseTqJacDsFzgRQKbkKnAwPOUjmt3EK7mfq2W8hbuaYxcvDMgxYnh6d8jQfICjlwWUPDo/jRkqCnhtZniHRiY/P88LNdiSSlNKg8PrG/dBvE6+vrEU6ZWCAlaBERuIhtLgUtTg/e7aHGBzOMQGYUzRpsCqDZ5JSBlA9O6oH3ZimwFHbl6VQePR+s1JZZaI7Kwmd7haU5h2T70r21Fp5zNCK4M8Whhc5JstWXNlv5WF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHoXgfQwVynrzlyAGIj8gjnPLra81OjQLNnbN2GcwKA=;
 b=fOoRPwFT3ekI1cUURlVFIxmlLp0czeccPwbmU7BdIGp+rABtlbKxX3QTSwlZ0QltWIm1lYKtqAYS2H3UJxEsJFa3mp5UrQh269/lcN4AZDaISm4eQc0LA0LXfGbudi9VnUUG1ixa35OW+lOELKzRrbzdrHFjvGgwe5sXnNZ27Wdl+lJybVD1DCO35LGDeYLytByiw9LiL4hpjk7u2BmcLDMS8z1TO6VqXLe/VaDnI+gPp1UCczVwl7uDdP+Dx30SxQb05tqtTqFBsJQU6b1xsObWX1/jJyP6LTTKC3ZpIvUsC0Gc2/3CAoKcQi0vrgU7BxsF0/CArPGbygz5poF/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHoXgfQwVynrzlyAGIj8gjnPLra81OjQLNnbN2GcwKA=;
 b=Ce33MLV4Kg/mV5zgxuKEWvpmLZhObqQhVMw7t0ji4TADkBCwBugLkvhthWYwFTq9eDltXxwqpGZzET04h1VGKOVyJTeNUWk543FatJvFAS6Ki/+iZMyCwoddUtA2QQiTltGoJWwfeTcYx0LeVkimd1qWpl86PNDo71ADgIz+QXmdGxdZ2Gsn0wTr8SCKZU+Mk5qljepK9l9bGRJ0I8wfVkXsVptzix/fxRitE7WX+SBvlkCpjWfTb9GkMNpDwVuUIAfCZvYn0rLfWhQvkFXi2zDQqahhEJODTl7dg5bK4M1gxk8WaOO9lCJ3IxSLsqkfAFFiCvuQ+ch3O1h3zbA0NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 08:14:09 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 08:14:09 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	smadhavan@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v4 2/2] tools/testing/cxl: Enable zero sized decoder under hb0
Date: Sun,  7 Jun 2026 16:13:45 +0800
Message-ID: <20260607081345.61954-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607081345.61954-1-icheng@nvidia.com>
References: <20260607081345.61954-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: cd752945-0692-4e12-7b47-08dec46cc00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	3JWl9bPDBgPupk5oL9p8o2gxWpL1NroTgrVZfJ5HeAbMhcJjlwhFd9699NrkxxXCkjFgvbnfAJy/jPZeajJLVclwoEF3MAnes3HordOhQ9pdnu+UG7rpqvyW3jHz+Ek+WaNvT2JAOV5jBKiCuMK5aInxarFOOUicgf1QyYU2M4VXvJRNZmBNIt8RtBXzw9yqojIYHSqkK18Z8U+ZeKh/nIK2Nc+1TN/ggmcfUo69mAwCAoGGkDcyHshs++Gca5mCCY0/MPlgwt8hGINGBEFjJKwxSoU0Q+TNMsCk0ieji6+PN3qMW+hHZw+DP4zeyPZ4ayfaj7XEnS6bMo/U7ZU8mbTAfvB3bfKlCJYbqpUsp6YgJFJKaGoszq8p5BSSxpdsaIUZIeKSYS53UJU7sHpsQaU/IWkG+2WPThALfVK/V2N5tWXcNa/KK4rULtv0KGbVEVJu5NWsygq6unNWGeAiOXYz0cLw9fkefIYBoysLLU8gHW2BbdS6KP0Pp1MOgAwGjgg0Z164yx8RbYYytVLu/qBOX7vsZs7bJDrmdLKysERhesFc4CyEkA7mqIID3ACfWCChakIq2YrEQw9qLI6e7q2ApzqgjcX4VX4p+qDZt3UE8HMMuH1HMqePi1ZKXFTuHhLghv50Fq7bgwXyT1YXqiJ1xj0pl0196b/ya2Wicl1NIIwIsNzv7uO7ASIkbgTT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPKw0t9VR8VZQKIOj7akHIdvB5rd1SN8jsDTx1JwiR1S2Wd6pa9PIeugeVKG?=
 =?us-ascii?Q?ISl0ZMSdu80I6RvWkT3kuV2nuLiW1t81DJ1o4n7vfZfXeYmAGAQ8gycfCNDe?=
 =?us-ascii?Q?Y4N4MlByfesYKotJztStKfASwd/wRwVnMDhZpyL5/QIRwaOsWqnTNw8nLtp9?=
 =?us-ascii?Q?WK9r8fNNLY5L2qmAY9k5i85fXK7yC2iY7ngtfcR93uN+WtCuwS0dTvo/Duq6?=
 =?us-ascii?Q?6bW/ZntjluOoDLwfKtte6GdVbQLVaSw0rKBCQFYgFi9p0QE49MDH7IdxLfYv?=
 =?us-ascii?Q?R1w5wVebLpVqxGoto/ScB7WGKaWJVJVu/4vj2rR2WLC/oayvYsC/9J0AuvM1?=
 =?us-ascii?Q?C7NTYCc3aZY4PbC24/mAbU0cuTGVfeYuM/Pdu+GQ1YPrWZgWMCn5uHzKZgK0?=
 =?us-ascii?Q?GZL2pOjByhLPUXvDxUY3775sWP1MOVle4gh4F2zRNWiEq4ebYuNHDLIn0jBb?=
 =?us-ascii?Q?1sfsQgMUPysNXsrWW64jPy2OIdFc90cX5Kq/szaUQwJ2oRkUTeEtCC7/IDwq?=
 =?us-ascii?Q?jZviTqZK/Zrby9svnKfHMMgMxUT7pZRbQbFrNfnQ8oOJdFq+bV33ISi+lmwo?=
 =?us-ascii?Q?mjzKG/ROv6GPy/io1vT8ZXqehBVMq6XGKffs61+1f+4eXa+0Mv6NYhUQpjys?=
 =?us-ascii?Q?rO3XhzdsGtEIyRYSWBtoBzZ+f5LZVln7ulQDG9qcMTwIm5S/SstQmeaFnCjr?=
 =?us-ascii?Q?S4c6DlFDieGzv/3EXwnuGqqaSoWjr1frq/UNdwimFFVqcJXK2UXLO1leqG6x?=
 =?us-ascii?Q?keQCBLi+rPzw0iWflxjyZ+1urVJEH+zfyIdXx+DAnkoxJLlFsZfPDh7Cqzz4?=
 =?us-ascii?Q?JUuSmEBhPNlOq49MOVFZfIT1aKwGMxBpy4TuLi55zIujqzmP2gS8dPj3NURo?=
 =?us-ascii?Q?VtzK/2AgntWeIJtLxIrw/Ni97w3H8XtvXBgg2lMyxognCkXdDpS60LgT6/pI?=
 =?us-ascii?Q?M8PdMmP+5Oe7vdoHUwRpAc+acCXOOCaacHYRoQ1aaDSwkWf+pcx9HtuB9Wvz?=
 =?us-ascii?Q?ZhFq7AFNVIYQxDOqAoCFuQ88+qIlDyMiyeuXAf7H0qqC1rh5d/E9ZUgUDKu/?=
 =?us-ascii?Q?BTaG/R+H+5hJGO6ObVV4E7/644kbcbjme9OkrvS3bNjs+w+tZG0MPEDPyr7O?=
 =?us-ascii?Q?rO/oZOK5b9oM9MfJYxmgpmPzzJBF3Yp+el2OWqZ0JhF5xsSISa9AGr4gx27r?=
 =?us-ascii?Q?Ioy0tq5EUNFPHcFHK3KHp0YDJ3q2fUMe/nBwzrm7Ai1aVnT5azMZo2ak9Rzl?=
 =?us-ascii?Q?KXcmwhsBRCLSu4NzNhbsEsDci2GsJSDJY9qOMgEhw3ObLYi8/Pit71z+w1kl?=
 =?us-ascii?Q?egEsGTh+5ZhcsIS0q29R6h27PoP0e8bL1CKbJPJBA29yq9AqbWMBR3oxMrqu?=
 =?us-ascii?Q?NvAU6ltEeOM+jJ6Vt4aPfyKw1vgHdQKd+NDNeC7tL3/gpJftPVIyBmJAhLmd?=
 =?us-ascii?Q?zzCik/keJJU5YRnnOwcL+4bbrWAsLW5yqDjlP/bGZPgnvhgyswZ2GjxoBQJW?=
 =?us-ascii?Q?ScHD5ZW+cpKG1vwE/DtAg1YgDauRmbjcLjUrtxhq8gF+gM67tXA/2h0ZckJy?=
 =?us-ascii?Q?ZIaRHU7k93UHCG95nVxzIxLyhUlnJ8SNDvwu6pG3nq0GeRkG8unlUCC5wsvm?=
 =?us-ascii?Q?+yIXRuP70Z1E6wubo3kQ+VLf/upoWROk32ynj8tFphZLbK3TsqzQS1hU3dQ8?=
 =?us-ascii?Q?wGJainj6I1ai6pteahOoSPIAvt3JYJ5btDhnmS6SLULg810rO7Y/06QrMM3y?=
 =?us-ascii?Q?2t6ZFZJIFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd752945-0692-4e12-7b47-08dec46cc00c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 08:14:09.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDuRm4dBbrFkH5lzzVTJPQWm75s878gaY26kN6Ujx8bw1ysciQE0RyNUOc3yKTos8qPfIXu8sLaO8pZSaqEdnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417

The kernel now allows committed HDM decoders of zero size so BIOS can
burn slots with LOCK; cxl_test needs to exercise that path.

Add a mock_zero_size_decoders module parameter (default off). When set,
the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4) commit
decoders 1 and 2 as zero-size + locked above the decoder[0] auto-region,
mirrored on the parent switch and host bridge. commit_end then lands on a
decoder with no DPA resource, exercising the new enumeration and
poison-by-endpoint paths.

Gating keeps the default topology, shared by the rest of the cxl suite,
unchanged.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
v3->v4:
      - No change.

v2->v3:
      - Gate the zero-size + locked decoder injection behind a new
        mock_zero_size_decoders module parameter (default off). v2 applied
        it unconditionally on the host-bridge0 auto-region endpoints, which
        the region test suite reuses, regressing 7 of 17 cxl unit tests;
        defaulting off leaves the shared topology untouched.

v1->v2:
      - Replace second_decoder(), third_decoder() with a single
        match_decoder_by_index() helper, so all lookups share one matcher.
      - Use DEFINE_RANGE() for the empty range instead of an open-coded
        struct.
      - Set cxled->state = CXL_DECODER_STATE_MANUAL rather than STATE_AUTO.
      - Set CXL_DECODER_F_LOCK on the mock zero-size decoders to model the
        BIOS-burns-slots case.
---
 tools/testing/cxl/test/cxl.c | 83 +++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 296516eecfd6..190cb18d6932 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -17,6 +17,7 @@
 static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
+static bool mock_zero_size_decoders;
 
 #define FAKE_QTG_ID	42
 
@@ -1041,16 +1042,47 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
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
+ * Mock a BIOS-burnt slot: a committed, locked, zero-size decoder
+ * (CXL r3.2 8.2.4.20.12). Gated by the mock_zero_size_decoders module
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
+	cxled->state = CXL_DECODER_STATE_MANUAL;
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
@@ -1131,7 +1163,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > 0) {
+	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0)) {
 		default_mock_decoder(cxld);
 		return false;
 	}
@@ -1145,6 +1177,20 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	base = window->base_hpa;
 	if (extended_linear_cache)
 		base += mock_auto_region_size;
+
+	/*
+	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
+	 * endpoints mock BIOS-burnt zero-size + locked slots above the
+	 * decoder[0] auto-region (CXL r3.2 8.2.4.20.12). commit_end then
+	 * points at a decoder with no DPA resource, exercising the
+	 * zero-size enumeration and poison-by-endpoint code paths.
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
@@ -1168,9 +1214,11 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
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
@@ -1214,6 +1262,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 
 		cxld_registry_update(cxld);
 		put_device(dev);
+
+		if (!mock_zero_size_decoders)
+			continue;
+
+		/*
+		 * Mirror the endpoint: commit the next two switch decoders
+		 * as zero-size + locked so the burnt-slot layout extends
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
@@ -2030,6 +2098,9 @@ module_param(extended_linear_cache, bool, 0444);
 MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
 module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
+module_param(mock_zero_size_decoders, bool, 0444);
+MODULE_PARM_DESC(mock_zero_size_decoders,
+		 "Mock BIOS-burnt committed zero-size locked decoders under host-bridge0");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

