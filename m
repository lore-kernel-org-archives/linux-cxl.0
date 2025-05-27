Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19451922F4
	for <linux-cxl@vger.kernel.org>; Tue, 27 May 2025 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374298; cv=fail; b=tJQnv0M7aAq78kTmDOKtIGvufISwGmV3M9/MCbYyAfLEbzl7rvoWERVEUiMd2bNnkOJzlGzfXP6tIbAv494a+s4gXuauAhnrg7DT2WUG38V/1UFcti/dAWYp1RrVuWF4ZX7AY6F65x7/Vmh4TmBVDfo7gThA28D/Iesclb0CLQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374298; c=relaxed/simple;
	bh=KB/BonpMjPzAZn9MLCH/sbGoshHkB/NReQ7mWLuSBWs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tJmQzSXs1x3Ueh0sNK6ulxLxF6m0zfN9xRiryebxOBBMDCcfqxb0fZavW/T6p2W+cLLk/qV0BsfyqHJ1/gEyxKWZLyj3qL+wgsIaR8/QbhFGYzQI+Z/VIyE3xwhglfqQcIUyXm0Hq0Qz5XM4OWTt63Ugte4qhoke2ggOcppMbz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbWVSycY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbWVSycY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748374297; x=1779910297;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KB/BonpMjPzAZn9MLCH/sbGoshHkB/NReQ7mWLuSBWs=;
  b=LbWVSycYl0FPtAPBqz3xK6kZEb0uOYObibCHjlwHQ7uTtbs5SJK3Qv/l
   1cKgrPKKKhO4l7swXWGSktRAWTjzBhbx7hE0vwM+cIxpkGH76LxLG6g1G
   Od36WLCNurOsbRmVy9rX6kXpliBfJFqVxTpOMdTDqR/+Z/A/jueQMv980
   PkGXJYHIYN27bCdg93ktP4dn6SU7k42GMrgUjHCWHOa1bs3d9CVTphyxg
   sEIOQDgHyYjeOuGpBivUkhco9aCzk3frev3krpRK4NN+BLx+UA7nJIo4U
   xa1fZTZatWmCCDgrOKEXRXrlCG24WsPc8RmpDNKIE9dZc9EFZGHZjg6Rq
   Q==;
