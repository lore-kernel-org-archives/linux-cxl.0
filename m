Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0EC747F
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716892; cv=fail; b=n+jo0maau6JESYXqhbz+eM33Vw+F9UTESLCQzhq/Jp03kqHu0KbxI/zmEM6/ZUzIERTZXIHNsC1k5DG7TsKIt/WD91jUo7WG1uPiDiCh5/oP1m2E4rRj7WrLPsskIeQ6zM+zKcSI+np8brm/xYXdfsClJ64b5RUC+O6ASRuUUK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716892; c=relaxed/simple;
	bh=V+rLFps+9mWWUiKnkTXZDp67CNze6yqC+qwz9oOYC7M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XWmkZ9dRF7JaGUDoJOdCCps/hdGyeDGctFvBzoqetCXWS/UuVsBr6N2IjjaIJp9EgRBqF7v9gYJLEOIMIo+eo8JD781kZF9taYfhYxNynGRGrpsKmqIyrriA5WTGuHH9ZgNGtHm9i86BDK0BuZt6tVBOAwVlH5RjUS4h6fYOuWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqQ0lyxr; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqQ0lyxr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738716890; x=1770252890;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V+rLFps+9mWWUiKnkTXZDp67CNze6yqC+qwz9oOYC7M=;
  b=IqQ0lyxrSuUdw8HguK9EzPKW9H2Xm4Hzr9cf61KC+s/eI3+hdOtqbSFi
   3wVH83T3fn2z+8kL3WEVvR7xqLUYRskfG1XOI54MX42pWhrbOD9uiXe8d
   1WQfu7kXBmAdtYNy8iSg6eioNC/GKFqXfbTpcaMm0MZVeu1dNdggAdHn3
   nNNULhMUnPX78zzoymphaQY+KkWEPESgbW/9DNZjk49l7aiQlECYAq+Vy
   amaraI72iy+Df4457JtaZ9iTwyvkn5eJXJkf0otvbEVveeYKwratXvoVo
   lNURH0h3AXRKsC8Y0pgZtS3t5kaXT0z3BmBOIYTu1uMVNRh1Yba3H/xqv
   g==;
X-CSE-ConnectionGUID: lbdrQe7dT1iJ1zs31wUGPA==
X-CSE-MsgGUID: aj9wZF6KS/SK1gC6G13h0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49920100"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="49920100"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:54:48 -0800
X-CSE-ConnectionGUID: 8UMd3Ym8QJ6764JrAUV/zw==
X-CSE-MsgGUID: uPmdyjKJRf+q9liTGSKnRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111628987"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 16:54:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 16:54:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 16:54:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 16:54:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3TixdOQkb7IoOfuelsgj64C9CgdNsqzG+n5srncSTJ1m1WVRZJVyOYkSK4WGl+wJEju1LxX/zFS6yRhB2bBLfP7iV2jJFSWCyhCFHM8HkEIuFKoJtA0wxLm0PrBzTY9Mo0sPG/VSzilQK0UpIiZ4EMquXUFvG8TKEs6Jq6wXkGXSXsi1W6/bD8MkAWKCZHpALsJD4lvlg1HuLHLKyBK6NlRht07BPIt+MtwBveMN/UHqtFV9TTW0JuWIdx1ysWDhxV++kxC9OEHHtQc4d/IxS2G6QLLAPy2rEhR8PQhDS4ir+qb8VjvtfQ2DzY8sy5pDLKzU1CtKOG6LwzXKMlWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Sh2HxrQi6Q150lVUjdOn7Cl0HSL48Wq44qzWNgamVI=;
 b=BNLlOh/KTSHzI95yVwv/U4nkRsTHqfdnLlwjYfmhKyASV9ZdQMIt4447rYbCqdJmCkmYTM6+XgSlNWUVHcB8+xRHtp7/kuPWuz0V2hec6+UH9r+oYfkt5jqou8uE1HHjWXfbJAXnEzZbDVC4zoUfgUWSUD1xqBSoPYYzHfgwXdWmieKCAD6sis4E9pXIaFhN/amJDuYgcYXBsNZ5gR+VjmsyuClomMlKf1XI/U4zAt0ERL9Q1DSkTJGDU7/gCDnYrNY8E3RXtbFlPIvC9BMArx0CEy7+bytxiWATjKoWvDhW6AmBM4n1zfEiXOEhs4++DUZppXZfP4POjzSKpLJ79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 00:54:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 00:54:45 +0000
