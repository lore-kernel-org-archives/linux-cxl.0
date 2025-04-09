Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD30269B1E;
	Wed,  9 Apr 2025 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224735; cv=fail; b=O7rGJncT7FziX1LB1anIkd4GpJkDLSofLbsj1lBBIMcvxlLRwB1vZxwxNE69Owi1805ov5NzQF1hSdoRescbk5Q33JXaoEh4TFzKtqMRi6wBm32QhC2pTZMdlaMXWWMhqHsyqlSoDgD2nnIFvwboAgFds39XHhoA/BooRGmJzMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224735; c=relaxed/simple;
	bh=T1jL5QYIe7qGVD+puVj1RTECQgFKziDjDzsipJzb5e0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CO7bFr7eqiXeZzH+ljfd7c05L0Vsy+lCKhazbqFznCIz99YJA1MXdefT91edv4YFsRw7FXVyjLRLp/FLFZOfko806pwuF34gmJ+eCXrdlTeVBq8y6S/UIHszSVQcAOsKojquRG95RqhBLFiaaKwRS8DlIoAkL86L4TmyNP7Obwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vi5XIYpb; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vi5XIYpb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744224734; x=1775760734;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T1jL5QYIe7qGVD+puVj1RTECQgFKziDjDzsipJzb5e0=;
  b=Vi5XIYpbLJO1HbDsqePO1uWMYgsbiO1M4fG61U1Con5fW23kNB3Md3ZF
   WvpEJ65MtTvmTmbLONiaqlerekLUwaqRlKhl87WGPtxgB4e1Ab4Iu77Sr
   LImjHFr6Y4ocSuwU9JsPoUKbqUCpksOxuvJf+FJKNsy3tXHazgus4BKsX
   uQOyJHtkrLUJaSNoay4tUdPbJ62Q9M5j/PCMRDmNWUrAeMoyo7Co7PpTB
   lT0BOvlLmldXeVvbe0ygTRalGL6Sp22DnJnRPT2t7HI8qO+f8Cemn3JkX
   wOtPCCWdliEfmR/HLEpJ9t56Jsw5Q6eRZ5fSem8Od+UDJFk58WYGGO221
   w==;
X-CSE-ConnectionGUID: fuWf3GR0TmOBRdlHX+ZtiQ==
X-CSE-MsgGUID: mxTh00noR8qVEsDOzJ84wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="44963947"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="44963947"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 11:52:11 -0700
X-CSE-ConnectionGUID: QPehiNGJS6WpZYge66kLpg==
X-CSE-MsgGUID: FiPBqwezR1eLprBt1GDdAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="129504255"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 11:52:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 11:52:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 11:52:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 11:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsYGeE99tXEq0PBFy60B4BHywnz3p1TuX3y4iGecAMAH4v3Y5kxIGhnnyucGzlmWfI5N523GHxN4ETL5kK7LceQ7PMoYwI/b6POHjCIxgg4rzoqYBhwaIQ//ZJ1HCrMG/s5DxCjeSF7MlxuJ99lvbJUk0Jjp9QAed9ffCWIoK692oQfYSUe4hMV0IIvFizHhEW3xeMvESBtws0a4Wa1CwJ93ucowLaFqmYIvUsSC2ehA27r+YaVGtxcEnFOsHiz122wGfCGHq49xFuDTX+KhEPLvtniUVa/eaQi05ztS/Ylfhd0dnwF06cdhNYlnMLHH212pecA98lBW7TFJuR6TZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mlBATlTdxhb6PAfanlMfdmDzBPjlNDbx74Obl8O9nc=;
 b=xT3/GCqMeutSHcqJzSWzGe5Ebt+IknFLnEizVTYNXZzgo5FVgbAlvPcZWc8RpMp95w3yXJJE0332zm5Lf7r/XllRz7NpL0fZGhpKd9VUibZHKMdJh1I+fjAdgRlBWnQADYYEo2E500D+noLkMA7nnhxLDjpGU0H/cbL7/J3rwi/CsBPSkNRRoRGYd0aMWMcnseT6hMWSb5B2Y9NiU+TiQ9KsUCuH7yFnpJX4XqPEhcUOGV42Fh+4lWkk3jl81Pe9DZvMzzuG0D6VanlsjOf4VuST152ZZG1z3gnGDuNPnUDik/ms9pH3x6GAth/aLQ6rUOY8UwMz/rUDTkRauFwAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4640.namprd11.prod.outlook.com (2603:10b6:806:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 18:51:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 18:51:39 +0000
Date: Wed, 9 Apr 2025 11:51:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Rakie Kim <rakie.kim@sk.com>, Dan Williams <dan.j.williams@intel.com>
CC: <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>,
	<Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>,
	<rakie.kim@sk.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] mm/mempolicy: Prepare weighted interleave sysfs
 for memory hotplug
