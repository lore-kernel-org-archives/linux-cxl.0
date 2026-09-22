Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296A544D7A;
	Tue, 22 Sep 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086070; cv=fail; b=Yi6J/flFGUy5ennTtVqDi4fxL/QbD1sEzyOPFqzazsKG/w6daq2VY+ogGMhJUbucU37/FMMZMcbSIslb6XA7P1lLVJdhj+fu7GPaWWhNng1YL4NG65hX6LkwXHDcisQAAjF8VM+fxQhqxDUl62zFpihkFPlKyTU9cmJQ+I7/IUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086070; c=relaxed/simple;
	bh=kHKyOvvg1aFzPqnGRIgq8MwfGCmiQsz8VoXnySE20JI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pLg9GFTpesHoNzEfMWlemvczLIqumV97zVYV+NNExkIevpkma99/lP3XQHFfScnLRcz81GlOncZIqUdardtfaRSDL6+FjUXGcPfTOX4RYvsRYH1PSgdgzJLv8T1pDmprX8ZPRntBxHxIHCFVGD84YjYhUHpYfz/tPs3Ovx372qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dD1azZkZ; arc=fail smtp.client-ip=40.107.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dD1azZkZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfrhJcW8b0RLl6vnuNWq7zLU9SzYCrjYm1g4vgqPj6Cq4GBZgna7EpBwoSJzH8PMdT0xqcGo3wklHJgElL+HttU+3yMRR4zGME8LhT3u3fvbjOLqYuUnJmMdKRu53rJZhAukvN+xGdvhP0qlRuUAOXc3lW2DQlJgQbpDdlALOFCDQJtOZ+t53avuy/g4wHJG6uSMFDgAsEMKvKFRBc0LQiOyJhjyYItMcYr+f5CplmUX/gC889MGPQNW01mEGIcsvu31UTajv80Th3+ewcnIp3oXoAZFidV/bQx9KALLpeV5BFq9N9ip9lvTkzwFYZmIqRVzsMUs19zuOrqXkdOeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Lx1oHG+at4NY0GWBhJ1VLW8zUlMaHYWXoeJlz8uxzg=;
 b=aanyl80/FydxSbZlgFyWHeRSZCzZR6TKMSHgrTfb/pA0hNtgylYjtkFEnaSrgBqv5cRmAB+3zrukooukt2/cuXNdOBQNU0gb3VORaSeYDgeJuaflCV5pDd9HjpSzF62v9JOTtagtNZ6hbZQ6uyUU7UwyH7rvb1DmBkjmFjMHk+KnOBm4LdDp3FaiCdQULIOdDAVY+NdZCND1edpnso5zXyn4aoxapaFlZFDB0/TTuAKZLnnu62zQD2kbcOgtkQxChKKAWim1OpJm7HCJlnj+CPoxbphXeAFPe9gHzIcG/o9fyzh3IIKZVdtcoAVg/3I65jAKWuo12UkN5RHGTKVBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Lx1oHG+at4NY0GWBhJ1VLW8zUlMaHYWXoeJlz8uxzg=;
 b=dD1azZkZDRgj6+hce1eEAQ1wgb1uVR9yBU9GpLTdKdEoraKaOMsHWAJESgLNKznZUPIBGvXlzEsxdyfgaca75VX6A40THO8uePc0FRNCHB7cjrYRAO7sx8B2vRWl8DQnJiJ1rdgqTo5j1V6WdRAbecvYI555n5s9e2k8wns8ILo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.14; Tue, 22 Sep 2026 14:07:41 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 14:07:41 +0000
