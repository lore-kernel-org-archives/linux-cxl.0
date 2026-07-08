Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669E1C860A
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478027; cv=fail; b=gDazmd09lh/3xskOQ4q514e//BgSdZh9Mppky6cSubcnhHegsH2zsewAAy4KwQ93vTfh6h+13uJ4SujI1lE+8f2gEKx3XxC7AMtC+PaJdjJX+BzN5ZyPxdIRWY1AWvRQzCfwfEuM7AzRbZbQ5czSSMY3xYeqROiAGu4g/rG8+/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478027; c=relaxed/simple;
	bh=mXbUe5wY/8cp9uAjYdbtlDUB+yt150/lG7iajd5yZr8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cg+D3KmHhMW3CEuZnAv8/X3gmcdbQQObLuHvzkhq8SSWeKUXYTL+oYmmWSrgi0nbuffUTAnM5jaXsvpomIv+zn2jYEGqGj8MwN1mCDQY+YLQ6jrwT/C3slNrd1uHjutbutWJChqV/nmT5r8NEbhJ7DCYDGjsN2+QihIKlIOmftk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnFIAxYr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnFIAxYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783478025; x=1815014025;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mXbUe5wY/8cp9uAjYdbtlDUB+yt150/lG7iajd5yZr8=;
  b=CnFIAxYroO1H7x8YrMgLz5Fqs4lG0PV/QPM9VhPPrgaSM4GUgUzvHICw
   aoGq+iV8yTzzjA4fwLlZOJD4HgMzAnV08kzzrNYnWoFaBALB/Ooqs2di8
   N6J7NJVjlfOCcNSKo3AoJBBeVnZIkWE9yDQVg5zBn4hugAGUKz+a02Q7i
   KT1EYhHlHOoq1X4QsqwDHwCaYIYts2/5lZZfhZE8V06Ow7JQfPPYw/Eui
   S+r5tNSZvJw7eA8xDhTF9rTD+1bSKp1WlhmkxPbm7+frus+puFAVZe2yd
   WXwDlBxipDiI5CQg9LG0MGlaL3Tkc3giTXjwBWAVrGRoL+QNosRtrEZT8
   Q==;
X-CSE-ConnectionGUID: nA49IrN/S+uc7CRvQnl7Lg==
X-CSE-MsgGUID: EtaG0st9TwG128HFjGK27g==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83991247"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83991247"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:33:44 -0700
X-CSE-ConnectionGUID: qQr/PCtqTKe49delpfEvvg==
X-CSE-MsgGUID: dMhQoYMuStKzrpE4W1PT+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253663930"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:33:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:33:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 19:33:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaNkA2BJ1INIU+FF82j3SRR8JVE2Z7MNbECw4uNvTRBVD5a/dcKaKGT3r1j8RkeQjf5LifMBngch5cujEg1EwU2etd8bZ3eS8fcmZoqS4B3+7r0QIu/q/bOWwvMuNHVBgJMyFF2Rfm8kLxnAy/fXakk9ZHA8no56E07+XN/vWXOT+amBsK5HJCqhok1zQVNkn5Hoi3OeerqHOr4O7isJqh+S58hZfGaWr/MigaHhRZQ4ufHrZuaBUcUe9lOtWjL0MItgEeC09SlAR7dBP/sPvPdWRYKZoL8Q2dQpelBzECG3/2j85ahssGfu90/ys4TlA/Z8cUlmmOxl7VDL6nleVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7IMOMsBV5f+hTIQrIfjRUesPi7O0e1qcJyOges2I7E=;
 b=BsnOPhBo6vbkyZNyPLQ2YEzDJZSQF4oS4bLrHZj2ZEg0q0FE6vCWQKXoWZ0rS9RiGzgDqSGBRmDWh4FVqSHamgVGQe/bnu6gu8gAJN5kzJjsz/V6W8c9J8bw7T48wsN4UDA5MApqIv9ObNp0ejuZ42sPIplJ5kFsKTBAORrRk3qCuJDCpIVZMqul8hNie16w0dlE1hOWQ1j04G6hckLunRTVHwDQcvQ4R0OcirrsVwOL9YFCqCuk2Kd/fi8ZHrK4yPZNj5jek7M3sTSqHPPhO/mWxK9SC/7x9y426ICt71UTMEsEATax4vIvSIhdyOgrFdYeXOyhpoIeYz56eRqEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 02:33:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 02:33:32 +0000
