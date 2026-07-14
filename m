Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541C381E9E
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996665; cv=fail; b=p4UlSEVPmWHYb5YsojqKbaBFZruNsGDEQpuGRs9T5t5n7wZIfna82MAdm9dzHv1nGWIpHQt6XTpodwmeWmiN3qMjNfds063iSJ4JMTB+bRAScgGMhu/3jgk00y2I4tY9xG4DfBdD7KFHNoB0pTAs3qVcw97b4xr7zpJcxxSI0vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996665; c=relaxed/simple;
	bh=f8FGgK6iSb+kk9dGeEylAxUguuV1KhZ8ICt+MGfdFmw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tB9OG6W3qXDKONVkl1/gbgnEI9GQ2Vb1F8pUBowGoSzYSOxd5gbbaURAtK36tOKl7b/VQphZ/8GjxaDXzdNdjhcKcONjH54EyYKJTRuqhlCNMxAH30KjH11+dEp2yc7emxdoYfnjN6iuV9tO+kLM9+D+/i6KrOVGQ3rXy+DWxrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0cDYhzf; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0cDYhzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783996662; x=1815532662;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f8FGgK6iSb+kk9dGeEylAxUguuV1KhZ8ICt+MGfdFmw=;
  b=X0cDYhzfs4xhw403CUL18zeAND+rg7NBwBOWPqvAduxXBWmXUidaSxwE
   KNQ290fhJAMPtMrwAwok+m99wBoIcwTLzqwEYdiv9pD0x7h9mPdKVM2Sa
   U55kvAIRu5IsDErWLmiG4t3g+7ornfP/63kjeYote5HaKKa1MgHE6BH5m
   O4X/L8Tn4ZJrU6g3v0xdqkfJb1yCIUoL05HY3HNvrpiiNvyXkB35qURu/
   OJhzbO5wWwBnQXzDNWVFcDJv0oqIKBwvMsBLclIH2TD3bt0zAM1ioPZDf
   Wq3cC7Zz53z/yMSFHNubWUjlFR1QHefrEkez+lCVurFroJqVHqKGOtHlq
   Q==;
X-CSE-ConnectionGUID: T/XQWugKRbWB0BQm1ayh+A==
X-CSE-MsgGUID: gXFEdDo6R2SJY6P2VrpMuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88511199"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88511199"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 19:37:42 -0700
X-CSE-ConnectionGUID: s9w9v4AfQEm2342U9kWJAg==
X-CSE-MsgGUID: V2OhA7yOTIe2tuqh4Yu4Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="257676197"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 19:37:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 19:37:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 19:37:41 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 19:37:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtqEUd4KczMzpHrAuTpBswOIKylYD8AfbD52qTj20lnuPnQpE+bDjmZfB9fFXx5o2SLIInFrNmcMQ6ORJ+fIyYgV3oO1lZuaooC0HyLgP1E8gCHtzQU2TbO8yAcWu1Ah/BVPFPu32nbE9IpErRyxxkkwXprQBcNKHLSg4c/iu1zQ6//eNDaC9dEcu4HzaN/iGVUCgXvPww4IRQVxnnoJZYniCe/YGFw0fxjhl6HXYfIo0dub4v4Va54QzgEaP3mBwqbKZHezXUk911/qmClAb6JIEpsP7BSdMTYZw9jbAzaFytyiWHdbnTl7Pup45XdL/G1mnZDjSsOUmuHjm1Bm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjx1RsuX5Z8j/0k153YEiIT1QY1Iv5BR9NDMCtvU1zg=;
 b=ue9rvTylsH66cJ+4vjgXz2cjxMOCPz8TwrB8MBAzjaGfojn96Mjgxb3CwAWm00RO2lQ4RBe36flQcyzQzCf+UaCC1ezlfRl1fsXubYufueOHsZzNnP5juiCQXiqr0pVqKndDEHbPu1pS5cHFXBl35LRaJ7R+N77rAaULfrfuZZBtgHW/uzBBXTai7vzbs7GyRC8FWE+OUzbvbpzB1Wie50SnGsHyIKnr20nqCOIsAaF9SZ25nzipojhwaklSsyPYjupL9Rii6iLKL9jNvBZbiJeOnItU9VibNoPC95ab3PrPNFgtkPeRL2J42DZli53bKPlTUZaWkUwpl8NFtEFL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 02:37:30 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:37:30 +0000
