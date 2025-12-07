Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336A224D6;
	Sun,  7 Dec 2025 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765067342; cv=fail; b=ULwnFFolYYizGnOfk71pkb+2RxVyw15mvFA4a0kybldNreDuxHxV8iN8DdioHwvJt6Z5qJ7EV3fgg/YC2Tnga5Gs+BG98kcsDq1V2sBqHwzxENBigSYa4QZ0FZ+/p5IaMWnIltE2UGtUOcQKmEtmBoJvQlaX7JNEqXPEPAeOIqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765067342; c=relaxed/simple;
	bh=sdyIyxeJfbcNmwmNtYN+UoXxDC3w81gi+S1a0dEEB+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VfSDhc6q1WgTn5ta9lZUVARZBVe0TYbI5awDJsvqRMNnKWDBFCyBCNlp/7wneX098MTR23fxrqEGcD22cbiNr87CLm/++V9E29ROX00UwD3XEU/zB4fmf5CdwLsRTijXJCuDK8z2/3O0fkmhlX4cnmbZI16DuuS7XCn8hf5lYqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpCXHT6z; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpCXHT6z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765067341; x=1796603341;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sdyIyxeJfbcNmwmNtYN+UoXxDC3w81gi+S1a0dEEB+k=;
  b=XpCXHT6zY23E0fcekcG641EkCdx4SZI/k4Ef/jVidaO2lLCHxN0TFE21
   VTGZvUClyQCEElHaQ2W1xyPGL1io1Lz0pBpOKT2UdykGZWDVD9yOMHNW1
   tVNN5E2y1emxqyJjRpQcSVBT2c32Dwnd690niexZf3EPRf3LEWsnQLFfl
   026jm60xSvnUzAeUWIxKfXW0+uIaVcNCXjbc38DMPR6CjG2lQxUvAHUSg
   jYGVV8K14dT8F/5k+3F3OCM7YXqFvKPVFLeWES6Ds0H7e+IpKbgj0pQsN
   dBBe+xzpzySnaR5QoY/2a3ymNnp0esgd1xKDN6hNsld7UtUFlLx1ivie4
   Q==;
X-CSE-ConnectionGUID: tgXzFi+JRcyKEjZuLBrifg==
X-CSE-MsgGUID: gNfwnxBQQ3+2RTAqeM2RUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="66953007"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="66953007"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 16:29:00 -0800
X-CSE-ConnectionGUID: 7/2SmVT4Rp+U/+VJM7D/Sw==
X-CSE-MsgGUID: /7gqHYiCRvKbluJJSc1k7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="200055110"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 16:28:59 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 6 Dec 2025 16:28:59 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sat, 6 Dec 2025 16:28:59 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 6 Dec 2025 16:28:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovWDmsuZL6uSIwxaWqrAU7sXayDgy/OIaZn/LzTVIQsvyWrZGQwvPzby/uYoaV8Sa8q88dUk/6CmZxMBG22Btex3Jq1bN1+k3qPoRiBgVHMifGs0ffM+wjv4mujhq/BU4ZLjiDFC6WHlnwuYNoYSidoCZ4OODHnXpYChMQv4m1JMzk1KqrZyxesFQaYjhjh+a6ZFaYYgQOzQySQNpk7HH8Zp6v44lmq8Y14tl2gjV100l1rvo7iDREh97a84grDDEwk706qW4eSWaVA8uWkEOLcT8UAMKsc/vdyVSEekqd6waeozFJQ5BlhdhnEACATx1BW6FDIwns+G5cQ3hDtIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE2KecAwjoVdJQcfsYirZN10tRBsMgDeUcS1H8DdGz0=;
 b=SJREp8RWp9fIg+Tww1n1VfLtnVC/SsPO9s3S7DMxtscqTINQu8dHAHMrKc7ivEQZ1wnrYQuVE4iui5jLoU98q3Zp5Vly7Vhpm+H4yC1RY/nsrF3wOCIkRVGnS1zNfUQRleKGRdWWe9lywCDmHnWAEvPF50dYwtFy4D8CEcl1rNC7dWxt0Qk4EU/xgs4Gmlx4W1SSwcpXlrIZqiii8UrhqyFp142wTNCmNutFD24tWr4KsUHGnwFKpixwc21XDyVLcuK5F29Jfs6Twosill1m/rONiwQsoSYj5hOJxHGsiu4foKHXposgQQwBiVFRNKMJbFXbTh9edhpGJLECAwu/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sun, 7 Dec
 2025 00:28:56 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.012; Sun, 7 Dec 2025
 00:28:56 +0000
