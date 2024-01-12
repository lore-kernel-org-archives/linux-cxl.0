Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B617729
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCMQBHYk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705098479; x=1736634479;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vfYwVLmBYNSLr0lSPNZbjtRanbupz8wr+ac8UK2afPk=;
  b=XCMQBHYk2B0CGLxp6I2+QCSDFWc9ia23/chkJs2hGVzgxPqiCnM42PdF
   /a/f92zvhYV6Bf99YgyiiooSuneKwBdANxAgg70sUmayfn7cJ4Lrfcy/S
   v681yAael7PhoDtf6iYHm5+yjjgMEo/72e28KU5cZ3ygG/zOQcS8w1kXX
   RHWy4LNHBGtN+uiKC5f2upwgok7NiOfIVGMppePtCZe3TOGT7Pb7zm+dr
   eoigywCkpLHfpEkZE+IoCmZiR8SOznsCuDvFEReSY05TZG6Hi8YJ/rC9f
   Uz2hmJSxYZnOO7J/RqAVtwUI1vznqnLVVBQzreQtchJ67fac4AV/2LzII
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="12786211"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="12786211"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 14:27:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="873506141"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="873506141"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 14:27:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 14:27:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 14:27:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 14:27:57 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 14:27:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/ZHtsjtLqENYNUG41i3HC+Zh2H6jysJROQooxJUndJDomw8dEj1zRgp6hz+k44lqsqigXw2SBQHElGo3tNGYumFxmwVXusP/BU8SUdFR+hHCFlAB1Va9PjsO7IgEyzW/AdHIgnmPjvbfARLjg9fyHZYzLi12k5PQfWwvj4J/e0gHjNyhFZMxT0YpGP2Sfhr305xWw2ddQdqHarRNAy0kKj6Ete+l2WRNV25t4Yup/QlfGQWBjxE8oy2/xnehMt36SfiCXNdt4/EW+otgnpzyCmmtjoV05MVhcsYmnAMTzjg3kVLB8aZD4ok+El1thvmuwdzKTN3Uyf89kVWfigCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br2itSudssQ7Oz1xcVV/ktTR8SzQFyymOfNCZHkRd1o=;
 b=a1cdeFtEohqMCm9vBVGSa0QJxJlnvWMTbeKDc0QfPRt7gdA7osAh9AB8K1EPoy0auw5dAuUiG4fJfvjbyUD4J84b8D7CvrlfIwa+sw8EUnrRRszPmGSHfzzQoLoOAdUYURITPPwDuKa4mnsvVmMxdSgtdHicBWFqiUJ7MqPtDEpIlTXbnUy4UlRRF2WTf798D0ucDf6Vtatolyptcv2oi0NKjPPX5hFrfS/vgyzkGj0ydqsYK4tmNiyLfHYRcROdp9dv8jIpzJ5rHYh4E+6djQtmdfq8ihQwuvFTSHo2wI3u9fyAlZUZMPHGlHeCWD9jb9uJ0VZFTjNxkcG14XDcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7763.namprd11.prod.outlook.com (2603:10b6:610:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 22:27:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 22:27:54 +0000
Date: Fri, 12 Jan 2024 14:27:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Mike Rapoport <rppt@kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, <x86@kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 0/2] x86/numa: Fix NUMA node overlap & init failure
Message-ID: <65a1bce74f420_3b8e2942@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1705085543.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1705085543.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af1a6c6-d987-421d-01bf-08dc13bdb817
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpJ16eZHRSvghsYWiD2cBM/H5TXD/2bZLdLat8qCULUnLnG6YlNCcHA2YGPa+YtWsMsLExED+UxGj96dP7oAMnpAjwp0tqA1M9tUU6DMKRt7YJ4NgSIkYL9faJMdTHkoGFOhnLgEeFIGgAwnmDPGfSj7zLi8cZWfgZz+gPaJjGvZVTpXyGgjWKOdnSU3/ZFSmtRUPyxu0PjDMZViKZ9vb8oIfujR/YzE5Jnhkasop+2sYaSVQkkpcTBqjqqCSfF6NfbDU7/qftjUPRcSv6/vwjQAi92+Er52j+OTd+ml7/5BW5NSy7MPB4+PMrJUJDH5N8eVz9RHYEOFyeQgU4s21GvgOdUc28zg0QxDLB24pZV74TeMBgm6XJHD0OA+t+X/R5ATtay5S0PP0OtE803LTkuSvPsdMZN4lvcQZY6MwuOSfGzLxlKy7hlWycYHbxqs0HTm157FAdrSBEKSxiIEHkGpuUjmfBUMk/13uLp6XNkmgl5+PS3Im7cCDhG2R/w6DvdFmM6kxrwQ6WZUf9PgA47lEfcM81519bIl3JBbELrebpB9dvCwJs0DiL6GDzyWvWw/TPyQ/+xFqOU0Vb9HDFkuNDY/kSFEz4hYdNr8fpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(4326008)(66946007)(110136005)(8676002)(66476007)(66556008)(316002)(66899024)(8936002)(6506007)(6666004)(966005)(9686003)(6512007)(6486002)(41300700001)(921011)(7416002)(86362001)(82960400001)(5660300002)(83380400001)(478600001)(26005)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aMElcSE3ztcgkC0h4DJ2Yv5/qfL0edjHvnebmjqvFn2JFbEzaVhbdAvZzADu?=
 =?us-ascii?Q?BinMrmS1kYWaiTcRjlNSghPcw6Rf3oaWfR1K7DNlpy+OX9CmfawXg8jb8KRV?=
 =?us-ascii?Q?yI40Ih8K71pD+DaitrjcCmqDUTv1Nmf12DvdgZgsPLQBMf74KeTGdyA2I+6D?=
 =?us-ascii?Q?/42bYKJTco+XXfeN8esRekipOKLGbxe1vbvXhuoPuXl34xL+QDJ64f9WdXYG?=
 =?us-ascii?Q?Fn2D4k66I+3G6qYMjlJAvTAIF5fH5fvF0yhvggGBa2TtJjRlaT9NVb0cYP0M?=
 =?us-ascii?Q?Qb7blwZBqqKnuwLYUNr3nIao0Y+wJ/KD/drDKMgP3iQD70+PvbRoVTW1mkfC?=
 =?us-ascii?Q?cagP3PNWnOdhiYW8wCKIOKz7f0LLJq2NUXYViF8+7EOWBEuLsItqles3LIEQ?=
 =?us-ascii?Q?ym2WeYjeJETSSQ49KcZO/AKXglwPk4yUlIANk89iTPw8HANJO4UFFFbL+4V4?=
 =?us-ascii?Q?6LvQvqNetFgGK2lb9vlgD9IBfVW1AKDTVPn9QPKobMNnhZ7K5ZKZi5X2pXPi?=
 =?us-ascii?Q?u52hDV4DgD4wifujDo3fiUN2AZX0EzCI8hoyCXHtcTJxHPyPvE7vD3IHbmxV?=
 =?us-ascii?Q?QBU991X5IFYaQ0fCJeUSHyYE02BsNVwWmNElDmn5/D9AF7LdUoSB88aSdFBi?=
 =?us-ascii?Q?pUd1TGQ1yocH4kIC1decg2fwgQ0/eDkGBXXEOA1yViuMwNhYefN9k9Gpg7FU?=
 =?us-ascii?Q?V9vF04eULmcA8jbk8oqH8c6KkTB8/hgY6fXTZwyu2UiEJgNlEqpBBOcMcvkt?=
 =?us-ascii?Q?PVW6FX6vt8W3qovckaxRoz6oWDpyVbIGE3ceraftn9P7258STJDOcQXEFEgg?=
 =?us-ascii?Q?gdy4vab6D8vShgQgRG1fG/LP23MB6QFNj0cnYqG8JUa/6aoN1bbVp4qsJF57?=
 =?us-ascii?Q?nIfywrVxBZEskB3Cd9xOMyDqmkx9lCc2zCKL/37Khx6mqerWBRzQ2qYlzqFW?=
 =?us-ascii?Q?j9EGsC5qga3FAaZl5wan+KJtkPH3TuTOQ+ZultM8Wq5Qp1fTct892uuLgrUb?=
 =?us-ascii?Q?/XxjP4ZKMKkjdT14cr6OQbURK3oI6OGcpTazqa1dPPxfGPWh5ssAt8lFtL33?=
 =?us-ascii?Q?1dXHJx1vHXfPhHcuc0rhQ1VhYCMVN33ZtA6Dpd0CcjNdR11BOmmicGMOIwlp?=
 =?us-ascii?Q?NrtbMqfZ4NsHNqni4qkGr2S9IH/06fATdzUIUSZH+X9YuPNFgO3tOgBaEgpf?=
 =?us-ascii?Q?b5NhabBvpRAIwYnycW7ARNVDvclH1ZpCZWWt2V9VU7dGz5Tw3TEZd6omvZgs?=
 =?us-ascii?Q?vRqry1NcGwCk7VxDs+JGDw0MX6EksVkyGPgasqOOLY9Aqrku2WPfopMtVoQe?=
 =?us-ascii?Q?ML+Zx65qK+9JR6wBT6WwLr9GDhPRBIZAYC3VqONk3LPsGnJaZc4thlHEywUw?=
 =?us-ascii?Q?LhbwP/yWBIwojHwRSUx5JIcB8fD6oXNaKsTSYX6861agkrX2gEZf1gmmBAHD?=
 =?us-ascii?Q?8oLa4TcHuMwl/yW+t+rB9QAVKt+Wg9kevrp7BmGfsjt/QoVwyphz+bD4OkY1?=
 =?us-ascii?Q?cnEH2qg2AhuiYxSQorv7V+pNiy5gMSJ73TvNQkTJoKITO2UR6lv1pasxaFX6?=
 =?us-ascii?Q?X7Q2GoH7FRXjfThGYS2cDoHMFTp0BhbYlGNqn+PzP/x/gjeDdfPZ+XxGLaJC?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af1a6c6-d987-421d-01bf-08dc13bdb817
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 22:27:54.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lejoqKOxlYi9hw6Nu/1BCmNE/vw6e7EecTYwOeXXDv7/lIAxtXEUb08K4DQtg6aZgIAHEpnofgfc8hHwbW8wtxLxsXIq0UeZCKE4MyQ/qqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7763
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> A previously posted single patch [1] is obsoleted by this set. The
> feedback from that review is applied and noted in Patch 1.
> 
> While trying to attribute a CXL user report to the bad selection of
> overlapping memblks, as fixed in Patch 1, I found that two issues,
> in sequence, lead to NUMA Node overlap and NUMA init failure.
> 
> An overlapping NUMA node occurs when a non-overlapping memblk is
> selected to fill (Patch 1), and then a bad sort (Patch 2) puts the
> memblk with the greater address ahead of the lesser address memblk
> in the fill list.
> 
> It looked like this:
> 
> Existing memblks:
> 	node 6 [mem 0xb90000000-0xc90000000]
> 	node 7 [mem 0xc90000000-0xd90000000]
> 
> Call to numa_fill_memblks(b90000000,c90000000)
> 
> Error (Patch 1): collects 2 blks  
> 	blk[0] node 6 [0xb90000000-0xc90000000]
> 	blk[1] node 7 [0xc90000000-0xd90000000]
> 
> Error (Patch 2): bad sort of the 2 blks
> 	blk[0] node 7 [0xc90000000-0xd90000000]
> 	blk[1] node 6 [0xb90000000-0xc90000000]
> 
> Seals the deal with a bad fill:
> 	blk[0] node 7 [0xb90000000-0xd90000000]
> 
> Boom: numa_clean_meminfo() discovers the overlap in Nodes 6 & 7
> and NUMA init fails.
> 
> Since the scenario above is not solely attributed to either patch,
> the story is explicity shared here.
> 
> [1] https://lore.kernel.org/linux-cxl/20240102213206.1493733-1-alison.schofield@intel.com/
> 
> Alison Schofield (2):
>   x86/numa: Fix the address overlap check in numa_fill_memblks()
>   x86/numa: Fix the sort compare func used in numa_fill_memblks()
> 
>  arch/x86/mm/numa.c       | 21 ++++++++-------------
>  include/linux/memblock.h |  2 ++
>  mm/memblock.c            |  5 +++--
>  3 files changed, 13 insertions(+), 15 deletions(-)

For both fixes:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...if they get picked up into the x86 tree.

Otherwise I'll circle back and take them through cxl.git with an x86 ack
since this is all cxl-related fixups to numa_fill_memblks().
