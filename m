Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5242107;
	Sat, 14 Sep 2024 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726288409; cv=fail; b=B4yR2yMPx+JacAH+z0MGwYe5a0Le4Mo2ehg5HM4Xf0v+cWNT0Q51CqO2qBv62q3Eft8jayL3lWusu1LqVcLMCLWXWDhIy/GoqeI4mhpgWx/AizHSNzvm07x12+W0dJhw/VOxb3IzODornAq73XMPxnFVpUTip6Z0vD+nxkpD+ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726288409; c=relaxed/simple;
	bh=dfIvhLw3W0aTvl39coCC2vVmi3s73ZrpwMvXa47NpTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SGWXTaQySAO/UZNxpMwHrZ5YDcVy992CY9dZW9MCAopX1SMVoVKrY7QQBGi6+o4qqh+oNubLhZiMSh9snb6PexK6RYvbkIE/pgTQVm5XvqDJsFo2ip3fJz379zATxMrcv3nI7wqlaMXq5NCYictB5wu0Q1FkJU38Z8se1S2CAmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfZCtp7B; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfZCtp7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726288408; x=1757824408;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dfIvhLw3W0aTvl39coCC2vVmi3s73ZrpwMvXa47NpTc=;
  b=jfZCtp7BNjFAt3VbQKeU8mYphbVZu23GtZt7CbvvnTu1U6rSDqWauohj
   oVaSzhj/3b3t8Cb0UNibX1D7ZIx3CnYrzfSzjc5uufNAm1cXrTU+LGVTD
   oHHwv84WWRLt0AVfCiuxCSf5LsrFzNbvvnpxlYASfESKIwhMaR+6Vp54w
   yRo9wH9rMougUCzXYAKx/ocGvVPB+1DruFD3BfmlYT30FAxcsaKJaLxkX
   GddiVdIQHWN5dABBGsIQ400D77HZJMau7wUQj0gwjVc//lsRm7zh6tSKT
   w7mwGlMIrdG3uVtK1V+4H10fKbzfv3jzB+QcSAYBfL+yN562oa3Hm/LY7
   A==;
X-CSE-ConnectionGUID: gi5HhZNyQny8r2vSGdckag==
X-CSE-MsgGUID: bXLEG43IQM6b64Nx5iPpLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25025055"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="25025055"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 21:33:27 -0700
X-CSE-ConnectionGUID: XQcF/eLhRwKOPDQ1ScnwsA==
X-CSE-MsgGUID: mPtiDFR6REWkcjDNm2g+bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="73057715"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 21:33:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 21:33:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 21:33:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 21:33:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 21:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvIm4OaqMHckmHHvXi7ZchHHk/0dbBka45I4lrQcnzPCRTNEcBVI71NOe3lt5fYVWB208bOXnP0RnkKWpYqsOA4O0r5/SUqnuTxxI7FToqMyQ07uSx2m3Ffpx7MaSPey2k2CVgunM7tTMZryHunjyVvaI9Tz4tPWyCg4qs/qei+FnttR0Nro3XdVzEWWhYSuhiHdcsWO0cjZR9DR2fbAphGpi9w+7ddX79oPnPumap6OvDijN3t0LluR6tJhCGS9sASzM2NUXtLBpnq6oW2S/aNbnt1UD5RxeHRHxHkpVLm/yATI3izLQ/RLz4MeoQUwgHBIo+3gXzVhWiylokRVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbx27TqfxHQWG4RH88QKUakeqqGMeSOjgEaCEAq1hw8=;
 b=E8ZlpLAmwOfjOfvDc3JgCosul+nPM6kiTtOjck2JVkESIYWApLnv56gfsubfzFvUKmLSDXKyJ/5gY58f1WhcirLSVdUZkIvXePWZwYSPGReCglIJpauTT9dX+RIugw6USn4OBiWqEi5ScIp+cqqxQ7+R8op0SEkm4qz6iHfoTePmQ/rKY4xgZJ5TffpnDcLZBiN6O9sGUWcgL+Pn0xl2DhXMVbQt5DPrZeBRLU/7lBvEofQV6rTVAc8cVV/2VF5o18PlPv9wiPlnyrj0YY+DSLbt0iEgY+aIoVXAcLd7PYxL4AANzBfYDxuBaQQtK5mvkoFDNLIB+3/7Ej01m1j2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Sat, 14 Sep
 2024 04:33:19 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.7939.022; Sat, 14 Sep 2024
 04:33:18 +0000
Date: Fri, 13 Sep 2024 21:32:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>,
	<terry.bowman@amd.com>
Subject: Re: [PATCH] cxl/core/port: defer probe when memdev fails to find
 correct port
