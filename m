Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF335280
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649542; cv=fail; b=NmS0q4ta3cxPo3Rj9dA9tqyr8L8P8TIaeGi8keOmX0k7kYvpUkeLUnGZwisvvtIF5UOmuNpBDeOFRtuy8muI68kLXDzZ76dneA4cGo5UE2HtBUtAvTNRzstJ8JDfAGCRM2XQB32s8TOHwFfkR58vU7ulDylQz0KDnPwlHPSXHUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649542; c=relaxed/simple;
	bh=1gMslxX2P5k1Zo+WCQLZ34qGvACyL8y0/iJb0Ewvz/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CUZXAqZ5zPERBK7rkBEXgQugKthbpws/4qjR4H9BzK44VnTJA6nHbywc2iWzfNG2GKlsDEjhzYlVmv4k0Bb7JJFg3muWeGeX1QHUsGwUKh4Sm5OVwNfJLuWYh+IDSiqpZpul3mTLAj/t9/oOBbIndJ1588Avq70BDhCTu2jFQSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Eyqssx4U; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Eyqssx4U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVOA3m/8gOqNq/Y5v6mkqYDNFpGHkYa7dRCla6ZNGB2ymjJciSnTClpbK0P/NlVF4hesteqMPiIUmOzAiSSPqvjH3ukzBmtIMDrf6P6d4rsf7rw//ydcKy5n0Bl8tL43bkqIJmm1FpEGaEHlSvlzUoR9O5lSQjtA/0M3tdIxn+WAT2NLT7yN6nGoemET+cSqDQ0v/c1UmkTdk9ONY66bfQuAOwV2WoE9zDj2QMrIoGRV0sGqTOnrr30EnXwPmblt/Dl1PwnlS4VCCTK6t7C/83UB1eXGtfCxOnlajTuEEUlnDa0J3mz9jXTB7ZNr++qLyEhfXTc6Dro6AKaxPqoY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8Er2JwIA/AsjN1W2fO9YCMepE2o7wQ98mhE8csNIKk=;
 b=Rjv4yXwuNO2H9Az99735uUvylC70RoMaGmr7oj85YX5Vm2fqtXpZpi9yJJeJVVFbxmf5g0vGOLvSuwBePu4IxjuBtNTSiv/e7NCJLJ6WU2DFud5LI/6Kb0TcslIPWyJfMgbl1UOVQjSwdIArCt6cwG1FdhgxW9mCZ2jf8hfFUDpKUkBKaY0JE+l42FLwDx2H4aCiI7L/HyRftOh2MNhsyZKx+zPKJ3L0wC3qYJ6bNH7zla2ZaNnBnoMiyLprJMsd3otUKBL3872DRPSwDPM0oGNUoiT0EWxF1UDsS0gnfA4kDF8NcoTy2TVi+BAOa08yWQ4iurM9o7CAwZP9RoFQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8Er2JwIA/AsjN1W2fO9YCMepE2o7wQ98mhE8csNIKk=;
 b=Eyqssx4UdfGPHhlA3zd5fdYYvxra0d4zgb4UuJoWZ3m+wnMWB3qyCqhD9OX23h5LI9lNxfAWj7BQ3yDZWNWhG+FcrOT+0WQ4W5uoWt0K/4qCCvORQmwOVptMpC43B5nn6Z6moiHbBM4ZwgGvXhOv1ZqsC2p+pI2jdn38SZBY6F8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 16:25:36 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 16:25:36 +0000
