Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1421422B;
	Fri, 10 Jan 2025 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531018; cv=fail; b=JCBl9XrLcHro/UN4AMa3TYu2zuvCf+FUu9eKiDqQErO5HhqgOV76ZbvVIPzihRBlPBFptd8ewGpVN/WV0MkHgV0TtZG0pPxyPaCpIII8iZHKa5oVUafpBUcUahghfiFabQnYMj1zlNwmjgrNjgVAUAEawa7BoHhA7TDFiggZU6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531018; c=relaxed/simple;
	bh=HHYcRybi+1fAO6Z7vfukn+3pnQCrKZwNxEbtAYI9CIc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kHVz1v4HMMtp8u4sj0cyU6VWzihm7Y6BG4/SF5o6YTSkVzJHqf3O0by3XI1cszlY+eSFBCFlmSr4R690fWzhiUniwSY/5DLbzIq2ou+mLOgsnQFlO5ucI60p82/dguDSCWUH2OgwjAZeAJB0ITOSZi/TWn/VAsNN6kMX1v1oESo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfgYgkUN; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfgYgkUN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736531017; x=1768067017;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HHYcRybi+1fAO6Z7vfukn+3pnQCrKZwNxEbtAYI9CIc=;
  b=DfgYgkUNDfZUrq3G1+bYjdvYuohtGh3YChh6GQy2XqWW+iuKq5BszpyF
   2IZrluCE8dgHd/LF8kJ5ifh3nl0GkZiD47hzo+uYupZCRH21Jw6FgzJiC
   iSlPgCMv8g2GEf2GpI+Vwk4FxQjWcL5HRUmbbRLtiFes1lagU4LNNXRA9
   TfwQsK0QaC42ZOZCZQMHrS1gJRweztM8qvIDKQDZYHJ/kAztNRHBGYJeQ
   2VwJOoK7r1wF55lWffRvdKvdMYxobyweYbiY6LcHvXL1Fn4bxd88309sT
   NY2DbGrrlSzvWlyqW0MDbarEANfqRLqjcgVMJbWsX19z3CAoaU5qAhfWW
   A==;
X-CSE-ConnectionGUID: hMDXgpFUTqipenY7UtQ3kg==
X-CSE-MsgGUID: ts5/98K3QG2gEWSFSrVLgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="47824540"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="47824540"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:43:36 -0800
X-CSE-ConnectionGUID: LE7UKFbLSTizXFt4LIDBVA==
X-CSE-MsgGUID: JLpGBi/RQiWWet8USFz1/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="108703595"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 09:43:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 09:43:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 09:43:32 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 09:43:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/eC0ouduVuEwthWu37WCgHhgmm/8rqzD6fYhvbbtZb70GpqpKA+IWDvJoVryN5+zYS5t8Qqmc9r7RUVrjoX5weUKUJd53I8nKMWW79OYpBg/E8OhuBLInCL90sBFdXzMqC2gDF/FdBPNKpgOxSv6kUuHNSsuiTrZpmePJKrArqshFeoY7h/tr8CWefj43fxGt1NdW2mDXZnei2C8v5WvnvRXZnMLOFTA3iF+i465Hg8GgyemVMjEd5Pm8swSCa5EYw+dzoUWdoxEs2j6s7/73nMSJuS1voF4bfRav8fCmQIgez0VxQ3JZ7BoQUKwsowqj6FanPN2NhQdZCTewhc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg0DWZRXKqibCOLEIhRfgwzTnbPVjUD/OEI3zghtz18=;
 b=czsieUsN/a8tVGOOBTag9PVeCkLLGjDFd7n6GJY+2CVmWbg4RGnMEzWpnpcjK2TRqixcBtOTQesMOA+7cPtwgeG8CZOsWIvys5vsChHfyQ3tj9+eOE3agaHUouYig9FLEMC/5syqETjyDvhzotUwvFccA8YM/73SwYApcI1Eb5jgD6vhEQ7O2NFwvI+rbr/PdCF/3wTLFECSFjCS1Sozie2kW3xlTcZs6Z79MZY4KZc7CmytCQLiCvOQO1DycAKCdo95cbGu+j0c7TDMmNAVoYdgaEmhm3FShrLZr9Fptltta4k9Grz3MTpztipe/rt/vCfs1c/DRSQQQme7aM5YLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 17:43:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 17:43:29 +0000
Date: Fri, 10 Jan 2025 11:43:24 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <shiju.jose@huawei.com>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v5 2/6] cxl/events: Add Component Identifier formatting
 for CXL spec rev 3.1
