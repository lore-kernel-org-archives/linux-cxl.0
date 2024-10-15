Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB861CBA18
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007636; cv=fail; b=Cyl0XqySUg0m1se6eVXPC+fHMvP9P8d4uFCgSgaVgNd0Nfz4byAocGtYBbi5w9k/SBsgCc6o1AUrr/PiDA+N25xfxotWHetHMDOay+2EhMYLNB8lPo12M9OPkxNJ70ZIz3JHMIEXvEZBnbsvxY3YNW+yjerAyPZIOmDcl/sGGJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007636; c=relaxed/simple;
	bh=1xaFBGOQifmEPelZgKRjXA0sGPqSyVyg8tHqbfbi6Co=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mdGmp/g/tMUoG7/W5nzHtP+PrMGUJy2p7OopO609+bMWmj0dlSCJZIZowsTd82+ZcISTOk2Z2Ls48teGP/SjxlIpKQ+Q/G7xIRQDo1LdkN04J31RAGum/clyoercskKE/i1zvmtVbIzpqeaNL1hDR0kpwnJbC5e7yzZfkHQSsVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3G5zXgA; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3G5zXgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729007634; x=1760543634;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1xaFBGOQifmEPelZgKRjXA0sGPqSyVyg8tHqbfbi6Co=;
  b=d3G5zXgAQy0zzkdsDcllRIpbAp2S+583AfIbs8h/KZaxOVdxqe2GS2ex
   ZZxJyeHKq39ejkvVzFScANOWqciaItDAUImGCoqsomoMxEHX73xtVNJQh
   VO2Kujox0uH1WvrlBVA47UddpcFBMBg55dA7mxA0OcRNftRXiLJ68nEzU
   fftO81vCIsV5yLPece2WwmRVxLU69BG7SWF0wMAesTkgvAHWJVlbPltZB
   eeIG0rG2CgW9DUd/9BvtBZvHULd+/Xd8D+asDpeZRf1Gy5OtdF50WTtob
   lAdjUzJbLiHADSmv1TUybqFVDFvmPKa/dkMA7dnkcEMCv5689UkDDPbsz
   A==;
X-CSE-ConnectionGUID: 4IUQOHIsTsCtnFmZgrBVYA==
X-CSE-MsgGUID: l7X/DOawThuoFpXZFdTEeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28611099"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="28611099"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 08:53:53 -0700
X-CSE-ConnectionGUID: ej/J6TFzRu2x+nzQN2UaVQ==
X-CSE-MsgGUID: kl1C4r2VRQ2r8AoZjVrgMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="77558695"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 08:53:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 08:53:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 08:53:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 08:53:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GojC2s1bfQsxYdB3LN9cCoTEG3lv9OflrKkZHnG3P4t+RECVfmXxpdmpPGfRT5eatUaNT2Q8b0EdA+IqQL2Q2knSLOuGbgxIR/2QXeV+SemuiPICRd5fNZBT0vGRQILZt7/55pOcpLcqrZTGFpjz935edEiFR7gp00K+M5hge4ebqiOct21ox0muA8z26qN248UQ2QFPvYyeg+aPiWw1dPvM25wFY02rdCVGajK5+9jKEuPEt9ZHsWCYfFjBbP+qMm2DnFs029nYuLAddAuZOLc6XDxRpWNeL8ddlFIJIiLPgPXfBY2piYgiVer26dxip2FBgYQkvgZfvSlVqVHTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvY/4awJC4NdJGGhlaIwgMxPWO21tbU8+nahQT4c0Tg=;
 b=dza2Gqwwex2ng2R1wosMi3FLrvrVCC7sbLxzIs6At16IIUQFYGam19jp/5nmlIJ6zxn0Zigou3+liBIzIQSSnQ58HOFo/Mg3bCXTHqCdLr7gMlvFMYh43kRBj90OBHGwuGiWl3PVX9vWHe/Jxq3/zucLNI+cSFiDQNL+vIYjFMi6802AiPc5/1tL6fkL5zZyfwHlzK2h9RiG7rxqSEcvZxICvybsUSnUJDwmCcik7HW95Raw/Q93dqVOlcZsXwzY1CHL2+4r/jgR2wREbWZ0x1bsWcY9AZSmdoC3TdxICaywQpyvqOtF0N+jZfTSeJ9zj74X2UIHmbLkxZXASTkn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 15:53:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 15:53:41 +0000
Date: Tue, 15 Oct 2024 10:53:37 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, "Huang, Ying"
	<ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: KASAN error when insmod cxl_test
