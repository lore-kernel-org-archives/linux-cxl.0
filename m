Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D124CF477
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196508; cv=fail; b=Db2mOV7TO8fSavtx+3a2WAvDzG87Ah6owH5HuQdNB0VJaS2YMoS3t4Cuzmh+1C6KcT0wi6a7r1oLut0FkJHSBOLgPNlUQvll12bPyr44+IijEP3D215pJth0jnJwnEVYJZMNkdCZTfIQBnM8saHdyE+BQMQ69mXpaUZtsN/0zoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196508; c=relaxed/simple;
	bh=s/3XMuyb3Aox3mYpNSZiJCFyTqgWtdAqk7qDDcUsR0g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RtNNDV9FJfvdH8LKWuO4P8CZv87NRiqoOIMaeTgUEQCcPJGCWU72X2XOjSIB3emXojtcbrHPFp0LMr2mUHyrztccWy4fMxYlqx5ZqyhGTJ+GH2AOyIMmX9Jdbq4SVEQnefCCEW0zZTk7Mslc9T7M9ToygXsDf/6E90Pb0UoIts8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i00g57w9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i00g57w9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792196506; x=1823732506;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s/3XMuyb3Aox3mYpNSZiJCFyTqgWtdAqk7qDDcUsR0g=;
  b=i00g57w9IENBqtCTBj4VneXFtGn+uO1oRFPEcDUzA646rd+Ro4Yx8PUL
   cZAsJ+4GOHKTisFc2tIh/fg2V8x50Nu7dVeg5OTpgM7tSCgR5FvqEKRIz
   6843a8CXnDjwHY21n0Ph3tLw+pLSqjI0PdmMgL5FAAH2TJacjBApJTv4f
   GBeWZxk1fv1PYJERsB+uGsJ1QGLdjOS14txt4I5XEhAPWCE1WfhC3uufk
   5morDWecQ051v6E5qAUNLNcReDdoIm0ub1lphH1KxLXaMeAO1Ddd9b5+P
   nNquIhPGbIeDKv/u0raeZV6275LIUemwn9vS0Hb98njrJ5cCeKEQMNXXL
   Q==;
X-CSE-ConnectionGUID: kTMp4GfKSF2hTbIlR6POlA==
X-CSE-MsgGUID: GK4GXpDCSumrYDDYac5WCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="994855"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="994855"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:21:46 -0700
X-CSE-ConnectionGUID: jGOHi4WLQg2EDKecT12sSg==
X-CSE-MsgGUID: 2/BUqx2dTAakpR4ToI9YTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2538051"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:21:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:21:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 17:21:45 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWGPrG3rOq25WiwRY+tFuHRRCIpaDT2k75yU81vH7QvDVZxpR7FQffvVTdJrEk5fgn1BqUk1RbOI8jYXmwsTdOriqD1MZ65SsNbVsOYrObJcVtGveIQSM8eFN17ohLDjDZIzJjTuAd2m8DObnSgQXw9qafVgzRP9+JZx9DBYMcrrxEyII8ecn5/8FzDmDONr6tfDHkA9rxr85+EcIhtexTY/Zxw5kljvCBJqG0iLSNcy9xiobg1zx+9bcGCASdzWlmD9YNx1YeNDSVbncMvLSAXpvJdp5W0nSqNfnSJYlHDRRg9RnZrLGoHKAGbRmx6owH7PB6qDZrdjMkcKNPi1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeRpYCgPY7mg3Y/CywxyDebJTwDV3YPLPfzaif43RD8=;
 b=lrKBRLe1VqtbRRnXbDEaixGqqYaLRNFgWn9GnyH/0fxRad0uZaQ7j6p0fG56uaaz8N5+Yfxbsa34EWkDfLwMevE2Uh3Ioo7LTkDF05aXcfA1OR6V+gK64dqKBb9TIaMrs3CZLQtjbZOxhYTk1uOGRsXvbryVF2cxjm76+94ztcnXnOEBgRnuvWw6IyOhidNZwk1UXLN81XbNN6HBklfastFxY5nCpc6UVBmrxmZDd9uM4mbzLM0hX8wbkIX3lsnx2JgR9c0P6uUukeDVrafngWd2bRfZV9tOJnhDTzqpGymSdKt3QakbUdNtaCfz5NcwDx/EBv11geN9ibvuFBOCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Sat, 17 Oct
 2026 00:21:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 00:21:43 +0000
