Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794966599;
	b=bA/MEDutmRq7kTYpGtnZCkDLuOLqCrBM5wE1ntwa0IMUTscRFHVoq7nRCmbzEW/2axuW
	 ZMEt3fLe5w5cf0U9WMi01VXLy1jX5UOg1KQx6693Vkp9A7JzgXgmcrHMY7fjtZ9RAvyfz
	 ZPVgbfAZ1aCGj9DFWRe/frVYuiwwPLWhHTEMDT6wjeIuqGQK3T+YHKsHxxyOpRhaQY8Dw
	 /JBw0aF+HFpI0+yPxZ+amGtEoUl+09YCo/NFuPcu0Udj0EiLwwnmDxRbERwtZnPdVlJ7P
	 1PzsP5S/8Q46d6ijngpbkXh2ZBu4ca0aC5rRaT07rZG3yFQG+rB/IOWYH65jhy9hBZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966599;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=NBL/d8cdVKHC+ARicpgJncDKvQfFkVbg+OMzbyRdrSE=;
	b=B/qlRmkTMGnIdxQ2AMUjtZMKwjB2wWx3u+SXfbPNgdLsJ6sIlPd8tmiX+0XjMkjILCbA
	 RP1tjPCJ19oBWurZ8hJdwGAxR9D6rSj67lgISzhEXVPAnak2fTkD03Hx+5w5FqpJyVwm4
	 k9urJTNZHeU81lLDUTRdiy3fXthYqj7KGDDRDZQjGi9jAY+yN1IVrhYYypH9L5lnjVO1f
	 f0rIp24Qn0bx9/mZ5rE1Hn5uP8fUGNVlxkKYSqISB4k+K7Pd07cbqRAMvbm8RmeFfPAxw
	 XAq+PB+zLO855uGSvNzYv6rcmhak0FsMyORl/fVV+4/nqhMR53apUjWyJERaewmyl4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HeRDL6Ek;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="RcXFud/r";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EB606A31C;
	Wed, 18 Nov 2026 01:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A1EB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HeRDL6Ek;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=RcXFud/r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794966599; x=1826502599;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JIefYeWvYLbirzd/03gg4KkjEGMVLupl+VBCuJOGq4M=;
  b=HeRDL6Ek1WOmV2Drk0JK+Dz4Ho0JlMMwdex7TblBIgPo/gyheGJFXhQU
   goTz7zKMUx0KYdzTjoLevEFCEu+IhNzabmkb7KQUiz0sF8AumsCZOK7bD
   bfaMd32BKjEXWVPGVwacoPaerIFcOjHTS9tV3lvh5QDU8AS8+6xJk1mj8
   bmSP5q48C125CIhpwyFBP6gDZZEbD359y5uUCgizFYpJ8gqO19xTxYIM+
   rTWVT9VKMKr7kneLaUcAeOuK3mlixPYzqOy4y5jmZVa5GTcuS/Kio8Bz5
   8jiDRfbzEfMXqYf3H+ASBtYOJIQ2dDAA585bFal4toC94ZMfJ9cISPdam
   Q==;
X-CSE-ConnectionGUID: wz5kBAdTTBq7edrwMiYUWw==
X-CSE-MsgGUID: fL+D4o76RxWGIAJBDeDqRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3772275"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3772275"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 17:49:58 -0800
X-CSE-ConnectionGUID: KZLtvJLuRlGUsiXkPAle2A==
X-CSE-MsgGUID: i64SJVc1SCezaD4gfhTMTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="11916287"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 17:49:58 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 17:49:56 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 17:49:56 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 17:49:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e613JskJ/4MaUDRE2Kice/n7l6qyDVZXA0A2U0UT0YUkchNTY9opYE0cvrc9M3Z6AMIFmvivBzoBCAJOEKCDU9jRIdMbsR6CsxKgXCL9eWawuMryQwfdnbMofRVSsoZD+y0iaz+hYJAK0/NxyS6IMZ+ilG4l3J8ECcl3r0PGy/dz3M680vE693DZPWCrvWsj1R0WXqJ9QCug23fTkU+IPDkyanQghOqusC5GdqGOCqlFbIOiKepXVK1sJd0WfxJBURKsMnf5q68IGACJTSMfNyiCekOXeT2aPMJriBtFI/GZV40TY/O9TV694fH0qKuZHVNjjZVd5d5KRpMdVewR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBL/d8cdVKHC+ARicpgJncDKvQfFkVbg+OMzbyRdrSE=;
 b=ozdVgiruHzZXEUC4OD3rJpSFhKUHFETRu0OWhWxTvzq+HNY0Znu9nfEB8jF4oCg+wUL6uJMw50xBQ+K+D7wWwHQZ6WNCtuzjQULTlhS6SFEqANGPXWz3x7ilbp/wgDkkQrI2fsWeQ/q6T5QMeyOIfhFa2jbTLNo8RaFzQXfGJF1Fz+XnfWDfXC0gri19Z1rGydFzoKvH8VycOWglqykFhU1wXtKWdXzYACfC9jdJJxnuFj/GDQ0C1GAskrxJnZRrR5SBG+aDElV9FlR4EL2Hf/vISMQTtVz9tqavUIlfuU6oHj/keBVgVb9kVedr76Q55eDigeMnR+vZSJpSA4Tu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBL/d8cdVKHC+ARicpgJncDKvQfFkVbg+OMzbyRdrSE=;
 b=RcXFud/rkh831H6BJ7KSwi6Lt/3zo0Bfsi3tU5FsIc82PnAIArXc3S3Q9Bc75rFkRBhzN/qL4OwE7wq6bO2DwLYo0OSGFyK/1TDvZ//X6hs84S10Dcqn3mQ/ewcpfX4stRlaPi8T5NReNOvLqnvmOGdMyGVAAhG0skUJt55xUp8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB9773.namprd11.prod.outlook.com (2603:10b6:510:398::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 01:49:46 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 01:49:46 +0000
