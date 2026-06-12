Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B236A375;
	Fri, 12 Jun 2026 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227256; cv=fail; b=J6NgEsc+9aS1FMrvy7xZBh5sPkwbFGDm5mcRc5ZNGBBsy/74Xs3Acf8wfvUWp8nhl5dftKjTBL73mVMc01BO6Ea3Cj9NgW71bj5J2mqxJc5puwMNhygyGKmT0NEJhC4WyCmwhTI4Ahi6ECoh3gw2w66lAOk1BnFe5URyou6ekoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227256; c=relaxed/simple;
	bh=VbH4K5lGjwawtQOK3dukHxPctH4Pe+bOOHMiVZEgSv8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aq9/XFyMvPJCQUJV3EeF4bUQak6hbjb18Bf/oLdGiizT+nFVImffBlp1L78aFXu9lQn/4xldkchfSEcRV/7cKfdAlo3+1RnX9SdL8Es7ce+PXXlai6RqpQ/eVcyMSUNFUoBCkpUGTTCNSNPWRBsBRPm1/2d6BzXn4wWMLx4RjPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+B1t+WE; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+B1t+WE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781227250; x=1812763250;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VbH4K5lGjwawtQOK3dukHxPctH4Pe+bOOHMiVZEgSv8=;
  b=L+B1t+WE369QKAHZqTbUjpuKczXRkjqzSAIvaQTsPI/n4RUg3StJ07Nr
   pbPsNp7qRxkFumXrD53cGk7+u5xFjaG3/Nv9co4Tcvoh7XCdywaseF73G
   yvRhi/rg84VV40QoDcIXfCiF7ctsV197QR4MNTUQjvKAp+1c62sRCWJMX
   aE6MgScrp7bHIJ9voaNYFLEuYanm13UKXgDadQ+kUft5uFxKrEpOh3vj+
   95Yh5fq/fldFu8K27RlNJGLVeBSaKrbttoCtlIESVOmrHjiwis9doPU67
   9VZSVZ668XKzp3SAH2xKLyv7a6NuzMl1ridSJTH+qymc2sTCo1SoPSucG
   A==;
X-CSE-ConnectionGUID: sSPGb/u4Slub6Sd9hfkamQ==
X-CSE-MsgGUID: 4+3p15UEQQSS5cWfjEHG2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99476061"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99476061"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:20:49 -0700
X-CSE-ConnectionGUID: cFFWpw4hRxOueLVGASeVEg==
X-CSE-MsgGUID: jVAmAyruQICCSKvnKG/9zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="242544980"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:20:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 18:20:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 18:20:45 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 18:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpwghmG+r/ylipzq+6sDbyEFLVGe6wcmvc9/SmDQJ5tuZf3xRNJstgg5PjcfwDbLt+fHsdFNRQrJWAzJ3aX4NsorjJ9j7ZotyoWgUB7xM+6bPav4wQx5xJL5MBUrJbtfTimO0W9eyG1BFetD/nFWZDd0r9mjBX1l0uvqI30GdMdoRBssALjzu9wIQC6Uo9pJGk3naMokweYSWpz8aErydG7zydLe7OGlw0pQiQ0xqYWhg2iSbNxml5eLz9Jh1dBC1JvtOs2fpTqqoX/nMUwZC1uLhowhtWqiRpuoQ/t/4XYk1eNNfNUVYi9CpXwhibAeIlZ1R/dVyIKNw9ih4RBPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Iwqrg+9+WuxkfEE5vgHRdklUYCWGhGuh56GqXceebQ=;
 b=XO8RjNZLnA5kYyS+0Yt1a5LMuHFk0fwI99vwuAjM3U5vTqMWH44MjmEguo9mC/0ElZWQ8MlhKaLbqhnWoxpocNxKD201tSoXUpzsbkJjnO9YqOyIylkkUeqf/7osAlewjMeHN3iRxQlmxiNbiBh6pWmjGyGivsquNomQXcC0I/zikCuP/v9uZqr+vKi+NF2HhABGKXilqWXuYaZAeSQTXTRYQQZyd4xhuby/xZfYNLMiuES20tJ70ddWiyYzLIv6GCIp9/ywKdGlet9LzLLOQOcugdLq2KimD7AXGmqM9bLPvJx9OgIMBfQNM84oI+9UwcTMmjQSJlp6eEHkHgOiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 01:20:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 01:20:43 +0000
