Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE778F59
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115174; cv=fail; b=WFlZjmKSbbnpPm38UmAfgiACCvXwzq6ntUZQp0/LKHa5PSt5IdwCr0pVXgn8UM2EJkFQubb2FtNXLEz7cVLSegDGJACahY5WI2M+o6Njgxnoq158hqYkU9vZTKKPZJ/+Ibhu3c22r4NXfpmLf0kMK62Y15eorDotNlkpUq3BTTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115174; c=relaxed/simple;
	bh=KhgrdXKHYKnb5BT3/YXuTVzbNH/XrVWr7yPjDJeP+Tg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JLe+6f7Zo2c28o5eYP+J95XsZKBfk0wIC5V9k31TmXm5y3kMqias7/R4TY2sqG8Q38DnzjiAQgg9GjzefthKW/1yef79il1rwSrhT0dvTByx38IeTYQ89xAMWYn0dFvYj2JsO8T7Gj9+3OxqOecxihkVN3udIWJgdJLOMoyABHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHsdnz/d; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHsdnz/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781115173; x=1812651173;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KhgrdXKHYKnb5BT3/YXuTVzbNH/XrVWr7yPjDJeP+Tg=;
  b=mHsdnz/d7hleUqrD7oUoXk5+u7cWum2Kc/EwQTNglRGNxOq6cS6/0Ygr
   G6CNi8nfSqzgQlrwDKjctvDPNGJ3VwitkgTUfY3Af7c6vlt3i7YjXZ7NJ
   BALSFxBFs44LgZbbniZRWUWuYIudbpGFrjZ78uN3POJ/mrPad/EjPZNmk
   kc3sNvvKBUbvXC1TwjytgzMOagfRJroDxE85s5KYaUS5SlasNcr4J2vlo
   R+XOMmQwn8SELoI8kGWeFtzPKiwGvgnNusnNkm6Fr3gfSSIlG4uCSfHfX
   J7t8O+pl269wT6s+heaE73BAOvmAwdVKjepxomq/zyP3q9JS2PyFF5cI6
   A==;
X-CSE-ConnectionGUID: GXtoUsnQSg2IM5D/laWlyw==
X-CSE-MsgGUID: UXKHZIlFTmWOYHvQZrDk3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85544292"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="85544292"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 11:12:52 -0700
X-CSE-ConnectionGUID: 2Am7epYlSnaxMjiJpXlueQ==
X-CSE-MsgGUID: rrLTD5fhQDCehWBtbikIeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251339400"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 11:12:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 11:12:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 11:12:52 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 11:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVaWS6w0SP9n4Hcby5j0WvT8KQc9q3lDB0rXrkAy0OnT5SIHLc5jAE1n128SVLmUxAvTLkHlv1YwU6b1zZLkxV4+/GhMK6NHHH8NN7+Vu7RndfndISygiCd9GhLnIrmwQDoFO+5c9ffvabdBSFXN+MMLBuKSdFpmbqeByjWwQz2uPPa0/HiFB0DLZVxFkwnhILsTeQT/LKI2+zbdWR3bknufe1chPK3N3p81NS794liHAIW0DUxVXjj1WYs2x14e1gZTwvc2pZw6eRkIEFtb9+jVVjS7r9dFTi6iUdZfXX4IFwym93UxoWeuqL4DqkeXBCpH2f/d9HDuTxCWWnshog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAl8LGCqO+X0oEpW+NgjuNKdu24WRUTngetgKqiH7L8=;
 b=l6IVcwMF069OCTcM2HFVW1trUH+aJvqwbfTC7/W0H3bdpuqYRJJoRl5YzhjAXCNy15wKz19dCJ8Jzk3Rto3XwxS0iavgWbGOkpiWeWkMso9nqg0PH3LA8c44hUeMH6jjvfp4yJNEX6OtX41N5A2tsFFFNArwTe09IiFFICLgdPObvDbG2XhN4XvrPnthBnkn2282dBfp4z4xl7TgyNeX6owyROpb9PXk/1B8LC7Ld+YT0spmlDOkvO0CbVJSpDhOvPHsTRl9G3nzUTpRoPoPJk9Mzw5J0svFOI4AeWUV8d4fR84w+x7EdguFYzk5psHF9vzHJ1OFYGaxZeVhwHvWDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 18:12:48 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 18:12:45 +0000