Message-ID: <67f6c1b89cd6a_71fe294bf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250409055618.512-1-rakie.kim@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250409055618.512-1-rakie.kim@sk.com>
X-ClientProxiedBy: MW4PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:303:b5::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e1f4ef-9384-4933-adc8-08dd77978fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/RtwYJpGJQS4uzJAR7645cLGUb9oDrvFxs6s7rWlJTcELhONk7tfF0I8EoRy?=
 =?us-ascii?Q?VsHp2ZtoSWwBhmQS4Zv1UEar4i5+OdIUrotG5AU10iBRnSc6AP9huNYFUxDK?=
 =?us-ascii?Q?8R4FUvB4dr9u1rFzzmg2nzaiwPC0cvtsY+3NahFKRmv4XuEy8OsJ/vt6NQ2p?=
 =?us-ascii?Q?Q27irEhWfR/gx3bkGAsSjsH7JKgsd+9kYxoORndF9Np0qF7q52fkzfDHDz2L?=
 =?us-ascii?Q?IOBVuwwyYp+OlbS5qZTBzhiU7V+mGP8BxqL60g2Yx7Myer3voKT1k09t7CP0?=
 =?us-ascii?Q?MVbG7FDpJ1cMF/0oN0WXrs9zQ+esKHHw++c1vFLjmOs6N/q6mKqXqFLJVwQ6?=
 =?us-ascii?Q?xivwzryZm1FY3lNY4myqwb6WAaQ8Z5PE5iPtX6S9NMovzeSABgaHakf3wCys?=
 =?us-ascii?Q?KNWedrOZQjDLnx/bDNjVyipnSuWUOHVJpFZT1h25Sqznv2R+IXEtsII5DNJ9?=
 =?us-ascii?Q?Ms9VITqZ8pc/mtrgvhTqQ1dI1FecvIEebnCJ1l1OX+ohnitQgUHxgbKTM8K8?=
 =?us-ascii?Q?G1RxULXJJctmcbUWuajP0cCbgE0500FPJoxUqZJpFqYoMw50zuYD0j8LxWLl?=
 =?us-ascii?Q?2j9oHggtHJHemgKSoh2v+WhAwM9JNb5yPRee4uU0xzwrHXhmNyJboi+BUfUq?=
 =?us-ascii?Q?GfHwn0Vy98EtYen8+iwLI0+kdV0UqWt0PbNaTlDjGeWG2enxJBDO3rMfl+Or?=
 =?us-ascii?Q?qAPSngLwsIBwIeMJhnS01izBw+TEInP9Me5Gp6hzDbzTrOF238yM98+/nYxp?=
 =?us-ascii?Q?jbnMSxc77xI+l6P3kvl/9vqZweIBQLOPRpMp5NzAEaNY6LZT3F4j0U5CL02y?=
 =?us-ascii?Q?/0gpBQj2T/KhH9SV1JYS5XPQjxaI8ScwHhhaTHVYEwEmD5GGaCM0GqPP+a6R?=
 =?us-ascii?Q?+ijyRcbDbg5rMgW+y9dJSDUz1rRoUkIAQhknmIhxdTrAmBpb49lrpM7i+qL+?=
 =?us-ascii?Q?/GMl6dYBiAFeLVEwXmZXDfFc5NYG4bUpjBH7wATIiqpoOXpGADAlwKCdm976?=
 =?us-ascii?Q?e/Mwdk1mI4mmgIqo45pshuUJjlfsdI9OBze0TkklN/vyEOpE778F4fff3wll?=
 =?us-ascii?Q?1hYpsEjuXoDU5FWg0hrfMBq2Q35ED5u0Jmgc16AnXVzMWXsDXL+oix4dpR1e?=
 =?us-ascii?Q?4OaJhIrpJLedu7sA+fx5tpLLGQmIe7xt4Kb1qAwkGZOld4kYXBefCqjuFbOI?=
 =?us-ascii?Q?4UwJDMaxTpBj5nop7QT0tJjlLI5iqrOJEzvQOBQMGW52gIICDkcG/9MNWMr6?=
 =?us-ascii?Q?woCgnGfsGP4/gcKgaZFfMjl+30NGsSm1Y5LVlzyQELlzo0Ao6ndZimQHB3jX?=
 =?us-ascii?Q?sfwTFqQ5qMxE/Ks2KCh4ZTomTGZ8or/rU7duv16CPOVeuLduy1K8k/M3fDMs?=
 =?us-ascii?Q?u5fTSyXttcu552HtF4BmG8qQOjd5o+Sr78vMe4MOt9FuiyTvgRNZppTziC2V?=
 =?us-ascii?Q?5zpTYf1g8GA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m+sGjF8DsYp61woVxou7U/LUd08rnNCL5FJtvIr5rCWOpdioZz9LvA8vBZHz?=
 =?us-ascii?Q?j8oveVNKbmHF4zVn/qZXT2MTGml63VG6TI4GLGs5bTABP0YlFJ8RSje1NER/?=
 =?us-ascii?Q?nhN/H8miH01tWocFLXZ/RcS9bbtZanyJTqarvMKXKcKAKzGkNK5/7ciUA460?=
 =?us-ascii?Q?jqHj9ReXFY2odVjA5OI6jqMlQe673fmaaFMkKvkXLjp1eB7Rx3WAOnrzr0Gy?=
 =?us-ascii?Q?7568vMz8Rm5IO9npruIX6FavJ6vIpE9BUb0e+QzmtSd8YNKTf4UFXTBDXs+0?=
 =?us-ascii?Q?UGDSdK71ISRqE8zapytfj83nLxAuJechVXQZNrDhnzDLl6FiFJWopE8CsMZz?=
 =?us-ascii?Q?dduycW9H/uePdcLJM5b9h1ncvjj7AhAtSjo8ncxM1NqJBFOwytTLhlhojfWV?=
 =?us-ascii?Q?cDpH1o2DeLIbZYY1R7gNjPw/3Iahq8P196NFT/SKWImo3cmxQ+VQ394OcSAh?=
 =?us-ascii?Q?e2AQ15Y6asRfnAzm824gmtW0oJIXtp6xo0V3S1nIWcrfRup3A/CjCgUboOy3?=
 =?us-ascii?Q?+o8Ef83TxxEr35OnOTVnLgfYEWIdgFXHvG5FOF6qOm0x6MvR2AgMAtuOHQHD?=
 =?us-ascii?Q?SKaGGl+9qawVz7gIspoU9GAcqENAliDTiBEwwIOk7YSGbVaA4MuN9wNzLr5k?=
 =?us-ascii?Q?i41z8tC9SjvGZJEJpWAL03vDrgbTYHh2/RUXuU6jpqzYaJfBTQX7YKzN+wop?=
 =?us-ascii?Q?QNT1Z6uoqxSaoYWb70rwX41PKu3q9GDPBwahWjEcHF+lEJcu5qxiOqEKquuH?=
 =?us-ascii?Q?DgzLnanlVmQnHVEKpSBn92wS8AzIyteqClOD9NuDL3DbFNkbEQ1zp3seKtZi?=
 =?us-ascii?Q?hAk2E+l9W3hEY+ys2Yu6d5/HFk0W6A4eCp4aYwo4W7bJyHZ5fxMXuD9bWj6P?=
 =?us-ascii?Q?Opg7dfGGeg+3TPlWB6bvlTk+1nlf4ca3BfMVomECmiP//EZAsdlUHah2gs96?=
 =?us-ascii?Q?0JBCH22rQCrUEeaZbDKX0lueQzAodJ3sukghg1fXtP5Fy5y48C7jkF/dJAWH?=
 =?us-ascii?Q?Bt3JRvv0ND7PWTN+n2hNPZ14ocLgntdNiOAmAGt0OKiFwMyEwe1c4x4OnmG5?=
 =?us-ascii?Q?KxYfsYCdJTadzogH1sPJASTm8r9JC/kdLLllr9m+qPfyJ+L5UeE8SJm3r8+q?=
 =?us-ascii?Q?A5UtyCcbbrOAr1iZGuqXTo5baw33x6ywp92ZxXYdJSvdv6ib3IwFMhw3nDks?=
 =?us-ascii?Q?pAXKPXyIEOAOCAEqsRBNYtlHfFbq/dfjhbd32A5fU9c4qJE0kQM1V6VQ+11z?=
 =?us-ascii?Q?oXqmwZFpZhgmYvNIFqUWt74olTrPg81VJuX2OhtueaKWgDS2NZUZR43Y8jWn?=
 =?us-ascii?Q?8UCLxTs6p80b85s8Yuc3EcMqAgPE3Cjhw7frfQncgE7XaZ/CW5RNAI3P9zym?=
 =?us-ascii?Q?T+hzcGmCtjlCieDONeqwhDmEvS8tK9/3YUZa6HQGSqiNQYvjyhjPrXJ++6u/?=
 =?us-ascii?Q?ZMOtNBLDdxq0qYALIHxBHfSVWudVgrBWVSBlTBBcthRFtLsVe3NoMJpqvUZk?=
 =?us-ascii?Q?4ny4QMeZMvKWFp354cSxU/b46P/KT3r45yFsGu0IV2uTmljwkiXAF3XGr7sW?=
 =?us-ascii?Q?DZnNNZiy5UGaJtnAIqAiJFMHuBXDmGEPOx4sHj4MxbEAtybUzPeaTIZ7yhGZ?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e1f4ef-9384-4933-adc8-08dd77978fcc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 18:51:39.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hS1eCwSOyaH+2zYVQYYmzeKnj0J2cS5s2X4knGAEHBS4c/kYJSkJF3bsuMkuPSfgKxU2EkA0AT/Vp0q2x5rwD9iZmZgotR5YzjSAbZu8Bn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4640
