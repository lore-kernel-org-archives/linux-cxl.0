Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD572BE053;
	Sat, 10 Oct 2026 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791595255; cv=fail; b=jWofOJvZ/qZSrYeO3xLtCUQD1+tYf+GgVnPST7+KgOby+tbshaKsopO99cCZZejqPqpSRGY9pL00ALtij5QIgfiF8PBrSDFZ3L5wnhQQPIo32v7EeFy+sH2sh8hQcjQUdgw18XNrsyc7AqbYNx9XC88abhtk4abw1UD6rbaWyPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791595255; c=relaxed/simple;
	bh=uQscPyK7btRs29BV52txt67RDrDSAWvrpCk53fb2Cpw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YTtKc8fNZNv1BYQdc4pn8pEE7shQa9JaK7iV9VJGFyjrFjYvJODrA6wlHan3vr5sABltJHIFAbe8TkhoRanf6TqdYdwW7vhp7QvIFZ8KCHQvuMH7G9HyjxLCEbpmyAun/66WD4ICpIE8OWdqjpObPpAPzUZXmm33eS5KIXOwtoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ck39jKxX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ck39jKxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791595254; x=1823131254;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uQscPyK7btRs29BV52txt67RDrDSAWvrpCk53fb2Cpw=;
  b=Ck39jKxXlywZKxqHPcOPWbpsL5KQ3ermge0z3T4CrmspYdHFHeNmelxW
   TrKsFnT8vS//XUs+dCvmkucsS6U1Svun8stb4NgSARFSNDtFdWj6Qm+ts
   uoY/0RoVmHBHVadRHEQ1OgPkTPDOCvss1PozpsR+/DkcHPKFjLGyXaHum
   O3FOpnaMTeQ0+7CaoExJV/AycF9W8bd+htmLDMG/fokJ8ZAp/v77x7+ZN
   pI8TmtzXc+kzOfmllnWls/dr0FEEdP8mbhJIPkt7O+NtMoBnJLnGwPF1F
   U017l/QhsSXkGcrPrAGleMLptnJ3VRpV3INqWi6PeS576hr1SMaVK511x
   g==;
X-CSE-ConnectionGUID: 7bEWvSUJTAeIBBiL3dLoUw==
X-CSE-MsgGUID: 5AbZ8jdSRT+fQnzNf6Da7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="274981"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="274981"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 18:20:53 -0700
X-CSE-ConnectionGUID: XZfY6yiNSd+i+y8QlBpRLg==
X-CSE-MsgGUID: ZDJte8TsQJuP/EYEHadrfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="405331"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 18:20:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 18:20:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 18:20:51 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.43)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 18:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlwNunRkV3Lz8k/wDbT114WQxtnwHWxBXHXsGFldElBw30kWvugPSyk84OFAkmGwl6TGX9G2RZJDwEFT1RVxWPb9AyfkA3v+6zfCpD06S4sclqfxyLbMmePZAkOSChPzcj8IWEwZX1U93Z0l9qBXnQrR85hnFpeDEdVsZ+SKfd0Owi9EFFpZnQzRn0n7QRVkgPu8sELFO1ubashSuTguVEvpTj+WXGh6e6l6ajwuWwSzgvOGfA/VDH9sP+vd6nig7wTTJ5M2s1pN3uHe7LPuyw3622WQC5Xwq2ZchplApdql9Kbv+8pcJsTaul0QRqUhhcT+4YYamz+BW769dqOYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TLw151x3g87wn+VWHdBpLjVDHw44TlV8KzXb5MXJWE=;
 b=O95eO/YK7LVsFTzean3SFB7VxbaN1YcpqtwKCL4evgr8fvJEDnU8Ugr6cKo1eDUErq9ee1IVzwgds0hzGx1xXvKy/78jk1ZKfvzniObS71nluSE5JZM7njvfd/7ZK3R7NFkgItTph5a/dhP8yUAgwlQb2gnylpal3Uul3/gwyX5NHQei6z0RgnpeYs4Nqy6rQmaYnVJTIB+6v/ulmtfDNnKs3zQuWIcnA72xmHBjw9VBluPnQLk4voVZ0AMSm3GTougD72RwH7cTQX9oCbdianq7ermuVIrqLpwR0bYpw5AZlpNIkUxBeuS24AYlF4RA/Poe/jz4SdP+fJtZZOGDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 10 Oct
 2026 01:20:49 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.017; Sat, 10 Oct 2026
 01:20:49 +0000
