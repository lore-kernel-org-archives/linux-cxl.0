Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A74457C6
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457457; cv=fail; b=a1cQ+20cQ6I/ZXpk4J61Mw6ArUfpjFFMSa93G6qpMelAOXryn0d4bqXgz9tSIE6+ALu0HuVSmRyd8glZTBbG9cEe5NEcQrJ7h5CZlKEfo80lRulVBVSBiZ2F7xv7IVzWnEKRPGtYMiFBubGfadBFS5W83O/qwfKazzCqNt4yfIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457457; c=relaxed/simple;
	bh=UKYnAAO2i/L5cFv5v6aNaf1D80DAKgfu4S6pMQMYJHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZkslM9/LallbY3Spia/zUM8Eae215ufK9SzidlyEc4Ndmg565HlAvo9F07D9cl321WeMMc0dH1Upv/RqWHEAFsnDZWoKMawTrp0uDo31W2Gjqe/+XTvA9I6C9Av10AEQ9OOeoKkje1oCr4iZSDKFBgjxuTQx5kKbyjAwdvgziIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JR7nbxL9; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JR7nbxL9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynjBKatQOi556a/XhayPv3KWQbI8i9ec1n1pvWlLi/gnPTqeAOEJh4z8qxQtA6lt61UvMBPSqDi9msubjTOvu282teJ2Yac5egu8h37JEu0BLcwIaiMyiYcEH0N5BRzgGKfn03t1HQs20Opb58c5YH+V7lfMcVm6NUoQbezpPUyvvWpqKhRXRCcDXSiqg2mxRg727dnH+YQ1deU8C7mmDyejmD+lxpSG9phoN0b7SLOAuMt+2zhRcsX8uTs4bgTFjEM9p/HNrcHSW4EfCERwhh5HDvfZBGK9s3tbVtFn7Gr1CA4WFzoSLYqV7WFs9dooMxqvxSgdSBCTp5MrcME3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VGzKhVO/gJh67qD7wa5mJwWPkuFoM/LYS/usUOWFmk=;
 b=RMP/izvpxnvjSuHPWZI5X9k2HnBHq+0PElHEDmx8zI4nRWmhHnjlqKviKbykq69zeYjfjf35f5KVh5WZl/VhSzWFafWFq5yfGgQ9KoXUBG2+MVms9lyirao9h8zflY/XJxhgYmzvgyMkaDAwBgxxv1CU9EJAVJie+hg8UYry6t6tvfL5S6WQ+e9wV0y+fGLtSmNsjVHFgfhZFouCBxP8J+G28rK2JCFUM4CNCDdQhme/fxhIRcgIfcR0wcdVz7z48dxP5z8GjsD1leSuJ8SV9+H45lsH7EZzwbfMLQ3Z8WulJg72yuJvt4QfKxhatEA/ylsioU283tkLxqnmu2/EXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VGzKhVO/gJh67qD7wa5mJwWPkuFoM/LYS/usUOWFmk=;
 b=JR7nbxL9FOR//vd6LcwPA+1AM1v4faSBw7Ah3rgB9VG4yfRQAgG9jb07p6ajsd6KGeFCZbMGJGCTjXZad82INMHzS2ZLV/D65JANAgcQdE/oG/64iqsWTm++GjAusPFAiAS/IIbU6cFhM52VqL+VV35neuHMFiYfpTQtGRrqzyDKjYXbSZDjhgDepCOSj+o9bWPpbP25g1bb/qCzrGztOJ2p88d9qwIMfcPG7ahKp3nN2l2K2zqPnPvw7UUcPUpiHxkDLMT3+N50flT66ljyE7rFFxSJWidz5SAbMPYIHwIgL9pa/loHbqZb89++1O7B0CH4rc3Y+bGePFV5jW7Mlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:30:43 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 07:30:42 +0000
Date: Tue, 15 Sep 2026 15:30:35 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, 
	jic23@kernel.org, dave.jiang@intel.com, gourry@gourry.net, ming.li@zohomail.com, 
	vishal.l.verma@intel.com, dave@stgolabs.net, benjamin.cheatham@amd.com, 
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 2/8] cxl/mem: Read dynamic capacity
 configuration from the device
