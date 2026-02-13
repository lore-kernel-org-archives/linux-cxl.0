Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB627456;
	Fri, 13 Feb 2026 04:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770957144; cv=fail; b=rknwOEGb7pGoyPu6Vc+CnLfk47+EJJ8ye43HVPp6YuGQZCVb5053cbIeYCMiVXBv3fj2aUQVEXhFMYpUFC2RL8Zkv5GaYUNcGApZOFGu1rB/bt3JMEdIL4TCczRQXyOtqNAGakXNgf6+mveUUBR7XVcCPNzm24ufefQjTTinpjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770957144; c=relaxed/simple;
	bh=tke4CASsiMozLiSK1lbWkvHVSiZNffG4/Q9C8wiPUYM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KJB0S7jphnPGJpN6K7uOE8Qsh1Jsf+CIDvNMGjL0ZyNp1lhNCYcVnY5UCimsGsKSK4gA/7xs4La0Aen1FWcFOHUAbiB5QKs/pvzSmFEO3g1ch7xMxVP/mvyjFeiebR/f0q/NWRcAVuM+JmeTyZQdlzhItp6DPRMRD4mBKJ+edzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTf7pEDL; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTf7pEDL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770957142; x=1802493142;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tke4CASsiMozLiSK1lbWkvHVSiZNffG4/Q9C8wiPUYM=;
  b=NTf7pEDLrR36HY/1TTzKSBNKXDrnnYKpWpO9Tk+pDhp0PSR6BAOwCqd3
   E7opZbvTeaD083dbSBaFhlV0eYwYoVaQRVgAhDiJsLHLzubKJxlTYPFEA
   JiKQYUwPH65gPFU/Vs1Xo42c/e3vz8OQ5Be+ARinefiDqTHhANVeMfA4O
   U8UlePj443MSX1h8taJBwJ2HCSzY8kW+gxm3J53h08HIqIK8+5dMIPsyQ
   5sug++ok8K1lA4oEFaOUuJevxTmjf8O8FCb1zAatMQZd97dxwFAd3prKV
   rrqvwgonbgWPFnWyO/UapbS6haUa2J5TExGYhWAxCpWXJoBHxwdoNGW5+
   A==;
X-CSE-ConnectionGUID: kGa0ZIVxR1KoP1RCWb/fYA==
X-CSE-MsgGUID: zLmjLyMtRA+TqVEfY6cziQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72043665"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="72043665"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 20:32:22 -0800
X-CSE-ConnectionGUID: UcGoiEN6RcyTcXadrCPBkQ==
X-CSE-MsgGUID: IgvxrXT3T7aCOIZZ9a/zfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="217787375"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 20:32:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 20:32:21 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 20:32:21 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 20:32:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjdV2Mr/1kImza1oGEjaRmad2FI1DzyabjSwV33qJjHHcP6EfJIKiWBomBkWPOlKHO5CoGGuTOhsjnsHUVkvKADaBCCdhwry+s5d0SSOY/Zc1yJv7LicE7J6+fCsUxVJLGVkg+2LdcA7jTOe8to9ImVhdVbtI0OOjBODkFBOItH80sFXHktOrdQVO1NmOz2wMN3O/5tTUb3e18lsJb200X3ARw+pIe4SixbT6fMn4nHyIChn8HUQAhimrOPDYGGyk7K+ykN0HmX3kw1cC2Ew2vqrx4djiZedCO6enixugbzMupVySfSZ45gSB8qjO2+tjUXV1xupeTOE+HFA/lOvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIXrHIMhbvb/LXY7Z6UiVy2JLFUNB7UtADP9byck5A0=;
 b=vcwR2D0ERsdjuEJGePpLqkFcaRFwdkrjk2d47z3mklovtT9sYK5U8ZU8A/JMDOk09fnapn+Xip5pOXOArK10FaI6uVdms4Xo65j+qpUSekVgJPSqfz1xDk2NiaKFEBNCxJkyKGPLjnMXWX3dq1yEuByypddOjfW+fRUTH5dPInNWXi59OzW90V34NIhOqhyVclRNvTps24s9ljmIv338oCwKBS8CtWdwLsbUO7B5L3ZUEgCItIsZ1gBT9wO2nUE0pn/bKEqw7tsupuFTi5obf/O7L7ZE4edyngrPbMnIFsM6wlkDg9cIVfUFw9L6nT4xSR34h1M9IBf/APjA1ZEo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.13; Fri, 13 Feb 2026 04:32:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:32:18 +0000
