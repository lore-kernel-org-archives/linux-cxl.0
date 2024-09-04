Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97184A5B
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432795; cv=fail; b=lekJ89LurvQKg1HiqscG4KqISqklTP0LbMfJl4XRTYj5MM1mGL1klT754ge1MZwC2vEnN/P0J+wcXQn0wCRiHo585NrHB+LNkg6G+4a31EDkp4EEM02pO/yFfFjx/90Gx+8Fh0V8oru9fh1e3jxt1ApWDHZRdiotJDFwl6CZfmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432795; c=relaxed/simple;
	bh=4YtXOhfK9Z50dXX6EF7nhA9HLKy1y81ojv4SuORPCAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MvyOKH6ej+GR1Hu2u8ykpmgrEZVUJrsFgv0QFytstDUyMKH62i+pJGLU+qke/fWnOgWnT7tCZv0UjCFX/WxTgPJ2jVYafC9z80JvayrIBHhnOah1nkKQgtGoQlX69JcJopIlShTQBOwGuwe2s6GCE+eRO0RvsIze717wpyQ28LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DOoLjCMT; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DOoLjCMT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhULCqSL6PUK8aJK1BQNKPpa3fkv72iaysz77rWGXsaobgaXHa63dODo5TzWBh8aR6yIzQoiv9O07by5UdTZF9jXxE1p1E7TLxHzvCEAh5WwUgOF4ONK3HG/4TuHR/Aj2zwPYdjL2iobZLE6H134cXS0PuM28VVp4PrIkAsv3sKwjpM+CDK7Zj5Z1JaNLzNZVvCRF5vFXSKw0w3sy3a1VSmtQp32wzuDi++dRfJ/a54Msy0Huz5TI2oTV4WGQrxBDdJn+5Jl7Wkh8lyIZ2oWfwgBOjuwzXfv+Nq/w03rGNzoXJ0aWIVD6A49R9CZ/LDFG6L8ht9w8EhyWvirg5XtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKPhsuNJmHvOc7oL/7qjzrr8HjgwyhFPwT3VYFpn7Ew=;
 b=Rtx+ry5zpZQ7eyjFqt4gTSX2lzwgmbNf7QNK/Ar7/004eEPa8tXZwx47BbzoI3vKvsMCv8rJz14RAocWN7O9ZextJSrFcjjOpyD53ulsnd5e28xO/mhK8Fz3tn9njcTYPYd/F/oUDr0Q0Xq4OIpi1t9TvXIr7d6n4dR/yKGJPZIu5F1fKue78BZB7wnY6oENNU2L7N3uBAh73X1eTHGhDkvxNm1NRJIFzDdp8gtTdTW2KcHJnXtt37YLF0Pja3r5DhJGbh0bE38K+Q6otTIDvZCMVF5yNWY0A5uAbS8CFsTLZ2PLrzO3oqpGvCL/KiGt8FOpMIKjvDAzTk/kW9LMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKPhsuNJmHvOc7oL/7qjzrr8HjgwyhFPwT3VYFpn7Ew=;
 b=DOoLjCMTaxxnxPzbiviBxhlgKr+Kxh6kOEI06+vD+hyrfhE2DzN+vZpyXCuS+6aO67TRzmTDqj302gygtOaiS41BqMp3yemcn+k7yHhzgqHSoWnV7UhYcNt1NoO2RC4D9CSl8lyELMskIkL3dN+iOmm4R/pyndT0nJ3qFbqZe9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 06:53:11 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%2]) with mapi id 15.20.7918.019; Wed, 4 Sep 2024
 06:53:10 +0000
