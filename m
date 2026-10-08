Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265949E5CE;
	Thu,  8 Oct 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467469; cv=fail; b=IrsjCUjRoI7FZoRb222WUrEF8WE+ap8c1gCZaZBlrDH2Pn1Bm8s4zHZoN4bSdrmd79tq/eSl1PE4Zq+o+sR0Z/Kgf+Hei6nAoELGHewXCJEUVvLPBjn4KlD3TJBIvJcI0C6256YEOb6ksXC/oYegD3Kwru+iz+rg8KC5w7AJGqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467469; c=relaxed/simple;
	bh=PERV9xtLiZlPyE+8Cxssy2IgRWnJRD6eGsJ0A7tGcjk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M7ZMB6mC0ROtAYQBBoqMh2fYc0xJ7GNaofTZUSbcqQCA1k5O7pv5rWffKL2XNi8Tw+O00s4/VDjhSMgVS/mpxHG9/x460wiVvY7MDSdT4oL1551vynq9a5MAVWBOMfyDfoeqL5nVPoTrUTmGvu+tUq5IGa1D3JOUTFFkc0U3lqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yJtHfR5H; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yJtHfR5H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7R0hA5sSNOZbICvFNPn2N6axtgL1sezpDJ8bbxA/NAcW/+FP3l61KnJF50XR4TatPIUiCLz1KC2QqH6abtLgZxph9RMeI5JKjD725NcCmpm7a4H5usp4s0Ozv5NsgSArkC59DH5NLBlUQjt4wHGQEEmHAyru4ggAuSrvnXmnax8cjBCVdNsSV6QtHJAejtZ06IFvX3OLODTmb+2B648JsoWZGLVnPECogHrt4nvyeyypxIWEcqxV+77xtNJN6rLALpQAWCKMwrwKNEzSV3k2HODDdgFUGSwN0GUxeiZ8iBWm48OOHKrWoMWqzhZCycDw76IaL6ICjC+LHCifk7CIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdiy8KxVqUgJPLhpyHtoaAbVKfX9/BEQoaYdZEoiPtM=;
 b=xtvO2uCe+jStDjH83UHvetofQgk5ZEneHkueaViF0ameKxQB+ESJ5sTtZneVfvaCFCenw23nBdCRTq8EKya+ZK0+zVKdGclekESSQT3Vx6FO68xl+DZCj5/ySjZYzTELudeA1mcR1AAOsygdsw+DuBC4Ly54KN4Jw1fV+8JBrXshOD9mt0Z33dLHjTw02ltAUkEhUPhTK4urU28P9FRSRysuY2CdLxcb4g7vYodJlTMo6ZAhYv9A8Vfc4ewRu52HL1dZKcT4wEyV2zKYR9fHkzyNzzTIUeISnnPd33Aj3ceangttdx+HrGQ4ldfs3kIGDYp/MSVVVcXp1zA6czSigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdiy8KxVqUgJPLhpyHtoaAbVKfX9/BEQoaYdZEoiPtM=;
 b=yJtHfR5Hn1yFJag4FxSlPUYYiIsnuEQU5Ik87LUadHWjoAm0YyeweEEOIjYS79W8uGO6BgE5cpAR0uic8LY5z6htV13YI15S4gJwt5iiedf1WEbGa0yTEdjspEnTPfefMRmPEbOYcY8fiKuLFQhRLp5eYDE8GDu/2I4xlwbqmao=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Thu, 8 Oct 2026 13:51:02 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 13:51:02 +0000
