Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7091DC64ED8
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 08:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjBXIEZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 03:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBXIEY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 03:04:24 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECCA27D71
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 00:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677225863; x=1708761863;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VH8NGaiRdll2nuYQvndzDjWAPeiqzoYmSMo1FWJvouQ=;
  b=iJF6pv2yv4gTU3ZYPUtQ/OIXLTkJd1ZKUdff9RZ+I9duOyoOxfhKQQBy
   rT99uLaOVVnAocxy+o2XXgklxWgIgpe6g8EQboUbZzGX/0ZHDmDs5X5J2
   nu5u/oRjJ0kqRV7ueb+SPhizf9xqNhxri59+0IaP6fBUNiHXBSFm6zXqI
   +E6RlzlOG9UHdsfMaSz8z0y7eK8Te2/klfZZVjM3HGBe24tlOb8qNAQ3L
   oj2cWaw+bujGKcN8YwxUKyttjkvngznf3QiGl7uT6dhUdQafJHq32zzV3
   miwNNH5D2bzFrNYRlyxqL+TX3ibq4dD9x/ccb8BzsFywRbK91cIzQGEOK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="333425944"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="333425944"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 00:04:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="666085894"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="666085894"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2023 00:04:22 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 00:04:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 24 Feb 2023 00:04:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 24 Feb 2023 00:04:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tyzo509BrPyzwkNH5HVLmLGoMCgZcp+XeuXKtYH0FQsl0v/dlbLWy4+xYP7f3/EVDLEtsvUdvxSPMhmZAHiPjIDX9NwQthDRBvYWfC8wAnlACvvwFTqRZFfrOFkuXu/321kyma4xSSy+LGhiC5dRdKoEFDRrieGYdLXCOjmOO7P2rxol/c02ezxbcFpj4ZTbvEXGbpiikdLqH/uvn7adJCgEG6KLz52GMsexHjStOagch0oatiy2h9EDjwEtsmvEFeu7sNRpTw8779QA0m7ibc5NGHRUzXxxjb79kdNf9EAn30GdNh1q7ReLzIhI2Pr+aRypPDBjSN7a19L8Zrw4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l45XMq72YUg3qP6KgfD571oz4AzZGkfxbBB69jUvq3M=;
 b=SM+6x07cVqR7ZKncVA0rwRvkt+2zP/MbM8Q8PueAuyPGrXpKe6HZyQNcx2M+woywypa/aNuH0LrAUw8RziYlfgetSuMaqkWqqzOHZ2XnFH1zXAKQQanYX3Sj6WZYcT6EExv1NiaSPi6BxMsNKfmm88t4/fgOGipmLwkpeokWN1beInBKRp+cIEdtpRTrS4rs4R0mz5bYmu82p5LYvFIdWBBzigDavpZ6SNV18UA71qharODq9cWPihBb85AVohJim1dSQrnWv3UyRNw0MDFKxJmfw9ZI6AN3zCdlXFUImhD0d9FdZyMyUvP2GpF0tYcDDI++2sfbPI/GM0bqcd8LCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7952.namprd11.prod.outlook.com (2603:10b6:8:eb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Fri, 24 Feb 2023 08:04:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%8]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 08:04:20 +0000
