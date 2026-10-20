Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792473284;
	b=kx9tn3Xg67tGl9sdl9cnhUdueyRhuStTFDcsqKgBpfPguVWbQ6RTAdwT8iVcrwFUSLB9
	 jSUsTJGDs6xsaBdRKtoJh387Xl3J8iMMK4z+BMviItTtXdAdfQag9WXsrSxng9AY9Na+k
	 rV+LxS/jz6v1aSx65FmOe7WvvsYHFzCUL1r2T2bQt49IT9JbwXms89icoo0HTNPeN46/A
	 PpOykX4cVphlaMjDtuuhYsJgT1SbWNA2R7vi56zw5JohzD4Nf8mGlRp0U3MzjGlNfMh7z
	 CwcJt18E7GfyBIWowbYmf4jVvAXGz4bI5MNJVEAsEGlPU5wnaDCQsQbeLROFLwRzTGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473284;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DZfQ6BmgQQy33qjb5px3j68bOZSEhw7ITW54zTFAFAM=;
	b=447syZVuJClJWdEP44uaNWOaiyUKYfyFMt6Bd4OwnE2Q8eeh7/7o1ctDPlJVSDzDT/Oy
	 1RemwaAvYnST8Ts4V5YJQjlBeF2u+pvmcNfh8K3iHQeDvn0V64Uc5iJ4CNBgdEc8WQOOU
	 zJo3whXCIjxJqvqXkUHsajvB6ILJS4O/vW2AlNhqbSevj+QDrBTNeBJXjMp/d8wGpIjry
	 CxAHf/i4CkaH4Y+iu0Wreuj2gR5e571GiaqBZh8ksfyK4Nfk6c6SI0tFO07J4oNl+9FoO
	 G1A90O95Y0/9aLWWznWfPkPf1huwWesIpkoaqrV9JPrQP2BNcYz0sn7c9kbMYB2XZwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DoyORul1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.62
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B81606A31A;
	Tue, 20 Oct 2026 05:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B81606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DoyORul1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV6mV8d5JCevg/E+Sgothqfbm3KWhDSAvRJiVqS47f8/e+7cXNquyRfyeAVM9kIsT2PA0YHKSZNu+XavZfCNITW03MGutKW3NnRHYRBUoheXCtx3ys98BDd67+8s112oe5WWws9wX3VhyIud1X+IheHN5PXzz1dcBuH/Bh8128gSjuWcMveMe0bNCueFwT7Gxlc092i6Jgsj3yq10mx0cEyWodaupR3pOmqMIAc0EQ109iXe9q3iYvj5UWuPtAEzRcfXPcv8TQzojvgFbD23zpjVoFJj7S6Hv0WrsMLlbGqZ1YBUWhbTvk34PzF8zJ+gROIkIJPJKMAwt+KaVU5BdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZfQ6BmgQQy33qjb5px3j68bOZSEhw7ITW54zTFAFAM=;
 b=aVzMPep4YbQ/gTIP1/JisB7aHWZYXVFV+r83WL9vrMMAft4QVYeWBM4MbzXR90CPk9g5DnBIirGHbv0JFLloorL8MEiA1lDGQI4hF0z75ZHRveL5EOjy/LeM9KSMR0H+yQzEw4Uvhg7ypzgK4YwwIfr/QscCwcLEuUxQXo4ysCJQaPWKIoHAN0/3qh/bBPJa+a27ttzrr/GUPss/QMovw/Ex2fHcdC9nXPHORnljSb3/ztTMrpM07CKfq49nkbUtjwGy6JfY7vUqu7N0KzB15nucDftST8HldgStrcs+cSdMdU9nBSL4DwH71azSR/3bZIXyx7eVLk4a6Wk1z11vKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZfQ6BmgQQy33qjb5px3j68bOZSEhw7ITW54zTFAFAM=;
 b=DoyORul1QMXKqvx+6ExQg3+e6OMq8tMM1uZXbqC7jLwYNulFE2mOOo8wQ5MD8EUP54LC5hHomCQzrZ+Urc406hhqKIIOWw9CCgUl0ipJOrjjNZu3DCL/3KbZb7az4NyaNclnvWFc3EQHrg1KoOm7XWm1gQ4hUm/gxpOxlWS0o8gW2P7aZhor/FN7EDeNYnGIWEc+sGpsXNDx5Rt2QvsTSJIqL1y0zFMTx6jP9uxuFVJsM2YiIW3ZZstYkzzJ2tANlw9gixaKJOfXJsTbySHIOaave3TJX5MZtBV4vEx9ok8rsA5QMKCs0eKsgyHEsSZ4aZ6vqoZO47TuyElLbLReug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB292992.namprd12.prod.outlook.com (2603:10b6:208:5a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:14:42 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 05:14:42 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com
Cc: gourry@gourry.net,
	terry.bowman@amd.com,
	alucerop@amd.com,
	icheng@nvidia.com,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v9 4/4] cxl/memdev: Don't overwrite the error from an earlier partition poison query
