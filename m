Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF50415F22;
	Fri,  4 Sep 2026 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499429; cv=fail; b=Es3VeezDfKZMW4S7AgI1XwH8EW0uhxbNoWg7nl3iOQOkoYnRA3RXPp3syDAoV1+Oiy5iWef60oJpkddz88aI//x75ODVC0p6BWj+9On25Tkq/Z1OPg0yufVnqdAwRoIAlVgOQL8pj6/FAnljls6H+euVd8mDstnKrvrCe/+AirA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499429; c=relaxed/simple;
	bh=vbdyAsifQTA4SmelIiHpelg1U1xT+f++L9ZKok1d3eg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pT5Guzz0de2on8jcCKWFtBwFV2wrIKBshpng137MipP/PIBl1J59Bx9M1KhNpWJ70HQiuh6RTE1XHH/mhTKUoGYZmFF96F1x64WBr+J6Jhn/Xb1VDcRUYsjSJDo41OnHcT6qnhCKyiLYzDNhoPEnHWuD6EXxMb5/viHiKtghNWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baJvnHA0; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baJvnHA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788499427; x=1820035427;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vbdyAsifQTA4SmelIiHpelg1U1xT+f++L9ZKok1d3eg=;
  b=baJvnHA0wKtdlWHkfaM6gmzMozSlBtF4Y4NzRY2FZDfhO2eA1oMyRbge
   BcTUOF/lzfb0gODQWtGcv60+CUQDJjf1yE2fzk0iM0jSHFynvKOl4ZAtN
   OCQdcf8rGSQOV3iTM2mciC6j15nIUIysQ4QjNxQmhprON3dqbwci5txGE
   DCMyNAqmgO53l+btHZalajRL9gP1VOy61oCFmrMnvQSaljx6bkqGqAwsE
   QnRsrc/Mp7v+eJYjLKUF5+A73ygRLgyXGI9BQ4v2ss3pWpXf+t51cALkw
   A+guF7aC4EKRNf9ntxl02MOQP3ScXkfUmAOST/56UHzkIYsoAlVLOX4IW
   g==;
X-CSE-ConnectionGUID: OIi9IsGjQ5KRQZ7Tntas2w==
X-CSE-MsgGUID: +X5fmc8cRfSdOWuh+kcFfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92815050"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92815050"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:23:47 -0700
X-CSE-ConnectionGUID: c/jRpiYCScWFwUnemCkBNA==
X-CSE-MsgGUID: 0X9ddJtFRQ+UZSKcbu932A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268199692"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:23:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:23:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 22:23:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.68)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:23:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JySBWCXTzX9alLhUd80s2VBCBImLv68PZNtyHg7F5Y2yNf3q/e56aGsI19ECb2MCHfDRUo3w3eff6d2GKowkUy+kL21e9Wvu+JV+78uUB0Uszf93xfhlLOVwtP5FA/HyYiUV4LUeyjZgl2UJhY4bhde/nAYW9JpqS4QDKZZZMFvlmPp09gr02pjg9nldi0REPFJgYKiL030jIbA88mfrnFp8U3vxV4ETnYfSirX7oa1qnjAjNuMfsiUG8ezqU+8ZnoK87oMMlFdw8YuMuBoRMhvie3oGSARCuKMRmCkY2yKhYiQXgXOVdBCqV7PC8bKXIicOdZzBqcXERVk/XOpi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSDjz2AEnFvh04Vl+jWtTI2Kn4XKjRtvKXZkcdO3RPU=;
 b=rwstpp5HHEQESLxghn4JuUVVNWZ+ssmN2rBsq8V6CfEXYzqv/pqiVQbxlmCm9/XszHrePKcvO/XrRf1/51fZXltRWUszgALv8elATX+TeuOQ+hpil6T+RqI70AUc/syn0DEqWYwflYaJlzRKMYHCKYzUHO+D186q4X2Whe5L8T3xmdmNFbvGhLt9IKPDrSJa0MXP+sm5anBMXohho9mZtDpNRwh3CaoN+kdtnAuDTc/VHv8MqWacqIKNX9ciYuk0QA856iyZg3aJrGy9AAFnZ1ItrMHN8AUA3aPGttuabR7uFMFAFSM4A4lnz4PiI8bmgfrlxn20Qcv3v3AdG/8Llw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB529852.namprd11.prod.outlook.com (2603:10b6:806:51a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 05:23:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 05:23:39 +0000
Date: Thu, 3 Sep 2026 22:23:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<gourry@gourry.net>, <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v7 1/7] cxl/features: Reject feature offset that
 overflows 16-bit field