Date: Thu, 11 Jun 2026 18:20:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Fill first free targets[] slot during
 auto-discovery
Message-ID: <aite6BrA77D1AL5f@aschofie-mobl2.lan>
References: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-0-5d94ca06c4e4@zohomail.com>
 <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-2-5d94ca06c4e4@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-2-5d94ca06c4e4@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW3PR11MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dea1e87-f888-446d-5698-08dec820d2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: OIml7fgtSUfbaEM0KWlE95GP8FBvw/WRxwc1Alf8j2CPRHT10bXwl5qSSb612Oge+VPJp5aCld6+qL7H3vIusXIuovNLfhF/BscjPnXuFdk2k4tNV1/S2bF6dhkD80x4V/TfTFi7hO1JFVQ6nkiNoIhxsR/l6XBefzDklAnPavXRDdyy1OoZBf0Z33Pme/K9nLvwHpmZLhbFRnNpUaAsTc9wUMZ2Ayj8tAsgqzz66TPll/c8QkHhG2jHeO4Rtcoc9PN3xSIl2XxlSzBCbrb65YZ95oDRhXtFuBHbqeN5rigCb3t4EaoCUjPq4cp2xHfGXKwd9u+7lYUEfU/yVqC2MOFSalfYHJW/p7x40s97IuYzupISZkzZiMlz2B79HEBkGkBnToxqCb3YKszp8XNE3m8x69buCB695IFy/mvkQZv14FyID4NgeEEP1FY4bW7BxICoGEcjYGVNahr2TXaHaBjqiOQnf1slYhSK8BLAiziWBukbp0quNt4yrgf1o/6+/vTErWE5uBPReYtKN92V6GtfSYQzCN+4o7FEwkvhuTWtFAl5oyTQGRvuZPZwuUL3R3mqAM04NWTi5snAqqamUozzsIHr+TK8KcMzAFQVyS7G45yJSQ6YAKw9am8Na9jHnimH1+SRo3i0kp8t8DsTN/XKnxaaYXPp6BYU/7+tov6ibdCLVvrexUfO4uihYXGT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+SJuAvZPnmfgueaOvsNT6frAQknJfgmoBSoA9oyffIwBsnwQa6gEByM5ojhD?=
 =?us-ascii?Q?BYdHQlUsvVu3OLDNcp7pr8SOrdXzJ62Qf7NW6WAIQ64370X8HoLd88eXO6kK?=
 =?us-ascii?Q?3ENDPwIx1po+uiXvq3KX5EQg7naZy+ApXIZat46XWDaLoxfGY0plOv9jEhfj?=
 =?us-ascii?Q?ErVcGkT1SYxO9JAq9BO6OsF6O1yMUYRxi2cC2bcKjPUmvAzbLKSIqSsmKtBa?=
 =?us-ascii?Q?m1FyyMdFa4mi/el6y4Azf4KAi6tYylYVWNHjVcFBsJjyqBM4Bksp8yFL1MkV?=
 =?us-ascii?Q?KSlFFWD2BO8ClT0xwyHhyDxCbOwY3fd4BDlew6ANCHg7mJDAuFVTmnRHE6He?=
 =?us-ascii?Q?OaKmqp5ZSQ2z3PCnvDyzeP2p9OiWDQHJXIpdwJAhW4MPpVKMfBspG9s35pXZ?=
 =?us-ascii?Q?ousUH6AhtLdH6rBi6vHibRstnfbW6FXt4hfTVF0XSGrv2QBZDZEPXANHMJ8n?=
 =?us-ascii?Q?Uma5JtTsfGbi4vSWhFhbGyPlNTZI4iXUU4X+L2TUCnlX5i1KcN70qcH+Vx+D?=
 =?us-ascii?Q?/ziZLy8uY61JML81XAbqjcqmEKxtRYSVEvNZsqQnfhPz7utx0VhFwfihJkCe?=
 =?us-ascii?Q?r22kBlDKMS0CdUMSERTEN+UMScHJ8dC+WTnk3NPBDjYk3w4Xr9Bjx/f4k3PS?=
 =?us-ascii?Q?hYyScFdRY6VzGQ5eckQE2R7qnSlkP7RbhOBnVHWi21CT/pJ44sgGacP7PWRH?=
 =?us-ascii?Q?293Ze1gn5h9GGVVEPz5Z6pvawyvKiXifuFdPZxuDIXgzzK7eqwzo64LMv+mQ?=
 =?us-ascii?Q?VNJP7su8RV1jvLVb+G6eWk0flYv72R7PqfVwl7ROC5mOdnjQsM0SLBZMGWtk?=
 =?us-ascii?Q?QnAIDnSx7GStEDdRESEOdcfApyBGm+EweX+xabfLhDcIerooHNK0lmFWWEcd?=
 =?us-ascii?Q?TtFn9xfT8BmWAUgVhSyHEf4VIxra/wOIyvPa+eSclDS+T1Gf5kvaFQOLXqa+?=
 =?us-ascii?Q?xMZ8ngnSKO1czb3bLgF9fkNh2+/7Cy6AsMdKeSSaY1vztMxBaUO3am9a7vnZ?=
 =?us-ascii?Q?ew12xufHR/5KJRb0pNKbL3TfGY3mnp3NSNSTn+GDHghrF9xwJH1oZntmXnpp?=
 =?us-ascii?Q?SQimbfC2WBt88QNFwcbGOmlcvM093VfF51QOEnrIhRs0Rdn2T8BRsiK8KJ+t?=
 =?us-ascii?Q?c+BcFjaxIc5tm6jIud/EFOmcmTwtY8enKNoqHm2We9td45volwjqppdTi9yS?=
 =?us-ascii?Q?9xatTUZ8JPMxxkYxsbt4Y+0Kd9XLPBoaj89hlaqg39ceI6t3Ze7OhGo1Lzf/?=
 =?us-ascii?Q?xujhiyKONAP7yzOkIsmbUPgwsbRSqsG4yDHKsuVcihQe0B1EjCmdiFnSjTpm?=
 =?us-ascii?Q?TLhkeMFhFPEP/QhUjTD9hw6m6YZsvn5Z4beP8N4UzvOF/JSB0qVUt4+w9cT3?=
 =?us-ascii?Q?ju8rR+sEuW2CJTucn+ZCnffbpYNgL22JWAKq4u9ypYNcet1tEcSbjMmAg6LI?=
 =?us-ascii?Q?ZthlfJfmSdRsYgKckvH5q1zvbHTG+zmkeRmOVIU5CzoVff8w6a82U1t8E5rN?=
 =?us-ascii?Q?8yO1RhtGKtM7eFmSSwaScle5iZs50aH/1yXXliAlQz+dycqKxSQKuSTkfxiv?=
 =?us-ascii?Q?Hxd/mo+wIimnA23wxT6+JaQugLaeERsnpT8CYABgh3JbZv4xDxI3hU6OqWXe?=
 =?us-ascii?Q?bLzVfqCjne61ZUw0AU5/BsKZCxEzGMpop9R621tOaLWFSKHlAX+JZssnOvge?=
 =?us-ascii?Q?D0dt+5ItuOVx/3YoYdcPxr3T5l8FcHnTD9TaIBbCwQaQ+0ckwezHhlr5eGHK?=
 =?us-ascii?Q?QEWkjZMXoD8wYS4mHTeswRxsGBfoeTk=3D?=