Date: Tue, 20 Oct 2026 13:14:03 +0800
Message-ID: <20261020051403.14186-5-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020051403.14186-1-icheng@nvidia.com>
References: <20261020051403.14186-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB292992:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d7bff7-6adc-4e04-a47e-08df2e690bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iMggA0zenS7JAvoLXjyRQdeNrdlTSz6IWtDOv7FYzKY86FJotGbih7uvE5Ywge3/sWZE/pJhldzAyjIi512KhQaO+kfPz7U39xC+NshM3rwpNitTZvzrURSzgQzl8a0/lsdpED56LUZ5wCvr/9+AH2iU4seeUN2Lo3s2Ng5gkn4r/aoaPtCDoXnPOzx0Sf+lDg5na7A/N8Jmcq9HwAiff9DR8saHbIhtSg9gab0JgmJ2fNc5NBrBwLG+5ZLrMDcxInPAa5DK1ItQdCyiNG+YOvRuaPwBabFrULekIghWpYh8OECi68qCLUfzlb806zEMpXkgbTF8bez8UvHmxAmjbgjnMMB4uvOis5WbWXWuvO396Y1zT64cwZ9CJX8vYiKKQGGAos7savcItZWm620OFt5KLQG1c6+vI6EF7DM8ZvlSfn4Je3P7WlacnHtRgUSH5NQlqNvN4/gbV0Rc67PXE6AJVAjGAyKv6ofSo97FZTqieEYV7gdUaZri9DRu0NrlpyCwNFcZcA1NVxz6vxY2mCrh96h1YoGrWHb8+wOrOK1QnBEE4Xwza7Jc3qA//qcHeR+E5HSqeJYikZji3AROGUHNxyqirMgsgYdva0BudxfBcWUwqxXxSN0VrmGqgL6dY3ngS2jQwpt4eovVVkoCilKYI6RQXi4HtiLTUMdfZ5U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l0obqb3inUquT/lqmxCez0L7WwjqhyFbIfphb6IMnqSfcJ83puZgdBDkoapj?=
 =?us-ascii?Q?XYjZU/jx+5EJLxuuB+R4Rp4p4OWqN7cxoPSS8fmo8Loende8vNBNe0Fzl1ej?=
 =?us-ascii?Q?6aqq+Uw7kViyTATwAez9p8kIqSFJaTUMJoVC8Wd8YOC7Emi1crhyugbC30xy?=
 =?us-ascii?Q?Jq3ALQpIiSJCp/z3BobSlGOq02euxV2up0X9HFDPSIBJ8a6ITB5kg7GJ9bAR?=
 =?us-ascii?Q?ngYVwt/GNCt+Y4vHgAeZ3zqoz0h7Sjx05ZFboqp9JSy8hc7cuo8m9mbXuSZY?=
 =?us-ascii?Q?gN0JOQGBC9XEYWIeB0DbHgmsXxJmC0xoIO2p8y9W9FgnsAUS8ThrlYXmphcg?=
 =?us-ascii?Q?/BfjiLkBymC58OqBthjQ23jxEBLXtkfzPrzlYKAvF8TMR0c9Ao/rl+HOA6pN?=
 =?us-ascii?Q?S5dNDyJlwX1vpEkJzdhuMq560NsJthZ0qIOJCfaDOf/vxLiXEZ4iFEM+t5Lm?=
 =?us-ascii?Q?pPQg6qU4Ytc/RnpyCbDsqKzCOnonUE4N37ND1AQOAYaFcegioEdk2YrjXTKk?=
 =?us-ascii?Q?CKrqQ1/ztPsRN8+UsY3quWwsUse89FINtt3VG1MjGGH6UORb1J4WKoPoz5q0?=
 =?us-ascii?Q?qUn1fLwXh5KFyvSYxq1TvK8GgKm7ZRJCFR24kgWvbUwm3G8nGRDEYYmfusv5?=
 =?us-ascii?Q?Jk8HQRPTP+ZY2yUYBr0n8omYX2DU4jprDOo/E0HUWzf0dL12PrQkmoKAYKBa?=
 =?us-ascii?Q?/iByvOaqJwTW19Nywdv/pz9FVJ5w25N4qX/5XMSbApo0Okd3CDDMlQJrajwn?=
 =?us-ascii?Q?oeAIfN1VPMKj6F7Q/M2kvoqLCsRzrWukKU4pPhz2GULnWscm97+hbu5yATe+?=
 =?us-ascii?Q?asWu/tGdr+jV7+H+wqvv8p74M8LZKeXS8sXHxFmMJXbpSRimjWvtJ47btAzn?=
 =?us-ascii?Q?B9A7y8OY2Thr+DahSkaz8+1SbgOjM+md/lx5redno3Vlz5ppoI5MfUmx82U/?=
 =?us-ascii?Q?+F1DkxUMu8XUTcuoTzSnO0z0+Xu6HBJatWK1DjTGoTCiBoW6G94l4ijun65S?=
 =?us-ascii?Q?PC8iDmnH8Rct1RvLdQIhFXIcMkYR/of24M0rMNd3CIdchvA+/c/IdNK4/A/q?=
 =?us-ascii?Q?jK+hLZdOH92kv35FebqefXiWR6DTdmDchWt6BwkDQUsdSqKoHMJo3BvkiEbY?=
 =?us-ascii?Q?Q3UW5fWsWtaJ7mu18cJU8YNLbhjcZzhNQ6VmFkA5zCaUjeVdTpBe8CWfqaRr?=
 =?us-ascii?Q?AGdnsj7FzYXMG5Hag18LluUSOS7N1DG+J78EUbxi4rLER+t4wopu5qzRMjGx?=
 =?us-ascii?Q?nvm7kVeGJTXwJLWOcLRZwkvhGdoj9iRh69y6IEENf5CDghuKpv33d7BjIxBa?=
 =?us-ascii?Q?sbv1Gp4P3RuOSez54JVT8DiVfbLbdPWsSyacZbjdOKXkvaBfLVfveg3o0LBL?=
 =?us-ascii?Q?r1Wqash9n01dX/t5f66P8+WkvI9JXDLyJyW0iQqG+NRvJSGbIucnhLTBnaMi?=
 =?us-ascii?Q?UJXE6qrZ++JKD/xtR6pnuirRKGgkNXOUhLx3utgPQi+h8MTyQQvAJRoExVF1?=
 =?us-ascii?Q?7zxBludjKLVzqEQg15EztVJ4LtV9CA5zeVMPt2pewF9/k/LnwnZHa+w/fqYZ?=
 =?us-ascii?Q?GYqUsc6UeX1hPUOdKwnQDZrd0ozXv8uHrrekcCBwk7ZwxV+fM6aPYLPalPxy?=
 =?us-ascii?Q?uMnHCOOtvJqylsZlB8oyZ/ORDB4QK49iJA9BoIJi9mmXmmN7qh6/uNGZ7K5L?=
 =?us-ascii?Q?+BwvfSDUkjmwe05whm9jP8Oz4yZ7egZYVS4QX6G404I9cAVO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d7bff7-6adc-4e04-a47e-08df2e690bec
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:14:41.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mSc/ihPUKI8eRjkDubmfKzy6bPp9+UVBuVZnhKhcmu3k4JC+uMfvq6cg42xcUkjTNIm+9CbEr3PRQN1UgiuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB292992

