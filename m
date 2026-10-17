Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0963403EB
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200536; cv=fail; b=lEi5gpPs9hF1zj82C33dXy3Cys7/2wdKkXyBNhnR1QQFFdVBbROyVJ4Y0I27J0XupsljFIs7Vn/tuZCQRaopy4mryk3oi0CD6gaDu/U33t1rAjsS+FPuFtmG8/Fq5+bgPV5xkgKkf+TYnYwUSYazYCgCVPcvCvYfcBbEcpnxICw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200536; c=relaxed/simple;
	bh=QlOiZNLIu72CMh+b2frnrjNhSYqOk0MfQNlyo5xdw9I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MgVKPEdoFj6yv632w4A1TSuCByQlhBtSgOSqqsWupfr+frEXgYMHZO8oEo947Tzi5pfdJb+63/6CCKMHVkQPqMkvzqavDNGiH3PX1v+qSXXlxQz66JCrjPwMjujZu8LcsObd28D3iNz0Tkk48CZ4iFcnn+xKE9ZxRD/bNpmq6l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMmvyilq; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMmvyilq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792200534; x=1823736534;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QlOiZNLIu72CMh+b2frnrjNhSYqOk0MfQNlyo5xdw9I=;
  b=QMmvyilquSOW64buxLakvvlSJ5CXzG8KqU2qTzu10EZcCfBiQFi+vr7X
   BSsaW2UKl9qqmxi9EhWkTHa/KpG4ryeYjDq0PGLyyBmgu5XQIc3QIRH3N
   7aBdxEPW1CYC1AAw0+kLeHaa7WAPt1+7Ab4uIiZZ4b35qryaSha/XKp90
   bHokWvHS9S91DNJf6IQ9xvFuF4yzbL4jxsCoatu8SoL3kh/dLQE3xqWQH
   +8QujTFFPb93Iy1dggHThcYLIekPYyljCwf5kqUumR6qTBtK9EdxmAFi3
   /IujC9Z7Kv33JjWeUENOqQpiXcdhHGdebh44A32jHIbk9tLtkdFEGyg6E
   A==;
X-CSE-ConnectionGUID: h1EzeI23Q+qH7SMgE8iguA==
X-CSE-MsgGUID: H6nIrzBfTXuAhN13fSn5XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="992474"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="992474"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 18:28:53 -0700
X-CSE-ConnectionGUID: NWHyQ9KES1mHwAhQtTItXQ==
X-CSE-MsgGUID: ybNERVjVT82kz4wEUU8Yaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2138976"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 18:28:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 18:28:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 18:28:51 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 18:28:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFtuxmf7VUo8BAjRKS5/tLAWBrVtCQerJL7gJPvkLHCuxb6NwcmEg5lvE9PGR0J3mOiO7Qx6eC6Wk/pxsgq0mb3WNpV3zsHy/G4lQUfv1y9/C3TALHvqQ50L4+BGvXacShFzH3f+2rPGuOBkP8HGBSY9+1Z1ifYiYj5zQxWdMxqcjdIfQm3pQJ8UqK1AR3v2hMC+dn7nHa2kgDhgr8lJrb9cDXOI1JS+NrOkPzfKJoM0Q+Yb9mSAOPdG7+8QX3tfQwHNAsBXP0FwVLU0P/AvnxtJKbLjrJDwinm2Hrb5hVI8bbR/IjanuG5hnnglH3p7RyAh0vtZN1H98mB2jYnNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4voGMz/x88Pc1xuZDLh9aHpmUB83rR5VCrv5kaO07dA=;
 b=Eezao2bWsVFpGF81HOhK9HQtvL6EPeuDmdUJEM/lvNuRymhnJJpfLiVVE4UeJhI5EhduZpzz1VGDwE4nV+NclEp8xO1nzCej1kZHHAux0xdq/GN+4QbcNSZgN551xoJl+5wX2UqDjs0M0WCne4WIbGeWuiokO8Y9qZj3qRPMQvUhuBO5AjUwD/o1M2AUTbU08TG/QP4Un7HqfNd+ZajWcIhhWujgre+F9TKeNrve7ZH0XPP9XuOTfbw03ByDgmSfz0BXF3zS8ZeJrZiKCbWF3djh2wUs53Za8Zk0eFqW0vnJc+34xUU/epJC29/kbsDP+TY8bjPHNqcFU6ZW9lb+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN2PR11MB4631.namprd11.prod.outlook.com (2603:10b6:208:262::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 01:28:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 01:28:43 +0000
Date: Fri, 16 Oct 2026 18:28:39 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] cxl/region: Factor out
 cxl_port_parent_interleave()
