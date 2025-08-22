Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55182213E9F
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885657; cv=fail; b=m7oVnsbHM/4ynMXvfVBOtfCkQZvhSareN67JlC9tdsavdeSnoWTTNiH4cl4vR5KE0LE9lehRHn3Ryab8TyZHaCngDVPxcdpBqaNAE+uoS7tyaq3KJnlxy9/sLhcchQvw8HpjQp1UR86mB1qwZcz4H7fuVNIgn13KPsoUnoba5M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885657; c=relaxed/simple;
	bh=DMOwkatCpxP0QxDHZXZZS7eEcXrgHt34H9wzwqFnx+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hdw0WRq6MXBLYhmyptIX+FmHnlbaVJ/FmCLkzxPhj+GG1Bt5x3g/zG9Tf9TL0S1vFPV18lRq2WhEE3ltqoN1wCdr0UDrAdL3SNbr4SsfAbnyXM2x3bvPLAmWQ+mU3gkkvIxbowXPB1tt7oshkus4oDlUemZKk6dPshWG+ryUghk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RwcNMTow; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RwcNMTow"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJzuxC7rCLOK3CC8J/BBAOl+CCl9oq/4m3t7P/+ilw5EZKEJHqnmhAltV4+qavCoTkHaxr3e3LvQSS32mPjBOMD7DpoZIEybKpQpiDdQPWg5otf81difuY7qK9Md0Y2d5+4QzNr+cnhbcjioT2VqGB6rpHrAfiN5Gsl4XtM0O/C23dVOoEdlWer3ln5l+nsCLtDziN7KP1UAhtaAJrmnTuBP8BlSJNX0bxtNRuR+auGylxl1y3XiLo/Un1R1fx63l68hP5fjMpBT83VWYISUOhHZtMVEUWZ+ShIiVzkF2QNTipi8l60ZYMyQaHYQR8HWj214L2oNl2qci7DB29Iy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpsS6gLAR66JAkdCdUL8FKMhwmerACBvR1LfYuEEMa4=;
 b=LK/aHhRO0Etlos4F2hm+65NDlbmKd9MJgs8uTIj19jcQGbS3ELcc9rtrJNzzASpaISK61xQSwu+yeFoZFVuM617CPVwkWDqSIOqm4R+f1CmLDQ8VRUagbDayF37ixcSFNUVgtaiRU+FgGg9JkBM1a+eVdYSf73POYbxL5WNktY2q4BIbNFIfC3GcQUDwRCaT9E134gcg7c6WO3fKHI1kMDcajxCj0EJ4yxZLpBc4lgN0+5rXWyF8kYLpRL55JEnwIbG61EeP8gLH7hU0XLflrOs2au1OP4uSZpOiBNq7xtxQjmWYd7EBtj4qT8478s1nv5R9xMSX/AZpjNh71yk16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpsS6gLAR66JAkdCdUL8FKMhwmerACBvR1LfYuEEMa4=;
 b=RwcNMTow/BdtxNWbzgsJtF+AUjjBPvZNTEsd8LZ1PW2oScSX7on5ogWHh0/4Kl9VUDa+Er4jiuN8HOTuygIcIlm47pJ5mdXQW9a48PciYbzRGzmZsr1sohlMntd8oF7pFJ2t2dfBaaZkoK8XICC8+Dl8NJCG/2l+cu0PhwkMS38=
