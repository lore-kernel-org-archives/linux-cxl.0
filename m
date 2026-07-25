Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48A316190
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941243; cv=fail; b=NTBfBy6WAx4JnRU70ZH7nzmiln75dfHvFldopHNewCy1ZhX+/zWZXLaIXGst8u12BlqLjfpaOl/uVLRJ/Om6Xr4UMoSYUMKiW8kKsJxdPQl09jVR2pbGQbomWQvaTNWZsRDS7pPjeGaeVAAQclNYinZ2sAIiY0r7G2SBhKhD5vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941243; c=relaxed/simple;
	bh=5BI+PE66zL7nszzYcGYS2wdkOB1bQJ6ej57ChG7BUdY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OdUTMpTI2gR5ic7mDjbeovz69Vp3Je39kg6p7UMU4D+rDiOaagZ7nFx3sAh6zDHGahxAgtsIxQ/oGbTYtJ2CKAGsCL3LnGvtVKjgL6twCi4yRG+r2zCobzNhWYM8gA1vkk1PdmdqT7LElAZxT7lzxKGrfg2jQHxnbwjnvBr/nEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTQFyz0O; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTQFyz0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784941242; x=1816477242;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5BI+PE66zL7nszzYcGYS2wdkOB1bQJ6ej57ChG7BUdY=;
  b=HTQFyz0OPagVrhNzDTtQ8WwsnKT0F8rJiyDtOfqYTsvqg5awvW8VCHxC
   jvmO5u/co5GNCpsKnXxa/MMZxWz5bamSWCVFiO43ru6S+I6xLEmcjb6u6
   yFatczuPeuQTFi0Y5uJ7PfMqzgzc2sQThSHARyIj4en5cjNfZQ1hTtnze
   q74U4dX5rsXb+YPact46CsW9kcDbisxJIfa9qkVfion6wzr/P+ithquyP
   syGOQWGMMB2Jl6+Bqk1Ei2Bho/QAkGHWZzrSoLz6xpgDOGsdTTwdLhWJ5
   H0J2E/Fge3T3ACzANOEIRkvwWtxuBRFnVoLpjs7Z1tLJGsA6ExhpXaqOI
   A==;