Message-ID: <atLPR4H39n0J4LR9@aschofie-mobl2.lan>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <85eeb8ae3272c57cb5f1a5ea8b4e0b635b71b188.1791860305.git.alison.schofield@intel.com>
 <as9IvZJ8aAU71yxY@MWDK4CY14F>
 <atK_HlWRv_-gTjSn@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atK_HlWRv_-gTjSn@aschofie-mobl2.lan>
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN2PR11MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: cb953f39-d0a8-49f9-2dc8-08df2bedfb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|10067099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: B6qXtTgTpFm65yU1I/VmSMQJgiJSMZbmnHNzu863o3TzVBPj53PJmMCKI4ShD/fbPjWTPjFM7ivcugEPQ4+yUYiLBch9ZEqgSrDwQWGuTWicwNnkkXHP1Txvi9gY+SS+Y+tCXFBmkw6mGm46xbNWP3HkKDfxeglVPB9SHIm2KwSWW2oiW+ZgnxCZN9Dxx37YrRP6GwM+xZdmHj4u9BlCJ9/d8GG2qvylZLaadXztRwHTo6qP0WrK7VEmFN3DGpoMzfnbhbt2tbT089IuNRnPchvdoQhH8mJ2xjhSu6/YK/dO2nHacSrWOpeYXAbTTIjW5L3WhGSSIm/JnGZISlBkP9iksXdk3k06RMKuD2oP9HDNuMNuWGPHeDTZIyGq2a4Opqn2AlQLtLCULDjcXDuvfURh594vpK7R1yPhknqSYByqGr3IQoIeEGEYZOWpAjxl5vqJ9ccHp7BNuCan5q6Bk47H/vKCXu0yzG2aMWkl34cIJLYNM5RF2UsbLqL54VJLyY9gWmAevyrKY9PDGZZnYpOAMDLpfZtqxb0sYzdJKpmNb+wGJwTbfMnsDyyUDJS6sg9DIeUj0QrXJdCtgpC/WSrEuoEDYAZ3jTO/XJSaz01VskhEGRs8lCCQIn4Rd6doLIOx3+lpJJb6q3ooED/pMdRcjAxmx/YFMkQ3WuwN7+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yvq4AWXommrTY5VBHVi/mZRBhMD9vtWKc/bUaJOiN23Ev++9iXCB0sHNCvx8?=
 =?us-ascii?Q?cHHyq01VZdCT436QIV1mZEUhoNXfTj+5MSehKQ9XIxfXqKVR78hAuU/KKnDr?=
 =?us-ascii?Q?uj9n1JsBEUWffsCmbP5qrwmPlr1Epr0mxu1B0hLbZfUoesvf3Ktx4ZhYtr/K?=
 =?us-ascii?Q?+nSBkurvinZCe+XfMWuru6PWoArqMJuqg6kU255BWLXDWaNKyMgW7xmKeMFz?=
 =?us-ascii?Q?o7NfM4aXqPfclzja51uGODDwmeNHIKqbZl9hJ7ec7xRIUTjbNLSrB3ppjPEb?=
 =?us-ascii?Q?LC6CbYNEpys6Zmx2xfBGtGgXW5mDkpA0pz2gxgy5ug3Bk//EJGWoSsfDgJMn?=
 =?us-ascii?Q?qpGeJLjlHZg8ErC0DDC6KxyKZPqn+fB4mRYE0PWsubXDAlNrRqci6fWjAWtB?=
 =?us-ascii?Q?CS1E4BLo8iX1vK627wUn9tR4oI1zE7Dgfc+B5mkuOqVk954WPLrCEvgJKkjt?=
 =?us-ascii?Q?B9cGlkqWCI/Jq4dqsmW8jInDuXQiS3P4kUESxPB+xngRBkoTkSWKk886/q7b?=
 =?us-ascii?Q?ZgxTRKKCdqZmfKUmWQj3NflD0A80LevkjsR9uWsnta6ibDzSN55qs5kkTZ8q?=
 =?us-ascii?Q?Cq+XZphmwtA5L9kIF6UOplzsu5xHwhNUHj73a3b/u6SYWQKeZACYwisCmkTJ?=
 =?us-ascii?Q?OtIbGDGkmPkRk55Kwc/EfpYXuFmBirUbQFbR+CN1NTvTmCeIw1dptlLPHNB2?=
 =?us-ascii?Q?1v5y3Qu6Z01OcvPbWgsOdHqs+f45yjdlb6SgTowv8p4eS+tNJTCYdIEfbOaI?=
 =?us-ascii?Q?0QZPomBFQVisFB0SpBB2QMR/90GK4WEBVbRlAwe5rIWYN/Uqoc4+nwIVSHPl?=
 =?us-ascii?Q?L0lzU2AK20Z84TvSuBjQUngevoWZ8UaqmOIvkmyG+PosmiK91BB34NP03tT8?=
 =?us-ascii?Q?C9t0GIS4Sf/db+pf4RnXSc9IVZGsOp4aTVG1GFkTyOO4ZBGNgtBDXci9qyFv?=
 =?us-ascii?Q?yIa5cnks9RrFAgt7W+nj1caTWwNv46EsV4eKrnkleJ8x4YGm9c0eKVgb2Zgo?=
 =?us-ascii?Q?5X2h9tHOrykzG2UuFPXebreGUOv6LrCSAkPrmM4GEdDaqyXeIaTrWiFouUo8?=
 =?us-ascii?Q?SU1baBJcx0UplWDnZXWJ3f1LjORBSCyRyNSTRBGGf70rnKYqr0A8KqLOdV5Q?=
 =?us-ascii?Q?w+1F4CGy7+pKY1CnfCkcnN3FcMftHrjazvvFVsWJY8jj8u53V7OWWpKAy/C8?=
 =?us-ascii?Q?oFagpT9SPKR9ez2yJwitW2LHD1+96/AexQ/pEyhguFZQsFMxzuZuqyqbD9HL?=
 =?us-ascii?Q?hlxJhNwS/8RXaRSLngvLnjYN9p0lFMFmjtjazhKw6+HjvNACXkh/orROrpyp?=
 =?us-ascii?Q?ewB6r4JIwur6T8jnbnTTi0s9NUhJfiWeDY4rJJkzdXWCV3BJc1eVKNds3Iwt?=
 =?us-ascii?Q?JUqXriIEzeMVSOxhTffC82g2MiLAcwca7N8Y8dpiGe1Zb4OT49H0FrfDObCR?=
 =?us-ascii?Q?yBODjb6FK4MZlx4oC0skDRMY7j+NbuelAU/YgFid8oARBITDLxoWPB7c3bf+?=
 =?us-ascii?Q?EaN2b2hXc5f765k/8wkp388ybC8BwFFC2Viq6nKPdnVbcU4sBbmJZlsV7XO1?=
 =?us-ascii?Q?8aZbsfXi/pzHcH2YlCCXFIHKMjhuf6aoOqeSUeEyNelF7APw/c3Y4aObRUBz?=
 =?us-ascii?Q?WA4uGI2Txl+Hyfgl2BKs7GsoEoOCveOeV6c/QfhqD38MfEvJdA2qYExGjVnh?=
 =?us-ascii?Q?4joDW20D1VgR3NqKR1FgbBpOroE4kMgG+fcYrRqEAyrn5kfUVdepm5XLzd8X?=
 =?us-ascii?Q?7vcDdb+a+ssq6hqe9XgmIYAHhKoLYVc=3D?=
