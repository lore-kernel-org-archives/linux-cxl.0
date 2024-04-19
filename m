Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2097.outbound.protection.outlook.com [40.107.100.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBADF42AB3
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544783; cv=fail; b=gKiATlJvstSWcRs7qq3fkC923PZ8FRZeDL8QbuPQ3cadP7DeShrI6dSItA8I2AVSNf6n+mXX5oOnFZejsrsg/ckjuppZnqOiOf78wsL6fpgWWsGSZgyWLlSbypW2Ev43+trR3TVOdDz6skG9GM5hzXuhs97M+SxpdKt1OuVJcPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544783; c=relaxed/simple;
	bh=zVMlqI2k+EQbu6T+3X29HOTPuBJfXnMD7Ua3JQd2GEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Db6FWEBYmq3hte2oFtcrAkETK98v4xCyT74dGmrCeRX/6UGritNiPWnkZ0/4somnLD+cW5qgmoZBFhvV8jMl7s1Y5r7naX/de/lbaL82TWWlCIZ+u3tcJUZuffdPrPpjtfyb5u4TM0lIYaJ7j/vmxTTYUvIojRSFJbwukU23JM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=GzOftKV8; arc=fail smtp.client-ip=40.107.100.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="GzOftKV8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvowDMwq3R8nCZXW53vfE5oHBqsRvF5E49CoqN9esK+5kGaQmY7Vy2/0mM5V86KfADaEZEwQHlsaVBoXdFjPA3ZhgySO0424A0V5l9qDEVOfRR3kg9PLMJMP77HRg2ei+9aK8sU3+qNuV8xoor6tgfP1nuh67DfUO3LrWqOdWlGJNmPHLeqL/YdByuUpB8l8Ws6icYg8DNU4wqK1ho98Z1Y4WvaoiFnsZ1gvGIl7LamfDo1tc2MHalETB5IzuHbNEXKVpqh3DulmnE8m7HHw/y2eSfi3PKN+zT25Lwr0CbNXESnlQ5CQMjhjjBTAiBF9r1NdWMHrz7pnZnYoNHFH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3Y/e5yu19wTE/p5lOjqbMZJjmFaLOKjUfGcV33X9ZU=;
 b=iHSDYe7Q1bjAV02hOiK72eZVg73H4aLXQ/8dq++D7YtOwJgXEhWsJMPGauIX0e56Pi1Dx1ziQ3YcEbQXgdBIyESQ/UewLqtK/s1QSB5S4kqd8LNoDot2Jg91UrQHHdprNFf78cli3Cciq+R5UXy8w9HwZxYjE+bHzSmeH7H95Nnz2y2XfFCo5AYqd2C+xMB38ZU4hW3JvC8eqwMR3S9cCJuZqc12kgCaOQfyMbW7AP6crqNSh7j8fSUvHTDu4VRDXCm2/4x7UbTU2OggX1vDAYLkSDlhtchUtI6RHKfzji1gBihmWfvd7DVYI8WJpi8fA0N6vKw4OsDHY3aoBA/EuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3Y/e5yu19wTE/p5lOjqbMZJjmFaLOKjUfGcV33X9ZU=;
 b=GzOftKV8Gn/8IuPxVep/ZK6bGEkhLn37rUGqczkDML7R6R3A93bDXA7g/ZQhn//I+WGOiX7StI3CMm5T+5KnngEiCyFdMd7VH/PFMnJ/cy+JUEDML+/X79bdiKErp7uv9kFWKPmWeJ9/v1/mkZ5sXhLvku/fkqMTaRAAMEdrlnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB5105.namprd17.prod.outlook.com (2603:10b6:806:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 16:39:37 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 16:39:37 +0000
Date: Fri, 19 Apr 2024 12:39:33 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 05/12] hw/mem/cxl-type3: Refactor
 ct3_build_cdat_entries_for_mr to take mr size instead of mr as argument
