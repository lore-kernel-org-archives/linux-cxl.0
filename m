Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23AB513560;
	Thu, 15 Oct 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057282; cv=fail; b=EP1J2xaYuVnyGk8SReZ9ZrcO5xw1CJjaJGqDWbVWR05G0RALqwkBmEL+F87yUixnIRgKX/4xJ1cm2wuo+2Vuc7CutWigiAkChEz0NbjnoGIo5Wx7n3dVSOapweyd0iyiQ6V0HWaz5hOePn7q9ZEjEX9bx9WIo/T778Tvj4YV/Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057282; c=relaxed/simple;
	bh=BE1WxZIzjjEwSzlH9e9dNz6AcYWjYou0S7R5JeD33zw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qzfKdzFJRlPf4jUnn8bzXYiV8363g9zChJC1wgrXKdDWXmUaDOcugxysFugLb+2qEWI/BgnCbMUlK3aMPYj5iRRc2MhCjoptX8dX2hQLLkWF5+hYfgz1nil+em7aYLqstWqWeRdLR6ttDNwO0K2odNGt2K/1+YgBFXZwN11A/XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nzwdN42d; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzwdN42d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6hjf3M7J8qnkhY2pJti7WZXvzQNjCav7RQiws4+k0viuC0Hed/AEFtG/QizAUDzF/Q1gvLLVBAlI7P+mQDvR0pzXkQyKy5uIqzOPfyc0SAkZzANmmtTLWsatQ8cr58HUa1TpuDmZRYw6oYIw8COoRtNZ6+FfY3WwhCKAOmayaWRJS32StXAN3EDnBeFVEJtXFU1Ctfrs6Hgq+lxdur4qIP5KT9e0dJiNRcpmsdLjh+ESEKFSxn4HeIQ/7PpWEzQ6eU7eJYhgiryYxtapGmQGvqgQcS/lItU6RMeke/iGGUVB8REFZtrLadk/i7KqEZC4uauzJbannyIIfIOtsVGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4VRKIXZbMll1fmwXIRwVxKPbM08CWF4jZgoc5GoS3s=;
 b=ebtYJ+NoJLQCkQPxlf+c2r+XZcwsphyIahl/GsDP1WoFA0E307+wjQd10nSw7msG4z6hP/wojQ3LhP4NgL5IehroMrHsFbyjBhqIJEaul2hU0z5gOlddPpHcu0gMT1vVjVP81/lVKj8Q9wYKFb6NRHd1czzwOtPQo6sK/f0PhfA42Tfu3itTvIO8iCpLq0mLbRwYjvLqpvCBO9p08o7lE6g917taCAfDGsSdAt8nfrAeZuNaB1bN9AoSIf74aHyN9UQv0UiX5HGdnya5YZFFVSbmunWwjSpuzc1H/GrT/pQBhq8hIJaElHmf6in0PPomFug9kfgEnBoKZbXpoOlZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4VRKIXZbMll1fmwXIRwVxKPbM08CWF4jZgoc5GoS3s=;
 b=nzwdN42dDknemNjkfhXXf39a2/8BUTFxUqo9tYfx6PtfsA9EBgGPHP4mJyoTAV1r91VH6o9a6jEf1OOqPUxNSd4o2gyZf0ro1hlck2t5HvDL0phpvUKPrs7AZUWphnSK5comVwBLi7GcLG2VuINiBEEK2K/3fpvOnKR3CHBSeWe1Knp9MXkyasoMkT71obJKldZBCol/4Rd3i1/kC7p+W9gWOW9MpDP9vcc9Q0ckrVHDBA6EO6vGMBEFi8N+qQkzKXfEuqma2S7bWGBTjIUPcYw3QanDF73H2crgYic5bU7Ux03zuyVH6wF0M0wvTdzNaGY957aqJZboaaIFBUm2cw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:41:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.020; Thu, 15 Oct 2026
 09:41:07 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] cxl/region: Calculate peer distance only for reused targets
