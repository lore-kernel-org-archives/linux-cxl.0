Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E8FA41;
	Fri, 15 Aug 2025 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218208; cv=fail; b=ojvzB0C69KQ+CYf+MNSvmXnACTqm7euHe1uXCaqALhT+fuHPCfnfnYOvwjeaUn+XmFqOCu8OwPY1W4ct7KMzl9FEd5MICk+WOGqjirC7t/DujqNcZLwvdHbcbPteDq4BKLKOTWWLB+2xxp2SwoU+RNU8U6uHzm7ZqXH40F3hkco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218208; c=relaxed/simple;
	bh=v2cVGC7xrQe87OQcjgHkJTh7Zdf1RAwHG81TDcQYEBI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AuLvWWGeh//m/voHOiCIYg4vMk/OdBlNnzNvpVJZgsQ+SpHPQKEF82gDJERpKsBjO2OLmOMAe+meMpnf13SKoHLqhqvtOoEaAndE2E478jkRB0hq2RHLjLGTD8tBf0NomkXwwl2bvg5wTvZ3xNPH0/x4WnNSMbE3HjFtD8qwMoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+HCiXFD; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+HCiXFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755218206; x=1786754206;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v2cVGC7xrQe87OQcjgHkJTh7Zdf1RAwHG81TDcQYEBI=;
  b=P+HCiXFD2fQHesIWApM7fECx4qszqrRWeJbKl+hL33YSU447voD9nelj
   d9HvYJ+Km6ELfhLtKXJOlK1+ZhJoYqbiZ1FtMhWTE6an942TSMy1SIy0A
   E9MLfQ6Ta4y1IyRYhXzSElEC+1ialOvQjq+WUzGdT9XmIdqIDhsPtLIxj
   6nrxiU8RgVWfT2g011KpZ37Cn6t5sJpMUvnzqcdjjs/hwyCUDj3Rof0J9
   ekii1j2waR2XWlfryatKykstuzq7GX+XAKgMQU3RhsurkT1rdQt/qGujq
   Br0FZiVy6K7rcRCbB9eSFqDl0dEowBy3d6EybZpza6IZ6lQ6Khstni68m
   Q==;
X-CSE-ConnectionGUID: zn6aUbbzTHmSNtelJdJwpw==
X-CSE-MsgGUID: 0PJn/UcXRm2HI8T2hbvsoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57473038"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57473038"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 17:36:46 -0700
X-CSE-ConnectionGUID: twne30iDRiG/cEKxBu8REw==
X-CSE-MsgGUID: HTQXKh9TQn6JuPsAcSizwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166864473"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 17:36:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 17:36:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 17:36:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 17:36:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJu2c+8EYey/zPJm+G8JbGu7w2BrWMH43H33mfmUgr57k+1yBxSEi4RVznacVDKrzh89VPc7LT5VhE5sOgDLU0O/tykcvXpdHFi0Xo70K2FdVerLvYKVfCp8S8dDLhdHgo+xnm547hlYdanK+m2dv4uvsAUH6OJ9cCZ89Fc/YrWFUzAVlFkh81Apk53dyoYzLBxXeCSOr19Sh/MQKb0Fre9Zs0oD60ceP5SgGqQVWJoNuSedGyepN8NX+gxHJS48uzZJoZloy9jSFkeDR5M1D00Y4BX0BAfF4bbMzvZl8ggsNoiBMljlXQeqBkklQWkETy7+xHccYY/2m69eCSkGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ3vUVW97/wSHbHWt1kIsxIRV4wqxO90ZKYn/lw3nf0=;
 b=B/TL1ATJwQJdPmpLlQiZ+KWMO3V5VKhJTq0ZiQ3Iqy939VytVsniAFM7sdyf91fbPSFsyAaDGDMKI/eHK82c2TpovsY7/nOtppSe3+BwHgrz0gB8PbjXreYQEtgvE4wBVutzKY8UhC9d29KIQ367IlhKzwGpD1pn0WIJiEpppYIAwktgJnrNvErDRte/anRUG2UzLvbr9+2gmcCOA78fcTPkehykXw3maO8RL6pcsHQNThNlasL1DreNH2Kwnte4Xqj2Q1HmFeNdDopVZ9ZWYvFx7ysS1ZrHwqnivKE4aoUdEonHG7MHUV/y7i0XreCfOTNW9KAqL2M19QNz0IFNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 00:36:42 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.018; Fri, 15 Aug 2025
 00:36:42 +0000
