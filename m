Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323A14F125
	for <linux-cxl@vger.kernel.org>; Fri, 12 Dec 2025 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765577103; cv=fail; b=XBhvj4jzAqJ97cbrDnG2er1QB5Z4G3Jig753B8+ZkDNoEISlAz22OqIuet3mmLTtypnOdMaQw1+qSGNGW5YPbClEcToPZFxerMpqQt32sWv8Ta788ii6lRDvcyExErO17eoa2R3tHra43ywFo4bcwdjvpk+8OCujsaGde66YBZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765577103; c=relaxed/simple;
	bh=+XWX2TSZZCdoJ7YlD75/t3p9kwturLs2uTeLkXFOgkw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PI7x5P4qsbf/suiG4t8ynJv7Wub0hKJeCDSp5i4mytaJZPqos1bvdqlE6T+7L5pzBGT6Uf25ghbGpdb0aes4t+WRUyv8Z+1SleKTCTnGXflPHHRR5E0hWqedaKQQXtwXFcKxgU5kQAe7RVJ1gyIwuJe0fAy7uKoNpsw5e1eQT0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr0a6Th7; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr0a6Th7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765577101; x=1797113101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+XWX2TSZZCdoJ7YlD75/t3p9kwturLs2uTeLkXFOgkw=;
  b=Mr0a6Th7VeSQiHkLPFEDxqYbRfrwND0DRGp6J54FlVee3YkVdVRnTDqV
   wZZHNKcx5xj6/E7uS4VJlCDJC0bU7PiPogGWoUUUjPJtRjck+LUAOOBGe
   7kppuuP7efGtRBFEVbge0uBROzhJExZ4wWq7wNIiNYU4FLewVMEMGbL1k
   rVBecgcnp/mF6PZ4kAGKX2s4Wi7H0rb3RyM2/LLS97tmJdOTBUhngucwQ
   icMwdt8syYKCvZZDuXnkQjhK09ETmGsr9nKuCpUTk3g8JV+uhymAt6R/w
   gOOCuMtZ0F965KfJ7/w8lG6LKOI44Z3A7y1ubxByHnj+J5omAzb3upgST
   Q==;
X-CSE-ConnectionGUID: MFoZ0kKXSxeDQ9JXKtfWfQ==
X-CSE-MsgGUID: Qg6jEpZdQZm14kUTBXygMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="93058894"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="93058894"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 14:05:00 -0800
X-CSE-ConnectionGUID: OsOd5xbPRtuCBaWMFg+TUA==
X-CSE-MsgGUID: TXg8vZBJTOyoHaRv/sZ1HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="202119491"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 14:05:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 14:04:57 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 14:04:57 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 14:04:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noUZ5ODophflEM1kbIrQZ4FLc5F3pamIpiRxQw4NwrZp6g9Pn03YtJdXAAGOIQCYfwDU7zM/d7Omb0nJ9r8wh8bHs9yC8tgg9TNyyyog3kGgjUHdbvPbyzLYj0ZT2fhMVifS3Lc4rFieGFh+tsZD0MPav544m4D8YT/W6F1NM/7QMk5SCBe9zA5QL0uDcTLwDWvZZL/dmwHUZYjlL1cyMybRI9KLy+9375M621KleCmVeWsr+/fUM5TIcjmQnLN5kldlvNdizzu7u2LPyMvk2c1TzkypucmwYGETgXYADM4UTsSMbp6b6hS17QEg8tUes/x0QDXWwgUUnkE7C/8p6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMFb8C6tjSccUJtoXHoKgAQ0BOPvA+UJDY+EkCLR9mE=;
 b=FtB9uMJXNhvqqRyaumGSHNrzZ7GHCJHRRg0W91l0/KnVQOMWJl89OUjH0sjLxxvXVyz3greaGGY2qJ3wMA0ZMDoF0HkdanFAV8atw9d4AvJgmb8tf0IDhenLuesd5ibfXbmO6BJATsWpm7rXj8nZz/8jG2ecl2LiFnZAO7D3VIA+A+LObOjEeOQr5BkfWEib4ocKIXRh0AlyS2l2yjFXAGodPiCu7NEK7b4XI6+nZQsQu9wNZzS8bf+wx+UnNDSDBNVyM0PLqk5NReukaCaQvXgLCKAYX9hfWrmRKp5YWUOyOPfm/lBxLr/NH8lV9kJPWf9G9dWhQOjNA+vJwjXEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH3PPF0515C3CD3.namprd11.prod.outlook.com
 (2603:10b6:518:1::d05) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Fri, 12 Dec
 2025 22:04:50 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 22:04:50 +0000