Message-ID: <ef577cb3-a89f-4918-9c26-312ed220eab0@amd.com>
Date: Tue, 22 Sep 2026 15:07:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] cxl/memdev: Add support for multi PF devices
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-4-alucerop@amd.com>
 <4d46bd37-1016-41a9-a810-66144be71ed4@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <4d46bd37-1016-41a9-a810-66144be71ed4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0038.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::13) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 104bdf4f-39e9-47a5-bff3-08df18b2dd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SjkRluBTIC4vthL8xbJL9AtEUtuQv9qkcbd9a/scyXhrC4nXpJogseiQkXKnxV7FPLzyYuUKR/S0QVintftVf1D3haUYoBION7SWZI8qlREbkGy6RZjTt/40q0b3+igLZ4Hnh5Ejui3wTVYaR5EKsYl1hSdu2z2RPRKGFyN5grO/zgVkRtXhtKK314Xi2L+Szj+TOERXbqzTR0RAU8eo04iobr/L2HEnd+4I2B6seUrpnKRPYvuFiqLXSBI7pUCJwJpclfrJWsJIkMcCeWuYIyVCiPxHBsErTHWMxk9A6q8PptplQ1gG3wUBzn7RfTXZsXnNETo9Or3PBlrR6XlQkpFtZT/W5giqqsSL2AxqD9c+nh6Wu4ZlNiUGFtP+hjk390Z0yivH5zrI4+GDQLSvfRy+2DnxHex82vSh06lZgVt+3r+BZpSoO7zld3qoUOkrnZjw4h03DaQm2L5ZnJiqMoTfRFouJASVCyTZdC0k7c+NxuX+vkZHNtFCNAjh0YFLE9C4sxx2LwyIvEQ4RKUhnBeTcZZsPNc2DhUdQJOVKYc0urbjRyu1I6LbQ8SxF7tJ1Z5ogze1Er3dRXQVO5cTcGEc0avhwcaJSiZteUrww45YsaVjggo6JxFLei/+c5RizifRhgrzER0CSi/C47cg1lQ5BrrnneOhPxm6r5D8TCE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFV2WmhMSEVTWHczWFZ0QnlEUmpEb0xkMEtIRG9NQlRvcUVQMk43Q1diZk1L?=
 =?utf-8?B?aVBwbGZkM0tONjgwU1JLMVVmbFRoT0orZGNZak8vNUhIei90NVpvL29xdTNC?=
 =?utf-8?B?TVp1THh1b2tZVVN2QVM1dDRNMFBMZGJVblIxT1czUHBWTDRwdXFpMGVnM2RP?=
 =?utf-8?B?ZnpBdExlaDMxaEN3ajhJV3NUZFJoQ0lWME9PU0pwMnh2ZWwvWG1IUEdZSzdC?=
 =?utf-8?B?VUFCaGdkWE9FUnBWQjQxOWNQUWZPbUNBYTZtV0NGZmwrZTE0TkZCc28rbzFH?=
 =?utf-8?B?ZDFORHp3TEdaS2ZlL3pFaUVNc3IyaGx0bXZnNjE5WG16U3BKN1NaYTZOcWht?=
 =?utf-8?B?UXR0WVluV0R1dmd5KzBQVGYyM2F5UTFYRGhYMFdPNUV3SlpRUEFTWXV4Q2NJ?=
 =?utf-8?B?VllWYUUwL3Ryd29jMWFyckJNbTB1NnFoQjJ5NTgra0ZFSWdEUzIxMTluSm9z?=
 =?utf-8?B?ZU5DT3VpeWhZVTBCbFA0UkFuaHFiNEhvY1JYSGdTOStIdXY1cmE5UE9wQlFt?=
 =?utf-8?B?NzVpa3BTd3c4dVo5dzZHWDN4aG95eml4aVRjQ2Uxem00eXhzaGVkWVphTzV6?=
 =?utf-8?B?bS9YMjZyTmxWOU1qRVIxbDQzZWxOVUgvVi84NXhWOXZVYktoWWs4NmxWVkY4?=
 =?utf-8?B?cWJwV0R6QVBnb0tPY0pQWk5SUS9paDNZR2pmVlBLZ043bEp1bVpYbzNSN01N?=
 =?utf-8?B?Q2NKWUdLNTVkUjN0ZmJHTjFQZkFjWE5wYThxWHd3QlkrTFNSNDhIdTZPcUx6?=
 =?utf-8?B?MHY1Y3RBcFl5cStvS3dpSXJaQ2dieUpIQVBHYXYzekVVY2M5eFZab051WmNk?=
 =?utf-8?B?ME9LOWRsbjZhTE54SURPc2xpRXQxWHNpMWJwQVVpKy94SFJzZ05Ib2Z1TDFU?=
 =?utf-8?B?a0hqdGNmY0lRYTJVUXA2NzlENUkwZXM5dGVVYktua1ZIUUw2cWpBUTc1VFpy?=
 =?utf-8?B?YzhLQm0zcGk0NEEwY3g5ckNZbWhRYXpzTFJxdjFaZlY2V2E3Y24xWll4QW13?=
 =?utf-8?B?Q3lmS21peGNIN3o4MDlaMHdvd2FwYWRVSFEzYnVHTERsUGhHcDExejRFWlQ1?=
 =?utf-8?B?eGlLeVJ4c0NiSWRwTE50aWpvQ2hSeXYyTFJaYlN2dzUycWpCejlVMmUxaEhk?=
 =?utf-8?B?S21uRWR0YjZVMjQ0V051TW8rbGhkK1VJNERud2pEOXdmeHZKaiswUm1NUGhx?=
 =?utf-8?B?WmFOb2NwNlRYTE1mRHF6dDJFRFg1N1kwL3h5bEJUdmJ6UWVIU1BHQmhJN1JR?=
 =?utf-8?B?UzYxRU5oemFBYVBqckdjRGRESkZIUHZhaExjOVg0TWMxL3VOazNxQmpCenR1?=
 =?utf-8?B?NndRZWhwT0o5YTI4NFZOSXdmMWpHWjIxWHllZlJOUXZRcTl6aXRWUXI3WWJ0?=
 =?utf-8?B?REUyeHB0Yk8zajczQlRFM2lmUGVMTDFVZnI0RmVoM2I1bDYvNGJwZmljR20z?=
 =?utf-8?B?ODlQVDl5TkNDQTlEVkpJS3hsQzhQb25FYTIwQ1lDWlpUcU9UYkJXblM3QVFk?=
 =?utf-8?B?dUhjb0RDaHlWMXdSSCtRaXRLamJtRDVIQysyYXlHcFd3OVorQWJNTUxHT0h2?=
 =?utf-8?B?c0UyVkpyZm43ZXNsQTRHamowa1VoSjJzYXhtVk83R29NcUVaVnE2VXRxTVFS?=
 =?utf-8?B?VGliYTU5Q0xvVGJEYWVKemdWS1IrODRteVRZVVNhTUxKem9QZzVvaGZ4b0pt?=
 =?utf-8?B?bEdmb2MvelJ6V2FOMSthNWZMQlpqdi9UeVNqbTBGQ1V2OEhvL01LZ1hzazl0?=
 =?utf-8?B?WU9peHZNY3hUdllNZWlhdFNqQVJWc3J5SkNiamhFaUNyNjJ5UUJyN0VlK0RW?=
 =?utf-8?B?NGJiZGRqa3J1QjJjQXM2NUxpdmllbU5aT1lwdDEyTzBvcyt2MmZ1QVl3bW02?=
 =?utf-8?B?bmJBSEdOWXJrV3hhWTVQZklJNGpJNUFiSnI3aSsydEc3V2hyZExnU3VrZkxy?=
 =?utf-8?B?UUhOaVBuM1huN3N0dzF0eDJrTW93VlpwSFdYTml5MngrbDRzWTFTYVlIWkNU?=
 =?utf-8?B?MC9LVHg5TXlhaXlvQ0phUWtQNThFaE15WnBrcVp5YXFHb3RaMnpVdWhCa0ZH?=
 =?utf-8?B?UzRmK3FqM0ZBUlQ2TFZhMURFN2lyempJVHh1aVlyOXhmSW5oa0NYUTV4OEpM?=
 =?utf-8?B?MlRUWDRySk1QS09mTHVjWGV5UFdSZVlYSEVLQzVlOTg2Z2NTcEUrb1p6TjMw?=
 =?utf-8?B?cWR5NkQ3OGxOdlB1SHFPaFRIYm1CNVFnWFovTWhRWHdzUG5MTjZoYkgvc0pB?=
 =?utf-8?B?dTBxYjU1Vjd4dHZUelhrQkpFdTNNNDY2UkNFajdrNzRvVnNTNysxa2t2YVBt?=
 =?utf-8?B?OVE2Q2FwcE5qeXFYTGJ1emRHSm85b0ZXUkY0NzVSeVV2NXNIR1ZGUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104bdf4f-39e9-47a5-bff3-08df18b2dd71
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:07:40.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k64m7ycmAJoYkn7qjkEr8lvaaoolv5+Ng2b8n9WIHiPZgUpuI2vpteA2D/EnSigzfbF4o7GJ1hZ7ICeBtxMsXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057


