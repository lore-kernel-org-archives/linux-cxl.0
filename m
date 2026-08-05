Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B02BB17
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891108; cv=fail; b=XIogUV8iMzqFBzlN6HtM1bUTXlC8f3+nCVNm/MSaxmcMByzLWdZcsKSURUDV6JGdaUZnTA/uDGALtnZAaxOPRucXhbAsGlqG2lH/SrWsqLdKZCf0Mk0MMN/i1WSHsHLB6POFBJv/deJAppcRh30w3J+ncusplCCZCSTlq+2K2xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891108; c=relaxed/simple;
	bh=u5xwcuY/VYJFZGdudqZjezKxsJOlg+DGJTNnm63ukKg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qFf5YGhLZN1JSbfvWlLuETi54chJP57TT+WVnex71Mps07Jv6f3H2xcaiAhrImfmpZDh9uSvZddBsTz4KZ+yWUVvxJbq0EaR8DMXpMwEhGnJaGp3qhXhWGm4qCRmGJcqSJ3w5CjmSvwNuz5qQML6aFDNvt7kkWHFVAoC+pY4t1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfLvuejH; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfLvuejH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785891106; x=1817427106;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u5xwcuY/VYJFZGdudqZjezKxsJOlg+DGJTNnm63ukKg=;
  b=gfLvuejHAuXAo/GxnIEl3Ll/yLiIwJeqhPervj8pHzcjQDJ5PxCnhef/
   Is8baPETgQX4JDYuOfE9dX9Q7bIkMrIEjhiA+wX3/bZN0drY+3G2hDXMw
   VQ0k7v7jBUpYGE6qas5IF+9YvHZ3rTOh270WARMPxqKysBztXUxdNYPsh
   jGiCbd2tHs/3QfOY1E9jS0eYNOptVqzMAT+iMmtWIg/JolM95eIpp05ZA
   aHPtsMVaNlaEDMXD4xKBfqmxgublfpmZitjIEF6YsbAYt53vTRGOEheP+
   gWA5HZKLG9MFaXWoFa9KKyQZjaIBA16DHYt95+6FjR7jKK5I7I0tAEF/X
   Q==;
X-CSE-ConnectionGUID: ZMtlnb2/RBSEkKSjKlUaKw==
X-CSE-MsgGUID: 8SHeTKDHS1aIdbjZPr/QPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86225492"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86225492"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 17:51:46 -0700
X-CSE-ConnectionGUID: EKCUuoL/TWGzeZnrTdSfJQ==
X-CSE-MsgGUID: g3MSHKGhTVyGvbDERe1k8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="261088423"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 17:51:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 17:51:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 17:51:43 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 17:51:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLKN4YlfEhDQ2XccDW2XtyvHko8V6v+D+rvjcmoxV78YYJPWbneh9f8MzJLKg5H3pjS8so/NW09O7II2VKDz2zHxs9pK3Y6FW8ZFT2AY/73MYV6PhUuZGQ0LhcgBca8NFjdZ9HLWZGs2ndQEgt1NU8aOunE1zj1/AnZoEhWmIXNuH+Od+83l9MA4MBCe6mbfh+OZAXipeZnC+MiCQJghClweCpPisDcd9Yt5pfDKL+nAMXA4X1e3e2hNKmn1KnlqYYdrfSAo6vm9fAiBHK1b0kL85pEgieOYxCOYlVbQf0XJD4TKFzBvWVTHvxuENUpY/cJNThgz5WRzqHloNdt6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaqXp5Uda6UH/q/tJeaoFBru6xjdX5pMgyi7WPf1rLA=;
 b=KmXJ/SX2QvEk9xnzBKm7fcQPM8PvZmsSFmIAz7Yu8Ff/1v4xlxojqGiHJVzsVCy+fTAV9wDvZT2CPRbivtblegkvllUnaXUw+Be0uzRQvlTQdX0LHUNFP8py4XFSpLp4KNM44o4Gt5o7+Z/iCO3XtZ00TqXf38j4DVlFr5va7PeioAsTHotV+l8f8njm/sW2URFUYJ2WHxsg1acBlxVmteFhXm7QvcfpCLCnPZkdIeploYoR1cJrl3q42VkWByVY8V37eFsv+rtI6BkJcPt2ipmUkeR9Hhbx6AFEVq6LLZpnH2VDGXqAalcg34LNsxjmo7USvwSnyHGtk6HPsEiJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 00:51:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 00:51:39 +0000
