Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4672B2D97A6;
	Thu, 13 Aug 2026 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592771; cv=fail; b=aMgjLYVP5uzVeSWMEEXgeamrS2H0fyKPUSUsy9Qowdn0ihWpuTP/yr4NTXNIl2O32xoH+XXmLy+S8ISpnhtRXF+qacH6QrQ18gStETbtStj6YNT3tqih7GrkrhJkiXIfB8LRB6uyp/IACo8OmloGp3sD2My5MAB+IpNCDG+8PzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592771; c=relaxed/simple;
	bh=aQtHP7Ze9GdkDxXl9K5JnPHmo+04QcH3/PQW65BMiBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DlcdBIiNXQjR+ULakCy8nlDq1rDhmwiyCwVKpEXOpfIA7KWQNSVSdODCjp1hcb50y7xWp02ypsfqaNgRw6CT/0q5cluKMBKm3fuVHgGXJIQlEFtCe42CmqIxcTVjG9wHoH6kv/YgWhbOgpKcvO9bDlx5sFs8/qbwl6tFkkwMwu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cemuW6tL; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cemuW6tL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2qt8ctLLzP+7OlVtHJiHDm2Jz3cuYG2xBrZUmn5Pu7zgeZAEypnqXY6VS/ygZiSnYbWnOERIPdbKuHI+ld54aInc3QBY1/gTsMlm8fGOFdeTH3812rpAOBhNtnMkpiB0s2KEb0hQ/83lYbOPG5cRmzwZ4VCZvKMhcnGlKwfSn07YUowMW0lLrEDr3Jg1Wyab7ux8h6/QaBF4/xq6j3iE2bPdrYas6dpEbg3Juwz5HtZBsYka+wtiE3eHEcBzfxXPMJjPnAAgKKDnBeE/6j0/oGuDkz+m2t6h6wSzFjwe72G5Lgq/7qdQ27GZdn3L02Ks9irOIF1J/HOwLdKmVxNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St0FiUt+ChylOJEPrekuFWzTORS87e7QXIfNU2Fyjbc=;
 b=cju6Qzp2XRIao0tLsluBL2D02cjEzorptcPf7dkLLni5kI7VrJmopb2NGd3v0UbCKH8Dj9Z/5FK+I1JrJmZtbnb7U4fgmSxEsY2ZKHJpEjV9zcLcrodd5kEut9PakIbOuO0ZxTeNUhMZCWxR2eEWf6+7BEdKdIvN7SM57y6Wc9dMbwDuNquisav2JKvGzd+pTN/gGxWPuFs9LAV+mg+c+dO4Q5gaUcfSk6saOdHdUJNMAvIHL6xVkmuU75HVnUsVIkpksCi4xTpA95nqD9/W8v2iG6oe1GXYqx4CbP0/LQKI5663N7d6QykFMucJyM6hs7C4AzSJTX1N96o1ovJgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St0FiUt+ChylOJEPrekuFWzTORS87e7QXIfNU2Fyjbc=;
 b=cemuW6tLn8bk843ARRo0rr2xaAk6slOKO+ni/zcxQcTW5PL9Up1wPWec86dVVaFP99/tU7fkZ0H8RZsBOnhyDw4guiYVivkRm0/D8npTftvy0xnaebJwCiQsJN0P7gmo2Vp+3MKzPLaOJ6SGNyaTD9YCws+caz+OGWt9QXqWd+f5X0xD1O6N+DowivTbIYTIUO6bve/963otKLA9alqWloBZNEy68R5qd5QLX/2DiM1cTyz3wJjoypuuIbG5dKDHDlvhtzYHk1V45d/Bq/IfqOj7NtRDLC0orKxDjjdauAmZCqDMh6+QbWcQUcqx/1CDJcSZMuuvjvso5S+rEYv/jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:46:00 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 03:46:00 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v5 2/7] cxl/region: Scan all partitions for unmapped poison
