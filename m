Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62B33F5A2
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840083; cv=fail; b=lMFWdzgNCgMDHHWbIgBZvJ6d33/NfGkvO7+8x0EfW/HOj3YhiEhw2utXYepGJ5EuzSrM2qqXWaZDkUtn9Ug9sxcTPICJHel7uZUsRzvwEE3TQ38IQ+V6ccPfI9Och1TRawxlG2nA0D54GSmhtMb3gPoyuFPxg/+CCV9ukHoBQHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840083; c=relaxed/simple;
	bh=UzRwJGz4v0079GRIxFZd9JYqdEIsH+pMPbroQHoZWro=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=heUjzXE9LRiTWDrAxYwZC3A3CtTCyui9yYdaWIuRkpo4u2BBEC6aghQ+Jaol6taizLxsoEj5zJYugXmp0rS9cesU0vn6yvV6ftVV3gDVTzxT6tC7xNbUDHR57xb5KpaqaZCL5yhlK8gCl2aGFPw0sjO2//74OOTEjFjmAMqe2S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BH06O1J8; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BH06O1J8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782840082; x=1814376082;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UzRwJGz4v0079GRIxFZd9JYqdEIsH+pMPbroQHoZWro=;
  b=BH06O1J8exgT7Q5Vs5sNUtWtYWhsu14SJoG3vYWe9Odkru/Cu5rx5cJB
   o0FoDWyzzsUdfJNvr40ypyVwZWf8JYU9EsPNXwzm9Vst3jYGa68xa6TXm
   sUuJz0Qjp9WtY5AKf+2QDtklCVdO243MkNKxYObfRtuoibnrKbXV+1Hmg
   sPWHaVIQ/zjhwQ97HxacsL0Wz9WRtZt1EEQWsubAQAnp84JChnXRjO6x3
   Z4+U2lSXlTLnMEliRqWHKduzdmFzdWWvZhqjweLvM7eFbusVnquJeWukq
   jcMtVRr7lyG8Z3jjnLAA9QvBCPgMQfn4h9eg/P1nqufh+qa4bkbDA2O86
   g==;
X-CSE-ConnectionGUID: i6O2iQ+wTSOHdcBbkvHSwQ==
X-CSE-MsgGUID: dVxTd5AMTeK8LcqeAYwJ3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83591620"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83591620"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 10:21:22 -0700
X-CSE-ConnectionGUID: Oo9TuIU5SDSgmcJDhBEqZw==
X-CSE-MsgGUID: /SYEc9r3S2O9I/AgFhCLoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="250617380"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 10:21:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 10:21:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 10:21:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 10:21:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUb9RgIWWlwlmyrU4Lr2rpIWKtw4T7HLYc+qN3ztsAzUHSRz8Ri85831C57r2hLvjsEeDgWO1qgXTDf9DgJLbFjzTvSvDZQBUUmxsn4D2jc91rQ189y3snqYEsFpVo7elHnwQFDDbtUCVQ8br4I5kNMy0M5FcezQz4C9N/nGkVudRdosBR6VFGnp83CSTiAabwrWgtweREneW3LXtzdCFZH70dsbhctICTHeEl2PVq5SZgexbi/rJlCxf0LWSJA3JHU58t/0lQaYD/cXjG2t+bPu6E1TJ5QmrQwSbsBpIgQFGFml/fM9l5GYfnAnKBiVB96p0uxaDhQ3F7H6Q5+s+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VhTxhrOTybKBZ0K9BqjS7tgX/9fg8PDUmaZQah9eXA=;
 b=JsL74J0fd/U+UM7g08iyw16GzrPYI1tYQUcQ8LPIIwv39reLyvvGzel5cJoNS9UEiWwn21SvBWKeTbUwgr6X1GkQDBWfRd5HQdMvZUHXKzv/q5YA9kgGq285UrWQ/98gV7Yw2pAJhs8P3EA9+RtRPmhYMOkm+Wndxs6P2+81Q7waBWC8REbYtPllYl9gTVpdPGO2rKAquTXUjINj+mGWHEgqMkY2hv1QBZtp0S+5DirrwRWca8QHx8952OVZW//GQOAAPLOqP+3zrLax5i2ub1chA1q6uk5J9xE7cUE6fH42GXrVvQTqTuji/ovps/qStYmgKDavqcOiHcpzdShbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPFD5EE188BF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 17:21:19 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 17:21:19 +0000
