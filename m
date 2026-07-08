Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F624C9015;
	Wed,  8 Jul 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535778; cv=fail; b=Pk9aLDMexjfxS+s5SW1hV7HryCcqsv3mUg0mjgTue9LdYOn1Z8FBrZr7VeXJx1AMuG7tYvzZyVoFQQ3eXfflCN8rCtra+qb0rFUTW6vl7RGXyKtK7SVblC/Rvo5GLffGrTk9xemvEwJc2SkhEu7r6erJOcraqpaIpdD1evA5I8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535778; c=relaxed/simple;
	bh=GI+kOSgXK8obM5NKNbHfF2noxbUeKAUoZ6PHSvdk4Sw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iMw6qcSFPhSXWQXgDTA9qBaDNJcQcuHlK/WBZXBe8BaSB2TfoRBlvBG1n0x2jCO0Bf3FuxXSImZ/DqR7gWoOyeY88t1Ttl8rFtR7lt49gk1kDfhoqSnywalSvC75FnjIo/hD06utLoB7vZ6ZauNtpeAww1aAqTebfPEj3sV8J00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEBe+0Jb; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEBe+0Jb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783535776; x=1815071776;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GI+kOSgXK8obM5NKNbHfF2noxbUeKAUoZ6PHSvdk4Sw=;
  b=CEBe+0JbS+kfE0ZNocKd2JP1zSUpq6xRl56OXanDdQRMrk7nTWweuggI
   KYE2HtvKamfA8XU5qukYGMHBws+NwKgZ26AF4N+5hSXzzjunmCwnLpP/p
   IzVD2BDGqv9aA35O7qy2KIiWCSQdrwzpLv8E8iMUsv9xzggc4DEBVbTSa
   079SthaRC6t8eCFkQu6vY5Wx5tHO79J/eY2n0TyeXT3nB4SW6I/+pfUbv
   /R2sUMRnXvjGQ+y/pTqG0vtRDqoVPpUXUNcNxV0Gmu0Jh/bOVVDZp39h+
   xVhnDuLqrHr9GnLm7cHXf8+r+59DJMwVRUfd/2aSstgV08NNLBETjYDcZ
   Q==;
X-CSE-ConnectionGUID: rjNfAr0wTYm5dpttA7Nghw==
X-CSE-MsgGUID: OuZQamGKQ3qtVOjKcW9BQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95368154"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95368154"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 11:36:08 -0700
X-CSE-ConnectionGUID: /15se9waR2eD1y1NMj5VBw==
X-CSE-MsgGUID: xiEOxXObSlS90E/LrNcz0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253883515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 11:36:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 11:36:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 11:36:07 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 11:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePyCHUi+q4n2CYqW7U3CDsfAmljfuJznIW0ao+D0im2PoDeE6K28hRVd9Oeb2heru8xttY2FTf98XdN9nXRbbYXxm/rJbDFqLkkosQUUlDwfM/mP06jIHBvQur94pNXhIQYiiYCophfH13zkpcQoDujdn4w/8AxhUpcXsoDHj80OhwWI9P0IfFHzo8cx8utUojSNJFpVCNc1mfGCbgp5K7zt4rZ2i0IYnl+Wqqt18hzkZYx4/kN8tbxBxMjL7IGPukk3DVYO6pob8FehLhXHBWg/3DECUHjFIy6Guxx17MaahPm3HPn6ooD4bT2hJjVeoZFvcVWcBp8Akx8KXzzSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhxfaT0oVdU3ds04GVcRDttG65aMaj3rSgbH3+8vovU=;
 b=yIWubWSso+NVMAeubRB34U5DSGNT9HocxGhxd8qzKTiM73TsgRzkbrEC2Em8trV/w35wUgrw9Qfmprcs2HxElHsKCwKGhTitVJ5KXILDyPH77ATPKw/8IoTjRvBWIf94slP0MShDnqSjH5v+mADuFGocg2OXOMctDC0uNspaMhKMa58bqTAWp/cBStc3ep4Co1RQeCKgWTiqlUqkOzLp/oK6ldRPsEungmr1mE5SktZARfG6cJztSL0wPQlKcshk/bgBQsLTy6Hq8Q0pZC4m49k84bBbNlts2X1Ge7+DtRgEDJwQ+k6iElbt8EWn+0BIH37BmWlE9no9FKRWnd3kbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 18:35:59 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 18:35:59 +0000
Date: Wed, 8 Jul 2026 11:35:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <kobak@nvidia.com>,
	<kaihengf@nvidia.com>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <mochs@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>
