Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C9414DF6;
	Fri,  4 Sep 2026 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501446; cv=fail; b=WJq5/pM9QlOZSNCzjhWPW9YUtFFyuCeTzFrLgc6dtKs+LcyxYwHo9a36E+QZovuEoKhLKK8zUGeTdunYkA0cBvKhr8jqZwHo6va7ozF0gbYwdYiF8b1s6Vyw8hx2wXlUT+axs+WEzHBZW4MNwaP75e3CUH/1HOcc5q5ir8sPhNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501446; c=relaxed/simple;
	bh=kJ33U730Pk3xHfhlTL4MYZ5akoO17yAzC9hy2f0dFaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OGthKVcRvoigMTaZud9kqnBRTbaknBGDbQ6N91nYW5oher60vYHsgBi16yQTPJCqOAKB47hdTpkEnmt2O+J/T9/vWmJsfKADh8O2Ri5AkVqnFYv2FrZ53MqGpx4/rFhOgQzzBNfctEIswHAWHoSBTGBzq8syw99q3u6xZwk3SrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWn7AoYa; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWn7AoYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788501444; x=1820037444;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kJ33U730Pk3xHfhlTL4MYZ5akoO17yAzC9hy2f0dFaw=;
  b=lWn7AoYaaZs6rWosyIKWvc8WjgkEpJqmpQJ7Swm2W1FbUA2kEPm9ywL+
   X17E3L1iiXxIcB/Iv5DrDXBMPSTHpaizrG5TjkEQM8t0znvprZMU2gaX7
   kjCA3xUsaZnNe3vyxsA5P06VUSKNMRKIXn1fba6cu7a/QilkAhOU4pSxS
   9h2b0V9k/t2zuGcSEHzg3CP7ZuoU9gzEGAgle7QL7My6mCQsQF70kFqkB
   ntifv4Qs6cXHnfFm+4ZKCk0mP/qCdOb2bWNalcT+TAi1B/ho40/+RSyhq
   Z77kdzfaa4JeL/WgNQotdcE12HPyNdHfgzRTS11FSCPoIKFhUFCdOM2xi
   g==;
X-CSE-ConnectionGUID: fg8fIxNmR9KsHRXrlcu8YQ==
X-CSE-MsgGUID: YQM+Nv8AQWK5RNsL7S+UrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="111770770"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="111770770"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:57:23 -0700
X-CSE-ConnectionGUID: lBRaf08pTRiy/UMRuCpa8g==
X-CSE-MsgGUID: e6GiClmjS52DqKUrKsRKVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268633343"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:57:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:57:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 22:57:22 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:57:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAT2ovJYkz1ep7ma2OpsOXKuhcQXQ/4ekNMpGi0QtRox9vPW6PXUXDaBLeFJG2W1pjfWr4vQIifxsaQToGw46Y2oz6EUa/6OGHwFOmKwR7Fs0JTF2BbFCpEM5zNr7Wo1IE3i3EoeChrjhLrnZIN73v6A/4AjpbykqBbuPwshL5SURqEMIrfvFhn574BjXtUWFqB6X7r/1jeRSHlrBnaFW0cgTM2LHEVNNNg1lX3gSh/HbcYiSShh7dinNxP3YU6UpG7P+CjmdNc/98JrR6BiYI5hyjZFmDBd34/8HTqKsbwhK4MsQtwq8F2F0k/1oYe2XBR9W73vT18KC3cIatOWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D88loSdfvyQadZL3R7rkqWB+epBgYeydDQ3G4wTSeY8=;
 b=RQB6IZrPiz9MWE/zc8T/qQdwy/SkyJ1YhGT+Y5eA+9UraoJNvi2wXtQhwi5l2FEPQqIvlQR/GC2DakOi/NgD6OGqfVbtIophJFgphBMO38cyFPHfVC+nc4oo0PLbQ5HXhHM6YYAkdbAw33VcoomBUsIVYHcf4uCLb9rnhZ9D4jjiSncwREp8w0YPvYRcvTb1ctUQ7pTKWONuVNvHk+dCQG3mkMbNGVAo+qddA7GFX3sTuDK2UKrYnNa598vkngQBQa2O3pvj0I/qCHUzhw976mxlR+s+1Qflg6DoEB69zI+gQ31ihJHZkMcZGM/dS0SHa7JL/NHaTSSyhytayDnskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS3PR11MB9844.namprd11.prod.outlook.com (2603:10b6:8:364::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 05:57:14 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 05:57:14 +0000
Date: Thu, 3 Sep 2026 22:57:05 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<gourry@gourry.net>, <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v7 6/7] cxl/region: Reject poison scan for decoder
 without a partition
