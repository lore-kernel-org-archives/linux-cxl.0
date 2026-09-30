Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0D38C2A0
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753614; cv=fail; b=uiO394i56UKRVWBXRR3ROGuwqybT8LWzFzf52IhwGKmwvIYF1jX6naEbzkaYcYvwrIkEY7au5dojNcYLlTIrV9AVyjpp4izXn+DzrhTdsM1K10TOFG5X4OE+ybisuVPgHW70yj7TqrNZsB8gOUN+NUT/b3V3m250G8O9NAtfAE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753614; c=relaxed/simple;
	bh=q2Yly1Y6bQ9PNcZTfHVPMHZM5Jl7DqInEadc90lGRxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Llqfhhf/ggV8yXMmAt9gAJAx55+wchjq+pCW4T92lvBMlqrKp9gqGG2Am4r4qxXVVsL+BK7UaLlSZsoMxDqUR9EUGOOAFburjA07nEUMHpbWtZwOjvjlSdPoj8d42bTCCLO4gOx/akwd64ICF5YxyoviGuBPH1wlrPedC4v9yTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AQ02bDsV; arc=fail smtp.client-ip=52.101.85.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AQ02bDsV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEFwv9PcJr2Ow5GHDvqjyHdOVca95FzWA2MViGcSux0xM65VOvE24SzIaueZI7Qc2fLw2XTRE7GWx3qA/l5hmdqul9LslP43Vt8nmOGrCaVn+4UQ4b/tooaFxlJ+0N9gBbt9XTHeOJp+q+Sw56zhz8X0sjoxxG0RJrUAoaj239rBrsCaZansIu8eNhmNDzLp6zc4AXWq43ZcfUORV3jE54s4Vxb/TukvWHki/jVl84AThsyRAzOQPpGbF64yEQ4Rei5ojuLRk8IPZcqauz7O7RTrbvyP5/m3bx1CdLKuKu9uAYx0J9nfAbwXqB89pxC+smkRwCCyyJ7324JiVr3nCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuUM2p6aP1aapSYmnqU1xD2OTmQvBQtDDZRfYurTLVg=;
 b=LWZ5kRqd0vs4Z5SzAGES1fVwpvg/CK1lbvXX+CywiDGQoW2GmvhHN8JCCsCDKuI/6MB8K5xrro13G7VVN0MdNbtWz6k/Arv8UeWs59FVU9qVBklp7zcKWwaN3TEr5C4nES0Gsd8HQIAe0/Cv4efyhZ84wlHQZRoh/vvnI8/1M5k9VPVyE6Hm5699xd+zHz+9xfoWummMvP3bKCh6f+kf1GjYpxM2bdPxW6r9KAQ4g3PnibFqsg+RgoljECgow9COk488h+cg/xoiGjWPAwzD6QBYLTAgY718jv1puyrganVpn/YY4LOZUWrEXgFPAyVmblU9xxYNg0gRn9h6WAY9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuUM2p6aP1aapSYmnqU1xD2OTmQvBQtDDZRfYurTLVg=;
 b=AQ02bDsVwf2nSeP4HX50EByBQpGSpyB4222rZwUrUReUd7chRAIlwuMhjViAo12Xmx2EGqLOlX3Mhq6F35IObtFfrpOpq2fxik8ELRBPRJIMSBmww5GXkTX1uxmhvNES5N/bfP3jY+L4PEZ7iTRFR1dFdFCADxLpjjh3qmG0u7Z+xIqIqVX1vd3bIGQeNOwz7nMCGgU+HS1/qQ7pHvNUYznbMBK8w2n1XYVC4Tu5R3xaPuQFuQ3Ab7ff8H/a/iMhxRLG4rSifSTcfmWcAPhjVhudIR+W7IIhrhMjhngGjBL+NBAEifuxjrA3FVA0c+ZmPJAupMKlJew2jxbZ1gRXYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 07:33:26 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0451.014; Wed, 30 Sep 2026
 07:33:25 +0000
Date: Wed, 30 Sep 2026 15:33:20 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] tools/testing/cxl: Skip the auto region when no
 volatile window is active
Message-ID: <ary6WmhJk6PWhn0U@MWDK4CY14F>
References: <cover.1790641236.git.alison.schofield@intel.com>
 <ccc11aec8658ff29e604aded94ac4ce0da7b5fb8.1790641236.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccc11aec8658ff29e604aded94ac4ce0da7b5fb8.1790641236.git.alison.schofield@intel.com>
