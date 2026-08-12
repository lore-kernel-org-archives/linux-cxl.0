Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7A31E106
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520298; cv=fail; b=QBQ/FUcF84KEuvV6UrYUfwth9NYn2LEpZSvGZLGwsm+XH29rF3IfTubEBKTrrFMLY9pEOplZpIEvJ2hg9G32Gx+FkmYTsxTzbjIwGnrfvfGx5oGGbdMZZRfwz9N44UpjJoV6Ijac1zXG78YtNmejWcBoYzSprL/WIU0fGoRFvp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520298; c=relaxed/simple;
	bh=3sXK5YiiwoC2fjQhyk0oSlKA0XpDvRBr2Ncmp1IoILk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vERXJuoe8EnV+rsTkwe8/h1Fp9WhCd9SImZF9WHTFNbxU/5GjE7Q0KR6gY947p0xUTawE2/TUdhTy3nlilR6mNWtIlsmAzvUlQ04mnuIkUnaHeD5AOC9tccRtDs9XxS8e1BHQF07QAhQUW9XEt9uKPzF6tZ66InVr0XqC+jUd5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cLT5YAUN; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cLT5YAUN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKQmq/Gmzx6a34F7wqXaEwmt3+PSGQjXj927uGPTTbFyK3hZPlrGcubuvdxfE56FIo+ooCwX61q/pyKubdDOwjPY57IibltrkMaztDYvo3bpaDk2nbToJJ47VlhF0lbNKVDDl+2Xncf8wyevCxx/aPeQnEczNerpwebJnssjCKY+CLuj4MykLYdsYuMFI49U6HJ2EgFdSHtHqRXZuIE0dFg6t2l6VImYvLeXcw3F8d/6Kghfs+VpeMykuOMe+RWYpjZR8SN3HaA2xxSDyi368EOcrq7RHLVreYuQFvQ+n0nnsL55YPgAaZ/yqDfno5yzxXMjDlR9J50DQpcptdkkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jr+biP+TltbFLaFb7Ec78s+BmytIyE9532HwrBRYuyY=;
 b=cTF5z7lGpZzWkl5h2BjoBanmtzDVtAWw/HYjSWzjhVIdDStLJVCynXlPnhFKUq8fE1cytrsDg/ERQBOa+1MyKHRjl+wgrpcst74NjwLe5vei6OGB95XXfZQv34eLekwi8isNKuyAqGhzRQaYevsfGjX6J+5TIZK/rYR17xQN6GSEjFn4ajopohiiWZmurdSFtJjFLyYhtZyY2dgWk+6mNG57vavFo81CaTdYtFbRwAlPF4eQTbfsS0i5hw+DzB+D8cte3zbDv8nJEt7Y7iW9CrzyzPN7jIdeTxDwedPwt3e6UIQuEAbjEmPALgETEjKVFrkQiOIhpO4Etegh7k155g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr+biP+TltbFLaFb7Ec78s+BmytIyE9532HwrBRYuyY=;
 b=cLT5YAUN0E8VwmFJFtc4SJqM0rwdIQnL6LM0dtGscmfIdkZfyCvA3nDdjNMW1bDQ4X/qe2fy4VhFkBXnCf2NhSynDMYt2WpckSa6fe63zOCOM1La+3Eiu0ry9cozODWKspE5ClVv1Erb0HGCbhXUMCFfA1PTKlv+M/mczLaUUzcbb6HHYaS03xQZJlOBWTcy6ziIQcjuCR0bvCwxmDt5zILfhGdqWDsJNQJIyYAZH6d+6MXsQo33FMy3E2bLvbexdNUMj++/+3YaF+imW0wnA6LCglal8E4cpJZ5IgfuGt5CHKpvcG7iwqgdTMxVZ7h+eCWoYUq4I2UvV/Q4hSX7Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Wed, 12 Aug 2026 07:38:12 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 07:38:12 +0000
Date: Wed, 12 Aug 2026 15:38:05 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/pci: Fix NULL pointer dereference in reset
 detection
