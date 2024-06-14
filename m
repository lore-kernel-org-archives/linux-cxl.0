Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C465C
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718328157; cv=fail; b=Ttu7MmwgIj8T5cwh1TORZijfHd13YQA8hKytXGr9/2BHjiSl51owp/le67o5TPPBVtaR6z4/ET1EUTmRqSftRIYHYn8b9hACCHGaaSulfKPZW5dH9gMZjtPCZeY8/eugrYvfisl4x3p2gIKOhjjEyfc76N/RHCJA8uIRqXYdv3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718328157; c=relaxed/simple;
	bh=jvZPCEFcyCEq90SXJSdgxtL7jv7QCwrusD7I17fKKBg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WcLijEI/b6qR78ihTyzUAdv70rkNe5e9dNIr984RzmixSfhw5f7i7plaZeDjz8YqzW5Fq/GL7NAFjaTUrNB0jog9wnN4ofvcz0Z/tvA2O9LZlHlI2izVhDgSR5fynqyUmoh14NO3nLOn/JPPT504OvfsUcXniMkbo0DtKf/pdzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nszyj5/y; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nszyj5/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718328155; x=1749864155;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jvZPCEFcyCEq90SXJSdgxtL7jv7QCwrusD7I17fKKBg=;
  b=Nszyj5/yM3QeqgltWD4K94yrd6HQOk4A/jokGFUWeF0cGg5e6ND+0T5v
   /IA7JZseV2jCrWiORrXvo2S6BnsyPTjjNe6xVhEkA3msweCEZxutEkBoo
   a3TEOrtXcPBNKQgoXOPPh1BXUKYqB4k833IQCe7RNhzKrojSBuZUZMXkO
   9CIzJbbO5OwhOtppPui3aCm/kVCnTMFC6hNUfIaish2N6nZzgBNGby37Z
   I1413NfgxWuBsFZ0pA3nBCjfIQt18KvVR8fIvS11W7dwciWIuwcrqMGwE
   Xijv7Tl7h8DgUz8bBVYEohyVVDZ0BSmw20FkKmQBYUarLqFNPFXYvCZVd
   Q==;
X-CSE-ConnectionGUID: OMkVdnLrQJOp4ytRQCGpBg==
X-CSE-MsgGUID: 5uxxpOSjTti3dHoHfQVsWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25872623"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="25872623"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:22:34 -0700
X-CSE-ConnectionGUID: Eu+4CtwXRYiLRWPbUfsQ/g==
X-CSE-MsgGUID: BDqR4FJrQ8qtZzD8sFtfHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="44763994"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:22:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:22:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:22:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:22:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:22:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHJkGoxJrirNKsrEBK38sRZAkaeRpqQouEQuWCSnOAtXN012kjItOznA1nY1dgv9BsAYYgH4LfjIxbcEzDwMxFSRxuy8T7cBF9VU1M18qlT1ANXtCA2EEI2fUvSkWttPhbSi2byqXen2yIaqvzmuS+njEjiD2TyTeR+i2K2+uCGfjQORpptMF9lMfmWSmBMEf/xA6n8RTygO9Wl9bzUMv1iSvrFe8wc2v9b/2o5M4AFThp6bfeA9jgwLgg0sRATnmSkXROQo8fxwttZxDeVOoBoH+PlT1Bh4PsMs3kNrkBp6Ea0ElWS+B5F0QCcDrHWdegP6v6i/UZlz88hB+Brx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWz3m5pZhQe/c1uiXtALTblweGOk0R+4o+WG0Vx0iyY=;
 b=bt3JktWHTFqBUtFpb5sLggnOh+TiXiY04e0h6ljkEni8B0w9DDnADn9DOv+jh4jXEy6IlOY5GojkFPuonCEUJGBsGFf2QbwF+LNVBVQQP1RpaLMU4h8ersH8s3ZrwnrykMU1R9KWFM3QMxbFA/uqveXlVSgJ/BUJCDng1r3Zde/RZqN9BYHvCt9ELl3ncZKgBu2Ii5g+9NeV+sUnjV2mcDhUtLCijJrs03rEP5Pp52e1pFxJAjzJwByTAsIdBn9pk/Sjh7gp86azqAxFyk+Cy5wfk0z5HSsipxy3NbCYa+cAtmzNDxu7JaIL5y0PHURHOXjD4a+EvIJ4qPorlE9lyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 01:22:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Fri, 14 Jun 2024
 01:22:31 +0000