X-ClientProxiedBy: TPYP295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b62c4c-140d-4869-c585-08df1ec51d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|4143699003|6133799003|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NmM2U2ZyYKdfNUjN1ujYUFV3TvNxObSHgiBe0OKLqllSgJQsocWz+YvlTl27Aya8ATfNNT/IDjWzrPyhRFiH1j/tT8hUvHNSpajmLnbaMp7P4JcvH67gY2p8ADEeiCIZu5R5Csthz8tiNQMhKRjdWxH0m7Hf4P7441H+dbQdFC9hAOs/sL2eJoGhGCvOZ8HZ2YnYS1C222gvgkgag7Q24tPAynG6fNprg25j3QkfvEoweEaIztDdz2TkPw7bpyAUaXyDYpVIWfgsObN27hvmcPcBhCblisumRg25DEQarnmfflW6x3Ot3UHpSs0u+MNULw0F367FLxXpJmRqWQC+VfknjCDsUMn2k2iHo2tRB6EcncIOBL6k5TTVqprGZHGKCceYcxltNByDrTQyOSLcxiXLZZpI9gPfGCfrNEmyRp+HFNvC3snNCYJ47zPQJEUJxfjgc7mn4Kgn/I0GcLEJasm3ITclhMyDEOA8mAoBQRtqffcPYUTfLMPOBENjoDAkdpvgqacJqzjICqQ9LldnD43Y1C8TOofCNl1lhxpCTNO+q1TgYKvqcVE29APhRtRkCxBgzVaeyB+Ff3mEkkJqjvq7ssdJygUNSsiDEN8vOYxGyu8albSp4SNHSgHeIaHvcbRhzUjkaOTESU8gq4ojciM1ENlGtBUkY0WEcz25taQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(4143699003)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UgpJrUePv7hov1lFetOLYwW2m/Zj1OX1sD2j/2M4aigGV5vo2mK+xn1NK0IB?=
 =?us-ascii?Q?RaI7Dem4a6KuaoDfOZr6ALH/9ycB60EyuEdRu3O9OW46g/yj6vTPMDmNmWY5?=
 =?us-ascii?Q?9Qs3f/9JWTst9VmeOcCxDHWnDAbKDXKIR+pvHellh2rnD0WvPsRSUYPvgHaD?=
 =?us-ascii?Q?dspNpNsIcnthgwiG289inS1dMj4Oj49NPN8Ga21PUbj9xe7tyJkCbe6snvIT?=
 =?us-ascii?Q?LV6aNqkWpqOtc2jegpu8uTXkCsOCwXxocIYTRQyfqFL+vQhRk2jlkFq0e1ZV?=
 =?us-ascii?Q?vBVLscrzWZSHeCKrbLFau3X9Ju4VnOJ6TLQSWfgZ8+ehbmDGQ8e+3AmhzHHj?=
 =?us-ascii?Q?0X9ZWmsgMOG9cAjKuBH5UyyO02aCXyMpTIfWKMTkM0K7uxX777hX72vErnX9?=
 =?us-ascii?Q?U3lFatdxvzhsZgWNHYKVJmpYzoSh80vPWY1YXVspIvD3xiRF/OSxjwAC64am?=
 =?us-ascii?Q?j3Apw3bQKXq26QKPvVw0WWsNzK979YQMxeLev+Gj+bmhYZS/TYs2D7GK3ryP?=
 =?us-ascii?Q?cUNkE9qZyr/K4Y6PsKr4qlYpySYu+/VJ8IuihaGq8hYH1OvR8rgqMCwdzNg3?=
 =?us-ascii?Q?n461Vdz+VmB/FQHDmFtVHvQW81B9zPHmOsBUPhx+2w7evKX7LBxQp9g8A2uu?=
 =?us-ascii?Q?E6FLS2TNQMeuBqpoxcXqpGliNlfp2EotkjSf7+aG0opO62E1c0uB6yrt09gU?=
 =?us-ascii?Q?yOKwroaFw/KJyeYMtaJ0DBhaqc0t7J+lQFgMRTlXqGwPtKe90BAFfRJ+JBDk?=
 =?us-ascii?Q?CQZRMw/1doEZVs7y/tTxNsmhSFkQ9DWVh2/xYMSIvERkCC8ftkBvAZaRS5Jx?=
 =?us-ascii?Q?M2Da9I0lN+dADU0tpFe5zb5+t3D3LQh/gsrHk6uDfUirn2VYCf0APXH678SQ?=
 =?us-ascii?Q?Y4GhzpTF1S6hp9kqjGODU8ELqcEXi/RMXuxgeJ5wnXgTmfW9VyCfqN+2PyRn?=
 =?us-ascii?Q?UgKb88fGNfEDH4LXClpu7KzQSWy43GImAHIIHbAxNhFvfWhlmTmfJOD9hbwx?=
 =?us-ascii?Q?QGVzWOV5qprrj1dBpG+A6zqp44HHeldhwy13V4MVbfrFjtUuxnE1iEOhEZj6?=
 =?us-ascii?Q?/Px5n9TrV11TxkXo418qIGDq6k9DIyU+LLrrzbUv4Iaglr5imwuUouzY0zVD?=
 =?us-ascii?Q?1t/B2hmIbkKfRhpnSI9EBKsA4p0XSHTHcnkE/nTtb483IvZfNQbRsWIyCwLR?=
 =?us-ascii?Q?Pyn3mZFAVnFnfsMYEiKJ6cnwchxADFJAJIzuMufhcIYGLM6RXYDQdzRin0DA?=
 =?us-ascii?Q?zDCNOVFA0qE2vTBy1LLZ1Q2kk4JHAzpVEF574Y1TNFq4sH+mkN7OqWk2BqC2?=
 =?us-ascii?Q?svb8n8oUrRyKBgJXzr7Ec3Ut1T8/9+JY+q9GGqeiuoU5SOdcUgur/TQYao+d?=
 =?us-ascii?Q?RvCB78GuY7l80LbucwU/RyVzD/ZLK92nw46d8Hn13W6AgcDAObe/7dfxdX0Y?=
 =?us-ascii?Q?+Nz8Rj3MJ4xYkWbRk0eGjMurKclGs5m43WeMlGOjT4KmCrsEd61MYFkZwgja?=
 =?us-ascii?Q?3OOoypl9GvxlBsvi4zIkopwTxAKNvlEylYYNbp8e+HO5dAEg0s2d3fUxhsRF?=
 =?us-ascii?Q?JGTtG+1gqfeMVH0ayHws7mHuUv10m1qvPMIn1i1rouiOgmTIpTClHMOjOlFi?=
 =?us-ascii?Q?nfIQuYHaFF1Tj5AVYjCgxy3zXO9Ri70PwPJ2NsHxwJo0cdESfNOwq8HBdYb9?=
 =?us-ascii?Q?g1SUDiLUm5xzT11reYhOy0SFG4016ghBcc6bShEd+gKW8Fyb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b62c4c-140d-4869-c585-08df1ec51d00
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:33:25.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3n6Gqv4clLkecoUmEjkVmy8wB24SX/jwnSsjQr5eor0N4OXkEhxI5ZxJ0wd64YZyUZlmoq9z/Fg+ETNrLWvOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378