Date: Tue, 7 Jul 2026 19:33:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] Documentation/cxl: Add region granularity and
 multi-level interleave guide
Message-ID: <ak229YhIwF6Uq8SM@aschofie-mobl2.lan>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <37c667b95699aaeb0e58104ece07d17720f55a18.1781199122.git.alison.schofield@intel.com>
 <akIzV6JJUTWJx7Jw@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akIzV6JJUTWJx7Jw@rric.localdomain>
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6f2a87-dfba-4891-1c28-08dedc994dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|3023799007|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: tdgp2cz4yRrWrVkQ4YeSuwt8uDfekPoG+Svnv21l+x0yo7jB2m4Xf2J/19Y6snJrOakvE9joeR/sKmPho9zloOdKlbo39GTgr/Xye8Yoq1WriOFGdBt57Ji6/vLg2pRnJVmzzHSODc1/0N8uUZ5LWy5Hl+QnNMwWI1mN5jTn6YZFjdZQ9p6aoyljyYUWcBiRLWwa8f6Ikx9oCEtLNs5TFKWdpPZdkqdAwubhgghNY5FJ38IAMbzERReQV16tQh6IrxWwXJ256wtCsYVkviLtU2PKMLt2BsbOHba/8UZo/uN4M1zK2QOzqV++iagWhtSFcb+mx/HBUbrus17378NfMbBYvSb3NUL0Ylt6CHx/5VJiVKFbHJUONv12nCJ7YEyXKFOv05r3QgLiGYoZ4XLGJyczZZ+b1w6LCidmzCO9RL1fU6nbGvmMtMLw3Jtb3Ujqtnrzo63C5WEn03PtbZ5QrN6S7ya0fcjCKIFU6ThQ5jQrLi8ulaEx6uuwKyERRL+yiW3Q6Zydi5RHCfAJGuos1BNft7sFMus7C9moUuIkYPaLA8tq6/YK8mqMfoJIKN3Lhyj49S4igtXr/1odtX4FWxyZ3FqIPWuOubenzwsSi7w23/7HLYKBUsonlkNzgNDZcvZNg4PdvmRYTVh4N/9G7V100e0Go9aeKMIC3gNL11Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?El9OetSy9LMPWxAIq1OA7xp66yEYWOmGtetfNE8PTNoaDtOV82wzCRbHRgzM?=
 =?us-ascii?Q?TuxMckJfk01oGLPT9sMWJ7Wz2nCUHCywWyzcw1wtHdnplS+Bd6fi2RkzYc99?=
 =?us-ascii?Q?YKfUkxjUcGgYZyUKJsxs5OsCT0FBr0pHI4rH2lTuBScipkQQou/dlt3/tmqQ?=
 =?us-ascii?Q?z1PGVaU6uIdtVP7e8BcJhVMaerIwAzSFp2v2tD/XDkZ6yClvo9LX4lUyOX8Q?=
 =?us-ascii?Q?uUZuhfp6XkR0DNeMdVzwKru50rxRLZd2nmbKNuwSnJPFrKsz/kMtyGGct1Y3?=
 =?us-ascii?Q?xH0BSgy28vmnZEx6qVhqRNmu7X1EIn0i7mYC8f0BDrgyn2kKwUBtCDPqEcur?=
 =?us-ascii?Q?baCKIeKO6pu7tzshD+S5CXgoJkd5A61pP3Z3+LaesL09RxeS1LISFL7wpTHr?=
 =?us-ascii?Q?s11fdabE3BK/gFa6cB5nlQtodFvRc90U4UFrr3lGVpSIRQJ1xIU1+Hb39Fj1?=
 =?us-ascii?Q?Cfpc3+SPtxZdGFdXprNb9BE2vEOmu9HYEGKJ72+tDTb+DUcP/dDupjBbZ9i5?=
 =?us-ascii?Q?uWbOy//wk8A+1c523c9L613bhE5YsYVdr5HhaQIH6dMu2pcjfSR3FdvHLc2P?=
 =?us-ascii?Q?fiClTsw1Hm37gl2v+bGkWC3yEtGJb7Syg7tn1I0ibp9JHmb6GwXWfRGTgACq?=
 =?us-ascii?Q?KR8O43QK12Em9Z/2F+cOHzviTZqlOYiUGDspjza84JpQTKNrmoLX0dgO06HX?=
 =?us-ascii?Q?S4R64gwj/2sY3qi+68ghsGD97mOO6Aa4Xan2TSfgvyMGlJhY7VCADQO63hZn?=
 =?us-ascii?Q?aXKJhSYM7PHoFSgF7l5dp1SFu3VkSK5tY/9c8MCvy8y4zigy0okjBDvJfnJ5?=
 =?us-ascii?Q?LhgYS4YBxC0vATUpvUrwtQtUcL98PHvIGgI8tuGvfCAgoCO9IftJYt4JcquR?=
 =?us-ascii?Q?XMQ96CZCtHtpc/UF0lZg3fGy/MsJgQ1MdIbCHNB3DaSZGVcmo2Bwi7BtXexb?=
 =?us-ascii?Q?e7IThc75eM4ZbJErm6654TtMcLk2mkIyfreSnv/ZoDNxVe40JyMfCzlQRDiX?=
 =?us-ascii?Q?kh4eP4Ma4UnLBezbjnsRTV1rIsntq+GHAyycfDFdPUa5o7HYUI9SX1H4+hJK?=
 =?us-ascii?Q?g1xId/9qm7C7jrE9joMdIlaz8gxRba4jbr/xCxSbvWNUjdvK737aW3tldhC6?=
 =?us-ascii?Q?utNopsQYYL7xAYgGXqSdBKm90UTtnkxlDkIWsUUFmX4cSo1qvZUKS6LZyAOE?=
 =?us-ascii?Q?BkPXO/OgbSqlHCo6GyAZh8uqOhF38jnrLPJDF84idLnTDxniGRcxFs973j3R?=
 =?us-ascii?Q?U6qSYIzXFOCrnlJzvj6xopR57rl2KpAB3G4suh0QFMfMa5Zo1ADBHYaDdmdS?=
 =?us-ascii?Q?tE/TIoykJc+zIVXt9xgDBkYBa6lN22iR1QYxnEr7aMVMH+8ExU5VO9YaME6V?=
 =?us-ascii?Q?eMlUG0Mjm9SqJ6oOulRwA/UhIml/fqbnGsiLckwhE+5VJEMnAUM4CjJeItvA?=
 =?us-ascii?Q?xJZRUUxyaqvCDu4NPCw/oe6jA7CuJryG5l3UWlHsJSUAkN6Qgr+nQHH4WURw?=
 =?us-ascii?Q?i4hEFWNmx1TaCYYFKffLtrqkhrLctpBMxDUIHEoybsK9D7Jmd63mSBHvsyY8?=
 =?us-ascii?Q?VK+q9qQ3KfrNHo8aGOkILzlFGwcyNEQuJ0JYutNAE38TAwLdC1BrM4DJ/VZW?=
 =?us-ascii?Q?gkox/4y8ribz7YEhip8vwqENZ0kH9Ax8zxuRcgowz78eIQbD20cNGudzDD9k?=
 =?us-ascii?Q?vp4ZOctEEG/ySL9VvCztHbqDTHVsjbA4OoxiJmt2CJONrds0dGoKB7f50thJ?=
 =?us-ascii?Q?KZkYe1z/uEnsRKOe+BMbthwgKLqRryE=3D?=
