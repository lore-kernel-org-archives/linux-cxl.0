Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA52139D1B;
	Fri,  9 May 2025 05:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746767128; cv=fail; b=AoBSAV42Z7FSHutZuRmF6mQFGybljua1BVGSEoijuMwoRHM6AKwgafw/YfZ9Lw42lw/mPy0Kt2KMBGZURC5f/FBMzFrRiqdCcfBnX0frk8N8tlXTnPY4sba4dpMqdWGeSRleDWOmRGkK6cmrZW9MOUdjGMWUpPLwysOEt4HV1/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746767128; c=relaxed/simple;
	bh=yZEr8m93XrE5Lm9j0rprCSiRM8xb26udWCC/1eVQPkQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SqhkbSJW6PyCvGWe30PFtqDvEM9QFWr2MC6iqRPAfgyuDFCfITKUky0YhIuD8SpO2qeqyuGh2BEXxJWDJhDWRXvJzKjViwzPayYP9tWhTLO6cM/EwZWDv/rOUXiXn9mJD7XpmF2uAIAPWTaWLjM7DiFR73ihvJWFYRM94dXYoG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOh3mTXU; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOh3mTXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746767127; x=1778303127;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yZEr8m93XrE5Lm9j0rprCSiRM8xb26udWCC/1eVQPkQ=;
  b=iOh3mTXUtfsblL8WZWfpL4fu5HuGukYppZsPDTLnTHydzbZHWAy5VMwc
   H/InoVaxWtu6CXO410te1yj+G5z4fVwfo1WKyKk69jl+nHB3YpO8tGe5j
   0ZftCyzXqzTqJAa10o85ANFoKaImciN83hiAWvBhjJoqjY2Kb/JubOLYT
   2/PXHuNhoM3Dhqz9VYOv6ypO7sH99OzyZ6l90ySPjbI45kCKIJcwMHIWG
   E32qDlzDdFpJczXGxH92XDwCm2ajsRVMzmBALAtFuWLdLFVYKNzoBtA3X
   zfw9d2Jw7WwNgtOL3/YzdY49jcyKJZ3bnNNrme0tdbfaicFjH5MVSGp+/
   g==;
