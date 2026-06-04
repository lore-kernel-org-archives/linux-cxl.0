Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B6492508
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591629; cv=fail; b=q0f2mKvU9FQAmi+rxkDS9cRsU3KZdR/yeKx332vdxqGFvHM8Pox4/jAmrbvFEaemBGijIr3tDCO6Do2HjDffk7quJpN2JdxR8Kv8EHTLS91X7P94/0Bya6kWUyNLahVsV7PpwJQYvbt3pS9R45HNLgIqoSP5gMVJKd/HMnARgrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591629; c=relaxed/simple;
	bh=UOH7IPR6F03X6Rz6XcLQ13Hsx3i5lOP+TAnyCAuDHZY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UvIDtNOFyopMfCeyuHMZwU23APrHo4YhVof4GIgiyCrMf0ztBl0Fkdh/zJ129BqLM4/v+l+Ii48aKCNRTf9Kb32qaqbE31VTBJZeBAr3d3hFl0sIWyGIaOdU6jLHsJdg3YLoenWZUWDT3cuE2cemXuAxwZyzofA8EA9Cp6gj0oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TS4RwX0N; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TS4RwX0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780591628; x=1812127628;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UOH7IPR6F03X6Rz6XcLQ13Hsx3i5lOP+TAnyCAuDHZY=;
  b=TS4RwX0NG2f7Dtuy5An+LvLPftVbpfQMAAJ+f84aWIAekjdXLKd6vgi6
   M2FEWyp66TYOPr9rqPH4u3DnzYPYZ8r2/m/9JMuZndmI4sI2HlN2A0ewn
   N1G6nxIo0yRDLzqRdAEvWEw7AT9+1fZUb+g57Gkshh9g4CJnxH1kL4zA3
   HTt+J0hVGSUubQQsaApMJcSLZhfZ+JaRGt924g03G6wNPVRe0gtFr0J0u
   m1b17tXzl3l8E7Qym8FeHYIedunciPeR+EW7Ma8488vbnmodxwuTAeunv
   EOE8SBfp/2XH7paxYwhP1m0ZWZeN05prBBDkyxj+g1FOtyNbEP2+US4GY
   g==;
