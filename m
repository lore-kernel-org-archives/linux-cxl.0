Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B41FF1DF
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067748; cv=fail; b=NxP4R16m+d1MnEXXaVZ8c3lq1kFyOoMaj2NO45WpJySwYEUDZkXhLomUXb+sAnIJmRmb9ibNEF2rutNm9UCx393lFXGJ+cKiec1XYc3I3XLpENvSQi4wQfF9p+rQsgIGf7yE3wnPjWqgVJtU26+XA+7Z5dHyElIGnbtkQ03bRaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067748; c=relaxed/simple;
	bh=683k+1pkfslhnh23sM4Qj5agvPbym2Bvzyww6a02OhI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0anlSNCE/ktEKdQbImlHiLVjQD8F/e/9JYzFKJwV/SN7UWTgDJZv/Uu4blkJ/mLjhVocxYjlAHwb00ySwxob24monNCnVW5VXV0eilqQDWpsNgnyR8nycPhzyMDGCg4BlvpOgNTvnVtJgxVw/ALUM54nSmeSJiSXh5urt9/9jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iU9r8zF9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iU9r8zF9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740067747; x=1771603747;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=683k+1pkfslhnh23sM4Qj5agvPbym2Bvzyww6a02OhI=;
  b=iU9r8zF91k91MucI/CISokprfJlEYbCLLSBLGqprCrYCK1z01dLkhYI6
   /pL1V2DR7ZRXlQk/i/DV0MILidDLKBdXSM0J19ZKYdESSj9/szwffTKs2
   br/88VhLHgGefe9ZSuiElDg2ibHuK99AI4hDoJNFd5HXwUHwgOcSqmelo
   Q/ETYkIKbK824/iEPH0RpBYqvu+K2TdToX5i05Un0tJ5Y2szIAZHG9+ul
   MOQuH8GQFNsRWxSptZa+TMhn+htWQmRfhkOPvK2EH8OiMTZQMQeGBBtgS
   5CH5ljhJfb+8MXKt6cQbrBigFbZKXwIZpoSjjuHosq9TXhMeSObnqheSG
   w==;
X-CSE-ConnectionGUID: VafJsaYeRpqBFatfkLfehQ==
X-CSE-MsgGUID: z9U9dKhXTW2MG5MttQzpug==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="28452399"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="28452399"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:09:06 -0800
X-CSE-ConnectionGUID: X1P9S12ERE2GHLuQiNfdFQ==
X-CSE-MsgGUID: YhQOL6WAR86atBYn1tmD0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115979978"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:09:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 08:09:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 08:09:05 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 08:09:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ/zr9kdhapwWaEtwOZLsM6uml41+foVonxwB08rCtVIKizxIFkDzFXnMeB/SBTkq8G3jskvAwvRfT3XnHPKJYZvIUdDqsEatuEaOsHskTkoYSdcNrbxcaQlUH78N1Xvuml+wdV4vvo3XRPi+Ea2gc1/arpIVAFf9VyATEv7QKDAbk7GbhqQR6V/cppflq51vtjoq/cu9TCpdvNf9jgxvzNFZk6LTBLoO8xg6Lbb0xn0V5r6eP90OyvitrQRLedQGA7sBf5KXzjzbros48quoGzDiUltEcPM4taEupHVW6eyaOZG+o14gPXpgG2UbM0XQ1YC5VvZYJ8d2pBxn6+Yhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F882ctszg8kuTY0bch5UlaBDd8O2oSdgJuXhOIpzaRc=;
 b=UX0AQ9BGL8NxqKyPcFR9DC1FksKPL8ke7+yWJ4cUXrlwRF3+anLUbMj4cFgEVQ3FZVKISLHNayFvT9b6g/cChuoMaPCtDQ2P99BUhXFFd0rKruMcax0rnSmH6wuDr7OqXTyHfVbJNWjhzVURSQWXX5x0JLodeM8OBs0q61xlBN87fhm/JEgcHr3ehUQZtbEju2q4+y+J/CJIb8LhAw0k3SusFIYwZEdZ+uFnBUAXVuZjvhehQGE6sXrFWuu3h2bdudRuE5glvYsrVAL2eg7T/QRuwjVy9uLDcx+IVFnSw2hkGCovN1zYaqeOAGJqUaJlaUkIVj4R7j7iGHGupAF2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 16:09:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 16:09:02 +0000
Date: Thu, 20 Feb 2025 10:08:59 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>,
	<ming.li@zohomail.com>, <a.manzanares@samsung.com>, <fan.ni@samsung.com>,
	<anisa.su@samsung.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl/pmem: Rename cxl_dirty_shutdown_state()
