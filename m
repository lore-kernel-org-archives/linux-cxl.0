Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02061E2848
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842119; cv=fail; b=g2C4JTbOMZ/YZOKX6FyEgUAk/H/Cpf19bJwHj02tvOcj+ushBVgOBBrHPQDdPbzIiwbbE4rvLjZfponf4n+ocwSrFe1JLPb871zw0QaTKDCFdw1Pn1T5mz++SWR7YC/eQGDF6/czihbFMkVbnV+mYbzfp83F5lp7faNwDfVigDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842119; c=relaxed/simple;
	bh=hzMHPkH0oq9n6SyoQA/O5+PtBrgio/O8r2tsRyHBmy4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MAqF9FYyesQ59vGzeJyS3f7i5zo5SDMxBhBl9lQuf5AS/dwRWnAz9tK0LF5dqvoWwAN2PlcZgSvxpex+EsGhM20hoAHQ96vRmNCQkfzwJcj9BqP+BX4rZxLoT5XXgjKEBNoSmb4KeRINooLCrSapiX5LZcoEBVybCTDBbeg78zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVI6gOap; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVI6gOap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747842118; x=1779378118;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hzMHPkH0oq9n6SyoQA/O5+PtBrgio/O8r2tsRyHBmy4=;
  b=jVI6gOapVY4bRPM8dIOsljkdhxoAl2N6w91arjAU7hIhp9Vk7Porcvjs
   7jKrfbI8ttBGlZYNNLPMZHacFF+1h0cQw/LtVg/3Y028vbkduSFh/HDIy
   OLl3nsYaXFeWrLuFgabQIkyWVuSXUgnGm78vs7Gf0JdHIbB/iYMGaIq3Q
   ITJJhzBe/MqlaamLGL0FdqrTZV7dTXMeuB6O8AJHMah/h1FKvL2qn/i73
   3D6zrMlikab5v6o/g4AqeQ86bCiPqBdesYYVa2d9of7Y5o+J5KqP6Fi2I
   /n29LQyj8tDALoInxIHdJ7C7AA7T8ItZJWXRUcb05XCAfyPE+P6GAPAA/
   A==;
X-CSE-ConnectionGUID: 2PdEHxSUQguQg7WotpuwrA==
X-CSE-MsgGUID: Af6X6GFQRtqIcbiHyYdsFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49086122"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49086122"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 08:41:57 -0700
X-CSE-ConnectionGUID: c2Qpo2HbRn26p99qlKUu1g==
X-CSE-MsgGUID: La2g6hVlQcGdRW53pRPkAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="139972089"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 08:41:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 08:41:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 08:41:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 08:41:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6BXW+tEXP+fyM/etQ1lEScKNufFuc0Hqv4gcadaj9CnlOHZeGlt4wJpwHU7gadfcAsc+dJf9ADWgK0ccQ04pm2tfaYmJgqgljCzYsIsYDzk0B+7IxTWCjwLvNgg2D67RpXMWycN6q6A7qs+O140tH2z7aqeSSisMgBTHiyZe/X+Gyrpl8BvqgfC9NtHV45W5maHv1b0cOma5Zcs1WTZB0FxVKa9OOMXd2d5ezVpHEqse8t2PV54FCwSIdEkoKRc9jKrysQxFdBwWBYpHi+ChOqK/YLGSTtl67Eybk9rLMwBSg75MqqmXXKsPwGWm3y+O/nltJd221ik4qwEhxcOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFZ5UwzdVJTSWc0HpKYtftLwXXlhaoMWpkI2t6JAwZY=;
 b=w2OD7gilO+Nftkk6+ve9W8/VB1sJixMlYA96EQoMbkuAqSZcRFp8nNHv9yuj7Se8Kw+lNIWOGbRsUTKc/ChjtmhPbobUyBbGRvEratSGeVKI9Uw5Yrl9FMXr6mTS7QLXhipt66Lb0F4z2ZSdEl41e8z00Z+vESIkaHJ0ZivkCdSDHFbazSZc7d5Tmo4bzeVmekBzhWT/O4YjIjeA4r4syfPYW0lRveWuZSJrDC7pEcPonB+3q+odJjUwjlH27qoS51zaJsEAxLU/oD82/4AAvHqyXT6lz1n/wOk6XXZ2Qt6dMNS5c4K8dH18rtp4Q+TrhCRsQqLhWzzv6K60vH5SBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 15:41:49 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 15:41:42 +0000
