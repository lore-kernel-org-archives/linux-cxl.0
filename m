Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B72D33468C;
	Tue, 16 Dec 2025 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765862836; cv=fail; b=o14QIvS2SqaFUdRVmsgidRFMmq7SFMxwqcJ+ojEyQ3PMO5Y9yyTX6K9cWW5oINJkZDH4EgXDuI1EYaG6b9VwiEBTK10wnBgNz+f5QwlVg9Xe/gjC9urY+JjosBAVlUphYHGnSzbuwATl6hMLzYtjysArg8MLSF8r7u99jfkckIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765862836; c=relaxed/simple;
	bh=sjrb7DXrroNz5btGNBEcmvszkq9pppzXs/ftPajN2EM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VwCWvb0TPJc/YrYFfJQ5qToOo3aUo+LX6xsWYHaYGQk9Y56VmdbJ057NTibSWO3GEUQ8lUtW3XZ8rsQTSNW+SW3vAO3tH5R2dt739nBX0RJoWiC0mM0Y+GeozKfFODfCU1Q06ROwVONZFGuB5thZnZDZ3tFJPxYGcSCoPTEuSgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n61q7JES; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n61q7JES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765862827; x=1797398827;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sjrb7DXrroNz5btGNBEcmvszkq9pppzXs/ftPajN2EM=;
  b=n61q7JESvMrurYN/iGlrh7bdBo9zZHV/rSK9vQrkkg3DWdn3Mu3DslHR
   dTl7isv0PbGCcA7ffpgD2bxguIwqB/8myoEHnY2kbppM5fSdds492PwFM
   Vb+FurB9j9+s9jt6qC9kgaozUvw3FNPCa/sTe1B+U2mjMEV9Tjg8V9X7z
   vJCjDQTkWpr1NRSqjsOLJgxSwe4Wo2EQWANcG3ftkdihTZs5BdZvP8NpJ
   42N8lZairAJghnE6e4mF+mzFJ8P9GRdfdhHpoyLslTl+xVdUG7Wt5e2CC
   UJ+oA13k/3wG1P3b/s3VoRGNRdOXCysGnGBUzUxaixTgKwXDgymuu93Je
   g==;
X-CSE-ConnectionGUID: 8qjZMr1dRtGSUZjHQw74Zg==
X-CSE-MsgGUID: 6RbVjuPRQYWnpljZRvHzwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="55341785"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="55341785"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 21:27:00 -0800
X-CSE-ConnectionGUID: LSmKc63mTBSKQV0V2sRLfQ==
X-CSE-MsgGUID: YyFjJfbgRuO6UNxpCfAAcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="228996742"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 21:27:00 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 21:27:00 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 21:27:00 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 21:26:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNskbuWMFS+hGylFNQZkDtsAuMwxieczLo0gt2RoCgIpYtOkuy42RhNi/rXxmOaFztw2KVMET6DRfw2oU/TxoecPnhDSfPWycUTfGkrPLQ88TLK5FQfLFqb02G9P1YZuor3JGyFL0UEtBvL2o43vAFfJYgVVJGt/FJxRsCuuuc1DiCKLS1gi4rTaPNa1zA9H9+v8paTbewN7XD9/A2DAEUz15923VRdHRVhZUC9RGeeJiAkgD8WrdKq/TG50MPGiKGh6drCGq3UBblFDo/Q8oQu8SH4WvJyxmwMga2TC782qD+SA2ClMUr4X2wgXSCwLAM4J5CRmDWTOMIpvnLoUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeN14Y0gKrIzT5Y80WBVSMsBcHVIbvObVRWS2D9WMAs=;
 b=hJUelA/c2ykV8h6QzPF/Ye+xGwyDT3Ok2XRmQQi6izFFsWJHazsTpxgktmxLSBPQt7VZmohTA3ZmmBnpxZNxN+XMBxpbDWRtbTXi5kPrJCQ6KldoeYo1Y1zFTr33xmb7TY/NQf4xocc2REMin7CW8IoqvtuF96AVnjfSLPZ2+vQTfJgDmh+NaH1wMYkOqyaCHz8H/3fT2fPywxOWbNu6KkKOeeNHARn5uRo85S7ZqYRg8EMOSwGvlkxBnAW87B0/WI4IXaSo8/Eyv8pZZ2x7Q3RaR4KCa0Q06C1okTRHZ6bwSydJIox5OUgDUtvF7du/DoNgEwWJnam187rtyD6PSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB6989.namprd11.prod.outlook.com (2603:10b6:806:2be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 05:26:57 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 05:26:56 +0000
Date: Mon, 15 Dec 2025 21:26:52 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v8 12/13] cxl: Check if ULLONG_MAX was returned from
 translation functions
