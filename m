Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92B8528D
	for <linux-cxl@vger.kernel.org>; Thu, 25 Apr 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714066260; cv=fail; b=iKjs4gi6nof7bPVJGyWR+D85LoMe6czxAfuKcsmWBazspa3xI7QHwkeFHO3TLwR0R5d6UadKuyaeJ9UBZmMdMQHJ+gYrrEJPbWzHyKJG7F+rOTkHLzWnIOoYo2hcpixm8bZhNvIxihNfRr61NnOvREIp8m2hgIo4lAQxFi04pPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714066260; c=relaxed/simple;
	bh=iBCWFW3DF85zmf3xIz4ZzydFzlYKN2XNGGlOlA5w93A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jMP903chrj9ps7W0nBk5P0h2UwitPT5gf8ISk61L93M82F4zOq3ZFY7LnMprw7ZlKpxEBMy8YRl4B4hOY2WAeYHuBLAt07F8UHY0oz7p5+E8gX4HoL/xKA668UmNQoSqypdL1VIZv4C0lZOMGIUYGYVYdIoCW4zsAJ6+ur1Yfbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahj9/ZNf; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahj9/ZNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714066258; x=1745602258;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iBCWFW3DF85zmf3xIz4ZzydFzlYKN2XNGGlOlA5w93A=;
  b=ahj9/ZNf20XU7uYUDwxnCUmESttXCOwWfP5DaFQaTLsgUPKioz36Alx7
   7xld31G38s6NJwUOyuaErInx8MNYxQ6Edp/ciPRGaKQmIDyfg3OFzIzq+
   QgUDNbI4X+XVUW0ljWJKCuhS3TJ/Cb8XFgqD3pjQdGdIQtxFh4GeBDjNF
   RWk7hQylZf738sSvgHU55dX/9j/DARS6y7hbFaCdJ0B7YgyP/2xt0uHe4
   pDcUuIf765G32V7Tbl/0CPmGRbRLIqZszexGVS1uG/pXYKtiwpa+jbDTI
   8NuZw+pyqyYQhm4l3uU5W/pGvBh5agxzsDxvjYaKwWd2p63OyRrH5JrAD
   w==;
X-CSE-ConnectionGUID: DPIuvA4ZQLOgMHKwaY3iDw==
X-CSE-MsgGUID: OL3x11y5QKuKEdaWK99DdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9933618"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9933618"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:30:58 -0700
X-CSE-ConnectionGUID: KSdpzrebTC2MF2bayCRuWg==
X-CSE-MsgGUID: rm126rrWQAGyL4U0fCjVdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="29615585"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 10:30:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 10:30:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 10:30:57 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 10:30:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4IoLl5EU8OC8gcRoMsfHuUPb3+/LgRlAJBc/HTaP1cGgzHCAURAjo9xxPogFYdmtQ0Ehzz4uhxdorjhMBiEj0GAe3B3sS4WVizrwARd9U33nZ3dklWyqJ+Z+uRe0HVqnFpwpjIZmtV6IRoPS3a+6GfuQIQ2jxdJJbSYah02OvoVFrJDWKN8DB+Rty5Pcy82/80VgkyHKI69pl0t6PpjZmb6hbs5I4HstypmnUuqCdKkR7tm/oDLvyBcFdt0J3nhrcDCHmxPLhJDBD8sV/IriBrKEpSVFK4B085nYUHRnPP6cmeWmUyoWC9gS76TcCesqta/rAbg2FOe6GYohv44rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWzXYHjS928InovVmH/p9+ok6n4VSTUvClrIAuzFc1o=;
 b=CNBaIFkYcJA9BP6FEtVGB7Uf3CFe8AElXV4zK2zrx0ihadmVnpBXofpupdooA1QS7Zexypj8CfYKaATSM6gJEAWg25aKFxDYID1/rEnyHb0gg73Lo/mP1uWbfnhHBuwF5J08g0PkQkegeIhrwYR6I3nsrbAa4qG3J2HUeREiw7yi9i9Xp3/ewhRzYTddAtaF64TN7jdV/MXIq+zIBcu733XMrYLfB7dWve1kRUqw8SOUjGbKyZrLqF3TbMVLmTVY74qh+TznZKNVdNNjNuAKiHjO+YcfebCO7bCCxa3qSvLnUlKUIOQm4riw4hwqZ0oRDPxRX7w1sxXqDI7Uh/ndow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 17:30:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Thu, 25 Apr 2024
 17:30:54 +0000
