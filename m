Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B714A4E1
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737672560; cv=fail; b=pX3E2L/8Vng9FWIftqQYJWdjx5GmaZTAJd8q6tR2XPtK5swDmmCqHq13NApkenz6s/w2ndQYD4czdACPMsm6JLzKE/+gKsOreQ1293FCL/2gvpgfJ3/W8f8aGJZN0XWQ/Fk/l7W1lddqDjxDMwAsGkHqJyFFSpvee40onxq9/I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737672560; c=relaxed/simple;
	bh=5Axw4/QirCE0+2kAdt/rOtp3K4ScYFde9/nq6+tFGj8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d4jRMK/Lan9xjLxV8e+q0gXaLia5GWcFb1K7kTsMKDxVEBTutpk+Q3/uQ/BTrV94TcEie6vbtgSQavhZVn9UzDGEPHgsm7LsVxWaGpgnA/SrPR6pZ1kCImraKP4j33awe2S+D5tgFHNdfrztyNGjgadu13hpmU4HHmBlLrg4GRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUWy6Chy; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUWy6Chy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737672559; x=1769208559;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5Axw4/QirCE0+2kAdt/rOtp3K4ScYFde9/nq6+tFGj8=;
  b=bUWy6ChyRmFSwq13PGubOxdllQMTa7mBThL5fDzLIe1rKx1j7U49Mg7V
   5tFGeeGB2LYsn4YUPxSozwgeAfxFTMtmZRQFDznOU7dZC6xEFbHU2LG94
   3Vm+/mD5DrdM9qQymWi62qVhKaJAHWIOSpRwCSADPO3N59YtjBFHYXBG8
   8tsOgsLldgeS00TqI/e3aCSYJ3ODtWXWuf4r64S/VtR3ky0Ai+soeTOc3
   t7DcpXbuOWamfmUdF5qtglFJxpxgOxtp6J8gEfrM+MgTeIQc0RYaEKFjl
   jV31KtIxjMTkP23YnfeBoyz26jN1YsjzLCGjyrdNHpem8UXRDhuKw1y5k
   w==;
