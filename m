Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA531B101;
	Wed, 14 Oct 2026 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999016; cv=fail; b=DLAwRHZB3TGFSoMiN3pE2N2PfJVtzGL2kfGj+NeDNZZQjWXx0oVbeW7aTXqfphrt8jA6mycVOjBTyruzjcV6+9zydGifoeVEr1y4gMi3O4niWvgSpOypFCDgphF1z6Ox8NcFjqYqsVem8OjoRB7CwrarIqqBhO3AqD9eHhDF2Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999016; c=relaxed/simple;
	bh=Z3OMmay6Z+GrEv8V6HwpgkFya+5l8r6MVPRUFEKOvPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLzNW92JebuI2XrBwO7vflSvBAuS+l+8kzkXaPJr24dW/qP83zFfCNfci/i1u6jlDidOkq9O7lubP0VYSlK6DW64tGN3o1RQc4rP5/3c+VaA5mLWpCuYYRP/NdyWSN81MbzDN8DLIbrA1x+aKyN/gA0GmWqX5Jm4G9TvdLu93kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a7XzTLKP; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a7XzTLKP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNyC17pvBOvXqo3eqYwdGs5HT0GG4OP9PGRLp0nopP4EeYOp8429gfoLjXELu4uVys8N5MUqVtJ+nJOY1weK4zgLIk54/qT/zcogEbWSIqKf1OFOFrLaZRc0dDw0iZ4S0DqGPu+Kx7xZscX3thTvxLLMLY3kBVd4dyTK1xBzIU4uPPhYZZFPjbrMCyXGHmb0EHAJoCB7htpoqnBechi3772tewbEXpI3T2Ch4vQtupQxLHyFE650UXKKJ6v/rOk4f4F65w3XVXcaGbAMu+R5TX5wIqCgJxpFOsf7zcH4u1amI+quAqnARrR/632RLSXD9tp/Rm6VEnA2WICNKF+mLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xR/1chC5NrZ/I4ulSQrQHm0pmrWBhsQDUX1rIjjVGo=;
 b=ULCObJJ00SeKbkHeBaxbv0qQB7ihyrVXHN+3+XsIs+G/W0wyabZMiJJ6ZcxCcG27A0WEQ8A4f+LgSRgOa1EOvBf7s73/MwW+ZvPzylKhL4HhgrlR5jmxmycbkvdc5jyztQG4DJZLKFxQVuOu97Z3943/4Na3r0+Bz+kGg/PXIe56mNf4/ptZsUQ4iHBzD5ShV94ulqV4zp9cin8nfA2AGAqeTVohsFpZmN3W2R5Cf6dUkH43H73Q04P1t6PMQXWRcWo/Ka/Bg/vEnmylaHcwWnJXhyOcUa5yhV7pymMKufZQfZWLnrcXAGg6zszGoNXhdmty1A0Ux4zP0txTKJiO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xR/1chC5NrZ/I4ulSQrQHm0pmrWBhsQDUX1rIjjVGo=;
 b=a7XzTLKPAmWdueQlivH9Danp4MaHZPGf/YpwgIwFgknk/xZ9xPIaeoX5PTAhTGtAllOoPfo3J1myeHJ9ewERtzp8B/+swLf+Mku+vSqeCgxUM+NFVijrpCjqqlJtmqvRWL11mjPI9Rc+N12YvSxi+X5WDy6w4HQRaC1yw9R1EJo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 17:30:10 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 17:30:10 +0000
Message-ID: <89cdd4e8-31bb-4047-bd36-0ff5d7ff4c39@amd.com>
Date: Wed, 14 Oct 2026 18:29:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] cxl: Provide explicit RAM region creation for
 Type-2 providers
To: Dave Jiang <dave.jiang@intel.com>, Richard Cheng <icheng@nvidia.com>,
 jic23@kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com
