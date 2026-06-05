Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A948032F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646171; cv=fail; b=fFNQ0DHh7GnVK1AywLvZ9B7mq5sy3pTqpq9fy6fZveqrdknrmknVOMJ1VL5N+t/SYjIXgv8+LdeqFYlL0sYgwiZ9v6BtrufypQ7S/g6cLArxn44OitygVC0+2narWNVy+juy++RABnL8sdPbUFmLWnEEXUm26FfnKv5gF1XRDSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646171; c=relaxed/simple;
	bh=MsXNmRpBnRadVFKaHiqoBU7TIQ+hYq3pVithg19IfVc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTFUKIBM6uNWX91KVqFU70V4bt5lUSaBrkf2YzdennaMcXKBL6d68ECRXJppUc3m3Z2YFm2adNOhFvZHdXDY2tMY0uHp83rbsWt5gdQHnpH78fldgmuKShed/qMjPrmiMxV5P7RAgendjbGBfmEUWwQUJ85+UIJU3VDNwJTEL7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mAWZo63d; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mAWZo63d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haBmwXaWEKf5LEX8uOVfAA4o1lXRkKHiJzh5eZqjSRyfKGavoS4+fHa0QXV7qeQoeIiWl719JLGStYq9klbEJUm4KgMmvFg0qYFs9K46SvvvBraIFLewMqoVfwXmO18wQJueoiMOT6reIHJ0ZA0IYXgA7T9cyKfU/pFkVMXz+18enAidf+02WsJ13iAIyOoIvZdiLpZDUieQndTr4wj9UM22aAzl1ivg1YoXLIzAsp9BFiHGs8bGq1clJw1G89fRQZ7jFG8cccJU96xck3n0FBB/QTLfj3xiIppblTLNoZZLu8Cp3J9a6VLje4y2IuW531cygBzZ9kLl4YU09aX8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfM1E85yy41noQjSua4hiLwZHGGmTioP3Lxn4OlO/cg=;
 b=j5WO+JcrXRTs1c7tZ5/A48cpFtWbZVAgp1N4vevXSAMqSmiYNIMayit85FXTrPl/lAGHvnAhSQspb9FOkvb9cTIDh9VLpq9Fl2h73kGPpYl39Hvy5ge2rWlxzecNH7rkHUMy1wdghYAoBsT9uA7/Y97/oa9So05XO7yD/ZGVrw4po8qvtx5Dkx8v7yrmDiVoG8io7/b+odcyXjUuYbuTpwUFcTrdBQ8e1oDGs59zjD1QaAEFHc86T69gbiyMzHzZMtPUZBDpEvVQNg8DqLW7ythgSFbr9MNebK5F72WeKXsJ+85FPNRWtH4dK6/rErsogrp+EqG7v+X1/WY2iSivhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfM1E85yy41noQjSua4hiLwZHGGmTioP3Lxn4OlO/cg=;
 b=mAWZo63d22XBhb5Ym+vHZ/1vOuE87aeScnU5unQ0hRd7kcKuNPDQhnz9SJZAahPBv//l83mx1/x8jmJjY4AOdrCu0GIAeDpPOEULXJaAgNlUIoCsj4ZXt9klfBmy+Vnporc/48hdvX3anrYEHAtRUJQILyw1pDrLkJKm2f12yfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 07:56:06 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:56:05 +0000
Message-ID: <2a9791d4-e091-4452-af92-3601253bc748@amd.com>
Date: Fri, 5 Jun 2026 08:56:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cxl: Introduce devm_cxl_probe_mem() and fix region
 deletion
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, alejandro.lucero-palau@amd.com, jic23@kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>
References: <20260519210158.1499795-1-djbw@kernel.org>
 <9e85d980-4a44-4f27-aa18-8d01630a05e6@amd.com>