Message-ID: <67815c3cc28a2_17789429457@iweiny-mobl.notmuch>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
 <20250110115556.1654-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110115556.1654-3-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: b27c59b9-9ae3-46bc-1e60-08dd319e4b2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Iqxnx6BgoQFeVwl1FZu7izdrX+kCjz33Enhqo2yjqhujGbK7pAJ3teEP12f?=
 =?us-ascii?Q?0cxFAil8B+QogX/xt1u2sttMUGwwfVTAwQ/TfqOub3nlncjpi5mc6vtRVyki?=
 =?us-ascii?Q?1REcZQOMLz7E4ixxUgkDfFCv3i0CVdydBPAluPH1qBOkQX11R6H6Vtu46Ydn?=
 =?us-ascii?Q?dXzvpjrFZyTen0XlXYh4OJQshXux3kFxPrIRixOd/GwlecdC8AVRDDo+hh4v?=
 =?us-ascii?Q?TGX/0Ia1zORr77RN9UyI4boOpzqWFgUQJu6glimQeAVRF/rGEzsD6I6UXsk7?=
 =?us-ascii?Q?qio92DJmAe4051XRJG98Q8Mkvr17IT7Mi8VBQsm824ve9P+GWmz0TUR56Fhe?=
 =?us-ascii?Q?E+hFqm3SVpRk1fl2+c7HVN+OeaYPdCh3Z1/0IGY8gzeO7DDSSbDSgrl4T4Lz?=
 =?us-ascii?Q?XZ+UfHWL5yyH4ZbN9qm/HRmc4W7LTHKU/f7BdLvIvke84/AhOD80c+eEtYIC?=
 =?us-ascii?Q?/A3awZnizYUCFVQ7WNMW2W9tkXy1Hj/z+gE8RuT3N2F5XrXDhUWsBz6H1aTi?=
 =?us-ascii?Q?8rUJ8n8OCeZrCPIo/Kpx0WjI/v60YWuuGZ5JdfjIP/CEo6E0B2HmvkmTza8H?=
 =?us-ascii?Q?z2zn5Pis3a/qiQbMkhYsiXSn1OK/YueBMje9jbNPsdltoTNjUVqAmt/k4i31?=
 =?us-ascii?Q?GPKJWvSKgxf0V2J0tCuHE+K2Ono8/mocP42sBrKRL/RTetvA0y3+ncihTBe2?=
 =?us-ascii?Q?seyvopDFWwD9HKRIn47ADJEtN1sy/37+jLFYQW3W5PVHSieIke75VOkdXQTZ?=
 =?us-ascii?Q?THUp3IalT7JkEZK4/Fx+8fETZtIPKpScx7RCmycswCqwbq+vWyneTUbP2ZQC?=
 =?us-ascii?Q?XiXgYhUZI2RAS09qA3CFhCTEerjGYKMTHbI0f1x1rhjrRfcQnpnK7SEukqSC?=
 =?us-ascii?Q?+yLdXAp2tXE9G5PQ+6PhFa/AMVMpfd36BSf5nPu7sQU1EdE4/cFesKccDy6n?=
 =?us-ascii?Q?S8XW4AZ8fis6OppxxbU4kSh4b5zIIvH9aXZiPLqBkM5Mm0LyRl6RrliSHgjX?=
 =?us-ascii?Q?dvUgCcn1nBhqUFTYWiftjasbAyNA1BPp7BYg8PO+ItvmDelmF+nqtE2hsv45?=
 =?us-ascii?Q?qsfS0BwEXuVPofGyePsigg/Spe7PkjorezmTq84bup6XrH+IXaabZCnscfP9?=
 =?us-ascii?Q?NE7JhpWpHqw1H+GffkYCSk4vuWNK8V54xrFYOldl09deBHIbNn68hyUxxuAU?=
 =?us-ascii?Q?wnbh81AgcQUpck0hxV+o8ezp+MZRZo9pmTrJS5R55jvRJJ5xhV8nQLsMht6m?=
 =?us-ascii?Q?keMPXmgWWIIDN+vFgZ9EvT5bqRgR1ovaBLwgsjlvsTrMq9tq/MDayVYTaWDU?=
 =?us-ascii?Q?tfQjUb5AEpEUzot1lu0C6hJRqmQhZIz2NSt/k/3EgLx4J12uQNgDUycS7nMP?=
 =?us-ascii?Q?SaTiPC5QY85RI0eVsoVZBDBWkJLuaJdnoIojiPQSeKwmDNRVH7DT3izZf0Jd?=
 =?us-ascii?Q?4KaT028udEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p/4qRmS5gNe+oK2tl+kc3Bl+V1vxQJCVx6eU6F8vR8j42XXJta00f4Ha4uRA?=
 =?us-ascii?Q?qJ2L3tIEupzYWuuCcc4chhV7fr1AzcbeBr+gntaqKaEfxtSAYLB3Eg/gwyM6?=
 =?us-ascii?Q?ZLV1ltmrOCYhefNyJExiAPWb+J2avha6uYJv589KWeZr3WlDD95OTDW4Fjxz?=
 =?us-ascii?Q?xa0bHFTI8plu99n4tsEuvABO5pa4pulGLTFvGuZ6J6tkIl8j2g+3rUaygh5K?=
 =?us-ascii?Q?miH+OwWSEGjSexVif85VBNR5OU6n4ElFIDRwduSMJobHK0f3BS3CLv245mt0?=
 =?us-ascii?Q?ZmF297ZU4lZ9a21VDPiOIOmdtv9oCvUF81atGt4hyDUXl7r3ws5RP7E3m/dT?=
 =?us-ascii?Q?YqosWHV42Q7YutL1w0IbudiQOMeG8nS8sCcV1D7AP6JTT/nEizq4Hzzfg/oL?=
 =?us-ascii?Q?qiP2YUx6tJ2LKoTNHZ0Pc5gkkT4Z3qiFQdWgJsZ5Ey+tpelXnvmMx1IvGEl9?=
 =?us-ascii?Q?F/J/id1NzRAnQntR3bH/3BhN51W+Q1DQ7ch8E4N4eTcU8juF2eiDpSgjX6lr?=
 =?us-ascii?Q?2sgmBukR+r11BHiB35xOHej2gnd85ZghaGv57sjaW3/K1qwt6P6isY6DLcc+?=
 =?us-ascii?Q?yfvZCsFvGQWkgJ7KVFEtSbTUXr0lNbWbrxUquNpKL1+l77iA8vk9mGhOalNV?=
 =?us-ascii?Q?IeZ5ScgZNEYpo1Tv3Vi7GoxWOBuFMOZFiio5E/uC0UF2hq/I5ziwSD4qgwtZ?=
 =?us-ascii?Q?Uk5hHCEmP2dwVOm1f4mA3O5ZiFLzZN1jr1P8fKF6C51qqhEZ2z8p8WQmacvX?=
 =?us-ascii?Q?J5AUL0ofQTq1IU3w7wCXVNQg+SRinxsAPqeEAsjyIx+p8HpAwjWQONSb5Mi+?=
 =?us-ascii?Q?z9DpK/U0cDftr+XYlZsIXY1dcEiXPUDBNVfCBcS8Km0hO1MkhTRwdaOiY0YS?=
 =?us-ascii?Q?6+K08LkZqqGmM1Wk6xDt/YkpEn2N0RX/ZqqUGqPMo+SUbz0KBBZYHwFCHBDO?=
 =?us-ascii?Q?XPYB7Cvfyyu2uWk9d3qTgo5tLE2a0e7N4wkj1Wd7AEq4G8kiHiMeFhkFju/G?=
 =?us-ascii?Q?SFRl6aj//Vr2X2hwBEan7aouR76KOdWia1zr7Q0RGKGKPRQUZsMAtgmd3hBU?=
 =?us-ascii?Q?9Zf2XUeeB9vRcWx420Tg6zm1TJzNiajK1yl/hFUmBcdSplN2cdIsAXI4byEW?=
 =?us-ascii?Q?1KXVFa3gfbwUF14McfLxodL/kBlw96FVwIFb0pdQM+iGZcRKKyhictpjFzl7?=
 =?us-ascii?Q?ObLXZryik9pdwxUrIBwyvVJ1GCSRXNlr6OUlmQjAQGeOYRAKkH0RY/dnJICF?=
 =?us-ascii?Q?M2PCRVy1IfTtZZdC6Vj9T24ZaHRBtf1FnmscHOlM74I8H0oVq3qY0/6fJZ0J?=
 =?us-ascii?Q?oJvbsBi++4w1jiG0Jw6LvAQbBBAL5AlH8+aLw/TlpmbzJYixoD6HGlP5PG9S?=
 =?us-ascii?Q?oi0v1f5ey9nWnPbBQMTSpas3nPVkzftaJcIN1Y+A+vhqn5Fg9uLPsyTpBnv1?=
 =?us-ascii?Q?8l6M0/hSgzdgqzx/nGB3bA46Oq2A/CH+rc+BLg6eHjx7wg/3hv02uLDnKfKi?=
 =?us-ascii?Q?rCkPHTTHRxXLGbQXQP30aVSmwoQYGZ4adzVDQuDFq3l3PKyDASEuI4jixUb4?=
 =?us-ascii?Q?hCR4fHUjbs6Wq3runvmzH4M3nb5bGASG4SWynVIZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b27c59b9-9ae3-46bc-1e60-08dd319e4b2c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:43:29.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr6mawOmFp8DWglJ+xzgmtWTVTvVSh9UVffmZKackZ4vIqTiLWTO9hhMauslE0Si+u51t/2VkFDD/+SUJXC8tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add Component Identifier formatting for CXL spec rev 3.1, Section
> 8.2.9.2.1, Table 8-44.
> 
> Examples for Component Identifier format in trace log,
> 
> validity_flags='CHANNEL|RANK|DEVICE|COMPONENT|COMPONENT PLDM FORMAT' \
> comp_id=03 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
> comp_id_pldm_valid_flags='PLDM Entity ID | Resource ID' \
> pldm_entity_id=74 c5 08 9a 1a 0b pldm_resource_id=fc d2 7e 2f \
> 
> validity_flags='COMPONENT|COMPONENT PLDM FORMAT' \
> comp_id=02 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
> comp_id_pldm_valid_flags='Resource ID' \
> pldm_entity_id=0x00 pldm_resource_id=fc d2 7e 2f
> 
> If the validity flags for component ID/component ID format or PLDM ID or
> resource ID are not set, then pldm_entity_id=0x00 or pldm_resource_id=0x00
> would be printed.

NIT: I would have mentioned that these are used in subsequent patches...
But...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
