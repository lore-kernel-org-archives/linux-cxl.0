Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92DBA3D
	for <linux-cxl@vger.kernel.org>; Mon, 19 May 2025 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747695389; cv=fail; b=CENYFTSO9dqCLsAgQfNjWPJPJbFfj5jU+K5kbaUywocboZba3dC5APu0Nr8g0G8eS6RnU+5dQIda+Y2IONsCga+QwEybw8YQxsjcgFESBJMZ3gzCl9LVDvzedKFKVPTzTbjUaNSDBrYjguuYrGtPEIcY2uEj/WfhmYV6rGvGlIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747695389; c=relaxed/simple;
	bh=WWYzrhriWMkmTPq9FudRdqNbyS58NxZ5pNGMUtcmj18=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GHtQ19lOgJTeE5ZFbiYF//B+Ohh0ygD0sl6O0n/LmbTMv3Oc7GeMHVUtHk2YHpKO4cM8owhHthXX+a4I8m2uOFmBUe5e8GXVIGE1ycjZo7viPViEbE0okLcIHPC6Varm7xbaCOYcnvX3N+Ep8GfD0QSKP0h0djW+a5aaw9iboGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHqUaBkS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHqUaBkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747695387; x=1779231387;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WWYzrhriWMkmTPq9FudRdqNbyS58NxZ5pNGMUtcmj18=;
  b=oHqUaBkSYnS30JuzCF0ZHLeVxlsUhwypNJfoJMso7fq1rSZ2U01XBBq3
   rdZRDknQhN6Uu2zamqFPUhyFfA8i5p9HHLcjeHDdIfJsxnFP6FrVZr1rM
   lJSGvb/VyI/EfrWqkMKtehJm8YKJLcHhrlNcb6fTQTs0uiFOm/jXPlMVE
   wXN5GYEoE3K0bLNLTx2JPIokJNNjUK7TotK8JaIXKiiQK8so7y1agcIM+
   +hQCzW/bD+uhfE+MuPgD92JQvuXvFF5NQPO66USvjpQkAr0epgEy2w8+R
   CZ1cruTez8zeLpqKWDT1HafXWHa3+LDBm3tgvFqOtEiaS0bo2gXiiHsoM
   A==;
