Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18581519A0
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053665; cv=fail; b=dhSn7dfNhqlrg3gHoSolEyFEWZvIHgb2E2wFi+lJtlUKxrBiskBZbWN4ibupn+0Vw0qjMj7OwAYhfI1JMMPlF+Ks26Tfp8+q0HJJKDUt1y8UUoJ0mq8kyyqIWC2EBLrkkZyYx6vCJ962Fgbodmb+xVU/QBm8+g2ICDL6L+v9bL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053665; c=relaxed/simple;
	bh=Gg99z0TytZYkp/H4AM0f3yGM9qYHRyt9u6Vxn5mi+Kw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=JnADCIIJEXzKoAwipBtlrRS0ZENxf/WQ4pZGYGE24qNuP7rIvI+/cUXMndwu6uYlVwYdaU7eTHKkaxFYVxO++Cm6yOrypL1huasXRkzh9fvyxIfopgYWudxzO99B/YPUE+t5Ap+ZVH4iLYgKD5f1AH/3g3DI4etqVKfL5UHw71U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sv8bTohu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sv8bTohu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755053663; x=1786589663;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Gg99z0TytZYkp/H4AM0f3yGM9qYHRyt9u6Vxn5mi+Kw=;
  b=Sv8bTohudDri4kYEzJ4AlMydmxVp5tHWznYA9wxqEalQuoI6Eb4WklGm
   E5QihIZMmp9BP80rhsHC3y4fbr92BPAsbkJbjoJxHHoCp2SsDduMEwtGv
   KxwRAH0SoHBgOHfO8/YGnlJR0G0mD32NBRfvj3/tEBACVMrppYXYg9EX6
   k5sooBmGRHMij5VNAHXDTzmWUGDsDKfwTh/3P3/tTexCUk/mcOCtMYKpi
   urJscOFYI73qR7lNQnaWYngH+hCtHG3i2h7ij9QWulRQccvW6I2ZzA5mZ
   1rFnT6nMzpcHggULpS3dTKqisYISGg9coZPVnX0FJvaWY0W8VL+V85Z/A
   g==;
X-CSE-ConnectionGUID: ZZVB3MBfTvO2q69kdvWlnQ==
X-CSE-MsgGUID: ZCSTfLCISIazGyrLUmyIWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56364383"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="56364383"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 19:54:23 -0700
X-CSE-ConnectionGUID: DB8YNkiXQcmHFLi2pIqcfA==
X-CSE-MsgGUID: Kzlk7V2kQNGfqDFRD3gQCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165853617"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 19:54:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 19:54:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 19:54:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.82)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 19:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PavXCqVa3q3FgKrWukGxNC40+5UOULibKKlr+bjsjc/MxxPEkdBNAB2ZajpfJOk9m/2gzsmuBvLpicoY6+UzaviOFyV75BZ17jyI5mugwUKgV30Aq/WgttSwi1t4khGeJ2a2ZN+k54Y/fy+al0/nU4QBdIv23LikjV84JPJVbmASUyl3ozZ6uSjSXzUQVFqlS5630SYVLmA7bDRV3e9LB22DZJpXu1kQ4WDUV9ptMf5Jxrzl+TqNC1rSpe88x0iq/HUrssYPIlY65uHhoaYtSUsP/IkOH/y61hLE8t9fywnOpU9jYx6nt0j7GaJz+CMsezFRWbEbR4xvFPV4ueRsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn/hcPVTJpf8QqFaDxVrthtqIMhTBC3+yy+6z1MfZrs=;
 b=R/0oPmzObFUKY374awaHcibG6ogM++pxmS1TzUoHF4JovmnT3Wzj0Y54wYOK/TQDtSLhJwj4qOyVNwIWUzFoNsjFIA7+bctYJtCJdnxm5uWBT8Ip+cJQjCMMM7yYiScx4H9oBtWnSxDutWhnXxBAO2K9sJRfJdqHlXlZWeqIj9aIF6Bkta3Yc8cOAzl0G4wbsMJqWEd7yXf5vOUfH2XnlCbI/Dl2Yov+SJqUf0tNTcssogGUKC86jAI7GkSIS9P9YEMv1DTKLU4nfefinfBlQ16P+t+Ytrp6b0cLaEQA/GF6guWl/V6gOhf1Mi0M4W3/XP8R+CocxPM6N985Z/JsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 02:54:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 02:54:20 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 12 Aug 2025 19:54:18 -0700
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Message-ID: <689bfe5a9815d_50ce1009b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <e2ffaa6a29117fd9832542e4ac314b46ab2d1fd8.1754291501.git.alison.schofield@intel.com>
References: <cover.1754291501.git.alison.schofield@intel.com>
 <e2ffaa6a29117fd9832542e4ac314b46ab2d1fd8.1754291501.git.alison.schofield@intel.com>
