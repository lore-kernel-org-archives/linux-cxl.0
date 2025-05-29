Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9228E56B
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748552129; cv=fail; b=QCBxSLHaBeTLuL0/u9QEbgEQzZ3xuNRHJpQakFIOEKbfP5tCTykumcOLbAcOx97Foik5n2U/3GN+kQECV87gIGkdYk0qU1AHHKZy22aZUQGXF0GmGWASArUmCcQKpLuWkqd9I4gKMrUcUsGlgR+I9tIOQ5FS7VpzuUZA6uyyVzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748552129; c=relaxed/simple;
	bh=YAmU0ufhtnAhm22d95YVpKiLH1CdG45kIcWZJ9DqKGE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XUoZVF0xGWwr56LtiAJy7l0QVSyf5PeZFEakFmyrfA3TgVmFNGxgp8gjy8F2JTOVfAgwYYwu+bhT3/ulmPbTwh7t9kki8OGJlcsohld0xFnoj+I2LWtqt91RaKk+XEbEucEC3rZXS63mj6o4+QbyMqpJEsRmDe8Q8wWcpYZEzNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbF+g10d; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbF+g10d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748552127; x=1780088127;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YAmU0ufhtnAhm22d95YVpKiLH1CdG45kIcWZJ9DqKGE=;
  b=IbF+g10dDcfLJx8gbtxm1SbZ03aB44iMSjrjUGOo8HkqpJJZ/LXvLGAd
   cMxhwTIiJ9+DzT4sh7ffsLJK0YccHbqImXpSvhiElBOjVDYHRXTPEqz3E
   SqJgelz39ba7t26kqIozSLlK2FI/Kvb0WekRzWPp+yi43scuvh7m8ZdPk
   QVZxB/8ZszAoeBnho6DwPJJ2ONn8noJzaSOskTDgmBLZNnfHh1zkrEFdW
   U43CjL2F+Bxqpge0wesGWNbNjDL2SLx73YJNNkMyz+aVZ6RolcL+k1CIu
   +4BAJ3qZ01uJC86fjxNzbhpLiua/B/yxMaNwyTaiIfOr1bsGERUZRNUlK
   g==;
X-CSE-ConnectionGUID: mOV/dEsFROawTPuXTwGwhA==
X-CSE-MsgGUID: 1wDRHwfLTv6RMCRq55a22A==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="54298268"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="54298268"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 13:55:26 -0700
X-CSE-ConnectionGUID: 2OC4ZlWpTPKT6M3egzAGZQ==
X-CSE-MsgGUID: IGgWmNjLRGeErCyqudbxtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="148463902"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 13:55:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 13:55:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 13:55:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.75) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 13:55:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/7FXWCP9n+RaWZv16XfThwNh/IHk1l+c0lLnmmexS/EQukCGfBKVJixu/sy5pxrKH//1o/C7X5qyBFIf+Kl1uTkXNLR5RjX1NtzjMLrxUOqpJZtJF4ojH8yG0HB1Fe3C7IBGlRcEsTjL/dnMnye1WsM/zqz54pBGTGR+2X743kndQod5e1KXwtmY3ZCGmaJRQfqy6YQirAT2xrixciAAuCZqYlk/rdYmWhHd39OdxDZMCfBTLpj4Zb7Y0g8Z3kxIvIF2Bn9KidC1OkMxYLWgi4x4Y5/nxKSJHpRqr70j+wj7mcJdEXBYsYVjuIt9liEnR/7Gd+Wurxa6YGEA4pRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi9V7qbi6QibFlSKECE5D3kvh4JERIDuUQ3f8HsOTBU=;
 b=oY/f0VM+K9Tet+yKBx/pPDCneWLQaL4uhHJvqxLtzcWkGZqnCSCIrFcXJtGEE7KRJX23fwxZ18/u0Sj3N8YRldp7fZgbcOc2j4uZZ9A1B6oCCoW++Rxzti9lbr/3jmk37TQF9fvuDV38QxEFE6HzN6oh0LFt1z7FK3tcRgPHtUfE4IfyE0m3RREqCnDRw8a8RTYipJeaZvSULA1/oVB2/MxQczJuKghyjR+2j17oWwoN7LCqxIvp39dCxNUJQpCgzl62vHDeY/9Co0g9cMp53kJ9YY40XWWEjc6f5yG20zmOSU3tkwMhvEEb8sY43bXY1wNJIVS2ivqp/sfTjTF4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF5EA507B64.namprd11.prod.outlook.com (2603:10b6:f:fc00::f25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 29 May
 2025 20:55:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 20:55:24 +0000
Date: Thu, 29 May 2025 13:55:21 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] cxl/pci: Replace mutex_lock_io() w mutex_lock() for
 mailbox access
