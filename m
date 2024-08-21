Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD01779BD
	for <linux-cxl@vger.kernel.org>; Wed, 21 Aug 2024 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276276; cv=fail; b=CAD/QIkdv4kbwwEHv4LlKgQeYCvU5EysP/Npz+JLpSeOlPg7bf1Z8SRp8XuaLkTT6q+62DeAqLEjSTX+Xxe/4/jv3+jLYuEtLbopHL7S3A1Bwu+r3GVFimyf9n+6fg0S/+VJvDgmgvdoo7wgfFdFm7kvYVJDeCIFel4Zi3aC51k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276276; c=relaxed/simple;
	bh=SW64CAdCwQ+9ng66x1jwFnPY4/+ZMU4pBWpfgTPWpX8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FsB38ZGjXjH1JMkzNjs+lmbZTS0WfsNvnZLTf/5zyWPGHcZrodb7q/D+pTTpG313H33xcpDAsEg+jMSacjJBSFGv9gWiRAhZaFPowuu3JzXcFbyfPdnbwhKIEnw/1ZzN9X6tOsD8rEtNvuiNNgJlHAIZ7SXR5nNDBFlX4Vteuuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJJmi0st; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJJmi0st"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724276275; x=1755812275;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SW64CAdCwQ+9ng66x1jwFnPY4/+ZMU4pBWpfgTPWpX8=;
  b=EJJmi0stj525yfdm6lOSVR+iZgabzIEj3d5pb6axIwtXbBPCapymsH6n
   13LsKknc4H67YTAXS8futsWf5Ub/lgEyHWOVNMQlsVVt57Jxu/tbRNPbq
   LnfExxZWp3lCpq4xzdTeU6dhroBOAgTV2tx1TFrw5N4c5NKPOdF9Fjtzd
   ZwzsUPYbHbc0OkIjnac5i90jZTNZHvKRxJwR+mwpMKjccw87dFJWd6eRJ
   gjO+xWQAmEp6FdEhfwXk0k9riHaH3bFzI3YvGcjpqNSLfW/i4S4yN2YRs
   hOW+OZWJsunoBFi+UhL1juMq4WeiokPOsZht+gdtjM5In1Ws+mt5GolcJ
   A==;
X-CSE-ConnectionGUID: Fh2mABELQEiq3h3WQNqLbA==
X-CSE-MsgGUID: 2Gg5bKwYSsmu927/UdmKGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="13142898"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="13142898"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 14:37:54 -0700
X-CSE-ConnectionGUID: ylmXU8aWSuuxI0bo0xmFRg==
X-CSE-MsgGUID: 1wkna/PXSUqBSBX9wcDcWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="65918325"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 14:37:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 14:37:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 14:37:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 14:37:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 14:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jL2CiU6H2jrTvrPE2FYlqEH6oR7rPuk+tj0E/5XaBH349aeyBjLyG51MLdzQ4k7RDUjZBpOv/5GTLu0kl9ZebPtDmkUW3H8MiQGCp5dUKtQ7YN97YQhowLLMjFPD9FIOnLl4rE5IV/XsB56bbHxY6rz9tsniMaD1XxBAeYTifXUp/P0j6w3RDmjhNm50TZVT/FfV+pLir1lCsiLpaU9L84N7SdEeuXDLKrNZa6UFJeKbcpKAOfKAiy5XCmM4RDSuOQUnUBZnVtgy7l15UFKRxO3FUVLcx3ztnEixDrZB4hbGdLU5jk3Mv5xxTPbDSar9+xGrnLS0QtnvopZg8QyYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thSJcJ3vjULeIh0lxZuMOUbwM3SYIP61N/ZEHo1n5Dg=;
 b=t2sFiwTvZvq071820UFXXlQgHu/Lnp4PetCRnyChkiPObqVMyZVhktYDwqjIvgI6QJ7FFq4/WUKY7tySdn8OVFLoxRvPI1Koog4CceDTewktDTlAb0EpY206aCYxg4Tsou5xkj9JTdzwp6mFKKFOPH+1PtfTGj6cCW8f3GBlAkPDJVaWXwXvZ5pR0Pvfb5IT0E3skv+D4iNeXymv5/LXYMXPVK27hWlMTmgDgzU9aNoozo/ZuByr1RM+7ZCZAcoaet63yqjFjERTdgTx8IeQ/yNXWfvaV3/3Ny4x15O2t0H/7zMEvIxosfXLAw2UXdHzJjl4raEBKvLKPErARsvKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 21 Aug
 2024 21:37:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 21:37:51 +0000
