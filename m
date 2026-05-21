Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97E403EB9
	for <linux-cxl@vger.kernel.org>; Thu, 21 May 2026 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374046; cv=fail; b=i3hc79JpcmYqj6ZFyJx4YOOEyU7Y39YE4UAKq9Fy5K9x5L+CcePWF0+N8M2kd1m2rj64gNnRL7Jg6/aVdB3BktB6gNgrg0jHmDfAfufO/sSnZGqp4s0OQp79Kp1FoHz35j/CRNvmgZNPK9vSS6CwDRC0kIul3kiicxyyoXtLT6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374046; c=relaxed/simple;
	bh=fooz+9QMVrI3HsRrUtOs+YlTX9UcQxB/La83IWNms+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e23SrXyaJpe1506XlhyKnCze1ZSO1x8bRRP8QKQ7MJXzvTc9k88Lp+AaGEdlC1jxVpd6082i3NpRY8UYsqxi/rjhdQQUPkIIGYBRvRi9XeRhLhexU4RUgsv5kbzm6G8HtS+tJO16NMYywnsNTDMirdPfbBCJG5IdxxPGfBNvZNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xrKhGR0T; arc=fail smtp.client-ip=52.101.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xrKhGR0T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et35ATtqoj0ezt7ud3SPWLeycXlFxOWfhOk1I11D0laznd1WxzE9mAlYZBYsSuYa8GarZuDF4q/2ftOQatBBwjw1xd2RWb25dipkDYpW6jL1YgE2sAgc/AkQs9tqxVtag5C8tWnUiuXvA+46ZGIkuAJ2cAz4s7M/d8s3MjHNfSK/bYH8EDbNz9jmSPkUa1iHYRN97ukZpY2zMsqE/XoEvERTZhWUG+f/18yJLnYOAZ2joNnKMyLGGZrAR0PwupcxI1knH7IDScWWgJ1lsY2E6+SvlTTiC3pPtHBQpVu6kO3bmbFu7JNJ+qmjKq//WGFB/u2pRoFfUxxjA7d4Gpar4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgfm2c9rx8QvhZQM1HzuTvwwkipecwOxr0f0vgs/9O8=;
 b=nldgJ1WNgWsi0O0OND9bpTd2vzdaGWfsukfVPRazc4yKcmu4m/dFZFBY+BpHBREgR/aA9gxvS/cdsz1jibE2t5Ek3vX/gwRMsg8GxdbKvtJ+SFWDR9NXP9aN6iynJl76UKChhbwle82sDpcrnpR3IehAQajILaEZHRZQztCawHOElZ4mtAR294x5+3la/Q64Bp1GVsaEeEQAI/yxp1B+Ibro0Yr93TUjspkvTuVIR/ENzNV4JhIJBVg3fkte2Sl7Jmv16VCPdd1hzl3kPoiSNQe9BukPOgVpMEEoq//BlbLIsKaVpIumgWWWFTQuqSUCreEpFxyevza/PLxr2FoZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgfm2c9rx8QvhZQM1HzuTvwwkipecwOxr0f0vgs/9O8=;
 b=xrKhGR0TbotXTWy8t4DjXwnsNNQZsJ53FebUqfbFFSYh1GymgjaYIU+tn/G0q0S30diVdWb/ITTcP7kuHBjrf0699r/bS3YcguvHDtVdZ/09Y65pfPAKcF20pZ6Qdqn2rcf2AcXh0FarNYtgIMoXfjw248yvlA/g4BtkWDUQEfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA4PR12MB9809.namprd12.prod.outlook.com (2603:10b6:208:54f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:34:01 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.21.0025.023; Thu, 21 May 2026
 14:34:01 +0000
Message-ID: <8d50665a-208c-43bd-a539-a826c17dcc0f@amd.com>
Date: Thu, 21 May 2026 15:33:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] cxl/memdev: Introduce cxl_class_memdev_type
Content-Language: en-US
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, alejandro.lucero-palau@amd.com, jic23@kernel.org
References: <20260519210158.1499795-1-djbw@kernel.org>
 <20260519210158.1499795-5-djbw@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260519210158.1499795-5-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA4PR12MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: 73016ffd-4b62-450f-c1a1-08deb7460031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|18002099003|56012099003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9lHHjOk7WLYhptEPena6yiMAUlKRzgbgl7PnFu2QjvsBcydRdLZQFptopY7F2b7q93RGJ7XdNeDAXUjj3gQLQTqoZQJqpEh4tBnZQsOG6EUn3Q9RVCOCNsIPfGYPKlFs3fU4ChhzBiuEFBTb9JuaixPmh8gzDL9MR5rwW1kjEBMIG283t9kO9iBuTx/oa/rqy3jHuqBB9F3wNk+zzneBSelph61EbYTeYTNmGhpg6o+9ChR8sDlYfsXIgSm1Vvu3Vv3wq7P6WOxugARiNYdBNx1Z2QMAiG8V1VgnLBoqjISFayp84dX0Dxo34+aHpdDWj1h6G80dO+erdfK0mO5AhhIwp2Hi+LwD0/bb6z+7hOvNp6nCYIIfuAUDL1D8irm8XeaHDwHBNoKLd5CIiorX236Jfy7dBW9y4MUDLpYGyBxN8RzrqOnSm29ivkCaTx+ZaegZaZpYQ+8c+i/cBhDhb+gSZdInV2X9dcddD6+KnJoDLALi9raIMmwcBdHdkk7LmMVvhUWoOLmgz2vhamm4Nn/s7r8zCAvYgf5ukckBxpAkczTXQ/h4CPdOGJNGoaJGfOh1l7DqHXzEArA0VHavdrtd+WPjBzRyLbyAOi/NokfNEeDsgS7UzX3EGKMJGSHj49NQd8lB89aX+dTtX42hCbqibKSY//EkYBMcFtm4B3vi3fvJ6JTnao6GKlf1JbQD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(18002099003)(56012099003)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjB1bTJMbWIyb3U5WGs5aFBNbGhxUlUwTnE4SWNMcDkrcDZxYTZZUWdwcnBS?=
 =?utf-8?B?bE9IdFZVS2dhZWVEVnJzTjJNYzM2NnJZZm1UMXhFTjNiM2lscmh0d3llUjZT?=
 =?utf-8?B?emRhOU9oUC8xWXNYT3JkN0xmcVQ5d2M4bjkzT1F6YTNvR1BnM0VUbUFVcmsr?=
 =?utf-8?B?ZGhNRS9JNEdkMU0yRU5USW9LWDMzWitLREJ1MjZyRWpwZWFGRWlTM1ZoSDRt?=
 =?utf-8?B?Z2xYMTRvV3VPSlZBc2Q5L2JmMC82bE5wYWczb3lSbUlmYUx0d1FqTGFXQzhI?=
 =?utf-8?B?TTJ6ZURERm1NQnpIRSt5RkJCL3ppVkV6bUNDekZRSUpnRTFTYkhOU2tIRzhY?=
 =?utf-8?B?dDFtRERWZ2s2em5wZlcvTTk5ekt3K09lbEs5dVVzdFI0SUNzZjR0dXNmM1Jr?=
 =?utf-8?B?MnFyNkpDRVBWVWFwSDNjcWYrM2JjTmN0clBNRjFPWjJ3WVVTejMvTXhOOG5a?=
 =?utf-8?B?ekJ4RHRYNEtvQzhIK2NwRWgxaHllSlpVUTlHcVhSTUp0VFBzQnp6T0F0NVA3?=
 =?utf-8?B?cG1kU2ZuaCtsaW9RUk5SaHlKSFlOcUU5UWhSYjdqNVhVUGFDZ0lFTWpvT1N5?=
 =?utf-8?B?RVRzeVFFNVRBbTl3YVlxZCtkQkJSZ1l1Y3BVc1NhT0EzanZ2T0pETERXbjJH?=
 =?utf-8?B?T1dsWUxLbk5VYXJEVk5aMlhUV2RUR0FJVXd0SlJCanVZc2Y1Y3VuRENRMWln?=
 =?utf-8?B?eXkvR3luL0JDS2RsbmdFOUZ6UEJWZGY1NmVoT2lJSStoVGJ1clNSL25Nc01p?=
 =?utf-8?B?OVVITXRNQjNnWUxNSHkzeCswSTUyQTJ0MHdVcWg4eThDakVrL1p4Sk44dzE3?=
 =?utf-8?B?WWFXZWo1d2FzampNWE9GZDR1VU8zS1g5eGhkenV4RFFzMjc5WjcxV3NVM2tQ?=
 =?utf-8?B?YnFVUjZHNS9paEFvZUk5QkE1VUFHTlErUzFqQVRHWk1mc3dXK1NYdlRNdHps?=
 =?utf-8?B?L1JwNEEzYVdibkJZL1k4LzVKSVN3RDhzLzVlV2RhZFlMS0JvSU9BekpCcFJF?=
 =?utf-8?B?ZUkrYkZnZEt0blVkeU9IZlJlckJyWFRLVXpYaVFsc1JRY2xVSGdEaU9QN1ZZ?=
 =?utf-8?B?N1JFbS9rUVo1dlR0MEFGWHI3RlJsUFFiVVlZM1dZQ2dLa0xkajBHTkNsdzRE?=
 =?utf-8?B?M2dvdlpCVEZSUzdDUUZOdy8vQ2owOUJmU0FaUk5tUW5vcE05Q3BKM2RNdTRs?=
 =?utf-8?B?U0d3T3ZnR3dsYlJ6VlhFck1RUTlJcnhGdVF0SmxjSGR1Z1JMZ0V5WWZyOEFw?=
 =?utf-8?B?aWdjaGRLbWdFa25jOGpucHFjYXVTOGlDUnNZN2x2SVp4UVcyNjlpRFdVNnMy?=
 =?utf-8?B?U2VpL1MycHdPVnRjc0xvUzkwT2lyWUFpTWJOTHZVM0RkY0VQWmJXTDZnNWFt?=
 =?utf-8?B?TEJJN2lCSW5UTGhvUG9tTWRHcXIxSnZuZGlhQ2NmL0NpV20wdURWRmxpZlZw?=
 =?utf-8?B?THVxczR3endUdnNRMzJoZE1SMmdZM2ZPcTFoVG1sZVRDNVhqUjJjdHk0QnNB?=
 =?utf-8?B?bDFUMDZJYW1Pc3hyQzMvNCtFMGdjV0FCZGZsblBXQmtic2N6MFk1OGdHT1pN?=
 =?utf-8?B?YWtJQmh3VjBUTmZreVFqaW9uRlRTVi85b0tDcll4VkwrcGo1dHluS3RkOTZ3?=
 =?utf-8?B?KzlhUlRuYXp5K1hTdktCUkNUeXhJN0JuVGxEMHpMQUlnb2wzYlg0SkY1QUtT?=
 =?utf-8?B?a3FybGxUSlJiTUlteWdrcU1xZ2Q0SWJoQzZWYzR0RE1vVXFaSE5xYXRYdHl0?=
 =?utf-8?B?N0JvSkZzbzlSRk4wYlVrNE0wd2NrR0lMU2Z1M0t5Y01PRm1DSkMzdGF5N0Vo?=
 =?utf-8?B?eUhPWWk4RmdOajlDcHFicWFyU3JRWkZIalRuWDhHOVQrM2p4K2plYUt1Lzll?=
 =?utf-8?B?TlpYUHFTM2U3cFd4UDQyUkxUdjJRZ3grUFBjV1Yyem9vS2hqV3QrK0ttQ0xa?=
 =?utf-8?B?QmVJWmN5OXRFZnRZQ1E2WmJTNFhrdXRhOFFPVWNtQzZVbUM4U0JkQ3IybXRK?=
 =?utf-8?B?dzdxaGxSUHRWczdzc1V3dG91VVZnSDJaRGw0eDVlYzNOU3dST0l5bzhKTmdh?=
 =?utf-8?B?UVBHanlwRWpQOTU5Mmk3TW9wOWlLOFJ6UlFndmsxaU9CaG1NQ2MvRzhUUDZN?=
 =?utf-8?B?U2hoeGl6UzE0V1A5QWVPR3MwN0JzaEpRUFR6UEtyaXUrUlRPSjZCSzdqNU9u?=
 =?utf-8?B?VUc0emdoTzFzYTZoWk1BbUdTMlFVc1lSNmYwZWtFRGsrK1BTYWtFdEhQMXN3?=
 =?utf-8?B?UkxXSDYrdloxelFnUkdaTEdrK2tCWVRuNWZnNmJNNENwVzY5cUdjWmxKdXB0?=
 =?utf-8?B?OWo3MHp3ZjJCQnFhS2J3clRFZmpwNUdWWWN1cVlISGljak1LZUxZUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73016ffd-4b62-450f-c1a1-08deb7460031
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:34:01.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SZsnvEBIjUDmDYCoHMTkSvmGogYHc0oPSKRHnAQLhiYr3GUYss5x85s6qQo/pQjL0G/u5+qsYc5H9I1sHChfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9809