Message-ID: <e6cdb731-c2f1-5791-79ff-ff5835009475@amd.com>
Date: Wed, 4 Sep 2024 07:52:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] cxl: move cxl headers to new linux/cxl/ directory
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, fan.ni@samsung.com
References: <20240904000020.1686611-1-dave.jiang@intel.com>
 <20240904000020.1686611-4-dave.jiang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240904000020.1686611-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::8) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 768dba41-abcd-4c30-a697-08dcccae3d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTRrbE44VVVVdWFPcjIrR0ZycnhLdFpVaDE3WC9RNEdnNnBkU3ZZZ1Q5eUg5?=
 =?utf-8?B?WFhGeXY1WjIxV3RtVDQxMk9mWFA2cmxvQlNmZjR0MlViZWhneHBROXFDUDE2?=
 =?utf-8?B?VkVpR1BDYXFISTRIZytHR3EzdnJ3MFRucjhoQ2dkRTBRQm8yWGE1dU9lNXFj?=
 =?utf-8?B?SitMVFo5KzlWRUQ4SkQ0bXVIS3NQakJzaXB0anFrWm9sSlh0TWp5VmNsTmVH?=
 =?utf-8?B?dG5LRWFObU5oUVhhOGthaGFnTGZEWWZWZkt5SkxuS3ErbElkNzVBbFZQSnk5?=
 =?utf-8?B?ZTBPbGJhckVBUEtaQk83VzZ5Tmd6SVBZSjBvT1VJajU2Nk1JdkZ6WG5EM3o3?=
 =?utf-8?B?MllFeEUwVjZERkcwMjV2SWxmNFBValp6NmNEQUUrc3RIbzFqa2ExZXR2dHJQ?=
 =?utf-8?B?YlRqbHdUVkdjeDdtQ29iUWlBTHlENExySDZHbS93US9UQnJWVTJHU01qS09l?=
 =?utf-8?B?MUNWWUdvVzl1SVFCWlRhZjkyZ01xQWN6S2N5blFidHowUHhVUysxRmMvZnZC?=
 =?utf-8?B?Z2RrQzFhSjc4emQ2TXYwVHZSay8weSs2ZFltTDB0bXhWTUZDTjRxMTlqSUNh?=
 =?utf-8?B?dUZoRnAzSjBDcjFYRS80bXJtbDFnSEN1UWRnSURHQ2hLYzVxc1VZRFdtZTBU?=
 =?utf-8?B?cGN5Z2NyUE9uS0U0eU8xQ1VLRWk2czJvcThsZHgzeXdidG16bm9xUkFiQlg5?=
 =?utf-8?B?dG9MY2N5eWM1UGRKWmJTREJ2MllJczk2OGlYdzdSemgzQkZ1dXdONzJoZEpw?=
 =?utf-8?B?Y0c1bTR4SkxFdUdxbUpzZ2taZXozdFdTZC9nbkFHSG9uVjd4ZEd6K0JNNm0z?=
 =?utf-8?B?WGM5VXI5aTZkUG1uM1U2akFCUzRuQTRKNXhxaTAvdFpiakE2c3I3Vk01RElx?=
 =?utf-8?B?ZUpDSlZVVWRZUmRIN0JyOEE4RW9QaEFRbEkvMGlFeVlxZDM0T093WHEzYzVv?=
 =?utf-8?B?M1NaeFAyVFZPUWxBUUhiaS9Vd2JobGczV3BhaGJuemZ5dG5iUHAvNUUwNVFH?=
 =?utf-8?B?WkhnNGJKZkswVlluaDVreU5HVW9CWTlJUjFNTHFoaWJyZ1NHVlRJMVVQNXQx?=
 =?utf-8?B?UUlxcnFYeEpyZ3Bid0MyazM1b1dSVG5CT0ZwVU5MNm9ldXBrc1ZOSG8vS2Zm?=
 =?utf-8?B?RVhsR1gybktKaGF6akFCMkFBSkJFTkx1MmZ1SmloRWI4QWdhZmZzWnYzSWsv?=
 =?utf-8?B?RHhXV3JpdHlPUEVwVVlRV2pxRkpPdVVIcEIzb3I4UkVnbkl3aXJoQmdtZWpS?=
 =?utf-8?B?VTVNL3Zxa3N3b0F1UkdrUGhKWmtnTXNNS09XcFJnK2M2cWVUM1BxaVJub01D?=
 =?utf-8?B?TlczTVEydTlGQ3phMkdBckZ3N2xaTnlESVJoR0gyNm9ZbCtta1A5bHNUWExi?=
 =?utf-8?B?ZFcvZ05SVGNjNkwxQ09wWE5WdmRJbmVqcGt2VXZHSllsYndodmw5dHNpNnll?=
 =?utf-8?B?TnUrd25BaTUzZ1lIK05Rc1hkbzVOUUVqYkZJSzNTYVY0N1d5N053ZFJ3R2wy?=
 =?utf-8?B?Nm1SV3dWMHM3WWsrU0REaVA5TXZDZ25GSUNMK0YxYmE2bjhqQ09iVTJOOUVj?=
 =?utf-8?B?a0dJS3A5dHc0bGk4Njkwbkc0b1BuUDRRa0NodVRzT3F4dzNKeEYvTmNNZmYy?=
 =?utf-8?B?M29TZXFtalBaRzhkL0JQWEZKTnhXU2IxakNoTEkyWVFLeHJuR0ZFM3FvR3NJ?=
 =?utf-8?B?akwxQ05FVUI1TjlVY1QvWnRmdEQwQ1pIaFpGVkliQmE4OU9mYWF5cS9wQXBi?=
 =?utf-8?B?VXJzekVPeEczelJtcVdJa0twekVzTUJyNHJCMjN4QWpOeFBrOU5wcHdNVmFX?=
 =?utf-8?B?MUJJL2JpU0ZuSW0rczhldz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0NJdEdiUExRdzFqMnQvaWVhWW1ZN3FEbmJHRk45eEZLUGJabWtzQlA4bm9F?=
 =?utf-8?B?d1pId3I4a1lEdTBLN2ZSTkpJcGpEam9GZHkxOUlRTkpMT0FLR1FkN3oyR3Ja?=
 =?utf-8?B?Y1hPaWljUC94K05la0pKR29QZjVKVFViVm9Gc2lIY0gvdHRsUGhzUmV5dzZq?=
 =?utf-8?B?T3NkSVFpZWhuZVYwS0xjT2VsYjBjMWZuRjBIK2xlYkNqOGdkTU5DRjZxc1My?=
 =?utf-8?B?SXlKTittNlFHbXlWcEJoek85bVhqc05JMEhtQXYvT0YweXk0K0pTTEtodlhS?=
 =?utf-8?B?NjN5UzVLeEErNk9rZFJzV1k4emdrUld0czF1bUMvbkdKQzNWVUJSQmxVQkVN?=
 =?utf-8?B?bXdTYlhicVFRVVlaU0NuYlFCaXd2Szh5YXlKeFhWdFpQOUR4UjFCSVMvdFcr?=
 =?utf-8?B?Vkd1VzNaTFhLcTFZUXlZYnIzVjhFVE5Cb3JLWjJYSnoxLzllVVhZajBaUklt?=
 =?utf-8?B?K1d5ZGlMeFVhS3JtQkhwU1BIaDBRNFdOOERkZnhxL2xWK2NSTDVOTmxidmNY?=
 =?utf-8?B?SlJWcDhoQXBsK3EzVUVmRlZTZFJWTEFjNEw2YnJqSGdIWEF3Y1EvMjBuM0Zw?=
 =?utf-8?B?ZCtReHB1RmFLeDR6aFBqUVFpaElIYVNlZ3l0S0I2b3Z3NXgyMXdwOWVkYUh0?=
 =?utf-8?B?bDdadkl5bHU1SzZEbEd0Tkt5YUhHSHlIVmdmeUJWa0tSczVLdDJKckt4bXJE?=
 =?utf-8?B?N0w2Ti83ZlVndmdDUlZmNG94MEh6UDN6VzJ0dmxCMGNpRFBlaGs3NGVEQkNQ?=
 =?utf-8?B?aDRPUzVhOG5BK21SdEtGOVN4RWhmVktkZDFJVVRxVXVnSE9WNGhaQTI0VXAx?=
 =?utf-8?B?Y3VMUzE2ZTczbWFrQk1SNFJITElsUzhpbkxSenhEWEFROVV5dW5QS3A1N1ZN?=
 =?utf-8?B?Y0twdnhGVEVkaUIwUi9QZ3hkYU4vUEI4TU9NOE1jb2E3U3ljNzBpR1R6RlFw?=
 =?utf-8?B?VytMUHN3a01ndGNzYitmRlg3SVR5N2QxNVp4NFZpYnUwdTFyeVVRZmsvdFVt?=
 =?utf-8?B?ZkI2S0RQYjlBYjEyUUM2cDRVVHZUMENNZ2NiL040bVhmME5IZW5rRkp1N3ZV?=
 =?utf-8?B?ZGFrTWdKcUNaL0tQU3dRTTcvZU1jM2dhMlNpTUNsZ3ZzdnJvSWRVajNBakZn?=
 =?utf-8?B?UlcxRHIvYUxTdjIraUM4RW1EbiszMHBBYk0zTlhmc1ZBSzBZbXdNR2tVZy95?=
 =?utf-8?B?bDV3QXNqcTlNWWh5YXVwK2tmVFJ0bnQwazJxb3hxZ1VFZDNJbCtFY2svUk9L?=
 =?utf-8?B?cmZrY2JVYmxhcHVJamo1aTdvRks0MmpVVWFScjBNK1ZINmsvVWJtbUJESHc5?=
 =?utf-8?B?VlgzWjZCMzluU1RJTXVBRWJyb3ozMFNDME9iblNRTGd1YmE3aktod2laMzFF?=
 =?utf-8?B?S29hYXFnRmx5cFBsYzJBcFZYaUdiakk4NWRNMkx0TCt5eWVZNzc3ZktzWTVt?=
 =?utf-8?B?TG1ta283cjFCQXoydTdRNncxWWRxQ2tSQ3F2TmtLUlNsTE9YV2RjTEFjbHN2?=
 =?utf-8?B?NGlmV3FqM3lnaEN0RDBlZ1J6eXFoZXV4SkNBTDh3OWhSa1M2RFRPTHpOWGNy?=
 =?utf-8?B?NlZXaU9Fb2ZPRzZpMnJGVHB3QlVwZ0FZOTRWWGl0S3IwVHM2MFdUTDkycllW?=
 =?utf-8?B?UEsxSS9sUVUxQktEQndBM29LT1FkTElYY21vSGF0ZG5hOFZiUGphQm5kVjFi?=
 =?utf-8?B?d1h0dXVsYlZLWlM2eGd1N0Q5enJwMjhuamgwVStGazZWSklDVDJ6Vjh2b29V?=
 =?utf-8?B?a3h6bExkVW5pemp5UzZGMDZCM2YzQ2VVTXpQajFxSWtvdlJXMnNFaFNIZmJ1?=
 =?utf-8?B?UDdtZlV6Wnd2b1ZFcVp1aFpjcHQzZ25kVVJobFNpMWJISE9zb3VZdlI1dTlB?=
 =?utf-8?B?Ymtpdy9obTRCWjN3TjNscGJDaWFUQXZ0R0tiTjgzYmlmcHVrRWJBKzlhMkll?=
 =?utf-8?B?cVd5OWRWcEIvNFF1bEcxcG54TUZhZkVMVWlWZWNZbTgwWXVxME0yUlZRNjBY?=
 =?utf-8?B?TU41SXZQdUlSQ0dQaEVPaGJtQ2xoaklRK2w0dDhRVzJtaGMyOC9zeTJnc1Nu?=
 =?utf-8?B?bXdhbmc3bzJja1FJZUhydUZZVXFNRk16OEZqM0xUNEVLcW82U0ZPRHYvaldL?=
 =?utf-8?Q?0RlDoxsipWQ8oj2QaWKjqTMM3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768dba41-abcd-4c30-a697-08dcccae3d51
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 06:53:10.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5qIoZXl+531raCb+qSr64gF7GaJ5ZP6b3HgmUr6TB0Z1ESr+rmdS22c4OtUhNQWlIk48Hk4NUREoxRmEXiIRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245