X-CSE-ConnectionGUID: 7hLe5fuaSc28f9mF5A6uIQ==
X-CSE-MsgGUID: xwY8LIz1QaaPrxpYPhz+Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48730874"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="48730874"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 22:05:26 -0700
X-CSE-ConnectionGUID: sdP8AAGMRzGquWtyd8qZ/A==
X-CSE-MsgGUID: c8at6UDoSReWq4NB/1RIjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136899003"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 22:05:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 22:05:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 22:05:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 22:05:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMrriYSKp+eRzJTATIozFYf1m2B9VkAyZI4svQtG28jkotDIGNzPlC77lX7Dn6MfO0DVhpaZsgo8Wwiluh6fmrXzmojViDUqVGZByYsmLXbfz74dl+5wMbRXC+fpn4NUryd2JiYAaFY0frigeIeWFkyV7AdMFtdeI/R0ncilMyduDmiZQ5/XbDP+1NHqzvNyJAidYbT1xAA/lt+ei8igtTjFMJXAjAkssDIraKxbWe7XcAR5WA+8qfUuzw4b32vSDy/rZhKRSC1nyBcPisMVQl97WRIUSmK//BNUDum7FaN+2T4WrAmWWn0DUVmzlA5Zwf4peKcteYYdDz+v2GXCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pUCmw0duIp4NmBJR0Yo7YPPalMTzeWgUs/Ye6Fp66k=;
 b=vaBoPvr1muPIRa1lSPyuVQNfor7vv64/PC8ZeCYt1f662SPCL7I2UKLSHCATCpHgxcVK5e56j6mO3xezkLDfP4HvcWEVX2GkPIBdGK7RMM6uQfPKq0sZ0O+VdrKUjfjF5soXVEPmOfL0Y97H+9xMRQaRAJSUxrqCXi+uqDjci2I8dHzSOdLyBv5z1TcMeUynHqM2fuY6gir0ldXWSEzC9onNel8jvWy8jGUKFo2WH5AdRgsZTpKjEXFk+qKpbcfJubuM1Xb0xtFNcWowMk6MPol4IwwdZvHLOHGZ9wqXuwLhhPSLo3NpmhWv5cCZV8ohLaaqanPKxeukL5bLcaJRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5205.namprd11.prod.outlook.com (2603:10b6:510:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 05:04:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 05:04:36 +0000
Date: Thu, 8 May 2025 22:04:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	"Ingo Molnar" <mingo@kernel.org>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for
 conditional locking
Message-ID: <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com>
 <20250507093224.GD4439@noisy.programming.kicks-ass.net>
 <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250508110043.GG4439@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MW3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:303:2b::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: c12a8647-ac35-44c3-7193-08dd8eb6fe7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9tFKTws9Uqjq/tKSen1/kloc7bftUlZNkTe5gQ0urIxEoutAlegWX62FTDMK?=
 =?us-ascii?Q?TOFSfRO3fG1Bc7CXvLHHzSFPcwf7WQpHeyQ4ovbqxin53C8qkucGHISM4Mvp?=
 =?us-ascii?Q?YsOXoeBqd5h/IPoqLghLzutZLcEd6EzfX6vYnmvtYj+B5bbLcl74IUbvTFzz?=
 =?us-ascii?Q?30TcWdGA28HciT8AJ0JiKz8gWWOsRhjokK0NULroAYMK3+6kkpsT45QLeNLS?=
 =?us-ascii?Q?Wh6AOxFOCYaAVXRLasHa/uaCRfPZKDMyx1oXlG79VSce4IQCNcPcHBK8AKls?=
 =?us-ascii?Q?CbsC9ssbuQW/r1z73a4eDiO9rv0SXcClS+HUcFmF3bioTIns8WRqUT6l9kJQ?=
 =?us-ascii?Q?Hs3e5D1nyJQ1chbStiDOZtXYTrGusJrapmPaMrBDX/ZsjZCZkjLgN/vWNvbl?=
 =?us-ascii?Q?GrJKGZ/+7kP82763GWoH8kWuC1GONcCWpnEBznRQ0jSQA4pPVdadxWKUDa62?=
 =?us-ascii?Q?y1heu4rPUPbmzrfu+YbqP0bBBzflFGWZdmvzx9jBpiJtvT2qrwf7SX46Zqmk?=
 =?us-ascii?Q?RZ6MAQNWaLhOiwnBqQQ/7mE2EW7thAiKD7lF8xAnQE39u1uyKAG3VkEcDNOs?=
 =?us-ascii?Q?KGE+tAJeW4pY6tS97LmtR635EPAbw4oqc/fR/EVlmKiD7XFSIrgLYyMLvRIn?=
 =?us-ascii?Q?mJ9UyjzzY6AD5nCiDECbENn4mJDJMJJ7Mgb2wYCoyStdc2cTnDAQzywP4Hdn?=
 =?us-ascii?Q?R/Y6QpJedXDdQveES1G06067bhqs+qxE7BA/ykx+/1Q5/exXbymF7ZAuOoEa?=
 =?us-ascii?Q?ZJk6GE4+dVETzNircpRyxn+bdTnk3OzP6jOyhZJ/OIlI4j/lqZtXtqDYs+YK?=
 =?us-ascii?Q?i6jr+WNbNYbs81B5+Z9cArq/iSqPQkFGkZU5P5MLOQPseTsPqVUt7ock2fFi?=
 =?us-ascii?Q?vpGmZwLhjeA6k6WrBXJtVVXSfgWZZX86V46EkJr7rUA6Vl/YZBRzfGuWOFEo?=
 =?us-ascii?Q?FgTrNEUWWYz1LCxhjdRhKWof8qgN7taUngMr78WTAj//pZLXQyCbBDZJwz5h?=
 =?us-ascii?Q?au99hraQFv7of7YXLU1+WvjhbSm+dd4hMWI0PjEsqt6ngcTCKmkBazcEncVN?=
 =?us-ascii?Q?pQpPpT+WECxG5MNtLbUs76jJoTR20Tr8RbnYspoC7txvecIXaHP1PNs3VGiz?=
 =?us-ascii?Q?hcNEIVbEYF/9jaBe5gH36KN7o8sPsCmIwP6Cfa2e0Gdne2wCgrXe9YZSr+qK?=
 =?us-ascii?Q?SjbjajKgf6zOZKJJVx/wWrmUQI1N6eVgSUGveMf5haKmMD797IqKuxeXENft?=
 =?us-ascii?Q?SSeNvngcGC6jyRoNcZI3DUvCjUf6ia2vyVXNTro3I4YpRi6AI0atD9adqzTV?=
 =?us-ascii?Q?wr7bLdLmhcw4/IxHY7TOuygVC7DPRZK2bbVKhyJfHz86DIfwgHOgXoAPSePw?=
 =?us-ascii?Q?cg+DN19haEdyX9WXTVAIq1+h0kloOn6w+PqA7UmXWd1l8tQ4HF19l4BH8ZC/?=
 =?us-ascii?Q?HSBNZlmJRNI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JDTK8+By84lnjLS/De1Bx+tgi7UmCWZmMMQe77SqjT4aLzJHrcI8buClrRCK?=
 =?us-ascii?Q?EhEUbk7ruDPN0zGV5OXleRfYLVhkie9s51VIh8qnTlcSOSM2jD3FFL5aaaYm?=
 =?us-ascii?Q?b8sxNE+zXGe52b55TFRgTp1eYWn7jfT2iPIMnv4duRsEmdsN/V717iiIWP+x?=
 =?us-ascii?Q?F8qaaikQp25M3kCRVEtiSZUOeWd6OmmOUUTNonAFD6WSlyryOZ719dL7hea1?=
 =?us-ascii?Q?h43LZI0NpMMGAo+QNTlUeYY9Z++ijGNjVEJQVGab1hc5PqUT7BroTTcRCQ0K?=
 =?us-ascii?Q?VaDcuEMkDOStGmYNpfr+vpidY4/hO5wrhreyTmx2cpWAYnZrSiodfDi9Sq/B?=
 =?us-ascii?Q?L5tbVawtD7r/hqUiHytmN5yiK/eOa1IWapFVdAWK/UOS8P4m1QsWquqnFTOa?=
 =?us-ascii?Q?ak4kYBTTOUlmrts8w5aNK/P28aSdpDp2ByacjCrn9Lgl/3tYsJDl2OYZVx45?=
 =?us-ascii?Q?zsTgxJkmJatpb8lfMrsSDY77TyFxj6GVVqhLMj7zDaemBAM9t540IHuneLLq?=
 =?us-ascii?Q?SPJQz7FIlwnF73pdgeFxD/jrPbO2DoqAbgonOLFu7yffXuIq1y5SWaO60sZO?=
 =?us-ascii?Q?uC7uM6NdS+JQ3v+d6Q8+RMUjZ6GmdoVrmszIaGA1WgwZE3gBPlkX9IUjKEu+?=
 =?us-ascii?Q?UlZMbpfc1yzHH65Wr1lY/AU5nl+4FK7NyIRkJFjsZj3Y90kqohD4aM70oXEG?=
 =?us-ascii?Q?MC3E2Wj0sMGb51FTB61r97AhoA1qy4sLx+Umx5vu1rmhFJRfUNlVB122SM0l?=
 =?us-ascii?Q?h+xXN2Mld0TqWPjFBF9dWIApSTIOqYUBEq8MME63SckKdfgbohu+YeZ0uSvC?=
 =?us-ascii?Q?j8N1HZFoM3G+SqiOltmESvVJxn3ns/bkPC2aah2aIBFjaQ90fjsyt1IFaHM5?=
 =?us-ascii?Q?Rut8lp6ypJvg+03jtDtiCLkMRPPQdQdviVeilhnUi6L+soDYHqUGsar/QN3e?=
 =?us-ascii?Q?P3ujBdlrG8sOHjonBRQBU4rB9r4tSs/4v1EgZhEQyoZwZ9vCrrgN6v/zAiLJ?=
 =?us-ascii?Q?d2nN+pqV9PYE9WN8w/3IRhB9oyTl22aeBzW1OVdwK2CVfqtS3Z2HaugqQg3V?=
 =?us-ascii?Q?gh/XVxp4P2rYnNH7k+BB8R1tZmtaz/onu1wgYC0ns0gtlyAvlw+YY1dRRrDt?=
 =?us-ascii?Q?zUckhLEWPMAMbWcgJiBvqDGMPg+0p2MmxvgNlSTi94vKgJPXAyouVWMXllwE?=
 =?us-ascii?Q?8X9boyn0OCAmGBorXH+LsvCCSBQey1HI41EpljrkC2NvFbTTWGSDSxN4ctga?=
 =?us-ascii?Q?2ZsndfagK649hG8Cv99Ioc24kSLj4RDm87z6WFOHSOiHxTRaBwgzdaO9NHnw?=
 =?us-ascii?Q?vTvWPpklawv/ceQ8HziZt6SPJg7TCtU7ZE/V++yEFV8ChnDTWRaXNzDlL1q6?=
 =?us-ascii?Q?sVMCqC1DmCs6ISzuXNNqnMZJ/pk2p3uO2f3ih6jtT7UjpVO61RomE4KASLXW?=
 =?us-ascii?Q?axYK/UXOQq4VfqMp2TB2teUkApMuMfh+SQ9BKAAfk+UZqNx0VTeKVssTCQYB?=
 =?us-ascii?Q?/V3fFodQvgEV9lQuHmDPhDZoAasCReAYfNfeldXyhkbcYyROuUWIgjAIZH0D?=
 =?us-ascii?Q?psFcelJKzpRHY4J8RnWCJ9XlpCzrNB2YDZ2IxCKBYyfGwG4O6/knNp0NdKHB?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c12a8647-ac35-44c3-7193-08dd8eb6fe7c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 05:04:36.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OAU4RuGPxvhMXO0ze6/wfcfI9gZ2djJW4ygn9IdhPxe6LP98dx6zd1Nh6QvuF23oSiiiI4otxcH7p7zpRd5OshGsqxXVUfcCM06y3SSBxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5205
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
[..]
> > So the proposal is, if you know what you are doing, or have a need to
> > switch back and forth between scope-based and explicit unlock for a give
> > lock, use the base primitives. If instead you want to fully convert to
> > scope-based lock management (excise all explicit unlock() calls) *and*
> > you want the compiler to validate the conversion, switch to the _acquire
> > parallel universe.
> 
> As with all refactoring ever, the rename trick always works. But I don't
> think that warrants building a parallel infrastructure just for that.
> 
> Specifically, it very much does not disallow calling mutex_unlock() on
> your new member. So all you get is some compiler help during refactor,
> and again, just rename the lock member already.
> 
> Also, if we ever actually get LLVM's Thread Safety Analysis working,
> that will help us with all these problems:
> 
>   https://lore.kernel.org/all/20250304092417.2873893-1-elver@google.com/

That looks lovely.

> But the compiler needs a little more work go grok C :-)