X-Exchange-RoutingPolicyChecked: nvU73TZu03BX3Jf1hiAhf3OapQG6qsZD4A8VTD7AQdLH6Q5lX6aPRs+8JIDRnn9EQ9KSO/zg+OCqwIVeBJQ+ro0gfQ+fJmpabvndIYb10rCNn1A16TGGKIVxrno5jexjTgsYDbsy6QS+uhyPFEfoY01u3Z3CMVdT966EdX4M1wE+1gKzr0iKd3PlLO7KspXfCPVIUTQRc27DHm9H8PF2C/GIlGuMjd9Nh3ktdFypjqxWhQCY5eTlTPGFhQFtHr7Ia4MwfmTt8r5K+RQVC+ELB7Y8fSVI9zPUGPyxCreWO5gc719gEIZioKUHh/XF3DGnp3AV4yK30m6ftkNvAqVn3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dea1e87-f888-446d-5698-08dec820d2da
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:20:43.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWRZE05NUEcPz6PaE3neSp9nSSUquMcQ2Ets993JI9lEGZUCavulzRAcehAS9c8RaG0mTjI5t2GiNbvI6lOEwK+zxDovt2fT07yZrGoapio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-OriginatorOrg: intel.com

On Sat, Jun 06, 2026 at 03:51:01PM +0800, Li Ming wrote:
> Any invalid endpoint decoder pointer in the target array of an active
> region is not allowed by cxl driver. This means cxl driver always
> assumes the first p->nr_targets entries of the target array in an
> auto-assembly region are valid. However, there are scenarios that could
> leave NULL endpoint decoder pointer holes in the target array.
> 
> 1. When cxl_cancel_auto_attach() removes an endpoint decoder from a
>    target array, the target slot is set to NULL. If the removed endpoint
>    decoder is not the last element in the target array, the target array
>    will contain a NULL hole.
> 
> 2. When a auto-assembly region removes an assigned endpoint decoder, if
>    the removed endpoint decoder is not the last element in the target
>    array, always remains a NULL hole in the target array.
> 
> When a NULL pointer hole exists in a region's target array, it
> introduces two potential problems:
> 1. Access an endpoint decoder via a NULL pointer. it always trigger
>    calltrace like that.
>     Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN PTI
>     RIP: 0010:cxl_calc_interleave_pos+0x26/0x810 [cxl_core]
>     Call Trace:
>       <TASK>
>       cxl_region_attach+0xc50/0x2140 [cxl_core]
>       cxl_add_to_region+0x321/0x2330 [cxl_core]
>       discover_region+0x92/0x150 [cxl_port]
>       device_for_each_child+0xf3/0x170
>       cxl_port_probe+0x150/0x200 [cxl_port]
>       cxl_bus_probe+0x4f/0xa0 [cxl_core]
>       really_probe+0x1c8/0x960
>       __driver_probe_device+0x323/0x450
>       driver_probe_device+0x45/0x120
>       __device_attach_driver+0x15d/0x280
>       bus_for_each_drv+0x10f/0x190
> 
> 2. Not having enough valid endpoint decoders attached to an
>    auto-assembly region. if an auto-assembly region is created with lock
>    flag or assigned endpoint decoder with lock flag, which means
>    assigned endpoint decoder will not be reset during detaching, they
>    could re-attach to the auto-assembly region again. But cxl region
>    driver relies on p->nr_targets to verify whether the required number
>    of endpoint decoders has been attached, and NULL endpoint decoder
>    pointers are still counted in that case.
> 
> To fix above issues, adjust cxl_region_attach_auto() logic to find the
> first free target slot for endpoint decoder attachment, this ensures
> NULL holes in the target array are filled, rather than adding new
> endpoint decoders at the tail of the target array.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
