Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D922578A;
	Thu,  9 Oct 2025 03:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979783; cv=fail; b=NTp9rMm+ea4KQNY5jbWdJzPnm2hR7z36mu2iPqVACBX9A/VmCzsQScLmVIXAyKt8upiJkCrLB2p/ovZw23ITISmCkB/Ze9UsnU+LcxI021Cw0pcrYYa2/YNH7+IE8t4dQeNUE0kk88tcR1BqLMa+IkkVeSXSq3GrfT8xfH7Gj50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979783; c=relaxed/simple;
	bh=mKAqWrKw4AYuA7J7JKvpBKrZNU+tl2WjUyRobZd5usU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rev6uEMEv0oq0EBs1zLmTaBYa5TKkdpT/dY4vZyRRyeH7kvh1URj5LcWWdOvZq8Otii0ZZmBYmWgUKinAoK8AWCrqlF0wT1pTAzZkEMHBkNVp3+x3VEEBTaF1OIrarBhV/PYStdRywNdzvRvqRqA2660YJKeHHl5nKpXdorp/Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFGDFdYT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFGDFdYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759979781; x=1791515781;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mKAqWrKw4AYuA7J7JKvpBKrZNU+tl2WjUyRobZd5usU=;
  b=BFGDFdYTYOdEcMqsSuM5NwkVqBYLKwfksX9/gjCqE5uXz6d/H61kTT7Z
   3wWCD7F7g9a+tzih10R9lVWKuQP/RYE8dW8aPg84CKIT2gEU8GXtDUZeg
   T+Za+L0oCDx1T3XDSQd6+O0Xfl9BS6nwQtXIt4FxoZek67KzKLzHNaCMb
   wbWtfC+hs9wVOCyswvQgxw/PhUCakk/JhwX/wAzYGZqVIYpv+2yHjHXim
   wIcmqkAXL97nVXl0tcIVe6Speo7Y4D7+s9Aj3YGbVrAz7F36Z1mEn0/FC
   PK/hL518255WQXViBcpG/gmUxhtXNdsYOY5eFoodwJtPFJ9szjiLpkClx
   w==;
