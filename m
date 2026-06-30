Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119DC27FB3A;
	Tue, 30 Jun 2026 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805643; cv=fail; b=FocZxBKpvtOiCuU3tJZiW2CU+6jgLYhQoPmGIeT98PiR4OEghinjS6E1ATa5Os6Lyu6eFxUttPKIwPaeVjMVb5uwc/YKNz/qbDP+WygWE7HXVy40gIWvj5sj1o9BKDCJBPYCm/SCGcfPtQ8LP8FBCkM498H3tUBX/anVkbo8X5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805643; c=relaxed/simple;
	bh=twU8b2A4pw6rIivNVYuAWYKPNsYOSh/9e/AduiYgX/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NiD4TcuI2LnkTRyPLIoLUuvc+2XmyfsLND2b2hNeYH+zAZGMMOz0hMg0etsKABEK9C8cMww2YrSa7BFjTKprsPHl/NpUKo24hkkTEFUeD8OZaE/0wD6t2oR51O0Qg1nKj7QYCT3+FIf6HesY9EDaXZYxNAd9JCUU8Wjb1yH/GLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQ0h3KJc; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQ0h3KJc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTopBG3VkCGjhWeijq+CeCRx27WGwO4q0FBsPnbQuOhikvIJNYHQliUH9OfR5HYqhOiaBmamRoZh+VZ5xPvfZVKCqjS/JEwu89eam1U6PKYgNiKmgKWsY+TtSa8I4z79ObGEAy5pQVWP9P5p1cZdvNz+yBptYhifWiIVvj8LBoKjbCchvYBa1MsJXQWJ3zp4TESiNP2XP5HoyHbYcq0UIe3j0vUwgqabUmTrrkiuNLVqEXyEYCgdPUmF+JxKy6YZyPQTZDVSCgUOMFh+ibvJ83yrq3X8W8JUAd/ITWytEmcoL16NG1KuEfeRe8GH4g6UgXBzWrRpksLTSXECM8sJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1u2qbPQ4AEpswnC9u2dSkWSPL/s+maRofePWO715y0=;
 b=XXV28Yq2+gXfxvbqa11viS99Ce8Ny3PHhNe1//BB8dW1UQmqsnMt2PwGv3JEiaClRkL+ICZZfLUzR1NefTJes4ZAvbILNxaS8aWeRs+7Pho6F518evBAKY6KBOD3QVd6Zdi09r+CER4DoggfzIhnQfrv/mFl4cBCRdhxaz8mW3z5jDF2FChff6Dk3rN+Ro5NypkJPcoRlj/ujDh/tHh5kBYyTH846nu/I80GKJc99TteBKZUYU23c5YAP6Wb6TKzP/OGpt0+59WrruZQvw/NIdgcuuDwyqajQj1NtBFmapt4HIjulblVu0ACxujLtWkIOS7hQKYBIZzctXS6UZXeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1u2qbPQ4AEpswnC9u2dSkWSPL/s+maRofePWO715y0=;
 b=mQ0h3KJcJauNRJxcit+BJ5/T32Gq+xWUtCHHO7ROYAHsKEUqD+jw1oFeq6JDCyQEqQLv1K4tCK9gUK3NCJjpxyaaTeydqdXI7NrSTzW8U7ZYqrskhTsmY4Finr/yn+QbOm6zxoeR1dOBza84HmYf/GRQM08sVwFO8WjTWvRSVLeAQCX6eFk76oOvDLwZRS4f9Zhd8o0AXjfBXi6CVtz5AwkZXoqi7GX8QprQzPZWrQNQ3SzJk4dmdapuwIVP1YQBGx5JMsqrCcSH6sOn8DfXdcw5coi0Xrdz0gvWIGQhA5eW65yXrInmu5IVw0kxffaL13FxEVfGZyYqnBFOcO7DtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:47:18 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 07:47:18 +0000
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
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH 2/3] cxl/region: Scan all partitions for unmapped poison
Date: Tue, 30 Jun 2026 15:46:56 +0800
Message-ID: <20260630074657.43077-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630074657.43077-1-icheng@nvidia.com>
References: <20260630074657.43077-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 226dee9e-6afc-47dd-b90c-08ded67bcf68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	yPOeRJf0PQ5JNSJxqznkzWDk2Pg3z5hyK1com7ZW/IFdhHVzEv3aZ0b7KYjuN22fdlcAFFyIxENkanmvT2Os6bQZFpuU+1s/zaEC4UEe4+8tAFun43PNDlC5G/XKKdTi1PCJDyP9sBM9Joa1zPqVaKBvszDPg6NZasjEOeyDMOw5/e8DTi4ClgJ6499ccHgTrWu39blS8qidrlwzX9D5G9JWGdy4sm9otMRiKItVca48FjsdnDgglCisenRgMUx7ros6JMHGkYBn2uKowgFRQunEFTlSQ7H3r+Rl5akyfdzrDMCUx/quizsSiLvxV9SvTYNc8BGW6fDqiO7ZEsH2tpibVpjyNEA5Il0IfLGoiVuTDtdItd6Jn2EKySXhr5Gw8dlxGFG6xmHcyrHgWqiVrn7TcpUT2HXC+7P+zmR2tcpW3aG8JuRmAcv+m00ipo3Tsb67HjaNHqN0QTgfoRhx3VJN0JDqSAldxlRqmV2Q1qPwuavaJSPf4a5I1zGrCR9rjqoojv/fdZ8dkMlJivMBjTmhcGWS/O2GOq3o4dEX19GWr6jc/GewXGej9VuzgflkvYXPgK3EWb0qWnP/SdUdkLOZumjnUBen8S1l1pQmDd7Zdq2yxlt3kOkfQq8HY+jFkmq8A4aUvashjb1eGLpOjXbvA/l64HX1YSF6HJ3i2XY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXNYrR2yaVwyNI7pxUNokzVtfd1Z/i9PF7f+TiVQNlfeAFz/cd4FnhxfcjLE?=
 =?us-ascii?Q?oAwAT8BWLTbXcUs2+/YhwuCG//DHMj2bB9ll/y6RI0s2B/y0UbQUd+AaL+Px?=
 =?us-ascii?Q?w1bE863aZUzLr4BH0YZB0EfZ6sdJYz65+Vpmslo7douxl3m8u9kiDHRSEZaq?=
 =?us-ascii?Q?tPAS8iTQcxPX985zcNjTN1FtxpSEdH2F6dhsvdi2nEwO1aOHsyLQtlO9SZB6?=
 =?us-ascii?Q?gK2zJrKoAd7J3xTvKzRCwmeoseZEQscnjRT7YKaKXqnxygFjpWp4V9bTr8mB?=
 =?us-ascii?Q?sJP1nBIgU2nqqbqElRCaF1EwCYyZDxlkvSKx/oLnY+pLp0aEtQRET1qugetM?=
 =?us-ascii?Q?gwrqXPcsjmivpaNf5NyxoQIRrjy9AKos6C0o7FSYfwKi1t3+b0M6GlFpteuC?=
 =?us-ascii?Q?bpSdqTw/MqJsgWKsvg4gcU7Yh1URe19RSE1RLy2dYIMih1N14J6Cf01Nn9LM?=
 =?us-ascii?Q?n9mpzQLA9KpJ8Jf3J08wOVGwP/TGxAYBrBLoTbzGqn2cp1mJqHOx32SaKg3w?=
 =?us-ascii?Q?1D9JtIYHalBET2n2YdhaDaGJ39vDVG8mRKKbYRQOTkFo0HXHBEAVNKe7bIqF?=
 =?us-ascii?Q?yNNazdcY6fKY0HNhUhaNwulwS3e2Juug7FfCJLR6TfPiF34b/OEkrthP33LZ?=
 =?us-ascii?Q?pmeNSIzvr4pgKhlP30pSTOY8dX++ajuKl4MWBNKbVYQpaLNsS7QIE890o4L8?=
 =?us-ascii?Q?YzINq/D1GqV/rEDIQoA/ros3ak6cM8XBq28xbE0ufeQGpP3siyAwI1WivZ0c?=
 =?us-ascii?Q?ttm8V6u6RrxnzPAkYRKOWRano8sKbFA+5wtt1Tx+Y94q6Xqbj4XoKXOljyo3?=
 =?us-ascii?Q?qkshotVHQ1wQirtCcxNzElECkOmgh1s0P2R+DYc0Ox03g0RqV2RC+A6LNcVX?=
 =?us-ascii?Q?0KRCFiLV93tpt/8sS/Y3GEMg5DOzB1Ua5yxKuEyx/q0D1FI0lSnXl6CmHWl+?=
 =?us-ascii?Q?YMwCR+cZiu/TRJ5GJwcBrkHL49mkdfcAdQCf+oOQ1PFp6EO8tv9ngQQRsBZ9?=
 =?us-ascii?Q?D2vkRDcCTHF/MdvpqzasBuiMMhjaEfLjh7uFFqM5sNFEXx2cBt+i7IXj+lzP?=
 =?us-ascii?Q?XA34jI5mT31K9RDM2vp3EL5Bb2Q7UN+b83rx53qp/C4iNbpUvf+6Lu02uyO1?=
 =?us-ascii?Q?WHC0iYkXUaZ4RNkyYaHbMTdhCIeg1cbZbejf9of3Nx3xIk+iYHVhnHGkTVLy?=
 =?us-ascii?Q?JY6trodIaqKSEdoJwBRgZewuH5vAODSdD8eYOp+mHBMiPjp3wLuHEAJcvXiA?=
 =?us-ascii?Q?RZXCUe+vmElGXFdMRn44rlNMELxRhd4CQmNiCi8xC2lzwU0RfBWJcOyiOyLR?=
 =?us-ascii?Q?r7p7XFxz75Ec6m9fYVjuL/105aHHU047YVsXnX5Aunk0lHWdyAayCnuwL9sT?=
 =?us-ascii?Q?De9W8l0ecQfLNuDadNRilPH1GQrytzTDcCX2OuI8f4uhMg0VIk7zcQbnSySU?=
 =?us-ascii?Q?rq7JDxcUGs+LIpLArj7PweHh3rRpE8M4tHHTx6ChB3JvM9cf/Ca64YbRQaL/?=
 =?us-ascii?Q?j0rQWA1sA5jwcgeXp/XZn5vXlrrxei3KsmffnZm+gHi6R34DTPQ8FJPHpq2Q?=
 =?us-ascii?Q?tcHMs9SPOtHU2OnoCggSA8gdNqCkYE/j4XsQe6k6gXjJwaokZJEfsiqOVJKH?=
 =?us-ascii?Q?hzc3op+xSV1YzKX5EFA/4Yct+uFas1+llLcY63ODylELp7ddspomkVVTjaBo?=
 =?us-ascii?Q?enoVJ3qj7urLyGQJ+C9cDDkQxGS65pkP/ZLCz8n/neWxjLmC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226dee9e-6afc-47dd-b90c-08ded67bcf68
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:47:18.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMjZ+nlfDDb86TrgFSJ0y11R95IU0uX18HtN1dhbDzfk2EkY+cxfe/BkTdMLD/ymyq/0m8cOmOQ5iFCf66g3Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
from ctx->part onward. A fully-mapped partition has no unmapped tail
, it's a normal per-partition state, but the loop treated it with break,
aborting the whole sweep and silently skipping unmapped poison in all
later partition. Use continue so a fully-mapped partition is skipped and
later partitions are still scanned.

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..be246fb09c99 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2931,7 +2931,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
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

