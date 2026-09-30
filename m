Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4A3B0AE1
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809786; cv=fail; b=W6bmb4INACOPVJcdR+hYSbzNGTOAnAHeMOjyAHudz9s7gQne9oKtFS+Pqaa9VM03U8sVhD1NTFn1tdxhQqq1d79O1xuRigtiXNENN/+jabOl6Yto7hN00E/3e+Y76j/QCul7EWNS+kHSPI/ewkVmYKXMe3cuZugzQXFpARRGZP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809786; c=relaxed/simple;
	bh=tpfto5/WjyrZVrxYj9pWZu78XKXRPWOkVxSc+qWAF/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AH9Y/cNQ1312uHnAwiiVp3L4RJmpVOILhz2D846zq9WkdmobPx3IWV0X2rsRUPJfBKM/u8VgdiUAW9b1eo8slQ+zAdmdH3u8qBhMMgJtB/61YLr0jr2LP/7NPo0hRyVIPeN3/dKnKwKWCxY+BT/WEd7oYWh3ebY9EZZZoos9Le4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Le6BIxK+; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Le6BIxK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790809782; x=1822345782;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tpfto5/WjyrZVrxYj9pWZu78XKXRPWOkVxSc+qWAF/s=;
  b=Le6BIxK+fP90jevDJtlydtDmP481CIx+ncs736clFcdZw8s1PTyubCXW
   AKNNMpb+10MnPi+2c4ZIsyUko0b5b+LjzEAYngY8jQeE/PWPpGTnP5xsJ
   30zm9rxIzqUzSBSWCLkXQdVt9ZjqQE6+1sOS3s4iYMjGkttAIEHAoOgke
   uhBHTHx2ipFBxojq72uU5s8KZ9xfvS4GRViujcTSnqvKuE7i1rFX7gM2L
   GNze6vgo1hTHCKaUw8XpOlnh1mAae/1nfXhhhMUCdKrMeMvWyQ23Ov9Nz
   WOlxuCATDNwACdlrg96msJJEdKsPtI8lswBJeoHyd6iyfIEX1dkjo7z36
   A==;
X-CSE-ConnectionGUID: gmLo/D2iR0G8FTdkyxD62g==
X-CSE-MsgGUID: uMv3A24sRsKH/YFPwCGrTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90512429"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90512429"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:09:36 -0700
X-CSE-ConnectionGUID: GZEaZ1a2QUGZMmlzC3mA3A==
X-CSE-MsgGUID: /BheIq/eQzSfTIDcKf8dyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="274937683"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:09:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 16:09:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 16:09:35 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 16:09:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLUHZT2Z8QR25z/HwPzI/MCnp+lD9aUV5e28n6u59VSe8xsE7mZTUIe4WvR0LWf+Q+KqdY7fW4NcJnLAH7Vul4wsUk+2GZFRA/Eit617x0vk94xSzyOh87n0TXQ0HsFh9pkEjIVs39t6Ai04izzb7FoFHFvc6Q0UJZHMP0VtxkJrjnD3z8exMpTeA4dmj0l2lKpOg5kfVkU6xWc8jX8WU5123cBhXIV7chybp2Y93aQ7BsjrgVC2efV8NzBJoLntFxDz+Dd8h6COUiaxo4lr7z7HS9WmXIvbW9djrJh040UQ1W5i7cxNQg3Ai50i83qE0I2ogIelKm/+S89ykfUe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu97CQQZWxNSWjqzJmzWCBdhHzAK7Y4gxPm9wvsrv10=;
 b=Q5QX5EJAli58xzF6n5xFKU259OGUwxwyo2Q+2LliZEhc+RrsA90k+poFr/62URIHepvAxqNoxlieQx82N1N+gFY2FnsNCXl6OFmoPiXLg+41wyvvqvCskD0VqGtSVHJlms1GPpiHOoqCDH6GZt0M+PnQIO4D6xIOOOeQrs8CAhTpSyDVffg2VB8QG8lYlfgVzTUXLmlH3XPrE2j+36/rUuFfWkNTLm9AsEWa8oBQS5Cceh3Oh2o0NMmTQqcxFTJENQghHDk9hX7T5aglsw/LMh3MkOZOLTO28vphtGKYiLQaOSGzlo5bpGEFGAWpKevFX39lb9RUGjr9U9wnhvgigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPF4990C6B9D.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::826) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 23:09:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 23:09:32 +0000
