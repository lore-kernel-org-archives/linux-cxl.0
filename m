Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74C9310636
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021120; cv=fail; b=oldUSVteH6ee9sotrC8pZtqqyTC6JcqmiR2Ohppnu9RaTiR5jNKDwWsaZbfmzDL3V9NyGrvZPqiG/+ZWkDMZugSlot/b3YUfJANgqSKHBnlbxSuttHQfL7bueyXS4HuTQPJrH/Q1fxgdY4VCCo+vn0JbF0SuOi+A2h9IQcAcg7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021120; c=relaxed/simple;
	bh=b1T2Ora3ZpNyFRCqm/KIwXSziGR+7qq2hJ2XJDEzIVM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YRWBnSHomK+z5wVXAPvbmxBayFGmCVcKqYXg38HtakqgFBWV/jQCh9EWSOeCK5RDYJ2x7yHJ09yqa39V/C9Lm2iwjcM7E6nI9eM+sSq7plgjxr7fmMqs0zx8q1kniOhV0MqPSScYtpfrjKZQfgSLCTxv0TZi1yr8EUC8meAAjb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PywcTrMJ; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PywcTrMJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQgQ6rhs1L0Yqt6eAp/NOGhza6xM+in22dWGVkWJnL7BJqehLl1G74K1eDTqqboT5bW7QDZ2AYMsyoBHmBG1Ag+XYi+0GDXzyWMyGC7dZvHDByzEdSf721S8oDy+QHAsH3Ddw6AoOfEWjO3svknhUo9h5wGWja1GZprGo4E+fIJeccj3krJhYVIHM7GQ/WvjEAsmG1xfi6ngcUrJUgORumjQhW0kwybn9fOOFe0Y0JGLqd273SXZtQikcd5m3az1BbCSSlWEnI5m3IE4UqSibG1XfPhyipCgk44w9izlmY133UP1HlxPL9ypTZ0kExzTE+Qzg4Kdz/Art7XcGBmRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1T2Ora3ZpNyFRCqm/KIwXSziGR+7qq2hJ2XJDEzIVM=;
 b=s/yStD5F0pzmwjaa9cSIKPrrizx00Nxp2QZ06Hs0ch0VWrnDKeArRRSFLy1SKrQnGrpM6xzoe+GzCRcRuWHYFbtml0/A6TouRB7rAmLc08m9+zShZvMgUQUZTietTSSRxJKDUS6ZQk0ynSHpuD/YGGRViR9tK63oiKkyJImtikeZTASU6DA6GQD0DNvu8EfqFyP/3sKk9T50mmtGJPADt4ROtkuKEXIMeQqq1Ozw4wOiFxc5S4H7Flsp+f+Pls9jGBq9cbBhq0LpKIOoDeqPYcv6z8efnJfGOuMv/DRKlleWhGxEcxVQb6ePq6C0r6rdTWMvuJ7Bdm87FH4ykoK+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1T2Ora3ZpNyFRCqm/KIwXSziGR+7qq2hJ2XJDEzIVM=;
 b=PywcTrMJkYqDhxMPJzGKBFnp5eOAdP4zo2jpn6OYCbNpfq9sohYjIFCdafoxF+k6Bm03fih0r9Wcz1sGpl+KAgzNVPCw3r1rGwannMCuB8tyxYosVQj54eouXywBDTgzvXyu+ZqrnhGZpymq830uYIGVU38IuKkwogRefyQiTy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:05:16 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:05:16 +0000
