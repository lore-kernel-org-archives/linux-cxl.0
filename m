Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C863093AA
	for <linux-cxl@vger.kernel.org>; Thu,  4 Dec 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867800; cv=fail; b=AyFSCk72sdhZVK1BNnyDFGD3WLoQB9f7oIGzfnaZUL4VkCtusfarIFwAqNAJtmIZJfVytr3saX7bXFnZX5wH0gPpzyniAg6sRnJU3q1dsGyvxkB9sP++/zBnm+tvSoefF+2TExc7BizxaFtXNtWguX7Dxxl4PgGWwj1WSMnR0xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867800; c=relaxed/simple;
	bh=uevb2rLRtNwAMqazTjsfnDLQFiMYKv224CObasQjV+o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jVbnU8H+iHcOGP2n8qNN0QehurzBQifjGQQzyKo9eGlhoXmjIwZkQ8s2T4NaXjWxEmpUKIybO2L6+HT1g/Hsd8zH/Oh/1JfzMzzvbHGjgoX/9h/bpbC9bgjVrhbm1a8NTCQTdh+1Hi4SmQgfRvJ8Kvzl6TI7QSkFoeRhvb3fWi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNqHjnkL; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNqHjnkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764867798; x=1796403798;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uevb2rLRtNwAMqazTjsfnDLQFiMYKv224CObasQjV+o=;
  b=TNqHjnkL/DzY9XbmjlrRxOUca90KDNO6Uqv5u9eJbyphQYaoH4obmxca
   Aqj2vs5QVsx3LxqZxF50n4INPf9IkhY1h4dgEzTSou9uXoTEJv/vb3C7m
   fisVnxvoChRCFvQtGd2qEwXe2puZ1OCRyEnjVOtyyaPDj9BTWytGR5d7+
   rbjQv09ZWCx3xDwKAVtDMsYVFWXyXiIdKQrntTCuJwT1t+D4Ny5hZire6
   UDlMZtO8IPZwD/sKrjmSYENokC6wkSlzXZlWgsH8aovRiWDYdzaqL+DV0
   NU4CF/lLDGoR0QDw5redExZz7fK9E1mjjDzCOpLIK2RvVFMyLO/G5EuP6
   A==;