On 5/19/26 22:01, Dan Williams wrote:
> In preparation for memdev's without mailbox related infrastructure,
> introduce cxl_class_memdev_type as a superset of a cxl_memdev_type.
> Effectively the only difference is that cxl_class_memdev_type exports
> common sysfs attributes where cxl_memdev_type has none.
>
> Related to this is all the cxl_mem_probe() paths that assume the presence
> of a class device mailbox are updated to skip that requirement.
>
> Co-developed-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>


Tested-by: ALejandro Lucero <alucerop@amd.com>

> ---
>   drivers/cxl/core/memdev.c | 16 +++++++++++---
>   drivers/cxl/mem.c         | 45 +++++++++++++++++++++++++++++----------
>   2 files changed, 47 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 91c99eeea92c..33a3d2e7b13a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -574,16 +574,23 @@ void cxl_memdev_update_perf(struct cxl_memdev *cxlmd)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_perf, "CXL");
>   
> -static const struct device_type cxl_memdev_type = {
> +static const struct device_type cxl_class_memdev_type = {
>   	.name = "cxl_memdev",
>   	.release = cxl_memdev_release,
>   	.devnode = cxl_memdev_devnode,
>   	.groups = cxl_memdev_attribute_groups,
>   };
>   
> +static const struct device_type cxl_memdev_type = {
> +	.name = "cxl_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};
> +
>   bool is_cxl_memdev(const struct device *dev)
>   {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_class_memdev_type ||
> +		dev->type == &cxl_memdev_type);
>   }
>   EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>   
> @@ -712,7 +719,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>   	dev->parent = get_device(cxlds->dev);
>   	dev->bus = &cxl_bus_type;
>   	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_memdev_type;
> +	else
> +		dev->type = &cxl_class_memdev_type;
>   	device_set_pm_not_required(dev);
>   	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>   
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fcffe24dcb42..ff858318091f 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -65,6 +65,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>   			 cxl_debugfs_poison_clear, "%llx\n");
>   
> +static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
> +				     struct cxl_memdev *cxlmd,
> +				     struct dentry *dentry)
> +{
> +	/*
> +	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return;
> +
> +	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +				    &cxl_poison_inject_fops);
> +
> +	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +				    &cxl_poison_clear_fops);
> +}
> +
>   static int cxl_mem_probe(struct device *dev)
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -92,12 +112,7 @@ static int cxl_mem_probe(struct device *dev)
>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>   
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	cxl_memdev_poison_enable(mds, cxlmd, dentry);
>   
>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>   	if (rc)
> @@ -206,16 +221,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
>   }
>   static DEVICE_ATTR_WO(trigger_poison_list);
>   
> -static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
> +static bool cxl_poison_attr_visible(struct kobject *kobj, struct attribute *a)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   
> -	if (a == &dev_attr_trigger_poison_list.attr)
> -		if (!test_bit(CXL_POISON_ENABLED_LIST,
> -			      mds->poison.enabled_cmds))
> -			return 0;
> +	if (!mds ||
> +	    !test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
> +		return false;
> +
> +	return true;
> +}
> +
> +static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	if (a == &dev_attr_trigger_poison_list.attr &&
> +	    !cxl_poison_attr_visible(kobj, a))
> +		return 0;
>   
>   	return a->mode;
>   }
