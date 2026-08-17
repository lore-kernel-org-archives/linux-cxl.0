Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705ED34A797;
	Mon, 17 Aug 2026 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008734; cv=fail; b=Ilvo226d+IFNr9FtDSLPBNF9razwjBrboj8boUxuh2nD2CorIVl4ttpFmgeizirc6GOI3b514TFrbpUO1sIZcK1ssm53gt6RcS7OaOrVpJM2W/fTHQsBaXB0NhsOQbKIcBECMH3sWV7/+sw0jGG3ZrHh8PqnUkMz5mBET0asQr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008734; c=relaxed/simple;
	bh=xHGRhM8q6/+fR6yyxCVeqz0p/OnS5PpMBp0vsE5Z0C4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zf3LUAVQ8f8wxvvPcrVQFlSX4obpahbUALwW5WoFlcNLH17+vxCtVOYVe6COKDyql3jl5FtXWQjvQgXq+mu8bvmx6vSf0pezxBxjiDpl8CDAOxrBt6sttr7ecP6YirOce/dSLvvkWtAtHkqMsth1YUY1LFsgJUQ0DPjB2nKwm9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bngUeQJu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bngUeQJu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787008732; x=1818544732;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xHGRhM8q6/+fR6yyxCVeqz0p/OnS5PpMBp0vsE5Z0C4=;
  b=bngUeQJuUBW9xr0wXe78msv+CeYGuxrh5BFk6UodW7EDdMHH4WRSSQzA
   U75D2a29LPg4UHvovCz8YymCp9gkEy3ahDXOXnwjq1Ut/nlZCXUkbsX2u
   UeXTyHQgwaNgl2S9U07r6rL2nixIso3Lopx1UT/bKUS75LbeIYKnDB6fY
   C/B3RFu1kpYTVL/X0x6aCRX8yZLchk/sGVue1BAh727XrY2aiFagfi4f9
   QHsyjZmn5Z6CrYnSzy/jPPZiD7mYVT3uhkdgXAGKA+NL05imNCJG1w2Dk
   qkoT0mtN7o8yKIQysQ3LOGCR3rs77LSfhtaylTt5GaRDRmRtabl/XcTol
   w==;
X-CSE-ConnectionGUID: ZQ3hbVsySsqrfenvaQP2HQ==
X-CSE-MsgGUID: fI+AjcO2Txq7ndITPl58Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="105026513"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="105026513"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 16:18:51 -0700
X-CSE-ConnectionGUID: CTIeiFq4Q7eygqf6lnDx7A==
X-CSE-MsgGUID: 3L69ffeFQnS/31YT4B4h9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="303283876"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 16:18:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 16:18:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 16:18:51 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 16:18:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtCMWz1+UIFZ7kjUBo99nYo9wfAD3HL/OF8Fp4hm1ruBs5hkXak94JrdI0NQ6RJN7P0fduxOGadk39W5b1b3CxnWyHrqufL4mgybQaXiWUFGXrbgaQXnOyBlEyfD5Sa2cBQwVpZNRrK5AwXutsPSqKyIW4exo9YFFirRLy0MDMgm4T2e+cbEj5C38BPYHgMibFdviIUMPeU32HohOvz1UM+5V/Yal6D7KNASO635K4T6xoCtlEiMCoSDtogwW3TCB2PPSOoVbnuTaZXyyLaJc5MMWnLHcfSMNwbtrJ/OzmoiqwargFZjHYeUySOwQlC5j3t7iDU2u1Gvv0QHeiKyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sl4T7fLpoU6+iVd9JOvsTHtiGO71lvr2nYSpCkYsEA=;
 b=QQAySh0rEQU0dfjKvkB4JL6U+Qv6eAG11EsmOQWPeGuATSFuX0qOTUUGTek8cG3+zY7y0BW2APjRMlpgmgaH//cqpPwNhT/IzOhEncbgfbReQjia+k3OJFrMY6AGRB/LffF2hB1uqJpfdLdFuhs9TIhSNcsO5z/AAi5AmkqqVWGuKdXVYQX+FTYZSr+C03dEiAkUGCxepRqGW4Qq88N7ZGRAvoGglADMW5SfuZqbvfrKzsyxgYD+lWHP34zOidmQKQHGq0SF2dhfp7gybgS6dM8mvzI0X+55EIJLY3leNZ3iJSOJc5f76wBejStLFJeWWXkyawn9K5u2yNM6CAbWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW3PR11MB4713.namprd11.prod.outlook.com (2603:10b6:303:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 23:18:48 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 23:18:48 +0000
Date: Mon, 17 Aug 2026 16:18:44 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH] tools/testing/cxl: Don't wrap cxl_core's own exported
 symbols