X-Exchange-RoutingPolicyChecked: ll7VbqwVDqffI8mWglzP438Kab0M+C/HP0c9KU2NUrygI7ZFbHbIcg2UgIvL7vYNB9YQuhjRfzrM8E+B/Z+l4LhF5vyy+msvUqEtP9BQVabpWGTvj0IzOG+0HMJODtNwvEfsZJ2zV1PnveM8E9GN0MzuLYxzhkZkHc3n0K8/a4aeAg5oJ164/1W2fqT1mYggHv6NSZfyfdZozzoeHlbnDuyiSeGHWTAaS/eb88oRylM2+suAcoXVJqEHc3P6xzcCxx4AxIF6U/szpN7njjew0St/ccCRgW7GJBj3rd6w96F+3mdrEm+mYUaFqyJ9WpN5krKi/HbrbFFKec1QBsh1qA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6f2a87-dfba-4891-1c28-08dedc994dc8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 02:33:32.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNrxkMxKV5wng14PxDigloxAEBViuTgsZL/SVEJYuVV3p40H6MA3eLJrlHvUXxbwp4qY1YUMFOvdsfKVAfagvgRDv0dksvz+gKuBoJMFRW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com

On Mon, Jun 29, 2026 at 10:56:55AM +0200, Robert Richter wrote:
> On 11.06.26 10:47:30, Alison Schofield wrote:
> > Document how region and root decoder granularities interact for
> > same-granularity, power-of-2 mixed-granularity, and 3-way-family
> > interleaves.
> > 
> > Explain the selector-bit model used by the CXL specification, the
> > legal layouts that result from it, the additional span constraint
> > required by 3-way-family roots, and how the Linux driver validates
> > those rules for both auto and user-created regions.
> > 
> > Assisted-by: Claude:Opus-4.7
> 
> We should drop most of the documentation as this just rewords the
> specification. We should have a single point of source which should be
> the spec. We should cite and refer to the spec to explain details.