Date: Tue, 30 Jun 2026 10:21:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH v7 1/7] cxl/test: Add test for module parameters
Message-ID: <akP7C0oFiqxxi6fK@aschofie-mobl2.lan>
References: <20260629221104.3891733-1-dave.jiang@intel.com>
 <20260629221104.3891733-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260629221104.3891733-2-dave.jiang@intel.com>
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPFD5EE188BF:EE_
X-MS-Office365-Filtering-Correlation-Id: d20f5936-00a2-4cbe-c13c-08ded6cbffb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|6133799003|4143699003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: wDzGYCyCa/Qle2T8hOMYkHAmED6ny+4xmR0J1Nx3o7XtECU4Xwijp+Q8qvBN63tqM4BPrNhKrr7lkW9UQJTOhweXK1/C5QR4FLXWJFbpXnYMtbWepO3H+gOoRNsECEGWNS3HKiQzR9Lg8euiz38j7DOb1YFbYLCxPK2TVjWDYwbc+WjdJ0xh9tCEzLkR08uz2QvblDRlmpWSC3StnWqVdqGVjQiaWHd7gwC15eabC7+75GpNrgov7kRyYSyQQiVpKlANu9hm0uP+diz+AT0Jh8ielH9wQEWwSqwHb8H8bvovV5xXwdHyJnP3Oc6hSW11n4h3n6OY0rg9k9gs529Ql0aQQ+S3sHGM8bNg7f0fXT54UKgdy00/vVuiatPyGtns8zsn25Q7cfeWFdfWCdJVB1qRfjtH8u68BtmVfEt+JsM/TV1obkxRDhooCt9JpRm35LL4q1jqGpmKF3wVzLY4dnBAIlxoC16C0qItTJOvZ8fue9WFjDDaoe5s8jXPyfCmLx5Y9v702DTCwlT1LckmnTUagTq0baK6kv/g6hka0EjR14J95kzQlrkMdvNqnIeMqyhGqvKswHqgbHqbBC+EaRrVqku6+XPST2KdsVTw4Us1gA4Hrsj6wXgHRJPSJWkvtR1z/mLRGjJZBUbzqcbwzMlo81b6dnjZLN7WlsuLOzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDPBMlBHpVw9eFoPyyVBlUddbsFaaPgJ5b3MG5GuExewMjstVNu53dD4x/t1?=
 =?us-ascii?Q?bJPUkAz3XGnrlZSSHI0slilQ+nBW/1CnR0OkorWr8n7TP6YYLoDTAXmQAQY0?=
 =?us-ascii?Q?0o7iCwjxrzS/+2WjC5+azjkVOESyXEvnSFLNDvOApMS++DVyDbvuMkF5PwN2?=
 =?us-ascii?Q?ZTfSh6ZEGEEbsSzvT21W/yu/bSCj83sssAN9iQb9ILlHjScqpRtA7WIWqVQf?=
 =?us-ascii?Q?WozC880ogMnPKZ/OUFmG//oVZl8EiL+psCefx2DsDFGnqt5OTBriAyixUcLU?=
 =?us-ascii?Q?epOPGPUl8CBono5Xs8ypk20itnVj2FTuhddok+ULM5KXAGnVT9NqEoEQ6Xe2?=
 =?us-ascii?Q?IZ9tDDov9lRQn593ej4DtwGBCJU2kLJPh+4mTMRd2oNyieSF63+TDD5caMZQ?=
 =?us-ascii?Q?Yl4NdwqW8TnxctIzfQNr5rBFkpYeSq+DWhe0K3ctpRAGM/pciWMmGoud/0mN?=
 =?us-ascii?Q?ID75RWMKJ4pWRipZ7x/e7TFEvHb+nxisLTku3irPhqsyq9AH6FUPe+YH0Egk?=
 =?us-ascii?Q?0JbwSGzAgfMwouzsv67UOaOHPN87hx54/oeVFjCvkkRl8vzWQxPgYxcV1Ae9?=
 =?us-ascii?Q?bEMF8NY4hw1t9hRFFWgFafzY0f0ho8T/YJ7r2vfyhmkFrdjWaIOAHQrozgkN?=
 =?us-ascii?Q?JBO8BLPMukJ7l+9nJmh4Y6/Lkv3+6L2T9YME9w+Mc/pLetb0S2zmIREmcHWI?=
 =?us-ascii?Q?TcsMUZW3lDuIA+Og5ab8bgABsNbgZcwjbPwPejAnBMxa5Ozn5uuCQsFdWcQt?=
 =?us-ascii?Q?j4Xsw6Uueo2KfIEmimfPOIcOY6l8TOVb3+KKq3Fp1Nw9IdJeBt51yOKl+OJs?=
 =?us-ascii?Q?Uy4rkv4wApDlv84nGPTDOIzG8r1YBXGHBYWVFWpf0hs1lngoQ4VyO7w1a9H5?=
 =?us-ascii?Q?JzwuDg/Ntgtb46+XZQqt39Yec/SusuKDAWfo54c/kIXPND5W9duvbWKXyWQC?=
 =?us-ascii?Q?uC/bByANHTBa3lF6u/8r9IfYdGtLvo+oflKSZk4YCKBXZ7DwOTTovAqYnfdq?=
 =?us-ascii?Q?39RJ7Ss7G4oM8TXD1WcQNIHTFVh0gpEss9MUMJ3dQRg4Vc/BuKXoCEXtaClm?=
 =?us-ascii?Q?9pkBG5RmbcLUoHnIzWureXBoh9fzJQQVQkCQsoZGdvTKWub/h0PxEiKwnKe9?=
 =?us-ascii?Q?GfQeS2cdJ/61WajDTte3syHODflbjC6l7Xz3jnbnV0OKKBXGcmqzNiAyBP0E?=
 =?us-ascii?Q?+dm9tFbGGK90P+69PrM81PQ0DvdLl+uwmBJNAySRau3JDWXfoHgoyT4lyIEv?=
 =?us-ascii?Q?SD52wX/PWnQCDNwqgNLisqHYsuLgdrUxNxTkmfKACLA9wZUoJkix4LZFtikb?=
 =?us-ascii?Q?dE9QvTVK1S0cpajWRZlhulFbq5CaKnrG5jgnbqqya37bHGDKJWA4axWCxpgl?=
 =?us-ascii?Q?3WvZPcX40QJ13oADYq5fEMaouo/CaCx+ftc3HAnU0yVujCfHsaAzvrToh+4m?=
 =?us-ascii?Q?3XQPUwG+nCsVX+PanRJMHgX6+P70o8Ea/bZZ96vHMc5pOjkC6mKiDmWP7buc?=
 =?us-ascii?Q?uYtjAsSXcBlqz5KZkPE/BIgnLWvkVfqzEF51NFP1rMq8XtE1eEJCFIaXRQaO?=
 =?us-ascii?Q?EjamYMjKfPLyA+NFBOSXEpJNKsDlGiSZTkheQ4aPOwSsuqkpv1B9VHCXbAvu?=
 =?us-ascii?Q?0qPLOoKEvhclhY6zuoA2cFmkolCSAVRahymV2TMLsq/DF875O7ZiqWj5IdIG?=
 =?us-ascii?Q?rvrkDNYnhHsWz4K4lnjyU4K1F4XqkB38ABTHIIch7xEoqG9Fi4S/qU7XOqZR?=
 =?us-ascii?Q?LYlGZ8lGnuS6ew3u6sRolhhOAqDJXE0=3D?=
