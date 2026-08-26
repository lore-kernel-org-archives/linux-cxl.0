Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0949362C;
	Wed, 26 Aug 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708751; cv=fail; b=lK1iCl1KI84Nh/AP6eks8V1mG65qcPkFzlQCTjGyHdv7cuMZELDUayhEqcM4NvuhLdq4jHkbwmd2wL5FWIFULzetCY/+Jtycbth5tBdRPVFVCX3BbAdLjEdyrLFPJf1lwqt0cwFB46MaVhnVXWqEStamVXa45v9sMagXaOHXTuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708751; c=relaxed/simple;
	bh=N8sO820OP/w/ocMdUW+tso8YAFf/1yY+6ASfXgI4MtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jUxP9HFDhoV220B9Z7DOy9bJJGQw3C1R3aXvw3UmmjIsz5CDa3g5i9+rt2jjhFmvfF7yYWrQb0i3M7j2WDw0ZSORGngsDQkZzN9KWHR/dEvuMWMoo+ooUAqlELcVDRbqc5npBchnTxtr/QQK6pt34guolE2nwoewCZ6q8+y1J2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iTR1uh0O; arc=fail smtp.client-ip=40.93.198.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iTR1uh0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFE7rBQctF5kjX5f0F/i9VtO8eqerO9osds0QP0Ppda4w/jgvlHIaJWH0BzyDtSzVqp3Law1EDGBEBPu+rjwuZ3XixaSYyyI+Uj46Evafz4i4pMW4YqdpwKdmUfz25LaAl19+VcgMZXPkjnTxoLjL4w0mW6FJBC7bNuvAgnLw1tt9BnwhcRk5iIVS8JE9AhO+bi02lBE3W8bViK7KQsM7ePDym1pfBgh0PTlqLjXuknf6hpA1o5cGzloaZRTehuvv4d5gdwM9P5XdGuxUNywLa/2sjoJz67/2ig1Ue3ebdhv4e6hhSizH5PfD+B0DfJo4ksCukbGNU9x7Y3Vk4z9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra+QSLoXzJ1Yf2fHmyX+ygANlqx0NusVyFPI0RGSLso=;
 b=WDmaBJasbKsqonKnpbHWje/5az3acplq8ruOgnHlR7b6IBBBeYDC4c944e7GMcRR4FlYQ4iQA8+F7DE8i94tfS51OQNMeyexg3qkqgNoZSDdaGaRAqpEnHvRkC8cIcPcwszsF7nzZsDqzrArz6Sd4hNKs/xKly1UVDb1cP4eyPFFUUU+o6K0MXafe5EVsFG6DW/K1AOvNIrm8rwK1/wwvfHvcSGVyEz88Opzbgc0HlbbVGmvhst1a+Xn1Uokz4ZpJBzmLIWuYqRVMVmXMfYfDQ7wIPdT+iZnmLsOlUfpWKfgqwUkyMBjq5piOjhYPyMZgXof6UtsG0A3OaWYTb/fcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra+QSLoXzJ1Yf2fHmyX+ygANlqx0NusVyFPI0RGSLso=;
 b=iTR1uh0OmifDs8uqTORJvXbXEGHMu2l0k+X2KjLr6F9sTYkgwDyCCgrNbwdvjn8Te23nGg8BYgLecOiEmicYyfcjTb7hxVEetsn/c9UAqp3R2k78FJOyXavChMYZSt224IfCdRWrmOXXYdDH1uFK2tFUm5lbuO8kFGcwDzO63DzsbUt09BId0gvh/LK8icEL9pBXKLBsNbDWeRntx4ivY2c7FxONwAURaBv6vj/CdoeOv5Vq6s861r6CSRmL9dy1NBQvwPMuQQ/k3IkGZQ0oX2qMNVSy2RRlsblmxtuIgoGE9qC5aWvpRl5JOpxfDRnKk1BB7cvvMkhJp6eWMIKChg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 01:45:46 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:45:46 +0000
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
Subject: [PATCH v6 3/7] cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
Date: Wed, 26 Aug 2026 09:45:04 +0800
Message-ID: <20260826014508.9989-4-icheng@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37fba38c-0d25-4193-3c9d-08df0313bf7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	D3jaB2CXO8sL1Q5uOvtldMF+8beGS52dFanwT7ztVB+06IXkK05AgMBbe30nxm4pF2TAnjdRtj0eL28/a6QMKkrJ+lpiR3tLtrSY9NpMRUX3FBPOwIRUXCYK6w1RpZSFNBptXc++yaxDxtqf65u6kZeKqDOgkZ+r7NNOTAtnsTiz/FQHwsA6Ov+jKoQ6i2OmVgh6l4BMqiBtlR+ShH4X3+cIjk7q3Q+Izyv849+pLLtlyw3xwkoFCIt3JjyXXAsOMQ4SLrgEfo5fsQ6UPSQCfZYr30mO0DGCktGEWN0fwAHiIBI8SS/jEGhngk8Ey0V+ju5a9ZDN/QDFIooV2LUszJGWUVdfXsoYf1Kiva3IxQbJUGPOWEoJDnRK+5zNFSAIc8UJ2qNaGFDfMFn5WU5brWMulxmap6EzdiDBOsfVNypM21e2psiEo/ll8Aev1FNuWrt2yCIMlUZCj6rvP0hYkwhYjWirLVklqG2pV64n7i2mzeT9uHkvWjnUFA2pPmycvk5y6Bq6Ri0N77mFIoYRVCgBvaDpqIZqMq28vkEmvFlJDN+ZJGQWHOIxbZ3AKIHDV4gHmx+An0DbfIxdAdhZNygtpxRk/aICxBJ3Ayzg+nrEtYCpNYiwGVeC2zRIxCLHxcIxVyuY1ZdedAuX2f4BJmYXQ1WxPatODVhZ9Kp8bi0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rwLGoIUvM4n7ZsH07YIjVPn5IrAAhTusEH2YqAvT7sY00eeEm9WeQP9Rqx9S?=
 =?us-ascii?Q?PD/WqFvWZhoYPcmBI9tyKOc90mHPo2TrJdPguGCxkHbylXtIu9lnB6srGD3h?=
 =?us-ascii?Q?ehkOHmuWK9w1W/VvASA8K2ZnBclY6bcEQDzniy0DvsO+owXHQ1UGlA+ExS1J?=
 =?us-ascii?Q?G1RfWzav1ITaHj8Y+aq+vkJuH40Rts4RIkA9hTR3p0naHh75Pe7RfpBi5cR4?=
 =?us-ascii?Q?RX8JaIQN+L8XBHut95mShx8kQnGg+L7/0CpfS4t8mYCRyayCIVWJ5B7i2UgD?=
 =?us-ascii?Q?6qyIfFwIMmdvIPsNeyq2ihiELUo5y+QRUbDCjT6QTWIpLfVJXUV7BQY2thlV?=
 =?us-ascii?Q?m7rkjmaRQy9JWXM/KNZrnHkaGM0b6leLWLWiWnUH8IP1xGnB6BgXTmdLFWkF?=
 =?us-ascii?Q?VTIP3dDfZCQR63s3Ox9BujfGWa7JjWmM8DzqCMgjQZp88zygFbJO518nOI/Y?=
 =?us-ascii?Q?HG9jUQEScNH3HZyHWVz2AC3wIienpBbYb5LRclApDAq7lcxTOXe+vhfRzIJz?=
 =?us-ascii?Q?wJ8Mc5RrdwveDPucvaQaxI36/q22V+rsbyLUWUmnczkGrG9ApNE4K40ktiXH?=
 =?us-ascii?Q?OF1AdP4MlMr4/ziqmwxF9G5ZI3e3kA6DmqJ2XxkIutwz4hz4QWuTCqno8jvn?=
 =?us-ascii?Q?gGZnpIER5SRc/X7OvKVsYoLIeGRLZ/IKRRR6dQcvzyEZ3JZbe7AY8F1shbsw?=
 =?us-ascii?Q?epJQDBFzYC5Ceqp56ok4+S/+anfD8Ko8b++Dm4OLgx665tx6p0HA2rclD+KJ?=
 =?us-ascii?Q?a93DsXe3nRlguw+N+g4yMuhZ0YhkQDuxBcssZGcvkNqpVgGcX5hoDwEc1IVM?=
 =?us-ascii?Q?5gDh77pr3T3LDFMjrd0ekIZycsmbjx7eQ3f6FCVal/xV2OwoEb5AscPzf6hn?=
 =?us-ascii?Q?uO7cNr7v4NPmq4p51IArutyIXy1HJz7M0UGWhlt4WM5DPEuf5ir47Sc1rPpN?=
 =?us-ascii?Q?e33KP7MM7dBXhO33Wr5EdGalLBkz2L+la7xncuxSdKiDJMO1vZ2lxl6pIt52?=
 =?us-ascii?Q?mghuL+ypebINY4ZBegvPf3Bynb6go/LE/1g2mkT7jZ4p0zUMpr+e8iy1m5pA?=
 =?us-ascii?Q?DKihgXht/NOkCjJsKTwqccw9LhzGv+xzH0Rp8c+DH9XXvO8qNYPjL1F7/5cQ?=
 =?us-ascii?Q?rqp4yiiGoYadU0rr9tBev0E5TMoAu1fDR2cXnv3c1iwsc6H9kMq3zdargnr8?=
 =?us-ascii?Q?ZbLrKRcBp5b2l3Bd8dB5wpllQvVseZQX06I+47X3WyFYkuFFL0kZDSDjMFtd?=
 =?us-ascii?Q?oSPWt3LZwJtsxwTZhjyYOvSbtnBr2wyL8Pb5dEs9v2SX+flo2XQ5qX63af4O?=
 =?us-ascii?Q?gM11HAbOgblrWkmEq80QxXZUaIHXgXSV8VqnVhWpAPoQ50YAfk6z3a2N/pEw?=
 =?us-ascii?Q?nVHvQcbnBZrZzghbhsvWSHlxiR5NcxXdmX3aeuUjGqpVFxksJZKPMP+vHZt7?=
 =?us-ascii?Q?2kscvfZW4TSDjLnKpqmJKfAG8lb//RXNGOYGrNV+BfGljr9erzyM9vV4A08t?=
 =?us-ascii?Q?/IeLOorbhXkf24ZEaj8wTeQ0Q/H1mIWLCsaPv352azE5eO3wgjVYNr8u3ZMm?=
 =?us-ascii?Q?nsaDmGQTze9eafYqdWmuvQCxQSGgoLgUxWN4jZocEw4MpPwTEfzdcaJOJZZC?=
 =?us-ascii?Q?KpAxE+19V0usOb3I9nl0jGBzFOrj4+0Q4E/KFJD+g8Q4N5y2AllaLm9rPqz/?=
 =?us-ascii?Q?IjLyl0AhX92mvg7kWA1K9f70ZQYr4QB3ztKjKJhl4dYB3H+Y0tEtQeXPJ8uk?=
 =?us-ascii?Q?nFk84YxGFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fba38c-0d25-4193-3c9d-08df0313bf7e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:45:46.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrSMQKhV+Po5QJPOBjMoYVFIJ7CIo9nBnXdZyj91IuWknS3kag8p6Byb+NWqpqoY/MKuTy7RSA8f4esQuvX25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
for Get Poison List by skipping that partition, but left rc holding the
error. If the tolerated RAM fault was the last poison query before the
loop ended, the function returned a spurious -EFAULT and the poison-list
read failed even though enumeration succeeded. Reset rc to 0 when
tolerating the fault, matching poison_by_decoder().

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b03f30c04d35..ddf12075b95c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2930,8 +2930,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		if (!length)
 			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
+		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM) {
+			rc = 0;
 			continue;
+		}
 		if (rc)
 			break;
 	}
-- 
2.43.0

