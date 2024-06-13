Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF086E5ED
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309515; cv=fail; b=DlPTS0YRk09p2SMVYSdz1Vp6YW25G046lV1lPu4ujPgVVFbZAproTD+Ze3A53phH5ShEsldCY0OpyAZCO33iI+TWS289bgbTm0hyz4gDlY88VSsWOq6gO6Dk2Kx6Ms5oBBJ6Rj4c6ljZ2adCSLvCx0aRlFUP2Z6AFwxzd8KAf3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309515; c=relaxed/simple;
	bh=Ol1f4bwePCMLmbMhA3GmGkvDoiU4LuObz4Vudjb/vAM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MGJ8X7cbJIj+K9vavsLkvt+n+h2t1QR47ZwOviyeSM0BNS9VLvzTtn6oXuNQOTGSnFwQ4qUKyK9zEYvrvjsLHvOmiQi6VUy0Aonu6oTIyLJzyLizTcbF3Oir0EPjgyjdGojSTMWFqCtzPRAkHXt+WNONsBDpmNWMJt3Gy4+GyXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G3jE9u06; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G3jE9u06"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1DxL47dQUYTKV8wn2qNdEVlHIR7WWddw0vxoFJGynsRusnjps3ySH59V7FTHkA3HQ5se4mQBAyVfxDPzFqG+Ewx8VIPddgW12YuWnpqjks5Z89fPtcc0IgUpaWqnQ/7BuOwSaX0aTvtAj3sIGs54cie5HtQszr+hc5ySJ5gj9W1ClC3cpXNRm7YDA9oiXy8M+nD+bKFRn0e2idAN6SMthIzGcLs/vqqe8Nodt7UlmaSIbeINckvoGnHZu3UD9gVyv7VGfaVqicCJjecBKS34OOjb4ZgVeiy4a6AKnjEEENXb8Pky9/Gj+A1iCuogsPqm9KS2Dpz8gUHG4QZHtHlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o851Q8RuQXIwg2PGzvAvgmzagJrVSuzDRSAZvVMOg8g=;
 b=Eo7jWmYnR4eYx9fHLiabe29dPk+IYDwLOW2ChWpRMW4KRZ9nf5NifwBnqkzK7+pH4TtgeXXovjmtFrtFRDCG67U9m3BR+mU1nbTVSiMMIM8lG7PHHGns2Gp02fLSxt9t7ZiBZs0A/eYY8XRyej/oYEavqlcMordJ5Z1ypIeXzmr6vExqvEmE/4BntQJBLFS5O2PkY+IGhOJDMOD1UP3BYeq608o5WEwJSwsHSk1W1Tiy0aHofyAyKBMpoJ6hE/Rd50kbM71RbH8W2NojZ6HorOa25o0dlJRQE3tp6boC1NtiKa/bRmNy4Z6erSuFuVJZlDm4mkNzZYF3UXGq1gh/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o851Q8RuQXIwg2PGzvAvgmzagJrVSuzDRSAZvVMOg8g=;
 b=G3jE9u06E9IT5FHsW3gd5p152AESFNuFh+GK7Ze50Y2UE08CWIvqPluBzXJvrkybN9eHpdtk435ydOt90q/idcLSFUaT99vyLnYgKogUmMA+VytqDWhabInigT3bT9OMEGn5VDnbfhOaC0xJaX1pMnPJRgetBuddHM391AODtlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 20:11:50 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 20:11:49 +0000
Message-ID: <5d214147-5509-4676-ba47-572200ce04af@amd.com>
Date: Thu, 13 Jun 2024 15:11:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Remove soft reserve resource at region
 construction
To: Dan Williams <dan.j.williams@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20240612205905.1209448-1-nathan.fontenot@amd.com>
 <Zmo9ltXuf5G7/pwi@aschofie-mobl2>
 <34868fdf-2f19-40dc-8ae0-3c5123f3ad1a@amd.com>
 <666b490f7a06f_c79a32946f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: Nathan Fontenot <nathan.fontenot@amd.com>
