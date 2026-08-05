Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41236266581
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892424; cv=fail; b=hJIFFGcbqe7PwGRDjDlCW5f9fYRHFlnANyo3Jb6iZSz0NMgn5a7rxVWPnDRgmMc3xkT8Wsyj9xXOCCL2uRcFOQDeiO6mbuVuxDUBBFEkpP0QwWTfAmOtADGj1uBZt18taqqNnBT1Z7ac3udBX3B/Nec6JkgAXv0VHKxavXqtYdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892424; c=relaxed/simple;
	bh=3osqN617y3Exz9GkgFHkeA1sJDfUeXVnmh1sXG5BtRU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VhTqd5TOJ+PkudNhH37wa4I3LZ90Gjibq6Tx1Hlw6Fg6xYkOQgjnJ0ETSc5oBp755nQiU8d777p8qJHuZO7+ywRJH+rDqkuz746AnDPZ3sjCNlo88XD0OT0GHal03lA6UyKA6sxPdSR22NtQJKlfkdP/bTDb3fuO4fdM11QalH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ni/zsF6G; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ni/zsF6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785892422; x=1817428422;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3osqN617y3Exz9GkgFHkeA1sJDfUeXVnmh1sXG5BtRU=;
  b=Ni/zsF6G79gnVMtZC4bRPV1D2ZMDCSBYskCCCW0B9K7l9kMjXQGl1xA7
   EryB9Nbf7eCAUvaa81ERKzaoZ3VaNC4xo9OSck3KYyjp20wGhrGg6O5gP
   +thZoxqKuZXxgCzfH4o1jIyCH5h114y/9WTPVE1w7kUugr4g0xdgqmlmz
   bc8rRzRfkwMhslQfr2rxSUg/Wp6wTPV/jTLq2fNetnYLxp62nDH0UrztX
   LM5jxamyEUmf7qBQniLVJiPfqk99YWGiOoFW7Tr/DVGrTEGR20jhgVVNl
   BwfP3RwnCW22R+MgFLLc4NkONsGPsCPgztjRFtUSP4DXXFDGJzxh4EYWT
   A==;
X-CSE-ConnectionGUID: ZcausO0uQXS71amNCPm+8w==
X-CSE-MsgGUID: JEBRrlMkQdCRYaoeKdqmNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="73992979"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="73992979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 18:13:41 -0700
X-CSE-ConnectionGUID: m5gW2L0wTCuUsW6dYAnDJw==
X-CSE-MsgGUID: 798PDqEtR22bHhxMgrac+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257787871"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 18:13:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 18:13:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 18:13:41 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 18:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6rI+PJ9Dcr0THNSr927ZULOu7sSNDsjH5E1D7w/u94U0DEkOrGwprDoqyFEdUidbYXTsOtxQZjsah3cNRg7xRyxIM7ttWsmGGulv7PpS+En6N1UlRzWGqdkALgGY/EC+OGtmJM7m9cyetLyCfmfGGrrQa/SaGTc3+YBOgWzkJMg/EyKASkGL5TX1wfUob3+OdJ+zN8S0pjkwwC5yBiphHIA+ARquky5NWbecZ22SzzK5SZCpt01DRF+KoqCDsnPyZ7u51kkTCkIRNaPzM3NmX4MGW1jL3zOPeLDDqqwP5rJYmouKr85D973+fLAoOJa5W4n4Bnfv9pyk/XsKc+ltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3osqN617y3Exz9GkgFHkeA1sJDfUeXVnmh1sXG5BtRU=;
 b=ESdTMgpGfVZd4nMapUu4UdQX2p4GkVHgmDaeh/TW894DAimxxMlMgkw5LuzcPWyUVd5drDzLB/uZDIClVJEroxFnbtY3lKLsG/s62/aUMoBKgdVhIu+J5oQU2G8aK1bAokw6WvOZBMSs4k6qRI06vhgQGF7YKGDBpXnk0trAdekFXU2TllfDWgubx2ql8mUs7PrN+pini1nB1emlFU8XxliBQV5jHF6ZtPI1GBvuZDF0sJqUDLrSzmGyv5LJyN97lmFuTyxR6CUJajRcBVeqIDb4f6apPoIa0wVC2uoLb3yqYILhBKTzKFepHT+9YUTQXdNDII86DXijFT7/Bx+lsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 01:13:33 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 01:13:32 +0000
