Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A241A9B24
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405196; cv=fail; b=b5QTIJvwCKehRf81Tf/v8/yFizEMu3f+qpPAdMMBVjEa4WD4VKHiCxKH5ueUPGl4V7TuZO5IqT11ZBSwUBRMq+3F/ofZidB0a/QTmdm7wqnVPfaWiWiPW1/Au9u/pNshexVOJJjhR0jjW/pw/fSP/d5ADHtmjFVM/MuE6meMAbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405196; c=relaxed/simple;
	bh=F++ElGXyLeo6xdlU5S/O0o43l1hcosW9HzaI5ZHncNI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bbv5T5Ky0pgK9Pi58DZA5U8gxFWq4K8qOtRpTY9nq79r+aH3j2Xy8sIst374M/lmype5MzVIsGSaWcskza1XLS7BXxLiBqFROku9l1sZVq7hLQN5gJSL1ASjzkh9chWuTz6GA9SAjLdg3AYuzQkvKslXvmYVByv/aliepIUg2tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSsKB9b2; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSsKB9b2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788405194; x=1819941194;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F++ElGXyLeo6xdlU5S/O0o43l1hcosW9HzaI5ZHncNI=;
  b=WSsKB9b2K5/fEtihcMrKRuMgGiKGdEKJcde4XjuJov/4Z/HYHo3IzBZ6
   FWp76osT/SUcCxsBFbcdgmWS7DweikZK915HaDJlPXvoa/4SKSKluE3U1
   pYsW2Wn/D8CvkAjtNY/RK9CqPIVTyaHriCjUtx1ZTWMt6xbsdh/oFmxZO
   MFV2NkTRjecMQrHEl6d9JpXP7IX5QNRIFpmQx0n1xsmveiBDZdGlESISk
   aLL+2dI71Jse/DFNz/rcvxACtKlBbvSD4y0bkZZZeKZQrNQZfVUxey2sy
   zeUWRmdccZ0spzn4qby6ja2soxEMH85NRdRK9Tz/FC+HxNRaKxtyiQ/9o
   g==;
X-CSE-ConnectionGUID: WbXyyvhmSAK3rugNEdMSqg==
X-CSE-MsgGUID: VbcLd5nWRtG6ZTbbJZWosA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100035594"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100035594"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 20:13:12 -0700
X-CSE-ConnectionGUID: HQo28VRGSS6U2eDs2Ms8Fg==
X-CSE-MsgGUID: H3kHQrMESCWHLmVZ9rn3Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="270138840"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 20:13:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 20:13:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 20:13:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 20:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxZTKX8QxFVWvWXMt3PCbIs5Zc1RCPfsQa901hh05JRzC5FW7SHWmKRV8W+KamTUDwxkXDxcIq3YCjzg6GxAy6Wpz0IJyMKF8c+9snb93aThnE9Zu84UgrcQH/CvVRh+f/b5xbmm5ImgHdnexXKZPF8CV+S+JA+uc/tMqQbvR+QNU4ZjUFnNG7QjK9xKKL+OqXe4P+PBzYqnw/6sw3VM480tGrb/U/3Ajbdfo5inv3vxh+1TsbKzwG6K+hdsmBRrbxKuC/w3ge4iuFzpWg0rJA5HfVN72rZmqevMCI0PKh80foIPT+jv4yK2ELOlt2t0Cmio7zW+m4/CvdlKO88PPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSRgsk5W87Z5OGPtCGfA7CTf2Hc4Iewbl55emEbepqw=;
 b=uIQRR49vr0fbA5GaRrCTuQQ2QNW2je5gnboaE83cGxyk/kKFMhslx4svHvyrJgydoGOxNTwg4BVz3OwmVWVbeekzEFyxyKiFVtlGLVtra/SIQMdZ2hAsCMeWP9HbPxpQse1Dda16g8OBxJxlbGL5+v0ncMmiltoNTf1e6MXDMBwqWnsTDmTclEc0VDojFoBtXtya0K8zOc+dNva6VXLl0TYb66iGP4TBH1zjjRuodBqoVV9//JaY9CxTvj8rDfdwipP1hrxD4XuKwo6emuqsHFG5swvBmWGreG6XfQwIPdq5yJukOJtjAJAAMFvk8zU74wRp7Ft8NAsvJBrXaVc/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB5773.namprd11.prod.outlook.com (2603:10b6:303:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Thu, 3 Sep
 2026 03:13:06 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 03:13:06 +0000
