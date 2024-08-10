Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B453C062
	for <linux-cxl@vger.kernel.org>; Sat, 10 Aug 2024 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257359; cv=fail; b=B5nxt0Lw/LqQ92vXb7/K5PNbDFoMNW4I4laABkGSVBqXAtYfR9j7rXHOZ/0BLsP4cElAT/jM9tm9rVaTINYMuH5IkQz9ZUdso++Eg4oLma4acC4KLFgU4BOZFSPAnohHpkcaAD4/lx/Sqv0PjJp2m8v2D1wUpmLQk9ezHX40I+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257359; c=relaxed/simple;
	bh=HODb0Dbz+5TW4hwuYu/+VSal73SZWjFwKDFfMLc+phU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PIqKZKAMYgKjB8VIpK2cJFlski/9Mhk4nRFwI7csKdnjb+O6LK7lGekP1hlFcucHkBjp1uHFN/dAZHpYeAvjqaI87vGAfTU7P1jUSpGggzLwKZ9vKdJtme442IUyl3nD9mC1HitQrWkiMuw173ApdxjGbDuqzjpzN34Uw+9RbUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hz4dsoRh; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hz4dsoRh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723257340; x=1754793340;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HODb0Dbz+5TW4hwuYu/+VSal73SZWjFwKDFfMLc+phU=;
  b=Hz4dsoRhUdY4YBBOvk37KjhtTp/bFwxdSDeJzRugMrOjP0UQZu4tsNBV
   2kRPqb6wa/TdOwoPDL8WqRjQ76pOccI8Kit7WotAMElthPZ+IaMvg0Rle
   a+kLMv7eGj2auUhQxl9iEWx+n4z0nhqvsHl2+TGE9kQhA+MVygHSeXYIn
   GvLT3Ebi7gr3tkaSKsoIABRgBa0lOu5mjeeGAYnraft+L8kzLYTL1qJqM
   O3eJtFzQXMuqgYcb6FooaRFx1D8ShtOyKSd4/kHMLdW4fnrocY782waZU
   Yk1D6q0JO51msFss+vDFXY6iWJ83SG97H04V8qOOlg/fi8hFm1YQC8U0H
   Q==;
X-CSE-ConnectionGUID: GvD0SZ67QRa4W6sw+vUi1A==
X-CSE-MsgGUID: TPPLooYYR0y5+o2CW3IAfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21573366"
X-IronPort-AV: E=Sophos;i="6.09,278,1716274800"; 
   d="log'?scan'208";a="21573366"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 19:35:38 -0700
X-CSE-ConnectionGUID: qlDTA7IRSSiC6bhBhlUJFA==
X-CSE-MsgGUID: 4M6CX8g0SaGLORSGoSirlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,278,1716274800"; 
   d="log'?scan'208";a="58452057"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 19:35:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 19:35:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 19:35:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 19:35:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvIKbjfisOY6LrtXy1UUXSQ0faexrYNgW/IkiPKMAv5KFHxH7vJAv3rv4+0ypN61LaG6RewBhRJwPgnvV6iCtzjUhvMq/blJE4/JPiQpN0QVUgykMfieL5hWY8va1WEBWj/EAR6+HDJHmRSRKvojnWz2WYKkgBv9ll48A9cq2lWMTeKRB9v3UcvkO0RvkfTFDnV6cHlf1mKL6ZcBmtKTQJyIjnM08GM70rezOZNmm/EOwZva+MlJBDCLIW16My7Y/tWi4OzFlpT35IFCXUpj01PabXj02g13mHce9eKCSR04ziRlY4b+GbuKihrhiFHVQVGbTDDha6Rv5mwpWwrqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4TWH3bMoqSTBLqWrEEE4QqXu9I0LLMxXyHyHjnjxNc=;
 b=wRCMehoEIiIISaWm84/TZCaTrCcUz093oUasBxQ61i77l9O/HiDF8Krp1TZfExoo0H72WbL+QgldsB4ojAjfhHXM5SL0u/EnJLKruQftGsfWW2yP5nyJKYfjMeNxc4Z8MeSmKuOBsF+v2EVUGKIou25n3Bk8H9tND1+sMVmXIvzLsgOqb4YS9MLrds0RMHFilPTynt5VxdvSaRBYdSBuVOS9NrkNPdmRHIThrrd80mUcVBCxImJnimrdtk6m+yiDsFA8EZG8NPHkxINIG5aw9/DurDmoqfWPryqaC6GR3BN9ET4kKn4yNYi/55egFkZlrxnmRJRwfeP+nsjGFoA4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Sat, 10 Aug
 2024 02:35:33 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.023; Sat, 10 Aug 2024
 02:35:33 +0000
Date: Sat, 10 Aug 2024 10:36:25 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Li Ming <ming4.li@intel.com>
CC: <linux-cxl@vger.kernel.org>, <rrichter@amd.com>, <terry.bowman@amd.com>,
	<dan.j.williams@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/2] cxl/test: Skip cxl_setup_parent_dport() for
 emulated dports
Message-ID: <ZrbSKZ70vXlXCU8E@xpf.sh.intel.com>
References: <20240809082750.3015641-1-ming4.li@intel.com>
 <20240809082750.3015641-3-ming4.li@intel.com>
Content-Type: multipart/mixed; boundary="1DvYohVG7jZAx/go"
Content-Disposition: inline
In-Reply-To: <20240809082750.3015641-3-ming4.li@intel.com>
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|IA1PR11MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5c0cdf-7b5a-4b9c-2fb7-08dcb8e51b53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R78Co9twwaHEepQ0WQy8IIrxo1HU0qH2yDto8D2x3/xPnLdTisNbAzHPPwgt?=
 =?us-ascii?Q?ruwQI4V97Jsz2xAERwJiY8Oto67SaV46mm6OF9bfQDlf7oVA7Lw2Bie99E6q?=
 =?us-ascii?Q?2pg5ftM5MtL1af7s/XzzBrByffuObr7NHGNKHnxOYiWeTREUYslu79fUsrZK?=
 =?us-ascii?Q?nlJQSsTWyWvSf8PZWKPgRM5bChUdoEza1pJwHFqGMHxDEKqmOlDmo1hE9F0v?=
 =?us-ascii?Q?49GmzZx91W7GV8vVwhv+JesZJSRFBwTqXOhi2ghAbL4X0E0JG2AQJUnjasQh?=
 =?us-ascii?Q?pjQLr8PEbtoTCVV7BovEQeIgo6TyaZ/AkHN0TnkNew552ieQZUsIGvVifctA?=
 =?us-ascii?Q?ZUXVMo4M6T6Zxg0SpolVv92OwOWOTdQsZ2uXFqrN6tF6uYPu2zUW+4UaALsN?=
 =?us-ascii?Q?L/NVJjfA9QBs4jJYhDapJlJN01+lsK48Y4OsCqnTA0rm3240YBuq684kn5eA?=
 =?us-ascii?Q?kgZYP3hOJYReRsSwY0nM1KfmdUTGQ1tTIraH6NT0FOBi0jNSc3Vdwjt+sw1w?=
 =?us-ascii?Q?brn7dKZjTfreha9TLz3fkmvxw4Ki8v8BvHlDE4VhH9OLY5VjvnQjHqUaTqyL?=
 =?us-ascii?Q?xrKtZngLre2atd7ZSOYEJx9978pw6worLJQfQFyhivttxtxIlWiZ+3Yrwycj?=
 =?us-ascii?Q?t+71g1HhijRpdBdljABAGZqbTF4z9vNUu36bdvmDbp84CgOMX6UheFRyn7RV?=
 =?us-ascii?Q?jtVi2ngqaAVc+TqK6E8dzDcSf7xdgBryigJCxguIxnWqyUHu17pIa5Q/9chZ?=
 =?us-ascii?Q?Ei/H8zbY76Q3tuIxQVuWdtHYG0VFjmXbUHR54e9aSYeWgCHBQWRpYZ6fnydf?=
 =?us-ascii?Q?UdV2BIDkWgF5AJy7ASZv7pl2M36whrpFPnIDLFnRegA9Dgxqc3238zFz4Can?=
 =?us-ascii?Q?Cy83Uxi9DVkscnO6TpCXWv6R7qTJEJdAmfx140SbbnC5R53SLx8J7x2pGLtD?=
 =?us-ascii?Q?HNHyt8V52sLA5IF8sEfg6INpkrQsUrQW5axk1v5i7C93TcjgS580/ig8J8Bf?=
 =?us-ascii?Q?n6VsM8Xr29BJ3+hktv5Wd0t6PYVixiN3fbvljUiAGfsP6ERhTHR09ehEAQVv?=
 =?us-ascii?Q?HVb+hY9KHiNEBCnzckRxWJkU5u5B6mg7KhzvzfVSobacYAC3zVepUb5SCIyz?=
 =?us-ascii?Q?PyhzU0h7z+1iI3un/mlVtmNVbmw4eXjaO7DnCWZCcAjdO6NLqQtP1tBtyWQU?=
 =?us-ascii?Q?qxJC6z++6BsCdHY0j5ZHhe3H4RfBhzpkf9dX4e9F74B0rpFwIk5M41R8wYM2?=
 =?us-ascii?Q?/IuAqNKIRS+W5FB7bi+uPSreB8aY1fXss16MQBZtxu9Ec9Eblzlv59PMAwxf?=
 =?us-ascii?Q?R9I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QvOnFYi6+mM7S9kh2eGEGgHBnr+1f48wbb3cUgSUYK2te7ZtNDp5q9QPNwpG?=
 =?us-ascii?Q?uq/mShygfUKyMJay8tzZJR2A6L9ivSvyDy2SPgeEmeGZl1xgracUYI9sRCBL?=
 =?us-ascii?Q?MBPXMM8CMe608U8D9R65YHO8lvwqDnnUJ79AyeJSyaep4bpo22zW34mW/9U2?=
 =?us-ascii?Q?mSof68IBEMv/iiwwFLgW9GtOuw097t7jV/uNaMs0zP5mdh5XfP3vyLL++2t2?=
 =?us-ascii?Q?pfSuwbgE4vI6DcNdZ60teKNOCGPDGMNVfCj5Jj7IzJ+lVEFZjxfnUivw+r4Q?=
 =?us-ascii?Q?JFKohsdXxYKI1vhteDLegShWZEmrAUoOfmNU5FwN5Nvm1a+HJecdQs+rq1A6?=
 =?us-ascii?Q?vfmNiyfMcWKiudBQHz81FajquggZQoYi/Yi9VW/Qv6+Slc2ZvUX/axcA/GUL?=
 =?us-ascii?Q?9/CFNovsC2kZ9hJ3bhGmZf30fa2mCRJXa7CzLPhnmOIsxkZYPoYCuFEijtBD?=
 =?us-ascii?Q?sQwaKUeynskDjp+NZKGOqJjeWKkwGZYkPTRRj3uIZqncHloXNGrOvCQQ3VNt?=
 =?us-ascii?Q?C+ZTPDmYvLeUjMqiOsgWa85QKDJTP4OLgtKHABC0lr6F+D341xGVw4ifnw5E?=
 =?us-ascii?Q?UTD9sQLobvyGsIcebeuK4d8ueR0UrAtcTJIj3lJ5zw9Db+NKphidZarAyqx6?=
 =?us-ascii?Q?mjMMT0twKdTWBIJFpj43+6OAXvhnUZmffEJ9TRLheG0/ju/oSMWZoYGHiwvI?=
 =?us-ascii?Q?u4T6jJR6R+RePPHiQquBU6UzTldiV2FHKg98EeC2tFkdrym3HPWCb+6j5bO/?=
 =?us-ascii?Q?BrD2mqUiCtFo4HLS9s+4S9KhO/m4mP0Tsbm35zcTPEp7MTUyVYYT5HWxHcdh?=
 =?us-ascii?Q?5roVlHu9SdRb8AJlBBPK4rUXzj8AF3GZdIxDDxw3ISC6kyM1gATaNN5DfxwD?=
 =?us-ascii?Q?TNQT9h8S6+f/bWEXFsVmVJ8ovZND6os2MIgV4ZHcPyUheYLlEA2p9WEGAWzg?=
 =?us-ascii?Q?QYsjcTbuWDjXzEhQDGcrHVBhWJ8YTp1niuBAdeYw28T54GzglR4uTKfM1LmR?=
 =?us-ascii?Q?EaVE/P2kgM/AcCYSvqRY17RK8orqti41v45ppzd5zbRQqAD+xXe4/q4CZlnQ?=
 =?us-ascii?Q?wrcQrjM0y5ZLVQiSMrv8or2TDmsqFWZTcgLHIVyO7LXXjmmh3N40CAVLicP5?=
 =?us-ascii?Q?deEzYtNR8+x5BJrvrHU8QrpHJ80iPgsH6VwmdhXdglLhiPUlkw0Kvnek4ak4?=
 =?us-ascii?Q?3IwWZjeDl3kyl1ldEqZNFwU8dwkRnrR9+vhQUM6NMKupxo+SfM1xD4YeHTbk?=
 =?us-ascii?Q?/VYPGUIY9nFFAtEjejahzLcPHT68qAAocwlHJBtwbJTsiIwJJR6xWcL729Qe?=
 =?us-ascii?Q?sm9KAvDRrDG4Z3o5Eb0xmwQ99E6EyG1jWpjRP+J4TwMzyDQua8YKTffLKgmh?=
 =?us-ascii?Q?Gg1LOUDyd8c2gr8gZ/wOa7xJaliSjCxV6lPNhbcWwIR6m2IJdvZ8E3GCLBZ9?=
 =?us-ascii?Q?zZAq5VXosZ2T/fMO7QB2vu0ttID7nrX09peRv/6bLui6nBsrNMldm70XlLbU?=
 =?us-ascii?Q?UMs67n7AHikUmI66tN6q/0PODMuqv0L7f7rYDA+4Ve2cD4H9EBAiOAxEKg9L?=
 =?us-ascii?Q?8Cjybkcbd+6HyRKat9O9kjmWDb1m8eHmHWT5VIJl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5c0cdf-7b5a-4b9c-2fb7-08dcb8e51b53
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 02:35:33.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6q+ja7Ulra0zE2K39hXXN7ePeUmq2cdKmcBsJvA1fb+xUJtDaaijwdFj+cO0gvbODxWBcg3booOVK7gbQpEbwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8152
X-OriginatorOrg: intel.com

--1DvYohVG7jZAx/go
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Ming,

Teseted all these 2 patches on top of v6.11-rc2.
No "slab-out-of-bounds in cxl_setup_parent_dport" issue in cxl_test qemu env.
And tested cxl_test without issue:

"
# meson test -C build --suite=cxl
ninja: Entering directory `/root/ndctl_weiny/build'
[1/48] Generating version.h with a custom command
 1/11 ndctl:cxl / cxl-topology.sh               OK              25.70s
 2/11 ndctl:cxl / cxl-region-sysfs.sh           OK              23.57s
 3/11 ndctl:cxl / cxl-labels.sh                 OK              23.12s
 4/11 ndctl:cxl / cxl-create-region.sh          OK              32.80s
 5/11 ndctl:cxl / cxl-xor-region.sh             OK              13.92s
 6/11 ndctl:cxl / cxl-events.sh                 OK               7.89s
 7/11 ndctl:cxl / cxl-sanitize.sh               OK              10.99s
 8/11 ndctl:cxl / cxl-destroy-region.sh         OK              11.67s
 9/11 ndctl:cxl / cxl-qos-class.sh              OK              11.34s
10/11 ndctl:cxl / cxl-dcd.sh                    SKIP             6.21s   exit status 77
11/11 ndctl:cxl / cxl-security.sh               OK               3.91s

Ok:                 10  
Expected Fail:      0   
Fail:               0   
Unexpected Pass:    0   
Skipped:            1   
Timeout:            0   

Full log written to /root/ndctl_weiny/build/meson-logs/testlog.txt
"
It's fixed.
Dmesg is in attached.

Best Regards,
Thanks!

On 2024-08-09 at 08:27:50 +0000, Li Ming wrote:
> The cxl_test unit test environment on qemu always hits below call trace
> with KASAN enabled:
> 
>  BUG: KASAN: slab-out-of-bounds in cxl_setup_parent_dport+0x480/0x530 [cxl_core]
>  Read of size 1 at addr ff110000676014f8 by task (udev-worker)/676[   24.424403] CPU: 2 PID: 676 Comm: (udev-worker) Tainted: G           O     N 6.10.0-qemucxl #1
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-2.el9 02/14/2024
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0xea/0x150
>   print_report+0xce/0x610
>   ? kasan_complete_mode_report_info+0x40/0x200
>   kasan_report+0xcc/0x110
>   __asan_report_load1_noabort+0x18/0x20
>   cxl_setup_parent_dport+0x480/0x530 [cxl_core]
>   cxl_mem_probe+0x49b/0xaa0 [cxl_mem]
> 
> cxl_test module models a CXL topology for testing, it creates some
> emulated dports with platform devices in the CXL topology, so the
> dport_dev of an emulated dport points to a platform device rather than a
> pci device or a pci host bridge in the case. Currently,
> cxl_setup_parent_dport() is used to set up RAS and AER capability on the
> dport connected to the CXL memory device, but cxl_test does not support
> RAS or AER functionality yet, so the fix is implementing a
> __wrap_cxl_setup_parent_dport() to filter out all emulated dports,
> guarantees only real dports can be handled by cxl_setup_parent_dport().
> 
> Fixes: f05fd10d138d ("cxl/pci: Add RCH downstream port AER register discovery")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Closes: https://lore.kernel.org/linux-cxl/ZrHTBp2O+HtUe6kt@xpf.sh.intel.com/T/#t
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  tools/testing/cxl/Kbuild      |  1 +
>  tools/testing/cxl/test/mock.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 030b388800f0..3d1ca9e38b1f 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -14,6 +14,7 @@ ldflags-y += --wrap=cxl_dvsec_rr_decode
>  ldflags-y += --wrap=devm_cxl_add_rch_dport
>  ldflags-y += --wrap=cxl_rcd_component_reg_phys
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
> +ldflags-y += --wrap=cxl_setup_parent_dport
>  
>  DRIVERS := ../../../drivers
>  CXL_SRC := $(DRIVERS)/cxl
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 6f737941dc0e..d619672faa49 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -299,6 +299,18 @@ void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_endpoint_parse_cdat, CXL);
>  
> +void __wrap_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
> +{
> +	int index;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +
> +	if (!ops || !ops->is_mock_port(dport->dport_dev))
> +		cxl_setup_parent_dport(host, dport);
> +
> +	put_cxl_mock_ops(index);
> +}
> +EXPORT_SYMBOL_NS_GPL(__wrap_cxl_setup_parent_dport, CXL);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(ACPI);
>  MODULE_IMPORT_NS(CXL);
> -- 
> 2.40.1
> 

--1DvYohVG7jZAx/go
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="v6.11-rc2_cxlfix_dmesg.log"

[    0.000000] Linux version 6.11.0-rc2-cxlfix-dirty (root@gnr-800442) (gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-48.el9) #1 SMP PREEMPT_DYNAMIC Sat Aug 10 10:00:21 CST 2024
[    0.000000] Command line: selinux=0 audit=0 console=tty0 console=ttyS0 root=/dev/sda2 ignore_loglevel rw memory_hotplug.memmap_on_memory=force cxl_acpi.dyndbg=+fplm cxl_pci.dyndbg=+fplm cxl_core.dyndbg=+fplm cxl_mem.dyndbg=+fplm cxl_pmem.dyndbg=+fplm cxl_port.dyndbg=+fplm cxl_region.dyndbg=+fplm cxl_test.dyndbg=+fplm cxl_mock.dyndbg=+fplm cxl_mock_mem.dyndbg=+fplm memmap=2G!4G efi_fake_mem=2G@6G:0x40000 initrd=initrd
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/split lock detection: #DB: warning on user-space bus_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000007fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000800000-0x0000000000807fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000808000-0x000000000080afff] usable
[    0.000000] BIOS-e820: [mem 0x000000000080b000-0x000000000080bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000080c000-0x000000000080ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000810000-0x00000000008fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000900000-0x000000007f06ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f070000-0x000000007f130fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007f131000-0x000000007f6ecfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f6ed000-0x000000007f96cfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007f96d000-0x000000007f97efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007f97f000-0x000000007f9fefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007f9ff000-0x000000007febbfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007febc000-0x000000007ff3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007ff40000-0x000000007fffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x7bf94018-0x7bf9da57] usable ==> usable
[    0.000000] e820: update [mem 0x7bf6d018-0x7bf93e57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000007fffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000800000-0x0000000000807fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000000808000-0x000000000080afff] usable
[    0.000000] reserve setup_data: [mem 0x000000000080b000-0x000000000080bfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000000080c000-0x000000000080ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000810000-0x00000000008fffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000000900000-0x000000007bf6d017] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf6d018-0x000000007bf93e57] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf93e58-0x000000007bf94017] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf94018-0x000000007bf9da57] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf9da58-0x000000007f06ffff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f070000-0x000000007f130fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f131000-0x000000007f6ecfff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f6ed000-0x000000007f96cfff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f96d000-0x000000007f97efff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007f97f000-0x000000007f9fefff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007f9ff000-0x000000007febbfff] usable
[    0.000000] reserve setup_data: [mem 0x000000007febc000-0x000000007ff3ffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007ff40000-0x000000007fffffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000017fffffff] persistent (type 12)
[    0.000000] reserve setup_data: [mem 0x0000000180000000-0x000000027fffffff] usable
[    0.000000] user-defined physical RAM map:
[    0.000000] user: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] user: [mem 0x0000000000100000-0x00000000007fffff] usable
[    0.000000] user: [mem 0x0000000000800000-0x0000000000807fff] ACPI NVS
[    0.000000] user: [mem 0x0000000000808000-0x000000000080afff] usable
[    0.000000] user: [mem 0x000000000080b000-0x000000000080bfff] ACPI NVS
[    0.000000] user: [mem 0x000000000080c000-0x000000000080ffff] usable
[    0.000000] user: [mem 0x0000000000810000-0x00000000008fffff] ACPI NVS
[    0.000000] user: [mem 0x0000000000900000-0x000000007bf6d017] usable
[    0.000000] user: [mem 0x000000007bf6d018-0x000000007bf93e57] usable
[    0.000000] user: [mem 0x000000007bf93e58-0x000000007bf94017] usable
[    0.000000] user: [mem 0x000000007bf94018-0x000000007bf9da57] usable
[    0.000000] user: [mem 0x000000007bf9da58-0x000000007f06ffff] usable
[    0.000000] user: [mem 0x000000007f070000-0x000000007f130fff] reserved
[    0.000000] user: [mem 0x000000007f131000-0x000000007f6ecfff] usable
[    0.000000] user: [mem 0x000000007f6ed000-0x000000007f96cfff] reserved
[    0.000000] user: [mem 0x000000007f96d000-0x000000007f97efff] ACPI data
[    0.000000] user: [mem 0x000000007f97f000-0x000000007f9fefff] ACPI NVS
[    0.000000] user: [mem 0x000000007f9ff000-0x000000007febbfff] usable
[    0.000000] user: [mem 0x000000007febc000-0x000000007ff3ffff] reserved
[    0.000000] user: [mem 0x000000007ff40000-0x000000007fffffff] ACPI NVS
[    0.000000] user: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] user: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] user: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] user: [mem 0x0000000100000000-0x000000017fffffff] persistent (type 12)
[    0.000000] user: [mem 0x0000000180000000-0x000000027fffffff] usable
[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: SMBIOS=0x7f788000 SMBIOS 3.0=0x7f786000 ACPI=0x7f97e000 ACPI 2.0=0x7f97e014 MEMATTR=0x7c17a698 INITRD=0x7c051f98 
[    0.000000] efi: Remove mem128: MMIO range=[0xffc00000-0xffffffff] (4MB) from e820 map
[    0.000000] e820: remove [mem 0xffc00000-0xffffffff] reserved
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-2.el9 02/14/2024
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000003] kvm-clock: using sched offset of 8928947080 cycles
[    0.000011] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000039] tsc: Detected 2500.000 MHz processor
[    0.000177] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000193] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000232] last_pfn = 0x280000 max_arch_pfn = 0x10000000000
[    0.000275] MTRR map: 4 entries (2 fixed + 2 variable; max 18), built from 8 variable MTRRs
[    0.000287] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000343] last_pfn = 0x7febc max_arch_pfn = 0x10000000000
[    0.010001] Using GB pages for direct mapping
[    0.028727] Secure boot disabled
[    0.028734] RAMDISK: [mem 0x6051a000-0x6b826fff]
[    0.028762] ACPI: Early table checksum verification disabled
[    0.028774] ACPI: RSDP 0x000000007F97E014 000024 (v02 BOCHS )
[    0.028793] ACPI: XSDT 0x000000007F97D0E8 00007C (v01 BOCHS  BXPC     00000001      01000013)
[    0.028821] ACPI: FACP 0x000000007F979000 0000F4 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.028849] ACPI: DSDT 0x000000007F97A000 002FD7 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.028868] ACPI: FACS 0x000000007F9DC000 000040
[    0.028884] ACPI: APIC 0x000000007F978000 0000B0 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.028903] ACPI: HPET 0x000000007F977000 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.028922] ACPI: SRAT 0x000000007F976000 000218 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.028941] ACPI: SLIT 0x000000007F975000 000050 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.028960] ACPI: MCFG 0x000000007F974000 00003C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.028979] ACPI: SSDT 0x000000007F973000 0008A1 (v01 BOCHS  NVDIMM   00000001 BXPC 00000001)
[    0.028998] ACPI: NFIT 0x000000007F972000 000198 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.029017] ACPI: CEDT 0x000000007F971000 0000B8 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.029035] ACPI: WAET 0x000000007F970000 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.029055] ACPI: BGRT 0x000000007F96F000 000038 (v01 INTEL  EDK2     00000002      01000013)
[    0.029072] ACPI: Reserving FACP table memory at [mem 0x7f979000-0x7f9790f3]
[    0.029079] ACPI: Reserving DSDT table memory at [mem 0x7f97a000-0x7f97cfd6]
[    0.029086] ACPI: Reserving FACS table memory at [mem 0x7f9dc000-0x7f9dc03f]
[    0.029093] ACPI: Reserving APIC table memory at [mem 0x7f978000-0x7f9780af]
[    0.029100] ACPI: Reserving HPET table memory at [mem 0x7f977000-0x7f977037]
[    0.029107] ACPI: Reserving SRAT table memory at [mem 0x7f976000-0x7f976217]
[    0.029114] ACPI: Reserving SLIT table memory at [mem 0x7f975000-0x7f97504f]
[    0.029121] ACPI: Reserving MCFG table memory at [mem 0x7f974000-0x7f97403b]
[    0.029128] ACPI: Reserving SSDT table memory at [mem 0x7f973000-0x7f9738a0]
[    0.029135] ACPI: Reserving NFIT table memory at [mem 0x7f972000-0x7f972197]
[    0.029142] ACPI: Reserving CEDT table memory at [mem 0x7f971000-0x7f9710b7]
[    0.029149] ACPI: Reserving WAET table memory at [mem 0x7f970000-0x7f970027]
[    0.029155] ACPI: Reserving BGRT table memory at [mem 0x7f96f000-0x7f96f037]
[    0.029408] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.029416] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.029422] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.029429] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.029435] SRAT: PXM 1 -> APIC 0x04 -> Node 1
[    0.029441] SRAT: PXM 1 -> APIC 0x05 -> Node 1
[    0.029447] SRAT: PXM 1 -> APIC 0x06 -> Node 1
[    0.029453] SRAT: PXM 1 -> APIC 0x07 -> Node 1
[    0.029465] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.029474] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
[    0.029483] ACPI: SRAT: Node 1 PXM 1 [mem 0x100000000-0x17fffffff]
[    0.029493] ACPI: SRAT: Node 2 PXM 2 [mem 0x180000000-0x1ffffffff]
[    0.029502] ACPI: SRAT: Node 3 PXM 3 [mem 0x200000000-0x27fffffff]
[    0.029511] ACPI: SRAT: Node 4 PXM 4 [mem 0x280000000-0x63fffffff] non-volatile
[    0.029521] ACPI: SRAT: Node 5 PXM 5 [mem 0x640000000-0x9ffffffff] non-volatile
[    0.029531] ACPI: SRAT: Node 5 PXM 5 [mem 0x280000000-0xb803fffff] hotplug
[    0.029560] NUMA: Initialized distance table, cnt=6
[    0.029586] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0x7fffffff] -> [mem 0x00000000-0x7fffffff]
[    0.029639] NODE_DATA(0) allocated [mem 0x7fdb3000-0x7fdddfff]
[    0.029687] NODE_DATA(2) allocated [mem 0x1fffd5000-0x1ffffffff]
[    0.030096] NODE_DATA(3) allocated [mem 0x27ffd2000-0x27fffcfff]
[    0.031864] Zone ranges:
[    0.031874]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.031888]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.031897]   Normal   [mem 0x0000000100000000-0x000000027fffffff]
[    0.031906]   Device   empty
[    0.031912] Movable zone start for each node
[    0.031926] Early memory node ranges
[    0.031929]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.031937]   node   0: [mem 0x0000000000100000-0x00000000007fffff]
[    0.031944]   node   0: [mem 0x0000000000808000-0x000000000080afff]
[    0.031951]   node   0: [mem 0x000000000080c000-0x000000000080ffff]
[    0.031958]   node   0: [mem 0x0000000000900000-0x000000007f06ffff]
[    0.031965]   node   0: [mem 0x000000007f131000-0x000000007f6ecfff]
[    0.031972]   node   0: [mem 0x000000007f9ff000-0x000000007febbfff]
[    0.031979]   node   2: [mem 0x0000000180000000-0x00000001ffffffff]
[    0.031987]   node   3: [mem 0x0000000200000000-0x000000027fffffff]
[    0.031997] Initmem setup node 0 [mem 0x0000000000001000-0x000000007febbfff]
[    0.032032] Initmem setup node 1 as memoryless
[    0.032039] Initmem setup node 2 [mem 0x0000000180000000-0x00000001ffffffff]
[    0.032053] Initmem setup node 3 [mem 0x0000000200000000-0x000000027fffffff]
[    0.032081] Initmem setup node 4 as memoryless
[    0.032105] Initmem setup node 5 as memoryless
[    0.032130] Initmem setup node 6 as memoryless
[    0.032160] Initmem setup node 7 as memoryless
[    0.032189] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.032305] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.032315] On node 0, zone DMA: 8 pages in unavailable ranges
[    0.032322] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.032488] On node 0, zone DMA: 240 pages in unavailable ranges
[    0.058514] On node 0, zone DMA32: 193 pages in unavailable ranges
[    0.058812] On node 0, zone DMA32: 786 pages in unavailable ranges
[    0.090102] On node 2, zone Normal: 324 pages in unavailable ranges
[    0.354711] kasan: KernelAddressSanitizer initialized
[    0.355044] ACPI: PM-Timer IO Port: 0x608
[    0.355094] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.355178] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.355200] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.355211] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.355220] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.355228] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.355237] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.355257] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.355263] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.355302] e820: update [mem 0x7c053000-0x7c05bfff] usable ==> reserved
[    0.355361] TSC deadline timer available
[    0.355375] CPU topo: Max. logical packages:   2
[    0.355379] CPU topo: Max. logical dies:       2
[    0.355383] CPU topo: Max. dies per package:   1
[    0.355396] CPU topo: Max. threads per core:   2
[    0.355401] CPU topo: Num. cores per package:     2
[    0.355405] CPU topo: Num. threads per package:   4
[    0.355409] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.355482] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
[    0.355533] kvm-guest: KVM setup pv remote TLB flush
[    0.355540] kvm-guest: setup PV sched yield
[    0.355704] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.355719] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.355733] PM: hibernation: Registered nosave memory: [mem 0x00800000-0x00807fff]
[    0.355748] PM: hibernation: Registered nosave memory: [mem 0x0080b000-0x0080bfff]
[    0.355762] PM: hibernation: Registered nosave memory: [mem 0x00810000-0x008fffff]
[    0.355777] PM: hibernation: Registered nosave memory: [mem 0x7bf6d000-0x7bf6dfff]
[    0.355792] PM: hibernation: Registered nosave memory: [mem 0x7bf93000-0x7bf93fff]
[    0.355798] PM: hibernation: Registered nosave memory: [mem 0x7bf94000-0x7bf94fff]
[    0.355814] PM: hibernation: Registered nosave memory: [mem 0x7bf9d000-0x7bf9dfff]
[    0.355829] PM: hibernation: Registered nosave memory: [mem 0x7c053000-0x7c05bfff]
[    0.355844] PM: hibernation: Registered nosave memory: [mem 0x7f070000-0x7f130fff]
[    0.355860] PM: hibernation: Registered nosave memory: [mem 0x7f6ed000-0x7f96cfff]
[    0.355865] PM: hibernation: Registered nosave memory: [mem 0x7f96d000-0x7f97efff]
[    0.355871] PM: hibernation: Registered nosave memory: [mem 0x7f97f000-0x7f9fefff]
[    0.355887] PM: hibernation: Registered nosave memory: [mem 0x7febc000-0x7ff3ffff]
[    0.355893] PM: hibernation: Registered nosave memory: [mem 0x7ff40000-0x7fffffff]
[    0.355899] PM: hibernation: Registered nosave memory: [mem 0x80000000-0xdfffffff]
[    0.355905] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.355911] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfeffbfff]
[    0.355917] PM: hibernation: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.355923] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.355929] PM: hibernation: Registered nosave memory: [mem 0x100000000-0x17fffffff]
[    0.355941] [mem 0x80000000-0xdfffffff] available for PCI devices
[    0.355948] Booting paravirtualized kernel on KVM
[    0.355959] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.356000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:8
[    0.357681] percpu: Embedded 85 pages/cpu s311296 r8192 d28672 u524288
[    0.357750] pcpu-alloc: s311296 r8192 d28672 u524288 alloc=1*2097152
[    0.357766] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7 
[    0.358071] kvm-guest: PV spinlocks enabled
[    0.358092] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.358113] Kernel command line: net.ifnames=0 selinux=0 audit=0 console=tty0 console=ttyS0 root=/dev/sda2 ignore_loglevel rw memory_hotplug.memmap_on_memory=force cxl_acpi.dyndbg=+fplm cxl_pci.dyndbg=+fplm cxl_core.dyndbg=+fplm cxl_mem.dyndbg=+fplm cxl_pmem.dyndbg=+fplm cxl_port.dyndbg=+fplm cxl_region.dyndbg=+fplm cxl_test.dyndbg=+fplm cxl_mock.dyndbg=+fplm cxl_mock_mem.dyndbg=+fplm memmap=2G!4G efi_fake_mem=2G@6G:0x40000 initrd=initrd
[    0.358315] audit: disabled (until reboot)
[    0.358473] x86/mm: Memory block size: 128MB
[    0.358484] Memory hotplug will waste 0 pages in each memory block
[    0.359030] Unknown kernel command line parameters "efi_fake_mem=2G@6G:0x40000", will be passed to user space.
[    0.359076] random: crng init done
[    0.360227] Fallback order for Node 0: 0 2 3 
[    0.360245] Fallback order for Node 1: 3 2 0 
[    0.360259] Fallback order for Node 2: 2 0 3 
[    0.360272] Fallback order for Node 3: 3 0 2 
[    0.360285] Fallback order for Node 4: 0 2 3 
[    0.360298] Fallback order for Node 5: 0 2 3 
[    0.360312] Fallback order for Node 6: 2 3 0 
[    0.360325] Fallback order for Node 7: 3 0 2 
[    0.360341] Built 4 zonelists, mobility grouping on.  Total pages: 1571215
[    0.360349] Policy zone: Normal
[    0.360357] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.360364] stackdepot: allocating hash table via alloc_large_system_hash
[    0.360384] stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
[    0.365108] software IO TLB: area num 8.
[    0.622191] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=8
[    0.622213] kmemleak: Kernel memory leak detector disabled
[    0.622482] ftrace: allocating 72130 entries in 282 pages
[    0.655832] ftrace: allocated 282 pages with 4 groups
[    0.660200] Dynamic Preempt: voluntary
[    0.661545] Running RCU self tests
[    0.661549] Running RCU synchronous self tests
[    0.661566] rcu: Preemptible hierarchical RCU implementation.
[    0.661571] rcu:     RCU lockdep checking is enabled.
[    0.661575] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.661583]  Trampoline variant of Tasks RCU enabled.
[    0.661587]  Rude variant of Tasks RCU enabled.
[    0.661591]  Tracing variant of Tasks RCU enabled.
[    0.661595] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.661601] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.661743] Running RCU synchronous self tests
[    0.661751] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.661761] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.661772] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.711854] NR_IRQS: 524544, nr_irqs: 488, preallocated irqs: 16
[    0.712706] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.713278] Console: colour dummy device 80x25
[    0.713338] printk: legacy console [tty0] enabled
[    0.720245] printk: legacy console [ttyS0] enabled
[    0.959304] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.960340] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.960885] ... MAX_LOCK_DEPTH:          48
[    0.961407] ... MAX_LOCKDEP_KEYS:        8192
[    0.961977] ... CLASSHASH_SIZE:          4096
[    0.962453] ... MAX_LOCKDEP_ENTRIES:     524288
[    0.962971] ... MAX_LOCKDEP_CHAINS:      524288
[    0.963563] ... CHAINHASH_SIZE:          262144
[    0.964157]  memory used by lock dependency info: 54145 kB
[    0.964885]  memory used for stack traces: 4224 kB
[    0.965497]  per task-struct memory footprint: 1920 bytes
[    0.966424] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.967895] ACPI: Core revision 20240322
[    0.969538] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.970904] APIC: Switch to symmetric I/O mode setup
[    0.971693] x2apic enabled
[    0.972396] APIC: Switched APIC routing to: physical x2apic
[    0.972910] kvm-guest: APIC: send_IPI_mask() replaced with kvm_send_ipi_mask()
[    0.973863] kvm-guest: APIC: send_IPI_mask_allbutself() replaced with kvm_send_ipi_mask_allbutself()
[    0.975369] kvm-guest: setup PV IPIs
[    0.977270] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.978182] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x240939f1bb2, max_idle_ns: 440795263295 ns
[    0.979875] Calibrating delay loop (skipped) preset value.. 5000.00 BogoMIPS (lpj=10000000)
[    0.981208] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.982292] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.983897] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.984818] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.986038] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.987924] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on syscall and VM exit
[    0.989103] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.989939] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.991146] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.991928] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.993166] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.994403] MMIO Stale Data: Unknown: No mitigations
[    0.995989] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.997123] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.998044] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.998946] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.999904] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    1.000818] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    1.001757] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    1.002913] x86/fpu: Supporting XSAVE feature 0x20000: 'AMX Tile config'
[    1.003901] x86/fpu: Supporting XSAVE feature 0x40000: 'AMX Tile data'
[    1.004879] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    1.005810] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    1.006704] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    1.007903] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    1.008784] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    1.009639] x86/fpu: xstate_offset[17]: 2496, xstate_sizes[17]:   64
[    1.010535] x86/fpu: xstate_offset[18]: 2560, xstate_sizes[18]: 8192
[    1.011904] x86/fpu: Enabled xstate features 0x602e7, context size is 10752 bytes, using 'compacted' format.
[    1.176744] Freeing SMP alternatives memory: 56K
[    1.177217] pid_max: default: 32768 minimum: 301
[    1.209608] LSM: initializing lsm=capability,yama,ima,evm
[    1.210301] Yama: becoming mindful.
[    1.213628] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, vmalloc hugepage)
[    1.216351] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
[    1.217487] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
[    1.218803] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
[    1.223013] Running RCU synchronous self tests
[    1.223501] Running RCU synchronous self tests
[    1.224914] smpboot: CPU0: Intel GENUINE INTEL(R) XEON(R) (family: 0x6, model: 0xad, stepping: 0x0)
[    1.227266] Running RCU Tasks wait API self tests
[    1.227860] Running RCU Tasks Rude wait API self tests
[    1.227926] Running RCU Tasks Trace wait API self tests
[    1.228712] Performance Events: PEBS fmt0-, Granite Rapids events, full-width counters, Intel PMU driver.
[    1.230032] ... version:                2
[    1.230544] ... bit width:              48
[    1.231022] ... generic registers:      8
[    1.231576] ... value mask:             0000ffffffffffff
[    1.231884] ... max period:             00007fffffffffff
[    1.232492] ... fixed-purpose events:   3
[    1.233055] ... event mask:             00000007000000ff
[    1.234290] signal: max sigframe size: 11952
[    1.235010] rcu: Hierarchical SRCU implementation.
[    1.235555] rcu:     Max phase no-delay instances is 1000.
[    1.235937] Callback from call_rcu_tasks_trace() invoked.
[    1.236881] Timer migration: 1 hierarchy levels; 8 children per group; 0 crossnode level
[    1.243238] smp: Bringing up secondary CPUs ...
[    1.244784] smpboot: x86: Booting SMP configuration:
[    1.245507] .... node  #0, CPUs:      #2
[    1.247191] .... node  #1, CPUs:   #4 #6
[    1.253136] .... node  #0, CPUs:   #1 #3
[    1.256847] .... node  #1, CPUs:   #5 #7
[    1.264303] smp: Brought up 4 nodes, 8 CPUs
[    1.265277] smpboot: Total of 8 processors activated (40000.00 BogoMIPS)
[    1.268568] Memory: 4878920K/6284860K available (75776K kernel code, 14449K rwdata, 17184K rodata, 15340K init, 68224K bss, 1374024K reserved, 0K cma-reserved)
[    1.274005] devtmpfs: initialized
[    1.297795] ACPI: PM: Registering ACPI NVS region [mem 0x00800000-0x00807fff] (32768 bytes)
[    1.297795] ACPI: PM: Registering ACPI NVS region [mem 0x0080b000-0x0080bfff] (4096 bytes)
[    1.299913] ACPI: PM: Registering ACPI NVS region [mem 0x00810000-0x008fffff] (983040 bytes)
[    1.301481] ACPI: PM: Registering ACPI NVS region [mem 0x7f97f000-0x7f9fefff] (524288 bytes)
[    1.302851] ACPI: PM: Registering ACPI NVS region [mem 0x7ff40000-0x7fffffff] (786432 bytes)
[    1.305061] Running RCU synchronous self tests
[    1.305644] Running RCU synchronous self tests
[    1.305644] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.307980] futex hash table entries: 2048 (order: 6, 262144 bytes, vmalloc)
[    1.309862] pinctrl core: initialized pinctrl subsystem

[    1.311799] *************************************************************
[    1.311893] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    1.312796] **                                                         **
[    1.313700] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    1.314638] **                                                         **
[    1.315577] ** This means that this kernel is built to expose internal **
[    1.315886] ** IOMMU data structures, which may compromise security on **
[    1.316806] ** your system.                                            **
[    1.317692] **                                                         **
[    1.318638] ** If you see this message and you are not debugging the   **
[    1.319582] ** kernel, report this immediately to your vendor!         **
[    1.319886] **                                                         **
[    1.320831] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    1.321791] *************************************************************
[    1.322813] PM: RTC time: 02:18:54, date: 2024-08-10
[    1.332780] Callback from call_rcu_tasks_rude() invoked.
[    1.342481] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    1.345122] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    1.346131] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    1.347102] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    1.349956] thermal_sys: Registered thermal governor 'fair_share'
[    1.349962] thermal_sys: Registered thermal governor 'bang_bang'
[    1.350776] thermal_sys: Registered thermal governor 'step_wise'
[    1.351598] thermal_sys: Registered thermal governor 'user_space'
[    1.351987] cpuidle: using governor ladder
[    1.353230] cpuidle: using governor menu
[    1.357201] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.359179] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    1.359967] PCI: Using configuration type 1 for base access
[    1.361154] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    1.368492] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    1.371920] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    1.372691] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.373523] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    1.384838] ACPI: Added _OSI(Module Device)
[    1.385370] ACPI: Added _OSI(Processor Device)
[    1.386059] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.386566] ACPI: Added _OSI(Processor Aggregator Device)
[    1.435895] Callback from call_rcu_tasks() invoked.
[    1.454989] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    1.480727] ACPI: Interpreter enabled
[    1.481374] ACPI: PM: (supports S0 S3 S4 S5)
[    1.481882] ACPI: Using IOAPIC for interrupt routing
[    1.482823] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.483910] PCI: Ignoring E820 reservations for host bridge windows
[    1.488059] ACPI: Enabled 4 GPEs in block 00 to 3F
[    1.596962] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-34])
[    1.597767] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    1.601075] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug LTR DPC]
[    1.601667] acpi PNP0A08:00: _OSC: OS now controls [SHPCHotplug PME AER PCIeCapability]
[    1.603860] PCI host bridge to bus 0000:00
[    1.603860] pci_bus 0000:00: Unknown NUMA node; performance will be reduced
[    1.603860] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.611896] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.612749] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.613748] pci_bus 0000:00: root bus resource [mem 0x80000000-0x811fffff window]
[    1.614804] pci_bus 0000:00: root bus resource [mem 0x82a00000-0xdfffffff window]
[    1.615853] pci_bus 0000:00: root bus resource [mem 0xdc0000000-0x37ffffffffff window]
[    1.615896] pci_bus 0000:00: root bus resource [mem 0x382800040000-0x382fffffffff window]
[    1.617060] pci_bus 0000:00: root bus resource [bus 00-34]
[    1.617993] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000 conventional PCI endpoint
[    1.621561] pci 0000:00:01.0: [1234:1111] type 00 class 0x030000 conventional PCI endpoint
[    1.625134] pci 0000:00:01.0: BAR 0 [mem 0x80000000-0x80ffffff pref]
[    1.630362] pci 0000:00:01.0: BAR 2 [mem 0x81061000-0x81061fff]
[    1.643912] pci 0000:00:01.0: ROM [mem 0xffff0000-0xffffffff pref]
[    1.644828] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.649978] pci 0000:00:02.0: [8086:100e] type 00 class 0x020000 conventional PCI endpoint
[    1.651874] pci 0000:00:02.0: BAR 0 [mem 0x81040000-0x8105ffff]
[    1.654039] pci 0000:00:02.0: BAR 1 [io  0x6040-0x607f]
[    1.663246] pci 0000:00:02.0: ROM [mem 0xfffc0000-0xffffffff pref]
[    1.670090] pci 0000:00:03.0: [1b36:000b] type 00 class 0x060000 conventional PCI endpoint
[    1.673133] pci 0000:00:04.0: [1b36:000b] type 00 class 0x060000 conventional PCI endpoint
[    1.683123] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100 conventional PCI endpoint
[    1.684301] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
[    1.687127] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
[    1.696736] pci 0000:00:1f.2: BAR 4 [io  0x6080-0x609f]
[    1.699009] pci 0000:00:1f.2: BAR 5 [mem 0x81060000-0x81060fff]
[    1.703777] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500 conventional PCI endpoint
[    1.711880] pci 0000:00:1f.3: BAR 4 [io  0x6000-0x603f]
[    1.723832] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    1.726161] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    1.728893] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    1.731566] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    1.733945] ACPI: PCI: Interrupt link LNKE configured for IRQ 10
[    1.736830] ACPI: PCI: Interrupt link LNKF configured for IRQ 10
[    1.739760] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    1.741896] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    1.743028] ACPI: PCI: Interrupt link GSIA configured for IRQ 16
[    1.744003] ACPI: PCI: Interrupt link GSIB configured for IRQ 17
[    1.744971] ACPI: PCI: Interrupt link GSIC configured for IRQ 18
[    1.745935] ACPI: PCI: Interrupt link GSID configured for IRQ 19
[    1.746871] ACPI: PCI: Interrupt link GSIE configured for IRQ 20
[    1.747818] ACPI: PCI: Interrupt link GSIF configured for IRQ 21
[    1.748192] ACPI: PCI: Interrupt link GSIG configured for IRQ 22
[    1.749136] ACPI: PCI: Interrupt link GSIH configured for IRQ 23
[    1.769845] ACPI: PCI Root Bridge [CLBF] (domain 0000 [bus bf-c6])
[    1.770549] acpi ACPI0016:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    1.771595] acpi ACPI0016:00: _OSC: OS supports [CXL11PortRegAccess CXL20PortDevRegAccess CXLProtocolErrorReporting CXLNativeHot]
[    1.776339] acpi ACPI0016:00: _OSC: platform does not support [LTR DPC]
[    1.785255] acpi ACPI0016:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability]
[    1.786318] acpi ACPI0016:00: _OSC: OS now controls [CXLMemErrorReporting]
[    1.788186] PCI host bridge to bus 0000:bf
[    1.788654] pci_bus 0000:bf: Unknown NUMA node; performance will be reduced
[    1.789558] pci_bus 0000:bf: root bus resource [mem 0x81e00000-0x829fffff window]
[    1.790410] pci_bus 0000:bf: root bus resource [mem 0x383000000000-0x38580003ffff window]
[    1.791328] pci_bus 0000:bf: root bus resource [bus bf-c6]
[    1.792042] pci 0000:bf:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
[    1.795822] pci 0000:bf:00.0: BAR 0 [mem 0x385800020000-0x38580003ffff 64bit]
[    1.797563] pci 0000:bf:00.0: PCI bridge to [bus c0-c5]
[    1.798187] pci 0000:bf:00.0:   bridge window [mem 0x82000000-0x829fffff]
[    1.799894] pci 0000:bf:00.0:   bridge window [mem 0x383000000000-0x384fffffffff 64bit pref]
[    1.802867] pci 0000:bf:01.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
[    1.807231] pci 0000:bf:01.0: BAR 0 [mem 0x385800000000-0x38580001ffff 64bit]
[    1.809329] pci 0000:bf:01.0: PCI bridge to [bus c6]
[    1.809914] pci 0000:bf:01.0:   bridge window [mem 0x81e00000-0x81ffffff]
[    1.811447] pci 0000:bf:01.0:   bridge window [mem 0x385000000000-0x3857ffffffff 64bit pref]
[    1.824960] pci 0000:c0:00.0: [19e5:a128] type 01 class 0x060400 PCIe Switch Upstream Port
[    1.827777] pci 0000:c0:00.0: BAR 0 [mem 0x82940000-0x8295ffff 64bit]
[    1.829052] pci 0000:c0:00.0: PCI bridge to [bus c1-c5]
[    1.829628] pci 0000:c0:00.0:   bridge window [mem 0x82000000-0x828fffff]
[    1.831218] pci 0000:c0:00.0:   bridge window [mem 0x383000000000-0x384fffffffff 64bit pref]
[    1.849279] pci 0000:c0:00.1: [19e5:a123] type 00 class 0x0c0b00 PCIe Endpoint
[    1.855876] pci 0000:c0:00.1: BAR 0 [mem 0x82900000-0x8293ffff 64bit]
[    1.862129] pci 0000:bf:00.0: PCI bridge to [bus c0-c5]
[    1.863730] pci 0000:c1:00.0: [19e5:a129] type 01 class 0x060400 PCIe Switch Downstream Port
[    1.866944] pci 0000:c1:00.0: BAR 0 [mem 0x82800000-0x8281ffff 64bit]
[    1.869353] pci 0000:c1:00.0: PCI bridge to [bus c2]
[    1.869909] pci 0000:c1:00.0:   bridge window [mem 0x82600000-0x827fffff]
[    1.871337] pci 0000:c1:00.0:   bridge window [mem 0x384800000000-0x384fffffffff 64bit pref]
[    1.873853] pci 0000:c1:01.0: [19e5:a129] type 01 class 0x060400 PCIe Switch Downstream Port
[    1.876607] pci 0000:c1:01.0: BAR 0 [mem 0x82820000-0x8283ffff 64bit]
[    1.879883] pci 0000:c1:01.0: PCI bridge to [bus c3]
[    1.880480] pci 0000:c1:01.0:   bridge window [mem 0x82400000-0x825fffff]
[    1.881871] pci 0000:c1:01.0:   bridge window [mem 0x384000000000-0x3847ffffffff 64bit pref]
[    1.884986] pci 0000:c1:02.0: [19e5:a129] type 01 class 0x060400 PCIe Switch Downstream Port
[    1.887874] pci 0000:c1:02.0: BAR 0 [mem 0x82840000-0x8285ffff 64bit]
[    1.891474] pci 0000:c1:02.0: PCI bridge to [bus c4]
[    1.891924] pci 0000:c1:02.0:   bridge window [mem 0x82200000-0x823fffff]
[    1.893292] pci 0000:c1:02.0:   bridge window [mem 0x383800000000-0x383fffffffff 64bit pref]
[    1.896214] pci 0000:c1:03.0: [19e5:a129] type 01 class 0x060400 PCIe Switch Downstream Port
[    1.899036] pci 0000:c1:03.0: BAR 0 [mem 0x82860000-0x8287ffff 64bit]
[    1.905312] pci 0000:c1:03.0: PCI bridge to [bus c5]
[    1.905888] pci 0000:c1:03.0:   bridge window [mem 0x82000000-0x821fffff]
[    1.907226] pci 0000:c1:03.0:   bridge window [mem 0x383000000000-0x3837ffffffff 64bit pref]
[    1.911860] pci 0000:c0:00.0: PCI bridge to [bus c1-c5]
[    1.916071] pci 0000:c2:00.0: [8086:0d93] type 00 class 0x050210 PCIe Endpoint
[    1.918543] pci 0000:c2:00.0: BAR 0 [mem 0x82640000-0x8264ffff 64bit]
[    1.920699] pci 0000:c2:00.0: BAR 2 [mem 0x82600000-0x8263ffff 64bit]
[    1.927876] pci 0000:c2:00.0: BAR 4 [mem 0x82650000-0x82650fff]
[    1.961115] pci 0000:c1:00.0: PCI bridge to [bus c2]
[    1.965049] pci 0000:c1:01.0: PCI bridge to [bus c3]
[    1.967150] pci 0000:c4:00.0: [8086:0d93] type 00 class 0x050210 PCIe Endpoint
[    1.971087] pci 0000:c4:00.0: BAR 0 [mem 0x82240000-0x8224ffff 64bit]
[    1.973111] pci 0000:c4:00.0: BAR 2 [mem 0x82200000-0x8223ffff 64bit]
[    1.976714] pci 0000:c4:00.0: BAR 4 [mem 0x82250000-0x82250fff]
[    2.013237] pci 0000:c1:02.0: PCI bridge to [bus c4]
[    2.017032] pci 0000:c1:03.0: PCI bridge to [bus c5]
[    2.024584] pci 0000:bf:01.0: PCI bridge to [bus c6]
[    2.030103] ACPI: PCI Root Bridge [CL35] (domain 0000 [bus 35-3c])
[    2.031296] acpi ACPI0016:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    2.031911] acpi ACPI0016:01: _OSC: OS supports [CXL11PortRegAccess CXL20PortDevRegAccess CXLProtocolErrorReporting CXLNativeHot]
[    2.037649] acpi ACPI0016:01: _OSC: platform does not support [LTR DPC]
[    2.047162] acpi ACPI0016:01: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability]
[    2.047904] acpi ACPI0016:01: _OSC: OS now controls [CXLMemErrorReporting]
[    2.049693] PCI host bridge to bus 0000:35
[    2.050164] pci_bus 0000:35: Unknown NUMA node; performance will be reduced
[    2.051045] pci_bus 0000:35: root bus resource [mem 0x81200000-0x81dfffff window]
[    2.051877] pci_bus 0000:35: root bus resource [mem 0x380000000000-0x38280003ffff window]
[    2.052786] pci_bus 0000:35: root bus resource [bus 35-3c]
[    2.053583] pci 0000:35:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
[    2.056790] pci 0000:35:00.0: BAR 0 [mem 0x382800020000-0x38280003ffff 64bit]
[    2.059257] pci 0000:35:00.0: PCI bridge to [bus 36-3b]
[    2.059834] pci 0000:35:00.0:   bridge window [mem 0x81400000-0x81dfffff]
[    2.060813] pci 0000:35:00.0:   bridge window [mem 0x380000000000-0x381fffffffff 64bit pref]
[    2.066076] pci 0000:35:01.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
[    2.069184] pci 0000:35:01.0: BAR 0 [mem 0x382800000000-0x38280001ffff 64bit]
[    2.071330] pci 0000:35:01.0: PCI bridge to [bus 3c]
[    2.071840] pci 0000:35:01.0:   bridge window [mem 0x81200000-0x813fffff]
[    2.073522] pci 0000:35:01.0:   bridge window [mem 0x382000000000-0x3827ffffffff 64bit pref]
[    2.086146] pci 0000:36:00.0: [19e5:a128] type 01 class 0x060400 PCIe Switch Upstream Port
[    2.088474] pci 0000:36:00.0: BAR 0 [mem 0x81d40000-0x81d5ffff 64bit]
[    2.090298] pci 0000:36:00.0: PCI bridge to [bus 37-3b]
[    2.090906] pci 0000:36:00.0:   bridge window [mem 0x81400000-0x81cfffff]
[    2.092260] pci 0000:36:00.0:   bridge window [mem 0x380000000000-0x381fffffffff 64bit pref]
[    2.109039] pci 0000:36:00.1: [19e5:a123] type 00 class 0x0c0b00 PCIe Endpoint
[    2.115553] pci 0000:36:00.1: BAR 0 [mem 0x81d00000-0x81d3ffff 64bit]
[    2.121986] pci 0000:35:00.0: PCI bridge to [bus 36-3b]
[    2.123533] pci 0000:37:00.0: [19e5:a129] type 01 class 0x060400 PCIe Switch Downstream Port
[    2.126557] pci 0000:37:00.0: BAR 0 [mem 0x81c00000-0x81c1ffff 64bit]
[    2.129544] pci 0000:37:00.0: PCI bridge to [bus 38]
[    2.130116] pci 0000:37:00.0:   bridge window [mem 0x81a00000-0x81bfffff]
[    2.131485] pci 0000:37:00.0:   bridge window [mem 0x381800000000-0x381fffffffff 64bit pref]
[    2.133869] pci 0000:37:01.0: [19e5:a129] type 01 class 0x060400 PCIe Switch Downstream Port
[    2.136842] pci 0000:37:01.0: BAR 0 [mem 0x81c20000-0x81c3ffff 64bit]
[    2.140480] pci 0000:37:01.0: PCI bridge to [bus 39]
[    2.141125] pci 0000:37:01.0:   bridge window [mem 0x81800000-0x819fffff]
[    2.142536] pci 0000:37:01.0:   bridge window [mem 0x381000000000-0x3817ffffffff 64bit pref]
[    2.145413] pci 0000:37:02.0: [19e5:a129] type 01 class 0x060400 PCIe Switch Downstream Port
[    2.147873] pci 0000:37:02.0: BAR 0 [mem 0x81c40000-0x81c5ffff 64bit]
[    2.151884] pci 0000:37:02.0: PCI bridge to [bus 3a]
[    2.152472] pci 0000:37:02.0:   bridge window [mem 0x81600000-0x817fffff]
[    2.153845] pci 0000:37:02.0:   bridge window [mem 0x380800000000-0x380fffffffff 64bit pref]
[    2.156758] pci 0000:37:03.0: [19e5:a129] type 01 class 0x060400 PCIe Switch Downstream Port
[    2.159560] pci 0000:37:03.0: BAR 0 [mem 0x81c60000-0x81c7ffff 64bit]
[    2.165338] pci 0000:37:03.0: PCI bridge to [bus 3b]
[    2.165883] pci 0000:37:03.0:   bridge window [mem 0x81400000-0x815fffff]
[    2.167229] pci 0000:37:03.0:   bridge window [mem 0x380000000000-0x3807ffffffff 64bit pref]
[    2.178035] pci 0000:36:00.0: PCI bridge to [bus 37-3b]
[    2.179843] pci 0000:38:00.0: [8086:0d93] type 00 class 0x050210 PCIe Endpoint
[    2.181570] pci 0000:38:00.0: BAR 0 [mem 0x81a40000-0x81a4ffff 64bit]
[    2.183812] pci 0000:38:00.0: BAR 2 [mem 0x81a00000-0x81a3ffff 64bit]
[    2.185787] pci 0000:38:00.0: BAR 4 [mem 0x81a50000-0x81a50fff]
[    2.221065] pci 0000:37:00.0: PCI bridge to [bus 38]
[    2.225046] pci 0000:37:01.0: PCI bridge to [bus 39]
[    2.227038] pci 0000:3a:00.0: [8086:0d93] type 00 class 0x050210 PCIe Endpoint
[    2.230317] pci 0000:3a:00.0: BAR 0 [mem 0x81640000-0x8164ffff 64bit]
[    2.233078] pci 0000:3a:00.0: BAR 2 [mem 0x81600000-0x8163ffff 64bit]
[    2.235872] pci 0000:3a:00.0: BAR 4 [mem 0x81650000-0x81650fff]
[    2.269113] pci 0000:37:02.0: PCI bridge to [bus 3a]
[    2.273783] pci 0000:37:03.0: PCI bridge to [bus 3b]
[    2.280544] pci 0000:35:01.0: PCI bridge to [bus 3c]
[    2.289542] acpi/hmat: failed to reserve 0x280000000 - 0xb80400000 in pxm: 5
[    2.292027] iommu: Default domain type: Translated
[    2.292563] iommu: DMA domain TLB invalidation policy: lazy mode
[    2.295228] SCSI subsystem initialized
[    2.296221] libata version 3.00 loaded.
[    2.297809] ACPI: bus type USB registered
[    2.299997] usbcore: registered new interface driver usbfs
[    2.300634] usbcore: registered new interface driver hub
[    2.301310] usbcore: registered new device driver usb
[    2.302228] pps_core: LinuxPPS API ver. 1 registered
[    2.302801] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.303831] PTP clock support registered
[    2.304159] EDAC MC: Ver: 3.0.0
[    2.305232] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    2.308560] efivars: Registered efivars operations
[    2.316130] NetLabel: Initializing
[    2.316529] NetLabel:  domain hash size = 128
[    2.316965] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    2.317813] NetLabel:  unlabeled traffic allowed by default
[    2.320328] PCI: Using ACPI for IRQ routing
[    2.426089] PCI: pci_cache_line_size set to 64 bytes
[    2.427160] e820: reserve RAM buffer [mem 0x0080b000-0x008fffff]
[    2.427815] e820: reserve RAM buffer [mem 0x00810000-0x008fffff]
[    2.427905] e820: reserve RAM buffer [mem 0x7bf6d018-0x7bffffff]
[    2.428575] e820: reserve RAM buffer [mem 0x7bf94018-0x7bffffff]
[    2.429242] e820: reserve RAM buffer [mem 0x7c053000-0x7fffffff]
[    2.429913] e820: reserve RAM buffer [mem 0x7f070000-0x7fffffff]
[    2.430587] e820: reserve RAM buffer [mem 0x7f6ed000-0x7fffffff]
[    2.431268] e820: reserve RAM buffer [mem 0x7febc000-0x7fffffff]
[    2.432613] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    2.432685] pci 0000:00:01.0: vgaarb: bridge control possible
[    2.433320] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    2.434308] vgaarb: loaded
[    2.436716] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    2.437357] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    2.449889] clocksource: Switched to clocksource kvm-clock
[    3.849121] VFS: Disk quotas dquot_6.6.0
[    3.849765] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.852886] pnp: PnP ACPI init
[    3.856643] system 00:05: [mem 0xe0000000-0xefffffff window] has been reserved
[    3.866666] pnp: PnP ACPI: found 6 devices
[    3.927617] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.929481] NET: Registered PF_INET protocol family
[    3.930948] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    3.936265] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes, vmalloc)
[    3.937539] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
[    3.938582] TCP established hash table entries: 65536 (order: 7, 524288 bytes, vmalloc)
[    3.940444] TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
[    3.945153] TCP: Hash tables configured (established 65536 bind 65536)
[    3.946254] UDP hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    3.947629] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    3.949229] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.952325] RPC: Registered named UNIX socket transport module.
[    3.953038] RPC: Registered udp transport module.
[    3.953562] RPC: Registered tcp transport module.
[    3.954081] RPC: Registered tcp-with-tls transport module.
[    3.954689] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.955392] pci 0000:00:02.0: ROM [mem 0xfffc0000-0xffffffff pref]: can't claim; no compatible bridge window
[    3.956517] pci 0000:00:02.0: ROM [mem 0x81000000-0x8103ffff pref]: assigned
[    3.957310] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    3.958002] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    3.958685] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    3.959459] pci_bus 0000:00: resource 7 [mem 0x80000000-0x811fffff window]
[    3.960207] pci_bus 0000:00: resource 8 [mem 0x82a00000-0xdfffffff window]
[    3.960966] pci_bus 0000:00: resource 9 [mem 0xdc0000000-0x37ffffffffff window]
[    3.961760] pci_bus 0000:00: resource 10 [mem 0x382800040000-0x382fffffffff window]
[    3.962860] pci 0000:c1:00.0: bridge window [io  0x1000-0x0fff] to [bus c2] add_size 1000
[    3.963743] pci 0000:c1:01.0: bridge window [io  0x1000-0x0fff] to [bus c3] add_size 1000
[    3.964591] pci 0000:c1:02.0: bridge window [io  0x1000-0x0fff] to [bus c4] add_size 1000
[    3.965487] pci 0000:c1:03.0: bridge window [io  0x1000-0x0fff] to [bus c5] add_size 1000
[    3.966399] pci 0000:c0:00.0: bridge window [io  0x1000-0x0fff] to [bus c1-c5] add_size 4000
[    3.967333] pci 0000:bf:00.0: bridge window [io  0x1000-0x0fff] to [bus c0-c5] add_size 5000
[    3.968260] pci 0000:bf:01.0: bridge window [io  0x1000-0x0fff] to [bus c6] add_size 1000
[    3.969185] pci 0000:bf:00.0: bridge window [io  size 0x5000]: can't assign; no space
[    3.970061] pci 0000:bf:00.0: bridge window [io  size 0x5000]: failed to assign
[    3.970881] pci 0000:bf:01.0: bridge window [io  size 0x1000]: can't assign; no space
[    3.971713] pci 0000:bf:01.0: bridge window [io  size 0x1000]: failed to assign
[    3.972521] pci 0000:bf:01.0: bridge window [io  size 0x1000]: can't assign; no space
[    3.973372] pci 0000:bf:01.0: bridge window [io  size 0x1000]: failed to assign
[    3.974179] pci 0000:bf:00.0: bridge window [io  size 0x5000]: can't assign; no space
[    3.975053] pci 0000:bf:00.0: bridge window [io  size 0x5000]: failed to assign
[    3.975890] pci 0000:c0:00.0: bridge window [io  size 0x4000]: can't assign; no space
[    3.976749] pci 0000:c0:00.0: bridge window [io  size 0x4000]: failed to assign
[    3.977559] pci 0000:c0:00.0: bridge window [io  size 0x4000]: can't assign; no space
[    3.978424] pci 0000:c0:00.0: bridge window [io  size 0x4000]: failed to assign
[    3.979294] pci 0000:c1:00.0: bridge window [io  size 0x1000]: can't assign; no space
[    3.980158] pci 0000:c1:00.0: bridge window [io  size 0x1000]: failed to assign
[    3.980977] pci 0000:c1:01.0: bridge window [io  size 0x1000]: can't assign; no space
[    3.981841] pci 0000:c1:01.0: bridge window [io  size 0x1000]: failed to assign
[    3.982631] pci 0000:c1:02.0: bridge window [io  size 0x1000]: can't assign; no space
[    3.983508] pci 0000:c1:02.0: bridge window [io  size 0x1000]: failed to assign
[    3.984317] pci 0000:c1:03.0: bridge window [io  size 0x1000]: can't assign; no space
[    3.985177] pci 0000:c1:03.0: bridge window [io  size 0x1000]: failed to assign
[    3.986011] pci 0000:c1:03.0: bridge window [io  size 0x1000]: can't assign; no space
[    3.986882] pci 0000:c1:03.0: bridge window [io  size 0x1000]: failed to assign
[    3.987707] pci 0000:c1:02.0: bridge window [io  size 0x1000]: can't assign; no space
[    3.988560] pci 0000:c1:02.0: bridge window [io  size 0x1000]: failed to assign
[    3.989374] pci 0000:c1:01.0: bridge window [io  size 0x1000]: can't assign; no space
[    3.990223] pci 0000:c1:01.0: bridge window [io  size 0x1000]: failed to assign
[    3.991036] pci 0000:c1:00.0: bridge window [io  size 0x1000]: can't assign; no space
[    3.991897] pci 0000:c1:00.0: bridge window [io  size 0x1000]: failed to assign
[    3.992716] pci 0000:c1:00.0: PCI bridge to [bus c2]
[    3.995791] pci 0000:c1:00.0:   bridge window [mem 0x82600000-0x827fffff]
[    3.997437] pci 0000:c1:00.0:   bridge window [mem 0x384800000000-0x384fffffffff 64bit pref]
[    4.000237] pci 0000:c1:01.0: PCI bridge to [bus c3]
[    4.002653] pci 0000:c1:01.0:   bridge window [mem 0x82400000-0x825fffff]
[    4.004257] pci 0000:c1:01.0:   bridge window [mem 0x384000000000-0x3847ffffffff 64bit pref]
[    4.009068] pci 0000:c1:02.0: PCI bridge to [bus c4]
[    4.010535] pci 0000:c1:02.0:   bridge window [mem 0x82200000-0x823fffff]
[    4.011933] pci 0000:c1:02.0:   bridge window [mem 0x383800000000-0x383fffffffff 64bit pref]
[    4.014173] pci 0000:c1:03.0: PCI bridge to [bus c5]
[    4.016030] pci 0000:c1:03.0:   bridge window [mem 0x82000000-0x821fffff]
[    4.017541] pci 0000:c1:03.0:   bridge window [mem 0x383000000000-0x3837ffffffff 64bit pref]
[    4.022080] pci 0000:c0:00.0: PCI bridge to [bus c1-c5]
[    4.023522] pci 0000:c0:00.0:   bridge window [mem 0x82000000-0x828fffff]
[    4.024795] pci 0000:c0:00.0:   bridge window [mem 0x383000000000-0x384fffffffff 64bit pref]
[    4.026942] pci 0000:bf:00.0: PCI bridge to [bus c0-c5]
[    4.028518] pci 0000:bf:00.0:   bridge window [mem 0x82000000-0x829fffff]
[    4.030046] pci 0000:bf:00.0:   bridge window [mem 0x383000000000-0x384fffffffff 64bit pref]
[    4.035398] pci 0000:bf:01.0: PCI bridge to [bus c6]
[    4.036850] pci 0000:bf:01.0:   bridge window [mem 0x81e00000-0x81ffffff]
[    4.038159] pci 0000:bf:01.0:   bridge window [mem 0x385000000000-0x3857ffffffff 64bit pref]
[    4.040244] pci_bus 0000:bf: resource 4 [mem 0x81e00000-0x829fffff window]
[    4.041009] pci_bus 0000:bf: resource 5 [mem 0x383000000000-0x38580003ffff window]
[    4.041820] pci_bus 0000:c0: resource 1 [mem 0x82000000-0x829fffff]
[    4.042503] pci_bus 0000:c0: resource 2 [mem 0x383000000000-0x384fffffffff 64bit pref]
[    4.045327] pci_bus 0000:c1: resource 1 [mem 0x82000000-0x828fffff]
[    4.046036] pci_bus 0000:c1: resource 2 [mem 0x383000000000-0x384fffffffff 64bit pref]
[    4.046899] pci_bus 0000:c2: resource 1 [mem 0x82600000-0x827fffff]
[    4.047602] pci_bus 0000:c2: resource 2 [mem 0x384800000000-0x384fffffffff 64bit pref]
[    4.048458] pci_bus 0000:c3: resource 1 [mem 0x82400000-0x825fffff]
[    4.049139] pci_bus 0000:c3: resource 2 [mem 0x384000000000-0x3847ffffffff 64bit pref]
[    4.049998] pci_bus 0000:c4: resource 1 [mem 0x82200000-0x823fffff]
[    4.050677] pci_bus 0000:c4: resource 2 [mem 0x383800000000-0x383fffffffff 64bit pref]
[    4.051545] pci_bus 0000:c5: resource 1 [mem 0x82000000-0x821fffff]
[    4.052308] pci_bus 0000:c5: resource 2 [mem 0x383000000000-0x3837ffffffff 64bit pref]
[    4.053193] pci_bus 0000:c6: resource 1 [mem 0x81e00000-0x81ffffff]
[    4.053872] pci_bus 0000:c6: resource 2 [mem 0x385000000000-0x3857ffffffff 64bit pref]
[    4.054777] pci 0000:37:00.0: bridge window [io  0x1000-0x0fff] to [bus 38] add_size 1000
[    4.055853] pci 0000:37:01.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
[    4.057188] pci 0000:37:02.0: bridge window [io  0x1000-0x0fff] to [bus 3a] add_size 1000
[    4.058219] pci 0000:37:03.0: bridge window [io  0x1000-0x0fff] to [bus 3b] add_size 1000
[    4.059304] pci 0000:36:00.0: bridge window [io  0x1000-0x0fff] to [bus 37-3b] add_size 4000
[    4.060228] pci 0000:35:00.0: bridge window [io  0x1000-0x0fff] to [bus 36-3b] add_size 5000
[    4.061156] pci 0000:35:01.0: bridge window [io  0x1000-0x0fff] to [bus 3c] add_size 1000
[    4.062071] pci 0000:35:00.0: bridge window [io  size 0x5000]: can't assign; no space
[    4.062936] pci 0000:35:00.0: bridge window [io  size 0x5000]: failed to assign
[    4.063755] pci 0000:35:01.0: bridge window [io  size 0x1000]: can't assign; no space
[    4.064605] pci 0000:35:01.0: bridge window [io  size 0x1000]: failed to assign
[    4.065428] pci 0000:35:01.0: bridge window [io  size 0x1000]: can't assign; no space
[    4.066277] pci 0000:35:01.0: bridge window [io  size 0x1000]: failed to assign
[    4.067061] pci 0000:35:00.0: bridge window [io  size 0x5000]: can't assign; no space
[    4.067906] pci 0000:35:00.0: bridge window [io  size 0x5000]: failed to assign
[    4.068703] pci 0000:36:00.0: bridge window [io  size 0x4000]: can't assign; no space
[    4.069536] pci 0000:36:00.0: bridge window [io  size 0x4000]: failed to assign
[    4.070334] pci 0000:36:00.0: bridge window [io  size 0x4000]: can't assign; no space
[    4.071186] pci 0000:36:00.0: bridge window [io  size 0x4000]: failed to assign
[    4.072011] pci 0000:37:00.0: bridge window [io  size 0x1000]: can't assign; no space
[    4.072856] pci 0000:37:00.0: bridge window [io  size 0x1000]: failed to assign
[    4.073644] pci 0000:37:01.0: bridge window [io  size 0x1000]: can't assign; no space
[    4.074448] pci 0000:37:01.0: bridge window [io  size 0x1000]: failed to assign
[    4.075202] pci 0000:37:02.0: bridge window [io  size 0x1000]: can't assign; no space
[    4.076024] pci 0000:37:02.0: bridge window [io  size 0x1000]: failed to assign
[    4.076778] pci 0000:37:03.0: bridge window [io  size 0x1000]: can't assign; no space
[    4.077560] pci 0000:37:03.0: bridge window [io  size 0x1000]: failed to assign
[    4.078315] pci 0000:37:03.0: bridge window [io  size 0x1000]: can't assign; no space
[    4.079081] pci 0000:37:03.0: bridge window [io  size 0x1000]: failed to assign
[    4.079879] pci 0000:37:02.0: bridge window [io  size 0x1000]: can't assign; no space
[    4.080716] pci 0000:37:02.0: bridge window [io  size 0x1000]: failed to assign
[    4.081501] pci 0000:37:01.0: bridge window [io  size 0x1000]: can't assign; no space
[    4.082346] pci 0000:37:01.0: bridge window [io  size 0x1000]: failed to assign
[    4.083152] pci 0000:37:00.0: bridge window [io  size 0x1000]: can't assign; no space
[    4.083994] pci 0000:37:00.0: bridge window [io  size 0x1000]: failed to assign
[    4.084805] pci 0000:37:00.0: PCI bridge to [bus 38]
[    4.087286] pci 0000:37:00.0:   bridge window [mem 0x81a00000-0x81bfffff]
[    4.088969] pci 0000:37:00.0:   bridge window [mem 0x381800000000-0x381fffffffff 64bit pref]
[    4.091688] pci 0000:37:01.0: PCI bridge to [bus 39]
[    4.093551] pci 0000:37:01.0:   bridge window [mem 0x81800000-0x819fffff]
[    4.095120] pci 0000:37:01.0:   bridge window [mem 0x381000000000-0x3817ffffffff 64bit pref]
[    4.097937] pci 0000:37:02.0: PCI bridge to [bus 3a]
[    4.101946] pci 0000:37:02.0:   bridge window [mem 0x81600000-0x817fffff]
[    4.103217] pci 0000:37:02.0:   bridge window [mem 0x380800000000-0x380fffffffff 64bit pref]
[    4.105511] pci 0000:37:03.0: PCI bridge to [bus 3b]
[    4.107081] pci 0000:37:03.0:   bridge window [mem 0x81400000-0x815fffff]
[    4.108519] pci 0000:37:03.0:   bridge window [mem 0x380000000000-0x3807ffffffff 64bit pref]
[    4.111239] pci 0000:36:00.0: PCI bridge to [bus 37-3b]
[    4.115441] pci 0000:36:00.0:   bridge window [mem 0x81400000-0x81cfffff]
[    4.116779] pci 0000:36:00.0:   bridge window [mem 0x380000000000-0x381fffffffff 64bit pref]
[    4.118867] pci 0000:35:00.0: PCI bridge to [bus 36-3b]
[    4.120403] pci 0000:35:00.0:   bridge window [mem 0x81400000-0x81dfffff]
[    4.121744] pci 0000:35:00.0:   bridge window [mem 0x380000000000-0x381fffffffff 64bit pref]
[    4.124066] pci 0000:35:01.0: PCI bridge to [bus 3c]
[    4.128376] pci 0000:35:01.0:   bridge window [mem 0x81200000-0x813fffff]
[    4.129701] pci 0000:35:01.0:   bridge window [mem 0x382000000000-0x3827ffffffff 64bit pref]
[    4.131732] pci_bus 0000:35: resource 4 [mem 0x81200000-0x81dfffff window]
[    4.132467] pci_bus 0000:35: resource 5 [mem 0x380000000000-0x38280003ffff window]
[    4.133249] pci_bus 0000:36: resource 1 [mem 0x81400000-0x81dfffff]
[    4.133920] pci_bus 0000:36: resource 2 [mem 0x380000000000-0x381fffffffff 64bit pref]
[    4.134760] pci_bus 0000:37: resource 1 [mem 0x81400000-0x81cfffff]
[    4.135434] pci_bus 0000:37: resource 2 [mem 0x380000000000-0x381fffffffff 64bit pref]
[    4.136269] pci_bus 0000:38: resource 1 [mem 0x81a00000-0x81bfffff]
[    4.138456] pci_bus 0000:38: resource 2 [mem 0x381800000000-0x381fffffffff 64bit pref]
[    4.139367] pci_bus 0000:39: resource 1 [mem 0x81800000-0x819fffff]
[    4.140055] pci_bus 0000:39: resource 2 [mem 0x381000000000-0x3817ffffffff 64bit pref]
[    4.140911] pci_bus 0000:3a: resource 1 [mem 0x81600000-0x817fffff]
[    4.141577] pci_bus 0000:3a: resource 2 [mem 0x380800000000-0x380fffffffff 64bit pref]
[    4.142417] pci_bus 0000:3b: resource 1 [mem 0x81400000-0x815fffff]
[    4.143082] pci_bus 0000:3b: resource 2 [mem 0x380000000000-0x3807ffffffff 64bit pref]
[    4.143942] pci_bus 0000:3c: resource 1 [mem 0x81200000-0x813fffff]
[    4.144609] pci_bus 0000:3c: resource 2 [mem 0x382000000000-0x3827ffffffff 64bit pref]
[    4.145929] PCI: CLS 0 bytes, default 64
[    4.146501] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    4.147228] software IO TLB: mapped [mem 0x000000004e000000-0x0000000052000000] (64MB)
[    4.147554] Trying to unpack rootfs image as initramfs...
[    4.148150] ACPI: bus type thunderbolt registered
[    4.150756] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x240939f1bb2, max_idle_ns: 440795263295 ns
[    4.189540] Initialise system trusted keyrings
[    4.190281] Key type blacklist registered
[    4.193259] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[    4.194101] zbud: loaded
[    4.198239] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    4.203320] NFS: Registering the id_resolver key type
[    4.203954] Key type id_resolver registered
[    4.204412] Key type id_legacy registered
[    4.204953] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    4.205748] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    4.207361] fuse: init (API version 7.40)
[    4.209027] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    4.213389] 9p: Installing v9fs 9p2000 file system support
[    4.228741] Key type asymmetric registered
[    4.229203] Asymmetric key parser 'x509' registered
[    4.229991] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    4.231950] io scheduler mq-deadline registered
[    4.232949] io scheduler bfq registered
[    6.379678] ACPI: \_SB_.LNKD: Enabled at IRQ 11
[    6.383414] pcieport 0000:bf:00.0: PME: Signaling with IRQ 24
[    6.387886] pcieport 0000:bf:00.0: AER: enabled with IRQ 24
[    6.389262] pcieport 0000:bf:00.0: pciehp: Slot #2 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep- (with Cmd Compl erratum)
[    8.534524] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    8.542251] pcieport 0000:bf:01.0: PME: Signaling with IRQ 25
[    8.544969] pcieport 0000:bf:01.0: AER: enabled with IRQ 25
[    8.546757] pcieport 0000:bf:01.0: pciehp: Slot #3 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep- (with Cmd Compl erratum)
[    8.552887] pcieport 0000:c1:00.0: pciehp: Slot #8 AttnBtn+ PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep-
[    8.558870] pcieport 0000:c1:01.0: pciehp: Slot #9 AttnBtn+ PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep-
[    8.563980] pcieport 0000:c1:02.0: pciehp: Slot #10 AttnBtn+ PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep-
[    8.570048] pcieport 0000:c1:03.0: pciehp: Slot #11 AttnBtn+ PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep-
[   10.706925] pcieport 0000:35:00.0: PME: Signaling with IRQ 30
[   10.711300] pcieport 0000:35:00.0: AER: enabled with IRQ 30
[   10.712832] pcieport 0000:35:00.0: pciehp: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep- (with Cmd Compl erratum)
[   11.135464] Freeing initrd memory: 183348K
[   12.839990] pcieport 0000:35:01.0: PME: Signaling with IRQ 31
[   12.842519] pcieport 0000:35:01.0: AER: enabled with IRQ 31
[   12.843670] pcieport 0000:35:01.0: pciehp: Slot #1 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep- (with Cmd Compl erratum)
[   12.849341] pcieport 0000:37:00.0: pciehp: Slot #4 AttnBtn+ PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep-
[   12.854401] pcieport 0000:37:01.0: pciehp: Slot #5 AttnBtn+ PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep-
[   12.859607] pcieport 0000:37:02.0: pciehp: Slot #6 AttnBtn+ PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep-
[   12.866814] pcieport 0000:37:03.0: pciehp: Slot #7 AttnBtn+ PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep-
[   12.871340] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.873573] IPMI message handler: version 39.2
[   12.874142] ipmi device interface
[   12.878719] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   12.880727] ACPI: button: Power Button [PWRF]
[   12.889665] ERST DBG: ERST support is disabled.
[   12.892279] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   12.895033] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   12.958225] Linux agpgart interface v0.103
[   12.963919] ACPI: bus type drm_connector registered
[   13.009110] brd: module loaded
[   13.037319] loop: module loaded
[   13.039253] lpc_ich 0000:00:1f.0: I/O space for GPIO uninitialized
[   13.051354] ahci 0000:00:1f.2: version 3.0
[   13.068487] ACPI: \_SB_.GSIA: Enabled at IRQ 16
[   13.070612] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
[   13.071620] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
[   13.072413] ahci 0000:00:1f.2: flags: 64bit ncq only 
[   13.084136] scsi host0: ahci
[   13.087882] scsi host1: ahci
[   13.091919] scsi host2: ahci
[   13.095449] scsi host3: ahci
[   13.098995] scsi host4: ahci
[   13.102610] scsi host5: ahci
[   13.104126] ata1: SATA max UDMA/133 abar m4096@0x81060000 port 0x81060100 irq 36 lpm-pol 0
[   13.105131] ata2: SATA max UDMA/133 abar m4096@0x81060000 port 0x81060180 irq 36 lpm-pol 0
[   13.106246] ata3: SATA max UDMA/133 abar m4096@0x81060000 port 0x81060200 irq 36 lpm-pol 0
[   13.107367] ata4: SATA max UDMA/133 abar m4096@0x81060000 port 0x81060280 irq 36 lpm-pol 0
[   13.108440] ata5: SATA max UDMA/133 abar m4096@0x81060000 port 0x81060300 irq 36 lpm-pol 0
[   13.109481] ata6: SATA max UDMA/133 abar m4096@0x81060000 port 0x81060380 irq 36 lpm-pol 0
[   13.112983] mdio_bus fixed-0: using lookup tables for GPIO lookup
[   13.114065] mdio_bus fixed-0: No GPIO consumer reset found
[   13.116158] tun: Universal TUN/TAP device driver, 1.6
[   13.117635] e100: Intel(R) PRO/100 Network Driver
[   13.118221] e100: Copyright(c) 1999-2006 Intel Corporation
[   13.118939] e1000: Intel(R) PRO/1000 Network Driver
[   13.119597] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   13.136798] ACPI: \_SB_.GSIG: Enabled at IRQ 22
[   13.424528] ata5: SATA link down (SStatus 0 SControl 300)
[   13.425721] ata4: SATA link down (SStatus 0 SControl 300)
[   13.426649] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   13.427749] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   13.428836] ata2: SATA link down (SStatus 0 SControl 300)
[   13.429812] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[   13.430661] ata1.00: 42991696 sectors, multi 16: LBA48 NCQ (depth 32)
[   13.431645] ata1.00: applying bridge limits
[   13.432331] ata6: SATA link down (SStatus 0 SControl 300)
[   13.433169] ata3.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[   13.433882] ata3.00: applying bridge limits
[   13.434869] ata1.00: configured for UDMA/100
[   13.436019] ata3.00: configured for UDMA/100
[   13.438247] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[   13.447863] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   13.449503] sd 0:0:0:0: [sda] 42991696 512-byte logical blocks: (22.0 GB/20.5 GiB)
[   13.450741] sd 0:0:0:0: [sda] Write Protect is off
[   13.451225] scsi 2:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[   13.451414] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   13.454060] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   13.456588] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[   13.471051] e1000 0000:00:02.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[   13.471924] e1000 0000:00:02.0 eth0: Intel(R) PRO/1000 Network Connection
[   13.472958] e1000e: Intel(R) PRO/1000 Network Driver
[   13.473509] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   13.474316] igb: Intel(R) Gigabit Ethernet Network Driver
[   13.474889] igb: Copyright (c) 2007-2014 Intel Corporation.
[   13.476000] PPP generic driver version 2.4.2
[   13.478242] VFIO - User Level meta-driver version: 0.3
[   13.480486] usbcore: registered new interface driver uas
[   13.481131] usbcore: registered new interface driver usb-storage
[   13.482228] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[   13.484999] serio: i8042 KBD port at 0x60,0x64 irq 1
[   13.485665] serio: i8042 AUX port at 0x60,0x64 irq 12
[   13.488785] mousedev: PS/2 mouse device common for all mice
[   13.493058] rtc_cmos 00:04: RTC can wake from S4
[   13.494770] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[   13.498527] rtc_cmos 00:04: registered as rtc0
[   13.499411] rtc_cmos 00:04: setting system clock to 2024-08-10T02:19:06 UTC (1723256346)
[   13.501280] rtc_cmos 00:04: using ACPI '\_SB.PCI0.SF8.RTC' for 'wp' GPIO lookup
[   13.501302] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[   13.502220] acpi PNP0B00:00: GPIO: looking up wp-gpios
[   13.504304] acpi PNP0B00:00: GPIO: looking up wp-gpio
[   13.506120] rtc_cmos 00:04: using lookup tables for GPIO lookup
[   13.506880] scsi 2:0:0:0: Attached scsi generic sg1 type 5
[   13.507522] rtc_cmos 00:04: No GPIO consumer wp found
[   13.508686] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[   13.513629] rtc_cmos 00:04: alarms up to one day, y3k, 242 bytes nvram
[   13.515105] i2c_dev: i2c /dev entries driver
[   13.516180] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[   13.516192]  sda: sda1 sda2
[   13.517757] device-mapper: uevent: version 1.0.3
[   13.519745] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[   13.520571] sd 0:0:0:0: [sda] Attached SCSI disk
[   13.520762] intel_pstate: CPU model not supported
[   13.522407] sdhci: Secure Digital Host Controller Interface driver
[   13.523072] sdhci: Copyright(c) Pierre Ossman
[   13.523903] sdhci-pltfm: SDHCI platform and OF driver helper
[   13.527235] ledtrig-cpu: registered to indicate activity on CPUs
[   13.528828] efifb: probing for efifb
[   13.529471] efifb: framebuffer at 0x80000000, using 4000k, total 4000k
[   13.530169] efifb: mode is 1280x800x32, linelength=5120, pages=1
[   13.530848] efifb: scrolling: redraw
[   13.531318] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[   13.540415] Console: switching to colour frame buffer device 160x50
[   13.544393] fb0: EFI VGA frame buffer device
[   13.545163] pstore: Using crash dump compression: deflate
[   13.545815] pstore: Registered efi_pstore as persistent store backend
[   13.547615] drop_monitor: Initializing network drop monitor service
[   13.548980] NET: Registered PF_INET6 protocol family
[   13.596736] Segment Routing with IPv6
[   13.597293] In-situ OAM (IOAM) with IPv6
[   13.597917] NET: Registered PF_PACKET protocol family
[   13.599290] 9pnet: Installing 9P2000 support
[   13.600036] Key type dns_resolver registered
[   13.608628] IPI shorthand broadcast: enabled
[   13.671336] sched_clock: Marking stable (13416011081, 255135680)->(13736939692, -65792931)
[   13.674813] registered taskstats version 1
[   13.679718] Loading compiled-in X.509 certificates
[   13.747980] Demotion targets for Node 0: null
[   13.748675] Demotion targets for Node 2: null
[   13.749263] Demotion targets for Node 3: null
[   13.754443] Key type .fscrypt registered
[   13.754994] Key type fscrypt-provisioning registered
[   13.790203] cryptd: max_cpu_qlen set to 1000
[   13.803211] AES CTR mode by8 optimization enabled
[   13.903542] Key type encrypted registered
[   13.905846] ima: No TPM chip found, activating TPM-bypass!
[   13.908127] ima: Allocated hash algorithm: sha1
[   13.909879] ima: No architecture policies found
[   13.911778] evm: Initialising EVM extended attributes:
[   13.913400] evm: security.selinux
[   13.914655] evm: security.SMACK64
[   13.916044] evm: security.SMACK64EXEC
[   13.917353] evm: security.SMACK64TRANSMUTE
[   13.918623] evm: security.SMACK64MMAP
[   13.920086] evm: security.apparmor
[   13.921280] evm: security.ima
[   13.922376] evm: security.capability
[   13.923610] evm: HMAC attrs: 0x1
[   13.930124] PM:   Magic number: 4:244:308
[   13.932019] tty tty37: hash matches
[   13.935638] RAS: Correctable Errors collector initialized.
[   13.937736] clk: Disabling unused clocks
[   13.939594] PM: genpd: Disabling unused power domains
[   13.967873] Freeing unused decrypted memory: 2028K
[   13.976962] Freeing unused kernel image (initmem) memory: 15340K
[   13.978453] Write protecting the kernel read-only data: 94208k
[   13.983773] Freeing unused kernel image (rodata/data gap) memory: 1248K
[   15.118209] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   15.120395] Run /init as init process
[   15.122303]   with arguments:
[   15.123656]     /init
[   15.124688]   with environment:
[   15.125727]     HOME=/
[   15.126709]     TERM=linux
[   15.127836]     efi_fake_mem=2G@6G:0x40000
[   15.221683] systemd[1]: systemd 252-35.el9 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[   15.228422] systemd[1]: Detected virtualization kvm.
[   15.229829] systemd[1]: Detected architecture x86-64.
[   15.231080] systemd[1]: Running in initrd.
[   15.235229] systemd[1]: Initializing machine ID from random generator.
[   15.622046] systemd[1]: Queued start job for default target Initrd Default Target.
[   15.624726] systemd[1]: Reached target Initrd /usr File System.
[   15.628169] systemd[1]: Reached target Slice Units.
[   15.630838] systemd[1]: Reached target Swaps.
[   15.633990] systemd[1]: Reached target Timer Units.
[   15.638005] systemd[1]: Listening on D-Bus System Message Bus Socket.
[   15.641816] systemd[1]: Listening on Journal Socket (/dev/log).
[   15.645318] systemd[1]: Listening on Journal Socket.
[   15.648651] systemd[1]: Listening on udev Control Socket.
[   15.651593] systemd[1]: Listening on udev Kernel Socket.
[   15.654137] systemd[1]: Reached target Socket Units.
[   15.707774] systemd[1]: Starting Create List of Static Device Nodes...
[   15.727361] systemd[1]: Starting Journal Service...
[   15.738610] systemd[1]: Starting Load Kernel Modules...
[   15.749861] systemd[1]: Starting Create System Users...
[   15.760646] systemd[1]: Starting Setup Virtual Console...
[   15.770093] systemd[1]: Finished Create List of Static Device Nodes.
[   15.784717] systemd[1]: Finished Load Kernel Modules.
[   15.795965] systemd[1]: Starting Apply Kernel Variables...
[   15.837125] systemd[1]: Finished Create System Users.
[   15.848888] systemd[1]: Starting Create Static Device Nodes in /dev...
[   15.867466] systemd[1]: Finished Apply Kernel Variables.
[   15.903093] systemd[1]: Finished Create Static Device Nodes in /dev.
[   16.038993] systemd[1]: Started Journal Service.
[   18.773534] Console: switching to colour dummy device 80x25
[   18.777610] bochs-drm 0000:00:01.0: vgaarb: deactivate vga console
[   18.781808] [drm] Found bochs VGA, ID 0xb0c5.
[   18.782155] [drm] Framebuffer size 16384 kB @ 0x80000000, mmio @ 0x81061000.
[   18.786129] [drm] Found EDID data blob.
[   18.814440] [drm] Initialized bochs-drm 1.0.0 for 0000:00:01.0 on minor 0
[   18.821332] cxl_core: loading out-of-tree module taints kernel.
[   18.821877] cxl_core: loading test module taints kernel.
[   18.844319] fbcon: bochs-drmdrmfb (fb0) is primary device
[   18.861849] sr 2:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[   18.861885] cdrom: Uniform CD-ROM driver Revision: 3.20
[   18.874589] Console: switching to colour frame buffer device 160x50
[   18.881773] bochs-drm 0000:00:01.0: [drm] fb0: bochs-drmdrmfb frame buffer device
[   18.898472] cxl_core:devm_cxl_add_port:925: cxl_acpi ACPI0017:00: root0 added (root port)
[   18.899766] cxl_acpi:to_cxl_host_bridge:30: cxl_acpi ACPI0017:00: found host bridge ACPI0016:00
[   18.900951] cxl_acpi:cxl_get_chbs:521: acpi ACPI0016:00: UID found: 191
[   18.901828] cxl_core:devm_cxl_add_dport:1216:  pci0000:bf: dport added to root0
[   18.902473] (NULL device *): found host bridge ACPI0016:00
[   18.902951] cxl_acpi:add_host_bridge_dport:608: acpi ACPI0016:00: Failed to get generic port perf coordinates.
[   18.904274] cxl_acpi:to_cxl_host_bridge:30: cxl_acpi ACPI0017:00: found host bridge ACPI0016:01
[   18.905265] cxl_acpi:cxl_get_chbs:521: acpi ACPI0016:01: UID found: 53
[   18.905432] cxl_core:devm_cxl_add_dport:1216:  pci0000:35: dport added to root0
[   18.905441] (NULL device *): found host bridge ACPI0016:01
[   18.905560] cxl_acpi:add_host_bridge_dport:608: acpi ACPI0016:01: Failed to get generic port perf coordinates.
[   18.908555] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi ACPI0017:00: decode range: node: 6 range [0xb90000000 - 0xc8fffffff]
[   18.911633] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi ACPI0017:00: decode range: node: 7 range [0xc90000000 - 0xd8fffffff]
[   18.913019] cxl_acpi:to_cxl_host_bridge:30: cxl_acpi ACPI0017:00: found host bridge ACPI0016:00
[   18.914024] cxl_acpi:cxl_get_chbs:521: acpi ACPI0016:00: UID found: 191
[   18.914039] cxl_acpi:add_host_bridge_uport:658: acpi ACPI0016:00: CHBCR found for UID 191: 0x0000000b80400000
[   18.914251] cxl_core:cxl_port_alloc:730:  pci0000:bf: host-bridge: pci0000:bf
[   18.917208] cxl_core:cxl_map_regblock:414: cxl port1: Mapped CXL Memory Device resource 0x0000000b80400000
[   18.918168] cxl_core:cxl_probe_component_regs:96: cxl port1: Unknown CM cap ID: 0 (0x0)
[   18.918858] cxl_core:cxl_probe_component_regs:96: cxl port1: Unknown CM cap ID: 4 (0xd8)
[   18.919697] cxl_core:cxl_probe_component_regs:81: cxl port1: found HDM decoder capability (0x128)
[   18.920606] cxl_core:cxl_probe_component_regs:96: cxl port1: Unknown CM cap ID: 6 (0x278)
[   18.921441] cxl_core:cxl_probe_component_regs:96: cxl port1: Unknown CM cap ID: 8 (0xaa0)
[   18.922310] cxl_core:cxl_probe_regs:435: cxl port1: Set up component registers
[   18.923844] sr 2:0:0:0: Attached scsi CD-ROM sr0
[   18.924560] cxl_core:devm_cxl_add_port:925:  pci0000:bf: port1 added to root0
[   18.928173]  pci0000:bf: host supports CXL
[   18.930577] cxl_acpi:to_cxl_host_bridge:30: cxl_acpi ACPI0017:00: found host bridge ACPI0016:01
[   18.933668] cxl_acpi:cxl_get_chbs:521: acpi ACPI0016:01: UID found: 53
[   18.937037] cxl_acpi:add_host_bridge_uport:658: acpi ACPI0016:01: CHBCR found for UID 53: 0x0000000b80410000
[   18.940952] cxl_core:cxl_port_alloc:730:  pci0000:35: host-bridge: pci0000:35
[   18.941034] cxl_core:cxl_map_regblock:414: cxl port2: Mapped CXL Memory Device resource 0x0000000b80410000
[   18.941090] cxl_core:cxl_probe_component_regs:96: cxl port2: Unknown CM cap ID: 0 (0x0)
[   18.941107] cxl_core:cxl_probe_component_regs:96: cxl port2: Unknown CM cap ID: 4 (0xd8)
[   18.941123] cxl_core:cxl_probe_component_regs:81: cxl port2: found HDM decoder capability (0x128)
[   18.941138] cxl_core:cxl_probe_component_regs:96: cxl port2: Unknown CM cap ID: 6 (0x278)
[   18.941154] cxl_core:cxl_probe_component_regs:96: cxl port2: Unknown CM cap ID: 8 (0xaa0)
[   18.941163] cxl_core:cxl_probe_regs:435: cxl port2: Set up component registers
[   18.941551] cxl_core:devm_cxl_add_port:925:  pci0000:35: port2 added to root0
[   18.941558]  pci0000:35: host supports CXL
[   18.942125] cxl_acpi:add_root_nvdimm_bridge:693: cxl_acpi ACPI0017:00: root0: add: nvdimm-bridge0
[   18.942789] cxl_core:cxl_bus_rescan_queue:2095: CXL bus rescan result: 0
[   18.956569] cxl_core:cxl_map_regblock:414: pcieport 0000:bf:00.0: Mapped CXL Memory Device resource 0x0000385800020000
[   18.967002] cxl_core:cxl_bus_probe:2077: cxl_nvdimm_bridge nvdimm-bridge0: probe: 0
[   18.967874] cxl_core:cxl_probe_component_regs:90: pcieport 0000:bf:00.0: found RAS capability (0x80)
[   18.983910] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:00.0: Unknown CM cap ID: 4 (0xd8)
[   18.983933] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:00.0: Unknown CM cap ID: 0 (0x0)
[   18.983950] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:00.0: Unknown CM cap ID: 6 (0x278)
[   18.983974] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:00.0: Unknown CM cap ID: 8 (0xaa0)
[   18.983985] cxl_core:cxl_probe_regs:435: pcieport 0000:bf:00.0: Set up component registers
[   18.984307] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:bf:00.0: Component Registers found for dport: 0x0000385800020000
[   18.984709] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:bf:00.0: dport added to port1
[   18.984960] cxl_core:cxl_map_regblock:414: pcieport 0000:bf:01.0: Mapped CXL Memory Device resource 0x0000385800000000
[   18.984987] cxl_core:cxl_probe_component_regs:90: pcieport 0000:bf:01.0: found RAS capability (0x80)
[   18.985003] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:01.0: Unknown CM cap ID: 4 (0xd8)
[   18.985020] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:01.0: Unknown CM cap ID: 0 (0x0)
[   18.985037] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:01.0: Unknown CM cap ID: 6 (0x278)
[   18.985056] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:01.0: Unknown CM cap ID: 8 (0xaa0)
[   18.985066] cxl_core:cxl_probe_regs:435: pcieport 0000:bf:01.0: Set up component registers
[   18.985103] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:bf:01.0: Component Registers found for dport: 0x0000385800000000
[   18.985509] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:bf:01.0: dport added to port1
[   19.011478] cxl_core:init_hdm_decoder:910: cxl_port port1: decoder1.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   19.032882] cxl_core:add_hdm_decoder:37: cxl decoder1.0: Added to port port1
[   19.032980] cxl_core:init_hdm_decoder:910: cxl_port port1: decoder1.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   19.033492] cxl_core:add_hdm_decoder:37: cxl decoder1.1: Added to port port1
[   19.040220] cxl_core:init_hdm_decoder:910: cxl_port port1: decoder1.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   19.046462] cxl_core:add_hdm_decoder:37: cxl decoder1.2: Added to port port1
[   19.050173] cxl_core:init_hdm_decoder:910: cxl_port port1: decoder1.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   19.055927] cxl_core:add_hdm_decoder:37: cxl decoder1.3: Added to port port1
[   19.058882] cxl_core:cxl_bus_probe:2077: cxl_port port1: probe: 0
[   19.063594] cxl_core:cxl_map_regblock:414: pcieport 0000:35:00.0: Mapped CXL Memory Device resource 0x0000382800020000
[   19.066394] cxl_core:cxl_probe_component_regs:90: pcieport 0000:35:00.0: found RAS capability (0x80)
[   19.069410] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:00.0: Unknown CM cap ID: 4 (0xd8)
[   19.072164] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:00.0: Unknown CM cap ID: 0 (0x0)
[   19.074709] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:00.0: Unknown CM cap ID: 6 (0x278)
[   19.077235] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:00.0: Unknown CM cap ID: 8 (0xaa0)
[   19.079787] cxl_core:cxl_probe_regs:435: pcieport 0000:35:00.0: Set up component registers
[   19.082357] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:35:00.0: Component Registers found for dport: 0x0000382800020000
[   19.087492] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:35:00.0: dport added to port2
[   19.090869] cxl_core:cxl_map_regblock:414: pcieport 0000:35:01.0: Mapped CXL Memory Device resource 0x0000382800000000
[   19.093395] cxl_core:cxl_probe_component_regs:90: pcieport 0000:35:01.0: found RAS capability (0x80)
[   19.095897] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:01.0: Unknown CM cap ID: 4 (0xd8)
[   19.098220] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:01.0: Unknown CM cap ID: 0 (0x0)
[   19.100837] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:01.0: Unknown CM cap ID: 6 (0x278)
[   19.103041] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:01.0: Unknown CM cap ID: 8 (0xaa0)
[   19.105346] cxl_core:cxl_probe_regs:435: pcieport 0000:35:01.0: Set up component registers
[   19.107866] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:35:01.0: Component Registers found for dport: 0x0000382800000000
[   19.111815] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:35:01.0: dport added to port2
[   19.139483] cxl_core:init_hdm_decoder:910: cxl_port port2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   19.142679] cxl_core:add_hdm_decoder:37: cxl decoder2.0: Added to port port2
[   19.145112] cxl_core:init_hdm_decoder:910: cxl_port port2: decoder2.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   19.148446] cxl_core:add_hdm_decoder:37: cxl decoder2.1: Added to port port2
[   19.150659] cxl_core:init_hdm_decoder:910: cxl_port port2: decoder2.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   19.154427] cxl_core:add_hdm_decoder:37: cxl decoder2.2: Added to port port2
[   19.157954] cxl_core:init_hdm_decoder:910: cxl_port port2: decoder2.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   19.161808] cxl_core:add_hdm_decoder:37: cxl decoder2.3: Added to port port2
[   19.165426] cxl_core:cxl_bus_probe:2077: cxl_port port2: probe: 0
[   20.382246] EXT4-fs (sda2): mounted filesystem 4ced6eee-b85f-46b6-988c-222ab3a03b5d r/w with ordered data mode. Quota mode: none.
[   21.487953] systemd-journald[228]: Received SIGTERM from PID 1 (systemd).
[   22.395769] systemd[1]: systemd 254.16-1.fc39 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[   22.403376] systemd[1]: Detected virtualization kvm.
[   22.406101] systemd[1]: Detected architecture x86-64.
[   22.420298] systemd[1]: Initializing machine ID from random generator.
[   23.428928] systemd[1]: bpf-lsm: BPF LSM hook not enabled in the kernel, BPF LSM not supported
[   24.024833] systemd[1]: initrd-switch-root.service: Current command vanished from the unit file, execution of the command list won't be resumed.
[   24.119096] systemd[1]: initrd-switch-root.service: Deactivated successfully.
[   24.125661] systemd[1]: Stopped initrd-switch-root.service - Switch Root.
[   24.134845] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[   24.141792] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
[   24.148144] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[   24.154144] systemd[1]: Created slice system-serial\x2dgetty.slice - Slice /system/serial-getty.
[   24.160193] systemd[1]: Created slice system-sshd\x2dkeygen.slice - Slice /system/sshd-keygen.
[   24.165716] systemd[1]: Created slice user.slice - User and Session Slice.
[   24.169969] systemd[1]: systemd-ask-password-plymouth.path: Deactivated successfully.
[   24.172486] systemd[1]: Stopped systemd-ask-password-plymouth.path.
[   24.175716] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[   24.184191] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[   24.190088] systemd[1]: Expecting device dev-ttyS0.device - /dev/ttyS0...
[   24.194441] systemd[1]: Stopped target initrd-switch-root.target - Switch Root.
[   24.201736] systemd[1]: Stopped target initrd-fs.target - Initrd File Systems.
[   24.205610] systemd[1]: Stopped target initrd-root-fs.target - Initrd Root File System.
[   24.214719] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[   24.218856] systemd[1]: Reached target remote-cryptsetup.target - Remote Encrypted Volumes.
[   24.225709] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[   24.231509] systemd[1]: Reached target slices.target - Slice Units.
[   24.234683] systemd[1]: Reached target swap.target - Swaps.
[   24.238170] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[   24.250641] systemd[1]: Listening on systemd-coredump.socket - Process Core Dump Socket.
[   24.258511] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[   24.274214] systemd[1]: systemd-journald-audit.socket - Journal Audit Socket was skipped because of an unmet condition check (ConditionSecurity=audit).
[   24.279975] systemd[1]: Listening on systemd-networkd.socket - Network Service Netlink Socket.
[   24.284792] systemd[1]: systemd-oomd.socket - Userspace Out-Of-Memory (OOM) Killer Socket was skipped because of an unmet condition check (ConditionPathExists=/proc/pressure/memory).
[   24.285758] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[   24.298468] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[   24.304388] systemd[1]: Listening on systemd-userdbd.socket - User Database Manager Socket.
[   24.347951] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[   24.359888] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[   24.375096] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[   24.387225] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[   24.400556] systemd[1]: Mounting tmp.mount - Temporary Directory /tmp...
[   24.412823] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[   24.429322] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[   24.443524] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[   24.457327] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[   24.470563] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[   24.483620] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[   24.496044] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[   24.500750] systemd[1]: Stopping plymouth-start.service...
[   24.507573] systemd[1]: plymouth-switch-root.service: Deactivated successfully.
[   24.507922] systemd[1]: Stopped plymouth-switch-root.service.
[   24.517832] systemd[1]: systemd-fsck-root.service: Deactivated successfully.
[   24.518182] systemd[1]: Stopped systemd-fsck-root.service - File System Check on Root Device.
[   24.569565] systemd[1]: Starting systemd-journald.service - Journal Service...
[   24.587081] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[   24.600114] systemd[1]: Starting systemd-network-generator.service - Generate network units from Kernel command line...
[   24.605270] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/StubPcrKernelImage-4a67b082-0a4c-41cf-b6c7-440b29bb8c4f).
[   24.620015] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[   24.623984] systemd-journald[616]: Collecting audit messages is disabled.
[   24.642791] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[   24.650145] systemd[1]: systemd-vconsole-setup.service: Deactivated successfully.
[   24.655310] systemd[1]: Stopped systemd-vconsole-setup.service - Virtual Console Setup.
[   24.667208] cxl_acpi:cxl_acpi_test:6: cxl_acpi for cxl_test
[   24.669612] cxl_core:cxl_core_test:6: cxl_core for cxl_test
[   24.670417] systemd[1]: Started systemd-journald.service - Journal Service.
[   24.672271] cxl_mem:cxl_mem_test:6: cxl_mem for cxl_test
[   24.672287] cxl_pmem:cxl_pmem_test:6: cxl_pmem for cxl_test
[   24.672295] cxl_port:cxl_port_test:6: cxl_port for cxl_test
[   24.685948] cxl_core:devm_cxl_add_port:925: cxl_acpi cxl_acpi.0: root3 added (root port)
[   24.689103] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.0: UID found: 0
[   24.691782] platform cxl_host_bridge.0: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[   24.693718] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.0: dport added to root3
[   24.699393] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.0: Failed to get generic port perf coordinates.
[   24.702485] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.1: UID found: 1
[   24.702501] platform cxl_host_bridge.1: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[   24.702674] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.1: dport added to root3
[   24.711392] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.1: Failed to get generic port perf coordinates.
[   24.715515] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.2: UID found: 2
[   24.715531] platform cxl_host_bridge.2: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[   24.717331] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.2: dport added to root3
[   24.726237] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.2: Failed to get generic port perf coordinates.
[   24.729738] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.3: UID found: 3
[   24.729755] platform cxl_host_bridge.3: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[   24.729764] cxl_acpi:add_host_bridge_dport:594: platform cxl_host_bridge.3: RCRB found for UID 3: 0x000ffff000600000
[   24.732990] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.3: dport added to root3
[   24.743271] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.3: Failed to get generic port perf coordinates.
[   24.746811] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff010000000 - 0xffff04fffffff]
[   24.751570] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff050000000 - 0xffff0cfffffff]
[   24.756092] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff0d0000000 - 0xffff10fffffff]
[   24.760682] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff110000000 - 0xffff18fffffff]
[   24.766039] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff190000000 - 0xffff1cfffffff]
[   24.772117] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff1d0000000 - 0xffff1dfffffff]
[   24.775042] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.0: UID found: 0
[   24.777527] platform cxl_host_bridge.0: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[   24.777544] cxl_acpi:add_host_bridge_uport:658: platform cxl_host_bridge.0: CHBCR found for UID 0: 0x000ffff000000000
[   24.778460] cxl_core:cxl_port_alloc:730: platform cxl_host_bridge.0: host-bridge: cxl_host_bridge.0
[   24.789324] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.0: dport added to port4
[   24.792782] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port4: cxl_host_bridge.0: mismatch parent cxl_host_bridge.1
[   24.793773] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.2: dport added to port4
[   24.798831] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port4: cxl_host_bridge.0: mismatch parent cxl_host_bridge.1
[   24.800786] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder4.0: Added to port port4
[   24.807404] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder4.1: Added to port port4
[   24.813028] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder4.2: Added to port port4
[   24.816842] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder4.3: Added to port port4
[   24.821411] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder4.4: Added to port port4
[   24.826164] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder4.5: Added to port port4
[   24.830716] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder4.6: Added to port port4
[   24.834419] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder4.7: Added to port port4
[   24.837279] cxl_core:cxl_bus_probe:2077: cxl_port port4: probe: 0
[   24.841707] cxl_core:devm_cxl_add_port:925: platform cxl_host_bridge.0: port4 added to root3
[   24.844393] platform cxl_host_bridge.0: host supports CXL
[   24.846490] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.1: UID found: 1
[   24.848830] platform cxl_host_bridge.1: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[   24.851561] cxl_acpi:add_host_bridge_uport:658: platform cxl_host_bridge.1: CHBCR found for UID 1: 0x000ffff000200000
[   24.855299] cxl_core:cxl_port_alloc:730: platform cxl_host_bridge.1: host-bridge: cxl_host_bridge.1
[   24.859041] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port5: cxl_host_bridge.1: mismatch parent cxl_host_bridge.0
[   24.862717] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.1: dport added to port5
[   24.865288] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port5: cxl_host_bridge.1: mismatch parent cxl_host_bridge.0
[   24.869220] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.3: dport added to port5
[   24.873320] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder5.0: Added to port port5
[   24.877329] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder5.1: Added to port port5
[   24.881369] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder5.2: Added to port port5
[   24.885267] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder5.3: Added to port port5
[   24.889117] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder5.4: Added to port port5
[   24.892807] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder5.5: Added to port port5
[   24.896828] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder5.6: Added to port port5
[   24.901743] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder5.7: Added to port port5
[   24.904491] cxl_core:cxl_bus_probe:2077: cxl_port port5: probe: 0
[   24.905614] cxl_core:devm_cxl_add_port:925: platform cxl_host_bridge.1: port5 added to root3
[   24.909899] platform cxl_host_bridge.1: host supports CXL
[   24.912254] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.2: UID found: 2
[   24.914355] platform cxl_host_bridge.2: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[   24.916808] cxl_acpi:add_host_bridge_uport:658: platform cxl_host_bridge.2: CHBCR found for UID 2: 0x000ffff000400000
[   24.919404] cxl_core:cxl_port_alloc:730: platform cxl_host_bridge.2: host-bridge: cxl_host_bridge.2
[   24.922942] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.4: dport added to port6
[   24.927064] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder6.0: Added to port port6
[   24.930393] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder6.1: Added to port port6
[   24.934208] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder6.2: Added to port port6
[   24.939415] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder6.3: Added to port port6
[   24.943376] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder6.4: Added to port port6
[   24.946168] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder6.5: Added to port port6
[   24.950026] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder6.6: Added to port port6
[   24.954084] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder6.7: Added to port port6
[   24.956528] cxl_core:cxl_bus_probe:2077: cxl_port port6: probe: 0
[   24.959357] cxl_core:devm_cxl_add_port:925: platform cxl_host_bridge.2: port6 added to root3
[   24.961392] platform cxl_host_bridge.2: host supports CXL
[   24.961423] platform cxl_host_bridge.3: host supports CXL (restricted)
[   24.966827] cxl_core:cxl_bus_probe:2077: cxl_nvdimm_bridge nvdimm-bridge1: probe: 0
[   24.969364] cxl_acpi:add_root_nvdimm_bridge:693: cxl_acpi cxl_acpi.0: root3: add: nvdimm-bridge1
[   24.972461] cxl_core:cxl_bus_rescan_queue:2095: CXL bus rescan result: 0
[   25.040509] systemd-journald[616]: Received client request to flush runtime journal.
[   25.825298] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   25.828655] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.0: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   25.833375] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   25.836416] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x0400 enabled
[   25.839319] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4000 enabled
[   25.841279] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4102 enabled
[   25.843724] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4100 enabled
[   25.846211] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4103 enabled
[   25.848794] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4200 enabled
[   25.850886] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4300 enabled
[   25.852907] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4301 enabled
[   25.855086] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4302 enabled
[   25.857016] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x0200 enabled
[   25.858847] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x0201 unsupported by driver
[   25.860988] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x0202 unsupported by driver
[   25.862997] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4400 enabled
[   25.865266] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   25.868215] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   25.870825] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[   25.873068] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.0: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[   25.875805] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.0: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[   25.881974] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: mem0 dport_dev: cxl_switch_dport.0 parent: cxl_switch_uport.0
[   25.886563] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.0: host-bridge: cxl_host_bridge.0
[   25.893689] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.0: dport added to port7
[   25.897788] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port7: cxl_switch_uport.0: mismatch parent cxl_switch_uport.1
[   25.900992] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port7: cxl_switch_uport.0: mismatch parent cxl_switch_uport.2
[   25.903837] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port7: cxl_switch_uport.0: mismatch parent cxl_switch_uport.3
[   25.908361] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.4: dport added to port7
[   25.911083] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port7: cxl_switch_uport.0: mismatch parent cxl_switch_uport.1
[   25.913642] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port7: cxl_switch_uport.0: mismatch parent cxl_switch_uport.2
[   25.916221] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port7: cxl_switch_uport.0: mismatch parent cxl_switch_uport.3
[   25.921260] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder7.0: Added to port port7
[   25.925249] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder7.1: Added to port port7
[   25.928737] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder7.2: Added to port port7
[   25.932300] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder7.3: Added to port port7
[   25.936128] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder7.4: Added to port port7
[   25.939807] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder7.5: Added to port port7
[   25.943481] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder7.6: Added to port port7
[   25.947068] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder7.7: Added to port port7
[   25.949208] cxl_core:cxl_bus_probe:2077: cxl_port port7: probe: 0
[   25.956124] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.0: port7 added to port4
[   25.958160] cxl_core:add_port_attach_ep:1589: cxl_mem mem0: add to new port port7:cxl_switch_uport.0
[   25.967619] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: mem0 dport_dev: cxl_switch_dport.0 parent: cxl_switch_uport.0
[   25.970471] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem0: found already registered port port7:cxl_switch_uport.0
[   25.979241] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: cxl_switch_dport.0 dport_dev: cxl_root_port.0 parent: cxl_host_bridge.0
[   25.982237] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem0: found already registered port port4:cxl_host_bridge.0
[   25.992286] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   25.995094] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   26.003360] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   26.007497] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[   26.012000] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem0: probe: 0
[   26.016095] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem0: register pmem0
[   26.019487] cxl_core:cxl_port_alloc:730: cxl_mem mem0: host-bridge: cxl_host_bridge.0
[   26.027757] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder8.0: Added to port endpoint8
[   26.032645] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder8.1: Added to port endpoint8
[   26.036811] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder8.2: Added to port endpoint8
[   26.040351] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder8.3: Added to port endpoint8
[   26.043968] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder8.4: Added to port endpoint8
[   26.051247] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder8.5: Added to port endpoint8
[   26.057194] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder8.6: Added to port endpoint8
[   26.064092] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder8.7: Added to port endpoint8
[   26.076467] cxl_core:cxl_region_probe:3402: cxl_region region3: config state: 0
[   26.078879] cxl_core:cxl_bus_probe:2077: cxl_region region3: probe: -6
[   26.082206] cxl_core:devm_cxl_add_region:2499: cxl_acpi cxl_acpi.0: decoder3.0: created region3
[   26.086926] cxl_core:construct_region:3296: cxl_mock_mem cxl_mem.0: mem0:decoder8.0: construct_region region3 res: [mem 0xffff010000000-0xffff02fffffff flags 0x200] iw: 2 ig: 4096
[   26.095491] cxl_core:cxl_bus_probe:2077: cxl_port endpoint8: probe: 0
[   26.099434] cxl_core:devm_cxl_add_port:925: cxl_mem mem0: endpoint8 added to port7
[   26.102753] cxl_core:cxl_bus_probe:2077: cxl_mem mem0: probe: 0
[   26.106839] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.0: Reading event logs: f
[   26.110341] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   26.114005] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '3': Clearing 1
[   26.116703] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   26.119690] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   26.131297] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '3': Clearing 2
[   26.134510] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   26.137351] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   26.146480] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   26.151874] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 1
[   26.153977] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   26.157206] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   26.168819] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 2
[   26.172137] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 3
[   26.174518] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   26.178431] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   26.187094] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 4
[   26.190220] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 5
[   26.192820] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 6
[   26.196702] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   26.199981] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   26.203777] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 7
[   26.206231] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   26.209604] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   26.214400] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 8
[   26.216895] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 9
[   26.219853] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   26.222084] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   26.225575] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 10
[   26.228050] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 11
[   26.230334] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 12
[   26.233106] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   26.235764] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   26.238857] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 13
[   26.241934] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   26.244841] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   26.252046] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 14
[   26.254446] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 15
[   26.256998] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   26.259705] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   26.263021] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   26.266815] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   26.270108] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '0': Clearing 1
[   26.272913] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '0': Clearing 2
[   26.275203] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   26.277448] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   26.280677] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '0': Clearing 3
[   26.283047] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   26.285586] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   26.394067] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   26.396739] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.1: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   26.406726] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   26.409176] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x0400 enabled
[   26.411428] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4000 enabled
[   26.413497] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4102 enabled
[   26.415731] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4100 enabled
[   26.417745] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4103 enabled
[   26.419859] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4200 enabled
[   26.421759] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4300 enabled
[   26.423983] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4301 enabled
[   26.425950] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4302 enabled
[   26.428103] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x0200 enabled
[   26.430078] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x0201 unsupported by driver
[   26.432567] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x0202 unsupported by driver
[   26.434703] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4400 enabled
[   26.437470] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   26.440084] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   26.442801] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[   26.444865] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.1: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[   26.447057] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.1: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[   26.452958] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: mem1 dport_dev: cxl_switch_dport.1 parent: cxl_switch_uport.1
[   26.457674] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.1: host-bridge: cxl_host_bridge.1
[   26.462134] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port9: cxl_switch_uport.1: mismatch parent cxl_switch_uport.0
[   26.466084] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.1: dport added to port9
[   26.468721] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port9: cxl_switch_uport.1: mismatch parent cxl_switch_uport.2
[   26.471270] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port9: cxl_switch_uport.1: mismatch parent cxl_switch_uport.3
[   26.474082] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port9: cxl_switch_uport.1: mismatch parent cxl_switch_uport.0
[   26.477824] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.5: dport added to port9
[   26.480343] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port9: cxl_switch_uport.1: mismatch parent cxl_switch_uport.2
[   26.482630] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port9: cxl_switch_uport.1: mismatch parent cxl_switch_uport.3
[   26.486980] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder9.0: Added to port port9
[   26.491476] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder9.1: Added to port port9
[   26.494524] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder9.2: Added to port port9
[   26.499710] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder9.3: Added to port port9
[   26.503677] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder9.4: Added to port port9
[   26.508314] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder9.5: Added to port port9
[   26.512618] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder9.6: Added to port port9
[   26.517736] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder9.7: Added to port port9
[   26.520018] cxl_core:cxl_bus_probe:2077: cxl_port port9: probe: 0
[   26.522603] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.1: port9 added to port5
[   26.524820] cxl_core:add_port_attach_ep:1589: cxl_mem mem1: add to new port port9:cxl_switch_uport.1
[   26.527627] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: mem1 dport_dev: cxl_switch_dport.1 parent: cxl_switch_uport.1
[   26.530540] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem1: found already registered port port9:cxl_switch_uport.1
[   26.534671] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: cxl_switch_dport.1 dport_dev: cxl_root_port.1 parent: cxl_host_bridge.1
[   26.537843] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem1: found already registered port port5:cxl_host_bridge.1
[   26.542269] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   26.545466] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   26.550394] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   26.554192] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[   26.558720] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem1: probe: 0
[   26.561772] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem1: register pmem1
[   26.564693] cxl_core:cxl_port_alloc:730: cxl_mem mem1: host-bridge: cxl_host_bridge.1
[   26.568986] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.0: Added to port endpoint10
[   26.574215] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.1: Added to port endpoint10
[   26.577976] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.2: Added to port endpoint10
[   26.581405] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.3: Added to port endpoint10
[   26.585806] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.4: Added to port endpoint10
[   26.589973] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.5: Added to port endpoint10
[   26.594035] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.6: Added to port endpoint10
[   26.597497] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.7: Added to port endpoint10
[   26.600243] cxl_core:cxl_bus_probe:2077: cxl_port endpoint10: probe: 0
[   26.604174] cxl_core:devm_cxl_add_port:925: cxl_mem mem1: endpoint10 added to port9
[   26.607303] cxl_core:cxl_bus_probe:2077: cxl_mem mem1: probe: 0
[   26.612499] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.1: Reading event logs: f
[   26.616972] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   26.620140] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '3': Clearing 1
[   26.623964] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '3': Clearing 2
[   26.626737] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   26.629884] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   26.632757] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   26.635786] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 1
[   26.639487] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   26.642466] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   26.647551] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 2
[   26.650092] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 3
[   26.652599] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   26.655609] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   26.658115] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 4
[   26.661129] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 5
[   26.663595] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 6
[   26.665863] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   26.668404] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   26.671075] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 7
[   26.673735] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   26.676386] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   26.679255] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 8
[   26.682807] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 9
[   26.686318] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   26.689086] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   26.692058] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 10
[   26.695324] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 11
[   26.698001] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 12
[   26.700465] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   26.703092] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   26.706026] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 13
[   26.708725] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   26.711269] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   26.714640] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 14
[   26.717180] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 15
[   26.719587] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   26.722116] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   26.725417] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   26.728273] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   26.730950] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '0': Clearing 1
[   26.733617] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '0': Clearing 2
[   26.736121] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   26.739560] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   26.743083] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '0': Clearing 3
[   26.745729] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   26.748608] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   26.761478] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   26.764216] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.2: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   26.767339] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   26.771267] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x0400 enabled
[   26.771282] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4000 enabled
[   26.776706] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4102 enabled
[   26.779344] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4100 enabled
[   26.779356] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4103 enabled
[   26.779367] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4200 enabled
[   26.779378] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4300 enabled
[   26.779388] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4301 enabled
[   26.779399] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4302 enabled
[   26.779409] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x0200 enabled
[   26.779419] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x0201 unsupported by driver
[   26.779429] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x0202 unsupported by driver
[   26.779440] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4400 enabled
[   26.781181] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   26.805758] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   26.808304] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[   26.810885] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.2: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[   26.813446] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.2: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[   26.818727] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: mem2 dport_dev: cxl_switch_dport.2 parent: cxl_switch_uport.2
[   26.822753] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.2: host-bridge: cxl_host_bridge.0
[   26.830156] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port11: cxl_switch_uport.2: mismatch parent cxl_switch_uport.0
[   26.833088] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port11: cxl_switch_uport.2: mismatch parent cxl_switch_uport.1
[   26.844729] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.2: dport added to port11
[   26.847568] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port11: cxl_switch_uport.2: mismatch parent cxl_switch_uport.3
[   26.850227] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port11: cxl_switch_uport.2: mismatch parent cxl_switch_uport.0
[   26.852675] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port11: cxl_switch_uport.2: mismatch parent cxl_switch_uport.1
[   26.852874] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   26.858020] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.6: dport added to port11
[   26.860397] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port11: cxl_switch_uport.2: mismatch parent cxl_switch_uport.3
[   26.860668] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   26.864234] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.0: Added to port port11
[   26.866718] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   26.868981] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.1: Added to port port11
[   26.871066] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   26.873458] cfg80211: failed to load regulatory.db
[   26.877323] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.2: Added to port port11
[   26.882809] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.3: Added to port port11
[   26.892885] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.4: Added to port port11
[   26.900684] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.5: Added to port port11
[   26.905882] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.6: Added to port port11
[   26.909880] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.7: Added to port port11
[   26.912358] cxl_core:cxl_bus_probe:2077: cxl_port port11: probe: 0
[   26.916736] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.2: port11 added to port4
[   26.919024] cxl_core:add_port_attach_ep:1589: cxl_mem mem2: add to new port port11:cxl_switch_uport.2
[   26.922944] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: mem2 dport_dev: cxl_switch_dport.2 parent: cxl_switch_uport.2
[   26.925480] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem2: found already registered port port11:cxl_switch_uport.2
[   26.929154] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: cxl_switch_dport.2 dport_dev: cxl_root_port.2 parent: cxl_host_bridge.0
[   26.932084] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem2: found already registered port port4:cxl_host_bridge.0
[   26.939839] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   26.942152] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   26.956134] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   26.959325] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[   26.967238] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem2: probe: 0
[   26.970180] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem2: register pmem2
[   26.974803] cxl_core:cxl_port_alloc:730: cxl_mem mem2: host-bridge: cxl_host_bridge.0
[   26.983319] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.0: Added to port endpoint12
[   26.987233] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.1: Added to port endpoint12
[   26.991026] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.2: Added to port endpoint12
[   26.996261] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.3: Added to port endpoint12
[   27.005346] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.4: Added to port endpoint12
[   27.012130] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.5: Added to port endpoint12
[   27.020074] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.6: Added to port endpoint12
[   27.023845] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.7: Added to port endpoint12
[   27.026043] cxl_core:cxl_bus_probe:2077: cxl_port endpoint12: probe: 0
[   27.027434] cxl_core:devm_cxl_add_port:925: cxl_mem mem2: endpoint12 added to port11
[   27.035200] cxl_core:cxl_bus_probe:2077: cxl_mem mem2: probe: 0
[   27.040279] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.2: Reading event logs: f
[   27.047256] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.050639] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '3': Clearing 1
[   27.052819] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '3': Clearing 2
[   27.054932] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.057297] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.060664] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.063879] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 1
[   27.066097] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.069019] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.072141] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 2
[   27.074252] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 3
[   27.076819] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.079046] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   27.082416] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 4
[   27.084563] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 5
[   27.086596] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 6
[   27.088625] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   27.090757] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.093098] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 7
[   27.095315] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.097507] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.101024] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 8
[   27.104124] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 9
[   27.106560] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.109079] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   27.112708] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 10
[   27.114844] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 11
[   27.117105] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 12
[   27.119492] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   27.121797] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.124699] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 13
[   27.126762] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.129085] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.133281] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 14
[   27.135489] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 15
[   27.137584] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.140054] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.142545] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.145104] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.147800] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '0': Clearing 1
[   27.149881] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '0': Clearing 2
[   27.152265] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.154481] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.157055] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '0': Clearing 3
[   27.159319] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.161571] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.177209] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   27.179674] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.3: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   27.182443] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   27.184820] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x0400 enabled
[   27.187007] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4000 enabled
[   27.189129] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4102 enabled
[   27.191205] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4100 enabled
[   27.193222] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4103 enabled
[   27.195234] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4200 enabled
[   27.197215] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4300 enabled
[   27.199259] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4301 enabled
[   27.201247] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4302 enabled
[   27.203245] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x0200 enabled
[   27.205175] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x0201 unsupported by driver
[   27.207111] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x0202 unsupported by driver
[   27.209134] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4400 enabled
[   27.214548] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   27.217875] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   27.220574] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[   27.222900] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.3: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[   27.225194] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.3: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[   27.233903] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: mem3 dport_dev: cxl_switch_dport.3 parent: cxl_switch_uport.3
[   27.247575] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.3: host-bridge: cxl_host_bridge.1
[   27.253975] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.3: mismatch parent cxl_switch_uport.0
[   27.256804] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.3: mismatch parent cxl_switch_uport.1
[   27.259039] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.3: mismatch parent cxl_switch_uport.2
[   27.262859] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.3: dport added to port13
[   27.264972] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.3: mismatch parent cxl_switch_uport.0
[   27.267381] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.3: mismatch parent cxl_switch_uport.1
[   27.269676] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.3: mismatch parent cxl_switch_uport.2
[   27.273855] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.7: dport added to port13
[   27.278168] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.0: Added to port port13
[   27.282159] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.1: Added to port port13
[   27.286067] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.2: Added to port port13
[   27.295855] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.3: Added to port port13
[   27.299615] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.4: Added to port port13
[   27.303237] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.5: Added to port port13
[   27.307990] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.6: Added to port port13
[   27.315996] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.7: Added to port port13
[   27.317873] cxl_core:cxl_bus_probe:2077: cxl_port port13: probe: 0
[   27.321490] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.3: port13 added to port5
[   27.323947] cxl_core:add_port_attach_ep:1589: cxl_mem mem3: add to new port port13:cxl_switch_uport.3
[   27.327610] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: mem3 dport_dev: cxl_switch_dport.3 parent: cxl_switch_uport.3
[   27.329993] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem3: found already registered port port13:cxl_switch_uport.3
[   27.334926] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: cxl_switch_dport.3 dport_dev: cxl_root_port.3 parent: cxl_host_bridge.1
[   27.337902] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem3: found already registered port port5:cxl_host_bridge.1
[   27.342130] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   27.344981] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   27.355773] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   27.359900] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[   27.364453] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem3: probe: 0
[   27.366474] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem3: register pmem3
[   27.369305] cxl_core:cxl_port_alloc:730: cxl_mem mem3: host-bridge: cxl_host_bridge.1
[   27.375226] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.0: Added to port endpoint14
[   27.379002] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.1: Added to port endpoint14
[   27.384356] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.2: Added to port endpoint14
[   27.388173] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.3: Added to port endpoint14
[   27.397821] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.4: Added to port endpoint14
[   27.403497] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.5: Added to port endpoint14
[   27.413692] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.6: Added to port endpoint14
[   27.428757] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.7: Added to port endpoint14
[   27.432014] cxl_core:cxl_bus_probe:2077: cxl_port endpoint14: probe: 0
[   27.435403] cxl_core:devm_cxl_add_port:925: cxl_mem mem3: endpoint14 added to port13
[   27.437916] cxl_core:cxl_bus_probe:2077: cxl_mem mem3: probe: 0
[   27.442743] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.3: Reading event logs: f
[   27.448387] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.452706] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '3': Clearing 1
[   27.454918] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '3': Clearing 2
[   27.457014] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.459295] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.461817] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.464533] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 1
[   27.466569] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.468700] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.471080] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 2
[   27.473165] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 3
[   27.475154] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.477364] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   27.480113] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 4
[   27.482205] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 5
[   27.484514] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 6
[   27.486429] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   27.488730] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.491404] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 7
[   27.493751] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.496515] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.499161] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 8
[   27.501373] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 9
[   27.503694] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.506068] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   27.509076] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 10
[   27.511839] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 11
[   27.514012] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 12
[   27.516444] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   27.516611] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   27.517315] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.524919] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 13
[   27.527234] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.529503] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.532345] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 14
[   27.534564] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 15
[   27.536727] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.538945] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.541504] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.544401] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.547191] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '0': Clearing 1
[   27.549613] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '0': Clearing 2
[   27.552316] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.554665] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.557644] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '0': Clearing 3
[   27.560328] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.562819] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.577879] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   27.580835] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.4: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   27.583915] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   27.586774] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x0400 enabled
[   27.589112] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4000 enabled
[   27.591298] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4102 enabled
[   27.593563] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4100 enabled
[   27.595965] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4103 enabled
[   27.598217] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4200 enabled
[   27.600662] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4300 enabled
[   27.604622] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4301 enabled
[   27.607594] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4302 enabled
[   27.609937] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x0200 enabled
[   27.612495] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x0201 unsupported by driver
[   27.616374] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x0202 unsupported by driver
[   27.620076] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4400 enabled
[   27.623297] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   27.626908] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   27.629759] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[   27.632752] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.4: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[   27.635352] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.4: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[   27.652710] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem4: scan: iter: mem4 dport_dev: cxl_switch_dport.4 parent: cxl_switch_uport.0
[   27.656227] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem4: found already registered port port7:cxl_switch_uport.0
[   27.658779] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem4: scan: iter: cxl_switch_dport.4 dport_dev: cxl_root_port.0 parent: cxl_host_bridge.0
[   27.662312] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem4: found already registered port port4:cxl_host_bridge.0
[   27.667016] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   27.669454] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   27.707354] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   27.710868] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[   27.715606] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem4: probe: 0
[   27.719946] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem4: register pmem4
[   27.723814] cxl_core:cxl_port_alloc:730: cxl_mem mem4: host-bridge: cxl_host_bridge.0
[   27.764279] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.0: Added to port endpoint15
[   27.784834] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.1: Added to port endpoint15
[   27.789270] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.2: Added to port endpoint15
[   27.791743] cxl_core:cxl_map_regblock:414: cxl_pci 0000:c2:00.0: Mapped CXL Memory Device resource 0x0000000082600000
[   27.794116] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.3: Added to port endpoint15
[   27.796305] cxl_core:cxl_probe_device_regs:147: cxl_pci 0000:c2:00.0: found Status capability (0x80)
[   27.800973] cxl_core:cxl_probe_device_regs:151: cxl_pci 0000:c2:00.0: found Mailbox capability (0x88)
[   27.801307] cxl_core:cxl_map_regblock:414: cxl_pci 0000:c4:00.0: Mapped CXL Memory Device resource 0x0000000082200000
[   27.801677] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.4: Added to port endpoint15
[   27.802437] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.5: Added to port endpoint15
[   27.803102] cxl_core:cxl_probe_device_regs:158: cxl_pci 0000:c2:00.0: found Memory Device capability (0x8a8)
[   27.803127] cxl_core:cxl_probe_regs:449: cxl_pci 0000:c2:00.0: Probing device registers...
[   27.804231] cxl_core:cxl_probe_device_regs:147: cxl_pci 0000:c4:00.0: found Status capability (0x80)
[   27.804746] cxl_core:cxl_map_regblock:414: cxl_pci 0000:c2:00.0: Mapped CXL Memory Device resource 0x0000000082640000
[   27.805106] cxl_core:cxl_probe_component_regs:90: cxl_pci 0000:c2:00.0: found RAS capability (0x80)
[   27.805159] cxl_core:cxl_probe_component_regs:96: cxl_pci 0000:c2:00.0: Unknown CM cap ID: 4 (0xd8)
[   27.805179] cxl_core:cxl_probe_component_regs:81: cxl_pci 0000:c2:00.0: found HDM decoder capability (0x128)
[   27.805189] cxl_core:cxl_probe_regs:435: cxl_pci 0000:c2:00.0: Set up component registers
[   27.806525] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.6: Added to port endpoint15
[   27.808193] cxl_core:cxl_probe_device_regs:151: cxl_pci 0000:c4:00.0: found Mailbox capability (0x88)
[   27.808223] cxl_core:cxl_probe_device_regs:158: cxl_pci 0000:c4:00.0: found Memory Device capability (0x8a8)
[   27.808234] cxl_core:cxl_probe_regs:449: cxl_pci 0000:c4:00.0: Probing device registers...
[   27.809718] cxl_core:cxl_map_regblock:414: cxl_pci 0000:c4:00.0: Mapped CXL Memory Device resource 0x0000000082240000
[   27.815114] cxl_core:cxl_map_regblock:414: cxl_pci 0000:3a:00.0: Mapped CXL Memory Device resource 0x0000000081600000
[   27.815897] cxl_core:cxl_probe_component_regs:90: cxl_pci 0000:c4:00.0: found RAS capability (0x80)
[   27.816910] cxl_core:cxl_probe_device_regs:147: cxl_pci 0000:3a:00.0: found Status capability (0x80)
[   27.817503] cxl_core:cxl_probe_component_regs:96: cxl_pci 0000:c4:00.0: Unknown CM cap ID: 4 (0xd8)
[   27.818431] cxl_core:cxl_probe_device_regs:151: cxl_pci 0000:3a:00.0: found Mailbox capability (0x88)
[   27.819187] cxl_core:cxl_probe_component_regs:81: cxl_pci 0000:c4:00.0: found HDM decoder capability (0x128)
[   27.819198] cxl_core:cxl_probe_regs:435: cxl_pci 0000:c4:00.0: Set up component registers
[   27.820550] cxl_core:cxl_map_regblock:414: cxl_pci 0000:38:00.0: Mapped CXL Memory Device resource 0x0000000081a00000
[   27.821708] cxl_core:cxl_probe_device_regs:158: cxl_pci 0000:3a:00.0: found Memory Device capability (0x8a8)
[   27.821723] cxl_core:cxl_probe_regs:449: cxl_pci 0000:3a:00.0: Probing device registers...
[   27.822933] cxl_core:cxl_map_regblock:414: cxl_pci 0000:3a:00.0: Mapped CXL Memory Device resource 0x0000000081640000
[   27.823690] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.7: Added to port endpoint15
[   27.823933] cxl_core:cxl_calc_interleave_pos:1833: cxl_mem mem0: decoder:decoder8.0 parent:cxl_mem.0 port:endpoint8 range:0xffff010000000-0xffff02fffffff pos:0
[   27.824012] cxl_core:cxl_calc_interleave_pos:1833: cxl_mem mem4: decoder:decoder15.0 parent:cxl_mem.4 port:endpoint15 range:0xffff010000000-0xffff02fffffff pos:1
[   27.824031] cxl_core:cxl_region_sort_targets:1862: cxl region3: region sort successful
[   27.824531] cxl_core:cxl_port_attach_region:1134: cxl region3: mem0:endpoint8 decoder8.0 add: mem0:decoder8.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[   27.825071] cxl_core:cxl_probe_device_regs:147: cxl_pci 0000:38:00.0: found Status capability (0x80)
[   27.825099] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_switch_uport.0:port7 decoder7.0 add: mem0:decoder8.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[   27.825574] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_host_bridge.0:port4 decoder4.0 add: mem0:decoder8.0 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
[   27.825770] cxl_core:cxl_port_attach_region:1134: cxl region3: mem4:endpoint15 decoder15.0 add: mem4:decoder15.0 @ 1 next: none nr_eps: 1 nr_targets: 1
[   27.825813] cxl_core:cxl_probe_component_regs:90: cxl_pci 0000:3a:00.0: found RAS capability (0x80)
[   27.825871] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_switch_uport.0:port7 decoder7.0 add: mem4:decoder15.0 @ 1 next: mem4 nr_eps: 2 nr_targets: 2
[   27.825983] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_host_bridge.0:port4 decoder4.0 add: mem4:decoder15.0 @ 1 next: cxl_switch_uport.0 nr_eps: 2 nr_targets: 1
[   27.826008] cxl_core:cxl_port_setup_targets:1444: cxl region3: cxl_host_bridge.0:port4 iw: 1 ig: 4096
[   27.826021] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_host_bridge.0:port4 target[0] = cxl_root_port.0 for mem0:decoder8.0 @ 0
[   27.826041] cxl_core:cxl_port_setup_targets:1444: cxl region3: cxl_switch_uport.0:port7 iw: 2 ig: 4096
[   27.826053] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_switch_uport.0:port7 target[0] = cxl_switch_dport.0 for mem0:decoder8.0 @ 0
[   27.826073] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_host_bridge.0:port4 target[0] = cxl_root_port.0 for mem4:decoder15.0 @ 1
[   27.826091] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_switch_uport.0:port7 target[1] = cxl_switch_dport.4 for mem4:decoder15.0 @ 1
[   27.826593] cxl_core:cxl_probe_device_regs:151: cxl_pci 0000:38:00.0: found Mailbox capability (0x88)
[   27.827657] cxl_core:cxl_probe_component_regs:96: cxl_pci 0000:3a:00.0: Unknown CM cap ID: 4 (0xd8)
[   27.827970] cxl_core:devm_cxl_add_dax_region:3185: cxl_region region3: region3: register dax_region3
[   27.828019] cxl_core:cxl_bus_probe:2077: cxl_region region3: probe: 0
[   27.828591] cxl_core:cxl_probe_device_regs:158: cxl_pci 0000:38:00.0: found Memory Device capability (0x8a8)
[   27.828659] cxl_core:cxl_bus_probe:2077: cxl_port endpoint15: probe: 0
[   27.828924] cxl_core:devm_cxl_add_port:925: cxl_mem mem4: endpoint15 added to port7
[   27.828960] cxl_core:cxl_bus_probe:2077: cxl_mem mem4: probe: 0
[   27.829685] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.4: Reading event logs: f
[   27.829700] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.829725] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '3': Clearing 1
[   27.829736] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '3': Clearing 2
[   27.829746] cxl_core:cxl_probe_component_regs:81: cxl_pci 0000:3a:00.0: found HDM decoder capability (0x128)
[   27.829747] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.829758] cxl_core:cxl_probe_regs:435: cxl_pci 0000:3a:00.0: Set up component registers
[   27.829769] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.829786] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.829807] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 1
[   27.829817] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.829837] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.829859] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 2
[   27.829906] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   27.829927] cxl_pci:cxl_pci_setup_mailbox:438: cxl_pci 0000:c2:00.0: Mailbox payload sized 2048
[   27.831182] cxl_core:cxl_probe_regs:449: cxl_pci 0000:38:00.0: Probing device registers...
[   27.831348] cxl_pci:cxl_pci_setup_mailbox:455: cxl_pci 0000:c2:00.0: Mailbox interrupts enabled
[   27.832128] cxl_core:cxl_map_regblock:414: cxl_pci 0000:38:00.0: Mapped CXL Memory Device resource 0x0000000081a40000
[   27.832159] cxl_core:cxl_probe_component_regs:90: cxl_pci 0000:38:00.0: found RAS capability (0x80)
[   27.832173] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 3
[   27.832192] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.832223] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   27.832249] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 4
[   27.832259] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 5
[   27.832269] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 6
[   27.832279] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   27.832299] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.832319] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 7
[   27.832330] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.832349] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.832370] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 8
[   27.832380] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 9
[   27.832390] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.832410] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   27.832431] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 10
[   27.832441] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 11
[   27.832452] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 12
[   27.832461] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   27.832481] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.832503] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 13
[   27.832513] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.832532] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.832553] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 14
[   27.832563] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 15
[   27.832573] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.832592] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.832606] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.832620] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.832646] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '0': Clearing 1
[   27.832656] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '0': Clearing 2
[   27.832666] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.832686] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   27.832707] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '0': Clearing 3
[   27.832717] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   27.832736] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   27.833156] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x0400
[   27.833894] cxl_core:cxl_probe_component_regs:96: cxl_pci 0000:38:00.0: Unknown CM cap ID: 4 (0xd8)
[   27.834693] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   27.835810] cxl_core:cxl_probe_component_regs:81: cxl_pci 0000:38:00.0: found HDM decoder capability (0x128)
[   27.836944] cxl_core:cxl_enumerate_cmds:818: cxl_pci 0000:c2:00.0: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 88
[   27.837569] cxl_core:cxl_probe_regs:435: cxl_pci 0000:38:00.0: Set up component registers
[   27.838869] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x0401
[   27.839014] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   27.839035] cxl_pci:cxl_pci_setup_mailbox:438: cxl_pci 0000:c4:00.0: Mailbox payload sized 2048
[   27.843374] cxl_pci:cxl_pci_setup_mailbox:455: cxl_pci 0000:c4:00.0: Mailbox interrupts enabled
[   27.847556] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   27.848820] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x0400
[   27.850344] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x0100 unsupported by driver
[   27.851273] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   27.852126] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x0101 unsupported by driver
[   27.853376] cxl_core:cxl_enumerate_cmds:818: cxl_pci 0000:c4:00.0: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 88
[   27.854626] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x0102 unsupported by driver
[   27.854960] parport_pc 00:02: reported by Plug and Play ACPI
[   27.856167] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x0401
[   27.857172] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x0103 unsupported by driver
[   27.858547] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   27.860110] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x0200 enabled
[   27.860925] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   27.860945] cxl_pci:cxl_pci_setup_mailbox:438: cxl_pci 0000:38:00.0: Mailbox payload sized 2048
[   27.861085] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   27.861797] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x0100 unsupported by driver
[   27.861809] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x0101 unsupported by driver
[   27.861818] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x0102 unsupported by driver
[   27.861828] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x0103 unsupported by driver
[   27.861837] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x0200 enabled
[   27.861847] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x0300 enabled
[   27.861856] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x0301 unsupported by driver
[   27.861865] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x0400 enabled
[   27.861874] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x0401 enabled
[   27.861883] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4000 enabled
[   27.861900] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4100 enabled
[   27.861909] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4102 enabled
[   27.861918] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4103 enabled
[   27.861928] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4300 enabled
[   27.861937] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4301 enabled
[   27.861946] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4302 enabled
[   27.861956] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4303 enabled
[   27.861965] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4304 enabled
[   27.861974] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4305 enabled
[   27.861984] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4400 enabled
[   27.861994] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x4500 enabled
[   27.862003] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c4:00.0: Opcode 0x5500 unsupported by driver
[   27.862385] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x0300 enabled
[   27.862433] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x0301
[   27.862461] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   27.862601] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x4000
[   27.862628] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   27.862716] cxl_core:add_dpa_res:1255: cxl_pci 0000:c4:00.0: DPA(ram): [mem 0x00000000-0x0fffffff flags 0x200]
[   27.862730] cxl_core:add_dpa_res:1245: cxl_pci 0000:c4:00.0: DPA(pmem): no capacity
[   27.862932] cxl_pci:cxl_pci_setup_mailbox:455: cxl_pci 0000:38:00.0: Mailbox interrupts enabled
[   27.863222] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x0400
[   27.863289] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   27.863445] cxl_core:cxl_enumerate_cmds:818: cxl_pci 0000:38:00.0: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 88
[   27.863676] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x0401
[   27.863709] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   27.863846] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x0100 unsupported by driver
[   27.863845] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.5: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   27.863885] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   27.863910] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0400 enabled
[   27.863920] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4000 enabled
[   27.863929] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4102 enabled
[   27.863939] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4100 enabled
[   27.863948] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4103 enabled
[   27.863957] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4200 enabled
[   27.863967] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4300 enabled
[   27.863977] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4301 enabled
[   27.863986] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4302 enabled
[   27.863996] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0200 enabled
[   27.864005] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0201 unsupported by driver
[   27.864015] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0202 unsupported by driver
[   27.864025] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4400 enabled
[   27.864070] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   27.864082] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   27.864094] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[   27.864107] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.5: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[   27.864121] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.5: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[   27.865163] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x0301 unsupported by driver
[   27.866283] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x0101 unsupported by driver
[   27.867443] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x0400 enabled
[   27.867454] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x0401 enabled
[   27.867463] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4000 enabled
[   27.868332] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x0102 unsupported by driver
[   27.869109] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4100 enabled
[   27.869913] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x0103 unsupported by driver
[   27.870485] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4102 enabled
[   27.871797] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x0200 enabled
[   27.871904] parport0: PC-style at 0x378 [PCSPP,TRISTATE]
[   27.872251] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   27.872275] cxl_pci:cxl_pci_setup_mailbox:438: cxl_pci 0000:3a:00.0: Mailbox payload sized 2048
[   27.872553] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4103 enabled
[   27.872564] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4300 enabled
[   27.872673] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem6: scan: iter: mem6 dport_dev: cxl_switch_dport.5 parent: cxl_switch_uport.1
[   27.872804] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem6: found already registered port port9:cxl_switch_uport.1
[   27.872908] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem6: scan: iter: cxl_switch_dport.5 dport_dev: cxl_root_port.1 parent: cxl_host_bridge.1
[   27.872945] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem6: found already registered port port5:cxl_host_bridge.1
[   27.873146] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x0300 enabled
[   27.873657] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4301 enabled
[   27.874543] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x0301 unsupported by driver
[   27.874814] cxl_pci:cxl_pci_setup_mailbox:455: cxl_pci 0000:3a:00.0: Mailbox interrupts enabled
[   27.874979] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x0400
[   27.875024] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   27.875249] cxl_core:cxl_enumerate_cmds:818: cxl_pci 0000:3a:00.0: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 88
[   27.875383] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x0401
[   27.875403] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   27.875455] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4302 enabled
[   27.875495] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x0100 unsupported by driver
[   27.875507] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x0101 unsupported by driver
[   27.875517] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x0102 unsupported by driver
[   27.875527] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x0103 unsupported by driver
[   27.875536] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x0200 enabled
[   27.875546] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x0300 enabled
[   27.875555] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x0301 unsupported by driver
[   27.875565] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x0400 enabled
[   27.875574] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x0401 enabled
[   27.875583] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4000 enabled
[   27.875592] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4100 enabled
[   27.875601] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4102 enabled
[   27.875611] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4103 enabled
[   27.875620] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4300 enabled
[   27.875629] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4301 enabled
[   27.875639] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4302 enabled
[   27.875648] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4303 enabled
[   27.875657] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4304 enabled
[   27.875667] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4305 enabled
[   27.875676] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4400 enabled
[   27.875686] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x4500 enabled
[   27.875695] cxl_core:cxl_walk_cel:748: cxl_pci 0000:3a:00.0: Opcode 0x5500 unsupported by driver
[   27.875778] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x0301
[   27.875832] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   27.876006] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem5: scan: iter: mem5 dport_dev: 0000:c1:02.0 parent: 0000:c0:00.0
[   27.876022] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x4000
[   27.876072] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   27.876613] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x0400 enabled
[   27.876673] cxl_core:add_dpa_res:1255: cxl_pci 0000:3a:00.0: DPA(ram): [mem 0x00000000-0x0fffffff flags 0x200]
[   27.876688] cxl_core:add_dpa_res:1245: cxl_pci 0000:3a:00.0: DPA(pmem): no capacity
[   27.877501] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4303 enabled
[   27.878217] cxl_core:cxl_port_alloc:730: pcieport 0000:c0:00.0: host-bridge: pci0000:bf
[   27.878369] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x0401 enabled
[   27.878457] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem7: scan: iter: mem7 dport_dev: 0000:37:02.0 parent: 0000:36:00.0
[   27.879275] cxl_core:cxl_map_regblock:414: cxl port16: Mapped CXL Memory Device resource 0x0000000082940000
[   27.879378] cxl_core:cxl_probe_component_regs:90: cxl port16: found RAS capability (0x80)
[   27.879397] cxl_core:cxl_probe_component_regs:96: cxl port16: Unknown CM cap ID: 4 (0xd8)
[   27.879433] cxl_core:cxl_probe_component_regs:81: cxl port16: found HDM decoder capability (0x128)
[   27.879439] cxl_core:cxl_port_alloc:730: pcieport 0000:36:00.0: host-bridge: pci0000:35
[   27.879442] cxl_core:cxl_probe_regs:435: cxl port16: Set up component registers
[   27.879488] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4304 enabled
[   27.879545] cxl_core:cxl_map_regblock:414: cxl port17: Mapped CXL Memory Device resource 0x0000000081d40000
[   27.879623] cxl_core:cxl_probe_component_regs:90: cxl port17: found RAS capability (0x80)
[   27.879712] cxl_core:cxl_probe_component_regs:96: cxl port17: Unknown CM cap ID: 4 (0xd8)
[   27.879731] cxl_core:cxl_probe_component_regs:81: cxl port17: found HDM decoder capability (0x128)
[   27.879741] cxl_core:cxl_probe_regs:435: cxl port17: Set up component registers
[   27.879769] i801_smbus 0000:00:1f.3: Enabling SMBus device
[   27.880226] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   27.880387] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4000 enabled
[   27.881211] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4305 enabled
[   27.882114] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4100 enabled
[   27.889332] cxl_core:cxl_cdat_get_length:540: cxl_port port16: CDAT length 112
[   27.889459] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4400 enabled
[   27.889626] cxl_core:cxl_cdat_get_length:540: cxl_port port17: CDAT length 112
[   27.891156] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4102 enabled
[   27.891167] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4103 enabled
[   27.892219] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   27.892258] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   27.893991] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x4500 enabled
[   27.896467] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   27.896561] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[   27.896773] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem6: probe: 0
[   27.896929] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem6: register pmem6
[   27.896978] cxl_core:cxl_port_alloc:730: cxl_mem mem6: host-bridge: cxl_host_bridge.1
[   27.897380] cxl_core:cxl_map_regblock:414: pcieport 0000:37:00.0: Mapped CXL Memory Device resource 0x0000000081c00000
[   27.897386] cxl_core:cxl_map_regblock:414: pcieport 0000:c1:00.0: Mapped CXL Memory Device resource 0x0000000082800000
[   27.897460] cxl_core:cxl_probe_component_regs:90: pcieport 0000:c1:00.0: found RAS capability (0x80)
[   27.897463] cxl_core:cxl_probe_component_regs:90: pcieport 0000:37:00.0: found RAS capability (0x80)
[   27.897482] cxl_core:cxl_probe_component_regs:96: pcieport 0000:c1:00.0: Unknown CM cap ID: 4 (0xd8)
[   27.897489] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4300 enabled
[   27.897495] cxl_core:cxl_probe_regs:435: pcieport 0000:c1:00.0: Set up component registers
[   27.897508] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4301 enabled
[   27.897519] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4302 enabled
[   27.897529] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4303 enabled
[   27.897538] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4304 enabled
[   27.897548] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4305 enabled
[   27.897557] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4400 enabled
[   27.897567] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x4500 enabled
[   27.897567] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:c1:00.0: Component Registers found for dport: 0x0000000082800000
[   27.897577] cxl_core:cxl_walk_cel:748: cxl_pci 0000:38:00.0: Opcode 0x5500 unsupported by driver
[   27.897738] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x0301
[   27.897767] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   27.897976] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x4000
[   27.898055] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   27.898166] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:c1:00.0: dport added to port16
[   27.898324] cxl_core:cxl_walk_cel:748: cxl_pci 0000:c2:00.0: Opcode 0x5500 unsupported by driver
[   27.898348] cxl_core:add_dpa_res:1255: cxl_pci 0000:38:00.0: DPA(ram): [mem 0x00000000-0x0fffffff flags 0x200]
[   27.899083] cxl_core:cxl_map_regblock:414: pcieport 0000:c1:01.0: Mapped CXL Memory Device resource 0x0000000082820000
[   27.899119] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x0301
[   27.899130] cxl_core:cxl_probe_component_regs:90: pcieport 0000:c1:01.0: found RAS capability (0x80)
[   27.899201] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   27.899628] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x4000
[   27.899687] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   27.899732] cxl_core:cxl_probe_component_regs:96: pcieport 0000:c1:01.0: Unknown CM cap ID: 4 (0xd8)
[   27.899745] cxl_core:add_dpa_res:1255: cxl_pci 0000:c2:00.0: DPA(ram): [mem 0x00000000-0x0fffffff flags 0x200]
[   27.899757] cxl_core:cxl_probe_regs:435: pcieport 0000:c1:01.0: Set up component registers
[   27.899763] cxl_core:add_dpa_res:1245: cxl_pci 0000:c2:00.0: DPA(pmem): no capacity
[   27.899836] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.0: Added to port endpoint18
[   27.899835] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:c1:01.0: Component Registers found for dport: 0x0000000082820000
[   27.900110] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:c1:01.0: dport added to port16
[   27.901049] cxl_core:cxl_map_regblock:414: pcieport 0000:c1:02.0: Mapped CXL Memory Device resource 0x0000000082840000
[   27.901313] cxl_core:add_dpa_res:1245: cxl_pci 0000:38:00.0: DPA(pmem): no capacity
[   27.901461] cxl_core:cxl_probe_component_regs:96: pcieport 0000:37:00.0: Unknown CM cap ID: 4 (0xd8)
[   27.901486] cxl_core:cxl_probe_regs:435: pcieport 0000:37:00.0: Set up component registers
[   27.901595] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:37:00.0: Component Registers found for dport: 0x0000000081c00000
[   27.902086] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:37:00.0: dport added to port17
[   27.902729] cxl_core:cxl_probe_component_regs:90: pcieport 0000:c1:02.0: found RAS capability (0x80)
[   27.902921] cxl_core:cxl_map_regblock:414: pcieport 0000:37:01.0: Mapped CXL Memory Device resource 0x0000000081c20000
[   27.902955] cxl_core:cxl_probe_component_regs:90: pcieport 0000:37:01.0: found RAS capability (0x80)
[   27.902972] cxl_core:cxl_probe_component_regs:96: pcieport 0000:37:01.0: Unknown CM cap ID: 4 (0xd8)
[   27.902983] cxl_core:cxl_probe_regs:435: pcieport 0000:37:01.0: Set up component registers
[   27.903020] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem8: scan: iter: mem8 dport_dev: 0000:c1:00.0 parent: 0000:c0:00.0
[   27.903030] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:37:01.0: Component Registers found for dport: 0x0000000081c20000
[   27.903331] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:37:01.0: dport added to port17
[   27.903408] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem8: found already registered port port16:0000:c0:00.0
[   27.903824] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.1: Added to port endpoint18
[   27.903876] cxl_core:cxl_map_regblock:414: pcieport 0000:37:02.0: Mapped CXL Memory Device resource 0x0000000081c40000
[   27.903937] cxl_core:cxl_probe_component_regs:90: pcieport 0000:37:02.0: found RAS capability (0x80)
[   27.904057] cxl_core:cxl_probe_component_regs:96: pcieport 0000:37:02.0: Unknown CM cap ID: 4 (0xd8)
[   27.904068] cxl_core:cxl_probe_regs:435: pcieport 0000:37:02.0: Set up component registers
[   27.904112] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:37:02.0: Component Registers found for dport: 0x0000000081c40000
[   27.907123] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:37:02.0: dport added to port17
[   27.907806] cxl_core:cxl_probe_component_regs:96: pcieport 0000:c1:02.0: Unknown CM cap ID: 4 (0xd8)
[   27.909903] cxl_core:cxl_map_regblock:414: pcieport 0000:37:03.0: Mapped CXL Memory Device resource 0x0000000081c60000
[   27.910568] cxl_core:cxl_probe_regs:435: pcieport 0000:c1:02.0: Set up component registers
[   27.911773] cxl_core:cxl_probe_component_regs:90: pcieport 0000:37:03.0: found RAS capability (0x80)
[   27.914255] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.2: Added to port endpoint18
[   27.914751] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem9: scan: iter: mem9 dport_dev: 0000:37:00.0 parent: 0000:36:00.0
[   27.914956] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem9: found already registered port port17:0000:36:00.0
[   27.915234] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:c1:02.0: Component Registers found for dport: 0x0000000082840000
[   27.915367] cxl_core:cxl_probe_component_regs:96: pcieport 0000:37:03.0: Unknown CM cap ID: 4 (0xd8)
[   27.917239] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:c1:02.0: dport added to port16
[   27.917796] cxl_core:cxl_probe_regs:435: pcieport 0000:37:03.0: Set up component registers
[   27.919465] cxl_core:cxl_map_regblock:414: pcieport 0000:c1:03.0: Mapped CXL Memory Device resource 0x0000000082860000
[   27.920357] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:37:03.0: Component Registers found for dport: 0x0000000081c60000
[   27.921628] cxl_core:cxl_probe_component_regs:90: pcieport 0000:c1:03.0: found RAS capability (0x80)
[   27.925735] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:37:03.0: dport added to port17
[   27.926163] cxl_core:cxl_probe_component_regs:96: pcieport 0000:c1:03.0: Unknown CM cap ID: 4 (0xd8)
[   27.951979] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.3: Added to port endpoint18
[   27.952515] input: PC Speaker as /devices/platform/pcspkr/input/input5
[   27.952591] cxl_core:cxl_probe_regs:435: pcieport 0000:c1:03.0: Set up component registers
[   27.952765] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:c1:03.0: Component Registers found for dport: 0x0000000082860000
[   27.954613] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:c1:03.0: dport added to port16
[   27.958785] cxl_core:init_hdm_decoder:910: cxl_port port17: decoder17.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   27.963841] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.4: Added to port endpoint18
[   27.964621] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.5: Added to port endpoint18
[   27.968125] cxl_core:add_hdm_decoder:37: cxl decoder17.0: Added to port port17
[   27.971804] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.6: Added to port endpoint18
[   27.973139] cxl_core:init_hdm_decoder:910: cxl_port port17: decoder17.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   27.978831] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.7: Added to port endpoint18
[   27.981029] cxl_core:add_hdm_decoder:37: cxl decoder17.1: Added to port port17
[   27.982924] cxl_core:cxl_bus_probe:2077: cxl_port endpoint18: probe: 0
[   27.983858] cxl_core:init_hdm_decoder:910: cxl_port port17: decoder17.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   27.985566] cxl_core:devm_cxl_add_port:925: cxl_mem mem6: endpoint18 added to port9
[   27.985567] i2c i2c-0: Memory type 0x07 not supported yet, not instantiating SPD
[   27.991118] cxl_core:add_hdm_decoder:37: cxl decoder17.2: Added to port port17
[   27.991326] cxl_core:init_hdm_decoder:910: cxl_port port16: decoder16.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   27.992293] cxl_core:add_hdm_decoder:37: cxl decoder16.0: Added to port port16
[   27.992930] cxl_core:init_hdm_decoder:910: cxl_port port17: decoder17.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   27.992946] cxl_core:cxl_bus_probe:2077: cxl_mem mem6: probe: 0
[   27.993787] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.5: Reading event logs: f
[   27.994046] cxl_core:init_hdm_decoder:910: cxl_port port16: decoder16.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   27.994999] cxl_core:add_hdm_decoder:37: cxl decoder16.1: Added to port port16
[   27.995544] cxl_core:add_hdm_decoder:37: cxl decoder17.3: Added to port port17
[   27.995558] cxl_core:cxl_bus_probe:2077: cxl_port port17: probe: 0
[   27.995637] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   27.995690] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '3': Clearing 1
[   27.996818] cxl_core:devm_cxl_add_port:925: pcieport 0000:36:00.0: port17 added to port2
[   27.996869] cxl_core:init_hdm_decoder:910: cxl_port port16: decoder16.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   27.997483] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem9: scan: iter: 0000:37:00.0 dport_dev: 0000:35:00.0 parent: pci0000:35
[   27.997536] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem9: found already registered port port2:pci0000:35
[   27.997556] cxl_core:add_hdm_decoder:37: cxl decoder16.2: Added to port port16
[   27.997806] cxl_core:init_hdm_decoder:910: cxl_port port16: decoder16.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   27.997946] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '3': Clearing 2
[   27.997965] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   27.998468] cxl_core:add_hdm_decoder:37: cxl decoder16.3: Added to port port16
[   27.998481] cxl_core:cxl_bus_probe:2077: cxl_port port16: probe: 0
[   28.000419] cxl_core:devm_cxl_add_port:925: pcieport 0000:c0:00.0: port16 added to port1
[   28.000551] cxl_core:add_port_attach_ep:1589: cxl_mem mem5: add to new port port16:0000:c0:00.0
[   28.000708] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem5: scan: iter: mem5 dport_dev: 0000:c1:02.0 parent: 0000:c0:00.0
[   28.000807] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem5: found already registered port port16:0000:c0:00.0
[   28.000837] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem5: scan: iter: 0000:c1:02.0 dport_dev: 0000:bf:00.0 parent: pci0000:bf
[   28.000854] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem5: found already registered port port1:pci0000:bf
[   28.001431] cxl_core:cxl_port_alloc:730: cxl_mem mem5: host-bridge: pci0000:bf
[   28.001505] cxl_core:add_port_attach_ep:1589: cxl_mem mem7: add to new port port17:0000:36:00.0
[   28.001591] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem7: scan: iter: mem7 dport_dev: 0000:37:02.0 parent: 0000:36:00.0
[   28.001711] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem7: found already registered port port17:0000:36:00.0
[   28.001741] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem7: scan: iter: 0000:37:02.0 dport_dev: 0000:35:00.0 parent: pci0000:35
[   28.001761] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem7: found already registered port port2:pci0000:35
[   28.002202] cxl_core:cxl_port_alloc:730: cxl_mem mem7: host-bridge: pci0000:35
[   28.002265] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   28.008412] cxl_core:cxl_cdat_get_length:540: cxl_port endpoint19: CDAT length 160
[   28.011624] cxl_core:cxl_cdat_get_length:540: cxl_port endpoint20: CDAT length 160
[   28.013174] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   28.019362] cxl_core:cxl_port_perf_data_calculate:208: cxl_port endpoint20: Failed to retrieve ep perf coordinates.
[   28.020468] cxl_core:cxl_port_perf_data_calculate:208: cxl_port endpoint19: Failed to retrieve ep perf coordinates.
[   28.020488] cxl_core:cxl_endpoint_parse_cdat:410: cxl_port endpoint19: Failed to do perf coord calculations.
[   28.022139] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 1
[   28.022607] cxl_core:cxl_endpoint_parse_cdat:410: cxl_port endpoint20: Failed to do perf coord calculations.
[   28.023388] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   28.023416] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   28.047545] cxl_core:init_hdm_decoder:910: cxl_port endpoint19: decoder19.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.049594] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 2
[   28.051439] cxl_core:init_hdm_decoder:910: cxl_port endpoint20: decoder20.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.051633] cxl_core:add_hdm_decoder:37: cxl decoder19.0: Added to port endpoint19
[   28.051708] cxl_core:init_hdm_decoder:910: cxl_port endpoint19: decoder19.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.052372] cxl_core:add_hdm_decoder:37: cxl decoder19.1: Added to port endpoint19
[   28.052417] cxl_core:init_hdm_decoder:910: cxl_port endpoint19: decoder19.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.053039] cxl_core:add_hdm_decoder:37: cxl decoder19.2: Added to port endpoint19
[   28.053082] cxl_core:init_hdm_decoder:910: cxl_port endpoint19: decoder19.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.053687] cxl_core:add_hdm_decoder:37: cxl decoder19.3: Added to port endpoint19
[   28.053702] cxl_core:cxl_bus_probe:2077: cxl_port endpoint19: probe: 0
[   28.054131] cxl_core:devm_cxl_add_port:925: cxl_mem mem5: endpoint19 added to port16
[   28.054223] cxl_core:cxl_bus_probe:2077: cxl_mem mem5: probe: 0
[   28.054484] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem8: scan: iter: 0000:c1:00.0 dport_dev: 0000:bf:00.0 parent: pci0000:bf
[   28.054534] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem8: found already registered port port1:pci0000:bf
[   28.055039] cxl_core:cxl_port_alloc:730: cxl_mem mem8: host-bridge: pci0000:bf
[   28.056821] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 3
[   28.059890] cxl_core:cxl_cdat_get_length:540: cxl_port endpoint21: CDAT length 160
[   28.060294] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   28.060499] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x0102
[   28.060567] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   28.061020] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x0103
[   28.061074] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   28.061133] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x0102
[   28.061157] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   28.061694] cxl_core:add_hdm_decoder:37: cxl decoder20.0: Added to port endpoint20
[   28.062818] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   28.064708] cxl_core:cxl_port_perf_data_calculate:208: cxl_port endpoint21: Failed to retrieve ep perf coordinates.
[   28.064727] cxl_core:cxl_endpoint_parse_cdat:410: cxl_port endpoint21: Failed to do perf coord calculations.
[   28.065632] cxl_core:init_hdm_decoder:910: cxl_port endpoint20: decoder20.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.066768] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 4
[   28.067609] cxl_core:add_hdm_decoder:37: cxl decoder20.1: Added to port endpoint20
[   28.068519] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 5
[   28.069395] cxl_core:init_hdm_decoder:910: cxl_port endpoint20: decoder20.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.069864] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 6
[   28.070175] cxl_core:cxl_mem_get_event_records:1046: cxl_pci 0000:c4:00.0: Reading event logs: f
[   28.070334] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x0100
[   28.070386] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   28.070694] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x0100
[   28.071176] cxl_core:add_hdm_decoder:37: cxl decoder20.2: Added to port endpoint20
[   28.071985] cxl_core:init_hdm_decoder:910: cxl_port endpoint20: decoder20.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.072609] cxl_core:add_hdm_decoder:37: cxl decoder20.3: Added to port endpoint20
[   28.072626] cxl_core:cxl_bus_probe:2077: cxl_port endpoint20: probe: 0
[   28.072816] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   28.072859] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   28.072905] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 7
[   28.072917] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   28.072938] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   28.072959] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 8
[   28.072969] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 9
[   28.072978] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   28.072998] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   28.073019] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 10
[   28.073029] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 11
[   28.073039] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 12
[   28.073049] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   28.073058] cxl_core:devm_cxl_add_port:925: cxl_mem mem7: endpoint20 added to port17
[   28.073068] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   28.073089] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 13
[   28.073099] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   28.073102] cxl_core:cxl_bus_probe:2077: cxl_mem mem7: probe: 0
[   28.073119] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   28.073143] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 14
[   28.073153] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 15
[   28.073163] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   28.073182] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   28.073196] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   28.073209] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   28.073232] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '0': Clearing 1
[   28.073242] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '0': Clearing 2
[   28.073252] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   28.073272] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   28.073292] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '0': Clearing 3
[   28.073302] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   28.073304] cxl_core:cxl_port_alloc:730: cxl_mem mem9: host-bridge: pci0000:35
[   28.073322] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   28.076566] cxl_core:cxl_cdat_get_length:540: cxl_port endpoint22: CDAT length 160
[   28.077414] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x0102
[   28.077446] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   28.077482] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x0103
[   28.077500] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   28.077522] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x0102
[   28.077538] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   28.080727] cxl_core:cxl_mem_get_event_records:1046: cxl_pci 0000:3a:00.0: Reading event logs: f
[   28.080774] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x0100
[   28.080795] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   28.080837] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x0100
[   28.080853] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   28.080906] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x0100
[   28.080921] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   28.080959] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:3a:00.0: Sending command: 0x0100
[   28.080975] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:3a:00.0: Doorbell wait took 0ms
[   28.081032] cxl_pci:cxl_pci_ras_unmask:553: cxl_pci 0000:3a:00.0: Uncorrectable RAS Errors Mask: 0x0 -> 0x0
[   28.081051] cxl_pci:cxl_pci_ras_unmask:563: cxl_pci 0000:3a:00.0: Correctable RAS Errors Mask: 0x0 -> 0x0
[   28.081258] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   28.082360] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   28.083722] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x0100
[   28.084296] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.6: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   28.085506] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   28.086444] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   28.088215] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c4:00.0: Sending command: 0x0100
[   28.088899] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0400 enabled
[   28.089757] cxl_core:cxl_port_perf_data_calculate:208: cxl_port endpoint22: Failed to retrieve ep perf coordinates.
[   28.089775] cxl_core:cxl_endpoint_parse_cdat:410: cxl_port endpoint22: Failed to do perf coord calculations.
[   28.090053] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c4:00.0: Doorbell wait took 0ms
[   28.090662] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4000 enabled
[   28.091374] cxl_pci:cxl_pci_ras_unmask:553: cxl_pci 0000:c4:00.0: Uncorrectable RAS Errors Mask: 0x0 -> 0x0
[   28.091489] cxl_core:init_hdm_decoder:910: cxl_port endpoint21: decoder21.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.092032] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4102 enabled
[   28.092200] cxl_core:add_hdm_decoder:37: cxl decoder21.0: Added to port endpoint21
[   28.092371] cxl_core:init_hdm_decoder:910: cxl_port endpoint21: decoder21.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.092741] cxl_pci:cxl_pci_ras_unmask:563: cxl_pci 0000:c4:00.0: Correctable RAS Errors Mask: 0x0 -> 0x0
[   28.093392] cxl_core:add_hdm_decoder:37: cxl decoder21.1: Added to port endpoint21
[   28.093555] cxl_core:init_hdm_decoder:910: cxl_port endpoint21: decoder21.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.093736] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4100 enabled
[   28.094949] cxl_core:add_hdm_decoder:37: cxl decoder21.2: Added to port endpoint21
[   28.095915] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4103 enabled
[   28.097308] cxl_core:init_hdm_decoder:910: cxl_port endpoint21: decoder21.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.097596] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4200 enabled
[   28.099430] cxl_core:add_hdm_decoder:37: cxl decoder21.3: Added to port endpoint21
[   28.101458] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4300 enabled
[   28.101476] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4301 enabled
[   28.101485] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4302 enabled
[   28.101495] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0200 enabled
[   28.101504] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0201 unsupported by driver
[   28.101514] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0202 unsupported by driver
[   28.101524] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4400 enabled
[   28.102380] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   28.106151] cxl_core:cxl_bus_probe:2077: cxl_port endpoint21: probe: 0
[   28.106967] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   28.110389] cxl_core:devm_cxl_add_port:925: cxl_mem mem8: endpoint21 added to port16
[   28.111702] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[   28.111722] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.6: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[   28.112680] cxl_core:cxl_bus_probe:2077: cxl_mem mem8: probe: 0
[   28.113589] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.6: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[   28.115743] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem10: scan: iter: mem10 dport_dev: cxl_switch_dport.6 parent: cxl_switch_uport.2
[   28.119612] cxl_core:init_hdm_decoder:910: cxl_port endpoint22: decoder22.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.121325] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x0102
[   28.121355] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   28.121391] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x0103
[   28.121409] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   28.121431] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x0102
[   28.121447] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   28.122171] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem10: found already registered port port11:cxl_switch_uport.2
[   28.123403] cxl_core:add_hdm_decoder:37: cxl decoder22.0: Added to port endpoint22
[   28.123646] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem10: scan: iter: cxl_switch_dport.6 dport_dev: cxl_root_port.2 parent: cxl_host_bridge.0
[   28.124612] cxl_core:init_hdm_decoder:910: cxl_port endpoint22: decoder22.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.125273] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem10: found already registered port port4:cxl_host_bridge.0
[   28.126592] cxl_core:add_hdm_decoder:37: cxl decoder22.1: Added to port endpoint22
[   28.126688] cxl_core:cxl_mem_get_event_records:1046: cxl_pci 0000:c2:00.0: Reading event logs: f
[   28.126773] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x0100
[   28.126798] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   28.126840] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x0100
[   28.126856] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   28.126908] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x0100
[   28.126925] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   28.126962] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:c2:00.0: Sending command: 0x0100
[   28.126978] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c2:00.0: Doorbell wait took 0ms
[   28.127036] cxl_pci:cxl_pci_ras_unmask:553: cxl_pci 0000:c2:00.0: Uncorrectable RAS Errors Mask: 0x0 -> 0x0
[   28.127055] cxl_pci:cxl_pci_ras_unmask:563: cxl_pci 0000:c2:00.0: Correctable RAS Errors Mask: 0x0 -> 0x0
[   28.132148] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   28.134257] cxl_core:init_hdm_decoder:910: cxl_port endpoint22: decoder22.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.137235] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   28.139990] cxl_core:add_hdm_decoder:37: cxl decoder22.2: Added to port endpoint22
[   28.140061] cxl_core:init_hdm_decoder:910: cxl_port endpoint22: decoder22.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   28.144426] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   28.148138] cxl_core:add_hdm_decoder:37: cxl decoder22.3: Added to port endpoint22
[   28.151454] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[   28.154232] cxl_core:cxl_bus_probe:2077: cxl_port endpoint22: probe: 0
[   28.156739] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem10: probe: 0
[   28.159863] cxl_core:devm_cxl_add_port:925: cxl_mem mem9: endpoint22 added to port17
[   28.160482] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem10: register pmem10
[   28.161301] cxl_core:cxl_bus_probe:2077: cxl_mem mem9: probe: 0
[   28.162153] cxl_core:cxl_port_alloc:730: cxl_mem mem10: host-bridge: cxl_host_bridge.0
[   28.165585] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x0102
[   28.169968] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.0: Added to port endpoint23
[   28.170845] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   28.172217] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.1: Added to port endpoint23
[   28.172698] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x0103
[   28.173813] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.2: Added to port endpoint23
[   28.173933] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   28.175609] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.3: Added to port endpoint23
[   28.178398] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x0102
[   28.179459] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.4: Added to port endpoint23
[   28.179663] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   28.180928] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.5: Added to port endpoint23
[   28.188764] cxl_core:cxl_mem_get_event_records:1046: cxl_pci 0000:38:00.0: Reading event logs: f
[   28.192159] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.6: Added to port endpoint23
[   28.194485] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x0100
[   28.195677] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.7: Added to port endpoint23
[   28.195805] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   28.196395] cxl_core:cxl_bus_probe:2077: cxl_port endpoint23: probe: 0
[   28.197241] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x0100
[   28.198094] cxl_core:devm_cxl_add_port:925: cxl_mem mem10: endpoint23 added to port11
[   28.198593] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   28.199421] cxl_core:cxl_bus_probe:2077: cxl_mem mem10: probe: 0
[   28.200327] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x0100
[   28.201996] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.6: Reading event logs: f
[   28.202094] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   28.202852] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   28.203598] cxl_pci:__cxl_pci_mbox_send_cmd:259: cxl_pci 0000:38:00.0: Sending command: 0x0100
[   28.204513] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '3': Clearing 1
[   28.205631] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:38:00.0: Doorbell wait took 0ms
[   28.206323] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '3': Clearing 2
[   28.207300] cxl_pci:cxl_pci_ras_unmask:553: cxl_pci 0000:38:00.0: Uncorrectable RAS Errors Mask: 0x0 -> 0x0
[   28.207971] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   28.208537] cxl_pci:cxl_pci_ras_unmask:563: cxl_pci 0000:38:00.0: Correctable RAS Errors Mask: 0x0 -> 0x0
[   28.209277] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   28.265262] nd_pmem namespace0.0: unable to guarantee persistence of writes
[   28.266865] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   29.593103] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 1
[   29.597682] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   29.601509] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   29.605096] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 2
[   29.608854] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 3
[   29.612114] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   29.615076] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   29.619363] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 4
[   29.622522] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 5
[   29.625710] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 6
[   29.628621] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   29.631362] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   29.634535] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 7
[   29.637327] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   29.640577] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   29.644426] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 8
[   29.649516] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 9
[   29.652937] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   29.656196] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   29.660741] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 10
[   29.663597] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 11
[   29.666123] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 12
[   29.666136] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   29.666163] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   29.666642] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 13
[   29.677322] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   29.680051] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   29.682769] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 14
[   29.686042] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 15
[   29.686065] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   29.686098] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   29.687900] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   29.700786] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   29.704186] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '0': Clearing 1
[   29.706568] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '0': Clearing 2
[   29.709705] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   29.712588] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   29.717240] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '0': Clearing 3
[   29.717261] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   29.717284] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   29.731014] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   29.733628] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.7: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   29.737121] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   29.739700] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0400 enabled
[   29.742142] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4000 enabled
[   29.745074] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4102 enabled
[   29.745092] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4100 enabled
[   29.745101] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4103 enabled
[   29.745111] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4200 enabled
[   29.745121] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4300 enabled
[   29.745131] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4301 enabled
[   29.745140] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4302 enabled
[   29.745149] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0200 enabled
[   29.745159] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0201 unsupported by driver
[   29.745168] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0202 unsupported by driver
[   29.745178] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4400 enabled
[   29.746081] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   29.770969] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   29.770990] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[   29.771005] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.7: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[   29.771022] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.7: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[   29.782458] cxl_core:cxl_bus_probe:2077: cxl_dax_region dax_region3: probe: 0
[   29.795402] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem11: scan: iter: mem11 dport_dev: cxl_switch_dport.7 parent: cxl_switch_uport.3
[   29.798468] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem11: found already registered port port13:cxl_switch_uport.3
[   29.812585] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem11: scan: iter: cxl_switch_dport.7 dport_dev: cxl_root_port.3 parent: cxl_host_bridge.1
[   29.815936] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem11: found already registered port port5:cxl_host_bridge.1
[   29.820285] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   29.823581] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   29.831851] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   29.835798] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[   29.840598] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem11: probe: 0
[   29.842918] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem11: register pmem11
[   29.844909] cxl_core:cxl_port_alloc:730: cxl_mem mem11: host-bridge: cxl_host_bridge.1
[   29.906914] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.0: Added to port endpoint24
[   29.940044] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.1: Added to port endpoint24
[   29.954092] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.2: Added to port endpoint24
[   29.975770] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.3: Added to port endpoint24
[   30.027640] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.4: Added to port endpoint24
[   30.031620] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.5: Added to port endpoint24
[   30.036194] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.6: Added to port endpoint24
[   30.037531] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.7: Added to port endpoint24
[   30.037553] cxl_core:cxl_bus_probe:2077: cxl_port endpoint24: probe: 0
[   30.043105] cxl_core:devm_cxl_add_port:925: cxl_mem mem11: endpoint24 added to port13
[   30.043210] cxl_core:cxl_bus_probe:2077: cxl_mem mem11: probe: 0
[   30.054005] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.7: Reading event logs: f
[   30.054026] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.054052] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '3': Clearing 1
[   30.054063] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '3': Clearing 2
[   30.054074] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.054097] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.054113] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.054137] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 1
[   30.054148] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.054169] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.054193] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 2
[   30.054204] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 3
[   30.054215] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.054237] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   30.054260] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 4
[   30.054271] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 5
[   30.054282] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 6
[   30.054293] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   30.054314] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.054337] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 7
[   30.054347] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.054369] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.054391] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 8
[   30.054402] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 9
[   30.054413] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.054434] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   30.054457] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 10
[   30.054468] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 11
[   30.054479] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 12
[   30.054490] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   30.054511] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.054588] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 13
[   30.054599] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.054620] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.054643] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 14
[   30.056586] ppdev: user-space parallel port driver
[   30.058333] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 15
[   30.162397] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.162428] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.162632] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.170983] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.173466] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '0': Clearing 1
[   30.173483] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '0': Clearing 2
[   30.173494] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.173517] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.173539] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '0': Clearing 3
[   30.173549] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.173569] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.181017] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   30.193664] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.8: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   30.194268] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   30.200606] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0400 enabled
[   30.200619] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4000 enabled
[   30.200630] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4102 enabled
[   30.200640] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4100 enabled
[   30.200650] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4103 enabled
[   30.200660] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4200 enabled
[   30.200672] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4300 enabled
[   30.200682] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4301 enabled
[   30.200692] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4302 enabled
[   30.200702] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0200 enabled
[   30.200713] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0201 unsupported by driver
[   30.200723] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0202 unsupported by driver
[   30.200734] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4400 enabled
[   30.201270] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   30.201291] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   30.201305] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[   30.201320] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.8: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[   30.201334] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.8: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[   30.203425] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: mem12 dport_dev: cxl_switch_dport.8 parent: cxl_switch_uport.4
[   30.203938] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.4: host-bridge: cxl_host_bridge.2
[   30.204783] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.8: dport added to port25
[   30.205007] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.9: dport added to port25
[   30.206230] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.0: Added to port port25
[   30.255972] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.1: Added to port port25
[   30.256885] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.2: Added to port port25
[   30.257579] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.3: Added to port port25
[   30.266684] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.4: Added to port port25
[   30.267546] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.5: Added to port port25
[   30.268254] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.6: Added to port port25
[   30.276175] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.7: Added to port port25
[   30.276194] cxl_core:cxl_bus_probe:2077: cxl_port port25: probe: 0
[   30.277342] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.4: port25 added to port6
[   30.282930] cxl_core:add_port_attach_ep:1589: cxl_mem mem12: add to new port port25:cxl_switch_uport.4
[   30.285850] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: mem12 dport_dev: cxl_switch_dport.8 parent: cxl_switch_uport.4
[   30.288630] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem12: found already registered port port25:cxl_switch_uport.4
[   30.292155] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: cxl_switch_dport.8 dport_dev: cxl_root_port.4 parent: cxl_host_bridge.2
[   30.294611] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem12: found already registered port port6:cxl_host_bridge.2
[   30.298524] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   30.300686] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   30.304956] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   30.309108] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[   30.312384] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem12: probe: 0
[   30.314646] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem12: register pmem12
[   30.316828] cxl_core:cxl_port_alloc:730: cxl_mem mem12: host-bridge: cxl_host_bridge.2
[   30.320982] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.0: Added to port endpoint26
[   30.324172] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.1: Added to port endpoint26
[   30.327880] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.2: Added to port endpoint26
[   30.331463] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.3: Added to port endpoint26
[   30.335027] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.4: Added to port endpoint26
[   30.339204] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.5: Added to port endpoint26
[   30.342452] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.6: Added to port endpoint26
[   30.345504] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.7: Added to port endpoint26
[   30.347565] cxl_core:cxl_bus_probe:2077: cxl_port endpoint26: probe: 0
[   30.349867] cxl_core:devm_cxl_add_port:925: cxl_mem mem12: endpoint26 added to port25
[   30.352186] cxl_core:cxl_bus_probe:2077: cxl_mem mem12: probe: 0
[   30.355658] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.8: Reading event logs: f
[   30.358604] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.362300] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '3': Clearing 1
[   30.364787] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '3': Clearing 2
[   30.366894] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.369225] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.371678] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.374583] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 1
[   30.377089] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.379372] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.382912] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 2
[   30.385039] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 3
[   30.387049] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.389214] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   30.392373] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 4
[   30.394416] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 5
[   30.396642] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 6
[   30.398605] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   30.400732] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.403075] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 7
[   30.405756] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.408489] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.411371] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 8
[   30.414699] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 9
[   30.417055] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.419452] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   30.423098] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 10
[   30.425319] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 11
[   30.427541] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 12
[   30.429578] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   30.431980] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.434971] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 13
[   30.437068] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.439378] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.442332] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 14
[   30.444787] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 15
[   30.446862] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.449060] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.451344] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.454522] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.458418] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '0': Clearing 1
[   30.461056] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '0': Clearing 2
[   30.463343] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.465697] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.468696] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '0': Clearing 3
[   30.471953] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.474514] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.487760] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   30.490048] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.9: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   30.493828] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   30.496605] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0400 enabled
[   30.498634] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4000 enabled
[   30.500700] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4102 enabled
[   30.502667] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4100 enabled
[   30.504757] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4103 enabled
[   30.506651] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4200 enabled
[   30.508673] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4300 enabled
[   30.510597] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4301 enabled
[   30.512536] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4302 enabled
[   30.514441] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0200 enabled
[   30.516396] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0201 unsupported by driver
[   30.518376] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0202 unsupported by driver
[   30.520433] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4400 enabled
[   30.523244] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   30.525467] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   30.527671] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[   30.529851] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.9: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[   30.532234] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.9: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[   30.536791] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem13: scan: iter: mem13 dport_dev: cxl_switch_dport.9 parent: cxl_switch_uport.4
[   30.539447] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem13: found already registered port port25:cxl_switch_uport.4
[   30.542440] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem13: scan: iter: cxl_switch_dport.9 dport_dev: cxl_root_port.4 parent: cxl_host_bridge.2
[   30.544999] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem13: found already registered port port6:cxl_host_bridge.2
[   30.548437] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   30.551684] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   30.556906] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[   30.560230] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[   30.564156] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem13: probe: 0
[   30.567441] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem13: register pmem13
[   30.569707] cxl_core:cxl_port_alloc:730: cxl_mem mem13: host-bridge: cxl_host_bridge.2
[   30.574458] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.0: Added to port endpoint27
[   30.577838] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.1: Added to port endpoint27
[   30.581244] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.2: Added to port endpoint27
[   30.584223] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.3: Added to port endpoint27
[   30.588115] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.4: Added to port endpoint27
[   30.591186] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.5: Added to port endpoint27
[   30.594654] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.6: Added to port endpoint27
[   30.598160] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.7: Added to port endpoint27
[   30.600389] cxl_core:cxl_bus_probe:2077: cxl_port endpoint27: probe: 0
[   30.603176] cxl_core:devm_cxl_add_port:925: cxl_mem mem13: endpoint27 added to port25
[   30.605887] cxl_core:cxl_bus_probe:2077: cxl_mem mem13: probe: 0
[   30.609193] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.9: Reading event logs: f
[   30.611392] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.613719] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '3': Clearing 1
[   30.615846] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '3': Clearing 2
[   30.617733] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.619887] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.622741] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.625666] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 1
[   30.627843] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.629950] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.633120] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 2
[   30.635034] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 3
[   30.636930] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.639301] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   30.641835] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 4
[   30.644222] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 5
[   30.646479] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 6
[   30.648752] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   30.651305] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.653958] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 7
[   30.656485] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.659031] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.662427] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 8
[   30.664916] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 9
[   30.667450] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.670274] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   30.673865] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 10
[   30.676405] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 11
[   30.678823] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 12
[   30.681245] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   30.683832] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.684643] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 13
[   30.688866] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.691402] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.694661] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 14
[   30.697270] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 15
[   30.699634] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.702427] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.705952] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.708765] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.711423] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '0': Clearing 1
[   30.713738] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '0': Clearing 2
[   30.716126] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.718627] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.721430] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '0': Clearing 3
[   30.724078] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.726733] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.739471] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[   30.742098] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_rcd.10: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[   30.745751] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[   30.748488] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0400 enabled
[   30.750886] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4000 enabled
[   30.753215] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4102 enabled
[   30.755682] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4100 enabled
[   30.758093] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4103 enabled
[   30.760399] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4200 enabled
[   30.762763] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4300 enabled
[   30.765083] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4301 enabled
[   30.767307] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4302 enabled
[   30.769510] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0200 enabled
[   30.771650] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0201 unsupported by driver
[   30.773922] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0202 unsupported by driver
[   30.776181] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4400 enabled
[   30.779641] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[   30.782082] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[   30.784484] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_rcd.10: DPA(ram): [mem 0x00000000-0x7fffffff flags 0x200]
[   30.787007] cxl_core:add_dpa_res:1245: cxl_mock_mem cxl_rcd.10: DPA(pmem): no capacity
[   30.792158] cxl_core:cxl_port_alloc:730: cxl_mem mem14: host-bridge: cxl_host_bridge.3
[   30.798924] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.0: Added to port endpoint28
[   30.803324] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.1: Added to port endpoint28
[   30.806632] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.2: Added to port endpoint28
[   30.810931] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.3: Added to port endpoint28
[   30.816308] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.4: Added to port endpoint28
[   30.820148] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.5: Added to port endpoint28
[   30.822871] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.6: Added to port endpoint28
[   30.826674] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.7: Added to port endpoint28
[   30.828916] cxl_core:cxl_bus_probe:2077: cxl_port endpoint28: probe: 0
[   30.832313] cxl_core:devm_cxl_add_port:925: cxl_mem mem14: endpoint28 added to root3
[   30.834519] cxl_core:cxl_bus_probe:2077: cxl_mem mem14: probe: 0
[   30.838040] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_rcd.10: Reading event logs: f
[   30.841050] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.844929] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '3': Clearing 1
[   30.847772] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '3': Clearing 2
[   30.850124] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.852535] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.855507] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.858016] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 1
[   30.860269] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.862631] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.866581] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 2
[   30.868906] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 3
[   30.871751] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.874323] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   30.877808] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 4
[   30.880481] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 5
[   30.882798] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 6
[   30.885561] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   30.888130] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.890560] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 7
[   30.893388] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.895799] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.898451] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 8
[   30.900884] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 9
[   30.903124] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.905580] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[   30.906142] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 10
[   30.911247] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 11
[   30.911264] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 12
[   30.911279] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[   30.911315] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.911615] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 13
[   30.925763] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.925818] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.926619] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 14
[   30.933543] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 15
[   30.933561] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.933593] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.934291] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   30.944474] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[   30.947369] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '0': Clearing 1
[   30.949968] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '0': Clearing 2
[   30.949987] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[   30.950018] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[   30.950426] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '0': Clearing 3
[   30.960399] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[   30.960438] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[   31.360195] EDAC DEBUG: i10nm_init: 
...
[  594.152665] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '3': Clearing 1
[  594.155523] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '3': Clearing 2
[  594.157777] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.160273] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.163372] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.166300] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 1
[  594.168985] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.171356] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.175021] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 2
[  594.177240] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 3
[  594.179379] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.181687] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  594.184296] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 4
[  594.187010] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 5
[  594.189427] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 6
[  594.191762] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  594.194055] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.197018] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 7
[  594.200049] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.202500] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.206279] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 8
[  594.208560] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 9
[  594.210750] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.212956] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  594.215531] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 10
[  594.218255] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 11
[  594.220863] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 12
[  594.223056] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  594.225351] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.228224] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 13
[  594.231609] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.234054] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.237243] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 14
[  594.240621] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 15
[  594.243294] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.245807] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.248799] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.253136] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.256090] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '0': Clearing 1
[  594.258923] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '0': Clearing 2
[  594.261371] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.263959] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.266602] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '0': Clearing 3
[  594.269617] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.272394] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.285492] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  594.288573] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.5: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  594.292603] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  594.295080] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0400 enabled
[  594.297387] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4000 enabled
[  594.299729] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4102 enabled
[  594.301977] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4100 enabled
[  594.304402] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4103 enabled
[  594.306556] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4200 enabled
[  594.308733] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4300 enabled
[  594.310815] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4301 enabled
[  594.312769] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4302 enabled
[  594.314838] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0200 enabled
[  594.316905] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0201 unsupported by driver
[  594.318997] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0202 unsupported by driver
[  594.321124] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4400 enabled
[  594.323529] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  594.326679] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  594.329345] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  594.331594] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.5: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  594.333814] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.5: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  594.338112] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem6: scan: iter: mem6 dport_dev: cxl_switch_dport.5 parent: cxl_switch_uport.1
[  594.340811] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem6: scan: iter: cxl_switch_dport.5 dport_dev: cxl_root_port.1 parent: cxl_host_bridge.1
[  594.343476] cxl_mem mem6: CXL port topology not found
[  594.345142] cxl_core:cxl_bus_probe:2077: cxl_mem mem6: probe: -6
[  594.348243] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.5: Reading event logs: f
[  594.350353] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.353817] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '3': Clearing 1
[  594.356252] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '3': Clearing 2
[  594.358434] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.360723] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.363182] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.366057] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 1
[  594.368649] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.371012] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.374384] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 2
[  594.376775] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 3
[  594.378783] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.381103] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  594.383685] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 4
[  594.386502] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 5
[  594.388987] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 6
[  594.391111] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  594.393475] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.396249] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 7
[  594.398586] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.400965] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.403104] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 8
[  594.405223] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 9
[  594.408219] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.410359] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  594.412870] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 10
[  594.415015] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 11
[  594.417070] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 12
[  594.419118] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  594.421411] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.424033] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 13
[  594.427194] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.429880] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.433065] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 14
[  594.436883] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 15
[  594.439630] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.441959] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.444930] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.449358] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.452566] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '0': Clearing 1
[  594.455631] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '0': Clearing 2
[  594.457927] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.460592] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.463206] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '0': Clearing 3
[  594.465637] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.468465] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.481609] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  594.484733] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.6: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  594.488033] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  594.491120] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0400 enabled
[  594.493476] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4000 enabled
[  594.495655] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4102 enabled
[  594.497702] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4100 enabled
[  594.499962] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4103 enabled
[  594.501956] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4200 enabled
[  594.504124] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4300 enabled
[  594.506118] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4301 enabled
[  594.508450] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4302 enabled
[  594.510398] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0200 enabled
[  594.512395] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0201 unsupported by driver
[  594.514355] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0202 unsupported by driver
[  594.516442] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4400 enabled
[  594.518543] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  594.521853] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  594.524627] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  594.526994] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.6: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  594.529225] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.6: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  594.533517] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem10: scan: iter: mem10 dport_dev: cxl_switch_dport.6 parent: cxl_switch_uport.2
[  594.536848] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem10: scan: iter: cxl_switch_dport.6 dport_dev: cxl_root_port.2 parent: cxl_host_bridge.0
[  594.539889] cxl_mem mem10: CXL port topology not found
[  594.541713] cxl_core:cxl_bus_probe:2077: cxl_mem mem10: probe: -6
[  594.545009] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.6: Reading event logs: f
[  594.548264] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.552815] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '3': Clearing 1
[  594.555095] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '3': Clearing 2
[  594.557456] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.560063] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.562722] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.565660] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 1
[  594.568416] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.571008] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.573611] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 2
[  594.576891] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 3
[  594.579272] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.581622] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  594.584464] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 4
[  594.587603] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 5
[  594.590208] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 6
[  594.592858] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  594.595251] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.597829] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 7
[  594.600960] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.603766] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.606520] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 8
[  594.609034] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 9
[  594.611284] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.613762] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  594.616673] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 10
[  594.618897] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 11
[  594.620965] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 12
[  594.623081] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  594.625431] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.628329] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 13
[  594.631171] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.633847] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.637071] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 14
[  594.640077] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 15
[  594.642532] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.644977] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.647775] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.651022] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.655040] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '0': Clearing 1
[  594.657582] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '0': Clearing 2
[  594.660183] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.662615] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.665206] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '0': Clearing 3
[  594.668160] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.670770] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.684359] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  594.687238] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.7: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  594.691030] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  594.693537] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0400 enabled
[  594.695995] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4000 enabled
[  594.698173] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4102 enabled
[  594.700648] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4100 enabled
[  594.702760] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4103 enabled
[  594.704944] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4200 enabled
[  594.707033] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4300 enabled
[  594.709121] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4301 enabled
[  594.711194] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4302 enabled
[  594.713268] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0200 enabled
[  594.715351] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0201 unsupported by driver
[  594.717494] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0202 unsupported by driver
[  594.719743] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4400 enabled
[  594.722108] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  594.725687] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  594.728651] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  594.730981] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.7: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  594.733376] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.7: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  594.737662] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem11: scan: iter: mem11 dport_dev: cxl_switch_dport.7 parent: cxl_switch_uport.3
[  594.740592] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem11: scan: iter: cxl_switch_dport.7 dport_dev: cxl_root_port.3 parent: cxl_host_bridge.1
[  594.743508] cxl_mem mem11: CXL port topology not found
[  594.745285] cxl_core:cxl_bus_probe:2077: cxl_mem mem11: probe: -6
[  594.749114] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.7: Reading event logs: f
[  594.751559] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.754390] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '3': Clearing 1
[  594.757049] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '3': Clearing 2
[  594.759207] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.761457] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.764286] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.767769] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 1
[  594.770806] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.773477] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.776276] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 2
[  594.779012] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 3
[  594.781284] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.783665] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  594.787114] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 4
[  594.789169] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 5
[  594.791429] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 6
[  594.793606] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  594.796314] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.798773] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 7
[  594.801313] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.803776] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.806261] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 8
[  594.809491] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 9
[  594.812156] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.814509] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  594.817164] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 10
[  594.820690] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 11
[  594.823326] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 12
[  594.825505] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  594.827937] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.830327] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 13
[  594.832827] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.835078] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.838236] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 14
[  594.840922] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 15
[  594.843037] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.845468] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.848348] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.852023] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.857226] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '0': Clearing 1
[  594.859684] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '0': Clearing 2
[  594.861934] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.864583] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.867081] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '0': Clearing 3
[  594.870022] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.872941] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.886366] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  594.889530] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.8: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  594.894255] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  594.896844] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0400 enabled
[  594.899019] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4000 enabled
[  594.901172] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4102 enabled
[  594.903387] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4100 enabled
[  594.905519] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4103 enabled
[  594.907749] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4200 enabled
[  594.909904] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4300 enabled
[  594.912285] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4301 enabled
[  594.914261] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4302 enabled
[  594.916583] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0200 enabled
[  594.918536] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0201 unsupported by driver
[  594.920707] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0202 unsupported by driver
[  594.922736] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4400 enabled
[  594.924991] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  594.927343] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  594.929650] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  594.932465] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.8: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  594.934616] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.8: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  594.938575] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: mem12 dport_dev: cxl_switch_dport.8 parent: cxl_switch_uport.4
[  594.941666] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: cxl_switch_dport.8 dport_dev: cxl_root_port.4 parent: cxl_host_bridge.2
[  594.944739] cxl_mem mem12: CXL port topology not found
[  594.946667] cxl_core:cxl_bus_probe:2077: cxl_mem mem12: probe: -6
[  594.950620] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.8: Reading event logs: f
[  594.953475] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.956299] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '3': Clearing 1
[  594.959125] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '3': Clearing 2
[  594.961420] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.963970] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  594.967334] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  594.970186] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 1
[  594.972797] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  594.975052] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  594.977662] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 2
[  594.980759] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 3
[  594.983235] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  594.985615] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  594.988452] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 4
[  594.991502] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 5
[  594.994054] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 6
[  594.996482] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  594.998709] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.001308] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 7
[  595.004601] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.007103] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.009650] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 8
[  595.012322] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 9
[  595.014455] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.016702] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  595.019572] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 10
[  595.022299] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 11
[  595.024884] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 12
[  595.026985] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  595.029260] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.032064] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 13
[  595.035011] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.037582] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.040332] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 14
[  595.042716] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 15
[  595.045058] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.047545] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.050641] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.053851] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.056862] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '0': Clearing 1
[  595.059268] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '0': Clearing 2
[  595.061426] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.064088] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.067279] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '0': Clearing 3
[  595.069718] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.072205] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.083990] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  595.086307] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.9: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  595.089785] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  595.092645] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0400 enabled
[  595.094763] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4000 enabled
[  595.096987] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4102 enabled
[  595.099108] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4100 enabled
[  595.101269] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4103 enabled
[  595.103301] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4200 enabled
[  595.105435] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4300 enabled
[  595.107606] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4301 enabled
[  595.109631] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4302 enabled
[  595.111896] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0200 enabled
[  595.113823] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0201 unsupported by driver
[  595.116028] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0202 unsupported by driver
[  595.118069] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4400 enabled
[  595.120511] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  595.122894] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  595.125219] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  595.127711] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.9: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  595.130104] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.9: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  595.134696] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem13: scan: iter: mem13 dport_dev: cxl_switch_dport.9 parent: cxl_switch_uport.4
[  595.138066] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem13: scan: iter: cxl_switch_dport.9 dport_dev: cxl_root_port.4 parent: cxl_host_bridge.2
[  595.141136] cxl_mem mem13: CXL port topology not found
[  595.143052] cxl_core:cxl_bus_probe:2077: cxl_mem mem13: probe: -6
[  595.147290] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.9: Reading event logs: f
[  595.150193] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.153193] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '3': Clearing 1
[  595.156310] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '3': Clearing 2
[  595.158631] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.161065] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.163692] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.166809] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 1
[  595.169656] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.172277] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.174757] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 2
[  595.177503] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 3
[  595.179977] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.182196] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  595.184949] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 4
[  595.187499] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 5
[  595.189660] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 6
[  595.192022] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  595.194314] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.196786] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 7
[  595.199618] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.202075] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.205116] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 8
[  595.208101] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 9
[  595.210375] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.212774] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  595.215658] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 10
[  595.218769] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 11
[  595.221205] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 12
[  595.223464] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  595.225698] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.228476] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 13
[  595.231783] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.234354] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.238129] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 14
[  595.240815] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 15
[  595.242960] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.245368] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.248144] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.250664] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.253343] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '0': Clearing 1
[  595.256370] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '0': Clearing 2
[  595.258790] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.261213] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.264057] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '0': Clearing 3
[  595.267046] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.269759] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.284677] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  595.287618] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_rcd.10: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  595.291712] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  595.294778] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0400 enabled
[  595.297128] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4000 enabled
[  595.299127] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4102 enabled
[  595.301299] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4100 enabled
[  595.303563] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4103 enabled
[  595.305600] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4200 enabled
[  595.307643] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4300 enabled
[  595.309585] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4301 enabled
[  595.311671] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4302 enabled
[  595.313572] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0200 enabled
[  595.315618] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0201 unsupported by driver
[  595.317601] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0202 unsupported by driver
[  595.319703] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4400 enabled
[  595.321871] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  595.324410] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  595.326742] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_rcd.10: DPA(ram): [mem 0x00000000-0x7fffffff flags 0x200]
[  595.328945] cxl_core:add_dpa_res:1245: cxl_mock_mem cxl_rcd.10: DPA(pmem): no capacity
[  595.333424] cxl_mem mem14: CXL port topology not found
[  595.336165] cxl_core:cxl_bus_probe:2077: cxl_mem mem14: probe: -6
[  595.340955] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_rcd.10: Reading event logs: f
[  595.343583] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.346517] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '3': Clearing 1
[  595.348839] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '3': Clearing 2
[  595.350966] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.353279] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.355830] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.358255] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 1
[  595.360773] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.362925] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.366024] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 2
[  595.368537] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 3
[  595.370602] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.372898] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  595.375273] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 4
[  595.377560] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 5
[  595.379905] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 6
[  595.381979] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  595.384611] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.387079] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 7
[  595.390235] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.393086] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.396117] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 8
[  595.399376] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 9
[  595.401607] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.404181] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  595.406739] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 10
[  595.409154] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 11
[  595.411381] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 12
[  595.413457] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  595.415824] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.418755] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 13
[  595.420865] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.422954] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.425434] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 14
[  595.427840] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 15
[  595.429944] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.432486] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.435022] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.438168] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  595.441680] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '0': Clearing 1
[  595.444973] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '0': Clearing 2
[  595.447451] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  595.449900] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  595.452971] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '0': Clearing 3
[  595.456202] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  595.458848] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  595.462898] cxl_core:devm_cxl_add_port:925: cxl_acpi cxl_acpi.0: root9 added (root port)
[  595.466039] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.0: UID found: 0
[  595.468607] platform cxl_host_bridge.0: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  595.471815] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.0: dport added to root9
[  595.474280] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.0: Failed to get generic port perf coordinates.
[  595.476846] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.1: UID found: 1
[  595.479278] platform cxl_host_bridge.1: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  595.482781] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.1: dport added to root9
[  595.486020] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.1: Failed to get generic port perf coordinates.
[  595.489163] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.2: UID found: 2
[  595.491246] platform cxl_host_bridge.2: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  595.494881] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.2: dport added to root9
[  595.497940] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.2: Failed to get generic port perf coordinates.
[  595.500841] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.3: UID found: 3
[  595.503078] platform cxl_host_bridge.3: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  595.505730] cxl_acpi:add_host_bridge_dport:594: platform cxl_host_bridge.3: RCRB found for UID 3: 0x000ffff000600000
[  595.509912] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.3: dport added to root9
[  595.512846] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.3: Failed to get generic port perf coordinates.
[  595.517077] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff010000000 - 0xffff04fffffff]
[  595.523281] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff050000000 - 0xffff0cfffffff]
[  595.528425] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff0d0000000 - 0xffff10fffffff]
[  595.533306] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff110000000 - 0xffff18fffffff]
[  595.537654] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff190000000 - 0xffff1cfffffff]
[  595.541674] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff1d0000000 - 0xffff1dfffffff]
[  595.545579] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.0: UID found: 0
[  595.548080] platform cxl_host_bridge.0: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  595.550704] cxl_acpi:add_host_bridge_uport:658: platform cxl_host_bridge.0: CHBCR found for UID 0: 0x000ffff000000000
[  595.553626] cxl_core:cxl_port_alloc:730: platform cxl_host_bridge.0: host-bridge: cxl_host_bridge.0
[  595.558654] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.0: dport added to port10
[  595.562727] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port10: cxl_host_bridge.0: mismatch parent cxl_host_bridge.1
[  595.567386] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.2: dport added to port10
[  595.570041] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port10: cxl_host_bridge.0: mismatch parent cxl_host_bridge.1
[  595.575681] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.0: Added to port port10
[  595.580030] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.1: Added to port port10
[  595.585277] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.2: Added to port port10
[  595.589351] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.3: Added to port port10
[  595.592889] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.4: Added to port port10
[  595.596658] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.5: Added to port port10
[  595.600375] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.6: Added to port port10
[  595.604399] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.7: Added to port port10
[  595.607391] cxl_core:cxl_bus_probe:2077: cxl_port port10: probe: 0
[  595.612215] cxl_core:devm_cxl_add_port:925: platform cxl_host_bridge.0: port10 added to root9
[  595.614655] platform cxl_host_bridge.0: host supports CXL
[  595.616904] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.1: UID found: 1
[  595.619264] platform cxl_host_bridge.1: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  595.621920] cxl_acpi:add_host_bridge_uport:658: platform cxl_host_bridge.1: CHBCR found for UID 1: 0x000ffff000200000
[  595.625346] cxl_core:cxl_port_alloc:730: platform cxl_host_bridge.1: host-bridge: cxl_host_bridge.1
[  595.629690] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port11: cxl_host_bridge.1: mismatch parent cxl_host_bridge.0
[  595.634118] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.1: dport added to port11
[  595.637354] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port11: cxl_host_bridge.1: mismatch parent cxl_host_bridge.0
[  595.641004] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.3: dport added to port11
[  595.645477] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.0: Added to port port11
[  595.651022] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.1: Added to port port11
[  595.655116] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.2: Added to port port11
[  595.658299] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.3: Added to port port11
[  595.662036] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.4: Added to port port11
[  595.665750] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.5: Added to port port11
[  595.670008] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.6: Added to port port11
[  595.674000] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.7: Added to port port11
[  595.677271] cxl_core:cxl_bus_probe:2077: cxl_port port11: probe: 0
[  595.681356] cxl_core:devm_cxl_add_port:925: platform cxl_host_bridge.1: port11 added to root9
[  595.684564] platform cxl_host_bridge.1: host supports CXL
[  595.686509] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.2: UID found: 2
[  595.688690] platform cxl_host_bridge.2: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  595.691058] cxl_acpi:add_host_bridge_uport:658: platform cxl_host_bridge.2: CHBCR found for UID 2: 0x000ffff000400000
[  595.694208] cxl_core:cxl_port_alloc:730: platform cxl_host_bridge.2: host-bridge: cxl_host_bridge.2
[  595.698258] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.4: dport added to port12
[  595.702398] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.0: Added to port port12
[  595.706025] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.1: Added to port port12
[  595.709156] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.2: Added to port port12
[  595.712386] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.3: Added to port port12
[  595.717610] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.4: Added to port port12
[  595.721329] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.5: Added to port port12
[  595.727907] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.6: Added to port port12
[  595.730691] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.7: Added to port port12
[  595.732777] cxl_core:cxl_bus_probe:2077: cxl_port port12: probe: 0
[  595.735831] cxl_core:devm_cxl_add_port:925: platform cxl_host_bridge.2: port12 added to root9
[  595.738450] platform cxl_host_bridge.2: host supports CXL
[  595.740726] platform cxl_host_bridge.3: host supports CXL (restricted)
[  595.747496] cxl_core:cxl_bus_probe:2077: cxl_nvdimm_bridge nvdimm-bridge1: probe: 0
[  595.750816] cxl_acpi:add_root_nvdimm_bridge:693: cxl_acpi cxl_acpi.0: root9: add: nvdimm-bridge1
[  595.754058] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: mem0 dport_dev: cxl_switch_dport.0 parent: cxl_switch_uport.0
[  595.757197] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.0: host-bridge: cxl_host_bridge.0
[  595.761259] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.0: dport added to port13
[  595.763598] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.1
[  595.766018] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.2
[  595.768886] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.3
[  595.772040] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.4: dport added to port13
[  595.774310] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.1
[  595.776965] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.2
[  595.779941] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.3
[  595.783882] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.0: Added to port port13
[  595.787643] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.1: Added to port port13
[  595.791127] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.2: Added to port port13
[  595.795738] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.3: Added to port port13
[  595.799332] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.4: Added to port port13
[  595.802098] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.5: Added to port port13
[  595.805815] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.6: Added to port port13
[  595.809373] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.7: Added to port port13
[  595.811525] cxl_core:cxl_bus_probe:2077: cxl_port port13: probe: 0
[  595.814385] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.0: port13 added to port10
[  595.816522] cxl_core:add_port_attach_ep:1589: cxl_mem mem0: add to new port port13:cxl_switch_uport.0
[  595.819458] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: mem0 dport_dev: cxl_switch_dport.0 parent: cxl_switch_uport.0
[  595.821987] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem0: found already registered port port13:cxl_switch_uport.0
[  595.825152] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: cxl_switch_dport.0 dport_dev: cxl_root_port.0 parent: cxl_host_bridge.0
[  595.827990] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem0: found already registered port port10:cxl_host_bridge.0
[  595.830837] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  595.833222] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  595.841985] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  595.845992] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  595.849641] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem0: probe: 0
[  595.852595] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem0: register pmem0
[  595.855356] cxl_core:cxl_port_alloc:730: cxl_mem mem0: host-bridge: cxl_host_bridge.0
[  595.859874] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.0: Added to port endpoint14
[  595.864274] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.1: Added to port endpoint14
[  595.869113] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.2: Added to port endpoint14
[  595.872851] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.3: Added to port endpoint14
[  595.876056] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.4: Added to port endpoint14
[  595.879127] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.5: Added to port endpoint14
[  595.881791] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.6: Added to port endpoint14
[  595.885018] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.7: Added to port endpoint14
[  595.889072] cxl_core:cxl_region_probe:3402: cxl_region region3: config state: 0
[  595.891903] cxl_core:cxl_bus_probe:2077: cxl_region region3: probe: -6
[  595.894952] cxl_core:devm_cxl_add_region:2499: cxl_acpi cxl_acpi.0: decoder9.0: created region3
[  595.898259] cxl_core:construct_region:3296: cxl_mock_mem cxl_mem.0: mem0:decoder14.0: construct_region region3 res: [mem 0xffff010000000-0xffff02fffffff flags 0x200] iw: 2 ig: 4096
[  595.903000] cxl_core:cxl_bus_probe:2077: cxl_port endpoint14: probe: 0
[  595.905861] cxl_core:devm_cxl_add_port:925: cxl_mem mem0: endpoint14 added to port13
[  595.910487] cxl_core:cxl_bus_probe:2077: cxl_mem mem0: probe: 0
[  595.914140] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: mem1 dport_dev: cxl_switch_dport.1 parent: cxl_switch_uport.1
[  595.917836] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.1: host-bridge: cxl_host_bridge.1
[  595.923317] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.0
[  595.926501] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.1: dport added to port15
[  595.928925] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.2
[  595.931527] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.3
[  595.934067] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.0
[  595.937374] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.5: dport added to port15
[  595.940406] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.2
[  595.942886] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.3
[  595.947716] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.0: Added to port port15
[  595.951585] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.1: Added to port port15
[  595.955208] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.2: Added to port port15
[  595.959358] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.3: Added to port port15
[  595.962064] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.4: Added to port port15
[  595.965827] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.5: Added to port port15
[  595.969139] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.6: Added to port port15
[  595.974323] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.7: Added to port port15
[  595.977068] cxl_core:cxl_bus_probe:2077: cxl_port port15: probe: 0
[  595.979976] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.1: port15 added to port11
[  595.983053] cxl_core:add_port_attach_ep:1589: cxl_mem mem1: add to new port port15:cxl_switch_uport.1
[  595.985661] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: mem1 dport_dev: cxl_switch_dport.1 parent: cxl_switch_uport.1
[  595.988829] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem1: found already registered port port15:cxl_switch_uport.1
[  595.991798] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: cxl_switch_dport.1 dport_dev: cxl_root_port.1 parent: cxl_host_bridge.1
[  595.994538] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem1: found already registered port port11:cxl_host_bridge.1
[  595.998567] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.001571] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.005780] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.009482] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  596.013148] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem1: probe: 0
[  596.015503] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem1: register pmem1
[  596.018071] cxl_core:cxl_port_alloc:730: cxl_mem mem1: host-bridge: cxl_host_bridge.1
[  596.022116] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.0: Added to port endpoint16
[  596.027459] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.1: Added to port endpoint16
[  596.031260] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.2: Added to port endpoint16
[  596.033961] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.3: Added to port endpoint16
[  596.037846] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.4: Added to port endpoint16
[  596.041588] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.5: Added to port endpoint16
[  596.045019] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.6: Added to port endpoint16
[  596.049049] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.7: Added to port endpoint16
[  596.052178] cxl_core:cxl_bus_probe:2077: cxl_port endpoint16: probe: 0
[  596.055832] cxl_core:devm_cxl_add_port:925: cxl_mem mem1: endpoint16 added to port15
[  596.058498] cxl_core:cxl_bus_probe:2077: cxl_mem mem1: probe: 0
[  596.061823] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: mem2 dport_dev: cxl_switch_dport.2 parent: cxl_switch_uport.2
[  596.066776] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.2: host-bridge: cxl_host_bridge.0
[  596.070389] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.0
[  596.073647] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.1
[  596.078112] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.2: dport added to port17
[  596.080663] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.3
[  596.083278] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.0
[  596.085954] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.1
[  596.089357] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.6: dport added to port17
[  596.092212] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.3
[  596.095744] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.0: Added to port port17
[  596.099507] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.1: Added to port port17
[  596.102844] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.2: Added to port port17
[  596.107122] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.3: Added to port port17
[  596.110482] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.4: Added to port port17
[  596.113947] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.5: Added to port port17
[  596.118842] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.6: Added to port port17
[  596.122502] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.7: Added to port port17
[  596.124495] cxl_core:cxl_bus_probe:2077: cxl_port port17: probe: 0
[  596.126530] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.2: port17 added to port10
[  596.128781] cxl_core:add_port_attach_ep:1589: cxl_mem mem2: add to new port port17:cxl_switch_uport.2
[  596.131287] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: mem2 dport_dev: cxl_switch_dport.2 parent: cxl_switch_uport.2
[  596.134456] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem2: found already registered port port17:cxl_switch_uport.2
[  596.138077] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: cxl_switch_dport.2 dport_dev: cxl_root_port.2 parent: cxl_host_bridge.0
[  596.141204] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem2: found already registered port port10:cxl_host_bridge.0
[  596.144913] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.147225] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.151094] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.153613] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  596.158703] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem2: probe: 0
[  596.161766] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem2: register pmem2
[  596.164114] cxl_core:cxl_port_alloc:730: cxl_mem mem2: host-bridge: cxl_host_bridge.0
[  596.167617] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.0: Added to port endpoint18
[  596.170388] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.1: Added to port endpoint18
[  596.173834] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.2: Added to port endpoint18
[  596.177128] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.3: Added to port endpoint18
[  596.181163] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.4: Added to port endpoint18
[  596.186385] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.5: Added to port endpoint18
[  596.189772] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.6: Added to port endpoint18
[  596.193368] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.7: Added to port endpoint18
[  596.196245] cxl_core:cxl_bus_probe:2077: cxl_port endpoint18: probe: 0
[  596.199650] cxl_core:devm_cxl_add_port:925: cxl_mem mem2: endpoint18 added to port17
[  596.201853] cxl_core:cxl_bus_probe:2077: cxl_mem mem2: probe: 0
[  596.204633] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: mem3 dport_dev: cxl_switch_dport.3 parent: cxl_switch_uport.3
[  596.208983] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.3: host-bridge: cxl_host_bridge.1
[  596.212636] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.0
[  596.215820] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.1
[  596.218309] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.2
[  596.222165] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.3: dport added to port19
[  596.224738] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.0
[  596.227105] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.1
[  596.229468] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.2
[  596.232358] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.7: dport added to port19
[  596.236180] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.0: Added to port port19
[  596.239983] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.1: Added to port port19
[  596.243470] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.2: Added to port port19
[  596.246786] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.3: Added to port port19
[  596.250859] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.4: Added to port port19
[  596.254605] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.5: Added to port port19
[  596.257619] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.6: Added to port port19
[  596.262110] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.7: Added to port port19
[  596.264405] cxl_core:cxl_bus_probe:2077: cxl_port port19: probe: 0
[  596.267056] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.3: port19 added to port11
[  596.269265] cxl_core:add_port_attach_ep:1589: cxl_mem mem3: add to new port port19:cxl_switch_uport.3
[  596.271676] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: mem3 dport_dev: cxl_switch_dport.3 parent: cxl_switch_uport.3
[  596.274954] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem3: found already registered port port19:cxl_switch_uport.3
[  596.277954] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: cxl_switch_dport.3 dport_dev: cxl_root_port.3 parent: cxl_host_bridge.1
[  596.280845] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem3: found already registered port port11:cxl_host_bridge.1
[  596.284016] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.286440] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.290927] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.294024] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  596.297432] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem3: probe: 0
[  596.300412] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem3: register pmem3
[  596.303077] cxl_core:cxl_port_alloc:730: cxl_mem mem3: host-bridge: cxl_host_bridge.1
[  596.306924] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.0: Added to port endpoint20
[  596.309574] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.1: Added to port endpoint20
[  596.312947] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.2: Added to port endpoint20
[  596.315738] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.3: Added to port endpoint20
[  596.318321] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.4: Added to port endpoint20
[  596.322060] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.5: Added to port endpoint20
[  596.325211] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.6: Added to port endpoint20
[  596.327943] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.7: Added to port endpoint20
[  596.329866] cxl_core:cxl_bus_probe:2077: cxl_port endpoint20: probe: 0
[  596.332105] cxl_core:devm_cxl_add_port:925: cxl_mem mem3: endpoint20 added to port19
[  596.334047] cxl_core:cxl_bus_probe:2077: cxl_mem mem3: probe: 0
[  596.337262] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem4: scan: iter: mem4 dport_dev: cxl_switch_dport.4 parent: cxl_switch_uport.0
[  596.339961] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem4: found already registered port port13:cxl_switch_uport.0
[  596.342973] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem4: scan: iter: cxl_switch_dport.4 dport_dev: cxl_root_port.0 parent: cxl_host_bridge.0
[  596.346310] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem4: found already registered port port10:cxl_host_bridge.0
[  596.350149] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.353405] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.358854] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.362309] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  596.365571] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem4: probe: 0
[  596.367691] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem4: register pmem4
[  596.369545] cxl_core:cxl_port_alloc:730: cxl_mem mem4: host-bridge: cxl_host_bridge.0
[  596.373532] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.0: Added to port endpoint21
[  596.376769] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.1: Added to port endpoint21
[  596.379645] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.2: Added to port endpoint21
[  596.382311] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.3: Added to port endpoint21
[  596.386046] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.4: Added to port endpoint21
[  596.389731] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.5: Added to port endpoint21
[  596.392956] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.6: Added to port endpoint21
[  596.396426] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.7: Added to port endpoint21
[  596.400639] cxl_core:cxl_calc_interleave_pos:1833: cxl_mem mem0: decoder:decoder14.0 parent:cxl_mem.0 port:endpoint14 range:0xffff010000000-0xffff02fffffff pos:0
[  596.405529] cxl_core:cxl_calc_interleave_pos:1833: cxl_mem mem4: decoder:decoder21.0 parent:cxl_mem.4 port:endpoint21 range:0xffff010000000-0xffff02fffffff pos:1
[  596.410523] cxl_core:cxl_region_sort_targets:1862: cxl region3: region sort successful
[  596.414890] cxl_core:cxl_port_attach_region:1134: cxl region3: mem0:endpoint14 decoder14.0 add: mem0:decoder14.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[  596.423371] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_switch_uport.0:port13 decoder13.0 add: mem0:decoder14.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[  596.434718] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_host_bridge.0:port10 decoder10.0 add: mem0:decoder14.0 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
[  596.444631] cxl_core:cxl_port_attach_region:1134: cxl region3: mem4:endpoint21 decoder21.0 add: mem4:decoder21.0 @ 1 next: none nr_eps: 1 nr_targets: 1
[  596.448978] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_switch_uport.0:port13 decoder13.0 add: mem4:decoder21.0 @ 1 next: mem4 nr_eps: 2 nr_targets: 2
[  596.454901] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_host_bridge.0:port10 decoder10.0 add: mem4:decoder21.0 @ 1 next: cxl_switch_uport.0 nr_eps: 2 nr_targets: 1
[  596.460536] cxl_core:cxl_port_setup_targets:1444: cxl region3: cxl_host_bridge.0:port10 iw: 1 ig: 4096
[  596.463200] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_host_bridge.0:port10 target[0] = cxl_root_port.0 for mem0:decoder14.0 @ 0
[  596.466183] cxl_core:cxl_port_setup_targets:1444: cxl region3: cxl_switch_uport.0:port13 iw: 2 ig: 4096
[  596.469205] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_switch_uport.0:port13 target[0] = cxl_switch_dport.0 for mem0:decoder14.0 @ 0
[  596.472607] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_host_bridge.0:port10 target[0] = cxl_root_port.0 for mem4:decoder21.0 @ 1
[  596.475905] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_switch_uport.0:port13 target[1] = cxl_switch_dport.4 for mem4:decoder21.0 @ 1
[  596.524656] cxl_core:cxl_bus_probe:2077: cxl_dax_region dax_region3: probe: 0
[  596.527381] cxl_core:devm_cxl_add_dax_region:3185: cxl_region region3: region3: register dax_region3
[  596.529951] cxl_core:cxl_bus_probe:2077: cxl_region region3: probe: 0
[  596.533082] cxl_core:cxl_bus_probe:2077: cxl_port endpoint21: probe: 0
[  596.535850] cxl_core:devm_cxl_add_port:925: cxl_mem mem4: endpoint21 added to port13
[  596.538373] cxl_core:cxl_bus_probe:2077: cxl_mem mem4: probe: 0
[  596.541610] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem6: scan: iter: mem6 dport_dev: cxl_switch_dport.5 parent: cxl_switch_uport.1
[  596.545315] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem6: found already registered port port15:cxl_switch_uport.1
[  596.549120] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem6: scan: iter: cxl_switch_dport.5 dport_dev: cxl_root_port.1 parent: cxl_host_bridge.1
[  596.552583] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem6: found already registered port port11:cxl_host_bridge.1
[  596.556954] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.560034] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.564285] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.568081] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  596.571083] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem6: probe: 0
[  596.574433] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem6: register pmem6
[  596.577474] cxl_core:cxl_port_alloc:730: cxl_mem mem6: host-bridge: cxl_host_bridge.1
[  596.582307] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.0: Added to port endpoint22
[  596.586883] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.1: Added to port endpoint22
[  596.590303] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.2: Added to port endpoint22
[  596.594862] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.3: Added to port endpoint22
[  596.598898] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.4: Added to port endpoint22
[  596.603042] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.5: Added to port endpoint22
[  596.606239] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.6: Added to port endpoint22
[  596.610721] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.7: Added to port endpoint22
[  596.613361] cxl_core:cxl_bus_probe:2077: cxl_port endpoint22: probe: 0
[  596.616887] cxl_core:devm_cxl_add_port:925: cxl_mem mem6: endpoint22 added to port15
[  596.619770] cxl_core:cxl_bus_probe:2077: cxl_mem mem6: probe: 0
[  596.623075] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem10: scan: iter: mem10 dport_dev: cxl_switch_dport.6 parent: cxl_switch_uport.2
[  596.626281] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem10: found already registered port port17:cxl_switch_uport.2
[  596.630083] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem10: scan: iter: cxl_switch_dport.6 dport_dev: cxl_root_port.2 parent: cxl_host_bridge.0
[  596.633296] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem10: found already registered port port10:cxl_host_bridge.0
[  596.637819] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.640868] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.645898] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.650342] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  596.653971] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem10: probe: 0
[  596.656796] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem10: register pmem10
[  596.659129] cxl_core:cxl_port_alloc:730: cxl_mem mem10: host-bridge: cxl_host_bridge.0
[  596.662899] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.0: Added to port endpoint23
[  596.665953] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.1: Added to port endpoint23
[  596.669908] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.2: Added to port endpoint23
[  596.673475] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.3: Added to port endpoint23
[  596.677580] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.4: Added to port endpoint23
[  596.681824] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.5: Added to port endpoint23
[  596.686002] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.6: Added to port endpoint23
[  596.689503] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.7: Added to port endpoint23
[  596.692331] cxl_core:cxl_bus_probe:2077: cxl_port endpoint23: probe: 0
[  596.695612] cxl_core:devm_cxl_add_port:925: cxl_mem mem10: endpoint23 added to port17
[  596.698325] cxl_core:cxl_bus_probe:2077: cxl_mem mem10: probe: 0
[  596.701263] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem11: scan: iter: mem11 dport_dev: cxl_switch_dport.7 parent: cxl_switch_uport.3
[  596.704694] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem11: found already registered port port19:cxl_switch_uport.3
[  596.707400] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem11: scan: iter: cxl_switch_dport.7 dport_dev: cxl_root_port.3 parent: cxl_host_bridge.1
[  596.710902] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem11: found already registered port port11:cxl_host_bridge.1
[  596.715726] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.718109] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.723090] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.726829] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  596.730126] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem11: probe: 0
[  596.732946] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem11: register pmem11
[  596.736153] cxl_core:cxl_port_alloc:730: cxl_mem mem11: host-bridge: cxl_host_bridge.1
[  596.739913] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.0: Added to port endpoint24
[  596.742614] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.1: Added to port endpoint24
[  596.746078] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.2: Added to port endpoint24
[  596.749849] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.3: Added to port endpoint24
[  596.753306] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.4: Added to port endpoint24
[  596.755877] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.5: Added to port endpoint24
[  596.758330] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.6: Added to port endpoint24
[  596.761713] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.7: Added to port endpoint24
[  596.763805] cxl_core:cxl_bus_probe:2077: cxl_port endpoint24: probe: 0
[  596.766381] cxl_core:devm_cxl_add_port:925: cxl_mem mem11: endpoint24 added to port19
[  596.768728] cxl_core:cxl_bus_probe:2077: cxl_mem mem11: probe: 0
[  596.770809] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: mem12 dport_dev: cxl_switch_dport.8 parent: cxl_switch_uport.4
[  596.774529] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.4: host-bridge: cxl_host_bridge.2
[  596.779817] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.8: dport added to port25
[  596.783100] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.9: dport added to port25
[  596.786831] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.0: Added to port port25
[  596.790012] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.1: Added to port port25
[  596.792943] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.2: Added to port port25
[  596.795920] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.3: Added to port port25
[  596.798579] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.4: Added to port port25
[  596.801962] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.5: Added to port port25
[  596.805519] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.6: Added to port port25
[  596.808389] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.7: Added to port port25
[  596.810361] cxl_core:cxl_bus_probe:2077: cxl_port port25: probe: 0
[  596.813025] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.4: port25 added to port12
[  596.815315] cxl_core:add_port_attach_ep:1589: cxl_mem mem12: add to new port port25:cxl_switch_uport.4
[  596.817513] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: mem12 dport_dev: cxl_switch_dport.8 parent: cxl_switch_uport.4
[  596.820316] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem12: found already registered port port25:cxl_switch_uport.4
[  596.822880] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: cxl_switch_dport.8 dport_dev: cxl_root_port.4 parent: cxl_host_bridge.2
[  596.825615] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem12: found already registered port port12:cxl_host_bridge.2
[  596.829435] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.831846] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.836050] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.839058] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  596.842359] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem12: probe: 0
[  596.845221] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem12: register pmem12
[  596.847526] cxl_core:cxl_port_alloc:730: cxl_mem mem12: host-bridge: cxl_host_bridge.2
[  596.850658] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.0: Added to port endpoint26
[  596.854260] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.1: Added to port endpoint26
[  596.857822] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.2: Added to port endpoint26
[  596.860858] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.3: Added to port endpoint26
[  596.863976] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.4: Added to port endpoint26
[  596.866605] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.5: Added to port endpoint26
[  596.870076] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.6: Added to port endpoint26
[  596.873358] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.7: Added to port endpoint26
[  596.875562] cxl_core:cxl_bus_probe:2077: cxl_port endpoint26: probe: 0
[  596.878332] cxl_core:devm_cxl_add_port:925: cxl_mem mem12: endpoint26 added to port25
[  596.881142] cxl_core:cxl_bus_probe:2077: cxl_mem mem12: probe: 0
[  596.883724] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem13: scan: iter: mem13 dport_dev: cxl_switch_dport.9 parent: cxl_switch_uport.4
[  596.886311] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem13: found already registered port port25:cxl_switch_uport.4
[  596.888931] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem13: scan: iter: cxl_switch_dport.9 dport_dev: cxl_root_port.4 parent: cxl_host_bridge.2
[  596.891595] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem13: found already registered port port12:cxl_host_bridge.2
[  596.895537] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.897863] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.902472] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  596.904807] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  596.908005] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem13: probe: 0
[  596.910467] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem13: register pmem13
[  596.912698] cxl_core:cxl_port_alloc:730: cxl_mem mem13: host-bridge: cxl_host_bridge.2
[  596.916648] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.0: Added to port endpoint27
[  596.919829] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.1: Added to port endpoint27
[  596.922630] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.2: Added to port endpoint27
[  596.926349] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.3: Added to port endpoint27
[  596.929977] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.4: Added to port endpoint27
[  596.933175] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.5: Added to port endpoint27
[  596.935968] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.6: Added to port endpoint27
[  596.938531] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.7: Added to port endpoint27
[  596.940432] cxl_core:cxl_bus_probe:2077: cxl_port endpoint27: probe: 0
[  596.943261] cxl_core:devm_cxl_add_port:925: cxl_mem mem13: endpoint27 added to port25
[  596.945741] cxl_core:cxl_bus_probe:2077: cxl_mem mem13: probe: 0
[  596.949224] cxl_core:cxl_port_alloc:730: cxl_mem mem14: host-bridge: cxl_host_bridge.3
[  596.964002] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.0: Added to port endpoint28
[  596.967849] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.1: Added to port endpoint28
[  596.971905] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.2: Added to port endpoint28
[  596.974962] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.3: Added to port endpoint28
[  596.977764] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.4: Added to port endpoint28
[  596.980646] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.5: Added to port endpoint28
[  596.983560] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.6: Added to port endpoint28
[  596.986148] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.7: Added to port endpoint28
[  596.988218] cxl_core:cxl_bus_probe:2077: cxl_port endpoint28: probe: 0
[  596.991793] cxl_core:devm_cxl_add_port:925: cxl_mem mem14: endpoint28 added to root9
[  596.993909] cxl_core:cxl_bus_probe:2077: cxl_mem mem14: probe: 0
[  596.997119] cxl_core:cxl_bus_rescan_queue:2095: CXL bus rescan result: 0
[  600.342832] cxl_core:cxl_region_probe:3402: cxl_region region5: config state: 0
[  600.345430] cxl_core:cxl_bus_probe:2077: cxl_region region5: probe: -6
[  600.355229] cxl_core:devm_cxl_add_region:2499: cxl_acpi cxl_acpi.0: decoder9.2: created region5
[  600.386745] cxl_core:cxl_port_attach_region:1134: cxl region5: mem0:endpoint14 decoder14.1 add: mem0:decoder14.1 @ 0 next: none nr_eps: 1 nr_targets: 1
[  600.391040] cxl_core:cxl_port_attach_region:1134: cxl region5: cxl_switch_uport.0:port13 decoder13.1 add: mem0:decoder14.1 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[  600.397658] cxl_core:cxl_port_attach_region:1134: cxl region5: cxl_host_bridge.0:port10 decoder10.1 add: mem0:decoder14.1 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
[  600.402670] cxl_core:cxl_port_setup_targets:1444: cxl region5: cxl_host_bridge.0:port10 iw: 1 ig: 256
[  600.405288] cxl_core:cxl_port_setup_targets:1468: cxl region5: cxl_host_bridge.0:port10 target[0] = cxl_root_port.0 for mem0:decoder14.1 @ 0
[  600.408283] cxl_core:cxl_port_setup_targets:1444: cxl region5: cxl_switch_uport.0:port13 iw: 1 ig: 256
[  600.410626] cxl_core:cxl_port_setup_targets:1468: cxl region5: cxl_switch_uport.0:port13 target[0] = cxl_switch_dport.0 for mem0:decoder14.1 @ 0
[  600.413351] cxl_core:cxl_calc_interleave_pos:1833: cxl_mem mem0: decoder:decoder14.1 parent:cxl_mem.0 port:endpoint14 range:0xffff0d0000000-0xffff10fffffff pos:0
[  600.418352] cxl_core:cxl_region_attach:2030: cxl decoder14.1: Test cxl_calc_interleave_pos(): success test_pos:0 cxled->pos:0
[  600.421577] cxl_test:mock_decoder_commit:681: cxl_port endpoint14: decoder14.1 commit
[  600.424040] cxl_test:mock_decoder_commit:681: cxl_port port13: decoder13.1 commit
[  600.426081] cxl_test:mock_decoder_commit:681: cxl_port port10: decoder10.1 commit
[  600.431558] cxl_pmem:cxl_pmem_region_probe:346: cxl_region region5: changing target node from -1 to 0
[  600.434063] cxl_core:cxl_bus_probe:2077: cxl_pmem_region pmem_region5: probe: 0
[  600.436775] cxl_core:devm_cxl_add_pmem_region:3134: cxl_region region5: region5: register pmem_region5
[  600.439113] cxl_core:cxl_bus_probe:2077: cxl_region region5: probe: 0
[  600.647811] cxl_test:mock_decoder_reset:704: cxl_port port10: decoder10.1 reset
[  600.650034] cxl_test:mock_decoder_reset:704: cxl_port port13: decoder13.1 reset
[  600.652445] cxl_test:mock_decoder_reset:704: cxl_port endpoint14: decoder14.1 reset
[  601.986819] cxl_test:mock_decoder_reset:704: cxl_port port10: decoder10.0 reset
[  601.989354] cxl_test:mock_decoder_reset:704: cxl_port port13: decoder13.0 reset
[  601.991500] cxl_test:mock_decoder_reset:704: cxl_port endpoint21: decoder21.0 reset
[  601.993596] cxl_test:mock_decoder_reset:704: cxl_port endpoint14: decoder14.0 reset
[  603.475043] cxl_core:devm_cxl_add_port:925: cxl_acpi ACPI0017:00: root0 added (root port)
[  603.480765] cxl_acpi:to_cxl_host_bridge:30: cxl_acpi ACPI0017:00: found host bridge ACPI0016:00
[  603.487124] cxl_acpi:cxl_get_chbs:521: acpi ACPI0016:00: UID found: 191
[  603.490701] cxl_core:devm_cxl_add_dport:1216:  pci0000:bf: dport added to root0
[  603.492993] (NULL device *): found host bridge ACPI0016:00
[  603.494921] cxl_acpi:add_host_bridge_dport:608: acpi ACPI0016:00: Failed to get generic port perf coordinates.
[  603.498695] cxl_acpi:to_cxl_host_bridge:30: cxl_acpi ACPI0017:00: found host bridge ACPI0016:01
[  603.501976] cxl_acpi:cxl_get_chbs:521: acpi ACPI0016:01: UID found: 53
[  603.504978] cxl_core:devm_cxl_add_dport:1216:  pci0000:35: dport added to root0
[  603.508611] (NULL device *): found host bridge ACPI0016:01
[  603.512477] cxl_acpi:add_host_bridge_dport:608: acpi ACPI0016:01: Failed to get generic port perf coordinates.
[  603.518569] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi ACPI0017:00: decode range: node: 6 range [0xb90000000 - 0xc8fffffff]
[  603.522936] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi ACPI0017:00: decode range: node: 7 range [0xc90000000 - 0xd8fffffff]
[  603.527121] cxl_acpi:to_cxl_host_bridge:30: cxl_acpi ACPI0017:00: found host bridge ACPI0016:00
[  603.530575] cxl_acpi:cxl_get_chbs:521: acpi ACPI0016:00: UID found: 191
[  603.533783] cxl_acpi:add_host_bridge_uport:658: acpi ACPI0016:00: CHBCR found for UID 191: 0x0000000b80400000
[  603.536894] cxl_core:cxl_port_alloc:730:  pci0000:bf: host-bridge: pci0000:bf
[  603.540174] cxl_core:cxl_map_regblock:414: cxl port1: Mapped CXL Memory Device resource 0x0000000b80400000
[  603.542881] cxl_core:cxl_probe_component_regs:96: cxl port1: Unknown CM cap ID: 0 (0x0)
[  603.545428] cxl_core:cxl_probe_component_regs:96: cxl port1: Unknown CM cap ID: 4 (0xd8)
[  603.548246] cxl_core:cxl_probe_component_regs:81: cxl port1: found HDM decoder capability (0x128)
[  603.550798] cxl_core:cxl_probe_component_regs:96: cxl port1: Unknown CM cap ID: 6 (0x278)
[  603.553460] cxl_core:cxl_probe_component_regs:96: cxl port1: Unknown CM cap ID: 8 (0xaa0)
[  603.556007] cxl_core:cxl_probe_regs:435: cxl port1: Set up component registers
[  603.559063] cxl_core:devm_cxl_add_port:925:  pci0000:bf: port1 added to root0
[  603.561398]  pci0000:bf: host supports CXL
[  603.563831] cxl_acpi:to_cxl_host_bridge:30: cxl_acpi ACPI0017:00: found host bridge ACPI0016:01
[  603.569073] cxl_acpi:cxl_get_chbs:521: acpi ACPI0016:01: UID found: 53
[  603.572128] cxl_acpi:add_host_bridge_uport:658: acpi ACPI0016:01: CHBCR found for UID 53: 0x0000000b80410000
[  603.576100] cxl_core:cxl_port_alloc:730:  pci0000:35: host-bridge: pci0000:35
[  603.578879] cxl_core:cxl_map_regblock:414: cxl port2: Mapped CXL Memory Device resource 0x0000000b80410000
[  603.581380] cxl_core:cxl_probe_component_regs:96: cxl port2: Unknown CM cap ID: 0 (0x0)
[  603.583766] cxl_core:cxl_probe_component_regs:96: cxl port2: Unknown CM cap ID: 4 (0xd8)
[  603.585948] cxl_core:cxl_probe_component_regs:81: cxl port2: found HDM decoder capability (0x128)
[  603.588534] cxl_core:cxl_probe_component_regs:96: cxl port2: Unknown CM cap ID: 6 (0x278)
[  603.590694] cxl_core:cxl_probe_component_regs:96: cxl port2: Unknown CM cap ID: 8 (0xaa0)
[  603.592836] cxl_core:cxl_probe_regs:435: cxl port2: Set up component registers
[  603.595563] cxl_core:devm_cxl_add_port:925:  pci0000:35: port2 added to root0
[  603.597756]  pci0000:35: host supports CXL
[  603.600400] cxl_acpi:add_root_nvdimm_bridge:693: cxl_acpi ACPI0017:00: root0: add: nvdimm-bridge0
[  603.603089] cxl_core:cxl_bus_rescan_queue:2095: CXL bus rescan result: 0
[  603.612558] cxl_core:cxl_map_regblock:414: pcieport 0000:bf:00.0: Mapped CXL Memory Device resource 0x0000385800020000
[  603.615451] cxl_core:cxl_probe_component_regs:90: pcieport 0000:bf:00.0: found RAS capability (0x80)
[  603.617790] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:00.0: Unknown CM cap ID: 4 (0xd8)
[  603.619670] cxl_core:cxl_bus_probe:2077: cxl_nvdimm_bridge nvdimm-bridge0: probe: 0
[  603.620521] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:00.0: Unknown CM cap ID: 0 (0x0)
[  603.625758] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:00.0: Unknown CM cap ID: 6 (0x278)
[  603.628340] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:00.0: Unknown CM cap ID: 8 (0xaa0)
[  603.630702] cxl_core:cxl_probe_regs:435: pcieport 0000:bf:00.0: Set up component registers
[  603.633134] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:bf:00.0: Component Registers found for dport: 0x0000385800020000
[  603.638845] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:bf:00.0: dport added to port1
[  603.643540] cxl_core:cxl_map_regblock:414: pcieport 0000:bf:01.0: Mapped CXL Memory Device resource 0x0000385800000000
[  603.646186] cxl_core:cxl_probe_component_regs:90: pcieport 0000:bf:01.0: found RAS capability (0x80)
[  603.649061] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:01.0: Unknown CM cap ID: 4 (0xd8)
[  603.651466] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:01.0: Unknown CM cap ID: 0 (0x0)
[  603.653905] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:01.0: Unknown CM cap ID: 6 (0x278)
[  603.656519] cxl_core:cxl_probe_component_regs:96: pcieport 0000:bf:01.0: Unknown CM cap ID: 8 (0xaa0)
[  603.658688] cxl_core:cxl_probe_regs:435: pcieport 0000:bf:01.0: Set up component registers
[  603.661070] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:bf:01.0: Component Registers found for dport: 0x0000385800000000
[  603.664706] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:bf:01.0: dport added to port1
[  603.695573] cxl_core:init_hdm_decoder:910: cxl_port port1: decoder1.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.699060] cxl_core:add_hdm_decoder:37: cxl decoder1.0: Added to port port1
[  603.702165] cxl_core:init_hdm_decoder:910: cxl_port port1: decoder1.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.706201] cxl_core:add_hdm_decoder:37: cxl decoder1.1: Added to port port1
[  603.709680] cxl_core:init_hdm_decoder:910: cxl_port port1: decoder1.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.713007] cxl_core:add_hdm_decoder:37: cxl decoder1.2: Added to port port1
[  603.715162] cxl_core:init_hdm_decoder:910: cxl_port port1: decoder1.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.718533] cxl_core:add_hdm_decoder:37: cxl decoder1.3: Added to port port1
[  603.721038] cxl_core:cxl_bus_probe:2077: cxl_port port1: probe: 0
[  603.724117] cxl_core:cxl_map_regblock:414: pcieport 0000:35:00.0: Mapped CXL Memory Device resource 0x0000382800020000
[  603.727772] cxl_core:cxl_probe_component_regs:90: pcieport 0000:35:00.0: found RAS capability (0x80)
[  603.730450] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:00.0: Unknown CM cap ID: 4 (0xd8)
[  603.733190] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:00.0: Unknown CM cap ID: 0 (0x0)
[  603.736205] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:00.0: Unknown CM cap ID: 6 (0x278)
[  603.738942] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:00.0: Unknown CM cap ID: 8 (0xaa0)
[  603.741619] cxl_core:cxl_probe_regs:435: pcieport 0000:35:00.0: Set up component registers
[  603.744811] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:35:00.0: Component Registers found for dport: 0x0000382800020000
[  603.751505] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:35:00.0: dport added to port2
[  603.754909] cxl_core:cxl_map_regblock:414: pcieport 0000:35:01.0: Mapped CXL Memory Device resource 0x0000382800000000
[  603.757429] cxl_core:cxl_probe_component_regs:90: pcieport 0000:35:01.0: found RAS capability (0x80)
[  603.759917] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:01.0: Unknown CM cap ID: 4 (0xd8)
[  603.762092] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:01.0: Unknown CM cap ID: 0 (0x0)
[  603.764802] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:01.0: Unknown CM cap ID: 6 (0x278)
[  603.767038] cxl_core:cxl_probe_component_regs:96: pcieport 0000:35:01.0: Unknown CM cap ID: 8 (0xaa0)
[  603.769414] cxl_core:cxl_probe_regs:435: pcieport 0000:35:01.0: Set up component registers
[  603.772212] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:35:01.0: Component Registers found for dport: 0x0000382800000000
[  603.776566] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:35:01.0: dport added to port2
[  603.807631] cxl_core:init_hdm_decoder:910: cxl_port port2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.811852] cxl_core:add_hdm_decoder:37: cxl decoder2.0: Added to port port2
[  603.815948] cxl_core:init_hdm_decoder:910: cxl_port port2: decoder2.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.819679] cxl_core:add_hdm_decoder:37: cxl decoder2.1: Added to port port2
[  603.822634] cxl_core:init_hdm_decoder:910: cxl_port port2: decoder2.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.827001] cxl_core:add_hdm_decoder:37: cxl decoder2.2: Added to port port2
[  603.830070] cxl_core:init_hdm_decoder:910: cxl_port port2: decoder2.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.834106] cxl_core:add_hdm_decoder:37: cxl decoder2.3: Added to port port2
[  603.837136] cxl_core:cxl_bus_probe:2077: cxl_port port2: probe: 0
[  603.849608] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem5: scan: iter: mem5 dport_dev: 0000:c1:02.0 parent: 0000:c0:00.0
[  603.853457] cxl_core:cxl_port_alloc:730: pcieport 0000:c0:00.0: host-bridge: pci0000:bf
[  603.856610] cxl_core:cxl_map_regblock:414: cxl port3: Mapped CXL Memory Device resource 0x0000000082940000
[  603.860674] cxl_core:cxl_probe_component_regs:90: cxl port3: found RAS capability (0x80)
[  603.863014] cxl_core:cxl_probe_component_regs:96: cxl port3: Unknown CM cap ID: 4 (0xd8)
[  603.865392] cxl_core:cxl_probe_component_regs:81: cxl port3: found HDM decoder capability (0x128)
[  603.867984] cxl_core:cxl_probe_regs:435: cxl port3: Set up component registers
[  603.873326] cxl_core:cxl_cdat_get_length:540: cxl_port port3: CDAT length 112
[  603.879312] cxl_core:cxl_map_regblock:414: pcieport 0000:c1:00.0: Mapped CXL Memory Device resource 0x0000000082800000
[  603.882034] cxl_core:cxl_probe_component_regs:90: pcieport 0000:c1:00.0: found RAS capability (0x80)
[  603.885012] cxl_core:cxl_probe_component_regs:96: pcieport 0000:c1:00.0: Unknown CM cap ID: 4 (0xd8)
[  603.887643] cxl_core:cxl_probe_regs:435: pcieport 0000:c1:00.0: Set up component registers
[  603.890841] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:c1:00.0: Component Registers found for dport: 0x0000000082800000
[  603.894368] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:c1:00.0: dport added to port3
[  603.898332] cxl_core:cxl_map_regblock:414: pcieport 0000:c1:01.0: Mapped CXL Memory Device resource 0x0000000082820000
[  603.901039] cxl_core:cxl_probe_component_regs:90: pcieport 0000:c1:01.0: found RAS capability (0x80)
[  603.903707] cxl_core:cxl_probe_component_regs:96: pcieport 0000:c1:01.0: Unknown CM cap ID: 4 (0xd8)
[  603.906112] cxl_core:cxl_probe_regs:435: pcieport 0000:c1:01.0: Set up component registers
[  603.909275] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:c1:01.0: Component Registers found for dport: 0x0000000082820000
[  603.914047] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:c1:01.0: dport added to port3
[  603.918915] cxl_core:cxl_map_regblock:414: pcieport 0000:c1:02.0: Mapped CXL Memory Device resource 0x0000000082840000
[  603.922140] cxl_core:cxl_probe_component_regs:90: pcieport 0000:c1:02.0: found RAS capability (0x80)
[  603.925210] cxl_core:cxl_probe_component_regs:96: pcieport 0000:c1:02.0: Unknown CM cap ID: 4 (0xd8)
[  603.927828] cxl_core:cxl_probe_regs:435: pcieport 0000:c1:02.0: Set up component registers
[  603.930584] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:c1:02.0: Component Registers found for dport: 0x0000000082840000
[  603.933669] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:c1:02.0: dport added to port3
[  603.936826] cxl_core:cxl_map_regblock:414: pcieport 0000:c1:03.0: Mapped CXL Memory Device resource 0x0000000082860000
[  603.939800] cxl_core:cxl_probe_component_regs:90: pcieport 0000:c1:03.0: found RAS capability (0x80)
[  603.942440] cxl_core:cxl_probe_component_regs:96: pcieport 0000:c1:03.0: Unknown CM cap ID: 4 (0xd8)
[  603.944959] cxl_core:cxl_probe_regs:435: pcieport 0000:c1:03.0: Set up component registers
[  603.947767] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:c1:03.0: Component Registers found for dport: 0x0000000082860000
[  603.950763] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:c1:03.0: dport added to port3
[  603.979583] cxl_core:init_hdm_decoder:910: cxl_port port3: decoder3.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.983786] cxl_core:add_hdm_decoder:37: cxl decoder3.0: Added to port port3
[  603.987077] cxl_core:init_hdm_decoder:910: cxl_port port3: decoder3.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.990593] cxl_core:add_hdm_decoder:37: cxl decoder3.1: Added to port port3
[  603.993941] cxl_core:init_hdm_decoder:910: cxl_port port3: decoder3.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  603.998374] cxl_core:add_hdm_decoder:37: cxl decoder3.2: Added to port port3
[  604.002904] cxl_core:init_hdm_decoder:910: cxl_port port3: decoder3.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.008065] cxl_core:add_hdm_decoder:37: cxl decoder3.3: Added to port port3
[  604.011255] cxl_core:cxl_bus_probe:2077: cxl_port port3: probe: 0
[  604.015112] cxl_core:devm_cxl_add_port:925: pcieport 0000:c0:00.0: port3 added to port1
[  604.017864] cxl_core:add_port_attach_ep:1589: cxl_mem mem5: add to new port port3:0000:c0:00.0
[  604.021614] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem5: scan: iter: mem5 dport_dev: 0000:c1:02.0 parent: 0000:c0:00.0
[  604.025144] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem5: found already registered port port3:0000:c0:00.0
[  604.028574] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem5: scan: iter: 0000:c1:02.0 dport_dev: 0000:bf:00.0 parent: pci0000:bf
[  604.032306] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem5: found already registered port port1:pci0000:bf
[  604.035753] cxl_core:cxl_port_alloc:730: cxl_mem mem5: host-bridge: pci0000:bf
[  604.040700] cxl_core:cxl_cdat_get_length:540: cxl_port endpoint4: CDAT length 160
[  604.049846] cxl_core:cxl_port_perf_data_calculate:208: cxl_port endpoint4: Failed to retrieve ep perf coordinates.
[  604.053237] cxl_core:cxl_endpoint_parse_cdat:410: cxl_port endpoint4: Failed to do perf coord calculations.
[  604.087570] cxl_core:init_hdm_decoder:910: cxl_port endpoint4: decoder4.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.091728] cxl_core:add_hdm_decoder:37: cxl decoder4.0: Added to port endpoint4
[  604.094698] cxl_core:init_hdm_decoder:910: cxl_port endpoint4: decoder4.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.098805] cxl_core:add_hdm_decoder:37: cxl decoder4.1: Added to port endpoint4
[  604.101839] cxl_core:init_hdm_decoder:910: cxl_port endpoint4: decoder4.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.106314] cxl_core:add_hdm_decoder:37: cxl decoder4.2: Added to port endpoint4
[  604.110283] cxl_core:init_hdm_decoder:910: cxl_port endpoint4: decoder4.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.114068] cxl_core:add_hdm_decoder:37: cxl decoder4.3: Added to port endpoint4
[  604.116978] cxl_core:cxl_bus_probe:2077: cxl_port endpoint4: probe: 0
[  604.119870] cxl_core:devm_cxl_add_port:925: cxl_mem mem5: endpoint4 added to port3
[  604.122550] cxl_core:cxl_bus_probe:2077: cxl_mem mem5: probe: 0
[  604.127581] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem7: scan: iter: mem7 dport_dev: 0000:37:02.0 parent: 0000:36:00.0
[  604.133032] cxl_core:cxl_port_alloc:730: pcieport 0000:36:00.0: host-bridge: pci0000:35
[  604.138135] cxl_core:cxl_map_regblock:414: cxl port5: Mapped CXL Memory Device resource 0x0000000081d40000
[  604.141501] cxl_core:cxl_probe_component_regs:90: cxl port5: found RAS capability (0x80)
[  604.144384] cxl_core:cxl_probe_component_regs:96: cxl port5: Unknown CM cap ID: 4 (0xd8)
[  604.146913] cxl_core:cxl_probe_component_regs:81: cxl port5: found HDM decoder capability (0x128)
[  604.149564] cxl_core:cxl_probe_regs:435: cxl port5: Set up component registers
[  604.154122] cxl_core:cxl_cdat_get_length:540: cxl_port port5: CDAT length 112
[  604.159732] cxl_core:cxl_map_regblock:414: pcieport 0000:37:00.0: Mapped CXL Memory Device resource 0x0000000081c00000
[  604.163704] cxl_core:cxl_probe_component_regs:90: pcieport 0000:37:00.0: found RAS capability (0x80)
[  604.166770] cxl_core:cxl_probe_component_regs:96: pcieport 0000:37:00.0: Unknown CM cap ID: 4 (0xd8)
[  604.169685] cxl_core:cxl_probe_regs:435: pcieport 0000:37:00.0: Set up component registers
[  604.173956] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:37:00.0: Component Registers found for dport: 0x0000000081c00000
[  604.178459] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:37:00.0: dport added to port5
[  604.181658] cxl_core:cxl_map_regblock:414: pcieport 0000:37:01.0: Mapped CXL Memory Device resource 0x0000000081c20000
[  604.185725] cxl_core:cxl_probe_component_regs:90: pcieport 0000:37:01.0: found RAS capability (0x80)
[  604.188849] cxl_core:cxl_probe_component_regs:96: pcieport 0000:37:01.0: Unknown CM cap ID: 4 (0xd8)
[  604.191728] cxl_core:cxl_probe_regs:435: pcieport 0000:37:01.0: Set up component registers
[  604.194514] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:37:01.0: Component Registers found for dport: 0x0000000081c20000
[  604.198492] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:37:01.0: dport added to port5
[  604.202637] cxl_core:cxl_map_regblock:414: pcieport 0000:37:02.0: Mapped CXL Memory Device resource 0x0000000081c40000
[  604.205636] cxl_core:cxl_probe_component_regs:90: pcieport 0000:37:02.0: found RAS capability (0x80)
[  604.208776] cxl_core:cxl_probe_component_regs:96: pcieport 0000:37:02.0: Unknown CM cap ID: 4 (0xd8)
[  604.211709] cxl_core:cxl_probe_regs:435: pcieport 0000:37:02.0: Set up component registers
[  604.214640] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:37:02.0: Component Registers found for dport: 0x0000000081c40000
[  604.218204] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:37:02.0: dport added to port5
[  604.221343] cxl_core:cxl_map_regblock:414: pcieport 0000:37:03.0: Mapped CXL Memory Device resource 0x0000000081c60000
[  604.224478] cxl_core:cxl_probe_component_regs:90: pcieport 0000:37:03.0: found RAS capability (0x80)
[  604.226924] cxl_core:cxl_probe_component_regs:96: pcieport 0000:37:03.0: Unknown CM cap ID: 4 (0xd8)
[  604.229371] cxl_core:cxl_probe_regs:435: pcieport 0000:37:03.0: Set up component registers
[  604.232386] cxl_core:__devm_cxl_add_dport:1163: pcieport 0000:37:03.0: Component Registers found for dport: 0x0000000081c60000
[  604.236852] cxl_core:devm_cxl_add_dport:1216: pcieport 0000:37:03.0: dport added to port5
[  604.267450] cxl_core:init_hdm_decoder:910: cxl_port port5: decoder5.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.272344] cxl_core:add_hdm_decoder:37: cxl decoder5.0: Added to port port5
[  604.276520] cxl_core:init_hdm_decoder:910: cxl_port port5: decoder5.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.281288] cxl_core:add_hdm_decoder:37: cxl decoder5.1: Added to port port5
[  604.284405] cxl_core:init_hdm_decoder:910: cxl_port port5: decoder5.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.288878] cxl_core:add_hdm_decoder:37: cxl decoder5.2: Added to port port5
[  604.291791] cxl_core:init_hdm_decoder:910: cxl_port port5: decoder5.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.295634] cxl_core:add_hdm_decoder:37: cxl decoder5.3: Added to port port5
[  604.298173] cxl_core:cxl_bus_probe:2077: cxl_port port5: probe: 0
[  604.301858] cxl_core:devm_cxl_add_port:925: pcieport 0000:36:00.0: port5 added to port2
[  604.305664] cxl_core:add_port_attach_ep:1589: cxl_mem mem7: add to new port port5:0000:36:00.0
[  604.309530] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem7: scan: iter: mem7 dport_dev: 0000:37:02.0 parent: 0000:36:00.0
[  604.313874] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem7: found already registered port port5:0000:36:00.0
[  604.317528] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem7: scan: iter: 0000:37:02.0 dport_dev: 0000:35:00.0 parent: pci0000:35
[  604.322129] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem7: found already registered port port2:pci0000:35
[  604.326135] cxl_core:cxl_port_alloc:730: cxl_mem mem7: host-bridge: pci0000:35
[  604.331454] cxl_core:cxl_cdat_get_length:540: cxl_port endpoint6: CDAT length 160
[  604.339358] cxl_core:cxl_port_perf_data_calculate:208: cxl_port endpoint6: Failed to retrieve ep perf coordinates.
[  604.342129] cxl_core:cxl_endpoint_parse_cdat:410: cxl_port endpoint6: Failed to do perf coord calculations.
[  604.371526] cxl_core:init_hdm_decoder:910: cxl_port endpoint6: decoder6.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.375039] cxl_core:add_hdm_decoder:37: cxl decoder6.0: Added to port endpoint6
[  604.378375] cxl_core:init_hdm_decoder:910: cxl_port endpoint6: decoder6.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.382707] cxl_core:add_hdm_decoder:37: cxl decoder6.1: Added to port endpoint6
[  604.386006] cxl_core:init_hdm_decoder:910: cxl_port endpoint6: decoder6.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.390671] cxl_core:add_hdm_decoder:37: cxl decoder6.2: Added to port endpoint6
[  604.394388] cxl_core:init_hdm_decoder:910: cxl_port endpoint6: decoder6.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.399746] cxl_core:add_hdm_decoder:37: cxl decoder6.3: Added to port endpoint6
[  604.402506] cxl_core:cxl_bus_probe:2077: cxl_port endpoint6: probe: 0
[  604.406252] cxl_core:devm_cxl_add_port:925: cxl_mem mem7: endpoint6 added to port5
[  604.409907] cxl_core:cxl_bus_probe:2077: cxl_mem mem7: probe: 0
[  604.413144] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem8: scan: iter: mem8 dport_dev: 0000:c1:00.0 parent: 0000:c0:00.0
[  604.416147] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem8: found already registered port port3:0000:c0:00.0
[  604.419457] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem8: scan: iter: 0000:c1:00.0 dport_dev: 0000:bf:00.0 parent: pci0000:bf
[  604.422896] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem8: found already registered port port1:pci0000:bf
[  604.426807] cxl_core:cxl_port_alloc:730: cxl_mem mem8: host-bridge: pci0000:bf
[  604.431746] cxl_core:cxl_cdat_get_length:540: cxl_port endpoint7: CDAT length 160
[  604.438983] cxl_core:cxl_port_perf_data_calculate:208: cxl_port endpoint7: Failed to retrieve ep perf coordinates.
[  604.441912] cxl_core:cxl_endpoint_parse_cdat:410: cxl_port endpoint7: Failed to do perf coord calculations.
[  604.475462] cxl_core:init_hdm_decoder:910: cxl_port endpoint7: decoder7.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.479819] cxl_core:add_hdm_decoder:37: cxl decoder7.0: Added to port endpoint7
[  604.483335] cxl_core:init_hdm_decoder:910: cxl_port endpoint7: decoder7.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.487711] cxl_core:add_hdm_decoder:37: cxl decoder7.1: Added to port endpoint7
[  604.490348] cxl_core:init_hdm_decoder:910: cxl_port endpoint7: decoder7.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.494736] cxl_core:add_hdm_decoder:37: cxl decoder7.2: Added to port endpoint7
[  604.498286] cxl_core:init_hdm_decoder:910: cxl_port endpoint7: decoder7.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.501947] cxl_core:add_hdm_decoder:37: cxl decoder7.3: Added to port endpoint7
[  604.504886] cxl_core:cxl_bus_probe:2077: cxl_port endpoint7: probe: 0
[  604.508144] cxl_core:devm_cxl_add_port:925: cxl_mem mem8: endpoint7 added to port3
[  604.511435] cxl_core:cxl_bus_probe:2077: cxl_mem mem8: probe: 0
[  604.514348] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem9: scan: iter: mem9 dport_dev: 0000:37:00.0 parent: 0000:36:00.0
[  604.517345] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem9: found already registered port port5:0000:36:00.0
[  604.521099] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem9: scan: iter: 0000:37:00.0 dport_dev: 0000:35:00.0 parent: pci0000:35
[  604.524636] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem9: found already registered port port2:pci0000:35
[  604.528696] cxl_core:cxl_port_alloc:730: cxl_mem mem9: host-bridge: pci0000:35
[  604.533651] cxl_core:cxl_cdat_get_length:540: cxl_port endpoint8: CDAT length 160
[  604.541343] cxl_core:cxl_port_perf_data_calculate:208: cxl_port endpoint8: Failed to retrieve ep perf coordinates.
[  604.544569] cxl_core:cxl_endpoint_parse_cdat:410: cxl_port endpoint8: Failed to do perf coord calculations.
[  604.575610] cxl_core:init_hdm_decoder:910: cxl_port endpoint8: decoder8.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.580007] cxl_core:add_hdm_decoder:37: cxl decoder8.0: Added to port endpoint8
[  604.583465] cxl_core:init_hdm_decoder:910: cxl_port endpoint8: decoder8.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.586936] cxl_core:add_hdm_decoder:37: cxl decoder8.1: Added to port endpoint8
[  604.590343] cxl_core:init_hdm_decoder:910: cxl_port endpoint8: decoder8.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.594750] cxl_core:add_hdm_decoder:37: cxl decoder8.2: Added to port endpoint8
[  604.598179] cxl_core:init_hdm_decoder:910: cxl_port endpoint8: decoder8.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[  604.603194] cxl_core:add_hdm_decoder:37: cxl decoder8.3: Added to port endpoint8
[  604.605929] cxl_core:cxl_bus_probe:2077: cxl_port endpoint8: probe: 0
[  604.609823] cxl_core:devm_cxl_add_port:925: cxl_mem mem9: endpoint8 added to port5
[  604.613194] cxl_core:cxl_bus_probe:2077: cxl_mem mem9: probe: 0
[  604.628241] cxl_acpi:cxl_acpi_test:6: cxl_acpi for cxl_test
[  604.630700] cxl_core:cxl_core_test:6: cxl_core for cxl_test
[  604.633551] cxl_mem:cxl_mem_test:6: cxl_mem for cxl_test
[  604.636040] cxl_pmem:cxl_pmem_test:6: cxl_pmem for cxl_test
[  604.638352] cxl_port:cxl_port_test:6: cxl_port for cxl_test
[  604.661157] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  604.664202] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.0: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  604.667495] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  604.670355] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x0400 enabled
[  604.673409] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4000 enabled
[  604.676057] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4102 enabled
[  604.678427] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4100 enabled
[  604.681249] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4103 enabled
[  604.683681] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4200 enabled
[  604.685998] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4300 enabled
[  604.688651] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4301 enabled
[  604.690894] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4302 enabled
[  604.693157] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x0200 enabled
[  604.695557] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x0201 unsupported by driver
[  604.697939] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x0202 unsupported by driver
[  604.700515] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.0: Opcode 0x4400 enabled
[  604.702882] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  604.705466] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  604.707950] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  604.710216] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.0: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  604.712899] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.0: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  604.717339] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: mem0 dport_dev: cxl_switch_dport.0 parent: cxl_switch_uport.0
[  604.720293] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: cxl_switch_dport.0 dport_dev: cxl_root_port.0 parent: cxl_host_bridge.0
[  604.722977] cxl_mem mem0: CXL port topology not found
[  604.724943] cxl_core:cxl_bus_probe:2077: cxl_mem mem0: probe: -6
[  604.728358] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.0: Reading event logs: f
[  604.730753] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  604.734124] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '3': Clearing 1
[  604.736953] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '3': Clearing 2
[  604.739415] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  604.741893] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  604.744922] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  604.747626] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 1
[  604.749822] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  604.752297] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  604.755672] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 2
[  604.757835] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 3
[  604.760071] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  604.762234] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  604.765136] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 4
[  604.767454] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 5
[  604.769470] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 6
[  604.771630] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  604.773851] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  604.776776] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 7
[  604.778879] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  604.781091] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  604.783883] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 8
[  604.786022] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 9
[  604.788381] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  604.790492] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  604.793181] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 10
[  604.795458] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 11
[  604.797434] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 12
[  604.799568] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  604.801673] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  604.804432] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 13
[  604.806669] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  604.808966] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  604.811744] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 14
[  604.814059] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '2': Clearing 15
[  604.816522] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  604.818803] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  604.821669] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  604.824481] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  604.826802] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '0': Clearing 1
[  604.828992] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '0': Clearing 2
[  604.831130] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  604.833472] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  604.836253] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.0: Event log '0': Clearing 3
[  604.838684] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  604.841001] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  604.856018] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  604.858218] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.1: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  604.861522] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  604.864089] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x0400 enabled
[  604.866102] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4000 enabled
[  604.868385] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4102 enabled
[  604.870383] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4100 enabled
[  604.872675] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4103 enabled
[  604.874616] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4200 enabled
[  604.876588] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4300 enabled
[  604.878502] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4301 enabled
[  604.880476] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4302 enabled
[  604.882320] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x0200 enabled
[  604.884443] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x0201 unsupported by driver
[  604.886457] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x0202 unsupported by driver
[  604.888505] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.1: Opcode 0x4400 enabled
[  604.890762] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  604.893008] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  604.895213] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  604.897209] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.1: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  604.899334] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.1: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  604.903852] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: mem1 dport_dev: cxl_switch_dport.1 parent: cxl_switch_uport.1
[  604.906326] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: cxl_switch_dport.1 dport_dev: cxl_root_port.1 parent: cxl_host_bridge.1
[  604.908753] cxl_mem mem1: CXL port topology not found
[  604.910384] cxl_core:cxl_bus_probe:2077: cxl_mem mem1: probe: -6
[  604.913241] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.1: Reading event logs: f
[  604.916203] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  604.919289] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '3': Clearing 1
[  604.921251] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '3': Clearing 2
[  604.923317] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  604.925516] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  604.928206] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  604.930570] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 1
[  604.932668] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  604.934802] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  604.937819] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 2
[  604.940140] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 3
[  604.942193] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  604.944690] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  604.947125] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 4
[  604.949359] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 5
[  604.951654] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 6
[  604.953675] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  604.956060] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  604.958479] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 7
[  604.960659] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  604.962829] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  604.965837] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 8
[  604.968110] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 9
[  604.970183] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  604.972735] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  604.975224] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 10
[  604.977552] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 11
[  604.979879] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 12
[  604.981875] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  604.984538] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  604.987016] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 13
[  604.989442] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  604.991897] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  604.994893] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 14
[  604.997114] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '2': Clearing 15
[  604.999277] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.001663] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.004679] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.007252] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.009560] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '0': Clearing 1
[  605.011922] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '0': Clearing 2
[  605.014001] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.016613] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.019126] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.1: Event log '0': Clearing 3
[  605.021440] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.023940] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.035931] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  605.038238] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.2: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  605.041590] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  605.044125] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x0400 enabled
[  605.046170] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4000 enabled
[  605.048560] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4102 enabled
[  605.050545] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4100 enabled
[  605.052894] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4103 enabled
[  605.054932] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4200 enabled
[  605.056963] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4300 enabled
[  605.058991] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4301 enabled
[  605.060958] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4302 enabled
[  605.062867] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x0200 enabled
[  605.064812] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x0201 unsupported by driver
[  605.066805] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x0202 unsupported by driver
[  605.068802] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.2: Opcode 0x4400 enabled
[  605.071083] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  605.073327] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  605.075550] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  605.077620] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.2: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  605.079849] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.2: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  605.084339] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: mem2 dport_dev: cxl_switch_dport.2 parent: cxl_switch_uport.2
[  605.088284] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: cxl_switch_dport.2 dport_dev: cxl_root_port.2 parent: cxl_host_bridge.0
[  605.091456] cxl_mem mem2: CXL port topology not found
[  605.093567] cxl_core:cxl_bus_probe:2077: cxl_mem mem2: probe: -6
[  605.096878] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.2: Reading event logs: f
[  605.099029] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.101823] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '3': Clearing 1
[  605.104228] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '3': Clearing 2
[  605.106303] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.108577] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.111291] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.113667] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 1
[  605.116135] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.118354] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.121533] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 2
[  605.124013] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 3
[  605.126110] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.128818] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  605.131495] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 4
[  605.133839] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 5
[  605.136079] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 6
[  605.138167] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  605.140809] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.143248] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 7
[  605.145498] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.147910] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.150964] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 8
[  605.153126] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 9
[  605.155259] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.157435] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  605.160062] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 10
[  605.162185] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 11
[  605.164506] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 12
[  605.166455] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  605.168643] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.171039] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 13
[  605.173316] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.175700] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.178730] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 14
[  605.180938] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '2': Clearing 15
[  605.183018] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.185324] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.188309] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.190764] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.194011] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '0': Clearing 1
[  605.196515] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '0': Clearing 2
[  605.198658] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.201339] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.204093] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.2: Event log '0': Clearing 3
[  605.206404] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.208761] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.223949] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  605.226224] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.3: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  605.228983] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  605.231583] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x0400 enabled
[  605.233617] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4000 enabled
[  605.235798] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4102 enabled
[  605.237840] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4100 enabled
[  605.240109] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4103 enabled
[  605.242068] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4200 enabled
[  605.244250] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4300 enabled
[  605.246084] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4301 enabled
[  605.248206] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4302 enabled
[  605.250016] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x0200 enabled
[  605.252077] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x0201 unsupported by driver
[  605.254009] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x0202 unsupported by driver
[  605.256146] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.3: Opcode 0x4400 enabled
[  605.258279] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  605.260676] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  605.262824] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  605.265036] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.3: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  605.267073] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.3: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  605.270953] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: mem3 dport_dev: cxl_switch_dport.3 parent: cxl_switch_uport.3
[  605.274520] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: cxl_switch_dport.3 dport_dev: cxl_root_port.3 parent: cxl_host_bridge.1
[  605.277750] cxl_mem mem3: CXL port topology not found
[  605.280157] cxl_core:cxl_bus_probe:2077: cxl_mem mem3: probe: -6
[  605.283460] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.3: Reading event logs: f
[  605.285495] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.288159] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '3': Clearing 1
[  605.290275] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '3': Clearing 2
[  605.292621] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.294738] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.297772] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.300491] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 1
[  605.302568] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.305081] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.307526] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 2
[  605.309683] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 3
[  605.311833] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.314053] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  605.316968] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 4
[  605.319197] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 5
[  605.321214] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 6
[  605.323345] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  605.325521] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.328399] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 7
[  605.330515] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.332849] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.335614] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 8
[  605.337799] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 9
[  605.340098] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.342286] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  605.345291] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 10
[  605.347436] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 11
[  605.349363] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 12
[  605.351428] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  605.353542] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.356154] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 13
[  605.358397] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.360693] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.363638] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 14
[  605.365858] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '2': Clearing 15
[  605.368238] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.370516] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.373615] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.376603] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.379041] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '0': Clearing 1
[  605.381579] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '0': Clearing 2
[  605.383976] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.386363] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.389032] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.3: Event log '0': Clearing 3
[  605.391367] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.393629] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.405869] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  605.408507] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.4: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  605.411395] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  605.413763] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x0400 enabled
[  605.416080] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4000 enabled
[  605.418179] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4102 enabled
[  605.420531] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4100 enabled
[  605.422599] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4103 enabled
[  605.424897] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4200 enabled
[  605.426940] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4300 enabled
[  605.428916] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4301 enabled
[  605.430810] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4302 enabled
[  605.432827] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x0200 enabled
[  605.434766] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x0201 unsupported by driver
[  605.436777] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x0202 unsupported by driver
[  605.438781] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.4: Opcode 0x4400 enabled
[  605.440982] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  605.443022] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  605.445140] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  605.447266] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.4: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  605.449407] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.4: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  605.453329] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem4: scan: iter: mem4 dport_dev: cxl_switch_dport.4 parent: cxl_switch_uport.0
[  605.456054] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem4: scan: iter: cxl_switch_dport.4 dport_dev: cxl_root_port.0 parent: cxl_host_bridge.0
[  605.458562] cxl_mem mem4: CXL port topology not found
[  605.460530] cxl_core:cxl_bus_probe:2077: cxl_mem mem4: probe: -6
[  605.463879] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.4: Reading event logs: f
[  605.466800] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.469814] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '3': Clearing 1
[  605.472235] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '3': Clearing 2
[  605.474276] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.476812] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.479178] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.481464] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 1
[  605.483713] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.485811] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.488526] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 2
[  605.490722] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 3
[  605.492741] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.494908] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  605.497931] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 4
[  605.500408] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 5
[  605.502457] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 6
[  605.504566] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  605.506770] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.509335] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 7
[  605.511676] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.513802] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.516577] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 8
[  605.518739] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 9
[  605.520859] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.523090] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  605.526077] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 10
[  605.528441] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 11
[  605.530412] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 12
[  605.532721] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  605.534858] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.537323] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 13
[  605.539744] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.541944] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.544806] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 14
[  605.547195] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '2': Clearing 15
[  605.549356] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.551855] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.554953] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.558160] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.561263] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '0': Clearing 1
[  605.563674] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '0': Clearing 2
[  605.565768] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.568342] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.570811] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.4: Event log '0': Clearing 3
[  605.573094] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.575497] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.587566] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  605.589818] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.5: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  605.592949] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  605.595481] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0400 enabled
[  605.597537] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4000 enabled
[  605.599675] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4102 enabled
[  605.601659] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4100 enabled
[  605.603742] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4103 enabled
[  605.605702] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4200 enabled
[  605.607795] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4300 enabled
[  605.609680] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4301 enabled
[  605.611695] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4302 enabled
[  605.613620] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0200 enabled
[  605.615581] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0201 unsupported by driver
[  605.617512] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x0202 unsupported by driver
[  605.619636] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.5: Opcode 0x4400 enabled
[  605.621698] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  605.624100] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  605.626186] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  605.628608] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.5: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  605.630638] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.5: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  605.634729] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem6: scan: iter: mem6 dport_dev: cxl_switch_dport.5 parent: cxl_switch_uport.1
[  605.638597] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem6: scan: iter: cxl_switch_dport.5 dport_dev: cxl_root_port.1 parent: cxl_host_bridge.1
[  605.641760] cxl_mem mem6: CXL port topology not found
[  605.644213] cxl_core:cxl_bus_probe:2077: cxl_mem mem6: probe: -6
[  605.647640] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.5: Reading event logs: f
[  605.649694] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.652498] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '3': Clearing 1
[  605.654654] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '3': Clearing 2
[  605.656732] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.658909] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.661463] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.663946] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 1
[  605.666019] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.668555] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.671627] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 2
[  605.673874] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 3
[  605.676222] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.678517] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  605.681578] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 4
[  605.683990] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 5
[  605.686037] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 6
[  605.688325] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  605.690413] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.692834] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 7
[  605.694964] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.697473] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.700074] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 8
[  605.702205] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 9
[  605.704625] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.706784] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  605.709761] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 10
[  605.712090] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 11
[  605.714080] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 12
[  605.716481] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  605.718630] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.721070] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 13
[  605.723348] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.725556] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.728227] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 14
[  605.730511] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '2': Clearing 15
[  605.732676] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.734986] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.738128] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.741304] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.743892] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '0': Clearing 1
[  605.746049] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '0': Clearing 2
[  605.748477] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.750763] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.753429] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.5: Event log '0': Clearing 3
[  605.755845] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.758391] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.771023] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  605.773336] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.6: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  605.776328] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  605.778712] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0400 enabled
[  605.780900] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4000 enabled
[  605.782899] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4102 enabled
[  605.784945] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4100 enabled
[  605.786959] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4103 enabled
[  605.789276] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4200 enabled
[  605.791302] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4300 enabled
[  605.793214] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4301 enabled
[  605.795120] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4302 enabled
[  605.797106] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0200 enabled
[  605.799079] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0201 unsupported by driver
[  605.801288] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x0202 unsupported by driver
[  605.803389] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.6: Opcode 0x4400 enabled
[  605.805503] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  605.807983] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  605.810096] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  605.812530] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.6: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  605.814567] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.6: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  605.818745] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem10: scan: iter: mem10 dport_dev: cxl_switch_dport.6 parent: cxl_switch_uport.2
[  605.821306] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem10: scan: iter: cxl_switch_dport.6 dport_dev: cxl_root_port.2 parent: cxl_host_bridge.0
[  605.823986] cxl_mem mem10: CXL port topology not found
[  605.825657] cxl_core:cxl_bus_probe:2077: cxl_mem mem10: probe: -6
[  605.829070] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.6: Reading event logs: f
[  605.831379] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.833748] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '3': Clearing 1
[  605.836102] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '3': Clearing 2
[  605.838129] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.840751] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.843341] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.845620] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 1
[  605.847847] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.849938] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.852748] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 2
[  605.854871] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 3
[  605.856920] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.858959] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  605.861912] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 4
[  605.864286] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 5
[  605.867745] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 6
[  605.869763] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  605.872214] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.874595] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 7
[  605.876860] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.879181] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.881828] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 8
[  605.884396] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 9
[  605.886346] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.888570] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  605.891689] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 10
[  605.893867] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 11
[  605.896114] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 12
[  605.898184] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  605.900631] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.903035] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 13
[  605.905297] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.907677] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.910690] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 14
[  605.912949] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '2': Clearing 15
[  605.915084] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.917447] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.920350] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.922836] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  605.926061] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '0': Clearing 1
[  605.928689] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '0': Clearing 2
[  605.930815] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  605.933593] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  605.936335] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.6: Event log '0': Clearing 3
[  605.938626] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  605.940909] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  605.955474] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  605.957681] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.7: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  605.960788] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  605.963227] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0400 enabled
[  605.965265] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4000 enabled
[  605.967337] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4102 enabled
[  605.969294] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4100 enabled
[  605.971274] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4103 enabled
[  605.973198] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4200 enabled
[  605.975127] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4300 enabled
[  605.977131] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4301 enabled
[  605.979015] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4302 enabled
[  605.980900] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0200 enabled
[  605.982799] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0201 unsupported by driver
[  605.984900] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x0202 unsupported by driver
[  605.986905] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.7: Opcode 0x4400 enabled
[  605.988976] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  605.991275] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  605.993578] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  605.995763] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.7: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  605.998008] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.7: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  606.002532] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem11: scan: iter: mem11 dport_dev: cxl_switch_dport.7 parent: cxl_switch_uport.3
[  606.006387] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem11: scan: iter: cxl_switch_dport.7 dport_dev: cxl_root_port.3 parent: cxl_host_bridge.1
[  606.009532] cxl_mem mem11: CXL port topology not found
[  606.011769] cxl_core:cxl_bus_probe:2077: cxl_mem mem11: probe: -6
[  606.016130] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.7: Reading event logs: f
[  606.018985] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.022161] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '3': Clearing 1
[  606.024647] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '3': Clearing 2
[  606.026719] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.029238] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.031837] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.034111] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 1
[  606.036461] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.038608] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.040955] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 2
[  606.043195] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 3
[  606.045312] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.047624] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  606.050591] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 4
[  606.052771] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 5
[  606.054791] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 6
[  606.056979] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  606.059482] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.062449] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 7
[  606.064549] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.066758] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.069629] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 8
[  606.072030] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 9
[  606.074161] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.076871] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  606.079611] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 10
[  606.081719] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 11
[  606.083980] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 12
[  606.085988] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  606.088536] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.090884] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 13
[  606.093090] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.095412] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.098433] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 14
[  606.100648] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '2': Clearing 15
[  606.102746] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.105107] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.107987] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.110363] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.113546] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '0': Clearing 1
[  606.115945] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '0': Clearing 2
[  606.118160] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.120704] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.123582] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.7: Event log '0': Clearing 3
[  606.126011] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.128672] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.145166] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  606.148415] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.8: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  606.150997] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  606.153472] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0400 enabled
[  606.155618] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4000 enabled
[  606.157593] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4102 enabled
[  606.159693] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4100 enabled
[  606.161602] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4103 enabled
[  606.163668] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4200 enabled
[  606.165573] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4300 enabled
[  606.167640] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4301 enabled
[  606.169514] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4302 enabled
[  606.171552] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0200 enabled
[  606.173392] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0201 unsupported by driver
[  606.175400] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x0202 unsupported by driver
[  606.177267] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.8: Opcode 0x4400 enabled
[  606.179440] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  606.181551] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  606.183781] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  606.185870] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.8: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  606.188136] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.8: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  606.192312] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: mem12 dport_dev: cxl_switch_dport.8 parent: cxl_switch_uport.4
[  606.196223] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: cxl_switch_dport.8 dport_dev: cxl_root_port.4 parent: cxl_host_bridge.2
[  606.199341] cxl_mem mem12: CXL port topology not found
[  606.201398] cxl_core:cxl_bus_probe:2077: cxl_mem mem12: probe: -6
[  606.204727] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.8: Reading event logs: f
[  606.206750] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.209464] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '3': Clearing 1
[  606.211871] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '3': Clearing 2
[  606.213852] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.216323] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.219404] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.221616] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 1
[  606.223723] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.225860] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.228683] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 2
[  606.230814] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 3
[  606.232805] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.235035] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  606.238106] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 4
[  606.240658] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 5
[  606.242678] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 6
[  606.244829] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  606.247048] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.249685] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 7
[  606.252089] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.254366] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.256806] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 8
[  606.258949] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 9
[  606.261036] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.263283] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  606.266333] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 10
[  606.268814] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 11
[  606.270813] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 12
[  606.272889] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  606.275128] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.277553] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 13
[  606.279924] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.282176] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.285123] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 14
[  606.287430] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '2': Clearing 15
[  606.289492] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.291977] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.295038] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.298160] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.301438] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '0': Clearing 1
[  606.303866] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '0': Clearing 2
[  606.305969] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.308603] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.311077] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.8: Event log '0': Clearing 3
[  606.313398] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.315987] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.328430] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  606.330655] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_mem.9: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  606.333736] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  606.336472] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0400 enabled
[  606.338605] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4000 enabled
[  606.340650] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4102 enabled
[  606.342703] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4100 enabled
[  606.344668] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4103 enabled
[  606.346657] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4200 enabled
[  606.348662] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4300 enabled
[  606.350578] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4301 enabled
[  606.352489] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4302 enabled
[  606.354334] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0200 enabled
[  606.356418] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0201 unsupported by driver
[  606.358324] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x0202 unsupported by driver
[  606.360553] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_mem.9: Opcode 0x4400 enabled
[  606.362715] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  606.364932] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  606.367045] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4100 sz_in: 0 sz_out: 32 rc: 0
[  606.369215] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.9: DPA(ram): [mem 0x00000000-0x3fffffff flags 0x200]
[  606.371427] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_mem.9: DPA(pmem): [mem 0x40000000-0x7fffffff flags 0x200]
[  606.375457] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem13: scan: iter: mem13 dport_dev: cxl_switch_dport.9 parent: cxl_switch_uport.4
[  606.377876] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem13: scan: iter: cxl_switch_dport.9 dport_dev: cxl_root_port.4 parent: cxl_host_bridge.2
[  606.380609] cxl_mem mem13: CXL port topology not found
[  606.382239] cxl_core:cxl_bus_probe:2077: cxl_mem mem13: probe: -6
[  606.385791] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_mem.9: Reading event logs: f
[  606.388483] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.390787] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '3': Clearing 1
[  606.392888] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '3': Clearing 2
[  606.394973] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.397577] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.400188] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.402443] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 1
[  606.404519] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.406724] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.409797] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 2
[  606.412110] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 3
[  606.414096] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.416710] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  606.419081] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 4
[  606.421272] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 5
[  606.423591] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 6
[  606.425786] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  606.428142] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.430619] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 7
[  606.432871] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.435061] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.438026] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 8
[  606.440377] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 9
[  606.442303] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.444805] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  606.447231] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 10
[  606.449321] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 11
[  606.451317] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 12
[  606.453253] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  606.455421] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.457796] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 13
[  606.460647] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.462792] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.465858] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 14
[  606.468272] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '2': Clearing 15
[  606.470426] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.472737] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.475289] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.477827] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.480914] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '0': Clearing 1
[  606.483264] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '0': Clearing 2
[  606.485457] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.487934] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.491047] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_mem.9: Event log '0': Clearing 3
[  606.493334] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.495833] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.510424] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x400 sz_in: 0 sz_out: 28 rc: 0
[  606.513506] cxl_core:cxl_enumerate_cmds:818: cxl_mock_mem cxl_rcd.10: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 52
[  606.516617] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x401 sz_in: 24 sz_out: 52 rc: 0
[  606.518964] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0400 enabled
[  606.521072] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4000 enabled
[  606.523187] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4102 enabled
[  606.525197] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4100 enabled
[  606.527136] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4103 enabled
[  606.529097] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4200 enabled
[  606.531041] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4300 enabled
[  606.532927] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4301 enabled
[  606.534776] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4302 enabled
[  606.536735] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0200 enabled
[  606.538563] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0201 unsupported by driver
[  606.540611] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x0202 unsupported by driver
[  606.542504] cxl_core:cxl_walk_cel:748: cxl_mock_mem cxl_rcd.10: Opcode 0x4400 enabled
[  606.545015] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x301 sz_in: 8 sz_out: 0 rc: 0
[  606.547237] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x4000 sz_in: 0 sz_out: 67 rc: 0
[  606.549333] cxl_core:add_dpa_res:1255: cxl_mock_mem cxl_rcd.10: DPA(ram): [mem 0x00000000-0x7fffffff flags 0x200]
[  606.551475] cxl_core:add_dpa_res:1245: cxl_mock_mem cxl_rcd.10: DPA(pmem): no capacity
[  606.555841] cxl_mem mem14: CXL port topology not found
[  606.557544] cxl_core:cxl_bus_probe:2077: cxl_mem mem14: probe: -6
[  606.560631] cxl_core:cxl_mem_get_event_records:1046: cxl_mock_mem cxl_rcd.10: Reading event logs: f
[  606.562718] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.565851] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '3': Clearing 1
[  606.568113] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '3': Clearing 2
[  606.570167] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.572678] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.575216] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.577427] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 1
[  606.579582] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.581808] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.584739] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 2
[  606.586900] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 3
[  606.588955] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.591085] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  606.594072] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 4
[  606.596380] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 5
[  606.598324] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 6
[  606.600626] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  606.602764] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.605241] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 7
[  606.607727] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.610062] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.613084] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 8
[  606.615569] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 9
[  606.617559] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.619867] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 416 rc: 0
[  606.622788] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 10
[  606.625007] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 11
[  606.627043] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 12
[  606.629489] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 12 sz_out: 0 rc: 0
[  606.631731] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.634091] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 13
[  606.636435] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.638544] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.640931] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 14
[  606.643095] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '2': Clearing 15
[  606.645208] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.647655] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.650662] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.653880] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 288 rc: 0
[  606.657001] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '0': Clearing 1
[  606.659310] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '0': Clearing 2
[  606.661390] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 10 sz_out: 0 rc: 0
[  606.663804] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 160 rc: 0
[  606.667092] cxl_core:cxl_clear_event_record:953: cxl_mock_mem cxl_rcd.10: Event log '0': Clearing 3
[  606.669282] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x101 sz_in: 8 sz_out: 0 rc: 0
[  606.671803] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_rcd.10: opcode: 0x100 sz_in: 1 sz_out: 4096 rc: 0
[  606.675397] cxl_core:devm_cxl_add_port:925: cxl_acpi cxl_acpi.0: root9 added (root port)
[  606.677563] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.0: UID found: 0
[  606.679657] platform cxl_host_bridge.0: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  606.682978] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.0: dport added to root9
[  606.686002] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.0: Failed to get generic port perf coordinates.
[  606.688785] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.1: UID found: 1
[  606.690804] platform cxl_host_bridge.1: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  606.694167] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.1: dport added to root9
[  606.697234] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.1: Failed to get generic port perf coordinates.
[  606.700093] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.2: UID found: 2
[  606.702180] platform cxl_host_bridge.2: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  606.705604] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.2: dport added to root9
[  606.708234] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.2: Failed to get generic port perf coordinates.
[  606.710740] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.3: UID found: 3
[  606.712976] platform cxl_host_bridge.3: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  606.715678] cxl_acpi:add_host_bridge_dport:594: platform cxl_host_bridge.3: RCRB found for UID 3: 0x000ffff000600000
[  606.718908] cxl_core:devm_cxl_add_dport:1216: platform cxl_host_bridge.3: dport added to root9
[  606.721582] cxl_acpi:add_host_bridge_dport:608: platform cxl_host_bridge.3: Failed to get generic port perf coordinates.
[  606.726077] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff010000000 - 0xffff04fffffff]
[  606.729904] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff050000000 - 0xffff0cfffffff]
[  606.734310] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff0d0000000 - 0xffff10fffffff]
[  606.737932] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff110000000 - 0xffff18fffffff]
[  606.742265] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff190000000 - 0xffff1cfffffff]
[  606.745781] cxl_acpi:cxl_parse_cfmws:442: cxl_acpi cxl_acpi.0: decode range: node: -1 range [0xffff1d0000000 - 0xffff1dfffffff]
[  606.749233] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.0: UID found: 0
[  606.751746] platform cxl_host_bridge.0: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  606.754367] cxl_acpi:add_host_bridge_uport:658: platform cxl_host_bridge.0: CHBCR found for UID 0: 0x000ffff000000000
[  606.757193] cxl_core:cxl_port_alloc:730: platform cxl_host_bridge.0: host-bridge: cxl_host_bridge.0
[  606.761127] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.0: dport added to port10
[  606.763761] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port10: cxl_host_bridge.0: mismatch parent cxl_host_bridge.1
[  606.767470] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.2: dport added to port10
[  606.770430] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port10: cxl_host_bridge.0: mismatch parent cxl_host_bridge.1
[  606.775414] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.0: Added to port port10
[  606.779474] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.1: Added to port port10
[  606.783435] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.2: Added to port port10
[  606.787889] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.3: Added to port port10
[  606.791887] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.4: Added to port port10
[  606.794857] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.5: Added to port port10
[  606.798715] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.6: Added to port port10
[  606.802557] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder10.7: Added to port port10
[  606.804875] cxl_core:cxl_bus_probe:2077: cxl_port port10: probe: 0
[  606.809182] cxl_core:devm_cxl_add_port:925: platform cxl_host_bridge.0: port10 added to root9
[  606.811840] platform cxl_host_bridge.0: host supports CXL
[  606.813896] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.1: UID found: 1
[  606.816575] platform cxl_host_bridge.1: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  606.819215] cxl_acpi:add_host_bridge_uport:658: platform cxl_host_bridge.1: CHBCR found for UID 1: 0x000ffff000200000
[  606.822073] cxl_core:cxl_port_alloc:730: platform cxl_host_bridge.1: host-bridge: cxl_host_bridge.1
[  606.826375] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port11: cxl_host_bridge.1: mismatch parent cxl_host_bridge.0
[  606.829344] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.1: dport added to port11
[  606.832036] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port11: cxl_host_bridge.1: mismatch parent cxl_host_bridge.0
[  606.835815] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.3: dport added to port11
[  606.839072] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.0: Added to port port11
[  606.842882] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.1: Added to port port11
[  606.845991] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.2: Added to port port11
[  606.850467] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.3: Added to port port11
[  606.853525] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.4: Added to port port11
[  606.857152] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.5: Added to port port11
[  606.861152] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.6: Added to port port11
[  606.864667] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder11.7: Added to port port11
[  606.866888] cxl_core:cxl_bus_probe:2077: cxl_port port11: probe: 0
[  606.869961] cxl_core:devm_cxl_add_port:925: platform cxl_host_bridge.1: port11 added to root9
[  606.872529] platform cxl_host_bridge.1: host supports CXL
[  606.874372] cxl_acpi:cxl_get_chbs:521: platform cxl_host_bridge.2: UID found: 2
[  606.876714] platform cxl_host_bridge.2: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
[  606.879015] cxl_acpi:add_host_bridge_uport:658: platform cxl_host_bridge.2: CHBCR found for UID 2: 0x000ffff000400000
[  606.881716] cxl_core:cxl_port_alloc:730: platform cxl_host_bridge.2: host-bridge: cxl_host_bridge.2
[  606.884955] cxl_core:devm_cxl_add_dport:1216: platform cxl_root_port.4: dport added to port12
[  606.888095] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.0: Added to port port12
[  606.891019] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.1: Added to port port12
[  606.894659] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.2: Added to port port12
[  606.898244] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.3: Added to port port12
[  606.902634] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.4: Added to port port12
[  606.905488] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.5: Added to port port12
[  606.908847] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.6: Added to port port12
[  606.911896] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder12.7: Added to port port12
[  606.913987] cxl_core:cxl_bus_probe:2077: cxl_port port12: probe: 0
[  606.916743] cxl_core:devm_cxl_add_port:925: platform cxl_host_bridge.2: port12 added to root9
[  606.918789] platform cxl_host_bridge.2: host supports CXL
[  606.920526] platform cxl_host_bridge.3: host supports CXL (restricted)
[  606.926952] cxl_core:cxl_bus_probe:2077: cxl_nvdimm_bridge nvdimm-bridge1: probe: 0
[  606.929699] cxl_acpi:add_root_nvdimm_bridge:693: cxl_acpi cxl_acpi.0: root9: add: nvdimm-bridge1
[  606.932847] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: mem0 dport_dev: cxl_switch_dport.0 parent: cxl_switch_uport.0
[  606.938933] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.0: host-bridge: cxl_host_bridge.0
[  606.948288] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.0: dport added to port13
[  606.950551] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.1
[  606.952934] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.2
[  606.955558] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.3
[  606.958643] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.4: dport added to port13
[  606.960999] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.1
[  606.963521] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.2
[  606.966010] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port13: cxl_switch_uport.0: mismatch parent cxl_switch_uport.3
[  606.970101] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.0: Added to port port13
[  606.973556] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.1: Added to port port13
[  606.978605] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.2: Added to port port13
[  606.981797] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.3: Added to port port13
[  606.985504] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.4: Added to port port13
[  606.989012] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.5: Added to port port13
[  606.992045] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.6: Added to port port13
[  606.995518] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder13.7: Added to port port13
[  606.997387] cxl_core:cxl_bus_probe:2077: cxl_port port13: probe: 0
[  606.999684] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.0: port13 added to port10
[  607.001874] cxl_core:add_port_attach_ep:1589: cxl_mem mem0: add to new port port13:cxl_switch_uport.0
[  607.005070] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: mem0 dport_dev: cxl_switch_dport.0 parent: cxl_switch_uport.0
[  607.007638] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem0: found already registered port port13:cxl_switch_uport.0
[  607.010528] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem0: scan: iter: cxl_switch_dport.0 dport_dev: cxl_root_port.0 parent: cxl_host_bridge.0
[  607.013048] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem0: found already registered port port10:cxl_host_bridge.0
[  607.016144] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.018952] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.023889] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.026266] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  607.029794] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem0: probe: 0
[  607.032780] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem0: register pmem0
[  607.035443] cxl_core:cxl_port_alloc:730: cxl_mem mem0: host-bridge: cxl_host_bridge.0
[  607.039201] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.0: Added to port endpoint14
[  607.041939] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.1: Added to port endpoint14
[  607.045805] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.2: Added to port endpoint14
[  607.049498] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.3: Added to port endpoint14
[  607.052437] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.4: Added to port endpoint14
[  607.055002] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.5: Added to port endpoint14
[  607.058413] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.6: Added to port endpoint14
[  607.061567] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder14.7: Added to port endpoint14
[  607.064460] cxl_core:cxl_region_probe:3402: cxl_region region3: config state: 0
[  607.066359] cxl_core:cxl_bus_probe:2077: cxl_region region3: probe: -6
[  607.069349] cxl_core:devm_cxl_add_region:2499: cxl_acpi cxl_acpi.0: decoder9.0: created region3
[  607.071869] cxl_core:construct_region:3296: cxl_mock_mem cxl_mem.0: mem0:decoder14.0: construct_region region3 res: [mem 0xffff010000000-0xffff02fffffff flags 0x200] iw: 2 ig: 4096
[  607.076838] cxl_core:cxl_bus_probe:2077: cxl_port endpoint14: probe: 0
[  607.079638] cxl_core:devm_cxl_add_port:925: cxl_mem mem0: endpoint14 added to port13
[  607.082628] cxl_core:cxl_bus_probe:2077: cxl_mem mem0: probe: 0
[  607.089807] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: mem1 dport_dev: cxl_switch_dport.1 parent: cxl_switch_uport.1
[  607.095091] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.1: host-bridge: cxl_host_bridge.1
[  607.097984] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.0
[  607.100943] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.1: dport added to port15
[  607.103043] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.2
[  607.105475] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.3
[  607.108070] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.0
[  607.110719] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.5: dport added to port15
[  607.112889] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.2
[  607.115403] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port15: cxl_switch_uport.1: mismatch parent cxl_switch_uport.3
[  607.119269] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.0: Added to port port15
[  607.122878] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.1: Added to port port15
[  607.125838] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.2: Added to port port15
[  607.130025] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.3: Added to port port15
[  607.134007] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.4: Added to port port15
[  607.137833] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.5: Added to port port15
[  607.141256] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.6: Added to port port15
[  607.144909] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder15.7: Added to port port15
[  607.146925] cxl_core:cxl_bus_probe:2077: cxl_port port15: probe: 0
[  607.149843] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.1: port15 added to port11
[  607.152231] cxl_core:add_port_attach_ep:1589: cxl_mem mem1: add to new port port15:cxl_switch_uport.1
[  607.154619] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: mem1 dport_dev: cxl_switch_dport.1 parent: cxl_switch_uport.1
[  607.158344] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem1: found already registered port port15:cxl_switch_uport.1
[  607.161716] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem1: scan: iter: cxl_switch_dport.1 dport_dev: cxl_root_port.1 parent: cxl_host_bridge.1
[  607.164714] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem1: found already registered port port11:cxl_host_bridge.1
[  607.167817] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.170125] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.173907] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.176602] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  607.179101] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem1: probe: 0
[  607.181997] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem1: register pmem1
[  607.184958] cxl_core:cxl_port_alloc:730: cxl_mem mem1: host-bridge: cxl_host_bridge.1
[  607.188841] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.0: Added to port endpoint16
[  607.191874] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.1: Added to port endpoint16
[  607.194621] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.2: Added to port endpoint16
[  607.198046] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.3: Added to port endpoint16
[  607.201920] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.4: Added to port endpoint16
[  607.205247] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.5: Added to port endpoint16
[  607.208344] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.6: Added to port endpoint16
[  607.211184] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder16.7: Added to port endpoint16
[  607.213273] cxl_core:cxl_bus_probe:2077: cxl_port endpoint16: probe: 0
[  607.215849] cxl_core:devm_cxl_add_port:925: cxl_mem mem1: endpoint16 added to port15
[  607.217912] cxl_core:cxl_bus_probe:2077: cxl_mem mem1: probe: 0
[  607.221101] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: mem2 dport_dev: cxl_switch_dport.2 parent: cxl_switch_uport.2
[  607.224840] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.2: host-bridge: cxl_host_bridge.0
[  607.231612] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.0
[  607.234089] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.1
[  607.237342] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.2: dport added to port17
[  607.239632] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.3
[  607.241997] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.0
[  607.244614] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.1
[  607.247624] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.6: dport added to port17
[  607.249798] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port17: cxl_switch_uport.2: mismatch parent cxl_switch_uport.3
[  607.253415] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.0: Added to port port17
[  607.256578] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.1: Added to port port17
[  607.260307] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.2: Added to port port17
[  607.263803] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.3: Added to port port17
[  607.266375] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.4: Added to port port17
[  607.270089] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.5: Added to port port17
[  607.273291] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.6: Added to port port17
[  607.276095] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder17.7: Added to port port17
[  607.278023] cxl_core:cxl_bus_probe:2077: cxl_port port17: probe: 0
[  607.280501] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.2: port17 added to port10
[  607.282625] cxl_core:add_port_attach_ep:1589: cxl_mem mem2: add to new port port17:cxl_switch_uport.2
[  607.285554] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: mem2 dport_dev: cxl_switch_dport.2 parent: cxl_switch_uport.2
[  607.288288] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem2: found already registered port port17:cxl_switch_uport.2
[  607.291031] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem2: scan: iter: cxl_switch_dport.2 dport_dev: cxl_root_port.2 parent: cxl_host_bridge.0
[  607.293816] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem2: found already registered port port10:cxl_host_bridge.0
[  607.297710] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.300265] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.304544] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.306892] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  607.310233] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem2: probe: 0
[  607.312720] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem2: register pmem2
[  607.314595] cxl_core:cxl_port_alloc:730: cxl_mem mem2: host-bridge: cxl_host_bridge.0
[  607.317562] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.0: Added to port endpoint18
[  607.321073] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.1: Added to port endpoint18
[  607.324140] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.2: Added to port endpoint18
[  607.326838] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.3: Added to port endpoint18
[  607.330414] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.4: Added to port endpoint18
[  607.333912] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.5: Added to port endpoint18
[  607.336893] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.6: Added to port endpoint18
[  607.339737] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder18.7: Added to port endpoint18
[  607.341689] cxl_core:cxl_bus_probe:2077: cxl_port endpoint18: probe: 0
[  607.344031] cxl_core:devm_cxl_add_port:925: cxl_mem mem2: endpoint18 added to port17
[  607.345956] cxl_core:cxl_bus_probe:2077: cxl_mem mem2: probe: 0
[  607.349009] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: mem3 dport_dev: cxl_switch_dport.3 parent: cxl_switch_uport.3
[  607.352495] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.3: host-bridge: cxl_host_bridge.1
[  607.356368] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.0
[  607.360164] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.1
[  607.363631] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.2
[  607.367047] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.3: dport added to port19
[  607.369165] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.0
[  607.371537] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.1
[  607.373696] cxl_test:mock_cxl_port_enumerate_dports:969: cxl_port port19: cxl_switch_uport.3: mismatch parent cxl_switch_uport.2
[  607.376531] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.7: dport added to port19
[  607.379690] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.0: Added to port port19
[  607.383626] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.1: Added to port port19
[  607.387002] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.2: Added to port port19
[  607.390892] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.3: Added to port port19
[  607.393539] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.4: Added to port port19
[  607.396964] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.5: Added to port port19
[  607.400021] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.6: Added to port port19
[  607.402533] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder19.7: Added to port port19
[  607.404500] cxl_core:cxl_bus_probe:2077: cxl_port port19: probe: 0
[  607.407108] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.3: port19 added to port11
[  607.409180] cxl_core:add_port_attach_ep:1589: cxl_mem mem3: add to new port port19:cxl_switch_uport.3
[  607.411501] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: mem3 dport_dev: cxl_switch_dport.3 parent: cxl_switch_uport.3
[  607.414117] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem3: found already registered port port19:cxl_switch_uport.3
[  607.417533] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem3: scan: iter: cxl_switch_dport.3 dport_dev: cxl_root_port.3 parent: cxl_host_bridge.1
[  607.420436] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem3: found already registered port port11:cxl_host_bridge.1
[  607.424023] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.426773] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.430414] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.432701] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  607.434993] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem3: probe: 0
[  607.437734] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem3: register pmem3
[  607.440181] cxl_core:cxl_port_alloc:730: cxl_mem mem3: host-bridge: cxl_host_bridge.1
[  607.443658] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.0: Added to port endpoint20
[  607.446379] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.1: Added to port endpoint20
[  607.450136] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.2: Added to port endpoint20
[  607.453830] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.3: Added to port endpoint20
[  607.457462] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.4: Added to port endpoint20
[  607.460376] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.5: Added to port endpoint20
[  607.463728] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.6: Added to port endpoint20
[  607.466255] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder20.7: Added to port endpoint20
[  607.468430] cxl_core:cxl_bus_probe:2077: cxl_port endpoint20: probe: 0
[  607.471056] cxl_core:devm_cxl_add_port:925: cxl_mem mem3: endpoint20 added to port19
[  607.473550] cxl_core:cxl_bus_probe:2077: cxl_mem mem3: probe: 0
[  607.475873] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem4: scan: iter: mem4 dport_dev: cxl_switch_dport.4 parent: cxl_switch_uport.0
[  607.479208] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem4: found already registered port port13:cxl_switch_uport.0
[  607.483432] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem4: scan: iter: cxl_switch_dport.4 dport_dev: cxl_root_port.0 parent: cxl_host_bridge.0
[  607.486067] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem4: found already registered port port10:cxl_host_bridge.0
[  607.490072] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.492690] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.496149] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.498332] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  607.501504] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem4: probe: 0
[  607.504437] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem4: register pmem4
[  607.506996] cxl_core:cxl_port_alloc:730: cxl_mem mem4: host-bridge: cxl_host_bridge.0
[  607.510992] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.0: Added to port endpoint21
[  607.513911] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.1: Added to port endpoint21
[  607.517996] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.2: Added to port endpoint21
[  607.521898] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.3: Added to port endpoint21
[  607.525108] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.4: Added to port endpoint21
[  607.527768] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.5: Added to port endpoint21
[  607.530212] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.6: Added to port endpoint21
[  607.533844] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder21.7: Added to port endpoint21
[  607.536229] cxl_core:cxl_calc_interleave_pos:1833: cxl_mem mem0: decoder:decoder14.0 parent:cxl_mem.0 port:endpoint14 range:0xffff010000000-0xffff02fffffff pos:0
[  607.540315] cxl_core:cxl_calc_interleave_pos:1833: cxl_mem mem4: decoder:decoder21.0 parent:cxl_mem.4 port:endpoint21 range:0xffff010000000-0xffff02fffffff pos:1
[  607.544433] cxl_core:cxl_region_sort_targets:1862: cxl region3: region sort successful
[  607.546814] cxl_core:cxl_port_attach_region:1134: cxl region3: mem0:endpoint14 decoder14.0 add: mem0:decoder14.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[  607.549779] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_switch_uport.0:port13 decoder13.0 add: mem0:decoder14.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[  607.555442] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_host_bridge.0:port10 decoder10.0 add: mem0:decoder14.0 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
[  607.560491] cxl_core:cxl_port_attach_region:1134: cxl region3: mem4:endpoint21 decoder21.0 add: mem4:decoder21.0 @ 1 next: none nr_eps: 1 nr_targets: 1
[  607.564607] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_switch_uport.0:port13 decoder13.0 add: mem4:decoder21.0 @ 1 next: mem4 nr_eps: 2 nr_targets: 2
[  607.569742] cxl_core:cxl_port_attach_region:1134: cxl region3: cxl_host_bridge.0:port10 decoder10.0 add: mem4:decoder21.0 @ 1 next: cxl_switch_uport.0 nr_eps: 2 nr_targets: 1
[  607.574482] cxl_core:cxl_port_setup_targets:1444: cxl region3: cxl_host_bridge.0:port10 iw: 1 ig: 4096
[  607.577474] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_host_bridge.0:port10 target[0] = cxl_root_port.0 for mem0:decoder14.0 @ 0
[  607.580623] cxl_core:cxl_port_setup_targets:1444: cxl region3: cxl_switch_uport.0:port13 iw: 2 ig: 4096
[  607.583028] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_switch_uport.0:port13 target[0] = cxl_switch_dport.0 for mem0:decoder14.0 @ 0
[  607.585857] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_host_bridge.0:port10 target[0] = cxl_root_port.0 for mem4:decoder21.0 @ 1
[  607.589067] cxl_core:cxl_port_setup_targets:1468: cxl region3: cxl_switch_uport.0:port13 target[1] = cxl_switch_dport.4 for mem4:decoder21.0 @ 1
[  607.635464] cxl_core:cxl_bus_probe:2077: cxl_dax_region dax_region3: probe: 0
[  607.637992] cxl_core:devm_cxl_add_dax_region:3185: cxl_region region3: region3: register dax_region3
[  607.641754] cxl_core:cxl_bus_probe:2077: cxl_region region3: probe: 0
[  607.644870] cxl_core:cxl_bus_probe:2077: cxl_port endpoint21: probe: 0
[  607.647731] cxl_core:devm_cxl_add_port:925: cxl_mem mem4: endpoint21 added to port13
[  607.650233] cxl_core:cxl_bus_probe:2077: cxl_mem mem4: probe: 0
[  607.653555] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem6: scan: iter: mem6 dport_dev: cxl_switch_dport.5 parent: cxl_switch_uport.1
[  607.657026] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem6: found already registered port port15:cxl_switch_uport.1
[  607.660731] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem6: scan: iter: cxl_switch_dport.5 dport_dev: cxl_root_port.1 parent: cxl_host_bridge.1
[  607.664250] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem6: found already registered port port11:cxl_host_bridge.1
[  607.668006] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.670803] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.674802] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.677681] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  607.682003] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem6: probe: 0
[  607.685805] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem6: register pmem6
[  607.689452] cxl_core:cxl_port_alloc:730: cxl_mem mem6: host-bridge: cxl_host_bridge.1
[  607.694964] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.0: Added to port endpoint22
[  607.698459] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.1: Added to port endpoint22
[  607.701739] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.2: Added to port endpoint22
[  607.706254] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.3: Added to port endpoint22
[  607.710727] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.4: Added to port endpoint22
[  607.714800] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.5: Added to port endpoint22
[  607.718721] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.6: Added to port endpoint22
[  607.721935] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder22.7: Added to port endpoint22
[  607.724950] cxl_core:cxl_bus_probe:2077: cxl_port endpoint22: probe: 0
[  607.727659] cxl_core:devm_cxl_add_port:925: cxl_mem mem6: endpoint22 added to port15
[  607.730267] cxl_core:cxl_bus_probe:2077: cxl_mem mem6: probe: 0
[  607.733509] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem10: scan: iter: mem10 dport_dev: cxl_switch_dport.6 parent: cxl_switch_uport.2
[  607.737201] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem10: found already registered port port17:cxl_switch_uport.2
[  607.740992] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem10: scan: iter: cxl_switch_dport.6 dport_dev: cxl_root_port.2 parent: cxl_host_bridge.0
[  607.744218] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem10: found already registered port port10:cxl_host_bridge.0
[  607.747989] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.750617] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.755508] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.758122] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  607.762165] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem10: probe: 0
[  607.765067] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem10: register pmem10
[  607.767639] cxl_core:cxl_port_alloc:730: cxl_mem mem10: host-bridge: cxl_host_bridge.0
[  607.770945] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.0: Added to port endpoint23
[  607.774720] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.1: Added to port endpoint23
[  607.778463] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.2: Added to port endpoint23
[  607.782013] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.3: Added to port endpoint23
[  607.785516] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.4: Added to port endpoint23
[  607.789865] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.5: Added to port endpoint23
[  607.795248] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.6: Added to port endpoint23
[  607.798774] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder23.7: Added to port endpoint23
[  607.800866] cxl_core:cxl_bus_probe:2077: cxl_port endpoint23: probe: 0
[  607.803006] cxl_core:devm_cxl_add_port:925: cxl_mem mem10: endpoint23 added to port17
[  607.805250] cxl_core:cxl_bus_probe:2077: cxl_mem mem10: probe: 0
[  607.808416] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem11: scan: iter: mem11 dport_dev: cxl_switch_dport.7 parent: cxl_switch_uport.3
[  607.811563] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem11: found already registered port port19:cxl_switch_uport.3
[  607.815509] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem11: scan: iter: cxl_switch_dport.7 dport_dev: cxl_root_port.3 parent: cxl_host_bridge.1
[  607.818270] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem11: found already registered port port11:cxl_host_bridge.1
[  607.822142] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.825409] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.829529] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.832083] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  607.834417] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem11: probe: 0
[  607.837560] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem11: register pmem11
[  607.839798] cxl_core:cxl_port_alloc:730: cxl_mem mem11: host-bridge: cxl_host_bridge.1
[  607.844453] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.0: Added to port endpoint24
[  607.848182] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.1: Added to port endpoint24
[  607.850909] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.2: Added to port endpoint24
[  607.854281] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.3: Added to port endpoint24
[  607.857762] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.4: Added to port endpoint24
[  607.861042] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.5: Added to port endpoint24
[  607.864171] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.6: Added to port endpoint24
[  607.866739] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder24.7: Added to port endpoint24
[  607.868585] cxl_core:cxl_bus_probe:2077: cxl_port endpoint24: probe: 0
[  607.871319] cxl_core:devm_cxl_add_port:925: cxl_mem mem11: endpoint24 added to port19
[  607.873913] cxl_core:cxl_bus_probe:2077: cxl_mem mem11: probe: 0
[  607.876331] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: mem12 dport_dev: cxl_switch_dport.8 parent: cxl_switch_uport.4
[  607.880354] cxl_core:cxl_port_alloc:730: platform cxl_switch_uport.4: host-bridge: cxl_host_bridge.2
[  607.884476] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.8: dport added to port25
[  607.886700] cxl_core:devm_cxl_add_dport:1216: platform cxl_switch_dport.9: dport added to port25
[  607.890306] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.0: Added to port port25
[  607.894011] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.1: Added to port port25
[  607.897525] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.2: Added to port port25
[  607.900245] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.3: Added to port port25
[  607.903048] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.4: Added to port port25
[  607.906467] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.5: Added to port port25
[  607.909980] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.6: Added to port port25
[  607.912930] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder25.7: Added to port port25
[  607.914720] cxl_core:cxl_bus_probe:2077: cxl_port port25: probe: 0
[  607.917487] cxl_core:devm_cxl_add_port:925: platform cxl_switch_uport.4: port25 added to port12
[  607.919678] cxl_core:add_port_attach_ep:1589: cxl_mem mem12: add to new port port25:cxl_switch_uport.4
[  607.921853] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: mem12 dport_dev: cxl_switch_dport.8 parent: cxl_switch_uport.4
[  607.924894] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem12: found already registered port port25:cxl_switch_uport.4
[  607.927436] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem12: scan: iter: cxl_switch_dport.8 dport_dev: cxl_root_port.4 parent: cxl_host_bridge.2
[  607.929947] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem12: found already registered port port12:cxl_host_bridge.2
[  607.934040] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.936652] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.940613] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  607.944808] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  607.948593] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem12: probe: 0
[  607.950816] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem12: register pmem12
[  607.952913] cxl_core:cxl_port_alloc:730: cxl_mem mem12: host-bridge: cxl_host_bridge.2
[  607.956391] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.0: Added to port endpoint26
[  607.959199] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.1: Added to port endpoint26
[  607.962617] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.2: Added to port endpoint26
[  607.966031] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.3: Added to port endpoint26
[  607.969253] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.4: Added to port endpoint26
[  607.971826] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.5: Added to port endpoint26
[  607.975098] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.6: Added to port endpoint26
[  607.978470] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder26.7: Added to port endpoint26
[  607.980608] cxl_core:cxl_bus_probe:2077: cxl_port endpoint26: probe: 0
[  607.983253] cxl_core:devm_cxl_add_port:925: cxl_mem mem12: endpoint26 added to port25
[  607.985803] cxl_core:cxl_bus_probe:2077: cxl_mem mem12: probe: 0
[  607.987962] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem13: scan: iter: mem13 dport_dev: cxl_switch_dport.9 parent: cxl_switch_uport.4
[  607.990451] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem13: found already registered port port25:cxl_switch_uport.4
[  607.993390] cxl_core:devm_cxl_enumerate_ports:1649: cxl_mem mem13: scan: iter: cxl_switch_dport.9 dport_dev: cxl_root_port.4 parent: cxl_host_bridge.2
[  607.996038] cxl_core:devm_cxl_enumerate_ports:1654: cxl_mem mem13: found already registered port port12:cxl_host_bridge.2
[  608.000576] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  608.002671] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  608.006172] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  608.008809] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  608.011110] cxl_core:cxl_bus_probe:2077: cxl_nvdimm pmem13: probe: 0
[  608.013967] cxl_core:devm_cxl_add_nvdimm:282: cxl_mem mem13: register pmem13
[  608.016337] cxl_core:cxl_port_alloc:730: cxl_mem mem13: host-bridge: cxl_host_bridge.2
[  608.020215] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.0: Added to port endpoint27
[  608.024081] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.1: Added to port endpoint27
[  608.027925] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.2: Added to port endpoint27
[  608.031407] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.3: Added to port endpoint27
[  608.034555] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.4: Added to port endpoint27
[  608.037208] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.5: Added to port endpoint27
[  608.040564] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.6: Added to port endpoint27
[  608.043942] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder27.7: Added to port endpoint27
[  608.045848] cxl_core:cxl_bus_probe:2077: cxl_port endpoint27: probe: 0
[  608.048608] cxl_core:devm_cxl_add_port:925: cxl_mem mem13: endpoint27 added to port25
[  608.050733] cxl_core:cxl_bus_probe:2077: cxl_mem mem13: probe: 0
[  608.054615] cxl_core:cxl_port_alloc:730: cxl_mem mem14: host-bridge: cxl_host_bridge.3
[  608.064430] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.0: Added to port endpoint28
[  608.069293] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.1: Added to port endpoint28
[  608.072541] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.2: Added to port endpoint28
[  608.075765] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.3: Added to port endpoint28
[  608.078314] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.4: Added to port endpoint28
[  608.081897] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.5: Added to port endpoint28
[  608.084830] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.6: Added to port endpoint28
[  608.087715] cxl_test:mock_cxl_enumerate_decoders:921: cxl decoder28.7: Added to port endpoint28
[  608.089566] cxl_core:cxl_bus_probe:2077: cxl_port endpoint28: probe: 0
[  608.092934] cxl_core:devm_cxl_add_port:925: cxl_mem mem14: endpoint28 added to root9
[  608.095317] cxl_core:cxl_bus_probe:2077: cxl_mem mem14: probe: 0
[  608.099097] cxl_core:cxl_bus_rescan_queue:2095: CXL bus rescan result: 0
[  610.196198] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.199865] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.202922] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.206099] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.210135] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.212927] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.215847] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.217930] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.222752] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.225163] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.227997] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.230061] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.233586] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.236044] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.239075] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.241941] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.245308] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.248930] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.252136] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.253991] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.296822] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.298693] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.1: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.302846] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.306140] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.3: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.309311] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.312174] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.5: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.315236] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.319555] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.8: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.322559] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.325936] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.7: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.329073] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.331435] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.334232] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.336558] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.2: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.339306] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.341384] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.4: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.344093] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.346223] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.6: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.351577] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.354138] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.9: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.478317] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.505786] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4501 sz_in: 96 sz_out: 0 rc: 0
[  610.508017] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.545692] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.547628] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.590735] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.593385] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4502 sz_in: 64 sz_out: 0 rc: 0
[  610.595288] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.636278] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.638316] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.682421] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.685402] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4501 sz_in: 96 sz_out: 0 rc: 0
[  610.687226] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.738153] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.743534] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.785977] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.792473] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4501 sz_in: 96 sz_out: 0 rc: 0
[  610.796078] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.835614] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.839912] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.883548] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.887940] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4502 sz_in: 64 sz_out: 0 rc: 0
[  610.890796] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.928692] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.930315] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.973365] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  610.976054] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4501 sz_in: 96 sz_out: 0 rc: 0
[  610.977520] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.015128] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.017740] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.058961] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.061645] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4505 sz_in: 64 sz_out: 0 rc: 0
[  611.063082] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.100738] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.102299] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.146069] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.150120] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4501 sz_in: 96 sz_out: 0 rc: 0
[  611.152224] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.190376] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.192765] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.395040] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.397570] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.439853] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.441433] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4503 sz_in: 32 sz_out: 0 rc: 0
[  611.442999] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.445244] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4102 sz_in: 8 sz_out: 3972 rc: 0
[  611.483808] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.486267] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.552903] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.554614] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4502 sz_in: 64 sz_out: 0 rc: 0
[  611.556127] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.593271] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.595603] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.636897] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.640127] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4501 sz_in: 96 sz_out: 0 rc: 0
[  611.641793] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.679231] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.681661] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.729224] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.732157] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4504 sz_in: 0 sz_out: 0 rc: 0
[  611.735264] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.774126] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.776712] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.830195] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.833825] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.876268] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.920236] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  611.922485] cxl_mock_mem:cxl_mock_mbox_send:1424: cxl_mock_mem cxl_mem.0: opcode: 0x4500 sz_in: 0 sz_out: 4 rc: 0
[  612.211869] cxl_test:mock_decoder_reset:704: cxl_port port10: decoder10.0 reset
[  612.214206] cxl_test:mock_decoder_reset:704: cxl_port port13: decoder13.0 reset
[  612.215791] cxl_test:mock_decoder_reset:704: cxl_port endpoint21: decoder21.0 reset
[  612.217238] cxl_test:mock_decoder_reset:704: cxl_port endpoint14: decoder14.0 reset

--1DvYohVG7jZAx/go--