Date:   Fri, 24 Feb 2023 00:04:17 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH] cxl/monitor: Make libtracefs dependency optional
Message-ID: <63f86f813345b_20c82e2941f@iweiny-mobl.notmuch>
References: <167718414197.16926.10394415062829848410.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167718414197.16926.10394415062829848410.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f53982b-1f3f-47e1-4881-08db163dbb76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5AS9Gu3WrQ3dk4ip252ZpQcs76SuFJaR1/6YdknPVN11bVSEMeLzOUL4GWWGiKbvNhVWsXJ/WlR6ByE7mdh+EqS7rnUMCI7i9E9t3HMYaXLCP7VoBsUQfeg/dZnDDS255HNq3Hr39llryeBvt1NvzfNQD4S0XUvRPztoIzbCnCVMOInaCz5TTs5TkyuyPyrEP3JRtnRTDEJbxcB13udxO0Jrnh2hf/k0ZfPzLIAFr+aTeMx92jhgqekbL74ZHlxr2AByle6wC8sjd+K0aDTIrYNy+eT72y5MWTqoKQqhP3x6BAw8Da40iPjIcCdW9dtO/UiCeUhB109zCJ7x6DWSXFt0zfXK9jdSoj46pYXn09HYCJSXd+35sOxRO36Sxh2vkhyLBMPqlYg98V9kVEgLaGUZgT92Ro2R0jM1NfjHjeMYvP1HA+KLMHDng16G3IQ3voHYwTjhCqB3NAbAqGgOAljWtJTMSUJv3MF0mOuh3QlZVpkHutNpIzvio4OkBF9Ppb9Bpt+xH3K23a5kUdzbZGjzhcDEIcKaJREY0vfmZqogg83rwNvPWxMS5AzuRrauYRtuN+WQlhcR04oDRWKg7qOsWn/OFwSlTGlNPHeAsK0ntWFK82V1CRp605CJhM7GzkYek0wXqxQ3hzsWAIxSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(316002)(41300700001)(26005)(5660300002)(86362001)(6486002)(44832011)(4744005)(4326008)(8936002)(478600001)(66476007)(8676002)(66946007)(66556008)(2906002)(82960400001)(38100700002)(6512007)(107886003)(6506007)(6666004)(9686003)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rWc2Wi3q0wuDUlkC8kvvZeGZIxvF5bQWgxwBbJzPiVnAWOB6k5xBSi3xkS8C?=
 =?us-ascii?Q?vfbIzRhQv1Wn5nS2+cCuTaB830ZXC++nqXXmGpThjneXGGi6uY9nwM/mDZAx?=
 =?us-ascii?Q?aq1x0ECUVFx3bQsUM0M7QtQNs79FlW7nmSngj1eqX3IwbTNhcXcJFOu9w54I?=
 =?us-ascii?Q?v7Z4e19YQZLatcvOobKjAp+ScQdn81/dXdnuwvd7VMLnxi6NmDCMZ5Zjww25?=
 =?us-ascii?Q?moc1CPCd3FNAu5WFxn9u9BDS5XFUKBWSe5cie58keVxLPF0DJKO/N8PxfmMZ?=
 =?us-ascii?Q?26w8Gn96V9y4aWxZ3gmMU/OAjcGQqtbrihgR0EAVGIOzeqB9+bxn0fFxRyiB?=
 =?us-ascii?Q?qFGGRGR3psnvn2FT2A4t0kJAGB9EYzYFdzVYS5VN85ojJMv8BvuPp+6egfap?=
 =?us-ascii?Q?0prAFm9S4VT5/GTgiu5xhgRDRWWm0ns0wz/18yAkR6RVrfuVxYHkifTlDgL7?=
 =?us-ascii?Q?hVf39gV22CnEjC8PHB4/ErwUUjH6dv27o3plo9r/TG6qiNdllDzCIfh9gTJk?=
 =?us-ascii?Q?C9eyGGWzzgyQnCl8ULI9v3d0G8YxL3pw6IVB4Vruyly92FBIeczTUHiqE9Tv?=
 =?us-ascii?Q?Epi1g+gDTD+7dclw+C5ZW7NYEEfOXZ2bnEAOUqj4LfZhV+d3mKVq1vCOrGP8?=
 =?us-ascii?Q?gZfDxXQljrt2qzK2lRvXnUoEA1Y6eIS9xQGD/pGoZ/o2QVFeIVcMlVLda2u2?=
 =?us-ascii?Q?LRKvZihWhtQlqh+nlIcogBPA6Jsk70Mgg4ThEl7ixxNLSX5fNbyAa9zSHD07?=
 =?us-ascii?Q?VYfwZJwlkrbagKJ1a2merBupsvGQehHf+gr0tuPy9U4HOGoa5pxWeuiCfU/r?=
 =?us-ascii?Q?GEB+F3LjZ9L0HAolhO96pTvRSigeRn76ObmWq4IHvGXQXC+CejbFOuFO3Ja/?=
 =?us-ascii?Q?wurcafC/Em3X53oLv99e80XMKo8ilRJ3U7B5FkNiq+qlkbjNByDJIVvBClAv?=
 =?us-ascii?Q?5P5HXgzdUIcgBWd//gTyaT+4AbMziGGkVfzaGbN39v2p3Fv95glRqAIrsrni?=
 =?us-ascii?Q?HJph6zXnkLWSYNka6YZziLQYMATgLf1J/YiJPLlKDjsPunZ3I3oeA3GxAdOS?=
 =?us-ascii?Q?UjFvqZ/MoHzjNOgnSrjc5wtkdWb3DN6vtX88Mc8yrSYml6WpNoStDml3ONuE?=
 =?us-ascii?Q?4NflmnrukEKIczz+t1Mqqq8UVJoPBTqmrdIbjt/bagUg6FRgvhfyIbKKCwcW?=
 =?us-ascii?Q?J9gI3stDysFt9XPzl/l8N2kBKgfplI8e+udfAwO4wYcf9iGy+6RoCZzIljAm?=
 =?us-ascii?Q?sLIoIgr6xihRdl+YmuHU1yCO7XKgF1y7hGvmMH1KPKBD3M43VvmRmnGgvULR?=
 =?us-ascii?Q?JJPD909tmRYa6E1bZeUYTYChsaD5U4m/jXjdarnTmtSpLabF9p30CBF8qKvV?=
 =?us-ascii?Q?VFzj5MD/PPT+F8PkbZZ1O+sDkZFRxwm9SsXyVdoSxVliRxtgCx4tljKeZEL1?=
 =?us-ascii?Q?w/nqhW0YrDF4TEYEX33tAwocttSbm8WkaYgWDZtnjjf0w5q93SBPs3/Lmq3A?=
 =?us-ascii?Q?lL+YZu6ar3SfcF+6B8MjO1AJPbscbzlxAhkKQuYDfTdAUJCyRq17iuA0Qe4T?=
 =?us-ascii?Q?/wsOIZSCPaZ70Q9lULUD1B1cBFmn4luHfrKf5Fk+TOurBp4YcwBpdhCE+4Mg?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f53982b-1f3f-47e1-4881-08db163dbb76
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 08:04:19.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53BV2xX1PLFwPyOWLDa7IKQGVMKqsk+t141qJ9ZEtEBCBDtGXH6bNmaZvuTRCrjd6TIbxRcaCVFApW1JDrd8ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7952
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Build a stub version of 'cxl monitor' that reports that the facility was
> statically disabled at configure / build time. Provide the meson
> configuration line to correct the build.
> 
> This is in response to the fact that some distros fail to ship
> libtracefs-devel even though they ship libtracefs (looking at you CentOS
> Stream 8).
> 

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  config.h.meson    |    3 +++
>  cxl/builtin.h     |    9 +++++++++
>  cxl/meson.build   |   33 +++++++++++++++++++++------------
>  meson.build       |    7 +++++--
>  meson_options.txt |    1 +
>  ndctl.spec.in     |    8 +++++---
>  6 files changed, 44 insertions(+), 17 deletions(-)
> 
