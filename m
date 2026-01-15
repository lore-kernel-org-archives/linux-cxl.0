Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB23D6F24;
	Thu, 15 Jan 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499809; cv=fail; b=D9/QjRMx/g6PfJERnxxjEcCzurolodR5RpTEUfwmBwf9V5dz8pXvIdH4qbSO2ZQzPRQiTpjQvVHNaEXuXKBdqIloGmkVQ0RtRZmuaM97dYLLdyvgp6ewuv1rbEyw5/AbjPvHQU8K1G9c3UCceOD9eLRQEuKTsRqhvLFprJqfxlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499809; c=relaxed/simple;
	bh=dnoD4I4hFjFgnCMPVPfTWvk+nxQ4NZqRA7gpOUijnLE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OoXUN3cC48ce2Vj1wdf7+MFBppLcy9mqQv+JeDToIh+NJgWOcx/yjKZT5Es5RMTmZF2G44u/kLG9y+h2/tzn+VAnYNzl20yF+sofgeEmeBF2Nj8b8BDComeFz5c0bwAOEbwvrbB+lfddRQxTPPx4RBhAK2j4ktD8xC6qQ8+PcKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVb+kSXb; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVb+kSXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768499808; x=1800035808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dnoD4I4hFjFgnCMPVPfTWvk+nxQ4NZqRA7gpOUijnLE=;
  b=RVb+kSXbqhKo0sTGiyOeGg4OX6O1AG2jIOQj0+2XXeEmV1hA5qySMv/Y
   qe7SJeINyZIkaPpXYx/qgJ1chjvux10QLeZskDOr5YDBSfREJJBnGajYI
   L3lnyujZNVeXvBD+n3SDw94OsiDQP8/80FJVY/78G8Dhw0xn4HPUFpLAB
   LpVexhvqqqBfx+JUmvhgFdThPcgKROtDhMqRFj07dr3JNyvijIIV+G6PU
   b5SvkrqEgFBo1vL2XbfgCpo0sUHaLNzzNWCbKImZ9JBzpbbDVMdmTbbBW
   bqHvqFrFNszpJfMZFQYDAjrAsd8boB9ueD2MumTUK4KUW9UUS0b3MZkNT
   w==;