On 22/09/2026 00:07, Dave Jiang wrote:
>
> On 9/21/26 12:12 PM, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A PCI device can present multiple Physical Functions(PFs) but the CXL
>> specs restrict to the first one, PF0, the discovery and management of
>> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
>> obtain the CXL.mem range to work with somehow.
>>
>> Add a device link between the cxl region a PF0 memdev is attached to and
>> the non-PF0 wanting to use the CXL region. A CXL region release will
>> trigger such a PF to be released from its driver first.
>>
>> PF0 being unbound from its driver triggers memdev and region release
>> leading to non-PF0s being unbound first keeping the CXL memory use safe.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c | 66 +++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h         |  1 +
>>   2 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index b3419df586b9..67be02faa7e1 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -802,6 +802,72 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   	return ERR_PTR(rc);
>>   }
>>   
>> +static int match_memdev_by_parent_device(struct device *dev, const void *data)
>> +{
>> +	const struct device *pf_dev = data;
>> +	struct cxl_memdev *cxlmd;
>> +
>> +	if (!is_cxl_memdev(dev))
>> +		return 0;
>> +
>> +	cxlmd = to_cxl_memdev(dev);
>> +	return (cxlmd->cxlds->dev == pf_dev);
>> +}
>> +
>> +/**
>> + * cxl_get_pf0_memdev - register a device link with the region PF0 memdev is
>> + * attached to. The region release will imply the link consumer to be unbound
>> + * from its driver first.
>> + *
>> + * @pf0: device to use for finding target memdev.
>> + * @pfx: device to link to PF0's memdev region, the link consumer.
>> + * @range: to be set with the PF0's memdev range.
>> + *
>> + * Return: PF0 memdev pointer or error.
>> + */
>> +struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx,
> cxl_link_to_pf0_region() may be a better name? cxl_get_pf0_memdev() hides the intention of linking.


