Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262D51615E
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786852; cv=fail; b=UXT0U2xUwl6UPhjKCrOs+bmo6HfV0LR6+tNKglHJwWo8uqOnM5INkN4V99s/x3Ra4tDaD/dtunU/XBn4oF1wHKiyjVU6tTCAcRZwM6AIk3abdTe3TLaqYsax0OHBlR6pI80iWtaihuS6d9WJ9/cBzeV++vtGTg9awm1sDJRSlHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786852; c=relaxed/simple;
	bh=Xctr0x9b5H8fpemUeKTT8cJna/FTWHtOWxCb7dgLvMY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WCaUdnKqPav8+ChcrZVQu30GMuwyi366+yuP6amLsdx/ib7qphkXXvKAfBG+AKzzmgVnyvjd5awsCA+ESk+tPEQ4muBEpBtkC1q8KbauVmcVa9u+3RFKgVbEEaHmG6N/QX69kRLfUa7xLUQqDebxss0OrqHDNrTo6Adkmf3XaYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNbt5v0p; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNbt5v0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790786850; x=1822322850;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xctr0x9b5H8fpemUeKTT8cJna/FTWHtOWxCb7dgLvMY=;
  b=aNbt5v0pOq0UGIBHm0f9r0S9/8gDGwgTczS7ueEUgDZI5L0hT4MqauHm
   DwZ1ooTDzr8b4zPTtGKBYYMSvRkcWgb1i/QZI9KPcXl5si5qDSO7h1Ph+
   bMHCndjtJaKMfnrP4aD2bPaZ1K+N1jLlyJcyzRUer0SuAd//BFkPdjudt
   n3BvICl5bbFaL/9Gfz587KB7cBJHW0j//XvSTtb3RUU7cC2oZOY47Nr0k
   GUPSnzwEPU2EW9/LCym1x7hgEUa3G2SlLi9W9eqamKJebqo1ye4ktiK/Z
   CGiy70CkSH0Q1rslDnzS5d3EVf/jx0P3APmpktnlWk/t5zERnE6RI+SsH
   g==;