Date: Wed, 10 Jun 2026 11:12:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<djbw@kernel.org>, <sam.moelius@trailofbits.com>
Subject: Re: [PATCH] cxl/test: Fix integer overflow in mock LSA bounds checks
Message-ID: <aimpGhLI-qCA5KM-@aschofie-mobl2.lan>
References: <20260605171238.3857744-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605171238.3857744-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA0PR11MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: b3129780-b904-455d-1a83-08dec71bdf0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: y9WM1ptd9MJ0F9+QA5C6NwcraKY167ETdCtu6HBMPEuQOrdUGkhPHrH/NkQe+TuP1cF6GStacsoo1D6iHnX7bQ0ajb7QKO41X9n90Q7ORAbKwxJFWpe2ov+QTfFprssTMUsETEcoUf4OVhP7lbotescT8R1ATxS53zlHVrwWke6HeTDBgtgTNQVWiZvJw5LE6xHhEVZksivYaeQ7JOPVvltLZk9R91pxUNvR4+zNia1NAOfs/6Msm6YuND+P6eG1+Id6TnyKiQcfoWi/G1KkdXUPceNAmvebeIqng/YchYA3AIXg+MTzyX6Wfmj+CK2pVmtB0V1pnaPvqGD9C5g4O/XsvE3/cbdNfnmfbnvvi/igNlFILzHw13MfVfH3bBKhBVFXotsQ8FpqhLWd7jJEA5A8aJ2xiMr3ETSYkQbDbhc4nf8kXZseDWtGulmZVsg8D0muy1+2/zMQ1WLlI9A2maNkQx5SP4b2gPPe5klWAv+CjWXjCZturhbJRA/RxLZqDcrj9yZDsN459w3+5Wg6e2WNro/cjGq6fSmOZrzpN2FdsDPOwOWGeY2v0Y1YmZo4KTGAmKhJQp7I+deiPfmtYGNQYr5+d2V5D5sGzCk9JexOWP3fac6zoUlJpf6p3yeKS9z1ExEuNNXJcKtFtnltBm99IMA22hKp6HhZDwquqmcOaZLPIYMcinymq423oSExKP4P0uKX3yOntNEMuLmmFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dd8PXO3CzeZVegusTyWzv/Bb9D5/n6H9QJ9iSRVX7eO5Cy+fZ83/UF7hjsr5?=
 =?us-ascii?Q?z6hACDthW3UDQ8YQtCp/slvK1dSu02LUudfTuUPZZbXemZcc5tn9CUSAOr8a?=
 =?us-ascii?Q?VYs/ueb4o2kGWHHQZxe/T8050FkYPNWX1BTJZ5Td33HLEFF1R5I1ftmZYeu9?=
 =?us-ascii?Q?hRQJtSwLxbjwVL7+4mXv9JS/AzoQ2iCP9VGx+75tz0hC+dlxPC7PIV/q4BFN?=
 =?us-ascii?Q?hVzf09STLjoRwoMQRhufZFpUoPbG12pwhESFNy8W8lCM/bsonOCGkMmC1srB?=
 =?us-ascii?Q?OnsWZFKNUaXOsWbP58U1T50MNl8Tl3fhndqDO/LvgFquCYdFhYcRB6+9wRR7?=
 =?us-ascii?Q?hB/phW43t+KhwCh6I/ePl6DGHBM5s/oZLhXbSCPpRmSRelOMWbcyYe4rp/43?=
 =?us-ascii?Q?o/V93AyWlqUHcFIvz5A/mfiYBGlIawWF9xOT6YUO2So381hbHaVcSBnlSpc9?=
 =?us-ascii?Q?J2g/Y1QyM+YPjS0/lebmjJf66aK6OLX6YQx97OTHwrgeNfye+sxY98ZCkazs?=
 =?us-ascii?Q?0RPKH3d0o+jHlj6CinhRqJaj2ifeJfd+3eB3dzzyitwz1iP4DanMrwkO6oeT?=
 =?us-ascii?Q?Cj0kx+1aWFDKODmVEqYI4XzAj0nY+otL+84asowgupXzvuioq1HwAupQNdB3?=
 =?us-ascii?Q?HIF74ikTaHSgM4s7TeLs0RHNEh9oVEUBBox4HUNg4YLrN7wLUAOdgnOBd6o1?=
 =?us-ascii?Q?Me5FyokaVCT7ARpeyX1+y+Tk3Rv8jxHsDiKEABy2v5A/7HG4SqgTVLQfBHlU?=
 =?us-ascii?Q?QHn2VU5gxc27IhN/tM6xqZn1q2rnq9+GcUE+gT9b0Iy4T30kOSgQqn6XPToo?=
 =?us-ascii?Q?YdrQLX57XQE5kjVYUrPgCIVMWr6OXDhM2ehgb8Pq6aQ64ID9mmPvUj7HuFm9?=
 =?us-ascii?Q?VTcbCsvFpvPxnAu85kGmQvBJ5rFyssU75+6YuVpUwCQfTRVajuVRMOdoeF1J?=
 =?us-ascii?Q?iwvSkp6NkvrNTnUJa/F+X3qDyVLW7/HFwTcsMfRlkDJftYC+BIUWywRtiRBE?=
 =?us-ascii?Q?49mn9nzvVMnIUVhPaFuV9lEjucm8B1kYbxzGaNqRoQDrqepujP3lx8JkAAjV?=
 =?us-ascii?Q?smklzBsBkpa0h9jqp2jc7nYzeOuowDl2zgEN3W7Fs/EqjAWiyCFy6mMWrIgB?=
 =?us-ascii?Q?N780oynm7/h+3bBzdITiVJKJUUSHaD5Of+E4W3phr4ZAk5ZSZx2hFYz8HGyz?=
 =?us-ascii?Q?mZSPJ19VO99cXynQAPf93CIhBdcEIbfUhJxtAXkaTgpRkzpsVxf3viNclRa5?=
 =?us-ascii?Q?3TkBXkkF0aO+ak00ji5RJL/XIMGhnIUf1Yt5MVd3Z3NVFF5wP9Q4SjtueHCl?=
 =?us-ascii?Q?ae5GkHcXZUqBigp20WWsRa3miM0GuesIQcfGR6DmVPHbCaP6lfHTb7dmjaNX?=
 =?us-ascii?Q?NHJ8SUdc6GPyzyschN6xHTuHziKZzoOV98wxLSDoCfbb0o0Bqbt9MxpT7KHH?=
 =?us-ascii?Q?wuLMqnO6yb9MwtbA5k+NJTD+sK7zQDpfNUWhkj/bR/IBZwGJmVzpZnLGCR8B?=
 =?us-ascii?Q?RAtlnu3XStD9dNq+li9pq6jQINyuCj0bHgU8tswd6MAPBKypEqHHRhhgslfa?=
 =?us-ascii?Q?Gl0jCFnXOMbRsmZu1ZjClKTCSM5WIQkdF/vXSsE+cSz7ZGIwuHgTb+v9oTNb?=
 =?us-ascii?Q?n5L3zC22/X1Dl7I+0SLs+2pGZ9JBBKhb5svMnYzyYmmz1Ma9VLaXHnwblv5r?=
 =?us-ascii?Q?DwvfvP5hPiBGWA7uWAZBpmaPds9l9dXQtDmV8NVo5wskFdOMPrAKj45C4EPD?=
 =?us-ascii?Q?i0s0N/EuH2dAXtrERLF5ndU7olFfdE4=3D?=
