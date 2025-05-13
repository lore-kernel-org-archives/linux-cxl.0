Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E281E3FBA7;
	Tue, 13 May 2025 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104012; cv=fail; b=W+FOiKvEdctAmgdRV1t/F836XV7z+AcadcC1LvX+tPKd+aa1VHjlLstZ+bOhyz55FDJx906ti7uPXBi/TjSlJeE3FmSM04VqOnXz7xuhgnP/m0PMYsENx54yVfdfpSt/y5/V9q37WvC8YaFyzhHDjrTzwPJJVyb+8gzb7qq8SGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104012; c=relaxed/simple;
	bh=GA1mwMzA3cfLZOQ8bsr0+Ii7RLfKQCISrv2iL0Yur9o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=QGzzRhNedN8Z9byqihYSPyTV5Okw0qQS6UjPtH/TNYKoADcjV9z3vMg8xVGAgmWCn//zChAmFrz8iXcHmB1yREJg3gB7GAFnrda+Qb5n+T9ALG+nXiDDNe34EGg1ypVCZyeY/fxtTqNmALKJPnGeotNbqTUn08Q8lx4nSV+mTPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJF3ino9; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJF3ino9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747104010; x=1778640010;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=GA1mwMzA3cfLZOQ8bsr0+Ii7RLfKQCISrv2iL0Yur9o=;
  b=SJF3ino9mFG87Vs5oHiVGjWmaweAdpbm0Lm7IXaWt0U95owln1j5t7Ry
   13Zw6JXp3oCbF4uuXi9/glXK5w9Bp5sSJUUC/00pq4QdlXe0ClX7c3SpS
   0wgqbt0QDLDIeTvQkoICCiqUKvSPwW3WNQzjeaujIh+X5ZgYb5iz8VQNt
   cUdTs7tkESmBj6SEWWKiypinPVfQ5OPIhe6yGQZHqWcNZG7mc3h+Nqyee
   z92VbDfJAxlB2O3z8yWIVYNYJQZizRuH7P7jEzZ+OE/sfM3C6YiNzYeuI
   VR+Fe7xMVOTBC/znjLU41YyG2cJhKf6bgf19qaRJMG147uyQlpDyR4gPU
   w==;
X-CSE-ConnectionGUID: NXsNUTErSRyBbjqHuVbMvw==
X-CSE-MsgGUID: i5esyor3QRmkV5fFiZEX7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52733745"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="52733745"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:40:09 -0700
X-CSE-ConnectionGUID: 3noR+h4HTQexmn+VrxICBQ==
X-CSE-MsgGUID: 5nqXKt+lT/aSIEjb9Lr1pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137275492"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:40:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 19:40:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 19:40:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 19:40:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQDHKqkNsCzQV8K3sRiWKnVtD8VjsJ+j6mniGI2IbirWxK6dAWDUhe1ujAlCCDVZ7NFoj+RQiqZDqhwKh3K4sb/OvWEdLWFgtx9pKiTKGSvhrK9SbC3L2lyyjemK86IM3KmSn1XuoPQ5HRDHU2hsQXvklzJcaW1OnlvhT7J0aeQToaP/hcGk6sQ6DtAtiIGVezfnEUJwm8AstQNmdr5g640GpttBtb+FT5YE8LAFIQhdPAnhypmzlIiSUyL8inY/F9QQ411exSeDbeUL2zEgHVowrA/NLCorzoSr4m4Q08vO2N94DxFjET5ARD0lxODtI4Y3ar/FUEeSuqUtlkspdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDoxP+sA0s/k8M/vBTAZc+9iGv4Yk7C7+xXZmbCcqjA=;
 b=kLtE7Yy4CYECvlrSztAJ4F1hC88x8pAXLZZaAJw2HpnuRQTRodqEyHPMQQT6bMYu5YAxNUeBdoSn/2a80tOxL2VqW61rxZBsHBUQ/RTlhGvEG9Viwxudt66q88CIZp4W5BiPqEVx+vtZe3fxFqNG7KDUdb7FB9kwboY7ZHdSAs8I7VAM1/87QIgnfH3bQVaKCXd5+f24Zu7mEUGy0nHxp2CFvXMK+a8UXAvtft7Lk27l7zDfVUra8JHB7pHTKg/U6ZgGCOh4LPutkqnUFUlAZTBQHL7QqxE4fBDhqDq+df+xM1yORyw8fSc1OivCiHSYQ1iaXTPdMLtIR58tLHXgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Tue, 13 May 2025 02:40:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 02:40:06 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 12 May 2025 19:39:59 -0700
