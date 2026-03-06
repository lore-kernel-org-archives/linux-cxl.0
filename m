Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F42FD1A1
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759256; cv=fail; b=c1n9tKJs10pZIhZDGVQ6mRz5UnZHZgby2EyN/48nJSI7/a1P6qVQE++8TQ3SLWERAJ/aTstsfM+Z9Atk/HRur6f1bJcsUR2EB/UngGcSi/oKSw2p5HFQ2IL0JBnpVUKYOlF8w6HpCiFOHBgHCQkUr9LSFml6tCblBgmaUX5t0/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759256; c=relaxed/simple;
	bh=pAPg94MWd9TQteJ+VRGJBKc8F4/cXeHrqIqPowQUsaY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Io7AA4rpZDFPA335hEp7OSQGqDzdVl+9dczrDCLIJi3ix8ZtJtlfD9051Wnozw/JRZ5G2FnwEtL9Jq9SyLTIQ6cmulhFyFy9g03qee6+47+xLVIY08EwlnrXXG+lapPnLAsyMHHKbiF03cIRqdW4362TzPUrSp9n03QofeMXcbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foD4YK6u; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foD4YK6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772759256; x=1804295256;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=pAPg94MWd9TQteJ+VRGJBKc8F4/cXeHrqIqPowQUsaY=;
  b=foD4YK6upE9mrlKhQuzEXVVi9AjdcBaS5l7AucdLQtXZwVQP2SIKUHaP
   jGBLroKI6yvF7mNzr6MrExhIxCVp0Jg8oOS+Zsdu/YhwDAdLfkaof6HnL
   izOx2QuanVM0gryatBmcmnkiY2CTMNAA87whJ0Ao/aKSv5e/8Gp+zSA/R
   RoWvHyLzbwAiCixHRI6Zc2C0L+U1hqwrBA56mIFjritTJUkKdPSVZI7of
   T3Slqd01CcOz3FjVQwQWGseb8Zp8nRcvVxwbi8nsRd2z98gNiUfgpZ3Th
   BzmVla+MRnb7E1FPONH4Wv5VaxHNi4DHupIYX6FijCI2LZwc2Gj15srhI
   A==;
X-CSE-ConnectionGUID: NlSCcngSQua4C0pzjaWyxg==
X-CSE-MsgGUID: WDAcst9GTIuFtRoZXH1fLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73779646"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73779646"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:07:35 -0800
X-CSE-ConnectionGUID: FFqAX6c3RJ++qTzrLaPqMA==
X-CSE-MsgGUID: 35ndqjetRTOPxG1Cufs1pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="218850608"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:07:35 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 17:07:34 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 17:07:34 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 17:07:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydhp7w3C9RjVcGdVyeFUcn1BRArU+l5MpGyDbvARhY/oMHZYvJw4QW840iU3yHqvZFRyn1rplDpU50g9wZrBRruHG6R95zMdc5dkeD3KwWWqaSU/mHutHLBpi0vDey9d9rh64MoXYTRL2cnO9HePs6cemPlacV8/6rZ8urNQUqUK84Qo/5I2Re0t/LgkSleNIRk6EjRlZhMxcgmP60CmGjxyX612JGF7rvnzVCR8oZUUPj06lDL5/dpyKoAk6CJ/Vb122XIQIMN78sf4T2fn5fZXU1hfAhdiwCqYmAQMmlhR3XkFoUg/TTkjB0lu1cPCDL2u/8oCgjybRKu+bcXeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDy7XvObVjS9dWmdU9zWIdjGTOST7PlZu4sNdRGdIOQ=;
 b=bYAQJwPu/eobFLtiq67AJV11RhGTn2eDhHZSZpisH9NyeuWa3UP9lOafuwMv4COKx3OqBr/u4p/RNqSvBH3T6WHZr6c1KqI+D/sxVJvO0bk7bFdqHHC2Xu6JWdJb6jgkixTzVG//o7hfgdXFlrXaOJmmq2FXTN+blPcySph9jojv8oXezPxf6ue9YIbnixpfZtpjNuBYRAM6JLku3UMdapzpzbF8Wyhf1jDmSDCZDGcmUGexUWhs3foLQLNwVBy5OWS9423hlgvGlm+a+Pp7ZujLFtZiWt/wo7lIYqD4xOZWh2j6nQmEVMon4Vb088ws3N8nrMfMaZzlNgoE/RpF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8048.namprd11.prod.outlook.com (2603:10b6:806:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 01:07:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 01:07:30 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 5 Mar 2026 17:07:28 -0800
