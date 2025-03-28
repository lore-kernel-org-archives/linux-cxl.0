Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92514D70E;
	Fri, 28 Mar 2025 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743205242; cv=fail; b=PoSv5KBG4p8Fns7Uf9Esg+9RHTw4AiJWqrX7coZoJM8DxV70r27I5fFXByqIXLYEpaVpgMhIQ7LGjPY/htwGQl+1JfPtja5cdGeUzS/NyAyIoZpwL8PBI0t/cKmebMU4HOwlWDModOngs3JP69bvSQOOJa6pB3M7oU+1wmLWgas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743205242; c=relaxed/simple;
	bh=3dQu0PjCwCFCaHGvkHlYbvl2aH0+hcaLttjBXPl6iac=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=owzLvnLDCaX7sIliB8xui9amrFcILJhdU6SsdOP9VBkVKz1cSD+7MCaQ3VtsX1Sj7Z3Dsw/jsz9DvWsx6A6rQ48d1aKQWfyAJBqpO2BhGC7IldLEyn/N3DNUY2NmDF/9BvGTkk6EIEia3kwfdxX8Ze/CrVBifAKVp9FOiE0Ebcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKqJbsml; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKqJbsml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743205241; x=1774741241;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3dQu0PjCwCFCaHGvkHlYbvl2aH0+hcaLttjBXPl6iac=;
  b=jKqJbsmlyZ5eK6Y2D9ADrkTutjJIe5J5FY+mQnVYon6UOjStUmAzz03H
   5nVy7whTduIe3w7PytJx+coIM6eEm2KZlYM/0ussJCXOWBGQc0Fxi2Zpr
   nqNVDFZXrZByv5LcwRXNTS03eebI26+s6ajF6NIIXWsfed0i+cCjfVI+Z
   9eo2ufB8CCAxHJOrV9TZoV2SHKWvkWBYeT6UstYDckvJ/f3bl68pqZHsh
   tF8LqdIXeazSvYf98W9kQvMrhICwETI7uFrfUPCOn26yLgCqY8QTwMR0j
   46mQU7N9shi/L+vDBOdz1miVp6czH16oMv7xMdD2BykxCjmsyhQJql/o7
   w==;
X-CSE-ConnectionGUID: IZsC3SLvRQei/EVU8q0WDA==
X-CSE-MsgGUID: SvcKqMJWTwWCcsRthqmyng==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44681132"
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="44681132"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 16:40:40 -0700
X-CSE-ConnectionGUID: sjEdlKP6R/+dUs+DaouzdA==
X-CSE-MsgGUID: PA6osfxSSHa3LtwYEvaZyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="130675877"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 16:40:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 16:40:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 16:40:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 16:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNgNli0mJPoSQrzuhq/jqWMI5hyusZ4+RgCIDZkZsEcJN8mT66G7d6SFiDjP8jqgH04jr/1Dha+z0JBAdaMz03L7DQn2CM6JU14swuuIGrgkRl3fj8Yp1W6hZOoKeZtl1//qTjbUm3Cp8ucYV56whiJcTEwqRjV9B89hBHo3g4wiKPi929DbXvefVkHXpsaYoNoPaA2DjjucxLHlIx6qdbVUgPrCyI1aN40kmrs2805fIeXDfkXY5mxfILreOU4Fejexri7upbguoKAK2at8rgZcbv6U9vPPDLS1Svqc/MRjgBo1BFPW5kssi05sv8Y5SoMaqN7bAqA6avTA7EYWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbPeKpGMj0QCygsRJqIXg3ko+6WMT7TTMFzKQQqRNPY=;
 b=HF/bNcMtFvZYTFIsO9BOvL8dMdJEvgKKFsIr1CLS5mhKfTakrLAU3d5BlLBLn4qPLvVkUcq3EhVBakOXSn6fp/62EKuo94MdfjPp1exDJN0r0LXyJyXorXwJQ8wPWO5vXD2B4SfzhXQ/tOAh1nDHsymoiIUQTK6FH3h7Y9oCeuUGYAWU5dxtZj7D501+xQsQwP6AqqSjJt2MNyvHKbaxnL1xIsQrwXdNh84gb1viaJGKqewTr0jFa0a4F4cN1V6u5bUXLrl8tQsCJTZVvEjiUwq7M6np4Ttv8PXMI7mrNQBXCedseeMO3etrs+SbsGZdAwp/7B5HB2KRYXkWocUguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6993.namprd11.prod.outlook.com (2603:10b6:806:2ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 23:40:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 23:40:37 +0000
Date: Fri, 28 Mar 2025 16:40:34 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <ming.li@zohomail.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH 2/4 v3] cxl/core: Add helpers to detect Low memory Holes
 on x86
