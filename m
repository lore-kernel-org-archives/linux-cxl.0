Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94F3469E7;
	Fri, 24 Apr 2026 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777067854; cv=fail; b=Cd7nb1Ekun+/BEV51hoatsEG0NDgM/yRqcBUAzlqSO8ngGq60d8pEhfD34YnAU9bc0pVSorqsFYiq/Vu8jNlIAiFO6+LCLCYUtRGNgch6XztVNVS36fjcx+1H8d4ZxBJ9zRYi9f3OCZ/sZNMpRqDyDkt6Eb5QB2THhi9MVm5ysU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777067854; c=relaxed/simple;
	bh=eWPyW6EaezPrFvIo8hPH9zqVA8a2M7AUqNPRB670SCg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7QQQnIuuxsaK2kXL7t9TbHcFZNlkXuIEAWh/1i/8V/5dHT2aHNy7sU15K5LD2fAoyvQ+Pc592/eoDk7nrSnaiXXQs512un0rmISqN3c8O4Psz5pvoihuM0k8Td4zKRSGuX0liFVeZcz0fmBP7e/EVYUvoV6x0hEdoFs0eM3b9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeY/HwWh; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeY/HwWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777067852; x=1808603852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eWPyW6EaezPrFvIo8hPH9zqVA8a2M7AUqNPRB670SCg=;
  b=KeY/HwWhdldVgQ+SytXtCBaufOaJggVZcEMzgq7mlHy/EGooVh1xvRlm
   9xrfPT+3ZIwS523yyNPXylFb91aYDfrL0JivLDJYEu6RcD6nG1zw4ID2S
   TWwAcElSxiZJY8pun4dYx/cgxGr/QGq5j7BPKPmXFKO7sCM5uRmKJGI5U
   BaTcA8ySbbYeaT8aJ7QW8MhM/leQtTMrdzG3BQD8zSs+LGrOafblMgEN7
   o3BKGK7YXSz2/C8+yn8FEERDIFwOpYTG1S9NDzfOsK0CjvBNrvjb+rmuL
   vqrFAITc6v/56utqH18WfBqyXs/1n3StzHwuJ5eSkihTNaK5O12b+RoLu
   g==;
X-CSE-ConnectionGUID: 20qwJHPiTmm5QhCJtyQHJw==
X-CSE-MsgGUID: 06w8th7ZQGO/sTL+qmg1Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="65586617"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="65586617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 14:57:31 -0700
X-CSE-ConnectionGUID: c8rIN5DqTqaBBXY4Ki+KTg==
X-CSE-MsgGUID: NYMO7XHXTYWzkxqjJvf8jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="238135945"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 14:57:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 14:57:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 14:57:30 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.35)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 14:57:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2tfZKh/zmssKRQ7boskjgrV5aNwFixaDzBROJ0GdhXF6r8XlMLM54dkDK3yzyEoZtMtCtwH/wodUAlOj3ahEQWHtgAmgTSTmaH/YDcED6UH18/3Rbv7ePSxsM/S6r2WlNc6e4GQFKjFPuJNuYyJ725Pj4C9NJOaPTpVm5Bfv5NuG5V8wjY3uZFuhUi6iAa/YZwQOviw7asUmpt4VS3mSPtvtQLdPW1nMXYMqebbfgP1LSFEKPKumUFfpthRJK62WmNDdl3M1IsohWmsYisiX65Kd33tVNsM/c5IT1YZ6zNV0UzHQ0da2AFasur61DuQB43YG4Td3dx3VyMWZdhPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBj5nO0cyc9uy0oHNBCFmr7voaW4YKefovnx3uMoqTY=;
 b=mleA2XRKfvegUxj9h/d63E82gYPBIAcp3L9vdTO8qypyo2iF0G9MvVZ8XzelOuR84cv3KJl5fKoSjIa4ns1zaTf1/pWDcOLiZhao3ALoZdpRSmWInC0trYvUNRe7rWi1sdaHVWsv6fiPN7/KzR2WiGvAtXVKO7BdopzTEnyMuEo8JbLqZOWOVXZM3OoaRUXy9dzh9V6Qvp6BIZ0IldTI1BcdXW2K0Em/TPXlno1/w3WqxaaKdNSo6ru32rkhFCGbv6jng+64x/xkoqIi02XG04AIiPqYwQ+bmy8x46Bs0Azf1lnepL7USHZf+usE1zacjkAHXJRNz+zGiH+J7h7GrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA4PR11MB9036.namprd11.prod.outlook.com
 (2603:10b6:208:565::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 21:57:25 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1%6]) with mapi id 15.20.9818.017; Fri, 24 Apr 2026
 21:57:25 +0000
