Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793613545;
	b=aOh69WBa3TupVyWUgwP4Uo227gl7/7lIrVPuNqTe96RDToNYdbOqyag9zB3IZVS8oaFS
	 KpUdlZBd/u9JylX2ECjJy9X0QFLBfwTlThWWD0LOQ2Ct8A+eAY+unE+hMq2JA2jrSapze
	 R+g7Rd+SRHoC5z59k5mZbexOGsvKFhPVHuun43hZSgM7gyl8ivO3ifS15r3YeqOP4prhx
	 IFgY3d4eMZjqeIVEDnV1NDBb375/thKYPmeyL0RZMNEN+292CjM8YnWqaatoN6N2Fr0J8
	 xc2HoHLIAvw99u5S0AVWZX0tvNBfrL9/Ef/pWwm5C2k6eg9MoJCiI5mEjgCdXPs06ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613545;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Wj6HqugAfVUw5FVDOYM1tjLv5Pc3yZZusK3bzpYJsEk=;
	b=H3dm5914yMbg2lVEYWMddil+5CfF7/w0P33GOox12oay2Qx7HSSKjPefPw/OYgom2+vD
	 0FOHdhl9Y9UUxqPYD7WLQNZXmKDXS4ORNbQLrvwXj4UPxwUZkgJzOJyC5yfXOKAcrCGAm
	 2FBvcaCH7f/wjJV5MPpnaG7d5BVQmNkwCuzEc8kAdQTy3WAw7cac0+85fpVNiRJ3woufi
	 3lOetpWtAt/55Y8TTff/r1L99bmWaBLVd4ApvI0tYcs/Hp4cBLuPB3z+TPgZu6hfPB1EY
	 bveRPhZsbZfrWjfWu+qa73MtPQXchLMFbqxhqk+btlHujO+Rhf9BxKQL3sK8FWSEoKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lCVqdJGi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.42
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB4606A324;
	Mon,  2 Nov 2026 09:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2DB4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lCVqdJGi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgMb4F8Z8a9CiuZqY3OtAbJM4wyujCvznE0lK0QYv8nIbcDgtTnHk5ppkfnp5PEKt8MpzVwzHJxYiJbuDKKNffvQiC9ZXgTLSUWSw8RHBczr8m8lUuKxO0IJuoFGheBk0rMhS5oEBeRxb25dnsA/rebCrR4OwBcuY6VIzc2oSK9dWZnFysoFfW8ALlMw5rXfMWowow4VNw23iJDECQPS2f5sgLX3aSXQkSJujW9CjG5rrF25hNgRbb4x53WCPEXyawOr6pdlqjK5Y47m56TsaCVkpt095n2hOk79fI+/cc6kmPukHA6VtaH9+q+V/AQ6DpPr6f0LDhhf70QFO9pVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj6HqugAfVUw5FVDOYM1tjLv5Pc3yZZusK3bzpYJsEk=;
 b=YLujiyCagP6GVsi2lh1cSminqlrFWVvnlqQ4coRWqyJYqCN7Q5+RwqTVmhvz4igKap/zOnHfPKHR112zA8xvhrfCoQgbvp1EdSC9P2ggQYQojUhIaqBGGPTez5vIxilNx3TcOVaSv/JwloGuvcTbuhIJy7CkPLqnY8uwNRz5lTXazqmwHYRk+PxC3O5QeFZV9TGyyi17fntXyaV4kjL4F9Fu9no3l1B6W/AF+3ByOfu+D1wMfZEnhSMyecQ8dev+vQTZTMOJmAqlS7Ly9oknp+6Echu5+mQd9WpXdlX0RYSYNhp87MKC7yUeFe3F/tMs9zVemQGNRFog1qRBy7GVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj6HqugAfVUw5FVDOYM1tjLv5Pc3yZZusK3bzpYJsEk=;
 b=lCVqdJGiVsf2qQ/L3hxVUKGKmoK9UYlapzEUjMtI/utRQA15ud0sFn2yaCQWDZZsyXo2D4rWI6xdFAZ0kNEzy+tOGdX2jOZGsK2k3LpwPPs+l5FaeH7GgdRjX6Rc4rLgxdeRu94KWu59T74hdcrlVu01jCrhGJyWItsaMahN9SMWQMINxGZd+nLpWHlxfnH7rXpqWoz7gZNjBeD1tdFXaookYStIR/N1UJhRBCOhNs1F2OIoV0fvnMEpUa9rFwS+Miaak8JzNNIa9qKaRxXqxGOo4uZUbmMmApvf1F/X8gtHlj2KakicpwpHL+QI6TRyKtRduMyTUq9+BvsWi7cI4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 09:59:00 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 09:58:59 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] cxl: Share media event DPA accessors