Date: Thu, 25 Apr 2024 10:30:51 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Markus Armbruster <armbru@redhat.com>, fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, "Fan
 Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <662a934b2757c_fa7d3294fc@iweiny-mobl.notmuch>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <87a5livrdr.fsf@pond.sub.org>
 <ZilDz3X5hmda5oNr@debian>
 <87plue9en1.fsf@pond.sub.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87plue9en1.fsf@pond.sub.org>
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ffbd73-b296-4157-1349-08dc654d75d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2lNo49D9pZXf5S6C/N2cfwuG4ErnFcR/rkqvihGWueMg3flADLwTJoYyqJ2w?=
 =?us-ascii?Q?JUzqYC2lgUtpxtiLUuN06U/syCvgFav1MDqZoBnEkPTv9KiyL4npEYX/31LS?=
 =?us-ascii?Q?KkNGJ//+oTGlehk2a7zAcoEmiC10jUcR16jmh6gy97FajJHSOuCEHKJWDD2I?=
 =?us-ascii?Q?H63vlo4q4Rw+G7Yn+OqtEvbJMZk54Bax3gw1UVZmdipOuojk01fi09UNtX++?=
 =?us-ascii?Q?aMdVXaq1GV+2eIm6RULbIO+5hSRlb+Dg9Bp2P6H4CAJKdXsbZfjDu6H7P8NG?=
 =?us-ascii?Q?bdqtILJYLZPlzZ2fvDORElIAzucsDeka7PHzZUf0yV/948KtjpM92V5xh4Vy?=
 =?us-ascii?Q?7q92cvAFgJ7i5805UWheoE3r/kn3gyEpT5YdfaUXVl2NrAWJUMK0O6/O4TRn?=
 =?us-ascii?Q?HZs9IOcy4neLHUC/XgxU91FeMJH30LzPgGFQ73ogtKQIjRi4XRR+IYtSS2eT?=
 =?us-ascii?Q?e8FsXl15/lL83hjQq9fAkdiH2SOu2IOhUMtXNtLl5OObqDs3dlYOGs5LVhld?=
 =?us-ascii?Q?XvT+AU3NrqUtqM5piKlTsJQ50owGKBDJ7M5H9CDy5muY/8W+VTmGVLDnO3xx?=
 =?us-ascii?Q?8amwbG1+kNm2a1vsoH6ca56uEFhECpL1fCUPa3e3nPkCXu2MyQlxJ85BhMUJ?=
 =?us-ascii?Q?IFiyvIQge9fy50BXk/PdTz7UmnsY42bzzEwrlPnsWo74/XhCt5ENEgmvZ8kL?=
 =?us-ascii?Q?Gw7uwEyqNhWZmYBxb799VbPs16vl/FGr6GPm2onxTe1ezfd2DAVpLobbTf4A?=
 =?us-ascii?Q?L+BaymJDoXAorVFB+SuHjVxHrgZTNBIYES+r5oKSnFAz1TwPRiSelwkW8fsK?=
 =?us-ascii?Q?hyLcB9CgEC93tZotCLiSiC+raUJqYLBHeSHgTQBomg6mYocCxCvt7L3zbSr3?=
 =?us-ascii?Q?+HNtRitvOgAd/FlYXPTWpllNImNA/kYdHn+t4jHvRYVIqhrdzt7llF9oaRUv?=
 =?us-ascii?Q?5CqlF+xbQI+Cj9Is1gIp5k/J92nYwWCY8QSAsTIOT6ZoT4ajSubtDuh6lvPb?=
 =?us-ascii?Q?Bf49mp0r566S5q9ClPsIhX6Z1HpCyU6o/S2j48i3LHp9cyeWLpXYr31s7qFf?=
 =?us-ascii?Q?V30nw2X8CH6XweZlH3t26eMYEQj91CY0yPIUuIGLWX/B1Rx0BE9teR+WyR3D?=
 =?us-ascii?Q?1c1DXOo9zrubhY8eWKn1Vi3o351Dhg9KzawREBCDH2XjFz9peWCdNHW54PDR?=
 =?us-ascii?Q?UA/laFr8h5PqSvIzHovLb3Hw9s6+37yHtWvzN4KERKA+f9G6FkAGiRnxQf7t?=
 =?us-ascii?Q?eLCnNzP9OCZorgGLhyapofsOJ1EmPmIcswsPblA3Dg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nfe3wtZTuMLd69CHrT0GNT9VjJ7ZIAT17ALi3gp5i0z9pC9hhUjiEwQTLIfC?=
 =?us-ascii?Q?Y+b2zZbYVqlfmGpNVARh+g6j0A3l9mock0XhXaBGi01cLUo6RaHfmo1mMMPh?=
 =?us-ascii?Q?Mt0y5joRPX0yRXR2YKwBGNMhiH8OdICn5qv+TrM7LIUjXpEj5+uze2S2X9xp?=
 =?us-ascii?Q?JR4DbgX7YSnwgN6Dh81cMfSliaiIAux7vAIwHYlrOergrN8rJp2SF8qGffoM?=
 =?us-ascii?Q?4JoKybE8UWMVvnbuKfsyCaAYj2+BNoQE2FiOmSVFkLDSIZ1AP63YYKQSJQEW?=
 =?us-ascii?Q?MFkKfXZ4dtylONYqtdvRGbuODV+gT3suLdUu7fjmhDwMWEea5sSXbSeatfig?=
 =?us-ascii?Q?ugH63AnjC25uyKPedzrGPLZDtHQg89gnYXuX0KnMgSpWNv6J4iItxDK456Yo?=
 =?us-ascii?Q?vGSgO2GvkaMwm5eBVJ0Vl/S3dIJJVnV8xV81NaBG6bjtlfYjANuufadWZY49?=
 =?us-ascii?Q?qaVOp493UUNM4rlhZaurp2eHtZI4cnMacP/bs7pBIyWv4PM17YmaPAonMsDy?=
 =?us-ascii?Q?jiK5SHn5BOvAqirFqWftUbsuhr9hh5BFUoEkHw8tSpt5opOAeEJfd5F5TG+U?=
 =?us-ascii?Q?NXYwTMD5eBfOXSkYKk9SBeTofHRmgcxgNbYs19PvB0QvCjapgRMen1K2FzBL?=
 =?us-ascii?Q?laUeHYxAqN4MLErtetBARTmy36KHoVdTI00tOjZvd2YdVes9/wn7Dfw7iisJ?=
 =?us-ascii?Q?ukm6HJaZ64J0vCIaaf1JnAj1w894LQ5ElwQcLPr9GNV9NykPJtjl67I/Js81?=
 =?us-ascii?Q?K4IyAPbbBmUzM2bDZpYfoK0xt9mCTqPjHAbvcXHmXOScj9xp1wdhvkk82Hqh?=
 =?us-ascii?Q?PhRtEFg+h0ewxfSsIDJYdFMywWq0XSduhZkjz9GVR24JhsUz+K8v5Gi3IAxi?=
 =?us-ascii?Q?CJFaq4gSTn/JMHz+J/NXFYSvofywJheu2/xnbJGgSYNFNU3ocsvScjmozUv7?=
 =?us-ascii?Q?u5CCFg851xhUGypW2mtIFP4XS9sBRKrpf7wwcTiEzGud3CAKQEQjjqDcZZgT?=
 =?us-ascii?Q?e4DzWXugNUNdEQzqUh1FcM7syyHT09uEA9Y7GUYb12XjlcBzLsNo9i+MwNg7?=
 =?us-ascii?Q?oQ8pA4BzrJNDgm2yN2CA2o8hFhIBjs9fUS9nWdKX7mkomZ5VhqEc65fZ5Xvd?=
 =?us-ascii?Q?6cAW+h7BNPlQS9pAx8dJwJRCuj9NT3UcUIr6Qgti8JhVpgLN/1ov3edB8qBW?=
 =?us-ascii?Q?EI0ChhnngWactlkDvjOrw1scWYIhCJnmg7v0+rmZnHEEV5i+DPUwh6y8+v9C?=
 =?us-ascii?Q?P30RP5UcomkZ+wMWJeZqOhoO2YzzTjUTIc9KASzs0Ca/EsC9vq63Qf+rpjYz?=
 =?us-ascii?Q?OhaenlUIKbC9yu/aQqemu9upChEbMe74+xjcdf9k1sPtYDWNXGUaulglvdS5?=
 =?us-ascii?Q?Ut9vr7fFxvRrpLnvCreMkLqs64kXJCPAerdSCYsu7/RAcvhLdTtkQNUvhc7l?=
 =?us-ascii?Q?Q4D8Jo7J0GY0KG1tBA0bzqKVseBPvGRoBrJp7rnamLc7F+xq2Mo+YrD94Bga?=
 =?us-ascii?Q?eYLX/v/YC23dPB92Qns+Ns119xZrlZwJhnEdD9UeFuB0e0rnPVloV42SuMCc?=
 =?us-ascii?Q?ZFWf7S40eLEGbl38LuvgBkJPwZTBPPo6R8oOsaYN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ffbd73-b296-4157-1349-08dc654d75d5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 17:30:54.5325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcCGgMAQgnbieZFp9WprAsnad11QZgCB8K3nTGJX6e4tSZWYDQyMahRe3jRLwj5uioOaCfNtyprqXlFbUcrVQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
