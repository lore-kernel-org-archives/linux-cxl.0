Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE2221DA5;
	Wed, 16 Apr 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840468; cv=fail; b=oWrcFS+HlLZgxHjvvDfFSiG1imXDNHu44Jm13f9OPZj63pRW/b0Dh4xfhZ9Y/468dbJqw+ORUOkhfdGszjRZvdbDyuL//BYQx+nuo1g8d8gEoR8A7lwCWiElqitbLL+QS7o4fIsW/RsrDWCqXbM/mqMEMtofbeNu3NfdCOWhVtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840468; c=relaxed/simple;
	bh=EwEDzZ3UY3JNuEdDEEO2HrK+IXhlQfW7lvDMBzyBVds=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ep7gJff5d0EurW+wEBS4ZIDkqkVhMw59nHz4ieBizp7093WE6HzWVAsV1/x27AU8dz1SL2F7OyMO6ykU+vqYUTyY1uHC8fk4BOKe+Xzb9y4X7ZQ8xYdYS+7+rDDBGgVCyffurWisWaddrfK4ZLKTluhOhZ7Jv7gZb1OIUxD5+xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJAaObjj; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJAaObjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744840465; x=1776376465;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EwEDzZ3UY3JNuEdDEEO2HrK+IXhlQfW7lvDMBzyBVds=;
  b=OJAaObjjXly8onPjezcTwRd5Y5mh2Ou0qhnYzfDwjrN931AlijYMj4Kq
   B/QeV2XZn8lmK30Oe4gZcN/rlhoRVCFH9bA/r+ncPdEqqFLMubiuzt2+/
   zU1sb15afcNny49QQPWHFFXfiLIuExYl0lefdeER8TUAj/x/EkaQd6ubY
   4zbWMrpnXHBMjtxZ69WgbgHkEBgdDoLAf/uP1YaxWHJIU8AJTD8MvKPMz
   Uhl3oaXUbj0FTDvnnUWAIUuXdrZqckj0s0jnU7/IqWrneCKDQYRcdju1X
   KCjjceG4rbFRP90JQOzYhajyFqDcWwNh5D4je+a9qp+GL/61YunowY+Jf
   w==;