Date: Wed, 30 Sep 2026 16:09:28 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>, <alucerop@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 07/10] cxl/pci: Split BI capability probe from setup
Message-ID: <ar2WqNnwik74uSa9@aschofie-mobl2.lan>
References: <cover.1790103847.git.dave@stgolabs.net>
 <c61a057a45837e29c53cc8cd4e15df8712439011.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c61a057a45837e29c53cc8cd4e15df8712439011.1790103847.git.dave@stgolabs.net>
X-ClientProxiedBy: SJ2P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPF4990C6B9D:EE_
X-MS-Office365-Filtering-Correlation-Id: c084d700-71cd-4031-e91c-08df1f47e31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|5023799004|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Hvy0N8+VxyKDPMG9o6wvNtXF5wo8XP9V7HKimseh6XWHlC8ynQKXTqr1vi3n5esKrd3zSmAwoVvdUsgvoFtpUNeYINRTQNn27tl11jA/5p0j+sV/q9qwAl6/uCerTEIMJyfVORFsfg6f7KQVkGlCb3O91lsz0cItFidrGFlM48EzdLRw0FInr+LHA4vCFeJ2Dkq+vwmA64jL16vrHyTumYaRhabBntBEib/8N0F0t9uYoOLsLOUZET2EyeKeAL1/yy9TIoedw8PO+rumK0DOqqEMmaC2pv5b4QQPI95yAAb89Lz8f3mbwF9WAjK4tTE/iRHgEj34CYkOwGMOJ8A728PxtQHAq5K1hXjnCYJgHeuSuCazJhi5RK87bLGctnD3HH5Xt11QO8L9HCcUv3xn7NkvQZ2Vaagd9BtSz2EFcxppLzBDpp9wq3o/KAw15KuXGeOxt6rRrzUfm10QvedrZlL4es5Z+MC6MNvKBKgwWFYLqJxj4PLZuGnt7oG0tUYMvEtcImFTfZWG2P9X4E8oHZYnOA5VVdXH0aRBRd0Eztl2OnGJ47BPgs6OAw+vCT6VobRtc7F6mvBdDBXUGO7XeRlYk7ZtVr01FddTB/2bwt3spwEdKIwYBRfaqXdJ3x/45eekepbUe78m0tdD56Ri3OtMs76PIP2JEocslOibCJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(5023799004)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Cr80RUwkMJhoVZCZy+AV2SxrNojqtk9354GmBedP3xepEgGtQd+Y3olGiEP?=
 =?us-ascii?Q?hBxG5o8AiB+Ef07AaVgFWpzQojD8zYx4kasgDwfrfpjnalevEpm/tnmTI/UV?=
 =?us-ascii?Q?forpHW3fxaM1v+xQS7FHoz3fr/uWsONNAQB3Xq+ISwbEine6Eg4XKwUK3SVv?=
 =?us-ascii?Q?e49EswPT4LEVQ1kBYYm8H+oMuMzIVUapTZ809Zz6ugVUoLpMgYSnLAux+dm5?=
 =?us-ascii?Q?jPyNQ0TKrZvpvAu0GCtNs5D4d3iDw5VawhQRtiyKYsxaDN4URzMPxnva1aSE?=
 =?us-ascii?Q?q+CUGC3Sv8RI9juvdInz776ytKgZlWCO64LIXgOvni0SzLRRdjcyrDzNOtfA?=
 =?us-ascii?Q?25WBU+s9rcho6LlgNOxFVsXDK4HMVv+XFj3FUM+XklNzMRHyIB4oD5b6bimN?=
 =?us-ascii?Q?1A6Ce3hCpkarQ0pEc8lHfDKVLVYu++F0Bjvwjw/NL8UYskmzGI02lC1s0H99?=
 =?us-ascii?Q?Rg2Bl/UrOhdave01YhVctvAoC2L2QkO0F6s0V7YpWKot/4cDLCYNdxGu+bNy?=
 =?us-ascii?Q?y/AsYRWBilWVoB8VurF9PtcWQTy86n3bHUOdqxFd+Vb6e51ePagll5iAFGDn?=
 =?us-ascii?Q?ZQSfeUhvSUl99kJqjk+1EpIvuJtlbIEszOoePFGgygBeS+ehS3Yk+vhO3J6h?=
 =?us-ascii?Q?B0B9/D+tDv3FCgDUs4uD1ZSjSc8krhC1IZ2JnuI+Ix6ld1leuOHGXIkJv4mH?=
 =?us-ascii?Q?B8oGWoyZ0W5NXTvu9GDM4ZNmoPUpd9iiKiMd3gVa1u20XJS8PqevLMMAJQn5?=
 =?us-ascii?Q?vDcZ/hidCMfVh9duFYh+vQKrumPm7ONEJgVc/ecKeS+SW8IpDgVNtMjenDti?=
 =?us-ascii?Q?SzrD2SS8pxgGeEMjhAQgzTkplcWzJws/YGKAOiAXT4Cvv0uGef8nGzf+rNXN?=
 =?us-ascii?Q?pOq/mmgmgPslu0GHqhgg2ReOHCGfKBRXcaJr2LroK516yx9EIibn2qjGByi8?=
 =?us-ascii?Q?ae4qXsmgeizh1Uxtg/6uqPV8VdwWpuBb1weO1isb+hsY4LDLo4KHOAWOVe+j?=
 =?us-ascii?Q?pGpi8JzkWBcnZkO7TqFGe5Hq/lv8vTqX70xL2yLZIrM5YyYQbn8/p2HdVrfZ?=
 =?us-ascii?Q?gbHsSWk4emm0+4qJXEMkUy3kA0b8AR0E4HjYY29XFxdmCC7ueumaF8C6KPl9?=
 =?us-ascii?Q?TtkH8UfKbG6qBCci9tGr0czX8VM0FoodXByQSsidnz+8UZdl9OUvDGgHj3sD?=
 =?us-ascii?Q?dum/PhAsVXxQGS741SYIxgtvABmQCSHTpSltvsdVX/hYi1UP/+PmDrWCzLq1?=
 =?us-ascii?Q?KA+FKRpcAAdpnJmClxGb7JGj8S4Z9BM4GPbvII6yiTlS11nAw82lkURGMTgd?=
 =?us-ascii?Q?gpkxQpTN6rRW3Z8N8cCYCNCt3qib7uVG1uydSlT7ty0ldUZbyeiSQuKnp6qz?=
 =?us-ascii?Q?WuOGeO15F5K874qFpSA7Je4h6lZIDNySP4Gb40w7/aZwiBUgC+k2Y1jAGZqB?=
 =?us-ascii?Q?iELS7EfLk00wxvgvnOEIeBVPqJi4P+9p4/AKT6dFTWXrJK1V0Xy88kZX6n9G?=
 =?us-ascii?Q?RaYOqRhYOGvd8HSQkBpkeJlhe4XNJw0P2GC5RoHdpXLYHcFLqE3ECEkMd+HZ?=
 =?us-ascii?Q?hQlcjiz0sejPOMz3tBKXst/shF3PCU08T3FjrRoVC2p09FccJz3IB7SC6rq/?=
 =?us-ascii?Q?sNaP0GVuCIOJEnQ0NJaH3SuNl4WTexXdw3p5Qi3JC4R+EzjWBfU3mtBcXQr1?=
 =?us-ascii?Q?GBxszlwgCv+Cn4ypp7tqAZEjt3L1lCO9KCj6fF84AAWq8KxokMN7+IWwqIvs?=
 =?us-ascii?Q?oCyoY669KgYUL9GNkx6OGSjLBo8zu2s=3D?=
