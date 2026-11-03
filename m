Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793674100;
	b=FWtlEum1byLu/Dq3Akc7i0Bx0Beh+3P2r1+xzQRXp1xLxSDsyvnteppQLqUH2KOILdMS
	 S8DUYw+9zZcXe0WgxupesbGDqrXOXsG+T47Gya/NlSif6r/BuG0OgRtfQhT9/zG5Kl2Cg
	 fsVl7AdBAtskKPt+DOWt9oXRGGRJCrZjQepkjeiXS53FE0L0fx52EA/BLpS8tDFDKNpoh
	 Y30ZhFY5VW5pBLBOY+5SliK+5UpHHAVday5KFV3UvEBn1/cRo2Ta8uDWTfx9/fw60MEqy
	 wHIWYHbvobpLozeNvH7pJG7wcCtFWy+0/mUm2jlgv9QidhAYbBa+YBOduexIlE5RxaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674100;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=JvIKPG5k0lrzUGOluElEfe/QzZoNs9tDkNcEqx/qEyY=;
	b=w7GanEAhFh5HDdxMhNa4uxq9BUinh2KL7ryY5PtH9Aj76ct93+hC6eO8RywZhg2VR+de
	 AfqUyq8hxiTS9NCveukFssgg1f0vUpnhMMUkk1BV+zHUWLPKBsOzbS4BL5/rfOFeAYq9h
	 Ts4ySUXzmnVESugbse7mLLgQe67HFyGTsMVLVloydvgeXA/4A7thQyI/7SWODlq9RjEXz
	 1u1AMBfZVfqvySGzal6VawGFrEQyw67NqwIbhe3XUuK5xq1w1erNQTfha1GOXsyTlGPr0
	 aHy8/Yf83HJm14XKHTBGoc73Pm4ytDPTocnGL5Hm0J5qjUrcNocJBRCpfRhvgjiN4ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KAV6Zzgy;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE6606A324
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 02:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06DE6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KAV6Zzgy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793674099; x=1825210099;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=svI9rXEEN6MRbKg/Vdl07w89aHjxSm2LQ/VVChB1/wo=;
  b=KAV6Zzgy0sd7d/sr+W1+YS5rWkkXL1GTEOgiQKRKS7r9A2WllW1XfThv
   02Zj2ndzOm3MERkCkKYKi1K8Hj0jLosHD0Xnnu7evkP9LrThQPbPSVrtN
   qAqWXPCb//LQ6PEdb+6vIo4MEWLuAsjv7elcfppmBi80DkTp9aRHJgBJo
   nhTsH+KKL1UlOzsw89cldguYSFRWZaynqtmZuEjaV76ICnEigMs/xbIPl
   hQefkyWgLGPhD++lZBv63RYwVV03cPfi+tSwWv31qgxbmKSL6qCz/zHQ9
   nC9rCEgyyyszfygtdbOIiBX+OHFmoGasVhcnXyVk/XLSuiNg6jC0Zq/O8
   g==;
X-CSE-ConnectionGUID: x5RykghbS6G3xsDtz8u1kw==
X-CSE-MsgGUID: Gxg9teDVRZ294NH89fdvaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2415996"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2415996"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 18:48:18 -0800
X-CSE-ConnectionGUID: +V+/MSrLQV2EfmEetrHSdQ==
X-CSE-MsgGUID: HY+PvWGmRyGAjLjB8esC+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6131987"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 18:48:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 18:48:17 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 18:48:17 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 18:48:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1m25dhXqb/sNjUntg0d9rLb9O/w70PXfAH9euSEHzjvvHham8KPQ05kpMgc+JA1Ed722sLNOvqEAUZ0QGrmQRc3LzNLkhi0HFz2Lur3T/3P/2TrejQ/zt9182dFZFB+zrjtI0NcWITn6Hvculvp0DVKorUrsc4cqLpIGQ1qURzoYPGenHyiOAj8VsrlcXP/NiS9v/U2jfik4S43xJ6vfhepD+MYC9aaFL0gBu/IAhwoH0ryKl7gKYjxOWElWieRMuNFRXcqN92PdM8mUT/mgh82nvExDYAs7l52ytYtHKehHcxAEDhJtkGRXBdq1qRNMdMehVQWw2HQEx5zW3Pl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvIKPG5k0lrzUGOluElEfe/QzZoNs9tDkNcEqx/qEyY=;
 b=ndy8wk8CtOZwdQxjQh2RUWORMla8zSwrMOTthhoxhUtXI84RadVF0VhopfM7R9UuPmedheODIubrUKTIiMajIl+aZhm/ZzO6rI2g7FXcG8q++SmP6R40msDM/Exg1rtl5gXfYyK3XUjdIvKGfQB2e97f8sn3wTsMsQF9b19+kTr4s8Qqqi9LKJ5sJEnqvQV4jcqo9KWuGaCWdC9QZV87MYHr1C4EwslsNAozSPzXk1zZ76V19QaPnBMsKOwBN/Ww6chwzLTowOA0S/HUOInsdst0beLvqcYjOgmp8VH5xK1iTNrcZ53tjYODVqilbskSd3i3POZXnI2nJq/9BVSpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:48:15 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:48:14 +0000
