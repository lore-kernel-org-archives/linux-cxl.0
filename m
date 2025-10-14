Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6857083C
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465006; cv=fail; b=fW85N8GcOc3nXAERpqWAuHJp938sM2SEpkid8STz9sqwZG+F6OKGZlMxM5XxWLmL8TdNvf+6qc/G4J3+RTGRoKgrfAHIadcL8lhGlRZjYvsKSgPH93wE2UcnvL+zRqjto5BcfPjhKSzjk6hWFclmSm6qPE4PMCx0QtMtd947tjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465006; c=relaxed/simple;
	bh=+/RxRzblJ9wRfyyfTDDecKy9/PTG48VTMocXuqyXSc4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dP75c1k9U3pkDB/n3KcEbK/pLK7KjWfMG8NVWA/+2SOxIUg5TeLIRFdYZuoxHW9faa0qk37ryvKcry5/2B02r80jbr9kZkLn3hDrn5xpqTkuZV5Cb9nGSCKVXEQ3weKfdqbF4UtCfvrf9PuqY0EKZUZT/86/Hi97pIsHWK9pe/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZAxflX0; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZAxflX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760465005; x=1792001005;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+/RxRzblJ9wRfyyfTDDecKy9/PTG48VTMocXuqyXSc4=;
  b=KZAxflX0ZCY2uhqNgxkdwNRAXSjXAo8t25BESirK86ZCLVKTvBqlhqMN
   U3s2Knac+byeYQJ7Ub3RRGAsmZ8uvs1zNA1Zh1FCt7WKakvC++nbQnWGO
   gAFHXrmsWDWKwRrY4Z5G0TWmmhaZ2Jg/ToiZI5Yf5N5J8UhnBu7rMv1wZ
   Y03+S+4gahrWC2NubKeJsrWvJwoEeLpiDD5yHmKuyhpwYggekFejoyBNj
   SqTySthVmxuTITjo1gde3ZaCxpWcQ+/Vs5l3dW7DiQNnSSVqon8Ulmu0F
   1BwRC479npZBpF5nddgAH0Yr0Pixuu8tTkC7GDpbvwNc2aRfH0dp0t/GW
   A==;
X-CSE-ConnectionGUID: NgZu9DjITP2dl1HbYTcMew==
X-CSE-MsgGUID: Zm0p3je3So2c8mpRXIQLzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73734944"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="73734944"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 11:03:24 -0700
X-CSE-ConnectionGUID: 9Ik2oxDAQhSxS0nkYyxVNg==
X-CSE-MsgGUID: am+AqzQyTUyC9lhrMiAeWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="187042437"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 11:03:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 11:03:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 11:03:23 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 11:03:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHYAF5C9tfOl8LhKJZI620e3FH4Ozev9aSEH+8r1ChjRanqCr/NKPtraciq0QBkWnZ/AO5EyrzZoM1eu0Cyxom0+lyNaNwds5QdN8c1+//D1z/Y2tQJAXuW1ecrEotLdUnj8vE7puV4W7MKfXYk9TsEsYfiyycNSACCs42iX4GhGOFqD9+PFdprOGuh2dBHVr+cmM8YryPh2eyQcA3U/Q/rQIV+drGsnuleCFFBR154oG7PZTuY6Sr8gMg/8he6Y9Uv/k3KBkPFQP5JiVC5fnpnqt9S13tFPY0/Yh4212qEpggWMuMgUCqbsIuEAMJt84SIVuS5RsVFFse8YZM1V7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL+9fmgZc6GCNVMVwqRH6bmcN/00mdJ58PIIe79GlEM=;
 b=ol9NvmLjRTSQLU1vHAE6zBikbahsB/Ex3DfNckcl05ah1Iz/+iZhMKoJRjsW564pEnXU6hj/b+M4CDNqtwgBu6yhp24SmXSEt8jnpmFKJec6uGAppDcaTydwo54vyq9XFl9hFK2aPwuinEH0ealPrHOd0Ta64UuMsusflQgSnJqlARAgxBfvpzuY7s14BRSan4/juIy/4e93Wo6ihCxl2E/jttLYOqWh+vbRsRsQfjRb7HiC7xolLw8wKIMppZ3cq8rfCxcorW4PItwGTmIENZsAIyNlMeNoZNINmNp+dpbpTG/y7104fVakUeeZ/c5cYjAbX7he5Cs/GDlSzGnShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SJ5PPF37792A6D2.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::820) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 14 Oct
 2025 18:03:18 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 18:03:18 +0000
