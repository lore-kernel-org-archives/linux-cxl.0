Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C1922B8AB;
	Mon, 23 Mar 2026 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233602; cv=fail; b=VPJB4MSbjLG//TVgZh3+wn3rImdfMV8vO423bsuv9vgR5kkjJi3kIu4dQTlCOjO9kOl3Ktb1oqJiRw3vFQD4v0SrHFNJE+yx58r9ps2FOmypTz4Ze2xHeWosQMRERcm4uFVVxgSOQJgqrwsTc9KkoqlBU6jnwN9HteA1Jn3qkZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233602; c=relaxed/simple;
	bh=dPECrf0O9z5KZeqs/n5puKntxCzr0v44hVcawY0TipU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ODIxFJAx+6mswnxLFels39mIYIXhQzxW5qwZ/PyMqh6zIj9MWDcWVJDqLOUHoAiE/GPyDRmc/NvmwMVVLaDud6a8vvgiOjj5fbBgx65dpUkj4OQIFNdGZgZmGwDeRrEgSp3HdsNeaL+4m0Q7TvxW3KlgCednHP4cKP8zgbn1NiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=je3ZYjEj; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="je3ZYjEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774233601; x=1805769601;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dPECrf0O9z5KZeqs/n5puKntxCzr0v44hVcawY0TipU=;
  b=je3ZYjEjfUI17+VaszDwp5zQvgInq9ZrkFxsl8sjVN5SToOJhYXggm1M
   rdi/DOI/G7bMCxO5TnI7B5a9xpZY6ZVF+WmADDTW3YVTCvP9XLgBqbzQj
   5WGpX4axVPbd8Hug63LhbphUOkkV/SuFyf5rR27FN8dn5d83BenCQbgiP
   9tOj1JShPjQ0jhSXe+ZiUD5R1UGjJrQIsoN1gWVoHJc52gr4SV6PUd3KL
   htnuwZAoC+gy9DsUICcj4vUEKf0MMFmX58bSd2/WmzmJDtvohWD3RgrsQ
   KsyHULGHIO+XevtfS6gzFuZPikG5dcOy8gkfMYxHLCfTkdj1pN5Zl2d5y
   A==;
X-CSE-ConnectionGUID: amGclIRyReKhKdi7bartLw==
X-CSE-MsgGUID: OZ0E1l1BRD+zfkxdXwE3VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="77837596"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="77837596"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 19:39:58 -0700
X-CSE-ConnectionGUID: NYtGLhlQRp6YLyY4nTpYqQ==
X-CSE-MsgGUID: 5SjwrbicQqOBGFZRPXvtHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="225639008"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 19:39:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 19:39:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 19:39:55 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 19:39:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btyZ+XA6Xu7AmFboaE6LyT0dZUgTm3razDai2UC70yYDaNt0RUhbsqt95yM2so72OS5amGEkV0ONXb7jqZUumlgBrdD87PbCNl4i/UQaeAlXp017aH5hxpZmwWKDyEjAvSoVSzXZbnRPrl8U1RGYugu3Cf2TIXGQ3+Lq0JpnEveJqW9Ibz6IeNd501MTcPepAWT+a2bER6DXmbsfFfVBnbpayV1CoQV6UJ34jc5BKvxbbMBVgrP3F3jjhBulaW9ZjM57KEeG66SDKZiZJq07bRDXbRf5M3aAkcp7lvNBIL9HwS4MWa1SXSJ0JKE2lgZC2NYwssBG2BtbLBK4QZn0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=danfFc0t8ef4+EZnIHSnaAyhtsbIUEeO1/eVapgjA0Y=;
 b=KMe9THa77IZOwkCB9MDR4CcqplXaDq2818V5zox/RX/oqqIVZBRrTEEbimgj1IVOLTyNJzDi6HYs2djxBruSQu4xu8PImVtgGo6VLCbGGfOrzLhVfLTPIkPWVNehwcjfCac8ci/NrqKyOyVLdGvHRMRAUDstM+ARAkPR19Zizenq8AMB2D6QSW0bsYnYlUWxEal72p1JyMTcsNe5CbThDRs+QppuKiGbXtgI/UTZbbIz7xoe5kXG+D9axh/uDasmc9v0U2a+KGb+39zOm0FCLfnWdfmthWAw1uwrDEde9Toh4i4C3BLZYYN7VT9+TQMKNewOS2vc7+1f/dSNSxaPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SAWPR11MB9781.namprd11.prod.outlook.com (2603:10b6:806:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 02:39:49 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::3979:c00f:fdca:b895]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::3979:c00f:fdca:b895%4]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 02:39:49 +0000
