Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6931A2391
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737147448; cv=fail; b=H3ev1fYWnyvfEQoqFxUwH8NFDh2RpE4ExbpIGPFTW7ytaSOCIeZmmDRaHuAI86n2dXAIZd4gJcRTdj96zsVB5SEGzeY6z+gSSEOT2fInOANjZiHs38aXnDvTPCr37FcEmrdi2c3/YtgshMf6OksfTrsjK6dmCmxASXkTINHywOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737147448; c=relaxed/simple;
	bh=Rq1LpV335XglAtp6nkhnotvR56+sgjeeWEFxIlEPW4Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=taMuJanr6NUnCkhSnhe3vQeJDJasvrHqRRAlgXkU4fDGnzEzgYly7ef1jqT2xHCVgmrDUHmTWghUVC3kVHJqfcR2XMzDnxM5rMp8YcZJ0VNG6ElamsIRRVAMbMjjk89GgF4zP428zd/eRmWyyHlKdLq69gLQmS9CMATBqByEwIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhdT2tUy; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhdT2tUy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737147447; x=1768683447;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rq1LpV335XglAtp6nkhnotvR56+sgjeeWEFxIlEPW4Q=;
  b=AhdT2tUycV+8uaLbbbLZvaoiPTIVxx3Vx4Jtu3eXgwJ7QktqZH+0pCO6
   p4aLjZIGw96pISfWEj8EPXcGFtMhc+Kxcsx4hSuJgH/IsznMTCYm7CwpJ
   rot/JnowE4XEyRlzopkT8atst3Vfc1BM6pJJoVY3HvgQupJ9i+wkMyGqH
   UbL+8G43apg7mRCVsHKBlvZiB72g9g3h5jlhEkObJ7qv4f9ds/sdGUMUq
   8xyCFlOFtzkrXG+LRD/6iMj3w6OdBNgn7DsOvDxnSAIDxP5AJA+VU47JB
   PUXK6a8R9tsLjeo1AXl/8AVa8j8F6b+tzz75E7xrUdzoZjXuROLaX/Njp
   g==;
X-CSE-ConnectionGUID: vGNZrcLlS8eQK8iGGEdVAA==
X-CSE-MsgGUID: X5qbZivURu+LEbipMSrKVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="49009752"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="49009752"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 12:57:26 -0800
X-CSE-ConnectionGUID: edIDVI01QiSc8IxyGRWjWw==
X-CSE-MsgGUID: 4JcI9M08TdupSBwl7SnO1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="136743045"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 12:57:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 12:57:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 12:57:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 12:57:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9cFTnJqVgFPDxp9VyonHPff+x46cyqE4Lu41t2CSOexSsOS6L4M/tKDzVkqFvCA9mwwayRBGJ007DG/Z17sy0sEfZXelIsD1wGe1ZhMAS9rQWUVhu6FFOnW/wK4chA1GjdfFGb7vMTNTVLkH1YyOT+ERC/lKwBkqrAmBNnHbIRJovbZIBeL9Zj8c+4pxdFaVDBDa3vRVsOtwE1HZ0XjnEZKL9E5C0LJsK72DGl6vuEbnp0M/jnIpunXw+GidywMPJ1O3v6Hx5ond334bB9llZHVbM+aVMu0atHDpIOU8swKAj5ievInItkvHf9xOHUcnNd/G/yx7kxXlJX/c0aJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySqvazxflq3CGzNrDlKKdtilhadfhydNZjka2sZ5zGI=;
 b=XDoDyBqaf/eDp/YOFX7UC+k3uZXqfoZhXDWTvrg3bAcH2CtzMyYxIQrITsSDhImK/41L+tTOB8jhPR5fFQhebZOf5xrnlF8fuVfK+rDkI9JAlURZhxsybqNAfJ0yDGT50q3oIjfQWU5K98J6d1iIknYUd4GJ8gq1bkgjAlaSN3mJUbnLQV34deXqdu0aVClrq6mPcj4iyRZheEhzc4MQnYenFJJdnsQBUo8btxPNnUu+QZRTazjQ1qQPzG+nhosAjRy+xZIN7k3PDpMVvHDU3BXEJXLRx9OhifImHCFpgf6IXHlkQ1UM7TYgAlVvNTszzS9vI9BDNuPU/NU5Gj5roA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB6021.namprd11.prod.outlook.com (2603:10b6:408:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 20:57:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 20:57:23 +0000
Date: Fri, 17 Jan 2025 12:57:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 4/4] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <678ac4316a7f5_20f329456@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709425022.753996.16667967718406367188.stgit@dwillia2-xfh.jf.intel.com>
 <53ef6364-4523-05bc-4fa1-8a2110f5fe54@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53ef6364-4523-05bc-4fa1-8a2110f5fe54@amd.com>
