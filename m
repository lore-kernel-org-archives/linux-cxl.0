Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71393339B41
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582321; cv=fail; b=oNQIorDIDpId1yDQ6vXqxYABIUwCTHvaDr5NRD+Zwk+1i8L3GrIitmK0Vu3VtS8ruUzvNJDL86UMWADk9u9AgtBPHrwHdw0HmswviVEVCyXeu2pMj3mhejZRwWzmh64Fa1rV5rTJN86ZmWzT2FZh37Y6iIUXEQLmYkqJuk6DOAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582321; c=relaxed/simple;
	bh=CD4Pzxpjg6qAllJTgtqg703Y6p0hBo6GRIcqnE382ro=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IVzz1rhoZoLCmeVH1Pj0kDGjL3ycuMC54SP7eEQeVrue0PvdC5xiBDLnLwExScakv/MIAkgW9PudNfbOQFWrLSTxaG+Tc5G2AV0gaj/OvB1gSlC4oKAhMCxkWeMxSyANWc8qH/KV4cDZKrZetOQaCERDK6vDKxm5w+kCmv51HZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIGXqPbq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIGXqPbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791582319; x=1823118319;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CD4Pzxpjg6qAllJTgtqg703Y6p0hBo6GRIcqnE382ro=;
  b=CIGXqPbqUip/bHzk10clEZQhrW2dR3hOb8jJieEUVUAkpTHF5OWp12cu
   PiNR1p156ltWgKh1RvolSFiC44GmQPN55UYiWBKRvTBn3NYDmtjZhBzRM
   L/hW64QjScCAjJD8l6T+/RSoYlxo6rGZEL7E/lPwK1+UOgBT+LYXbs7cM
   qeLwPRjmMAH5BEvhCXj1B2sOSkSLgoVrLyKcAV7Ei4HHzB0PbSS1AqJOA
   iTEnEDVS/NwRNNm515Z4SWxRhFXu+fiSEyauFdTV3c3n1U5YSDFHrRczo
   qZz6HyFGgtV4ezrYewRPcBECxvqPJ202hkvdLMPxi6I6sPi3DQ+4SFH/E
   A==;
X-CSE-ConnectionGUID: q2OV3c1ZS8O6vVpr/pCoHg==
X-CSE-MsgGUID: Yu2PCcp8SPijmRffP1w5PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="274754"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="274754"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 14:45:19 -0700
X-CSE-ConnectionGUID: b6tdXTRpShmUy7Na9mIWBg==
X-CSE-MsgGUID: SwUDETcCQK6427lQDkw1ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2244060"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 14:45:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 14:45:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 14:45:18 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.48)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 14:45:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUTyXXA06XBNYKHffFRCtm600jC38nqu3CscHx69boaoGAIO4GsVJKfwe3D90k0SYmZiR2qWq17HMHDL68NCOWaYgpt5N/IAfFsiB6qiYbgCIWAGfwOLN5S0Towfyl8ObRVC+WESvodLQX3j49+Nm/XiJMQqBe8VClSwM3Q7NceT3nrrePzQdaTJbDViU/49L1FSCKCpXxlExw0dNllJx2xVM3+RjUQ0VIae+kyWbUA6LIOFpUqW6hATclnQ50Atj9J+ix6uaz9qh2Vg3ZVrMa9ynSZuPq2EHbMhBDp7lY5uUtbV63eCuClezQS/dbkjFoVp6ptWpc1K0qlIjeDm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQfXUI3gPPRo8C+AaMthqrBA5SjsEKglfOA48+fsu18=;
 b=o1Vb0BdJBtS8SfF7AUAbTyHPDplxdJvcXOQ2uOw7L1e9Ojj6OxBz2w6yneF6l4Fhj76sC9aJiHSx0lPdLnnjIXWuZjrTr2o0Z6mcWt6fGLURV/D9EgKxxKgi/E80awdOi08CfI2TQSXsjtF/4UNlAt1R7ge/qXGk8b5Z+2OhkZ+YWuEItOmUfnN78O8T3ySw9qDywzgiqz5Lesnp0X8R4U9qpZwQYUKG+8SqQB+4HYx0maodxdO+2vVMfiY5msvyrVQjSRTM5VCYlmMsXiyS49gw2kjeyYKnNv+DkMUEsed75vBDlZakI9UVsTbxqhfu9BZBfdLShgobipoxY8iJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB683941.namprd11.prod.outlook.com (2603:10b6:610:360::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 21:45:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 21:45:16 +0000
Date: Fri, 9 Oct 2026 14:45:12 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] tools/testing/cxl: Skip the auto region when no
 volatile window is active
