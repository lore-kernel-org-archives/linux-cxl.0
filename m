Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD431925B2;
	Thu, 17 Oct 2024 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150065; cv=fail; b=eraPEHIycSKYPbK7A8QCETzRH1ESC5bhFL2etvIIzCTQqNM5UiOYONeogYSxZVuAYI8rBnx9T0NWu4iht2z50Zi7kia+3KTqf3OX6GEy0ITbtFVPElmtn+lP4lVQAwaxWd7KG0EBvGABB4D2mNfy/SDx+SVaWnnRKLrK+udeMAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150065; c=relaxed/simple;
	bh=i+gWPsuSOcJC3RS0kZvE98sUKiMS9LV5N9CBgXZ3gr4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OFwtjliU1TOsWC+zFhV4O2upbQPkSmiCHt3+Pf9DWmV3GFSm24cVhd9EAzhCib4ze0MDlRji6JeC4ZBENzGwCh3CHAIJJLgefHsHcACo77a1U34CzVYQXffi0o5nbxN76Rugju6VjlJLzSm0v2LcqYNXC2g/63fCCSKPDgHAXN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fu/wYfLg; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fu/wYfLg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwToUnKmEXIyHm1Nl+oJLP64nVMHH7kmn17wVP9oBMgaj/m156sCJkfSP6Lcu5rKZgoA16iX7ZHwhSgdY78SXrUlkzWnFiQgr92THG1DYQtCIaUWlInxu8CHVyT+YheyjVFJKbXf9qXOgt/F6ZDCv0DbYuw8UPQgTTb6iEzu9/xe/9Vg/0xl/7N9LN74+TaWfTkkNtABpIe38MKIcbi3+IORk/Vz7kiW2lMs/JHw0rqEhqhfmj2mPCfmrz7ZjA9Wu5J0ymsM8NLIT5GnOxm1PJNz/YjK7hNdzl8TylT/sC9LY7phFjikSFwB0dnq1NdPLV0P4FhmbbRogH4dCq3S0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dYEUWWUeAGWmUcoyWGc/G7nI8Hj9sw0yTITIDAqcA8=;
 b=sR6NlllzuhlskG2Sz8x+AOhM7QydXwiM0b/ZFMCrxhrkqyBlSmXoBj0Uazg4z9nziEYmPIWcHIK1PyWw0+6gVZb8TdGEFJbAgPdWIwse3S84o42svRAFMooD5LmnRs7YWHw5ozvdy5DkKPAfwc0q1K0fBh6ZUX4U3aJYr3GXPOZeroMA8QkBvY78YaoVXv4pmVpArOQvZB/o8R79hqLehbNFZBZM8ovHtb78GUUBw7QBJ0Dc9hho1jTUeKZHb9ZkTK4asTFehYaFL8FJAEUiITueCjhSF/IFEUWCU9WcmP4mcUA1z00JAYUsmJT1NhER5JaYFQx9XTDh54uI38iNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dYEUWWUeAGWmUcoyWGc/G7nI8Hj9sw0yTITIDAqcA8=;
 b=Fu/wYfLgPulLK4lvuptUNJdGnPclGy907FE+p462RArgMrT3rXWnS56bQXfEnKXODUqKXjl8iZO6ECN9J7Zxl3Ge5VJORR3WmCHvjnyR4hKabycorH4QHA3OaFf3tu0mC3+3+nRkGJpj1+k9bZ4/mHuzi+eHK5CerMsMEyEUurY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 07:27:36 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 07:27:36 +0000
