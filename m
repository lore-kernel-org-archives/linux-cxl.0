Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE2322C99;
	Wed, 14 Jan 2026 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360427; cv=fail; b=OEnZLGtrjNeL7FFwsakh1mivTs4pbgFpFTa0XIx0UnW5wPqFaB3WXZim/UBnCTY3DeVcZHGH6qiPbrEsLjh3l6Ns3bl0o374C46Y8st+g7l5CWBLI9WFcCd+25/K7IymAWES07jvO0tmIebP1LAYc54NMmulM67cPZlkdqwOTHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360427; c=relaxed/simple;
	bh=nhVHN6TVFVEukJU/yNFeIF+Et+T8DlaQqIX87DtAGx4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qNVSbrRXIqyO2LinZi14WGUV5YF+urtbK4yU2nVJtApRk4rduJsAJPo2n+4g5cFemPy2W+RFVBVWr0xJcpH8FIG7dsuCtwhZz/XiZB877Fb6tXysCHe5/ioFmfVnmcRCeLYDFgsevGPS0y3CZhjWDcZ5DFVnmzXxZs5yL99B9TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhdacpRs; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhdacpRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768360416; x=1799896416;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nhVHN6TVFVEukJU/yNFeIF+Et+T8DlaQqIX87DtAGx4=;
  b=PhdacpRsFrKhD7XUFQMlebvBgCZ4dmy8joIkiuZ3P4v/mKX+iGUyzAY7
   fuuZdROPnDNc+zuAqd9PgBrfA2KHXpTMJCNn1R6jl2OeAkcAnLgJ82IJX
   dqoU2eMPJ9e8+x/PG5Dn01Cl4HIiXLd3fA7b6rTsxrQE3O8Ria8StlQiH
   k7Av5h09MtR8B/2r4ZzUkb6BeJc6Nyvf/0Q8cdL4hbppTZbRyrNsFhFgv
   zeCaITqBTZ7Gv2yQJMy2MHTb+JELIkq03L7UuhQhlyOzVJnX9b4ceRtKN
   2F/oMiIrlWfDfRcuPZLw6VDlBAL8XZ+sNDG4ZHnVZN706FfmyoxJ//uV2
   w==;
X-CSE-ConnectionGUID: KauS21YCQyafdXCLus8QSg==
X-CSE-MsgGUID: t9rcvcGYSkufNGRADNjtHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69576193"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69576193"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:13:35 -0800
X-CSE-ConnectionGUID: 0L0+FtJ0T+ibGVVKqePSVA==
X-CSE-MsgGUID: oWgtETmVQtaCZE5CiJOVVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="235807335"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:13:35 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:13:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 19:13:34 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:13:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQ51dLrepBp5lAj/dhiWABhnd2rhrRMK4x/NTyJgOgnfoiDIf1No9ZHA0rfaeGy6kBbd6tuO36FfcbOi9rSA3VyDtJSR6yaQeXdfiS7DGeuW8l0HyfjH6xnI8018ezBh7RJ3NAYZGqMnCqlpYLxML35Npwy8reWuDauFKKQUkYyeqz8qNDyKCisPynjd0HPkbvOOspXVZisegs8A23i8uIQQ6SjT106mrUlo1mjtgLG7yvS+ZWG1BVYUFj1Q/AGE/3ugAaq41ZRiJ+9fWcFFAImyUWWjlIoGSSFaA9grKfbwbPuo4zxMAw21fSMzh27M8GaONwnJDBVIMD5BmxwQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foadF/7C77uNqYQALFKsx/gj8RHlj9Mnu1fFK5Ai1iY=;
 b=mq9Wnqb1lMvmsdBSFmfgl5jx/t0yvvxHFgDNcnqzmd1UGLNd8TnzVA9ppYKoaEgF9z9bNDd353LH5MisGX5L/api5GP/MX/PAlpxIvkExbtbtRS9wWVy5t0lsgnv6rAfZx51C67IkmZ8NQgb20SPrsrzeUP52OfKH8KR9Kw9vyok5f5Mjw92/dDIBSJ7VQTl+5xBEcqzu9VdKMe9Zp1NLz+0G5DeRx9NBR5VIzsZaX6FKViV+lAn7NExv3qp5j4PlZGEraLgaDcOakqNX6sSRj8DkdY5fIPu8TcAbrCQQw41drQzV04p1aLe/pGRq5Swqssv/a8JhVMPlZAll6UYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Wed, 14 Jan
 2026 03:13:32 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 03:13:32 +0000