X-OriginatorOrg: intel.com

Rakie Kim wrote:
> On Tue, 8 Apr 2025 20:54:48 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > Dan Williams wrote:
> > > Rakie Kim wrote:
> > > > Previously, the weighted interleave sysfs structure was statically
> > > > managed during initialization. This prevented new nodes from being
> > > > recognized when memory hotplug events occurred, limiting the ability
> > > > to update or extend sysfs entries dynamically at runtime.
> > > > 
> > > > To address this, this patch refactors the sysfs infrastructure and
> > > > encapsulates it within a new structure, `sysfs_wi_group`, which holds
> > > > both the kobject and an array of node attribute pointers.
> > > > 
> > > > By allocating this group structure globally, the per-node sysfs
> > > > attributes can be managed beyond initialization time, enabling
> > > > external modules to insert or remove node entries in response to
> > > > events such as memory hotplug or node online/offline transitions.
> > > > 
> > > > Instead of allocating all per-node sysfs attributes at once, the
> > > > initialization path now uses the existing sysfs_wi_node_add() and
> > > > sysfs_wi_node_delete() helpers. This refactoring makes it possible
> > > > to modularly manage per-node sysfs entries and ensures the
> > > > infrastructure is ready for runtime extension.
> > > > 
> > > > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > > > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > > > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > > > Reviewed-by: Gregory Price <gourry@gourry.net>
> > > > ---
> > > >  mm/mempolicy.c | 61 ++++++++++++++++++++++++--------------------------
> > > >  1 file changed, 29 insertions(+), 32 deletions(-)
> > > > 
> > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > index 0da102aa1cfc..988575f29c53 100644
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -3419,6 +3419,13 @@ struct iw_node_attr {
> > > >  	int nid;
> > > >  };
> > > >  
> > > > +struct sysfs_wi_group {
> > > > +	struct kobject wi_kobj;
> > > > +	struct iw_node_attr *nattrs[];
> > > > +};
> > > > +
> > > > +static struct sysfs_wi_group *wi_group;
> > > > +
> > > >  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> > > >  			 char *buf)
> > > >  {
> > > > @@ -3461,27 +3468,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> > > >  	return count;
> > > >  }
> > > >  
> > > > -static struct iw_node_attr **node_attrs;
> > > > -
> > > > -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> > > > -				  struct kobject *parent)
> > > > +static void sysfs_wi_node_delete(int nid)
> > > >  {
> > > > -	if (!node_attr)
> > > > +	if (!wi_group->nattrs[nid])
> > > >  		return;
> > > > -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> > > > -	kfree(node_attr->kobj_attr.attr.name);
> > > > -	kfree(node_attr);
> > > > +
> > > > +	sysfs_remove_file(&wi_group->wi_kobj,
> > > > +			  &wi_group->nattrs[nid]->kobj_attr.attr);
> > > 
> > > This still looks broken to me, but I think this is more a problem that
> > > was present in the original code.
> > > 
> > > At this point @wi_group's reference count is zero because
> > > sysfs_wi_release() has been called. However, it can only be zero if it has
> > > properly transitioned through kobject_del() and final kobject_put(). It
> > > follows that kobject_del() arranges for kobj->sd to be NULL. That means
> > > that this *should* be hitting the WARN() in kernfs_remove_by_name_ns()
> > > for the !parent case.
> > > 
> > > So, either you are not triggering that path, or testing that path, but
> > > sys_remove_file() of the child attributes should be happening *before*
> > > sysfs_wi_release().
> > > 
> > > Did I miss something?
> > 
> > I think the missing change is that sysfs_wi_node_add() failures need to
> > be done with a sysfs_wi_node_delete() of the added attrs *before* the
> > kobject_del() of @wi_group.
> 
> Hi Dan Williams
> 
> Thank you very much for identifying this potential issue in the code.
> 
> As you pointed out, this seems to be a problem that was already present in
> the original implementation, and I agree that it needs to be addressed.
> 
> However, since this issue existed prior to the changes in this patch
> series, I believe it would be more appropriate to fix it in a separate
> follow-up patch rather than include it here.

I tend to disagree. The whole motivation of this series is to get the
kobject lifetime handling correct in order to add the new dynamic
capability. The claimed correctness fixups are incomplete. There is time
to respin this (we are only at -rc1) and get it right before landing the
new dynamic capability.

One of the outcomes of the "MM Process" topic at LSF/MM was that Andrew
wanted more feedback on when patches are not quite ready for prime-time
and I think this is an example of a patch set that deserves another spin
to meet the stated goals.

> I will start preparing a new patch to address this problem, and I would
> greatly appreciate it if you could review it once it's ready.

Will definitely review it. I will leave to Andrew if he wants an
incremental fixup on top of this series, or rebase on top of a fully
fixed baseline. My preference is finish fixing all the old kobject()
issues and then rebase the new dynamic work on top. Either way, do not
be afraid to ask Andrew to replace a series in -mm, that's a sign of the
process working as expected.
