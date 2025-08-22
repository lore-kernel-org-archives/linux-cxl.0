Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B819E97A
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885741; cv=fail; b=izsgY/+y9VdHHPqpbajXe9Id0fFevMDS7zhfIaQ86l2Ol7BaYihvgftnD/ajV8lLC9/2CAZ+Onkf4yJ1BunZi1xmSHC0v4H8/dJQydlpJZC9NsLwnAMq0Zpy8ybOjFmu0m0S28vNQljmoFdRSvy4h/I+c5oFfTZaIi3ul6Zs888=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885741; c=relaxed/simple;
	bh=XeJisJPaMtiGElWqWuoSPYacddC3JM3iEeN+iebS0uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lOLzg9EJQjG/L58GPH70A1pmjeaxh4utP0EwYd4JDGmvpkoNjLklkQBsdmDA5LygZvHVtWCPZMm+zw5wk8YWX7+XwKQ8Fe/enMbXIsim4WIdo3PbnBXQVY6QgZbpL4HEUeq/sLlqqlFv1mNW2PZiJT/DHxJqHCZ4Slu3ryrmSLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3wjY1Z5u; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3wjY1Z5u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsmi8K0fd3SczfCHHn81Q/fbLSeDp2z+PU3ttnlyiBWIuE4avHDBA6QhJOfr4/9n8WxCk0tzpTKaN1CNr+XSJyJKm++xTCw/IFaFLfAW3Aqk6AQ6tqcl6b3QVS8j4oltBSOYhqFGwN2dtAQz+XtvRTaJt5HZA8y0bikKkJBsI5lybzq67uSVas6BKp+MEzsVPFss4r6u1vJIZ6tUvKAPr4vZslMKCqFO6eYAXAYI/Azpmy7nIbBNOvWuhlKUwVv8sNqEGyHQTMEv6eLh4GzhpzJ4qEQzD5oHaxgPhVT7XA7IFxpE/qGd78GXBggrIWCGNrFaVOuDdhKW0QJTyiwEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzdvhjhC+VmqrKqxI5ehjsD1lowRFTVjJmbq4qm5uBw=;
 b=tDab48UypFr92c81bmkKPNEgctvHbPy5B1edjRF/jn20vgFnIus0LTC4cr4Qu5u79Z7BynsX6R0zW8jdnlq1Xi399t7W7n4WUkuekO12NCHLDNZDYooROOZ3bRFVAHWYpUbKKNryfJAgUqHAbJgH+xkZA9qFyHRxLonMMR36GBv54DlrgyoCZfg70VVWjDlDJ69GiY3srX3c3zlPM9nLL/osjkp34AnwFC7/BHMOKT/9YYlEbP4UU7RgahM3tJfeOC1mj6wrYYHuwR3j0ESeYGrv36Hi+kUASAvlmlvDjoYpapgR94TBVBnGixHxc+XemLOXzMcQX0CCSL3WuvttAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzdvhjhC+VmqrKqxI5ehjsD1lowRFTVjJmbq4qm5uBw=;
 b=3wjY1Z5u1bpb5dG+EWZYhS2oKmkHxSUVZpOp9GGy3xfPZPWnOsLMyuFEierPc+nwRLHehR+cDAlO0iQeACzdzDt8MzkH5OOWW7Vj7SPpVZAnpoUx0WFixAGplC/5ek1hw2ki8JSg/dYUrBIw9580Pb4Bx8Mj7b0Aamz/E4quXYQ=
