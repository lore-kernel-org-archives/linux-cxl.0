Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB330CD9F
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448486; cv=fail; b=Kw3bCj3LL5XbD8D/G6botwj0kfPpg9l2uO0cEL1MtgWLx+xjT2WO5RWanOR2TO20e43C5vAkcRo7LoQL5l6XoZRTpdoLUJEKzpo9ZQ0KtxgwF12upY2wdUrhkBDPMf/VVsEI2EQq/ILw24GFU3iGLULVZPAG5EghaGWibOLE2tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448486; c=relaxed/simple;
	bh=WBBVPcjOFELuMuh6+SbjvoqpYQwIX42EqBd8FBY6fOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klLMGtIWWZTPWGuElWbugwURO+vSWmHxaVUaEhnrq8BAPkWsJy0vviOPyJhbx2pGgxWdVI8V4GRdZjpxMlLyEhHzvQbHK73R54kIFgtnBNUWgin914/20cKzxfxcUvWD844PE4wA6+sFuA9BgZ/lM4wDJuMZrvQVWJ5UIU+K7Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPlc7BVx; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPlc7BVx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756448485; x=1787984485;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WBBVPcjOFELuMuh6+SbjvoqpYQwIX42EqBd8FBY6fOw=;
  b=JPlc7BVxl5pqwabf43OhRwRw/upSdztYLvXrWJKzgIlZ9QBZ5F3Gf366
   TTX3XSktoX4KdRdUfj5hBS9af6Ni1xo86/5hrR9ix9UgjueesmfiyTccO
   EHubTaqtM2mKlMQkCbMqufO98K2NV+wrJDNTPgq+db0XTCuxm3B+vZB1m
   3hRAaXMESEvD1xFhfO2vZqllsdUwvcPjr4jSGsabsKhIdp9tCdWwkaTDj
   nEsa6LtxkIfUm3PogQMADK4aGfyexWCxNI8q+RUNQF9vcSKjpaS5rXORk
   6dSkwUWv9CAMmNOOESJe6Z3RPrgNLLyJU8YQ/Phge/60YEdPZCqDO4Ipx
   w==;
X-CSE-ConnectionGUID: YbZ4PbIjSC+eKoom0ENMXg==
X-CSE-MsgGUID: wBye2w7+Rhi/JYoVui0SmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69325164"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69325164"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:21:24 -0700
X-CSE-ConnectionGUID: 0od0pSKCTJymlxNt8JckWg==
X-CSE-MsgGUID: 8pK9tZs3TG+4cMP8bJf/+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="201248879"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:21:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:21:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 23:21:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.50)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:21:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxIBrqY1bYMMDzQYzgwEydph9tyFD5gof78u73MtzRGM/qSd2/nJvyEGkG5aITqwbt3fWkweUAoLeDpLIRLpGxUPJ9TUJWl7Mvn2WGbsXYEJsb3+OgOE2rqlFmNZ6wOzM0/lF2/7JUiSCNoUADpcoCb5Hywe+8DCMRqprRdZv2Lfv4sSxaUritaY6+453ydmDLT4Y4Xg1U2BP7roioejavqND7AxdVIfKNPzcZk3Yas8YmnDJ/4xpAiuF5nWbRNvUUuBbpv+GA6WZVHPePF0s8YNrUxIEWH6HMG/LVDtDV35kSJcaYSGjd50O9FX2wfqMJ5jyrW9PJ7wHJb+u6rhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1wt7VIfmO9bRkADgxfFZPp4MOuvdPA27EYvQy+EDZk=;
 b=PLecipo29X0xPoB/RW3WEXy5CXJKcv/I5Opr9KCZEIQzHNL4GVEVXmiOlOORGp6vLEMZzWDUjkB4rzV0LbOykbddjfOzJdNfDYbfjtamoe94J6F5dtD0wgx8g6Xa1XQauSdU4//B2bThU94K7MtswL4M/dwlpmeQihRm9Yq+PvhNGCqoO0P0pb3NO6UbeYmnGpq7N3G2YtMu9oAdw2aBsowYAjzZbdoZbGIGlAxCO+Fbs7WRfxh1c+eOMSQYC5qiGY4p/ptfHQHnsUUqQibzFSjgWBwlK6OvBUAyjUNbSJagtPBXd1NkwJepFPxT0VAYVMVDg4BX1q2u5eLPvCM+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPF89507EDE4.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 06:21:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%7]) with mapi id 15.20.9052.023; Fri, 29 Aug 2025
 06:21:16 +0000