Date: Sat, 6 Dec 2025 16:28:52 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
CC: <dan.j.williams@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v1 2/2] cxl/cli: enforce HPA-descending teardown
 order for destroy-region
Message-ID: <aTTKRCUmbNC9jIrG@aschofie-mobl2.lan>
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
 <20251125143826.282312-3-pawel.mielimonka@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251125143826.282312-3-pawel.mielimonka@fujitsu.com>
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f86f31f-146e-4c6d-75dd-08de35279ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3txO30VCRrphWUpPGCccRaoTrWQngtSBIctXeNwHvL8JifSzcdUrVBKrJO92?=
 =?us-ascii?Q?qUYyc2zi/tOvBpfGyWVn6cZMA31/9k17sxeb6gI2huXmBb8Vuiy+PctVGsE1?=
 =?us-ascii?Q?WIUwh6OPgLRmDkL6C6zdagfX5aggKbD3XqdsNGtu3h+fMaom6eak7nZxeH4U?=
 =?us-ascii?Q?mr2RmlY3Vv63mdRljwChjQvWvgg0gtaR3WrnuRsqJwg9+ysL3jMVIN7Hywqe?=
 =?us-ascii?Q?LKtfV+MiGYg4cPCbcSG3Zr5d5BoPcgFYje5Xmz19JJ2WjIyD3+Ds+lnoASh9?=
 =?us-ascii?Q?mapk438OU0ZmPTKjCfpFRVE1bnD6Xajuhmz9zOk4fRIjp2UKO+7O8E94Enp0?=
 =?us-ascii?Q?HSd4nVxHhn4X9EwMMorcQiJxUYIKowTodk23n+L4MCBP+nojf3Vietp2AxJu?=
 =?us-ascii?Q?SIRUf+waPi1NNsU/0oSwulsSRNJRJIH6QNLGpAQXUN/k3lWxqih4qeP5QQBp?=
 =?us-ascii?Q?JeXtB4cw271XnRXZpx0Zi01Uus5lyL6u/D1XcMgMF657uXKBq+fTOAPI81zh?=
 =?us-ascii?Q?ocBY7KBaloTKlW7hetkoU1mfxkinR3mDreXzMWdc7Vtn00FPGOCF+0Br+T2S?=
 =?us-ascii?Q?qq7NVCRynptD3TMsPeeHspHyNOyL/WdNLgr1HP18iadLDQ4oawxOGUtTBmfd?=
 =?us-ascii?Q?EJhiy3L3ipY1gwV+9sOVKT4lWvkxpJaOIseaCk9cYFV8lArSZvzflmGxp8LG?=
 =?us-ascii?Q?Q81WacE1hsewHqlC6Dz7UwT/KCvR1shqBjbEnfkcZQ/YLpF4UzyrsdZSwonc?=
 =?us-ascii?Q?Fczq+PkBJwofMF+cnSvf8tUnDLHeqjegtIeoVrTFxxhSMr4TMi41ReUnOs/i?=
 =?us-ascii?Q?YbJy/xUDLUx1/6fQ34fp/D4u4MbLobeqenHngUMic3v/PL5opmPBpMtoY5DL?=
 =?us-ascii?Q?MF/qqUe839viQZi0wMrSwl4FRLAZzDiMTPuvhptLF8Uev+bDpxPmE7FBcSiN?=
 =?us-ascii?Q?62DNReQCIZ1sM76qmpGAXFf+EFuOaPAgbAbEyBOzeEHYRmWuQqlFTJDTDFXL?=
 =?us-ascii?Q?BneEWnNigYe3hT0yExGPpVi2yAhh5rIvO/iuVnyFQqWnl/9YYXit77S0Mutc?=
 =?us-ascii?Q?iNHB2x3AN2UCapaPbhdyzpsd45OTMxKbeAdQ3pQ2TOHDCMDQbEPlWBN6wIuc?=
 =?us-ascii?Q?rlhD3EsW4rNm9lPdNzxM0fl8UEGlqhOPU6evX8QV3D4d5JfmLqKvdUUXZ0ju?=
 =?us-ascii?Q?l4JHihaXqHkVxXR6F9AKgZCXXbfd6Zzk7oF13EiHUyfeOQikpJx45svjSPG2?=
 =?us-ascii?Q?XAhngHyRzOKfHXrR6Qj1qv5ShC7NDnq9rR+sn0yeCjZ+iSruya+8yv712AB1?=
 =?us-ascii?Q?MOaxqiMQA98VxOpa+oBbO+cfVLlB3DknP4GKI/3VgI+mBQldsBbAvxHvCOPo?=
 =?us-ascii?Q?7stFh/3B5G7QlxAuBQ7Rb9pST7oKCcuhX74XUJX7EB9O+AT4nyLd9T0BK+t7?=
 =?us-ascii?Q?BCIcs7mSj2f0rJLoWzvofVt7JUL2RssN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K7YMZ5691ceNiRPHtyD2b+7LfO2BsDIithTjncstfg1Wnys9xJihsLUtdwyF?=
 =?us-ascii?Q?gAn63kWp/ZoSlL+NwDDW32Jx21Q0iqw9klHdWD/jzhMpQyHQjA04UqK0lxTR?=
 =?us-ascii?Q?U/a0HSIl1EJT5loTx/N34KIpHGwcILgyqW1NwtS/41m5OClvSGy1m+nBd8UG?=
 =?us-ascii?Q?TEembi9meBNMyxUf5kW1omSqDOHOs81IilF9e5N2ltARRrAGZW6y1xWsoWgF?=
 =?us-ascii?Q?illvpus2Ds1rf4osOby9VC/bcCS40WbKVfSTjBkg/Dd04fZwlX/epvR+G329?=
 =?us-ascii?Q?JOOP77vifhWdTXxQcIRf6ndwUbxEEYmV4Btg99BrdrDcFpWaweKd4qdoG2a8?=
 =?us-ascii?Q?Ahn/ZanrpkUUXhrKAVPTNUYFs2Tc4DoBslE35qyvnqC2SXMTCrrQyCx4Aji3?=
 =?us-ascii?Q?UHDN9JW9nVVsZOaAp6X9HBGQdIzdMSQPQ0PyFX2Ww/5xcwctxQz/DdlLsD5A?=
 =?us-ascii?Q?AZP0+8o8wTVveKxJwTaEwb8EIx9Ei9jAkWqG2qC2hpn0fATliTDoOhkvuyTv?=
 =?us-ascii?Q?1KF6CQnLTGt1sUpbt+U2NFNekFogYZYzxr5c9zA29qQ/mGfn/Mx2AqIZ/BuN?=
 =?us-ascii?Q?kD5uPLPe1Rmz7LKY1F8CBvqF0BUeYww/hIPV/egkP1z3Yc23uxg1u/dr2JFt?=
 =?us-ascii?Q?0DB+o/g9pCE9IQmG5JtFNoDGV6LYY86jCe30173wBPYtN7ufZT9u1+qc4PV3?=
 =?us-ascii?Q?pFISkhqsYrofg0gRgZYwEvxDw4CJSGJNdEu7f2gbKihvAC8ngomeaMHS8MBE?=
 =?us-ascii?Q?e07IERkyqLtLQCQrNmN5ifHRUtqVosS6MISWIQYVjOM2Gqvjd71/4Wenhw2D?=
 =?us-ascii?Q?ljnYKZi2mbtqD6rigaSf/AhgEdyTDFFmV/Rec2vKLjXYGKvW9kGNvIsmFVZw?=
 =?us-ascii?Q?sUW1cKGebHO2BM+KMsxLYLorOGufpSDwz0Z802yyKkBKgdmpvDs3VAZsUBWU?=
 =?us-ascii?Q?hxAx07xnMwgLg24M0VVGQbccAa26v4+yeY15nDiTA2p5gFtaLOkGqpi3P7ub?=
 =?us-ascii?Q?2LgHgJPB2ya9Fg4gHcmp1+SBTnNeDzwy2OLveGsaTQKRyj9tUjYOb2uVGO0L?=
 =?us-ascii?Q?gH32RpAH3uFPiUOemAxxiHqWaz/HqgLipS5jtn/nDM8JXILHXs6tem22xU6A?=
 =?us-ascii?Q?CxEBoyntaRJdEaRkfaihnptqtndrcg86q7pxBWv5GeQrJFccg9NkCSh7ueOS?=
 =?us-ascii?Q?Cm7okkNtnQBXtUjCDT742XhSD1qV5P5V/EUaJPEDnAYKmz6Qo/JjonJmWYNP?=
 =?us-ascii?Q?m4G+Qdo8zenGQcikkQ/TAAMqVUdQea3rLtSvgaKVlyZhk7wo5qP5643pTT8k?=
 =?us-ascii?Q?iMuKuZNgi53piQpTEBQ1BNkFeHMJOnmHRNESSAsYwdFfVzkbkLeYdQlA9q5u?=
 =?us-ascii?Q?3QFKPOpXC1evLDAqW3bHCYpijRdA6/W6vX+mOM76zPMH8b7s/vyxUOCSv/DW?=
 =?us-ascii?Q?DwjUeXYU5P4ChRFH6lzFyA+PPoY3BCY2EEaStLSrPExUKzbbP80+0EAV2AJ7?=
 =?us-ascii?Q?K7WDCPIHzeklkDGTmrBDDWIv49XdTm17na+j2rs5f9LevlJRYiOWbLYoyO5b?=
 =?us-ascii?Q?rwrRNtNPxm0d9mmFP3HNgahppBewPIro2AVpoVR8sN8eiXaPUVSYhxvVoOhw?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f86f31f-146e-4c6d-75dd-08de35279ba2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 00:28:56.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvg2TN89zXZwL7tg8AgiTDu38lGXAdDhLfKRrxKYmIbIuSNQTxjPzhA09up+nDx4D3wjqoo+cjbJs//HAg9iI9+2guOlQ3ta0FZHfz73N7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
