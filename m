Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299643F4C0;
	Mon, 20 Jul 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564775; cv=fail; b=jpvCrBPVYq5k952gQhjjT+FtskqPIufyGHA88rRE6Kw/GSsqB1ysJP95D/Na4a/4cJ0KNPidRWHC2qb5VTiRlevdYdWAGwr59IYwQCbELfuv7RKvvYdY7KCyUWT0liHnzH+u3wjmG6aO8zsPVQK4JJaujsx0ocHZT88NPHGmny0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564775; c=relaxed/simple;
	bh=G3ooKo9u7et5bFMAP0nezpMYLBjwtGraOfWjkIrUaCs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eT9mm0g8EU+sktJgc1e66fSYvJ1+acAj88TPJEUJ8bOjvVlvfYcXTzjWz5m6s7skyCO3hv5cfWk011bKu5DvVAxoy3dZMN/FOC5zvlKb0hilThtq4aa2GgxoEg7ysOnS9SvyL3HQGt/VcbMfVNFpU6FoUHS7oJt+0+DBDpocR1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvyONYJ6; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvyONYJ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564765; x=1816100765;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G3ooKo9u7et5bFMAP0nezpMYLBjwtGraOfWjkIrUaCs=;
  b=SvyONYJ6PYggdVo8TR9+3lbgKBREN0SZWgjMDCHC9nbGYVmmwtXvsjPK
   GDted98nnN5wfOpQvKIkaH6RzfURLasqNREVtlflDJBEY4ftu+7ad6bvu
   y53vyTHjMEFI3pG2xYknSNZmOt1KsJTYvwXnQJmVz+I8B47IGgnQtoHSZ
   iQGS34/VtyxwTq53fYhO92ba9TaDmRJoOeiuXDIUcn8ZOpKiJbjgSVNcA
   q42x6bUMZsibeu3l3Ir4PbUyMRFx/fz4GlbiNvhowDzgF7KmtD2MNZm3V
   KS+7axmHT2hdKhlxcVhmQVG909ync0oW74Bk/0uiy8fNt71n/a/b7x9QX
   A==;
X-CSE-ConnectionGUID: RZMIH/QVTTaG1uf3fIqZvg==
X-CSE-MsgGUID: 9xwDlujISkWeK8lNF5d1ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87689783"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87689783"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:26:01 -0700
X-CSE-ConnectionGUID: GgLZCp+4RbGQmIycf6fAIw==
X-CSE-MsgGUID: Abex7Kv8QB21tUgaqf/XAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="256316349"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:26:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:25:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:25:59 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:25:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1DPA6NEaaGTs6KiyVQKKEgo8FMF5X4Zq1USNtFmE8fNmyP5BSpKpcTAMESIaY1aNqBGer3rp+PVv/X6haxso4a/wDsSGyfmMo1X6/htqFmZ5VMskoaBvYhYo5v+Pu5gZyzUbpZ7M6qA1BIZES82MHsebBnimI+sLC/fGr2uo3M7+v1QXmmPwt4PRXhwjw8GBxLb8PHybnJCACCQV50zC8g+m3JNPH0mMQzoueUSkW8YMqzuboGVJOxzFe7dmC8v8sjDXXcoHnyHiqG1snDb+GORoSFwGi5JKaX57/rBmPsa3vt0XlJCbfCP7WfeyN5zR1lqxcu1RsDVp9JOjXSrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FSgS8G0AJGmyknsvbWftN5by5M3GUJXtbR+A6wcJiw=;
 b=oQxT1ZryvQJIMMRBOTKDfyrXLFVLpct5GxWlGF1wQ0NajdWbc4lyQn5Z+ysDZrEpmpuoKuWGSM1rGv7ZgPZQw5mKrv/M7MTWIQN1UYRtNkmGcxvB8rIBQsW98kJeirV5qtE5ctXlsjZ41aQdoGjTPZ7RS9sbCVVY1Zi9nlOdvJ4lpcoiah59Qymva9hzMhEFdADVsVKAaHSTuxmgi1pZvThqqXW/ZuEafYB3ZagdVuS3CM6nOU67WhNFz68acW6yHLLMCXMskFgArRZeLbG8qJcZf2iN0tV3wQAkCSHc12h6Ki8IppLyihm6dcrYA+qgB+uXRIUipqBYL+yrT4tY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB9157.namprd11.prod.outlook.com (2603:10b6:208:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:25:50 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:25:50 +0000
Date: Mon, 20 Jul 2026 09:25:44 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<terry.bowman@amd.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 04/10] ACPI: extlog: Avoid populating software AER
 metadata from raw hardware buffer
