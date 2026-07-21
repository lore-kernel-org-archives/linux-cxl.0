Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C0390CBF;
	Tue, 21 Jul 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624265; cv=fail; b=lTGkk0B67JoXDCWigd8XratqZRgkKlCgN1CtUWKF+wiWxORoR+dXCIabuD1EVyS9dTl68O5LX4ClUx2200mUHyq+PzNSYIe0K/zPkQP6JD9EO27BHWhFh5sRiElsIg9kt6OLIGyAGk6aJTDVCLR12Nj1pR2zoUuqQP4ZIm0BlTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624265; c=relaxed/simple;
	bh=wmDRIcSTFUiIsDiksHp0JHUzjzyx8eeWvpYd1/tLUYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6Wxd6UyfPXwkjlZJ2GLWpUO1YLVQWWd7G2sZXVcyx5TzV8fbZ+QcPWP7QuUcbVOJhlSzA9mf+mJ/wehqMRACQ2ihLAdjRg9fZXb7JeWoy7dbTCre/6NlHJIqH0gNyfPuUccQOKdoAp/0v7pEmeJHHopPAnakWSUr9bffXKLcK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pI7KBKZi; arc=fail smtp.client-ip=40.93.198.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pI7KBKZi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbEcc1n+quzs0Aby6I67b8k9IWj1q8UJkQC38PJWzQmOwAxssfxhHgnkO6brni93jat2ZISSqDkYLPxNHLLO3wnXPionqvSyiAPEoY4P6o3SFOBGCwMmYRpaohO3OK1Z0OYduPqFp4lgdKvusmeSRZXiet1WyjPWlvRZR/5sAQ4RobCnUziyXg35LOfNBWxfP6Nglc0UR6W+c5QbnAElH/EVV+Sa9ouU2Mp4c7RjMeQM/gf/JGaIPV5qPRe1CsvFB7hMO4h4DOP+JQpGF1tgRpNhe8EiNP4/xlqoeOT4ZtWiBQWwRKY5GRSLaalXGnmnVogBPXdJEqgTbbDQ6IJA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A558qqW1fT8tr7tiakAzzmERjDILPcEiZMdj9Fm03c=;
 b=ixYk8wcmeTglhjx/IXtVBeCRtwxLsjcIG90/kI5VGSJcOwbrzzZ8cmuto4jcyDIW1N/LtV2zvtDLHxu/GMxqA96N4dLWfOf/vQI0Dmrrw2wdUq9zYqUL8RCtM8dv3dgf+g6PhW/mDazc7ZM1vQcH1uJNlCEKW/1fA99NbdF3nZ7tIdh0epsV8BOgrOjMLEqfEFmdo4q+3OCukwiWkCBd8qcfVKdilSLTYEPCs4idahKvejEEWtHolLrZlkIPmgMXG2KgfdmlT6A0Ys2yQ5SB+7I+dcScl8H8sXsHioYoD+lYOxWccccBAJP1+agmF/RZCmxcdyH2Af09vE9PHDUQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A558qqW1fT8tr7tiakAzzmERjDILPcEiZMdj9Fm03c=;
 b=pI7KBKZiqHY+OnCMDOsetdzSCOf59v4T9yZw+HJ7tPz6q0ivv4crNlxPxb806po5U2cZgu+5YAug3pa+wzFTEpGPLfe2U8GRkef5lCbOXe4OGayQEXQ3czFa6dGQ7eU14e9q9J+5gyWb9G0CyusivXMV2WpRog9HMHuVvAfbFqJNDyiHRVk8chEjlZ/nSRUhAaOeO9mdHBUe9GxCFeLMQ8qZVQ+CRyEPjWxCwhm/rg2dmx5u/br0/PsP4vAHwBRzCLsqXevVEFC5Ti2QvgUMTJwkxzjGRu46r5pztvTXjHGpbY80sKKyzv/1ETTJtljxtdf5vGiWaRleKStEd4+VYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 08:57:38 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 08:57:38 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>
