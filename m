Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F843538B
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJxvcEmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704424646; x=1735960646;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i7XLlCygYC6AN2SO4Mg1BA492WqBWgkef+dz+0fjKGM=;
  b=iJxvcEmg5Mcl9DDVL0sOlq64jS1zNqJvidxk3UYxhdY7G57J9wyQAxNe
   39vdLSMHaHdPdrtGkx5gmBg3zR9BwdUoiRQO0Venmr3oKsQF04GyTw/2a
   YmMo2N9fNdLRiE/4YbcqAsrrjW9n5wYdKYBQqSWi5tCnNh7ZOZIAMdYor
   2j+u627OODuM4vVN8c7A3NxwjzYCTmSSxaFWtXVi32y2dslM2Heh/DM/5
   a2ui5WgT3OR1PtRWR7PkppUICfc5Z897lz/acfELVLc8BpWB50QP0OlE9
   qoMJuakgb4nGC8EIfseR8lknobKsaXR9ykwrj6/XKoogCyveqKSGUfzVg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4192764"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="4192764"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 19:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="809427531"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="809427531"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 19:17:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 19:17:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 19:17:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 19:17:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 19:17:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI+YncLoH47vyOqVNXHVILtbRzk84JvGgUkooL6NLfmg73ml9qBQTZipay9rMWzYH6IX4lv3k9hXEcjjRbj5fVOh8SpfCj5K3wkenL14Rt580iY4rKQzCcdXH/VyhVVTy8es2KytYJcisH7XK1VEkzp7nxoDULVgSprh/lfyTjFGkU66jbPLEOPA/IiZpUIZnTxrMqGKUeduIGPA6Y1MPOrQ8AGJ2T3ivTsSQmcOBaiqy6bg8RM1IrZSJQV9I+kMtsq1Xx2zhjfjhkUlTdoqTgC+DL0QqKsgW+SgsDAxrrGKN4/rH/wCSb0tZ5p+lneSnQ0cXkhED8t4/JrFyzWT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6ZtKhT/Z5Pz8nzaBOq77WPP1x1aT7wnhC1BoRzqiXA=;
 b=HQzQV7ygMxeuc6D5izV+h7be0KUAdBQDyQYhQui6sigeDNN3LkrF4KVylUPy/Onwfg5/NoJARYlY6Fye25X037LhoX60yJae8bxsMcK4S+dKfTuOiKP6sGDAJw1QZQPWTR2NDprPPz0gWBCiMq0FG6Pf6HQMwAiueGRsPyU32Es7e5dyTiMFwTs24HTrL2x5jt6/USJ0PqT5R1n6qjWpNlnZycNRpx5ficFMh3xRO7Yy7xTwyn94t4Wr4tn/Yt1zgRF2dEObl5yziV6rmtyTqGKufza2lIofyzJxB3PBqtQchVfRWkp8tu0Q39wC6p1IMkVHuZxhAlXIuP8PVV0KTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6166.namprd11.prod.outlook.com (2603:10b6:8:ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 03:17:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 03:17:22 +0000
Date: Thu, 4 Jan 2024 19:17:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Robert Richter <rrichter@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: RE: [PATCH v4 1/6] cxl: Introduce put_cxl_root() helper
Message-ID: <659774bfadb71_8dc68294f7@dwillia2-xfh.jf.intel.com.notmuch>
References: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
 <170441748869.3632067.1712163433527825314.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170441748869.3632067.1712163433527825314.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:303:6a::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 25521e58-2e53-4f2f-7e70-08dc0d9cd54d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cKYkZgZE0I+22pPEzjDjo3qXcjkJ4Q1J8zWrgJkKWQWXF8vgiO6TvXj7JV6OuaAEY9DiPaoFNJ2x7YPsUHANQj+IIdy2eUcNuwG/C7oeFtq6yJJPT7dwC+FWKh42sFoNt4XoFTMv+FumGNy3+h0yEP3AA/FKI+mlo1HtZs5rQ672Qi5lszw2TQnTxuyQ0RK2rFN0MX4+hgp9RSW9cSGAbLor+0AlKPYD5eaHr8hgbh6+fVeG1Jpb8nMdRedcNnWCWJ8uT4v9Vnz5wvniLlPbdQKPdbkvMCxFt5o1z/XFNa5XapEiLJPVI55pjLNWp4P0EIB3ITtQL07bpsfJm+5L63liIQJSdeU+7GlS+0D79Tu0iKIYlJmjH3aYDKHvCCzw3c5n1GiG8s+LpIp9C6VjJIeI9w3ka/AqFm1361QFGq10Eg4UmQzL/N1wauG0Usb6YOXoOgLCjGj0VpeIxeVAwaF7nQcf7vgL2lOCWubAUISPeV/Ny0aJmaaAQjYQmIZKD8mNWjM+n32yV0wRLLlOb22SUFQpkEEyPZqi8q2i8lO2Mh/0Vv/sAv9C1gU97Lj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4326008)(8676002)(8936002)(2906002)(83380400001)(38100700002)(26005)(5660300002)(82960400001)(478600001)(6666004)(6506007)(9686003)(6486002)(41300700001)(6512007)(86362001)(66946007)(316002)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2HEnDBnjDFqoDh/kwOkfvNzmixTsz62pUkBDstqKfz4evV4QSednXmi091s8?=
 =?us-ascii?Q?4nosqnqQckwIMTFzeWpavY5TE1E+kddbVmZHeCS50eE4ZbOqQkC/MkPwgzQW?=
 =?us-ascii?Q?k7JdOk/GbVdiyk3pRHLtb3Q0uqqh3ueOW7Mwp8nIpggr7g+nIfgGwg+7Se+r?=
 =?us-ascii?Q?Snhe9YcbGJAflwVvQQspRvF3UvBzDeNEUCQkCBImOWq+/7torguvQ2oCHT0W?=
 =?us-ascii?Q?MEE1MX5vRMQN6w12/0MkipE6vXswV+UaNRSt5XtMpssJIWP1QQWozG99R1QW?=
 =?us-ascii?Q?73AatMmgAHCzYyXbIT2JsyazOev2t0XJTFoJMeSqpqVD37xewq7x4kikPgm9?=
 =?us-ascii?Q?dI5fDMLKBk40xYcARcZpGs1Zz3iVTscKY/81vI4lJTfWQ2mhJpMCZvfq0Zjf?=
 =?us-ascii?Q?XFmKEOhsU8J6zA+osb5rirGRec7s1KoiTMtqlSvVQC65avdmTxyq0Bsen3UI?=
 =?us-ascii?Q?uX2rwbGLKe755cAV7Ko6SF8sCFqYqIict49oi9sYfhWmK0TTAg4BUoza2j9v?=
 =?us-ascii?Q?3gsd45bEYUn6nlf1rkcIMtLJ40QD17eYEHdOaW9TRc1m1zCHaO+ikLzyweZU?=
 =?us-ascii?Q?uXdH7onUpWIs3G+22X+uwdep3E8jx5Rd/AqZ5OpfY7EA/QAiXHeYGLlL11NZ?=
 =?us-ascii?Q?B7ZB+i1Ola6ZZm20c25YoEEIDoPGF04iCWx3leYw9tXgUp+diRMy8bF0gr8K?=
 =?us-ascii?Q?loP+KQpRZZZeAfFSVmczhqWfnnY7gCw5rRqYcHm8ESe+zkTCYQr5XxB3YDL3?=
 =?us-ascii?Q?qi/K16vowB08iP/qXNe2PtwpE3CaUd08YnT0ilJtSlDPr3+dFOE5JvgRsus5?=
 =?us-ascii?Q?EJjuM3wIkmt05AVKEB2I0IhEtjYoi1QZAiah3a6iJX/2HB22xxjyh0YP7k0A?=
 =?us-ascii?Q?+XjpzW+iJGEOfrOL8lgdclrzuicu8E/+eIGKlECddaKKsvXquPifUyMILA+7?=
 =?us-ascii?Q?cYtQgvBEvjYTJFoYXEbdpAvKTEtZHqNHlcjbDR505FS+0Q9y10i4PbWrZBf+?=
 =?us-ascii?Q?9c8aITvUKXUF/U4CYs6jUcaNOH1CzXbwJ0mEczygQLS4Dl0BEz8f0Juot4sJ?=
 =?us-ascii?Q?VZIU5eIQm3tzzbLE3bd1p3TSVrAsLO0GEUsdUdQ0ZHzZfkjasBe1HUkTqGt2?=
 =?us-ascii?Q?/Q5rm+/DMw6rusvzqqykHPtSPQWu/Qbz52dj8erZJoyBcE7q/OaZh+7pih/s?=
 =?us-ascii?Q?IL6A5BO28cCEgVHc/9uRzs8ojQ6wu1Yea8W6z5kLxcEaaU3Ei7QQ5NIrKtBJ?=
 =?us-ascii?Q?yKkY/qQk60Q9rQ7S9inF+yf/07WUB11cAC5niIktKJtekdIHkQ1XIhdH1rsm?=
 =?us-ascii?Q?3g4psq/n9pnUnOWck6xC/V0G1sMh+Q5hN6pzdjP+Lo7DDe42EfpPzYoxvKbx?=
 =?us-ascii?Q?QHhbEohXpv/ZhBuH1+w20a9+XA2bQn1oe1Et26batl+A0x70zCtF1GrcYBaP?=
 =?us-ascii?Q?Ugw/eixibf4VzWfoqaZPQDSrn6AvJ80iS9Dh47rI/xspnOuYaAvJ0VSov6bN?=
 =?us-ascii?Q?PdCt/FFZpmIBVciNgNwC3O2b5M14El13SlZZ2jPrPvNkEmgYI73io2IOmP7d?=
 =?us-ascii?Q?3c8/Rw4RXwxvr/uCL8gtEEYZLuVaVlSiZqu3PXsnAsasO3ScADQ2OyC4BgvQ?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25521e58-2e53-4f2f-7e70-08dc0d9cd54d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 03:17:22.6384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EPYMbxOBcaKhcAeCSvKbfpkYpgQc7/n4zDWMtSwivSE+mtxzM1BJjn5EixPn02YzGVf70CgBGWlru/hP78WWdDp90qniWWSkUPAVSwiHQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6166
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add a helper function put_cxl_root() to maintain symmetry for
> find_cxl_root() function instead of relying on open coding of the
> put_device() in order to dereference the 'struct device' that happens via
> get_device() in find_cxl_root(). Add cleanups for all code paths that
> calls put_device() after find_cxl_root().
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Adjust ordering of this patch to front. (Dan)
> v3:
> - Adjust for cxl_root as parameter for find_cxl_root()
> - Add NULL ptr check fore __free(). (Dan)
> - Fix DEFINE_FREE() macro to name it put_cxl_root (Dan)
> - Cleanup all functions calling put_cxl_root() and related calls. (Dan)
> 
> v2:
> - Make put_cxl_root() an exported function to be symmetric to
>   find_cxl_root(). (Robert)
> ---
>  drivers/cxl/core/cdat.c |    5 +++--
>  drivers/cxl/core/port.c |    9 +++++++++
>  drivers/cxl/cxl.h       |    3 +++
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index cd84d87f597a..c1085fcc5428 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -349,12 +349,13 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct cxl_port *root_port __free(put_device) = NULL;
>  	LIST_HEAD(__discard);
>  	struct list_head *discard __free(dpa_perf) = &__discard;
>  	int rc;
>  
> -	root_port = find_cxl_root(cxlmd->endpoint);
> +	struct cxl_port *root_port __free(put_cxl_root) =
> +		find_cxl_root(cxlmd->endpoint);

This fix needs to wait until later in the series after find_cxl_root()
is converted to return 'struct cxl_root *'. Likely it should be part of
that very same patch. It's a type-safety fix that comes along for the
ride in the type-safety improvement patch.

> +
>  	if (!root_port)
>  		return -ENODEV;
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8c00fd6be730..f66650bb6128 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -986,6 +986,15 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
>  
> +void put_cxl_root(struct cxl_port *port)

This should go straight to 'struct cxl_root *' and just have no users in
this patch.

I can shuffle that around now that the patch ordering is mostly fixed
up, but in general if you find yourself editing a line twice in the same
patch series that should set off alarm bells.
