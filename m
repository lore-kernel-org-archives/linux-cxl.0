Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793824772;
	b=ZJrZVXDZkV03i8DRlZ4lpZvOVgb/EXMsnI4OjUMdXRX/SRjzcf2hvbraNXmwIssspT11
	 sq/lDrEd2ivaKrdgN6maAv0VwmZoJgcnryEAo9Y+PAwDTw9Oqc2dijWlmv3RVQiwGKcnC
	 INILy78QEv77dcdeTQGxClG0v4bVlDD2lY5I4eVl/Hy3kp7wp0dgA90sXgRWOLT5qFJEX
	 cB7cICNk5o/7wvF53Alw8E5itmPntvMiIo9FpNatVAW/ayL/7VMvjuGep+5+VbQZXweqo
	 UmIkdrkMpjpAqu46z40OyJg8yicyk0EmCGAv28ni0NojO69n9NmN9Pls5rsz2FFCWTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824772;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 X-MS-Reactions:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DR1g0Q8bCtJw0djR3dMfoLeXmAkZYDMtyQM9I6YDmHE=;
	b=1141B5uVmEdsfJ2EuIrmiNjlUVwkVXw61MvvgS0GbY28FPHAgIUVHd59kD7h3ALnzGZz
	 KONa3d7VRLCduFre16gwvPT6Ycr8ftzdAY3KBSr4tFiLXRVlApQH45SdDVh1IbVt0/+3x
	 WAfRWJKUUbOab0fdU0Z5fAEVQx3J/fGg7tK+SbCMns9ptXpGdzdpPPtZRLGHqfPwo2/W7
	 aIhYGt5/UpBQmnyhY0k8xGN4U6b0odWvJOXB2n742yC2td0xQuRo4t66t6nvOLB4n0+oX
	 B54m0Be8d1VDF/1nW+bceIf60XWxk8RD0ZhNRXvq6Jq5UhWLTlnHEOEio1kLAAXQFzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U5QnF+x+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.59
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E57606AC00;
	Wed,  4 Nov 2026 20:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E57606AC00
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U5QnF+x+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwxEXj6BMVLyMH99aul9fFdUy+Kj/FCDcC+pm5lfrWmHiwH/KbPa27hSy8Zue3UOpXk7GCiQ8LEF+OwLjO6WZHKu7zWxNVvxT2GRg47GXPcb+XjyoNeEfAmMqr02kojBoPAwVK8cClQi+wtImk+DfqzrxJ6ZGE8eYDG0YuWY+VzF3QRtfSfwhpf/QPhqT80e+U00CKw0VLaK+LokPQ1cRCdotP28tnZ3SxnQLEU8sbS6yVmdUyPkQ8BeOJ1PwfgG1KmZeFfA0FpUGRz1C1j/R6NXhVmTUKCg1M02nKYB64xT1yYXIHjM7dbivKzpEQr4mciOZCn7LOvga/LYs+tMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR1g0Q8bCtJw0djR3dMfoLeXmAkZYDMtyQM9I6YDmHE=;
 b=tZhBzcMv+6M10NNwYzAa5PMCojvjffU+jxQV7VERTlyD9w8ka9X+rCvFNFLQFdkrO15mC2Jo97dn+wrWEMirh8AH5/yBL+tHfZAQlQl/5dv3LhTVjZOs1DezqD2x/7gZxYocK3uIV1ZAzs9Eu0oXxltjjAyZ0SnCe9zHrboqF3sNoAUlE1F+RYjdfWNnJ8S2oIkOcRR1EBV2NfPekPmtMIrsaANLpfKWxg2tuNxW2zTydejK/ZusX5Nxi2mnaNyX0h0I+Rxj9ne5zLTnI7PDvJBLsLRDLNSNxSXHpv0/wZZ192TC0b1EPU9l8QWRPB8dRECXNIstOFp4y5O9pzizrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR1g0Q8bCtJw0djR3dMfoLeXmAkZYDMtyQM9I6YDmHE=;
 b=U5QnF+x+1rX3X3C6GCfvqTyqOB89IdREo3ZKOc6JN40HsN7K0ngf+ihdqEYFLT9yOjJtVk6RPvBW+hSg6vjzSV5AhWYeMJQms/+9sAeeK435KG2am9MS5jMDrqTqIQACr/JXrUzXM4i2H58mqb71MfUnGG23y6KDfrJ7DJYA3tS9goRHnN5grNrqhoZ4GAt3Ljc+/RWb6PAv58G6/QTa24byovdPwVHAV/MKcTSXFA5MeLiTlZIhHVPQnIX0pXLgyCfYf1ieuJ4cCI2PBNBd+vf+8y46h1IgL9OnTc+Q/BMLPxZ9XLpm4Ugt1kmkz5B2nRQlI+PT5I0VV9P8j3OS3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 20:39:18 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 20:39:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Xu Xin <xu.xin@linux.dev>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Brendan Jackman <brendan.jackman@linux.dev>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: split out memory-failure declarations from internal.h