Received: from BN7PR06CA0064.namprd06.prod.outlook.com (2603:10b6:408:34::41)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 18:00:49 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::5) by BN7PR06CA0064.outlook.office365.com
 (2603:10b6:408:34::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 18:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:00:49 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:00:48 -0500
Message-ID: <10efaff4-4f86-4a6e-9976-7e980e46884c@amd.com>
Date: Fri, 22 Aug 2025 13:00:48 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/18] cxl/core: Add CXL.cache device struct
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-4-Benjamin.Cheatham@amd.com>
 <20250819124808.0000670f@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819124808.0000670f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 76732ac5-a4dd-4d79-3a6c-08dde1a5d3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmUyTEdpTnNIbWxMem9CVjR1a3JycDAzeTBkT1ZuaWFmU0wxemNSbVRobFBF?=
 =?utf-8?B?U3lyb1hIR2haa080ZytTTkx4YjJ0RitoOW51ZUhPTzJ2QlB5VE83TWtCaW05?=
 =?utf-8?B?Ti8yY0F4MWNyeS9laGJabC9Ld2I2Y29ialdheXpMMElxTlNVNTlXbDZnWmcr?=
 =?utf-8?B?a1JsOXNvMU1ObENnSFNReDJwVjdsWGFScytkbEJ5ZXlsTUIweXNyb2Z1LzU0?=
 =?utf-8?B?bWJPVU1oSVI4b0QxV2pBcVNsVEt2eEM1K2pkdTkvemlNSno0dTFGQ09TMjZu?=
 =?utf-8?B?VDZYQzVEaHJiUkcyNmZsdzlrSVZEcS9UY1V5U2kzeGc0cFEvY2Q5ZEVuUTQ5?=
 =?utf-8?B?VXdZTmk1NkkyWjVPeFAzQnlzTjBvaTBKNGl3L0NNQUQ1TTJ1bkZ1QXplaXhv?=
 =?utf-8?B?THIzUS9vZ2JyWjBCakJNelFPSElhNWlDYlBCQUY0enJ2Ym53cGZYNytWcXZF?=
 =?utf-8?B?Y0k3RlZRWXFRR29sUEJZMlkvMlJ4TWsydjhTV2s1M3k2TktqS2JQVGc2eUV3?=
 =?utf-8?B?emxUVHN3NkdzSFFYZHhIazF1YWgyWEtyajByRWN0cGZ0WDZnVnhJekJwTFV5?=
 =?utf-8?B?QzNmc0JzalIvQXV6RTdMMXdHa3c3U1BQNjlBUDlnQlA1Z0VQbXpNcXdPUy9W?=
 =?utf-8?B?TUlCMXNGQ3NYd2gzRjJDTlUzY1kxZTF3L0N3MDhoNHcvOU5idDB3MTZ0ZlJ6?=
 =?utf-8?B?T1pNVVk3K3Q2WGIvZ0dqbEpvOGpjZmk1SDVlci8rOXE2dERUSzE2bG5kRVho?=
 =?utf-8?B?K2NpMkZlcVBVc2lnSFNlMkVZQkFLRTRyTDhEOERZV0xLL0k1ekQrTUpZU3FK?=
 =?utf-8?B?VyszenFYV0dZbXdQMzYzTW5qRnRqZFVDT0F0RWRuaXBJUkM5UFA4LzZBQThB?=
 =?utf-8?B?WGNYT1l1MEVrT25lc2oxZUJVTU5ITHowOTlNMnFBc1dDRGVtVUdiZG1UZUYv?=
 =?utf-8?B?aWQ1SW1oZ3BsUGdVb1FZRzR6UkRBY0dQS3FEREdiYWZtT2xyckl3dEpKc01F?=
 =?utf-8?B?RjFrUkNmckNTNWR5bGZDRXQ1WHkyTCtyRCsxU2NlVnVmSzF3MFcvQVMwcmE2?=
 =?utf-8?B?dVUyVjFWYVJFNGpHakhsRkpIaGFaM1lLNnlIMWlSM2V1cCtpcnRSQ0JGMldp?=
 =?utf-8?B?V2wrK2Exb1NUMTdYSG5WL2tkQXVuZ1QwYzBQY0hxSFpoRURDWEdPREFCN1BK?=
 =?utf-8?B?RDFCdjh4c1ZmUmptMDZ3SExFdC9mTUpXQzlEZUNhbGxWM0dyWmRMcXhkcC8y?=
 =?utf-8?B?UTJ6MnRSQ0NEL2RKU3pjRUhuOVFzcGxXaTdsQ25IVXFtY0diU3FJYzlCV0FN?=
 =?utf-8?B?NGdQeDFCYXRQZ1JVajdZZlhJNTNiMm1JZE0xWVRMUktjV3YwMVl2ZURNLzFl?=
 =?utf-8?B?eExTVFRIQmV6dUlUcnA4ZVQ3eUtJcXNuUE9ackpjem0vSDZvdFBWQlpnZkZR?=
 =?utf-8?B?dndmZzY0RWRFNldlMDhJaXVDM212cXNLaGlkSC9NamZweS9FSGFzSUlOMDY1?=
 =?utf-8?B?WnVqU3I4UGZSOUhCa0N3dS9jaUZJWUptaExXNXo0OFAreUN0OHE1RkFMWUwr?=
 =?utf-8?B?QUN1R0wzVENEUTI4Z2MrZEF1NUJxNFIyeHJGQ1FJWnRiaS9tb0tBSEg2Y1pU?=
 =?utf-8?B?WG8wT2owMCtkMEJ4SFd0M01aTWNGYWVsS016VHFEU3J5Y2wzRnoySEhKZ3pp?=
 =?utf-8?B?Y2dNTm04VnpxQy9SRkV2VzdXb2pPZldKeFBYZTBZWWVYZ2luRlJYUWhSZmtV?=
 =?utf-8?B?UnFDQ2dKYVhRcDAvaWFHSmE1Z043cUNjSmRCQyttOVBiTzkxZW5YR1RESUZ2?=
 =?utf-8?B?ZXhyb0F2MnlxYmV5akVNdDRjZGJHTVdpZFo1RWJzSjZYVVVXUFlIWXZLc2dH?=
 =?utf-8?B?SWtxWXp3Si9CVERpTkoxQWZYcFhIVi85RUs3aE96NmJIcGxWazRJMExIR005?=
 =?utf-8?B?SDduaEtTLzBFOUxSZFl5Q1hFQ3ZWczljK0hIdTlWMTRJV1E5NXJWUEtaS1ZL?=
 =?utf-8?B?NEVLU1kzTnBwbTdBWGVnSEc2NnhjT3hBZVl6SEVYdnAyL05QYXZwdEFXT3V0?=
 =?utf-8?Q?kc1X/Y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:00:49.7186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76732ac5-a4dd-4d79-3a6c-08dde1a5d3e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257



