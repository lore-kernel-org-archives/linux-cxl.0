Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701E1E868
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935877; cv=fail; b=S/ol9f3ARDTwHhIdRQOlyoyqnvk++l34Z7cAUYOi/3Bj/WWVIY+/8OE4PmsjnpRXPfiCV4s45bmsmXoqyJrcDcthLR8LE2CqdQhGt4UYid6G/dzs6qBw29lJAX2cizUwG8pPjkxzmjFtJKtioVsU/TmZ4z2JS1fSChu/s4I2zTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935877; c=relaxed/simple;
	bh=GpyPzRZcNTjrfjn2Jh04HtwUUInjHbCM6tuEM2pFwIg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jeUMVdklV3VP79j/ytGe6Flt1FTT7doNeEhycFWcwa7H2nIxcGIX/txKxDLKHsPfO4Dzjn/rEPMqkhsip8FjgtnAvpZKlbSGwsIKg+fxXmaL5yXDymAXOQIw0sG845cQgWrPFm4ScnCns4hojxj2X5xi9/WV4TDual0UhKBgRU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzxvQ3Gk; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzxvQ3Gk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713935875; x=1745471875;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GpyPzRZcNTjrfjn2Jh04HtwUUInjHbCM6tuEM2pFwIg=;
  b=QzxvQ3GkCk5GsjnSxWpcaSFAmQhss88oNLpBkf5bL8w4hGIGthYhO530
   QJrRGwXk6L8n06w3M7Zkr/XbGPKIx7iWUmKVZ9kArDC7P0+HPgolZH8d+
   QMUz0F92EYQ0bJpTDKVqx9Dm/9vqwx5BrOddiAuMwuEVMZjb0sWVXLwA/
   GE+oDncAR2McxFReXnBruIQB8Yvg/ts42/ERbKmHfnG35w3limio4PPxI
   m2G6o11zCsF7o/2R7RBbG9brUyRDtFmx3vAND1uAJD+fczmRvdZZdKpui
   S8es0VWU/+tHRRWdjLhkueXCixZOwp+izTAE1JHfv688FMGgQ64smtk/7
   Q==;