Hi Robert, 

The factual corrections below are all fixed for v3, thanks, the
spec-4.0 wording, the undefined terms, and the root ambiguity in
particular needed it.

On reducing the documentation overall: I'm going to review it for
content before deciding structure. Some of it restates the spec
and can likely go; some of it is driver behavior the spec doesn't
cover, what the driver validates, what it rejects, the auto/user
difference as a region-creator sees it, and that needs a home. I
need to do another sort and rethinking before promising what stays
vs goes.

More inline below....

-- Alison


> 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  Documentation/driver-api/cxl/index.rst        |   1 +
> >  .../cxl/linux/region-granularity.rst          | 486 ++++++++++++++++++
> >  2 files changed, 487 insertions(+)
> >  create mode 100644 Documentation/driver-api/cxl/linux/region-granularity.rst
> > 
> > diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> > index 3dfae1d310ca..1ae193ea4020 100644
> > --- a/Documentation/driver-api/cxl/index.rst
> > +++ b/Documentation/driver-api/cxl/index.rst
> > @@ -42,6 +42,7 @@ that have impacts on each other.  The docs here break up configurations steps.
> >     linux/dax-driver
> >     linux/memory-hotplug
> >     linux/access-coordinates
> > +   linux/region-granularity
> >  
> >  .. toctree::
> >     :maxdepth: 2
> > diff --git a/Documentation/driver-api/cxl/linux/region-granularity.rst b/Documentation/driver-api/cxl/linux/region-granularity.rst
> > new file mode 100644
> > index 000000000000..7d0d12e6e2bd
> > --- /dev/null
> > +++ b/Documentation/driver-api/cxl/linux/region-granularity.rst
> > @@ -0,0 +1,486 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +==============================================
> > +Region Granularity and Multi-Level Interleave
> > +==============================================
> > +
> > +CXL memory regions stripe accesses across one or more endpoints by
> > +routing transactions through a tree of decoders: a root decoder, zero
> > +or more switch decoders, and an endpoint decoder at each leaf. Each
> > +decoder in that path uses a contiguous range of HPA address bits to
> > +pick its target. This document describes how those bit ranges combine
> > +across levels, the constraints CXL Spec 4.0 places on legal
> > +combinations, and how the Linux CXL driver validates and programs
> > +them.
> 
> This suggest that cxl spec 4.0 introduces that constraints, but it
> doesn't. In fact, 9.13.1.1 just documents the combinations of
> interleaving levels possible with 12-way, 6-way, and 3-way configs
> which results from factorization of the ways.
> 