Date: Thu, 12 Feb 2026 20:32:14 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH] cxl/hdm: Avoid DVSEC fallback after region teardown
Message-ID: <aY6pTk63ivjkanlR@aschofie-mobl2.lan>
References: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: SJ0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cae89d-cead-4def-e813-08de6ab8df38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BRh2TvQjtwStUfjpXab3s1glT1dxqwAIZ7JBChEcreohV0BEUB1Uj0F9eRaQ?=
 =?us-ascii?Q?EOzBlR1/NUwLRAge1YTatcwEaESk9xVp1vwTMyry4Mq1PugMilAub5x0MCm2?=
 =?us-ascii?Q?OL8lwdowhmaRRl8etyafnOddzmKMyVirnjiW5Tgv0TpLSWppImBjNV4AzDxZ?=
 =?us-ascii?Q?3RMn9GDBEdGYoZKYGbpiFbfXmIfRfKkyrTHtBgDbOvEiOHZNwKm0v9x0TCEt?=
 =?us-ascii?Q?wVVhdOUmhOaxKDNEsBG5ri+7lTdtBQ73v0e/BCDmQLWyn9XwxDrcg8rM6ief?=
 =?us-ascii?Q?DjrQZcV4QQxNlRJekYOswvOLiYoamE5GaHdX4cFbAPL5/ZSlIGySOhRjnyl1?=
 =?us-ascii?Q?SK/IDbxkjs7sdsAbV+dOeLcDnuui1Yz8IZf1YgTQl84GjpQ+u+GCDwFSfEa4?=
 =?us-ascii?Q?cb93fZo0gwV1CFD0+FGFPznb7rto6m3BqhYnc/uyYhCDNX631WrSHBS2lK7K?=
 =?us-ascii?Q?54UaQ2zW5WdaCqvEu1EXImFMJQLIP2M50Hd1FacYCKQn4ZobT1bQdHW5WZrs?=
 =?us-ascii?Q?8NWV+/lZcxXdGTjaablDK5dLU4ozCE4PCryxJYSEVIsqhwW54/rw/BNcV/8N?=
 =?us-ascii?Q?KB2Q3RgvmeLgwRwbqrEPFNK3SbH2AIrEdlgkU6fJ0tqbmTgD9aXL2vf/+Lix?=
 =?us-ascii?Q?xaiEwA6OsQ1IR6+6WY8XyBMYF6PNqpxyagdUMANSOcKmrPqBN4txUbNlucsL?=
 =?us-ascii?Q?I8jRm0B3KWWfm/kD3bwtsXC/EZd8mnznQ73rFADx2hf9kdheS2ME2BARZzt2?=
 =?us-ascii?Q?etosNWGlXOiVwXh9tEp/MkPaIGqNyPzEMcQoVOObMymn6HFhn9YVl/Zi4F1G?=
 =?us-ascii?Q?WmvDKgpoFHfr2ck8SPVAAEdKRZfRVoJiqzJxl/iVnmk59FFBSWreB5t0pW2j?=
 =?us-ascii?Q?DShSUwd/+MjmKj5TzmgYDm1tOpy49mg8pfWJfEEWVyE9R4/ifr0mGssMN4D+?=
 =?us-ascii?Q?FItiXRHhZJeYK0HGggbPACHQcXanuGmkjy1mtkTbarNFBv0Ippqz1k02dwfk?=
 =?us-ascii?Q?7ATFRauu7aMsYUoqatYVN/Axv/8E97MCJa/x4LkBc3nelgFpES03/tmO9p3G?=
 =?us-ascii?Q?fhLV4XeVQE4wgriTujT+sAgV8vUGEGjo90ODwSSiPnqURwKqHp7HUBVHw1OR?=
 =?us-ascii?Q?vRM+nhOxwtUH8e70JAm1AyrzKU2E6iJU4iQKUTv3T6+toqOC5Da4LF+KaAcc?=
 =?us-ascii?Q?CE9M6G4NzMx7cbDCeZFq//xnbjb6GBHtYsGqQFB8nuDyLRizt1eF1qx29htR?=
 =?us-ascii?Q?oULKsJ9g0DDM8sKPmksUB6GAemxx1l5vYt33TRYvlBG8hlOESeuoxUtXgLbf?=
 =?us-ascii?Q?yzNPpRrxNc5E9nOtdYOq0oJo/gmJawQ1mmiSuWPI9mBLTgG6r8BT/+4ifMIt?=
 =?us-ascii?Q?ivDaY9zNONXrX5p9aVZ4R09H9AjRZNKeAHdRmkqaXVmFKXl2syaa36dpXoWn?=
 =?us-ascii?Q?8k6ou21WgUqH84p3dRJyJBKmPArLJ7dTnxZwCphMvQ3xAeLcj+oYOGL7YCpB?=
 =?us-ascii?Q?Gki8aN3ZnEKwIOjHRS79l5DpaOX52a6EbDOuWQkKpssZEdvMvmteY1j3wFch?=
 =?us-ascii?Q?e4gmArQEaXsMnUFkJFI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKzzT5xmUAucaUSfdTpFEkbO0dE4E0jeTsYqXQ/uFGy6aH+fJnNFUMcG/lWw?=
 =?us-ascii?Q?FilVfvlV7e/dUZ7boRhMaRhwG+Ir8c8MPhWMhMxrIbkfhp0YGzLyy/UvCCMe?=
 =?us-ascii?Q?ypRkof+06qVMjDGOA+RU5QW1M7NlqKtQmc5ES+93DWwA/9Ru9lE0d+0+7G5q?=
 =?us-ascii?Q?7/keDGrwJpG25Kxo63GcgwizyGXji4CeG0CSJhWmI5Csiht+UFpYsQnl88Hq?=
 =?us-ascii?Q?GqoxXM9WyT4zgzKOolX6QeqKKDcd8fRx1IxKgL7+KuRaSpj2cbCJPnlVoW31?=
 =?us-ascii?Q?VV/CbCScCSoWnPtTfBbPfnVihMa/gWgBBkHuQv8e6w8tkwyFKoY6N4WfSapi?=
 =?us-ascii?Q?3kLXU3sT02mLVx7TP6ccX9ne/rs7xPBXU8Mp7Uvfr/5+ocGomYz00uZkcBgJ?=
 =?us-ascii?Q?fvqAKj7Ksx7BSV15kjCVeVvF2y/VMAdPlf4UF1nqRau/uR1Y6Z294KUxa2oR?=
 =?us-ascii?Q?NM6zhChJv8ARc+CIuHCUKMO9xLjLZA4spw+hV/2uzM4XeKKe/Nlozav2VsEC?=
 =?us-ascii?Q?al044VFISsLvzPiJcTH8KQG/6K7MMP97Svto/Aa9NFxoGZ+mva6X2j1CXUJw?=
 =?us-ascii?Q?ow8urF4PorsV0XwdpLxYXVPpTTZGhYzYC87vp6yPmcbp1dqha8kDCuBmJBNw?=
 =?us-ascii?Q?Ztyj9wQJNZmdWY4Hy333JRXlUSP2B5o4fQfzSP6RtgzhptoREtpGqd5WB9JN?=
 =?us-ascii?Q?k/k4CcqJvRQznUcDc7mVFTkGdX2l0+y40cqiNwve315smMSiM9FoiwLzpz9F?=
 =?us-ascii?Q?dNLrOWtf6xrBie/abIEhUAIT9mhzt0U7Zv7Qf835XGGHRTDOFrCeKCPD2gf+?=
 =?us-ascii?Q?HY7kY97WHBU2KN21kjNBNWKsCX9YGZ4OxUwr279fMq9hEHaYl/wRwJ5/he3q?=
 =?us-ascii?Q?91Q8w0BpJR7RZHTvEUT6zo/cuUjN3JSU1ZjuQNp2w02K/U3KnrXLzaLoY5N9?=
 =?us-ascii?Q?cpaQBMCQduGc06SHiRTp8iZL1yVl/t/+vy63OSukzpfOAdxOcK5eQ185A7KM?=
 =?us-ascii?Q?hun6xzrccXONqcvKw4iiJm8VqSEfNIRFlm8YGNBVFd76KtGZtPYKu8wV3w8v?=
 =?us-ascii?Q?t2RaFh1xbO0hzHmItkx18en4iGLYxkq/+fr1fJXkpLcjKaKH/Sf5OVXnBTpf?=
 =?us-ascii?Q?htDq3QCXM5ycx96gj/nMTb55zqdGSu9fE9Oc6IjI5Zo61DMuxzZ96Je1v3cv?=
 =?us-ascii?Q?loAwQn7YrcbFTuuSf3c2NC6N6GJlOWJ6Pj88x8eR7oXgRdhJ3kDMHMDwgCez?=
 =?us-ascii?Q?zI8aq79sQENN/Rytg/gg8vYwaE5/eWC0umnTVwBfk2y45XCqGScENBK2OwXm?=
 =?us-ascii?Q?4Ej0++MxBkiyHzprRGM3qjeXn57eoGtfEbu43V32lZq/dEtgAlDTqLNb4I5q?=
 =?us-ascii?Q?VaxxoVOy3HfXxabCD9xSvZtt0XP+TeuOQoldNMyGdO1lIgvpbZ6X5+4yV3+a?=
 =?us-ascii?Q?StJKzPFcm/WU+h/pkqS16XixZvgpR6kYeAfHmRZUQEBOSRW7LuPQ+87OPLWr?=
 =?us-ascii?Q?g//swzNQDf3xdmiJW4u+LcA8rVUur4N0RkKaLvZhp6V/NN4biyfjDju7FWgq?=
 =?us-ascii?Q?JgzLV/6tszKn5yTwuhs365NbZxGyU0gnvqY5D4lo/hnm6ZNJRhRXs7HB6idh?=
 =?us-ascii?Q?Fd02wbMJe002TtLBrmRe0yUHcabwPUlaRpIV/AIY4U0CVzPpmwEiw0qo7WAZ?=
 =?us-ascii?Q?PL+riWAgFP3KKCNcSOpI6Ks0S0bLRweDxFIHQmbc5zPyzKaecjXpheT+83Xf?=
 =?us-ascii?Q?6b+tRB/hYU/dlvcccU/o+mVRJVMmIWc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cae89d-cead-4def-e813-08de6ab8df38
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:32:18.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgzcYMOTwKEVBbKBZuDHm7fOEiMQoKdmBiD5wG573JmPeCVSFr1i7PLXDFrYjgtUQsgz4Q7/xL5a22fJkioJcQh3LsPk/i39gGVilpqAOPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-OriginatorOrg: intel.com