Date: Fri, 16 Oct 2026 17:21:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Richard Cheng <icheng@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/7] cxl/region: Factor out cxl_port_peer_distance()
Message-ID: <atK_ihTf6uqo6c3a@aschofie-mobl2.lan>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <ab51546efee79855622d10a71993ef7d21ee247f.1791860305.git.alison.schofield@intel.com>
 <as9E1ldLkjpdfTDr@MWDK4CY14F>
 <20261016192543.5895c34c@jic23-hlaptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016192543.5895c34c@jic23-hlaptop>
X-ClientProxiedBy: MW4PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:303:6a::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: df10172e-e0b3-461b-eba9-08df2be49efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261009223027099003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lXlX3gjceK+Qg68C3rSx2G6zEIKi0ylb4CCeqdgo5EYj0quW50AnX9Uo/MF3T5cZFjIOgP1AY1gAHTJdCYFw7QHXNCdAIVcFbWcqEVH6/JXh7c5vAsQKkhfqko940Hc9PaQDnBP9TwAkUitEE3oEQlB+fr+gjkQyM6zE9d5o0W/17ZgcULcPTHZAy3keyOT5rWE5gLFVeKkl4uFVzVLCjGbMb5r9+FMae47CqaHhNX1tl/l+l2oDj2JDxYyQ+OZXAQ/vlmKZbo+3rJOP/QvYVlo2aVSzKjQ6eozS0vVB2Gd5Hd/xv261uwjhTO6ftWCheNtIRfkQwtiZzhX5GDm1Cv311ClHxehffGcgBDcRwpenmOBCxm2yr3AJ6tm/6J5x8ALhfq6svfupxHaV+e2FGbqVvxrgr+GV51tmBfoD2bjt7Qeruze3umsetj8cqTTP56JzSqF/kaDsb2M7798ONds4qmswjBCv417Lugp21ahwGxafs2UyD8SwGmrclQOHYB3rgVGWzAcypcYB6iP2Nb3+50WGKPTT/B6JLwGoQG/uOlioSyaw0KmMk13jkPb6CPzLZAj/kZtf/wUwlamCmwJoQP1qqpY9SHj19m7LHwPXfuLfsydKg0/CKztKjt2WnWcJ4q+zabhZb6b1TXreh8tG5d8Lm+YZh7VXyyT7Pl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261009223027099003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HJxMeV+c1Q76snM7VkUSnaj/+Jby7NrLa6IZK4KDuNvjwDYaJZzFajov7q4L?=
 =?us-ascii?Q?SwQftGhQ3v+lr8Wc8Rle1zAgj7lCcd9yFK1pEhCjPrMM3CdC519L7S3X+LLU?=
 =?us-ascii?Q?lgmVFyp6QjitaOzmBRw+UKcZ626gmH6e+shEgvUjlMO+kvl7rVVNdCCYXeFv?=
 =?us-ascii?Q?J+AiHYV/EIHrqNyqJCp5eNxsqf1Vq/7Ywu+6t3Aw2EWne67fxU44WDTeyKzh?=
 =?us-ascii?Q?jp/l54cCEp0e+wQK654pahLuvRrv235sjVZ3C2TQxP107i1/dPtjtpDYoMt7?=
 =?us-ascii?Q?KPBNvsvFgJ81lp8nlG53j1fUR7Po3j9zfsOszvv1tYtb8MDocfnSbhX9VtI9?=
 =?us-ascii?Q?BGEWILVfI+Y0q+7IvYk+OYtnsVYz0+De3BlWMEFquug7r/pP8VYRBEUKkFvU?=
 =?us-ascii?Q?m9NXrxruORWIPIuQAGdnQjLTu1Ems1aWWTxUJ0JOoRAsQ3OufzXC+tRNdByc?=
 =?us-ascii?Q?Cn9wVW06Eiqt8hB/getAg7pl1tL+ZbXAU4kKxexpZVR9n/CZl/Kiuh5iNZLQ?=
 =?us-ascii?Q?PkKDhSg4zUdbLcQIt8bvjote6eaFXVFZvga6rGaaUXyL4LX3VE3xOLcC4/IN?=
 =?us-ascii?Q?fyBHzm7d980QpaUaeoGgePi3aLTTsCM1TAGdUr9XiNXAZnvp0jJ+/FlKUGOl?=
 =?us-ascii?Q?kY0q9fjzbab6udIZyZdiTrg3vn5TFgOkdYo/n9mTOpex2nyU/OHzqcWf1nri?=
 =?us-ascii?Q?YjRocC8lUeQcEV60+Hw2u9nqTK70o99Cf6hc3cZ+QuwZn+lDGuMVdU5VhT4x?=
 =?us-ascii?Q?OWpDYWBckSrpZa+cShrQuW5yilr498AL3VvpUnr/eP20SoeWJ2RMGiSINsfC?=
 =?us-ascii?Q?YxYy9bnEvq/HLCFPHZ3FOZuK/4ltwHcp4BiPeJezm/CXMa30KAv07q6Xl2wW?=
 =?us-ascii?Q?EKD1qo9Xr6IZOgg9243PjUgc9XhXd8TbTWnVdf1RhM+jfkIk+VKwr38tvoYx?=
 =?us-ascii?Q?Yg+2HteGJmyBP4LYlVnXjGSo0UtdypUb76CGVO8vmqGdicwfcHXhNZoQtTu+?=
 =?us-ascii?Q?1rFUMs9TPUw7v3pnjl8KtT43uE9HNhbDTmxmJ3852WUoJU+XOpVXn/mv8N3y?=
 =?us-ascii?Q?DiesO2oSNqABdW7dX6qV+DgmtE1+RdoEciAAF2xvGuBqEver8DVZiQ6jYmh3?=
 =?us-ascii?Q?5SwOK9TEVsZlpihgklgibu774k6AVPqQhUgJzlFUi5uDbkSCRc+7qIp1R1qr?=
 =?us-ascii?Q?azqjTT/7hpVwRpDIfg6sgORQ8vrkjxKtkgSprZuaEmO7skUTnPlp1UyjbAcM?=
 =?us-ascii?Q?9iXLycQ/8dp8UVjyxmIHl9RNTkWZgseTYvYZxonYWVuHoQuvyPV7OeGmCRLP?=
 =?us-ascii?Q?PZmT/vidX6Q4XDxiAOTt9/tFtXN738CvCon1z21O0ediH82aKC0vQ6qc+OJd?=
 =?us-ascii?Q?9SQgCVIJJp6/TF5b3z+iN/4P/nINDrDNA3kgRjlGv1hwUt9/Rx+ReMW9vt7w?=
 =?us-ascii?Q?T8ZUD0JD1bZZaqiMIb6tOxrTt1KPGBFjWl6qUTGlA6FSwIID0lo/lM4I4/F/?=
 =?us-ascii?Q?VSkQbJQ6yi96Y5Fq568ZXA+F0EzEv6mo4jkomGH6SpQv8vuAqDmKpWHXuXez?=
 =?us-ascii?Q?ZYJ/kmecV2uQrUi54/Yimc4+gj5bgzEHHZMCRrGkTgSJqy6O6EqfwtWg0A7+?=
 =?us-ascii?Q?72gGcq7ynEdlB7qY5anVDGP9MT1ji48f2QFtoSJWawN8mN9F48w0sOtTT0+u?=
 =?us-ascii?Q?Dl/omkLVLz4g+Q5PHwGteQR3xJ6c6+O2lE1oKA/nPAS2DKPj+dPYpxYp9r7z?=
 =?us-ascii?Q?sM0gp0Uqpt58vQZidwEdoU4hXi/ZZ/k=3D?=
