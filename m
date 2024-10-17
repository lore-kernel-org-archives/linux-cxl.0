Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF4168BD;
	Thu, 17 Oct 2024 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729206942; cv=fail; b=dBoer2l8cmVXJx0A7nflKE78B3Ahk0yVjD5C0zSWs13W+vnwGtl+M1wmTqv3lsaeB8d6lLE0tlWKoKE70M1dv4GCbhaz5ZN8PsMnFGG5PDb54F4aS1S96fdsuwk4N3iY4e/yBjS7D73qdfUbrSJUEPXTCoBzbLKfyOptxfNvi0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729206942; c=relaxed/simple;
	bh=Cdgn5vr5XHRwu9VX4u3+20vWs+qzxQ9RYTJ1OfkyxBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cjQN2WIm0+0HRKu0Lmeix+uiB30EDd0syxG7TSO7JVKINWhyRNFHygrjyXPtzov79+mHIajXaoKRs0rPUU78Jz2DPWx4gTV8Dd3judVvwh5DlmjuXTkdDrXWFioEj1740ud65YojJ67ydVLMy4eHXhOimyAs2ZvHZC3RxDAIndQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKT6VH1K; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKT6VH1K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729206937; x=1760742937;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cdgn5vr5XHRwu9VX4u3+20vWs+qzxQ9RYTJ1OfkyxBw=;
  b=iKT6VH1K61hcREGEXQQvwBtMxM7qdrckVBYHkiZ3te5l1mwJ+SEGcklO
   Z1CTqQtAn/mVMiOtAhg5YxnPUcBwTEqic/BsmhSNsNhsl5+cSF/5qYNAh
   qebeKt5fHX8q+Qres6wyz7fxzBAUT7WIpWmpwTT0y6NlrZ1OqJbTGLpKm
   3iIaXmdULMZqIh/KSKFqTzm+8rcoHfjDLqkWeMdEV3dVQaKvGIH0B1kHZ
   tN/0CYz791idgb38GeIEyQKFiFLwg55sgpD69DZo8+i6huG6NMxeveOFN
   q3nXQUTZ/sNscCW9i0E+CRbin3h6oGYln+NFsf3NUCgetIqflrKG9OWFS
   w==;
X-CSE-ConnectionGUID: KX4+ZEU3Qp29FZoq6LP3Pg==
X-CSE-MsgGUID: 7vMVMLHFTnqH/o6xpFCh9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28605510"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28605510"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 16:15:37 -0700
X-CSE-ConnectionGUID: Erp3bpKJSimbLf2V58duKw==
X-CSE-MsgGUID: AkpyR57zSVyqOPytAW8G/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78658275"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 16:15:36 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 16:15:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 16:15:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 16:15:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 16:15:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 16:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoPrK52UT95xJ0i+mrICJAJyJQfU0fYf8we6WAr+/wf9nIZA0miWfk6itZc6iRfAEwYP5VUuiF9+cuTzV6Sq6TmC084TFWVRoGeQjT0Lf4/yqZiYOxJ1w2U/YbvkZbb7CHBz1yNQpytZW8MD1oU8V4pRNrmKlKkuZ4Tg5z1Ergn+Uz1+vDNaofRGPCIz9DGdexVzYYn8tWI+Gt/bOVKW4T+sb3ynHfsdOtm6r9qEiuoMeY5+ZZBIYUGbCuoT3rsGYPeYFWkglsigplMlLS/2LrcDKQgBLhtdFLI0w2BTt/n0+OPCi/WVc4NmokfQOtIA9aCfGXLJc9+642YjlOIZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnNP195sw7VaWrG8ICWm0YWBCL2BQgevYoQ6KwjFPjs=;
 b=tLvMPb3yrh+IO3dnTPjWXF5pqpOgXREBQ5jDuVkC0hUdKuBdPTP+QK8x1P6HxDS79GOhFHI5Qg9LC5ajo5rZZzZuua7KEErqKATZngoOkdoMDuwqRbGuNrmr6G0g2HlLKq2xvObNFG/KV00DE3wJ5ecUK3EoZit5LlJMWjI/TzAgOebSVyAkSP83QOdZDihZgJIv5Nz8aA4acJM0tB1q3RTw/8UO3ieMKPa7OhvgMsp2ItgXpRYSwNNqoGjR+P30Isf0AaNbDY3TlONs9C/0MDo6NNnQI+/IOlxkgkcrhq0xBysU18Nxg+uXL/zt5aSQ1QhqfVnY5I5kFO8sGlQPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.28; Thu, 17 Oct
 2024 23:15:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 23:15:32 +0000
