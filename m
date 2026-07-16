Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE2E3EFD0E
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jul 2026 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191792; cv=fail; b=fSrz2WPv2RiwZwnC0ZxMaQqsqvDbqLvTBDI9Fj14P8s3rBCWA2a5tBlVKhvN4BnHg6lHXkiUtFR8GkVBY5yFdHm7uqu2GAHUE5s3Ax1iMwVmC21pWlc48MLEX2zz+UBPe91ea9VnFLw+ucQNvFL+qYxP/RVl9wakcN/B0lGTPAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191792; c=relaxed/simple;
	bh=kWekf4kfpzevuQRt8g8U5lSVvt43BTL09XwXSpGIC+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NKShemKzNUh+2hdI5SXS9dNIK5cHp3VB24j96hQ6vwWETtWps1xfWobqQ6+QNs3s1sKzVLnrzuUt4tny7HpkdLdJouYJcq1JsLX62sJAqwMHoHxap+o7U99sdnfGljLLYyMMCdAZ+xNbU7qyze98h0A5Jgp4v8MsyLNEBKBRPII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=keDcB6QW; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="keDcB6QW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Now68iTloyxKaQq6KpP9T0R1lXW9nX2FluhdWKgfe3RLWREdC9iUnVer2wzjAfKxEY5tz0vrj5Yhb2blsxZphnhyXIW3jNAjE/XoRqFTN7fnb56REe7xsMZLr5mTpRI54nX8HI2SqTKF6UErDZyv9WOjptt5X4g4ZnoOHIL+RhSIhD3/qeUwQdIfS38MesSd/jCsHWNf+HxjohMTt41Ly74s665AytlW9bE7l0JtIxsVxGTqDxznh0MpTanexWRM0mHVKrZIVlnbyf2q6XdtlHFZ6Ae5v1o6+2MBD5nyGyNDtIZM8TlnhhH0z27ddhaLAY6U4vnTvR4RIc+BIMciug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOle1dVA/ygjlfuJlndCx2wR2R0Uylzgxi1AYFt6oAg=;
 b=bZK0iPhMb+MVJp6QjqNp/HCFn5287x8UYW9d/xDlw8J6k6tORQfYMwTlDUvwzlR/ShX32CTOnKx/gmIbxbL5kVOoG8wToKiOpT85BVZobSkAY/yYZQ9VlE19QWSr/5KuDy0U2yvuo9Np3uuCkeyiJn5anYHeGqq8JXQ4hfS4jP03MnX2v+EJoUh25Csto4qWylI6cQrUP8dfKHQ2W860xBvwsPKC2PJgQcr/yYNBuNmUZHg6nn3w34JQNDHo7oNE4YC3DR4wMZJeCoU+ZFFVCsAriRV+/955ANQXiLPHly/xPT1qLVzeTPtUqMAGU0TsmqQPuEAkIoRGxZBP6ZB7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOle1dVA/ygjlfuJlndCx2wR2R0Uylzgxi1AYFt6oAg=;
 b=keDcB6QWjMy7BHOn0EYn1h6zZUPSwM/FmG0UXYLnuOL0CWBE3oU29zi81M+yijmLE2Ut1D4+2C2sNnxrKRDm8Wqjm+w2+onpxxgFSRbjbdTEthd6OWXwkvZnNCxRruzm+EqH4dM7PKr0NYwRRJHA5TXQAqeLBcvlNaPuplAGncSA8ZmDU37z743675rbbMACQPurw4N7PcWHW+2qw8MNE7nl2JJllC73XFT62np6obP7kVRMVlKrRnAqWkDZ2iB6Kp63j4DfAndOCPV6jLvurE08e7ULAlAZ9Udy03pXHcpsu/Mdi1IaR/8R/Qzdm6xio74pmU3KSjhd6bywBtS11w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 08:49:40 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 08:49:40 +0000
