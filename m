Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3418B484;
	Wed,  2 Apr 2025 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611644; cv=fail; b=VwRzgPVcGLDRQhoa20t+WNI5db8GQqHja+CqD9zQaGSyq5NsVe/mljwD0+rPsPAGo21fJT2hPhxOE7dS96F7UjppB/TLmabR1k9PTzu52Iehdb9Exueaqf9ZKUlogac+lYJqBw/DTAIF/EGsgGNR8L0k8vmNyFhxF3evF3cWhn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611644; c=relaxed/simple;
	bh=ckFgYRmOxYmDsOCqbzlBsiNsEwAiDU6HwReIs5B/+ZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f+TRP9L3/U1wtgQL1legUFm34rx3PPMRsvcH4m+K6hRfaCRjpjs/AHvIlkBkQSpSb4dGRzwGEAMpqqdnOhQrbNLfnXQwcLNmHs5m+wiucZEMC87f7nSIWm35HlC/MRumFTi+UgZXB4n/l9SWhN7ziaK1katcuq96SgYiO7ULjPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeKFhTuC; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeKFhTuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743611642; x=1775147642;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ckFgYRmOxYmDsOCqbzlBsiNsEwAiDU6HwReIs5B/+ZA=;
  b=IeKFhTuCZ44CksKHPEpH5yVkNHxhWnwux+XTd0q+TSBUBftc7fLIyila
   ZSzuGhfsGS8TIsWjJYumcgI9QaIzcPKHA4l6khzlP9/vJTAZi1T0RulqW
   WjwTeFFcFIhCPSiOpfoT2PN39ZC8bpaTi+t7vKt+msvVSU7iPDN53S1lj
   F8HL7iShBMgH3DWl6VV1qvr+9Pa0ibgmqD9fsXfpt1/sIOIKGX6oOsLEg
   TmBSFX3ixG+XV4Ofvf/RW89mikqA3jd+9WzKADQ07RzS/rX3OyMluWElT
   xfN63/hBwZZPGlb/M0q/Bd+mKzsDqO+3YTL+kE1euZjUFPWOo46QRjTZY
   A==;
X-CSE-ConnectionGUID: i8ZL1ac7RIKXSIvadYXw1g==
X-CSE-MsgGUID: C4bvv7BJQHCX8x/mctCbsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44697665"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44697665"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 09:34:01 -0700
X-CSE-ConnectionGUID: FsE3qWOkR+eKoMQcmUDSyA==
X-CSE-MsgGUID: nXA6I0KjS3O47s2dLiD32w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="130875791"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 09:34:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 09:33:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 09:33:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 09:33:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbW0LItj5abGde+1mEJnDK37jh9jerTDZeycHLPSzHmwq4A4nZcGpbBtaR9Tl9UsbGuAh86V3Mvi2Jvljt0qwpcLjoW+OCOEf1rTMFyd4Ea4tQylYgzy4EHZ2mreySK8qgZAsDMInNRr9X06eXPaD+4Pp2/BwZzErd3w6XJkHj23kgdQsE3SEJSmoEzd8eSaQnr2xGyk8NNy3b+cYVDM46vNePUhezMU+CSCI5pxNtV3siGHAAM05DHEqax77HzPhq0c2HTiUXZapEqi5rwlNFqluRmzKBEXws5MtBU8Naf3k9r1jHzM2wP1BIkb8JyL4ln7z4DjGKML63E0WGZ44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdU5XzzQTY0veu1RKK1iBE/FF3p99916C4szTFm5F4w=;
 b=ora8R/kKDRdtkO8x8XeFuNiE2tYXDjw8MMXMf3XvFRpHRnBJDkFiBAJmZz5FbcZa3plh1BY2rm+fdrpgzMEK8iAgAK1YplwgRs1Jc+bmWBtdkSqeJgKgRedTgA79Dc6XWJhhdywAfoYGUPwkEuowcnp+fDvBMCScMHJtLhnIRfBz/rT7zeB0+VGji02oc0nWuWQRaboaQMsX2GbaAMAyx8Tc9RtcYr1UOkavgy4OUCT8s/jBwJ+bupfYM+YI2aR8/bVte26l13AAvW3eSqENVzz/fenNAM7ndidVfPUZu5pRm7S9NAih79m3Cf/QLCRQniJaFE0XTQb2RIZkproE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 16:33:56 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 16:33:56 +0000