X-CSE-ConnectionGUID: l06WfhHLQ6KquKggbl4C1w==
X-CSE-MsgGUID: 9svgKjuhSiuQGZuR+SB9og==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9656577"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9656577"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:17:54 -0700
X-CSE-ConnectionGUID: h2VaSN0KQ8e0bondwgKI6w==
X-CSE-MsgGUID: FATOi1FCTXm8Z8ZsvEiPpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="55792375"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 22:17:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 22:17:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 22:17:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 22:17:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 22:17:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRxzm2e3bo86DPda93dqmJKTDZySyyBcOsyopHvFeqJdKfZhiP8XJX2oqiy4gCcV2Pq6cwyzHSY8XwxgJ4/NzfcQvIHANHyOefvXdHRym5m3Qa9rqslk4BIAf8KMTI1YHEIJ/xcEoOVwxpZaIpQJRwG/YHKZDX4iKlfd4Mnd416igk068xKtF/aav0SIXkwFaOyOBbd1SdZWyUVW95QtWpsvg66dy3I759oGncxosDmZB2lHfCNWbWjMbRSBgTXkMijz9a7wUNoTWeAbPZxSwVlDtumSTSk0U4nRQeRtP1cRG/7rLQpi7U8f712T/20qZREu8wAACBDDsQeJpj9SsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v3xNxoc0it1hm+JdbjUbxJNasLKUoDBFbvhx7O/q5o=;
 b=UpVhVLY2nIBhCtdYR1zlxNJrM6FjqV4e1whQEhojvLfloFXFKrjN21cXtFk3jSO7bJITYI9nLNJty+sgpkHAlBeJ3+p7d+kJy0W/CZyidkjCG+K09dfVvKjQyOQUtA6S3F7WW2nRtOvWg6z54IMVxwaVMxVeofP2ovw14QKeyYVJKRyXT1IkNI4Mtpp36VW1WlpsVWdNweT8hARHZKfAfLNGlOLz1Q9MXNNMCs191wgglrVYsneCT1kRulLhn5j3o9VIgTGAc+n7Eo8JsOnYtWp7ul8uRtjy8rQjtKp000Uw5RxSJbXs/g7hhWHJntJ9xty1MN5VK2qh4prCoCI3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6679.namprd11.prod.outlook.com (2603:10b6:806:269::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.19; Wed, 24 Apr
 2024 05:17:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Wed, 24 Apr 2024
 05:17:46 +0000
Date: Tue, 23 Apr 2024 22:17:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <662895f86a0d9_a96f2949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1713842838.git.alison.schofield@intel.com>
 <800328a3fdffa0f3ece709be337bd64a07089bff.1713842838.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <800328a3fdffa0f3ece709be337bd64a07089bff.1713842838.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f18cc63-8b61-45d3-efa1-08dc641de0a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cg6IOEMxWSQKkmx3FQOjYKnMR6mxGRFwKVO/vBZyep8VvSjw8XP4x7N4c5oT?=
 =?us-ascii?Q?4FFSJcGbFLcyoMXewe/uwNAxQ+ZkFnmVfW491r3MrM+cGSwZYc+225YRGFdy?=
 =?us-ascii?Q?g7LpKoYLgwY4qbDC1hla/MOEB9MSyROL7p0e6VpNQpPxZV/tOkk5sjw0W9Fw?=
 =?us-ascii?Q?eTZ+FyeGeN4YBukKRrgp1lNHtXjQOmTuaD/96AgkNMlly1O7GYybjGEgqRL3?=
 =?us-ascii?Q?GyfbcHfW+dPILMwA3gvdSvud3kMlcmGg+BxFFSGlh/WsAmatifj/lNotOil1?=
 =?us-ascii?Q?B0yqdTFHHu8aEyOqHYNbgRB/COQtYO2HZKkCbAmFf5HoYnpFYkKTokj0aJ8I?=
 =?us-ascii?Q?wC2qXf02im2rY7UN/9WmSSntqXiUsxXmBWYiu1OLRDwIL/L1dA/rgih/coZ6?=
 =?us-ascii?Q?5J5kWrB4YJQ21df5y+Tuu3Q/qjFcwQPAE/prdbPicCm1DeTAPPGXywMZf6nF?=
 =?us-ascii?Q?X+LpSsSJG0+dju9HPO2Xl8D1iX9hC+r2/n2/duSgJZrjGmlU0d6vzK2b9zmz?=
 =?us-ascii?Q?NsMDn6mCy2ZhFZA2gfCFTUzpsuH7en6I3AAHU17k4ZtexTwtBWhF/fGw4XRE?=
 =?us-ascii?Q?QQPLSZ5olzMGjXBurpp554rjVe4gUSN3e0D2td08tPLvneUype8eAfU6lgiV?=
 =?us-ascii?Q?6TsaTmmw7IGScjTrBnxH72AKZ26Vg3Wn7z2L8y1TU7IBEBygLG+kWNUpixTv?=
 =?us-ascii?Q?8drxh7I6wTOMovZFu/EpFs0kC2JdXdLY2cy5sIpByhdqyDo8OYklFIVgEHDf?=
 =?us-ascii?Q?zum5uSQMutg0N3TT9c7oZxTxAusJawn6U83rHfGqp8n46n4zL1JUbKISnaEd?=
 =?us-ascii?Q?0Aq9UjQK4hM1d/x1djMAPUYzw80igK97DggyzBSkTFx9obrvaOVdXh7jRodC?=
 =?us-ascii?Q?ZCAh6gNo8h0QjgktlLTsQZKS3E92QkUSEZmOFuze9q/fxBjCLtggcRej/lVv?=
 =?us-ascii?Q?1TZJfTNN8OLuHYe+NuDyI0a2vdHW/9TYj+XZ65EseIUGKKZ2t34mYqayFZZ9?=
 =?us-ascii?Q?pESBde31+r/WvTprfj+NJ8meSaSan7IEkEyVVTe4Sdj76TNUHEPjLVk6svLC?=
 =?us-ascii?Q?3S90GHJle29QHMK9r5IVNv6dyDOgiGVspFTMFx5NhVoKX23wEOgc3PclvmJW?=
 =?us-ascii?Q?eQkLoOP/kX/e8dHqWJSj7rBlV0cQA41QP9ZQ1v8Tqblngaj5WXCs/bI/fppo?=
 =?us-ascii?Q?X6KrkD55jIoQgbIsfiyT0/Gt8F0KuuQjQig/DyyTyew4HtTGtqqa0ZIs1Vz8?=
 =?us-ascii?Q?q8M6eZwoSrclngM9SbUHB0Y3YIl7E9IIev8vEak88g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0A+ZYTCQbXgzt7cOADtzpaWgHWkhAyGnG00d0ePyfM50/Z9L6RZNIYmBNcu+?=
 =?us-ascii?Q?rz5mEMSVoJ02yBoEyj7HjPoh3HOggjAGL75Z4nGb/U44fdlUSwEk9fb5fw/H?=
 =?us-ascii?Q?f9yWJ3apCsPwTwkos96ge5mECGhW+FdMR1g8JFxE9ZeT+dT4NFUYT8ogxM/x?=
 =?us-ascii?Q?0LxkS6YOQgT1vWGND3Ka30JYtDnA0Jjn/eC8ETt87c1Q3jwIgaa1IcMDHpk5?=
 =?us-ascii?Q?bacA/Cj5ZHGLKjG7g4btXuzc1P2iEmEUI1aOllukMdibEFtevbH4bfZ5uBs0?=
 =?us-ascii?Q?4TBZyo7QXH+ktQLjm8IUUCmw1RBntoSgUT4T+OgVKz20zUiegkzET8hZgQF4?=
 =?us-ascii?Q?RLzS2wSaIAqh2WAdGIeYEGconlo9VwG7YtqtsVwtbQksevnf55b4e/odQ/6n?=
 =?us-ascii?Q?9OamDuEFeDmTTtHWEXF1yTzw63GfhnMx7jYIIXV7Cgk2N0c34mzu6nhu4dKm?=
 =?us-ascii?Q?zxKFQCz/BNp2kMHW8XNIpWVrIQzCXRLTFdFQoqMHnQa7ssbJwbRXRIMGWpZf?=
 =?us-ascii?Q?KypSA7x6GH2B/8dgaziqf+N9CPibxsHUuqreGO11iAFrp4OQse+SRvY8vUR5?=
 =?us-ascii?Q?PphAPOJB/olfmsPx2hFd0Ff9tqU9vuCF9Kpu3pswxHfWDzU420Lparx5ed7f?=
 =?us-ascii?Q?CLfMlbc6yEWkjYYX0fgi3zq9VQLoPscIC9tyLbfyep1j6QbmBe/OIpwNRtTv?=
 =?us-ascii?Q?aolsykb2g9IN8kg5MkaP1siU318Nc9aeyk6NULdSqX7QPvJZHlSnzOdPdxbS?=
 =?us-ascii?Q?pmsMhFTnzxfv3q3avU3sMGwasuxfTZ48cqMINpRJCgSB1fX4xXM93RQVE6Q3?=
 =?us-ascii?Q?HUz7dK4yizkuTYUP+gBo9e1RvtWj15lzFuaF2GNffDbCnP9DAmM+GsfYRxpj?=
 =?us-ascii?Q?O8UZ0g2yesOiGeMwRAwAJe7gKpmWHkvY840HiSQ3VOmxJx9zrT1fOZtNK4+S?=
 =?us-ascii?Q?4Tar0dtpI5hNP0yeHmZKTKlVDC5Wvw4hbsPW0pkilg8Ajj+vNyYm6tzbv7Np?=
 =?us-ascii?Q?LslNx70qNaDbOkYmKSa2tsocJWJDdChasZYpdXWUSPvbbrO7R0rZY2/WINvI?=
 =?us-ascii?Q?tOGwDpJT9yNR/42nGl4K4OhtbIZU1XwvGRwkgj7zaAmorLZ4cEfBBswMf70s?=
 =?us-ascii?Q?jLzOSrxLPg5diHNj+gvttoXpeP8/hxOwaKxJwpm7MwhVv/S/mDpivpUfHcRt?=
 =?us-ascii?Q?1ShB1jLQGRSddp0CNryeG9nsNH3M4OjiBmdaxkcYz2Sf4miyLIUPFiJeYCfS?=
 =?us-ascii?Q?503Jrw72t9fomwHI8diBdpCA0pc1M+UBAz3fYfMglXkZ0kEqbdFXnB2LIfSz?=
 =?us-ascii?Q?aUMxCOXrFjIys55QMO3IKrgrKDBTqlKM5+knwgfNjZWXLIkCo0+te3c3AzyA?=
 =?us-ascii?Q?b++HM8zAiRrw9ZWEmPTo3B5JGIAuIyeAsqUaMn3YbaZtMlodMiN7fBMPe6ib?=
 =?us-ascii?Q?8PuEF7rWU6OTvWAnGC3nm7JlH+pnF2JPEMbB1NSc0ixLHMXklvH8NNBfMP7R?=
 =?us-ascii?Q?bT2ypxQsJe20+udLQLcfIl+ozpFHZIhCV+Kk0rUk2i6EVpCxvNXnLcK792FE?=
 =?us-ascii?Q?JEVtnlTB90AlLnPWFN+Zwzd/AtJeZqgJfJ5MclkOo0CmacLC0IfnPCs/7rVX?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f18cc63-8b61-45d3-efa1-08dc641de0a8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 05:17:46.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MsFOgI4CPC6OJbabDTLHgsn/4iOgNYMTRmlflAcPNwstZM17cd3O82va5AKieiIQXo1I3uIeZL8TlhCGHhlaOFYKkdkfiIia/YuQ4/r5C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6679
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may need to know which region, if any, maps the DPAs
> (device physical addresses) reported in a cxl_general_media or
> cxl_dram event. Since the mapping can change, the kernel provides
> this information at the time the event occurs. This informs user
> space that at event <timestamp> this <region> mapped this <DPA>
> to this <HPA>.
> 
> Add the same region info that is included in the cxl_poison trace
> event: the DPA->HPA translation, region name, and region uuid.
> Introduce and use new helpers that lookup that region info using
> the struct cxl_memdev and a DPA.
> 
> The new fields are inserted in the trace event and no existing
> fields are modified. If the DPA is not mapped, user will see:
> hpa=ULLONG_MAX, region="", and uuid=0
> 
> This work must be protected by dpa_rwsem & region_rwsem since
> it is looking up region mappings.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/core.h   |  6 +++++
>  drivers/cxl/core/mbox.c   | 17 ++++++++++---
>  drivers/cxl/core/region.c |  8 ++++++
>  drivers/cxl/core/trace.h  | 52 +++++++++++++++++++++++++++++++++++----
>  4 files changed, 74 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 625394486459..2fd8d9797f36 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -30,8 +30,14 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		  u64 dpa);
> +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa);
>  
>  #else
> +static inline
> +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	return "";
> +}
>  static inline u64
>  cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
>  {
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..3c1c37d5fcb0 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -842,14 +842,23 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt)
>  {
> +	if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
> +		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
> +		return;
> +	}
> +	if (event_type == CXL_CPER_EVENT_GENERIC) {
> +		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
> +		return;
> +	}
> +
> +	/* Protect trace events that do DPA->HPA translations */
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_dpa_rwsem);
> +
>  	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>  		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
>  	else if (event_type == CXL_CPER_EVENT_DRAM)
>  		trace_cxl_dram(cxlmd, type, &evt->dram);
> -	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
> -		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
> -	else
> -		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 45eb9c560fd6..a5b1eaee1e58 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2723,6 +2723,14 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
>  	return ctx.cxlr;
>  }
>  
> +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	struct cxl_region *cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +
> +	/* trace __string() assignment requires "", not NULL */
> +	return cxlr ? dev_name(&cxlr->dev) : "";
> +}
> +
>  static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 161bdb5734b0..2e24364b2b8d 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -14,6 +14,28 @@
>  #include <cxlmem.h>
>  #include "core.h"
>  
> +#ifndef __CXL_EVENTS_DECLARE_ONCE_ONLY
> +#define __CXL_EVENTS_DECLARE_ONCE_ONLY
> +static inline
> +void store_region_info(const struct cxl_memdev *cxlmd, u64 dpa, uuid_t *uuid,
> +		       u64 *hpa)
> +{
> +	struct cxl_region *cxlr;
> +
> +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +	if (cxlr) {
> +		uuid_copy(uuid, &cxlr->params.uuid);
> +		*hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> +	} else {
> +		uuid_copy(uuid, &uuid_null);
> +		*hpa = ULLONG_MAX;
> +	}
> +}
> +#endif /* __CXL_EVENTS_DECLARE_ONCE_ONLY */

This ifdef usage looks awkward...

> +
> +#define rec_pa_to_dpa(record)						\
> +	(le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK)
> +
>  #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
>  #define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
>  #define CXL_RAS_UC_CACHE_BE_PARITY	BIT(2)
> @@ -330,10 +352,14 @@ TRACE_EVENT(cxl_general_media,
>  		__field(u8, channel)
>  		__field(u32, device)
>  		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> -		__field(u16, validity_flags)
>  		/* Following are out of order to pack trace record */
> +		__field(u64, hpa)
> +		__field_struct(uuid_t, region_uuid)
> +		__field(u16, validity_flags)
>  		__field(u8, rank)
>  		__field(u8, dpa_flags)
> +		__string(region_name,
> +			 cxl_trace_to_region_name(cxlmd, rec_pa_to_dpa(record)))

...and this looks complicated.

A bit too much dynamic resolution happening within the trace function
for my taste. Just do the region lookup in cxl_event_trace_record() and
pass it in. That also makes the rwsem usage more apparent rather than
digging through trace to find the dependency.
