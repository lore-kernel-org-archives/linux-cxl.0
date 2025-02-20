Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1D206F0C
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068002; cv=fail; b=mWBaBty5AM1Ui7pOuhlLUj1u51vCDGH5j80v4jNte9easBTh3A59GOVgE9GPfDcSEPSRqZIlNRq4U8wmlJiBnM9WP6MLoOCFFvpru3yCHyUA23hBjcNWhiDHzPLj2/fJwI3HABKvlJmiZs89DN3yS4J2l3WUu2kPtj3n2/g447s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068002; c=relaxed/simple;
	bh=WQir2gLGStDhbDFWBao3AQAyeL5MGFrUOefgsAEYbkU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l/4wOk+pk27Im4xcMLyK4GFD7Run4xj/aVy3HnXSKuAJqZDnF6cEWpwn2Vpam/8cSD9ugug8cVX5tD2eQokd2HvVfo8FCQBghr5ZaSDKL+agGkQ91SjzVItgRy8sViVCkYhm4n52ndH4Nld++T0S7guAYj801E1lHqm4K9iClnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCGeqR24; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCGeqR24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740068000; x=1771604000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WQir2gLGStDhbDFWBao3AQAyeL5MGFrUOefgsAEYbkU=;
  b=FCGeqR24QSTsYH3WWscWyyzUG+nC0pytAGTrq++Yy1wZeFPkoDsXKOQo
   qMwy1rc3xwL5VGFcFQdZ9wrb/amLrQpvNjBklISHsM5pW8vm9AycFns9D
   PLZ9jEZ0r5PrkvItu2jRs1Va38QC6Zw3IWsYuGKMq/XXs5EiTb3o5Rx+N
   G2H6oKS/SJt58GrmiKHs2rToJDPJYl+2wnHvEnao2tHXFCY3SPQiEEnji
   0eEpW3uz8yVhg//eliAA+SxX/YvgSFJzZxXevKeiiz9t++lV/izGPriCn
   9EVNL3yGicu2Jkd/xEuhFzXjQciIpSPIwy8WL62C29I4RaeWAaWg7utcd
   Q==;
X-CSE-ConnectionGUID: jKzWViK6SxKpiI7V6708aw==
X-CSE-MsgGUID: YTADJx1pSt2cPmk6HPuviA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="28453314"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="28453314"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:13:19 -0800
X-CSE-ConnectionGUID: 1TYsodwXQA6UGchc7IfunA==
X-CSE-MsgGUID: E8rzmiIwRZCAHlCsWMm93Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115981192"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:13:18 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 20 Feb 2025 08:13:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Feb 2025 08:13:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 08:13:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxM0foYI+GjhNw1iLp3BPIFpxaiT2TWMaFJK5tCIC8TQyCyPNadDe+4KCHFgQ6SfOSVHuSjlcmYrWrdby5i1JP7ffA3/FACN5UlQCZZVZPv9/Rb0a1dsR2CQN4pHRGnRfEHb5sogUOy4lvjySH4RhNqMPqeHrJF/cS7FMxBZMlG1WI5ktFyTh/HvPNrcf0B545u9FhGtUR6m1XMkM4yFWdXCHzUk4NhNg3RKswyb0Q5W5XSXJlXwobMsLMCtbmfgQaKhLW+TD+4lYruCexLYvYnEGTCyYXA3cqJne8y7d7XHtHeJu/ZzqKR44d4rC0FFNnGj9Kfv5lOZldEoD03pFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXkBWhMKHCOKNQc5YWAXCh3n/ejdztzyb5gyf2/BP0k=;
 b=J4id142XFOcYZIyCuFNDWE/vOqP/fH+W+i7yT4YDSe+KSd6klRqbIpThOZ8+slY0DIYHEFxubLCjZYVsoCl5kBfP8dByNS1iBVuFgG03HT3OkpJWamrOeYoGecuDSFm2DpjxJKyvBqyc13ni4yyKl1RymNnxA29GjSJTpUDajBG0cgq3oujcS8T2Ai56OQqx1L5mBlsDUwskgpNlRW/NqorknV28qtavkC01eieSk4bt1555hXIde3Uh3UQcBhx6chRhuk2G0NmZ+VpsC1vaDizqfr5hwkzVR9d+jrVZwM4EQ4N8OiSg3S8NsPyzgltvr5Ih76JqyyoU+9e4RuNmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA3PR11MB7534.namprd11.prod.outlook.com (2603:10b6:806:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 16:13:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 16:13:13 +0000
Date: Thu, 20 Feb 2025 10:13:10 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>,
	<ming.li@zohomail.com>, <a.manzanares@samsung.com>, <fan.ni@samsung.com>,
	<anisa.su@samsung.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/4] tools/testing/cxl: Set Shutdown State support