Date: Fri, 24 Apr 2026 17:01:26 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: John Groves <john@jagalactic.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, John Groves <John@groves.net>, Fan
 Ni <fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Shiju Jose
	<shiju.jose@huawei.com>, Robert Richter <rrichter@amd.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Groves
	<john@groves.net>, "dev.srinivasulu@gmail.com" <dev.srinivasulu@gmail.com>,
	"arramesh@micron.com" <arramesh@micron.com>, "ajayjoshi@micron.com"
	<ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 1/4] cxl/extent: Promote cxlr_dax->region_extent to
 an xarray
Message-ID: <69ebe836a8ea_bde13100d@iweiny-mobl.notmuch>
References: <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
 <20260423235158.3732476-1-john@jagalactic.com>
 <0100019dbcc1f7da-e3c5b4b3-6505-4dc6-9952-70a4676cbdb6-000000@email.amazonses.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0100019dbcc1f7da-e3c5b4b3-6505-4dc6-9952-70a4676cbdb6-000000@email.amazonses.com>
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA4PR11MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 74592ea0-56b6-40e1-f307-08dea24c782c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: xAda8EmQCGXoaQXvAtevtq9q6X6+WGrS1N+IZiJYo9RmHKtXDUyRHwbpgqZJy9mOAx1tkHxtax0P3tv/GCKUIMFbsSUk6E6HZgHhbDUYf8EWh69LCD2w1oS9uDUPF/6nUJa7L8516FP0PL2ypJY+c2mRMurbvM2yMwBx1/x0LmDzEz61MXwA7CNq/CRjeitJRvT1cfXR5U46Yu/TuZGgECNPKu6I/hV9SDVZmdbuQA4Ybugd3W8gF2o1W8TqygFljyWZO9Uh1/hHPg2ykSBhrinjIr5EFpxn8GYogBtCj9ZFQSBWR7xQTUWbH8zGKE+T1VCO91HTtN/1YZ/AEwds9rDDEoI07fDQ1M+Ha/d2p2zPYOKtEQ6niKMxV356QU7hRRL3LR1rtcLljABZqpQnkXugiL9LqqAXT0imSAlpjFClCdz/EN/lCmJJWMjwmktxKvKXaF2FfVgWsdjHqDiH2uUecWzLzfhkyCLdi/trHomCHkc5I+mLUNUaNlURAInPmf0QKYYqdjyoC2Lvu6YGv+PX36f4Xn6Zs3pG7Znz92y6oMTa5ZRUrW/ygwrCmGIhbNcd5OI+sK6qkUknfPGZjeDbIkOpEYHMGFwev+/QDzXmLIzF2MW4wesqfkHuJhGZvIEjP8YHfTNXXwwUF2R+SPe0F5em9PGXLR9rC0taV/eeFBQ61cJsy5nZqJix/lSyiH/8RcO93oiqoOkRJ1cTcYDx3aZjVFPWAUSjectXRoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MxEKZJ+quDgN3aPXRWVNRyYuDem+uroHnWiv2NyNNeorcq4sMaHhMO3JgJmv?=
 =?us-ascii?Q?On489mtoQzcbPT06bN6DtDQN41ZdXBkOgPOCdFa0SKoV8Iv1XWVVQ1PpJqjp?=
 =?us-ascii?Q?4xGFA4thbV2jZAL1B+K/kKiF2Pi2Rx8vG0sDoWUyc5DizyTQ+k+7bMcntJtE?=
 =?us-ascii?Q?73sKZTpvj5MdQvxxx4DRf+ZUupOIvdlICr1gpNyCu+TZKWlhLLNUgUc6MpjS?=
 =?us-ascii?Q?iXTGe5rF4eEr6RFbJB+pVA0jjir/WcsWLUMmmSNP3iLj683kx+AO7muyw9LQ?=
 =?us-ascii?Q?3KoD8Wl3+haMADEv00xyiKwuoHbvsH2HPYH0S69xaUbtSDuG6Rlup80aGNiU?=
 =?us-ascii?Q?m+4PdPSLYJ0htQdikuJsFGAtjWuJYk1Y+lsx5hxYzCMqVCEjJ40sLTKIqUjW?=
 =?us-ascii?Q?xrfIo+0pAv5oui3O3tpbKOdpM+zPYKhGKvm/W926nTMuLfrWM8MekWXDlk7h?=
 =?us-ascii?Q?pe/3gn3ZBWfBD9Lv3itsnfzj/5b3VnPhYtBmJRc+YUcyMXCgvU7VytXvstjF?=
 =?us-ascii?Q?BK8oSrafEI+dZkYCk+JIYaRh+WqfGyC7IMuDl9kxbXz/BBAQRS4H1Sg6w5Iy?=
 =?us-ascii?Q?shfyxEv4QaQF4sTia4fJZjU2uB2od95E+sD1d/M7ruvr209mGNSbPI6cG/7/?=
 =?us-ascii?Q?1w1Gs3a4iPPoj1ddt3Kjhb9tPRu0hYJo3HUME0QY7RspbfVPhfCDTApltCDW?=
 =?us-ascii?Q?Lr/A8nEhd2vFDxHExGcWtnSwxa5yTbWwu4UMgVRalikGC5ad9X3jD2UhiSWe?=
 =?us-ascii?Q?0AMQQdvqvWl0GdVBJ84AaGXGS65bfG6r1W9AvYKxWknYS3cDbU1nsZptOJdl?=
 =?us-ascii?Q?Apz1DHnOfEjR2aer5j4r6o6W9KA6xXtVTm+xx0aSECsvJ2TYglMRVjLV9qBx?=
 =?us-ascii?Q?vxv6J4AZph7evDORTdggYDsEkN+Wl0KX8Hzq+fyBC2J38c3eeHgCmRdtYOLn?=
 =?us-ascii?Q?iOKVsY+uG5GgRSMXUVqLSql9t4E4lAOofy1HcFjtYXqxUjeMB76w7qli2Rp0?=
 =?us-ascii?Q?fAI9qSwilJh7KS2BCJM1AoltkX/cyvxMAs3qTA/CC+oquWn3ns1CDdG7fHno?=
 =?us-ascii?Q?qoIHMaedQlIQ0l3A+yJuf5Nmh+m2/cWn0+8SiA2No2beaFFr5zn/LWO7Vpl9?=
 =?us-ascii?Q?Wk6Xsf7C4duKZz18tpJwbBwFGajO5/Bkd3AL7b91w8YveWFXu86HClOl2uwW?=
 =?us-ascii?Q?BcW64MgS8v1rFUThWP2QfUQPE2pU7PtwO71Io/2xRiNHjB8aXS2wtHY0ImYC?=
 =?us-ascii?Q?YxL7NaY4VLGulTMJuKIlksYs1+OHwuevseYKcOx3gP6yuULQPeCn1zrrA/2i?=
 =?us-ascii?Q?wjrdQJ7QzF+C+hGP9Ox3naq9yd3iJd7WzA69o4ZVl46UAVOOwaux4QcK91ca?=
 =?us-ascii?Q?OEohanfAcCeAy9zp+GBQ1gtwlKHKrkjHsNXUuuq/W1T7w8sBXps20mPsSBd1?=
 =?us-ascii?Q?BwpoyjczE9dAaj6GYnRp6mlJ/R/CPuHzbGokbjvmngEfigz3N961a/ZFIQmA?=
 =?us-ascii?Q?D6clKSalt4EQGkopHdroOQ/a29+gN9UMju5aavPuR1FkSCZ+XMTiW8DlJkVJ?=
 =?us-ascii?Q?B7xZorK/Z17rofzPSOIUZfqUr/ru5ls3hXmRuV1LZeQILXcOSKntTglsUtaf?=
 =?us-ascii?Q?yZVjVMYcKiEFehcg15EtV8uee7WJ6HbXiwpZxWqYn95NqPj7wsNbDNmAZYLE?=
 =?us-ascii?Q?SxBsir3DTRzwRdesy12ZE9QhVsL7WSBDpHmwAYxsiocv/i2BOQgxgBrcGRtY?=
 =?us-ascii?Q?6Gvshi0GXw=3D=3D?=
