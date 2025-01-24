Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804191991A8
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737678636; cv=fail; b=I+VLdO9zsNU9pv5mzBf6Tc5ZCsHU05KGa6IrEuGWiWVvvupFnsObprheGJhTrI4nnGmewHUS3rcXDbMUAUapQT8JLo7gH6aV4ZHafRNjGjJu/qW3ihlzu50hwYx+crcIdxfQ4KjyqA917jAcWaH3DLPf1Kt8UmbJs6G79RhgAXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737678636; c=relaxed/simple;
	bh=SU82zeLL8OqJuedWvZME25D/7RMhHoz0zp25jc6EEXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XxotUSeWbVSiw4gEgG8ypDGCrZDubFYaZ1ismqt1Xzvd1LtletsDYqlITygw45viP5j8RU57Uud3+Rh700s/4k5O29iuIYfI8nnWM/gm96K1W5ubjXESiuTW0xgiMA434MQWb3SP9MYAPNXKmD6AgPHaA3AVHCcqqw+klX+vxac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKIkpD69; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKIkpD69"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737678635; x=1769214635;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SU82zeLL8OqJuedWvZME25D/7RMhHoz0zp25jc6EEXU=;
  b=gKIkpD69ocpk7td1yaBU85Fi4z5rhERRS9kiTGXSy35/KynWXIRcDpBf
   vU6xnhqr8GKc6h5KL68ADAiUhpA/ULCiRD6FWSvgvBRvPIvssDsEf/jQJ
   NKwp2YcXMmqKLudOQLnfI1Pf4lu2tE3PAnawT3mQGVIor1sAGSdhWZVfD
   agAFj11RD2k58GI8mCkARHGr22meB26OHDbyxOl8gaHsmDZTHJ/i+9/Jj
   YChYD87msiEB6Re4cuKjFpJBnTGO2EGKb+n5ga15YTc3e3P1W26/idsiP
   iACp4NMwjczK6hehcVkRCMAoO18Dmw1bF0NAiYiHZ2dqDz8S1WrDdOjV7
   A==;