X-CSE-ConnectionGUID: YFhepUa9SFa+pvq6JK77UQ==
X-CSE-MsgGUID: kC5Ix+cSSXmE5bM4PcWCag==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="49492711"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="49492711"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 12:31:36 -0700
X-CSE-ConnectionGUID: LlbsFMjaT42dn6EJuXUyaA==
X-CSE-MsgGUID: uuuIlJlbTeaouc897LxUAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="147710664"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 12:31:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 12:31:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 12:31:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.55)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 12:31:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcDIw//vQhjFfqS6wewPES2CY6WI+IcwHcogmSeidAU1UqvZYj+Rt7bAf/iGm/WGYVlTFYkVj9VCctL3nHA4cvcGpYcI5MtQZQohM2w1cINWzNNEBFCYnKCgHgK1tDGiQ+LYnfm/R29oXtnjSksAjbF389GP54Os/9TVUw0WigBrkCGBexmduJEBSzZnvxfqhhT5jz6y9cYnVbw1ZW0suSe6yrTKW+9JjpAH3jdxV2I1WApb7IO8BMbXobi0nfqcEcTUmKRtOzqWywPKDXnJBUcxM6NryXsf94YvL9TBN1GGnry1NzYQ61QX7BkLde9l7W/yycyp0qWKbatESk0fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KaVSVU4h4QHOQuHDooVK6NmIoThbslQNd0NG1x67gs=;
 b=fcyjGUchPSqbGym+CBcJ2eWrYyvaFFzr80gprg1Jw+WNqY+bLqkYjyp3A1vl3cZimPqYK7n3wDeRUUQ3nAX9JqGjQ7rkIVrMYaC0+nqyDySZ0BC+2RwKvajzUi5yVijvx73Pzv9gELS8dK5uuDYlRtrqrwdo2SUMSUk4mt+7TcMJpBl9dhKYZHWtd8K7HgyP7n0BlvNeQPSSgySdVuMKy4Nrk1/GYVI1E8AsF2/AR/7pFPdr8jIDdI1C3IDRMt+L4ZY6PDbJ23yKAiOAYixN8LytUcfcZo0h95HbDMtG7QtPU0ifng/JEoMT/53Z8XeEnQnJW87rJ+KMAK20Zsrogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by PH3PPF9D9CDC305.namprd11.prod.outlook.com (2603:10b6:518:1::d3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 19:31:29 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 19:31:29 +0000
Date: Tue, 27 May 2025 12:31:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, Itaru Kitayama <itaru.kitayama@linux.dev>,
	Dan Williams <dan.j.williams@intel.com>, Marc Herbert
	<marc.herbert@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<linuxarm@huawei.com>
Subject: Re: [PATCH] cxl_test: Limit location for fake CFMWS to mappable range
Message-ID: <aDYTDgPuu8L6jH2W@aschofie-mobl2.lan>
References: <20250527153451.82858-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527153451.82858-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::22) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|PH3PPF9D9CDC305:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d8990f-eead-448a-15ac-08dd9d551443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VtUJeTVSQm13r4qCcRCQFLSosWG0lrGwMm5zKwKENGf/9NByxx+83LGOrPbm?=
 =?us-ascii?Q?cIvYNXRRsdyCplTwDOdyWfi81t8t9Iijcv3NkQPbxKRkqboiWeYMqPRYVu39?=
 =?us-ascii?Q?g1PkzEJn/U3wCOAp4tBvOmJ0vAm5lWxZIQ3D05K/0dRgYqPHM2VyfU/wpQwv?=
 =?us-ascii?Q?Nl0+SF/gZBLk/InXpBMGtZgLuc5310EtV0seNJmfRZc588AVdwh3/pG9x9qH?=
 =?us-ascii?Q?3CYIWNSZdoHgN0YjyiK8XWYRosEdlWP8I43K3JddTWIqbIYnR8O3Y6zDik6w?=
 =?us-ascii?Q?StgqKSeGPRrlqtcfEdCbzQEyMDfzBVuwU/5pjMyXDllCtZNaU7y9Wq0DYFxy?=
 =?us-ascii?Q?Hh8dB2LnlKzxCPPDwtDzs8o+dJon4XShI2esr3dkUmb8sn94oTdbJIk4jhGJ?=
 =?us-ascii?Q?pOA/DDauiZ224Mt9tjyJBQxAj55FI/I3G3UYKPVfdi5Z3rM1jNSQBS+yNoGm?=
 =?us-ascii?Q?boEfEL3x2pCdzPP0+ULK8GqUdU86As3ceEpFop2s2Ym74gYij+s5tKIfn00M?=
 =?us-ascii?Q?vxHXeif+wUSb7EfgHBUDsqrKiX9/YnnzqItFM7qjRolOg0dKdtra7sWQwK8d?=
 =?us-ascii?Q?gY7dwMiuqFVhV6sj/2N6+XJot9JuGC2WqeKTyTL591IIggtc8JcLk4Rvz34q?=
 =?us-ascii?Q?0WjwAyqsU4zxO4I9kDltLoeDgMd4LtYNwHu4brrUek2O/z3S9dtJEEelZcAp?=
 =?us-ascii?Q?PkLCR5ck9s/mmwaUDGpV2qZcCPwhPGClKOt81v2+3PbYAzr1OVko0ac/qyIf?=
 =?us-ascii?Q?9VnQKqqBlb6weuiBrv0A/urjPD8nl+0BRV5TD6nTBeDq3YWHFmJU5kfaSbrK?=
 =?us-ascii?Q?58BCmvpdfEcAasStimNwoJps/zpekWr5qT048XZNTxxXwqugZTc+z3mzhXRX?=
 =?us-ascii?Q?BqfbJ6txG3HaTEbY4IkNAeI+ivlkpI3cRYfF/x63rP1MIgWwTYkD0OJEx9Lb?=
 =?us-ascii?Q?sMVS1TYIAsXewgmNuFpAuTUvcMYqNcKeOI7Ko428WqCg3L3mX75DQkpcVf4o?=
 =?us-ascii?Q?cSmhg7qpmBZmL1QEzDgZRdByQCWdAubWkm6btshAQGesriasBZrs5zrvgx55?=
 =?us-ascii?Q?Py1I7jsKBPB6Zi/go4SnESmLroPDcry97dnedeUI2MnooT9bd3N/4s1v83Nv?=
 =?us-ascii?Q?n8rkmqbT/8yk8sv23kq3QhTyyA+NpN+l9pG0MEcdajiXFTqgEFrGB84Pih74?=
 =?us-ascii?Q?FBMXIXbc5uLpVAXxZRWu0d15o39h82wrLQbpZyjLIiOKogyI5W0VNoNRzyzl?=
 =?us-ascii?Q?OWNQthL/MyEOBLTkJrdL7hAojyKK0Q8JaDv3YL0GRRT6jpfFY5I/5XrElaHu?=
 =?us-ascii?Q?1lQ+/YRnQuTBipRC6DYkepDXPPcksV46mjk6VvCCowB4oc6AXN+areKEyiBl?=
 =?us-ascii?Q?Zacl1lMGDVHCvvyMvMvpu4NG3YZ8Az2pVoyBVIjy51Mobu0sb+FAMHDmesFE?=
 =?us-ascii?Q?XpUnZn8jrrjLhs3zr9Vz3R3Wayd6h9Lm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QRI0BGIJWM7sHmcxQOHTQtbKn10SqV8hNmjW6Ghy0ZMgAzZlxb++tx/GTjtW?=
 =?us-ascii?Q?x+YCKOtcteFLDENV7EytLQjKgmnhz1Ec2f2OmhDmtlzeKJPeMYeIuG3jWI9g?=
 =?us-ascii?Q?t2Co4psG6EmIGtqH1FL6ppLaONXiidH5GzB1rOJ9yjAvksyHIcZeZp5ULTUN?=
 =?us-ascii?Q?MwRMu42sPnQOwjVjyP3EBoIqZ7f79Qtp7jgIhE4Zl9z3u0ocD5ksSIEy+oS5?=
 =?us-ascii?Q?1sOejpXPrB2dbC+XxOLjS/WscgBm3tqZ1vHitPF4jaFV0kVAST7I/BYHu2Ai?=
 =?us-ascii?Q?4J2gBjpnFQn8bsLX2eORhYPD2xvQ2DrpqxkwmouaPJ9uGZDkQoNxVK4qYGhv?=
 =?us-ascii?Q?u1XnnkGZ7oWxWm4Wz6AeF6y2Pj98gCrYdMwPNuUmb3MyHPZf4DNZINvFq/ql?=
 =?us-ascii?Q?DGAAwh93/LisKd5XZtm/bAFVuSmnkR9sLHLX2hR0VRt4aE0+IhSYhuWtogcd?=
 =?us-ascii?Q?s3f2n3a8wEov+lDWosXRIPGuR37IB+NXAuVHRw7RP88qg50mFd9l/jiQegI9?=
 =?us-ascii?Q?F3c32JLE28cO9JSAMHMBNYLMvPDULnxEveMe3tzU+Fr5AqstcKo1JHq4MKeD?=
 =?us-ascii?Q?crXFDplruyS1PzmyY/Je7Fh0ZYBIDy+U743YWlsfDMemJ8o3hiXcZQHttuGI?=
 =?us-ascii?Q?B+saGICiM5257nkB42zAmJyICpvxVGspu/jsqV0Bi1Tbr/WTiS5r/NOdcJ0d?=
 =?us-ascii?Q?Q4fQQaY2zY1mEQkrQ4w8qFRYgWNYIujFCO/HZi3rKNoLQdrnWxgUP2PCPfRy?=
 =?us-ascii?Q?FpPfrcHH86lS4vQGM/O9kRj0HvXqHt6pPAKZNTdGzlNQ7d1p6vJYSgg/yC2t?=
 =?us-ascii?Q?iwQMpojFtrAlfe5Jrzx4sAjdm5mWg50KhaRF5xszW2uQS+BBAWZyvg+MXFKK?=
 =?us-ascii?Q?ScCnRymv0vFyuLa3PhJIY/wCCJEtDo6JgQEnXWH5lpY01jAaNGuwvvTBqFvH?=
 =?us-ascii?Q?lY97xIB4mPwq9uxkM4kWPgaJPuYlfXuVTfpwBHuJI5949Y+2vO/OyDbjnbdd?=
 =?us-ascii?Q?kf/eG/ZdRByjXKYvE3nfoZ5LHy+pL6cGiDVtup52nWq2kvYtFvYpV/ipGQI5?=
 =?us-ascii?Q?sP+CmwaCbZTBO9q0shxg0BG/BaBrHOrNmTnaR3X8Qm/9r/kkv778aOjlXVCi?=
 =?us-ascii?Q?0wKyUms2jwjp9fpCxRNTc8/Iq2+NKrpO+gLG7E/9BvtUMTtuCiOLYq9YTAzk?=
 =?us-ascii?Q?qpdd5UR4la36ZAfyivdAj/BjVjGF+iCGcyMlyfRgIPZUbccN6VwJkYC1XmS/?=
 =?us-ascii?Q?L8tQK/d7OqzVk4ZpAupuzNxrzxs31bBLKTE+6CXSezLCVkJQEkcNU3OHpl6V?=
 =?us-ascii?Q?vDrYVyjOPfJbqUTcQflVy3GSTk4gVR2LbSWCD8h0DV4IuD7GxWZY1a4EQUDX?=
 =?us-ascii?Q?Kg/TmxxHE5pq+UfLtjfsB/MpUO9v9UcS2lWNeh5BLpkpn9rDfCN1er7xTvDQ?=
 =?us-ascii?Q?Z2lQ5eXlHgTVOk10ADxj7BJYoOjK3GZpsLUlhPUOUTtEItkW4VouCR65bCUG?=
 =?us-ascii?Q?FzGVGfg5HmIxN8LCkgKGqXXKpGJn9MBtqGYeasRA5Z1mzQUbDBuciAj0gkLL?=
 =?us-ascii?Q?LZvba4Gx+zhYL3IuOX8q3LMAALbL/WSSq829OmAw2N5frEEcReS0eh6wAk83?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d8990f-eead-448a-15ac-08dd9d551443
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 19:31:29.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gFV4RnmaoFprDatBy9EzsZe3o3EGLa2iXRec4miWgtRP9q/Oh6ND2jgPRtmtTAEl50l5xgxvDyOk+o0ewY/3WGHRvrsi4y5FaUDuC94E4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9D9CDC305
X-OriginatorOrg: intel.com