X-Exchange-RoutingPolicyChecked: dUSitApYre8+Gbdb1pVf60eXC7FZe2GPrSt5aHeh83Wqv09CE5LasBZTlg/Byv3QPT4OCH3uUi09/ifAfb7jzx+r/myRNGyj5KHgVD2Mi678KAjwww8NDvMEzAZeRw5OnAHSTfgSHawRqLZ+FRRMISkgvUhBrJbWt2r4wu0d/SWs3PEEr1r9Zy+6FDSdviY5z8CHW5MVdb5GDEDcdYsmFQa4pMcHROQRYFzG9phVks35RpXanGYDAqCqcRkrXx+DKnVGtTfyix6/dPJKCJxIaO/4g9CpEnGZHdul+iS8ZqnjC+aiXFF9kfm+tDTsSte8A6RugUknYMsa5y0il+Uu9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 74592ea0-56b6-40e1-f307-08dea24c782c
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 21:57:25.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSRQg1Seb0uDQQ3H3CDQR/SiHRFUkbcTtlx5y86bX3N6jpTV1IwNRlNJ8gmMRU70NMjIJwPSLhxv1asQtVN31Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9036
X-OriginatorOrg: intel.com

John Groves wrote:
> From: John Groves <John@Groves.net>
> 

There is a misunderstanding of what a region_extent was intended to do.

