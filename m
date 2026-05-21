Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E23D810F
	for <linux-cxl@vger.kernel.org>; Thu, 21 May 2026 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374005; cv=fail; b=ltHZJJB53HlgyF/wx50Swhz8T3X/BUzrY2GpLwcV9XOdHonv1OtKLVdqu0A6jgwEgzkbKOMbWvgDC863LQaTpiuiZ6KL9/X5OEkQINwFe4Z5rGKHfORnDhijoBJN3nEObawy754buYnoTIWcC3Ggat5GjA7k2M3l86iQA58g6N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374005; c=relaxed/simple;
	bh=3asT4e4GATadRv1+6fAWrL8KfWTgpLZsPtEwVQBKniI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rtBh02M6s0Pg3yi6mpnPCJcbwR10sHGSLmFRpE92ISEAi0yKhe6v5S3qrgUm59IxLp049cbUviOyF6Gqn0lbvo7sl2qFUfPDI0Rk9VflvC5y7WY4jbNADojP+tXaC9oZCXAtVglSqc76muX+6cGngW6DDguU8KSTXGMVB3caJoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GNM5bLw9; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GNM5bLw9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npIyDLiTHpwFLuB1NWZtbKMceSDXOSazDcjcQdlJ4+7bNiA0UauaraI4IFJF00R/bIt1+l+tuTa2IjfCn++w7nzUHb+KpdSbTzwAv9hc9qIkAuq0Sl9bTcwImOatnlZgEHZgpPSXjuVgi+9iOGFjEWVAv114JgdCkWa2eUU2D2vXC7NuqUbjj1WHmxBxJEmVYyMgvuK/lC2QDjHDjHXlH0DckYGD2iHeXs7XHIg6NBobfk/D5TVG4vxdl+ZelB4EmEO8IK7n2F2YhYgVYc2WtZFm8JN2eGKJMKxQtYS2aBFnjmo0OYjpNW8HPWhVOUV/eAGhRVhXI1VJ2vMzD4LF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYnkYHMw8lppWGEUpfMVlertup6f/iZU1AsIjTsWzhY=;
 b=fvNchLfvKzDGC+aeGgRzlOJ0Nm2WFY3BffAmihzXk3yFYBp2YhNcndQCLjcdkiqnfnl3NCZKUIXxNZcreT1l26QJZ73B1qUXuyp4jUrQmqvZzJM/0aAJuLUU7ObUDW3zFey91dvm/kRICF2pKzEBLth8r95wLBywl/DtZ9c8Vw+VGXjTOhbulNkqItnpNaJkVXBoKsyvUsXAhAAagIf4E7hYh1ChLs+EXDDvespLiYFOye+3JHHJuTz14NmK7DLTChv4IFJQv8uSFfU0wJzTkFOt8a+eI07bOj1WfiT8oQgvb2i8M7G+2COvgHgShWGq6T/rjVpxj0Fi8yDqFhxxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYnkYHMw8lppWGEUpfMVlertup6f/iZU1AsIjTsWzhY=;
 b=GNM5bLw9p5XGLqyoyMmKtYqhn1brAeLnsdDTBKOeGHJPU1xUO3InD87xE9MHD3msJ9M7snZMoC86xS+G2Y62vMENITM9a2KBc1PqCQXwAq0lk8oYwr0vYpTSosDdzOjRIpyKVDUbE0Y3r4/JwMiwudJPohPuKbGJjEcVNRDgAN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA4PR12MB9809.namprd12.prod.outlook.com (2603:10b6:208:54f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:33:21 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.21.0025.023; Thu, 21 May 2026
 14:33:20 +0000
Message-ID: <758d40ad-56e9-41aa-aaa1-6bdf8531ce35@amd.com>
Date: Thu, 21 May 2026 15:33:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cxl/region: Resolve region deletion races
Content-Language: en-US
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, alejandro.lucero-palau@amd.com, jic23@kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>
References: <20260519210158.1499795-1-djbw@kernel.org>
 <20260519210158.1499795-3-djbw@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260519210158.1499795-3-djbw@kernel.org>
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
X-MS-Office365-Filtering-Correlation-Id: e1dd0b9e-1fd0-4034-7317-08deb745e7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|18002099003|56012099003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zd1/JRrOvDrgd56AI7O2PS1SdVY2vOYcl3Glkx2bQgz4vRzTqKDsCJEkbEH7Xy8AFPNDWhksMculKpzuYfT59nCs3xwkoQiVtyb3yCYSEq5d699clw0U5vIL72HN5r8tcU+IMQDvvz11x6Kgh+3/ICL6zieOrX6VYlfw1y0vEVpvAEfipi1dwHgycae/xS2dkGdqyhrJ/B41GgTf43m6FW+zs4CBOz0bLSmocf1jShF2egosSuYXE5nzw6Dx+W5lVUrjR9pZmA3SZrL9DKbZOc15WwMnB4NNuLdzIgd3zTKFmpsuWj38eo88iS76ducUGJa++QCyGp3kfbQY5mmmTGOK8hwAHYM4Npvwihih7CYibFSZNHkMDIhbjxWsW6a78sFDF3o3LdKfTqnRA9CznwD8R9nJZKdSZHK7vBgIzdT/o1bdeEu7cOFR0xJGSBzci+S2F3tjiZGqJffPxeXFYzWy3OI/ZhJqTX16Wei7UnUqcpKe9/2CJ7TckN5WEWgdWQx0kT6fyVSeWbEAZwJZpL2+r668Y/L7bnaQ1xr6fjUVhMqE+1pcfQ3cXPo0HtMHELT7X4r/Jo3w9QVM1wXqY9GFmQBGD1zBkEqvFUpZ/a3ZlGvLMuPUnYQ5efVTiuxfI3uq/LTLO7aMRz76iApgp2HcIHL+iAJlpsRh+jkTdv7U72n2SalW3siu5PuyO+4W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(18002099003)(56012099003)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejhTU0dDNG1BeWtvVW1NKzI1Qk82akVuY3RheFR4WjNDd1RQOCt2aUNxWTJ4?=
 =?utf-8?B?OExzbnI0ZHVIZmF3YVR6d3Rybi82dFZkbGl4akhuckI0MVJ3NFFhcnlvTTN6?=
 =?utf-8?B?R3RrdmkwcmxVTnVFYXhDYkFWVFhSN2xKR29SbnRFa3VjaVovdmQrcVdRQytJ?=
 =?utf-8?B?UUluZmpoamVIdUNseWVBMDFKZ0p5a3JrZVcyYnZYSkh3RU9VUEFhS0o2dms3?=
 =?utf-8?B?cHczRTRWQUJidFBsUTlEQmxkUG5tc1IzUkpFSFQ0M0dMOUd2cFptaWJMWElH?=
 =?utf-8?B?V1dyc3k4TzZ3YXNHZ1pyUjZDWk5BVkxybjNJSWdLUitTWCtIWVZPVTZvQWpI?=
 =?utf-8?B?azRhUUVWWit1REJ3L2NRS2g2Y3JWUDJiODVxMUNaVUpjcHI5RHBrQjVVQXZ6?=
 =?utf-8?B?dXNRZnZGVGpEazBvN0QvZkVlRFZ1UWpwQndOT2VjU0xOTDZReFRnUHR6N0sw?=
 =?utf-8?B?MTh6azZtNE9MMXZvdU5rMi9qY1dUT0d3TGRmL3E2ZVRmaHpKRExVeUNxQTl5?=
 =?utf-8?B?VDVQNXhraE8wMHN6Mm9hUVdKNlpUVVVlVFdOUlgrUEVMdHBjaE00UEJuOTd1?=
 =?utf-8?B?TmJpODZqcVpzcmE1ZnBZN2NwWkNTaGVGQU45V2VzaWFIZ3VMWkRkRmFwbUFZ?=
 =?utf-8?B?V3pIa0N0Mm8vOFlsVDFFeXVabXZQM21mSmJidmdyR2Z3dG5zQXY0d29qSEov?=
 =?utf-8?B?LzhoQlV5S25WWVNIQnUwOTU0ZWVjbFZXYndkVldZUW8xa0xwcWJBNTdYUEVv?=
 =?utf-8?B?aU5yRDlENmo3YituNmlHcjFFZVcwUThrckh5Y0lIRHJhTVlwdDJrTkN5ZXVu?=
 =?utf-8?B?MDhlNFp3ZHZlZDBXWlIrdjhVMWk3MCtQb0tjZEQ5cGg2Z25uTlUzNDc4VXNB?=
 =?utf-8?B?bXAyVG5XaVZ5SkNiQWcwMFdlalZ6VzR4ajVaZkNXem1ZQWZwUEJrdUcrbmdL?=
 =?utf-8?B?T2tIRjdyUHZZSnhHNytYUE1pNCtLUThLdU5ka1hPd3p0TlJDSHcvN1B3U0N5?=
 =?utf-8?B?RlBOZkYrelpmR2xzZmU5T2NKL2l2azh3VjQ0L2dPNDNYVmJCL25EdGVwNTYz?=
 =?utf-8?B?RXFtQlU5c1MxQy9GRXM0SXBjVEVZWW5FUlc5VEVNTW4yakxVMXFQcHViUlFr?=
 =?utf-8?B?RU5CMkdBRjR1OWVBb2hFZFArTFE0eFp3OHdmUDdyeWFjSUd1ZXdOaGxoazB6?=
 =?utf-8?B?SEhybW9GdUZTYUZaaVFzTi9IY3FWYTZHRlhhR2RqYWVaMkZYcTBqNDhwQWVX?=
 =?utf-8?B?Z1QzSy8zTm5LdUJUR2lGZHZHTWV1Ui9zb3h3SjFJb0R1RGg2TUZJQm9BeldG?=
 =?utf-8?B?MTl4dy96ZlZYaFI0b3dqaWhWVEgrVStMaFlRRWVtSm9UMm0ycytCVlVCRm40?=
 =?utf-8?B?NHZGUllkUy8wbkRxRWRJMm93UzFKQVJySG5WTzVwd3IvRXQ4cGhHMHZTaFY5?=
 =?utf-8?B?c1NWUmpCVUNwcjNqSGhXM0Z0TzlrcjQwQlh4Vkl2U0ZZYmtuT1NselplRWt1?=
 =?utf-8?B?Y2xib2hFQUZ5bUFYWks5LzJBRXBaY0ovUjVLS3dWM1BwSU9acjJIQ0RCekcy?=
 =?utf-8?B?R2dQVnc5OS92TDBBbGRBUjZtQkRrTllHYTJSQ3VoUjIvdnV6OExIRjhxNVVz?=
 =?utf-8?B?MmEyaGxsclFMcytSbCs4Rm9jbk0xWEI5ekJSM1luUDRlN0JiUXBadUlvN3Fs?=
 =?utf-8?B?dFUzMHhvc3dLUVRNSTRPR3lVUlhtZG5TSlJPK3VHcE9ObkJOYU9KSUZvWTZr?=
 =?utf-8?B?dldUVnNQN2libE1lVmVaTnl6a0loOTRqVDlUTUovaEloY3dhaTRqYmJUbVRF?=
 =?utf-8?B?eFJPR2tuSmU1VWNsOXptMmhpQnZIZEhZT2RFSnJ2RkFMSG40cVR3MFcvRml2?=
 =?utf-8?B?c3N0cTdFcmlDSC9sMkExQWU1VDRKWlI1bDg3eWlCeEgzVmVpbWt0VXZ4WkdZ?=
 =?utf-8?B?SG5xZDZPTWhpZjZJU08yejlodjZGKzNDZVdxaWc3c3hYSDVoVmt0ZThlU2ZM?=
 =?utf-8?B?WnVUNWZsS1F2djloSWYvTUxBaTU3NG95UHRXdjJCQWNHZDlra2ZMeEJhRS9G?=
 =?utf-8?B?WVg2NTJmNllQS0RHdWFNTnh4WnlCWmYxSXR4NW42UlJCK0NzWUt6TmhIWnZ3?=
 =?utf-8?B?NEJ1NHMrVGZvUHZ5eFZxUXVxSlBLbkI1U2R3c0dOWFY2ZTFHbytNenhoZjhQ?=
 =?utf-8?B?TUk0T0FXeDd2V0NwbUxvYldxSlZ2ci9pT0kyMUNDcmxCTlk0bEJyTURBVlFy?=
 =?utf-8?B?MFE3UjFMeXdPb0dEM0ZIbU5NdFNmZzVOT3ladlRXejREYWk4NVJHL0VMNzZW?=
 =?utf-8?B?UnVSVkdONm56akZVQTBxSXAvSFovbFByNGRDZUZ2QTNnN1BPeTRlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dd0b9e-1fd0-4034-7317-08deb745e7a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:33:20.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYGbiyPhb9rlLt3lK69TIakLUOg+ZwirCvjBB+3li2y3y6AqzcBeEapxYqPjKhwb6Z8mj5kzp419KxAGfNok0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9809


On 5/19/26 22:01, Dan Williams wrote:
> Sungwoo noticed that the sysfs trigger to delete a region may try to delete
> a region multiple times. It also has no exclusion relative to the kernel
> releasing the region via CXL root device teardown.
>
> Instead of installing new cxl root devres actions per region, use the
> existing root decoder unregistration event to remove all remaining regions.
> An xarray of regions replaces a devres list of regions.
>
> This handles 3 separate issues with the old approach:
>
> 1/ sysfs users racing to delete the same region: no longer possible now
>     that the regions_lock is held over the lookup and deletion.
>
> 2/ multiple actions triggering deletion of the same region: solved by
>     erasing regions while holding @regions_lock, and only proceeding on
>     successful erasure.
>
> 3/ userspace racing devres_release_all() to trigger the devres not found
>     warning: solved by sysfs unregistration not requiring a release action
>
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Reported-by: Sungwoo Kim <iam@sung-woo.kim>
> Closes: http://lore.kernel.org/20260427032010.916681-2-iam@sung-woo.kim
> Signed-off-by: Dan Williams <djbw@kernel.org>


Reviewed-by: Alejandro Lucero <alucerop@amd.com>

Tested-by: ALejandro Lucero <alucerop@amd.com>



> ---
>   drivers/cxl/core/core.h   |  2 ++
>   drivers/cxl/cxl.h         |  4 +++
>   drivers/cxl/core/port.c   |  5 ++++
>   drivers/cxl/core/region.c | 60 +++++++++++++++++++++------------------
>   4 files changed, 44 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 82ca3a476708..07555ae63859 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -52,6 +52,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>   		   u64 dpa);
>   int devm_cxl_add_dax_region(struct cxl_region *cxlr);
>   int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
> +void kill_regions(struct cxl_root_decoder *cxlrd);
>   
>   #else
>   static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
> @@ -81,6 +82,7 @@ static inline int cxl_region_init(void)
>   static inline void cxl_region_exit(void)
>   {
>   }
> +static inline void kill_regions(struct cxl_root_decoder *cxlrd) { };
>   #define CXL_REGION_ATTR(x) NULL
>   #define CXL_REGION_TYPE(x) NULL
>   #define SET_CXL_REGION_ATTR(x)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3900a0778571..f43abd1903ce 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -360,6 +360,8 @@ struct cxl_rd_ops {
>    * @region_id: region id for next region provisioning event
>    * @platform_data: platform specific configuration data
>    * @regions_lock: sync region discovery, construction, and deletion
> + * @regions: regions to remove at root decoder destruct time
> + * @dead: root decoder dead to region creation
>    * @qos_class: QoS performance class cookie
>    * @ops: CXL root decoder operations
>    * @cxlsd: base cxl switch decoder
> @@ -370,6 +372,8 @@ struct cxl_root_decoder {
>   	atomic_t region_id;
>   	void *platform_data;
>   	struct mutex regions_lock;
> +	struct xarray regions;
> +	bool dead;
>   	int qos_class;
>   	struct cxl_rd_ops ops;
>   	struct cxl_switch_decoder cxlsd;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6e7a70d51cfe..1215ee4f4035 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -458,6 +458,8 @@ static void cxl_root_decoder_release(struct device *dev)
>   
>   	if (atomic_read(&cxlrd->region_id) >= 0)
>   		memregion_free(atomic_read(&cxlrd->region_id));
> +	mutex_destroy(&cxlrd->regions_lock);
> +	xa_destroy(&cxlrd->regions);
>   	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
>   	kfree(cxlrd);
>   }
> @@ -2017,6 +2019,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>   	}
>   
>   	mutex_init(&cxlrd->regions_lock);
> +	xa_init(&cxlrd->regions);
>   
>   	cxld = &cxlsd->cxld;
>   	cxld->dev.type = &cxl_decoder_root_type;
> @@ -2192,6 +2195,8 @@ static void cxld_unregister(void *dev)
>   	if (is_endpoint_decoder(dev))
>   		cxl_decoder_detach(NULL, to_cxl_endpoint_decoder(dev), -1,
>   				   DETACH_INVALIDATE);
> +	if (is_root_decoder(dev))
> +		kill_regions(to_cxl_root_decoder(dev));
>   
>   	device_unregister(dev);
>   }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b5601e89e302..faf9785c0509 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2537,12 +2537,13 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>   	return container_of(dev, struct cxl_region, dev);
>   }
>   
> -static void unregister_region(void *_cxlr)
> +static void unregister_region(struct cxl_region *cxlr)
>   {
> -	struct cxl_region *cxlr = _cxlr;
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>   	struct cxl_region_params *p = &cxlr->params;
>   	int i;
>   
> +	xa_erase(&cxlrd->regions, cxlr->id);
>   	device_del(&cxlr->dev);
>   
>   	/*
> @@ -2673,6 +2674,19 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>   	return NOTIFY_STOP;
>   }
>   
> +/* unwind all remaining regions */
> +void kill_regions(struct cxl_root_decoder *cxlrd)
> +{
> +	unsigned long index;
> +	struct cxl_region *cxlr;
> +
> +	guard(mutex)(&cxlrd->regions_lock);
> +	/* no more region creation */
> +	cxlrd->dead = true;
> +	xa_for_each(&cxlrd->regions, index, cxlr)
> +		unregister_region(cxlr);
> +}
> +
>   /**
>    * devm_cxl_add_region - Adds a region to a decoder
>    * @cxlrd: root decoder
> @@ -2711,14 +2725,15 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>   	if (rc)
>   		goto err;
>   
> -	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
> -	if (rc)
> +	rc = xa_insert(&cxlrd->regions, cxlr->id, cxlr, GFP_KERNEL);
> +	if (rc) {
> +		unregister_region(cxlr);
>   		return ERR_PTR(rc);
> +	}
>   
>   	dev_dbg(port->uport_dev, "%s: created %s\n",
>   		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
>   	return cxlr;
> -
>   err:
>   	put_device(dev);
>   	return ERR_PTR(rc);
> @@ -2747,6 +2762,9 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>   {
>   	int rc;
>   
> +	if (cxlrd->dead)
> +		return ERR_PTR(-ENXIO);
> +
>   	switch (mode) {
>   	case CXL_PARTMODE_RAM:
>   	case CXL_PARTMODE_PMEM:
> @@ -2822,38 +2840,27 @@ static ssize_t region_show(struct device *dev, struct device_attribute *attr,
>   }
>   DEVICE_ATTR_RO(region);
>   
> -static struct cxl_region *
> -cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
> -{
> -	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct device *region_dev;
> -
> -	region_dev = device_find_child_by_name(&cxld->dev, name);
> -	if (!region_dev)
> -		return ERR_PTR(-ENODEV);
> -
> -	return to_cxl_region(region_dev);
> -}
> -
>   static ssize_t delete_region_store(struct device *dev,
>   				   struct device_attribute *attr,
>   				   const char *buf, size_t len)
>   {
>   	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> -	struct cxl_port *port = to_cxl_port(dev->parent);
>   	struct cxl_region *cxlr;
> -	int rc;
> +	int rc, id;
>   
>   	ACQUIRE(mutex_intr, regions_lock)(&cxlrd->regions_lock);
>   	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
>   		return rc;
>   
> -	cxlr = cxl_find_region_by_name(cxlrd, buf);
> -	if (IS_ERR(cxlr))
> -		return PTR_ERR(cxlr);
> +	rc = sscanf(buf, "region%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
>   
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> -	put_device(&cxlr->dev);
> +	cxlr = xa_load(&cxlrd->regions, id);
> +	if (!cxlr || !sysfs_streq(buf, dev_name(&cxlr->dev)))
> +		return -ENODEV;
> +
> +	unregister_region(cxlr);
>   
>   	return len;
>   }
> @@ -3718,7 +3725,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   {
>   	struct cxl_endpoint_decoder *cxled = ctx->cxled;
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	int rc, part = READ_ONCE(cxled->part);
>   	struct cxl_region *cxlr;
> @@ -3739,7 +3745,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   
>   	rc = __construct_region(cxlr, ctx);
>   	if (rc) {
> -		devm_release_action(port->uport_dev, unregister_region, cxlr);
> +		unregister_region(cxlr);
>   		return ERR_PTR(rc);
>   	}
>   
