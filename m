Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801B1A2C0B
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055337; cv=fail; b=jLJiQn18FZNTRoHGUMTo7A0c/SD4kEux15r/zsmwezonsPBzwS+VU3t3w2d5gJJvjXgyS4cjXAMbvTmAhM7cZ0m0Sr/CcAM3Wz+bGegbz7qAMy7jFeEQuMkwWKyZXpF31IqtToef9UFxf0hhrRZ8hL5vSIFEgCztgyIpUCIwgXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055337; c=relaxed/simple;
	bh=p2lQk0CB8cVW1LXTYgZKJrXh5ugu2chp4YO4q6avRTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sR3E3lXu6ToW9m2F0e4ZkdAf+pmeOg4Cn0xtXq3DYRFkUJvqii2WAM4/aqNE/5j5QzDEMUge6KcXQDqOB8MJq8vDgzAEBmubyXj4LfgXtUlH27+o3Z4eFmJe7vz9OL4ZTXraBYwHDAbX6kiQxR4SL16YLRICnatjL87QhrrFcMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QBMrHJ1p; arc=fail smtp.client-ip=40.93.196.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QBMrHJ1p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAwLkyi3NwXaZ0jBq1dH+vW8DS8HptuNBshJ3msNk8F/5y1XCi2wK+lanvPIqXynEDy0gqmwmmv5n+0woeHoo5hjKXQciFUgnvUeSEE46vYM7krKzE2krLzjWUuwuFS41VHOr2v4v+IBEt/YoZdifXL1CuyiSUGhckqNYB/7aM1VPBYSVm7ZeMGArBME7JG43osEKwiQY63NX5ytAPu0Lo1yuULI9mR/s7oGbEzB8ojwGLZb3Ey/pbT8FQRCA8Xw7wDKIXn+ZJkke2yRYnJ3aH+pPgizveAiQrlSxV4Yb9y5kblLVkPKjZsKbh9V91C5UbxLySSJl9Gp2/Sff+ZBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atYRSAIzp88Z2RLeaqsPYUb3/ZMGbfs8WWmA0Wjdb+s=;
 b=bz3a8NyA7v1CR7mBzyFgfvpn6bxLNXG7Pt5XLpS+MzhninlZz5Ove+QbmgOfTrZmyk+u25PpZRklBYeCxBc6VmVFjroadoxsWAh/a8P3bQKh9dLub5AUV/WQACs3zHZuZw2FwQx6KXtXIL9AAFvuWFUUjsl2RTkZlGPoSVGAKi0WCLYHQ91J2CCmR/zL8N40olqVQPF0Niw3Yt2su+j7k3J24seQMoJf1rVhaoM47EpHHJd/ZoZAWWOPuvQApAKqm40oafnAQtWIqmdAbCPnJyWyacPaRuiVn1bNXQ7ENZlowAX8cj7q67/z3vgaJs6/idKoc+Uo5C+P9/jZ2IXSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atYRSAIzp88Z2RLeaqsPYUb3/ZMGbfs8WWmA0Wjdb+s=;
 b=QBMrHJ1pZudzCttzsemRPH114E8VGLEEItiiPJ0RvsBIBogi8hkr7lzmyxRhx+Q14BJFcGBMXdFFWUM/5oQxmYwHQimaWMoc5J4DbiKqvOf+dPfvo2W5/RvJP34Comsp/LpJ3iSuRjdOv3f5Hc4B4VWnBNsnf2TPDeUufBV3PV70YQKCiNVgN78Rh6K91slRDXGe7gSRL/caXhFAFJy23QgEf77LK5Syt4Nh5gTD6POVUZj3kWkK2+SGPgvvLn9oPvR5ItUXjWuQVNmNOn4bfxFuh1IxfXphAgxNBsxwJcJh/dK2tzbVwLEU/GObVr5sqbMB1PZUpexq4qg6aoC7RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 05:35:32 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 05:35:32 +0000
Date: Tue, 22 Sep 2026 13:35:26 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, 
	Gregory Price <gourry@gourry.net>, Ben Cheatham <benjamin.cheatham@amd.com>, 
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>, Jonathan Cameron <jic23@kernel.org>, 
	Fan Ni <nifan.cxl@gmail.com>
Subject: Re: [PATCH v14 4/8] cxl/events: Split event msgnum configuration
 from irq setup
