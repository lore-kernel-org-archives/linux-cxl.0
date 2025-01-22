Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333D215F5E
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567786; cv=fail; b=o/L+Y7jNN+Pa12YB27mG9Uu9qp7EVrSzCsNTIWtBpOBbi8Pw+EJ+Lyd5LNxXOC5JB2h5PJfMFa+8gRo0z5ZqEnlPfOUCjmtV9e0rnsvOGx96tcrKNeIZoCq6mY89VulYcXFN/hI6FVd9JdrVZDLmDRY3ZXFS1SV2u1sDwB/IRUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567786; c=relaxed/simple;
	bh=F7EqiT2wSfvEJKRVnXIOOlP0zi/iuE/aX3Ga4NlkxJU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ndTvGriySPpyMO8zgKt7uYH/bqILU1LYiHBQcYxZYXrCRhT/0PlkK1QqlODkrXIXGIGSXBc0TXglwcQo8q72RU5vH2USQFFsFOVrVNJDQhTQbeq8k1LEAIyXYVbF8+YW9rIgiuriOI1FapOMF7f7AZ9Q50DyPOz1IyQdyR+CqBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DR+V/cUz; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DR+V/cUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737567785; x=1769103785;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F7EqiT2wSfvEJKRVnXIOOlP0zi/iuE/aX3Ga4NlkxJU=;
  b=DR+V/cUzHkEtMqnq2szKJ1DTERQcqmcSiIRvWxvYZFnD7BruDZun+3M1
   mg5oTOJhySrphXZfBmqkfNLwtB4jS1OVzVD2rhGvvVGObJB/QLn7qjWha
   gjSeD66SZhFzXz4TPkb1YOATw/HzcqZHivFf7RwYPRe5s3Hy07BuHqkwV
   BFCaLon0GlbIApnMUz+1AunLOfH2ze5STr9EQyuMmdWN/drQVhS5odr21
   O6PxOpuoiBh/pyHj5kuAaaWy67dV/ZO0N64lKjAJ2UnQeegtIkJcpYKCm
   DMTjYRvS6+UquHz753vctbiCj0ivLl0wWbpSaZNWMnw4tiMAqvK+bXyW5
   g==;
