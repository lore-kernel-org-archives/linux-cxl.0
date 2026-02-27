Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F914368978
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222452; cv=fail; b=MBS24UFF8FWfqil8XQZ59mPyLnskYp1/VOU5feJeerlP5cPcWonxgXBCHISVuCpF0pHhlsbYMUiQcosq+jL9PA5fKuJ3AGNtoEvUPS8pXI9+L2zq7QHiiWoIGZIwU9U8c2xhVSw3WNqbCbTYmG1vJU0/SmwaIyrA0ekuWYoeDj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222452; c=relaxed/simple;
	bh=MWC12/2+vilrCgnBLKbO89Hkqr1IpCnMHbjueZ+Mxzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p209zKG8o6cwXyMqLIKK/JWC1ieMOrPMx9cqx5jDzGPyu2wQmPTINKuJIUdh5hjUd2Od2cv9x6W/QZ4sHrvudA+aqNp3CXblA2L25HKNOkeRTWJ5LSQEWmDnkQq2PZE2RmIYPEbb0IunzNwjygkRF2TJfieUQ+G2CTJYPH0Xp3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mljgmGbs; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mljgmGbs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Or8CQ9NEijKN1tTMhMD4/fal3gJG52euHxpCACuX7w/PWbOQDMcSYZAaf16jPTMBnQyzlo7cDxmF2ifk+BzhxaZNVXJQotO5OmgPNavHwxQQWoFnM8c2kRV4EMeS6GMMwh0RAfmKcsK3hTFf4R+iIAjjIixyT4i0D0qAOqktS/W8UlDvk5g36yuVfj62ZriVzek36UYbyDw/kdfGn3WYMs/3k5aKLBFzelVebwRYljBqfN26ydOqceQ15Et/Fci+FsveV8SNEQHAm3GketGSSUHshidBG2PpRRY5l4AjAgZeUhURoEUEMjdao/Pnur9pMfN0veP4LZirNxDHrKf/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w+evMi0UftU5lp3qJrWkXTWsPOOlea8Uon8rmmL5r0=;
 b=Sp/CpsaZr0/e6Ht1bhiRFFpUvXWdN8Bu6/AhAREn70Mu7ihhYWL8LJJOyLL2UIM4wytpBixw07SjlN9Hy6YOLSYBLtjNZXLc7R1SpN4y1k0VLcesktVI3W9AaCtXz0O4GAYa0WAm/b1iGXuYVXiT/p1Mp8M/SXvn6/dsJjpyNcm49f4VbUgh+Np2tclHhDaIkxlJuQmvrYDoWUW5yjAPAePu1rnmSh/VoNpWaZ+iG0RpLEVsnj6IWk+xNTb55YTO/k+/KwbLU3SAlD2dZKUtTXZBLmlK7qDquNU7dw9EJwG9pMhJEgqHN0esM34T66z2zNqfFmy3/wZIihNf1MH+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w+evMi0UftU5lp3qJrWkXTWsPOOlea8Uon8rmmL5r0=;
 b=mljgmGbsSfPwDr1Ay74i1ehB9i4NPbT9qQt0l6NM8gfDOU7PsrL5OGjJJv+ifPIwzyEHHjEeh4uPZmb/mDQEHdhb6vYU4mguvrjtOC1X/f9ryNmtsugPwTNqwQB5ftbeFpyzLzYgenY2GgEkhOwILwjYe/b1isRAFlqT4+hRT/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 20:00:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 20:00:45 +0000
