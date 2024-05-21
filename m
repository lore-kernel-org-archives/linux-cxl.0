Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348311C6A7;
	Tue, 21 May 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308401; cv=fail; b=A3/2zfSM2/AAR7fArylY2ummg/Z8Ybvblqi3ZERLFDmvTFBRjmfzdbiNLC73EwwnS73/tpwCRpHlTt1nwGHHnZw4bqNI6aaDQNRlEyd/cyDjXG77bKFAuesc/VvA1XKTeRFfvPMZ3ZVTsFHo3ZjC8iQhYL5atK6iCp2qPOvVVYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308401; c=relaxed/simple;
	bh=7jWn+027dcWoOci1TjgWrZq0RrxjNF/0aDfjw1QG1C4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uTQDr6O9QekMWMd9qEUGI26MEGRcNCW/oUfxHpFP50wHf09Wmspx9nmYXOOo5gVhOo/u39V44X/SJmv0oY58bgC72fqpUEUhFqizFSh+tcge3PQ29UAv5S84I/W3FB7mKX4ojfbA6DOgiVzu2CU2Hq1tVkC68n8qY4nYDFVOmD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GecU+Smz; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GecU+Smz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716308400; x=1747844400;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7jWn+027dcWoOci1TjgWrZq0RrxjNF/0aDfjw1QG1C4=;
  b=GecU+SmzuKlXcDtxXpxqplNJiRk7ejgjy5800VScghKYSriuxhyosAnX
   ldGrtw/UhV5G7TL2C3AMVqMB58sB5CL3uH3KD4RYYsKlfqbZD+WkdEVJ7
   QKlEi9y2DQN6bENL76LtAY03GXR0YNdpnLxpbcr8odY3B/lneXUld/jQR
   JWrz27e04XpH9DETGHPaS3ltVxaR3JqjDpbICkPIZGloVSqSTMQXbBCjt
   5wTPm9+FePZA1MCTXb4uyWzIGQhrh3k2ataYZkwC0UniQqCUh4nRpb9JO
   o88q6XZjM+1PYCakiL2IMOGiKHcH07O24HWFvAMZxMjqDysJYGc2eHHVW
   A==;
X-CSE-ConnectionGUID: t11vt2RrTsSyOc2Xd7amYQ==
X-CSE-MsgGUID: sJobUIX1TD+/ISlUpl3XQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12631838"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12631838"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:19:59 -0700
X-CSE-ConnectionGUID: hbQnaLd/T/Slva8YttcKiw==
X-CSE-MsgGUID: pkzrJqG/TqqDEmgRnHFZMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32953063"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 09:19:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 09:19:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 09:19:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 09:19:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 09:19:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm6uOCptryHZi0HLpUCK0qPiC4jwd4jufmnmFvK/WQj4PM5znkmdn8DITin86/LWpG6eTFtlP9RgGgV+GcuCYAa4mLvtR47Bh20t9l9FMbArkLRTc7cirWb7oXwkmF5HMKHhMuATRR9URjQQW7Edi3UwxexyTA3Kpg9WDtClokkZoAEzefSU7byozTUBEv5sGLv9HJkkuhQx0mCgjl9JS/IrJP/n+nUr87a46Zo5cDD3de1iRVZgb/L8jN9cm/rFEzH3rS+u8H1sv1uNgjjhDISt1GS25P3GmR8xFPr/zfXXQu0NOGKIcZZDspUpm4vJOl39bR6N2bukwCj/1zRM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMv8dBJGl2CWeQcR2B4sb5zL7A/ouTWlZaGjEDI2i3Q=;
 b=nMhPutVbxZmVGihGvC+kgbNavYmefkPDjZFpg2C9IoEXeVE3TzfBTedcRrNCCx77Ah4RDZdqV26F4IhNwimWK4gvQAXyFq64CbqgkCgEEzGoUWUt3oumIPLs4MbUQlQ5sZPACLFSnFdgHyhCi7QXKCT+cbQ8gZUtlGp2pVUdbqK0C5V+BxoE5U6Vu3H45kI6PH2ukmuUo5a4myvrhNu6sF8e6rG4HzwuKiUaHffGip0ZN+evYmUlGhYhtFs6dgCI8jaG7hNRW4Owv/snMazYwYoaHUy/yBxRBAecM3xI1Bm//EhMeqBlnKJch41N+E03Nw/3QKjdKjHuPgF5Y8bd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 16:19:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 16:19:57 +0000
Date: Tue, 21 May 2024 09:19:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2] cxl/region: Fix memregion leaks in
 devm_cxl_add_region()