Received: from BN9PR03CA0098.namprd03.prod.outlook.com (2603:10b6:408:fd::13)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Fri, 22 Aug 2025 18:02:13 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::92) by BN9PR03CA0098.outlook.office365.com
 (2603:10b6:408:fd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Fri,
 22 Aug 2025 18:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:02:12 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:02:12 -0500
Message-ID: <d627d852-972c-47d2-83c0-077d885971df@amd.com>
Date: Fri, 22 Aug 2025 13:02:12 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/18] cxl/core: Add cache device cache management
 attributes
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-19-Benjamin.Cheatham@amd.com>
 <20250819165329.000022f7@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819165329.000022f7@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: e12ebe89-9011-4621-6779-08dde1a60574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGtvdmRzS3pXZXZBQXBteWlqeDFaUlF3YmFncm1uM09CSkNrRXBTc1FDdnQ3?=
 =?utf-8?B?TXBBeU91eWV3YXVkN2FRMGFOdEVvQ1pzSDVxNnVRR0RmT3hWaGlFL2tqcjFj?=
 =?utf-8?B?cnF1akFZSXpuRXcxbUlFQW91bnpyRGh2RkRRWDNwVHUwU0FSMXYzZ0dkczlB?=
 =?utf-8?B?RithYWJBSVM3akM0UmpldWF3bzZiQ3NFaWV0RWpacTMyKzN0QW5jTnROek85?=
 =?utf-8?B?MitvSXJSWVJMSGlmZ1FkT2pwbFZDQWJtMGZ3YTdBK1JsaXc5enZ3V0RYUUl5?=
 =?utf-8?B?WVZzZmc5ZkhzTGZDVVFPcjdzUm4xTFBoVHB0WUl0MXE2b1dreUM2SWJhbFpF?=
 =?utf-8?B?dnp5YnlRYmU4bHFWV0djMi92enJoVHloajZsaU9mYm56RTJQNGNET3hWRmxi?=
 =?utf-8?B?ODRKNFp1OU1NUnlDSXlFK1RsbUQyalQ2ZEZrYitoTENNVENtWVBXS1dFeXNk?=
 =?utf-8?B?RnBVbHU4SlowU0ViYjIzNjQwVW4va0FyWXF5cmNickc0Y0dlYVJud1o4QVAw?=
 =?utf-8?B?TlJINDA2b1BEekpZcHhYclE3SkVYLzhVS1FRSGFCM2xpSmtvUlIrWmVtOFhq?=
 =?utf-8?B?TGhlMmp4a09xZFpaU2g4b3YxM1E4TnkxZjdleEtpN2VvMWxraDh2UEpLYXdv?=
 =?utf-8?B?WVZEWGZpSGVvTklyUmRLRjBhdEpHUXZzZXlQM1JJanRKano3QkxBYXpyMllW?=
 =?utf-8?B?MnJOTXN2MjNzbTRpQlNhdXNZdmc0K3NLZll5ajJtMG9Wc3pXRDZJWmU4dWJY?=
 =?utf-8?B?ckFVSnZVc0R1L2FHSW1TdEhkSVIzdm84b09jcEs2UURhZ2xtcDkxS3BYSGJB?=
 =?utf-8?B?T0lvTGtPQWxKSEZsM3cxK1dYVk9QT2NDU1NzbVl3eG9NbGxpTzdtUDVlL3lQ?=
 =?utf-8?B?NnFBSDMzZ1VuNDR3TzFVZC9oU1VpZm81eG44SkVDdUl1RlVvNGZsVElXZGNi?=
 =?utf-8?B?K0VIeXZuZURWcm5HbG9WTUw0NmswaWtwZXB2aFBuYU5rSjlmUXdCUTdZeWli?=
 =?utf-8?B?U0ZCMGhwMHluNkF6anJsTDIyTklkam55WTkvZU9tUWFPL3c5N3lNbzFLZVBw?=
 =?utf-8?B?OUs3UUdzMVlmNndVOWJXRERHaUVmZWZiZ29XZHBKeFNybzFxNmtXdDNodWty?=
 =?utf-8?B?bzlJclVtV3V5djVZQjhwK1d0WkM3R29JMlRNNStQV3YzaTBBUHgxU3V6K0x0?=
 =?utf-8?B?OTJhakJBNllDRVRxd1MvcDdUN1B3RmJOcWdwNDRMV2pUSDY0NWQwc0YvWXNm?=
 =?utf-8?B?c2NSaSt5MHdIOFNxMGtTN091TUUwc2NPM3Zmek8wdks1SEF2NVhCT24rSzB0?=
 =?utf-8?B?ZHZPS0owK1pKVGRUMkp6U0FDNDMwM0ovc3FJL3JmVm8ySGY5ak8yK2RuTVlM?=
 =?utf-8?B?QVBjWW9PN1ZmMFovdVhWV25mdG1tSkdSdWJDUnBTenQza0pBeFVaU3VHSHV3?=
 =?utf-8?B?UmdGamtOd3hTYitObC84NFgzRGpGalEyZ2toS01Hcms3S3pFcjhqVjArRkNY?=
 =?utf-8?B?OW1SVkxDcitjSXpldmVyWGNnenRCSFpTRnpkWUM5OWl4dURUTTl5OWhoUUJ6?=
 =?utf-8?B?UmFHN3oxV0hNeGUvekZGTTdQcklwYno0WXNWZ1RvQ3lKcFV6S01DanVvNWw5?=
 =?utf-8?B?R21NTm5KZWp5R0hUTTRsK1c1NyttUkQvaTRwbWhGdTNBdTJiVmhaNVJzaDZk?=
 =?utf-8?B?QWFOQWpBR0dBdENtTGZTV3lrSStCUnd5TDRnSmxZWFNKMWtvbHFpZkxzLzhT?=
 =?utf-8?B?MmNjYXNUSlhrN1BYRWY1TmwrckF1a29Pa1dUbkZUNjJqaStLSkYwSmNWbG91?=
 =?utf-8?B?bWVuUTlieWFubGplMXN2c0VyYzBGOUl0emQyTlIwdy94cy8xNmFMSis3aVhp?=
 =?utf-8?B?TnBTZ3dkYmkzZjE0WkJJbDZmWVk4QmNaNHZzbEc0L3loOTduWHBhMk9vUmlG?=
 =?utf-8?B?UXNoaFova3V6TkhjcytqSmdEOEpZOUovTFU5dTVuQ2JtbmlwcGRjcGJjYUMv?=
 =?utf-8?B?bW1TTjR0QkRSMHdkcFFnYXBidkxJZTRwdGl5SmdJbW9EVjNNbkpwczhPWVp5?=
 =?utf-8?Q?S7oBzm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:02:12.8399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12ebe89-9011-4621-6779-08dde1a60574
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446



