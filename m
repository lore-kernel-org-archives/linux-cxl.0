Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3FE1AAC4;
	Sat,  5 Oct 2024 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728086890; cv=fail; b=uVa4896AjTJYzLRTqPjfVTVP+v3hm3og3midjbKiAomnNRQBNjI8FuBWNuNkDB28BiN2jFHsuaV4rVYrn2be3hH6Th94zKtvomIt27amaVDz+MRh734ARg0Z6rc3E86Vuj7C/3iPGUgjinpNnEjW/VCDNC42RlXgCQ79SljUZ1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728086890; c=relaxed/simple;
	bh=NBtKi2jz6HrqWV684a2iTgltj77pjPsamhkbeBU4ufM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=opnV8U6dC0o3RenxZfvp+yLCQ96RmA2y8cCWdJnR7HEa0j6Wkl1gkbWR05KEtd8dRxVLiqecLXGaLGB/eDOAD7Wz6NVQBRVLYZZBvgwPg3PXaMD3B7LPQhls8h54aYYGhJlKOo94zsIrk+MMMaqReCYFDd0XQWb1lAgatMLVbHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gR+vwqzq; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gR+vwqzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728086890; x=1759622890;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NBtKi2jz6HrqWV684a2iTgltj77pjPsamhkbeBU4ufM=;
  b=gR+vwqzqQDkEuWKTtuSFHqBJfvbo+Gca2du3vjwixFUvQ9FLY0oY8lZY
   EA0bErB+wamuNjGBap9FSFyfW/jHFueL4QwyF8c1AKdi/6/tU5lFavjOa
   KKIF4cslcEm85IYUfJo7nx6OpPCcJIzmh71TT2mbmPUnGJsdS1YrLtDPz
   YOra0xVchdPLqO9dMqD8HGftHTQIFDbB5HeuGIRxumsu0dcWJ/P16LH8a
   1tWTXjOVyetGwU0avxHQx/8nuU6Voh02rjoAjXUNrgYHpVhzwpkbBw3ww
   gRZC1XLGRvYGr5a7ngYPcZkhlcD9h9P8K2K7VqPTp/4edAj6HuYCjxKgy
   g==;
X-CSE-ConnectionGUID: 7AB1f1pnSJWd/8QX4vs22w==
X-CSE-MsgGUID: r6dvcE5pQ7m+UnQoQ73l5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27410832"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27410832"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 17:08:09 -0700
X-CSE-ConnectionGUID: hg4/vD2/SVSDn0krAmwt9w==
X-CSE-MsgGUID: iu79hvhESLmeV1kieXvXjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="105710534"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 17:08:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 17:08:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 17:08:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 17:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5raoCCbZiH6hY9c1fVsIZe/U8lyjt9HAzImyHR7F+z8YWMMAeQGedUpLT54bnTByhGk4vJZp3WlDZ6j+NTfHmgaWPcIccznOY1OWMl9z2YakEKEyGSYSs1w9XR75ThYHg+iZwHObKKd45Gfb6YwiMfC4b1PLFvdUhP5WGPJOHUsZEU8lLHQwCd34uT3b2XkA/cYVw+MYU+1ygEwF22WSOHx/nxIhzRhfFHysNCypUejbYdcA4jX76rjtQHV0mb92q68v8tSjuy7dK30zGpVDL/a2D28CEM2ea84hGXl2Cep3eCBRu9XCibYCfPRxSKkNRPrWRqL1w9clBnufLqYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvVtEle0KJvZPrq38YBJjudcHE3xdIhCOlbOipGrB8g=;
 b=R0db5qYe5qlheGJ5we6V6fyO373r1GREH1MBJw+JGizm/mRGmFG7ffia075rxH5xR6fX2U3t23PbzA36huDi6+pULVpmI+yGckb/sgR7dVPFKt806e5jDqJdkl1gOYeU3maGnZIWx2O593XCk4GeHuvSJHiY8GEUQmKCM9fkTx0o0JtqtXgSNLivgFPP13LtUeNi+YHz19pQ7q1GVZzfmPIaRhOl5OnmQN09p4yXgcyIMCK56VUr7HHqLhX1CqhpEDxfWF26Z8lGITgsdllaJa49zivy6TNREumNGPA0ASgCwhR7SKKV/inF5v81teVLrWJmgvjrm1u570FDMcCDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Sat, 5 Oct
 2024 00:08:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.017; Sat, 5 Oct 2024
 00:08:05 +0000