Cc: kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
 kristinc@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007090540.43817-1-icheng@nvidia.com>
 <1fd14fc6-de0d-4980-ac8b-8138dd5ef17c@amd.com>
 <3466e889-82a0-41ac-9013-7d21020b5092@intel.com>
 <9427af6f-e693-4cdc-8fc3-21c529888125@amd.com>
 <ccfb14ff-989c-44c5-96be-a092a5c0fad9@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <ccfb14ff-989c-44c5-96be-a092a5c0fad9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0369.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::14) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|LV0PR12MB297887:EE_
X-MS-Office365-Filtering-Correlation-Id: dccf5bfe-35f0-424d-c797-08df2a18cc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	D7IfKJYuhnCvhjsSnLosDHna8VtX7rbfSTPEZt4MJiUnBmH8HXBpQIkCUcmJ0eB4YE5akRoIWqYXODFkFC+55Dj8m5eoiS3TFLcBz3IW3JZpEEdSTrASUOpUSPHKFjcz3+iO3Uj4YPHKeQtw6w+wof6LP5YK9wKT56OpbLBFazEsusC79bhSZ5CICMgyr7nFartFrEKs8LT01V2kPCU5QSqT67KHlPrma9XG6YSuiyED5hbSHaLwFv0eC75qvHhSrZsvpTK9E1E2W19YNgVg8ZrtBBbU5OrtaoEHqKLiqwXZfgESQhpJ6edratpyoJ2lZ0ARNgxxBAFHAL0IjQ7oi10y6HutC1NBjGedcuGc+POzSBpmjv44pOKPVUxohuUB7BgvILNkUa/qJ/XsyyPQPxuV8snb8csIwWsJ2gcBuZV9zIYGLzYwLsshYWTBZpVP31YUgGCjeKUzcuN71iQukcejONQlOJaGs4mFBWcJVWxBRXdDY7xXbbWAuwV9eBZ1akWxHoD/2cfKSGwEUSn75TbzmIXgOzBhECtSYo/7lyefBoC/AyRSzRUFfF+RDCGXGovfxCgpTrKe1UB0OXoxSH7ddS6YCpWFOW0+sykYFcNTzYMAf/zXmFJaf+f3UNvv5cHzYoJNhtYPSbu+SYHfKFToKsajQXo6OMBFfDF1rqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG51YnVBY0Rwc3hjRi9LMzdYYlJtNmY5STlXeWhRamZMaS9iSHBLY09vYWFU?=
 =?utf-8?B?aE5sdUQ4NkppYXd0cGJVV00xdlQwOTBXV3BEMzVITzRINFdWZ3Y5bW1vc3h2?=
 =?utf-8?B?L3V6Q1RwWmRocUU2UXFKdFN4RysyL21FeEI1QXl6czZVNUQ5TmxnU1FtZmk0?=
 =?utf-8?B?QkhwSC9qNmZVVkxaTU5RRFlaMWN3dUg1a2liNExobGZaR1pSNDVwWFFBRXZi?=
 =?utf-8?B?dkx4UGgxczhyVm4xdnNlUXpmdktoVUFmZTRwSy9GbW16NjRMU1Mrc0s5SzFy?=
 =?utf-8?B?S0VHR3J2VU4rRFA4WTdoczNmelpzejhKYkMrSDlZR25YWWtGbzRMb2h2bWpS?=
 =?utf-8?B?N2lZdUM5VEZkZ1RVSVowVXdWMTJHY0F3QUtXdzZFQkdaajZZL0JqSkc0NU53?=
 =?utf-8?B?RDVRdDhkNWFsSVR1TTd6M1RTQ2swb3U5R0tVM0NQWmNyeUJYaGtMLzF0Ni9S?=
 =?utf-8?B?aHJFNGY1UERIVDdWYkJuM083NlNtbFdhWHdrdHJjMWpqKzkzTlFaODVtbk9L?=
 =?utf-8?B?Ukh6Smk2UmJOQVRYN1NoY09HcGdqNE9TUzBsaUV5L2RDcTV3ZHU3VThHYU9P?=
 =?utf-8?B?a1hHZFlOa0lFZUdHbHNhOXVZaVFyMEl4N1l3OTIybWRkZkRpSVA0Wi9WNFIz?=
 =?utf-8?B?eStQK1dxVE1ROS9FWmZ2N0JnMUx1RnBpbDc5ejliUmY4dFh3ZGhveUhrc1hj?=
 =?utf-8?B?ZmRJdVZRSWtGMnI2a3R1VFJZRVhtek5VdjFVZzQ4RklJS21lN1pjclJKRWZn?=
 =?utf-8?B?RkhHZTJoN3hjWWJYalBCblNjT0JHUHZtM002Y0hxZmtPL0gvbVl2MitSdFlV?=
 =?utf-8?B?UUt0S1I0QmFaVFNuNERlZDlWWVZETlZpeUxRZ2ZRMDFGMzFJbEl4NW5EdCtS?=
 =?utf-8?B?MVNaek9qT1RTR2lLK2ZjTnUwZXQ1ckZJNEJsbWlUL09CRmx3MVRWSEZCRDhw?=
 =?utf-8?B?TjZtOTduTVFrWm9tWWU5MU83UTVmYlZjRE9zanFVSC9JMTJWdkNsUTFIc1B5?=
 =?utf-8?B?b2JiMi93cUwxdm5KMTFtUVNpY1NnVzBFdEc5SHlqcWlyWjZrSUR1a3VlbTZx?=
 =?utf-8?B?b1ZaL1E5QVV1M3k3L2xQZ1J0bEhMWXhLME1uTmVhR1N6ZTE4blhNYWNGVE0x?=
 =?utf-8?B?V2hkenRBM0xtdVl0ZXBCNTVSMjdtVFN2eFBqTXdqSldCNk1uZEJQSFF2UW11?=
 =?utf-8?B?WkV3Um1kbFQ0QVFTUjlJNUVXcGFrM0lUbWpRME9pbExCRFROT2crZlF5Vy90?=
 =?utf-8?B?Z2crek5jSDhncWIyTzc5d2lsTTdJZnlBVGtXMXYxSXBnVXkzc2NnbkZHQmkv?=
 =?utf-8?B?RnMxc2Z6RTIyZVVHT2hPUDRjMU5icDFmc1RLWXQvNDlpV09FL3I3VDNCVUtV?=
 =?utf-8?B?eXFETTFIVnE1ei9Ma1dzNnZlZlpaUncyaFRFOXduaGNPRHQ5Tllic2MwU3Jp?=
 =?utf-8?B?WmlpLzA1YmZuNTRVZkF3YURCdTJpVzJBREpaMEtrb0U3c25UN1pDM0hWQ25R?=
 =?utf-8?B?MEJUOUk0dldTb1BLNGxUVy91enhadk1uRGV4M1VXM256ODZ5QXc3ZnJEeFYx?=
 =?utf-8?B?NGgxYWVaV3VPZkZEcVV1M005WmNBNldVN3dGY2VqNVZiZEd3OHFqVW1zQWlv?=
 =?utf-8?B?SFhFUjl6c0xXOEFJWUx0Y25ZL0NFU1BnUFlvVnNsbUtjUlk3TmZxOC8zbUV4?=
 =?utf-8?B?LzlOOXlEMWEraFBmcGNiQmFMUFo3ZlZxOHV2MkVOZXpvYkJtekZwMEVLUk1H?=
 =?utf-8?B?SVdEbnlybDJ6M01LSXlqQlNqSThxVm1TQXVtK2w1aGpEN2JSUmxoMkt3VzZw?=
 =?utf-8?B?ekVCWldlRG4zRXpPQXptSERhWFNPTXBkdVdnaGhOaEhvNmErL0tnU2xHdGMw?=
 =?utf-8?B?aExPd0Y3czNYdHRObmsvV0lGNWxRU0ZGTFJYK1BTT3Y2OWVrYTNGYW5tWnV4?=
 =?utf-8?B?NGxHc3U0SndJSWtZU0cyQkFMbXRwbnhSWVhJcU9qanU4ZG51L0Z3RTYrbmdO?=
 =?utf-8?B?WEhCMWxLMEVRTWQzSjU1YnRDNjlLU201T2dVeGFJZmloQk9GQkMyeDBMZUZ4?=
 =?utf-8?B?WXJLZHM2V2hZcmU2MTRHR1hQNk9sazkrY2hNbjBFUEhVTjBhRTFGWUlmYUdy?=
 =?utf-8?B?MVUvVnNQTXEwZEY0TjVTMlpaazBELzR5Q3Q2S3lkbVZwcGVkUFFMVGx1ODJG?=
 =?utf-8?B?M3ZGSlI4NW1XbEloUVNSOW80SUFYUlhxZWtCV1B5dWwzZHNSUEprYUFzVnI3?=
 =?utf-8?B?dXFIUzk4MlNjOUxmaGdXd1RjMUNyV01peUxoQTUvZ21MY2JQQmJyZyt1cHNU?=
 =?utf-8?B?REhrdkpOb21lNU1sYVFCNUdFODZRMTRqT3NsaVhMdDNBM2NjTEIrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccf5bfe-35f0-424d-c797-08df2a18cc12
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 17:30:10.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLQBsqmKpS3T21v3hudQWkRq5ydsRgDLM9nrwzTfFUK17u3ucXXNwX6CcXsd0LltnlxwpfxlEkvK4JZGC7utKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887