Message-ID: <aUDtnOIGKiHTEpEO@aschofie-mobl2.lan>
References: <20251209180659.208842-1-rrichter@amd.com>
 <20251209180659.208842-13-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251209180659.208842-13-rrichter@amd.com>
X-ClientProxiedBy: BYAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: db1d1102-d4d4-4ada-ec00-08de3c63bac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8av0yUtfPVvCOFUSERnYIWX8RMFYygGK2rnjrRzRsy9xrAqYtbPB+DKvFepa?=
 =?us-ascii?Q?O8Ik4lnDirFeOZVKKqlsPn2f66o57zuw9KJ0FzpvmQ0SiBCPyOxPfSnboUT5?=
 =?us-ascii?Q?tY18AykKCSDznBxHYeaFSOtH02kzE9VRutgqsWjjgb8TcgQicL7wQkz4wluo?=
 =?us-ascii?Q?+WoggHgkC/O1BziTwdzv0A0SjbraIDcYdOxKADsGPYmkbgrPXRPN6Rq98u+I?=
 =?us-ascii?Q?dS4ZVvqjG/D2RiKoM1n8jDDWqIUZl1U5cPrZQbJeAEeuq3kCVg78te0MmRnw?=
 =?us-ascii?Q?XejB3QOthsHkXLrfqYBqJjw2UVeuGKdTmzfLVTAluqNSJ8xB4sEFp/GAlmVU?=
 =?us-ascii?Q?8h4OE/JIPNFh4H18mMn/UdwLLxi7lHfadeSSngIJCMrosDJPBQrj2MkUsKDE?=
 =?us-ascii?Q?3sacN+0SJPqhFaokexa6kEiKwq02C2NU8bvTUnYQG2Ikcq4xVbaoKKYaoEOd?=
 =?us-ascii?Q?Sz23KaYnGf92UPu6J0YXE+0FNlSw7qJjxReh0sy7nRJlbHB+u43vYNA3UjGs?=
 =?us-ascii?Q?CkOZKtwTfFkIi3+ZBTyMhxrvWFjvpWdIG2nx10CkcMepLYEfiJKlBUoIyeOL?=
 =?us-ascii?Q?pm57+AavhGOH+wK/R0aky1KmXqy33jftsO0fIG211kX3HQkK8NQsoz7oy4Tv?=
 =?us-ascii?Q?BF+CUGdSeDMlBegpJrrPoWzl0AgrnMvv6o6CJ5mn/9s9QwANUj7/fnI0r2Sm?=
 =?us-ascii?Q?YF4XMKfc7N5CNS0UvA+zd6JEY4H4LWFxkjQYyobt8KsMSPuj0/zonxfLNm4e?=
 =?us-ascii?Q?f+9glmdKPqZMUlISVSsom0KfB5mjNAm/b4phLtGRzT2mS+iAZxzkUQXk6XtF?=
 =?us-ascii?Q?dAwCfgvyiCxQuGs2YnDT43Of61PvLjjX8Hc9L2BaINals1Ikl22UOggFBOKE?=
 =?us-ascii?Q?F1XHUngdtMWPhEDS4QX7irGhvbRsEH6+DbaLKYEqEffRqu1ym+ZjgJLwVCcC?=
 =?us-ascii?Q?Je0w2LIEpeSElrCv8q1OK2q+1ErvWXw3b7R6LgKOwE0ZdgHb/mV1gWXTSmXN?=
 =?us-ascii?Q?x4G2opZxAO/1WQNITXveUrSFFr7Pm98MYgF5S0AUJPB1htoqpbXdP/TdQEBU?=
 =?us-ascii?Q?aK8yZJmP8Ua5MFxdr/z2/0qRBAyOeJu3G2sHoT1OzAsdHd9etp57520cPpSM?=
 =?us-ascii?Q?b35gVVxCvxFeisHo/k0Ibpd63MAHUkclpZMdO2msXBZ1mLyewLd/FTV9tc/D?=
 =?us-ascii?Q?Q9zcSXZtdTaIf/5rNckDxKoIVoUQTbcHh8SFQnPEm6kVM+97+CriuAvOjw37?=
 =?us-ascii?Q?wY3+zoQ/iWAM5tHzbq8nkJ6jYSGnC73N53VXubAhEs7WByMI9keic/rBcnoZ?=
 =?us-ascii?Q?2lkULxD7KHXDjLX+rC0SlTrm5f5YWlTIQWE1h8gRpkWYRBWF/gFEcqlAsJLf?=
 =?us-ascii?Q?Y9iikwUvtp205uqOSX4Ke2LNIYMERWAcS5MPpNrxQnhHSVhR77FJVhLY7tp8?=
 =?us-ascii?Q?BU8JyVtxJAixgMVVOnHYjWKvBYDjaKCv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PldtsYjlMkUCXjn18Z1L3L4LozLg/2uZSS5PD4rbMNKHyMT5topAKkLY/61E?=
 =?us-ascii?Q?TQpeTB0TO7yQaZogerPvKug4Uo4GGFJziA6+f+fS/ild+MN4K3/oO8FLKmzX?=
 =?us-ascii?Q?Hl+Z3B64+u6pVv3gSJLAe5Rsg7v4pjjhVaBxuZsV0PYxEMnarTcEHupawan1?=
 =?us-ascii?Q?ag2iITa0qJ2cfX2y6rSOXXDXnSKKQKgZSdpMh1Ic83nLf//chv9bXVca5F7t?=
 =?us-ascii?Q?2g3/NtTWAlyO6uypcYInToqhTPrNVL5gtRUX2hwUd8NR30ArVDVbB2JVDUHJ?=
 =?us-ascii?Q?qoWgalw3/SFCB2QGxJVrW4kI7eu5h6nirmJpa3MIij4ymvlsMiCn6jOyiK9t?=
 =?us-ascii?Q?aCDVFVjzNeRjiYiJWklOn9ksVoYzatG1ATOGbkCuf9M1jXUxHkL48D9Ts13m?=
 =?us-ascii?Q?D2Z+3yG5si0N3BOdpbM+gwFWDycuxcBd/0KH75Pg5Q0Eo7Kd58Q5Ai3oGlOF?=
 =?us-ascii?Q?kneGyuSI8bTgnf0xApupTz8CSmEY2BzqYyHr0cJ1JjXtLWQTdz7ZUbLgWz2B?=
 =?us-ascii?Q?0FTImlc8jEKY7EmwfnHO4HQvn9uY4+ws7GMPD4XdyywOcTPUpAqQZS73gDjx?=
 =?us-ascii?Q?oteJaulwK1L04/LvyZnS+N0UIigENr9atr+LGBugHfVUXJa3EusFqlXX8nR6?=
 =?us-ascii?Q?f+QBh4TFkkI5m9U1rh2PQoYUJ1rnSFKfBVKOXi9tNc9Kaj1Yo2RaXzV2LPOJ?=
 =?us-ascii?Q?Zybe2NEyGPRGjBxC0JbM0Wcu7KRTpsQ4nTh25kIJMIKcAec93ZsBlEnGAek2?=
 =?us-ascii?Q?1/Ybdz+wg2gVi4P000gpthWVNmJPzGyxYya03CPh6OaoRaGHKmbkT4N4CqSJ?=
 =?us-ascii?Q?XyQXbHCXTcYdNEeXAq6QheB2s6U6K/gnyTr/Jq6IIVxV5ezE2bhRON0XsPsl?=
 =?us-ascii?Q?gh9q+S/B6vbnrfU8HmSHjhLjjKIVvnA4oryIsbDkTsNtyJPVuxQBmcSr8EMy?=
 =?us-ascii?Q?+cn4blWx4CAXoSArcQj14suc95YaihLacI8EBZjLCQcS3IRJGVFnA+QZWDlS?=
 =?us-ascii?Q?pLLkBM+A3qe2OyohkDWZbK1BfTIftDVNW9xZICq9UioM8xAt49ZzrEsb1o5I?=
 =?us-ascii?Q?M3LCarCxb/xd3eTupr1HY+vp3d9yCuDCEe43wjDQyyagYVb8N8yNCdsyUY7E?=
 =?us-ascii?Q?t0jJreTKDKXPJz9LK7/OgRgHoMn0khF8U+4sgj2OuZBaqxrCcR92YHYBH17y?=
 =?us-ascii?Q?dh7fL7kH5VYsTOM4C1sK9OYN4lO4mnBt3o+NBkQMVzUawXpbmjoAI+Q3ChaD?=
 =?us-ascii?Q?mJx2WAVvRxh9iu8Umjucdw2rF3wA/TFPHL0wBmstgrx1b/9r4tMBZjjXdsYv?=
 =?us-ascii?Q?I7ONzDVtyVXEGSGwrKTBCtc6/uF+4srIOUhtq2b2+b2GNnluUh1BCpV99h7m?=
 =?us-ascii?Q?ZVRKgMWCnE7STj6w4Goa8tXK67NHOJbJSyLC8c8NlwNX7Rgtzonc2c28lRI+?=
 =?us-ascii?Q?5AwMEdupV1VrzJRo3RtYlY7IPOLMZwP7Q3F2clcsJ2bia88gdOX5PaZms8JH?=
 =?us-ascii?Q?9seNAynHVMZt3+QBwQYWyVgLuDzsjDPQNPVTs2Stvctp3M9Y4Y2p6mFtDxwm?=
 =?us-ascii?Q?d4lYw5AXdasrHlD56PQsSm37PHp6zzFAIo6OOmhrw5OYLgdcpuMEXw7eY8rZ?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db1d1102-d4d4-4ada-ec00-08de3c63bac7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 05:26:56.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fVexQkraZCCuvFiIbJJgQf4XA27NJpz6d5YA9/YcpCCwZF4DPiJ46dQoqJ0Pl1TZWvJUK3t5cy2lSTnbPXltJ1fV9Ek6p26yjBEF+WDgJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6989