Message-ID: <6838c9b94d05_3e70100e7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250529205117.1990465-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250529205117.1990465-1-alison.schofield@intel.com>
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF5EA507B64:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f989e74-8fa3-4430-2b83-08dd9ef32212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rgwpDIkPU9JB++KLfd3wacFQPi8Mv1ho8zhrjIglakYb7cgJT4sAW6UNPM1P?=
 =?us-ascii?Q?GmntaboZId68VuetNB8dH2RQOQcSl5SCQtTpSctYCIySjdk7wN1fLb3EKwaF?=
 =?us-ascii?Q?3fBc4Ml7dgA4F3SlwDG6Lm5o/B92ZtG9HNn2wwlJ11UYPKyWdCeannhPe9yh?=
 =?us-ascii?Q?5Mrn+CkVoJ+YlrN3NWY0LPc+eN3EGYmSQP2WBAsWoWZuHQk4XQrExup7N7RS?=
 =?us-ascii?Q?czHukfVjpEpUgCnDp4Dlgc/9/mtdRMGhDCsRp24V8fV8c4rF0hAFh1wV+Hqi?=
 =?us-ascii?Q?uaO3pPkvcvAjf5ihs5WceisjmIcujEsRf0JVBYQQ6pX822V/+O+kQlD4crZP?=
 =?us-ascii?Q?X5dpwfmeGWSpSmH0T/gJRJQIQ8E9LYuQqbPyZTjEIP3SbWgcuVjF4KED4sPY?=
 =?us-ascii?Q?k/GLVnRxBj9bl76E6QZDxEzW79KbVzX6IRWNYHDE+56Z0fbUTlkC1AQM6yUl?=
 =?us-ascii?Q?u6433tiX6rVUXsKHsP7xU3Db2wKgoEOZZycONG2oGpz/JQlX2zvQPI9uklvM?=
 =?us-ascii?Q?QNfD2hiAKj/CyDXzMBiOEXr6WyAZ5wofOi6Rro2ix6B3wYiRRecbFzwm6WgB?=
 =?us-ascii?Q?ki1gzMaiFWoy8IRTTU7DgnkZmtX3pzNR2XxquHQiODadT7nVSsH64OPym9td?=
 =?us-ascii?Q?8+iCT2soNLGuLo6JiZ9sy1R0OzRYpQaDkKef8pQEW7dChb5hc1IZaLpn4Zsv?=
 =?us-ascii?Q?ugGNjamiSog/pJ4bfUrADase/+maKe96aw7M+32kHGkN4aeZIIBhn0KiQg6F?=
 =?us-ascii?Q?MLKv1PSGpJtyXqkxNZ2/xxYnxau0eaQwZEYE0Iopnq4/3wSJK+gMIXfhIuS6?=
 =?us-ascii?Q?zg/oONxxV2OuCsUgyoQly/znxuSla7GK8kzQCin8Dwl1P+a2P67NoliCEc6X?=
 =?us-ascii?Q?eZ0JpsgBlbxQ+6J8EpVUpgZ/1NQoaLKFN2uTp4elR8w4aqD3VqJNcdQpVNKR?=
 =?us-ascii?Q?SkigvyI/UPz19koWB4DXq1jjQ/ixgU+GpBVs1FvGAWoOGrao3KmkVX8zqmc3?=
 =?us-ascii?Q?FRYqzS9UzySGFLRCEyDaRuDgeWSPzbk3i1mliRYV7D6XL9tiXX6c7Kp5z1yc?=
 =?us-ascii?Q?2p1Qp1f8eWMeK0w8C6V+UzvNXs0GaPfiLYDpdWJ8jN+ytrhgz1ndAvVJfySb?=
 =?us-ascii?Q?W9wtNonklF184gjQUOTjDG1KJx3b5wh+bKlNfe+6uiYyQHp8FGT5e4Me/Qo0?=
 =?us-ascii?Q?QiMq3d3Ib7sDiMJbleiqMW1iS5T1+1JL9QSCAFlJNEdCoZTlemtKHh0mpWY4?=
 =?us-ascii?Q?72uO9dC9wIxyk9lt70MVcTfD6SgSu2MijhTYOmYum+Ne3u+kTYzxJmN+1olk?=
 =?us-ascii?Q?zB3Diiqig1lZlkLQ3o6EgMXYrO9XoXEEdxYGxWoE7EzklBAL80OOkC+SZwaz?=
 =?us-ascii?Q?H6ukn+KVncP3R4r33dy2lcPp6c95JBD5okhe2wVPV+485K/3GRomIlGflskz?=
 =?us-ascii?Q?911dHQeGxv8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OpBqSNIZqe8QE5AEDkBk/MXY2FixT2E0BlEyIkxbhRWYorJRvIJsPyDI9rgF?=
 =?us-ascii?Q?v28f3Q/aNQWPDn3E2Vp/+lTGVQxarVTGZeRgFMMXGwPo7HqbqwawUzF7zzvo?=
 =?us-ascii?Q?Eb6wnXMHqRMSmqrIg++y5xBjrMH0g76mEe4+9yQCjCywaYY/KeQ6heawGD7c?=
 =?us-ascii?Q?7GRb+kwLHgIUinEauPzNppojYWak1cX/DJisHpGOVe5Sq07uQpS4bUoXeyae?=
 =?us-ascii?Q?Cdi2zhvmHMbvUfNZMffp7xNuzX60wNxC8bGlF/2Emr0bUcvGhmg592Phi+7x?=
 =?us-ascii?Q?KJHqH85t7t59j0rQ09Kin47j3Nt3kXmyF1PZMlBc8xCzkLVvZhJ6nLSRx6gI?=
 =?us-ascii?Q?7rylxAO618s7Ez4qv61fXqjt+2yoMgTL79gomiigtIYvgCW/Gp1pQU3WO7As?=
 =?us-ascii?Q?Xbv0bqgNaFQNKk/A2oJVjZOSU5UVAqflefBcM6L0UdF0no5rq9ZHssu94N/o?=
 =?us-ascii?Q?1Ntd6x5lsQEcXUn8fFlA4HBXDWN/rZxOlR1utM6KGDmb8zr5xHCZ0LGEHM9P?=
 =?us-ascii?Q?2qDwrQemNn2skeX07bnIckhr9u/cFGGLsjrEhIyq9s7exMvkoLuswg1uXpD3?=
 =?us-ascii?Q?pK5fP3YNQH22INA3JgGUyIiWVI9vXRwa9Ls6yf/9VLjb/iWABaboXbUgDXbf?=
 =?us-ascii?Q?E/H7LTQhMn4dgx2o0hwBgymVxm1yz28x4ZynMI/RRDc4KKP1OudHNkSjnqew?=
 =?us-ascii?Q?uwdCimwjQHVEMr7auZ7PUwwG0AQyoDG8POkddZ4juLX4HZLB0qXDU6apnFjC?=
 =?us-ascii?Q?ACycBj/u0rCMic/1VjCWpULbVOGWskbcVqsX0xyWhfQfniFzgsM9xjdrmdkA?=
 =?us-ascii?Q?xrCrPc6agprDJWDG3cmLYLkIxUNlspBLfxxeEsVI/d3dawg3fPceKTZ8lO1H?=
 =?us-ascii?Q?oK+KMNZT68zdlwWcLM7HBWlKGDVOKu7rk2y/YW1RUNgS9ReNYhRD6ZadYTLH?=
 =?us-ascii?Q?Qw1iaLL+r7NjAIV6hU5yzKxtpvQrHgmUgHD/FAjddGFMPHngUi1n436y87PD?=
 =?us-ascii?Q?WMmNA5ZpEESMIoDhBVLlrHdnOBxOdWXeKAZOvnnE2PQU63OzbB4cAQzKF9QZ?=
 =?us-ascii?Q?c3b7d8gOzirm28HAnClbVf8N6ESQFLknfBhSwuqzqZePweaf6hXhbnLMMp96?=
 =?us-ascii?Q?D1Ajp9kHsJHnCmYujPedrpf6JaQh9BdzX45n1heTtE6C8VpoKZJXUqHXJhz8?=
 =?us-ascii?Q?kw+PYCxlQw0q5CeHdcsOi3YRgCHX/TY+Qvv+Ik9Ogn1XWwI544ae2RQpKNZY?=
 =?us-ascii?Q?ytAOcqVYVjKTFGyjAb9YtwCXkJ4G2a6syDMTrc5iMx2SRGX/m/+0xYWyx/Hw?=
 =?us-ascii?Q?c+MQIYpnhokxL9c2AmfT+kngwu2BMIzrvMVGpbQhijtoBkRzEyAmtMGtAAC+?=
 =?us-ascii?Q?T8Civ8Qp0iEtLH3PGERtQDviNXt/4F75oNLfiE/YDIkjPsq+ki2sA32mK4k7?=
 =?us-ascii?Q?hMNbq6q6KFqoeUZqaHX8xLDxGCygrUezoOsUt6TqfelOz7aCwrgPzz5iH1yb?=
 =?us-ascii?Q?xI5k1xFvbh5A6kGynHfqgmUqSXHM93hk/cEhfnr+J/PqmzcJKfrEV35Ai17R?=
 =?us-ascii?Q?nKu/VnOgZiHKBm6PNwxUyzAiQAQVB6cw6DrR28d50325n2Txwui8qWn+vpgN?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f989e74-8fa3-4430-2b83-08dd9ef32212
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:55:24.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS9h3nCInap+7qCVa8BzUbjqXkYvAfhPoI5r+SwOv9mo+HCTIABVpdzJ4m3jNz0B8FZfdVejq0+jc0MYoIRN0Fc9MZZTMyarg0SpwePwkXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5EA507B64
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> mutex_lock_io() differs from mutex_lock() in that it may call
> io_schedule() when a task must sleep waiting for the lock. This
> distinction only makes sense in block I/O or memory reclaim paths,
> where giving I/O a chance to make progress is useful.
> 
> At this call site, cxl_pci_mbox_send(), the mutex protects an MMIO
> mailbox. The task holding the lock is not blocking I/O progress, so
> calling io_schedule(), as mutex_lock_io() may do, has no practical
> effect.
> 
> Although there is no functional change, using the correct locking
> primitive, that more accurately reflects the semantics and intended
> use of the lock, improves code clarity and avoids misleading readers
> and tools.
> 
> Reported-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Closes: https://lore.kernel.org/linux-cxl/0d2af1e8-7f1b-438c-a090-fd366c8c63e0@oracle.com/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Looks good to me, I would suggest that Dave drop the Fixes: tag on applying
since there is no need to backport this.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
