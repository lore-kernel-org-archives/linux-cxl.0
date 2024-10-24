Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D11CBA17
	for <linux-cxl@vger.kernel.org>; Thu, 24 Oct 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786868; cv=fail; b=pP3rUsqPV/rcQ09mw+9gqC1HCV0Iq+EuTUl6TEuF8XWfX0TrKc6rlyVqLMb8pr8Dfqs5cyn4YbpFtckgNR7QMOnVBRPYzFF0UbkBF1cmM8lHzZDIIjQn2HzgS4XmPJKeYvL0YiotFFtMsuBwj/itZnHDZDknY+KBYK6+dAFZXms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786868; c=relaxed/simple;
	bh=u3XWnxDslpBdVoifMQ3e80MNJx9wJznm/Ca67DolCsc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mGxmEBZq9mMk9f0Q6rEzZDE5z64gf1hVqcrzKRPNYUUe5Bq7j6QiefA8ycdZ3QEKL98ZP5tCXjYvW6EK0YsKHO7zM9jhujTS7guy3r+eN6B7ARodixOMuuWraxXx7rdMOyyT+z+DMUov+SWIDa7N+n9D9U6yZQ/HvbYpGfRllck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiyxwnlu; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiyxwnlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729786866; x=1761322866;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u3XWnxDslpBdVoifMQ3e80MNJx9wJznm/Ca67DolCsc=;
  b=jiyxwnluW54GYP1v8WE9GIqyyT9mKE2cjljOiK+6t0ihthBuGDf9Yfn9
   xg0n4Jup7jxniaSdDMCVffkk2YNjlbKA1cXxjdBynzYqRiOhNJAVWTB4r
   9eQ+F22fe4neF7ZnwZUnh1YZhpaYxZ/6vSqj2uKX4aFh8/NMl0H5thFhg
   5WZApKDEbllghwylnnJmw0A92d7hwsg3xe++Yu2reKuy+dugRyCljbp1T
   uZQMr2B32nLkenDGXHbjw+f7f5g+exT4qdhlMlE2gBoaVoH4boP9zWm4J
   3yCeKlZJ4q6Pa6QT0bve4m9pLGwnVHurm5aR5uH3G4yOU7utBKFRf2Sam
   g==;
X-CSE-ConnectionGUID: QI9ov1z8TaO4c5t3Lk43Bg==
X-CSE-MsgGUID: JOLjdsEmSyuwD+GfOPdHsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33122757"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33122757"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:21:06 -0700
X-CSE-ConnectionGUID: MIX6ajxwR96HdJ5e6PkbjA==
X-CSE-MsgGUID: 2+Jody8mTRy65vLeAW5olw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80562005"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 09:21:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 09:21:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 09:21:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 09:21:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug6MLpEcT/FjLJ2HCjWwtSzN2oci08shlJVr39yWiTiKwfoSOjnpfJp6buu4/M8KKhekXDw3h9eWKLQdK1qY7n3F4v5+ilDdIw5YeBITtkC/75oovsw1FXJMF8VBYqnTvbdKELcz6UyzQ0CGV9oNj6jWvXeC8vonCpwN4Z7zAdDYp/erJ5RgCH2bQLki23JKArFvxgtoUOckY35bU5e+mMh60KW09gtTtAzlcV/Jxsb30F1DhMoXSXceGv3muvM1WDjQ2lquDhq9Za5lwQiW+FbKPHWO259K23zbo6NC4zB3CwI+WI3Hye3p53P0lS4Nna1rtXVaALq+EUiQZUDrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hddheE1f0NxNX/qQM8h5BZ8y54pFAshd0wpOycgzpZo=;
 b=Ngr3RuFXtXijr7//b1FXWuRF9VYdA6/e4YaDOPbP2ZFjAml0/fxv2VvawPzVuaNLT7v8Cki0QDr0t7JRc94OTgHKBp66pOeCnDBSfa7NNC47sqCeVvglf2i3fXkIEDXja+lu7bX531AmuJDONsPCfZHVRzYg+a+7xgBu/XwOGuvjYa/u6PZ4sNu/2zQHGqLDhGxxlTBB09NL/A+swvgAaroI/uCKFgGswOjy6dx64c10eR1geTdHjtAkT1FOfbsv+8gz608rZDuNaSbPVxHB2Ou4aRFshiMceLWZTfemXzYmJjUQsgqcPgMUwYjcHHjxAuCBxsNCB1T6f3oPbByp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB4909.namprd11.prod.outlook.com (2603:10b6:a03:2af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 16:21:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 16:21:01 +0000