Date: Thu, 13 Jun 2024 18:22:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Christoph Hellwig <hch@infradead.org>
CC: <linux-cxl@vger.kernel.org>, <pieter.jansen-van-vuuren@amd.com>,
	<richard.hughes@amd.com>, <dinan.gunawardena@amd.com>
Subject: Re: [RFC PATCH 01/13] cxl: move header files for absolute references
Message-ID: <666b9b54d59bf_1fcf29499@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-2-alucerop@amd.com>
 <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
 <ZmkkaOTUFuzIr2cG@infradead.org>
 <666a1099c94e6_1fcf294e9@dwillia2-xfh.jf.intel.com.notmuch>
 <b51be5ca-cf7e-bd93-108f-1713e04301c3@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b51be5ca-cf7e-bd93-108f-1713e04301c3@amd.com>
X-ClientProxiedBy: MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: efd8c8c1-48d3-42a1-e838-08dc8c107671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hJicBTnRRXCHBqnPAwcLkInp23QNfK72E7/xO4SEEr6yvdm5gTmWQE4iTx5H?=
 =?us-ascii?Q?Z/M0vaPI8yXZNpdjRzDwaCg0my/fJMg5V8yJZbc+rccKkHnovjTEJ9HxYrnI?=
 =?us-ascii?Q?sKgc/xlKXgGAgu8sLHIHxargugT/VCoQc0l117/uSLHhJb9hM0AEUQh4eY0P?=
 =?us-ascii?Q?f0ZXZmTW0gWEm148Z1gQ4LLVNa4bgBFNdj+/Iv2lNVFpWP/YFKi8r394A/mO?=
 =?us-ascii?Q?zEWPhqptaGXdS7POGFXAW1i7bHaRtyIYa0n+bNuQKw3Gg40rcDbUQTIUmqdS?=
 =?us-ascii?Q?PtpKrOib9RpJ7su4ni4OOxA+HmD8VL7MMJxxoX2MNBKywmmWqGy0ZOjn8PAI?=
 =?us-ascii?Q?2Ep6tnkJSiSvXHIjnK/zYqskO81a7LGBIGi00HyvbWbQUPMPZxvM2Djj6pOw?=
 =?us-ascii?Q?U9rWSn8tn5JI1X0njLhrGfBJreS59TSDAnLm0SBjPxKnewpZ6n6wyIRznvDl?=
 =?us-ascii?Q?4JHp4nhMmAOBbh6WypjUl3xM7ZfkQLKieAkFJKw93eV78pzB/HyrWX3qvy+w?=
 =?us-ascii?Q?IJzv56QK4UtN30NnUPhW06G2QG9+h6CO0ab4dqjc4ak39Rjpl+7O9v0udWbc?=
 =?us-ascii?Q?gwDibyfLhsxB/42Pgzc4HUij2Z4bQ9Hm3jr6SER4wCzY0wjSNvM7mZkZFdsm?=
 =?us-ascii?Q?LTn1bp85wvt9KsOMCVR7WLqjimYsvTNWkuq2lfOMrOpaZIb0IrFGUKzM7lHZ?=
 =?us-ascii?Q?YSe2rEXJkXquS29OqnHHXdDdbOoP2c+pJC0n8Mo6h6+M6z0AtEKNj5PwEZLU?=
 =?us-ascii?Q?mQSTHg+ORGXatMc+eozikEsai5wBS0CmpjoRZoWU6KC8TB1vo1m22hE2vKbv?=
 =?us-ascii?Q?DXFnODOATMHERmTos7qEfj4IPb+q3Rx662IoJkseGoI31sSftyT5hZR5IHm1?=
 =?us-ascii?Q?BrDXyap63dY2SZbioJEPvdj4W7ZSPLFa8ewkYaQ80FmyfbePs6aRfuE1J25/?=
 =?us-ascii?Q?Co1QSmmyIEd0yHbSVVrK24N4JynjAwyIO3xJBo3z5e6j2xLRgpQPKG9Kw1Zg?=
 =?us-ascii?Q?akgmo31O4RmheJoMgdOD5DB0Xf5dwzlpo+i3TlgSu7uAvns+rn6MdynVmjvk?=
 =?us-ascii?Q?2Kbz/mdyzw0BLX53S7SrbDXIRZ3ubqa1hkiM55ZLh82olHDmovkm8zAwdMf3?=
 =?us-ascii?Q?S1xaghCmt8D2+dh2jCVX5OWcyXstmSiOR3toCC1VAiji/zsqiAsPP+LC+cAx?=
 =?us-ascii?Q?zo/dcJ4q9+EGA7eDWOS3jtUMNRrrYxW55yMg3oFuvJ0OwlWZQCIogatAFlvN?=
 =?us-ascii?Q?vamCZY0vf6l178lNAtQ63Q/f9h9QCaVU4lTbafygE+tITQfFmeu2+BfCVxeC?=
 =?us-ascii?Q?ImWsGGV2fI8LCnsTAVnQ48+g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/R1Uw1noK1fua4QP9Br8EpHxrZkL5Jr3AEDeyoQLrgjs2K6M3wekKte1WVKA?=
 =?us-ascii?Q?VsT1RLk8sp+T5RMPJvVIHCVVkdH4rcHlhxZXgbZH/kKLPw1NI2CKnc1vkO5k?=
 =?us-ascii?Q?t7gN2HfADdyroKjZc/JWqi/K1ZQZg2yg/oTVViqdkSItxcNZZ1rZVWMFwmmU?=
 =?us-ascii?Q?BPYeyopQF414qhhINAhzAhDyB6uTw9XcNMl4dxmdwaGPrikgmUDFZGEesE6U?=
 =?us-ascii?Q?z8R7CMaoOuYv07x5bwCc5LHYoWNnJTm5w8x5QDyc7FHb4myV3GDiA7TnOUkP?=
 =?us-ascii?Q?Gq2S6664zIeh4q7eA7YW4HeWJexLun5bCTFLRL3S8sUpogiQLhZ4ysqdlOB4?=
 =?us-ascii?Q?Fj1iuRFTlC/nj/+9XBAkaWdawZUHmoTjIJMXDA9FjP7Rmo7mxtUahFEMN1EA?=
 =?us-ascii?Q?TOrYyCt90H1OuFHf5rAyZZWOJqBuSZzT+g73+AIExh8Co8V31ztK7cPaV8gN?=
 =?us-ascii?Q?9JvfFVp/tn5FfI+IqG8i+1ItZgPVvBAqT292RahanyukEcVCUoKKAVjCaiEm?=
 =?us-ascii?Q?RGOMotvbMFr6X3mWTIk33TU2xmg7lQlfKm2zqWzOzFx+TllVucNafHG5N5Lx?=
 =?us-ascii?Q?nTvbasMio34idq3YcUs7ymwjSHZEXnbsa4bkiTG6PbTcxHqjhn3FX7a2h2mp?=
 =?us-ascii?Q?AyWpa3D2owXdRCaQWp+p/LREyYuATF7NCl5DlQaguoFNQvOSBqlCjAjgTIIz?=
 =?us-ascii?Q?i/jklvVlF9s4FzHi44qTXzsuLQ65CNtjOVE9QHxsJ3pDy1iPWYWBxGGwyxyL?=
 =?us-ascii?Q?Y7lHa1MIzo7W/4ZVrftGegcZk7Ot7uiXN0WUnK979qYOl8F/j6awlvkV2t/D?=
 =?us-ascii?Q?Faei1b/Y2oYBiG395uD0qPOfbzdP714bb8v9FDE8lxvoNAEQmK/ac6Nj6QWs?=
 =?us-ascii?Q?rbJm5MqzWRT75wU0YKWzTX05MX4jktwUTRCdxQzeyIkeV0XltuG3Wsaye1RC?=
 =?us-ascii?Q?XGhEMq2MqJs73O5t1bVrPF0DFROuGC1QvV293D9kzHhVslw3z009V7oUZGah?=
 =?us-ascii?Q?10bgg9tM8s1sWYH4+7p59g5TGrkI7q8KVdHF3sbD2p/iOBTqQ0HCVeLDhJ0Z?=
 =?us-ascii?Q?hSxDoIj06lPOwcd0su/RZIkdKosq4ACzuOzFhtEKsfmtTK2wzLzcg4GhkEjF?=
 =?us-ascii?Q?7C9xRdf7tnxe/bJHRJBygSMxIcBY15iJhYwPv1UOnZKCxMNPYsz0kDn28/B+?=
 =?us-ascii?Q?+/5PwfaWE4RW7lThHBcFEZAYnj0vUdFREtxHSSzuGIjPSmtMOjlSsF18kWd5?=
 =?us-ascii?Q?xbX5NTRH5Ygyd6T746m28XqScFLPUgDZKrrNWYef2+QnyH9pZ8Cp81j/hZIy?=
 =?us-ascii?Q?fp0WDmIeTL4jjgAYQ/r+j/Y8bg1hiikU07jBNn4KsWtWTMdHB4pTq9yerafQ?=
 =?us-ascii?Q?CcBixYJkEbmzc1d3eDs021a+uSj3BfS/jnBiFIhz1Bfi6sk/x1uaIeU+1q4Z?=
 =?us-ascii?Q?65RG2vrGC0QlzLrwd30pV5URdVpyu9zfPHXNysI82++WNwIeKL3Y0Wp/KsjF?=
 =?us-ascii?Q?JjYiwYu+MdXeWfezlzgxJLUA6TsXWtk0J6jV/U3OEPBENqUfAY0xXZcbUXPI?=
 =?us-ascii?Q?Nko1a5rejJbyrXO9ysR+/Xfx1L6oq0QEoOqqgtgC7yDhCSyOrJ42s9AkUUZ/?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efd8c8c1-48d3-42a1-e838-08dc8c107671
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:22:31.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbwIoyVjUoQ2k9vr8gDCUPr5CETPzAL4KRwCvgRpa2zYoqopG6WHDXqlV6SkVlhBl51zKT382bsyXjKBWvMClIhAbSwTjzdwVYiHapsPiEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> On 6/12/24 22:18, Dan Williams wrote:
> > Christoph Hellwig wrote:
> >> On Tue, Jun 11, 2024 at 09:27:38PM -0700, Dan Williams wrote:
> >>> alucerop@ wrote:
> >>>> From: Alejandro Lucero <alucerop@amd.com>
> >>>>
> >>>> CXL Type 2 devices imply specific vendor drivers binding to those
> >>>> devices instead of generic ones offered by CXL core like the PCI driver.
> >> No, it absolutelt does not.  There is no such thing as a vendor driver
> >> in Linux.
> >>
> >>> So I don't like this approach, there are details that are private to the
> >>> CXL generic memory-expander use case, and some that are suitable for
> >>> CXL.mem and CXL.cache capabilities in other drivers. That distinct
> >>> subset should move to include/linux/. I.e. I want to see the incremental
> >>> conversion of what 3rd party drivers need compared to the generic
> >>> expander case, and consider when and where new shared infrastructure
> >>> needs to be refactored.
> >> And I'd much rather keep all these drivers in drivers/cxl/ anyway so
> >> that we can keep a tight control over them.
> > Yeah, especially for the common pieces like CXL memory where the
> > endpoint driver is responsible for registering a 'struct cxl_memdev' and
> > the existing 'cxl_mem' driver just grows to accommodate device-memory
> > alongside host-only memory expansion.
> >
> > For CXL accelerator use case that's where more specifics are needed
> > because CXL.cache operation gets entangled with IOMMU / DMA mapping
> > policy for ATS.
> 
> I think we all agree the central pieces should be in CXL core and other 
> drivers requiring CXL setup going through such central management.
> 
> But this can be implemented as I thought and tried