Message-ID: <e207aca8-5953-4479-821a-8ac0a07c0466@amd.com>
Date: Wed, 25 Feb 2026 12:05:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cxl: export internal structs for external Type2
 drivers
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, dave.jiang@intel.com
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
 <20260223142633.2994082-3-alejandro.lucero-palau@amd.com>
 <aZ0R79N952TTsRcl@aschofie-mobl2.lan>
 <20d72717-23a2-4996-8abb-4d886147e3f4@amd.com>
 <aZ3iEEqQfp8sAkCY@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aZ3iEEqQfp8sAkCY@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0515.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::22) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: cc464f33-0c83-4ad2-1177-08de74662295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	Ajn5auIjRYXtvgyZkCu6lxTt67vIJy+n7Yxc0huyVs8fGybppIaYPYYxiYAc/g5hhOx4qHKxwyLJJrcK4Axo/N82fx/Li7s8Tzdwcb+AyvuCPWdsBChXp3ISzwF4+uYSpnv6V1fqwUyO4bIDicFMemdFtPIL8dYL7pnUOAUjfjQnii4JgWE5ivf1BkeKpkZBkXPFLJjud6e1vppEZUUEiIcJa6/ny7XbglGNmDNSBcKAGKVlbalY3JeUkvgJLF/NGnSsGxGFhBn6THqBo5Pqskd5BBnsENpY0eDasimSlY2SKAxGt26AEjJ/eUhBNyMFCC/l6Lzo/sUd3NxzGRpSXLZsJVL62ZSeO2w7FHjzp1uOEJ+u4hiA3s+T0+BQpfWC8ZJ51dtED8vGu0j5mA0DdP1FPWZ5L2+UDtrpi8EIxPWHHVQ5SN3P4SNyrIUPeZ1TISduyOKATDLivPkVtRuTiqMxxDs5JOZiH91qqa7SVnoGZXvyesVZ2Ty/o8QHkoKl0pPHS7bzp/sp28iR93a9FzLZpYguhO36dL9GFG5ErhKQO6/XVBuzKwY2JiZcY0HFx6ehLoYJKgzM3ibVcS9oPiJIlUP+BVq8yvGxGL5LOhQa5c/v7gEcoRORY112TVDyLjBZT3mZsK8kOIuMBc9wZQGhxWuFU9PWrKdYQ9b5u1rtClZ/MwZ0Qu3F4G+R3CzkrGFrb+9XvmnX2XVh+/yZ2frjDMkxsv7664bEY+m4IrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmtFVERNbGNyKzNIdG5GUVM3eEE1aHF2SUJGVXYvcnNCUHFROEcyejdHc0Zn?=
 =?utf-8?B?Zmc5dnR1UFZEcGpMb0FaTHV5TVp2enFPVFFnTzdXNURONmNuSnhyeUN1Rm5r?=
 =?utf-8?B?eGZYMG9YTnlrOWxLWWxTZlh4KzFRZDh5VCtIQmlPZUlxRHN1bkovaVU0WGkx?=
 =?utf-8?B?aUhTcm1NVzV6NkVqeXF4K3BRcjNEU0FLNGhIa0tJTVkwY25FZVZLU3pOZ1pr?=
 =?utf-8?B?TEg3QU9BWlBZRUpxSm4zdS9iVmZnT3FyRUJPVHpWOHJUWWs5b2xIdzV1WDRE?=
 =?utf-8?B?NFF1eFZOVlJWZzdscDhBTHpNU1gxYU9WQTJuOWxPMitkVFBIeEVpVUdIT3VK?=
 =?utf-8?B?RXdRbXBtUk5kWkJzYU5aQmlmYjRjVlBURGI3QW1xaVNaeXM3WWRsb0JKT3Jh?=
 =?utf-8?B?clR0azVRcm5UWjF4aUpESnEvN21nYmo2SVBVT2R6dlZWeGNTTStpMHgrbWpX?=
 =?utf-8?B?cDBlcmQ4WHJGc1pHQ3kySWhUbENXclp4ditmTnd6aCtXNGI1VGFqMDdadGJB?=
 =?utf-8?B?UWRxTzZ1K1BieU5DenhJTFMrS2xWc1BjUGFzenZrSGhOTWlOYmVLR1F0VUto?=
 =?utf-8?B?K2NuSm9XbGZVUU1GMzVnYm9HckltYklHd2QzNUI2WnVxbllmbUdQeHZDc2hO?=
 =?utf-8?B?ZHJUQnRUaDR6N1M3Y1JCT3dTayt2MEs4Y2E3a05oK1hnaGxPaXlheW02RFVu?=
 =?utf-8?B?QWlHSmpEWWN1MWcveGZGYUxhK2pTZnpvQ0RoalVvQWg2YnZCYU5GMTlPQjk4?=
 =?utf-8?B?TXNqMnZKeVJDOG94S0gxTElyRGlhd0c1bjQvcVpmVzZzYWREK2FlcnJyNDNI?=
 =?utf-8?B?NHZram9obnhWcHNHOUpjQTFWUFhTTjdyaGJyNjJCWHk5SUlRaWVJTlg0VmE1?=
 =?utf-8?B?VTd6NWNFa0s4eHQxMTZhdUc0N0FMYW9sMzYzZjdCL1RXYlBtVTl6MmFmK3g4?=
 =?utf-8?B?OVRNTHZPSU8wVjBMV1luZVIwRFlFR2VTNDJmV2JleTZxRXJZV1dIZkJwNkJm?=
 =?utf-8?B?akc1RXhBVTRGZnFVUll1ZGxEbjFXaEJvV0FUaGJVN2x5U1J5SXp3aWZwR2Vv?=
 =?utf-8?B?NW5IS0MzQ0FxZ1JiY2FyRFRHbWVPMWlWMEY2STU1UWNmUVFkZXJBUU96UGE5?=
 =?utf-8?B?aGpIVWNSZE15cXpIMndjTllYb1lRdWJMMW9rS0FEamxuYUV2VzAyMXVBRU9L?=
 =?utf-8?B?dVh3bkgrcVJ3aDhFSHpnYmVPMUJ0bE92SlJHbDZPMEFOZytibnRZd2hUUXNH?=
 =?utf-8?B?a2dCNzRoUmVsdHFvT0dySytLYmxRZk1WZzR4RVB5ampEWDhyM2libzF6VVV2?=
 =?utf-8?B?YWpMc2NZcFJKSkNlWGpxdVRZakRjdzA0MEFDcG1VcmY1RGEwVjFCMkFnazJU?=
 =?utf-8?B?MitxM1pmMTBNVi9DUXpjTytoOWhmMXFkeGdUbVBlOXB0bmNVMU9iZXh3Wmls?=
 =?utf-8?B?VjBWK0duQkR3NTVxNWNPU1NockhoK1lRbXJEWnIxN0d3QXBpS09hWDBUMDZW?=
 =?utf-8?B?Z2o0QTBJRG5QVmhKQzZpNzBlTmd6Z0tCSVh0a3N3Y3pEZTIwYUU2VHZQdGgz?=
 =?utf-8?B?WEhTbWx4YUQwTEU5QUJRaVhEbGVtaSs3cTQrb0VCVjd3bkdKMGw0YVVoSi9G?=
 =?utf-8?B?UFFJMGdmMmJERHFWRWUra3dmWnYvSmd2SVY0YlplWWpiWEpaL3FLZHJvcUNk?=
 =?utf-8?B?U2t5UzlBWUJTVXVWUHpTQzFQc3I1MGtCZGxuOGpPSWM4N0h1Y0NtUkt3QUNQ?=
 =?utf-8?B?WXY2MEJtZ1BwOU5IckRyY3h6QUFwc0g5aUUxYVhZa1ZkRVpVZlovNzYrWmVq?=
 =?utf-8?B?akhERFZ2L1M2M3lQWElvNmxuUjExMnJHTnBvajh5Wm5Ndlo0WTlxMEdCTits?=
 =?utf-8?B?cmRoWVQrRmI0elVwZnFKYWM5S0tDQkdhVTM0OGFINWUrS1JoVnRqVVF4Q0lz?=
 =?utf-8?B?bWo2SXovSndyQmlmem85YTdLR01ZM0k1ZzBMRTcwbHFzVnRXcDdzUml0Zy85?=
 =?utf-8?B?RDBkVWYzSUNvSlJwTmdYOUFtVWpYMWl4VVNTNjUvMlVCc2tPb1lvbE5WcnVi?=
 =?utf-8?B?TWQ4dXhhaDI1ZUNjcTMrNkh3Z3ZnSG5sSXh1NmJITzM2cDlzOUkyQjRiNmtu?=
 =?utf-8?B?SU8rayt6cVhTZy9uTFVKdzdRdFcyaktCQ1h1aTh5UDBxdWRVOERUT1dQUGo2?=
 =?utf-8?B?d2lTN0tDanl2bDNiRVdKMUFabngwSG0rOGpYMk9sRTJrY2NETXZoVStqa1V5?=
 =?utf-8?B?WU9yTktuNERtc25VN1dwMmM5dEd3bjdXZk9HSHNBUE9ZUVFQd3FBSDRPWXBy?=
 =?utf-8?B?KzNnOGVGZjYvSFVidWNXOXpGZkF5YVNuZ3hrMWduMGRXZnRKd0pRQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc464f33-0c83-4ad2-1177-08de74662295
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:05:15.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5Xi22y6q4JUF/6npYRBKROljjJeoWAV4qJRKmjYHgwqks2FQw7vI5n/lTemvDN5zQZOszcyQUwBNoLtds18aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965


