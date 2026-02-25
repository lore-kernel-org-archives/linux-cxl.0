Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D7319601
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772062955; cv=fail; b=aKB/bAicp+GoyAPJ5P87t4dVjBGmGkORZFdiddwX+HdYEGIT8Or7uctFwO8+3h/kEv5xBSQ1rH87+Dq/8QnsocujvLWDinS8eaR0kswL6aEUKC1b34i5mvmziVWoTqz6EDeGt0YXjuOS4V+Wz3qTb5mLnNRjFZUxwo/0qjj1ouc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772062955; c=relaxed/simple;
	bh=0ec4V4ithAjPDToOIY6mNF3GVYd2Xz6hlE0AasNyzLg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bLH91GLU6yzOgH6Dg+FwZgxSG2bTW0xulin5s2q4C+kslxhIKj7cUjkGW4QrW0Apk+Sji/6lLktQwUubFxJAxqcWN6cZTyHuGEgWxiAVYSfw1c7IDMkzJCweQSVClFqS83soOJJMcUqhnDb9niBTAyfR/0YGZJIhHUnIsdqkWts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6UA4bV9; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6UA4bV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772062954; x=1803598954;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0ec4V4ithAjPDToOIY6mNF3GVYd2Xz6hlE0AasNyzLg=;
  b=j6UA4bV9cixoItL6rmNq4vUiqv3+vR4F3Z/R39IHGWtrs4Pzsq31ieB/
   idxD40IV1AgwJVVRqrKuuetDx1IshDZyyyawEA1gj+/hgv/dzuPuCLOFT
   rG3RvjK0dOqkUH9RA32BxkyJZJRwkDhTc+7m6Naybz7DzpY4ax69AVIeB
   1sj8Qr8fdjf+JnA2XvBdahg66NBp2lFV0clDeC/GMrRIIAINprQhpYfpa
   eHV6sR66Zmx0SOMtmEtx4qs5zjjUoW5Nj+QPnMxqu9av1wwQ9R0z/3+2R
   zGVOA2NwkFs+nmurlaeANZUMA9rA5XR/UI4QLFD5BSByHwE7scqeC9DYQ
   A==;
