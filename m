Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF6077A1E
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169563; cv=fail; b=onhMveIqUSWx51+SYOCwi6mkaGVgpU9nGCF+EVA+Ajz2tE8E0Nr49Ev3bF+1bqeDtRuLkJYahPLh06DjvDsKWTQJHM+7wyhpJrp6GRh3tWaTK11gC6CH4w8t4Oo7VYkiE1nbf3DuKEBG7rkKqNrkxDH04kkjntpP8Eh+XuUaOUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169563; c=relaxed/simple;
	bh=014T/kSQzYf3qJZO4wzpGNYgtHLbDeRFeaTYCHpt9q4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OFu31JfdzHpgupfmmZ4EEGSj3qodOQmViAGkaRz0+2j9vItbP3b8s4606fi7Va8an1Bm+525TR1jYqoyqi66/znA+UJLU4Aog1udUr9GA7gJXdY4cZPJoEE+bYDTY31wX8lUexCovz+d/o8TU/QDtppxNyG6xEK5BT4QBOQoX+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBnmgHBB; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBnmgHBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717169562; x=1748705562;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=014T/kSQzYf3qJZO4wzpGNYgtHLbDeRFeaTYCHpt9q4=;
  b=ZBnmgHBBV2l8omaFUIc5YMejUymdfRe5Xv/YZz/+SS8/xuB2uUDilbAG
   sGhcnZ9DAE6fW/9720vYi8z0vSX0kdk26S2uljY50RHzlnaRAJHopyi9p
   YwmaOJSneDL7a6xWxMou7fh1iyv25BZkCLmvg+MakXLLJGxpRachDSD1z
   OU2FsDAOop/0lFLkFzvICmYRN/apMpsSTit9woLHp4HyjOG5ZGZNGjeNB
   C1BxobgtD+3SMYCyrMK0fh2Jde/wFthC8yvghff0QmdJwdBkqyFfVIt8R
   XHvr6NHxS4+eYpbLRNibvYQwCGpYHJqtzuAS7U+164Tv3me6fOfyyl6QT
   Q==;