Right, the wording overstated it. Fixed to make clear the
constraints follow from the selector geometry and 9.13.1.1
enumerates the resulting legal combinations.


> > +
> > +The relevant spec material is CXL Spec 4.0 Section 9.13.1, especially
> > +Section 9.13.1.1 ("Legal Interleaving Configurations") and CXL Spec
> > +4.0 Tables 9-6, 9-7, and 9-8. CXL Spec 4.0 Figure 9-17 (two-level)
> > +and Figure 9-18 (three-level) illustrate the bit-routing intuition
> > +this document builds on.
> > +
> > +
> > +HPA Selector Bits
> > +=================
> > +
> > +For a single interleave level with ``W`` ways and granularity ``G``
> > +bytes, the **selector bits** are the ``log2(W)`` HPA bits the decoder
> > +inspects to choose among its ``W`` targets. The lowest of those bits
> > +sits at position ``log2(G)``, so the selector spans
> > +``[log2(G) + log2(W) - 1 : log2(G)]``. Equivalently, the bitmask is
> > +``(W - 1) * G``.
> > +
> > +A few examples make the geometry concrete::
> > +
> > +   2-way at  256B  ->  selector bit 8         (one bit)
> > +   4-way at  1KB   ->  selector bits[11:10]   (two bits)
> > +   2-way at  4KB   ->  selector bit 12        (one bit)
> > +   8-way at  1KB   ->  selector bits[12:10]   (three bits)
> > +
> > +Throughout this document "inner bit" means a lower-numbered HPA bit
> > +(smaller stride, faster cycling among targets) and "outer bit" means
> > +a higher-numbered HPA bit (larger stride, slower cycling). HPA[8] is
> > +the innermost legal CXL selector bit; HPA[14] is the outermost.
> > +
> > +
> > +The Multi-Level Rule
> > +====================
> > +
> > +When a region's interleave is split across multiple decoder levels,
> > +CXL Spec 4.0 Section 9.13.1 requires that:
> > +
> > +   "all the levels use different, but consecutive, HPA bits to
> > +   select the target and no Interleave Set has more than eight
> > +   devices."
> > +
> > +Two requirements live in that sentence:
> > +
> > +* **Disjoint** - each level's selector bits must not overlap any
> > +  other level's bits.
> > +* **Consecutive** - the union of all level selectors must be a single
> > +  contiguous run of HPA bits with no gap.
> > +
> > +The union of level selectors is the **region selector**, and it must
> > +equal ``(region_ways - 1) * region_gran``. Because that mask is itself
> > +a contiguous run by construction, the levels just need to partition
> > +it cleanly.
> 
> The region also includes cross-hostbridge interleaving (described in
> CFMWS). The region ways could include a factor of 3. For the selector
> only the 2 factor parts are taken and the factor of 3 removed before.
> The region selector then includes the cross-hostbridge selectors too.
> 
> Below, you refer to root decoder and Cross-HB interleaving. Same as
> "region", the definition of it must be described in detail as the term
> "root" is ambiguous (cxl root, root decoder, root port, root complex,
> etc.).

Agreed on both. The surviving text defines its terms up front
("root decoder" = the CFMWS-described cross-host-bridge
interleave) and uses them consistently.

> 
> It could be added that the endpoints are finally programmed with the
> region's interleaving config (ways and granularity).
>

Good point, added.


