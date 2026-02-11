Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F8324B34;
	Wed, 11 Feb 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770848335; cv=fail; b=TYJ5h1+3/tLrOPv1Z4HwVIUS/u3/AWoqj0+A/RUZxWmE0dOYKMaL7ZwLI8nzunz+CyaXUSnDxtRoAyw/NucRej+9WKUEoIg9XehViGJXiW5tkFQREtb5tziSanTbCj0wemi6o3t9/CccW2N/IeA4CMwrQwIuExc9Qm7COrT9M14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770848335; c=relaxed/simple;
	bh=lkr6JMqyHSgn5j9xceBcO8s65cslwNTppWMy9PRE9js=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=jjejCvcZkdyiOWpgxYzOombUDYeIQSFG99J5FU5z3iMNdXCUyKfFqYNTQLhZGvJplPlq0kTz/x/PEV2WDyg7/JsROyrNs4NUBmwf0pQ6cD0l3hUjhiwBKPI4WyDixWRCWACSQJh1HfJomfjX6SgQygkfSPcr3lYJZMBiMowdcG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=upa43FXx; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="upa43FXx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQL2/oZeg3HxpemppptXfi/Nc6c5+lt0Pm/r3TgCEEjFWD2+WWLfqZbu/oMgqz3W/xxBFeoE//0pi3C3bTWEz2y80RGPulGjhN8YD+zup0MuaVkSig7fih2hZSYE3nYEYLL6VS+558UaWeKXleAhkUIKKZJlmnoQ5JfGxCR5IpYAJM2vRPDbSzaSVy+M7bbzlhicIzlz9oAvNoLHHm6U4AybzOaaqBg8Aub5C1PW1jpACWIthaNcllSpQp5pqj2WjaeL5iB2lE9VJ3nSJM9vtH7b2sToF5LamzpSkeOJ3wXj/t+qQ1NislyAcx6GjfuI4LbP1bLi85ZhGohUvCRxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygQ8QyM5Sk+6SaQfAa+bZC+ruPXAgwaotlv1LECVyNc=;
 b=OSxRAGxVpuQJnQYwIt+tx6Tjfv6qyiD82BaRDc5k8KakdagMWoWgYVeKdAJf+d/3Nbjub87zOaMCJG4Fxy8F9aROyOG4hfeQ6mnz9GgHEXUNdsxxymoJ1bw/uGdyw6j2GDY6qAud+Zo19c1jd0hnU1TthYof6D64VUzfxNIr7+Zo1oEY38JpSlO6OByJemS9gfBiq3RNdgVsSUcZT3jpcR6eUr3josVYAup4v8g8MG919/VQ/xIZBj6Wc8Q1USRsvgk43OS4sLShJu37vAqwqk2HuKhjzdLeRTpENrbxsXsW5ryyThv2VVBZvEFPRGXHu3seb7oX4fo+YMZaHwP8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygQ8QyM5Sk+6SaQfAa+bZC+ruPXAgwaotlv1LECVyNc=;
 b=upa43FXxpL3902jeH8kTSrrSvbWSIVfuRtmgKlxSq/hQ+Lbik8Ss330L5zP7oe9huGZQqDyzsmz4aOAROujYmqf1Ci2CYYrSEO+l4DMjbaoAXu569K73Mg9+i9wJE+86IpVPy0ukIHq/K51BTq7zurqsAASl7keRKkuuD7FW2t0=
Received: from SJ0PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:33f::6)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:18:48 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::81) by SJ0PR05CA0031.outlook.office365.com
 (2603:10b6:a03:33f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.7 via Frontend Transport; Wed,
 11 Feb 2026 22:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:18:48 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:18:46 -0600
Message-ID: <35db57ae-64cd-40ed-8353-7d3b64069471@amd.com>
Date: Wed, 11 Feb 2026 16:18:45 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH] mm: name the anonymous MMOP enum as enum mmop
To: Gregory Price <gourry@gourry.net>, <linux-mm@kvack.org>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <david@kernel.org>, <osalvador@suse.de>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
	<akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
