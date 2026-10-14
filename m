Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928D37A84A
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 05:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791955652; cv=fail; b=MSI/B1+Q2jw2nCBM0zELGXFDU+qVjZEusxXQ4IFOHNoEzv16b7jhe00CEQ7AakS6YEJWj7o6Hiis7Xp2UeuJU3xSKHA/Eh3WMf7R+Zc7gBqrmOOmlpsPjNyosY0ozD5BMHgrWXTOL59ZLBII4y2Fsl2P5EY/mQ70VrlzSvQX2yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791955652; c=relaxed/simple;
	bh=IN9pql4LYuyXIFdh0RCwv8ReAJVOYgmomr0ljf8ZPWA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NIMnfdWr0G6Fb6g1OTMChlrhwpGXotVSTKRi9raIsDXLLIfgQfebjE7sugebLSL8aDHTyFj1wlE3ONs7JgS2KS+outYYMmKJDa2d8XJU1EmB51r27H2yHAw926N1JadGL3fy8brL5Nl+SML3VVu2ttJjpoungxaxtcdYWS3dk18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9kFXd7p; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9kFXd7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791955650; x=1823491650;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IN9pql4LYuyXIFdh0RCwv8ReAJVOYgmomr0ljf8ZPWA=;
  b=N9kFXd7pingH+BjtjIKSn03SoSNg46YSZ6ovcMm6c1UQEO71B4Viv6xk
   0PWoYIbw03ZhCrJ/0hL0bOWqWJyT136azMVJ/cwRT6IKHc7hbk+wNabue
   DubTDUjMd5IqjmCWAaaXDVeL6GcCQKQD7xDuehLw2Af3IxwzWLoKE0ehV
   OOZKuF3bQs5PH+DpmftcTODc43f9BgM/aVNKVGFEWwSmEo1Z/mVd7lTbj
   tqbJ4f/Wte8xYsE2koz8LaUQK/FgI2E06dIdV8PcUVOpPJ/RQ0UWs0lpQ
   dOYY6HgPM7XXZ6vllUZD5BCI22PfC9lYGZwJZFRpeGB6PXfkzyOVCFIBQ
   Q==;
X-CSE-ConnectionGUID: XQ5JCR9XTQqkYau5G50TsQ==
X-CSE-MsgGUID: IRdGwaDOSYqdMxfTeSUALw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="593492"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="593492"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 22:27:29 -0700
X-CSE-ConnectionGUID: GYCQ68BrT8OxFVdKsSFhjg==
X-CSE-MsgGUID: JeaTjn7sQEuAS2aOfxYucQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1300305"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 22:27:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 22:27:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 22:27:28 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 22:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQ+UWtKL6LDaP62NoeEt6LJxbjJlWqz1d4wiEDD64jz/BDcaL5wZWEuKjLLoSsEWT9Ij41pfiimnXM+mU7ZkNe2zkWOA68FXce2dqqb5VoMcWaOlvjYflPpFgap/oeYjhlsz9MWYSE6UQV4EmzBYhV4nLsYMXGyNWZtj60b6yAhuLRi0zS06pwx+2aHDEsSO84sEwTsojri+BGp262nCKTzH+aacLEJjiHijfnPJ0b74AdztFHsqVQBHlhKXc9r3opGFZLCsSchELphZET0xAaP6m80ny/60+zDYCvZ10dBtFvvYCgM0/UgPLYdoFPjcSuAtC3Ou6xh+t0HMc26f+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrA5LtJ+IO0tjqBEZFLDRhsNWJWbjeZ9w0ZZ8A/Q7Hs=;
 b=HgCQRydU7hxOzl1C0GDAZYTtC6kV2sUzYsll54S1vJr8w6jJx93kfDrZAIjr5xrQtC8IwqSrPZr3BsLh6w2yIQcV4fkaM4vP34PQLN9hNmXBY+zI8zdWF9eaBSJSlLNnu+AlVL9gEmnGO5hgvEpTizopN5xNTC1UqH5ehzUeJpNhrTt3r/LXAy0vcVjBITYBRNI2IwR0AI6qKDbaasU99knpsBeKMccBGGqus8bygG74VTyiPwDV3XrpCVtQaSjoYPKIP6+kDhKiC7oPaPHvqTPt79QVDbvcEKPcG1oFcQe+22tTX6hRahbKinj8gOHZcek2gO9KO8bdt47UrEicJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB8198.namprd11.prod.outlook.com (2603:10b6:208:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 05:27:26 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 05:27:25 +0000
Date: Tue, 13 Oct 2026 22:27:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Richard Cheng <icheng@nvidia.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v8 3/4] cxl/region: Start unmapped poison scan at the
 committed decoder boundary