Date: Mon, 2 Nov 2026 18:48:11 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v10 08/10] cxl: Handle auto-committed BI hdm decoders
Message-ID: <aulLa-fBF1T_LDQU@aschofie-mobl2.lan>
References: <cover.1793567979.git.dave@stgolabs.net>
 <db0f7cc38da1300596a7b8653bd2fba010e20e52.1793567979.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db0f7cc38da1300596a7b8653bd2fba010e20e52.1793567979.git.dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:303:8c::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc4c261-646b-4c52-9596-08df3954e84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|5023799004|4143699003|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: Mv3TOAft3neitppmo1Ph0qdUDr602NyZKwyGsbZaYs4BTvElVOPhhA1YmKvKuYc04NfO6//cWqdhCXSYePDDwZk13BbK+1VqaxOau3/vNG8D2CGKPv3GSbiOcVQ5racRQkjZBygHktaqRjO6icpwGZk6ACm+nCOtaZ7RhT8usDRbW0zpGinmsArnPFnp+8EWEuHBCHtVvOzrYBzKNV4Wjc7suz7wlf3f1sV5jjpc9sUmJMWnziFKOx8abFjGpX4fJTJUswYrrpfg7tLGiYkSFBmpRKQ2HaQJ2RG/LM4EMHq44Q5qjN7/eMwF+USPjl+CYQYFZ0WOJBG23ylXM/Nhi66nycP8sSlwurVw8ciCeI3c0ew1p/dXfdDfkURaGQRNex/otYDlDSwILZuOvU1R/YKR9+49+n+aMaL0ABemLlRRliMYPeGHB/WlEeUcZeoYSMuz8prsrjlyIoAp7wGcrnIkBENDQQyTzHyk0/AsJu6sKi3qbtGY4qgtCskdyapyZB6CplcrfvneoMbrMnOXlOG9+hnZPHyIPhUIu3U+dUsgswmhC7g1e8qKpzH3MzRMe9uL4uflTq0HHZTh7y/Ya4cYo7pSmbeQTaR0SKKTjXzmlS+lYIJfEzwGPNM8EiP7n08kmwFCZq9yjZaW+TjFW8rULUvXKlhQItpGuIFT5uE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BAZeFDUTfkzt0IfTRfDiu/waB3SqNE8EiEE0DPLR/G08ogQn/ACt0sVVurN2?=
 =?us-ascii?Q?Q2gmc36a/+sxsP2s5oro4xKHIqVli0otcwOQ1RSfWQL9dGmHjsoAYMi5gPnd?=
 =?us-ascii?Q?Kg7V7BqNr0cg7SOE2PGWtjLcDTvekKoVg43dQkf+OlWQl9SqJaAih5oqSmR1?=
 =?us-ascii?Q?FiNo0g4/9Q0/aTQvKLVfSZpEog5Ba2ODOHAWKsjYZGKMsjW3OLcFXXByoFv1?=
 =?us-ascii?Q?kl7ZZu/W+iTbVotee0RY9TV0IjWVgi3Uf50ReNaMuhLYwq3iAE3yJsAEV0RH?=
 =?us-ascii?Q?VRpoHlfu2+l+kNuGj5oFHKdxvzBdWBsj/9KIfNKh58oeB7PwLMefkS/kuNcC?=
 =?us-ascii?Q?TbgRIais1z9XbYrYzVqZkukzO63XZkgGmga4qZUGWzbMod4Qg93IY3GFvs/L?=
 =?us-ascii?Q?RcGaxWd7PwWVANMwKYTH5i5h5EjW1WEO9ihxQVbEBs4vaUTrbzdLw1RjKghS?=
 =?us-ascii?Q?sqTtzP26cRNc9tn9x9GjRWKSiv98sEqGAFWvPkzzpRY9gzOs9WkxkGKx18XN?=
 =?us-ascii?Q?DzDfjRNt1S3OOjvuwQ1VLDi/zr0kOEoIccev36k08PiMNJ+4fTg9uwQLNksy?=
 =?us-ascii?Q?eVjNvwgPQ4fo+jEM8ErtVCe1AIUdc64Gd08Gl5PKTEy5MrWUCMmHqbuoprmB?=
 =?us-ascii?Q?Wrp2FVqF6SfEJkjDNFqfQZ/i4MGupK91FuL++R+PVQHY4ZQ5enjrHIhlU4dY?=
 =?us-ascii?Q?4RGwRJ+0uw0EzudTOJPK0fj+usarwmCjHAUeK+e3we7YPuGxxOhfdtkxEIjv?=
 =?us-ascii?Q?nvrxSENSPn2TIQ6rXV8ep8tsVAaq5CY2yaQfHFnn4+tJKoDFj8JG0qDBIVBb?=
 =?us-ascii?Q?kmIX/aVVP/37RcwOHTPCPCKPf0E0W5FdWrlcimUZjEvLNHOsXQl1P/ynfkwl?=
 =?us-ascii?Q?u+5gHXkGJXjKEnAmqGhRq1n4xOheOzuGygnNopkHxDpOMBRYc8LYTT4RSA1T?=
 =?us-ascii?Q?c8ARBLcALmig5f5+gMMEPUCnCoRI9qrDucRveJcND9aGf2Ho2eTdlCMzW1rt?=
 =?us-ascii?Q?beShhu5TVDHVkqz76lD3HZukm4d3MDjwd3QX0A677eQ3Qqgw7MYMVPmqZxOp?=
 =?us-ascii?Q?7lNc/4FNWNf7DXh98PFMtl1z1odjMFh5GUMlnhlamM/Z3HXPbZ25yIWqtNKA?=
 =?us-ascii?Q?SohhV+H723iuoAOjf53DIU2GJXzySn4iAJTeXC0CJzr6pNWt82rjpbOeYgSW?=
 =?us-ascii?Q?Z5PdKCm58b766IukzaDl5uVAJogHAauCiHFGJtbbvuIgcN35e+3Ab33Qh1IO?=
 =?us-ascii?Q?0xSQTI1TfJ5ABSjwRwjCyUifI9IBbfMv6mL22vsmJwJyz+N5kopBLuMialWK?=
 =?us-ascii?Q?fue5siRdpiqF5aNbHpx+D1FtVQgJS0AazpySE4pot6J5hxNcA4R6dA8iTDH5?=
 =?us-ascii?Q?R3aQxw8+AOxSw5jMNv+H4oR3a6oDkVRbzQuciyfdlAMUIBOtSdUMODKXq7ts?=
 =?us-ascii?Q?IhTk57+MHX4czZDBdCfeAt/2jcNv7qnAL3H1YUYlTDZoKNTXukW+sExCHwgc?=
 =?us-ascii?Q?+y7CfRs4juPIr85dz0RUI3GO15ZDp5qpN9Gifhy9vQ7AihxLl4Y7yPjyQ3Hp?=
 =?us-ascii?Q?PsZzMXz2NLmDdPtz+QHs7lhcPxFSLQI6o/uK1Kx5Wy+UpOh2r39ep2BJWMvI?=
 =?us-ascii?Q?p6DqQgM1yBPaHupocXtYx3m7Iuquign6HsAg/zXxxzisEkKadT8keXRCwq2+?=
 =?us-ascii?Q?Lrbsrn+8bxrxeHMp/m5N7YKbmZdNvPMVUw7KQXXF01I88+bpGrFGMiy/RbQL?=
 =?us-ascii?Q?FGCEnf9NjyNDUQwJAHY39ZLF50sY0kc=3D?=