X-Exchange-RoutingPolicyChecked: g9T++3u5W9OXacu4FBa/OmcQmQbEQilEyBhokYan7mC3U6P80LMbac+/93yhliXm3KiT5EQvXCkgKRLd3pVHk3R5zns5mqAYfXJyWRhMddliwHkyXs/ufSmKsa+HhsWNY+w86a/31tlVFxnF2oDar9pv3Ixp43KZGmMkCqgUSoa3/Zmzgy5Cs2neKSVKAJCiA6g1CUg6w0EaJdGn4rKiRUFJDVDn+GcIdQJqLFgYaD3gZX+4Q4LBOFwuZTTpgRXEQoOHFO8IfQpT4TGR15gZhgaekgsJryJCOMEfpSn1wWqQQLHEW4XskLnUYUg3//DHAxpMpGAN44WqQGo6RKPScw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3129780-b904-455d-1a83-08dec71bdf0a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 18:12:45.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sP6PM4eb/dRbyhYLerNH3lXQK1XKeL8/VrOumvFiJLGSXffyuq4m71AfWdfmm3psA2+jglPu0JOfBvbTLtrrL1BBOiXvPtiHIMzFwQgMLqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
X-OriginatorOrg: intel.com

On Fri, Jun 05, 2026 at 10:12:38AM -0700, Dave Jiang wrote:
> Pre-existing issue discovered by sashiko-bot.
> 
> mock_get_lsa() and mock_set_lsa() validate the requested LSA range with
> "offset + length > LSA_SIZE". Both offset and length are u32 and, in
> mock_get_lsa(), both are taken directly from the user-supplied payload.
> The addition is evaluated modulo 2^32, so a large offset combined with a
> small length wraps around and passes the check.
> 
> Rewrite the checks to compare offset and length against LSA_SIZE without
> overflowing by subtracting offset from LSA_SIZE after bounding offset.

Above is a mouthful, is it more simply...
	Rewrite the checks to first bound offset, then compare length
	against the remaining LSA size.


With a commit msg update upon merge...

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Suggested-by: sashiko-bot
> Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
> Link: https://lore.kernel.org/linux-cxl/20260605143748.235271F00893@smtp.kernel.org/
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 5d812b10fbc8..f9b11207ae60 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1063,7 +1063,7 @@ static int mock_get_lsa(struct cxl_mockmem_data *mdata,
>  		return -EINVAL;
>  	offset = le32_to_cpu(get_lsa->offset);
>  	length = le32_to_cpu(get_lsa->length);
> -	if (offset + length > LSA_SIZE)
> +	if (offset > LSA_SIZE || length > LSA_SIZE - offset)
>  		return -EINVAL;
>  	if (length > cmd->size_out)
>  		return -EINVAL;
> @@ -1083,7 +1083,7 @@ static int mock_set_lsa(struct cxl_mockmem_data *mdata,
>  		return -EINVAL;
>  	offset = le32_to_cpu(set_lsa->offset);
>  	length = cmd->size_in - sizeof(*set_lsa);
> -	if (offset + length > LSA_SIZE)
> +	if (offset > LSA_SIZE || length > LSA_SIZE - offset)
>  		return -EINVAL;
>  
>  	memcpy(lsa + offset, &set_lsa->data[0], length);
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> prerequisite-patch-id: 2230e8cb1f5da168992ad92776043f6632681665
> -- 
> 2.54.0
> 
