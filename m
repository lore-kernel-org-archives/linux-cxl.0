Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93856344D8C
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146144; cv=fail; b=nnWANiZTAYI4D406aDeaZrcFAbLkKVcCXNIxIVx8/ch1j8USfDnHVr2WCMrTdQwD7YNre/zO8duZeM3BuWwFlCj8RJGXyURVsYHfrV/igaG0DuR7oO6Vzw+oUKHCXtTvrA7uEWKBXgSEAxajwipWZPvwNUJCksAWNsamxKmBU+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146144; c=relaxed/simple;
	bh=w/kOMDkrGdoQ84tntA2kUB+LpCqLeLiiwON27u5liNA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cvm8I6mMCbPHQDMEtYpVoh4iN1WQzFVkU2Wz92NAeP/NBI3bRxkTm/vwI7EXvPoOxMvLSDe8GPWMRQwfFAHDjkVu1W77z5VEkJAqtiJ9Fpajoxr+rzQW2genf1jSB/w27meLq9hKK2cWT4n4tfab7l9s6TpyvbyGPXiIqOmR5q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8UT3uzU; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8UT3uzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786146142; x=1817682142;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w/kOMDkrGdoQ84tntA2kUB+LpCqLeLiiwON27u5liNA=;
  b=Z8UT3uzUrAsBhLja8CuV3A5UNIko/bxBNQ3w4j/muH64Fm45snw+ierg
   34wp9bxUSXAwRDeyqDp3k4opPDePPZzDwacOWL1S7edQS5IhphQC2l9cg
   fiXaG5PU2i5NtUCHR//HSIaNzZzhIC92UzzZi+kQZt1QOvuGu9bF1TmK0
   jFe419958ADg4Af22nqskcUECjlJawL8zT6KraG8e0Kq2Y2G0YNvOBaL/
   QLSQ+QBXT0eiVEfhhJ17Drzxm/amHup1tAkjYaCU3EryRh5x/7nBfdJAy
   Eufj7XNrcEGjpZ0yYBOit+K6c+edTTAWxbtrenA3IPNTQTTN40fyZYwTV
   Q==;
X-CSE-ConnectionGUID: CCH6VQcAQUKmtbOj4Dt/jA==
X-CSE-MsgGUID: ezDmWBOBQhSQZi4ALxcRcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="98273207"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98273207"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:42:22 -0700
X-CSE-ConnectionGUID: uiHRBeR4QWWluGsL2+Bgkw==
X-CSE-MsgGUID: FAduMoExSF+de3vvFtlOFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="259207071"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:42:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:42:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 16:42:20 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkVnm5hfBIK58GuSs70Yf6+Tql2Zc1nMfG9WzeWdbNIZ2LYsQg6GCFP66zfSKpR8Ofq/v7s+u13lZBPT+lK5ks4DOqWboUtO9abMaUHSO4bfVpZ0ZFZ13eQShnQzp2zarkDoItLK/cYnt/I6Ng0wPzotaAn5rW1ADQFFaClzyFMYZFFSQ9OMNDVsy3GTzD2s+MLX3Ygv3+o6cTqcsBp2ReIf2MSNpNz5MfIebTZPwv/7ZQMleFZYdhUJkTnGKM0EdwzqFlb858D2jti5HQxJ3b4SmE3OMa2s+JxaX1mU/fI6zWCNM5/9SoZc1io+E2HBVAu75wy++rNg7g6aufVnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/mjNWso/F9VpVKRa46mVpQK1t1MGsKbMW0NlsL1ddI=;
 b=uV3nqN3dNh35i0F5FRPF/fJhxwrLbnwZ8I6OlhHSNDxPZHr5ZKxi4gNJq8Uw20XVDqTknWoV4r0BzIZ65/isfh9zGe6ximN1A0CEGyzjorj9J4euGTdtEhayFbxuQ7RlggNHXL3ldO86y9BbfV8foO04MexrI4poAnY2UzXFu0QTJkXUIt7iNfC1Rip5yyQuUziOPYg5pqKjNwrGIrJ4M6N/IoHftizTw/YeKnP1oa0PP1HmjaE2HCjQgwREay2LUDQ2/G8FvH9SWRMtcnXYMG5u9VQL1JwEsLvgi5PTJvGWD498dtTt/0+LwST6CtKU6xeBBgOPLxA8bPa6pRbDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 23:42:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 23:42:16 +0000
Date: Fri, 7 Aug 2026 16:42:12 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Dan
 Williams" <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v4 1/4] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <anZtVJSXBFwHo02H@aschofie-mobl2.lan>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
 <20260722015547.6c3bdd47@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722015547.6c3bdd47@jic23-huawei>