Date: Thu, 28 Aug 2025 23:21:12 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/region: Refactor address translation funcs for
 testing
Message-ID: <aLFG2J_V65mJBoYg@aschofie-mobl2.lan>
References: <cover.1754291501.git.alison.schofield@intel.com>
 <d60d89dab66e1431bb2ff5cd7da1f0960bc2a057.1754291501.git.alison.schofield@intel.com>
 <20250808171218.00003c57@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250808171218.00003c57@huawei.com>
X-ClientProxiedBy: BYAPR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:a03:60::33) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPF89507EDE4:EE_
X-MS-Office365-Filtering-Correlation-Id: c537aca1-78b9-4fef-4d03-08dde6c44226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?118sy5VRfmC5o3n76eSUSb/cXrN6J4O0+tz/oqk9RhRJ2lFeHM/jllIV0emO?=
 =?us-ascii?Q?hvNNBjYT6Owgs0Rr+fgwHOkKuI3xVkLnKlcKTRFR6/Vk6mj+9giQmdssPBdb?=
 =?us-ascii?Q?jAoWqP6Fc5PfjjssleFTjRvPLBzSLtFPN0s0rvshumkxWJ9yW1xpoq58udLs?=
 =?us-ascii?Q?+IM8gSt85vEIdprQZPO/eAbpDLsTJRCK04+V1jJ8scNlrr6lCiAqXMjOa/EK?=
 =?us-ascii?Q?DBXE09Va4lMszTDwZFLvcktUeh15rYLolFMFtsELBd5KYBgQLGM6KB4CgvVH?=
 =?us-ascii?Q?r6+spkEG8wtXTkWV94237QfjwHBnTkD0e9s5f//uXdc2NPpg9grH+Jfb5c2y?=
 =?us-ascii?Q?NiGSwytwzqxPdrrJ14mS3mJOLjvdMbVajZp3MXzwPBvCSyMlXmNyCRebxFc/?=
 =?us-ascii?Q?Ys3T1eegUj8+DAM7algBpP1XXo/94ewL9rnZVG99sPDi1jQJPOPWzy/ehVE/?=
 =?us-ascii?Q?akiKyFsu5AF4COtSOCKjCA63+1rw5G7d1F76Tzj2137ljhy0SMFmxj4h/LYg?=
 =?us-ascii?Q?itpSfVD32g/tjt7Y87P341gbAX7Q56/rvup1Sfd7NPic1B0iM0i7p96x5eoN?=
 =?us-ascii?Q?mP+le81UlyvL+9tab0o4yRJ5F076kuSAtXflDFmKuTFuag/LceLmqGzwy0fn?=
 =?us-ascii?Q?yWPgebk21zIERl8NfIUlmEFos1YA40IiMEY5pKqHlmnOVvlXYV5mm4zofpW4?=
 =?us-ascii?Q?U1OSu+TZFTPRgxrX0yOL0Ywoe3uj9fI8TMjoqycf4to2ewOjsanSxL6850Kz?=
 =?us-ascii?Q?wvjSVK3SLbz0oAHxJRJ1Yk0vTGY2beYNL2T7jVmnyoxDJLHgi4ZrgI/DKH1g?=
 =?us-ascii?Q?7Ua8yn3wI+j0Ixe5gHPAOKra2lqJi1C7bzgR5QQUhThe6fllscyzf7Ugzpjd?=
 =?us-ascii?Q?9sgQ4QeElvthQ4vXS7d6UiS0xOY2G8lad9/ERL0/jWb9YHb7ay35JGN+rZXg?=
 =?us-ascii?Q?Q8WRNcNnnHyuHZ1+HV02sV7ZC+OdSxOhkp2YJDYU9Ndvex9hcYLQmAPX0Llv?=
 =?us-ascii?Q?Z+yGecR/pneoxCLWtlIVyThcVMMqAIWNMkcvMlSaq6bpoG0ATEDJnLTQ79wi?=
 =?us-ascii?Q?SgtJkc0HdfHl6TCWXO0ZzpJUvJE7/2juBIrWc+njmicuQ4QU1SZ0X7koxxc3?=
 =?us-ascii?Q?rR/GENPQ+GMoaoN5x6lXiIQQm3sf/6gRIsiMBweRi+ZFGrvq9PMkSYB0AtKk?=
 =?us-ascii?Q?ln2ZK/2Ud+1Pln6/ql3jXDg3TV/gz3Lk+27H2V6dCrXAGBgicdchQtEJgeU7?=
 =?us-ascii?Q?bb/m91SQjgl/aIjpoD0R2HHDJesLRtwWMI3ig84zXI8rjJaIoaIX8yOkktES?=
 =?us-ascii?Q?0XPHZ+x1/F2Zz5sAqFhsnlbHMFjuYsJZ1eBUQQ1hwHKk79iXWhyibUn9o2zN?=
 =?us-ascii?Q?1at9rLWtnaQf8busleFZMcOLpP+8og3xKA2I8sEZ+9JKDbnj9oHllkzuh1Yt?=
 =?us-ascii?Q?+Qwe16gERlA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wkxhZU84niXaTPeAV1sBu5L3P/bS927UevKHJc9kyCBwbG1+ExePhQOyQjY5?=
 =?us-ascii?Q?dE+x4RVLjV57VfHfs29+gzigCc2kolIRKczSEta32Q6q4RfRtnv4P8xh9nKJ?=
 =?us-ascii?Q?PVt+K2NK0WrJiNqzqv0icQaJ2RXx7LH6G/Prxe4JzmyPu6WjqJ0HKlYmYKsi?=
 =?us-ascii?Q?5uJBVfgG9gbiRhE+0yGChT7AxTfc/jH+ij/P4Qa3dCysxVsk8x7KRZqKkReE?=
 =?us-ascii?Q?mHzk0uMIGAcr1R34v8cAryKn3ooyoOBMqRd90NeepKPNtGppPtlJqGUBsP2d?=
 =?us-ascii?Q?UiCCKUdwl7ajQpMKl5adx1wowuFStSt1sEqpk+dMRIIngZIAk53ej5yJOT5W?=
 =?us-ascii?Q?GI2l/WYJ57KMCxjYhwO+tmXtNIXWE7BF9TdryPma5xWWf3W0j9S4CGljj26s?=
 =?us-ascii?Q?ixU3IMKrDVEhsi7qFOm8HxNkx7Q6UiDDM2jiTaD9MogKsycpURXN8hFgbGu2?=
 =?us-ascii?Q?BJmVBk1xNIRhlQafjF9g4m765tHpzy/06FKQORCkQkLrd28YinL6kMOTU4Qx?=
 =?us-ascii?Q?Iw+OjovFb/qrjCaSQdG9jeNDMRIpdQZKkPdFP0fBJuPD2qvxYHtq0rVcrYoj?=
 =?us-ascii?Q?eYuleZp4sZLbNDU8m+kE5Y79ucXLhpdPatHGzJntQUtlzKhcYp5ciQFem4sy?=
 =?us-ascii?Q?4B8tHgxGLYehZpcHObPV5BExFXUheoTX4d2jIRRlUVfOBa/Q5PX4OrMVi+cY?=
 =?us-ascii?Q?qS/y4RX5YTp1O6QjFbUR9CCIDtHaFyG8cDAL8icmTSoCVnaUgSPqkwfRVk0J?=
 =?us-ascii?Q?3vbKUVkcbjxEMemi/gLn2hDphVjhvBgwP8MdLZ7PO2+ANMYRD0cfCwUXnsz/?=
 =?us-ascii?Q?qRro+zUqFp5iQIq2UH4sp0b3aHn74mlp+gQUO7ZEqgKgtCha9n4jiVmXX9la?=
 =?us-ascii?Q?YNmYCCSR8gQrmrVuMgq770w2+b9NdeDx1ERCpmAQM2KTiXaZllUUMoW9GKfi?=
 =?us-ascii?Q?DSujInerLw8LoDLc3EF9p3VCdIPW7w+L3oeHlGcrFgCuvtN3Vzm6EayZahzQ?=
 =?us-ascii?Q?rbc5+Braz4t3lzsgh7hUDVOJtJv6sMyYTVc2aClMsp8RX8mH7vq0ng3ugo0o?=
 =?us-ascii?Q?ibzQ5CiJrOXN8EVq3VdZyFk0b9Q6K4bxSijDkIh983AtImYZ5klhS5TkJYF3?=
 =?us-ascii?Q?UDP1YAMhcSbyHjhMYKpOqStozX+6IJqab/j3lCxR5WXJP4FL3voiNliQJq2O?=
 =?us-ascii?Q?v0Yl+qSxmPL4HS40dX9ohURKT0ZPKTyhivLtW2lDjuDIAa+SpSPBFHQFVLgB?=
 =?us-ascii?Q?wEYUTn1yxwbjJgMfY8hY1g535dLpkffQRlpV3Ccc6PYOxwA/DTdYm8KZbS3F?=
 =?us-ascii?Q?JtwDyo/WcjZ73eabu7Pn2/21HLp8qcLtfYhq9KNB311itDAZGUfy87ApyYqT?=
 =?us-ascii?Q?GAEwyLuUCfe5SZS/96k9p0HQT+h7fN2n61Di4RcBTtwpjliAkotjiSrA6Uve?=
 =?us-ascii?Q?kl3iXSBJXJ9Klyuo0fgk6gsRbR9k+uvBH+r+KdGcqJELGSixIrxiZvvZXaX7?=
 =?us-ascii?Q?nfkMIRCngDAW/sImcm7IMOSC/z0ZBDUrBqbDTcSwXcqDhFvLv/DzOpD1fBiV?=
 =?us-ascii?Q?bfouUoWaUMKyw0CUGQ39v9yvSMREKo2TqsPkfJKmDEJxrZ10AxMylrbG+ZcV?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c537aca1-78b9-4fef-4d03-08dde6c44226
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:21:16.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NO0Sela8UR3r+AZgQ58/ae7uDQtihStfBMxrDTsEAcA8m4RAvDkxPjmOfwafwXBHRTnq6mfnXRCz56Xu4KXeoEqOrp9B81E7PFyZMnvvrWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF89507EDE4
X-OriginatorOrg: intel.com

