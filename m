Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FB768EA
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890533; cv=fail; b=pqhZoupQ6ti1ok6MU2oHPJz++eBNRClXgHWFmRQt+v+WUONMV59UB4wqyHzIw0of0TSDbxt9doz7U6btS/CloRh73myiyGYpG5wVXs8l6NCUjTyxXYOQwZjBYYHGZU8HGuFd0dPZv7uwIGVLZdTB2y6k9JpsDIdXLVG+w6m/V1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890533; c=relaxed/simple;
	bh=uGw0mhbV8s1ed0jRIusx8eys5aNSxC03HDE4MbQk3JA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RjjtDaCF1FnLk8aIORHYRY0q6Bc7DZGhPXdY08hgWTOsC8SqXq/4X2TUmcyRMUiZphJG/3XY79MrM9fNW+tgTrFPvk3MZhMYKzzm/wsAF1hmWCCdCHcPB+7uLFRJYfG4oD2R7Tayv10eVUvJlS+67IeObQZlL5tb8veKD4TRCE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUO8k7re; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUO8k7re"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785890532; x=1817426532;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uGw0mhbV8s1ed0jRIusx8eys5aNSxC03HDE4MbQk3JA=;
  b=XUO8k7rewjwBnkdaNTgYthfFcYopOjOV7xqf3WLSI8lV9eI0dp2St5CX
   ADbp+0Rb+ioBB5T6d0BTjTzptWer3IkrSerzm1WsepjJh/pK4pPujVwvp
   pqktL+71wfWoJeZUcCiOgjH0/nKMsSPxPShUsOaPlFTS5P2qV3z6QDtKU
   xwefNuRo5/NtKCrV80kiCM+7vieCAMhszxDyC/IOI1+FIoJXyNGEInV5n
   7PUyLs5P6xEkWxepKSGdyD3K3X+YkaUiJeqf3+OHB+EM3Bc6CcDtpVJw5
   FQnBAgsh+f8o0mJ+BIsWI1slGexwY1KBUZebapRicws0LSIvYj/XSExop
   w==;
X-CSE-ConnectionGUID: 2B2Q8tsATLm/QTgxHvsXEg==
X-CSE-MsgGUID: 5clDedXPTxmPIuotFVquig==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97817568"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97817568"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 17:42:11 -0700
X-CSE-ConnectionGUID: 3rplr2vZSYuDxtJxB/DOSA==
X-CSE-MsgGUID: 8zpHbiahSeOr0XaXtKgAlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265477697"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 17:42:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 17:42:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 17:42:10 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 17:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=It1ls1oy+jOlEfOJQWIOusUAVCoMy2iPG/V5E4Bg/TjyrFHlFN0CWzGKSpIydv/8iT0clwmseh/+a5QLlsdERG5ykjGUWXZOUldYRP3DYU1W58seb5GBiEGCWn7fvG31jXUMKr0PsmnloeEuWkD66WNxjGlWllyrBPTAq8PXfATG4IGBQfJjPpKs/9deXDl6JMW6499u1e5fyg6xcIxVc8BMVV7tOaU5Bb8Ued+FdwToqRZjaLC5E8cncprEykV+IIJ0Rdl/zOr5XR3gygyAzeUk7TUElFIq/sBoWbWPiEFS7sChl5LbavmheC0w3IyEux+nKJoVoGl+OFOd9byJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUTJcN2dNqPRqr0IVhurdIPvheXw9BpPyDyhw3HOwuk=;
 b=zOU4BIER8aMUiGLsMfjfG+l8Cp0ASYHMKddNfg0xnE1N3oA8+kOmgw7Xkwk/NEGx8cP77SwOIrYGOSRpXOWJjcJm5N31o9U9nP0huQeZyjj4cbWkoCjM39D84VLYcIyDJKbRslzCSI5zL+Z8HBuVFNapY0uOK890b3cGvSNriSvmKKvcgjVPdYHxnCanFOklJyNm4jNhsI9ohbTIKyQ2+oulhlC/5BrNfza9zGYbZ14Uhf46/5LLq48/dg6W2UH9pDwRIWGbNBRct8i146mkktpL/cBBU3Gxmk++aG/Ib+ROp/jLq0f5iMNymU/x6f6amxH0OhMBZk3q39Ie+lE6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB8854.namprd11.prod.outlook.com (2603:10b6:8:256::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 00:42:05 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 00:42:05 +0000
Date: Tue, 4 Aug 2026 17:42:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<benjamin.cheatham@amd.com>, <alucerop@amd.com>, <dongjoo.seo1@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v7 1/8] cxl: Add BI register probing and port
 initialization
