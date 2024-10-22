Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DB1E51D;
	Tue, 22 Oct 2024 02:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562843; cv=fail; b=Wj/0PC4GJUswLJ75fr61N5Pkc/x47U9Vhk9WxxMlOTAKeQOHGGQ/DRmRM23s1W81570PaCh66bddYde5HYa7vKCBAWdpGmfFh64Cs3oTrLvCv/SKsSCPAFJlsBfJgEVomrsoFZWkviMcVGukiO9sKy/BLXoE8V1l3naIbiczdcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562843; c=relaxed/simple;
	bh=yOApFFb129dERqPB55W6GVEIa5FjpySP72sB1FWe1B8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RpfsuTW2JoKty0E3DBLh5ezi5TV18Q/NZbLuG1c4FwCjSRHOUVcjBL+kbT0BTjmcEe4AQrWdfZZsAIVQxA5hia1Bx5AfsI74tVS2DOEx7Uga+Vcyp7sptJ0GQ246UA36fl5GeEbABqJK70s4ewU+VTS6B/29x+3/mNgc20faxc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoyS9OZo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoyS9OZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729562842; x=1761098842;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yOApFFb129dERqPB55W6GVEIa5FjpySP72sB1FWe1B8=;
  b=RoyS9OZo3lR8p4vGpUktM5ifsvO/kUhbeVZfTvyzzqiZctwrItNLeVyp
   m+BmOWPREZj66MpULk3DjGdYE3oWyRJEcirvEN7Fn5UqPgIqEWdkxkDiU
   mbOl6+++RqPU1g/tbBBFuw06ZOmQIn8tecZrTVVRARDlsMpnwHZjBX5qp
   W+oSo/awCR1xald9eYEehwsOeKH6KDImlPXZ4X7BQiT/sv8jEtTrIAXQ9
   FQ8biR7kOMP9k+biqZkRMSVZNr00uo72rCFS2siJkNyw2lUViumqCr8Jw
   VcQMTztO4TUR+n8XjP0Xs3lmEP4qPmyGOZu8L5wp32I4hKkF/xLBtbneh
   Q==;
X-CSE-ConnectionGUID: X50deXNFRWSp8Nf2iNRrMw==
X-CSE-MsgGUID: qhSxX8dFRiuwkKfOJapZkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29186554"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29186554"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 19:07:21 -0700
X-CSE-ConnectionGUID: z9mMjclKQZ+7WKv6f5j36w==
X-CSE-MsgGUID: XqedV3AURpq2PQhHya841Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="84302888"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 19:07:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 19:07:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 19:07:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 19:07:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8RBzY3gJ6m9pdWxomTHxxiv9JcECQyiIpJSHXqutxznjsbXXigxNdnmVu8+qZEiMCwg400jetcRXm9ckiSFbrSYcjnIug0xU4mueZ5CqEawPfVwR6r3gWzqIRNd7/Sv0KvEaFz6STFPx+HWkSULplqFVoWlFETg0CF4SyJy9bvIJ+LfVpmtsS/bXu51ZiLJK8VIYcQU2qSrFdfxjB06QckRNG38qccbY9eJNAneIu/RhDZrxHHTWkOeQVA3AJxkI8JnQkv80mfIIqKEqwFiFXRxGf0mJTBiQ4ztTNiSli49oJQNToLwAPqMwQuUEnkuKZfY+k6xXHev7TlI4RiFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoY2Yt2jUiZqKFZRHhX130bECZBmF88gY8o7WYFvyK8=;
 b=HgTR1O4Rv4XTqh6My11yS6CS0tGNaspM86VqF+aAmGmtKf0vBORkNHQL6th/abUz4e361GOE5+7RxEpIQ6ktPUCjHWs8AlylNsq0nsIHPlb5/ZARqlE5utRiCOhlPaAKZkt+gJQqb61NeAluhjyN4PqaUQFpqJGV8Vk/ABFfOZON1AQDo822hkljY6bVgFBhVt3ECYntBKwzkw9M8F2ELFQpbs5/7RfRxNgLEjWdT/BooXFTreiWHqi7V0nFK4NXkqBJuJPeI9jYXde7LQs1JIR8/YKgrCeJkrOJhYszGeWhOijPjJ7tP5rg2TZh6Pr5atHTLflBBFOdjhNjM7TmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5788.namprd11.prod.outlook.com (2603:10b6:303:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 02:07:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 02:07:12 +0000
Date: Mon, 21 Oct 2024 19:07:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, Li Zhijian
	<lizhijian@fujitsu.com>, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH v2] cxl/core: Return error when
 cxl_endpoint_gather_bandwidth() handles a non-PCI device
