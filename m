Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02A194A52
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668252; cv=fail; b=GHpnv6UfgxSUcxglqlGVc9qKTxuuCoRC8JdnG0mSORRZvy1p8zTrM0nGQridEC1cLKdYLtHF0cdqk58oyuqcBKdfAIDUVQL50b6b9VjQ3jaI6dz8Pm5YCmKFKL0Bq1vPNmJEO1voxrtOTj0eIy/XtOFXJlnIzYu81bz97UyDxJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668252; c=relaxed/simple;
	bh=7MM/1dY9wT4nkn/sgCZWziPU5bv4quF3+/mkZu9lhCA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qy9LUtfMVSW0ITU528ikU09vUuse5SJSXzjeLWmsYh8L5jMiae3yhNFgJi/+2rzGkjrIRVHyFCe3B/wvRPWWVNIM0F85OkGBsg/N/vN6SC0IqSOwL9OpGazgIVEPagnTFtwa1vBFkrbYXv/DOg0gIR7SpTQCDTM/EayowbcqqBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYM+xkYH; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYM+xkYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718668251; x=1750204251;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7MM/1dY9wT4nkn/sgCZWziPU5bv4quF3+/mkZu9lhCA=;
  b=ZYM+xkYHdzEaSNLXoTUkOjAUC9TM5k+ONg24aUX9QmRhC0NK2HC2JQkD
   DGFrbY4+WU5gKIztk7Zly11ZMN09ReD4rATXzQ+1NaoG75WP2DVrphD2u
   Qfoeb5aCJSsBULvMeU+3Nh7Z560cHBnlFyCf38upb+C2X8HHPaAysoSaJ
   aHwYg7XrKml279i7JuTZAgOl+2SrFFJsl0lTAAKkcLVMGVDgTtS5aKVNN
   Ga15yvq5r60JTjmWF0SCBxQ4WFboq2uy13+yQd/fif+E3Of820Apkm6kd
   PxeaVkwPfqttO0le+VVbFdovMbMzK3MMDobwtTLmxJ+tV/1hrWv7HMsox
   w==;
X-CSE-ConnectionGUID: d+/Q+IdaQhaKupci9dEq+Q==
X-CSE-MsgGUID: uWQmrykbRz2SaDn3y9s0Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="19304255"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="19304255"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 16:50:50 -0700
X-CSE-ConnectionGUID: S9IxZS7QRY6VUeQgGyy4og==
X-CSE-MsgGUID: 2E5/7+VyQSWmNuGjEqlgUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="42057652"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 16:50:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 16:50:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 16:50:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 16:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm5zbx1jS+xDqD+C36FTH0gWCsSpAknRJXBtl+LuMiD7QSh8yIKNh/Hheiz2yVe5G8Y7ILHpJ7wYq0y3JcK1wT4wsHu1+oOUbcuUe1+ObdVbSPNNihF34Uqg6vBLjnBuJer7t6Jr4ZQ3WwdiH4EYJ6xPXdLhJDNj5L2yINdKJsIdfzai1Z8Ny4sScM1fXEe4fYzQoxPG1/6PK0Nejj4gULusulVTkyb+/qk3JLgQ+bHsLfHWKWNYv0J4h9B6IPyOBl123LK+kddFJk2cfmAu652pN/1vqngVNb4WA3u+c0+P0nuQWUaACP8FY2uvNnFwF7rnWk3+vx+fiyrdPspYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l67oEmrakfMZGMzMQG4zaacd+h07aIJ1UsxaGHrKGBU=;
 b=ilyVvlsJjLwl0Z3v7r+tE5SFJ8ExuL8/J2GZqpBfLM1hcmtiQizc2U6rjC5BZAFXvNOFG0zkrRgoRi2jHZsJLlc6S7+xtgKuZsPWRRvLcXChcvivH3eyNdCE/UMEvlp2/KIbefo3J0Dj5cyJmJZX8PXGGAC1cFiE5+bdIvQQ/rXGV3jkJrTRjlsvPv/kbuHoprmhGaBPv45i7U03ibGQ2cv0vrTVxDmZrvyGPMKPr/uM8Oa3heCcTf0aSKK+tIk3Sp8BSLEnbi489m+HG1YQXJcemGO87BHS/lWq3wgUOuYTVu/bhcpdNmBJQSkx1zL/HL3UWRCoVqHU/aneyJE61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 23:50:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Mon, 17 Jun 2024
 23:50:47 +0000