Date: Wed, 2 Apr 2025 09:33:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Rakie Kim <rakie.kim@sk.com>, <gourry@gourry.net>
CC: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<joshua.hahnjy@gmail.com>, <dan.j.williams@intel.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>,
	<Jonathan.Cameron@huawei.com>, <kernel_team@skhynix.com>,
	<honggyu.kim@sk.com>, <yunjeong.mun@sk.com>, <rakie.kim@sk.com>
Subject: Re: [PATCH v3 2/3] mm/mempolicy: Support dynamic sysfs updates for
 weighted interleave
Message-ID: <67ed66ef7c070_9dac294e0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250320041749.881-1-rakie.kim@sk.com>
 <20250320041749.881-3-rakie.kim@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320041749.881-3-rakie.kim@sk.com>
X-ClientProxiedBy: MW4PR04CA0250.namprd04.prod.outlook.com
 (2603:10b6:303:88::15) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|CH3PR11MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1c9f8e-4532-41f2-64f5-08dd7204299d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M6wjEwdRE+w6Rec6sVs0wNg/KRR7fhKRwoIBij8XrEyI2drYZ+uL1qKk2lm0?=
 =?us-ascii?Q?s3NgSAU+fgp1H/STW5/Dnsv8kReIkcClbNbVhzrWMhyNmwWZK87xBGkltIFZ?=
 =?us-ascii?Q?Hp8mGP44pnLthsN0fAGQFlIASLp1E+b8mqkrgFytnzpNnRJVVWGiR80ZgAZ6?=
 =?us-ascii?Q?6lnrCRDbQWqw3aVTyx6eNQn5k+qwTQ1T2deL6yiTf77tKIye7b548iLPyn9Y?=
 =?us-ascii?Q?N78j/Ow2Qy1csNxrr2qSd9TGN8w/P2QLPl3+BIgEhJYYDw7ec7PFTtxf4I+z?=
 =?us-ascii?Q?u5Ejo/BDhqwf7eKa0m2ERlqTI1dOxunPvGBIJ0ERgRRUMrXqoEelbldhI3Vi?=
 =?us-ascii?Q?7i1+8URmaCI3hvuMAQWFWfX1nlm9aHgUw6WVwk+mmPmoCReSfYeQ5SLfLmv5?=
 =?us-ascii?Q?U6wOqOv1eqg2+UWaxp0aOyygZjMbxGYnjXjdUpc6mOOXvsFXewMxkj81VQPA?=
 =?us-ascii?Q?ZWQ/qGV8IBwpGVn3ZO0wGTG0YHPxRHzPqy9Lsdv8PbBEsiHgZNhbb7QeXAFE?=
 =?us-ascii?Q?2ymiAlymLrKkFkVPd0zeZGt0JzZeLrBIGF6wL0rb3Kw+ZpzP+3U3mUVYoSUg?=
 =?us-ascii?Q?WhxDvxkLKrhEEAmr462a7yPXRXwXaZdsItueiH7UwtCFHtPfch9+Uj0W6bxi?=
 =?us-ascii?Q?F+tn+cOb8afIs8y/o7E4mMV9bM9aWJ4uReGz09CnxiNjDLEQxaKyizNdEmDw?=
 =?us-ascii?Q?P0JWb6225YOZOQ4Phug7ur7vQT6e5jzNhlRFGF8x8sA/1gtPVhb0JkJ70xF0?=
 =?us-ascii?Q?YEyh38jh1V16q4fFbUeo3OBcrLyK5zVuhGJ2jMELpwBS3Yc6O3MllFScqWY5?=
 =?us-ascii?Q?ZqPPxLHjLMx4f98l2t9QdRm9enSObn+eC2SU3/t3usWGdCd5NUheXcVAQ+yt?=
 =?us-ascii?Q?4C6lsS1C6k2eI2XyWtgXuHpjV70kdopiMbv4auIUvHDYoZtiVICibzuJjAXZ?=
 =?us-ascii?Q?lAnAG4sSVv1ZFID5laYyvOG/pAf9sRGtPZ+DSrdwwjp9HZ48IkB5lOVZoHjw?=
 =?us-ascii?Q?a5qss9z6WuhE/6jt9FRNzd5Kss6aV7p30Bmq8nehy33P3BcT418dYnj1qL8e?=
 =?us-ascii?Q?cmHgn4vYH7yfIS/jd40vqz59t2aCR/KAtF+NhG6cM4k40mNIDVU4gvbin7gj?=
 =?us-ascii?Q?A91YU6VVi7u4g5n7F+CsABjxmi0s8IEHzbJOJYaIGG5HSIbvZ3BR/iBRmMx7?=
 =?us-ascii?Q?i6X9HYxy4nPaACVp/2OClI5qtqS4kxXs7GK9uYJA/AUrEN0LEIJ7YKnzCREt?=
 =?us-ascii?Q?5HsZj8AX2Ii43IbBojwbS+mYDd2mVHyY2ovL0mcBupoWqPWhax9rQGhAbOXL?=
 =?us-ascii?Q?i3A2uECiFQHXUzAsfeZSLMILKH3ER25C7YTQIAqz6ye/nYAbbG0EJ57cFis5?=
 =?us-ascii?Q?CB+9AdM45EONmwB8WgWj39G77gjQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ny4YooCn3846Yg2cYpm717cVZS7M+zb77hhZF7cK3rTxJcxreNyZvHhgSoQG?=
 =?us-ascii?Q?xAdDTKdyjRjJHyoaIy6qPXRw829WW4hG/dKsAGBkdHMZM2hEaGxVvPavo9AD?=
 =?us-ascii?Q?9sH2mxRmPXEEAyWthorgAyQsXeEsk76CNb4OGnJWU+gmGq9Czm5I6eXJ0CY5?=
 =?us-ascii?Q?qWchR1Q5wkZSucd5S+0MKVdO/LdKyrMNpzB/fs5JKzeA+uLEdSdcW+9kiBau?=
 =?us-ascii?Q?Dy4JJ/W8BRzjZUScgFc+s0xP/PPpaCGp9qXI9315B8WX04+bySaYO7slbHJL?=
 =?us-ascii?Q?OocAga3XGZyzEITS5DTTet/1eAarR76cTcFf4+/XtdQG0KYjllBZb9KdQ4hb?=
 =?us-ascii?Q?Et17/FrlUelqJBUopgV9RkGMPlIBRpRX5DulIbP+lKZjzRHxbHe86I00jOQS?=
 =?us-ascii?Q?O8f6Fm80XgRf2R70KfSUsbk4RqlCZ/qIv6Z+mNQ0iRzisXTSz9r03fnXGG3T?=
 =?us-ascii?Q?pvyzLHWeDWQET/vW5SFo/GaJ7suSkbsv3lZbTkGxXx8x3fl4Pxq9RScfaKzw?=
 =?us-ascii?Q?ewPPC6tBpoKswefIRHdSQC7+VZLbKdjWgk97X5gHmtTGBM4jDufe+WWr3HzM?=
 =?us-ascii?Q?D6GFiGdDSCJRZlNFDL1lUHP2/EcgwqPjXTR9NxMB6i8TT7MfutGxUauOtyIS?=
 =?us-ascii?Q?JvKrZz9dF0AADtwsRxYaSUmWc/kEJ5GBol+j1/7UYxJl1g6ALVo96Z2eHbQd?=
 =?us-ascii?Q?QaDYyzVwHa26tgtXxBvoLxTQwoshGQBQvna5yUVcliW6fp/dnMDdRME2wKEL?=
 =?us-ascii?Q?KcyzSXnR2HUFf5IwwNLC3NfmrvwbpxUwfW7OA2RDpNOoclufuzcTpFOlOv2v?=
 =?us-ascii?Q?0CptG8q2/qSmYT/XdKfzIHLGeLPq/MMMvGS1TNaead7yIdbYp4GehCu2Gso0?=
 =?us-ascii?Q?f25KYzjRIcu/6Jmh3aZ6t2hRPfb78fhoBP8EmTYbSmABs/J9U6kNoketjwxM?=
 =?us-ascii?Q?LPDsrcScSyLRf3McL1SREvHxR4Ek/oGzgZBfpK2KGAjovPS+8F6wxr7Hnyt+?=
 =?us-ascii?Q?44714AvvBeVpxLpIOpc5WO840+K83Q/XgsCUPHZGuGfudv6YZAZhy2frsXkN?=
 =?us-ascii?Q?HsoTzDd6VpF0xx51ks1URSa4hdVSVU2Mg4Pfzz60MZTBQS0IUD7pfsGz/FSa?=
 =?us-ascii?Q?27p1r1YuE5POY/L0h53NXMHCUpQKPWtTAkN/ko7ISAt2/Dhq+wqQt5AieZgF?=
 =?us-ascii?Q?CMWn03k7TPrCpPLMaBv1DyEW1ZTvFsTeTgBG2D9hvEvwR11ivb3iLDFrRUQi?=
 =?us-ascii?Q?wBXSqXIqCc8sGL6rC/nqD4g7z+Us7JiyzZSkPGx8GjezwPoObV6OA5xd7h78?=
 =?us-ascii?Q?Gxvh3O7f79v0RtiwwmpwR5qoOKAYoDgaWDdmZVVl8QC45GMpsN3PJlE3d5LK?=
 =?us-ascii?Q?rFm6fWCvj7N5W//dRar+NRtDk+PitNgLExjFakYIvXr+PzhJ2RwavLbYmumj?=
 =?us-ascii?Q?NRwAdiBss2Zhaz6+7bM/0a7CktmbHNMOU4qB8y/FTYsKEn4/0gbh6PTwORcW?=
 =?us-ascii?Q?yMoe3wGfKHe1Shdf6lTX2u3e5g+UsHql930iNFQwqBmyMQzzcJypzYLTut8y?=
 =?us-ascii?Q?WqmEDOpiKDBThnOqKGClnCLfORvuReLmcLe+OQpAFOGZ01R9MY1LMvhYfPk0?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1c9f8e-4532-41f2-64f5-08dd7204299d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:33:56.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAX6ObDJGeUZzlVb0GEN0keEFra5DGrs1I7kyTQV4bta2CbAiBeTqvZBJ3o5cDGQgRZ4En/7hHiHKZzufSHNJeKN42LEF4IcnuI8sab39fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8773
