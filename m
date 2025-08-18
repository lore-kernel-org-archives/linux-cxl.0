Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBED31B101
	for <linux-cxl@vger.kernel.org>; Mon, 18 Aug 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534460; cv=fail; b=dc8mSM/YnvwMf/VIUnPfxOj9tuvk3ettz5jCaLkGakInGJiCi6jAz+6rd3o6mNQiP1sFDX8HT0PUCFhWvpEd74RCqd/DJKsbKu1zXGLyqcnOxGMFFImZID7dzor0/TSNnspCCtcmZ46hBZILuGgIIqiOnIpPmabpHu5hFMqPiD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534460; c=relaxed/simple;
	bh=IZQqr3Vj25dqZcvm6XnTRi+hYt8BQ4V5yHmL8lBOwgA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y8wZ+Q/iWV4pwCXpVQ2jyoxUwijaIatTvhS58Nnl+f0TH/uWACJXKqoe5OmTqwfoLTiKpC75yC0e1CBJbvKX+0UDlwrUJ/3bY/ceHEvmKlFKkpjucEk+eKK5NDtFplHFsGfFWOD622JFiIPQdGrePBMffzPHS7gf2GywfHhCACs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7NeAK+L; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7NeAK+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755534458; x=1787070458;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IZQqr3Vj25dqZcvm6XnTRi+hYt8BQ4V5yHmL8lBOwgA=;
  b=I7NeAK+L4tUB96h+n7CZFnERvAOD/qPyLXM+Oo9Gh8xKelTdF91YYZcF
   HkGJclgD+ww2XoJWrco21EfX1cS8vr8n8TpZ8RS5LaJAVP9ma6iBcP1Xf
   lLpEdycwapxUjC1m84xQFg77zb71AeZUELUs31++YuXjA/kMhabkffZlN
   nmv8MeVSd6y3A8DmANcpTZE+umXYS6puveiACJ/f9H1bcobVD5w+Xx6Fh
   OurLHX+dQfWrtuiotOuTAL/mxSTNjT98vijZLql6gv9iAtmehzVtw4cI0
   +C6TymptQXG6VlEUAJ90IzpvjNh++KaxOX+tRt8pwa5EXrwaBe/O9sgjE
   Q==;
X-CSE-ConnectionGUID: PzJTPk0jT5WSHjkPn6ZQiQ==
X-CSE-MsgGUID: pekBaaBtTACquPaJfRElow==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57870242"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57870242"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 09:27:37 -0700
X-CSE-ConnectionGUID: OOGtl8yjS+icdlt6dWEYtg==
X-CSE-MsgGUID: agYfD0IcTtOHSXjY5FvB8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="172042833"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 09:27:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 09:27:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 09:27:37 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.66)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 09:27:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLabwAHCNZ8AKTskIYBxQUDdKG0xaDIkdaSDfY3Cr7vp8txTcdzi+u1M+L6j4BjemhKYJsyU3uHLbdXXb8NV8XuBrYYeP52q8Deedob8NYh6MsNf2aUfHZPSeKkfdIMfT2yWUgVgDrsyu6cuGY5iMspPemDXReQrd5noR7ZWjCoAp4s1nkBNfMyAFklfTWU0j67Q8d/9bp/ah/ZcrBVZ688wy2hNuL6oow6Otsytg0V3oiJ7szAxjmf+tUPnysladFkVluwgWOeUrBh1MEaAZj+taB1qsgC8T8rSYQFSsEV5gUEbhWq1qo0KZL/SAntYIJizruo3S2NKmRHZuKFrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITmIZw+mYw5Qnvd31CO8DCZOKeDqhlSmgkSRsaFVK5k=;
 b=nfCsN4JuR+wvtp/5w7/UVEw5Umq+HhgC8y0alIt0EfIvs1EFErij5T+B8Ct6KqV+fboq2+cUlzpNDDAPgU5NfM/XqaV7x8SYtq7NUEbhONHDn4F/nZXt5lTLZRIRVn2APvMGI2fyHGB3THJ8nYihS/Q0A+NidHi2YPm55wszXnYzeSsEJ/EbLcwAoem8UX07bfPZ/FREaYXBZj+yDm0X2EvTOkidplzXHSM27LBEY288o9hnO0ofG5WcGNbjgKSebOq51RvYlJ4eEe9ki1mUKZ2CIibBKyUZx16nL4B02m3LmO4g+6sbmwK19WoTOM4VXFRM8ACWlPcI0asAnjJSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 16:27:35 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:27:35 +0000
Date: Mon, 18 Aug 2025 09:27:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, kernel test robot
	<lkp@intel.com>
Subject: Re: [PATCH] cxl: Fix emit of type resource_size_t argument for
 validate_region_offset()
