Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7C16F858;
	Wed,  9 Apr 2025 03:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170244; cv=fail; b=o/Vkcykl71xTl3puMcwM7UeZcE+g3oRZzvdnMC1iQGiEjK7hgXwJp+qb/QGd08jd7AP83m7PzqqZI2tQuMhnsgtB81HFe3io3EHQqDcYVZCTd+ustD07/8y3WEru0h2arahNPTsxkk/rlHtD5aux9Rim7TftgPZ+tuSXgt7vhi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170244; c=relaxed/simple;
	bh=6jJs8HSbSJARf/hFIlj0BB0Kpld21LD1+wSuOAzYLP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DXriZnBhrNdrGXEMdzOLYvqNq9nK9m3jmQVMw1aFZ5ZB2B470UkRscRQei+ZmB/F1PKc6UYWQE9b5lXQXFu9JN0Hza9sr51fgHNRbkF1noO/X5OCJz4uUvANIfg88fRyybSgqeTZgCba1RuOxRMCHJb3dQ0i4Oa/ZtVqDAyCSeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFsBxKXO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFsBxKXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744170243; x=1775706243;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6jJs8HSbSJARf/hFIlj0BB0Kpld21LD1+wSuOAzYLP8=;
  b=CFsBxKXOO5fJ1eBMFuVzNz8don5sy8/7XOeopbmgNgKDzmfAExAHLtr6
   9Ecafjyi3ruTe4wHNXuZnZck4XveDMZa/HgUGCdggQ8+zU73hBJeA6DuQ
   UGn1DQJpzk1G59Si+B3dnEKCeDSBLf0WSk1km8tku7JL47eDQUt2/jM/g
   wllCVYas+PqPNeMN1o/+mt5uTEnA4uj5WFzLu/j+eG+CpW14jp1kEdQ8h
   k09JQu7/jtd3BQAEhwmu3Befdwi8fjnJRDeIm1loIyJHcW0Kyzn6hEsnU
   fO4o4ppnRrZm6mJWcadwofLuRHx1sUvafihD9XMeQJA5btfdvo7lPPAnC
   w==;
X-CSE-ConnectionGUID: LfHJGHwsQ8mSF2E0K/Z3mA==
X-CSE-MsgGUID: 5hLB+2+pQqmuPT5UZ2vJ9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56998389"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="56998389"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 20:44:02 -0700
X-CSE-ConnectionGUID: FYUA+ea6TEePni6oxJ82RQ==
X-CSE-MsgGUID: WpllMmjpSsCPukydiuubGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="165688501"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 20:44:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 20:44:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 20:44:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 20:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW8HMYIUmYxi/FyLY+AKfH7DL2lfNzw7lxwJSCa2eFbGjI3YJqpUPqTu2TTzvYhPvAobGjh80fZIPoL06DmXvy4pN+T2uKFBcee3v5Q9Pa054Ctt/AqnZN7g4Hf/dCfFxGFIcjcCcUIuaBMo95MYJFGfuVv587b8pHKs2h1s5mg5Qj3ZLElQ4hqnLZNuiP/bEzWaKm1mLiYEHBL/Rp08q7RXd23porEQM1T6L2f42xj+VvPEvcTr7s6hWCOOBPaPvawzyLw5ZseF5Y+0YYWEyb8vPbnSbmQLr4uJwE4+OLopmj5NyVgIBIOcom3/QWCvVhnjqmJhFQvmi0Mx/PHM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSr9Tm0x6qFhYk9xey3U/xLR415AwTcKZdnBEC1SFvY=;
 b=qgHz3//Ehn7EPs7UQYKemJBsKZhKGH7OjCdIEfXXZ8noWv4EoaBFjjtj+8LpNgDwgRu1+m40CputUuttODnaD6iKLwB+CiBGBYpatd7WvKMs70SKjRI+R0WoaI56GpSV5qEipBS3sKJoXSYfbspbMWRrg6CJ6KkCwcY/fV18VzB0LsSc/Hv51aHERi+sRf9Mscr8DUj+QmcyOxutljXvvY97BXl+6KRoA8qo2F6pPD+9fVKThOE9Voij7lV6CYjzkY3f/heanwuFiDC7m3a3DQuHUl/ZfFx4XiVFKMPnf1Wyq+AOYfbIyzbrOZTN7n0ZgAzZJP4+Uz7ktmILVyB93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8277.namprd11.prod.outlook.com (2603:10b6:806:25a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 03:43:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 03:43:15 +0000
