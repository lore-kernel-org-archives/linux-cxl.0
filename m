Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28798368978
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222532; cv=fail; b=IlNjHBB2vaPLztftqBsNb27aQxaROQlaXhqxgOjRmM8eMMaQis2ULKWbvXe0V97hvfp9pGFQobjUmDCk+B5gZG5HO9iMsnwHym+4kROqS/4bM8+3ZeM7SpY6Am3swvMLOvbvHnFsmdCH54jEo44gOdsICs2hg7gFLeHfEa/W65U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222532; c=relaxed/simple;
	bh=E4+Kw5c1xlOffN3AJy3pXKSOwK8oB6wi+lo8WIQenMI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CTZPQZP2HZS41K+3pbtWpuQ19UyRTycJpiMFbo8ZliZK5iyHy8bML/XNmgq/mN6ASVqdLhOC807/kvURy53KghLzud882bydrMoHThFtIeyu20KpixLoo0eqqHoIUcn06XU9dKKSq0i1wDEwbqe4HVYF6VVaMoc4yXTK7/pHSCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yVRRGyPv; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yVRRGyPv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBixIS54kYf8fLlY9MlZjD5jXYxZWCkqHE1qtfob8YrrfbZUJx7gGf+kN6jYSGN0mremgTtsZ824l2qYOZg3cU6N5bG3KRfUSanCL+T5WRIZThfzxoZSEGq0q66E5Oa1fAAuxLdgKiUgJyxHgAZJA1rjaYFDylOF0z/ixETprVrKvIsyfBCZYWdL/v2f2EoRKXWe6BcV2P3W7marbH3UyjDL0DjetSzZEyknFwkPeD7/3M/k9VKSXyFjr6krGPRow0wkvQnveAEjQpb6fV5a2wXHcUhe/r5u2pdKakAfkxYsa3RkpDveTxhhPGTct4emWI0R8Ea6Xee0TTNwSKA7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Qly+WSRguxVf2DVNvPnVvX8pwbnrDTrcb3OnGnsK1M=;
 b=o7GC2+a7I2BpNlV2Kfl8fTgvrAKxRxpJGdk3BZl+z5L4fS/3eZYdhfDhqgCuzcn5tTUfDP1RPIHquY8aE1sL1qgftV2gWFQm5CUQQYvOtax0Su+ncA7yXzuoKtcGi0EEscLxuyOMrm+5NNOLj7C7aRF/2N2ZU7I82tssa055i74FXk6dT9IwxqRrgZ9PIsU0AJm6JkmkQzE6YevqxvEVP2xmx5tD6RnYZ5OU2SDLlMgBtt9oWYIazWIOW4RVOGkZ556G1m1jKKkC6zNODu3sEwHDh5lWDZHvHT+NocqQ8Ex1UU3qWiwdP8cXudhKSYzaX171io+/P3ooDpEZfYN5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Qly+WSRguxVf2DVNvPnVvX8pwbnrDTrcb3OnGnsK1M=;
 b=yVRRGyPvoVe/snMHDmnz1LrilOg4hDm9D/973WMoDzZh6GMN+/rqPAdSNyXb1OAd3RB0EaGGuyZDM3/1xGeZurC84Sux0oLm3CtQP/c7VPAlvMfelTS0Yguxv2z0mUg0TQmewpW0PAXXwDPqA8+wu7i1+Ch9pC82+vv0Ugl/jpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 20:02:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 20:02:06 +0000