On 9/4/24 00:59, Dave Jiang wrote:
> Group all cxl related kernel headers into include/linux/cxl directory.


I tried to do this in the RFC for Type2 support.

I was told to just move the required bits for accel drivers able to do 
CXL initialization,

What has changed since then?



> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   MAINTAINERS                                | 2 --
>   drivers/acpi/apei/einj-cxl.c               | 2 +-
>   drivers/acpi/apei/ghes.c                   | 2 +-
>   drivers/cxl/core/port.c                    | 2 +-
>   drivers/cxl/cxlmem.h                       | 2 +-
>   include/linux/{einj-cxl.h => cxl/einj.h}   | 0
>   include/linux/{cxl-event.h => cxl/event.h} | 0
>   7 files changed, 4 insertions(+), 6 deletions(-)
>   rename include/linux/{einj-cxl.h => cxl/einj.h} (100%)
>   rename include/linux/{cxl-event.h => cxl/event.h} (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf59c003da76..45a56af42a79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5620,8 +5620,6 @@ L:	linux-cxl@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/driver-api/cxl
>   F:	drivers/cxl/
> -F:	include/linux/einj-cxl.h
> -F:	include/linux/cxl-event.h
>   F:	include/linux/cxl/
>   F:	include/uapi/linux/cxl_mem.h
>   F:	tools/testing/cxl/
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> index 8b8be0c90709..54ef0eef18fe 100644
> --- a/drivers/acpi/apei/einj-cxl.c
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -7,7 +7,7 @@
>    *
>    * Author: Ben Cheatham <benjamin.cheatham@amd.com>
>    */
> -#include <linux/einj-cxl.h>
> +#include <linux/cxl/einj.h>
>   #include <linux/seq_file.h>
>   #include <linux/pci.h>
>   
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 623cc0cb4a65..55ec68aa417a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -27,7 +27,7 @@
>   #include <linux/timer.h>
>   #include <linux/cper.h>
>   #include <linux/cleanup.h>
> -#include <linux/cxl-event.h>
> +#include <linux/cxl/event.h>
>   #include <linux/platform_device.h>
>   #include <linux/mutex.h>
>   #include <linux/ratelimit.h>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d5007e3795a..6506dc2a71b1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -3,7 +3,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/memregion.h>
>   #include <linux/workqueue.h>
> -#include <linux/einj-cxl.h>
> +#include <linux/cxl/einj.h>
>   #include <linux/debugfs.h>
>   #include <linux/device.h>
>   #include <linux/module.h>
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 579d5c647189..838f8f16e7dd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -6,7 +6,7 @@
>   #include <linux/pci.h>
>   #include <linux/cdev.h>
>   #include <linux/uuid.h>
> -#include <linux/cxl-event.h>
> +#include <linux/cxl/event.h>
>   #include <linux/node.h>
>   #include <linux/cxl/mailbox.h>
>   #include "cxl.h"
> diff --git a/include/linux/einj-cxl.h b/include/linux/cxl/einj.h
> similarity index 100%
> rename from include/linux/einj-cxl.h
> rename to include/linux/cxl/einj.h
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl/event.h
> similarity index 100%
> rename from include/linux/cxl-event.h
> rename to include/linux/cxl/event.h