Date: Tue, 14 Oct 2025 11:03:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Qing Huang <qing.huang@intel.com>
Subject: Re: [PATCH v2] cxl/region: Translate DPA->HPA in unaligned MOD3
 regions
Message-ID: <aO6QX0rlhqfNtw0j@aschofie-mobl2.lan>
References: <20251014062850.727428-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014062850.727428-1-alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SJ5PPF37792A6D2:EE_
X-MS-Office365-Filtering-Correlation-Id: d06035d9-7cc4-4400-2b5f-08de0b4bf405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P+SLGoAZxT91q8wfEoW0PDBajNkEKGnzWLeriDmgznxr0tzZW9hxTGBS5Fp2?=
 =?us-ascii?Q?M/wtFemiMPdCEK15AhtHi4YZ8fHyvqDB2wSMEyF97Rsy8i1gOwtO6ub0lW3T?=
 =?us-ascii?Q?EZeh6Hotug9KtuZy+swXAGMTmKq6w/rq9sqRbAJMN4xuYe13P45zyKJjbuQE?=
 =?us-ascii?Q?VWy9vzz/E5CuWsm5/Lm3PGY1gz7fmIQY2i4/9tmHGYeoqJ9HOHoozZgl7pD+?=
 =?us-ascii?Q?FIRkZKs2NSs9YGN7OjwxqsdZ12aJwGBeQ9y8KNXJ2BNN3xQCVdmH6fulj1xU?=
 =?us-ascii?Q?O/7eHgIV5U2UiQHEuu+3e6HKjLLDAXV3ClnQNs7Zu7N7lohY4Y7KwrzlFIsW?=
 =?us-ascii?Q?4Il0frx87Wd6DF2mHe4ucCM2B70A2CcNaAP7LxxWqXf2XZeXy9MSK6i1tUP3?=
 =?us-ascii?Q?y57tepFSVi5f8PXCMC1q47SqKjeHLSYofFv9osMagCrnlpplEk6UAXjqcFH7?=
 =?us-ascii?Q?0/03rk+dJpVJ+LO2NL4s7s7kJ0q++G9WtjlLPjHMnwWZYjXpCoXHVyB2jWIX?=
 =?us-ascii?Q?hgptu5GCB1OAuiGvSjwR+Qw3R7tVxSxBA8pYUFbd9yWjK0VSJ5UZB1AblSDt?=
 =?us-ascii?Q?kHqy1/Nzbtpee0wf3vUltCdqMEeD53l2EjlOYWvFqmUrlBt10J0zxpd70xrk?=
 =?us-ascii?Q?CWeOIzNT9rljqEvl4hZhFGOv2vJtNOvwg3hZnFUSaOVqDgDclChqhO/N8+Jh?=
 =?us-ascii?Q?ETeFt0YLMeS49s/6Jqq69WBFBJV9OWmxE+cNkP+G62aC2T1LrNcC0v37hIis?=
 =?us-ascii?Q?JE9icp8GZHDO8QCczLq4h8uqHj2SsR9dmZzvAZku1uKi2zi8/3TcNuZUJyA2?=
 =?us-ascii?Q?Yhx6428ymSD6csERGBSkvpZITq1Ds2d0W76cnEgRyCTbk5LgAxKaSubezIam?=
 =?us-ascii?Q?ytjRQ82gO9HAInwmdp0FLsTSxEvUhfzkmYTgIEwCJEdtRCy559V2W3O/5x7V?=
 =?us-ascii?Q?SuhLGkD0LkPT0o4qu8fPq5E+p4pLM9e/8tVH9WMeNuAs0hlq5uRrbvazKDbQ?=
 =?us-ascii?Q?G16SK3yeWzkINytML2LR/fS6FEb3DPRm6WuioidJm+wHGyAF/D44t8S3dTUC?=
 =?us-ascii?Q?hOk1pPSYtHPkGwBq1tCPcZM4QIfT07IQB/rC05EsYc0B38EbwY6x36Q+u6CR?=
 =?us-ascii?Q?IueXGRdN5agoQjqHj0Rhiib1cvAJLK5Gao2HKLijGEZ7Nef6bI9vpo2ApVrR?=
 =?us-ascii?Q?jNswX14e+Rc5HnTRwe/beXKXanTrPfy6GxpTC74258se0bAywxJmGcq7nt6n?=
 =?us-ascii?Q?qnTTPEkHFZAwQOPYzeEKWSyZAWOUMufS2DcJk3YDUHL/KtrYa3NI64Ub0Lx5?=
 =?us-ascii?Q?iIxuOp13l82cZ/uIoGg282s6t814s/F5U26mxItZ6SICjpJNqQjjhiJ2N1di?=
 =?us-ascii?Q?DPVK8dl8M4q8vSGcVmQSad8BtnnJ14nJk1p34tAJ6kGzMe2KXTFPhzegFngJ?=
 =?us-ascii?Q?5ipAX5xS59J2cKPbotCh7u8gjjVypIAb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZhblbZ813mtpKCPXe57S0Vm6PhvLOtVj3lWo+852wc/nKJ2uuvLAwZhNgk0?=
 =?us-ascii?Q?AxUClAm3L/i4ApxOE7336FjbkLwh4NuAdBGp3F3cHg96NylUS5cq1AxbNw0U?=
 =?us-ascii?Q?Rr+h3x5ajhHNcCpVI0lhoF9u7x2ve4LKxY0rYQBYpqiBbLvVSoZ9NfRyNa8s?=
 =?us-ascii?Q?gRg3P5xz/ANRKxJDeKVooy8Xnr9mOAgfIuLrL1TliasmJFqE6dMbMK8DeqpF?=
 =?us-ascii?Q?bseHp4UmSmykaxOx3/R7HuJporuRRJOQGRCFkfyZNEb71s4V/1pxTTjLfr6r?=
 =?us-ascii?Q?ULo6sGS3v7i+e+760qGTT5xTuq4796TlKXS8LT/rmJCg1cgbYB5ap0/p2N6M?=
 =?us-ascii?Q?HrqZImqNwFeJKf8ElgU3PxNLuXoFfnV2PTmo6MiA8aBbeph/MBm2ViiiLYTc?=
 =?us-ascii?Q?pEJINOPMU9ddnyxXxDdl33NeQpzHRBvrmF3HmKvxnoqd4LltJ6/6SjbBUor2?=
 =?us-ascii?Q?Lk7VtL+L+TBy22zcbDVlO9aCaYnNxqBds/Ts2Q4CUzl/kCsU0qvUPr/1q6fp?=
 =?us-ascii?Q?ULOdCbNPIBk1NUQLwXSP2xFwv6qBPXS9pKuHbZKVocEoOuwjTb/YjEXxPGQ1?=
 =?us-ascii?Q?Ng7yPNyDV2werywkcyW+x8d+/xR51zZRPA7/FS8q2M1bdlpnyI4GKrxj9aK1?=
 =?us-ascii?Q?5NVifwd90tgJ0D1cfTuxfdUJDY7vfFGkggCzeZnZ2hlSRmP9BvN5jD4UU7dH?=
 =?us-ascii?Q?aol8onXCZ8zz/TF+zFRUaY4CuhWxTcyobWku7tbh+v0U5sUGk0r/X8rHlM2i?=
 =?us-ascii?Q?GnkAo3zGCarJPTimiObGBEfBSdIOf3JFaLMZdnKmGOcOQvmaMOkU0gY276xr?=
 =?us-ascii?Q?X3nOA6HfpWbZobrjYG3clb8hUgv0xKCFNa9lQlMICvqZ93zoYRxqoO8faqWd?=
 =?us-ascii?Q?atUnlY7bCB1k8IJo1k2c2z2siM5WGrHm46QdTGM8AGXGQcIh8ieukCL33gOh?=
 =?us-ascii?Q?TsbhS4bX0Mu6Bv5PK91MdHBon5U3788sV5q1NY2XA3qMIHybox+mm9ns8r5X?=
 =?us-ascii?Q?hA754rG7UcFv0IDEEDLKsMP5oVWRKoqFeyVGAFsV/L4OkxdoUz1JyrwNoDWz?=
 =?us-ascii?Q?XciAie04GL2cag/w7DSr+aef+XjcEzas7jo/qIi2UQ6tBJgAxNHKTLRVp3Ui?=
 =?us-ascii?Q?jcM47MdfFVYxY2ddRfSYlyMBZt/3Kmr7mFFFjnwtNvom/Ov5x789J3YKQTAm?=
 =?us-ascii?Q?ij0BZKaGQzbHajsucHzfXOV/B/kH7eK9xm7r7mD0iYO5iC/7xdCwOK7srCW0?=
 =?us-ascii?Q?kbDDLs2oxhHo7OjUTW/B1WwamGIJEX4t1pFMUB4vJvgiYM/dBfb5cTZMRAgD?=
 =?us-ascii?Q?oyy0X3+xgq5teHiu+ZP3XNVVbIPFXT41yC7oGx9x3Pe1pJx8iFd/QTAtAjBR?=
 =?us-ascii?Q?gI7SFffpI8YB77gGYXU1vPhuZR7vmENDgufVYhiE9iFLXwYlWUSZb/x5a4UB?=
 =?us-ascii?Q?WTjdeoa/v17H9i5Y0G2AS6Pa3zA2E3CZ21TS/6HEjGztOun9Ka4lhzS4/WSR?=
 =?us-ascii?Q?5g+y8l6CneMVXEBBHzJUWSIhiczpwul3cQZjTg7PfP72ddR2bTRW4SXOc0wy?=
 =?us-ascii?Q?9rk5InDOUKXka/MwDakPXhz/v0GMOaqh9geA66wNRQLiz8L7eCXJjF+3MzlW?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d06035d9-7cc4-4400-2b5f-08de0b4bf405
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:03:17.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKKNEcP5VwmZy8fJJCXqN1zVVtWbox5zE5bk6//LTJgR9j8XRBY2NCHnFnpKWuJK/A0PkGRmlhhYZfZHNM+VpMnFDWk1ih1U8AJ2FxiQSmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF37792A6D2
X-OriginatorOrg: intel.com