> > +
> > +The seven legal interleave granularity values split into two groups
> > +(see CXL Spec 4.0 Section 9.13.1 and Table 8-116):
> > +
> > +* **Group 1** - 256B, 512B, 1024B, 2048B (interleaving on HPA[8..11])
> > +* **Group 2** - 4096B, 8192B, 16384B (interleaving on HPA[12..14])
> > +
> > +CXL host bridges and switches must support every value in both
> > +groups. CXL memory devices must support at least one group, advertised
> > +through their HDM Decoder Capability register.
> > +
> > +
> > +Same-Granularity Interleave
> > +===========================
> > +
> > +The simplest case is ``region_gran == root_gran``. Each level's
> > +granularity equals the next inner level's IG times that level's
> > +ways. The region selector bits stack inside-out from the root.
> > +
> > +Example: 4-way region on a 2-way root, 256B everywhere::
> > +
> > +   Level    Ways   Granularity   Selector bits
> > +   ------   ----   -----------   -------------
> > +   Root     2      256B          bit 8
> > +   Switch   2      512B          bit 9
> > +   Region   4      256B          bits[9:8]
> > +
> > +Each level's IG sits one bit position above the next inner level's
> > +selector. The region's effective selector spans ``[9:8]``, two bits,
> > +matching ``(4 - 1) * 256``.
> > +
> > +
> > +Mixed-Granularity Interleave (Power-of-2)
> > +=========================================
> > +
> > +A region's granularity may be **less than** the root decoder's
> > +granularity. In that case the root claims an outer selector bit and
> > +the switches beneath it claim inner bits. The arrangement is legal
> > +whenever both granularities are powers of 2 and the resulting bits
> > +remain disjoint and consecutive.
> > +
> > +Two-Level Example (CXL Spec 4.0 Figure 9-17)
> > +--------------------------------------------
> > +
> > +8-way region, 2-way root at 4KB, 4-way switch at 1KB::
> > +
> > +   Level    Ways   Granularity   Selector bits
> > +   ------   ----   -----------   -------------
> > +   Root     2      4KB           bit 12
> > +   Switch   4      1KB           bits[11:10]
> > +   Region   8      1KB           bits[12:10]
> > +
> > +The host bridge bisects the address range at 4KB granularity, sending
> > +one half to each root port. Beneath each root port a 4-way switch
> > +splits its half into four 1KB chunks. To each endpoint the region
> > +appears as an 8-way interleave at 1KB based on bits[12:10]; the
> > +leftmost endpoint receives 1KB chunks at HPA bases 0, 8KB, 16KB, ...
> > +
> > +Three-Level Example (CXL Spec 4.0 Figure 9-18)
> > +----------------------------------------------
> > +
> > +8-way region across cross-HB / HB / switch, all 2-way::
> > +
> > +   Level         Ways   Granularity   Selector bits
> > +   -----------   ----   -----------   -------------
> > +   Cross-HB      2      4KB           bit 12
> > +   Host bridge   2      2KB           bit 11
> > +   Switch        2      1KB           bit 10
> > +   Region        8      1KB           bits[12:10]
> > +
> > +Three levels of 2-way interleave each contribute one bit. Total
> > +endpoints: ``2 * 2 * 2 = 8``. Selector union:
> > +``bit 12 | bit 11 | bit 10`` = ``bits[12:10]``. Disjoint and
> > +consecutive.
> > +
> > +General Power-of-2 Rules
> > +------------------------
> > +
> > +For power-of-2 ways at every level:
> > +
> > +* ``region_gran <= root_gran`` is allowed; ``region_gran > root_gran``
> > +  is not (the root's selector would land inside one region stride).
> 
> It is unclear what 'root_gran' refers to. I think you mean the root
> decoder's (cross-HB) gran here (from CFMWS).
> 

Yes, and with terms defined per above this becomes unambiguous.


> Since region gran is the result of the union of all levels, it is
> always the smalles gran within all levels.


Agreed, and that's a cleaner way to state it than the inequality
form; done.

> 
> > +* Both granularities must be powers of 2.
> > +* The ratio ``root_gran / region_gran`` is the number of inner
> > +  position slots packed beneath one root target. Endpoint position is
> > +  partitioned by root target rather than interleaved across them.
> 
> This does not give any hint of the bits used for the selector. Each
> level has an individual set of ways and granularities. There are no
> dependencies. The ratio cannot be used for position and selector
> calculation.

I want to push back on the last sentence, because the ratio is doing more
than the text conveyed. root_gran / region_gran is exactly
2^(root's lowest selector bit - region's lowest selector bit), the place
value of the root's selector bits in position space. That is precisely what
position calculation needs from the root level, and it is what 3/6 uses.
See my reply on 3/6. The doc text failed to make the ratio's connection to
the selector bits explicit. I intend to fix that either here or if I
move this to in code comments.

> 
> > +* Mixed-granularity is always optional for power-of-2 topologies. A
> > +  same-granularity arrangement always exists for the same set of
> > +  endpoints. Firmware may prefer mixed-granularity to expose a finer
> > +  switch-level interleave to the CPU.
> 
> Why distinguish between Mixed- and same-granularity? Same-granularity
> is only a subset.
> 


Fair. v3 presents one model with same-granularity as the special case
where every level's granularity equals the region's, rather than two
categories.


> > +
> > +
> > +3-Way Family Interleave
> > +=======================
> 
> Same here, this 3-way part is already documented in the spec, I don't
> see much sense to rewrite it here.
> 
> The whole point on 3-way familiy configs is how the HPA translates to
> the endpoint DPA and how the endpoint is selected:
> 
> HPA: <upper_hpa_part><selector_bits><granularity_bits>
> 
> base address: <upper_hpa_part><zero_bits>
> 
> In 3-way family configs the base addr (upper_hpa_part) is divided by 3
> to determine the DPA, the remaining lower bits form the selector up to
> the gran size. Think of prime factorization of the base address, it
> will contain at least one factor of 3 and (sel + gran bits) nums of a
> factor of 2. The selector bits also form the endpoint positions below
> each host bridge.
> 

The spec restatememt goes. The driver relevant consequence stays.
Will look at moving to in code comments.


> > +Linux Driver Implementation
> > +===========================
> 
> See my comments on the patches, a rework will simplify this doc too.
> 
> Imo, just add comments to the code where needed.
> 

Mostly agreed. See the 3/6 reply for what the rework does and doesn't
change. The stride section is gone (renamed and documented in code as
the root's place value), and the enforcement-point walkthroughs become
comments at the functions themselves.


> > +
> > +Region geometry validation lives in ``drivers/cxl/core/region.c``.
> > +The helpers and enforcement points below implement the rules
> > +described in the preceding sections.
> > +
> > +``get_selector(ways, gran)``
> > +  Each interleave level consumes a contiguous range of HPA bits to
> > +  pick its target. ``get_selector()`` models that range as a bitmask:
> > +  ``(ways - 1) * gran`` for power-of-2 interleaves. A strict 3-way
> > +  interleave consumes no HPA bits and the helper returns zero;
> > +  6-way and 12-way are folded to expose only their power-of-2
> > +  component.
> > +
> > +  Kernel-doc: :c:func:`get_selector`.
> > +
> > +``root_pos_stride(cxlr)``
> 
> I rather would like to not introduce the term "stride" here. This only
> adds confusion. E.g. the root decoder selector could be used instead.


Probably will drop as a documented term with the code comment describing
it as the root's position place value derived from root and region
granularity.


> 
> > +  When ``region_gran < root_gran``, each root target owns more than
> > +  one region position. The number of positions packed under one root
> > +  target is ``root_gran / region_gran``: the root advances by
> > +  ``root_gran`` bytes per target, while region positions advance by
> > +  ``region_gran`` bytes. Same-granularity regions have a stride of
> > +  one because the root advances on every region position.
> > +
> > +  ``root_pos_stride()`` returns this ratio for the position walk and
> > +  the peer-distance computation. The same value applies to 3-way
> > +  family roots: in value space they advance by ``root_gran`` per
> > +  target whether or not they consume HPA selector bits.
> > +
> > +  Kernel-doc: :c:func:`root_pos_stride`.
> > +
> > +``is_ig_allowed(cxlrd, ig)``
> > +  The region granularity must not exceed the root granularity.
> > +  ``region_gran > root_gran`` would place the root selector inside a
> > +  single region stride, leaving the root no address bits to choose
> > +  among its targets. ``region_gran <= root_gran`` is required for
> > +  every legal layout.
> > +
> > +  ``is_ig_allowed()`` enforces that geometric rule. It returns true
> > +  when the root is not interleaving, or when ``ig`` does not exceed
> > +  the root granularity. Endpoint capability (the IG groups a memdev
> > +  advertises) is checked separately at attach time via
> > +  ``check_interleave_cap()``.
> > +
> > +  Kernel-doc: :c:func:`is_ig_allowed`.
> > +
> > +``cxl_port_setup_targets()``
> > +  This is the per-port enforcement point for the multi-level rule.
> > +  For each level between the current port and the root the function:
> > +
> > +  * Rejects overlap. Two levels that share a selector bit fail the
> > +    disjoint requirement.
> > +  * Rejects escapes. The accumulated selector must fit within the
> > +    region selector. A level whose claimed bits land outside the
> > +    region selector fails the containment requirement.
> > +  * Derives the granularity to program at the current port for
> > +    user-created regions. Each interleaving level claims the lowest
> > +    selector bit still available within the region selector;
> > +    passthrough levels consume no selector bit and inherit a scaled
> > +    granularity from their ancestors.
> 
> Fine with me, but all this is simple bit mask logic. Just comment the
> code and use helper functions?


Yes, with 1/6 factored into helpers per your review, each check
gets a short comment at the helper and this section disappears.


> 
> > +
> > +  Auto regions reuse the same selector checks but trust the
> > +  granularity firmware already programmed at each level.
> 
> Never trust firmware. :-)
> 

:-) Poor wording on my part. The AUTO path doesn't trust, it
verifies: firmware-programmed values are run through the same
selector walk, containment, and span checks as user values; the
only difference is where the values come from. The replacement
text says "validated, not trusted."