Message-ID: <bcd5aebf-2c51-410c-a655-ad7cc790bbfd@amd.com>
Date: Fri, 27 Feb 2026 20:02:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cxl: export internal structs for external Type2
 drivers
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, Alison Schofield <alison.schofield@intel.com>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
 <20260225121430.3839189-3-alejandro.lucero-palau@amd.com>
 <20260227122144.00007cc0@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260227122144.00007cc0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d10eb3-01ea-4229-03b4-08de763b14d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	Ia/9t5qKSo5aNV5YcXH+XiWRRDhK6vD5+J+sG/ULPhFuBvVbXBFpKRUF5WV17TunWgN9OMvXEd7z/39nMO5bxalhyL2fQF6DjrYmPgH4+U4s7mddLfK9Cg4iD8XrxGnybFXKjFqZs79GlLfCPS3IRtHh2doaKwPg94jVgZDIGXpMlrqx4nUn+xE6Y7Qmk5hNWsJsMqLSjDOZlLRoUuB20ksIGcpy/pHb95t/Tr9cGVF081XNz+wu72GpAELmNvypnQ5RuRwBqqxKaJS83PoS1KNTiiU4jB2QpnXLM+T6e71nmDdXfBFPFcRBu6nnyn3M/12C72qYOADKUjWaKTd/eSbff+BcX/by1YOv+8bwimiv0r+ESnIX67jCyuO+gIoZWV3FQS0vTpSA1s2FAECkWpC68dwSAkNWjHz8V7hDLR59R3NMj7kbQ6pEnXpTMjqQaQXSKccvIfDp7n0+m2PlStCpyxsNQw8AictPATDYCXPY44i/sJexgUtK+B/jAdtdfSnRnoOjI4CnpwXpFdLviruAecZyA1aqQIgUmLnA9prq4zPQpiIBwCxj4X4izatV6mcQrBFLU9GHJvR/t7o6JAzWQA+ny+aE1m6udFKlOTWF+ix5vgovssra9eKld1TJ6OFUevvDiFa6k6jM29RwZASAeKIP5FwvtrrzzPpKwhD322tqTrGsvsZjIvfgJQ8EtvephQxhd9gRvCWQqLbyspxINwLoB/Bo16fnEN4V3CI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWV1elNtQmM3c0ZaU29hN0xWc3F6TUluWDlkaURxOXNhU24rNnhrVmNXQW1S?=
 =?utf-8?B?ekJzYTVWcW1kNDJHRWJLRVU4N1RoZ1NNQ095aGIyaGJ1SUVObkx6L2JjUXRV?=
 =?utf-8?B?R3I5aThDMHpRb3pQS0pTZ05CWFM1VHJVbmpvWnRIMGRjczQ5OXpxZThkL092?=
 =?utf-8?B?VWx6NzRvQVZIMEtSOGIwZEdFcGIzUUJMQUpROEYrSU9heXNBWkpBeTV1eklu?=
 =?utf-8?B?SDV3amFTMzlxYkMrMGdDdWRNNVlrOWw5ODd5S0MyL0dsL0k2MXMrOXpjRDlC?=
 =?utf-8?B?dzNwd1RwUk5Ud09EeGlicWxDbnZCamxFd1dCZzk1WDVaTi8rWm42OFRJM1dR?=
 =?utf-8?B?aVh5TVNVd29wQk5PRTJYRTB1a3NFMXhFSkcvYlYwN0lEbXkxdCt6QWhrUTJV?=
 =?utf-8?B?bmhiVDBzRUJvTHNWbmFiUC91L1c0dWlFQUtOMWxxR1g2V014WVhza3c3KzAw?=
 =?utf-8?B?ZUY0dXI5d2x6bmNVZmNLajBFdW5ldVBvTHlDd0M0ZTJHMlNFMi9iM0c0cUFa?=
 =?utf-8?B?TmRNeFhhaS9kUTBDTFdtTU9ZdlFZMkFGNHQ4bUwzUzAzelhWck90b3JyUFl2?=
 =?utf-8?B?VWx1RGZTNHZQa1ZScld5TEFpc01hOVdaTHZ2NFR3MDdXVHNRdmM3UmpmSUF2?=
 =?utf-8?B?OVk1aXVVb0FkaEZmR0ZDSXJZTG5QV09jSGlNZWNVVGxFT3VUb0gwbEQ5RWt2?=
 =?utf-8?B?U0VwVjJVL1JnTFQ2MlJYZkh1dXRob3YxVm82RUczeXg2aFdQdlpwUGZrSnNH?=
 =?utf-8?B?dk55cTJNcDZWTTRQeVBJdmpxY3psbGtLcUorUlExNWRVSmdyRmgvSUhCd0Rt?=
 =?utf-8?B?RlIxREVXNC9kWldBTnlnN2p2L3hWYlNnVFFaQWlIWUkydFJGbmYrUUR5QWo5?=
 =?utf-8?B?SDBYU2MwZHhod3VzUUsxcXdDQVR6Y1ZITVlTdjltY3hENGcxR210VHN1d05X?=
 =?utf-8?B?UW1qVGN5VXJLNkVpcElrcS82OVJvV0NHalZzM1JNcHFEMkdhRGp3dVlNYXMx?=
 =?utf-8?B?dkg0NExyaTRVSUlaSUc2a3RwWHlQbkVGTG9BU3dMd1lyOWpoOE5kcUFxbGlK?=
 =?utf-8?B?ZG5TdjNDeFRYOE41U0l6YzZUdkRxUHdjRVl4ZkhRbCtMemlDNnJqZXduTDlS?=
 =?utf-8?B?SFViTjcvTnlpWlRqZU12VEsrUW5IK3lQWVd0NFJ4TGg4dWRSbUJHeGltbG1r?=
 =?utf-8?B?YUdybmtpZVpZR0FUVG9Bb3pMK0NrZ1NKR2ZWRG5ESHNITmJhbS9FMlhoc2Qx?=
 =?utf-8?B?SXZzclhJeUVJMzB0ZHEvR1NVaWlhZnZrWnJ3eFhCckdSQTZVYXZVVTAwM2tl?=
 =?utf-8?B?UTQrZ1VKcXFqdXhPQUt4Zk5FV240MExoSlRPdm9QZWNNYlVsaXlYK3kwdUdL?=
 =?utf-8?B?ei8vTU0zYTY3NXFrS3h4Ynl6Q2Njd0hib0ZCMEt1QjlSWk4xcHl5dVlGU3Np?=
 =?utf-8?B?aW5GczAvSU9iQ1VCZ0EzOUJqSkZGUVdYNEdaRU95RUxEWFJleEVyUlBTb0pK?=
 =?utf-8?B?U1AwbldHUmNOejlkQmovT2s1aktBNHkxSUUrSlpwRTZoeFpNWUlTbHduVGhR?=
 =?utf-8?B?UDh4MjNubDVCc2EreUgxSlBKMHFnQlRUbWpjN2FQRTlLc3daaUE2aUxXbFgz?=
 =?utf-8?B?OWxHcEtzM3VTVXZiRGJ4Yi9wMzhvM0xhQkxNaEtTMVBGdS9Ld0JEMkxwVUw4?=
 =?utf-8?B?aTRjMEFQZGs2RDJnc2craXNMWE5JcjlyOU1VNldLNnM1TzIvdlFHMlVNNHVH?=
 =?utf-8?B?aGpSSEorSVY1bXlqT1VOOXlpOEl6WFMyU0diSnNzTWhVTXNDRG92UGNrMFhE?=
 =?utf-8?B?WVVhMk9UM0gvM2hRSFVoaEptajJrTHNVRkNPcWFDNG9lSFdlM0dDOHhlakNs?=
 =?utf-8?B?cldvNzlJVng4blVIZ3BSRlpreWk4U0Z2UjEyY1FwTUZOVER4MW9CM3ZuQXR1?=
 =?utf-8?B?cmpXbkdTUXpESVN2Znl5c1NSa3RvaWs0bXp1S05WTjBVTVVHbTdMcnZFZ2xx?=
 =?utf-8?B?a2cxUW1TOVQzZU41RWRBNlROczZHWlFCNmdwVTNNc1ZOaXFuVWxJT1Jic3FR?=
 =?utf-8?B?UzhnU0d6UDJFNW50VllBZW1KMWt1VCt4bjBsUGxXcWtmODFMU1F3TGUzQ1ZO?=
 =?utf-8?B?N1RxQmEwbmtOUXJ1NmVrU1NaR1hVdGx4aE9EdXc4ZUhZU3RKTHBWTlc2bUNp?=
 =?utf-8?B?K09Fa051WTlJU2VzK2ttZlpPSnNINkhQTWlIdkZFcklBamhiMFkxRkxsalJ2?=
 =?utf-8?B?LzR5QzBWSGsvL2w3MVV6dkg2d3duYmRBSjN0L2t3WHlnRnJDYlpLSXIvOUZL?=
 =?utf-8?B?bHllMWl5SGtjSWxtRDB5ZFVNNm9HWGFQNkxkWHlRMnEwblNySTZNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d10eb3-01ea-4229-03b4-08de763b14d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 20:02:06.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqcKF5qE7+Wox5xWDGoc6OK3Fe3m1qbDeapReF8EsGrJdjrXIct3vPm3XuPBVO6SmJ209Ptiz8OhVKEgpZsXhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229


