Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932B746E;
	Thu,  7 Nov 2024 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941880; cv=fail; b=tSFclt+6kHq2mjb4EtLLjJ4zMkvINiF1znRwKqNQl1hP8C4wLI7iuEgCfGo0kvcsRhueeCwRntolEe4yfQ6la0GdGWDEPEDFlqjBJZFx9LSUIBd0hPeIK/MFURsdgXhHx2ox/fpzV09SPaQDM/oEn+G8BCN7o8rOrbs9eq5kWhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941880; c=relaxed/simple;
	bh=ywyPRGh/e7Qg48h17hIkbvQTXvjRix03YD4gDrwz+w0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EFY573BX+HaCA2i+KXoJcRPV6mp390p4PaCd+/GsGBG8euJC926VDlw76vhuo2y/R2D1BYPRaRQL+os1cUjO4kYlrZzS2xr//OuKqOcwoOJ+4ZGstmX50Rxlin0aN3Hb73ksC9Uu+llZXvBKwI3vK92XBuCFrtRq0+8o8tNfaXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CY/KJdzc; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CY/KJdzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730941879; x=1762477879;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ywyPRGh/e7Qg48h17hIkbvQTXvjRix03YD4gDrwz+w0=;
  b=CY/KJdzcoG5yeEraPUx1RBtGvXP8KeaZ3wxrfa7H0OM8Hoh4N7wIp8U5
   6PHkpI5eeSBGZkR5XQOi/E9DQPYp7LTDTl1U2VRL+iBIvfMrYMPCtPan+
   V4wimsg1d5cIVSEW6sMUIipQoomiaip2ZB4cRm6IX5erUAHVfLcRQZ/kI
   mfEQDH/b9UUhmSflGiWulHtSMbjKE1xd196GVvtYL6GWMXOF+JO5O/0Kf
   RXvwY0fULVyzgS/N8F9drPjsoFodWieAQHQ3GK1jFUof5ZOvn3YXFen23
   G9ygD1fnvIJvzPzGo+42iW1qIVIqc35NRp+kYJi1HYyWLf5FItLYeqALq
   A==;
