Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D238B149;
	Tue, 23 Jun 2026 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184317; cv=fail; b=ip5Q5dlznYlsJGIKM8tkKVQl4jF7z4p7IyuGm5R2NksTRJ2iBFOFfUGIg9AtgltGINBcBEGBziM6zFEqNlNy2MtTnDC41IkoTaz1Gkm8e67cv/4W9Ns6AR/TvhtLkI2i/LqX3JC4vicoAbXbQo20ykkxyrzgjT0v0PvfEPEGjQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184317; c=relaxed/simple;
	bh=6q5IGAuHCqoKtqkXr7t+x88pxfxyGoFYPZaubleqW74=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pD0IIGRZYJL+Z2KSaLZrE+wDUxT3V5fWmlO91GgQak4VLV/2Z5e/wNEELEvDTamwzl1+wUnAk3xJA5nurnV5Va74cQNWzHsg/LmAfk5PAuYjCc4RQIlPAVYbgQ+J6l1VnS/9WwUcC77aOhcegxuzP1e747G8PyQmeBINFld8hXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4NQ/b6t; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4NQ/b6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782184311; x=1813720311;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6q5IGAuHCqoKtqkXr7t+x88pxfxyGoFYPZaubleqW74=;
  b=j4NQ/b6t2rcIUVdoODMJtSBlphSmXuEHWGKuHn+oAhx9x6VORlxYH4/z
   CFPCYfZjMNZDlQq5BQll3wVME4l5fBnEMvRRZeIK2+TSE90in0zikVCHc
   +pSmYgweJNo5Zr+XylmVRNPp1DY+VF6rJ/OBfj1H79N1j6kH/JPe+xVB9
   8zVppXrdaIGNI4VAC7+vWRqKQD5RI2wAfGSFDY5RSmkxeZb4188v1Gwl/
   1otm6AoQVwbAychvQwolfsa9MufCGJvhY+wDseXYnF1FwnKp1Xhzj3Fm0
   utTDipKb4UJTlzv3oTMRnegjJKxN9L8EbTTYhmosQdXApzqAIbUiqaLwF
   Q==;
X-CSE-ConnectionGUID: j8yrb93OTyabgm03HDPCAw==
X-CSE-MsgGUID: P6L5+C+qQPuPGVBksj+Zwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94417184"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="94417184"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 20:11:49 -0700
X-CSE-ConnectionGUID: oHmyHmmiSKOlssZpzkJ0Cw==
X-CSE-MsgGUID: GTAiGfSLRQOolV0IvQHY6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="247054107"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 20:11:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 20:11:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 20:11:47 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 20:11:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ke8Y2a2cTDQVPzjbNeXbeev4bjpkeLiE1w20GUkJRebxTBf3mrfHEASLa1PyYZ+UNDQX9btWD8tyWB8gIVhlJSmYXb95AnoeHe0mVPhkOl+JINs+GuzpcET7kwsABVgWFeXDNrkNA/yh5NeWqDAJDU+/+DgjElTpeDlozcJexFhtWOgDDeeQ7MIRMLftD3qzePSVdASfesWd5W88BQU6PF51xDOjkOWGsEe49kMeoauR7MoqUxlmKGfO8wU/zaus9d3ZF/85L6gOdQ6jwUXSMhKB3Debp6diJWMT9zmm/GDKfo9O59QQvv4QCwBfiBN0QHITg9Ej1bipHO0btbQXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuLmR6hC65U+/zm4PcU+sOE6DmCKj2zyPtgLrvnzPYE=;
 b=MBNvQ5BP8iY0f4AlK+fRyTSmgqDVIGKh3vUvc5jb0pcJToMvIRkQK4ixhRP2Qm6ox5H/jFwXUnWodMrxJUvJoW8NOLI6fqcPN5LCEYqyMHpqwUjjCW8UeGxhhRMtqjBecA2qHFb654nL3ciMSYEAO4jEaK7fWsi2t9FwIRckiXPLfs18vgwGbLmVZ7NR2JrK2V+j5deIQYA04OjCVpXktgzDZM1y+H3mvnYLHywEPWk0w4Jmp6PFkpj77h4ziG2IisCXbIbLEOo7WHGTyEJcOaCsiw7SbBO3AfxC95ywx8EGhsf0zQkhUc55ydFw6V64BtE8ggs4w7Hj93zSMuqZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 03:11:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 03:11:44 +0000
Date: Mon, 22 Jun 2026 20:11:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>, <vaslot@nvidia.com>,
	<smadhavan@nvidia.com>