Message-ID: <aKNUcy90uIHy6iYI@aschofie-mobl2.lan>
References: <20250818153953.3658952-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818153953.3658952-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:332::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f7d2d4-e2c1-4a63-ed51-08ddde742380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8lPStf+PZVzkibthGFGF+qw+M7EiscnOVAGIl1vmJ6gNoPfig+bdOfhYSA6O?=
 =?us-ascii?Q?5bJO6nSf5BIyU70qPihMuoE2aBXt5dV+Vehy/t1PYKLsG5o9CIcuR61gCJ/T?=
 =?us-ascii?Q?gOEHI2UgHtvJahBuMO55+bD3N4x4QSrsoB7SsHXFYSw34icOoFyaV235/POm?=
 =?us-ascii?Q?/qsZUkt5trJMDBBDt7oDzq6xmSulOrPhZUP1HPYXBD8uHpt9wxR8oSQhUXV4?=
 =?us-ascii?Q?VBY1w/i6BVP8VZev9yNPL5T5MWVXSkggFdsxnxrJn8ySbh+a6LO8riKzHC0a?=
 =?us-ascii?Q?vpvbzIr91hqtq/NwF3A27pexrFkBIT4oZQ0YiMInZdmk91PcHkHqt7lhUz1x?=
 =?us-ascii?Q?UPnWLO2YbHcQT5AyUkerb151YBXqVUx0xFakAxxcRX0b1y6gMo0ATlZwkbuo?=
 =?us-ascii?Q?NOJoqIDOIuq1gROn80nhUue73r5rg0+RkVnPJ6w9m9ElGMGfNvqYJ52ycQ3L?=
 =?us-ascii?Q?O3FdTFrt94ik1l9glqGex7Za2JZTkF5z67EvBSp7/vZGJQSXQke1So/ZmN8j?=
 =?us-ascii?Q?azCH+w236AvM3f8jnZ/qrhhJRl8stW+iuHTD29e9fiAsontOoGZkh7qFAY7N?=
 =?us-ascii?Q?l9QIvLu/ineGdsm3vWDDch/YBbKVscnLVqht/RbpfFOUdgJGxTWBV6593UfL?=
 =?us-ascii?Q?mNxeGMgFoWwYnbM4bufVOcgQngYxu/6CAZmDzkD2Dpes+tLU2tVVsHydBSi4?=
 =?us-ascii?Q?2bM8zaUJn5C7/RTyWK/RWRHICG3bIzGXaEe5naHnN47YgY+ynGtjXLRyzy6h?=
 =?us-ascii?Q?dVP/bCoanLIrJE3IkwNA+SSQWVBr/tJrkdJTv20hNBO169N+SnAhwSdWO/RY?=
 =?us-ascii?Q?L1rqE4N78VhE93rG07VJSGO7T3VG9E3qg7+QrvCSuWdjbX9PAFcImhS2BwkU?=
 =?us-ascii?Q?8pdfOBHBwWA1Nma1xmT9A2+JSa8QqtPa+QhbcY5UnRoqTOU4zbg7DcivhdZA?=
 =?us-ascii?Q?Hv+bLSTjDDnHytBBsznUGRaf6WLnvLr46EBi2o4+kC0oKNqwGJWsYW8/M3Ac?=
 =?us-ascii?Q?+doeeGbCBKRHIhuvUQKGghKQWnJVUfvv03R+6ghsFFS/06+/JepwSvw2MQKV?=
 =?us-ascii?Q?p2QKkO6NMOJOMW6LXwJApQHTCgNneUtpEm0yv+I4EiC6CkyzmX7F9eXI1A0I?=
 =?us-ascii?Q?BwJt/rzU8Jw0w8Fc1SBT+xmORWLBr8+EyIVoVDsFN3uUFk0togn21Hl6BLVK?=
 =?us-ascii?Q?591HpkajbkleKELyBRMmurGA1k633US3URtPjHEg4Beme0nZsCE3Zpo2GZTu?=
 =?us-ascii?Q?ldtsqwP5RN6wZYdpT0ubRYmbWyNSBQYU4W45qWd4CkMxmTuik6KcSZKRohRV?=
 =?us-ascii?Q?NmbtzcYauO0D96RiKEfLUebshYt8dMqHCgDnSmbZYry5rzPMFSxGUH4SPhix?=
 =?us-ascii?Q?5xC8BY87UkDAJpjydl5bWqPOIMawoVTM4mZWIkmJdlz9xfKVXjT4Cpizy9sj?=
 =?us-ascii?Q?WnVpC0Q3bbY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3oNKel845HI5xcZqb6iPcGAjBcB0sAUUxcTuRwN176LtZJwGf4pjulEqk+QI?=
 =?us-ascii?Q?hA0grffD4EHuvS/k3Ur/ocYN14KEzD17qvn6gm82o3jXmWw9GTUffpCClO3H?=
 =?us-ascii?Q?NTuz46DnxDs9sd97zbO/KbFfrDsZcunTwDgfyURqvtjUitDJD6XBWEjHql2Q?=
 =?us-ascii?Q?yh4ed4FKVB4apm3Mgw7vyVwuaxuohvlPAw+uFDou994CF/frc6GqMCBxThQR?=
 =?us-ascii?Q?Byj4OFcrKfVpQbAIHgEpSA3i9y8e7tHCoEij8WfyxqhlDDu3/WH6PboOQWHW?=
 =?us-ascii?Q?olQYIsTha1k57FDDsaOgsYVTraNZqzprZHBOHKE274MsG/ma+smzVCVoZKdY?=
 =?us-ascii?Q?/BFv9EK19MHOVA1bmfBYvjr/4XmRxAg0u+6gKgfB3VZ6yqTl5UHMSctZE85m?=
 =?us-ascii?Q?uLhcwmKYerqCDcX2DOZ5PWeIP60ChqViBogIOhSA1uQ19bdbAhRx4rd0p8/7?=
 =?us-ascii?Q?T27KrF/PIe9dt0T55fWL2zCn3njPNBqgFHT1kllilr7PJ8Rh73GkqFNVQ2+6?=
 =?us-ascii?Q?DBtPtHngE49uK+Y1k1v33Ya985sBY95ndJKthPyEfa5/Ortp4ZGdFgxc1I5I?=
 =?us-ascii?Q?STJi0Y2+r1GgZUxwC/xhVn81wyueMGsx3rn4jFvnw6HQXV3txuxjerX03OPy?=
 =?us-ascii?Q?eoy4yEjV2R2HL6AIbNOjDIDM0+WVI77/zB69qcsQ19CWdOx7vhjJWU5eFBlN?=
 =?us-ascii?Q?zJNY4WrFRFPLFLYERg5aEZOU1L/I/KCofez81oDr9wHC7/GImJxDmcZhKsDe?=
 =?us-ascii?Q?dY1xeGSVTV7bS6J3RAYuQPz2RxgPu+LH0R9I2eWOdjyTzM++tRpy7M/JnFQ9?=
 =?us-ascii?Q?zbfEBfd4SyOGkWsHs4ZDuN5izpdrR1f281pTBhzBcgx6AEgCcB6T7wcW1WsT?=
 =?us-ascii?Q?u2NOL1hvrDPESvBa+T7aqu+nEXF7GSFmO6LW6JXCLdr8qdviHivoJ5vz9egt?=
 =?us-ascii?Q?yRYdiQmKd97bujYxOPQUaw5Hhn6XjJ3VJayPE7iYZWkGc19KcnwGOAb+Ng4y?=
 =?us-ascii?Q?/0B9DLoF2/PsrfTL0rQe6XCRcov2Ecvn9xxfWNNuelhp/nOA8ZIh2aaXfIi5?=
 =?us-ascii?Q?3SJ1A39OX8u97Yumg8iIUPElrmKRx+4yaEafJolwolexwSobdrr1X1IxKPYX?=
 =?us-ascii?Q?lcMECmSM3y6Q++CBYCLaMwUrwifii6oMrQH+iv8sD5D8BgIdy7qD2+xc31VW?=
 =?us-ascii?Q?3PSr/kKTTMnneRStuzJXFFWQOATJbdHifZ3uY5VbS2+IsNS1AD98wshKV7cv?=
 =?us-ascii?Q?Nu+dgIR4DXJarz6j9nqLOLzHEV65yvXOQZmxcvO8hDy4NOvsqxsoX1hd9490?=
 =?us-ascii?Q?uTnYICcgc7Bd/tGyLXTG4JpzmNQ/wG+MGBHrKrYeNv8D7tqglL9auMlprRla?=
 =?us-ascii?Q?mKKYmaE+0qRDD50UZFVXZR4jmSkr1CTcPgqQMIdNk0bgYDx0LkYq3OVWW8qy?=
 =?us-ascii?Q?Sm8Mfv0TOsMtIHdTAWg7Vwp2VHP8YPxFnDKU0A0jlXCGXPc4N9zuIJpttLXm?=
 =?us-ascii?Q?9hlu+zNEYRcHobbGa1s/QcXzuc7viQCRykV8dSk5d+LbxW4OLjc8tUvPifuz?=
 =?us-ascii?Q?NuiYNWpoRjC4q49E14jpwOXTg6mM4Cr2Bb0e3HKDhAw02ILfo/DXhkPdclCo?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f7d2d4-e2c1-4a63-ed51-08ddde742380
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:27:35.1840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rd4IYTGtReM6PqYr+khYd6bdorJ/XomEv0b15rtDoyH/IgeRvLz1NAQQtnWqWjtmNT8/k/i4Vi8UPbH99zDBaQUksVRA2OYlUJd+yd31ydE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
X-OriginatorOrg: intel.com

On Mon, Aug 18, 2025 at 08:39:53AM -0700, Dave Jiang wrote:
> 0day reported warnings of:
> drivers/cxl/core/region.c:3664:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> 
> drivers/cxl/core/region.c:3671:37: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> 
> Replace %#llx with %pr to emit resource_size_t arguments.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508160513.NAZ9i9rQ-lkp@intel.com/
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
