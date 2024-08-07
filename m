Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7451553BC;
	Wed,  7 Aug 2024 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071641; cv=fail; b=snt4zvEMrfZSjUvuZLWUqjssPsM8gzdplQ6bEwc+qEpQyvZgvQe4B6fZXNcYXdvpAAswX63UF8tJYb0q565PHvuVg/5p6mGSt1t8FdNM3vsqVwmIGcXPKkA4tvyIEAuIsaLTPANU6oyDYMYxp1rgqxbUOuRyv3LxDecD9d323x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071641; c=relaxed/simple;
	bh=+RY1oLEuhs+L0bpS9sut3WnvwjlxHLtj7T4hNrjP7VI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pMnhbQwZjJp+T7hBBaMBXOdkxKgsG7vfJehfjgPtLXstrbFdOGs4LPYfmIP8gK2QIz0cynf7dLmW8hK9UAGWFUOX4+Buyqmwa8iCI4qKD1lboPMx93b/1WNQgrDlXy6kPTuJLoCtuva1+Sz2NwCYgxf4uKYUTdhMq7Zj0eh6Wis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFjFcRfa; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFjFcRfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723071639; x=1754607639;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=+RY1oLEuhs+L0bpS9sut3WnvwjlxHLtj7T4hNrjP7VI=;
  b=CFjFcRfamVYiCGREauWHqoMdfF4p/VX6dlsJiPWifolRtPgzRa16Xs+3
   HDOcX0HIo8+1pSUmOypnU9b9IczlqwfdNsiu2rJBe1XvDsj/oP1h5JlI9
   RXJ7ziM+imyiRfEN8qBb1dX5TCbKBqUvvdC8HXAdWATNFSgRYF60G4HeM
   G4KGR9d/w39mgPoLnAT8nl/sypxnzRO1RVUt9mPBZA5M/ZRwoOnTiRbLa
   Xs22bDIwIPv3f9+V62MmEBrEuu2FWSs3x2n2gza3r6sjd+GCZ65nS8zLa
   NU+yxcUY0fq4uDG+Gaw3D1aKxnEbJt8OCaCseufGOwVlzFSbA5erGzCpV
   Q==;