X-CSE-ConnectionGUID: 4qIfdOqATlOmpKDMNTT0sA==
X-CSE-MsgGUID: 7Ae7aEYsQ36zuDonwo9mUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90662374"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90662374"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 09:47:27 -0700
X-CSE-ConnectionGUID: oSA6Jv+pROWsh5zashKFLw==
X-CSE-MsgGUID: dyhmZZzGT5iNJwpmtuuUSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="303675509"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 09:47:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 09:47:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 09:47:26 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 09:47:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlrAOJ6Z93bzZQJGJsWqLqjoKLrGpmIk0WRlS7FR9o9S50ABCDQ6c1QdL9+2OBSXsFtH+wofWCqtBZc5BjFezCNYiepmGP03J5Z2AmauVCmTBfbN9h4EBRT732i/e6u5GlUNKrg7aq9OWwNmMyH9FZUXhjoJnFCk993DgWYJv8iVUHe/d8CcsgtCMRjEvpJuxi1h1x6KDpRZhsGtNWiE5IjP4l+T22tweh0MIu1XXQw6GQIpuzLFpC64PCaZ0RS8Cos7WSqDwHAEMcHuWIHBPUgxpaiLv/O6oIga+bmdtndlLUbIAaSQc7JZlffklb0Gg6/eIF7eLHUZrwRQlR5WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp7SiLpQNk/e5d/tSPkk+s2OjMeUWILNwewgq27pTYM=;
 b=ya+xUHn0lUYkg08TGRsBEi5qiCvybocMEbT++FeX5UgclJQa/wdVcN3idgypZmib0rV/i3jk8awqq6nXmV6BkaLSxR/YXFURXc8VRDV2tsQv2AfCaNJIrhSF7kKl3A2CrDstX/ETOVbq3XnXsZaOZVJwT/zG8EcLjZ+PSgA79NfQ2+SU2g5Y8wbe2KWnDaoxMdjvP0NOwkOgAy3X8AuWZSyT7SjF51zmbtIDe1zvKeDAX4Nm2EvC28eGjToxJy9mq+DInyWVltdkpiXxu3CGkiJtf/sAEu6a32QwhjrNwGUl51CJf5Z0l0DebUi3N2tifVzV9lmyg2OAsSnB1fE31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB7645.namprd11.prod.outlook.com (2603:10b6:a03:4c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 16:47:17 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 16:47:17 +0000
Date: Wed, 30 Sep 2026 09:47:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>, <alucerop@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v9 0/10] cxl: Support Back-Invalidate
Message-ID: <ar09EVGzKTm-O5mm@aschofie-mobl2.lan>
References: <cover.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1790103847.git.dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: b8803218-d065-4e5c-0533-08df1f127ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 150WEoJPFmsrG1+UUNLmPqJ2hDSE+So69kx+qHKlaZEhnJGjRAKdRFUf2ePB+Huc4ETGAClvchTGyg6KL5j1H8GCTJXfkCCyoh+F/IEggwnwBYtfVcRlEH+MgrfpgqI10XgziCXYpz5L4FJC0celibNXuo6VkHZUe2Gm2moOWYgE+1xp2T69FWpXGG3oHcUyRE2RWynuhCIIi7b4h2QKN3/SSEfveAusTWUlYPEHpWcLsfbPZlIe40JLdK5g460m+CaaX6hmfm5efM82KOr+AWN4ITDsu0kv+Xmmu5iPIRnF4/JQeGAgRYtgzcHeqZs9OgM9dHQZSQKFry7opM8J1pWFj96RX8GqDDDd76/krbiqzI/JqCe6CN52N5Uw9wF+gjkyiFRlHWhKNGhoLydCZSNxlJ8YnEptTABHe2sk/AQRskazywg0vz/5g6I9Y/FwA9FqR/7dacPgbQX6MTTB3F0EjTnJRYk69zY0kRpRJ7pX35oHwDEMDEVGzzCi/M7/ZVWIsLkPfVbvVop2bVheFtZ1bHB902aS4AtyWH3FiQVlTJKDCMVKbB/QAJfuHlghdsV6vdmLGxWFyYWop76z9hs0ZAG+Hfdq6bVziqN0Z6mSjY617AMsljZ4MqI7O9GCelgC5BvFdF5ESSD744s5izm6ewI798bezYxvnDfG7zU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6NrV2s31tCiwnXTZPXYHTuQPDJ4aqlwkLjcmGD6cXsSuasyP1fHNJt74RCcG?=
 =?us-ascii?Q?JUU2z2fpfr/kAHjMbulP/fI5Fxet4DvIOfeQZQRAMvBjQb9gVoCmWZh6rb5/?=
 =?us-ascii?Q?TMd4injZ9SSz7b1mGeCi8D5UrBlvP01rdqIBIWNfBmd6w6dXemXWpn1Ud57e?=
 =?us-ascii?Q?JZRrqSNjS/qg2uFd1We07bDPwz3seOAGou9qwpdNdjD4JZja5ECA9Bx/fWw8?=
 =?us-ascii?Q?KiKPNl2Hu+YUFRUk4/BE+t4vwcLXxgOO+/gT4FYG73GK3G1e7o62c6RBx0Cx?=
 =?us-ascii?Q?dAYsxR9Dh4Kz5b8L4cOw1Z8a692sam1rsOqwm0xAUtoitANS20kKraCWrjHK?=
 =?us-ascii?Q?E86eMciAooY0vjpJ03UIHRTmj3WhKG6UCNyFkcxcydrEODB/XRBGeBm2Z3wo?=
 =?us-ascii?Q?ODZwapd3tcbCkObSYl1z1AhAXajVDTYrLhzwP9IoBB6bFzGxRUdELZnHA9A2?=
 =?us-ascii?Q?0zkveN2/0UBYLdunJWhrlL7xbnkQ9GPjvm1HZQqBLsJ5q2F+SJrbO6Th7gCt?=
 =?us-ascii?Q?hKN9iCE5UAt5GsW+pTbs3Urgbc3n3lCcRD4BTBt7oFPlzLubTndTIz62iTh3?=
 =?us-ascii?Q?dBZm4qUDwXDNnDvZqRvf5zbKASQjBWlVcw0q7mJaThjWQMncYgg663pSSA0a?=
 =?us-ascii?Q?QQOgYmqcZ0+xneTDY0GjnkJj5fQXNq2rSAXaWCqRvtd3BAJRB2Ditn3K63d3?=
 =?us-ascii?Q?JPMecPZXtch/tcYRxQ0nYqkdLi/qy/GScXgbxq8DO9XLk93dR/ywslXEF12i?=
 =?us-ascii?Q?Nyk3S53NPobKLxvNmEvR9nlCBpkmHHP0yNy0cshjryVFtYxk/WI4ihT1Pmih?=
 =?us-ascii?Q?GBZ0QJhCXEVikgd3tGoLjcSHBtuuJeuVKC+wekgqCvT3AOyGMBO7XSLc1H2v?=
 =?us-ascii?Q?0ewGjxfr/a9Bi98xaGj2KHNAP228xEIzPPf5HSaQ1ciEGyuC12BT4GQFbhIp?=
 =?us-ascii?Q?IC0nEzo50UWR983BgoqPTcKoI/haXg8QQsnvyB55+xr4XEkln/7nCh/A0Igc?=
 =?us-ascii?Q?zklS06BbgOqYsqJQnN4qYLaFAbktzUJwtpBSAefkNSd1/KNHrJ9017vXzRRZ?=
 =?us-ascii?Q?8D/7oFG8deL+RZO76hF+vkMR+mp3hNK4nlisnwumoIGVA5YT5LjxcZcC49N4?=
 =?us-ascii?Q?ayQcxvnSG/USomSg3BCQGXjPyxURvt0KZk9j3KMMDpYQEdwQbA30ZXpyJfvN?=
 =?us-ascii?Q?53vlwrXAYLtws8ODcWKz7jx2/UvKannEOAtW8FEFBlFuOPrF3WNISIEpHdyR?=
 =?us-ascii?Q?gu1Oj9briIx/x1vNHpVts+oU/9dW43Lya+S9uU3iXTs0RlUYGSAf6zzLPNvC?=
 =?us-ascii?Q?MWhz62rtdqkDqMlwS3MT9Lx0pn0oTvnEyoa7LLGBz/Mk3KMYK7qjf0/bPbQA?=
 =?us-ascii?Q?IgLnfRbyTUi3iJSwya4rJ5e5JWHAT0/drm/ZYEP2UuFjJRxab855hpJVm3Kx?=
 =?us-ascii?Q?WrTdvys7tq4p0Cu5bsJAF5/JS+OGVWOb4tkwZChPbRhtjKBqeCW0pnmv/cTa?=
 =?us-ascii?Q?ptwZPTkwDyQ8Zlue8m9/vmlYRqPXTa3upFNdoZDFwX3k4OxPHr4HRMePdnXM?=
 =?us-ascii?Q?+mhaKLXV4sSJSJl0Xou68WIX2xriM4WDObFbNWUe3dYc/Fg5E+3gUykW0uTY?=
 =?us-ascii?Q?Z9m3wD0Adp5YGqcMwe8745oaEou0te0GJM9sBn+OOKfe2cl765jWbaA4GHMW?=
 =?us-ascii?Q?2I/r/nr/wsJ+qHdfEVXBUOR7dR78DkWaURz321TO7SCZpxpo49n+j4Hi02Pm?=
 =?us-ascii?Q?nJopcAwzU/Zk/X72z/NW+VFTrnxE1rA=3D?=