Message-ID: <aqjxpUZSylwTN01S@MWDK4CY14F>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-4-anisa.su@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-4-anisa.su@samsung.com>
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 211a0d48-0ed4-4fe4-acd0-08df12fb3fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|3023799007|10067099003|18002099003|4143699003|11063799006|56012099006|5023799004|22082099003;
X-Microsoft-Antispam-Message-Info:
	n17ma0Upgcoo2vbr9NWS0UtGAJoCzhJsGAEFawNdiwSGCUAVmKM4hHnL0yYWIawS2x017Eq61B1D6TE8TWZUtcy69HI5H/Qw9F+h6xCqKLOT0WaCXzh77q13hlFTPBOSApMIUpsTQKz/kk6TjsrYuTqIFHbYta7liHgm7qBfi+Vf+J2Tw0QTVeA8lRrqCiPm2/VV2LWgFgxBIAy45VZZgz2ZmfUS0HGK7FhYwjAzIMgulePacqZ+wEpfV3Hsasb3RTfvYoEJF9wblfG9T9lbF4Jolh7ZaDoKjxF0XLzWfy6WjOv8GJlSI9u/QeM9/EycZOfFPI8uDog0ULHEwRZlItdBpFhbAFnNVlfql3j+EhMv5aAFhS16c7N1f1iDMzUd8+jnQbyM2cV+lVBSE9Zsy7QsLVqb6DTht+Ok5Gf0XrNz9odwqcbG9kmGfNlkHhnlxe0bjM8vSMisErSrSfc4cyp+ByMwdcwvfuKWmkj+ATNBrHjvxL0AdO4M1dCUOdXEjU2AYetF47hgIyXQP5/qFTeA2wiuynqIchAYWfomwB9+1RPpZayMl5buBRmjkgjjGAHaOikUJsXVVsimd181gojLqQ3NfOZg47QaVXEw19QIHHFUAhZkp+hiWUFTE2msjHksanHBVzoJq8XncPoNmqF8fNiNvVHFCafOxrF9s90=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(3023799007)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006)(5023799004)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bT7LFuC3nLaxA3empjmJDEcXwG0RpaXkId1uMsp0GSAeYZV0pyio0ZxtQIkc?=
 =?us-ascii?Q?gbCZkRd+XvR9imRrh8faj1FEC4PHxH2RA1odFhqdZnCEVC+wKQT9fZ6HIa2e?=
 =?us-ascii?Q?RX39gi2RlVkAqgL3P5s0anSqipPmaWg51FD0dcqmqj6QOZTjbnRA2JZBue8C?=
 =?us-ascii?Q?Gq7ulmYYQiYX9BKiveQZkaiREH2dX9nhPRaxkf2nMj1+qkTUWr0DmpuPz+sr?=
 =?us-ascii?Q?EJpJqxgEUS96Xh/n3fP4veDdJuxg4cOohjT0Lrxuv1hBPLNyhJb5h9oXnCQo?=
 =?us-ascii?Q?k23X6iick5vyzYTN3mjdit3sO89kz7QVD3St/eEhCZB5CPUeD66ZQu+1Uph7?=
 =?us-ascii?Q?CB8dzBUtmRxQSV8fd6/KdVX+s3dBoI9qTYMzmnRpRTkKsiSw5r9TFjzEFSxY?=
 =?us-ascii?Q?C8SagX6zQR3o2o+yZeAkz7eIFmQMgnmN1e26Yti3lfXRpWeIMNavgn6QsfRu?=
 =?us-ascii?Q?LgKV9DrH6bP8TQlrtz/D4pWqHFH11rNoiKrFzDT2IuNePUEKdX1dptB0IzRr?=
 =?us-ascii?Q?d0cFKDqOlyQwipYfvIEP2w8m9EC3jO4ORQfSuCtkbSez8hib5YqO09N5Hnh4?=
 =?us-ascii?Q?zwkt+FccdzDAEDX9+YRoFEfveQkk2eHxdpaKbyAGCEgjMmnlm504Qu+y/mb1?=
 =?us-ascii?Q?9rlfTVbq4091v2cigvp93N5eBxEvezanI5SFVmLCQh75dUozDYzY+d3D69b2?=
 =?us-ascii?Q?QlzCxP+HDQHGCgri5WyJr7DNCQVikOV/YDtlIjD3RXCGRlanAOaLe2tGyJ+0?=
 =?us-ascii?Q?yUfvsZLxwQHdu3CFDN3vmnzlqKxl/KieQgGOTGXaotVnifN1bkyJlYB3LMIh?=
 =?us-ascii?Q?tkbOm+319nH3+8ej7tlNOGt00JXtvqywdHHyQ+Q5VluYYXITp7kPZc7UVe1g?=
 =?us-ascii?Q?tKKUzc0bT9V+/ZFCgZNUitlINh6SFu3lrCs4Z2byyeFh3hdB5M+dhrKFsGmv?=
 =?us-ascii?Q?uAeg98nR1LlYYDa2tk69npyYweUIJUMLjgVHGNDnd2MB91pnbp8yAp27JH2x?=
 =?us-ascii?Q?YAsOHwOGwhfYsJZ54p9XlR+c0Evy+c86Yrprnny1vemCjdpXIXKrveurLGU0?=
 =?us-ascii?Q?uZS1XIvMKHIUjDYp2OQE0IbjlSxMLnGmyGUGxIDSiwcprvyE+tE86XgdMo+t?=
 =?us-ascii?Q?mO8y/ZrbZ7hEe4T3fWjMsBXhErVsjtXByeapzOzkHdu8+5HnXlNhJ//57NR5?=
 =?us-ascii?Q?mBEXTbzXqnncEo4UjQcIPtoud1o51K11C+hgP/O8+olxDOwEK1lti8IXK7CD?=
 =?us-ascii?Q?T3rs1TtOJavi9Wl3sj+6pPUU7OiKK2ECixQILqKjq+5GxoScuDbcN9HzKD+1?=
 =?us-ascii?Q?NC5xfne8kOZ5rrmnDgo1PLFL34EzRQ8z15R2IiwF4dz3d+LiJgnqX8+O/UDu?=
 =?us-ascii?Q?9/RpJOGKNOzK2GIsVkCDyBvWlYOAbf/8zjnT6XkNCpgA7HPWrtgRvc52ByeL?=
 =?us-ascii?Q?Pt1qrk0uA2PK/tbRcjvw73/BtvDqAK+/DZOT5AtVZr79sqzWu4KkV/PQug8R?=
 =?us-ascii?Q?86hq1FB7gpB0HIIJOlL1zCi2eNtJXZfZl7iPFwikOj8uNTj+GHXxmrm2N2Se?=
 =?us-ascii?Q?qTshk5qh3cBFF/c1XaY09533N+GGvNCIt+ypKNJqoAXR6BligHJgXSMygKwi?=
 =?us-ascii?Q?P5Bzz/9FkV8f27AlvohgXz7pnXZmihgOEzA2ALgQugCFZXoCpdlCIot9dJmj?=
 =?us-ascii?Q?aUAW0Y9GztETEALktOq4fFdX8ESOIxwLs1nvCtZb5ixyn9//?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211a0d48-0ed4-4fe4-acd0-08df12fb3fc1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:30:42.8104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRszUGVkGfe0AaA4Rpc1mSpa7DAL9CW2VV84tsIQl5o/zdoYrqeQu8NPkTDQpoqFq7kKwGZ8D/RkO6P3Uzxsbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492