Date: Thu, 17 Oct 2024 16:15:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Huang Ying <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Ying
	<ying.huang@intel.com>, Gregory Price <gourry@gourry.net>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 5/5] cxl: Avoid to create dax regions for type2
 accelerators
Message-ID: <67119a9189428_3f14294b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241015065713.308671-1-ying.huang@intel.com>
 <20241015065713.308671-6-ying.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015065713.308671-6-ying.huang@intel.com>
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: decbc41b-20fc-4ea4-2eb1-08dcef0198fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lqe6xFDaQ9TUWQhEsj9JGPjeJQjZQ6cW0N6kZ6/EB9qLiLAa37uNVpmmo/8g?=
 =?us-ascii?Q?b4Zqbp9UpcdHwj+XDDbxyhf75OQ6aFi46tJ28jZPynRoQP5WpDQmlnNmzU0/?=
 =?us-ascii?Q?8hG732USA8tVQRFzgdg9Ad1bHBuy9PWUO3e7PKO3vcCRi5OznLrYe931lhN6?=
 =?us-ascii?Q?HjPH+5LwyukPV+xZGzd83czYYH+FEMyJ2gmjciXphidZ3qdPm/6TBJ2SWiHb?=
 =?us-ascii?Q?TRvrtinqLJ1c7N/XQnihtgmWNRz5GMjOZ6Jr4TBjJ2M39F2JaTzwvr4nPk7G?=
 =?us-ascii?Q?0nfMdn+/4QS18+9JLUbL2QUNjCUXmvYM/sipdAxmX0T0yiza2capBpp/dFY2?=
 =?us-ascii?Q?CfMn8oN9xnD9kllhhXbarKY+FVNJIq3DZ31WZ3KpYd14Sim9kP4oyz2hmSAf?=
 =?us-ascii?Q?4K7sMR/iGI29ANcOVd08irlLcQ9GYy6vXwldj8km0VC/tXuVGZkCSqnQwwy2?=
 =?us-ascii?Q?Ieln1OuQurxlEcq6YOybg1wpyXHfCisHSwi15lybi5kZR6raCSo+NCtavzfn?=
 =?us-ascii?Q?xVvB2giW34Khh2NSC+GMfg6vr5ON0cgprHov1Wx770ZP1eum+cOsay422cDS?=
 =?us-ascii?Q?lHtdeJS8poSuV322CuakyBBDwq+Ndz0rdUQJ0WU27hGXC4MSPuqqG9wp6mGT?=
 =?us-ascii?Q?tz80QFEza2wOryn94LDZWWxN6clXIe2gP2F5uKLojMJhEucOQDIsMSTD3O0N?=
 =?us-ascii?Q?/Seow/oSmkfuxcxpbSQQplB7QaVGeW8z9g1pCsZdeURDpdunGDrtr+CF2EL/?=
 =?us-ascii?Q?9CtoJfqgfN6E48dKrVw799RNvRwUiwEotYD81AL4oOVbcNmlkuNxh6nqsKn4?=
 =?us-ascii?Q?FdaaQYfJ5uHCDSHf1NELX3+6WXWJRKya4+lZOtxIGbM6Vzkh0CoocydUJI7z?=
 =?us-ascii?Q?IL0OlZVcBrUuqdEXoC/Q86hwVAEYx+54EY5M1FBRJP3KVLLQHdX4djYKkwHW?=
 =?us-ascii?Q?nWNFtM/d0RxWDX9T4vLsbVb8LimZl5P7WzEMZkL8uTebMD/UxlYQPP/Wk6sj?=
 =?us-ascii?Q?CmDin53s7tGrGSACetF3KYX9aANeY1sAF2yUK5q6G7Dt6kRHehpTSMxlfZKV?=
 =?us-ascii?Q?pdNKA8SFx+Ty2fMuFmo+oOmuOxSxM+nwuAcaYlGHpHQq5aY6XGvMJroBKnCt?=
 =?us-ascii?Q?cxzgQH23o+DyTOzKMgRvvFQFLReJW/grWaxeJnpJ1cd29yv2fW4Z4JLaxnfg?=
 =?us-ascii?Q?YcNiUZ7NjgLJ/kV0ku/eRRKiUkESddguxe986HWoiJ7AAPvB5R50LsZL9gUE?=
 =?us-ascii?Q?/dgicWoypIx9oBwuEQY8kwoMOhqzqGVGYrIj2xaQjCjmPbn595ot0LDwMYT6?=
 =?us-ascii?Q?IjLen8folhdpHYqZmOp91LIF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AsB/kg82g7DxohHFfexxgoGxppMh9tBcjImtg/TProFOzHoDuVjl0nFXPPwb?=
 =?us-ascii?Q?zfjOa+PSeYshwhl0pX0RQPwzWB4NA5Fzy8cEm1iD7nzj72VwH7MUVtd8CL0n?=
 =?us-ascii?Q?tQ9+2L8ym/NcsMPODgBtn6howhFZ8CcF7idqj6voI6qsEQMSsKxTLwkUnrQX?=
 =?us-ascii?Q?ePaH1t77gczu+v6K0J8EoCfwVN4lLGahRhhGM8z9gPdF+IEi0nd1mgscM4sy?=
 =?us-ascii?Q?ntdcuXWrdOMbejUF8dY9cAq+P4Eh4Zo90O5faiSmWWl4btPHJW/m9bFeCard?=
 =?us-ascii?Q?lSxqaIldQ0qdpo0w16WhufLCVmLdJliQ0ImZVQz6i3nh0skH+MyAohBperU9?=
 =?us-ascii?Q?FDvQqaiandXoshfw6fr90yq9U8VXH4ttdkkAztsxSRt+qfaK/2+rN8MYN6BO?=
 =?us-ascii?Q?BaGDdMrgapwmGREKNCDg26Kpky7BcI5FRRwVBld7G0w+DRTPffNnb+suodpi?=
 =?us-ascii?Q?eTgElwDlgJY7gu+blwfPFZwgrmpId6+KAOeHhJGT/UR/CK+AKxZG/46/kwjY?=
 =?us-ascii?Q?nufn2FzkfArnJN3f7EQ5EwtaI2QHj9pIpf24jgIvbZtsca8n+CdHSahHF/U7?=
 =?us-ascii?Q?PAi/7fqqaFZsUPKRYqKDRpivAsLtX4Da///y5o83lKE79qKkEN87FKDaoTFv?=
 =?us-ascii?Q?sou5k1RRJ1TPUh/zauWqKlms36WfBdyOL2/U8vhrPwwHHeMM1irhDYHM0yub?=
 =?us-ascii?Q?GLCfonx1FWUgeYaCunVVfYDlXE3KymUVs3tXxX8ugZt3iSklPEMSXYOVF9vD?=
 =?us-ascii?Q?CBy7qO7/TMoWOkjsGpp5CJ/Se7g2VoD9fksMbSCFPJTQbsS7rSaemo2TvtEf?=
 =?us-ascii?Q?8NpjRbHkcFPX5X9dYzGHdLMm9Bm9W5rbpCAGtzAF6Of9UDddZKWFDHLZy7Gl?=
 =?us-ascii?Q?NJWfMoGqyLg34EtBCOHjxy0OT5Q+/4cb1rDmxHSfuK3Vt9f0KFPEWUVF8ykS?=
 =?us-ascii?Q?LCssFbqM5ToiAO/3rHkwO/5CUMbAABTxOUhYlNkuEGIcYt8xb1A6g2QSZAdg?=
 =?us-ascii?Q?6EgYLh/dZwT7P/7EJ5HHNmlOxwhkQU4pmNMVjLZ1rpmNlu7og7nxPmz10pzR?=
 =?us-ascii?Q?/kESkWPGTaCbhjq4cYmN3D0VONKHXjqrCdb3S+9C/OuKPw+bsdZMEoYwLrt6?=
 =?us-ascii?Q?SSF6Es6KioZ6u1wmby8VT0HnnIJWGjwDEMrDgqUqpQXESvcVwHVf1EslAh8k?=
 =?us-ascii?Q?l4t5VhL0ICYOHWQX4OB6fMyFT9d2drxXPdAeWwKjuNbCdVpRUlxHE8GzJPzX?=
 =?us-ascii?Q?PsL/cz3QvbMGmr6WpYsn3VH4cDzq7IoCW3iZtebc/ZtMBvYHp3dnS/xcDM1v?=
 =?us-ascii?Q?thU6EwntbVmLCECERtPYY+6nFBScRgdxI/CEhImvmuOtSeUSuln0koXXgreB?=
 =?us-ascii?Q?5+ftaAE2dGYxUyErhAoa/eVmzyiubxgQjta4Vn/wOu9bBD3GtqDoW0nKnkIR?=
 =?us-ascii?Q?qMofSqLP/oqCCg01tGOCt5gIHmqyjaRYO01ZiqWcH+dVNKb2kyILTpFig0VI?=
 =?us-ascii?Q?Z9aFNtfFYVEgeYK0jcsJeuH9vrWkmIQdrK1HlfL4BSQrkkKMmuUef1Yx1TGs?=
 =?us-ascii?Q?77WdK05Ge/QQqhABuajYFUAHp+nzBGtT4sLlazeaxhsZa7G3nJCibBfqI7tt?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: decbc41b-20fc-4ea4-2eb1-08dcef0198fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 23:15:32.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgbIVSCSvvHMzYm2PMIG6agB4anZgKb8qq/TBwNln+ySgX7cVd3mUVasifNSAcGAS1lb5UJyTLhSaz3Octecchl5iics8Lvv8Omex57F6WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