Date: Thu, 14 Aug 2025 17:36:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Joe Perches <joe@perches.com>
CC: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
	<dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: allow an assignment in if condition for
 ACQUIRE_ERR()
Message-ID: <aJ6BEuNueCNuOOfQ@aschofie-mobl2.lan>
References: <20250813003821.2891532-1-alison.schofield@intel.com>
 <9afd4c898a194cd576f1aaa08b72c67d4e538cc7.camel@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9afd4c898a194cd576f1aaa08b72c67d4e538cc7.camel@perches.com>
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b086d15-680f-4487-33ab-08dddb93cdf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YFI/YkK023t2RiAvKTXn/yZ0osu3yhjhYMi+Y7tmS979BmbgT5vdnW3tTYJy?=
 =?us-ascii?Q?ZMkgf6A8qbyLR9VntIHo9PdgxKiTlpMVfo38iR5acdy/sZ7SHxriMQRfQ+ML?=
 =?us-ascii?Q?ZIXxq4yjJTbUIB3rtcXCMFMX16nSbnh4/uhe8CPFcPCRn6KSGWLL2GDy1Y2v?=
 =?us-ascii?Q?ARjYXF85PvmMjJ6iKHYWlQhvNE/X8Onx1wIFmsPAjpwdw9E1lX/s+qtdVxZ+?=
 =?us-ascii?Q?aJEbGoJq2iunQLYyVD9Mdc7Z5jdbol46xg70OwlWUhHrJNE7ytLZIV3OeD0d?=
 =?us-ascii?Q?FOFy6ZVju19T95kWfba1jTwnoykvinuwRlgn1SuIGjxySuJTk2M92W85WN4T?=
 =?us-ascii?Q?ETG8Fo1uN0fDXPD2YKHhcIviGB0bAXYwOUyqe2gtpWcQWxPyvompss41a6Vy?=
 =?us-ascii?Q?+TsyY91+oYLu5qLY0fUOFDSL51VhPtlsdzuw2cwVSkmqDgOJMhvuZiNAA1JL?=
 =?us-ascii?Q?C5zsvAe7uCvaBtzavhP0c4au9i9PT5o3WzF7STvP1oHdzUuNMTI8GjByfAjT?=
 =?us-ascii?Q?+Z59RjX8Z2/v9BOXzlPECJE9riIBGjgUyrtn/j/wCJINC4zbnX900RjEqM6x?=
 =?us-ascii?Q?yNulfTYbLPhgUYRfDR27Ifkwa59eQT6/SudcgemDMfLc1wqTPI0q9aBJX1h/?=
 =?us-ascii?Q?7hmGsb+2nMAH38gEKJdbDqHL00kEIjD95mB7fp7kzDB2tM2oH9OFsseYSDs5?=
 =?us-ascii?Q?yakdMqcx2ZC3i0gCeihTelGf1djmQ87505jkFdBy1tldzR1rNn56yD3LFrFH?=
 =?us-ascii?Q?ZKrAov1WkeLJjTFzU6bW7u8mqOIkg+1Yy50MjoL7J7GJCOr+PZ2kMJSU8oqi?=
 =?us-ascii?Q?9z+DnN5X2JHvzuAOEjjW6iq0cCSUhEQ0U0vPIzPnKSN+zp3DTa9imaLjzFNq?=
 =?us-ascii?Q?gB+z2ZvgVzOXShn4178zhV3a3Pmh4rXdpa1WcB4rNEKWBDSgr9E27hUA2o/k?=
 =?us-ascii?Q?WoN3MFzrM7DuNnwozeBUDpynWkE3D8WWTqoHrZKYq75bwJa1GtkUzoVNXLIR?=
 =?us-ascii?Q?6Eb+/d6K8sNEwSu4ktZ2KOZGm6pq7Nd1B94akjXUjq0+pwpXPVld4DfWMxLw?=
 =?us-ascii?Q?WPMimrucuN31wrHc++mq/v7CnvsY3rSTVBorSE4lK+3/IvLObTiI3rxWApPn?=
 =?us-ascii?Q?9zqeqLxYkhVdGR9w+zSoEECFndkJdTXkRlrawBHy3GJZERc3oWf9NK0Wt8PS?=
 =?us-ascii?Q?Fkh6Zgz23C5ZiX5KzIfWzWq5BLF3Sp5PYyWnGqlHcTYZ6HnHdWsa7MKCIpP4?=
 =?us-ascii?Q?fmX0rGgQpmKMs/oZEMQiZdeXJSww9DIL1R1GstH4wZyqBBr6i65Cer/5NLg7?=
 =?us-ascii?Q?IolHTxoBj0jQ3LpYfJbwId4+dO5Yl+YvLMdUVbmYqWhTiABLCRkLrdcP+CNi?=
 =?us-ascii?Q?4vyoIHy+m9qIz1HqdFqoGOfyiT1yQ/AgRuPFgo5V6cxLX7X1vQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bUmeDGkpXqfQmk1KXRM9VltJ9miWLcELEN6je0X3WyGCmwrpJ/uwLR7JN0fb?=
 =?us-ascii?Q?6OFxOCy4u0KM0ya+Qtanzw7BuSTxqaS6rDM137MVPbUnlOlRRXsiqkDheZrN?=
 =?us-ascii?Q?uZZJSoT6X4NRiATVe4n1oBoRpq6D83Tpi2zAWcNB04fWo005k24cWdoUCTOc?=
 =?us-ascii?Q?VNGKtNevrp9ga/e0qSeJAlFFiqxKtsUrb6WqpWP4MovZK/mRsQqsWM9eiFhS?=
 =?us-ascii?Q?HMFQd3iAuAWCjwBzH1/F8oaYBcB8oIdPgj3GZrAfHyA05xuVr/p5DOabrhru?=
 =?us-ascii?Q?KSTYokJEsPYsyqI5h+3wxJ3+xxFKhUadRKgHtalcWB93f1jsP7NDRlXBI/np?=
 =?us-ascii?Q?Mna4BTKib1R1qNzuV4L9yPgtVtK2kkiGa8OShIkvRbG3e3WJBd5catqauY9P?=
 =?us-ascii?Q?HwbfXYPIGs9juOq8v5V8OnPSjPvnHKIXLsGqD6KnrK8OISO3XICISBT/m9x9?=
 =?us-ascii?Q?hB7ewV0KFJXgR0YpWohQ5yTi1rvHS5FYEVCUN1AO/ulqKF3GEnn6TWEb6FUJ?=
 =?us-ascii?Q?ZfExbkxhCvFLj+/k78W0hsbspft7xwAZJxOTY7C5MWuWcdQXvWV9NvLWkGh6?=
 =?us-ascii?Q?MC6hIcwVNGCuKmY9mDrg9qjr9gWP4cdDuTTyJqHkA15z7aoAGusaJlVbEGue?=
 =?us-ascii?Q?XiVZANdbjaUS+Os2KNVu3A8wOZmDHvwsAZC5B/K8ibjpHOhd9JETqmJZB4Ii?=
 =?us-ascii?Q?dheGgiUEfo+A175LNYUyGqOiMOY7+4Klxe6lMa25QOkd8VDK+7CNcA0FEXQ6?=
 =?us-ascii?Q?Hmp29s8l9M+uC2WfBRmAtbZ5uaxsMGj3LahTfcgLN5WziY1p2mpLI6R3cs93?=
 =?us-ascii?Q?W/BGRZe5pJr5u4OYUgaqXuNPyFOohzf/5g2yNxtYzRtIEgeqrXsHXz/4NOlP?=
 =?us-ascii?Q?fIWk5+GpQwVNCj/Ij5usYYFbdo+9vp2zlyM5B1kWcC5N+4kH/Hqqc/ngLP92?=
 =?us-ascii?Q?GRUlSCjK6S0QoW0Ywx7QiCXIvl1p+rOLEkaTEzf+NN+QT6MrBw5p2INKAYPj?=
 =?us-ascii?Q?vsf8p71C56j0CkmjDlRSPzbRYuqI9Gjkqa0TH/a2n2QNI74Qs9VFx2BUZ0nm?=
 =?us-ascii?Q?HV1QanpbHzV+dTpb4MsA+3QlsN0y6zeVB3vX4lQFAA+QcObWn2gzVZ6UdKhH?=
 =?us-ascii?Q?r6uZzei8qRTcBvCAr6DMcTsppQoqrN0Vgt7fUBAVsOtgalSsyMtimj/l5lx+?=
 =?us-ascii?Q?MnzzlqkNzdfOfh7obM0dnME3h3lfWdiYWlalBOMDIgIskfo5PvkkH2ZZ2SKd?=
 =?us-ascii?Q?cOckSOu9m7t0paKcSk2FgvWrwEmgwQPHWan+1r8v1DQTfI9rXj0GgduBpjcD?=
 =?us-ascii?Q?fLkAPCdDyMVfnwk/g4BrxEoPaVCZvu4Alia/WgslOcSZTWd6EOWCaKlWHvCp?=
 =?us-ascii?Q?A4LiBjP5RlsOD4hXyvn4wfWOsKy7GiAmCyvaBKrx0/o3DCO+1ZOYmUy0RvlU?=
 =?us-ascii?Q?/KxAVeOaTLasP+JifWUJI+tl1ZI57a+6gIp2XV+LPblKW3SqlanqgyW9vYds?=
 =?us-ascii?Q?Cq44v41pEyZVns131c1pxqaWaWfIlw7iBPKG1AzXNt4hGVb1iivUswrqU37O?=
 =?us-ascii?Q?qwHneVYhEItg394iw869KX31zfm3MCMXFtsRFyGI6qIdbWHfDUxEXa6fnF+E?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b086d15-680f-4487-33ab-08dddb93cdf4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 00:36:42.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFhfvgQWZxlIAO0lsCc6dkF33tlLxPLEha1IHw2iEc1LtBPQHIc4lXWr/x/iK2Y5ucFmUVN68IQBx8+sGt0CqBhCoMxFf9OvAXwmykoph/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-OriginatorOrg: intel.com