On Tue, May 27, 2025 at 04:34:51PM +0100, Jonathan Cameron wrote:
> Some architectures (e.g. arm64) only support memory hotplug operations on
> a restricted set of physical addresses. This applies even when we are
> faking some CXL fixed memory windows for the purposes of cxl_test.
> That range can be queried with mhp_get_pluggable_range(true). Use the
> minimum of that the top of that range and iomem_resource.end to establish
> the 64GiB region used by cxl_test.
> 
> From thread #2 which was related to the issue in #1.
> 
> Link: https://lore.kernel.org/linux-cxl/20250522145622.00002633@huawei.com/ #2
> Reported-by: Itaru Kitayama <itaru.kitayama@linux.dev>
> Closes: https://github.com/pmem/ndctl/issues/278 #1
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com <mailto:itaru.kitayama@fujitsu.com>
> Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> I haven't given this a fixes tag because it never worked on arm64.
> So it isn't a regression fix, and I'm not sure we want to back port this
> which a fixes tag might well trigger.  If people want one shout and I'll
> try and figure out what is appropriate.
> ---
>  tools/testing/cxl/test/cxl.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8a5815ca870d..6a25cca5636f 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -2,6 +2,7 @@
>  // Copyright(c) 2021 Intel Corporation. All rights reserved.
>  
>  #include <linux/platform_device.h>
> +#include <linux/memory_hotplug.h>
>  #include <linux/genalloc.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -1328,6 +1329,7 @@ static int cxl_mem_init(void)
>  static __init int cxl_test_init(void)
>  {
>  	int rc, i;
> +	struct range mappable;
>  
>  	cxl_acpi_test();
>  	cxl_core_test();
> @@ -1342,8 +1344,11 @@ static __init int cxl_test_init(void)
>  		rc = -ENOMEM;
>  		goto err_gen_pool_create;
>  	}
> +	mappable = mhp_get_pluggable_range(true);

mhp_get_pluaggable_range() is only defined w CONFIG_MEMORY_HOTPLUG

This to tools/testing/cxl/config_check.c works for me:
+       BUILD_BUG_ON(!IS_ENABLED(CONFIG_MEMORY_HOTPLUG));


>  
> -	rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
> +	rc = gen_pool_add(cxl_mock_pool,
> +			  min(iomem_resource.end + 1 - SZ_64G,
> +			      mappable.end + 1 - SZ_64G),
>  			  SZ_64G, NUMA_NO_NODE);
>  	if (rc)
>  		goto err_gen_pool_add;
> -- 
> 2.43.0
> 