Date: Wed, 2 Sep 2026 20:12:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] cxl/region: Support mixed-granularity auto regions
Message-ID: <apjlulaAui5XPu9D@aschofie-mobl2.lan>
References: <cover.1787255388.git.alison.schofield@intel.com>
 <465a9a3e68144a41af45ca1cdfa642e7af553c4e.1787255388.git.alison.schofield@intel.com>
 <20260821225759.6cfec077@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821225759.6cfec077@jic23-huawei>
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fe2682-952a-446c-abd6-08df0969461d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yP9UFAMG1YF568pW8mb2Wn/Qom1bjpOVgGpx1RFYMPBy0NSuqi0L21cN1YC2iBK0eQxV++3S0vmfYDoxSGhnrUR1C+L3lm1iCftqradNwbuV9JiToQSdDRpCC8+lQEYDNDpuo9QU3Zi0/kMYLop5HahL+/zKh0riGYf/rtZk02X/JwM+2qOv5O30kujKNIqNK2maSK8XIw/lOIQ78q9xEXXGItfm/DZYYuJLCozVn+WAaoDMn4mkM93GEpDznTYg0Qa9VKqZZk7BAwqJMxseT289yVbhHEPGCvYSmaSKEXNueTahOdpRttoYOIzbk/IxvyRd+8+I/x6OgpOZpJSAKSnx/LZCJhPbv2ABYUYbFEWMrg8w7jbrL+t/mX+gV8XmdxxVeA26gDYvRU/W6EnkCMH9UQ1++97LVqR1uxb2ZB2CzrJpOIM7IB9l9ngv5uB4R9ekJcQWnYreeDJTaBBOyzgGnz+8e4dkI8fnUPBhZGl7LWNM7dPmy/ClExef73AWOcrtxixK7XYnYx2NN+5mUodmqV7qDmKxSdsvQwdksNDSnKOGbJWaApeEjFGZvakeUfYAC+L3bAeNg7A4cKIbEUPiPdheRqdOw33LdI0wrVqrQaWP5crcSkmoabG4r/6fivwMrobZ2/AKq5GeT/BiLrUFfIdLMQ66Gxf367chtxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WwfW43OlrA3GNND8dd/1KL8xNU7kUr2aOZkjedYgjsEbTginNvlJH0IEp9yD?=
 =?us-ascii?Q?cjhsyysduOt3UrPa4tI1O3iq7DfeiQA55suB9BzFkocZc6+QIlpc9F/75K33?=
 =?us-ascii?Q?OIkEudAwynY/Os0TJgvcN7OO9eIFIJP+DwVtiEw6tUtTeJRSdv4q4dWAVqSF?=
 =?us-ascii?Q?+KMQ6VcXq3HrQ1S96x2ew0BEjUvhIhNrm+n0eKT62oNl2cc1has5BHsEzfZS?=
 =?us-ascii?Q?fx4xhXZWzA1H4B96gj9f8b/wo2BGbGcfraLutMVlO7iiT3hl8ST5LL5Z7KtN?=
 =?us-ascii?Q?oNk/dFiVUPI0v7FmyDBWcVg+hDk6tIF1x1rDXj0bRxTZL08KWRrqYiRt30Ql?=
 =?us-ascii?Q?Q+HdAybSyRAIA5N+ANPEDvpvF7GFiKS84cRtRgk6rtDgZHCB/9ud4zwM0wHM?=
 =?us-ascii?Q?gAwmw5h0+GpzWMoZR6uiyPVWNtnyUFToA1StfGVHxXaX+8PE0MSc/CqsdPLZ?=
 =?us-ascii?Q?Ks9CHSSz4Ug6oPQFOnLO5yNrc7495KPzF4OOSuqLhoU5tUqfOh3IY1Z5qCr4?=
 =?us-ascii?Q?oOWXuqAKAGinyRZRk9NiNSVS5gbahXcYBwBPfKYSun0LaiGAqhFk19kvEHOv?=
 =?us-ascii?Q?nNrDbZ9MG+mBoUAoJax3h0aonXftIxOr5mwn7o8gwEfMZMpstx7WZBxOc+zA?=
 =?us-ascii?Q?R8g6r2g03FtJwZTpmv1FY1vv5mv7wd4UEKoi+wl2I59ePXcXrXiIZhpE8/dt?=
 =?us-ascii?Q?JOGEGiweW7o9nGD+6int8bSwkyy7cWF10eUwbZY8TjopqfEEEKuuNNX7L8PB?=
 =?us-ascii?Q?6tz0cUbpFlShZusRW226CgunYxWuZ4aGmxLurRlhBLx2Rt4Ga4eQ8hj/IC/e?=
 =?us-ascii?Q?OW7fYYA4W9CnegtERYgbdLt4Xq6tcABg76hkL2R0E7F30cM5PHHbR6nb4pxY?=
 =?us-ascii?Q?8XN60TILKlK6ciF0PQcKRS9xn3+JoL3hUEkJdWPSWtxxI1GKKf3RG6+be5o2?=
 =?us-ascii?Q?O9/NR1UH0Gue1c1kYL+f8KPKLimPg9rBZqyAzqwhTC2gsl/Z2bwOBHMAsrOz?=
 =?us-ascii?Q?bD4P1xhY0SueY5tOPz2vigJ6g/RYhdKyfEBPpoydikPC2/FvxtRmoQbJSL5r?=
 =?us-ascii?Q?EwPBwNENaCueq04o3Aekbn6WMp908tknlVOERmvcMd5uNaOnYkg9cOIV30gA?=
 =?us-ascii?Q?Idv3k84xVoCQ5RLl8TaZRxR2jyJdYxJ1jeuwiaD/ReM6aVQOkU/nxrWXBbHM?=
 =?us-ascii?Q?BUepFPYX7tOps11vJvPVr5U3yK3E5WyiiTamF57SWxOXXMYf3oYJXzviFeC5?=
 =?us-ascii?Q?OloFApr6vW1SwiUNMU7cpfg/yiNfTiB2GtJi0xID7KepJz16QNVnsgxToQae?=
 =?us-ascii?Q?D59BloVzU1rDJyjFNelaYmpxvxNXDtk/Qp5Sr42Ld1rQdRx5gBzvQSOyB/Fj?=
 =?us-ascii?Q?Mx3qSQ2/84WqgDxX5cZLJJAEEazzT094dOXx4OLsUiFgb6WzC5kY3FpX3Rjw?=
 =?us-ascii?Q?JUH0cMotMQ85QEz/e/lVTeBb63lm5gxWQdAn6rF57KSlvlVW+fCbR/2vg9U2?=
 =?us-ascii?Q?lcbcV4EWH2x5HBPV+Uq94GmhIc7m0uWYl/Q9/qpJJIfsMQ7JNtjOjb7DlNQ5?=
 =?us-ascii?Q?Rm1s6HhpREDgMBKLVWuFVcmHjNvonTYC7NoHRX+kzP5vOktoIDVaV/KIkYG/?=
 =?us-ascii?Q?MnVVfZ4nORxUWkX/TCxPCLcJOC3wx3fcjFzR3YffqKgvPISn/jMr+wTw5BFf?=
 =?us-ascii?Q?f6fJEYvSkdCW7GZt8h9H791lLgM+TOYCNwqrERfuz0EkBUshLh6mdWxkRmfY?=
 =?us-ascii?Q?pBSi2fiVTaGoPQG7LRXLspHSXhhYCCU=3D?=