Message-ID: <670e900125a34_156deb29477@iweiny-mobl.notmuch>
References: <87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <04fb47fd-0114-48c7-ab8d-e779924f489b@fujitsu.com>
 <3f7e276b-bd2d-4986-8953-cc80a851304a@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3f7e276b-bd2d-4986-8953-cc80a851304a@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0256.namprd04.prod.outlook.com
 (2603:10b6:303:88::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN0PR11MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: b248ecb8-2120-41de-bedd-08dced318aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AVtr6S+IUMo3oDJHz3M2CoRorqldY9WhbyjLqg52FAujQEngvtKKV0E+6VlT?=
 =?us-ascii?Q?Ggum/pBP4L6eBjRnE5dFeOOPCcXVGtOYClyLjX25icfBTnxRGrlxbMdnp7OF?=
 =?us-ascii?Q?fvGcs090W9kqSHZlZzTYY+/p186gGJ0asjvTaP6R53ZuQGcxxNz4Xrxt4Ux3?=
 =?us-ascii?Q?VYCs0/bovZNuJBTaAMfjbhqEv/1vRyLpuq1fCBAG+r2qIY3b5nXP1qs0VDMk?=
 =?us-ascii?Q?Mmgbqsnq1b5ynpqUpL4EFHjXl9axqU0EcI/r5s95gkXZqr0CxAU8AjaXmzlk?=
 =?us-ascii?Q?dEqKytVUu72avNmDR+zBschz55WYwoWl/Fip1DfevnPFbMl7JAjDs7QPeGA0?=
 =?us-ascii?Q?GRPovJItwjx+M32rnAnnvAVCQp4iHlKb3SpqtaAuDTduRexdYko5e+WhO9yD?=
 =?us-ascii?Q?o7cA7bTZkP/uOkI2Srs83VeLJoEFzJsb1Wrsm4VDB8C7++HDHO6OtB0ub54c?=
 =?us-ascii?Q?Ppt8dLSy6kYIh4cOtD66QH0ALts3C/WaSZkIxhG1GG91X/tQ5jkLGVu44D2F?=
 =?us-ascii?Q?KXM0ysM5SYRkcYvsj1Hdmt6xCZKWhG1afVl7xA1dSLjgHACbBG3vo7g6YNnb?=
 =?us-ascii?Q?1MkbQ+M5zlj1gS4hYE3G7MPTz29aqVU0PxoaDclwYjI7/ftpmrsc2RQfA+zH?=
 =?us-ascii?Q?gtwxJGtcJ0pKMVAYNMW81cwlDOlDrfHvPeUlG9svCGhxzOhI+ezXZDI/i0pN?=
 =?us-ascii?Q?0mCdylNd+tmdnFfVAa+v4QuT+gQbw36FgBo1Ga3BDI4dSPfXXhNP5+hrI5MB?=
 =?us-ascii?Q?43v5QH+A7lsrtxtT75FUkGvzeidtfMfMQEoCZyU/+v8w7+/TEtH4znlmK20B?=
 =?us-ascii?Q?PnUJT2BZiH5RyMIx6bqa2L2hYHVoujzBH+bbRJPn24tK6YX6+60SWkYLKrNo?=
 =?us-ascii?Q?673c7mFg00eORyCJrjrbiECDxVtybVIfaRc7LmnrX8xobAE50WOAdOZ91FGA?=
 =?us-ascii?Q?LLE9jwYbQpNwZMMl7qzRYXvDrGnLzfBGvZsJhEi7C4W64dwueiF0JTjjw9LX?=
 =?us-ascii?Q?p/MLWL8vlv8TBt+NPxkQZNlKC1Fp60nExlQZjPqp07toX2U6SR3v7FZ0gNpY?=
 =?us-ascii?Q?UGPxyV0GYGhv4oD16b3wZJprIWRp7+k+iYoOIsxyAcrdtfQNtk8IGj6RSGNc?=
 =?us-ascii?Q?TIYU+ZSSlHouh81S7RipyaSFhixmmM4jH+3k1lVHlO1+Ps+40mketTqpelwa?=
 =?us-ascii?Q?/K9y+WZQtKCWErELLf1/2b8K8zumLTwVZGrmw3VrLRj7scbxma6D612z1166?=
 =?us-ascii?Q?psSgBhgD/1pspNPu3Gs7x1E33fIOeAl0FcspHFcdgw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3hwJIZgdvdFtsnRRQ3EmPwYBRVpppdd98gk2AQN5gh24gyRd14ajFk5NkcoP?=
 =?us-ascii?Q?e2JNm5flw4Ca5K0haQh8dH1dDlrvCRijzQc+QDip/2XcL8Vz+iLKyo3lsRXw?=
 =?us-ascii?Q?XDi7Le90f5dYXXIcDk99vnKuiTPzerG81ZJnKqJhzM9uaGe7yg8X55PzIKRh?=
 =?us-ascii?Q?hQs0Jyn7FSCY373KwSn8+rPVCuxUwFh9RaStV0cvD5QHp3OEcU5DqBxlLTt/?=
 =?us-ascii?Q?ML0YdzHgTg6Ijr5qFyM/2WJGDPHLifR3CM94pv7Vu5GeFxs4BiHhCPocHRrY?=
 =?us-ascii?Q?ckhF2SfVH2WoNBmQcIntDjxVwH50tugPxwb0/t/8CMrEYjW+F4emmfhK9WZy?=
 =?us-ascii?Q?CK0GdppVnbTWV76WmTdmQTXIEjZGWN2DLP+YGiSUrUIzw/UtbawCQ2K/S75G?=
 =?us-ascii?Q?MQpjuCC6kgeNFmxKYNK7OO21C5lihBCel/m4Q6XEGdnR6ekyRhqDmhd9HFvk?=
 =?us-ascii?Q?HOOUNKAFDLjq851TUl4GHVo6fDVWoyUSQfdnjjvTSP5K2wAqsrTdqH0++mXl?=
 =?us-ascii?Q?gmBhU9FexVJ1bToseuq6zXa7U0DaWTGm4Azpw0h1GojXfrYOGRMhIAAc279T?=
 =?us-ascii?Q?iWKl9G5ZMCbPa3msiGZfDisdi0DXu+cFa9EOW4o853CHTZWrACDD4qfODyMJ?=
 =?us-ascii?Q?LoUnWKzmaZaJjPOCqfkGZ33m16YeZObMsqvE5tAYX/wDbeM5jEwbNeBVRYjW?=
 =?us-ascii?Q?4W4fq43NSXxZbH4YrJM6FmLKuGCLoBXYIrUMDpBdErnedzIXAasF61W9tNK2?=
 =?us-ascii?Q?C7PVbKusXq1+iQRIQvQ2Z/ifNwKnEzvBuBUpaqZVaTrlxg3BQuk8buHbCbOp?=
 =?us-ascii?Q?til7kKWqETrGmv6+8cRX24OdBok5M7iG8b7TqFr39IKeEaiAyDJ26We+Mg2z?=
 =?us-ascii?Q?/cKkJAMRCITs0ilg/KEkRsIV/ziRzX7+MIJDyUhaO+rIRrDu7owd9SfuJxsH?=
 =?us-ascii?Q?tTeA+oenOIsQLO43g2GvZdVsO23e2fn/1l6Iz9T2MxEmZDdA5H2xjHezoLv3?=
 =?us-ascii?Q?KICK5cRK5ZaKhWCyOxwX7FJ8Jo9L5AW/5q8S2/GgB60BMyv2yYk7r6P/zHYs?=
 =?us-ascii?Q?9iDhOAqf6loPzwnVir7mGT2ny4mR+5j/4olg9a/UduRuYFeteiPBaAz/svXJ?=
 =?us-ascii?Q?1KocmQgq1oARz2IFMmuA4GM0XJiJ/X1Kej584ysMpa1HqUdR4RHWj8SHtvFq?=
 =?us-ascii?Q?WrSpKzNRDvhhkPdicJg2zi1TQqMp7V7Y0aaefHj69W7lZzFvBUUB4jZYfQmx?=
 =?us-ascii?Q?Hz0mmBARqtiLnPX7DOpO9xsdRJzTCIoTGGn4/ImMY9s4FL0yEwgBYUiuegFD?=
 =?us-ascii?Q?ZF9xYhSnyIByih+HmBm34PULRJhGRzFAKJ7eq/uRhTP9IpS1lid/NVv6r8dG?=
 =?us-ascii?Q?msxuBvYqFBc5fPZL/gF0rivndAN771Ar+352jalj8dAEwTnStUWWeZHETlHV?=
 =?us-ascii?Q?mM892ChwTrWTJCFI/RWkIZ4rtoQ1mBB+kDImLm94bGrJI58NylZIT7jFTxoh?=
 =?us-ascii?Q?vDo5J9ww+erZqWm4M3pliDL66Z0qrWtG6g82IZ2ViWoee/P1AnJjkeOi9Cms?=
 =?us-ascii?Q?95fBGQyPTNcvBf2rp8UY9kghLJ088W4l4yEVcX7P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b248ecb8-2120-41de-bedd-08dced318aa9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:53:41.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRnW88/iQXbq6buVUwMFGFHYMoeWwmFpPFPsTKunYu6931V2XBhrB/Hn7qPCn3G4GHr8J8dHDZsMHswzYR0/iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6135
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
>=20
>=20
> On 15/10/2024 16:39, Zhijian Li (Fujitsu) wrote:
> >=20
> > All,
> >=20
> > I encountered a panic with similar calltrace
> >=20
> > I guessed I have root cause this, it was introduced since commit
> >=20
> > commit a5ab0de0ebaa65e0a75ec0761a2745c66a9d17dc
> > Author: Dave Jiang <dave.jiang@intel.com>
> > Date:   Tue Sep 3 17:11:51 2024 -0700
> >=20
> >       cxl: Calculate region bandwidth of targets with shared upstream l=
ink
> >=20
> >=20
> > Which calls cxl_region_shared_upstream_bandwidth_update(cxlr).
> > However, the cxl_region_shared_upstream_bandwidth_update(cxlr) works on=
 PCI/PCIE device only
> > while the cxl_test was implemented by platform device.
> >=20
> > I'm cooking and testing below patch
>=20
>=20
> An alternative patch with a mock,

This prevents the kasan error as well.  I've also reproduced your pointer
bug.  I now see this is clearly a cxl-test only issue.

For the future I wonder if this mock function should walk the platform
devices to test the aggregate bandwidth through simulated switches?  But
the current tests don't seem to care.  So I'm inclined to get your patch
into rc quickly.

Zhijian

Would you like me to write up the patch or can you submit it quickly so I
can soak it for RC?

Thanks,
Ira

>=20
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index b1256fee3567..ed9f50dee3f5 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -15,6 +15,7 @@ ldflags-y +=3D --wrap=3Ddevm_cxl_add_rch_dport
>   ldflags-y +=3D --wrap=3Dcxl_rcd_component_reg_phys
>   ldflags-y +=3D --wrap=3Dcxl_endpoint_parse_cdat
>   ldflags-y +=3D --wrap=3Dcxl_dport_init_ras_reporting
> +ldflags-y +=3D --wrap=3Dcxl_region_shared_upstream_bandwidth_update
>  =20
>   DRIVERS :=3D ../../../drivers
>   CXL_SRC :=3D $(DRIVERS)/cxl
> @@ -61,6 +62,7 @@ cxl_core-y +=3D $(CXL_CORE_SRC)/pci.o
>   cxl_core-y +=3D $(CXL_CORE_SRC)/hdm.o
>   cxl_core-y +=3D $(CXL_CORE_SRC)/pmu.o
>   cxl_core-y +=3D $(CXL_CORE_SRC)/cdat.o
> +cxl_core-y +=3D mock_cdat.o
>   cxl_core-$(CONFIG_TRACING) +=3D $(CXL_CORE_SRC)/trace.o
>   cxl_core-$(CONFIG_CXL_REGION) +=3D $(CXL_CORE_SRC)/region.o
>   cxl_core-y +=3D config_check.o
> diff --git a/tools/testing/cxl/mock_cdat.c b/tools/testing/cxl/mock_cdat.=
c
> new file mode 100644
> index 000000000000..a48d9c549651
> --- /dev/null
> +++ b/tools/testing/cxl/mock_cdat.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +
> +#include <cxl.h>
> +
> +void __wrap_cxl_region_shared_upstream_bandwidth_update(struct cxl_regio=
n *cxlr)
> +{
> +}
>=20
>=20
> >=20
> > index ef1621d40f05..3eb27cfe43ed 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -5,6 +5,7 @@
> >    #include <linux/fw_table.h>
> >    #include <linux/node.h>
> >    #include <linux/overflow.h>
> > +#include <linux/platform_device.h>
> >    #include "cxlpci.h"
> >    #include "cxlmem.h"
> >    #include "core.h"
> > @@ -641,9 +642,13 @@ static int cxl_endpoint_gather_bandwidth(struct cx=
l_region *cxlr,
> >           void *ptr;
> >           int rc;
> >=20
> >           if (cxlds->rcd)
> >                   return -ENODEV;
> >   =20
> > +       if (dev_is_platform(cxlds->dev))
> > +               return -ENODEV;
> > +
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > reproducer:
> > $ while true; do meson test cxl-create-region.sh; done
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [ 1174.878672] platform cxl_host_bridge.3: host supports CXL (restricte=
d)
> > [ 1175.532274] Oops: general protection fault, probably for non-canonic=
al address 0x3ef17856fcae4fbd: 0000 [#1] PREEMPT SMP PTI
> > [ 1175.532300] CPU: 1 UID: 0 PID: 9167 Comm: cxl Kdump: loaded Tainted:=
 G           OE      6.12.0-rc3-master+ #66
> > [ 1175.532316] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> > [ 1175.532325] Hardware name: LENOVO 90CXCTO1WW/, BIOS FCKT70AUS 04/23/=
2015
> > [ 1175.532335] RIP: 0010:pci_bus_read_config_word+0x1c/0x60
> > [ 1175.532346] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44=
 00 00 53 b8 87 00 00 00 48 83 ec 08 c7 44 24 04 00 00 00 00 f6 c2 01 75 29=
 <48> 8b 87 c0 00 00 00 48 89 cb 4c 8d 44 24 04 b9 02 00 00 00 48 8b
> > [ 1175.532370] RSP: 0018:ffffa115034dfbb8 EFLAGS: 00010246
> > [ 1175.532379] RAX: 0000000000000087 RBX: 0000000000000012 RCX: ffffa11=
5034dfbfe
> > [ 1175.532390] RDX: 0000000000000016 RSI: 000000006f4e2f4e RDI: 3ef1785=
6fcae4efd
> > [ 1175.532401] RBP: ffff8cc229121b48 R08: 0000000000000010 R09: 0000000=
000000000
> > [ 1175.532412] R10: 0000000000000001 R11: ffff8cc225434360 R12: ffffa11=
5034dfbfe
> > [ 1175.532422] R13: 0000000000000000 R14: ffff8cc2f119a080 R15: ffffa11=
5034dfc50
> > [ 1175.532433] FS:  00007f31d93537c0(0000) GS:ffff8cc510a80000(0000) kn=
lGS:0000000000000000
> > [ 1175.532445] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1175.532455] CR2: 00007f31d95f3370 CR3: 00000001163ea001 CR4: 0000000=
0001726f0
> > [ 1175.532465] Call Trace:
> > [ 1175.532472]  <TASK>
> > [ 1175.532478]  ? __die_body.cold+0x19/0x27
> > [ 1175.532488]  ? die_addr+0x38/0x60
> > [ 1175.532496]  ? exc_general_protection+0x1f5/0x4b0
> > [ 1175.532507]  ? asm_exc_general_protection+0x22/0x30
> > [ 1175.532519]  ? pci_bus_read_config_word+0x1c/0x60
> > [ 1175.532528]  pcie_capability_read_word+0x93/0xb0
> > [ 1175.532538]  pcie_link_speed_mbps+0x18/0x50
> > [ 1175.532548]  cxl_pci_get_bandwidth+0x18/0x60 [cxl_core]
> > [ 1175.532575]  cxl_endpoint_gather_bandwidth.constprop.0+0xf4/0x230 [c=
xl_core]
> > [ 1175.532596]  ? xas_store+0x54/0x660
> > [ 1175.532605]  ? preempt_count_add+0x69/0xa0
> > [ 1175.532615]  ? _raw_spin_lock+0x13/0x40
> > [ 1175.532623]  ? __kmalloc_cache_noprof+0xe7/0x270
> > [ 1175.532632]  cxl_region_shared_upstream_bandwidth_update+0x9c/0x790 =
[cxl_core]
> > [ 1175.532653]  cxl_region_attach+0x520/0x7e0 [cxl_core]
> > [ 1175.532672]  store_targetN+0xf2/0x120 [cxl_core]
> > [ 1175.532690]  kernfs_fop_write_iter+0x13a/0x1f0
> > [ 1175.532699]  vfs_write+0x23b/0x410
> > [ 1175.532707]  ksys_write+0x53/0xd0
> > [ 1175.532714]  do_syscall_64+0x62/0x180
> > [ 1175.532724]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [ 1175.532734] RIP: 0033:0x7f31d9611834
> > [ 1175.532742] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84=
 00 00 00 00 00 f3 0f 1e fa 80 3d 15 f8 0d 00 00 74 13 b8 01 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> > [ 1175.532764] RSP: 002b:00007ffc382f7ff8 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000001
> > [ 1175.532776] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f3=
1d9611834
> > [ 1175.532787] RDX: 000000000000000c RSI: 000000003ed90593 RDI: 0000000=
000000003
> > [ 1175.532797] RBP: 00007ffc382f8030 R08: 0000000000000064 R09: 0000000=
0ffffffff
> > [ 1175.532808] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000=
000000006
> > [ 1175.532818] R13: 0000000000000000 R14: 00007f31d97c4000 R15: 0000000=
000428d80
> > [ 1175.532830]  </TASK>
> > [ 1175.532835] Modules linked in: device_dax(OE) kmem dax_cxl cxl_mock_=
mem(OE) cxl_test(OE) cxl_mem(OE) cxl_port(OE) cxl_pmem(OE) cxl_acpi(OE) cxl=
_mock(OE) cxl_core(OE) xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf=
_nat_tftp nf_conntrack_tftp bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fi=
b_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft=
_ct nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_securi=
ty iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_ma=
ngle iptable_raw iptable_security ip_set nf_tables ip6table_filter iptable_=
filter rfkill intel_rapl_msr intel_rapl_common sunrpc x86_pkg_temp_thermal =
snd_hda_codec_realtek intel_powerclamp snd_hda_codec_generic coretemp snd_h=
da_scodec_component kvm_intel snd_hda_codec_hdmi snd_hda_intel snd_intel_ds=
pcfg snd_hda_codec kvm snd_hwdep snd_hda_core snd_seq snd_seq_device snd_pc=
m snd_timer snd rapl mei_hdcp intel_cstate soundcore iTCO_wdt mei_me at24 i=
ntel_pmc_bxt intel_uncore iTCO_vendor_support i2c_i801 wmi_bmof
> > [ 1175.532885]  pcspkr mei i2c_smbus lpc_ich loop nfnetlink zram xfs i9=
15 i2c_algo_bit drm_buddy ttm drm_display_helper dax_pmem(OE) nd_pmem(OE) n=
d_btt(OE) drm_kms_helper nd_e820(OE) libnvdimm(OE) crct10dif_pclmul crc32_p=
clmul crc32c_intel ghash_clmulni_intel drm nfit_test_iomap(OE) r8169 video =
wmi serio_raw ip6_tables ip_tables pkcs8_key_parser fuse
> > [ 1175.533043] ---[ end trace 0000000000000000 ]---
> > [ 1175.533055] RIP: 0010:pci_bus_read_config_word+0x1c/0x60
> > [ 1175.533065] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44=
 00 00 53 b8 87 00 00 00 48 83 ec 08 c7 44 24 04 00 00 00 00 f6 c2 01 75 29=
 <48> 8b 87 c0 00 00 00 48 89 cb 4c 8d 44 24 04 b9 02 00 00 00 48 8b
> > [ 1175.533088] RSP: 0018:ffffa115034dfbb8 EFLAGS: 00010246
> > [ 1175.533097] RAX: 0000000000000087 RBX: 0000000000000012 RCX: ffffa11=
5034dfbfe
> > [ 1175.533108] RDX: 0000000000000016 RSI: 000000006f4e2f4e RDI: 3ef1785=
6fcae4efd
> > [ 1175.533119] RBP: ffff8cc229121b48 R08: 0000000000000010 R09: 0000000=
000000000
> > [ 1175.533840] R10: 0000000000000001 R11: ffff8cc225434360 R12: ffffa11=
5034dfbfe
> > [ 1175.534567] R13: 0000000000000000 R14: ffff8cc2f119a080 R15: ffffa11=
5034dfc50
> > [ 1175.535295] FS:  00007f31d93537c0(0000) GS:ffff8cc510a80000(0000) kn=
lGS:0000000000000000
> > [ 1175.536015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1175.536720] CR2: 00007f31d95f3370 CR3: 00000001163ea001 CR4: 0000000=
0001726f0
> > [ 1176.146160] PEFILE: Unsigned PE binary
> >=20
> >=20
> > Thanks
> > Zhijian
> >=20
> >=20
> >=20
> > On 10/10/2024 17:03, Huang, Ying wrote:
> >> Hi, Dave,
> >>
> >> When I tried to test v6.12-rc2 with cxl_test in qemu, the below error =
is
> >> reported.  Revert commit a5ab0de0ebaa ("cxl: Calculate region bandwidt=
h
> >> of targets with shared upstream link") can eliminate the error.
> >>
> >> Can you take a look at it?
> >>
> >> The kernel config used to build kernel is attached.
> >>
> >> -----------------------------8<------------------------------
> >> [   28.103428] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [   28.104078] BUG: KASAN: slab-out-of-bounds in pcie_capability_reg_i=
mplemented+0x18/0xfb
> >> [   28.104635] Read of size 1 at addr ffff888008a79fb4 by task systemd=
-udevd/408
> >> [   28.105137]
> >> [   28.105261] CPU: 4 UID: 0 PID: 408 Comm: systemd-udevd Tainted: G  =
         O       6.12.0-rc2-kvm #5
> >> [   28.105868] Tainted: [O]=3DOOT_MODULE
> >> [   28.106201] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >> [   28.107115] Call Trace:
> >> [   28.107339]  <TASK>
> >> [   28.107526]  dump_stack_lvl+0x65/0x8c
> >> [   28.107803]  print_address_description.constprop.0+0x8a/0x309
> >> [   28.108223]  print_report+0x136/0x20f
> >> [   28.108493]  ? kmem_cache_debug_flags+0x16/0x23
> >> [   28.108836]  ? fixup_red_left+0x17/0x27
> >> [   28.109262]  ? pcie_capability_reg_implemented+0x18/0xfb
> >> [   28.109806]  kasan_report+0x85/0xa7
> >> [   28.110184]  ? pcie_capability_reg_implemented+0x18/0xfb
> >> [   28.110693]  pcie_capability_reg_implemented+0x18/0xfb
> >> [   28.111211]  pcie_capability_read_word+0x38/0xaa
> >> [   28.111653]  ? __free_kfree+0x9/0x22 [cxl_core]
> >> [   28.112194]  pcie_link_speed_mbps+0x54/0xae
> >> [   28.112594]  ? pcie_get_mps+0x6d/0x6d
> >> [   28.113037]  cxl_pci_get_bandwidth+0x58/0xd3 [cxl_core]
> >> [   28.113645]  ? cxl_pci_get_latency+0xac/0xac [cxl_core]
> >> [   28.114192]  ? _raw_spin_unlock+0x1f/0x2f
> >> [   28.114683]  ? xa_store+0x3b/0x45
> >> [   28.115109]  cxl_endpoint_gather_bandwidth.constprop.0+0x2bf/0x352 =
[cxl_core]
> >> [   28.116017]  ? cxl_hb_gather_bandwidth+0x205/0x205 [cxl_core]
> >> [   28.116967]  ? __module_address+0xe7/0xff
> >> [   28.117673]  ? is_module_address+0x11/0x26
> >> [   28.118419]  ? static_obj+0x7f/0x90
> >> [   28.119016]  ? lockdep_init_map_type+0x22e/0x305
> >> [   28.120557]  ? __raw_spin_lock_init+0x73/0x83
> >> [   28.121707]  cxl_region_shared_upstream_bandwidth_update+0x12c/0x49=
1 [cxl_core]
> >> [   28.123434]  ? cxl_endpoint_gather_bandwidth.constprop.0+0x352/0x35=
2 [cxl_core]
> >> [   28.124622]  ? check_last_peer+0x228/0x2c5 [cxl_core]
> >> [   28.125273]  ? xa_set_mark+0x34/0x34
> >> [   28.125717]  ? cxl_region_setup_targets+0x3a/0x1b8 [cxl_core]
> >> [   28.126417]  cxl_region_attach+0x8cb/0xb05 [cxl_core]
> >> [   28.127049]  attach_target+0x49/0x6f [cxl_core]
> >> [   28.127631]  cxl_add_to_region+0x15a/0x1d6 [cxl_core]
> >> [   28.128262]  ? schedule_detach+0xa/0xa [cxl_port]
> >> [   28.128790]  discover_region+0x5d/0xb6 [cxl_port]
> >> [   28.129327]  ? next_device+0x20/0x2d
> >> [   28.129767]  device_for_each_child+0x8f/0xc0
> >> [   28.130243]  ? next_device+0x2d/0x2d
> >> [   28.130644]  ? kobject_get+0x47/0x75
> >> [   28.131051]  cxl_port_probe+0x19f/0x272 [cxl_port]
> >> [   28.131573]  ? discover_region+0xb6/0xb6 [cxl_port]
> >> [   28.132117]  ? kernfs_put+0x19/0x2b
> >> [   28.132509]  ? sysfs_do_create_link_sd+0x7a/0xbc
> >> [   28.133016]  cxl_bus_probe+0x27/0x54 [cxl_core]
> >> [   28.133611]  ? really_probe+0x194/0x43d
> >> [   28.134064]  really_probe+0x1e4/0x43d
> >> [   28.134483]  ? driver_probe_device+0xc0/0xc0
> >> [   28.134969]  driver_probe_device+0x4a/0xc0
> >> [   28.135430]  __device_attach_driver+0xd7/0x102
> >> [   28.135932]  bus_for_each_drv+0xf2/0x116
> >> [   28.136374]  ? bus_rescan_devices+0x15/0x15
> >> [   28.136849]  __device_attach+0x10c/0x19c
> >> [   28.137300]  ? device_bind_driver+0x39/0x39
> >> [   28.137787]  ? bus_to_subsys+0xad/0xb9
> >> [   28.138213]  bus_probe_device+0x4e/0xd3
> >> [   28.138656]  device_add+0x55b/0x791
> >> [   28.139056]  ? get_device_parent+0x20a/0x20a
> >> [   28.139539]  ? rcu_read_unlock+0x51/0x5b
> >> [   28.139996]  devm_cxl_add_port+0x20a/0x49c [cxl_core]
> >> [   28.140642]  ? cxl_port_alloc+0x430/0x430 [cxl_core]
> >> [   28.141271]  cxl_mem_probe+0x3b9/0x47c [cxl_mem]
> >> [   28.141806]  ? __devm_add_action_or_reset+0x26/0x26 [cxl_mem]
> >> [   28.142447]  ? sysfs_do_create_link_sd+0x7a/0xbc
> >> [   28.142969]  cxl_bus_probe+0x27/0x54 [cxl_core]
> >> [   28.143540]  ? really_probe+0x194/0x43d
> >> [   28.143999]  really_probe+0x1e4/0x43d
> >> [   28.144418]  ? driver_probe_device+0xc0/0xc0
> >> [   28.144902]  driver_probe_device+0x4a/0xc0
> >> [   28.145353]  __device_attach_driver+0xd7/0x102
> >> [   28.145629]  bus_for_each_drv+0xf2/0x116
> >> [   28.145865]  ? bus_rescan_devices+0x15/0x15
> >> [   28.146115]  __device_attach+0x10c/0x19c
> >> [   28.146351]  ? device_bind_driver+0x39/0x39
> >> [   28.146614]  ? bus_to_subsys+0xad/0xb9
> >> [   28.146839]  bus_probe_device+0x4e/0xd3
> >> [   28.147069]  device_add+0x55b/0x791
> >> [   28.147306]  ? get_device_parent+0x20a/0x20a
> >> [   28.147568]  ? kobject_get+0x47/0x75
> >> [   28.147784]  cdev_device_add+0x31/0x89
> >> [   28.148015]  devm_cxl_add_memdev+0x26e/0x2d7 [cxl_core]
> >> [   28.148369]  cxl_mock_mem_probe+0x2f3/0x33b [cxl_mock_mem]
> >> [   28.148694]  platform_probe+0x3d/0x7a
> >> [   28.148914]  really_probe+0x1e4/0x43d
> >> [   28.149133]  ? __device_attach_driver+0x102/0x102
> >> [   28.149420]  driver_probe_device+0x4a/0xc0
> >> [   28.149669]  __driver_attach+0x19c/0x1bb
> >> [   28.149912]  bus_for_each_dev+0xc7/0x101
> >> [   28.150152]  ? bus_register+0x2d4/0x2d4
> >> [   28.150387]  ? bus_add_driver+0x137/0x2cc
> >> [   28.150648]  bus_add_driver+0x19d/0x2cc
> >> [   28.150881]  driver_register+0x12c/0x17d
> >> [   28.151111]  ? 0xffffffffc0ac8000
> >> [   28.151307]  do_one_initcall+0x139/0x2da
> >> [   28.151538]  ? rcu_lock_acquire.constprop.0+0x25/0x25
> >> [   28.151826]  ? unpoison_slab_object+0x1b/0x38
> >> [   28.152100]  ? __kasan_slab_alloc+0x37/0x41
> >> [   28.152342]  ? rcu_is_watching+0x1c/0x38
> >> [   28.152572]  ? poison_kmalloc_redzone+0x44/0x65
> >> [   28.152835]  ? kasan_unpoison+0x26/0x31
> >> [   28.153058]  ? __asan_register_globals+0x55/0x60
> >> [   28.153338]  do_init_module+0x118/0x388
> >> [   28.153576]  init_module_from_file+0xc2/0xe4
> >> [   28.153838]  ? __ia32_sys_init_module+0x40/0x40
> >> [   28.154127]  ? do_raw_spin_unlock+0xce/0xd6
> >> [   28.154370]  idempotent_init_module+0x1ea/0x3c0
> >> [   28.154634]  ? init_module_from_file+0xe4/0xe4
> >> [   28.154892]  ? __seccomp_filter+0xf5/0x4f2
> >> [   28.155135]  ? files_lookup_fd_raw+0x40/0x4b
> >> [   28.155386]  __do_sys_finit_module+0x68/0x82
> >> [   28.155636]  do_syscall_64+0x9a/0xfd
> >> [   28.155848]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >> [   28.156145] RIP: 0033:0x7f2239ce4559
> >> [   28.156355] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 9=
0 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 0=
5 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 77 08 0d 00 f7 d8 64 89 01 48
> >> [   28.157428] RSP: 002b:00007fffd30e95d8 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000139
> >> [   28.157858] RAX: ffffffffffffffda RBX: 000055fd0ed12110 RCX: 00007f=
2239ce4559
> >> [   28.158260] RDX: 0000000000000000 RSI: 00007f2239e67e2d RDI: 000000=
0000000006
> >> [   28.158661] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055=
fd0ed13b28
> >> [   28.159063] R10: 0000000000000006 R11: 0000000000000246 R12: 00007f=
2239e67e2d
> >> [   28.159465] R13: 0000000000000000 R14: 000055fd0ed13180 R15: 000055=
fd0ed12110
> >> [   28.159870]  </TASK>
> >> [   28.160003]
> >> [   28.160098] Allocated by task 385:
> >> [   28.160298]  stack_trace_save+0x7c/0x94
> >> [   28.160523]  kasan_save_stack+0x1c/0x34
> >> [   28.160763]  kasan_save_track+0x10/0x25
> >> [   28.160997]  __kasan_kmalloc+0x3a/0x43
> >> [   28.161222]  __kmalloc_node_track_caller_noprof+0x1fd/0x22d
> >> [   28.161562]  kmalloc_reserve+0xe6/0x130
> >> [   28.161797]  __alloc_skb+0x109/0x1b8
> >> [   28.162018]  alloc_uevent_skb+0x55/0xe2
> >> [   28.162254]  kobject_uevent_net_broadcast+0x11d/0x265
> >> [   28.162565]  kobject_uevent_env+0x534/0x6d3
> >> [   28.162806]  device_add+0x4da/0x791
> >> [   28.163011]  platform_device_add+0x248/0x2dd
> >> [   28.163258]  0xffffffffc0b40708
> >> [   28.163446]  do_one_initcall+0x139/0x2da
> >> [   28.163673]  do_init_module+0x118/0x388
> >> [   28.163933]  init_module_from_file+0xc2/0xe4
> >> [   28.164312]  idempotent_init_module+0x1ea/0x3c0
> >> [   28.164665]  __do_sys_finit_module+0x68/0x82
> >> [   28.164992]  do_syscall_64+0x9a/0xfd
> >> [   28.165295]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >> [   28.165634]
> >> [   28.165767] Freed by task 168:
> >> [   28.165968]  stack_trace_save+0x7c/0x94
> >> [   28.166207]  kasan_save_stack+0x1c/0x34
> >> [   28.166442]  kasan_save_track+0x10/0x25
> >> [   28.166669]  kasan_save_free_info+0x3b/0x41
> >> [   28.166912]  __kasan_slab_free+0x18/0x2a
> >> [   28.167150]  kfree+0x206/0x26a
> >> [   28.167388]  skb_release_data+0x152/0x16e
> >> [   28.167636]  __kfree_skb+0x14/0x1e
> >> [   28.167834]  netlink_recvmsg+0x2b2/0x503
> >> [   28.168066]  sock_recvmsg_nosec+0x48/0x80
> >> [   28.168305]  ____sys_recvmsg+0x10c/0x1fa
> >> [   28.168542]  ___sys_recvmsg+0xc7/0x103
> >> [   28.168762]  __sys_recvmsg+0xb7/0x113
> >> [   28.168978]  do_syscall_64+0x9a/0xfd
> >> [   28.169188]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >> [   28.169504]
> >> [   28.169599] The buggy address belongs to the object at ffff888008a7=
9800
> >> [   28.169599]  which belongs to the cache kmalloc-1k of size 1024
> >> [   28.170285] The buggy address is located 948 bytes to the right of
> >> [   28.170285]  allocated 1024-byte region [ffff888008a79800, ffff8880=
08a79c00)
> >> [   28.171055]
> >> [   28.171152] The buggy address belongs to the physical page:
> >> [   28.171487] page: refcount:1 mapcount:0 mapping:0000000000000000 in=
dex:0xffff888008a7f800 pfn:0x8a78
> >> [   28.172060] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_map=
ped:0 pincount:0
> >> [   28.172539] flags: 0xffffc000000240(workingset|head|node=3D0|zone=
=3D1|lastcpupid=3D0x1ffff)
> >> [   28.173104] page_type: f5(slab)
> >> [   28.173343] raw: 00ffffc000000240 ffff888001042dc0 ffffea0000226410=
 ffffea00002f3010
> >> [   28.173822] raw: ffff888008a7f800 0000000000100008 00000001f5000000=
 0000000000000000
> >> [   28.174308] head: 00ffffc000000240 ffff888001042dc0 ffffea000022641=
0 ffffea00002f3010
> >> [   28.174733] head: ffff888008a7f800 0000000000100008 00000001f500000=
0 0000000000000000
> >> [   28.175177] head: 00ffffc000000003 ffffea0000229e01 fffffffffffffff=
f 0000000000000000
> >> [   28.175631] head: 0000000000000008 0000000000000000 00000000fffffff=
f 0000000000000000
> >> [   28.176074] page dumped because: kasan: bad access detected
> >> [   28.176391]
> >> [   28.176484] Memory state around the buggy address:
> >> [   28.176746]  ffff888008a79e80: fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc
> >> [   28.177121]  ffff888008a79f00: fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc
> >> [   28.177612] >ffff888008a79f80: fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc
> >> [   28.178011]                                      ^
> >> [   28.178286]  ffff888008a7a000: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
> >> [   28.178671]  ffff888008a7a080: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
> >> [   28.179183] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> --
> >> Best Regards,
> >> Huang, Ying