Message-ID: <al5MCNmIhXPpL9Xr@aschofie-mobl2.lan>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717161647.1493259-5-dave.jiang@intel.com>
X-ClientProxiedBy: SJ2P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5e9b2d-0cf7-451a-a76c-08dee67b8fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hpG7g16YMZZVdnNNHpHUUuWEVCoVOPLjeVqb2mb6uTRTegMxATlQ1NFmLAwmgXhMJtgOKrRWoq3eiKsc28TEuPlSm9pbgDf014qns4Co8+A2kBe7Rauk7g9/Pf9kWOlaBjtaoQMuF6QT6UD29w2foE9BdkvtRK6mxoYXX5TNK0itoS/IZTxzsRV3LyqHwTcbuJV3aT1tuetfKhEzF98cSfhOuNUI7qqcS31mArxfaZ2Vc/UUUna9xjcVO2F/8XTQ9wCjNVZBK4UP7f7+CcArvaP22mT7kK944Q7ynW+P0XNAlmCV6HqtcI3eMIb1dMMiEZglCGbLWOvxYUadjZmGQJjmRpCRBa3Z9U5hfK3i2Twf73TiP4Nadi+5OikgAxyUHGkQfJi6YFpyk4G0FJSDgr36FdO9okCa97E98qlosiXcPOir283h+nAd1OjtYo8+hkp+LpAstqaggKbeILAx2aPlVnxgeH0ruNO+Q9rZj3yY94QjEVs+TlaDJlGTf8WbY00iG1S3HiqYR4et0cGtwa/2/2DZzOs5EA5C+Gwf8+z49QD2+8uEOlNzCvp6WsHTUMbTker/t1CdDxtNJ5y75PMXPsVXLrtlA5hnqwndUjJP8f3cA6v5xkxyjxeBTosheNvRZEp2NiYbclWp0Pdb+qGEhd6XuKzkUjoYOn26jmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lfNshdmqHqQL3giRR25U0frA8Cvo3KCO5OFjmM3tPKWRbTm42Jju0EOk5GbZ?=
 =?us-ascii?Q?ZTH3BMnpysV8pvGnjeeJDqmz36NkFOzE+3Yhgsbi1lLW1RLvub3FMSaGfqDf?=
 =?us-ascii?Q?3btRF/Eo0POXifAEso/NHQg/sQZqjRfFhYaM7iX7svQF3LShreoDuPgifHwK?=
 =?us-ascii?Q?E7xY0fa4pqvfYZ+gqmEFqlx8wggnaVvt4pbZoj5w1woa1PmNgTuyRZ85H1xV?=
 =?us-ascii?Q?1zyJgzwEKJvyw0p4sAS1kacT8JTTbNXs7nfOSXYgy09UEC0FSICCxXlqQfRy?=
 =?us-ascii?Q?P66Vg2w2j2UvuGw7U8Bg108WErSYkuIGFhSYNK9VIIA6JWRrBsFvpkOrdhxU?=
 =?us-ascii?Q?J+g9pNmj3QalqzZ72c0RzO1g/19VPXVD1AO/PgHzpj5nQcwyVcg/2mdLZ7tw?=
 =?us-ascii?Q?B7JR2mMEAKAoyh0zTgARcKIgGpG8hoFyUYNnpMsi4rnVObQRxjnAaZgB3vSA?=
 =?us-ascii?Q?qH7uv94Wxco3BwaS1KPU9mCreMzFLqmDd29lNx//aO5xSxq/9hfNXF5RQJDt?=
 =?us-ascii?Q?yo0q4eThBTu8huFi3F1SHFPFcuckjEKt+uzZYP3WsFgv1mNgrbBkPZZkklIM?=
 =?us-ascii?Q?5oKSralpImwRpj3qjkvVBR9apaB4xjxpxYZNdpXRj3+HJJ0Oez/bteXhoukN?=
 =?us-ascii?Q?vfIqN+mmBBpJDpb/dkzC0t2zQXkwbpObXL1CGQ3J8Wqewi8EPU51tZccJ6Hx?=
 =?us-ascii?Q?gUCT8HIOGZdY4qcUhH5c8jIR4z19SdX7tk4H9etGwl2V1ueTBFOnmdcoOzuB?=
 =?us-ascii?Q?GOTr2P0XWi1/5jNeQuKEJVTVva1nhzs6EdcOtTx+MpyfORWlCHZT4Oae0FpT?=
 =?us-ascii?Q?OacLJ+dKVzQctB977UlZbU49TYblo0CInPMTVstdhi1NOzcHb/SyWiv4UhRt?=
 =?us-ascii?Q?KkksjdsUlswIIejzV6LNPOwnayar5hiJ4K0NSkwrkEKfI8aLSsVYb8GsNpwP?=
 =?us-ascii?Q?V7sXkN4/k6yEDQuyLqidnXYgzS6YqEr7CO3+dc3o865642XxraQc0b/g2fuc?=
 =?us-ascii?Q?wtjb5np17cH9u9EeTCJpmJpHRS32s84cs0jBljtYS9ca9cAaZBzeuBSvtzkK?=
 =?us-ascii?Q?cAbtSXosEBIO4YOMAXP0jrdt7i5xAJR6PxBITrVA7hJRoWltOJ9LoFUnkVKI?=
 =?us-ascii?Q?vNNEQSVBIZMD0OpDlrKlkN921Epj3OYXB31g7tIFYRuYNX+d1fmh1bM9LoP/?=
 =?us-ascii?Q?Uk3TTIxJpf7DMAqZCH/cbZsGDdVmwwcoAqVQQSaqhlU8l+UMIfCzUUVBlk2X?=
 =?us-ascii?Q?K5s4qtdgKtqXImqDQ/tSPkvIv08+QN0fphkRwtjbbyzM9+CGg1/bBHPY1wad?=
 =?us-ascii?Q?6kRCQdFj+otwThpIBdlwnoNrMzKBW+OU3EtiCmrR/qYBGbP3NuuIk3I1SVYY?=
 =?us-ascii?Q?Xa8ojgVFPX+EIOXvNkxKTefjDZlRbg7gAqkpdJsx0dX/fL8ltoAisAkusjev?=
 =?us-ascii?Q?INk9kuehyrHHJ0go9eed1azK2Q1xrjV0NF98OsegIdr818ALUqakaKjQQES+?=
 =?us-ascii?Q?oj/ulr2m6Cri/2Few3qSQux2151EmFjP9HMnzk5f6w88afHsEVxQ84EtO7kB?=
 =?us-ascii?Q?uqIv+XYh2WXxks1gZj/2zM3qufhF8+XIKsbZdRAL+oqN+T48il5yAWEhWOs9?=
 =?us-ascii?Q?98ufme+DbMQijthuGR5INGzmm2kdRvdDnzLuJ2StlCRp6rpE+N4EaxapN3R3?=
 =?us-ascii?Q?3TYI7Y1UF6eOVIPo2/hvdxvQyTW1HCvrR/++2OWwMwLZU13590B6xtlfiMgb?=
 =?us-ascii?Q?6FcU0wlCdlUNnE0PrB43aVk7CNAh798=3D?=