> > +
> > +``cxl_region_attach()``
> > +  Pre-flight gates that run once per region attach, before the
> > +  per-port selector walk.
> > +
> > +  * Auto regions bypass the sysfs granularity gate, so
> > +    ``is_ig_allowed()`` is applied here to give them the same
> > +    geometric check as user-created regions.
> > +  * 3-way-family roots require an explicit span check. A strict
> > +    3-way root consumes no HPA selector bits, so selector containment
> > +    cannot prove that the root and region cover the same address
> > +    span. The span identity
> > +    ``region_ways * region_gran == root_ways * root_gran`` restores
> > +    that constraint. Power-of-2 roots get the equivalent constraint
> > +    from selector containment and are not affected by this check.
> > +    See `Span Identity for 3-Way-Family Roots`_ for the full
> > +    derivation.
> 
> Same here, add it as comments to the code.


Got it.


> 
> > +
> > +Position calculations use ``root_pos_stride()`` so that both
> > +same-granularity and mixed-granularity regions produce the correct
> > +endpoint ordering. The position walk itself lives in
> > +``cxl_calc_interleave_pos()``.
> > +
> > +Kernel-doc: :c:func:`cxl_calc_interleave_pos`.
> > +
> > +
> > +Auto vs User-Created Regions
> > +============================
> > +
> > +**Auto regions** are reconstructed at boot from the decoder values
> > +firmware programmed. The driver reads each decoder's ``ways`` and
> > +``granularity``, runs them through the selector walk, and accepts
> > +the configuration if it passes the disjoint and containment checks
> > +(plus the span identity for 3-way roots). Firmware is the source of
> > +truth for the granularity at each level.
> > +
> > +**User-created regions** specify ``interleave_ways`` and
> > +``interleave_granularity`` through sysfs; the driver derives each
> > +intermediate decoder's granularity. The sysfs path runs
> > +``is_ig_allowed()`` at granularity-write time, ``set_interleave_ways()``
> > +at ways-write time, and the full selector walk when the region is
> > +attached and committed.
> > +
> > +Both paths converge on the same geometry validation rules.
> > +Differences between the paths are limited to how region parameters
> > +are obtained and when they are validated.
> > +
> > +* Whether each intermediate decoder's granularity is read from
> > +  hardware (auto) or derived (user).
> > +* Whether the membership of the region is established by walking
> > +  firmware-programmed decoders (auto) or by user writes to ``targetN``
> > +  attributes (user).
> 
> This could be condensed to:
> 
> auto: config is read from decoder registers
> user: sysfs is used to setup decoder registers

Got it.

-- Alison

> 
> -Robert
> 
> > -- 
> > 2.37.3
> > 
