Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94528B7DA;
	Wed, 26 Aug 2026 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708764; cv=fail; b=sPxzlvxZP/vogR5+SUVifPr6SUSGBy1irmhDLFpvX6wdUjso1+/wjc+Dks145tkEJ//lTmaA7O8H+yYzY0jwqAIsmPjDcU1LcFvFnzAePBCulhO17XOT2jcGOwnt9JACj/dLTWL021Q6txG7z+6/LWillWNVeVbXS3HmivB5RVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708764; c=relaxed/simple;
	bh=z6HjmXviEd3fDnaAwRLd5vRIxzeEqy1qCYOD43wwWnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AlbOyBYmAOeiT55F/PzkUFDzFPh3y8Nk36BRPUBOSWWxPc0H29Y26QKtTllwpc/6GRDugoh7n7dpO71/BC7VhUr9TwLPoeQ5Yl/sF289RZt5Ar5GWwmUx798725KWswtLUI1RmmaDuOAcFudri0KOtCLZFp2YFQnwr29rGmcLr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hewXphdi; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hewXphdi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLSKY20oQX3qkk4plbB5Tp+mmpxeiRWeVLm6OVEeD7cj38mztJvWG6UvoVjUK+bDfqR5khvn6UesneFQMwANpaEhNrC2OB0aDcjB4i2nMS5PL3FTcKlcKSHf9WiujTYbpauctzNPcttxdpm8a7HpcD7ks+dD40I+DQZ25/cf4OE+X93hyBCXSN+NFKqyOgJ2SKAcAK5wmMCpOh+provE/PDPIbRO0vHZIcu68+8fLzklvHzowE/CudOJDXoik5eNzq0ZmE/3EP0RZqG+9u5kreontDckTdM1AGqgl7Yi5z6awPj0LpwDc2hUy+DjUrh08sZ5QuuIa6ICKxSa0m+iZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsU5zj7ElORtAaGZG9p+pGFgHTILgqa6giJl7SJUrv8=;
 b=f1yAUWmxrXjtB1GoVgEFeiF03itNUdiPXXhVwaz9oThIrsQ9VkCbp3Jr1Klu7nn6g57LK3zC8Cfs/+BJ9Td2o0wkQq0QGXMcg6OrtLpLnuI89xHrWVZG0iDQGRajPGfdISKpj4bnoaHZ7GBRDtmkd/pv+ReTL3aY3zqNuspg4I5CW6znY88EZmdjAjhWMxKRYvvDboqRbblnXLPvoyh9r3cggRVPH76LGd0qX8vd8EmEnJqO2NIW98p3iePWR9MggCkt0boim2FN1rYh70Sd3DEJjnZOx0sFTGYQtoEa1Rdo8TYSoaPcMhyl03hCpcRvaY9m53B//3afDDf/Md355w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsU5zj7ElORtAaGZG9p+pGFgHTILgqa6giJl7SJUrv8=;
 b=hewXphdiI9+2uXiRIgD5XwmM3SPnY6B7Cc7kWJRHHrqRSZtp1FyjLydz2EzojAreTmYBMc6r6AsQgDU5SotTk5l0v4QbfzdLbAZOEqc6xYZ5+93lQxyA7nDmDUExh0aMnqhIHd4CmMw3lNjiPAVCPkTl5xPKNabtjbSfq1s6TfhnuWhIikvGdrPA1qQ7JaWBfoUKuKzTj1zUluHNqJMUQ1dKH23A9oBHhkeSN+0KpbofqG53D14K43gL/fo24G71dmltnL1WcYgRb2kpFhVcS6oDhk4tDGlnaFnHWUhHlFafYX/WYaZCldTX9puVjVavuE3QFVJlUNatR046IxYGQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 01:45:54 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:45:54 +0000
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
Subject: [PATCH v6 4/7] cxl/region: Start unmapped poison scan at the committed decoder boundary
Date: Wed, 26 Aug 2026 09:45:05 +0800
Message-ID: <20260826014508.9989-5-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260826014508.9989-1-icheng@nvidia.com>
References: <20260826014508.9989-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: e83a7b58-6b19-4db4-d5ef-08df0313c3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vZUwBbWtGuZHoSUXd1yzUm/5AiNVum5wpXUJWfoIpkC2A7naRjLhc8/yvbjjvbkbwHiD5K7/hZttEmtUH/Rp9/61f2Yl9MuVNUnM8dd4GqZfuYk2DQwdnzCOdfeN8t4DeqRm78tH8vS5sbLH21cIX71SPLFgX3043yfr5vJBKrwPhJKrxaDY/XSwrwqczIJCTSq2uCVOYdLNMUaw4f9UYKHx/YoSmZkKy5lGIU8drIeRB0S1C6nLiy/qA56GV3/rIvtX+gQVbNlkgH4mYvkY99HnIZMsUjnWIRdgdZu4HmLJf/bAutJtnTryu62fUId1qCypo83iMUIlIR8uHGHbcDeK0JzY6JA8XO4hiDCB8zqjvbYMrmgCTYHPGP6m0SXk/QJdpPCgvKePnbfYOELHAVyzWBedW2Bns3VBr44VnF8d+6+Ehse89whTJ06FgGyUlJ80QWrenAP719mpTO/zzmrnBcS/DWft8jGW/dT01+N4zeE0HMntTXCagi1AauwiCKm0jEOSNARZBuUjpSyssKVcB8woX7vcqfOoUaEZc9GXcaQDjGUOC3aPf3p67fk1LHSEnzYQrtGa5wOr+dSab2SycKJ5u2oVa8i9med8c4MVPlFc17JWoy3O4I2DnOr61TZXg9bzz6eJtHgwTzljWLwLX/XEOjsM2L39XpIzQb4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYuhkz/5QIWP48B/TKo9cvVU1o1Pt9AGo1uTJiEt9RFwX7S0M1CzHrLJW0fv?=
 =?us-ascii?Q?8uj3DmLi7tv//FLzwqrbNvEpZCSDrkNIAq8vNvpBp4bRtP7z6AT5kJsUO9IO?=
 =?us-ascii?Q?oRSC3/UKXrkBravrJ11t66tUvkI37GuMRkExrE4frYh0rpfEMrYj0txKaLPB?=
 =?us-ascii?Q?iS4Oc89z78FmZ+3evokqxd1ur2oVwZiAiddhgTT9jFjxuKGUi9nvVz9YQhP/?=
 =?us-ascii?Q?/UB4VnM+zLYf0XcM5mZHDhc406cyYXD5Fkwk8NWR8G3otg6O/XQk9Zk5aSYH?=
 =?us-ascii?Q?i5I2IU06YxHoqQxhnDh+YceyKAo6G1Xb7NxHcwJEfTTF8OoXRLmiyIOpdBFF?=
 =?us-ascii?Q?TxhkmhgNiTWB+jWEiloNzqEBc2KqdMJN8+gfRoJ0OYJGt30L1Hy1GIPxjGZT?=
 =?us-ascii?Q?18cf8DCnQKD+GChpTLmM87pss9OaR/cwgWotfgenGJK7a1cn7AwocSg9S5VP?=
 =?us-ascii?Q?maM2/4U20chMCqPZx+KqqxkJ4B0aGIpjOv6IYkz0O12O+MmV0CU/ciSua08z?=
 =?us-ascii?Q?9W0kYKbF3zqNXzz6Dg2KYe3KosMt8lDFhld82gcWHXjBULoTx9/7dNGDFHdd?=
 =?us-ascii?Q?nlycslS7395Jj5u8XxP4D6BG2ydjoKUqpbs2FDxfPnqrSi8wS9cdCuAiZUnJ?=
 =?us-ascii?Q?s/Sx3Cu4G7FTSTLBljPweGC43Q5oVdrORgvs7GW+7gpeT0CDrpQkai+RMWu1?=
 =?us-ascii?Q?EMtDQvOivGZYicjAFOyaM7LsGwJDnbsTwULpmgqrZfMzce9nfdM5CKeTWu9i?=
 =?us-ascii?Q?+yXGlci81N3SBpDe5Eo/WoG//U7EcVZw2VPAQOWP2SCwscr2zQ3/J6kurPZB?=
 =?us-ascii?Q?3Jv2D9BZSabXRG5zmDvtlQL4Asewoy2X84CLCwZ5lNtW2J6BaxIWTSmBzdiz?=
 =?us-ascii?Q?SmKzE4jpmJHpv6Nu0OX+Q6BPPCOJdonO2WHswE9CFQpUA4sOqXsZk24wYLAs?=
 =?us-ascii?Q?se719iiO9PsIy/exqTzL7I0xSetKGt/cStBQ5NKvEdJ+QwIFkAc70gQJyHa8?=
 =?us-ascii?Q?qksrz25DGk0wncdkn330qltnFQxyNnt+aYHKaFd0OQcJeZCIZjXB2p9aQJj+?=
 =?us-ascii?Q?gaAj7A1o2y/DYz8Hv9B075eMjz7IIQtz8xySiRTn0iql6mIeT8WmQqed+57v?=
 =?us-ascii?Q?ZV+VafVBR8obyelz0NlHNkkEW8QoVRCD2PZNQON922CmFEB749Bu6vlewljo?=
 =?us-ascii?Q?DW8LaHxdga/nqWiNq5fHaW/HgQQmTLiTL0kvhCc7cEuuKzYbVovWW1FTTHUd?=
 =?us-ascii?Q?pK/z2xYPSa9m5afn+xpgjIzCYwPxOZbphTskm7ecj9Wh17q9OS59s2lZWh72?=
 =?us-ascii?Q?uD570UFiNWdYriOIFfU7Gs9sqER8Ya82ItGTlIVl9HlGsHGB/+P3KB58gYOl?=
 =?us-ascii?Q?AAtJ7jKETlIRn8lb/N9MH1iXHuBzw5HUUT0XvMoCDnAmZJspSw54YvKiFpu1?=
 =?us-ascii?Q?16cjNP0zZ7c2K3+Rk3Jia1+2brnxcsj1JheQ1CnaST6NGpou0jG8oP4vkrya?=
 =?us-ascii?Q?Kh12K5f0u8+TRutjJbbXdZqVEs50WurNMamC73e6ohWksTNi5N60MzSFTCqL?=
 =?us-ascii?Q?gG6ZsI0tvB/eEK+p6+6flZmMsnTrwxul7mH3P7hYTxMGlvIFrpmSjIypDlMp?=
 =?us-ascii?Q?Li7X2IE2q9t1HDhaV9n0NNgsRwI79JWuQ1GaLqWITbnHJvgYVbOdzWnIZkAv?=
 =?us-ascii?Q?GAqgv7BZdnD0396dQDhxFo+Ld2TgnST6EESdlelCcdCoqi+iiry+8q+FzYNW?=
 =?us-ascii?Q?V2MtohPKQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83a7b58-6b19-4db4-d5ef-08df0313c3f0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:45:54.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebCPIiC3/kx1TDg4nj8cPUmdDBXlOjHT51DUDGjobJl9ShOcF1f33VoPwvjrxaLP8fTjW6hfrkZHNOIk5l9vWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

poison_by_decoder() stops at the last committed decoder and records the
handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
starts after the highest DPA allocation instead. Allocation exist for
uncommitted decoders too, so their DPA is skipped by both phases and
poison there is never reported. Resume the scan at ctx->offset, and scan
later partitions in full, restoring the pre-rewrite behavior.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - New added patch ( sashiko's report )
---
 drivers/cxl/core/region.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ddf12075b95c..b7dc5d4988da 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2907,7 +2907,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	const struct resource *res;
-	struct resource *p, *last;
 	u64 offset, length;
 	int rc = 0;
 
@@ -2920,10 +2919,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 	 */
 	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
 		res = &cxlds->part[i].res;
-		for (p = res->child, last = NULL; p; p = p->sibling)
-			last = p;
-		if (last)
-			offset = last->end + 1;
+		if (i == ctx->part)
+			offset = ctx->offset;
 		else
 			offset = res->start;
 		length = res->end - offset + 1;
-- 
2.43.0