Message-ID: <as8StBu5tupammk1@aschofie-mobl2.lan>
References: <20260922101129.52794-1-icheng@nvidia.com>
 <20260922101129.52794-4-icheng@nvidia.com>
 <20260922103000.88A861F00893@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922103000.88A861F00893@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fbf702-ba7e-43d4-a67e-08df29b3d48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|5023799004|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: upPU1Sf91vXiwe4IUNabkLbxgtN0oF9apRtbHhWqjkx90j/7/RPWxaznUH0yNMRg5GoGLzM5D67ZIT5fBVBJ0ErYNYFgIEMvwYrQJZzI9YorBG7UVUTk1DbBG/qbCqPJX5jXxkndhd7XLGcgpt0lv4e5wrHXptuLn0owXdtbgsmHlH9pZZ8ArH2e33iydtMBbsXyI7nRt/H7dw77zCzaGPLXRA7TfvdR/0cnq5ggKJYQNkWe+55WzuLb176TG27c/qw+XRNWcrEZBvFLVtWT3V3Yxq9vn9lddm2Ce0BU5vNX/ErbeFGnHCPO9Nau6Jz4y1KL6JDgb0SmQBeaBQ1UDeSmFjoC1PDoa4sPwHe/AlCQEQM9ve2dz2pYikJfejfbr4aeIwufVJUrknsBwQau9S8GugZcfA0MyikKbDu12eb6Z3xs7RMBxubjiqM3m+MxnDFSw5zuDNLOYvzZhqKGqsRV/f+EVTRz+L0o9yopL0kJSidJL/xWjJ23gx4IeXnugUgYOUwbkbxfQ+O367hI83EnnHHSnRB4DuEdOK6iDIKbZxo1+K1ZMKBr9hmS3vOdihlx3itdzZinDGOTBDlGzRhStOsmHj0HVG7j3oyuOKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(5023799004)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gXUx1Gg3oCdQ12TM7WBR9hJv3QBn4hmtSUcLzGWqvwBcK/eNssJGhJ+hEC?=
 =?iso-8859-1?Q?XE0lSgp9wEfEQ7+h84jFFTmRrMKB3St660oDjCWwnzbmGhLvkyxbbZie7d?=
 =?iso-8859-1?Q?ee6s/+vWyHe+mDXpkTRD0tB5A0tsoZKclud145S/XM3vX6TE8uYj9bcS7j?=
 =?iso-8859-1?Q?uhuwE2LPgfYn5zgb9AHvCUMJRGHnIKPpQPGHMwcP6p/b+rWx858UKqGlHI?=
 =?iso-8859-1?Q?etyjHAm1HdoEahAKU89qT3hdX1/C9RDqqF53u57F+xTUgBQxkjmOHXQCmT?=
 =?iso-8859-1?Q?ZJsnDKKONOPgV3Fh8y/cyh1233hio8d0uiNN1+wJm9ENJont8GoGsMiQo0?=
 =?iso-8859-1?Q?8oFS7WcQ1JhTciko40RlFtpJ2XgozGgv5UBTFu5m72JSBDDQtyVlagtSgE?=
 =?iso-8859-1?Q?vY8FuuSwtCzHCB0Qy//y1ap1iZ8gmOjsPTuLXSzb/eEKnLcNeScs9ZP8JF?=
 =?iso-8859-1?Q?HzV8f8i4wrL1h7gb3jOjnankwWLg2ZRP4cPLQkbj1aW2NLDd8um+rrAeVt?=
 =?iso-8859-1?Q?M+IYThRv3eT+DefGyt1uRvVIOIExwuxCfL1jFMLieF4hR7fNlvSSxxHUIr?=
 =?iso-8859-1?Q?857i7G6qCzZ+pU4rL24xGCZmeJo+waJKEv5vpGWgBKEOhpVS7GJDDlOuR/?=
 =?iso-8859-1?Q?FCXeGL1CMdwAWPk6v8TsH0ikBcRD1IjG0UcgCP0Cfy5b3drH3IlM4lvQ+2?=
 =?iso-8859-1?Q?T4XkUCjNX/9kfKfG+SBuD+gzgajYDVqQuFwEN8Lwa+Omorw5wl23dgvx8Z?=
 =?iso-8859-1?Q?G+bw41fop4zjQyGy8hNfqbIJCo7PYox+2EzS0KnwMXsg/+jztMt2BLS9cr?=
 =?iso-8859-1?Q?PES5G+SK8/b8/VrdZsWJVXZr3yqoSyQgZgisDDzpV+1yrGXlw6QsGj+8bp?=
 =?iso-8859-1?Q?THxD3BKwB36WkdV0ZSDt1+U75LQ0EwoXg9UNTO1Qmqp0CHfSoKZ9uHbUlB?=
 =?iso-8859-1?Q?Dh8oWIMTft08joWMaBIRGipyb7Wo4WDd/99fsj9I9hFlpVeg3GR/nVJ04u?=
 =?iso-8859-1?Q?7+gSqfzoEdPUjdy4oljaKpuG+eU9gTnd0+IeC06exwazw0tImXiLVdoXqZ?=
 =?iso-8859-1?Q?BDSIo+FVOuZJ/L5sompaklmyg/bdKaStikmaGmSkxHyJ2oAxdxQxOJM2yR?=
 =?iso-8859-1?Q?ZJkCFgmixTv3EUlQ1xHOJgyQflfBCr+NmZR7De9znWA8dvbRJkhnsbd6HK?=
 =?iso-8859-1?Q?lgOJUXPfscVGcnbFCbZpGFq80B/Pn3CfmDQk66+1RS6z/RPMwTFChVBX8Y?=
 =?iso-8859-1?Q?Qa/oOqnVUG2E8fMlSCoV9s70QKBpI0zJ3J6GcSCG6VqjKy1hfBm5rofLvl?=
 =?iso-8859-1?Q?a9pSFWCmZn1iVTdXD9ltu2YGi91B5wuCHXF7ypC8xvxONYbE2v8TgWrPeE?=
 =?iso-8859-1?Q?MQAXValbg3Hr2KiWoJiYdRI+4lrVOq3hDhdeycU90Aur5jXPHgtpWVahfG?=
 =?iso-8859-1?Q?kgpZ/1Utnglyn2A9BvC2wL4+12/ZqJQfj2bMqJBXCnd2zVKBGW4g65VOYQ?=
 =?iso-8859-1?Q?vzcWvl26sG6qAh+XRmBbes6VBFUB7WL/IH8M1C2WB8VEzGagf5uMZSgjwS?=
 =?iso-8859-1?Q?Qp8IHav11q/J/3YyaJte49/O5m59AHQAf37uVA+ec+iHpvROrXrMatoC2d?=
 =?iso-8859-1?Q?p2riMH4qeJsYlXi/i5VeOjmC8lwWyiKAZ+XG0YEdaEFhvbQsi2KVoZ4cEg?=
 =?iso-8859-1?Q?1OV/l4+JO2hFolJnGOHRIVwK4XDh/4AAb8ABEARfqOgk1kId2gZUhl9qeZ?=
 =?iso-8859-1?Q?mUys86i+A0uyqylblS3pWZJWBpgcTW4KgdPHCWOWOjEGpWlrOmq5hkWrfh?=
 =?iso-8859-1?Q?Q4YKRlKklCLPTC8bkuPYOrpGM2tIKj4=3D?=
