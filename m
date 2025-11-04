Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3334D3A7;
	Tue,  4 Nov 2025 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297357; cv=fail; b=VBFmkJD1azcEoSExHoKsCy8S78FVAr6GbpvoiZQ0gj0uVeKg61vTseUHSalDBDt4RyumexbX3YaTDB1lF1TkwMi7QO1FlOwlUX9DVcVM1CCg6cD2u8RwZ7VDpOWzRprDgi+qFyiE9owe+lYwIV5KeNA4OlEItqB0xe8HLBzMXuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297357; c=relaxed/simple;
	bh=DLK5C1Bjm3bl94uZtbXAB6oRDJOQMHkQjo3W0FSswOg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aA3XywtNdcgWK8myeW1eUgGI0hrttOjYbdK89Vnk4VzxtbPGicas5qXgr0QWRFG8AgCUoH6vUtFr52IxNusTlcvYcFLBPe5dFgyh4k9GzUquD+teyj7iQagEoFNuHZE9Lpv2PH5hdfOkgTbPXTJ9dYOqIe9F6AeiqVJHDdQuD4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJqQycZ2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJqQycZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762297355; x=1793833355;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DLK5C1Bjm3bl94uZtbXAB6oRDJOQMHkQjo3W0FSswOg=;
  b=BJqQycZ2Hm3X+h72Vz6mZgalBB8VxVVFyezPwgAFxSibMp0SQltGh4uV
   XE48pNnR2ptQOoCV/sk0abR0PsXL183ExId0kRWcdzGIlFJu2Zm4j3t01
   RnyKqNGNeBDxwr4ohPp+H9BzyTeVBzDSfX4JGjPI40DgvcoZBGm1Dd2R7
   TFax5p6Al+iZTxtUrItMzfLNH3zSQ8mYK1gfsGAEHfkrnpvHVrtCH8aGb
   oaTe0rBEY3BMkcvZmIgUNowUbJlUM+PIGFyYSDJrSJN3n2Qb2T2VjxwaU
   SDQrHXusCR+3d0ap/f1PUHRcR8RXNFBGBDPKE4amiMXypxF36lWZQOtUz
   Q==;
X-CSE-ConnectionGUID: VC6fo0qMQ0yktkT7bxYIbA==
X-CSE-MsgGUID: rqAx4+GKQiyVIzK2KU0Rog==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75753641"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="75753641"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:02:35 -0800
X-CSE-ConnectionGUID: OJtd06myRCuhJ6+XmzlT5Q==
X-CSE-MsgGUID: GbjYbkk4RMOeuDZSjyl55g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="187730337"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:02:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 15:02:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 15:02:33 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 15:02:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW6IScbj+XNJqjoshPOUZGY5xvDVQc6LYEMgegd7EZG5VyPQpzDgGyWTCCoybUKzydgGbFijaP4grdSdGDWv1TaYBpBMqS38Ruo+DhG5yjZwtYI1bmNwVmT/vBaAw/R8N/StQd05KrRKEm8cs4fMhakM9EnSV+YNSVhObw/pEEvFPwoKoY/TuTAylV6zbdG+en+3L6xkm6n5o70iGhJfiDhrFakdTeHBpRjI9g4GBEhhSXMHyZ1n9EduMVEBnnSxWf3smVrQAHbQ1MGP30cd9ivGMfI9dZ0McskNw23Q6H6HePnbFMkT06e9D+xvG92mgx+OvzqE3Fmdsu3vAlNb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLuC/MwSKXsZ5Z2gF04WcmfucunWVOhRejOd4YcymDo=;
 b=u9zSBboYuq4tcw1dGmZf+MsNvuhsbIJ8A+7i5kRJUQc9wRqvqhr194L89srGZ1jwj5zdl1zklyyIv1IquBCf1v6wayUIWbOqu1MQ6Kp0DT0C10YYRpfj5kv7ZDpia3DW/dCmKSM1Q399xSC46pZwWUWE+D51+4v5AnVOoqE1AGZTbZYG+fufsWXd1YBiFcaqnYjT3anFKNuWekIm1waJRU/i9a7FH2bb1HavlFeWZri0ND3HjrVLhnxZbtmTy+x36S5ER34H+yqQsP87mBGkIE2kSpXZnriTRnyyQ1OMu0UaEUPAtmiQKwvPJqO7TnRYho6wVkt/sUj6/YxhmaG1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 23:02:27 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 23:02:27 +0000
