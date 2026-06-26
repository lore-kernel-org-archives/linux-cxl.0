Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB63BB673;
	Fri, 26 Jun 2026 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470475; cv=fail; b=GSDJGJz3hGNz2Q9BZFAKA4+9hBRnbrUs0sBQvuEgrTYkMAwrhKcpjCpJJJLfX91/sge83uuTXXGAJSTD5rLGEWzXd/3cSwfLYRZu5UJYlzKYShYp8xISIZ7tlSFACrMOkOkU4ngE689T7tf7qW9ELc8wnUF6fKWi/6Yzazf5IJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470475; c=relaxed/simple;
	bh=Keeu2lr9UIcdOg02joBPDktaVsTig42qSuFrclmLW8w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OCOszfLjNsckuBiMaWt/wEa2/FUNYkiFKZiDZgi9gHfPJRHJdEN+yOjqDM7vEFZlrNKCaujb3DBHM+y712cqKG4lgGOHrfqFxZipj0ZIJcfkxbfibm2lpZZA/5vCRnmqxKA9aEhOm0IJSkCItm/ykFQjPADwPZVzxWG5393sYlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=futP1682; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="futP1682"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNCOHz2RjhdxmWZnBJ8AKUWxiCDV/wILS2MjaeS/NbHVfCsxI//T1DoR4YKL8YiZFEfQo5EsePBIOoiehQ5WyBjO/uiTOE71x3IiKXkE8ykJxGEDwK2wt4gV9kHa6uZMDB0iJPqSrvGAMgb7N6aPgeUTWcogWODzo7BbqN4Yy5veX+XNSvZBJ34riybSXcDrTUAeuzLabAxYApuN2Rqb/s1U37l7Nk1fd4WHhnbPTfXiobn+2ndh91gnbe73EgJwLafe2bLOWN+rQM4KOan/aZH2t2FriCXSHrbqd+Xu0rEZ/mPT2S+OzUc3SXmYYhOP1SDIjw8nK+q2Cb1p+yyxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPmrRDqTZVbMb/zf3W+qbH4/77V7ePyFIsuxjjRCOUI=;
 b=cEIkvHX3ya0MtCI5BSob6prGOa3CO3rFrmARvx0p/il0J91Kj0XNfD/pawJyLhJKSOlUcYbK6L/caQY4bTDBX1Ti+T/Py4Tq8t+WyowjqqvxG85e+oNkiF75ngdTy8IsPKkRL/RLvxXxwiSfrKnv4QQkNIRwFeak2066AsFKkZG911IwBprOdm5sqnEtbD7CCNW8mxTPjDgLD6KoCLWw7oJD66yPazYLWc3JE/f7MNk944W1nmuO482o3K1pulbIQTNFX0AsOFb/icH4/ba/YP9vqmNRymwhcLidPBBGpuVIzRZuhZV0N8Jvp4LdATUsGSunZX7I2IbktLflMtWBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPmrRDqTZVbMb/zf3W+qbH4/77V7ePyFIsuxjjRCOUI=;
 b=futP1682tCPY8GLiR94Sk/vOSg3eVda63wt6qn8zJVm7ojkePXi4qo1CoAWANm/9ZsQduuyH0qA3JWXG+CvotZZt58PzuoZTmkvqOpRYbfQfDd7qXtn2miV8UARRHiddrrP2rYA5u3T1rv9UYkPEW30Pw5rwmVCHjkY1GLDHE0ayZOJBUADfoE2BFCWx6tA7l1Ya505T8ylPqejIIfOBRcY8JTchXL2xOtaQV4AMRzkCyDlnwQZEhjzkyy0JaMb39osQ+BNcwlRCY0IXxvalBU6UvqXWhJMSU1CHchFKUJvAwmYnM0MrACtgcyzrarajHSAFm+4L7by7rPi3JQv/pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 10:41:08 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.018; Fri, 26 Jun 2026
 10:41:08 +0000
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
Subject: [PATCH v3 0/3] cxl/features: Bounds-check the fwctl feature commands
Date: Fri, 26 Jun 2026 18:40:59 +0800
Message-ID: <20260626104102.53892-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 1241f65d-d733-4c7e-bb7b-08ded36f6e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	294VaykNFWlqf5QIJVrPm/a+wSOtnNdHrsd0lZs1icD8doY82TMkyAzSNO03AKKh47QX0HgZmJrw/pLFkhwBI1wzoNcauF78pBxbPiaT3lWl8gfWhavWpZgc9pZjtHA5dWRj2Y5L5CTsWTRoUKxQLBVC9jWgWqgce1oJUVuVdk5bUi73ti0FHunZUn7jIhBJDeo2vr9afDRH2a6vZpkkRrxfYJj/UzcjQlEC+NlesvbxS5X294lLq11IY+sR7RWIULPcPMLlpNXIF9fjnbjuQ9+SCbuqVjvsISTv2IFcMZ0tkGL2DkY/LFTqe5tQiInE2lkCH7X+vQNxULj4f6HUg3JrJ3ZTnLa3BwLM2M1XVecdU+wbx/eape5fKoZwXC7v4oHhjzpGfxsNHEcjXmBp/5V0VMjzXXFg7A4pnh+mVhUpTfqloCrYc2Q+XRkU960bfhnH2W3XncJjBN3924Qazs6sd62BY5//167iOE88p8/vNu/F8uHIjRk1w1v/n96UtbZh5eCRmAIAbk5bys7OFIc2IJ0ln04IFoS2IOrttlgf1+mn1uIi25W6gFgPYdkxHUAjgAf4jKuqCi44DcuSKk4MdS9yIclaABWKDA0xzBAWH52f3pv/7ju5aEC+7diMy/a3vLaHoNCiKfC41N6ULKEp5h0P3VWUcxDqAfBYQcE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(56012099006)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iYJIecTU1jxWNgEQ5fk/ruSq+BFXv5Q6MAvhkjF5S7lUDquiJ4HZAWPDLiyJ?=
 =?us-ascii?Q?w0+Db7C1XUgUzfIEkXTEBA03ALbwX50GiGSgUqlolgubPdlfT/EeNpNuSy36?=
 =?us-ascii?Q?3ut4qh0k67EQMe0E3W9dzXK+KhPP+mP34Wr+Jx+tl7t5LgyxlDmRs4qeonre?=
 =?us-ascii?Q?Wqf4Xo+a/NbZdyR84DHXTVVZKP5Ptiq995FzSSf2UDvBh9WCWkgYQ0P9fOPs?=
 =?us-ascii?Q?V5NooyS/D6mHnOPdRlM8C78wVo40cw7VOzjAVxqFyaCK6S+iqnEVng7+8QLL?=
 =?us-ascii?Q?xE2rQpHad7j4cf9Ikl2SPTh8kkCgjmYOAj7650UbB3VqJeTgWYTAWvuEdTRG?=
 =?us-ascii?Q?ox6LPCSfkEnbGEffa3ZwsH9YKyPzz84EE+X8KQjrz69B/3Kl47weWpyUzFhM?=
 =?us-ascii?Q?MNsFJDDBx/VkIPictuelq3/zLQP28Aif+f4gx4sAIyPsxg55zdjLSuuIsfVG?=
 =?us-ascii?Q?qvzlLQU75D5dDi4LbjpyGN1B//vorPvPglRSu0dMF5SPNAcot2fWTgdmejYy?=
 =?us-ascii?Q?QN0M1+D54DC/0MTYil5x85dJIUYatCqsWfFG4rA81Nip+6RTN7sB1/FIBbe7?=
 =?us-ascii?Q?ifwcfocU9I/z58A1+HhLH0ol51IaHY3QDcUq5Gj62VjonmGm1nL/LfbiEgAC?=
 =?us-ascii?Q?z6FumzZZyZhw63ccUx6WqzkRt1kOOgVO4GBOr6m/hvAbgIDLLrGbThRNBxQu?=
 =?us-ascii?Q?nHb7iNredPrxdjrTYGFIiyGclHucfOVshDhXZhSq3Pw7iIALIwZeLj060vLu?=
 =?us-ascii?Q?hOwnbNIBwMXRb26tqIfmp1hyeT0PtcKI8ZqbTxeM2YNm3XaKAxHCztVf/8tQ?=
 =?us-ascii?Q?akit1e5/Ku2x26ZikujmyDQWK64wMJgv/+zBnk4vboeEgh+M8EreKRkzAvWM?=
 =?us-ascii?Q?sLI8zerZd1utIGClSXk/9wEAmFBmM5ozwyG/DJ721UGiTspMQiVTyhQCfioH?=
 =?us-ascii?Q?lGZIDsFD8kbrsEG9lzFnqSGWIMEKZYFaIiCsroHWPP4phRWTs+aBHttFEjBE?=
 =?us-ascii?Q?jK4VvsCBDdSqlN2brp/GUMHaSNmguuQHCzMjYthTlJccn5Mjllh+GSD7oYl1?=
 =?us-ascii?Q?SE+dG/tPhfRpnvC7wTXoT6zbBtYRtKrG4iffHgl8X23hFcQVey0rUBQdW/OG?=
 =?us-ascii?Q?UVtch6KOJwbmZJjoR5wz/haHcoQYDyJ0pom76DMGtFxMWeI+dLsuwxY07iJm?=
 =?us-ascii?Q?tnaY5R+oFevCaWN4BNQ4aafDAPv1f3rpNnVLyoTTYj3Uo6Hpq86zBOUj2FQW?=
 =?us-ascii?Q?Sv8xm5105vlrPQkNvX40TkmaBJub9PQHw3d3U+Zz4I5qzlRsKvwVvg+oESlZ?=
 =?us-ascii?Q?zMQvN32S+dzzohNU3jb+3ECNZVkXE0C+aUkzQeF9UJL75fDhWqsqZw8mUSeM?=
 =?us-ascii?Q?2c2eLsj51WSsskfsXSSW3NgGnWkQxe3N6EOCa3rXL5na4H3exS7hByloWEB5?=
 =?us-ascii?Q?ogXmN0eOkR6yHYxweB1RNOgAjGzskKc9vl8RnHpgcW8gzMoV4TFbeoZvNtyA?=
 =?us-ascii?Q?aBA4xaVtpwiVA8KJlm9iLd+sWa4AmXI8cOaKD1dgU9QnKwbXLDoQHtrqecs2?=
 =?us-ascii?Q?/GNLch67AQBQjDMlnTfsjh1tWtLSV8v+EPDUftXCi0GCo4+LrZRb0YSyA9Ai?=
 =?us-ascii?Q?qiYI2tIvU7EtcKovgJOpMsIe3scmA1i3WnsdKZE3/2DQH6nJHNP+AeyLejbi?=
 =?us-ascii?Q?7gIi5IPuq4USk9puIfv2IFE1BLyObMTDJZYjZ/d/JWPdxz0gGIp5zt0iPyFC?=
 =?us-ascii?Q?NzlUcUyNyw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1241f65d-d733-4c7e-bb7b-08ded36f6e47
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:41:08.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PiiurxEJ/vjVdXucrCvexerhWxpPLC8gLpqHgdXsfiv+O1IgILOn+vwh20IZsTmrJjMhfkAQ8CnoXK6NhjAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

The CXL fwctl feature handlers take buffer sizes from userspace, which is
out_len, and from the device without fully checking them. This series
adds the missing bounds checks.

Patch 1: reject a Get Feature whose count is larger than the output
         buffer.
Patch 2: reject a Set Feature whose output buffer is too small for the
         reply header. A zero out_len makes kvzalloc() return
         ZERO_SIZE_PTR, and the header write then corrupts memory.
Patch 3: clamp the Get Feature read loop to the room left in the output
         buffer, so a device that returns more than requested cannot
         write past it.

A related gap is fixed separately by Zhenhao Wan's patch [1].

Changes since v2:
    - Expand the single Get Feature fix into a series that also covers
      the Set Feature output buffer and the Get Feature read loop.

[1]:
https://lore.kernel.org/all/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/

Richard Cheng (3):
  cxl/features: Reject Get Feature count larger than the output buffer
  cxl/features: Reject Set Features output buffer smaller than the
    header
  cxl/features: Clamp Get Feature output size to the remaining buffer

 drivers/cxl/core/features.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)


base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.43.0