Date: Tue, 4 Feb 2025 16:54:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 05/16] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <67a2b6d345b61_2d2c2943c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-6-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204220430.4146187-6-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:303:16d::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 30183d34-614c-47b1-024d-08dd457faf03
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3FpKFPuJNzUwXy0ztVadH2bbvcsZsQL/kw2rd6RbhNwTVij5EnqzPocHFfdg?=
 =?us-ascii?Q?/cFB5fHbxjlG7hQZut8+i3UO9g/NS/6Kid+yXsuhV/RaIVJyTotTRmwCLsyO?=
 =?us-ascii?Q?pm5bgj8S/SZ1ykVfDczatJomrqZ4wipeZZ+qLwLmc3wZL3kbFAbLyQB7g5sT?=
 =?us-ascii?Q?JamuKGxCgS1lRK3O4Oq1MeBv5PM02BjIb6Em5PXGBVQenRpAW+r7a4THlYh0?=
 =?us-ascii?Q?G6p+aXjyew2MXY9msY3hV3orfPVFMjNZrSiNVwlDB6KpjA5dyGt4Zd6EToqq?=
 =?us-ascii?Q?jf/7KpFE71vCcHx5imsfny3zxdoDW3F/X35B3SNfG676znTcv3+hbppVnJtf?=
 =?us-ascii?Q?JvwpLAmxpfYDNYrEWAiNZsZEvJurSBAiHNqPuxqO4ByeLWEKdWzDjMWCYTWo?=
 =?us-ascii?Q?m4Fvkfg2biB5sWbZREzE0LZyBVMOgJUrNazWUftoSJR9RYwbpGYK99H01Y3Y?=
 =?us-ascii?Q?G+67MoRXr3NonPaEIYA3PtzCd8OHc7M8mEC6tX1pVtoPUOjaP4F1ZgX9qsZe?=
 =?us-ascii?Q?JUFweUvlHA5FiSuOwEEJ39pKdryIRcaaeABqEWF7gE3IJOS0zq3mT+frPerz?=
 =?us-ascii?Q?3uObgC9MB/mXZq1ZhpfXvhlbOQyE3GZRKrxVCEhllXXaC/9bndMSC+VCsIwH?=
 =?us-ascii?Q?EVPxEUljn+vHGe4GZRSLNLZ6ryNVEyDYYqqYiSne32N14d7D2KcFkryQYpBO?=
 =?us-ascii?Q?y5M7uJ1aTrNKPHekIVguprkd5Up/L2d8gZKrROQODZc9MlYNZAaxZj1pTYO8?=
 =?us-ascii?Q?J56Fe+nxI7nwmWLQFkes5+6lrnmUo0XaHLWK4ZGO0IUrCQ8VW1LibOAUDfvz?=
 =?us-ascii?Q?UsXu43QPplogQvhaWAVDAkTJeL0hG7qAidw1NVZOFRviGYQlRBcF3F80HQVi?=
 =?us-ascii?Q?wEhhofteH9EE/+rPWk/fLZMhDg6coO+syGFau243my7PJRwKciyo9Mf4/CKW?=
 =?us-ascii?Q?BqzGot1E/Cu22gYaSdXUHb8AIloWxL/zae51PwL9bZLZrkSINM+Ei4JEB479?=
 =?us-ascii?Q?GXQX/pHirwfm1xCCw+UneIWo/v5rjlI5MDFocImogLW85+z37PmcIIpXEwLs?=
 =?us-ascii?Q?pKrshLRm3K+K1KDvtvfb8gAXr58Yvyd49TCHZWtqYa9QrAsnXC2DF6wELi5A?=
 =?us-ascii?Q?RidGm69BSr60u2km0X/c1gIgZ9s3MAzqOlTREFU1woWc/zRijUrs8nsx6fhU?=
 =?us-ascii?Q?+KCB/5Y8PyiWOvRrV53nXKFxL4jtTmSI2hBXIDqWfr32lU1S+mt7Lg4DyGIP?=
 =?us-ascii?Q?sOefFKIHHrQ3pl68ITYHznyIJTzbGGtJaL/ZQ/vfOyfIBcZEbZS2n4A10F9N?=
 =?us-ascii?Q?AA63tSkdhHreedYm/OtzbNyYf3zrQG9mlJxItw6QLycV3AmXoytp9kjH+tqk?=
 =?us-ascii?Q?ODUF418r8+Mfbvu0z2nhekVD/j2G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDVocBrVUUAKz7oV48V3Qm6qxu+t+0D7WnAvnIfqiGoJft0OTfIRrTpcjDK8?=
 =?us-ascii?Q?8lIl+55rWK39oETiCaNLO5DG8o9psXrZHRAEAmb2aqG1PHc7CM6FVuceFDuk?=
 =?us-ascii?Q?LrrEzU4wuSbJeMLbQNBZI/YPSQ5lBE0KJr77I1+Eo+AQErmyTH6/El+DE0hV?=
 =?us-ascii?Q?b/rxZ2lNIdEMJiX+I4sdUVjkJeDu/7tm44vKQw7nSAeJL9R/qrGwbcEONIO7?=
 =?us-ascii?Q?LjpXbqVpSltnv8nmrH8X3tvrE/kuyFQMf80U38sQ8ZMs6P/7ToBZtpjbk/FJ?=
 =?us-ascii?Q?QzycDApYPTbO6Li6kxblWRA8bpzEKrxb4/pSQEjOlBAb3AzZAGF77MyIM3Ym?=
 =?us-ascii?Q?3cffbv4Y41AY3WLZk8re/Xf5okW1KH8RXAzDaUbpVY35ty9vSVkXDGioXZ6z?=
 =?us-ascii?Q?03bvmhEgAzpNfrGGdG/F6HBpfdp3brLcgiM3gOeSZJKfTw2U90NuERN2HT9/?=
 =?us-ascii?Q?c0I+z5MPZhRdUtbUSKQ76wcYPq9R96ueLzXBuNR7DwSG0ypYl+pbh9DaFHfb?=
 =?us-ascii?Q?HIHhGm3sOuf6E3qlL2DZj0aj0Hx7axFXkfiKQjiTchZpuks3kUq/5YJErN/j?=
 =?us-ascii?Q?vTpdZXkCFpOXNAwFQnIM1iUU56G7SNhoMhxozs9Y9Mip9dtwDh/rUPLkv7HM?=
 =?us-ascii?Q?/b8gGSONJB8I4W9Jmy8jzki6zEMrJ6Ej+wvkzf8y+MDCvnXUBK4qtLX0WxtU?=
 =?us-ascii?Q?ey2uVLYjm2rHtVmOtEJrWDjVvPIB5n0It18zg8Use2+ha0GtTWvScxfV5LU2?=
 =?us-ascii?Q?P+omdN9j6ZfqiXUOojuxb7yewHaVAIjKA+2wkF84aTERcdvK05JCsffkth3d?=
 =?us-ascii?Q?Oi4e82EJN9VU40kAho8fdaVXspaMB7XIteAG8kioSAA76oWXDEh7+1DfR3A4?=
 =?us-ascii?Q?DpZd7B3+OXNOqaJV4zttSx+e+fDsXBr42gEY9YD1ThPxyF+Rin8K/WYQCeAH?=
 =?us-ascii?Q?dUOCn6HIeP29yWWprzYqO0vWobvAAAtdnRfsiuNXOTnABVMXltMzlryhZuLN?=
 =?us-ascii?Q?VSUZGt7Vf6ikh987xta7UOlQ38kk6uZtF/Ru8wDhDFECpfj8YHXf91061kaw?=
 =?us-ascii?Q?MdrBmKL+WHeKdEDWCXPOcoMIM9qduQcQqrEmBtXA1S2DLSHJOuvRqm1PDlXO?=
 =?us-ascii?Q?ta0QLvm6O+uGS5oBAe0cEs0KAd/LQ4HqxZz4BlvaTI1Ok5+nDzK38rUKLeMq?=
 =?us-ascii?Q?Xzu0YXZO7ZPlshAIEL3E6YaG0aAs/M6lyw4mNAnJY82BUYlc8eTaEJWjirJS?=
 =?us-ascii?Q?po9oxj9ZZdPdB6WT8Y8kNzXb+5KKsBgPWtEI+fs5HamLilcKhX+Qvo7av7Ep?=
 =?us-ascii?Q?2QLe73vFVP9g9MsD3Dr98LgasMMD6cImXM8gPU0DyL+odX3KEXm0gmItDlXJ?=
 =?us-ascii?Q?TWlxuAFLq5MIKSEX0eiCwrqWGD86HGJRbVo+ntUszDZTO+fR+UTRa5MEQ+i7?=
 =?us-ascii?Q?+eqx5KMlMVaEwI/Ex5gHK1Y1HBU2P1vWS8qaZXAzKhxy6gwVWa//PHvjF1z1?=
 =?us-ascii?Q?00AtoO0Bw9ZamKD8UUlyznUaYEwpXAAZoUvEeAKgOsSnnD7/mmQ7mrgrEtuu?=
 =?us-ascii?Q?ztNJ1GgQf0T9Jan4DV9fngG3otvI8xmpxP2kTSUY1BvZnapfs/5O0vEVzl0l?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30183d34-614c-47b1-024d-08dd457faf03
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 00:54:45.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YA/WDrdrpRRqwA0KyfdfXni/OgY3NnYS5m4bi0yeeXPdU6Uo06q0B6kBxs/qXIjDnoZm3l/AMPN9QJaLlSYQbvjuvUwQq7o2uEexgnRsNAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_FEATURE mailbox command.
> 
> CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
> CXL spec r3.2 section 8.2.9.6.2 describes Get Feature command.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/Makefile   |  1 +
>  drivers/cxl/core/features.c | 59 +++++++++++++++++++++++++++++++++++++
>  include/cxl/features.h      | 29 ++++++++++++++++++
>  tools/testing/cxl/Kbuild    |  1 +
>  4 files changed, 90 insertions(+)
>  create mode 100644 drivers/cxl/core/features.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..73b6348afd67 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -14,5 +14,6 @@ cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
> +cxl_core-y += features.o