X-Exchange-RoutingPolicyChecked: iomns/Qb1T2R9AymyqxgnHvPncA1O++7jHSdenFpPH1kW3r1YjUe9vvzbx41ftihzHS2IxxZE4DgHqw2laG1hNNoBYQmy2Mq75D3dCQnhAQ4Z8fT4FXTeiF+ggXI1KSV74nQjPyLp0Z1GpnbizX9cRiFowOkSAt3CN9jPd8+z8W3v2zzZkOO/zjbJlZ585355t2eraGxE0ghVuefizIUNftQ1/2exKCdrvX88SkCYBF72gmyhfQDsU32gzP/Th5UKqu9eC6iDDLi5XqgRyRHNbqL2X7uyuXFhMM1kcG3P4Baq5wTG1F7Wt50sYyNxP/gkK/Mf/LzpiOX7qaH/ncCyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fe2682-952a-446c-abd6-08df0969461d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:13:06.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMXeg/tkIhWxH5CBFaWL7ZKt0dvOv6rd/JdN7STwB/yGCmUnOzcX6vg8mnWCsiwsIb6uzaPvf/FXmHeWCVMrnD8he9fXFapl2ajlSFTQaYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5773
X-OriginatorOrg: intel.com

On Fri, Aug 21, 2026 at 10:57:59PM +0100, Jonathan Cameron wrote:
> On Thu, 20 Aug 2026 16:31:21 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > The CXL Specification permits a region's interleave granularity to
> > differ between levels of the decoder hierarchy. For an auto region,
> > the CXL driver reconstructs that hierarchy from the decoder
> > configuration programmed by platform firmware.

