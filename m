Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84121FAC5C
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707989; cv=fail; b=qvWf0a13CbHuj6oHcdizkewdCPP4UwSmP/B9/6zlhfbMLj1U41vK0LI/88czJO4tF2m59DTV7qFIMOPlODMaYYYVe2K0D6Utu3/IjQsOkXKe6FQ1IlLdEmL4X91YuvUOSOMAxbC+mhftUI+dWPeEnjYQjWtNp6rvofLZv9Gsmxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707989; c=relaxed/simple;
	bh=uSDfBrFMqQic/UdW0dUuGqYIbLtJU97qb11Ev05F8hk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ABBcc0vTPjMh+2eLHONNXKx0PD244PuWUTGvpxYhktKiQJkkpsiB9Qqebtb5UsF0q0VjFp6R+PNfBaDTRN5gq8ZSzVYo1djXvfpsfSSeMp4XMGjNaZLoPlr+tlQE6yFkrilHqzJ6MRF/gL7YlkZ1YcLKnhGEnZNrnmnEAyrfO1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTcBGBqW; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTcBGBqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738707986; x=1770243986;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uSDfBrFMqQic/UdW0dUuGqYIbLtJU97qb11Ev05F8hk=;
  b=OTcBGBqWD9uyBIhBYuafPPZyAxQIGqzvSfOey7+wlQEhmp6u5ZW9RQlV
   ChySxNpjjcjfcEeAvcXoRQqHo6y8qusVgvVOFRcGiAWXgs7jj35RYBJW+
   OLLmDtGq1rLs+TOpA7jjxzIjUy2AlaQMj7Pc5+0/WjZOh/e7ysQOrbvbV
   Ox6Hc2nFVmyklwG1RT+HgVaHRvOQYmuDjFxbkhMidCRxWOgkwaeA4oI/Q
   mCrW8fBmchY3uv8TFwTc24VEra2kPSk6ifjl7bu5puAgm+/2CsMnojXCZ
   QAlOnzBg4tvDZiXcbm17/n6Z1dZmXbpTI8wmk25kZ61v4RETYBUSO6nrm
   w==;
X-CSE-ConnectionGUID: QND+iQLlQG+18d0QAYvVWw==
X-CSE-MsgGUID: XseLWde6TDGzw+7TCQakRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43177650"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="43177650"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 14:26:23 -0800
X-CSE-ConnectionGUID: BhMeXg7PS+mjj2tHFh25rA==
X-CSE-MsgGUID: sQYco3qgRg6zYix/lq32BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115715175"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 14:26:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 14:26:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 14:26:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 14:26:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl57Y4fL3zBuf0CD0RmR8ha/9uyYvxY2Dc/znop6lzco4zpoA24qhAFHbj+7ZbgwFR6RPlWOQWNrCTunMal94oSHQnSvVfuVbsDjGXvuYARrrP/k0VVJmX6fmLHBuoJZiUuN1EbQXtMiApH36G8mDgNvlJfJCOAMj/JgnfeJ3N55HfubFyMln0gAyTHdI60ThwJz3NxSm5zfjGn5n/HJURz5AaOXylnoCkM4L0pGCxoMUadUBFFvTASUzvmUO8vUDEl6Ia8VBWRqTvmp9wtq6X034sZVjNvvC0R/STkBkR/VpLyiBnTMTn9UKgdc0uht5FT6SPj91QL2rwqNQMVHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHjgNZCrSqdwErF0vqrYHfBTOusCYjoLAmPGdoK4E3Q=;
 b=Y5c9rjoJrlkg2brpVzMsV8WYrn98Ia9MY63EtYGvShvtJtT5goJZOWEep436OAiWE1rLSh1HpXgjU0Uj7tj+2Sbi8uTpas4Q6XdFVmp+HCBgsGiR7CMVPEzxq5x/7d4d6p4plliCAdXSn3EolpmevA/WTc9iIldZIPvw9ulQXeNPTFiJ7pMsf1AL3S0HSVBVPonZ+B4CkYhMHThg2jW1s5Sqe0XAi1Xp1selFvGFApj4u3+UgOBkCOWuYrAK/9zpCEtQqUjPellh6tP/ch8iIjveWS2+sBZ3+wcWuwoTDmpq2/5nAATWIhUXQhu62lALcF8Cj8JfrKWG+9kntfJP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Feb
 2025 22:26:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:26:05 +0000