X-CSE-ConnectionGUID: J8UZEBPBTeuXMsJ1gXxBTQ==
X-CSE-MsgGUID: buXpwQ2mQbyjdEzM0MerZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38301275"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38301275"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 14:49:18 -0800
X-CSE-ConnectionGUID: QSM/A+xoQim6BfxJMpyxZQ==
X-CSE-MsgGUID: up3y0280SsShDZlpElJ1jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="108197808"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 14:49:17 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 14:49:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 14:49:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 14:49:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdACjmEZYT+P6m3A2IQyr7621yyAibYCakFKN+fG90u09dgW0ZruIVf8GowMXz1/116rf7OT0DM8sDkygj7HzDoOHlTyY9M5TeL+pieQoq1Qmam0hlTBieGre/npoDZFhcjH6czqXCzam1Myxoen628N+0PzZGUDZNQNrziVTPhgtFon9ZLtIUFP/xkTHR80H12cPpqIverV1ULDxFnT0DUuMbcyYe8NSMiQZVmuzh0sD6ki2GOAoKCxPYXgcjlW5/KYUpLVGQ77B7A30/+NeEIte7skf4LBBNWVArF9eu+rwz0eWSUq/rA/RNCb/vZyfHUcz+1DqmG6Lb3G7OaSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDrHO0ok+uwNHNtoQl6a/HeRzqdXLgc9OmXOvutCZtg=;
 b=CRD4B3hxDUGNTnQrZO38NOxmMu1X8vcK/7C7i9lSiC3HX9IWOB4ETIDkbRjG2MK4R+KqJV7egLDNofBTpXDh9aCgjqqMEuzlWcrlheawFjJQR8Yx780xOH55qdx0thEEQsTsuabG8KK9m3ELNPFEp1Fb3bVdrc/QjGerR6LozCtTd4eS03/7pxEv9Ju/ENDBRiRWqNMahwjm1Wr2597Zuy98jSaKbXR2ym3TIH1+oDXTTUdAM7NeAtujv11+FM8mhsEVfNIkVEuIAONE4adazY2BzHOpFnYjwasl0KJLecrBLk1pp18TBoaigROIdcG7sefZuQsTuFAzRjksGT4Vjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5922.namprd11.prod.outlook.com (2603:10b6:806:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 22:48:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 22:48:27 +0000
Date: Thu, 23 Jan 2025 14:48:25 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <6792c739cc4b_20fa294f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
 <0020a489-5002-33a9-fc5c-58e46f581199@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0020a489-5002-33a9-fc5c-58e46f581199@amd.com>
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 157bd014-48ac-4925-d2f9-08dd3c000d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Le5j1eoW5qlf0YAmxBB+Vsd20ZLroTxvuv9BxgBqMI+eneAUCyblaDm0mOTT?=
 =?us-ascii?Q?KLNJ0Mg/oHrel1N6cPbGTZVvzFRtIlEMelW5BKS4iK15qysXfuH1eymEkTVo?=
 =?us-ascii?Q?EXXs1L5HVJVfSalIovXrUk06/3+d/B3ZYNlx43mpYfROk5WD34KpAsFwme8E?=
 =?us-ascii?Q?1zz+99fkZ/pdHntsIf+vXpCTeRgvcP+k2JCCr5M/Sd2XfABs99XUaIwEztXW?=
 =?us-ascii?Q?nKz/dkqgkWdg/4Bg+kloLm5khyvuMH7PGBYUyxz9IBpQ0psOqUhq3pYBZ2MV?=
 =?us-ascii?Q?XuOIpdfz3Gdj/SddwBPjj3eamjLOrvTBk7MtgZ5BGjaz5UvBGfEgtL/mLQ/D?=
 =?us-ascii?Q?rEI5A6fqPbaZ7yRPvmK4xH4BeGiZf12rkMFHCnAbxZNgBhkCLjXYHVxt/Tsi?=
 =?us-ascii?Q?yoM0orSgKY6JwDaEVb+Eia8h/LCV1f/xmPnPTOVy60i3NwH8zNG21mLvIsC2?=
 =?us-ascii?Q?3pyaG8moWVo1TE+/TjVKOTKBzQ5vsWGwxN3zL6vCZ9KSNFgZbj3pgmZkhvqf?=
 =?us-ascii?Q?Hb6s+zU014o1s/mpIBkYUGnqUQj/V4KM+11cK+uENmcgwUvIdWFuyamqssqM?=
 =?us-ascii?Q?maRenad6wlCaTb/btKOCVjGqkEV/9QyJl9L1tuwCPs0eUbo2h3rbP87sMoKv?=
 =?us-ascii?Q?ixN9KlTKIh8+ebxGwVvhvgcfxWPS/zR/Y+ElCrbFaICE1LUplPYbISFkPkjF?=
 =?us-ascii?Q?eNQJObQe8HEaTTUXqL5YWOvr06Sb0OWs7KozYelEiBnhvnNCpKT33iqPpSZ1?=
 =?us-ascii?Q?sT6EVitmkeR1kkUxzLcP0zxIIvTbAzzfDXjP3U0mw5FXlSdiAZhRjm2lsmb5?=
 =?us-ascii?Q?24Qu+YPR+XpC4QdlL0L3Q+Ys2R+b6iqZ3kYwL8nxHFvzP2pwzXKrtSKoaxPg?=
 =?us-ascii?Q?d2oE5t222M58+g9F+Yiu154jDyCEM7Cy7xbpzYyS6Oh+Fph0/qz85nG73Hyy?=
 =?us-ascii?Q?t7J105sLNXDXwT1QNwY3m56KeTr4TWoPkRznAQl68kLUrGEaLe/3FRNGRyCn?=
 =?us-ascii?Q?WINix4GWslOsj5zORJEhwk80QKaKLNl1PxJK3Kow3DkaqxAnkm9Hr3WoG957?=
 =?us-ascii?Q?Z/81cvN+LzOdHfbbTOZDAHS5SxG+j4FRSfMe4aWWjRHfhD1LSfN/VJDI7GGH?=
 =?us-ascii?Q?oLmeI1ggD+r9MAMTnB40h5p4jxM3h1jNHiYhUw78yGahbbZhbZxkk4v6jPsY?=
 =?us-ascii?Q?F8ptC/x+IApsryr4JcJd3nMnl3Dh9qdtQZa6ipy3cnRJp93izLvR+FtBjItc?=
 =?us-ascii?Q?bpO+9bnD56rKx2Mp5F/Mv7kDWQpeB9tpPYltMJOtbgk7VnJI1avDIvUy40mV?=
 =?us-ascii?Q?Bfjdbd1OwY8qlIgEYFwk1wPNureaQTrvDq5zmnPztJVabBCrpjU2qF2Hc+1K?=
 =?us-ascii?Q?1EN4zsKHyj0g+SouBd8wiVIFTYLK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0p3c6YHp4N/7QMtnjME0ZpNGKS3LC9+pC5xvusOHu9bDkXiyuc/Xj0Dk5/N?=
 =?us-ascii?Q?GXZmVyI4CVGU7+PZSIFrGk8P8QtMktsDLoHw1eprjfCevOFE7Ta2/eKpwCJc?=
 =?us-ascii?Q?Gni9XYtkPampK+Aa7vR9WwGVsFgEXN3D5qUrFBWOC1qwHcguJP9uqJ5Z2C89?=
 =?us-ascii?Q?SUTVRq4sot0CEnM6CJydqCAI+uVOrvQw8rOu3uq6yVZjIGiDw+YjEpAiqN4E?=
 =?us-ascii?Q?qCwifJe0VuWMGqbt97/2FR39Vi1l1no+l2jyP5WqWYJWVsRPoMPL7OCZ6ka1?=
 =?us-ascii?Q?G4UxJTXQuU4vUs5m7nU5EzAeFmokqYfZh+F7JShJTiBjfw5QUtoYxcil4Hak?=
 =?us-ascii?Q?mVxYgHhpk+E7CuWr2IYjDeglGWO08yawBJWR5YjQOOkyR4YvCLpMy6EiMg8A?=
 =?us-ascii?Q?q3q90lU6zZYpHlht3kn6bX7mh8Yj+zmjsoocF/QthHnysd7Rqvq8kEFUoLpl?=
 =?us-ascii?Q?RfjtAGBlqpQN5QCgREsOL5zZLe0KHibDdtoDqqXXjv6Kcf6eE48SBXPFwD7i?=
 =?us-ascii?Q?GmO3ta1CKxrgmYdSqwwheNBxLgkWkue3iTE2nq0ST0sXoYAT49MPM+K/JSlo?=
 =?us-ascii?Q?jheO32itzSlritHchcJRI1Yo33ykLRWyfPzObQvQfcNiZk8sx8ya50uDjV71?=
 =?us-ascii?Q?cIcqVpD9ccZaimsXgJnJg9VCD+OJ7ZFOCtM6RScmjWZ13EkLd1Blbs0IK9y5?=
 =?us-ascii?Q?VHxDdOObHVw5h+c1gbchqxKDhcVqNW940/5FSvwPuW8OP0Ure2QvzoTmlTp+?=
 =?us-ascii?Q?GuKXJpnreqhpqLp8ETFtmMtO6Xa+ryAQolbP6YO1L159vCzkiJtt4KAycPkg?=
 =?us-ascii?Q?VdD5c90LqobHPbGjgzFvN8KxsjFciEzgC5k0fqgYREuvKH3wxTAv3+K4lCPI?=
 =?us-ascii?Q?KtAcwl/1kHUbuZdz5KbtcdIj9AgmWbEtFR5GT70JyclgT5BuhjxumLk7gzZk?=
 =?us-ascii?Q?NGqPU+LaMETNL5ktsO7nqm0yAlAn2L4dGf+pUChVylWmlSRixXWcvoB1SpoN?=
 =?us-ascii?Q?SYTjE6RauWv2vT+F3VZ6xs6Id9pKOdGydHkuxMAjULkuvv2mbIP8LC6Dv96L?=
 =?us-ascii?Q?24P8Nt5ab/pd4M0ZsXaMl229m2hPx178sYem5iiuwNIaD8QYNrZXdh5nsRuo?=
 =?us-ascii?Q?mH8RoyaPAIfUi5Oc7V8aw3oKZ3dL3puIqgsv4M96LX6Ic0N/0hQnbt9sXhld?=
 =?us-ascii?Q?YbXPwf24VbDv5LJPflF1sFSurT/dEIxoBP9cXnJkGQFRlfSVzTdfewYoFceL?=
 =?us-ascii?Q?cdpxbkJdb4xvf8/UwvQg+tPVQRFpjYUhlwP2AnNwYHySJSlAPDZcedUfdB6n?=
 =?us-ascii?Q?XXNOdYv/qynM+MNcMoIbHwx9SLEjbgNdALcTaIjrnXjUG7sY8JydRCUiR001?=
 =?us-ascii?Q?zK0aoGrDypWi52CXaUnmW/CEXUpcgjY3RPaq3XLLim9ypJwDwzNV50uieTiR?=
 =?us-ascii?Q?VRwqQ2TBlh0tcbsNqiRFEznja/O66jviRDrVBuVdQfzlIi2oH/b9wehQ0QZ9?=
 =?us-ascii?Q?H0MNXNzfg0cX2fOSK0T3X3+swZgpOCR7wGPd2Wr50lsaV/WoYCxMNA9TIlL4?=
 =?us-ascii?Q?dLBg93chp+9vKxErxJ8JIJIT7sZ8QRVW9LKfL3IIkFfrAfkzKUa34ojXXjhK?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 157bd014-48ac-4925-d2f9-08dd3c000d12
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:48:27.4764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIJ4wI+xdtayq7XSeTeDuhsQPoY4bg1gZsDib9n/6h9DQw0nBKoFdg3Fp9u0EdhGgNW4FSg2MCWDkaLE1vdzKCUko40iHRcuxOri5IP5lJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5922
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/22/25 08:59, Dan Williams wrote:
> > The pending efforts to add CXL Accelerator (type-2) device [1], and
> > Dynamic Capacity (DCD) support [2], tripped on the
> > no-longer-fit-for-purpose design in the CXL subsystem for tracking
> > device-physical-address (DPA) metadata. Trip hazards include:
> >
> > - CXL Memory Devices need to consider a PMEM partition, but Accelerator
> >    devices with CXL.mem likely do not in the common case.
> >
> > - CXL Memory Devices enumerate DPA through Memory Device mailbox
> >    commands like Partition Info, Accelerators devices do not.
> 
> 
> Forgot to mention this one. Mailbox is optional for accelerators.
> 
> 
> So maybe "but this way is optional for accelerators, implying 
> accel-driver defined/hardcoded enumeration".

That's what "Accelerators do not" means. I.e. that setting up the DPA
layout needs to be refactored into infrastructure that can be shared
with drivers that will not use a mailbox for this purpose.

[..scrolls to end to see if any additional comments..]
