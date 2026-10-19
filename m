Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792444170;
	b=KKxK4NL6jBAkCVRfHzCdCyidia2/MCZQbqx6rq6c9YQKuE8jJGy39W49N+/MuwBgnsl/
	 5NuCoL+PxIrC9JKq1LaTny8ztDHHqbLT1/siC9M7x8x/fxqGR6uYL1ctpv1EUuCAFFPPK
	 3IkyGM2i3laWnllW5qirzuBO11JagPd96pSymS9A10xQt5bV5tIU1SjuuzsbUqb66N5Mo
	 m4OKS+OJ2gi4dg1izNYVtfZcIRpx8KpGWR0G59fUPHFXmLygNLzH5IY40/KQAk947Zf0/
	 a8j4qIv1O+Q4w4Xw8Hj61I4EJizwDg/GsWDni0QfNi1TF+cfpnbMNYUSoGTHO3ikKWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444170;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=atO4LquU6eUeeFcxXM4S7LjIODqk2IA71WNj0X5zbow=;
	b=obdAF92picX4dZDbaXsiPFfN4vL3JIeZ7LOKSSvqU0l16Fw70Enc6B6IFglZjSDtKO/y
	 iDs0bXNB4XWjjDt8DCTavyCaAOiF7mc0ljoy6pCBvg/2uexkw5RkIvlmIkYRfmKbzEqhK
	 8DL669LrkCeP2nE8UTtVUCWBsgp0HCqI+fnCMQS1uHpr95daRahlzCLYZ/2qFTfjY4fGR
	 687OKV8Tw7dS5Z/gSxWbj1oGn6xNFun7pmZg2Oc/RMP3wZTke/Z4kOo8tzPoPnkBdlb1a
	 Rc5eF5pUUjtigHLtuxoB4sxjqUbrGDbRNhC7sja1+AE6U23Fl09Cp5OSucuPfrvL18Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cf1wUmCW;
	arc=fail smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAEF606A319
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 21:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FAEF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cf1wUmCW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792444169; x=1823980169;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oFrZrKsW2+MmZWIQX/zxqyKAm1wM2hL+HnCcNt1v6bk=;
  b=Cf1wUmCWH+6Kp+HPPVLUnc2sUGbwnl5fP3zGqcUEQ3yvH26kM/j+Ps1W
   LLooD69cCQTMIJtpTgPmisu8PWqCTQ+1xEDWqExZEU+lXO7oJTOXNlitF
   4cWg1YJlnT4ZbHUfDafAcHwPbjJoN2yOwKFBuekCafDNwgbf1+Hl/Ef6K
   F3g7KatdHII6znJPLC6eP/c5dTIu2/gBEL619bPCeWVCoGEL4RYwfJnq7
   h9e5YUJTDxTxoaU7IVCerR+cNwIQyihTumwuOYVht1Xw2dUJ6ZWCxIe5D
   9S7qdBcCf6LGuP+cUQeiOzDJmHw2070sxAQb3ZAST2RHSvbbJfrD73iFt
   A==;
