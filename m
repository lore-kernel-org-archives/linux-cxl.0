Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285B310A19;
	Thu, 22 Aug 2024 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290169; cv=fail; b=uDSiYt1Wi5kp370OHaGeHTpC+BItJasKj4iIyteI2UWrkI8W341x6MY9viPqZKb8l6h6ur2WktUNttItDh1wcS56EQzpnpH2xfLHxkbzDrHLVyZ6V39VReymmgUgVgQuSxzdEjhIYFvbrzoMHcV0Rhm9ADFzgTSZArvP+Uw0Aa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290169; c=relaxed/simple;
	bh=tMuNF0ewdJxQgLViIF7tA1P7kfjcYUc0ep1cWjmAeXw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fp1Khoq3V1fOhAXpGy1cDSx4dDhUrUIXLvZbFbGbmfqO2KSMpK6e8erb5AVCgPUIinrzqamhnTDv+UPXKHafA8CRa+Ip8qWUQw2UnI3tzMfmfRZuvmSB+bPvxywT99nFFWDDv9AHEqOG5JMcdd5dx8AcQ0cJO0NmHujhtNYIiSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeXCFpdz; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeXCFpdz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724290168; x=1755826168;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tMuNF0ewdJxQgLViIF7tA1P7kfjcYUc0ep1cWjmAeXw=;
  b=OeXCFpdz7BlqyHbvA6+OARI2Tnepr8RrIfFNuJE94seTsb8V41qHN6LX
   J5MyxfoBWVdw93rvw2p9m61FLe4KzxYXE0uIpqv52xDuAQ7uvPY7qCuqt
   eE6sYUsDnLSl/qZwfnFBH34dmmIrBSKtQ6wa80aPlS2v2OC/qVvhUd5tj
   ZeQvL+JsBsvOi9undUXVM5Hi0tTOngjK5xQa2m+bNwvutR8R+Yc8nRfGI
   wUloeUCbbMnBBp6XrcyYUfEzXpuXrs/pUtswkLoyqZKbTXkcs5rSzlucQ
   Oo+8WRn5UisXnO5pxXpNCHbd8IA7PMF154c+C6OXEqX1zybzKkKKj+aus
   A==;
