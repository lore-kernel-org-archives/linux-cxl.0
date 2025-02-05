Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAE376;
	Wed,  5 Feb 2025 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714570; cv=fail; b=qsApT9ihkOyll8nzlleepqH53mAaDoDQ1DTa17vGiKo76oE/3XXXoTrCrR0DK2qu4byyl3/ckELMY3i8kUh5ArvjraPdkLdkf+xqm1d621Ha4GZO3YUFrwPq2Vit237xY2VEsNKCU/Kc1j3qHr1mL4m1a/3Ua6V5c2xQ55kazAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714570; c=relaxed/simple;
	bh=oR60pMlPFN4yrvAuItz8CsWuBp80LzMSHx531JHB5ss=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uxmC7w/memj0NGua8ag1iB8CVtfCEqRlgMoyf5mPXWZdy+MxCZllq+O4xxGKO7PVZ5P6Jk8xskdJZUIxQcwpC/f9TsIUZSPyKVo+mXdXGjpHlMDfxyPUNj7dLODXCm3pxhHxiudTKROi1tV0gd6jtf0GQxh4pCZKAznkQ7Wu+Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJE86vfD; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJE86vfD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738714568; x=1770250568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oR60pMlPFN4yrvAuItz8CsWuBp80LzMSHx531JHB5ss=;
  b=CJE86vfDaW7inOK9ZITpXW+xea70y2+byl3uMZDWnRTM1TYaQ6x/CcHi
   u2uAKz9c+cOAFQx02e0mt+X0QQ3WQEQYU5C2i708eFAStafE11oQabBIX
   CxlSRtLnhiUgmrQwWGeKUHz3TXK9mFLwa2fBVTTZk6TOwddBOLH+/HOK6
   qTW2FQvWdIywZwgX2/CO0WQIpGbPoPVQHGiBXfdiZyEwlZORy2s09K3LL
   QlNW6Ae/IxbRQHFO0I2bhbpDjk0W7uETzWTkN+jJn9YrP5e/EzQQvYpeV
   INuDLa4oBbgs83/W0OMi4iyJwFFRBOwcRnmvcMQrXHjCLPznrnE+ZnjPg
   w==;
X-CSE-ConnectionGUID: UyLP3gDYS9mcqoVZ3mWPrA==
X-CSE-MsgGUID: A10q8sNLR0Gw+oMY+1oKRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50686250"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50686250"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:16:04 -0800
X-CSE-ConnectionGUID: 5j5fXlLGTrGqCYVVMJddNw==
X-CSE-MsgGUID: HPq5HxIqQASvxarX8cvc9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="115725206"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 16:16:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 16:16:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 16:16:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 16:16:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Li4RgATMeStmZ1O8H2P3r2/E+EzkeFo9+VdQSo4ZGP/YhRT8ivtjpGcnbI0Mq9JwJkdX0yFWYiALuTK8yg52wulALQvvkTdGdzZx06U0BGHTbAT5V6rCpM3wPvC5sIiDu75jodd42HtdKMoP7nRlq5ZcrfucFa93FeiisrQTR9ha7DSZ13z+EOF06mn6dBLNFwFJsy06abZB6KmGJ3F9vmReXDyFqm68WakqX8xWqGskXjiy4elRoeq3iQbB9NcftSG8GEcdhsER1lGbi9F3c7AInV3d7EJuIpOEqkSvoRKY3QZ7yXnic+40+74VtJJd8MeR2gkbaRZFr0mbI/vC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h5G10eFuRbv8aUaMIQEgcKHvpu+Y3C1irw9pLR0UIo=;
 b=TBcT3b3fZEaokrLnApHOb49lYK8whaMgitX3dtv1xy868BgKimjzZXzIo3n2Zt/VTp6Nt1vppMiljW4Gtdkg3GpOa6ppjTnm3+UMpgFt81LGaCDxElodVSLwU6R0+Tnp1ExlwpE+ZgFv1Aw1hiZORAc/Ts4VS2FGdlkB/RfyVkTrSSAy4dFg0W0NYmPxZ/pWd7a7wDXIBwXxS/JmcDCbd3zK0kBxG8+woObDzVHvWyPa91eHlDZ0c4HAqLEn1yyRCp80609yPHwJWV3aZNk7TCDMv/TXIVhkRECoamB5MHyewwJ1AItLT0rw5NCYm+ZqJ11kZ+qt64YWhpu6eiI7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 00:16:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 00:16:00 +0000