Message-ID: <1d8a1726-d90c-4a11-8616-d978f69e215a@amd.com>
Date: Fri, 27 Feb 2026 20:00:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cxl: support Type2 when initializing cxl_dev_state
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, Alison Schofield <alison.schofield@intel.com>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
 <20260225121430.3839189-2-alejandro.lucero-palau@amd.com>
 <20260227121443.000011ff@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260227121443.000011ff@huawei.com>
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 10145baa-b8ee-4ecc-672f-08de763ae4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	uax/odKfCxdjbfMJKAPwdEhWEp6OxbkcdGLcErp39BQRzi78tZYOvjm2al1D+aayP3nq0MW3nDyD6+aiCgLM+Sjx+eMJVH/cWRI+JlvwUPWBynZNJBIaf3sjgyykOZBtLyv7S80ysQahJ7di2huHrfg0qC3LISFbxSgoJEbAL+5o2Dx/rZ0o2yQ9+i35Q3ig2NV9CTqME0Y4yjnUhdT4MqnHC5tndYpIgcF0hImQFG70gScWituC91OThXDzIsWgdgW3dZyDmdXRqZbbl7+SKfVkzstRZJ29MbIB8wS08osMNs5sM+IVeoecxezK/R0+4qzidKGqFqbwa24VHM/PthEEYgwteJP7jo7rDn2SpkKXf/tJQ7PRL5vp/r8I9k5tPnpfK8rxZLYIlDs2a9PmAnL20knoxG4Ysgq3wroqahr2fAWf8yd6AHbmOep2aAnzc5+B3x7F2iFnqihhI2y3g9AZZgOpyDaDpHdMekYomSz8qV8CuQMWGLhWl3p8EIs91T/pXFWLPYSCbVvYBYaquv8vmq8Ug1lYAj6fg030kPNY3DkhT6NJhacW1/ttUX6D/UFGFZ39LGI+zDISmmdbiMqZcofCrL4aSQToS4hVOEQXjZ6K3UpyC8UxXjvZ04TNZeImSViN+QjMW5aeTOPk7o8G/jxs6HIfOY7n1iVF62nBYWvWXkdFVwiDcFeH8YIr7+yl9f0fmhIdo/ASHCaJzxApwISzDL4F/jIcRhyGuQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnJSS2dFZ1FyTHdmQ2xhWFdDbHhCUGRsbWZ4bjhSM3Nrb0h4WUlnZzQ2ajZN?=
 =?utf-8?B?MTlQQW1kSzJXWFJXZUp4WCtxbHc5M1BZcUx1WEhuYXJGN3JMUFNPbG5XQlEw?=
 =?utf-8?B?emg5N2RsOTNGL0RibDZRME1vWWREcnprWTcvR3VoWFJwNWVTV2RkMW8vM3lZ?=
 =?utf-8?B?aUdsTnFXcUNwZmlPNWtseHZ6QmFlNHdlZEpwemk3S0tCbCsrR0dmOVZxOGY3?=
 =?utf-8?B?QmRZZjd2Vjk0dzdhYUlIMTYrZFBaVUlRcFlDQnBEUEpzNWQvWGRjdCsxNzhh?=
 =?utf-8?B?ejZoMFBTQjBIWm4rclNkcTBlWFN2QitORDl1V0pWTG5jVGYxczUweUxkM1g3?=
 =?utf-8?B?Sis5UEZtUWRRdmQzWm9rSmYyanZrWE1OM1AwZ3pPZ3hIV1VSaWE1MnVuY2ZB?=
 =?utf-8?B?QmV6dVdiRVdVczdtN3haYzc5SHNzS2FTOFh3SEw3V3B2VE52Y25ldzErY2hp?=
 =?utf-8?B?WlMxeDQrMFp6b05yMFpvcG1SRExSWFJqTWVZeW1MVUdETDRyeXYxckEvb3NY?=
 =?utf-8?B?K0tuTzlyMFVPZ3ZXRWtSTTB2ZUIzTCtDY0JsK01LZFRPMUJleW1vVWQ0S1k2?=
 =?utf-8?B?RW1SWVpEL2JXbVh3VGN4K29xaVVoWGU0T1NwNnpDSThLRldRUHN4dW5QcXdx?=
 =?utf-8?B?WGVGM3Y5UmJuSmpNMyt1RmVOY3hqUW1NYXpPaDNKYU1zeWVITEFyUGpUcDFv?=
 =?utf-8?B?RlZOYXRndFVLRy91RjZMMXZWYlJOTVNGUmhUVW43cENtZWN1ZzVhNTJBUE4r?=
 =?utf-8?B?S1VocVl1aGxqNFVFK1FLb1phQ2hqWi9tbEtEZjhrbFFTWmxQWjVwOXdSTHNp?=
 =?utf-8?B?OFp1eWpGVXdHQTRFVldwN3BhMzlrb2JUeURXUHcwQXBIMFFHN2k4OFJsRzEz?=
 =?utf-8?B?SVcvbGx3QjFkMTFqcFV1YzlXSDkyekRSKzVtRGJ3Njg4alcwYSs0Wlhhempu?=
 =?utf-8?B?eC81Tk0zbW9BQURYOXU4YmY2bFIraGtSYkV6cHRtUURYQjFlL3NJODRRai9D?=
 =?utf-8?B?eWVRT09rWXBqYUhwdEw3WVVJclFTKzQxOEJlcDRoN0hzQURvQms0TnlpNzdL?=
 =?utf-8?B?VVkxMG94ZGt3blk1bTZDb2tFZnFsZDNIM1BqNzV0WmtNd0FncDdTbmlubHVF?=
 =?utf-8?B?M0ZqZ2RkNkU2YkpuRGc4RU1Jb1E0NUdqTzljeDdXN2xvUjlkanZkaFFtek9m?=
 =?utf-8?B?QmVRc29BUk8reDJ2Rk5NcVY2cnVCNWJ4WE1ZK1lOTFNkaUJTT050MnNWTlBD?=
 =?utf-8?B?WjdsYnZBY1hrN1VoeGtnSGp3a2ZqMml3UGV5RktBSDlQNWVCa2xGcTcxdlBW?=
 =?utf-8?B?N2pUaklETGJCKy9udktycVJRdWMwc3Uzczd0QzZPWmhqMHFxcm9rZmxleGQ0?=
 =?utf-8?B?MGRFekZtNVJVS1VTOW55d0VUYXlvK2YxT3NOcm5JVEdlSTVLcVlGOG54eDBP?=
 =?utf-8?B?c2ZlMHRPYUxMM21XZTZBVC80QyszVVVabzFwblQvV0xQOVI2ZkwrdlZ5VFRh?=
 =?utf-8?B?aXVHUnorZGtjeUVPVk5BSVAwYjNybWgxWDFKam12Y0RMdVdhMnlMb2FaUHIw?=
 =?utf-8?B?Tmhpb09iRC9McDZNTUhmQzdWdCtLN1B1eU1jUHM5MWZKQUYzL2wwWnRxSS91?=
 =?utf-8?B?UTJLQjhURUprN1BvWHJvZ1kxSm8wVzduaS80aThaMGF2OE5Jd0x2aTJFWDJo?=
 =?utf-8?B?dkZZbi85RkNqZFpybkU3dFhqL28xdU41K1c4blBaeEJEWmRDWWlsUlpjMFpz?=
 =?utf-8?B?ckJxN1JNcktzMFhSU2d1aGhUWWQzaXduZjh0Mm94bHA5TEhPWERCZHB4elI2?=
 =?utf-8?B?ZE95RVNpYjh5c3I1cGFsMjVuOW10TzVNNklPTnQ5ejNDdFZaTzBPM3RuSHdH?=
 =?utf-8?B?L3VoUXJ2Qkk3Q1dRcC9NbXErQ2VMTmIveXoyK0x1b2Q5dDR5am45ZjQ1SEdn?=
 =?utf-8?B?WWNxdjRya1dveG1Xc29RcTZxVDNBb1hLTVpaU2dUWnYrNXNCQ2s1MTNSYUlU?=
 =?utf-8?B?WlBCSTZyRENFM3lXYmQrN0JKeVVIWWhtV2NwWWZleUxTUW1hbDdPVUlkTVNh?=
 =?utf-8?B?REpxaXR3d1VvNzU0TTFqMitwaWs5ekdmRk5HVUx0UmZGSG9XcjM0UkQrUWVi?=
 =?utf-8?B?RTJQNEJ4ajBqbTRGMWhnNTl3UDBZZUJSWEc4emFvb0pVNnE5d3dNeXlBQ2sv?=
 =?utf-8?B?ZEdLa1JyampYaDlPRlVXRW1nZzVWb3dlR3gvdmlRNEs2UU5YMEk3TlNwUDRh?=
 =?utf-8?B?YUhwcHYrT0FCY2dINDY2Q3E3ZVF3Nm02MFpCb0YrUk9NalRtYjFxK0lNN0J4?=
 =?utf-8?B?cDRUTDR6U0xkMnJNaHZHZjRkdDN1MGtkaHpOa09XUjBYODA1eC84Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10145baa-b8ee-4ecc-672f-08de763ae4fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 20:00:45.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjgZs4b0PbZ8/kM9/XApVNW5GLuMX57YLgEu7JFI8DSmKqfdVDkkBgbHtcd9/pN0gHi14AfTn/yMXHeLttIYug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202