X-Exchange-RoutingPolicyChecked: nn+X96ZA+LzyJriXUYMOtkoVzpoDqavZK5tIpq13utVNcAcR+CqynuOXiYWcOO1G4hnHL2ppDXaY6MUea3UYWNYRYqub3gmoo7LbZDr7L3EE0oPnBdtlqa1tdRT+ZYMTcJnJVH3DfQcfY/hJpZKT1A1NLOV5uKY9rFmxdr1gsdXEK63gjLeZmPGAtrqRUfYawNoSQ3EzDbUmZ0yHnd038+ie5Bh7txu+nQS9Tg8cfqb0+xEm1Ee/lX3GASEpu+YzOYA+FMKoai0gTuXb6tS6e5ltj5KjJNuFxx/z5vf+8IxtCGCRjyZ9Em5gjkCn9M6JqHoJNTcNBBjr5KKDusb+Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: df10172e-e0b3-461b-eba9-08df2be49efb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 00:21:43.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk2n+lYQYFYdxWhCZcLDNb5TRisw/tTHn4fcyTp3sMLJqdsmB75EIRcvB3of485RLM9WZDiUXtMlu4/NaDXKCUmzTZJ/ZPV70chNcI4IEKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 07:25:43PM +0100, Jonathan Cameron wrote:
> On Wed, 14 Oct 2026 17:02:35 +0800
> Richard Cheng <icheng@nvidia.com> wrote:
> 
> > On Mon, Oct 12, 2026 at 09:25:59PM +0800, Alison Schofield wrote:
> > > cxl_switch_port_setup_targets() is nearly 200 lines long and open codes
> > > each step of adding an endpoint to a port's decoder. One of those steps
> > > calculates the distance between region positions that share a downstream
> > > port.
> > > 
> > > Move that calculation to a new helper, cxl_port_peer_distance().
> > > 
> > > No functional change.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>  
> > 
> > Reviewed-by: Richard Cheng <icheng@nvidia.com>
> > 
> > This patch inspired me that there might be some space for optimization when
> > facing different topology, while keeping this one as a generic arithmetic.
> > 
> > I'll try to draft a RFC patch series these days.
> 
> The patch Richard sent probably just wants rolling in here or slotting
> in immediately after. 