Date: Tue, 17 Nov 2026 17:49:42 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Jongwon Lee <ai@linux.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] cxl/edac: Skip event records marked NOT_REPAIRABLE
Message-ID: <av0ENg0EwkGRVY1R@aschofie-mobl2.lan>
References: <20261108022022.3352-1-ai@linux.com>
 <20261108022022.3352-3-ai@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108022022.3352-3-ai@linux.com>
X-ClientProxiedBy: MW4PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:303:83::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a35da5b-056c-47d0-f216-08df4516394c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|261009223027099003|11063799006|4143699003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: asPztWYtftkEZ3u7L9zbpPdB4BJiCaz0BCYvTyfwAqM3ExGW90aCd/BmuzVASAg72fr7N3eraXh7zlqbBbAbWrr6v5pp2VQWqmAaasMpK9CZQn2B2HfVbUzPTSxI+RmyQM1GEp1fTeUeIbDuP0kJYaSWS5ORpWoXuCgM2U2C+KtGXWhBLY2xnMhJGmgDagce/QR0HBod53t5znfDE8DwPLT7yGxSX1yIHXlhJmncHWivVmcU5KEJdHhkJKmJJLdRJu3+K99vuWRNYjL74Stm/eXUHwCLWsP0QuxFW8YusSFlds3isLS20uxaaKMltt1LClnQ/T6UvDJinAQciPo83SceimrrQbUciOTpUJJvI18OLbnwso2u2pqy5HmVkdWRi7cn7+42XLT6GG6D9ZY5nnWhsws0YjG4CqLaUudsd7we9bQ1GpDXHyd5fAe0vCLTTlg6/oPKNM33MMIaf/1Znli1WicSYV1rnVHMYzXrMzAgU3IDwzL7i8QrJpiUWucDaaocPoN05+fh7PQasiEQKeU5CYtRlKAk2exmMpR4n5ZzP3oylrHnSlXZsoKScDHTx/BWgqoEpUS/YeW4FYnWd1N+JwirVrEtd6Xm1Jc+Ueyr/xtZNI3iTn1PLYNv11xsAZU5to369s27JUpYBpyjUBsrUbcA3lEPmZLbSxPL9FY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9RdDN4eGtuNHk5YUs5dHRldlIvTGU5Q3EwTTZRTXRDbnExWHQvZFJlNUc5?=
 =?utf-8?B?K3FqRzRCZlJTaGQ4Smp3Nm1OOWcxK3h5VW5VYm8yVitqVWVwazEwOUp3VnZt?=
 =?utf-8?B?Sis2ZkswZG9aUGJjQWRrVzRRMXZEY3N1NDBQUUFEcUVuSjBWc3NHZzhkNzJz?=
 =?utf-8?B?Z3Bub3pwN3VpV2lxVm5tUDgyQTZ4OGJsNDVmZDdzd0hFTS9VNDRFNWRKYk93?=
 =?utf-8?B?VFhHSGhNb1NoSGFYRG1LSUNvMVVvaVVOZHpaS2Fxd2RJYzAxN2pVajNyamRJ?=
 =?utf-8?B?Z2xGdlo3VTBTRm9pYnJjaVFoaXBJKzdHbnNHeklnZ0NiZlFXUUlFUWVFN0wy?=
 =?utf-8?B?RmZBZFBpa1JEQVhzWDNBcEhoZWZNUmg1eVlwOGFIRzJLZEpTNlljWUtDNDZS?=
 =?utf-8?B?UmJ4WmVhS2ZPL2xDbTRlV0hESytka0pXL3MwRUtMR0h2bE5idUtuYXM0allm?=
 =?utf-8?B?bVhLbS8wM3JYRXpLaDEyTWg1N3ByVVM2NzRPeDluZFNLa2ZkOC9aL01PQ3p2?=
 =?utf-8?B?ajhSK0VzeXUzS1hXNnRDUGN3aTJHaGFmWWM2WGd5Vzc0eW11OFREclZVY2Nu?=
 =?utf-8?B?YUo2a2UrdHFwbEw2MDh2T3JDbXNBRHVVWW9pM0RqVXFCNGJ2cEFLcGtZN1do?=
 =?utf-8?B?dzdNNHRSSVN4MnV5RUJYNEpyNzY3aGI0T09odDd2Mm9iNGdIczl3OENlT3Bi?=
 =?utf-8?B?YWduckdzR01nVCt5WVJpd252NElHbWVSbmxQRXB6VDBKb0F5b0xMbEhUejFa?=
 =?utf-8?B?VWQ5TXh5d3hHSGZQWGlKTy9WbW1jTHdmeFBWR3lJK1pMNHA3cWFLcVVxZ1dO?=
 =?utf-8?B?Z003cjUwWERkK3RHQ0wwOTRyZURJRDNCNzZmdlZHR0xiU1A3d0dnbk54Umlw?=
 =?utf-8?B?MzhnSTVJVVF6d3JsRUZqR1ZjeTBVOGJiaU10RC9QWTRhVmFXT2pGLy9oOUM1?=
 =?utf-8?B?cjdabHhNbDVDc2hodjVXM1RCUHhpVVRUeVRmMzJ3K2xNT3hZaEk2NFBtMUY4?=
 =?utf-8?B?b3pkWXJXYjN2L3BMTXRCUDllM3B3YWdhSVZPZ1hhMmlFYklIeGlIS2EyRzQ5?=
 =?utf-8?B?NEtwMEN1ZFhTbTkraEtVdkFHQVJMaWpTUnhjTC8wSFczbVNaZU41ZDB2Wk1y?=
 =?utf-8?B?eUwxL0t6REwyOGRVZjVjeFZQMGFhUkd3bFB2N1MzZy9PSEh0VWJjc2lQUUc0?=
 =?utf-8?B?bmpGRDNIN0dmMmpPZU44QUk2aTNraVN0VXEzZG1DSFVIYk1EQWp4alNmSXVS?=
 =?utf-8?B?K3owekVTS1R6OFhPUWZZeTB1TGFtZDlEUE9iSWRvNXFSbEswRnl6eXRFRVZs?=
 =?utf-8?B?dHc0dWxZTzJKenhBSE10dWtQanJobUMvcTRNL2JnVnd2aTRWcWhEMS9Tc2Vz?=
 =?utf-8?B?bGJtd3VhN2RhQW85di9yY045b0xvdithd21uQmlPcmFaZHdkWjJ5ajA2bVpx?=
 =?utf-8?B?MEsrU3gzUVFJbE5BY2IzRzhEWkpsYXFHWmxTRmVwa2EvRVpJRTg5SFdpS3hV?=
 =?utf-8?B?enhRbWwwenRYbXZzZi9QWkQ2SVVhaVF1S1dyTTdwN04rczBCMmNMSDNqOVR1?=
 =?utf-8?B?OU1ZOWJMaGZIQ1BrVlFoYVdHTGdUR3FVSE5UNFVMcHo2QnNtS3dZazZxQTE2?=
 =?utf-8?B?NUE2K1pid1M5dXRxYWdiNEhrRVQ1WW5ZeDV2Q2hhVFhRUkhDWldBS1dTeEVS?=
 =?utf-8?B?QktyQXJTelZEd1JXNTJDK2tjcE9CY2YzclVGODE1QUh2bkJjbzZyS0E2dW13?=
 =?utf-8?B?bjA2OGlXOFF5VUgraHA1VDVLTnRqaFgxdVFzNWt0KzJ2LzNzZTN4d3VMMHlZ?=
 =?utf-8?B?dzQrTFZ0c1dlT2JDQUdoTWNicXF3RnVsQjhjZ3hPRFluWG03R1BJRDJNM3Bm?=
 =?utf-8?B?NWlFQU0wLzZpTnFLNm1Ud2prSlFYY2RGWmxzanFmYjEwbi9zUnVYTHlYVURs?=
 =?utf-8?B?eHR6RkhJaHNydUVjc012Ky9sL2RkdGluczZLR0N2Q0plelRJV3dFODZlMDZx?=
 =?utf-8?B?ZHV4T1dWVkgyYzR5U1c5b2hXb3Nkcnhzbi9qdHNZUGl4WUtBRjhMMmVMUFBo?=
 =?utf-8?B?YklSSXJWdzNoWC9iWXJycmR4QTRUV1BsSFY2WWFrMFBPSkJ5dG1TU2ZMWFh1?=
 =?utf-8?B?QU1FL2dWYnEwQmIrazE2TU9pSW1jSXNlWTZIOHNHd1l2VjFDSmJ1NWVKc1pU?=
 =?utf-8?B?Q1cvZUZHbGE1S1B4MGE4ekFSY3pGQTQ0bGhacEhVaUpUZVo0aHpTeHFUZmQ0?=
 =?utf-8?B?WnFLU2YzUWdNbjVWY1g4NFFadExQQTVWSDRuWll0eDNHb1N3bjFyR2p6d0NI?=
 =?utf-8?B?MGpyZWZSZEJDRUwrR1VKOWlZdGFrMWMxd1dtYUtVRHBMOU5aVXROZVMyU3FP?=
 =?utf-8?Q?EqShM3vaQZB5zwfY=3D?=