Date: Wed, 04 Nov 2026 15:39:15 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <13A0BF13-BB68-48AF-87C2-6650F8426F5C@nvidia.com>
In-Reply-To: <20261104-memory-failure-split-v1-1-3b0a85f0b7e7@debian.org>
References: <20261104-memory-failure-split-v1-1-3b0a85f0b7e7@debian.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: MN2PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:208:23d::10) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 561dd2f3-8db9-4423-5439-08df3ab3b1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	HjY1AaufJrgDUO/CJpq5rw+wLYHnrd3RNM3qVWPuBjKY29JHXK9tvz2+RKjntwck87JztbogTRKz5J+rtz3UyIxOyf+BbCBVTWcswAW5jqE8ovE9mj38GW3Jir/z0w62rKRB7RfBDxw3GmlOUhXKlbu/oXxmZi5aJJJhS+5sSZ6T2XaACH1b0UBTV0bHC1Zz1AAWEhnghcdNINybQiQkOdb8XlTtG9F2RqcCSTFmgZSt1+9dzb1bfVJAA4diArcLP1JelkJJtv1x9QNTZHKDKtB99R7WD/YtqZNqPww+tQeB8kCODbCJ46OBNsRPcHrZ2Tf8Xq61sDzTRdkoH7VPDtS297O2awCwT7C3I+cFYI+85XlkcDWe09ECiT5ZQfFi7ZA+F1rXJfQSk/gYFs+N7NEBuXmq7v4yvqt+bUbuEKa6l5TKbVo1nyNzvcrK/60B2rVdhrSqgDgPbWNbCcMbWLKo11vBgZ4Cyv3lqCYUUDIz5mUZW5OyLKDLcHMBusP1S8U2tQW3VrTpQEU+DO7DvnHeo/J/LCPZqpcNKfSh+sa+lrBiAgaAgdMyC3Jo9G0+GU6anRAygNyG1Bi2/o5leZvUMhDkFBdA2RxBOHX4yIB7QxdkVlx8kWCB2vjGXdXh0jWCOZ/0rxEd4PTSPa2F/iiZgRQGKAFOdfIErUq2B+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cLf6zZBAtBh0ULfz0Vxbyq7vzLVRYAd3bn2CCiLNauB8Bc9jeNGefi60hDZ3?=
 =?us-ascii?Q?92j+51QjfQbX+G5+6NICItO1F5uW95sSJ4R33bYl59fVnSiWS14UG+hYup3K?=
 =?us-ascii?Q?gC2DPfGHvmEwVaCNA3Q/nVwgtNcwUPNonM8i7nu5VHbtihBZt1fCal7jdyh6?=
 =?us-ascii?Q?giJnFpnwOxGdo0mlPs6ePH4yO3IdTCABpZVsLvwlfuF3j/LTwjMOBA3+iv12?=
 =?us-ascii?Q?8SCSJYAf86xpeC5D+hx48deFNv/eHDcc9eYr/Zh1wnZd7/59Sb+Y5BrJ/uvK?=
 =?us-ascii?Q?BvRIfZhOdgQdbVLohBmX/4P2tk1v31yktIhytduOtjt3Y+LkQnoDvsI4MfWw?=
 =?us-ascii?Q?eeiln+fH31ccFRDhypofknWPDyxHrcUhP+4/04tTnLkapSy4Mz0Jfwowi35o?=
 =?us-ascii?Q?1/1gxptH5wS+eptLtFQndmc9J638mbVpkIyvwiBTwhVHvqKfqY0pZDt46IE5?=
 =?us-ascii?Q?T8yxyUdBsT0ZB3eZyUpkM1s9qyDnvjuDNcSHh6Ua9DvNHNHo4hymnI5tGyd2?=
 =?us-ascii?Q?gCM2TQJn5SjpWaGUW6+B+GthRthZIbTtYs0Lwe4aiTbdEmtM45JnClS4zsSg?=
 =?us-ascii?Q?/CxeHIuve0C9LFr0iikmDKmbKu9/UFtUQWRo9P3OYi4leFwWN9Mhrxicia4s?=
 =?us-ascii?Q?g00Q1Zg2Obyhv4bJyHaRp9To0VK8yRIFF28PuaCTKwRfS9BI7kH+a/EdI4P2?=
 =?us-ascii?Q?A0VyN+RI4915VIhRYbcqwPFEuPQAiQfCBvzzPV9Z1HKsZNOre5ClG+Xb2jtc?=
 =?us-ascii?Q?lyPWwSKPP7b9QgNEzuk6b9OZJi6kJshPWEn/Nb2S0yw6dnNvSdv5LQkwedF5?=
 =?us-ascii?Q?9MpVw7tmVMaQZv8LLAzgA20axXRnNcHYne03p2W9ddOjTrMX7H+5KrPjHyQZ?=
 =?us-ascii?Q?FnGms7kfWdlRGm8TtR0ixz+gRH33Oy2Cb9Zw5mk2cFjftheYf5AgZwHiuDib?=
 =?us-ascii?Q?D7f7sH/EC0k69+Zlg7M7ipFHaGMoho/yJ93vSX1oZ64wVXml60vH5/VXwbAM?=
 =?us-ascii?Q?qBUSQtxGu2uT1u0n4fJrWAwOsJONYrU+Zm9cfJX0MPYVg2TXHsUdgOVt5ar5?=
 =?us-ascii?Q?5JXyLZy+bAm9iVMDakJEmYj+x9LGLk4+Vt8ZhoxYUrgMToUTJDSSjjwNMScJ?=
 =?us-ascii?Q?seTbM2zFJ95P81CrJ6xP3AS/m8wAiRWfv3oAGkxTeiA1Y+M2YmUD8tvJk3fp?=
 =?us-ascii?Q?JRgmemnNqvw4q1i6duZr06Xr97VubfWaz4Ia15oaWQBqYDzzV+2CMMg0qPhX?=
 =?us-ascii?Q?AkfqpitakCkPGeIgDjEL8rKISe5PqBE8VhXYnrJhsI2ZfjK+ztJG184+EGRQ?=
 =?us-ascii?Q?ksoHn2lOlDV6BTWEeLFdqB1tBPStKD/jEeGxcgkjJos5GBTfOXEGK1XFESPD?=
 =?us-ascii?Q?Ftef+kapyhpFWD8z6xLi+18huVx1ry42dn9xAbhGPB39ubIQFR8f8ttKDG3Z?=
 =?us-ascii?Q?q3bzdUUD6XU36ZnTBXLLh3G8M5K3TYiTFXhYJaakWLBdsL/cvK1HvdMLFcm2?=
 =?us-ascii?Q?2G4ZO7dopaewKuH+V0Bj24WS+M9TVCz8ULD/M2EgA4QTQm862wVQJbNg/KMY?=
 =?us-ascii?Q?vgE0OcG+XMWRf2hmuKLrb66RqoXhsJeJZhHjWRmjMoCC+YfUAzdGzi37r6YB?=
 =?us-ascii?Q?IlbfyFtOlZSAKYwUH7pfagufhV+MTGinnzSvI1VjPgtJKXBSB746zmE1VFDx?=
 =?us-ascii?Q?AXkJYk+iTlkh3QHohhLNcjOv4huPlHl6KHfNZ3/JxiRmRUwu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561dd2f3-8db9-4423-5439-08df3ab3b1ee
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:39:17.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29cGIbZdM0P8usie9fV7L8HhlRk2qrFXrODm0IYDO0Y9YItzvNgtVOVu5QvbVz0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414

