Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7C23909F;
	Thu, 13 Aug 2026 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629216; cv=fail; b=h4ESRIyr9HhKXf6TosA8wGhTvySwJ8d7e4tJE6hWydwCGeYA15bP3fHpuhkqH0PPKEysgYLfYr7E4FRa+MVT251a+eGitwAz6j+lYHv/xobYycuOgXwdFAuL4IrcRSi2kmMHEPGG46HFQOUreU8u5jEtA+JSVNu2032F7kOcUwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629216; c=relaxed/simple;
	bh=F5izCJLVdVd5RqwkGWzgNx25o19zaspJqa0ThDQlchI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OgcG/dTZZjqNxwLxlwXTxpUdsEJ1z2ch/xUCSS4QwzNPS8tpP7GjoUfeqvW6sEmhG/68GzjqpDteFbadA+Hbo5lAnS5TWz4Rc5pwkUtrG2Lrwroj8OSwC7DvgaMB5WEXv7b0qDb4PYW705blVaBI8spTIjm0bixxCPIELUtmkzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jaHDyEDL; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jaHDyEDL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2tjtt0sDfm1qKSV1TRgyyeq1xib0kAE9GjR1X2ZzBYyhlmsHx2TmTYWvIrW86GvbY59rn2Mv7vHyOxG9ICu2Nl2wESrYZDuYk9SrR3knghHyjeoth4LVXDAaC8mnUaxycBjLfbQWxHFI+Mha0mKEKJe5N8ZUg9Y+5/N6IFj6OfB8PfhsZ0yQZH+IfPU/QGD7+/e159xt7nNrIPOxWOv+xaj4Focm4xt77E8MS6Egzf3vQFRoC+LJHvuFFREJ7tiIYEp0TNyJgHbwnq8UtVwALCejYGLEh0CSwVKXUBo5Sza3qLGUZCWh9lmE1tnVqQ1kKte7uj06Yozr8eP4N5kUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnfOMcEcrRvNTDmw8FkR/grQbQp9wd6Cvd53bo41gb0=;
 b=gurSlH7fgSs9uIos66ZtwT53/SWi1mXw2PIkI0CvtPC2mGNsrYvtaH6rZbw37eobxwjxFcT+3z7KNvVoWGgFhifsPjfBLhCRGUzqbSad9dyU9grnAABCbXx46wCkkrnwKboH2YcZpYgFrc1mtVyQr5wQ+CNpKn+bW1rSF1wat0zJfb+36/WoxfrjhHHAzRi+d+bmvbRNBXwzunmMrcfsOphHqODLp7FJm9z795XlrWVZRmv44W5U38HON/2Dha88cxWsgMPbDB8Nen+pwHHdXqbzmZjGN0TL50vTDp0Dsvsdpyl0zvMLvz6N8ErQ6JMhjYMRALq5b9SMjK4CZ8KxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnfOMcEcrRvNTDmw8FkR/grQbQp9wd6Cvd53bo41gb0=;
 b=jaHDyEDLHGY/26Ti3Oi+wIXSzvcW9xU8o1YKrHpcq52HMiRotpkwAQaCrxC/MQ4KKm3x77+SNwfbLTNDozmYNW+qX1GO/pqp5nx5/Q9xQD7GS1/Zfppr8RgaucZttRTLD0ean1oN3J0ivcLtuQpmBIqY3qQT+hyaDvm9ipB/Lsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Thu, 13 Aug 2026 13:53:28 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 13:53:28 +0000