Message-ID: <671708cd6d84f_232629418@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241022014745.231085-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241022014745.231085-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: d15911ad-d32d-468c-3e07-08dcf23e3df8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3lHd13RkU//Yy1GhEqLNO4kFv5l2EQSeAvZy1rCNzZjIwEK60BgGMwiNKR9G?=
 =?us-ascii?Q?VT/ggTUh86V3W/H8bY3ccm8t6Bk/UWEUTjfyMidZiapuEKVEBUfjVCLstpLT?=
 =?us-ascii?Q?8+7PyXHkJd9D5DOGWIBcAFm2dV5ddZqfpeOixfGa5PYahEAqHpC8hDjNpIIk?=
 =?us-ascii?Q?G2A7KikuIEBpJgBE+Mfy0RJtRLRlPvWDkbMNL0qWSx2N0YFEF+h6dVwK3737?=
 =?us-ascii?Q?xoGLfmNc+sIhmKzK9CaZpT4nn6bhz5jHTImgI3Yo3b7OtiWH6ENbIkB/lPfy?=
 =?us-ascii?Q?bjrNn4ORouzEOhfDuqCFXXavRiKWvN1r9BZMOvNzAVZxZkWioQVSnK0xVb42?=
 =?us-ascii?Q?jBgU3P0uQZr48XL4qMSnn9TYrtcRRZjRqd/EVvnpSuZvgdouPgkW9cqa5QTV?=
 =?us-ascii?Q?v7HUsP+2yC8Rnt1PoviS1WaIiUNkw+eKlp/fjCMTd6GI/sFNe/rY/aXcZnBX?=
 =?us-ascii?Q?uXEZYwnxh+vVQqZ4Z6G+HcZ6wOJ3VGZMGm12TbeiDbOwsmtLieFlgwNOzE80?=
 =?us-ascii?Q?0ICltIlZFy+/3xVbdReMeMGkDULubq4LF8EZ6nugJy8IySdAO5KDtJLXPKOa?=
 =?us-ascii?Q?avgdR0TglrD2MLnW7C5flPHRwVD2HHRlaSqRI+lUhWzYJl3Os1rvAmsTGMc7?=
 =?us-ascii?Q?+6G2/22erpCMZxCCrwFznsA96mkqpoMA7MdVJZRNKBcxmuZ4RF3s1pSaa0RT?=
 =?us-ascii?Q?Nr6E9lVhyestQd/o7AtZDldeupi2bCoQP69cUqZiXYAvzPUE/IkQEYRbH21h?=
 =?us-ascii?Q?64x8zdSXFMn2wSntBu9Bgy7DSxstkkfjB6KMEg4D1ptNcWj/aBLbPGWj99RQ?=
 =?us-ascii?Q?5CA+auHtyRHtnUp9U8f6fFx93YPxG8HGQtHsxGZYhgQQqGu2+SQEksu0dJzr?=
 =?us-ascii?Q?xgePNh4HNv/P+c540C/D1skJvCmubxzYSJeULXeMGcdM55JAVKmzgwH1dKjf?=
 =?us-ascii?Q?LPU1eeZ7CQNeR5JQ7NsikjCS5iMVK1+sJLSC4SPb0X0X6/wp+qxa6lCZs4wN?=
 =?us-ascii?Q?7qs/Z+MtHB5Dsipt9bTMxGGzpwk9pQiHba5Y64io+iAzg1qwsd3pDQCsxqeh?=
 =?us-ascii?Q?JkNVvnwzDqntValQ2w4b9rIZjoL5j6kA6YbKeotuCuufKRjRCMQImOaYrpO7?=
 =?us-ascii?Q?/S9elLGoWHbzHxMub+OLx6z8KH5/ZmVs4rI+W2Dw30Um9+Xvs8oLn4vLzCHn?=
 =?us-ascii?Q?dwNY1N6qvXXtCmWrUZoh26LAvTBqvWKcAcb8IYYJzRF8YbSwA9qMhITHYr4U?=
 =?us-ascii?Q?XgnFOIXaaM5O0AKeSaPrXvhAQR1V/66dzl4YCGcCGlzC7+gNTWXZ3pPY5/qO?=
 =?us-ascii?Q?nAlIum/2I/vGY3sTTKD5LYWJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DUcYkBWUVj6rfm3VbmjPYokYP36qqBcKM0oN3R8/Xkmufn9tHUVefpRpOb4g?=
 =?us-ascii?Q?hyTGmiqrm1HUFk/GL1rqKUwUf3bICSYSkXOsfDuk8IpamipqxRoKbm0X3TXw?=
 =?us-ascii?Q?/LKo9g9nVdINrwE9KdFm1BKT+5V/ICtntN87FZfm2vrpQ9aHowHWGHBMBUSf?=
 =?us-ascii?Q?JxpJvGeoaVcZYDZrl9O9dLmIYKAWzbT1Rc6lqCDdGxSTIpuSQRzzpjZ4UQox?=
 =?us-ascii?Q?jIKlMbV2ETopmu8wKP/VqdKeF5ntaYN0ipwMBI0Wo9BGqfuE4XZ7B3UwS4sp?=
 =?us-ascii?Q?GTDfBVYxr3b66DL/rd32KgyZ87mxl9HZl4rS7hP5hpv5HrXmqqq6VsBY8/bS?=
 =?us-ascii?Q?VT7nK23FDSwpLApRn2AAiEkgfpMhzN+v3l4whTZO5XNgh8XZzigYdNsNaFBx?=
 =?us-ascii?Q?FF7HCX/B+y7MzfgdRf98I1YDZhOu142Yp4vlyMcFFsPhWALEa2E1bt6PD3Lc?=
 =?us-ascii?Q?u8ef6RiZEdQXuB0ULH0/ksvYhdbFt3kc3Bkbs9xyElFYcbLJ5+7BZ1zb0X7O?=
 =?us-ascii?Q?qktYGYDqxgSo5ntTiCyVRAkhAnx4WJWnfFxiCyxamaGpZl4Kj8tFr7lv3H+k?=
 =?us-ascii?Q?cBTL8S/Py+5Q4rIQvYHl0oV/xDdSZfQtEwIFq0Qv0uFgwniapXDOS+QqXN7c?=
 =?us-ascii?Q?wW3MlaMfsNXee+gVSNflx2Vn02i3mqwuooONRSVBDsLQgk8aW35CTOPHf3Wb?=
 =?us-ascii?Q?xOQv2oMivoXXk65T5eTN5G6+73As3DruHKAqHZMZ6/cZa9AU0IT4ZCbUd3+1?=
 =?us-ascii?Q?WH1YumrqZ43Ja1+YIldIutKNB3fVr62SbYLVtKffQDOL/8d4350Zcs3dKkH3?=
 =?us-ascii?Q?AkNGfhyJPl7ve1ilcD/WvjnmwyKpJYwd584Vjo/Wxoe/VixaWHTceKog96oO?=
 =?us-ascii?Q?SG2RU9X40cuUUDrrdEG/xuLeB1ttvdpi0c0dOxU7NiKxds5qH/XEjucLXXWC?=
 =?us-ascii?Q?SplYvv2zOx10MIVCLuiCC1FaIhaL5m05fqqN6Jaldh5/1JPMaDDTGmE1a9gP?=
 =?us-ascii?Q?viUr24Cz1c9y2iNC+rWEl0DCT4AAGEXBnneuyjx3NHL28mKI4Z2+L+MVknHg?=
 =?us-ascii?Q?9cBFTMtHxA20b6Q9WdltUbi1oZl8MoS1hh6TFBBuZ2tAvh7Me2asa96keia2?=
 =?us-ascii?Q?5QbMOM7ywzAqbD8kvQv+qHMrqJbnwbuf/tAYrbqIKqYgt4ugqtZFtmKbksdd?=
 =?us-ascii?Q?2icEB5vqDho6nVlZwpVuCQlxMFyLvJ8nZh/wiAUSxuTmAgvsxf+rKo+HwlXh?=
 =?us-ascii?Q?cgRM2dHDj7S/uoE1g6Q9cvyFh/BwxzvYg+pxnQUd1SO11jRovN3VJUsZJMWb?=
 =?us-ascii?Q?XgRUMJNEbtLLot3GW4veCM62cQxRVkrg3qbzcYVrXB1ekMCtlZVJ9pNzJ+t5?=
 =?us-ascii?Q?bLshcojLrTM8ccbjZYJTBOLuqZ2HDbqKSZQj5ttSUDA4sVi/ct0kYsjzdJmW?=
 =?us-ascii?Q?H1dYTzlg3qbmnVpl/ccwHpIYJWkkWyLN3S7vR/601cHo99D9/j2mk/cdt4ri?=
 =?us-ascii?Q?m84PeoFHzbx4jEQGB4LlWt2uy/2SJzOEZ1JQ6kxwbl4oXimkSWH3Vutwrr+r?=
 =?us-ascii?Q?1B2rJpWyRcBf7YfXJkejdNtmRn7ruMaGEbKf7Qh+yTDgwru6c1mHRCLoFOUm?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d15911ad-d32d-468c-3e07-08dcf23e3df8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 02:07:12.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEv1wnZKRzMPWnrgCKTquyt3qWncw/lB0HuTN7JlHgemL16iOtLJLdkFaT/XzgvB2mAA99v8E+DTf2vkYzUonMEsPTPeZb6qjuG8eYigSSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5788
