Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D33793CB
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936357; cv=fail; b=ka7u8IOOTHQiffOmUYzs+DyRTerlpY+FWuWE/Y7vB+9mYR4DeKSmlvykW6deh11e52nMMP9sDcSX8NwtJRfZTnFiyZLyR3kYRNYJmuv++9ixT2gM2yu4fX7EVEUNP5yBqRFx4OuQ2D8nOZqCs9Ki8AyZeuJ3okwWzUoKpxhiVV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936357; c=relaxed/simple;
	bh=Wc/0W/mZRc5299wFNXDr4YfQok1E+1xA2RvWPYzv1R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HQl6Np+g0/yB2WzXsFUUFnNaiqqF7MGzuHOSipT5q7loZm42plcXZ+sNRvMO7OBcE3T17RVIlItt7BqmnjoQonzPV31op1LwJvNfynBGtf0MW6cEEyX4pg7NWOP6IsqwhjYI22o0ijF51WIiTcgZ/Wbn/14npz8CuNnhHagyp7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K0PxSDlV; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K0PxSDlV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtmkOYL2lFR/yJIeVBOy9V7tkzf/mzhuGQqZt5PpqqIw0yKj4n/rYxFYxdJZw/usDH00PmBYN7uTlqliffe9rRRhiANxyuUplkNXvcSMC5jPd8L1YFOt8pz/etapd8LmqlfmuaY3k5ESAJjm2PQ9im6CntfKnZV/5MMxpYIv2ounkJGy/V/iEYvyUVPp8ysWH1EGN+bhrsMpLtweM5PcdTMesuA2zEYOZaBIp3Lj6zHIJtIhUNdwpHY/gWe3R40u2v0sQbGaWoJlifNtGTsPeDonEDRlwAPObMtAy2kqLZIWHAEqrNCZAaoah1gfyKaM7O46jvvFbPiy7mesPzmpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8dURDacbwamgSQdeG+dNKRNq8uM+fYrChhEuS3ok5M=;
 b=r9vpGY21ha/vsp5ldEUGkPEjrUlV0kk/FlIz84H0KDCwhNoHNy2VhTAXnyfBpPXhRIM+N42hRyMMZIiXTUsMyWgh4CDXQvZil2MXNmVTHF0nesepC8RVx7I2zejhV9/Kks0ElgCrWOHTc1uUAt/ki1cmgs3oLjRWBk8rokwZaCPDIv52pdnFYTHYKC5LPOd0O5r/b/g32y6WeDiagj6BJuIRqUbspFHbqtluIYoeOm5X9EwKVimW+x6ygVlVdOyexewKNZEr3Mu5F1zTE2MA7UrfUmCIzmPVlJdHtYnEkUPnPFn8y0bJBaGCiY8S4AM6X/SLR4639NC4Hy41sagA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8dURDacbwamgSQdeG+dNKRNq8uM+fYrChhEuS3ok5M=;
 b=K0PxSDlVkniUSSwAuVBohZNr4TcUmFuEbj8YWdeL92ERwCOO/nSle9BkPXVpnq3JdLfwt8iHxDK6TTPn6ZtxZ6Mbg9hDUNIZIllk7WvwSnjNho4/yPdRTh6pCrpLMnENw459GwZiqS+cn9b2rGMqcripKGlYjBaqURqcjiQpA2nsEAKdLl53k+fwHDhRCof0LdWHqeR0S4CQCJuPWB6TijjdP4dbqxcI/4796dcSN8U6O75oHfKdM4GqfFBDAvd3nbpiejdcvxZg4SEBaBlSaOJvqz+BqXO1wapr5w9q+rc41Caws1DgcJwxNXr9TyrhqxWt3K5rw00YdlfiJTpShg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Mon, 13 Jul
 2026 09:52:33 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 09:52:32 +0000
Date: Mon, 13 Jul 2026 17:52:25 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, djbw@kernel.org, dave@stgolabs.net, 
	jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl/features: Serialize multi-part Get/Set Feature
 transfers