Date: Thu, 13 Aug 2026 15:53:23 +0200
From: Robert Richter <rrichter@amd.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	djbw@kernel.org, iweiny@kernel.org, ming.li@zohomail.com,
	gourry@gourry.net, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, newtonl@nvidia.com,
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH v2] cxl/region: Add cxl_decoder_is_passthrough() helper
Message-ID: <an3MU6_wgm1E6L-Q@rric.localdomain>
References: <20260805065935.27837-1-icheng@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805065935.27837-1-icheng@nvidia.com>
X-ClientProxiedBy: CPCP307CA0006.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::8)
 To DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 396075a4-b687-4d13-3d18-08def94240be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SfnCOK8mn3riU+dnnBppmVfNPiHTnFOK789P9RwFK6/y1s1khK/gCRwoVwd172WGFSIRMjdkhUEhjtAoSHJrS/EeS8U1Znac68Om6t2BqOUrMbq8lUX78Vrx6NzCpSLX9RO6ZDsoqVgVATgZgQJFGG1P7rKoZKzvaLG9N3Heju22FR6qSXXXwj6wTc1ScIlu/GGfElfFKtU7iX3B5epOyrsdZ9FzmRh6it2drUeGhtdQmu/axSrezWOf7iuhAsMnyRKVVsPD4uFgqrbqzMvEYaaVyq46Iqe0b1stnAQEszWi8MOQxbzH7vADQbk+lbB44ZxBPy/keWbQra3FHvEsbkbmpElJAjkbobKob2U8/RRyGg92ogIhbX7caX+siYExlvV3M3Y4aM015IRY5xLhwiiPraRIwFx6AThveRCxfjTE8jGirq15+xFt1ba1PuJjy3hlufc5aR4m94A61RCTAyMM75FXnqHhTbSvWuC3b57/DXQYuZB/irN9MAa0+quK2E0IXa+DS2ikoGL2J901HGRPDnFbgC2+00sY9+tjtEAiPw88KCa94XfM55ex8hvs2R432+f7wHVb9Nbubzk/X8EC2bd4+kFOxXIc5v9LSKjAt3hCyPvs7nAFH8VdZgLG2MIpnkQMKgAf5i8XGf5Uu2Ht226cQLWDiMWnQbY8epo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OLToinONOW9CNEni4Dauq1XcMX4XCIEjGBCCOVa3Lsf0NaIRgCj0yCl8wstM?=
 =?us-ascii?Q?6vAo5AJrLu/sv4jzT9f3Y0evsLlnAfbOx8jF3tDyV7Txn5f17KB24jYB2fIi?=
 =?us-ascii?Q?AdUNKTcW5RljrPuNLwy5irqU6tyTFwO8DWzsbMtIJ9PHNDbqf14eFGN2I42+?=
 =?us-ascii?Q?BOsmXUGMSg+tRWaZbqOX35I4u3OLKONQ9UoNeY+DpNYhcfHBwUSwkrK8oi7m?=
 =?us-ascii?Q?eJSh5xGQQIz1m3tB8QsqTlZT5VYUqUvSQzBPFPgUAEx8FowR2CthkQ4cPuJY?=
 =?us-ascii?Q?xH6Uir6OKGd6T3WT1NqF9pwcREn453RQDrgAbHQdB5I+eYnx5IUCIcZRFwgV?=
 =?us-ascii?Q?5856pSg3UzjFDYj2hLPLb80L5Tv/dRzbU8YOG28UI2mYQTC01ixBBkMxdPvN?=
 =?us-ascii?Q?pfMytaA1emk4lOMWfVMUq6qfVbxehD8pF4lBTc25frDq3pIZ0g9S7+QC+0jI?=
 =?us-ascii?Q?nRyak1m7lqPlPB6kML7GkwNbvZyYsmSbckfW+hugIU+LYyQT9FKBksmH/2Aa?=
 =?us-ascii?Q?w8VVdcMVQZPNxU+XkfdOlzLFyJIV+bCze1fTWRWM2vDdOgvOff1ZW+5RKGjT?=
 =?us-ascii?Q?j4YhFsl7OQ3Ejt9zhtu1lqtbcGOOCGfDG2X87hh9KRia7s+hSF6jLOB5uL5U?=
 =?us-ascii?Q?zdk6PIlpbDRf08xhp0mI//CS3tj1HldCA94ohLmFbG8GtNF1DBSIYAid8QRj?=
 =?us-ascii?Q?aBDf70MCaqTMCPSa46IBGOH+I8y/WVeVd1im/lz6q9/YQGuwZz5HS80SMLir?=
 =?us-ascii?Q?KB2JQMTmYXBOuFZhYAbXaRV2t6Vae5zI3Nu0GgI3jyzL5WdHx58f+HZXBmAG?=
 =?us-ascii?Q?aJNQudDuHAH73ylws6hzDm1Hnv4Z6Sdfr+lMwXcoi7Ib4RzFsmuzD6jisjcd?=
 =?us-ascii?Q?UN0VvtYsLoojdDlGt7kXYGfXveOdUzp+U6tgI/DesMa7d4/nW4hQM4bMBlTN?=
 =?us-ascii?Q?UPAHIoMeKRBhlL7hfm5/8zHzkSbGPOeWg3UAQC8vsujDT1wBPuiwzm31Rdi/?=
 =?us-ascii?Q?Q+YAC48GXK6xnKuWv+ySxwAfRBEaVLGHxBeFPJGHsZvboUSMk7WneuBMXltr?=
 =?us-ascii?Q?UBHWb75CRUawZt5aB0ZLufAn78koFMEHPNIj/+HifSM8Azvr+UXw4nEYoWeL?=
 =?us-ascii?Q?dG6ooRfLU+pJ1HVgEGpgRtE8NAHcauMQdQoIFWS40RfbUSEEHhIcC+MbuNZV?=
 =?us-ascii?Q?70BDYWwXYeG7RmZy5ypaXtVGzywhaYVMUNNHqnHkHgqtzP70a41r+269oETw?=
 =?us-ascii?Q?hy1WJIqHpSxGDUuiB5RCP384MlFW2FJQFv2KPPvArlbFMCoaItgUwp9m5IO9?=
 =?us-ascii?Q?dvWF0VZF1hBKgxx62u0QC8HbzuFzXvzeQ/wHtgNpZX1GNWDGtHsXpgsGEPiK?=
 =?us-ascii?Q?OSTHxbR+rMjTeNKaCVlER3k1mqT5qUsT3mstW26g4vUtudQrR78gMfSZ9ewP?=
 =?us-ascii?Q?cYONkFSxcva1HSqLez/pyfZZpIDQFWkEtbst1EhFp09HI7D7Bg4U5oh5koXw?=
 =?us-ascii?Q?yqq0hmyQsr4XnfAPEhH36HELlQy+fDZtBBEOc0PgTwjDccX9iPdzXceMu2ro?=
 =?us-ascii?Q?gdrunXHptEQqPi7Lw35S9VbVv9nMNT7gkU3zAnFcnywhxQTYQMeEB6pHwa9n?=
 =?us-ascii?Q?Cbuld8amRV5He1+fQXw9fzv0V0PBh7YACdcT3SrCUUNFVq3eftlzLdAW49Pl?=
 =?us-ascii?Q?NMqLJEIXPFR4Rca0PDSKkPMLyG7EqfP+dQVyzLqZ4YqGp4CO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396075a4-b687-4d13-3d18-08def94240be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:53:28.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxkH+J2G6FevGevrMPA5iyJNbwuG0TEs8Xj2FliXWy8SiBh1mtyHA4bMauZ+u5p67/K5/aTvUF90+t/HMoCHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