Thanks for the review Jonathan!

The tidy ups and nits are always welcome as I don't want to disturb my
reviewers flow ;) I've reset my rule to 75, not sure why I had that set
at 70 columns.

> 
> With my fussy hat on (I blame Friday!), guidance for commit message wrap is
> 75 chars so bit longer than here.

Fixed up across all commits.

> 
> > 
> > The CXL driver currently assumes the interleaving root has the same
> > granularity as the region, with each successive interleaving level
> > becoming coarser toward the endpoints. This prevents the driver from
> > assembling an auto region where the root granularity is coarser than
> > the region granularity.
> > 
> > Support mixed-granularity auto regions in the CXL driver, restricted
> > to coarse-to-fine layouts. Derive each interleaving decoder's
> > granularity from its parent:
> > 
> >         child_ig = parent_ig / child_iw
> > 
> > The topology determines each decoder's interleave ways, so the parent
> > granularity and child ways determine the child granularity. Use that
> > relationship to validate the decoder geometry while assembling an auto
> > region.
> > 
> > Require the root and region to describe the same interleave span:
> > 
> >         root_iw * root_ig == region_iw * region_ig
> > 
> > The same span relationship covers the CXL Specification's Mod3
> > configurations. For example, a 6-way region at IGB across three host
> > bridges uses a 3-way root interleave at 2 * IGB and a 2-way interleave
> > at IGB below it, as described in CXL 4.0 Section 9.13.1.1.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> This interleave stuff is a rapid path to a headache :( - I vaguely wondered if
> we can use a few local variable names to make it clear which ig and which iw
> each one is.

Done. Thanks for the suggestion, the improvment is nice! The bare iw and ig in
cxl_port_setup_targets() are now child_iw and child_ig, matching the
parent_ prefix already used for the level above, so every arithmetic line
says which side of the boundary it is on.

I did add it in a prep patch though, because doing so here polluted the
work of this patch. But when we get to 'this' patch in v5, it reads so
much better.

> 
> I'll go as far as I saying I ran some "paper tests" and it seems right
> but I've been out of this stuff long enough I'm not feeling that confident.
> Good thing you have tests in a later patch :)

Well, I ramped up the testing too. You'll see new mock topology in the
cxl/test patch, along w more test cases in the ndctl unit test patch.