Date: Fri, 12 Dec 2025 16:07:32 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Anisa Su <anisa.su887@gmail.com>, Ira Weiny <ira.weiny@intel.com>
CC: <anisa.su887@gmail.com>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>,
	<dongjoo.seo1@samsung.com>
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Message-ID: <693c922448bbc_c04a9100eb@iweiny-mobl.notmuch>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>
 <aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
X-ClientProxiedBy: SJ0PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::11) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH3PPF0515C3CD3:EE_
X-MS-Office365-Filtering-Correlation-Id: ba55b1a7-5d75-44ec-f2f9-08de39ca7893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q5UATmwchdHgRpIC7Gi7Eq6T/EZxFxskdlN0fi3oJ1EpeD5m+6uDlkg2dsdR?=
 =?us-ascii?Q?1i0yedF3abiy32yNoYXobljQ+rUQM5DPvECV5yEVgmM4p0mJjGStcsApc2Vz?=
 =?us-ascii?Q?KKTiQtYuI09BsrgKy7dL0gDrV4TFxsqJtmV3fbrhMn4g8BnLKrytAU3roIPz?=
 =?us-ascii?Q?KD5IMRvPZ+PSNl+Zo7Ve6rIfzYIAUuOLlQGyNGAmT1xwK/RkgeRsqqAka3C2?=
 =?us-ascii?Q?gVzf2vc8wZBd+1RQlA8YRIZNJcN5h3r/hHESetFIm7ZOnV0p5h98LLSUaNaH?=
 =?us-ascii?Q?5a+KjfG5PEnBlCKksJ6RH7oHRQvxoN+0O9GBbple2D4G4CALGOtnEKh916oo?=
 =?us-ascii?Q?LkJFth77YMELgxhkX0XhfVySe6ns6quCYvrIIocGBRyOggEq3iz7BTXjRbyJ?=
 =?us-ascii?Q?ubM9/+OTRPJy0T/tijsxb/G9LEHxD0ke8DmzE3ekb134l+VuyTz9H1Vh3wV1?=
 =?us-ascii?Q?saKfPUUU7gzEgqG7ZYMTf+xVKCI3TNRylFsqgaI6qappUyL+/W89PYHNGdcw?=
 =?us-ascii?Q?BmWSR9S9ORGdiVtBbxYPfQ+16F8QSwRNj50073ssEJGTvK0kWVzhNqMLw4dO?=
 =?us-ascii?Q?Ccnhg86pZYzafcj8Z4lCU+CfbBD1urCR/1zk9pm/KH2wvVocgQFSAza0bhB/?=
 =?us-ascii?Q?I3lCrUuCcqEnfw+1atQvI1lkI9s2ncXu9fpDQQXV/eaFU/a9Fi2Bur4b1u/a?=
 =?us-ascii?Q?kJQbBFMvEW1QNJweKPnWQDN5zKe6WiGbGMH+hHb5k9/HKJXtM72XwthunRB5?=
 =?us-ascii?Q?hkcHA1Bu1M3Z1EZhJffwHFUD5XYXUFG5PLs5/QQhhhnwGSNumnU+xoXbPP0k?=
 =?us-ascii?Q?cQ1/Cmfm3loWwMxzggvNs0xJn+ebzWaZFrQV+V3jFVSaU/dnVcPaNe28sG7d?=
 =?us-ascii?Q?TQzMLzYuuAy+8FURAtoS5e0N6GF7pFoSe1XAkxnv1/xNsFwYO0hWyDDf8Ypv?=
 =?us-ascii?Q?rJoUJWiP6mmom0khHNvYf+4wMJXQnwvjnfer6cJzGjK6GsxlYgB8wXeeBQZ2?=
 =?us-ascii?Q?B0ZJLAvneZGm31HBkDlpk1NcmH9pNS7xkrq4hPq+zBrNoHNLHrGYhh3rH7KF?=
 =?us-ascii?Q?eQpCpQqQ8mZVkw6iRHUCibRKPoPuyPpk+QylzzMYZdyef14IUHuSGjDJFMze?=
 =?us-ascii?Q?QUfYZERD6jPzJoe++Aym0dvN3/rDhSDRXHes9pjjJhhPn1nJlz3jKMyv08Ij?=
 =?us-ascii?Q?CBfToLSJYBe27yqpyfC1HZpxdNP4HOiiZ6dsYE5Pr+xhrrO0GsyQ3mbGpbeS?=
 =?us-ascii?Q?l80OOw/tCpQ+T3lQIDTHzle5Z5YsZRW9LgpBwnB8RBJooLnCUJOMyOOqDPK4?=
 =?us-ascii?Q?VXFPibOoLT7Ug3X6XpvXEM/0I/qApmK+UK/OtEd86xeu620VP3+70RiOSv67?=
 =?us-ascii?Q?+PgzVmM5A457ZNEBoLdDBT/LRsSvEiXEF2/MGAz8sAv4kHiBwOF/AMQzuyW0?=
 =?us-ascii?Q?w54JrAuTGNviegUO4MMwrOMy1R1K2fnBYzbSJ9TNHC+ya2UnIB/5yQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g8HakTIB/h3xEoMdBAWqwu/ds3lxMdm+1f0zL89MwjsZIn91h9h7DzwgFCFP?=
 =?us-ascii?Q?qrZvEXkOjLMOzQ4IEfaTffvC44gSp044OFlahtzikNe7uyvP9ioi4nQ2NmG5?=
 =?us-ascii?Q?+zeYKCZ8WQbkNwW214ywKviC2nwEm/byno59/NieChxzqpqdK8G6Iu9OXwRe?=
 =?us-ascii?Q?Jtk8bbUtt0JTi5wOFHV1mrjbt9TEk/nAC8Lwmy0UQwLropDFJrRJYHflUzv+?=
 =?us-ascii?Q?0ZX6JplJY1A05/zeYYbnD3ScpTd4hycb3JIZ5tn/gej54ygXY5e1f/EeROgY?=
 =?us-ascii?Q?ZvN6+cNDs3n1VXQJ9fXMvahJS578Mc/DvynGRyUj7xEFth+SoMiifU2yiSue?=
 =?us-ascii?Q?5mA8NnxFmrX4WnajlUeD7CyQ8zskTRqJF7gmOZAQ0zRwtRuJxQ6VYGcM8iF6?=
 =?us-ascii?Q?OjuL25M11zaZ2ZV5BVkwEcHskcne45ANQZ0z75g0+3xMwxjBIW3+fqKBYPNj?=
 =?us-ascii?Q?WzyMjpHMVS8BhzVfleeeNsFrHuLC3sgu18sHBZ9mnQBPMZar3P2TvNQDb8Sq?=
 =?us-ascii?Q?pNAhdu8x39kz/FYYIlWuivbDr38pGEN9/SOGciZreAWjlYdbxFjhmxZAXazl?=
 =?us-ascii?Q?YwTdr1h19p5UvqMZTNEMWyIBQOHwhfhrysbkU28WDqI/DnpdU1E8akqAQN2W?=
 =?us-ascii?Q?aqV275USyPJM0Hw7bm4m819Qitp/0x4hMC/dcxndTHT03vqNLDRio/uBzqli?=
 =?us-ascii?Q?0o+SMpDGXmfwk2UF/GmZnZt9tALA1wi+IDUTlxHiJoUxynhAT3gmK/lyuo8Y?=
 =?us-ascii?Q?8Uq3lxmKBMGsNGYFwpL+nswXGCnCeN10NgMtV2TVfrF5q+2XC/KLxvT4kA/E?=
 =?us-ascii?Q?uouXVFnW4f+MZbtKvvwSI/IoxWevSRJw7ffyuJPELbOjotHReq/Yxcg2n4Jk?=
 =?us-ascii?Q?4wTl9kS/N+d6ZDEqGrNkUGuPwNAuoavs8D6y49Qv7faglV9oNGhaE/wbbGs4?=
 =?us-ascii?Q?hDHfzQjRov6g6PBd+DB7UxU3kDChGmj/JS/h1MGulfgSZVIIM30dz2CNSmwg?=
 =?us-ascii?Q?PZ+Py1bczNOJeJtnTZVcqgU9NcwqgRlmiobwvXoN1Jh/SF6zpkA60JYV3gCF?=
 =?us-ascii?Q?1wO9lxHLczcJQ9V7jun33Ba7a5aAbNu/KRskEeE1JOl08dGDxdRXU2BaCfs9?=
 =?us-ascii?Q?Gj0WtImRx5Ifq36hEBD8oNli3aDs4BPDGvUIpfGMxBk2JkJGG6ZZh1XbuiYE?=
 =?us-ascii?Q?g3tf7eubkz8T3u9U5TpDLt9MlgTZlU+0HU5FF+focGwlOja/U6MdlBVrEyf2?=
 =?us-ascii?Q?V6UMMzBLpGgpDsESriVvhNkmBo510dUOWaIUYQtZznr+m7c5hAshsE0TmXvc?=
 =?us-ascii?Q?5kVnaqoRY2MQxy9yba8SMbLHIEt5sh2US7o1hJVWdy83xKWRAc02ry/qmEAE?=
 =?us-ascii?Q?V5Z8maebPfpvmEJaOrBEWCEQ27RG0rE/I+KaIKDTK75AQLhLZG31BDMAeYyZ?=
 =?us-ascii?Q?c32cqYg3yHK20l0LqaPBoItmwHMCfQJ7mZ9bMXHbhJjns2OLmgmQkdkQ2j97?=
 =?us-ascii?Q?cCieB0QktCKu/mPeJG8ymaCH2VvxpVQiBzpM3gelQFJxTd1yA9M2insosBWy?=
 =?us-ascii?Q?YlIjpfxIv7W5XRdt/qeH9OLW6wnEW3wDFNmaaCit?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba55b1a7-5d75-44ec-f2f9-08de39ca7893
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:04:50.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcFMp2CELPCw7S6DKw56K3p8Oonu38B/zaModm2OfAEbn+h/vtGxJ4sJ6EAQ8IDbe8unYFTA9gjQZROxJ/aIaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0515C3CD3
X-OriginatorOrg: intel.com