Message-ID: <67e73372737bf_201f0294e8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-3-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW2PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:302:1::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fc0ad9-4a1d-49e1-c7f2-08dd6e51f0cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TAx98muNSuGAtHkhCOZGTGNGLF9c5ya2yUYDVNMfILg3f9EbABRPDaKQzE05?=
 =?us-ascii?Q?tXmcyiWvmNYpVn3/ek00LaaHVd1OEUX7csbSy1SYG/BWO0gW1Oh9J5dwqD/e?=
 =?us-ascii?Q?5zzDUEXhW2mei4ZI0rcg7RIR+kwnG9KjJGMgj1t8eUaOBBUH4ooK1M5Du8bN?=
 =?us-ascii?Q?elCQYBroR3O6ZEcqehl79DvN3ehvb9t9MkWydGkpQDUgBzqaXUjOBIoiHjTt?=
 =?us-ascii?Q?oGw01bswF7Rjh515kllr10BrpLM1qnTfobwStNrAJjC1YsoPfwgvqen+Udh7?=
 =?us-ascii?Q?pz6M/6LnRhjgIpzd/IEjAl/1fgUrkSSIpX1NjhTG9CtnZWjH5z6cFODZthDc?=
 =?us-ascii?Q?eteeErdjO+5SQytSEKVw+lJIpzmsvnF3c70bqN8qx8BKD8TYsYwq2zygcn31?=
 =?us-ascii?Q?hxGPLtVluZOR/C0UrSiTBDnflDTebYoVUcrt65OhRGCPYrhLyPLRPXmg3g46?=
 =?us-ascii?Q?w6wXItRH013GUMJ8Ye5pPKubzdUuWua6VpSThioNPDPq0nxOwM7lKjDW1g9B?=
 =?us-ascii?Q?yzS1I6UQfmggXY+i3XVhRfP8tyCczyQA8S31e42ZfMvDvYVhYyDdA0Auykf3?=
 =?us-ascii?Q?7R31okgCrFCGesMjt8Mxcm5h3K08YgJnxilwFYaj2x5HvLPSS/+K6olkTewA?=
 =?us-ascii?Q?DfWMaLx5Ur5ELfHpqLp4OYh0oJd/+bGRO1QuMyojxTcugvlLYbhRAEpj05vu?=
 =?us-ascii?Q?8w1A2yP9M0qhs0e7MrN5/QR0S94nqzDsY5wIXcp0WugCR8cwQOGh/MJg8hXn?=
 =?us-ascii?Q?M0UVU+0pI5wfNMSZSJzGGaGamT5ki7gTUU6MNOyVPHc1iDtSYnCfoiNVpCkl?=
 =?us-ascii?Q?grkLPP3ZFisol+vRAEDG+Z+/quaZ3wqS9r0lZgjMPU1i9lqGEOxw/MpfpOBK?=
 =?us-ascii?Q?44adqpgueQ3VJP/GD3mScxhqnKzVkyoUHVIS0XfDnCpV8uvrym2csLWE53zA?=
 =?us-ascii?Q?dNNUFg2b5B8cJWEXeHPzziRRxZJX4BeLpKc/CvhzZuds6pe/9byJWe6ngvFt?=
 =?us-ascii?Q?iauWZNihJqE2mY58w1vuIOgMefsH4ztBiIsr2LIOGOm6YL9MlwtGp+o95heL?=
 =?us-ascii?Q?0hvLeYRXqVMQ5k0AQliCu8vPoOCTqgA6fCT0OblBCYfKtFraFXJVNxB1MqiJ?=
 =?us-ascii?Q?rBY0tzMhI/eYWS0L1Y9830qdp/M2IbgDI+531kSA4RL/tOttI3Tksq0noVBz?=
 =?us-ascii?Q?Dx8PthOvyGJ4gzsmaUh73351bV9YZz9GsOF2vvR8S0/2TK2WYpsdD/3dZq1a?=
 =?us-ascii?Q?YbXP17ED+H41wzZupdScPPAK0XcOEMh/IqJvT4gmYzEBLeVkavQ4+QKY/6W+?=
 =?us-ascii?Q?V/x7/54/1FdpzszU4NyycT8VByg/opxt/hx4ivNahMYTiojvJ48JKxYWgFt3?=
 =?us-ascii?Q?4I3ymGHlV1aD1Yv8jmkVNh6BZ3ks?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3pKeC0JUc2FL6fJIzIpxPvZ86QgcosQLv1lyrk2r5AyzDx4EBL4ii8a0e5MF?=
 =?us-ascii?Q?QCl6iQGtUC2G7KxfmhkaSYGJ2wkppKQc70i5oMtiuR4QI1etxeQO4SyWd3iA?=
 =?us-ascii?Q?I7p232znKMXJgyR5t6L/R+Kon8kabXEnI5RJ7HIzENUiDZYENM1+cUuQp58A?=
 =?us-ascii?Q?t0g9fENO6M1F1KMphAsb+6yVsTgTbyAFGwVwWqnK03e9Rwen6qwqFF3G4W9h?=
 =?us-ascii?Q?d5REByMUMLM0fjQYdzE2IwdQUEdXJxdyiNYhPAsxTHqMHKUVEH502Nx4x40y?=
 =?us-ascii?Q?LI7ifh7kM5rL8l/9gtHltGPBqnj4eDQxxe7mk2Y9Sa4vgVPlmvS77RHh9K1P?=
 =?us-ascii?Q?ZUw0mgd23dp9XZwSnk9lEyoXjhAKoHbaXaj1/OvBRBU29gDDor5qGYDnZUfd?=
 =?us-ascii?Q?jW8hml6G+WfOYXi6kTRliAhjktFZQd9JO/moTg08tL1MJMWwaFtr15zdZSmx?=
 =?us-ascii?Q?E0m8u4jfVHXGcwpQVug0gOWrmud9TrcjPjrs4P5DYqsgf3whtL6np2ytDbtc?=
 =?us-ascii?Q?YXPHvz6br/LtTxb8VmKHHdCfoOp0gLodqyXhBymKnT+YCLPlYQqW0ap85AtF?=
 =?us-ascii?Q?2mi8yQe9RMdYkbtZkLXu1wA6ZK0cN2BeScxTZNfo4KPoRDJaNWPu2lWs1LQJ?=
 =?us-ascii?Q?nO7Z5RuSez5goFNQ9Whjb8rqEdcN2vzMKmWs+wEmp533auMTQz3Qqrx6RtC2?=
 =?us-ascii?Q?WP4kWfkK+YLJ3nR7InuLGmZfm7Hqkth1mQH1j8j7mmTvBwSiAG77TKPodVKT?=
 =?us-ascii?Q?SvnMANGxxVlV1xACFB5Eir8U2HaJKvWzi2vyurAXgqQm8cYsFmgW0j0fmDlw?=
 =?us-ascii?Q?MO8fkTi/v3NARQyO2lRvZJOf82Ga2ThTEJU64+NznJ/OnsBbIiI3iLv4bJIU?=
 =?us-ascii?Q?CWqYUbrQ2RJjOUPUM7ED8hhIBsLxLlTIm+N25EdoBsE56+HRQLrN0oEybhV/?=
 =?us-ascii?Q?CfeE7PzoGnEnN+qmYcoYPqH9GiTAuYlkfM8/TxEAer5ARcZ2VXZYMUdZet9Z?=
 =?us-ascii?Q?Agdz2YXVMlPPHiFntNHm7a/TeqZw4CgpEVh3bVI1gR/f7/ccE+6pkvXJ6cYQ?=
 =?us-ascii?Q?Vx2/HqRa1JKBetHiqRGVGcPo02eI2shxffFclPKp+QLWn9Zl6TRbqYKXRkid?=
 =?us-ascii?Q?y60vXQp7gDPb4+Rvmfen5w0cZN06IlGxA0Pl1MQtEePdUgT17Ca5mCwhlqIu?=
 =?us-ascii?Q?UMV/N/R9ACmzgfTWjjTXJi8pfxPv0k1w7a/ZMmo3/T258G5yUAQB7y11qHXJ?=
 =?us-ascii?Q?kFAEk1F+6GePnU3R/lFxU4g9R1Ipu/U44QFG3rvR3lTLW9afeS/J7p02o9CS?=
 =?us-ascii?Q?DdqNOnX38RdEUzcSyxF2eZMW0iqiw/gMDRhnOWZ9cp8g8fB5J5iKQEhBI30z?=
 =?us-ascii?Q?cndoR22E/HGgZNgzQRvz4OnYhWaTOYZEZzSvC6TrXKZY4Z4Fr+RBzkp25A4G?=
 =?us-ascii?Q?MkWUHvOn6xD0xuSoG9StNyvkpPZpicMm7ixnd3vwjFGwmuQKT9q/ASl70m1U?=
 =?us-ascii?Q?M0BNdsCy+IFKB1Wx3vV5IHT5jZ2Zd1VMVA5ayWl4ypnSrIn5G9b03XY+I6Qh?=
 =?us-ascii?Q?KgPgGK1t5lCrYIerlEPIqWvNsE20cLDXxBiaSY9qO0BwcJLxixJlBaUHBNRU?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fc0ad9-4a1d-49e1-c7f2-08dd6e51f0cc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 23:40:36.9716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B56wTfWtXJwB7N5Wv1HOqRB6+cA5xLF+Ke6XZvzZT3cuSTIjjOCGSokZu55ke0CAe7bRZvixhQABL13I2HgZ5Ia51PiNg3wd/wovh0iUrYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6993
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> In x86 with Low memory Hole, the BIOS may publishes CFMWS that describe
> SPA ranges which are subsets of the corresponding CXL Endpoint Decoders
> HPA's because the CFMWS never intersects LMH's while EP Decoders HPA's
> ranges are always guaranteed to align to the NIW * 256M rule.
> 
> In order to construct Regions and attach Decoders, the driver needs to
> match Root Decoders and Regions with Endpoint Decoders, but it fails and
> the entire process returns errors because it doesn't expect to deal with
> SPA range lengths smaller than corresponding HPA's.
> 
> Introduce functions that indirectly detect x86 LMH's by comparing SPA's
> with corresponding HPA's. They will be used in the process of Regions
> creation and Endpoint attachments to prevent driver failures in a few
> steps of the above-mentioned process.
> 
> The helpers return true when HPA/SPA misalignments are detected under
> specific conditions: both the SPA and HPA ranges must start at
> LMH_CFMWS_RANGE_START (that in x86 with LMH's is 0x0), SPA range sizes
> be less than HPA's, SPA's range's size be less than 4G, HPA's size be
> aligned to the NIW * 256M rule.
> 
> Also introduce a function to adjust the range end of the Regions to be
> created on x86 with LMH's.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/lmh.c | 56 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/lmh.h | 29 ++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 drivers/cxl/core/lmh.c
>  create mode 100644 drivers/cxl/core/lmh.h
> 
> diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> new file mode 100644
> index 000000000000..2e32f867eb94
> --- /dev/null
> +++ b/drivers/cxl/core/lmh.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/range.h>
> +#include "lmh.h"
> +
> +/* Start of CFMWS range that end before x86 Low Memory Holes */
> +#define LMH_CFMWS_RANGE_START 0x0ULL
> +
> +/*
> + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
> + *
> + * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
> + * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
> + * the given endpoint decoder HPA range size is always expected aligned and
> + * also larger than that of the matching root decoder. If there are LMH's,
> + * the root decoder range end is always less than SZ_4G.
> + */
> +bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
> +		    const struct cxl_endpoint_decoder *cxled)
> +{
> +	const struct range *r1, *r2;
> +	int niw;
> +
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +	niw = cxled->cxld.interleave_ways;
> +
> +	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
> +	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
> +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> +		return true;
> +
> +	return false;
> +}
> +
> +/* Similar to arch_match_spa(), it matches regions and decoders */
> +bool arch_match_region(const struct cxl_region_params *p,
> +		       const struct cxl_decoder *cxld)
> +{
> +	const struct range *r = &cxld->hpa_range;
> +	const struct resource *res = p->res;
> +	int niw = cxld->interleave_ways;
> +
> +	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
> +	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
> +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> +		return true;
> +
> +	return false;
> +}
> +
> +void arch_adjust_region_resource(struct resource *res,
> +				 struct cxl_root_decoder *cxlrd)
> +{
> +	res->end = cxlrd->res->end;
> +}
> diff --git a/drivers/cxl/core/lmh.h b/drivers/cxl/core/lmh.h
> new file mode 100644
> index 000000000000..16746ceac1ed
> --- /dev/null
> +++ b/drivers/cxl/core/lmh.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include "cxl.h"
> +
> +#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
> +bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
> +		    const struct cxl_endpoint_decoder *cxled);
> +bool arch_match_region(const struct cxl_region_params *p,
> +		       const struct cxl_decoder *cxld);
> +void arch_adjust_region_resource(struct resource *res,
> +				 struct cxl_root_decoder *cxlrd);
> +#else
> +static bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +			   struct cxl_endpoint_decoder *cxled)
> +{
> +	return false;

I would have expected the default match routines to do the default
matching, not return false.

This can document the common expectation on architectures that do not
need to account for decoders not aligning to window boundaries due to
holes.