To: Keith Busch <kbusch@meta.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <dave.jiang@intel.com>, <gourry@gourry.net>,
	Keith Busch <kbusch@kernel.org>
Message-ID: <69aa28d0d9076_6423c100da@dwillia2-mobl4.notmuch>
In-Reply-To: <20260305204057.1516948-1-kbusch@meta.com>
References: <20260305204057.1516948-1-kbusch@meta.com>
Subject: Re: [PATCH] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate
 mismatch
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b379763-7a0a-4bbc-627c-08de7b1cbda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: lTfov48ZOOjiZD0bkXSl7kixzdG3YEsA2PUBCxNWP9kghtg+X2Z82pllgnM+dXP+MPIyTQOXa37P4xcWrOZUlcYqej5ZiGkpHCgqrtIspt7UhyXGHm2YTQ7QnIqLoamUVwvfS2Drn3J4U4GUwMass1Dus14bA5KOVZQbblQSiCFARjj0vP/hZQr7UIZlKXf8lX8V6OcEzNUjT89twKscrqwQRehSijhoaYf4/kPm3nyToHgrmC34+MBHl1VIqeFeBcjOSEnbfhr4mf1pmT2C2JAHL08tCnnNG/xpKB76AZJpZ2vDQ7y3B21VRkCqnI1k1VEyO+fzkMeIMbZTOQiPKcSpo6R0ZOtPa6je48R6FoQawgR2Speoks94WrAz7V6H4mgRo3qRPktVuWh4ne0a21h5oLZ3Gg6Qen8V0uT8Fyoh+LiyfrE3CMeRCodpanuA1d9/+97svltiObg+KzMQhKGsrhgt9h+b95n3sDQ50pXnjMlOdMf36QMv9EnydQs1D/jDcFQ6BU2hd/HYaEnXpfC996qn/Oi+l+Mr4jH/67EaC+6nXn/haLMzrvPIBiSMorCODoXuXM0rmVlT+zJdaGqlsWYst9arJjU1bIhWW4nID6Y0okAHI3Iq92OR1ctnagEgiK3XdrZNTT3sU2TgGs5EAGG/OlNYvSbobPedZssz79OaoEcZqbltpthZiaZNcBWPJPf4RbFWnW1l533+2WanU5+pHGcTZeRMy85WQkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZQcUN0eWF5UE5WVFlJMHpxQ0IvdTdhRUNCMjNCOUk0TUE0amdzWk9jS2tE?=
 =?utf-8?B?cnVrdkppZ1lxZG1nOThVWW03VGFCM3l6Q05xeFQ2MHdoWGhWdVQ0T1VDdUtF?=
 =?utf-8?B?Z0YzY29Mc2o5cGd3ZVoxTUtpTU9mcE9YTStKVUZVYUNLREdwb2FsQUkyWXNE?=
 =?utf-8?B?VGZvZi9DOTlGanhSMW9OOGhiRi85cGtxUnVObXIzYkdDVkhCdzhEK2xkVExi?=
 =?utf-8?B?SWsvWWs0cHFUK1RudndNczNhWk15VXY3bStlKzhSTkRBUkZpb2ROZ3BXa3pI?=
 =?utf-8?B?SnA4QS81ZUtzbzV2aHg0RUljcExSRS9MOW1BdzFGakllc1NSeEhINWlnVDFv?=
 =?utf-8?B?dzBOZDlpak9BL1BaMmRBYWRPK3QvNzFLZTBOaElQTDk1KzVabXl4dkVSdFRF?=
 =?utf-8?B?TllJMEJwTjZMY3FMK1hFaHpZZnM0Y2NDazlXYXVmQ2I2Zm91Ri9HSlBTNHFQ?=
 =?utf-8?B?cERLem1wcnFyOXp2Wm56Z2lHd0lraEh1VEhBQlN0bXovampFM1FNM0hLcGg0?=
 =?utf-8?B?OGFXRWtrb1RQdjFQbklGRGFqeUVSSEtuMStHZkZCaFdyaHYrWVpUd1ZEcVY3?=
 =?utf-8?B?UGRvUmpiNTgxbnplbjJ3Z1JHVUI2MDRBWDUyVFF5aGZicWhCa091MGhSMHVP?=
 =?utf-8?B?ZXF3N2RRczIwNTRwRlpBemRPcy9Rd0pYZVRSeG9rYXhvdllkNFJONS9ydkJR?=
 =?utf-8?B?SFNjeU1mT0orWHBaci9hUStjN0hra0NwZmg2cloyT1QxYUJqckpEWWFvcE0y?=
 =?utf-8?B?cnY1NTlKMGJQdlBPdnZiUVM1SnZJQUJSMTVRU083clRTZjB2d2Nqem5mekRH?=
 =?utf-8?B?aXVsQitIYnR5T0RUYUZySTFOaHpiTEI1dGVpZTRsWXo3NUxZV3JhcVdSRFhM?=
 =?utf-8?B?Q3lBSUxxK0trSWw1YWRaNnFwRFpDdVVRTkNQeUJ4L0pYMGcxNHhlUXZBMldv?=
 =?utf-8?B?K0NYQ2JVOEJRUzdNYTFuTUJ5dFM0VzlPdGN2c3czbzU4c0kyM09vVkNvc1RB?=
 =?utf-8?B?R085YS81ZVlqd1hzNmFHWmdTbDJNay8vMXIrQm5Sa2dlK2FOZzJUTmlNQmgy?=
 =?utf-8?B?ckNVSXkyaEUzVW04THFLc1RZb3hObmdCQVJjbkxydVY2b3NYMkdJeUx0Q0lz?=
 =?utf-8?B?K2xuZGw5MlBPTUp6bzZQbnFTRUVxMHVhYWg2c0NZSUhodDFjS2dEOU9WUC8y?=
 =?utf-8?B?bDlQd09qcnhscVJDaFg0U2JsTHBvWmtrOGRweEFOSTNXMzhQZlhGb3YxbU5v?=
 =?utf-8?B?OEdwL0krQk9FdjFQcVJHejg1Zmk5cUhDbW9UV2kwTXRVRUw0bVgrd1RwQ1pK?=
 =?utf-8?B?bnk0NkFrcW85NnJXK3pwTHhzSG02dWRyVVQwcDlMYmNCUUJDcDN1czdNcXpK?=
 =?utf-8?B?VlByQllXbm9URHArdmxkVHBpOE12QjFtZ2FwR2RpdVB5YmhZMU12NEl2OVow?=
 =?utf-8?B?MENWNEF4ZW1nczJXbTFWTEQrYy80WXQyVkJucGhoNFhjKzE1TkQxVDJITWFa?=
 =?utf-8?B?YUEvUjFtOHpZUFREUkpld2RQczFBclN2M2tiU2FzRDJxTExURFFlandBRVBs?=
 =?utf-8?B?b0p1MjUxZ2N1aEFFUy8zQ043czVPKzU2WEs2RDZ4SzhCSlFTa1dPcExiL0Rr?=
 =?utf-8?B?RXRnUlJHU1JzMGtRM3dmcnZYYzE0c0c3S0E2UGFVaEpQTE9vZjdRNGFtQnRm?=
 =?utf-8?B?bUp3ZFRzdlZ3UXNDOFRNd1hlb2R1MUFCRlZvcHp4TG5EdVZLQloxSjBuSnJE?=
 =?utf-8?B?eFhubFFkbml1c1JyQmhCcXphL0VHSnR2QmhxWG9hK1lLZ2pEMWNLRVEvTk5J?=
 =?utf-8?B?TFRTejgrR3lhL1VHM05HY0QrclIwR1BXYThMOG9yRVRIVU1lR2dPdS9sZTJH?=
 =?utf-8?B?dVpmeU53TllVR1BHUGRVZWxPYXVmZk1SMGRjMDZNTHA2ME1sOTBIYXhZa0tH?=
 =?utf-8?B?OG1HMVVFOGc4cnp3Ynp3OWF6WnRBY3YzbFp1WTdLdVp2N2tVNXp2T01vUXA3?=
 =?utf-8?B?VFVqTVVjd1RoOXR1bGJRUnFiKzFYMDFTTlZnTDFxYjFvQU5VVWsya0l2Mkdu?=
 =?utf-8?B?eXdHbTZYcHl6Z292Y3ovSXpaTi9hMXFjdUpsNFdHS1FsSFlEaXdGSVQyV0Ft?=
 =?utf-8?B?c3dHT0dacHpIbytQUlpBNC9mdllqb0JuMFNzTk9jSkNjWjlrcW5VQjdlemlM?=
 =?utf-8?B?Syt1czNjMW9RS0dJVmdNVkMvQXJDZFFyR2x3QjV0UzlLOVJJdmNFRjVZeHkx?=
 =?utf-8?B?M2RZWUlFekcwZ2VOQUtHNFhrbi9aUkMyWXJ3MWgvbUZ6R2YzbUF3d1N0Q05N?=
 =?utf-8?B?dG9nMTZlQnNuZ2NJdlBHV20wUEFYaVl4VFozYzBwc1JZL0UzeTROUzZiZWdP?=
 =?utf-8?Q?0Cy6t7ZK/lprQ+HY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b379763-7a0a-4bbc-627c-08de7b1cbda6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 01:07:30.6327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVatMkbQ8QHaQJVK189HWGjQEJwAyH6U+sbmxRTd+QQIVLyBHO3C00EeMuU32W9FYzm/iOgEVs3jvg1bs2YdT0BN3AY6mtDg8SVeipjw5rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8048
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Commit e7e222ad73d9 moves devm_cxl_add_nvdimm_bridge() into the cxl_pmem
> file, which has independent config compile options for built-in or
> module. The call from cxl_acpi_probe() is guarded by
> IS_ENABLED(CONFIG_CXL_PMEM), which evaluates to true for both =y and =m.
> 
> When CONFIG_CXL_PMEM=m, a built-in cxl_acpi attempts to reference a
> symbol exported by a module, which fails to link. CXL_PMEM cannot simply
> be promoted to =y in this configuration because it depends on LIBNVDIMM,
> which may itself be =m.
> 
> Add a Kconfig dependency to prevent CXL_ACPI from being built-in when
> CXL_PMEM is a module. This contrains CXL_ACPI to =m when CXL_PMEM=m,
> while still allowing CXL_ACPI to be freely configured when CXL_PMEM is
> either built-in or disabled.
> 
> Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/cxl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 4589bf11d3fe0..80aeb0d556bd7 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -59,6 +59,7 @@ config CXL_ACPI
>  	tristate "CXL ACPI: Platform Support"
>  	depends on ACPI
>  	depends on ACPI_NUMA
> +	depends on CXL_PMEM || !CXL_PMEM