Date: Tue, 4 Feb 2025 14:26:02 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <67a293fa8f068_2d2c2944d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-15-dave.jiang@intel.com>
 <6794478dd8026_20f329455@dwillia2-xfh.jf.intel.com.notmuch>
 <20250127105132.000072dd@huawei.com>
 <67982790e13d1_2d1e294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <20250128120138.0000599f@huawei.com>
 <67a170ca464e3_2d2c294d@dwillia2-xfh.jf.intel.com.notmuch>
 <20250204100408.000048fd@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204100408.000048fd@huawei.com>
X-ClientProxiedBy: MW2PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:302:1::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 657a9cd2-f084-4c71-c387-08dd456aea12
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e3aG3CCTh79N42b4zcEguvClj2O+Fp+qoQQbpYsMKLq065iipxEas4pLqNfk?=
 =?us-ascii?Q?Rmat6ka/43hLIYM+GdJtPE9QozFou3GCC+BhOjlP1+BzqsWpja+qIpjFkBae?=
 =?us-ascii?Q?OZvA8xUF2/p00WgGzYDG9PMgFEFflaPZ13wIcK0hGTJA+ImS15RUUpXmX52n?=
 =?us-ascii?Q?X4vkiRa8sIm1vDFhOybeKQJQLgJFeBh6eI2psaPk3JjgME1AYlXjk0D7Ly0h?=
 =?us-ascii?Q?7n123UmDKa12zNjP7iTkIqnZdR8DqKqYQ1KANHteI9JtJgJ8X2D/n189iNQF?=
 =?us-ascii?Q?erJcl1hD15dv2egq/RZzsQtiX/M3HLIcXpJi5u+NXzeDftRATUisJImFj6BQ?=
 =?us-ascii?Q?8aiSh9qQJULq0cPsUvDrF9ssWmDRcI04mLuFs1rj6RaZzl9bi+JF2be8Ovi5?=
 =?us-ascii?Q?KpdU/v6n4IkK71Z6MfmST20fq6fCxoOMOymxzICzR3rm0AIQ0P4GRA+6MXO/?=
 =?us-ascii?Q?XHuJryzpL6JCoo/O/U5tkz1cD4fnRkvkFrEuK9DtSQJBmMa3S93pV59s4K/t?=
 =?us-ascii?Q?ogJUtmW4OovXQQ0ptsVLdQbIOzv+o6iYTuakfmlAWq+wLXzKvj5ohKJ3z7UM?=
 =?us-ascii?Q?KZ1Bo8br92NG+A2etpdRN0RQoE8pjPWeJVlf4MJqBGQY4MmAoIZ+l9DoXfEN?=
 =?us-ascii?Q?3cqa8jIPC4UuDe/GfqnOnUqQwiff8k5p/+uviH6FivgCCr7Yt5i8NT9rc3Y3?=
 =?us-ascii?Q?fxLcA3FGWNmEd1ZyGEOrBpEokkHoqS6x2vJKGYvRpzSX7+r2Ei1Pjtf4CLQc?=
 =?us-ascii?Q?s/C2BTGITHTcMNStyc1LlUrP0FdAzUUvVRQQuG2gxIBuvQC7f2cK4/Nfe6kW?=
 =?us-ascii?Q?e8TZ/0sULzZoiYNMls0bCH3w/Vcp1nYb0CmvrDqC/aYfDkEl85cJqcc9qPzP?=
 =?us-ascii?Q?hmbzgCU7CDwU813GZlZVYw3d5EodxNAMZ8XnSjL64LeUi1I0MbSdKdKG04JD?=
 =?us-ascii?Q?98UEyN+2OhbHEJKNaaXp4pV3NFbQw5/z3+xyJXV8Zb8t8ivEFfAqQ6x5ziMA?=
 =?us-ascii?Q?CICcrI8ojXk0g8cU3PVAB2EEvIBxGsu5qmN7sZF7MPpY505fbVXdRbQg4wIp?=
 =?us-ascii?Q?H3tRuFHwOtTLluGaoep6PC1JYNJ5p1QZ6MHxhxj/SP7UH+JMqz+sv30VOpj7?=
 =?us-ascii?Q?2AXiOIhHJhMGyQh6z7AIWrRfpm5nAIXkSds+6fDSVQWjG2HaXMsxQtgd2SKB?=
 =?us-ascii?Q?zSXJS05tfQh75wYwCGy5x8zqN4s/PWQDyDySm2z+XYuq7gksgCB38VtdV8Y3?=
 =?us-ascii?Q?1RMlI0H3k7Rge/eUi9DTtHlQVKaa+ODRMNRr3fpWS3Gxym53cprUxF+bm5ZR?=
 =?us-ascii?Q?hvF3nHVJExi46Sqj61K5UwTI7lmXZgYZ9OOnW4N3a09N/R9mLIOCI+THwGdP?=
 =?us-ascii?Q?CaLGXmz8IveBUd+mrLFpfqjbAvuV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d/4x1qgu0qKAxnGbTWrMzRLcB74TniiVRGnNaFEOhIE39bdRWNuOHJE28snb?=
 =?us-ascii?Q?N5LnyYo1jrHxOzBgZesz9asohRkrm+mFQF+AJlnEZoq6ocdVdIWo7IRCpqqg?=
 =?us-ascii?Q?GD3hqiPmuaFbk3kQqug7cjne68sxD29GWnEMX7i4zlYJDxj0nQ3+BoqFTYi2?=
 =?us-ascii?Q?cs9MUQ4cebt0ObB1zHgClOfl960SCEhYOvs0jj6rj5h6+fynzGM1FW/xoRHE?=
 =?us-ascii?Q?1ySwsUT0Nbn84XsYmulUcsmeb6angLrP1kowXwIjLgmztc5hnil9emBWAs6L?=
 =?us-ascii?Q?OvHDxdgnBN1/BaDVnhusVMEQMxARwO3NgpykyMsVG9NCmM4FZkW0ft1Xi5S7?=
 =?us-ascii?Q?Civd+hYU7XMgBQCX5UirG5uxDN4cpRJUhpzspX5i0p2WNIekp08hXH5emb3c?=
 =?us-ascii?Q?rPZicc2SXkeCpbRL4Lm8vWjnwXL17Zvz0+LqG5BRhWyJUkunInvmPwKSt9GF?=
 =?us-ascii?Q?7YyWlxd9rPapVLwcGvfJbJMjsisjF/bRH4bZcqnOV6ykeHYf5st5K7sb8mL7?=
 =?us-ascii?Q?BURFxUrNRwQ5/XjZiE2ixVA3BhCBqvA57qG78zo76ykGukg6nstbd/0wiSHs?=
 =?us-ascii?Q?FUxbLrG6dSdgAQZ9vmY/TaOb7WIoqYp6ROZrSqolNjiU5SW/NDSraGXH9I9k?=
 =?us-ascii?Q?Fcvh0neBa4Mj7JSDo4RB+qSOqVs4RF0GyQReoURwi87blPiACfnB2mIzF7Y5?=
 =?us-ascii?Q?KPdzt/Vxg4AoS9aEewKnjLnAce/hyn7x5/+BBEIuRGMsSBIDbppIfAHQ0vmI?=
 =?us-ascii?Q?8nPXAiXWNUQNX9Wz2JgDO9ly7ieAIp4zNnQPthrAp007KjpFU+lycKvXk+VA?=
 =?us-ascii?Q?1omPd3uauGj55EHrHujsEtM+aQaXvCNB9QxLt8cynT67OJHRvFG/YD95GBp2?=
 =?us-ascii?Q?awe+Eui8RrC1PdUfcbnOJM2PN/s8HxonQPi1bHG9sr6+5Xdvo89+lIRfjXj9?=
 =?us-ascii?Q?fm/GWAGZcITeCXyHAcn/w9XuvFEMQNSq39X5gnPhZ6eRTImkAJSYKzqJ4FUM?=
 =?us-ascii?Q?ogKA3Sdil1XjZj9Qlqjuzs8FgAx5Jf96BcFud73LaFeEpc7+VK5BCCUDIDt2?=
 =?us-ascii?Q?teIsu6Tg/6iLiZ92/wmZy9i5h3hgnM0gRVgdAanUHlyQZcbpysMXEMB3F/Dr?=
 =?us-ascii?Q?hHCruJgtUg9HxkPhrJTSrqAEOg3Fuxu5n6yLnKa+YLEWv4OT62GCfRF3gCEP?=
 =?us-ascii?Q?SUKKVDBNQU48+N+RBJx9wL9oIiGprVJxVuMihPrXzsBAw/clm7R6+dUppnbL?=
 =?us-ascii?Q?HKcAcbT7bwuulYuZo3bysl3Qux0xHMMumPGHp+nnFccXUtK9HRkkNEwj3hmv?=
 =?us-ascii?Q?d2lofWGNXqYPEWDQz3FtBY3ULAa6MKxYjaEMG3kq/SAv7+dBoadNY8VJ8ifw?=
 =?us-ascii?Q?LJBOi1uLwa3yG93PEj5Cv4T7FRUdvsyekjWD8FAvYymM6hAGXhozjheKTxdH?=
 =?us-ascii?Q?yaOzrkrLuyE6pTl3zcgps4x/kZpWZEuA8JmuTG1+psQfX1ISm9tSNY6kCTet?=
 =?us-ascii?Q?U8vYMNNVtGRR7m0dc/Sry+gmeTiOpED6RJMvJzyX8efWhTEmsw5pbjpw/yBG?=
 =?us-ascii?Q?ysSyERURpKbmLwpQZfj6J7DZf1TJJJu6k5DTwY2h9iEcLRUR6VC8mrHPZ/Fs?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 657a9cd2-f084-4c71-c387-08dd456aea12
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:26:05.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1AgRbgetZWkuAYxjso4U++ikEI8JAi5Lic8tN3j9eVNB/CxW2o85hXiwYXwSYugMsezpD4D9bu8QEFF5BPxTBUpIc0Zac6w2oC5E0RU0/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 3 Feb 2025 17:43:38 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > [..]
> > > > > > I think it's fine to let userspace see that exclusive features are
> > > > > > present, just need to return EBUSY if userspace actually tries to use
> > > > > > them.    
> > > > > 
> > > > > To me, a poke it and see interface is really ugly.    
> > > > 
> > > > That smells more like a matter of documentation. "Doctor it hurts when I
> > > > try to use the documented kernel-exclusive commands?"  
> > > 
> > > To me this is a nasty interface design.
> > > If I'm writing a tool to enumerate what is exposed etc then it will
> > > have to poke every get command just to list if an interface is available.
> > > Hopefully none of them have side effects!  
> > 
> > The kernel exclusive list is documented. How did this tool get written
> > in such a way to understand how to get data out of the interface but
> > without reading the documentation on how to consume that data?
> 
> Today's kernel exclusive list is documented.  Kind of tricky to know what
> is on that list in a few years time.