Date: Thu, 13 Aug 2026 11:45:33 +0800
Message-ID: <20260813034538.13189-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813034538.13189-1-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: a6be7dc4-3b9f-42c0-c809-08def8ed641f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zr7SxEdI1DHiDryWG7yEF9FDv38x9clpVwLbu2iy72Po09N+6QVEtJ6QVmW8R/Poq/Iur2SbzOvTthK2dcQKvG0PvR9vFkTCohOxDc7vD05sF5XixlO83pV/SQqZtBd4Ud0SbN0Txs1CeUeM7ICen5K1u5W7epC2k0caEGAcmpMWo1XO1EHiJwA/OdtUwXmC9mkdr9dWklXcI56URc/oCyyo6rMdd5aplFr1oOtDMCG8XOEMEPjqoELIUz0Usp+Ccig88sJadzAfG0o8qhLM9DSncH4WD7Kab8nia7ng/g0ykJXHs8X4yc21pmWx3TdaZz1YwvYXZiIu2yu2xHoPSfvbRCv2ah2mbZDTCxtMw9rpY2itObSiRtKyyu6a/RHuw4Q7n77TBPMLfgKnvAPLDkllHY6GoFC75/+dR+L2mZMCl/RZ5qkKi+6yp0yVO0TMHengEVuG0y7i6NXT31bjlankghR56jvyJmyeU6CJzvf80driPARklSrlyTyFlwIBA6XG5aj57UwtIriG53HuC6n0PQ/KY/EDs97s3yLPVdPfSdJZbdvZfWf1r8OkwO2X7WIYbpgYTegy1RL48okYBSyjAO5ZzT/MLFx79KFdHe2QL2GGJYQoGH93lcAWtbPr30ZAoZt517zcQ03VQbpQCIhTpTZEObyCQ8256G602YU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mLstW/Y6p1MxUE/iYzKz/eOJrPF0tEmfV3t6jdtuHqcgxkI6IIyoqq5pkhjs?=
 =?us-ascii?Q?dSMAkuNCnfoolJx91mnQztkQ5miAMEvcFMix1PKW47UcR4ctJXMBqvBktZDx?=
 =?us-ascii?Q?Ta9tONTBRPPjJz77rspwyFxJnQIDb/JY2R+LJvnvnog0mSMZgazlkrt/lAhz?=
 =?us-ascii?Q?JEXbtudxclSqRFcIABDDJP47bcQqBqlj2NK8TqvQNH1ASVBhHnsaKPQ0tr1D?=
 =?us-ascii?Q?wYrvYwFak1oySkCDP1WBuQ9jFOxFm5jNJwxcN3lTvc/hfcym/THTNg2QDmLd?=
 =?us-ascii?Q?LhXMifmeDLquOkxI0uXc50C54GHxhsZ/k0xeP5FSoBBdtGLHiL0QecV7r6Wb?=
 =?us-ascii?Q?bKzDqaeoDi8pZ6xEl9dAu2kqE8QP/u0YKELWRid1nE6T/7DXy3hpsFlInBN/?=
 =?us-ascii?Q?uNe0dhlIJJHBfEAPWrli0ErwjBU/AhbwsJSt1FXVsb0JTbPR/Z9Bx52Y+iW9?=
 =?us-ascii?Q?YbouKvuXGY0+vor0EHFxP8lvhwXHlbRJaYy9TkYV1LCd+ybW7GDPDp656dEz?=
 =?us-ascii?Q?AM3/N1n83xRD41SJOv3Dvvgo+H56ZA9FQ60LyYD2CiNtnCGja4yr+tLDNT0C?=
 =?us-ascii?Q?QBcCW4k66PftRlTW7NNBm20OyCkGkA0o5b/N58XDPAxdVlDOUBv/cVSkqVqB?=
 =?us-ascii?Q?41aw+aOWC0RTniUBbDjtwzD38n/FEdfYVrLQcTX3hjmk8BgqTmIigefTEffe?=
 =?us-ascii?Q?x1tkYVhCmBY3/tbnaAsEY7B3rMgPyGQ1HhGTMxHR4iSS0E1pjWQQpriIcFjz?=
 =?us-ascii?Q?bSnjYS7N+vWIbeIehhKbsLYP9mea4IN6JAgISjEQAHemOQRsyIZ70zBI7bSK?=
 =?us-ascii?Q?cNblRK3RfslKzF0+3KTuU6jhuSUbFgPlW248c4KSp4ecCxYh9c8xnedu/mBo?=
 =?us-ascii?Q?5c3cu+iDWZCwKQpFZyuOtzgCgH8zqCl1051II6eSbp1fcePQ60TjFalp+o/u?=
 =?us-ascii?Q?ntjHVQxHoKH96vbuVvltJXBnMJFHzrCKn/twRtdg+aXF6AVUd/ASxppBk24X?=
 =?us-ascii?Q?kTs57+/eIUextvbNu9da8qOfO30zyQIKKfepL0iR2YCe+70Jjz/Oypkw3Opw?=
 =?us-ascii?Q?8Qb8lxNiOhz4OoVccpmazxQ2KEl/BETEuTncOLs/GILyoLqObR2TmP57qX9w?=
 =?us-ascii?Q?k97CqnRsvlYC+59ZaZ635jobxWTbe0wEsfBsdoFVhXfSbXQzp7M2VIe/tmoF?=
 =?us-ascii?Q?Y3jcyfZVcLrro+zbX1HAPiMq6PjEILNUBGdf0w2IRkpnwqB34Ri2Zh7kKlVl?=
 =?us-ascii?Q?U1llbKAv1reAn4mxIuBkOmAuVWOZCoPPOUWXL0fgUSdec3xw5sxxRs1zikQ5?=
 =?us-ascii?Q?A+HlZfbNuj18jQR74Lhz/fTfyo6c2an3R7x9nMYpY2A//oNBH8yOQrZFDWiN?=
 =?us-ascii?Q?OlqFZDbFRw0UV3+eQS2zGVIDpcznptsn5INfC2rgDqLOynj4KJ/bqIecITVT?=
 =?us-ascii?Q?neYWIUfEOLnezSQ8wxLpXaG5SmbyiYXxBe+BET6HmtmGQPVFrPPXhZIciAY9?=
 =?us-ascii?Q?lZuXCmdxJoqXQWho3c9jTb6pxYCy0KfBKR09uu9UD14hyK0VM1xrMkH6oM/I?=
 =?us-ascii?Q?/3IcIJsgA0W3dp9ACLWfhLojzve6fP7GoprkuatTIlRRGqFGI68XsJ7C0v4c?=
 =?us-ascii?Q?F/ggBINOpnmyLOq9OaBieJ0iBKHZ6CVEEJcPlAzCUIzLPBSwrVtgLPlPWrAd?=
 =?us-ascii?Q?G90iMme2K739iN8425s5PE8BhZVqTFtKY+IPEHvGr4LK3pI//06+kRG9EnwV?=
 =?us-ascii?Q?9VOzqN5BUA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6be7dc4-3b9f-42c0-c809-08def8ed641f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:46:00.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5iBU9XnUCWgXa+iiP3CIstB8CpTvuweLZESgoR63oZF6XSSJyZ/yzKQKhBi+xo0bvpiO8ZRLg+Q2m9WX1ffMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
from ctx->part onward. A fully-mapped partition has no unmapped tail,
it's a normal per-partition state, but the loop treated it with break,
aborting the whole sweep and silently skipping unmapped poison in all
later partition. Use continue so a fully-mapped partition is skipped and
later partitions are still scanned.

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - Tweak commit message
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..b03f30c04d35 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2928,7 +2928,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 			offset = res->start;
 		length = res->end - offset + 1;
 		if (!length)
-			break;
+			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			continue;
-- 
2.43.0