X-CSE-ConnectionGUID: fo737nLqQSWO6yu/ufHmMw==
X-CSE-MsgGUID: MnYfhZ74SxisZgcBLPlbEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49309903"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49309903"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 15:56:27 -0700
X-CSE-ConnectionGUID: vKWevmXkRxqB7GcLRStvHg==
X-CSE-MsgGUID: xqmt/XGsSjGjTv5WFxoOrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="170534573"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 15:56:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 15:56:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 15:56:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 15:56:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1vdpkOE31+747ZZ/PmGz2xzZxhbon4CjUhuLOH81GJYngFWbC8XReXfJS/6HiVXpwnZkHJuCb0cmLbnlinYZYM3iOSoX6ReOUSq6jB0qyvw2vRx6oz8kE/RQCZzsQP+Rkx9w9fuJnZ4L9IUsWnk0Dq7Al7bZCpfxJNU/GpO9soVyWlv1biitR2kHOJ025zIkHbPAWp8oYRCQ0nlTV72u5qz0cN5IFbTYclKaD0zgEl0jV+HtIeO85eBLivNX/JEpv3SNqB4CuxnmTdP5U+dz//28xFt8NnFPQyYHnmkHG0iWtasMnzQXCWzPiPINl8i+IQq77mVzqzVUzoroRk51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g83bsohD5mw2rgP4uk+FKXZTDUcFg6wzzqyMxLhntwo=;
 b=yJHKTtBAkY147yZmX/B9sMwnLrpf+zLJ7ZPmGfb/VRlqnirRAhXHJQvy82tg7zQblSSA9YJNEDeWDg+7HJoQJfurul9BmoIGjPnMin2MMqN9YSGQqb5Dui01Zud6JY2mWEebGdrNz78PQBEZZ8Cm8DnrFX8AFjjlZrv6o6a9ne0+VwLCcxH9k99SeS13uBfasCFGN7Vep0dpcy7159JdMFsRhfCAY/MdtjJy6TObXY57gBOHsERK+Q6EDKmOhVetrPCHirVjp2zt2jjMkxbTr3HB19i9jpoSJZLkbY2E8IpO97fgS2ZRs0O5u3ShSOlu4N1uWf491qWnp9M0lhTVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6260.namprd11.prod.outlook.com (2603:10b6:930:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 22:56:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 22:56:23 +0000
Date: Mon, 19 May 2025 15:56:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yiannis Nikolakopoulos <yi.nikolakop@gmail.com>,
	<linux-cxl@vger.kernel.org>
CC: <yiannis@zptcorp.com>, <dan.j.williams@intel.com>
Subject: Re: dax behavior on CXL 1.1 hosts
Message-ID: <682bb71427ee2_1626e100f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <CA+CExOgLYnVYdhHADBp4EEmDgfvhv81R1RW1iHGJZxd+V_1wSw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+CExOgLYnVYdhHADBp4EEmDgfvhv81R1RW1iHGJZxd+V_1wSw@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:a03:167::46) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc42a6e-3de0-4d19-84ef-08dd972860a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6bcnldmUVVX0Pt1hLzsFmDEb/aW14nER/TB9O8dkeo7iAJpL76x55ijGuNjO?=
 =?us-ascii?Q?lSofQgAE2d+RQLHtUVszubFdsTWXenNqVFVLjVitI7po3NTh/1hCZDx9Jo53?=
 =?us-ascii?Q?CCg/QIh6L1hLDZKHlS2pYHC8XYqbwv5kf+stJghrpI0SMHl0C09DW7PpWN5Y?=
 =?us-ascii?Q?zzw4Aix2hWulap7UDyyoLJySVcv0NHdiivtAgfBx0fWJlTC5nUO4ioCztnVv?=
 =?us-ascii?Q?Cpsr0hPamWOiheMshtIwUl+6mfgDiXr4ct92gv/JlwFGmpVmIuk6z1HS7EQK?=
 =?us-ascii?Q?hSgvv9WJZQd91Xkk7OBg03cUUwr7VFxFlnuBgNe/0eySoNmCmF+d3irJeNGM?=
 =?us-ascii?Q?ry235u6QRosLM/0xHKyNAgNAtUSmKz/Us3Gn3/TzmFzsWJKE8TJHTEM8WjQb?=
 =?us-ascii?Q?pybN49AZN3a775ffoDa/Md9iL9G+lnGKfVyC24vJpYh/UGYbdpeiyAqoESYf?=
 =?us-ascii?Q?ewHimlKqVCOhhtoyZ955+dJpm7WZ3Nf89E5JeHgds5wbOCk8gKhHns8Cox/9?=
 =?us-ascii?Q?I/T5UsCzKfp6j6kDP9SyZ4yQU50mJ2/FKenGVfZrmzQqnqRK6ETPYAzjy6Sg?=
 =?us-ascii?Q?h4bM+thcQEkU16iG6fux6joCaX1kfT3yjNZHqkRfixNpraYO9YulyBfuytam?=
 =?us-ascii?Q?tnw/SrheMNnHqDhfkTXuF7j9gAJyNh+1zP5hi4KjB1423au/eDzPKm0kGCp6?=
 =?us-ascii?Q?jiD6JO/t0M72+tpvbw8EOnijbYEx+lrZ1cltHIWUDMPK6A5I9sk77XuU8JNt?=
 =?us-ascii?Q?erAFzvUcq7fughTAbpO/TiWLNdne8YSoiHm9vmXSFNKe8qKW6Fyn+I/TkWTu?=
 =?us-ascii?Q?ByqbZRTtaRMFq1ztY0tJi2u34KSSHsPOtvEYmWic67nSGQ/Ts1Z8g+rzrBgd?=
 =?us-ascii?Q?gp4clC7iNiv8gPLxbWNlvi8iMYgLom17nAingfTZaJtSGKhBo+GnHwqJEYwN?=
 =?us-ascii?Q?J45xR4B2P95aJAijVAxe+LkW/eyUYDFdPfsyg4lzcE+AVd+xchSAg1XpOp8O?=
 =?us-ascii?Q?s95cacLyb16PwQm3cffjA766RwkWNpfK8eYaWOTqEY7dzpgPD6OTWj4tCvBT?=
 =?us-ascii?Q?zEYDnwacDt5QRa5MTGg3hQxCY5zJJTfc1YPlOp04rjKkGIQPZVTFt6uDdWuD?=
 =?us-ascii?Q?RGNNgiY7czZ9GMZUEiHpndbVsX2/zhv0AJ4rHM7ZaQWw39d++TxZzmX609xn?=
 =?us-ascii?Q?QeAdgiqNNz3iEUb4Ed9Ji4q/MxjnS0dy9RQKvQ6UMCQdlYhJljcvzmQ/ktXW?=
 =?us-ascii?Q?UA/OSDRFDxWoY8Oayjf9BTixV3x3q+u1SMOdOXrInw1SkCempYdf3SoVxDjm?=
 =?us-ascii?Q?hisvJTwpByTGi+gU86DnDKIhOfzyQHM1hnOt9KyP0RmN170bFqB9U14TT8zQ?=
 =?us-ascii?Q?qgzoZn+G5RXBWsw6Oq89q1I0+wZM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nl1soh3K1rxbs9dEL7ZSoHUbXXPvPUDIZXoVdnqcwJCqsVKCjXGFdqLxIAty?=
 =?us-ascii?Q?kTFscdUtzRJ76g05+Zj94j38XcifdmSPrrB/MSMByDb4NbbQnkwlNMeNKpTv?=
 =?us-ascii?Q?dDfb+gAJaqeJQogM57a4MrajIBjeuDrkJ0C06Slt015bY7nCdBbJdPXPpWQC?=
 =?us-ascii?Q?Zpik6IgAws3qtnQGILOk9qbSsECbPiPkBHZe7pWANnVlUth5jZAoccgD2ZlM?=
 =?us-ascii?Q?o+j+AllGWrm09nSFPHt0jfVLXdV+rig0LW+5PEdvHtk8QuwXHSc4VNFNRuCc?=
 =?us-ascii?Q?bfmWZtkS+Fyop+xS4kbrtDw8xUblsgkhZcFoVWAUsNMI39wr16R9NGZw+mCu?=
 =?us-ascii?Q?9BNXijDb+64wzTCLA2Px60VNWaGC5GMUpm9CqTyC11Ngw8KrLETlTXCrNyy0?=
 =?us-ascii?Q?BJ8izEKoDZ9IYjNyy4u9H+hG4BhYeT1K75aqqqM7SHVnvwJABET9mrk+eT78?=
 =?us-ascii?Q?+XGmrB572kvTG9eWpodDv1v2lLLySMYtepLPmEveY/J1GZP5n1pf4Q0b0pXL?=
 =?us-ascii?Q?rQTZ/5Jz6gZJbTLYjP7BrZlrQFifYpRa+QK3PflhTwsEosTzrvsnjt+vfg6B?=
 =?us-ascii?Q?vqbVoX9n2vrdoFOEURI0a9qymF7BNV6WzQDX5sxTyVYtQXreWx53TDsdRuKh?=
 =?us-ascii?Q?cIHAZV8YlIKLdCTsT/ctq55AGJLocLYV9UlChriRwIPIRV590c9YOeFLCjo+?=
 =?us-ascii?Q?D+Nj5MS1yj7LchwlYntaR64J22VTgyxWc7bC0ui2BhNXxdCtuSVv/3+UNp6P?=
 =?us-ascii?Q?DLPDqfII68XYES0TLmtcNm4UrTYgHgZSTExoT53v5po0eeeCuUBeX0Q8zU1b?=
 =?us-ascii?Q?+ytK7DP/icRxgLkBYMUGsgV5JiQ76kzuKQJFB7HYzC78i4Aw5tMEtePbCqEn?=
 =?us-ascii?Q?/hkOF0qa+U2w+O0aehNCVCiiA8Arn/5e16/jejtk+cVyHkLEgCm7bNVI0fN5?=
 =?us-ascii?Q?p6uA9qigMkBbybGsk7a4q3dPOHtAnhoGFFMz7z/WFrhmAMRobstqAqrgxVYL?=
 =?us-ascii?Q?XVXXy/sfG3Mht6XDikFUl2emhdMHld3QYBg+TtQ28VQvGX8m0kePLUEVJxfx?=
 =?us-ascii?Q?eqe7fPOU1PV2TUFsJpZY3zfJbldXlsG/As40mzgAjQacFIGyUEZnZblDmVW4?=
 =?us-ascii?Q?nledEryD9TvIk0J3vo6eGXp6KkBv12gMOqmEy/KkJKH/VLO8h7KqYRZXOeM9?=
 =?us-ascii?Q?HIT8Y0vnKDQi5qQ5eETub67bJSihkaiPqM/B4tqedv0yttHRhuNAdg1qTv6j?=
 =?us-ascii?Q?Og5fuPuK3rYqYomswVO9NDq+nDEqVtDu+Bs5A6nRTD3DR+QBvlLWs+lHdftq?=
 =?us-ascii?Q?9wZn1JOL864IyTmeCXY+/uvucvl0YUAJNiV6bNpNgnPh/YIosMt3iptRCp+8?=
 =?us-ascii?Q?cg7KxqVwLdAuUWLKrreo1zY93AAEKMXa+J4TFe9GqGyOIdCmEXR23IFx9ngl?=
 =?us-ascii?Q?PvBduWLFfT1b0hEkTeVE+y7YMDhLtFzjV1SedIPTZpjiMa2nk0aCetndzHhb?=
 =?us-ascii?Q?XEzeF1I7POo8WFG48LzQfrU6FZc6fasiYqGhGFM+PNlXRiSLTGyDj4RDGL+1?=
 =?us-ascii?Q?hj/koNPvXoH0Spo2IQuxeqpORrWYxXOmMvvjAHFIaqopiL+xRfhzTkw088cf?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc42a6e-3de0-4d19-84ef-08dd972860a9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 22:56:23.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaxD3CdKZnoMyDD9H/sR/Sol30TV9ZWPc5RzFEhETBGHQpzmDkpklVYSqHZZq19YNEnD/z1YTHBEI94OcV9OHvWLUDbmIEp5eTC+R7pD9Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6260