X-CSE-ConnectionGUID: 9ieEuYEERLiRkU3FTQm4zw==
X-CSE-MsgGUID: NyrNzt/tSp+yx3Tiw0IXFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85727910"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85727910"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:00:41 -0700
X-CSE-ConnectionGUID: co2xBtunR92W8OJfSJYzNg==
X-CSE-MsgGUID: whRQXJEBTxygmvfYbzCQew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="282168669"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:00:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 18:00:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 18:00:40 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 18:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJnyizhHGQzNn1YpzNtBmYG2rZMtnYUsUFF2HXm0OudAh3xk9wfdu/wvlrGMt+m+FGdVNzOyN0XoDoMxWeRhsFmZP/cmVrSCIStGqlLDxcma82PJ1C0z6uClktUBskNbjg2PGSL35fPqm2CBq0u3wrnx0eF8g8VDeDVVyu3FZIJSZTyr4HCwKvVgzUSDW6U4kuUTM72F9PzvmHImgq2eGZ/vmJWHMvv7nKULEV6inIMpZ9UQC8Leh1TKFld5CdfD38+E48yuEAHFF+oZFcpjjN5LTPZli2vXhTn1jwWcoS1CvCzvEKFlN8US9qBBJPPDhfQhOn2qHGNhgL5IfH9y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSYdV90FMXaLiy+2b202NvAtvy85dvpYS4o+fMiQ72E=;
 b=QW9Bod5OVe2atgqsliWllO+WhPFhcl6XN1Ivx3MS7SRAZg/T0U11oJNnlCIZPrjw/ni71cJbHae6A/cEZFjinw77uHiuAYYeuA1xCx0KJgnR4nI/ObgFnaYaxtcKC331/ympXNiViRqEcXWXFKxsVltSuycDtp+TnbPIH28u38Q6NYd3TbPX/XbO7XzkyYjNxJ7aOE5wsHK9MPbBrR297BVfJt3I8iHtXgs6aJGDao7l0i6xLj+kZs4h2CZo+g4mXyK9hTDVEIG8JWDftw7Paz5j4erGPxlQSS8eKNjLffonmHMnSSgBrjpSw8oytsj6ibJtU9U4+rPrTg4APc02zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB7782.namprd11.prod.outlook.com (2603:10b6:8:e0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Sat, 25 Jul 2026 01:00:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 01:00:37 +0000
Date: Fri, 24 Jul 2026 18:00:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <amQKsUymDtqOCWJh@aschofie-mobl2.lan>
References: <cover.1783795720.git.alison.schofield@intel.com>
 <9a798f6b445ca8f2b16743d3e16fa289efadd86a.1783795720.git.alison.schofield@intel.com>
 <20260711201508.082531F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711201508.082531F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: b53d9191-ff99-4df7-2b49-08dee9e8235a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|5023799004|4143699003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: wapCv/7mRE+tNCe7KfrNtu9jAPqvHfDwSIixc1NbMqJ1cZQA2cXAsF3PLvru8S8Ho7hUUhkuwxetTTkdyg+DGQVtQBL6Noj87BiwKoEbIzuxFgOQsvPmmW+sYb1+oCl9GwpDvXJqWHV8O7QwHp0guVohuoLYkV/Po81ZjfPiUneL5oXsktsf/GNE7ie4RE1O8sf9R3CxkgtUx9eThHxrW5xTgb6S4DKx7s0atWw5hV+AndBTZDAodMSP0I7LX6/gEyaaQ+bAeAeMD79JAuBSe6dJ9ckC3O3YAeUDW9dU6RU34OuZmCgk2+QKMiejHsKlSdRmvnh4QNpV/pnfOv0EjMJTdHdnVWuQFvwo0GRhlKkFrbHJNxdY3MpyTaMCCd6d4TJgoXrwCcC1R+jH4kw4qmtP6thnaBzu/3eeZVTXCCOY8YGQQyfcVRxweZNJbM0/ibTiaEoynSx6aerpsJYciQXyJoW2vYPicJizOxXhGDIqMu6aI4z6EB9bcHJ7e3RLEoOsL6ZU6TcJV+GBcyhVNTVJ82g6ShRX8DIRwnbMzWL9U0q/oJtpzFcFxYKqu3a8AMJkY68bSorJxUZZfHuytYBSs1IMb1h/+4Asa7LlVgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ld5avjhYBZtiGWOM1fBxY9xk17iDpZTI7x72ywL7pie5iLVyf2ADOP/OOb?=
 =?iso-8859-1?Q?SmXFc6ltP/PRMEx2wR95/gSVTAkWIScCFhIkgzY+6JgayvQEl1/0wJifcg?=
 =?iso-8859-1?Q?TTss3//Yi3yJIWOyvMQSdUUXldKHWxI0bnmzmeFQembJ/RFcEoaIdccWyw?=
 =?iso-8859-1?Q?AB0aM7rAwFsm1SABRbmoFLoZe5dQWrTNpFQ5RrtMQKpiOZr3PR6m5roc0i?=
 =?iso-8859-1?Q?sbUlILj2lu93PZ18cBBznbdOMNogwDNK5U4gIZYRdQYa5sizdzyOqlJqqK?=
 =?iso-8859-1?Q?aXhHO/hYaGQ1YHmHIRX8Jxi93/pGKDdTrTC0afWH1RqQ+bOhtrGGAgfHql?=
 =?iso-8859-1?Q?kO2yZQAZ5cuZa86BIGUXbCrS8DF5IbbRHg2USKYO5RLxwDjnYKp7oRCmpR?=
 =?iso-8859-1?Q?luWGMya793Kjupa2p03egHhU/ce1U2FMUGpmx5VBiO/FhmoPBSXpxbscoP?=
 =?iso-8859-1?Q?mAvzQtLsoJnmViohGksFrXdHWvbLrgpfbwGuXmB0KJGrrpyqi24pVMWob4?=
 =?iso-8859-1?Q?FMQ1YasmvMe/H7KYF1g5Vx75rt58Uo4w9B9YjZVTRSVaXUe6WIHuBWV0//?=
 =?iso-8859-1?Q?lxedqOuh+WtBhCry1WlKob65Qg8ft5NU893OhcLFs9CoTZ112+SIRjXrDO?=
 =?iso-8859-1?Q?dc0quMRaHHfi/ljzdBZVOkGZRhBRwljHZ+cb3mblxwM5V1r4NtYdqwMKhj?=
 =?iso-8859-1?Q?eGFvMk/nshnbted62RTAFtD0ptgWJL59HkmSB5fcmWHOEeLT4yYZHqgwaA?=
 =?iso-8859-1?Q?7kb4szlZsqJ4GnwuwzmGpjJoMCehq/u4luoib5bNEYZ+cggiksFGdkxV73?=
 =?iso-8859-1?Q?mMvYXklAduAW4+X3wS/TwOjEUC9CoBY09PjKWCqZUId7/Wiffh6ldG6OOq?=
 =?iso-8859-1?Q?wVzu8nZDEj5YoZ7z0Wt1NN+5rHLncZnWfKWh0ha3wY9x676MCl4xuwlECP?=
 =?iso-8859-1?Q?XHBapv6HrqmdNOA7BAcht6cYjBJFztwgvxu/OPqyfX/UFHEHEQ03RIxSXb?=
 =?iso-8859-1?Q?QLSbfg9+2Xk1cDgsM3rQelEUDHMkUJXf93ERFzZrKXl6sIzu7UKQIHlf1K?=
 =?iso-8859-1?Q?D167A7FBSMyTV8jcIrVbas9x+gwX9GB6Uah/OytJpH8N/V9nMABSwRdXIw?=
 =?iso-8859-1?Q?MGU0OSuJ5gPLsWJf7iwqgPFlVEUqIu6eLkZe0KF8xehZhZ2Mxnav6ZmbvP?=
 =?iso-8859-1?Q?K6yV6LRV4hYeE+c4Ta9pEt942YpYUK+OVt4mFqDbGQWdt2Z4+TEV8i+bsm?=
 =?iso-8859-1?Q?ILezmonBJSVynX4970Knpl/2dkQeKZOGai7ASx8OTOhio7wpvbleXIslZO?=
 =?iso-8859-1?Q?7PBfp5Jm0HbZFYBD3yn81hZnNrM3DKbD4v1jbwLva7bSnVn4VGdTXKLyve?=
 =?iso-8859-1?Q?FxBgcuEJMwZBLJQh1avNygcWd0MzEF/40oAY9w3s2CyZrIkaHWqnHvPHb8?=
 =?iso-8859-1?Q?osa+gb4F97o8N5Qk7bPZZX5d+yi3afyT2srw0zNscfOc+raaQEUSrQNmc8?=
 =?iso-8859-1?Q?h8RslSXYcfDnI6rksrdVEHMEjM6lHWk88CA+Bbhaqjs+eGUBwFijEPKvvL?=
 =?iso-8859-1?Q?6EXuUIrMoFsrKDe/gWb9iLCtmqk+eMYm2EiqHu4pZ1NGaKoziw/BuUrhY2?=
 =?iso-8859-1?Q?Sox/4MqzvyjHXSgJrXLVVoUjd5eM7heH35zxtPzCRvsgIZ9NT3H0wWAHPF?=
 =?iso-8859-1?Q?zNiETJzs1GMhg8qPUeTmGJcykhltVLv4r92lrrK+aACbQx7HglfLJHh0mu?=
 =?iso-8859-1?Q?HwxiVh9lzxpPsTmC/wPHElH4lyvf92C1OFpOrRj9ZS2GLTVS7poTAY0wPB?=
 =?iso-8859-1?Q?8F9JdnpWNV/NHWOb2tClKtLeRIW3ae4=3D?=
X-Exchange-RoutingPolicyChecked: U1wuv8GEBgb25SKM/sPqVQ24ZPgPY7d2E/O2kYZLE3VQz/z/iqWXFtjWBGeN1A6g45miKB/Ukf9gXbz56XVB07fzn1ghUrQ/V+HpuxndNbgb4mp9gtPLji2MeQ1v+MXuDNh0WX1a2lAOC7Zg/wyVUlCZsDGnqDNAa7qmISibt9kvRGQEUJTZ3pOp3WSrlQ29ggeyMBmQk2pJcw40BHJgeyqlQHKlK+SH5XP01H9jRRf02nkgk02KqH8+1KjKzlABADFPEIaTmlfGnDTfcGC5Bq+rr8XTKL+any9nSjSOeNU+ApbXSr5Nk/y7rQHDHmczosa/ii2Vl+7veDHRbym5Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b53d9191-ff99-4df7-2b49-08dee9e8235a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 01:00:37.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpgRDqvB70LbyAmsAjcq26bWCOtoEkx/2RxbCb0LvNZmo7l2WFVHusR+MZNBv48VTAorCClYQ+tQWjimekyUkeCGTtfmsdGM3I5DA9y/cmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7782
X-OriginatorOrg: intel.com

On Sat, Jul 11, 2026 at 08:15:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] During auto-discovery (CXL_REGION_F_AUTO), passthrough decoders fail to update their `interleave_granularity` software state to the computed value, causing downstream decoders to inherit incorrect granularity and fail validation upon reboot.
> --
> 
> --- Patch [1]: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K granularity ---
> commit 9e2526342188a97e338bfc63d454c253f1e2b3ef
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Allow passthrough decoders with >16K granularity
> 
> This commit allows passthrough decoders beneath wide parent interleaves
> to have a granularity exceeding 16K by programming a don't-care value
> in hardware for non-interleaving decoders.
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b4..d164662668c19 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -691,9 +691,16 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> >  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> >  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> >  		return;
> > -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > -		      "invalid interleave_granularity: %d\n",
> > -		      cxld->interleave_granularity))
> > +
> > +	/*
> > +	 * A non-interleaving decoder ignores the IG field. Encode a
> > +	 * don't-care value instead of validating the stored granularity.
> > +	 */
> > +	if (cxld->interleave_ways == 1)
> > +		eig = 0;
> > +	else if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > +			   "invalid interleave_granularity: %d\n",
> > +			   cxld->interleave_granularity))
> >  		return;
> >  
> >  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> 
> [ ... ]
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1e211542b6b64..5a443551288c4 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> [ ... ]
> 
> > @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	 * Interleave granularity is a multiple of @parent_port granularity.
> >  	 * Multiplier is the parent port interleave ways.
> >  	 */
> > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev,
> > -			"%s: invalid granularity calculation (%d * %d)\n",
> > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > -		return rc;
> > -	}
> > +	ig = parent_ig * parent_iw;
> >  
> > -	rc = eig_to_granularity(eig, &ig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			256 << eig);
> > -		return rc;
> > +	/*
> > +	 * Keep the computed granularity for descendant setup. Only
> > +	 * interleaving decoders require an encodable granularity.
> > +	 */
> > +	if (iw > 1) {
> > +		rc = granularity_to_eig(ig, &eig);
> > +		if (rc) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: invalid granularity calculation (%d * %d)\n",
> > +				dev_name(&parent_port->dev), parent_ig,
> > +				parent_iw);
> > +			return rc;
> > +		}
> >  	}
> >  
> >  	if (iw > 8 || iw > cxlsd->nr_targets) {
> 
> [Severity: High]
> Does this code break region auto-discovery on reboot for topologies
> containing a passthrough decoder?
> 
> When cxld_set_interleave() configures a passthrough decoder, it now sets
> eig = 0 (a don't-care value) in the hardware.
> 
> Upon reboot, reading this hardware state will initialize the decoder's
> software interleave_granularity to a stale value.
> 
> During auto-discovery in cxl_port_setup_targets(), the CXL_REGION_F_AUTO
> path skips validating the granularity for passthrough decoders (iw == 1),
> but it appears to be missing an update to correct the software state:
> 
> 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> 		if (cxld->interleave_ways != iw ||
> 		    (iw > 1 && cxld->interleave_granularity != ig) ||
> 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> 			...
> 			return -ENXIO;
> 		}
> 		/* missing update: cxld->interleave_granularity = ig; */
> 	}
> 
> If cxld->interleave_granularity is not updated to the computed ig here, won't
> any interleaving descendants read the stale parent_ig, compute a mismatched
> expected granularity, and fail validation?

In preparing v3 I found I didn't reply to this last piece.
It is real for the encodable case. My v2 clobbered it and read back
state. I've fixed it in v3 at the encode side, so F_AUTO has nothing
to restore.

-- Alison



> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783795720.git.alison.schofield@intel.com?part=1
