Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFF2586EA
	for <linux-cxl@vger.kernel.org>; Fri, 11 Apr 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394226; cv=fail; b=BGTQSbbCkR3bgSyWukcfqixUyOGx2OHcyCcIaj5m5K8NsVfv7c9l9Hx4bRNnHo+4I8V/hUFOjemIlPaJek+lOlSH1t458AvhW5f9BX0AGRygKoZjGnBk38HB8ksF/btFviSiOMc0p6D1HHFMPvFonFigyNVG+y7owM4Ze0i2qVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394226; c=relaxed/simple;
	bh=yw2g2IhpoSHtha0YqQPsKX3Ss615t/dMnui+op7XTgU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J/GzGkPKD2k4Za4AhEYSna6Jae+0WRHgy0MG+y/rBvkay0B1zUh7lhakIKqmNHzoNjZ5EwE+4YgV1lb8jG1Sffl8JDmFk22N6dIT3WAeZFYJakaNwL1yTBEqd6bBY9br1JIDm2HC8wLx/Vehxb+luwGjt3sUQD1Lk7l0yZLc2lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ubfbsrqe; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ubfbsrqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744394223; x=1775930223;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yw2g2IhpoSHtha0YqQPsKX3Ss615t/dMnui+op7XTgU=;
  b=UbfbsrqejdoAJKPDqCbPW8ELfqvaF2u5iHrV1YtnL7hwTJuGorQao8z7
   gtDtN/d6Hi4g6ePyXt4YqL8+ScPIkBgmWPnarFn56Igwghe8SHNJPAP+3
   jLnh4xQUB+ole/MXwqtt5d4ef4ElhGCIEbmKLQcK/jxeTvLT4s6gZ4OCT
   DxM3fnQ/TBWV/aohhWDXQEQ/yWWt9EqKWK0kNn04EUqiAH9JE/q62xhrl
   4HzAY/qh9Y5QeHoBucOsNmxg0wO0SGjxX0jJz3Pyorsbs7Fvu0PB9VmM8
   NLtnMkHNxOeDSTxuqFqx7e3YjRXnux9hz1miVy3V9vmruOeDSzhGm3Z4D
   g==;
X-CSE-ConnectionGUID: bvQ44RC2TDGL+tL6QeKk3g==
X-CSE-MsgGUID: C6ggETChSf+dNKOMQ2rPZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45663960"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="45663960"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 10:57:02 -0700
X-CSE-ConnectionGUID: CP15+REwRgy8UIwUFKzqyQ==
X-CSE-MsgGUID: bFw64RHyQeaENl20v7Y2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="134414906"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 10:57:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 10:57:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 10:57:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 10:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzydQ+w+3aSdyWHdguEQT3aR05Fn+iYxKel9WMzW5ckESCtsMdVe7MllKLxyjbdxFV/HRbXBrVs5DifK0I1/ot8gO4Oh3FOmJgI3eJB0y/dzYPWyczh8JtRQb9wUfbWDTbJZyejSdLHBR14ckxuPH7Ue3owyMykmcRMdcJ+6zchJDPfpkZoYE0fa7AZWZtntKfCEquYgxM/pb123S249jCOfRN2wzJXD+2mg2pC3Gqkpsl3YGP6xiJIR3suxstbF3s2oFJlpMBBu+ow2i9vQuK2mtaZ6UCJng5A0CMYB3W/h8b7F9QrO2rSLxw14cUeHAI3b/pl3TbO7pW/QsS4Orw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI9WD/hsvWbT149trz/h4otgk0owx+okhdoIogArOxM=;
 b=BhjtSENKypDsU+dzifH2OGJ6lDF9wptCzVIbyFo6DR6PbZ8GEtXMv7QDyLSVXpXbcSk16RFK6YQHXxoF7ZnYZlrAXauNATkFhNd0py9CZLmcPuQ5YWS8Bfvwby8dWdQJj8joaWpzKCkEXondcT6+Rc8R7SnVngROTPxtkjxBQQNXTXQRAHrFTaGaQBqNovj3rNrPtHhcr4GjhbsP8PnFVbd3AMbfWmJ02/PoYd2mhARa+2/xwrtrVGS2mXy0Ea+5H2DX2E1k+nVWKSWLlCWas7wBZn1GuoiZHXNBINJ4dq0LhX81h+f0uzJ1Ou8hgTv0Mr0YEVLwxr6VQuD/1dyd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8766.namprd11.prod.outlook.com (2603:10b6:408:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 17:56:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 17:56:45 +0000
Date: Fri, 11 Apr 2025 10:56:43 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Li Zhijian
	<lizhijian@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] cxl/region: Prevent destroying region out of order