Message-ID: <ea8afddb-9e97-98f6-b1ee-b5394d35e8c0@amd.com>
Date: Thu, 17 Oct 2024 08:27:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] cxl: Avoid to create dax regions for type2
 accelerators
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20241015065713.308671-1-ying.huang@intel.com>
 <20241015065713.308671-6-ying.huang@intel.com>
 <d5233135-9d70-9080-c7eb-0906f07e5104@amd.com>
 <87jze76y4r.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <87jze76y4r.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0339.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e087bee-fa9d-44a9-9198-08dcee7d2c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkdxY0YvbnJ4TUUyRy8wWWhyY1BCbFRabjNWMHV3emxCOWc2MXlHcFhPSktp?=
 =?utf-8?B?WGxubXV3WE52aHZXdnFZbXJxbkhyTGhqdWxCYlBWQVNPNHpOeFZIMkZvTi90?=
 =?utf-8?B?emVPTXF0blRJaVBaN2g2alZYcmM5cEdIMjdpTk5IWkRWVW9KZWVVNFhjRk9p?=
 =?utf-8?B?U1gzWnJwbmMzUTNSWSt6UkswOUpMMVN0WmxDeWp1WlJIK3FPYmxtRG16YUpV?=
 =?utf-8?B?Rk1RdUgzSDFsbGFjZXNHcUVBN3o5cE5OWU8xUmhCWjhpNGNScHBCdVZmeW5Y?=
 =?utf-8?B?MERnL3c2Ukt6LzFWSGdMdUdlQnZGQzQxaFJkazIzYVRYZU95dU92VlZPbmlk?=
 =?utf-8?B?MXpVRGhoOTdjd2pSUlVsaDl4SGtvcXZMajVPOXRWVDdEKzlZSndMSmNvVGxy?=
 =?utf-8?B?NTU5Zk82RENlU2Q1WjhGZkJPdC9maTMvNS9yaUhDL0M4TmlhMytpT3NSNWxE?=
 =?utf-8?B?UG9nKzV4TWV1cHUyT2xndkkzRGg4ZkpXZTA2UzVXOWEyUFRDK1Q2bkV5VmVV?=
 =?utf-8?B?UU5TMTZvM2w2cDRLaEpIbTNRL25tbEp0cHVFTklxbm9SYzVYV3N0SVp2cHk3?=
 =?utf-8?B?TTRQYng0ZS9xc3pVYW43TEl5c1NraHpQbUpSV1BNc0tSL2JyYW81d2JCZ3d2?=
 =?utf-8?B?eThZa3lUOHI1YmIvL2hDR2dveFdWa0JKQlRiUksrT1NWMGFueFZWMEdPdGVt?=
 =?utf-8?B?NkFBS2lac1F5bks1STRPQWRSbk9VeC9rdGRhd21ML29WbXB6Znp6RUFGZ0RM?=
 =?utf-8?B?dG53QUdydW11RDNndVJtN3JnTFZuTmdYQTQ5cXJqWkFMRWkwbVJDcytjVWY2?=
 =?utf-8?B?anpQeXBPTkl0YkxHR0hmYzJ6dHdxa0tzUDliMUFncTU0NkF1MXRPTFhveHU5?=
 =?utf-8?B?SDhJRDRkT1Z4RE1VWE1KN1A4RjlBTWwxaHJHdXFqU3FlK0liSThSTHlSSFFQ?=
 =?utf-8?B?cXU5S3JEcUVFZEdMVEU0ai94Q3J3SHhXS25DNTRVLzB1TVBmMjBqSDJFOG5K?=
 =?utf-8?B?bG0xeFdCUUNydG5UVjNyUVdvTjlyaGFhRk1MbnhXeXhKMlVyamhHK2h5dngv?=
 =?utf-8?B?YmFXd2R4QzZVTzNVaE1BWFFWVXNXUWtaYVlKUzRWRnpLcHdxV2M2djZnUEhN?=
 =?utf-8?B?a0xiTVo2YmovK0FFa0w2alJnSjVGR0l3NTU4Nm05NHZoZDNrTm5scTg4RWVm?=
 =?utf-8?B?d00xT0lQK3RQMVF4NWZXWmdBR3dXWS9EajZjOWhOcEM2T2FDNElaYUhNeFNi?=
 =?utf-8?B?ZVZoaU5tbHc1Vkg5MWZ5d2lWaHI0VWEzWVBsSktZd0RXOGdINWVNd1lpb0NV?=
 =?utf-8?B?UWQvNDBzRnllcmJKZVY3NUJXWEoydVhGRVZOSnA0QjRibUFzWElNS2RXUjBa?=
 =?utf-8?B?VUNXSEwzNEdFWE8wZmRtRzNCSkRDYW5RRG9xc2h3VWU5VUNiWm1RU3pidis1?=
 =?utf-8?B?LzdwOFRlQUt3QVMzajFibk9VY3Zqd2YyQkl6YWxJM2IzMk5wSmlGNkd4SDl6?=
 =?utf-8?B?ZGlvSU9RVWZmTm93aGZIUmlaY3B3dFdyVUlUNEY1L0VIbmJJUE10c1kzSUs2?=
 =?utf-8?B?NWhlMCsvNjRtTERNWXF3ck9FQXFWWWsyTG1MRm5uNjVwTGY1VU95L0x4d3pR?=
 =?utf-8?B?ZEhNcVovT0Q0ZlNSYXpmRmZ2dHJYYXk0Q1k0emZ6eVAxTzFYd0R3d1dWM0lH?=
 =?utf-8?B?ZTRHUVlFemRGU1dKZUJpb1RtczJXeHV5dVRXR1Iycjc0eGN5a0lZMVRHMDRT?=
 =?utf-8?Q?kQ92IdelVDiLYpEp3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWRMajJDVGcyU1VlNndnY1VMWm1JaEtnVGVCZzc3YkJFWklpZE53YkpoVGJo?=
 =?utf-8?B?SEVnNVRpN3hIdS9lb1pXSVhpOU10ekk4K3RuSysrQ0RFeUxOMG55ajBWNmpG?=
 =?utf-8?B?REV2bVZxRzBqNTBKb0ZLcmV6WWxZeFVYTjNkNVBHK0o3UzNVSXV0SjJuRVJN?=
 =?utf-8?B?Mm0xVHMxaEhNczI2Mm84QWlOanRMNXZ2OGlTeUpKeEQ2cmNrQUlmZnlsUEx2?=
 =?utf-8?B?eG9BQ2Q5RFdrbjAvQUF0RERRdGlTK2VmU1NQWlNuNDB0bG9OZmlYWkppS3B4?=
 =?utf-8?B?SDEvNlBKUzNBT21tY2E1Tis1d3FnRVZ2d2x6dUJjbnQ5dTZmbTlSOGw3UWs5?=
 =?utf-8?B?Y013UGE0S2l2Yno1SnBxeFo0aFZMaVRoM08zQTZja0ZjL2R5V0NyZkVTVk9L?=
 =?utf-8?B?dGVvYlBXMHhMQ0NDYmdFZnNkNG56QXdpenVkb3ovanozN3BHcDZSdnR3cjA3?=
 =?utf-8?B?R3kyb0JXZnd3UUtKN0o2R1RGc0RORm9iVTAxQ0JDSlJxZ3dDL090aGtmV01r?=
 =?utf-8?B?R2dpM0hQUkdLeU5hbW0ycDY1ajlnc0pVV0REL1FZTVpVZjNIOEg1Q0pXOEtk?=
 =?utf-8?B?NzlPOVNDVmZCTlplMDBDTUhTMEpqajRqOERxOXExYmM0S2ExZUZzTllPWEJp?=
 =?utf-8?B?NzJiYStCN0l3cEJ2MU1Rd2FIVjViYnRqYm1PRGFjZUZVYStRNzZteTRBR3l3?=
 =?utf-8?B?elVhQy80TDVHRWhZMTNsSmdmV1FNUDJzeUtjcVY4UVJrNWJaRVFSSDB5VVc2?=
 =?utf-8?B?R3VqZW9OS2dzYzNlaHR6aldaNlhZWHhwUGMzTWJ6QWVSZnk1S1FhRkRwUllW?=
 =?utf-8?B?dnRGNWdQQnREaTFwb1JJQTF2bVJGekZLZFlsYm1JYmNiOGZNK1FHUUw4TlBu?=
 =?utf-8?B?cDJCelg4RFBmWExHTjBFOXkvSS9Ja0IyQytNaTBUMmpTSTNoYlJlUTNQSFJ3?=
 =?utf-8?B?bGw4em5idDdmdUxVR0hlbFB1alduMW9MQU0vMUZVdFpzTXBEb1FZcW9PREFp?=
 =?utf-8?B?QjJUQW5iQVRWR3VDQURITE1VeHJTdVJmUDFhS2N3R1hLeGg4L3d4eHo5Um5u?=
 =?utf-8?B?L29VUDR4blRFdmtwaTVyM0F2dzd1dTBJTGtwVDQwQ1RKV1UxUkFaa3l2TFZW?=
 =?utf-8?B?QXVDaXRGVjlUQWE2QmF2RGFaT0FHZkY3VWY3YTU0M0FNNzJ4MUw3TEp3bDVi?=
 =?utf-8?B?NFZmcitLYkJaLy94Z2NDNzl6d1dGMEluNDdsV1JkQlJOSmZMV0F4Q2xXbTVr?=
 =?utf-8?B?b0JyMUVJVVE1TWN1dnd0OGVFU1FsYmY2Q2p2RVdoa1NidWs0MVpGZjFuajRE?=
 =?utf-8?B?WmFOTTZUV0psYWw5TzUreU90TFhELzZkQUcxcDFlY1YrZXVvampCN0lseWRw?=
 =?utf-8?B?YlNFdHA1czBnUStpU0JXOUJqSitxamJvRmZjMmt4NHE0U3lJTE5CTHVEQXhD?=
 =?utf-8?B?YWh5cmo5T0tWVmwvbVpFTlFtQ2JyUkRNYjMwemQ1ZVg3ZVNpQ3ZmYmZJc3NR?=
 =?utf-8?B?djFUbXFtUHordkxVSGRKbHVLd0MxTDJmcjlUV1liUU8rcXArMlMyKzdCWkti?=
 =?utf-8?B?dkxPL2ZQWmtYd3NGT3JpMy9pWHpOOFErOXJMYUtHc0pVZDZjcTg1azdYNHds?=
 =?utf-8?B?dzlnQU5kZGlta3lFdFJGMGhKeHpJcHdBZjdwbytqc0xmNm1QUlNzV2wzK0dP?=
 =?utf-8?B?ZlR2R2tYNFpjYTJDaVU4cG0zNXlIOHVIdnZPT3daWDcxNkdaSjJBcTEzcGlW?=
 =?utf-8?B?b2JkZDZUS2hoSmZKTDk3THpaRGN2cFpGTHJ5eTVyQVIrRkQrSmhNSGpxU3V2?=
 =?utf-8?B?cVU1eTh6SDEvWENCZWxUYWM1eHNQamYvRG8rWVpwazZFdVp3RHVxNEZYTlhF?=
 =?utf-8?B?K2RCV1hWekZQdEswTUQ4SXovVDdxeHpOWW1US1M1YWFyVlJyOUhrUFdGaUg0?=
 =?utf-8?B?R1VqaXR5RnZGSEk0dE94Q3c0Z2tHLy85K3AzbThvS0M0NmhqVll5VmFWdGJh?=
 =?utf-8?B?dVJqY0pPVk04alcvSWdpbjNjMTRvOXg1U3lNb0lEYUpFbkt2aGh0NlpyWTJn?=
 =?utf-8?B?N2ozdkMyVFFNSGs1anJsaERpa0xLbFZCb1J4VE5nS3VSZTR4VE9jRXVieHAv?=
 =?utf-8?Q?Tz5KWe9Ftr0wHPEaaZuYoKPWR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e087bee-fa9d-44a9-9198-08dcee7d2c69
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:27:36.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9NzxhhCVNrYNmCmO+Dl9b9rwitqtBHJOOpocQakD/qSsGQVNlHEz3PaQlbi4gA46oCzgvnp4KssJDxnww/RUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570