Message-ID: <67b7539baf331_2e08a129490@iweiny-mobl.notmuch>
References: <20250220013604.263489-1-dave@stgolabs.net>
 <20250220013604.263489-3-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220013604.263489-3-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR04CA0356.namprd04.prod.outlook.com
 (2603:10b6:303:8a::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: a32cb7e8-fea8-4cd4-487d-08dd51c8e43e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pRdzlD44tvl32YKuAjW8RvLz8g/EBnCHAiwP03EnyzebLGNHgx86wxl2yyxk?=
 =?us-ascii?Q?PjD6HPs9Vg9eYCTigyW70DbIMepdxkH+lUG8GOdIDbKVpxtTCrZEtewBSqRV?=
 =?us-ascii?Q?xjBHgju2iG5i42mOGcfIb4V96aQq9YwW8z5fR61xXOuwJkId14ssYr2gUQ9n?=
 =?us-ascii?Q?l7yuY9kxXrLNmWKumZZM3y7eoEB3KaYJnIieLBkGCCQp5MqKDclOO/y/1yZ9?=
 =?us-ascii?Q?hKsHglSQpDYUJ2oh7dkeo45Xgi+PpjPlMtZJyKqlzEEvuCj4zXPXeUAv50Ap?=
 =?us-ascii?Q?p/gbp6OHnBwJMv4pc+h6izEpZ0N0YIHQw5NAjDhwtwUrsr+fnLWZBTYiZPhU?=
 =?us-ascii?Q?TdqTBIL3cbBZ8w/qa+zBE7Al+wrFLnx8wrDkYYrBJ+R2OY6g2Rd1vLXRzNTq?=
 =?us-ascii?Q?YIcfCZnM+wXpKuLO1GbXX/kdr0qmgD1N1mX8hXt7Ju1n9wSw0lOr0D7qFOXL?=
 =?us-ascii?Q?SYY14i/4c5SK1iZ2/8hhxtDl3m5LbNMPrvxFlHZEcvL924pL1coyO1+11uPO?=
 =?us-ascii?Q?AT+aUFHhCnACB8txzIDgwvbSaVaVhC+msz938DX7sYK39Udysxf2v8dy+G1Z?=
 =?us-ascii?Q?GGa7uaJoofmSa2IhWayjysf1OQJH23E3m7+WwGJY1Or34dPQ6cgGSLNUCvDu?=
 =?us-ascii?Q?CR7KacSkWaWEjjsMIRiUBDFAIyTDgWbErEVKiswm1E+2Zp64p9ahZc0Gj1kO?=
 =?us-ascii?Q?c1XK+b7dnNyjnoXdQDUDkSwP31R+HPN3IcxwEFiXhTvGgb3AO4tFp1LlNmvt?=
 =?us-ascii?Q?SNEbIO9+aFEQeCt77dJn2qXxwwt0KTlQmb8H1elUUc4rAfhGbGV83Jr3exou?=
 =?us-ascii?Q?uk+29/TTqBi1r8pX7eTig98XU8+FBqSTM4WbbuDQGa4QUiKR+Qf2OIRQfQ3s?=
 =?us-ascii?Q?Sl5dpSGsL1wOXLHNKKDexW997b3afNfg+GCPlQSTmnhQ/ScWUFZHosnLUI+i?=
 =?us-ascii?Q?0JXLPoeIX6xtMG/4VlCbbaACB0gegFbGJSAfo207bSz0MKspJ07cjTBtM8Sd?=
 =?us-ascii?Q?CMnuPMGhJMEWL16sVTahOOngDgK1C1NgupQWtlFZ1CFDg/RgrpoE5Cx0y5uD?=
 =?us-ascii?Q?Hs9vAH4Mb7ganOTCo7g6UncdtUiErPlxyqFI40c/0ggAmxBAEKeaBOGWORbl?=
 =?us-ascii?Q?UaT0FncUIiGMOI49A3wurVd+BEpxP+G8O0HbiAKxjbKUAAwCnWFNCgCKsEql?=
 =?us-ascii?Q?P2EvibOOFRbQzOY3q9LpYTv50GdWyhCtqsS7sshFCZz+WnWaMwiR2ZBZj1t2?=
 =?us-ascii?Q?+XFyEf9rToOVFtV4zGfSFFnpTPxRtzzEqz1VVZKFXs5hbDlgYsY25EaoWZcA?=
 =?us-ascii?Q?nxm5gCuRBnXaOJQTadBC8ix8e1nFkM0/sCnIaZ7P9GKsEh1tIt1Yrk8bUpxm?=
 =?us-ascii?Q?VJ6X3mTwC0RIZCWrTdc7ThJAaNus?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8EtSxfq05V7+rBXshfzVPBVq0v0eLaEco1aSRXdKKAKmaS46N3sbWpdtUl4k?=
 =?us-ascii?Q?C5X5m8Ve5EMo4VUT66xb4kbngkm0kdbxEq0zHQQQ1Fk/6b9Uvj9Oi1LjHtMj?=
 =?us-ascii?Q?DeIPf/dPx7StjTihNaaAfCkyhYn4gaJwpEwEFJhRs9xk4+BB4N6YjWiO9GDD?=
 =?us-ascii?Q?dGmxIkeS1jBNaACw5nFKzLik67s+Y8vqMhnWN058XZGS0dh+UOudY/YHNguT?=
 =?us-ascii?Q?Fn8BVn8h6zb247FEh1XYWpAVA5AKKibsC7Pa6R9CqBvhtzdm1NsHCwlHyB/g?=
 =?us-ascii?Q?G9yn0lDr5Dsbmt8OT4RDvD+VNNyUHg7N/ZLavCN8CJ4a2KeKjnYo61ZpKcAP?=
 =?us-ascii?Q?Qwubhh2ANd0XmafaNqzb8+gVFJs51tBf3S+XmLNeu8ac3s8HKA1gUoslKg1L?=
 =?us-ascii?Q?n8TV4pKl+bqN4uhgc2mJTHVy6t7d4UhLEvqun1PQm2y2CuhxzoOPfmAqnI/S?=
 =?us-ascii?Q?FUA1fMNqcOOZL/h7fIoXlid6SR1P2B+ikzuwJagxlIVu32Q7/47M7PF0PwS9?=
 =?us-ascii?Q?Jc9W2O408LfmN+hTVZXEo5OYY2gQBb73EKR2T8NSWztECOVEqUBmgSHfr//s?=
 =?us-ascii?Q?nP9vAFjZWC6/TsO8YRwAUAcO42w1pv5s02dZaPhn8GdFGQmM8t6LCO93HDdM?=
 =?us-ascii?Q?+Plw1Zxn/v0radDTv/cKVzf2evwsH2DJUjemPrUkqY+HDEMa4YzsRIS2fXX6?=
 =?us-ascii?Q?1/HKVU6W42bHuQl2Ite4URjDtjGZZ+nC1wTbNb2+xgAmFEJ+lhT9z99kGXvM?=
 =?us-ascii?Q?a0pamTwnoBM0URwuWDaU0CUoHxTmcbwWeN4Dmzy114WAhddB8yFsUZ+ILrxi?=
 =?us-ascii?Q?Ph8WFjh0O9I/ONvcLlhzYhcTHxirPuSi/21AzfZn+LZ+64Rh0rjz7HEmuEFZ?=
 =?us-ascii?Q?sS/LVsy63ihGDlGT64KtI+dKauD9hgygV0ZQCs9u2OpThxaeP6HWSDen0srg?=
 =?us-ascii?Q?4U6mn0bx436esxZQt4ebqhp2sHzguD1kIdYh2hoWOWzjzDCUw4+S+fA4DB+e?=
 =?us-ascii?Q?argL4j2MJlIcg/S9+bxtCFqHWR2QZ3+Te5x9tw+Wi8OFvRF1LvySnhiAghmF?=
 =?us-ascii?Q?963NOdxYvzc9yF4eabKFJi8m08P9bt34vchIDYjFQc3AsLTnCY6WCOTsH5Np?=
 =?us-ascii?Q?J5M0R1zEaN8nnF3BaOSGUYO4uuG+426xXmiv45ZV7ywPnuwazrj3NxJLownx?=
 =?us-ascii?Q?OOso2PqFnHi/qYR8jc99e09CALx2/DXZKxUVO2CC9lg6lHARIRsTImDpDJhI?=
 =?us-ascii?Q?/oCXuWHbB97/EtJJFRmlcl7Cfb0I9jvJ5p18bsMxlCFnoucKUPVRxKTf06Qk?=
 =?us-ascii?Q?rH8/KyciF2iBt+mV9nRzAYKWOo0B6SS55bv9dSTTYZYM3vNiNKWN0pwWFgvt?=
 =?us-ascii?Q?daer5520+Ch3NI+Jn2/EeczKx76APyiWjMDpYF4qGImtFiBCRViwsxm5DnMn?=
 =?us-ascii?Q?mwze35H7+tnHy1ji3bgGFs/1MAEY19fcPPPRyOaUIi7pXRmDrW+z682t/pnP?=
 =?us-ascii?Q?TaosGzfG0M5J6/NzZdwMIKpIY8gCTR6nghS6kPZT9vT4Bn61UiCAGLOsQRXe?=
 =?us-ascii?Q?aQMoJ7masFeBQc9g3//YZo5NDKZUk0Jk9a4BmjW2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a32cb7e8-fea8-4cd4-487d-08dd51c8e43e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:09:02.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PXGsQiJjEq7AgDW00GF1xYvxm9v9m+4KsCiz4pGCCWNri6BWoi4dAIW8N5OYyu+uC7ouPJqPdUYsuCPXaV4bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> ... to a better suited 'cxl_arm_dirty_shutdown()'.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

[snip]