Message-ID: <66e511eff0c0d_ae212945a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240913183234.17302-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240913183234.17302-1-gourry@gourry.net>
X-ClientProxiedBy: MW4PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:303:dc::11) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ2PR11MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a97fcd-c9f7-4336-25d6-08dcd4765aff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WvKg0NykKDLw2VVB6JurN5al2ZhJMH6eHyJZc2vF05xF4VC8rZLnqzcnLX6I?=
 =?us-ascii?Q?jRiVMml9K3XyrYcCt+wGgeYz/J2WNyrDwiBAcDtrffDSX0+9cIaC80l9yYxS?=
 =?us-ascii?Q?h+KsvyLyPargNztskSnR7aWXrV/ejorI55E+Q4JM/60q3P49G7TN7XRbxaQy?=
 =?us-ascii?Q?AIHbgBkJebfMQ3ovfYmR4gXmr4nkWdPl9Rp2WEmh3Xff7HULzuNh6LtZInVU?=
 =?us-ascii?Q?1R6YlSVT/5/dIzHeeO4WPAKgpDVZmWNqJ8k+oLEYdri+EL96BqcRe79OtbRj?=
 =?us-ascii?Q?kVT6nAzi7EmVvYxOXPJ2+mKC4AhNLbXsxJIhUboKyGzTxHL0PY47hWrmGtX9?=
 =?us-ascii?Q?KtVZFg4PBKvqKTYb/uODraj0dEUbIDS2j1BPeLaFXumu3w4KDLcJ6qp4nkum?=
 =?us-ascii?Q?jTKKjfYChXZ9nH226+dDzxYpHD8pBa3NtMzmvCogQyDizhVARioPhFyB1LOW?=
 =?us-ascii?Q?XhB47V/jaYnThFdj9r71Jn7yfELxJJn81I0ROSO0kSS3k1woc+gr+Gl2DyFl?=
 =?us-ascii?Q?02Q0Dgb66hjB02szvou72t9fNC5kupe1l3qa4mtOyZikmV31vZN6JEB3T3NV?=
 =?us-ascii?Q?7DU0jhU39hH9wYt91VXbHvsEfec0Rf9oASNAO4Nrlf/uR5KG3Wjmf7nnPVLf?=
 =?us-ascii?Q?V9JJGpqwWfN7Y8u/t/Grp8w+YDrxDRP0Z3FEdAKsJPAZVCLp8Qy1405m3eSV?=
 =?us-ascii?Q?F3/zRWZE/y1zxlmJYQ0LYCBAbVBbhRl1I2OBcqzHJLEZxEO1lXCrHY0gvC5Y?=
 =?us-ascii?Q?ZjHubsF2ae+ZOXzIoYISFkBO0nad4E85945BAATU62N/goUulfTf/taEf/7x?=
 =?us-ascii?Q?xU0RIvJoYVu78m0BJn3Of8aVzpxZXd+Vgc6PrfoXGZ8pi4FuI7F7AMUoSc5N?=
 =?us-ascii?Q?gBtK86J9pPG9kwmbyahS7Sp0dUrPl7ipbkO7KOShxX55vo3bhJVuN/f3Q2Dn?=
 =?us-ascii?Q?+Ri2mMde7fehHXO/RACXAtzYOTdIGoGUU1V2PqXy9AhuM/41VqxHJXfqS2Wm?=
 =?us-ascii?Q?GAUiKFsX+NSA3gzOM6G/pFLTvbPBBOtsH2isLZxtkoOPyyuzUr7zaWPI9Yw9?=
 =?us-ascii?Q?yI2/gc/GoUkFL6YzLw2ESDESFDx7vMf4QCKdoqNAnXsuqLa1J0PYTNEX0V5a?=
 =?us-ascii?Q?WcjjZZf5rMmrxDjAXRgI3CWCPDk9Uoph3eyvU5leyK9ba/VI1oBvUt2+D5j8?=
 =?us-ascii?Q?3P06qko+E4Gsu7uBRRMh6ArzgA2jDCoWxCpLOhA3uA0v47k8hMJpmBQBkKuZ?=
 =?us-ascii?Q?t6P3mo8HXcGBn2HZPXYBAOtMbWfQb/P6RLrQuA3mwFe7dPO5yWB1PcYo8XcG?=
 =?us-ascii?Q?jgqksDOwf8jNUcaSzywFxnqYEY7hWpWdZ92pMSjBsEHLdw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ymOoddkFhDGvY2ubg2xKYqD6YFbNEReorjWI+1iKGBEDdRMpasY20NkP86w?=
 =?us-ascii?Q?ZltbyCx8a2ojByNDHcyQuNlsWhmYgkilVXrCKPnebJWwk5mNXc9k5dGmvONL?=
 =?us-ascii?Q?HTAYxbHDkirNFiSb6aZcbMp2dR1zyzYS13WH2iJWb3EdVgDOhdg11AalnswK?=
 =?us-ascii?Q?r/qsDHkd5iderhfusv3Km64+vXCRbh8ZmgPSXMEOTzm4DOsEmUmJ0PyKGMIy?=
 =?us-ascii?Q?/6tJ4+XswFNplZgEFmZOuG3oDPrNNWnCDTFG17syS5A5MAFb7TV5LllMEMOj?=
 =?us-ascii?Q?sHeFHc4T/xMpWbbZzdr0/oorigHTgUhsyqWW66OWF5JS+PAOnh3ygs02gPZF?=
 =?us-ascii?Q?7RT9pxX5WRaGCpD/roFgqWN2y4gnQyhO+WgfTlduGELGOm1r26KzbpD3AALh?=
 =?us-ascii?Q?HspGTp6cGBGUM9v84x4uBCP3FC8FbBZcjaG7JzpgXwwiMVwtMKa1YAssYnux?=
 =?us-ascii?Q?iu4/dtPOzjPyx/OJoo364umQ8Ktrifx/Kc6xYngpB0CDQe3yZnrZyA9H4qdL?=
 =?us-ascii?Q?X9LiGjKm7XJnIyseK5wLIU/o1SbR3bIqNZnAdeLnZ5NQ7oIeR6qc5iwFMPLT?=
 =?us-ascii?Q?zCC+ro4uvoOxqfy9JRLvuGl7SAtxNfhF1QUlHPWgOknBImxh8vaQGC7BorDT?=
 =?us-ascii?Q?Yug/ogzgwc1/A8tRyLiK57ApC2NsU462/O3/U8Lh3crKcq6V/S6Ntgcyxzqf?=
 =?us-ascii?Q?JEaVhfjLLBveZLOhysyfFL0MKkNcVN1MhfFE/RkSKdIHvOx0Ksqiy+qiaSQY?=
 =?us-ascii?Q?amK4Bdhh8iZvHQ3ThCQAd3LmBEZsxViFNZe44TEcxsHfrp5veFqtN4EW+8KC?=
 =?us-ascii?Q?3aBUUwNdnZ129jIaItlv4drpPOGF+5VlUfulTNiIwldlLdkxBy9VxuUb6uKD?=
 =?us-ascii?Q?CUDCgn/XgaqKbmORQLLYklG4XLV6IlIgmFFbTINDTI6gCY3sM9z1TkJwxmqK?=
 =?us-ascii?Q?hHiwkQ90QElcdz3R4M4rLW3s7QEHLtQ7y3DywW6BqpJXIcDhS3R8chpiCAvE?=
 =?us-ascii?Q?AlDbgOzrV8wTaAmujFxpTaXX1TK9nXdRxv+GK2NjkAhSZcamYI/pf0S9QYLF?=
 =?us-ascii?Q?tgHjGUtQkJIrMoe7NhK/JequsGPRCOfO1UKDpsQoEx+zcaxwVh8kJtBX15QG?=
 =?us-ascii?Q?Y4SD/yDodltmiTNInv/aOeyssMoGWKw/mgeh3TFyz/UQOfmwU0Zf7nCB7tNS?=
 =?us-ascii?Q?hrMd/kCo35LVPhE4A16TtHv5/UJHtfUmEvH1zT5MlI9NnwHM1pmCL30fsJMe?=
 =?us-ascii?Q?7xf5Qp+tLt0Z6GF39ArN7jNTHey/VrCgMEMrox9BRIsoJfigAO5AGXLTz9uh?=
 =?us-ascii?Q?QsoqdohRCQ4qXbHsd+js9zWkzNxa+MjyLU3EibPRLWe5q/MAhk5wqOOuMb/y?=
 =?us-ascii?Q?mh3FeszFTdjdW0kVKU2hM2BiPJa4ot3LuweJ1JlLvXBDPZpEoU7uZTCD54Gs?=
 =?us-ascii?Q?Uk6zV7yjUqMspEIHiw5kF9sLT2akOWTGu5x03NCJSAnKSscxU5n89aTs5/ic?=
 =?us-ascii?Q?pejeuc3TCLs6dyX4Mn7qJg0zpp483KrWFFOGnt0a4e+hN9h99Uc7xFO+PaWx?=
 =?us-ascii?Q?GmqVEe0FwuRjYC6kOGI5h6+FLI5PGQPUQ6fCH8evMjalwKzZ7YEB7Gva70XV?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a97fcd-c9f7-4336-25d6-08dcd4765aff
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 04:33:18.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBmWAaEpt2Sac3YmxmetZFLHInlVB/VqSUOZ3Lmvky9GL3oqv3zbv92jmwik7w45/ncsV6ZCpFhJlbnJeiBSOcncrkPEL/gTFOeEMRPas4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com

Gregory Price wrote:
> Depending on device/hierarchy readiness, it can be possible for the
> async probe process to attempt to register an endpoint before the
> entire port hierarchy is ready.  This currently fails with -ENXIO.
> 
> Return -EPROBE_DEFER to try again later automatically (which is
> what the local comments already say we should do anyway).

I want to make sure this is not papering over some other issue. Can you
post the final topology when this works (cxl list -BPET)? My working
theory is that you have 2 devices that share an intermediate port.
Otherwise, I am having a hard time understanding why the
cxl_bus_rescan() in cxl_acpi_probe() does not obviate the explicit
EPROBE_DEFER.

So, devA is dependendent on devB to create a common port, but devA loses
that race after cxl_bus_rescan() has already run. Then EBPROBE_DEFER is
the right answer to trigger devA to try again.