Subject: Re: [PATCH v4 2/2] tools/testing/cxl: Enable zero sized decoder
 under hb0
Message-ID: <ajn5bIu2lSrjqtXv@aschofie-mobl2.lan>
References: <20260607081345.61954-1-icheng@nvidia.com>
 <20260607081345.61954-3-icheng@nvidia.com>
 <aixM4NA7hX43Bs_y@aschofie-mobl2.lan>
 <ajkLv7vRScdspEKV@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajkLv7vRScdspEKV@MWDK4CY14F>
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA0PR11MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d23a7aa-016f-40f6-b167-08ded0d52757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 7cdMBLnzT2VTgIiSGQDY76yvH7fMIqI4v0/elWpzmKdKDO/IvKzQH147fHbMSlX+Sf8bJvatM0Vi0AJGZ6/Snw6yH2mX9RVO86+KgEIWaIxHxCY9VFEypPRBNMGWUSSbX5VYgvk1mfu1Hl1vrPg30yBrkG7vKkBJheItiQs4gO0rgARpmw4pNIDSdVtLGrq9imU9iivaX2qyD8rMgcPnfTqqL9xs4DS39ctFHMpxUzmMdqqrMpXlBuFG4C06nvuDVYqZC4oQbt9gSo6XJSxVfYmtu6ZCj2eKoo1zNRwXqKF28I0hT35ZtR+tJqmu7YBIcZszS/vRU/iMRMscnKV61vjleaCHmzuTcYPWv+sgWN93Gfw/bslpJP7TsXVoWlZl7FPNIU8yDxJk55oCc/8H9Ov2rTNGugkqdu/AmOktVEHaclwPBwrRglJ+FRqaxoSPi4+B07aT1svUeAYxOtHmtne+XsWC9d+xINqYnxBOk2bA/ek54hzL6qDx6J18skwG4F3gTvKEkvtD+iY0yyGZ60w2w+2QxfRx0GSswmm1MRIO/dRw4gXEJPeJSaP7GbwnK9pzdw78LoE4CDBjKdJjoKv509kZ5zuex5hdm3R0w9bGfA7pbW+CDRlDFymHmxmaDFQNBKc7SR9vxx0IH+ctMq9xSKf4sfXmTylU1fwfbzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6iCd6xrNNUtvZijlVIrNz9p+csAGDWeWejpN/vJTEcDVYhxWUakoxxAeG3er?=
 =?us-ascii?Q?gHTeuwyr/3w//OiKt4pLamhvr8nuCKNh+w88h5Pf2LpjFShiYLygz/rEyWHZ?=
 =?us-ascii?Q?dCxuHCsiLF7R2G9ofFxPJ/H8UjZztrLandwL9XR+vOUdMhvwXqWSfL2hQdF3?=
 =?us-ascii?Q?AKXl4TIUfaNS9MfjauFiYKOZA/EHfiv6HOBtgO2nfiIdacV7y/vYus4HC7NG?=
 =?us-ascii?Q?3xr7/NX2LJPGw4UFf9guYU33b613TxOL54y/6teeiz1+CkgqDkImdqT55nLw?=
 =?us-ascii?Q?IzCo2+/D6uJTqM1fmIvLOdCWqZYVeoK0cMiNcuHmVjyhqpIZfJC6kcqsejMJ?=
 =?us-ascii?Q?Nt/zAyqSn9UjOKmR5Tzpw70UYaR487UXCW4M/wE7/UZl/paxOupfFyrbo8Kt?=
 =?us-ascii?Q?xvJpmDRrF/84MlERdvTe+iMW9xtMZfXf1Bmh6mi+MvX6XKVJfzPO5fIUjil1?=
 =?us-ascii?Q?FT1CmodzMEeSuYkWmdDXBZqav1OBeh4oP5Hj4K2Rc80jezzND0N0ydPriWIn?=
 =?us-ascii?Q?4nium+ySFT/OaZu508b8NgXRR9E0+3WFif97xB4UUwGgHCQXxXHdm0+XfSj6?=
 =?us-ascii?Q?IfnsLHEaQ5ADw1YcPslaDHEL3jL1PLkRHMoIyIGDz0yZhdLHtrWFY/AyzaI6?=
 =?us-ascii?Q?kSNjdURt282u2cxitYZ9omV+thZYd5Cfc64Klglw46Kq1cSv5MxbRO1EtwEF?=
 =?us-ascii?Q?kVetUCdEzieqwe27iRg+j0nlHP4nooNJgg0jOMdUaK1Io+3ZY/8a5BVnxhHz?=
 =?us-ascii?Q?ulsxfDiUQLtSMV/tk/Hl1bZ9kjA8vBVCsyOQPLOSqDqV9+fDwfGz4WItLRCI?=
 =?us-ascii?Q?qLZr/Lt9rSKCzcpR2DDI6AL2TaHfzqh6cM/qDBbwmQoEQSFj6Jy5TCH7sDlu?=
 =?us-ascii?Q?YJJOGsCdyKZLtr1fjlmFeaCLjLQdvWJn1bL9K1Aho/8v75Sel/svgYiRK9Gd?=
 =?us-ascii?Q?RPM7RwJTA9prRZvWp0mtKLTSfgT2B6Nr5w/nCZHhyx0JAhjGuHfRAwo3TZnq?=
 =?us-ascii?Q?2lpSju868+zNKKgqVriwE3ELngt+HbZMx9HV3krzysufLje2y8AFkZSiUZKy?=
 =?us-ascii?Q?DYSVdH4Z9pxWjGBxehAC9x5NcDDtBM8ix17RKCD7rcl99yGZGxLDzA7rRcU7?=
 =?us-ascii?Q?WJHP7J4k/4xe9ptHnYVw9ydNgCfj2SdZS+lQqe5VK9rlPyQee8mPF8A5lb3n?=
 =?us-ascii?Q?6hLS1zDlo8U3Mw17lwE+5gVc2EfbPMXBfV+oGd7mHk82Iwab1qSw8jli6QuQ?=
 =?us-ascii?Q?4aB7MYsvti+puoKTnlVkinqtldR8D3sFkvEgkZS1dnfQMD3wU5xxWCpjB04/?=
 =?us-ascii?Q?P5iJgutaP5XahmJA5o/GRjDiqEGUbW0nlG0oTEh7WOldEp0EKbCzBVNZCot6?=
 =?us-ascii?Q?goD9LooMsNerOo6hC2oVsve4ATLXHF8jGIEjQSHYWzsd4jpxoU1NyrrGn3KZ?=
 =?us-ascii?Q?lq/gU1QHINF6n+jTtQX2+NUasGigyxCafeVbqkJdLdkLJ6EA2xVk6jYsK4Uv?=
 =?us-ascii?Q?QXNLbNmHiBRtj1pzkgpZElBXWZR98xjn4X9F/KD2PuvxsoISsmwZ0IQrM5ya?=
 =?us-ascii?Q?MGr4QmfWpJnnsZfG6OIvCJHW2SVGiz4wdygVK4Izp8K5i7yE8Xh/yw6Tljyh?=
 =?us-ascii?Q?IIkMNzsBP5Og2P5KOMneOz3J2PZku6RoFiQnlys31sORMmaUS4WyyRpBCNjf?=
 =?us-ascii?Q?S/Ii4MfYsjZyuj9Hr/Kl62OHZbc9GzL+hhG/97dA8l97Sjlu9mbo/JgZvQvL?=
 =?us-ascii?Q?hgzJzXQ5d60oTv4/ztq84iPaakys14U=3D?=