On Mon, Oct 13, 2025 at 11:28:48PM -0700, Alison Schofield wrote:

snip

>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> +	int hbiw = cxld->interleave_ways;
> +	bool aligned;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -2953,6 +3064,28 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	if (!cxled || cxlmd != cxled_to_memdev(cxled))
>  		return ULLONG_MAX;
>  
> +	/* Remove the dpa base */
> +	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +
> +	/* Unaligned calc: MOD3 interleaves not hbiw * 256MB aligned */
> +	if (!is_power_of_2(hbiw)) {
> +		u64 rem;
> +
> +		div64_u64_rem(p->res->start, (u64)hbiw * SZ_256M, &rem);
> +		aligned = (rem == 0);
> +		if (!aligned)
> +			hpa = unaligned_dpa_to_hpa(cxld, p, cxled->pos,
> +						   dpa_offset);
> +		if (hpa == ULLONG_MAX)
> +			return ULLONG_MAX;
> +
> +		goto skip_aligned;
> +	}

I got a personal kernel test robot msg on the above and don't know why
it is not on the list here. hpa is used possibly uninitialized above,
because of the missing bracket around "if(aligned)"

Should be:
		if (!aligned) {
                        hpa = unaligned_dpa_to_hpa(cxld, p, cxled->pos,
                                                   dpa_offset);
                        if (hpa == ULLONG_MAX)
                                return ULLONG_MAX;

                        goto skip_aligned;
                }

