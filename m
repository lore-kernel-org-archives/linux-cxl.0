Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21522C34F
	for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733874493; cv=fail; b=j4TdQkJ0zDblJK0bwf2vsKZ0dW5TXSLsmJus1o+6cjZto8OGnJtqvavAj4uh5R+nZ460/zuojdXgTK0tEJVC+du/xXAq55Y48GbSYHmiq60qhOKDgbuZLFXyXY4qBXf/UwH1LJmpR+xS/18r0UOtO6kDoh22agWBkJevRUZghM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733874493; c=relaxed/simple;
	bh=B+pwmSX/lJKquebZ3UVSv2qOUEPVSvE4S365OKLiDuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sPADiPh+MHMpXtkIv1SV6Z80uNqhS+zCL1g3AZA1C1a7Pk4ZOuB6d0iQSL2E+7D4/LzI5n/GGnffyMfPhCcT8t23+uGvQs/9mjLGr2luLqXwNblWsnIuYV2aTZaV5+8LSY9Nb8ATvDIGOrgxbPccConZwSWzMI4+UnwWy9R6p1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANPkpWWi; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANPkpWWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733874491; x=1765410491;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B+pwmSX/lJKquebZ3UVSv2qOUEPVSvE4S365OKLiDuI=;
  b=ANPkpWWiof42NVRNGwTT8djtbK/ybJiYmCi8lNr2gbZnZZf0LHAsaM2n
   nnbHzrDiFZYapfdcEbaEGw04Mf8bF+i+nYnw0Bc9fXh1jx0hKahkmzL4k
   K19Jf2oFb5suvL3mP4ZSqXVoD9SN3L0gepU/sgV/jqeGZiudqCzLvO2h+
   PfQCmKvIq/3Ow5zwzkLHkKd9Yrh6TrE9Gt7VDgPnTUAuqzaA/6b0zUG7x
   QZKbyzn+bwoaSmjSm2hjByJtt6EhLlz7IpzXSEee3kBteFxFQMPRprclN
   ASsbGZYvEHqPCwGW7XGMG5j1ThIBe7tyExbppgAZ2ti3f5j6dcZayyvAQ
   A==;
X-CSE-ConnectionGUID: 06lFZqjeRYigR0/7gmDcyw==
X-CSE-MsgGUID: eE8pGyz4RtOK+6ehjSeX5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45643186"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="45643186"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 15:47:58 -0800
X-CSE-ConnectionGUID: 2N9PukHrSQukV73dQHjzDw==
X-CSE-MsgGUID: xqvWtfK0SMuE828OCws3Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="99633534"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 15:47:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 15:47:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 15:47:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 15:47:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwusq1hrb/WNrxDd7JgEyEiN+jfIimieFC+1GEK2gX8KYol8kdQr6ZI2ScIqjajcYX0UwaBbGrKuBoiN3EdPE9dzrwP9Yrn2wZvnhYficng4T0NZk81DrfXjsRYi9WEGciHjyf41Ip++suh5GPFy1x5eFKgi6wOAZmS/n8nv4mfqD6SkIc6ZvdmoAgs8x+LlzOaYOpDewJcumpEHOKg+7Zlm1fysc5Ma5R7AwdlX2AXIc0/42Q1RsBMHMAig2TntkiALZbuTo5viZgFGdD6xXYWK1A3CEIIGDqilw05f8BpXoMI1EVq66N120Ba2DVknqPIInhNGnw/vaKCVSz9/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uyfk4/rB71T+qrHsYTLqxpjZr5WOBzbpRxo510bAYIg=;
 b=CLudYy8qV0dDoE8yFPbiWRfV1nG8wWj6s2XiaF7E/dYkqtHC0tEDWh7zTp+ed5jinOeIpd8xhxJzZ4aMk/UUdcT0TH0gDrADHnnmbELYuHi9jqqeiVaDxxwVBhpD1k7S5h654UIcuO+Mbelj7YOyMyJOVYKhznru1rJWctTee7QLjv91XYAFWv3nXY26tioDDln52zSjNsebIDajjzUYblONYOyiYi8PzBQ87jF01VrnUCJ/oPszXCebGmtQQdjxvKAQqsH/QcBWCxf65Sy8Lgaa3pGjUjUPoz3wry33cu5X/KtDwGbZxd/ayH9PwtuBNiiXKIy6AGg4csPr3RzqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5285.namprd11.prod.outlook.com (2603:10b6:208:309::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 23:47:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 23:47:25 +0000
Date: Tue, 10 Dec 2024 15:47:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>,
	<hch@infradead.org>, <a.manzanares@samsung.com>, <fan.ni@samsung.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH] cxl: Support Global Persistent Flush (GPF)
