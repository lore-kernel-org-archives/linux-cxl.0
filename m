Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE74DBD65
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693045; cv=fail; b=VQfrBC/sL7oWporFBaLzXwtup6pV3JfVBWGrjGbfkSF7mSjUzcYditbtWge2PfdQ15sydiTgEOupT674hO5QwHeEtmczVVjV1CsHzhUjnm7X/ixFYy7j0pXJnxupsXR74+6hocOoRoT64YswohRqwsknjucNgx07xmcvgohloE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693045; c=relaxed/simple;
	bh=zhHrDX4yV25/yc6HH84pYnvwU/L+PWpeKuSPHFJC5Cs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pCmFtVZWIMxDE7OGLM9tRWPbuWlAVwhciAFh/0EvIzWxtkj+XDlRZeKl/DB44RS2segBBSmwfnxqgs+zRg8tCERan27S90VNO1wnJTJDjH10jBQHCHlkEYUjlxELJhjqeY7h3mt+mAi859hRDKWzsPbD9doN6ZWjXEGxw3SKnQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hr6lwj7H; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hr6lwj7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778693043; x=1810229043;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zhHrDX4yV25/yc6HH84pYnvwU/L+PWpeKuSPHFJC5Cs=;
  b=hr6lwj7HmtLogQpPbaofN/sjSD1pLTQWfTTBiUN7n9cUGxCGhhLIKz6v
   d+nUn5kSLlaw6SLgvFmOFLvXNdjsWQkS/9wo3UqwsRzsvSoDajvWC/U/Y
   /huE92ikxxfrmZSClIvCY3qv1AM3bngTwUrPHcF3jkZLl9+Z6km2XKqx/
   mEBUzy3fImedTFxK3NsE45MI2Ovq8LYWAfYDhE6ckHG7bSyTpt5Tz00rz
   hKJKStN6tdQJH90aM3beFLdyhJgLjdj/Mx7HOWCyF4dRpoTwiknAru4Hk
   VTMBQVgaZ+HVm64M+wnOxDy5OPDoyjMesbspcJ1PxrLEKdKufyrsUSv5S
   g==;
X-CSE-ConnectionGUID: MKg4yct7SLKa72ByoZzngA==
X-CSE-MsgGUID: 77kNCzU8RJqwjGaB6oZaQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="67159425"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="67159425"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:24:01 -0700
X-CSE-ConnectionGUID: NLhDgVcpSty+1JdtL+0+Ew==
X-CSE-MsgGUID: Jl1pf9AnSsaTLgOVYy0WHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="261649246"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:24:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 10:24:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 10:24:01 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 10:23:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILEoFGcqV89tGxCHFhLSm8AGppHxC06/34GSvMveu3qDhy8/xQ8K/b0pJ6VZg7VAFI5EzyIB1VGZZ+YRUcjjc4vhbspAb5e3HDFnFp2Ibfg0cuBL4lTe5ZNCDG+pmlXSQqk5xNVJqHl6yVn1xoqiIpHgpky0owAFuu4vKQ8RldMH+ROMNmHX8nV3RnNowlAcDo2fTMeX8iRxJksJsrtlwyVOWnkyFc6BF3/+nyefkhy+b/Wro+BX3K9jhzjGXxTuy9xfiklMltXkcI7N8XXByBYbmBbg7eNTqrqEBCvrWDA73bMHQ2Dms5kOoI6i2npWcHJ2WhJbLgMx2uHFOy05NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9olnEoIT1+55jUOwJMGNBnoyuiNQ89EDZOT2FUnI/6w=;
 b=lWH7IYRUxf0Npg71mvyIg7ZMrn6toWHrIubjg4IQCtWXR7c/bFcZTNQFXoRDAmEEZovl8dSkZxZ44uB13CTqIQ9agks5gj00VgJuLMaNNbdo86aNhjWY6gROk33U6n4sCd007Btc+wt83RLEXdakF5wijH6/Gu2lS8r3Gxd/CLQ3kMZEYWGY+vxhT4YJjHaQ/qwgfW5ghtxEhsYRYjS0HsBCGrJSO3xoMB/SX1mAl1g3qs6oC1GkyE/z1ro+hCjtWfsyyXSMQV3BaFK7Lyg+ZJPN8+2Rzpj2TPV218FVJMnyOeQjLBYZO+VhBxcfMC3AxOMoexmj1r9JcKFT7jobKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPF1611BC49E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::812) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 17:23:57 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 17:23:57 +0000
