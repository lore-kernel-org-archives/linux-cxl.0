Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAED4779A2
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223229; cv=fail; b=dHR00lsX3ZP0RBdMzZNeWwLp5HLUlSBkj0MZaOEEIhQGCbkTC9+reMmU6SVMR8FydYv2lb9N90Dwcblx+AGR3lSRjypMi08LuBGcvejkoPK9Mna7IHE1wdSPov/LSH67ddP8mxwZerYXiCZ1I+zYA22VMFxs0kZzwZac8PPYP6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223229; c=relaxed/simple;
	bh=T40LNnhM7eM1NtdDqZyyt9YAvDai3kfNaGGSmaHaaFA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pC8xqMZM38SvNgIsohCfC6UB5LiDNV8ppu3VKd58QPDjMZvXAmJSDbwpSUiCvu3qodYtCTZobS9EY5lmVmaXNQKO8mvMLUoeAF33G5OrHFdUpf6lmJFFLX+C4nbLiNzxT+hf6i7U0ABxQkzfOOfOyLS+BvJ11wlT266fpWeuaeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=moYYvwP5; arc=fail smtp.client-ip=52.101.53.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="moYYvwP5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4MTXwlUxbVE/lyxPHNv663J3FrQiTsSsdlSnPa0aWZOtc3vduVMZSsrZBKz0gdEfuUAMtHFnOI8+6a8FwnQrA0FwAKPOwyK54kciWWqGlgOln+4u6NabeAu26wwHy3ISQkvBkZ1RawPgQGPtDVmnDXGn1NvrF+tYZC+fCxFv/Y3JWlAvsbfozH8O5Pttz5U62+j4ik0cQnEqOPvFlYq2MsivDDHeSiQIBHDj6gmqpMPCqb2JYN+/OwZGwnt0qHOCukA40M/ohLUAiOR41e/R7UL5LepPd1FVzWxe8bUz8qboQmbrLkvEX+U6Ym9xrEbCa1UeChOpcpMAKRZ/xA8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgxRYyj3W86AhO77iv1nHUFJBZgp+Rvm7x9NqjOkI4s=;
 b=G70Y+WO5MK48BII93yFAEWsse9wn9bYgNqg2I2oSneWO6VLjSgNAn7G/eBYhTKNMnxu7pnRS8FOhYTsO13GSuOlkMyd1fjObottnWYlvqivUYa1CMdrlJzRCXPssK+A6sy/8/cXlNS5p4m+y3lCcJqkX2AkXoQLT4FxApDoBBtfqPmxr/hdEXPoUg2HScuysdXG3G6Zhtj0y6n/a9r99v4jE4wZkYWrceY0ZR9Wlo69Qb6RRHUYAVhZkVh83mOe++AdSoLa3UYXXDUSW1/nYbDPVmUlJEITS5OsA9Vk7raMx0GGXiOYSVWmHaLEyUV2pS9V20ZrWPsalJeVP0+7sEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgxRYyj3W86AhO77iv1nHUFJBZgp+Rvm7x9NqjOkI4s=;
 b=moYYvwP5N6cPqfCzGCI02CZ4Y6b8p6KGZxR08iiGpiKsg2d7pCIXkopoIHPVxaq0rzaWg2sBQEY10uo+pjoGu+nNcT+1u6YoXH/p5j2IGGGcZL+W943CBXl+ujmAxQ4DAFSL7TBNgyfPhWmRhXZCB4oQRvzNaVPCAg8Rbbp2JR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 20:13:42 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 20:13:42 +0000