Message-ID: <anwiQwy1bR-0peFJ@MWDK4CY14F>
References: <20260812061027.57037-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812061027.57037-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7b8ecf-3af2-4056-34bf-08def844a9cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|18002099003|22082099003|56012099006|10067099003|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	yUutXQbiU7FdP8TaPe2BvRnFDiAE5ouKV3Y+JEyjjwXWs/VuLRwDaXqrz6PFJEGSen6yQe1N+/9KXONSGIDo176MApBC94Q17W9ywglB6cvQzBUKhDpUhTvZI8ON7KbgiygTy3WIzwkMhmKQC9UHIriat23Kis4hMgohaRW9Ytr6sYi32CnR3gzec5KjNux06uVlmfIMRW5Lt9kvgQb+4XLmMaroNiem5TpLc6VsoP5p79Jn7Ym0mZb9lbAW2Kc1qImFkSAZnHpUI1ngUYHCHm4GkeELzfUsr0XlpMj0ryrNTWUwJgalbl0A6D0qm8hTmXCCxB2qFMTb/LyW9P4fBHHJr8VkIufpiF5PJox0G0c+loAQyJ7BVDXVJxDzbPHL4TFcix71VJnyi/WqeBdzF/VfnLdMBM4EK+g7OMt8c0KCj8ObXzTO9l4xNhksPR0bYjCvHcCuHp/gSJ+IlwK6Y93yr+alB8P1p5QhzDmgV6aOnKmL2PiFotvAqEYOMK51utfAstXDujrFM8WmQ+uq83nNXmNEoUmKQXKCgA6t2l8Soxpmkrc6ui20YBJXpKKIbRQ8pnUyxHweMslBIDxtkJ7RnAVycsYZgVVQVWlGHH3DK0NEiwVQWHt8J0pm4dAMVQhkk0UUXYQaPXObHMK1/G76nAdNWri/iiY+JgqkaXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6tvH5FC9Nkl4LlLtR/jW+sj6fLU9lgt5MGpFS/v1UGNsOqYgw4HXRF9u7+fC?=
 =?us-ascii?Q?btUG7IzYtkNJ+EaxY4EYQ2WZPQM25ZUR2B4vKSDPWFswmQgZO0cjCCes0i1J?=
 =?us-ascii?Q?O7gbpxecr6VqW9Rk+cR9XAikqlCPTiTd4UBQTJzUtp6JfOxsxnFZ9bPUGf5J?=
 =?us-ascii?Q?zm9beEPU+UeVM18Qmhf9eO0qqhRvOfH1ZCqr6lAUJp/74GYP0ba6ObMMjivs?=
 =?us-ascii?Q?QCDOqoNOMXSkBbwQ0wj3OVcywl5Tb+6jCe6SuWZqZ05VEuI2/2nPnorwOYWK?=
 =?us-ascii?Q?9Fg2ljACTcyN+S66pEE6OklzRVRgbSNtMtyMAv5ZJyI3xyU/VYmxbBFhm+wk?=
 =?us-ascii?Q?CASCCD2SvIo7oiOAME6nSVDtzA5wk0Lsn+B+EFoOV6bgPJVRMkISoBp4ysT1?=
 =?us-ascii?Q?UhONXT7G/9Hn19B4o6vFA+ptJ+P5EYX7pKsIjyFykOy6sCR2MAWcM28Zx1ap?=
 =?us-ascii?Q?Bp7OLDL8W6ds7XqHQMNxZE+oJLheHwS3hMmIODtYaRRuYHXon7dcVEKdMY5U?=
 =?us-ascii?Q?r36hvdygKQtWrPWxiW97L5lNzHXiVphL+W98i0hIGzU1aPJdyiZCL0ZHZQh1?=
 =?us-ascii?Q?saxqJ1gVQJyZsOebvXELnzgb9jYuThSwB4Suar/7qCJlfsFwlZXEyplaszWD?=
 =?us-ascii?Q?13TCFXghSpc+4tFgHGOzHOQjsQGXkvw7y+YZ/T9wQ0ShdVynpdTQMdfTs6LZ?=
 =?us-ascii?Q?w3OijAsUJiz+M4jznjm0NsbljJtRIUACAckFjlaKwbsIOPZpxHzR/tIQ9Tqa?=
 =?us-ascii?Q?4Z95HUZMMA7R3zGPmW/9GTpjgDQMy15IzqWL15w3z/GmF4Xk0Vz4CMhHyzb/?=
 =?us-ascii?Q?3+t92Qfjmhih1bV8oPjijlE7cO605WuoFt4U/poLDtyI89SEwUuyUCNmh5nT?=
 =?us-ascii?Q?acci2BlYlyei/MCjjJGN5xPVEB2hOZ6N5fYDPA5KhL8fPpgN2eo3uEjHDQCc?=
 =?us-ascii?Q?uLgvXPc9ctc2bRzQhnFj9gJszWO6DrNC8zRuIEVlzxCLTHt4rg3tKvZNCnLC?=
 =?us-ascii?Q?witrPzJ0VC9rMYg/cJfojq/+MPIquGY6BZ9cVcGeBmfMoc7L506hRcsWl+hR?=
 =?us-ascii?Q?TYu2FUA6AL25wqb6yp1AdYws+e3wgBmgHil+sOokAZkjRZSoJhshGryULLot?=
 =?us-ascii?Q?I4B3tq0ybZLosQSfW/D1bBJD8iLCa6dmV4FbIfIkp5v1ItMWringB8X4tTO7?=
 =?us-ascii?Q?2wHybba1l4ovLx9nb8Q7yuVynhQNU+Z5yRfhxOyWH/ylL5RqdFJkAuAMHFla?=
 =?us-ascii?Q?/ACGezVcH7dOT5Y5w4DqHNQbUjhdidnhYIdkMu0RQEOiDVo1EZzWWs0aKvLu?=
 =?us-ascii?Q?5HZRmIQIM9smPC5aEzpDabH58ZJsu6zQPQLi5FWTSuBEGqohtrOgUkfLG8E7?=
 =?us-ascii?Q?qidwHKitWR8kmiDHxTEhKCkB5MlhG0cnGEylFrqXnf1JwSSIEnwvSvSLx8z4?=
 =?us-ascii?Q?Dur66WlFj/TXHuRGVcb13yxUnw31HXDs1OY32eW4ujQPIMqzgynvB0+L3B5g?=
 =?us-ascii?Q?2n0vjF2HtV1BuM0tsD46PXIewf2DztwrY63dla6QvIMVoqt8zyyDnbKOElB/?=
 =?us-ascii?Q?KN76QaTZsZKOTLtbib/kyVZeULvHcCy7lIYiULGSfoB+agmmc7N69TSVpgrf?=
 =?us-ascii?Q?42MSeV8bQvvrVljTjSOK+FNALyRNzz+Ecuk6iW2ajpOAihZ5P8trm80mO/U+?=
 =?us-ascii?Q?Loeww82jf/94lm5f5e+VXPThn//HE8/g94xNhy9CZBzah/U78VdbnjwkaVcH?=
 =?us-ascii?Q?Yk/kb2q7Mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7b8ecf-3af2-4056-34bf-08def844a9cc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 07:38:12.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlF7SP1neR80RyuWskhBaQkUXxHI2og2BCyl/ivTDj2pCWTOkDOY0fJVRuOFWeFx5TtuvjLpylS+ak6Htste0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117