X-ClientProxiedBy: MW2PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:907:1::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: a54819b1-6dfa-4e5a-7f5f-08dd37398a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MaVtWzPccVtWP0Bu8PmnAdNM+x908AXTDTUiRu3Bmmqkyvo2WQVxu951qGdm?=
 =?us-ascii?Q?Ot9bmTnvXrWxL266NPy71NOupzuV1PgUBYdwHu03C+BXsgUvGo+sFZ1/y5ro?=
 =?us-ascii?Q?MjtOK32NOtWrsXmWOHaPQrujiEXkJhQOfhUk3s8JyQiEXw/6rJazTOP+Ykgb?=
 =?us-ascii?Q?K1z3OJl1gBibXZ8wJZ5ZXwG+W9KpPNXW5SjyxKqLvM6D08XiQ3xzOyve82yk?=
 =?us-ascii?Q?0sZdiFvmugZQxwlXU5a71bTPOZZPB+t9sISOHF0/5i89IFA2T5qoXz1d/ti3?=
 =?us-ascii?Q?IziR7905kKUuGNZVf8Rb0H+ToQi+G8IRsvPut6AKq9bwk78Zcoqhg7twtC0x?=
 =?us-ascii?Q?pVFqOFw4r4+bGF5/hFxA9lyItw6VT39fBGR/0CE6Em1sAGvbeFksrDCoO6sW?=
 =?us-ascii?Q?Br4VG536mVLog+zM59mPHVOZIlqAj6o5I7oR1ZW9BfDCOQg0x19p920QVxNM?=
 =?us-ascii?Q?0IdpRR83XpxhzZot54tYp7UE8nw3t6+mjz7QW8JqTr7ca+iizozlhrZwzkIJ?=
 =?us-ascii?Q?/CYJcn7//K8nygHXhMNUNOktFu4bCLxs9Ge9xiASdVtkTo3cOYLZRNYgklNI?=
 =?us-ascii?Q?A+Kyus48z8kKt2Uki6Hlc5js2WMA/N7xDaSN+G33wbg1O+5nC6jJwPCfMV+o?=
 =?us-ascii?Q?hQhpYH/gEsTYRodUV94Fnj7DLtRSVLV1n26bPXr9qsP8fRPti6FtrA47Nsnp?=
 =?us-ascii?Q?qQMHX+WkMP1aK7VU25XVWdRxu8aG9xXLSE7mdIw730+Is1Jr1ks+grmE6TBB?=
 =?us-ascii?Q?Va4YcmIB1NeK9rpMFP45x8GKgeHmGK6sy37fnYnEEEl9P+auogel/leonDNf?=
 =?us-ascii?Q?Ls6A202FteFrst8H8HYl1b7H7Bo0y280h6Dm3LUzTBGR20ki4Ag4T7dxRVVo?=
 =?us-ascii?Q?XYf/It+3TauLodSkl0bmdP9X1BDHu5LVqreXNPRgxWHKiF5iHVJS1hnbvLGC?=
 =?us-ascii?Q?MT5YiG+GeI3/Ts6eliaOmicIdd+Al1jaGbotsOuHN5ROotObXB/iVtCMeKqe?=
 =?us-ascii?Q?VyWCo0uOe76kEBtEpnjpR0tJzcHHZurkUmPYAnpjXTr6YId42rIqHuks6aE3?=
 =?us-ascii?Q?kvemj1wOM+r90I8f9tg88kC5hNyalSP2NceIVMLLfZUO4ltrCchhef1Hsqqc?=
 =?us-ascii?Q?EcPBFOQTMyr5qJxgVnDGUG90bSl4ypqcx4xJlxFaXhFeeTx0QixvioOkrdSg?=
 =?us-ascii?Q?pZHnGFGm3EaLlIO7MTU377OgtVqBUPydw3E+Cdh3I4oqoXmQygkmbGgsut8D?=
 =?us-ascii?Q?cZnL+TJdYNjy5+GbbLRI72UxVTiQkw0VOVyjZS1HXiU8uCeZWAnP+WiI8qL1?=
 =?us-ascii?Q?2nI/2OAxVZZsAwBSod6/vQbyAAr6N+KRXczcJrNWazqq0HAeIw+bv718igfF?=
 =?us-ascii?Q?Kad1++C1OqARrR6KrgbxOv19fsNm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oS8MCmmPI78SGO00Z+9hkn3YuLgvbZ6EkNdJIIlRVcqIHWw+91dorXP0lVSx?=
 =?us-ascii?Q?Bm1Nzo2wGAnJ2iQvPynudsVzJ/nlPhRx90+Lx76IR7rRg4Z5/1EVqVeoeYCn?=
 =?us-ascii?Q?XX0JXhsi4uv4e3sAoVSlQxSy8AgvBQAUzJq1/ZQiTKRSxXfXZjC00pN0LgwN?=
 =?us-ascii?Q?L/bjOlvo0BcZcOyPaoB65x7Sqb13gsgUz5NhUV7NRXHWj4CfTpXZkSMlr9Ro?=
 =?us-ascii?Q?YdlM3HcsK7koSo8GEM0gY54RiXVHHgsaKOe4mykcKs5PhGDpZuyJvRp8lpwf?=
 =?us-ascii?Q?rwQmZ5Eel8fVfpG3Fu4ryIIwERxy9Fw/1pO1pFobV0sWA7A8TThH+xoywVnH?=
 =?us-ascii?Q?Bs3H+IbpfZAdeeemhSKNnejSf3mgvDgB1c/feGrbr9Jtg50C8q9sBnyjnCCg?=
 =?us-ascii?Q?MQmsFmeb6JFu+YcvzZY/l/N1Niuxd0+L7IAln//aUqLZ58VyRnWZbfPr4Hs1?=
 =?us-ascii?Q?lTWN8f8E2DFNbihsT6l0eH90LBCzMEBx5IyW2WeQW2GEhJd4/S7XbOAZPlml?=
 =?us-ascii?Q?9mEzAZAonMzrt/LapOHpWcRSYs2Bin2u9TZxy46CtPU/XdfHOY5Fbsho7Z7q?=
 =?us-ascii?Q?4Zz+pvk6S8dZyv4ic5cxdLDKj7REDA2AtbMspmWNOiF0/GQljKNN+xFkyvU5?=
 =?us-ascii?Q?FlEFfthtn2YJCh8ehv0LxP/qr3Fq0zOBVefw1EeY+HAqygUQRNKMf0Y5oCYY?=
 =?us-ascii?Q?wCsBkr6JfFlY8+dR2biQVaLwhsjhrcKzLf1USxn9FchliL0D1scd7M0SzcGQ?=
 =?us-ascii?Q?7ZXYwRIltGvrnHPUJbaDe49oqwcRTz2fytd639dMqzTfOQCnaGzLUpNZahQN?=
 =?us-ascii?Q?P1Yqlp8oU0FGZ656DiQVyI1EnDbhDTI7sRKCp7uBiwqHvfSH4W42z2ReZpAA?=
 =?us-ascii?Q?DTOkDXKY55aPu7M87kcsbfuyrVoG3bHu/GzBPi2QglriwT5OdTMKpLG1nKLB?=
 =?us-ascii?Q?rQLhNF2W4EZ3EcsVyiA7gTXP+BnD60HWKSN8D0SW6t8GwhxOMQZEMKQlPd2a?=
 =?us-ascii?Q?6O6L+skpqVaWPzqW0KmvkpYLQTiVdNOrTQAU+ZrhRZMJDzfNyZtoBLfCAC/K?=
 =?us-ascii?Q?gcJHkk9LwSLT8FkuoNDNiBdtZmoMStr8jjNqTaKQmPfomIbBn1rZvFl/UNi7?=
 =?us-ascii?Q?k53EjAlT0/EFIm572YRc45WHJ+m6puvkFNPpW9wP4hUllja/zzzUIAxpOnPL?=
 =?us-ascii?Q?oc6gR6AlwX0xSClcLHG2YO+d9N2CeRadpLDAsg75hhxzdEXlLVP0bd1kftZ+?=
 =?us-ascii?Q?3vNPUHITvbFcBqkGe9LEyv1WzqI2dm5y3RvZclpe4Xfylt1+4U6ES7ToVxHy?=
 =?us-ascii?Q?4wDYd5CKtZNwCAjxfGcvnkzeRSQfIg7cmR+jFMcOVhJexIZ8vs1RJh7x+vWx?=
 =?us-ascii?Q?D6aIXGU1LA9QrOEsKxc+79pvR7k1pKFi+CgL72tGui7RiKwhfyipEDDJopLM?=
 =?us-ascii?Q?LpRlJhb/Xog+c8WmUj6H7GvHvcISe0/9/QSawLr65IjoZgBbulBcRioFmco2?=
 =?us-ascii?Q?v7Hn6jqczTC+3Fjzske75uPfDQN98tFHnPM2vvta3hsohhhDeJQQRQDJX4BA?=
 =?us-ascii?Q?VPnUtasO+8sk1VsNeWcgYWYGnGGRp5cxc/M3BKKqfWrUSKEOTpXSX0JZZZfH?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a54819b1-6dfa-4e5a-7f5f-08dd37398a6e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 20:57:23.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huStWLVJpa3mXKhatLxHwPamU1CDINR6KmaqDdz2uOOo8KJI/5ZjI8aPhaMN9YZYpUyjuK+X9UCSqR7dQVtXADXnINHLi6RG8y5bd9o7iXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6021
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/17/25 06:10, Dan Williams wrote:
> > cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
> > allocations being distinct from RAM allocations in specific ways when in
> > practice the allocation rules are only relative to DPA partition index.
> >
> > The rules for cxl_dpa_alloc() are:
> >
> > - allocations can only come from 1 partition
> >
> > - if allocating at partition-index-N, all free space in partitions less
> >    than partition-index-N must be skipped over
> 
> 
> In my view, you are mixing the current code with the new code in this 
> explanation. It would be better to say the current code assumption is 
> just two partitions, ram and pmem, but DCD changes the game.