On 2/24/26 17:38, Alison Schofield wrote:
> On Tue, Feb 24, 2026 at 04:38:03PM +0000, Alejandro Lucero Palau wrote:
>> On 2/24/26 02:50, Alison Schofield wrote:
>>> On Mon, Feb 23, 2026 at 02:26:32PM +0000, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> In preparation for type2 support, move structs and functions needed by
>>>> external type2 drivers. Differentiate between public and private data to
>>>> be preserved by type2 drivers.
>>> I would have enjoyed a mention in the commit log of what was needed.
>>> When I saw struct cxl_dpa_perf, struct cxl_dpa_partition,
>>> CXL_NR_PARTITIONS_MAX, enum cxl_partition_mode, it wasn't so clear
>>> why those were needed (as opposed to the cxl_dev_state defines)
>>
>> Well, this is what Type2 drivers support will end up needing once all the
>> functionality is added. So we know it because the type2 full patchset and
>> the idea here is to put all that in the new file visible to external
>> drivers. I know the standard is to see how the changes are used by a client,
>> but if I do so I will be adding all the type2 patchset ... So in this case,
>> the cxl core code will use another header which will be visible to non cxl
>> core, and the commit says it ... although maybe some rephrasing could help
>> like:
>>
>>
>> "In preparation for type2 support, move structs and functions needed by
>>
>> external type2 drivers. Differentiate between public and private data to
>>
>> be preserved by type2 drivers. Refer the new file by those cxl core files
>>
>> needing the moved definitions."
>>
>> Would this be better or too much twisted?
> Well, still doesn't describe what Type2 needs access to.
>
> How about "Type2 external drivers will need to access to "___________",
> so move those to a shared header file.


It makes sense. I will rephrase the commit using this template.

Thank you


>
> Where the blank may be as broad as "all cxl_dev_state related structures
> and definition", or maybe it's something more specific.
>
> Thanks,
> Alison
>>> I was a bit concerned that new cxl/cxl.h had dependencies, so tested
>>> that it compiled all be itself in a completely separate module.
>>>
>>> Tested-by: Alison Schofield <alison.schofield@intel.com>
>>
>> Thank you!
>>