Agree. Added it to a new patch in the v4 series.

> 
> 
> > 
> > Best regards,
> > Richard Cheng.
> > 
> > > ---
> > >  drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
> > >  1 file changed, 29 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 9b0e2f195d1f..ea281ce4ec49 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -1432,6 +1432,33 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> > >  	return 0;
> > >  }
> > >  
> > > +/*
> > > + * The "distance" between peer downstream ports represents which
> > > + * endpoint positions in the region interleave a given port can
> > > + * host.
> > > + *
> > > + * For example, at the root of a hierarchy the distance is
> > > + * always 1 as every index targets a different host-bridge. At
> > > + * each subsequent switch level those ports map every Nth region
> > > + * position where N is the width of the switch == distance.
> > > + */
> > > +static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr)
> > > +{
> > > +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > > +	struct cxl_region_ref *cxl_rr_iter;
> > > +	struct cxl_port *iter = port;
> > > +	int distance = 1;
> > > +
> > > +	do {
> > > +		cxl_rr_iter = cxl_rr_load(iter, cxlr);
> > > +		distance *= cxl_rr_iter->nr_targets;
> > > +		iter = to_cxl_port(iter->dev.parent);
> > > +	} while (!is_cxl_root(iter));
> > > +	distance *= cxlrd->cxlsd.cxld.interleave_ways;
> > > +
> > > +	return distance;
> > > +}
> > > +
> > >  static int cxl_switch_port_setup_targets(struct cxl_port *port,
> > >  					 struct cxl_region *cxlr,
> > >  					 struct cxl_endpoint_decoder *cxled)
> > > @@ -1445,7 +1472,6 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
> > >  	struct cxl_region_params *p = &cxlr->params;
> > >  	struct cxl_decoder *cxld = cxl_rr->decoder;
> > >  	struct cxl_switch_decoder *cxlsd;
> > > -	struct cxl_port *iter = port;
> > >  
> > >  	/*
> > >  	 * While root level decoders support x3, x6, x12, switch level
> > > @@ -1460,27 +1486,9 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
> > >  
> > >  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > >  	if (cxl_rr->nr_targets_set) {
> > > -		int i, distance = 1;
> > > -		struct cxl_region_ref *cxl_rr_iter;
> > > +		int distance = cxl_port_peer_distance(port, cxlr);
> > >  
> > > -		/*
> > > -		 * The "distance" between peer downstream ports represents which
> > > -		 * endpoint positions in the region interleave a given port can
> > > -		 * host.
> > > -		 *
> > > -		 * For example, at the root of a hierarchy the distance is
> > > -		 * always 1 as every index targets a different host-bridge. At
> > > -		 * each subsequent switch level those ports map every Nth region
> > > -		 * position where N is the width of the switch == distance.
> > > -		 */
> > > -		do {
> > > -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> > > -			distance *= cxl_rr_iter->nr_targets;
> > > -			iter = to_cxl_port(iter->dev.parent);
> > > -		} while (!is_cxl_root(iter));
> > > -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> > > -
> > > -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> > > +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> > >  			if (ep->dport == cxlsd->target[i]) {
> > >  				rc = check_last_peer(cxled, ep, cxl_rr,
> > >  						     distance);
> > > -- 
> > > 2.37.3
> > >   
> 