X-Exchange-RoutingPolicyChecked: ey9HX6rfNRQhjJxp04RGN0CjdI1EgMke7rWu9aC2xZKO77HnZUEDpjZk2mV3wo8ATXZSr99dEo3LIWYD+lw154nYzwExLPE6eLYyzdoUfI0RPxEYNeOKmdW/4lM9bu4bnlJvk+3ZRpEzq0kjIhiHwz5pyuwsk735M9iDxGhezvTsMKZsypi65BZc+jXq4yieuVHxovG7CcZxGaxznm54xepjk0kHiIRCj1lx5tx2avFFgjPcv9XFuIzIJA5dNrHPtTXFYrpQTqW+SaaZHwu3XqDabBCe4RrI9QklN1VTiwIsQ84WpV2E6hO4LH//qey/DQXbvJJUUHS2TyzHHvDgHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a35da5b-056c-47d0-f216-08df4516394c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 01:49:46.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osUdAjEDzyOntBKQzCXAyL2ReMNjWCLH4Xf/6n0kyxE8LMlS9MKIVDSxJHGtmKJaOGzWca0A/3bqphkbBC9eHTBuV3zttPthNOuNZT7yVHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9773
X-OriginatorOrg: intel.com

On Sun, Nov 08, 2026 at 11:20:24AM +0900, Jongwon Lee wrote:
> Bit 1 of the DPA field in General Media and DRAM event records is the
> NOT_REPAIRABLE flag. The device sets it when the memory at that DPA
> cannot be repaired.
> 
> cxl_find_rec_gen_media() and cxl_find_rec_dram() do not check this flag.
> A repair request that matches such a record passes the lookup and is
> sent to the device. Since the records are keyed by the raw DPA, this
> happens today when user space writes the DPA with bit 1 set.
> 
> Skip these records in both lookups, so the repair request fails with
> -EINVAL. The trace events already show dpa_flags='NOT_REPAIRABLE' for
> them, so user space can tell before it asks for a repair.