Date: Mon, 17 Jun 2024 16:50:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
CC: Li Ming <ming4.li@intel.com>
Subject: Re: [PATCH v2 1/1] cxl/mem: Fix no cxl_nvd during pmem region
 auto-assembing
Message-ID: <6670cbd4beec2_310129497@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240605101524.2244180-1-ming4.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240605101524.2244180-1-ming4.li@intel.com>
X-ClientProxiedBy: MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: f1306063-4466-4aaf-18fa-08dc8f284f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u2cLAhATuejkBYasky/34YDZDgDy5iZvdCauP8fzZxFHAkRKm3GBlX5Kf8UE?=
 =?us-ascii?Q?P4QvQxzHQPUtJhYw61Q3fgLkXjuBUf4/c92rXjhoja9PmmaZROsuoU2L0iRq?=
 =?us-ascii?Q?y/TZBSlKQW5uou3i4fX0CHsvCi4/haTawVF5E5DdcL8QEMl4Nji5svPzLVDZ?=
 =?us-ascii?Q?1Rgp7UvJAMl4I82ZLeOU7NL8ibo7PV1HyqAY+KmcCIkZh97JUQoP92B3sACG?=
 =?us-ascii?Q?6cL00Fot0sWu7c7IJ7UnatQwmCw5NefrJ/xF2Vu6q2H9uoYfIUW05qZq/XWB?=
 =?us-ascii?Q?2AjOAjUnwCYppk5JfhBvHl3X9UyGmQDvkoUayvMkxsc2oB9Ii0lHcVTrhggD?=
 =?us-ascii?Q?sKz26MY/MoVukMZ4B6hlzOWeepFQ3/l3VCmdVgKz9wG8DSxd99MpUgpUEe81?=
 =?us-ascii?Q?YhI3NFj8CXKnMb7+9haR+G2pw4oFjkJnBkFlymlVmuu4J9laxiU5yxxtYmrs?=
 =?us-ascii?Q?+48nl8hHosTvf5LxcsdGZwPKC/IoitxZJNmjIN3yiWCemedN+utxDD5yxtPG?=
 =?us-ascii?Q?AsE/QPeaWEGv3yOxn7gWbhF2fb79ZeX9sLmkyJop5YZq4Ff7LzajY7lK53/X?=
 =?us-ascii?Q?iQPuW5a9gDyA2IZe6weGWqRobv/OdQ7QsRzLPih5VlIza5Gb2knwc6PsIr8x?=
 =?us-ascii?Q?zTNLzzcRn2zX1Y22DUlDQDQUh2RsW0kNeWmyEkamVsA4ZJqDXYQ+qEfNkEFP?=
 =?us-ascii?Q?cqkCe3VOgOFYxOvO92oU5e1WeHmEgs9hxs2BCOTZBj1NsZo7tgUoQddSZXN8?=
 =?us-ascii?Q?Vg3qO9Uqf8drthL1JELArn+knoqkAMEzrh1e64tg0nVPAJ46UIe3P61ShH2U?=
 =?us-ascii?Q?kg3Ubt06YDzvI3rRXUA7ALNJXRaQxJItTxjvWgBKz22osmsm1LKpojAXlvfl?=
 =?us-ascii?Q?PCCqyolo94efl8+07YfPKVleV/cldBS/yl9Q4Gp6QfuistHYYccgnYe3HbjV?=
 =?us-ascii?Q?K/5CTGAM2yGBKW331mC2exw18wnAEYq5sIevudU2g4+vXEFa2oPbJDseQ7wm?=
 =?us-ascii?Q?s2/4pMbYzpEcbxCDQyjlIFcWVuQtvQxKg4fFK89DpD5+Igk3Fgof5MsPqI0E?=
 =?us-ascii?Q?mkFsW3w+aTI0U3WTsqShVcFYXLsj9MPm9em0JukUBkuuMCey6eiSTlEoKCBI?=
 =?us-ascii?Q?wghRC6prQQh8NqQ8yllg9zEEl07tGFCgcQtAenZ2YWm6pDp4wulP/4z8ntEg?=
 =?us-ascii?Q?xhHRl0rJob5BqF5ZjcUzcPpE5QSOCL+40i+sPdLicnN8KrNZ/LYk30bXfSI4?=
 =?us-ascii?Q?fgJi3/OPKwIjBDjlFQK1t6vfeoslf84A2kTL3sr/z+KR3rtSOV1SJ+KtV3QF?=
 =?us-ascii?Q?zhY3DR6bTYSpWvufIXFlhRJZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X3tjehlzAbq/1f005vOzwfh16O2vowxPcjKO+vbRM+iAuTIkkarR5BzYEpZF?=
 =?us-ascii?Q?gfi0eRm2IWKIiDkN/c5q2SA5CkzTaFtiJKGwsgwvtA6qxMPPOV/ikkYkgsdD?=
 =?us-ascii?Q?N5mNqhFIEjEeF2bA15jdkcCCf8daB9n4wZrVR5Jx6JO5yt7BzlmFsotnDRfa?=
 =?us-ascii?Q?FH3T0B7lrUsqmLwZ4ekNfWeqk0OHcXD9Ko2yRV8fqQloPArMgelaiRvuidTg?=
 =?us-ascii?Q?gasSGeoh3Rf901WLGeNbp7O3JT3mAuvrqZRBa6C/34J+8dC0S+2P55qa6UP8?=
 =?us-ascii?Q?YIJc5q0z5OWRNDc5DL40/8tnlZMgJTFcd5XGKSGY/z+656s92oT4tCgvdTXy?=
 =?us-ascii?Q?ohvDFETIIxN+iMEDp8SIQMvPCLSKEgk+u0Y2kVLxgd0LAZH2pJPVPoZNGSmo?=
 =?us-ascii?Q?P2+z3Y5iVoxbHk9uPteye73PvkaqsBDhLJrQRNRupjx8XGfBr9c6GRj3iwjF?=
 =?us-ascii?Q?SopjZyR1CP3hWjwF3XXDkW8wKSY6CFl0ylfrH6IZ+iR+vOWNJ8AJSBxqiJW4?=
 =?us-ascii?Q?Mx4ORzwvqFNNh0ZxG6MpLEmnR/gaFGs2Tf66FVT9Q/D1cQTjxmszd0Dl2o0t?=
 =?us-ascii?Q?ogq/+fem/R/AF0L6ywmoUBav2YB9IlmxfojbE70QQcmxivdQSIIDx7BMJ+Du?=
 =?us-ascii?Q?iDupD8H013tdKK52L2e9ABOm+peCwXEXLR6/K/1RZvNsJpl9QO1uK9q+cWND?=
 =?us-ascii?Q?f6EP56P1UxSzHGQWT0Nz0TfdINdP8O8eOcz/SfhHFzE3wYhCGwI+evlf/jYx?=
 =?us-ascii?Q?6mEsZQ9JZVCsEzKkhTDFy1nVm/4qXF6q1C7zs9Hw0ZVAOjgMQI5AzG2yJmVf?=
 =?us-ascii?Q?/EWQpPLcnF1Hea6ppHxGW9zL4s5GMnpeVK7KtnXUGwkShfbVZqps3JnqoazQ?=
 =?us-ascii?Q?lDPGhO8HLmI2vN8IR/Vhv7C8N69UX0tmomBtIlErwxAbaY7y7eRFWH0/+xS2?=
 =?us-ascii?Q?L7p6UKdlfXdGLyfEkkvzbdD5/DTZRrWhbD1iAJXGlEDN6BfEfp6xu2SGzs6V?=
 =?us-ascii?Q?C0S6Nckfo6eqLpZotqi8ZZ8TVsCNvopkbrLImOU3F48GLoHNyB16+RK6DB2o?=
 =?us-ascii?Q?kbev+Ramdq2FLiw4KhL+gT9e54jb9BuCz2y5s+LQyo9okw4yR7/ioCAarbL8?=
 =?us-ascii?Q?RqfXjsep5spgW7ZOVAi10EMviIAq/noBIFsddagV0xXZlfRATtAGgG16Do0f?=
 =?us-ascii?Q?JdeVlGbagtPHceeG3I6hF+qEyKsYGopSJfabUVnYO2rBX1FQy7l5YJsX+jdC?=
 =?us-ascii?Q?R/aMsGO209b5Cd1dZSOoYqrssTHKhRBE7GPHEjOqfJPNdQxLZYdT9ynRIWl2?=
 =?us-ascii?Q?MImZOnihqi+sy/ecOnlwjL2Ha+cNnP/7oeN4VyIiY8F1AcqRtnPkKu/NgRAd?=
 =?us-ascii?Q?GYfsk5biEdJtwAjvq2j/ewJJFov+5ZtKjlvAcRepp0nOPz22KqNplfDE2dYl?=
 =?us-ascii?Q?1Cv1qcH3dhVMDeQOW1aCJzcE/IVHsZmixW2KZCeymOwiLfQXa/QGRQOUkro6?=
 =?us-ascii?Q?a0uZdKnnFPSyYmhq+HcekC7YjnM8JP2xLWVxISTlh2mOePo8OnUeoaMlnac6?=
 =?us-ascii?Q?ti9xOVr40L38kMgU5TeLTfzBfpcdFIl/ZFAEtKvEk0/M8q50WisThe/Ggf2H?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1306063-4466-4aaf-18fa-08dc8f284f50
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 23:50:47.3061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NgLBpDq6R0QbdANJdQ0pXZP3o6EnStiXHshtlZXnCJwn/IwYHZHSnSWCLCMQS3CJ/TpR4gWAOOI7hrdmmi+/IdPCkkSJxT0TEg/qby9MPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
X-OriginatorOrg: intel.com