From my original commit message:

<quote>
    Regions are made up of one or more devices which may be surfacing memory
    to the host.  Once all devices in a region have surfaced an extent the
    region can expose a corresponding extent for the user to consume.
    Without interleaving a device extent forms a 1:1 relationship with the
    region extent.  Immediately surface a region extent upon getting a
    device extent.
</quote>

Without interleave support the relationship should remain 1:1.

I don't see any comments here which indicate interleaving is being added.

I think the misunderstanding started with the modifications that Anisa
did trying to make device extents contiguous.  Her version of the commit
message:

<quote>
    Regions are made up of one or more devices which may be surfacing memory
    to the host. Once all devices in a region have surfaced an extent the
    region can expose a corresponding extent for the user to consume.
    A region extent is comprised of 1 or more contiguous device extents with
    the same tag. It is surfaced after all extents from the DC event ar
     processed (events grouped together with the "More" flag).
    Interleaving is unsupported.
</quote>

From what I can tell Anisa confused 'region_extent' with dax device.
struct dax_dev is the container to group together extents.

Look at the diagrams in this presentation:

https://lpc.events/event/18/contributions/1826/attachments/1435/3335/LPC2024_CXL_DCD-v2.pdf

'DAX dev 1' covers memory from Extent A and Extent B.  What yall will want
to do is ensure that the region extents which get surfaced are ordered
based on the sequence number _when_ _the_ _dax_ _device_ is created.  The
order they come into the host does not really matter.  Although yea the
spec has a bunch of rules...  so whatever, follow those.  But it is the
dax device which groups the extents into a contiguous HPA range and maps
those ranges through struct dev_dax->ranges.

Patch 2/4 tries to undo the contiguous DPA requirement.  This is going
down a bad path.  We should go back and fix Anisa's patch rather than add
on top of all this misunderstanding.

It may also be advantageous to remove the region_extent if interleave is
way far out on the support list...  But it was added by me because folks
in our meetings insisted it was something we should consider in the
initial implementation.  Sounds like that is just confusing things.  So I
have to say if I were Dan I would probably be boiling right now with the
added complexity Ira added to the series...  :-/  Sorry...

Regardless, this series is a bad way to try and get the base series fixed
up.

Allow Anisa to go back and remove the contiguous restriction and fix up
the base series.

Ira