How about writing “so these records cannot satisfy the cached-event requirement
for an online repair”? Offline repairs skip these lookups, so the current wording
sounds broader than the check.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> cxl_find_rec_gen_media() now reads the record, so take the xarray lock
> there too, as cxl_find_rec_dram() does. Also make it return bool, since
> its only caller just checks the result.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Jongwon Lee <ai@linux.com>
> ---
>  drivers/cxl/core/edac.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 4624ab4644..42683b7c54 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,24 +918,27 @@ struct cxl_mem_repair_attrbs {
>  	enum cxl_mem_repair_type repair_type;
>  };
>  
> -static struct cxl_event_gen_media *
> -cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> -		       struct cxl_mem_repair_attrbs *attrbs)
> +static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
> +}
> +
> +static bool cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> +				   struct cxl_mem_repair_attrbs *attrbs)
>  {
>  	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>  	struct cxl_event_gen_media *rec;
> +	bool found;
>  
> -	if (!array_rec)
> -		return NULL;
> +	if (!array_rec || attrbs->repair_type != CXL_PPR)
> +		return false;
>  
> +	xa_lock(&array_rec->rec_gen_media);
>  	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
> -	if (!rec)
> -		return NULL;
> -
> -	if (attrbs->repair_type == CXL_PPR)
> -		return rec;
> +	found = rec && !cxl_rec_not_repairable(&rec->media_hdr);
> +	xa_unlock(&array_rec->rec_gen_media);
>  
> -	return NULL;
> +	return found;
>  }
>  
>  /* Caller holds the xarray lock. The record may be freed once it is dropped. */
> @@ -949,7 +952,7 @@ __cxl_find_rec_dram(struct xarray *rec_xarray,
>  	lockdep_assert_held(&rec_xarray->xa_lock);
>  
>  	rec = xa_load(rec_xarray, attrbs->dpa);
> -	if (!rec)
> +	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
>  		return NULL;
>  
>  	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> -- 
> 2.55.0
> 
> 
