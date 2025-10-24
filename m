Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D832E74C
	for <linux-cxl@vger.kernel.org>; Fri, 24 Oct 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325540; cv=fail; b=BtGgJiUDXdliSPczJcbLkib1m8cl21Mv1Gblh3Lf6QExSCR+zXGrkwSnZtgPyQHTYRLD57wran0ISekoxmBG1QTtiMW0qqInsFtIXsRS/7ZbJRoNxwnHqeyTxmVw5ZYYm8NuK8owO0r0tOnqqtmMwCemHzBLS3SQ0dz0YXdbVhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325540; c=relaxed/simple;
	bh=J78yfp7dLrC9+VPV61aOdcunT7yNa8pVrJHuUO8tTAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uIb2v/6GiIhcDzBU58XUjwRvuecpny578YiltIiEjs3+0I2SZctCu3DgaPpRLSrtsv9Fgu2YxOOp92iSTcdtrM317XZxlaHAuNap8OQcmZAfc+XLmxb/3I4x08VQrR2NE547CspCeR1lzioN/s94W397mY640Xhg4kN+W5LomSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0xlBod2j; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0xlBod2j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnTYbAkafTQLFWRK8OV+cHb513Zo3BgAy6K0O8omHgUwDn1ZRUnrpOuUxl/N/c6MR8htU9JRWcWm87MloWgJAVMJjBXU6bMx4vOTlR+qR+B2+lRttwgqzB2nURmDWY7uwwhnBSk4wYNfqQXqgpiJ9H82b9LFxgv/BUDeKi5ED/kCeHcvZpEqFgPMahj/N96Wu1HOlrgdXhbX3qplM7hjkD8RHgaFgGMx64uNY9fJgR5GIM/1XJp4HzIYScWjkQbULX0bV+KDcb0IHhdNujzP/M/8QuTC6HFfkj1zuAenUtyzke6clejLpEpbzUMEZdkPFMHu5arrrc7qvTx4zJqb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0FQF5UdxJQi00yx5/aNJzXyH/xudGo7arKuc7neaZ8=;
 b=Mf5jcef7c5x41wg6IVVEb7EGtx/i5L2j+/U4WTJNlmxwtIWBcXSrsGluXRtCyU+YqK9EJ8PUr+HN6rvPbD3u5hIrtC4jUOrPUWgTqD4qD2JNBKvTo5X5lB/fGdxkY4ig0RBX0maFmoUOVmNOmwVu5Szj5Jdua3azGdUAMcGFAqf+2f14S4H4peWfa+d+XSatCXbpQjhqb+cqLaMJ4+DoytmHqDuvnlcqI25VY0BmfK/qru7POGFoxqdyZHZFLN+lZyJ6e9x5h3lWLcSGdgDE0IFdleSXU0KDkXvWAvZj1SQ0Cy+2KJpsg2G76EJT6Un0ipjNFDIfRDdmIo7Xb58TXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0FQF5UdxJQi00yx5/aNJzXyH/xudGo7arKuc7neaZ8=;
 b=0xlBod2jZDA8hXhYYZ+j8oB88O0MZKGBa11Xy8r0z14tjf8hgF1oCu4ALKfDlhD9OIGOHRbGLreNuUEfsZKz4XX2weuDvIgFB2IS7tNV5FRvc5lRNBEUy4s1TTLCQT2ZAf/BupPrtNUXklzFMY+EFfJOFHBd7IPW3cn2wEr4YE8=
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:05:34 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:303:b9:cafe::e6) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Fri,
 24 Oct 2025 17:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 17:05:33 +0000
Received: from [10.236.181.3] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Oct
 2025 10:05:31 -0700
