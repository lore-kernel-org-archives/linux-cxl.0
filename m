Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2362F35975;
	Fri, 22 May 2026 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779413380; cv=fail; b=m7Fw0Wo8hJgui5K3uNUNBSio7kX1C3+5ivtcXUXzbKABrrmFy1y5ybF3COoQBILos31U7G/aCRpddPSoP4d4ea4VWKuP8yOJktxJU55x50SXHai8bp3EY2taQSKhdW42KGy8MdhZiUee46OGdTiExZAW4tRNyj2QtR2wi9imVQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779413380; c=relaxed/simple;
	bh=BWSHuMO+ruEkyeGjr4NeIg5CYLXd9MlLnQKxvyoXGjA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jy6kAaZF5FnX/KeZQ8njdw/u4RrFishETtPS2dTDfn1ePt4/LUc8n6Oe9NbDsd+8fp+mKJm7Q3mYIUYFOvdeGhfpNFUdvCk043cy4RpkwBxVGZjwPWcibkmyLNGrgmOaWIlSEoI355GpzPBe0dFoFSx21ROwYqNakpUJFSnbSrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHNK4ep/; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHNK4ep/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779413377; x=1810949377;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BWSHuMO+ruEkyeGjr4NeIg5CYLXd9MlLnQKxvyoXGjA=;
  b=hHNK4ep/kzWLUy3SLTZp1wRdXbv8FN5IkBYon1jqRnBr344F1G4y5l65
   peGzufsCc03B8U0ho5ujV8+5Rc4sJOiLA0KqHvWhk6igUm+um364Rin9n
   +cG4ESHxceUKLX/ZvUgBLELLic6V4MzHCPSMeQP0IIV+1UD3sF73PqcfD
   StwS3ulHWNjrpxRguM90rx1JUNUD0TmhQzmjZAHnadu9AQGqZqjYstWg7
   9g/BX9yS4m/Sx1L1ureyjLCkyVwJnjGM0BbGV+y3Ya9EfjPQzg+Kee4LP
   0O2LghqYMkiUZX/teSHRDH7VKgynXioz6Br2uayfkWDxpG5uvo0mpnuu7
   Q==;
X-CSE-ConnectionGUID: 4qc/bSenQji05xcg3B42HA==
X-CSE-MsgGUID: OvZTU+cvRT6m8NLNe3DqsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="97917540"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="97917540"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 18:29:36 -0700
X-CSE-ConnectionGUID: Ci2aCD1JQ1+aYJxpI9go/Q==
X-CSE-MsgGUID: ctWjJBG1RjOKNd4n5QM9eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="264541362"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 18:29:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 18:29:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 18:29:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 18:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gxv/QZ/K83GvblEPzgAY4tpY/EeqQlG8bNMO7IVgYypUbvVuceaWxd4+9BOvKVA33Ya1xe4apeu6JEkcBdKLvFsfZNr8pjwMhHipJeezW/RvjTHB9zojVuNhG4ZDnY/hxdYWp16/S+dl2gv3PwNesRBLFTijg+IBYvRVYp/W9Zm9thO3ulsvgqGZUQTM3xRpNZ2xlpF4rifUX4tnZQR/XRSD3RHrVwnQc7P9UvfAFffWeGKfKzSuB89QfNQYvGTxosz8DH4tEatSxgt80FxGqXsKKldJADVpxm+XQNbl930ytL3Tr3sI2Xh1xRnK8PQoeFVQH8d83pb/ySMLqfuAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm2b3919Ii2n8naR5PT7uhPCW+js+upsifYs0QkyfiI=;
 b=OW4jYU48NHzeRuAuPw4aDHvwDZiWzhXh1C3o3SInalCiig6hWkwdXtuW6Jbtb7dRViYEweYm/OdZS6YLaH4dgfdDOVZSmGqOzb+GHIZgr1qYR+nDqM/526kRb0u5znzbkHeq2WgVaSc702C6ho3fTGJ3+JaaKjQvQExxa7RZ1+PIMG/AeR/XOnW4tZftM9dmCQsSvNmRvfCfMUMjJjxRCVMkLgVP/746KMyzP1pSb0qeAxjUDq007Q5CE3D4n4Btp5URKENNDlv7mu82Crv8bRagtqg4G6q/t0w/kozBw6P0+Aq/MHVm16RfitDceui6tfbe/lHxdzPEbFXkvu1MAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 01:29:28 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 01:29:28 +0000