Date: Sun, 22 Mar 2026 19:39:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] cxl/hdm: Add support for 32 switch decoders
Message-ID: <acCn8Z_rmpbz3qdm@aschofie-mobl2.lan>
References: <20260321061459.1910205-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260321061459.1910205-1-ming.li@zohomail.com>
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SAWPR11MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: 207f935d-5ee4-41e7-1b06-08de88857420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: DIbfKvntpImTuzqrrUtelCdXc0HmwjWTP7fYzS7PFB7Ei41Mwzm9P7SRZNDiWOAAY4j3azKQUjPBQESbk5o/TsooQxx7kVioUnRVM1oADiTch8lFm3nBTN9E+Tdk2sPpMcGrXgMXDh33dVudH6HeaHML7bAqqK+LVv3AqqLmT1ijCDTw01kEocf+vVexZTuPukHKSGCG9Vl56T2T7HEwxcZ1gQ3D3YYYu4pKlPggxgIV6vDUJhzvmpSNDhoyd44fsWqDctQA2REhNHljPykDxECJ82aRoNSpGFN+M3FhEsNttAyYFROEjhsEupDEfuGaPyhJ7kSqDS4uEZEBT9imPqhk6LrlddOgVzduN/fo3iIM56AqAOhX41YxNAzC//ksUxGYzGszO2jiXQXvdX6C5GdYFBaLZLEpTMNFKDAZFbXyV49WP5NbsKna0SFGKrZGOyuWJmQuIXzULlJlfvvZkOFYdhv4ZUlvqyt+cNUx2wqm/hbz6huXEST85eDQFVSN+kFdGnhrrIsV26GqzKPS2BvtGMYLPbO6ZHVRyGHQbBRuMWrEb5KgS8qNeHBYs/s4vY9c0fUa8dTnH9nnRWPvL2X/qY0Ag3XQ4faQ9ySiCh1IN4YT3NDGcqo5varvUDN/LuQhOLdN2nP65UgJdMmdk/8grAjj8h2hfh9qwFX9FzwRyRtP7aZ3i9cWl6CawHPWjjXA0P3NxDiVbNTSpoCZdhR/Jk76ff1mP5dC37Qqhh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AS2oADkCzsfZ3SfEf2gvrXtOjRF2ltGvbR7z9E3VF2cAgb+Sw9kVZasv8nyo?=
 =?us-ascii?Q?Kb/Y3TwGlZW+V6IZaFhFLrZg6H5ONZXReV5kMyKNCFnqj2adE4K10gkNLuEn?=
 =?us-ascii?Q?u7ikESkHxEOhynxz3j34pay1daCXoJ5lyogadhd2UINdXp7q+bETlodl/CrP?=
 =?us-ascii?Q?BUKkJaDC4pNd9flPSNDNCcIL54STF3kdzfeofb+tKfwhU01O4Ts9B/K3Sjhs?=
 =?us-ascii?Q?Bi/hVmbuX9g/unQdCeAuSreFTinn07LPsV8JPR2293qQuQPkPDuQ+RMe7EDr?=
 =?us-ascii?Q?r8nWfai6m971dRTgRfwxRm9IcbdfQeGDzbu19Zzi2HQzk+ZSSlLd/gUMpLRK?=
 =?us-ascii?Q?IXHvMPP+tTKrVf8jRUJ/mXNGzxNClBwFF3TmM/euZ8ZUXtPu0AFnpqMxeGzN?=
 =?us-ascii?Q?NJSlsuvrTbpAUJkpManILws4NuiRA9iymcdi+yjWiTNYD8cKwKruD8/4qmbN?=
 =?us-ascii?Q?8j+1GJ5t03Tl63yfngunoiLxgrKQF4ybzVgJzj80aVpkcXx4y10xxUWU0JOb?=
 =?us-ascii?Q?w7HMf96X7h/thq9cXlzrPfUdUV7Q8Ro29TJPuis5L9RhRgSYOIscWT6v547/?=
 =?us-ascii?Q?ghBLufpKP664FyBkoyBNnfoVxh2cmuEhtbqLWBM70QMnnpO2ij+PPj8SmZeH?=
 =?us-ascii?Q?7PQiYCQqZO7puRIQd1rOEUzo/yFanZZUclSK5gb4I0DPllxN+p4CnBojmjHa?=
 =?us-ascii?Q?Z9RUxOChPfspd7L+Qcnia1rl/vvXAWgePpoGGh4ng6G80ezy7w52MmOV3dgg?=
 =?us-ascii?Q?1tnLeSm3EYkYwnU7rdnhRAq4gJQeCiyoZZfuaItPo4tVNmvjiiNJLGr5riY5?=
 =?us-ascii?Q?iAS3xoLpLNCnLiP0FzsgNY32PIo9AI7o0QbOjG0bg+yWz2iC658YBoiQ9pfj?=
 =?us-ascii?Q?oXhxdhqOZJDQ5jnvAuojh0TsN0nwvFOTacF5kjQuFPnr0+zq9MHfxtLZQhDy?=
 =?us-ascii?Q?fucc5XFkIqBKxftIsrGTcxo5uqb8T4pYH+fvQCiJifMgP/KuDVMNkMooZNF/?=
 =?us-ascii?Q?XKIUh19aVIAn57lYH9f8Hute2pB3SHpv5N15q/u53Uf9ZyD4MRF//mKTMoGV?=
 =?us-ascii?Q?ZGgtgd5F39JttSjihUJiIzpxmceprtyKNWRE6Kc7e/fFt+HGkdq9fTMME36Z?=
 =?us-ascii?Q?HIZS6xMXr6t2evwFGfrbvQTsF5R5yDJkQo6IHHBISu4RATixM7zQkG8pvFcA?=
 =?us-ascii?Q?OXkwHT+6+VMv9Kz8rPlNCMP6Jno3Ix1t3LxEEjMSoJBHz2ztmggLobcFGaxs?=
 =?us-ascii?Q?ajFiJ3/xaCJlt+cAIgDIYdjhw9MX2JGy3T5zIRpJaRmaAX10KvDb4vwPBhTt?=
 =?us-ascii?Q?tyZSxUpDZtGyp/b+zlDpI9xLai8TDZmDftCbiVptHGaQDZWjEs3jCZsEKDt0?=
 =?us-ascii?Q?dKxSREhQsdm/G9QrOlQyIU0JsvNULnpaeEGmPzMLbe0o0gXeO9KOEswfomaN?=
 =?us-ascii?Q?tWujy4FCvz6PcrmkM3psCCvNLmQVyY0MxHTGvMdzjF5+BIlzD4/uG4NEJuBX?=
 =?us-ascii?Q?XC3AnQKItnKhtbYnRID0lCdWvW/Zm6KF62XyL2IbPOh+Er5xC8rRHDx32TPc?=
 =?us-ascii?Q?wN3EuQBMJpHG2AnKPUQTSXgBYjG4dGA/r2xtCjfctGEIwMQ6QPEli4Wmaw/y?=
 =?us-ascii?Q?IS2RieHqLwYLBJTP2EY0nxKvh4EcqT6Wn2cvSkeE6WPg9sg1tQWSSWhHTNyD?=
 =?us-ascii?Q?dbNAwgY6AS/Wf4zUnp5/M3rCb3mVKMBZOszJ91R2gjrh83kuI+B6IBEKAuej?=
 =?us-ascii?Q?31s4vo4BzDjb2wHBBKcyY7Ao23Ln9ZE=3D?=