X-Exchange-RoutingPolicyChecked: y32PPZj5VLGgA6lRy6Jf5c+oDtcdN1n6UYRXYCj69vkmG3CoaeaJkyNW8dWI8/VV17KJUM3KuRBbz0hDnwcKMLQbxiQQOEeyjkWPtFxwlXo18ngZoqAMlj1sQlGNDUXe/1YIXJJyU1TU6D52JxnEpfUr5cRMLIvHYjJvnsWXpaCz5P5LGWPcX1MaZ7k4IiB6A0LPPLAF16cYNTZUK7vutnN/aiPUvqh2g9KnPloUIXUm20SoVjilckJRKNXfBiuXhGdGd7qE+NE9nlW3iJeSy5IpBw4whGSzEhzgZ0qzXWHEDH9JBcWum6Blda3Jk6+jnIChKVstou3ZjZjFgTKa7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fbf702-ba7e-43d4-a67e-08df29b3d48d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:27:25.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSxzCqgymh9SoUS2EhgCkiU18qmoxcRk9m0eD6zb5q+9vs09XovJBImHy8Ie9ICT2RJGauurMbqrOBok1Bn2+AUe7MQufle8OabXuMkXtTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8198
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 10:29:59AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] cxl: integer underflow in cxl_get_poison_unmapped() from unmapped decoder offset
> --
> 
> commit 8602a2ffbae3a910b43392bb444acb65b6b365e7
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/region: Start unmapped poison scan at the committed decoder boundary
> 
> poison_by_decoder() stops at the last committed decoder and records the
> handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
> starts after the highest DPA allocation instead. Allocation exist for
> uncommitted decoders too, so their DPA is skipped by both phases and
> poison there is never reported. Resume the scan at ctx->offset, and scan
> later partitions in full, restoring the pre-rewrite behavior.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 042356c71ed79..4869cdd6a3d48 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> [ ... ]
> 
> > @@ -2944,10 +2943,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> >  	 */
> >  	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
> >  		res = &cxlds->part[i].res;
> > -		for (p = res->child, last = NULL; p; p = p->sibling)
> > -			last = p;
> > -		if (last)
> > -			offset = last->end + 1;
> > +		if (i == ctx->part)
> > +			offset = ctx->offset;
> > +		else
> > +			offset = res->start;
> >  		length = res->end - offset + 1;
> 
> [Severity: High]
> Does this code risk an integer underflow if offset is greater than res->end?
> 
> If poison_by_decoder() encounters a zero-sized commit_end decoder, it can
> set ctx->part = -1 and ctx->offset = cxled->dpa_res->end + 1. If that
> decoder was configured by firmware with a large skip value, ctx->offset can
> be strictly greater than the end of the first partition (part[0].res.end).
> 
> Later, cxl_get_poison_by_endpoint() forces ctx.part = 0 before calling
> cxl_get_poison_unmapped():
> 
> drivers/cxl/core/region.c:cxl_get_poison_by_endpoint() {
>     ...
> 	if (rc == 1) {
> 		/* ... */
> 		if (ctx.part < 0)
> 			ctx.part = 0;
> 		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
> 					     &ctx);
> 	}
>     ...
> }
> 
> Because ctx.offset is not reset to part[0].res.start, offset is assigned
> the out-of-bounds ctx->offset when i == 0. This causes the length
> calculation to underflow in unsigned 64-bit arithmetic to an enormous
> positive value.
> 
> Could this underflow bypass the !length check and result in sending an
> invalid mailbox command to the hardware?
> 
> A massive out-of-bounds length passed directly to cxl_mem_get_poison() may
> cause the CXL device to hang, time out, or process out-of-bounds requests,
> leading to system instability.

I (with the help of another non-Sashiko AI) looked into this.
The precondition is not reachable. An empty decoder is assigned the
partition containing its base, request_skip() fails if the skip extends
beyond the partitions, so ctx->offset <= res->end + 1.

I do think this is worth closing down anyway, to avoid revisiting this
again and again and again.

I looked at 2 places to clamp this.

My second choice is in cxl_mem_get_poison() but all of its callers are in
the kernel and have worked out the range from the partition layout.

My first choice is below, right in this patch - 

I wonder if DaveJ will do this upon applying, pretty please :)

 --- a/drivers/cxl/core/region.c
  +++ b/drivers/cxl/core/region.c
  @@ -3032,8 +3032,10 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
                   * (every committed decoder is zero-size): scan all
                   * partitions in full.
                   */
  -               if (ctx.part < 0)
  +               if (ctx.part < 0) {
                          ctx.part = 0;
  +                       ctx.offset = 0;
  +               }
                  rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
                                               &ctx);
          }



-- Alison



> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260922101129.52794-1-icheng@nvidia.com?part=3
> 