Anisa Su wrote:
> On Thu, Dec 04, 2025 at 11:28:40AM -0600, Ira Weiny wrote:
> > anisa.su887@ wrote:
> > > From: Anisa Su <anisa.su@samsung.com>
> > > 
> > > This patchset introduces support for multiple DC regions. It is rebased on top
> > > of the latest branch published to Ira's repository:
> > > https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-09-23.
> > > We hope it will be useful in the meantime for others and restart some
> > > discussion around how to move DCD forward.
> > 
> > FWIW it seems patch 1/3 and this patch are both bug fixes to the DCD
> > series I last posted.  If so they should be tacked onto that series.
> > 
> > So, you are more that welcome to take over DCD development.
> > 
> > However, I had multiple DC partitions (Regions) supported in previous
> > versions of that series and the community decided that there was no use
> > case for such a device.  Based on this submission it seems that me ripping
> > out the multiple partitions was incorrect.
> >
> > > 
> > > The corresponding NDCTL support can be found on this branch:
> > > https://github.com/anisa-su993/anisa-ndctl/tree/multiple-dc-region-support.
> > > I will reply to this thread with a reference to the thread for the
> > > NDCTL patches once published.
> > > 
> > > Testing:
> > > This patchset was tested on a QEMU VM with the following topology:
> > 
> > Unfortunately none of the details presented in this cover letter really
> > show why the kernel needs this additional complexity.
> > 
> > Can you go into more details on the use cases of multiple partitions?
> > 
> From what I understand, the motivation for DCD as a whole has always been a
> blocker for the entire series. However, this year we've seen multiple vendors
> demo memory pooling/sharing at SC,25[1], as well as the development of a 
> controller that supports "memory pooling and sharing across 
> multiple hosts" from Montage[2].

