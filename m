Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6E15E96
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jan 2024 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cgt+hbH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704222391; x=1735758391;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gYgHtjnf1MHdTv0kVq+mVM0KRRJRvgWYkxtZ+anyak4=;
  b=Cgt+hbH4H1uUYvABwOaQw3AdfZGMdn4ut97ZkrojkiWUfujbS/mGexiC
   /IsrO8OYMvlFhP/M20lj01CsmjSBORHvU5B6sHHPnrK2rP4m4EqX/ZJf9
   VXFipIwJVrt05UHJkDdjNGQfT2V96/5IprvcQkvmonG4dW8OPkysd88m4
   Zdrec4hlY4sW45omifuPSyOsywwwhAoJB5zx8wGeJ2S5pGdjLoW5ehtzN
   qi8MDfp3eyKR0mubqXtQHSdBv/t8FpTNgXgHziPqkbEhm3Fi22iNsioW6
   l38s7Zrz01rNsmGWSXmShLUEuL8+R6/QSww81JWU2pZ6d2l6pPRFC1r09
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="396643031"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="396643031"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:06:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="903191067"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="903191067"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 11:06:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 11:06:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 11:06:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 11:06:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 11:06:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW8u/YLRbX2uPIJ0OU978VlsxN9QA2ekWNM9GrKZr4BwSV9l1fsq4oDQBurOSwAb1NQmy7i0CwJtsk8n7aSasry/dPfoOtNX/ngqNk8Y0odo8E0tl+YFkJLB84WSYQVAarONyJIqAV0dr1fXOAwGKTBlL2lBf2CLBEIjuKsxuUj+V1bEi2Zy9mqQqDfwlWDpMgmO9zVZggHuI+Vw5vq9yVu/LtCc7Dr1tsPP8Q6kcXTAEJQf6QK8NeX1UlqhngCYTACFVk/Gugos8PzFqmnJrpid1gM0renETAJMawxl2/EL2yftcsB92/GRkwPYOx6suLh0O72RMscOwQheebawGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTLeE7lePvt0WbDzMI2BRK2/+GyYlEgulOCk7KDHaw0=;
 b=JmHlKbJly91Iyn1w6g0kMt72YXaFapotsmIFYo8l6lDcnZXc+zB6QuYw+dvVGZBGvNBl3kN+rvH+MWJGTXU0nAgJ6cktbRCQS6L2ZydmyHHDh1txJnLjaI6YXQLpixsrgkaAr6LCngutdbp4SA2LKDOdhrkNnQbH2TrUoARStlTodyT7FUbjtYqK4Kf3xFE36hUWDGMBaHJ0j2/TiQioeKlDdJ+xvb1RzQaX4KXPRbEYiCs00K+74SBFAeE7bSevZXl7lrBfN/fcGcqYaR+6q7Qe8ig/VCI7F/N1bWW/4J2hX5LlHksXZ+orkaq7pATZM0rgxM3Mgaq4kZDoelPSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 19:06:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 19:06:26 +0000
Date: Tue, 2 Jan 2024 11:06:22 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>
Subject: RE: [PATCH v4] cxl/region: Add dev_dbg() detail on failure to
 allocate HPA space