Uhmm. Not sure. It does hide the linking, but the main point is to get 
the CXL HPA range to work with, an in kernel parlance to get versus put 
is what I had in mind. The device link is how safely the PF can use the 
CXL memory. Noting now that the function description forgot to say about 
the HPA range ...


>> +				      struct range *range)
>> +{
>> +	struct cxl_attach_region *attach;
>> +	struct cxl_memdev *cxlmd;
>> +	struct device *mem_dev __free(put_device) =
>> +		bus_find_device(&cxl_bus_type, NULL, pf0,
>> +				match_memdev_by_parent_device);
>> +
>> +	if (!mem_dev)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	cxlmd = to_cxl_memdev(mem_dev);
>> +
>> +	/*
>> +	 * we got the cxl_memdev and the implicit get_device in bus_find_device
>> +	 * makes the next steps safe.
>> +	 */
>> +	attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);
>> +
>> +	/*
>> +	 * The cxlmd object does exist and it can be found in the cxl bus after
>> +	 * creation but before attach probe setting the proper HPA range. If so,
>> +	 * the caller will need to try later.
>> +	 */
>> +	if (attach->hpa_range.end == -1)
> CXL_RESOURCE_NONE instead of -1?


OK.


>
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	/*
>> +	 * Create the device link between the region and the consumer device.
>> +	 * AUTOREMOVE_CONSUMER means the link implicitly to be removed if the
>> +	 * consumer unbinds first with no consequences for the supplier.
>> +	 */
>> +	if (!device_link_add(pfx, &attach->cxlr->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	range->start = attach->hpa_range.start;
>> +	range->end = attach->hpa_range.end;
>> +
>> +	return to_cxl_memdev(mem_dev);
> Should we bother returning cxl_memdev? Does the SFC driver consumer it at all?


It does not consume the pointer but it uses the memdev indirectly ... 
this supports my previous comment about "getting" the memdev, but you 
are right, the pointer does not need to be given.


Maybe to return the HPA instead, but the call needs to support 
EPROBE_DEFER, so returning an int would work. What do you think?


Thanks,

Alejandro.


> DJ
>
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_pf0_memdev, "CXL");
>> +
>>   static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>>   			       unsigned long arg)
>>   {
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 802b143de83d..e3b1e5be95f8 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -228,4 +228,5 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>>   				      struct range *range);
>>   
>>   int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>> +struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx, struct range *range);
>>   #endif /* __CXL_CXL_H__ */
