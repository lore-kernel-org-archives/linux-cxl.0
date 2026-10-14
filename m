Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25155D89C;
	Wed, 14 Oct 2026 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995724; cv=fail; b=qWBH/F44lTBQ5bIqPqqtMqDitB+RiSzukyFyCIpQGa9MBAUn9WRJ1wjIDAQzyf6srtVPYDzYTHRI4zKpHSKmcaxtxoDkic/oS+kADX+tq1/rEktm6dvOhT84p5cBQCgBAlJhGE3Vj3bO7VYo5e2hTlKPycw5t8HFM6EykxZII6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995724; c=relaxed/simple;
	bh=2YpBBBl1JprqUy71IITcll37DLVH7JWPPW7P999PC5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PeYBPd9iF/tF77gMYqWXbX1nliwloVgzBAR1Eaec+ZHjiSXQ4QX44ye60jVu9drMjoYR923qHnSU8cPqWoqGYA/Z76EMCPAW/0nnGpzT1A0KKtcZwd8zoGDr2IczI5Cj0ItpoVVbFWxtDVZYT2JSIzHmY2b+YnKUwPAbm5QTobU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KZnx00XH; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KZnx00XH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsVSIA79bwlLOh4xHOlGQ9++lW+0j6BZAkC7UZwJgEvH9ctpnRcRxNJB1WBSmUUvEGHbTCP8UxBSmIYTi700V+jJennPEd5yHpGSvb026ZbTiyD7/JTOrAqZ0UXDocg0hoLaBA8oipZesdNST1//k+qTIT+WpUTgoDurhpBUIliBIazhc4EA4a9hHwDfbXxH7LpKXvM3C7ltjvr2ANvARiIi0o36VPbiJjU9hi0gR/mGF0tzLMUbNcoa+zIdvY9qHQuAPfN7aqY6nmhl5+xBDQ50UYzAT7vJDkQ7g6dxmsVbezCPrnhxkBbA6FO0vyrtqMLoLIc6qVJbAx8xccfizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhf8PYseew6Zj/K5UPrOD9/T2K3z9MwEk3vurQe42AA=;
 b=xwNhPujqbV94NvvNzZyzpaoJKJ6BRD6A56mOdSagscitE+ulgFlEw69TX43Ljq0VvntrnR5tx1uog62z7ltRoGGQpIf2w7YMZgd3puO556ETWLhXKQPbkjKhBzj78bwmT2Jdlit9u7U1bbWWzbEwB+O8CzwSmoUbhJDgb9T3Xw6oSUNj6U1pbyjWf5/f2lM0lLyBXWgFaCFuYbUWyoXtqU6xOBB27SnK5kz0faJ7K931a7+cPoJ1asJIwllh+r3iKbbo+Cbr73Aw+Bymn15Zk3JexxwJ3t27J9IKg/LdhvQodEX3utPB2mMSTzEmEhVos6dyuVMyaXtVyUne57Ulrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhf8PYseew6Zj/K5UPrOD9/T2K3z9MwEk3vurQe42AA=;
 b=KZnx00XHBTlY6IIbcR1xFQ+JfOr9NP96Rh0Zihl0jGxlLJvYW51RKWMWAoYzlWw6uhQBu95tUVNjDtuQrkZ2ejlFdBzsy6Y6CoQLP4jMfihoT7wQJz7pbCGlv3Wh3+G+18ImRVuu/6vWOY7TFq8MjM4RXBKxhxvMtLhM3gpPco0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 DSVPR12MB999125.namprd12.prod.outlook.com (2603:10b6:8:38a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 16:35:14 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 16:35:14 +0000
Message-ID: <9427af6f-e693-4cdc-8fc3-21c529888125@amd.com>
Date: Wed, 14 Oct 2026 17:35:03 +0100
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
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <3466e889-82a0-41ac-9013-7d21020b5092@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|DSVPR12MB999125:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fc2acb-c823-4f4a-d310-08df2a111fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HAdLIOr0d8IfDW++D8tQ3+TVKE/I7g+G8M2iODsuleeeFyQi5AbyiQivRol5uSNmIptERO8HOgjZJIkgZmx8yvZJP4AO7eIbxSSwR7BArPrwb9/SHc0fVqnNHTzXgk3eArhYubwvlXmRE16eTXco/rlGaerT+dfYiV6BtT1KVGSasO7RUJlruL9ZGsWhHusq7DDOL+V2Xts7CqCLiw3yI2xJHfWSY9HKb9ZiHLfTuWnKmTVwJgDpDU9OTMP/NTVKApKEWHsZn0VSwBrBazS0fKojR3B4T9JkiDKzYAZ/VuWYB6xouV2Ii9/+enhEj9UWGEvu2MYxK7Ra+rCdFfGqjzwYsaniKY3JRqATt+lGzEzq0eSYLBBzjLiCbNeALFtQgZ2oaszxQJQKZqTr59R2dr1f2+Azu2xD/cwvQyk/jKzyeD5gaHtCa6rc+cEMRqZjyfGGtYpATib20h7Tj0bswi3LKoORYrfoPXeen5pIAOwFLrXC5qdX9vOE/mqL3EaGGN/6WYFBv434wK0DK5qls2loKBvX+2sXQ+/uBb8pyTjWsNtUzhvJ/fbEJ/vqpcgUrATn7nDLUIdh16yPRk3Di6AFbzZwkjtDeiJ0Kab2VO9hOX3VZsV3W/ya2fAfX2jy1EqNaoSn4LxPQw/BgRDQjq3zaUfBcP1GkL/yPRN5ITI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWpHZ3FxWERQQ2dBbEovNDVBSHZIYWNlKzRMeUhXSHppWnVCVzlJNWJwTE9u?=
 =?utf-8?B?UGJXbUJEcEVYMzNXVjFpNXdpTDVKSjU2eEg0MEJ5dVpqdXo4a1hCUDY1V3pC?=
 =?utf-8?B?b3Mvakk0T2NxVWVxNmJUUXBkTWxSQ1VKdXVyM1ZQY25uMkt3eHovNlpqY1cy?=
 =?utf-8?B?ZHQycTJhUVNUTzZkd25HcDZlblRtREM4bmdFaURSeDh4WTlvOHJjK0w5YjFM?=
 =?utf-8?B?dU9zZXlLNTFQbzFtbUI0cVE1MXdiZ1I3c1BseEt2b2tQRnpCWWNOOTlhTWxy?=
 =?utf-8?B?VUx3elpvR2x5clVMWWhCcGl2em44dFVnWnpNeUs4eHRTMHZRcU9uUUZTSDly?=
 =?utf-8?B?OCtuOHdndlMwZ1Z4OS9tM1psemN5T0Q1UXpXU3pxaTNzZi9McndGSm15bXdL?=
 =?utf-8?B?QVVKQ3FuMzVNS1pCMUxFcGFEd3o4cXRRK2F5YjdvbVVzb3ltaWdFb3RrT014?=
 =?utf-8?B?S1BNMzlRdnU2MDBqMjlBbFFpUW1Fa3g3bklxYmJoeDlnMUJ0OVdpMEh0WlQ4?=
 =?utf-8?B?TGJXSlVyenJvSzFUb2VFdmcrVFJxR0o2cTM0dGhXRXczVFNaYjJGWmhwZmtH?=
 =?utf-8?B?TkdYcHoyK3RoVWtDZTNFNEJWQ21XSFp2dFVyazI0ZHhHVXpDcU5aamNGVDJu?=
 =?utf-8?B?Q0ZKaURWMDM4MWNCR0JlVVlScmpndUZTdmFmZXkwVjZiTnI1RjA0R1FqN0My?=
 =?utf-8?B?WExhY3AzUEp1UitxVDgvazhhSW53a2k0cnhobFQrMnZOdzhnbDNsUnJJMXJT?=
 =?utf-8?B?alpkL3BFQm5NZTRsQ2RndTVkT1lCZnBKZHlJaUpmSmQzU3Y5ZlhacHJBVHQw?=
 =?utf-8?B?NFBzU0FrSW94UVBYd2gvVm4reWg0Tkd2YURRQi93V2h5S2lEdS92MmFodjlT?=
 =?utf-8?B?OU5CSXpIM0lLNjJTbG1EUEcvQ1lQNWtiaW9BQzFRMmdYQVlQUDhQcEJibWNS?=
 =?utf-8?B?VzdWM2w5K0xNcjUySklNSDI5czR4QU9jRXdMY3FTNnlEbTloVktGZXAvNnI3?=
 =?utf-8?B?UEZzbnBXNEVQdkhydlVoNlhDREV4R3FHNWsvZlJBSThNVW0vcFRrTHMxbnl0?=
 =?utf-8?B?cElqcWlDL2xmWkNNdElGaEYwakhKa01oZmRRVjRFTkd4RnkwUEFsTXJiMWU5?=
 =?utf-8?B?VUFra1ZjN2d2bW5ZckdwcS9kTGJCdEtyS2M3UG9XeTN3ZG9YRVVXRmtDVTdU?=
 =?utf-8?B?VnVCLzdRbVlrbFFOVEt5dVF1VVgxY0JsMGUwRjN6aVZpbWh5QVFpL3huQTJN?=
 =?utf-8?B?UmhqYTRRZDJ4N1gyUnZsUW5ZUWttMmV2VGE3L21kcHlGR0pyMXk2Q0tHY1hr?=
 =?utf-8?B?bUhISzZ6SWFZSmh2V2lpWGpUNFdBdU1yd2pwNGJLNU16RDlyNlpSUU9VajNW?=
 =?utf-8?B?VFc3NnozMDZoSDhxWjIwT0prRXBUYlFwVjQzN0R1ZGlGejRVUXRseEZVYm9U?=
 =?utf-8?B?V0kvcWE1NjY3YXFaeW92QWFJT3hyT2VLZ205RjBMWWxsaTJ6RkJEdjN1K1Az?=
 =?utf-8?B?dWFQTlRIVlc3SU40cTZSUERTNHVYcWRkVzJRWE9CVWpLZkUwRWJ0dWVMWDlw?=
 =?utf-8?B?bzZQTXppZWFPSSs1dnZ3Y1hJMVJZQzZySWloN0oxNC94L3pwbGRycU4yVktS?=
 =?utf-8?B?L3BsQzBXZGd5UFdEUDFFNUNqQW13emFLOEpuWnh5Yng3NVJ5dms5WFQwOUV5?=
 =?utf-8?B?NWV4dGY4dDVVRXBQTHhJcXN2ajBOVDFPY0xKa2dibVVXRFIzcHlmb281eDBi?=
 =?utf-8?B?anVyQzkwOVJLaEU1TE9HUmZDUEJzNDFGK3ZtaGZTWWRrcFQ4MVdMaE45Z1FP?=
 =?utf-8?B?aHJDZ2w1NE1kUjhUczdmbkVtSmxQNGI0RmpTNmw5NVUxVEc1ZTgvVzFQd2R1?=
 =?utf-8?B?MFA1bTFlNzF1YysrcFFLRlU3a09ob0ZyNlFKeCtxMm5CSVNRUUJHNUYyUi9h?=
 =?utf-8?B?Z09hUjhWbk5sMmVEM3lVN1JJMUVpSWdmeFZlZDVDSFlWZkVpSEZMQlIrSk1G?=
 =?utf-8?B?U0dTTjdQRlV2VC9sZmJBUi9LaVIxMWUwV3JHbFRMeTBXM2tSbUVJRk0wY2pI?=
 =?utf-8?B?bUlxb3owc2pLem14QWRva2RSWGNoc0xPOFRyV2ppQ0ljMm1TUU95Rnk1aE9X?=
 =?utf-8?B?NmQ5RSt3Y1pDZnZkVTlFY1BHVWU1OUdPNmNzWTJzaUYzQ05PQzJLK1hVYWZj?=
 =?utf-8?B?VFhzTUZBalRHVmFkZWczMzNHUXBsdzNFbDNjYTVCUkRBejFqSDNPVlFHMDll?=
 =?utf-8?B?S2dpcm1IaVQ4TUVQWDNrN1cvcFBjdE9UaWVPVEd6cVhKeXNzVWFqbGJUaXVm?=
 =?utf-8?B?bnJDSTNLWDFCZHBkQjd6ZGxpVE5LK3FRMVNQRGYvYnZ6amNEK0xWQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fc2acb-c823-4f4a-d310-08df2a111fa5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:35:14.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhTkidXcqGLcZkDtgOyVkqZKsTKSZXMaRZJ5aDhL80c1dNdUrUHM9IhraoK//QZCT/uFVC1eq++X6S3cC74Xdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999125


On 14/10/2026 17:23, Dave Jiang wrote:
>
> On 10/14/26 8:34 AM, Lucero Palau, Alejandro wrote:
>> On 07/10/2026 10:05, Richard Cheng wrote:
>>> A Type-2 provider uses devm_cxl_probe_mem() to register its memdev
>>> and obtain an HPA range. This requires an existing committed region,
>>> so registration fails when firmware has not configured one.
>>>
>>> Firmware may provide a suitable CFMWS window without programming a
>>> region.
>>
>> Hi Richard,
>>
>>
>> FWIW, I unsuccessfully  tried to explain this possibility to "BIOS people". The fact is, nowadays for AMD and I think for Intel as well, if there is no CXL device detected with CXL.mem enabled, the BIOS will neither set HDMs  nor there will be a CFMWS.
>
> Hmmmm....don't they have to reserve CFMWS for hotplug?


I have to admit I'm a bit lost with hotplugging and CXL needs, and not 
real experience with hot plug devices at all, but in my mind hotplugging 
allows a great flexibility which is counterintuitive if you need to know 
before hand which devices are going to be hot plugged ..., regarding 
CXL, how a CFMWS can be created without having that information? Maybe 
there is something in the specs about this and I did not pay attention.


What do you think about my other concern below?


> DJ
>
>>
>>
>>> Hot-added devices can have the same requirement. A provider
>>> needs its endpoint topology established before deciding when to
>>> create a region and how much memory to map.
>>
>> Another unsuccessfully discussion was to avoid BIOS setting HDMs at hotplug time as this could race with host dynamic regions creation.
>>
>>
>> I'm commenting these two things here for maybe having a community/kernel discussion with the goal of defining what BIOSes should do and mostly what they should not do if they want to be compatible with kernel expectations.
>>
>>