On 10/17/24 07:29, Huang, Ying wrote:
> Hi, Alejandro,
>
> Alejandro Lucero Palau <alucerop@amd.com> writes:
>
>> I did comment on this some time ago and I'm doing it again.
>>
>>
>> This is originally part of the type2 patchset, and I'm keeping it in
>> V4. I do not understand why you pick code changes (you explicitly said
>> that in the first RFC) from there and use it here, and without
>> previous discussion about this necessity in the list. I do not think
>> this is usual, at least in other kernel subsystems I'm more familiar
>> with, so I will raise this in today's cxl open source collaboration
>> sync.
> No.  I picked this change from Dan's series as follows,
>
> https://eclists.intel.com/sympa//arc/linux-bkc/2024-10/msg00018.html
>
> So, I added co-developed-by and signed-off-by of Dan.
>
> IIUC, your picked this change from Dan's series too?


Look, this is not going well.


You specifically said in your first patchset you considered the type2 
support patchset complete but too large or complex, so you were taking 
parts of it as a prelude for making it easier to review/accept. Just 
face that and not twist the argument.


FWIW, I'm against you doing so because:


1) You should have commented in the type2 patchset about your concern, 
and gave advice about doing such a prelude (by me) or offer yourself for 
doing it.

2) Just following your approach, anyone could do the same for any 
patchset sent to the list. This is not a good precedent.

3) If this is going to be allowed/approved, I'm not going to be 
comfortable within this community. If it is just me, I guess it will not 
be a big loss.


None has commented yet except you and me, what I do not know if it is 
because this is a nasty discussion they do not want to get entangle 
with, or because they just think your approach is OK. If not further 
comment and your patchset is accepted, nothing else will be needed to say.


> Feel free to include this change in your series.  If your patchset is
> merged firstly, I will rebase on yours and drop this change.
>
> [snip]
>
> --
> Best Regards,
> Huang, Ying