Message-ID: <67f957db28b12_2ce6294d0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250411085218.120312-1-lizhijian@fujitsu.com>
 <Z_lG0JsvfS0husxj@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z_lG0JsvfS0husxj@aschofie-mobl2.lan>
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 610794b7-3bd5-418d-b22f-08dd79223941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+3CIMC1rtFrqvkRMTH/2/Fj2PCDe1KkKGVSK3Jmij+wwTLpDLh8MZjuIBABP?=
 =?us-ascii?Q?rHL9Eue2BEMjYUZaMi+Djha2uKFlFR1ayGLjdK5COjG/u48fWVjW3lCV0aDb?=
 =?us-ascii?Q?vzBZQg1r87+jfyKrbhYUN4Aw4SAuElk06DY2ObuT7PiPLxMgStqrvVxEmPMG?=
 =?us-ascii?Q?fTzpB2gCn+oEGLwAo72d++48xu83i8+Qxy2yIcpkbbcXENTCfmEqyZMmxjR0?=
 =?us-ascii?Q?rpsa3q6AqXICQPPdCuQSaVrGdPp9sq9xRVil6UQa/TT0/Sc6sFr0vMxlzUVP?=
 =?us-ascii?Q?sSszB17xqEtLcveGHcRULpzxfBzJ9CyZH98g93kivnEllloky6gd7v+DLKZV?=
 =?us-ascii?Q?fF/gI+0UL/hf1ApWVn6VD8Hum4qIAd3m/3uV3jJlhAndOtcT4wezICV5v7PR?=
 =?us-ascii?Q?gcy6dZT3gL0MrnC0pDaGGHj2tMNrLNRQ6nXAmcJXTVtksZJQmMDEddsO7ceQ?=
 =?us-ascii?Q?+oDiR90sFKkQ6fOdh/OtJLcs9fGhsc8P9pezPlCgeCTxgzeXZh0e5rpQ9xZK?=
 =?us-ascii?Q?i0WSxL5mBcbkMgJ+j2GCgosDgffVsjSewKW6oMfeWOfTj4HdUvgxnNRLM3/c?=
 =?us-ascii?Q?Amly3kv5z5++yJAOCa9wLgH/LPl6EdLau+HXCsrAI5WBeObCSlG/8Q0/lEYx?=
 =?us-ascii?Q?x0Dtik1QZIkaoBj0eKM7i/gol3wjrbn2xP2jyDgnA/Y8sWgFGFJSJVv6Fw8b?=
 =?us-ascii?Q?9W+Zn+wcJhZ88WLWNHjaIrTxLrhMLu1IV8h6WN+VEgcaYJIogoueK+bMSOAQ?=
 =?us-ascii?Q?Av+GRc7GtWN0Z/6OYQyKFg8BOE6v8iZ/riHnJ8/EBDsyr81WOHomUtyPLafz?=
 =?us-ascii?Q?xJGO8f9ERbj8gO+5xdECSs2d1no7p0WVWiAB4SxOBLDTuvFuwur5lSvXxhLI?=
 =?us-ascii?Q?JbRfPRPPDhWTFiELJgr0M9EQ3vO/ZJD1lkOVrDEKCAOGfnszQoqsCaE2xcAp?=
 =?us-ascii?Q?bnk1Bmm5X2rcn55IXZBUjV/vRWzP5jS2gfYFVzd2TRh+6/KGN8xMGgWMUg/3?=
 =?us-ascii?Q?5XcbgD049KytzPFB9mfabmTLTUNbzomZg3jlVzH0lWFaVwebVqJi7mjku4kv?=
 =?us-ascii?Q?R4sD/lc7WDwdlyNp9zt8vUYQ7Mfzsd7jK/8KHwAOXSXP5WNVjQOKILiUNL//?=
 =?us-ascii?Q?a2ulMTBFLad5eGYnG93ODbPxj4qsUzMO0I9hYtaj3JzZVbZRafWItbirTvmN?=
 =?us-ascii?Q?FUNF4m/81tTSNVh87b0nZ27t7FqS5fX2V+5eB7WhVsyk5P+ZTD5+zXLdAJwp?=
 =?us-ascii?Q?6fw3v7wSu6yw+JniIr4uNCKPFWIBxJKU7uE+EbUeB2OawbidNKWtwegURUrp?=
 =?us-ascii?Q?exWiOOdm9/5OIQjnP/EIMUJy3bgtGVXLw2N2M7VA6soFgQxPvIUvGtSV0gHI?=
 =?us-ascii?Q?JUHAlihkhZTbo1TI8RmWuVzdK2SBUBbUWZT+8R8lNqKUJvtG0zLSOAsxaHMr?=
 =?us-ascii?Q?b9yrrq6W+4U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZI0nrA3PfKIi8dY44o9siRpn2Sozbx0dXoljO7gdO9TNfQbHTmvIqvILqgZ9?=
 =?us-ascii?Q?3OqjsT7SA7FKyCYSkfkdw5ZFwREduwKRXnaAFeFbPms6BHIzp8ldnfQyV9kj?=
 =?us-ascii?Q?kAVtO3I8McfbNWiqo7wc4FhreJpvxT+vNLGWtveSO7FHmW3BoSO0bKO0Qj14?=
 =?us-ascii?Q?GJsVdrQvcf/c3Z/rxWbXArrAfsHOMPHHO1ArYeGv8k3N44/wW1nrfR3zMD4W?=
 =?us-ascii?Q?t6Wi7rAFu3PBDuGODTbzpb2i/8+wlJdj/txkqYonEnyaWsbCshEjV8rEhowN?=
 =?us-ascii?Q?7A/Nn5YvtyIVugnr/0dIPClPUtzr6cC3cuXH2kBokBvCrLzeejPNOWG9DGpD?=
 =?us-ascii?Q?UE8rYeKrRxHlUkwrkMIWPcR1JcXcluzf68LK4G1G9nUZaE+34O7UV81qY1OK?=
 =?us-ascii?Q?us5TgWx734tljdf/apSzBzDXWuQgqrp4kki+83dw5v8bxxDLcqvuAEFIOf/0?=
 =?us-ascii?Q?aVUPfMj1Q6mh+KGjSYwjj2SMIQS1LP+8K9qWwrt1hCkLkmyKqnD+2IUr+2bs?=
 =?us-ascii?Q?rwOeJI0PzqB7FRDM/IPZkMflVP5gGVauGp0lWjgmQEb+VlcSoj4wmsnk6EDG?=
 =?us-ascii?Q?+ayCT87I9l8LVn9Ezn9OTPICLpZYHkdPoKwUQXQ/1jHSAT3Y1et7z1X75dUJ?=
 =?us-ascii?Q?qfk8fZxO2WPoIYg1uadO0zr7WNnrR/qXXyYijHAJlS1sxdsxjIQHd1VPPBrw?=
 =?us-ascii?Q?aLXPJ96jxYqi+nhqZnfSU0dSkyAPFB7uC3Mx7GLMOIaPU1UAuyrtQ2Lfysvl?=
 =?us-ascii?Q?aiDK7H0hM0xU9grGBePMy/vL4RIyAGDl0LORlGT5Jnoc39MVQXBIdBYMKLYm?=
 =?us-ascii?Q?4Mng11vmGZhrXNijJRlo9aDjHR6fz84Dw7qyVg/waDKis+2OXAzsrO0ZnxpT?=
 =?us-ascii?Q?dGnt27a1tIqnUvCkbBknq2LOfoFx5dltWjwihChzwcGe3HdcfFO9Wz1qrpO+?=
 =?us-ascii?Q?8EjRh8sZkqJ+9SkcLhKmxV/RYp6UbOKwwZIPRsgpy6dBIcLfs1ZUSAwtJfVZ?=
 =?us-ascii?Q?IL0iOeEEMFl8eu/Xxlao9H8NXcyiZkLtiFTNyza6x3ihi+RLPJpoiz8XJD7I?=
 =?us-ascii?Q?sC8nF32uFL14BAvadu+nNmP2a0asOsQYMnZB1imqiwZQV6nqjoSlTj/9pVN7?=
 =?us-ascii?Q?9cJJI6+MDlXO+JxbWz//W4ySnuFLrIX3EZq0NiVx8e5GXIzO4D2vGO/lP1ky?=
 =?us-ascii?Q?QUZII+kpfFZFPIcF7aKOQZa1Z13UYMkpfmZSzAwPS5wcc+Bgm0xETC+JROvL?=
 =?us-ascii?Q?qdQHKTH11N30wXJXShVtIKmT+QT3uFImVt5TFkKTxjAEwyo+D+I2JH+onv6K?=
 =?us-ascii?Q?Ohv4xp1wIwwCmTqL1OPx05ffSyrQfu7x36t0Vx4uyU73oIMgbvvRbWEWlY17?=
 =?us-ascii?Q?Vl5ZmP7t6um/MaDj4k22ojFbHK1AO83GZMcfONYro4Dg70U4EBaAkBx3PcC4?=
 =?us-ascii?Q?S1iVNibWzjDQOOn+bVZtpeQfAajCBjCMw75iyLLlubQgrQ0c55q4h9dQbpMO?=
 =?us-ascii?Q?KkFbTZO0XGNSqTymbE0Nq2oUGJmUGAQuiKgegeTfNTHofHTwC8xDnyuEm5dw?=
 =?us-ascii?Q?ZdAaiZ54puEGoyqJlmuk1aY15MXx5HAZxufZ+23wFFOQBcWrsWxcgBJTmYHz?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 610794b7-3bd5-418d-b22f-08dd79223941
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:56:45.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grJxZchAtmUpUQwvdREHHRJxWxxkfoT9rfvlf6hcLy/cXGH/Pwe8zdjM7loyQDU97ERrAN4AtSBrtKz/5BiRVO3APldoozT84ujY6n1f7/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8766
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Fri, Apr 11, 2025 at 04:52:18PM +0800, Li Zhijian wrote:
> > The destruction operation lacks atomicity, which may result in partial
> > completion of the destruction process when attempting to destroy an out
> > of order region.
> > 
> > Previously, a out of order destroy will return:
> > $ sudo cxl destroy-region region1 -f
> > cxl region: destroy_region: decoder4.0: set_dpa_size failed: Device or resource busy
> > cxl region: decoder_region_action: region1: failed: Device or resource busy
> > cxl region: region_action: one or more failures, last failure: Device or resource busy
> > cxl region: cmd_destroy_region: destroyed 0 region
> > 
> > Then, the components under this root decoder enter a stale state, the user
> > cannot create region any more under this root decoder.

