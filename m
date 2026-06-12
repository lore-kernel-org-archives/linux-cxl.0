Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D41E531
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231652; cv=fail; b=RpcSgrvxBvrkTjREF9bZmm2Tl8+uQQCU9wQwGpPQJPWfzGvWATN/ds56jB7rgJA+TQzD/arvc/1A/vdcrK1xXfNMbNCqg87kkejAsvxDwSbq6odFLUhMZP/mra9gXpKtTAf81hANUFMF1UawjewL/sGxMy5XkrRfU+ie16M8CAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231652; c=relaxed/simple;
	bh=tJS4o2vecgrZG41mdy7efIfLth4hy3/azP8Y/DTmH3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uq5IPi/cp1eJsAGZFtLc8YmkuTAABucU6cCiDzCLkLXV7qxZq9ClVDcS7w9dNIbOH6haFXdAGhFEce3f7ynOT+QlTD7OqK0wL77MLX9lyNdKiC86J60xoNJl8fTXYykNq7RSpAJgCprhFalaoaGT8CoTFdlxla4wj+nvfjqGSqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=noa6T4JB; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="noa6T4JB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDjP5RnJD6AmsxC6XDc4y3aGQrH6CzW3l1KSotcxPs2aXeO6WOpzgtrMzvlhPvCsfYeWBl71EajNaIIAUYL9lOoPaelTe/BDT0DOmfokb2XRV39RU7rgQqkn/gNqcisyQr0pmF9p+pNiKPylSSnQr/sl9s/7njW5KqL03rsby+GLl0V0Sr7gTw7Og6QyE7JUA4QBUOPPiebzg39eegqVwGLBxhiPGH01wg0MO/aDzkqKN7CxP+1pM+JNx+LyzrFEixZUa+Xl5lYoCmpIYl58n77YmpEIGMa9iEClFNhPiZ8iYg5nQShM4sRRk+hZDWm9BQZZ8O0NGKwbvXsE9uGrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci1NdN7HPyn2MeSUua2mz88swg3yZ037Dc3Ur0VxdWQ=;
 b=OMazXxOSli6Mhyy8gDj4tn+7d7Xfg0/Paeb0K9d9dntiPv8GnoldgRCVLxUUQW2s/uIGwRVk1rKJhihZDRA/Tz8uleQEl1AOKktyI2ehJS9PA07n2kaKDtHptJEXlymKseVRWkxF4QkUQIpJC7bmOFukb7nY+57IuypI1gF3MRvrtmfYiMP3reIDVBSko4/WdK/iF9YuLlEA1GmdkArjtYKNZaA9K2MgvZuifTkrWMzrKc6kmik5LTtpghTqBs81OjJZl7FmO2hb8QLeEmwJi3osj54knw8uqV3HilxFYsBAIzPtKSVE3hxDwzMBWZaRQxTQdAEqrI5+bloyrCh5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci1NdN7HPyn2MeSUua2mz88swg3yZ037Dc3Ur0VxdWQ=;
 b=noa6T4JBPurUtzXvILB12uR8oIU52KgVx/Ln2lzqopALK/ladCROiYMgBC9gz/FVY1i43q8LFtfLXggfNVBnzv7EF8FTIs+r1Ww+ld+/XmHhYJ7Xho+01q9LbAXmUHkSZA/CmEOPi2hmmZADGPYQxKcaiSWfRnx0FhEO2s9eL4m3rDdXXxZvw2CGIqZMumS7zMaoZ+LvFFWk0sedkilA/K9EcRP6GPk6QRiKou37i1tdq06YKD6oFaNDHQVO3RQjJ2Hrtm9WqGdlpQPcBV04mhlXuhB7U+T92ApQ917jZz969LX18gLCS445jCxASkHfmcVYX+nG97rsLnHRdqhkTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 02:34:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 02:34:07 +0000
Date: Fri, 12 Jun 2026 10:33:59 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, djbw@kernel.org, dave@stgolabs.net, 
	jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH v5 1/6] cxl/test: Add test for module parameters
