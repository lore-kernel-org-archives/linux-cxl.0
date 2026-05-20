Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D1C26461F
	for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245445; cv=fail; b=YRuBOq+OAZACAlU0VFxZHBVR9T4dGRABarpVhDEfJpMk1iOWw6oiBuZwCWj7aJY2kFX4Sq11iQ20Nyw1ncLesncTGl7jypbPfCn5VJwygZHpQoW1G7JJPb2SFsq6CTWr6PQ5gpvOz06WiKuJnOzrr164sIoacVh1uSv3dc2PVWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245445; c=relaxed/simple;
	bh=1w4gcOPjnmfTsYTzJpjar8nYaqLUDJBxvV8ZXkPprjs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JzAoMYSwA91zCZhSw1sOf6q66zar3jCWk5SINLZoQ0qeBstaAlrSZMsUfkLGKv62/Hh7wZOsz1W6P/yKvJNJ8FHyrQKQ14MYFbYgJKHbcVZM9+uEAtXh7Nv9zu6NpCkYoMVNIdXVWQpS0Zg/6gxWeESvDmEs+xNk9VBDNRKTPUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlcGVTET; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlcGVTET"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779245444; x=1810781444;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1w4gcOPjnmfTsYTzJpjar8nYaqLUDJBxvV8ZXkPprjs=;
  b=HlcGVTET2uzCjSWG4PI1MHEfYmMV6xqMsZ3V4F5l1K3YcsFTxqJtgxFx
   5rBXgMM/KGgzvLIiF4SXWsqV5T4Ajj101p7NPeYpqS/9UYu0O+h8tdSC4
   yxDh2Lcr6ikkMqeoJr9p5Uwfggp2kal91dO196sqw69b3Alq1wRFg7PF1
   p7vjkLNCtEjvO+3UmjvF0Yc5lNXzntV6fsK4t7awLHg2tEHcop4ofxVt5
   YQZ8pXD7iPwxeouGugdEBJHabliy/l4KUW9njylFZQRQTCYQ1cz7Uy5Qf
   Dv/xP48KVTg0PxctEHUorbIx9AYt8OoHWMvX/GRhMNhvC1papXEaOB5Rz
   g==;
X-CSE-ConnectionGUID: 5y3K0qHdRrSJlWzwDIvGDw==
X-CSE-MsgGUID: elY9E+A1S5W0LY6FjTJaKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80170981"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80170981"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:50:43 -0700
X-CSE-ConnectionGUID: EgP10Y20RrOMcsYzULUNbQ==
X-CSE-MsgGUID: LKyDKlcIQw6iBM/EyvO32w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="240254607"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:50:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 19:50:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 19:50:42 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 19:50:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks2fNeox/sd+v0Swb0R4DEOKp3YakGWI858u1ryPl914SGlwTE4fuQ8k7dbE28+CJvUOVqhT9RCxRvaqoUffxAmhMJhyCtWRLKFHfp0+maCBE8Ze1YrpUXTukE5Y4b4bTo02MEjLJo9kcIKBlTyLkcy3aiVmZoQl/Vqs1kVvxwJCofnFfVob5Mw3VoF/OqemF+IXRhsfglGG3EMhsDAaR8QO8/rErX8/bLJ2Oi9JRZarDPijQbrzfRkkBjnhUF6jBNe7PY20bpa4Zan5hveoh6EFpmv6i9xcAY+TySyZAqeqIXBmrzG8Vb9D9ox4sz9+7lAXn6LFvcNmnFbByl/Fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcPaF4NmovI9B2G8esGe0hucW9juByn45/KeeZxI8ko=;
 b=BbTc68vZ6HQf/DB5kZCWq5PX8mnuzMemvrV/PuaZIABznD0vOytCY19KicprSBtUF+wYF0bqeqLFLOC3CifdjqKyN1YMAhTN6cqwEL6g15w3pt00h2X3l01nVj4SCmOHu5ty3J398NT4KAlHIRSWhHqx8AJAydfsroqCgFnrl/1Xz7FRaBamWTAnpeKglWqxmWmcowgZzpexXHY+vrsWz9lOukyHKa7oFdNL1nnYdYJjOwUGGlhyR9hSSxJqMf2YlPO/u0yeq4XEcyWsghD0A7KPV3un2T7m2KYz7n7AfMeIqtPVuduvSLbKGGuP0ji3QgdGsot01ZjiehQwz6YUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 02:50:35 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9891.021; Wed, 20 May 2026
 02:50:34 +0000