Li Ming wrote:
> When CXL subsystem is auto-assembling a pmem region during cxl
> endpoint port probing, always hit below calltrack.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000078
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  RIP: 0010:cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>  Call Trace:
>   <TASK>
>   ? __die+0x24/0x70
>   ? page_fault_oops+0x82/0x160
>   ? do_user_addr_fault+0x65/0x6b0
>   ? exc_page_fault+0x7d/0x170
>   ? asm_exc_page_fault+0x26/0x30
>   ? cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>   ? cxl_pmem_region_probe+0x1ac/0x360 [cxl_pmem]
>   cxl_bus_probe+0x1b/0x60 [cxl_core]
>   really_probe+0x173/0x410
>   ? __pfx___device_attach_driver+0x10/0x10
>   __driver_probe_device+0x80/0x170
>   driver_probe_device+0x1e/0x90
>   __device_attach_driver+0x90/0x120
>   bus_for_each_drv+0x84/0xe0
>   __device_attach+0xbc/0x1f0
>   bus_probe_device+0x90/0xa0
>   device_add+0x51c/0x710
>   devm_cxl_add_pmem_region+0x1b5/0x380 [cxl_core]
>   cxl_bus_probe+0x1b/0x60 [cxl_core]
> 
> Because the cxl_nvd of the memdev is necessary during pmem region
> probing, but the cxl_nvd can be registered only after endpoint port
> probing done, that is a collision dependency, so adjust the sequence
> between cxl_nvd registration and adding endpoint port to guarantee there
> is a cxl_nvd in memdev during the pmem region auto-assembling.
> 
> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