X-CSE-ConnectionGUID: 0V1ySIEWRXSMtDCBqrt/eA==
X-CSE-MsgGUID: 5K6X8/J9QnKcXZz5JZBk/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38097496"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38097496"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 16:30:27 -0800
X-CSE-ConnectionGUID: T3cv3ZVeS7Wp27xetv40Cw==
X-CSE-MsgGUID: Hsx6f+C9S2ubSpB4S9ju7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="108161123"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 16:30:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 16:30:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 16:30:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 16:30:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2GBpjDihUlwys3cV4pEoodTUlTjA/FexC6aXYSkNuLAOwKPHP6pxS+iq6MjLD8IjWBxC2dn/DDNahtaQno1xVPi+5vvJAF4MQtkDpk6HMx4M6y+NZVSHuA39QBN2zf4A8MQTC9XitkZn+D1tj2xjCB4yxirTWSEmDLNf31wZxzgIKOwPwKtL1WCpP378+iSL1Pr7zqgWdxfvOj0Kwo9dmK5ufQGoaw9v4U0RIwty1K0z0bbBQLm5xC5FMt3vBleZ5kbPl2JiLp6vJGiuVa0ncLQ1jUFWCBeVRjEMw8Q8vGFyGkVkM5YPz5umKrzxwCofhPW/aUFLOmLwDYnOqOssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cg/xjxVnYFqYTs2OR5rx2Ct7I+xmYoMh7s/YshDHP8=;
 b=rngxPW2lRLlELgcXAxYZI+P0vpXhTkBz34d66zBX4O8hvJSpP0wsoMqbPyznMgFO9tdj+IExKeiJqIY2U5O7rBBvmISx/AeyTV5hJT8dC7O54mhJ9lKeIo37EGwdOMjk58imfJNw8WMJGGtykoVZJ3gpBzaChlI+7HAFL0pN/9Lbd/o8dEEpzMmGVRA1cRzfj46hn4qpogRAo29it/t71uUhYFf4LczKAH4xa9bPz/F45O7McDrdj5lsBTa0fSq4gd0AKCMlAoQ8T3zpnD6mpJu5MKbeDJlS3iO2Nb9Uky4g3r5O1VxprhVLPbfiCh5zRjumFJLvlgYrXio/ISj/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8534.namprd11.prod.outlook.com (2603:10b6:408:1f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 00:30:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 00:30:20 +0000
Date: Thu, 23 Jan 2025 16:30:17 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 04/19] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <6792df1982a19_20fa294db@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-5-dave.jiang@intel.com>
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 733307bf-3813-4fb1-7810-08dd3c0e4873
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ko3pRtKDVyIzQGbvV2zIvrBuwl6lOmIk4N3DfpTEnksViylHwBrR27tzKPZB?=
 =?us-ascii?Q?BMe23kDI9MGUEvIdXTT9lUleJwpLGyYq0lsK4U6sZQS06NSByRyZpFUFi0/O?=
 =?us-ascii?Q?2gY5U+GYGECYe1flWQgnbro1EcP73ZY3NOmv1PUhLEVc8cCElABZFJOSrm8N?=
 =?us-ascii?Q?6CCkEzLfrPm+JIEPIiJIxQxOzfcFPcIqDoe1wipKoUlFGknEs0ReBczy85xP?=
 =?us-ascii?Q?zFfgrA+GLubGtuKZecLgmlmtDC00vOx3ZVkPeVXm0NU2aCF7ahzkeYoAlJq9?=
 =?us-ascii?Q?K3KMfz22apJh/JJWVH2s7AQokA92tnkm4h7JRQHxWtw18px3Ru1FGry/A5zY?=
 =?us-ascii?Q?zYSUsl04vkzEGpFH7lSRp38cEbTOkkJSvYxV/YbBrJmafGl/26ik1Un9KhgR?=
 =?us-ascii?Q?Xd6AGYh1Bh3OjUF4eQcguOd9qkZd/16XovpbPpVBZ4r6R3QadJ2Ib1kjxBK3?=
 =?us-ascii?Q?pLofO13LPhoBHm42fcYqzTBzHsGimG1kdDnkkpdV74DbY16L+bm8k+ezf94R?=
 =?us-ascii?Q?1MedR048FZUtoJd1yg08TpORTgeNyXRsBlCk9XNPVts84tt5G/dROUAIbXiP?=
 =?us-ascii?Q?9Is+NrEUce6eQRAZF9M35ukWXJU4REt3hAOzpmckBQK1dAh2ehsDpkpgO0O3?=
 =?us-ascii?Q?XdN1GyLf4j1KxZTwFGyMTF3H07Lo3mL3MwsqZbL9P1vY4taR2eBHQeUC4T2c?=
 =?us-ascii?Q?fNB6MglvqUg8dq1CK7eISWgZGfloSR18aENFUx4V+Lw+hyoy9x5tJk9NuqqX?=
 =?us-ascii?Q?1BaPqeoghzgQQGqlsoTeSxlyFv0obFh/6lp41ugESESmHXJAb4ND3RCtxviM?=
 =?us-ascii?Q?OK9mnNslx6whOfoGepDzM6kW9BNeBzEKftffVMgN+2WOGs1nt55c4OugQ/3F?=
 =?us-ascii?Q?j3T2CSadyc4hzFL/4leVGZsIg3KgWZbIMiXOurJkqzPmQ/VIkDFKJyqVlvP/?=
 =?us-ascii?Q?K/FQDla4oGIUUi+UAp4Bs/6aLPIRKz1/64weLWv0m2FhlLn0gbWYMdObcdU7?=
 =?us-ascii?Q?zyp6DOoVjwBEEUqs2vmPWlZUnnodaZySBRdJhocBvcWiZBBMLCbX3FHGqXuY?=
 =?us-ascii?Q?WiZwOgkKxGk5Bm5F495ifZCfn3kHzO69pywau5Y88lKbcbZmDPL7yKAbJWyR?=
 =?us-ascii?Q?qG+IqrfNtiFdQWi6OhEQreVATtwxrRpwtp0qKA/1xat6eWfH3jlgO5Cs88rA?=
 =?us-ascii?Q?sFw+hQU1XMC584elV8+FaaWg6OnltBWE/PO+UgzTrQzX0FNYeQSszFfAFDgK?=
 =?us-ascii?Q?wrkjbKOUnMqvuEcSRpdyqRvchQwnYKwotSuwtwGYkkvh9CJPJsoVK1IKwY11?=
 =?us-ascii?Q?Td75CC6a96z4J+xcvFuRP0l++LX/oD2lVFyGxGNIvMcrUvNBcXh9YPApGcF+?=
 =?us-ascii?Q?gU5xMjSes2soDSVBl51oRZ73jzME?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9L4RwhemnmbtcOtHMvaLB/NvNIfJAX3NJLxyhFpUHIb/9ZofGhyLMBACo5gQ?=
 =?us-ascii?Q?xrIW1m573ynpZF9RQSiYX8awBxA8lE1ULQIKRhzPZx03W47V5U8uFpZz4N+M?=
 =?us-ascii?Q?BjGqJnBtAp5+bqT3lTbHHDeHytvoFl2YHOnbxdiSX8F6mfLFsaOo0osM4XuN?=
 =?us-ascii?Q?evPUyQjy1+xVfWT5kNg3O/VvmU3P7PhBY6jRs2SBwOgGwFEqSDWBY4Uq06N4?=
 =?us-ascii?Q?6pTDZW58d+vr7SilrP7dyWNZCWPQXlg7ajZIuKC0TWe6lu6g+IeRvwWrHVPo?=
 =?us-ascii?Q?y/mH+xONf2wSqiDkfF6rHFcKDcX5NeHHlI5bkeX2PK05r/D1UMrRPXapfs9G?=
 =?us-ascii?Q?EkSvsEMPXskaOTPNUmD0a/gbgFjtW0VMdtSv02cP76Norj9WF+fkrbMDGNwz?=
 =?us-ascii?Q?2fTewpwuTWpckwKfj6rOMR1n0Qt8QdKYmtmWtTZlqTmqqGpw1281T1GjoBUB?=
 =?us-ascii?Q?dEuyaNfykZbMBYHOBX+FGp11p7rri/cD4eX65SuiNWtZriQodt/1p/vudayx?=
 =?us-ascii?Q?Nh58dzewrTw9N/m43QFbRCUh9E4UC/cLf8yRAu+uaefsde9jX+iZrRqPKDhC?=
 =?us-ascii?Q?BL/1Zg9O++qkyq7Kxl5u1kdhgAXo8l95Xo0Lfs1x8PqOAbMZ/qO0MMFksPv+?=
 =?us-ascii?Q?CWZnoxy7filFzbMnXtnXN98BTmXW2vXyYMSViwxNJOBuUeog7BH+I3dF4PJI?=
 =?us-ascii?Q?fpBqq0WTQR9nLjVSwjVoYnwGCxYh50u4zzCEMnE8TN301aJN0zzodQZJ/AIO?=
 =?us-ascii?Q?XhgHJf+TNKra2R+Tq7jW0hpbuUp2bN8IQ9tOpCHX5NujXnR7QjVm/FLNRjwh?=
 =?us-ascii?Q?WJBfjyWApnTJu9UGwdlwxcPY1TlbJnoNJILzOaBcz+WOo/ii/xXsmHxfJTKj?=
 =?us-ascii?Q?dDMh9ubE2pbKNWovhdV7DhjGqwtovsz8DOXrAKoRQCG9TNF/4i4vSvQsGEmG?=
 =?us-ascii?Q?pB+KK3aBffanwkuSD02FMhjeMW2rp9qrO8bXp4/KKK+byEhIImGoCu8UL6WP?=
 =?us-ascii?Q?+hlSXAFEUOKLSNJ6I22SDnQIGcibzGhP9P+FXP1G1B/oyAOKkiWdukwP+GC5?=
 =?us-ascii?Q?RyUY1G39bocVhEc+WHBhjpW0eUv8wTwb6Dngq1apoy4Ok6NU2u33lz7b4kPf?=
 =?us-ascii?Q?9oj2Ef7/8tfvWpA3pgyZCU6JQaORYn280c2eFEsuuaxAyCGKJO8mjj/cWJdM?=
 =?us-ascii?Q?TDsaFcaJX6U6aPLLDMXlDS0TKHWvJcKYlA5Cn8CiE02Gk7lLQaAmJ9MYEEEn?=
 =?us-ascii?Q?v8+UV9p2GfYHpSiDjme8Qqvuh97iPa3MNT4wu9KBXc0qijFr90RhVkW8MKiv?=
 =?us-ascii?Q?QfY45oUEoGGsKBm6XBg8bKYkQp9rpCgba9bcT4Uu2EsGSTBtyOojghqZlGv3?=
 =?us-ascii?Q?5gDSXBo2cAkLWJJC04JHFsS450PTVMyVIgDU/KXUicQgwIbOHXovDZIY/+Nb?=
 =?us-ascii?Q?1mJaU8t1trcbQXj4azFLE2rslfP07Br8+HDxTsXnPlWUof22n6BFRPHdS5v5?=
 =?us-ascii?Q?OsJe3Umd5IZsBGCy8Cvl9sNyQQ7WAQCpXUuzCIyLItLCd9ic7vPL7mX5P33e?=
 =?us-ascii?Q?xLP5eyHA4DhZmJkip0hk5dLo6HTuwL423YGNlg/mMjmpWE+Th3kogL11Hod3?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 733307bf-3813-4fb1-7810-08dd3c0e4873
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 00:30:20.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er0Hk4fOPTWNTDc4f4yr0p6tA4X6j1aMay0MCpmX0nYhmQ2yaJtK0Nf3mpM2wxNdGcMd9rroLwbNaSkZmvqyjX3tAtogkSoN2f2tFZ7Dx3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8534
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> The command retrieve the list of supported device-specific features
> (identified by UUID) and general information about each Feature.
> 
> The driver will retrieve the feature entries in order to make checks and
> provide information for the Get Feature and Set Feature command. One of
> the main piece of information retrieved are the effects a Set Feature
> command would have for a particular feature.
> 
> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v1:
> - Change input param from cxlds to cxl_mbox
> - Move mbox_out declaration inline. (Jonathan)
> - Fix __counted_by() input. (Jonathan)
> - Return count for cxl_get_supported_features_count(). (Dan)
> - Remove goto from cxl_get_supported_features(). (Dan)
> - Return cxl_get_supported_feature_entry() directly. (Dan)
> - Drop user path enumeration. (Dan)
> - Move to the feature driver model. (Dan)
> - Add support for 0 feature data requested.
> - Add missing increment of feature data ptr during copy.
> ---
>  drivers/cxl/core/features.c |  28 +++++++
>  drivers/cxl/core/mbox.c     |   3 +-
>  drivers/cxl/cxl.h           |   2 +
>  drivers/cxl/features.c      | 146 +++++++++++++++++++++++++++++++++++-
>  include/cxl/features.h      |  32 ++++++++
>  5 files changed, 209 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index eb6eb191a32e..66a4b82910e6 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
>  #include <linux/device.h>
> +#include <cxl/mailbox.h>
>  #include "cxl.h"
>  #include "core.h"
>  
> @@ -69,3 +70,30 @@ struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
>  	return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_features_alloc, "CXL");
> +
> +struct cxl_feat_entry *
> +cxl_get_supported_feature_entry(struct cxl_features *features,
> +				const uuid_t *feat_uuid)
> +{
> +	struct cxl_feat_entry *feat_entry;
> +	struct cxl_features_state *cfs;
> +	int count;
> +
> +	cfs = dev_get_drvdata(&features->dev);
> +	if (!cfs)
> +		return ERR_PTR(-EOPNOTSUPP);

How could this function be called outside of the driver being enabled?

If the driver might not be enabled when this is called, what stops it
from being disabled immediately after this check?

Went looking for the caller of this function... none in this patch set.

If this is for the EDAC use case, that enabling had better be triggered
from a known context where these questions have a satisfactory answer.
As it stands I think you can just delete it, right?

This has me thinking that the EDAC integration should just be a feature
of the cxl_features_driver.

...that last sentence made me itch because I don't want to have to
untangle future sentences like: A new feature of the features driver
features a new Feature to complement the existing Features and other
features.

So I might need to ask you to be explicit about at least using capital
'Feature' when talking about a command, 'cxl_features_device' when
talking about the device and 'cxl_features_driver' when talking about
the driver.

> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index 644add26975f..a5949312a4ab 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c
[..]
> +static int cxl_get_supported_features(struct cxl_features_state *cfs)
> +{
> +	int remain_feats, max_size, max_feats, start, rc, hdr_size;
> +	struct cxl_mailbox *cxl_mbox = cfs->features->cxl_mbox;
> +	int feat_size = sizeof(struct cxl_feat_entry);
> +	struct cxl_mbox_get_sup_feats_in mbox_in;
> +	struct cxl_feat_entry *entry;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mem_command *cmd;
> +	int count;
> +
> +	/* Get supported features is optional, need to check */
> +	cmd = cxl_find_feature_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
> +	if (!cmd)
> +		return -EOPNOTSUPP;
> +	if (!test_bit(cmd->info.id, cxl_mbox->feature_cmds))
> +		return -EOPNOTSUPP;

First, who is calling this function without knowing that features are
supported? Like how did we get here if something already did that first
level enumeration.

Otherwise, that looks like a lot of work just to ask the question, "did
the mailbox see CXL_MBOX_OP_GET_SUPPORTED_FEATURES" at init?

That could probably all be boiled down into an enum like:

enum cxl_features_capability {
	CXL_FEATURES_NONE,
	CXL_FEATURES_RO,
	CXL_FEATURES_RW,
};

...for tracking Feature command enumeration and optional write support.

The cxl_mem_commands organization is quirk of the CXL ioctl
implementation cxl_features is free to not copy it.

Longer term we need to think about how to make cxl_mailbox more
independent of the memory expander / cxl_pci use case. Whereby, perhaps
the consumer of the mailbox passes is in a callback that takes action on
each found command. Then we get out of this game of how to cache command
capabilities that are awkward fits depending on command set or driver
use case.

[..]
