Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05582450FE;
	Mon, 21 Oct 2024 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543420; cv=fail; b=FruyZ8vATkRNlYKe8VZbvOlNRPDQROwwca7ZrEMFb318AyrqXl4D9Qpw+WcylPGdHWGtcZBL2HsV8SLDS3Q6eE+kl8+dIr1DFMeHTxdRjA57ng2ZpU7O540byFGCv3yy8Ntzwj/ETG5M8A3b0bOYn+zdthxbf4tbTMBQdTQ0fyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543420; c=relaxed/simple;
	bh=JHppEJ1pN2EpQPlgj9n3R7MQiEw1IPb3O9b1xyNxuq8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k8TEdXL1eON4K/zRA3IgnwvYd+Gry6tuRLYkPQcLkTmrI7LIjwoN7TiGKUOR+mG1EVzB14sBkT/hoBTTNnHi6DCxy2TW0VjHxMN60CP/5h60LKtqyZODVt2iz7iAN5xbR4MvRz7N4iYOf+nfgcszkgCyVh91m19b8ItiQCcBbvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LB6sznzy; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LB6sznzy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729543419; x=1761079419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JHppEJ1pN2EpQPlgj9n3R7MQiEw1IPb3O9b1xyNxuq8=;
  b=LB6sznzyosPz8AXn1RMgu/cY7vzcbDHZGQ60pKeERLmLkYJLa7yRK43B
   HaIEqftoyEXNRJahBTlT9CGx9wYiGIMCnzp3iI6VYGAOCYZJ4DIFKF2hx
   0iGY573MUSZVcbX4J738F92NtVH0VdEB6a5wpJMnI8uVwxKPU+kel83PP
   b0qkLy3Fbshcqm9BA3QxwE2GEot0HAKNkhdjI2Vp0s+uAgRqsYFN1GAr+
   6r6N+S2NED4eucLJXqtu2jA5/foOqK5qo6UZTD8IbQWQke3E7wiaOtXJo
   KQ4Taim+D3j1Zyu3SnQuNO2HRVbKnshUpAdhYOcYmCoWpy4PRe/TmJzjy
   w==;
X-CSE-ConnectionGUID: wCpWTqDfSj6is/JmuS6bMA==
X-CSE-MsgGUID: +LUi/VAsTJu0r7X4X7JSfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29163340"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29163340"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 13:43:38 -0700
X-CSE-ConnectionGUID: ZtiZlMzRQcOnJBKcnTmf7A==
X-CSE-MsgGUID: jvAATH6YQZiVKCcVxqjQsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79216420"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 13:43:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 13:43:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 13:43:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 13:43:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iy+OZFO6khBD1Q7rgQArIQbdeAh6l3NpqyYK0tHPOC09FgLhfHdlW52f69eQBo+NnpGuXrhtkDKdW0LPTgXlW/478Yaz6rKqn/4teOOYxLzFSTQmAycB3o5DaX7PLspXCr+mVuFa4Hf2BBZBlPfJisGJF+xXBhSJa56OiDLEIxNssV3klVpzScOYYr6yrP63HZ2DtE2WmNkWHJosBrFebAWG2rxQzHuYmF3JhBPAXbAdsvvogzIgp0TZvrq2Xqu2CoXv3bvAVo18NEAzcVZ6hY0CEK0VVJnNYxMMj2BGl4NpFnjN+q2F4Wd4TunccKG7RQMQjXRUPiayG8vf8D7miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNllsTPQaRWX+OCsdpHlvmhkcVtBIN9JRdBSPm7Hv78=;
 b=Dcw/QYYNZCX8UEHuCJJbiinSVL7IG/KcOVAF8F6onWC1pv4gMUGkLLSW/Cdl/wKhTzcY+DkpQ6o9Kv7PgKNmLJHy4rIO3VH1N3WK+Srkcy5qr6QHwYqdf/VbTJvploInFEvLKO2Lbp7yrhS83YqAo8QsgF6BwUvVZl1Utjavr/M9mMqlKFi15mqPlJ2FQyGDChsCSJOXSGyTLvfu3TCzAOk1ci4LUcYonmh2uE/rTRqq/1rqBpGk2OiAi+je9E5ko8i6VTu6OsUkKDAuhO/k3BXPzhalg7aMaDYzR3t/VTcA5LfGDaz5MxE0wzySmmZl3vHNcOunDXotVOVz74nCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6649.namprd11.prod.outlook.com (2603:10b6:510:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 20:43:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:43:19 +0000
Date: Mon, 21 Oct 2024 13:43:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] testing/cxl: Fix abused pci_bus_read_config_word() on
 platform device