X-CSE-ConnectionGUID: 1Q8gpKTqTC6e3IG7rN9n9g==
X-CSE-MsgGUID: JNu3LtuoSKauf8a9J8ps7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="61887697"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="61887697"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:16:20 -0700
X-CSE-ConnectionGUID: IEIC6tyORt6DxApjLKbzdQ==
X-CSE-MsgGUID: CdOh3LLQRnSIyZ1rJ76oVw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:16:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 20:16:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 20:16:19 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 20:16:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TptrwX5R8ypH90G/z2AnN2d3F2Mc9h0dfbmGbq39+h7gFWkCktsVvuQAKLUE34DCYjN2iGWwSVgWhOO12VYLzMfS2Vt3tgaEBBcKhLq6MDAUtYXMuI9XNFgnbmCP3qgFKLDxzX6rJy2AU9Lf3q+8uak12ivNlC8mCMYok7AohqlVHO0zl+pcbpcaoeDtHi3xpNl/B5VvsMjpUsY8gaeD2CqD6dKTvsTtTIAYrgAldEz759XNd0YVEVrG/z3fP2Z1f6Kxnvy3vSH0hxU7On2RGjv4GqlXUDZjXejvUvXU6FKhGK7udHb3fs0ShRtiZjnzDJJFgRgcwPHqKtXCLPOv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UTrGbPcAFOzz5MAeJ8ihfA21D6pY0lRvHmkmrmYSXs=;
 b=xi8K8xNdfx9QwX0FRrqcnQAYVvl1HlOYLQhqi3wqb/tBiJXbNkKiNyGE/DF7bbTB9yyuoaH0GrwGP1rvuBQ9c2zZ1oPQNP/jjYn25aKm5rCcbl9/MraRjmCrq5k8HVbE9v920iTBbg8Ir23g5xidlg5fYzHY+lVkgqpsnOmIZn8rRqMx4won4ZdvVVGXyf99F7Go3JL1ESiEWwJftnbtSf3u/FZm35GK6j+0hJyWC8+Q/YwmB0HJhU0NIhxGaXpOXiHP6+b4htgtzWJytT3+89EI0/sblEazxneR2MNcXeGAWbFJ14JmZ5lWiNyt93vcYIEqKxHwBfzkyiNubR2euw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH0PR11MB8236.namprd11.prod.outlook.com (2603:10b6:610:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 03:16:13 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9182.015; Thu, 9 Oct 2025
 03:16:13 +0000
Date: Wed, 8 Oct 2025 20:16:05 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Dan Williams" <dan.j.williams@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, Robert
 Richter <rrichter@amd.com>, Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes
 on x86
Message-ID: <aOco9dzjzcWJBNYh@aschofie-mobl2.lan>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: BYAPR07CA0051.namprd07.prod.outlook.com
 (2603:10b6:a03:60::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH0PR11MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcbc749-9277-4eca-9bb3-08de06e2334e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uCCdC6eRXPGH2I+Ai1PKsFR0PRgrBePO6yf13GLQZu4N9AaRbFtwAKO906i+?=
 =?us-ascii?Q?gK2TMktwISmFUgXNrTalBC6DRSumqoH+bI63/KwoxZKM2vnHEqywRR9m2DEi?=
 =?us-ascii?Q?Zw/huGOBWn5Sc7b1FiHzTBmd+vbQ5oVVHw6ylRGINIIXy/HRRck382Ltbv3Y?=
 =?us-ascii?Q?NAki1Iy+iFe0Mfoj9lQMqlr+0eOjeh+CWpAEtX6rO0k6TnNJC1rKKLTZHk/f?=
 =?us-ascii?Q?mTxNH4bcaJi64Kl/oZUM0ob4Uts5n3lXGh+njqo1or7zBOhbSXUqouYT4KFq?=
 =?us-ascii?Q?dCPYj97MWGeWgni7x5Lz3PxGmmXis0PwInuwA/272JX8FsEP9Kfugr01LHGV?=
 =?us-ascii?Q?Yd0SGTw8CTOc3+acYha5ivLF/IoDgsK+V/FGniQ0sQcdARy9uOU06vSsm8jL?=
 =?us-ascii?Q?80p9iGm72/TjDK6fkrB4EiybufzA2jnbP7+gbCtvMUoYoMB8FgwZLQ/FRj+W?=
 =?us-ascii?Q?+CNEGlaf2/gQcN68mdqvHKnYTxZZEAf1V9RdYb+hzxq+z7NUWdA9FOFsf1xM?=
 =?us-ascii?Q?sEZ7GJTbjik6Lzryl/qmKInsZM6//FxCaV2tMramuXpMgkDyf/f2Y5e7Yev6?=
 =?us-ascii?Q?ugJFoWfZ3kP3WJkrPESUOr7YXh7wYqWhsloD3JSVGSxN77XQrRIyyqY9FY+L?=
 =?us-ascii?Q?qbBgKxjOQT1S5iSO6E9FGK4zPkE5qNjSYisUE3zb2EhrMkGRsGqn0HtwvjaA?=
 =?us-ascii?Q?bW/pQs3+vD8LKFhmaSicm8yShN8PZcS8lOY0qsev8tYGPImNQ4xrgv9fw96q?=
 =?us-ascii?Q?RmNzH5HWW/eh+9TPyGhrtl9AmdvimwlFf9yaO53kzwVCLJJdq8y/fiqX7CZ2?=
 =?us-ascii?Q?DsQQiRrGNSjw2IxEAI+9TgXkQrOwYLOkjIUvXnNg7DTmNqj+xB7nTGp8HdL2?=
 =?us-ascii?Q?s5tkrTkKceBvzpGlFiDeQKVOS/Ehgr3yHD9mzeikN9efxVsoc6php1z64VWv?=
 =?us-ascii?Q?JXEgpokxWuJFZSxchskYFJVpNu0IR0gbmghn+uE6FdjVPyIq0p1WXrzQIJbJ?=
 =?us-ascii?Q?0zOEEEdihgolRXIKjpevQlorDveq4y3xe/5HffneoIA0AraDJY7C97J7ybwr?=
 =?us-ascii?Q?LtepJRxZX1R9PlHfc7kURiL7wglTyqJ44YTV5d+RBwh1S2glcfn0PeB7Sfqx?=
 =?us-ascii?Q?AQN1QBX0Et6IL4R5CqhKCQGRVfvhfaNtL9wPZvkqnIEdLeprqjE2n/vGR23m?=
 =?us-ascii?Q?muR9LLOBnCgili4N7zOch5WjD2hG0TYYObEU3t/1pU8smaddySz7Je3lD06q?=
 =?us-ascii?Q?U+1UcswBAns03nFQ4kUCcH9DEm+zGrFBvlRWdYdCJI/ZcvIDMJgq1EZGWh53?=
 =?us-ascii?Q?3+ZDakJPBFZzoEobtxIJVjEieBUNe+0lVcdvPAWj9+lOTijOu2v9tMat7cMp?=
 =?us-ascii?Q?2TlCxemeNunrhhqGOQDaVPMHZdh9D8fVjaQGjtdpAbb1PqvyJu7Rli3Vz/lu?=
 =?us-ascii?Q?3KOAFF03D7K5IO901Rizz4LRXAc0agQo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KRI/WswJ70xBM8nSxueU2afIoTtONY9NxFdd/qRC5JqaM6D7PQos531USxFu?=
 =?us-ascii?Q?kGWCXgdxK7k8I53wbwrOeIGwJ0IAPebfMEEjDJfsnfhNaf2dK17H+2GEU32g?=
 =?us-ascii?Q?UgXFzNF1sAkkW7rA9xZQP2ZX/AGMdTHPeKJDIX0OuPEo0jDGMlwTDYbXyvAu?=
 =?us-ascii?Q?h8T/vsEZt+1Bxs0FzpwzM4PIW84nYNOxCvrD5wWi7b7vQ50AuEMLlrSP5Rvf?=
 =?us-ascii?Q?uFZDg0qUXj51WQ6AhA2nAPHaF9p+Wx9x9f5xCCUJ4EigyTmnzc1m93KgEdMx?=
 =?us-ascii?Q?P9Ei0q5UWlgrYD6vrTI8azpaZd8jWYgzZ9PL72+Pb2Yn5SwTDPJRpAYoVzqt?=
 =?us-ascii?Q?SoGh7dgTtxpjPxtIDhmi7ua6Msa5JvjsH54/eDIBDZr9hxTPM7iqbmDwlurI?=
 =?us-ascii?Q?5pGCXvCumMUQOkPqvv8EramwhIKx9bY5d5bBOcyyIKG6Ne52DtBkwLxrWMIE?=
 =?us-ascii?Q?7MWq67aBI0PJQQHzxNpSrGywEWI+zYdDGFIZoQCvh7WXwQFifPeQ2Bt94pq5?=
 =?us-ascii?Q?P/XuOh1kEs3VXegTPx0TQw3N6VtiRxtMfCTxjXGrcP/nVJoorzOvX9WMeWYC?=
 =?us-ascii?Q?/wfjXobvcO2hmG6tKiJYCGWx3rWoaSe9yoEOJ6Kr5Kq2N/nvoylU0r+SBifG?=
 =?us-ascii?Q?W2Gfifn7lojyty+UJ+VtzTx7MCu4/uJfmKBDs4uU0VkVAc1VkhYH9UoDUVt2?=
 =?us-ascii?Q?gjoqeLkIHjAq0V3mIeH5yCDmTCjk7Zmh95C/MJ2rw859g/7yr5sVQWbeOwwX?=
 =?us-ascii?Q?arJMqdd0mX4tPtp8i/nk0h7mS32MjA7q7IxDwsUJpMlJT5MhSjtzMDP/pCS6?=
 =?us-ascii?Q?v2gmzKRH/z/1APuBUARRFRCRsW5fhyAwI5ONw6UIJvcUTFH32RieY7wWorPd?=
 =?us-ascii?Q?MaRruCcEwg+TXyNmsWKmqBJiOWC4KsYdOcco/t+n3zZd5onnbqtJfnYJRmXQ?=
 =?us-ascii?Q?imLD72tuPanEU0jcG2/Nd10m5WolL2ZuJ5ThaghAVjjQDyi/Myh4AQ1KbEsk?=
 =?us-ascii?Q?Vcb05ea9ZS4Xe9bUpcVhp0uwwD7T0Zieyg5loAAauAGOhoxWs/gX/Nc3WiZY?=
 =?us-ascii?Q?cRoyPLOlTSWyrn0ANeMgH8Agxp6aTgoQ8BikppR7XqZWdb5k6r9aclW48wn4?=
 =?us-ascii?Q?KORCo9TGVhlfbKwQix9okgXrG9kbq4JeCLahmg61nELf/uKSzKuBSq0wT7xv?=
 =?us-ascii?Q?euJTjvqFpNlrPY+XtKUXQTfr12mylv090ziAbXYHp7LQ/qjWw5xQElgXjjH2?=
 =?us-ascii?Q?wLpGMXNctptRZtGp/ZiP+Hi49g/JYOXY7txH7AyrhsVnv7d59LP2/dE3bzJ1?=
 =?us-ascii?Q?9GZnenSe1nfFeEzeLj2lK+UfmYg4wE5+xS/FWsHkOyUmFh+z98E+j5j6BZMS?=
 =?us-ascii?Q?MZP4DpWEZZd05E/ugWEbWB1EkVUZYcOJ1CGivtpGqG57L7twyj7cqZG/QjV+?=
 =?us-ascii?Q?ZWnBEoF1GznZmZvFuFqjWSpw4ZWGILBbYgYXg772yqFPSTmTi9YpbqXw+GJV?=
 =?us-ascii?Q?pv6JRmhrIf4RuwHYhsE3ct/bjBTHWjKhW4YOfcCPJ6gVpNczwGKU2fje2MGf?=
 =?us-ascii?Q?JV27kX+55gHaJxC3/sm+GKlqbPgtc+RAm+rHxbA0KYK6IVXqzNg7GqEJMh4v?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcbc749-9277-4eca-9bb3-08de06e2334e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:16:13.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMlhxHKk5xWUHnvMRDfnci9DxrPpoDFHqX4gn6PfWxDX8KfdHwsPFp8nS1Bopjdkyz11Pcffv8EO9GEeTzl651Im6Kkx1auN22cipC6qSw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8236
X-OriginatorOrg: intel.com

On Mon, Oct 06, 2025 at 05:58:05PM +0200, Fabio M. De Francesco wrote:
> On a x86 platform with a low memory hole (LHM), the BIOS may publish
> CFMWS that describes a system physical address (SPA) range that
> typically is only a subset of the corresponding CXL intermediate switch
> and endpoint decoder's host physical address (HPA) ranges. The CFMWS
> range never intersects the LHM and so the driver instantiates a root
> decoder whose HPA range size doesn't fully contain the matching switch
> and endpoint decoders' HPA ranges.[1]
> 
> To construct regions and attach decoders, the driver needs to match root
> decoders and regions with endpoint decoders. The process fails and
> returns errors because the driver is not designed to deal with SPA
> ranges which are smaller than the corresponding hardware decoders HPA
> ranges.
> 
> Introduce two functions that indirectly detect the presence of x86 LMH
> and allow the matching between a root decoder or an already constructed
> region with a corresponding intermediate switch or endpoint decoder to
> enable the construction of a region and the subsequent attachment of the
> same decoders to that region.
> 
> These functions return true when SPA/HPA misalignments due to LMH's are
> detected under specific conditions:
> 
> - Both the SPA and HPA ranges must start at LMH_CFMWS_RANGE_START (i.e.,
>   0x0 on x86 with LMH's).
> - The SPA range's size is less than HPA's.
> - The SPA range's size is less than 4G.
> - The HPA range's size is aligned to the NIW * 256M rule.
> 
> Also introduce a function that adjusts the range end of a region to be
> constructed and the DPA range's end of the endpoint decoders that will
> be later attached to that region.

Hi Fabio,

Your getting some fresh eyes on some of this with my review.
The adjustment of resources is what caught my eye, and I looked at
platform_res_adjust() in this patch and it's usage in the next patch.


> 
> [1] commit 7a81173f3 ("cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution")
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/Kconfig                |  4 ++
>  drivers/cxl/core/Makefile          |  1 +
>  drivers/cxl/core/platform_quirks.c | 99 ++++++++++++++++++++++++++++++
>  drivers/cxl/core/platform_quirks.h | 33 ++++++++++
>  4 files changed, 137 insertions(+)
>  create mode 100644 drivers/cxl/core/platform_quirks.c
>  create mode 100644 drivers/cxl/core/platform_quirks.h
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..03c0583bc9a3 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -211,6 +211,10 @@ config CXL_REGION
>  
>  	  If unsure say 'y'
>  
> +config CXL_PLATFORM_QUIRKS
> +	def_bool y
> +	depends on CXL_REGION
> +

Why no help text for the new CONFIG option?
That text will probably answer my next question: why do we have the
option?

snip


I have comments for the callsites of platform_res_adjust() in the next
patch, but I'll pull some of that back into this patch to keep it all
in one, more logical, place.

There are 2 callsites, and one passes in NULL for 'res' because
at that site we know that the regions struct res has been adjusted.
I felt that was subtle, and that it may be better to just pass in
the 'res' all the time and let the function adjust if needed,
ignore if not needed.

The name platform_res_adjust() suggested that the 'res' as in the
region 'res' was getting adjusted. This is adjusting multiple resources
- the region resource and the endpoint decoder dpa resource. If it's
meant to be kind of opaque, that's ok, but by using _res_ it sure sounds
like it's adjusting the the region resource (when viewed from the call site).

I might have done this in 2 helpers for crispness:
res = platform_adjust_region_resource()
cxled = platform_adjust_endpoint_decoder()

Then you could adjust the region resource once when the region
is constructed, and the endpoint regions every time in 
cxl_add_to_region().

If you are settled with one adjust routine, perhaps just a 
rename to platform_adjust_resources() will make it sound as
broad as it is.


> +void platform_res_adjust(struct resource *res,
> +			 struct cxl_endpoint_decoder *cxled,
> +			 const struct cxl_root_decoder *cxlrd)
> +{
> +	if (!platform_cxlrd_matches_cxled(cxlrd, cxled))
> +		return;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	dev_dbg(cxled_to_memdev(cxled)->dev.parent,
> +		"Low Memory Hole detected. Resources were (%s: %pr, %pr)\n",
> +		dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
> +	if (res) {
> +		/* Trim region resource overlap with LMH */
> +		res->end = cxlrd->res->end;
> +	}

Prefer dev_info so always appears.
Prefer to see the region name.
I'm guessing the dev_dbg() above and the dev_info() below are written
with the idea that we want the before view only in dev_dbg() and the
after view only in dev_info().

Looks like this now:
[] cxl_core:platform_res_adjust:90: cxl_mock_mem cxl_mem.0: Low Memory Hole detected. Resources were (decoder12.0: [mem 0x3ff010000000-0x3ff04fffffff flags 0x200], [mem 0x00000000-0x1fffffff flags 0x80000200])
[] cxl_mock_mem cxl_mem.0: Resources have been adjusted for LMH (decoder12.0: [mem 0x3ff010000000-0x3ff03fffffff flags 0x200], [mem 0x00000000-0x17ffffff flags 0x80000200])
[] cxl_core:platform_res_adjust:90: cxl_mock_mem cxl_mem.4: Low Memory Hole detected. Resources were (decoder13.0: (null), [mem 0x00000000-0x1fffffff flags 0x80000200])
[] cxl_mock_mem cxl_mem.4: Resources have been adjusted for LMH (decoder13.0: (null), [mem 0x00000000-0x17ffffff flags 0x80000200])

I'll suggest this to emit explicitly what is changing:
[] cxl region0: LMH Low memory hole trims region resource [mem 0x3ff010000000-0x3ff04fffffff flags 0x200] to [mem 0x3ff010000000-0x3ff03fffffff flags 0x200])
[] cxl decoder13.0: LMH Low memory hole trims DPA resource [mem 0x00000000-0x1fffffff flags 0x80000200] to [mem 0x00000000-0x17ffffff flags 0x80000200])
[] cxl decoder17.0: LMH Low memory hole trims DPA resource [mem 0x00000000-0x1fffffff flags 0x80000200] to [mem 0x00000000-0x17ffffff flags 0x80000200])


> +	/* Match endpoint decoder's DPA resource to root decoder's */
A 'Match' would be if the the endpoint and root decoder resource were
same. This is more of adjustment or recalculation of the DPA length.

> +	cxled->dpa_res->end =
> +		cxled->dpa_res->start +
> +		resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;

I'm cautious about the use of division and suggest this as the more
bullet-proof kernel style:

	slice = div_u64(resource_size(cxlrd->res), cxled->cxld.interleave_ways);
	cxled->dpa_res->end = cxled->dpa_res->start + slice - 1;



> +	dev_info(cxled_to_memdev(cxled)->dev.parent,
> +		 "Resources have been adjusted for LMH (%s: %pr, %pr)\n",
> +		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
> +}

Here's the diff showing how I emmited the that messaging above. I really
wanted to have that region name to emit. This was done keeping the
adjust in one function, but maybe you'll choose to split :)


---
 drivers/cxl/core/platform_quirks.c | 32 ++++++++++++++++++------------
 drivers/cxl/core/platform_quirks.h |  6 ++++--
 drivers/cxl/core/region.c          | 15 ++++++++------
 3 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/platform_quirks.c b/drivers/cxl/core/platform_quirks.c
index aecd376f2766..aa25770c088a 100644
--- a/drivers/cxl/core/platform_quirks.c
+++ b/drivers/cxl/core/platform_quirks.c
@@ -81,24 +81,30 @@ EXPORT_SYMBOL_NS_GPL(__platform_region_matches_cxld, "CXL");
 
 void platform_res_adjust(struct resource *res,
 			 struct cxl_endpoint_decoder *cxled,
-			 const struct cxl_root_decoder *cxlrd)
+			 const struct cxl_root_decoder *cxlrd,
+			 const struct device *region_dev)
 {
+	struct resource dpa_res_orig = *cxled->dpa_res;
+	u64 slice;
+
 	if (!platform_cxlrd_matches_cxled(cxlrd, cxled))
 		return;
 
 	guard(rwsem_write)(&cxl_rwsem.dpa);
-	dev_dbg(cxled_to_memdev(cxled)->dev.parent,
-		"Low Memory Hole detected. Resources were (%s: %pr, %pr)\n",
-		dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
-	if (res) {
-		/* Trim region resource overlap with LMH */
+
+	/* Region resource will need a trim at first endpoint attach only */
+	if ((res) && (res->end != cxlrd->res->end)) {
+		dev_info(region_dev,
+			 "LMH Low memory hole trims region resource %pr to %pr)\n",
+			 res, cxlrd->res);
 		res->end = cxlrd->res->end;
 	}
-	/* Match endpoint decoder's DPA resource to root decoder's */
-	cxled->dpa_res->end =
-		cxled->dpa_res->start +
-		resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;
-	dev_info(cxled_to_memdev(cxled)->dev.parent,
-		 "Resources have been adjusted for LMH (%s: %pr, %pr)\n",
-		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
+
+	/* Adjust the endpoint decoder DPA resource end */
+	slice = div_u64(resource_size(cxlrd->res), cxled->cxld.interleave_ways);
+	cxled->dpa_res->end = cxled->dpa_res->start + slice - 1;
+
+	dev_info(&cxled->cxld.dev,
+		 "LMH Low memory hole trims DPA resource %pr to %pr)\n",
+		 &dpa_res_orig, cxled->dpa_res);
 }
diff --git a/drivers/cxl/core/platform_quirks.h b/drivers/cxl/core/platform_quirks.h
index bdea00365dad..55647711cdb4 100644
--- a/drivers/cxl/core/platform_quirks.h
+++ b/drivers/cxl/core/platform_quirks.h
@@ -17,7 +17,8 @@ bool __platform_region_matches_cxld(const struct cxl_region_params *p,
 				    const struct cxl_decoder *cxld);
 void platform_res_adjust(struct resource *res,
 			 struct cxl_endpoint_decoder *cxled,
-			 const struct cxl_root_decoder *cxlrd);
+			 const struct cxl_root_decoder *cxlrd,
+			 const struct device *region_dev);
 #else
 static inline bool
 platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
@@ -35,7 +36,8 @@ platform_region_matches_cxld(const struct cxl_region_params *p,
 
 inline void platform_res_adjust(struct resource *res,
 				struct cxl_endpoint_decoder *cxled,
-				const struct cxl_root_decoder *cxlrd)
+				const struct cxl_root_decoder *cxlrd,
+				const struct device *region_dev);
 {
 }
 #endif /* CONFIG_CXL_PLATFORM_QUIRKS */
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9a499bfca23d..d4298a61b912 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3502,7 +3502,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
 	 * platform
 	 */
-	platform_res_adjust(res, cxled, cxlrd);
+	platform_res_adjust(res, cxled, cxlrd, &cxlr->dev);
 
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
 	if (rc && rc != -EOPNOTSUPP) {
@@ -3611,14 +3611,17 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
 		cxl_find_region_by_range(cxlrd, cxled);
-	if (!cxlr)
+	if (!cxlr) {
 		cxlr = construct_region(cxlrd, cxled);
-	else
+	} else {
 		/*
-		 * Adjust the Endpoint Decoder's dpa_res to fit the Region which
-		 * it has to be attached to
+		 * Platform adjustments are done in construct_region()
+		 * for first target, and here for additional targets.
 		 */
-		platform_res_adjust(NULL, cxled, cxlrd);
+		p = &cxlr->params;
+		platform_res_adjust(p->res, cxled, cxlrd, &cxlr->dev);
+	}
+
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
-- 
2.37.3

> 
