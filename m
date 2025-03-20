Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3217A30E;
	Thu, 20 Mar 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495242; cv=fail; b=JjsM3BXzOUzZcZKqQpM6BDn7cOQLmt2quf9b+P5l7VTqdNxVyLs1DhbfPTSdU0CuHQAUOZVo5jMGEpO8OEvQHUVYblHjdviGIZE85yU7pSKJuLqTSwgH2LFhqzP7+FIhthUrMn3p/6SOFZZwS0jNqqg9j+3etXBDclz8vz7ahxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495242; c=relaxed/simple;
	bh=uC9Q9iAuUDGt0IfPm6sIK2LOEvgDq95Y5s4MH5BGhH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WenqSlq27x2fokT54RVW5shzVxAf8WAKV3MTlcth3WzXao0qMakTEaa0Fn5GaEaWxWzo9jgTceRkKMah7btt8KHCkaEBng1rLxnz9XzvKR/W2IyXkRpDoqVG3eLRPG7yEi/pMmk/6Y8KZyf+jHL1bPVq9XUiLNS7KDQGkpTfm1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7/A0iNl; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7/A0iNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742495240; x=1774031240;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uC9Q9iAuUDGt0IfPm6sIK2LOEvgDq95Y5s4MH5BGhH4=;
  b=K7/A0iNl4M6QTl64R2RMCtkkum8DotziTO077MEEVggP3wJEx/0XlDHS
   AjgpeOX9LPSpkyMvL12tVxDBNbkteeXxjAA51jLxJAClefA0nb2XotJ32
   hcwij1iPVG25QSlfoHywzM9fsQjH2Nkfj0pSDEDb+AcUdgVUmsXo8dLs8
   bDfYdaVSJXb5vpJo8AWJfusdtVBgMbx1ExgWpsNmPzr/K+dtujRXodKyC
   OMK8JObf6RIOr6XbbfzXW9CMxyT3P6r6r7chRY3YklJkrb0F+ZpLNuvRc
   HXGx5x9BJgWVEkjMXGdPSF75IkJo+2q0lGWGDgEIEi+/mU0oezkz0QQYv
   g==;
X-CSE-ConnectionGUID: l5IvRz02QPuGcFB/CsTsGQ==
X-CSE-MsgGUID: mj5X/BIvR/movOM5DZjn3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55130905"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="55130905"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:27:19 -0700
X-CSE-ConnectionGUID: Asl/cvNxSW6apiwtyz/R9A==
X-CSE-MsgGUID: dE9ApT91TNKAjZpHZspCBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="128284909"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:27:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 11:27:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 11:27:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 11:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQXoK6t2kltFqz4NEem4K7E2XgdXstNRIM2otau+ss3pcC0YAb3b3K6AweKtRIeCvl3PWY+Tqt3Sq/dTUhcZWReEOTlab9f6PUvbajJPFDyMZb2XpzSU6xajcoyje4iQZPtqXeqQVwybK1joI37kLQPlhaY01FyGgjAORrFW4T6ALHjMKwo+P3uViwPGnHzX/b3Rx8rXzFx26GKUJGP4CYmTLDYKN1/OTl66e6OuQmGOhhgsGaY0ymo2dZG4Ex0RGsOtIDWLTVAgZP2+PV99C4/creHyRXShArwvHefGV8cOaI1BOTTBK8N80zYWyxIPUdGh4412Na39VG6Z1KM3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+75liLyvO5hhWzUt6cKHIDCbfkACp2Hp5K9qpjM1vLc=;
 b=x7YA6xcVle6rPyOg34ELu7VkuzYAstwpI1Zrh5Mksps9k2lH0xbFuc2b7nCLd55kA9gzrAkT+S+oMzLRB4PD7o+4BLJwuv3+tPp30jKSAbbP/7yKYE6LNuwiWfVVnwfk5cTrmQpxG+cDkgSqOb7aNju0GlbtBCG9sdhFo+tS4Ro1Nn1AmkGeblgU47inyB+DA0k3iwo/szl1zmqvI9qa6Cg19RYCJ4A6pIG4SJ9ZS0hmsPFpMI3svGzpmehgloSPLSwcabvu/APhLMi4asOS0NclnZEWwcVi3GWKNk7R3uqqm3zNcmkz/xVEoltGF9yPoJPqGrf1zJi0k0/LYGuBNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB8862.namprd11.prod.outlook.com (2603:10b6:208:59b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 18:26:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 18:26:35 +0000
Date: Thu, 20 Mar 2025 13:26:51 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH 1/1] cxl/region: Fix the first aliased address
 miscalculation