Date: Tue, 4 Aug 2026 17:51:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<benjamin.cheatham@amd.com>, <alucerop@amd.com>, <dongjoo.seo1@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v7 8/8] cxl: Allow auto-committed BI hdm decoders
Message-ID: <anKJGC7iXDifSHZt@aschofie-mobl2.lan>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-9-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260728144136.709882-9-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: c4248cbd-92b0-4577-5cf4-08def28bb5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|5023799004|10067099003|11063799006|4143699003|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Cq637owvIyhF2sko38ZZJOH7JStj9CuMZg/JKKwIHnErPvG9YE4L1F5jwCKYVyshYeqKQgLpfha/71htfOw9O0M2t/qM4fxOHsXZxqFNqPJ3ByIfuH4/oStCfHHKyVE+cYCTX5lY4CBaFFP2keS2hzgM9+bXbFUh688LOE9bYUI1e/UDG4H6l+LE8r6uVmpLy/mYQja3G/Q0o8NTifmbS6DtNsZfeFZia80s7FW4daiyEkP+ZS7/QuJmHROUkTEirZRKb2MaR7Z/qcYyI9sVWjLM0RpP34mUgZW4AZy4sPb3NwV37S4aqaj4nmEvpUWAnhatSzVO96W1Hf/AeDZ327Th8Gt53/VcW8ODL17pAY3HIoUYn/GoHWiDQ3NiDnqVW7cFghVSL+CCdzi7SgD+03c3Hud/h4f3mV9+7oM917Z3Q9VtULm6JBmWtCCaoaxwT8hZ0IaZBr90hlt9sHMtHAVnPunDxeWDa7CT1WhqH1u+92WbQwt0MIH2tkHJuKSoL3YfCg8i0TAr1JHy0+bV1p+n2XOpdKNl5ZnXRf7hTnb7nCvpyE86e0H4DQYGqyRwIlH8ESYxKaGpve+Xcl3Y08zQp8vJ7EkCxVpvRaM/cNnV8aGnrd7LclYBlm86wlW4uY3arKftMwB7yELOaOdCuAzgy2BIhP1UPYVHX5fnPF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(5023799004)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n1RYrEH6F0+mb2Vog2IJC64fdiMQ2D/8PGjwt3nO1gw6EbE/2ukroFoFdju8?=
 =?us-ascii?Q?ppRvDipYXN/OspcBN7mLvoX5TSZ+KrIpzIDAV1+prYw2rzmNvuMh6KGXVxw8?=
 =?us-ascii?Q?sC23tx8i7BeykyJokhN3vU+iJlvuhW/6G3Ccbbv213OVJ1Y7ue3bY5+ZW4p+?=
 =?us-ascii?Q?azUvK/mNggbE+4Jysgg6YuNma2m+ZheJbBJLnLaYmElII+lE1hhtOFAHBPEV?=
 =?us-ascii?Q?o0WtDpi431Cmr9V6giA164bZf90bY+/A5hMddyzpOza43kAxVfR9GUD1thOT?=
 =?us-ascii?Q?0IkTKxIgxv7BsYYH2TinCwrhSGfJ4NepeYS/ePDCE57pGBow6y2f9fPJ4/gm?=
 =?us-ascii?Q?XXr1Fkrkdm0D7mKicXH6P3mwTL16l1GPmg4qivFBi45tarzBAxApmz9xnCXE?=
 =?us-ascii?Q?eEPEc95OnmQ0NjQX5qYTow0AYpfp/514jWUE/K9inW7RolJsGHZ+imtaMBgt?=
 =?us-ascii?Q?+dNRaBluESKmPJEMWBqwHLX9TYI9ZktB9WMG2TsflTwh2b3/WVJ3CXtFgFkU?=
 =?us-ascii?Q?27OYynpHNMllwcUUky+jpREUQa6lONDVgwA3LfvNwmX6CtibZscArcGlSdOc?=
 =?us-ascii?Q?i2Z0V1b4cOgMK+o2WKfIxhiGUAhtygWelCuhg2pyuYJWUVrHa2xqMPG8cT3D?=
 =?us-ascii?Q?XZP7++ruwbfSVmZ+tPjPaVtQbgZZm3tufBg48hXPOPf2nD1tAq4AqLfetBg/?=
 =?us-ascii?Q?VbSKx5fbVq/mgp8kQjIyeUZyt/dRspaJH3/VG5egtmNWOJAtx3H+Jv46CSdN?=
 =?us-ascii?Q?lnOzJcX3kxX1/3dVhmeSYRBkvvTRF7ij74cDQhtr3oZp+Xqs1/bPKH3vj09Y?=
 =?us-ascii?Q?ZxmWwN4M9SJ8g8MhKG9dKnZAjeWMuAyl245FAxjvlPWTfike/0nRz8tQc24h?=
 =?us-ascii?Q?qmuB1xvMsMzYYtW+9D3HFuiqfeyLL9w0FHYFqnH2GnfovgZu4jEcUqckur1x?=
 =?us-ascii?Q?P50xz6frPROqbjQRjJdbPZZZtx0LWNszFB2XXT81evT9mEIkNXGYw84+ZKjq?=
 =?us-ascii?Q?+SlTuAcLPnsevzPeeX0EhfGHsTMpo9QJNoyoQFSeAPXZuinE81xVCZ2bzVCL?=
 =?us-ascii?Q?RazK8yh5UKwdoDtg4qk/OJ+AOliK0aQ/T/ThrjIwE/NAqTu05VpE5VsjXYFD?=
 =?us-ascii?Q?8+U+g2lKtnRGEZMfPDkl23EotKJVbbUfECx6bw/bDFE9HoORVZZOX6YG9h2l?=
 =?us-ascii?Q?Le28eh1nCCFN2uGBWGFxIRl4n0UZu1Njephvi8PpR5F23BaYl4/hRSKEstMm?=
 =?us-ascii?Q?HpQH+Znf0OWfWC/7BOFhqRIj9e8H39a6QSB4Jn8qkwxGnnQB0MBwHJ5WCsq5?=
 =?us-ascii?Q?rff0VuaqktJ3md/OJuzxA2GDAWNb4FZjNcOBB0X/qu8UHdvPLCI66LnQZKPn?=
 =?us-ascii?Q?E/pW3ZZlXaAgtN2N1sYAqLxqJa6mJSzYUBeTx33fR3zCwbDJyGL89bJeRnqV?=
 =?us-ascii?Q?VLfwmkf8WwPRr4T6yoB378/IFpNeB24sP9bqcjU+R2QaY0byjbHBvUKAD8vx?=
 =?us-ascii?Q?kONC7MUcDGMHrY3SIUhY4NNu4WIY6KiY5qh/eRoMlGYdqJ/jw2DhMwu5wX0l?=
 =?us-ascii?Q?SGEmeo3wb80NFWIsPplJQBLcIhUbo7n/ftuVC6365p4gwddx+DA3c09oQGne?=
 =?us-ascii?Q?shnPWDtXh3KrXNVCZV6O8oVVFi6vkX7Ij1QUNLE55sbEIKbCn8Pt29UVhOv2?=
 =?us-ascii?Q?MNraNkNs8fqZlTuBvMahBbwjQ4nMrOZ5rj2Fr5yMQRGgki4jnk7nglunqFZj?=
 =?us-ascii?Q?+vsTIgpMpQUzASKZPk8rXw8ha42z03A=3D?=