X-CSE-ConnectionGUID: BgSSU0EKTRqT+Rqp0f8jig==
X-CSE-MsgGUID: MhPBsfi5QPqVe4xNzjwhiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="81257996"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="81257996"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 09:56:47 -0800
X-CSE-ConnectionGUID: NzdnpvzQSHWOOcAI38im/g==
X-CSE-MsgGUID: IkbcRKGyRXKbgzc/uztYig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="209494794"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 09:56:46 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 09:56:45 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 09:56:45 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 09:56:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0WIUPniYk25vqntV4QDkW7Gv1rSKIS2JMem8J7ySINEPqN1xYpPPD7vnVXiE8FLer/V4Qt3ix7T9EZUO4ZXphtFVjfZL1aIYu/G8JgD0NJH6hXnPGW0Ob+nQqGoZ8jG5FZfxC1hhMisGG68vG0L0yAEvn/XP7xYZGOzrdaAaWX64NiRE7HwCP2hwp0KdDzFNrwYlYB71RU5OU2EJ3n724pgBw1BGCCVem/5PEX29bFNxC91iVB/yuitNl1oMKvTSudtVa8ealbiElBuvgnTWODhIAPPCiVyoRTa/OW3sQh05CLiplQ10oeV/Gj+UKgOC3swMxlCM6PCyPL2RvjYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/9zVJ1rf+3KCuhGeFNBBIZoA7yYXLKPQlZ9dOe9xN4=;
 b=Riem/FbqvP49uIpfq2HjaIX8/9W5Z3Xb52skJJ/0pqXzK7VxDvoHgWne2yM7WSHk7geGlxvp+hsRgiSUoB+qZU3tVb28bdCa/0c81i9rssP0X1kk5n2T6VbjUifnJlvdyHzemDbCMvaz1ersaLxshbCpBhz2RrpEQjhX+A9aMN68Q8+XFWhEsWyOFNFhv8PwwR6Qc3EhuPSstVN2XMg7fCZ4nBFSxVlAo1l6dwFCkIUw2NPzNZsagefcpZDyFCZX4LyuSdUPgo0ODnYM3Ejg5xFRr0lyZNyHw/0gDur0jN1Pz+xkfKvIzzadrecJhzUTjZhZQRLPSPKMYXlda0teeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB8965.namprd11.prod.outlook.com (2603:10b6:208:582::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 17:56:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 17:56:43 +0000
Date: Thu, 15 Jan 2026 09:56:36 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi: Fix using extra xormaps for address
 translation
Message-ID: <aWkqVFud7UA5CRie@aschofie-mobl2.lan>
References: <20260115131648.620177-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260115131648.620177-1-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:a03:331::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: c93e6609-af25-43cf-f3ac-08de545f7133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3o3+4MqNd/16UYzJ/QCJ/tim1vv3Xjvnyv1G4a6VKwYk3Xeb3iwncN4hWP0q?=
 =?us-ascii?Q?kjyJmZaTMuvRjKCGZYt47+YKrMglVV+uJlqp1qEGTbLaqM3sNE7EFyv9v/+b?=
 =?us-ascii?Q?2ruy4SloOn0hwKsvvOVxdbKeDzwUoQqlj4Nj8kxaghYC8D4iG9nK4EUyAFvr?=
 =?us-ascii?Q?GQshyYXZPn2Ka3mvQtoFryNvcBwqQrGl515ur92JstZWzUGyNPb9kL2yeHSX?=
 =?us-ascii?Q?FkugH+8gIPKJUOoClGi50PNGEMjhzADAJm0HGhp4vHX8qTgVn8X/pUHGn5Pf?=
 =?us-ascii?Q?S47/eOLa2pZyR1olhBesEqeDPr1yrIKTKq3L+fExRCKYSTt9PCCyxaKV/lbg?=
 =?us-ascii?Q?m9e9UnetT+aiHjDK+UV+e3b3UpnqvMb6Lhkh3dlOKUjMOZk3IaRGTqjLlJ6n?=
 =?us-ascii?Q?/NF6+nckHLHngqR8yU7pULL/Wh9OE7RzxxdHufnk1rdb6VDydW+91BYcDDfi?=
 =?us-ascii?Q?h+KQKduO/e9O/Rz15HdyVdgit+EMG/rasyiatt5uibuUXj5fwFnt+XKxfIBW?=
 =?us-ascii?Q?U194Qulh78twDXuWxsBMpV23xn2x9/ilbrba5SDvkUrLIvQt9Pu+h9fJsuZn?=
 =?us-ascii?Q?a0SEjI66r3TymGfJ56sDnUUj6pTX7ozKfefXGmnEDCvGJ9ycwWfR8KO9nd3J?=
 =?us-ascii?Q?AReUnHCN5RKmtCXzx02gIq7YrWS89TP2lEJxYQO4fjB35vEaWVUcWbrbzjnn?=
 =?us-ascii?Q?7hd/zDi8oeYDzgQpmOCfufWPN9J44o8oOzpsWeg+6fWGUboQ0mCk/UnDeBzO?=
 =?us-ascii?Q?15RuUmlZ5lJ6bwWW6opNaW0RFqdlgo8ZJ7oXfLUF2zGWrjdLvB/1/GqUIyWf?=
 =?us-ascii?Q?h/jfmVMSqIvFo+hSXsAlEvb8HaARG39Rad5Ix6zh7FQ0Jv4+Hv7T3Y9B6s80?=
 =?us-ascii?Q?MtoI6WNfmJZimRiG9Chw34OfKA98xOgDYT5BWglEl8tmzODxjgj+x3Fi04As?=
 =?us-ascii?Q?JVS2Ci4h+u8X0ZeJXYvuDyUCwHnqqD57iAHoOxIssq53V4LcferkGQ8b8PoJ?=
 =?us-ascii?Q?/PE7W9vdNdlDvNWlw47R8ysIy+qo3VZQw7mZ5eqd/9fS7RLFwvNmmOXgOVr4?=
 =?us-ascii?Q?0w3QVYoCAHyvMtzGJpidamQNqBaMGxvtSawykfAM4vKIS0NPyyP2p1RDa1XC?=
 =?us-ascii?Q?m8luo/EF817aXOdtJgGREmkalLeSKs1tfEGICbhFzyBE4ovfAWpKqp7omf3O?=
 =?us-ascii?Q?kVH9uJYUNIC2ceVGjR6FkPVZ2ftcXZW6K1nKM1i2LbCPD+R4gwwofCQm7nP3?=
 =?us-ascii?Q?+/aDca5Sh1qA0UL/GmW8uIar9KaSy9ouR3JoEgsztRgxZpDJFyTLxtnT/Xuo?=
 =?us-ascii?Q?+lPeloKEGsuUMN/cUJa57KwXCeK+Xxs3NoG7AXuxCXYiACQzcLs3uR6yHUAF?=
 =?us-ascii?Q?fHv4YIRu6mg6Fr4CSGvH5vSzfOZj+PLukVv+Zc/lqmdoXHfYTi+oYHMt+fAr?=
 =?us-ascii?Q?9rAPNg7kVNmJZ8WETlc/e8CArWS5kGgzYxTDptukUiqkLV27yBIe4FYb3cA5?=
 =?us-ascii?Q?QFN6tpG7ICcVLEnjGhGY4+Y413uBaECqSTwVPPmMtmMwZbest5zi+CCyz1Ff?=
 =?us-ascii?Q?x2wWlLPxIVUBOqw/lvVwWkLTOe4EkZ+jDGe7+Wdg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OIsmrcBMzPs8/RS9Ix5aLjygsxfd0ZhmSTLOBSkqikC760Sk7XoWqI78lg3q?=
 =?us-ascii?Q?NPQCP6/dDLnBHsfAfkPHxNWFYNopMstVURkOzctA9t+I7IWBWy4IXATNNdIm?=
 =?us-ascii?Q?MaspzWgWuQTmVko3/8MbIgftQKGgFMpfII5btxDBgv6W+lTmsf093OWQmsfI?=
 =?us-ascii?Q?DPpYmSac6MMyyRwC4ono5HX8CCoG0ERH6g7R+4lu7NcJ4VzeHExYbQlEx94K?=
 =?us-ascii?Q?H+VljbmDXsYO5JnLKsRe6AWu8t2wUQu0xyflPN1RZ8th9QI4cQMMY5g/0Ife?=
 =?us-ascii?Q?zXsDAxBdVz/RoVgxgJMjnB2UyXROC7tqrvALBlZw9JofcCYF+wlXQ4sM8aYG?=
 =?us-ascii?Q?37VLxIyuuRY8UxgoMoYu5pt1H+bSLDEuXJ8WgO00MUGrHlMnd9mbBIWIz3sU?=
 =?us-ascii?Q?4agu8A4+rBWlHLleBwol364YFRXmR3+nZ2BxHxUNpmc4QRfPzaKNREacpVu2?=
 =?us-ascii?Q?NY89Fi8CfqgAQZZ48bRXDpadfLYQ2n1PDzIVeTby6oAZ0aeZISSj55xMkJ4z?=
 =?us-ascii?Q?hXOmfnP84TT9wDa1wtyq1LCnSz9xIioT5HPtvF4Hc3pNaPalNCCsfcjvJzdi?=
 =?us-ascii?Q?w8h4xkMzCRfyOpvPP04O0LflORYICNQZBIJD6FjE7Jp9R0hoS3kqokreRfxY?=
 =?us-ascii?Q?TtvfR0TytbI6KgNicBAoU/oMt965w5kcbDPnu/vNde7dEjYN9k6jZtBRByTx?=
 =?us-ascii?Q?iGAgbTEyq9bJ2U1hPBjEyAhzNQHEIQvXlk25AVxlkzwQDSRJzmvxMSQY2vXc?=
 =?us-ascii?Q?WumAIVlS/5yQdURKWBd/MdqXyfcZcGvIKfEW4fTqBXf4zt4Rb0ieQZvyvCFb?=
 =?us-ascii?Q?sPj0ULDCLk5mw2vmbQIfvM+fo1BLLh3Sim6lSm+BS97REI1reaWxxo0CjCq2?=
 =?us-ascii?Q?4lpRNznsIqlB4q/ErJ8Po7lE5GEGlwsMrop+RmuAh7noMgyxTpeS9XUeW9RL?=
 =?us-ascii?Q?9zONJYwzidEp0uA2R54NBWUtKS4b8HgHz/uCX9XQHeJ2HpWmc0PKH7aVJJn+?=
 =?us-ascii?Q?uWY9F2io/4f5SJpGcQe0S4UVMX2gZ1H9cAMX0HJkobasYTFwRIYVAyN2eepX?=
 =?us-ascii?Q?ES78oX44Q3QSEIisIgBR0gmGek+gsf/hlo+0GeQNfpNGvwhmA4XEQHsekjSz?=
 =?us-ascii?Q?YKDyiUYuR4xffWq0OOZuij8PLdEWXUNnIHHr5zkq9/86hZXp2TkTHfs0JA7H?=
 =?us-ascii?Q?BUEboxsdd5j+WgDOu//mgDDkcbbK0UktDiNcku1ccFEsq9ZDj6N/E2//54N0?=
 =?us-ascii?Q?EYTXcpaswBKNWvTPyjd6OLBZZ6P0PKNfgjH3VBkExeenEsNLuPsKyTDoYDdW?=
 =?us-ascii?Q?SpeCFCIWgGc9ZEyqXz+thUug34L8JvlXV4ltxxIQO0t8qkX6+wwVyKlcBrBF?=
 =?us-ascii?Q?FLcE1mgWPIBkjWMdmmL/TEKeYQwfhENH0tyX9WTkX4lxk8SFVNAotAQ8Z4ig?=
 =?us-ascii?Q?Jz92MWk5YdIZ6ycr3LEaYtdKHBTfazVnrBc+DTRNzgQoTUND29mkpy0WrO7z?=
 =?us-ascii?Q?YhOOLRLnUP8lkTiRfkXnXc9zG6T8J0jnqU3M6u98j70SYwEY5y6UOV74qb1o?=
 =?us-ascii?Q?e3hnSLN2JlpgCazpWdYdDrMTRaUk+POYfYjoSLicQGJwaCzVgEGNlFWCn2er?=
 =?us-ascii?Q?iR46VWUG8OznTi+kfqmRHPI3/cKdTAF4MNTiKOfe8Ud19qSpzq/jjpCSJ2rk?=
 =?us-ascii?Q?FMnsbcRmviG/W3Q6oYCyd9IERr27g33Ccf25dcWX46JIZuk0uDJiLTfZz6lb?=
 =?us-ascii?Q?c3/cWaoj3ulJZ59GuZr8kiz/oScBiqE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c93e6609-af25-43cf-f3ac-08de545f7133
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 17:56:43.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KY2bcmjBYcvsKfJzBupHYOQYSeRml5MJtsJvNntwS67EHvScmZsPJB7oe+DhSYOSjNedD6hJYOHDNOspE0MVV6BbHxz2dt+0mFNz5zv1raA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8965
X-OriginatorOrg: intel.com

On Thu, Jan 15, 2026 at 09:16:48PM +0800, Li Ming wrote:
> CXL r3.1 Table 9-22 defines a fixed number of XOR maps for interleave
> arithmetic based on the number of interleave ways, as reflected by
> hbiw_to_nr_maps[].
> 
> The current implementation applies all XOR maps during address
> translation, but it should use the spec-defined number of XOR maps
> derived from the number of interleave ways.
> 
> Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Ming,

I previously sent similar patch and then recalled it for the reason
described in this thread.
https://lore.kernel.org/linux-cxl/26c7ca6f-eb5f-4f20-8dba-e62e43e3e1b5@intel.com

The above was all before
	"4fe516d2ad1a6 cxl/acpi: Make the XOR calculations available for testing"
where I added input param checking and introduced nr_maps_to_apply.

I don't think it is necessary to use nr_maps_to_apply in the
for loop once the params have been validated. So maybe this patch
is a cleanup on commit 4fe516d2ad1a6 rather than a fix.

Please take a look again and let me know if I'm wrong again ;)

--Alison

> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 77ac940e3013..5f84d01e7d39 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -61,7 +61,7 @@ u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
>  	 * bits results in val==0, if odd the XOR result is val==1.
>  	 */
>  
> -	for (int i = 0; i < cximsd->nr_maps; i++) {
> +	for (int i = 0; i < nr_maps_to_apply; i++) {
>  		if (!cximsd->xormaps[i])
>  			continue;
>  		pos = __ffs(cximsd->xormaps[i]);
> -- 
> 2.34.1
> 