Date: Thu, 16 Jul 2026 16:49:35 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org, 
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v2 1/3] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <aliaSasHogM2go8g@MWDK4CY14F>
References: <cover.1784150131.git.alison.schofield@intel.com>
 <0d7618c36e20bfda585699f8641d62928b23f6d5.1784150131.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7618c36e20bfda585699f8641d62928b23f6d5.1784150131.git.alison.schofield@intel.com>
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 86794825-969b-4a86-9988-08dee3172c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|4143699003|10067099003|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	y59BS4E5orr4Az9JG8X7MS4FFkFpuY8ppfaxBqBZ4s2C5Uy0U3ZT66AvaM7o0Ia78XbsOAfLByF6vBPGnqZhHoOoPsgZKFgfiFZh/kgaQKOoV+cL8uKnsChS+sYn3rn6OjE7j+Be8akBhyBdShSnkEXz85hv7fKZlpLMSJeosnwkwL7o33DjM1u9lNSbRIJ7UtIZ2ZkTyBREtRxFaXFBAPBlghzLc7s9kI3gGt1vbDLm6OSqlNc+97kmkn/ZiST1ckecSGmRuai5+bNUNg9Egd+RoFHDHAS+VQQ8smuyxETuBUZJgADsc2FCX+2um60khAEG0r8ie/8F7R4btcD/8BKbe/VewOgPTDfAxrzKZSDnKFS4/WDHL6MnEn4466EnWaf7Bx4q81LI5P6P3bkvvVS47OQACZRsFwOEaS/hGN2bhAfhiNcDpYH3orNAIOwaUe5LmusBOmqoz8euFL4TmjgmRkng1ebsPw9w2r6Uxjd1kyJBHLi0GfEX8dvX+BIrf+Rj4xVADKF3H2JDgNiTFbnnAGPnFkXCAoAw26Qc9wpxcgfcvaE/9PE5ZHeMx2rT540ZhDPzsZ73s4cu7Y1UTUxwxRXxB4Vi7cAACiT3482I4y+IcL/vZsCELRGW9V8Z0uUhLMkvseZ64NYL0DlOVRmJRqLSrtep6vRVJ4TfqAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(10067099003)(56012099006)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3gkgRVPr2tD08GnKQWVLhoyOjfuhcxiMjJ1/WfN/9c3N5tbDa1kMAR0zqpGs?=
 =?us-ascii?Q?vq6Uyt8ZBZEIAlLIeiQ1Xxq2bikElG1S2ZIp7Jd6uIO+6OCGp7pluW0MTaIt?=
 =?us-ascii?Q?6WRPEDtxv7B1yia3DxWZKBAcMrZvnhJWLQUj9r1riR0KuTpfnuUTIRgyl60U?=
 =?us-ascii?Q?oL4j/FUEfzhfrnKIibme/rz6qzKGdn+ChxKYgYFEjwqWuiA0UGaF19+PF2qs?=
 =?us-ascii?Q?oM9FzfbUfvMHQ0m5yHz3lmnde5WFukRCXBt6MfaW9rxaXPHLLCr700UH3ixM?=
 =?us-ascii?Q?12DR63wqhPd7oHcd/wO/z6vJNlUJYkI9/fBeTBEosNiVlyEDKXgjHJxSeOWi?=
 =?us-ascii?Q?ZArkrUZnxumHA8TWD+mCfIB1gGhPY7b2msNj12B5qFlmFxg1w/GH38V1kRL+?=
 =?us-ascii?Q?C1iCVOS2LLJR/hFyoqd157eLo5kOlWW3uRecSif/Z5CH6e6J3UAy8etWaVr1?=
 =?us-ascii?Q?UyHF2h6/AtYkxVyZluWZyce7cTur1NNW6oqPr2hyOnV7awd3k2H7nrfpzYDm?=
 =?us-ascii?Q?Ox6eQufM6CSNdxj/BPZMjJQ0Twi0Nf4AXLZcjZ8a7CJBPnjmvfmaPayzJ9VE?=
 =?us-ascii?Q?4FdQ/gy+ukR2ZGZ4IAfZHfroU3/eSN0LzU5xFCCDuiyscN9XOR8fD0rrvKew?=
 =?us-ascii?Q?vujLTtOpM06NGcz6B+A+VmwXvaI5NJ3vTeWKDUtDOxYk0lMbs1e+l+lrxOlG?=
 =?us-ascii?Q?oK47E+mmjaCBVvo5jg9Q8sPvwMU6PtWsdHQhnaygZ04NckokY6sChCJcrUAL?=
 =?us-ascii?Q?r5PxooqYHnLR1OFn+NHKkylfCMpg26Smqlp6B211TAbLOggRD+IWHXbDAtcT?=
 =?us-ascii?Q?f1x/gwCU3EZDlYujNmsvKR69gU4msKc03F6SslPliRFPxa49bHRewxztV1Yi?=
 =?us-ascii?Q?VQA9dpbWSEZOTcdTmbcCLEfTZGiGmAI69KZGdIbrfPhCHaq0oNEkm6PLjbrN?=
 =?us-ascii?Q?KHV0lBFeWSN7MOwhFuAe0coDmTNqryHnZM/O5VenUSMCRqpB9/LuzFEF57B7?=
 =?us-ascii?Q?mcNF/DWmUdFt91dTBrZwfOZSHYkv5fk1zijXrudhJ/TfdjJ3qLjLlLJssHVk?=
 =?us-ascii?Q?BSFYe9ZHIsCITTGUkrns9S3izbZ/jV65f5NxLcJ1Vme6Qf7l8meNQrQy3Vz0?=
 =?us-ascii?Q?To3ox28KdbjmI5Sec4+aLRoa00XTBWgp12tqyeAeAY14f3cHJ+oviUIUbF38?=
 =?us-ascii?Q?Ebu4ILXcuvUAknWagzF8L5lPKgNrmBAOp3tPk0VL9NWQjTRZAPZFW5HpCT4E?=
 =?us-ascii?Q?QrWNobc0ujQ/p0spupDPKScsI14oZtpiiUd+Tv5X2EimCM+yldodK6TlXCn9?=
 =?us-ascii?Q?uNjslFIHCmfIUlEekD8VYNodONYViTDVNXb6sDQN3yuX4XjrklVCjeaTDtGa?=
 =?us-ascii?Q?+XkUEsi0G14LUT1y4IAPZnttCJKm44iRla/JJ/htSAc3673jgj5V7bGyH4ZJ?=
 =?us-ascii?Q?20K/Vr6JV51k31qsXm3oBUG+mMcjb/65JmkWLJ+2/dWHDnHAaprGi+rx3TJn?=
 =?us-ascii?Q?FdmI7HNAiiDeOWOgS8cQeAWQNJ2Yv2q9VQgZUmh9T6gC65fh9+96b7RkHZog?=
 =?us-ascii?Q?Tykf2voDPYP0CDnEvhVq+tC696S4/CPv1OprgQbobY5lFPbJy/vrntx/vg/Q?=
 =?us-ascii?Q?KJh/6tj2IXXDXwEOQQ+/kRxmx9OWw4g/YNpxG6bcqHUfR04HPCr7Q9M/+e7i?=
 =?us-ascii?Q?LxEkwTCpPlO5lDhHe+I/nnonUKRZAXJRINbXn3cU4+CXFj+z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86794825-969b-4a86-9988-08dee3172c4f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:49:40.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivyRl/1kUiN7Ovt6imFCiMPl+GPHrkNqMGekd6a7blciS024PwErItNSANyOtk854kA/wRVQM3FFlDNDtXPa3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796