Message-ID: <aittuDSmdIzR7X5U@MWDK4CY14F>
References: <20260611234409.256765-1-dave.jiang@intel.com>
 <20260611234409.256765-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611234409.256765-2-dave.jiang@intel.com>
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e5e443-ad14-47d0-2594-08dec82b1291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|4143699003|56012099006|6133799003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R/p1MTQZfiFbEtCpAGfOl+vdArvT91yWHW4JDv74oQbvXxXK1imZNT4sl8Iyvy4B0P4R5TRcV9H4G6dSoyuglLHaRRBRbudOtum8gndIfj3NL04fZpFKqazidJF8VTX3HuS2kArLpGr1Ot3pzMi05WqfWjrs/c9LBCJ4LGIeJbx17lwFj0u9c9cWyFn1JJKLjZYxj6zYWz3j7EIq2n1Q2P9yAdD/K3pAkWzYrRXtDihqP+mIcL4joM0XHMmfbQOcSphi8tW8sI00OASPzxHBJp9xz+kNJbnuMNHQ7dQQBfui/pmLCEpJVf4K1ByWAkDbESCiFJUL/HKtQdsn7qWnBeKjo9+GfpbvHV1opDKhbDGo2bmV8EgBeQGp21wGZ5IZDQsRzeqxcPg68XIJOEuKmrte9JQygmA2c3OI9ndXj9jOXS+F2IYqPPvOKl9dkwRDrFJDGFz03V9t/4XQcLsv/C4AitTtn74G3p5SnyzTTod4uSTFlCoinskS1kmNGfGzWKf4pxB9EcNSBjeL9JvMZS/0cvolW9r0LDocMnFPYtYIzTHmb2Y5e/6OhI+MQPhw0jwEFydW0O/Slpfe6lP5xg95sf6SGZVZBK0NVoAOzegl8YV49BzjIf1DqprZ9215DwOX47/YoRRxmVM4zbUZBZ+99mowp1sfQjj48bxi8tiu+8OgLMZTczpUaX7tQjVe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(56012099006)(6133799003)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q1oTqTotjOyJXy0vxpwW9OfhKd894gsE/49eS4nVqc2ELfsCgoxMLiHuO5li?=
 =?us-ascii?Q?wy5h6Wr7oN17VfplNoj/g1+uVgl2f1arMcypxdozQe6mEaePgqIeDSjXT1QY?=
 =?us-ascii?Q?hKqEgC/zVhqP92BJ4OoOE94XnBf+z+uQ2Gp0dGtr9cu2PguR27C9t9XjypgZ?=
 =?us-ascii?Q?5+5rJQo/6Lb1ImNfw5xpNMjzMsFh5c5PAr7dRc7/s5WFn6v6HieB9Gt19hFp?=
 =?us-ascii?Q?1Q2Z5eYkvJZO/96LZ+5JHyAyC63GXzPxqiebxZJShQTDVu+8fKtHFICPTJMU?=
 =?us-ascii?Q?B6yKQGAgpMcyP9BF7FiL2y+8T4XCYko3ckB4Cb9ZAP4gnrmM3V/KyZmXPbPc?=
 =?us-ascii?Q?5T8zvb3nFjpxgBZECywZawTB1v783jexicerLpF7bWX2YyvBiAhU/CDWZQCW?=
 =?us-ascii?Q?dTJLVnkgegmc33kAzR3mDqybdx9dIaxe7PNLTZszBT7lSW4Z9rnpJehPgJY7?=
 =?us-ascii?Q?gaDuBRp08D+J0aWgLLpsnnhQP92tunYQ4pAFws9WaWdZyIUhEfwKOObhMgWO?=
 =?us-ascii?Q?bHC5kpuhXvAH6S6jnY/giN3NJBN9pECxTVeAMiyVen4Nhl6Rr8At0JRgRLJk?=
 =?us-ascii?Q?XzBvg9rkXF8Zs9P7T7aBvaFDm2EcjJ7c/XgMWN2OM67/RA27VmWB6LejggFR?=
 =?us-ascii?Q?bQ2wRRqxP1un/DZIxX0pgy1dkFSLUw9zqlTrBFtI4yzY2aP/GsJsIFrNYyMy?=
 =?us-ascii?Q?OnHPPBnJnHsrK8vcuhtQK1/r5XP5YN5+wXACEyKY8+4NQmGneanraKEfM6kV?=
 =?us-ascii?Q?/XNSR+cOnAMOF38ll0KIuh4mzsrYtJPg2gvLGOIZkH90jWgJqT7hlZZIqM5G?=
 =?us-ascii?Q?X4AptpMIxHMYwYOIR3Msxq74PLHwXbxFYunfKOg7XXmS6tycaOuaLD9To7OQ?=
 =?us-ascii?Q?Ci4Yht798qtyIo2WtGtC3SqPVmol5ssX2FEchptyZEXQ60GihMV/1O2ZmWjW?=
 =?us-ascii?Q?uMpr6c3HZRMRmI0LvrA2TS/62zMyMAUxs+zKsoQkdhL7ONQjE10G7PFJTEO/?=
 =?us-ascii?Q?6JR2R56Js+0Z09o1ttced5CqowZFbZVZmfFBEWu+oT0hHnXRGrpOL8IYxeqb?=
 =?us-ascii?Q?1gC7Glkw+9u4fjIGfBJuEfOcU0PZiGXNF4IXqpXb8QUK7qzznCmlWLng/D7O?=
 =?us-ascii?Q?bt2dWJTkRbYoVgSef9B7V5LPMOCgQuPSCYS3Ky7pDWk3g0wZnoXtDtU7ALWc?=
 =?us-ascii?Q?pGrwhIOMjCCEhrZaIeIZNgjA84F0rVFrIKvsb/Tz2nTcZGpymwlE6jzgGJzn?=
 =?us-ascii?Q?+sTuLWjhyZz7mX3VScwho6RgF2qYGtqWojtqy1LFn8kSNX98+haTBdCG8Rww?=
 =?us-ascii?Q?sn0tt+KBVTgJQwXtAB0lzEu3jtlR43PiNW23AqKXquTgNFCSJqPv64OI3EoI?=
 =?us-ascii?Q?D6DhpNcMKIrKu7oPXlN/fFxWAYDAJGyNcWJEwTA806SzpuM5ELFAEWpF5p/v?=
 =?us-ascii?Q?dN1ANjJUTSQC8BC1XUTaeM1KvP+CuXnQWjrWn3SOkSvv7lApF9Zh69D4CYEs?=
 =?us-ascii?Q?Hok7oHXyEGTdwjALGQsf8YnX0DHRYDAaIcVvmyboxTIc2jf+EW8x+Cj0qkfN?=
 =?us-ascii?Q?yp8gWcGSjpiHG253GaXv3JCHGhE9p+anmUbv5qmwAl/G2xK7/rXo7dgbR+bj?=
 =?us-ascii?Q?UdhGuUwcAxV6qseO/HIrVkczKZD+Zv94gLZwOxPlll2noJBYllFHkBY1iHIK?=
 =?us-ascii?Q?TZLBdft0j/R4E8HoPO67EEd44dUlz0cyWkyanFJqru6NKA3ZZdIUAY2wROp5?=
 =?us-ascii?Q?/FbBb8jLeg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e5e443-ad14-47d0-2594-08dec82b1291
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 02:34:06.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz9YL8GPAi/gD/YBitAvG+g8Pmoo7CoTt0Rsz8rJ7LKbdwBMWiKKnBBJ7Az5BmzuX6TDzSPrBKpsFKIaGeadpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

