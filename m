Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A612331A57
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941394; cv=fail; b=EhPhmwAZmSr0iQIcap+o8Dkg6LMAE13xsF1zRRRX4/otPRNMh0VwE8x3zSGezwbNsfiXR79mc405zf3uYCqlEr5peKytDiCI0N7+fkARjTscL5GJEK16XqoRk/eA1+q47IYJeic+DvNve3HvOw+GfVujO7sSRuNkYtjQ2nfv0eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941394; c=relaxed/simple;
	bh=IPtMWJiKrXSkE+lvKaryl1GcxO2sLfmWKr4+UR95eOE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uzTCih370giAzucYhUzJJU/UmknjnLBJclWh9CnWFyqWLkUN8eJF5RdUmtF1mYqQtypnGa+kNz9dyaz+1bRGXXtjnnQbu7nN+3fwT2Uy6MDwXzpvrxGBqJ+kaFbiStz+aEWg7RZDcNJodiV2Cpb5/iMxt4O7pmQdU0iM0HuQ+6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e//ZR0KQ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e//ZR0KQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784941392; x=1816477392;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IPtMWJiKrXSkE+lvKaryl1GcxO2sLfmWKr4+UR95eOE=;
  b=e//ZR0KQEfCWPEX5Mgdv9jNPx+UOnSq/SLUYN/EuJ8ElOeehtMjkhL3i
   s9wAcrc8Od5FYU9hhcyw+Wo8M7e1nsrLwjLzud9HsMCWYcC4FIFZB3ZV3
   Q/JmQHMPfymqYcYYf0ZIDs74v1d0ILQNiP8n7YJ93CRwnEL3gCx4/zCQZ
   M1FIzsV6z5NZH1wzZM+3WuHue4ng1T/uN0i5YSdpF9Pc4z5q0y6s71I74
   VAn76sJFk/oVjXJsDaznYs2EHcmANCNhjybl1sx71Er1zgn+tCRgwh+zf
   pNytCaUzGTHOrAYk9fhguyv2BMYueFWn7GPsHafNKlEjnPV5C7ALgcuLB
   Q==;