X-CSE-ConnectionGUID: jYryGYCZRZ6eIcM6B9FRJQ==
X-CSE-MsgGUID: 28ND4MTgQlmZlKTwCEvRPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="49104997"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="49104997"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 14:54:23 -0700
X-CSE-ConnectionGUID: jPnCgL8VS22FGKk20edmWA==
X-CSE-MsgGUID: PlKffZuBSt2zjCtyx6ccqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="131157200"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 14:54:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 14:54:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 14:54:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 14:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPkWSdZ3//dvsJyDovC7gKOPWJfLHZVaSvhgVrtkNAC6jTvvFtqfOKbAslt9/YhfjtBrLBJ9NYAqSztRadaGVNS/lEEM4jkzX/54XMYDYvF8Rvhc99Euvfzt4ticL6r7PQORidjoaLhGgMZhMSSc9NtycBZH/6kpQRwugsW6tDXQa2TKQTDddEay9/5trzXq2eHnrSk54niGJTuHE9pmdcz0Q1kXQMPuGmKCqNeaJLPbSes8Fog005EOwOH4sZhaJfiUux95EbLXYWaw5J97wrKvJdqf+DlUfgjOZ85fvXJj1Xs2ZzpQGR46+Wnyw9Kxb2b1ybeqgCK8t1c2JPBhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZtVeVaTHfqhFmubq9ad1OKiaVYRX3e5hGggpo9pD+s=;
 b=grqnzavAnLHP4TYLrBv/Mw2v2jxSTat7NmqwIaIIR6/0XWyM0Ok824Kiqr8cEU5le/zn8Y9c2jUk1lRUf7GMvOqE6IF797VNuU4NLeIHIi11ucaN3pV+VyFA2bLZLzbrHI9CAOWM74e+6cuNod/86k3k9QAooP83EP9P/3vuak0VuRYFTRJyuXFwDop5FLMnTswHg6qKh4ATvgf/RcFHxwbwlV/q5M0fcxdhq9I34L9au61QlxlGRWTne5Qy+KLXCkapJdRJ8N9qgOr2Cng0Fc5NsrGY8zD3/JYK1eV/DVt6c1cCAQlucC8+wL+Il4GQtbC1ndR/eCMLlSZjS4nU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8571.namprd11.prod.outlook.com (2603:10b6:510:2fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 21:54:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 21:54:19 +0000
Date: Wed, 16 Apr 2025 14:54:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Rakie Kim <rakie.kim@sk.com>, <akpm@linux-foundation.org>
CC: <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<dan.j.williams@intel.com>, <ying.huang@linux.alibaba.com>,
	<david@redhat.com>, <Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>,
	<rakie.kim@sk.com>
Subject: Re: [PATCH v8 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <6800270845306_1302d294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250416113123.629-1-rakie.kim@sk.com>
 <20250416113123.629-2-rakie.kim@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250416113123.629-2-rakie.kim@sk.com>
X-ClientProxiedBy: MW4PR04CA0288.namprd04.prod.outlook.com
 (2603:10b6:303:89::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d6b69c-55c4-4107-31d3-08dd7d313d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j2CU0CJg7i4Mmb3bqGu1a06J4QDR7YoY0bA2MJDKi4NX7nY2tyZ+1GvynGIM?=
 =?us-ascii?Q?CZAcT6ezmFuFYnZjIWc0aE6gTfwzcD4xbH6d/cdcbLs+I45q9hCofVCknfj3?=
 =?us-ascii?Q?gK21Trjwe6p5gtwDP0JbxAbvQKcqx0KISsS9zliJUr6MjZMH4H+Te3M6vxW7?=
 =?us-ascii?Q?PzX6Zyum4UPq+COl+WJf2hJ+iXDVF0t8gFanuoQnuFQ7O9YatURoHVTDihCD?=
 =?us-ascii?Q?Djq+pG0iMvZ+gl5Qwwu6UUQjXB1PqKBOGYEbv3lrvg3FlyqKhpYcU6uoDCK/?=
 =?us-ascii?Q?jDJ0npyMU17tJX6KUODkVWVUBIngTkv3xGC++sXCFCXo3KRMrRk+qXRlE3br?=
 =?us-ascii?Q?JNk3zQljHmiHwJcp0E75pj9RNqvl1cyxSJw7a4EcsfVK7Anwi5nn0X5v6yB1?=
 =?us-ascii?Q?YEuPuwuVOCBhUv0GRi/qAxyjIpN1QDFaV5xqyxSEYltOlGwDzaEiROaDq5a4?=
 =?us-ascii?Q?4kpcoeUckCTmjG3scCDlfLEbhcMAOOBzZMQ2KtXMclKP4vxlIjJOT+b+UYQH?=
 =?us-ascii?Q?N/vJ3oG3vy9yjJr6FlrhS8cI7ffScF0TK8OV5XyAKiSeDd7lfaCT/V8YvGFY?=
 =?us-ascii?Q?rWjpjpDRUy3ozIKcInD1AkmAZCVo+a99BBFDYE4K+e862hXtcg7++sRq6/Wg?=
 =?us-ascii?Q?9+1lAdQ/AcskxPVuOe//KtjL667VfHHyUx1r0k9RfBd7wx1Mpu+iOOnOJNzR?=
 =?us-ascii?Q?dGgNMKZkuwdwaaZeYB0OH/WuRZrP3H21CFh0juWjPK/Azotd6sD2Al9hMlZy?=
 =?us-ascii?Q?EhirYN8eteFjDTFvPqtduKhwwBGs/KbPK9MMIDLVO4CtBpecentqxiwPdZAN?=
 =?us-ascii?Q?driFLl7wokLzj99PhHdZUzm0VzLsI+Nfomyh9OGeXILKPCnhnmHM8zvGOIKc?=
 =?us-ascii?Q?eAyMzSdZNe1iHAhg2w5/a3n4wHKaakaZtwzFaXaMb5/IZXMQ8HQFIkK01BIb?=
 =?us-ascii?Q?1YvgvpIS0Nst1ZcnrZwx2KErXuSaAOPq5IbqsVFsFH82pGqrGwXeNXnTGwDe?=
 =?us-ascii?Q?CUvLgoDDjQejDqX6WFHfO50uxLMzrORoysELfqCIWHyvETt5D2+003wlD2N3?=
 =?us-ascii?Q?hAEyYVFRwkA8fMpQJuM8lECRop5WBplxIqZFH56+2+h490q34e06R0o7n7VR?=
 =?us-ascii?Q?YVQ7ug3hWEDPp6YdH+Ak5na/W0jJFSkWg/4lOmjoa1dEHkfQguKxZHnIZHWX?=
 =?us-ascii?Q?Ml08DEMEJPRYQMtqYGCKavj11iYBV0UYc/uWsQKgLwBXhce8tSvilKbnAJqk?=
 =?us-ascii?Q?4dKYgiB4lMVehgE03owP5OcmE4ynX5DGWspOW7kMZsrs/PmT87vw9Vf77A+j?=
 =?us-ascii?Q?B+ADb9PsDkwylj6ovtxrE8Y3ImfBP7xxrgrPFZwg+lhBxk2WQMxquCd9J7+e?=
 =?us-ascii?Q?yEbbqVUCkc3z0iBTooB7A/WU3oaELcHlK2mQoGaA/oUCzT7pNCDEjp8B8QZH?=
 =?us-ascii?Q?rOmqNib5rD0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EhGjKzTE5ozPfA7YuEojrpWOmoNMhxtK0KzNxuAHznyUsEvLKLUohV8e1qy0?=
 =?us-ascii?Q?RY4TmcEOajRdHFeysxcpIXhlmH/1Dcqnq7JbRqgDd/l5jD/pf8kWWLhSFecJ?=
 =?us-ascii?Q?Be8m5zYuiKzDdL74SNEkQvpf2PXJB4lTprukKrsK9ixNxyyPcJLELGUHXCdJ?=
 =?us-ascii?Q?R1Jo65SL+Qj+zUyFwJ/glDvFF/tvRAgZ9NHVMCm5v5SkkkrQ6omLJOxPqp/c?=
 =?us-ascii?Q?eKjvM8FgLXbqdiH2sqziDrYwMHLOs8DEtAkbGQ8+YLCVj0NHKi2HDo0zT576?=
 =?us-ascii?Q?B0nBIQ9g5FL4esA2rpg+G5tZ8cDOQ1qAfCtCzjeF4URJQ5vFJrsKfZURKSog?=
 =?us-ascii?Q?woq9OaGvhiPH9TkF/Bfy7sNQbi7V3Sg/acNFQ28Uz/NZ5MZ5pHlKllKQMfvU?=
 =?us-ascii?Q?isa6QpUsSRvyqukPdWHRaBLjjnDhIC/S+aVO8uiEpjMKxIzb6sjCh0NfzMlM?=
 =?us-ascii?Q?p/OJGtyYvY/YdMQYySUn2PxNC5x3zSHvk4C8oRIq7MHYCJ7mfmgzGHqCBktw?=
 =?us-ascii?Q?m8WqT46GC+OsmJjzG270wKnTsruFdcPFPymluIlxvfqIAe//vvWnOrlz+Fem?=
 =?us-ascii?Q?7oKW1ld6COlSfTMZ6x+ICCmK7cvfTGEpWBVkblGeFQzCtPMAARohgQtV7i7f?=
 =?us-ascii?Q?yp2+7k4Ayac3osxUTKMms7bnn3xUOY+FmhgXxHoqDN1XPznKx9rfM7OjF5z6?=
 =?us-ascii?Q?sWzQ5ITkV+w9olPphRw68Q8WRlNgCLa6eXDSkmXfNnS/nb/3r5vfYRsDJNkp?=
 =?us-ascii?Q?lDyIFSuZtZ7PmalpTmOrC11BNHJZaV42rSSbEuW7R89LJXGwT9BmU3RaHLoi?=
 =?us-ascii?Q?EODaJrk4xDmrMZUZ9BCU05TsY4zggxaoGxx+9E1Nm0Af4/DDaxawtxUg5z2z?=
 =?us-ascii?Q?PJyViLquKdJej4NiBG/FdqpmxTWtbZh9a5P0b5zumc7lq4GnbxNFbwT/7Wmd?=
 =?us-ascii?Q?gSzE+j68rb788ZNPbo95J0Y88foWdMD2UEZsND8eeJ0C4T8RIRm1IdrrKzfA?=
 =?us-ascii?Q?UXoij/PPkyXaS5caIWB7BQFsoYE9MPZSYe4iR0CeT8i0Aqcp4bvMxu98erNN?=
 =?us-ascii?Q?HkAjvyqI/od0Vr4VR/fFvKxSFKyQBLi9ahTIqjnNg7VBcL8DNHfj7Dd57fsD?=
 =?us-ascii?Q?FSvT7Pj59GSyjCofpMLY+pp2jEHX9IP7qQjSy3skjdBtydv+Hs9hSLlhnBRf?=
 =?us-ascii?Q?7b4WU8QR6fdoePPAy+/LkZugUMo3/wZ6IvByN5/+66TZd18IKvt23DRo9j3g?=
 =?us-ascii?Q?nmC+6QxNC3fmOpZelkUTYZUvAklKDNy6pfY8HZbVpuTOGE8wQ/kdrRw3lFsH?=
 =?us-ascii?Q?k11LxTUSvcdWJZL8eH43uF+ORLWAxfXZ/7NG5PJADUZu7ljwU7k1fVy0D6T8?=
 =?us-ascii?Q?+LORFePBPOvjJWPlMZQYaBMvDVQfP+93vZzQMEFctAHYhljU/iw/PwBkefsK?=
 =?us-ascii?Q?sQDoY4C93Ceo0qFOJLE5YFEUEDYWgR0BpWza6lMmweRvl1L2efhqEQNG5CbS?=
 =?us-ascii?Q?UAIGkxcC9S855z5eQZUK33BfNBOHYgWljSFeT0Ftst70g57iFkYEh3Sy3Azz?=
 =?us-ascii?Q?S2lPqtLD7fOW3XK1DYM5czXcjMEP6JCJN3dYOwSpV3R3r9UNrRCnGklXEUe+?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d6b69c-55c4-4107-31d3-08dd7d313d42
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 21:54:19.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClsJQZuwyJ1U3ZZyj3MPzBYj5hUu9In1RVCSupfyVjHO3/IP+jvwi6u4e6YbfdV6jUs8DIwoqFBslK4sdojBMOV6UOru+Q0RD/b3AvlNyYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8571
X-OriginatorOrg: intel.com

Rakie Kim wrote:
> Memory leaks occurred when removing sysfs attributes for weighted
> interleave. Improper kobject deallocation led to unreleased memory
> when initialization failed or when nodes were removed.
> 
> This patch resolves the issue by replacing unnecessary `kfree()`
> calls with proper `kobject_del()` and `kobject_put()` sequences,
> ensuring correct teardown and preventing memory leaks.
> 
> By explicitly calling `kobject_del()` before `kobject_put()`, the
> release function is now invoked safely, and internal sysfs state is
> correctly cleaned up. This guarantees that the memory associated with
> the kobject is fully released and avoids resource leaks, thereby
> improving system stability.
> 
> Additionally, sysfs_remove_file() is no longer called from the release
> function to avoid accessing invalid sysfs state after kobject_del().
> All attribute removals are now done before kobject_del(), preventing
> WARN_ON() in kernfs and ensuring safe and consistent cleanup of sysfs
> entries.
> 
> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  mm/mempolicy.c | 111 +++++++++++++++++++++++++++----------------------
>  1 file changed, 61 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b28a1e6ae096..dcf03c389b51 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3463,8 +3463,8 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  static struct iw_node_attr **node_attrs;
>  
> -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> -				  struct kobject *parent)
> +static void sysfs_wi_node_delete(struct iw_node_attr *node_attr,
> +				 struct kobject *parent)
>  {
>  	if (!node_attr)
>  		return;
> @@ -3473,18 +3473,41 @@ static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
>  	kfree(node_attr);
>  }
>  
> -static void sysfs_wi_release(struct kobject *wi_kobj)
> +static void sysfs_wi_node_delete_all(struct kobject *wi_kobj)
>  {
> -	int i;
> +	int nid;
>  
> -	for (i = 0; i < nr_node_ids; i++)
> -		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> -	kobject_put(wi_kobj);
> +	for (nid = 0; nid < nr_node_ids; nid++)
> +		sysfs_wi_node_delete(node_attrs[nid], wi_kobj);
> +}
> +
> +static void iw_table_free(void)
> +{
> +	u8 *old;
> +
> +	mutex_lock(&iw_table_lock);
> +	old = rcu_dereference_protected(iw_table,
> +					lockdep_is_held(&iw_table_lock));
> +	if (old) {
> +		rcu_assign_pointer(iw_table, NULL);
> +		mutex_unlock(&iw_table_lock);
> +
> +		synchronize_rcu();
> +		kfree(old);
> +	} else
> +		mutex_unlock(&iw_table_lock);

This looks correct. I personally would not have spent the effort to
avoid the synchronize_rcu() because this is an error path that rarely
gets triggered, and kfree(NULL) is already a nop, so no pressing need to be
careful there either:

	mutex_lock(&iw_table_lock);
	old = rcu_dereference_protected(iw_table,
					lockdep_is_held(&iw_table_lock));
	rcu_assign_pointer(iw_table, NULL);
	mutex_unlock(&iw_table_lock);
	synchronize_rcu();
	kfree(old);

> +}
> +
> +static void wi_kobj_release(struct kobject *wi_kobj)
> +{
> +	iw_table_free();

This memory can be freed as soon as node_attrs have been deleted. By
waiting until final wi_kobj release it confuses the lifetime rules.

> +	kfree(node_attrs);

This memory too can be freed as soon as the attributes are deleted.

...the rationale for considering these additional cleanups below:

> +	kfree(wi_kobj);
>  }
>  
>  static const struct kobj_type wi_ktype = {
>  	.sysfs_ops = &kobj_sysfs_ops,
> -	.release = sysfs_wi_release,
> +	.release = wi_kobj_release,
>  };
>  
>  static int add_weight_node(int nid, struct kobject *wi_kobj)
> @@ -3525,41 +3548,42 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  	struct kobject *wi_kobj;
>  	int nid, err;
>  
> +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> +			     GFP_KERNEL);
> +	if (!node_attrs)
> +		return -ENOMEM;
> +
>  	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> -	if (!wi_kobj)
> +	if (!wi_kobj) {
> +		kfree(node_attrs);
>  		return -ENOMEM;
> +	}
>  
>  	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
>  				   "weighted_interleave");