In-Reply-To: <666b490f7a06f_c79a32946f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: cd750dea-3601-4721-08eb-08dc8be50f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUlZaWM4N09xaDN6OWcvaE1zZzlVMXFmWndLZGxYQVQ3RDhVcjlIQWM3c2wv?=
 =?utf-8?B?UEYwK2Zpa1lLV3l4bU9maHZjYzQwVzMyVkQ4WjRKZ08yWDNFNFMvYkpGV0Y1?=
 =?utf-8?B?L2U3ZWtkd2RodW5yc2lsSlFqVFdVdWIxVk9HWXFwSmdVOGtzMHlLdGRGQnBH?=
 =?utf-8?B?RHVnN0hOYjh6ZGdVT3M2akNmVUltbkdCQkluQkxQZTZodUh2MXFLNGhYaHFu?=
 =?utf-8?B?SWI4MHh6L1pVOE9Wc2pVM0o1KzNtWnVBZzNPWDZZK3pRRmROeFRONjhzQUpm?=
 =?utf-8?B?dVIwT3lvUmw0U1RSVmRJMDU4TlVLeW95WS9QQ1pjdjBDWHNYci9XdHd0amUx?=
 =?utf-8?B?VDRRRDBTd2gxTlFOYkxQeFJGK3ZtOXZ1RndlSnZtYW5zL09qS216RnI0bjFI?=
 =?utf-8?B?a3lYd29DTzZyMW5iazJBMzVLT05NS2FBQ0NldGY1UFJKT2hnaVo3ODZKMFVk?=
 =?utf-8?B?WGsxUGJscWFyeEFyYzVRcEx4ckh5WnduZ1NhcmtDUjkvZ0lMZEh6MzMzamRV?=
 =?utf-8?B?WXQxS1lxaVUxMThzdHBaZTFkWWlxaTNXaE54OStVVG5QeXZjVytrOEJyUW5Z?=
 =?utf-8?B?NHhuZEJTN05KdjNsdlpPeDV3aWJZaFBaTkJNazc0dGdLZldqeUVJT1RvK1d2?=
 =?utf-8?B?TkR6VjdWQkV4aFMwYXRHdkpzMmxEcnNRdzlwTTZLK1NpTndGUTVPTmI2VGNh?=
 =?utf-8?B?U3llVE5ibjNBdnNaK0k2VUxKQzY5OEhJajRhZit6VjRRTWV1TWdBaSs5MEZF?=
 =?utf-8?B?NkZnMllYWmE3WFd2RXI4dUZseUJEMkpjOGFLN1V1WS9kelVCWUJ5ZTNhYkdm?=
 =?utf-8?B?UHJvYVd6REhHMzdyNHNKM1A2ckltVFNzc1RYQnJzcVNQMTZ4SnJCOHpLRjdV?=
 =?utf-8?B?U3BoeTE2aXIwamtGMzdhU1EzVFFlWjBVRE9FaG0yMjRzMXN0Wk1sUVVwVStp?=
 =?utf-8?B?dFF4SnUvZy90UmZiQklnazB1ZTMyaVgrT2FLRm5EOXlHMzhGK1BkUFdYaHpM?=
 =?utf-8?B?Q0w3M2FXVklOYm5BM1dpeXBlT0NCSzFlRkk5M0VsMm1jT2NYbXdjS3ZJWWFP?=
 =?utf-8?B?ZUlTUUMya2VIeWlHS3R0UnZHa3dyWWFqN0hNZFgyOTV6YmJ2YmlGU2R6eHBB?=
 =?utf-8?B?K0RHencyUGROZUtaWTZhcXRtRWtITEQyeGdWeWlsWSs1UnZuSGpreWY1cUZq?=
 =?utf-8?B?MUNIdDdWR2FLK1ZNeTlHKzBBcUhFNlo2RWErRTdOSGNYWnVoMkdRTmVibVBG?=
 =?utf-8?B?RExGRzlBeEQ4QWlqUjI1NytpQkxSQmlFQ2REYXJZTlMraXNTcExHYUdVQTl2?=
 =?utf-8?B?NDVRcEpteDNkTHEzcG13SEI1ODZDK3k0RGQxVUNha1NKS1VKSnhHTTlKQmNQ?=
 =?utf-8?B?YmRNZUMwRTZhd0R2bHM2Z2dONXoyWFlObStVREdjdnZXUVF2ZHM2eDVXeEts?=
 =?utf-8?B?YlBBOWo4bDZ5OGdvSGhOMWlTNkRWcFFjYTFUU3p6TnVwNXNrenJ6cnpBUnJo?=
 =?utf-8?B?NXZaZUJ2N2VUa0FsZWhoU3N4d1g5QTNUekJEZFB5YjdJTWhVS3M0R3phdXJ4?=
 =?utf-8?B?RHRjTHBhMFV3dGtWT1dKaWRKVDNlWVdkRDBJcStwc08zUWFULzJBaXJvY3pv?=
 =?utf-8?B?MzlGeWJNdEk4Nlc0TWEwYUl6NmwvOUpodS8wQ1JwM3YrSWpLd0NGQjI2dXBy?=
 =?utf-8?B?NEwzUGhhZGhpQ0dnVmlzdTJHM3JGVWJ6clU1L0JlQmI5V0YxSk93RXV1VGts?=
 =?utf-8?Q?k/Q29MH8wKU1LCUM7GIoe6TSt06opq3zSMcW0gk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG8zaFQ3M0J2TmVVa2hGNWZ1RXZDNzBvYXpRRFpqU1VibjhxdlJIZ1kzUGJm?=
 =?utf-8?B?eFBwRk1YMXFDN0QwUUJPTTFUOVhub05qMWxrbUdrQzhwMERqbVVuOTFYMnlh?=
 =?utf-8?B?R0g0U2RKN2NqMmRuQ3NEd1o2bmdkY3dwRm1mTHlsY01pd1pJeklLUlM1aTYy?=
 =?utf-8?B?Znk1ZVQraXBkR092S0lEckxNZXhnaEliWkgzQ2s0dFBTa3FDTUtrNzUzOWlx?=
 =?utf-8?B?NG15OEt1ZDJHQUxSeWRXeEl6czdSOCtzdXE4V2RuejZlSVpWbUQ4VDlWWUNM?=
 =?utf-8?B?M3hTMUxzb0t0Z291LzRCRmltaEdkSzloaWpHMi82ZWJiT3BvT1J5eGZsYUFP?=
 =?utf-8?B?a3FTcFlhbDluT0xjTDZTdGs1blpqVEZPbWkycTNZNWlFcmxveWJXSUhGNnQ3?=
 =?utf-8?B?a1BlSWRWMDVaTWlOcFRaZnFyQW1TK3Z2Rnl1dm1tSW95SkE5MzlwL3hPZE1u?=
 =?utf-8?B?b3JCKysrSE5zeTlsRkNiVWIwNzJVV1hGd21DM0ppbzRTUG5JTElYY0NmOUQz?=
 =?utf-8?B?UmQwd3dIcVJiMFJMWmFtNzVWeGsrR2pNUUZVeFMwaDcrUTBBaC9raHJZTm9x?=
 =?utf-8?B?S3BOdThuYnc3cWZlSVNCY05iVVpGdnovVU45bk84ZDFsajJVRTdsZ3lUYW9R?=
 =?utf-8?B?VWVibGRuUnd0T3cyTDB6QmNvMFdQSXpOZEtVblhKU3dKbEp6TkNRWTJ6WGNO?=
 =?utf-8?B?SEV5SDgwSzQxM0ZJRU9ZbHRyc0ZieW5MdjdTTDUzWXliRXNNUTNSdGl2TVF6?=
 =?utf-8?B?TnZRdEduZVRaSU1FaTd0cWFGaGNWSUpYTkR6ZTBKWGNyN2pLZVpXa0d6S2Js?=
 =?utf-8?B?REdIeXJuUllYTkZPQkNoU2xkR3hwZHJ3RVVZUHpHblU0ampwbUQvOXZsZnJy?=
 =?utf-8?B?YTNTam5CNW1lMEZ2dXZpVmdoaU1GVkFJSFBaZGhnc3VZelJyTyt2NWs0NXc3?=
 =?utf-8?B?NDdCQUk1eUluNE9BYmp2TlBTWksvSzNlREZsbWVCL3MxU3pBODFZQVlOeElm?=
 =?utf-8?B?RCtiOHhKMDFCcTZJNzJrQjVvdXZ2OXl0R0FCNEhzYjhmNzg4UGdoUUVwcll1?=
 =?utf-8?B?Ylpiai9UTVFJbFN4VWFXYkdlK3Zya2RYcGJuRjN5ZUxDOVdRTnE2MEJNNk10?=
 =?utf-8?B?eFhwc1FsSlo4RWV5ZldpaW1CanQyMW9kRG9IekpvNnQ0dk01THVXam0wZlB5?=
 =?utf-8?B?ZkdmS1VUNTVabU55KzhPaWZLS0lUMkdVOHlVS3RoN3R4NWVzK3JYNUZLT3Bx?=
 =?utf-8?B?OHlUeU1WOTdlSHRjbEtOWDIwZU1nNVJGdlBWTjE0YVZtcDdxRXVYc2o2RXIx?=
 =?utf-8?B?UEpvY1lXRHVkblFWUEY4ajFsQ3BUZHovTUxrMUh3SnppV0RWenRyR1dYZkRI?=
 =?utf-8?B?d1JSUllsUFE3dmRUVVo5QTdzODhsSTJmUFNNZks5Znp1LyswQVJ6aWwxczY4?=
 =?utf-8?B?T1U0Nmt4cSthWHIzcUVDT015MTYwSDFkS3ptNlN1ZWQ2cVVWa1dEWXNEeCty?=
 =?utf-8?B?bUhub3RqUkRGTFlSNENkc2taNU1NVW5uZ0pjRXFLRC9tMS9jV3lReEVDcnZ6?=
 =?utf-8?B?RjVQNWFKYk1STnNBbFF1UWxkWTZ6eEpCRjNYQ21hTVBKR2czYTdod0FmT0J0?=
 =?utf-8?B?RGdsWDFETmVJWkZPRTN2VXJvcEdrbE04bXpNYWt1dkRaVW1va05TaGQrMDBJ?=
 =?utf-8?B?WDJLUXFBYklxd1A0V0xDM0tjdzNUT3hpSGxiUTQ3ZmwzTXRLNWErekxXbmMx?=
 =?utf-8?B?QkEzRlh6Q2pNUmlVck0xbUpUd2tpbDUzTkhjQ09OSFdWRmR5TlRIRmowTXRB?=
 =?utf-8?B?MWFYd2hFSHBZVVhjZXlOa1JmcUh6dHhBRzRoVjQ2SGZNdGl4dVJvYys3UUw3?=
 =?utf-8?B?c0ZpNEkvNmh2ZG1DbU9PV0pxak9MUjlQekV2eHZ6d0ZqWFRodTErcmZEYlhC?=
 =?utf-8?B?U0N0MFU2aGlVdWhVdEN0eWs0RkV6MUw0bUpTMG1aa3VlcVlrT29NY1hQUGFl?=
 =?utf-8?B?SU1MYzdPdzhzWTYvK210bUpveG1HQ3VweVBLUUpjTDVKNUFSQ1VjZVdtVG5J?=
 =?utf-8?B?cFlGRjU0QUNnUkJXVE53RWJXTGhubGdoR3ZWWGZTcitjYnQvN1l0d1dKK1FE?=
 =?utf-8?Q?9rM3e6hqZwiCmxHvI45qG9uGz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd750dea-3601-4721-08eb-08dc8be50f04
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 20:11:49.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDdqk4kHCYb0zA5FWb3inYEhN2fN5xWtevJCaZ3HHx6OoOShrpw4OZS8tBoUX/I7rkHMOTTbrV0zeDlq7VeDoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971

