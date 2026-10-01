Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AC3C3450
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790825345; cv=fail; b=lxXZNNG8FfMQUqnNDAlyDHywSTN1TnFM1mfX6AaiE86jS50QhwEgIlT0z1SvGP9nzDXZtA3ZzC6yDe+7YyRzhRbuRycyM9oVsPRpjlxyp4m2fEs0YrpXohJu1RjWlEv+Cmkwqnbh+okcrjSKRAnat5/Ex8WQbKGULWAtsywpy6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790825345; c=relaxed/simple;
	bh=geSzcvG3PZAYFf70bF8MANSEC0kWi0knuXrKA4i+eqA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbpQprCjri6V3uZKOVZdqqyI9ssKCMY/Hlf/2mrT2t8PlUAv9JOh+WCPVF0WIngzl0+1JY9V3i7S0Ct01kNDBoQ4Wlx7YIgwXNrvsVuelATGsmt+euOsIB9eq28Gn+olnqjXDtQNxhHj8iVcJ89gaEi76T81jZb/v3bwIbHk4Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlqXypYb; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlqXypYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790825324; x=1822361324;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=geSzcvG3PZAYFf70bF8MANSEC0kWi0knuXrKA4i+eqA=;
  b=TlqXypYbxLeOoHLGl+vK/3QUooncx5jNgspq5+jccn8+p1Tp5XF+rVUR
   Qdj3yypxHQx+rWLDPynz0s71ksVfdTkMXP6chYjsyWKQr/iOYjbUan0u2
   fps0D+rTKjhztBACXyH1Hpk4lbc4XwIsTdPXkAKlpYjC3NnY6p4IY2n3x
   01kLKwMJFZrEUcED7UHJoNLrnXurpCceRDcde3j4DtAp5dsfGQ6JoFC97
   CgmrJwpvo7NLLg8XOsH8EoazWhkkQop488TyvBD0RwWd5qvF/dEqrg3wB
   R2h/FXz2u57mf9pNjqFJINaZ4pXdiboLAs4p4W30EBip/ACJ265fsrhgF
   w==;