X-Exchange-RoutingPolicyChecked: EQQ/doWo+fJ2+kcwbHQ/8ZZbrwseAO0Z8AvTiO7kf//eKJGUCcFzrtt2/15eFk99eHv94v4qUlyhW2Dse/bajXG6QqzapOMALCIBLTY6X5d1zpyVmNJ2S0DsSCXv6QNJy5z0bifVmlcKnshSHbZN0UFkXjImEciAbdNgg/652/pcblYEHpnSmrKsEZszBeN4mjNFMoCFDckhMEcNAD40rDsmK1PTqnYeZQs0WmZSwEPBQstx7uEdrWzL1wEe+VBqKEqLAZYqbKUizeAGdljwQjzx+attVs/kQBcm1PndRiJj8kExGgKUzrxTm74G7WC6GF5p9P9Vlg8Q97uso8KeqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d23a7aa-016f-40f6-b167-08ded0d52757
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:11:44.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYJHPvuVDUBTz4aFqYdZaM4DHXaE6KVOLD+dLQ/3dDnmWzg+CE7tFOnFXYR5F+VGhcFH1ThNk3ZUpPm/TRnlggCqyRNsd8WbDzD9Q3QlRqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com

On Mon, Jun 22, 2026 at 06:19:00PM +0800, Richard Cheng wrote:
> On Fri, Jun 12, 2026 at 11:16:00AM +0800, Alison Schofield wrote:
> > On Sun, Jun 07, 2026 at 04:13:45PM +0800, Richard Cheng wrote:
> > > The kernel now allows committed HDM decoders of zero size so BIOS can
> > > burn slots with LOCK; cxl_test needs to exercise that path.
> > > 
> > > Add a mock_zero_size_decoders module parameter (default off). When set,
> > > the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4) commit
> > > decoders 1 and 2 as zero-size + locked above the decoder[0] auto-region,
> > > mirrored on the parent switch and host bridge. commit_end then lands on a
> > > decoder with no DPA resource, exercising the new enumeration and
> > > poison-by-endpoint paths.
> > > 
> > > Gating keeps the default topology, shared by the rest of the cxl suite,
> > > unchanged.
> > 
> > Can you add a unit test case for this?  I think it makes sense in
> > cxl-topology.sh. Perhaps before or after the work on the default
> > cxl-test topology, load this new topo up and validate the zero size
> > decoders are as expected.
> >
> 
> Hi Alison,
> 
> No problem for that, but I want to make sure you are talking about
> adding test in ndctl right?
> 
> I'll send v5 within this week, want to make sure they are ready
> together.

