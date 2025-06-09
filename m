Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1993D544;
	Mon,  9 Jun 2025 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485612; cv=fail; b=b5VldEBST0hvmULzSbE5qpeYrzc1anjG3+TdP/cnPjcPV5kRpzI+lLKG4AgZBM21dq7bMzX2cCqaUm0lanhm+yTgE+MCquvjJP1jr9IYHt9I4O1ez1Jk+aYQ7gyWdM1Fahre2oj29zmAvMGhQ2TNULSEvXntH0fDiDgyoRhDrC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485612; c=relaxed/simple;
	bh=aFe1YQPe3/fVVHvUvPmKHZlwzktXKaa4gNAzDIlnB8g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rYwFCgw/RxYjswozsG/i9/IckS543l/gjqDg2h7YhX5sCJHCtqAQUjURd8DkDfZoPCr1zX0EfODTG+mKuzxhn2nFqg3MWQP5pK//3AkUY8P50HFqDbXq0oWYYm5UKzzvrYqDl24UwHx+MVkPE9mIojsW/aMlXJNrMJuaGgKQOag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWgdjGvD; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWgdjGvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749485611; x=1781021611;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aFe1YQPe3/fVVHvUvPmKHZlwzktXKaa4gNAzDIlnB8g=;
  b=nWgdjGvDNuRlPkp9f6YRX7RJiiqixfTuFvf757MOLYFiMbYwYb04j9yv
   45SMJuWcMjAcjRlafKK9MvUqwj06ZWZHqG+kdePKm62dpvljeurOlSVhb
   JolLTl1Feq+DN3xjZ1zVrXAfVcAnMDsXov1X/nPJNXeuCt89PZk8OSAd9
   fXwoqBgVEVwBtzN1b9ecuVFVDd+//qt5IzndfZiSIGWDjav4oJCwpxAsn
   Jb+hShg9QJQN6Al7StwmWWaaLgnkdKx1tCQLSHQX42T9UtPJbku34fGfq
   gKZg+m7rryIdhxTioH1Pm5FLl6WRbfXVFXh/aNdKQN1v9fd6++JH/Q/xE
   w==;
X-CSE-ConnectionGUID: Um+VK7m1SciqSAKQXxLoSQ==
X-CSE-MsgGUID: 66ZOC5q/T7enQrPNVWFhmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61838079"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="61838079"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:13:30 -0700
X-CSE-ConnectionGUID: wh9DeSGhSpKuH5gpX7L58Q==
X-CSE-MsgGUID: LNyhWPQJQc+CftQf/JCOmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="147493141"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:13:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 09:13:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 09:13:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 09:13:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1/5Omk9jauhaec3ScfZnCrigYI+YP0D2TKP0N59JeVIvUf7Rz5Up9p3Zk2XdWwnwoURJdZFg0aHDwfP3orrLUuq2y1reguNGSsoe2/EBRzwjUzB3vqpL4EoYtFrsjpx8BiBrnsMOkcc1oIcuC0BJ+4qHSAHVm8X21q9iTfy+B3hStn+WbAypCHNOcTZjSBL7jXAOvK0IJm49Jq7y2yKHsFKuWpERpr3aFNYQnR8Fm/78nHKqfRC/8OJdvReKka9ARrDtxhLTHPLXh9vPlAx/AForREGmEzCUUY0FN8+Yn360YOg4QuHuSG8EJuSCdsDURz1jYnfGYX3WwzDAG/Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPqbZIpStB6366rTqhR5tbHpjA5PoY0nfhcGWWcbKPM=;
 b=PylrcCTMoSeZyy3in6p9g727iw1LpL53uGvqoPnqlOyCuXEZ68wJZzzTGICXWeXcHKNEUbr8nEZVCSpJ5RX3O+TxEL15/O/RH0mjo4bX3kEl3LG/mYLhSOJq+A3Wwlt3r/zSndz/ME5AFDBrsqvoSf/3m/EISB9WFyqtNJKjGTuZFPDuxN5Xsa7FpB1VLxRoFjrMN9FrUv4vF7VgrMZV8/Eia3JVBi5+S/udw4V+aHXkxDPtJnl2K8XXgZUxmqd/9YUJcF8Q0/p4BaKtG/1e2/uOgbP0P9jVgVGtq/FJiVH1KxdQBC3HjQsd6wq9lt7T7/ftIIdbqvLqORoZqn5C7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9131.namprd11.prod.outlook.com (2603:10b6:208:55c::11)
 by SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 16:13:21 +0000