Message-ID: <5e9e4ac9-c0e1-4c30-b4da-1f97e14bdb39@amd.com>
Date: Fri, 24 Oct 2025 12:05:31 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/region: Add support to indicate region has
 extended linear cache
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
References: <20251022203052.4078527-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20251022203052.4078527-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 83985c38-c17e-48d2-17cf-08de131f8b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXlGT2VHMnVkUjFzeEpGTUEweUhxZ1RCZTBBa0Zxdld5OS9ONUhBMmF4TmtS?=
 =?utf-8?B?TDNPQ0RBVUovb0JrWUhjc0Y1RHc4QnpWdjNlVWFudkpsUktrQjF4WW5YNTNy?=
 =?utf-8?B?ZU9tSUp5ellxWjEzRVVLUU10M0dMYjJlWHlxR2tHRWRNczdYNGN4RDloOGhG?=
 =?utf-8?B?V3l5TTZFL0JKNEdwUGUyV1FzcXVxR0lsZXA5eTBWcDgvSXQ3UEg1eTh2SlJM?=
 =?utf-8?B?WFlYeUIwZDk0aGhEMmNrVldIeCtDa0VNc2VQeGUwdHRvR1g0TGVTdjFqMjV0?=
 =?utf-8?B?UTMySitwa2VmemZQVlFXODlDUXFJaDB2OTVrSUNyNWQxUGdMVHNQNzFtMytN?=
 =?utf-8?B?Ly9uSHZiaDQ0M1VVV1ZYNkhLd2N0ZUlIOFo1dDZuN2VONGIzd204QXZCWGla?=
 =?utf-8?B?T3p5bGVCM2dLcElqZVNESWdFYkVkUTAwUmZnNW9UQmNMNlV0UnlZTjIwQkhD?=
 =?utf-8?B?d0FmdlZ2bHVkNkJuVWdBTytRRW5ZdEl0eGJNcXExSHFjQkd6aERib2RMUUJo?=
 =?utf-8?B?ZEZaa0UzRVdYcnk2ZDY4aERUNmJ5djVoYlRpOG9ENUR5bHVoVTJJVnAzM0Jq?=
 =?utf-8?B?KzQ3WGdhWDE3QnBPOGhsMjRkWXVEUWFJZ0pIWGl1ZC91UklZdExFSWdwclpv?=
 =?utf-8?B?WW1PL0pyQXdGUWpyckZKUytyekhYWDYxN0MwZFdWUTl2dGt2OTBzeFBKQVdK?=
 =?utf-8?B?ckFuVThNQmp6TW9mZHJCQ1lYNVQyTnNUcFVtc2JQY3hTcVJMODBEMytndjVr?=
 =?utf-8?B?cVJFUTVpUlkybkF4Smh2UGNsd2lIaWRKRVB0VitQMEF2d0JNN3BnbGpwVzhW?=
 =?utf-8?B?VE12Vk5lV2oxekFnNUtDVDJ6VG5XUGs1M2tiVk5vSlhneERJSWZKblBDdG96?=
 =?utf-8?B?QWJnOGtvWGhndUlLQ2N2RTZpRFdIYXlhY0NBVUMzekozTkRYci9CbmUwTmli?=
 =?utf-8?B?OS9ScGdsQ0xRU3JJL3BxTW42QmRPdS9yY3pKTVFmVGxpcG5PbGQ2S05wWmJO?=
 =?utf-8?B?OFJUTnN3NkVqZENMVUhKR2V4b1hVK3JNcDhqcFp1UXQ4c3E1TW1CaG9nRURI?=
 =?utf-8?B?QVVPb1E1Ym5SazJJUnRjYmZWcG50QnBTOWFZcytHbVk4WXBJNDd2NGNsbXFm?=
 =?utf-8?B?ckJsQmZ6VWRwTENlQnM1RnJZRjRyV3ZUbWJRb0U1MnlRanJ6YUdrSGFXZHlr?=
 =?utf-8?B?dnNuQk1SblU1eFVWQUF6RGR3M1RJTkRaZUJkSzJaY055bVEzL1VzbERydE95?=
 =?utf-8?B?WWhHL0dLOGtTL08yM3BVdSt0a3dpQnpMT0ZPMGo5c1VySnNjSnlFekxuaWZ4?=
 =?utf-8?B?UC9xcy8rT3JPR0ZibzF4M2NwWFBmQi9YdXdlR044Mzl3VE9jeVp4Y3lPRmRX?=
 =?utf-8?B?ekVpQ2NxYjBhRFpCQ0t6My9TV1V3c0FuSDc0UFIxQS9hZU0yUkZjQ2NPekFo?=
 =?utf-8?B?SzdZNXlCYWRnVzJQVTR5ZllpaEtsVXcyWXl0ZDhlNlFlYnRUcWFyN0EyblRo?=
 =?utf-8?B?dmVma201dXJMUzdEOU9aQVlQZkJMYSs5eitGM3dDUCs0dXpGZjBWWllIU2VB?=
 =?utf-8?B?Y0dFWXMvbm42c0FpR0ZLNDZOaEx0WDZrYjdBTE45ZE5PaE5ER2ZuNC91R2F1?=
 =?utf-8?B?NEJGMXpoMHhmMVRMSmtkcTNGamZaOVNFdjYvWDROUTE3VkJvUUNkY3I0czFk?=
 =?utf-8?B?QnYvYU9kaTVLeEU0UllHMzFZVCtDbnpMUk9wKzR6WU9GdkdhYTdZZXhrMnhI?=
 =?utf-8?B?c0dZOUlGeDNOdmhiZDlTVS9QRGxjeE9zU3B2cStScWRWK2FxRTRZSVIvcy9K?=
 =?utf-8?B?aWVLUVhOaEpNT0FGc0VEejFHUExZKzd3aExSRlZzZ1RYeEIvbU5WaHQxNUsy?=
 =?utf-8?B?NTFlQ29HTUhyN0NOOFNoZGRvZkRjRTRHdDZOVnZ0SFJ1LzNxVnE4Z0RveDlZ?=
 =?utf-8?B?U0h4MVBHSWZwQTlrZzk0S2sxUWM1WXUvQjdzc3Jmc1NISVFaT3N2aXI0OFc5?=
 =?utf-8?B?bGU0ZFlhckwyZXhUdDJPMk8vZ0QydHY0TnJXbzVJY3kwSGJSa2ZIWFpxUFEx?=
 =?utf-8?B?cUQ5MEV4dmlIcXg1aStiK3Q3QzVaVE5kbk83US93Q2ZjVndMZ0V4cXdyZ1l0?=
 =?utf-8?Q?G9iI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:05:33.1881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83985c38-c17e-48d2-17cf-08de131f8b2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687