Message-ID: <appdsV1_A-Tu_j9j@aschofie-mobl2.lan>
References: <20260902053839.25595-1-icheng@nvidia.com>
 <20260902053839.25595-7-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902053839.25595-7-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0179.namprd05.prod.outlook.com
 (2603:10b6:a03:339::34) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS3PR11MB9844:EE_
X-MS-Office365-Filtering-Correlation-Id: c7532b78-ecd0-4c9e-3773-08df0a495e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|23010399003|366016|376014|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5UYPBDiFG6GD33v0in3J5ccKPagvPfMDPyTQwxt1W7GtNxLs/1k4xe4UWucWHAYYEYjIrtaXCMPsdIWXx2Eu/dkm8Q0Azlix7/UInJ9AKo+Hx9eBdXId6BsBtE7eNDTmQs9Z5Wpwrm++KJsbvs8BQXgTJeIxVsspIemw5hIh9gZ/6aBwixMa2+jdgZdqUoY4xgCfPdSmhm3+1ULmnNkgaBSZDbOzPwPV7l3MOhAamNeiKn7xQMbK9n8MZlA51t0FgvAeWhD2BqCq6JsDGQMFa0O5Ck0DJXM5ZYTl6MsEn/57UK1ehvAkJRbLapMYKpGDooufLl79i3L2g5NxudHIVUtzYlrcePFfPfeR05CAnySrRDPH3sMMXXpLAWP7IxwMGt22xX5jlhTlJ9wrfbpNmuI7t6JlAxml4kkgQQ5wINpFsULuaHj4VBDee0M6pnHZQTGrOMxVCiUbLewKcWBWOCgagGSwaAj7WYlguJL9o+JMNP0SRgx0+NgW2qioav0Mokc1xLxMufX/jalWnL+Kv0rlYdVZE5RiVoD1MwfJd8BLOVPPjatvbf3DjBXe8ezqJZCoHmBMBxpTnYTlc0XKDk15lT5nleAGo9DAAMy7ZebKzhSgem3D+Jnms4NCEr6kDfcWkm40KuuV8JjuhC9xwfeD1gaPpvIb2eJsjISsczQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(366016)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s74VVIMT/tYfxET73wlJha4Oy399ZV4FgNo2gAm9j8IGdT216HAJyf5VrMQ7?=
 =?us-ascii?Q?9lfkYUwaMcAqEC027at45JotNTGldnrkw005IKHho7X4cw/IyvpWzvFGp+6O?=
 =?us-ascii?Q?j4s89XIh1shXi/QgLNx/qxR6yEHuuGYnwR07z1aomLw6YS0g97oY1W0e3eSA?=
 =?us-ascii?Q?HB361WHZdPaWKe9Knmd7LSb3luy7x3HWw+VPUH/KG6s8+kLI0gcJlswbtGUT?=
 =?us-ascii?Q?syW+w3fnTJe2dirfvle/+aabWpsTd6W1+gAYzujGv7PexpQz+G/WTFUhPl0Y?=
 =?us-ascii?Q?ZQzixvqAVmWVimTlZdf+TJiNBBz6Adg3vBh9yaA6ADcPqw/vMaba1NclU74m?=
 =?us-ascii?Q?9W+EcuOlEucQmPpXQlPy+XqEM3BZuqCzeJIJiXpuvA0tZeJwedcJ+lDdnhXd?=
 =?us-ascii?Q?EBe5aKoJS/jIjd6gU+YErNDJUjH4DvsdHll7yMZD16cs5koBPf8F6Smae2nG?=
 =?us-ascii?Q?CQp/CRuIqN03l6NlI4A7VnJC52dUdM0AuySy2zr9055QdjFUOmCTmcZ/MQwY?=
 =?us-ascii?Q?/Y3grR5AWEof84iwaCq93oi8QG19BOtzpq8wQ+Yxc7ai921Eo2Pn8ewHQFE6?=
 =?us-ascii?Q?bUQRs0CWlDrWxMxdIQbYJ2iCWzF8hERz0aYvXWOcxG4JuWahA95sq6DaEL8s?=
 =?us-ascii?Q?+wrsOvgsVoN1Z15z5UsT/uuuvSiHZ9lde74uZ3Sqiu2clXW4nhqOznEosuQ8?=
 =?us-ascii?Q?codlCbJFFHcMvcun6mzzwIV6Rx3ZxX/ncaP/oTJ3dwb00auvO1ORzTT2ddkO?=
 =?us-ascii?Q?jQnqpkibsMCSckcLIMhC9EV1vQ8Lj2k1rGHkHbKSPhOeNHcEu8K5gxvzGiLG?=
 =?us-ascii?Q?RN8cc9RyaXz7KIDPzWBoZiRaPqOMmdc1L6V9EBlMjhfGKbrZf8dkqv7o4Ok0?=
 =?us-ascii?Q?FvDuSXyvRc3P+NB6TiG1j0VN6eKb3DvwYPkPsA6ztnAG+dNAVUw2IGXXGkRZ?=
 =?us-ascii?Q?KctLJKEAQ8EOZ+d3J6PIps0mp1uio/X2/5lF3j3SCO/jU4RieWO4RgFE7l4w?=
 =?us-ascii?Q?bPLo0Lkj+fDCMZi5sDWyewMyCnVJlWMVyjfljpNwPf1JeLGFZo+rDEm7s80L?=
 =?us-ascii?Q?dFQpSHbaB8Qw0XJPBmom6nxpPQJUE85GQZRhKaErInslGQGKT5FER6SVWoS9?=
 =?us-ascii?Q?iCFfYcE9U+GwCqT4i3CJrbX0ywn5sD1Ryod8bdeG0KIVypbxBRUv3fW8tcJQ?=
 =?us-ascii?Q?ZI2Wx4CMarTdh7V17hmYiCHYAx+RRtfLTxBZUsFAghwlRr2eEWXZNBv2/skI?=
 =?us-ascii?Q?hYOEJ2QM3ByLpzhoxYMtozukj7zA/M4c+Ne+1JK9Uhy0l10q35fkmCql9gxJ?=
 =?us-ascii?Q?k0v1tyOF8PdnXw5kv9NiFi/M89LQUthXm8oLWwaprwDvmXArfz0IES/fIEa9?=
 =?us-ascii?Q?JbsVQjbhoIGoS7KPLKeYt3dfRihxhVEVo3QPDTQN9A11WGRSySwh1xzacwEp?=
 =?us-ascii?Q?MdId7MxVd60s6IWVvMRDNaSMegH88HAv3+XVZjurTlkFKAiZa8BzyTNFpDfl?=
 =?us-ascii?Q?DoYFg0+Th/G8Ho6MrxlsiKjOsl4GmDO/3M9uVY3Uls3JAr61h0lke7fiqDP0?=
 =?us-ascii?Q?a8GhGJVLWbx+wCq86ALiiqT4J3+UV1V8Y9aLcIfnHjz8yS3TzipjzFzww99m?=
 =?us-ascii?Q?Z/IS21fXULNnsXaDzA3T+gXBGvqAGWML2D19cQVOmP1tIFxIw5S+P1oYEV1L?=
 =?us-ascii?Q?QSZI7KwTyGXLDbhHMJvDO4CQx5UiUrX4Syyf1drQ36WO2HfT6qLGIR1dsV0F?=
 =?us-ascii?Q?id8I+AB0Gwm6NiNqbEpZCnWNLPdulJ0=3D?=