So I do not think this is sufficient because there is no
devm_cxl_add_nvdimm_bridge() stub in the CONFIG_CXL_PMEM=n case, right?

I came up with this. I do not like that it puts ifdefs in the code, but
then again I do not think add_root_nvdimm_bridge() is big enough to
deserve its own C file.

-- 8< --
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 4589bf11d3fe..277877da8263 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -75,6 +75,11 @@ config CXL_ACPI
 
 	  If unsure say 'm'.
 
+config CXL_ACPI_PMEM
+	def_bool y
+	depends on CXL_ACPI
+	depends on CXL_PMEM >= CXL_ACPI
+
 config CXL_PMEM
 	tristate "CXL PMEM: Persistent Memory Support"
 	depends on LIBNVDIMM
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 127537628817..a42ad5035958 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -741,6 +741,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	return 0;
 }
 
+#ifdef CONFIG_CXL_ACPI_PMEM
 static int add_root_nvdimm_bridge(struct device *match, void *data)
 {
 	struct cxl_decoder *cxld;
@@ -765,6 +766,18 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
 	return 1;
 }
 
+static int setup_pmem(struct cxl_port *root_port)
+{
+	return device_for_each_child(&root_port->dev, root_port,
+				     add_root_nvdimm_bridge);
+}
+#else
+static int setup_pmem(struct cxl_port *root_port)
+{
+	return 0;
+}
+#endif
+
 static struct lock_class_key cxl_root_key;
 
 static void cxl_acpi_lock_reset_class(void *dev)
@@ -952,9 +965,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return rc;
 
-	if (IS_ENABLED(CONFIG_CXL_PMEM))
-		rc = device_for_each_child(&root_port->dev, root_port,
-					   add_root_nvdimm_bridge);
+	rc = setup_pmem(root_port);
 	if (rc < 0)
 		return rc;
 