Date: Tue, 19 May 2026 19:50:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <djbw@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 2/2] cxl/test: Fix __fortify_panic
Message-ID: <ag0hd5Jh47bZgf3Q@aschofie-mobl2.lan>
References: <20260519221204.1517773-1-djbw@kernel.org>
 <20260519221204.1517773-3-djbw@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519221204.1517773-3-djbw@kernel.org>
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5339f5-4ba1-4291-ed25-08deb61a90a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|11063799006|22082099003|56012099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: tB8VbIiQ1jUig/jYtawrYzkMtaTWwAFzbx7CqgOVyFy7YJEHUGMPbPiLDRQj6zb0uN6xhItTAcIguCfQQ71oVKXVqbASgY69a+OCxJCtT/MuhR3uxfMmbf8nyDQtmvwB8xqZK+zcIdxhglqW20YoxGzkq/RRL3qwWB8Z7gilMT4Jfucz9Etdgh3+mjiXoI85hW6xi6NfYxNVXQOsUkTqx0LBQ1CQkrZSGV6Kpx1sy5+p5y4u+8cWx6HPr8zcJKdpiNFe/eRv2JiGVBWKc0BLFt/Yz1nxJx8Nplanf/VXLTWKWWnHOWObKC5ezIoChdUsxu9iIpFRcb3pPgazdoHE7ggG+KdCy19nwKPaeR2ApXHMqr4Fs+zERNqAmeJAs8D0pwOWverkoCHaypyq5TNtnFxWJ/IaMzW16UnVg5UMh+bdWI15y+LGyBfhq0ZZ82kVqzvya6rrrvf70WNR8hyfSLmBZg7ZBNvXptS+Rlr6YpYt4dAvAFhplhskARrEfxQwLMBXSyGl4Jd/i4GPNwb31D5AjCEovjds9LZf69k2a1saMboTfuHrUavP9ML5209WrzPQo0UiihVaMW/5wXP753OnE/b1LRjw+BJdyox2JdVkrUaHfClJrajY3gFbzjoO+pvBOOvzgzKTw5PQ+Tf4nAfJdSnKviMIk3xRCqGUd093McONzraqhLFIoCP3nDmz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(56012099003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lt1Xp5wukT7zl3gCldQviBigo+c8BSpEu+Ai6K+tdD61wEwuFKvP9ef/aWtP?=
 =?us-ascii?Q?0Ja30O3TvoIaxQNaZ1XqbbR0R/qOi9Z4Ojv7WWcwRDAsL2zQYn7YuBx6470J?=
 =?us-ascii?Q?77/o7P6XHhQmdnVlyRCXpekUmEZNFagupWdfpO2Qhd3yIR63efi0hpOce6aI?=
 =?us-ascii?Q?uarJYBYrkrc23BJeSjkEVomiXv7We21fP8mEfgPPNI3tXzw07VpSBbXU+WR6?=
 =?us-ascii?Q?PR7sahA8lHb7mwygkV9OaDkXVd5bUxn5ThdRilqZs9ZFxU5cxO2LPS3vMGRN?=
 =?us-ascii?Q?QhDWGgkDTY2IcrJe+3TUmoCaIiCpKCSJfdghdQdEnhzsmjJmP2eYr5LNj2de?=
 =?us-ascii?Q?5BxC77DCSjz99RreUApXD9FYvORXFDH4495WqIPvXITXTolGaSyVfz0F7w/a?=
 =?us-ascii?Q?mPZ1Blh4BIYJkRZ3wL+e250ouSit1azlyA2Cy/H/3cy4k5iO5PIlF7rR0kSL?=
 =?us-ascii?Q?yRBA/iyDXK4nf+Rc8Aau6FXnYGRUk7+a4adjIYwSUwN6LBJoK7fOcFQYvnlI?=
 =?us-ascii?Q?1YcDI19+xGiLeZf+3xCFsFvN8lT9qSfgqHMMYLZZLZgX9pbJITwvi3aa/EbA?=
 =?us-ascii?Q?xptyHTusyD24xp/v5c+Eb0qmd0lZ32YwEg30EyINWQLatic0auGwNEdHseLW?=
 =?us-ascii?Q?vgE7ZhpPQ4Bz4YVlsc3TmEQ2RsB13JCWcmRTztQyuK+sqZcmukrB5opFibNo?=
 =?us-ascii?Q?NbY8150mmNf+PvdkS9RxhzOu0glnrBfOsxGNo8nM5gc89VmIBnMgflCw2pTa?=
 =?us-ascii?Q?Z6WHKKWXjCC1baxxZXQEZKRGNZ/OWJrh8u9zke2Qzr7L5hWg8yBpETYIPJnN?=
 =?us-ascii?Q?N+pRHRuoSxZwcIF7+IJwalgW0Yxh9yexyGJ20R1DjpeLW/N7dMOYt5z8Bo0P?=
 =?us-ascii?Q?/5h81rs8y/tWGQA+92iJQeXwYWj+A9m9QpXPNzYMTFIua6TQIRaJaawnCU2P?=
 =?us-ascii?Q?Htqex27t2Oi/cTZ+c33zgUFSMMad0R786GgP74ctL8gw88tVveZcOEPIF+4M?=
 =?us-ascii?Q?RayWa2rej/4j7F4yUEbOd6PNV5HLm28jcvLScwlEWfcx8ifS4jyz7VBW98Hm?=
 =?us-ascii?Q?KLa126oOqIvbfORjI0Pxpq+ER5AjhrxBZfzcHHLRsvy9QF6N+Kvjzmvg44dG?=
 =?us-ascii?Q?WxvYM4b8nf2m2GL7UNKriaC2A9tY1aTPQRuMsV8r3szj/f+57OxoOWc4JTL0?=
 =?us-ascii?Q?tMuse15+qf3mOIq1Pf3YtOUip6ze3iYtuO1L2R911YqE242OuDN59pyzLxmd?=
 =?us-ascii?Q?s0AWq6QPNe6ahpSHmt7ZXS/hcYgDzl4Nzp53LyncMIa9W2poQYztngsehiR6?=
 =?us-ascii?Q?gYxEUIoiY7dmxErSde/crYYL4CQtajPWfL/K4rgljJhGAGhnV6iZttBi+UG6?=
 =?us-ascii?Q?ybS3Yl/LL9tI+PLPEjOA1K4+MfLg6dpTXhE2h0R6gFrPATXp9XY9q/H5NpBF?=
 =?us-ascii?Q?lVfsNoAJzWrJUYNkoQmFy9Rg3kaG6G5eiP9P9/Crwbp61UyMBgB3PEx8n5Go?=
 =?us-ascii?Q?0WBvAq91kKKA4h2kKSZ2aNDTz+o8xcNngarSD7TL28R6KuIStFAI89YafesV?=
 =?us-ascii?Q?6p7e+V63yDdjGw8FQjiWVVaTyXUlWOJmuJhPfouSlzVADL1TMWWCRG/N1dP2?=
 =?us-ascii?Q?j1iKiTNiIkpiVdvnpaPTXfcLI7uvMroOKkxmURxB4ImTtDRkf/uIAGaKrSbO?=
 =?us-ascii?Q?AUBdefdagKfUYcSMvhzlLCu65w4YtNUgTz6U1wj0vNR8zIGb+NB5opN53p9H?=
 =?us-ascii?Q?LNTI3RucIq3DQ/hn4smOac6srxbzQDI=3D?=
X-Exchange-RoutingPolicyChecked: ESzVWStPW9h2TvBM6bfqqvDwf9KVzHu9vwInTkWx898ekjTUwtXaT4xbKuNbCrtYkBZEJM9YHL9BSh/58OFhq8Xe6AllqgLNlVtaQOAe/dLLfZPxGN8UTy3V4miMIeh6GTlUmgiFaSl1kLwHIIq52I//84RMzn8fsCc37TPsWi+oUaOY+grHeqSGRMnonc5l/qRyd5CPi+CahaEbJRcYQwfpcB50Rj7kLKB0bdoPHl0TrtXq9MkXOX9FkPVjb3dhXvE/QQLGcvOK1gyRgA/H31zJaVrz3hNSIrCThalXz+0KHkCGw4H9QMtu4qG/Szib4Ql4udHqR9Ii+Shob3SHfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5339f5-4ba1-4291-ed25-08deb61a90a7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:50:34.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agiSRiVwbLuT3Re3oRj3WwqckwAARXvWlP7R8N/LRNlJqVMyy3JGpp5nPQAUqam3T+wvsYy9p9Wjp7exq4oPyf0ncOOk8zOjBCo+g5glK/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com

On Tue, May 19, 2026 at 03:12:04PM -0700, Dan Williams wrote:
> Fix a runtime assertion in setup_xor_mapping(). Fortify complains that it
> is potentially overflowing the xormaps array per __counted_by(nr_maps).
> Quiet the false positive by initializing @nr_entries earlier.
> 
>  memcpy: detected buffer overflow: 32 byte write of buffer size 0
>  WARNING: lib/string_helpers.c:1036 at __fortify_report+0x4d/0xa0, CPU#8: modprobe/2728
>  Call Trace:
>   __fortify_panic+0xd/0xf
>   setup_xor_mapping+0x6c/0xa0 [cxl_translate]


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