> 
> > ---
> >  drivers/cxl/core/region.c | 114 ++++++++++++++++++++++++--------------
> >  1 file changed, 73 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 4f367feaf6c8..637d1b60a570 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1434,6 +1434,16 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> >  	return 0;
> >  }
> >  
> > +/* Mixed granularity has a region IG finer than the interleaving root IG */
> > +static bool cxl_region_is_mixed_gran(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
> > +
> > +	return cxld->interleave_ways > 1 &&
> > +	       cxld->interleave_granularity >
> > +		       cxlr->params.interleave_granularity;
> 
> 	return cxld->interleave_ways > 1 &&
> 	       cxld->interleave_granularity > cxlr->params.interleave_granularity;
> 
> I'd go a little long to improve readability.

Done.

> 
> > +}
> 
> ...
>   
> > +static int cxl_region_validate_interleave(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int root_iw = cxld->interleave_ways;
> > +	int root_ig = cxld->interleave_granularity;
> > +
> > +	if (root_iw == 1)
> > +		return 0;
> > +
> > +	if (p->interleave_granularity > root_ig) {
> 
> This took me a while.  It's specific case of more general one that region
> granularity can't be greater than any decoder granularity in the path.
> I was trying to figure out what was special about the root :(
> 

Yes, you're right. There isn't anything special about the root other than
that its granularity is available before walking the topology.

v4 only checked the root. In v5 I kept that early check, but also added the
general check while deriving each decoder's granularity. If the derived
granularity becomes finer than the region granularity, the layout is
rejected.

That closes a hole in v4 where an unbalanced topology could otherwise make
it through this validation.


> > +		dev_dbg(&cxlr->dev,
> > +			"granularity %d exceeds root decoder granularity %d\n",
> > +			p->interleave_granularity, root_ig);
> > +		return -ENXIO;
> > +	}
> > +
> > +	/* Same-gran power-of-two regions may span multiple root targets */
> > +	if (is_power_of_2(root_iw) && p->interleave_granularity == root_ig)
> 
> So this is our original fine to coarse check dropping out nice and early?
> What is this letting through that doesn't get through next check anyway?
> If power of 2 and root_ig == region_ig aren't we guaranteed that
> root_iw == region_iw and next test passes anyway.
> Basically I'm lost on what this test is here for.  What do you mean by
> span multiple root targets that isn't true of the x12?

No, root_iw and region_iw do not have to match in the same-granularity
case. For example, a 2-way root at 4096 can host a 4-way region at 4096.
That is an existing valid configuration, but the span check would reject
it:

root:	2 * 4096
region:	4 * 4096

So the exemption is needed to preserve those power-of-two same-granularity
configurations.

The x12 mixed-granularity case is different. Its root and region spans do
match, like a 3-way at 1024 and 12-way at 256. Mod3 roots therefore go
through the span check rather than taking this exemption.

I also changed the comment in v5 to:

	/*
	 * Same-granularity regions below a power-of-two root may span multiple root
	 * interleaves. Mod3 roots are width-matched instead.
	 */

> 
> > +		return 0;
> > +
> > +	/* Mixed-gran regions must span exactly one root interleave */
> 
> Maths is fine, but I'm getting confused by terms.  This is talking I think
> about complete interleave cycles or maybe strides depending on definitions?

Yes, a complete interleave cycle. I was using "span" somewhat loosely in
v4. The v5 doc patch, now first in series, defines a span as one complete
pass through the interleave pattern, and I changed the comment here to:

/* Span is one complete pass through the interleave pattern. */

The debug message now also reports both the region and root spans directly.

-- Alison
> 
> > +	if (root_iw * root_ig != p->interleave_ways * p->interleave_granularity) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%d ways at %d does not span root decoder %d ways at %d\n",
> > +			p->interleave_ways, p->interleave_granularity, root_iw,
> > +			root_ig);
> > +		return -ENXIO;
> > +	}
> > +
> > +	return 0;
> > +}
> 