Yes, I was thinking updates to cxl-topology.sh and now looking more
at this version, cxl-poison.sh.

I only suggest appending to cxl-topology.sh because I don't see 
any other 'work' that you want to do and verify with the zero size
decoders. If there is more work to be done, than add a dedicated
unit test.

The verification for the tail mappings appends nicely in cxl-poison.sh
but frankly, I did that before I looked at changes suggest for v5.
So take the appended diff suggestion as possibly useful, but maybe
out of date:

diff --git a/test/cxl-poison.sh b/test/cxl-poison.sh
index 49aa1b68c5c1..b40c896a0903 100644
--- a/test/cxl-poison.sh
+++ b/test/cxl-poison.sh
@@ -361,6 +361,16 @@ if check_min_kver "7.0"; then
        run_unaligned_poison_test
 fi

+# Assert poison in the unmapped DPA tail is still collected when a
+# committed zero-size decoder sits at port->commit_end.
+if modinfo cxl_test | grep -q '^parm:.*mock_zero_size_decoders'; then
+       modprobe -r cxl_test
+       modprobe cxl_test mock_zero_size_decoders=1
+
+       rc=1
+       test_poison_by_memdev_by_dpa
+fi
+
 check_dmesg "$LINENO"

 modprobe -r cxl_test
diff --git a/test/cxl-topology.sh b/test/cxl-topology.sh
index 170c9caf840b..aee675d3b7fc 100644
--- a/test/cxl-topology.sh
+++ b/test/cxl-topology.sh
@@ -269,10 +269,46 @@ do
        ((count == 4)) || err "$LINENO"
 done

-
 # validate that the bus can be disabled without issue
 $CXL disable-bus $root -f

+# With mock_zero_size_decoders=1 the host-bridge0 endpoints that back the
+# auto-region commit two extra decoders (ids 1 and 2) above decoder0 as
+# zero-size and locked, mocking BIOS-burnt slots. Validate that enumeration
+# does not abort the port and that those slots appear with size 0 and the
+# hardware LOCK bit set.
+test_zero_size_decoders()
+{
+       local region target_decoder base burnt size locked
+
+       region=$("$CXL" list -R | jq -r ".[0].region")
+       [[ -n "$region" && "$region" != "null" ]] || err "$LINENO"
+
+       # Each auto-region target is a special host-bridge0 endpoint. Its
+       # decoder0 backs the region; decoders 1 and 2 are the burnt slots.
+       for target_decoder in $("$CXL" list -r "$region" --targets |
+               jq -r ".[0].mappings[].decoder"); do
+               [[ "$target_decoder" =~ ^(decoder[0-9]+)\.0$ ]] || err "$LINENO"
+               base="${BASH_REMATCH[1]}"
+
+               for id in 1 2; do
+                       burnt="/sys/bus/cxl/devices/${base}.${id}"
+                       [ -d "$burnt" ] || err "$LINENO"
+                       size=$(cat "$burnt/size")
+                       locked=$(cat "$burnt/locked")
+                       ((size == 0)) || err "$LINENO"
+                       ((locked == 1)) || err "$LINENO"
+               done
+       done
+}
+
+if modinfo cxl_test | grep -q '^parm:.*mock_zero_size_decoders'; then
+       modprobe -r cxl_test
+       modprobe cxl_test mock_zero_size_decoders=1
+
+       test_zero_size_decoders
+fi
+
 check_dmesg "$LINENO"

 modprobe -r cxl_test

> 
> Best regards,
> Richard Cheng. 