X-OriginatorOrg: intel.com

Rakie Kim wrote:
> Previously, the weighted interleave sysfs structure was statically
> managed, preventing dynamic updates when nodes were added or removed.
> 
> This patch restructures the weighted interleave sysfs to support
> dynamic insertion and deletion. The sysfs that was part of
> the 'weighted_interleave_group' is now globally accessible,
> allowing external access to that sysfs.
> 
> With this change, sysfs management for weighted interleave is
> more flexible, supporting hotplug events and runtime updates
> more effectively.

I understand the urge to try to make a general case for a patch, but it
is better to state the explicit reason especially when someone is later
reading the history and may not realize that this is part of a series.

So instead of making claims like "this is more flexible / more effective
for runtime updates", state that motivation explicitly.  Something like:

"In preparation for enabling weighted-interleave sysfs attributes to
react to node-online/offline events, introduce sysfs_wi_node_add() and
sysfs_wi_node_delete() helpers to dynamically manage the
weighted-interleave attributes.

A follow-on patch registers a memory-hotplug notifier to use these
helpers, for now just refactor the current "publish all possible node"
approach to use sysfs_wi_node_{add,delete}()."

> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> ---
>  mm/mempolicy.c | 70 ++++++++++++++++++++++----------------------------
>  1 file changed, 30 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 5950d5d5b85e..6c8843114afd 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3388,6 +3388,13 @@ struct iw_node_attr {
>  	int nid;
>  };
>  
> +struct sysfs_wi_group {
> +	struct kobject wi_kobj;
> +	struct iw_node_attr *nattrs[];
> +};
> +
> +static struct sysfs_wi_group *sgrp;
> +
>  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
> @@ -3430,27 +3437,23 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	return count;
>  }
>  
> -static struct iw_node_attr **node_attrs;
> -
> -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> -				  struct kobject *parent)
> +static void sysfs_wi_node_release(int nid)