X-OriginatorOrg: intel.com

Markus Armbruster wrote:
> fan <nifan.cxl@gmail.com> writes:
> 
> > On Wed, Apr 24, 2024 at 03:09:52PM +0200, Markus Armbruster wrote:
> >> nifan.cxl@gmail.com writes:
> >> 
> >> > From: Fan Ni <fan.ni@samsung.com>
> >> >
> >> > Since fabric manager emulation is not supported yet, the change implements
> >> > the functions to add/release dynamic capacity extents as QMP interfaces.
> >> 
> >> Will fabric manager emulation obsolete these commands?
> >
> > If in the future, fabric manager emulation supports commands for dynamic capacity
> > extent add/release, it is possible we do not need the commands.
> > But it seems not to happen soon, we need the qmp commands for the
> > end-to-end test with kernel DCD support.
> 
> I asked because if the commands are temporary testing aids, they should
> probably be declared unstable.  Even if they are permanent testing aids,
> unstable might be the right choice.  This is for the CXL maintainers to
> decide.
> 
> What does "unstable" mean?  docs/devel/qapi-code-gen.rst: "Interfaces so
> marked may be withdrawn or changed incompatibly in future releases."
> 
> Management applications need stable interfaces.  Libvirt developers
> generally refuse to touch anything in QMP that's declared unstable.
> 
> Human users and their ad hoc scripts appreciate stability, but they
> don't need it nearly as much as management applications do.
> 
> A stability promise increases the maintenance burden.  By how much is
> unclear.  In other words, by promising stability, the maintainers take
> on risk.  Are the CXL maintainers happy to accept the risk here?
> 

Ah...  All great points.

Outside of CXL development I don't think there is a strong need for them
to be stable.  I would like to see more than ad hoc scripts use them
though.  So I don't think they are going to be changed without some
thought though.

Ira

[snip]