Date: Mon, 13 Jul 2026 19:37:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH] cxl/mbox: Break poison list loop on an empty payload
Message-ID: <alWg5q2CGP1ljJri@aschofie-mobl2.lan>
References: <20260709155714.1893280-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709155714.1893280-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: f58eee29-a7c5-465d-538c-08dee150d985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|6133799003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FOlm+zi7RECnMv8Xye3vP0X7Jn07AoKZI4pkI5i9vobJ3TnIzhPHPOGBPM3EqckOK4yB3ki3sXPVYcTlRTvWjBJag49oSoGQdM00ytvCNGwa4lr22vpCCjVU17508j1lBeNtv665Eorm7sVo/YFyQ9ko00C0xbLHVhE725TKvU5Dyv3/UiME2ilVgN3o3Is9g7Rlrwqs54iVFEUJaVOnp2Ohfyz1yeSHaeCCdea58bh7+SrvVZWJm4IpWtt7Q6GzrUNVUvpPxShwSpHI853fESaGOVE8DdJsIFLbveI3Kb0AxmfCEovDQSjf9FQVR+D21Wuy/6F8DPnRGNBF37ad4lXbzNv8duhKP/qL/YcDtEjkbENOn368gC6RVny23zIJARC0b8oPJiyKC7FUdbCn+Hal2+8njdreVGhRQxh6NCDKa9qmfQ6c94tgZVUhjgd/PnebKLyP4/uMUJvORQRKacz1AiubTrgccPRLIh13H9kcMtE25jFubOxRbZ9/FhegDifWn5jBEU27l5S8icSwT7aQeiYpUdK9BynWx2tmWnFDbiW2br1DPZl59AVUQxIPM4dBavXikQXn/HioioKVQM5tgSbCINcvWNE/2qEQVcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(6133799003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OUkSQXoYy84BpHY5vg7EZdMSXs2sGu3+MScJEBnW/n5WJD3aq0pQWA2a9MVH?=
 =?us-ascii?Q?pbVHkmrQLArJt22pIlQf5Ar8tk9B2WRnzAzmKv0oNYGigRF8UYKCd9qZLtAs?=
 =?us-ascii?Q?oFKjDAVdD3gTaJ4YIQGsKDgcZWIsRd2E6vs8z1HwIF6jrhSJ6f4rc67bMSxv?=
 =?us-ascii?Q?pP00HTn/glEZNZm2Wi28X5G/zvzYBS5dka/w9E5T160fdYrbhVOty8IKKjPC?=
 =?us-ascii?Q?5yuu0NjZi6iZ1Jb+okPUJa9aaSbnewQWXVnsd/3Jnn13ip2Of3F/mE0mIHN+?=
 =?us-ascii?Q?kM8iHgl4wyGc9jDB0m5CULlOl6P6jF2pQjnHgIqVFvWUUMjfz9Kzlu/JFOkF?=
 =?us-ascii?Q?gQLBFz2zLcYxTaPo3AlBCqPIRk62gE40zz5ZIuSYUGjyZm+fXl+f9ll2b2/u?=
 =?us-ascii?Q?+fkBsmXV6bl01hflVGN1yyEBzgX0ypPd2Cf3tD5wpgaXIbbNCjRArkCrud3q?=
 =?us-ascii?Q?87dQBHHqrJavLNfzAMwYt7j9ar11Nchkjo19oAuYfsh6yQF3v+jI/E+8upzB?=
 =?us-ascii?Q?SM4UgQeHFLxbQD4iBTqXGqCeQj6Q+HcTUUmC89h9TA2VySSjmQKaG+XwFeEM?=
 =?us-ascii?Q?XA8+YKMrVOyPhj5M37/MQdrhgvfUjCDsPihOfRAOCnLlp6TAp8YtdOSO5Ovo?=
 =?us-ascii?Q?CB/CHgjsB/og3p3TpeJ2XXk7FaHMJSN/5TkmxBje7zkyB0C8fbnRNl9fwig/?=
 =?us-ascii?Q?v1BRnrGClrQ1qy6MiHbBAhpmnuOIUs2PdnwPNo8iuctq4kypmYYXa6gVaVuU?=
 =?us-ascii?Q?vmuBJgmTLTR9+xftJYKHUL3N2iZy12zJ8eygRk/yHuDUz7uLC9MNzZSIa1H3?=
 =?us-ascii?Q?+hIHtWJaVwwmOYzLSicGrDXtCttutREr2aQMLTnX1PaGDf+nQc0ARFk2hZ3i?=
 =?us-ascii?Q?oeQKiYqJhjs8w+K6LHV8vnrCE0MR9r5kTyWmAzo696hHybWP84WMUWwoco7n?=
 =?us-ascii?Q?ZN660YtqHbAxxUSViuggJqoGHNsRoPFmGSyLSYzU0nE5u908E1c1dWTLIUw+?=
 =?us-ascii?Q?C5Qc0d+gtEUU+fp3VsI/Pl2VDjdtG1xY9mIWjAH7E6x9J8pcLLTkWDN6pjxt?=
 =?us-ascii?Q?OeqnB+P3Yrk0JQC3gk9czjiMMxbLQ/mTeYLUQCG6jUdHN7C0ZOptbQBumc/a?=
 =?us-ascii?Q?MAQQUrfUNs73bdEx8K0NEp4lYNMGQn+VymAWnhhTxGlrfedL66zh6wSPxI4g?=
 =?us-ascii?Q?m/B897apHQSkyFwt7+G2j7N1zfS6aFels23524QLfm1KxZGfpgLhKwpRUPE7?=
 =?us-ascii?Q?Fm493NDJ0xSFPrzukmHgAttH9HnHqTJXA0gI5Can/fuvwg/GQ5AzKLIEeA08?=
 =?us-ascii?Q?aM9EP3wsWtd8doPwl92LAWtLMcG4LlGO/ySu3ktxonye0dVURgo6VOH1Qm+h?=
 =?us-ascii?Q?IJAyrvdzH1N4l68OKm2NkRV5bgPTXnvKY6ULDsC04LI6YtkOBBU8NOwnaChf?=
 =?us-ascii?Q?Df/ORI2eKUelEMLofyrJG8q2nhEcM4MyWN9iP3FbvGfU7zVJBtgf/JmHM9sf?=
 =?us-ascii?Q?g5BVIcvBadrky3Z2Q3eqmUe5QmbPSdoU9hRGLSoZvAZo2hqUc2g2VgLKu6u+?=
 =?us-ascii?Q?QI7h8u4nLuL158e7q2hMeBQ8rRklC3wiO9yDkH86bxNDmjxBLjzKKOXMGHtw?=
 =?us-ascii?Q?8He4pkfNjZ6+h0nQMOJ4wD56h8k+yFu0e44+BaE+3INebY46kgzC4TfZlkMo?=
 =?us-ascii?Q?gYZVFqDv7SE/pTYXK5wRexewCIVgccM7moyHD49tiia2CllfEVEBGPQDQchz?=
 =?us-ascii?Q?03rkAymPnebIYqg4IxluMoY4zeO3oo0=3D?=
X-Exchange-RoutingPolicyChecked: o97BS4sNk3oFMn4KNwuM5bpC4G2NIy/HmQhjv3PJemMCMAFplHV7fryNBv0ilU3g7WKezrYYHhvksMOtbkbIohfeL4EkKpnyjAWn+e9UePanQY01btzgJnpwXRbJxm0m/ixU5fnxiYE0sHyegeR/pxq0t0teApvWIUijgqw500swQyXylAcCcPdVHmW6iCcntmBLJ1aujt33ftr39VADNI/t7wcA+oNWfyRyYTsb4ZTaoSrPAm+vsxpHfKK4aq0kl7Djjb352BjflOZtoFvDUWAMdA5+7ja+0OTGRHea4vcGm+55nDNccpmTmFutRzCBHJ3Huzj0UcYaHKG/QazezQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f58eee29-a7c5-465d-538c-08dee150d985
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:37:29.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBf7r7/6oRKEW512IPxZxwxPGD2klU7kh5VG2VCOhIKF9lOLHY+9EWGnRfJF5VOdiNNWllQOndLwcw9vM5SA07osOyj3EMtmlN0H+hbK604=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com

On Thu, Jul 09, 2026 at 08:57:14AM -0700, Dave Jiang wrote:
> A device that returns count == 0 with CXL_POISON_FLAG_MORE set on every
> iteration never advances nr_records, so the max_errors guard never
> trips and the do/while loops forever while holding poison.mutex. That
> hangs the sysfs-triggered scan thread and blocks all subsequent poison
> operations on the device. The existing "Protect against an uncleared
> _FLAG_MORE" guard was intended to bound a misbehaving device but does
> not cover the count == 0 case.
> 
> Stop the loop on an empty payload so a malfunctioning or malicious
> device cannot wedge the poison scan.


I'm guessing Sashiko's new pre-existing complaint will appear as
a new patch in the future, so for this one, let's get it merged:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Link: https://sashiko.dev/#/patchset/20260702090849.47501-1-icheng@nvidia.com?part=3
> Fixes: ed83f7ca398b ("cxl/mbox: Add GET_POISON_LIST mailbox command")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..c09fae2cae9f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1455,6 +1455,11 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		if (rc)
>  			break;
>  
> +		if (!le16_to_cpu(po->count)) {
> +			dev_dbg(&cxlmd->dev, "Poison empty payload!\n");
> +			break;
> +		}
> +
>  		for (int i = 0; i < le16_to_cpu(po->count); i++)
>  			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
>  					 po->flags, po->overflow_ts,
> 
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> -- 
> 2.54.0
> 
