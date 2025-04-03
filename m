Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04853502B1;
	Thu,  3 Apr 2025 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743652826; cv=fail; b=Kax+f3CwLNosV/M6Qy4uU1FFdOUq0Xy+CWzrAASIMNQCwZkLsXE3lTL+AQ+Gb1iPLXs/6JOcVyFUoA7pKBwPE9rUHoxUPz9QjYogpuiPEOu6Dh6XMoueE5na10AB38+5WBrvJmtkbtw1PFcY9tI6ag5M1PBRU6HwpSJlNutvddE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743652826; c=relaxed/simple;
	bh=OWLGK0BJaSVszDuX2igRIEOfOF3DbKyA7gSde99wcr4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJGsRa6HSNG5fyffkcnHNHTCYqVtdFmyxowAKfukWjk2OS5ooLJiO4ZJvv8NtWNVHfAvmImK5ckjyFFNYJPILLzmdgI+oO4BSX2ty3TLYcwtWLO0m7rEsraCCWXsIInC0TzgKwykZJQnRcAizLb0CsVr5qXMonY7LZ/4hNj9OSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZAidDiM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZAidDiM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743652824; x=1775188824;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OWLGK0BJaSVszDuX2igRIEOfOF3DbKyA7gSde99wcr4=;
  b=nZAidDiMhJUqtGPXe+XlnSpdwAxQsXaMYqQigwr+wtV8XUDLpxOeoiYR
   K7eVWikG6EWvbk/q/GfQt6W+zdxN6Qi02eWzDYScs+5jC4GxZwy7/3JvA
   wpw6E+csbs3NsCyx9jXGG9I0ho2142fqoR19IngG31awv1qmywtP663UC
   EybTzQLNWSeswm2ZcAvbOG5B93Gbkb8hb7hgwbjB8T3vfs6SXtORi6TYY
   mOx/QWXoXTC6oeTX2Z/Yixji2n0K6dzckGdyaC/2uUgR+Ndp/YOzwayuO
   9sIs0SK0qbaOYZwEsuW1t83CX9bQGTfm+GFmc6jezuiEXhoWGefJDmmoA
   Q==;
X-CSE-ConnectionGUID: NZFju6Q1S3i12wNS8h/8Aw==
X-CSE-MsgGUID: 8XK+12ppT1eD3wVcjX800A==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="47762496"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="47762496"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 21:00:23 -0700
X-CSE-ConnectionGUID: KVhwnq7iTvuk+6emAkkkow==
X-CSE-MsgGUID: 0lBdfz71RH+LKdgKCwuWvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="164118548"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 21:00:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 21:00:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 21:00:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 21:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htZowo8ct42gInqXd2VSfzwokAINNCSuGhgRm6Mgfjl+I6UDzxOWm+GSSazeaLtqD6E6ZGYFgH9A82IUTp/keO1WuDXaepJ4p44C04rtkLXFM0C8iK3ai7gtn8J0JMSFVSLtvZPl9m3nbLm/nNLw/0Qw+KHieCsZlNohYYgO/wWNVN84RYhP9p7FxtwsodJkmzzpGzUL2EDQ870PtmWvBX+SlKHXNrWh0mA10VTOKdP+MKGm/pwhr+pLwwfAXKMkVwixKylb84A1aKKn4Wy/dArwertGRCbrifvMB1VdB5CxYUCyeuKKIHdfCA076nsNIKINXq1fyF8u0ukLeKS51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmplZf+7sbuN8+kUvs+s61wK33pAq7QmA+5IfpdXpaQ=;
 b=yWjlmM3SQeNvAiCWdBRkK6SKgzyrY78zXVkFq0TAOk5mD3naIVGKde6msSncQ0c8LstC2Q1dI4PaBRJ1IqYu6WMp1EXzAfNUmOs3uyw7M2uiRKuYqm8ZkmXxzCHxKog0pXNewW7ehecuICRK75X+gfhv6qNKSqmoEPdUoXzjFbSLnOfDBz7Ueoo4VO081is+4rQ2vuAa42VWRODNPXub681D589t0x6S3/oSFndjOooq/XMbqvyfB2ABY8sJwOVabz/twhjDBhcQKwgKOQIpr3A16gVgPH3pmLc/iQrjja9Bq8Av+62P9Dg6cmXqcGJQ8cWA7afhxoXrX9Mduadilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5792.namprd11.prod.outlook.com (2603:10b6:a03:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 3 Apr
 2025 04:00:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 04:00:16 +0000
Date: Wed, 2 Apr 2025 21:00:13 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: Robert Richter <rrichter@amd.com>, <ming.li@zohomail.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH 4/4 v3] cxl/test: Simulate an x86 Low Memory Hole for
 tests
