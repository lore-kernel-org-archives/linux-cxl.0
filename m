Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B6217F5F
	for <linux-cxl@vger.kernel.org>; Fri, 25 Oct 2024 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892536; cv=fail; b=tf5Xv5gLE1cGzu0NlZ3cyTwOQH11lENg7k81mrVLaEDWVcQj/1vQyuCimfmxxKGKbejdMza4UYSAgvjQrMNNQr2rSR/PNlamKNm8y0zDEoU6bL8rSTKrdagJ57Np1/Ox+/iYfZ4BHyapVjcyPk7/kqEe30tzl28LYZ9aLqx7zQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892536; c=relaxed/simple;
	bh=qYUgHpeyJLxrJXFlipqWLqmUrrymFCme+inh2Ip2FsE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QG6pKV0ZJx2KsaR0a3p/m7U8jR8Uwhhq+ax491WaJDXWjmu6G6oQ7xnmaVkUNZQEgnwoG18h1LmgL5yJUg69xPCpsXGBOIj3WwF1D5e7eBgrkCMfeSZYYg0Ei8uLR9uQh9VTP0xBWIgX4XpqCMz+Mx0VcTdXlARYM/f679MvuU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFQs/uf/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFQs/uf/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729892534; x=1761428534;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qYUgHpeyJLxrJXFlipqWLqmUrrymFCme+inh2Ip2FsE=;
  b=GFQs/uf/ROTlTff7EGAxX2bw7OS064CX2VIETV4vRDPb9XvDC1nn7AJi
   EXCgQZs9X1XhzLbRxTfY6Z7ti0SD739739fMacgyiI2HZAmdsGFB3u5fm
   0ex4ICEYJXJF0YoOFaIqiBaQLN/IprBKQTf0ow+9EBVjUb9LBWmzm/mQg
   rMhtl0Tr94UkzPPGV6r7AaoTQJqIoMwnlABkJS6X0nGwM8JhcCQY0iANu
   lBbR9ZBqBOgoCV1snsKHz3MdDB5lGjbJfYCgz68RUOeZv5Fpg+KCbN7B3
   F+cbSfHsgVWTO0LukutCUs4RHhXxzUxQ0SFuNxkBCMkSfBx6tcpmNSYgx
   g==;
X-CSE-ConnectionGUID: ROPD/IAUT+2e77AZHs9ZUQ==
X-CSE-MsgGUID: pRMg2UPFSD2+4u4g323fbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29749684"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29749684"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 14:42:13 -0700
X-CSE-ConnectionGUID: Hkcz+sh0RpqcSZ9dYCXGaA==
X-CSE-MsgGUID: 2gl0umkCTZaCbRcJv9hNMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="118499991"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 14:42:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:42:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 14:42:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 14:42:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fU5aRioYIkz1+Vqs+4+vEcCxzD/1Dufh9CivOB4W5mO1tZeu0SL9PUAnj4S2ZJxMar/hcwROJ94fR4d36Ky9B2fYTXe+kyGZmphdD4A0IIC8UbuXq2Mjktyg6tQkSmKeWakdGQrlVXSxCPsNTcgGBIbIPlKi+YhRpunVw9XPRfu7H/loOnrVHOubJ7t5+9ScOaJJdHpInwkFSEqaCngtJF5w5dM+Sjly/6a6zBoVIzeJb67xq7ttxtqOd2+UZZf/FM9bxNtWBW7D/PfYRbcyOyHpxi+DpRuJqQ2XqvJVAekLoBaQvRG1BNpDvMVTwYWzYszQGPMs6EqvZUTeo19BmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lLm8yRYrmCjJjHUkjhk1CBG7oFsvRgiEjTf6RH0f6w=;
 b=aIKawbIuhPPI9qkqvnrB+xFRB7N2Eww5nzq+qF+gQ72pruysejoXlmrcoXtyYJeXWFkchqiqHJabqmhrU0LjVceSWybJpP7/qNHwy+f8TgqVf+gQ14kiXQhkBrG2IK+HGnMUytNq435bM4k8qvVpnT9HlpNlOA8o5X7H1jyTouJYBL3gFF887xb7ek3hsqEwKfRePfBu3hqIYgp4FnEfvXPBb0N45CCclUCeyY53nOaDH5R9wwiacL2LPq9ancIPdqQ02ikRtF8mHbzeddCi2/uUvjiGTOM3Z5B60WAq0cgwF80HVcyW4VMVS7JoxOSavc4nTbiI/g0NqSRAeYQOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.19; Fri, 25 Oct 2024 21:42:09 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 21:42:09 +0000