X-CSE-ConnectionGUID: biV6oosJTdy6nH/rrt/Pww==
X-CSE-MsgGUID: 1Tml9EVgSemPqlY2TyAdcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25120890"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25120890"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:32:41 -0700
X-CSE-ConnectionGUID: d+9ZqYjMTIe4w9kiwOYlOg==
X-CSE-MsgGUID: w5ZSXndGRO+nJTvRwLmxqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36280999"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 08:32:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 08:32:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 08:32:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 08:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFr/uXZtvWK4avV6NotZfDJxzAlC67nEIkN722q+mpmOtB4XABDYG9hlqgr2YFC8iztv+9S+easiU85HUm8f1VQ/0YJee0oxLsJZV3BF4nK7HZxdAOClMEuBcm5OM2RH3IbH6u3ISyEM/QjERQqksRh8PXDhYxVcO2CrZdcBHBQosAqPsVazBAIf8xq8NiCH8wrq5zRiWimvUOxmBKZLKafnGRdIDe28X3DInRJL/jH+La6dJWwYykVPfipIPazbaztaIFvFVJ6BjSnpohsr6J93p9p4SlMND72v/R7G1DO8zq8U1uGLo+J2EMjcWtW/AykXP9KjVl/bUy5l/M1O4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC+3Gt6KL5SVkxqIwQJ5wXx56DL0CsQEi1xf6UQ7lBY=;
 b=nhC9ZKvTGKkX2yl5HCFZSmnFJ3kIjZRudPAQ7S4OJfVeNHzHcCGSMw0N5N1My6nfPrBGtLYcCKHp+1T0Ru+0GkgAi8LNAqCl1T80bAzXHvla2kUOSZQgXZ+wmMytBLjjwfcVCbq+jnzkS5uoFEhTkFdMhRk29t+LSOjl0b4B5w6WwPpLgAZaamnwBdHqhF+Eex03ALyGjpx0R0IWnXZYbeQMDK/qWbeotrWo/s8b87tWyLWCPUC7CyRKzeXU2DJdqwj1AW9r9WoWthbPULAXJAve4k/tWUJd38GM7FJ0Umlto+XMtUVCnoABElbso23A9LLS/98kgfWgjq68gkuNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6228.namprd11.prod.outlook.com (2603:10b6:a03:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 15:31:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 15:31:30 +0000
Date: Fri, 31 May 2024 08:31:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Foryun Ma <foryun.ma@jaguarmicro.com>, <alison.schofield@intel.com>
CC: <angus.chen@jaguarmicro.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<foryun.ma@jaguarmicro.com>, <linux-cxl@vger.kernel.org>, <rrichter@amd.com>
Subject: Re: [PATCH v2] cxl/core/pci: Move reading of control register to
 immediately before usage
Message-ID: <6659ed504cc4a_166872944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <Zlf1xa3O0DNu8Tv3@aschofie-mobl2>
 <20240530064751.586-1-foryun.ma@jaguarmicro.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240530064751.586-1-foryun.ma@jaguarmicro.com>
X-ClientProxiedBy: MW4PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:303:83::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: cd135150-34b4-46dc-ae7a-08dc8186be9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?njh5YroV6TqhChyTowWqGpsuTS9haeREeHKbMo+0bMHGhvacDkRfSJLl/sXj?=
 =?us-ascii?Q?XBERgdBbpA/FniixK02fFzL4a2gTi4TuuOoJhpsKbA/B+zCBRmfFWSlc81Mw?=
 =?us-ascii?Q?JE7t84bJCne077TZ5DP6IBeNQT11X4o9UvFC5N60/RmSzKgRHG0ivmmXvRYf?=
 =?us-ascii?Q?YoEtDFr8jQK+31+C0VY29gfufL2UH5Oz5BQiyyEl93uhjvEsg0Y22leUjjYF?=
 =?us-ascii?Q?YHTG/v7u3bmnEinGlhF2ShuQtXweQASqDBqqeT+/6Vmod7XyKJmN8nX5Wx7u?=
 =?us-ascii?Q?s8ZJ4mXRPJl0JH4X+LzPSbXTZ6nq+xVplErh0WNc7CdRdx+eAhwCB0HzghDv?=
 =?us-ascii?Q?JvAL7KixIMLbByReNsI4FyAKbNz/PEt5DSXyJn6u8EPlLJ881PRLwHFY2SBU?=
 =?us-ascii?Q?9nOjMm5zxq/ABPIxfyh/PIB/pOWb7aYa6HoCTAHVXxWGYSZguDytwrkr0KFd?=
 =?us-ascii?Q?Trny6GEZX12UiotUX9G070fxXkdHUSU67v/Z4CvOWaX6ukKjvF/3Tvyhl4TH?=
 =?us-ascii?Q?5E8Ti2hS7w2HW5y9y5oZItXK5UCNkPD07hLs9OfsJuYnP2/V6w4sn8Ce/wl2?=
 =?us-ascii?Q?44apQqUPynCGdyasvywPrJCEkSpS73udE5pqJgbCXU7XuperCeO6CHLeJiDQ?=
 =?us-ascii?Q?b5fHd2mIwQH2+C+VZCtJM3/3RCqsPcbxOrR2nC3+LidWjoU2INXLf6ISfPez?=
 =?us-ascii?Q?UUT0Awy5hz+ECs+9cXKfev+tGUtjXhWjmR4KCFJ76miW2CtD0VQjhZ9rikXD?=
 =?us-ascii?Q?uIPRq58u5pn7uIJF9UXe9Xtzegv+6CAKNGlGw5EUZuhbahtz+XRiXeu8GmQB?=
 =?us-ascii?Q?BZrqwe+QSinOlPVfgyySs2UcXrdTbWB/dpBcHEntTvMVenG1P4w92fqaIuqJ?=
 =?us-ascii?Q?Jo3nNdpCXeelFvW2doxv4T5eUKFMyeVS2Koq42eD9qEVH+iBLPFJbzAwsAZX?=
 =?us-ascii?Q?hu2ZOe5vOjV1MZJz6NnNK6HdA+MmTsQ5fJ9qam/CC+QdkmgudckeWtlvw4rX?=
 =?us-ascii?Q?EI3EFYDWifyNix8DpuQuGjprRzYVoyUxC3HVN552eHUjISwJnHGOL+OkXmDb?=
 =?us-ascii?Q?eUcSj+O9AkfsK3wxTcIsT2FItxb0YbmbCmu6A9YrODfJa9PVmM9ySRs6JVgH?=
 =?us-ascii?Q?HYmMzVue+GL9GIEbAdOfNctRgoZpQ5PTGiloUejCZ9FKaP3w/fINKbN8QzAV?=
 =?us-ascii?Q?2uTwuwFw1akLuto0KBwUHNxyKXN01dWjkiI0PkO0i2tSHKCXoo/pm9oeFYJj?=
 =?us-ascii?Q?mJLtOaUe5C91nlN1T0a8RBgg2FVp9Rc0elSoHyMLiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/AZ6xKknV6t2PPz806zkpEraj913DBSO4eo/FvMeuGnPQrugTrJlzbSgVSH?=
 =?us-ascii?Q?iGASxaqpWs4uLUytQsQhXIvre9uIWUtBHlExvHDFRjOozBz20oqkO+rQ5sqZ?=
 =?us-ascii?Q?T5mV1u3lUN3KHXyXPxxxKZWaMRirWkwgszQRiyGnfeRPyxrdxNBnDyMFhRcd?=
 =?us-ascii?Q?EhmBRsAlDctRsU11sziIUYXxEavKbYD/dR3Yia0naxhM2FC/ouI8t4LcEQuD?=
 =?us-ascii?Q?yyrw0N6AC7+QwLaIuSlR+XqkHxN9UMWoua/lxIz72cqPdrp7GiYhxgIrPOkJ?=
 =?us-ascii?Q?bLXJxD5EQ25dHf1p8Duc3LCqM9swOTsloMXtFMvOqQm/K9QIXMZoOGXe5cwM?=
 =?us-ascii?Q?u5K8M6by7G+1Ga/tsRSSe8YFJs4B5x8aqY5YA6zyC5EI1W4PzdEMMBay/x+9?=
 =?us-ascii?Q?WDewuRPMz3H070JSqS135DIQMaQNa2h8ZXCvKQJUFnT9nhvOjji403JabSjC?=
 =?us-ascii?Q?FnLVP5s+ROi5xKZiq4dB5Aj/XBDru5VZk7AUIkgeBJte6AIGAdL35I8hrs+d?=
 =?us-ascii?Q?i/TryH7nXFu/ey30hevdLjAkorLE+8XT4yBNxmBkp7n0mgVavta8W6h21zaw?=
 =?us-ascii?Q?u5rPAZqeocwNPdg9vTFiyH6Gsi83ekP5pBLNPAOI/qtcZ27rVRhrInxdWjao?=
 =?us-ascii?Q?RvSneLa5P5TWsBF1IN9CJYJoEdvHfHIxB/tOy9up8XdUxEsljaPGnHhjrh4n?=
 =?us-ascii?Q?6d5OeE9gyokpORwlaZkE9nLVrtB2xjxN2TBpy9JNy29tOPHwuCs/iXetAKJM?=
 =?us-ascii?Q?PGNfrVBJdziMafrqTTvyqrGpWx28ARDPFU+CoxqU+hhLTUDNOCo4QfXrBQcp?=
 =?us-ascii?Q?goC6nIoagATRoRK1dnqqeSxHMhCiRNlwREF7IhixgJgsX4XnBKchTkkboixt?=
 =?us-ascii?Q?Pox/MIdUJy3x2oWcxx6ISnH+5m3dWpaLoBX0hupy96WOy4SBNl9SE4Fmg0EZ?=
 =?us-ascii?Q?glLLVXejOusxFjXHjxYz05Vpc0xj00gpIs5LiFywhuXLAoYth26FCuojIFIZ?=
 =?us-ascii?Q?+/xZxughwQNTirJfdo3n6gQgeV53HA0Q7PtfSBRaWvOB+MlN2MmgC/uqOHUf?=
 =?us-ascii?Q?vjUj3u82wXoCZMY2dz3+eXzxaLc6qI9VPF/cLaigopkGuOjJdmN+eCN9Y5X4?=
 =?us-ascii?Q?IL2gPUff2z4y8kVNU05GdqCcCKQ4uzaR0qDG/cYgS3NpVUKdD0L1RTr8yVpy?=
 =?us-ascii?Q?lCzc3aGih1Yii/A7H+/MBDQue6il2gXKrR/b3HR1C2hbJ6i/M/WUnePMeVwj?=
 =?us-ascii?Q?NMj6vm7ZJYJFFS5a22LkjnpTwhYrr0ddK4RY+uAj9u8MbHHKrp4E/G9lYOZJ?=
 =?us-ascii?Q?DzG6MJsN2hkAP/xsL8NzsZIYDwcN46LKgiwIJyHGqhSPFTqyBZDsPOb6HLnz?=
 =?us-ascii?Q?tysKrq7u5Jpc98H8XEIjcpBN4AdsdBqRjMKTfX0+dZjciJRyKb54PcOgu3vG?=
 =?us-ascii?Q?LtJUaJ2bI4Vh2jPSHfWH32RL72uszlzNK73By/TsMvrnoRp2OqGwoJrtR8t1?=
 =?us-ascii?Q?CE6lx/uqdksYJOBqpEyxxDFSXMDME+dQPe5LhflmpOHoQpd7Bkz3mUwNHGqo?=
 =?us-ascii?Q?0BIQXKh87m+BaTGInXP8FiuR5xRSesQwTP3GN4Ooa9z0OE8IW7U4Pvv/5X7W?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd135150-34b4-46dc-ae7a-08dc8186be9b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 15:31:30.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mZcnPi1bkil56ZQ05qnYwmd5/XyqTZN9W/N+SK7ezbus4Ok/2EwzAULikmn1MBuuGzrOEYqdJAWLdzw8aTgZf97RGf8tHb1hz6U5OnSOSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6228
X-OriginatorOrg: intel.com

Foryun Ma wrote:
> Relocate the reading of the DVSEC control register to immediately
> before usage and avoid unnecessary PCI config access from the read
> if DVSEC capability check, hdm_count check, or device validity check
> results in failure.
> 
> Signed-off-by: Foryun Ma <foryun.ma@jaguarmicro.com>
> 
> V1->V2: change the subject and commit log, suggested by dave.jiang
> 	and add change log, suggested by Alison Schofield

I guess this does no harm, but it seems not worth the effort to post and
review a patch for the given justification. PCI config cycles are cheap,
and all of the noted failure conditions are unlikely.

At the same time, I admit it is nice to see new contributors get to
the point of being able to send valid / well-formed patches.

However, going forward, if a patch has no end user visible side effects,
and does not improve the readability of the code (i.e. is not a
cleanup), then it is probably best not to send the patch and add to the
review backlog.
