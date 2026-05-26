Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5B21771B;
	Tue, 26 May 2026 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837702; cv=fail; b=WTIM0XfQfhLjJhZcXVQ+QJT6rp4tkq22t7McR3HDpF7nxSP77L8BUggwBgg3tL8ad1uk+C2N6rwShbXcQCmw3mB7mRLG0uYoHN2tSyBMx1EWO5PRA357l0S3Dt9t4mrA3jCc1qcSAHbUQa7H8SOaWFipjjULnQOt6xZnqQKYZ64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837702; c=relaxed/simple;
	bh=6M2vc6lkYis15L9Thqd4lw2iqa6s1CIX/eKoK5Ck5ZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S1WDOkVoRek+/hb+AZ/bu9t1o2pZ9+5TZRZgmwuiIPCnrn3nByqdlRCt9H/XVMDaKNFgX88qweZx+sLZCDIztQmptAaBid7k58hDgX6eYR/hC91+E5bsX9HLvh4cL853gFXbG5eFVlwrPPMuTdzonvWdrPhaBDau6zE0fKOJHRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVtmgqX6; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVtmgqX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779837699; x=1811373699;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6M2vc6lkYis15L9Thqd4lw2iqa6s1CIX/eKoK5Ck5ZI=;
  b=DVtmgqX6L8Jdhe3cGHJkJm0E3GDtKTxCYYQx/UGFyBgu3GFNE9nvgiY5
   1E2KIDSht/zW5C70N6lNsJiGkF+oNtkwfYRi+g3jcdtNeLqnLz5Dr0HeT
   DAlF5oY/nVERXDs1RrBnr70Jq1XeXl+Ko9Zo6ueGQUOrXuR6Z/AXeICH1
   hsDCwSYhldcQGpvBr+ZQ2mGk1+yERauumKxij0skJg3SUbzd856pto5oM
   XkXR0VuC5L+BCeO8OXeQJ2uHYBjxC2nYxBeHxjh/p8KV1wjFakOBHvD9L
   TPCzOz82bg3Pgb4fGgbUjOuTdgLHe2ibFlNc2Nspktj+M1qbo0BcRLyJK
   A==;
X-CSE-ConnectionGUID: GCHHt/xaQPWo3RAMUn4dUQ==
X-CSE-MsgGUID: prhWz/63TvO+eHxiVt726Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84556165"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="84556165"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 16:21:39 -0700
X-CSE-ConnectionGUID: MkhmupXVRieEUsc2Ldjnkg==
X-CSE-MsgGUID: TxnQaWxyS5GP0eHp3tGI0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="246320970"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 16:21:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 16:21:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 16:21:38 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 16:21:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sR0u2Xq5a9tiBp1/PokTkRe8Qaw0Xw/YslH7HNvyTBefNUHLKoBaSixUMKxoao5z8ChbK9Td5dd1HLcoYnW6C/y7FVrtDv06AM5MC5yXw79ODv66bJJnjUAX4OOHDevcTLnguHEvDVBloCnDXxaDZqceG+9DNIqtIpFBowUk7xz2urtzuKzrDFiMLwLP1CLqZPoDeaoSyJzcKmttpEHoSyH+B4meBQR2dDPx+3oiF+4saut0ApkP9RvMg1vz+2HnUYSKnRdRxj15OtlxI2MJAETS3hrzJtlVAQIIYD01FeAZ+T9dbtJxbRqtMh4p6EUuz2TwiYxRmJUYlDVv0LCGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLb5+zEoDT6E7JbD0jqHN87e3IGLrtaQrseBTYRWIgs=;
 b=ZOoBBlgIOHmbTrO/ke2qlQ9nQHKMvy18D0xRLq0RAeHTEPB0ePgAnwokPYQFjnS1ZaK7e/35Cd/Suxg3gkN8VtfQDW9hYVGnnkVUmq31QsedVoSJspQglLAQBXnAYWNDbdOsFqTu+mjlTTGMSvwrne6CDc1KG9h6ZoHJYWCVK6iJfpBcapzV0KSGYn6EHlkOzb4E94os/4RlmrBOAVEHvDIYcEeUo595eJw14tc0TZCd0Ls74Kyke1aylW4BKXGpcTLEKWi3ENTOWwFBV1C/QBT0n6425UqGlHTgUhPFDSTw8A727O4eaPN/7sZ/NIQb1d/vWa2bVybrD/0/c7jtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6859.namprd11.prod.outlook.com (2603:10b6:510:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 23:21:35 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 23:21:35 +0000
Date: Tue, 26 May 2026 16:21:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.ne>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v3] cxl/test: Enforce PMD alignment for volatile mock
 regions