X-CSE-ConnectionGUID: c5v/QG9GQhK6QD/Up0ozmQ==
X-CSE-MsgGUID: QVqt4FzCTKKmFsJikhOB4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1019221"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1019221"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 14:09:22 -0700
X-CSE-ConnectionGUID: K2nbl/6yQCaEjMrAYJoqsw==
X-CSE-MsgGUID: am9J9lZnQPaQHyyGWxXOkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2693556"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 14:09:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 14:09:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 14:09:21 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 14:09:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZOUqWHDBi01dSrkuapxCOUI621wUilwrdw9z1I9aELsY/XmIxQQvXReYFELWTs/bjvxbDo6MabgOXOIV9esLUA15mCe9ixjphTEcyE3ZDSf3zVcSCKWc/L2lGeELfWlAiOkqqbyCQh/Pu4GYz9XvrLyATB1yBUtimL5ZPnDCdxPKr5zplJvRowx1XrqMGG7V2VbO8JaEXmeVwT6M1p522+fNG23Jg4lcX0y6sTRyIogxXbveWFv08Us1Bdl7PKVi7qyIyJJBhTCuCErkOvbnE48VgQiTRkUJXulqryH0/+lYwZXiT5il+srxkqf9n46S7i0HfXEMZ8b7R5j8/mqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atO4LquU6eUeeFcxXM4S7LjIODqk2IA71WNj0X5zbow=;
 b=ZpAimPCzOUm2JtXhhL+vVRzjlWIVu4VwVZkF9kR51/dJC7cH49F3gmX3ASiEczE1+U75c+i3wOGKeNFA2NomRbqExpfEqm0X7I2s0AdQ1CWxPBBShjbnlm7nw+NdcPVxyHQ40j9opw9D9Cu0Wn/9OFB4/E3mVF16r92vglY/122iykVDxsTUkjamo5t0oevIKXe0H5SyUXGeuJS+bnhUvgLZvJkZPQmv+lCMzrRFxzxDS9lwCV1BGMbBWjkLQz2plYXDDFd8gAdwj3sPkA48WSLzwE5Tg43ZNt43Q2gignUAvRmEoKKWWdkTSjakx/uBj2i6nL1jeyyB6Nn0F3+8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB5802.namprd11.prod.outlook.com (2603:10b6:806:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:09:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 21:09:18 +0000
Date: Mon, 19 Oct 2026 14:09:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl: Add KUnit tests for HDM decoder encoding helpers
Message-ID: <ataG-ibFPWeYI0ZS@aschofie-mobl2.lan>
References: <cover.1791949910.git.alison.schofield@intel.com>
 <73af16d29561eec944e128af116783e20b990dae.1791949910.git.alison.schofield@intel.com>
 <20261016210137.64db4a14@jic23-hlaptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016210137.64db4a14@jic23-hlaptop>
X-ClientProxiedBy: MW4PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:303:87::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d751d55-7f0d-4bda-cfd2-08df2e253ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: txC8BDFkfdYQ0zNfJOCzIs0LlIc2eP6bX5/1gGkabVCqb6nGg2bA2Gv/1IzI4azQlrZJvDpmQR3X775PVJbtIOCDfjstUBsEVBkjFA+wtYTeT2ZYJOxHhkHL6ZT2M+ueqG0F8XzYXu5Z7WOtoV7VtSbaGgDmeVzLCA0dfTookiijulZEIB+zsZeu/k7OFFnKidCmM+1MtlICQwtGK4wj/DP9l/H7P7V0Kl/F2msNuoPFUfF3I/pK1C8M6sy6//tnb//SCBvbR6Mj7oQRl5HsgiV5FaA/teuRx/oH/7Ori3idisLknSOJzQRYfjttJh23w4EGEV2OKbSWj4mEmpgNPTTAd6P/d0XX1Vk+sKOQhgM1u0Qc1tBDnd3ny9iS3dMO1cy+TGj7Er8OZnPOjZOKRGWU/5XiHQoz9bmrcpWGSsj16YKaErabD76TnGHX8Rb+G3zUE4z8Uk1qyFuFWDTEZVfHNlCs8wLgC9D+EbwffgyQ+LxSDq8b3f3OpTP+0vTf30WzcX/uZvPZoV5jStYJTvg3pVRQb7If5cByIiKyCg1q4jpXOZR3TPGvxgbI/YgX9pPZayh4b9Jjups5q3dJCidRWLtfBeVbURvDaRdcDUhGD3S7Mos+cOGZXBm2xbyLvssoDm28y5kXfRLw25Cus4WUiBVkDuhzFlWxf3vIbWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ocMuq/0KD0oA/g9JTjnHXBCKI2DXdpsvGR815nRxAdbak8NXmwoz7lGnQGvc?=
 =?us-ascii?Q?sOH2BG9ZgBc7pZOxX+HyKkTkJ/YH+sAr6H/dZQ4xol+kVWj+hCy3HE3ZHecw?=
 =?us-ascii?Q?ju0tL6T5Tt9q+xwPMqgAM+OqOdBaoOvEwWfpbIeZDU6BEoQokxAObJiao+fZ?=
 =?us-ascii?Q?EkAJtV6dSUGTaouuk3B2We/X8BPLfxz3ETqC6aoHXXR7MBCR5q4+5EEKoAr3?=
 =?us-ascii?Q?/07uy07skEC5NXJlJ2YvHmznJ++V7tKRDK4lOCbaUcCUY83A3QhTG8iU64ee?=
 =?us-ascii?Q?o/B0u5fEyjxE32EuUHrunJQ2NXDuv74FGsOOgspIXvnv60gHtkCG9vEAWeH8?=
 =?us-ascii?Q?/XISDdRkLwp7ewUE0VnU4bse/DYGzt8bDYdw7cJTB5Kf2/TM0SGiuo3u59qi?=
 =?us-ascii?Q?5cvMuAIPCv55fJvVTnbjWwRGtv1gHj3Aq+rn/6gtlHtF5AflyX43P6koXQz+?=
 =?us-ascii?Q?1YmyalHLhc3F9FzgJtWI9slJYcmNgWWQFl84UqYSNs59T3bNnGLiGO2EmCiJ?=
 =?us-ascii?Q?qKSwPGhJX8FP18eZeZGAW0d+AVmsQ8numfmq0bGAgj7Hah7xoiNWqV+cJGOb?=
 =?us-ascii?Q?xggZOcNsisUEbuVHhGYO95wT3GjIsh0mt+1pXzOojhsSpu/YyDqXUrSQxxnE?=
 =?us-ascii?Q?KreVg55EaPA+8wDgnHkr2cW6hA9l8w/ZqQUXhYSRUelgpmYevkl9M4SRIv2u?=
 =?us-ascii?Q?vla4OqO6m/TjigGtsifZfas48mZCE9ee5QGL1VudhtBnIHeRQamB9c8g+or+?=
 =?us-ascii?Q?ZxTnVKMxYVhh+Bgs7cQBDmgIlKs34RXZzHiVPBgJCQe6+jIskgDWIao4mKqn?=
 =?us-ascii?Q?2GblAPAp0XRU/2wPKgoFBfxilE0H84JCDhy4A990EY37/60B+riPCzn9tV+J?=
 =?us-ascii?Q?B/jj81Sz14NNmLPuisH5kcOFjWuQnnVTTXJ3uWoTS+US7khF5ZqRZZ1fBR8X?=
 =?us-ascii?Q?qYKie4IA0Rv98blELgqhJ9mKLxExXUHqt87xjyARbw2rgIpfVvmEDS00U9Jy?=
 =?us-ascii?Q?1NWzD+y3sry2tV8FUT/VgWGukJut7D/uUUyr0Cg4yKSGUwcx+J4L02bWmyBd?=
 =?us-ascii?Q?MBYOTpR1couFw1uYOp8hdu2xXyAYaurwZyc5GGgkJzvrMKRG7LjQfZgpUkZP?=
 =?us-ascii?Q?geQtg0aHmtX7EyQLDGirs/240psFkM5l/6yUYdzQJA3sk9XHMuVPvpQLUASe?=
 =?us-ascii?Q?VV0cCGHtXz0LOERQhj7r2T62gIFlskBW95gF4d/p7AIzUI8syLfHu3UMS7ha?=
 =?us-ascii?Q?dpJo8CVg5dNkHJBZxE1cP+rsO7gcBY622QYZZbubrZEmpwdBTUXzOLhyPMFC?=
 =?us-ascii?Q?HSADhfOHdPMiVibb++f7RKsIox3QyXBMygTSEYBuWWRHh8DJp3uu4vAMPpqa?=
 =?us-ascii?Q?WKwwg8xoPZjHvjP6BvdF9WQ3Lw91iDYbp81yn6xgl558QJD3LClJtX1GYP3j?=
 =?us-ascii?Q?5KtM13hTY0YwIfXJgwSgvBRIUm7Xu0YtlwZ7l3oz0Mzy84thI+2Ocsoekeo5?=
 =?us-ascii?Q?Q6e8B3b9VBIokbB5HUj+b/vLawSsf8RT/6mDNm4ybniuhT/9HNcvDLsDrIbr?=
 =?us-ascii?Q?PJXe3+Tfak15pImiCMHlXoiOiQysZg2mgBzdk8Lb8XKmpMuXse7Mxd10KAjY?=
 =?us-ascii?Q?kV6l/M6nFGQW6HgbfKWaNG3imrS+K0at5FPjCw36BY4lrXqOWmY6BnaRoErm?=
 =?us-ascii?Q?s2uM6NIU/MACNXEvqV3kpIOfy58tNbgyH+H1jcJr1/XGHeISBDgWm/6vNe+X?=
 =?us-ascii?Q?eJHFVtPcEGuBmp7/KYYh7wFHT01zfWU=3D?=
X-Exchange-RoutingPolicyChecked: FZ7xtsXWPhcZvsb4F7sxxhusndsA6irJRqff0yGdlr3eGHRc3Ozgup8Jbuy2QtrRME8CkD62DPDdvbbtpFLhEWJNUfUb8uYXHJBnNAjkF3/VQDivrfPD/82Ubx18cBkterKOyd8+Nh5RvGVQQ8ezuZl6B51hod5ELuM5zBeJVgNsYqj7RxjXE6Hdhnu0Ru+09eCwF1HGPaYu1z7xvDxWS/tglCT2vu2nNqa4OKQdTmdeW2Wn0WAp0Bit6/xoo4or0CoMqtEzJn6gY55qeWyepMOpda+73agKleQWPBczP+aEJcBrq05mbei+/4eaGhzKVFQhdUpxgY39XVVAvgVvIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d751d55-7f0d-4bda-cfd2-08df2e253ca0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:09:17.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dU9tbqkQaUxMmJDeF4L+mhotlPWhWZwN8ZyFLPtomaGA/nAN3xdcTeLcb/tp2RGS42UJ0Rgg7q60/BNeB0mCfYoP5fSUGwI9rwRxy87RTwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5802
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 09:01:37PM +0100, Jonathan Cameron wrote:
> On Tue, 13 Oct 2026 21:17:53 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > The CXL subsystem has no KUnit infrastructure for testing self-contained
> > logic.
> > 
> > Introduce CONFIG_CXL_KUNIT_TEST and drivers/cxl/.kunitconfig, along with
> > an initial suite for the HDM decoder interleave encoding helpers. The
> > suite checks valid and invalid encodings and round-trip conversions.
> > 
> > Use a single Kconfig option for all CXL KUnit suites, with each suite
> > built as a separate module. This allows new suites to be added without
> > requiring additional configuration options.
> > 
> > The HDM decoder helpers provide a starting point for establishing the
> > location, naming, and configuration conventions for future CXL KUnit tests.
> > 
> > Suggested-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Just one thing inline for the only case where the test is exhaustive.
> Either way on that
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> > diff --git a/drivers/cxl/tests/hdm_encoding_kunit.c b/drivers/cxl/tests/hdm_encoding_kunit.c
> > new file mode 100644
> > index 000000000000..54a7cb078a06
> > --- /dev/null
> > +++ b/drivers/cxl/tests/hdm_encoding_kunit.c
> 
> > +
> > +/* Decoder Count field of the CXL HDM Decoder Capability Register */
> > +static void hdm_decoder_count(struct kunit *test)
> > +{
> > +	static const int expect[16] = {
> > +		1, 2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32,
> > +		-ENXIO, -ENXIO, -ENXIO,
> 
> Can we make the mapping of bit to value more explicit?
> 		[0x0] = 1,
> 		[0x1] = 2, [0x2] = 4, [0x3] = 6, [0x4] = 8,
> 		[0x5] = 10, [0x6] = 12, [0x7] = 14, [0x8] = 16,
> 		[0x9] = 20, [0xA] = 24, [0xB] = 28, [0xC] = 32,
> 		-ENXIO, -ENXIO, -ENXIO,
> //hex is to match spec that just lists these one by one by hex value.

Thanks Jonathan!

Added to my v2 prep but w a different handling of those trailing ENXIO's 

static const int expect[16] = {
	[0x0] = 1,
	[0x1] = 2, [0x2] = 4, [0x3] = 6, [0x4] = 8,
	[0x5] = 10, [0x6] = 12, [0x7] = 14, [0x8] = 16,
	[0x9] = 20, [0xA] = 24, [0xB] = 28, [0xC] = 32,
	[0xD ... 0xF] = -ENXIO,
};

-- Alison