Message-ID: <67ee07cd4f8ec_1c2c6294d5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
 <67e7337f25c3a_1198729411@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67e7337f25c3a_1198729411@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0262.namprd04.prod.outlook.com
 (2603:10b6:303:88::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: bce5d2de-bcf2-41b5-fa13-08dd72640b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7hdLhgrExztiGDawF+rDOTcV2N1tHicbG9O6Ta6jplUwwssdBl6BtrS+w9ee?=
 =?us-ascii?Q?Fx+4D/P4EAzks3okzbsJP564zMGl7B9xU/PyO9IpGc5tR6tkTeoGoqu6ir1w?=
 =?us-ascii?Q?97wimtyRGnsNQiuKb71ANUSFOhUfnXBWScCHYkp0C0JORnhwxveZoCVu8mIA?=
 =?us-ascii?Q?7hieTcORA8ozA1iGrzSDa9Yrq3oWZuLhZw6vX5JPV2P8+66AaUcxYG4CcQsB?=
 =?us-ascii?Q?UUHU6vPayBkmGDKYY4bREBlAqYHfJfMkzBVmXuZDc/L5nJQLwBG0CcLG7U/M?=
 =?us-ascii?Q?J5gJEfQE6Ly8q2Yw3YquNohu/LjbZiQBCLcvnfS4wzxmGk6poHaoGO0ar2Nn?=
 =?us-ascii?Q?TqYG3QT6a4i9TlYZBErX6DoOW9JXqbKUDUMg8jVpT9Bf914xqGn2xyABBFls?=
 =?us-ascii?Q?/zzUOkgUNSy44FBh+aq9w3GtV/nnnCqL482N9aa5281+oOKiBMAbri0fqWKc?=
 =?us-ascii?Q?nBH0e3GT5EcAzNvd5Zng0q5Zbxk/VIWB7tBwG+mQeD7j4+B+Z80REBNNfQO9?=
 =?us-ascii?Q?iIHidQM4Z7uFD4yAAF10eV919+dlMEb9YLGnegyYaKx1sEe1iu01Di91cT5c?=
 =?us-ascii?Q?lkRaFDxlLhXnny99/rDnJb2Q/X3Sq0Sorx1CTwqH9Ysn29Qo686w4Mh7avc7?=
 =?us-ascii?Q?ghzTrVVGfsnqsJAIz699ip2n2jO369ktrYj61LQX1pgUnjQNK3/hxs8uqlB0?=
 =?us-ascii?Q?bxBx09FKkLigI8ANn/BqHX3mZuOCU2oqOkGw/fBbDwB+/nZF/awResoMlRSa?=
 =?us-ascii?Q?gxluI706TN5Xk1KfSzKVB5t6aGbuZfG31Cat/ZpHgLyokhr0gM8W08xT6zR3?=
 =?us-ascii?Q?qmTp9VNbHH09afFDy67p9Tcz2II5K+FRD8ea64lPuqil9ecD2D1SHxyu9cUG?=
 =?us-ascii?Q?zxWzvjAHT7rhBGtY/iyoyT461yjhbtIT5GTCtf+7L0H+OGzPa7jWAj6C7lR/?=
 =?us-ascii?Q?89v+eupv9+Btm8hV5YtblK1IakRDiF1s26Cj7ypdmZgr891n2nhSnMBwjVZ1?=
 =?us-ascii?Q?usug+5P/gLKJxxOLkCP3krfRQvetZv17uEeISMnxffKG23+744xKf0GVYBJ5?=
 =?us-ascii?Q?iTvLKFpf79h0BihHL5giuhPi1V4mxz74ix+DlkMHzXH92hGB/tTiyH+pSGC/?=
 =?us-ascii?Q?kbvPTdoBJ2vaGNihHIhMNXLlzNYQIrQgvReC1Pu7bZWihFP7/w8o+yOFLTEn?=
 =?us-ascii?Q?9F2L+2MhhdW8bciBeuPMNfRgivGo9HCd2W9+S5YK8FnoySpmwKyMNzqhqtr3?=
 =?us-ascii?Q?7p6aP7i1kAhHqQLidQkN7p/G5MP/ND11g5MSXOcSUWCcsDixpGkQKQ9jIYce?=
 =?us-ascii?Q?mOe9iy5XPruTzuwCsQeDY+ZkzWw5wKYocfXYRVX2R9KLeOPpnL+MLaxmeDa8?=
 =?us-ascii?Q?/mv2VMG4I7n3glvn76x0jYdwto1vCT7CQcCfuPK8bJZNwpGM0IKOs892cnDs?=
 =?us-ascii?Q?hAO42u3ccV0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f4YVUiuhmsPLpXolgkek9a7GfwngjoixrrVOsvkSRbE3V8tX8AV+eTpZSQz0?=
 =?us-ascii?Q?Vaj58iXlQ7tK0lEAUVCX499s91nL0Oi8/UMPsdkINWfShuqT5sVltPIXqMo5?=
 =?us-ascii?Q?qSdqjeEl9s5Ruyu3d7A8pjhZ+is3traJjTq90PZClC0ZRKkNlAhNY6W0pHhU?=
 =?us-ascii?Q?LhU2z9cgWCsPI3hHATeQ9LzuQhyNu7rhmQWqEWk+F3T2y/JgWteQkhOgn4ga?=
 =?us-ascii?Q?zgzlHtbAmEsgU++HRcePTNOUuhkQGUkQeNicsQo5ghGII3U5GVVOKsQMjc9+?=
 =?us-ascii?Q?TZzN+DqEQqwOkpngj/jMw+vjFaebs86A58/iVA/NbTZC30jFGRm7dF9mBqJX?=
 =?us-ascii?Q?+kIOcg0xRUj5IXnvhH+miQzlDrcp2T06YpnK72ailqlUAw66VabXYbMwOF28?=
 =?us-ascii?Q?gAihRRta0XGV/ZckLvH6P3sC0OqkmMMqhattJymU8WpxvjQIv0tScBiFDfrE?=
 =?us-ascii?Q?gsIYQK4MIyafF9MbqhpNxwyt33Ge+fMUdU/j0+jZk+mLBuI+UGs3tIJNIWhL?=
 =?us-ascii?Q?IB5J462D7+pdoQtrh5mtNpPWJnf4pYc88r6q8HD2qzIrJ93qMICwiq5+KdBK?=
 =?us-ascii?Q?x4G35IlMMjQgP0wV7QuUrUgWgPw3XrENbFdWDasAOulAjyfMvmSW0qcy9n/X?=
 =?us-ascii?Q?CL94HorhRhmcx8R4M+lWI4xwZatc9/WRkx+5EuYneXvOUOT61vg7kbypEHLM?=
 =?us-ascii?Q?YdDbGN/tm90aI0xS5SzlZilP7j+Z4qzIRJWRXn2exJQ8qlpDcdeWlmlta/rR?=
 =?us-ascii?Q?OYZ3iG0TmFscdjXynnMxtwiai4a5tnQrilP7N7+X9SlaUl7xRov4povXrIdF?=
 =?us-ascii?Q?R4Qp6AiDLOZ60HhxSIW52nxePDhmAw19IGB301B63Wahmq3dDiosSCHzNOCS?=
 =?us-ascii?Q?oECjo5yYXdbFB9xwb3U5BuXnlR2qq+QyogLaUYBXU65TOtR6OrbWybobmPvi?=
 =?us-ascii?Q?eWG0hnIT1KjqZYI5PLRIA6p46WsXWoM5G6k89LVJxsPCsYiQmx5V7XuIr4vH?=
 =?us-ascii?Q?X5r3JVu/qKyelT2dBBohnbkB9yYIkd6gn/mkBAnXDpZ7yggzXI2sCBkWTI+K?=
 =?us-ascii?Q?YT4+4ELDxCViyqfs2Tm+PkEjny3EvVO0l3mMsDNiLBCuX7MAXKdFaeKIox/k?=
 =?us-ascii?Q?7nI0kFXl65xx7ZCtFaTtrieby9Z2ujL3sycZOk4mSmh/fNce8pyeZOSGYpJY?=
 =?us-ascii?Q?BCi65uh1Iglq6WTHPo1hBbUW5xfWn2IfJj4zItuHWj13oVex0Z+/+Bv5EpwV?=
 =?us-ascii?Q?KXLOQljRRcjXSEZdIEryW6jfHyYp0v8ligjC9KGbqKwBrsUPA3w0c+J8i0fA?=
 =?us-ascii?Q?RmNvXVo8P3n6f1wYo1VdDgnin2wyBMw3z6mHK/McriURv25TOCLK1SozsLc/?=
 =?us-ascii?Q?ZdduQ/ITF+LuoOgh5B8m2DnTSBBBJxVinBmw7CrDL3FsE4NuLLJT8WQImlVG?=
 =?us-ascii?Q?YqDG1nsw8lMmr+Tiupzp/BVM7m/iQ2FbUsU9l2gEsmUPazY6EV1erHzcv+ak?=
 =?us-ascii?Q?cJXj9nD8nfzgUT3877CvNbaohBt/RbbDQj/VgQUsobz32DHhOnceLbyyqwdN?=
 =?us-ascii?Q?LABXdXgl8rjax18pCYOONxRdu/Cb1klfEQLhVQBGViNn3mU5xU1w48uhgyjg?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bce5d2de-bcf2-41b5-fa13-08dd72640b1f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 04:00:16.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NB0HdNmTJxFSukVI7Ngdl5gei5iBYimQmhGp+KPm5IJ8p1ao0XVTDaLjsMdKnV65vN6Zh6YFkXuEOCpAF8soiaNTOEomDrGP6w4iXf86Df8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5792
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Fabio M. De Francesco wrote:
> > Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> > mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range sizes
> > to 1GB.
> > 
> > Since the auto-created region of cxl-test uses mock_cfmws[0], whose range
> > base address is typically different from the one published by the BIOS on
> > real hardware, the driver would fail to create and attach CXL Regions if
> > it was run on the mock environment created by cxl-tests.
> > 
> > Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to match CXL
> > Root Decoders and Regions with Endpoint Decoders when the driver is run on
> > mock devices.
> > 
> > Since the auto-created region of cxl-test uses mock_cfmws[0], the
> > LMH path in the CXL Driver will be exercised every time the cxl-test
> > module is loaded. Executing unit test: cxl-topology.sh, confirms the
> > region created successfully with a LMH.
> > 
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> > ---
> >  drivers/cxl/core/lmh.c               | 35 ++++++++++++++++++++++++----
> >  drivers/cxl/core/lmh.h               |  2 ++
> >  tools/testing/cxl/cxl_core_exports.c |  2 ++
> >  tools/testing/cxl/test/cxl.c         | 10 ++++++++
> >  4 files changed, 45 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> > index 2e32f867eb94..9c55670c1c84 100644
> > --- a/drivers/cxl/core/lmh.c
> > +++ b/drivers/cxl/core/lmh.c
[..]
> 
> Someone should be able to read the straight line CXL driver code and
> never know that an alternate implementation exists for changing these
> details.
> 
> So, the mock interface for this stuff should intercept at the
> arch_match_spa() and arch_match_region() level.
> 
> To me that looks like mark these implementations with the __mock
> attribute, similar to to_cxl_host_bridge(). Then define strong versions
> in tools/testing/cxl/mock_lmh.c.
> 
> The strong versions would apply memory hole semantics to both windows
> starting at zero and whatever cxl_test window you choose.

In the interests of moving this forward and because cxl_test, while
useful, is a problem I created, here is a rough mockup of this proposal.

The observation that this hole detection logic is self contained and
suitable to be duplicated in the test code.

The other proposal in this mockup is that the names of these
augmentation functions be changed from "arch" to "platform" as this hole
is a total system / platform quirk not limited to a CPU arch.

Lastly, while I did not make that change I think lmh.c should probably
be renamed platform.c on the expectation that all future platform
quirkiness can land in that file. CONFIG_CXL_PLATFORM_QUIRKS can be
selected in the x86 case, but something tells me every arch that ships
CXL will eventually select CONFIG_CXL_PLATFORM_QUIRKS which might make
the config option moot in the future.

This builds and loads CXL test, and I see the mock versions of these
platform helpers being called.

-- 8< --
diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
index 9c55670c1c84..1bfe516aacf3 100644
--- a/drivers/cxl/core/lmh.c
+++ b/drivers/cxl/core/lmh.c
@@ -3,26 +3,12 @@
 #include <linux/range.h>
 #include <linux/pci.h>
 
+#include "cxlmem.h"
 #include "lmh.h"
 
 /* Start of CFMWS range that end before x86 Low Memory Holes */
 #define LMH_CFMWS_RANGE_START 0x0ULL
 
-static u64 mock_cfmws0_range_start = ULLONG_MAX;
-
-void set_mock_cfmws0_range_start(const u64 start)
-{
-	mock_cfmws0_range_start = start;
-}
-
-static u64 get_cfmws_range_start(const struct device *dev)
-{
-	if (dev_is_pci(dev))
-		return LMH_CFMWS_RANGE_START;
-
-	return mock_cfmws0_range_start;
-}
-
 /*
  * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
  *
@@ -32,52 +18,48 @@ static u64 get_cfmws_range_start(const struct device *dev)
  * also larger than that of the matching root decoder. If there are LMH's,
  * the root decoder range end is always less than SZ_4G.
  */
-bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
-		    const struct cxl_endpoint_decoder *cxled)
+__weak bool
+platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+			       const struct cxl_endpoint_decoder *cxled)
 {
 	const struct range *r1, *r2;
-	u64 cfmws_range_start;
 	int niw;
 
-	cfmws_range_start = get_cfmws_range_start(&cxled->cxld.dev);
-	if (cfmws_range_start == ULLONG_MAX)
-		return false;
-
 	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 	r2 = &cxled->cxld.hpa_range;
 	niw = cxled->cxld.interleave_ways;
 
-	if (r1->start == cfmws_range_start && r1->start == r2->start &&
-	    r1->end < (cfmws_range_start + SZ_4G) && r1->end < r2->end &&
+	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
+	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
 	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
 		return true;
 
 	return false;
 }
 
-/* Similar to arch_match_spa(), it matches regions and decoders */
-bool arch_match_region(const struct cxl_region_params *p,
-		       const struct cxl_decoder *cxld)
+__weak bool platform_region_contains(const struct cxl_region_params *p,
+				     const struct cxl_decoder *cxld)
 {
 	const struct range *r = &cxld->hpa_range;
 	const struct resource *res = p->res;
 	int niw = cxld->interleave_ways;
-	u64 cfmws_range_start;
-
-	cfmws_range_start = get_cfmws_range_start(&cxld->dev);
-	if (cfmws_range_start == ULLONG_MAX)
-		return false;
 
-	if (res->start == cfmws_range_start && res->start == r->start &&
-	    res->end < (cfmws_range_start + SZ_4G) && res->end < r->end &&
+	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
+	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
 	    IS_ALIGNED(range_len(r), niw * SZ_256M))
 		return true;
 
 	return false;
 }
 
-void arch_adjust_region_resource(struct resource *res,
-				 struct cxl_root_decoder *cxlrd)
+void platform_region_adjust(const struct cxl_root_decoder *cxlrd,
+			    const struct cxl_endpoint_decoder *cxled,
+			    struct resource *res)
 {
-	res->end = cxlrd->res->end;
+	if (platform_root_decoder_contains(cxlrd, cxled)) {
+		res->end = cxlrd->res->end;
+		dev_dbg(cxled_to_memdev(cxled)->dev.parent,
+			"(LMH) has been adjusted (%s: %pr)\n",
+			dev_name(&cxled->cxld.dev), res);
+	}
 }
diff --git a/drivers/cxl/core/lmh.h b/drivers/cxl/core/lmh.h
index b6337120ee17..34f88b9e8290 100644
--- a/drivers/cxl/core/lmh.h
+++ b/drivers/cxl/core/lmh.h
@@ -2,30 +2,31 @@
 
 #include "cxl.h"
 
-void set_mock_cfmws0_range_start(u64 start);
-
 #ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
-bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
-		    const struct cxl_endpoint_decoder *cxled);
-bool arch_match_region(const struct cxl_region_params *p,
-		       const struct cxl_decoder *cxld);
-void arch_adjust_region_resource(struct resource *res,
-				 struct cxl_root_decoder *cxlrd);
+bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+				    const struct cxl_endpoint_decoder *cxled);
+bool platform_region_contains(const struct cxl_region_params *p,
+			      const struct cxl_decoder *cxld);
+void platform_region_adjust(const struct cxl_root_decoder *cxlrd,
+			    const struct cxl_endpoint_decoder *cxled,
+			    struct resource *res);
 #else