X-Exchange-RoutingPolicyChecked: hGn19Z6BIFhvIPb6/51u7rjaoBTPY9TFqM5vFbjgUqgrrux8O0aLoXHd5ms+QigP3tljoFoRwAuYJ8ItNgp3ccafH4HgjIEMuVhxhN12wPOJXTrARdqaygMwlXo2cYkHloBmq16gpAwN6WdwdLHN0zDgH0CNsTnL/Jzo2gwg+YwJtfRX/7hPvhkNIe1sLKingi5ygUnNQ9rcwFCt1GG6lZhKNbjXoeIgloqjqOQYxhbTJc9qp31M1B+OwAze6p6+UPp/KNXipP0ud2s1SV1iWNffkSY+ZcylpKBch/x/ef3Qw0eb5vnVhAsySWAqe+mqLS5BcXo1Rp64JuOITxJ77A==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4248cbd-92b0-4577-5cf4-08def28bb5ab
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 00:51:39.7175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CUCI2C+sJ5fnnfmX8oVs4sc2bHP/IB5mOgVdvhHxnajsUD0vYP/lNVV3o46I95A1jzi+lsLNAc+iPDCIgzHtH3NrBRWvTLl0a5p7rTSCYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com

On Tue, Jul 28, 2026 at 07:41:36AM -0700, Davidlohr Bueso wrote:
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

Hi Davidlohr,

A question about reading the CTRL register twice -


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

Here we first read CTRL register -

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

And then we re-read it here.  Could we record the bit at the earlier read?


> +}

snip to end