On 6/13/24 14:31, Dan Williams wrote:
> Nathan Fontenot wrote:
> [..]
>>>
>>> Is it OK to remove the entire Soft Reserved when that first region
>>> is constructed?  ie. in this setup that removes the soft reserved
>>> before region1 is constructed.
>>>
>>> 100-600 : CXL Window 0
>>>   100-600 : Soft Reserved
>>>     100-200 : region0
>>>     200-300 : region1
>>
>> My approach was thinking that it is ok to go ahead and remove the entire soft reserve.
>> I couldn't find a reason we needed to keep the soft reserve after this point. I could
>> be wrong on this.
>>
>> One different approach I've been looking at is if it's possible to add the CFMWS resource
>> as a child of the soft reserve. Instead of starting with 
>>
>> 100 - 600 " CXL Window 0
>>   100 - 600 : Soft Reserved
>>
>> We would have
>>
>> 100 - 600 : Soft Reserved
>>   100 - 600 : CXL Window 0
>>
>> My thinking is that with the soft reserve above the CXL Window we no longer need to
>> manipulate the soft reserve range on hotplug remove. The alloc_hpa() call for user
>> set up uses the CXL Window as the base for alloc_free_mem_region() and the soft
>> reserve wouldn't come into play.
>>
>> I haven't looked at acpi:add_cxl_resources() enough to know if this is something that
>> actually can be done safely.
> 
> Could you please stop trying to invent new approaches and respond to the
> one on the table?

Going back through the previous conversation, I was just trying to explore different options.

-Nathan
