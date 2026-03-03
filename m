Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D81DF248
	for <linux-cxl@vger.kernel.org>; Tue,  3 Mar 2026 03:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507529; cv=fail; b=a0kC07ljxQwnl3RHel0rRVqKjXrwhYNzpCnrSaQ8mGHRQRs7Bc8PCjhlADjcEzCvcYAEXdDP9wJZHvvP8C0E5EGhqazSsESrGg/yjQjxMV+5I09eBxxsDopqPcqjLSd5gYmQWM0xsCkpGyt2RBlrRt9K7Jd/GwRBaYuNJwcpOdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507529; c=relaxed/simple;
	bh=HhmXmNLxBmi7EaZT6rhH1aM88kbFtR7F97eEnmvl40U=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=aZVFbzN2K/t0Yu+z8bThTJXdu5NQV5qsSEAdT3hXm+lRCLwzrGZK2TCobPrTXin9mq7iSbrPe7htbYCuKI2hvZT6riZ6CMc/Xb5KYTuThAqWD2IiDsRD6q4Pw2r7mlMJtLXFfsdRdoEkdGbIQgHhApfXKJkjUrqAffjRShIA6Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pj8SNn8V; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pj8SNn8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772507527; x=1804043527;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=HhmXmNLxBmi7EaZT6rhH1aM88kbFtR7F97eEnmvl40U=;
  b=Pj8SNn8VjWs9aZUhMxRUnf/z7+NlEO3oRI6rtz5we4REa2pC+IFa5u9S
   a0cKe5UKdpCX0LbeMDf16g+rd6w7yWNgD6HzR0qRIa8ijhh2f10xdEfL8
   S4aMxvAGd7FUV1STzRN3+kAgjpbQKJguMk104MOQUavFB0Mq1lA5e2IBH
   MFKbkzdq0U7dA+XgHPk3etlQMyaehRU5Od6A8HPFnAGUWHwkqICvielKO
   pkDCzgj+osjkWV9LfPANZX4ba1x87sHyjyov4DShZmy5w8GnDzWUyyMPj
   XJ9AZ2T+M1PVqr6503a7E8Jx3/deY81w8U7dqOs2Um3e098o5Cm0BdCtc
   Q==;