X-Exchange-RoutingPolicyChecked: eSguWy6gP9g+vzH5vvFbTh4lOHgIw5NnPJVdWcKu3TNv5RwAe3BOpc7kjdeF5wXUAKUzku95M2C/tYeqjOh2Vp0WvNBdfhQtOq4VCgieIxo+ICAvFfZGWz2SZv+yNHo/z4L0Cxgb14DT5JhBu29HQw6sLY5kHAOJQ9CRwva17uhGwRtdmFn6VwZI+5gT854hPE3q6eFB++KSax92Hbn4bZTs12xhrB9UM5UJMwAcDWF6H5+R22YG/nUDMLCAFZLH9gw76RW+R1ChjJ/jb9SEKlOoTzbSQRX8j/4TD7+VLWOl7EInU6yK51FBnvXZ//OowGPrXF1RheMwUPvVD6Ac3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7532b78-ecd0-4c9e-3773-08df0a495e30
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:57:14.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8v2+5khD482R04+++ummC3nN0RbacF+AA0xLYxKN1vp3A8BcAiH/trVS/YZqxpY283YeD7NxtJ4KnrhSbLjZRvd1TqcIlg1A1MYvzR65Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9844
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 01:38:38PM +0800, Richard Cheng wrote:
> __cxl_dpa_reserve() may leave cxled->part at -1 when a decoder's DPA
> range doesn't map to any reported partition, while still keeping
> dpa_res. poison_by_decoder() then indexes cxlds->part[-1], causing an
> out-of-bounds read when poison collection is triggered.
> 
> Return -ENODEV before accessing the partition array when no partition was
> assigned.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/region.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b7dc5d4988da..afe3fb57b7fe 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2954,6 +2954,8 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	cxled = to_cxl_endpoint_decoder(dev);
>  	if (!cxled->dpa_res)
>  		return rc;
> +	if (cxled->part < 0)
> +		return -ENODEV;

