Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C73D810F
	for <linux-cxl@vger.kernel.org>; Thu, 21 May 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374025; cv=fail; b=iHn/eTii0Bjg/qvf7EvwXm2bbwilaIuioadsIhhSauRE+gXGyxwHETKOq3Rzuo0HRba59i1bPH6vMFt2+yFsP3WfrU06CFc7tD6H57I/QsMV3j6//Jac2rF7HBzdjAWyJew20IruQQRgZ+bi5qSc1SZeuBfL39K0W1k6mjiBjUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374025; c=relaxed/simple;
	bh=tA0CpSS7rf3keHSYMLWKk510SeR1ePQ689eIsp91Bz8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dbmhENJLJndunlCnOGR2hg3JzNIV2GNCdVwntz0vyOEe0hCtOZm5Pz127cCWmMZYPeqQol18Vx6UE6z1vbWAib9X8yud+PXhXZMlEZ+7xFFuNkiprVGFW9Dz18C9UbF3lmnYOW9I/pKDpPBK+8N8jTrxFc/H8BNn2ZvS+iJYxlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UZgE84KN; arc=fail smtp.client-ip=52.101.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UZgE84KN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdczXJjAzQFVSCU2VZdPiOrwkjK/w+S+4JvVcHaCBZc5fg2IVPq/DYfG+hv8dznMJrwXhXIVInpQ22L1TDZpdKy3ZYd0wBx+5/o5/k6DyPuEpAcA54kMyhshOePOMz1xsbHtDm7UfrF9HstkwgGkrmM1FUyNsKl5uoQq4oHWiLIWy/i+hjBiZBnBnMsfdBcs8io0A5emnXEnyLDaY5xXzFKg9IIL8CNRIhZDR20u/04ywV2kGKiRTI2bR+C/8B+fJb95mp0bB+GROTkop6wcTFKDKcmHWPK6s4RZaaIBeCqSezlNmYIn1/WHK0M9/dR4L6OvsXe7lT0wU7vcluvaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OW1yD5Wpuh/Pv52MOw4jIxP8KS3v+yJe/9h/MMDa0Q=;
 b=SKBhjKeYvD/KDM+MHXrCZ6/xDmRSx9XKVHHea9tTLAfDLocm85reiVxN9CdnGOpVHygaVmUYK6VeJoYFLWGtog52xFBqzDSDo057FxrI8YmLMiyPx3ZOLFk70729Hbu8Q/OaZiHEOqOciyCHWpBd1d9D0jg8UM+s+Zy407+mR40jz9ZMhzAzxBum/pa2ltFqlLZ17N1HO5WGXSnaa2d99ylMMxtAA+2JnQwltmnKQR4g93KM2Aw/hBUOkP2a3HJnmNmVe76KcRPVf094FW5Rj/j57YQ8ti2T2IzvDxxDBXbP3TI7MROzKXgyBDdOJDWR4cquxOAVUJfMEiore6eySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OW1yD5Wpuh/Pv52MOw4jIxP8KS3v+yJe/9h/MMDa0Q=;
 b=UZgE84KN8F/CVsWJz+KjYj19ZSVR53P+qYGnu/FfUxhDpjD8lbqYI+twEFEHGqU3P5mflDZATfNZs6nzpUdMgZmRZLvXsl4u92T2FiwDz2DDP97h1+4FNQJ/0uo4lc8ADMWd9ux9reD/Wp15auY4fvyjf1ebV1Zfw3oMi+kU6so=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA4PR12MB9809.namprd12.prod.outlook.com (2603:10b6:208:54f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:33:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.21.0025.023; Thu, 21 May 2026
 14:33:41 +0000
Message-ID: <4b3969ac-6d8a-48fe-98e1-2bf72fdf450c@amd.com>
Date: Thu, 21 May 2026 15:33:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cxl/memdev: Pin parents for entire memdev lifetime
Content-Language: en-US
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, alejandro.lucero-palau@amd.com, jic23@kernel.org
References: <20260519210158.1499795-1-djbw@kernel.org>
 <20260519210158.1499795-4-djbw@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260519210158.1499795-4-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA4PR12MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: dc52bccb-5185-4bb3-7bbd-08deb745f405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|18002099003|56012099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	vVDNe0NuQ4uHQr+f4vrJawlZG3v/gXYwTZ4QkGeioedI+J2znhmh4/ZDcThSudKvcZnsls1Blcx+jKd8WNif/ehd4jKJJrCtaNg+ejB9QSQw0zhq0fGNTnEmWS7l60nP4uVL2q6cum1d5jIew90ZtFjWIa6GvRG1DiDiTHsEyIavJ6qyusD9BUi8dMNNO/d2N5VqjGC/TEP8Z0DHVvlORhke30a8n+tUlWhi/bRDRR+2sKx0y/J/ZxDDWMJJbOmDaCoG71iLmu/hsB669RGf4U7XRgKlhvL5ap5M6nm6o5ojyb5B8tX5qwtu72p09MsCWSQ4G3HwKvJFXijnwvw8SWe++txjW5fvJ+7cgtsrMJHTnhOl+0L/pr0KtE6KsNMnEqc0xbecj1z46GfeWH7/L3cg2QBkS7dS0FsOYgg3+iqBH/0pYeG75Sn9OkmILZsCNjJwcTqf7kTtxnAedgo3LZa44p/xi0C6YcnrJ2XBjDpZgWgvTra65itM3IL+e7M+R50ComziXZ6UPjihTT3Yk1r0WTP5gXpQzN+o9ntWybeCLlvIljCIKW0ln3eIfMxFB4FX2O02jPmR0vl6yrDuIowuNpMaQjka6/VGi3MI2c1MAd16hB/QsObBggCdVI6aV9L6GR2ikd6vAxQBwyA8cR0zrjz0b0TTmr+903ZviKbv8HPGW29AdHx7QsOfgzeA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(18002099003)(56012099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUdBQksvdCtPM2kvRnhJZ1E1TnNaUmNzc3l6WVdoOFpGOG43ajBXMUFseG1Q?=
 =?utf-8?B?QlpJQnNDaitaOTEreDVIcUtiVzJML1pOYzJsV0hBRnJiMUlNZEo1ZW13VTZs?=
 =?utf-8?B?UVE5cCtGYUY2bkJvN0JVcUZkMjBjMzNISjBHSVBRMjVxaFhTdHV6alZJd244?=
 =?utf-8?B?OXBTL21NOFZjclJKcTl0V2ZaY1YvYld2RHVORWlkdmRtZTVsNCtUMWh6S3ZD?=
 =?utf-8?B?eHExdmRKUGlqUlhrZ05GVENXOUZ3Sm42N1JPVXNZYkJBd0t0TGpxK1RramNt?=
 =?utf-8?B?cU1sWWl2S3pyd0dnWHJhOW9XUndIVEwxdFZ0dDQySVhDRTFwN2dnbjdZMGhh?=
 =?utf-8?B?QTBqRHpRcjMyczRtYjFYeWxRUHg4N3BaOThlYjRHaVVjV2JlTTJIekcvTWc0?=
 =?utf-8?B?TGo4dG1oWVZjV2QwTWxhU0RsUnJIOTM3TEMrSHh0VUtoKzhtVW04UUw0M2Fm?=
 =?utf-8?B?NE03RDVRUGlaZ1FPK2xHYjhUNDZydW9tR1l4OEJYSkJFZThZVGFPQk01ak9k?=
 =?utf-8?B?SmxGR3ZzbDg1VXlNdTQxdkk2UjdVaEN0eDh2bnQ5QTVGNjYrVy9RRDI3b2pZ?=
 =?utf-8?B?Q09uWWRzazRLTFJVU1lzOFBNUFJUSjlKZzRQdGRGNlppMjJXRUZzVEdNOUpv?=
 =?utf-8?B?TjQ0OTVSamxncjZsemRPZDV0dVpFZ3gwUXhpZlY4Rm5oVk91bko4R1YvYkgz?=
 =?utf-8?B?akhsVEpzREUzNWFKZThUL0t5QWx1UjhJS3RjN3dwZ1gra05BQmkwVWFNTy93?=
 =?utf-8?B?Y2Z4bndTSGliRW03MWZOdU5CQmdFUWtkRUVLZXFDbnRyZlpGMm5CVEk4MVov?=
 =?utf-8?B?dWxLT1gzL2Q0V3VEdFhxcVliNFM1U3lTY0kvd25kSUN1aGpobWFvdGtNUlBE?=
 =?utf-8?B?ZHROWWc5ZFJhaEdHdS9uaEd2b2Z4cEdLR0xXdm1WR0FIc01LMWE3Nk52dk83?=
 =?utf-8?B?THRYQjZQZ05UNSt2S0lMNGw1UXJtem9zczRxR1JvU2FOM09iTG5hTGJFUGlj?=
 =?utf-8?B?b2dTcUJiQ2d1N0FwSFc2OU13ZGcrdlFZM0hweGlLa0NzdUVoNEs4RG02b2ZM?=
 =?utf-8?B?MGtOTG1VSmdtaHlPOHJkL01lWUdmOW85NHhQNjlQTDhHTHRSZ1RiSW1FVDR4?=
 =?utf-8?B?dW5LUU5TMHRRakxsTlpxUTNtVVpWdzF3a3g1dGVrWFQ1d3ZXL2J0cXBCQU5O?=
 =?utf-8?B?MlJtWnZnU3FBUmxXM0VmNGIzV2ZqTXRheHNFRlpFbGo4TWVrbVY3c05Pdlgv?=
 =?utf-8?B?ZXFGVUpLRS9YdkN0L1FBWTFuMDZIcTl6NUw1V3pZZ2VWaXM2R3dEZVdHZjhi?=
 =?utf-8?B?ZmxtUWxlMVByTWlDaVZ1enBEaG1ETVNmRVBtaXJYRnM4WFN6QmJWc1owM0x6?=
 =?utf-8?B?NFlaR2dsMFZzL3JxbitJaXpjbEpNL2hjQzB2ZjVYSmFFY3hIMFRhTVY0bkxI?=
 =?utf-8?B?WWxlWmZpWGxUMVRQc0ZUWVlyQndxbU9RbUdKa2NkSXorRSs4V0QrR01jdkdn?=
 =?utf-8?B?UHVpZEluWlI0MlNub3dmRXVzajFUd2JWVTZlSjFjVEFBaEFQZHJhRnBsSU84?=
 =?utf-8?B?OG9VbHVkZ3hIcWZtTDhsVm41d1VkUVpiOFQ1NnFuZFFNb3VGek5TTFk5NjZh?=
 =?utf-8?B?Z2laL3FPZURnQitmNFZlUjhTRHVSZWRvdDRxSlpIOThhb2hEOSs4RU4vZUJj?=
 =?utf-8?B?U01ydmt5SXJuWkJwd2J3TE8zVENZZlh5bVEzbXRwRnJZeUk5UzlGbEVrWml0?=
 =?utf-8?B?elZGT0FCVDNnY0E2SzZzYmpqS2JQWkNDb0FXYmVrU00wOTA2YUpGR1ltc0lB?=
 =?utf-8?B?VVEvSzY1UDVad1JkMC9NY2F5ZUs5NWpmT0tTRTJBZFYxSUg3SlVKNXlkbTV6?=
 =?utf-8?B?TVQ0VlVRUmRvcHp6OHRjcU5XTWdMVjZqeFRWVHNvZzlEQSs3SUM5RjAwWjAv?=
 =?utf-8?B?OG1JSWJlNXV1ei9Qd0V4NFlqQWtiWGcvcmxCV0pENmhHVnRIQVM2S0paWDg4?=
 =?utf-8?B?all6a0VobFliU1ViTkxOY0JHR1R4Q0crQktRSVRBTUQ3L3pzUlVXL2FkWWtX?=
 =?utf-8?B?THZYSzhPTVBvVkp3U2tTam9ERWtOWjA0Um85ZUtyeUsycThUcTJWTlpDaS84?=
 =?utf-8?B?T3hNTFpmUGkvR1ZNeFZXd2R4dk1lOVRyMEZYNm82bkNzZCtUbFpWOUNtR21K?=
 =?utf-8?B?NTFnZW5QVlZ0bVIwYjZDMTdsdDYxcGxwcU5DOHNHWTV4bm82Y2E2MTZRR0xJ?=
 =?utf-8?B?OXA3bFpTMEU3cU5RNzllR0xYUFNteWx3T20xMm9KR3RCWWl3bWFGZkV6NHJX?=
 =?utf-8?B?bHk2VDVhdHMwaHd4ak8xRS8rMGFHQ2NJcGNVQkdVOUdhV256UXd0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc52bccb-5185-4bb3-7bbd-08deb745f405
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:33:41.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9EL24bXm0a285zrNyc6LXIjwzOxB0mBLV2hSoTcuPxb+RsmPZM96QeI6ATXWkcSwFsIhU4xpuuR1K2eJkQncA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9809


On 5/19/26 22:01, Dan Williams wrote:
> In order to be able to manage the driver that uses a memdev attach
> mechanism the parent needs to stick around for the
> device_release_driver(cxlmd->dev.parent) event.
>
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Dan Williams <djbw@kernel.org>


Reviewed-by: Alejandro Lucero <alucerop@amd.com>

Tested-by: ALejandro Lucero <alucerop@amd.com>



> ---
>   drivers/cxl/core/memdev.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 80e65690eb77..91c99eeea92c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -25,9 +25,11 @@ static DEFINE_IDA(cxl_memdev_ida);
>   static void cxl_memdev_release(struct device *dev)
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct device *parent = dev->parent;
>   
>   	ida_free(&cxl_memdev_ida, cxlmd->id);
>   	kfree(cxlmd);
> +	put_device(parent);
>   }
>   
>   static char *cxl_memdev_devnode(const struct device *dev, umode_t *mode, kuid_t *uid,
> @@ -707,7 +709,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>   	dev = &cxlmd->dev;
>   	device_initialize(dev);
>   	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
> -	dev->parent = cxlds->dev;
> +	dev->parent = get_device(cxlds->dev);
>   	dev->bus = &cxl_bus_type;
>   	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>   	dev->type = &cxl_memdev_type;