X-CSE-ConnectionGUID: essyAk/8Qp+G8gwKolLGcw==
X-CSE-MsgGUID: V4b3SazgQPaQugLBndIVpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="113362621"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="113362621"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 20:28:41 -0700
X-CSE-ConnectionGUID: PTHum+/fTtyBkpcg9y62ow==
X-CSE-MsgGUID: cVWW6mcASsacuF2K+07jpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="275908902"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 20:28:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 20:28:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 20:28:39 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 20:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVLZTMTB2JkXiQ6tKjpJRYC1W1nPnN1y6Ik8DxN8I0zaOOZ4XunddWUsdDQy9nBy1mDExbLSnydWWXuqMT5lsxbRJ/APAuJCNgz7RhzgypAg1s7XwKnQ/vRPZUuJ2fCRMvuCJ9lRiKTdOuE1QVyFa/6nY1HI/IMo3gglCxo3xj+H6DAehl32iX/AR9UhlqQ0lJjRfnR+4sf0BEcPXZ0gzfvzI8yFqHcQJtt2P3mSB07MdF15FfPhGuzf7Pz2rArbmi0DFV6jsOT6e3UcOkiRzHANhlIQi/At3lTuqQEhghKNDw55r9qVjkk242ucBftgzoRgyzKJP8xKY8m5xeotKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mlyN670698egt4ObhNbrQ30aUv2xfDR/9g4vrA/qLY=;
 b=NmW092MiVVb/4D3Wt5kKVxJ4l4W8/rvQ8VdH3p9Fpbm1FOgiHxFv3B+ZO1mkWhsB98zViY4yWUxJX4JRwCnW/o2q1n1kp4Gz1wBoEDMuv9H9Q3sNTSHv8PZvewzE1GpxFMl3dQVhxiwyr0XkbHB5Y7iV2CfCQHda7rk4lg6JC/Zz8vI9JBl/dF9uu1nxqCiPg3h3nAPX4kc+loXhQ/+jUWmqwC9lf5vLFhj0WUogdCWFHCZByBOdqjY0jnvmOyEi7B9gVcL1fvtWG7Rw+mNiCnlOE1aF8NAqoMKIQhP8RQApT5pyUYaK6FDAGGuOcNCvB+uCyWafA7Yp2xZaa2oKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6546.namprd11.prod.outlook.com (2603:10b6:510:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 03:28:30 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 03:28:30 +0000
Date: Wed, 30 Sep 2026 20:28:19 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>, <alucerop@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 04/10] cxl: Add HDM-DB region creation
Message-ID: <ar3TU4IM_TtcGgwl@aschofie-mobl2.lan>
References: <cover.1790103847.git.dave@stgolabs.net>
 <4a85b58e026256ea66b2d5f71c73cc6e03620330.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a85b58e026256ea66b2d5f71c73cc6e03620330.1790103847.git.dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc869ed-acee-4a11-0369-08df1f6c1023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|5023799004|3023799007|6133799003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: iXPXGgN614c3Iy/ZHv6pP3RcA2fZVilKO+FZY6uMJ0d5x1MRegJwL6QO4BnxDS0Wwha3hoJaYTKffp6onbQtnrNvk7XKfppSLFMUyBrA1Aj30Mvn7tCc5nGkTN8i+PgwC//guJJHM6ZhIYDgdnGxXAfv7/+0yVMGj6fxjodt5gNY6UDMecrqOvR6D2F0F2tlOgWGqwDNvNkA4pFGK3KCxLHLU4sYi6VKmtGUhnHKlXli2J9Kxy+zFLPc1N+aq0GUGfvSE5Eq/pV/xK9KPsF2ccxzQaW2DHRHbz52AGsA1c34IyO+2Zvv0YL3bnJoTZ5cGykkrAlOIni5fdreQ55VYVCvv/Vk5OsrXT3iQ8TPeARt07bsQlYCO/AKX7W9k8bRRvhBKE9M8UK1XfxfZ5qstZT7BGbkrYyNVszCVB8fKYNK/ZRzdKAPjPp6H5vXlU7H1nn1a/SwtgAb3bCHexQQKBpb025KiCdfFBaTHGtjFE9845McgjMLkOjrzG6jgwK3OIFZdr9Gg/QiYP8ObR+ZJfCWFGRXADEF8AWpvL3+qUbQt5LPl2/GngAQbxIoGHI2fI+adfX7VGq8cpCrptdwzvtDoc2NpwjXqiq6k2HEgmY0xQKgTjtFDxE/Wkl8YhALvMimBOCTQrIF1ZWFfq27EmZfI7XxnNZnNIlvXHm4+Q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(5023799004)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYGqa1qHX9vN8h/P+HHytUeE1AtsznbZnSHoKFba4JE3AdBvC8HsDsVyNY7g?=
 =?us-ascii?Q?UmN1jaQ3uY+8Te6jw3gF1goUIskxC+wi6pXXieZcgnreMdC85xXMxRzJQQ78?=
 =?us-ascii?Q?56EWYEkGQkJsfnXWPs4tsSKqsoUbTDYgCrl6ap8L6XZDPHN7jyVHN30qWw8P?=
 =?us-ascii?Q?ZNTyRPHN9M6DZHgo3MIErHVKFXKDcyqn9yEVG8Q65hFsW8LLwy+h5fX43UaO?=
 =?us-ascii?Q?RUkIE3VQ/dGBKXHwoZtCsimq1hVXc8hzst8TWOolhGkPbhpyCzFVVTebKd0r?=
 =?us-ascii?Q?/gCNpx/5dPjXnW1EzdjkZLJCUxQkZAL1Ek5xPO5rYpXIy1JYgQmyGNb6pPEO?=
 =?us-ascii?Q?AkNAA7QN7zxEW07cWFu+PiMwIDDanW1xAhmq9K2VKsJgflv3tXPEJNmqCgQs?=
 =?us-ascii?Q?p0CqAWG2NAyWzHR0oB5exteyYxcO4CPY1KQsFbaa/l1rnByq7cA2IihzzqnX?=
 =?us-ascii?Q?vAGUnpbNMJXI1PwkpFimX1DWvm53WYFB4/zlwowaN+VaNMdtFOwG4Uu9sgeR?=
 =?us-ascii?Q?eUX5zbgV4ZyeGmJau2YP1EpdEqsBIRLtMPhC1rGUZz7lE5geify+e9w78afJ?=
 =?us-ascii?Q?eSGUS+syJ0IC7e6nV7cM45KzBTw1bgyJty5UGEc5rvThUg0twSw7Iy+iutX3?=
 =?us-ascii?Q?sqhHQi1jkck4wXeYDJGZEnp9qc675Hx2FXOCWXE//JD2qyDVyaLOkos4iS8a?=
 =?us-ascii?Q?3hVXGI/BJad6CmpWycGqOJGVhaxj0XBBm4bZVqEQcKz793YLNWEoSMgxOTXA?=
 =?us-ascii?Q?OxMKxtsvKrsX75pKF0EpF6TLglZlfMwhmy7oAPcql+Zm3wKDH03Sx4Tiq+dT?=
 =?us-ascii?Q?dE1isRBsPWrXV1tIhZyzXPCE/y9ts5NGpHLMz4WoNZ00YNLtFATLqbYzgLXA?=
 =?us-ascii?Q?zPAzTmFycOwZT1m+LJ5MlD+Ey9W9QbXc5CIN0xr8n0p2TCLyJB5nzO51/+fs?=
 =?us-ascii?Q?qRw7X4vXSWHKSL2KjjYKRDQ+xrhtzsA1HczXX8zqfC2UrD3PHPRXE8S+VSW6?=
 =?us-ascii?Q?Sg0CyD5EronGtMFOfcy3KqZV/CJIsoqKoy74xaKAbMMYP9W7DlmlawyDE+m4?=
 =?us-ascii?Q?yPkt2yDGO6QDpGhUggYe5RWBFIeAEGfq7QpLFy+G9ik6YJOE5ySElEMWGeb+?=
 =?us-ascii?Q?GycUNkFuRWu9E1Y+ID47nvSf6gTpTea05KpO5jRx4hULnKZ1i5oAle2Xzx9E?=
 =?us-ascii?Q?StgD7TLxznX8GDLZeZg+J1xZ2sXNqZJEkVUXpRajcJPdBKkd4hWU7FbMeKkV?=
 =?us-ascii?Q?1v4dkoIzkznKN2/T7pOHGs5NKIk8wgh2BiQ1nnb2hVTsmv7Z+s2ClVNK/ePg?=
 =?us-ascii?Q?I/p9nmSdNop0QTQD4WR/gfiIGYCzskOBGS0L1vRdz7H9QZZlfoTrQ4iJZt5A?=
 =?us-ascii?Q?f18zLUoTR0LTn7wZ1flP3SzLGfb7m5k2jUnXSMfyZnZ4n4YmDidpcToAkZwl?=
 =?us-ascii?Q?7H6i0ILMNRid2vomNSg3SWZ3DhC5COAd8Zc4iWBuGtxUNluvbwwVhYWZjUSA?=
 =?us-ascii?Q?xZMSf2qbUcbSbP50fWACeMS9UHV2HGx0JeJus17uW1WfB/qT6gzZ0txXTGk/?=
 =?us-ascii?Q?UJBQV+CwbBpCMfab+fs+5T0NPg4F3ca/acbIufBeRBEDsBbuM/fzxxmfmiZz?=
 =?us-ascii?Q?4qivzs2c/qdBJdx776KGrZoMXArsOOFyImdmaRFB4fuWdaG3M7Xyeu5knv4E?=
 =?us-ascii?Q?OkQvD6eqDm/ONRLQKXouzIxiKhXS84PopO4BXV+TOCMEzEWXjOMiX5JgZDAh?=
 =?us-ascii?Q?Kod44EisNNALkY7S/cm+Fx84zzxxMU0=3D?=