Date: Tue, 13 Jan 2026 19:13:29 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 02/13] cxl/region: Store root decoder in struct
 cxl_region
Message-ID: <aWcJ2YKkoiRzu6sf@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110114705.681676-3-rrichter@amd.com>
X-ClientProxiedBy: BYAPR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:a03:54::48) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SJ0PR11MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: e14df4bc-835f-4658-9b8f-08de531ae5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0enNLiS18jfjZd8oFAhs17LZ7waTkck8qPgi77lsvs6ckpcjc0RiM6xBQYcQ?=
 =?us-ascii?Q?KnQMzyAPAIc6rDiTvPKx4DmpsFGlMJilEA5WPGtU+zj/cyuU6BW/Ljftb//+?=
 =?us-ascii?Q?f6PmNp4kg1ejvfK570UZF3GZ8jjUQAk6uXB+CkHgQCtPRkpdrLgOEeVhZT9D?=
 =?us-ascii?Q?ldetGe2D4rlshN79/XDB80xlTW+30aeDMX8aIBgKSV1d+Lq3O//2wlSGj9pU?=
 =?us-ascii?Q?KQe7X+BSVhHT1HMNu/nuVpdiuLeI6cjKimujj8tdBybsDuJ4mcmZKrFgm2H4?=
 =?us-ascii?Q?fNmgVBAO1ExK1Ef6PQ9o8e1mTrr1WwXiJxYL2JcZQoJBfEHcXlFWNztX9N25?=
 =?us-ascii?Q?lzLhcZg0SylZtBT4Ubi9b0qGHb63ub6MZOUST9IjsV6/TvkNDiPaHkfHGE8B?=
 =?us-ascii?Q?Urtam1GOhwEliXtSua3J7DbPt9piS0C5i7ZbyplvYoNX7biXNQHzkWP7Vw64?=
 =?us-ascii?Q?3daJsK7o5CzPCT9UjMxNkRVPcorsvjXTSD+WfBDyRvIfR6MWPxe4VBpNkXqn?=
 =?us-ascii?Q?OsHgku/cp/76CJGZDBgR5PbmzN9fBQYA8cad03hGXHoHepn5aCgBwaLMnpXC?=
 =?us-ascii?Q?rj9IM39ySfHzq6hrhIcaaPdwPQvsYuw3AFiZceADITp6inm2sD5KMZJ2J5X1?=
 =?us-ascii?Q?ujZip5YALzpA4u/nWICf8oN1j/Rkw0uQ8ImZzpeHA0V7gDcYiH168lNSb43K?=
 =?us-ascii?Q?prlsvFNZ5nF/evLcw6fewvKv5SLqXwopZyQ7LMt27m430Hv6+TtxA/XIrSKb?=
 =?us-ascii?Q?s7v1Q8yJXk6exX36ixXfw0VaDM7RRFg2SY8zxaXzngV4dbuiII+2rNNcQmqJ?=
 =?us-ascii?Q?0QxWOxX3UNmnFYen8TTevxgCPy9fYjp5c6vFD73Aibw56oohLwuT2jX6kjoU?=
 =?us-ascii?Q?0FH6qXkR0OFIa4ptOKPTIyprFi987CXp9t26zpo9VdOE3LJ5vl1vBt7tpdY8?=
 =?us-ascii?Q?Kt48cWFd6kf6s5wjsI9q/m4nk0g9ORmGlNNnwVscPbcea7CWRiU/M9fK9P5E?=
 =?us-ascii?Q?JY1dE06nDh/8P8XsEcWsjcG/yFlQK6SPqFB9o86WAxS0Kt3Oq3SYIPciRUqa?=
 =?us-ascii?Q?tHcyS/P8wRMFrO3TKd4b+GCujmUqjFdOajvppyWa5Krz8FvoVc2grMX2gEzY?=
 =?us-ascii?Q?Kq89zPjOJahesKEvtFo+7z7e95i9JTSSSj1teAOLolYk3UXcIU3U9zIM2n4F?=
 =?us-ascii?Q?J1RYcxyUj+10tLnDQacQFJQyEKme9UGEcJrreDqxzT95qQ44GCVhmZcRzefp?=
 =?us-ascii?Q?vxJvbVpS5m9zYT+xdOi3ux0F+ZpnEf6rl0xgV1e7Y/ixmSqsVotXyThn2T02?=
 =?us-ascii?Q?etstMXK4e5NFZCzlOEPNcUAvZngL2BhvrSuOhSb6WwI1LmwLwRUSdboUb/w4?=
 =?us-ascii?Q?IRkqr2o8F8sQ6PtepmKDMITUkHGHk2PrXx+sIglv2W/cQtmFIZsOSimjNJTG?=
 =?us-ascii?Q?wsgte90EvtUwNQwrpa2gzHu8Xc/XXj9G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lTnxt6xp46y0a01l0wrUkfsfi+btNMAURj1uY2RdM1djMpZ/E8GbRhLu7GeC?=
 =?us-ascii?Q?xy9LZDMh2hetzkRldGnTRrDgwmRk55vp2IguOiXW2xJUkkfyFQe0Hd/ZfGjD?=
 =?us-ascii?Q?yED+EDDtZcxkUNUQno7CqbFucJoukTD8pEhwP/o5ulVOtV+CdX2KIbyc31Vs?=
 =?us-ascii?Q?8ui8N5krjndZcpnxnQaRuRH8ks9ipQ8PsUy9OKVtzpvq9IFL/y65H7A4lm8U?=
 =?us-ascii?Q?7bjhQcD8dIqcVSSWVmzTDK5nW0pA7VdCUOU0qoOREhnWBVTay+FvvoNpRFRz?=
 =?us-ascii?Q?0+WryyzMxDzdp9wb59Gh7PJl/q+pKHpO6hc1kfvFo3L+vDV3KmZv/qDyHjwz?=
 =?us-ascii?Q?4bCe3eMG3GAlW6F+psKqmAJ2FKbECPOKnl9Fhy3u/FqHHaVSuUF9Z9va/Gia?=
 =?us-ascii?Q?LFZRY6XtO7qLXPILdqbhpyWuM+XpaPPQ7n9RwPq3Ki0qa2xNxhLnf8qYTYk8?=
 =?us-ascii?Q?QhBG1i8zKmh2mlsNFZKl8oEpsIodVZKNJO2LqLNfWl2lN1mjonjEf3PQv1/P?=
 =?us-ascii?Q?Hy5Pdd2qIVrPjJrR9q3gMh2/U4OPsdMbQ2pupnvezt5gS/Yo/CUnlTcZOoBi?=
 =?us-ascii?Q?pxVZymgmP78vtRVxycXAFkYV1SztAKqJuWuBUG+PraNBDBnuoAbwS5wX2PW6?=
 =?us-ascii?Q?B4NDoUmDKrv/8UnUTu8Lwg4oJHAljDElpa08LWIjdnXg1SFbfdNv4NyK9a6m?=
 =?us-ascii?Q?kBtKct3C9pE091qUWEeUckmNmbrNuEgVDrJaBsLB7czgfr0XLIEvG0deP6XG?=
 =?us-ascii?Q?GLZ2ahSBJzeDLkM0X0TOhlpwAaoP6HpnS98ILhgdYOcyFc4gVCKcgoWWXA/P?=
 =?us-ascii?Q?G8GQM6rYc2NkAOWZPi1rtnkZlEvID/Xym657+0eiMpFNfAHn/BOzANPTkPoA?=
 =?us-ascii?Q?UrsNHPwawd0mb8j4ebeg0EbHR1Or6eZpLTspr++eJgbAwWgZqLIhwu1g9FFD?=
 =?us-ascii?Q?6YgMww7RxUpulmMfeY9SVMNBWWGFRkzYbCNViAUQ6n/9Ot+CBTG5X181OwO3?=
 =?us-ascii?Q?kmY1JZkjXzz7Rer7L85kaCFx8SCUX6D2Kk1DTzinXpYJ15s7ZaxHwAIUhHmm?=
 =?us-ascii?Q?0WKV6U7JXnRUUtuJFwZA1D3dOcPYH0FkqP05qlZzg2YjhCEejF8rUKV8O6x9?=
 =?us-ascii?Q?GvxENwN1/Ew0Za7YgUyfvz+THfp4brjUXKPB0F35A9CzLx2DfBhBFLL1RU7O?=
 =?us-ascii?Q?4lJzFQ7j3bhBc+qTQ7mp40Vut0RGFDHAjlNz/QUijye4yM7OwC8g+rZ0Vuv0?=
 =?us-ascii?Q?pSozlr0ItGCYtDU7U0JufVB80EywtFPDCm5agJZXcnkIi4RYWsIeFKPEYCzx?=
 =?us-ascii?Q?vPV0w+fv3fp/KhYtZw1A6Xy0sPJveMaipfjUwOWpDjWHn93kp0Em/vdAzs08?=
 =?us-ascii?Q?fEXnjKjg6aT/FU6Vwmj5SdRbHJq+sxk669tX2X/EHQoSeE061yhgwK4Zt4ej?=
 =?us-ascii?Q?fUb+K1WRWK1YczfsrpaG8Vlg+GPwZBbvZoo0g5tLai4phCkQyX0M7zQiTYU8?=
 =?us-ascii?Q?l3THqcYelA9EBYlEtYfSByminX4SyAcYy5TbiaSaaASpD9r0UeKwM915P6uL?=
 =?us-ascii?Q?ucO0inKKN0OyDtjBpF0YeRnL3BQf/LpYCqT1BBpsD/o+RYuGJXBpUa/YLL/m?=
 =?us-ascii?Q?AtqOGATgkP9gCX6IfL/uK+NUYsDnWYdOruWapp5vIK/8JAP7YV95yDx9g5Mc?=
 =?us-ascii?Q?UynAD4Dh13R6MWdJg9v5xACJGKZak2Cu10Gj4Gr5RJP8E33rZhoijeji172U?=
 =?us-ascii?Q?xADfFGl6pDD6ogsOdhCJn2X41H1WW5M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e14df4bc-835f-4658-9b8f-08de531ae5bc
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:13:32.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db5+1Xc6L1wiBlAkkk7zNlYXSId8n/WUwxndNNGGzOt2kcNcQrZu7owsz2fPn22b7L0dAy9eexJgaI/ogEF8Y6vxrXsEwqj2YsyfuES2WVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com

On Sat, Jan 10, 2026 at 12:46:47PM +0100, Robert Richter wrote:
> A region is always bound to a root decoder. The region's associated
> root decoder is often needed. Add it to struct cxl_region.
> 
> This simplifies the code by removing dynamic lookups and the root
> decoder argument from the function argument list where possible.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters. It changes the argument list of __construct_region() in
> preparation of adding a context argument. Additionally the arg list of
> cxl_region_attach_position() is simplified and the use of
> to_cxl_root_decoder() removed, which always reconstructs and checks
> the pointer. The pointer never changes and is frequently used. Code
> becomes more readable as this amphazises the binding between both
> objects.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