X-CSE-ConnectionGUID: jMYin4kvRhOXqEYctqhYTA==
X-CSE-MsgGUID: sULsq3UORJWz7s0THzeDlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66938923"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="66938923"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:03:18 -0800
X-CSE-ConnectionGUID: u4CtTVneQZ68sAdyR0/AZQ==
X-CSE-MsgGUID: MNSfn4pLTWW6lv4flMS30A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="218398963"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:03:17 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:02:33 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 09:02:33 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:01:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF1OyDPDLNuVKKInND1qXeWkWKiMVIn7Oj+VB6WwMKsRFqTH12J34GTy6qbjr9xwYDIXC1HareD792gRRDZ0/BYbyq9Um0bz2/QcFiHyaF8tHuwAJJJnZMcCogcwHz/q43UWU9FjCXpkUt5Jo+6F7iQ1scGD84bk0r15IdLHQTUcQMd0KSJ2D8q3galH7Hh36aiYk5mX1Klg569krGnuIfCZSo3FR+iEhoV8TF8gbS16KkalgcVic6EqxmeL8GkTOsEZPs4ltPYSgxlQCWGZfrxR/gwP35tRqM+xPNKmXSVU0Wlwmt0jhNaCeZcPNBL7MYXzCSY1K0EyPm2lKsim2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O25UEKAHazK5VVwTYQd9kblJE/jJrjkcbtaJ4sNjFcw=;
 b=KmDt0PNRGu0iB21L5IByDykvKcvsJgEWt7cU1Y28GUTYTrGVZPcJAZW+lac6np3xkNkLJHZQ5r3b8wIMtIHmqZUYbXZ2Jaw8+D6B1gP7JhsmuN6k+bWCc90qZMCOzzIT8mNHmfrLENu6doi/YbJkYuCnMQBLoVvkt8N5spts/F8zyBcpDimul7wBRzU0c4750jCj6H6aDDjYVCC7NfVMOS4u/MMDCHSAflkIp9kyHJBzBl3d40m+ocNPGNrljJdB8MblCj+DCJ5ZjXHLMCrgH2IqQy2A5lNUI+wWmR56vepwyD77tEMllQiUwDdH1+DS1kfcnf92e6wSNPqFm6BZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA0PR11MB7377.namprd11.prod.outlook.com
 (2603:10b6:208:433::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 17:01:55 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 17:01:55 +0000
Date: Thu, 4 Dec 2025 11:04:32 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <anisa.su887@gmail.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC: <nifan.cxl@gmail.com>, <dongjoo.seo1@samsung.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [RFC PATCH 1/3] core/region: fix return logic for store_targetN
Message-ID: <6931bf2052f37_4301010043@iweiny-mobl.notmuch>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <20251203203540.1091827-2-anisa.su887@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251203203540.1091827-2-anisa.su887@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA0PR11MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa65f75-5c99-4425-0fde-08de3356d3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bETcCs88YBlvdemmfes9DiJ/l6I//nZaejA0hqpXpwupqysM8I/EHQWH6HDS?=
 =?us-ascii?Q?+7MUa+MDYHspYl5vJy3e0uIrB+xYwS+1hHE9L3x4YQeWwWac7KyYOz3Cn42s?=
 =?us-ascii?Q?dbVx4l9sP+jkpBM6rZmeRsrNgwGQ37lhhYqVnFow+TsDLmqZxRRVuTUPVDVK?=
 =?us-ascii?Q?yolbQHq4xQlv/A12nYs/BL4WEUcYI5dI0RfYT6SW76hd90l7jjdR5I0tafgO?=
 =?us-ascii?Q?hov38ZtYGjfLm1LWbzomIlBCtW4AgEiP9nIus0oACxgHo7ChAPk543vWF71g?=
 =?us-ascii?Q?ZbZfVw7l3uEXub3rlEIs6jQ25D/d7YiLEBcRmu7fFsnFNmjLhEhWm5KhN9Yx?=
 =?us-ascii?Q?5vHxiaNhOTu6pxB/QcLsb8L9y0K+oRHHwk5hWckBG7XIIwm6PcZ7nck439WZ?=
 =?us-ascii?Q?CQ7r7n7AXIu34Hgvp1BDrV6obpjG00YQwOroEX4i3k3BnprF5SY9lrE3rOwO?=
 =?us-ascii?Q?T08JRzMzV+WTWkWjyDo8oRruYAmoGP2m9B4OBczaWKb88+XUJiWEaBbmhJnd?=
 =?us-ascii?Q?qI3DOrYbAqkOi4HWsd+HhAAIxQ0ckXf7tZA2gIEwPpUTvzFSlQbItyikF3Wc?=
 =?us-ascii?Q?1HBBk54M6fwgDwjW1mYwuHUy7aDo38WZzp5tnuB9sF/D8BghtUldDRQQs02W?=
 =?us-ascii?Q?IHUgWDNRYqsyw6y3g2JIhiAho1lhSiDvphAA3nnUvMuVpU4PZ6zzH6FikhK1?=
 =?us-ascii?Q?C3vx4rdwbNEGnXM38cOK0PoNv1zMKetWBblavUHWjFFJOUwwAQ/HYsjHNuWC?=
 =?us-ascii?Q?VInMnsWKtUTUBoW6s/sAuqwtWo6X0ox9zr4Nz2be4UdeGhXMhmNyV7v9hh5P?=
 =?us-ascii?Q?HvPXuStoUzMgq5U3ybtYDYX310yh1/hW5k5mceWWCvyyAFsYK2TamQvYX2Vc?=
 =?us-ascii?Q?xQqJDcn8V32enK2EP3Rehsr6OM29jKcRF5n1iVZZAhBMwOn+fJpfiY7BUnsp?=
 =?us-ascii?Q?BJY39EIGhBuO91V1Wdevnw4a+Ktp8CMS+z1Dy8V7clFKsuVjFRQ4zRR1tfSU?=
 =?us-ascii?Q?TD/zmx+lMl1g0rOm9xJvV224GPRbTr6KYXRZIDbkOYhipRXaBsdqmpKNxN0H?=
 =?us-ascii?Q?3VXZ4EznpcM/RsDIYzMu3+Y32XqBlOZ1MP39yUPkisDSqA8ueXRGYAqCPeQa?=
 =?us-ascii?Q?t9i/n0sKPX8Bb1e9ihLF/fB9uHiS1Tk1ZqW6x1UhnCcg5kSCsKBAvicDXwTY?=
 =?us-ascii?Q?gfv7ecdYg+04X/VWTYT/VloUX9zGwIbTlbj8NdHmkfTz7OHEdspA9/dHb+XR?=
 =?us-ascii?Q?wNnyZqY1w2GwbY9J3hj5MG0ROWW0WYpVzjEpeAoH2w4644khigzbLYb2ECA7?=
 =?us-ascii?Q?wFot36GJnVnfEbtWnfL3N0J7uxOaddgA1EZO3mSdlHcKMKRS+5agREsNSBPR?=
 =?us-ascii?Q?0PeL4iBDrJU11Jaanh+zeuyaMcPKALFgD9DXfHmMkx57aOA6cL8aNw6ApaVR?=
 =?us-ascii?Q?LZwUHbn+ylA86MA4wyj+svVqTxIEyZp6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sldVcNZLCj9K250e1c5nHaH0BPxoL1G0xENir0DshUi7ssp0f+/ogRZF8L2n?=
 =?us-ascii?Q?IdsCT62+wrCEvfPiNfnuJK2SmF3kINzoY4bjozgaAkXxU/6dTEmLQd0vuMJB?=
 =?us-ascii?Q?siIb/Sbk6OW9AXK127hQpSNysWK+8S3ClixWvJGtZv8FEU4HjH776wBHfYUV?=
 =?us-ascii?Q?3wwQM8huwzEdg7ZiUw3M7CXONpGNkh21mR0yDcgYAME51WXAM1CQTAGzDX+K?=
 =?us-ascii?Q?WWUr8kI2+NLKQh6WaJlhuEKBxqJXDwrR0CxMxq7kZD7kRhWt6YThrcPIm/CE?=
 =?us-ascii?Q?rwsZiqFxpAsMqWUcEsMLybsdb0P/tEm/PzZ+yDBJ+EpFDkBDUJ9xsPSY42Ka?=
 =?us-ascii?Q?ZnmjmYSwSy6yXYOmCKa0wM/dTsvKRmAZelBEBKdWjcxet3QLhkk3xxhsHO0w?=
 =?us-ascii?Q?ob0AcyCxtXxRNotjsfuuVsZ2CxnV5S+dSIv9/SwSdLvZ/lsYRFF1Np85dO1D?=
 =?us-ascii?Q?WxbTQFxL7bgOwng5GQeQEPB4U3182Gb3kUVjS9L6mM7ptSUwmlj7mkOd7q4i?=
 =?us-ascii?Q?ekEXFm51Z3iGAvmFUKUZV6+BEYCv6EIcVDw6C2WeFa3EP0YaHUF1LiDaosUO?=
 =?us-ascii?Q?8leEXzQtofvQp4HOsZGTI4fL6q1zvywWDfrWCOvKkCgiKxP0ZrCCgPhjgQ8e?=
 =?us-ascii?Q?lGx4/WlEirSOdSJAPX4ZHefn+sXNGvt8aOMKVAPRpy/w8ATVePm8eu4h7iIs?=
 =?us-ascii?Q?XmbGdBFxQShkjv5HcqubTMRmbdoqhjskrbj7wXNEArBwlrKo/ybCt9B7MdDc?=
 =?us-ascii?Q?gVpkrwME0vn+Iq4ZBV0L3T0j1HN28JZX1/kDPtQQ0QlhM8KDg9lxzq/BCj+q?=
 =?us-ascii?Q?J7zRAhdsfXa0gm7D6/hrp/m7Jjb9Ipv9NfSwyxEcPHRa1L1EZFk5Pp3RYM64?=
 =?us-ascii?Q?zL6RvGEA53UOzr2DIk3N8u0DYz7ujtZXg2s17sKMisw/QxESITMGBUTOAMIQ?=
 =?us-ascii?Q?aP9vCpqtpuvlXNjGJycbrh8vvydgCqK4lBPb233n3q/s9q+bYJcNCWUB+nvo?=
 =?us-ascii?Q?KJUkEYf5G4QcFxe//rjS0LAe7FgsUf5db7iyhU201gP1cPrdX7qhpPHGRV9O?=
 =?us-ascii?Q?2ReieEiqncRLICQ2KDs+nLQZ0WlO6tgjX635IgB2AlE3xjeLJWr964gNSush?=
 =?us-ascii?Q?f6qpr9f0rhQGMWI7mj334TSh1cQ1CKg1RhW3tbLPuerNOsHwfP69t0Eezk+w?=
 =?us-ascii?Q?guGGaWcRN1MJc/DJxfP07RZwWb+AC2x+T8HD17MVa56C5sO+YyN7mxbmrcff?=
 =?us-ascii?Q?LkIRTLPBn0m4obty9rE2TaDsW4IBwlsAPK5QLglupQx+cZtVWdtxawN6staU?=
 =?us-ascii?Q?RAGQMgiiN9vG49wO/NK6SZEtNQz4PoNC+9WPScyZRBbenQFSe9YWaMnvVsEQ?=
 =?us-ascii?Q?XfRcnC+FkY242pQzo8RZcQQDTn0XWMS7FVdU2cifYJ/1rIq+bln3ObWg6zHW?=
 =?us-ascii?Q?70tpAWfTlSB4Ae2YK4ivWtjaNdY3WUd2D3EWCSeoLq3vStDSC3r8PBI8pPEg?=
 =?us-ascii?Q?kZz9lxNhi5vfS7n6S2XXFjWqkUG6JfYO4QUWs2rsbtlevY+HqHnHKNYMEgUE?=
 =?us-ascii?Q?f6gSf4EIpQmUf4oMloGWGFeEnlQnX9Nb72YsJWrD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa65f75-5c99-4425-0fde-08de3356d3f7
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:01:55.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d11bfhAxVxwaH466tAFAchM+G3Kprn695EqgOLEN1z3L+0HuoUHt40eFNqKOXAi/Izq+SR/kyCiUmkReUVIdRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com

anisa.su887@ wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Currently, store_targetN attempts to attach_target even if an error

I think you mean the endpoint decoder device reference is not released,
correct?

> (cxlr->mode is incorrect, DCD is unsupported). Add a goto out statement
> to skip any attempt to attach the target on error.
> 

With an updated commit message:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
