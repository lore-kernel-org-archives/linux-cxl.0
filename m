Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B783A1E84
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766007867; cv=fail; b=MuSXEfg5JbCz52StVgkfjgmGDcETkSwZdQ+HbV//MkNm18+JAHwvduaWeQueR/j9k5vserR6Bq+3J4Ka4Uyy2lsrbTFaAzm5pOlGc1d467D8jQTli78BvXNGXhOgEu1ExDCVK+KcgQgiSjRhNxqhfV6FX/7BdTQKtxnyY5De6Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766007867; c=relaxed/simple;
	bh=9ZKHHaZon4cP6zafJdVVlbPuXzPHQ6rnfP5QYD6TF5Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ge7YY7eHcPEWRfRaLOVd8cS+UWE9vD73sxntZnnPbWtQssOxuTFAFgDZv83U1e6MOXuMdNm97I5KNYnRdgG9BEdEWs9pBopM4YuycE7a7eE2iWfehvNo6WKB9yGkneuQWFL39bZ1O8AgOa3SKqHkrbQeOp5imwsylCRs4IwlF6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vawzRh08; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vawzRh08"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lov4Rrua8h5tAi5ZzxjRZes7DX2kRH/KPSdfR7KhQH7XiqlgRmS0g82JP8D5OWvtYp7vGd0Bxn2lFVWyltGo6vltm2gadbiEIb7h/+cc7zYSNTY777MDp1c8qFcbSDU7v3m95HARyBVTtnmO5SwvWYBSaeETf4hfyMz/aGRS8qS/3NjCI89L66ZbcnTM2FU1wyZ0g+hMkcihNLj2qkJNpi3caHluYyrRi0drPfhH4zJAXUMF+01dbHBQ8KzlAIh8KO8dKZj4GFzec43xxA4dMs7wytXjx10vu3I5YcfpyGUS9RYijP+cpsmMWkrMcQv/eYcLvz3Cg1pc9FwZd+haZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRryauXuRQ3SESqbWrZOjHze7wRQo5sHxFQ9rUlixaA=;
 b=vrzdP/mN4oUJONhBD1cxoAw2cmNetLaJLd8RqVtu+aPYPUf977QEnYEKAeK9GN/bXgnjmBqOk7fBaOGGThO3ANy9D45FSklC8na4pnGGkxsEgS7Fl0pdQ3YtGXvHfeCI/hF8uFlW1ITxhZXjd6ZEr/bFibNS9RQH/rtwdTXu4adAnniBl8e88MO+vGELxQ8tyQZZ/mw2KtjFLD0oDe6UYANtg1HdodWAm9R954wEXr8fX+6Y0NhHA/FDBfquED/KU1x42h2OdE2t53s2xihXmF2p/u0Xce9qPJDMXM+aP8qU8/Wl4Pem7IQ2bw7yBwCNKgctHG0Gg78HkWA6guv6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRryauXuRQ3SESqbWrZOjHze7wRQo5sHxFQ9rUlixaA=;
 b=vawzRh08d6tuYrp4L4Ntsr2LeSr8ybuil5dfxGLtZ/ywtD70SkWnrrXa2Rqb91dGGZLZBhFUHtxBV4kCVbPg0puPtfEEcyMu8xYf/FE6P2/T5DmzHNU+tRP5oo3eql6OI9oAABfZgqw4z99DUSOtcsRzyWNq3KBIflvi7fcgDUA=
Received: from DM5PR08CA0035.namprd08.prod.outlook.com (2603:10b6:4:60::24) by
 MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 18:10:41 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::d7) by DM5PR08CA0035.outlook.office365.com
 (2603:10b6:4:60::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 18:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 18:10:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 12:10:36 -0600
Received: from [10.236.188.135] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 10:01:30 -0800
Message-ID: <e1ac295a-d184-4672-b64f-e0ec06561bf6@amd.com>
Date: Wed, 17 Dec 2025 12:01:24 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 03/17] cxl/core: Add function for getting CXL cache info
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
 <20251111214032.8188-4-Benjamin.Cheatham@amd.com>
 <20251217160937.000021e9@huawei.com>