X-Exchange-RoutingPolicyChecked: SXx2zuCZDEekmuSrrH9NJAz9qYXKKAjH9dLB00Luo/9bWaPYWvThXtLFuSL3/0TmUVUB3EJyhdG1XJUMS9F8nNp5Q6HJbF0u9uRLJC+9AJIu0AgmRCo3ofV+P+cFxJVfPJSSqZEl1ZKOvTEQ6fJVYKQGewcUEELui0Qg7tBFvzEigwVIwgVymGbl3VNpNYLJo2MKcD3YVbUmbJ16SoO4E93YVBHc9GxDDL+spSXjDODGUA2M64ksxrS9crMASnGboIiepQk97+jFVZcdDaEwurY+2zZdlEpFP3sMxn9LbTevyZhuYaTRCzWpbcIDzXg0v/423dUGSACCwlgOetDhYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc4c261-646b-4c52-9596-08df3954e84d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:48:14.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEyq9IdFwQt3rCOxXH83dqpUTmE2bJFxbCnsmfGc4HbmNJnOjO3LTpsT4LtJ1a8Nt0HNAqcfA7GIiR4h9DzpcOmAv0UwUokPFFX/nM3iplE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
X-OriginatorOrg: intel.com

On Sun, Nov 01, 2026 at 01:51:05PM -0800, Davidlohr Bueso wrote:
> An HDM decoder that firmware committed with the BI bit set was
> assembled without the bit ever being looked at. Record it, and
> refuse what is broken - BI paired with a host-only target range type,
> or for an endpoint decoder BI on a path that cannot route BISnp.
> 
> Taking over such a path must not re-program what firmware already
> did, and a dport's committed state does not say which device it was
> committed for, only that firmware committed for something below it.
> Two endpoints sharing a level show why that is not enough to go on.
> 
>                         RP      Forward set, but for mem0
>                         |
>                        USP
>                        /  \
>                    DSP0    DSP1
>                      |       |
>                   mem0      mem1
>                BI Enable   BI Enable
>                   set       clear
> 
> Adoption is therefore seeded from the endpoint's own BI Enable, since
> only a device firmware itself enabled can have had its BI-ID
> accounted for above, and carried up the walk. A level is taken as
> found, with no register write and no commit, when nothing this driver
> routed sits below it, the value this driver would write is already
> there, and both the decoder and the switch's route table are
> committed - the table carries a commit of its own that firmware may
> not have performed. The first level to fall short ends adoption, and
> from it up the driver programs and commits as for any other device.
> 
>                     RP    Forward, written but never committed
>                     |
>                   USP0    route table committed by the driver
>                     |
>                   DSP0    Forward, written and committed
>                     |     ..... adoption ended here .....
>                   USP1    route table already committed
>                     |
>                   DSP1    Enable, taken as found
>                     |
>                   mem0    BI Enable already set by firmware
> 
> An adopted level owes no commit either way. Table 8-152 and Table
> 8-156 owe one per new BI device enabled below the port, and an
> adopted level is not seeing one.
> 
> On failure the walk unwinds through the same release as teardown. An
> adopted level was found up and is held, so the unwind drops its
> reference and leaves its register alone; a level this walk brought up
> is cleared. Teardown works the same way: every level this driver
> brought up is deallocated, unless a decoder below still decodes with
> BI and holds it.
> 
> A committed decoder is refused when its coherency model does not fit
> where it lands: unlike a decoder this driver programs it cannot
> inherit a region's model, so its committed BI bit must match the
> window's, checked before the region is built and again at attach,
> where a second decoder joining the region arrives.
> 
> A committed decoder's BI bit is recorded as CXL_DECODER_F_BI. On a
> root decoder the same flag is the window's BI restriction, as F_LOCK
> already means a fixed window there and Lock On Commit below.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

v10 changes LGTM!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