Like I said earlier, start by minimizing the definitions to just what is
needed as that may trip over things that need to be refactored.

For example, we had a similar conversation about how to support the CXL
mailbox which appears to be showing up in more than just generic CXL
memory expanders. In that case the observation is that all the APIs that
currently assume a 'struct cxl_memdev_state *' probably need to be
refactored into something that takes a new 'struct cxl_mbox *'.

> and Jonathan has also suggested, that is an API with opaque structs,

Opaque structs is even nicer, but first step is "don't make the entirety
of the current definitions public" because that violates 'least
privilege' for many of these structures. 

> or through a more disjointed way from a client/driver perspective
> using an approach like auxbus.

What? No, I see no need for auxbus. "cxl" is already a bus.

> Maybe there is another approach for "keep all these drivers in
> drivers/cxl/ anyway so that we can keep a tight control over them"
> which needs to be more explicitly elaborated.

For now lets interpret that to mean that any driver that wants to
enumerate or provision a topology of CXL HDM decoders should be looking
to register a 'struct cxl_memdev' object which is driven by the cxl_mem
driver in drivers/cxl/. The client driver that registers that need not be
located in drivers/cxl/.

> My plan is for a v2 removing the test/mock driver and adding the sfc 
> driver as a client,

Oh, as in CONFIG_SFC? Can you say anything about the use case for
CXL.cache and CXL.mem so that we make sure the code architecture lines
are being drawn at the right level?

> but only if the original approach with the CXL core 
> exporting functions is the approved one.

Not sure what you mean here? Exporting common CXL core functions is how
the cxl_mem driver itself gets enabled. So there is no other path
besides refactoring the core to be useful outside of the general memory
expansion use case. This is analogous to how the PCI core provides
infrastructure for PCI drivers.

> If auxbus or other way is the way to go, it will be just a new
> patchset and requiring more time.

Mainline has the time to get it right.