X-OriginatorOrg: intel.com

Yiannis Nikolakopoulos wrote:
> Hi,
> 
> I am trying to understand the dax behavior on CXL 1.1 hosts running
> recent kernels and what is that I have probably misconfigured.
> To my understanding this series [1] introduced some different
> behavior, and I am trying to figure out what I am getting wrong here
> (but of course I might as well be looking in a completely wrong
> place).
[..]
> When running with Kernel 6.2.16 (or older) the dax device appears as
> expected, and I can either map it or configure it as system ram. No
> issues there.
[..]
> What is it that I am missing here?

Starting around v6.3 the CXL subsystem started attempting to takeover
dax device registration.

    09d09e04d2fc cxl/dax: Create dax devices for CXL RAM regions

I.e. instead of simply relying on memory-map information, "dax_hmem",
let the CXL subsystem assemble a cxl_region which outputs a dax-device
on the backend.

The rationale for this is that a CXL Region enables RAS flows that raw
memory map enumeration does not.

The problem though is what happens when the CXL subsytem fails to parse
the configuration. In that case you end up with neither a CXL Region, or
the the original "raw" dax_hmem device.

There has been a slow drip of fixes to get the CXL subsystem to
understand all the various platform quirks contributing to CXL Region
assembly failure. There is also efforts like this [1] in flight to
attempt to recover dax operation after a Region assembly failure.

Until then, the workaround is to disable the cxl_acpi driver from
loading. When cxl_acpi is disabled, dax_hmem proceeds to produce a raw
dax device. That configuration forfeits all the RAS support, but that is
to be expected when the CXL subsystem needs help to parse the system
topology.

[1]: http://lore.kernel.org/20250403183315.286710-1-terry.bowman@amd.com