Date: Mon,  2 Nov 2026 17:58:52 +0800
Message-ID: <20261102095853.56698-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: f50c3c27-b249-4342-85b9-08df38c7ea82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261026140227099003|261022105027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vSh3I97Yh4hdYUe6HCkUWzzf+5QPN/6DsRhvsFnYIhf6KVYQ9qU4CSBtsUyYbfBA4I2L3xi9Awk/DIwyXd+rUKiaYZVakq8KAB5Y/3adt6h9AvuNND+BgDij21SCjYWInRDR/lGwyDqNzmKzQrtzaRRPvubppVsGJmjEHw/ha8edWXiwh33XaWO60HWupQyo9tx+Ulg2BMDJ/ycj60Ag8PYet0NirzNYx9I70ocNs/ZTLyVeE/IuYGZejkRovYpMz9qpCwPoxCw+5VVN8ygvjFSvm3pUt1FqGddHjS8qN9HbcGruXjCYXq+P++EQqHCgMPPPfgExWpXJFv9dBuPHoX1sP8tHEZcwBrT0eodQyeS7wdBU8XuMN/PLmXeZCVOBL1mYL1v0N+wf7UglruBRpI+h4PznQiUOeAb5fdJBSO/4CfpZDNo5HGdTDsUM+LdVeYWS9QEl9/w0JPsNKQDq0gWoDG7ixUP0VbPJjCdRZI9GaOpfOAp52XnofbAI43klaEUheYx4xvVWhByu/wmnKWNC5Gl7vSTgWsYkUoe2MGcU+3ciFazWwc4mYR0Y9IMPKO95YeMS7/2lT6y+SB2EbpCiT+P4uRF3Rll9L8yz6+oHSruWXUoC5mFwMOeSleW0uEV7WuIAGB14c5F66B8Z/Y/NFqtjz18R1qY8TpN/JY4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?anudInr+7gu/dj25KqvR9vyumI0AYTGbUESjNSKE6+eEoVlQg2mcPQ2IMXS8?=
 =?us-ascii?Q?09O7B/7nVjnFvbJfdk2V4c58Bb9Usumu768f/Z6kRhRGn3j0jbvrm/vSv15+?=
 =?us-ascii?Q?BX6PaqqLkBkGKLX3iztl2TrMb5Wn5ucKsopymLevN/p8ZODKdd6zn/FsrpJK?=
 =?us-ascii?Q?fl46mlqns7bLidDk1x2xrv8cmq9JUYHkkRR6JTnJeGKdwsYd6FvyNCmRsYMH?=
 =?us-ascii?Q?BgL5WePfgnG4O8K0ulvOlEC2xXNvyrGygNXC3Go2XlDlaEuGLh977xVUmVmO?=
 =?us-ascii?Q?9R0ZC95WTX5Xds+6eCUMhAF7kLRUjweHxpVtsC+O0Ed753oFRxao0tLlKDun?=
 =?us-ascii?Q?KoBQmIFxa4RVcMCXD/g0lwGnDnqSnJu9Agyenql6Z0pyE8ZG5Btsney7Kvs/?=
 =?us-ascii?Q?3SJzL1GsPYSz44n6YivjWJAFpdvUnNWD2nRofUtdOZqFLJsRB8mC929Ds3lm?=
 =?us-ascii?Q?iWmpGw+6+4pnRao+/wwoFFnzPfBeOKzia9eYJDAv2djUQ3alu/ruw37zcFOi?=
 =?us-ascii?Q?FlgvlZtlue3SMSUkkAB+XyIMvK37fREtoCOzFQnzNv/NMmTV68IAHCJIZHwU?=
 =?us-ascii?Q?XJSC/F+t3fUqExdjRYnB5wus/Vey9o7Rha/6g+r6bWEvNAj4UPNeilg6XFn3?=
 =?us-ascii?Q?4Ygs/Krm3gUuatPNgBsS0LBpyFxygbwQXmN4JU71WfLI/TO4wdD3iIyfcqHp?=
 =?us-ascii?Q?Qw+yZ/dvnovdzBawjKhaerOIX+EFxcFmAukaBi1whIGoFVqVTNE6/ccQp9TN?=
 =?us-ascii?Q?P6UPRwqvIvCXNSK7Zbd2Y/61gBMULQf+0Yv4rO0YiAS+uBcUOz5Jk8I/g/QX?=
 =?us-ascii?Q?gYc8lfvNjZaYqA7TCjIH73DZT1fMW7sK0qyQgMDNUkpKsa2PfBKm6pD0RHza?=
 =?us-ascii?Q?+o0yId7OcrXvb0bvuKgGraffrThCoK0xjcMIoa0ZrvWIM8aA2KVMunH2aBPJ?=
 =?us-ascii?Q?Y1pvDL1Nz2ViibTmT7KWSUR2zS5jElbgL45QgIgdv32xsBYA3Dr2f/7FeWu4?=
 =?us-ascii?Q?ChS9mivw5fRdkh8CL4yGDFiU6rhIrqmVBCmjqKx2aUHBccpU1pKJYY+pHI2F?=
 =?us-ascii?Q?ghzOGlcF1jkVRoj/0sfAMTQmiVtmIhObH5qP/L9Kt6HVT0yj7JjGMTlrL/m6?=
 =?us-ascii?Q?8fRhRPQCieZ9U1PFBAuaxiQNMy5YhGLI9FmCCDLKhzgN+mF7yGtEx0FNXch7?=
 =?us-ascii?Q?RRAOxNQbO53gCZ63DJtu62G1uUtHcztuRQPnZ4AQlFZsbyjh7+ASClyp+cTp?=
 =?us-ascii?Q?fLpc0+AMWiude3eEmzkqWmFwgRTo7Zwwn8sS0JmLMfZUAnYV8Vgn7bBM7gjR?=
 =?us-ascii?Q?B0+wa/gry7VQ9Emw4UAGr3yd/SeNFMKTKeleKRdq0+wupp5T5Y6cO/rZ5okT?=
 =?us-ascii?Q?cKmycSHgQwKlfEukOZdVZpus/4upng52JqAJeUA2MQfdcbUCC0al1IV6Djfs?=
 =?us-ascii?Q?u+9rkMQ6A5VvYB43lZGK58xv5N80OSLV2Ef00cvQO3uIeZkwOzWLRuK2XLP9?=
 =?us-ascii?Q?t0r3inYQHdRQQJ07ywFGCnf9/DGTs4cPUTXn0Mtm0h13SdaX9fkFyUDkYfaC?=
 =?us-ascii?Q?eR0o4ZTbPFOP730RhT52VItbxFAj58lk78RHoLGmaqMqgzhQK1jVavxYTx7Z?=
 =?us-ascii?Q?1BWy8wIwcUANKk/bDoEfwB/o0QQ3Lx31spxSW2WnBQc06Oj6lJTFvrSp5zCV?=
 =?us-ascii?Q?ty1xDBxk98DYTA+ET5yKrjZG21unEnWF8vlJGjF9xHBgE4mw5RNtfk+dRIc9?=
 =?us-ascii?Q?6IgAxiQY/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50c3c27-b249-4342-85b9-08df38c7ea82
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:58:59.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09qtEpim4mBbWcuNbAkRhO7T/J8NgD8hWBmYgKF0reW5zSYVYsaxkDc0fvvA4VyRbAFOASvwV32ruSa/ogxklA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956