Date: Fri, 4 Oct 2024 17:08:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rrichter@amd.com>, <terry.bowman@amd.com>,
	<dave@stgolabs.net>
Subject: Re: [PATCH v2] cxl/core/port: defer endpoint probes when ACPI likely
 hasn't finished
Message-ID: <6700836317627_964f2294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241004212504.1246-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241004212504.1246-1-gourry@gourry.net>
X-ClientProxiedBy: MW4PR04CA0375.namprd04.prod.outlook.com
 (2603:10b6:303:81::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d809fbc-b297-42dd-4d94-08dce4d1c950
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lRHRzfjshk2u7RyAUmtupVSWr4d/Mx4jfSKJ7pXiWIJO8IUoQoyeVrcpSKTw?=
 =?us-ascii?Q?SoRXu+UaWNq4nY+Ygpn7eLUcfRGmGti6oIeC+9fIlAgpvN75P1vo2MfvBnmF?=
 =?us-ascii?Q?q+glLruHDNVajilL5L6krzo8Jj3xY9hig8JAIHOlJHhqydm73hUTj37JHlgQ?=
 =?us-ascii?Q?hhZNgtz/2iHkcXP2S4dKpTQ6vRF51oYwnq4APEyj2FpeVSwinfaGsurD2orC?=
 =?us-ascii?Q?lFnUeyW4skzCdHbYEbR/rP7+RxejMo2xeg+00JWWjBS5Y45RFptsW6tXGDBn?=
 =?us-ascii?Q?DLsKUwi4/4PRbfP4ie2fjI7/EPNmseoroJIe79voMFp8plMYuo0SKR6GutYh?=
 =?us-ascii?Q?hAB9gFaSxUHZrMaW1SBxU9hiOEJT9pvVvbtNkOp+2eIsRQG8gncoUNE/kErU?=
 =?us-ascii?Q?WAl7h7lymbqgx8iK9suTcnx5oNjPHlY37esT+lC8VPtTiNubmFdtxk1ztIkt?=
 =?us-ascii?Q?kxXzgHlAV2Rgc0eU6X9+seUotYkJ7EXjdgnVi33RkjZz5Iiny/V1+3BQuWFJ?=
 =?us-ascii?Q?/GQ0zQt+OAibLiczc5oxyUvxUr9gH+2SuJ7f3hRxNqlmwq3/kABLEA9MIZpR?=
 =?us-ascii?Q?K6Z9NSOHVQxilVBi7uYnBNEvzBkGFNN1odenRdBT3eo/HdXYMwrVfD3HbSza?=
 =?us-ascii?Q?M+SMaDcB5FT3DtJ25zENE1U7Gt1lEJUOGO1NyHnjf6hzPBvROrcLPOT9AxWP?=
 =?us-ascii?Q?gY5H6+9Xwskub9zr37DJlt7Ix3zs0OZ+5MhrINgH9p9Lz90ZXU4wmXAtoDsa?=
 =?us-ascii?Q?Vmle/vcSrLiRheAe0x4jqLJZgsQkbSvaIdQGAxjWB1i+w/AFTZ4TzciLwxUz?=
 =?us-ascii?Q?tcQZkDsGR0wv4DdOvXOr2dVSMwNjhce4FaL0f9iNKjhcfGqdBzfCaxN1/4jy?=
 =?us-ascii?Q?4Yw9ptVo7D1VCpapiyTNcDk3a1HfnxAvUajJudp7hmvc7Visw40gwhx5kjIY?=
 =?us-ascii?Q?ePAd+5Wrns8Zr+5l3mFbmTHOm5FlCaKLyIZpuXTIKrKB7mfFLGkxcTDh4DAs?=
 =?us-ascii?Q?7kfx9UrXqlBYPaxPVxo+rtVy63wmNWRkaHrX/W0w1jh0pPTIebxSTwCxRucC?=
 =?us-ascii?Q?DXhMCBSULS1DNnE/AnYPkF65KhPD/bIgbs36g5fuf6VEHOiHLYCuXqB0WmKQ?=
 =?us-ascii?Q?kZXRa1WhwyCJCMZ33PwgKPtVHVV67q8a/WsDMW25LwGhjstJf3NXAOFMe1jh?=
 =?us-ascii?Q?tj+DKdeI7YBX7T3A3HSCyRzJdCo4qmVUsHQavQAwcVLlx5ygpfY31xFN1zpm?=
 =?us-ascii?Q?Rvo+8aAIFIuEk9H8Te63hAkFHD1BYtiWLlvaXHckLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKN1J3ZJE9cC8JvguwKEviwfaBLA+u5p1V6/rlxPjLPLWmjUq8LXutiC/Z5q?=
 =?us-ascii?Q?DXeTPD/CJuhcpyLMvcWpZIuak4hOmrN46JoaBwJ9DDqLUFf9J1fqluQuFRFv?=
 =?us-ascii?Q?EBKRCDsWhrB93j0NB6xsHtBDPEyBJhtp5ypsQKio6zNjxuKa+PNyY1u5p/2z?=
 =?us-ascii?Q?sxXweIbKzQAjLNQS6P9BIf6yxafViRwWEwMhgcCQ3TzwfvB+UO7t/4Rj2lx7?=
 =?us-ascii?Q?bK/VflXZ1PLcU9alrOGg+lKE2LoVzhBOwoVYpQ4Yt639I9F6x4wKykMbMCPM?=
 =?us-ascii?Q?u5G4cWA2l6Z3/XNSaftM2CAXQ81uOxdMMTR3q2LwIvEnkMCbWxddTfZOdh4C?=
 =?us-ascii?Q?0uRq5ghaWi/XDNOqxCHw0ZTg67oYOZqb+Z5tgQwMBNE6G9Z706pDbbOzsMi1?=
 =?us-ascii?Q?rNBkDEOGcwxMJs7GsiS9HMiFvLYxUsFMT3j0VUi3oHP7SaqxS8Ik+Wp7ZwUC?=
 =?us-ascii?Q?TJSyH+yR6MKLBonEnWOUgwQdWYDhN64aal/ECqsPgbe9+//lQzlq7TsGG1W1?=
 =?us-ascii?Q?fU8rvcURodYyGm5qLxDDPHcqnT/d8Nf6fucPZjyIbtGCGI7xeqQZhlI9QLcv?=
 =?us-ascii?Q?UZ70qPa0eidSL6ZEX5cQx4Dre3cK/sFNKYadQmFBSju3uooX/TKqgc/Yyeww?=
 =?us-ascii?Q?h4MhP3CTE9uEzedSb0aYy87JqtPPKLPr5mXK9CjewbfzB+DZdcX8c8F42tjv?=
 =?us-ascii?Q?FJxiGtJtYMRTt4dp+ovXw6fXgADFCijGcKn7Sv3N7oau8xonY7DbG+Wvwrxp?=
 =?us-ascii?Q?sVFk/FqVmYIcj4ifMCf7K37ysuOHMpDrrK2tEYulbSagJWgEWGGIbbwinaQr?=
 =?us-ascii?Q?kIz2o/Y/gcLoRq0zdsp54pOLfp0UM4FAw4LChJ173iBepAvwQzYRmBnOgKMr?=
 =?us-ascii?Q?4jAydZgvxwStIXQx1fJjdrss0iM6a5c5Xkod2o8ekxwZ6HLHGDEjbfx3Gpw2?=
 =?us-ascii?Q?WLMDHt4rsODrNBB+d0l63j3RucX9OP/aUqRVu0CUMYTBOgomEXMnHlUd92kP?=
 =?us-ascii?Q?hLEhh5bWJ+k9dd+MBF1MEBir48gJITRYmbySUpnejY+nVMt8T6sSKv8UY3Mc?=
 =?us-ascii?Q?Iu32SAuNW8YSF3/K3Kz+7RG+vRnzntNcCkMaKmY9SeiiAe3RHFNAc1fCNtxU?=
 =?us-ascii?Q?SKgGpXquMtBNpcnE1htsfjt4YXjBUDVCCJc5YuQQU4SsZfUf4JgYLuUeKs5i?=
 =?us-ascii?Q?anCLZIN7W2P4vGf71BpO52yOApsT0mvgdLUhzmrsuwjLl2tV8ky02ueWKGos?=
 =?us-ascii?Q?dWYo1qj3nosrDPtWt8wNwaah6baG3qUxxZM5WgxUQlwkICDJIAv/xOOROFnb?=
 =?us-ascii?Q?DibNiNYLnSBTg55I7lx0tkT0JTQtBKdOjSJSaOP5kp+ldEFCeJALQHe6vlVf?=
 =?us-ascii?Q?wrW7Pptx3315Mc+4h4oPoqMFppO9iPfSWUL85ifj0+MjKe+X4mhHCO88pVnP?=
 =?us-ascii?Q?ND7IoK8UEIG/QI1Ir2NY0HsNQa/PESD7xXazgtk9G5XE5qOU1rUS3tU4qYBp?=
 =?us-ascii?Q?nBjB3U8ONQxVNfgvPdvI8+PFrydLas5i6Cz31zt9zkjDVT63HL0QDIxh5Cnc?=
 =?us-ascii?Q?Y8YEe38T7d1B+kWg/JmkeQ1nw2HYzYyJdOH7nzKSkWhNaXUA4CUol7509OB+?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d809fbc-b297-42dd-4d94-08dce4d1c950
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 00:08:05.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oc4QRR2U7agloJhY0cATSl4gYTYcMo8XNvgKakj9XMEBoUMLrBZEFoMsNEzSrjWcCdMy/VofQooIvxOUUdN83byI2vuDnxPPvWFLShBOJU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
X-OriginatorOrg: intel.com

Gregory Price wrote:
> In cxl_acpi_probe, we add dports and uports to host bridges iteratively:
> - bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_dport);
> - bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_uport);
> 
> Simultaneously, as ports are probed, memdev endpoints can also be
> probed. This creates a race condition, where an endpoint can perceive
> its path to the root being broken in devm_cxl_enumerate_ports.
> 
> The memdev/endpoint probe will see a heirarchy that may look like:
>     mem1
>       parent => 0000:c1:00.0
>         parent => 0000:c0:01.1
> 	  parent->parent => NULL
> 
> This results in find_cxl_port() returning NULL (since the port hasn't
> been associated with the host bridge yet), and add_port_attach_ep
> fails because the grandparent's grandparent is NULL.
> 
> When the latter condition is detected, the comments suggest:
>     /*
>      * The iteration reached the topology root without finding the
>      * CXL-root 'cxl_port' on a previous iteration, fail for now to
>      * be re-probed after platform driver attaches.
>      */
> 
> This case results in an -ENXIO; however, a re-probe never occurs. Change
> this return condition to -EPROBE_DEFER to explicitly cause a reprobe.

