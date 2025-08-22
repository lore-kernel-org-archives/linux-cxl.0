Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126120EB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885742; cv=fail; b=CMvnvv74qhfjGYqrGCuANtO/V5D0f7JB2ZqyJZSqvdFcxnCfVd+gg3JUSOxRw5vUABQYW26lIR6AGxY4XUVkO/4N7GB8AD/m0QzgXYechVaTU4XJutujr77q+uiRqo25ubuxdrEOkKDu1/OPvdKxCX3BxkJWAQypB7KWs+L+QGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885742; c=relaxed/simple;
	bh=Kcx+7nMzNNCb8tONiPZWS8kZN3OlLM0nww1GiL+wmf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bF62CTmnWrShOHUsrt1mroconWrxnUa7vn5wphsfUZnT8BQ35y59IFgvJrfPozXRYtYxLyZ3iv/2If6BJq9ywA39WHOIsHgxelZqQNxsaayR8RLR+FtP3UXxYnI/2BYjVuVLa/mYGQ6tQgdITRJK1AW5u3f4jlvE71ijow9CkCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yLff84RY; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yLff84RY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf1Z8N7g+9sK5x2+xAmIsJ1u+Nr8tt0qwYd3+BYseyCDySeDFIlnGevRodtPaTF4ifHFqESvjRkPTHSZFH/RImFS8rwXw2DGrWilADETe2/7SJEXq6UkuJf6jF5lCgkLXuELju4Rc/APdkKLJPDKZr2CwLpSrTVZWYCFdpxz+cYS4aVirglg1s0rI1f8K+XQIJ7sVg3u38lP6fCQ5+2Zt2xwpWxudCuumi+GvC3oyl2TvHHu6cryPsvsi87opVMVYUudBcOGRwALVq5uDuKexZtlebyW7pWK/+Y/lCK6KsNCWkiZ5ofi1tllOEPoHi3LlUuj9OQApxb0ZpmmgHyHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQcYaIWM/uY92HRkyuIJXStBuQL7SZeZdRsG8nLvdGQ=;
 b=KYn4Dw3sa0DqqjwU/yXjG2FQpelKbXY7ZtEB3zB23jCGfPlz795U3CjsVK9L3nXCfYoh7fpZ9rByKHHkyb8U4bVCIwahBtOFda/4Cc1bDSQcXDHIBVEN8Ecyo8FNVJzRgQbnIA5t03fZ8SDxCMqRxzPxwluk47rufQ0QhSqPWh4m3p8vakAon3ftWtlprupJPfMcAoDtQL9HhmC4YHPnQ/XeWfg38QOON3FNwTxfZOud4d9aR/e7qx8HgqzGQGn7sRw90EqCciC+W2BBiigpM4+vS+v5bAx+SObAxuXDgOpb88RqNN0G0Y6+ZiKc7acVYBuR+PDzLXh+dxQAi5Ndwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQcYaIWM/uY92HRkyuIJXStBuQL7SZeZdRsG8nLvdGQ=;
 b=yLff84RYwVGMWM9/xy+QytCBvtbxG5GRz543SPNmgln+Tzhi/HVxD96YcAsjNPLG8ne1ZxBbTFHRSy8i8uaCB+cSShXAAVG9eQTl+6xSrUMnc+vrFN/PKxJuz6npkyRpwZV49rzdFB2GJnM4UdlP0h/AAriA/sSmjGhPLLbXCN4=
