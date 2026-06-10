Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711212772D
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111645; cv=fail; b=C76IW+kyQX8GHNN8+r4LCAYXhBzs04iFXHPSy/2+2o6tbyz84fgdE6mYRba7EFzclTATuIsdrAqx1MOuUDyjeTWSbHg//ISKbDai53LPzEp2riCRtjYRSVJtGyHor67QCoujuDatyN4BGABaa9VbQ2LK5K1nC2juQ4SjuDZUosQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111645; c=relaxed/simple;
	bh=jkXUBEULik7tzCoShBChMw7f4wQPegSzNKe/ZG4sKWo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oBeNXLW+EeOgDZ0pQLYPOweESCnaZf2AaYLyOZKA7VvSj/LQmXWUdQ5HLBiWPUvULbe8YpSOCX5A1vNaagcM/IwwRzdfrjlo1COb1pGVjZ1lyW8cx1TPA7lKKJOIsQAlPDdNNUgBGeWoFiecwdKi0CD7xb8yLkTJPmoouFw6hzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYQocV1k; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYQocV1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781111643; x=1812647643;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jkXUBEULik7tzCoShBChMw7f4wQPegSzNKe/ZG4sKWo=;
  b=fYQocV1k6Ezt26g8tj2VLbz2txCp0y9eBrRdMhXlGKg/pVwq2NrP/jQu
   sr0Do/Ew2R9rkFThxs23+LMqTUJa/M8jtVeDM2MJUrm5lCgtWGbfeIWPw
   J/dRusNsjVCs8+j+kR1oDPZlZWGydC/5yUUX0d1Qx9XKbxPgzg4oxjMWT
   k9eLFEG6RX255l8ok0d0ioSe1SJMP/3nvpgYcYFQA7HZd6eqn9XaOC/el
   f2gm/WlxXgkvd6N7yBIPTEyzVcqlcQC7o9PsIbJPwq9qnE/SSplIgkrcb
   WUvgS7hYfDW9CksvyG/5IyPQNBCxjgoC7l/u9mZdZRo2AnaMUx+FZ97DW
   A==;
X-CSE-ConnectionGUID: 2ZiD/QmdQcum/vaTUlljbA==
X-CSE-MsgGUID: XgdiNQcnTwqgYYK4rZbodA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81045199"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81045199"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:14:02 -0700
X-CSE-ConnectionGUID: qHj4UBfkTPWpPiEp5tct9A==
X-CSE-MsgGUID: 3TmH29xITQy3YmLOz6ozCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="242097833"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:14:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 10:14:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 10:14:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 10:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4diL8OcDiSxQDf+TXEc6NwOE7oODf0469/Vhb5Yhys7vh7vM0PI2+AtCLbxtlLhaa31ZqcAXI5az0B28ZqeuqWbwW37ejyAvyffUQRADws50tSzMcXXNJ+h5W2S+4MVgYGvwFxAiV/xeGQUerL3+RJ9Zn7idcxOmNX68h4lnDW2ewrpz3JyDIXElgVzOQkeMgxnq//DIpZ9eiyrd4uCUiGM5IGlEhyHr7I7rKBxH7Go0fMVm8WjUN7Jemh90uuTGFvZpyKkhcteJMpz4t/D976GzBt+xA4GfR8J+kLfDwP2wxtPKVrNMcs5h9wM5dyaRpF/cm+CGv0YwTrp0+tfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8fEaBkLvhQzXtw+8pAEVSa7uGLosy1lJXDGxMiiFUo=;
 b=cR9m+igebBleGbPwv+eYDIEJmg7vIhzOXv770vVmt+dOPYFSWo2IjtaBEa1OtoqBDBLJMLeMDLwAikm9aKC/YTBPQWveW4PoN/ixVea44CuwA3kmxKPTWCcK1CihLnnO5NAu5XNCIx0fIo/8sh8aNb0cyMZXHeyDue7F/XbrTZKeIELj1m5b6co3P05byi40moivbh7f2iSOZ4Po4yfTn6GJZHjNf/B56Hz0WEtSAyvy+ENwqOrDDXpA39p7EiNkDk5L8kAPtIeGzbXwMHF+au8Zwa7RUtBcy03jgMGLrcAC+ZtLlQVD4Y6kz4JrPgvjI+vlMYppKASOqMq4ymzYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 17:13:58 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 17:13:58 +0000
Date: Wed, 10 Jun 2026 10:13:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <djbw@kernel.org>
Subject: Re: [PATCH] cxl/port: update reference to removed
 CONFIG_PROVE_CXL_LOCKING