Date: Wed, 21 Aug 2024 16:37:45 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming4.li@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Li Ming <ming4.li@intel.com>
Subject: Re: [PATCH 1/3] cxl/port: Use __free() to drop put_device() for
 cxl_port
Message-ID: <66c65e2917d00_1719d294ed@iweiny-mobl.notmuch>
References: <20240813070552.3353530-1-ming4.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240813070552.3353530-1-ming4.li@intel.com>
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: a27063a6-61b5-4001-f777-08dcc22981e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UM3ra3MIjmYiBPVsu6WfNbd5G9n4Fv9nGpIxZZe0DYUkxRaF284qvUXHWo82?=
 =?us-ascii?Q?8emuh6T6GKjIinG893hWHNXYjRGJEKKln7bTqn07tdHJ++jFwLov5wgBIldb?=
 =?us-ascii?Q?PxJVxSDuvZ0VUKwHAqRUQ0e1biUn8FrbGgfFHd9Ml2RW3DTWwiCkPjE56iZ+?=
 =?us-ascii?Q?PexsmUuA1P2uI9Lx4Z3Ilse9lU6cq8bdP/RtzygKP2qpSDsO/RCI4TsMS9lC?=
 =?us-ascii?Q?z9ej/3iAiAmznkGCGmhcSataL0+bbqfxGJ6ZB5oaTo2cRqa4RtBhRJW1ayI1?=
 =?us-ascii?Q?PjsO1doNBiTJqzbUQfHr+Pz288Ie1kdRY0qWMU0HMnetnnxNrCkfT0A9nYmx?=
 =?us-ascii?Q?HYOxkiR6/h/3MM/mwhHpufcSKhOXloQqVc4+zk6aHu++NhaciGyfY2LoqcTH?=
 =?us-ascii?Q?/Wdb7vBTZ9Xnj8jre5T+bTL+No4Z8KDTnWhQk9K1qprr5YGe48UoSeRUYd5e?=
 =?us-ascii?Q?qUFukoOwVD2jeDw5VEkVt9yvywOzzgSu7FLUk31Qj6dvcm4MK3G9uP2ozjxU?=
 =?us-ascii?Q?1M7YY+vF3GAqJq0sm4wQccZ4fSZ9LQoe5wL8MTQAG1aq/EgjFbL9JZ6gOYRN?=
 =?us-ascii?Q?1ra2NvWMpMfRI/pyCAwtT695BlJFKxD8FNniqTJyZIDdWwrIGHKUshDimflX?=
 =?us-ascii?Q?ykl/+KoHtyektTeuVFb68JFtR/i2QHivtaedd5ddYeU5ZNQ1olG4yCSqFHdC?=
 =?us-ascii?Q?vcf2tUNmwja91GxQ71ek/L4CIf+Zg2SOHEzwvPfU7+6nPCA+zSdXcBKXOzEO?=
 =?us-ascii?Q?yxtPuD/tpZabxm4as3OX4IHQlm8ZR35boqTk1aNUjM+DCAlLIEt1ttwbbe/o?=
 =?us-ascii?Q?djMiBDAVUGfZvsvXuMyQ1Bdnvqed4JZcGvId6/pHfBAbk/OQAV+QmdxOJCaQ?=
 =?us-ascii?Q?yObb+pUtzrWdN9xVQxI9Q/il835lEaZa1VGUCVvDQGvnQil7zL9hcxFQfiMB?=
 =?us-ascii?Q?4bzx9H0rQ1cK8WHUixG0cm/8YR27tk4+eZDiEbQc7SRUQvAfWtHypwZYeQTa?=
 =?us-ascii?Q?IYDbdOHS/597WDNmLijQVD2khV0O8d3zLdXbkslj06Lq50DUTltq9RWuipTu?=
 =?us-ascii?Q?oCt1SonKcMDhHsQPArEJbvrPQv3hOesyx7mJ0uqARyDXYCccD8wSySsuBd9p?=
 =?us-ascii?Q?yCM4lrvp3hHcckM9TDSgQvI1BMXEIho+9P/6nOVQnMk1o5vYVOIksYSKmHfB?=
 =?us-ascii?Q?59thavyBb007bLC5LVsNah/JxI6E7cFcIKPFmkq0tA0qrVR6DwgkrRMmPlM3?=
 =?us-ascii?Q?JJkUl5Otk/Lc/gOY6f1fTW/MMnqqni+0gEZ/3T9YSigGjm/nhr+O5JNGbqDf?=
 =?us-ascii?Q?7fRcWkhRJBciVL/9BiQCFpxIgzbDar12fwIAEC+8orfuVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2B5veCZh71I8E17QIyqxRSEQ4FhOkwfgE2lRN2dJTNlQPQ989yndrmIZR5g?=
 =?us-ascii?Q?LM4x4mziKq3Jfwqtc5j9i+vqYolZkxEu06cI7ZYaB5nP+G1E7+XfaXTEPVtF?=
 =?us-ascii?Q?5D+S0ELc77uF3X5uNLJD2KpkjIAT/Ll7itegunqaffhJ5N+UnALPRouuFwBU?=
 =?us-ascii?Q?GHEi2XX/WNfjiQVyLrSGjJn4fXW8p2jeccZAVEIgskUVsGQFIWSnC+8NEQBc?=
 =?us-ascii?Q?Xm37mzlzhwpIq4dskiJoYUrMp/k9sxZNXY/xni/frD8CZqeWtzywjKKb+FNb?=
 =?us-ascii?Q?zHiSnz7UvCSlaBNAd6oQEi/mVMvrp8d7MTjhtnetNbh0/erirsWYsQeZNdsB?=
 =?us-ascii?Q?tSuBVi+6sXPC+MK+84xDK/yDltXV8CX7U6AlpWDorSqMPHCEg1ZtQ9GDrkZI?=
 =?us-ascii?Q?efnFEK1B1bCr75mo3Yb5DuMmo4RrDkAf95UaY1zAc3jY3nzgcyuSaKjfeZbI?=
 =?us-ascii?Q?6by+RUcbjmbuXM2IPtXimHYImxcuKW9zNVl2I226nWTQrGFmtBO969Y6oYa1?=
 =?us-ascii?Q?1gucelPvRHM8nNyImInINz7cZAuJW/6z2gWXLRE803U5fft+T7ASG+S+6Y5t?=
 =?us-ascii?Q?3VeIuzl71+/CqBQxCPqk9O2u0+C0/61fz6cBAhU3pbqb+UYNyJYFTfln9f8N?=
 =?us-ascii?Q?6jeoazMSKQpxqUbKVHz8fdpWYYHbh3F7Jqz8IC2QGQmUyuhGIvTyh7cm28/q?=
 =?us-ascii?Q?0ni9DksaGzAkcJYyliCnBpaOik2DEhDtRkxtn9YROEtyEOvM9jQt+X0wLHFk?=
 =?us-ascii?Q?A//fEqANkT9m1IEdeD26UuorMLRdmuc5x8apq3HKDUwJ/Cn45jS350ZEZc75?=
 =?us-ascii?Q?UxgSU/XcRB+pc8ajqmIEL6ST37WB1wR4xM/mOyfOG5hjdPkznJlb3Ocbn7PO?=
 =?us-ascii?Q?NPOIT7pmJuHSlp/VYFI9778oTUGD1kJoaHJy6Y62hxOIEos1TEDXyQ89Yq11?=
 =?us-ascii?Q?x3noeRZ9MTk+m/0L2+Os7ALsfDSTNLmaXlUDYnNi0ArW7wdnEn0gFguV9+l9?=
 =?us-ascii?Q?fR4+AFxBzbSHO7ZN9e3x9InBi1UfEn/F9JKKSLfVQxsvcWOU3uXvkpCEnLPW?=
 =?us-ascii?Q?AFkS+9Dj3aTPWfsABawVAG8kbLpYTAEUwSEg6+qTsGlk3nU4vPO6y/LKOQ0i?=
 =?us-ascii?Q?cA8F+FzFX+QrjW+UvPROLHIWMNzV/5Tq8OHEcIZTy01gPBohYjaqNxYpT49a?=
 =?us-ascii?Q?MYDvF+BxM3bCGLaXsE/PFLxf372PtbXE3LOcJR9Lc+fwLIuocoFN+oW+hRrq?=
 =?us-ascii?Q?HrUQ49PH9LXdStmtvJFGadIUSDQmrqHbIld9eP8Dgt0c168iYHwm3nkvPTqR?=
 =?us-ascii?Q?/rhQnP5llEHUJvDD3ECAZIVQAKiE7zoJmnWFolf2ljaEPHUdHtJmiuI5qFzN?=
 =?us-ascii?Q?LDEOntZLX3Vkpq/AnSLJ74Sv1CR73B2gpGt9U76HpbqQ3bSYUMRcWtEsxZe/?=
 =?us-ascii?Q?zU8phERuJFFasil75G8QwK344eS47cobewnMBLAG+2Bk3Hyg6+v9uGiHb8PF?=
 =?us-ascii?Q?h6pJU7YFb1i1fVPzdT+5GBNa7J5QxRmxDOmLfs38cOSbijs2hrYBHQco+yXM?=
 =?us-ascii?Q?3W2OktES4gjs3LpZ6zZyepCBAj60FwdhaGlpk1gi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a27063a6-61b5-4001-f777-08dcc22981e4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:37:51.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8B6ubvxSEua/tfg48+6VlTJskdUAdFOc66UcY5TzHgafqaJuOENwVwr+0FDAZDcZkueVKiPEe0O3a1Qe7SHkoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com