On 2/27/26 12:14, Jonathan Cameron wrote:
> On Wed, 25 Feb 2026 12:14:28 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for type2 drivers add function and macro for
>> differentiating CXL memory expanders (type 3) from CXL device
>> accelerators (type 2) helping accel drivers to embed cxl_dev_state
> Slight preference for
>
> "to embed struct cxl_dev_state"


Right.


>> inside a private struct.
> I'd be tempted to call this "a driver specific structure".
>
> private is a little too much of a guide to how this 'might' be used
> in the long run.


I'll change it.


>
>> Update type3 driver for using this same initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> One minor wording comment below.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index e21d744d639b..9daf4bc42692 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -523,6 +523,37 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>>   	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>>   }
>>   
>> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>> +						 enum cxl_devtype type,
>> +						 u64 serial, u16 dvsec,
>> +						 size_t size, bool has_mbox);
>> +
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
>   * @member: name of the struct cxl_dev_state member in drv_struct
>
> ("as" to me implies a cast, which had me briefly confused).


yes, that seems better.


Thank you!


>
>> + * @mbox: true if mailbox supported
>> + *
>> + * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
>> + * struct initialized.
>> + *
>> + * Introduced for Type2 driver support.
>> + */
>> +#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
>> +	({										\
>> +		static_assert(__same_type(struct cxl_dev_state,				\
>> +			      ((drv_struct *)NULL)->member));				\
>> +		static_assert(offsetof(drv_struct, member) == 0);			\
>> +		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>> +						      sizeof(drv_struct), mbox);	\
>> +	})
>> +