Message-ID: <014b48d1-8b93-478f-b9d4-f8a5ca8ec8df@amd.com>
Date: Fri, 27 Feb 2026 20:13:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cxl/region: Factor out interleave ways setup
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, Gregory Price <gourry@gourry.net>
References: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
 <20260225122223.3841889-3-alejandro.lucero-palau@amd.com>
 <aZ-KeLC8tKemoNJH@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aZ-KeLC8tKemoNJH@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::25) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fbe735-e556-4b59-edba-08de763cb3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	py/5XFh6mV6bMURAFxF5tfqX5RoKNGCvYlKGntC/XjD08J2GjBJ+AFnV4Yb4Btrwoh5MccCcz0kSdqaBpTGuf8d2ocCOZytNthxhG0xkOsvpU6wflljDScBoZQIqPsUtpxpaR1B8L5VLNO2BXlA/tk8Ep8sXDJCb/oTtm45A07qZ7WyD0SaoNm0px64ogwIbwsOoVpzwBBktaFcYh7/LDOR3c31m4JZmQDlUqVfQ6BTfyw8NJH+4hizo0BWIdCPzzaH01Ovu4icJTldyVzYUGEu5QxcwrLNDor4pd9rVHyabXxi//Mt9JJApRi6acZTU5hTd/YxTgW+wSVG+YNqbiapeZB5mFRFGlldD/xNt7rWWA4AyXQGzM3IFhsMiVGhx8rpGRxFWJSG0TZM7KRDBAwR1DszrSQaBi/Z574+fFqQvoFzLcWuQCsAG+fIf3pD/c71KqnwvHdouOihMtg/cGvy2MfveXPkQ6MkYrB2ht2izeL7cU/bIuqgP3SMYbnGDfNwonOPKCMr3i+Zj8txHs8gT4jWZqYyPwpGr2Fyy+UVqdr+PB24HpAwPeeuj3pIMarBZ4uCpZSoQgFRCnQzo59uSGleC5T/4/kMybOhfH3QwydCAlFQ7fzWLOZIW3qlBk7uk+66x/THZAAYtOD4NOJMEW6gYsovRhtvs0/gnahWbMGl01o+MVAuTDToIjOtlsY/jN5WYiDrA37pa7E1ZZMQiBXns9CbADAycTjHXFu4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blFrQy9odjlydVFDemtMLzRDRFMzT3dhTm9taXh4M3E2K2twcUVJdVZ2ejFp?=
 =?utf-8?B?K1RwTFY1YVBDUFc0K1lpMWhKU0FNVWFNalZNdXh3Wi9naG9JaHVlY0RPNWdw?=
 =?utf-8?B?RktvbFo0cS94bVFLdkl1VGZqNFU2MGx6OVFDWTdJYVJGSUVrdDh2ZjNVZzZY?=
 =?utf-8?B?a0NYTXkvT0NYOGljRElKQWdSTmNvcmJicWxpSTd1bHNNT1VGd29UWjlGOVRu?=
 =?utf-8?B?cnp3MkdKaHhXRXhzaU5kbWRzV2YxbitDeHJZbnJHSGJsUUVrcWo0K2JQbGtN?=
 =?utf-8?B?bDMwam84QlJtNkQrWFJXVm9pMy85bUlsN1F0WlhwaHU2TEZDNFFiTkY3YVlN?=
 =?utf-8?B?REQ4SEZXYVo1UEJGcHlnZFUvOHpacWZMVUNBT0QwUXFQTFZLREdraHhKR1dr?=
 =?utf-8?B?R1lyQ1FqdmIyUU5KekUyK0hnTG1ZS1RzQ1E3TkN3b2l2dkwyV2hoSE8yL2lP?=
 =?utf-8?B?N1lRUTQzclZ0T0JLaldaQ0FnVUpUZWQ3U3pJNk5NYjZ2UFZHbTBFNEZCemdu?=
 =?utf-8?B?VEUwWUFJMmF2VlhrbTY4MHFmbkZoVTBObjVvNllERlBJWUg3TEZxMVUyTHcv?=
 =?utf-8?B?VGhUYTl4Y0FEeG9RM3ZVdm9oaDdhWDMrL3o4dFNzZFp6MDBXeHdiaFN4bjh0?=
 =?utf-8?B?cFlmdHd0VGRaYWllSmJSRjlRcFNnTlFjRkFhbmNVNFBEUDFmVVJpeGY0WkpK?=
 =?utf-8?B?R2VhMzc5WXdCcFdNeUxaR3BZSThmMDRCVG1JU2NRN3h6QmFEZWswUVA3a0dR?=
 =?utf-8?B?VkpzcnVTRng1TzhwdFBIcXlQOWp6YUVyQjA5N1pyZ3hnMHlDK3BWQ1piaDlL?=
 =?utf-8?B?RlZSa2IzSTZBZEFWdHVSMi91MHBzMEN5bzRobjZoUFNUdGFBN2JtbEl4dkdw?=
 =?utf-8?B?cW82c0VrREg0eW9zcUdtcCtsd0RCNTZrYTJ5RDVmVlpGQTdBS01DakRhNnhI?=
 =?utf-8?B?S2NHYlNEY2w2bHlWYWV5VjE0SVRXUllVaERTSm5nai9JLzdvQ09NWWNyTFpR?=
 =?utf-8?B?cnNIbWEyYnJmM0E4TWFOQVRuSTBLdDFNd2xRMEFvelVDYmlwWUVjQzRiSGJH?=
 =?utf-8?B?Y0VCdEVjbElQWGJDcTVYT1dxMjZBS1o1cENrSTF4U1p3NE5Xd0dzSGJVcllS?=
 =?utf-8?B?TlozN0lNZ2w2aU9nTmFNcUliY3ozWXUrVVRxVVRWb1VQWVFFbWhLbGhnZHEw?=
 =?utf-8?B?UmticjhqK3E4U2ZTVjFOVVlWcC9rcGNkdHRwU1dRUHVYRnRWK2lUcDZaZEEr?=
 =?utf-8?B?b0c5M2ZRMDdVdDlhQitxbDEzemoxRDRVMkUvanZlUVNyMXhVU1ZsdnREZHdq?=
 =?utf-8?B?dFljaHJ6dFREMEx1RmdFemdTY3Rvam1PVEhNSjBUQU5EYU9MYXZoeFQxS214?=
 =?utf-8?B?YmxuR3QzbGRWZ0t0Ly9Ed2U4TEdUck5oVzZwSGJFUmpiTTMwU2hybWlWR0hO?=
 =?utf-8?B?eE5FdExjLy9YUEFIMUtKaElLcVJZRlk2dGlqdlhsVkc4S001NUcvNUlkdmpD?=
 =?utf-8?B?V0E0MjNTajUzaFpBSS9ZNzdDc2l5VjYrdXFVUWcrTmwrbWhQMWI0alZoNlI2?=
 =?utf-8?B?Z3IvQU5aVXFrc1ZHNHdlSTdpWGQ2c25Ib2M3WndIMVJQWTdtbUdnd3k3ZHkw?=
 =?utf-8?B?ZksxU1FJUW1xekVTNWRRTTRQZmsxbkc4OTZ4KzFRM1J5NTh5V0sycXd0RFAr?=
 =?utf-8?B?bDRQWk1TeXNmQzM3UWgvUHZJUTlkaXc3U3BNS1JIMEg0VHF0STRxTFIzdlRP?=
 =?utf-8?B?SHJPZmNjL3MrdzZ2SWpDKzRuN0hacGpqQUZMbHBVUWxvSk5HMlU2Sm5OalNq?=
 =?utf-8?B?V1lNK3ZhMWdxL2huOE5LaDBsMEw2QVlHdUlLMWlkQktWOFhldy9IMURWeW8w?=
 =?utf-8?B?TG9pOGpkR1FOd1Fhby82VVk4ZWVlWE55Sm1ETlhWYnhrekZYVEpDL2xSSE5D?=
 =?utf-8?B?RE14alFjWWJuZXJld3hvRjBoc1NWYkV4NGNkM0ZTS25xcWUvdlY1OU9XYlF1?=
 =?utf-8?B?RDZqRXMrblo0ZUhqV3lELzlwQ2RrLzdrellVbmZNVzd1TkZFa0drUnA2aEtq?=
 =?utf-8?B?Q0VTemxVOFVmM2Z5M3hHVWNZVm9mR1d3MCt2WGNBeWRjM1ZkRXFnQjlhTkcz?=
 =?utf-8?B?N0JSNEovUlk5WlErOUJaakY4YlBkYnVTZWVRTGg3L2Y3d1lod3dZZjVmaGcx?=
 =?utf-8?B?RWEvbDJUYUZNb0xRZjJsbXpXa2xWa3drcWZmOUY4dDdUZGRFNXdsYlJwUG1x?=
 =?utf-8?B?K3lwVXVtS1lKN2JnZjFRTUFTUWRzbm9DeDZjUmhYYXZDaWtuUjdKa3B5Y1pC?=
 =?utf-8?B?TVAxM3ZycE5BbjZGMDdnUjM4T092Z0MzMXB1VXlwM05NQlpUZ3lJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fbe735-e556-4b59-edba-08de763cb3fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 20:13:42.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4/wYAJ756MXB7B0QFcg7IzbHXuX2UyjR780boBiFqlaQvKFBtczd20pniYvboGRVOIfVrq5IT1CypgTQ3woeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187