Date: Thu, 21 May 2026 18:29:22 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.ne>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [RFC PATCH] tools/testing/cxl: Support multi-decoder
 shared-dport topology
Message-ID: <ag-xchhZdpqE9fXW@aschofie-mobl2.lan>
References: <20260521084806.28232-1-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260521084806.28232-1-icheng@nvidia.com>
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: c1adb738-5f6e-48a2-9138-08deb7a19054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|3023799007|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: VUgWxWsH6hDgyF+PyoYsx56Cp2YLG1af2alV5U0BDaWXgB5KZ60SnP5xN4n0tgcY8PsJIMoo5gyDr33vDb0ucp2cLeCR0QlU8WKubbTdi5fIENyo5j1gG5dFhYpVhvcGOTL26tHnWjzX/H/FCCSvinWO5BH1k7rqe7oTnVDW5/TK7m1EgzT12at3bDRUYXGCIKYa99uTg43wMFzmgZyTg366fa1c+ZZjGI20ZsW/VXORm6BLbeiswwQub9Cdui3kcaTfKiduE9gvd0ZNtkJl3wLnBTOTFnk6z/TrQ3Le+yldfpzoLxEp2cyQB5+Er2dDK5O5W2cvPAcsY6Rs1zN+eO8b4K4CevUu6qkF9XXTHD7VUPYX1P8jwx2RDxinNfDbx+Std+R8oBhsG1QbY22mPEDqealwC/mQeHxa2zjY3tfu6qK25o+ylnKalwl34fHRcibIXOF6bPmnbvLeWHwWTCAc3rn+KChNhnWhpQha2MiQdcXlJSx5bW/DVUNWKGW92E81P1JhrrVlMxide8/dTr/nLafBstwaKFVHKytE+W2FwsNzi4uRg9nlr2YWBEnEA6Q5DJ3bH7yWgpA7Wy09vKNfxc2OIQYC7KaSLjjHFDBvqI9roVq507cJeHvO66Nri4XeMp/eNOhvccFdsdWlKeAANPjsMi+M/82/2Rx3PdKrBaGrN91oR/ChAEGvlIDozWJikCwaYYcRjOnNZHfvpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(3023799007)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n9Gg4SNCdDa8KOQXnx6DYReQg1/PGGGS7gUeVTfb3hNhMX5VEUfpMOqWQ+qD?=
 =?us-ascii?Q?gpQgYEBPuU9/oT2U+FVIP2X9ra+QnMLz58+pmsQjrYJWGHDuP8iveKZLSnC+?=
 =?us-ascii?Q?C2lpIJyLupmtebseFbpJtzLPYOQMmjFjdH+xfjI7DUSmKGH8i3WzgSXySwQ3?=
 =?us-ascii?Q?G/X5I59deUPHeOVMjGN9aRXe8fHWNBqb2N2m/Kiazh8ksdoobShU9THE9z87?=
 =?us-ascii?Q?NtPPQMXR6BeDJZmRAvLCY+1lMf9t6cQfwUjWSylPgomwpt+a+Q7w2ei5Z2rV?=
 =?us-ascii?Q?hmFZspj2sw9BiLcx+CEwoKknWk4KkzLX5K6Jm38e+ZbNjpUv9OroyfyHHdzi?=
 =?us-ascii?Q?/NZ13etmjSvOUMNy6Kx0Io9/jzNhP5XmrbCMErAvjV/tEUz7HlooMpg4CC3r?=
 =?us-ascii?Q?OOjMI+jsJBYK4p2NX7n6ErJHrxrRRbdd5am/KZulH9eI8vPoxdE5J7zXntTM?=
 =?us-ascii?Q?o03T2NQiRtyaAiZk05GGlUhNcusdgm6KUVhiI39W8VoYdMiRdVsTIeIsPIKS?=
 =?us-ascii?Q?L17/jp27ZmJQPrK8m3WOuE6Z25J0bk0HDKhtSeN0cbajG78C5OS9VcZEgYtj?=
 =?us-ascii?Q?FPzoNZfjW88oaiiwHO3UCI04UxA1JxSK97iFHRknHaCoOFIP4ZZwm8Gg0XIR?=
 =?us-ascii?Q?1D7Ao4NZPeKb7QDW5mmiZ0tCpcasw44kKsDYWKLWnAyxyo2lzFydq3ATJb5s?=
 =?us-ascii?Q?86O/u8jRbhtZbEfDtBfGw63jirWWu0GkD1JsSsjt2fLC0cEVIYopMlmMTsfb?=
 =?us-ascii?Q?huxDgWEYFkXWm6mvfR+Bm+u4sExEJGN9CMl1/FluUpilwVQ6/3mbNVibfnJR?=
 =?us-ascii?Q?dogN+pNC1gZg1qLuH5MT/TyFgHrrmtuWaT8vOm+a2+UdXcGmPSoLdKElohvg?=
 =?us-ascii?Q?UyJAocYacLNjRx6Y55tNKxt7koUXzuCByYsOUcOJgImDP/Dop5OPwI+IeXT9?=
 =?us-ascii?Q?VN1ecfaKODKZ35XIsULPrC0qW9MTKdr5hz12crNhgrbDqf11jrfX32oUKqA+?=
 =?us-ascii?Q?Go2PZbCRhI9sgWxMX3xqPUhEKsV/NdYgW+VCGnVXvaF8THG72kDtl6cO9Wip?=
 =?us-ascii?Q?GukBcZhq0pCDEEDq/MnbVHe4YX29SR9T1mx2FFTJwWakFRRwxJB0sZ9ns8Iu?=
 =?us-ascii?Q?dnfyB+rpwAGhJXUpA2OgDlhRnLGqL57OttkDJKHA2KZaVReRF5UvyF1OUzqm?=
 =?us-ascii?Q?IQGkjWYgjO+1roCpRIX0oi0DA5oPa+X2se95VMoo/j0qbxcGjr08Rfnd2K6T?=
 =?us-ascii?Q?viXfJJXyq32xxv2lWCsDzh55iy4mbeYBt80SbqiOd6MtJ6h5RrL1IfU+8u8K?=
 =?us-ascii?Q?vxzBjJ92oDDV3GLXTKQPCPuxtwNBN7TxKzm7qvr4zo3ON844IDw3bKOv577z?=
 =?us-ascii?Q?n2mTnNaRDUuaN1vlIjUxs59XJsC22A+B9DsLf6jaab7jVosw2nlN6HkvGdZX?=
 =?us-ascii?Q?rEmiqD29roXKVLr8HqSaKBdqikyBfevbhJbMHUCCStwrJtDI9YUzKbxzOBLs?=
 =?us-ascii?Q?QTZVRic/FYBMffKNVI28a7al08DYQ2wgDIZhT+vltV2D6mo4+RtkYf2bK2da?=
 =?us-ascii?Q?IaKj0VKqK+A3w/ydgwh/fH8emZUT6N1CfD5HABwId3ah7ESleoBx2o0MuD3H?=
 =?us-ascii?Q?kQE2Cew5Ci9NPB8sWBMRv+csgr9CqcP4mAGtneWoeMfIN55cWuU+jIUz8C9R?=
 =?us-ascii?Q?JWPvdJcfbShO8xSKrMnNgpOBcGMGNfs0Qg2p9C7lorSc56CMgpBiEI+0vFBn?=
 =?us-ascii?Q?3Kfnwtgwy6EjbJxpwyGVc8jQqhyME3Q=3D?=
