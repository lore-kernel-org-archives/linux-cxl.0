Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70360442C;
	Wed,  9 Apr 2025 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170902; cv=fail; b=tQcGHtFOHWQC4H9UMTp9hCJF25rQGSl936drQlRrdjcyNw6suWHZzUZcv1hwBWOgVb6IFnla7QlVW/YpT/ueWfpsKEZu4zbvqGhKBWXE2p5ZakFlVF4rBM5a2qKYMosb7FhtmZwSlKXwE8NVxJXyduN5Jm2BBpgQ3FzqUs/hqG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170902; c=relaxed/simple;
	bh=MJgJSl9bNWGZNqMrSB5cn6hgj1PzGzW9LpdyUD4lcA8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C0CU49eb4M5pQj4zvroiTNSr2EzbI+xaYEZDZaxF83W4LCKk3fmL42C3dRP4mXZIycOpLjWUhHpwariVhJvw1VR31PwL6rNnHiuU0dSwgoUjN4l6znmcC+zK/ECgH+ot4KcWMxUI51OdU/JQ5fTwUdNhNnnI0kw8Cnycb1xWSY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlEe7F2H; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlEe7F2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744170900; x=1775706900;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MJgJSl9bNWGZNqMrSB5cn6hgj1PzGzW9LpdyUD4lcA8=;
  b=TlEe7F2HJ84qUr3JxNd+QtQbI7g1FeRaWdeOBWRVolnqMTFbu675o6H4
   TumFN642p+Iob35lyWdk5tzbsoqOg0UvrQKGQ4v31BMWkjAk2eFbkqykM
   iTyCNdoTzBR1oYrqTo+mVmIFlrP4l+pIgZpwQJ5Ls3G+qfvt09hkpwQyy
   i4OJgDFPUdcaoTsFK0AQBkwll6qDwW9ctLPMbC48TLLIJ4cBoK02V4hHR
   9lSnkOGMRLfK1CAazhotO7JVAK0y+Ax5IP8kfGP+xYepJ4uMBsers7a17
   LnkSLf/XNAAjeW96UdzSvAE12YiQwtAKUgC52nTkXmb554OVIoWvrR1nr
   w==;