X-OriginatorOrg: intel.com

On Tue, Nov 25, 2025 at 11:38:24PM +0900, Pawel Mielimonka wrote:
> Implement destroy_multiple_regions() and bypass the generic
> do_region_xable() path for ACTION_DESTROY. Regions are collected and
> sorted by HPA, then destroyed from highest to lowest, stopping at the
> first "matching after skipped" to provide user with better error log.
> This prevents attempts on non-last regions and aligns destroy-region
> with required decoder programming order.

Hi Pawel,

It looks like teardown needs another sorting layer that accounts for
endpoint decoders.

While updating the unit test, I used a configuration where a memdev is
targeted by regions under multiple root decoders. In that scenario,
the 'all' or 'all -b bus' teardowns fail because we try to teardown
endpoint decoders out of order.

Appending some debug output from the failing case. Regions 5,10,11,12
use endpoint decoder14.4,3,2,1 and need to be torn down before region3
which uses endpoint14.0. 

Also note that with this config, a cxl destroy-region region3 should
fail gracefully with an out of order message.

+ /root/ndctl/build/cxl/cxl destroy-region -f all
cxl region: destroy_multiple_regions: DEBUG: Decoder decoder0.0 - 1 regions collected
cxl region: destroy_multiple_regions: DEBUG: Region[0] = region3
	[348.871669] cxl_core:cxl_dpa_free:567: cxl decoder14.0: expected decoder14.4