Message-ID: <9114ec71-060f-48ae-a6e5-0b46a881c259@amd.com>
Date: Thu, 8 Oct 2026 14:50:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/region: Add region reference in memdev attach
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-3-alucerop@amd.com>
 <6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com>
 <8ebaae42-a0c6-4e9c-be1b-ca68a4769ed7@amd.com>
 <bd412198-8a25-436c-b6d6-6b6730e8c28e@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <bd412198-8a25-436c-b6d6-6b6730e8c28e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0324.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::23) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa699cc-d2e5-4c2f-65bb-08df254330d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|3023799007|10067099003|56012099006|5023799004|6133799003|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	LcgkzEILqD6GGcJ+SqwVyEJ4KO3BYXkFQc3GX+OlGPw86fDCMpufF49i7M8k/SE/1iRl+7sHibMeDDjvMjhZMKfIccOrPyZ026WXa1B2GiV7fijbs4wIoH1zVWZjpnI+DDXTS88l1SlA574uMqTMcAkZKlsd6DIGi7dPL8YUIJWKEaCaJnCazSqQPNYko9CgYKGmxdFb3P4jcS04d8tZnmEbC0dpyBBoYBc+ZtjU8Vl20ashl2SSqXbmFptp61+BXdlPHFGoGJGMdbV4f37JNweynP29+t/uHbGlFEOLl/RGX69mLRFwkjBQO6vJEsGBmNimsZryZ14AiMPSEbo6AqeKx0rfJKg0OK3TEFMESC3mMKxw2Ywf3O1TFudZup7BDp4Yqab8R+XjtFlT4sszS4Mms/zmRWcMEL7UbcB0TtD9V9XHh6DzRwiYZ6a5RFSScpmj3G59/Lr8YE51IUXv1VBmMGnBk6VS1xO5E4Hq1znqWMg0ZgnDPhUeXZzrdQTWN0AuKmwOkk7wh0/BvnOI8Ic4T1s82X6Mqw5peNyrr3/qMoKfNXnps6+n4MLLLY+t7ewNXIdqWNZLtRsOhHVc16xQuLy9okr69mmimfhjeVXlirZuHd8L6Xyhkb8Ft8rY3qpw8uPRgMSRa3LcGeAXKYR62X8GTslGb7oxLVJwT1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(3023799007)(10067099003)(56012099006)(5023799004)(6133799003)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkF4cmVvUWprZGIwZWxUdHMrWHl4Q0dSemM5a3ZmdDNUa3puWWZKejVUTU16?=
 =?utf-8?B?citjZDBzZG1VeFREZW9XZDZoTkdXY0FvRkthOE9icXR5NTdvcVBFbWNpUTk4?=
 =?utf-8?B?OFFTbVMvcXowdDlCZUNFNkFNSEwvYSsvMVRBM0hOUXZjNThOTHNpVUFxd1Vz?=
 =?utf-8?B?Z3BzZnU5d3pPZzFpOEtpUU50UERJb2ZUb3FqQzJqcXcyUGE4UnJkaTJBblla?=
 =?utf-8?B?enQ2eGoyaTFHOGVIZlg5TXd0RnpTMTFLeEYvOCtSVGxESk8wL0lDckwyc0JD?=
 =?utf-8?B?R0NXQ2VNcHo0YzdOUnFSL0ROcVgvejUzMnQ0VFQ3TCtBQW55dm83eWhYMHJm?=
 =?utf-8?B?YVQyaHZxME1yWUdVUjdtY0Y1VzRlb1VTeDZsVlV6UFkrcW9XMzhEWjk0QmNN?=
 =?utf-8?B?L2R5eTQ1RjRTcnhZd0NjR3Y5cXJTSUVMZVZGeTJLQ0w2aGhVZUYvMGk5ZlVE?=
 =?utf-8?B?cTBxSm5SK1piMFlwNHEwUDhqeEVrYWx4eE80RmhmZWUwaFdCSVhiVnk4Q043?=
 =?utf-8?B?UTlSZ1JmTzcvOEgrbHlWSHd6ZHVwZ1FrSHNTTVNsMVpuZ1g1alFEZ2F2YlFQ?=
 =?utf-8?B?N1QyeTFWMGQyOUNacWVBS0hxSDY4eHpweWRKRk1zZnlEZmgyeTVmK2hRaHAv?=
 =?utf-8?B?M1BTNXZOclc0cG5zUnZUV3VOa0RQWmgwOVJCV2xmSWZUTmQzMUgxWGVhV0Zh?=
 =?utf-8?B?ZTVyekJUaU90YmEwS29yencvS09jSmM2dGMwZHV1ZkNPZXBPY2o0UVBJSW9a?=
 =?utf-8?B?QWZuVThxazFPd3pEVkp2YWZ2SUhoWStTa0ZJanArWUZQVzdiQmU0S2F4cU9P?=
 =?utf-8?B?eVlpUEV3aEZjVEYwaVRROWx3Q1lKTU12TkNGV29IR2JaeG9TMHJZbDNpL2VE?=
 =?utf-8?B?Wnprb1RwbndjdXZJRVJqeElTMzFyS0pQZUxKZlZ5R0dQVWtRaGFIN0Y3U1Zw?=
 =?utf-8?B?UFlqNjBudmtUVllPQUtrdFNYU0szS0pFaGFESXo3Q3kzNHlmbEM0TjhPNlRB?=
 =?utf-8?B?UFdTemtHOTVSWDFiNDBWSEE2dkVRSVVWU1BNVjFJVHk3S2RqVER4YVI2czd0?=
 =?utf-8?B?eG1XSnI2dFU2a3BidHJyMHQzUmFTelR5UGFyQzRySVJkTzVKeUlyOE05UHF1?=
 =?utf-8?B?T3luMEVjRzkwQkhQdkg0aGhoRThSUVRJVEFsVHJuQTQ4eG45NjF4T2grOUZX?=
 =?utf-8?B?M1lBQ0tzdG93MzJUb25oT29KbUM2VUZxZm5mNmNHT2NvelByOUxaSWJtb1FT?=
 =?utf-8?B?d3djcTMzQ2Fhdm5tZnJNVCtaU2hwVkhXa0hlcHlEMXl2ZmtBNURuZEdjK054?=
 =?utf-8?B?NTVOY1FWSTFqdnBCaUp5SE8yempKNXVNTWpRT3ZKUDNLeGNUNzE3QmJZQmMr?=
 =?utf-8?B?U0E4SlRaNVBicHVZc1c0aExlWmJ2YzlZT1lJd1ZEbG5GNlFPNVlvMDRON0di?=
 =?utf-8?B?UHRzMlVpbGJ6bHZuSlFaVXlRaTNxMVRLbUE1ekNJdkhsMUgzSmlEQWVpOUQr?=
 =?utf-8?B?cnkyQVRtUWZvY1JNYzBTV3Y0SmpQMDVtS3I3dHJPOHR3TWcwdXB5Zjc3SFVq?=
 =?utf-8?B?cFhzS2tmczJkYkVjZms2bWhBSnJxWmNvYzdxeEJpWkYydGdYS2RmNXFqR09y?=
 =?utf-8?B?UnNJdnZYd0NwM29mV21FcFV5T25kMDkyM0JSeXphbnRoVFRJQ2dudW9ReW5v?=
 =?utf-8?B?ZHNEcjVybzVJVlQwQmJJZXk1T1VBdFNnTktMTk5nUE1ySVZ4MkF4UXJVVGRS?=
 =?utf-8?B?UWxjUVl6R3JPa2YzU0pydVZsbWNNZWs0THBMV3pwQnZrNENnU3l3RnFpRFFG?=
 =?utf-8?B?anFmcWE0bnpXQlBxZnJ0emIrWWtYRUdtbFJCTHRubThtN0htNmdobDJNQVNF?=
 =?utf-8?B?VldxYUVwdXk1VlVWOXpJRkJJeGt2SVlUa1AvejRqNkRxMXY5bUM1NFJHOGt3?=
 =?utf-8?B?YUJPWDRRVjZKdFBHd1cwckNOdXhBQzVOekVibWJ3QVFKeFl0eFE5NGNGekdN?=
 =?utf-8?B?OTlncWtiT3p1Ykl0d1Bmem4vQ0gvdlYwTGUvN2kxdGFXczgvSjJXNjdZV29I?=
 =?utf-8?B?Q0EyaXp1T1pFWmpSbFJwOW5GSkUwa2dPSk45YUxHbDlvRXhqT0pGNTBHL0Rl?=
 =?utf-8?B?UkU1V2F0L1ZYWXpHOTkyS0VXNjdEN2Rpais5RzQ2U1k1bHp5TFNRNURwb2xK?=
 =?utf-8?B?ZzhodUF0T0dkYWF6cjA2QXBXMjlyNERqS3JIZE5PY1BhV1RDbXMyN1crdWZv?=
 =?utf-8?B?S1RNYlpBd09OMVNkdUp5MjkwdC9xdWNEZ3ZndUZRbHhXdGRTWmZ6c0ZUVERz?=
 =?utf-8?B?Q1FRajRKWVFjdGVpclN2d1UrY0lsdmlGVU1EMVBhdXdHTm0xWm9Ydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa699cc-d2e5-4c2f-65bb-08df254330d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:51:02.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhUxenr0cz9ljpwcKlreC4VZXs2wGjNXwd2fCQyGciJu5r6QCdM9M4L4qEMaDqaVbZHq5uUHB0xm27ryx/t2hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699


