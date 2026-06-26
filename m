Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAB3EBF20;
	Fri, 26 Jun 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470497; cv=fail; b=CiOUB18RQkogHbtccy+ZpFH6Ki16xwDFLwvvtV9Hyk0aM1+NvnOtG4e0EI2rI/Zze18p+YOGgqamCzpUaXn6LFV2dufxTSiQbc9CTojbdv4Yuf/mzR+n/vAyPxTjPeDp9xzpXSEJM/8GUznXGwnZO22yIlHPRwLeO+dBVRPat6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470497; c=relaxed/simple;
	bh=RyFoRwCu8ZYwFvFgLpVlOp+Uwcy/ak3ayNDDEwQH/UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ek/DvkTXOzzWOIp0QCgR88Gz5CPaj3hqY8LeI+bFGkv6SvYH76SlGXX4dNPA6djqUgvfUkadTfyepOyySH7gzudaEDDQaWBTbnD9u0ZZEeNTDOlk2Z8BMTdYeOrPGvZN+DNhV49+XF3NVBO11uieMFFzsC8eugUgj4lmNBIq2qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oTEYBV3A; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oTEYBV3A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7FpPN+V6Roj1gVq1MeMWPQOKYhPqUx90opQ9N/wABmTWH49zOTcKOth6lZMqaagwAwaLjsudQmHgv359FA+ZH89oW994d5VlkR5CNYc0AItyLPSKa7XuD8TOcfm7rhOcp4eD3bQ+ujNLRRoIQjGXk4wYmxTefm/20+7W8MvNG2m9XVZ3mqwbq2QIq2mXgq3UNC1H90iOwbJ14lV3iwRfbsogkTckvt3LvxQdjgiMcr3k5R/XBe3D4UnSvwyCCVCLdKW/+YS4Cgd99V42FsZD1cgoGfTdLSHXF2u2TiM7oFn/I9RpZkayU7fHy5RDfV72OM/WNkKXlUnX80ymjK46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYzLVnsP0sCNcJ1cPfi0YKDFYjP+or2YAph4rQQn5CA=;
 b=f/d0oCHwWHybEpIaRv60yeAwL8XcTy60fnZRK5kuUBXXDE/9gTnf8qN/4ir1Sb/O3t//7zebWwLrEP6gQvPzdKwcb5rVySCPhi1gQkLkBt+Ub/J9CKi9XrCaQZPYoW1G0yxp1HthqEuxHyT3of1SCXzEaHnr/88L2JKYuwnQz7PmjSVSq5PcAZgz81V5cS5ZZKucOyPUEQnJMi2ecyPuGgo7rOCipIv2piGCq3Pzz+FTFIgC9SFEa1TA/vPl3HLO0dN+g8xIhqsmXY8YOfQWx8Zf1hxj1l0q/riDwwg5mgiHUx+UWOJfeOqzzRVCGiZTLtNk4UdvepNkBliBgj/K9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYzLVnsP0sCNcJ1cPfi0YKDFYjP+or2YAph4rQQn5CA=;
 b=oTEYBV3AW5Rvs1v9ELRHKZocUBkN9TBVUhPLhP8gtVpaCuYpQGA4XS5VIw9ibxvGCmxfOvdXcMx3k7vai1YTcJqBxkg7yBlN2QCaLsufgfZGXjcGqH8KLrDaxrHoRO7nCWPmZvjSnG2NDAl+P0GoVVZC15CoV9kbuMbOtqUjhAjA7sjCVY5yR3wpvodVHkuXml4lPE2S/OcmuV2LrGVhLlEvyf3WWIs+bkBJaWrk4jJsNCmiiY6Vlv5RxTWJ3ryp/6mVWIzpsLyZ/Rcj1GOZH1eiKYEqgKZsq5pQG46peC7wE++nJGquwDhF5NqvPdWSagXReH6h2jiPfsN+Ja6+Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 10:41:26 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.018; Fri, 26 Jun 2026
 10:41:26 +0000
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
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v3 3/3] cxl/features: Clamp Get Feature output size to the remaining buffer
Date: Fri, 26 Jun 2026 18:41:02 +0800
Message-ID: <20260626104102.53892-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260626104102.53892-1-icheng@nvidia.com>
References: <20260626104102.53892-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df1f1a9-f949-4eb6-4194-08ded36f7922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YsMG0zEkPXMX1Zao+GO5t7Cb7Vb11r3MV/9zV+fPLu0kMdgX6ZRiyv+w+f1ead5+HeDqsgKrTAyOJuiMBIaaKVsPOrLLlqHuUpuG+e6nbjh14Pmj+EOjVyarYCykqv0A4w0duZNUXHvV3bqKofTcS2VNKwkztrGg3BEDlytpR1liUFpWOC5TyAXx3BGSGAEKuWylmFpS4UiNdJjNxGnaEG8R0/Zww7OafX4uh3PEuuzMFAvLBMHLWtnwd5n15aTSHca2ozFpaVMMh2S4G8WzzM7N5VrbL+atcAL3E7euaSKiyyAY6R9dC7P03Bpjztb9fvhY2EGcfCOuw8zEjBge+V71SdIoY4ThXnVFLaMwycI1H5NMK2BXEmlIkFLPheX9y9JcT/CyFHg9AaJnKyMC0cf03TtlR1n8i4KXos1x5cj0Xeezxe9nRmERVf7AAUfDmb2zWbdXWIEgSdZH7dsYo+6/1MyaCJB+bau1KE9z47zTdTpWu+LKmR+sd7r8WrsRYFlOM0Alrdn07DvU/Shwigqf3cQBBVwKM6tRH32izKnLkLNz+88BeKOZ+0i2nA27iflFD6LiD1xJKftihfDM8LlLqUfvKsbQJ4P2KN90fPmJ7g7SnoL6XMts0Xc/WGnuR05S83VFqlIHPGQ1C2AA1VtJBxkjZ1PjnDx+kxAZavI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kx0JSdlkFwzoz1Hbrp+t6voKa0JZu2nK3T+4bGScPPh4ZA/Kkfs3JpibEtlA?=
 =?us-ascii?Q?txmMNGVd7mpp7VmU1zxBJTy/vITnXiwAxJ2GhTQZgD14jEa2TxRI2Hg0ZvOG?=
 =?us-ascii?Q?oKnWdtYMWGXmGqqn+gYAIb/uXj5J9qsn+H00yDVTJ41arukWEVZ+sDE3WE0P?=
 =?us-ascii?Q?dwRqPO86LkGG75l39gibTvZ0B6MtKixSM0pTsiUofz5Ws9xsDOtlL/F1jcTl?=
 =?us-ascii?Q?EBnFVRdPFgTYHFaTownOQaHNOzBz/z4BgMIkD7XDKDDSAtCsGfXYMkWvQzWY?=
 =?us-ascii?Q?yLlGfRbcr9MiSysXXzVH/2GObGAr2Q8MTbcF7tZ+aOEaZazEQJan++8H2oI2?=
 =?us-ascii?Q?WRwwm/XoycRdan8XOZSrP8LZ3dvvpTn0eRC6z6t327K/43wPVAdm/jYyIdSr?=
 =?us-ascii?Q?8bQrceky/mzPCpYQg4nFAAT8n7QsS9eSPUBaUX2SvrIOuOIb2TFzDaoMOt+y?=
 =?us-ascii?Q?qU9YU3peRQBS+r44H0L5TmCzWSNHV1SSSEqbqMwGUN8k38Fzlzr01NK2zfOU?=
 =?us-ascii?Q?T6KH0iabf5gS9dtdtv/eaSAw3CzOa2Rc0gn9cE4vMW7nqWq+2EOpUsdCz7Py?=
 =?us-ascii?Q?qTZctrk15/2a3rptg0xGXjVpdFZpTq1IPy3kjTTSRJrqTpYMHD0T4faVbXvk?=
 =?us-ascii?Q?/tXwN/98Fz5KmwRY4+LtW9yOlPUQmACoGTpGhFsVUoyXkFKZQR4L8jagXeHv?=
 =?us-ascii?Q?Zxk+6CQJr2uGpJ3tDMrs7XkFnguVyl+r/XsTXPB2PZx7nZpVf9f+g8fTy5jL?=
 =?us-ascii?Q?EWVD8unwmVqvfqcqLuunhSlD3kxVoB+q6/AhAoTklFLeWw2FZqR4cV+yndTl?=
 =?us-ascii?Q?vi1awuDWzi9Zh6WhEf/20r+RjNXosH+LtbdWT+rJzl8+yn3Ie1I6W9CDRFtu?=
 =?us-ascii?Q?sZlXk2Wt0UA5l3poMgqLPDA0UAKSRed4VGmO+z1G52tJRhLamwyHmWoWOKxP?=
 =?us-ascii?Q?VR+qGCL5QBUW/q6DCx/OoVxzUpEz1fB62X22symlJX/z+85vRfKGl3rTqdfG?=
 =?us-ascii?Q?8yka99jfZ2VoxXP5PRPwAAmkGO9DB8iX4J6P3Cmi0qhwVB0w4Y7OSzbXYxON?=
 =?us-ascii?Q?4ioNdC4BJRZJvMHTXBtyyeCQq7lrlR8BoYTFY1VXnYn1/PPFDY6B+2sFvHmX?=
 =?us-ascii?Q?1groJE4zicnWVVR3lNsY8PP9FcfF07fZKy2VrncWvtWj/dJQVj4Qasrw2Tc4?=
 =?us-ascii?Q?PodwDGGn7CGPdHAC7/rj8sf+j3kPayF+40T2VfotZDD7jFibCBmxTZOXvpSG?=
 =?us-ascii?Q?luvF8lFuNoQMlDvSpU0dQO3UJXwrdla2jwdZoqrm2B5nAX4IDNFehJGoz19J?=
 =?us-ascii?Q?iTYavSgSgkVPPHOwYOfnHWFrD5bWl3Ze7qFXqnXO0xrXCudXSKAFEbawqs4c?=
 =?us-ascii?Q?JED2qIieCHY5HZ5jY4ECknETfxw8QGV4vBYYDnuzgZuPdQFapIphh75k5cM3?=
 =?us-ascii?Q?e5Pl9Z9OijI/ygSTwmBkGvlxw4ChSr10HkMgUfmdz5mLs+XikUr57zSZJI32?=
 =?us-ascii?Q?AMNToLapCtsHw8YHN3T4qdxlPyjr0x01lJd4w8273AhpPQe7X/k+QFwrNQMO?=
 =?us-ascii?Q?dIL2iZ6ghgPVDAwrDceewvR499l5XcfDjScYMzm9LTsWe9mlxYL1xAvv/C7e?=
 =?us-ascii?Q?NPRP3nofM1v4Q4G+1DRIiC4m3ly5dyy50v5QuXw81hGIPKrXHYMiaA56jmkQ?=
 =?us-ascii?Q?Mxa4S+KAVh4IgQ4Cgy8nOpjgzP4QVX/SJjFDhLa5RuzgvJ5M8jmNVET9H6O3?=
 =?us-ascii?Q?sLqX/rmMLg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df1f1a9-f949-4eb6-4194-08ded36f7922
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:41:26.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiPVW53jXLDpWtW+TrjNx75Bs+Gxn5U2x2y5SneVa+shsCrRAjRYLOnXQJtBHip6hfREs/F2BH4iBSwxv1+zsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