This patch is inspired by Jognwon Lee's series [1], "cxl/edac: Fix
event record lookups for memory repair". While reviewing the series,
I found address unmasking and the packed byte design scattered
around the code base.

Design the common interface to interpret them consistently. Move the DPA
masks and flag def from trace.h to include/cxl/event.h and add typed
accessors, use them in both media trace events, DPA-to-region lookup,
cache insertion, and the existing NOT_REPAIRABLE predicate.

Following CXL 4.0 sections 8.2.10.2.1.1 and 8.2.10.2.1.2, Tables 8-224
and 8-225, preserve bits 63:6 in their byte-address positions, expose
flags 1:0 separately, and exclude reserved bits 5:2 from both results.

Keeping this interpretation beside the record definition gives consumers
a common interface and makes future decoding changes easier to audit.

[1]: https://lore.kernel.org/r/20261101013418.87326-1-ai@linux.com
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/edac.c  | 16 +++-------------
 drivers/cxl/core/mbox.c  |  2 +-
 drivers/cxl/core/trace.h | 25 ++++---------------------
 include/cxl/event.h      | 23 +++++++++++++++++++++++
 4 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 94d44a3dc1f2..8c3b7da1fb9d 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -918,19 +918,9 @@ struct cxl_mem_repair_attrbs {
 	enum cxl_mem_repair_type repair_type;
 };
 
-/*
- * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
- * Records are looked up by the DPA user space writes back, which comes from
- * the trace event and has the flags masked off, so key them the same way.
- */
-static unsigned long cxl_rec_key(const struct cxl_event_media_hdr *hdr)
-{
-	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
-}
-
 static bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
 {
-	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
+	return cxl_event_dpa_flags(hdr) & CXL_DPA_NOT_REPAIRABLE;
 }
 
 static bool cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