Subject: Re: [PATCH 2/3] cxl/acpi: Make the XOR calculations available for
 testing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ab892c-b1a4-4348-69d9-08ddda14b3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2c1a2NTa1NIaWxhNE5PMkZxRUdkV295WndvSUQ1S3R1TUpnWjdWSGRrckE5?=
 =?utf-8?B?eUNYbkpvMXNwVVVQREltQnRkWDV0dDYySFZHOFMvd3VGZU9XeVFNVG04ODdi?=
 =?utf-8?B?dlpnKy9mMjA3eVk1QzBsbTBCMEhkd2kvT0hIdlFMbkFqN1huNkQyazhGbFhB?=
 =?utf-8?B?SUNDNzFKSUpTVG55bEptb1FKZjZNTmdoVFNMcUU0ZkhsZjlqTUYyM3laMXRU?=
 =?utf-8?B?UEx5SzBiZGI1ais2QXhybi9WR2c3MHZQbWJ3YjVDYnhZZ3R0WmI1MEVkaHUz?=
 =?utf-8?B?UWJhTU5xZXRBVmdsUGplMVhCbURFR1UvU0VvQWlVNE5CVjR6QVdnL2J5aVUv?=
 =?utf-8?B?UWRPOEZucDdlUk1BMXZRY2dKVllRWit5cUpLUWlhWnVMbFhQVjV0YzFVM2NW?=
 =?utf-8?B?SXJUbERqSjdkZnh1Ujlma0lITGxMZnpFT3cyUEUvVmpFRTRzdnd0c0k0OXZv?=
 =?utf-8?B?SkNNUGhORXFWcXI0QnkyVm1MY1dORHVMZk01QmFsbUIvdmhMRFJVdnU4azFp?=
 =?utf-8?B?OEtyekdSbGVrbHBjcDR5N2lPa2VodXIybGF5TEx0aUVXYnVXbmNEQklsTlow?=
 =?utf-8?B?UlIzaHFlL2NZWnVlSDdBSHA0bWdVZzZPL0VLNitoaTIwMks3bUpMZWsza2NH?=
 =?utf-8?B?ZkowZjJJekN3QnRUUE5XUUtveUpDTS9XVWRsZEZaVVd6cHBSTXJHSEowbEFa?=
 =?utf-8?B?V1NpTllTTlRobmt4UXBON1pCNVVvTkFrUTEyejVtVEI4MjBXcUZiQndxQnJO?=
 =?utf-8?B?Ykd5dG1kU1B2WHRWMkphUDdxV005VlI1R0ZraHFYNXRZb1FyZVMrM0FnbG5w?=
 =?utf-8?B?UTltNzdUMHJLek5OUExFa0dKRTJ0S2VBbndVN0hRakRkeUZ6RExldHFYTUI0?=
 =?utf-8?B?UnhaMlFYYVg4TmRkWHNpWkI5L1NpQnZKemdndmF6S0dGWStRWjhMTjk1NmFN?=
 =?utf-8?B?d1ZxSXBJMkI1cHE2bUthYlE4OFBFblRnYjNoMEFwZWdmWWpPcFNpVEFINlE2?=
 =?utf-8?B?UVBENEowdTZjVDlKeWtWNFZZdWJRei9lSm90Mm5YbHlaMzFlTWYwWXNqNnM1?=
 =?utf-8?B?TFJGbW14S3JhZnZEVjBQWXpGNTlNQ2hoU3B5Vlo1VThRZTFEUlJUZ2hqbHRE?=
 =?utf-8?B?b1d6UzdhSy9BN1c2ZVZRdGlrMkhXYUp5U0d4aVpVMFM4UDEwejBEUEc0MGp1?=
 =?utf-8?B?TTZrSHJvWG02bnhUS242U2kwcmRPc3hWSzhhZkF2bE5acFFKNEM3ZWp1RTc1?=
 =?utf-8?B?QzFhMGFLcnc4K3RIRTVqYm03UHN2VlQvM3ltbGZLZyt6VTlZWDJGMnhKd0Fq?=
 =?utf-8?B?MkdSK2Y0MDQzRm9oZno0Y0ZaNGVEUFlQdjJ6eXNwRlQ1UUZFV2ZTQml2WUpU?=
 =?utf-8?B?VUdCcERJZWdJSUtkcS9Sc3RRTHY4SnIrRGVUYngzclFNbWVURnZXQ3VmTXcw?=
 =?utf-8?B?eU5KdWEwWkFuRGk1MjBMTjMvN3F0d2ZVMW1SbzBRRTlWTFBtOFY1NkFvWXQx?=
 =?utf-8?B?ZytaQlBCcnFUT3ZMbjlack9HY1NVNndZTUZmbFEyRDJyVGJkdlZiNGVjQ3Nr?=
 =?utf-8?B?QkZsZGZFdlZtNUo4cnhyLzdHb3RYWlZVQkR0dU9qQlFiM1RtbUp4YXEvSVps?=
 =?utf-8?B?L3h1T0puNit6a280R1BlSlo5a3VLU0s4RmU4SnBWQURMNmY0bnIwUXN1cUc3?=
 =?utf-8?B?K0QwL1Z0UWxhWEw0bFZURm8rc1ZaSThMR1FmbnVOd0hpdk05UkpGRmJmU3Qz?=
 =?utf-8?B?U3h6emYveW15QlBCY2E5aFJtdUo4bkJ4czRhY1R1bzhBMEpNWTIzR1dRYWJt?=
 =?utf-8?B?SWNlWTRMSjdOc2thWTN1dEVKTlFJRXZvdlZ0VzVNK1VrNWMzbVlYdHRlSmF5?=
 =?utf-8?B?Y2kyWU04SkVqRnNLZEcxcWliMkxuallSSVZiMDZCZEdLUlBmVlR6MXJZdkcz?=
 =?utf-8?Q?P3L0SXrGzpM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhCdWYvbFUvd3I3SlJLUSsva0hFNE1BMVBNVjdxdVVUczhYZXJYTC9WSWdI?=
 =?utf-8?B?UDFvc2J5UWcyeUs1S0d6Z3J5aHZsQldsMjlhczg0SkhvdnhYSWVmTUQ4M3Zy?=
 =?utf-8?B?TmZCK29zMHQwWTVVaDhwRGR5K1VpZEFVcGtKLytQWUFlVjNEN3lYQjE2SEJj?=
 =?utf-8?B?eWdSRk9RZ2NESUNIWEFBL2tVN2VnSXBFVk03OUhTb1NHc3VaQld4NXpXMjZh?=
 =?utf-8?B?NHBoem5SQXF2ck9aaGRxOWFBbkg0Q1hLRjlNSVR6MFVOOVE4ZHVFZ0tRTjR0?=
 =?utf-8?B?ZHR5cDYyUzhEdTNZQms0Q1lHekplT0lNMWFPdlV5QTBhRnVBOWhmTW9qVUxW?=
 =?utf-8?B?cjdYbXl0YXByR3RyVlhvR2xHSFNrOXA2NE8rMHkxMmZIV2RiUlVnZlNyRVV6?=
 =?utf-8?B?djJkOTBYS0w5KzNDSWpjcncwakZSWUlCQXJOUEM0NEhNUW45ME9Yb2FtL1gx?=
 =?utf-8?B?YWo0YXg5U3o0QTRTaFVmbW1jb01VUy85SFAvOGV5R0FMUm41TGZ4a3N1YW5a?=
 =?utf-8?B?aWp0RHBSS1hNTVU2djN6WnlGNXgzYkZ5d0ozd0J4cGVVcHhkUmYwL0YyczN4?=
 =?utf-8?B?YVA3Z0cyZXVUSUtlZ3dWYzh6WGkvdGFEYmdJbWt1TndjTW15UlpDclFZRURx?=
 =?utf-8?B?SHQ2M20yRjFJeEhUa1FtU0c5NWVnZUwvNEVmemZCbm5McnNLLzJGblRQU2tT?=
 =?utf-8?B?a3lWVTlGaldNVFM3MXBVcmd1ZWx4NlRnK3B1MkVKV3BFRk1hQ2pJK2g1NDdh?=
 =?utf-8?B?M0FuaUhNL0t6MDFGWUhmR2RBUjJXaytuckcrbSszcnp6L0p0MTB4aEZ5MC83?=
 =?utf-8?B?N2YyY0RzTUhKYXdEK3MvNzhaTVpHbmNhNE1jTFkyZTVBSTF4OW5QVU1ndTY4?=
 =?utf-8?B?VHB6OFp3TDk0SmxkZWduUm96RjN1TjZvcC9xMXdXdm1oVGtISkExRzN4NlZD?=
 =?utf-8?B?c3RDYnBDc2l0L0g0V21zeHlqcUg0OFB6NHU2azhOcXFsbFlLUTg5NU81aGJF?=
 =?utf-8?B?cGpuc1lXNVl4Y0ZabkphbENCUVFPZ2VtQy9ISUNTUndkN3BoUWVTUlNEZjYv?=
 =?utf-8?B?NTMxZnc2bTNhZmc3ZW1GS2pwZzR2c0lISTlBckV2RXZjby9BUjl5WGo1L3cz?=
 =?utf-8?B?UVd5NDU3dUJrRmJjQkdVZDVPOEtrZkNWRlhPTXpzSTlxcU1mcXhSdXRsbWhD?=
 =?utf-8?B?WGtFb2RhWlh2VjhmMG02U1dGeXllZWlKYlVqUUMzMHNFZ1JLM0RQQ3hjbWx5?=
 =?utf-8?B?U0IwOS9wbEpmZlZOQU1NNitMblpmcEdBZmRwWHk0akdIblVFdEhOd3dBOEVa?=
 =?utf-8?B?MjZsOVEwTGdkOEVMcHFXaS90M01vZmRqRVdNNWErQnNSU2QrVDRWR25hZzV0?=
 =?utf-8?B?UTdnN09lOVdPMmZxWk5vSG9qenpTOXl0R1NveWp4aU5DUHRGTGVSQk5lcGhm?=
 =?utf-8?B?ODlOTzhGVWtrU09rVjl3YlNmS29KblU5bHU1clJZT3l4TE0wTzRqTzJRQzlX?=
 =?utf-8?B?aFcvYnNIbkR1aFBha2VVRmZjNUdHcmxod3d4SE84N2x1azBkMzV3Y2JoTSt4?=
 =?utf-8?B?WHlUdE5DMlNGeHRUSHFTd1owbUlDZVZWZFFIQ1NXNTdYT25URXl0TnFPaWhx?=
 =?utf-8?B?Z1lnaFZ6enBDSG1zaTZBeGk1emNvTUJObGVIYWcwR2lKQm9yeWxueTJ5bDBF?=
 =?utf-8?B?S3FMejUzVU5rVWJ6dlc2YWJ5VXNVY01vZE1QYU96cDFONVVJNkpBNmhnajEr?=
 =?utf-8?B?VXZId2kyQm5qMXdrck0xTjVFc2dvU21hQjdtM3B5WDZmZVBnM2tMb01Na0pD?=
 =?utf-8?B?M3A5YkhVaHl5RkpRNmJFa0xvTXF6OXoxV0V0RElqV01rU0RJb0MvbUgwZ2ND?=
 =?utf-8?B?bFo4SDJHQ3A3SHV5MHV3VUUyK3NMSFkvMm1PME1rb1VtSmk5dEhaSHdTeTM4?=
 =?utf-8?B?TGp0eDAycWpDYXRFY3RuVm9yUVBwNFdGZW9SajJPZmwrVGpTdUttSnR6UjFY?=
 =?utf-8?B?ZnZaVlcrRUZtc1FLUWM1V2lXSzhSL0x3WHZwSGtNak11UnFVK3lYZGRIZlBs?=
 =?utf-8?B?Y2NIM2FwbW1XUHhMMS9UcWw2TDJMUS9kN2hRc3NtV1FXWURpdEYvdFo4Q0N5?=
 =?utf-8?B?OWJjdWdtZEMxMGh0cERxeU9YWjF2SEVHdWE4SmpuTjhhUzFEMURFRUU0bTdm?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ab892c-b1a4-4348-69d9-08ddda14b3c9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 02:54:20.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWagtqbcuhWzWnTJswBRYAQGTF0aNsZjlbu28HgL+lW9TSOwanTkCrNO0YQqta+ahnd7Fa5vHE9EBbVShE5MAeX6hTF6Nk0nDSzWBHTIO/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> In preparation for adding a test module that can exercise the address