X-CSE-ConnectionGUID: 6AKLJnJOR6aJG9avV8n9RA==
X-CSE-MsgGUID: HZxqGHDjTbeL7IAw+UNt5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48229683"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48229683"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 17:11:19 -0800
X-CSE-ConnectionGUID: ZvPmR9nxT3i4FYCz+VLedw==
X-CSE-MsgGUID: huA89pN2RZK7lf+jFFr9/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="89702477"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2024 17:11:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Nov 2024 17:11:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 6 Nov 2024 17:11:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 17:11:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN1+e6SH3Ton1Y0TZ1poVg0V0B7aIFBHP9/9Aa7Hxy/bH6d1U/YrzMk18CJqw7gXiM0Q7hZSNHzFff/Nwl3RGfMi+97iEIQKqYCpCcPKjlfs5hM7z+eaEyAK6WcOXOA5NCfhHJfvIEZSlFjcLhLLgQPF5Fl36KTBs4bnC2BS3gcQxBXJA/fKdqQc+TVrzB2pOMlLhG9NH7n5QF4bRx658CNjbxlGYXUr5VMnax2BOGl2EUUws/kYwlrOEfzkbDtQ4Bkjol0CTRetDkQOQAs7kJCYL9HsH0zljPMLnvSbEJD+tevF+wMHlxvaHvzCKEEAG96CRjVrXG3BxsyoTopo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkfdUjEAi/yE6prgG8ztj5es8qwRzmy5jWQ+P2G8Y0g=;
 b=j7u7s7x22cQFZc3NOPtac2XZUmSE1TVyEBF4Jy7dp/HKVKhQiYdCiLWa2IqGpOSOnzgKBnWT5mLGmmvJYU7RmS+/X3IA0S95NP72s+A5rYLZbx8WFyH3DLJ8cBS48dXF5ReJckBTmeSIqRxaeXI3qCOhWIl109zpY0LKeGSDPY9rxREFcaX53hMPTHg4rG87LjuxnGq0/P3jbYqzWgvtrxhMF3tTcrWWdKAV/Zb2rhJ+/nKkjVYlUpRv5+4lBUc7GbFPOb/GL6AKuerCeMNW/yVj7dnPJW950d/gnjL2rP0sfShUEoRYx83JsGDhXGDzGE/QQcSPyJYjE2Nh97y8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6068.namprd11.prod.outlook.com (2603:10b6:8:64::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.20; Thu, 7 Nov 2024 01:11:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 01:11:16 +0000
Date: Wed, 6 Nov 2024 17:11:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Huaisheng Ye
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pei.p.jia@intel.com" <pei.p.jia@intel.com>
Subject: Re: [PATCH] [RFC] cxl/region: Fix region creation for greater than
 x2 switches
Message-ID: <672c13b19a530_10bc6294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241027075717.3714821-1-huaisheng.ye@intel.com>
 <80415a29-14dd-4108-aa02-4b0b5e1f2baf@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80415a29-14dd-4108-aa02-4b0b5e1f2baf@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0316.namprd04.prod.outlook.com
 (2603:10b6:303:82::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: bba216b2-5a65-4605-8526-08dcfec91419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i5bJDX1oKDkE/3W6/KsAQZwYuKaSTxnrIMoHoTj0GIN9xHWBEY6m5SDELWOA?=
 =?us-ascii?Q?TH3KZsoU1bniew6fYVDQ2lfBfTRPerAnJMluAx/q5l5S1b8dEHcJV05zDXML?=
 =?us-ascii?Q?h10EXSMIqSdNv2mZ9AD4cN5XtkaqeMmigPRxMFmJkMkIy/yrBgBiY0OK9vFL?=
 =?us-ascii?Q?3PN7NKNQSd37rs+8M4CABfu4HsRBoxxEUYmP/hvbxkLYdQUouMZZZyUwvurU?=
 =?us-ascii?Q?mng/LLHU8OSgInF0gXctYDqAs7GG77QCbTpayHRbgFpQRW76EF8XJj2dGyC6?=
 =?us-ascii?Q?4dPOe79nVjhbCyRidxNcMoHok6iRD+1kWtCxyIKGUQfFv9td1z45qP41ArxE?=
 =?us-ascii?Q?g72A9wKfebBzjEBnz6VWUhn71bxDXyV/8XjXdD51oWaI42X/ewQbssJSulgy?=
 =?us-ascii?Q?OjyHkTtwUdNtCVIl4iqcDUQM9ggFtH0YzcxW+YfsDX3GYs02EdUH+uFBP8V2?=
 =?us-ascii?Q?GskCoSy1pCl/ZuCXdiqBoMxj5bUveHC68KUgzjuCD1GJLBYuuPrc/xI/DWhk?=
 =?us-ascii?Q?N5n1fiLuMtWOrDWBu8yA+xa7PyMhYmo6fo5A0FMBGBTinDKtpZO8Z9XuOr4p?=
 =?us-ascii?Q?MLDFcC91HfRtSbzm9U+l/z76c6TE4+hbZqGvYWeS9NjRshEOWFxJ43/86z6n?=
 =?us-ascii?Q?a/4qDhg3hZNiwjkVjfQvvENsRi2XzExebWtyqD9xxfuvNx7kkG4gdVB7JnIP?=
 =?us-ascii?Q?wGfxVx3U97vbVVe/EbYkSdLlQhZf276ryHCzzUNMgg2XDNRIAxIE+M8vDnBg?=
 =?us-ascii?Q?s0CreAlmpfQEEqEj4A/B3n4qQ0+gJHmRT5xXV4dLnoVWPym9tFfy+0La/n9O?=
 =?us-ascii?Q?8Hvxv/l5PcUGqO1Tt6IJ0GYSX0sMDtnVcwFy4YncTXCYKBsewo3ZrcluGSCj?=
 =?us-ascii?Q?TakLgAZIoYSRKMLVPbEo/G8YPscMSja7QyGT7xQn0k6vlYUgewVAxwNQVCoE?=
 =?us-ascii?Q?gQSb8nH5rIqStiACZ5p/vHCo9ITSU7jONAlZjtzABChFz5eToETuH75B3Yzp?=
 =?us-ascii?Q?ucxbbGelTFZkJ5cTA35lh+cG5w+woDkDA0Ui41OdjaO9omrsfagwEN6MnXDf?=
 =?us-ascii?Q?JqANUKdDvw+ifN4Xnkno38bJw88rA2587RxpI3M5Q6pfMJwr0GC05pJp2z4Q?=
 =?us-ascii?Q?PB1XHLiWBI39VMCqGQqIJlY3x8X2qSzPaQKOjSb9RJGq4/qW49QftP6HnFUo?=
 =?us-ascii?Q?NiL607/aEdG10hfO0Ii+peSSFohYt+RDzeuRWbsIqsXXTL+zUufZIDR7UMfW?=
 =?us-ascii?Q?BYGUQPkeh62L821yLN3OGVux03o91rdklj+WK7QEriB4NsiolykZr8QEEjox?=
 =?us-ascii?Q?e2ShLpjqZaM9ZLPbpQb6PciK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pdwk/kV7t2hBXHVgjppUoJqsELdfKlnkzGkTCD/CG9Kqh2FF0/cQ6bBsmI1v?=
 =?us-ascii?Q?nZ1cAFPSuhfHpte/XUSjVoNrYeQBvAogWuc6PdtET0YfsBPkkSeTx4KHOvD0?=
 =?us-ascii?Q?GusKG5zqo3fPqeWo/i0B1PPv0lqTk0wHAoXSZJzjHlSUyJGLkJJYyCaIQqWC?=
 =?us-ascii?Q?Gz/PI/ZfVkJQLVq0YJMFuurjt0nK9n9x4fvn1MYx9vx9wTbQaeUd0DFo/jCr?=
 =?us-ascii?Q?jnTG/2fr5al9WPj5wUDmSynk16THpbKnDG/AAJjXYeXb1S2yJJuKlep0c7Qr?=
 =?us-ascii?Q?QyKwi6JkDWCyVJpMa0mGiChnpPpiJQGmVVX49Su+eTGW2pF6Gn1inNAQ1FPB?=
 =?us-ascii?Q?JoINeb7r8NFVkvv5L7KS+KnMbsBS1yy78mLrLtkppKBdblQKTth2gstxjP3R?=
 =?us-ascii?Q?UJDEJWFuv2akh7AuOvHucLiUcXdvDE9xp9bOSCbSlVLf+JVTFj1JHM4n7SBB?=
 =?us-ascii?Q?rwhYo2PUK753r68sYOeb1AEab6adf98xvxttwK2qkR3jIWPDZRvHu1TmJl+I?=
 =?us-ascii?Q?++SpcR6XrTNBME+IK6g+/rxbKW8hX66lN9TwMOI8w10GjWOQFIvKbtFGJs5Y?=
 =?us-ascii?Q?yBA9QK2+tSJ5gh4dCPaTDIe9OIoYuXZcF+1ezOI9ffk+1CM1PlvToL1ON4NM?=
 =?us-ascii?Q?bZZwcgjzJlChSCTqSbwDaLKzigZZCq5WN+B3e7ZOihiemm45ueLzb1TGOIMi?=
 =?us-ascii?Q?djzOmnPtODtrsP3bYSbajScgqQiV3Rtya3bN3H5UI0lB6OSdpOc8pxz7JJja?=
 =?us-ascii?Q?tTcZ9I61IeXwLTrS8L9UnK1BQDFDG4AMY4WQnYx+FUMGmuHqUUF3YQyNZCkj?=
 =?us-ascii?Q?5fs4i5voF9y8Z0RaMZIa+kNbm6HDqnrzycBtiH2Di2tIoTMQAfzTDdhFpGhV?=
 =?us-ascii?Q?PFLC+VWAbIr7VoW7gVmPrOk7ROntskh+yl7TATvl+YMFwY4MfnuXtIcdsA6d?=
 =?us-ascii?Q?zhYl3LH0Ox68xslIyr0FaSRqXf/euVSoKeOQyvLJjDYQofZ7Chc8pvqtABDk?=
 =?us-ascii?Q?7P04RzEUkEoPiyHw1eBWtvBnNNYqXxXvf0ZE8jL+hWOd/1PsxY/eVEA8H7Cj?=
 =?us-ascii?Q?NFJWI7n4UJwGMHgAK3QQOXGMIPwviBZQWNc9a1bQOrhORmY7zS0s58tP/DDd?=
 =?us-ascii?Q?0ul3HfqRbVbY64tBPEYNzEg8qzRaX4aTd3XVE1Kjt3Q+oBA4L0SE2C2nIEM2?=
 =?us-ascii?Q?Xt8KVgnq1qmy6KWuL2POB8cd2PxIjE8p6VV9Gwr7ICObd0/fkmNgemnAayMq?=
 =?us-ascii?Q?V8W2y9mrEiehEjNqx6Xawv9r67diJ2fV4GeHqZbHeZ/wgQzj0d0z3+CZWP3H?=
 =?us-ascii?Q?rhGJ0OeZd30o36xeK1uE3AiA9WCtp2Eu8fu0IH9pFrKQf3Bf1dWVLXJyDC/J?=
 =?us-ascii?Q?qFqvmcw6IPkG/2M7TcS+ucU7s2bN9DuH8sVDH4sAl0LxfyE47i75XKcwrBKc?=
 =?us-ascii?Q?KTTaDomwxY+4zETxArw3gGfBtlKWLNJ/sFuiChyfvb2V4H4P+1Djy0pgNzbE?=
 =?us-ascii?Q?izusj093BxTDjyn6haywFfJ131exOmHcJaOoDmxd4GgC99fMe4Id12i+aqN2?=
 =?us-ascii?Q?FbSaz4fkfSnO4SdIP56U7EiEjhgSGXJCx8ncY5pZ/ehHL9zPNmNCQ5VkNOgv?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bba216b2-5a65-4605-8526-08dcfec91419
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 01:11:16.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaQGfrjzZ5oTZZRSv+JEdRKQL36B+XDgL/IJnIkeKkPHkA6VCDRkZHdMYD+1+K56aQzNlu1mFdNmDb5mLbOrTCkJk0UMsvAX9WdvvcbK+Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6068
X-OriginatorOrg: intel.com

[ add Dave so you 

Zhijian Li (Fujitsu) wrote:
> 
> 
> On 27/10/2024 15:57, Huaisheng Ye wrote:
> > The cxl_port_setup_targets() algorithm fails to identify valid target list
> > ordering in the presence of 4-way and above switches resulting in
> > 'cxl create-region' failures of the form:
> > 
> >    # cxl create-region -d decoder0.0 -g 1024 -s 2G -t ram -w 8 -m mem4 mem1 mem6 mem3 mem2 mem5 mem7 mem0
> >    cxl region: create_region: region0: failed to set target7 to mem0
> >    cxl region: cmd_create_region: created 0 regions
> > 
> >    [kernel debug message]
> >    check_last_peer:1213: cxl region0: pci0000:0c:port1: cannot host mem6:decoder7.0 at 2
> >    bus_remove_device:574: bus: 'cxl': remove device region0
> > 
> > QEMU can create this failing topology:
> > 
> >                         ACPI0017:00 [root0]
> >                             |
> >                           HB_0 [port1]
> >                          /             \
> >                       RP_0             RP_1
> >                        |                 |
> >                  USP [port2]           USP [port3]
> >              /    /    \    \        /   /    \    \
> >            DSP   DSP   DSP   DSP   DSP  DSP   DSP  DSP
> >             |     |     |     |     |    |     |    |
> >            mem4  mem6  mem2  mem7  mem1 mem3  mem5  mem0
> >   Pos:      0     2     4     6     1    3     5    7
> 
> Yeah, I tried this topology long long ago, it didn't work. At that time, I thought it
> might be just like that. Until recently that I saw this [1] in section
> 2.13.15.1 Region Spanning 2 HB Root Ports Example Configuration Checks
> 
> I once tried to understand why the code used "distance" to determine the order of the target,
> but in the end, I still couldn't figure it out (and I still don't understand it now).
> IIRC, neither the CXL spec nor this document mentioned the keyword "distance" at all.

Oh, that means this needs a comment or a better variable name.

In this patch discussion [1] Jim came up with the term "ancestral_ways"
to describe the same concept of what is the offset ("distance") between
consecutive indices in the target list.

[1]: http://lore.kernel.org/ZUHeTLZb+od8q4EE@ubuntu

Does "ancestral_ways" more clearly convey the math that is being
performed at each level of the hierarchy?

Now, "ancestral_ways" also does not show up in the CXL specification,
but that is because the CXL specification leaves at as an exercise for
software to figure out an algorithm to validate that a proposed ordering
of memory-device-decoders in a region can be supported by the given CXL
topology.

In the meantime I have flagged this patch to Dave for consideration in
the next cxl-fixes pull request, but I suspect it will need to be
updated with a comment and/or rename to resovle the "distance"
confusion.

https://patchwork.kernel.org/bundle/cxllinux/cxl-fixes/