Message-ID: <appV1-1gwX0pBRiJ@aschofie-mobl2.lan>
References: <20260902053839.25595-1-icheng@nvidia.com>
 <20260902053839.25595-2-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902053839.25595-2-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB529852:EE_
X-MS-Office365-Filtering-Correlation-Id: afc5d1fd-db33-445a-c7ef-08df0a44ad3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VE7Ja7uIdxVz8dL8QsLQLOtD/BMQO07M6eGIQW7OrQ1xOlM4+Wev4SlVR04SaFlA5oWJhAob/OLZrs23tu+tZDkTwpGh/22Q++SbArW9wDT702+4QTJmf+a0D+PhpKnZe6vPrhSIAQkqvrrhSWyF+eTe3B9PjifF/jvMaGhOMAsUoD5N5plQvcrkEaDipqUkfx7VpO6Di47BEh6BGpl8+cKMg9qaPwAtdQdQCiElQqo9mllmUZZz/O1SNPvJ8XIWcISY8oPKWwyUVyMBVS1tAj2vg5JHAG3AvRQrTKdBGgpYufhB3V0YwXsOc90WD4YDYDsbJLOPO6SzNMj1NEya7ejokwB+WBFeuT86aj7IDlBX+p9haE/p0/lx7DrK1IdqR0iveeRMf8kVF+wZcRUJvHq60o+e83wUoaQFNi204Pjl6uSz0zbuEHhcTb32rdNc8oQdBzt90sVBTMAK/V9q5gkiSYFqYt+BT0ohPLITAGwIUDQXoT9MosfB1ks+0tLr0qYjgCEqWfgNO07Th10MN4sAxn6Ew3UsfZ0a5+88JKIY5khBwLcM1I7T6cCt0dgYU+I9IVH41PsdkOK+coBLD1MD2jSin/yr8WJpJRnT7GsWCxppZMLz4A+PHQodL9Zwc0LaVJx1v3csqBXNbfHywLGHqqmmcrmC/C1q6Z1BICg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2AdoRPb8lGh4VswwAqRY1KRQZRbSWWxod4ncGboCXVXxYO8YvoxBq42QakaR?=
 =?us-ascii?Q?3Fe2hpf8DhhI/hXmiYBCd/cOqxC+RENrAwxrm51MuJA1bWV903lKOFXzk2Iz?=
 =?us-ascii?Q?GIxeNJfKJhsbiykk5ov/Vq+E+Nc5Z8mZzklCrIK7A9F2jpoENcEuRthu6I87?=
 =?us-ascii?Q?OXzhSzU/VVew1QBA4JC0/5Zs/enKgeTONxUhvJm7JQj7IF4v0gG2B3JKnBr0?=
 =?us-ascii?Q?yAKSRl/THmzWC1PBlptRMGRou01YVN6GNYE6seRAewFOcduw0XgrVswq82hT?=
 =?us-ascii?Q?hyobwYhJ4sUeU4EWbKpH0b69AfPLbDtZluRWQJjYFf2qxNfrNxgPy46KCpO/?=
 =?us-ascii?Q?zgezTO6FgBjPL/gHZz7jDWUYNVWN5gPBth7jM2/mvoqfuvYOhyLpT76RG5cX?=
 =?us-ascii?Q?nggzPFEEudSwkS0pQ0e31VV3t8+c5w1HPOknSM4z25x25rO7kiql8hqhMrJR?=
 =?us-ascii?Q?GHNykVnD8xGq5MAAAMfmMi26kR6j7lR7kwNuL352Jc6cGWA9Tnetmi1nkk3R?=
 =?us-ascii?Q?einkoYhpXptkPZMmpwaW/WbQBetqgd1cK59M4vg3zRsF1FSNfQkmbTIAGuJL?=
 =?us-ascii?Q?WJu8zIkLqidTDK1ovwLpBbs0nAS0s6oigc3+dXS0DITsS6Plv3LmyztmBePF?=
 =?us-ascii?Q?GFp+Q8jbOun2KxGRVz8chlOHw5kOurbUc4zPzU+G47Dt5S45DNbatRkHcXlc?=
 =?us-ascii?Q?IJt4mvkcLUSNeb01UEk+ToFxioQ8kJjH5H6PCMZrIgm2Vi1z/NaUlaAz1khe?=
 =?us-ascii?Q?vykEI7AkHKCsvEYcCAJt2CfqM/6ExvyV/Z3z7XkO9DsYaNhwtiDuujAi5hae?=
 =?us-ascii?Q?cxDez6HgeXFilj7OGGPQcPztfuZXTe2yHDSSHp1i/dWYrIjGcn/3uT+1etMq?=
 =?us-ascii?Q?zdefqkQSvg1KxykIxzZE2f7IxK4w7jfOmwmgONJ9EGD1vaqO0fC+9U5RnDmG?=
 =?us-ascii?Q?i743r7fhieOG+PHeop7xNU7+ym0jDOvr6x/Qzbyo9qCcFw4uYhwDaE8+Nyhr?=
 =?us-ascii?Q?0r468FxotXERagArQNLlfcnSK5Y/BbO+8HOQt9sdCqW4nEI/wXkYwRSoK638?=
 =?us-ascii?Q?lPTHjjxQPeNHgg2Df6dHsliT5rinTRHXVChgyrqdv9+ElKPeleVz0PH9+Z7X?=
 =?us-ascii?Q?7Qyr7v5A6uqDG1alrr1Ye/6tri7MPAiEu358aF7jn81/NYEpWESVl1yd9Fuc?=
 =?us-ascii?Q?J6Trl1OakVA0/74GueRQiqPODQSIdgzxtYE9XkNVssHfn5exPEigUnW9At4k?=
 =?us-ascii?Q?991fIUHTfrniM9qyPvFh2K86B6Gwr0TVoS/b/AnS7MmgFhjpk+i0czUWNwcx?=
 =?us-ascii?Q?Mzp1I08wnNEtIvI0+WxoCpLlaJfQ4rOm5aLfMNDjcRESyQoWlVq6vHtJ2NKU?=
 =?us-ascii?Q?iNDS9Nv83NwLafn0Ys/NDMEfGxg0HL5FIfl8BcQnvWlR0XmV+Vm3h+hJAdI+?=
 =?us-ascii?Q?022mZ8/FmrIq4oHwxyJpMmBN/9TWnMyIvOQDg4m9kxMP2wRQqa3W2xP3Js+W?=
 =?us-ascii?Q?yrc2391hPLle/zrkUGT/DpA7WheOKIS1K7/QkAtGgu/2wuR3XuaGnIWJ4u4p?=
 =?us-ascii?Q?AluvN8USadmSvwSG6RMpCeRCZFNRNm/OBIdG2x+XXybRDbrMYGyzaIgpMiwG?=
 =?us-ascii?Q?mPUIRaC4joUaB2ANX/Dm4X21VLfp+FSLwV5ijXhqgf9c1cRfzNnf0E/hluuc?=
 =?us-ascii?Q?1Itom3v9GjGZz1rvP3U8gj3EmxOvFi/Ipjk9ML0qiIhHHg9k4CEjBp0xtXjZ?=
 =?us-ascii?Q?uCwvouzbLJlN8PivKdZDf29fxMW/zO0=3D?=