Date: Tue, 4 Aug 2026 18:13:28 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<benjamin.cheatham@amd.com>, <alucerop@amd.com>, <dongjoo.seo1@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v7 5/8] cxl/hdm: Rename decoder coherency flags
Message-ID: <anKOONMaDflkg4X6@aschofie-mobl2.lan>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-6-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260728144136.709882-6-dave@stgolabs.net>
X-ClientProxiedBy: BY1P220CA0046.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB9301:EE_
X-MS-Office365-Filtering-Correlation-Id: 345200e6-08fd-4cf6-d89f-08def28ec441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3zn7++W6c0NektzTzoAsdQvu3wNDalLDxxefpWQZmZtxpGKW032uzM9hIkzawdnJ+xsOiIaPacIJn+uXgtyG07aBIx78lZ3PRgjo7LMTmvLv3MoBRu78ML+x/jmObtCaT4n9+fZRSdmB0GqMjHvgjyJXH5ZVnXvoIT1bpgXLeaR6Gb/BPFJn1PgAtrCcM9auvxKodqiI5EQUQglmPbuqpK+UgJA/KnCONBeRQi0Gh6Ih7RQFd5jWrWTq/zCyTTkSJ2hTsZWtLPVC6oVPSFpuuZhoCH9lP0t+jnhe2IFkEWxE2qxaxw0DNJWOofuW30aX8in8GhLCJHt5JNF77WzPDokrJCGr3p/IjEAuqR9ueqZ5t8z6D7IDSIEUpaH9ZD7bjdlbdNcfOJ/q8rodoJFeygjJuElhJc3GYZeEMb6DCDMIUjJexer+o6V3xdAiWLnrlUCMSS44WQZbf//tJX7lehR2s4tz65r9oLkXQAcRifzw4iS9ImbpGuCDKuAT+C0lF6HYoj+aR6Sz/vBl3b9yKntDf1YEANy2d6pE5rwu1h+WXqGzqDoOJ7rl31IhLECZCGKm1nn3UHHxvGTlz17FltKUJ/ctq/To8Iw2pj8JFs0lYH23WPUjrM3Ag0lkpfZLUSJKXaRhLxZSZV1S0sWd0LO+sqIEn/pkgo1dHvFlhUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rmt8j+Rwc6he4YSg5IfJeTKkHLMaUvWHGT8/VYoBGG8ueatle3RQXgRZXnpp?=
 =?us-ascii?Q?a/m/oI7wHrNnI8OC1qMHmZvoh2VW6T/6L6TrqrmSarVGc0NkNtPrLHcOjJR5?=
 =?us-ascii?Q?s5rha3nmksHdc/04cZTnwaPSOaxF8LnCmMTd38hV6+lUHfccVN0lKL5zBKcy?=
 =?us-ascii?Q?vce2fPbJs6frZghMmXAxbl3rkxhWx70VxrSjrU6t47Lkr4yC17Fa6rjEChCp?=
 =?us-ascii?Q?ZviBbzHVaIOh7Qv+Fdor9/Y5Vtoe+u4gZuiennq7HutDSf5qCJ/VhBXl77B7?=
 =?us-ascii?Q?p5MuMp769TTnbgi7ZRwd5LwlppNqUuR6cQEDY/XU30fzTKxAzfgH2G5Q+R+z?=
 =?us-ascii?Q?Y1zfouun32s0fu6rFpL7e7/AR/rFsYx55OYcTbv4nekeFooQDQlNN0GQmyYv?=
 =?us-ascii?Q?AIDof0U8AWqbAur5/MEJ2vXGuBXZdtoE79HJw67QYMHg3BEw37cBhx77IUtN?=
 =?us-ascii?Q?txfX+cdOoWSE0FzDxD/XMsYW7jwLC1eOEtpvd1ZxSaKhV/flYjoFR+kYpOg6?=
 =?us-ascii?Q?VZ28pW/A64Nc5GHIkI6OYZpFrntkL9mRQV0MrAS00J5gAzNj/rjAksRZP6hN?=
 =?us-ascii?Q?kTWx9DUcqHz7TwJfdUbUXZ9ZFLG1x4RgCKlvQqetQBDk717BN7XAbJ5+4dk7?=
 =?us-ascii?Q?ZuhBMFCOHjIjT3PsNjozR+ZPRu56oayJDoYDqwvl9fWLrLFgcT0Ti9qHf1dq?=
 =?us-ascii?Q?wcJpiPOFn+X1xAPzlq7O2m6z1bspjKhlPhrytxH6eEucmwUWw1vRsaz40l5o?=
 =?us-ascii?Q?CKv9ipT8LNfP6HRjl0SVbP27Do/QaXsvishp9xYwIZT0dSFX7Zqok4NhgeSV?=
 =?us-ascii?Q?8SDT+40qk+gxZwVcQ3ALdgM9Xh3/j+AD05u9lRO4VIicCsc2aQxNQcxmcPWA?=
 =?us-ascii?Q?OlrdJBgg4fZmsP2TuCMIC9fv0GGF5TMBPlgdu3F22IV6NZErpoVgHK1PCEZW?=
 =?us-ascii?Q?+Hkk/46ox9R2WJAXGCK24krhB0Tm+04kpiqgb/BMsca8b+Y0ZQ/gy8gQt/cC?=
 =?us-ascii?Q?HdR7hf+9XrwJiVbpXtq5cPW8+SXGM9GNrnlnPJQwiSfZJGhIjYNcL9+114eU?=
 =?us-ascii?Q?4iMV9Ov1aAMiJLd112yrLJplBQflqkpmf8m9MXZDEsZYPG68zqESs+4WvMwr?=
 =?us-ascii?Q?NzZ559VawOoP3qAIY0lJSJ1SQ/5/fGRmCyOhov5lsLwm8WDAyc7uZIYDZgKM?=
 =?us-ascii?Q?RNr7a9BQIz1stJCTT1tSjopjcTQvDajSCVxbSjXTgfVBRQ62mnmVHi8rK8W3?=
 =?us-ascii?Q?ci3FHs+kVjd1txt+ipDuy8LLtoU4NchUah7zQc8is2TcBmq1mYkSP0ZUs2No?=
 =?us-ascii?Q?6RR+Ba7e2ABsrmFSI6ct6J4TqN8VwKiwI+HYWHyVZbJrnoO3eN6XgHNEbbzm?=
 =?us-ascii?Q?nyttttJvbpfJMKjWCwxZgV4l/ZgP7dkK/YLgxSpfjUw/8q1Dwq9Bx09y49lD?=
 =?us-ascii?Q?LGbQhtjfEYkyWmPloGFgmkg2hE1+WOasAReRCbPWsB6iqC7jcemtJZKrIQIn?=
 =?us-ascii?Q?gS7u0tEOiARGoC+RmaJZF30tZYz5yMC/by93q5zAlWst2esVxNvZeLaxLo/E?=
 =?us-ascii?Q?zi6YuIZDNrZ1OBkb2RtVjK8Qi/W9azdEl4zhkNYtqcdFfIRDHKIMFwXKl7R2?=
 =?us-ascii?Q?1OZK3KEm04BL+2wn8a0LtVTHVFmWry0RPWezhgXkL7X2kBKMd15ijWmH3im2?=
 =?us-ascii?Q?0mCMYtP8Op0UtXFKM3SukWsClNv65GlHrBICHmXCRHwk9C3rH47foYKz2o4y?=
 =?us-ascii?Q?1scMn4biqxOsamnPiz72f9su1HRk6Bk=3D?=
