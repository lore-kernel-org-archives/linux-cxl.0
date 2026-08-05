Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFD73DE44C;
	Wed,  5 Aug 2026 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915733; cv=fail; b=baoA2fH3PEFyGE5g0tGDoFtSRDSgJQM8YCZnz8ZjOJePIMMjs5p5tx/g1utZs9O3th+ZVBDotzUxL4JFBz1t4EpGzRqOYwyO5x6z/bm3twVPH2ORilWHFNI8MWj7VmZHeg2nVyT7mey45ShchxVvMCp9GWdU/Nv6IQm6DDB8/co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915733; c=relaxed/simple;
	bh=j6hM3nHHW+wy+aPdDMCOurAiwyXpxMzfufChIz/y9CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ldn9ksDE6U8gFpB5NY+acVZ0Th67JskTw0sjHk+f+gE+3loy2DZpTQa4F7V/wkll8x6zpQtadvXDkQCLOqUOz3BVtUBkJ3FhO5SZPZHTUDMDALXEGB3CPV6emaJxu9ZXGxIddM/aYNZU25NzPM679NG3wd9LZgjmSwgWNyXyQXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OvgAU49z; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OvgAU49z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8cuPGiQ6SWepy9XvWJrQG1CJbf9XXwkhyTs5QQ6w71GnuKzjgiMyotHiF0TCN6RXtZryLqLsqxGSlTRDFvvVjjFMKxUr5AisskVNQL9WIvUhIsjOdOs8fpaQTqlk3sLcsdjAGoCXY+mc24XkG4Khp9o6bnk4q2jpNs3XYmZpuJxisxThez4gdk0FJ8+FUW8XIgCANXNyiQPmE8D0xecRb9ZiH6lm14Jm9EcF5SH12W93KX9iiOBGA5uGXWBuLzPs5yb1S9c4MHUw85KZbyYANLlaQGUJyUuRNP358pcsOLWLhsOArep+9F3+v3lVrTiVqQP2I3XOVxhceyU68uQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OadVr7LWfCyKIqXNGVTlgCDbDmYGh2JVTaimHxjWWwA=;
 b=AG+h27891tz4Gz9YkOZgyTQ9kevCqPX/Blrgrkq2HZCyGkLIhWx2SnipJkWSjJ41RRtU1t+cZNQBxQ5w3zXATylx28r23PTtj9ug7Zvcg0GDufh0soG9Akz9er+WBCmlgl4WubxvI8X7okoTllj8qmTv3BFxoBKFM/ID6s0KIHdS6BglHC/ZnMbrkpaYeN/8lzVlmjSfT3qvBVaM8PY3KXkwZL7u6CB+FHX6yRRj+6v0/JfZf8ikr1ILYFRlx4rMKbpNUSsU+NmdNR3ZFcuEPTxfN3I+jqQ3TjJgKVO7UlgAoYtxJHIlAFnOHBjJs9M8B5JG2/7C7eCEnXZItnyQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OadVr7LWfCyKIqXNGVTlgCDbDmYGh2JVTaimHxjWWwA=;
 b=OvgAU49zS3N1N2+CImswHTni4KjC1W8dGt4desPBP0Ddi5J17fmFsbxCThcKBiLnp01IHLtNPeUxRMpI4CWID+Jnbkw16L8EoNPWTIMBi+Q6NHBPTJDVSdv0qThpnHu3pOUaGUcjanwJWXDa0HPYcOR6RH724RZvYrsbdyj1eTZLzjRNq9SDk+BbqnPRPhovsRIdtWJRh5RYM9hARUUiov4ScSEC11myiYPZ+MuaXLvCcNHKzU5WwmG3amXdNmTlkP8qpOyyvKYEqfHXk79qWIVG8l7veMprl5XDbq4/D6c+/IZqnXqBKb2+DruAsW7qTHgOtE7QET1EUv6Ip49LBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.20; Wed, 5 Aug
 2026 07:42:07 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 07:42:06 +0000
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
Subject: [RFC PATCH 1/3] cxl/region: Reset software-created regions on memdev detach
Date: Wed,  5 Aug 2026 15:40:40 +0800
Message-ID: <20260805074042.30173-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260805074042.30173-1-icheng@nvidia.com>
References: <20260805074042.30173-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad7bc95-1e88-48a3-0b74-08def2c50b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YS6H+pf1Tl4YdXzFoToqCO1+1TxW+ln1yriGe26bJEWFPF1Gb2/UxdphjCYio2eLZoR2MZkibWkcCdBLy5xyz/WjT0dYmxCuqqO5OJxJnOiEOt5diZjHQFCF7kswu6+KduoEIkvoxBLjBv2OdxL5Et6BPLuj6/nleOeQeVnrmk2C499DDFF7EcmPCbaCic8m9QpHYPjLvbeA5kJpCpMxCo1Gc2KSYUbXU21wlo2CqLfIiO3oFlijl347/qfo5S/+SNuih6pf7akjdrsCZ9x47oaivtSc01cGsdWBxii9N8EV2Z9JcvWvQkuRQWN0vwn+3JEuy9qBKmTMN8dW63hm5joQRcNii+uJn64xAJK4TeQFurk7kcKUJtvaWh7lHaQnuNIGmtgm04Mb6hF1P0SubIx9Qg5xbS2mFm/07nlpOay1yjZynn1BiF/ItUIDrf1Pm99ngZymkOudd6Cfbzp9exd+DXhvgZVqYuM573T2mjulkIFbblj+KWMrdDBUgzhwqji6hLe8Qsie6QIVYuL9vC5r1jJVSgaw8wqB/6NtzAIk1ReAYvlQY3A/5dxfOy94pLIlkV4NukAwTVaWxYD4mF3Cb0HXSLtkqaSuijo6SFQA1faNDpAHLd2j1sBzp5f5PwEvX6coo575Xd7eRJ7k2OLBhM3VZIV45ta1o9/yQ8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kvUsQ4hfWyZV0aP0/1Ent7aUC9FfndjZSpfSiiMkstvCl231nrBwZrBoTzUI?=
 =?us-ascii?Q?+07MrXjmT7N8BWgLE4cHHN2QQMJB7QoTdPypMyEkLt9c28RtKNTy3qCLa7Ua?=
 =?us-ascii?Q?MZ6Q3WGaUpzHhqiAhLJ5p+h3DItgtMnyTGoxufsKzyXeDYdAD1DOIuH0zslT?=
 =?us-ascii?Q?WDrQb2HiX3BLHDrQa8CM2mXLr9/aIAlxHBtsJVN5r3htTHwaEKo2PMZuyghz?=
 =?us-ascii?Q?7dtkPoPudn3krBAZ+4zJWeI+Rit0MS2LemrHGT0Kyag+vNqvWxNVps9VOVY4?=
 =?us-ascii?Q?OsKiD0iWCYDgqcv50FtPnY5h8kRGQp45dR3oV1vPDqRD2cVtsnBf4xd40we3?=
 =?us-ascii?Q?oZqEWWOv2S41MieFHESd/TW11UxzDslGpH3DyZGUG8Yia92frhZyWhxy23JG?=
 =?us-ascii?Q?9dbx2fM4hPZuXk0FlyZIUCQPUgpYQKQ7V4clz/MufGwm0KKuscvqmXxH1ZFH?=
 =?us-ascii?Q?/nM7IO+8qjG7fT+vPTuVzbqX3Mxcjyreq5vLytp7Jr3YyOsqsbCHcMVkoCV9?=
 =?us-ascii?Q?FaC+elW/IJ8HO+HoH6Izkp586mfPsLI13HRYS3UwhL6d7YTGBR3CGh7psIyW?=
 =?us-ascii?Q?r1SiGI4SFBcWwhHWPF98KhVSAAHNKPAJiLEGDmFChwB0AxRNbkvaOyo0kj93?=
 =?us-ascii?Q?i/+cwq4f06CW/wMAOQd9hWCDhrkgzyYudbD9hcZcJOnC3uXnwOVrKjtdYaQK?=
 =?us-ascii?Q?RRuj+3NJNT2KUXqBclxdYSWapPfqyWCxKD6MsVufyDPBv1v57mrv6JI/j6GR?=
 =?us-ascii?Q?v/p9kdvy9DZKSDv5/CIaAPJ29aosNjreP1j8DeokLZrOi060oWhs7ZIcxtdS?=
 =?us-ascii?Q?XFStawl4/JLYPcY0HtDRDPman5ttfuDzRFh09JKf1yrgzZykWTtZcxZJVOvw?=
 =?us-ascii?Q?X0vFdNxkyJGgWO6tuKRfFO8Xi0yIqJSpoH8CIXhApooSx9BP+MAGXSgfzVhl?=
 =?us-ascii?Q?1Q3HB86EOgZduFNGImHIPz24TsfvNOM/yE1sgrnfy5OqKrrn2XaMAMdHFpej?=
 =?us-ascii?Q?697UvESf8v84rpDXN7PWzLIVhR8YIaESwr7RuyB3Rb3ypV4yxxviMyh3ua9T?=
 =?us-ascii?Q?aPYTZHoV6LTxNrl+89hTrJK6SFduYFaJcQHW9pbKqB93xXm7l9ItHKlyZrKn?=
 =?us-ascii?Q?qqVAIPnvEcivDvpft1sQ0Vfh1c4ekV7mIu32YI1/wWY8msmR8FPM4uA10eKI?=
 =?us-ascii?Q?dQ25iLmiF+r5BlQaf+T2HkI/en1Xv7hGU1h1CVuEpUO32loGEkSxugd61zVU?=
 =?us-ascii?Q?hlGpZdEGn9S9cCFuPWevur/tEXI0yTXyu6j7tZj1p0kG0LUIm+5zAm3Cqfnm?=
 =?us-ascii?Q?DA1FVPgptMHGsEE8Ay+UWMhUDfi8Eh+YYoh4NJWt7oauEvWGw3HD8i6+yfwk?=
 =?us-ascii?Q?OUSvS94vYjnywvFT+qQDmni9F1dcGMj6Nv5b4qBGF2+RiQBVU1eDhQwaCnBZ?=
 =?us-ascii?Q?0J4d+zjiTiAQPg3M4DWfNVjWnXQmQ6uAZwdj0S5N3MQ7aN9ECiIOcIJjG805?=
 =?us-ascii?Q?qeSmoHl2Cy6y3BrCNVlOb3Z+eSXGt71wpfzVCz5NznFkBeP4d2rkOV05X7VX?=
 =?us-ascii?Q?s5t7LVq7lz6L1d6df6UlrnPxYF4jNfsw6FXqQa5scBybJtym+0E3Nx3ZtZdd?=
 =?us-ascii?Q?j3uh6ARtk2WkDx1UyvY/pUwHr/Td1XRpkTMgzBAy2oVL4Jjz+zf62ntrX9mh?=
 =?us-ascii?Q?k6/nRgi/vNu/quYSPKFZzRhEZyJrNPoCc4k92gmaWGh2DfqQXqRp/q1L6WK8?=
 =?us-ascii?Q?4vzuvjmocg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad7bc95-1e88-48a3-0b74-08def2c50b5b
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 07:42:06.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhDcmzRx5Q2H9NITGMGXuylIzSFv5dptZ9LACtOd0nhMVuj1io16hMa8Ae8pFDa2cTo8BexD2g2ok5T9tkiviQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