Date: Tue, 8 Apr 2025 20:43:11 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Rakie Kim <rakie.kim@sk.com>, <akpm@linux-foundation.org>
CC: <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<dan.j.williams@intel.com>, <ying.huang@linux.alibaba.com>,
	<david@redhat.com>, <Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>,
	<rakie.kim@sk.com>
Subject: Re: [PATCH v7 2/3] mm/mempolicy: Prepare weighted interleave sysfs
 for memory hotplug
Message-ID: <67f5eccfd6ce0_720529435@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250408073243.488-1-rakie.kim@sk.com>
 <20250408073243.488-3-rakie.kim@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250408073243.488-3-rakie.kim@sk.com>
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: cabca29b-27b0-40ae-bdea-08dd7718a914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0BVukFMVH7a9tVjTPo2GckWrM0fkSfbTYcRw9UPwkBGu5R8U+QOoGRFpsd1U?=
 =?us-ascii?Q?M8CEa5JC6m0tE7XlaZI9g7JPPd18lTncKED1RwgsPhYXbM9BRV0ZEou9bIeN?=
 =?us-ascii?Q?cQZ7HENhOl90O9tICO/cAmSS4Mi2ShypzWp00vhN788vNWLrQsIVNZOLUS0D?=
 =?us-ascii?Q?oQg0ZEc5f3yrHg8HdWjojM+KU4OY1sdE6guRKJq/Hpyx/udjZu7VnfGScVop?=
 =?us-ascii?Q?eTAMxKwlBVtq4pDLFabn43Vjl+7lpug63ndtNP8//46e2vsKGbjYmn23YCZH?=
 =?us-ascii?Q?8LkbGxab6FlRqHq45jdBkW0kniTt/JF7cGLl7n395UAX6gvHyZoom6DnlK2T?=
 =?us-ascii?Q?ihH58gZZmQLOMFUpO4dUc854li5gkJJikXInb7aGCG7zoDKH3lNtV98TcHGR?=
 =?us-ascii?Q?j3L//Wghrg9Lr4q/OM51M0EkAIMviB3MUTYRGfTweWgwB3TJwe5JAXNWk9er?=
 =?us-ascii?Q?dtx76YwhfWxdPXT2i0e6OzCv6UNuaWx0UwOtm5k/Li1B/RbUYco7RzmlDyvs?=
 =?us-ascii?Q?OHUdY3Pgj1MEc8aIcozGU3i8kXV7RLtSjdv5eNf5Pwk9UIauSTprS2WomzzI?=
 =?us-ascii?Q?toqWFLVZOQvmkSxNtlBwFmJUkCxvDy3FkkZ1u1db3CjmOrssD47x/Qgl36s2?=
 =?us-ascii?Q?hNIdytviyke0uu+gOan4830gjItsglr3k+1CGE2s7WzOxDCnWnexNXZSDMl+?=
 =?us-ascii?Q?IX8Fb2Zt/HNK6Zt68SBRjsibwrtXWQhSkHaj6qa1Y78+lmcqxoABVkh3hzyh?=
 =?us-ascii?Q?VHmUuXZ7OxsEULg+u3vivbttar8f4klq3EMF5wbe/jrcITXbti32b9NF29/K?=
 =?us-ascii?Q?lytLYpJrJO4WoEtqYlkOs2heY0aGK2Snf0BIOwb4+lH2GjR2u8r8bwUtzTe+?=
 =?us-ascii?Q?LfstDdoXe5uXQdLXk90yhWrFxx3g8V9TFvhUv/jvTE9YuTTaXkkGKePaSfKv?=
 =?us-ascii?Q?LPmzZriaol0Qc9/Ljq+IM0y9Mh7Fr+0uWoa7W5vvneAhjWXsLDwPP811vfEZ?=
 =?us-ascii?Q?sTTBxCNkIFmuhKo/N/blwNKk72xDoM9Fpip92BS77Mzm1UeL2ZLEPPvMYH3Z?=
 =?us-ascii?Q?2w05JVShXDZwEO2QMhyfP/U07mq9kOdwD8h/ikY75iiWIrB8k8UAh2gnowHA?=
 =?us-ascii?Q?pLV5KGrTQI+j9B680SygOV+0zrLbdQq2PhNu5GL++fOL0ZEVyn8Lzk5wKtgl?=
 =?us-ascii?Q?pd3KcZHxFpjd/jft9shl47kz+h4qIWmUoL5ddJkZGDElqdO+TtK5Dbs3vbV3?=
 =?us-ascii?Q?bdvv1oFroreWM53fUML2VVBnwZlQjNxyyweHwdAfOcCTF9oZjD42LI6HLTSS?=
 =?us-ascii?Q?zJvlsblm4Fs7Ww6ui9vHhmv5z7jIwifxKITAsTzKVsY4DMWIfnJMqalErud0?=
 =?us-ascii?Q?QhanEJPalqltO6W0azcWCfyWSyP7CCCK62ZU04PIlDsq+42FPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X0ncBI6UqxIkFtVBiVxuA2T/jwGy6wk24WYGqz93/OJQ3tL/VedzK4k8l2Wj?=
 =?us-ascii?Q?BH2a0i/n7EySLMQa/fM/gB7E6+AWgvZMCJ3xAUz16zGbCLFMjQNTf+reBlFa?=
 =?us-ascii?Q?9PyLbTetg5cra7Rrne8+xvUe7D2n1xP4d/pc0jyjbjEmh9AgfZIGKfvgPg6R?=
 =?us-ascii?Q?mc10/ce9dvOVH5M3hh9oZqykRXITJ35yNgOSfiuflJQygNBEVvH/vnp9YkTY?=
 =?us-ascii?Q?qDGVeAAQ7eIsps0fAji5SVlQNinIjo+HinWFkvmpb3Ob7k+PDoahZy579J55?=
 =?us-ascii?Q?jb/1ajHavWCazamyd9U/NnxMZykFVgLKf/Tn/3TmFp0Q0kOQv1VN3n7U4cgZ?=
 =?us-ascii?Q?EkK1FMk44Eg+OnV83BwdVuYBq9CC2rC2trx+zQGg+91sUOGHOTA4VWeQ7wua?=
 =?us-ascii?Q?AH4IDUsgs/Jad6nHcaxHFgBGb8Oaly9cjAD0Rj56xzYhxMHKLHBcimd2CMCR?=
 =?us-ascii?Q?A09UOWr0Fa/QsARU9PVUt1TMtQ388xIcE8+kgNETF2b6CgoSlzSuq8c9ih7h?=
 =?us-ascii?Q?K39b8kDS+X4CUZ3ce6sTWYA8F1O+rXhV7/Pem6YThnAyl8e4mEzLXIWC+dh4?=
 =?us-ascii?Q?fCLFWFVLWqrGzhDo/AeauOZ/QXdLDCNVF2SHvH15D0ofjXZE2a3TyWnmPNpJ?=
 =?us-ascii?Q?YEjvn0h9qG8xruJKXr8Ayb/7rSU7YwXN2oIPTjb4GV7wQXGi+10+gLxKzqNK?=
 =?us-ascii?Q?C+e5JvA7FLECIC78Q/ndbrRgI/nbIsvlsWWW3/JNQTbHU3jCAPTkfrJCtS8m?=
 =?us-ascii?Q?lQWFk0LGM0J6KHnxKlM+aNNVT2VJ+8w6gCJyNugzWv88uvMvJECurgP4h/V8?=
 =?us-ascii?Q?8rswVmsontRLC4oND01j6G8YwdegvPV0ssMkNFrkt+9W5q2wHDQSuY4QggXz?=
 =?us-ascii?Q?rChnvIvATnhU5lpwV/rRMiqYzZRobcdZldzSUJBrSDrw/bA7psIKnjKzYe4A?=
 =?us-ascii?Q?Wbyj7RczIT8dJk+GnGYH8ykCmzmYSTIxLDa2BOO3cKu830Sk0UJgAXcTi74h?=
 =?us-ascii?Q?t95awkkLlLIVvZPreaCsPE0rAzK56HiduB/gxeLJcMzO4BtQ4/2djtvCxUhU?=
 =?us-ascii?Q?Ywu85/3Nt1WgAt1bRC+rl1cuzH2XkKqEqMnAjHPF9JA9DwN/aQux9ximZB8O?=
 =?us-ascii?Q?FhZqWLUlchV/FZ4PGqMRBYsvcCkoyGRxLWYnVUIjwER1MYOgeh2G6YG/6CQM?=
 =?us-ascii?Q?nm4Z94wPBFZs3OBbe8x8eKa6UvmeSCs36Fiow9U4MIbGT8xcKBqpL8zD+pBc?=
 =?us-ascii?Q?6LejSeFUfFpQbOH/kV69WWvCmyYDvnzVzz0gH+IsJJFGYTFXykO/XRvuR7r/?=
 =?us-ascii?Q?OdnjaiwashfjGbGYJSub2qgqgj6Arme6xAzJGzOsIIxmd6FWc0F3PKpCFbPX?=
 =?us-ascii?Q?mhzx/Cs69KESrFxq2aMmZ3VTVTQVQJ9aNgZBFbT7OCwdVEbNAzuJC81dM7tn?=
 =?us-ascii?Q?43LkuBHIGcynpswVcPYJ+pl5Gdqa1R6LiLW1rYniJYjz+Mg9FXR3C3VKy8iZ?=
 =?us-ascii?Q?DYG8CU9AStRZ3KMJ2Bwd47XdHXiEcTwePFANN1m+oRjWEafM/zL7Zslc9vqV?=
 =?us-ascii?Q?ZnRRNmOe19Yd8c+NvqfRw9SaagTsGiu5v6ofNkwFU0/mmE/NzwXK1zGZa28I?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cabca29b-27b0-40ae-bdea-08dd7718a914
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 03:43:15.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kN+g2NmM2nrH3IskJiahXPfE3DszV7MjmNV+r/GLNj1CTnFZ8XyelRwmb4HWnaKEO37sdJnH6tqHZOh7fdXbub69cqIrhqOm5F0P1rXlZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8277
X-OriginatorOrg: intel.com