Message-ID: <aimbU8nYlSqLwggC@aschofie-mobl2.lan>
References: <20260610042101.222349-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260610042101.222349-1-enelsonmoore@gmail.com>
X-ClientProxiedBy: BY3PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 767e8ef1-594d-4941-a614-08dec713a8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: WZbhHWz+CWsOEI/L+xsSdN72nDKJ+x9n21TRdMAJvoWMWEapmmAU7KozCI5b6XG/FWIyDUIwPBFusJRqaNjWQ7dxYg/5+baJWwvacooaVF0SLVN1wzYnEkUk7QV+mKhGutGDCTGjIar8O4D4mOMN3sWnAjrj9uXyG3Y8VTnjTndIqXDfJL56Nux9qq2JqyM1d/DNoNvl7ExeqBROrGQyh96ruFt+oiUklRFdmzSvzDtZ0WBMlCmwZiVY97ZMe6o8Voqolchhjvcd2WgBAvw65yu1ITj7Ohv/PtOz6bYmKL0mJLORiFuewpz1JQslSqEjyeElLH5H6IwkrjsYoAW6pM1gbkQ06xEa5e/f4UVpWzJm4/ft7haw9u1g8O2X5btz0sWCr1aHLPde4WoGxT3LyFdDQNbAEXn7U3V0hH2bHZbdHG0Q3S6k59MYwi/GBlYulFz3YIhCeveo8uXRbVFybURWAH89MFV+WSviE/pbONMM0FoIUaQUFkbIg+M2XbOArBV8qll/+fVtwoqR0Wpci3n+O28k7D0oYbl0uYosCTV3fH948RiuLPl+FPQJL8ovOarjbx3xQD1g7Ahhl7Kxai/T8Mcw6sFzz69J75RkJPZZq5+JqEA5meBnz1QzR5j07v5jvdz0eHpscc39W1HPLP+DFLETQlCUsbsXQjBLNQ2dwoJJTAZbdt7TmhTtH6oI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LB27tM16r+LMMz6B38XVOABWT+dv3ivnlYzcI+F9vKOnJveTcS5CDOutkX6s?=
 =?us-ascii?Q?1nCddc3wKLubTSl2+idSzqXAjz+ybBwjMIkOo8t+X4+a7Hen0XVw7tb7ecJb?=
 =?us-ascii?Q?T0s9X9GEtJifudHi0NImOTE6YcghH97Ug8UcdMNylpWvDbMm66766NcspWsI?=
 =?us-ascii?Q?/xKo+q/dGJ1Po32+D7H8CuLIlcsB6jfnBXZITZ9c8f414VIv/O1+WrqH22sj?=
 =?us-ascii?Q?0Va8p+hfjsdu/iy2tKXmK5gBJ9O3fSADoJ40fJ9iU2xEmrHLcuq7IBKjUcS9?=
 =?us-ascii?Q?W8PTpEZy8jFVIehTMxrVaKVUNrF7NviLJxKXHN65AxXQdY7CKmxH/1ghHviT?=
 =?us-ascii?Q?mv9y3RfbvX/r2hxrQStlcO/2ChZCeK2B8ChXDL8FHmdRwAPlefWtz5cq/PGr?=
 =?us-ascii?Q?dWPSmwDFeB4BF1jt9t3IuY4CbwwsPCrvk6KDK3uZLoBeRuLm+R+3JpqgoTKn?=
 =?us-ascii?Q?JA1eWoGoKILJZ+cKJB0i9UZfWClBgcWbpEkhYbIln3KzKJclsfCi1pYhqmOE?=
 =?us-ascii?Q?QdzwjpHg7fPDHqx2joaBVRhdMzKsQgszxyoYN3A/lO2ZIi4UDL0T2N0jvKDX?=
 =?us-ascii?Q?EdJPAAuz1sPcuqF+eO6nZ6X+lej+gxpjqQEouLEpLWgyVHlMO1KiH7M4mo+B?=
 =?us-ascii?Q?S5ElgobNcKCm5jFRF0/iis59fe/UrmMKxV+97c3bg+MbXLSPbjMgMiUAnqGd?=
 =?us-ascii?Q?TlCWsJD3kqDYgzJJxHeKu3rYUd53jslu3zSdvoLc1prJGrDsl1NS16mrDYbb?=
 =?us-ascii?Q?DA8fmmQjaXQp1NVehO0Oq9WOFhKcr2B0/hTLIwPmgrD+RgL7HafbjdHZGyIP?=
 =?us-ascii?Q?tNVSuUjCKISb3xLP5rWKLOtiCzW3Q1TWDe8qslW2eO4P9MHvqUgL7yzpF2aw?=
 =?us-ascii?Q?6ZbHJ9a0Zx71LDHrEunoWCnL4epVkMOnfu5eKzoYpZ/FmrgF85h51DTxqMbk?=
 =?us-ascii?Q?V7NDOlDaDy4kjWkRBAKihjZGxhu/RMCDBQg1oiDx4SJFcEofnYhNtyoYGQUB?=
 =?us-ascii?Q?HUkTkZxhg+SBQS45Ki79zHtNEpoVeXx/dANJ0pB8bg7/mIWOH5Y1INTFkE6k?=
 =?us-ascii?Q?r4qmFNIM0lK1nYxMnr3EBH2mV1T+vGrdJUVWunHmh/6We7P+S8IonMaxA0o5?=
 =?us-ascii?Q?ilIAIFgkrAMnS/l8jcdMMCWNCa81sfBAqb1CdTpyEXtVsCdZNhacrU4JFIBE?=
 =?us-ascii?Q?d+K4p1jKsPtRT+MXgOqPGQd9gJCjRVDWNGJAedm88jukzoyrZWgtWuI5cN8t?=
 =?us-ascii?Q?gcpJBiEewzOP4710EW2Ss59BY/6jVpMuW3nyaExoPVWMUPYAMoxtChEm9HQo?=
 =?us-ascii?Q?AyhmctgsGQw3x7XbklpLn0Q4h9wvfdEAVqZw3sLwrzoirlg83nDAqRpp7RS+?=
 =?us-ascii?Q?3he3V/FAiLd4Hvpw0938quLl3QPHsoqk50mfrEv7RaqF6ihsfj6X8g8LjyBB?=
 =?us-ascii?Q?PlcoWahXEtF2yGZQkELbFkmJs8ZCbAzW7/APfWev4mP49h8MKYwQaDM9ZKCv?=
 =?us-ascii?Q?6XHqYbzbs6crUrKufGpc5VN/hkg/p1XL0gP/q4ylmf8gGCCLDJXI9RHUyKA9?=
 =?us-ascii?Q?icHXZnljMJ8R/08LIidQAaEmd8Ubg8ekrBZj6G2wsdwcRB+PE73+oCbiSAWK?=
 =?us-ascii?Q?ReVFNA6MDNfeG2wTLNeTbJHFW7ZWasISNyPQXoJ+IDnnceFT3gJGjChKeMBq?=
 =?us-ascii?Q?dvq9FaYCk+EK6leOuqR9sOx4WyM0J7lGEkEkmMVkWnOVbGt0g+fiohvJL9Cu?=
 =?us-ascii?Q?93PIIrF4e7hpaY177+cg+Uv/DI+GJ/Y=3D?=