X-Exchange-RoutingPolicyChecked: FF4EXDBXWw2woLWBNWqlYKek6o5rCQis7GKydNVBRAqvqOGJMisV91D91sa8wLdjd2zoBOEEENX53pYaZ8EngROjW/dowFhn32ZdEalQiRZDFxZfCk7HLShI1+fRsonMcAD3BweEcZJd/2CkCZoImKXcnfU71RglnpHgjnf5aief6exPAeW92YUbt7LfxV0TAxGTZhOLKB8hvBFXWM6ONed1xzzJuEI1SXPRlpiE1TSc5ZmgH85k8gdvMVmV/ebkz0ZNyySWZRuY/9cH7se0vanKWHA8aJ6iYe0F7NYqWua11Wtn1QF+AdXx46RUrVvWozDGd10VCi7GJVZbOX6otg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb953f39-d0a8-49f9-2dc8-08df2bedfb78
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 01:28:43.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UFfg7qBDN/6C9gSw0WBbbjstJCaExYK/7yx0Bu8swg3+CPEn0YwkvDhcCyFsUmPdqpswR/HszOX6s2zANYuCk6YKi0ggPMjc5Q16yyun4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4631
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 05:19:42PM -0700, Alison Schofield wrote:
> On Wed, Oct 14, 2026 at 05:26:21PM +0800, Richard Cheng wrote:
> > On Mon, Oct 12, 2026 at 09:26:00PM +0800, Alison Schofield wrote:
> > > cxl_switch_port_setup_targets() derives a decoder's interleave from the
> > > interleave of the decoder above it. That parent interleave comes from
> > > either the root decoder or a switch decoder, and each case is open coded
> > > along with the parent validity checks.
> > > 
> > > Move the parent interleave lookup and validation to a new helper,
> > > cxl_port_parent_interleave().
> > > 
> > > No functional change.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/cxl/core/region.c | 88 +++++++++++++++++++++++----------------
> > >  1 file changed, 52 insertions(+), 36 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index ea281ce4ec49..c14ac041c4ac 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -1459,45 +1459,13 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
> > >  	return distance;
> > >  }
> > >  
> > > -static int cxl_switch_port_setup_targets(struct cxl_port *port,
> > > -					 struct cxl_region *cxlr,
> > > -					 struct cxl_endpoint_decoder *cxled)
> > > +static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *cxlr,
> > > +				      int *out_iw, int *out_ig)
> > >  {
> > > -	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > > -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> > >  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> > > -	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> > > -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > > -	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> > > +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > >  	struct cxl_region_params *p = &cxlr->params;
> > > -	struct cxl_decoder *cxld = cxl_rr->decoder;
> > > -	struct cxl_switch_decoder *cxlsd;
> > > -
> > > -	/*
> > > -	 * While root level decoders support x3, x6, x12, switch level
> > > -	 * decoders only support powers of 2 up to x16.
> > > -	 */
> > 
> > Hi Alison,
> > 
> > Can we make the comment more explicit ?
> > For 3/6/12-way roots, the helper returns a normalized out_iw of 1/2/4
> > rather than the parent's actual IW.
> > 
> > Maybe we should document that return value convention ?
> > Simply browse through the helper, I would think it just retrieves the parent's
> > setting.
> 
> Thanks for the review and good point. The normalizations happens in the
> root decoder branch of cxl_port_parent_interleave. This diff doesn't
> show that because it moved unchanged. Here's what I'm planning for v4:
> /*
>  * For purposes of address bit routing, use power-of-2 math for
>  * switch ports. For an x3, x6, or x12 root this returns parent
>  * ways of 1, 2, or 4 rather than the root decoder's ways.
>  */
> 	if (!is_power_of_2(parent_iw))
> 		parent_iw /= 3;
> 

Ah..that did seem right once applied. I actually placed it as a
function header which you also seemed to be asking for.

And that did make me take a walk thru all other new helpers,
because this is the second function header added. I didn't see a
need for any more. Others are obvious from name and don't need
clarification for callers.

> 
> > 
> > Not a blocker though.
> > 
> > Reviewed-by: Richard Cheng <icheng@nvidia.com>
> > 
> > Best regards,
> > Richard Cheng.
> > 
> > > -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> > > -		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> > > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > > -			cxl_rr->nr_targets);
> > > -		return -EINVAL;
> > > -	}
> > > -
> > > -	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > > -	if (cxl_rr->nr_targets_set) {
> > > -		int distance = cxl_port_peer_distance(port, cxlr);
> > > -
> > > -		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> > > -			if (ep->dport == cxlsd->target[i]) {
> > > -				rc = check_last_peer(cxled, ep, cxl_rr,
> > > -						     distance);
> > > -				if (rc)
> > > -					return rc;
> > > -				goto out_target_set;
> > > -			}
> > > -		goto add_target;
> > > -	}
> > > +	int parent_iw, parent_ig;
> > >  
> > >  	if (is_cxl_root(parent_port)) {
> > >  		/*
> > > @@ -1539,6 +1507,54 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	*out_iw = parent_iw;
> > > +	*out_ig = parent_ig;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> > > +					 struct cxl_endpoint_decoder *cxled)
> > > +{
> > > +	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> > > +	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> > > +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> > > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > > +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> > > +	struct cxl_region_params *p = &cxlr->params;
> > > +	struct cxl_decoder *cxld = cxl_rr->decoder;
> > > +	struct cxl_switch_decoder *cxlsd;
> > > +
> > > +	/*
> > > +	 * While root level decoders support x3, x6, x12, switch level
> > > +	 * decoders only support powers of 2 up to x16.
> > > +	 */
> > > +	if (!is_power_of_2(cxl_rr->nr_targets)) {
> > > +		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> > > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > > +			cxl_rr->nr_targets);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > > +	if (cxl_rr->nr_targets_set) {
> > > +		int distance = cxl_port_peer_distance(port, cxlr);
> > > +
> > > +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> > > +			if (ep->dport == cxlsd->target[i]) {
> > > +				rc = check_last_peer(cxled, ep, cxl_rr,
> > > +						     distance);
> > > +				if (rc)
> > > +					return rc;
> > > +				goto out_target_set;
> > > +			}
> > > +		goto add_target;
> > > +	}
> > > +
> > > +	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > >  	iw = cxl_rr->nr_targets;
> > >  	if (!ways_valid(iw)) {
> > >  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> > > -- 
> > > 2.37.3
> > > 
> 