On 10/22/2025 3:30 PM, Dave Jiang wrote:
> Add a region sysfs attribute to show the size of the extended linear
> cache if there is any. The attribute is invisible when the cache
> size is 0, which indicates it does not exist.
> 
> Moved the cxl_region_visible() location in order to pick up the
> new sysfs attribute definition.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

I pointed out a few typos below, but contents look good so:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

> ---
> v3:
> - refine documentation (Benjamin)
> - Drop helper function to get region group. (Benjamin)
> - Add blank line for better readability. (Benjamin)
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 11 ++++-
>  drivers/cxl/core/region.c               | 59 ++++++++++++++++++-------
>  2 files changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 6b4e8c7a963d..c6abce129137 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -496,8 +496,17 @@ Description:
>  		changed, only freed by writing 0. The kernel makes no guarantees
>  		that data is maintained over an address space freeing event, and
>  		there is no guarantee that a free followed by an allocate
> -		results in the same address being allocated.
> +		results in the same address being allocated. If extended linear
> +		cache is present, the size indicates extended linear cach size
                                                                     ^ cache
> +		plus the CXL region size.
>  
> +What:		/sys/bus/cxl/devices/regionZ/extended_linear_cache_size
> +Date:		October, 2025
> +KernelVersion:	v6.19
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The size of extended linear cache, if there is an extended
> +		linear cache. Otherwise the attribute will not be visible.
>  
>  What:		/sys/bus/cxl/devices/regionZ/mode
>  Date:		January, 2023
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b06fee1978ba..095f5dcd17a1 100644
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
> @@ -762,9 +762,34 @@ static struct attribute *cxl_region_attrs[] = {
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
                 ^ display