On 05.08.26 14:59:34, Richard Cheng wrote:
> commit_decoder() open-codes the passthrough test.
> A NULL ->commit() plus a switch decoder with at most one target. The
> call site is hard to read, and it suggests a NULL ->commit() alone
> identifies a passthrough decoder. It does not.
> DVSEC-emulated endpoint decoders also leave ->commit() NULL, and root
> decoders never set it. A future caller testing ->commit() alone would
> silently include them.
> 
> Move the test into cxl_decoder_is_passthrough() and document what each
> condition rules out. The helper runs the same tests in the same order,
> no functional change.
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
> 
> v1 -> v2:
>     - Dropped the passthrough F_ENABLE restore patch. The bug was
>       already fixed.
>     - What remains is only the clarify helper function patch, so the
>       patch is retitled accordingly
> 
> v1:
> https://lore.kernel.org/linux-cxl/20260727103743.63343-1-icheng@nvidia.com/
> 
> Best regards,
> Richard Cheng.
> ---
>  drivers/cxl/core/region.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..cd73684fbe97 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -293,17 +293,33 @@ static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>  }
>  
> -static int commit_decoder(struct cxl_decoder *cxld)
> +/*
> + * A single-dport host-bridge need not publish an HDM decoder capability
> + * when passthrough decode can be assumed. The resulting decoder is a
> + * software-only construct with no registers to program, so it carries no
> + * ->commit() operation, see devm_cxl_add_passthrough_decoder().
> + *
> + * A NULL ->commit() alone does not identify one, it is also NULL for
> + * DVSEC-emulated endpoint decoders. Test the decoder type and target
> + * count as well.
> + */
> +static bool cxl_decoder_is_passthrough(struct cxl_decoder *cxld)

This is much noise for just checking if ->commit() is required in some
cases and generate an error if not.

>  {
> -	struct cxl_switch_decoder *cxlsd = NULL;
> +	if (cxld->commit)
> +		return false;

That duplicates the test and the code is never executed.

> +
> +	if (!is_switch_decoder(&cxld->dev))
> +		return false;
> +
> +	return to_cxl_switch_decoder(&cxld->dev)->nr_targets <= 1;

cxlsd->nr_targets is easier to read and explains that nr_targets is in
struct cxl_switch_decoder, which wouln't be obious else. So the change
does not improve readability and instead does multiple things in a
single line.

> +}
>  
> +static int commit_decoder(struct cxl_decoder *cxld)
> +{
>  	if (cxld->commit)
>  		return cxld->commit(cxld);
>  
> -	if (is_switch_decoder(&cxld->dev))
> -		cxlsd = to_cxl_switch_decoder(&cxld->dev);
> -
> -	if (dev_WARN_ONCE(&cxld->dev, !cxlsd || cxlsd->nr_targets > 1,
> +	if (dev_WARN_ONCE(&cxld->dev, !cxl_decoder_is_passthrough(cxld),
>  			  "->commit() is required\n"))

The original was pretty straight forward: if it is a switch decoder
with multiple targets, raise an error. It looks like an assert here as
!cxld->commit is only created in devm_cxl_add_passthrough_decoder()
which sets the number of targets to one (not looking into test code
here, but if that causes an issue, fix it there).

So I don't see much sense in this patch.

Thanks,

-Robert

>  		return -ENXIO;
>  	return 0;
> 
> base-commit: 212e015fc34712c849653cdb3179cd643c915015
> -- 
> 2.43.0
> 