Subject: Re: [PATCH v7 2/2] tools/testing/cxl: Enable zero sized decoders
 under hb0
Message-ID: <ak6Yi55kRbX4tCl3@aschofie-mobl2.lan>
References: <20260708104024.68029-1-icheng@nvidia.com>
 <20260708104024.68029-3-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708104024.68029-3-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1a484e-af61-4e5a-a037-08dedd1fc156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|22082099003|18002099003|3023799007|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zI/b9z7cpFcq+8AMNcg4RHhWz5HTGWtv8msl32LPOAwumkLQHqNkUS0aWXAmvP8nhF8Nmq2owmN20r2Gh+GvG9BgOoWMjZswg3BJsNEEHyl+Lf/eix/XJMVceJoZ2dxNPwaeEq7kV+6H7ho+OQlR4KRjyAWHWDmYULQveIv0O3q9A2vOPOBMEOaHrhvsl6drSYUzqx26N+djDLnhKYkxQWdue21BjtD2vUjJJYfe0cXRUdVTi/KGm/YSNqai5pQF7n3k/1qjIKCFyADyGgZ4UN9SaPys6pmV2N70VFGFmsMItzL4kcjpfYC05ePfL30Cge/6c4frGKfOTEXgFpcXqiuHva9MQVHkwunH1XxpYVt17u3bK4x8KUX1xOl0gdbnKEWOBI1QtIe82OFwo+6RWOVpzziJJ8+vBy/yNX2ekV6mRdwy/XGOi8nDigCDV02rEYqojsBy9lhPUOyDjNGcBoKZGW7kDI810Rpuv/GKGhBvxGHW5wh29Bn/g5eiJXE3Nrm0y3Ll/6zCCE18AqMQFmRGVVXF7EOR3oVmeMl52uq7LRNXfJP8Ey2cdr0qZFMff/Y21StKU/9EH8JPwNXOYYZRYxkqvKks2di6YmhJAX7UOHNCmsAOCSxnqV68gO1ncGm4ofskNhsodPD8R1ZHz61f5jpztKhWNMtDPEtMggM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WodPWyuY8sS95e88bRhmun/hNHJjtT00/VJmVBE8Sf18HxfNuQWyfiyw0Nlu?=
 =?us-ascii?Q?VkEiULi/zWbElA60DXPf9NL7Tn0vB4Bem6HwpkUvwbxjBTLqamCP7kcvmRf/?=
 =?us-ascii?Q?T3jsRHuEgsGU5Ni6R2qAHZdFMfg9+jaolZXrDVX7pAHHRpm0lhTjnm5hZQWk?=
 =?us-ascii?Q?cxyMzewhYCsZ3Q5/glsL5ECYm763Z1GVk9NNtmjJ5R98bBUli+9PCsdl83+P?=
 =?us-ascii?Q?oa+6MizJTif5j9Rblq9hsLR6yX+AiTXUeFN0y1T2kvgr4ud7qk8Rv11mlKx3?=
 =?us-ascii?Q?+329RjTqlWwPH6Mi7mLs0S3UPVArLWXXlJPezdbg9q9U4R2imXZYVCRMzWpV?=
 =?us-ascii?Q?c3R3xeojmzcP24ChZAv9Dq9d7zTQ7le9TGxIx2FbgN0bwhmD+05IB52B8cLI?=
 =?us-ascii?Q?YJnNc39hS8+Y8PvhfupFtlj+MD1+YqYBnPD3AIYlUDnRiH6TDKLdO+9B1GsF?=
 =?us-ascii?Q?bt9pUC7maFTOLMPRZeVIYQenq3smUzBztjrWQtFcJKlnQNOQ+Mswzd6wf72j?=
 =?us-ascii?Q?Koxfhw9+5dvhBZlu/v9+BOvY50fCiWnfz4pbURFMfGVv1PtZzXzD3YYfc4Et?=
 =?us-ascii?Q?rlhiUkOrctRl9eKQxFOL6PFXQw3fc2Utr+OQDA+OujxzAonZbwYRb1i+IDAF?=
 =?us-ascii?Q?5YE/wkd43Hh6YVH461674so+9F081es/OywkkEeE3PuefFpyV/4INpooQpbD?=
 =?us-ascii?Q?9iZuOVjeKCrSTSIhzzyLkpgbXe6jDzg+6biW+qIGFBPtJshukcKffQuGfd5C?=
 =?us-ascii?Q?0jYOao1VxHp4K+uhrhCNxdwLeKgRnVq2L46EWFpzXy2jl3wqGBbPAbemgwE1?=
 =?us-ascii?Q?HUQjkMVGMhKMItCOLZ2UhQVlyOxUyAvtZRgRfLpY9cuuS1ep/2nJHVMCEcdu?=
 =?us-ascii?Q?IubrZWSRPM0/Tgtbe/pb34j+0znUjHPnVE1R+bq1h6mRnPlakp1IpQo2t0rN?=
 =?us-ascii?Q?SfXvYmzhHjIpORSW2hCZIZyUwzipeehLBWpSIf6CO4nbQR5dIzvlzQddI5n0?=
 =?us-ascii?Q?gpcKoMJgMkkYRnzshRD09oomlfau8cstg7XucOJwmC663g3h+cEz1/deP3R6?=
 =?us-ascii?Q?+Fb2kQgelkhATXYRl5Ji3KYpSkGETXhNSK0Rv8+k/tWk9Wm7jaIYfXdqISZs?=
 =?us-ascii?Q?14HvIAuo4sWnHHjt4zaJKrCemWwtHVO4m4wH0vWmfbQ5yULocxJxeH4YY17Q?=
 =?us-ascii?Q?rhSfJ+viaWSra7EHL6QSDtboh1IKr/U8VPT9e7P1fvfwvGrOtexYefq4iwnj?=
 =?us-ascii?Q?386egl5X6rxa8UJ1wTohmHEeVHSo9YNPk/n4swD4S/qIV7VLAU5PE+FPxpqc?=
 =?us-ascii?Q?Ov0WFAcW1rfV+M/qGPguad6vYYNQ2AFjDb9adNOK770wQerOymchApenyLKC?=
 =?us-ascii?Q?7E4LIuk39TncX/K6WRVADVEks17vHY383ymERtietHRb1VjxLqCgUAnHq44/?=
 =?us-ascii?Q?LllBmK7NrWu8i2rNykSU5TPC0uGJlPYOla1Xoa9AKmd9OLJesZ+HgBrzoir0?=
 =?us-ascii?Q?h+zT1R4V7/i0BqoQQVVPw2KKio9y7aR7vwWfpzz4PKXfyH2GyvG+Gob4YaM7?=
 =?us-ascii?Q?W5Mtbav0PqdiuQ/q0yLY8cSL2YrA031ufhxacm8t86YEddq7iwjg2whR6gZp?=
 =?us-ascii?Q?k/3xju2l76BKz+qKMglRtG/4nPtivylyxQi+DIIANT6BYhtEjBy1cV10YU/c?=
 =?us-ascii?Q?poqbY2SVgdYIoCTDLEAwpmYyLRRJlpYO50FBU85pVD2DzNvWXTjZz1rRb8wl?=
 =?us-ascii?Q?xHFvGSVDIbpK7efA4jzFAu2d1errfnw=3D?=