X-CSE-ConnectionGUID: x66iifvuQIegiAkjxZhIlQ==
X-CSE-MsgGUID: Yh7hNW6zTEGHfV0pwGsghQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56265676"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="56265676"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 20:55:00 -0700
X-CSE-ConnectionGUID: k8SWM6X1T5GVeT8V43uFuQ==
X-CSE-MsgGUID: jYT6SnwTR1+7cUiJQ4VI4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="129289585"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 20:54:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 20:54:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 20:54:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 20:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc+8u4Seg8iLK6kx6qPl5mcnDfEb8N9SRPTnTRMbqAn7b/CXTSiXEzJMxE6u2y4s5Jm8qT0TqbPLMBJ0PYFcB/qTRDHR6qT2sGHKzrsytX9F4P8MH2uDd1+Vwyvnxu/zwmq/i+bH9XmRfP2aL5D2PLvPrFFoTq0354LF6/BYEzLGh4VpPBujW4y2Wnvld2Jajf/UoLpYsLkPY8dy5Q5/mQyO8wWfpyKcqxpJstrtTKigZJVLVZMztHaAM1oW8rBFw5LuOazKZhHDGbwRmPxaP/0RwndI6nlAxUWnzvEwOpWPo6gh0x7PJmqWeEf0QqHslzFedJ6uKpw/8AzV4wuotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doBPdp7pB8/SMD3QlIgHPrFpra4lVZN2iGy0lHz0iQE=;
 b=e198iqDpIUpwFEYPKUEuzY+lpa7+HxQXe+3jQRnTeOSjE+LQRaytyQjKuAaJLWtcBZdp3y8beA6u3CPXPkJL9aWaEYXSFWsYgpptqU7DCFIoggxV6LDMOwEwJIzEaWoD3HtErzgFoB+YQBcr/7EixXM1m8tRF/NmmNHjB9vC8lfgweSC2gmENLYO6E0dRBWt0f7uGH9Rsj61iL4t+O7yY0UV1PWQ8LGxb1x2/BrtQjZb43anKfTPmi86tvd7LixqZZWp2XhoGIthEEXSNi2s7BFUNpxuNLS3y5wKrIXDVszVn4A4ZOOinzA5gspJqIQ8idqd7SJlbZgJQ1AqSHDo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8287.namprd11.prod.outlook.com (2603:10b6:510:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 03:54:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 03:54:51 +0000
Date: Tue, 8 Apr 2025 20:54:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Rakie Kim <rakie.kim@sk.com>,
	<akpm@linux-foundation.org>
CC: <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<dan.j.williams@intel.com>, <ying.huang@linux.alibaba.com>,
	<david@redhat.com>, <Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>,
	<rakie.kim@sk.com>
Subject: Re: [PATCH v7 2/3] mm/mempolicy: Prepare weighted interleave sysfs
 for memory hotplug
Message-ID: <67f5ef882b674_72052946a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250408073243.488-1-rakie.kim@sk.com>
 <20250408073243.488-3-rakie.kim@sk.com>
 <67f5eccfd6ce0_720529435@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67f5eccfd6ce0_720529435@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0282.namprd04.prod.outlook.com
 (2603:10b6:303:89::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6f717d-0249-4a8f-78b2-08dd771a477e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fc+iWCKze0yLfAeAO3WwjhLd0Y9zmojrxZQTWk4vRYrC6ppRWtYJ5vFE3rNl?=
 =?us-ascii?Q?C77U6Pty4rmkZsfPI3VcfvSOHXv/cavhSTV0/UKqY1vHOvXbIhNBVic3sY0g?=
 =?us-ascii?Q?SKNVIUlKO1prHWVmlxQjpv7pjuf+SxgX6RxQIkC14Pze8deD/5LA8QxHuwO8?=
 =?us-ascii?Q?uCZGra6Oazu5mqdtMYvpaJUBh8Mk0ONfqPALoe1VeXzOhh8ziGsjqRxj4irv?=
 =?us-ascii?Q?dKUcLSCHLOO4og+BArI8xSuZdjIhrZhsa1Dvr6RR41eHNY1NirR5qHLClevM?=
 =?us-ascii?Q?2Il9UOQnuLGF0go54NVA2f1uRdqm6qiH0fMVk16gXG9XaXX/oiW2rdELj22J?=
 =?us-ascii?Q?nLLR354N3fCh2D+NivjIPhOZPvgHQTuPuyXPxb4yaj0DzPOk8gR0YUETzCFA?=
 =?us-ascii?Q?4SZW9YAZWsN+yLFFzA/dqUUdaSO3SSczxiriWvBHt72uWlb+PytnDfRPHJUE?=
 =?us-ascii?Q?3Vuu3BuyQN4xwScIWjIz5/hYnwjyhpQzwvX5ZoYarvORGOJ2F92C8NHIDxN1?=
 =?us-ascii?Q?zqBqEriLTmtqX/4xB7Y73fiATVOut7ssvtn681WehKKpcz4F9BedT5PiNRpc?=
 =?us-ascii?Q?2QRByDDT2493yrBbGOKanEmJkJnxWFFgD9Qo4bqEZXsXZGtZNVrzielJTHZE?=
 =?us-ascii?Q?atz3a6Bggp/eQ9qWZqRc1nsVguuZ0K6dgUJLFUwEfiNe92enxlLguxe3p8ik?=
 =?us-ascii?Q?TeeC3/8HEtzDr8Pnij2+86lgw3dI5FuZcSQe7lcXQzpqk237HbXmdOr4o6vb?=
 =?us-ascii?Q?flOcplo5VXS/IHLWc9q/L309Nszrb7VQgzFsIAsp75OCUHrt6SfO4DsIFwkt?=
 =?us-ascii?Q?NtWk6y0kYssj00GTeZn7m6BWYUs6wORTvFml8GY99we2qWftj0rdM5HXR1yZ?=
 =?us-ascii?Q?8TE0j/1nrJV2mAnazfl0YuJWtGS5OaYmLNyZBXSSkQwaRGCQVFxp4xPtkbL1?=
 =?us-ascii?Q?5/i/AXowBVyOKhpd6o2o1ORgkOlmH6k+x8H4FwlWKN6QD+y6pCUnMNmxqIGZ?=
 =?us-ascii?Q?JAZVVvoV8NG6nUKNkUVdaJkY5kRhtZrhXODZPgPHf82J/WQJBA5I7n+nOCRE?=
 =?us-ascii?Q?8BaO1dicDzruFMc1fzAlFtP4lcKnSDy7Qj0kybbq+vCXKzy/jNkkC3RBmt6x?=
 =?us-ascii?Q?DLMsZUtlRv9P9hDL8/WN0GeaDUxqGp4jNBwXWL+bzX1GnxkWj6+Z+65w23Ev?=
 =?us-ascii?Q?yAZeuW6EkcQAO3PYVpVdU0lGMItDMN6pmfYegGg3TPf66ctL3BSBQFuEIcFs?=
 =?us-ascii?Q?SpULjRDvU/VayT2W6HvyJGOZQsDY4DFcbOKhGc92IlegcVQG8Pr6PzI7fdDX?=
 =?us-ascii?Q?wB9ClXy1gu9DobhpHFXnnjAOssHtHh+qR+5A5Q+YmYtD5Kj0Fekh5/Mmxaw4?=
 =?us-ascii?Q?rl7cHjkE61EgFQJWrNX9m6RgIk6s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C25LPxDylmZyVDi17WTlYL6XbPS3M2OwHQLShlV2beqq2y5jDP3bDa94CHCQ?=
 =?us-ascii?Q?GQXzK9+Zx6KHXSvJSuH1C0f1x7OUbUPzgThPG7s7QHZkEbeqJ4NEhWHv+GHc?=
 =?us-ascii?Q?mbT7EnjLDGHC1+4DMdCSv3PprsSNEhwhlRAqVWmeF2hGaPCgOv0F3sO4xo7P?=
 =?us-ascii?Q?tTzJwmOu6vr71Sh/P2aMpsp8dy3iyjpV/bPyx0Wf9RQj58p7SNXiG2BAUN6T?=
 =?us-ascii?Q?JG4WV+j8rMD2RzMoIogG3ZPBSNxE/h08oG0rEbm7VTL+/GcgbpfZtZSitMn6?=
 =?us-ascii?Q?ghonbxofHaJThgZX3l9sKZpxckjCHPCXV4puysgCAul5vVRA5ctPMA06e/U9?=
 =?us-ascii?Q?+vAjGMFBmSkH98Tc9Esw014BzKLvlORZMa2bueBpHsfZ5FQJwl+P+Z8iv1A+?=
 =?us-ascii?Q?bOqboRxnw3h9JP4pbwRfgr7qGijwyVNtqBIAZMXaw2IPbYh/V+r0DBp83uym?=
 =?us-ascii?Q?l5/eSZKWeu2/GvsDq5U31Og1Erw0q4qE7OWK8uKl9LgLy5kkOz/BAxds2B9I?=
 =?us-ascii?Q?zd6vZg6TRVwo39FjY7Wq69zS/2IL0uwQjPRGUbF/ajQAEsG28mxtJsaXURgm?=
 =?us-ascii?Q?IWUMDZbinj8brVCsVXH0xbTceNBLUsX7n603KmtZ8Ox8Ez/lpiyKsArcsx9+?=
 =?us-ascii?Q?NoZ8lYSlKlhw/aNZ1JV0P0/V84xCoDqMoGQfK3bMjFTih+eZzUHkkRDv5m8R?=
 =?us-ascii?Q?9zo8neyAvNeZN2ZBcVmmYyqJVFMQVqledCkUHX5SimatIUE8IHgtnF59b6n/?=
 =?us-ascii?Q?tFzzo1jiOWIZcYO+KJM6TkmG3TOaZSNBEzEoElp69jk+KaOq/E7GUNSOy0yA?=
 =?us-ascii?Q?EXa31+DU1B00Q0cvBk9zbD3zus/ZTWdrdzVnGeH7Ts8KSV0o2OlooJOODtDO?=
 =?us-ascii?Q?ZVxq4ui4IYY2QjqPmpBM4BLPmRPuxyiwonsUdbjRILWYmlkngoegZ5C9uwl1?=
 =?us-ascii?Q?huJY7zOcnCxR6AdrCLNVRVZtb/q0ixdJP+AovNmdDQl8KM2eJcxzevA8tVdW?=
 =?us-ascii?Q?a9tj1O1e3PFPd8/TavgpvuUHzKBgDhfR8U1Pit60tnKUMognn4u5ASHe+e05?=
 =?us-ascii?Q?r0x97UHiccZlNDdzYf7CSse0TppYY++PNuX2ce9geE810pleg7QNILviySjA?=
 =?us-ascii?Q?GSVAJWtN8/4l/8Bb69E9mQkwLxwgMHnz6ot3bsTYuqIjp8RalVDSTjCfmFyo?=
 =?us-ascii?Q?IztAmhYAzi+yhN0RSRcv+Nb6DyRKL1dyYeZOtCSBmg/W6AL8pUYmFAIJedPt?=
 =?us-ascii?Q?KL4ai9vfjkB2jM2rqGj9m5bM2Gq2lGvr6x2/l14FG3N3E7n8Qugrgw52uWKx?=
 =?us-ascii?Q?roziuemIOSwwppaXmqkyVuS5ZmUFKh8zi/5YNRs9WNW+vtgCAuyfLJ7f2ofM?=
 =?us-ascii?Q?/vZOc5u+z3mVZV5w0BHhy7YuqybV8LxxepQtTbCXCkDAn2BsNVotLrmsgwAo?=
 =?us-ascii?Q?OU9HpnQkw7E89FSSCM9Vo/1RqWEB7AfKPGjR/eFbEQyxT6YDOL0C+C3p7Jiu?=
 =?us-ascii?Q?Y+TJg5PnIArP8EeNjLJumeDOwMCDKeMiHuFOEFRL1pTdCBQXBjgsZb1kgWbl?=
 =?us-ascii?Q?e5V3fEovBzJvJo6uXxG86Pl/SH7hsuEik2BHhLrjAPGlGhd8SAvkgj9lG9QP?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6f717d-0249-4a8f-78b2-08dd771a477e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 03:54:51.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2e4NJl2znDRA0+tXPwMjtHWNaRNUqArn63UskM8ErQLn/L6WuytXUNinZ/Qj8nOHSyLth8UAdC2n20dDsEYfw10VmWI0pDMHK4zsjFsiac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8287
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Rakie Kim wrote:
> > Previously, the weighted interleave sysfs structure was statically
> > managed during initialization. This prevented new nodes from being
> > recognized when memory hotplug events occurred, limiting the ability
> > to update or extend sysfs entries dynamically at runtime.
> > 
> > To address this, this patch refactors the sysfs infrastructure and
> > encapsulates it within a new structure, `sysfs_wi_group`, which holds
> > both the kobject and an array of node attribute pointers.
> > 
> > By allocating this group structure globally, the per-node sysfs
> > attributes can be managed beyond initialization time, enabling
> > external modules to insert or remove node entries in response to
> > events such as memory hotplug or node online/offline transitions.
> > 
> > Instead of allocating all per-node sysfs attributes at once, the
> > initialization path now uses the existing sysfs_wi_node_add() and
> > sysfs_wi_node_delete() helpers. This refactoring makes it possible
> > to modularly manage per-node sysfs entries and ensures the
> > infrastructure is ready for runtime extension.
> > 
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > ---
> >  mm/mempolicy.c | 61 ++++++++++++++++++++++++--------------------------
> >  1 file changed, 29 insertions(+), 32 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 0da102aa1cfc..988575f29c53 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3419,6 +3419,13 @@ struct iw_node_attr {
> >  	int nid;
> >  };
> >  
> > +struct sysfs_wi_group {
> > +	struct kobject wi_kobj;
> > +	struct iw_node_attr *nattrs[];
> > +};
> > +
> > +static struct sysfs_wi_group *wi_group;
> > +
> >  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> >  			 char *buf)
> >  {
> > @@ -3461,27 +3468,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> >  	return count;
> >  }
> >  
> > -static struct iw_node_attr **node_attrs;
> > -
> > -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> > -				  struct kobject *parent)
> > +static void sysfs_wi_node_delete(int nid)
> >  {
> > -	if (!node_attr)
> > +	if (!wi_group->nattrs[nid])
> >  		return;
> > -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> > -	kfree(node_attr->kobj_attr.attr.name);
> > -	kfree(node_attr);
> > +
> > +	sysfs_remove_file(&wi_group->wi_kobj,
> > +			  &wi_group->nattrs[nid]->kobj_attr.attr);
> 
> This still looks broken to me, but I think this is more a problem that
> was present in the original code.
> 
> At this point @wi_group's reference count is zero because
> sysfs_wi_release() has been called. However, it can only be zero if it has
> properly transitioned through kobject_del() and final kobject_put(). It
> follows that kobject_del() arranges for kobj->sd to be NULL. That means
> that this *should* be hitting the WARN() in kernfs_remove_by_name_ns()
> for the !parent case.
> 
> So, either you are not triggering that path, or testing that path, but
> sys_remove_file() of the child attributes should be happening *before*
> sysfs_wi_release().
> 
> Did I miss something?

I think the missing change is that sysfs_wi_node_add() failures need to
be done with a sysfs_wi_node_delete() of the added attrs *before* the
kobject_del() of @wi_group.