Content-Language: en-US
In-Reply-To: <20251217160937.000021e9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 26dd2288-bd07-4c6a-a5d2-08de3d9795f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REpnd3J4T3VnOFZYMkJlRTgwaEtLbk5VN1IwYkg2TElsVnA1Tno1VnB4SkE0?=
 =?utf-8?B?WkIvSUZZR1VQamkzcGhUeWt6TVJsK1lsb2dKZWJGRXBMbWcwTVdYZzVZak5V?=
 =?utf-8?B?bmNKUHVLNlo3Vy9pVVRQbFEwd0RKdU1uNVNxVDNzZEJYekt6TGJwbHgzUitH?=
 =?utf-8?B?a29jZUNCWktNSjJtcnNRVEE4eGYyM1ZwWDlqT01heGhMaWxLWjM1UEM2Q2Jo?=
 =?utf-8?B?d0xwb0FvRngrZGZaa0RpdGU4b1UvOE9OcEx5RS9YY3AvLzhjbzFJZlhla1ZI?=
 =?utf-8?B?VzFJVlFKVzhVbC9mYmhUc2JCNkdYYm5DbXdKb2phYXNQK25jOUZFM1JXc2JL?=
 =?utf-8?B?aWtCTTRmdmZkb3NoRFoxaWt1amltaVczWnRwR0QwNEd3RW9UWHJiOWFQOUxh?=
 =?utf-8?B?TDdoRVV0bkhVQVZMZVdnUUpvNmdCdUgybE9PWFNCWkczM2xVc2YybDQvSExl?=
 =?utf-8?B?K1Z1bDdCbVRsNzBITXhSZmxRNGV3Vmx2ZEdmcVgrNWRiSFBaazVMYjd4ZWJM?=
 =?utf-8?B?S3FSQU5rMU5ZM1FHVUh0aS9EQ2hjN1doZzg4aHFmRHFTWDVRekpwTXY0czRP?=
 =?utf-8?B?MWF2dm5pc0tQMk4zbFcwQno0VXBUUUJNOC93eWQwNy9yTlJoVkEraUwwMVRp?=
 =?utf-8?B?R1pDY25jS01xN24xZVZLcjJOd2VIY01UeitOS1ByMFhZKzliaTNjKzlCOHhQ?=
 =?utf-8?B?clgyZS9ibUoxY09Oa1RidThUWEkwbUhVektQWlJuYy83cHdmdnhCeHBnTzBK?=
 =?utf-8?B?czQydXdOdkxXMTc4T2Q5aEZSSjR2T3Z1ZEdKZjYvTG4yZ2Q2NldoakRVNGp0?=
 =?utf-8?B?R2I2enR0bG9SbU9lOWhXQWFYMmlNb2RKUy80Q00yK2txYmtGM1Z3cWcyQktI?=
 =?utf-8?B?VTNUSGVDdHN2c1N1RWJ1T2N1SmRQbXk4c2NqRXJiMFZTVUhxM2FxSEJObXZG?=
 =?utf-8?B?NWhHSXJFcWY2ak4xb1c4LzZtNS83RFRuWGJ3dk4xZ3NMYXMwNnNhdmhVaFpa?=
 =?utf-8?B?aFJ4Z1pOOTFFU1VCR0NVQkVSZEZUK2tmcWpka1ZBTnBrNi9mRXJ4MmV2WlJs?=
 =?utf-8?B?eVFZVzQvWG1aSWNyS0tHTGl1dC96bGhFYllKNWZrRnQ0cUNxam82Ri84bTVU?=
 =?utf-8?B?S0w5SnMwejZ2d1lMdERtRGp2RkJwTEhXWTlnUWtvSDB0WmlWRGhPN0NqVmNY?=
 =?utf-8?B?QXF2dThKMTM3aXoxUEpVa0txMFpyV0RnTGtsSzNMZXRvdFVZdmpGaUNwYjNo?=
 =?utf-8?B?UTFUQ3BEaEVENW9IdjRuV0ladVhFeXF4aWlFMmhXaFppZlE3TmpWREkxMVlV?=
 =?utf-8?B?NUNwbmRSUWdkMHJqL0VJSnNJcm9PcTdPWHBza21PNXVZQWE1TVE2TEwxYjZ0?=
 =?utf-8?B?SWtESE1hZlpHTTNjZU55bVY3YjRpUHR5UVhFajN6aThLTEt5WHZObHF5b09k?=
 =?utf-8?B?VVJzcFlHNlZWQ1ZwTGtrcVhXbHhidStGZTl4Rm1yb1Y0SmxZSVBDWVkybzI5?=
 =?utf-8?B?K0N6OFlMbmEwZXRNKzBUWEl3bU9ZamJqT25BMytNOEZRYTlTQXBLbnNSRlRX?=
 =?utf-8?B?Zk9wSkRHbnQybi93NzBaNXZnTjBiaUZ6Szc2b205NGRISFBDZVV0SE9sWTF4?=
 =?utf-8?B?M1NOMEZvNXdHRGpLMElGamhSVTJzU3NKUUhuNlZSUEh0RGxYc3k1ZlFVVCt6?=
 =?utf-8?B?eXVWNDRlZksxOEo3a3kyYlhORXlZVm55TWFrNmdIVU9qR0FDSGpJdmFheWpO?=
 =?utf-8?B?ZG9wWWFOMXRFdkl4SlhieCt6U2xTQVhJZGFVZWtsTk00VGVwTHVFanNEeVZE?=
 =?utf-8?B?SHVCczN5dVBqQ3FGS1NuZmFqTGYvZTh2eDNPRUFjdUxRNER3ekRWU0FLWDRU?=
 =?utf-8?B?cWFReExxKzkwbE5oa0d4VnFweVJWd0NrRnpOWnNZODNxcXhzanBwQkp5QlVQ?=
 =?utf-8?B?cGlPNEk4SmZCdzJoaTh3TkVSb1liS3JkR1EvdjZxNzk4eWhMTi9JeG05bFpE?=
 =?utf-8?B?eXVnYzQ0bjdNYlVEZEJqVlc0blZkbUtudWZDL2Z5dmZ3Q21XaDNDczlteXFr?=
 =?utf-8?B?VVJySWQwR1FTMmRxcjdzLzcxd2NLelc4TENXYUZvMFcrWUlRaEZwQzFqQTZE?=
 =?utf-8?Q?VAYk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:10:39.7595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dd2288-bd07-4c6a-a5d2-08de3d9795f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085