Message-ID: <664cc9aa97558_e8be2941e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240507053421.456439-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240507053421.456439-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0356.namprd04.prod.outlook.com
 (2603:10b6:303:8a::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca5d80b-4e66-49cf-d9d2-08dc79b1dae2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o7GTAI4h93snwivMV4Xi7vsh0A4sy8dujmiOXBqNo4Nsi2g30EQj2vgJ0LMX?=
 =?us-ascii?Q?U64IkFBZlq/g9KAVNaPUGPVvJ99yljN0X6A/lUwGOWe4loxpWTvbe8/3Vb7H?=
 =?us-ascii?Q?MMFacZw+5dUwbaStEiVsM9PS+5FVYKnWyah9bH/mHw1kb6xXvRU9GSaDxI7w?=
 =?us-ascii?Q?8C0ghfo3mgw57Tgj+VyLY6ghb9xdjcmDF1Mkvb1uNNyxWQBQh6twuUElY9r6?=
 =?us-ascii?Q?WQsgbs+lXJzFEvoMw7e4d0qjATWlmig7HvxiBigNyxJS6SRZRv/y5yYBNmEo?=
 =?us-ascii?Q?rsusm6TsnBOILgNUKtqL8Qwy7uQIwp1U/GAhbdnE5zt7dhW5WCaIXdOY8+k7?=
 =?us-ascii?Q?GGvh1kBtx01J0tF67U4jnZ2yvRvpjfaYFvj86gauHvXBxuNBw5KOzqBI867v?=
 =?us-ascii?Q?aKQcCUZxAfEP0oEY+LQBcfaoDheqGS8PWTM5PBGfnXZpJEHPyqNb43C0Nrl+?=
 =?us-ascii?Q?qAFv8Q2WwnccY85kMlXL4i/BNLNiC4Sxtnc1YzuMhVkuhAuHJSZV3Cas/WTi?=
 =?us-ascii?Q?4JEBSdbI4cF5FUHtjMr0LyJxGaIXlkrCcTasZgMgWfCwBO6SBmCoT5zOSzJ4?=
 =?us-ascii?Q?+HMi46TqcBvQIFWFzCvZ0NeBxEI4bPKqqXp94RjAsl2o2BAYRmmTOc793xLv?=
 =?us-ascii?Q?Qb4a/p1CT0hd8HjN64YkabXQDppzhu0Ov6MVPh7spYLs9li/qOB/aCbfyntE?=
 =?us-ascii?Q?cLpbKIUp6T8g4jy0cHL2zqgwwnoNgC489CmBll4ZWyR0lyRMZbz7sfGjf3Ww?=
 =?us-ascii?Q?UWy6EC+FaJ/jjDf4gSTRRxHqGdNsBHcBf2TQX17z1WXG4sduf9qBYfTU7V3e?=
 =?us-ascii?Q?vQJSJIHNwGUMbaPgosmvxvPjoHViNs0oj/R97QN0AsJ4rUrmJDotulYDXiJq?=
 =?us-ascii?Q?9dkOmwsDsPQIpQAt8ljoxXKgM6SiMpuGg7kOIwtakZvViTWnOQWNTMg+c57j?=
 =?us-ascii?Q?Zx+OQjScayhMLziciD4u6QEpC87IcExSmz48rtpcJP2nBcfI2mSJf4zbmmTW?=
 =?us-ascii?Q?DtL75AvqSUSkh7xpGAAYbSc+1+HJrcrZRWCQ5xXdr0RB3wxFTiWbs7+dDpLl?=
 =?us-ascii?Q?Dr42FoixCzHwCeWh4YsacWnUclRrZSQjjBmbbB4/7wiImvauJF1F9vo2dFif?=
 =?us-ascii?Q?pEza+BzXCnKvOW7n+N1aGIPZCnekCJ/FHzmHCY3ZUBreKja7qcMwzvVJ0Fsh?=
 =?us-ascii?Q?dkeEf0Eua6ObYYBG3Npm7SqLfMK0L2jufef+D8zszQ/b5baPp4t2s50DcJhO?=
 =?us-ascii?Q?RjsxstxRlB1Jy8bnyEhoupktI02oc1I8CFAJgp+rWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eG119cWFkfowhNSPM65WmFjGoOmf+d76ybwd9osJfSmLReYmNjiQ8qTp4uYO?=
 =?us-ascii?Q?L2iSAiqE9t0q0qNrLjkPRhdXEX6/T/ZWilAQv2kodlg3PLu7p2W1R2Z1yzJB?=
 =?us-ascii?Q?ZHx0ENpZC0AbKBmrg2lrXL2QdKB2/gxFXd9dwfbylE5xlkUwZVybpR1ac8MF?=
 =?us-ascii?Q?XU4iE8TKwJHP7GWrqQLlaVO3000JJeoRImFD34fKf01sQomUQVXD61GyIGlu?=
 =?us-ascii?Q?31D/hByYnmZC5DD47GWcu+EesaK+7vjeTLjJG2PYxKVZ9DPg9ZOBdD8BKhj2?=
 =?us-ascii?Q?rkNmjTq8l7THHoelAPFRF52uMT+bNWET+GWcCYQQJXQe1oTKOed6NfoUM9TV?=
 =?us-ascii?Q?0x5JWrb3J/xEdgASRV0fVVfalFYH3JVLJqXgyaoXtL28Hel8GacW/wBD8TF8?=
 =?us-ascii?Q?vW6AqMCUp/4S8wWQXx+TkDor7gL7iBYVbYvW3Ex0gbBHG4KVgbYbvFNEwNpc?=
 =?us-ascii?Q?CM6z4AEm4/GH/o6SVBZaIDFS8oIAy/aES/AiXwqYEmM/B5djDxklFiBmoMsG?=
 =?us-ascii?Q?mPTCsy9lyORJpoUJShzsVmp3XjsY8gENjaxApvMy8sV/6QSUgpcsEQ/CddtT?=
 =?us-ascii?Q?eLSBuFpo7+jE75P6fxMRqKt5FDPbNoXceBzRDbtXpC9fR5b/MSd8JvUAhZ/0?=
 =?us-ascii?Q?kRoL1NKZRsrZY8L3EwUf6YjRDz3WT9Gq2XYMoKFgK9B2V0DgITIWPGGofNqu?=
 =?us-ascii?Q?1ym22OailXxQycOmwX5i+txKNuZwj8XxNO20QF9qvlJHmBE+0bw9dM3msdVV?=
 =?us-ascii?Q?q2EXObQaq974l3+FkPKnykNetsZ7dlsX6aubxQ2u/Bb5lt0thiKnBDY0/CDC?=
 =?us-ascii?Q?B8pjAanpICNSP+Pqb1SzTETFnHQS+EIJ+7giHWh8xSIvQ5IsJ4ZVVA8J+jNz?=
 =?us-ascii?Q?XXX2szxzmudRcVyavaIbg5dfgNOJ46mvNLIy+NDWZZIsrvostDdw+IQDNoe1?=
 =?us-ascii?Q?AcVJpXHKvOrcKPuULun+Fe5p0gJN8CDm04E3wwhROKFi2M3ZWIOzFNl5x3DD?=
 =?us-ascii?Q?ucrVn+Ssrv3Wpx23L1sAkXIkPQNaNFGPatHunBLcxM9qMt/3pvb2cpByTI34?=
 =?us-ascii?Q?/cDLQK5CnXmL+WvEASq+Ya+vJnG3yfoK6eJp1FlohSnp5cRwoPOq8uzfrADR?=
 =?us-ascii?Q?EiEJlAKK3zYRa1SFSeC32jKf7e4deVAdBwj5/7PvFzp5NzWnt4b6t6mT54kH?=
 =?us-ascii?Q?mmXmsRLGvNIUn2NQ56wcILgXN2vBb05oZs1+mG0Rt0BgELjU9WG8VE8fiSdB?=
 =?us-ascii?Q?am43WXN3hB8G7lSD/esu1O2IN2pYCvTkX/suTkSIaQ9pfPeQ19Z+m5M0hLz1?=
 =?us-ascii?Q?r07J0UdtAFB8oLdzgl/bcZ7IDO21iUVvnV8b9wleAOxTDXq05wcR5+s6aTkC?=
 =?us-ascii?Q?ruXLpzKRsEQfiw+KyvOzvDAaDExRPdOQubRhOW1m/58nl0+nKF5upLT4NHYZ?=
 =?us-ascii?Q?X/zeCnNZ1/CLghLNxxEj7X7aLbelSVeNMvtkkr3lD1usoUZ8qRlAXxwHmY05?=
 =?us-ascii?Q?IiLvrEZcDA4MYYSR1+I91JRFWwh5uD6AICqXDp1FKJVz8/7K7XcFau+iguqV?=
 =?us-ascii?Q?RVS24V89F8CHjGgzQIKhHKcFlQS/OiytQ7wWcFAs+yI8wDkc4CsJH3O4piJz?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca5d80b-4e66-49cf-d9d2-08dc79b1dae2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:19:56.9629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rn78x2QwLkboIOZHThdHSbeisx7Ovu2EkfaA9PZ/xgPPZJXz9vuHK1cnmXaMjNz84yw1SWZdHfuvvyhg8RiJLWiTHQaFC5CXP8lc4ImDy9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com

Li Zhijian wrote:
> Move the mode verification to __create_region() before allocating the
> memregion to avoid the memregion leaks.
> 
> Fixes: 6e099264185d ("cxl/region: Add volatile region creation support")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2: Move the mode verification to __create_region() # Dan
> ---
>  drivers/cxl/core/region.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