X-Exchange-RoutingPolicyChecked: b1mSjsZ9Zmk7aJ8DuwaJOQfZsMH4GGz95em0WQV0vlyLFGuxF2e+Y8+UqMYk7gFUU3SP6+kNoJISqzplwdgkMMtlozWFGTQaUDVsfGraXdQqYGxXKsL5s7F4+9TYSctCU3HZCOOJIdEJIHNUbV39YUfFE3Tr14pF9f3YTNOIwzcnb5UgFWifaad+XK+pwfEhz84jG/87sTVGdz/JNLk0nVUjTPhgecUYpRUPEX/s48/Bq2e/LL5aGE3NaalL8DLoSGfhuOVFgxVLjvNIHMrkrPMKlQkGsgsS0xCLX0bdW9Mh2hv7fFWDtBToDoKYSQzGeryRsYpSShCHe4qoRHY6WQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc869ed-acee-4a11-0369-08df1f6c1023
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 03:28:30.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Frp6IY6SViuKrJCfh+gfJT/FCsOqgo82TA1xHCOCl4BS42vhlkrH2/tCX3rlti6ofT1XpaL8aXEv128Brv2v1yVoBoWUGTQfi6PU9Gviops=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6546
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 04:38:41PM -0700, Davidlohr Bueso wrote:
> A region inherits its coherency from the chosen root decoder - HDM-DB
> if the root has CXL_DECODER_F_BI, otherwise HDM-H.