On 4 Nov 2026, at 11:45, Breno Leitao wrote:

> mm/internal.h carries the memory failure declarations, but only seven
> of the 81 .c files that include it use them.
>
> Move memory failure declarations to a new mm/memory-failure.h and
> include that from those seven files that need them.
>
> Move the block as is, including take_page_off_buddy(),
> put_page_back_buddy() and page_mapped_in_vma(): they live in
> page_alloc.c and page_vma_mapped.c, but are built only for
> CONFIG_MEMORY_FAILURE and called only from memory-failure.c.
>
> Keep the declarations private to mm/.
>
> No functional change.
>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Link: https://lore.kernel.org/all/aumt-4kfGGtoXuh-@kernel.org/
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  MAINTAINERS          |  1 +
>  mm/hwpoison-inject.c |  1 +
>  mm/internal.h        | 29 -----------------------------
>  mm/ksm.c             |  1 +
>  mm/memory-failure.c  |  1 +
>  mm/memory-failure.h  | 36 ++++++++++++++++++++++++++++++++++++
>  mm/memory_hotplug.c  |  1 +
>  mm/page_alloc.c      |  1 +
>  mm/page_vma_mapped.c |  1 +
>  mm/vmscan.c          |  1 +
>  10 files changed, 44 insertions(+), 29 deletions(-)
>
Makes sense. Thanks.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