I expect new software for new capabilities considers new documentation.

[..]
> > What breaks if software treats those bits as Reserved0? What breaks if
> > software ignores bit9?
> 
> More generally we can't assume it doesn't happen if those bits are 0.
> In this particular case perhaps it doesn't matter.
> 
> Hmm. The aim is to decide if the permissions DEBUG_WRITE is enough.
> 
> We have already verified it doesn't happen immediately. So now
> the question is does it result in a change conventional reset.
> 
> Without bit 9 we have no idea either way.  So question is do
> we assume it does, or assume it doesn't?

If bit10 is set, assume it does, otherwise not, but as you say below,
does any of this matter once immediate config change effects are
accounted?

I think no.

> 
> +	/* These effects supported for all scope */
> +	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
> +	     (effects & CXL_CMD_EFFECTS_EXTEND &&
> +	      (effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
> +	       effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET))) &&
> +	    scope >= FWCTL_RPC_DEBUG_WRITE)
> +		return true;
> +
> +	return false;
> 
> Right now we return false if it was conventional reset but
> we don't know that because the hardware doesn't say either way.
>
> I'm stuck on what the right thing to do is.  My assumption
> is that cold reset will always apply if conv or cxl reset
> do. So maybe who cares and we shouldn't check these two
> at all?

That's true, if the security policy is that reset based configuration
changes are always ok, then bits [0, 9:11] do not matter.

> Fun corner: there must be something that causes an effect
> to happen (or in what sense is this a 'set') and if we have
> excluded everything else maybe we should assume that
> it must be one of these two resets?

Yes, fun. "What exactly did this effectless 'Set' do?". I think I would
be ok with blocking "effectless" Set just to make the device commit to
a security model for all of its 'Set'-able Features.

> > > There may be corner cases where the right answer if we know the
> > > feature is not persisted over a reset but instead panic or take
> > > some heavy weight action. Same can be true the other way around
> > > in that we may have to do something heavy to manually reset something
> > > we don't want to persist over reset. Hopefully not but we'll see.  
> > 
> > ...but how is that relevant to the FWCTL use case which just wants to
> > know if the operation is going to have an immediate effect that changes
> > a parameter behind the kernel's back?
> 
> In that case, should we just let everything through and not check for
> cold reset either?

I think so, yes. Filter the known problematic effects for live changes,
and require the device to claim at least one of [0:5, 10:11] in its
effects, and filter Features that claim [12:15] effects for now.
