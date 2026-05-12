Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC72DECA3;
	Tue, 12 May 2026 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602872; cv=fail; b=ftoT18HtwdiGcmwOonBh4NMkGYJf1uVoLWWANfLILYdwieRN7rqnbdUeyY7cdbJWSra3iwI71vVLaHIOQRXqgP3kT6d6DIQ010pvHML8ZYILbeELlEXI6paz8QqBuCyedHXi9Lg/93melvahitE6Lwi1SHT5IyqyihFP+GEuLow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602872; c=relaxed/simple;
	bh=vcz6rnPD13HdcHfQCRcxgLczhKo3upYEEbNffTIVNN4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rt3FJubTDbsQnOofG/wKaWGQPGsFaWCmdQlHnIepZ0tPEBWHxziWmhr4xo32onjuOy7fKnz4BH8ZjlQBLZMzo5YBL8mXMubq6ghmDR2PK3iy5cQwrGOyU2q2wuTso+O7KJUfQrpbKLL7Ib3bNRCcJIbvA7y8Je10CCvIeLy+bB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUa/2bhE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUa/2bhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778602870; x=1810138870;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vcz6rnPD13HdcHfQCRcxgLczhKo3upYEEbNffTIVNN4=;
  b=aUa/2bhEY3ceS+IUNpm8oeMl/+DpfNkcEobmDNrV1+EwzxAzZ8faHG0o
   VsuNBJ94UDOo/3hdoMRblUIP7GArboEQA7P18N0IYFrHU5gMQjH8fU+cC
   UUCDLQjunf+BB2ahv+EZY24HeXyLPQzvVlmvJMbjyL9COZSJWfFThJijB
   NRto1SHp9eDvX0ckRTFYzNPBAzaxxnA7AkW7qnRnOe7y1ba/P67c6ubFm
   z2iP3hR/j6FRegehPx2gzW2lFXvVauBm50GLaDT71OoDeGVXRYU7+eK2D
   NmZXExs8J1MLjeSgqIezNsOxL2ZB5okUjS130w2iHmu3M92Kt+XhxgNw2
   w==;