Message-ID: <anKG2SLH72n-I9lZ@aschofie-mobl2.lan>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-2-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260728144136.709882-2-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a8a55b-076f-4839-3770-08def28a5f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: P/UepGNwmTEmm0Brja5UMqdznAr8vphdchH85zayviQVlYEQZ/+y2En2j+cubZpJ1C/xvO6hnOT4VUiE/eSnTauKanzB+p1/eXnFIMsS71x7nY2Wwt+lSRWa+R8RZbZIiQ+NgE3rXLTCa92g/bkZ0cOs52IQjDhHi3tGaqhf2540XWFxM+YA9eAXyjQ56+5hjoIOXlR2CIpyyVvbajpWL1UM3+6yemc24mnNBHlkG9i6TOU/oljCd8R/1yvV2FZ7gyeicpZmgEJ1Du3rt3NPV2qcMo1WgerARC7ycKxbXYM+JaMIpil2iKX9CZ2qVf7D6AZRhdl0nxX69bEQ/Fcpelc//reA0F6DU6OY47Ya3ghcTRynC7lkD+IDTYkcMMDVWbUpX7lyOHCGor+FHbhGUBN2u1EtZrFDec0siAgzIwsDUk/emERCglj3EFg46S2vsZfaH92XxgHDSdVMEUWmSuT7Jn9ym0/1SpDPJTayQ3qhovjCpUCI+AMnOfOQkXhVzuTfvz35FEzj/Onxud9ssQTmpcLo9LhA6XPp8ZBB2pEMaDYdRt9g8pWWI5JhlE+9eC7R2N0PSHO9R7DLAMM2+4jIylo/BzBpC8+hC9719KmabDuzNA3Pj7kZPhsV+dJx/zhFmmGlOVm/iFvM41wxHcXi7PWGRpfiBDrUpThqEnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wbl/FlqV7syflhBR1ILx1MPODAhFZORWfrKGWP8aBXOTfh9v/kDEKrys+QQz?=
 =?us-ascii?Q?tEhHpyYUqAzkbCva5qW1X23T+yZp1RNx5mitCBw6CBWtpO2DrzIkGIcOyJ07?=
 =?us-ascii?Q?Gp2yN5PLgj+S70qqzBd+7aKhssE4Bsz63g31+frNQS36+LkoWmBseKevR85D?=
 =?us-ascii?Q?/QvZnxzJT3L5POBdx8VXfuVoeGsk4DrL2vbZxFjS0YBIdMobnp7nxWA1uB1e?=
 =?us-ascii?Q?Vcm89uqhwb+XyQB+IfmcJ5RkvlDcmJ7LHZ820yxBf72pRIEHSRQdytvPa74l?=
 =?us-ascii?Q?bM1oOwoEWTopIFRNVs/ywelykAxrLdycMJWXIhAoBkUth27jIYZ9jm/GIoWb?=
 =?us-ascii?Q?/8RwkTfQBiaXsQ79hmrQ9mKDr8ylz0Ln6aVqWQT7K+9EPcludR7WtrgBFGF5?=
 =?us-ascii?Q?cHLKy4uVYonUZI1RWxp5C6U8ogdqEAvY2tzt39gOdVzRQrZ0uD/qhp4cQ8Dk?=
 =?us-ascii?Q?Id+FVwkWoQzaVrahZUqt+wBPoG0Il2cgZB71LJIqlwgiqA5URL04T+SLkyln?=
 =?us-ascii?Q?AscNY9Y1/KNqn7h5oQ3VBxDILQmbqXDygkeJTiqAVvHszWvecj/yjrIspqJD?=
 =?us-ascii?Q?U2kOaJLfcRJIc3cbdZSB3UdkZfIwZCJlorIB0TXx7ON13I2dmjtAonVMCJw6?=
 =?us-ascii?Q?8BsarLfqr2+m959/jVy2wWqa3PQB+XVljsxxNVLQuDRi5sv90AqzZ7fH8Zx0?=
 =?us-ascii?Q?C+3vpmMsvIHe8VnjOuM20YVhyLJrAlssVrDqB5VH5ZOXHHtDs8QQU0/YUKY+?=
 =?us-ascii?Q?6T5zukoKA5WF0oTi5n0l8TLHuEe0M+ONyhp9541MReWORIbGiRFcL03CRQU/?=
 =?us-ascii?Q?oJSyyriulBpoNaIA/ACM1UM5gI4Gz/ete8on06Kad+kPTwffJBv4ovNQzZV3?=
 =?us-ascii?Q?oOn1ROsUWV9w+yQ5qx4Fk0TABoDjTbclugMEm8KMIMWZg0cis0QBTyfGIuBD?=
 =?us-ascii?Q?IOLp3tdSqvifZsCOz6v+X4gKkADJrUqTd7vqpLHcPj/4kDMLKpO7yr9r5DDh?=
 =?us-ascii?Q?h9TvEEO2CwatkFLxBjPaxKtWbFsxCQc7LuRgBZrZLhv+Fi/3R/8kAt2RX2Cp?=
 =?us-ascii?Q?ytzNGgVHX4Dvs+zOnIiSSiDVi0rjBmKnmdCdCtgN/117e4dqQpObxsnNYi/q?=
 =?us-ascii?Q?nJkCAzdvB/8xHmYzzhut3aCSDLDyorW+P6a9lQRp2Wh1ats76Nnyy6qPaN2L?=
 =?us-ascii?Q?YAYsYTDdevxQX54wFzHiV4VZjU7KBjFqpNSLEK0rEqAlCSkxaUpMSaUzIPyu?=
 =?us-ascii?Q?x5INNNfF2Xsz7O3DEu0LzVbsZXgGRwr+C8ZbU9yLn8ZwN5T3qZnMQP9GmDU6?=
 =?us-ascii?Q?9HveygU1+DF3/EfSjMOzaQe8XOwQD8Lsqm+wZm7wrGPu09CNl89+j6htCPwQ?=
 =?us-ascii?Q?hD636whLdtUzbWwYIUZYPias65Ab/5w0Dg3eoYWC+kCp2lABpZazN/3ypV+r?=
 =?us-ascii?Q?NLZcjD7BnM8ZPPtfBXiXeT+zUQBvU3L4ZPhsAG1OYdswbS6Hr4Bb+T3b+bzz?=
 =?us-ascii?Q?GI1j6ekmRZKija7fad9goU18nd61U5SBJX4m8v7S6kyw0Qa4eWsUaPbntTH1?=
 =?us-ascii?Q?W+fJ2eF6nP/JwooD73PmS4RCLH7suB6YkGtkeD+G7mtrjE4YRGvSpOVaJ9NX?=
 =?us-ascii?Q?nPcFcb9Joe5LEYrdLIiuQ7/rIjx6a9ZYI9nUu57EX/96WmOu/ih2ybGaER1x?=
 =?us-ascii?Q?2Xv5tMEqZ7Cq/mRYFabOkMRoIZUs+gT4SVzOiJg8+DUNF7/UUNh0cTxmz1tp?=
 =?us-ascii?Q?INoR3wMpMpOsWwYdYsGqjnzGWylPzTA=3D?=
