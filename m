Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219C28A737
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734107; cv=fail; b=bBIgrb/hDFll/yr+6wEotDEsiSG0rMPftaih/lCmEXD5DJD83xOUwbYrYQLKwJCRvoEnS18w7qSdOx6Cm1dFcTW4FIPoYbBr/BNKb3Pag57gNaTmbHNfCTvL8XcysYzTnBa5/+/CaLt2W2CFo55HntdmOGcqT+Qzw6QhBOn3/ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734107; c=relaxed/simple;
	bh=K2pMsF647mb9DOFFG68+bPx+fi0luUn/DGJwdyK1YyQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uv339pF0UbxRNDqSzp64v/C7pVzot5nWmMsWJTFbqMpQdkL8Q2eVjkhQxC0Xo2gpne6hoA58EqtrGDWmGKK9741/i0ObugtxqeyB8RF+/UxtJlBNBzOfLi/JOYL5iEPFrXHvs8FbV+v0H14c4GZBil2SlCWIOb13pzyOM4NudU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcjBaVgr; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcjBaVgr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746734105; x=1778270105;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K2pMsF647mb9DOFFG68+bPx+fi0luUn/DGJwdyK1YyQ=;
  b=JcjBaVgrb2hPDTIUrR+gmvJk+E0NKNctcSt6lMbZqemGR6Zs2nYeDFy9
   6427ALM73v6KVQCkdIXmqJpxE6h7KTkqPOWVz52MoPS2q7NZfw0+MCYGQ
   6JKs22Mi1XqQRqfJGwyLvI3aYvP0VBIguZLrqGSty24QQh/yrd1TlnZK3
   HCSIzm2RZhOTTsImo6Nm1axVuPM/Ewe9DqDQ93rSu9NtLiL6W5CGNvq6W
   2EV2MKS4LzYKeZ+flYPnNb2gcWca27LWeFSLx6oWjiouQwxTT/nyFYYHk
   dqEK1XCESg41r3+ozRDG0Wib8jgfpidQCcCuHNKqiVw/AunSQ1hhZ5t7x
   A==;
X-CSE-ConnectionGUID: CXrwJ/+NS6O/n2L93xB+rw==
X-CSE-MsgGUID: A7ehIUzFRJ2UpecdCMzy3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48249267"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="48249267"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:55:03 -0700
X-CSE-ConnectionGUID: lPUlFR6RTrGUcVSWYMWkCw==
X-CSE-MsgGUID: CFE+eRfWTqiaOYWVqgaS5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="173579282"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:55:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 12:55:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 12:55:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 12:55:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/dBFVD0XAjetSCW32YkEG9NgWAuij2gUUdaQD/MhdccZX5bR7li9UOdPYh3nXZDntZi/Q6uF8wy7dTnR+shw/iyWaey70nFOfaljrmEZ6YUZCOsf+EIdg/loYWHd5WFBW2NPOtZ+id7cllB3e2/yphyuQ/L1dWswzWPzHdvnOWIvDJhZjcuj25GeZjG09exB0jijatDC/0C0Wc2mx1416zeQgemrq26LGWu2s64Yx07RcuboT0JIRPYDeuOi2NhlVfemu9gYHQ/XlRTYlvBB0vKBmGiGwbn6CBZvOZLSf3YxGhPV3x/9QJ3CCg7jI+KSU/wkxqpRH6OmF9FyKPwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXkLNWy/YUFXtZ3R660F0WQYxgHVMnKvoJE5a4xBA58=;
 b=dmGXVIDqt1+ZDDO3pEue4/FHZYTYXf7kasrO373WD3W3anssxL6G0lrqAjarJNlsu3V/oHNI6LT8k5IRMxt9X5tH+ljlAbveHaR8Ly7snAZWf6go38R+zCPVqYCYT3Uts38q0VuvLHo3C07QhIJSFlHtqF/YEyeWzOMMZsxUcgMfONMwsKMuZo1Yh1uCpuCiXQWNcvv56e8ezsBxFtmDaNipflbOVG1YBSt2fD8axf6RuuJ7CjPZLxituVMuV7dsyjAb8wzlb3IicmBzxOiDfl3yypNBKlBN4HZtTiikR1MUd/rcUYwwf6y3jVUyVFALA1kO/tgLjQMqgMJYK9Hrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 19:54:13 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 19:54:13 +0000
Date: Thu, 8 May 2025 12:54:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 01/10] cxl/region: Add decoder check to
 check_commit_order()