Message-ID: <ahYq-pJIfNWJr4TR@aschofie-mobl2.lan>
References: <20260522054457.5429-1-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260522054457.5429-1-icheng@nvidia.com>
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ffb696-49b9-46c3-c4b9-08debb7d8740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|6133799003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: JDCBDVjpcGFXRmkLKIEcI1K5fqcy4evCyAfbWTxG9hfI4wvTmmW5cjtxzyD7OzRBVSQ9F4W1WnyMG9O3QEk/65s48RO4jj8KRZ9nTZ+IaCdwGyDyfvry0Ed4ZqIQasBFukPwtX5STntD5GQNKk9aESjhSpplXncTm/4FSNOUwfNBNIEcDx908Pt1F8kVq2xKtuqhSTC/wjUlXOHAdfLB62Aos6/FGL95b92kpcETawKP1T5YKPPPQANni01nuxKulBg4M/k/HcGP9NJaU8km0bpnuNcmcX5m8N85hYR3joKnoh2igX5EPjlFHqkYTYsTiDPPW+VSQaEQlc/xMsVCbh9meBj22kQAc6Vn7mU+ihG08h58/nkFOsXE9j3nUJR9Edoe9qt+MBIrGjmPmPUuVniNuZ92v7O2QiIMOpR7dYnBM2Yeh1T8OlFgQQO1soKwbAcHMzMHCktuov/F09X2dEG3lTmHrn/mu7UnAA74pfkO9Hn2OL8xpGISnSRgQ8A7jEQRz6O0CG6H7BgZbGLQYctBfgJFrJgi71RRefz/Wl7FiBnYBtHTOXFlG07yZpRb0uGc3LaaX6/kWhjsJOl0jZLveSSnj9cQKb7+JIdi3E4fVPSJmzIXFleHiSaQ8qe2I48vyJkf1ntWiXpyFadvAN61W/fO0BozUsjHXuAKoJFgLqY7qya2VCSn+JPSzo/O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XAqzCS6EeZVeWPaUljN5Z2k55OrnnQj74jsj4eDjlL8O2DPAVsMrWFcwnPHS?=
 =?us-ascii?Q?i5YuDOkNRBVzQfaufWduuVsG0NKhS80ChsVdPsa+jdYpRoA6hpL+M7DFUFzz?=
 =?us-ascii?Q?wbKjBJQ8BO3I+7CksZNFcOW/5JZgtw6G5TBr6SOZkZvf16xiU1p7Qa2f5r7Q?=
 =?us-ascii?Q?pjpxFxH7w57rOlUoKP67hU4VRAGOWguhBtAIYghLftmdsrTH6+ANI+7zpeki?=
 =?us-ascii?Q?ReKrrDMhRMJ55ylPwLIfVezORc0loemGZFMC3jZTdX0+ntxuKjrDcoEjjWUi?=
 =?us-ascii?Q?ya1jxz4AJ453JErB0lc+2Si82GxIaWRD5/9B34m3eIaHaOZ0ZvLHqnVggMgF?=
 =?us-ascii?Q?aZxVYPtuI1WXOoTrVlLewzTRYcywj/OgBW1RdmfyIVly7w6xNmn1XbNvkr8K?=
 =?us-ascii?Q?AG6a5idw1ZTgSNIbQFmsrrOrDZgSlqUDpqPMf4JGrcu65bKXR3MVAGvZhvej?=
 =?us-ascii?Q?qsVuZglB84IDnMy6P8wQkGtIBFlW4iei0GpokOsq51LIqx3eAMyJg0W+rApX?=
 =?us-ascii?Q?BW9OdynXDt3C+Ok8CaifadFBhcPvQqGkPkcj7G+eDzT4FO8Y2lrELrY28iC0?=
 =?us-ascii?Q?skcHaELHVdT3lAw3UgaLL8C1+4uumc64zZfnCpn9POT8DnQL2tId0bapCUjZ?=
 =?us-ascii?Q?9b1zinCET6qdMJLJIj8PMIiQ5cPE69YjCO4Si5p02UqvpwdWB659DIF6XDfC?=
 =?us-ascii?Q?bv33dE8P/IYI7abY3WV64Y0+5pa3UdoZ59XRfhM0ElbG5PU6DIlpiF0dqjy8?=
 =?us-ascii?Q?61wx7jWFUSRqiGs3KeAJ6fKCQG6g5/GBSbZNs+M7OK1qD6gZwLx3PWwX04Wg?=
 =?us-ascii?Q?udKj04AM3HsA+tNztVoAI72xvlKzAaAJgIKrGTHo41sY7c36DkSAHXhE9csQ?=
 =?us-ascii?Q?IpKCgFTmzzM/STSL4ja3NhYCwtpF7mcKrQundE1zni/YFtfuzKvQ0KIXVQnB?=
 =?us-ascii?Q?rf3ELnBV6PWf6q/HJHZm94fcW9zHpmJWfNhKldRPNQKuP/Y/qAKKhJmUu9Wb?=
 =?us-ascii?Q?jr0mgRQAFzahhDCotp+7jpj66ExbEAfC4PXM5P3ey23iLhHaaDTbP3yyG7zm?=
 =?us-ascii?Q?OR/wG2ma3O0NVf0tOtHAwHTYBOO6xbWZf/M1rboc65ovA7LDzG0YMJa+ZgPw?=
 =?us-ascii?Q?/H8nYayr4Zw+JeB6efcBq2BC8GHmzjOgEe/E1xS/PSCsBoS06PmY8kuNHJI6?=
 =?us-ascii?Q?iLfuqB7RQfofL7/lCmPpCcd/YGVlTFiOvbeq0aCcFF44HOhpoL8ILOfAz/nw?=
 =?us-ascii?Q?o7cEtUElasLUbK/ph69fjNscE8oBsM0zZ7rbDrn15h6YTACBfqhfjQ/liDEX?=
 =?us-ascii?Q?oZPAgM1eD/kQ3dc2tyIxjt2YFTIq4gkGUdKiIScj2u4yVLzV57ZjCw+F25ez?=
 =?us-ascii?Q?lsXnkvQpCvguMbYFhWPyp+SwxKGMWvePUmf4WFvQjb0kFV1ysrTly/eWDLUT?=
 =?us-ascii?Q?AiVhOo4H09L4icTbxVzmw8RMjKo3otqYS8LXn7DwY7Czg19Dr/ERxChl5Snd?=
 =?us-ascii?Q?g2lQGYKaJA6IJ9q6VDQYp06rGKQM+hH9vKexKa023pJxwpIUUn92ER8A/zfi?=
 =?us-ascii?Q?y5Wgh8l0b2MM0/b9KobdVXItTh6rZvq79d3UWrGUsBwFOxSnrg0jr+HAt5vj?=
 =?us-ascii?Q?Ar+t+2YwZ6gX0DmwoS4gUlE1MMi94n45N79LUQo4htrbTXJtbrt3BNdO3DAd?=
 =?us-ascii?Q?okwX2HachSp/kCUq3MWlNhg3QtStH6dR/xBpluYCjpMt1ekHJdSFcrrLiaBg?=
 =?us-ascii?Q?mlUCZzUn6Wcw+LC7YNAzFj2PGeEOe+s=3D?=