> translation functions performed on XOR configured regions, the XOR
> function needs to be refactored and the ability to create a CXIMS
> provided.
> 
> Refactor the XOR function by extracting the core calculation into a
> standalone function. Enhance the parameter validation since this new
> function will be called from the test module where the parameters
> may not be guaranteed valid.
> 
> To allow the test module to create a CXIMS without exposing the full
> cxl_cxims_data structure, add new functions that can create and free
> a CXIMS.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
[..]
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index f102c0fe3431..854578c6009f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1616,4 +1616,11 @@ static inline bool acpi_node_backed_by_real_pxm(int nid)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_CXL_ACPI)
> +struct cxl_cxims_data;
> +void cxl_free_cxims_data(struct cxl_cxims_data *cximsd);

This just wraps kfree(), call kfree() directly.

> +struct cxl_cxims_data *cxl_create_cxims_data(int nr_maps, u64 *xormaps);

The only caller of this is cxl_test, it can just be copied there, no
need for the core to carry it.

> +u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw);

This function should be static outside of test builds. See __mock as an
example of optionally marking the function as not static. Move the
header declaration to tools/testing/cxl/ so that most readers can just
assume this function is static.

That said, __mock is currently used to optionally mark a function as
__weak, so maybe this wants a __mock_export for that purpose.