Li Ming wrote:
> Using scope-based resource management __free() marco with a new helper
> called put_cxl_port() to drop open coded the put_device() used to
> dereference the 'struct device' of a cxl_port.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/cxl/core/pci.c  |  6 ++----
>  drivers/cxl/core/port.c | 25 +++++++++----------------
>  drivers/cxl/cxl.h       |  2 ++
>  drivers/cxl/mem.c       |  5 ++---
>  drivers/cxl/pci.c       |  7 ++-----
>  5 files changed, 17 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 51132a575b27..4725e37d90fb 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -915,15 +915,13 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	struct aer_capability_regs aer_regs;
>  	struct cxl_dport *dport;
> -	struct cxl_port *port;
>  	int severity;
>  
> -	port = cxl_pci_find_port(pdev, &dport);
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
>  	if (!port)
>  		return;
>  
> -	put_device(&port->dev);

I don't think this is wrong but we are not holding the lock for the
duration of the function where before we were not.

It seems like this is somewhat an abuse of the cxl_pci_find_port() call in
that we don't really need the cxl_port reference but rather the dport...  :-/

> -
>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>  		return;
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d5007e3795a..6119cb3ad25c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1472,7 +1472,7 @@ static void cxl_detach_ep(void *data)
>  	struct cxl_memdev *cxlmd = data;
>  
>  	for (int i = cxlmd->depth - 1; i >= 1; i--) {
> -		struct cxl_port *port, *parent_port;
> +		struct cxl_port *parent_port;
>  		struct detach_ctx ctx = {
>  			.cxlmd = cxlmd,
>  			.depth = i,
> @@ -1485,7 +1485,7 @@ static void cxl_detach_ep(void *data)
>  				      port_has_memdev);
>  		if (!dev)
>  			continue;
> -		port = to_cxl_port(dev);
> +		struct cxl_port *port __free(put_cxl_port) = to_cxl_port(dev);

This threw me because 'to_cxl_port' does not take a reference...

Seems ok though.

>  
>  		parent_port = to_cxl_port(port->dev.parent);
>  		device_lock(&parent_port->dev);
> @@ -1512,7 +1512,6 @@ static void cxl_detach_ep(void *data)
>  				dev_name(&port->dev));
>  			delete_switch_port(port);
>  		}
> -		put_device(&port->dev);
>  		device_unlock(&parent_port->dev);
>  	}
>  }
> @@ -1539,8 +1538,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			      struct device *uport_dev,
>  			      struct device *dport_dev)
>  {
> +	struct cxl_port *port __free(put_cxl_port) = NULL;
>  	struct device *dparent = grandparent(dport_dev);
> -	struct cxl_port *port, *parent_port = NULL;
>  	struct cxl_dport *dport, *parent_dport;
>  	resource_size_t component_reg_phys;
>  	int rc;
> @@ -1556,7 +1555,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		return -ENXIO;
>  	}
>  
> -	parent_port = find_cxl_port(dparent, &parent_dport);
> +	struct cxl_port *parent_port __free(put_cxl_port) =
> +		find_cxl_port(dparent, &parent_dport);
>  	if (!parent_port) {
>  		/* iterate to create this parent_port */
>  		return -EAGAIN;
> @@ -1596,10 +1596,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			 */
>  			rc = -ENXIO;
>  		}
> -		put_device(&port->dev);
>  	}
>  
> -	put_device(&parent_port->dev);
>  	return rc;
>  }
>  
> @@ -1630,7 +1628,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		struct device *dport_dev = grandparent(iter);
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
> -		struct cxl_port *port;
>  
>  		/*
>  		 * The terminal "grandparent" in PCI is NULL and @platform_bus
> @@ -1649,7 +1646,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
>  			dev_name(iter), dev_name(dport_dev),
>  			dev_name(uport_dev));
> -		port = find_cxl_port(dport_dev, &dport);
> +		struct cxl_port *port __free(put_cxl_port) =

Does __free() get called before the next iteration of the loop?  I guess
it does because it would be out of scope outside the loop?

Ira

> +			find_cxl_port(dport_dev, &dport);
>  		if (port) {
>  			dev_dbg(&cxlmd->dev,
>  				"found already registered port %s:%s\n",
> @@ -1664,18 +1662,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  			 * the parent_port lock as the current port may be being
>  			 * reaped.
>  			 */
> -			if (rc && rc != -EBUSY) {
> -				put_device(&port->dev);
> +			if (rc && rc != -EBUSY)
>  				return rc;
> -			}
>  
>  			/* Any more ports to add between this one and the root? */
> -			if (!dev_is_cxl_root_child(&port->dev)) {
> -				put_device(&port->dev);
> +			if (!dev_is_cxl_root_child(&port->dev))
>  				continue;
> -			}
>  
> -			put_device(&port->dev);
>  			return 0;
>  		}
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9afb407d438f..cad297fba700 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -744,6 +744,8 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
>  void put_cxl_root(struct cxl_root *cxl_root);
>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
>  
> +DEFINE_FREE(put_cxl_port, struct cxl_port *,
> +	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 7de232eaeb17..ab9b8ab8df44 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -109,7 +109,6 @@ static int cxl_mem_probe(struct device *dev)
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *endpoint_parent;
> -	struct cxl_port *parent_port;
>  	struct cxl_dport *dport;
>  	struct dentry *dentry;
>  	int rc;
> @@ -146,7 +145,8 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	parent_port = cxl_mem_find_port(cxlmd, &dport);
> +	struct cxl_port *parent_port __free(put_cxl_port) =
> +		cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
>  		return -ENXIO;
> @@ -179,7 +179,6 @@ static int cxl_mem_probe(struct device *dev)
>  	rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>  unlock:
>  	device_unlock(endpoint_parent);
> -	put_device(&parent_port->dev);
>  	if (rc)
>  		return rc;
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4be35dc22202..26e75499abdd 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -473,7 +473,6 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
>  static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  				  struct cxl_register_map *map)
>  {
> -	struct cxl_port *port;
>  	struct cxl_dport *dport;
>  	resource_size_t component_reg_phys;
>  
> @@ -482,14 +481,12 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  		.resource = CXL_RESOURCE_NONE,
>  	};
>  
> -	port = cxl_pci_find_port(pdev, &dport);
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
>  	if (!port)
>  		return -EPROBE_DEFER;
>  
>  	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> -
> -	put_device(&port->dev);
> -
>  	if (component_reg_phys == CXL_RESOURCE_NONE)
>  		return -ENXIO;
>  
> -- 
> 2.40.1
> 