cxl_get_poison_by_memdev() queries Get Poison List per partition but
never checks the result inside the loop, so a later partition's success
overwrites an earlier partition's failure and the whole scan reports
success while that partition's poison went unlisted. Before the loop
conversion the PMEM query returned early on error. Stop the loop on any
error not already tolerated as a RAM -EFAULT.

Introduce poison_efault_forgiven() in core.h and use it in the memdev
and region poison paths to keep the RAM -EFAULT exception in one place.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v8 -> v9:
- Rebase onto v7.3
- Introduce poison_efault_forgiven() in core.h as suggested by Davidlohr
  Bueso.
---
 drivers/cxl/core/core.h   | 9 +++++++++
 drivers/cxl/core/memdev.c | 8 +++-----
 drivers/cxl/core/region.c | 6 +++---
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9..0a8180d7ff2a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -153,6 +153,15 @@ enum poison_cmd_enabled_bits;
 bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
 			       enum poison_cmd_enabled_bits cmd);
 
+/*
+ * Volatile poison-list support is optional. A device may return Invalid
+ * Physical Address for a RAM poison query, which maps to -EFAULT.
+ */
+static inline bool poison_efault_forgiven(int rc, enum cxl_partition_mode mode)
+{
+	return rc == -EFAULT && mode == CXL_PARTMODE_RAM;
+}
+
 long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..9652e7d023be 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -225,12 +225,10 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 		offset = res->start;
 		length = resource_size(res);
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		/*
-		 * Invalid Physical Address is not an error for
-		 * volatile addresses. Device support is optional.
-		 */
-		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
+		if (poison_efault_forgiven(rc, cxlds->part[i].mode))
 			rc = 0;
+		if (rc)
+			break;
 	}
 	return rc;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 18114d25662b..ad9e5b5f5636 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2927,7 +2927,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		if (!length)
 			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM) {
+		if (poison_efault_forgiven(rc, cxlds->part[i].mode)) {
 			rc = 0;
 			continue;
 		}
@@ -2963,7 +2963,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 		offset = cxled->dpa_res->start - cxled->skip;
 		length = cxled->skip;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
+		if (poison_efault_forgiven(rc, mode))
 			rc = 0;
 		if (rc)
 			return rc;
@@ -2972,7 +2972,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	offset = cxled->dpa_res->start;
 	length = cxled->dpa_res->end - offset + 1;
 	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
+	if (poison_efault_forgiven(rc, mode))
 		rc = 0;
 	if (rc)
 		return rc;
-- 
2.43.0