X-Exchange-RoutingPolicyChecked: Uj+Z7dKpMlbG41kqp0z0hKUQrVn6LUghjEDNaXWb1KiL30eUOy7WwxGbFURCjLJPdIBFV6MpaA0bzJobqkoB4GYRP+GGC84CyHlSll9Bdtr4XIPpsjlbuXrxK5lkjLNFsLTa4jEKtxxN1pYqn0fyJFTWmJ5+gYYMsEdrIAVLdZa7E4sS62EvTAMuj8wlChB0sa0sa0mT1NVVA8sPxm+Wzc/aWuWGqljcHQYmTkcGNAGBa4DscKge724QqLXPrbqr91cLYg0KUhziWJ/15IVpgAMqPnLn7NtRbAh4R9JbMLPaHOhdEyN88FBtAVID1nOhmxUCqrCe3yKkLpMiCZ3IRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 207f935d-5ee4-41e7-1b06-08de88857420
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:39:49.4417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjPF4aGlDavmHOLutXD9L4MlKp9W9hqqP5ocOcfzNOg/J/imugZ/dFxh2mXpdhOofueOBxv/MzAudQEU0N5OasLjcqzVo6RLfNzL95JjT2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9781
X-OriginatorOrg: intel.com

On Sat, Mar 21, 2026 at 02:14:59PM +0800, Li Ming wrote:
> Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
> support 32 HDM decoders. Current implementation misses some decoders on
> CXL host bridge and switch in the case that the value of Decoder Count
> field in CXL HDM decoder Capability Register is greater than or equal to
> 9.
> 
> Update calculation implementation to ensure the decoder count calculation
> is correct for CXL host bridge/switch ports.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