X-CSE-ConnectionGUID: 3EbqO3v8Tme13YwGu//HTw==
X-CSE-MsgGUID: tbVsTZjMQD2c6Ds8EaEXmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="95730307"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="95730307"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 15:42:32 -0800
X-CSE-ConnectionGUID: MRfWt2a9Rx6zsjmq6CazIg==
X-CSE-MsgGUID: w1XuAls5SZ+Unsq5rq8RTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="246932877"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 15:42:31 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 15:42:30 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 15:42:30 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 15:42:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZeba6RB5j6KRfubH+Etv6lspPpkwf9la35BKal6TwMJ/M5Bx+qa9zdXHW6tB5C8aXshByIaWJQgWSn9hTs8fs+ZZ12AbHUijEFwevIg0l1dhw06rr1k6p8XiKnRCnizdYietj2fg5sB2rrUo2QcndzVcKf01nenF2LsVp3a4p/5UgfhV6IAEMri5Fo7TKw1gNMMjSgzDYZwwU+ZBEncG44kzp2b+5BIjQJ3zG3C1bMHxXIzrUWySHv9ilIDE/8BM4J5w1Lq7lXXIfYPgENNgtDzzUfmMEZ2YZ1fwO+mtr/nGyT8nIlBmWT4JB2mWC7UY79jfW7UYhaSQx1NWj1mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCuvVHCmBzLBV8ZG6ZaYpE8wkKrjdYkj/sqx3QZ823Q=;
 b=Nos3uObDDVA3SPtHIeEBLtOT/QBqUGCexSkSxgvD8Ogb2bJKORBxXv+EWIeaFimcfI1Xe/8Vt0TRmkzMKpSMEXy2CcREt2rBL/X+p3QUeaVom/KZmQATOz9JmklCm4DNJg+imgwl7u0m4lEgEAHo3Eo7TnZDFQ2Me/xJ/BqDWCKLLRy4TDYuFoqFyfd/ZQQBR1/Z4XFIEyom15+B6hCx5izTYKFTFiVpjt8bjWf6HAF2AQTHidJ0srcyLZy6FjqWyIKzX5POPT/3Djm+JPynflAFELPMemnEl9r+jvPxgoWHCAs2ONCrGkEYrLFwcW6Zx09oTyDI9ipNQDGy6C81nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB6849.namprd11.prod.outlook.com (2603:10b6:806:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 23:42:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 23:42:22 +0000
Date: Wed, 25 Feb 2026 15:42:19 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 0/3] cxl region changes for Type2 support
Message-ID: <aZ-I2-NsMEKV_W53@aschofie-mobl2.lan>
References: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d010c81-b73a-4022-866b-08de74c785e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: KOAWmn924h6vHU0KQGVeRAzeafix6NsVvUHV3UPlTSQzMaxP7S/dNHQBrvWyDjPYcF8Ehz80vRkFoojhcN0e+iWwNNZeDBooO9ai1tm8WBA5bzXzw69XTVKQdDQKClj463IYyLJDFU4remkx25DIN5UyRkBN1iolvLjAiuJmVo8vq/o00H1s1MVHPVmQB5wgiCrVepMfJ6r3+QE0a//O6O/B6ZkKWnjALbHw/cdjPQuWREWnuk+lbWqDBIKUg7ctvWSskn5A6ifCs4pIeumJSoiHMr2O3ZCYjnp3r/sN3HM5wbqozR8kvTkoAP1sceEEn3TFP0eqXVWjAMBRfpZ78FfogM1UhvBa5ip4YwSiUcMzBOuAlRu5mWTP3lxu3okdVPe//zEYYtZIGImiGZfu7UpmNHFbEJYnsBdELzJr7way3gF8C0XdjkcMyX1OTNXmv148xjOIMc1ML5b9NVWMt/fktfgS58dUApVDzm2yzAZwq5AzPlc3GcrbIRoFlQAdM88pFsTdUogOrgLvvYvnyLwCbi2iG13RTZIY0eFnjoRhwLTaum+5cG3DXhqC4/K5vvnznKgmV4l926ez95hGHfv1RRfN/ZwVbxJQ6b+zwZPJpUNO+xuOSptQ2BIcKQCrIE8VHKzws8A/vpiDZXeTXb6JurRqFRCk8JwMixdB7GAFtl0jX12K8JbX/YeD5kx0f7Iz6TUZNG05FW1vebtWWcTEB2TwBB7GvPaKyJYvA+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HAIWp5wLv/mWhbtG7PgNXNhQpB2ZYtsRFDEe5O/fryuCcpy/SyQo0pFHPX2s?=
 =?us-ascii?Q?UES7IlNv3feqW9f3R8DzyDVu1xZ5Z4S3P2uOzhfYLaMg9houS7nNQqc8sn0C?=
 =?us-ascii?Q?ARVcUGI3iNmnz9Jj/ncjQy2K7XleOMhsbt4gC6YTR4Bidb8uZpTatxrJF4rb?=
 =?us-ascii?Q?+htvs5oM21C48zqbna6Vsbk5Tx0rBGV3YttDwGl2UA9DTn/H8UQ/Ve7iTU26?=
 =?us-ascii?Q?Cwv3Yrg/qLlpTQyBpeb67hFrrBnvrHJe5jdfT/gt9X7LzEe2pYYKx6IEvql+?=
 =?us-ascii?Q?Mew6ESWMzZQlSmQn+tJKRh6uvy26+IATv7xMJr2C/PYlOfMwW/MLKb1+7LDp?=
 =?us-ascii?Q?zd4Zclu/015lmGQ9wjd9tghMiyeKTzD/gkaJuEhI8jq7/Xhi0r/IyMnE+tdg?=
 =?us-ascii?Q?1pl1s9x46fWj0eZtik6+gPgB3WKevylb+xKG5nHHGYhlJkhVxXraQX9JCJk9?=
 =?us-ascii?Q?TIjur16AiKEo5DZ9V5+PDgf5eVxlwbgMw4iK++0R8cjZosZsbtLRi/XkqWNO?=
 =?us-ascii?Q?w57nJ+a9KamcmMXPoxVT0sNliowTAoFBVdGRX7wY/dQ1CWE3lbCMzBX8kU/F?=
 =?us-ascii?Q?pkKIgG7HhFTn16UBhhBQs2hj7kE8DKUyMiaZVcZvTgHPx6KdJmH2cfKAsAZY?=
 =?us-ascii?Q?KpuCrxhZVt8sIfBF4Ifls4yjMT5JeFyswHSaMucsQqX+Kz+EAFmXNyPz4feZ?=
 =?us-ascii?Q?LQ7i2RY6aBufBrZfp8NTuhUO+xfbZBcEZqHdTEb09ZoH8TdzzTa+ExGMt41U?=
 =?us-ascii?Q?kWZdVJH48ami1q+y7ZkFcaj4DdIQpXoz38Fpz5iD9N3xMTmiNEZmqK7XpygA?=
 =?us-ascii?Q?HjgEBiDNaE9wHPvcoLWNcnjPFCRon50bwSroeb73Y7X44/scorikFYHWqGsL?=
 =?us-ascii?Q?5Te3w78JHKgfRS8Ju0mVZ+ioGt2b20lvQCPjb4lNsqEY9yQiu/vdY4/72bNx?=
 =?us-ascii?Q?OSB9sWuq4afksrvTD1xmB7rfFqTkhd0iPnnvUEtdmRAr4SJ/b6sLvKUElHSh?=
 =?us-ascii?Q?H+zgP5UvpgEry1VeCajYj6sO7fWKd9Qd0i61hptXaPjJ+u8i4Q+SzSSth7WB?=
 =?us-ascii?Q?GpG8VHDqFuINJ1jVaRAY2Y6Dc/VpVsNpCrX1dri5ZbZHxqYPXYrJ5zJln+Za?=
 =?us-ascii?Q?K2g2g/MGr9RsoXN9qvIQIZ7OsYdB9g2H7Pmq8N4bal4DZlmIZI4bIDTxtSKL?=
 =?us-ascii?Q?UJ1B4ff66JzMfBNfmY+K5fU5wFJIGTMW/r9nkjtS7gJ+s/xdMzrWTXumb21S?=
 =?us-ascii?Q?T7ncPuk3lQaJcXZqbpWWBFukPDZguhveKdxNz3MwTyyqR9Cd9POiVh7UCQOK?=
 =?us-ascii?Q?aftWdG9R4UnMN1LssSr1sv9z9Ej/luVqeHqzX4PxjoBh7O+D6l/IUsnSELYy?=
 =?us-ascii?Q?JvyJmzKPmoMur7YFiQz/AGPxondjDZR9keL9PtaeJbQo59Nl0R/Ud0mJ9HnV?=
 =?us-ascii?Q?uYF9/pqYYGpUllWzludFwS/zogMX21ug4ARli90T8qxW2YXpGFVzM2f2hm1V?=
 =?us-ascii?Q?9gsndmb+1AfxNpSG1DQHFOzA6c9cwvCDcNhPeBwAA8C02IY9HVO09XjSlIBl?=
 =?us-ascii?Q?Hx5qeaJQiRFnfNQreCa9WpEB4HvnFiOpYUIyWLudwS23jGicDuMZyaXsaiqn?=
 =?us-ascii?Q?exYBvZ7BIAmI7ozVJFqHR0lRe+iX9HjO+5JUm94JGf/hk1q1uv/2i23wRN2p?=
 =?us-ascii?Q?CUHbY2WU4YXUd7fh34tZ2Jhoro//sT0AoWRfnlDMK6pLl4DSLWBE6ngsPna+?=
 =?us-ascii?Q?yTC/wf/FsrgmxMDo+uKgQq56RmM5f1Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d010c81-b73a-4022-866b-08de74c785e8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 23:42:22.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEjxxrthLNTukalIGIwLBHOXD9lGJQp+HZa3XIHRdDCjE0fv21WtDBMTdbXapRzNtIL0xfaM+Ze+Tf4hOlCLwIrpqQMIxGvzcUc9GGxATjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6849
X-OriginatorOrg: intel.com

On Wed, Feb 25, 2026 at 12:22:20PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for Type2 devices/drivers support, these next patches
> adapt the cxl region code for required Type2 functionality preserving
> current functionality.
> 
> v2 changes:
> 	- fix commit in patches 2 and 3 (Dave)
> 
> Alejandro Lucero (3):
>   cxl: Make region type based on endpoint type
>   cxl/region: Factor out interleave ways setup
>   cxl/region: Factor out interleave granularity setup
> 
>  drivers/cxl/core/region.c | 87 +++++++++++++++++++++++++--------------
>  1 file changed, 56 insertions(+), 31 deletions(-)
> 
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

Above is 7.0-rc1, and set applied cleanly.
Below is slop that shouldn't be present. I mean I assume it's your
other patchset, but is slop here.

> prerequisite-patch-id: 8d7cc83a3a58f41fe5e06fae90007692187095dc
> prerequisite-patch-id: c29b0a563fe612597230f169c616753222b39f14
> prerequisite-patch-id: 5303d151b258b111d338359c565831476035f16f
> -- 
> 2.34.1
> 
> 