X-OriginatorOrg: intel.com

On Tue, Dec 09, 2025 at 07:06:48PM +0100, Robert Richter wrote:
> The return address of translation functions is not consistently
> checked for a valid address. Check if ULLONG_MAX was returned.

The why of the dpa base address change is not explained as that
That -1 return would be ULLONG_MAX in 64 bit system, so not
clear why the return value of cxl_dpa_resource_start() needs to
change. 

Is this is for general cleanup, then, like DaveJ noted, returning
sooner is better. I guess post this as a general cleanup pointing
out why the earlier returns are needed.

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/hdm.c                 |  2 +-
>  drivers/cxl/core/region.c              | 36 +++++++++++++++++++-------
>  tools/testing/cxl/test/cxl_translate.c |  4 +--
>  3 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1c5d2022c87a..8b50cdce4b29 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -530,7 +530,7 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>  
>  resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  {
> -	resource_size_t base = -1;
> +	resource_size_t base = ULLONG_MAX;
>  
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	if (cxled->dpa_res)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c7ac78f1b644..2c070c7c7bfe 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3124,7 +3124,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> -	u64 dpa_offset, hpa_offset, hpa;
> +	u64 base, dpa_offset, hpa_offset, hpa;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3142,8 +3142,14 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	ways_to_eiw(p->interleave_ways, &eiw);
>  	granularity_to_eig(p->interleave_granularity, &eig);
>  
> -	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +	base = cxl_dpa_resource_start(cxled);
> +	if (base == ULLONG_MAX)
> +		return ULLONG_MAX;
> +
> +	dpa_offset = dpa - base;
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
> +	if (hpa_offset == ULLONG_MAX)
> +		return ULLONG_MAX;
>  
>  	/* Apply the hpa_offset to the region base address */
>  	hpa = hpa_offset + p->res->start + p->cache_size;
> @@ -3152,6 +3158,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	if (cxlrd->ops.hpa_to_spa)
>  		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
>  
> +	if (hpa == ULLONG_MAX)
> +		return ULLONG_MAX;
> +
>  	if (!cxl_resource_contains_addr(p->res, hpa)) {
>  		dev_dbg(&cxlr->dev,
>  			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> @@ -3176,10 +3185,11 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_endpoint_decoder *cxled;
> -	u64 hpa, hpa_offset, dpa_offset;
> +	u64 hpa_offset = offset;
> +	u64 dpa_base, dpa_offset;
>  	u16 eig = 0;
>  	u8 eiw = 0;
> -	int pos;
> +	int pos = -1;
>  
>  	lockdep_assert_held(&cxl_rwsem.region);
>  	lockdep_assert_held(&cxl_rwsem.dpa);
> @@ -3193,13 +3203,14 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	 * CXL HPA is assumed to equal SPA.
>  	 */
>  	if (cxlrd->ops.spa_to_hpa) {
> -		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
> -		hpa_offset = hpa - p->res->start;
> -	} else {
> -		hpa_offset = offset;
> +		hpa_offset = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
> +		if (hpa_offset != ULLONG_MAX)
> +			hpa_offset -= p->res->start;
>  	}
>  
> -	pos = cxl_calculate_position(hpa_offset, eiw, eig);
> +	if (hpa_offset != ULLONG_MAX)
> +		pos = cxl_calculate_position(hpa_offset, eiw, eig);
> +
>  	if (pos < 0 || pos >= p->nr_targets) {
>  		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
>  			pos, p->nr_targets);
> @@ -3213,8 +3224,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  		cxled = p->targets[i];
>  		if (cxled->pos != pos)
>  			continue;
> +
> +		dpa_base = cxl_dpa_resource_start(cxled);
> +		if (dpa_base == ULLONG_MAX)
> +			continue;
> +
>  		result->cxlmd = cxled_to_memdev(cxled);
> -		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
> +		result->dpa = dpa_base + dpa_offset;
>  
>  		return 0;
>  	}
> diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
> index 2200ae21795c..66f8270aacd8 100644
> --- a/tools/testing/cxl/test/cxl_translate.c
> +++ b/tools/testing/cxl/test/cxl_translate.c
> @@ -69,7 +69,7 @@ static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
>  	/* Calculate base HPA offset from DPA and position */
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, r_eiw, r_eig);
>  
> -	if (math == XOR_MATH) {
> +	if (hpa_offset != ULLONG_MAX && math == XOR_MATH) {
>  		cximsd->nr_maps = hbiw_to_nr_maps[hb_ways];
>  		if (cximsd->nr_maps)
>  			return cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
> @@ -262,7 +262,7 @@ static int test_random_params(void)
>  		reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
>  		reverse_pos = cxl_calculate_position(hpa, eiw, eig);
>  
> -		if (reverse_dpa != dpa || reverse_pos != pos) {
> +		if (hpa == ULLONG_MAX || reverse_dpa != dpa || reverse_pos != pos) {
>  			pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
>  			       i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw,
>  			       eig);
> -- 
> 2.47.3
> 
