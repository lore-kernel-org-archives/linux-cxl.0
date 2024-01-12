Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D8179B5
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nK5Sqm6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705098011; x=1736634011;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oEiXsMyEt8XlwjfBXjr3PqMdplHIqvNDMhN54GDqaSk=;
  b=nK5Sqm6dgpN6/reGru5n8W1qF7CgDJ8gNQHlqsF9EwDjnSRsU7ts8V6j
   YQ6hEMa6zzMfR6LWb7AIpytL6+vuyIk7fhNv8P0zBo/I1lhL0MrbHt2h3
   yp/SpTTBjNaWviwBtVqJ/zoeJ9eG3ooeqNsQ8lv4eqbHGrxQAy6TUz9hq
   arjlDIrUiIvZj253wKMb2IF/sigrS6fTchfYuMe88bfo5IekauxzU3EQJ
   Y61hDbrnv8rmLbNBwoaj2eWCaderhz+oZNeAXFEri4b+NksXhKNfWc1ff
   9rENCFOB8Sk1LXUHfj+Xc1Qp4AyT4RxtKInNXCg95AtUtOcpasqSNZPQi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="12784962"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="12784962"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 14:20:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1114354099"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="1114354099"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 14:20:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 14:20:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 14:20:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 14:20:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7C/gI3YkeRLuWKIzfpLFtX6fV1qiVrm4YuGYcDGRbVujb9uZqWnUM+mWpbOrPxKQ9YXefa7Z/1oGaSMtTzDyp1xdKqbXdD1b18E0ie65jw6IL0A9uXjSbZMIoOqQrMhyASiXj69/5CetXWkKANQOakj2E9Y6i1+v9Nk1kvHrh+G+stvxqbqj3zW9BAq330Nt5GVJUp0xgHr2UWCsTdN+g9yGYK8QWG9fgffL2x2DP8NLo2ZLu7hPRsqTnD11WuY8mWlIHpGuxtxPTBcU5GPFcf+vgorfpj3P3yS5Xd+jhvwZche6Z8auZPKONlM7CUAGPoinlbKJK+IVVDtgdbA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdyoDkd4kMWU0BkrM6rS2cDa5l9rqzVZer5D+yqyPDo=;
 b=OXjlgC1xFQmib+6dXB5Tm9JAp0Dy5LOmohEd6or10O+/6kUtdtANGR+PnjGQ/dLT5d+zGomH/11eBEYBtFYBnt6afOtruLERAphW0NfvjlTIkHXxvInDW5lUQHiF4bQdSx6yEAK8XcAgWqvTbjAmrJHk3k2JkG+ysY3IHAcmd5vilpJm0yTBUocx8mfpE9x1ewuu/B1WSlEDc3ETjkJ49E+PU85//nhvqJyCIib8fc8ufGpfRKLZh96aAm48cDJfGXalnW4ZLFoXffniA9G+phF9cHirPgo0Cltory2wok6ousLx5HrLeem84Pmr5N5aM9VDYnPOb7vQNQawdOiN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 22:20:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 22:20:07 +0000
Date: Fri, 12 Jan 2024 14:20:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Mike Rapoport <rppt@kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, <x86@kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/numa: Fix the sort compare func used in
 numa_fill_memblks()