Above holds for regions created from sysfs. An auto region takes its type
from the first committed endpoint decoder in construct_region(), without
looking at the root decoder. A committed host-only decoder in a BI window
becomes an HDM-H region under a BI root, and an HDM-D region is neither
HDM-DB nor HDM-H. Can this say which regions it applies to?

> 
> cxl_acpi_cfmws_verify() rejects a Window that declares no coherency
> model at all (neither Device Coherent nor Host-only Coherent), one that
> sets BI together with Host-only Coherent, which the CFMWS definition
> calls undefined behavior, and one that sets BI without Device Coherent,
> since HDM-DB is defined only as bit[0] and bit[5] together. A BI Window
> therefore always exposes device-coherent memory and nothing else.

These rejections drop windows that are accepted and usable today.  See
the cxl_acpi_cfmws_verify() comment inline below.

> The root decoder's target_type follows the Window as well -
> device-coherent when only Device Coherent is set, host-only otherwise.

I'll comment inline on this one too, acpi.c hunk below. I think this
describes dead code and opportunity for cleanup.

> 
> Introduce the following read-only sysfs ABI.
> 
>   - decoderX.Y/cap_back_invalidate (root) reports the CFMWS BI
>     restriction.
>   - decoderX.Y/back_invalidate (endpoint) reads '1' when configured
>     for HDM-DB.
> 
> cxl_region_attach() rejects endpoints whose device or HDM cannot
> serve the region's type; target_type is inherited from cxlr->type
> in cxl_rr_assign_decoder(), restored to the endpoint default on
> detach, and to whatever it was on a failed attach - a refusal may
> come before any inheritance, for a decoder another region owns or
> one firmware committed, and must not relabel it.

A decoder firmware committed is still relabelled when its attach succeeds,
since the type mismatch check is gone. More inline at
cxl_region_attach()