Message-ID: <arITiPF_88quoUfG@MWDK4CY14F>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-5-anisa.su@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918203049.7273-5-anisa.su@samsung.com>
X-ClientProxiedBy: TP0P295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: da94cf8e-7524-4668-cfb5-08df186b513d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|6133799003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	h8vQW02nLgtBu1sKTYtWBIUhGClDPKAW/U4XC+6Ej8HdSSiQRoa46pcVx9moxxp4c6kCrijY/9l0hG6HOZz0bjFx2yEaqkBOdclFaEPkQQDXxjALktKwnPS9hVtnybOUXRznxTxyoLM30nFD9jGWOf1sYV/0ZbcUmm2xsm70qAHNWZYPGlD3GysncUcKbO2qgNvyRT5Ev8jNkq633dctOYqQe1OsBS4SbmhRWnJc661YuunaImXRsJIkCGUXlF2/Vny7sttd1hOP8rHno7GtNJ0zvkD3hbDlXRCBR3uayXrdLXC9nTczskZaZ0f2xqCTSFKDKefy4Bp12Kq7NwN9mRe7mdX9wvKYzFfGb6vVME7in8CRx+T+ATvr04FiH0+Qo/3npOJM+bH2OYFNkrZN/uzD0THXYsJ1L/DWgY/9YKt/HVtwIOnit11F68P3eE9G8xnQz63uqP7eJQBsPocyNm0kqt8dEwKKaSNZy1W2NhhTwMYjmtXuNXKcVtBgWhIyJVFyjJBpqZVUSaj1pzr5Q/fNQbYPzjKpKYhe1+x7S7mvN9fQdf81N8qeOCdAaLXEXk9MzmqP8cZ0ezqDIOGrEZK5cSWOQsHt7b8ZuhFYgVTkki3e5UAbYEE82VW0/v/eoWnh6EoXT5xxhEil1fQ3nLqU/5HmqO4zh0ahj3s3sHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0JTc2Hrk+Oh6GPTQMkAtzYs1NnZ4WLUzLj+jzfFQvN/c4xKyB7guAYl4/kny?=
 =?us-ascii?Q?pFoL+elxrSbtJCBjMsIpPaEfTQNt+L50BtipEAQPDewUwQNXsJnjtYlmCorb?=
 =?us-ascii?Q?rmiQLoJ/NeGGZyxEWtQzghNtD1H3eH/sPZ9rOezHapHtQiVth8jWGDATdV3Z?=
 =?us-ascii?Q?WiLo/WJ8zSemo02Yy9phjG9X51WWqGggXV3PnvjiGGCv5Fs15uzv95GyVFZK?=
 =?us-ascii?Q?uNay94ogIBKQrJYi8Snphtr3UeE+nvKOpHKEvmqAbWTJcuB0fpOx5U4uZVr/?=
 =?us-ascii?Q?66vGF3vt96NE1RUGhNvQOH2xj/dpn2Yb0rzE5cJhYz//PGehIcp2u9iv6QZg?=
 =?us-ascii?Q?WCzU5tcnKp/FmIcyWntSWPcjzmfTTYFIRujrBW2JaZLCeObEYKDf8Dmmz93p?=
 =?us-ascii?Q?LlXvauYOTh00dcsQYFMI8ziQTEUhhwboAMDzOdI7pmSP5n0kHI4+uxBiyYty?=
 =?us-ascii?Q?rpRjEa40VmiTkLWaQy8XRVSM8Kzr4QwYJWqdAUZOOG2+aDJDxHCXXhEackSQ?=
 =?us-ascii?Q?0AJDRKa+3XDMNn0LvpwyujFybvCzCMfvao7omA4lHepdfj2gBsh8TKLrWNH2?=
 =?us-ascii?Q?ahYngJSHPfrzV5KmIsCmt6dpA9KoonS6GakFPwjC8JXtHfMnxnZq5z+9eAnB?=
 =?us-ascii?Q?Sif5GHi8n4ufSwK24RSZT0DWp/GXskdvnFUXONeXC6de4TN0gq0L+zkt/fFc?=
 =?us-ascii?Q?7XUW14kbfgBxewg+CVmo6l5Vd8oaep3mV7+q8A9cr/48lrGLhAyFH6nsuWJb?=
 =?us-ascii?Q?xmctFUDGEw4+as9G9DORVMrHagXiXDp7Wr4Rd/jejjSNsHJdUMPw+VGfc4Lq?=
 =?us-ascii?Q?GEtie5bhA4HFdHo3WP81mqA4OTTlbH63t4Vw3jOFtgf9RXx1qhlwzVnq6EOc?=
 =?us-ascii?Q?EpY+oE0oJS2URAI31EaWAm1bQqO7Ir/V6mI/2LIBLQEtcxZHJX5pk/AMebwS?=
 =?us-ascii?Q?L7KnTFi353SimNwUD2v+3kstRsHGEUw7zED6X4JxM7WGIE5+PSfQNvkGXkau?=
 =?us-ascii?Q?1mAZqBPSm9krToO+AwIfkombC1wGn6IxgPs3aRDb//kb0IiurCUfglLwtmFp?=
 =?us-ascii?Q?jOnqiFUIL682Jo65Ye6LJpEfew+fE/2lr7AUVLHqQWs/JuWrA5RWSBqX3K2M?=
 =?us-ascii?Q?Z7DeTEjnLBPIngzc6DxWWatL3nX/LgwgxKqcC3plgXucxhR7MQzJZhaTfRyJ?=
 =?us-ascii?Q?te058n+2WGk8z9ZnIZppzF73Y5z4IFZTPla/IzafZm7ApSwmgHVAnq9bhJHz?=
 =?us-ascii?Q?TnVLcQq/jeBQ0eG0ge84LCX7hlWOa/rWCkdBJjIyKFKBA6Ei/TM0yEuch9lZ?=
 =?us-ascii?Q?LkxHzNp87j46VksDno5r4sDEIeCgQ+5iThedw3YiAbliRKJTWKZq8RBhjVK1?=
 =?us-ascii?Q?3gR/MWxZCtlqAHa1BzOaOo3+OTX6nVsjpu6tml16Y6Blz40I1PwJrrpjCD/v?=
 =?us-ascii?Q?IEyXPIwd15suCdF4yKDGaAr1xh02qBbHV7khg08m9PDiCUlLIpb5Fq2nt/nz?=
 =?us-ascii?Q?cmhe7qq470vjuNXr1cIc3dvvz+J7B9IDbn3HocSbyWLLM5+OREGOvDklZega?=
 =?us-ascii?Q?pK5Oji6r7Q6xEtV5kgwUAJxjbdsoO5oQ25wGuEH7ZAP7DDGUOAV6krgxXwDO?=
 =?us-ascii?Q?jkv20tKubK4Ph6wmt38BrcD7wwaqhELZrEpX6d8kpuQC3UHIqSDtJIfpbK4p?=
 =?us-ascii?Q?PxmMhgLQv64PrPASx+++kKCf/MZ+t6xB33dqE1L0Tw2LnWSwy8h7nsZcOdhJ?=
 =?us-ascii?Q?ofsgPWeqiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da94cf8e-7524-4668-cfb5-08df186b513d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 05:35:31.9885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7v4poQbkz2OtIQywynB2f1J9cW8LxECxao8Ng8LUQKe0G0Ji7YXetkZyeNC2uAgDy+kDYi3yOePaIA3SHv10Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

On Fri, Sep 18, 2026 at 01:30:13PM +0800, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
> 
> Split cxl_event_config_msgnums() from irq setup in preparation for
> separate DCD interrupts configuration.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
>  drivers/cxl/pci.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2fe9db4b3d86..4867657f5526 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -600,35 +600,31 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  	return cxl_event_get_int_policy(mds, policy);
>  }
>  
> -static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
> +static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
> +			      struct cxl_event_interrupt_policy *policy)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> -	struct cxl_event_interrupt_policy policy;
>  	int rc;
>  
> -	rc = cxl_event_config_msgnums(mds, &policy);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_event_req_irq(cxlds, policy.info_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->info_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
>  		return rc;
>  	}
>  
> -	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->warn_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
>  		return rc;
>  	}
>  
> -	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->failure_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
>  		return rc;
>  	}
>  
> -	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->fatal_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
>  		return rc;
> @@ -675,11 +671,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  		return -EBUSY;
>  	}
>  
> +	rc = cxl_event_config_msgnums(mds, &policy);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_mem_alloc_event_buf(mds);
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_event_irqsetup(mds);
> +	rc = cxl_event_irqsetup(mds, &policy);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.43.0
> 