X-CSE-ConnectionGUID: p5OqrKGXT7+A0SYBgeJqnQ==
X-CSE-MsgGUID: QJdNF9vgSt+ZZWAcISOnfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55586209"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="55586209"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 09:42:57 -0800
X-CSE-ConnectionGUID: GHimVBVyTzO6XS8Pe8IRCw==
X-CSE-MsgGUID: j3QCS3p9Q4WjWJdXzBwmqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108083137"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 09:42:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 09:42:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 09:42:54 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 09:42:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cb8Iygjvxmr4TTrNcCl7TjxEphoaQ7f56TTXeOBEqGXo1d55m7GFxJRvWuaxXpVwKgSsz7MbkOwjF5tRx3802lQLroCCOvT81Wp3F4QJx3Soc1C/OvJ4mRN8bHCPfU2DGJJOlAo/oapfMmDOJchSSbfEs3PynYZtyLN2Dn5m0qWde1TnNjabna651pPf2HTBzzeyxxcrQwrQuWDz4n5l2V2roMu5Ai/2hg7B46DUzT3MIzeru0GNcqLXXQ47q+X+fGH0mdz7lFS5FiUNcQZ/xZYM5Ih2R/jJTQ8Etkzlvrdq0rG/WCUIlCqB9DZw+3DragLsG4068f1oIovB30bLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhPRDEWtaxnpuhiUZ0FH3fZpPQxLJkqwn2/loBFe/z0=;
 b=fU2Gsq0a+IAc6rhxLjXLPm7v2qsOgL58/evjIrLIKt+6/EAFl3XkHw+vLkgiFBzTJq4gOMkJMH4/XTEJ7BsuPwUMTSCkl1ed2Y/+DNAkuANB+0EOMayKsDPlDpZmg/azzl2Nz4047l1k21C0pSBaNmhyBIPh0/oZ8yS2uBDppfkzWlydcBXc9+73lipe2je93k9x0MnIrLUhmDqM95/oyQtUgcvu9ZcTtrG9YdNYS8AnbQvr3fvnJ1hqzn34zkVjiDPcMrDeKEHDKr/i2BSTYzPiGKr7eE0dCKj0Ps9VNTxSZbzIZQR6s3hYoDlzMyMPeB3pSR5tTgsQU3c1O6F2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6869.namprd11.prod.outlook.com (2603:10b6:806:29c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 17:42:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 17:42:36 +0000
Date: Wed, 22 Jan 2025 11:42:31 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 5/5] cxl: Kill enum cxl_decoder_mode
Message-ID: <67912e07cc2f3_1eafc2948c@iweiny-mobl.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0319.namprd04.prod.outlook.com
 (2603:10b6:303:82::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea703d2-a42a-4b7b-81ef-08dd3b0c2843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vDxIxWZ90CddhbA0FbxSVjwQOtG0iZ20uSyRUKZaNj9Kftg93WdBerRbdOja?=
 =?us-ascii?Q?aMmGoe+wVZDd7mdcle68Ok0YW/iht1JNrjNIFrTMaQ1r/WJ67zcAitubpW6P?=
 =?us-ascii?Q?oInbaalgMQldE2YiWPH7cPIIyIbd5PXXdFg9ha+Ddb9GSj2KMNuEU1ycNd6C?=
 =?us-ascii?Q?OT1ZAy5Gk/xlu3DgszjjM8vJBLJb3seayZKJknvmfc8fHgcfdkU4gX6y7aUM?=
 =?us-ascii?Q?VIRmtWco53jPHmX4CD1toNGJAuR/6OX8Euw1tB8J6dEYL2iFtjdOeYTVgzjX?=
 =?us-ascii?Q?OhqEavH1G6p+2Z2kn07fqAshc4YEq8EK74PYyo++uOLpsrqmTnm6Bnvyf/cE?=
 =?us-ascii?Q?JiENXRhANfVcbh88XAm28oyRuD+AgknHGmDJdlvsm8rfxDThqz+KA/TOcH2m?=
 =?us-ascii?Q?Gf9/UogoOe8D4fbCLrvwxkVVFPxYEl/14xuvGq6VsDwg2lNXVdLVCz7fIz4t?=
 =?us-ascii?Q?MXIKFW9chA/WLHg+ED3x+3kokM0QMoYfV22SRg3UrrbIrF0vA+5xlJIbMH9d?=
 =?us-ascii?Q?jNpxBbMPGOW1AcONusWSIMRZg9tJW8umX5OmQd0oGxXC7UyaTlZ6UHMNlO4m?=
 =?us-ascii?Q?Oxu+pmnyFHsK0MG8fzhn+9tG6MP4ivfRZDZHMBf40iyuegKFl7PaGBXyxIGi?=
 =?us-ascii?Q?VXf+QOFlbB7T0FaAjj97JJ0AYzrn5ekOkrh4FtW/ynsn663I2S0feuNR4vSh?=
 =?us-ascii?Q?FhSw8oRfZk7LZcHEk2LzY1t1wpnZAphUuAhhe/ckzLwqY+vNMDabBst2F449?=
 =?us-ascii?Q?CQIPzS4AXV0wNTtikOqzo/AHb2hVHojwzww9Eozy8mogC+LEaWp+gbLFd26x?=
 =?us-ascii?Q?J4ySKzZSGGHTz6zrFFtyZ238Faiy8JtETyJIY3Id4m9n6mfQ0P1JhoXkmcxO?=
 =?us-ascii?Q?jSKRuqrKZUC/8pFFxFlwhuAIm0iR9g9HtBh+/kSPFOl8Xnvp7Nu6Z582Rh2M?=
 =?us-ascii?Q?vHZuAf6P9vmiaHmYNaj8/W38AB2rBCbQG3E1Yi4W1huPF+a9twIL2tyZgnbo?=
 =?us-ascii?Q?Iy/EDTTWR1c/lBj781NSqdKu+h06gcH19KlmC7EzkZhH5VlV0P1d6Fwiqwxy?=
 =?us-ascii?Q?G4751Jmdds2ZnRARJq2WhkxZIXRC/97pRcFJEQ1yK5MLL7n/F83hSkknlN7h?=
 =?us-ascii?Q?rV9MF+AnEBYbG5QgbM+hEbdRSXK2/VbQ5ko2C/rGN2Z8xs1tu8BBu6wsIEWn?=
 =?us-ascii?Q?gU7XPzhctxShnQH/mggoISxMjye+v5TpGARMQd7VARJpgl0Pwa3BB3Ve/cRC?=
 =?us-ascii?Q?NTR9SVoqoLpB70pad9E4le4YmVd4Q0oJhnzDI8s+Y8AOA63pQXgDZZW33NuR?=
 =?us-ascii?Q?5kvbXdjzmXt+SvcMM0RGjOIfoTKfLYCNfQz+nXKoZ0J0rXlhkT7HATcQ5eEv?=
 =?us-ascii?Q?jmhtxcH9tkEXUkuSaycKMzqKP85j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A4SG3fze6+ntjW+XosieVAj866Ph2pokbozscclEEPGFYpwthg7+fOgL2ayz?=
 =?us-ascii?Q?bW5dIHM6zyC2v3Qmnhv7zz3uZy2SV2qO7mQv+bJ4BkV6tSNGylnsc/ioyWjR?=
 =?us-ascii?Q?9+4+zGymeqFVEi3Le4OwgscAnQ7XD4KTmejVDTv/EUGq+1eEWRbelRWEjxAW?=
 =?us-ascii?Q?Kpz5EpSvA34cJWyJYHLqpbueK3au7l7NDHJxlqmEKmxvSZiiTqAOYXQrmhzK?=
 =?us-ascii?Q?VC2EGGkBf3GMakjgxJIt5WeZqQcH6RTPxna+/D6HqqEG/c3MFiv8kxdyE1Um?=
 =?us-ascii?Q?K21QsYpLPVdH05RlCt0/IYLrXagtCwLPikigv2+A6Qm0bDlek8rypmszTBx2?=
 =?us-ascii?Q?W1kpzMqWXRk04qdlSvrmdItbrgmyPVwPQAdAOICCChsdwV99F5q+9phoClnm?=
 =?us-ascii?Q?9RFJzi5Dj1qYws3tLz3kfjGAkFLtvRbZ13Ni0jYQakxK695BoWow9M1jmSWt?=
 =?us-ascii?Q?qjCFzZhi7UK0Vez1gp2qt2uPfntL97/Aq6uSbMSvScZab+AEhMfMePul/4UU?=
 =?us-ascii?Q?Gdh08n2dzc4V5Itue6uVH3Tjfm+OdnpOmV19D+7h9KEkSnB/0miubc5DayE5?=
 =?us-ascii?Q?eTVtjCJwgX2CbaJB1wZe/Wpiv5fdicERBKtWLyPUs/DWfZX4vx5DTUIACCzw?=
 =?us-ascii?Q?jjZbnDbzILvJOAxRfflJQl9rrwGlaKw2+6HDns4tkt73vzE4AYqaSUSA/vmH?=
 =?us-ascii?Q?kzVHtDssIUjEGpy9zzLcJbM2xTgMxnlYDU36U2h+nfdkenuaCnnaYCBF7ApF?=
 =?us-ascii?Q?RsDh7fO8A32sUZ4Sf+zQguc7o2vBHxKrR5pB59yLNr6uCbRgIoPfXU/IU1zz?=
 =?us-ascii?Q?JkNXHnK0RJUeX7LmeH/JvEfH2mZerX6yzTGlYmhr4/C5xseHtcFTtyeykUHg?=
 =?us-ascii?Q?xsmXQB8fYGfmCXDHJOsGhli3ymcYE98rLJQuzekZUp6hMhwyViO1uu8g0x5x?=
 =?us-ascii?Q?JL/79TAQBkpxTdLB14mTBxskiYv+00skc/mtLj4dsxcTe7fHkmtl/uxRxuZ0?=
 =?us-ascii?Q?82E/rQPElVoSExs/jQavIBY3QyLdcR2PDPV47PyyRay4DliB7QQeVG5KDhzj?=
 =?us-ascii?Q?hEKMH8PeBltXFn6u2Un5XOW/V5J/eEqE4IbHSB93z8v1bnfEEVNFU6jcrSxu?=
 =?us-ascii?Q?24k+lru9eOOMRaR2WQbzzO0jx8OjzWy3PtYvyWt/KgAFGxuPapETjd49VeZj?=
 =?us-ascii?Q?Cqn/Yq4mve4qjW7+tcXMBfsXGwL3xhTGtjegEN8VpBhcS3nt85BX08k5Niap?=
 =?us-ascii?Q?BvOAzTb5Sh0fQpiPKvxiMzUWivDgN8+ZBC+49JM72hPzb+/vCiS0IEkySVNM?=
 =?us-ascii?Q?POyt/dsx1KHUI5uKS0QWuvzvlz4cyVoeZ7HCQNFGvj3L3txDcPE4RRwYiYzm?=
 =?us-ascii?Q?adXpV+GxO+zMudMR9duQZEvDj6s5t9XajlB1wK/7ha8arTM/7mOxQvlf0+FG?=
 =?us-ascii?Q?d2j7NSe1Ysbo3RYwag1hvNrTsqE5IZsAi1C94I1DdcnvpmeChovGBXVPg6X5?=
 =?us-ascii?Q?efn5KglW4EHGnKNiqwR087Daicezb1h+apS/cLbHusZQkZmjBYwzbGFrf9mi?=
 =?us-ascii?Q?nCMK+l+lIyQH+9VwQmGl2f36cc8b+0zFWvu/Ft7R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea703d2-a42a-4b7b-81ef-08dd3b0c2843
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 17:42:36.2171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxE8FZsT9EtW0fp/QrylZ2hydP1Ves1TG6BJoxTCb3XJhET6XkhQUs35zw9Xk2YZmYHceE78CUGA7n9+3owCoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6869
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> tracked in the partition, and no code paths have dependencies on the
> mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> can be cleaned up, specifically this ambiguity on whether the operation
> mode implied anything about the partition order.
> 
> Endpoint decoders simply reference their assigned partition where the
> operational mode can be retrieved as partition mode.

You really seem to be defining a region mode not a partition mode.

I did a lot of work to resolve this for DCD interleave in the future.
This included the introduction of the DC region mode.  I __think__ that
what you have here will work fine.

However, from a user ABI standpoint I'm going to have to play games with
having the DCD partitions in a well defined sub-array such that the user
can specify which DCD partition they want to use.  So the user concept of
decoder mode does not really go away.

In the interest of urgency I'm going to give my tag on this.  But I would
have preferred this called region mode.  But I can see why partition mode
makes sense too.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
