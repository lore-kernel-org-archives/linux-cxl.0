Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7346EC81
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104229; cv=fail; b=VayjWHHyzpBLBg/mZ+wK5d+58dbWpfRMObuMLn9y9hlTha6VLPM0iSu5TxwNuvqtEspXwORQ3sDl3uFxxKaVNtWqFlCI73VpxNssXFqJpnFp2LyyTKfx+t4IEjOxt8mYDuf5/4MZFFzRt2dxxzJADOqr5jpzcz6AXjgcZoSLlSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104229; c=relaxed/simple;
	bh=C+mhmPDkSYYIyRE+EzTbY296vyWenUUoXJDZqfSHZos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oAOnbvRFkLs+66UkthH4nFx1AahdejPJbIv2HY+sUNYnPUSlwTX0Nyr8NyV9k7O0m0J48neY/HD3gPi9Sy5mPwqtEEaowZEjvuPUk6ECmp+nR+Zubq+CiyWddZYIYCAGtWkHHnT0vIhFT+1WOutWCXhW3RvgagPRMhRQBvaR6bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECau496x; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECau496x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yE6spzfXUAMB3S7DANMR2HlgP1jED8eMkXfFkzhp1SZd9x/IFKAZbXivVisbw6WezJe9jYT9sqmr8JRtlZ6RJDboUtZ33/9GR5vn7/y68GxVvMh3u5lxHarVlUdkT4Mxv02L14vO9QtV/yYvi9lpAbupx9cYYyC+gRh7xBIvGcJ16TUWYPLkxYwx4nc87+X41q4Y0jIWX0h1rBpxS4E9c/4M7jzj0JDhYCfr5evjQXSKNd2IE5Lzyyf8IarnjawCGVkF/Z/TT6Tcz/NEAiqloew+r/p4jdEIXnfTU4oCIWfO5nfIbzkDDXxO74Rj/bQk2P7wpvLrakhdUy2yWTxzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RnLVw2/AamGc4lqs+q6J6oszXu54Z0c0iT7JfmC6aM=;
 b=LiT1VH8V1vVNOOF933oJifrwkKq1oyqNz+ttnH5QY3ykBmkt6Nh0tJs2l/IgZ2Z/tuIYe4dFuhLYRj6dEmV/vFVdxq2als0mFcDk3V0XN+sOYcMYOAKUEofNsXkxsaI/mPEDby4VGSdwM7+GRNe4Jh35fqJGM3xUlPSR1P17xG8ACXBWft7SLSol20GExyemfLTDogQhxPQonLz/9tngXQVrzV6LFKUNQPQOXnhXr2Zwhsg7pnNa1osbRTwdtXVvYcQ05AvqPOcl1HQ6AlnD2UqP8I0u9gM71GbnEuv6/5CczmmBYfUojmL3Wvxw3uFldEa6gBAF+EKIw8vjFLthwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RnLVw2/AamGc4lqs+q6J6oszXu54Z0c0iT7JfmC6aM=;
 b=ECau496xCSJkCAnfxceNJJYC9Tddf0HpmJVbWNaKaZi8HlzPPzM4VfLSTVhn8lxzaYNr4ZNoQdhjxlOlawtd3hgRjNIWEd9zSmBhhVUS5lCfcvZCRwnrMqY4yUJExJNk8/ueBYBT55aBIwft/44h23AZR5GfKIaUpX6LHlIuwSGRd5d0s2VpuWGuDO1wtvvkqbIZuRy9CYRXFYlVCg0EMChh+zcAdKCPhRq3vBtRM66x4Mcf5gIqFkrkVJDkKvP8BSQ4YFuitiYvQGyue/pHwaWZqYwbQeZo29+kLizXf5A860Zc46DNcIhxp3bRf4vdVAp4SRBdWgfgDV07b1+1YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 12:03:31 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 12:03:31 +0000
Date: Fri, 7 Aug 2026 20:03:24 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com, 
	benjamin.cheatham@amd.com, alucerop@amd.com, dongjoo.seo1@samsung.com, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 8/8] cxl: Allow auto-committed BI hdm decoders