Message-ID: <aB0L4lAlb4MdHwll@aschofie-mobl2.lan>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250507004310.3536991-2-dave.jiang@intel.com>
X-ClientProxiedBy: MW3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:303:2b::33) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SA1PR11MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bda6b56-19c7-4d28-aee2-08dd8e6a1b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P7C3wVS5Qy+GbjvNFvBhOZKGC6E+IEdoAqgm+9hnm1nHHAqnCD+b8CpEHzc+?=
 =?us-ascii?Q?aZ788tvTjzN0MGGb9xxKfaSJDjDkAJEzntP+J2Cb3vqkmKoOhCuGiC72duul?=
 =?us-ascii?Q?teWoEaopEOTxlVTQbnENJDdl99wu/JDCrZXb9mfTyZ1BQE+aeWEVSr9nHZJL?=
 =?us-ascii?Q?2dnrdwjBNyywO3pitcKcz8ceQbGeLPqERfjepuRmG10IAk6L3GJvJHbIYrEm?=
 =?us-ascii?Q?eHWruMEp9tZ+gP4mAfeSNLrDRMDQ/kqgHLDHNTj1nL+tDTU7Wj8LQShGbkk6?=
 =?us-ascii?Q?EGePP61/FdsowEyv6Z1ZYU+QfHYBi83V++Kmlylq+Egfj7BT5gbYmzTmF3Xu?=
 =?us-ascii?Q?QzpLhspRSokxL+wriTGMUhV5dX+YrLjm/7xCb5tAxX1AyySkw1Rx9nm0POku?=
 =?us-ascii?Q?kDiD2PCtJKvEoPl6rn9ZQxevi1gExrHnecCm6799sAz14zVP9YJbkxeqSai6?=
 =?us-ascii?Q?wAMoq0jaYYTuHKMhaR5TFKJ4tQ9ADB91kfFHChdjxBkRNve0LlPI90jS2Orc?=
 =?us-ascii?Q?7JAQKPmanuk5jcODzF+Gk+lMW9N7Nksy4562RvC+Fb6URgafMKq1FTWowPvu?=
 =?us-ascii?Q?ESQ/E7lQYdN8wwGPxeceDnyjuBTyEpF/J2ByoLUzwZmkCdXZ1uR58gJJN/bd?=
 =?us-ascii?Q?M8/zro9Cg6Yl1hg06jV5RBfChhWiJjL+TZb9HPQEhrI8frBpTTPWWiwt3Q7B?=
 =?us-ascii?Q?qE975yuKTQUg4JYPxsnLaim3NajbvmDgs/iACen/tbQrHtmxFYSX5gS7Ju/n?=
 =?us-ascii?Q?dNunZHvo+ox22kkSIypC1oOmbvMUMCqB0USsmpVIsY3ItYwOvZ4kZzph5LrG?=
 =?us-ascii?Q?pOegUC3Kd7w7YswRL/04A2hPJkRNwxR9KPbI2Br1kIjMaBh1niztf/l9gDnb?=
 =?us-ascii?Q?zMpaP4Z+uOLG+bPd3z+mTCX49tumIEdDG8aOFIFjvG4u8ls7/IzXd5KBrsMH?=
 =?us-ascii?Q?x/Wy3pOo2kLBQkqktyYWUOQ4/eXkBq+j6nZXd/jNH2AfZUCkN+4A3m6nWl7s?=
 =?us-ascii?Q?tFuzCPhzkNU1NOOepTF1nJz/XuilSzZyY7wsHUtJyHUzjMCxR3I/yZHuk4ya?=
 =?us-ascii?Q?GAjcsljyVoPszQdAZCWim2R//2P0reWn17vzwlRDeeZmUzZXbgWE877W6JR7?=
 =?us-ascii?Q?MgEfrasDCgFTIUTxr8TYB7t0PsJu7qmcW5b0yY+yfZMuMecYY69/JsLaOl8L?=
 =?us-ascii?Q?pDq4l0TcyDgZBVYXj4sJfW8vJw7p5nlp0SG1z6WZoRePM6a5ZtC5b/iBNrTE?=
 =?us-ascii?Q?VyWSRj64/w8pxrC8auyPdbuQcnsWSY9rhL4Y6JLjTkBKeUOmKcLty7luYDPd?=
 =?us-ascii?Q?9IFeKGh/sGc8lJ3Xg0eqzR4eMph8Ye23neX+0Qf2hCZ2Qpm/iAK/T7cEfhqj?=
 =?us-ascii?Q?W6THsU0Ilq8/ty/1fL12IVx77chjMFARsWy2QfmmYAmT+L9w/afMv/eMXiM1?=
 =?us-ascii?Q?yn/9bzWidEw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SStxrdsvXK3Mp5xxQfetdymQ3JxXSVp0zNxSHyDTwkHXgTbVxzzOW62txvQP?=
 =?us-ascii?Q?I5Ttzg3Bes5GKqpYqxWzIR9AGynPtNQsq+Kf1WUpHh3zJAt74BNJS+Do8Y4i?=
 =?us-ascii?Q?4zYTleAwz3MlNg+e7p4T+h6P1fMd/0iqe9meOEC+KWvVBhhi6qw5jf1lByyG?=
 =?us-ascii?Q?VPo8aB3cPqehUx1cXL/kZZf2xXXP39jevydTISc6jVIJ/ybhRyxt4GISEb8e?=
 =?us-ascii?Q?3qCn8IsdbqyTyFl9b6s08dhbJbfI5eP5Vvhl3Rp70fa1rQP68DRAl+jadG+i?=
 =?us-ascii?Q?Y8ntkRJLeCzbey738xwzKhj9B5NP1Z3aLxLvUHj2iywn4/aM4azIcQC2sJvz?=
 =?us-ascii?Q?M4vs05dl82W0yFvkOz8V5P6/rljSrIbU7WJEwlMjq+CgBt4km63JYKdnCNKk?=
 =?us-ascii?Q?oJl2vDPuTLXjqhs0nH0EFJNbvLH6tJV4wv3JrvzW/LQbX/5i8mCxT6yRSJRO?=
 =?us-ascii?Q?SyDQyZ+ru7cX6sYTsJZfi7c3qWAx+UqqLYmbEaKFaauv0bgjVMjQo0Gh5klE?=
 =?us-ascii?Q?zm00wKBMd0m8B8lQa1P7/Z7uuV8R3RDTTloV7twsinTBO5LLrpmapDRlNuzM?=
 =?us-ascii?Q?7wwdxv8zUEyiwyHVK1FYPbyr45Y1gjzcH2bp9vLSUtKUaJ5296VHHQ2bGDLF?=
 =?us-ascii?Q?E/Fs3vDMKsFWlSWpMWOyL6OW4IuTJdaPbg8kE8yArspoAOf1L0onHesNl0DM?=
 =?us-ascii?Q?YUHyFGaI/B7uoqfSOFW8I3WNNgeTL6SeYyO4xRofxnJ9Iee049wEurKsTsv9?=
 =?us-ascii?Q?o0kKzgsPaiPQGNi6EyHfVkmxRIbPa5RTH37cR97uUvOH5c2Nrcl3ta/m4j1x?=
 =?us-ascii?Q?ioIHWjWh/2EBzF8qXTk55ZgZlGdhc7sTfBxXzM9C8wP0XETNmPi9riGWtcVH?=
 =?us-ascii?Q?oMGaMLL3cIcOQg4iCglrfR+R2IX6dFJ9EFQvaWUlYVQ3CEwxwqFa5WfwdGjy?=
 =?us-ascii?Q?WCwZab7rBYRksZAKoVy+Edcb5YjSFXfLd7sVbifWSV4t9resmUOkgea2ngEX?=
 =?us-ascii?Q?ckeZVXZ0qU8GhLck6LzjjrZ7CMKC46BaWloOQFTqItEaXBhuyVv0C3GMW6Eq?=
 =?us-ascii?Q?+LQd6B2WwRxm0OMMycvX+HBI4dYrakAwpLkmqtb91ihYHSijSANSzkop2PWw?=
 =?us-ascii?Q?X8dQRz1h0yVGqpMSj3TZL9klEVWvdwGRd61kwy+FRj3/xJeqy1WWAvr/iLHR?=
 =?us-ascii?Q?t7VfLGwz1Z0RD5IC6EhhA67e/K/CMYMdgo0uAyGJduiYSiQuTyLc5YrSypCd?=
 =?us-ascii?Q?P15Uc9WYzWbxFckTjlAx9ecIQEaAo3IyWN4WHzvYnig5EARFeeA8IR/L0Nuy?=
 =?us-ascii?Q?BxO2RSpPuPTOR6vN6019WlVw/rJwZNrLzbcoKT6OG5HqpM+PTyDOcXsNcnQ3?=
 =?us-ascii?Q?7V6VEpzY47o8vnF/69OprF/rT1p9FU6ZurYOiEnesi4V5oGUEkJoiKMutQ5J?=
 =?us-ascii?Q?ryG2G7bku868Ax+BhJSw5SdOznQ+aJ6KXXAFVTOpnO8gplgjE7EnjdpZy5sv?=
 =?us-ascii?Q?Q9oHpfH2QzPKM9jdVUbox8SuvEqoUKQdqTQxrjb68YmouL1HCXY0eZwDJFH1?=
 =?us-ascii?Q?PKG3xrzm0q/ZAaLlD4o/VRd0ERW6UgY160+VRY3WJ48ozZz/VNLSoHhlWpT0?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bda6b56-19c7-4d28-aee2-08dd8e6a1b72
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 19:54:13.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yPyHrH7vAiYxOtUkGhnOfUlIXoTR8BkWkD8G5R6n7eqXgihbn/KRTKSbZ5TFfc43bralWGIRKst+uCkgEIvFfpvAOvyTG7Wdnqe8ilimnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
X-OriginatorOrg: intel.com

On Tue, May 06, 2025 at 05:43:01PM -0700, Dave Jiang wrote:
> check_commit_order() attempts to convert a device to a decoder without
> making sure the device is a decoder. So far this has been working due
> to pure luck. Issue discovered while doing deferred dport probing when
> child ports are now in the midst of decoders due to ordering change
> of child port additions. Add a check before attempting to do decoder
> conversion.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