X-Exchange-RoutingPolicyChecked: SNPiNIGZa/fS5Rn2TUHhXYpt2rsAURVo3xnR3/7G7gD/W7mQD/GVlhwmUqlLtY0aK8ymbD94ylRRnMCBBSPa/r35v7WKv1NXgNGnqyTeSbZjQVjf6LQjaaD6y/eaXKi/+27AsBUbz2I/moVwiF9ZyJazXk9Zy+tWF8K4uKg6MSS39Zpdx3p2SOqZ5sNVsZ2HQoAqgEFVI5XnfPpRILaTByCdKvFqcJWuknw3IMQBSe/vn/Rk4THntXuTbo2QsLTvmDZhFwEnTLUD22NOMeXPmUvPflGo9rO2JO+E5a85XQfUcUF2Zgxmsk7HsJ8rJP8my/xZ1JRqow0vN6WkUmhQyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c084d700-71cd-4031-e91c-08df1f47e31b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:09:32.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0fjRO0P8oJXiBz+SwUPAd9WQtfsdgm4ljyifhQXTvVoc+vRWXht5wNujj01OjjTarSDMjaJuTO9BdihOqm7vwYClaQauSZlKG9EhwO2uxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4990C6B9D
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 04:38:44PM -0700, Davidlohr Bueso wrote:
> Decouple the topology read-only capability verification phase from
> cxl_bi_setup() into cxl_bi_probe_capable(), recording the result in
> cxlds->bi_capable.
> 
> This allows further dealing with auto-committed BI hdm decoders;
> having such knowledge upon decoder enumeration time.
> 
> No functional change intended.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