On 14/10/2026 18:16, Dave Jiang wrote:
>
> On 10/14/26 9:35 AM, Lucero Palau, Alejandro wrote:
>> On 14/10/2026 17:23, Dave Jiang wrote:
>>> On 10/14/26 8:34 AM, Lucero Palau, Alejandro wrote:
>>>> On 07/10/2026 10:05, Richard Cheng wrote:
>>>>> A Type-2 provider uses devm_cxl_probe_mem() to register its memdev
>>>>> and obtain an HPA range. This requires an existing committed region,
>>>>> so registration fails when firmware has not configured one.
>>>>>
>>>>> Firmware may provide a suitable CFMWS window without programming a
>>>>> region.
>>>> Hi Richard,
>>>>
>>>>
>>>> FWIW, I unsuccessfully  tried to explain this possibility to "BIOS people". The fact is, nowadays for AMD and I think for Intel as well, if there is no CXL device detected with CXL.mem enabled, the BIOS will neither set HDMs  nor there will be a CFMWS.
>>> Hmmmm....don't they have to reserve CFMWS for hotplug?
>>
>> I have to admit I'm a bit lost with hotplugging and CXL needs, and not real experience with hot plug devices at all, but in my mind hotplugging allows a great flexibility which is counterintuitive if you need to know before hand which devices are going to be hot plugged ..., regarding CXL, how a CFMWS can be created without having that information? Maybe there is something in the specs about this and I did not pay attention.
>>
> I believe BIOS needs to set aside a range of HPA via CFMWS to allow for hot plugged devices.
>
>> What do you think about my other concern below?
>>
>>
>>> DJ
>>>
>>>>
>>>>> Hot-added devices can have the same requirement. A provider
>>>>> needs its endpoint topology established before deciding when to
>>>>> create a region and how much memory to map.
>>>> Another unsuccessfully discussion was to avoid BIOS setting HDMs at hotplug time as this could race with host dynamic regions creation.
>>>>
> The BIOS does not touch device when hot plugged I believe. It's all OS native handled.


If this is the kernel expectation and I'm the only one concerned with 
BIOSes respecting it, nothing more to be discussed.


Thanks,

Alejandro.


>>>> I'm commenting these two things here for maybe having a community/kernel discussion with the goal of defining what BIOSes should do and mostly what they should not do if they want to be compatible with kernel expectations.
>>>>
>>>>