On Wed, Aug 13, 2025 at 12:17:51AM -0700, Joe Perches wrote:
> On Tue, 2025-08-12 at 17:38 -0700, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > New helpers, ACQUIRE() and ACQUIRE_ERR(), were recently introduced to
> > clean up conditional locking paths [1].
> []
> > That compact format was a deliberate choice by the authors. By making
> > this a checkpatch exception, existing ERRORs are quieted, and future
> > users of the macro will not be dissuaded by checkpatch from using the
> > preferred compact format.
> 
> not stylish IMO.

I knew when suggesting this patch, that the 'no assignment in if
condition' hasn't had any previous exceptions. I appreciate your
helping in working out the implementation details here.

more below -

> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -5696,7 +5696,14 @@ sub process {
> >  			my ($s, $c) = ($stat, $cond);
> >  			my $fixed_assign_in_if = 0;
> >  
> > -			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
> > +			if ($c =~ /\bif\s*\((.*[^<>!=]=[^=].*)\)/s) {
> > +				my $expr = $1;
> > +
> > +				# Allow ACQUIRE_ERR() macro syntax
> > +				if ($expr =~ /\w+\s*=\s*ACQUIRE_ERR\s*\(/) {
> > +					next;
> > +				}
> 
> nak.
> 
> Using next would not do any additional checks on this line.
I see. I'll get rid of the next and use conditional blocks instead.

> Likely use basic block or a constuct like
> 
> 			if ($c =~ /\bif\s*\((.*[^<>!=]=[^=].*)/s &&
> 			    $1 !~ /\bACQUIRE_ERR\b/) {
> 
> 
> and perhaps the \w+ should be $Lval

Thanks for that. The v2 approach uses the $Lval and captures the full
if condition expression and iterates thru each assignment.

I did more diligence in v2 wrt testing and will post my test cases
along with that so you can see what the patch intends to allow and
what triggers ERRORs, including ERRORs that the v1 usage of 'next'
got ignored.

-- Alison


> 
> > +
> >  				if (ERROR("ASSIGN_IN_IF",
> >  					  "do not use assignment in if condition\n" . $herecurr) &&
> >  				    $fix && $perl_version_ok) {
> 