Date: Fri, 9 Oct 2026 18:20:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alucerop@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>
Subject: Re: [PATCH v2 0/4] Type2 multipf support
Message-ID: <asmS7Wec3APcV8RF@aschofie-mobl2.lan>
References: <20261001132023.17032-1-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261001132023.17032-1-alucerop@amd.com>
X-ClientProxiedBy: BY5PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 55734bd5-f26c-4098-cfc2-08df266cb7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|261009223027099003|5023799004|11063799006|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: OjhRBeWAoRNk2eQnoGk9E8YvDw/aPaz6KqxNiD30FvrEQ5tDkeAccimB4ikXWpfnivHNKzmmD+DgnKInpOy2cPG/avx/ULI0FJ4o+eq5JYWlsvQKRVu7b5qTZ2hLCWS8Dw8Gw/HS63UHH5qgFTzqjjbJdwn5a41D9XJT4Va5bc+HoBkHG/6Khyp2laSAqWn0KJcWD4ERMuwNY14r49xH6uJSjKQi0NwmjH1MyY6NP7/RXgTAGK2NOzhIh6G8Lv4txSla0lbsuXmLMuAQsHksMRG3DyZ+t/avdWQHCzRtS4ah4Ib+hn0/KB07Dib34OpLs+a6PFff0yPkHCRVEDy/QulmaA5OZ8g7PhOTzikBdJ8S2RLLTaf3cs2f8jUNBWZwHvr0tDdvK+dH7vlXgwdGQzaOc0UCK8YyaG0ov5tkuDQLAo0UEprzuoZPGgGzK7dmAzJICGzLVV0rHalPYhQ7kkctb/zLuVDSm5idvNjUAoRJrGztty0QKznIBmfDK4fuVPhPJqSpq6UbDgvQ120l+Arl8Y9gvP/cJGVM/LKIiLoZ5Ib3PzBBFbE0R52mdNfNemUz1i6+RmjdNWwb5bfM7PJLVyqg0tzgM1kZQ+qukrpSwa0oXl1oS7r3LB2kZT2u+hDxr9GZkaHqmjAlUSVZNTaK6BZXQdDH/mqcOCZFAX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(261009223027099003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jb8V4Py1upVw/qnG6ZBepzAh6/Pq+xB87OzW4fJMBHTCsmvJAhTeOHpDTe+H?=
 =?us-ascii?Q?PUBcLFUIDzbHOVgaVpy3bLYwAhLvqwFSShHlU9hydUbRTDsmN8ybhPnVpKzm?=
 =?us-ascii?Q?kJFvdPsWPpbt4li/irc6Cy+iVrApkdwgj9BXoDonwJTi+9AMsNbs6dWhsGS1?=
 =?us-ascii?Q?wBrNCcDnNajXc37eV2+v2l/cGyDp0EUceGxx2SojHXxbmeMFy1BEHwr8FHQc?=
 =?us-ascii?Q?dU/vinHmlwpNh6OIXZZ7QLHi1AEtXls4bm6ZoJfkAri2jgXpzj4woVIHBAnF?=
 =?us-ascii?Q?s/wrvHCaKwR66zxHg7Pof8TU43Ii7DKPKwJ9p2qJOKxMjE88rlZGYRSOlHM7?=
 =?us-ascii?Q?Q+X0zEzI2YiQgpiTMGjoc1mOUAufLHspKqihAgHoCgWBtgXyw0lRfIRP0DxC?=
 =?us-ascii?Q?7JrrygMnlWzXCIyG0DpXpYoNConU+gSI30iGKpmMERjTbCtpaLMdI7VI/raY?=
 =?us-ascii?Q?3eemyuRirQFjibnXNZd2zqn/W9GHVaJr83Cu9ywbWRMwXV8b5tp6telkfVPw?=
 =?us-ascii?Q?zdctTcztg7f/GWsjROEDpFixlqV+kMblZb5T5PCjIatf9lqz0bgkB2/8VYmL?=
 =?us-ascii?Q?LOJojrMzScTfWnRiCJ6wtkyO8e2ds1/jkWp0U5c+Vhxu2FZItu3+LCGtHJ5v?=
 =?us-ascii?Q?M9oCN2PWyz/C2wV+mHdLcNa0YZ4goIm9ZT0LltbTRPPeTaS64zOgy06ejI6b?=
 =?us-ascii?Q?2WQBQRWrz8wMpOGNYMV424/3WLp86YiMRi/a4vndyFy2UWkxYdfOV05Zsil9?=
 =?us-ascii?Q?yu2/FATVTudG9DQsz9WzByl+H8GqxtzZ9aQI6VqMVrRV0vUVgDxdM9Ccs7vx?=
 =?us-ascii?Q?AXc57i+2S6hGvZDluf7LPVzCERhCD3hqwRLXO9E0hLXjTpAGueGCWPSrgLML?=
 =?us-ascii?Q?wzgvgQctQHS6m7XBLkw1vJy9ca6J2s8MMim+/C3hNdh1YO9uep6DDAnZu/gZ?=
 =?us-ascii?Q?Vr6tK4I3MKWXUzPlAausblhteThvgs8lOXBWV5OGhh2E96BwPCMKOKT7bL46?=
 =?us-ascii?Q?J1jMTPeoOrFg/jGehPkpLliWnhqFQK6CSHufs9IDkgnuqRwJRyzHPR8Q9fHN?=
 =?us-ascii?Q?28ZYXVnsqiB5kowQKbagYD48sf/xd+sYnBtLZaQz1Ajc47+6ji/AeNi985Mx?=
 =?us-ascii?Q?aV1e8hRJqjF4smmAbPuq/YFCUNqawOMvqk9xHmrKCcmOY4m5DY/g55ePlwLu?=
 =?us-ascii?Q?46DnLVuipNo3hpbTxTNhS77+OezGlgca+KfedhvPk2h4CsxjXsRkFacN8Bwp?=
 =?us-ascii?Q?APZqEjeM1Hs2PajlVAMk3M0e1XR1LOnrSS2mEvOS8zaEssRuyzVVXeo4vvIE?=
 =?us-ascii?Q?S0bwmzi7B8lwWhmOgPucU+KC2PZQmXxKXCn5mHTzlCICQaQHjUMER4IeZUOt?=
 =?us-ascii?Q?FMVF1S4kP0ycqa9erPrqdxhBnheAzKYk9Wks1vRq8JQ3sMfD7q1kU1p1+D9b?=
 =?us-ascii?Q?GioVJ6AX8WFgUSfqQUozRclo0fEClUi3LPsg8Vg8Ccjzvknf9aVzCgwjVqyt?=
 =?us-ascii?Q?/41UVomxy8Qevt65KY5XNm18saO+d75NVBJeUoxB1EKN77it7MtwHFVyq/ry?=
 =?us-ascii?Q?kKkQEWOpqo/zAG0Hql26vwISVh+bXqcJuYz8lSrLpzOOzqLquZIULT1k5Xj5?=
 =?us-ascii?Q?Ul7sbQlUA7R5mNgbQ9z9WK8yk4jP63MZYse32qQID2UsRhQpgzAKZUmZAkm7?=
 =?us-ascii?Q?g7sC11i8EA9S+KuQo/SEHSD6KghpDKiI5VCTzn3egj9iaKIhpgowF9tUw9Es?=
 =?us-ascii?Q?N8PF6U4OtDNjOVYBQWN3EBfe3PTnUD0=3D?=
X-Exchange-RoutingPolicyChecked: am5cbGZhbQ/2brfUPIVsy9wrp3jA+Tfn8nUSSmydmm89v8BAzjlZ/nF6TMU53JsxpgjeLKrLGrwkZU4ImUNgR7DzXM03Y3S0GDzGmW3LXkZRpCDhYMTmchC2STDdHnw4yMkDvb6MKbHDY9vEm221kVRSTCbtV2VcF3RVSm45MAO39oEpNnabacbin4q1ABjwJwWbplfen6Tfi0Tohp/yyPFT0fIPXRRTaePZxzQejDETd/B69Lx+k7FDWuuxjzUBt+xXdOKPZuMCYDUf9X+hykGjxzCz5p59U4NVIXCktZYAzLBynaarBNiW2bppQ3vBqIhPEyblK/K3TNFJ2qfi4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 55734bd5-f26c-4098-cfc2-08df266cb7b1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 01:20:49.2207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4S4FRFMdYL2O6Hld0pviUo6P4MaWqMnv1JIc36jVs3hBlynzjWgyfWcn+I9TRcPo7LsXbac6wD20gjjlT8bEnjH0IDqIKnKkGN2Odz5cKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-OriginatorOrg: intel.com

On Thu, Oct 01, 2026 at 02:20:19PM +0100, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>

Hi Alejandro,

It caught my eye that Patch 1 didn't go to driver-core list, nor GregKH.
This recipient list is not quite right. Appending how I get the list and
what I think your list should look like. Your method may vary but the list
should be same. Okay maybe omit linux-kernel ;)