X-CSE-ConnectionGUID: ZGYIgEfbQJ6KvZIxsbnV5w==
X-CSE-MsgGUID: Uk24WLaVQCS6Vgi/XfEgjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85371415"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85371415"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:03:11 -0700
X-CSE-ConnectionGUID: PteaDfjGT3K2ljGAxJzx0g==
X-CSE-MsgGUID: E2ENAe4MRCKTm8uvUmTRhw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:03:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 18:03:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 18:03:09 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 18:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeynT4hSlzEW68CtA4nR6KLBAY9fZ9SlIeaq6r5pBceBScf1ifBZ/5lYl1fJ8U2wUkpFXPLJEI5EHYDPYnxUUKHpid1XHGnkGpHYqUkSnZLWJ3KJESNOHdIovlnRc07bYC1TywKed1XsU8wM/fOoQ7GUcq36Eu5P0XYbbJxHuamdHxvgXWTsFuxK02FQ5K6ajjXlALShqa/ihGV+yNBWKVuDT29sGCjOjMGIcUovrXDTBRkPVaq+Hxt7VSAKt7scqw/to/NaaruFs3OYl8Lwq06pnYfuyJF04JOmTCHSPEQwfZDrHWAyjP7APlRbPOw2pMn6JEmYrfkE0RLhCTyrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkmNxHC2bbNI5IxGh8txT/Zo5GZlx4tQPGS1UGdzJSc=;
 b=ZD3nersTQGRmeaqUcGvSCVvsw6un9Ht925JHHayrzgVbAaRvYKETD1MCPxMync2LQyvf4R21amZrKPzA5a+qNFLI7lXqsx6soJoFOnsYE4UP2bfoxlAmokspCQJ4GMVequ3YCSmjyCkEhbI04tPlGxeHR5aJXyn8XeOEjhXnwXByAKLaZloLaaAceDNmYLB5RFWQV9DSk4J+LOOhO4lmTH+Ms3EFJoV9SsaogORukYxRybLW9sOPQKVYHFtraKYoRrKpoaug2ScUsuy8iqS8BUZegORA9iI5LvPVyYIPqnJl3AdQe2OuIGdBeFdFL07ra7av1RbMz+vKVOqhcojLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB7782.namprd11.prod.outlook.com (2603:10b6:8:e0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Sat, 25 Jul 2026 01:03:04 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 01:03:04 +0000
Date: Fri, 24 Jul 2026 18:03:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <sashiko-reviews@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <amQLRUUVew-jUu_9@aschofie-mobl2.lan>
References: <cover.1783795720.git.alison.schofield@intel.com>
 <9a798f6b445ca8f2b16743d3e16fa289efadd86a.1783795720.git.alison.schofield@intel.com>
 <20260711201508.082531F000E9@smtp.kernel.org>
 <alL3a2UXB38XI7Nb@aschofie-mobl2.lan>
 <alXqISpyXQVzOlmq@MWDK4CY14F>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alXqISpyXQVzOlmq@MWDK4CY14F>
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 1319f385-aeaa-4c55-3e84-08dee9e87b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|5023799004|4143699003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: KHWNXT5ZTO6nlr+MeWoBeU82hCujfroG3xJBpL0jfpk6JxxBh8fZcSVC0OhNo3CZbN9ka8vnZ5l4RoGxy8357Crb19UfTO+pGECXFRE2y/BZj7V78tZx5TrlrCoTaxVNlq5rQr9xw3pTHIiR3auaUwZlGJ9fhtIllXzzVWQXzWAS6NtvAxbx55F76Uti6UygselAsQq8ble7SLHsTaS3TsrZizmeBmKOw7j84C5tk5fmyP18kibmZlpp4WFWqe078D1j3LecMFMVhB9gVzGNx66cohzHXLB2QToGe0lJWiXkb1b8cqwgtP866j9bWo/6GXFfPAjJ+vVdSXQIbZBZ4Nh6Rsbh/9dRVvmZ/Kj3r66uaORAZA0cDDCeWd0oBO4oepRG2KRxnopTmmzQ4KMoIn0FSZIOWmekCg+wNQyFXv51iAq3k+kiVdDwgN0vswv62potSBuHj7Sy14CBIIXZbceWq46TtfKpXYf5mPtC1eZlTe1PP+zZdrj3oiUTqZjaYXd164GQ/mH9IKzGSeXMd/cInI96slvvEucNvmvjgXWK7LspsSkP3K7C4jymlAXU8UHqSa92uNeRWGgfCvE6ZRuEgp1fj+A8OT7ey7KQd8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZSuOyhsJPaKp+RYuBByVGsLv2P3fc0jawzdn8NfthGFQVgiP4D9Ffo7K4g?=
 =?iso-8859-1?Q?lPglXoEZeEdGRlUIkPMsnBhz7CG2K8GeFGy5EgvE/2djDx+Jr+6XWGjwX+?=
 =?iso-8859-1?Q?RNcO0dx3WT1YKQBjm7pCCCUHXW5P2xbUjR9zJ8bpY3oSaN8d7kPTK0vOui?=
 =?iso-8859-1?Q?TssNzQpt9qa5e77CtrjWARZ2qUfofZHPoyW/u6c48UJ2kmp8TmIs6Ntg7e?=
 =?iso-8859-1?Q?1K/SKEgZbxXrDlSVH3S0w5VmUVftas+gpCIzANOmpzz6Rhi2zNrTdXy1dc?=
 =?iso-8859-1?Q?W5T8FVvgaqsuekhGiEFXnDOzFet3Gy7jpptsMaEqb63TuqjpvsDG7169oC?=
 =?iso-8859-1?Q?x/ZyDlihsjKHkpdLY4QRkBuqujl5as8ZnygX10zf0MaS6Fa6TwtXTrTBHb?=
 =?iso-8859-1?Q?uknmvYAZ8FWKxbhOoE9IVhnpu0l0AXuj5OSoVXU7O42+mSa3HIsHC0uNf9?=
 =?iso-8859-1?Q?I8n4qLsmaufY708pz2ILoq91Na3nZTihrbOmpzPt7gSZxHXHlz+8PpzBa1?=
 =?iso-8859-1?Q?gHoTbtVZqGs1Wj2jaGgtfYAcYGkFQpe9+3Bno2YF8U3CjN9iu47xbXLbRU?=
 =?iso-8859-1?Q?QBQ4QgvWjQnNYv5icEzmwEsi4wx2FI5ep46Z/eNhmYL2eHOImmwDA/rtfX?=
 =?iso-8859-1?Q?ld38QyWPf0n4/i4/UqobiOq6oZByP3Y4jfH5w+q8j5G3N5mUZ10AywHT26?=
 =?iso-8859-1?Q?9ssMGgoG7gD57A5G3+CH/CEx4Gp8K057H26Y0jbZaBJjWW6URUG5qWETSx?=
 =?iso-8859-1?Q?+1xXSjDJWu4Nv1gj961K5we0EPQ3FV3PfddiMGRH9e5qv3cQubRWITfRt3?=
 =?iso-8859-1?Q?WczUWGX/Nd/vHEpWkyorgxGI642lZlGyryr7QGpk+b0X6y5hGZuQlGe4Ud?=
 =?iso-8859-1?Q?a6uVopCIIZa7qrUBLwNyYPZM/i32ziuGHrvd4SndJQrWCgpIfihpQ42b5W?=
 =?iso-8859-1?Q?B276AKG8/+PHcyz/t/Mf7ok8G4EO+MqGWa6NBYHGLaNM/XxWyzL82H7y2L?=
 =?iso-8859-1?Q?Hx0Sak+v/+DUUxMS2tYXA/bQrw7ZOfGSBU7VAetMqIdwLSyiE0YzC/TD7x?=
 =?iso-8859-1?Q?aZIm+jJg5daWIrabFkzh61Mw6sPmBgxmFXOp8hNigM5E7uXl7zvKDNmg77?=
 =?iso-8859-1?Q?d7Az57EL0OL/fbbCRXKBA9BHM+U/T4vmmjnbHe/DYlPByw/G7KdadJUToX?=
 =?iso-8859-1?Q?5SnONZEgTAXV8Ss+NDK3UPr45L5rqRXpd54jgM60zhmPN01Tkl0dSvlVvr?=
 =?iso-8859-1?Q?39xFUfTSQYsE5fYNP9llyKNPwQczhohgIIje1I3Y7TA0tsd7TsmW9jJCPa?=
 =?iso-8859-1?Q?omdYoWZb56rVeUKboHgAeYdW0D8xCv/ONlbDvR7sCuQdArrhGo2ELkry+V?=
 =?iso-8859-1?Q?e7acKiW/PwPpuZ6+da9RoH3YZsbysvCGJhXfgwq2nyQlzpp0gMTQ3ZoImm?=
 =?iso-8859-1?Q?jOQFrHf04Mrn7cOzOaNHHkuVn9AIVDSzDArnNkBDG1j+3j5GaOTMFmXaOT?=
 =?iso-8859-1?Q?RYtfT0v4rUbVAzB92DDZewf5iC8Szx8BLCVnI92fRT1Z+aBaTH5P5S+aCZ?=
 =?iso-8859-1?Q?zyZqdBYy/pvSWH7aIRscLGzz4dl+Fn39p+T75bzT+odqvoDc5jZXvqyUX1?=
 =?iso-8859-1?Q?EjCA3Y1InF4/HjdxIMaHqBufWLQb2087DuCFg5ge3lY9gMCRFh5Tuoe32r?=
 =?iso-8859-1?Q?h5WBwSuRd+it50QjD7UmLOkiY85i9xuOcttwy7WvL9rfiF5NDRdIqmjo6K?=
 =?iso-8859-1?Q?EUFmqiS1E93MKcqbicYjAllTE/DNBufMnx/8LlPctaUna+nOEI8UdpQ+K4?=
 =?iso-8859-1?Q?4Wz3cgG9YWK/1QvsuFNZTD2ozzpbIVE=3D?=
X-Exchange-RoutingPolicyChecked: McZpfavXFUPD7U8sEcyMYt3Q6QCWpvc/z7xkN6JNKqkm4BXN+3+G2DleCk8xzsWY0aEvdV85vGChuDilAf66zSiImjpi9VBxd1puUzRa7MV6JCzR+frpB6WFCHV2lYaOSwFlHRUX0bvu6XU3a2ypN9IJ3duwjgQ4Td0F5K0mhGr/XPHz/77BWzPC7Ei4QKwE92BYN4GriqiYnZkgh7ACwUGKgl3c1mCF9/NOAzblf8tancwPMSLD6kCMJWU46uHVn4vkw9avfla7ENUwCUM3++E1l3QaAYbA1oAntdL7UnyPd4/bNwHODGuVUsaOcfkHr1yWPwlZHhr+6yB2/x5OLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1319f385-aeaa-4c55-3e84-08dee9e87b02
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 01:03:03.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSNw19NEimk6LQm/5OqeXF6o0JjVMEqRw2c1fQQdosZ1oLavqcVjT7+jEyv3bsD+gqJx1gajxPrxG4hcuIaGqfBtT2DG9wGIwyvZ/enBPEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7782
X-OriginatorOrg: intel.com

On Tue, Jul 14, 2026 at 03:56:18PM +0800, Richard Cheng wrote:
> On Sat, Jul 11, 2026 at 07:09:47PM +0800, Alison Schofield wrote:
> > On Sat, Jul 11, 2026 at 08:15:07PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [High] During auto-discovery (CXL_REGION_F_AUTO), passthrough decoders fail to update their `interleave_granularity` software state to the computed value, causing downstream decoders to inherit incorrect granularity and fail validation upon reboot.
> > 
> > Same NO as in v1[1]  and I don't see a way to graciously alert you to this
> > in the code. Gratuitously updating the field is not the right thing to
> > do.
> > 
> > 
> > [1] https://lore.kernel.org/linux-cxl/alKP8OP4DNT2nJnu@aschofie-mobl2.lan/#r
> > No. A downstream decoder can't inherit an unecodable value into a failing
> > check. A >16K granularity only appears below a wide interleave, and
> > everything below that inherits an equal-or-larger value that an interleaving
> > decoder couldn't encode. So every descendant is necessarily passthrough and
> > never validates granularity. There is no path where updating the F_AUTO
> > value would prevent a failure because the failure cannot happen.
> >
> 
> Hi Alison,
> 
> I'm thinking of 1 scenario where a regression might still happen,
> independent of whether an interleaving decoder can appear below a >16k
> passthrough decoder.
> 
> The new cxld_set_interleave() behavior writes EIG=0 for every IW=1 decoder,
> including cases where logical granularity is encodable.
> 
> For example,
> root: IW=2, IG=4k
> passthrough: IW=1, logical IG=8K
> downstream: IW=2, IG=8K
> 
> During manual setup, the passthrough decoder gets a logical IG of 8K.
> With your change, committing it writes EIG=0. On rediscovery, that is
> read back as 256 byte.
> 
> The AUTO path accepts the passthrough decoder because it skips the IG
> comparison for IW=1, but it does not restore.
> 
> The downstream decoder will inherits 256 bytes instead of 8K and its 8K config
> fails validation.
> 
> Could cxld_set_interleave() keep the real IG encoding when it's encodable and
> use EIG=0 only when an IW=1 value isn't encodable?

Yes, and fixed that up in v3.

> For latter case, AUTO still need to restore the computed logical IG before
> walking descendants.

I don't find it needed for the unencodabe (>16K) case. Every descendant
is itself passthru and never validates granularity. And with the encode
fix, the encodabe case is no longer clobbered, so there is nothing
state to restore, and nothing left to test for.

Please take a look at v3.

Thanks for the review!

-- Alison


> 
> What do you think ?
> 
> Best regards,
> Richard Cheng.
> > 
> > 
> > > --
> > > 
> > > --- Patch [1]: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K granularity ---
> > > commit 9e2526342188a97e338bfc63d454c253f1e2b3ef
> > > Author: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > cxl/region: Allow passthrough decoders with >16K granularity
> > > 
> > > This commit allows passthrough decoders beneath wide parent interleaves
> > > to have a granularity exceeding 16K by programming a don't-care value
> > > in hardware for non-interleaving decoders.
> > > 
> > > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > > index 0c80b76a5f9b4..d164662668c19 100644
> > > > --- a/drivers/cxl/core/hdm.c
> > > > +++ b/drivers/cxl/core/hdm.c
> > > > @@ -691,9 +691,16 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> > > >  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> > > >  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> > > >  		return;
> > > > -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > > > -		      "invalid interleave_granularity: %d\n",
> > > > -		      cxld->interleave_granularity))
> > > > +
> > > > +	/*
> > > > +	 * A non-interleaving decoder ignores the IG field. Encode a
> > > > +	 * don't-care value instead of validating the stored granularity.
> > > > +	 */
> > > > +	if (cxld->interleave_ways == 1)
> > > > +		eig = 0;
> > > > +	else if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > > > +			   "invalid interleave_granularity: %d\n",
> > > > +			   cxld->interleave_granularity))
> > > >  		return;
> > > >  
> > > >  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> > > 
> > > [ ... ]
> > > 
> > > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > > index 1e211542b6b64..5a443551288c4 100644
> > > > --- a/drivers/cxl/core/region.c
> > > > +++ b/drivers/cxl/core/region.c
> > > 
> > > [ ... ]
> > > 
> > > > @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> > > >  	 * Interleave granularity is a multiple of @parent_port granularity.
> > > >  	 * Multiplier is the parent port interleave ways.
> > > >  	 */
> > > > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > > > -	if (rc) {
> > > > -		dev_dbg(&cxlr->dev,
> > > > -			"%s: invalid granularity calculation (%d * %d)\n",
> > > > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > > > -		return rc;
> > > > -	}
> > > > +	ig = parent_ig * parent_iw;
> > > >  
> > > > -	rc = eig_to_granularity(eig, &ig);
> > > > -	if (rc) {
> > > > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > > > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > > > -			256 << eig);
> > > > -		return rc;
> > > > +	/*
> > > > +	 * Keep the computed granularity for descendant setup. Only
> > > > +	 * interleaving decoders require an encodable granularity.
> > > > +	 */
> > > > +	if (iw > 1) {
> > > > +		rc = granularity_to_eig(ig, &eig);
> > > > +		if (rc) {
> > > > +			dev_dbg(&cxlr->dev,
> > > > +				"%s: invalid granularity calculation (%d * %d)\n",
> > > > +				dev_name(&parent_port->dev), parent_ig,
> > > > +				parent_iw);
> > > > +			return rc;
> > > > +		}
> > > >  	}
> > > >  
> > > >  	if (iw > 8 || iw > cxlsd->nr_targets) {
> > > 
> > > [Severity: High]
> > > Does this code break region auto-discovery on reboot for topologies
> > > containing a passthrough decoder?
> > > 
> > > When cxld_set_interleave() configures a passthrough decoder, it now sets
> > > eig = 0 (a don't-care value) in the hardware.
> > > 
> > > Upon reboot, reading this hardware state will initialize the decoder's
> > > software interleave_granularity to a stale value.
> > > 
> > > During auto-discovery in cxl_port_setup_targets(), the CXL_REGION_F_AUTO
> > > path skips validating the granularity for passthrough decoders (iw == 1),
> > > but it appears to be missing an update to correct the software state:
> > > 
> > > 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > > 		if (cxld->interleave_ways != iw ||
> > > 		    (iw > 1 && cxld->interleave_granularity != ig) ||
> > > 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> > > 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> > > 			...
> > > 			return -ENXIO;
> > > 		}
> > > 		/* missing update: cxld->interleave_granularity = ig; */
> > > 	}
> > > 
> > > If cxld->interleave_granularity is not updated to the computed ig here, won't
> > > any interleaving descendants read the stale parent_ig, compute a mismatched
> > > expected granularity, and fail validation?
> > > 
> > > -- 
> > > Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783795720.git.alison.schofield@intel.com?part=1
> > 