On 2/27/26 12:21, Jonathan Cameron wrote:
> On Wed, 25 Feb 2026 12:14:29 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for type2 support, move structs and functions a type2
>> driver will need to access to into a new shared header file.
>>
>> Differentiate between public and private data to be preserved by type2
>> drivers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Tested-by: Alison Schofield <alison.schofield@intel.com>
>> ---
>>   drivers/cxl/cxl.h    |  97 +------------------
>>   drivers/cxl/cxlmem.h | 114 ----------------------
>>   include/cxl/cxl.h    | 226 +++++++++++++++++++++++++++++++++++++++++++
> I'm a tiny bit dubious that this has 'yet' reached the state where the copyright
> notice in cxl.h is appropriate.  This patch for instance is just code movement
> which I'd not consider sufficient.
>
> Meh, it'll be valid in the end!
>
> Trivial follow through from the earlier patch.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..11f76d61c9f1
>> --- /dev/null
>> +++ b/include/cxl/cxl.h
>> +/**
>> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
>> + * driver specific struct.
>> + *
>> + * @parent: device behind the request
>> + * @type: CXL device type
>> + * @serial: device identification
>> + * @dvsec: dvsec capability offset
>> + * @drv_struct: driver struct embedding a cxl_dev_state struct
>> + * @member: drv_struct member as cxl_dev_state
> Follow through from previous...


Sure.

Thanks!


>
>> + * @mbox: true if mailbox supported
>> + *