-static bool arch_match_spa(struct cxl_root_decoder *cxlrd,
-			   struct cxl_endpoint_decoder *cxled)
+static bool platform_root_decoder_contains(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
 {
 	return false;
 }
 
-static bool arch_match_region(struct cxl_region_params *p,
-			      struct cxl_decoder *cxld)
+static bool platform_region_contains(struct cxl_region_params *p,
+				     struct cxl_decoder *cxld)
 {
 	return false;
 }
 
-static void arch_adjust_region_resource(struct resource *res,
-					struct cxl_root_decoder *cxlrd)
+static inline void
+platform_region_adjust(const struct cxl_root_decoder *cxlrd,
+		       const struct cxl_endpoint_decoder *cxled,
+		       struct resource *res)
 {
 }
 #endif /* CXL_ARCH_LOW_MEMORY_HOLE */
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9eb23ecedecf..7822e726ea8c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -851,7 +851,7 @@ static bool region_res_match_cxl_range(const struct cxl_region_params *p,
 		return true;
 
 	cxld = container_of(range, struct cxl_decoder, hpa_range);
-	if (arch_match_region(p, cxld))
+	if (platform_region_contains(p, cxld))
 		return true;
 
 	return false;
@@ -1784,7 +1784,7 @@ static int match_switch_decoder_by_range(struct device *dev,
 		if (range_contains(r1, r2))
 			return 1;
 		cxlrd = to_cxl_root_decoder(dev);
-		if (arch_match_spa(cxlrd, cxled))
+		if (platform_root_decoder_contains(cxlrd, cxled))
 			return 1;
 	}
 	return (r1->start == r2->start && r1->end == r2->end);
@@ -1994,7 +1994,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	}
 
 	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
-	    resource_size(p->res) && !arch_match_spa(cxlrd, cxled)) {
+	    resource_size(p->res) && !platform_root_decoder_contains(cxlrd, cxled)) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s-size-%#llx * ways-%d + cache-%#llx != region-size-%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
@@ -3231,7 +3231,7 @@ static int match_root_decoder_by_range(struct device *dev,
 
 	if (range_contains(r1, r2))
 		return true;
-	if (arch_match_spa(cxlrd, cxled))
+	if (platform_root_decoder_contains(cxlrd, cxled))
 		return true;
 
 	return false;
@@ -3254,7 +3254,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 	if (p->res) {
 		if (p->res->start == r->start && p->res->end == r->end)
 			return 1;
-		if (arch_match_region(p, &cxled->cxld))
+		if (platform_region_contains(p, &cxled->cxld))
 			return 1;
 	}
 
@@ -3348,16 +3348,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
 	 * platform
 	 */
-	if (arch_match_spa(cxlrd, cxled)) {
-		dev_dbg(cxlmd->dev.parent, "(LMH) Resource (%s: %pr)\n",
-			dev_name(&cxled->cxld.dev), res);
-
-		arch_adjust_region_resource(res, cxlrd);
-
-		dev_dbg(cxlmd->dev.parent,
-			"(LMH) has been adjusted (%s: %pr)\n",
-			dev_name(&cxled->cxld.dev), res);
-	}
+	platform_region_adjust(cxlrd, cxled, res);
 
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ec6b906371b..1b3a97ef3f11 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -74,7 +74,7 @@ static inline struct cxl_port *cxlrd_to_port(struct cxl_root_decoder *cxlrd)
 }
 
 static inline struct cxl_memdev *
