Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD803FA5FC
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564671; cv=fail; b=O8Q34nu7duwMu8vN4/F1tVM+dB0B2CpJDLom8JJ6Mog/l1BMGKxoCzYIdft+TRIyjwkr3Qkg30VLWioNZxyk3FplJKNCn9zI7V3oevE7mTSqCpRue4yYf9GKdJNpPuUDFU+8He6DOB8i9iVZfLX1H1XXfTXpjNwzZNWUjbt3YMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564671; c=relaxed/simple;
	bh=wKHNdoSIzTWg4/aA01I5YANpwu3yi8OG/59Uv5hp9Tg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U3aYy9KYSCpPVsf+CN0F/Y3Z5HMFRs6jltp/KtOjTY8TFrTwtPcFO4yZwN7ABfRnvDOXSMmbMEejsTf8nI6zeE7mGY/UpFnIH9lv03Cdtv4DS75gQrpot6eJhE4ELtZiyCs5oaqAd8UY/v4WZoqDHZ/0OLxfs0OmGMI3+xNpBvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MN4sQVOY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MN4sQVOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788564667; x=1820100667;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wKHNdoSIzTWg4/aA01I5YANpwu3yi8OG/59Uv5hp9Tg=;
  b=MN4sQVOYncpMzIbS+3g4S0auWfRLkCetMvj9CBadRcbyTd5VhsOzbl5u
   Tw0iS4s2V2LsjvvTUvhMLg60h3UuCunCOKtCnjZ5UybCaNq/OJj0SnT25
   j7iN7jl3B6qDo+6lYhfS6JbQepJ96s/Jfc3Ezi9oV0YWOa0NEN79OO6vA
   O2Nxo+91Lrz80S2B98FkqU3DVZXifujQfZI1tJIrxQmW9a+Ic2yr+jYur
   uP/y9N7qi6ecfSmnxXw8OvdsSRPLzinBezQAKjlcZVDfYhUejtaMBIInf
   p+x1mgyIIKQbyI80r/ZwNfI3Stair71XG4CBI8cZ9dB0n6a88Fc48hMiG
   A==;