On Thu, Feb 12, 2026 at 10:38:00PM +0000, Smita Koralahalli wrote:
> After destroy-region, cxl_region_decode_reset() clears the HDM decoder
> registers (base/size/commit). If the memdev is subsequently bounced
> (disable/enable), port probe re-evaluates decoder capability via
> should_emulate_decoders().
> 
> The existing logic checks each decoder's COMMITTED bit. Since those bits
> are cleared by region teardown, should_emulate_decoders() incorrectly
> falls back to DVSEC range emulation, even though HDM capability is still
> present.
> 
> DVSEC fallback marks the endpoint decoder as AUTO, which triggers
> cxl_add_to_region() -> construct_region(). That path copies the default
> interleave_granularity (4096) into the region parameters. The resulting
> spurious autodiscovered region consumes the CFMWS HPA space and causes a
> subsequent create-region to fail in hpa_alloc().
> 
> Use the global CXL_HDM_DECODER_ENABLE bit instead of per-decoder COMMITTED
> bits to detect HDM capability. If the HDM decoder block is enabled, zeroed
> registers indicate teardown, not absence of HDM support. This prevents the
> unintended DVSEC fallback and subsequent region creation failure.

Nice find Smita!

I tried this out following your recipe w an auto region:
disable/destroy the region then disable/enable one memdev.