> Terminology note: "CXL region" (struct cxl_region) is the
> mode-agnostic HDM-decoded HPA window; "DAX region"
> (struct cxl_dax_region, nicknamed cxlr_dax) is the DCD-specific
> CXL->device-dax shim that hangs off a cxl_region.  This commit
> touches only the DAX-region shim; nothing about cxl_region, its
> HDM decoding, or its lifecycle changes.
> 
> Prior to this commit, struct cxl_dax_region holds a single
> region_extent pointer, so at most one tagged allocation can ever
> surface under a DAX region.  A subsequent commit rewrites DCD
> add-capacity handling to assemble extents per-tag and permits multiple
> allocations per More-chain; that work is latent until cxlr_dax can
> actually hold more than one region_extent.  Do the infrastructural
> swap here, on its own, so the behavior change lands in a dedicated
> commit and the per-tag assembly work isn't tangled with storage-layout
> changes.
> 
> Replace the single-slot pointer with an xarray.  Note: the xarray is
> *not* keyed by UUID.  xarray is a radix tree over unsigned-long keys;
> a 128-bit pseudo-random UUID is neither the right width nor the right
> distribution for a radix index.  The key is an allocator-assigned u32
> obtained via xa_alloc() when online_region_extent() registers the
> device; that same u32 is stored in region_extent->dev.id so device
> names become "extent<rid>.<id>" with unique suffixes per allocation
> (replacing the hardcoded .0).  UUID remains a stored attribute on
> struct region_extent; tag-based lookup is a linear xa_for_each walk,
> which is adequate at the bounded per-region tag counts DCD delivers.
> 
> User-visible naming: device names remain "extent<rid>.<N>".  Before
> this commit, N is always 0; after, N is the xa_alloc()-assigned id.
> The first region_extent under a cxlr_dax still lands at id 0, so a
> single-allocation region is observably unchanged.  Only a 2nd+
> region_extent (which cannot be produced at all today) gets a
> non-zero suffix.
> 
> Call-site translations:
> 
>   - cxl_dax_region_alloc() / _release(): xa_init / xa_destroy.
>   - alloc_region_extent(): drop the hardcoded dev.id = 0; the ID is
>     assigned when online_region_extent() registers the device.
>   - online_region_extent(): device_initialize() first so the release
>     function is wired, then xa_alloc(), assign the returned id into
>     dev->id, then dev_set_name() and device_add().  On any failure
>     from xa_alloc() onward, put_device(dev) -> release ->
>     free_region_extent() -> xa_erase() handles cleanup; no explicit
>     xa_erase() is needed in the error path of online_region_extent().
>   - free_region_extent(): xa_erase() replaces NULLing the slot.
>   - extents_contain() / extents_overlap(): nested xa_for_each, outer
>     over region_extents, inner over decoder_extents.
>   - cxl_rm_extent(): walk region_extents and match by UUID to find
>     the target region_extent (linear, bounded).
>   - cxl_add_extent()'s "already onlined" gate: translated from
>     single-slot NULL check to !xa_empty().  This preserves the
>     existing single-region_extent-per-cxlr_dax invariant; lifting
>     that gate to actually support multiple allocations is a separate
>     semantic change that belongs with the per-tag assembly rework.
> 
> The dax-side (drivers/dax/cxl.c) is unchanged.  cxl_dax_region_probe()
> still iterates region_extent children via device_for_each_child() on
> cxlr_dax->dev, and cxl_dax_region_notify() still takes a
> struct region_extent * through cxl_notify_data; neither the CXL<->DAX
> boundary nor the DAX resource model is affected.
> 
> No functional change: all paths still observe at most one
> region_extent per cxlr_dax; this commit only prepares the storage.
> 
> Signed-off-by: John Groves <John@Groves.net>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  drivers/cxl/core/extent.c | 89 ++++++++++++++++++++++-----------------
>  drivers/cxl/core/region.c |  2 +
>  drivers/cxl/cxl.h         |  9 +++-
>  3 files changed, 61 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> index c4ad81814fb4d..44b58cd477655 100644
> --- a/drivers/cxl/core/extent.c
> +++ b/drivers/cxl/core/extent.c
> @@ -87,7 +87,8 @@ static void free_region_extent(struct region_extent *region_extent)
>  	xa_for_each(&region_extent->decoder_extents, index, ed_extent)
>  		cxled_release_extent(ed_extent->cxled, ed_extent);
>  	xa_destroy(&region_extent->decoder_extents);
> -	region_extent->cxlr_dax->region_extent = NULL;
> +	xa_erase(&region_extent->cxlr_dax->region_extents,
> +		 region_extent->dev.id);
>  	kfree(region_extent);
>  }
>  
> @@ -144,7 +145,6 @@ alloc_region_extent(struct cxl_dax_region *cxlr_dax, struct range *hpa_range,
>  	region_extent->hpa_range = *hpa_range;
>  	region_extent->cxlr_dax = cxlr_dax;
>  	uuid_copy(&region_extent->uuid, uuid);
> -	region_extent->dev.id = 0;
>  	xa_init(&region_extent->decoder_extents);
>  	return no_free_ptr(region_extent);
>  }
> @@ -153,12 +153,26 @@ int online_region_extent(struct region_extent *region_extent)
>  {
>  	struct cxl_dax_region *cxlr_dax = region_extent->cxlr_dax;
>  	struct device *dev = &region_extent->dev;
> +	u32 id;
>  	int rc;
>  
>  	device_initialize(dev);
>  	device_set_pm_not_required(dev);
>  	dev->parent = &cxlr_dax->dev;
>  	dev->type = &region_extent_type;
> +
> +	/*
> +	 * Insert into cxlr_dax->region_extents before dev_set_name so
> +	 * the allocated id is available as the .<N> suffix.  On any
> +	 * failure from here on, put_device(dev) -> release ->
> +	 * free_region_extent() -> xa_erase() handles the cleanup.
> +	 */
> +	rc = xa_alloc(&cxlr_dax->region_extents, &id, region_extent,
> +		      xa_limit_32b, GFP_KERNEL);
> +	if (rc < 0)
> +		goto err;
> +	dev->id = id;
> +
>  	rc = dev_set_name(dev, "extent%d.%d", cxlr_dax->cxlr->id, dev->id);
>  	if (rc)
>  		goto err;
> @@ -167,7 +181,6 @@ int online_region_extent(struct region_extent *region_extent)
>  	if (rc)
>  		goto err;
>  
> -	cxlr_dax->region_extent = region_extent;
>  	dev_dbg(dev, "region extent HPA %pra\n", &region_extent->hpa_range);
>  	return devm_add_action_or_reset(&cxlr_dax->dev, region_extent_unregister,
>  					region_extent);
> @@ -184,17 +197,16 @@ static bool extents_contain(struct cxl_dax_region *cxlr_dax,
>  			    struct cxl_endpoint_decoder *cxled,
>  			    struct range *new_range)
>  {
> -	struct region_extent *re = cxlr_dax->region_extent;
> +	struct region_extent *re;
>  	struct cxled_extent *entry;
> -	unsigned long index;
> -
> -	if (!re)
> -		return false;
> -
> -	xa_for_each(&re->decoder_extents, index, entry) {
> -		if (cxled == entry->cxled &&
> -		    range_contains(&entry->dpa_range, new_range))
> -			return true;
> +	unsigned long i, j;
> +
> +	xa_for_each(&cxlr_dax->region_extents, i, re) {
> +		xa_for_each(&re->decoder_extents, j, entry) {
> +			if (cxled == entry->cxled &&
> +			    range_contains(&entry->dpa_range, new_range))
> +				return true;
> +		}
>  	}
>  	return false;
>  }
> @@ -203,17 +215,16 @@ static bool extents_overlap(struct cxl_dax_region *cxlr_dax,
>  			    struct cxl_endpoint_decoder *cxled,
>  			    struct range *new_range)
>  {
> -	struct region_extent *re = cxlr_dax->region_extent;
> +	struct region_extent *re;
>  	struct cxled_extent *entry;
> -	unsigned long index;
> -
> -	if (!re)
> -		return false;
> -
> -	xa_for_each(&re->decoder_extents, index, entry) {
> -		if (cxled == entry->cxled &&
> -		    range_overlaps(&entry->dpa_range, new_range))
> -			return true;
> +	unsigned long i, j;
> +
> +	xa_for_each(&cxlr_dax->region_extents, i, re) {
> +		xa_for_each(&re->decoder_extents, j, entry) {
> +			if (cxled == entry->cxled &&
> +			    range_overlaps(&entry->dpa_range, new_range))
> +				return true;
> +		}
>  	}
>  	return false;
>  }
> @@ -306,21 +317,25 @@ int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
>  	}
>  
>  	cxlr_dax = cxlr->cxlr_dax;
> -	reg_ext = cxlr_dax->region_extent;
> +	import_uuid(&tag, extent->uuid);
> +	{
> +		struct region_extent *r;
> +		unsigned long idx;
> +
> +		reg_ext = NULL;
> +		xa_for_each(&cxlr_dax->region_extents, idx, r) {
> +			if (uuid_equal(&r->uuid, &tag)) {
> +				reg_ext = r;
> +				break;
> +			}
> +		}
> +	}
>  	if (!reg_ext) {
> -		dev_err(&cxlr->cxlr_dax->dev,
> -			"no capacity has been added to the region\n");
> +		dev_err(&cxlr_dax->dev,
> +			"no region_extent matches tag %pU\n", &tag);
>  		return -ENXIO;
>  	}
>  
> -	import_uuid(&tag, extent->uuid);
> -	if (!uuid_equal(&tag, &reg_ext->uuid)) {
> -		dev_err(&cxlr->cxlr_dax->dev,
> -			"extent tag %pU doesn't match region tag %pU\n",
> -			&tag, &reg_ext->uuid);
> -		return -EINVAL;
> -	}
> -
>  	calc_hpa_range(cxled, cxlr_dax, &dpa_range, &hpa_range);
>  	if (!range_contains(&reg_ext->hpa_range, &hpa_range)) {
>  		dev_err(&cxlr_dax->dev,
> @@ -329,9 +344,7 @@ int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
>  		return -EINVAL;
>  	}
>  
> -	rc = cxlr_notify_extent(cxlr,
> -				DCD_RELEASE_CAPACITY,
> -				cxlr_dax->region_extent);
> +	rc = cxlr_notify_extent(cxlr, DCD_RELEASE_CAPACITY, reg_ext);
>  	if (rc == -EBUSY)
>  		return 0;
>  
> @@ -416,7 +429,7 @@ int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
>  
>  	cxlr_dax = cxlr->cxlr_dax;
>  	/* Cannot add to a region_extent once it's been onlined */
> -	if (cxlr_dax->region_extent) {
> +	if (!xa_empty(&cxlr_dax->region_extents)) {
>  		dev_err(&cxlr_dax->dev, "Can no longer add to region %d\n",
>  			cxlr->id);
>  		return -EINVAL;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 15065d9a1cbf2..42b3a3bbd502f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3546,6 +3546,7 @@ static void cxl_dax_region_release(struct device *dev)
>  {
>  	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
>  
> +	xa_destroy(&cxlr_dax->region_extents);
>  	kfree(cxlr_dax);
>  }
>  
> @@ -3590,6 +3591,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>  	if (!cxlr_dax)
>  		return ERR_PTR(-ENOMEM);
>  
> +	xa_init(&cxlr_dax->region_extents);
>  	cxlr_dax->hpa_range.start = p->res->start;
>  	cxlr_dax->hpa_range.end = p->res->end;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 53d8a2f0d1272..715fa9e580cb0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -637,7 +637,14 @@ struct cxl_dax_region {
>  	struct device dev;
>  	struct cxl_region *cxlr;
>  	struct range hpa_range;
> -	struct region_extent *region_extent;
> +	/*
> +	 * region_extents is keyed by an allocator-assigned u32 (see
> +	 * online_region_extent()), not by extent UUID.  The UUID is a
> +	 * 128-bit pseudo-random identity carried on each region_extent;
> +	 * tag lookup is a linear xa_for_each walk, which is adequate at
> +	 * the bounded per-region tag counts this driver handles.
> +	 */
> +	struct xarray region_extents;
>  };
>  
>  /**
> -- 
> 2.53.0
> 
> 