Date: Tue, 4 Nov 2025 15:02:19 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 12/14] cxl: Simplify cxl_rd_ops allocation and handling
Message-ID: <aQqF-xCnL2Ugh3hp@aschofie-mobl2.lan>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-13-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103184804.509762-13-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: c762f46a-8b51-4cea-3190-08de1bf6396e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?boRGtNlqmT9LTUjFSofyf/pGWMbmx/STaKPDVBFNEIERZ7A59tOAEGoX4N+3?=
 =?us-ascii?Q?E+l3fDGdG5+vhoiI4GhrZfoWdm8vXpTgihIfAC84VmKXfmEpeeUOikTVX0x6?=
 =?us-ascii?Q?b9MY5rf5b1zxKzwW6X8cknAIaCy8LARjIYYM8gfxiYSXPD6zWrpW9iiu0+F0?=
 =?us-ascii?Q?4sHDoaRb3g4YMg0rgIaT7bvI/25nFJkopCqpfhwduWcIHoeKtWrfl3xW4aMA?=
 =?us-ascii?Q?Ip0tjmoIHLje+BQ1GMl2J4JiiyQKW3QMSxRh1X1ug8IthwcJkq+d0+srmcFZ?=
 =?us-ascii?Q?IyHJCI9eRr2sK0om4tmGKqxwBEvHAcfROq8UC81gyKiPSI4sro82WQKcx/mm?=
 =?us-ascii?Q?Ol8lnzca7xEZd5UjYicjh/fy+p9D3SmBqcumZ5NxVG7dDks/dk8xeAjRQ9VG?=
 =?us-ascii?Q?I0+h1TBiHpbBP5wKHTgQf1BL4Yg7c8iYiwSddBmgvxk4SNHE9XPk7GrmQiQn?=
 =?us-ascii?Q?iQHa8eAAwE3p/CUGe+t0z8jNSkJ7FDojHIfIftLJwpGxPshFb2j4AXifcRGu?=
 =?us-ascii?Q?oe+Y0fUJlbJxBfJ7a2HzxrPzIB4lqEct/UsqS0u2O5Rj8vaXYS8mJKebOzf9?=
 =?us-ascii?Q?FO/fdTJYpDcBvQgHZiECLHrgATBNdhQwrTM6oUKnB8DBTdE30KJq5oeRAfjm?=
 =?us-ascii?Q?blf1V1aJvcXS+TfjCtEiellIj34F1IfC5M3/taJ9mkRAkc5ttOUNgmfIERfC?=
 =?us-ascii?Q?I4uuFVTlC82Ghqp03o0bGbchKcsNYMOmpbmcnGMsR4kAv4MMKBc0EB7TBx2G?=
 =?us-ascii?Q?QLMduLUye8DPyMHT6xx2eJbhvaP19WFEVODl8G8wj370UGK6gYdw53cdLXii?=
 =?us-ascii?Q?y5L4wqCkQ+42P+JyipcR8Ij2epYSUZ8L0qsD4ZxjxQuNkgtWLv5wo2e4ahU2?=
 =?us-ascii?Q?cISLG5dPuR3WZQcfU7+J+2angXU++RRNuyLrC2TtOMdcWIR7PNljBbehIFrn?=
 =?us-ascii?Q?ir3kRvjuB1rHUCiH7SzqaFwI7Lt9dhwnNovr8Qip1PmscHckq8DWICKOOC4i?=
 =?us-ascii?Q?IWmPb1We4t7GgFsdpaAsyCWcILGwAyh+CbvQYNtsu9wQFoPoCmg4YVEgFo87?=
 =?us-ascii?Q?xHiNglfEwFfUUIxKh7YyxW4WmU7jdZIGfGAkpmBen85AA8054jr2+amM7bm0?=
 =?us-ascii?Q?0rsVA4mYeJoXUL1I4TPKTTuIFPhnr40CQua70skryFGWbhTINYRMEZGCtweg?=
 =?us-ascii?Q?inLWTYxWQMrNAzQXeLuAUZGpf8bHN9XXpNJthFCavT/3JR7Jy9k+g66CE7Lz?=
 =?us-ascii?Q?rNSfpbrev4rmxGf12UDWBF1EGsAv7HTykhEPhXf2nzJ67JK+OfC/ChUaTTu1?=
 =?us-ascii?Q?tFvZ7vDKQcfHrvOr8WjzBpC/dfK0LOwVrlMh3CCaAzxIeARAm/8i7sJBym6W?=
 =?us-ascii?Q?Z2J1VDy+kBQYlqExKqY8PB2kKkIG0KLYiVdsTw5vg8FQyqyP8FWQGqEEawir?=
 =?us-ascii?Q?r+utFgtBnzG84ngIXCJyd21el3AE1MCn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8+DXM2xUQXZ2BfhyrVgsTQHmGcdqnUIRxGpWeIpDryzw5X3ou4rI62l5OT5I?=
 =?us-ascii?Q?gUpAyH2cAeN5Qt6Tyl3ypgcXufSjBBC8JTOQSk5q8LqzKl3RvR+PU4djB3bq?=
 =?us-ascii?Q?mLfSgiO1bYHtIK8R8SS4NgrEkvbFTSYI86vg4oOF8f1+W1Mx26ft+mvosW3c?=
 =?us-ascii?Q?4lY2KTIZd3UtZuArb65lQMWjA1W92YL5L3Xxyg+yOAJoD+x07F2YdklE9G0Q?=
 =?us-ascii?Q?RqIgDK2o599Bt3YoaSDPjCwFDGRmm0VKQcffIXHILSaMovB/tFsEWGbG+XWO?=
 =?us-ascii?Q?ns+XoJiYZjkzPLw+u49vFbLiIdYujxwoUIIfMeri4D7Kl0r/+sAuL8Lkaw9C?=
 =?us-ascii?Q?fj4y8A2St7OowyynDhnt4lF8UXcv5Xq2r+XT5h0c4zmKGzJn4IJJjxRjlqgZ?=
 =?us-ascii?Q?H8v9w0ax5UiuM23oSVVklI6B1lXkhtiTWgrRT2LgOl/C9fNf0hDHSeVQeVk5?=
 =?us-ascii?Q?oagONRiWoaNEv8lAA9pNPJ3vd6gyWo0mMu754fcOsKdsnB89h1UWMOvCMgyx?=
 =?us-ascii?Q?bZ0tWo1Omf5UpEZD633YWNkMqxFLJ5vJkienC+zHpvPjxyM/Zr1JlKd/S8fa?=
 =?us-ascii?Q?JoOQ+PTVkAWUXo59TLirdvlsJS/hg7Zrc0Fj8cZLaLz6twCPQvG1mNEGwZBR?=
 =?us-ascii?Q?hw7Qo+erAeg8s0Bp1Q0XU5Kk0NJzKqFzxAKgqYDE9HwZuoszNMtPND9B3EnC?=
 =?us-ascii?Q?9LNWNcl4rW5Ia9+EvuWvfIx1NEKKeGEwKxr6cXoMXT4AymejPyl6o1kTJORH?=
 =?us-ascii?Q?tPozdbfjXOpRvHhwP6ugBxxlgWLJIoZIJYZ9BPI8yCXD6VyKSFFduy7hM0Kl?=
 =?us-ascii?Q?Acfxlu1QcjFfT+cbq5A6NqdjHOI8bQQ9+UQHP35fLjU+ocU9UG3tq65lOATS?=
 =?us-ascii?Q?Sv8bDvjdMBziQErxX3HJHQZpE9DWJWZrtrFyxuZSlYHWXr2PFpgpKHoSjZP1?=
 =?us-ascii?Q?/XznXia7UuQp/8SZo6V3TlEOIh3IjF0j8CaV1hnfyqpi1RIf9cc3E4sX0yx+?=
 =?us-ascii?Q?vF9L8+JcTq2RiyM50QkaQTIAXhUwPC5YZS4ZWi2Oo6i9LQFbknbdDh5amCl7?=
 =?us-ascii?Q?uz9NbbVUcQyr0Tnqgqcaltx0WNALcFJH9epFQqNvzL/oYngESXrdzD6Cck+b?=
 =?us-ascii?Q?TL1TBBisBaSsEd1LJOzEPErspffVe9kawo8N0mRgj6VGvJATjn9BmHG0PcGm?=
 =?us-ascii?Q?ZV99Tv3Q+tXUbYJeyeVuqr0pSWzKRCMcJVkfzACxPcYR6/BiMJ/jpK7bCTUg?=
 =?us-ascii?Q?dm4PKgSSCsi8cvIE/GJLaAGRVUWVYYKy82MZN6OTcvRYHhwxG+1sAuL+c8IV?=
 =?us-ascii?Q?KM7sj4YIQwEPxfBZES9tvJS5HQsL5wlfl+v6YtFiyXpmCHhi/OcwEClQLvuO?=
 =?us-ascii?Q?88UqfxA9kkOLwVKYwJw2R9nexSTqiwj2QBmODuP47ZxTvRCH3YF3q35P2fqZ?=
 =?us-ascii?Q?1mEfJwSUv4l6TaNRhKS6W9javs8xCegSTLtXly4FYNtG0ydwcp+JzOxsdoPx?=
 =?us-ascii?Q?vlOwm7kVTtXOY6UuAsSp6SSA7hi7vqf/5N8OwuWgq2aJRCquoxCoiO6iARg9?=
 =?us-ascii?Q?T0x0hYD+HHcttcPferRMu1vsCpTB/QTgwulBB4EQ4na5ePumDxeakaLAyxyT?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c762f46a-8b51-4cea-3190-08de1bf6396e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 23:02:27.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6OhEjCOAQrtYtwLZV1R7xFdGS3/VIHSZZksHeWuDENYMYROPDw9HLFKCEUrVtoYYt0eJsu+vDe9fRU9WzB7pd4QG3oUKoXCKIuWY4EgOX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-OriginatorOrg: intel.com