X-OriginatorOrg: intel.com

Huang Ying wrote:
> The memory range of a type2 accelerator should be managed by the type2
> accelerator specific driver instead of the common dax region drivers,
> as discussed in [1].
> 
> [1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/
> 
> So, the patch skips dax regions creation for type2 accelerator device
> memory regions.
> 
> Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/region.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d709738ada61..708be236c9a2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3473,6 +3473,14 @@ static int cxl_region_probe(struct device *dev)
>  					p->res->start, p->res->end, cxlr,
>  					is_system_ram) > 0)
>  			return 0;
> +		/*
> +		 * Accelerator regions have specific usage, skip
> +		 * device-dax registration.
> +		 */
> +		if (cxlr->type == CXL_DECODER_ACCEL)
> +			return 0;
> +
> +		/* Expander routes to device-dax */

So Linux is this weird career choice where you get to argue with
yourself months later. I understand why I took this shortcut of assuming
that the coherence mode determines device-dax routing, but that is not
sufficient.

An HDM-DB region could want the device-dax uAPI, and an HDM-H range
could want to do its own uAPI besides device-dax.

So, in retrospect, I think it is a mistake to assume uAPI from coherence
mode. It really is a property of the region decided by the region
creator independent of the coherence mode or the device type.

I am thinking that 'struct cxl_region' grows something like:

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..4cf1d030404d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -511,12 +511,25 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NEEDS_RESET 1
 
+/*
+ * enum cxl_mem_api - where to route this cxl region
+ * @CXL_MEM_API_DAX: application specific / soft-reserved memory
+ * @CXL_MEM_API_PMEM: direct region to the NVDIMM subsystem
+ * @CXL_MEM_API_NONE: accelerator specific / hard-reserved memory
+ */
+enum cxl_mem_api {
+	CXL_MEM_API_DAX,
+	CXL_MEM_API_PMEM,
+	CXL_MEM_API_NONE,
+};
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
  * @mode: Endpoint decoder allocation / access mode
  * @type: Endpoint decoder target type
+ * @api: What if any subsystem will present this region to consumers
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
  * @flags: Region state flags
@@ -530,6 +543,7 @@ struct cxl_region {
 	int id;
 	enum cxl_decoder_mode mode;
 	enum cxl_decoder_type type;
+	enum cxl_mem_api api;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_pmem_region *cxlr_pmem;
 	unsigned long flags;

Now, I have not seen how Alejandro's series handles this, but this
type-2 series was shorter so I started here first.