Would have expected:

cxl_core-$(CONFIG_CXL_FEATURES) += features.o

I think it is ok to throw all of Feature and FWCTL support behind a
single config option. That is, until it becomes clear that someone has a
"yes, kernel internal CXL Features, no FWCTL CXL Features" use case.

>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> new file mode 100644
> index 000000000000..b01dc5ebb24d
> --- /dev/null
> +++ b/drivers/cxl/core/features.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <cxl/mailbox.h>
> +#include <cxl/features.h>
> +#include "cxl.h"
> +#include "core.h"
> +#include "cxlmem.h"
> +#include "features.h"
> +
> +size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> +		       enum cxl_get_feat_selection selection,
> +		       void *feat_out, size_t feat_out_size, u16 offset,
> +		       u16 *return_code)
> +{
> +	size_t data_to_rd_size, size_out;
> +	struct cxl_mbox_get_feat_in pi;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t data_rcvd_size = 0;
> +	int rc;
> +
> +	if (return_code)
> +		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +
> +	if (!feat_out || !feat_out_size)
> +		return 0;
> +
> +	size_out = min(feat_out_size, cxl_mbox->payload_size);
> +	uuid_copy(&pi.uuid, feat_uuid);
> +	pi.selection = selection;
> +	do {
> +		data_to_rd_size = min(feat_out_size - data_rcvd_size,
> +				      cxl_mbox->payload_size);
> +		pi.offset = cpu_to_le16(offset + data_rcvd_size);
> +		pi.count = cpu_to_le16(data_to_rd_size);
> +
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_FEATURE,
> +			.size_in = sizeof(pi),
> +			.payload_in = &pi,
> +			.size_out = size_out,
> +			.payload_out = feat_out + data_rcvd_size,
> +			.min_out = data_to_rd_size,
> +		};
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		if (rc < 0 || !mbox_cmd.size_out) {
> +			if (return_code)
> +				*return_code = mbox_cmd.return_code;
> +			return 0;
> +		}
> +		data_rcvd_size += mbox_cmd.size_out;
> +	} while (data_rcvd_size < feat_out_size);
> +
> +	if (return_code)
> +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> +
> +	return data_rcvd_size;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, "CXL");

So I see this is exported to a new cxl_fwtcl.ko module, but I think all
of this can be core built-in functionality similar to memdev ioctl and
firmware upload support. As long as distributions can opt-out of FWCTL
and Features at build time then this is no worse than
CONFIG_CXL_MEM_RAW_COMMANDS from a proprietary use case / security model
stance. With that software only needs to worry about finding a
cxl_memdev object and not manually loading a cxl_fwctl module.