X-ClientProxiedBy: SJ2P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 351e7152-98ec-4285-9675-08def4dd8323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: oDbT97S7oAP77qqXmlQ7wAyG72snVEvTseTWU3n8ITz+dWYLN6ItvXndV1aZSEvYGN3Y99eDR3ABiYIT7+hapUQEZKB7/XiUIMw/CG/uKV/sjWaTSE3Tj5mLexcKD6FsDhFRnl9XnbEAFkI1mKPabMhfB0zUEasSjPeOsQFIE7PQL+3vxGChgdF9Udz3Wv5UDE0srPlMj6DS35r1MrJ7TXoihB5lRKRkkUNwOq2elP8cVPU0wa+9daDLY84Lq09M9RU+IwCY+F3A+58Ji1ma8w3Cxm4f+vZ+fGNv8IC5g4yMHcVmnhxtu2/gpSC1+xVJR6KM+hMd+PXsaCjR7VtqywmnFirl3CxcDGVIXPL+j+16ffKbl5SUB0lHx/8wgzFUaGsVa8UazIqT7RZ7roa3YXxCYwR21+Sjx3Y+HmygQAZoY5EdPSsXs8VcQjwQMOp5PVwNs3JhDKAJIKt9RXAa7JTclrxYbURSnh268Yi6nR2TwhN4O2c4ebhKPY9OgrJpMk/Jq+qlYdKClfyHjE3K29B01/bIhl60hzLO/j9T58AREUg9Y8O3prHKjHFwkxQkBlXsS2aZqBzXG8E7DwMkGKWMZvsKzJcuF1kZYfaGnTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TXos1o4IPW/2Be3ZUV7Sc3YF5jJSqe4B0hvwJnT8i7V73NXuEVQHs2i1spxE?=
 =?us-ascii?Q?gSwKE07HIwYUEo2H/RstQ6oLtDmtNYU1ZFeABH7KD2jMJU5cN/rWsymeFUMc?=
 =?us-ascii?Q?9qYghAo6fwciT6miO0vZLDrBtar3tJ9fI7J8MhFuVXcLdQbYkxwmOqSCwxur?=
 =?us-ascii?Q?rhCVFWcY3DPkY297Wu/4iHDA5Zg8CYTaDs77qI5s3jvNarYN5d2q16cJYwdA?=
 =?us-ascii?Q?iGQzYOuAdTY9IvRRuJExuWAA7DZGqb1+vTHLEizYJkBpe5dRJbxfVCokcf6a?=
 =?us-ascii?Q?dhdWvkTKag+yHPASPyANSwWOx/02nlcYimNwMW/KcFYSUGIks6kiZGKJD0+l?=
 =?us-ascii?Q?VbtBPfxlMzsBiBWUobYNUZbJvIXPpMM4y2ThWqOpgzwneISFvunTdyM6MSCB?=
 =?us-ascii?Q?PUlE8su/nZganuGhhM3HYFlth/+VCagL1iZcIITpDb6pIk+HwA05pzomQX08?=
 =?us-ascii?Q?SUZ4PadwQ5OyH8b+YAytGxXRmBp6OWmyl85Qef0uO5400CyUkB4VUUIVCNz4?=
 =?us-ascii?Q?y10UieMopBMjUN9qR8llayriZIeh8YezDfszOgBkR1z2dzzE2xirgn396m5O?=
 =?us-ascii?Q?5O9A5DtVgPv8HlOvGaJGLGcG19i6LZSkckOANwEW97N4LtKlK45BN8LvdT33?=
 =?us-ascii?Q?r4tTu3k744SmwFD6jrLm8IFMigeqy6ugJ8ROCmr4I2r9icWHnFrYZqbuz6nJ?=
 =?us-ascii?Q?sLMxpTABfvr7AvqmJGSNX/I2DKYLxHwlL8DAor/DQjtb2s4bNQT1LgviJye4?=
 =?us-ascii?Q?176dM0ttZcBQZtoYjEi6KhGiQsMZtUutFCazi/kELo0aFeWvV7AQDaFCeI9Z?=
 =?us-ascii?Q?3p+2+OJmCnDzGH2bUtyI5REHMnGnSKlZCQUW2DrLG+cgKI0JHRael29D02sd?=
 =?us-ascii?Q?K9nNo+XZ/7R9jNM18OyYeOQQTwi6ASeH9KbuRWgvGDFVLjMhpGvCh8LuLsWO?=
 =?us-ascii?Q?LFoNHzEv2+pGbfX/ZY1hWbVBcfb/M10cjvazuJXCHOU9C1mrZetHV6lzuKFr?=
 =?us-ascii?Q?tOH1XkPaJYMhrM615EeVPCYaiLqIUp5q73x9T0XrMFtWQBJPT4V43HB3BkmT?=
 =?us-ascii?Q?8MhDBkOcvSq7Gkr2Sk09AKmtBYoWypX6AfM4lbQPbjYP+iSncAiOIwrCKgCz?=
 =?us-ascii?Q?4D41rxE06ZGNOi9zAefSa4UOWmiNeGNAUwHWA2f19Bykc3l4p5th80OnsqgN?=
 =?us-ascii?Q?v+Wlyw4g+JZF3zPX3aHcroE9/Z59tei9OPd27+d47xGs0Fvy1SeWkmaAtbX/?=
 =?us-ascii?Q?eRv3qUCEmCm6sg5HCNketSfb9NgSO8sgZ1zyMhGbXrUunqnX4wM/u5s8B4hn?=
 =?us-ascii?Q?9aepmjD10IzMjeeBc60jeddWCJ/e7/2hbDxKAnqhgXpl2DdyM2oeK3LuBnp1?=
 =?us-ascii?Q?YnTyB1u3zE1kDHmvd6ZvpO2EsGaRjwhbNbvyzc0+B8cheMsfCm7f0Vbq8fMr?=
 =?us-ascii?Q?SEt7q6Bw7Ph+ZRTePp5ZTj4MoBQstQ7otOUI/YB7kzMjSCpU2mOtILOqJwfY?=
 =?us-ascii?Q?Ia0WQbhtnm0I/Epdt3RR66l4NnYzDbHk/396PZvBvyxp4bUoiKE/wOP3qErD?=
 =?us-ascii?Q?DFe/XxP/eJ3tYHz3PckO+ixVkA/OeB3mlCYA0Wq9TjpInzBeGX4wnTNc1UC0?=
 =?us-ascii?Q?+zc/E5D1ofDcvdvSGGzK4x6c6vDgworWZFjL+07SJX/NMnDAUhfhIfDoh9za?=
 =?us-ascii?Q?cayBD2oH9d7FpZo72lg9vHgZ2B2yAAme4chVGPIK2bBGCntyjFuzzimfw3uy?=
 =?us-ascii?Q?gg2wTNc11qTaUNfDf9U+nFyZUV0qtec=3D?=