X-Exchange-RoutingPolicyChecked: ErS19jbr8LeO4GlFjO+vq+s0oqT/S4kUNpF+PVopjNSR3AYY/J8PQ/Ead9b5mktTtPGpr47DEz/fdFYq/zy+B8RsbfQUbuhINd+NmRx2kx0Job7aqm6g5FJ3TKEzBezdVEXY501NDBMFBUAqDZyu/MWMnTuvmHfvN2bZ1tpKUcTJLk18XwgXYgQWidUNvNiON58Jvbm/3pe30kdulaJZOnqgK4KNzM20Iopknrj9ARzyDrvzBLyaAqKDG4dXDJkiACOA5n63Sr+Kpb4smLJyf/UftW84Ayw+4bMnsv64HRyIwtR3o/iySlmxRlbsSzlZjtW5M20NJ++b36mPc39AVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b8803218-d065-4e5c-0533-08df1f127ca2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 16:47:17.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSVnV1VNffgPcUm6CxN5Jp/Yh4A9dQ4j5z1QY5RSQyC7xmkzygmZb/EMH3MWJpUFkI33L2TLjbjBTtBdIVyuV5GPSyjJ1s3OtNdVoA7S50o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7645
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 04:38:37PM -0700, Davidlohr Bueso wrote:

snip

> 
> This passes regression testing (nothing breaks) ndctl suite via cxl_test,
> with the mock HDM-DB window of patch 9 and the BI phase covering HDM-DB
> assembly, cxl_acpi rebind replay and the Type 2 accelerator. The BI
> mock device test script along with tooling to consume the new sysfs ABI
> from this series is in the ndctl tree here:
> 
>   https://github.com/davidlohr/ndctl/tree/cxl-back-invalidate-test

Please post this to linux-cxl and  nvdimm@lists.linux.dev
Thanks!