Ok, here is a last shot that incorporates all the feedback:

1/ Conceptually no need for a new CLASS() save for the fact that
   __guard_ptr() returns NULL on failure, not an ERR_PTR().

2/ The rename trick is not true type safety, especially if it leads to
   parallel universe of primitives, but it is a useful trick.

3/ "IS_ERR(__guard_ptr(mutex_intr)(lock))" is a mouthful, would be nice
   to have something more succint while maintaining some safety.

That leads me to a scheme like the following:

    DEFINE_GUARD_ERR(mutex, _intr, mutex_lock_interruptible(_T))
    ...
    ACQUIRE(mutex_intr, lock)(&obj->lock);
    if (IS_ERR(lock))
       return PTR_ERR(lock);

Where that guard class differs from mutex_intr in that it returns an
ERR_PTR(). Some type-safety is provided by ACQUIRE() which looks for the
"mutex_intr_err" class not "mutex_intr".

The rename trick can be opt-in for helping to validate refactoring, but
the expectation is that something like Thread Safety Analysis should
make that rename track moot. In the meantime code stays with all the
same named primitives, only ever one primitive universe to handle.

I am open to making the rule be that "#define MUTEX_ACQUIRE" never ships
upstream, it's only a local hack during code refactoring to check
assumptions.

-- 8< --
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d72764056ce6..b767d3e8f9c7 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#define MUTEX_ACQUIRE
+#include <linux/mutex.h>
 #include <linux/security.h>
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
-#include <linux/mutex.h>
 #include <linux/unaligned.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