On 8/19/2025 10:53 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:21 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add functions to cxl/core/pci.c to manage the cache of a CXL.cache
>> enabled endpoint. Add these new functions to sysfs attributes for
>> userspace accessibility.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> Documentation/ABI needs something on this.

Yeah I'll add it. Skimped on the docs since it's just RFC at the moment.

> 
>> ---
>>  drivers/cxl/core/cachedev.c | 99 +++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/pci.c      | 89 +++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlcache.h      |  4 ++
>>  drivers/cxl/cxlpci.h        |  6 +++
>>  4 files changed, 198 insertions(+)
>>
>> diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
>> index 1cdd94520ceb..85989cdd1eb8 100644
>> --- a/drivers/cxl/core/cachedev.c
>> +++ b/drivers/cxl/core/cachedev.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/pci.h>
>>  
>>  #include "../cxlcache.h"
>> +#include "../cxlpci.h"
>>  #include "private.h"
>>  
>>  static DEFINE_IDA(cxl_cachedev_ida);
>> @@ -125,9 +126,107 @@ static struct attribute_group cxl_cachedev_cache_attribute_group = {
>>  	.is_visible = cxl_cachedev_cache_visible,
>>  };
>>  
>> +static ssize_t cache_disable_store(struct device *dev,
>> +				   struct device_attribute *attr,
>> +				   const char *buf, size_t n)
>> +{
>> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
>> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
>> +	bool disable;
>> +	int rc;
>> +
>> +	rc = kstrtobool(buf, &disable);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_accel_set_cache_disable(cxlds, disable);
>> +	if (rc)
>> +		return rc;
> 
> Can return 1 which is unlikely to be what want.
> 

You are right, will fix it.

>> +
>> +	return n;
>> +}
> 
>> +
>> +static struct attribute *cxl_cachedev_mgmt_attributes[] = {
>> +	&dev_attr_cache_disable.attr,
>> +	&dev_attr_cache_invalid.attr,
>> +	&dev_attr_init_wbinvd.attr,
>> +	NULL,
> 
> No comma.
> 
>> +};
> 
> 
>> +static struct attribute_group cxl_cachedev_mgmt_attribute_group = {
>> +	.attrs = cxl_cachedev_mgmt_attributes,
>> +	.is_visible = cxl_cachedev_mgmt_visible,
>> +};
>> +
>>  static const struct attribute_group *cxl_cachedev_attribute_groups[] = {
>>  	&cxl_cachedev_attribute_group,
>>  	&cxl_cachedev_cache_attribute_group,
>> +	&cxl_cachedev_mgmt_attribute_group,
>>  	NULL,
> No comma
> 

I'll remove it (same as above)

>>  };
>>  
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 2279c2690c59..667f75043f9e 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1232,3 +1232,92 @@ int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds)
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_accel_get_cache_info, "CXL");
>> +
>> +int cxl_accel_caching_disabled(struct cxl_dev_state *cxlds)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	int dvsec, rc;
>> +	u16 ctrl2;
>> +
>> +	device_lock_assert(cxlds->dev);
> What took this and why do we need to check?

It's taken by the function below and the cache invalidate function. Though looking at the
patch, I put the guard in cxl_accel_initiate_wbinvd() in the wrong spot, it should be right
before calling this function.

I'm checking this because it's exported and I expect it to be useful for type 1/2 vendor
drivers.

>> +
>> +	if (!dev_is_pci(cxlds->dev))
>> +		return -EINVAL;
>> +	pdev = to_pci_dev(cxlds->dev);
>> +
>> +	dvsec = cxlds->cxl_dvsec;
>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return !!(ctrl2 & CXL_DVSEC_DISABLE_CACHING);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_caching_disabled, "CXL");
>> +
>> +int cxl_accel_set_cache_disable(struct cxl_dev_state *cxlds, bool disable)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	int dvsec, rc;
>> +	u16 ctrl2;
>> +
>> +	if (!dev_is_pci(cxlds->dev))
>> +		return -EINVAL;
>> +
>> +	guard(device)(cxlds->dev);
>> +	dvsec = cxlds->cxl_dvsec;
>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!!(ctrl2 & CXL_DVSEC_DISABLE_CACHING) == disable)
> 
> Maybe FIELD_GET() is cleaner than the !!

Sure, I'll change it.

Thanks,
Ben

> 
>> +		return 1;
>> +
>> +	ctrl2 &= ~CXL_DVSEC_DISABLE_CACHING;
>> +	ctrl2 |= FIELD_PREP(CXL_DVSEC_DISABLE_CACHING, disable);
>> +	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_DISABLE_CACHING,
>> +				     ctrl2);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_cache_disable, "CXL");
> 

