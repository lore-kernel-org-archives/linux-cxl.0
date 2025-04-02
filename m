Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9821E9B0D;
	Wed,  2 Apr 2025 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603586; cv=fail; b=TVSXaQFF5ncj5Rrvi/IELDwiuEbPZUHWfjfakdJLrsfFsMrXgWo1p5sqlfR0KN4jIp4OS/FsJFg9eu7eT77N+AsnnjuMwt2XoDYlp2qc8mxAnT4I2AatQ5/OU+EpcMqfzlPMsxIZv034SQ4zMwJwe8yOd+U8/tsKG4DkdLXp6nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603586; c=relaxed/simple;
	bh=VxW/E0UykYJh+QD1QGo6w7ZtsUwqrmchx0C0iE38xeA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QEnYz35YEMa9nqiXeSuRgMzh2ZTd0xIGT9XqIpcjgFTLDSJ9OxNlN4qmEMduhgN8PctlppF9ASyccFee59MRrt9uKGvjiY4Ub6znEHwjEq8rCjh8UgUncNxtxbFUhUFgufKWAM6HPmaDAN8xOYIN56sxlJbBLctoBqG7uIGfyEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWbjE4Sp; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWbjE4Sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743603584; x=1775139584;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VxW/E0UykYJh+QD1QGo6w7ZtsUwqrmchx0C0iE38xeA=;
  b=eWbjE4SpCkbbGO5id/wd/QjqmBBsba9kNyDhOBPiB1FLOvtHs7dRedD2
   vqSF2JxYpQTjYJDFDy+XSIRDQ2+PuAyzoxluJ/jsFBThe62DmdaWazE2T
   TZB8EK5+reb0iChBZkI9mdGDpbjNDhgCtcZjTBjArS5MGx0u6gR4PDKQH
   aLry33cMQRdp07ZZb5q45QGBVL0oxBejv/vNvb/XYSmie21goRErhcmYV
   LVHnv2WQzsmVfniaFiQMIcUem1aw/DmsNNp9j9JyddT+wt2CqZpE6cVo+
   WkqdBgTk93wWdmCoX4qUxsV+EU6rmqzNy4CNLolXn4Tu+Y48sbzuAC4T4
   Q==;
X-CSE-ConnectionGUID: 3FyTMgfNTCqnmsZgeH2iTg==
X-CSE-MsgGUID: +WsKv4dgQz2Npv2W0564LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44227901"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44227901"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 07:19:43 -0700
X-CSE-ConnectionGUID: 5b7Y47j3SNa1qjuQ+5oVeg==
X-CSE-MsgGUID: A/UeZXf7SuGP3ItfxJrJIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="149907347"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 07:19:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 07:19:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 07:19:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 07:19:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=er7GXCJ5hv4rFaLZ52LBrFTlSb4EfV17Bc6gT6Krh1eOesuyVG1Mn35OSyFwL1NTdH43yKcP2fdmSRFDL9itJUPIg0FCO1W16em5jf7C/TppdZiLklkDKsKWdhVf6gLyZUcbxA33/aOVpiDCn9MgH9Bqy7UYY2pfft91QngjK4kgTmAkN/q0O/8RcU5g3N6Xkaa6kW/uTFkMXr19MCdjl4LuFMQfIaxEY9LjKR9iFhXynw92gXnVOJQL61EBOBCyT7tnKqE4ij91XaTdqs3CqSa1ywCI9H17kA6ThO1Oycaa835zMkyT7d+nTYtO6tQ0iW3ZCJrAku7jxN6puF8C6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhDrWDI3l+hftOEBxF/rsF5Ex2yRacC0M2EUUnfKtxI=;
 b=JoJOnDcL5Oo1UGDv1AHHwxqgq5YbhyV7ebEdoTUGsJKXo5y6bPe1OjmxMuXWMTJHGgOZRVvUwF93XPNuZJVnuFBzSWF7weI/fHDqrOLBgK5tyJC7gMxTq6WVlhA7u6NYoGPdNkF5ZKupYlxqYPOISbROr34Lwo+J9HZwYrJ1vmk4Nq8Cj2dpnUsPqFdZqAW7GAzkLDCpEHzE9l0X9fbFnIC74EWNcmQiYi7QolTFtbYqLdpV8Xb8iNeAyogKN/1Pc3Gen+M2gA4ks/Jux6PpYetapavOwaBox9Ul+dVDAaRgKffoCrIPMXaOERG0hybhtzuGkJD17aoLt9nPPvyPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5048.namprd11.prod.outlook.com (2603:10b6:510:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 14:19:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.052; Wed, 2 Apr 2025
 14:19:40 +0000
Date: Wed, 2 Apr 2025 09:20:02 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, Dan Williams <dan.j.williams@intel.com>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Robert Richter <rrichter@amd.com>,
	<ming.li@zohomail.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4 v2] cxl/core: Add helpers to detect Low memory Holes
 on x86