Date: Fri, 25 Oct 2024 14:42:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: Why does cxl zero-label command fail on my QEMU CXL environment?
Message-ID: <671c10af9a6f2_10e5929496@dwillia2-xfh.jf.intel.com.notmuch>
References: <TYRPR01MB123355935A2E90A320934E3ED90432@TYRPR01MB12335.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYRPR01MB123355935A2E90A320934E3ED90432@TYRPR01MB12335.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:303:b6::10) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DS7PR11MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 295ec977-40de-456f-95ec-08dcf53de0f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M9UCD4Qr3aT2O2ydSahM1VDXYkRSMTvYFQbL0SEsgrYelABUrFaiRNLaku3I?=
 =?us-ascii?Q?9lGuyEGws9Dt5MC6UX2Txmcek/VnXLvJgXJG01WM3piS8nmcf89cRxbpUIK5?=
 =?us-ascii?Q?wI3UebfJm5Rr+SaYlwBe8PkFEL3RFonG63HRlmUU+XlL4dOH/JCUIESUlOwt?=
 =?us-ascii?Q?SuehbdNxvSqtlpLIUlTOdVdx5OLL3sYEmcFurgD66DzC8S8ZiKMlT2WMaUyS?=
 =?us-ascii?Q?PPFNxmVy3kg1pn0mKaKQ/6H+31A/vfLRRK5vGfqK2L9mwmsXr6jDrBOybwtY?=
 =?us-ascii?Q?HaArx+lwZy/ZqCCg82c8If6UrWs9KtJMYkpd5fJ9oqBK99rm6U0n8FxvRnFB?=
 =?us-ascii?Q?vUjMhtWTdtCJhVZLlY1B1TtryPdJl5ovMBsq5ZwUcrV+uwsHdzLMbbG7DwJj?=
 =?us-ascii?Q?GfTiXNh/4bikdYO8j6b2O0u16+NMVOMXjP2PGoEW7t+joY2wvDAjAeuc6IYG?=
 =?us-ascii?Q?AYoyzloIexGjlmlv/uMLFLAvzwVdOIFSGkGecQilQZ2BDkyPpjqtCXVM8fNZ?=
 =?us-ascii?Q?T3qr5od1954EmeFTJE2mxsy62C063iJG5jr89ezgFSsmCfj71Vd734R0eNxc?=
 =?us-ascii?Q?p75beC2hLG0McKypYNUKGm9ls3dD67FEq74M6tBUI0NCXKEOGpZ9zLYjXs0N?=
 =?us-ascii?Q?GwB3nvGC4X4hF3n8oL47xKgoeQNtsh0v0eqrGgbZe8dxEEMqm6hEgwxsJXp1?=
 =?us-ascii?Q?pW1bzkncCH0jkcLmVmBUQ+mofsdn2h2rZSfVQdeaK8k0vN8WpjvEHRJ6tvNo?=
 =?us-ascii?Q?8x8wRjJh7vugx/y1MuWiXVUyi8TELKVB8WqL4hbK/MH0ABBBS4ucyFrOZQEo?=
 =?us-ascii?Q?xycvAsjCcyQucxxSkRctOxMcMBGmLS7ZpLGXAALNMWVrz0PkVPQQe1ToBBZv?=
 =?us-ascii?Q?/LdAntyY9WGM5Xd5AXmRTiyYMiWxR6ILcuE9tdrGH/tNhNKf8C1AvsAoHclP?=
 =?us-ascii?Q?BMYrFbNFsOyfVEpuvfTNFy8bHIfcQJ/j8tc0a9R07CnzTzqY/JH1EnYm63Rd?=
 =?us-ascii?Q?ycV94K7ARztezi+aIUjgP7MtQwrMBJT/FCfmnFL+Sg5JOD8w87p8vChCJ2GO?=
 =?us-ascii?Q?ffptATCOiLddLbOacK3gHCbk8VpVxwQrPeOtFJQsi/tT7nQWEsYI8JOMRcOf?=
 =?us-ascii?Q?SpQiW5FGBpuJAOlM4RHk9IMSDpY1wEkUpuyH8iCSdhhTpvSo4ukw7DNDgZR8?=
 =?us-ascii?Q?+DwLYnmMnxXvIB3j34PQuZOOszeNU5AF8950t2ltsvZ/7N2+TjTq0wxJWzuz?=
 =?us-ascii?Q?/Dn2T05U9ovaHHkHfL8fAmF28oDlLm/uOp/krfWPq7vFfynQVnL67TD9IXy1?=
 =?us-ascii?Q?XuRe6H+C5GtXX6x3KHLcJ4Lu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?33tmzgjWjfi8QAOIGgZ/KceM9Tuay5MWM2qapkLUofCLwgdy548z0aOoDy9/?=
 =?us-ascii?Q?bcNXDFrnixTH2UDdlGzPFt5EohvBFMqJv6odr2Csqcy7galaXEl8Fp2J+S8J?=
 =?us-ascii?Q?KHWk/87GNMRFbZknykrA+zbJElnHsSLCr6ZrzmFEOh8QAoYs0msRgTbH2kqz?=
 =?us-ascii?Q?SMTlme+QvB4C0F2FjBt86Nfl1LhhXyLmOReYOPH8Zx8oXYyEI1hH+UQ+E2l0?=
 =?us-ascii?Q?XfNBOfmHqIqjDbHVCCG+cKalFNDA4ZEANxaGBIqB9DyEoDJ3bOM75rsbUD0Y?=
 =?us-ascii?Q?3iWsnqPfAmdwEUw+JKbe0kjYnhezNZm6emLwXQRdqLyD9MZvMwZOOZtOSfdD?=
 =?us-ascii?Q?QcdX/n2AnA9jk7Q73P4yx5qN0rBwiLSKvEJ/ujR7Tzikw3yRubMSMzU6BzCd?=
 =?us-ascii?Q?ELOcE09/tLpT1eIddKSMPwXOhhdpnnhmlPO1ae1Ke4xZ0mL+S8bMrPTAWb7/?=
 =?us-ascii?Q?Ttm7/CJDT/2+LEfXsRFJhOGkND6PpDaEk/DF37zDKkK4Yrv/pQvGm+jnLWz+?=
 =?us-ascii?Q?haj/YdfXEqBiXCQ7WTiYI0+vFOm5ipS/Y9WirH2+0aUVJMT1sFq0xKjoKFEY?=
 =?us-ascii?Q?oPk+2WJWkUcHl3pR1UioGQb7BZbN+beamd5oVyi/vMqVE2EGDpwrl69JKTb9?=
 =?us-ascii?Q?kau616B16quG/AbQrTLCbGinyo+3vyDIyk3+3RKAPFocSD/GTzzKuEyNcboM?=
 =?us-ascii?Q?S/pwIxL2AbpGmYpuMCAQw/Sj5rrM0jfFXJo6Sk+2yj5y5aVIyLhEV7+XXYlx?=
 =?us-ascii?Q?hlOTrD9ytabG1jM0h9ifuBKJGXLBnxIp5k92c5YyWK+S2vzSmonQDBl7HU5s?=
 =?us-ascii?Q?PXgQPdbPNJVIhxclPhsIhstnsznXoe/IGe4cYjXc6P4wjZaq/ZKOquZpvQx6?=
 =?us-ascii?Q?fK0kN0pl2UNGpcyPzxTnRKhhvPNDF6F4WFmqd1N3fbR2h3IdHEkQHpVqjRuy?=
 =?us-ascii?Q?0q3c2w1cG/h/xgpotlaDnjf3atwfPW7oFIIU0fvxgE9fzfWOiX+bPRU1QqqN?=
 =?us-ascii?Q?Luy3tdq3U55beMPfywE5VbZQCRAVm1SQ9fCTjWUrMYFGbsg1SEL/ksRJ/Wky?=
 =?us-ascii?Q?FkllzPl5abaBpTv15Yr7+RVGfujrXx8xixfsLQdeuu+ZjXIUac9ZvMtUmlp9?=
 =?us-ascii?Q?Skl21utS/MQXW+QMH0JFhU0NqaJrIoTjTsbyNX8d1ECmhgsDgRYz2OwULKeT?=
 =?us-ascii?Q?ErYpnWwX1bRppif5Vgf5+/CvYrDLcUlvlpGtXP2MSqhA0Rc4uLaJvQ3B8zDN?=
 =?us-ascii?Q?PRJU8UNbEc760d2yvYsZ6USJNgXNQd8omtkq+HQyRVIhn/9EFBtNo1u0iigN?=
 =?us-ascii?Q?KgPTVvrcf6o6gO6ib5/hWKAuajphdo4zxmaK39TAXJ5u4QmZCm0aFlLffxJy?=
 =?us-ascii?Q?IZ4+lgWhu4dyTuI9zt1vvXAKnEyvdEO65l55Mi2j907/wmdQ4C8Sc6ppX2fk?=
 =?us-ascii?Q?G8Jr169mW++4mgHlrEbVoPUbRdGpnbDivuxXe+waGPoYmLnJbLDjdTgiNi12?=
 =?us-ascii?Q?/cOqH6dNHjpvWGSH6+2zcCAKQVw/BxFcUBH1xktLm7vLrLc4W2ilpbEZjp63?=
 =?us-ascii?Q?SrX4TK7ZCG3vy42/QG603gpWDqkgZRenQ/H7rOzQqffIfJ/nItnOBgZgrf7c?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 295ec977-40de-456f-95ec-08dcf53de0f6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:42:09.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iy3Rzpflqq/J6YE2fiwNh/jhNhgvrZ/39JJzfVCnoEVBXIfqPKiIMiY2BoGMmi94IBArEWQhFRAQVJ272sTqWYOxRFppu079jxlnN/ixUrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5966
