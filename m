Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A084322EC;
	Wed, 12 Aug 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533720; cv=fail; b=nXwJmzyMW7T2t6U+uvbkoV5u/Oa20XO/0qn7g0VKBq86CBn0s08N8ZfxdVNi4fVPeJN9bV5fKkvi9JZOYmgJhPUkEMbIFDJoYJiCM4pPvtzaAbAy2EgFgS7kZbJI4Coh0e40/Y+QNiSW+G6gqV8Fzrq6isInwOOzd6HYjaj+6uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533720; c=relaxed/simple;
	bh=TGk1ixv/4Xsxjm/SwXk091TqGoq8daaM4ISGhJYDHIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SYWlPk+IVFpoxd+bZ50jupM3PveFfSX3rCj0aqdM+D+aoxyX2CHx5es+2+sz2or3TT346fv0AQtTFhIzFuzQJzQfLrW2AkKtgcGD9o5b82n1xfKMXomLie7M4uoyPamVVgtueyyCHG1f5T//16VAbudgpmevb9DSXPkASIFqs2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AgppkvrL; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AgppkvrL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3BO0VkNFz3fiXneeO9qkw6xKzybW6+LZ4+z80C0l09Fysmc9GzZSoc6z8GVAoX5PYaomNTdyJ5y2EfALBbKGC7ojnpp77Gh1P9b+D8wIVSY90+p6pricq9DH7GOaqCeQV19USjEmM8ZEopHTayRxKEtsXiks4RA0kseqVFnV256PoWEB4D13cngTlmkiv1UPR66UMEM0iVASjiAjUuC6CmcQvFlJ+XPVih0p3SNtxMt3sSVMDAnopCwiCbtYZdyWFqPGDOcPYeGqYEzNoLHWi0MG79zJrIM+BNMpH05u2kxZFOkRrPdPDEVMkTYsT1rKqmWua8Yj8XuhnT4nMvaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eouvKWGNQh96dmqUMkxqaJZQZC8igDESkQGRD0speSk=;
 b=I1lKPsj+zwcFjEEUM3W6nP6JS/6EbYNbCXjUuJjNhVpxNVB/jf0Eij0Wv7ppnZG/WUHfePZT3Ps6VG3zuhX8gmpRQUwifloM1umByaG8yAko3TWhbxA9LNf0Wj05lSMwlAy4Bt4ADFGMtHDX3pZfS5kzxP/TZUIUBcyB1Y2BRSUDEyP2abUcfNMxPZxLk3njYzABdlu3o9AfAZdD0MGa331r3tehZuS5ivn0Rv56IiqHBBMY1FyLwctyP4GFhKL8qUkwX2EX4IOeAjVslGhMIFDQDSpyoNZ8oNiedYc2a66BeC+L09m/nSEJKUdca/g9KaNrr1aMy3c2icqRJIrLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eouvKWGNQh96dmqUMkxqaJZQZC8igDESkQGRD0speSk=;
 b=AgppkvrLPz3G51dBn35Dabif9eC98ia1RBOvHKzm+In4uSxVBaSSBrgn1pSRqpM1QxupM1fudnMX+9z7h2ir13LE4beC+DAgJwcYRdzoUKXdUJgkAGd+XLlTppL89+fZ+OtrjD+3A2IPJRGegAQb2pH83ZAl8KazPMbQPlt7rCD9ZeaqQrAHDLrS+zshxUt4Vf+YpbdHnx6trf9lkbEBD6VW+iky3ctiEK6rSYEpj0+zQchLOljg6Hng2kKndji2xRpetL2WQhOr1PkY1bWPZT+r1UgKU1BenxPNCkj++/Qb71LiHVqOXEliNalU0kjlvhpdkePDED1sAMJHO1Drow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 11:21:56 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 11:21:56 +0000
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
Subject: [PATCH v4 5/6] cxl/memdev: Don't overwrite the error from an earlier partition poison query
Date: Wed, 12 Aug 2026 19:21:06 +0800
Message-ID: <20260812112107.56181-6-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812112107.56181-1-icheng@nvidia.com>
References: <20260812112107.56181-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:d10:25::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0e6856-8401-4cc7-c5aa-08def863eabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jPS34DEBrihG7zq8C5N30uVQ5oS563pSG2FVhsS8en+y4MbcpnMHYUg30qdKnZq8W+Ez50iwlhtjjTE8wPjPec6y8Cm7zkaNMWTMmMbnegCG2ah3A2nwV5sgdVAn1QrNPimJLq+l8RkL6xi32bhutIG0kXfzdcLD3g4jn9Rqz73qY+sGPE4UWt97scglg+KQyo9LxUVXEBcOn/XWzfzgzWKKR+hpojsql0rQkSsb0E7OPNysIV/1Hm8Fj1e598vv94yCjRmpRwIJRPzGUJD/+GqgGkNsRDFsff7tb1IjBZMlT94fl8Bb6625MhTL3TPcfUiMxa7lHmMifwWsc+zysFxn01OGv8wGkf2KL8hqz3kKwLXtZXS46gVT7tCXkWb7L1z91lGNqvlwN2W6DDe65LA2fXZBa8kjouWva3N3dEwF+bw6x96s5vb1lMzNr0VipB+xWCBkmPr/+ow2SY+rqhhXCKBQXxaQNevq5l8F4qembrZhCXy4RqPDzBMicCpDkv3hI9RbdmnpkWM47/goBnDfGL9n0Tggv+p1Hnm13w3bfGz3g9OmA3RYNAp/wvsIg0ccawUOGCke5FalIbq9lF+Endh07WHLeyd4kQU1Ol1tXCtUGxw/mdAFxRw8CzdZAeokcwN8Y4nZ/OhfL434eBrLll1FaukhCbWJZ6mFwtc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Z/uXzwnuQHj/oBVV4QUIpgKdZr4NXqWbiY4iD8eouGS2/6Ja2K1agzJI1Ae?=
 =?us-ascii?Q?xeK3/Yd+7sqW1rtYWZE/GYMHEhDEm8wewH9yGzcmW+dZ3oibZ5Va2AdKL9Gk?=
 =?us-ascii?Q?43maIYhopN4DdlQ+WFeEGumLgsWc/WQ/+EroCwTvI6vUHesYYrK2fVqnBFDA?=
 =?us-ascii?Q?9TlM4kOa2uMkRuct8KyVw/nJBHWODnEXN7ohfwJ7Tpmqe7xTjfmxBM53vw10?=
 =?us-ascii?Q?RX8JAwahlB8oxohRAp82JqJOxoJnrKvVlI5QKPNnll/CMTKcAcdVVTNWXsPB?=
 =?us-ascii?Q?CxD8hF9Em5jL2/Oqx9WULo3BNcJDWCN+I/lU65MU9tHa/5SeSZGRanoVzBZY?=
 =?us-ascii?Q?A9F3CKgm2QRL5JZGlRBt0fYVo6GK1mlk3DXWGKXfq8FvbSBii4sZcpczwHzC?=
 =?us-ascii?Q?R7JW+NkkLpAEdHWNWiisiTrJibxFr5ZUc12BBhkLr6FmGORjC7yfIzRCQF9Z?=
 =?us-ascii?Q?htoTTZiTKTwGKuzAIhHGZfH1J+lUVQ6FDFKeJL2wihnJ+J6DdOAWdLOLzo82?=
 =?us-ascii?Q?l+wXfuGi6Nt7URZN+pk2qMRZagWuyeypzaH55lih8Dfb29YN+BHIOO/UD9zr?=
 =?us-ascii?Q?0wDOh+AtfvyNLTJ9Hocglv6quS/zXFAaMfxuyS86an8++elMVa4C0G3i0kj1?=
 =?us-ascii?Q?ic5ae3VZIguY/MCpx0yxmfcw66EO/jXXZALwau5MAGA/VPjlqUiTdj4SHchz?=
 =?us-ascii?Q?1w4qNLuO3QzsMonL1jvnbcuqp9X2y0f/hOr4n/Ah4biuOcIoi0FY7RtBxTAs?=
 =?us-ascii?Q?kQ20xcw6CCT5l/Snqkl861D7QcPcTc6TRDMbsOEJnsTZaRXpuZfB+Xxil3p8?=
 =?us-ascii?Q?4R9PSQ3dOrYxDuAVl6E7wAB4aMX3pIJhskIvSsSnAFGx9x6PSaJu4h1/rQNQ?=
 =?us-ascii?Q?seYFXUyXYrSxiU6xJEiZoT/GiDajk0WMC4uKutJtafbnNTGb1/Q3oXoeGSHS?=
 =?us-ascii?Q?Yn+VEdm1C79Ej0QkktWh9Q1I4iIuKJxfq+coqy0q4ZrXBTz1KBUbUk+pEANU?=
 =?us-ascii?Q?DvoNYOUd0NG2D8/1CtZ9WVhfBkDQnz8EKmudQirweh3+BlOAUS+WRebILh8p?=
 =?us-ascii?Q?+g+6/fwKIwCs8Dp0BCPgD6tojNDVFMXyZos2ig38T8HxxJqJuidezelooV5Q?=
 =?us-ascii?Q?GgJVu2s+1b/Q44qI7IrI6FUjDQJIKkjWFPLBtyP1K/dquyhbEnG6TRxDJSRX?=
 =?us-ascii?Q?mY9EvH4JPA97D+b9Zd3Axh2M6gqj3o+sw6oEXgGY9ydjSI5PXMopyrb7nb9M?=
 =?us-ascii?Q?0Px9+HvB+Stw77xqlD/yyxVdSaav4HBIKNC+Orv8jDolKmlFNqnYPvisb2Zl?=
 =?us-ascii?Q?QOzuZSNZKNMrzNSmOQzeGOWZmhYikUrHfVz5qTAt5RQS1oKYS3Ar9Ihb+zhX?=
 =?us-ascii?Q?G8rmXs9VrAIbiOCMnIdCA0GrckF1pjUOw0Ml+pQCKKeoPrZNiGUQpafBn3lV?=
 =?us-ascii?Q?SRzG2FMPzh6vBUx87C2m5ZNBBvu0oKpakegrz21zQcEx9TKPivBB4GFxcRRX?=
 =?us-ascii?Q?7dGWkxpmSWP19iBeDUMhu3dTwFVEa6HMcS/z+L9mRXzK93CCJjLvLJP/TZZb?=
 =?us-ascii?Q?ZJ5S5pd8FcBWjJJbc84jwTkmr1d13UYPmjbkkMNeXpDoTcZA4FdKf4Vx2q6/?=
 =?us-ascii?Q?x6eMKG1PtULK9mc1YuT0aa/+7ZXJZ/2XCM1b0o4Yuhdr14bO+z9Qg1yZhA8u?=
 =?us-ascii?Q?44l8MXzkbE47UfrbKGSjPz9eKilL0SbAQCarLSr8V7EwgL5LDGXx/HMegAVU?=
 =?us-ascii?Q?cOuWh0/olg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0e6856-8401-4cc7-c5aa-08def863eabb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:21:56.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1aYTtavzTzYG8NmaPLOyT9d/SrncJ5HHPRXu6P53jD+BKzyMOymO6JIxL1KPaa4oCLvfevhWAv1HMyMZEStzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

cxl_get_poison_by_memdev() queries Get Poison List per partition but
never checks the result inside the loop, so a later partition's success
overwrites an earlier partition's failure and the whole scan reports
success while that partition's poison went unlisted. Before the loop
conversion the PMEM query returned early on error. Stop the loop on any
error not already tolerated as a RAM -EFAULT.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - New added patch ( sashiko-bot's report )
---
 drivers/cxl/core/memdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..e39b3d13fd56 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 		 */
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			rc = 0;
+		if (rc)
+			break;
 	}
 	return rc;
 }
-- 
2.43.0