On Fri, Aug 08, 2025 at 05:12:18PM +0100, Jonathan Cameron wrote:
> On Mon,  4 Aug 2025 01:52:39 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > In preparation for adding a test module that exercises the address
> > translation calculations, extract the core calculations into stand-
> > alone functions that operate on base parameters without dependencies
> > on struct cxl_region.
> > 
> > This refactoring enables unit testing of the address translation logic
> > with controlled inputs, while maintaining identical functionality in
> > the existing code paths.
> > 
> > The moved code has only one change. In the new cxl_calculate_position()
> > eiw_to_ways(eiw, &ways) replaces the prior usage of p->interleave_ways,
> > since the new function cannot depend upon struct cxl_region_params.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> A few comments.  In general looks fine to me.
Thanks for reviewing -

snip

> > @@ -2965,19 +3043,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >  	/* Remove the dpa base */
> >  	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> >  
> > -	mask_upper = GENMASK_ULL(51, eig + 8);
> > -
> > -	if (eiw < 8) {
> > -		hpa_offset = (dpa_offset & mask_upper) << eiw;
> > -		hpa_offset |= pos << (eig + 8);
> > -	} else {
> > -		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
> > -		bits_upper = bits_upper * 3;
> > -		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
> > -	}
> > -
> > -	/* The lower bits remain unchanged */
> > -	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> > +	/* this chunk was moved, maybe move comment too */
> 
> No idea what that refers to!

You caught me talking to myself and you caught me not listening to myself
too! That comment refers to a block comment that is cut off (from the top)
of this diff. I intended to move it into the new helper as it describes the
algorithm of dpa->hpa work. I've moved it in v2.


> 
snip
> > -	}
> > -	if (pos < 0 || pos >= p->nr_targets) {
> > -		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
> > -			pos, p->nr_targets);
> 
> Bit of a shame to loose this debug print if we hit this condition.

Yes, that was not good. I've restored it below in v2.

> 
> > +
> > +	pos = cxl_calculate_position(hpa_offset, eiw, eig);
> > +	if (pos < 0 || pos >= p->nr_targets)
> >  		return -ENXIO;
> > -	}

snip


> > -		dpa_offset = bits_upper << (eig + 8);
> > -	}
> > -	dpa_offset |= bits_lower;
> > +	dpa_offset = cxl_calculate_dpa_offset(hpa_offset, eiw, eig);
> > +	if (dpa_offset == ULLONG_MAX)
> 
> How do we get ULLONG_MAX?  Not obvious that cxl_calculate_dpa_offset()
> can generate that.

No, that shouldn't be a check here. Thanks for the catch.

> 
> > +		return -ENXIO;
> 
> 
> 