On Tue, Sep 08, 2026 at 03:15:06AM +0800, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Devices which support Dynamic Capacity (DC) are configured
> via mailbox commands. CXL r4.0 section 9.13.3 requires the host to issue
> the Get DC Configuration command in order to properly configure DCDs.
> 
> Implement the DC mailbox commands as specified in CXL 4.0 section
> 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> information. Disable DCD if an invalid configuration is found.
> 
> Linux has no support for more than one dynamic capacity partition. Read
> all the partitions the device reports but validate only the first, and
> configure it as 'dynamic ram 1'.
> 
> The specification requires that volatile capacity starts at DPA 0 and pmem
> starts at the DPA immediately following it, but DC partitions only need
> to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> So a device could leave a gap between ram/pmem (static) capacity and its first
> DC partition, or between one DC partition and the next.
> 
> However, Linux follows the precedent set by PMEM/RAM partitions and requires the
> first DC partition to begin at the DPA immediately following static
> capacity.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> 
> ---
> Changes:
> 1. mbox.c: validate only the first DC partition. Other partitions are read
>    to make it easier to add support for additional partitions but not
>    checked. Richard/Alison
> 
> 2. mbox.c: rework the cxl_dc_check() validation. Run the checks in
>    dependency order -- block size, decode length, length, base -- so the
>    block size is validated before IS_ALIGNED() uses it as an alignment,
>    and give each failure its own message naming the field that is wrong.
>    Drop the block size alignment requirement on the region base; CXL
>    r4.0 Table 8-347 requires the base to be 256M aligned and states the
>    block size alignment for extent start DPAs, not for the base.
>    Reported by Alison.
> 
> 3. mbox.c: range check the number of available DC partitions reported by
>    the device. CXL r4.0 Table 8-346 requires a DCD to report between 1
>    and 8 regions, but the count was used unchecked as the read loop
>    bound, so an out of range value failed later as "Invalid num of
>    dynamic capacity partitions". Reported by Alison.
> 
> 4. mbox.c/pci.c: cxl_configure_dcd() returns an error instead of void,
>    and cxl_pci_probe() decides what to do with it. Failure to read the
>    DC configuration is now reported rather than silently swallowed;
>    -EINVAL for a partition overlapping static capacity, -EOPNOTSUPP for
>    the gap Linux does not support, and the mailbox error propagated
>    otherwise. cxl_disable_dcd() moves to the caller so the function
>    reports and the caller sets policy. Probe still continues without
>    DCD rather than failing the memdev, which would cost the device its
>    static capacity too. Reported by Jonathan Cameron.
> 
> 5. mbox.c: check the block size is a power of 2 in 64 bits.
>    is_power_of_2() takes an unsigned long, so on a 32 bit build blk_size
>    was truncated to its low 32 bits and a value such as 0x100000040 --
>    non-zero and a multiple of 40h -- passed validation. CXL_BUS only
>    depends on PCI, so this builds on 32 bit. Reported by Sashiko.
> ---
>  drivers/cxl/core/hdm.c    |   2 +
>  drivers/cxl/core/mbox.c   | 235 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c |  37 ++++++
>  drivers/cxl/cxlmem.h      |  55 +++++++++
>  drivers/cxl/pci.c         |   6 +
>  include/cxl/cxl.h         |   3 +-
>  6 files changed, 337 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..0ef076c08ed2 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -446,6 +446,8 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
>  		return "ram";
>  	case CXL_PARTMODE_PMEM:
>  		return "pmem";
> +	case CXL_PARTMODE_DYNAMIC_RAM_1:
> +		return "dynamic_ram_1";
>  	default:
>  		return "";
>  	};
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 199bb986d674..a484e23b2b3a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1349,6 +1349,241 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return -EBUSY;
>  }
>  
> +/*
> + * A partition unavailable for Dynamic Capacity reports zeros for decode_length,
> + * length, and block_size.
> + */
> +static bool cxl_dc_partition_unavailable(struct cxl_dc_partition *dev_part)
> +{
> +	return !le64_to_cpu(dev_part->decode_length) &&
> +	       !le64_to_cpu(dev_part->length) &&
> +	       !le64_to_cpu(dev_part->block_size);
> +}
> +
> +static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> +			struct cxl_dc_partition *dev_part)
> +{
> +	u64 blk_size = le64_to_cpu(dev_part->block_size);
> +	u64 len = le64_to_cpu(dev_part->length);
> +
> +	/*
> +	 * Not an error; leave the entry empty. A partially zeroed partition
> +	 * is rejected by the checks below. CXL r4.0 Table 8-347.
> +	 */
> +	if (cxl_dc_partition_unavailable(dev_part)) {
> +		*part = (struct cxl_dc_partition_info) { };
> +		dev_dbg(dev, "Partition 0 unavailable for DC\n");
> +		return 0;
> +	}
> +
> +	*part = (struct cxl_dc_partition_info) {
> +		.start = le64_to_cpu(dev_part->base),
> +		.size = le64_to_cpu(dev_part->decode_length) * CXL_CAPACITY_MULTIPLIER,
> +	};
> +

Hi Anisa,


I think this might have overflowing issue, if decode_length = 0x1000000002 , it produces
2^64 + 512 MB, which wraps to 512MB in u64. The following check wouldn't reject such case.

Maybe a check_mul_overflow() here ?


> +	/*
> +	 * Block size is a power of 2 and a multiple of 40h. is_power_of_2()
> +	 * takes an unsigned long, which truncates blk_size on 32 bit.
> +	 */
> +	if (blk_size == 0 || (blk_size & (blk_size - 1)) ||
> +	    blk_size % CXL_DCD_BLOCK_LINE_SIZE) {
> +		dev_err(dev, "DC partition 0 invalid block size %#llx\n", blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (part->size == 0) {
> +		dev_err(dev, "DC partition 0 zero decode length\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len == 0) {
> +		dev_err(dev, "DC partition 0 zero length\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len > part->size) {
> +		dev_err(dev, "DC partition 0 length %#llx exceeds decode length %#llx\n",
> +			len, part->size);
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(len, blk_size)) {
> +		dev_err(dev, "DC partition 0 length %#llx not a multiple of block size %#llx\n",
> +			len, blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(part->start, SZ_256M)) {
> +		dev_err(dev, "DC partition 0 base %#llx not aligned to 256M\n",
> +			part->start);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "DC partition 0 start %#llx size %#llx blk_size: %#llx\n",
> +		part->start, part->size, blk_size);
> +
> +	return 0;
> +}
> +
> +/* Returns the number of partitions in dc_resp or -ERRNO */
> +static int cxl_get_dc_config(struct cxl_mailbox *mbox, u8 start_partition,
> +			     u8 partition_count,
> +			     struct cxl_mbox_get_dc_config_out *dc_resp,
> +			     size_t dc_resp_size)
> +{
> +	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
> +		.partition_count = partition_count,
> +		.start_partition_index = start_partition,
> +	};
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in = &get_dc,
> +		.size_in = sizeof(get_dc),
> +		.size_out = dc_resp_size,
> +		.payload_out = dc_resp,
> +		/* The device must return at least the fixed header */
> +		.min_out = sizeof(*dc_resp),
> +	};
> +	size_t expected_sz;
> +	int rc;
> +
> +	rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* A DCD reports between 1 and 8 partitions */
> +	if (dc_resp->avail_partition_count == 0 ||
> +	    dc_resp->avail_partition_count > CXL_MAX_DC_PARTITIONS) {
> +		dev_err(mbox->host,
> +			"Device reported %u available DC partitions, expected 1 to %u\n",
> +			dc_resp->avail_partition_count, CXL_MAX_DC_PARTITIONS);
> +		return -EIO;
> +	}
> +
> +	if (dc_resp->partitions_returned > partition_count) {
> +		dev_err(mbox->host, "Device returned %u partitions, requested %u\n",
> +			dc_resp->partitions_returned, partition_count);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * The payload carries trailing extent/tag count fields after the
> +	 * partition array (CXL r4.0 Table 8-346) which the driver ignores, so
> +	 * the response is at least, not exactly, expected_sz.
> +	 */
> +	expected_sz = struct_size(dc_resp, partition,
> +				  dc_resp->partitions_returned);
> +
> +	if (mbox_cmd.size_out < expected_sz) {
> +		dev_err(mbox->host,
> +			"Payload size %zu less than expected %zu for %u partitions\n",
> +			mbox_cmd.size_out,
> +			expected_sz,
> +			dc_resp->partitions_returned);
> +		return -EIO;
> +	}
> +
> +	dev_dbg(mbox->host, "Read %d/%d DC partitions\n",
> +		dc_resp->partitions_returned, dc_resp->avail_partition_count);
> +	return dc_resp->partitions_returned;
> +}
> +
> +/**
> + * cxl_dev_dc_identify() - Reads the dynamic capacity information from the
> + *                         device.
> + * @mbox: Mailbox to query
> + * @dc_info: The dynamic partition information to return
> + *
> + * Read every partition the device reports, but validate only the first:
> + * Linux maps partition 0 and nothing else, so a defect in capacity the
> + * driver never touches is not a reason to refuse the device dynamic
> + * capacity.  The remaining entries of @partitions are left unset.
> + *
> + * Return: 0 if identify was executed successfully, -ERRNO on error.
> + *         on error only dc_info is left unchanged.
> + */
> +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> +			struct cxl_dc_partition_info *dc_info)
> +{
> +	struct cxl_dc_partition_info partitions[CXL_MAX_DC_PARTITIONS] = { };
> +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) = NULL;
> +	struct device *dev = mbox->host;
> +	u8 start_partition;
> +	u8 num_partitions;
> +	u8 partition_count;
> +	size_t dc_resp_size;
> +
> +	/*
> +	 * Bound requested number of partitions by mailbox payload size. The
> +	 * 256 byte spec minimum, verified in cxl_pci_setup_mailbox(), keeps
> +	 * the subtraction below from underflowing.
> +	 */
> +	partition_count = min_t(size_t, CXL_MAX_DC_PARTITIONS,
> +				(mbox->payload_size - sizeof(*dc_resp) -
> +				 sizeof(struct cxl_mbox_get_dc_config_tail)) /
> +				sizeof(struct cxl_dc_partition));
> +	dc_resp_size = struct_size(dc_resp, partition, partition_count) +
> +		       sizeof(struct cxl_mbox_get_dc_config_tail);
> +
> +	dc_resp = kmalloc(dc_resp_size, GFP_KERNEL);
> +	if (!dc_resp)
> +		return -ENOMEM;
> +
> +	start_partition = 0;
> +	num_partitions = 0;
> +	do {
> +		int returned, rc;
> +
> +		returned = cxl_get_dc_config(mbox, start_partition,
> +					     partition_count, dc_resp,
> +					     dc_resp_size);
> +		if (returned < 0) {
> +			dev_err(dev, "Failed to get DC config: %d\n", returned);
> +			return returned;
> +		}
> +
> +		if (returned == 0) {
> +			dev_err(dev,
> +				"Device reported %u partitions available but returned none at index %u\n",
> +				dc_resp->avail_partition_count, start_partition);
> +			return -EIO;
> +		}
> +
> +		/*
> +		 * Only partition 0 is mapped, so it is the only one checked.
> +		 * The rest are read to complete the enumeration and dropped.
> +		 */
> +		if (start_partition == 0) {
> +			rc = cxl_dc_check(dev, &partitions[0],
> +					  &dc_resp->partition[0]);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		num_partitions += returned;
> +
> +		if (num_partitions > CXL_MAX_DC_PARTITIONS) {
> +			dev_err(dev, "Invalid num of dynamic capacity partitions %d\n",
> +				num_partitions);
> +			return -EINVAL;
> +		}
> +
> +		start_partition = num_partitions;
> +
> +	} while (num_partitions < dc_resp->avail_partition_count);
> +
> +	/* Linux only supports the 1st partition; nothing to do if it is unavailable */
> +	if (partitions[0].size == 0)
> +		return -ENODEV;
> +
> +	*dc_info = partitions[0];
> +	dev_dbg(dev, "Returning partition 0 %#llx size %#llx\n",
> +		dc_info->start, dc_info->size);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dc_identify, "CXL");
> +
>  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..fdd6b395dcdf 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -643,6 +643,43 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> +{
> +	struct cxl_dc_partition_info dc_info = { };
> +	struct device *dev = mds->cxlds.dev;
> +	int rc;
> +
> +	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
> +	if (rc) {
> +		dev_warn(dev,
> +			 "Failed to read Dynamic Capacity config: %d\n", rc);
> +		return rc;
> +	}
> +
> +	if (dc_info.start < info->size) {
> +		dev_err(dev,
> +			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n",
> +			dc_info.start, info->size);
> +		return -EINVAL;
> +	}
> +
> +	/* A gap between static capacity and the DC partition is not supported */
> +	if (dc_info.start > info->size) {
> +		dev_warn(dev,
> +			 "DC partition 0 base %#llx leaves a gap from static capacity ending at %#llx\n",
> +			 dc_info.start, info->size);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	info->size += dc_info.size;

Overflowing issue issue as well.

With 2 GB static capacity, DC base = 0x80000000, DC size = 0xffffffff80000000.
The placement checks pass but the total wrpas to 0.

Maybe check_add_overflow() and return an error before changing info->size .

Best regards,
Richard Cheng.

> +	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> +		dc_info.start, dc_info.size);
> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_configure_dcd, "CXL");
> +
>  
>  /**
>   * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0c8e23276dc6..4fac65dbb808 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -407,6 +407,8 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };
>  
> +#define CXL_MAX_DC_PARTITIONS 8
> +
>  static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  {
>  	/*
> @@ -689,6 +691,39 @@ struct cxl_mbox_set_shutdown_state_in {
>  	u8 state;
>  } __packed;
>  
> +/* See CXL r4.0 Table 8-345 get dynamic capacity config Input Payload */
> +struct cxl_mbox_get_dc_config_in {
> +	u8 partition_count;
> +	u8 start_partition_index;
> +} __packed;
> +
> +/* See CXL r4.0 Table 8-346 get dynamic capacity config Output Payload */
> +struct cxl_mbox_get_dc_config_out {
> +	u8 avail_partition_count;
> +	u8 partitions_returned;
> +	u8 rsvd[6];
> +	/* See CXL r4.0 Table 8-347 */
> +	struct cxl_dc_partition {
> +		__le64 base;
> +		__le64 decode_length;
> +		__le64 length;
> +		__le64 block_size;
> +		__le32 dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed partition[] __counted_by(partitions_returned);
> +	/* Trailing extent/tag count fields unused */
> +} __packed;
> +
> +/* Trailing counts; cannot be a member after the flex array above */
> +struct cxl_mbox_get_dc_config_tail {
> +	__le32 num_extents_supported;
> +	__le32 num_extents_available;
> +	__le32 num_tags_supported;
> +	__le32 num_tags_available;
> +} __packed;
> +#define CXL_DCD_BLOCK_LINE_SIZE 0x40
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -812,9 +847,18 @@ enum {
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +
> +struct cxl_dc_partition_info {
> +	u64 start;
> +	u64 size;
> +};
> +
> +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> +			struct cxl_dc_partition_info *dc_info);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>  						 u16 dvsec);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> @@ -828,6 +872,17 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  			    const uuid_t *uuid, union cxl_event *evt);
>  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
>  int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
> +
> +static inline bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> +{
> +	return mds->dcd_supported;
> +}
> +
> +static inline void cxl_disable_dcd(struct cxl_memdev_state *mds)
> +{
> +	mds->dcd_supported = false;
> +}
> +
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..2fe9db4b3d86 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -868,6 +868,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	if (cxl_dcd_supported(mds)) {
> +		rc = cxl_configure_dcd(mds, &range_info);
> +		if (rc)
> +			cxl_disable_dcd(mds);
> +	}
> +
>  	rc = cxl_dpa_setup(cxlds, &range_info);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..4ef9511fbbdd 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -133,6 +133,7 @@ struct cxl_dpa_perf {
>  enum cxl_partition_mode {
>  	CXL_PARTMODE_RAM,
>  	CXL_PARTMODE_PMEM,
> +	CXL_PARTMODE_DYNAMIC_RAM_1,
>  };
>  
>  /**
> @@ -147,7 +148,7 @@ struct cxl_dpa_partition {
>  	enum cxl_partition_mode mode;
>  };
>  
> -#define CXL_NR_PARTITIONS_MAX 2
> +#define CXL_NR_PARTITIONS_MAX 3
>  
>  /**
>   * struct cxl_dev_state - The driver device state
> -- 
> 2.43.0
> 