In-Reply-To: <9e85d980-4a44-4f27-aa18-8d01630a05e6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0184.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::12) To SJ1PR12MB6244.namprd12.prod.outlook.com
 (2603:10b6:a03:455::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: b62c52c2-7047-41cf-b2bb-08dec2d7e48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	m9UiI/Icnxxd84OPEWBIFXy/OMO8Zy5tlazDO7CSqo5tsEjclBX1vaWdcVrJGGeUSDUIsEkoQXNwY4AQBeRVrbU3090ChGkrokG2AbZ+Gyn7gnmy3Gsho84qm63OXxiZSZbG6TQGHwmfkqfKtz+FGyukX8rU2EhI2aHEcvKO/8WzA8KgjrOQn0tYX1jIg3kgIBh3g388gqKqjbyceMS5Ur3/cVmiKstBoqD+o3zgS4KSbSTeXrilMVmX2EfTtdsCljKgSqtBHl4oPol+rF/ZjQ+xJjj/noRKAk8kljH2Cc1vjqTclQfmEmRzYl/YAzzVDckcSdRI9nsyd/EVfdIVJ9r+jgkLnoFsyJuCGblkzhryi50qNmLVD+FOD3XB/oWDowN95aEexjLr7t80Ck2mLWhNwVAVFczGolY4f8p1V3JmfvmO8fujp9UmkPFR0j186LpKyfn93OmmgskZg8g4xVbZnNilEeXQhdfQ+klRXYcxsM8mZqUFcQBOWAFFBn5+a2i+607fBczpGwWwC3wbroyYqxW67flJUudXB5WoAuHYvqAYTkQOU2wU+tieKTy1aCpWEI0CeR9GT9MKC+Z7sVAD+p6PCRaugp0GdZuZr6VMrowVka6hGEiJW/scixB3fiVlBxyJYxuoyIl4ui35eiaspVwQZq5PTUz8KddpBsGDSPdq+z9cOF2OiVRlajeZ53CkXStGkLCyhoRiq2lAHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UndDeklXcmJJMnZWWk9vbng4UG1JS1JMTXk1WFlSUWtXV3ZoSExpTUdJN0tw?=
 =?utf-8?B?ckJxRk94ODFpa3phVktLaktwRWJlMXRta2M1K3c5bXJBMHlSKyt0NnZxMU5E?=
 =?utf-8?B?cGtxTVd5ZzNyMXA2Y2NxYlZwQXM1c0x3SFJTSDhMYUNIUXBhTzd5RURJbW9V?=
 =?utf-8?B?SS9uL0ZVUGErR0dySjNWbGRaZlY4blEvL2ZQMjdaL0MwZVJxSitYcEJUSGth?=
 =?utf-8?B?aFVQRlR2aFdmaUZCZGxIZmJhTkJRQ0hiTlJSeXZWR3FBZEVqWTdlYmhtQzEv?=
 =?utf-8?B?L3MrTEQxYk1nRnhaK2lTRGNmaEg0SW5hZktmZHRJbVBpRGRVTm41Z1cxRCto?=
 =?utf-8?B?MDMzQmhGZm1LdGZxcWN2WEJwaE40OFZlZXk3VUFwQUlOUGN0c09nK2JnckZ4?=
 =?utf-8?B?ZGV5ZW90SjBBeS90SjVqSVlrbmVOWFhFc05ubXBSNEJoMWNISUM5YTQyVVRZ?=
 =?utf-8?B?SEJ2TnpCak05WlRDWmFsdzNoOWpNS1VNLzFUeWpQVVJwMHhVdzNqNGhQMkc5?=
 =?utf-8?B?VzJpenpMYTJtR0hxNjExL1FCd08vT2gzZ1lmb1hGRzNVdEFsQWltQ2ZaMFMy?=
 =?utf-8?B?YWVzWDc3RmxzMlowTFlPbVVwaGZMMlhmS3FzU1ZBVEIzWWcrNTdCQ0J3SDBR?=
 =?utf-8?B?TGZsZWxiZDN6NHJVUGJXZ0F0eUVJcDZuRTlFYjVOdDNnVWJaVnM2ekNBeWtV?=
 =?utf-8?B?SXlYWWFScDFzU0ZUU3FtcUg4RThsUEFQU3RSRlhwdWVlRmx3SEN4MmNlMjV5?=
 =?utf-8?B?U3hpM3N2NHoyMFloT05KbjFMOGI0UVZ3YUsxMnR0b3F3d0M4VEVWaE5Ed0xr?=
 =?utf-8?B?RVRxR1pJRjlWN2M2ZUxnd25mT2Y3eXVuZmQza05Hd2JMZnN3bHR2TDE2anlM?=
 =?utf-8?B?VnNFcTc1NTQrQ2RVVWdkdWZwMC9wbUhkK0V6WEZ6ajhrdDZqNElGYVVuMzNh?=
 =?utf-8?B?dWQyMEF3MmFlcnRIOWlnNEp5VENGNXcwWGRjNmU0azlkV2Vxbm5KaC9wV3BZ?=
 =?utf-8?B?aXViMWM0eUpwMzNYK2Y1UUxDN1crL0MxcmtSTG9iVENJUnVQS01DbzhuSTM0?=
 =?utf-8?B?NzN2dWMzdHJtNGE3VEFhbHQ2NWkvQ3c0NVZRbzhDTXcwL0w4TEZyTmFGRVFJ?=
 =?utf-8?B?S2ovSXJhR2tBdk9vZkFpOUZqWUJGVVFsNThMNkY1RmR4akJ6THlBSFRtVW9i?=
 =?utf-8?B?Qm9qL2RGS2NseUM4RzNYU3RDZE1kekpobDFkOFVHMlBRMTBNdDI4WUEzY3Za?=
 =?utf-8?B?SjBRTzdQanBUUHgyWDVJdWt2a1ZSVU9PWjl1N1laRVhnUzYrTitHblVCa25O?=
 =?utf-8?B?YUdQOG9sVVpld2pXbUpJVCtIbFlDenV1U3pNdjIzbElCTlJ3TlJreGVUdnZx?=
 =?utf-8?B?UHIzMWU1ZmFBT2hDM3ZJMTlrL0dHSHJsakZrSUVwR3JsNkt2Wm84TnJ0QStF?=
 =?utf-8?B?UXJYSllqd1h1bzdTYU0xZmFGRWx4N1NLTi82TVdRUWphZWVneEtJeFFXZ1ZF?=
 =?utf-8?B?c2lIbjJNR0gxRlRJeVhQYkNqTkdFOXQvV3c4SUhhNkY5THczUzVjL2JLNlMy?=
 =?utf-8?B?Y0FXNW9sQTJXMGN5Wm40WkdMVU01VW5CSUpTUWlyZW5UMTFaWlphRGdVY2pX?=
 =?utf-8?B?c3ZROWRpc2tYbk9relRxOXhDQi9BVDgzdytJTU0rcWtsTkpGU3ZWbi9VZ2E2?=
 =?utf-8?B?dk5mM0d0VGsrM3dwRzdiWG96T0NBejAyakZOVlBBb2JOaUJvYUl0TmJtNy9D?=
 =?utf-8?B?T2xPOCswU0lZTVRVWjcxZ3o4bnRzMVY2Rnk4SlJ4UExqMDZRMkV5R3VnNDZU?=
 =?utf-8?B?dTBBZWRFVTBQNytGdEx4TFdxSmFmWG1PQUhRTlhDdFhTaEN4c1J6dnlYK3BH?=
 =?utf-8?B?cmlyZDdhamZYajF2QTczTTg3RnBBZVVGL1NYRUR0ejVOSGdCU0NqYTVCSE9Y?=
 =?utf-8?B?THRmSituaTVuYWtYR3VGa3JoL3EvYzJ1T21jVHRpNVlDU0dmWjNwQmtoWXlT?=
 =?utf-8?B?WEVjdzhFYUEwN2VDTC9naU9iV2JoV1pFSXVLWmw3OEQvRHNiMVZGRnNveXZq?=
 =?utf-8?B?RFIyUGM4K2Rld2tLV3JoNWpZSXd2aTJCcmZyMlBzSkRMbzZ5WGdHUUJBY09B?=
 =?utf-8?B?YWl3WWd2Y2Y1aVNqQjljNzcxQWM3MVF2UzZVTjB1QmxOUSsrR2JwTmJHMEFM?=
 =?utf-8?B?QlpBOW1DVjJqOFpWRy84ejQvaGFZWExXZ1V3S29HZEliMG5mL1ZWbWpYWkZB?=
 =?utf-8?B?aWpTY0pVNElEeEZuWGovTnBmUi9NNGVxSGYxMmdhTy9iUy83MmlUMEtGOFpu?=
 =?utf-8?B?VXcrNXpFY3pUNEpVT3JhZFk5TGZRRGtXNkxONVFTdVR2OUhzbDdxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62c52c2-7047-41cf-b2bb-08dec2d7e48b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:56:05.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp72Vn3Jt8DytAf99F0BhiwF26E84y7hXHGH0GQsJHSuZswG69Vrn/WeGPoraisY/0SBCGUl+Kc30x/C+4159A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782


On 5/21/26 15:31, Alejandro Lucero Palau wrote:
> Hi Dan,
>
> On 5/19/26 22:01, Dan Williams wrote:
>> The devm_cxl_probe_mem() helper creates a memdev and retrieves a mapped
>> HPA range for the device. At present the retrieved region information is
>> expected to be established by platform firmware. A future update will
>> auto-establish a region if one is not already present. This arranges 
>> for a
>> simple CXL topology detach == Accelerator driver detach scheme.
>
>
> I have successfully  tested this with sfc and it indeed simplifies the 
> accelerator driver. Removing cxl_acpi or unbinding the related memdev 
> works as expected removing the sfc driver as well.
>
>
> I'm quite happy with this approach and I hope this is the last 
> building block for the simplified (only with autodiscovered regions) 
> type2 series.
>
>

No updates or comment for two weeks. I wonder if this is being 
superseded somehow and I did not notice.


> Just a minor comment in patch 5 and a suggestion for maybe changing 
> the devm_cxl_probe_mem interface call.
>
>
> Cheers
>
>
>
>
>> Now, automatic region establishment on behalf of an accelerator driver
>> also requires automatic region teardown. The existing scheme of
>> triggering devm_release_action() of a cxl root device to destroy a
>> region is racy [1].  There is no path to coordinate multiple devres
>> actions, or conflicting devres actions, without using the
>> devm_remove_action_nowarn() workaround.
>>
>> Instead, move final region cleanup responsibility to the root decoder
>> teardown path (devres action cxld_unregister()). Expand the root decoder
>> @range_lock, renamed @regions_lock, to coordinate region creation, sysfs
>> manageability, and deletion. The @regions_lock also prevents regions
>> from disappearing mid-auto-assembly.
>>
>> Changes from the initial RFC [2]:
>> * tested with Dave's type2 cxl_test
>> * fix region remove by endpoints (Dave, Alejandro)
>> * fix user triggered region remove (Sungwoo)
>> * fix lifetime of the @attach ops (Alison, sashiko)
>> * hide @attach details inside the CXL core
>>
>> [1]: http://lore.kernel.org/20260427032010.916681-2-iam@sung-woo.kim
>> [2]: 
>> http://lore.kernel.org/20260403210050.1058650-1-dan.j.williams@intel.com
>>
>> Dan Williams (5):
>>    cxl/region: Block region delete during region creation
>>    cxl/region: Resolve region deletion races
>>    cxl/memdev: Pin parents for entire memdev lifetime
>>    cxl/memdev: Introduce cxl_class_memdev_type
>>    cxl/region: Introduce devm_cxl_probe_mem()
>>
>>   drivers/cxl/core/core.h      |   2 +
>>   drivers/cxl/cxl.h            |   8 +-
>>   drivers/cxl/cxlmem.h         |  27 +++--
>>   include/cxl/cxl.h            |   3 +
>>   drivers/cxl/core/memdev.c    |  20 +++-
>>   drivers/cxl/core/port.c      |   7 +-
>>   drivers/cxl/core/region.c    | 194 ++++++++++++++++++++++++++++++-----
>>   drivers/cxl/mem.c            |  95 +++++++++++++----
>>   drivers/cxl/pci.c            |   2 +-
>>   tools/testing/cxl/test/mem.c |   2 +-
>>   10 files changed, 297 insertions(+), 63 deletions(-)
>>
>>
>> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