X-OriginatorOrg: intel.com

Li Zhijian wrote:
> The function cxl_endpoint_gather_bandwidth() invokes
> pci_bus_read/write_XXX(), however, not all CXL devices are presently
> implemented via PCI. It is recognized that the cxl_test has realized a CXL
> device using a platform device.


> Calling pci_bus_read/write_XXX() in cxl_test will cause kernel panic:

I like that you include the failure info. I would also trim it to just
the salient information, like this:

 platform cxl_host_bridge.3: host supports CXL (restricted)
 Oops: general protection fault, probably for non-canonical address 0x3ef17856fcae4fbd: 0000 [#1] PREEMPT SMP PTI
 RIP: 0010:pci_bus_read_config_word+0x1c/0x60
 Call Trace:
  <TASK>
  ? __die_body.cold+0x19/0x27
  ? die_addr+0x38/0x60
  ? exc_general_protection+0x1f5/0x4b0
  ? asm_exc_general_protection+0x22/0x30
  ? pci_bus_read_config_word+0x1c/0x60
  pcie_capability_read_word+0x93/0xb0
  pcie_link_speed_mbps+0x18/0x50
  cxl_pci_get_bandwidth+0x18/0x60 [cxl_core]
  cxl_endpoint_gather_bandwidth.constprop.0+0xf4/0x230 [cxl_core]
  ? xas_store+0x54/0x660
  ? preempt_count_add+0x69/0xa0
  ? _raw_spin_lock+0x13/0x40
  ? __kmalloc_cache_noprof+0xe7/0x270
  cxl_region_shared_upstream_bandwidth_update+0x9c/0x790 [cxl_core]
  cxl_region_attach+0x520/0x7e0 [cxl_core]
  store_targetN+0xf2/0x120 [cxl_core]

> And Ying also reported a KASAN error with similar calltrace.
> 
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/linux-cxl/87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com/

Minor, but this can also be trimmed:

Closes: http://lore.kernel.org/87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com

> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2:
>   Check device type in original cxl_endpoint_gather_bandwidth() instead of mocking a new one. # Dan
>   Also noticed that the existing cxl_switch_gather_bandwidth() also have the same check.
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/cxl/core/cdat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index ef1621d40f05..1a510e692ac0 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -641,6 +641,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>  	void *ptr;
>  	int rc;
>  
> +	if (!dev_is_pci(cxlds->dev))
> +		return -EINVAL;

This should be -ENODEV or -ENXIO. If this error code ever leaked out to
userspace the application would think it passed an "invalid argument" vs
encountering "no such device".

Feel free to add:
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...after fixing that up.