On 12/17/2025 10:09 AM, Jonathan Cameron wrote:
> On Tue, 11 Nov 2025 15:40:18 -0600
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add a function for getting common CXL.cache information. This
>> information will be stored in the struct cxl_cache_state member
>> (cstate) of struct cxl_dev_state for easy access by endpoint drivers.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Hi Ben,
> 
> I'm only having a first read through so probably only superficial feedback
> at this point.
> 
> We have so many major series floating around I suspect this will be a cycle
> or two anyway :(
> 

Don't worry about it. I figured this won't be ready for a few cycles regardless :).

> Anyhow, comments inline.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/cxl/core/pci.c | 53 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h      | 13 +++++++++++
>>  drivers/cxl/cxlcache.h |  7 ++++++
>>  drivers/cxl/cxlpci.h   |  4 ++++
>>  4 files changed, 77 insertions(+)
>>  create mode 100644 drivers/cxl/cxlcache.h
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 18825e1505d6..5b1cace8fc0f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/pci.h>
>>  #include <linux/pci-doe.h>
>>  #include <linux/aer.h>
>> +#include <cxlcache.h>
>>  #include <cxlpci.h>
>>  #include <cxlmem.h>
>>  #include <cxl.h>
>> @@ -1258,3 +1259,55 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>>  
>>  	return ctx.count;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_possible_dports, "CXL");
> 
> Stray change?
> 

Yep, I'll remove it.

>> +
>> +/**
>> + * cxl_accel_read_cache_info - Get the CXL cache information of a CXL cache device
>> + * @cxlds: CXL device state associated with cache device
>> + *
>> + * Returns 0 and populates the struct cxl_cache_state member of @cxlds on
>> + * success, error otherwise.
>> + */
>> +int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_cache_state *cstate = &cxlds->cstate;
>> +	struct pci_dev *pdev;
>> +	int dvsec, rc;
>> +	u16 cap, cap2;
>> +
>> +	if (!dev_is_pci(cxlds->dev))
>> +		return -EINVAL;
>> +	pdev = to_pci_dev(cxlds->dev);
>> +
>> +	dvsec = cxlds->cxl_dvsec;
>> +
>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!(cap & CXL_DVSEC_CACHE_CAPABLE))
>> +		return -ENXIO;
>> +
>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP2_OFFSET, &cap2);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* CXL 3.2 8.1.3.7 DVSEC CXL Capability2 for encoding */
> 
> Given old versions of CXL spec tend to become hard to get, probably
> shift to using 4.0 references for this series (this probably raced
> with that being published!)

I wasn't aware that it was published, so that's the reason it's still 3.2 XD.
I'll update them for v1.

> 
>> +	switch (FIELD_GET(CXL_DVSEC_CACHE_UNIT_MASK, cap2)) {
>> +	case 1:
>> +		cstate->unit = 64 * SZ_1K;
> 
> SZ_64K

Will change.

> 
> I'll comment on it in the sysfs abi patch but I'm not seeing unit
> as necessarily something we need to keep around once we have
> used it to interpret the size.  So probably local variable is fine.
> 

I'll address this in the sysfs patch.
>> +		break;
>> +	case 2:
>> +		cstate->unit = SZ_1M;
>> +		break;
>> +	default:
> 
> I wonder if there are devices out there that simply don't tell us
> (so case 0)?

I heard of such a device yesterday as a matter of fact, so I need to update this.

> 
>> +		return -ENXIO;
>> +	}
>> +
>> +	cstate->size = FIELD_GET(CXL_DVSEC_CACHE_SIZE_MASK, cap2) * cstate->unit;
>> +	if (!cstate->size)
>> +		return -ENXIO;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_read_cache_info, "CXL");
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1950cf3d5399..259d806fb3e3 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -759,6 +759,17 @@ struct cxl_dpa_info {
>>  	int nr_partitions;
>>  };
>>  
>> +
>> +/**
>> + * struct cxl_cache_state - State of a device's CXL cache
>> + * @size: Size of cache in bytes
>> + * @unit: Unit size of cache in bytes
>> + */
>> +struct cxl_cache_state {
>> +	u64 size;
>> +	u32 unit;
>> +};
> 