Message-ID: <6716bce4c37f1_3ee2294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241016015213.900985-1-lizhijian@fujitsu.com>
 <ZxGqYPGNaVWoLuP6@aschofie-mobl2.lan>
 <6711b7c0c0b53_3ee2294a6@dwillia2-xfh.jf.intel.com.notmuch>
 <627bb352-29dc-457f-a383-0dd399f55ab1@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <627bb352-29dc-457f-a383-0dd399f55ab1@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:303:8c::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf8188b-8697-4998-2ad2-08dcf210ff01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zA1CHOcIi2tkKicyFT3P0J3g4YaHs8kM0clInUiB/Z/VBQ/hPn/9/WDi1KRk?=
 =?us-ascii?Q?5HpgNeejn1cGPUAyPJAqeB+KxB755DtneQCrVd84pQyD0q/6TRslr2OYfcBb?=
 =?us-ascii?Q?N29uMW2Fe5tAnikZ15EIo2F1mUTSa14XIDafaD4Sbh1awwVORQKY4OBtEZ5L?=
 =?us-ascii?Q?mYbsDhPxkU+5jgR5ClADaT7ztTj1TGo/XHaJ9TG8KGmVUkaGDyqTRiLQ7Bha?=
 =?us-ascii?Q?sQ0craiu84mqSDLgTXH65jUOxcBmJb9JpXojuul3VFlwvJCho+sGMPF9medh?=
 =?us-ascii?Q?D0vmPcGLhqSAulItmiKH0B1HQBRNs01wrsFCPT6aVNlbaR6k6bupnJEWPN+D?=
 =?us-ascii?Q?36vEV0qz3+vQQzyLYrDhQ/ceMZ7QbZ8uoR3ncOHR/0GkDqW3OzyeqspIvfuO?=
 =?us-ascii?Q?H3tWK/Ft7I9fawTvKZnZyRRf8f7eOaVmQyx5ds6NABNlf5HUl96XKqYdYwmU?=
 =?us-ascii?Q?2nxxLhbTlALN/HUl33gABpEhvgWeVisw1K3yiPdT34sSnhwCGTL5f8RHMP4O?=
 =?us-ascii?Q?Sh4N9CoaQSxI/OObUvhZoaUBz1Bk9bgnw3wtV6x5wn49xC9WJeM+JQzvkH9k?=
 =?us-ascii?Q?Iwdmh6OAWY+O2wnEYP0ZaEK0dtQ+BRYmkJ7Q1L1PdxtQS3MlNwLf6kEqodJY?=
 =?us-ascii?Q?mNC7VnJ51zNCB8wTy6wTRwNSPfJf10RIAytfdasf07vJSNSsbO/7OtUtgpBZ?=
 =?us-ascii?Q?YnE1zbigFsn5vrtupUCCYwOVUgigHP6zhwPtEHbo1TmSZ7a3Cb8wMAPYNQ5S?=
 =?us-ascii?Q?GxvaqNMbwoC5AHOKwHKJQ6SQ+rK0G6geUen1GEgFoCNA7XHBh05Sy9gYtOvh?=
 =?us-ascii?Q?1O7hlNkro/tb5ExUv/G7SdcUeCvFClOZ0XF99+SOcV7HXzgYAMS7C3EijDfi?=
 =?us-ascii?Q?M+UNImCQxGaSnK/sz8u5vZfKgq9cr7W4nSt4JCylpV+ZqeMUT4qHPAuNbglo?=
 =?us-ascii?Q?cB6f+7ymLNfaVWIV+Pw4hRgyqjvMMziIXokUw5MlUPfAQA/4kevTlhL6aek3?=
 =?us-ascii?Q?kBoSp/CNhTgxAl9qcWtajOkXk5cWdqDjQ/iOo/nqcj7m1Y8u72/tYszUh9Ys?=
 =?us-ascii?Q?12FlLNRa7BKy+pDITwUKOaX7KLie0M9c6X9gEop7wxBkdLk2qdWLCQIWRQiB?=
 =?us-ascii?Q?BjF2raRyi1UzbnSCqvw+TJ2DJGdyoIXNpSd+gckrrZ/L6RwUekrcG/k3POAe?=
 =?us-ascii?Q?cDVNb4so+Tb8gTDN3mMMTcqCVw6in3AI3+s363QaURYxcBBmvZPo5uJM0s2q?=
 =?us-ascii?Q?KPwAUQB3Eov9NaQQePBW/DRQCHPtrICUwS45QAVnWpTsJbqQEJzqv3w+w82a?=
 =?us-ascii?Q?tiU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nc3+feubGXUtfkg5f0j2StJLFxCj2u9UPxsez9IGQNzYshH8TCST+6EnzirX?=
 =?us-ascii?Q?vLUQKMg3QWtoNBpIWvcjcwG2J4tb+aTuIFtxPjHPGI1Xt2abVkvRBFt7TITV?=
 =?us-ascii?Q?bRQmGdr7JM29aS/7C8LNYWHGehy47SlXRpRUdCYw8lpWvwReuUatu6qhl5Xa?=
 =?us-ascii?Q?OBc5P22Ez0B56SNzlGwbvglHlEQmPzWCK5nX2OdVHWLY7EbOl8MPSDXaxI/k?=
 =?us-ascii?Q?EXXLCQBVG/Q1iUns7beCY1cR26jMFAW8ma6lcKZ/VRL3zwoPRCxndhcVkdan?=
 =?us-ascii?Q?RaMCTSYElPelh1SzehrPk27cxS7M9hObGJIkqsm143AeoqXU2O/yYzUbS6L3?=
 =?us-ascii?Q?RBZz1M1kVD9jhLBhZfJBWb09v2/znh55I9yRlqYpH2cscoZoMfAd6hCjgHtf?=
 =?us-ascii?Q?Q4KaOqMeQyyukL+xUX5HETECOVBXt61FzSKEs6ctGopKoWg3JXNENIKDaF2k?=
 =?us-ascii?Q?9j4mymO3zaGuAIesACnYMXS7YUUN+qGUQi0XsJNX7VuZKOn5R6/tDrnQknx3?=
 =?us-ascii?Q?VIijGFA2SSZ2xuQvwFY8zTkcqoJKJzIYEg198brucgJHOuGQOOZOc/43d1Vk?=
 =?us-ascii?Q?YjNbhbEyFcVrWm+dsYVUBONKjBIzY2Nzv/2dsV0pcV88Vcl4ub243CFU1Twj?=
 =?us-ascii?Q?WKRXW5VeCkkcmyPLavabxv9gejLm1SPMUInlQ+g1erWZbCnH6je7A/rwnEF2?=
 =?us-ascii?Q?xenol+KzDedJNXM7OiUmWbAjt98OSgwAq0Qlcqu8p8KCzQExUcukWw+W4MJ1?=
 =?us-ascii?Q?RaNpdnOmNTuAECRa/c8Y0D2ugyP4OmCv1eFPkvrnxTZrT4gg2TlvvfhrjAj4?=
 =?us-ascii?Q?LketJbLvDctNbfgDHob2LV4BFlSCWUi4pdiIMqIN8oLV2n9t/iHCTZoZNDWR?=
 =?us-ascii?Q?qKJrbNyte3BlA6/RNQXUHat/7P/HJnCDpjVPq8iIVeH+OUJCRlsDslhksPxb?=
 =?us-ascii?Q?zlZT2T0mfxo87nYbZXJiAL1RpgCGy5XKUjRKPpwPxAsqRhAywd1m2Sz8ofwg?=
 =?us-ascii?Q?2ng60zP+bA41TDOk2qJ9Slecj/o7HfBQfpYpMqsmISaPD48Jp2j8NsllwtyU?=
 =?us-ascii?Q?on9aEr7+uT7sljX4u+cIEgNSGb2Pmyhzq7XwB3zNlqGKUH0GiH9Q18SttUWk?=
 =?us-ascii?Q?cQe6Llqp76yu/PO0A3SWDbv1XRtfhi0qR/+Yc59KyMF9CSHXLPbISRdaO/Kp?=
 =?us-ascii?Q?EGDfAM0vKWa0XDUDGK5RV+/k/BWbD0I6yV+KLWJpk1g9aWpCieu8nwZP/FHW?=
 =?us-ascii?Q?rSeyn589uYIIJzVSrR6PU/we6EKlL37ieVgKqvtQxwuwjGvWVUJ9iEdVW/8d?=
 =?us-ascii?Q?2l4ApDLyDNH1FJu9KmIyTEBDkoPqt1vvqOo4r0TKajP6I3aFg/WEXJAbp6QN?=
 =?us-ascii?Q?neC0xwm/iIOYff1ONJM6mjuoX1yknAzr59t3L3GmA5+1w2GpwmUDm3EXyDjC?=
 =?us-ascii?Q?h8esOyW7bYcsH3gsQpbt5mPe2EvBZrPwu2OhptMZ9BnP9ThXMOWKbTuwr8zi?=
 =?us-ascii?Q?vJYRiI+J98MkfhJit/VVeleuaGjexA5F91garhtKuSKy93ctjj0HOi28KaBd?=
 =?us-ascii?Q?4BD1pUK20a28EtJIHrB34mQDux2/xPo+uZ9VkKGzGmOuBop+D5MIgUm2Bgm5?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf8188b-8697-4998-2ad2-08dcf210ff01
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:43:19.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeeDOnTGzihA1J2Q/FHzZrSlb3p0d1sPoh0EsTHMMoSAlIc2KNMfben8lzUn89+WmMcQ/+tA7WmRaI07CzayE1yhbQcNpZlTI11hX+wsDrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6649
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
> Hey Dan,
> 
> Thanks for your review...
> 
> I want to confirm with you
[..]
> 
> Just to confirm, do you mean add device type check to drivers/cxl/core/cdat.c
> 
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -5,6 +5,7 @@
>    #include <linux/fw_table.h>
>    #include <linux/node.h>
>    #include <linux/overflow.h>
> +#include <linux/platform_device.h>
>    #include "cxlpci.h"
>    #include "cxlmem.h"
>    #include "core.h"
> @@ -641,9 +642,13 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>           void *ptr;
>           int rc;
> 
> +       if (dev_is_pci(cxlds->dev))
> +               return -ENODEV;
> +
>           if (cxlds->rcd)
>                   return -ENODEV;
>    

Yes, this one looks good to me. Place the determination as far out into
a leaf function as possible.