On 8/19/2025 6:48 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:06 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add a new CXL.cache device (struct cxl_cachedev) that is the cache
>> analogue to struct cxl_memdev. This device will be created by
>> endpoint vendor-specific drivers to enable and manage the cache
>> capabilities of the endpoint.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> Whilst this creates the device it never adds which seems like an odd omission.
> If that's intentional add some more text on why.
> 
> Jonathan

Yeah, I just wanted to keep the size of the patch down. It would probably make more sense
if I moved this patch next to the patch where these devices get added (10/18 IIRC).

I'll try and squash the two together (or go more fine-grained if it's too big).

> 
>> diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
>> new file mode 100644
>> index 000000000000..aaf4a1b94178
>> --- /dev/null
>> +++ b/drivers/cxl/core/cachedev.c
>> @@ -0,0 +1,91 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (C) 2025 Advanced Micro Devices, Inc. */
>> +#include <linux/device.h>
>> +#include <linux/pci.h>
>> +
>> +#include "../cxlcache.h"
>> +#include "private.h"
>> +
>> +static DEFINE_IDA(cxl_cachedev_ida);
>> +
>> +static void cxl_cachedev_release(struct device *dev)
>> +{
>> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
>> +
>> +	ida_free(&cxl_cachedev_ida, cxlcd->id);
>> +	kfree(cxlcd);
>> +}
>> +
>> +static void cxl_cachedev_unregister(void *dev)
>> +{
>> +	struct cxl_cachedev *cxlcd = dev;
>> +
> 
> It's not doing what we'd normally expect in an unregister
> as no device_del()  Which is fair because it was never added below.
> 

Yeah, that's an omission on my part. I don't think I ever actually added the device_del(),
will do.

>> +	cxlcd->cxlds = NULL;
>> +	put_device(&cxlcd->dev);
>> +}
>> +
> 
>> +struct cxl_cachedev *devm_cxl_cachedev_add_or_reset(struct device *host,
>> +						    struct cxl_cachedev *cxlcd)
>> +{
>> +	int rc;
> 
> Odd to not have a device_add() of any type in here.
> Maybe introduced in later patches, but I think you need to drag that into
> this one for it to make any real sense. 
> 
>> +
>> +	rc = devm_add_action_or_reset(host, cxl_cachedev_unregister, cxlcd);
>> +	if (rc)
>> +		return ERR_PTR(rc);
> I'd throw a blank line in here.
> 

Sure.

>> +	return cxlcd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_cachedev_add_or_reset, "CXL");
> 
> 
>> diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
>> new file mode 100644
>> index 000000000000..3ccbeba9fcd6
>> --- /dev/null
>> +++ b/drivers/cxl/cxlcache.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef __CXL_CACHE_H__
>> +#define __CXL_CACHE_H__
>> +#include <linux/pci.h>
>> +
>> +#include "cxl.h"
>> +
> 
> I'd add docs from the start.
> 

Will do!

>> +struct cxl_cachedev {
>> +	struct device dev;
>> +	struct cxl_dev_state *cxlds;
>> +	struct cxl_port *endpoint;
>> +	const struct cxl_dev_ops *ops;
>> +	int id;
>> +	int depth;
>> +};
>> +
>> +static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
>> +{
>> +	return container_of(dev, struct cxl_cachedev, dev);
>> +}
>> +
>> +bool is_cxl_cachedev(const struct device *dev);
>> +#endif
> 
> 

