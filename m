Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BA342C8B
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112369; cv=fail; b=g5tw881QLkr+W/Crw9pxYPxKgyOo5zfLspLSNpRm4S9xKUu4/1RGim/8Q9fLYz1JBteZew2fA4FySGmYx66Sed/rrFft6xvm7pNvY1PqlBgcMYoueowEY0xU6Mst74h8yyguB0wAJvjNyw+yh3NK0zisfoToRNc/9JmIrBu/yJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112369; c=relaxed/simple;
	bh=FTZiV/Q7kof5oSHFLRY8B+rdNUZKMu2iAGYQWs+iekc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NkpsieiSP57rHkRXO0fuHLHnNxIpk05seE6OgMyiJLZlcvbr5jMQy5LIBNq97FlHXrf5vLOmp/sCv5oNrJErwZPZrKDwxylc9GxwsZd4qa4RbgOe9NNWOobEcbjW5Hv2jfR9DmlIupqE4q7y/N3Y4het9ZM9LTpqzPjAejence0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvysEmfO; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvysEmfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781112367; x=1812648367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FTZiV/Q7kof5oSHFLRY8B+rdNUZKMu2iAGYQWs+iekc=;
  b=MvysEmfO5MKpIK4gO9FcdcnANLqB4kx+ZYVTMS1snH96/eXKqgZfwHkB
   ihjzksXJhejHAQxpska0J1k91p+VaBPwWK7rG0btictYjBNlN4RxQA6FN
   AQKDbtEczPbJ3RgHIfB+kqWdGNx539/FZlxSm2C51EwImGLEQZu2FavLN
   0zgoOe7RCNM/O9QkNpoGAOsCZnwKRPzFAjw2Fitpi9BCCxrDFFzr/2Otf
   lmdKY1W7c8dRCZx88NfJra6ngph+KoCczgtYQOXWHlezH7JNTOxNTsjxC
   ortzb1AZbLoLD8qegYAPF71qA3j42Y+eY52vgubz0q2vIjKlU7H7NcS+g
   w==;
X-CSE-ConnectionGUID: R847xR3+RcuJbXFbOKrcHw==
X-CSE-MsgGUID: WmjQ8yDrTXiYQskjNUpivQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81889165"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81889165"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:26:07 -0700
X-CSE-ConnectionGUID: yuP5wE/DRyW31RRp1boCIA==
X-CSE-MsgGUID: JZ7zdbEFTLqbNeLy1pJuKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="245113201"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:26:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 10:26:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 10:26:06 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 10:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oq6dF5DRoIm/AKUi6E7dOcN6F+2a7nN49RlQ5hkozSr5EkNXEl99vlhX/hru62IYPGSxFq4CGlZ8GqNTBQxrWQmksadHRR7tcvtHXF4v6UpCsCKvTIoaP9kYcEtXdAxWt5yfg8x/eyeKtCQuQ34i27kuBETUQpyDmQ6MVOE+MwsKZpGEvzd2ecyn8YKgykJv9kpDt379B8LvlMZxRUc0jh5F+lcrbNZmBkM8v5uJYjiWpa1pQe9nELZ91yBilkpW/DRKEnJ1v/C2KJKpEkgR+DZv2TMBGiY5cv6orrKkWx4mlucZzlerUvSHmHMtAAO2AUYdTxc4TOGiUdL2v9pdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0lWl2NdfWEBCCYpP+BgFSeBGNrmTVC5fLCx35zuSVM=;
 b=bYXZOcY7/IbzifBXrrQHjtwe9QAav9EoVl7rkPob2pVa7OuFKQgbn0Eqf3Ohka+KUhJ84r5Dr+TUO5EfsbReORCO6aLTH2iJEE343RzjGQVvZFTZrJy3v0tMCVxiIpnVUvNtnNDdm+p0F8QwV/byh9EH2PsorlbELlzLzomxaZRXkh88RNzMo5sDCWHXLiQ68QCn+J3219yiAkdYr98SpobGsTDQhhyIHEfEQCYay4kVDzPgRm6HOGIGlZI6YL556315faohNZBUgH0W3+UpKIbdMAtkDTMfQ+FDf5g9BcQA5z3NREbbs+Rl6gm8uPiN/UTswgthcUDSruFTP4S17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 17:26:02 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 17:26:02 +0000
Date: Wed, 10 Jun 2026 10:25:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, kernel test robot
	<lkp@intel.com>