There may be more flow improvements here. I'll take a look.


> +
> +	/*
> +	 * Aligned calc: all power-of-2 interleaves and MOD3 interleaves
> +	 * that are aligned at hbiw * 256MB
> +	 */
>  	pos = cxled->pos;
>  	ways_to_eiw(p->interleave_ways, &eiw);
>  	granularity_to_eig(p->interleave_granularity, &eig);
> @@ -2967,9 +3100,6 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
>  	 */
>  
> -	/* Remove the dpa base */
> -	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> -
>  	mask_upper = GENMASK_ULL(51, eig + 8);
>  
>  	if (eiw < 8) {
> @@ -2985,7 +3115,10 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
>  
>  	/* Apply the hpa_offset to the region base address */
> -	hpa = hpa_offset + p->res->start + p->cache_size;
> +	hpa = hpa_offset + p->res->start;
> +
> +skip_aligned:
> +	hpa += p->cache_size;
>  
>  	/* Root decoder translation overrides typical modulo decode */
>  	if (has_hpa_to_spa(cxlrd))
> @@ -2996,9 +3129,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
>  		return ULLONG_MAX;
>  	}
> -
> -	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
> -	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
> +	/* Chunk check applies to aligned modulo decodes only */
> +	if (aligned && !has_hpa_to_spa(cxlrd) &&
> +	    !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
>  		return ULLONG_MAX;
>  
>  	return hpa;
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> -- 
> 2.37.3
> 