X-Exchange-RoutingPolicyChecked: KVj41SbF2BRAGbq1QStBZC/R+Lq5pVJfhi+EtUkZs5Ow5MRw+IWpiNxBlB1quR+9I3d0YKsbt77GANglmlQyy66CngU1VXRTXHCVpNDsQBEBDrmcjpu+NpNa6Om/3hLjg6NpeKr9OGbS5diRVwuPrFbiUVFNid8EL8r2t3Ux/6zJ7nwJ8I7PVi2T7K9m429c+j/i/jR9vAbg7OirHBM/NFyhN8qg9bcp9QCbuXNxbsPUFrus8OPToSNPK9tX8NfXxQE3F1o+cTXBO7otdmftN46bEt3/6c2v2wg2aJnj4rOVr+BMKYQl6OtmJt9xy+JqKcr4Y9lCS8hn/NR9zq4LOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1adb738-5f6e-48a2-9138-08deb7a19054
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 01:29:27.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IJxWJNq2T60NkKvz8I4zwZcRFPjexqXeyp618WaSuZ0bpMC18nFCKs7LgSo/NbMmgjyvlo/OFeOljd4/rKZyXotZx27GaL/RaX7r91RDRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com

On Thu, May 21, 2026 at 04:48:06PM +0800, Richard Cheng wrote:
> Add "multi_decoder" module param to the cxl_test emulator. When enabled,
> mock_init_hdm_decoder() addtionally programs decoder X.1 on cxl_mem.0
> and cxl_mem.4 as a second auto-region carved from the next
> mock_auto_region_size of HPA in the same CFMWS window.
> The result is 2 committed switch decoders that share the same
> downstream-port target_map[].
> 
> This is inspired by [1] so the emulator can detect and test for scenario
> like that.
> 
> [1]: https://lore.kernel.org/all/20260108101324.509667-1-rrichter@amd.com/
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---