X-Exchange-RoutingPolicyChecked: MQ6/3QLRzxiAEfGRa7nXMymv9D8jLjmyJ962CnPFq+/i3v3HgPU/24NxfFnZFMZWiZdOdlssPnTrLRIlwQ3q87KJoGhvPmQlbutEjFg3sproEbckTl9H2/ExWAE5oSn3kWPDufEa/s5uiK6yU6GgAebSDfbaRnt7Z4Ky+uKcac5e4jDMTHO135B5ZnYVUjaPfJP/nKQP9do+oLS9S9AsWeLMLSVJg0qu07TEjlfTTUkALeE4+0sIZ9ezsv6bar4zpwAt/eAZT3tJ1v/RQDBnOvGnDYnXAKkHjJP8WHqu0QRPqxE0aD+wWEJJzFdvLU1AQzDa4trKl7EGZOCc3QpKIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5e9b2d-0cf7-451a-a76c-08dee67b8fd7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:25:50.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmMyCUjPQ/VvPr829DDRN+KsnF611BY4F4dzOAMeSqscUco5h42W+zmZhPNWYZqIMZVRTtgx8josLJmK3+ZfnNiTNciA8mrnogaO2C7bCKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9157
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:16:41AM -0700, Dave Jiang wrote:
> sashiko-bot flagged that casting the raw aer_info buffer fills
> software-only AER metadata with hardware data, driving an out-of-bounds
> read.
> 
> extlog_print_pcie() casts pcie_err->aer_info directly to struct
> aer_capability_regs *. That struct embeds struct pcie_tlp_log, whose
> software-only header_len and flit fields sit at offset 84, within the
> 96-byte aer_info buffer, so the cast fills them with raw hardware data.
> pcie_print_tlp_log() uses flit and header_len to bound a loop over the
> dw[] array, so a large header_len walks past its end.
> 
> Copy aer_info into a zeroed local struct aer_capability_regs and clear
> header_len and flit before passing it on.
> 
> Reported-by: sashiko-bot@kernel.org
> Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
> Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