On Thu, Jun 11, 2026 at 04:44:04PM +0800, Dave Jiang wrote:
> Add a test for module paraters during module init to make sure that
> only one is activated.

"paraters" -> "parameters".

> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Add test for hmem_test module parameters. (sashiko)
> ---
>  tools/testing/cxl/test/cxl.c       | 20 ++++++++++++++++++++
>  tools/testing/cxl/test/hmem_test.c |  3 ++-
>  tools/testing/cxl/test/mock.h      |  2 ++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 296516eecfd6..1c8ac8bdd8f7 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1814,11 +1814,31 @@ static struct attribute *cxl_acpi_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(cxl_acpi);
>  
> +static bool __init have_multiple_modparms(void)
> +{
> +	int count = 0;
> +
> +	if (interleave_arithmetic)
> +		count++;

Should we make it a boolean ?
It should only work with 0 or 1 right ?

--Richard

> +	if (extended_linear_cache)
> +		count++;
> +	if (fail_autoassemble)
> +		count++;
> +	if (hmem_test)
> +		count++;
> +
> +	return count > 1;
> +}
> +
>  static __init int cxl_test_init(void)
>  {
>  	int rc, i;
>  	struct range mappable;
>  
> +	/* Enforce a single module param active at a time */
> +	if (have_multiple_modparms())
> +		return -EINVAL;
> +
>  	cxl_acpi_test();
>  	cxl_core_test();
>  	cxl_mem_test();
> diff --git a/tools/testing/cxl/test/hmem_test.c b/tools/testing/cxl/test/hmem_test.c
> index 3a1a089e1721..0fa00f7e16db 100644
> --- a/tools/testing/cxl/test/hmem_test.c
> +++ b/tools/testing/cxl/test/hmem_test.c
> @@ -3,8 +3,9 @@
>  #include <linux/moduleparam.h>
>  #include <linux/workqueue.h>
>  #include "../../../drivers/dax/bus.h"
> +#include "mock.h"
>  
> -static bool hmem_test;
> +bool hmem_test;
>  
>  static void hmem_test_work(struct work_struct *work)
>  {
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index 4f57dc80ae7d..846d7c5d6eaa 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -5,6 +5,8 @@
>  #include <linux/dax.h>
>  #include <cxl.h>
>  
> +extern bool hmem_test;
> +
>  struct cxl_mock_ops {
>  	struct list_head list;
>  	bool (*is_mock_adev)(struct acpi_device *dev);
> -- 
> 2.54.0
> 
> 