X-CSE-ConnectionGUID: 1IFWMr7USEOKZ2R5CGE4Lg==
X-CSE-MsgGUID: PJkDgZ8gQ3SZkHN6kR1yQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33299344"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="33299344"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:29:27 -0700
X-CSE-ConnectionGUID: 2YnD5vwjRRifFgIb0FhMVw==
X-CSE-MsgGUID: cUOG8XkGQeyOzS7PT0YUgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61138050"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 18:29:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 18:29:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 18:29:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 18:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFF1mJ2oMFMLLQ6TWDq52Ui5vlLR4WlNZQ1gKlAKiewPsenYacpZbjr3H9+0ahkfGwBC8atMrzV5xLAfRvK55YR6mE4I0TWW27Ds/AImrPstrXRW7YSr1Pealq1pmHITiKUtwIfdriXsQKLg+NIfbbX326v/xlrHO97qhACiaNpvDaLduAw4gTEURAFJf0LxzukzjZPml+d+e1x88T2HCmDcVxniTHpIj024XgNQpRC3bU3LhVxbrXLeMVWbE2Sgqem0NgU0BFppDXFhGoABOMmEp3tnT44d41ZHVBlQ5Ip0/9cWQOjdBEr90FWBfGr0RinEADfcLJM/51kGyM3YuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Non5N6BWLh6gdb+S26rOSE+YVMH6mjn7rd7RHwejvaM=;
 b=Y+WckE4vLR5ZXrrfyirz3hfdZwc2fHRUF9ohIkdrGU9Ggo+Z1fq9ddR0zr8IBJ97ihLy0WnBngl6+j1LIx/Csjx9sDB4cfyGrmAEov2JfljAhvBQiQouwDncF0UXpQLkTHw3IM2TW1oxlIG+1WyHc/q8Gp+sng1aO/edLdF2ZV46UZnbyDjjeBo5Glwl/gJhJJ8RsdVqE6OcFozTtPeZWX2BGYkt71iUd3PRO7KaH0uaCtf6zYgCuxOdhGelAfq/hZeNV4ZDFiMoA53fRpotKC3QAmRyQxsZq9cshghWK00OcRg2r3mvyu69fW2+i0nWj9lJJM/SjgB8jKMRicUODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8725.namprd11.prod.outlook.com (2603:10b6:408:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 01:29:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 01:29:24 +0000
Date: Wed, 21 Aug 2024 18:29:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Resource: fix region_intersects() for CXL memory
Message-ID: <66c69470ae357_7605294ab@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240816020723.771196-1-ying.huang@intel.com>
 <66bedd0f746ab_1c18294b5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87y14wj4ju.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87y14wj4ju.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9429a2-cd78-4d13-0ad7-08dcc249dabf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PMKdxJQtUlsm4sHEleGP2z/rwuQbwBmL1OfLFHPhQ3+HVqCKl2kghEfJjIAu?=
 =?us-ascii?Q?Oq/R/jIy9fFq2Fs6leX9MgkRArSTPMetmT6g9LhWdhFG8MTyNTK+rV/zxJOV?=
 =?us-ascii?Q?QY44GDtwe+EtETd9alELR5bApa1NHFRcUwvgKh2mEKaNrsugFtxf1f0dT5fh?=
 =?us-ascii?Q?qNHfESlGpIpfeRuXDL3ZqYAGhgUuhNOHDGjCdXdqKObxaJkPwutKqpiL3sBD?=
 =?us-ascii?Q?HFTIiS5zju3C0D53K3KHXsdf9r0guWgXaqyh5KeaLPRZfTMRGEkirg3JtRL/?=
 =?us-ascii?Q?Q5IMHfNWeJJy468WXcQeTgow2RqI63cSagAN+zp1aBNqGCKY4YNdO42K1l07?=
 =?us-ascii?Q?cJhew2/X4rRwg/s35Cl64qKLh3fjtX9r1pIIcLbXOmvaxs4J7CU4gCpzdTCJ?=
 =?us-ascii?Q?eUQiPTVYVrjC7fqdqIuQwcoEpfZn2l+FHLY6QPSHfMRsoS3uZ6KhzTNKSaUu?=
 =?us-ascii?Q?zUviYbC4LgJTyv+ygFlQ79IbBh0G7eJ88PlVfk0YiaHkGhzY4DX+XAG1N7sg?=
 =?us-ascii?Q?Pnva+BdJQiGQt4TCWEpaDtd7xt57h2UCbjveggpP2o+u5MqxkwafyzVB7txb?=
 =?us-ascii?Q?ego2fstHXnXTdLIGFuv6T8GL+oxpSU+f/L+uMo8L3BTulCd/GmNbfN89LRWg?=
 =?us-ascii?Q?+Ufvx04k6ikWqtZaTlgFXV/1rQ7FRoesbJiP0i43GGQoQ8EXM+tEGmG5ELXM?=
 =?us-ascii?Q?kRxLyvA+TR7icOVOhbMavtg9XQpluf5WIf1CzKBimvbg1mLEX+LFCc1nKHk8?=
 =?us-ascii?Q?eVdduGmpm+419yZThRHHrHKIRee2rAFnnY4/FM/n2nC7oEWH0PLtF2Q4tINf?=
 =?us-ascii?Q?DijABs5CfrzmoWzhVbD9U6DImb/8ZaiIaldTCjE40njI6c3UX+mt7jh8eHvN?=
 =?us-ascii?Q?bVslVW+bovp6oxPD9KAJuqt6YujdyfkviX5WtZubcD+vq5ZsrKpo1ZmuewJG?=
 =?us-ascii?Q?NPfkx1eI3RoABhL2rSrglPavElxw1+JKwQo6OvDunWAXDywnZ9Pm5AYOyP1P?=
 =?us-ascii?Q?2JrNhN1AMvbLxZ/4oczoYmpVuMdi+JbRzqTJ4VZ3KbJsq9DIFGKE4d2LBnu5?=
 =?us-ascii?Q?SE54w3yOszb5gnZ8BD5P/LQr5me8Ja1LhJ1YXgdPYqlOVzlLafpeIoj/MeOp?=
 =?us-ascii?Q?AyuFyLCJAReZ7zEawM2gPal/Ox3szAXQFAecnAKXUw2Ww8YYvCpQ+kZ1Qsjs?=
 =?us-ascii?Q?Qna1du/OSyerqa7EAwC/SKWfTHnJgBQp6sz43S3Gx9DjszpIHto7HKyrIQzR?=
 =?us-ascii?Q?67Ics78nOxCAn/8ADiVWLHRUNq7g85EsSLqDDeKep87Nqgko0iH3CrOZ1qw4?=
 =?us-ascii?Q?FIJYXsasMbGjpeU1eJKTU0uvzTs3R/PA0RizSmlUCvxsnA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?saAi3nG4TXyJVzmuk4ebVckrGfxgOdQhpRLH1TDyFFb+JMnE7ZZI4HEyNrD8?=
 =?us-ascii?Q?e6e/XSo36WB6jwXdtIymxOwhTjEDEAiZzxclk7SPavK5tJuRjDs0t89dgfpO?=
 =?us-ascii?Q?oWe9f/p8u5yxTExIf1Po038kYhKgfbhB8tuaIqgqSXPs7CEyRUfZ+BW3Lqrt?=
 =?us-ascii?Q?YyJx+PI70eAJcOUIQ9jda+7qdejT37spkdE679pZlbGsyzIFgTNjJw2u0jVL?=
 =?us-ascii?Q?aj1kb35dJiRvk2RoVIYPgUA9isV7Ne4RZwyFsypKjM6Ogx0AeY0fKDPeIy2B?=
 =?us-ascii?Q?9WiRSC4FhhyrAkyRoba0dMqtLVrP5exI3hAEl393iUBXaYffyUNUADV295C/?=
 =?us-ascii?Q?d4RG6WauP89udpzWKYveIakKGV5sR7uH/JwqXlkeZQCV8/cCauir5F4CTOce?=
 =?us-ascii?Q?U2J93tvVNAdDbR2Wu5JrLD1dujOKuvO3nBoyG2IV+8EyX5wBfXLc1p7lOLk4?=
 =?us-ascii?Q?7d5NkJ1Nx3Y9RXzbxgeb2P6sc2ty9dmpZkAaMzJhaxR0l5oYRO4AVzNVL/qn?=
 =?us-ascii?Q?+BpkcHO85AmSCa2afIuDRd0NnE66iWXheb/hNyey43HoNC1M7P/IciN1Usv5?=
 =?us-ascii?Q?EYoyE0aSQw4RcB//mPEAH6UsZuWwqGcMHEXkdo0X8i9PPoDvCc45HEL/NOJ4?=
 =?us-ascii?Q?3lBgnrKLGG76ScPeS8YaX6B8cz7v/HoTHYaMqmZlU34gEnqBvwOmdUWYCjQU?=
 =?us-ascii?Q?6WWNbf9Rgig8m02bSoH4HYLIcmpJ+QicyTi5XYz+vfU9DVQV33wvU/04wCIY?=
 =?us-ascii?Q?BQ/gIgB63cn8NkQ43af1IXCiLzaxJ7zzsfQwbI0Q5HMEuUu1f4YGxluFhIX/?=
 =?us-ascii?Q?1X2SSheyQiRLc2UtQKx6NR11X0j/v5aHdAZR3HxUFlBkzLbs1FeSWMV0GuZL?=
 =?us-ascii?Q?/VdieuGJPAUJbAa7VbWfK19FpC2erLgOkuaWMzwW4Tv6D/yl13qcGCJu6Khu?=
 =?us-ascii?Q?ZKrhoX6Wu4IBuixX1/FhGkp5ffr3tCOGEpeJCNqK5wS5oYrQMlGVlYpueoWL?=
 =?us-ascii?Q?7VJYUfPhpQSp8tw0jFRrcBcbuJbDmEWcKA+IdaAiJFyBC6DaaSFdKZWD1IU2?=
 =?us-ascii?Q?+YO+h1xWqrOsBV9W/OHzkzjNrI4f+wsow6YEcSScHoCKeqBM/c1XiXTP6NZC?=
 =?us-ascii?Q?32i+EbQ7kRQdyBrtzlZGvsE8HaLE1ZUS3AKoVDuE2nNNidckdgw0jhl8OX6Y?=
 =?us-ascii?Q?4D5zxlosx5fHpdCmt2NSgTwxgX26Rg2y3SOPMVgNWCmmG41xDjaqDTJT4MPn?=
 =?us-ascii?Q?srAX0EmTJhZCGij2rOLv1206QokVkJwMw8fHfIqT44fIejaQn5xH8Omdtyvg?=
 =?us-ascii?Q?ymqFcqKEjlCxAUJuEZx3PWEDW49CqObVvNVo4SwwtZdLdyTkISJfZ0FkI2ii?=
 =?us-ascii?Q?xasQH3BceeS+uwCip17K38FzjWLJ1I3Hmu9ne1lBYe93hpuspxmvRcegSsjD?=
 =?us-ascii?Q?0DYUdHnq8z6nRmAS7pgBuG290v/wiaL2EH/QcTIRcqzV1LVTmprFBHKwvB0A?=
 =?us-ascii?Q?nUZxLAkXIP5sLdxYi5zqIQDatRyLnnLwDNTMqxj1m3buT1GK8eDNU6k/u5ZW?=
 =?us-ascii?Q?aVLCujYsPGjv+lEHM8fijYbMSxHdX4UEfkqd7HpBN11uajMHLCEmTqamXmNa?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9429a2-cd78-4d13-0ad7-08dcc249dabf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:29:23.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzsvbS6aLdYZnUWeQDNUOY3rPuz1ziN1t+xKdiPk531NzqlsETyDVoK5+Bb533CES45gHwj/Rvf/hUn00KVtAHDc7sy6hQQ4nIA34Lxtyv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8725
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> > Huang Ying wrote:
[..]
> >>  kernel/resource.c | 44 +++++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 37 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/kernel/resource.c b/kernel/resource.c
> >> index 14777afb0a99..c97a5add9394 100644
> >> --- a/kernel/resource.c
> >> +++ b/kernel/resource.c
[..]
> >> +		/*
> >> +		 * Continue to search in descendant resources.  Unless
> >> +		 * the matched descendant resources cover the whole
> >> +		 * overlapped range, increase 'other', because it
> >> +		 * overlaps with 'p' at least.
> >> +		 */
> >> +		other++;
> >
> > This results in REGION_MIXED whenever the target of the search is found
> > as a descendant of @parent which I believe is unwanted.
> 
> This is not the behavior of this patch.  There's a "other--" later in
> this patch.
> 
> +		ostart = max(res.start, p->start);
> +		oend = min(res.end, p->end);
> +		for_each_resource(p, dp, false) {
> +			if (!resource_overlaps(dp, &res))
> +				continue;
> +			is_type = (((dp->flags & flags) == flags) &&
> +				   ((desc == IORES_DESC_NONE) ||
> +				    (desc == dp->desc)));
> +			if (is_type) {
> +				type++;
> +				if (dp->start > ostart)
> +					break;
> +				if (dp->end >= oend) {
> +					other--;     <====================== HERE!

Yes, I missed that.

> +					break;
> +				}
> +				ostart = dp->end + 1;
> +			}
> +		}
>  	}
>  
>  	if (type == 0)
> 
> 
> That is, if the overlapped range is covered by matched (is_type == true)
> descendant resources completely, other will not increase.
> 
> So, for resource tree as follows
> 
> 490000000-52fffffff : CXL Window 0
>   490000000-50fffffff : region0
>     490000000-50fffffff : dax0.0
>       490000000-50fffffff : System RAM (kmem)
>   510000000-52fffffff
>     510000000-52fffffff : dax0.1
> 
> region_intersects(, 0x490000000, PAGE_SIZE, IORESOURCE_SYSTEM_RAM,
> IORES_DESC_NONE) => REGION_INTERSECTS
> region_intersects(, 0x50f000000, 0x2000000, IORESOURCE_SYSTEM_RAM,
> IORES_DESC_NONE) => REGION_MIXED
> 
> Even for
> 
> 490000000-52fffffff : CXL Window 0
>   490000000-50fffffff : region0
>     490000000-50fffffff : dax0.0
>       490000000-50fffffff : System RAM (kmem)
> 
> region_intersects(, 0x50f000000, 0x2000000, IORESOURCE_SYSTEM_RAM,
> IORES_DESC_NONE) => REGION_MIXED
> 
> This isn't perfect, but it looks OK for me.  Because for
> 
> 490000000-50fffffff : System RAM
> 510000000-52fffffff : CXL Window 0
> 
> region_intersects(, 0x50f000000, 0x2000000, IORESOURCE_SYSTEM_RAM,
> IORES_DESC_NONE) => REGION_MIXED