That is great!  Do we know if they used the patches which have been
submitted?  Do we know if the user interfaces were sufficient?  How will
this memory be presented with the new DAX changes being proposed?

> 
> The flexibility and control provided by multiple partitions is
> an important capability of DCD for enabling composable memory 
> infrastructures. IMO, adding multi-partition support back in from v8 or
> picking up this patchset would strengthen the series.
> 
> Let me know if this proposal sounds fair? Otherwise I can
> separate out the 2 patches that are bug fixes.

After RC1 could you rebase the series and fold the bug fixes in?

Before we get to multiple DCD partitions the interface for DAX devices
needs to be settled.  In the last community call we were discussing a
special famfs dax type I believe.  Has any work been done on that?

For multi-partitions we need some review on the partition (region) names
because you made a change which would be incompatible with the base
series.  But it would be good to get single partitions landed and then
multiple partitions as you have added.

> Also, apologies if these points have already been discussed. I've not been
> following this series for very long, so forgive the ignorance as I try to
> catch up. If you can think of any materials/documentation outside of the
> mailing list or open collab sync notes that would help fill in the gaps,
> please let me know :)

NP this has been a while.  I've been looking for someone to take the
series who is more familiar with the use cases.

I look forward to you posting a new series with the support you feel you
need.

Ira

> 
> Thanks for the feedback,
> Anisa
> 
> [1] https://computeexpresslink.org/event/supercomputing-2025/
> [2] https://www.montage-tech.com/MXC
> 
> > Also, did you consider to use previous versions of my series?  Perhaps v8?
> > 
> > 	https://lore.kernel.org/all/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com/#r
> > 
> > Thanks,
> > Ira
> > 
> > [snip]