There is no mixture in that description. The rules have not changed from
old to new, the implementation is updated to reflect that the algorithm
never needed to consider ram and pmem explicitly.

> > Use the new 'struct cxl_dpa_partition' array to support allocation with
> > an arbitrary number of DPA partitions on the device.
> >
> > A follow-on patch can go further to cleanup 'enum cxl_decoder_mode'
> > concept and supersede it with looking up the memory properties from
> > partition metadata.
> >
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alejandro Lucero <alucerop@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   drivers/cxl/core/hdm.c |  167 +++++++++++++++++++++++++++++++++---------------
> >   drivers/cxl/cxlmem.h   |    9 +++
> >   2 files changed, 125 insertions(+), 51 deletions(-)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 7e1559b3ed88..4a2816102a1e 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -223,6 +223,30 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
> >   }
> >   EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
> >   
> > +static void release_skip(struct cxl_dev_state *cxlds,
> > +			 const resource_size_t skip_base,
> > +			 const resource_size_t skip_len)
> > +{
> > +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> > +
> > +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> > +		const struct resource *part_res = &cxlds->part[i].res;
> > +		resource_size_t skip_end, skip_size;
> > +
> > +		if (skip_start < part_res->start || skip_start > part_res->end)
> > +			continue;
> > +
> > +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> > +		skip_size = skip_end - skip_start + 1;
> > +		__release_region(&cxlds->dpa_res, skip_start, skip_size);
> > +		skip_start += skip_size;
> > +		skip_rem -= skip_size;
> > +
> > +		if (!skip_rem)
> > +			break;
> > +	}
> > +}
> > +
> 
> 
> This implies the skip can not be based on the last child end as the code 
> implements.