cxl_get_feature() reads a feature in a loop but passes a fixed size_out
as the output capacity every iteration. On the last partial iteration
the buffer has less room left, so a device that returns more than asked
can overflow feat_out.

Use the per-iter size data_to_rd_size, which already tracks the
remaining room, as the output capacity.

Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2 -> v3:
    - New patch.

 drivers/cxl/core/features.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index ed18ccb5e236..e52371f87300 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -225,7 +225,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       void *feat_out, size_t feat_out_size, u16 offset,
 		       u16 *return_code)
 {
-	size_t data_to_rd_size, size_out;
+	size_t data_to_rd_size;
 	struct cxl_mbox_get_feat_in pi;
 	struct cxl_mbox_cmd mbox_cmd;
 	size_t data_rcvd_size = 0;
@@ -237,7 +237,6 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 	if (!feat_out || !feat_out_size)
 		return 0;
 
-	size_out = min(feat_out_size, cxl_mbox->payload_size);
 	uuid_copy(&pi.uuid, feat_uuid);
 	pi.selection = selection;
 	do {
@@ -250,7 +249,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 			.opcode = CXL_MBOX_OP_GET_FEATURE,
 			.size_in = sizeof(pi),
 			.payload_in = &pi,
-			.size_out = size_out,
+			.size_out = data_to_rd_size,
 			.payload_out = feat_out + data_rcvd_size,
 			.min_out = data_to_rd_size,
 		};
-- 
2.43.0