I called this sysfs_wi_node_delete() above because _release() is
typically callback invoked on last put of a kobject.

>  {
> -	if (!node_attr)
> +	if (!sgrp->nattrs[nid])
>  		return;
> -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> -	kfree(node_attr->kobj_attr.attr.name);
> -	kfree(node_attr);
> +
> +	sysfs_remove_file(&sgrp->wi_kobj, &sgrp->nattrs[nid]->kobj_attr.attr);
> +	kfree(sgrp->nattrs[nid]->kobj_attr.attr.name);
> +	kfree(sgrp->nattrs[nid]);
>  }
>  
>  static void sysfs_wi_release(struct kobject *wi_kobj)
>  {
> -	int i;
> -
> -	for (i = 0; i < nr_node_ids; i++)
> -		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> +	int nid;
>  
> -	kfree(node_attrs);
> -	kfree(wi_kobj);
> +	for (nid = 0; nid < nr_node_ids; nid++)
> +		sysfs_wi_node_release(nid);
> +	kfree(sgrp);

This looks broken, are you sure that a kobject with a zero reference can
still host child attributes?

The teardown flow I would expect is:

sysfs_remove_file(node_attrs[i],
kobject_del(wi_kobj)
...that does final kobject_put()...
kfree(container_of(wi_kobj))

However, now I do not think patch1 is actually fixing anything because
there is never a kobject_del() of the mempolicy_kobj. Just like there is
never a kobject_del() of the mm_kobj.

So patch1 seems to potentially be addressing a bug introduced by this
dynamic work which is caused by the original code being confused about
the kobject shutdown path.

The original problems are that sysfs_wi_release() has a kobject_put()
which, yes, is broken, but equally problematic is that there is no
kobject_del() in sight for either of these kobjects(), even with the new
changes. mempolicy_kobj_release() seems to confuse the activities that I
would expect to be near a kobject_del() call with the minimal kfree() on
final put.

>  }
>  
>  static const struct kobj_type wi_ktype = {
> @@ -3458,7 +3461,7 @@ static const struct kobj_type wi_ktype = {
>  	.release = sysfs_wi_release,
>  };
>  
> -static int add_weight_node(int nid, struct kobject *wi_kobj)
> +static int sysfs_wi_node_add(int nid)
>  {
>  	struct iw_node_attr *node_attr;
>  	char *name;
> @@ -3480,57 +3483,44 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
>  	node_attr->kobj_attr.store = node_store;
>  	node_attr->nid = nid;
>  
> -	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
> +	if (sysfs_create_file(&sgrp->wi_kobj, &node_attr->kobj_attr.attr)) {
>  		kfree(node_attr->kobj_attr.attr.name);
>  		kfree(node_attr);
>  		pr_err("failed to add attribute to weighted_interleave\n");
>  		return -ENOMEM;
>  	}
>  
> -	node_attrs[nid] = node_attr;
> +	sgrp->nattrs[nid] = node_attr;
>  	return 0;
>  }
>  
> -static int add_weighted_interleave_group(struct kobject *root_kobj)
> +static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
>  {
> -	struct kobject *wi_kobj;
>  	int nid, err;
>  
> -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> -			     GFP_KERNEL);
> -	if (!node_attrs)
> +	sgrp = kzalloc(sizeof(struct sysfs_wi_group) + 			\
> +		       nr_node_ids * sizeof(struct iw_node_attr *),	\
> +		       GFP_KERNEL);

The recommended way to allocate a struct with a flexible array is using
the struct_size() helper.

    kzalloc(struct_size(sgrp, nattrs, nr_node_ids), GFP_KERNEL)

...but overall I think the original code needs a cleanup and to be clear
that I think there is no memory leak risk exposed to existing users
given the shutdown path is never invoked.