Ok, thanks for the additional debug. Like we chatted on the CXL Discord
I think this is potentially pointing to a bug in bus_rescan_devices()
where it checks dev->driver without holding the lock.

Can you give this fix a try to see if it also resolves the issue?
Effectively, cxl_bus_rescan() is always needed in case the cxl_acpi
driver loads waaaay after deferred probing has given up, and if this
works then EPROBE_DEFER can remain limited to cases where it is
absolutely known that no other device_attach() kick is coming to save
the day.

-- 8< --
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..6c0cd94888a3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2088,11 +2088,18 @@ static void cxl_bus_remove(struct device *dev)
 
 static struct workqueue_struct *cxl_bus_wq;
 
-static void cxl_bus_rescan_queue(struct work_struct *w)
+static int attach_device(struct device *dev, void *data)
 {
-	int rc = bus_rescan_devices(&cxl_bus_type);
+	int rc = device_attach(dev);
+
+	dev_vdbg(dev, "rescan: %s\n", rc ? "attach" : "detached");
 
-	pr_debug("CXL bus rescan result: %d\n", rc);
+	return 0;
+}
+
+static void cxl_bus_rescan_queue(struct work_struct *w)
+{
+	bus_for_each_dev(&cxl_bus_type, NULL, NULL, attach_device);
 }
 
 void cxl_bus_rescan(void)