X-OriginatorOrg: intel.com

Yasunori Gotou (Fujitsu) wrote:
> Hello,
> 
> I'm trying to execute the cxl zero-labels command for a CXL persistent memory
> on my QEMU CXL emulation environment, but it fails with the following error.
> ----
> # cxl zero-labels mem0
> cxl memdev: action_zero: mem0: has active nvdimm bridge, abort label write
> cxl memdev: cmd_zero_labels: zeroed 0 mem
> ----
> 
> In constrast, ndctl zero-labels seems to work correctly.
> 
> ----
> # ndctl zero-labels nmem0
> zeroed 1 nmem
> ----
> 
> Can anyone identify the problem?

This is "by design". Once the memdev has been registered with the NVDIMM
subsystem then the expectation is that label space belongs to the NVDIMM
side where it can be coordinated with namespace management. The ability
to write labels from the CXL side is mostly a debug facility, not a
provisioning flow.

This is also enforced by the cxl_pmem driver where it disables direct
submission of CXL commands to write the label area since the NVDIMM
subsystem is in control:

cxl_pmem_init():
        set_bit(CXL_MEM_COMMAND_ID_SET_SHUTDOWN_STATE, exclusive_cmds);
        set_bit(CXL_MEM_COMMAND_ID_SET_LSA, exclusive_cmds);

cxl_nvdimm_probe():

        set_exclusive_cxl_commands(mds, exclusive_cmds);
	...
        set_bit(NDD_LABELING, &flags);
        set_bit(NDD_REGISTER_SYNC, &flags);
        set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask); 
        set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
        set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
        nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
                                 cxl_dimm_attribute_groups, flags,
                                 cmd_mask, 0, NULL, cxl_nvd->dev_id,
                                 cxl_security_ops, NULL);