Message-ID: <aslgaHlL1_n24pmj@aschofie-mobl2.lan>
References: <cover.1790641236.git.alison.schofield@intel.com>
 <ccc11aec8658ff29e604aded94ac4ce0da7b5fb8.1790641236.git.alison.schofield@intel.com>
 <ary6WmhJk6PWhn0U@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ary6WmhJk6PWhn0U@MWDK4CY14F>
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB683941:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c33aaee-0e29-4ff7-4597-08df264e9ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: pOvOUCpB0GlXQ8opgDfU9VMNzqToPcDsPESAtrvkO7rHve/i4iFuTFj9fUYdOZAd6yRRAdVgu2v8iyNMEOKIjrGzJYPiiagxa4bpjCs9e2lerCBJyiD8+rqw88QJE0wewovIVifQHleNWusXxf6ZNtIAx/a0L/x01jnYoAmQToYzC4yPKa/O41ZNp/1tV3LgGpZkgupXCKHgS4xtYDFNkWy6C0C20Ro1Ea4oWK0ndZlW8C9BgXDmIHw2R6UZMOZB8WUcpKAXUBQc3qc/kiYy1wBn4pGrZRDNCpQUz3dTRQmvewXBNQhmxPbza6mqOxA/qYsijZWURy5c4a5F/GzTefXUocuyAz4/8R6X4FNnX0xCygnmqN9dN8XV9hcN4KnZ0wur5ffc83OWx/TGKEU/AM/zyhVIN4Qg1oHTrmv0rSZqmWYCskWRzReep2Kp5O8g4vJUfOMWz0wuN/fnWMnSMCTxBefrjcaxvzr1tAZcPvZvjEbwpS5+sYB9Q7zNq5p9SUIpisbOm2+3gZ1Y3pfhr5FxHDrOedYvsdCU/FJQXDfJKfKcwR98pEanxfwJMAuee776jMcquNRB/M1AQ0Z02i2nQ8Ct27q76NBI5g+9MKfm2xKODg9vgTSSFzCn7Ps/VdFkajqUIqYlnDqK7jn92o9bdxo2K8nW4CCQYMwyJYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1RDTA4COENushFqUl5wSxmUQcrwuvEvwcPsd2Qn+h2+0aTfzExAs53V8sNOc?=
 =?us-ascii?Q?1ot2CeFn/bgHafl95VqjCHysEzjNciO3qhKeHoCBxzPLYMAukUFdhDtfcwiB?=
 =?us-ascii?Q?DA/1QeXCvNSz/ai968gxi/SG25la47ugJiEm8aS0R8QdRmLc+w64QTWvBGPV?=
 =?us-ascii?Q?fFxJbQPPbQL2mV7H+8d8bGw/Z9e6/j8WKWMYWj0j1JSb/qgTHLABrj4UXUGN?=
 =?us-ascii?Q?SDckqY+1bDvY6DNu54Gy5fqVoHbTlWfErbnbux6iL+5Y2qgNy94JIiMz6Nqr?=
 =?us-ascii?Q?2JCP0GJ6/KzJaM0apyEPROKjQOp8YqcBE/5jPkLxKbM/YZKjjX4HNOur5I87?=
 =?us-ascii?Q?408mZ16VuTKtFhjNjoQxUVRDjlmnDssMfzyR6h2ivVSLN80fHRCRMAXGEfD2?=
 =?us-ascii?Q?oVQp1Q/KcHQP991e0VJT+b8VIfmeRV9+fxqAw+KszNNY+koJ5J88USyazP76?=
 =?us-ascii?Q?skCRzDHTIciUTUDemSwVw9cZpUPFCENnyx3RTE1nJblgpqjcz61GwrzoUWhM?=
 =?us-ascii?Q?vXb3xHfkSQTDe1jcVlpv/l2yMImCCDoUzEF9VDsvhT9oO7eFfKzK1E9icFnc?=
 =?us-ascii?Q?EegzmDuFaJUBcixHV+fbtL86Gs7QIz/MxfbwJNe1xwVpHshiJ4Z6h1T4yfdA?=
 =?us-ascii?Q?mgONSLLyeikomodh0312KJO3ytO2jA7XGZTVOWDPTIP50BEQ0AO3a1otO/FV?=
 =?us-ascii?Q?aBkTLlFsx7sGYfnfXCaeJJuW9+4YwjMmHgMhUBEL0kIC6nQTSO1PD6s/8P1b?=
 =?us-ascii?Q?l3jyDutUof77sUQdlIoOXxbn6XYjl7DXG3PNvq8jmeA/s3BUPWgThfvEVUs6?=
 =?us-ascii?Q?KsWuBlbOyIXE68R/ae1STxvtrsJZ9raV7SXXu76Tk7iH5TmSEzSP+9B12flI?=
 =?us-ascii?Q?Gt8SCisryz8n/ULlfIV/ysHjResieYpRY7xrecxqwBiPGYhTXqKaqGk4AzDO?=
 =?us-ascii?Q?/gE73G+bxj9NZXQwKi7VUrcr9PY6/3+Sfo/nnfWIBybsJJDDJ9ZEVTVGjdpQ?=
 =?us-ascii?Q?UFrDCXbhNAJ7WD4IJqixZhJJmboEvm7LSdpHs35bb4+/8ugHz8N9lgUsIOQe?=
 =?us-ascii?Q?3rfqQfLSlz0owPo5KkESqR4WTGAN84Hc+9ktkp5p1zsmknay/+siHbH+D3qv?=
 =?us-ascii?Q?pPYLYBtp3+UZm0Q6Uma79y4i3WNiluq2PlSVDsHX3wvsgHDGlbg26+ouzzQ+?=
 =?us-ascii?Q?m+hlaviQIGXiu8TvArJ3dP1XSAZpDYOgk47UibLYEjV/Rz6oTsxVz3/9CIdJ?=
 =?us-ascii?Q?pIkgecfImantIXnT505swpjqy5UeE/46XFkwOPlYgGpC9qDq83VIvmB6R/bz?=
 =?us-ascii?Q?JUn3jepDmbpt2sy5kk+g2fw87nqCMxANTpmltgYDCixCG1/avYE3Y5t4zswQ?=
 =?us-ascii?Q?WScToa0C63gYRkNh6xYZPofx1S7w8SIf7CuOTWebmtKC/GOf+xAIE1LUasfJ?=
 =?us-ascii?Q?A083cw0HO1shnJembPRC1whkfQtLOVmNBvsxQ8vnQHhX8FV2/mKWCAY6xGmz?=
 =?us-ascii?Q?TBL2lat13SvhbRMrjFvFcDEm9SfA86/wUi9pTVy5f3j4310S3GY27kGdDreS?=
 =?us-ascii?Q?VcEoLw4yJuRrIWEn7haykDsqbRFjuxRjp7wbWg1uHTHDukz8KJ9KcNKje3DN?=
 =?us-ascii?Q?A/eQhQyUFhShbBo9r3ytK9wfXYIq6OxuDyX8IFcibObqt7liMISEzB+/JHwM?=
 =?us-ascii?Q?TJ/C7qosnEduUvX/z7YmvhnIg26prL4BmaiBTcj4Vs78rMBOe6PbMgv1NC/y?=
 =?us-ascii?Q?1okO20ieuGYyWk+02Dk4+k+OldaRIMY=3D?=