On Mon, Nov 03, 2025 at 07:47:53PM +0100, Robert Richter wrote:
> A root decoder's callback handlers are collected in struct cxl_rd_ops.
> The structure is dynamically allocated, though it contains only a few
> pointers in it. This also requires to check two pointes to check for
> the existance of a callback.
> 
> Simplify the allocation, release and handler check by embedding the
> ops statical in struct cxl_root_decoder.
> 
> Implementation is equivalent to how struct cxl_root_ops handles the
> callbacks.

The allocation was intentionally dynamic because the root decoder ops
only existed for CFMWS's defined w XOR Arithmetic.

From the commit msg:
>> To avoid maintaining a static ops instance populated with mostly NULL
>> pointers, allocate the ops structure dynamically only when a platform
>> requires overrides (e.g. XOR interleave decoding).
>> The setup can be extended as additional callbacks are added.
See: 524b2b76f365 ("cxl: Move hpa_to_spa callback to a new root decoder ops structure")

Has the usage changed?

-- Alison


> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c        |  8 ++------
>  drivers/cxl/core/region.c | 20 +++++---------------
>  drivers/cxl/cxl.h         |  2 +-
>  3 files changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index f9bbc77f3ec2..778ee29430ea 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -471,12 +471,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	cxlrd->qos_class = cfmws->qtg_id;
>  
>  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
> -		cxlrd->ops = kzalloc(sizeof(*cxlrd->ops), GFP_KERNEL);
> -		if (!cxlrd->ops)
> -			return -ENOMEM;
> -
> -		cxlrd->ops->hpa_to_spa = cxl_apply_xor_maps;
> -		cxlrd->ops->spa_to_hpa = cxl_apply_xor_maps;
> +		cxlrd->ops.hpa_to_spa = cxl_apply_xor_maps;
> +		cxlrd->ops.spa_to_hpa = cxl_apply_xor_maps;
>  	}
>  
>  	rc = cxl_decoder_add(cxld);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 379a67cc8e31..dec003084521 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2932,16 +2932,6 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
>  	return false;
>  }
>  
> -static bool has_hpa_to_spa(struct cxl_root_decoder *cxlrd)
> -{
> -	return cxlrd->ops && cxlrd->ops->hpa_to_spa;
> -}
> -
> -static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
> -{
> -	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
> -}
> -
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa)
>  {
> @@ -2996,8 +2986,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	hpa = hpa_offset + p->res->start + p->cache_size;
>  
>  	/* Root decoder translation overrides typical modulo decode */
> -	if (has_hpa_to_spa(cxlrd))
> -		hpa = cxlrd->ops->hpa_to_spa(cxlrd, hpa);
> +	if (cxlrd->ops.hpa_to_spa)
> +		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
>  
>  	if (!cxl_resource_contains_addr(p->res, hpa)) {
>  		dev_dbg(&cxlr->dev,
> @@ -3006,7 +2996,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	}
>  
>  	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
> -	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
> +	if (!cxlrd->ops.hpa_to_spa && !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
>  		return ULLONG_MAX;
>  
>  	return hpa;
> @@ -3041,8 +3031,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	 * If the root decoder has SPA to CXL HPA callback, use it. Otherwise
>  	 * CXL HPA is assumed to equal SPA.
>  	 */
> -	if (has_spa_to_hpa(cxlrd)) {
> -		hpa = cxlrd->ops->spa_to_hpa(cxlrd, p->res->start + offset);
> +	if (cxlrd->ops.spa_to_hpa) {
> +		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
>  		hpa_offset = hpa - p->res->start;
>  	} else {
>  		hpa_offset = offset;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0af46d1b0abc..75fd45ddca38 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -451,7 +451,7 @@ struct cxl_root_decoder {
>  	void *platform_data;
>  	struct mutex range_lock;
>  	int qos_class;
> -	struct cxl_rd_ops *ops;
> +	struct cxl_rd_ops ops;
>  	struct cxl_switch_decoder cxlsd;
>  };
>  
> -- 
> 2.47.3
> 
