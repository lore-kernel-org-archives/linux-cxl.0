Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BBB30675F
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787878202; cv=fail; b=dR+bUwxe3duOMM9cT+9+Q1EpOf+gaKvE+vJKpIhzDHNZctsbW57sHLNhy+twS3+5x7mq+SwXKtK6xiOyUy4W5LWnm1fsexidgUKUHDcjRBKJAkHsDNuCaCIxEE9iitJ/30nYrnt3BFyo3BY6o1Ca7o87BNHdsSaQaQrzJnpLcWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787878202; c=relaxed/simple;
	bh=djXnSXVwMdwXa+4fyx7Jb9wByi8U5i+BqJtBC2oxeZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p0seuhDFlXu4pqg6g22cBIJ6QIFh8lehXm005kyp4ESr/I/mCQJpMjIfLIYCSDOawyNDvJJ3E0trz4vGjPHu1Wuj38C/CqgGsnA03fOuyx7yVkBwArhEaoKBiOSRUK2POvQ23XvlKn8aXrxVgpe1SstuHagUZYF4og3YSUKfmGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTRCXh70; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTRCXh70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787878200; x=1819414200;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=djXnSXVwMdwXa+4fyx7Jb9wByi8U5i+BqJtBC2oxeZA=;
  b=HTRCXh70hdDDT3pIWSG/fzwRCPnDsRnQzhU8Iv/F/pdWV5k4gg8Fc/a8
   hvPfLZJtd2r+ZCmjLG40ufupEZlNQB9e5xy/RLqKZreWi7ILdBFWcEmds
   kvp6zkBSeIeZNgd//hKXB6nLM3i42nq0ACkgV87+nQXn8+rkZaI0HAVsh
   KUNHoaL48g5wSRO9pDFiqbMqSVtgo3/KPR7YuYnzUzolQQ+uFja8e9pji
   kdejRvI9c/KzDzzGKYhBKVA2cuB8owA9ErbHNV/SHVxABzdvHKijqG28T
   va4YKzdZMEB3PJiDUZFiLhABIUxvq5ONOyL468eQII5J4i4vyeR73rd7e
   w==;
