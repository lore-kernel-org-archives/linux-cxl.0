Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F532882D6;
	Wed, 26 Aug 2026 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708745; cv=fail; b=aYj33Sgi7SQ1hmNC76zNI8FmiYtRaftWQ4i8poIw34L2VjaSMQD9/7cAhcnM6QJ+wmzvUeCiTG+IeavHxpkIzbxPJf1R0AOvbxcjbYp2sIijbbWTB0opg5Jm8k0CHcS2z08GmqGAjWgg2Zg7g1CRPmQw9u2LdTHAdwY8qF+iuJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708745; c=relaxed/simple;
	bh=aQtHP7Ze9GdkDxXl9K5JnPHmo+04QcH3/PQW65BMiBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tksFI8IP4iMkAv0chOORGnKriThLQUHr6XZ5ouub/5hBTR7rVrIsLQO7TbaKN1IvfxFrxczN00mq6mgAF1FS4e2CwY6hEugWJFkrnhskANUaCwfBOu7guWqg2rbce9T3bpHMiaoju//iZMan9Ufm8mJN8DtJAuLgAVmUhVGDP3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iaXQwZbB; arc=fail smtp.client-ip=52.101.57.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iaXQwZbB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yon9tAWC1g7MKWhraCZ7bUvHzmmhIMaLosQJCtPbu0uvdF6V2+5kto3383xvSbTyw2m9QO3ddEhzZ7RKNqFiS8RvV7Y7V7uzqCgp/3ub7a79M2uNc6Dk0BaTxo+QpvSqY5ynuv6pzCCTONWZxM1aNv7FavfwBAHAcaNZA7MihCaIN1r150jUmDvGb/xZLG12iErgtJlczaWIA+G/HUHODBbO7PPUkSktDzeB+dbHxYhnD1SpaPkXJOmizwc6NwBc0Ju/0pqaGlv/wzcFfQlVlBuIRG6z2NYDluBI6GrHyJZFBDNdt1+qHexbrphWjy/bkDBErpLs0txfDWh9EPJCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St0FiUt+ChylOJEPrekuFWzTORS87e7QXIfNU2Fyjbc=;
 b=rh1IxYgeJsGBAM9cXyiqP02raWnQnWDdHaSM6VSAldRhHksvH37n3VR9HUEzXY7LDC4+tdTgS+i8yZ0LbP0f5r7H+134jy2xVjzjIINydnqwOMlPrefQIoMPnyCouS3A63TEgGbG6NzopwMjdRDWVtafXzsTU1HpYVZYvfofBSSoiJ0wfZUBT0kEEA+Vdc5cZf3Yh55m4udOnH3WIs/oGnnUzw1ymJUx2Qp3SAvQyv5sGi0tdi9RlmmrwRcbeeSIfoLY/DK34F7VzFwoNuVa0HkVXa/0tcSSfM3d+8EkF8J5HZfh5iV9R1hD7JK8VMLGbzpRddFSS8E2tQfIw5iSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St0FiUt+ChylOJEPrekuFWzTORS87e7QXIfNU2Fyjbc=;
 b=iaXQwZbBEKATk3tnJKFUmGj7xa0V2s2b1CbzhdWfcZ1xFJjoGyqzWtKkXGH+N2K/n422oRowigQuldUjPaSgr3L/sLXo3NNl3NYqTOtiYRa3HXGb29vN9AXHvpvQhUfWyBYPWy8qmHB6nIzMfd2Qy1TXQgp0zUYLg9vjuzooTjmyKSQjBT7Akd3xzG4IKLgLl0hdCDj3zGfP9XKkyMQyZ8D1rCyIQX4L0cbnanEQ8Ko74Cl6UMNkbukIPSN9G5E93bT9dLTkYwZ08YSkjvVjnbXHBRmHIomOenxANtXR/bWI0xkwOwsYcCbfh8enprW3QhRDCSePx1luROwZ3myKSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 01:45:39 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:45:39 +0000
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
Subject: [PATCH v6 2/7] cxl/region: Scan all partitions for unmapped poison
Date: Wed, 26 Aug 2026 09:45:03 +0800
Message-ID: <20260826014508.9989-3-icheng@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8367dabc-eae6-4de0-2e93-08df0313bb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ooa52aaHJAF5bLjeoUkgn3Rdcc801AO4KaU3F516pPTDSfm1BDn40ZBjk00McbrJWIpgF69xojzw25Nd5rTH0e7WspitHDKEP8VkDJ9MOof+LuNx5SqFZg/yzy0smrGnk1N16g+H8EINddFoH/TsMLDQ71TBcF81MFE2ua9Hmncq3UIrv4BTdEF7zya5fEaL7UpgNzACapcEq99toJFzxnjVd8cacys0pFdMXeKJK/2avG/5W9lmPZg1rlUIFO9M+wT1Letmvom4WjHMDOA0HHe8Jx+LQO8S8j5RRf8fAxfrH6Z3+YaYmI6LcMOXEAR4NDXvJsnflFrYcmE5O1eO7km2nS3C1h8uHTlaP0BPqg24tcfaUbZSMd81aNCBx9tm3qTPqC7OgphJ+IpA0KvZe6q9GKFjXdHzR1ybEIDhG0K48ZLPfKt+rUEt0+g/j7UxDuFv/IouDr+uooiPWQQgNBe7tCg+E2lQqBbMIqjp3otfKgWnTVMkvdQBJE0DUXx95m2sHmpS7rdt8o0Wof52xV10iSvHwzAiDA067+wR2t2QfLRV72z/31g2lkQ7ratSrosYt/9VOXGOMhR5HPK7aHkoSIvbq+WWtm/QQh7so1cRZQEWUFZ/7h3IJrASIZFZiTpEhgfB++5zJjrELupR0yyr9UTFMc6ZgTRFJ9QAgZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MgguVFbxXyh2KCPOUD/z5eENTsna3ntVtvvVDKEsHz9C9rRF/lUJhTbE5s+w?=
 =?us-ascii?Q?4nn1R29Q0RWDtcHIe+4hDl0bndmcp4a9ESzaTGjSz0mcHlEx8VzVgQ6XK08n?=
 =?us-ascii?Q?5GFf2nIt3+Wje/wT3fqdD3vTRqNabnYT26mynzuhy48yEc3URf6RJ51L7MGR?=
 =?us-ascii?Q?o3sfkXHonNLmIXXuxH4vHR/ZxnfyaxWhOcRdRM+W7Ef+fB4idAxn8L4HShlv?=
 =?us-ascii?Q?cYHWRY4wD+vbFkbIDnc8mo0FuyCPBB0U/kNXSM7dWi4AJyEw7V1FuXyzM9XJ?=
 =?us-ascii?Q?0Dt4Lu+1nkZaAGsbQb1A7Fv13M/gT5mffZAu856Hn/BaR5i8IN2BV6wjpL+4?=
 =?us-ascii?Q?WetC44Ol8Naue+YER+y46aNyu0AluH740fc0JKYNGbpr7BGH28B4+6y/pbQH?=
 =?us-ascii?Q?hBeD9KVpYkW/IKCvBOMAEB/aSXinYhYRqiPqr7mP0q9cApZ4kBfHT5MVmyYs?=
 =?us-ascii?Q?4CTbVETwJRB9CrcqK13jRBn8dE5waYvgolmkvfZNNl708Li7RhUgolTfiv4E?=
 =?us-ascii?Q?CACcd2jJLMoqKtWC6NxjDHwFcEhdmtSwt9W6Jf8PHMKj5cHFcl76fvKj+rNE?=
 =?us-ascii?Q?sHTw4Z+KBL/YHRhmcZijwRR/JSL+cpAAzx3xat2CC0TM2l+FtmejPsw1Yaqn?=
 =?us-ascii?Q?W4NFPfJNiRd4yBqxz92QcXer8Pg0HTdSR36/r1dx0fv+2JF8NUOoYdy4X0tJ?=
 =?us-ascii?Q?qbP8Dg80Ft56vLe1UfXW851iuGoub7xeSYyJUANzaCBRNba8UEOWGfPyyS40?=
 =?us-ascii?Q?26T475VKFiagExEeTFdg7BbEKSPtDfzKlrL9tZvAClZCxIWk7hAYJNWUWDf6?=
 =?us-ascii?Q?7momiev31i8H87LyZDT94x1k7Gl7aLjzpeG9lNMtXVHBlzpRNpou3p5kQcM5?=
 =?us-ascii?Q?3AVn759nYfcgohSL1+s5Qlhzw/VbFWKGLPM3ofYhHKm2rHpcsrH6UAygLf0h?=
 =?us-ascii?Q?kPsOeZZsEbNJpbzpok08o7qgnwLTSyq0PM33aaNZIMqOlQOQKfjLuzy78wny?=
 =?us-ascii?Q?xqBTf1j2JWqbRMXkczMPmnIz3VAi5UCwYBTkclOPD00Gl1cqs/sgq9KnQtEf?=
 =?us-ascii?Q?lRFISMH5YL+MZA54VJtV1Wfw3wJRCQV4gw77skF4zTrxVcZnv0tXoahxd9Gl?=
 =?us-ascii?Q?amHNShc9Z+O94OVJq/pDmbmezUKapo3WoGswCOjVDmIxcbV7k5nMoYBUdB6q?=
 =?us-ascii?Q?maqYGqX/gPbTksNLuI++l9PwH9LIDoUGK0IycD33Lf1gg1FfOyB6/gFfRGxK?=
 =?us-ascii?Q?xG/g0qjnT7BFfk/j4OgAN4jVfT5Tg53Z4gOlHoKR4L8C0Ljj4YKy2+mIrblr?=
 =?us-ascii?Q?WmGjoBkyv2WKq4IBsnd+mQQVilXHPbFcwdhzSFn0P4/A0Q+2Ug7AeTOXfg0K?=
 =?us-ascii?Q?dcPCOamnQ7HcUwN5WJozwH1WcmR8dxfQeZXUNdXsXes43JaVmStXMtZ3Hwvc?=
 =?us-ascii?Q?rDJijX140UdtZSVOtSviXWp2MSMwmQusdHwOg1kFEpwriGHgh9jLLdedqDem?=
 =?us-ascii?Q?egKIjb/rLN3utf5qzpcWP0ofm/Prpx3jyPIiM4SzRBV4Ef64SCL9dLfMB2JU?=
 =?us-ascii?Q?u4uTS96iaBju0ap47QyUHgaxY3NkxGm/6RzofPgfBx3CkfXSs/sxFZPB11O1?=
 =?us-ascii?Q?HU0ixOgqHwaGmA2RjC5qavag7zNkZ3YlGQp/8Lkx1S6yoAcYtKiEJPBKWPyc?=
 =?us-ascii?Q?WM5rvqK/uMmuJDguzV+BoyXtlooPpor69L0YnZ4tOGWNNJDh0AqELnG4mAT9?=
 =?us-ascii?Q?GBh32BObYQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8367dabc-eae6-4de0-2e93-08df0313bb59
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:45:39.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UI9s1uhsJavuuXuBSpryAEOvhUvCV8VDtxHQSAs8vCyAlKJP5ObTn9TeURtf7E/20nqHEhLRzZ7PqaCARB+pVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

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