On Wed, Jul 15, 2026 at 02:45:47PM +0800, Alison Schofield wrote:
> Switch decoder enumeration validates that the interleave ways encoding
> is legal, but not that the resulting number of ways fits the available
> targets. This can overrun the target arrays during enumeration.
> 
> Reject committed decoders whose interleave ways exceed either the
> hardware target list capacity or the reported target count. Reject
> switch decoders that report zero targets.
> 
> For uncommitted decoders, ignore the stale interleave ways value and
> reset it to one until the decoder is committed.
> 
> Add a clarifying comment that target_count is a direct count, not
> 0-based like decoder_count.
> 
> Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/hdm.c  | 26 ++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |  2 +-
>  drivers/cxl/cxl.h       |  2 ++
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..9f005f3193e2 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  
>  	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
>  	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +
> +	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
>  	cxlhdm->target_count =
>  		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> @@ -1084,6 +1086,30 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		cxld->interleave_ways, cxld->interleave_granularity);
>  
>  	if (!cxled) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +
> +		if (!committed) {
> +			/* Ignore interleave ways until commit */
> +			cxld->interleave_ways = 1;
> +			return 0;
> +		}
> +
> +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				CXL_HDM_DECODER0_TL_TARGETS);
> +			return -ENXIO;
> +		}
> +		if (cxld->interleave_ways > cxlsd->nr_targets) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				cxlsd->nr_targets);
> +			return -ENXIO;
> +		}
> +
>  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value = (hi << 32) + lo;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1215ee4f4035..28eccfdd75b8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1979,7 +1979,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
>  				   struct cxl_switch_decoder *cxlsd,
>  				   int nr_targets)
>  {
> -	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> +	if (nr_targets < 1 || nr_targets > CXL_DECODER_MAX_INTERLEAVE)

This contradict to what the comment claims.
The comment says that Target Count is a direct cound with 1h to 8h. However,
this check uses CXL_DECODER_MAX_INTERLEAVE, which is 16.

I think since the capability field is 4 bits wide, values 9 to 15 are still
acceptable.

I'm confused by this part, it looks inconsistent, refusing enumeration above 9
doesn't make sense to me either.
Maybe some explanation to explain why ?

Best regards,
Richard Cheng.
>  		return -EINVAL;
>  
>  	cxlsd->nr_targets = nr_targets;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c0e5308e4d1b..291ada46b646 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -67,6 +67,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
>  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> +/* Two registers with one target ID per byte */
> +#define CXL_HDM_DECODER0_TL_TARGETS 8
>  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>  #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>  
> -- 
> 2.37.3
> 
> 