Message-ID: <0ebda6db-8431-3ef3-9c24-d19cbec7f338@amd.com>
Date: Thu, 23 Jan 2025 16:25:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636159.3849855.512949598685608224.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173753636159.3849855.512949598685608224.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU6P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: f5516535-f5e1-46e2-a2b4-08dd3bca9153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aER0OHV4Mk1aNFo0MHhuWEF3ajJmeFpjaDFjVjBEMFVCZVhZZi9wZXFtamd2?=
 =?utf-8?B?Nno2a3ZWR3VLNGlWMXRkSEp5VjdEblNCckpJMkRsOUJ5UE1ERWExMXFJSzcv?=
 =?utf-8?B?M2srSkllR25yeW9FTHljZS90Zk1pYUJmR3N5VzRIQTh4NjljUldCUjJ5YkU5?=
 =?utf-8?B?dlhtUk9WQlVqdFF4Ums3WlRPRG11MU5ZcitNaHN4andveE5YejdYdlR3UFA2?=
 =?utf-8?B?M3pTaFpZVHZmelVIaEhZUkQ1YlpTRTgxc0RKejZ1MS9qRGtKSGhnRnd4b2Ro?=
 =?utf-8?B?RFp4REwyMG01TFBTSkNuQkFQMGJ5em1aUVovaGZJR3Q3NmpUZmdlQmQ5eENz?=
 =?utf-8?B?MVF4dTZrZzJDU0xnUzVGc2QzNUJjZ01MeW1lRHR6Tzg1ZEpYK1lzSGsxaXA3?=
 =?utf-8?B?QURGRzIxRGMvdG9hTTVhZTVxUGFFaStsNmpMaUVSN1J4ZHdTK0kwQXdXeU9W?=
 =?utf-8?B?N1Ftc0l1YkxheXpMRTZzbkdNV2w1SXhDamppajhpN1BhK2JBbzVmUDNzdjA5?=
 =?utf-8?B?VXRKT21sTzlxbllnNzNEb2dOZ2tlOW5OQmJzOXZodVRPbng2TVo3cXRUTGhD?=
 =?utf-8?B?VFE1SFFsR0xQV2x1R2Z6eUJwSFNGbzNMdk81ZnRIUU9DR3dFTGNBUW1rUnZj?=
 =?utf-8?B?cWlVSTIybWt2RVBrY1hvUGwyTVg3WmhDNFhQV3hBT3NXdnZxKzNwM3Jmc2RE?=
 =?utf-8?B?Sk90SWtIYk1JM3BuTGt3VDQxVHFqSTBUb21pTXBTdVhRQ2toS0dnL2RaYUxY?=
 =?utf-8?B?VnJIZVpSazhlVm9KQ1R2bGwwanl0Vmg2VEF2SDJheUsrbUJIOXduMzE3MUdh?=
 =?utf-8?B?OEl4dkp6LzNBYTdrS0NkZU5lQmhZMGhPTnJSUkhRK1NTWE1QcHBFNkk2aEwx?=
 =?utf-8?B?a2ZKSVpNQXlJWVNNVW9ya2srMHhQcFpXcm0waStaQVNsUmR1eVFlVmVtekNS?=
 =?utf-8?B?bUpSS0hiOHRnNDdrWHU5S1czNmg0bjh0VnR2bk1oM0l0K1pTazZXV3lXYVUz?=
 =?utf-8?B?WWtzR01tK211b3BKemlrM0dBdzlJbzFUNkR0b3RtdVIrZzhpSU93cmJyd2xG?=
 =?utf-8?B?RWN2VkptMnpPbkoxbFF5M2NydUVUaDhWVjh0MG51bHk3TGsxMFl2clJRblZ6?=
 =?utf-8?B?bWdlYTErTlc2eU1obHpkTG9DVTFscjhwSGtHeWVyVFZVN2RhelF0L1Bwa3hv?=
 =?utf-8?B?KzR6WmtwcUpaVjhWUko0VjVGYWY1UUNxajJDcDhnVmJUd254c2xIMDErMWF3?=
 =?utf-8?B?akxoQ1pXMWJFTW9DbkRSNG5nK2cybDZwOVJpd2xQSjhYYnRWN1g1aFhFVXhX?=
 =?utf-8?B?NVcyeHh6bGhCbXpybXEwVnNCc1JxeU10Rmlra2YxTS9DVjdhLzdQeGFXZllt?=
 =?utf-8?B?L2wyTGcxL2VsdHk5LzZzbjF3T0xrK0QyRXVxVXFyRSttN3Axd3hhNXlqOHY4?=
 =?utf-8?B?R3dNaE85QzZXcWN1TG82WXFTdnp2ay9yeGZzY2NLajVHVXFnREhYbFlXRk05?=
 =?utf-8?B?RGNia2tZbkFlT1Z3a3Q5dXJydUQvUjA3QWhaODA2OGpLWkljenF4REIrb3pj?=
 =?utf-8?B?OFBONEVkOVQwcTIzYTU5TmV3UVlyYnp3UFJKSDIydHZBbjJHU21WUEF4dDRY?=
 =?utf-8?B?ak5naHgzd24yd3NlcUxTYlNmSmdpZTF0eUVPUXZiUW8zTyswdmIzUk9WNE9v?=
 =?utf-8?B?clROWlJqV2gycTVON0pFZ0pxSy9vVW9qWEpRQkx6d2VXQ1o0TE95U0lmcUY4?=
 =?utf-8?B?SldTVDRVQURiQjhqSm5FclNSdFBqMG0zN2dMVlJzZzZaek5mbkxCeDh6eDlZ?=
 =?utf-8?B?cXhDSHBlN28wbWpyS0JISmZOU0NvWjJlZU0yT051M3pnaUdZckRBeXpKR1BB?=
 =?utf-8?Q?Sk1v6tbfWBn05?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2NwOUl1eXE4V3J5YjZaRHVrTHBwSzRmSTRxQ3dBNW9jL1pHbk5iL1FqMk1k?=
 =?utf-8?B?YjZFcEJmdlpBZWNGY3huSW9LQnVXSWZqSkM3ZVZQZXVPaFQxMGQ4cGI2WEZk?=
 =?utf-8?B?dVlvaDFvNjRteDE3LzFjU3pmSG1IL3pSZk0zbjQvak1sbGJTcEhLZXMwLzNh?=
 =?utf-8?B?OTZjT2Fnc3R1TWF3YmJrWE1tUmVGTXBzU1FQR3loVTMzN2FxQThRZlhmSDdM?=
 =?utf-8?B?cGdOMXF4eVhrYlNrakM2U1FNWURDZXl5ZW9RYkU4T2pMNjc2MnFISW5xbHY5?=
 =?utf-8?B?VXZZV0RaYnRzTTVpbE1BT040eW52ZG8wcmJ6TTJTbnlJRk5nMFJJeDI4cFNE?=
 =?utf-8?B?VHJkT254ay83U0I5WHBxcUZRNHFXNm5nNThjLzZDQWVMeFJMRnNmN1AxZHov?=
 =?utf-8?B?dTErRldxVTBRSXJjMzRjZmlDU1dnMWxPcWlUSmdaVzJtWVJUNzBFcW5YdDNB?=
 =?utf-8?B?WExXNThhMzA4TXRiQ1BmZ0Q3YnlJMkJKV21xdnF0cCsxTDdiMmtzb0VGRDhr?=
 =?utf-8?B?ZDBTbUppTEhQWkhkbjhFcnhZNWhXWWhIUTc0RkRqVUdXVmhDM2dLOUpQMFAw?=
 =?utf-8?B?Wi9qYndJOGNVNUtHM0RpYWd2NEpqYXF1c25uRkdCOGpyZkVES3h5TnQ4R2RZ?=
 =?utf-8?B?eFdmUGhjd2dLbjNBZzVOeWpoUDdCeHo5OU1zTExVaFNLUTlhVHhodXdBMDRi?=
 =?utf-8?B?SVQrMlUyVDUyQU41T0U3dzNvU0NxbkNoYUMxTVlITEZlZHNhdThWbDI4VDFj?=
 =?utf-8?B?a0tlL0JreUZDczB3UmswVXc3dlR2dVV4NWFHZ1pmRk1wMlVXUUYxZG1DSGxl?=
 =?utf-8?B?WHRTV2FZMU9vb3VreUc0MjZOWWU4MWlyQUdERWM4K09WRFF1bTJtaWdIK0py?=
 =?utf-8?B?M1VwaTZFOUFXT29sb3JIZFZwYXhpd0UzMzMxdURhSXhBUTcvaEw0Zk9jWDZk?=
 =?utf-8?B?QXB5eUE5Z0c0eTQ0YzN5M1RBRUZReUtObHFIbUVBcnc1YlhpOGlOYkhEUzlU?=
 =?utf-8?B?UC8xaGhqMkdvNUE0VFJ1L1NPS0F3eUdiU041QVNhc2VURGczYUpzdnFiemVK?=
 =?utf-8?B?MGVuaEUvUkdnS3AwUzMwWEo3Rkp4b08zV1NGZ0sxRDA2L3V4NGREMVVNVHoz?=
 =?utf-8?B?UHBacUJkQ0ZKaHNVR1JMdEVWUUpsWHlHZkJFeXVsR3VpUWZDZjJXeVpqLzBG?=
 =?utf-8?B?eTlnbjA5RCtGSEFQUCsrajcwdkI0dHpOb2pPSTMxSC94Y0NYKzRFNk5FeURs?=
 =?utf-8?B?OW9oL2FUeW9ubDZoTlJHZkhJT3drdDhEa2JXRGIzREl6TmFlZWcxNXJnV0Zk?=
 =?utf-8?B?QlQxbzZPZDE3YWNqNEJpS250dzVuZ0xmYjlVNldBV0dod2Y3L09LU25IQWhZ?=
 =?utf-8?B?ZWlZUG4wQ1dQWjBPbmVYZVNrSFNtNXZONEt3TUE3WDV2ZGZsNVdFalBVSHFG?=
 =?utf-8?B?MnBnWmxleitDcVRtQnhlaDhaNzczSDRSWUNNSE9ZcHpBWkdIUS85VmxkS1BY?=
 =?utf-8?B?L0RZQ2ZMY1JoT3EzL0RvZnhKVVVJTWJGTHhVeXVSYWhSRmIyUEtMVjdWRGVX?=
 =?utf-8?B?ZS9vcUVieWg5dUo3UFVGcC9Qd2VvNlhpeThvbU9wNzJTTlRyZmI3RUVOL2RW?=
 =?utf-8?B?bVlxRDI2QlY5UjF6bGdTRDF1L0xoVG94NktTRDJIeVdYSWVwREllaUgwNlp4?=
 =?utf-8?B?bVJUVVZBdHB0eDlHZmVaOWdiTDBGaURSWTNVN2xOdUFnd2NYcy93aUlnT3Fw?=
 =?utf-8?B?OWZvRVZmT2ZZTEpQaXhhNjdhSjNWODFVOXg2cWtDbjJRVGYyd2RodXhvbSti?=
 =?utf-8?B?aDJEa0tFMS9uSFprQjVlZUlEYjF2SlBGRlptOEY0dnZXTFJkZ1BxYWo3T3Z1?=
 =?utf-8?B?MHFCREJQVnZwN1Y1MWVwZlY4RkVvZkFkTVpxOVdYTlQzMjE1cjVZRXFseXZo?=
 =?utf-8?B?emlncExnS0o4eWMrVlA3NXFhWXNEOUNHWCt2RTVpWlIxMmdZVzN6ZzlyNk5z?=
 =?utf-8?B?TjMxY3Y4UHlpVmFVSFFlYkNyTTc0NklpQXpRUVdnWDJlcktJMmcxUVNZTGkr?=
 =?utf-8?B?bmdqaDEzU0xVVUt0VXBza21OakV2eEZlYzVBbkVYZjNEWUhPcURwYXBRT3NF?=
 =?utf-8?Q?dWmBCWEna4hXQ5TvjUpB133GI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5516535-f5e1-46e2-a2b4-08dd3bca9153
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:25:36.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQEzXjs+hdENh9yMdpZUotQrt80bE1+Ya5FaOaaeblKmAMY50NYOJDR0KhVBHaxUwV6v/cefn6EkrsgILyyg/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469