X-CSE-ConnectionGUID: u7cZmkK8SFWInuchobEvDA==
X-CSE-MsgGUID: 0cGMiZN3Qla0T+gN68Q0wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="84169213"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="84169213"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 19:12:07 -0800
X-CSE-ConnectionGUID: JTOJ6K6ESBGqKVi/HNA3eQ==
X-CSE-MsgGUID: nWuaix3wTXmwqUpyXbUtPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="217767389"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 19:12:07 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 19:12:06 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 19:12:06 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 19:12:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Htx5KU4zBj2Kg1+T7xgPKRDOzZvlFa7OhjTgpgm1phL3WZ+pgzvZ9XnRrPSHL5S992O9crVHKtibXVZNmJloV6+mWcT7eAnbyqzNmhfXFBwmnLNYpFGRcsiylE9tsDLbsmrJrSvrzBXN/o+1uf9Xxmpv6uuOvyPMciO3uq0d77LIkAWThQ0WFFIDfDA2BGMsHESPnzT8sLXHw9YzP6hMOO38jwAawqv+OjCcnZNYA8qR8y8psPEdmBzcjJRMPCL/EmOyaZCmpDljtu5ZHkOXVAU++CfW/3z/Gd0YXjKGQsCdeX0ygJuxiY+hKVq0QLCSYSd9/zHFjGeN98MJbchwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsxeMOMVf9EqbGr/8Erc6sAbGx7E2zCGsf9mSqKKNOA=;
 b=bzDHbVsgqnn6UcniFWzEZ88DxCB8OIM9rZyds7yO7OdT4eDUi3lK6h0xJfTb36pIrEfM2WrNca2wkOlbzgqmLABJ3iLFVpm4iiwf30jtg1fSopIK1QvT1KSaurIOaRkNW7JDD6QnMG5Nqlw7vHB2kzJTVdI4kM7nznEXCa60117+Umkmx0c+IcsQucnGca15wMt8ZJQeq5A8f4hrmbEo4nd8vD+HOkQ+PgnZLfhlMSwRpYbqyKpqnoqAOL/6txtYVceRf+FTfmBnwFm2ZQ9poEY9YGH1FGewASihaUm3bBF7r8ewSjEH4/mC4OmLZxC3DIPZ70oIqFQwgl6DKQU/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5205.namprd11.prod.outlook.com (2603:10b6:510:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 03:11:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 03:11:03 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 2 Mar 2026 19:11:01 -0800
To: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Li Ming <ming.li@zohomail.com>
Message-ID: <69a6514597db6_6423c100e8@dwillia2-mobl4.notmuch>
In-Reply-To: <20260303001616.1821728-1-alison.schofield@intel.com>
References: <20260303001616.1821728-1-alison.schofield@intel.com>
Subject: Re: [PATCH v5] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: b05c951c-76de-4f66-2181-08de78d280e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 0wJWljU9dutwOgfjW7eA3e1AM+wCBy3teCX5EfDPvbIaFnCogW/+ZpoIVbYl2MQ3DjvhKLUeMrrcKR0CQTq/fgu1ksAqC5TUOMwX/cX4CLBdQDUGOjhdzsrtrkLklLPGafE7NtwljL6hyGibRc8JPxcSEzVEHklVR1VR3lSjzoLWXpxPYvTerdW3+67pH8zpiQ075y3Sap+MMfs/O1elKTBuF8i7P/X7ic5hD5inaDpKUSX/RDPeOkkraUcRcP9+Mr/t8CJjXtxPfJLKTpo8aW3B7kaVG2pWwrJ82pv2xsa7WpS49BTwB0qVPJG+uECYTgXNqTOMZ+unQD6pAWymTshFCdS1tqBhhm+qUdECCY0F5squqLSmQ2wCVkCo5sDhkYJ6gfZf8umLdhTGh+GQRAbThCUMo1H+WFfvaKyoe3m4gUfHat6s3lT9p8JL184+iFNBWSoObvl57TQs3Lr1TVvQhKREfZFnfIudBJXYpPlSOeIyCYdUHRtQvjy4UMftZ2orBmVfvQCpi28zLsVPGl+cJ7ZMZZyAGJLl5q/5a9NiXJ6FzAxuM7TiRYSzgwWgUJ2Mi7p8DXEa8u7/iraB0ld3V2zOOVbIrL2nLZf+xlwZKpRFCxLwogOfCbFduYNIJYabvnSOHHMqFHSvFnk9c3Ks3CsogKWA9MRXOXmvWubplcNEVx9OEf7VkLVemDDeTJpcIrdLU58dUJXs9XOQDQP7D3WMH51jifjMyOeBKHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtXLzJ0eGxZWWFVOXJoQUtCRlRPM2FUSGJKNk04NmxKdlc1V2wwVFBlbHor?=
 =?utf-8?B?YS90Zk1QQVJobUs5MUZDaEJuZEVTMzkyb2wxUWhOUTNuWFNwRE9hZlpIUUJw?=
 =?utf-8?B?SEdaQmRibTlDU1RVVzVoemJwclVDbTlIcE45RWtmOUdreVNld3NwYUNyTHBH?=
 =?utf-8?B?bklXVUFVcm84YmJMVEhEVzQxWjhnUWd0VW4wazZsbGxHdzhCQmZtWjIwaWJM?=
 =?utf-8?B?Q0VjbmtiUlIyaFFja3Bua3IxVDNmdUNqeTY4QTRtMndQNzU4c3FxYzRmOFdv?=
 =?utf-8?B?SExLTWxERytEdkNKUDJVdGptWEZTSmI1YlN2T0VKNmNaSVRKZkpaY05aTkJZ?=
 =?utf-8?B?WVdQTFpFdEk5Y0tncGxPOElqb0NEOXlNdTBuOGpwZndNRndoY3ZSbXI2cEVz?=
 =?utf-8?B?SkFPRjdqeVZ2WnhtY3RRU2VrZEl0dDJKOFZjWUc4ZCtDTlZBNlp0SkxUYWN3?=
 =?utf-8?B?MlFwQ3N0Z01pV1R4UkZoS0NUeW1jdkJtbk9mTisxTFpmSjVyenFMYkllMmdS?=
 =?utf-8?B?Yy9HWlVFTnVKVkRYYjlIcnVENmFTbUh5NFlIc0tWcVNTQUxsVTN4TTRDcDJU?=
 =?utf-8?B?ZXR1RFZUSTNCSjNuY2ZLTk8yK3BUVjM2VkF4Y1FhMXFCUU9qSGUySHQyT2Rq?=
 =?utf-8?B?U2lOdzlnbkJvamRqcGdmMXhoTGI0ajFPcUpUTWVUR2hNUDV6ZXplZ0RlLzFy?=
 =?utf-8?B?eHN5clY0T1dkeFd6R1RiS1pOcUg2N0xZWjhzajVNQ0NwdzVEWjNkNkszUm5R?=
 =?utf-8?B?R2dqY3ZHTndFb1RMOFUzaWh2MkovTVg5TXR5bmNDVXl4M3VNVTlaN3orSTRC?=
 =?utf-8?B?NXFSTkdXS3RvVFQvRFVwZkZhYnpmNE8ybUR1NVNLN3Y1Yi9aVm1uWWQ2Qmtk?=
 =?utf-8?B?Zmx5TnR2RWFuUHFLbXFvZXBGUkxwOHZmbUVjU1Jlc0hNd3MyaTFJL0NGYjZr?=
 =?utf-8?B?aTdVTzVvQmI4NG5qMlgwSHhHbmxiTktsK2MwYmRVcW5SK2hOV3huZDFRT3ZQ?=
 =?utf-8?B?a01saFJFeXZMTDFBWVc4V0hrbHAveS84aHlobFMzeS91dlpPdE1LVkI5OE5I?=
 =?utf-8?B?V0t4T0FQYTQ1cnFNVGZHZkRWcERBb2VEOWU2K3p6a0F1SHplTGxBaFZzdzRj?=
 =?utf-8?B?WEdrR3NVVnpkZ3E1WGRQeUFYMGFHcTJuTEZua2ROWjVzVjJBUFluT1IybmdW?=
 =?utf-8?B?b3QweE91WVpDeW5xUlBxbU1TbC95T1dKL0Z2c2xSR0ExeE5ISWJNVHdaSndU?=
 =?utf-8?B?bVdSMEJUb3JqZlNPVFlkSlQxRmIwMEY0QjJZUTg3bkNOSmxHN2tmOXB5cjR6?=
 =?utf-8?B?V0svTmRCb3N0cUVTSTdaeSsyOXZuY2t2MG9xb2Z3K1gyZXFHd3ZZOUJCbzhy?=
 =?utf-8?B?TDNqZFFuRDVsbFB5c0tGTFRxaFdKNVNyUmI1VGNlMTdpNnZYWFo2eDNySHM2?=
 =?utf-8?B?WkpmZ29mMFR2Rkd1a2NDSHJoNEgwbzJ3cWoxcUhGMU41cC9lbjd0MDdOVFdJ?=
 =?utf-8?B?ODFZcjc3blhuL2hMcFZQRUFjWXNzTE1qZzNNUGtIUTE1aXhmNUUzb2RZdTJy?=
 =?utf-8?B?ZHA0YmdmWThzamFDZm9hc3JmZmhpYlZON0JOa25NNjBzbVUycUpORVZyajJC?=
 =?utf-8?B?NFUyWXdzbFZoSmhVUWttUWxGWDU5STA1ZWUxbUJ1aUhEc1EycHZvREk2Yzlt?=
 =?utf-8?B?TE9UcER5L0k0NVMzanJrUDZnSmNadmJTQkNIUDlVWmdrV1JSNjYvSk9YUmpG?=
 =?utf-8?B?Ky8wdTFBY1NpMTdCOWk0Wmc3VG9kaE5obyswOXIvVnVOTnlydnRMMHFjRGhJ?=
 =?utf-8?B?d1RJL3g4MzQrbDhEWXFaSzZRMlBoME9VTmo0emE4b0tybnZXRXBrNmJqa1M5?=
 =?utf-8?B?ZjlpRWdhaUdmSzRqZlA3czJYS3NTam8xMXhjMTRaa2s5dTZST04yenEvbjVL?=
 =?utf-8?B?SkZVU3BDRnpidGc3TWxVQWNXSWllclNBZzZGck5kYXJFaEJTZ2hKLzFBck41?=
 =?utf-8?B?S1ZXL2dTOWhrdnVyajd2TitWVXNPYUduL0xVNFk5aXdHM2l4YjZWNmlWVDJ0?=
 =?utf-8?B?UzdjVTlGQXllV3JVZXFPMk1uSkppYndJOW1DVWZvbUZGcTFqbHg5TGdyWnZD?=
 =?utf-8?B?TEFqMFg3NHNsYmc1YUdidHhLZm1QZDlFZmhFTWQxQ1NWc1VyQ0pRTEtubjdV?=
 =?utf-8?B?Wml6a3EwQkFDdVZLUDFFUzhHRVNIRmx3QTc0T2l2NFd3eVNkR0NTUDVUU2Mx?=
 =?utf-8?B?eDFlTGRJZkRqbUVGNWY0MmlucEpoSysyZnFlOUJ1TytSZDZVSWsyWDVuQzh5?=
 =?utf-8?B?NEVDR1NDYVhXM3FmRVd4TXVwVCt1WlNDU3NOcE52ek5vTDUvbkRzTGZQdWRL?=
 =?utf-8?Q?O/Ank+9hUpLMZvJo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b05c951c-76de-4f66-2181-08de78d280e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 03:11:03.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDYmx46MfziUu3O5SGOLaQabmLUf/pxxEBfDyM/a7SpSZvJv56bqFxmDWznpVpbjbTXDcul5Eg75jyVrRRtHU2Gm2Pcl2QvwaBgbHf9xx0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5205
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> cxl_detach_ep() is called during bottom-up removal when all CXL memory
> devices beneath a switch port have been removed. For each port in the
> hierarchy it locks both the port and its parent, removes the endpoint,
> and if the port is now empty, marks it dead and unregisters the port
> by calling delete_switch_port(). There are two places during this work
> where the parent_port may be used after freeing:
> 
> First, a concurrent detach may have already processed a port by the
> time a second worker finds it via bus_find_device(). Without pinning
> parent_port, it may already be freed when we discover port->dead and
> attempt to unlock the parent_port. In a production kernel that's a
> silent memory corruption, with lock debug, it looks like this:
> 
> []DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
> []WARNING: kernel/locking/mutex.c:949 at __mutex_unlock_slowpath+0x1ee/0x310
> []Call Trace:
> []mutex_unlock+0xd/0x20
> []cxl_detach_ep+0x180/0x400 [cxl_core]
> []devm_action_release+0x10/0x20
> []devres_release_all+0xa8/0xe0
> []device_unbind_cleanup+0xd/0xa0
> []really_probe+0x1a6/0x3e0
> 
> Second, delete_switch_port() releases three devm actions registered
> against parent_port. The last of those is unregister_port() and it
> calls device_unregister() on the child port, which can cascade. If
> parent_port is now also empty the device core may unregister and free
> it too. So by the time delete_switch_port() returns, parent_port may
> be free, and the subsequent device_unlock(&parent_port->dev) operates
> on freed memory. The kernel log looks same as above, with a different
> offset in cxl_detach_ep().
> 
> Both of these issues stem from the absence of a lifetime guarantee
> between a child port and its parent port.
> 
> Establish a lifetime rule for ports: child ports hold a reference to
> their parent device until release. Take the reference when the port
> is allocated and drop it when released. In addition, pin parent_port
> across the parent device_lock/unlock in cxl_detach_ep(). Together,
> these ensure parent_port remains valid across unregister cascades and
> eliminates the use-after-free window in cxl_detach_ep().
> 
> This is easily reproduced with a reload of cxl_acpi in QEMU with CXL
> devices present and visible with CONFIG_KASAN enabled.
> 
> Fixes: 2345df54249c ("cxl/memdev: Fix endpoint port removal")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Changes in v5:
> Pin parent_port across device_lock/unlock() in cxl_detach_ep() (Ming)
> Note that issue is visible with CONFIG_KASAN in commit log
> Update commit log
> 
[..]  
> @@ -1533,6 +1537,7 @@ static void cxl_detach_ep(void *data)
>  		port = to_cxl_port(dev);
>  
>  		parent_port = to_cxl_port(port->dev.parent);
> +		get_device(&parent_port->dev);
>  		device_lock(&parent_port->dev);
>  		device_lock(&port->dev);
>  		ep = cxl_ep_load(port, cxlmd);
> @@ -1558,6 +1563,7 @@ static void cxl_detach_ep(void *data)
>  			delete_switch_port(port);
>  		}
>  		device_unlock(&parent_port->dev);
> +		put_device(&parent_port->dev);

Wait, why is this needed? 

    struct device *dev __free(put_device) =
	bus_find_device(&cxl_bus_type, NULL, &ctx, port_has_memdev)

This is the child port device reference prior to the device being
unregistered by delete_switch_port(). It is not released until after
that:

     device_unlock(&parent_port->dev);

So, if children are pinning parents and this child is released after it
is finished with its parent, why is an additional parent port pin
needed?