X-CSE-ConnectionGUID: cV/qzh0dS/GLlqmeDLe5rA==
X-CSE-MsgGUID: GG0nhnbmQ9G7keMYdnRNBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="88009699"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="88009699"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 16:31:06 -0700
X-CSE-ConnectionGUID: bHI/mQa/TZS//6Sr/UdfdQ==
X-CSE-MsgGUID: X5B0KdJUS9Wz8WgwSkka5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="300037950"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 16:31:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 16:31:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 16:31:07 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 16:31:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ryzv5escJFB2q6qZDWgm6o+Of8YgJ7QkXLGKQrDD9UCOXiphx11FSKenBfmrDk0RPyJ4x7Z+hZBZsr3d+RSagnIlBBtymQTSLFvoDduwZa2HAXbCUOoHDIosLmP2WZnGd/73UjvmGT8mUl5siqyj/BQ1citiG2b6JhAD4VLuoHoxowtfkOdMbTGRu9YxyCjyhUaexbJSY93j64Cto0//eI/gzfPFWob8b7aN95FvxjzRgzITF2gb90Q/WOfGr+UMzA8TUuV269PW6QWTA+n+qVx3aucw3h2ivoaoWtMXpDomaxtMlGXmX7iIeZ0f/XM/OpKN/udbTSNzIoOogrGDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDQTsGV5Izr/04s7jJc+ea1APs0D1spfjn0rSUPyGGY=;
 b=iSUhxHM+hfnwZ49rpnsjCJ2fkBuXnxtqj3Izbpc8X6TJFep8u5zfcWF+vRAAVqdparXoCqDybh3NBI2tqGw/KdMtOPfTdiH12c5ZOmNzmRVMCEWd95O31M56NgKgfecV4nkE32613QpG/7DXVVTRv0YilReiwJ0thPCbgQxIyo5HtraHZKF4Czp8Goj7Us0/6eMOfE03uURDLdOEXEDcxIR2uBAi6fSQn+QDrpP9uZet2dBDazkOr0p9WDASHWz8NlCe2IbNcWUfP8mTnNgoZuaJuinwJFpVaDydxCPlyqIkT2+E504tgx/PIEJfhfDn1csOg1IP0ay61vTnR6uk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL1PR11MB5223.namprd11.prod.outlook.com (2603:10b6:208:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 23:31:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 23:30:59 +0000
Date: Fri, 4 Sep 2026 16:30:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>, Srirangan Madhavan
	<smadhavan@nvidia.com>
Subject: Re: [PATCH v5 0/4] Harden HDM decoder enumeration
Message-ID: <aptUsPtnnjV51cet@aschofie-mobl2.lan>
References: <cover.1786143520.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1786143520.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL1PR11MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 14aaa7ed-ddf8-4f98-6260-08df0adc935b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0sH4jQ/bx2/MyEWj9eibVmJrPM4PXwpf0xj2mRtFItlN5o2FGX+Vt8JDM2Zl/Ay+sVjGn7Y0YmTFRZi86a3F2wUKxz6jH3aPkvqG1ZlSLx4cfxVOrbPFf0+fmIrqMNPAITXSOoFBoaQn9/6vjovwgaZwNBWQk7ww76OOXtMQ3+4jM/nE04vYk2dH92eUkTfCTBDREHs5FuX1JGGacwcGldIMLlNTph5Ygr2Su6loLtwfxUW9jU5JjvcF+Y+grMbNSPNKougr+50ebDqtLXHlDBc9eMhVyo1wrJzTyLrYQMo9eFQuZ5JF5aKIXG+SALcm/CxYUXcSWNrhYf1qzEplUaS7zvinAZ3ZlKMIf+Qjc+6q3RJ9Y3qaJV3LbunRZ+l2u4zb+6EC77yTrO5xvZI0xTYaKaMe2ZMoklt+6X81El2kSe7kHUOYF9tvgyknFibpgRTmL6sRToUXIw32J6la5DULuwtbWrh+/jsl2eV8Aqq3HuyIqZbroDT9zFBJLho34mHepCuWT46DA9DgpiS3rsm/HUkWT11G8fa6MLnH9boEV0oE6zSA/K6Z92xpnkFwmHpQOO5rSh21veaHHzn50pfNtjwyoSNIfrFPXzmPIj/jsYIxOfy1RnMeaizhY9+r9eNY7vaCBTJj0KYwdsLk4JPadqhMXhC3MQgP0yRQOmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EweAQhzUXmx2gfEF5rg7Vrvsy10O5UT9e5Ooga1cSJXQIH2sbBeMlYXnBnfv?=
 =?us-ascii?Q?h/NKSsErUTNhDubLru1g6js0HKV265UnziHlPHmWQTsKneDg/Ip8fq3bBDL7?=
 =?us-ascii?Q?iXixBqii8m/VGEGv5ua3oSsoy+exhAqoGUKiHAmGGEUpLr2kU5k3Kpy6u1hG?=
 =?us-ascii?Q?bL20/zpoT5F0uqCENSfUTz+j8cEgfFdJNc6cddJ3yVGSDXvFbUW+VVE7e2Ae?=
 =?us-ascii?Q?Zk5tAO7juuwEMtUkHDqDLyLgW/I7ribBzHfuPhgFK4lt2IKxFl2G1xXIYVFO?=
 =?us-ascii?Q?Bwbd5HOG19uNE4yrVKzKY/o+DqdPQawyC4CJAJATKC3j4TVUt7JqGP1XMTfI?=
 =?us-ascii?Q?8jLAlIfayruV9ONsi0z1yni7WGiZOd+jO/DGpORBcSv1KUkKXSnqLTycDf2j?=
 =?us-ascii?Q?2GsQQ4pE7R7NQHpNmwjfG0q9MirVC9ar6mWJnpjFqLoVQqOM0pjcgmDYf96/?=
 =?us-ascii?Q?ZQDq6nch4odeaqUeQEKxNNEOqnLwBFX1Dhm83SwiJXCJX3JzUGCQVg3UaQkw?=
 =?us-ascii?Q?2hBFaqbiJL2gH2koHLtEC/EHqwOkBZu8MGjadTEg7UMBym9vU56yVAT8qZVL?=
 =?us-ascii?Q?qt7DMZHcsT5Unlp/LzXGNs98ZaaXinK36kXqGH9qySpzjOcn9mxw4t3hrM4d?=
 =?us-ascii?Q?oWvFfkZou5+HwinCcGr4EdWaiSEbL80wi7e27lqaVp1HFffMumvi2BsixVFt?=
 =?us-ascii?Q?Xzbh0pDLDFhgClSaHQJP3anESCgkBOwYDsdm+ymedhgBigqqjIDGQZIZlw6c?=
 =?us-ascii?Q?NV+oBfrWQDKayBDQqW9trAEsw2NCrgDamCulULiFl0GEi3zDTSPc5ujp59T1?=
 =?us-ascii?Q?cZ4mR0rlGuIRZYqtvJn8yeyAXOXUYC5/fiwYQKXxdQK1MjHZKTG2IAekAlcu?=
 =?us-ascii?Q?SBVTYrMbCLfYRb+MPP0kwcfnrSGe+JVbdFqVqTspveiIDZuzgoYDAC/KmXfM?=
 =?us-ascii?Q?S9utp5BWuZQGElLM0JF4yE955edn+nFoMtHrG+o64StMeu00X5wYj//B6UCH?=
 =?us-ascii?Q?7ag/RQBhSZTQNyqQpcGCfis5rGRlnYTdrhZN0fqW4zd87uEi/hgMV4uy0qfz?=
 =?us-ascii?Q?7uk67pBkuKYy0ACG0M5WqGUxhtELTVis60O0MiMJTpwJcRSXu69+EvpReq8+?=
 =?us-ascii?Q?OpocDzD3OidzwF0AzKqHaOj2PknpKDprYfwqiew91+Ua/0iB0Vll+IUomeoy?=
 =?us-ascii?Q?65+/yEuaUzI3KOXzIAlHg7SA9g20B9n0al+tLjqW48tVQF1/W9o6/5KClgeP?=
 =?us-ascii?Q?54fLzzzGXryDnW9Q0A+iOSEdDtDLSFCqlS7dpXuKs6guxp0VJbK1+ub1RhVA?=
 =?us-ascii?Q?6PTP0lYX5RPOQ8a26na6GR/XNzLlRO4ZBPXZ96aVL6ujTMaZa6oTMVEVNQEL?=
 =?us-ascii?Q?jEhSuayy4aGn91ijD5xG4zqghei2WZzNCNaEdDnPzSKCni4yYG/ale8GgQqX?=
 =?us-ascii?Q?WzaOgQQoXicKy50mf4Ko1fFf7nGGO++mqhPfWjDWzEf6CnBK2U89oANEuvyg?=
 =?us-ascii?Q?Txo8h6bHND6fjs2F5gwfuSXkoMsjUVOonWykcmMLZFucOk5TmbPe+ZxsDXh1?=
 =?us-ascii?Q?aHWbFgK2f1k6lK/gwgdJoqipNUKvg67aH0mqWSbKmNntrmQtC7fW/sQE8lXp?=
 =?us-ascii?Q?8W0OE6BxBpKq+ZsfgQnITKSXwy7y9vVI3bzx3ukjDvWfg8dlJ3EYXVAbylhD?=
 =?us-ascii?Q?lhObbD2FIpgrdy/JGm7O7srBVp7lxFOWilgvZFMdulZniuZSesvYa8KTI/Wn?=
 =?us-ascii?Q?JCcR+Q2+TOBSpg04/vHGs5+xmqTQnEM=3D?=
X-Exchange-RoutingPolicyChecked: d+zgr3Bj37A6eFfPFOFzbKy5nIDiI9Xge59WBRC/TqZ53Hzb9sETdft1QWH4TYbBDExvWxrD4IdmdTvERXH9Hptu5bjwWoJ2pV1ZWSWRJk+Y90VXURtub91VzkGJYhHsYEWud74nlmOeKoykOHuV40KDZ5Fy7fgLWvW40I9UV+hZf2pvKTty5KWC+XMphjmiCZkYVgdt1jLYaUv0BalYN9UnNXBVfEHm8ewrL38bUeUpia4fjXvPVxawxC2rH3VOQZGT7o+9tRrN0f8MH+/R7Uu3v/0g+ePx5K4lnYpHVaKswmRXeuXnJFivJQdCdZF6k4GD3qnxQ+io+g/Mr2Lp0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14aaa7ed-ddf8-4f98-6260-08df0adc935b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 23:30:59.3254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4faMp4bS6pJ0+987ArihT6KoUdHhKhVPe9l3egf1knh5MpQ+yFGegbhI0dJ3Y8txC+M2ygfSAwMh6h7BHKxtfLmsqxuf/8BRHyzIponQ10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5223
X-OriginatorOrg: intel.com

Hi Dave,
This applies cleanly to 7.3-rc1 and cxl/next (of moments ago).
With these latest tags that Ming has offered I think it is ready to
merge as is. Please take a look.
-- Alison

On Fri, Aug 07, 2026 at 05:05:47PM -0700, Alison Schofield wrote:
> Changes in v5:
> Drop P2 of v4 as it changed what user sees in iw and ig attributes (Davidlohr)
> Renumbering: v4 P3 and P4 are now P2 and P3
> P1: Validate the target count once per port, not per decoder (Jonathan)
> P1: Move the zero-target reject back to cxl_switch_decoder_init() (Ming)
> P1: Drop the ways reset for uncommitted decoders (Jonathan, Davidlohr)
> P1: Declare cxlsd on one line (Jonathan)
> P1: Reword the CXL_HDM_DECODER0_TL_TARGETS comment (Jonathan)
> P2: Build the target IDs with put_unaligned_le32() (Jonathan)
> P2: Dropped all the tags on endian-ness patch
> P3: Commit log s/none committed/uncommitted/ (DaveJ)
> P4: New - bound switch decoder target array walks by nr_targets
> 
> Changes in v4:
> A new patch was inserted as Patch2, so now set is 4 patches.
>    Sashiko is likely to complain in Patch 1 for something fixed in
>    Patches 2 and 3, but reordering does not makes sense.
> P2: Only interpret interleave settings on committed decoders (Ming)
>     This is the newly inserted patch
> P4: Register reset w devm_add_action (Ming)
> P4: Fix up a kernel-doc comment issue (lkp)
> 
> Changes in v3:
> P1: Move zero-target reject to init_hdm_decoder() (RichardC)
> P3: Reset commit_end via a devres action after decoder teardown (RichardC)
> 
> Changes in v2:
> P1: Handle uncommitted decoders (Sashiko)
> P1: Reject switch decoders with zero targets (Sashiko)
> P1: Add in code comment clarifying target_count (Sashiko)
> P1: Update commit log
> P3: Reset commit_end on the failure path only (Sashiko)
> P3: Update commit log
> P2: No
> 
> 
> This set started as Sashiko reported cleanups. The patch added at v4 on
> Li Ming's review is dropped in v5. Davidlohr pointed out that it changes
> what interleave_ways and interleave_granularity report for an uncommitted
> decoder, and those are documented ABI. That is also the answer to Ming's
> v3 question that prompted the patch -  enumeration decodes those fields
> because userspace reads them, not because the driver needs them.
> 
> Only the first patch includes a link to the original Sashiko complaint,
> since the others did not originally appear on Lore for me to add public
> links.
> 
> Srirangan: I believe some of these patches address pre-existing issues
> Sashiko posted in reply to your reset series, but frankly, with the
> renumbering here, and the respin of your series, I no longer have 
> the exact patch to patch correlation.
> Alison Schofield (4):
>   cxl/hdm: Reject switch decoder interleave ways that overflow targets
>   cxl/hdm: Make switch decoder target parsing endian-safe
>   cxl/hdm: Restore commit_end when decoder enumeration fails
>   cxl/port: Bound switch decoder target array access by nr_targets
> 
>  drivers/cxl/core/hdm.c  | 62 +++++++++++++++++++++++++++++++++--------
>  drivers/cxl/core/port.c | 27 ++++++++++++------
>  drivers/cxl/cxl.h       |  2 ++
>  3 files changed, 72 insertions(+), 19 deletions(-)
> 
> 
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> -- 
> 2.37.3
> 