X-CSE-ConnectionGUID: 0gnMSYOISg2NQ39ZhqLX1Q==
X-CSE-MsgGUID: wTlLirnuQ0mhHT/I/Csvmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79695961"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79695961"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:21:10 -0700
X-CSE-ConnectionGUID: noAfr6/RQkKnEKB46QDsyw==
X-CSE-MsgGUID: T40X02UXSh6//QokRlbmUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="236828941"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:21:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 09:21:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 09:21:09 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 09:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZYm34WCSDn5sHdhsv6ZCo6Kl6TEFEQ7fF3d0QdNccRhyHfXbr9FEsT3OKt2IGvEFyAGt6Kxbi+fTI8VGI7wnR0t4XLE/4URjaABsojbELdz+RBY8t/dohpp3qaygM+bkDv2DVQ4+OgC4zlBWKNSrLQ6oS5KK1tC+5JrtTcIBOmONVgxbdiUipN59cxLxgIDo6OTTmikjsf8DBdli7uH0sYPlAlfpxhnMlb3DoUQ1/rCupBHwNxlWTVI+i+ypOw7lsDWWFn+MC9PNQElPyDR/92cr7kiPKh2wP+ODpuMiv31mNDB7WlahVyQSwnpMpTpO8B33mJIqz6xqB4mf/PPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhqtDcj41eQFxDdGQ/HxeyGwZKd8IkPsrqtjEkjPteE=;
 b=obLQcRnrurFHb1q/iiB9yPVfCG6GKWlpBxznbE5sUEv4MeIJ7v6rj97ZA7ha7ffOtgE1YL3/VQkCJqZZyVYcrZQfh6KetLsP4wb4Q1tlkhPro4yECKJJ9Rj+ufDsGSA8fgW5VEeBhWvlWfZqysVQwKlsfcIUnfrmWAX907nS8pbC2rZrZD9WHMybjAN4JaX7Z+vYwnF5KOLeBwbD4aOLlTrwErmlsa4u53u9E6+k2tucyXtz7bN2xYNe0zPy8B/rF+S362dQjBJPsdeK5bY0lN+QjmAjXhmDB+CHQo+9sMEXbM2a8CPgdLb8tU1ervBRd2HrEqy12Bwy0I76vEpWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LVXPR11MB9732.namprd11.prod.outlook.com (2603:10b6:408:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 16:21:08 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:21:07 +0000
Date: Tue, 12 May 2026 09:21:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: KobaK <kobak@nvidia.com>
CC: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Validate partition index before array
 access
Message-ID: <agNTcGEsKqo_mzm5@aschofie-mobl2.lan>
References: <ad3EjUssy1sLzrr9@aschofie-mobl2.lan>
 <20260414151410.3599342-1-kobak@nvidia.com>
 <ad5zwglddhPhE7YX@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad5zwglddhPhE7YX@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LVXPR11MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: bee94b4c-7213-46cb-e1d8-08deb04278dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: smGdxDhQfMTf3nrqR8wrJWjYbTik8LXvtw/pVsvISX2xBISPTZGwLdP47Zz1IXElHht9LivY5F5SH33N8+3EHtVrdKffRyVIV//0+eNttIAZsPIHit4/VoQtJ0i20IBQmrwYnMzt0sD8GNB3ba6UMdshrOJS7h/fKd610J4RNQRKpXNUsDWLhmXyPSoQBOWLLWL2bIuOHJaE2E27boVBghV7Tm4wq6nXbNmaayIi0fnpApukHoY9uq61lUZRtdPF20NwBvydTRPHwKt/xGG/v9GZC9D1TVQyiRr6wesncOBK+Uj7nablvHrNogKTd4SBHZvxuvUlWr81EMU5gxil4eV/mjt5/o3kDEj2iTqBO+/UqmFrAL4+c22vT5ShWyFH6gJMeDf/ALbGVvoQTyNWsUFejhAJ0mK6RsyBdycMJJWPlfHTEFAsnIeBOzeupDpZId1emMr01ASENHkqVh73SJKtpLRpRiCwyPUp5coOMiXZXnASe7tlxgV9MYLMhDYb4l1/xNefrvGMvrUl9gUsZA0YgGv6t+NbY3vKGB0HRictvgAMagdz0iUV9ZvxIVcyX+YTJMCCUwbsUWf9u+DAHJtX84MmxaehQYQgdYJaTApykpszLt9f1DUBLDJXBeq3+vDJ7T9D2/8pXAkAbi+0vsXuheumRUOJHaBMu02X+Rm3GIorwB6aTw77/HH6Y234NZ8TAGDbW//T1ChBMi6LUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bt96l8OGUH0DBfXgiCfwqyaowFaXo9d4s9i2CudDN6mAZEDrK4D8vs5xye9v?=
 =?us-ascii?Q?kYH1rIWQQBA6LPauzlhSgN6s0jxIjoZ5hgZY+/YrHzejOqC5sOTbggwTKKVX?=
 =?us-ascii?Q?klzca70uv8Aa1P0jOOBlwmpXBZZLMyCZ9hqwZd7U7/Lgj23Y95oxifbeERpI?=
 =?us-ascii?Q?TTIgnDkf8BWLUDARmz5Zq+dvPqEaJ3nk9cPawRi16D8ayJhCdg/tYj+1rzyB?=
 =?us-ascii?Q?FecrdpdTUnvtT2X4xxJGk4vqONNqq6q8gSyTabKLH15PA6V34fzmNkxYVJ/v?=
 =?us-ascii?Q?jeu30tFrBujkS8IVSjfEKcNXp2jbd4m/fVgJIpEk12S5EdQQKH5Ioh+syQTV?=
 =?us-ascii?Q?66cOKnQzs1GNX70fR0Xb9skifF4wLM6cbmapBo2AStP43jztmplXRlklYrDo?=
 =?us-ascii?Q?cSUB/bAZHgsPePU8iz3tyAAqoqIJK2fRKabbkkBvMewcJeTlvCC778JeJ3i7?=
 =?us-ascii?Q?FLw/uoIGspF7KUwvoCnsj7tWHYA7QAFuhafeGORNExhaeIvyMf7HyV+SX3AY?=
 =?us-ascii?Q?LD5u54BN1YgWPkW0aNbipZRClgK6Thgsybdw79D7zi8gd2kEB/2+H8P0VUE5?=
 =?us-ascii?Q?aqlIoa8puUdOmm5LdqMvqhiOnOWtvUY8PwGHBwPrt0u2dvtfFaMtEm+q7p4j?=
 =?us-ascii?Q?8cEgHeGBaJTdfKc4W99zj425o8oZXdoNfgt3pqF2fJLMYrTpZtbvErw+LKwZ?=
 =?us-ascii?Q?g3JhYP3PB4uDSgvMr4W32vA5Rczy+XxoQcjoxh/1jzOnCCtPe2BBvYjN2QPB?=
 =?us-ascii?Q?loYXNnDiKrQ25ytJtmKpeICt2ap0NwLrXDRfjqYEIAiJBOpGORiM2P+iTEEU?=
 =?us-ascii?Q?AKQneneE8e812xYoniVbXqL8gMgSLH4Elgii1Okin+1A/Q4e7hz2536D9V2E?=
 =?us-ascii?Q?EWsFyQwXfFrL+uX+uMd3hLxy2wEoMLDI4I7o/pFx6INsQ6b2P8C0tBIzwawl?=
 =?us-ascii?Q?QRqqDJkf6Am6cGnUYs3eBNiTqvHGswMYGByyAie+inSPf9pgLVL0H5jl31Co?=
 =?us-ascii?Q?WaiCIsC38Q+OLNi4w0ZBLiHAy51+FtFsqdnp3plmvnetJj37vxgS3Fv8ABLT?=
 =?us-ascii?Q?/SUk2skbF7SFxftP9cyg8Cn/Uq0R7eQhjoAVIn5/ed5sJM3zb1O0q23mv7R/?=
 =?us-ascii?Q?TUwnVj4mS50W8XlQI/4SZ2ez62cul87T7P/Qf4ir942Cn6XQXkZuYsJWa2pa?=
 =?us-ascii?Q?uf8KOzsAKd3QHAHd8v0oNOmjxPePksb1yKWJlattJaql6eN0hQ4nwjOa8vjw?=
 =?us-ascii?Q?CFX+5rbcnBa8kZ+ZaO2RHPsNwRdRu8jg36uAgaZfLyxBcIIEBHnijY2NFdNZ?=
 =?us-ascii?Q?JTxd/JeqCv1lHFBDN22O3dVWQdHKBgzjtRtwhyYQLbBYOBMyV7xDMCWWCsQg?=
 =?us-ascii?Q?51bIhRZeo+oHgspSLoxEOoDBimFb41X8WX1RYui0rY2p3ssI3a5lgUrzl6Lx?=
 =?us-ascii?Q?qRlM+s5waWh3KfVqks7OwF18ehNhdb4FLAhVs9ZacbDJ9lKD5SfaN8KyaCX2?=
 =?us-ascii?Q?Kxhss4BmVla+t5w7AEhrOAOyP885MRn4j5xYzTupE37XC10em8oK7zElgbSu?=
 =?us-ascii?Q?h/yaCpSpzPXZL9Uyhcd8k8e/UUk0cy7MTRE+eoaZlQVamOouwZuW4iPD+pcq?=
 =?us-ascii?Q?LhduwYaPU/vwnpjqVIMNttNOSAs0vxJcnsWlCV2YQyZoo+ttz7W2rA4fk+1p?=
 =?us-ascii?Q?426MHbkfNObHpq+SPaTcUAoeq43tFoMURe9HASbhu52m8Rc8UkK4xLozED7E?=
 =?us-ascii?Q?Y8uFaYjJLqEcbffg9/mw7LhD1orzGrs=3D?=
X-Exchange-RoutingPolicyChecked: Bw2P9oYQ4Bk7cgEJKWwXJlyGCyNXyagiqN9rAF2pjDtobTy/HjjoICvd40W0leEdSkEB7SlyIU0fA7HFjFG3K/IpgC8OFnas9vet27YkFsavGL74oxJvnCQwSph+KRYFh0yZhl9y8K2uhzVfKAhQVKj1aqpnTt8AT+gXZ7oxpFbt2ePnhffr1twVVbQIsGaEUmpF83BKT2L/TEwDgWnlH/p6oQGXKtLZWkijMySx2VWKeXtZfZHbeb3Y4emqNwPPPzCwsTjOV4ZLv82mcMbBtGApT9CNsrLTE44AcZ8UUa4V4/BwJP+yMwo1bmkUofzSy+tGz43nOGfnkqTt4EB+Xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bee94b4c-7213-46cb-e1d8-08deb04278dc
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:21:07.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaRfuKuj4EWFG/5ZTU6ToymxxWQ1q8jAc0JOEsCBE1gIo6jj877NMypVWApC0oH6xZ1BrC0KvbLxoe9hamK2CJ+dQs+1HFGaTxNkljY7gcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9732
X-OriginatorOrg: intel.com

On Tue, Apr 14, 2026 at 10:05:06AM -0700, Alison Schofield wrote:
> On Tue, Apr 14, 2026 at 11:14:10PM +0800, KobaK wrote:
> > On Mon, 13 Apr 2026 21:37:33 -0700, Alison Schofield wrote:
> > > > Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> > >
> > > The above tag added the check for part < 0 in construct_region(),
> > > so that's not the fixes tag. Like I wrote in v1, I don't see the
> > > obvious tag that deleted that check, else I'd just tell you.
> > 
> > The check was lost during a merge resolution, not by any single
> > non-merge commit. How about dropping the Fixes tag entirely and
> > explaining in the body instead?
> 
> Appreciate your follow-up Koba but a v3 is needless churn at
> this point. DaveJ can fix up or drop the tag upon merging.
> 
> Note to DaveJ: see the v1 thread.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> > 
> > > > Signed-off-by: Koba Ko <kobak@nvidia.com>
> > > > ---
> > >
> > > Need a changelog here.
> > > See https://docs.kernel.org/process/submitting-patches.html#commentary
> > 
> > Sorry, missed it. Will add in v3.
> 
> No need to v3. Just a note for next time.
> 
> > 
> > - Koba
> 