Message-ID: <65a1bb13f0262_3b8e29483@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1705085543.git.alison.schofield@intel.com>
 <99dcb3ae87e04995e9f293f6158dc8fa0749a487.1705085543.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <99dcb3ae87e04995e9f293f6158dc8fa0749a487.1705085543.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: edf7416a-838d-4c79-252c-08dc13bca1e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bH2GC0sbD8G0M0/Mlk9yJeGlxK+oHrouIvyI7DU03bTrvYBZ1i7bkl0Z2/9/blfBJHxK3+wPw1UNS+baHUcFlQaTYohtXJMGD6cTQHM4dq22Khpuy3vEXm/7ew94ui+EVUIqi3mPV9IbL1RD/er6Idm3DZd1JhsROs50fjWeb9JSPkR3EvQ1XJuJmPwmm9cBkeiCajC4WtEotDisDcyiaWuuDyENXbhbcOGllMVOhSl9Ta+K374IDnbSgcqR1FZRfCkma80e5rp8ogOCHa6pNB0dN5lXIyJM4EWHsOEZWYNNKiEo3XcbPOLK9T1bO7Ez7OGhFfuxoF89lihASx9P33XO4rQ49myzOPubMG7lBtiEaG8a53iUqCfqb/niUdAlhMa1zbjwsFotxb02SCyReq/xw+L4rIkAZpvnqp4RQvJzz0Y37WeCGQ7IEowl7LrbZRNaBDW8+xNEX9okfAzHHOB1xReABWC2pXejH/BoO4wBgzRKZ+WUlpIIMdD/Pe6uZ8o3YaZj0ktMvGM1Gprb4saZmCOOW09CPj8wpQ25ZqCh+ISEERI7GkiV2voagYjbtQ5yJK7tdNcwCW04nS/+dqqqHtuGSO24dc3wted7ybQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(921011)(2906002)(7416002)(5660300002)(41300700001)(6512007)(6486002)(478600001)(38100700002)(83380400001)(26005)(66556008)(9686003)(6666004)(82960400001)(86362001)(6506007)(8936002)(4326008)(8676002)(66476007)(66946007)(316002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1Ull1Mtl/e9LFmxfuJ1mHbBIYNCgmhcps5+m8BsrFHx/phAQ6KXEzExkXHs?=
 =?us-ascii?Q?K2yDT2dpg7CUj8v1pc3tSAQuOQkI1z9bZ9mqAMkytHEpkL4ZVsW8QNwzVkrg?=
 =?us-ascii?Q?l8BHRax+wzoNA5NaWoDSgZe6CFWUGDa04t2bxAnLVRFkxKI9wfBUf2sXZUpF?=
 =?us-ascii?Q?7T5KFpLg/MK9NPdyyfg61BpjXHESbCTHsnnAKKXCj8tGUhbvnI+l0Grji58e?=
 =?us-ascii?Q?kVZkg3JpmCOc/evEG5jX7ApoigGCvomMSW0kL/xyfGwE7LSBNgi1d4sOmnQn?=
 =?us-ascii?Q?1rhYp5AEDV51X5/XIC3jn+eU5urTOj0e6cYKOETPiyOyX6vgFAbQ8jh8EZS5?=
 =?us-ascii?Q?pxXjdUsAvBUudLy/G9fi6jLXMfWRGS9rqotLnP3dse7HtbT5IKg/lFLCIMIb?=
 =?us-ascii?Q?Dx/qsioWAObhoASA0yX/ciaCTQefvA3mZNjczAwAoaB1KfBjdncCJDHZBV+T?=
 =?us-ascii?Q?wq7ZKes1NTotfezwCQMfBNWnwK0suGPaw/bzpo34vKLms3HJTPBxV/8isi/m?=
 =?us-ascii?Q?8w2X8UaOQPQcTWa0dia6Gtx27VbGQwGP7G5h1EjTURZB6f/Xhg3RVQ3OEjzx?=
 =?us-ascii?Q?VxTS813VY10yuowZInQBBdmkEWfoO2aYeOzTbExkrXSWE9kX5LsCWpiM63p6?=
 =?us-ascii?Q?NK75dSUfikovSoY01m9eR4gfE32C1pm1Iq7xw6I1VEIEpHcXcpXxK7OWj8T8?=
 =?us-ascii?Q?9CrUp0OveFRNwiLQxKVwg/buwzE9Dk0MtIlCBLR/wQEKkf+1w9iS3ccrwNXo?=
 =?us-ascii?Q?u6YmExk1GRYm/zdwJM70K6UQYjT1pVwixZclQY/ZGF4XMn2I/3Zn7RdyToDK?=
 =?us-ascii?Q?wlZXhzXxrcOVBzYboHAoCZSMoz/e+4unRtcCIsnOrZj1Fl1QY9m7o9QwnUt+?=
 =?us-ascii?Q?B4XbTSmZiMh5LhiHWIbihAQmdVUW4PYzqHm9ChEu8CCb8WkC/Fm4AjpchEbE?=
 =?us-ascii?Q?lH5VAdVR+IiYfJDg+2pJLxQrKyYTrskiJm94Xe1f91bZgkdfUDzL3+qYi2Me?=
 =?us-ascii?Q?WravcATWMeODDjJwPur8jvNCFmnIahh338KkL+CN/3W2r9H+ViKjv343h/0g?=
 =?us-ascii?Q?rKLHs5IQUNKJR+wRppjuTCqjPstX2NU8cY5j/M96QqJJu34m456XBk92oYbA?=
 =?us-ascii?Q?j/2YaAKiaDMh/9PD6TlHVw3dbSiu1VMA+o63GKhw3oPZ3y4GBkJgV/NoSblQ?=
 =?us-ascii?Q?lR7eccvqddiWrhKJoQF2bMaEst6DgskXXn+MEwLY5DZT7bTdOt2z3Qa71J38?=
 =?us-ascii?Q?B4VnmeXy6lil4ufTYbFZV6kv3SCmCgcsV/VqPQV7WgItQC2evv6gbm33lIsn?=
 =?us-ascii?Q?rWB7cS+uNEvVtl6p/WJVZB5LZ85y29+qcn9FgzKTR/n2Mfw805+uLsfZyH81?=
 =?us-ascii?Q?FOK6cP74LcXw3rvpKGFWUQiPdLHkJkHlwuUjsjcST7CGCOQObOFV4bQC96OV?=
 =?us-ascii?Q?JL24BhnCvJj0cUROrAt65nJzm3uj3dSaTRqrORCcWGGdOG74192Z1DTYWhVL?=
 =?us-ascii?Q?8smdLHDdP2xdRAJWzevMmlgHcG+1t0hIKHx0jUDXXwB/mFHtDYcIxa5M63k2?=
 =?us-ascii?Q?vlJ9kwX0k4mr5CdXKt/2+7Rpt23kMc0OUzQAX0eomsl28f9tzlyAwCIQztro?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edf7416a-838d-4c79-252c-08dc13bca1e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 22:20:07.2691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHj7IgK27b1+iAACcqDfQX+oVnRXb/IMWYAIEQre2PnNJ7bNGQfwOam71nRYpCQyWOA6vaPh2yrfKQxY5oDcxKg5DQbdb8jDCMtQq4l5KVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The compare function used to sort memblks into starting address
> order fails when the result of its u64 address subtraction gets
> truncated to an int upon return.
> 
> The impact of the bad sort is that memblks will be filled out
> incorrectly. Depending on the set of memblks, a user may see no
> errors at all but still have a bad fill, or see messages reporting
> a node overlap that leads to numa init failure:
> 
> [] node 0 [mem: ] overlaps with node 1 [mem: ]
> [] No NUMA configuration found
> 
> Replace with a comparison that can only result in: 1, 0, -1.

Good eye!

> Fixes: 8f012db27c95 ("x86/numa: Introduce numa_fill_memblks()")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  arch/x86/mm/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 8ada9bbfad58..65e9a6e391c0 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -934,7 +934,7 @@ static int __init cmp_memblk(const void *a, const void *b)
>  	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
>  	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
>  
> -	return ma->start - mb->start;
> +	return (ma->start > mb->start) - (ma->start < mb->start);

Maybe just do the less clever but obviously correct thing like 
other unsigned compares like ktime_compare():

    if (ma->start > mb->start)
        return 1;
    if (ma->start < mb->start)
        return -1;
    return 0;

...but otherwise this looks good to me.