X-Exchange-RoutingPolicyChecked: vJa3vHgoPyPcYTRu7G2a6YRdUfgAVqgewvhEMt33zGKoJVEzTMT4msUIor5myWopqZKSZZkItDLNdnN5oGfj0yUyyF/jSKxuh7q8UISA3ECjwS8aBNabZw1I4IX82cjQnJfVNpRnA4Onv04g03TM/JxtlFHw6/hX5ywzo5+ySqv1mWO/SnC+cnJJJh6Ib4hF05pmfFKT4XgcOorW3t4UzCXhrOkjISi5SOFVL27avPR/1nthGfLiGhXnksMqkeQm9B0fRBhPC3XBRyT3G1HZwMbipWa05V/dwX7amVLJEQw46OngLWpERBNw1/Hte5+ydVdq8kw4kjt+bso2+ZVAYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: afc5d1fd-db33-445a-c7ef-08df0a44ad3f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:23:39.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbA1WIqZhgbe/+AQxzIALMetiwYG2hlAKEPm4uaQRCyuvIDqtM0LPnafEvTLPQEowsNxvnagySPXDyfMi4p03vrz9QYc0AyRIV0ujLL2UuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB529852
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 01:38:33PM +0800, Richard Cheng wrote:
> cxl_get_feature() and cxl_set_feature() build each mailbox command's
> offset from the starting offset plus the amount of data already
> transferred, then store it in a 16-bit field. A user-controlled fwctl
> offset and transfer size can exceed the feature extent, allowing a later
> offset to be truncated by cpu_to_le16() and target the wrong feature
> data.
> 
> Reject requests whose transfer size exceeds the remaining 16-bit feature
> range. Express the check as "size > U16_MAX - offset" so the validation
> itself cannot wrap on 32-bit systems.
> 
> Change cxl_get_feature() to return ssize_t so invalid input and mailbox
> failures are reported as negative errno rather than being conflated with
> a zero-byte result. Update the EDAC callers to handle negative results.
> Keep fwctl behavior unchanged by translating helper failures to the same
> header-only RPC response carrying the CXL mailbox return code.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
> Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/core.h     |  8 ++++----
>  drivers/cxl/core/edac.c     | 20 +++++++++++++++-----
>  drivers/cxl/core/features.c | 28 ++++++++++++++++++----------
>  3 files changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..bb380ec6daeb 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -217,10 +217,10 @@ int cxl_port_get_possible_dports(struct cxl_port *port);
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
>  cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
> -size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> -		       enum cxl_get_feat_selection selection,
> -		       void *feat_out, size_t feat_out_size, u16 offset,
> -		       u16 *return_code);
> +ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> +			enum cxl_get_feat_selection selection,
> +			void *feat_out, size_t feat_out_size, u16 offset,
> +			u16 *return_code);
>  int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u8 feat_version, const void *feat_data,
>  		    size_t feat_data_size, u32 feat_flag, u16 offset,
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index b321971fef58..f1df4b5cfe5b 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -78,7 +78,7 @@ static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
>  				    u16 *cycle, u8 *flags, u8 *min_cycle)
>  {
>  	size_t rd_data_size = sizeof(struct cxl_scrub_rd_attrbs);
> -	size_t data_size;
> +	ssize_t data_size;
>  	struct cxl_scrub_rd_attrbs *rd_attrbs __free(kfree) =
>  		kzalloc(rd_data_size, GFP_KERNEL);
>  	if (!rd_attrbs)
> @@ -87,6 +87,8 @@ static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
>  	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
>  				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
>  				    rd_data_size, 0, NULL);
> +	if (data_size < 0)
> +		return data_size;
>  	if (!data_size)
>  		return -EIO;
>  
> @@ -551,7 +553,7 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev,
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_ecs_fru_rd_attrbs *fru_rd_attrbs;
>  	size_t rd_data_size;
> -	size_t data_size;
> +	ssize_t data_size;
>  
>  	rd_data_size = cxl_ecs_ctx->get_feat_size;
>  
> @@ -563,6 +565,8 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev,
>  	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
>  				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
>  				    rd_data_size, 0, NULL);
> +	if (data_size < 0)
> +		return data_size;
>  	if (!data_size)
>  		return -EIO;
>  
> @@ -583,7 +587,7 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
>  	struct cxl_ecs_fru_wr_attrbs *fru_wr_attrbs;
>  	size_t rd_data_size, wr_data_size;
>  	u16 num_media_frus, count;
> -	size_t data_size;
> +	ssize_t data_size;
>  
>  	num_media_frus = cxl_ecs_ctx->num_media_frus;
>  	rd_data_size = cxl_ecs_ctx->get_feat_size;
> @@ -596,6 +600,8 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
>  	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
>  				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
>  				    rd_data_size, 0, NULL);
> +	if (data_size < 0)
> +		return data_size;
>  	if (!data_size)
>  		return -EIO;
>  
> @@ -1264,7 +1270,7 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
>  	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	u16 restriction_flags;
> -	size_t data_size;
> +	ssize_t data_size;
>  	u16 return_code;
>  	struct cxl_memdev_sparing_rd_attrbs *rd_attrbs __free(kfree) =
>  		kzalloc(rd_data_size, GFP_KERNEL);
> @@ -1274,6 +1280,8 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
>  	data_size = cxl_get_feature(cxl_mbox, &cxl_sparing_ctx->repair_uuid,
>  				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
>  				    rd_data_size, 0, &return_code);
> +	if (data_size < 0)
> +		return data_size;
>  	if (!data_size)
>  		return -EIO;
>  
> @@ -1750,7 +1758,7 @@ static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
>  	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	u16 restriction_flags;
> -	size_t data_size;
> +	ssize_t data_size;
>  	u16 return_code;
>  
>  	struct cxl_memdev_ppr_rd_attrbs *rd_attrbs __free(kfree) =
> @@ -1761,6 +1769,8 @@ static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
>  	data_size = cxl_get_feature(cxl_mbox, &cxl_ppr_ctx->repair_uuid,
>  				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
>  				    rd_data_size, 0, &return_code);
> +	if (data_size < 0)
> +		return data_size;
>  	if (!data_size)
>  		return -EIO;
>  
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index ba6d2a5acb74..8d44ce829497 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -220,10 +220,10 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features, "CXL");
>  
> -size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> -		       enum cxl_get_feat_selection selection,
> -		       void *feat_out, size_t feat_out_size, u16 offset,
> -		       u16 *return_code)
> +ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> +			enum cxl_get_feat_selection selection,
> +			void *feat_out, size_t feat_out_size, u16 offset,
> +			u16 *return_code)
>  {
>  	size_t data_to_rd_size;
>  	struct cxl_mbox_get_feat_in pi;
> @@ -235,7 +235,10 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		*return_code = CXL_MBOX_CMD_RC_INPUT;
>  
>  	if (!feat_out || !feat_out_size)
> -		return 0;
> +		return -EINVAL;
> +
> +	if (feat_out_size > U16_MAX - offset)
> +		return -EINVAL;
>  
>  	uuid_copy(&pi.uuid, feat_uuid);
>  	pi.selection = selection;
> @@ -259,7 +262,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		if (rc < 0 || !mbox_cmd.size_out) {
>  			if (return_code)
>  				*return_code = mbox_cmd.return_code;
> -			return 0;
> +			return rc < 0 ? rc : -EIO;
>  		}
>  		data_rcvd_size += mbox_cmd.size_out;
>  	} while (data_rcvd_size < feat_out_size);
> @@ -288,6 +291,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	if (return_code)
>  		*return_code = CXL_MBOX_CMD_RC_INPUT;
>  
> +	if (feat_data_size > U16_MAX - offset)
> +		return -EINVAL;
> +
>  	struct cxl_mbox_set_feat_in *pi __free(kfree) =
>  			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
>  	if (!pi)
> @@ -462,6 +468,7 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>  	const struct cxl_mbox_get_feat_in *feat_in;
>  	u16 offset, count, return_code;
>  	size_t out_size = *out_len;
> +	ssize_t data_size;
>  
>  	if (rpc_in->op_size != sizeof(*feat_in))
>  		return ERR_PTR(-EINVAL);
> @@ -482,16 +489,17 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>  	if (!rpc_out)
>  		return ERR_PTR(-ENOMEM);
>  
> -	out_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
> -				   feat_in->selection, rpc_out->payload,
> -				   count, offset, &return_code);
> +	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
> +				    feat_in->selection, rpc_out->payload,
> +				    count, offset, &return_code);
>  	*out_len = sizeof(struct fwctl_rpc_cxl_out);
> -	if (!out_size) {
> +	if (data_size <= 0) {
>  		rpc_out->size = 0;
>  		rpc_out->retval = return_code;
>  		return no_free_ptr(rpc_out);
>  	}
>  
> +	out_size = data_size;
>  	rpc_out->size = out_size;
>  	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
>  	*out_len += out_size;
> -- 
> 2.53.0
> 
