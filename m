Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AEF4DE733;
	Wed, 16 Sep 2026 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591764; cv=fail; b=UNWoZ1sWEmanNrZu5dUrz3a4+nroSU/Z1V0SdQ9fQ3iytPBMD1zid/U2Tz8dQp30TreoQrZPoTC5mLdiekvtD3kjsCjtVdVn2Z2+HXNU/soRD/A6ol4fVUOd7S/HDp5qzI26uFFvYppXQxDM2WP6kq3lIJJWmnhAXIOSkno/OyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591764; c=relaxed/simple;
	bh=/jz83Lecyz/BhlyBZMq8RNBtA2ro+D/rzDqtW+NRyT4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eftwcUWB2EADknxgAJWxcaqZxvfdk0sIvVM3kfNGWdPpc2cQrDirX4jxXgYWiXi03oxiQ/8GbwHjYsOGQ1s/zbyHCg+tETqBDpiENzsBZrnVUoU7f8IRGYcFka+brh1PdsRgpK0LJygb/QuDjvfj1UyKpQrG8fPMZs8sFXQchcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kr0WZIWh; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kr0WZIWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789591753; x=1821127753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/jz83Lecyz/BhlyBZMq8RNBtA2ro+D/rzDqtW+NRyT4=;
  b=Kr0WZIWhA5o/EkK44gbXWJDaBxnGTKYzVC6/kpsYIKa1rYThB2NoiPR6
   KqSw5Sd6++fjrJBigIuoanMxCi9VbAMzsvi1HfcbqjtmL8IXpirsMeS7s
   UXLLeAxGPEcPzWy3eBW13GS7/Q5CQTcSaudDEl4kEmEMx9Z89Py829SN4
   THCRA6fh7+F67ip75gYQcv6aUFKCZfhVHZZ5AaCZYs4b8m4iJXPxef3GG
   JJoq2REErM/uJcgZ7t4sOsJ1o38G4nWHkb1bfHdC3dVjwqoVdvwy29cSS
   odncg+UmOeyGFZUbYDdVEQamvkXiC3rvWdHFahpMxKDek0MPlLRfAW+q4
   w==;