X-Exchange-RoutingPolicyChecked: Nieo9imZgoxnKXGO2ZeSNS3mvaqiDAvOnUn65VsfPEkZEAVqyPqeo4TZR/zM5hkQKxJUMgRlZ3/Pncdlwsojxnaw7SeSwwELS0BpxVLJtm4ggnQZ+Ec61T+blqnk205WCJWXOsI2eI6XocrqWk7eW4TLCSLiZaMy5jtnLTgxMEddDLwByXVhQQXA9tRsOlF6+yCFEDCC1RKgJPAUX7ZSoHKCUnlSQyiPSPJON54P/DcAZFp3t0uGyT53a+D3sUXZerdELDFwHtbFCdZcHg04gXGZ2QX9XCl+KHCfZpqpiX/9KiOqNFOjiq8haQ4VtCp/3fz2Tso6w+eISJDjzi4zdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a8a55b-076f-4839-3770-08def28a5f14
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 00:42:04.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWJgbFd4EXFM1H7ZHtw1t1gIieY/9PnzyrDmOB03DWEBcMkRucKWzXqd8D6mubJbHsm7VXQ4I6DtzIwfaJF+HS6YQW9USQuXwKQqoGEkIaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8854
X-OriginatorOrg: intel.com

On Tue, Jul 28, 2026 at 07:41:29AM -0700, Davidlohr Bueso wrote:
> Add register probing for BI Route Table and BI Decoder capability
> structures in cxl_probe_component_regs(), and helpers to map them.
> 
> cxl_dport_map_bi() maps the BI Decoder of a downstream port (root
> port or switch DSP) at dport-creation time via cxl_port_add_dport();
> cxl_port_map_bi() maps a port's own BI capability during port probe
> when the upstream link is in 256B Flit operation -- BI Decoder for
> an endpoint, BI RT for a switch USP.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