X-Exchange-RoutingPolicyChecked: oLFTHsIMpa9wv/3L/yZRouALEUPGoGZuxpn0TEsJv3pyWh3Rd2yepx6I40pYe5awT4kfrnjHcIj3vR3B7RMG9EqV9OFXwZ2omve/y4kSNpbUCT7qHM/9ZY8pLy9Qi4SzP+ljXHmC1T+Pn7M8oq+gexo3nkPggsUV22R3xqTsYRMqVSbfwaGXJUV5Iv4My3PcZRPOsyxP4e1iTOQ7BCpqZuNBxMQZ9dcARHNnVLRBro/v+hGrC2+SLQnj1ruYVd6BJZqx0C8cYOM4AOwWTxG60tLb9LlutZO3vPCnUyjSjZUAUa91uDbf5qYM6PUqnHqm4UQJq0nFvYAYaXrASpRhjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c33aaee-0e29-4ff7-4597-08df264e9ae1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 21:45:15.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8Z96DO1lOO/0gmrM2MGwIsUxblo+a9vR96a4mArqfnPtbuRpjH24HQJmFArzL8Lfd5NgWyEFobuJy7jMfNzBI29HbuDBFmfKMp4iBSi45Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB683941
X-OriginatorOrg: intel.com

On Wed, Sep 30, 2026 at 03:33:20PM +0800, Richard Cheng wrote:
> On Mon, Sep 28, 2026 at 05:56:17PM +0800, Alison Schofield wrote:
> > The mock auto region always uses CFMWS0. With XOR interleave arithmetic
> > that window is inactive, so its HPA base is never assigned and the
> > endpoint decoders are programmed at HPA 0.
> > 
> > No root decoder matches that range, leaving DPA allocated to endpoint
> > decoders that are not part of a region.
> > 
> > Set up the auto region only when a volatile window is active.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  tools/testing/cxl/test/cxl.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)

snip

> 
> Hi Alison,
> 
> The caller of get_decoder_init_type() and mock_init_hdm_type2/3_cxled()
> is mock_init_hdm_decoder(), would it be possible to just call
> mock_auto_region_cfmws() once and pass the window into each function ?
> 
> That way we can save some redundant traversal of entries.
> Do you think this idea makes sense ?


Yes, tried it out and updated v2 like so -
get_decoder_init_type() now passes back the window it already looked up, and the
type2/type3 helpers take it as a parameter. The lookup stays after the auto-region
filter, so it runs only for the two auto-region decoders. That also removes the
unchecked second lookup in the helpers.

Please take a look at v2.

Thanks!

> 
> Best regards,
> Richard Cheng.