Hi Richard,

Welcome to cxl-test and thanks for the patch and the explanation.
Before we add another module param and hardcoded auto-region, I
want to walk through what's already available and see if it covers
your need.

The fix for `3e8aaacdad4f` ("cxl/port: Fix target list setup for
multiple decoders sharing the same dport") can be duplicated with
the user create region path using cxl-test default topology as is,
and that can be replayed as an auto region.

I've appended a script to demonstrate it. FWIW, I didn't know
this for sure, and was wondering if the auto and user paths might
diverge somewhere in this config, but they didn't. I was able to
watch it fail without Roberts fix, then pass with it applied.

ICYMI there is a test case in cxl-topology.sh that detects the
failure pattern but not a config to verify it like you point
out here.

Your implemenation did make me aware of a gap in the region replay
capability. On real HW, BIOS programs the decoders, then the OS walks
the dports, and update_decoder_targets() is what populates target[]
from target_map[]. But cxl-test bypasses that ordering. In cxl-test,
mock_init_hdm_decoder() writes cxlsd->target[] itself on replay,
which IIUC is why your patch called cxl_port_update_decoder_targets()
from the mock to reach Robert's line. Lifting that call into the mock
unconditionally, so replay goes through the same dport-enumeration
path as real HW would widen what replay actually exercises. I'm not
sure how we get there, but if you'd have interest and time to take
a look at that, patches welcomed.

Does the user-create followed by region replay flow cover your need? 

-- Alison
From 0fcdebae75d307036d83f8b7be971db305b83660 Mon Sep 17 00:00:00 2001
From: Alison Schofield <alison.schofield@intel.com>
Date: Thu, 21 May 2026 17:39:51 -0700
Subject: [PATCH] WIP test/cxl-multi-decoder-shared-dport.sh

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/cxl-multi-decoder-shared-dport.sh | 139 +++++++++++++++++++++++++
 test/meson.build                       |   2 +
 2 files changed, 141 insertions(+)
 create mode 100755 test/cxl-multi-decoder-shared-dport.sh

diff --git a/test/cxl-multi-decoder-shared-dport.sh b/test/cxl-multi-decoder-shared-dport.sh
new file mode 100755
index 000000000000..5f15b23f3a27
--- /dev/null
+++ b/test/cxl-multi-decoder-shared-dport.sh
@@ -0,0 +1,139 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Intel Corporation. All rights reserved.
+
+. $(dirname $0)/common
+
+rc=77
+
+set -ex
+
+trap 'err $LINENO' ERR
+
+check_prereq "jq"
+
+modprobe -r cxl_test
+modprobe cxl_test
+
+rc=1
+
+# Regression test for kernel commit 3e8aaacdad4f ("cxl/port: Fix target
+# list setup for multiple decoders sharing the same dport").
+#
+# Create two user-space regions on the same root decoder, claiming the
+# same memdev set. Topology routes both regions through the same switch
+# downstream ports, so each switch port ends up with two committed
+# decoders sharing the same dport. cxl_test enumerates dports per
+# memdev attach, which fires cxl_port_update_decoder_targets() against
+# the already-committed decoders and lands on the line the kernel
+# commit fixes. A pre-3e8aaacdad4f kernel stops after the first match
+# and leaves the second decoder's cxlsd->target[] empty (nr_targets=0).
+#
+# replay_regions exercises the same shape after a cxl_acpi unbind/bind,
+# so the regression is checked on both the user-create and replay
+# paths.
+
+destroy_regions() {
+	$CXL destroy-region -f -b cxl_test all
+}
+
+# Pick the volatile-capable, 2-target root decoder. The cxl_test
+# topology routes its 4 targets via 2 switches (HB0/sw0, HB0/sw1),
+# 2 memdevs per switch. Both regions below claim all 4 memdevs, so
+# they share the same switch dports by topology.
+find_x4_ram_decoder() {
+	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
+		select(.volatile_capable == true) |
+		select(.nr_targets == 2) |
+		.decoder")
+
+	[[ $decoder ]] || err "$LINENO"
+
+	# Decoder window must hold two regions
+	# Each region size is half the window.
+	decoder_size=$($CXL list -d "$decoder" | jq -r '.[0].size')
+	[[ -n "$decoder_size" && "$decoder_size" != "null" ]] || err "$LINENO"
+	region_size=$((decoder_size / 2))
+
+	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == 0) | .target")
+	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == 1) | .target")
+
+	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
+	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
+	mem2=$($CXL list -M -p "$port_dev0" | jq -r ".[1].memdev")
+	mem3=$($CXL list -M -p "$port_dev1" | jq -r ".[1].memdev")
+	memdevs="$mem0 $mem1 $mem2 $mem3"
+}
+
+create_region() {
+	local size="$1"
+	local region
+
+	region=$($CXL create-region -d "$decoder" -m -s "$size" "$memdevs" |
+		jq -r ".region")
+
+	if [[ -z "$region" || "$region" == "null" ]]; then
+		echo "create-region failed for $decoder"
+		err "$LINENO"
+	fi
+	echo "$region"
+}
+
+# Similar to cxl-topology.sh - test_switch_decoder_target_enumeration()
+# Counts switch ports where >=2 decoders are programmed (one with
+# targets, one or more without). After both regions are committed,
+# every switch port we use should have >=2 decoders programmed.
+check_shared_dport_enumeration() {
+	local label="$1"
+	local issues
+
+	issues=$($CXL list -b cxl_test -vvv | jq '
+		[.. | objects | select(.depth == 2 and has("decoders:" + .port))] |
+		map({
+			nr_dports: .nr_dports,
+			with_targets: ([to_entries[] |
+				select(.key | startswith("decoders:")) |
+				.value[] | select(has("mode") == false and
+				.nr_targets > 0)] | length),
+			without_targets: ([to_entries[] |
+				select(.key | startswith("decoders:")) |
+				.value[] | select(has("mode") == false and
+				.nr_targets == 0)] | length)
+		}) |
+		map(select(.nr_dports > 0 and
+			   .with_targets >= 1 and
+			   .without_targets >= 1)) |
+		length')
+
+	if ((issues != 0)); then
+		echo "$label: $issues switch port(s) with incomplete target enumeration"
+		echo "(>=1 decoder with targets, >=1 with nr_targets=0)"
+		return 1
+	fi
+	echo "$label: switch decoder target enumeration OK"
+	return 0
+}
+
+# Start clean so we own all RAM capacity.
+destroy_regions
+
+find_x4_ram_decoder
+
+region_a=$(create_region "$region_size")
+region_b=$(create_region "$region_size")
+
+check_shared_dport_enumeration "after user-create" || err "$LINENO"
+
+replay_regions || err "$LINENO"
+
+check_shared_dport_enumeration "after replay" || err "$LINENO"
+
+# Destroy in reverse DPA order
+$CXL destroy-region -f -b cxl_test "$region_b"
+$CXL destroy-region -f -b cxl_test "$region_a"
+
+check_dmesg "$LINENO"
+
+modprobe -r cxl_test
diff --git a/test/meson.build b/test/meson.build
index e0e2193bfd51..4abad21102a7 100644
--- a/test/meson.build
+++ b/test/meson.build
@@ -171,6 +171,7 @@ cxl_translate = find_program('cxl-translate.sh')
 cxl_elc = find_program('cxl-elc.sh')
 cxl_dax_hmem = find_program('cxl-dax-hmem.sh')
 cxl_region_replay = find_program('cxl-region-replay.sh')
+cxl_multi_decoder_shared_dport = find_program('cxl-multi-decoder-shared-dport.sh')
 
 tests = [
   [ 'libndctl',               libndctl,		  'ndctl' ],
@@ -207,6 +208,7 @@ tests = [
   [ 'cxl-elc.sh',             cxl_elc,            'cxl'   ],
   [ 'cxl-dax-hmem.sh',        cxl_dax_hmem,       'cxl'   ],
   [ 'cxl-region-replay.sh',   cxl_region_replay,  'cxl'   ],
+  [ 'cxl-multi-decoder-shared-dport.sh', cxl_multi_decoder_shared_dport, 'cxl' ],
 ]
 
 if get_option('destructive').enabled()
-- 
2.37.3







>  tools/testing/cxl/test/cxl.c | 88 +++++++++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..929bbee471db 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -17,6 +17,7 @@
>  static int interleave_arithmetic;
>  static bool extended_linear_cache;
>  static bool fail_autoassemble;
> +static bool multi_decoder;
>  
>  #define FAKE_QTG_ID	42
>  
> @@ -1041,6 +1042,17 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
>  	WARN_ON_ONCE(!cxld_registry_new(cxld));
>  }
>  
> +static int decoder_by_id(struct device *dev, const void *data)
> +{
> +	int target_id = (int)(uintptr_t)data;
> +	struct cxl_decoder *cxld;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +	cxld = to_cxl_decoder(dev);
> +	return cxld->id == target_id;
> +}
> +
>  static int first_decoder(struct device *dev, const void *data)
>  {
>  	struct cxl_decoder *cxld;
> @@ -1079,6 +1091,8 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dport *dport;
>  	struct device *dev;
> +	int max_decoder_id;
> +	int region_decoder_id = 0;
>  	bool hb0 = false;
>  	u64 base;
>  	int i;
> @@ -1129,9 +1143,16 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	 * assignment those devices are named cxl_mem.0, and cxl_mem.4.
>  	 *
>  	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
> +	 *
> +	 * When multi_decoder is enabled, additionally program decoder
> +	 * X.1 of the same endpoints as a second auto-region that shares
> +	 * the switch's downstream ports with the first region, so that
> +	 * the same dport ends up in target_map[] of two committed switch
> +	 * decoders simultaneously.
>  	 */
> +	max_decoder_id = multi_decoder ? 1 : 0;
>  	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
> -	    pdev->id > 4 || cxld->id > 0) {
> +	    pdev->id > 4 || cxld->id > max_decoder_id) {
>  		default_mock_decoder(cxld);
>  		return false;
>  	}
> @@ -1142,9 +1163,14 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		return false;
>  	}
>  
> +	region_decoder_id = cxld->id;
> +
>  	base = window->base_hpa;
>  	if (extended_linear_cache)
>  		base += mock_auto_region_size;
> +	/* Place the second auto-region right after the first. */
> +	if (region_decoder_id == 1)
> +		base += mock_auto_region_size;
>  	cxld->hpa_range = (struct range) {
>  		.start = base,
>  		.end = base + mock_auto_region_size - 1,
> @@ -1156,7 +1182,9 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	cxld->flags = CXL_DECODER_F_ENABLE;
>  	cxled->state = CXL_DECODER_STATE_AUTO;
>  	port->commit_end = cxld->id;
> -	devm_cxl_dpa_reserve(cxled, 0,
> +	devm_cxl_dpa_reserve(cxled,
> +			     region_decoder_id *
> +				 (mock_auto_region_size / 2),
>  			     mock_auto_region_size / cxld->interleave_ways, 0);
>  	cxld->commit = mock_decoder_commit;
>  	cxld->reset = mock_decoder_reset;
> @@ -1165,12 +1193,23 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	/*
>  	 * Now that endpoint decoder is set up, walk up the hierarchy
>  	 * and setup the switch and root port decoders targeting @cxlmd.
> +	 *
> +	 * For region 0 use switch-decoder slot 0 (selected by
> +	 * first_decoder()); for region 1 use slot 1 so that the two
> +	 * regions exercise the multi-decoder / shared-dport scenario.
>  	 */
>  	iter = port;
>  	for (i = 0; i < 2; i++) {
>  		dport = iter->parent_dport;
>  		iter = dport->port;
> -		dev = device_find_child(&iter->dev, NULL, first_decoder);
> +		if (region_decoder_id == 0) {
> +			dev = device_find_child(&iter->dev, NULL,
> +						first_decoder);
> +		} else {
> +			dev = device_find_child(&iter->dev,
> +						(void *)(uintptr_t)region_decoder_id,
> +						decoder_by_id);
> +		}
>  		/*
>  		 * Ancestor ports are guaranteed to be enumerated before
>  		 * @port, and all ports have at least one decoder.
> @@ -1179,23 +1218,36 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  			continue;
>  
>  		cxlsd = to_cxl_switch_decoder(dev);
> +		/*
> +		 * Region 0 (decoder.0) keeps the historical shortcut of
> +		 * stamping target[] directly so single-region setup is
> +		 * unaffected by dport-add ordering quirks of cxl_test.
> +		 *
> +		 * Region 1 (decoder.1, only programmed when
> +		 * multi_decoder=1) intentionally leaves target[]
> +		 * to update_decoder_targets() at dport-add time.
> +		 */
>  		if (i == 0) {
>  			/* put cxl_mem.4 second in the decode order */
>  			if (pdev->id == 4) {
> -				cxlsd->target[1] = dport;
> +				if (region_decoder_id == 0)
> +					cxlsd->target[1] = dport;
>  				cxlsd->cxld.target_map[1] = dport->port_id;
>  			} else {
> -				cxlsd->target[0] = dport;
> +				if (region_decoder_id == 0)
> +					cxlsd->target[0] = dport;
>  				cxlsd->cxld.target_map[0] = dport->port_id;
>  			}
>  		} else {
> -			cxlsd->target[0] = dport;
> +			if (region_decoder_id == 0)
> +				cxlsd->target[0] = dport;
>  			cxlsd->cxld.target_map[0] = dport->port_id;
>  		}
>  		cxld = &cxlsd->cxld;
>  		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		cxld->flags = CXL_DECODER_F_ENABLE;
> -		iter->commit_end = 0;
> +		if (iter->commit_end < region_decoder_id)
> +			iter->commit_end = region_decoder_id;
>  		/*
>  		 * Switch targets 2 endpoints, while host bridge targets
>  		 * one root port
> @@ -1212,6 +1264,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		cxld->commit = mock_decoder_commit;
>  		cxld->reset = mock_decoder_reset;
>  
> +		/*
> +		 * For the second region only target_map[] is set above,
> +		 * not cxlsd->target[]. On real hardware target[] gets
> +		 * populated when dports are added (BIOS-programmed
> +		 * decoders are read first, then dports get enumerated).
> +		 * cxl_test's order is reversed: dports were added long
> +		 * before this point, so re-fire the update here against
> +		 * each existing dport to mimic the real-hardware
> +		 * ordering and exercise update_decoder_targets() with
> +		 * pre-programmed decoders.
> +		 */
> +		if (region_decoder_id == 1) {
> +			struct cxl_dport *existing;
> +			unsigned long index;
> +
> +			xa_for_each(&iter->dports, index, existing)
> +				cxl_port_update_decoder_targets(iter,
> +								existing);
> +		}
> +
>  		cxld_registry_update(cxld);
>  		put_device(dev);
>  	}
> @@ -2049,6 +2121,8 @@ module_param(extended_linear_cache, bool, 0444);
>  MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
>  module_param(fail_autoassemble, bool, 0444);
>  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
> +module_param(multi_decoder, bool, 0444);
> +MODULE_PARM_DESC(multi_decoder, "Auto-program a 2nd decoder per endpoint sharing switch dports");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.43.0
> 