Subject: Re: [PATCH] cxl: Add dummy function for cxl_memdev_attach_region for
 !CONFIG_CXL_REGION
Message-ID: <aimeJO4d6_RwViWK@aschofie-mobl2.lan>
References: <20260610001324.260268-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260610001324.260268-1-dave.jiang@intel.com>
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a146a7f-cc43-4166-805e-08dec7155848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: m9sleoWPM/peQBq5WrE3AndAnkCqnpniYV50NtfzYXu/JdjCspm301zu8eoJMZCEOIjgd2R/0Iedu6YT/w6CS6ccLDD6BrABSW7szDuUPPzgk113JpQoW3wttanvFP1oJw/khaO0fe3X639/17Lc3AEKNup+3jsgVZArV2lO09fJu4ac30E2WrbZqlfkgcDfHtez/uqxcPWu9FKimkxMqzBUZtywJa/WDJn78Iv7864tQzhkzPlLaib/KkaWVpGs9RnfXJqAQf6iumL+Bzvqklu6jgw8JaydRwQ16eueClipcLnKZWj5X3mzOXzdFv1WSnrMWn2bv7POPGq6d+tLIVd63+xVvvbETuAQ/aWobYCh+GULpIS8NU9HRzxPWz7/osnkJamZ50EvQxX08hD9hc97maoO8mT5aJEeprEIGIvpPDyPBzl+DEnlo4gpb84hv78lo3VT7Fc+HJ9/Koke471KZJm6p4k1adOmENf3nXqvwgLpdOm9lw4OJi3L+z5+dmUKIEBPR6omLPZu0ctSJ0V5Io1O/69Ylj4FYVPb69eJQdl4+P+YY+ifephf43erxxp2Fwg3JEh1UxzUan3/vjOk7BGGU+KEhoCrIoy05DrNuH6j4i2uPirxKmEX6xcVWHEi24vF8nxDa/5Uqf0HCa+SsHkPDdTa2BbBJHtfm8x2xc6ETbt4N0ud4drWZe49
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o5XrITZwbNP+3hDYRHy5lmJMexGQeBezbKhRBHfodjnlV89B/Yh2TOwiVcl1?=
 =?us-ascii?Q?YN7QML0ZZztVHsWnxLn3W43mKTFTJSOuur8wfnkxN3DlkgJRdmvWrW32u+PE?=
 =?us-ascii?Q?JwMl5ECh+1b7DPE4xstzZz+0wuC2YXWcpDc58g6M/SrXQljqAf9cfL3lvBaX?=
 =?us-ascii?Q?FsNnbk/4Jqo47pK5hPZuzxSEY7eBQ9XdlKPAjj/1LfqBl8deWT5RYh3DbKHv?=
 =?us-ascii?Q?sbMz/6nOIUwxHVToOTKK/FrIT/lasZRyRbylCs9Jp8BKciRx6tk7qsIHsTk3?=
 =?us-ascii?Q?bmB43h3XV0YZeuNY2RxxCuayWMFbnne0NTsMMKge6EcY4mrr03luZbw20dys?=
 =?us-ascii?Q?6x+0rmf9BMnEJHGTNaoDxDLiRBBZCQFyEarlNER0n5CIiPYSlGqcIYaYAXod?=
 =?us-ascii?Q?EiA+pm5Ie63l1SK7sQEeSd/rmui3Dhc3S1U8VoAhOmdMt1aeyZNGpsV2Jvq4?=
 =?us-ascii?Q?yL4A5G90js4Fk2qL3vmBvz2hYjJlLUHdRe4tGxrajnA74sz/A2di42p3WTw2?=
 =?us-ascii?Q?uEExKF85xQVWxOXcbK0FTEwrobgPaY3qjMB3IMP+58JmHYcXJ1n0YaYZyvUU?=
 =?us-ascii?Q?2k+hpIMqD2y6a1q/wEWDZXjI5uCyQD3VUyaC/nKl0m/BoNYZqXc/xc/JGkd5?=
 =?us-ascii?Q?AWR/vUJkyvMgk79LL9xhRVEzp7OfomMipjjKjJEFZ8J3ORCbn1Ue+kl8Qu6I?=
 =?us-ascii?Q?F4mebFzl3NsyNCMkSfdJ6nPIq86KZcIRBge/amVstng6J1k0Oad6rxmpUDaP?=
 =?us-ascii?Q?2m+NW/H6RMsLko0u3HoySydES6/AiLtDp7Y52qnrp8DwADyxg7LJLhKIxWCV?=
 =?us-ascii?Q?NoVTRSR7eNfGwNe6jWoVnnE6QqCR4YoUh94w7na7HONFBX7zVJa9i0rwN1O9?=
 =?us-ascii?Q?fumbYrJVQyXqcCMtmSeIhSzNOb1FeEqn3mUydYALLdCnup3WKlHMD5iIZIpP?=
 =?us-ascii?Q?ZrWHkHujydo80BCE6q3/205vaZ53P0/vL5XhmI+3EA3RZDjpspCgq/NRm3k4?=
 =?us-ascii?Q?NMsEVTBr8A5kcFunwScvTwgKKebSqyay15rS/49RtICuaGyFVmWgFqASj11s?=
 =?us-ascii?Q?hmqfkqTebXJuGnaD07Ghe5hBTPCVQpyIsF8Nid9OuCe+wqbFFsffMEVKqbzD?=
 =?us-ascii?Q?aXwTkN47CMqMuS2TfUjY7GLsUsd7RFdGhBuRZiOphY9FZYfhEKssSVwxHOUs?=
 =?us-ascii?Q?eRyTMYbYDgJeRjt8tQQ4Tl1KP9kuzaazoXDv35IAig76i4ICPBpXALjy1bt9?=
 =?us-ascii?Q?SUcJqwzi4Vj9PONyb5LY7i9pMf+Mkiv10PgQ1Z1BaJbrLIMHVDWiJnDFkI7v?=
 =?us-ascii?Q?ijyoBaSkCU7ijTmB3GcpmQsRB+rHJlUxrDTpeWv/tMzNs01MBHNL+X/xoSjz?=
 =?us-ascii?Q?aVp+8SZcNF+skVRDPJcwipr+Io/Il6LfSzx+Y3LyY9GO1s8ge2Ii0GQdGry4?=
 =?us-ascii?Q?Ct0RU7JhL+KhsR4xZ98bIrf2WECny6TW5pktZfea7HWuxok/u+9K3dYimV6b?=
 =?us-ascii?Q?zRx0Drgl4CFfuvScLJuGXi34RRuQq7U1oDWphctVPAqB2OBMt8sd/BS30gLY?=
 =?us-ascii?Q?LLs/Nte3mh7Z+Tj3+9llACEv1nkXro8At8h7271VyTg6CvUpfIRuuaIDwqF/?=
 =?us-ascii?Q?K7XEi8MLeTXje7pKKDSuQejjplS4B2jrLyG5xegaaZiYzA7N2kqL4zRpo9WR?=
 =?us-ascii?Q?gPKOxEhG/9dWG7LFHXyBpSlzcuIgXx2NLtzhIypnVelPu6S++GBOPwnOLzHR?=
 =?us-ascii?Q?J/nbbWX9G6dhDUQfPBjgtb68bWR0IvY=3D?=
