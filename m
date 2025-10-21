Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA626738B
	for <linux-cxl@vger.kernel.org>; Tue, 21 Oct 2025 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076416; cv=fail; b=WWTTH5cM8Bb9V8oL9pV9F/FkcMhRM5/iei/K+NxsveRyibAVEjDxOwZC3iUH5dpN2BWgQZTgr3tO04OC31m+skpNY1+PIA0dJnlODMnih8AGcSEGXzsjn/6gcnD0WdF4YCtb5ovw0ahx/hOmd5Iu0wk8imSWWgxe+m9BdwH3LHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076416; c=relaxed/simple;
	bh=6Juc3z9OOZoqSmBZ+i168TdP1YJoON4q8iNUPMoKcpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W6HXRh0MSe5v5QKiuUxp3dpNhkuwjTV+g6I/Ljw3KtWkFBSbyFrvdHSWmE3EPMsQnkKzIPu3L7jGzn0cIdYLQ8nK6atPGrJIN8eGKCSF2P7+PY58R5Qu8hPfwoQPXYRU35Fh0afeiQkcMzp5kbnWCKzk1w60dEnxz6aqSrd3YHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rzl3DX3W; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rzl3DX3W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZMmMOrdXeySDzrAHsour4tMVu4k4BIRxf7bjXqBSg1TLt2/GKX/lmO4+xHspDeCvweIw6yfT0R9zQvDUCGO4H4wtv5X52a2JMPXDnqmIXxUQii5TT+Y3YrjsuQhVCtc26W1BCDUZjOF70ygMvlUsqyg+Txt50+WVC0exneCv0iL0IBGqZ8fQwO/KJUDBqJxtB9pCy1M34ZEEsFxvzqAZMRDNmz+49jR26Tu2WXH2L606QOEUgnCct6lFvifpa7JNxmj1IvYDd07Kx6FX0E/E0jI6HYPBPvY5KGXbV+AGSR9xm084GyYGoV3NiyFhFr2+z2JN/Ut2jYYam5rsvlOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke/Ayk1aiHxC+TKqwLmJBlqwboiIjuCowQ/Hy0JAkZM=;
 b=larldxg68pDgShGgvkvj+H68WtS2r5uMaoCsu9urftHvuoiyckOQFOShpAZA/0DEWWIUo/p9SASGDeuGvuuFNyFLzxRvB2Cvv2cizjLPyM8o86WyMQmBX8/fhIWpcottws15GUxNM2q2ug0uovf+tvU7DWGkpwJfSbhiV/tC7db5Lz5QxklydgR+Km7JMOkUs1/1Uw8gRG6NfuW3CZrIdPJTB28s7uGoW3cNrwnQcrWlPfxGAh9hngwFEZ2pdFXVqvDidSVdH3QqELdp3QHCVDVb3hDQ2njoQEYZAF0EPkGv+/YlxzHcmL87gv633D3HyOiqzw3FkQCHBKwfaAu4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke/Ayk1aiHxC+TKqwLmJBlqwboiIjuCowQ/Hy0JAkZM=;
 b=Rzl3DX3WUpKLvsWkN0xxxOVY7zoQ+e03ZRSmqhKhXFN3zPFcYJD4AXzyIpnbe/OaZNE0nL9b7j+yTsA5lNHAh7ZksmQbo7vSP0KYHT0LWMcY4SVtP3SRjJ504aKVnjYZ+hbiPgkbjEzUfLMkriDsgh8j1tDYzaLntFpPNA56VWk=