X-CSE-ConnectionGUID: cH1GocmYQ/yl2V/PvC1XXQ==
X-CSE-MsgGUID: 4OdO/QGrT8OWC0oOIO4haw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85313738"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="85313738"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 09:47:07 -0700
X-CSE-ConnectionGUID: oxEFdN2iTOCAuwJIPVE61Q==
X-CSE-MsgGUID: ftyO66UdShS+3x/9R4c5sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="242108164"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 09:47:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 09:47:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 09:47:06 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 09:47:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAY1dAePXGzg8zPpy34qJF/1UuQR0Da6UAjAGaA6oF4Wq3TR0GQF7jMM8teWyR3hRxrYBdjmyXaIhQPhBUThG1TLYM/88qYLYn8sikVBCecRLIEOX7AjkpB4XTt5Q1oVayDV2g+siLKHKSj4RJJ278HknHf54g6612uGxI6SNAWBd5Skhf88trOOAhs+HWYb+C29S8UG5W3XsfTeZuAETD3bNa6oHcfOImo2/l3fuKcm0QDkSTEnT3KE5VahV91cjxGYDFF+84o/p3NtbmlfWgUlqrlLw3dcav8EyxVwDLIUud4cMC5rGzK/6knPVgePGTq01A+l4rKXow1DqfM7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJAW4pp3gVF92mInElza+qscoDSDvQ5/PJl7bVgoNDw=;
 b=R3hdmrhAhAKBEuH4xGtL0AjduRthV5HFUUUtsrmDrt2QXB0Pze/nC0ZkIjrYDMfFKKyMgTwH2D5cNCkYEyAgI+Sy47GSJn7ZphcvVl2LMnxaB9iwEsGi0/xTP1d9oVpQJ6H115SJ2IRRdaXwOSxkALQphYcI6ytjTPr9zwxiSGiHGGZwApmQpEAJ57S7h8W6Jj2hey8ht1oj4Rgstax4zgNYfT8T8eAnsLCpBO65CpmFcID75PYSPKNGInss+eRrB6XcZg3rtrEgpuZE+Fv1bJsJM5F1WJ5yPeID8O2Zrm7au8Vd/lV81kO0BnmNu3ZS061qD7kiAQcaBrh9t9D7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB6685.namprd11.prod.outlook.com (2603:10b6:806:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 16:46:56 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 16:46:56 +0000
Date: Thu, 4 Jun 2026 09:46:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<djbw@kernel.org>
Subject: Re: [PATCH 2/2] cxl/pci: Convert PCIBIOS errors to errno on DVSEC
 config accesses
Message-ID: <aiGr-cKexKQkwfBD@aschofie-mobl2.lan>
References: <20260603185752.4149725-1-dave.jiang@intel.com>
 <20260603185752.4149725-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603185752.4149725-3-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 495e3724-a49e-43bd-71d6-08dec258e356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|5023799004|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lEMfEn2BXy2ZjHuoVtrdBn36azfwJyajQk3M3W00mvyE2Wrqsa30MnhvMOF9FUw9+ucIOiiyPLLMIzYwOw5701X21mNLYEXck5cL5gbzGDJnCkiyX/y+GWbKekOASpf7MkoQ2Ionp5QOPfWOWlFisMiGXEJ27cyngmgBo7VhCo7lBLJHTcHlt7UzuRpXqIq3iccZG32a4Y7sjwJk9wAKpHxrVotRxLM7k3rQfSKvG9jzvbYsL1u1s4uHXG7dnrRiU60YSNB1GXJIW7yLtBpEXBrviICO74NDRLUMm3KETllSLMeRMJ80rV4kVlxnofnCZs2W8jHLD0Omy4ejqVmhjv8SPSrATTx79ttADaci/+a8D2IfhcnJ6/6QMnrKmJXxAusjU6VngMda91Qk+qzVkFjvYUN60vLlOahQefsSoReONty3ahga1+AuIixf1GaqmQrYUZZDDiETXFppes7a3YOqVJE/4QGdrLbTLdAGHRDTh8k0fmUT5vhgiHukPuj7Xji7bxPucAPj+OhqB1Bb5alKVmd2HVV+LSXCy0vT1k6oO43GKqUxAm/ElPLPBAl3enL5VGuXmQ9TdQm3Pfm/I+WwpWl7f9A1aqdKDymwagyA+OSNRnVQUd9i9QCYh8+8hkUbhpj0QLarlPXbyy8tvu7cCN74eXfOlkDZJMDaDPfTJmHbNIsZgiRFWL4jTfzE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ALDPBCNimhNIIm483C+8Xj+Jv8ZwJuboM384w2iVmeDw5m10hyUoVbcNlMs?=
 =?us-ascii?Q?7mxkPuLm5vLtCYEIs7uc643/XgnUGLaMJNxKhA1RzdtzjrZGJ5n1cHk4vXwg?=
 =?us-ascii?Q?/6F2AgcepbSbg4SewfVZ7fa3cpoCXfqwAlvtP1imNZcAq7WTcUOKdEDFF2qS?=
 =?us-ascii?Q?U0s0dnWDzWmhdyvpG8eYk91r2RB9nTSsskR83BZ/M2HOF9BALHD1W6wHuijF?=
 =?us-ascii?Q?P03yatMg4KHvyjzObKz48ey7NSLIZaeIrjQbhzQcm94EReJuHnLp/ecbnCsi?=
 =?us-ascii?Q?NWZVFvvn5jfM6ShrALclg9k0DVqmFtEXg149RC04uSxm9hWJZrmTQhywl0x4?=
 =?us-ascii?Q?HWNb0hRpNZVKmL37TQ/hJ8QYowyPH+RFePEpomN5gHSrMpdvFiVto5krTpzv?=
 =?us-ascii?Q?+31uIajlU/mKMLn56K9dbjLc3GVW4R0D5lITq4+7Zv1TSahdNEELhPgHb4Ro?=
 =?us-ascii?Q?+J0wqoD3eF2MeTzeWQ3JJgptDBeTbNYf9qE0dKQJA/hXcvcTUBTV2mUcr38N?=
 =?us-ascii?Q?Zexz42csHA1KIjGCb67IfV5kRPRC7KmxeoUP6SFH87pVQcoxRdRldhno4ahl?=
 =?us-ascii?Q?EQeBLURyHMu6SWIpLkw0fQBFyPFwgZTgF6uYEZHWowaUTiUgrm8JcFmHMTyX?=
 =?us-ascii?Q?nQT1iafuJgoX0joWKyCmxBnS5w8wj6sgAfHLL4/CDhyYFpqaDtYWkMO4LIkA?=
 =?us-ascii?Q?/uVncd8XsEL4RCDQRcMMK7uVj5NEIgAKwyVefi4eftrrGe68mZjJy8Ml9+hc?=
 =?us-ascii?Q?j0/HxHQ/h3hhdTAtG9wjWdLc4azwk/JN64+idRZVYg3l8T/pzLqpjPwfvc5m?=
 =?us-ascii?Q?4/gk9hSKYYG/taWl1dEXUQEgZGpV0ESCWBYIvfoaPHd8lJnO4cxLn7KoV1Pt?=
 =?us-ascii?Q?coelYg+CV2VI3iBNclzbfYg9O103/B92CtQgt4rprrobFU6sv7t6CCoApr0U?=
 =?us-ascii?Q?v7pqWA00uRP1X7Kvkl1hKiee7mxhv8SBxOS8Y0KbLKa+ABEhbZS/JBw7IumG?=
 =?us-ascii?Q?sZq0sCF1yuS9jrROYvWHEJN3I4bbKvgFji/KeOJHFNXkoYJoPVZglvjnUeZS?=
 =?us-ascii?Q?XcyVq4db2n2CG9rLznHPcwQyMjpjoqLe1qDhPzhUulw3LdU1nj6DkfIuLPQ4?=
 =?us-ascii?Q?vV3wVKP7yoZ9zK/vNF99yXNKGBoC77PGwOmbbacU6yyl6KMQOPGD/pJMWp9R?=
 =?us-ascii?Q?fWXX5sNlXsUwpLUFueacaw5hc6o4Ny5iu75li3/hVfU2qzPa0rzC3FC1Y+qD?=
 =?us-ascii?Q?8g+2uJ+rZ+OO1h0/6qHTpRi6VdzxlJML8fT5RX9ek3JCrNLwwi/wQXDtufyK?=
 =?us-ascii?Q?8DwMZXxlTST24IZUzcOjxtUYxvJVhswQlNQhmykVxvd+H90MgJv2r1oTU567?=
 =?us-ascii?Q?GJFcpu8eQ7vY5NTd+QO+hli934XNA4sKzfwWhKMGvBiSTOKPtq0dSullyEI4?=
 =?us-ascii?Q?cFUegcD+dejmp24uRQmayTjYrzxo5rYdf+kikHnQFD1B5Vbupupd6RSvzSYK?=
 =?us-ascii?Q?27qBisg7ExEiqSwAIsO68gQgz0MMM9vYISzlqVRGjWv+xXZl2lB64X6feP13?=
 =?us-ascii?Q?5ChIbVnM/VgnBAqYL793e8WDaF/+HwILXQ64zUsK6B8uCKcDQp5q2UNyHAvN?=
 =?us-ascii?Q?aXiAUh9/ZDzsPgdg2Lt3uTr7d+zVLKX0S01eJ6VZCyg45J2xClky3MBATfwR?=
 =?us-ascii?Q?sLe6t8QpBn0TIxm7/gUTj9V1rx+zp0AXq89/Z3ceWjFp5ER74PJcFmL9Zc6o?=
 =?us-ascii?Q?/opnpNqln+qlqQlDvDwslRH90S38Y3I=3D?=
X-Exchange-RoutingPolicyChecked: ppOqjLcse+qBSi6rmht5LYULgdIO/8VBXUOK3kevKLL93sJriBhDeqQjeJkZueCn/w1SzkSueSC7YwQmc/58H7Kq8VndRlyCJQYLQZi6OjLueTv3Mef4iwAIiXOv+cX0zww3582rVrV4F4JSH3s4RFDGxFDeMz/6NsDqVDRVfdL1juTPFobPHPr5sp15blj3OjW+rjaVitaBSr0cT1daYtn7DLXxzddjDiET74WJLnpHhpgFzvwTpe3OU2ZZCTXprRv1k4UGH717aqNgidJX390NhBwmkKB4KwFaTF5plESnzDa9ydiSalL1qcXLHnbipXm+fj8PUB0thSYGuEHn/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 495e3724-a49e-43bd-71d6-08dec258e356
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 16:46:56.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ug9Ja7o6osthsOOOZ1pvaiHaTa5hq5TenGUF9OIg6kSV8EYF3ioa4xWXWQv7K+V/JTubL66MNdbLmi6TPGLUVDtgOKMdc+qFg0qLsXQeqwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6685
X-OriginatorOrg: intel.com

On Wed, Jun 03, 2026 at 11:57:52AM -0700, Dave Jiang wrote:
> PCI config space accessors return positive PCIBIOS_* status codes on
> failure that are positive integers. Several DVSEC accesses in the CXL
> core propagated these raw values to callers that test for failure against
> less than 0. Thus silently misinterpret the return value as success.
> 
> cxl_dvsec_rr_decode() and cxl_dvsec_mem_range_valid() are the two that
> have callers make such assumptions so far in the cxl/core. Convert the
> postive error values to negative errno values so the checks are correct
> on error paths.
> 
> While the chances of a config access failure are low, fix for correctness
> and to avoid confusion in the future when more DVSEC accesses are added.
> 
> Fixes: 6612bd9ff0b1 ("PCI: Update CXL DVSEC definitions")

This first fixes tag is a macro rename. Look at this one:
1acba6e9206c ("cxl/pci: Break out range register decoding from cxl_hdm_decode_init()")


> Fixes: ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory related info")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 43885c59a7f2..cb33dc8139dc 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -89,7 +89,7 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>  					   d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
>  					   &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		valid = FIELD_GET(PCI_DVSEC_CXL_MEM_INFO_VALID, temp);
>  		if (valid)


Above converts one twin and not the other, cxl_dvsec_mem_range_active()

With that cxl_await_media_ready() calls both, _valid & _active, and
returns different error codes depending on which one fails.

Actually, cxl_await_media_ready() has 3 return sites:
- the cap read (pci_read_config_word) returns raw PCIBIOS
- cxl_dvsec_mem_range_active() returns raw PCIBIOS
- cxl_dvsec_mem_range_valid() returns negative errno (w this patch)

My suggestion is that cxl_await_media_ready() be made consistent,
those 3 sites return negative errno, in one fixup patch.


> @@ -275,7 +275,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  
>  	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CAP, &cap);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
>  		dev_dbg(dev, "Not MEM Capable\n");
> @@ -299,7 +299,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  	 */
>  	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	info->mem_enabled = FIELD_GET(PCI_DVSEC_CXL_MEM_ENABLE, ctrl);
>  	if (!info->mem_enabled)
> @@ -316,14 +316,14 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  		rc = pci_read_config_dword(
>  			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		size = (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
>  			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		size |= temp & PCI_DVSEC_CXL_MEM_SIZE_LOW;
>  		if (!size) {
> @@ -333,14 +333,14 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  		rc = pci_read_config_dword(
>  			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		base = (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
>  			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_LOW(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		base |= temp & PCI_DVSEC_CXL_MEM_BASE_LOW;
>  
> -- 
> 2.54.0
> 