Received: from BL0PR02CA0131.namprd02.prod.outlook.com (2603:10b6:208:35::36)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 18:02:16 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::a3) by BL0PR02CA0131.outlook.office365.com
 (2603:10b6:208:35::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 18:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:02:09 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:02:08 -0500
Message-ID: <45da6670-d6e7-4301-ba93-68b63b1c6361@amd.com>
Date: Fri, 22 Aug 2025 13:02:07 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/18] cxl/core: Add cache device attributes
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-18-Benjamin.Cheatham@amd.com>
 <20250819163858.000063a7@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819163858.000063a7@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: e63b62f8-a105-40d2-0e70-08dde1a6032f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0l2TWloKzBMU0xYTUVGYUxhK2R4Z2FSbUg0RzlIN0RCUGxUV2MvUkxsWkpt?=
 =?utf-8?B?aURTNU9zVmlGaU0xV3dsQ2FqVW1abkdYdy9kV2FJL2crVEsrcXA0VnpsTC9p?=
 =?utf-8?B?bVR3UUc0VGREa2VqdldobUdDOHl5QXVWLzgrUGtZSHNXeTNZTTlzbFBtSHR1?=
 =?utf-8?B?RTJnVEtOTy9nTUZ2WmpISDc5UjE3QWF6eERqWC9qNmhKdjArL1dEUTFMOGY5?=
 =?utf-8?B?dXZXSGFVWUdKZUtNTlJEZ1RnV1B3TGlXU2g1RVZUeXFVa2d4cC8vWHY1OTNk?=
 =?utf-8?B?bUpicDVOUjNWajc5dzM0UUZTWjIwK0VCcGpHYzN3VjFPSnAyajQ2V1h3UjZr?=
 =?utf-8?B?TUJoTE9sYmRXTXhzRHJZS2tzb1I4RFJOa1BlZ1Nkb2pObkhkRVJCSm5vU0tE?=
 =?utf-8?B?Wkc3Z2h5aHExeWF1ODNHZzc1aDR5WmtHK0hpZzc0eDNveUN3MjcrdEVNRGpH?=
 =?utf-8?B?aE04dmM4UXM3ejRmV3JVMjJzSC9HREVwZXl2N0Jwak9zVWpUVzBmM1hzTmxI?=
 =?utf-8?B?N1VOeVZjS0c1NTdMeDh6ZkpYcUNOVHJwdWRZeXl5Z2tIdDMrT2NMc2wyZ21Y?=
 =?utf-8?B?dXlPUldKUTJKUjBsb1VNYmRhbkU2TlhLalFwSFJWeHJxbDFUeU14VEdWTlM3?=
 =?utf-8?B?bkdscE5zWWdNbmEyMEYyV3grZE9jQlkrR2tlWUE3UWcvRlZkYzhpSEozMTRm?=
 =?utf-8?B?aG0wbjEwNVFJN0lINGM2SGExNXFHNmw2K1dKSXhoSHRjRWx3b09IR1YweFFz?=
 =?utf-8?B?TTVnT25ObVg4ellSaTJFU2Izc1kybzBVOUo1Z2czMk0zUmt0RHlMZTVrbjRv?=
 =?utf-8?B?QnowaUI1cHc4dlBKdzl5bjduVEtkRHdNOE9Pb1hJeFh2N09mTktzK2tUc2VH?=
 =?utf-8?B?WjB1Q242Si9COERKVGlBQ2puQnVoa015TWlqV2h2SGZmQURrYmYyT2VhNVB1?=
 =?utf-8?B?YWxTYzhJdHRFVEcySCtFalZENDE1RkxVcytaUS9CL1R2L29XUk42Qkl2YlN2?=
 =?utf-8?B?SkRpOS9TWFNWcldFdXlKbW0vWUUrOVlUWFV1S1ZyTVJ4bXRROG1jTHdib3Nw?=
 =?utf-8?B?K1dkYXMxMmdTbUwwTnkwbVJOU2paeXlOQzNGTkR2SjdkUGt5TzRGM2k4Q3dq?=
 =?utf-8?B?K2V5cm9UQ2lHM0lMZk80NlA4NlphSmw5Y2p6TjN2ZXc5MlprUFFRMWRzZjJa?=
 =?utf-8?B?ZUZZc3FwTWQ2RWlZRmQ0Q2tNMnFwTHZ1NURZMXdWamh0NVdYdGJpMGxVWE53?=
 =?utf-8?B?bWtqNlJmOERzSm44TU5KR0J5VXRNWnVBa1dGSXhFd01vY05rZHNJQ0ZSUFBu?=
 =?utf-8?B?WExjVkxGYUJPMVJTOFh5UzBUU2M0c1NjS3BHRk1mVU9aQytEZ2E3MHM1RFZB?=
 =?utf-8?B?Rkt4ZU8xdG5CcHVDN1ZlZnRFam5idU91UHpMMXlFazl3d2I3Y2hESHRlV0hu?=
 =?utf-8?B?U3B0WVRMdjRvRUVST09GT0tXS2Rod1hZU3E1VEZ3SEE4UjJ0R04xM0JqVVZ6?=
 =?utf-8?B?bzRQb0RLVUNWalZnOHBJS0hteUZvdjAwYXd0RjVveFVUSFhqSTBlWGNSUWYv?=
 =?utf-8?B?OHVOVlFhU0NRaVNWNlNiVXNPUDQ5UnhZVG9TUG5mWkFtWVFCVHFMTzI3cVd3?=
 =?utf-8?B?M0grR21hSllTdGRpdkJ0WGZWOWNrTUZHNVRnSzlJaXczVURYdTNpTU1teHNX?=
 =?utf-8?B?MUJvNzdSSGpiemRVaFFDV293bmRIUUNlcUcvNm11TUU2SVRGaHo1NXl5d3VM?=
 =?utf-8?B?M3ozYlJOTWo3d1RyZDFXWi9HcTRjNktVZk0rZ09MckFsYi9PNWo4YTNINWR4?=
 =?utf-8?B?TVVPekUrRFVGTmpCYldGTGxmMjI3Yk5Td3M3SkNNU2xjQ1U1RmhKWnZ4bzUr?=
 =?utf-8?B?bzUzRXJHVVNMRXRTMzVTOEtReHpNRFBoSnp5ek12MHdEZENvaGE2N1kxa1Iz?=
 =?utf-8?B?a2tLN09rRGpiUm5KTVVxbHd1a3RFd0NoVGJNK1Q1Z1ZTOFgyY2MwWlVrNVNm?=
 =?utf-8?B?L0hpekhHM3J2MkJXN0VZRlhzb3Z0a0psdmhoYkhJYVFNTTU0VWF0SFJXRnBL?=
 =?utf-8?B?UEJvQWl3YkIyN0VhbTh4a3FqK3lUWnRBMm44Zz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:02:09.0299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e63b62f8-a105-40d2-0e70-08dde1a6032f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600