@@ -1394,9 +1395,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
-	rc = mutex_lock_interruptible(&mds->poison.lock);
-	if (rc)
-		return rc;
+	ACQUIRE(mutex_intr, lock)(&mds->poison.lock);
+	if (IS_ERR(lock))
+		return PTR_ERR(lock);
 
 	po = mds->poison.list_out;
 	pi.offset = cpu_to_le64(offset);
@@ -1430,7 +1431,6 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		}
 	} while (po->flags & CXL_POISON_FLAG_MORE);
 
-	mutex_unlock(&mds->poison.lock);
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, "CXL");
@@ -1466,7 +1466,7 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
 		return rc;
 	}
 
-	mutex_init(&mds->poison.lock);
+	mutex_init(&mds->poison.lock.mutex);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, "CXL");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ec6b906371b..9b4ab5d1a7c4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -257,7 +257,7 @@ struct cxl_poison_state {
 	u32 max_errors;
 	DECLARE_BITMAP(enabled_cmds, CXL_POISON_ENABLED_MAX);
 	struct cxl_mbox_poison_out *list_out;
-	struct mutex lock;  /* Protect reads of poison list */
+	struct mutex_acquire lock;  /* Protect reads of poison list */
 };
 
 /*
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7e57047e1564..403947d2537e 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -291,16 +291,21 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
+#define __DEFINE_CLASS_IS_ERR_PTR(_name, _is_err)	\
+static __maybe_unused const bool class_##_name##_is_err_ptr = _is_err
+
 #define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{ return (void *)(__force unsigned long)*(_exp); }
 
-#define DEFINE_CLASS_IS_GUARD(_name) \
+#define DEFINE_CLASS_IS_GUARD(_name)                 \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
+	__DEFINE_CLASS_IS_ERR_PTR(_name, false);     \
 	__DEFINE_GUARD_LOCK_PTR(_name, _T)
 
-#define DEFINE_CLASS_IS_COND_GUARD(_name) \
+#define DEFINE_CLASS_IS_COND_GUARD(_name)           \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, true); \
+	__DEFINE_CLASS_IS_ERR_PTR(_name, false);    \
 	__DEFINE_GUARD_LOCK_PTR(_name, _T)
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
@@ -309,6 +314,7 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
+	__DEFINE_CLASS_IS_ERR_PTR(_name##_ext, false); \
 	EXTEND_CLASS(_name, _ext, \
 		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
 		     class_##_name##_t _T) \
@@ -320,6 +326,7 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 #define __is_cond_ptr(_name) class_##_name##_is_conditional
+#define __is_guard_err_ptr(_name) class_##_name##_is_err_ptr
 
 /*
  * Helper macro for scoped_guard().
@@ -346,6 +353,7 @@ _label:									\
 	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
 		if (!__guard_ptr(_name)(&scope)) {			\
 			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
+			BUILD_BUG_ON(__is_guard_err_ptr(_name));	\
 			_fail;						\
 _label:									\
 			break;						\
@@ -424,5 +432,43 @@ __DEFINE_LOCK_GUARD_0(_name, _lock)
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
 	{ return class_##_name##_lock_ptr(_T); }
 
+#define EXTEND_CLASS_ERR(_name, ext, _init, _init_args...)                    \
+	typedef class_##_name##_t class_##_name##ext##_err_t;                 \
+	static inline void class_##_name##ext##_err_destructor(               \
+		class_##_name##_t *p)                                         \
+	{                                                                     \
+		/* base destructors do not expect ERR_PTR */                  \
+		if (IS_ERR(p))                                                \
+			p = NULL;                                             \
+		class_##_name##_destructor(p);                                \
+	}                                                                     \
+	static inline class_##_name##_t class_##_name##ext##_err_constructor( \
+		_init_args)                                                   \
+	{                                                                     \
+		class_##_name##_t t = _init;                                  \
+		return t;                                                     \
+	}
+
+#define DEFINE_GUARD_ERR(_name, _ext, _condlock)                \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext##_err, true); \
+	__DEFINE_CLASS_IS_ERR_PTR(_name##_ext##_err, true);     \
+	EXTEND_CLASS_ERR(_name, _ext, ({                        \
+				 void *_t = _T;                 \
+				 int err = _condlock;           \
+                                                                \
+				 if (err)                       \
+					 _t = ERR_PTR(err);     \
+				 _t;                            \
+			 }),                                    \
+			 class_##_name##_t _T)                  \
+	static inline void *class_##_name##_ext##_err_lock_ptr( \
+		class_##_name##_t *_T)                          \
+	{                                                       \
+		return class_##_name##_lock_ptr(_T);            \
+	}
+
+#define ACQUIRE(_name, var)                                                   \
+	class_##_name##_err_t var __cleanup(class_##_name##_err_destructor) = \
+		class_##_name##_err_constructor
 
 #endif /* _LINUX_CLEANUP_H */
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2143d05116be..bd4b449ea6bd 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -198,9 +198,37 @@ extern void mutex_unlock(struct mutex *lock);
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
+/*
+ * For subsystems that want to use a "rename trick" to use type-safety
+ * to validate debug scope-based unlock, define MUTEX_ACQUIRE before
+ * including mutex.h.
+ */
+struct mutex_acquire {
+	/* private: */
+	struct mutex mutex;
+};
+
+static inline int mutex_try_or_busy(struct mutex *lock)
+{
+	int ret[] = { -EBUSY, 0 };
+
+	return ret[mutex_trylock(lock)];
+}
+
+#ifndef MUTEX_ACQUIRE
 DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
 DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
 DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
+DEFINE_GUARD_ERR(mutex, _intr, mutex_lock_interruptible(_T))
+DEFINE_GUARD_ERR(mutex, _try, mutex_try_or_busy(_T))
+#else
+DEFINE_GUARD(mutex, struct mutex_acquire *, mutex_lock(&_T->mutex),
+	     mutex_unlock(&_T->mutex))
+DEFINE_GUARD_COND(mutex, _try, mutex_trylock(&_T->mutex))
+DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(&_T->mutex) == 0)
+DEFINE_GUARD_ERR(mutex, _intr, mutex_lock_interruptible(&_T->mutex))
+DEFINE_GUARD_ERR(mutex, _try, mutex_try_or_busy(&_T->mutex))
+#endif
 
 extern unsigned long mutex_get_owner(struct mutex *lock);
 