X-Exchange-RoutingPolicyChecked: dToy1Vj1bI8O8myehLHBRe9uYKB4SIwkNwcmFgnx5ibMu+Qk8/Iq7xlfpESKcSSh6yEEnlFcZCm7Z4tGUF2EOdhRC6ogLddDOv+5h97P0w0h7ZXodRh1f3gfuJqKxNb2HC98JRLHnLng0qpZI2X/kgoEmHdC+HSYXAJFL9lsE1Gx2d/HROWte8JBhJ1pr9lvrnILA+Qo29h0JgTCp7vO/EIXLvdMCMQyxR8gF8EmjIU2qdJ1u6E0Xk73eDFU+h6uaqk8fKgkCWLI+2tXY4PIYQeePcN/HjPmXQT7q7k0jPc+rnTlhCmKicWuOCJkWdkE0sotmOwnsWcyGY8sCZs/7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 351e7152-98ec-4285-9675-08def4dd8323
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 23:42:15.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjE23s8hCRH35/OYQrpqi6Aski9MusU2TBZW/2yxr+Kklqf2UORzgBRpQKaUB3VvDnXzt8nJIkIzSZ3/Mavuw22Yb75KhQtQo3+a5N5SnCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 01:55:47AM +0100, Jonathan Cameron wrote:
> On Mon, 20 Jul 2026 18:59:37 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Switch decoder enumeration validates that the interleave ways encoding
> > is legal, but not that the resulting number of ways fits the available
> > targets. This can overrun the target arrays during enumeration.
> > 
> > Reject committed decoders whose interleave ways exceed either the
> > hardware target list capacity or the reported target count. Reject
> > switch decoders that report zero targets.
> > 
> > For uncommitted decoders, ignore the stale interleave ways value and
> > reset it to one until the decoder is committed.
> > 
> > Add a clarifying comment that target_count is a direct count, not
> > 0-based like decoder_count.
> > 
> > Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> > Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> oops. I replied to v3 after you sent this out. Please take a look.

Reply for patch one is back on v3. It all was still relevant for v4.

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/hdm.c | 33 +++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h      |  2 ++
> >  2 files changed, 35 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b..d81df45d8005 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> >  
> >  	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> >  	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> > +
> > +	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
> >  	cxlhdm->target_count =
> >  		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> >  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> > @@ -1084,6 +1086,37 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  		cxld->interleave_ways, cxld->interleave_granularity);
> >  
> >  	if (!cxled) {
> > +		struct cxl_switch_decoder *cxlsd =
> > +			to_cxl_switch_decoder(&cxld->dev);
> > +
> > +		if (cxlsd->nr_targets < 1) {
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: reports zero targets\n",
> > +				port->id, cxld->id);
> > +			return -ENXIO;
> > +		}
> > +
> > +		if (!committed) {
> > +			/* Ignore interleave ways until commit */
> > +			cxld->interleave_ways = 1;
> > +			return 0;
> > +		}
> > +
> > +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\n",
> > +				port->id, cxld->id, cxld->interleave_ways,
> > +				CXL_HDM_DECODER0_TL_TARGETS);
> > +			return -ENXIO;
> > +		}
> > +		if (cxld->interleave_ways > cxlsd->nr_targets) {
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
> > +				port->id, cxld->id, cxld->interleave_ways,
> > +				cxlsd->nr_targets);
> > +			return -ENXIO;
> > +		}
> > +
> >  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> >  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> >  		target_list.value = (hi << 32) + lo;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index c0e5308e4d1b..291ada46b646 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -67,6 +67,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
> >  #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> >  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> >  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> > +/* Two registers with one target ID per byte */
> > +#define CXL_HDM_DECODER0_TL_TARGETS 8
> >  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> >  #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> >  
> 