Subject: [PATCH v7 2/2 RESEND] tools/testing/cxl: Enable zero sized decoders under hb0
Date: Tue, 21 Jul 2026 16:57:15 +0800
Message-ID: <20260721085715.39322-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721085715.39322-1-icheng@nvidia.com>
References: <20260721085715.39322-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:4:297::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 834f7343-67ba-4dd8-ef95-08dee7061d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jrDeI6ncBVmLtzafIGxJD9nnFANnSksaosk7cbDdCZ4Zpv0VU47uJ3mwbmcb8FCB1QWeURostGL4NXoaGQ5ZnwzPy4yhE5zqw9BaOWn4p8N2baGadb8mT3d/1DlGEfgupCmS4Lh+8La5RJ95wUXkr0j8Y7koTTvlTQ3Kx+hrfyHbwWzktS2Qipycv34nKNfUUmM/Kp0XQiRclUieaOwQZHpf4lVVHsAKXjTz7+30w4Mw80Qhyld+/0eeDJOdNgHwqyRiMd3E1G9A+3FeXfBvEGDzd7RiN9MbxpBxZ1N1fYd1UUjROxi6CWDkYxg1fdKVESYfjvyuDT8OGpyi5pKASmVTTiY7RYcqyULsaJeVXkGI8g0ufX6QsGrruM3lkEbQFWF2yKOix0coWuvH+TuCyb0LhNOEgmSr8cYEzrwuQ0q2nC1g7aOns58AoIUYLrzDFpNndS9nsrOVxTrlnvWrkgePyqRJPSKUbK3PBwmXTYARSmow93gArb8UMnoO91CbtwegTNDCFcGX/eoykp+56D52qNYyrs9WhnhMUsVOC48JYGwvWBMl00ze689rT5FMaHQCJEUwwMVYuKe+GL5F3PbK/+mEmPXWOFolvziGF0XTJ1rPBqDAXW2BU3JT44A+hwfynIDwE4V3A9Gz+CUBsrF2aMmfTl2bJPt9o3fuf7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uXiuPw/MugJQMNZN9XV3zMrtiWcHYpL033zsS7fulwFuEw8rDtxrcae3DTzO?=
 =?us-ascii?Q?ojEl2k/jBIOg3N4o9YBLyYPFoG0zn+XEq8ztJLc2RDtfEA6DPYMRuA88AxMV?=
 =?us-ascii?Q?HgSc4wMLzogm2MJwO1kU9ksu3cXgMzlKWOVbiGbAZHsE0R1dTDfK82F1O6PO?=
 =?us-ascii?Q?0BOF8YnxoFMfBdDnizgOaj8hOeFDPzdmQV1a+7DnxyBTz9sqjjlnlMDywwTV?=
 =?us-ascii?Q?1H0sGmndbkNmPOeey97H0Ys6I/wa1U+GxjM9Y9mpljM7dvz2bSruSVbfiF6n?=
 =?us-ascii?Q?SPgDkul+/wtpq00+dQPmtb35ndXg9R+OX1Cag5+JoHHxEeaEJq6ClhSaTujx?=
 =?us-ascii?Q?CFW0p2FKpcXFarSlgWcTdO5Yh/Oj2jXriF8TGN+cxhlhsj6OTJ55qumiOeLe?=
 =?us-ascii?Q?Uh2hMWJlIuS47m0OsE/cs0nvuo1X35ca9Q/4Wau+9TXwUwP1znC1OzxOJ+Wf?=
 =?us-ascii?Q?03BYdmZ9Ku9wUm/K+fmOAzrt1sf3hRSnQyHbnO1S+iJgpsrlgjwnIBg2d6PE?=
 =?us-ascii?Q?wJFw+JgsdGnkJBHPq9g+xUaJJoRA6POb0+jNS7PVm4iEf8k99jE+OC8kUzJr?=
 =?us-ascii?Q?N+08prGFRoMwAbnrxe7KNM9CuG+n/fplH6WF8vUouth2f3khAYgSVE2TvjRq?=
 =?us-ascii?Q?jDNdd+naoTUiWDuHVjWl8QNVZdiUJb7b7rCNlvK9ZxMAtHpa2QMFp7KA4jBK?=
 =?us-ascii?Q?aY8sCpRMc0tDvkaVByzeh9y3Z73hjb3JK00cwiLp262/uTzr3BtLcG9xL1YK?=
 =?us-ascii?Q?lBi8qH4ScjqxkUbCMENiLRmabZ69+M8eZsZGxvruerTgrI/pyWJWSV8R8Esq?=
 =?us-ascii?Q?mUgCFOeCdUNsqWu44hNtlHbGyJ4mE8/Ye/Ufn8qCmU7wu7LgsB5hOQdr3e8b?=
 =?us-ascii?Q?Va6mTx12JPNsx6P8Z9emUsYXw/DnWJ0Mhxy0tDmiieb/+Epp3GVpwq61MpdG?=
 =?us-ascii?Q?QVE3IULJ9s1OAGWSZTxANgarCVdZyo8O6/G5rOEjwkWGgtunDx7BuwpsUlCo?=
 =?us-ascii?Q?sf2t7rxEM1FOSrJLyvSVQZ2vKbM9ALfqnMiMfk5Lf352nYgqAdDrLN7l6S2z?=
 =?us-ascii?Q?PQG/T3ck8gXnNsb2a6esVW6cYemMS/m0qMvBN/flpOosmwpVUmJ1iYz+XHIk?=
 =?us-ascii?Q?z4yCF/7Kgj5MTRBI7DT9ZWn0mbLqeN20FGZ1WrZfzsRVrExmZ3AIcS5FnAZJ?=
 =?us-ascii?Q?oMhM9brQOVhORHH+lTSyMa8SqrkEy/Jc2qjRnxKUeZnf4LuHp9PfFxg+Wgr4?=
 =?us-ascii?Q?PEK/8K6AGXC0qUToo8rUacoE798r/Y6iM47UgKX1HVhUdersWpCTJONtndvU?=
 =?us-ascii?Q?i5nYy24mcVLrqepV/O+mUls3UE/oWMzx0AgkrkpIztoXr1nSEFFtmKzt6qG+?=
 =?us-ascii?Q?L3E/VESVvD2FUH8RvlR5p+t7hqlPm8vw//dH+Z20fCaMTF5o5ZigbjMyfWu7?=
 =?us-ascii?Q?gNBzhDgi2tegwYcD8Eesi6dEvjACLMixU/fDhYj6KIdeXgf0bjf/FZITYh6b?=
 =?us-ascii?Q?NlVmasKWwc8Gpj08W4CiFd/H5CE1H9lprCPwVdjiHyOCwmmp1o3Ti3tN3lGB?=
 =?us-ascii?Q?EdSe+jocgxnmwRZqAkAfmTkUWIN/EjjOfSkqhh14BU/3JDGuyDBGiAML3RMV?=
 =?us-ascii?Q?pt12jZPa3UpJjJd8oH7fNrK2kcmNC555v4L7B9zCt2NUHgPyajjb7IiyR5uu?=
 =?us-ascii?Q?RSv4kdLbfFpMRClhEFURw8ImATEYZh0z9t62Lrj95qgmUeQ5y/VrCeD/6IQZ?=
 =?us-ascii?Q?WtDI+7Is/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834f7343-67ba-4dd8-ef95-08dee7061d26
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:57:38.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Glv0izLT7ofuQGeNuL1xvFzM3ChLgblFExAa1H5eny+Cx51004+IkSbgWtHrMH/03x2yw4sK/JTEPva1rFp5og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069

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
Changelog:

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