There was a problem before the patch that went away after the patch,
but the signature was different. In my case, the endpoint tried and
failed to begin construction on a new auto region yet still blocked
recreation of the original region because it consumed an endpoint
decoder, not the HPA space.

Memdev enable led to this:
[] cxl_pci 0000:da:00.0: mem3:decoder12.0 no CXL window for range 0x0:0x1fffffffff
which comes from cxl_add_to_region()->get_cxl_root_decoder()

And then the original region fails to recreate with:
cxl region: cxl_memdev_find_decoder: could not get a free decoder for mem3

Did you see any of that or totally different messaging?

It would be nice to confirm any varietals here and add useful signatures
to the commit log to help with searches.

-- Alison

> 
> Based on cxl/fixes.
> base-commit: 8441c7d3bd6c5a52ab2ecf77e43a5bf262004f5c
> 
> Fixes: 52cc48ad2a76 ("cxl/hdm: Limit emulation to the number of range registers")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index eb5a3a7640c6..a0718cbcc355 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -94,7 +94,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  	struct cxl_hdm *cxlhdm;
>  	void __iomem *hdm;
>  	u32 ctrl;
> -	int i;
>  
>  	if (!info)
>  		return false;
> @@ -113,22 +112,16 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  		return false;
>  
>  	/*
> -	 * If any decoders are committed already, there should not be any
> -	 * emulated DVSEC decoders.
> +	 * If HDM decoders are globally enabled, do not fall back to DVSEC
> +	 * range emulation. Zeroed decoder registers after region teardown
> +	 * do not imply absence of HDM capability.
> +	 *
> +	 * Falling back to DVSEC here would treat the decoder as AUTO and
> +	 * may incorrectly latch default interleave settings.
>  	 */
> -	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> -		dev_dbg(&info->port->dev,
> -			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
> -			info->port->id, i,
> -			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
> -			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
> -			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
> -			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
> -			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> -			return false;
> -	}
> +	ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	if (ctrl & CXL_HDM_DECODER_ENABLE)
> +		return false;
>  
>  	return true;
>  }
> -- 
> 2.17.1
> 