Message-ID: <aoOW1EaV1a-POHaP@aschofie-mobl2.lan>
References: <20260721084009.38100-1-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260721084009.38100-1-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:a03:331::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW3PR11MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: dfededd4-8eb3-4196-0cda-08defcb5e469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3sA65T6HuMxVoNx1tQyCpSr5C8KgHg+y2YCOT1d/qCyyx5IyyejMKQWt3gsO/QMvrpl4xwrmXLHGCkJeK+BMh8nGtQVwzrb3kdjVVSC6qUeyZZSSYkhFgDPzEqA+LPqG7jgKXXl//VFfh4YG5EQ/uFNb70IfMQuo3VumI7DfSe+LgjnJj57ztPDWmAkavrr+yo38HH/vezgaXR8OLfMvvvmorl3wQhyZAJtzQbMa8lmd3AV/5AyeUcd6ErKcQ/a4ZSUAOMsaYLpfn9HwUSJrtPBB+3Ngjcx0cAZP2iaK4zOcXwBZo3TU5hsh7N+CFOZGtqw/Fs9EYtRKVpBZq7HE/CEU9w8CwEktHR9gMWsfOoSg9CRlVP3jVxrHkoXB0mCu6bldg1hnUO0tuYj4ZvRa4BUR+X8X/mW8CMlvHRUQBISCqigkGWp1vx36sO8JEFWwYxsIGkjcXM91Saagp6A7U5O12itPskCYHxZgLqI6rh+5UTPnGWYfSueup/wZkL7VSS/y7BtEUJIR4hcsoCW/EhwuyDWXzuXqqil58vrRmgspID4ZoKIJHcK0Vqcbrdqw7SSGfRYOMuxDk2OSXhLIFOwTIq4WCakGPhzSjohbuvcWrjvUFYRuj6fM5zjrBgFLTDA874qQRTUsXEymnLpmj2asUif6Ow9P2sc1ZkeGt0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XPEt8YvXJgjtCwRiLwKLVRDJGdFG4NNZkw2qOO60jwnKq4vGcU56TGXFMuW5?=
 =?us-ascii?Q?uLDD0zX1Q2N7KdxTMtHNNQj5lMhdzgchcPtClpWlAwLyb046YWKwoQPGLA+3?=
 =?us-ascii?Q?vmH+CqiswyppnpSuIf82WDg9XukPg5EgWrI7OgZHcM1rxRqGXm1DPGaEVrTw?=
 =?us-ascii?Q?aPkr0HP5eB30A9nXnM7xPsvWipUdVnx8S943luDEiuOstNWP7OJZuDHCUg2i?=
 =?us-ascii?Q?3Dkz2UgnIZRWIxn12cb9U2Bh/L9YN9mXKlRljmJ3SgF0ovS84yPR1cNCv6s1?=
 =?us-ascii?Q?tr3HQkn0miXAvQiw8uoUwea0HBPVIEvQWZmjK1zhNhnMspDfC9muC8bAZbm9?=
 =?us-ascii?Q?nW6qTSqvDuLMDa1VB7dUZ6cDQh1mYR7AZIJ6bfbiENHBZ1nGZRjf+gXvMSuR?=
 =?us-ascii?Q?NgUGXmYNvw78AzB1F3oEK7+rzVQiZbyWGAd5ON43yKOuapTF/PYrktWjNIAS?=
 =?us-ascii?Q?K+12uF2sNrvse/FoK+q6X0YHJBN1vxTwWRP/Uv4vZ4AOHWn6fj3vm+ex5STQ?=
 =?us-ascii?Q?A3wx3YvtfY8tSH6VRJWcnEfEMPO52NysCIAf2C+oGpQWjg2nyp3prTCEf/zp?=
 =?us-ascii?Q?kPaIjDtUzXLQOgKXovCJn2mCHfJNmFRCL9LMTY2JiJmNa0G5PcOLPzGJ2zYq?=
 =?us-ascii?Q?hXCTbA3VFJtjWzx55Wdycruls3U0Fjn227td39Yp3dFfzB7/rZR2Sg9b7jLl?=
 =?us-ascii?Q?jnWMwhAU011TN2XF0ap+CXr2TBN2MsubgfdyJnhxrNq7OvsNEQlB1PwaCPG5?=
 =?us-ascii?Q?5/ygzDtIDJImI2tZqmCeYLYV9/Pyaizo0bNwgzLa8pWfK8bTEvNiKy08mhb/?=
 =?us-ascii?Q?seD4hrbe9Gak71+d/kg6Mhgt+NiYggyjfjVz4XKJujiElYWPfStBRb20RNlS?=
 =?us-ascii?Q?j3NTPnNmSZyZQ6AmvfY7Sr9sdnKtTUZLF/3gJSn/bPj4dDLLmQhHlk4QPlHQ?=
 =?us-ascii?Q?u7dBbnarzYNKPfHpnxDufMMWkKV9nQa9edcFOn9fA4iO9rmOzZh1e4xX3N8H?=
 =?us-ascii?Q?Rgivmfj/+WhL5K1RFxTfIQN0pxhnFSCr6utchm+/yQLxR7i1vQgOs2o/1wro?=
 =?us-ascii?Q?2Qv08bpe802/AsaM6CEBOPiD2iPTfPevhV+BljK9WR2vyURZvvdzYMe0jKvT?=
 =?us-ascii?Q?AaeuKd2uL1RnWq92OJNyxuwLdIDZ2w7oxYhNBBk2Db/y8M7bMe/E2nmk5+uc?=
 =?us-ascii?Q?hd3/XU1aFEOHcQ0utZ/ZLiglkb9VW+nyIzFdpAkQ3m7tTuKnLQN7CX4GGEJR?=
 =?us-ascii?Q?30Kn9caMzaajfVBFz5aMNCrbyXvX9DM2GBy6N0PmHOH53zJKZXY0LEKJD54s?=
 =?us-ascii?Q?CsrCTHsRrM1HCzSgLjivHScFUA0NpQPccQChD8C3nMAUlYso1nHlE/aeD7pN?=
 =?us-ascii?Q?6cDLZX14GKYn0/w3YGpLoq+pwkXCfNG7ZHokcAbx8eTf4EncFSgM2D2Q2cyI?=
 =?us-ascii?Q?FygIX5lAibpjIXC0aqbSRNi/vV/9mEPYIIrKyhhtcSPi4PevqDKa4XucW3Pf?=
 =?us-ascii?Q?XN17qPu0PijAYPT0R1yCwVGSW/L98IIrZC2euDDUUAx7/Kgq/i7LPBpnPAaz?=
 =?us-ascii?Q?qrB2DIw8Rl8MXO1d8xLN4lrmgxYmewkQIZJ2grKpkHZD6NwkfiHjPZSSdlzM?=
 =?us-ascii?Q?ChRiV32uyboQHMxd4fCtf6wxNows43Skzu0u4EvdK6I5YkGfG5KhHiFifqFp?=
 =?us-ascii?Q?cnVmJOPMK1Ba1Rd1WOJ+pjY9o3QiAVZiilU4Q+TWGpc/uPEjs96LPn7am0wp?=
 =?us-ascii?Q?IbxrM5BUbbcikyZrjozkqj+p0Ouz+Dw=3D?=