If this were a HUGE set you might do cover letter to all and then
patches by subsystem but that's not the case here. Just let us all see
them all.

Thanks!

-- Alison


$ git format-patch --stdout HEAD~4 |  perl scripts/get_maintainer.pl --nogit-fallback --no-rolestats
Greg Kroah-Hartman <gregkh@linuxfoundation.org>
"Rafael J. Wysocki" <rafael@kernel.org>
Danilo Krummrich <dakr@kernel.org>
Davidlohr Bueso <dave@stgolabs.net>
Jonathan Cameron <jic23@kernel.org>
Dave Jiang <dave.jiang@intel.com>
Alison Schofield <alison.schofield@intel.com>
Vishal Verma <vishal.l.verma@intel.com>
Dan Williams <djbw@kernel.org>
Ira Weiny <iweiny@kernel.org>
Li Ming <ming.li@zohomail.com>
Edward Cree <ecree.xilinx@gmail.com>
Andrew Lunn <andrew+netdev@lunn.ch>
"David S. Miller" <davem@davemloft.net>
Eric Dumazet <edumazet@kernel.org>
Jakub Kicinski <kuba@kernel.org>
Paolo Abeni <pabeni@redhat.com>
driver-core@lists.linux.dev
linux-kernel@vger.kernel.org
linux-cxl@vger.kernel.org
netdev@vger.kernel.org
linux-net-drivers@amd.com


