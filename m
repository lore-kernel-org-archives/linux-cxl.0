Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B3E1B87EF
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000134; cv=fail; b=hpx7r8F3bIvLfFkvrR1QmPjID0YP0oqCBC1Vvzb68cbuFgQkP9D0AEmq5A4tsVBPLvkne1dDWGNrNmnDBNDXtZvQS8b2MDHFk8o4tGlPoJZ5dE4GlwLtVixfyWi+tXcOeDluzVypaHkgHnLI4hLPCNwobQjfmx3wyqsda7LZvZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000134; c=relaxed/simple;
	bh=LgW+Na1R1vDkthxnSJvAbts/lJCkjC8O86YILakv4qs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q8ceNGio7McaMIwtKO7vmZNQIoxPuBYWgmb2b8N7llDvzAA6bUofSsvFNElsFREyXm4QhxDfUSW+8PrWqTqXAdsfYh37btplO1HDyAgnEFbvPPwoEKl8cqeGlNU3L5QlapnviOXL4vTcG315maUPsKFOXNAjM8cf5OChioFqBlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PD5/xyEZ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PD5/xyEZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740000131; x=1771536131;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LgW+Na1R1vDkthxnSJvAbts/lJCkjC8O86YILakv4qs=;
  b=PD5/xyEZF8UidZi9LzbX2+ZD/NrdKDxbQs68EuCSnnTekcviA3Jzd/VN
   8GoztVs7e2dTO0QkJsdg3GmGKmARUfzSuQAgbhS1Bqz/ERU5JiXy4CR3P
   OKmcH7npiJacihjHp49TeHduy+s0LAynP/AL3ZlWRPR4LZo16S1U8x/Fz
   csI+G8ehfjNnLJXDwpJvQhluVFnlwwernVGunL0HL6BolqJh8HkQvuaSM
   YKduyENnYEUI8j15kKCyeEUGlt6lXibDjYf59X3Oxwnu3zhHWZ0JsDUk9
   B+gQfHlX5y7lp18/63QDJPDns3LsqU+vHk8Q0iBVFV6IaG+kdsZy3RzdZ
   Q==;
X-CSE-ConnectionGUID: c8zrCu4NTD+viag2F+J1+A==
X-CSE-MsgGUID: MeJW49oVToy8cYB3eeUuRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="41017066"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="41017066"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:22:11 -0800
X-CSE-ConnectionGUID: Tb2uVif5SoCPeiIu37Vxfg==
X-CSE-MsgGUID: oqgylTnnTf2aFuGl66fzUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114778657"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:22:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 13:22:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 13:22:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 13:22:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b70NGNOzxnQyaV3KZ6nvRBbcuPTQXIdBAwOXB+4u21rU5Jni7IA3f8lIqS2hlAFZZzZodZPz4VYKXLg7EwbJkqSOpcATKBO3k7oPbTuSlBBmQY61fl23pm3FIxeZW2nEobouzc7s13Ut703MVKR52D8TxLZGRTd1lpXglJhI+61FTXF2c1vpfCXWy6QXk63V9duNKF7DKVRPxfYx0O7zPCebk6GI1Co0wux89IsFM9TNDP5+l8ceSnmVF6Vp1bCHz7IQsYST4iHhBiecyTIgI7KT2W2KqyI0TQbc+fPHVmsThS8n9/8YiO62MDk+CAK67VdXzw/F8gZ8NpOFmv315Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFcSEodALEuTOI7IGCvjWKZRz5vfvepyqAURufSLYyI=;
 b=cxlNw+Z7VObCI8hIkJ9LCTEA7/liOws8+WvvPFmdcn2IFh7D8nBSC5bUFTazvAIb4iAqRJN+fC8OugmyDf/fxV46q5m/hhx5ZoMzJpeX0N4KNas/bzNWfVgGZ4NqudtWFtghtiY5rIPgtuVEIgVOaKFXL8C8/FfoPPJxGj/zWqCn+IjmncOaMAwJySsl0hSLPUAy6mwjGnZj+JKwa08yyt9rQY7CFAo/5Nsyr/mAaWqzroMqfu82kEuF7TMvvj8KQN9I72WE3vDqQ1tNdHxQFQ0KxbXwvvGpRs3Pi6AXtP/GgtpQDjEZKbcmMfLb4RAAcGkv8eUjyWIXFIEJkvfBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5284.namprd11.prod.outlook.com (2603:10b6:610:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 21:22:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:22:02 +0000
Date: Wed, 19 Feb 2025 15:22:00 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>
CC: <dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
	<ira.weiny@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] cxl: Some ABI doc updates