On 1/22/25 08:59, Dan Williams wrote:
> In preparation for consolidating all DPA partition information into an
> array of DPA metadata, introduce helpers that hide the layout of the
> current data. I.e. make the eventual replacement of ->ram_res,
> ->pmem_res, ->ram_perf, and ->pmem_perf with a new DPA metadata array a
> no-op for code paths that consume that information, and reduce the noise
> of follow-on patches.
>
> The end goal is to consolidate all DPA information in 'struct
> cxl_dev_state', but for now the helpers just make it appear that all DPA
> metadata is relative to @cxlds.
>
> Note that a follow-on patch also cleans up the temporary placeholders of
> @ram_res, and @pmem_res in the qos_class manipulation code,
> cxl_dpa_alloc(), and cxl_mem_create_range_info().
>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/cdat.c      |   70 +++++++++++++++++++++++++-----------------
>   drivers/cxl/core/hdm.c       |   26 ++++++++--------
>   drivers/cxl/core/mbox.c      |   18 ++++++-----
>   drivers/cxl/core/memdev.c    |   42 +++++++++++++------------
>   drivers/cxl/core/region.c    |   10 ++++--
>   drivers/cxl/cxlmem.h         |   58 ++++++++++++++++++++++++++++++-----
>   drivers/cxl/mem.c            |    2 +
>   tools/testing/cxl/test/cxl.c |   25 ++++++++-------
>   8 files changed, 159 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..b177a488e29b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -258,29 +258,33 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>   static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>   				     struct xarray *dsmas_xa)
>   {
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   	struct device *dev = cxlds->dev;
> -	struct range pmem_range = {
> -		.start = cxlds->pmem_res.start,
> -		.end = cxlds->pmem_res.end,
> -	};
> -	struct range ram_range = {
> -		.start = cxlds->ram_res.start,
> -		.end = cxlds->ram_res.end,
> -	};
>   	struct dsmas_entry *dent;
>   	unsigned long index;
> +	const struct resource *partition[] = {
> +		to_ram_res(cxlds),
> +		to_pmem_res(cxlds),
> +	};
> +	struct cxl_dpa_perf *perf[] = {
> +		to_ram_perf(cxlds),
> +		to_pmem_perf(cxlds),
> +	};
>   
>   	xa_for_each(dsmas_xa, index, dent) {
> -		if (resource_size(&cxlds->ram_res) &&
> -		    range_contains(&ram_range, &dent->dpa_range))
> -			update_perf_entry(dev, dent, &mds->ram_perf);
> -		else if (resource_size(&cxlds->pmem_res) &&
> -			 range_contains(&pmem_range, &dent->dpa_range))
> -			update_perf_entry(dev, dent, &mds->pmem_perf);
> -		else
> -			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> -				&dent->dpa_range);
> +		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> +			const struct resource *res = partition[i];
> +			struct range range = {
> +				.start = res->start,
> +				.end = res->end,
> +			};
> +
> +			if (range_contains(&range, &dent->dpa_range))
> +				update_perf_entry(dev, dent, perf[i]);


This is checking if range contains dent->dpa_range.

I think it is just the opposite.


> +			else
> +				dev_dbg(dev,
> +					"no partition for dsmas dpa: %pra\n",
> +					&dent->dpa_range);
> +		}
>   	}
>   }
>   
> @@ -304,6 +308,9 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>   
>   static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>   {
> +	if (!dpa_perf)
> +		return;
> +
>   	*dpa_perf = (struct cxl_dpa_perf) {
>   		.qos_class = CXL_QOS_CLASS_INVALID,
>   	};
> @@ -312,6 +319,9 @@ static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>   static bool cxl_qos_match(struct cxl_port *root_port,
>   			  struct cxl_dpa_perf *dpa_perf)
>   {
> +	if (!dpa_perf)
> +		return false;
> +
>   	if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
>   		return false;
>   
> @@ -346,7 +356,8 @@ static int match_cxlrd_hb(struct device *dev, void *data)
>   static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>   {
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_dpa_perf *ram_perf = to_ram_perf(cxlds),
> +			    *pmem_perf = to_pmem_perf(cxlds);
>   	struct cxl_port *root_port;
>   	int rc;
>   
> @@ -359,17 +370,17 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>   	root_port = &cxl_root->port;
>   
>   	/* Check that the QTG IDs are all sane between end device and root decoders */
> -	if (!cxl_qos_match(root_port, &mds->ram_perf))
> -		reset_dpa_perf(&mds->ram_perf);
> -	if (!cxl_qos_match(root_port, &mds->pmem_perf))
> -		reset_dpa_perf(&mds->pmem_perf);
> +	if (!cxl_qos_match(root_port, ram_perf))
> +		reset_dpa_perf(ram_perf);
> +	if (!cxl_qos_match(root_port, pmem_perf))
> +		reset_dpa_perf(pmem_perf);
>   
>   	/* Check to make sure that the device's host bridge is under a root decoder */
>   	rc = device_for_each_child(&root_port->dev,
>   				   cxlmd->endpoint->host_bridge, match_cxlrd_hb);
>   	if (!rc) {
> -		reset_dpa_perf(&mds->ram_perf);
> -		reset_dpa_perf(&mds->pmem_perf);
> +		reset_dpa_perf(ram_perf);
> +		reset_dpa_perf(pmem_perf);
>   	}
>   
>   	return rc;
> @@ -567,6 +578,9 @@ static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
>   		.end = dpa_res->end,
>   	};
>   
> +	if (!perf)
> +		return false;
> +


This change seems to be an improvement or hardening. Not against doing 
it, but seizing the change, the function can be simplified using the 
parameter without any local variable.


>   	return range_contains(&perf->dpa_range, &dpa);
>   }
>   
> @@ -574,15 +588,15 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>   					       enum cxl_decoder_mode mode)
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_dpa_perf *perf;
>   
>   	switch (mode) {
>   	case CXL_DECODER_RAM:
> -		perf = &mds->ram_perf;
> +		perf = to_ram_perf(cxlds);
>   		break;
>   	case CXL_DECODER_PMEM:
> -		perf = &mds->pmem_perf;
> +		perf = to_pmem_perf(cxlds);
>   		break;
>   	default:
>   		return ERR_PTR(-EINVAL);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 2848d6991d45..7a85522294ad 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,9 +327,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	cxled->dpa_res = res;
>   	cxled->skip = skipped;
>   
> -	if (resource_contains(&cxlds->pmem_res, res))
> +	if (resource_contains(to_pmem_res(cxlds), res))
>   		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(&cxlds->ram_res, res))
> +	else if (resource_contains(to_ram_res(cxlds), res))
>   		cxled->mode = CXL_DECODER_RAM;
>   	else {
>   		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> @@ -442,11 +442,11 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>   	 * Only allow modes that are supported by the current partition
>   	 * configuration
>   	 */
> -	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
> +	if (mode == CXL_DECODER_PMEM && !cxl_pmem_size(cxlds)) {
>   		dev_dbg(dev, "no available pmem capacity\n");
>   		return -ENXIO;
>   	}
> -	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
> +	if (mode == CXL_DECODER_RAM && !cxl_ram_size(cxlds)) {
>   		dev_dbg(dev, "no available ram capacity\n");
>   		return -ENXIO;
>   	}
> @@ -464,6 +464,8 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   	struct device *dev = &cxled->cxld.dev;
>   	resource_size_t start, avail, skip;
>   	struct resource *p, *last;
> +	const struct resource *ram_res = to_ram_res(cxlds);
> +	const struct resource *pmem_res = to_pmem_res(cxlds);
>   	int rc;
>   
>   	down_write(&cxl_dpa_rwsem);
> @@ -480,37 +482,37 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   		goto out;
>   	}
>   
> -	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
> +	for (p = ram_res->child, last = NULL; p; p = p->sibling)
>   		last = p;
>   	if (last)
>   		free_ram_start = last->end + 1;
>   	else
> -		free_ram_start = cxlds->ram_res.start;
> +		free_ram_start = ram_res->start;
>   
> -	for (p = cxlds->pmem_res.child, last = NULL; p; p = p->sibling)
> +	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
>   		last = p;
>   	if (last)
>   		free_pmem_start = last->end + 1;
>   	else
> -		free_pmem_start = cxlds->pmem_res.start;
> +		free_pmem_start = pmem_res->start;
>   
>   	if (cxled->mode == CXL_DECODER_RAM) {
>   		start = free_ram_start;
> -		avail = cxlds->ram_res.end - start + 1;
> +		avail = ram_res->end - start + 1;
>   		skip = 0;
>   	} else if (cxled->mode == CXL_DECODER_PMEM) {
>   		resource_size_t skip_start, skip_end;
>   
>   		start = free_pmem_start;
> -		avail = cxlds->pmem_res.end - start + 1;
> +		avail = pmem_res->end - start + 1;
>   		skip_start = free_ram_start;
>   
>   		/*
>   		 * If some pmem is already allocated, then that allocation
>   		 * already handled the skip.
>   		 */
> -		if (cxlds->pmem_res.child &&
> -		    skip_start == cxlds->pmem_res.child->start)
> +		if (pmem_res->child &&
> +		    skip_start == pmem_res->child->start)
>   			skip_end = skip_start - 1;
>   		else
>   			skip_end = start - 1;
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..3502f1633ad2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1270,24 +1270,26 @@ static int add_dpa_res(struct device *dev, struct resource *parent,
>   int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>   {
>   	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct resource *ram_res = to_ram_res(cxlds);
> +	struct resource *pmem_res = to_pmem_res(cxlds);
>   	struct device *dev = cxlds->dev;
>   	int rc;
>   
>   	if (!cxlds->media_ready) {
>   		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> -		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
> -		cxlds->pmem_res = DEFINE_RES_MEM(0, 0);
> +		*ram_res = DEFINE_RES_MEM(0, 0);
> +		*pmem_res = DEFINE_RES_MEM(0, 0);


This is a good example for the discussion about the  patch hardening 
resource_contains. The initialization seems fine but IORESOURCE_UNSET 
not used.

it could be argued the resource is set, but it is a zero-size resource 
leading to problems in current CXL code.


>   		return 0;
>   	}
>   
>   	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
>   
>   	if (mds->partition_align_bytes == 0) {
> -		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
>   				 mds->volatile_only_bytes, "ram");
>   		if (rc)
>   			return rc;
> -		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
> +		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
>   				   mds->volatile_only_bytes,
>   				   mds->persistent_only_bytes, "pmem");
>   	}
> @@ -1298,11 +1300,11 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>   		return rc;
>   	}
>   
> -	rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> +	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
>   			 mds->active_volatile_bytes, "ram");
>   	if (rc)
>   		return rc;
> -	return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
> +	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
>   			   mds->active_volatile_bytes,
>   			   mds->active_persistent_bytes, "pmem");
>   }
> @@ -1450,8 +1452,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>   	mds->cxlds.reg_map.host = dev;
>   	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>   	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> -	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
> -	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
> +	to_ram_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
> +	to_pmem_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
>   
>   	return mds;
>   }
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ae3dfcbe8938..c5f8320ed330 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -80,7 +80,7 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(&cxlds->ram_res);
> +	unsigned long long len = resource_size(to_ram_res(cxlds));
>   
>   	return sysfs_emit(buf, "%#llx\n", len);
>   }
> @@ -93,7 +93,7 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(&cxlds->pmem_res);
> +	unsigned long long len = cxl_pmem_size(cxlds);
>   
>   	return sysfs_emit(buf, "%#llx\n", len);
>   }
> @@ -198,16 +198,20 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>   	int rc = 0;
>   
>   	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> -	if (resource_size(&cxlds->pmem_res)) {
> -		offset = cxlds->pmem_res.start;
> -		length = resource_size(&cxlds->pmem_res);
> +	if (cxl_pmem_size(cxlds)) {
> +		const struct resource *res = to_pmem_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
>   		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>   		if (rc)
>   			return rc;
>   	}
> -	if (resource_size(&cxlds->ram_res)) {
> -		offset = cxlds->ram_res.start;
> -		length = resource_size(&cxlds->ram_res);
> +	if (cxl_ram_size(cxlds)) {
> +		const struct resource *res = to_ram_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
>   		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>   		/*
>   		 * Invalid Physical Address is not an error for
> @@ -409,9 +413,8 @@ static ssize_t pmem_qos_class_show(struct device *dev,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> -	return sysfs_emit(buf, "%d\n", mds->pmem_perf.qos_class);
> +	return sysfs_emit(buf, "%d\n", to_pmem_perf(cxlds)->qos_class);
>   }
>   
>   static struct device_attribute dev_attr_pmem_qos_class =
> @@ -428,9 +431,8 @@ static ssize_t ram_qos_class_show(struct device *dev,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> -	return sysfs_emit(buf, "%d\n", mds->ram_perf.qos_class);
> +	return sysfs_emit(buf, "%d\n", to_ram_perf(cxlds)->qos_class);
>   }
>   
>   static struct device_attribute dev_attr_ram_qos_class =
> @@ -466,11 +468,11 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf = to_ram_perf(cxlmd->cxlds);
>   
> -	if (a == &dev_attr_ram_qos_class.attr)
> -		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
> -			return 0;
> +	if (a == &dev_attr_ram_qos_class.attr &&
> +	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> +		return 0;
>   
>   	return a->mode;
>   }
> @@ -485,11 +487,11 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf = to_pmem_perf(cxlmd->cxlds);
>   
> -	if (a == &dev_attr_pmem_qos_class.attr)
> -		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
> -			return 0;
> +	if (a == &dev_attr_pmem_qos_class.attr &&
> +	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> +		return 0;
>   
>   	return a->mode;
>   }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e4885acac853..9f0f6fdbc841 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2688,7 +2688,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>   
>   	if (ctx->mode == CXL_DECODER_RAM) {
>   		offset = ctx->offset;
> -		length = resource_size(&cxlds->ram_res) - offset;
> +		length = cxl_ram_size(cxlds) - offset;
>   		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>   		if (rc == -EFAULT)
>   			rc = 0;
> @@ -2700,9 +2700,11 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>   		length = resource_size(&cxlds->dpa_res) - offset;
>   		if (!length)
>   			return 0;
> -	} else if (resource_size(&cxlds->pmem_res)) {
> -		offset = cxlds->pmem_res.start;
> -		length = resource_size(&cxlds->pmem_res);
> +	} else if (cxl_pmem_size(cxlds)) {
> +		const struct resource *res = to_pmem_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
>   	} else {
>   		return 0;
>   	}
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..78e92e24d7b5 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -423,8 +423,8 @@ struct cxl_dpa_perf {
>    * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>    * @media_ready: Indicate whether the device media is usable
>    * @dpa_res: Overall DPA resource tree for the device
> - * @pmem_res: Active Persistent memory capacity configuration
> - * @ram_res: Active Volatile memory capacity configuration
> + * @_pmem_res: Active Persistent memory capacity configuration
> + * @_ram_res: Active Volatile memory capacity configuration
>    * @serial: PCIe Device Serial Number
>    * @type: Generic Memory Class device or Vendor Specific Memory device
>    * @cxl_mbox: CXL mailbox context
> @@ -438,13 +438,41 @@ struct cxl_dev_state {
>   	bool rcd;
>   	bool media_ready;
>   	struct resource dpa_res;
> -	struct resource pmem_res;
> -	struct resource ram_res;
> +	struct resource _pmem_res;
> +	struct resource _ram_res;
>   	u64 serial;
>   	enum cxl_devtype type;
>   	struct cxl_mailbox cxl_mbox;
>   };
>   
> +static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +{
> +	return &cxlds->_ram_res;
> +}
> +
> +static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +{
> +	return &cxlds->_pmem_res;
> +}
> +
> +static inline resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
> +{
> +	const struct resource *res = to_ram_res(cxlds);
> +
> +	if (!res)
> +		return 0;
> +	return resource_size(res);
> +}
> +
> +static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
> +{
> +	const struct resource *res = to_pmem_res(cxlds);
> +
> +	if (!res)
> +		return 0;
> +	return resource_size(res);
> +}
> +
>   static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   {
>   	return dev_get_drvdata(cxl_mbox->host);
> @@ -471,8 +499,8 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>    * @active_persistent_bytes: sum of hard + soft persistent
>    * @next_volatile_bytes: volatile capacity change pending device reset
>    * @next_persistent_bytes: persistent capacity change pending device reset
> - * @ram_perf: performance data entry matched to RAM partition
> - * @pmem_perf: performance data entry matched to PMEM partition
> + * @_ram_perf: performance data entry matched to RAM partition
> + * @_pmem_perf: performance data entry matched to PMEM partition
>    * @event: event log driver state
>    * @poison: poison driver state info
>    * @security: security driver state info
> @@ -496,8 +524,8 @@ struct cxl_memdev_state {
>   	u64 next_volatile_bytes;
>   	u64 next_persistent_bytes;
>   
> -	struct cxl_dpa_perf ram_perf;
> -	struct cxl_dpa_perf pmem_perf;
> +	struct cxl_dpa_perf _ram_perf;
> +	struct cxl_dpa_perf _pmem_perf;
>   
>   	struct cxl_event_state event;
>   	struct cxl_poison_state poison;
> @@ -505,6 +533,20 @@ struct cxl_memdev_state {
>   	struct cxl_fw_state fw;
>   };
>   
> +static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> +
> +	return &mds->_ram_perf;
> +}
> +
> +static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> +
> +	return &mds->_pmem_perf;
> +}
> +
>   static inline struct cxl_memdev_state *
>   to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>   {
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2f03a4d5606e..9675243bd05b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -152,7 +152,7 @@ static int cxl_mem_probe(struct device *dev)
>   		return -ENXIO;
>   	}
>   
> -	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> +	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>   		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
>   		if (rc) {
>   			if (rc == -ENODEV)
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index d0337c11f9ee..7f1c5061307b 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1000,25 +1000,28 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>   		find_cxl_root(port);
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
> -	struct range pmem_range = {
> -		.start = cxlds->pmem_res.start,
> -		.end = cxlds->pmem_res.end,
> +	const struct resource *partition[] = {
> +		to_ram_res(cxlds),
> +		to_pmem_res(cxlds),
>   	};
> -	struct range ram_range = {
> -		.start = cxlds->ram_res.start,
> -		.end = cxlds->ram_res.end,
> +	struct cxl_dpa_perf *perf[] = {
> +		to_ram_perf(cxlds),
> +		to_pmem_perf(cxlds),
>   	};
>   
>   	if (!cxl_root)
>   		return;
>   
> -	if (range_len(&ram_range))
> -		dpa_perf_setup(port, &ram_range, &mds->ram_perf);
> +	for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> +		const struct resource *res = partition[i];
> +		struct range range = {
> +			.start = res->start,
> +			.end = res->end,
> +		};
>   
> -	if (range_len(&pmem_range))
> -		dpa_perf_setup(port, &pmem_range, &mds->pmem_perf);
> +		dpa_perf_setup(port, &range, perf[i]);
> +	}
>   
>   	cxl_memdev_update_perf(cxlmd);
>   
>