I do not follow this comment... more below.

[..]
> > @@ -551,47 +609,54 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> >   		goto out;
> >   	}
> >   
> > -	for (p = ram_res->child, last = NULL; p; p = p->sibling)
> > -		last = p;
> > -	if (last)
> > -		free_ram_start = last->end + 1;
> > +	if (cxled->mode == CXL_DECODER_RAM)
> > +		part = CXL_PARTITION_RAM;
> > +	else if (cxled->mode == CXL_DECODER_PMEM)
> > +		part = CXL_PARTITION_PMEM;
> >   	else
> > -		free_ram_start = ram_res->start;
> > +		part = cxlds->nr_partitions;
> > +
> > +	if (part >= cxlds->nr_partitions) {
> > +		dev_dbg(dev, "partition %d not found\n", part);
> > +		rc = -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	res = &cxlds->part[part].res;
> >   
> > -	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
> > +	for (p = res->child, last = NULL; p; p = p->sibling)
> >   		last = p;
> >   	if (last)
> > -		free_pmem_start = last->end + 1;
> > +		start = last->end + 1;
> >   	else
> > -		free_pmem_start = pmem_res->start;
> > +		start = res->start;
> >   
> 
> 
> As said above, this is not correct if there are holes due to releases.

There are no holes introduced by releases. The skip is always one
contiguous range, it just happens to need to be tracked via multiple
entries in the ->dpa_res tree. Jonathan had asked for more commentary on
what is happening request_skip() and release_skip(), I will clarify this
detail about contiguity.

> 
> 
> > -	if (cxled->mode == CXL_DECODER_RAM) {
> > -		start = free_ram_start;
> > -		avail = ram_res->end - start + 1;
> > -		skip = 0;
> > -	} else if (cxled->mode == CXL_DECODER_PMEM) {
> > -		resource_size_t skip_start, skip_end;
> > -
> > -		start = free_pmem_start;
> > -		avail = pmem_res->end - start + 1;
> > -		skip_start = free_ram_start;
> > -
> > -		/*
> > -		 * If some pmem is already allocated, then that allocation
> > -		 * already handled the skip.
> > -		 */
> > -		if (pmem_res->child &&
> > -		    skip_start == pmem_res->child->start)
> > -			skip_end = skip_start - 1;
> > -		else
> > -			skip_end = start - 1;
> > -		skip = skip_end - skip_start + 1;
> > -	} else {
> > -		dev_dbg(dev, "mode not set\n");
> > -		rc = -EINVAL;
> > -		goto out;
> > +	/*
> > +	 * To allocate at partition N, a skip needs to be calculated for all
> > +	 * unallocated space at lower partitions indices.
> > +	 *
> > +	 * If a partition has any allocations, the search can end because a
> > +	 * previous cxl_dpa_alloc() invocation is assumed to have accounted for
> > +	 * all previous partitions.
> > +	 */
> 
> 
> This is right, but the code below is not because ...
> 
> 
> > +	skip_start = CXL_RESOURCE_NONE;
> > +	for (int i = part; i; i--) {
> > +		prev = &cxlds->part[i - 1].res;
> > +		for (p = prev->child, last = NULL; p; p = p->sibling)
> > +			last = p;
> 
> 
> ... holes ...
> 
> 
> I think the problem here is we assumed ram and pmem being a child and 
> likely some free space, but a device with multiple HDM decoders implies 
> potentially several child.
> 
> The code supported the case of multiple child but I guess we still had 
> in mind the simple case. Otherwise I can not understand all this ...

Holes are not allowed. If you want to delete any decoder capacity you
need to tear down all higher DPA allocations. That is a constraint of
the hardware definition around how software can assume the value of
DPABase. Will add some comments to that effect.
