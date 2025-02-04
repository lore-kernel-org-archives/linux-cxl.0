Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7D19E83E
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702342; cv=fail; b=kbe3rp+zKw3yF/R9emGWkrDU42aiR/yAc3fb8dCk/P9V87C0stY4AJOBqgd+y2Iyz3N8e0RlNGNRWTeLlAZXFiiixAfEzPTr1oOW7I0kkiBb0mP9TnBvs4ctUGjMNTVk6L4wd1S1RVp3t1O0tGQgCkK8ZHR/ENSZ3Y3mE4uscCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702342; c=relaxed/simple;
	bh=jrCSoGd/KCCXZEkQ0N/i6sb6ns/fZ/dNrdmGQgZHJYw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PDAbi+OqwE2E1/Ixn8n9dlIputzYiEPP1WKw0LMq89H8IlOo3ZxK0Qp9RcjwLykOuLHV91FCi8zh9Ts7aWrazPi+Uwrth1gPZOF6V9dbcrORYVyjeJ9QJgN3CSxJ+7zifQUd885sYNmApE+S0r0HiYzQGUUXqPZzALZQ09ziRPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COjTr4IG; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COjTr4IG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738702340; x=1770238340;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jrCSoGd/KCCXZEkQ0N/i6sb6ns/fZ/dNrdmGQgZHJYw=;
  b=COjTr4IGlnJTRHPzqKskdgsRpziJOomKzHMoPgj3M0K6vIQ9VM6Z+gC6
   l8Eys6cw2m2onx2bSWys643sE7F1GWKdeH6PXAROde8aci1VeVIj9GDwM
   5o3HGWF8Yc7K+Z7a+0hmLjSix2TUosuE2LWPxMR01ECZNoSs+IckNU7Ki
   euwyq5arYYY+ZVWnyJfFS1nC95p1lEAVNhQdeZRN41EMo38BO8otI/Bw1
   3gbZnelz+RZTFF/SQnrHjRY0ZdN600xAmzh+kc5pZrJfcv9pJtXyKJoxS
   w5j9xgCsKuG2C+qPvGCtU35ONd/hUaQAdzcRsQKE9H2y38BwetOlkgV8B
   Q==;