Message-ID: <alS0YGIqRfGBVCWl@MWDK4CY14F>
References: <20260709155841.1895915-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709155841.1895915-1-dave.jiang@intel.com>
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c50e7ee-1ac7-42eb-0987-08dee0c4754f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|3023799007|11063799006|5023799004|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4XTjNwBrERFGIqdFM4a4cV732vTmkj28MP0ME3n7d0OThNpAwUP6a5le7B7hxZtEgqG5YaXzEXLhGh0XB3fr8h80s3t+nxtN+WURxzcW5Z0MaqmQmZQjOyOTJAzOlkYOER5UMOnXuULGsj/yDyjLWnN8URlops+nR3f2lyCnboGufCeRmFOFXT4Xy/hjXNOLqzjB9VjhXePe+g/dhxGbl+jr3daIREh/P1zrGgeZF1fKeuITQTG+1uTSRYLttU75XC/GPsPa8YW9uZ9d1LluTHFxRhOH9VoQCmnEQ/nR+vA2ESAMy2yyqvVyLMXzFUOpkNHW9EHRyN5nxaUSfZXogz4P0yNWb7qDjbSQjkWxn80LP83S7JQBVnb+9oioBNLHW/xcivrpojjg6jEJD1DuQGRH+a1hFnt+tlDaMzEe4Sw1rHHtxrJO1XI2SnvFIJ9J2mYH/5qRJ0NG7KmQzmIvODVfRSqul0cmaGByInBnlaWE6hSjQTRVhQnXzhEa/5xeZOV96h5/7rK8UemjdGHuLlplw596g0K80bLjAkEBn+1SCidUbGwf769EPzEAt2cSWDEQEB0raQjWhrIpam80XDKcbRQWU1pp+4JFiTHDhzsBV1mrQvUfGpIxcXENKpa553UhQgbp4gRPuVuy0jHRCdol7oHnqdL26FX1o1PYBxY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(3023799007)(11063799006)(5023799004)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xOv/TTX+kbWwlQ7sy/VdqZmhZhkLEIVgBsr/Hk0ln6uSZxXX/6XvkNqou5Xy?=
 =?us-ascii?Q?kO5FURIuzPEvRpcxhoj+EyUXS90uwQFpuoEf8HwbORExppEqoGyoVSBbVB3z?=
 =?us-ascii?Q?oC+1ZC2v4qiRQXY2Xo+VG/S1tOPbgL2RyYWqbaw1vblQMZdSk8MJuq4739dT?=
 =?us-ascii?Q?rfgmWd+idGcGplMUAfG12w2cy3TF4W71XZTW28atw7DvDjhFbbllvbJX+fRV?=
 =?us-ascii?Q?vhM6vRxvKEGDmMWlsCKdy9VL6Qe6HadtNmYjWe60TUKLv/IT5Onu/6LZavy7?=
 =?us-ascii?Q?AvBJ6cjon+pcar3kP18lmR+Y9u+JYACpuvbjJWaECLsGcggw66hMRzP4jhzE?=
 =?us-ascii?Q?huW9gmugQoziwbFTzFzVKX6Hdx5oubiax5bUHidcsTIccupMA6XsN6ruHjFP?=
 =?us-ascii?Q?voE+L3+GKoPKu5JG4+cWzvJD5PpMFmwIQp67liJ2QhrtXQ3ff7nOUsqD4qQ8?=
 =?us-ascii?Q?46VNPo7Crm/9OG4BUAwwlwZ6TYEu+eZ5dQzWUC9YXAVV3s5uuRvmBb6QtKuz?=
 =?us-ascii?Q?RFSwQSn7mF/JBIBzOSRig0VrdZTp/qslvreq/96uTissWKqyeEKXM0nhsnET?=
 =?us-ascii?Q?O7xXcfkOwhjS6ALLlnxMwBVTGyrfqoD9fGrZgrx4yywEFH5MucJqHpWKWgs/?=
 =?us-ascii?Q?cA4Mcy1yP+Q5iId8KPqZpXKw/96sxcAVUZqwUMLmcXzLnhaZ1IZbff2vvWXO?=
 =?us-ascii?Q?a4HZ9ttzA7BSXIu2onXp0VbjsC7QYpgAuSTJ1+eM0ItbdeV9NuqPg7dV2ifh?=
 =?us-ascii?Q?Ok041oS514/d/qyTsow0VyvI23fwoqruA33sIuySDQSkcAbSSSmvh02IGeif?=
 =?us-ascii?Q?mO/7d0zIC66WxQfB6xh0lUue+JOXdF1pdfvbjst5n+F/l+0hbgmwWdmpH9jL?=
 =?us-ascii?Q?jiLnPMT8zB9Em0DxtzhR4dzr85Hpz998o5NOUbDDdyAtIhPPkiD/JhbL2Y9I?=
 =?us-ascii?Q?Hnlfq0biKH5mCb2DuYQLDqhFl4XiFaJHQIi57zRiatNWMCP+ow2csyNJ8Dlh?=
 =?us-ascii?Q?oMalsn8gfxDpxHIfslCgpRZ67t31ymRWpcFb7bDzvGMDH/pGvxpPnE3YGz22?=
 =?us-ascii?Q?0MmBlmP2qY/FDWSYD0MbXz04tYWK6YIo+gFw64NBH/SkpeXBVztjjPGCtzUC?=
 =?us-ascii?Q?Xp1xXTWa+L0F+iUjqLZhcpVqMTJ4+/niZrl8JLFBNI3FjO0+w6KJW1DQJ28T?=
 =?us-ascii?Q?VR0EWaA9hBV92RKNLzudvPPuCn7P/n52NK09uSc+quWfoWdtqWy775duFZnD?=
 =?us-ascii?Q?QaJXaeJdDISSg00kFKyre6zhALQ9XCxEpQT9J8ownN9B2RI1fsgFnT7w23tO?=
 =?us-ascii?Q?IaHfTX85/HwqSFQ8J6rou+Q8ZWU2N3Pe1470OKz2ZDK2f/MObrccmL3A3DSf?=
 =?us-ascii?Q?FSdMkPNNNEAktsEv+Qr52eydxMjwQirzI+uekXebtt3gm30dpms909eKgkxJ?=
 =?us-ascii?Q?CY4wP2GBjuT1L/GrQUttWUsrDAW8+gIeMbFNnSDej37ZClsnBUITqsBrykGJ?=
 =?us-ascii?Q?dVe9Qx9+yxOa4SnIbDI8jhhVIVewa72jb+6nNFoo5V/XAdYQxIdXRb1rdDTL?=
 =?us-ascii?Q?LVmMUYr1VEokUf+eqjYqeWxHeWE/j4NEQFw20wuALX+r6nfgv+5XyI+OzAlN?=
 =?us-ascii?Q?/rFooU8/TrxsLcXDVUW2KBNxkPLZy9rKTJwZOHeAeMR+utFwWyi8dPooppoV?=
 =?us-ascii?Q?d2DerFjw0TL9fV0xoTZF7YgKLljafjrfT1kDxeBND3YWiMXYcpblJhJK/ugB?=
 =?us-ascii?Q?oqkLO/BcTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c50e7ee-1ac7-42eb-0987-08dee0c4754f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 09:52:32.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlFibDWVnFcOmCllUz6o7zSlFsp7p+XxdGAXf+UTa68Xarb45n7wLqsZAYncI5UKZpuXb+rfISvT08csmuPOAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF

On Thu, Jul 09, 2026 at 08:58:41AM +0800, Dave Jiang wrote:
> A Get or Set Feature payload larger than the mailbox payload size is
> split into several mailbox commands. mbox_mutex only serializes
> individual mailbox commands and is dropped between iterations of these
> loops. Nothing serializes the multi-part transfer as a whole.
> cxl_get_feature() and cxl_set_feature() are reachable concurrently
> from fwctl (per-fd RPCs run under a read-held registration lock) and
> from the EDAC scrub/ECS/repair paths, so two transfers to the same
> mailbox can interleave their parts and corrupt the device's transfer
> context.
>

Hi Dave,

I have some opinion maybe worth discussing.

Get Feature does not have transfer state, it uses an offset and count.
For Set Feature, the device must reject a second transfer with Feature
Transfer in progress.

Maybe we should reword this as preventing concurrent Set failures and
preventing a multi-part Get from spanning a Set update? I don't think
"currupt the device's transfer context" is accutate.

> Add a per-mailbox feat_mutex and hold it across the whole transfer in
> both functions. It nests outside mbox_mutex (which is taken inside
> cxl_internal_send_cmd()), and is taken nowhere else, so no lock-ordering
> inversion is introduced.
> 
> Link: https://sashiko.dev/#/patchset/20260702090849.47501-1-icheng@nvidia.com?part=1
> Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
> Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/features.c | 3 +++
>  drivers/cxl/core/mbox.c     | 1 +
>  include/cxl/mailbox.h       | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 85185af46b72..85d6bcdc360e 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -240,6 +240,8 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  	size_out = min(feat_out_size, cxl_mbox->payload_size);
>  	uuid_copy(&pi.uuid, feat_uuid);
>  	pi.selection = selection;
> +
> +	guard(mutex)(&cxl_mbox->feat_mutex);
>  	do {
>  		data_to_rd_size = min(feat_out_size - data_rcvd_size,
>  				      cxl_mbox->payload_size);
> @@ -314,6 +316,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  		data_in_size = cxl_mbox->payload_size - hdr_size;
>  	}
>  
> +	guard(mutex)(&cxl_mbox->feat_mutex);

What about RAW command path ?
With CONFIG_CXL_MEM_RAW_COMMANDS=y, GET_FEATURE and SET_FEATURE can be
sent directly through mbox_send() without taking feat_mutex.

Or you want to keep the scope minimum so RAW path is out of scope ?

Otherwise the locking and ordering looks correct to me.

Best regards,
Richard Cheng.

>  	do {
>  		int rc;
>  
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..0370ac39ec4a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1516,6 +1516,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  
>  	cxl_mbox->host = host;
>  	mutex_init(&cxl_mbox->mbox_mutex);
> +	mutex_init(&cxl_mbox->feat_mutex);
>  	rcuwait_init(&cxl_mbox->mbox_wait);
>  
>  	return 0;
> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> index c4e99e2e3a9d..d008b9db07aa 100644
> --- a/include/cxl/mailbox.h
> +++ b/include/cxl/mailbox.h
> @@ -50,6 +50,7 @@ struct cxl_mbox_cmd {
>   * @payload_size: Size of space for payload
>   *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
>   * @mbox_mutex: mutex protects device mailbox and firmware
> + * @feat_mutex: serializes multi-part Get/Set Feature transfers
>   * @mbox_wait: rcuwait for mailbox
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   * @feat_cap: Features capability
> @@ -60,6 +61,7 @@ struct cxl_mailbox {
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	size_t payload_size;
>  	struct mutex mbox_mutex; /* lock to protect mailbox context */
> +	struct mutex feat_mutex;
>  	struct rcuwait mbox_wait;
>  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
>  	enum cxl_features_capability feat_cap;
> 
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> -- 
> 2.54.0
> 
> 