Date: Thu, 15 Oct 2026 17:40:59 +0800
Message-ID: <20261015094059.46818-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 00438283-5e3e-42c6-f70a-08df2aa06fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|56012099006|261009223027099003|11063799006|260925021311599003|260925022911599003|10067099003|18002099003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	Mh6/fY/KAlkGt+hpgWuYUhGZaE+rOWRA+PvGto7aX7KJ0silMWzUpfl0FD112ITgk6xI7kK8O6VJOL24Fj7zJJ8NabhoNmNvUDmsbO65jfYtP/5fx7KVsAVnwwspunh/XQEnfu+YM9ugpOU6zkir8Qje4h9MAC3NFH6IVIfwstv6to+C0NOHRW8z+2pavhbd8voRX4cwsMmGUkfxmsxVveuWAIhsNS0YDNUYZFSz5p85L5Lb2i+acANTt2TheukaIr539BnAABb0LoFCd8UQjmnqZnBFg+kb8eLk9VdydOzUJ/ZElSifbVGWBzvrSiQPBOFg/4kh9RhLzRxHaHHaxYrXGCi6oE3I6vmebn3MmJDotF9d9eO5wHw9mvLWSJBzCwwfn8VpFOtch3ozGu7bnu7jKTmxsmlD05bto4GxfMYVdVVDsTZ/ZlXp671koOJ+vb4jMuwaqVdxEc3Gz2OVKDtB0qWnqFJCGUeuy+EavZkGcBfqVyr9mR+phz2xvjm9zrxEp/a+vdBRR99sTVsfLPZ1me9jkr2bjMS85/cL6/XIZ4RjCSzDKKoqlYRv/18ekIjUkbSNJ6tL05z13i9Tnv8vNnbZFEJ0CyI/7Qp+Mo632noAzxYwI4aKMQ8f+lLs/BG/6wqhXxrmTixsLwcrWfUNUr8ZF6w24RhLiyypBJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(56012099006)(261009223027099003)(11063799006)(260925021311599003)(260925022911599003)(10067099003)(18002099003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oR62QNMmOZ0al32I+/Jk8dk+VvhVIhyBwHWuAT0Thuw+PoU5DPkSx+sPpPsq?=
 =?us-ascii?Q?N8+u8RZfP8pubSDnw6LYKZehpT7aFvaiTsdoDjoScomq+9HqwT1gmFPrlTkw?=
 =?us-ascii?Q?mlI+6i3Jx1gjKBkQ3tzMEyABssclRq5YO9grkA6aBnGAk48bJVYewJNRvt0i?=
 =?us-ascii?Q?/anLHre78sbOUx6Ihv3uXI2Jxv48WSgWVyWgR10HR8/gIhNvMXxKrIj3o2e/?=
 =?us-ascii?Q?IjZA7naFtAPsIMu1sFfcAqkO1VTLWti952szGJ/KMt6+Agk2DlQHjkYZsyvC?=
 =?us-ascii?Q?bjfD7EJRqaafYsH45UJlxLZhgvlwswGkixs8PJ82TRbW3wLJg/QrBs1lnv7B?=
 =?us-ascii?Q?YEvIL5USgrA9Q+HyX4lKzsmcwULxBqV/pYak9FWiGDrU77sO3xGeYKKBo5gB?=
 =?us-ascii?Q?I1TEuOZwS0z8YIkq3lUGHSGBwNSJh+Usn1RywxYxnsxQMmWS3tf82UE5RsSr?=
 =?us-ascii?Q?VUnN5WB5Jd4mGp0CbkJvX74upEXOXNIHHzvMlv6JTJzSs7JDHx1xToqDM/hd?=
 =?us-ascii?Q?aLLmkO9e07C17xR/7ddpIG223rRUUbBKhLLTU2K9oWzsw3bY5YniajpsbxUo?=
 =?us-ascii?Q?2aCNFXgG+gbAN/6KAGAxcsu2n+rFWbqfTqJYNlu9W4KHP/WehFEpq+9fKx6U?=
 =?us-ascii?Q?uzXCPwlWt03Bsjp2IhyXG0r3wQiXrPL0mcfQdbMtO9yeV1Qg5Gy7LRrUA0Lo?=
 =?us-ascii?Q?Xgl09fUkqNc60hJwF4AZqK2rG1r2s+d86LGNRcqPorPdgpR3ex7z8XBTGNub?=
 =?us-ascii?Q?Qkys/Q97xD31xMc9J4ATP4LyhhQ2N4/tXfoPkbPl/Ww7bWwGozq06cQ1NElv?=
 =?us-ascii?Q?d377r3eNVowrzPMP6T6LXAJEce7ZwDM5DX9jJietgSGW3aro8Y8DesX6PWsL?=
 =?us-ascii?Q?TtOixUdDopudAAzT2YgECfUXAMzkjzOe67d6lgJKAI2c0lcTFe1XOTHgPm5w?=
 =?us-ascii?Q?x+BnhtNm2VFn153bGRQqluioWp/UNd+pry+HXqWzIDRrQWi0WRZWxTHiWI4Q?=
 =?us-ascii?Q?ZD4ti5p+GW+DqO7l8Y6mbba6sp0Us40azzHTkvslf0flMDMgnD+pPnjZkXho?=
 =?us-ascii?Q?hVCFlqUKZVIgycaWcCyjzdhy90GAcXf34IrKldODeRl0yu7GUZnDRknfzomb?=
 =?us-ascii?Q?O164/RpP0rEcxOr5kmDlvHbcPWrwa7bzQrSIVH7AHWBjIcWs1OlGUo3W87AQ?=
 =?us-ascii?Q?jqYSpITR3gzUp1a7XP4Be6CR5SEexVHWOWpxYFArUNhBgNbAwj+GiD5KnA08?=
 =?us-ascii?Q?N3hZDVO/LZ6rgeytyOVQFdIyLnSrCcjm78IYiBHRDtSJEyfepUXiP66hF2Xl?=
 =?us-ascii?Q?rdJLoE1HwGo6a/eTkUpa332QyUwYn1dZof16oFWWpYErRzV8lIURtkdbfAoO?=
 =?us-ascii?Q?WD34NCykw0nXVKqDZw3jREtxUIHjnajzx2OQgwi9Tk9Hs3UYEErHWl0kIctM?=
 =?us-ascii?Q?XKHlPWxycTIe2NS+vkcVkBgVwFpl+QORGukuKFYqVr3UPhjIxOeNKbmdMU8t?=
 =?us-ascii?Q?RbSWTG/4+ZJ28Rsnh8y4zdjU0vSsfhi2XXG18lNzkI7NUCYtC08gaFtuEYA1?=
 =?us-ascii?Q?NwOA5LkqbPZxdCl+KrUubMJSqMOIGItslZgVq9UMnCgyeDTup7rf1dqC+WDm?=
 =?us-ascii?Q?/XV/D5SdwL9N6QbxPmxsxbjh0FvekHZ5U/zk4oyTK+UMJ3FpZiCTHmQjIKKY?=
 =?us-ascii?Q?jXjxO5JCc83bq3wAKCCKwmGjvF4j+++wz4HusvVjo11jxA8R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00438283-5e3e-42c6-f70a-08df2aa06fda
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:41:07.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ7owlmp4iDVJB6zaglaFd0oJryV/CEByYVIeyMIXs6Ri7BklY7eYPWHmUlCqSX340+k/6BLdHBD8ftQwnmDIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

This patch depends on Alison Schofield's v3 "cxl/region: Refactor
cxl_port_setup_targets()" series [1], this is inspired from that serie
as well, since her serie contains no functional change, I pull this one
out as a standalone patch.

cxl_switch_port_setup_targets() calculates peer distance before
searching the existing targets. When the endpoint needs a new target,
the calculated distance is never used.

Move cxl_port_peer_distance() into the matching-target branch,
immediately before check_last_peer(). This avoids unnecessary ancestor
walks and per-port region lookups when adding distinct targets.

[1]:
https://lore.kernel.org/linux-cxl/cover.1791860305.git.alison.schofield@intel.com/
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
I don't have available HW for multi-way interleaving setup, so I can't
exercise the case optimized here. I would appreciate if someone is
williing to validate the actual benefit of this.

Best regards,
Richard Cheng.
---
 drivers/cxl/core/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 50f4830c225d..efd173c57dad 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1666,10 +1666,10 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
 
 	cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	if (cxl_rr->nr_targets_set) {
-		int distance = cxl_port_peer_distance(port, cxlr);
-
 		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
+				int distance = cxl_port_peer_distance(port, cxlr);
+
 				rc = check_last_peer(cxled, ep, cxl_rr,
 						     distance);
 				if (rc)
-- 
2.43.0