If you fix wi_kobj_release() to stop being responsible to free memory
that should have been handled in the delete path (@node_attrs,
iw_table_free()), then you can also drop the wi_ktype and
wi_kobj_release() callback altogether.

I.e. once releasing @wi_kobj is just "kfree(wi_kobj)", then this
sequence:

	wi_kobj = kzalloc(...)
	kobject_init_and_add(wi_kob, &wi_ktype, ...)

Can simply become:

	wi_kobj = kobject_create_and_add("weighted_interleave", root_kobj);

> -	if (err) {
> -		kfree(wi_kobj);
> -		return err;
> -	}
> +	if (err)
> +		goto err_put_kobj;
>  
>  	for_each_node_state(nid, N_POSSIBLE) {
>  		err = add_weight_node(nid, wi_kobj);
>  		if (err) {
>  			pr_err("failed to add sysfs [node%d]\n", nid);
> -			break;
> +			goto err_cleanup_kobj;
>  		}
>  	}
> -	if (err)
> -		kobject_put(wi_kobj);
> +
>  	return 0;
> +
> +err_cleanup_kobj:
> +	sysfs_wi_node_delete_all(wi_kobj);
> +	kobject_del(wi_kobj);
> +err_put_kobj:
> +	kobject_put(wi_kobj);
> +	return err;
>  }
>  
>  static void mempolicy_kobj_release(struct kobject *kobj)
>  {
> -	u8 *old;
> -
> -	mutex_lock(&iw_table_lock);
> -	old = rcu_dereference_protected(iw_table,
> -					lockdep_is_held(&iw_table_lock));
> -	rcu_assign_pointer(iw_table, NULL);
> -	mutex_unlock(&iw_table_lock);
> -	synchronize_rcu();
> -	kfree(old);
> -	kfree(node_attrs);
>  	kfree(kobj);
>  }
>  
> @@ -3573,37 +3597,24 @@ static int __init mempolicy_sysfs_init(void)
>  	static struct kobject *mempolicy_kobj;
>  
>  	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> -	if (!mempolicy_kobj) {
> -		err = -ENOMEM;
> -		goto err_out;
> -	}
> -
> -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> -			     GFP_KERNEL);
> -	if (!node_attrs) {
> -		err = -ENOMEM;
> -		goto mempol_out;
> -	}
> +	if (!mempolicy_kobj)
> +		return -ENOMEM;
>  
>  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
>  				   "mempolicy");

Similar comment as above, now that mempolicy_kobj_release() is simply
kfree(@kobj), you can use kobject_create_and_add() and make this all
that much simpler.

So the patch looks technically correct as is, but if you make those
final cleanups I will add my review tag.