Received: from IA4PR11MB9131.namprd11.prod.outlook.com
 ([fe80::7187:92a3:991:56e2]) by IA4PR11MB9131.namprd11.prod.outlook.com
 ([fe80::7187:92a3:991:56e2%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:13:20 +0000
Date: Mon, 9 Jun 2025 11:14:24 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Shiju Jose <shiju.jose@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, Fan Ni
	<fan.ni@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] cxl: fix return value in
 cxlctl_validate_set_features()
Message-ID: <684708602e1c8_1b0de02945d@iweiny-mobl.notmuch>
References: <aDbFPSCujpJLY1if@stanley.mountain>
 <aDcqO5hlGrRXzIPT@aschofie-mobl2.lan>
 <3cf2e87f32934c6d84ede6415206a352@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cf2e87f32934c6d84ede6415206a352@huawei.com>
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To IA4PR11MB9131.namprd11.prod.outlook.com
 (2603:10b6:208:55c::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9131:EE_|SJ0PR11MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 35970f0b-a4e0-4383-2eb9-08dda7708d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?REJ3kFhvQFZkzSngyujlnAmTKrd+UMyOk0bOdLRmcuc3ZVYAI5CBht31kI/g?=
 =?us-ascii?Q?Z0f+MFqr3utuOftRnOI4IGUvPS7POxczSh75+r7nXWd4sFsniX7HqJ5Z2MNm?=
 =?us-ascii?Q?iS6oS4csP3fQ0JCvqZAH8TfuAJ1j6XJ4CInUGEpXCthW5JkxkIjfVdaBycB2?=
 =?us-ascii?Q?ZWsIvACtWP+GlW+XOh2wwygv07qRHMuUSG2NxBGS1b8TvGUQO4gxza08rs6r?=
 =?us-ascii?Q?JoHa4WeyF2OfUyv+7/gJzWJZDPEgYnxPtrsqWz9kaJ2X/+F3pxBJvVJVd3Hv?=
 =?us-ascii?Q?d0UEyKyWf36ryz/8wmGSG5MgFCaMeiBbRXWpusnI8AK0KtwiVGwxKw386C7X?=
 =?us-ascii?Q?8L8ZJIKS5USGyqkJ2xbd6sIFSKu79/AF++bQO23gr/hAGqa7lGgFIJM7CCxS?=
 =?us-ascii?Q?GOe3SCoQix2e7t4migNjr9lWQL0NgDAz3+uR9zS4RdSqx8FEGugY/8RZRPzm?=
 =?us-ascii?Q?v7BcBKF6iHWA8Br5idCsNg3b8iwE7bB31GtUpxnyYx6awHYIvBa02WKo2syA?=
 =?us-ascii?Q?UCMWz0fMCT8s54PU0C3Z1Zc9WU6EKzr/ch0xeMKYL2/HqO7v8a2RrEuTynMY?=
 =?us-ascii?Q?iz1sN4F4q59nDl9TNyGD5Vs2YFe25Q8pHkB1sMB8cfi6sYMyfhxQXDQFkgiv?=
 =?us-ascii?Q?MeIHdIhljopsbFUR1Ux1IY831MA30utL+nkvdmaTtoDWMUo2feptdPDk/29p?=
 =?us-ascii?Q?TMnBkzwb2YbA5ZtpquqC5BTOyiAxS/wNC/kdWTw6hGX1dO5+VKCK994SkG8Q?=
 =?us-ascii?Q?OyZPEexKkipVYSlkMN2EugIaNVjWKfz4AgpJ65mxLUq/R6h26Kk0XUCqQeAH?=
 =?us-ascii?Q?8oSd0qWkCOJmh2svMIH0Q7LOxj80JGLZG4wcfGeuRMY02t+dayghnIpewu5v?=
 =?us-ascii?Q?f2GVBXElasCDJVnvmSyo5Xw1gvu6a0yjVP+cquYLenCkA/j8l+YiyzOrZv2M?=
 =?us-ascii?Q?CSkCqiW9aADYbQxOPjCqhUTdcAJFNO6w0H13kWVHqxPieZeyrYmXTeNAwadB?=
 =?us-ascii?Q?PV16KpBHXAqVDthTes4/rxD/TAv5WL+gYR7WLa9tOYWg8mMqO7YKpi8Z/R1Q?=
 =?us-ascii?Q?3Od/I3NUk4Mpv0F3JgFS5iTtZmDpdg+k5ECCNGdabG5/1OIxm690FeZoMOao?=
 =?us-ascii?Q?k/dWNP1mi2EjOmPU0nqh5oKn6UmGE35fgsJ8G16Y1vbxIdgmo+DqV2lj1LHS?=
 =?us-ascii?Q?xqcoelC0Cl8HAmwvhvg7Zsj4c3zE5DwyxQCOJdgUaZpKCbr75B+f5vI0Cd9m?=
 =?us-ascii?Q?rQYNGY2dWSuho/HxWHeNlx5RR3OBT0lpiT87Kgm484jhLCZtcLHs5lyjXU3v?=
 =?us-ascii?Q?s1j0wrTVaaYwLRB/kqsKU14wdSVYn796j0Akl7U8IzutUb+iYYj4cldGLWNk?=
 =?us-ascii?Q?UYCe0/LCDKvJQprns31YDktqtwvvoJxuudHdWWwbMI1Xcug+wsvR3IMFkIZM?=
 =?us-ascii?Q?V2+6w8x/b8Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR11MB9131.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H88yD272DM1gaibOC8cvrl1Yj/QZskBxqcEmVfVLhjRCoOB+JWauqqnTE8A5?=
 =?us-ascii?Q?Qt6+O7WEd7D9EW0nfc5T2g8cp70Bi7J72MwK4x8STh+DL3avDQqYVV+2e2l6?=
 =?us-ascii?Q?Y1+F0aVGdWqkzE1TSjy49noW1386GaTtcCkSiwtTsFbOcAWUYGoJEa3CnbFf?=
 =?us-ascii?Q?EAqXdIkuLxYhXllSIpOQ/EXX7sn4+JpiXKrMwAau//nukiLm+rI8YP6fvuDE?=
 =?us-ascii?Q?bGEtuJE++z2yUaW4/5YP1Mg8ja+fADSca6X9tSzulJ4BgJWkC7nb2F2w6iVl?=
 =?us-ascii?Q?xcwTuEusLfQq3LG1ZAllZ/qJtD3ZzMR7J6hVHs2KbFPR9bJ27djWL5x026jR?=
 =?us-ascii?Q?F3/pn1ir1SqdUUTTw2Fc5EV8DsfkjxUT/x1S5BufxZiWwpnitc4ILohplz5Q?=
 =?us-ascii?Q?PdM7XZ2XgIwmWGYomfZ+Vtena8WzCwLFS4HqJGH3cB8apFEPJI4hXoaFef3j?=
 =?us-ascii?Q?vjVkFwo5lTQ48iqwpIoDpBfkue74/7zPYEIitlj+g2mImfNvWMiX98j/A7CJ?=
 =?us-ascii?Q?zn02XwY3y+KbEy/ttc3UhPHosKYOwT5cdQSDlH0xc4hAsju82ZsubAU178lZ?=
 =?us-ascii?Q?hELZ+JhO5VPLPsIxkBRa7jTZ10UZwpL7PzElgR/JZaDkqciyZCy1wmgT2HmJ?=
 =?us-ascii?Q?EAuMif3roCfgGI1IMLWQrbbkt24rtpfYJ8GlIJxKAZbvOX35I3geQongi62D?=
 =?us-ascii?Q?Pu8jfaqaGXhTwIjgdqm0Gu9/lKnGzuRjYvRNo28DZ3mFGU5frht4I7ltSORE?=
 =?us-ascii?Q?DikNY6KZSDjvrREQ5LIUMkrwVVNS+OdsF0y8tCufjZzJszR8tRGtZaMKcRL8?=
 =?us-ascii?Q?wGul/H+l2nvFt2/BRWB8/4NsQhoieRcPWClpYWVqMMEz7c5gDKlYiW+QYuTa?=
 =?us-ascii?Q?JW3W8n4BGqe3GpewFqCYkXTyLshcgwaIlaF/KFuoVVW8/RpWglYi8ya4vzd1?=
 =?us-ascii?Q?3R2tyQnwdCJnm4j1Ig3XxqHzI3OKw9JX22OSOMlWTfSca+oSLN2vC/UukHkp?=
 =?us-ascii?Q?QBdWArOnupPCdXqVc07V97NL+CUwYmHDptBq0Wkr10sY3dDTFi9hKXXHkw9C?=
 =?us-ascii?Q?mlKciVaZjcRSeJ6+clHq/ellyHCBiYMazOX767zTzBA8BqgXWJxFClCqDBiz?=
 =?us-ascii?Q?xC8eBr5r7Bv5EOLJ3sP0z9lkbe689G2d5Bz54Qxko27y2uFBPtTK2by3A06O?=
 =?us-ascii?Q?70vJzSAl3EHADXsR+E2XdWgCxiD2ObDYMqjQEyKWqCVD3J3Od1FGGcgFdyt/?=
 =?us-ascii?Q?l4AMi6u0z4kJXx4Y6zeTUAUbseXtWOy40PgpGwURU62cUcgOSOKsrHyX0a05?=
 =?us-ascii?Q?CwYmjofmRoOLOrGlf16ozi55El0euCK1Dd+YlM134sAlYefY6SptCnC0jrix?=
 =?us-ascii?Q?0uBoufplWO5IYjPStDkuWd5/vR/RVnnk4nqY0reIabEYgXhdK0mmqcHPajEB?=
 =?us-ascii?Q?eQ3MU85HamUKwFG4yXk3iQIo5i4HlMiJjpzp49trgFYSxQgOB8mffWuRnZjM?=
 =?us-ascii?Q?T/F1li6+GbZrwFad6rTl8t9Gsv68SNVZUh1icj5Q25qRkiD3dZ0Q0Vf8YOQr?=
 =?us-ascii?Q?BzIKau2xoECbPWEZk+gXNjLiO9ztF4mnQy/qDmIk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35970f0b-a4e0-4383-2eb9-08dda7708d30
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9131.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:13:20.6928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqY0HaVaQl/teuj/YLpHzEB91uP8vQTZbEI2JXvcfBZUWliJOkxPiqHRIdlwey/0tAKfPpssw6t/BwhZwIt5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
X-OriginatorOrg: intel.com

Shiju Jose wrote:
> >-----Original Message-----
> >From: Alison Schofield <alison.schofield@intel.com>
> >Sent: 28 May 2025 16:23
> >To: Shiju Jose <shiju.jose@huawei.com>; Dan Carpenter
> ><dan.carpenter@linaro.org>
> >Cc: Davidlohr Bueso <dave@stgolabs.net>; Jonathan Cameron
> ><jonathan.cameron@huawei.com>; Dave Jiang <dave.jiang@intel.com>; Vishal
> >Verma <vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>; Dan
> >Williams <dan.j.williams@intel.com>; Li Ming <ming.li@zohomail.com>; Fan Ni
> ><fan.ni@samsung.com>; linux-cxl@vger.kernel.org; linux-
> >kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> >Subject: Re: [PATCH next] cxl: fix return value in cxlctl_validate_set_features()
> >
> >On Wed, May 28, 2025 at 11:11:41AM +0300, Dan Carpenter wrote:
> >> The cxlctl_validate_set_features() function is type bool.  It's
> >> supposed to return true for valid requests and false for invalid.
> >> However, this error path returns ERR_PTR(-EINVAL) which is true when
> >> it was intended to return false.
> >
> >Shiju - Can you trace this one through and add the impact statement?
> >Wondering if this is going to fail gracefully, or badly, further down this path?
> 
> Hi Alison,
> 
> This is introduced when following fwctl specific code
> move out of common  function (use both in fwctl and edac path)
> get_support_feature_info() to fwctl specific function
> cxlctl_validae_set_feature().
> "if (rpc_in->op_size < sizeof(uuid_t))
>       return ERR_PTR(-EINVAL);"
> 
> This may have an impact on fwctl side if the above check pass.
> 

I got a bit sidetracked by this conversation.

It seems the TLDR is:

This fix is not required.  But should be fixed for long term correctness.

With that interpretation.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