Date: Tue, 4 Feb 2025 16:15:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Message-ID: <67a2adbdde7c6_2d2c294b5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
 <67a28921ca0b5_2d2c29434@dwillia2-xfh.jf.intel.com.notmuch>
 <67a2a4d2519_2d383a29411@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67a2a4d2519_2d383a29411@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de0b37f-f8b3-4eb6-c328-08dd457a4518
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MGQyPodTHxWPtoP+x0AcVgzanwA2qnNkKcJR1GKohO+LRAqwX0SRGn+/qwSa?=
 =?us-ascii?Q?A5mN1DtQyyPASWeR5SQPwQSeHBWcJ1S+tRNSwA+tVeidVGYNQA++Vu9Q24HH?=
 =?us-ascii?Q?QpRI0J93ApmsU9ubymUwChHjluoqXdyTCYVnr3puo3jVu8wXmWg4bgvSRsz+?=
 =?us-ascii?Q?OtShoXBIfM4z9YLiLrhXQHQtBVMADPxODQyPrGzctqtTqg32n+TM2MALVwTP?=
 =?us-ascii?Q?IZ/KExFEXbvrJQxP3qjxFQ4hXMtR0Z1/tCySryc49FFpC97jVmfqOuCpY19x?=
 =?us-ascii?Q?sB7/FWmFFIxPMv84Ptzb6KkgJMp/47IFRqPP422kNbErQr0jwslWavTMz8a6?=
 =?us-ascii?Q?jcj1t8VI9EL1Yf/C0P4KrUI3P4rOxjhtaZVGgN+1ROxOvW5czsliaCGTAuiM?=
 =?us-ascii?Q?x/OUJhlU/jWRxcSCK+EaxhuM/VTUu95fplxDkwo7sqyzmaKHmGDLbSZMBw7i?=
 =?us-ascii?Q?abuvmsdTAQNN+zmWrXU8y7Ow/J/mb52rn9on6Yfaru5+iAlignGI9cPLUjN3?=
 =?us-ascii?Q?Xs+9nSXCNhtylfi/JyAq8EiueHEY0YcV1lkKM7zCQuOb5EcH3YbB27qbtIB4?=
 =?us-ascii?Q?e6uWqAPxNmaL1y29Kka5IF0tBybZIJCaXMvJCEuQ3OChAUOjkODapUycpS6f?=
 =?us-ascii?Q?UYcYJKw9T1zz+soAlJAf7mwSWW4y74tV4Y/tqCp5RlqNrfpjb3Wd1RI0S3DW?=
 =?us-ascii?Q?zVGJq4p0yOB2B/xrAHBuDbQZzaFKqGk4zzWa0kWzy+QoDDCl0IKn8RF8gXtL?=
 =?us-ascii?Q?axMnFjc9idHhPU5Zv0QYKo1u/+vMkwkQCr3t3K6UfcKwQIyByQtLuu6BhK3h?=
 =?us-ascii?Q?AsiIM9L0mtq/qqV0FBiwRA7mfvtz5K/UZjSe68ikzYm5pFXSj2caRU1zp8Qv?=
 =?us-ascii?Q?p89gJuF9vMSsNtVFGf2Gfi6AiQXd3OuqvgG7YTS/Y9FQviwx3/CTIuw09coI?=
 =?us-ascii?Q?HrpWmV+xj35cTr84Kz7OqnLqxiGijcQpasrPlNop7EVn3QyvnUahYVhyeVwc?=
 =?us-ascii?Q?cvnyRsp9AeLNpq5Y7yeRGts4fa9qm5ggxNORC45sxsQ/GhuAtvBvxrNl5Kp9?=
 =?us-ascii?Q?ohOSb24E1yyUdGXWaxKj6Q4C+qcKydv6EvnxQWRrT4vFtxgLWesmOJxpDcqa?=
 =?us-ascii?Q?afw+QtXmbHI4Tz4zg9uwlpYddRKdZeg9AhLgb45+q5YMCh5c7IPnBvgUOrJl?=
 =?us-ascii?Q?5Jbg08lABf9wYH9jPLeoJoP9AzZzvez6hc2AENJ5gamymqZ7QOqpdDIqlWWw?=
 =?us-ascii?Q?Z8xZm0fS3KjjygtTbe03S/ZJrbYPMhkVNZY+qBuC3gE7eT5+LsU8esKLx2OO?=
 =?us-ascii?Q?Em8eO8HU/ChL2W56CWV7vnleN3BEvLv/Qvw3mjMHKA5ZwKNniw2HdPusS2a6?=
 =?us-ascii?Q?V6LxF2tQR+A+5dK9GGaaTLH0hdVj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ViRBiO6/Hms23d2MpjSK4ruSnYBVPpiIW3Zn50XWaFqRy5f1JfnGIkZynSDt?=
 =?us-ascii?Q?Rm4iSKuafKk4R4P3hQwM+62cSdUSev/CJhLPMer+502gLqwZ2uTWalwN9j7+?=
 =?us-ascii?Q?h96yqMlmyne6HnbfDwdhEpFBBvXijF7+WfrFqKz+NjPreMOn6DEiOLhYDeLE?=
 =?us-ascii?Q?OZEsDcLBc3uWgYHUt82SN8KUy+sw4Gn3uh1gS4CZP14XgExKOFUBJITGwfoC?=
 =?us-ascii?Q?okIgWJ2A8GdxXJBZUeeqgsWeBCxxhiMjyeJ8sbszTOvaKI1wnNUJrpgFq2QY?=
 =?us-ascii?Q?/Q6i0VHFOwTYmjWDddAZpRIx7UrPb4oTTWtpDUXU+vhcNroVPEVokIGH6Txr?=
 =?us-ascii?Q?RRMDYaa5gr6vvQVmX50rAkWnyanRpnqZl+EFS6Ogkl8re8rzRlAkZ7eAXR3v?=
 =?us-ascii?Q?DeHSPgOgEPjWN17ReadmNLNpmcc4df79ipHJVZp7ZAOdJnhA31Y9E0a1tdkO?=
 =?us-ascii?Q?qd6g+ibfyBj8UOTminL7XN4c1w4W3FdaMlpnKcvmZMfAK0tkcB+IAHHweFo2?=
 =?us-ascii?Q?zhRqIhaimE9s8Nq06BmaAIOpjp7gzmm8P79tgTHT3IX/Kl4zUvUmkUK0R/WL?=
 =?us-ascii?Q?Mhd8Ou5v9nXCLA0J/iwRWurNYlSE5fR9rS/PvgAbsb3P0nqDn1LcxTOBc0ap?=
 =?us-ascii?Q?PfoXFsvVUe5D4m9tyB9C+jqccb42HRBHvRbl1S46bniXQho/Fl/S9Zqew5CF?=
 =?us-ascii?Q?qW2bW1I0CN+8nGrVkxSPyD6fAJYAzVaH5MjOMWBq6XyHpA48z8CXwGvta2iB?=
 =?us-ascii?Q?rQR98joegbGbsZETJC09zd9/NKHbs3W2vIz4uYLG3gE6WlbTiN4wqip+PAR3?=
 =?us-ascii?Q?ke9AmrnX+AVDN3oDppNusBw5d0R7Zgwq7x0W+H9ENWbp+G7KHBR5YV+qhC3O?=
 =?us-ascii?Q?6arjopeZoSdP73x6zMpEaQvfip2mzStY8H53GEPYMmPcduR4Id1n3EEF5pnQ?=
 =?us-ascii?Q?PxZI771qw9mXX/QimWcqz9Uo6jHncvx1Ce8O54oFB5GKasOAUMvvNXxjDQye?=
 =?us-ascii?Q?fGkdPfmzFwUxFiaupREKblBhHdLmaF4a2VdlrZsf1FT5diGcQHwPcUpIXKsC?=
 =?us-ascii?Q?aZiHELjjknoq/K5IM3jQqFf/zDyKlon3+czgdmWqozQvqz0ilK3CfViS3vhJ?=
 =?us-ascii?Q?S2GnsgQJjXwc7zNjPAY28mfuHwvhnvmqLBvL5bPGFvCpXyzIyQgRKiyyNiBB?=
 =?us-ascii?Q?B/7eIF5FPM3RjeR24P20kDkr3YZ5ShLWqelb2ufrwa5QEmbiQpmykODK3yBp?=
 =?us-ascii?Q?krArbm6AmIZ05xtw8XcxRj4W/BpMW4iGepQkBctx1Lu+JZYsjDjSN3jqS3Z4?=
 =?us-ascii?Q?yPAoJh/ho6f7Xd2KT+KwmOhObo6u/B4OqJBvNztvBmj7Sf4uC9IirKcnMxYn?=
 =?us-ascii?Q?4s1Vi41vRL23UyKdCBiJ9StVhclZccnvT+bYTwFctCdpAZB01wKafY8zEZ+i?=
 =?us-ascii?Q?JPb70+HOmFJ89F+5to1DGfekiUt/M6AUS+zXWI4DzWrroS2QvSCrrTl8YJ6U?=
 =?us-ascii?Q?vAbSVlAeDVhMmSwQjKRDlDazeLttldQGjueRxgVeAwjNDe9Tx4m+xYhNL2Dc?=
 =?us-ascii?Q?wRcGHMySpXj5yxGOWLc3QcyV6A7a6XH1AdvFcv/rBheLgkksLyC8So1/NGwb?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de0b37f-f8b3-4eb6-c328-08dd457a4518
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 00:16:00.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kl7AKR3Pnj4Iqt0/7I8buMHTJ/QUVQGlNZXiBtqe2lxZGYKwh64+3FBFSnc+DlF0uHapbn1SSPP8m4EuK6SN40VrEHJbJOyk+4hVDv3jR+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> 
> Perhaps this would have been good to add to the commit message.
> 
> <quote>
> 
> The net-net of this change is to make partition set up 2 distinct steps.
> 
> 	1) query the device for total, ram, and pmem partition size information
> 	2) create partitions using that information
> 
> While doing so it avoids storing the total, ram, pmem sizes tuple in favor of a
> stack variable cxl_dev_info.
> 
> </quote>
> 
> [snip]
> 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index 998e1df36db673c47c4e87b957df9c29bf3f291a..44618746ad79b0459501bb3001518f6b7d2ceaba 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -1068,6 +1068,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
> > >  /**
> > >   * cxl_mem_get_partition_info - Get partition info
> > >   * @mds: The driver data for the operation
> > > + * @dev_info: Device info results
> > >   *
> > >   * Retrieve the current partition info for the device specified.  The active
> > >   * values are the current capacity in bytes.  If not 0, the 'next' values are
> > > @@ -1075,9 +1076,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
> > >   *
> > >   * Return: 0 if no error: or the result of the mailbox command.
> > >   *
> > > - * See CXL @8.2.9.5.2.1 Get Partition Info
> > > + * See CXL 3.1 @8.2.9.9.2.1 Get Partition Info
> > >   */
> > > -static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
> > > +static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds,
> > > +				      struct cxl_mem_dev_info *dev_info)
> > 
> > I was hoping this would get further away from new in/out arguments and
> > look at centralizing all partition enumeration into one routine.
> 
> I don't understand?  get partition info is only required if the partition align
> bytes is not 0.  IOW if the device allows for partitions to be changed.
> cxl_mem_get_partition_info() is only called IFF that extra query is required.
> So this does centralize byte information queries into one routine.  It leaves
> creating partitions to the device driver which moves us toward these being
> mailbox only calls...