Date: Wed, 21 May 2025 08:41:39 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: Internal error: Oops: 0000000096000044 [#11]  SMP
Message-ID: <aC30Mx7NM11wiACv@aschofie-mobl2.lan>
References: <aC2RKceK4HqYEQo/@vm4>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aC2RKceK4HqYEQo/@vm4>
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|BL1PR11MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: c16bac52-be3c-4b53-3a56-08dd987dfc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kpS1T/y+D02GitMsZeuphToy6NoQdI5kLUeVOaCrRknn7SZDjS37Y7Sox55T?=
 =?us-ascii?Q?/IM5wbwNWPwbiodOBOt40VE7mnDb6a91Xk+Cy44SgC9ktgPMLuUHiJUukC90?=
 =?us-ascii?Q?Js2Xr8sUwMfl6bd5V9fxwnC3auOkQhc/hl0liaGJ8+mBxM1qsRWE8oBDyuGq?=
 =?us-ascii?Q?Sx39+07V67K6nxeDwa6OCb/mFnfMj9SI27+ItAe2OMUuUU/ghC4GBY6BqttS?=
 =?us-ascii?Q?X3TRuATkCW3HWh+gtGhTGyuxChC21QvOU+6qCiK5GF1NCGcR2kmA6ik2uzM6?=
 =?us-ascii?Q?BXM85j6ARKKJHY6cYbNLyacTw9TGOvCOBykpN+Wr11MoDc1i+BKCR+I1FQyG?=
 =?us-ascii?Q?XXSlzNgxjc/Rzp1L4dlgHeRhzmM+f8QsadKpTo8okq7ZH9JuqPyrHaYVCiBy?=
 =?us-ascii?Q?WkFRrrOy7e8cl2xdCvGzBIsWJgRjC7OBh5SNwvcUnK6mGHB2uQOeb+0tJ60U?=
 =?us-ascii?Q?w3qn3Wr2wNtdfl85YrHe5/V5TjxIOkthctMM9gNUuxJIFKoXVp7aDC1grrf8?=
 =?us-ascii?Q?ErXgNQs98XXp1k53qYEmKTGLvtcgcacm6pvBrRRQT3dfdES5hiHkaYIFalvs?=
 =?us-ascii?Q?eYhV/n6PN3Ro+nw7yaW1YJGIZdQfV9g2xdfzSoZA0yWANAOvusQ4JU05A0tB?=
 =?us-ascii?Q?LHIF4cDHjBRV84D7tzn+RrDHO0HPqFgrjJR9Xad4NVK1CIKwl5t0YRtvKdYo?=
 =?us-ascii?Q?F0D2KRP9xcuhKkMc8qjUcZ03H3ZIxsOpgfGmwETvtI+jeE8oHbRnuSiSzFl+?=
 =?us-ascii?Q?OmOEaaOy3norL0RGIjpsbSdRTbzUAttUOjY229AGGkgNag0kB+wRwQrLaDic?=
 =?us-ascii?Q?GUSDOo4Jocw646DZBAVtD4Ha6CyWr+m3twoKOE4wqfmSZdBglZvHluhzWVmh?=
 =?us-ascii?Q?9FKHDLHZh+oS2Yp4Tg0uMcPzuSX79ZZRRj4TMm+F5cPnDgxXngfh6r+avZ5D?=
 =?us-ascii?Q?MY1nQw3+UzEwVCTFC1RngDMIKCOjJtn1Bmql3ZavMTP6/1PU98omD+56ZCYN?=
 =?us-ascii?Q?MdPnPRmw52aNHCi3BTK2OrExVsue4MRyq1obdMb2XkY/AU9khBcWUzI78yuX?=
 =?us-ascii?Q?oEQpRAUKQAysuP3ha4gqw0zrg5eI3YPBswUCDOxTrH/NCAJ2PGwztAeiO8TI?=
 =?us-ascii?Q?g6beBAjlHllVzRDc/yNoomutdo6Beu60wd0UnH317S6ndGIDBKrqrQtZzyk9?=
 =?us-ascii?Q?KIQz25u8qzPEylUctxuNzp8OhoTVyLdKehH6+W9oJXqLT1n/dymb8/70dsCy?=
 =?us-ascii?Q?2HI+cklHTDQII2ap11+9JmS+SMkAwflZtxNAMCPz9P9ABSz5iVj7CFeUcaBc?=
 =?us-ascii?Q?/J9Qmr51dxJYwmQ5Lxdy/ZUF7UZSeNYh9kqY414cGdxFfWd1AYJsqp4ZwD8Y?=
 =?us-ascii?Q?YOTDk0o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nIwcuVZ4BUkm3BPnuf8dbi24Zz8TEufQWDqOrVfJDJ4iy6lNPZOjXDuvB0Ce?=
 =?us-ascii?Q?HDWcZFEagLXBFDhrOkeNx4zshtW5INcefRYxowmCgcvVvczw6xfFc7xJDWxp?=
 =?us-ascii?Q?o6wRU8TqmYEHkb9nSb8q/vBB+K8+p3gz3Cb/Rk3cz4frsv0P6Svnvn1JgpIM?=
 =?us-ascii?Q?5EYfkm1tR0RlwTuESRbWvl5HroyKSaPF34dfQRVzdqnVisz3QkrFf/awzKf6?=
 =?us-ascii?Q?Cceq331Y9oki2AXLxa+sDWtJX4lzco+H/+7E6uvTfr0NWm199bpRMqk0Xrsz?=
 =?us-ascii?Q?SrZ7rAtmmzFi8ul67wakchh/RHSCESi9rI4vDs2PVY1O1C1flYPetT+dQuxJ?=
 =?us-ascii?Q?WJ7IG3G9bMeN1ODN03dbVP0D7ntoCBHW3gxhg8ii5UqrwXhpHIenNfk+PIFu?=
 =?us-ascii?Q?51n6/ECjfVOP7TkirVtpWoB2drkHBwRJbC1TisWSjKZsosHmaUa9ky0RIOzF?=
 =?us-ascii?Q?tySZEJKBLYslmmnLUpC50EQriptUWAt8o+pq0RhdtmgY2e4cqx2tycUksT8R?=
 =?us-ascii?Q?EdUuU+QMOjtljip+Pjg+DY6CAZI86YienrZMUoT1EJjhPfJRTpRPph59GfGx?=
 =?us-ascii?Q?J6sbQ0MiMmpOUtjJVzuAwS5HMovAsUN+Xz8zdkUS1HQSQtdVV/ie698eWEmt?=
 =?us-ascii?Q?EF1096zk9ishM54QabcGsvgoLEb9jdyp38exId8nRDTnKupmbMsxfAYeTeDq?=
 =?us-ascii?Q?/nTDRi2GIne6kpcVlSQsTR2WFTBvCyOUtGakAG5GQ+V5ZwdTOZu6GGgjbRRx?=
 =?us-ascii?Q?XdcxjcaGJqCg6kjvoxzAyKk/7ti8TRR6V9uzOFYd+VUipogHKdlO6j1XfSep?=
 =?us-ascii?Q?+eYCKLcDqK0JmDCC0Sl2ABcDa4S+oG3dL0DtPmE4Tx+NRPc/cUq6Dwp7PF3X?=
 =?us-ascii?Q?Tzv4OacGrg0EoPCESU34cvB6wjO/NYJ52fUpac1uP2488Mbyv6dHnEb1/HlE?=
 =?us-ascii?Q?O30KXez1xoHwtUGjWokCr8nLwlykvJO2dq/pwNAMvd8Lg1dUS765Bl2slimn?=
 =?us-ascii?Q?A7d/Ovs6kFHRDQfEAPWsUrePjlO+Ig2dk9YuWsD6lWDQ9KT+aAJFplwusJtA?=
 =?us-ascii?Q?tTt0CPviLlSq/Cv+/4xwvuiLyoysRbWbq90Eh17a5QSExiyB+BlLhJKdF3Cg?=
 =?us-ascii?Q?rq2sZW2xBQ+Qpv5cLa3lnEB6xSUD+FTZn2GSTSy2etvnkevzx17z0IzLQibz?=
 =?us-ascii?Q?oXAmYorf2tPdXEzVNh1wpZRlJ4r2wZyc/rlWtG5aPeOYpjSC2KxVbtdFC2dw?=
 =?us-ascii?Q?SS2VkV7b8IFz/2RKq7wPGBZrmjAxZf0JWTzVunRy8KSNmTfzMKtsZNW+0ami?=
 =?us-ascii?Q?9sMPH4nWYB/rzecfCWAxOwNT9aHqZVNmIK+dwMsyA36xJRuC+G/zDJi4D+Jk?=
 =?us-ascii?Q?YgT8CsTYPNR7cy2WXUdRjsgDA65TaSZVpsTkRaqj16o4X8UAzNBqeTZT/cWg?=
 =?us-ascii?Q?Vof7btKtLF49xRqqSPDMuVTPUH7v/v5VhaPO0Gykq8kRgIQx43X5gm29v11U?=
 =?us-ascii?Q?mhQve8/XWWBJIVlCL5U8iyYFnVu3SBXmKW9cawrWaclhYzk/bZw1t4uU7ne/?=
 =?us-ascii?Q?QhTbS5eA5rWwLhDBZwcSRGFi7uyhJlzpA2JsirdyemCrsGYXdPnEAFfnQvS6?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c16bac52-be3c-4b53-3a56-08dd987dfc3e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:41:42.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvSdgxF014GNa/dZ2dwtwPbcP2uzEJfRKWBJzadKkH6b5SKm58kVyw+QjLrHmhtb+JoK7UgC4NFhmwpZiTA9qmm8LB8JFIZRcoGVee5KcvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com

On Wed, May 21, 2025 at 05:39:05PM +0900, Itaru Kitayama wrote:
> Hi,
> On arm64/virt QEMU, the cxl/next (as of today) kernel prints out Internal errors:

Now I'm connecting more dots. You posted this previously here:

https://lore.kernel.org/linux-cxl/49A4B521-AB66-4037-A23D-1D0D7AF0F42F@linux.dev/




> 
> [   80.968299] [     T48] Internal error: Oops: 0000000096000044 [#11]
> SMP
> [   80.989250] [     T48] Modules linked in: cxl_mock_mem(O) cfg80211
> rfkill cxl_test(O) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O)
> cxl_mock(O) libnvdimm encrypted_keys trusted caam_jr caam asn1_encoder
> caamhash_desc caamalg_desc error crypto_engine authenc libdes fuse drm
> backlight ip_tables x_tables sm3_ce sm3 sha3_ce sha512_ce sha512_arm64
> cxl_core(O) fwctl btrfs blake2b_generic xor xor_neon raid6_pq
> zstd_compress ipv6
> [   80.992210] [     T48] CPU: 1 UID: 0 PID: 48 Comm: kworker/u8:2
> Tainted: G      D    O        6.15.0-rc4-00040-g128ad8fa385b #40 PREEMPT
> [   80.992791] [     T48] Tainted: [D]=DIE, [O]=OOT_MODULE
> [   80.993039] [     T48] Hardware name: QEMU QEMU Virtual Machine, BIOS
> 2025.02-3ubuntu2 04/04/2025
> [   80.993400] [     T48] Workqueue: async async_run_entry_fn
> [   80.994718] [     T48] pstate: 61402005 (nZCv daif +PAN -UAO -TCO
> +DIT -SSBS BTYPE=--)
> [   80.995329] [     T48] pc : cxl_mock_mbox_send+0xec/0x12c0
> [cxl_mock_mem]
> [   80.995691] [     T48] lr : cxl_internal_send_cmd+0x40/0x104
> [cxl_core]
> [   80.996189] [     T48] sp : ffff800080d0b9f0
> [   80.996380] [     T48] x29: ffff800080d0ba70 x28: fff0000008dd2410
> x27: fff00000088fb390
> [   80.996714] [     T48] x26: ffff800080d0bb07 x25: 0000000000000100
> x24: 0000000000000003
> [   80.997135] [     T48] x23: 0000000000000020 x22: fff0000008dd2410
> x21: 0000000000000002
> [   80.998119] [     T48] x20: fff00000088fb080 x19: ffff800080d0bb08
> x18: 00000000ffffffff
> [   80.998419] [     T48] x17: 0000000000000000 x16: ffffa8d169128748
> x15: ffff800080d0b5ad
> [   80.999243] [     T48] x14: ffff800080d0b400 x13: ffff800080d0b5b8
> x12: fff000006f7a0000
> [   81.000519] [     T48] x11: 0000000000000058 x10: 0000000000000018 x9
> : fff000006f7a0000
> [   81.001337] [     T48] x8 : ffff800080d0bb48 x7 : fff0000074fa0000 x6
> : fff0000074fa0000
> [   81.002497] [     T48] x5 : fff000007f937508 x4 : 0000000000000001 x3
> : 0000000000001000
> [   81.003993] [     T48] x2 : 0000000000001000 x1 : 0000000000000000 x0
> : 0000000000000088
> [   81.004223] [     T48] Call trace:
> [   81.004795] [     T48]  cxl_mock_mbox_send+0xec/0x12c0 [cxl_mock_mem]
> (P)
> [   81.005136] [     T48]  cxl_internal_send_cmd+0x40/0x104 [cxl_core]
> [   81.005520] [     T48]  cxl_mem_get_records_log+0xbc/0x198 [cxl_core]
> [   81.006042] [     T48]  cxl_mem_get_event_records+0xb0/0xc0
> [cxl_core]
> [   81.006246] [     T48]  cxl_mock_mem_probe+0x568/0x6f0 [cxl_mock_mem]
> [   81.006417] [     T48]  platform_probe+0x68/0xd8
> [   81.008340] [     T48]  really_probe+0xc0/0x39c
> [   81.008885] [     T48]  __driver_probe_device+0xd0/0x14c
> [   81.009539] [     T48]  driver_probe_device+0x3c/0x120
> [   81.010239] [     T48]  __driver_attach_async_helper+0x50/0xec
> [   81.011130] [     T48]  async_run_entry_fn+0x34/0x14c
> [   81.011276] [     T48]  process_one_work+0x148/0x284
> [   81.011420] [     T48]  worker_thread+0x2c4/0x3e0
> [   81.011552] [     T48]  kthread+0x12c/0x204
> [   81.011693] [     T48]  ret_from_fork+0x10/0x20
> [   81.011840] [     T48] Code: 54001b28 a90c6bf9 52801100 f9400a61
> (a9007c3f)
> [   81.013772] [     T48] ---[ end trace 0000000000000000 ]---
> 
> How serious is this?
> 
> Thanks,
> Itaru.
> 