-ENODEV disables poison listing for the whole memdev since this is a
device_for_each_child() callback. 

Before be5cbd084027 that decoder was scanned like any other and the mode was
only ever compared, never used as an index, so CXL_DECODER_NONE and
CXL_DECODER_DEAD both still got their DPA read and the walk continued.

Can the fix be less instrusive and not fail the scan?

Here's a diff, totally untested:
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index afe3fb57b7fe..ebf06edf23be 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2942,9 +2942,9 @@ static int poison_by_decoder(struct device *dev, void *arg)
 {
        struct cxl_poison_context *ctx = arg;
        struct cxl_endpoint_decoder *cxled;
-       enum cxl_partition_mode mode;
        struct cxl_dev_state *cxlds;
        struct cxl_memdev *cxlmd;
+       bool tolerate_efault;
        u64 offset, length;
        int rc = 0;

@@ -2954,18 +2954,18 @@ static int poison_by_decoder(struct device *dev, void *arg)
        cxled = to_cxl_endpoint_decoder(dev);
        if (!cxled->dpa_res)
                return rc;
-       if (cxled->part < 0)
-               return -ENODEV;

        cxlmd = cxled_to_memdev(cxled);
        cxlds = cxlmd->cxlds;
-       mode = cxlds->part[cxled->part].mode;
+       /* Without a partition the mode is unknown, do not tolerate -EFAULT */
+       tolerate_efault = cxled->part >= 0 &&
+                         cxlds->part[cxled->part].mode == CXL_PARTMODE_RAM;

        if (cxled->skip) {
                offset = cxled->dpa_res->start - cxled->skip;
                length = cxled->skip;
                rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-               if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
+               if (rc == -EFAULT && tolerate_efault)
                        rc = 0;
                if (rc)
                        return rc;
@@ -2974,7 +2974,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
        offset = cxled->dpa_res->start;
        length = cxled->dpa_res->end - offset + 1;
        rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-       if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
+       if (rc == -EFAULT && tolerate_efault)
                rc = 0;
        if (rc)
                return rc;
(END)


>  
>  	cxlmd = cxled_to_memdev(cxled);
>  	cxlds = cxlmd->cxlds;
> -- 
> 2.53.0
> 