That explanation makes sense and matches my expectation.

> However, I admit that the original code is hard to be understood,
> whether is something like below better?

I like that this proposal defers incrementing @other rather than
decrement after the fact.

> 
> 	for (p = parent->child; p ; p = p->sibling) {
> 		if (!resource_overlaps(p, &res))
> 			continue;
> 		is_type = (((p->flags & flags) == flags) &&
> 			   ((desc == IORES_DESC_NONE) || (desc == p->desc)));
> 		if (is_type) {
> 			type++;
> 			continue;
> 		}
> 		/*
> 		 * Continue to search in descendant resources.  Unless
> 		 * the matched descendant resources cover the whole
> 		 * overlapped range, increase 'other', because it
> 		 * overlaps with 'p' at least.
> 		 */
> 		covered = false;

I would call @covered, @single_descendant. Since @covered is ambiguous.

> 		ostart = max(res.start, p->start);
> 		oend = min(res.end, p->end);
> 		for_each_resource(p, dp, false) {
> 			if (!resource_overlaps(dp, &res))
> 				continue;
> 			is_type = (((dp->flags & flags) == flags) &&
> 				   ((desc == IORES_DESC_NONE) ||
> 				    (desc == dp->desc)));
> 			if (is_type) {
> 				type++;
> 				if (dp->start > ostart)

...this should have a comment:

/* partial descendant overlap indicates overlap with a descendant hole */

> 					break;
> 				if (dp->end >= oend) {
> 					covered = true;
> 					break;

...then per above this because easier to read as:

	single_descendant = true;

> 				}
> 				ostart = dp->end + 1;
> 			}
> 		}
> 		if (!covered)
> 			other++;
> 	}
> 
> > The semantics of region_intersects() has always been within a single
> > sibling level to date. So, I don't think @other should be incremented
> > until @is_type is non-zero. It follows that if @is_type is set and
> > !resource_contains(p, &res) then there is no point in descending because
> > it is known at that there are no descendants to worry about.
> 
> Sorry, I don't understand your words here.  Can you show your idea with
> some examples or pseudo code?

I think your proposed updates address my concern.