Message-ID: <67ed4792b475_7190f294ce@iweiny-mobl.notmuch>
References: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
 <20250114203432.31861-3-fabio.m.de.francesco@linux.intel.com>
 <Z4ccKD9Fc-Egc6EL@gourry-fedora-PF4VCD3F>
 <67ec4d61c3fd6_288d2947b@dwillia2-xfh.jf.intel.com.notmuch>
 <Z-xdYvxD6yz3fMiE@gourry-fedora-PF4VCD3F>
 <67ec7814ea055_73d8294e0@dwillia2-xfh.jf.intel.com.notmuch>
 <Z-zFrBqZHc4UWvMb@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z-zFrBqZHc4UWvMb@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MW3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:303:2b::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c85de36-0430-499c-656f-08dd71f167c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dPAjCwMemzBi3zN8mjSAEyiVuRWTNHwrdIiFnY61YgS8jic5F/gzs37cUiBy?=
 =?us-ascii?Q?zYjPfrbT9OSn6SG6ojsFsUb/wafGS0SBDODvQAgkx0u9vS2P6N1EEz2zKDdd?=
 =?us-ascii?Q?PSE/i7kyCB/uZd00QHgZMJTubUkQAO40SdJdKaRwboe1srKmy/u285tJ949j?=
 =?us-ascii?Q?1+TTxh88IGwg7Ag43drS1gL/aOCeb39V9k6ay853YKXq/sskr4n/P94v8GVs?=
 =?us-ascii?Q?hAb4EfAap+pVy3oSaYrQGaqWeh9QuTTq5iXgKu5m6HFyQUkzajInbkjkDW3q?=
 =?us-ascii?Q?gqsjqpgqFfki9AjIolxrUA+SzXJSjtWNzlLJS0gTAei85dPJKE3QMT5vDyDY?=
 =?us-ascii?Q?7WZM842pnr/OgBmhUR5rrvkBG2sgi+06dN0/2F4y4t3u9EVjimVFmetr9uuL?=
 =?us-ascii?Q?vQmSiUOV24AdW94yR0YV60iwjrG28+u7f31bqtYF7iFGVp2WRltgEBhEVGKW?=
 =?us-ascii?Q?Dp81/neA3bBPsKsQAWhIGH/ukiDDyxa7ZHfv9+CS6EGoh5E2gtMaf5O/ardD?=
 =?us-ascii?Q?RTrfua+42d7hA/Q+u1msDkz7LoyDl2IUYmIPOE3mjFDjoN3eTXiVK6uqSQSC?=
 =?us-ascii?Q?6ea7pkVNvWO5wy5xA63xUWCFmGQ57hAg+dMnuWRmRkPfLTst4EUfjsJziLQg?=
 =?us-ascii?Q?Y5n0z2C6MXaWFzS5mWqKm6Sb5nJXLZ1JzUlQv4xdhP0NlIdmZEBqrHQ/EJPw?=
 =?us-ascii?Q?LyxAT3BsDXttBdJjYuYkm/64hLIoXLyf084Ig4gPqKw/zBXZn1WsuBLoeUy6?=
 =?us-ascii?Q?u/1fzqoIuckoELvFKHxyIhtuKpyOV0ocheVVecoozInhtwd+eVRQRFtsfwsm?=
 =?us-ascii?Q?8RXNLgTU+ETIdSk/qdbhQx2kCvP8Yah4E9BNM91BmdGx2QYWDsrJCeD7KY6y?=
 =?us-ascii?Q?4eIpos9EJzznk9ImEhyEbEaasGvw0C5NcHoIHG56k5Y5YbpQeKWDRJ/+KtrY?=
 =?us-ascii?Q?3//g1BWDdqcapl0JdtZtjb7bgyAHi9rWpSYZjJhPySApwmoBxzOjCVZUoQY5?=
 =?us-ascii?Q?fEINMHckJZzmScxl5y9iFKrLwTzIqHFAGnje49PRSz+Spy/fkIgiuW9l09BI?=
 =?us-ascii?Q?tFB8WQNCLD7tYpZddO3C05FU/fiDoBhzHd8ozIbgLktLj+ybQFAdnMY7QmW1?=
 =?us-ascii?Q?yrfZhCPO/8oEO3K3lTI7WNzf68LLLQHAarZ8VDe/siavPlgAje5k3HSre0S8?=
 =?us-ascii?Q?26FyDZpwMPL25ePUVWV/R3/fj6cbnwE3EPg6JZ90opOICpcMU0LoJWeQfJm8?=
 =?us-ascii?Q?xa5Vlqn3Wdo9fj4DGXW2f7DmemIfGqXy150dUL7KUd3VLfz8OJLC29F6miu5?=
 =?us-ascii?Q?tVku7bgnxlkU/YnVGapHphTgSx15xHcm38NRYHKh8UKaCUsjH+UFh/OCUf+7?=
 =?us-ascii?Q?jpD+loHW/0l0MoZNBGq6trGdZgdZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNrD3VfT0lrDpq0xT+oNJWnaZCVvtcs2EJHXzTO6AS0PpxF+6kUsY/0QqnR8?=
 =?us-ascii?Q?pj9vHr5dpmEv3cVTeJ0/Uw0IN6H74CX3STpueiaQOM9xSu04j/oHpvAwCj/7?=
 =?us-ascii?Q?0GsTWg8xdAqQ4aRhK6qVddf4rVWL7R3HktBrAARZ6xdI4+Loc2fD8+ypLUQ6?=
 =?us-ascii?Q?nrEEUUuklDxzmMG5TnZw66CV3+ZOtZxu6i3yGAM1Bahpnl1rfwyUniqBjZYa?=
 =?us-ascii?Q?zwVLWvU7NiptA4ygd6jMf2LNbVSOGqg2ddHO72QPdITiJDxxa/4RVhwUKvXH?=
 =?us-ascii?Q?eZnR8ZqErjY4komXQ/bqSfTiH694ue+PV4+3sE8IphDrxu4ukInHRv468Yy2?=
 =?us-ascii?Q?ydVEpevkDbO9Xqk38CtkBpRXTN8PHPIeXgxKgpzXp/LAZcfKRrfFtPlOs1b3?=
 =?us-ascii?Q?0R3pFJx8ctiDDPiTwRjFsjAcJf0dfqMeyXXykv37ijaCWH4BgzH/NEvQBMJc?=
 =?us-ascii?Q?vgBOjsY805V8CdOTjpBXJ0arf83G0j8oY0TKu4MpUjY8BTvVtlOvRhlM6UhI?=
 =?us-ascii?Q?T+tkwU+t5p8QrRXNelg4gsPHcZcU1Orm5zd6ZYkE7bA7vj8FgknK21wPqOAG?=
 =?us-ascii?Q?So6ie2d0xu6C2IfAKUgnJQTm0IOUzO7a4IY7V2jB/yl6srh7BMdhXsKjfrDQ?=
 =?us-ascii?Q?ai/nNSbF+WnHT3St/NPvOLD3fQt/OGraSDF7aP4y0ey3CEUm4gYjNAWODW4h?=
 =?us-ascii?Q?/XvOGaD/iZuZI8fiE7OE5WTPMtv8fCL+rw9XUq5iVQ+6Q6j72GE3I+l9Vzgf?=
 =?us-ascii?Q?ey6hvSjvx3o/OXd0qRFJiQcC+A9z7m/ZtlEHMguKRDXLJl4AIDVVgwGaAo/F?=
 =?us-ascii?Q?Qo49Vb+Vs1A8ki1rxh+qQAdM4rKTdQOopzKLHksEmZptG2nPp3uJ3X7C9dns?=
 =?us-ascii?Q?PQeULZQZCiNDZGq77PekdGkVKT7pbml/E3wScHEyD1pEIZSDqOcKm47E6IKM?=
 =?us-ascii?Q?2iOTiA9JjRmlYDrjrtf0PV4ixjfxxDitoqfeiR0bWyJMB2X2NI3X3Q9RQuWj?=
 =?us-ascii?Q?PtDsXQjpxeLL8I54GfEdSjnCOLsPnR2K+BSMaMQI1tUmyqplApT+rQGyrYLt?=
 =?us-ascii?Q?lfXGbZsNTkoGbNzjAYnl1YHJ9pdcT1s9N0AUYENymp+5w9HEORGaj3IktFrJ?=
 =?us-ascii?Q?a+nROKqO6uYyowSq39xxvpGV5CSOUmd+wg9nBRzr6YcmCxUPqGwbEsO4z8mC?=
 =?us-ascii?Q?TsyTUwPaQ6ekCaoRA0dweLzlLN0vbuHHt+ph4t3atEBRJQE+ToSvlDm8thzX?=
 =?us-ascii?Q?GQJqRXbFb8eNwdwNtvJMKVNVsTcHSGpN31U2ea4NG01UH2yt747Y6URnxChp?=
 =?us-ascii?Q?z0dggtiHA/8TzwRJAcXXFY2eU/Xsm4b6C8fnGpVTUtUIYgi72phbZFWdJxmH?=
 =?us-ascii?Q?Va8K0YSYN5oyFhsi03A64/6L2u0sKfDZWMC0J0BiIMJefw58KoHexf4zydZo?=
 =?us-ascii?Q?wV/aXlkPEkCwRMUJCEEN2Nw9x5SOfOZJYUGmm++z29nAjwnmab8lc0F69Jy8?=
 =?us-ascii?Q?qofjdPLuT2rVu3TqfzT3lKqIxDjUUVcXHhWPbb4Zx949EANC2zShH9qcEG2K?=
 =?us-ascii?Q?+rgcifCksq82Me77WB4iQH5WEh2s3r3brTLU5vO+R7cZ0AArO12aczpNA3LB?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c85de36-0430-499c-656f-08dd71f167c1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 14:19:39.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8k10mI+aSh4nSKZ4KCyZc3PZsrtQhGkTCrFUhwK7Q1oj4peWo+3XPT5cdKr0ftRMdewcQsVAQ7seEr+K2KFd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5048
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Tue, Apr 01, 2025 at 04:34:44PM -0700, Dan Williams wrote:
> > The platforms with this condition want to support CXL mapped starting at
> > zero *and* the typical/historical PCI MMIO space in low memory (for
> > those PCI devices that do not support 64-bit addressing). If the CFMWS
> > blindly followed the 256MB*NIW constraint the CXL window would overlap
> > the MMIO space. So the choices are:
> > 
> 
> If I'm understanding everything correctly, then I think this is intended
> to work only when EFI_MEMORY_SP is *not* set for these particular CXL
> devices - so it comes up as memory in early boot and we're just trying
> to wire up all the bits to let the driver manage it accordingly?

That is how I understand things.  But I'm just jumping in just to review
the patches so I could be wrong...

Ira

> 
> If that's the case, then ignore me, i'm just bikeshedding at this point.
> 
> I can't imagine a system where the memory at 0x0-4GB is intended to come
> up as EFI_MEMORY_SP, so I hope no one ever tries this :D
> 
> > > (Also, I still don't understand the oracle value of <4GB address range.
> > >  It seems like if this is some quirk of SPA vs HPA alignment, then it
> > >  can hold for *all* ocurrances, not just stuff below 4GB)
> > 
> > The goal is to get platform vendors to define the rules so that an OS
> > has a reasonable expectation to know what is a valid vs invalid
> > configuration. A hole above 4GB has no reason to exist, there is no
> > resource conflict like PCI MMIO that explains why typical spec
> > expectation can not be met.
> > 
> > So I want the subsystem to have an explicit set of platform quirks
> > ideally backed up by updated spec language. That allows us to validate
> > that the Linux implementation is correct by some objective source of
> > truth, encourage platform vendors to update that source of truth when
> > they create new corner cases, or even better, be more mindful to not
> > create new corner cases.
> 
> I follow, seems reasonable.  
> 
> ~Gregory