Message-ID: <67dc5deb3a5a9_60ad0294b5@iweiny-mobl.notmuch>
References: <20250317070124.815028-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250317070124.815028-1-ming.li@zohomail.com>
X-ClientProxiedBy: MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7983b0-7fbc-4d40-a42c-08dd67dcbf23
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jUG2Xs4zpxryDQeVVSZpF/fbwPNI93Py9ympQDOAmzI1Xq6Ie/43iKco+vn/?=
 =?us-ascii?Q?rUMp5B2FuzZU7ICUcN2KgVL8KKjExPvKzLMisHf0LumlvYqELov2PemiJOo4?=
 =?us-ascii?Q?la4fZnSSQ1hui8eXQsOK011sOspEWitwg9iiohEEbSK1dJQF3sSBddu7ULoV?=
 =?us-ascii?Q?i+MebJOUIc5fb4zscr1DKaA+cxSD4biJcEIZiMgXdJF5syC/SosFr35gJ76Q?=
 =?us-ascii?Q?6zb3GWQVdBiVyTvmoR/IfkGMbN57XmUZ+WnxoNetQ7864V0r9qGEX9YI/6U2?=
 =?us-ascii?Q?NnuGWRycm3fTa508Zc45xWF8zR/9C9Es5t5GNtyH0sMntPBDurY2pENTPlQO?=
 =?us-ascii?Q?KoQWEUt9I2/TPjArh6Xv+jUVRiEaoyoc7qxFLGaecmV/zaXjcp2pOcKQSTw3?=
 =?us-ascii?Q?hp/SgR27mEWQdNJMBPyvrdvZyUACNSyDiNfN1rMPqU5/boivIDkWXJcGkZWH?=
 =?us-ascii?Q?MNX0oBF2g+z9Ipx7aouqLQROR1aTOcu52PO2ytFXbk/iUR3H9Bu3oUJIGVBk?=
 =?us-ascii?Q?WbLBYeTB4p45FVD03WiFQ63UX8ChcWlNFHSJNmxZDUQ/Cpkein+GX2FIbDaS?=
 =?us-ascii?Q?kJgRMAXCU3Pdo3seBSyy6LgMFGb9d5rR168X+a5FBC7BO/iO95ryaNSUfms6?=
 =?us-ascii?Q?UwPXY5LPtLAybEmq/J3ZsiJFwnyMTeH4DxM6jYft/btSxZqDzu4LjNTwdC27?=
 =?us-ascii?Q?zHRbV+MoORwx31UP9Bw/y126yXZM+hb/o/ju8DlluGlQznkVBJoZQApJ3qX/?=
 =?us-ascii?Q?ybzVehORUAvF4UzjtMENbfT9yzXvznc+NOs3z/sSKboxVEx0kAvn8THOeoAo?=
 =?us-ascii?Q?YF2428xOOBA3rojUf/1kNii/cQ+gy94x9T1m4jvum4ggGJmtWxTuamRsZBH0?=
 =?us-ascii?Q?Hm5PIDM2lAI3jh3hQribZcbl0cLFuPknEFl+pRWOSUe7kaWjzgOn6V9Tl8wi?=
 =?us-ascii?Q?8Hbrd25HwpnD91BZokiiupM0e11Bhaisj/WUm2W8PR91k5t/+mSpP+WKr/iq?=
 =?us-ascii?Q?zcCDks5Q3p6YSBifCZHxqNk8k5Krk51q6UjliiQdGWQUzBYOzZsY+Xi4P7C8?=
 =?us-ascii?Q?dmLlNLrtWR0QjCrEZ+ETt4nrc47sG7iAgJtxtOjQX8G1dsOMm3g0R2QV+U0t?=
 =?us-ascii?Q?MRrvzbluSKppM9cYQIZnF4peI+bMqVBck2rGOPxmT6/zF2MBbO3yeRo9+CDo?=
 =?us-ascii?Q?3JnBBPeZYSiwBXqE1J7fkcWZo2AeajBL8GdbXdyM1+tw/XjcCirfvuyt4BxC?=
 =?us-ascii?Q?E6fFO/AKSsyyAQIY0WEQR80cONpta94/jfvsd5KY1Scas0AddZnnjNH8jUwu?=
 =?us-ascii?Q?jJ8Yd4DJ7CbszEY6ZcOzknpH6BjzGagXuq35tnwmoKCpjF28+v5gnACt6na4?=
 =?us-ascii?Q?/2L5kfXxxdFAkmvhKRAsUkmt9/PV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KKQegfUaRqs3Adx6RLHhRzFDpiyMPJ8fELYELRHF3ZvOThqkvtV7ABfJKY20?=
 =?us-ascii?Q?3bA5dppQfIefFv769QWSdlv2/+yazO5K9YsAoE1ZPUV9ecfo2+xQvyoieNe1?=
 =?us-ascii?Q?Pq0IYV2AG3tGcLxvFGHVlW8QkQigtS4PdGaCR9a0n0cdWQbKr49NBhb1j02/?=
 =?us-ascii?Q?DnWs8NnXq0llH/ejA65cSiuSdYeIE95uhmZj3nRC5nuqhAYaC4KfxO6c3sbg?=
 =?us-ascii?Q?s5bi0YGnk07rrOJ+HZRqkPHIN61LIaYaivx637n0Cws8815VRrircpvLHA84?=
 =?us-ascii?Q?nYRM9m23JGgjuXNoKLfSHqHNL2FkiG2AOB4EFNay/9cjpb9IEkN5lHWWW93D?=
 =?us-ascii?Q?qy9ygylAa3Y26UJH3Dkao+iLy2er9Sez4Tc7FkoLPOSUpcFWCCkI4XwAj/2Z?=
 =?us-ascii?Q?tPovAXgR11zSzq/5/njD5kkqdiD2pOwcxRx5FXFhUr/rWXfd87XGbkcq6Kut?=
 =?us-ascii?Q?bwnYjeH5KHsNuSOm0tOLmQZm2e7G/eZLTIIAqeSP2pi1Xf0mvnZC3l8zEQG6?=
 =?us-ascii?Q?T3JyxZAHeCME/AQO2cj98fSaaDAdkMg4xF5UoQ3jODO1KoIaZrDJkBQToOqY?=
 =?us-ascii?Q?G8dFRRVk/pNBhNuXkFv+v+5jOfpFqu90PbwCt/mnvU+urrGHlA9GtVw3MMf0?=
 =?us-ascii?Q?GQFX/nIV4Aw8Yv+AdPoXQKLXQEQp8xsIOQmLufgIicwwemuSDAfUD8AsV02i?=
 =?us-ascii?Q?CewRaZ2TzIEwD+vpFuddcAXV76e/xp6DHHVCpGry72lhRGUvfqEfo16T0h05?=
 =?us-ascii?Q?rCrOiydk9+q37wuuG1w6zCE5T02i0513JGrx8z83YO9AvID98BC6h12Po0Y+?=
 =?us-ascii?Q?WnQtXJtQ4O8SvVoGTwpcBYkF9R9CMteFljEXVI+DSW0PL0MoxUNLZmUbe3Hy?=
 =?us-ascii?Q?bbOcvoGTu/nLU+kJDwtUeIuMrzb3391JdbovKkLQf2/4ULEIUjvQNfY+y0AS?=
 =?us-ascii?Q?sJbz+iTOdxAqX2R53vgkujGa9np5ozfnnfirj0QT5w+Rnm09UnGWwCmZIorp?=
 =?us-ascii?Q?RCHjtl/PWCy82nP17Hx2gHdyxAMhxyu74t0HMMX0hc+6QTw5AtNzEk2unmIo?=
 =?us-ascii?Q?7mz/Uy/ycUFq44f4iZGEpzPckDD6+GxXOjuoZ8p36tQfo02aw3pnLuVsHZR4?=
 =?us-ascii?Q?/SJDVlYxxR6C/rEUKdsCISXRn+cd6UqxTGaaY2j1Ff2hPOARFuHQ6BU7rOqU?=
 =?us-ascii?Q?Nh2bHqBpXaWjh2P2W6YMD95lE7dhYECFS+CRFjAZW5DmuYJQ4whM92jvA1/Q?=
 =?us-ascii?Q?U28G37lMOCriPgc0WLBfHdArdTmirpryx5W1c3aHUTQHzhXhyA+wJHSM4thl?=
 =?us-ascii?Q?fGk2oZINioTaZjHIzBuPz4SUfTiqTLCJ/2bFbbaTK33mFJVeIz22sKUgZWOQ?=
 =?us-ascii?Q?cOd748n26mQYM7eVNHc7dDi7AcCVcxmNc7x73Q7Z6I7ur41yHYzL0ESoIzZw?=
 =?us-ascii?Q?5EXjK1elxUOcyHb5jw5r+LQz2NBP1g5TM38COcmboMHrjWLPGwvEhrZC/dIY?=
 =?us-ascii?Q?FKf84HtHYkOGboh+u40V91sGwXKqDg6bfLXvHDMdWV8xNRWgsDbZTh7KmNRl?=
 =?us-ascii?Q?eQGG3/8hZxrtr/OSztQA4An1fg9zD86Bo/CMjQOI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7983b0-7fbc-4d40-a42c-08dd67dcbf23
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 18:26:35.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+gDmPVgRFILY6cJxLHWpu7Etae25VT9T5CHmwKes0a7eO/+H7yNXBDbfR4QKm9H1vsUqveLkk5ZnHihPUikFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8862
X-OriginatorOrg: intel.com

Li Ming wrote:
> In extended linear cache(ELC) case, cxl_port_get_spa_cache_alias() helps
> to get the aliased address of a SPA, it considers the first address in
> CXL memory range is "region start + region cache size + 1", but it
> should be "region start + region cache size".
> 
> So if a SPA is equal to "region start + region cache size", its aliased
> address should be "SPA - region cache size".
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