Message-ID: <65945eaee5923_8dc6829426@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240102174505.1489656-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240102174505.1489656-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:303:6a::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e29af6b-c76f-4e22-99f1-08dc0bc5eafa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUH28yJ6MrEki6wWBEKI0zW1S7i22hLj+4EKk4N0xMWwUc2bzLVpg4b1b7ZOwawhcokr74Win/cZ/4iNZyTS7K3o//NaCovDGFXVD2XF/kuJZ+rsavl98GeyBJSZ3/kxNdjJpb/lMx2T9+YLevSNIvj8wKS6L69w2rSQlEVclUisjoCLQ7OAHbxsxsMcULJ4HYlKxaYqtMKrAfgI2V3odxNjt4UrzVMVnhqjKAMdJTfTuosYLPVau26wzbDZNkkwBCF0IEi/xMYK92OHj4FNIB/K0ocSK4KnVtVQZD62S/FmbdkNy3hBwGMRAH/0OKZb0f2r1bemaIZJCbf022G/1CTw7dvoZ9Aj1lIXXYJgo9xpJnlQgsk70XsrYuHPBwHf+60Ehjnb7CP0MyWKvo4xV3VGowYfGxC6YcW+WfxR4jqUlqD+7pZM1HPSZIfREVpwfViaTYxibhCte92eqBVB1ex9NrH1WWFcHZJFCi3k42iEvaBpmxSOKst0hjk8CDnk3nO5CdwEHBs3ORS5o+jZr0fuTuokGpwplgNHLRCVnyROQxNVHRiSqzn/FNp0WfT1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(478600001)(66556008)(6506007)(9686003)(66476007)(6486002)(6512007)(86362001)(66946007)(82960400001)(38100700002)(26005)(4326008)(2906002)(83380400001)(41300700001)(6666004)(8676002)(316002)(110136005)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ZVm+pcOhL7nRV33iGkA8heWGI0k84LHFlV7CaxB4YM73A5kBGwXwKwXR3gR?=
 =?us-ascii?Q?klbGc6zXVjBFenOPdSeoxIpJ504edrIsuz723ZGS3REP0YS/HhfYM3roucGK?=
 =?us-ascii?Q?WXwNy04Ixb6IjpkxQOHW4Vi+fXg8LRIjy3GPvZ0rx7ieGfQnx1re+x+yIp+t?=
 =?us-ascii?Q?S/AFNlvoAwJybF+PKHlyAn9+NsjB1TZypenLJpGiczFhXA41SZk4sF6SsqTG?=
 =?us-ascii?Q?i/ZzU2UNxRLNQ7fwpId97yTziFqYpSHlBmK62vmLylsQ9iAyZzIYS0kAgHiw?=
 =?us-ascii?Q?BwyLeHJqIYBVG+JwPmjFhrnX89Iv7l3j7ggBdxg9WPx+EijyDoNSsbtr36jU?=
 =?us-ascii?Q?rZln7XMke9sSCNQD26MwGZ3dbTBQ40nDyYTtDJ1ZE6qZ/t/+aQA4DAo8j4dE?=
 =?us-ascii?Q?kjIM6CtaNWKnfOVSl+BTv2jkZhIlvystjTtbIS3+s7Fr3/7K+6NhlN/ytegj?=
 =?us-ascii?Q?uRgzjXHJpIVZw87NxjvSgdnK6eCDzW6LxzKZW8m9r/AHal73H7qtKnPEByEH?=
 =?us-ascii?Q?jEMy5byEeNIdoVMoiiK4ycccdHaWo5SwD00SACWt8rU3mpaMCg3l8s5UG23h?=
 =?us-ascii?Q?Vgk0UXsAgTMui38F8mwfvF+8KbBTEImVNTvpcuxDxAsoIbLseOaaas5vY1A5?=
 =?us-ascii?Q?lunhxeIcblBTFmHv0LZMSizqtUUP8nex0bF6jLtGU103+7uXEdj5CsPEG56u?=
 =?us-ascii?Q?jTuQ9PuC7v25/+hDipaflkXNfdgl06Cwy/dSHa1VCBvS5ucPpCrCN8UfyHdu?=
 =?us-ascii?Q?YOczevQJgpY5iO9cEJ5XCNbJ1sXSniAD8vI+Ub/6GtpgD2pYJYBCv3iWpR5z?=
 =?us-ascii?Q?091+mJv90bdKqxcCIIZG9k2YykecTbsdosmAuVmaTyurVHP/yzGRkIWaI1Sj?=
 =?us-ascii?Q?thnghPDsqkwsEVEO9Io7xsSYeBGop2/Ngx9Khq/b0+rSgn1w5DZLD4u3+u2P?=
 =?us-ascii?Q?igR745rQHG0wlkDPRiQbkw06ewMWyOTHvRepAoZo2TzY83blbekayHna/Vhc?=
 =?us-ascii?Q?aRCpwclZbrXDjFtAaWdIkfN+S9aM3CA8MsTlCS2Isq+afTflzigbb9LDQjfi?=
 =?us-ascii?Q?VqYuogITOC2VWF3OGqMDvZGcvUxd4ScC1dOuTt0Q6VuIxdbfIH0vszZ4L+di?=
 =?us-ascii?Q?66Qq7EaCV/YcRv+rN5BJCKexOQREFFx65pYgpnBgBVqMbqQ7IXE512JW/4R9?=
 =?us-ascii?Q?KmgUgeUouW9BWOBVyW8yTbI2TniDSobQRk6EuTncEw3i93K99V+VrKRI/jra?=
 =?us-ascii?Q?55QAzzeo94rGLLFSdBl/ej0y4u4SeEMq8P3ioS0g0wWT9p/XV17WVqiM72NH?=
 =?us-ascii?Q?IHamq3A2OZUwvl4lEHOjfAxtShsGK8sKwIgtq01x6QWBp6f7ZlEnZ+zY6YoQ?=
 =?us-ascii?Q?Mrheq/5TRU+2nip2uvc8pn/gDQX3N7Odpj4Cw3ssSr5oV/s6bSX2WWsmWdZI?=
 =?us-ascii?Q?5lXyULsylbxA/S8LMoOgByPipWxEdT9kmvThyl90GlNRo8UA5UR689gtZLgB?=
 =?us-ascii?Q?QpYnqwUw+KF53eHzZY+eE2Ox1gKd0dtxtBEkduB7GyVbaKo/Pxb41woSS/8R?=
 =?us-ascii?Q?HSPUGqyLWN+GQuirC19Yv4tuXlG2Zpc+9T28C05KdH0SIU5aF72TJzT8Qg4v?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e29af6b-c76f-4e22-99f1-08dc0bc5eafa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 19:06:25.9592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rR5Ww0A9br4EGGD7Rr9caPCcp6h8JrSPMnW0f1D9lNgLUopumG4jgMtsbIOncgPzuolLZDniw02ob1Ak4Qudek18KTX+zPdesMsjHBmw28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the region driver fails while allocating HPA space for a
> new region it can be because the parent resource, the CXL Window,
> has no more available space.
> 
> In that case, the debug user sees this message:
> cxl_core:alloc_hpa:555: cxl region2: failed to allocate HPA: -34
> 
> Expand the message like this:
> cxl_core:alloc_hpa:555: cxl region8: HPA allocation error (-34) for size:0x20000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]
> 
> Now the debug user can examine /proc/iomem and consider actions
> like removing other allocations in that space or reducing the
> size of their region request.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> 
> Dan - Let me know if you need a separate patch as this is already
> in cxl/next

I went ahead and took Randy's incremental fixup for this reason.