X-Exchange-RoutingPolicyChecked: AUVBCTE+hogpV76rdcJh/u+1rzkXS2/T7nEk9+brGRNux7Ya0SmpyI1B2wFuNrHSvZC52tAjYwTloNfk7/e6ONd6z3HeWoiLrZrYUyvhJxDQdLudYDFw/OQ8V60pUpaNUPXfIWdt68t8UwQgrk/l5I2o8NMcdf4dE7U9tnXGtlnEuAYvRCuO4sdwgUCi+KYtlUEbyC6HSrQGOt5g4tl7jacu1mBAoT4ysiwtwy28Vk6rzHH2sJzSY3zpd26fohaf1tZ6GcHwiIfsYfxXiCzzL3DRwzCvaWomD5fKZYDyVE3Uue3vWn6oIb3WiAOdIqMOJvT6rL+NY1+vf8JOx/XG8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ffb696-49b9-46c3-c4b9-08debb7d8740
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 23:21:34.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToDfyJI1wHAQx3x7YMjIHTUZ0Wu+MVoR4ssKbSql5gveOoLU9v1kHf2rwpHucOS4LdmbB7lJ+pUNDUoGG6VLwPT9Y/Z36S/75v7GHzi7WsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6859
X-OriginatorOrg: intel.com