X-CSE-ConnectionGUID: pEVHOoaER3KIfIQdo+JDQQ==
X-CSE-MsgGUID: UwoNpRMcRayLtruKFSTCNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="20746464"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="20746464"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:00:38 -0700
X-CSE-ConnectionGUID: +lIqj12kTBq9yIQ0mRJ5Cg==
X-CSE-MsgGUID: dUMUIcqxRrewuGC3P8fjLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57711179"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 16:00:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 16:00:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 16:00:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 16:00:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 16:00:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oubnal/rov204CBwHQDiTPDSjGkNCnN41CO5jd/i+RNUJ2DwPDvC+CmpFhTJRYvg+sd8qo//boKfyibxASAA96wlhUKRlooyj0RJeUt/e6vP9EJeIbYD9uj5bJExOSjzkPJk8b2J94DKdQbUqS/guH5sJ+jGaVZuh0coDnQ5sjt/KF2arguImecCOLlEMIDas6Yaf2iI9pj/QLrPnICX6rxkOC07UXadE7V4zJY/6wzYjnb1QNo9odz+nCIJecbB608jxAhzJeo/orDeD/W6iQinpk8H1N1GvUAtTuAU6eLjmvHmMKXKDCX8wJ1brikWJrQ5iKp4MJhkk+Q4GANu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ujBPWfWlIpsqiK+8cxtBOGWkMLVX/BpVYFU7Ee6Wxw=;
 b=ThMFUlcYztRqGlwM8WHps3E8vKzyS9vuC9yuv38f9OUsXNg6yQsUmxBSAHdhhl9pVlsyyANvbkIEF5DFN5aYzsZJR7yUAf+xb0SkDOpnk61oKEJl8qr3Ob7CHK/OxuQpzWWA4wHqeBZXkAQqEPPHuIMPdMjhVUsG56NypRO6xuWuWJjKtZkflzZMqTLBwNyXFKw8AmVOcYA71UxA2iqPNNapbr8gl9Trl3l7zpVdn0T7TuuGTW1kay7HDSTDYoPIV0XfAju/4jnpjzaiYBXngtDndmS+H610MAl3qQsL6CfXo3oBzB+DLgbYV42sy+uTU5KPWEVE3QotcWjs+ZhKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7026.namprd11.prod.outlook.com (2603:10b6:510:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 7 Aug
 2024 23:00:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Wed, 7 Aug 2024
 23:00:32 +0000
Date: Wed, 7 Aug 2024 16:00:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<cerasuolodomenico@gmail.com>, <hannes@cmpxchg.org>,
	<j.granados@samsung.com>, <lizhijian@fujitsu.com>, <muchun.song@linux.dev>,
	<nphamcs@gmail.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<souravpanda@google.com>, <vbabka@suse.cz>, <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Fixes for memmap accounting
Message-ID: <66b3fc8d39391_2657d52945e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
X-ClientProxiedBy: MW4P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0e1022-35ce-4138-56d8-08dcb734bd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HWBLxjukLOMQGK0llz2HFvPXBh0USpEh3hi/kDHVJ2CLZFfoSfOskCVjR6xY?=
 =?us-ascii?Q?8Hl/wH7mkxZ1xNcT+vmMk4rhD6dhxEKTCx3hioAjtyqHojfmWK8MDGlj/Eso?=
 =?us-ascii?Q?4Jnz4CgZr6ks4rkDWC48Pw0Sq9yQG7qnR+t8lr2BV0cIZ/s95ur0+0K9OY2J?=
 =?us-ascii?Q?OqvCD3NOmlpHiqFLHukAM4bFFgKrJkhsAG54wanNCGTc7GXPWZjJcTC10REj?=
 =?us-ascii?Q?e5POeUqikd6HyN7SAK9wI8UpKwEshX69ydlbPBUqXP5qChrGhyCxipR+khf7?=
 =?us-ascii?Q?qad/Q4S017kzXuX6MAvpjXXadSujLl94tf5EhFmAFNMr042V5gFLYDlwss0m?=
 =?us-ascii?Q?zt2JoZiscMEyf3ykDGelTr/s/D+6vNOtYIgHcHh5dkt+aiiIQqDW2Z+AQ/qO?=
 =?us-ascii?Q?/TvzNA0z127nNiAlwuSB+63wuglTYXT/NKEbXhlYs3gjNMlakf4o8I2kHPib?=
 =?us-ascii?Q?SMnd1C66n+vXCfiv2oqrKep/YZCqO+J1uS+oKgyXvZtSJSdI/s+D1JXdXwpA?=
 =?us-ascii?Q?4Q++G1SpU8XMLKHSrRgQnqJIn8Q8+jC6YLpuDLkDOOK/eLiADNcegXfNWD6j?=
 =?us-ascii?Q?2g4ExHy4SnuMenckLhvk3/8WdZimH/pIpdkW11DWml1FcMENFdMRpDZmvwsN?=
 =?us-ascii?Q?tJDJS5rTVWEyHqgD4KlP00rvUo+A0WKmY7g87oRj6SH6qJPydCPyEqDJUDxB?=
 =?us-ascii?Q?jLBlQ8ZWvhKUih0Xk2BgYogCKzjaPXf9UwFECIjI6AawctBoXREhpj2WMV+k?=
 =?us-ascii?Q?tw/V4kCRQp/GdLcb3ilurJmWqDvRqDwCvjxidAYa1xuoL35wUQ/YOzqgaEId?=
 =?us-ascii?Q?ejX06G34gFQrkBo04VBVynyvygCjsEM2NJ0Duy3RAN36NRZEJF3QBsKhEBrl?=
 =?us-ascii?Q?6UMlQ6nRLV3QDV5r6WP4+QN+X0xUdqketLgpN3atQUrZHmOcduv06d5tHYa1?=
 =?us-ascii?Q?jeOnlf6RN8h1wbWM7fzpdykRCbTiyPFMCKhN0dm0WsuUII8/ursh/QAh490k?=
 =?us-ascii?Q?ipDVW/GvPtLhIUido+AJuLXwBl7ONoaTHODRcTbDn7pqa8gfDkkVMrR4odgb?=
 =?us-ascii?Q?7T/OUHT1K9FFB5obA7I5d3TsVId++DvnYOeSuO0fHWs6IFFKmqD51T9zp/SJ?=
 =?us-ascii?Q?GowQr7WO9mPepYeT3ZwcKG6g92gevAN7PeGzfickoADr3debQar1y6OQoTqJ?=
 =?us-ascii?Q?wpH9p8BKjGpeFbTlqYaouNH0D17SZSwfwdxpVpnyldXnjGrPY3Cts1woRWko?=
 =?us-ascii?Q?mjQMHNP7gBhs7ne9qFWpac77hdngiR9TOmUgpskq1/CduMW7FFc4ZG/o3Ycp?=
 =?us-ascii?Q?FfJ2dKXnViFQILcYtV29Xgbs47pmY0BDVUryxnz5LcAChw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cgwep+FSnvZ3G1sDXPPTNldZn/DEA8y7GNcQbDCnh4ftgvjQMkaqKwYwAVLm?=
 =?us-ascii?Q?EY/IqQzF3hyPYbTJBvIGURQsGyLQXaalJnVVVVBfJsdb9R9Mumgm48TLhQrA?=
 =?us-ascii?Q?XAL187LHrTxuRRObCTEEDCXsiXbt6A9D0JKb5PYUYddZiQERgbqJU6wnNv7Q?=
 =?us-ascii?Q?2GaHC0Z8TGF5HD6T/F5+5YOo33caqBijGqTH9+Hfxes3Vpq0e2NzaDtHCFl2?=
 =?us-ascii?Q?o7GbOJhWy3AWEeMw0+a9oDVau2y0zvA5sxZf2IIwc5A4xJ+Dth7jvQDab80D?=
 =?us-ascii?Q?NlWSFN7EWusgGf0mCpk5cLMQaU+AX2FhaH39VQyAxMJK9Zo4G515YFSuts7w?=
 =?us-ascii?Q?38u10oBqipQSpk3FIDWHhhZC+X8moaUUHxfZi1EtrRW4OHeNKUuX0jwa/heH?=
 =?us-ascii?Q?nVyuNc3mMPL7UZnH2LHwey1g0plotP5hcO9dEPu4wCwan7R6xq7U2aRJBVSL?=
 =?us-ascii?Q?vrfcAZQdr2/3NC0cEuNrgYwHExiSzPwz3dEHA7DYssVimivYCoWE2N/1FaSR?=
 =?us-ascii?Q?5uOU/ExQGJnmPv3GetXhFg50SgBw/BFz8/yJmQEdUdZRgclzWfe6zuLccXrU?=
 =?us-ascii?Q?NDW28mtfop45wNVEX7Jp42hlbTZr+iMr1Ke0V19ivUA2XJddW2pXnm6ocLKr?=
 =?us-ascii?Q?2AenWEmjalWZfAdVvhzwp2qApFdx7Qmka7k3oC8CLR/VKcrDU+Sdfg9rkQWs?=
 =?us-ascii?Q?T2iOlv+1PkX7UBUop2fRiQ2lLQMFKzTMy6WuSI8oJQvhJLki01j9cVT9/SHa?=
 =?us-ascii?Q?lSAKTDEtaS0GJqiB7ysoTYPINob7lKADFmVCa1UNqTgiEuGFYhvudKEf9lWo?=
 =?us-ascii?Q?3YE0vvXjB1k/b97CpLbwOPPthL2ZZ9clY8FNkdYjuAxs1qJQl6kxyJ9xuqt3?=
 =?us-ascii?Q?hM9puHRjljXsj7Dud9pwogdg5t3eXA/n+1eeKEjYajVQLK33R5lmdGJWLeJC?=
 =?us-ascii?Q?qsm3TJTB0r9J4eZURj0SmHIUwjQgPtkTbZIaXY3fefH2/w5xNSSmXnirnTB+?=
 =?us-ascii?Q?N87X1p2wFBnDiG9rvjkuol6zGrzXEu3yo9qEmnQvME03lZRF7/ONEfU0yhT6?=
 =?us-ascii?Q?XEjR4O8HUEQThbeTEA9dmAcgvCiwlmI0vUqTjF5lWK7Cys0XOB8qGxIRaz3+?=
 =?us-ascii?Q?/nEuQhHd+xIBnHg3+JeMhla2lebLX6Gx4CseCFyMxLAVymU5WOJso7N/fnRj?=
 =?us-ascii?Q?jY5+XXMru4x34tpZSADEmoljP4vKh5AZWaeltaXdxt7LBVVPv1GfBAevkK9M?=
 =?us-ascii?Q?nWN6UemaBHx8vLIHK3biN+1kipzTxsiyYSG6qHshYYHlMcr6fD07DN+BVgbC?=
 =?us-ascii?Q?PPmV3r+L6l6edL8kv4Bdljx/kqL6d+vbg157lMpU8LZtIGLG1VlU8w/KJ5Gg?=
 =?us-ascii?Q?hLGqfSrSx80xCJlXttSxnwe3/K62r844d+ZwtVbUERjlWfL716U2WZrDHC1P?=
 =?us-ascii?Q?J3q5GoFSFvakWfYINnGxRQ4Rl9DD8hhn4NxZ9XgaFCDtxFX63VXOxDIX1pqZ?=
 =?us-ascii?Q?SdxcFj2RfJXbumk4CzP9B4swl4AjIxYVZkyQeXESZMGz0eng4Awi8UZA4VWO?=
 =?us-ascii?Q?22hjcHsY1wX6Gv8L6YJa4qrmtIcEhcOMvLUuEk2UlOeK0Oen9I8Z8taS4y8w?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0e1022-35ce-4138-56d8-08dcb734bd5b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 23:00:32.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvcqAI4aNlU2HUxxsqwjVO6Z54LoxYp0pDiBdtVZOa8Kt50LYKYAxcWM1OpBpgokDZUnasf6I4LpdaUCVvr3gu9aOcxsa6y6LfnAKwj2KMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7026
X-OriginatorOrg: intel.com

[ add linux-cxl ]

Pasha Tatashin wrote:
> Memmap accounting provides us with observability of how much memory is
> used for per-page metadata: i.e. "struct page"'s and "struct page_ext".
> It also provides with information of how much was allocated using
> boot allocator (i.e. not part of MemTotal), and how much was allocated
> using buddy allocated (i.e. part of MemTotal).
> 
> This small series fixes a few problems that were discovered with the
> original patch.
> 
> v1: https://lore.kernel.org/all/20240806221454.1971755-1-pasha.tatashin@soleen.com
> Changes:
> 	- Added patch "mm: don't account memmap on failure"
> 	- Changed from using nid in hot-remove functions to non-pernode
> 	  system-wide accounting for memmap data.
> 
> Pasha Tatashin (3):
>   mm: update the memmap stat before page is freed
>   mm: don't account memmap on failure
>   mm: don't account memmap per node

Hi Pasha,

Thanks for jumping on this debug!

We almost missed these. Can you update your scripts to auto-cc folks on the
Reported-by line, and optionally include the lists where the report originated
next time?

This is looking good from my tests, you can add:

Tested-by: Dan Williams <dan.j.williams@intel.com>

...but I still want to take a look at some of the implementation choices.