Date: Wed, 13 May 2026 10:23:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Davidlohr Bueso" <daves@stgolabs.net>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v26 7/8] cxl: Avoid dax creation for accelerators
Message-ID: <agSzpfQZmbNOMkc2@aschofie-mobl2.lan>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-8-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423180528.17166-8-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BYAPR21CA0012.namprd21.prod.outlook.com
 (2603:10b6:a03:114::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPF1611BC49E:EE_
X-MS-Office365-Filtering-Correlation-Id: fd368b0b-71cb-4830-a6ff-08deb1146a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|11063799003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: BhxrsUKCvsnKgVi9nPhh7OAc+lxjeZ82rbAU1BNYiRmSdGuLbo8cYyR2h7JS/Lb1rXR4PzMbyy8y/lHbWZjFEy/k6qdVvBf7J3j1DFfKOhnvDAcDVc+8l2vq3fiTLpmLu30Qnxp1Y02Xgh7iBZMOUO5QKlvmTlnA6fdRKrBBPFw6n7sp5SpFrbyZhCKWWHcbF59Z7EqTBzfH/C0Xj3gXWOgN2FgP70oB3uc17kzooCckadB7kkJvaJOvhx242yK9Y7SshVCCMrwadXq3SQTipSiWPEXV4vENnzYKzLHVmJaHDe2C8SgOzZSZT0bH9PknUPu7m2/eZL1SFj9v58X748s0FCpt7N8omUwcjXd/17nC37Pv+sSI3pUBUKkoHpvihE1aLiXYvRg6H4sosjfxQXV070MGHTdS3wJlrwdArbrhV5ZTr3+aFMsQYj0BlN5wp0abPlpWY86fu5HzoJkJ66hiRLowOwmKPIaSprW8/iuUO5Ocx09O35lV8JOvfW6L9H4ipD1yiTeG9JPsermMon5UVR3xmHj2e2kx7W9kdVokEsfBNiV21ZqLZtVbn+PA5Cs49WZihknJu+SPw5H2HJx0aFP3vrAVEefqlidpitaePLH5QPav6twdhPR01gjY8doDKG+v9hoCWIPEReC1kv5E2USdurqk90f8+vJPyyQgx+pcm405eVcz+Nmw3KOA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(11063799003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7TnZPqtCXjBWn7zvy19nUwZYNg+auz0yBa4xNBmYBWrGUNl6Q6uFmZGEJUa?=
 =?us-ascii?Q?WhWJCZ4lMbjOefxK76SHIjK2s5rvnhH9Yp5MwHrWe/tKgy1skFbUssez4g9m?=
 =?us-ascii?Q?Ap++upwi9dgF2ghUXwwH7t3Xfvt9f4Pobv0GuDh2DKIxgp7HRrQBEM6bs40/?=
 =?us-ascii?Q?REIJoWKXb8y0cGj4GJCiRa/o/8kLeTIOUfnwg8svqLNo3fZfz/IYtkXOi0hf?=
 =?us-ascii?Q?XY4+Kd7nrW3Fko8M4q8uWHQIvQ500sd/GxDWhNI7HR/xPmER1zHLY3z+PArW?=
 =?us-ascii?Q?GAqb21t8t+NfW4gkqOu1z4HzoQ5Z9+AqUADNXkyBHdsXPk/7Ik7QPsnXQeTl?=
 =?us-ascii?Q?IG5WTxkGClyVUmL8XbVZu89/2bWCthQRgBobLwfKOMayz3ZpQrZjbN0xA53g?=
 =?us-ascii?Q?qoOfbyww+U3Ni0+7z93rew2Swx/YJJNzfp9K8ngMW5CYRFSdHeuj1LQrqMwA?=
 =?us-ascii?Q?ZP+oIbBC4DV+wjQxeR8nVonmKfLbP1+iuGwSNhfenCJGxs+vZq4lsB6lfnys?=
 =?us-ascii?Q?aghphjBud4HWJ+8EwdGUwMXJHLlGIZs1TINyivfuveOL76vm72F1t5flZyfF?=
 =?us-ascii?Q?6r/CLubHcJVWDQG193d87PcSinsu6Ns3AwH5qTFhEy1JOKXP7CqGDbBLhT5R?=
 =?us-ascii?Q?6zPdv2mRLGuWpwx7JwShEd5Z1xKfIPTQYut4dXgihs1J9gvaVercoudNJQhp?=
 =?us-ascii?Q?lg29GA/d8e0aI00bS6ZnjrgdEq+Cx8VfiORg2REKFEvGCYrBA1Ax+ivdoJBc?=
 =?us-ascii?Q?7Ad/17109QaZLY2gLybwur9F+oGctSbkPJWp20zkvK179GVmxqKnLy9Al9/K?=
 =?us-ascii?Q?aN3EHAP/u+HxC6OwpXiLfuOFnzV6DFs0gqNk5Nd4/lWi9HJOKNLr94nkTENR?=
 =?us-ascii?Q?vVFXfrzcJV2AvtKvWkADskGDqfqpegUZBLKzlKH4wG1p8axVE98hUPrnzF/u?=
 =?us-ascii?Q?b7TXKt4LMNHEjjIHOUjyGHvg0VwGfCwEdT90sXHUEdZ+GMopk2bX737zsYXm?=
 =?us-ascii?Q?CbJMlAKht1eCnexzQWTm1mRK/PTBtO960jpFCAppTTZQeJ2MtFFXtQT2WKuW?=
 =?us-ascii?Q?OJnIo0ciSNwcfYnu/jFlNSDqocZq1RoKg6iDqHooZOCoEHzOmAx8Aji9CfMU?=
 =?us-ascii?Q?O9YXu0V+5l3M2dI4k1dUDidKlwKJv9Dh1Fs6XUOwYRjRQbYuYLqyOG4h3Pdz?=
 =?us-ascii?Q?XDYqif2ISQJJFfDaCmwOq+Ec2qe0XFvCd8876DYB/LQWc3nZFt4DH6MMFui3?=
 =?us-ascii?Q?OhyvJTXhhaS6AVToQL8wzNnzy5uoxPYq4WXtU78aMhZdaq83VsM7YWUG4tv9?=
 =?us-ascii?Q?EjtDZnFNg2tvpQumdw7qqUyVJKPGtNRPiDDs9TJUJMZf2rnn3Csc63LjU71q?=
 =?us-ascii?Q?pMkpm9w247Y+oeR4XrMhiSnTAO303ZaU7aC63BMkhMKLmgQB21GcaboW+r+u?=
 =?us-ascii?Q?Ebtua+Pw8huY3CG/dkrteEXWj581fytgHD5b3idn7Pqc3vSu8K6VJblGAp9i?=
 =?us-ascii?Q?f9DI8VAH5TM14C/HKvQhNdFZ99Y/KZtoDYqumJ3pa60YiCSc+cXAEH8oLcfc?=
 =?us-ascii?Q?3mReABxN/kLrjEA4Gl36tZd/Rb3e6pq0AJMmPGII09Ts+V19i50iZJKI0Ioj?=
 =?us-ascii?Q?/eCsJuUIXVasFuK52jGxsdwcFj9ecLEX8QSHal2J6mCn/uLklZ/QSVEC94zd?=
 =?us-ascii?Q?McrE44Tfw2tABgrJAnfjU3T4qIc1XcaP9Y5acyPlMYMCDvofwt3MuYwmJLv4?=
 =?us-ascii?Q?TBtr1BKKHWZRDnsrkfsF1iz8SqVZqI8=3D?=
X-Exchange-RoutingPolicyChecked: sA8pIPBhvE4SRKTozkNFZsDHoGoGsq1FMEu6FlqVKSoENZsWAohshaGQGjLiKuLOmIGvGZmveyxvv4X17aozWcnVd7nfh4n1uT7NFFSicnqqGUS6rXS7FzRQyo+nNhV4ZgobqHDrKWKq4P82/8QlKXHzFGKzUDsTqFzQW1bOuRnvwTnGi3wo2duqasPORw/xsSuJ/op/iDfiiHJFGjFdSzUxxEeU4sNRGeCkNjaZ5Aif0KKtjQKCZ79NyRxuw4llnCrUlEjst1umg3NUBlIo675dxLQmaApM0O3IBCxgaqup1lnML4OZl8bs9siFwv67iBMBNsITNmj/MvMAp8UxWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd368b0b-71cb-4830-a6ff-08deb1146a01
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:23:57.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGD45Lz2VHMvAtYrgTglbO0X0/HpftkkqY8grJTdi7gEiFMR7xV2y1yLO2osLQmAr/apBuuQ9hDocdD1piRDXY4rGkzJEwK7Obio6MZ8uJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1611BC49E
X-OriginatorOrg: intel.com

On Thu, Apr 23, 2026 at 07:05:27PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses like DAX.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 68f5a1fd1b1c..3af2aed6c6f1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4165,6 +4165,13 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
> +	 * Skip device-dax registration.
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM)
> +		return 0;
> +

This decision is now made twice in cxl_region_probe(). This one above,
and another one later in the function as added by Dan's incremental:
	cxl/region: Introduce cxl_memdev_attach_region

If the intent is only to avoid dax registration, then the later one
is placed better. If the intent is different, then the commit message
and comment need updating to explain its placement.


>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> -- 
> 2.34.1
> 
> 