Message-ID: <anXH5vC_w-iu6_iB@MWDK4CY14F>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-9-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728144136.709882-9-dave@stgolabs.net>
X-ClientProxiedBy: KUZPR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::8) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: b183e6a7-6b63-4544-816d-08def47be635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|5023799004|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	zaSD5fyjdqTZMDNxDs9lH4gxWBn1f/Qs8xl/mG8w1aow8SfuW50ueo61x4yub9hpSRRA1Q2q/cUVwfxui9HXNlD1z+ngYq3cZ0YnsxjCtz1Afk820KvW1NQ26fIki/TDGScz1xbmOycvEd8SmJC9gpcGyaOVge20rJvraW6g69LZ18HpbE/4JLrER+S0PJ5BNPy+GqXtX+j8W0gOX0R5TGWt3kJFObP6ucSZrfjg6x5eNPSOshT2cJZbOrs91zTr6cuH8PnGPS0WG4CIN5o9Msk3Dkl4ITzNER6GPIbPYXpzt8KRZOdULw/ayTwfjXSt9f65oJ+Ex7vbHVjSs79Po/8QWsFYWTaYO+wsXw/8B10rCK0ur84SnRQSCDxMOeLkJF7oVx4hZ3Sl/H7dag5O7ArLyr8kyDz3Ai6hl6tofrzlY427L8InHx+wtEWU9CxBCh1CY4AaujEL6JZ6Ek2qNXw+lO41AEZ0Brk8KdB0az8F6f+wbZga0/w7LO28o5dFS8gPYeACwbkxHYqSBggC+wAFSUzyeZFhsAPqMtVLhI4z8JQ7smktsxkLM9ajonEkq2K7E0gfseXnVV+KXAl1Cr6ZMlWLMc53IwRzmSZwMF8FtTYft+wuZW5nD3uypnNCLfpzWUpzHKpxdGCJCnUQ4IDPM00jYwzPsZVyxAJVCqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(5023799004)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXY1j9lXtfdJJnkypBoDZ9yTNRd9HVTThYT9b7K137ZklgeR7E+bnvURjotS?=
 =?us-ascii?Q?nKPm7JAK0kRSNsK0pd8Emio/nKBef/B++6n1V0Ls+R1Mw7SZHcD+QjC+KqYQ?=
 =?us-ascii?Q?FND7b18/KxwY/gRYHyjCQ4tOei+ep1iW0J6kSooHhVCehD5W00gXwb9ZvEGN?=
 =?us-ascii?Q?/zTkSlG6rhfuyF4VeSJa/OS8vFweGU73WgdkkP2DDIqg1CUU3MIUNvX2LR0E?=
 =?us-ascii?Q?FZLdU1Wx0WoJx3hem6v15SFBImR/nUbP1SlZvgF9aXfGrpkg/eeKj3YmR4BW?=
 =?us-ascii?Q?ediXSgZPQGzc6Sp+P6Bm8WMQB4VxcJz7xnc5arGQGHyZ2E04cUDGuf2OTP11?=
 =?us-ascii?Q?Y9vwMkf5zQH5RZXjVO4ZM/dUxxE+jQyBxCyd2nHIXfbhBGT16P00WHP3fEg7?=
 =?us-ascii?Q?tpetLcl3pVN/USra0gx7zRKu7VPOC0UZXqkfo4UUqe/S1mSqDCUJZH0NLE4s?=
 =?us-ascii?Q?V0DffpOHQoB0F+Uvb86C4vYETIE4lxAdFJjMnYKbMEQUuB+nQ0vnDYjXqYhQ?=
 =?us-ascii?Q?hAvzP95EteTprnU8FyGeCP2dxeVP2gDMgQdbJRiesafhD7jBNgpTyl6cXLNo?=
 =?us-ascii?Q?2kwGTXN+BIpgtHnxNHwP7NsV0QBF6bC56XAsR7iTO9LdzPQyIzwKHzOppoY4?=
 =?us-ascii?Q?mWw67bWKJQTpLazdi0kKLLs03RSA34S0dzNM/kHh2jT2mOR4bL1hsiwKjJVC?=
 =?us-ascii?Q?fzSmzE+wsUnOHlOje/Rf9yu4bTmDslvfnUyXDnkQ8/mxWFvnMosLD4ziB45J?=
 =?us-ascii?Q?UMVHSAIjXqKKoPq0FsdMxJvJXtORc6g2hSRGFaF5ddU8liYGefMCXZWxICvc?=
 =?us-ascii?Q?5Hanx1DBRA9EWlyJxUd+mmcZME8W2fNw+eQpYnbo+7AyxWZnXhyiUvUNgnWD?=
 =?us-ascii?Q?2xkQoWjDWitr/KIL9ZCogTlf6Z4l6faYA1gAtKUVzHfAGJmKFueOiM29j5rS?=
 =?us-ascii?Q?Q4GKTgPxu8D5/3e0RflkZi0Ob+LqvMaME4tasY5I2Ex/YKGY/08oRVi0OlFS?=
 =?us-ascii?Q?C6LyvqvWCujdY+lPSKuppOR0JsUvNePq6QVsOUolLRcmDyQ88p8QC3Wl1PS7?=
 =?us-ascii?Q?Q1PbkLlyVC87aJsvqGy2M38pCTtj4zJmjB2fe+IJPo9xc8cbViYJMYNCg28k?=
 =?us-ascii?Q?vVj4UyQzGHu+Gmph2jxraJ/ItwtMp8EZz8yIx+76in1VkLmL3MJtU4F0k0I4?=
 =?us-ascii?Q?HKs57q3ZYfcfXEyinAvUpTM3+NpM/oE+sz7JPk9gKLj2q1RsjV0V4I1k3JVD?=
 =?us-ascii?Q?hVlQfLRdQ+f5R0PQudjNLsy10IT3jKT7Zwg4k65wkviB/ysO9Q6NLBkhaqmj?=
 =?us-ascii?Q?5AqFGbBsIJyqv9vU9bHQLKr3JDqKy/IkE63M4qrj/gFRu18JvVmnZHSqvf08?=
 =?us-ascii?Q?9+0I8sPgWyadn64QukGNgnmS/lxpYsrXLM9RTooYxOI6BSCjUAz8J/updDkT?=
 =?us-ascii?Q?Uq2AKEApcPEEy2TOV0Dc3Ks5E2MSM7wu5yEZcY0A6MW975+fx+yuz1v8nZuH?=
 =?us-ascii?Q?lNihJIg7JRzsLACzZiPWkwSAkwVqGReV9Gu8ZBLtgTCJmJT9Z4WZeFTnGVlD?=
 =?us-ascii?Q?diw4EfPDxe1FFHq5n0tScSIM3Vf4mAYiO7NQ/uM49wqTErQmiun0WgM9wN35?=
 =?us-ascii?Q?AiPyFqBr3+UPLg3qE4pw6UXDmCWeA9NKEykPsUGq1UaSeiCO7bY3KAVfN87X?=
 =?us-ascii?Q?NELfFVhyw//7vbFr5mqjVuRaLQpYihWH/2/NmpQfhc0FvBKqvqGq/iF2OOG+?=
 =?us-ascii?Q?9/BwJ/HerQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b183e6a7-6b63-4544-816d-08def47be635
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 12:03:31.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkQzW4+tOHZuYY6uhJLwzSkpEHj/n2I+s9VFi6J23PQwv1b1gmJSrBJ54EoqFIP1Aw+q7tskENEPI93du12dwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967