X-CSE-ConnectionGUID: ISiItJ8vRHSGSY0SiljC5A==
X-CSE-MsgGUID: tbWgOgdeQG6dJ1JDPsLc0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49865973"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="49865973"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 12:52:19 -0800
X-CSE-ConnectionGUID: wnK8mN+FQB2dIoKWdu7syw==
X-CSE-MsgGUID: wXx5HosLTp6ELIH2s7pglQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115891931"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 12:52:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 12:52:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 12:52:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 12:52:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNNU9JYhMaPKUwPTmyku2YkoPC1kRk4H6ZOLemqTL/KgHnvpRD2DVLDM8pO2O98vB7seBxbJFh5CvF2zGCYi8pDdvS2Qy6DAC6f8gG25n5cBlTP8yAqAR6uYa4PUG3rbVBYIo0J/0GXmousA7Efxkiuvg12baAYn/mdai/q7t+UT5RZ6aMMWZ3wQmE/3fV64meLd7aDk9YZcokaBPfbus17FdSqsCnaheqPFpDB3N0046QNJ5vfF3E7g1KD24LWQXK21tGF0D+BSvJsfuULTxJ5SkMXbZQts4gCcla9/S3EHSv/tnTE37+cK4CB5k6kMuQiYPeAyqol4mK5F7xV/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GZ9O2VOYDtA8xlMHfHICAeC59K73CiZa5ri0vtyeRs=;
 b=RhTfSkVJFmPk5lvL+vPWqLXHPQilgnJ0Ja3WIxTTzuC4UxrrIx8dTOgsEqXMCS2qIs+zBw7RDn+euYNkLIv1taizwLkF/4z6m4iiIW2nMx5nF84TDjKQPyUeGxLi1a0mMl5ZLNMo5sRllCm/iaAezTWgn+1ju1RpAWNcFioV/IRlHZNLjo4RideG70oZlLrxXAHLzRBDrVLrgbB3eceGgJOlJsxfc8BliiaUQaVXdXpzq7+gk7reGiNaL+MiXfk8m/aaT5vbylCSb56pSUrI3a5XH7+ykLsiTCVM6PwrFBuGeuLQCm8TWoMQbWREPPiJtoe38RtVlv/CuU2eezLpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7661.namprd11.prod.outlook.com (2603:10b6:510:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 20:52:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Tue, 4 Feb 2025
 20:52:14 +0000
Date: Tue, 4 Feb 2025 14:52:09 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 6/6] cxl: Cleanup partition size and perf helpers
Message-ID: <67a27df8f3e10_2c83e029413@iweiny-mobl.notmuch>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
 <173864307519.668823.10800104022426067621.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173864307519.668823.10800104022426067621.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:303:b6::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5356b1-93d0-47ff-3daf-08dd455dcd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4O/ny81NhNOabyg2RHHBbhxwk/yllqRYbBIeKyMKzgwodil1Pv0MZColKbk8?=
 =?us-ascii?Q?HAJ22UxaWMXmm//w1NGyAP1Jijpj21BfiYLIqFMa+HBiAtI7Mbib38trMKdx?=
 =?us-ascii?Q?cSy3X4DZkqJoEw8UWyed67WYH1w5qjoRPqx1u9z+NlLX4XZQ3FDoOx7YsbYx?=
 =?us-ascii?Q?7azfgRFM4eQrXSsCwc4gqdM9AENVKp0Zo4ZM/LcngzDPiQ/spKKdGykno1Sd?=
 =?us-ascii?Q?/tyCAUXxjN3lZSyRl9b/nVi30DCDl3jbWRi1cRsHEmgPNBuNoXUfEFsh//pT?=
 =?us-ascii?Q?yChtIcMtlrUyuFrRvUkZ8SCjSR7i9GZUuXCmnjgeZ/XuOJ75LpM7LSm5/fCh?=
 =?us-ascii?Q?n0tF1X0mreG9Zkk7WFQyuQTZjdm3VEDvzcnDx4W5PUEv01/sE+N+9AzBbLLK?=
 =?us-ascii?Q?xAX9y9z/w/9axQAwVhzvrL07CJeW94aKsYRoys9uFB2bb58XDM1id92ZEzn7?=
 =?us-ascii?Q?wp5s5Ya7oCuore4GFPnaJsZvVvteNZdlw7S0s0ZA6ojShRSosXOdTwWmVRkC?=
 =?us-ascii?Q?+S95pdiaCo+J9zOYgh7eYSAMmPICouu4W4WJRXncKsING5ZMt26t8otqxwGE?=
 =?us-ascii?Q?dkpXFcz65LpNSTM3hCTtTF/+i7VADVV7q8/sK76jyJ62CnVIwI8kH/1SDTkD?=
 =?us-ascii?Q?Q8ujhHgqXBdYSVJCzuufgT39y4Y0RRHUIskBsWHBw6bOl8LWMozFnW0VaBH7?=
 =?us-ascii?Q?3MJHDKn/6Vo+RDTzSKv3Ddde49pSRTlm8TDdWian51LUl/TfAO8PSyFC34Cv?=
 =?us-ascii?Q?zGVs7EmAnd439NWX2mZlzPEJz3hsj9/MnU49StA4iPzAIrZIShhrvM+fcd1h?=
 =?us-ascii?Q?wPct5fN42kAZfbdx+Ez78gR1XVa/knRIOyPQm3SJQ6EFvB9i7PHggTXVLDJ4?=
 =?us-ascii?Q?FuKHDliGPLat2r0yriDracDM73WhwEbefIZfMOk2V6GbA4o+3V/k+WVFje8X?=
 =?us-ascii?Q?iwJpO/BFxkE7Ud+Jn3t34iSvwVwmLOv/v8v6XsfWXG5QplD5JL6oK1Uq2tk8?=
 =?us-ascii?Q?+FrmvpWZFYL661yB+KFBBYsbci4RfX1KcYHCRfQs8CqZ/w89Yo4K9uAP16hK?=
 =?us-ascii?Q?yhG98WpsV9MfQr8aiJE2XP2Ouk2mZgzJI01P33CQ/cWMUd5Erz1NdUov1wMd?=
 =?us-ascii?Q?5AWeIsuxhkc84zMuVrbcMA8T2JIAW8x+9xheuX22bT0h4224yHdSTDzneabY?=
 =?us-ascii?Q?eRGfSY+rezSJEOXGCrHqe7aF4SVgFljNevdGxJTtHgn+8huaWm19FxLsX2E/?=
 =?us-ascii?Q?pt9+yBpN4CmobOUvAdzEKkEWozAa7SJ9Z0C560D5eWsg7+jIu2Wa7MjWg+l/?=
 =?us-ascii?Q?yXIdVTYj9vHreqTbnORKRNdlHG3JUxRoQiQ7Fj7wdEgmhofMKjy3mz5oeNq+?=
 =?us-ascii?Q?VAqxD5uFQqWpwCxXlMvLBm8hs3RR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MOX5mrpAnnxGlerxXplL7PlSHoofi64VMxFea3Kax6/8Q6rrZKPRLzOZoGk?=
 =?us-ascii?Q?Z3NiAelGhgv2KNXGz0mPsHzRbmJv6bt50VMh98WXVfiAm572svvUPkdXRW4D?=
 =?us-ascii?Q?Y/ORmnMawzFVC6h63qLcqHBDBdMXLbzzNlvU4Q0zEV39f4+YZ2P1pPNXamF0?=
 =?us-ascii?Q?ZWlafKrVcY8ubgydGE4zF0PkZvmd+PI8/p7KvIrtu5j+nqk+2G6Z9gF/a4xN?=
 =?us-ascii?Q?U/qtx2WjdGT6w2ulkRYII15Y2BVAc/GmCQ7Gf3itDIBy51uJFKQPJxehQ/dc?=
 =?us-ascii?Q?b5YOMQNd6xleH7YHvld6J4M2ztI/1K+HmnheNTCb3E9fxtpOZSK407sSWw9D?=
 =?us-ascii?Q?wIQ0MvWOLYUjS/1hjrUzFMM2jYeJ1SP6KKeeSPk8djvJ0DgonBmPPfbUXApg?=
 =?us-ascii?Q?9UvnkhX5hjCjsyOMDAaTPedJSUaHDvdbOtk3BeEN9Qxzw4CBbr9aqHUgG/7A?=
 =?us-ascii?Q?70ITOudShxU9eIFKFqHJ2LZdymOdvlyUJy1/atgatyBYbKCZ6xZsBJ2NoJdq?=
 =?us-ascii?Q?420L14rKvQxcAxrc4w4ZMgY58CH0UT886AHP7KTg3hoTXPUtlucqcHoYnoED?=
 =?us-ascii?Q?TBl/zwmgAjmzVm33wBA4iL3Ihcwgip3Nd5f1qpoahvKJmPGhAmSuhYl+K5Y4?=
 =?us-ascii?Q?rSyRzgaR2lRk2AGNmaQIkUt/jILi0n+Lq/8wUpuKk/JlVhnbYkDHCigoG3Ff?=
 =?us-ascii?Q?cJwtseDgHbPQKoMOvzCapXfjC5HQ1vJ3Y+vc6KlrTQ2uU8Vd72Odg5IbOOi8?=
 =?us-ascii?Q?24Vh0ASmGrMvdj0gSi3LPEvKGoTBV0J2+zYd6Z6WmADkb2SESIilUjf5bP9d?=
 =?us-ascii?Q?3bWL1P8dTdYHGIwTCf/0rdpMp/jcjHVG9Jy0LR4nDxaNRiO9cV2Y/3niUKdz?=
 =?us-ascii?Q?M8JC/viyYSAvbM5hIHKH8O+/GfBKOYtGtJVJE6C46iCPKl5fWyaYkX6MWgNC?=
 =?us-ascii?Q?4XjH80NA+gSa28dNl4Meu8fsPwtHyG65/Fs5G8m/1Q/M51JipD2G/TfuYsbJ?=
 =?us-ascii?Q?oC57/AgGDwiQ2ZBs0YnucX3qi0pvXGuXgcfFKQiLyfkV4D5+Tmd7YLCESmSu?=
 =?us-ascii?Q?e4+soYS6TgfGUTETHpjAceMygL2XpeuVEmggy6fX1PXCqhlk7tPanKrlzvS4?=
 =?us-ascii?Q?6hVRvjBydxtSLrni/OiITgK/5d2zHTOTThGdl5ybZ840HRLDgeQ3nIjlChTL?=
 =?us-ascii?Q?9fzmQRQUiDTLSr8aH74KZlbRAxGch1U+x9dzojmb+tsBw0gLiR+uvp9Mt6pf?=
 =?us-ascii?Q?tsrhjnuH2ZDz7EI4x70LDG2kCOPHOc23prFbF21UNXykq1cXhDthpenAZmQf?=
 =?us-ascii?Q?1ywd8uiQEuwykzzvIqZRJjW0xdTKu4p++Z9gHwMox4h7YJL/rxniICxFphje?=
 =?us-ascii?Q?1/mdyt4LLcCPkQWRUYe4495+fKV48aysg++rk/HxdoO+fn6rZtR5Su5mnCji?=
 =?us-ascii?Q?KHSMJtdMER5xosHmoAkWGd+HYFwZFzrrbJrV8P/xKXppD5oeNds7DEr8GFFU?=
 =?us-ascii?Q?nNrfnZVEzYKrq0CDNdJnANyWVzEiNPGf6CcwBi6qR1Cyv/eo8gfTyUeUrzFZ?=
 =?us-ascii?Q?9vOgfrUekfjtLV0SNk2X1BIxrR7bdaOF2xrFtFO7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5356b1-93d0-47ff-3daf-08dd455dcd88
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 20:52:14.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bD1l+s2lNXXES+Df5gqeG+ELgo5gt3ZY8yUwHAsfH4ZytxPCBTXh37Rr/0ssme4s58MqL74LxTvh+2h4LcHygA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7661
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Now that the 'struct cxl_dpa_partition' array contains both size and
> performance information, all paths that iterate over that information
> can use a loop rather than hard-code 'ram' and 'pmem' lookups.
> 
> Remove, or reduce the scope of the temporary helpers that bridged the
> pre-'struct cxl_dpa_partition' state of the code to the post-'struct
> cxl_dpa_partition' state.
> 
> - to_{ram,pmem}_perf(): scope reduced to just sysfs_emit + is_visible()
>   helpers
> 
> - to_{ram,pmem}_res(): fold into their only users cxl_{ram,pmem}_size()
> 
> - cxl_ram_size(): scope reduced to ram_size_show() (Note,
>   cxl_pmem_size() also used to gate nvdimm registration)
> 
> In short, memdev sysfs ABI already made the promise that 0-sized
> partitions will show for memdevs, but that can be avoided for future
> partitions by using dynamic sysfs group visibility (new relative to when
> the partition ABI first shipped upstream).
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