The crux of the concern for me is less about the role of
cxl_mem_get_partition_info() and more about the introduction of a new 'struct
cxl_mem_dev_info' in/out parameter which is similar in function to
'struct cxl_dpa_info'. If you can find a way to avoid another level of
indirection or otherwise consolidate all these steps into a straight
line routine that does "all the DPA enumeration" things.

> What I did fail to do is change mds to a mailbox.  So add this hunk to this
> call with the corresponding change in the caller.

That's a whole separate conversion that can wait for an omnibus cleanup
patch.

> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 44618746ad79..873793dab68e 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1067,7 +1067,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
>  
>  /**
>   * cxl_mem_get_partition_info - Get partition info
> - * @mds: The driver data for the operation
> + * @mbox: Mailbox to query
>   * @dev_info: Device info results
>   *
>   * Retrieve the current partition info for the device specified.  The active
> @@ -1078,10 +1078,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
>   *
>   * See CXL 3.1 @8.2.9.9.2.1 Get Partition Info
>   */
> -static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds,
> +static int cxl_mem_get_partition_info(struct cxl_mailbox *mbox,
>                                       struct cxl_mem_dev_info *dev_info)
>  {
> -       struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>         struct cxl_mbox_get_partition_info pi;
>         struct cxl_mbox_cmd mbox_cmd;
>         int rc;
> @@ -1091,7 +1090,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds,
>                 .size_out = sizeof(pi),
>                 .payload_out = &pi,
>         };
> -       rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +       rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
>         if (rc)
>                 return rc;
>  
> 
> > That
> > was the intent of cxl_mem_dpa_fetch() to capture all generic Memory
> > Expander DPA boundary information.
> 
> The problem with cxl_mem_dpa_fetch() is it mixes in the partition info mailbox
> call after you have already supposedly set up volatile/persistent byte
> settings.
> 
> IOW I don't think it is clean to have the cxl_mem_get_partition_info() call
> hidden away in cxl_mem_dpa_fetch().