References: <20260211215447.2194189-1-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20260211215447.2194189-1-gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 25174c4d-67eb-4739-60e7-08de69bb875b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmZUMlpWb0Zhamw0eEcwWDI2QUJWbGtYWlR1S1FxRUI0ZFBzVDc0U0JiL3lh?=
 =?utf-8?B?UjV2MGJhbE1yL1kreUhyQ1htV2hWN0Uvd1FxZmZUYU9ZSGFDU0oyNDNzdmc5?=
 =?utf-8?B?a2N0ZVZZQWp1YWVic0tsNmd3VUIvZGd5VmsxaHJ1L0JSOS9ORFF6UGt1R0E4?=
 =?utf-8?B?MTZwNHJmTml5bmQvRkxaSGRhVTA1YnpHblBGMjN0WUx5b3lSZnpIRklMeDNj?=
 =?utf-8?B?OGtVbUxnUm0zNHhpR3pXcXJtZWZZK0oxODBVcWo2bkhZdlF6TE5KY2Y1d3BN?=
 =?utf-8?B?MUpTL2FrZGhFU1Vnb3dIYjBsUE55L1BNT1J2eVlMa3ZFN3ZFMUJyY1ZmVkxr?=
 =?utf-8?B?MmdxaFFMa2V5YmVPalk2c1FmM0RtcGpPaGFhZnhRZE9JdEF3QXpnR1hiUnZ4?=
 =?utf-8?B?Qy90NVVVWUdYSDJrV3JiSVpjbzVBb2FUbmlsMXJCTDBQbW4zMTh4VVpLQ1d3?=
 =?utf-8?B?TGl6d2hOR29PcFhNODhSVXliNUFGYy92U1RabEJ0Zy9FUTdpc2czNStOSmxJ?=
 =?utf-8?B?VkVFdm1MYmFSZW5zTGRoRCtGak9zMlFOMkt5dWo3OXRHelphaEhzNVF4ZkRi?=
 =?utf-8?B?UW9pZmtLSmFYMmlGVE9VMVdyM3MybjI3Z2JvdGFtbTVnbkx5MVIrMUJwd2hJ?=
 =?utf-8?B?M0RoT0RWeWw5V05pMWN1UHpyVjkwNTFjMFUwSHhwV0FJcHUyalR3Mm02YTM2?=
 =?utf-8?B?eGpIanl6S29oVlg5NXdxQk11OUQwUkZMSndBMzNaMHorNFMxd0lXRXd0bjls?=
 =?utf-8?B?SFFlRFl2a1Y3SDQ1eUxqS0M0c1Y1QWJTTTBremJIWlBlVVdVdkt1ZGc0a0pQ?=
 =?utf-8?B?V0hDYkZ3OW91OE10Z2ovZkczRFFadmNDYW5jeC8rYUxNVzFpMWtsNFFHcHgw?=
 =?utf-8?B?ZGIrWSsvbFdnNFpBVTQwVUNzZ0RMTHFEWHlMeEp0cmVhbklFK09TNnlPWTY0?=
 =?utf-8?B?Rk5ZQTdmdFV5bmpaN0NkbHFSUlB4dHdUdGZNanZKcko5cXlqWXUrRzdnbHEz?=
 =?utf-8?B?VWtVUUFhK1NDUUpacFR1VGNWT0JIKzZ6ZzZwOWZtK1Y1UHVNQm9XSjlwVHhv?=
 =?utf-8?B?S3hNbU9WOUlNbkVwcXZWMTZEVmlmZHI5c1JZdEd3aHkyWGJPN3FMc0lmTk5L?=
 =?utf-8?B?YU1nbUNkTVI0UTM3NmFJRTdnV1BKVzJHZmUzVWZhMnpjSUdQbFJXUHpZdEFG?=
 =?utf-8?B?Uk9zQ3FKZGwxeU82OUJxQjFFOVZzTW9JUlViUnVUazBla00yTlgxMU14LzEz?=
 =?utf-8?B?U3JjdTNKL2lQV1doK1ZkMVhvaVdNek9tMVQzNE9lSlNhQ21STnhvR0ZMVHpt?=
 =?utf-8?B?eUI4WjJIb0JBcGR3NzhpRUlPU005aFVWNGJvTVV3R0w4aEJzL04vWXpYNWJq?=
 =?utf-8?B?L0I0b0JoTGJha2dZZHIwcEJ6ZGUyVW5IREdhVkRUY1l4dHZyR2dqQzhJQ09h?=
 =?utf-8?B?VmM2dWRydXRZUEVRZEhhbUc3RTU5QkFYY1JVdEJIV1hUTXFVVW5DbnpwKzBF?=
 =?utf-8?B?eGozcC9wM3ljMktxK2tQQ0x6MDlmYVdOVGFOM1JSZlNFbWdxV2VWUm85Snhh?=
 =?utf-8?B?aFRwdGlyS0N5ZWlETjMyVUlRdWhPUlJUV0t2MThNeDNyN1hpMVlKazVkT0NN?=
 =?utf-8?B?Ui9Ja0JMUkVPc3VTWlF2bDJxM0VvSTFsV29LWFdyckpRajFXV0VsT1pRNk5C?=
 =?utf-8?B?MEpvZ2JFMVVtb1RDNEh5M3V5eDRQUTFWbGZOQ2F4N29Nc3pnL3hhYUFzYnlM?=
 =?utf-8?B?SzVWR2ZkWGkwajRQeW93VDg1am5kaDdYT0JVR08yYk1VNkFLSUVaQlRFMzh5?=
 =?utf-8?B?S0xvSE1qU2pmZWNEL1BrY1BNU3FIeVpVbW9oTlUwQkZIMldnaHpSM01zT1cy?=
 =?utf-8?B?Vk1yck8vbE5FdHJVb0RzeDMxZ3dvemI5R1lBeUQ4SG1jOXZLUnVyeWNGaUVx?=
 =?utf-8?B?ekdiTWRMVHRhQUtOVGl5VDRMU2lCS1FXQ1ZySFVPQzZ4YkNnUVZHTWl1cVF6?=
 =?utf-8?B?dTV1eHlYYk1VWWJWYVNFWHdsV2cyVm1KTHlodDh0SVBOOXp1L2srM0lJTjZN?=
 =?utf-8?B?U0dVa0lwZFcvZzRBWldBZExRYm11dlBkRFRRRlVLRXJiMTNmUFRWTklzRHhW?=
 =?utf-8?B?cG5hQXZvMFBlWUNwekp5Tk1hM3JhQ2FaNEhsejJpVXI4cWs5b2tsMUcwdnFU?=
 =?utf-8?B?YWZmZUVlQXluSnk2K0RkQnZJWnBXbDZhTW1pUmkxR0xPV3pzMWhTejFGZFI5?=
 =?utf-8?B?aHFDYysrcGtxa2k3eldMRUxEYVNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iockf9cwFVPJZe2ahVAM8wEBMFueXV8yokryQVi9n2eTtKSOZO/JFBDc+kh9YVhaHgoCCd9hH7pJRt/aoVygof1EKwsCOuN1tZo/wBFV+kbVHd0zrPOq/r2qj+YrEFJPrt9wsi2sTtsHksmWUH+my7/rgviA7QrkGuljLv7BjFUCnJPtP7jRfZHYMuD915a/KuDe01ZKKjNKCKAodzBEoQIH6ywFTgaIDa6kuMXhxliUGND1o9fZYl/FB94PSQeES1A0c3obL36f7+lv4lp3srpPkY7p7xswhW80xNLsRsf3wZ6nH3wfUTCggeevqmZYzyeHcjnBhJBGoGYooheXZjhLjOG2VWBexmHh2apJnqm6NNwG9CLKbOzujqngUE2Xq2awlIUd1KhEIjkrKMER4HaaIzjP8tsx2fx2jZIXxMleMl2pSsbzTV6vF1mKvq3F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:18:48.3080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25174c4d-67eb-4739-60e7-08de69bb875b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440