Date: Thu, 24 Oct 2024 11:20:57 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>
CC: Zijun Hu <quic_zijuhu@quicinc.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] cxl/port: Prevent out-of-order decoder allocation
Message-ID: <671a73e97fc61_f5b20294ee@iweiny-mobl.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964783668.81806.14962699553881333486.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172964783668.81806.14962699553881333486.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:303:dd::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d26b37c-dbac-4123-0490-08dcf447d9f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g3pyB+573b+InRM3B/FSOKlSS6BLcCKqgw4hactBtk1o+6/fHnDnivEYgC9X?=
 =?us-ascii?Q?8o1+A45bhrUTcGUYJ3Uf0sEubjPCcyWkBMqo80xn3f57GV+aN4Fqvemb0PlD?=
 =?us-ascii?Q?x4rU3+FmNzvjlQumcfkJYjy8cA0K/1xiTEZTM+9kOMGySiqwwpu1P/whWS6g?=
 =?us-ascii?Q?23nBvEKm3/37nt/BysHeRaK9oYARg1mBkUIl70nqhlihighKSuhbEXl5TGNg?=
 =?us-ascii?Q?nz5KHiKkZahCUTkQOJNtKR9QBzSY6EF3ftSz5AUAj4CxPtdoipfc5tuJp9Pb?=
 =?us-ascii?Q?UGXFBj/G2nPL48OCEZOVQZfI4TJxh5B4LCpGIo3l6LpYWnI8J0zoIJAvNbxb?=
 =?us-ascii?Q?uFfaPgKgFNymrLNNuli/dw1e/e8CNZn9peqd+c07tRq8DinlJCtXJ1jZMa3O?=
 =?us-ascii?Q?2ej4PDD57VHqwrvrNIG+NTg78I+HhDqSNzdcr1pVCPUI1lbgIDLQ9HuOPPnQ?=
 =?us-ascii?Q?6WmomT4JDg1EAHU6tweYx4Rx4q0l+8J4O9kpmqtRNUadsU7I28Bk1CUWtdLk?=
 =?us-ascii?Q?WihyqylRow2t6J+VP4q3RkIRJ6E4a31prXet6awwqI+TS6jUuEAHP/6U1BEu?=
 =?us-ascii?Q?gTwNp6nouWzWnTVMcKhp6HQGBXLFeytEneDklFvXvPOZhuXMYZq/SbeShq2w?=
 =?us-ascii?Q?07IcnZg9xemOdokhgc9+/8kA3nn4AvSp2i8O6WAapbCbMm2ZlFwA6oLrjTBu?=
 =?us-ascii?Q?5PjGOAfdvQE2p2liAs8t3d0eXn1XFxhNjrr051C2+qr/IrUdIx4eRkSolreB?=
 =?us-ascii?Q?dmg2IE/kgEPdP/B3t2jyvR82S6Hy+Kt+1cVC7Yh6FxMeqLYv0K8rZ8+q/1ue?=
 =?us-ascii?Q?VSWcIvailUEJyXQmUxXe3uwg4l/5HcW9mH221/YydKhYeC+G0fmHCiqVdmww?=
 =?us-ascii?Q?JOG+moXThp75Xsf+/4XV+/xWgcxynXljo8iwEqC3Z0M56MoZDCyK9uqf2db+?=
 =?us-ascii?Q?Hy5Eep4hBf6CeikcCe6diUqWuDcSEVamoe0pz55aK/CWDDZ/oaVdUfrkwYpN?=
 =?us-ascii?Q?/P6WwSyotefkOlroY4PtYi5KKqdd6KrJh+lfinMHNSjASR9/La/pfcI5TalT?=
 =?us-ascii?Q?eD2Abc8cvDMUCHNniBjtCZE/mu9qsk+dDtlEgN3omU8RphbaVbUUZf2n54C2?=
 =?us-ascii?Q?MRO1o0HH6gmjfu46IKmPd27+flLqTtu6DG+1VNQuOm8TN3XAYA/RVhJiLr+q?=
 =?us-ascii?Q?XEgc182TfckxXDtM8AtXQtlHu54sbcyOHV6HvXeYVkTAy1frWouD8It8IutD?=
 =?us-ascii?Q?CF6ZkS+WqYaPIhirF8ywes+J9qMdCZFiRvn8Q+CzIr2kPrEnGXmWp/EOVOK7?=
 =?us-ascii?Q?N/8Di5Ho/lWfraMiRKFfWOar?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQdv1IkV6uUw+ShkBInjJ5u1AoNfFOTHknZtxq88OfghBenlCvV1BYVG5O18?=
 =?us-ascii?Q?5zScS9Z/wEmsWDGV2SsSN5STSySGnPRDZBkuNv5Dggcn8k2oxIPhkQHZEinj?=
 =?us-ascii?Q?5w+E7fjuPnl29HZD42OuKuyZq9I0o5xCYRCj5VeeTUYVcqhIowhOmz4K2rnw?=
 =?us-ascii?Q?tGr4GVIoGm0r+MltRYlM05g2ib1XEtbZ4b5qG+MmpHyEOzF9Ym1v9QnaqZJA?=
 =?us-ascii?Q?QAMb9TMa0IbfxUe55HqGSer1DP7OV7aiG9ZxUgtg/2ZdcFAw5wVCAx36pnZL?=
 =?us-ascii?Q?JM0QTBAeklIe5oSnZhcoEpyJvFtk1ZjOBwDcV371FevRZC6HeRt2gssN4S56?=
 =?us-ascii?Q?WEeFNyTzBoF7uv8n6/28jUCJYdx9I3AuRUQfNKDkoMr0Sg5butv2LMHTdnbG?=
 =?us-ascii?Q?RbB0R6TSq0FLsLnrNJaF6yoGBDRgDEzEHHvkFK/dmHE4+ksjxIqF6dMdfZi8?=
 =?us-ascii?Q?ZjJppK9oy68lILcqUM4MfJnxSxPNyB/xVl3j2ITO4Wr9Fv2Vhmz7F2eGv5Jh?=
 =?us-ascii?Q?IuL2IWTV39sIol9fl6ylRDEDAhE5orH398Rv871TB+GK/tJQA+ztv4n0LaMj?=
 =?us-ascii?Q?ii/O7BAgLrk8Xuv6kZjg63fTJWx4KDXdMugNQn3iwEvBn53w2qB9SsdUNOSp?=
 =?us-ascii?Q?Tlyano/L2yI5R/9rQdNkCW8x6/hSneHDVNv4fKQa2aVM+IDlfB/r2+OJ9YUj?=
 =?us-ascii?Q?wVcHo5V9dQKloZX5mFHxt5i3oKvdAe8xKd7Ll26pODPEbq/N42UvOAFj06zR?=
 =?us-ascii?Q?cYMhEuhnEwABPRITxsLjpurYLzAz5r20LpSdo0E994BEdTws610JY5nwu8fI?=
 =?us-ascii?Q?seXrETc0bFxuDKBFcpBiKdBg4UvisG6U0ydXTZ58tA91V64wG82G2bPtCfit?=
 =?us-ascii?Q?AJQLv1MV3vyjlFYOM0vLHAF+tUAIW1xrA2lE+TFDGkCm+mohUkD1mPyF2Bra?=
 =?us-ascii?Q?X4IAS9SYecznPbrB18ANDcXpxJOd+t2KljBSK/oiN2++jFSiEX4GH8gbeEoB?=
 =?us-ascii?Q?Wqmt5mrilnB7o5Ey/HtFbqbV6N4S5LDzc3r8kJF/agv59S8wvxnoM3CL6boo?=
 =?us-ascii?Q?EaPdtcH63UNojCtnjy7W+kGBkvuvsXuFyhneYmd8DNKFdo2Jf49uyaPXJ3sU?=
 =?us-ascii?Q?Vxa2y5KSdD3lyFpuaPna5swC1vC9PpYZJA8tIkzXFntLBHPYhTXBtd9MDP6O?=
 =?us-ascii?Q?JddseIzdmdUxc+O9hdR6+wCbjVP9YHHicSprITBaDtU7e9D3p6opO0Ui7hrB?=
 =?us-ascii?Q?K7eo0zNmxz808nNI9ZLGO/GmWUhYHIZvQ0lOoUa0T3CS66a3f5HsjAr2EGYr?=
 =?us-ascii?Q?QF9NSD31emU6N1sUMZhji9sMGk72jm2ClQo60xUQwop1j1tmog84jyPwzcn6?=
 =?us-ascii?Q?oQTEn2tPKSpcXLFmpr59IhZvlKjD/l8AUNxmjJlNMDp9V79rxiNlHgX8r0tW?=
 =?us-ascii?Q?gXJ6YqH3KEJfKn+b+/PN17TKRaiIjuNpmtd42CsNiWMFdqGlmA8EPe2tP/SH?=
 =?us-ascii?Q?lIzp9GDLra4w0XYbuYn1jC+Ytxg6WbEy6qjb0/NwQQ+NzxcNhAhpntDxj+7r?=
 =?us-ascii?Q?LmJtz2GT3bJgzvYr0DwsP4rDQZNKrN43vXBI5fLP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d26b37c-dbac-4123-0490-08dcf447d9f0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:21:01.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/nJaPw6g0SHT9JIJ81TlNxG2ccjTShGNI4PBG7hDxpo0X3NcY+8KJLwiXnlfyeISvU4JUKbM7Gss1JM3dnjrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4909
X-OriginatorOrg: intel.com

Dan Williams wrote:
> With the recent change to allow out-of-order decoder de-commit it
> highlights a need to strengthen the in-order decoder commit guarantees.
> As it stands match_free_decoder() ensures that if 2 regions are racing
> decoder allocations the one that wins the race will get the lower id
> decoder, but that still leaves the race to *commit* the decoder.
> 
> Rather than have this complicated case of "reserved in-order, but may
> still commit out-of-order", just arrange for the reservation order to
> match the commit-order. In other words, prevent subsequent allocations
> until the last reservation is committed.
> 
> This precludes overlapping region creation events and requires the
> previous regionN to either move forward to the decoder commit stage or
> drop its reservation before regionN+1 can move forward. That is,
> provided that regionN and regionN+1 decode through the same switch port.
> 
> As a side effect this allows match_free_decoder() to drop its dependency
> on needing write access to the device_find_child() @data parameter [1].
> 
> Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Closes: http://lore.kernel.org/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>


[snip]