X-Exchange-RoutingPolicyChecked: dggQGla3QSyTW+PNhFtfxucM+sM+ZMr1MjAdf/Q8MVljZ+Hsj2lakqrcvcD/JVts5Nbn5xrTzO/0U5iGoSzQve9Di6xwzKgiEXyz6XGE/mieGyU8GSDrPAL0qkuC/2NNhfN0jR7PsHWv7vBT1OT284ETqdEh5iCXc3gU94EW69EkXm1LYgEq5F2a6si2o3vwIeujAF95B3MTOsNZJFkgnrBswhrKFtfGelpdRWRNqJYJBq9y029zvovdaK0Q6wamytQOn5+koZ8NlQN8SCu8zYYLTyw+RuSINe9c/oAVncT2lBZv6LwxK81AlQ3fInGYofGtOeKgv+WMmoQrzqCTSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a146a7f-cc43-4166-805e-08dec7155848
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:26:02.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7FV0DLnxDabAvK17IeYql9WaVMmooEaT50ml7PZfJCBmavBHChSYtidkuiSNmVM+0e1SL19FbBdRYdxKPflbOhwvdJh/sM4GJ0wYQwl+Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com

On Tue, Jun 09, 2026 at 05:13:24PM -0700, Dave Jiang wrote:
> Add a dummy function that returns -EOPNOTSUPP for cxl_memdev_attach_region
> when CONFIG_CXL_REGION is not enabled. This allow sbuilding when
> cxl/core/region.o isn't built.

Thought above could be more explicit about what it allows building.
Something like: 'This allows building cxl/core/memdev.o when ....'

With or without a commit log update: 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