On Tue, Jul 28, 2026 at 07:41:36AM +0800, Davidlohr Bueso wrote:
> Allow auto-committed BI hdm decoders on sane platforms, rejecting
> only broken paths (ie: one that cannot route BISnp, or BI paired
> with a host-only target range type).
> 
> The respective region creation is done like any other committed
> decoder - with cxlds->bi set by the time an decoder attaches.
> 
> A committed BI decoder under a window without the BI restriction is
> refused (undefined behavior per the CFMWS Window Restrictions), as
> is a committed decoder attaching to a region of a different
> coherency model.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/hdm.c    | 24 +++++++++++++++++-------
>  drivers/cxl/core/pci.c    | 36 +++++++++++++++++++++++++++++-------
>  drivers/cxl/core/region.c | 33 +++++++++++++++++++++++++++++++++
>  drivers/cxl/port.c        |  4 ++++
>  4 files changed, 83 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index f437fe15c6df..c5be6fe4c77a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1061,13 +1061,23 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		else
>  			cxld->target_type = CXL_DECODER_DEVMEM;
>  
> -		/*
> -		 * Autocommit BI-enabled decoders is not supported.
> -		 * At this point cxlds->bi is not yet setup, so there
> -		 * are no guarantees that the platform supports BI.
> -		 */
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
> -			return -ENXIO;
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl)) {
> +			struct cxl_dev_state *cxlds = cxled ?
> +				cxled_to_memdev(cxled)->cxlds : NULL;
> +
> +			if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
> +				dev_warn(&port->dev,
> +					 "decoder%d.%d: BI with host-only\n",
> +					 port->id, cxld->id);
> +				return -ENXIO;
> +			}
> +			if (cxlds && !cxlds->bi_capable) {
> +				dev_warn(&port->dev,
> +					 "decoder%d.%d: path not BI capable\n",
> +					 port->id, cxld->id);
> +				return -ENXIO;
> +			}
> +		}
>  
>  		guard(rwsem_write)(&cxl_rwsem.region);
>  		if (cxld->id != cxl_num_decoders_committed(port)) {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 554058ccb1e9..8d2651e06a79 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1083,6 +1083,18 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
>  				    scale, base);
>  }
>  
> +/* Committed, or no explicit commit required */
> +static bool cxl_bi_decoder_committed(void __iomem *bi)
> +{
> +	u32 caps = readl(bi + CXL_BI_DECODER_CAPS_OFFSET);
> +	u32 sts = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ, caps))
> +		return true;
> +
> +	return FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMITTED, sts);
> +}
> +
>  /* Enable or dealloc BI-ID changes in the given level of the topology. */
>  static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>  {
> @@ -1127,6 +1139,16 @@ static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>  		return 0;
>  	case PCI_EXP_TYPE_DOWNSTREAM:
>  		if (enable) {
> +			/*
> +			 * Adopt a dport that was already programmed and
> +			 * committed by firmware: nothing new is enabled
> +			 * below it, so no commit is due.
> +			 */
> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl) &&
> +			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
> +			    cxl_bi_decoder_committed(bi))
> +				return 0;
> +