X-CSE-ConnectionGUID: sF2iKRG2QMSrV2vBJGROoA==
X-CSE-MsgGUID: 0Av8fnTlSdOI4cDc6dElIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="87330942"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="87330942"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 17:49:59 -0700
X-CSE-ConnectionGUID: /eI7PwcYQ/SqNJwRowFZfw==
X-CSE-MsgGUID: MOWFNtjDS8i4wGFcMRzqbw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 17:49:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 17:49:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 17:49:58 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 17:49:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXBcc/pf8c57UFvLK6B7y0Z+e4WB88JhpdxpJnLId56LpWwEZxaX0IPbsLr4qoFJknudc/v40PKJ/WAXMjh3ypsG7WQp+ccoLeCM6bMCK+yd58UMb1g8yPSJzjF9cLopYXzfuFB+e8q7CIzOkCHTdmPvVxg9f4vlLDGa9ti988IRY6rV3llWKcC9w9adCKz3xsSSlvRmx6h8ypg4tUFGfLuHpCfU3/iqp82rn+gqPc5aYb9/4fhIxfNKh/pM56R3Qebi9+LkZXrx982FohIC5K6qpnxd0BVuUqxaRtVw2UOiowQbIbZFKK9OAIb+cyJRmS45D5zjPlfGCex4OVlriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZEhh6mGbyPsZzODf8wt5dKOZ8vmc2m2eFP00dOw/4M=;
 b=TizJbv/TOgc/LP0Z8Cvda02Md1ls8emShGQ6v7LUuRrwKe7WlFHDLYFnXpWjkm0ZK+o0eB7pCOx/qLoDw4Jc4KxtgvkGYMQbZE62xDfadeI0bcjmAXWYPpz0gDDxHN+wr0A64zobPluuVP/VdEN57qXpTnIGNFhC5UBwTBpCh0fFPU1efELHrwUI2mIJ7LgQN+e7/mXixPEl58f8pJXyHlnN3DQYQVSDK8dBWjFf9fc80e5V3Z0dN0MqPiZL8qzxxbrK/rbGIk/9fxXcpdqt+z68wj1lqMtQrLbKNzas48BVZwU+7tp7CEIvYMas3GhCMhip2AF7EAuPfJIrA42/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB7170.namprd11.prod.outlook.com (2603:10b6:930:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 28 Aug
 2026 00:49:51 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 00:49:50 +0000
Date: Thu, 27 Aug 2026 17:49:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/cdat: Fix uninitialized stack use in
 bandwidth gathering
Message-ID: <apDbK_xjfHEV69Cp@aschofie-mobl2.lan>
References: <20260812083035.372308-1-kanie@linux.alibaba.com>
 <20260812083035.372308-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260812083035.372308-2-kanie@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: dba2a3ca-2db4-4900-a4c6-08df049e442d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|3023799007|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OfymT9FFQMPQXFsEnr9HbC2fEN/z+HgxXBKAWrUVvVD8/OBGegl3LvusAFFTfhROZSeB6vlVykCh/oMvqWQtqCs5Xj/5AWjINdjKf2A/hfXQ3G+m7LaYEAymjn2PdN0U1cdXpZ2QhdhSb0V0dKeYtThTrAx7LQwojrWzapNWrQcUpLZ2tidp6AE904Rba0TY9D60Tmdwk8Dchi73Innc5t5wm8oWMdVRIfWOXjUsCAwEXjZCC9Y88/LrMLYYWFvga52FeyGxneoDx2pjOuGfCZKwnas2A4ojkXXVYo/H6J+2pOCGwHc3X7haaaJEA9RA7yXwdwoOBglYuE/HzQ6mc83bqC93/BCAHaLeu3M7k6vs/gfPDkzEi3z5lfJU/QwHvCqwGV+uxjoZhVB07B33ad6HLNB/P+qUBnaX0cky3Exf2X8r/KYfolIwfeUzLkQH5oxXwz4adWXH9+PvZ5rEfMzrnhZ9eaDYDwcH6REFZLkLTmUUnkRbA0LKIjV5fKkms3LnViZpndrvCkP08e2iKPvG5TG4WNMpFZpSi89Aieh8YUCey3gum5YhGnaMsK8tgzFMN7ydOOTAVP0M1ZjxwenZ/MgGTRS7aRfNvOETiJJxR4jb7GHqJvaQL5ROEcOAyTooFJ0FzXn6EC2Kv86FpB6P1hb3vV9axMmKReCIwk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nzTMBVJJZHs0pVNIQuAdp8fQ/9/oeDJF3VN5Fh3Yg4EbJWpva2lavu2bOeEc?=
 =?us-ascii?Q?MRp/Wz+PtkjR32484KTRrFiST3I+mQyEvI2axEglQuxDqh6e9g780POfveL9?=
 =?us-ascii?Q?QvIwFcWbxoTvwQl/CKxOetBp4rFLlaM/7vqufhHKfLI/BTQOiUTdGAQp/x0Q?=
 =?us-ascii?Q?UGMpgzHTkA9KnYUVP+/+wwhW/qCnlI771nzCS4OJN21kaKZfYxb7aooaJX8k?=
 =?us-ascii?Q?l09GVYwN7+ral6GIeZzs9DzLCgV36fx1LluUPqXnbDxEtsaHZ651JTmE7YBM?=
 =?us-ascii?Q?v/r2T2+azWq0qfeiqp14d/rAEx5Znv6LiwMr7P8wWa7e7OqbfKA53uGxvx1H?=
 =?us-ascii?Q?jIuGeV14vwy4h/8K3UiVtworORIaLgmrA/aRS/qWj1SfRVWB3q6+ROKSx9cA?=
 =?us-ascii?Q?idtZJcXvR8XDmhP2Lyi/m1cvR6QTCcCuw5anSfMZss8qRsYx5m8IITLSEOMM?=
 =?us-ascii?Q?Oc3C2bcUqxB4sIAK9J6PQT/LULvX7Pi0eES5OwrOK81TihZmJXLNMHwuKvdW?=
 =?us-ascii?Q?PqCQlCUJ3YhelGvAMGOOw0HWF4b26HCMTQFLj+8xLn8uSOlKQB1GAqe8MZvJ?=
 =?us-ascii?Q?OQjXKm6HjasQrHQOb9waTxZ36sFMixBbWhQWh1CKlVBIgmQwXCMN55m0mOeh?=
 =?us-ascii?Q?OiDx2shlm3KrH1wT+o33v3hn/owO/PsfQHhvoMAQn32NC3+HVbi2bvfo3I5o?=
 =?us-ascii?Q?ySCzzKTnrnW2OEHoEjA37EED83UDHfLJA32ZZi/4FMd4aYEKDjxSPCDvJhSx?=
 =?us-ascii?Q?NxHyA15vfXV7X0MKJsM+JmPpt4XTWBghitosQtI6XFycQyWVyZG2g2rZzHIZ?=
 =?us-ascii?Q?CE2RyHfgp1SgFnJKbAn+vM6I6nE9Vi6lIAbx5X3P7gFnU3XQsSZPzfTSTuQe?=
 =?us-ascii?Q?ESkS8BHVAAh+Izoio67YnNpXgNdHbf/rv0mH6tKrUOWGJMjhyMVcRhhqy5eB?=
 =?us-ascii?Q?RoPZCObGkchCZevyC8p03uLqRTsA+RCYY8LyC/L3Pt9APh+PTfuOmrUyDgiB?=
 =?us-ascii?Q?8kXUXx3iH+t8glh/GkQ63UJ4SzhzoqkHpG6IQJoSL/2pMID9TItPP5xwS2ad?=
 =?us-ascii?Q?7vHQZBHmFGjlTIeTPgdZH9k3lN1HBfENibMtzW7fV099HnLbJpI5NQYEQWE6?=
 =?us-ascii?Q?VSiWKyuDYnjgW4qgVLPqF8IX6kdLsdzO9rkcL3A+QPjvkQTrWxYmu0EbtnMG?=
 =?us-ascii?Q?v8hmsaINGAj2UZ6AJaXZJ4HMw+ooBJP6IZyAaGTses1HKnbuR9PGInAmEvnV?=
 =?us-ascii?Q?U++q0YYPEGheYe/PuigeJS1zc11CVfTuQTWf2uO8iS/z+VVgNo5g/OHoUhZg?=
 =?us-ascii?Q?jt51eJ56vL915/k5UWy4tHy/Ttm/3QecBOyPS/VzFC5Mc0zVFH314bH9om5i?=
 =?us-ascii?Q?0vesNIVjEp3Gd8m0Xr0G2wHgNvr8DGvBq3Nj8y1YbBmXeT05rgdPytc/ueHQ?=
 =?us-ascii?Q?oRJMZ5aPGgrBoUGKqMgshOdrwhRTdDzoE32BxHbKxWR9CmLPwLgE1liB34lM?=
 =?us-ascii?Q?eRqXdQYJhE8g2GSWAOwsl/YTbln+wqDoEHo1H+TTrpQ9NSsRjiYl4v2LUrJ/?=
 =?us-ascii?Q?MXTfncdXWi8qH+XRP5mikq918si9MatbMkBL/dMtcCpIDbEoxhIp0WRgT6tH?=
 =?us-ascii?Q?snuA9KKEDc87XPHVuT4tcNBEm2KFv6wiCuwMoIK2sDk58sSP18aUpc+UqISK?=
 =?us-ascii?Q?EdZRhJ43ZlP658qByR3Kar9DBHknRsJ9KVZL5oFwceGRHSccpz/HIjdBOnKX?=
 =?us-ascii?Q?3o1t9e+QMtsImTZJahUR9x/lLd2q5ts=3D?=
X-Exchange-RoutingPolicyChecked: smhfBWEazpLu/LJrhTmUg48AauXdjJoU5SXuYmBGxkAamScMVQhmdoIBrV5TUF5JZhBw8hK7YiDDcKCyFoHgFHBBnzx7foYp4pukht5iEyzyytziQrTllLhIScGUDRiL+YTgT2YwaEhor5xULVIwZRzXvYiOwvMFaUmcrN+N0o4BD6yxUHYo5udfz0amWHj+kGWTlaFZODmoZ9P8hSTePhBiJ5HCtets/0lCK3oTvXtREqAwSrUj6p5ETHwBHqH87BZm1kCdL6fJ2q6tPSNjrGTiJhUB6nX5KquB3FfcMXgATzuqpQjWG94ThBH1aMpl56YdVB2UKzLusnMjTK44XQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: dba2a3ca-2db4-4900-a4c6-08df049e442d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:49:50.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7RecqneRc4Mmzi+98eS0H1VmG5VKXbt4ZM/7ADPDcz/aiXOu+Sk5waXGZCf5UaDHxoZ21+WXpqZcJrrRzvN4FajPiFQVtE/+NJd0cDn1zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7170
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 04:30:34PM +0800, Guixin Liu wrote:
> cxl_endpoint_gather_bandwidth() declares three access_coordinate arrays on
> the stack - pci_coord, sw_coord and ep_coord - without initializing them,
> and relies on its helpers to fill every member. None of them does.
> cxl_pci_get_bandwidth() and cxl_port_get_switch_dport_bandwidth() assign
> only read_bandwidth and write_bandwidth, and __cxl_coordinates_combine()
> assigns an output bandwidth only when both input bandwidths are non-zero.
> Every member a producer declines to set is read back as whatever was on the
> stack. cxl_switch_gather_bandwidth() has the same defect in its coords
> array, which it hands to cxl_pci_get_bandwidth() and then to
> cxl_coordinates_combine().
> 
> Both cases occur on real topologies. The latency members are never written
> by any of those producers, yet __cxl_coordinates_combine() sums them
> unconditionally, so the latency reads are undefined on every call. And a
> device whose CDAT DSLBIS reports no bandwidth for an access class leaves
> perf->cdat_coord zero for that class, which is exactly the condition that
> makes __cxl_coordinates_combine() skip the bandwidth assignment and leave
> the ep_coord entry untouched.
> 
> The ep_coord case escapes the function: cxl_bandwidth_add() accumulates it
> into the per-upstream-port aggregate that is published through the region's
> access coordinate sysfs attributes, so stack contents are reported to
> userspace as a bandwidth figure. The latency sums are discarded by
> cxl_bandwidth_add() rather than published, but they are still computed from
> uninitialized memory.
> 
> Zero initialize the four arrays. Zero is already the value this code uses
> for "not reported" - both the __cxl_coordinates_combine() guard and
> coordinates_valid() test for it - so a member no producer sets now reads
> back as unknown rather than as a plausible number.


Hi Guixin Liu,

Please see my comments on the einj_inject patch about commit message
clarity and level of detail. The same issue applies here.
https://lore.kernel.org/linux-cxl/apDXSzSZVcjQ027J@aschofie-mobl2.lan/

For this patch, I think the essential story is:

Background:
cxl_endpoint_get_perf_coordinates() returns success for RCDs without
calculating coordinates.

Issue:
The output array is left uninitialized on that path.

Impact:
Callers can consume and expose garbage access-coordinate values.

Resolution:
Initialize the coordinates to zero before returning for an RCD.

That is enough to explain why the patch is needed. I do not need the
full path through CDAT parsing, __cxl_coordinates_combine(), QoS class
selection, cxl_dpa_perf, and sysfs to understand the bug.

Also, as with the other patch, please say how this was found and how it
was tested.

-- Alison


> 
> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/cxl/core/cdat.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f07262513..df9261ba84e5 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>  	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
>  	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
>  	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
> -	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] = { };
> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] = { };
> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] = { };
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> @@ -757,7 +757,7 @@ static struct xarray *cxl_switch_gather_bandwidth(struct cxl_region *cxlr,
>  {
>  	struct xarray *res_xa __free(free_perf_xa) =
>  		kzalloc_obj(*res_xa);
> -	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate coords[ACCESS_COORDINATE_MAX] = { };
>  	struct cxl_perf_ctx *ctx, *us_ctx;
>  	unsigned long index, us_index;
>  	int dev_count = 0;
> -- 
> 2.43.7
> 