X-Exchange-RoutingPolicyChecked: KJeAKpjKIZKf1+uhLnznvmzYyzlDA3lqKn6WeMkMLZKAylds+fhfVD+xq/OlEgfR+b+JqnipObatq/DVkFW0K3OKuA2uni+0bFzxcYzsBLU2gqjR7sLGlO2xrOzAIDrioAK4Ph4pmcd3MPiPeT3cq9WtBl0/zrDa8FiYT1F9cSeeTR9wH+u281fWmMIXCJc1+jYV3M1jy6VrJhvUpaXQ1fhQ3mbrWPSdRchZ1CJIL3BbnF4sSjpZsGua3zzrQnKzSa/MQwk6BfuQ2+JFpeszKPxDsf/2Ifrh0W07uqXKfvippX3674yg9vvMUn5HsWAwb9/2Ttx7XSYKPTlCx0bLNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dfededd4-8eb3-4196-0cda-08defcb5e469
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 23:18:48.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGBz29u3MwT3NYy4bDokzFUP2PWtAnzSXQ6cXv2gcb2p3FmXmTskrSUQjll2DUrvhv6xd85KSNB+g9YSJibARjQUTRMFSrSEoOFlq9la23U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4713
X-OriginatorOrg: intel.com

On Tue, Jul 21, 2026 at 04:40:09PM +0800, Richard Cheng wrote:
> Building cxl_test with LLVM=1 (ld.lld) fails in modpost:
> 
> """
>   cxl_core: .export_symbol section references '__wrap_...', but it
>   does not seem to be an export symbol
> """
> 
> cxl_test --wraps 6 symbols that cxl_core both defines and exports.
> GNU ld only wraps undefined references, but ld.lld also redirects
> references to defined symbols, so cxl_core's own EXPORT_SYMBOL entries
> get rewritten to __wrap_* and modpost rejects them.
> 
> cxl_core never calls these symbols, so wrap them only in the caller
> modules via LDFLAGS_<module>.o instead of the global ldflags-y.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