Received: from BN9PR03CA0873.namprd03.prod.outlook.com (2603:10b6:408:13c::8)
 by IA0PPFAF4999BF6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Tue, 21 Oct
 2025 19:53:31 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::30) by BN9PR03CA0873.outlook.office365.com
 (2603:10b6:408:13c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 19:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 19:53:30 +0000
Received: from [10.236.176.164] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 12:53:29 -0700
Message-ID: <beb4a761-c7f8-44d2-80c0-99ef0a20e811@amd.com>
Date: Tue, 21 Oct 2025 14:53:29 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/region: Add support to indicate region has
 extended linear cache
To: Dave Jiang <dave.jiang@intel.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
References: <20251017222536.4160645-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20251017222536.4160645-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|IA0PPFAF4999BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1252d6-be78-465b-959f-08de10db8264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEdnSHNzQ1RZa3QzejRMeDdrRCttekszTDZ6czZyZnZvZG93Z2ZEei9uNEFj?=
 =?utf-8?B?NDdNUU83UmxvUW5XNmFRdDZsQnFrb2FiQmtZUUdpUmVZQkpVcVpuYUFXYko2?=
 =?utf-8?B?aTFVcTJRb1ZoRm5MTE5MRjJzSHV3ckp5bmVJZ1dTd3diM2VZdTNXK3pHcXNw?=
 =?utf-8?B?R0lMblRIa2JPeS9pdkt0OTBNK0xpZG56ZEpqcEFtSVR2Y3RXNG9adTR2dHhp?=
 =?utf-8?B?bVFETVp1WmR4TEllazZTRkVhQ29DYlNxa0VXbGpZUWM5dnZ3akpMSDcrckE0?=
 =?utf-8?B?R2tCeFlvaFh4eFRZeUhjY2dhamc2djBKSGNpQVdwZWJUbTFtQW5JVXdiMWQv?=
 =?utf-8?B?dk5yTWFqMzg4Y3RuODMvck9qU0RUNGkrSjR3WVBrR2dDSlFHUG12TFV5TmJ6?=
 =?utf-8?B?bTdib3BTUm9GYm9tT3Y0Z2pmdkVrUVJuYkdBT05XbmZ4MC9Cd2VoMzRQcS9Q?=
 =?utf-8?B?TnlGK1I2OG9iZ3NYRE1aRDg1aVhxdFAwRUVtKzVQcFBTNTZoL1hoeG9VSzBP?=
 =?utf-8?B?WXVGWlhhQml4L0F5RnM2MDFISXRHZjVhYTI0RXZZR01UNytnL05TSlBydXhJ?=
 =?utf-8?B?VUhFdFdRczgyZVpJWW5YczZnZ3ZWeTJyM2VQajNHTDNIVlRJRitBWm5JN0d6?=
 =?utf-8?B?cFJyeTRRcEdSLzVqdmR5dDN5NDhtZXN1dXZwSFJWMDZnUGhqMUJXbVVoeFN3?=
 =?utf-8?B?NlJaWUJQVDNaRGxjak5sWEdtWkZpS2N5ZHMxRXkraXlxNnoyK0YvWmZmb08w?=
 =?utf-8?B?bzVOVGx3VTN3cnNCWFJqOWpXcGc3c2hxUE5JWTAvVGlWR0NpQVBXbXpwTkxB?=
 =?utf-8?B?RlNkVGxFVVVta2JuL1BXUXgya2xrU0xEamNCM2RmMlluSmVZMDNScXliMTQy?=
 =?utf-8?B?ZEFwNWJleWQ3dzVTbm0xZmNVREJnbzdHZjNUQVBsYkhES2lFT2NEL3owQ2RT?=
 =?utf-8?B?TTltK21ReER2YTR0M1lpTk9FelJsdHZUWS96d2RBZEl2V2ZjTnBiaG5EVWVm?=
 =?utf-8?B?dnZ2d3ZNWDFmN28zWnhWOFp4N2gyMElnekQ1cHphT0p5dEhERlRFUDdrb2ZS?=
 =?utf-8?B?QnFTV2JLczRpZHFOU2FWNGpIaTdXcUV5RkxLNUxJQW45NG5WVFppQ0hqdTVB?=
 =?utf-8?B?Q0p3UmIrMzh6WXd4eGVyejNEeG9TRWM0aDZLN0FZODZEUGVPVHNpTU1iR3VU?=
 =?utf-8?B?ZW52VU1aTHVzTTBjRndhSHh6cTExeWVZeTRySTVUUW1xWmlIZ2ZyY2Z6WWlC?=
 =?utf-8?B?dXdMWWV0QTFkVHY4V242Ykw3M3dvS1VVc2c5bkNzOTZiV3VQQUZ1OVJXeEti?=
 =?utf-8?B?T1FpWGlzVDZSeC9OaWVQT1pmZDYwNmFBZXNrbUhaSlFHUlJtWEtWM1JaSEZh?=
 =?utf-8?B?ZEErbGRUZTlVVUo0eHF4akpBNHF0N3pTdmlnbmRTOGFncFBmcVdSbEoyYlVN?=
 =?utf-8?B?SmNnWWxOK0lUZEJEY1pmTEJWNVpJRXA2YWJ0RXpkbXdXTnUvSVNDM1JxWS81?=
 =?utf-8?B?bFpEbEVIZjhadDJOYi9ySDBuWXdiZ3hFM3BCU09ZN3plVHlDZkNUMzBYNXQ0?=
 =?utf-8?B?b0F1TEYxNTBOdXBQbmdYTkd3WldGejNFZkw1UjJvZXFTYUQzcGJBY2ovazBW?=
 =?utf-8?B?WXFhb0t1Uml4dmFhNFpTMHBHRExsUkhLNy9Tb0krSHpURFoyV3N1YmZ5TVZW?=
 =?utf-8?B?Smh0eGsycXJyeGs5SE5qUXlsTkN3cC9rWUxEaWc5S2NDSmhwZXJKUWNmdDJo?=
 =?utf-8?B?NEpBTVJwU05jWFBCbGI4aXlwQ1pyRERwOEMrbHNST25PcURxVm1qUzBQMFlR?=
 =?utf-8?B?KzZEeXBKRjYyYTVpQXg0RjQxZWY5RkJHWGEzRXhOUDh3SFdhZ0xMd2R2ZTdR?=
 =?utf-8?B?ektiZHpKS1ZISDFUcXY2RThVVW11dU9nOVFMSXhvZ29WVExwRmk0Y2w2VUh6?=
 =?utf-8?B?Mmg1M1cxV3MrcmNnbTZvYkkyM0FyUWlScHF5WTJSaDg0MmR3NlIrWnpMR0JC?=
 =?utf-8?B?R1QzYmhmNXBsZjFvdmpiNEFUeGlNcDF4dmw5VVFhc1k0L1hxQnVYU1JURjBK?=
 =?utf-8?B?SldoVlRZUlJZVVpVU3M0N2hEeW1tekUrN1VlUmVrL1YxT0p2dk9Ua24vYlVN?=
 =?utf-8?Q?vEd0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 19:53:30.4271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1252d6-be78-465b-959f-08de10db8264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6

On 10/17/2025 5:25 PM, Dave Jiang wrote:
> Add a region sysfs attribute to show the size of the extended linear
> cache if there is any. The attribute is invisible when the cache
> size is 0, which indicates it does not exist.
> 
> Moved the cxl_region_visible() location in order to pick up the
> new sysfs attribute definition.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Add documentation. (Alison)
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  8 ++++
>  drivers/cxl/core/region.c               | 63 +++++++++++++++++++------
>  2 files changed, 56 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 6b4e8c7a963d..8d529d68dfcd 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -498,6 +498,14 @@ Description:
>  		there is no guarantee that a free followed by an allocate
>  		results in the same address being allocated.
>  
> +What:		/sys/bus/cxl/devices/regionZ/extended_linear_cache_size
> +Date:		October, 2025
> +KernelVersion:	v6.19
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The size of extended linear cache if there is one present.

s/if there is one present/if present

> +		The region 'size' attribute would reflect the total size where
> +		the CXL region size plus the extended linear cache size.

Bit messy, maybe: "The region 'size' attribute is the CXL region size plus the extended linear cache size."

You should probably add a blurb to the size attribute's description about the extended linear cache size.
Changing the meaning of the size attribute outside its own description seems wrong.

At that point you could probably drop the second sentence altogether (I'll leave that one up to you though).

>  
>  What:		/sys/bus/cxl/devices/regionZ/mode
>  Date:		January, 2023
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b06fee1978ba..531f790b9510 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -461,21 +461,6 @@ static ssize_t commit_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(commit);
>  
> -static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
> -				  int n)
> -{
> -	struct device *dev = kobj_to_dev(kobj);
> -	struct cxl_region *cxlr = to_cxl_region(dev);
> -
> -	/*
> -	 * Support tooling that expects to find a 'uuid' attribute for all
> -	 * regions regardless of mode.
> -	 */
> -	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_PARTMODE_PMEM)
> -		return 0444;
> -	return a->mode;
> -}
> -
>  static ssize_t interleave_ways_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
> @@ -754,6 +739,21 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(size);
>  
> +static ssize_t extended_linear_cache_size_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	ssize_t rc;
> +
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> +		return rc;
> +	return sysfs_emit(buf, "%#llx\n", p->cache_size);
> +}
> +static DEVICE_ATTR_RO(extended_linear_cache_size);
> +
>  static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_uuid.attr,
>  	&dev_attr_commit.attr,
> @@ -762,14 +762,44 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_resource.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_mode.attr,
> +	&dev_attr_extended_linear_cache_size.attr,
>  	NULL,
>  };
>  
> +static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
> +				  int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +
> +	/*
> +	 * Support tooling that expects to find a 'uuid' attribute for all
> +	 * regions regardless of mode.
> +	 */
> +	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_PARTMODE_PMEM)
> +		return 0444;
> +
> +	/*
> +	 * Don't dispaly extended linear cache attribute if there is no
> +	 * extended linear cache.
> +	 */
> +	if (a == &dev_attr_extended_linear_cache_size.attr &&
> +	    cxlr->params.cache_size == 0)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
>  static const struct attribute_group cxl_region_group = {
>  	.attrs = cxl_region_attrs,
>  	.is_visible = cxl_region_visible,
>  };
>  
> +static const struct attribute_group *get_cxl_region_group(void)
> +{
> +	return &cxl_region_group;
> +}
> +

Why introduce this function instead of using &cxl_region_group directly? I see there's
a precedent with the target group functions, but only get_cxl_region_target_group() needs
the function. The other two (get_cxl_region_accessX_group()) are only ever called after
the attribute definition and should probably get cleaned up at some point.

>  static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> @@ -3478,6 +3508,9 @@ static int __construct_region(struct cxl_region *cxlr,
>  		dev_warn(cxlmd->dev.parent,
>  			 "Extended linear cache calculation failed rc:%d\n", rc);
>  	}
> +	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_group());

Missing whitespace above this line?

Thanks,
Ben

> +	if (rc)
> +		return rc;
>  
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
> 
> base-commit: a4bbb493a3247ef32f6191fd8b2a0657139f8e08