Message-ID: <67b64b7899508_2cf2f8294ed@iweiny-mobl.notmuch>
References: <20250218224853.67457-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218224853.67457-1-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:303:b6::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: ec88f6ba-8051-45e5-9f7b-08dd512b73aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ve5q1dT+D3XGx124Oj+3zWXB0cf4ny2X8O9AomObYGWkafZSsMKjryP5HL+I?=
 =?us-ascii?Q?mD//+fzofb65Z4j0uXpAvDAoUSS1ZXHKV2sfj2Il7FqqLo8ds14e0FHzy+J6?=
 =?us-ascii?Q?yz88rjLsLqY0/m11/veqciVNWDmbM9x1/uvPoTfBmqT/OfruPawWdtniWalU?=
 =?us-ascii?Q?y3Dsl4GIv6Dj9/aR3E6N7Q3W7lZw0OM27M7rWGlaE8ZmBTf+aG6oKmOAXMLu?=
 =?us-ascii?Q?7RZI+eyTwZMnIxrk28VHGQ7WV1r/Ys/g+F9iqZie4QNnLeNG3MsUPBLGlsbf?=
 =?us-ascii?Q?hiArwB/hDJuehLTxxRQT9k9KNLIJtCnRb8b1q+Fvy+BIiuCHS8+Z0UFdMAag?=
 =?us-ascii?Q?9dtjdKOqFFm3zStU9zs3+6qIa55BAe4yvo/h4gDJ3LlCfC9UWKUs93OzMpVt?=
 =?us-ascii?Q?CmLAsXT95c6wopVyEVohoU3K2ZCu4OFC477bKltXLT5RdGXBL+lJC5o1HYZ3?=
 =?us-ascii?Q?sBrZlJeJCoREHWYtPsHP+0GWNsTXNDWt+GqQjHsrKxnHzvyL94rRN+2aTrKn?=
 =?us-ascii?Q?51u3qAWK3LvcsmRAyWSI99ETXyUgXQcJ7RIDgpQPl9WpnyMaBx+fD4aY3YaA?=
 =?us-ascii?Q?wS9q4IwJu8eVYsWeXA7DoLfWsOWELnYNoWMGtwbEzzeY1+OZ3PVN4IioNWJD?=
 =?us-ascii?Q?maA9GPz/4qeHQKb7Stx0vj0qTQfzErvCZwXomyQXE65TTnZxznMxsGTM5EEF?=
 =?us-ascii?Q?/WcGZev7xfJlH/YFqLLpkq49zPExxRTcTuR8eA231PkZCV2Ze4X2rQLTxcTZ?=
 =?us-ascii?Q?dVF+PS4XWLaoPVQEpmDag+mkN4iII99RWSCmnY0Vo4XPTgJCHJ5dha0WJQJz?=
 =?us-ascii?Q?qpVd2mBb5QqLs5piGIy58oKqbCFa2n9/QHlkYWAt/Ikrz2IgSlCeh1oO/jl5?=
 =?us-ascii?Q?cEBjISgjkKwde1jz5DRvj2xJY0/0KGHo7GdWiFCIFJZWhQYaHRHzE4B6crbc?=
 =?us-ascii?Q?cVVFTlWL2E7ROuWEUEVUa3Q9jvpJpVg2KbhKJytAPtjQF28y75xsV5TPM0Q2?=
 =?us-ascii?Q?R2TFjXipnbrH5IyRq66BksCfsu6LL7G4140Wt1arDlzfYRHCXN3Hg8fcG9Ob?=
 =?us-ascii?Q?Xm+PMv64M3LViIzjsv21KlAZJcJOl9IPbC85+DiqUjNuoHSElP+GbBXrnGND?=
 =?us-ascii?Q?B4UGSUQUqz6dI9A0uMONBZV9MiGzH60vA7nNqYiNbwSao4amM9Np59f+DMEU?=
 =?us-ascii?Q?Gn6uONZIQe5qb8z9a37Ocf47qMozbNFsGUj45G99JHQX25/DYQIXRo5tqxox?=
 =?us-ascii?Q?zoabcYJwVMWYIVG327YkT8sQ9TE0P2IszRro3NWJ5jUP0hbQpt/dbLjBRpF1?=
 =?us-ascii?Q?79gQH55uyhIRzwpEvRt1t0q+Yi6SJauuI/wCI7+HTtgVFLNiC/rRM47ffgqb?=
 =?us-ascii?Q?7c6bUTHzl3km+nxSB3YicdpOiHL+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ir5qaTr/jICGkjQd37XVD/6eFUGrN02WrOcy/jFb7PVpgHPlVMZ1DQ7PK+Xw?=
 =?us-ascii?Q?Cmx1fu+ATMiXfbGHlhuFdn6sf0aDfI02xtYH9OaZ0WzsCIurZO+GWh3zx/Kn?=
 =?us-ascii?Q?+33zk+6xxSEKZ0xq+CWzzm+i9mortGGpEUTgea3fIPcyI57Hh7vR0Ry8zLOH?=
 =?us-ascii?Q?kdJG3hnmYpLgozJANiilD9mZRb31QdLv4QvDc/n4t9ewUn6Op8ykVolxFrtH?=
 =?us-ascii?Q?myDjSBefoIWnjAM1tv8mAXXEk4rOHqDVIOCrebcaE1N6wdYonvkXagwvx/+k?=
 =?us-ascii?Q?lajGCBJDNPVUDWwXM1CeWc088rWvePPKMOLtsqD0uOqV9FWIRa3yVzPQGwmn?=
 =?us-ascii?Q?7kW19v459gj9VMTDOCsqRKSJBKdMUKVxVRrgFLtQXHLL13JUUHxF9vSzyhcu?=
 =?us-ascii?Q?2H3y7muaDXNDPtyiC4UFTT2NFNLJlJccjpxMPAHfY+gG9AM/Sb079DMq2MOG?=
 =?us-ascii?Q?BjpnlvPi8CVVhPlz4Cm6G/iUGzvUnuYkxGokOGwnGNTfirzmQHi2B7q9nXTZ?=
 =?us-ascii?Q?m9OgNSKHXS8rcdMyAwZZLU0VKfGBzEuxXbDjM/+THtRXRtF0NtoVlJq5Pvl3?=
 =?us-ascii?Q?+CFq8glXUgeZ2PlZk3QUhMHvCfQ87lUSNHY+jaQQOw6NTCPVaCa01ABeo/pX?=
 =?us-ascii?Q?/uEVaPem7X8NgqoqQDF2pkU1ZoioZ5JJxGJB+w+gOFZlwmyhzUWAmpNcDfWz?=
 =?us-ascii?Q?wo0lLayRDTihpuNQQdl45MJqGFSYw3NfacqeLUEnWiCXrovMxsxlj4M2b1Tx?=
 =?us-ascii?Q?sdgxx8DGlscz22uNkoGFv/utHmkrZfFFZ3W+fwEnH8Gjp0x1//YsNNssulqU?=
 =?us-ascii?Q?05szbcK+WBtdSkPLpvcoDyCtOIC2koXZwIu2iqFG/dQXPth8U8qzVCnSUFuh?=
 =?us-ascii?Q?yWImrgYK22UoTuKkuf0gPhhnP3kRwM8ZQ8ycl6Wl5tGUkvggdac6Ah4xZFfZ?=
 =?us-ascii?Q?5L8OUTkMh4UcYWe1x7C2KvlgMn+cKXTe1NOxyKFz/35bzYnIZlRSSAnDObG6?=
 =?us-ascii?Q?jbDjKaRawzLO/FIHt7fLwrucEZweMpfJJcIybfNKu8loGcid9fhBYeyy+hI1?=
 =?us-ascii?Q?7GvUfvhsC22AL675ipWGhUBVt2clZJpbgYLRC/7Pq6Sd4VLu9Y/znwpaykEC?=
 =?us-ascii?Q?V1A4u30fzegYh1YBi8J1HEdV7HwQAXqZ1M1e09N5CFuxJceUY7O8+Vi20mZn?=
 =?us-ascii?Q?Vt7N8qrgN1V1f3aodRwNwMwFQHo+mri0Qv+ai+otBxRvxY9alUhVfnrcJhAG?=
 =?us-ascii?Q?OvgJYoJC2XP6scDEhMv4nTwi8Nh63FO+wlSjdZumYp8wehTbAO4dlrPzKq//?=
 =?us-ascii?Q?DP1UyF61/DOqx7LDordgTGfFGZkmiW0mewVt5+Ndu9LQo5RC+BobVjwpPdw2?=
 =?us-ascii?Q?7gP33G+cvmq8sDc9VWE7chBWW3/SgWOiwcZXTr0uQwtFrGHAknGbBd/bt/SR?=
 =?us-ascii?Q?In1tm5mgE889Iqrmv5BP/F6kYnCfiSNoXe5R6N5XaoIBLZleftkLIdOsJJ8L?=
 =?us-ascii?Q?jZCSz+b/7JC9rlhacVvBwXmVZh6TSNYQbtAsD82HLYU+rqbSTD0YhgdTv/gT?=
 =?us-ascii?Q?rpw5yLLQeZQ9Isg58Y90UKs8Jq2CUHPeXBEKHMrH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec88f6ba-8051-45e5-9f7b-08dd512b73aa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:22:02.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0xIZcFUFAk2b2Fjghh0H5n4L+FCUy1zZBTb9MtBpGbQ/fRmCDMX6qGjFx9vRezLdnktkdWKtWqS2ZoTT3RIHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5284
X-OriginatorOrg: intel.com


For series.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Davidlohr Bueso wrote:
> Hi, Two small ABI doc fixes.
> 
> Changes from v1: - picked up review
>                  - s/Mb/MB in patch 2 (Jonathan)
> 
> Thanks!
> 
> Davidlohr Bueso (2):
>   cxl: Plug typos in ABI doc
>   cxl: Document missing sysfs files
> 
>  Documentation/ABI/testing/sysfs-bus-cxl | 26 +++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> --
> 2.39.5
> 