Rakie Kim wrote:
> Previously, the weighted interleave sysfs structure was statically
> managed during initialization. This prevented new nodes from being
> recognized when memory hotplug events occurred, limiting the ability
> to update or extend sysfs entries dynamically at runtime.
> 
> To address this, this patch refactors the sysfs infrastructure and
> encapsulates it within a new structure, `sysfs_wi_group`, which holds
> both the kobject and an array of node attribute pointers.
> 
> By allocating this group structure globally, the per-node sysfs
> attributes can be managed beyond initialization time, enabling
> external modules to insert or remove node entries in response to
> events such as memory hotplug or node online/offline transitions.
> 
> Instead of allocating all per-node sysfs attributes at once, the
> initialization path now uses the existing sysfs_wi_node_add() and
> sysfs_wi_node_delete() helpers. This refactoring makes it possible
> to modularly manage per-node sysfs entries and ensures the
> infrastructure is ready for runtime extension.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 61 ++++++++++++++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0da102aa1cfc..988575f29c53 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3419,6 +3419,13 @@ struct iw_node_attr {
>  	int nid;
>  };
>  
> +struct sysfs_wi_group {
> +	struct kobject wi_kobj;
> +	struct iw_node_attr *nattrs[];
> +};
> +
> +static struct sysfs_wi_group *wi_group;
> +
>  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
> @@ -3461,27 +3468,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	return count;
>  }
>  
> -static struct iw_node_attr **node_attrs;
> -
> -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> -				  struct kobject *parent)
> +static void sysfs_wi_node_delete(int nid)
>  {
> -	if (!node_attr)
> +	if (!wi_group->nattrs[nid])
>  		return;
> -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> -	kfree(node_attr->kobj_attr.attr.name);
> -	kfree(node_attr);
> +
> +	sysfs_remove_file(&wi_group->wi_kobj,
> +			  &wi_group->nattrs[nid]->kobj_attr.attr);

This still looks broken to me, but I think this is more a problem that
was present in the original code.

At this point @wi_group's reference count is zero because
sysfs_wi_release() has been called. However, it can only be zero if it has
properly transitioned through kobject_del() and final kobject_put(). It
follows that kobject_del() arranges for kobj->sd to be NULL. That means
that this *should* be hitting the WARN() in kernfs_remove_by_name_ns()
for the !parent case.

So, either you are not triggering that path, or testing that path, but
sys_remove_file() of the child attributes should be happening *before*
sysfs_wi_release().

Did I miss something?