On 8/19/2025 10:38 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:20 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add sysfs attributes for getting the serial number, numa node, CXL cache
>> unit, and CXL cache size to struct cxl_cachedev.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> A few minor comments inline.
> 
>> ---
>>  drivers/cxl/core/cachedev.c | 102 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 102 insertions(+)
>>
>> diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
>> index aaf4a1b94178..1cdd94520ceb 100644
>> --- a/drivers/cxl/core/cachedev.c
>> +++ b/drivers/cxl/core/cachedev.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  /* Copyright (C) 2025 Advanced Micro Devices, Inc. */
>> +#include <linux/string_helpers.h>
>>  #include <linux/device.h>
>>  #include <linux/pci.h>
>>  
>> @@ -30,10 +31,111 @@ static char *cxl_cachedev_devnode(const struct device *dev, umode_t *mode,
>>  	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
>>  }
>>  
>> +static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>> +			   char *buf)
>> +{
>> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
>> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
>> +
>> +	return sysfs_emit(buf, "%#llx\n", cxlds->serial);
> Just as an FYI there is a discussion about putting similar in place for the pci device.
> 
> https://lore.kernel.org/linux-pci/20250811173931.8068-2-thepacketgeek@gmail.com/

Wasn't aware of that, I'll probably remove this one then.

> 
>> +}
>> +static DEVICE_ATTR_RO(serial);
>> +
>> +static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>> +			      char *buf)
>> +{
>> +	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
> 
> I grumped about this when it was added for the memdev (duplication) but lost
> then so I'll give in this time without a fight :)
> 

I don't mind removing it honestly, it's just there for parity with cxl_memdev. It really
confuses people who are debugging CXL memory in the terminal but don't know much about the
driver in my experience.

>> +}
>> +static DEVICE_ATTR_RO(numa_node);
>> +
>> +static struct attribute *cxl_cachedev_attributes[] = {
>> +	&dev_attr_serial.attr,
>> +	&dev_attr_numa_node.attr,
> 
> Missing NULL?
> 

Yeah, will add it.

>> +};
>> +
>> +static umode_t cxl_cachedev_visible(struct kobject *kobj, struct attribute *a,
>> +				    int n)
>> +{
>> +	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
>> +		return 0;
>> +	return a->mode;
>> +}
> 
>> +static DEVICE_ATTR_RO(cache_unit);
>> +
>> +static struct attribute *cxl_cachedev_cache_attributes[] = {
>> +	&dev_attr_cache_size.attr,
>> +	&dev_attr_cache_unit.attr,
>> +	NULL,
> 
> No comma.
> 
>> +};
> 
>> +
>> +static const struct attribute_group *cxl_cachedev_attribute_groups[] = {
>> +	&cxl_cachedev_attribute_group,
>> +	&cxl_cachedev_cache_attribute_group,
>> +	NULL,
> 
> No trailing comma needed given it's a terminator.
> 

Will fix (with above as well).

>> +};
>> +
>>  static const struct device_type cxl_cachedev_type = {
>>  	.name = "cxl_cachedev",
>>  	.release = cxl_cachedev_release,
>>  	.devnode = cxl_cachedev_devnode,
>> +	.groups = cxl_cachedev_attribute_groups,
>>  };
>>  
>>  bool is_cxl_cachedev(const struct device *dev)
> 