X-Exchange-RoutingPolicyChecked: T4n4Eyew8u8fwTBi+Y1A0dWpwgLqgocqHGBFvhb87iQ6XIDjL/weOvF40Ff5TA0rvQ2GTQ8jjO0jrF3ZC3N/hc088glUuOJWyQqyK9jBUVFrW+FMfvc8zdO3tHNMb3PMl4+Cmvtsf2iSBMaYfU4rR+wtwb0Ok8k4MpMjpC3SuJVL/gxKAEFyN2hLXswom0u3HDQOxzT2WVaOTud+af5B43Ht9XwSkiLgPdb7WTwEWBXJY8XJvkh6ZHdgJCjsN9CuVMy9Zgi3MC5L48QzifElRvrv/aPEVTr4aqoEPrRrLAbO/MNcTwR/oDE1T3UNq2cd2lQj/NV41Ipxn0cvCZ7JDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d20f5936-00a2-4cbe-c13c-08ded6cbffb3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 17:21:19.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hbj8Rl+ltVJFOSu7JSgg7zHzFVAXiq2Xmphlw2Rwg9yQs6heZLXxehoHh4ovKCThfN18iy4ixTYXJLuhZl+HOv5uw0HPfFvJCvBpm0ZRs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD5EE188BF
X-OriginatorOrg: intel.com

On Mon, Jun 29, 2026 at 03:10:58PM -0700, Dave Jiang wrote:
> Add a test for module paraters during module init to make sure that
> only one is activated.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c       | 20 ++++++++++++++++++++
>  tools/testing/cxl/test/hmem_test.c |  3 ++-
>  tools/testing/cxl/test/mock.h      |  2 ++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index ef92dd35e030..198a128181b9 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1827,11 +1827,31 @@ static struct attribute *cxl_acpi_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(cxl_acpi);
>  
> +static bool __init have_multiple_modparms(void)
> +{
> +	int count = 0;
> +
> +	if (interleave_arithmetic)
> +		count++;
> +	if (extended_linear_cache)
> +		count++;
> +	if (fail_autoassemble)
> +		count++;
> +	if (hmem_test)
> +		count++;
> +
> +	return count > 1;
> +}

fail_autoassemble is a modifier of hmem_test, not a standalone mode.
Needs to be dropped from above func for cxl-dax-hmem.sh to run.

Tested with this diff:
 --- a/tools/testing/cxl/test/cxl.c
  +++ b/tools/testing/cxl/test/cxl.c
  @@ -2081,8 +2081,6 @@ static bool __init have_multiple_modparms(void)
                count++;
        if (extended_linear_cache)
                count++;
  -     if (fail_autoassemble)
  -             count++;
        if (hmem_test)
                count++;
        if (type2_test)