On Wed, Aug 12, 2026 at 02:10:27PM +0800, Guixin Liu wrote:
> __cxl_endpoint_decoder_reset_detected() samples the Committed bit of an
> enabled endpoint decoder by reading the decoder control register at
> cxlhdm->regs.hdm_decoder, without testing that pointer.
> should_emulate_decoders(), the other consumer of the same field, does test
> it, because the field is optional.
> 
> A memory device that exposes no component registers and describes its HDM
> ranges through the CXL DVSEC range registers takes the early return in
> devm_cxl_setup_hdm(), which leaves regs.hdm_decoder NULL and derives the
> decoder count from the DVSEC ranges instead.
> cxl_setup_hdm_decoder_from_dvsec() then publishes those emulated decoders
> with CXL_DECODER_F_ENABLE set, and CXL_DECODER_F_ENABLE is the only filter
> cxl_reset_done() applies when it walks the endpoint's decoders after an FLR
> or an SBR. So on such a device every reset reaches the readl() with a NULL
> base and oopses in the PCI reset completion path.
> 
> Report "no reset detected" when the endpoint has no HDM decoder registers,
> as should_emulate_decoders() already does for the same condition. A range
> described by the DVSEC registers has no Committed bit that a reset could
> clear, so there is nothing for the post-reset warning to observe.
> 
> Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> This was patch 4/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
> issues are already fixed in cxl/next.
> 
> v1->v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>   the code change (Alison Schofield)
> 
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
> 
>  drivers/cxl/core/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..611175f29d24 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -685,6 +685,14 @@ static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
>  
>  	cxlhdm = dev_get_drvdata(&port->dev);
>  	hdm = cxlhdm->regs.hdm_decoder;
> +
> +	/*
> +	 * Devices that describe their HDM ranges with the DVSEC range
> +	 * registers have no HDM decoder registers to consult.
> +	 */
> +	if (!hdm)
> +		return 0;
> +

Hi Guixin,

I think we should cover the case for DVSEC-enulated decoder as well, where hdm is not NULL.
That could happen when HDM registers exist but are globally disabled, so the driver uses DVSEC ranges instead.

In that case it will still pass your "if (!hdm)" check and reset detection still reads the unused HDM COMMITTED bit.

Maybe we should also check for "!cxld->commit" ?

Best regards,
Richard Cheng.

>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
>  
>  	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.43.7
> 
> 