Message-ID: <6758d309c9ddb_10a08329414@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241205082101.1193038-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241205082101.1193038-1-dave@stgolabs.net>
X-ClientProxiedBy: MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 93eb693c-2f40-44e9-ba14-08dd1974ff65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uKooT3JRd8SLi3MigBfRvnRxRSzMdAKmC9VHM/CSa6qD3uxXNJUmdOIrw05O?=
 =?us-ascii?Q?Yn1N+pPNdTsflnZkSSnCHO+S7heaCsSgqjs7nyaO/kn5PTMAaOVnXPYrRNat?=
 =?us-ascii?Q?d6HyayX1iI2bI65CZf61n2Mnh/cRc9uSGI8u1XXQd+yl7ybfBiQJSOZs9lmQ?=
 =?us-ascii?Q?tXieLQ/WJaXcLGYKFaGZOv7B2VSBDBdN9x5gGQBzbPKKNlfsy4hUf7HM10Vk?=
 =?us-ascii?Q?zYdUz60GbE9IxwFD4CSLH1TsVqK3yHfWw6XAnJ6hZ5bzK/nDK6hp5IE8wXzh?=
 =?us-ascii?Q?MGXeRUhv8CBK1fTzzzl5nvncKm9yF6P27mXdrYUwk29M2BzdEf7gYBlQJdWe?=
 =?us-ascii?Q?bhDFc36uBD+QHOlmbQMwGI9wZp20X6mF7e8uvowU00CWH3vZ07I0S9EpFkCP?=
 =?us-ascii?Q?/s4wM8aNPKMWaR4HnO6g/5jBFM7mzTyR1QNmR7ZTbmP0gp0Q1PkSgNYy8FKt?=
 =?us-ascii?Q?Eb75LqM8jYrMPivnTg1AkkmqXztWzw4DVjd79AGwXOAUFcp4oUNuL/Ll9fB7?=
 =?us-ascii?Q?32fGsKT4s0hc5TwJEJ76eU+CM+NiSP/jnFEENFAhYI1W5Y6Pzk+WUJrnESz5?=
 =?us-ascii?Q?xV7gwq3R/XfGqcTEaCL35bPCsP8URQSLoGEb6N7kEOHvWCANA08tP6ncdzdK?=
 =?us-ascii?Q?HHz/x8/nuVCT/hs9O8Zl6JqqYai6WvnWXNyq4YU2q2IUsqhUcrUQwLVDYwiJ?=
 =?us-ascii?Q?3px7VKC/Z/6XnOoDs1s0rr7GIYuwa7lSnhhi+zWyNT/HAqEO79TQlvUNw/wa?=
 =?us-ascii?Q?0DOsHHIVzTvK4qU1iBt4ON4yzmf38xvDwrv9CelsSvouxHoad8qcYIkRSp3k?=
 =?us-ascii?Q?sfX/rhdAwC5ct8KloJ7lhPX4PVznX00e/J/gsWSMeWxoDzntNJWNYm/39mZz?=
 =?us-ascii?Q?UPoZym1ShDZzFJIN6rSzfic1lDizS2LMcsRDC7aZJItRg1VcbMI7zlFyziHL?=
 =?us-ascii?Q?TdpX1HcwYB8Wh9stNzUq6T2P3r37UCAaf93L6zh8NcwXyfthDKdMIJ1LFaJs?=
 =?us-ascii?Q?R5ov+QPv/pgs4LS7GgZ+4s3DHSzWt0llO5MHa7wDChKC06g+cJ4JWf1iUaSe?=
 =?us-ascii?Q?itKBVLtiYxNuD+PXACLuLk4P0/LPbTcLAm9Z0x0GSrewBT0fpfr/WG+MROL1?=
 =?us-ascii?Q?q0EPyqlG1hYGWj8G/c3mVu53EwxfznirdjQyRUYN3CjrYdUJxnxwxBmldyYN?=
 =?us-ascii?Q?PVqCjlftbyz1iq4UhHGjO/geYTNG6JafzVSZ6E9s/Bmut3C7wOFphNrHq/I1?=
 =?us-ascii?Q?0WgWxSMvqNIi9/H+rLsdutJlF6NxQCEWjg7s9fEiBzsEx4RqCvhL0P5rPMBa?=
 =?us-ascii?Q?U92N8KDAPY5kfLmpdnalXzn8jOnCozk/MijAa6G9v60c7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fD6GcRLirpRI1GVgEhAfJ3mvV/3sHP5lk2ZWYyCJDj87WbTJCroRPJTs42x5?=
 =?us-ascii?Q?V2byxodQ71FMGEWW4QZlyaF+83m/lcNsfqlADbiXJX/fi6iN+dzzhWp9TuJm?=
 =?us-ascii?Q?4k1dRWM7RkqhDMA9cuOPEgpdEIE9tLMUSDNlMgnJ9//0Wb70Cj2baF5tZriz?=
 =?us-ascii?Q?kBoltko2FOC7vCKAew5xFpoXu+zYD5zdLocsxZBeFdnYtTXhpOd4FpeFbeav?=
 =?us-ascii?Q?1SGjaYW6WoNbrlqhq446PnyWAJs5XExZk7Rln7VJ0e7dU8lgGHOD0pPg2rTG?=
 =?us-ascii?Q?r+AXhXIFVUlVvq6exHtLOTtbXnm7Z5hoZLfOnYmNoVmDxyEiP1Pra2635pNc?=
 =?us-ascii?Q?qMP/IKYNjyLY5bZ5o/AOvNBXdJt43APfJDx3TshgCAMvds7mH5ZL1qsieNcG?=
 =?us-ascii?Q?+L9EHRlzGiDA0oq0cttt2SmewixtfBaI0H54KKcatdBBr6fimO9fYzzhBR2I?=
 =?us-ascii?Q?ndPhqg8eINvOQYNtZ71m0cADCknYrlBXsaf1n6Tt1PPnTrUFhb0vzUX58f8b?=
 =?us-ascii?Q?eJJvCiwA4puf9r27NpjwRcKROzyGUEhB1EpYiXNCQHqc7SkjAtila2XeQrJO?=
 =?us-ascii?Q?mnGp4t+NsPOS5LuQBOON+91M/KeTqjn+U2NkDmxkIFDcbJhzIHIWs6rZUHVD?=
 =?us-ascii?Q?jiGtljN2LQ+BwZ6ZVHLbA5prGG5+p2yxm1V8VEL73GvShluk/KGTh7apdI0y?=
 =?us-ascii?Q?jQPYaTOA7qJh5nTz0FMqW1u0NC/CCHVj0IgaL9MqFRiHHjZmT+47VVLWXyLx?=
 =?us-ascii?Q?Hikn/VEYXfILyN5D5FVYuJRPaMTTQmpkk5mZGpq4PzUkZVjGlVGsARAqqHOh?=
 =?us-ascii?Q?sySE68rz4LcYvw9/40skKJI1J1Jb47GoKP+ZE1I0jGm+WkXCEA3LbbtgSFER?=
 =?us-ascii?Q?6yPWFgD/KZEd2/Rr1v+4uEwSwvK3lqb21EMgR7YMd4vV3HQarbTnKZbru+1S?=
 =?us-ascii?Q?skV42nkrKjRF0ar+GgI7gkTpiWQ4UHx9gkzTQbWVTXJOhWQXNZOzNWgnqfYA?=
 =?us-ascii?Q?hZQmMdLE0yYzvRFm0qtTg1m7TfsboC4TnHk2IycVpTiIPKrj1O+ZlnBYUPPj?=
 =?us-ascii?Q?BY7uviLr2Y8YQSRA/KElr0gxMgYd5XZ1JTm3a9X2peST6vOt6i40qxVY69lQ?=
 =?us-ascii?Q?WU2s4SLF1D5aRQZrfkic0T2UXGCiSJUXkrvf8coFJMaSbYM4DC4i7VbEFTVJ?=
 =?us-ascii?Q?cteaN2UcOxJdhL1G9tg4qiNoMZ/WhfQQJgjSBp5ZYLgClKkcgWTKKGhGT42Q?=
 =?us-ascii?Q?EXgwIhdFzaCELIeVrzXxs4LqKtqbsoUHuY180AaUg9m+vd8z2g9DxICVZP9w?=
 =?us-ascii?Q?Nj18MkgeqWt3W3irtU9/bbt/9n+FZcC/7NRkMvU/+qi0UVM+95iq/E2e4KNA?=
 =?us-ascii?Q?cxruU3I1FuzjOrUYqixeVehzsFwKtQv4O99ZROSQAPSIW/eYGFJQQINqoeq9?=
 =?us-ascii?Q?E+s0ADJ+qziwa5GBViDxbojPiDE6QKr0j7zod8M2QdwcilZlnaVPUJoXx5hD?=
 =?us-ascii?Q?LvzjPObP7hnDQBlYm5StZfIFdkO8ngCw6PTg/fvXcFpi8hCfHfHy8ytEzjPx?=
 =?us-ascii?Q?CweckIcRuJfKeaEU0SHOJADHuWTaRM5yOegRJj3NloDt7+RsZcRk5hbkf9xm?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93eb693c-2f40-44e9-ba14-08dd1974ff65
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 23:47:24.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPam39rIs0jAmvwm/K7l0LWLcW8eUnbyzHdcdbhq9sy/TK2CZCyXomUCBqIigikiAcD0PP/4l2i36Ei5h38PYjMZu/gbdLWw5/kGrT2x/gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5285
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:

Hi Davidlohr, thanks for this:

> Add support for GPF flows. It is found that the CXL specification
> around this to be a bit too involved from the driver side. And while
> this should really all handled by the hardware, this patch takes
> things with a grain of salt.
> 
> - Dirty shutdown is not handled, and puts the responsibility on the
> Admin to deal with any GPF failure - otherwise the kernel will just
> keep using the device upon next boot. Hence no SetShutdownState DIRTY
> upon memdev probe (and no need for clearing upon successful flush).
> 
> - As such, the driver will only update port timeouts throughout the
> decode hierarchy, upon device probing and hot-remove. These timeouts
> can be over-specified, particularly T1. Set the max and rely on
> devices to minimize GPF response times to avoid the worst case wait
> times that those timeouts imply.
> 
> - Energy budgeting is not supported.

The missing detail for me is why are the defaults likely to be broken
such that the kernel must get involved in setting them, and how does
the kernel determine they are broken?

It is unfortunate that the specification does not recommend default
values for this, or even an implementation note about what system
software is supposed to do with these registers.

Can you say a bit more about the end user visible effects when the
timeouts are violated? Because the critical enabling from my perspective
is timeout detection (notifying the sysadmin), not timeout setting. 

A policy for setting the timeouts makes sense, but I am not sure that
the kernel should pick "max" as a default policy. Especially when max is
80 seconds which is already longer than lockup detectors would tolerate.
Likely anything over 30 seconds the kernel should be active complaining
about something being broken. If a configuration needs more time that
likely needs a user policy override mechanism.

This would be consistent with what we did for mailbox initialization
timeouts. Pick a "kernel reasonable" default and provide an override for
outlier cases.