Message-ID: <ZiKeRZ8Ju9/0dOV2@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-6-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-6-fan.ni@samsung.com>
X-ClientProxiedBy: PH8PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::22) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc42fa4-4f46-4c6c-3934-08dc608f4d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AfbuwXICU6x5bvtwMXEWMEhBnI8pNayK7ueaVddGBtz6zu5uvkWm5glkVXKCVoJDRTdHqKqbkEflDfonKR/TncePnglbPn5TzokiwsBzkZEOr1I4GZdQUnSGdyBeyLjrk9tBgrYBIuaqQhKZB2VEcWd2lKAskRFa3bXXOOO82JAmjrla1ymh7GuHr9mwoF1HJhjVqBWiEHKv1/a90DdAt80KcAdVhE3Lvbv4sT69Ci1KWtfoaKYa55gao9WqpDG/DjvF8RxqKOH4exQj3UBh2tXTRNL0VC0Vnw5SnPbE3P2VIqKkkuEgadLFYEU8cnKgRlxDSRnZKnp2zFkkEDhqJaMByUk95eM0eU64cxScgTV5s4wGN90XHfW2dF/ag7B+P34NDrJTja0KIzz76dhE0OoIsAFLxMEmiflaoLoUuWp5WMvzmevBO3PoPeyOPm3CIVzduRGukI6tBg1y/sQ0wzXhepVlToUrDO4JFBN0Fgdh3sJ8j5imelx6HNI6YID2mo+59lAgI2zJMFFfZKHDqZHI0qnnT65zxCyvkO+Gws/BhQoNIOcmapik0xr67M0JJW1tWsKsMsHeiJY8hoGRBuc7JzVPcRL0mOkyGOOEnEQg/HPzO36diaZBDs6E3zD1DauzKZZgge/M8PDlL81zGRI3FAOttOHnIRgQqGxeuDo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9UlhqDk04piXP5tT1jxnf25TLAIi/EprESnF2aIvvU0BOFDB126Akdt4v+f1?=
 =?us-ascii?Q?c/GrHb9QH6FIMlsypgmx+9r9+6L/6zgMEdcoygPfgvIzDAaZ+Vvkl5utCT3T?=
 =?us-ascii?Q?m/B4id6Dsg8RzFjmb4t890Grjejssuw3YUQ9f8cVcqmhksY9GNmci9Z9/c7b?=
 =?us-ascii?Q?xYv3bDsBrzVHLRLOdT0OEOeUmfzE8VBNBn478I6U30ch6cU1LVT1+iRKN12F?=
 =?us-ascii?Q?fVF+DxWd6EnlbqB15Z4wJd9Pkud5594Nf51oqKewXMMw7AfHINrGYibA+x30?=
 =?us-ascii?Q?mpG6+czRYUpHR98Z2yd/SjEOkn6gZufde0oL5JtQw4k46bNY5EPvqbH57Q0v?=
 =?us-ascii?Q?ZLeD2AYVRzvgVxfBkqGSoZ8l3PYFVAtmKHx16pZORSE49bIHnrD/QRjhIQPo?=
 =?us-ascii?Q?sv4wZIiMyOUJjMt/Jp7i+7KXZgzF/FwnDuinpgkI+TH7iYTOINNsmFOABZmu?=
 =?us-ascii?Q?5Ljcax9TjP8HGAj9hTvxpEZMa/zfqSz8qMOthWtgw4SAZ1e25zo268n6ajur?=
 =?us-ascii?Q?wvWTB+Kpu9GIBhzy1ArQhUFMqqjjA+M2TCYlWTmdycoUuvHu7XvxM7/E6ml+?=
 =?us-ascii?Q?Mtp2rBXiGkZymTJBdIjyhcuPxqpSIo3hEBuXcGkMA+tDTfK3pDxdZ73vaUZi?=
 =?us-ascii?Q?C+gzjqlq70ZxJxC/pTHu2VSCLzhdvwjah8cEiOTdOdCGh8vgXKMjnv30B+lU?=
 =?us-ascii?Q?oFgwpxhQIWVU69tpmPfOsanGzdj/4hcm9ASOvHUWQ/UY/s41QVgy+w2noSwv?=
 =?us-ascii?Q?2aelLgj27f58kNESOK3H+1/WAeBhSDwIgngQiGX4atVKyfMZNR0vvrBSuFvR?=
 =?us-ascii?Q?32b7BKd5LSI9XNnEaS/LcErme+XKktDHJX7FkmQi/cddhBdyCtc2LGgQa+ez?=
 =?us-ascii?Q?0AZxevbIesOzTco7zM5CM+Ih1EjC65nCfXHHREA2RCkOfnIDx27B2KzYSazP?=
 =?us-ascii?Q?FeK5tSHfMiL7q2aHWZvHgY/jEPxF9pR5NySds2B7hwdbIFEjn6u1RwjuhA/t?=
 =?us-ascii?Q?IBPubS24dH0k4lkHFFP1Vb6bGYIzeBQ2Uw6tvZpgLctctzDk+/buc5Ti4nCc?=
 =?us-ascii?Q?KVHggj1mL+XRlSMZM6WyN685jwoLRjU5jfwQvibcO7CN5kjpw3UFjLKYtTl0?=
 =?us-ascii?Q?mNECqn8iRIAhjl0KcKXg/73SFgXBcTqoXEeG2LFsw7uXuRMfOX8zMFUd528h?=
 =?us-ascii?Q?SwyOR2kKMLHkm86BdseHxaZssOEenlRU0RiSCn9kK2vaVFtxO8X6B70O/bZn?=
 =?us-ascii?Q?CkcWZIFtHFmOu7n9kPcuA6952LxRJpy1DnI4Kg7iTWpLQT5ecQ1DztFUspvp?=
 =?us-ascii?Q?hyyx2u6npWMmk/Wk7IR8amQ9cHc0MUuFTk2bgsCywPR8oLMQzAgQuCutM5i+?=
 =?us-ascii?Q?Q2seYj4hEP1sHunxlnlfC1qVWt1Edm/lnDZC60jfxzfTmM3TRYz9zPoGzPyY?=
 =?us-ascii?Q?kyTaXTRD4GRDFZCe86yFtrdKWwz7nnUAVIU2KxqaonkPai8xSPpFwuVNoIU5?=
 =?us-ascii?Q?E1r1kewqbkbgcs7ak9O4hQLYemgvVQmRdeO8DwPHUlsP7TIeAd9F9MYSYREJ?=
 =?us-ascii?Q?CrbVeWuSp96J5izFu42POtV0pIcYb/iXlS0RB+qPIkwMdzQ2RquJja0G9EUd?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc42fa4-4f46-4c6c-3934-08dc608f4d64
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:39:37.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nwnaFF2YPLWOPtfXQw6RtNhUq7mufNKVi8DoN0OMj1iyVieAHB6YefrUDJZKRn6fdUGnHqgw+BK+R4JDpbvm/qKSOjmKwVqxc1Ae8/d8Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5105

On Thu, Apr 18, 2024 at 04:10:56PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> The function ct3_build_cdat_entries_for_mr only uses size of the passed
> memory region argument, refactor the function definition to make the passed
> arguments more specific.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/mem/cxl_type3.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5ceed0ab4c..a1fe268560 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -44,7 +44,7 @@ enum {
>  };

Reviewed-by: Gregory Price <gregory.price@memverge.com>