cxl region: destroy_region: decoder14.0: set_dpa_size failed: Device or resource busy
cxl region: destroy_multiple_regions: region3: failed: Device or resource busy
cxl region: destroy_multiple_regions: DEBUG: Decoder decoder0.1 - 0 regions collected
cxl region: destroy_multiple_regions: DEBUG: Decoder decoder0.2 - 4 regions collected
cxl region: destroy_multiple_regions: DEBUG: Region[0] = region5
cxl region: destroy_multiple_regions: DEBUG: Region[1] = region10
cxl region: destroy_multiple_regions: DEBUG: Region[2] = region11
cxl region: destroy_multiple_regions: DEBUG: Region[3] = region12
cxl region: destroy_multiple_regions: DEBUG: Decoder decoder0.3 - 0 regions collected
cxl region: destroy_multiple_regions: DEBUG: Decoder decoder0.4 - 0 regions collected
cxl region: destroy_multiple_regions: DEBUG: Decoder decoder0.5 - 0 regions collected
cxl region: region_action: one or more failures, last failure: Device or resource busy
cxl region: cmd_destroy_region: destroyed 4 regions


-- Alison

> 
> Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
> ---
>  cxl/region.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index 58765b3d..1bf1901a 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -950,6 +950,57 @@ static int destroy_region(struct cxl_region *region)
>  	return cxl_region_delete(region);
>  }
>  
> +static int destroy_multiple_regions(struct parsed_params *p,
> +				 struct cxl_decoder *decoder,
> +				 int *count)
> +{
> +	struct cxl_region **list;
> +	int nr, rc, i;
> +	bool skipped = false;
> +
> +	rc = collect_regions_sorted(decoder, NULL, &list, &nr);
> +	if (rc) {
> +		log_err(&rl, "failed to allocate region list: %s\n", strerror(-rc));
> +		return rc;
> +	}
> +
> +	for (i = nr - 1; i >= 0; --i) {
> +		struct cxl_region *region = NULL;
> +
> +		for (int j = 0; j < p->argc; j++) {
> +			region = util_cxl_region_filter(list[i], p->argv[j]);
> +			if (region)
> +				break;
> +		}
> +
> +		if (!region) {
> +			skipped = true;
> +			continue;
> +		}
> +
> +		/* if current region matches filter, but previous didn't, destroying would
> +		 * result in breaking HPA continuity
> +		 */
> +		if (skipped) {
> +			log_err(&rl, "failed to destroy %s: not a valid HPA suffix under %s\n",
> +				cxl_region_get_devname(region),
> +				cxl_decoder_get_devname(decoder));
> +			rc = -EINVAL;
> +			break;
> +		}
> +
> +		rc = destroy_region(region);
> +		if (rc) {
> +			log_err(&rl, "%s: failed: %s\n",
> +				cxl_region_get_devname(region), strerror(-rc));
> +			break;
> +		}
> +		++(*count);
> +	}
> +	free(list);
> +	return rc;
> +}
> +
>  static int do_region_xable(struct cxl_region *region, enum region_actions action)
>  {
>  	switch (action) {
> @@ -957,8 +1008,6 @@ static int do_region_xable(struct cxl_region *region, enum region_actions action
>  		return cxl_region_enable(region);
>  	case ACTION_DISABLE:
>  		return disable_region(region);
> -	case ACTION_DESTROY:
> -		return destroy_region(region);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1026,7 +1075,12 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
>  			if (!util_cxl_decoder_filter(decoder,
>  						     param.root_decoder))
>  				continue;
> -			rc = decoder_region_action(p, decoder, action, count);
> +
> +			if (action == ACTION_DESTROY)
> +				rc = destroy_multiple_regions(p, decoder, count);
> +			else
> +				rc = decoder_region_action(p, decoder, action, count);
> +
>  			if (rc)
>  				err_rc = rc;
>  		}
> -- 
> 2.45.1.windows.1
> 