X-Exchange-RoutingPolicyChecked: sdkA4Cp6d1RJc4X7vK0Zz6L2jiZHmcS8uwKi8N9R/QYjV6yf8gbnqXkXN4hS2vAYcAF50c2a/P9Kluw7qlB78L52LANnbotoE+bL4ip4mSIwLGKGqaRlGFRHs8jfmmI8Qmbzq1h1ay9e7nFhyoz0IYHWQ/d6l/whBibJU5/ZYHRrr6c65KJC6/v1KKFUTcFWuPy5fqGqiRPux9BiZhWicM7sW2Y3uqFen5ULFyLMEHKGuBK/UBWZ1ylnQG7iHfHzvZvlxU8B/sOIT2bzzsqmXymuvnYAZSJj/w0ZgiUbXsHIl/Ra1VQuGl2i/+X602V6eka2g7TcvKsw/iGkq/XPMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 767e8ef1-594d-4941-a614-08dec713a8d5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:13:58.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1xL6jYJKpSpskgc0+jh0+09e7DBEHGDWsB/OHzemc1uL5I8rMcBJRYhksLohcOW7gWjekKa8OllyKI/z1DprGjn97FOWGGwhEmGZOefXns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
X-OriginatorOrg: intel.com

On Tue, Jun 09, 2026 at 09:21:01PM -0700, Ethan Nelson-Moore wrote:
> A comment in drivers/cxl/port.c refers to CONFIG_PROVE_CXL_LOCKING,
> which was removed in commit 38a34e10768c ("cxl: Drop
> cxl_device_lock()"). That commit switched CXL subsystem locking to
> custom lock classes, which can be validated via the standard
> CONFIG_PROVE_LOCKING option. Update the comment to reflect this.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