X-Exchange-RoutingPolicyChecked: G+S1nRQyN1eH8+Ob7ZssqxOvee6Cu5Zmxw2kl4nHgEreGqx6Py6EI+8H6I5p4N3KUYUhiCEq3cuO7qCnq2/b7qaUTrKCoXtvScPo92S+Jt15krDOtQKu1ITuHjIEfe2ZoOtXgwZSlU4hbtEU3O2MYfpcXehEAXNk9vJi8gk1jFrJ1mdxXcYa+tfGeRlCWIWgHDoVqA/zTvbgkKrNeSqZvl545AxtV+6x6Igo8EiZ6gasy5Sm2vSUTDCYQ1gQNiB1kvFmG1fEUvLRwpiL4XH1hBEIuYRN8cFSRMoQu3v2QE8J6Dj61ZlIPYaIFWBvDj54YNQY0mE3oZV92L2ap4+0UA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1a484e-af61-4e5a-a037-08dedd1fc156
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:59.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnXHFCpU6FqlE2DR4PoJzB18pl3PcZ/IPCIEgvI7I/ijqWbeC7obM1NylUYtV7RsSxb4FC+zL034RwbrLEEn1Ynk+C+WFEAuQ7kmGGKUenE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com

On Wed, Jul 08, 2026 at 06:40:23PM +0800, Richard Cheng wrote:
> The kernel now allows committed zero-size HDM decoders so BIOS can lock
> empty decoders; cxl_test needs to exercise that path.
> 
> Add a mock_zero_size_decoders module parameter (default off). When set,
> the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4)
> commit decoders 1 and 2 as zero-size + locked above the decoder[0]
> auto-region, mirrored on the parent switch and host bridge. The mocks
> take a real zero-size DPA reservation, like enumeration of real
> hardware, so commit_end lands on a zero-size decoder and the
> reservation, poison-by-endpoint, and teardown paths all run.