To: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>
CC: <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <corbet@lwn.net>
Message-ID: <6822b0ff24080_49706100ae@dwillia2-mobl4.notmuch>
In-Reply-To: <aCI5c_hIS8bWgAaC@gourry-fedora-PF4VCD3F>
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-15-gourry@gourry.net>
 <aCIjMNooAzKaONod@casper.infradead.org>
 <aCIkF6RZJtU0m3Ia@gourry-fedora-PF4VCD3F>
 <aCI1X3NZwuagNOqS@casper.infradead.org>
 <aCI5c_hIS8bWgAaC@gourry-fedora-PF4VCD3F>
Subject: Re: [PATCH v3 14/17] cxl: docs/allocation/page-allocator
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::26) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb7d4cb-f34b-4c9b-dd2c-08dd91c77814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUpXWTNZT2ZxUDZJUTNqZkRCRDRCNnpEQ1F3RWw0Z25nWVdjaWlBSC95aWRM?=
 =?utf-8?B?aUo5dVFnY1RUR1NPVzhvc0o0RUR6QmM3MElWQW55Z3huUFN2K3FLVTJPd3Qx?=
 =?utf-8?B?T0pQRzlDSFd2WjlLRFZNWUVDUnpSZ0NDU2xPWEFiczFpTzloTmpVT0JUSk9F?=
 =?utf-8?B?WGdzaC84dmVqbzRrRGU1Y1MvYUxhR1BONUJLbkZZckpEekVrL0RvNU9TYk5z?=
 =?utf-8?B?bEFhOTZ0eWRyNDZwUGtqbURuYk5OQnJxMkxkaHRwdW8rbTRIamlnUkUzYXN2?=
 =?utf-8?B?U1l6elo3SDhjek1rU3FZZzloTGlVMHhIUjk3aEs0aDI3MkxmbW8rdUs2YUlY?=
 =?utf-8?B?K0dkdEdTamc5MVplUFRCaGZVbzZENjhRVmdrcEc1NnFUdE1qMm1nT2thOTAz?=
 =?utf-8?B?V3pCOWhRa0xtYUxVL3VWTW5lWWp5NzlkYm9mdUVuQXNOUWwrZ2tWWU9mbDMr?=
 =?utf-8?B?eDJIcXpVM29LUnlTRk05bVZXendIcXkzQzMyTnc5Ukd1eHFJT3ZLVjlXNWhP?=
 =?utf-8?B?K255MktBRklEbkhRMEw2S1NUeEZTT3diR3JjTDM1U3BCbjR1a0hwWGUvU0xJ?=
 =?utf-8?B?Q0hXdFJGSkpIaCsxeTJiZGNsbjV1MEV1UHlQL3J0SHJkZXJGQ1dMQjRuSHNH?=
 =?utf-8?B?aWdEYnEzNUJPUnczZ1B6bWFiV1pOaVcrOWEzUGdnVmtlRXdSNnc2bWl1V1pQ?=
 =?utf-8?B?S3p2am1JUDlOdE1rMW1SdENnVENxYzIzRHJpQjBzR2FTV0dRRTByREg1OGxK?=
 =?utf-8?B?MWR1YmdLbU5PdTcveXd5L2hlYnJMMHBvb04yYlB2clVRTlpIQ0RDU1crR2tR?=
 =?utf-8?B?aUxJN0FaOG9VTERBNlN2N21HSmVpQnFHUHZsblFsVWhSV0ErVERwaGVIeWxu?=
 =?utf-8?B?UEcwdjRVaEo3U0hIdWdya1BWaTg1SitEMFF4aXM3TkVOeElFWGg0L2l5b0lY?=
 =?utf-8?B?TnA5ZGlJeitPQjFybU13VnFQeElSV1RacmhCblZoQi9mQSszM3liVGJTdWJD?=
 =?utf-8?B?MHJJdWNaSVlXQ05ENEFhd0xEcGI1MExXOWdQeWdYeWw4YkZ4TDBZeVdKTGJV?=
 =?utf-8?B?bEtBQmE2cnFyWEtkRG02N0JaY3p5Tk83UVNmc2ZGR0h2MXR1dUFhcUdJdndw?=
 =?utf-8?B?dG9zMCsreXRPSDVMWEdqVE9WYTJ1Q0IvRHpUTTdBY0VIalZmQldHRXg3MHJl?=
 =?utf-8?B?clpkdzBzeGVWQkJPRUp4SE43cU85ZnRCTkVvc2MyamVqbWJLdEQ5bGo5TzZG?=
 =?utf-8?B?OUV3VnU5Vkxvb0NZY0EvakVqOTUwRlQvUWlvbS9SZmgrbVB1MlRsS3VHUTBE?=
 =?utf-8?B?WExOdnlaWUJLeXp3ZUg4ZGNicDFVeDg1aHdwbVo2bUdFdnE3emVjZFBSZVJu?=
 =?utf-8?B?dWJKcDdhSFNJM3ZoVldoNEQ2ai9iVnNvVlNtOThOYjRJREs5SlVydGpDTmhX?=
 =?utf-8?B?TFBYcnBZU2p6aE1BOE80T3liQVdLUlRTZCswZzgwRUdNNURjV2pvc2ZpcE1Y?=
 =?utf-8?B?dmJXUG1SQjdvU0RLRHFsdldMVE1ldmFrazgyblJybE1oUHgyZUlLWFFKbHZt?=
 =?utf-8?B?b1dOUXp2TjRhWWVUTnJjK0Zwd3VQQWVvZ2RobkF3Ri9NbWVZc3RvT0FyTld2?=
 =?utf-8?B?VmdyeDBKZXlieHJuRmk3UytuclZpTGhNcUdpeGx6dUR0cUxnWGJsN1JwYXFn?=
 =?utf-8?B?d21SRENMOHZRM0hhWk0yWDhiSjk3UTRzMGhEQnlvS1dsLy9YTHczcVNnbkh3?=
 =?utf-8?B?a1VKTG9wQldST2xRbUh2M1Q2azZwT3Z1Qk1zMUJvQWFQa2lYUDdHYUtFNXBq?=
 =?utf-8?B?amNUWGd1TUxpMzM2bEsycFJQdENoU1Z5MEQxa05kNC9JMG4vL3Z2blZtWHV1?=
 =?utf-8?Q?woO2vD92wWG9/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlZtMXVCSVNHa3A4ZUhpQ0RLTU9GVXRpVHZaTlIzTXl4NDJvdDdnVFVmbHhw?=
 =?utf-8?B?a1Rjd0VESGNaMm42ZVlIcU1Yd1NkZWpRcUxvbjhBMlpnYXNpQlFxMTZNMDNY?=
 =?utf-8?B?OC9yTE5yT2ZwcTRxb2dNTWhrdkFtRmJydDhiVmxrMmt0UldtRFhnTnl1YkdO?=
 =?utf-8?B?Q2FpcmRPY0ZkbGgwN0VyekN6MjBaeFlpQnNYWTRXMnNIejY5WFA0aUpMN21K?=
 =?utf-8?B?eklQSWVGRk90UlZsV3dQQVZGdFpFMlZCbEtPaThaeGJSeEU0WitjSVdiWEx2?=
 =?utf-8?B?cTFxdDA0TmlCUmtjbEV5bjl4ZmpwZi9SNzFWU1R6NGdyY3hJam1rNDJmTjUr?=
 =?utf-8?B?VS9tVW51QU5XYXo2c2haRnVDdm55Q0EwQkxpSzVmRENLUTlNZzdPUlBRdHE0?=
 =?utf-8?B?SWJsSGQrQktXdFdIRTgzOHhDUG1lUnZEL2J6cFRXa011QzZ5S21oVmtCTUxW?=
 =?utf-8?B?VmRRYWNnaVJkZzJyVHQrMTRwR1NEbTBJbDluZ2xUdDZrMUJURkVHVys4OG5M?=
 =?utf-8?B?eWVEY0ZqeFRnWG1KSTg5eGwrbEZ2S3ZJMUY5UWlUZkFpOVJsN1ZRczI3R0Rt?=
 =?utf-8?B?Z1MzTU5uK204N2dNL0dnR2ZkdDlFQ3VoYUxPMjFQdlNEdWcyZklBVENYTS9C?=
 =?utf-8?B?dStwUk8zdXFYbDRxN1pmWG5NVk1OOEkrQ3RUVkxWYVJzWGh6Qzd1UGUrVjMw?=
 =?utf-8?B?NTRIRHlnVFcvSDZTaE9PSzNqSFJhVnA3N3RJUkdia0ZsdUlLRm12NXFsdlky?=
 =?utf-8?B?L3NKd2VFOTM0dUVLVDVQMUdZOVd1VlhBVkIrbnB3VzFUWmRrS2FpVktUOC9k?=
 =?utf-8?B?cVZqSmZJZUpSRFlXSnJ5bWxEMlpYMXBqdnB2Wnk1amNGbzNIak9XcUFBTHdD?=
 =?utf-8?B?QkMzbUVHTmdXeW5sUm9lR3RRbXAramFaQ2Y0Ym9sZzNYaGo3ZnpiTmI5SXNs?=
 =?utf-8?B?UHVxQnQ0WG02NnRvUEtUdEJnYUtaV2Q4amhlVTdkR0U1c1k1QW9pRGFHc0Rh?=
 =?utf-8?B?K2I0US9ZMTJnc3BmUGhUdzc4VnhTYmtURS8rR1hwRzRNQTlmV2RiTlUvVURz?=
 =?utf-8?B?ZzdnQkVNb2F5SUdBVEZEZyt2d2VrM2JKM2xFWm10SStPbm9iQzN5NUwrTG9i?=
 =?utf-8?B?TU85NWQ1bVVydVZPeUszNnZGdXNsNVlCRytKc1Y1SmtCZ25KOWVQRmcvSkhz?=
 =?utf-8?B?eEFyTlpBd0kzV1hCK01EVW9YSW4xb1o5UGdHVkJoV1FXTWtuNEVVTkVWbVdj?=
 =?utf-8?B?d1djQlBBL0hNbk9WTnNhRVRDbGRGai9uaUVZQ0FqQ0JsN0J4ak0xbU52R1Bv?=
 =?utf-8?B?Z0phU2FSaTd4SHBTenF2NFJHRzNIaFAvZU5ic2VEZkRhMDNOcmdxd1M5RDlB?=
 =?utf-8?B?VXNUUkxEd2E0ZnQxb1dzTDdxNElKeW5QckgyK0d4N0lWdG5rbEt2RUJmUFM0?=
 =?utf-8?B?NjcyWC9YeXJ0dXpVSnVGMFJNMUo4TjdMcEdXSmFORlJGeUpqcFUrMFU2VS9H?=
 =?utf-8?B?WnJtTVAwSEdvUElRUFpaUHQ0YjFuMWpOcnI1a3RFcGRGWjJqbFVHSWRmZmQx?=
 =?utf-8?B?ejNSTy9ERk5DK2ZGQVRHWmprUGRkSmV5WUVNSS9zdXJRL1ZuaGlWSWNCV3Jp?=
 =?utf-8?B?YnZEeThoWUNsRDlIN2h6cHAvdUpkUFhLWGdDakY4NmM0MXpBZ1RMc1RBMnY4?=
 =?utf-8?B?eHV5cEQzd3FSQ2RwN000dXZnUjBRMGJkVzBQSmc4dGpvU2EyRVNJdUFIbnUw?=
 =?utf-8?B?d3VtOURyVXhIOXpmdzUvY1VkYjBPREkzcHNpSEVSYk80Z1J4c0NCTG1QdnY3?=
 =?utf-8?B?ZExSRTN0YXZrV0t5MkdBU0FYSGJpUXRTQkRzdHRZSFlMMS85V3c0OHpZa2tQ?=
 =?utf-8?B?NzZ4WWJIbTB3eDJWUFB4K0NNMStjSFlMd1JJejZGZXpQWVJQQVNRMnVtaWND?=
 =?utf-8?B?NUdHM0R1RnJKdnMwbUE2ZzRhNXUzeVp3SS9CRGdoczRRc2tuNm1RR3JUL0tG?=
 =?utf-8?B?bHhjVlZxd2Z2NmJiYTBYbFNYOEpPTXZyd2tRQjF5Y0Zhb2hoQTVyWENkeENj?=
 =?utf-8?B?UFRxZEQ4UTdCUnh0MnhFYlFIQ2IrVFM1UG1iTFhMNnpkbEpmUFJGaHNYbGV1?=
 =?utf-8?B?YndGYXJteWo3cGtPU3JtbTVUK2RrWjJKbW11LzcwdElMbVdtNHVqMktWUnVG?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb7d4cb-f34b-4c9b-dd2c-08dd91c77814
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 02:40:06.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT36ZnX1fGjTlW2a0hHGVoz7A7GgPTOOecRJQlBntn/jdfusTCTpQDjr5aRVNVPeTkhI8Vns7txAcns+MKXoLpV6Hzrc1PNnFTRRaBoZMmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7959
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Mon, May 12, 2025 at 06:52:31PM +0100, Matthew Wilcox wrote:
> > > 
> > > Feel free to submit patches that deletes the existing code if you want
> > > it removed from the documentation.
> > 
> > Who sneaked that in when?
> 
> The ACPI and EFI folks when they allowed for CXL memory to be marked 
> EFI_CONVENTIONAL_MEMORY - which means Linux can't actually differentiate
> between DRAM and CXL during __init and brings it online in the page
> allocator as SystemRAM in ZONE_NORMAL (attached to the NUMA node that
> maps to the Proximity Domain in the SRAT).
> 
> Not sure there's anything you can do about that.
> 
> And for DAX:
> 
> 09d09e04d2 (cxl/dax: Create dax devices for CXL RAM regions)
> 
> Which allows for EFI_MEMORY_SP / Soft Reserved CXL regions to be brought
> up as a DAX devices (which can be bound to SystemRAM via DAX kmem).
> 
> Wasn't much sneaking going on here - DAX kmem has been around and hacked
> on since 2019, and probably some years before that.

Right.

These interfaces have been there for a long time and this documentation
is simply catching up with what is there today. I called for all of this
documentation to go upstream and have no problem defending it to Linus.
Appreciate all the work here Gregory!

Now, is device-dax and dax_kmem the long term solution for exposing
memory of this relative performance class? After LSF/MM this year I am
convinced the answer is "no". Specifically I want to see a solution that
meets what this astute LWN commenter recommended:

https://lwn.net/Articles/1017142/

We can delete documentation and infrastructure once we have the
replacement interface upstream and can start a deprecation process.