Message-ID: <67b754965e5d7_2e08a129469@iweiny-mobl.notmuch>
References: <20250220013604.263489-1-dave@stgolabs.net>
 <20250220013604.263489-5-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220013604.263489-5-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR04CA0132.namprd04.prod.outlook.com
 (2603:10b6:303:84::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA3PR11MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e2f780-e0ed-4bed-0380-08dd51c979ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ldxBQ40zWeTw/E8lQLOCIr7v9U7I4eCD8JiqFNor/BmoTGQuZu2F5ZFoSOhf?=
 =?us-ascii?Q?PTq7f8JN7Drekhz3qVjB/iZYikaS0I7tQn+akcMxsLTcPuXVydbuVmcvbqaY?=
 =?us-ascii?Q?S4e+2xDLw31b/5UzXQ/iRk6Iyu4PefkmIEXyGVA6UOEehWoUBp6pt0jy4Q44?=
 =?us-ascii?Q?r6761TDvz4BYfyaZGMBxZ9YK09OxDg68AYcAGX44XRjzuRwqOWUzDdfEBhyv?=
 =?us-ascii?Q?338KLa5bmu4fYEJPT2FhNdfu9z9JgRDnVoLWly4zuV4F0xJvpxiG6dxUBs1f?=
 =?us-ascii?Q?iZol92q+pZih19NrcOqzj/SvXkrdvEtzWMXKY7eB08Z0EvzmwzWSnhJLaEGp?=
 =?us-ascii?Q?NY1wgw3zQseW3s7uyoMjyd/SVpgGheNsJDFN48EKwY0HicBfSl/+Rz9t7cVA?=
 =?us-ascii?Q?IknMbwy+RPVoDuhnQwir8C883Hhec6MuK7yY+DvaGzyUBVlVbkG66YHMpx1n?=
 =?us-ascii?Q?UD3qqKdeUOVhwCcz7Ih1kepVF5giy3/JdjOHqdk4Ji57zyJ+qCg5VoIu6Z6r?=
 =?us-ascii?Q?gwNGYHkf4SSFsET66xFMUGxiHyXE8U7tKURWcRBKFk2r3QFydmTt47Rcfw7W?=
 =?us-ascii?Q?xMvEZCULjFZceV2m+Yjp+AyMdeyM/h7HBMF3/u1DMv6xluFEqdq94ajAw2Ur?=
 =?us-ascii?Q?uf8pyXfUCON0uMWS0TAfFkO4K/vHMweiEeby93XA2cveiqMiZpgLtn8QHutM?=
 =?us-ascii?Q?4yzJq7ey52YKZHbbIxvqKmkiJxamyTAx3yqGmEsM7T1K+fKbdcUnZydq3FgU?=
 =?us-ascii?Q?EdeF99l/wV3HHH41P9ZgkmmM8br/Li+HPuCUlwfeu1W+SuH5QyACXoPLD0sB?=
 =?us-ascii?Q?782xT69LQnVm0PAyEiuK9pivyohm8lN8NdMT4+xb0YdXvL6n+y3QtH2F5Uur?=
 =?us-ascii?Q?kcXkaJqpMAiVrd04F6MGblB4cGMN0BA8be00yb4kEm3qUqlJI4mxuqh2FfSC?=
 =?us-ascii?Q?zMmOlB/mklVgX/jSJZOX6LgHC3pqgIwuwvVBHQ3TMYQ3OUYaOwCphDUJUUZ5?=
 =?us-ascii?Q?NfcE5OpAHW4DJxLOj/J7oFdTePLXSLob1OBNLPxnj12vnGnZRKTh1IjpgoME?=
 =?us-ascii?Q?NPDJpKmCHahIRZLyyaMWlEova3n6PH6mpbus3ashA6nWV8HbUoXPJ+DoXZzX?=
 =?us-ascii?Q?h0snTzKvpgYsxVTHk85OmayY/oMGkNtvkFeoHwDldxxR78KYbqIcCw+SC7IZ?=
 =?us-ascii?Q?7acesHNbT4fhG0AkxmJZjDJpd4FQinQMC53+0Xu761Dn4bcuCKj+mF3ooL6G?=
 =?us-ascii?Q?M/k6SWYIoQBFfZoN/b5jbanEy231cywYH49NZhywHpClgJtgAY+BNr+5O/mp?=
 =?us-ascii?Q?IU2WbutYexy+y7SDtv8U5g+35qXlIlD3xbui8ufeWIkgS4DTL9fE1tYR7J5c?=
 =?us-ascii?Q?CJZEDjyLOw+YVvQapYqP/Z0+cCRP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8CwptOYSlklfyPE/wznOgKezqnfiHyeFQeBTSyG7bjQBbrG+a0uqqR4pR9vq?=
 =?us-ascii?Q?mq06zcXwgbqpsBkbwTL1c7ivUSS9LQDpmT4hTYkNyXo/FPlJ/zHqieOyq3gJ?=
 =?us-ascii?Q?GLxAaFGPbS/HCASyvoWAeLWZAG76a9A0ML/URTGDmezU1CyKiYC40dNYNWsc?=
 =?us-ascii?Q?fPqTT7k1/Zd7nwiwiypEqNrvg2tttmSGjjYzZqh0eLkBrWUXJwVd3CnaJOCF?=
 =?us-ascii?Q?DAA0jJgKjLeUgw5LJL1S+HL1iTaoiC0M02O/BfBeSfjFxhf6L84wHOyk5Fqu?=
 =?us-ascii?Q?k6ID03dNNGXfXhBXKNuYRAoULKSf12fO6ov/9vvtqDwiijwePfn1So9U6spD?=
 =?us-ascii?Q?CD+a8vN2GYruT6C+HdxT+Tbtbz2rey5N9kHGWxBLbNUdBuTXW0kALjkD3mAU?=
 =?us-ascii?Q?kBiCKvbLbruA8rNowH4BaTuF6gbTh3IiJx2zViBLGtisUP3LFtlzJ79ssCro?=
 =?us-ascii?Q?YCWIx0jHzhOLfg49SZHgOf84ebbBLjPhkwvPZa7fzVK6v0geJxoj1C9aZTqF?=
 =?us-ascii?Q?T+AHlKDWj0lSAteokEUfF1P0CJOqdIEdWDcEemv9a+Hp6ZgKjPxanAfZTr3/?=
 =?us-ascii?Q?i7Ol61zHn90fpCwCIpc4SLxAljRdbYRcl+5B+8EyZS+iUjVfoQwAVHgr4W5j?=
 =?us-ascii?Q?GmnjaXYcxlqyVZNs0Hv0oTQt1Q9qn75iUTw/a7RCBpnsBk5WvE44Dv0staZz?=
 =?us-ascii?Q?+j4EyfWksS0cRR+tRCsipZ6/ZF6hrw1FMfpig7TAtl/mJYY+3/+bRDWvFkTI?=
 =?us-ascii?Q?uUsBVCkZGVv7kTCN8OxtGn6z8K3KmAyGv6WxlQIjlh62zIoUychk2oR5Odmr?=
 =?us-ascii?Q?2uz731A/AklL6muerk1HVg3LSJWTFOSncRfhku/taXdHItrBhEtYwIVFjCTx?=
 =?us-ascii?Q?7+E6wSBtpgoom1Nx9lX3+XkaM8m7E7wcjfDohPo6211ZkTyMJrPrp7UrwKR/?=
 =?us-ascii?Q?9l8YTuRdjB5sJbfBsDnAlfgopvUKyk3OAGEyUu7YJGOHlZnDFmk7FZ37AExu?=
 =?us-ascii?Q?cjenqWwpxrAdEG7wTomqmmXFYtaKMx/zx3y1GhwCDJErvVD304Qj6VVbXyyU?=
 =?us-ascii?Q?vaUfGexorw0Sn4fqDXixtEBbuE91vEMTuydFxP7Sx3VVMu0k+xkyKA0mpVbD?=
 =?us-ascii?Q?vPKo3V/EHafpWF06/rcK1L/gRwLmfTb00z9YrZKw44uyH1A8Dm0YSF1CiY6Y?=
 =?us-ascii?Q?XDZDbHQbvbOlbVOrAhynRr9d7fEes34UWbtG460JstUi2hgtWKmml/e0ICk5?=
 =?us-ascii?Q?esUzBWUuGsjs4yOe/K12fkNwXvBOPexg803PO3YOY2f279AW2XfqZicdVe6C?=
 =?us-ascii?Q?l8R9prSC5Peh637VboYXgdbOdWim/MpmdMCMnfg/c7cVBYl7U6oamCiRXkEW?=
 =?us-ascii?Q?TYI7jmh7tK2DZPib75ItuvVEgyTJoGAjGdPOLhOpJP/QzsMkQXresAMMa4Xe?=
 =?us-ascii?Q?MryRIlIM1zBr7uUmmjgfQ0LpqMFBvzNdLmx5YXUBM00LJLk87w55s7w5Kajq?=
 =?us-ascii?Q?wdbuYxibHV7TVRx8k8WENfKOX3NVdtmgBDzTunXQB68dBcADTkGQAJurFkHE?=
 =?us-ascii?Q?eofET/f005YgNWMNjimtcFkpKxFble7A5XVK2BwwwYj99ae+owJi5TbcoLLr?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e2f780-e0ed-4bed-0380-08dd51c979ed
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:13:13.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojFGg2FbhJ/5vzQEXwj5wK5GbmjhJmYcdj/L22XLLZ45mkdJKAeR75ii3CiEYZ07o/LymyjSm3X+8x2K+gjraw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7534
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> Add support to emulate the CXL Set Shutdown State operation.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

[snip]