Small question, when DSP's BI related registers are committed by FW, does it guaranteed
that all the intermediate switch on the path are also committed with BI enabled ?



>  			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
>  			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
>  		} else {
> @@ -1173,11 +1195,11 @@ static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
>  
>  	if (enable) {
>  		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> -			if (cxlds->bi)
> -				return 0;
> -			dev_err(cxlds->dev,
> -				"BI already enabled in hardware\n");
> -			return -EBUSY;
> +			/* adopt firmware enabled */
> +			if (!cxlds->bi)
> +				dev_dbg(cxlds->dev,
> +					"adopting firmware-enabled BI\n");
> +			goto done;
>  		}
>  		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
>  	} else {
> @@ -1192,11 +1214,11 @@ static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
>  	}
>  
>  	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
> -	cxlds->bi = enable;
>  
>  	dev_dbg(cxlds->dev, "BI requests %s\n",
>  		str_enabled_disabled(enable));
> -
> +done:
> +	cxlds->bi = enable;
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 76c6dc28a407..5578ef68034d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1827,6 +1827,21 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	return rc;
>  }
>  
> +/* Read back the committed BI bit of an auto-discovered decoder */
> +static bool cxled_committed_bi(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	u32 ctrl;
> +
> +	if (!cxlhdm || !cxlhdm->regs.hdm_decoder)
> +		return false;
> +
> +	ctrl = readl(cxlhdm->regs.hdm_decoder +
> +		     CXL_HDM_DECODER0_CTRL_OFFSET(cxled->cxld.id));
> +	return FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl);
> +}
> +
>  static int cxl_region_attach_auto(struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1839,6 +1854,16 @@ static int cxl_region_attach_auto(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> +	/* A committed decoder may only join a region of its own flavor */
> +	if (cxled_committed_bi(cxled) !=
> +	    (cxlr->type == CXL_DECODER_DEVMEM &&
> +	     cxl_root_decoder_is_bi(cxlr->cxlrd))) {
> +		dev_err(&cxlr->dev, "%s:%s coherency model mismatch\n",
> +			dev_name(&cxled_to_memdev(cxled)->dev),
> +			dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
>  	if (pos >= 0) {
>  		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
>  			dev_name(&cxled->cxld.dev), pos);
> @@ -3806,6 +3831,14 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	if (part < 0)
>  		return ERR_PTR(-EBUSY);
>  
> +	/* avoid UB */
> +	if (cxled_committed_bi(cxled) && !cxl_root_decoder_is_bi(cxlrd)) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s BI decoder in a non-BI window\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return ERR_PTR(-ENXIO);
> +	}
> +

Should we also check the inverse mismatch case here ?

if (!cxled_committed_bi() && cxl_root_decoder_is_bi()) {}

thoughts ?

>  	do {
>  		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>  				       atomic_read(&cxlrd->region_id),
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ab3317fc1388..0c666ce00aa2 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -181,6 +181,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * Must precede region discovery so that any firmware-committed BI
> +	 * decoder is adopted before its region is assembled.
> +	 */
>  	rc = cxl_bi_setup(port);
>  	if (rc)
>  		dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);
> -- 
> 2.39.5
>

Hmmm just curious are intermediate switch are guaranteed to be valid in AUTO discovery
scenario , seems that the implementation only checks DSP.

Best regards,
Richard Cheng.