If it can save new in/out parameters and hide that thrash from
cxl_pci_probe() outside of "get/set DPA information", then that's the
final organization I would like to see for a cleanup like this.

[..]
> > Why does media_ready affect partition boundary enumeration?
> 
> We want the driver to load without any partitions so that the device can be
> queried.
> 
[..]
> I explored getting rid of media_ready but I think that is a bigger fish to fry
> than I have time for ATM.  And you have ideas there which I need to explore
> more.

It is jarring to see cxl_pci_probe() now handling this detail when
previously cxl_pci_probe() just called a helper that either succeeds or
fails without bothering cxl_pci_probe() with the details.

Push / leave complexity and logic to leaf functions where possible.

> > > +		range_info.size = dev_info.total_bytes;
> > > +		cxl_add_partition(&range_info, 0, dev_info.volatile_bytes,
> > > +				  CXL_PARTMODE_RAM);
> > > +		cxl_add_partition(&range_info, dev_info.volatile_bytes,
> > > +				  dev_info.persistent_bytes, CXL_PARTMODE_PMEM);
> > > +	}
> > 
> > Why remove the cxl_mem_dpa_fetch() helper in favor of open-coding these
> > cxl_add_partition() calls?
> 
> After removing the ugly hidden get partition info call in cxl_mem_dpa_fetch()
> cxl_mem_dpa_fetch boiled down to 2 cxl_add_partition() calls.  That was very
> tiny.
> 
> More importantly this exported a very clean cxl_add_parition() call for any
> driver (ie type 2) to call without creating special structures to pass to the
> cxl core.
> 
> I can put cxl_mem_dpa_fetch() back if you want...  I had changed it to
> cxl_mem_create_partitions() to make it more clear what it was actually doing
> before realizing it was so small it was probably best removed.
> 
> It would be used both here and cxl_test.

The name does not matter to me, although it is unfortunate that this
helper lived for all of 2 commits in the history, it is more about
adding a new potentially redundant in/out object and adding logic to
cxl_pci_probe().