At v5 review we chatted about a unit test for this.
Not sure what has happened since wrt the poison tail mappings, but
the check in cxl-topology.sh 'wants' to be in place to merge this.

https://lore.kernel.org/linux-cxl/ajozhDmPogKi9hb5@MWDK4CY14F/

-- Alison


> 
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
> 
> v6->v7:
>     - Rebase onto cxl/for-7.3/cxl-type2-test.
> 	- Integrate mock_zero_size_decoders with special-topology parameter
> 	  validation and reject its incompatible use with fail_autoassemble.
> 
> v5->v6:
>      - Reword a mock comment, no functional change.
> v4->v5:
>       - Mirror the v5 core semantics: mock zero-size decoders take a real
>         zero-size DPA reservation via devm_cxl_dpa_reserve() so
>         dpa_res/hdm_end/cxled->part match real hardware enumeration and
>         the poison-by-endpoint walk reaches commit_end.
>       - Set cxled->state = CXL_DECODER_STATE_AUTO to match
>         init_hdm_decoder()'s fall-through (undoes the v2 switch to
>         MANUAL).
>       - cxld_registry_restore(): reserve unconditionally for enabled
>         endpoint decoders; enabled now implies reserved, sized or not.
> 
> v3->v4:
>      - No change.
> 
> v2->v3:
>       - Gate the zero-size + locked decoder injection behind a new
>         mock_zero_size_decoders module parameter (default off). v2
>         applied it unconditionally on the host-bridge0 auto-region
>         endpoints, which the region test suite reuses, regressing 7 of
>         17 cxl unit tests; defaulting off leaves the shared topology
>         untouched.
> 
> v1->v2:
>       - Replace second_decoder(), third_decoder() with a single
>         match_decoder_by_index() helper, so all lookups share one
>         matcher.
>       - Use DEFINE_RANGE() for the empty range instead of an open-coded
>         struct.
>       - Set cxled->state = CXL_DECODER_STATE_MANUAL rather than
>         STATE_AUTO.
>       - Set CXL_DECODER_F_LOCK on the mock zero-size decoders to model
>         the BIOS-burns-slots case.
> ---
>  tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
>  1 file changed, 94 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8ab2ce1262f3..fff2004a08c8 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -18,6 +18,7 @@ static int interleave_arithmetic;
>  static bool extended_linear_cache;
>  static bool fail_autoassemble;
>  static bool type2_test;
> +static bool mock_zero_size_decoders;
>  
>  #define FAKE_QTG_ID	42
>  
> @@ -872,14 +873,13 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
>  		cxld_copy(cxld, &td->cxled.cxld);
>  		cxled->state = td->cxled.state;
>  		cxled->skip = td->cxled.skip;
> -		if (range_len(&td->dpa_range)) {
> -			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
> -						  range_len(&td->dpa_range),
> -						  td->cxled.skip);
> -			if (rc) {
> -				init_disabled_mock_decoder(cxld);
> -				return rc;
> -			}
> +		/* enabled endpoint decoders hold a reservation, sized or not */
> +		rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
> +					  range_len(&td->dpa_range),
> +					  td->cxled.skip);
> +		if (rc) {
> +			init_disabled_mock_decoder(cxld);
> +			return rc;
>  		}
>  		port->commit_end = cxld->id;
>  	}
> @@ -1072,16 +1072,49 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
>  	WARN_ON_ONCE(!cxld_registry_new(cxld));
>  }
>  
> -static int first_decoder(struct device *dev, const void *data)
> +static int match_decoder_by_index(struct device *dev, const void *data)
>  {
> +	int target_id = *(const int *)data;
>  	struct cxl_decoder *cxld;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  	cxld = to_cxl_decoder(dev);
> -	if (cxld->id == 0)
> -		return 1;
> -	return 0;
> +	return cxld->id == target_id;
> +}
> +
> +/*
> + * Mock a committed, locked, empty decoder
> + * (CXL r4.0 8.2.4.20.12). Gated by the mock_zero_size_decoders module
> + * param so the default cxl_test topology, shared by the region test
> + * suite, is left undisturbed.
> + */
> +static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +
> +	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
> +	cxld->interleave_ways = 2;
> +	cxld->interleave_granularity = 4096;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +	/* decoder[0] reserved [0, size/2), empty decoders sit at that watermark */
> +	devm_cxl_dpa_reserve(cxled, mock_auto_region_size / 2, 0, 0);
> +	cxld->commit = mock_decoder_commit;
> +	cxld->reset = mock_decoder_reset;
> +}
> +
> +static void size_zero_mock_decoder_sw(struct cxl_decoder *cxld, u64 base,
> +				      int level)
> +{
> +	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	cxld->interleave_ways = level == 0 ? 2 : 1;
> +	cxld->interleave_granularity = 4096;
> +	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
> +	cxld->commit = mock_decoder_commit;
> +	cxld->reset = mock_decoder_reset;
>  }
>  
>  enum cxld_init_type {
> @@ -1114,7 +1147,7 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
>  	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
>  	 */
>  	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
> -	    pdev->id > 4 || cxld->id > 0)
> +	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0))
>  		return MOCK_DECODER_INIT_DEFAULT;
>  
>  	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
> @@ -1147,6 +1180,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_port *root_port;
>  	struct device *dev;
>  	u64 base;
> +	int id = 0;
>  
>  	base = window->base_hpa;
>  	cxld->hpa_range = (struct range) {
> @@ -1172,7 +1206,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
>  	 */
>  	dport = port->parent_dport;
>  	root_port = dport->port;
> -	dev = device_find_child(&root_port->dev, NULL, first_decoder);
> +	dev = device_find_child(&root_port->dev, &id, match_decoder_by_index);
>  	/*
>  	 * Ancestor ports are guaranteed to be enumerated before
>  	 * @port, and all ports have at least one decoder.
> @@ -1232,6 +1266,20 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
>  	base = window->base_hpa;
>  	if (extended_linear_cache)
>  		base += mock_auto_region_size;
> +
> +	/*
> +	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
> +	 * endpoints mock committed, locked, empty decoders above the
> +	 * decoder[0] auto-region (CXL r4.0 8.2.4.20.12). commit_end then
> +	 * points at a zero-size decoder, exercising the zero-size
> +	 * reservation and poison-by-endpoint code paths.
> +	 */
> +	if (cxld->id == 1 || cxld->id == 2) {
> +		size_zero_mock_decoder_ep(cxld, base);
> +		port->commit_end = cxld->id;
> +		WARN_ON_ONCE(!cxld_registry_new(cxld));
> +		return;
> +	}
>  	cxld->hpa_range = (struct range) {
>  		.start = base,
>  		.end = base + mock_auto_region_size - 1,
> @@ -1255,9 +1303,11 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
>  	 */
>  	iter = port;
>  	for (i = 0; i < 2; i++) {
> +		int id = 0;
> +
>  		dport = iter->parent_dport;
>  		iter = dport->port;
> -		dev = device_find_child(&iter->dev, NULL, first_decoder);
> +		dev = device_find_child(&iter->dev, &id, match_decoder_by_index);
>  		/*
>  		 * Ancestor ports are guaranteed to be enumerated before
>  		 * @port, and all ports have at least one decoder.
> @@ -1307,6 +1357,26 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
>  
>  		cxld_registry_update(cxld);
>  		put_device(dev);
> +
> +		if (!mock_zero_size_decoders)
> +			continue;
> +
> +		/*
> +		 * Mirror the endpoint: commit the next two switch decoders
> +		 * as zero-size + locked so the empty-decoder layout extends
> +		 * end-to-end through the switch and host bridge.
> +		 */
> +		for (id = 1; id <= 2; id++) {
> +			dev = device_find_child(&iter->dev, &id,
> +						match_decoder_by_index);
> +			if (WARN_ON(!dev))
> +				continue;
> +			cxld = to_cxl_decoder(dev);
> +			size_zero_mock_decoder_sw(cxld, base, i);
> +			iter->commit_end = id;
> +			cxld_registry_update(cxld);
> +			put_device(dev);
> +		}
>  	}
>  }
>  
> @@ -2085,6 +2155,12 @@ static bool __init have_multiple_modparms(void)
>  		count++;
>  	if (type2_test)
>  		count++;
> +	if (mock_zero_size_decoders)
> +		count++;
> +
> +	/* Zero-size decoders require decoder[0] to preserve commit order. */
> +	if (fail_autoassemble && mock_zero_size_decoders)
> +		return true;
>  
>  	return count > 1;
>  }
> @@ -2493,6 +2569,9 @@ module_param(fail_autoassemble, bool, 0444);
>  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
>  module_param(type2_test, bool, 0444);
>  MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
> +module_param(mock_zero_size_decoders, bool, 0444);
> +MODULE_PARM_DESC(mock_zero_size_decoders,
> +		 "Mock committed, locked, empty decoders under host-bridge0");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.43.0
> 