X-Exchange-RoutingPolicyChecked: BrQO3PVG2yja2kN2korf1R40lN7F4M2gxjx94eHnOYdp7sZksE1j5xuy7PARt8QRByPxEzNoyDNY0Kubef079KgX59PgmeCiZkRxKbS20YGXTcSuWQkxz/NV1OwvPSej3T0D6jIB3/99HIOzIx5+688py7AeYJ/5zW62sfGx1UUWuW5tgqFzDl5oTBGIA1XH6uBMJ+Ify0Hs6bTIjE+MPwhMkFOQp9YwVpd8Brtwj+jyTgx6BrLm7Rvcsi4d2H15EGgrys5wanu9cESnpEdX7uZZ578gBLlrIzbSPO232lvvqOeMR2pjzIAQvr0D53VIb+jj0d7TUPQ+fQBm0/8rwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 345200e6-08fd-4cf6-d89f-08def28ec441
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 01:13:32.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPN7WvalRSbZq6Nse4CYIN+qODNVSZYWmzFQp7rhC3vT38IHzYnhI1yf4fNvH+jU9sBknuaLYmf/5im7Ivcj004eemLqH4Je1fy7oRFNCCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9301
X-OriginatorOrg: intel.com

On Tue, Jul 28, 2026 at 07:41:33AM -0700, Davidlohr Bueso wrote:
> Align with the ACPI CXL Window restriction naming and convert
> CXL_DECODER_F_TYPE2/F_TYPE3 to F_DEVMEM/F_HOSTONLY. Type2 and
> Type3 coherency models were named prior to Back-Invalidate.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