On 2/11/2026 3:54 PM, Gregory Price wrote:
> Give the MMOP enum (MMOP_OFFLINE, MMOP_ONLINE, etc) a proper type
> name so the compiler can help catch invalid values being assigned to
> variables of this type.
> 
> Leave the existing functions returning int alone to allow for
> value-or-error pattern to remain unchanged without churn.
> 
> mmop_default_online_type is left as int because it uses the -1
> sentinal value to signal it hasn't been initialized yet.
> 
> Keep the uint8_t buffer in offline_and_remove_memory() as-is for
> space efficiency, with an explicit cast when we consume the value.
> 
> Move the enum definition before the CONFIG_MEMORY_HOTPLUG guard so
> it is unconditionally available for struct memory_block in memory.h.
> 
> No functional change.
> 
> Link: https://lore.kernel.org/linux-mm/3424eba7-523b-4351-abd0-3a888a3e5e61@kernel.org/
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Suggested-by: "David Hildenbrand (arm)" <david@kernel.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---

I saw this when reviewing another set of yours and thought about mentioning it, glad you cleaned it up!

One small nit below, otherwise:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

>  drivers/base/memory.c          |  2 +-
>  include/linux/memory.h         |  3 ++-
>  include/linux/memory_hotplug.h | 16 ++++++++--------
>  mm/memory_hotplug.c            | 10 +++++-----
>  4 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 751f248ca4a8..3753ca80069d 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -452,7 +452,7 @@ static ssize_t phys_device_show(struct device *dev,
>  static int print_allowed_zone(char *buf, int len, int nid,
>  			      struct memory_group *group,
>  			      unsigned long start_pfn, unsigned long nr_pages,
> -			      int online_type, struct zone *default_zone)
> +			      enum mmop online_type, struct zone *default_zone)
>  {
>  	struct zone *zone;
>  
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index faeaa921e55b..5bb5599c6b2b 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -19,6 +19,7 @@
>  #include <linux/node.h>
>  #include <linux/compiler.h>
>  #include <linux/mutex.h>
> +#include <linux/memory_hotplug.h>
>  
>  #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
>  
> @@ -77,7 +78,7 @@ enum memory_block_state {
>  struct memory_block {
>  	unsigned long start_section_nr;
>  	enum memory_block_state state;	/* serialized by the dev->lock */
> -	int online_type;		/* for passing data to online routine */
> +	enum mmop online_type;	/* for passing data to online routine */

Comment looks unaligned.

Thanks,
Ben