On Mon, Sep 28, 2026 at 05:56:17PM +0800, Alison Schofield wrote:
> The mock auto region always uses CFMWS0. With XOR interleave arithmetic
> that window is inactive, so its HPA base is never assigned and the
> endpoint decoders are programmed at HPA 0.
> 
> No root decoder matches that range, leaving DPA allocated to endpoint
> decoders that are not part of a region.
> 
> Set up the auto region only when a volatile window is active.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index aa140307e0c3..9d844932f0c6 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -423,6 +423,18 @@ struct acpi_cedt_cxims *mock_cxims[1] = {
>  	[0] = &mock_cedt.cxims0.cxims,
>  };
>  
> +static struct acpi_cedt_cfmws *mock_auto_region_cfmws(void)
> +{
> +	for (int i = cfmws_start; i <= cfmws_end; i++) {
> +		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> +
> +		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> +			return window;
> +	}
> +
> +	return NULL;
> +}
> +
>  struct cxl_mock_res {
>  	struct list_head list;
>  	struct range range;
> @@ -1114,6 +1126,10 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
>  	    pdev->id > 4 || cxld->id > 0)
>  		return MOCK_DECODER_INIT_DEFAULT;
>  
> +	/* XOR windows are all pmem, no window to host the RAM region */
> +	if (!mock_auto_region_cfmws())
> +		return MOCK_DECODER_INIT_DEFAULT;
> +
>  	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
>  			    MOCK_DECODER_INIT_TYPE3_AUTO;
>  }
> @@ -1137,7 +1153,7 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
>  static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
>  				      struct cxl_port *port)
>  {
> -	struct acpi_cedt_cfmws *window = mock_cfmws[0];
> +	struct acpi_cedt_cfmws *window = mock_auto_region_cfmws();
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_dport *dport;
> @@ -1211,7 +1227,7 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
>  				      struct platform_device *pdev,
>  				      bool hb0)
>  {
> -	struct acpi_cedt_cfmws *window = mock_cfmws[0];
> +	struct acpi_cedt_cfmws *window = mock_auto_region_cfmws();
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_dport *dport;
> -- 
> 2.37.3
>

Hi Alison,

The caller of get_decoder_init_type() and mock_init_hdm_type2/3_cxled()
is mock_init_hdm_decoder(), would it be possible to just call
mock_auto_region_cfmws() once and pass the window into each function ?

That way we can save some redundant traversal of entries.
Do you think this idea makes sense ?

Best regards,
Richard Cheng.