-cxled_to_memdev(struct cxl_endpoint_decoder *cxled)
+cxled_to_memdev(const struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
 
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 3b3c24b1496e..9d24a7fd2536 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -65,6 +65,7 @@ cxl_core-y += $(CXL_CORE_SRC)/acpi.o
 cxl_core-y += $(CXL_CORE_SRC)/ras.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += $(CXL_CORE_SRC)/lmh.o
+cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += mock_lmh.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index 7b20f9fcf0d7..f088792a8925 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -2,8 +2,6 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
 #include "cxl.h"
-#include "lmh.h"
 
 /* Exporting of cxl_core symbols that are only used by cxl_test */
 EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
-EXPORT_SYMBOL_NS_GPL(set_mock_cfmws0_range_start, "CXL");
diff --git a/tools/testing/cxl/mock_lmh.c b/tools/testing/cxl/mock_lmh.c
new file mode 100644
index 000000000000..b849166ba86a
--- /dev/null
+++ b/tools/testing/cxl/mock_lmh.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/range.h>
+#include <linux/pci.h>
+
+#include <cxlmem.h>
+#include <lmh.h>
+#include "test/mock.h"
+
+static bool is_mock_dev(struct device *dev)
+{
+	struct cxl_mock_ops *(*get_ops_fn)(int *index);
+	struct cxl_mock_ops *ops = NULL;
+	void (*put_ops_fn)(int index);
+	bool is_mock = false;
+	int index;
+
+	get_ops_fn = symbol_get(get_cxl_mock_ops);
+	if (!get_ops_fn)
+		return false;
+	put_ops_fn = symbol_get(put_cxl_mock_ops);
+	if (!put_ops_fn)
+		goto out;
+
+	ops = get_ops_fn(&index);
+	if (ops)
+		is_mock = ops->is_mock_dev(dev);
+	put_ops_fn(index);
+
+out:
+	symbol_put(get_cxl_mock_ops);
+
+	return is_mock;
+}
+
+/* Start of CFMWS range that end before x86 Low Memory Holes */
+#define LMH_CFMWS_RANGE_START 0x0ULL
+
+static bool
+real_platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+				    const struct cxl_endpoint_decoder *cxled)
+{
+	const struct range *r1, *r2;
+	int niw;
+
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	r2 = &cxled->cxld.hpa_range;
+	niw = cxled->cxld.interleave_ways;
+
+	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
+	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
+	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
+		return true;
+
+	return false;
+}
+
+bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+				    const struct cxl_endpoint_decoder *cxled)
+{
+	if (is_mock_dev(cxled_to_memdev(cxled)->dev.parent)) {
+		/* cxl_test_platform_root_decoder_contains(...) */
+		return false;
+	}
+
+	return real_platform_root_decoder_contains(cxlrd, cxled);
+}
+
+static bool real_platform_region_contains(const struct cxl_region_params *p,
+					  const struct cxl_decoder *cxld)
+{
+	const struct range *r = &cxld->hpa_range;
+	const struct resource *res = p->res;
+	int niw = cxld->interleave_ways;
+
+	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
+	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
+	    IS_ALIGNED(range_len(r), niw * SZ_256M))
+		return true;
+
+	return false;
+}
+
+bool platform_region_contains(const struct cxl_region_params *p,
+			      const struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	if (is_mock_dev(port->uport_dev)) {
+		/* cxl_test_platform_root_decoder_contains(...) */
+		return false;
+	}
+
+	return real_platform_region_contains(p, cxld);
+}
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8c69ce0a272f..f54a648d2268 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -459,7 +459,6 @@ static int populate_cedt(void)
 			return -ENOMEM;
 		window->base_hpa = res->range.start;
 	}
-	set_mock_cfmws0_range_start(mock_cfmws[0]->base_hpa);
 
 	return 0;
 }