Right, but the user in this case passed --force, they had better be
prepared for all of the bad consequences.

> What's the complete setup here? I'm thinking of the test case we can add to
> cxl unit tests for this.
> 
> I notice the -f, force. What happens without force?

That's documented in the destroy-region man page. If the region is
enabled the --force disables it.

Recall that the safe way to shutdown a CXL region is:

daxctl offline-memory $daxdev #only if this succeeds proceed to next step
cxl disable-region $region
cxl destroy-region $region

In comparison "cxl destroy-region -f" ignores "daxctl offline-memory"
failures! What that means in practice is that pinned pages prevent the
memory space from being reclaimed. It is highly unadvisable to use
--force in production, but it is a quick shorthand for testing.

> > The kernel has already ensured that region/decoder committed in order,
> > so just ensure to destroy the last region is enough.
> > 
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> >  cxl/lib/libcxl.c   |  7 +++++++
> >  cxl/lib/libcxl.sym |  1 +
> >  cxl/libcxl.h       |  1 +
> >  cxl/region.c       | 11 ++++++++++-
> >  4 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> > index 63aa4ef3acdc..c13bb9377237 100644
> > --- a/cxl/lib/libcxl.c
> > +++ b/cxl/lib/libcxl.c
> > @@ -706,6 +706,13 @@ CXL_EXPORT struct cxl_region *cxl_region_get_first(struct cxl_decoder *decoder)
> >  	return list_top(&decoder->regions, struct cxl_region, list);
> >  }
> >  
> > +CXL_EXPORT struct cxl_region *cxl_region_get_last(struct cxl_decoder *decoder)
> > +{
> > +	cxl_regions_init(decoder);
> > +
> > +	return list_tail(&decoder->regions, struct cxl_region, list);
> > +}
> > +
> >  CXL_EXPORT struct cxl_region *cxl_region_get_next(struct cxl_region *region)
> >  {
> >  	struct cxl_decoder *decoder = region->decoder;
> > diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> > index 0c155a40ad47..3ce408b9cc55 100644
> > --- a/cxl/lib/libcxl.sym
> > +++ b/cxl/lib/libcxl.sym
> > @@ -180,6 +180,7 @@ global:
> >  	cxl_decoder_set_dpa_size;
> >  	cxl_decoder_set_mode;
> >  	cxl_region_get_first;
> > +	cxl_region_get_last;
> >  	cxl_region_get_next;
> >  	cxl_region_decode_is_committed;
> >  	cxl_region_is_enabled;
> > diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> > index 0a5fd0e13cc2..9b5657203eec 100644
> > --- a/cxl/libcxl.h
> > +++ b/cxl/libcxl.h
> > @@ -305,6 +305,7 @@ int cxl_memdev_is_enabled(struct cxl_memdev *memdev);
> >  
> >  struct cxl_region;
> >  struct cxl_region *cxl_region_get_first(struct cxl_decoder *decoder);
> > +struct cxl_region *cxl_region_get_last(struct cxl_decoder *decoder);
> >  struct cxl_region *cxl_region_get_next(struct cxl_region *region);
> >  int cxl_region_decode_is_committed(struct cxl_region *region);
> >  int cxl_region_is_enabled(struct cxl_region *region);
> > diff --git a/cxl/region.c b/cxl/region.c
> > index 96aa5931d228..2eb6f5416433 100644
> > --- a/cxl/region.c
> > +++ b/cxl/region.c
> > @@ -835,7 +835,16 @@ static int destroy_region(struct cxl_region *region)
> >  {
> >  	const char *devname = cxl_region_get_devname(region);
> >  	unsigned int ways, i;
> > -	int rc;
> > +	int rc = 0, , did = cxl_region_get_id(region);
> > +	struct cxl_decoder *decoder = cxl_region_get_decoder(region);
> > +	struct cxl_region *last_region = cxl_region_get_last(decoder);
> > +	int last_id = cxl_region_get_id(last_region);
> > +
> > +	if (last_id > did) {
> > +		log_err(&rl, "Unable to destroy region out of order, "
> > +			"please destroy region%d first.\n", last_id);
> 
> not so sure we want to make that suggestion and again, not sure
> user will understand that 'out of order' means in this message.
> Is that explained in cxl destroy-region man page?

Agree, this case needs some more documentation and the error message can
be more precise, something like: "regions must be destroyed in reverse
physical address order, otherwise the kernel pins port decoders active"

> > +		return -EINVAL;

My problem with this is that it causes --force to fail, which is
supposed to be the "I know what I am doing am prepared for the
consequences" option. So at a minimum the old behavior needs to be
maintained with --force, but you can add a new check for
"destroy-region" without --force to fail with a new message.

The kernel *is* tolerant of out-of-order region destruction, it waits
for all regions to be destroyed before resetting mid-level port
decoders.