On 02/10/2026 16:52, Dave Jiang wrote:
>
> On 10/1/26 9:41 PM, Lucero Palau, Alejandro wrote:
>> On 01/10/2026 22:38, Dave Jiang wrote:
>>> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Use a new field in cxl_attach_region struct for easily link it with the
>>>> region the memdev is attached to.
>>>>
>>>> This facilitates device links creation where such a region is the supplier
>>>> with non-PF0 physical functions wanting to use the CXL region being the
>>>> consumers.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>    drivers/cxl/core/region.c | 1 +
>>>>    drivers/cxl/cxlmem.h      | 2 ++
>>>>    2 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 27e63e6dab7c..78ca7ebc3e55 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -4132,6 +4132,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>>>        if (rc)
>>>>            return rc;
>>>>    +    attach->cxlr = cxlr;
>>>>        attach->hpa_range = (struct range) {
>>>>            .start = cxlr->params.res->start,
>>>>            .end = cxlr->params.res->end,
>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>> index c401e3a1af06..c598561b8e5f 100644
>>>> --- a/drivers/cxl/cxlmem.h
>>>> +++ b/drivers/cxl/cxlmem.h
>>>> @@ -104,6 +104,7 @@ struct cxl_memdev_attach {
>>>>    /**
>>>>     * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>>>     * @attach: common core attachment descriptor
>>>> + * @cxlr: cxl region the memdev is attached to.
>>>>     * @hpa_range: physical address range of the region
>>>>     *
>>>>     * For the common simple case of a CXL device with private (non-general purpose
>>>> @@ -112,6 +113,7 @@ struct cxl_memdev_attach {
>>>>     */
>>>>    struct cxl_attach_region {
>>>>        struct cxl_memdev_attach attach;
>>>> +    struct cxl_region *cxlr;
>>>>        struct range hpa_range;
>>>>    };
>>>>    
>>> attach->cxlr is never cleared when the region goes away. Unbinding the endpoint port runs endpoint_unregister_region(), which unregisters the region and drops its reference. PF0 stays bound until the detach work runs.
>>>
>>> A non-PF0 probe in that window still finds the memdev and calls device_link_add() on the freed region.
>>
>> I do not think so. This version, see next patch, relies on locking the supplier, PF0, before getting the memdev and potentially using the attach region. Only on PF0 release can such a memdev and region disappear, so I think this is enough.
>>

Hi Dave,


> The memdev, yes. It's devm on PF0. The region, no. Unbinding the endpoint port, or cxl_mem from the memdev, runs endpoint_unregister_region() under the endpoint's lock, not PF0's. PF0's release is only queued (schedule_detach() -> detach_memdev()). Until that work runs, PF0 is bound, the memdev is found, hpa_range is valid, and attach->cxlr points at a freed region. Root teardown (kill_regions()) and delete_region also unregister the region without touching PF0.


You are partially right. The problem is not that async detach_memdev() 
but the fact the region can be removed without the PF0 being aware ...


I was relying on the memdev being unregister first then the related 
device released later on, with the important part being the memdev being 
unregister making it unavailable to the other PFs because it can not be 
found in the cxl bus. I'm pretty sure about that scenario but I was not 
counting on sysfs unbinds for the endpoint device ...


I need to think further about this because I think it is wrong to remove 
the region in this case without PF0 or the memdev owner and original 
region consumer still unaware of it. One thing I tried to discuss with 
Dan was why we have the unbinding options for cxl_mem and cxl_port 
drivers. What is the point? I know this is standard linux device model, 
but the unbinding could do nothing if we decide so. Couldn't we? 
Otherwise, If there is a good reason for having this functionality where 
the unwinding can happen through different starting points, we should 
document it.


What I'm going to try is to link the region removal to Type2 driver 
removal as well, not necessarily with device links but through 
devm_action_or_reset links as we are already doing for other cases. And 
I think to document the different objects/devices involved and its 
lifetime depending on the current unwinding supported would be good to 
have, so I will work on that as well.


Thank you,

Alejandro


>
> I attached an LLM generated test kernel module you can use to reproduce the KASAN complaint. Commit log provides instructions.
> BUG: KASAN: slab-use-after-free in device_link_add+0x521/0xa80
>   cxl_get_range_and_link+0xa9/0x120 [cxl_core]
>
> DJ
>
>> I added comments in the exported function, cxl_get_range_and_link() which does the locking before calling the internal function __cxl_get_range_and_link() which looks for the memdev and the attach region. In fact, it should not be possible to obtain the PF0 memdev reference and the attach region not there yet, but the code is still checking that possibility as a sanity check.
>>
>>
>> Thank you,
>>
>> Alejandro.
>>
>>
>>> How about something like this?
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 27e63e6dab7c..38ca73f12b84 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -4076,6 +4076,23 @@ static int first_mapped_decoder(struct device *dev, const void *data)
>>>        return 0;
>>>    }
>>>    +/*
>>> + * Invalidate @attach before the region goes away so that
>>> + * cxl_get_range_and_link() can not pick up a stale region.
>>> + */
>>> +static void endpoint_detach_attach_region(void *_attach)
>>> +{
>>> +    struct cxl_attach_region *attach = _attach;
>>> +    struct cxl_region *cxlr;
>>> +
>>> +    scoped_guard(rwsem_write, &cxl_rwsem.region) {
>>> +        cxlr = attach->cxlr;
>>> +        WRITE_ONCE(attach->cxlr, NULL);
>>> +        attach->hpa_range = DEFINE_RANGE(0, -1);
>>> +    }
>>> +    endpoint_unregister_region(cxlr);
>>> +}
>>> +
>>>    /*
>>>     * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
>>>     * simple case of single mapped decoder per memdev.
>>> @@ -4127,15 +4144,23 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>>          /* Only teardown regions that pass validation, ignore the rest */
>>>        get_device(&cxlr->dev);
>>> -    rc = devm_add_action_or_reset(&endpoint->dev,
>>> -                      endpoint_unregister_region, cxlr);
>>> -    if (rc)
>>> +    /*
>>> +     * Not devm_add_action_or_reset(): the reset path would take
>>> +     * cxl_rwsem.region for write while it is held for read here. The
>>> +     * endpoint lock keeps the action from running before @attach is set.
>>> +     */
>>> +    rc = devm_add_action(&endpoint->dev, endpoint_detach_attach_region,
>>> +                 attach);
>>> +    if (rc) {
>>> +        put_device(&cxlr->dev);
>>>            return rc;
>>> +    }
>>>          attach->hpa_range = (struct range) {
>>>            .start = cxlr->params.res->start,
>>>            .end = cxlr->params.res->end,
>>>        };
>>> +    WRITE_ONCE(attach->cxlr, cxlr);
>>>        return 0;
>>>    }
>>>    EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index c401e3a1af06..7cd3a69cd5f5 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -104,6 +104,8 @@ struct cxl_memdev_attach {
>>>    /**
>>>     * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>>     * @attach: common core attachment descriptor
>>> + * @cxlr: cxl region the memdev is attached to, cleared under cxl_rwsem.region
>>> + *    before the region is unregistered
>>>     * @hpa_range: physical address range of the region
>>>     *
>>>     * For the common simple case of a CXL device with private (non-general purpose
>>> @@ -112,6 +114,7 @@ struct cxl_memdev_attach {
>>>     */
>>>    struct cxl_attach_region {
>>>        struct cxl_memdev_attach attach;
>>> +    struct cxl_region *cxlr;
>>>        struct range hpa_range;
>>>    };
>>>    