On 2/25/26 23:49, Alison Schofield wrote:
> On Wed, Feb 25, 2026 at 12:22:22PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation based on Type3 devices can be triggered from user space
>> allowing memory combination through interleaving.
>>
>> In preparation for kernel driven region creation, that is Type2 drivers
>> triggering region creation backed with its advertised CXL memory, factor
>> out a common helper from the user-sysfs region setup for interleave ways.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> Tested-by: Gregory Price <gourry@gourry.net>
>> ---
>>   drivers/cxl/core/region.c | 41 +++++++++++++++++++++++++--------------
>>   1 file changed, 26 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index cac33c99fe6a..3ef4ccf1c92b 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -485,22 +485,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>>   
>>   static const struct attribute_group *get_cxl_region_target_group(void);
>>   
>> -static ssize_t interleave_ways_store(struct device *dev,
>> -				     struct device_attribute *attr,
>> -				     const char *buf, size_t len)
>> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>>   {
>> -	struct cxl_region *cxlr = to_cxl_region(dev);
>>   	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>>   	struct cxl_region_params *p = &cxlr->params;
>> -	unsigned int val, save;
>> -	int rc;
>> +	int save, rc;
>>   	u8 iw;
> Why the type differences? set_interleave_ways() takes an int while
> the sysfs store path parses val as unsigned int via kstrtouint()?
> How about keeping the helper argument type aligned with the sysfs
> parse type (and/or p->interleave_ways type)?


Yes, that was pointed out for interleave_granularity_store by Ben 
Cheatham, and I did change there from kstrtouint to kstrtoint as 
cxl_regions_params expect int type.

I forgot to do the same here.


>
> Even if todays sysfs path won't pass negative, the helper is
> being positioned for non sysfs callers IIUC.


Not sure what you mean here. Should I do the change above as with 
granularity?


>
> Similar question with 'save'? Should it match type of
> p->interleave_ways?


save is an int and interleave_ways as defined in cxl_region_params is an 
int.


Thank you


>
>
>>   
>> -	rc = kstrtouint(buf, 0, &val);
>> -	if (rc)
>> -		return rc;
>> -
>>   	rc = ways_to_eiw(val, &iw);
>>   	if (rc)
>>   		return rc;
>> @@ -515,9 +507,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>>   		return -EINVAL;
>>   	}
>>   
>> -	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>> -	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>> -		return rc;
>> +	lockdep_assert_held_write(&cxl_rwsem.region);
>>   
>>   	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>>   		return -EBUSY;
>> @@ -525,10 +515,31 @@ static ssize_t interleave_ways_store(struct device *dev,
>>   	save = p->interleave_ways;
>>   	p->interleave_ways = val;
>>   	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>> -	if (rc) {
>> +	if (rc)
>>   		p->interleave_ways = save;
>> +
>> +	return rc;
>> +}
>> +
>> +static ssize_t interleave_ways_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t len)
>> +{
>> +	struct cxl_region *cxlr = to_cxl_region(dev);
>> +	unsigned int val;
>> +	int rc;
>> +
>> +	rc = kstrtouint(buf, 0, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>> +		return rc;
>> +
>> +	rc = set_interleave_ways(cxlr, val);
>> +	if (rc)
>>   		return rc;
>> -	}
>>   
>>   	return len;
>>   }
>> -- 
>> 2.34.1
>>
>>