snip
> +
> +
> +What:		/sys/bus/cxl/devices/decoderX.Y/back_invalidate
> +Date:		September, 2026
> +KernelVersion:	v7.4
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Shows '1' if this endpoint decoder is currently configured
> +		for HDM-DB (device-managed coherency with back-invalidate).
> +		The HDM-DB state is inherited from the region the decoder is
> +		attached to, which is in turn set from the chosen root
> +		decoder's CFMWS BI restriction (see cap_back_invalidate).
> +
>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
>  Date:		May, 2022
>  KernelVersion:	v6.0
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3b818adbd38b..2e8e31544a5f 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -152,6 +152,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  		flags |= CXL_DECODER_F_PMEM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
>  		flags |= CXL_DECODER_F_LOCK;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
> +		flags |= CXL_DECODER_F_BI;
>  
>  	return flags;
>  }
> @@ -198,6 +200,24 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>  		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
>  			cfmws->header.length, expected_len);
>  
> +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
> +	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
> +		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!(cfmws->restrictions & (ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
> +				     ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM))) {
> +		dev_err(dev, "CFMWS has no coherency model\n");
> +		return -EINVAL;
> +	}
> +
> +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI) &&
> +	    !(cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)) {
> +		dev_err(dev, "CFMWS BI requires device-coherent\n");
> +		return -EINVAL;
> +	}
> +


Can these checks break windows that are accepted and usable today?  A
rejected window gets no root decoder, and auto-assembly then fails with
"no CXL window for range".

A window that sets neither coherency bit is accepted today and can hold
auto regions, since assembly never looks at the restriction flags.

A window that sets BI together with Host-only, or BI without Device Coherent,
is accepted today as a non-BI window, because BI is ignored.
Manual HDM-H region creation in it is lost as well.

Even if no shipping firmware does this, is cxl_acpi_cfmws_verify() the right
place for these checks? Til now it has only rejected windows that cannot be
decoded (arithmetic, alignment, ways, length).  What a window may be used for
is decided later, by cfmws_to_decoder_flags() and can_create_ram|pmem(). 
Might it be enough to withhold CXL_DECODER_F_BI for an invalid combination,
so that only HDM-DB is refused?


>  	return 0;
>  }
>  
> @@ -437,7 +457,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> +	/* host-only wins if firmware sets both coherency restrictions */
>  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	if (cxld->flags & CXL_DECODER_F_TYPE2) {
> +		if (cxld->flags & CXL_DECODER_F_TYPE3)
> +			dev_dbg(dev, "CFMWS has both HDM-H and HDM-D\n");
> +		else
> +			cxld->target_type = CXL_DECODER_DEVMEM;
> +	}


Mentioned in commit msg, I think this is dead code needing cleanup.
I don't see a consumer of a root decoder's target_type.

Building window-derived logic and a dev_dbg() on top of it makes it
look as if the root decoder's type matters when it doesn't.  Can this
hunk be dropped?  Removing the old line can be a separate cleanup.