A memdev attach provider locks its region to prevent userspace
disposition. Future software-created Type-2 regions inherit that lock,
causing the existing reset path to treat them like FW-owned or HW-locked
regions and leave their decoder programming behind when the provider
detaches.

Pass a managed-detach context through region teardown. In that context,
allow reset only when the region is non-AUTO, owned by a memdev attach
provider, and has no HW-locked decoder in its path. This narrowly
permits the provider to reset its own software-created region without
changing generic teardown behavior.

Generic teardown remains unchanged, while FW-discovered AUTO regions and
genuinely locked decoders remain protected.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 112 +++++++++++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..7fcaddc61180 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -39,6 +39,7 @@
 static nodemask_t nodemask_region_seen = NODE_MASK_NONE;
 
 static struct cxl_region *to_cxl_region(struct device *dev);
+static bool cxl_region_has_memdev_attach(struct cxl_region *cxlr);
 
 #define __ACCESS_ATTR_RO(_level, _name) {				\
 	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
@@ -222,6 +223,45 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
 	return xa_load(&port->regions, (unsigned long)cxlr);
 }
 
+static bool cxl_region_has_locked_decoder(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int i;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	if (cxlr->cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_LOCK)
+		return true;
+
+	for (i = 0; i < p->interleave_ways; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+		struct cxl_port *iter = cxled_to_port(cxled);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+		struct cxl_ep *ep;
+
+		if (cxled->cxld.flags & CXL_DECODER_F_LOCK)
+			return true;
+
+		if (cxlds->rcd)
+			continue;
+
+		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
+			iter = to_cxl_port(iter->dev.parent);
+
+		for (ep = cxl_ep_load(iter, cxlmd); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+			struct cxl_region_ref *cxl_rr;
+
+			cxl_rr = cxl_rr_load(iter, cxlr);
+			if (cxl_rr->decoder->flags & CXL_DECODER_F_LOCK)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 {
 	if (!cpu_cache_has_invalidate_memregion()) {
@@ -243,12 +283,27 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 	return 0;
 }
 
-static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
+enum cxl_region_reset_context {
+	CXL_REGION_RESET_DEFAULT,
+	CXL_REGION_RESET_MANAGED_DETACH,
+};
+
+static void cxl_region_decode_reset(struct cxl_region *cxlr, int count,
+				    enum cxl_region_reset_context context)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
-	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
+	/*
+	 * An attach provider locks a region against userspace disposition, but
+	 * a non-auto attach-owned region is software-owned and needs reset on
+	 * managed detach, unless its decoder path has a genuine hardware lock.
+	 */
+	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags) &&
+	    (context != CXL_REGION_RESET_MANAGED_DETACH ||
+	     test_bit(CXL_REGION_F_AUTO, &cxlr->flags) ||
+	     !cxl_region_has_memdev_attach(cxlr) ||
+	     cxl_region_has_locked_decoder(cxlr)))
 		return;
 
 	/*
@@ -350,7 +405,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 
 err:
 	/* undo the targets that were successfully committed */
-	cxl_region_decode_reset(cxlr, i);
+	cxl_region_decode_reset(cxlr, i, CXL_REGION_RESET_DEFAULT);
 	return rc;
 }
 
@@ -449,7 +504,8 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	 * thread already handled this reset.
 	 */
 	if (p->state == CXL_CONFIG_RESET_PENDING) {
-		cxl_region_decode_reset(cxlr, p->interleave_ways);
+		cxl_region_decode_reset(cxlr, p->interleave_ways,
+					CXL_REGION_RESET_DEFAULT);
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
@@ -2268,7 +2324,8 @@ static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
 static struct cxl_region *
 __cxl_decoder_detach(struct cxl_region *cxlr,
 		     struct cxl_endpoint_decoder *cxled, int pos,
-		     enum cxl_detach_mode mode)
+		     enum cxl_detach_mode mode,
+		     enum cxl_region_reset_context context)
 {
 	struct cxl_region_params *p;
 
@@ -2299,7 +2356,8 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 		cxled->part = -1;
 
 	if (p->state > CXL_CONFIG_ACTIVE) {
-		cxl_region_decode_reset(cxlr, p->interleave_ways);
+		cxl_region_decode_reset(cxlr, p->interleave_ways,
+					context);
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
@@ -2340,23 +2398,25 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
  *
  * When the detachment finds a region release the region driver.
  */
-int cxl_decoder_detach(struct cxl_region *cxlr,
-		       struct cxl_endpoint_decoder *cxled, int pos,
-		       enum cxl_detach_mode mode)
+static int cxl_decoder_detach_context(
+	struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled, int pos,
+	enum cxl_detach_mode mode, enum cxl_region_reset_context context)
 {
 	struct cxl_region *detach;
 
 	/* when the decoder is being destroyed lock unconditionally */
 	if (mode == DETACH_INVALIDATE) {
 		guard(rwsem_write)(&cxl_rwsem.region);
-		detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
+		detach = __cxl_decoder_detach(cxlr, cxled, pos, mode,
+					      context);
 	} else {
 		int rc;
 
 		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
 		if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 			return rc;
-		detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
+		detach = __cxl_decoder_detach(cxlr, cxled, pos, mode,
+					      context);
 	}
 
 	if (detach) {
@@ -2366,6 +2426,14 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 	return 0;
 }
 
+int cxl_decoder_detach(struct cxl_region *cxlr,
+		       struct cxl_endpoint_decoder *cxled, int pos,
+		       enum cxl_detach_mode mode)
+{
+	return cxl_decoder_detach_context(cxlr, cxled, pos, mode,
+					  CXL_REGION_RESET_DEFAULT);
+}
+
 static int __attach_target(struct cxl_region *cxlr,
 			   struct cxl_endpoint_decoder *cxled, int pos,
 			   unsigned int state)
@@ -2398,9 +2466,10 @@ static int attach_target(struct cxl_region *cxlr,
 	return rc;
 }
 
-static int detach_target(struct cxl_region *cxlr, int pos)
+static int detach_target(struct cxl_region *cxlr, int pos,
+			 enum cxl_region_reset_context context)
 {
-	return cxl_decoder_detach(cxlr, NULL, pos, DETACH_ONLY);
+	return cxl_decoder_detach_context(cxlr, NULL, pos, DETACH_ONLY, context);
 }
 
 static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
@@ -2409,7 +2478,7 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
 	int rc;
 
 	if (sysfs_streq(buf, "\n"))
-		rc = detach_target(cxlr, pos);
+		rc = detach_target(cxlr, pos, CXL_REGION_RESET_DEFAULT);
 	else {
 		struct device *dev;
 
@@ -2559,7 +2628,8 @@ static struct cxl_region *to_cxl_region(struct device *dev)
 	return container_of(dev, struct cxl_region, dev);
 }
 
-static void unregister_region(struct cxl_region *cxlr)
+static void unregister_region(struct cxl_region *cxlr,
+			      enum cxl_region_reset_context context)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_region_params *p = &cxlr->params;
@@ -2574,7 +2644,7 @@ static void unregister_region(struct cxl_region *cxlr)
 	 * region parameters.
 	 */
 	for (i = 0; i < p->interleave_ways; i++)
-		detach_target(cxlr, i);
+		detach_target(cxlr, i, context);
 
 	cxlr->hpa_range = DEFINE_RANGE(0, -1);
 
@@ -2589,7 +2659,7 @@ static void endpoint_unregister_region(void *_cxlr)
 
 	guard(mutex)(&cxlrd->regions_lock);
 	if (xa_load(&cxlrd->regions, cxlr->id))
-		unregister_region(cxlr);
+		unregister_region(cxlr, CXL_REGION_RESET_MANAGED_DETACH);
 	put_device(&cxlr->dev);
 }
 
@@ -2717,7 +2787,7 @@ void kill_regions(struct cxl_root_decoder *cxlrd)
 	/* no more region creation */
 	cxlrd->dead = true;
 	xa_for_each(&cxlrd->regions, index, cxlr)
-		unregister_region(cxlr);
+		unregister_region(cxlr, CXL_REGION_RESET_DEFAULT);
 }
 
 /**
@@ -2760,7 +2830,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 
 	rc = xa_insert(&cxlrd->regions, cxlr->id, cxlr, GFP_KERNEL);
 	if (rc) {
-		unregister_region(cxlr);
+		unregister_region(cxlr, CXL_REGION_RESET_DEFAULT);
 		return ERR_PTR(rc);
 	}
 
@@ -2893,7 +2963,7 @@ static ssize_t delete_region_store(struct device *dev,
 	if (!cxlr || !sysfs_streq(buf, dev_name(&cxlr->dev)))
 		return -ENODEV;
 
-	unregister_region(cxlr);
+	unregister_region(cxlr, CXL_REGION_RESET_DEFAULT);
 
 	return len;
 }
@@ -3781,7 +3851,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = __construct_region(cxlr, ctx);
 	if (rc) {
-		unregister_region(cxlr);
+		unregister_region(cxlr, CXL_REGION_RESET_DEFAULT);
 		return ERR_PTR(rc);
 	}
 
-- 
2.43.0