On Fri, May 22, 2026 at 01:44:57PM +0800, Richard Cheng wrote:
> cxl_test allocates synthetic CFMWS HPA windows from a gen_pool with
> SZ_256M alignment. On arm64 with CONFIG_ARM64_64K_PAGES=y and
> CONFIG_PGTABLE_LEVELS=3, PMD_SIZE is 512M, so every CXL region carved
> from a volatile window inherits a non-PMD-aligned start, and
> cxl_dax_region_probe() -> alloc_dax_region() fails:
> 
> """
>     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
>                                 with error -12
> """
> 
> Enforce that every volatile mock CFMWS is PMD-aligned in both start and
> size
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
> 
> v2->v3:
>     - Correct hunk headers
>     - Add base commit SHA
> 
> v1->v2:
>     - Reframe from "fix start alignment" to "enforce PMD invariant for
>       volatile CFMWS"
>     - Bump cfmws5.window_size to max(SZ_256M, PMD_SIZE)
>     - Gate populate_cedt() alignment on
>       ACPI_CEDT_CFMWS_RESTRICT_VOLATILE so PMEM windows stay at SZ_256M
>     - Add BUILD_BUG_ON for MOCK_AUTO_REGION_SIZE_DEFAULT v.s. PMD_SIZE
>       in cxl_test_init()
> 
> Best regards,
> Richard Cheng.
> ---
>  tools/testing/cxl/test/cxl.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..7a1105f9a0bb 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -318,7 +318,7 @@ static struct {
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
> -			.window_size = SZ_256M,
> +			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,

Why not this: max_t(resource_size_t, SZ_256M, PMD_SIZE)


>  		},
>  		.target = { 3 },
>  	},
> @@ -495,9 +495,12 @@ static int populate_cedt(void)
>  
>  	for (i = cfmws_start; i <= cfmws_end; i++) {
>  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> +		int align = SZ_256M;
>  
>  		cfmws_elc_update(window, i);
> -		res = alloc_mock_res(window->window_size, SZ_256M);
> +		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> +			align = max_t(int, SZ_256M, PMD_SIZE);
> +		res = alloc_mock_res(window->window_size, align);
>  		if (!res)
>  			return -ENOMEM;
>  		window->base_hpa = res->range.start;
> @@ -1826,6 +1829,8 @@ static __init int cxl_test_init(void)
>  	int rc, i;
>  	struct range mappable;
>  
> +	BUILD_BUG_ON(!IS_ALIGNED(MOCK_AUTO_REGION_SIZE_DEFAULT, PMD_SIZE));

The rule we need to enforce is tha the actual auto region size is
PMD aligned, not the default definition. So I think this needs to
be a runtime check of IS_ALIGNED(mock_auto_region_size, PMD_SIZE).

-- Alison

> +
>  	cxl_acpi_test();
>  	cxl_core_test();
>  	cxl_mem_test();
> 
> base-commit: 6779b50faa562e6cca1aa6a4649a4d764c6c7e28
> -- 
> 2.43.0
> 