>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 18200a8f3f72..44ff64b1a9df 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -705,9 +705,21 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  
>  static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  {
> +	bool bi = cxld->target_type == CXL_DECODER_DEVMEM &&
> +		  cxld->region && cxl_root_decoder_is_bi(cxld->region->cxlrd);
> +
>  	u32p_replace_bits(ctrl,
>  			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
>  			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +	u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);
> +
> +	if (bi && is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +
> +		u32p_replace_bits(ctrl, cxled->pos,
> +				  CXL_HDM_DECODER0_CTRL_ISP_MASK);
> +	}


The commit message does not mention ISP programming. Can it get a
sentence with the spec reference for ISP being required when BI is set?

snip

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c

snip

> @@ -1131,16 +1163,11 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  	}
>  
>  	/*
> -	 * Endpoints should already match the region type, but backstop that
> -	 * assumption with an assertion. Switch-decoders change mapping-type
> -	 * based on what is mapped when they are assigned to a region.
> +	 * Endpoint decoders inherit their type from cxlr->type; broken
> +	 * pairings were already rejected by the coherency checks in
> +	 * cxl_region_attach(). Switch-decoders change mapping-type based
> +	 * on what is mapped when they are assigned to a region.
>  	 */
> -	dev_WARN_ONCE(&cxlr->dev,
> -		      port == cxled_to_port(cxled) &&
> -			      cxld->target_type != cxlr->type,
> -		      "%s:%s mismatch decoder type %d -> %d\n",
> -		      dev_name(&cxled_to_memdev(cxled)->dev),
> -		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
>  	cxld->target_type = cxlr->type;


A Type 3 endpoint decoder in an HDM-DB region now reads "accelerator" from
decoderX.Y/target_type, and the ndctl test on the branch linked in the cover
letter checks for that. So I take it target_type is now being used to report
the decoder's coherency model, device-coherent vs host-only, rather than the
Type-2/Type-3 as documented by the existing ABI.

Does this need sysfs ABI update?

cxl list doesn't show target_type, but libcxl exports it through
cxl_decoder_get_target_type().  If that is intentional, libcxl.txt will
need the same semantic update with the ndctl patches.


>  	cxl_rr->decoder = cxld;
>  	return 0;
> @@ -1803,6 +1830,7 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> +	enum cxl_decoder_type type = cxled->cxld.target_type;
>  	struct cxl_decoder *cxld = &cxlsd->cxld;
>  	int iw = cxld->interleave_ways;
>  	struct cxl_port *iter;
> @@ -1828,6 +1856,8 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
>  	     iter = to_cxl_port(iter->dev.parent))
>  		cxl_port_detach_region(iter, cxlr, cxled);
> +	/* undo cxl_rr_assign_decoder() type inheritance */
> +	cxled->cxld.target_type = type;
>  	return rc;
>  }
>  
> @@ -2056,6 +2086,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_port *ep_port, *root_port;
>  	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
>  	int rc = -ENXIO;
>  
>  	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> @@ -2105,10 +2136,39 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (cxled->cxld.target_type != cxlr->type) {
> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			cxled->cxld.target_type, cxlr->type);


Should the type check stay for committed decoders?  With it gone, a
second auto-assembled decoder whose committed Target Range Type differs
from the region's is accepted, and cxl_rr_assign_decoder() then
overwrites its target_type while the hardware keeps the committed value.
I think this changes in Patch 8 - which really makes patch 8 required,
not optional. (more on that in patch 8)

Maybe the CXL_DECODER_STATE_AUTO mismatch check fits better in here,
since this patch that removes the old one?


> +	/*
> +	 * Verify the device and HDM are capable of the region's flavor before
> +	 * proceeding. The endpoint decoder's target_type is then inherited
> +	 * from cxlr->type later in cxl_rr_assign_decoder().
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	if (cxled->state != CXL_DECODER_STATE_AUTO &&
> +	    cxlr->type == CXL_DECODER_HOSTONLYMEM &&
> +	    cxlds->type == CXL_DEVTYPE_DEVMEM) {
> +		dev_warn(&cxlr->dev, "%s:%s HDM-H requires a Type 3 device\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	cxlhdm = dev_get_drvdata(&ep_port->dev);
> +	if (!cxlhdm)
> +		return -ENXIO;
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
> +		dev_warn(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
> +		dev_warn(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>  		return -ENXIO;
>  	}


Why dev_err()/dev_warn() here?  The type mismatch refusal this replaces was
a dev_dbg().  The attach fail here would be reported as -ENXIO.

Tidy up opportunity, maybe move the 4 coherency checks into a helper so
cxl_region_attach() stays cleaner.

Another cleanup - the 'is this reion HDM-DB test is now coded in a few
places, my look may have been limited:
	cxld_set_type():		target_type == DEVMEM && cxl_root_decoder_is_bi()
	back_invalidate_show():		same, plus cxlds->bi
	cxl_region_decode_commit():	cxlr->type == DEVMEM && cxl_root_decoder_is_bi()
	cxl_region_attach():		same

Maybe a single cxl_region_is_hdm_db() would be clearer and cleaner.



snip to end