X-CSE-ConnectionGUID: vDB2eU+qSsabmTwLaj0m3Q==
X-CSE-MsgGUID: uoz+xI9KRYuz+sBF+nBoCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="486929"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="486929"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 13:49:10 -0700
X-CSE-ConnectionGUID: bnE3NaSBQRern5RVfxrzdg==
X-CSE-MsgGUID: V5ahPet1S/SxcZynBoQNvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273969058"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 13:49:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 13:49:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 13:49:08 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 13:49:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idPKNFtkbsvvvNYBoRxw7O845rO7Il44A0QEJEobbWjO7Uoi6Rod6u5CEPVQurFnbb4LGz76ymvQHzERYNpyhRH1JWS3mfx9tG/cqJTcAgYPFXg2K/c4mvc35spsi7hyEl12yQQrmH2G+ehroWd5S6EnTI41XMkyCiXSvDieMaNF6c5AAg+cVqfV3gAYJgjebbpSXfgWYqkRntjkb9n99VMMGVFgglhtGpr2GrZW4JAMqKVsEJIv5roohjr2C5aE/CT2lZ2Tx9RfHf/yhMbBswl1SRUIHxUSqR56v1f9/GIuTg8mmayvvfadwtNLOvVqnmPw3D23YwumiANthpAc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZryuLgbFlIeqAXl6NppnhvJtYKsbQ2/eJ+55Gbw9DG0=;
 b=WO9OR/JYJODkbu2Pm3CjjUg13BJbcxJg9SfA2g8R0bXkhnyFVIuCJ4sDW0XWSGAzUJaOWxExfzIiLCDUS+K4LqmDVi9BJMy7GHkgexeKXzmVDAehRT3ccBHo0xIz4n1SpHcYtZziook0+GbxTO9T5B/wUPZtjBz7CD/PVNQW2T4wjsjlV5AT6UMFyDLC5sY0osYnLGG2yFuQt/1bWoU1PjC+VOwT1RacReFStvMfKOp5X6x4QhNF/QfphfWpIuEz++JA38qVl1AsK9/V4EdPwQZ6ZPyIBtHLoz8IBn2gukBdqrXCS7JUGrFM10B0akG+bUSQ8aDAYzLOuSz/qP+2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PR11MB9601.namprd11.prod.outlook.com (2603:10b6:8:34a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 20:49:05 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 20:49:05 +0000
Date: Wed, 16 Sep 2026 13:49:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <anisa.su887@gmail.com>, <benjamin.cheatham@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/events: Return IRQ_NONE when no event is pending
Message-ID: <aqsAvLwDi62t9IXI@aschofie-mobl2.lan>
References: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
X-ClientProxiedBy: PH7P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PR11MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0ce2b8-60d2-4608-0c07-08df1433f28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: r2Tl87cAcuFeIMjnvA6KFAiT2u1eRrIsLh5vrEgGzzSXYR6UNZ05QUFZALBj3eyrlcL4gTHR0hGnkfgbc547/f6GHYKtNZDJZ2XoYqn7jeXZ/KrXyanUvaHmjaST7MY3YAfHnBFlKXVg35pwBygLZ/xRznZ0oTJXjSZ/CXKZXs9+CaE5166JrDPis6P45C59Eds43o44VYZRToN1NW6N5z/KnAOb9mJt+5i8jY2LGzIEPPMCtBW2WckxZTJQ4mgAHM1uiIwsReEDKFa41wKAqrGxmal2xQ5H4GTP68FIEGx6UpBznSItyw5z+K6G5CkfVdoyjY2oMxxgaZaiMYxaf8RIazy05AkEozBeur09q91fntAUgw/DVs+SV1M6hFfd91tM1hzTBHjQ/Pz4G9popiXqKctJSTcNPzFpj9OKhYM/YIdqAe6cxzw1i6TFrR5IBm4ofjczjInMo/omEdpm7O/DmdnrpF6xwSlgNjO01LCMwwRLAEKiq61pmMn7wwxmc+JkKb9p+tpOTN6/Stok6Qq6rDHTNr3k5fN6Z/6XCnVlCZYZGstle/hIxYTiOJf0FsbKIyfRstV4ti7mreNcXtyCVczmcZfTUMI/oPPrP9z8KDVP9B4N32nSSGaGBMEZrmaUTRFQj9QAJUYBqqy6+BCtZxBgKZRhPSVT9U21m3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cnF1dLFoGwPxIxsQ+ru6Wshk1nJhp+CeEOkWCN9ESamR/N/W3ymakx1WUahl?=
 =?us-ascii?Q?0/f8wiwxkEyNXsA20JhFrZBfDOFUu9TF5qtOXzhpEC42YtC6zkVUCuSSx7Is?=
 =?us-ascii?Q?9gAAUOsmKEkDfkbgCMLKjwBe3SWyG+ZPUQG6E1Eid70M0DpjGK/Ec6KKfFQL?=
 =?us-ascii?Q?c6Lgo2QB2O9/XtxSfuzczL3bsMFYhR4UUcFbCHxXKShTpNLxlISAg3ZdTQJr?=
 =?us-ascii?Q?F4Z0wPgt0s9DU/qy4T4/IEY2+gSwDZPKNOHOoDTMYBJlSUY5s7/RhIyNEX87?=
 =?us-ascii?Q?kYXG4yaSRZPUyX9FRUbD7Ebc+mLy3v0WP5yENO73hYf8xcfK62S4ym0UvwUd?=
 =?us-ascii?Q?Vr/c9L83b6Yz3NgHoNoJJOcCi4oKZG85OC/8TBoV/xUbtrSCVuwgzmslrxXM?=
 =?us-ascii?Q?vrP/oMHZlR5Znjp5IVGLFidzezQjyYqZat/cQUUVERI+yNMMX4EK2fwNiNzC?=
 =?us-ascii?Q?V++/9sGHSKvxfwCHfVB7liANhVKdU7FKl2U1Cgav8lDNHA5AzWZmyZsE47/P?=
 =?us-ascii?Q?t7j2DViAU6lxEQ5pr5o0/HGL7LOZSO6oC206lbyA7/DOYfvrc1mSHbNKEQ6C?=
 =?us-ascii?Q?wgA1amYy2VcYx9l0RDNhP0AIi1nJKdZPbC9G+lWvG5y4RJGFH7Nn611a6p/S?=
 =?us-ascii?Q?2GbyDMWe9lhjHIPd5U0MyBNB2j4zHrtpWlWRwoTqdhAOwcz6Fh4vL9CDE/tp?=
 =?us-ascii?Q?sC1jEq1T3UAYZhP1t0TDYrG5WtLm9lgecWrJRzdLzk4jIlOoEOd6ynOjCG6h?=
 =?us-ascii?Q?94Ue+fLngBrznf3zlBEJACL4azdcYKqeB6aMoVqHgu62z5Ikkq4GnAp/S3V0?=
 =?us-ascii?Q?eZFBGF6D4uXEPhdD2KJZxbM6S/mfbtdo5AKGOzPu6gLN+Rs3f696pBanyVNs?=
 =?us-ascii?Q?q6efOe/FIpqEQ0TDGOlt/3gHWf6f2raHmRmtx00tnSMb5w6DfTdF9xrLfh+n?=
 =?us-ascii?Q?4IKRtq6SFi8QBU0tiAX2Dvad82VFoRcf8uLi8pm81gNcNyllt9mCHiVlZdyk?=
 =?us-ascii?Q?t4mOeCzeVVTyWQm8mJD+q8QkoWaHaWYEyJ28RI/4tRa1uR43n0vS8STKGQjR?=
 =?us-ascii?Q?TvF0SxBR/dKhxcGcX6fPF+S5HyWkBVbE9FRytw7Hss+1XiOjdTo2NYSE/bkx?=
 =?us-ascii?Q?x8M8BxI14xFZPHFaRpock851PtNDm6pOocVjAHRCPmBOi9P5jUlNgY5uGbOn?=
 =?us-ascii?Q?v/XvkwnHGZwdU7cHSbGj2W8O4U5E9u6MXsV/B3f9KGEwUkIVIBr1UnxqfY0G?=
 =?us-ascii?Q?A5V/4pljlrtpbpcD6SwCEDQoBO37qSHVdHekSUnNwkO44lythRaqc+wfa3y9?=
 =?us-ascii?Q?ZqbLr3ysXQA6CZx18cyKO/3kdmUUWwSw8vGU9MoZDL2bi+/9ch4OhhA9GChm?=
 =?us-ascii?Q?1dDR9SO8W6qIHvHdCQJUZ3nhNdDKTsx5mKKX8NoScd5hcLWhjic/al4Gxuw/?=
 =?us-ascii?Q?5qRp/RrcIAVHhfrvLheY+zzcP/ELA745ynx5A64cnJUcfcpq6Wo5Ozhr8BVB?=
 =?us-ascii?Q?u4H3YGjNfzdJIVtVh1IWohtmAdi0ThfLgqnlxuXvE2pWnl2noX9bsMhTnTiU?=
 =?us-ascii?Q?1Zu14eDT5uszlAcozpAZNzaEh4NIQ3qPt6trKdjDF+dTH/OgS4nYbsnr2s8X?=
 =?us-ascii?Q?be8PvcWQI76qGdsfdJPmDOfW1+yB/IQg9HmZ3gTG+8EV+n1P48nFCSebipuU?=
 =?us-ascii?Q?D8yf824ohKhWaSLDuDz89IGapXve77ZYwpDuKGqenrS52VVJpzMDfkpxe9GN?=
 =?us-ascii?Q?CeVW2F28R/1eghBuXFGOGirL7Cx+sts=3D?=
X-Exchange-RoutingPolicyChecked: fGIGTpRXicpB3cX8ncM7+ddRi7OWWncuzzdELhYr39Zk+jzZd5AS42CGFwLQgeZntGyVFBtBa0aJEQIfj+E9QXMtRbGplYRdFfwktDL2fFgibWQyLn0tYbPRR9aU0Su0eTvwL1id93eDYf61kWRxODUs7eElgYeRFRdsloT6RiSQoUIrZm324Tos6Ho0eo80yladEV09WMesfQDh1Xo9xehrikulzJ7P3zKDXE63la3Tvexo1B4Ie4P7ozC4f9rK+LmJlD9yEa6J+AFCpioVePNITSwFwVbzs8ezW228fh0bQd6OSzdQTvgpgMsaLPtBoRvDxrA1B2TRWHV1kMHWHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0ce2b8-60d2-4608-0c07-08df1433f28f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 20:49:05.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2f44qrMwIkWcv3vWAuHYu+4YMAAmBCECaoW9WS5/D7uFmK+600XBGheSxL25n2RNSIewjCflv3huNtoL/EFDZePOOQD+F9sC67JAFMYgyfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB9601
X-OriginatorOrg: intel.com

On Sat, Sep 12, 2026 at 03:08:15PM +0530, Shaikh Kamaluddin wrote:
> CXL event interrupts may share an MSI/MSI-X vector with other event
> logs or device features. Consequently, cxl_event_thread() is registered
> with IRQF_SHARED and must determine whether the event-log facility
> claimed the interrupt.
> 
> The handler masks the Device Event Status register to the event logs
> supported by the driver. However, when no supported status bit is set,
> it exits the processing loop and still returns IRQ_HANDLED. This
> incorrectly reports that the interrupt was claimed and prevents the
> generic spurious-interrupt detector from accounting it as unhandled.
> 
> Track whether the CXL event handler claimed the interrupt and return
> IRQ_NONE when no supported event is detected. If no handler sharing the
> vector claims a sustained interrupt storm, the generic spurious-
> interrupt detector can eventually identify and disable the affected
> IRQ.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