> 
> Changes since v1:
>  
>  - Simplify drivers core required change
>  - Change name in the new accelerator API function (Dave)
>  - Do not return cxl memdev but int (Dave)
>  - Refactor sfc cxl initialization for the two cases (Jonathan)
>  - Restrict sfc_cxl_map to only mapping (Jonathan)
>  - Addressing some sashiko reports
> 
> A PCI device can present multiple Physical Functions(PFs) but the CXL
> specs restrict to the first one, PF0, the discovery and management of
> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
> obtain the CXL.mem range to work with somehow.
> 
> This patchset adds support for getting the CXL HPA range other non-PF0s
> can use based on what PF0 did initialize. This implies CXL for those PFs
> can only be used if PF0 is bound and successfully initialised CXL. This
> needs to cover the potential race between PFs probing where non-PF0s
> will be deferred if the expected CXL is not ready yet. Moreover, those
> PFs can not keep using such CXL memory if PF0 is unbound what can
> happen in different scenarios.
> 
> This first version after the RFC uses device links as proposed by
> Richard Cheng which simplifies the support avoiding specific handling of
> CXL memdev siblings as the RFC did. Using device links needs a change to
> this core kernel functionality for allowing suppliers without power
> management initialised covered in patch 1. The second patch adds a new
> field to cxl_attach_region struct for facilitating the device link using
> the cxl region device where the Type2 memdev is attached to.
> 
> As stated with the RFC:
> 
> the final Type2 basic support was possible once Dan Williams and
> I reached an agreement on how to solve the potential unwinding spenarios
> linked to a cxl memdev object. The actions triggering this unwinding are:
> 
>  - User space unbinding the cxl mem device from the cxl mem driver.
>  - User space removing cxl_acpi module.
>  - User space unbinding Type2/accelerator pci device from its driver.
>  - User space removing Type2/accelerator driver.
> 
> The last two trigger the unwinding from the Type2/accelerator driver
> exit path, while the first two start the unwinding which in turn invoke
> the Type2 driver release from its pci device.
> 
> In any case, the decission was to release the Type2 driver always
> instead of a degraded functionality if CXL.mem is only part of the full
> functionality. This needs to be extended to other non-PF0 PFs, so all
> the scenarios listed above ending up releasing those other PFs as well
> from their drivers.
> 
> I have tested this patchset  with real hardware advertising two PFs and
> under all the scenarios listed, but stressing this requires another
> framework, likely under qemu or adding a new cxl test set.
> 
> The base is vanilla 7.3-rc4.
> 
> Alejandro Lucero (4):
>   driver core: Check for supplier requiring PM at link creation
>   cxl/region: Add region reference in memdev attach
>   cxl/memdev: Add support for multi PF devices
>   sfc: add multipf support
> 
>  drivers/base/core.c                |   2 +-
>  drivers/cxl/core/memdev.c          |  92 ++++++++++++++++++++++++++
>  drivers/cxl/core/region.c          |   1 +
>  drivers/cxl/cxlmem.h               |   2 +
>  drivers/net/ethernet/sfc/efx_cxl.c | 100 ++++++++++++++++++++++++++---
>  include/cxl/cxl.h                  |   2 +
>  6 files changed, 189 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 93f51579e7df248780214094418f205253383cc5
> -- 
> 2.34.1
> 
> 