@@ -1143,7 +1133,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
 		return -ENOMEM;
 
 	old_rec = xa_store(&array_rec->rec_gen_media,
-			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
+			   cxl_event_dpa(&rec->media_hdr), rec, GFP_KERNEL);
 	if (xa_is_err(old_rec)) {
 		kfree(rec);
 		return xa_err(old_rec);
@@ -1172,7 +1162,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
 		return -ENOMEM;
 
 	old_rec = xa_store(&array_rec->rec_dram,
-			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
+			   cxl_event_dpa(&rec->media_hdr), rec, GFP_KERNEL);
 	if (xa_is_err(old_rec)) {
 		kfree(rec);
 		return xa_err(old_rec);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 39485b6bcb97..ea35787dedb4 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -965,7 +965,7 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 		guard(rwsem_read)(&cxl_rwsem.region);
 		guard(rwsem_read)(&cxl_rwsem.dpa);
 
-		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
+		dpa = cxl_event_dpa(&evt->media_hdr);
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
 		if (cxlr) {
 			u64 cache_size = cxlr->params.cache_size;
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index c379d60047fc..31f8e1f13184 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -314,20 +314,6 @@ TRACE_EVENT(cxl_generic_event,
 		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
 );
 
-/*
- * Physical Address field masks
- *
- * General Media Event Record
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
- *
- * DRAM Event Record
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
- */
-#define CXL_DPA_FLAGS_MASK			GENMASK(1, 0)
-#define CXL_DPA_MASK				GENMASK_ULL(63, 6)
-
-#define CXL_DPA_VOLATILE			BIT(0)
-#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
 #define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
 	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
 	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
@@ -490,10 +476,8 @@ TRACE_EVENT(cxl_general_media,
 		__entry->hdr_uuid = CXL_EVENT_GEN_MEDIA_UUID;
 
 		/* General Media */
-		__entry->dpa = le64_to_cpu(rec->media_hdr.phys_addr);
-		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
-		/* Mask after flags have been parsed */
-		__entry->dpa &= CXL_DPA_MASK;
+		__entry->dpa = cxl_event_dpa(&rec->media_hdr);
+		__entry->dpa_flags = cxl_event_dpa_flags(&rec->media_hdr);
 		__entry->descriptor = rec->media_hdr.descriptor;
 		__entry->type = rec->media_hdr.type;
 		__entry->sub_type = rec->sub_type;
@@ -639,9 +623,8 @@ TRACE_EVENT(cxl_dram,
 		__entry->hdr_uuid = CXL_EVENT_DRAM_UUID;
 
 		/* DRAM */
-		__entry->dpa = le64_to_cpu(rec->media_hdr.phys_addr);
-		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
-		__entry->dpa &= CXL_DPA_MASK;
+		__entry->dpa = cxl_event_dpa(&rec->media_hdr);
+		__entry->dpa_flags = cxl_event_dpa_flags(&rec->media_hdr);
 		__entry->descriptor = rec->media_hdr.descriptor;
 		__entry->type = rec->media_hdr.type;
 		__entry->sub_type = rec->sub_type;
diff --git a/include/cxl/event.h b/include/cxl/event.h
index b5673384d930..2c7028116e53 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -3,7 +3,9 @@
 #ifndef _LINUX_CXL_EVENT_H
 #define _LINUX_CXL_EVENT_H
 
+#include <linux/bits.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/uuid.h>
 #include <linux/workqueue_types.h>
 
@@ -39,6 +41,27 @@ struct cxl_event_media_hdr {
 	u8 rank;
 } __packed;
 
+/*
+ * Physical Address encoding shared by General Media and DRAM event records.
+ * CXL rev 4.0 sections 8.2.10.2.1.1 and 8.2.10.2.1.2; Tables 8-224 and 8-225.
+ * Bits 63:6 contain DPA[63:6], bits 5:2 are reserved, and bits 1:0 are flags.
+ */
+#define CXL_DPA_FLAGS_MASK	GENMASK(1, 0)
+#define CXL_DPA_MASK		GENMASK_ULL(63, 6)
+#define CXL_DPA_VOLATILE		BIT(0)
+#define CXL_DPA_NOT_REPAIRABLE	BIT(1)
+
+/* Return a byte address, keeping the DPA bits in their original positions. */
+static inline u64 cxl_event_dpa(const struct cxl_event_media_hdr *hdr)
+{
+	return get_unaligned_le64(&hdr->phys_addr) & CXL_DPA_MASK;
+}
+
+static inline u8 cxl_event_dpa_flags(const struct cxl_event_media_hdr *hdr)
+{
+	return get_unaligned_le64(&hdr->phys_addr) & CXL_DPA_FLAGS_MASK;
+}
+
 #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
 struct cxl_event_generic {
 	struct cxl_event_record_hdr hdr;
-- 
2.43.0

