Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CF73188
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437121; cv=fail; b=q1qLyRYuckjFw1CxTyXRJVvShUdSsj022UKZb/7eSAfWuPF9HULLnpbiH8OHiZ230frdfiwVMRfTW7RYKiZNa0Iq2RQlB6npnVVMSlBwHwIG5KuG9OebDoczgpLRTqUQP20Jf9aDbLGXFpGYkNxsWM69n3W2kf3Ed1ielj0HAPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437121; c=relaxed/simple;
	bh=tKHM1NCCfBWBbw7o8PuXxjLZP3qNiZydLlqfqzF3emQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dBjpx4AdBkBKz3cBbxSd9hdXWS/UYXSdGLKW61UejDW52HtRHlvDlz+A+eq5eCMH0DXIK7nX1molqvqgyvV+IS2IZZkxPW8sq2bAMwpReyO7U1RUQC/O7rrt8rnMqdMrmW/9x1ZJxCKRc++FFihwjp3Kj7PA7p91Nlg+cxWL6zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpZFqGEP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpZFqGEP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710437119; x=1741973119;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tKHM1NCCfBWBbw7o8PuXxjLZP3qNiZydLlqfqzF3emQ=;
  b=ZpZFqGEP9xC2gYpGOLFIEJZPd9bK5EjxNL0n5UC3lzU3Cu18U17qwe3l
   Wg3RWf+u0qyzf3gSaoTZA1VDBb9SgMm0CfdJYMMHnQJC+2leO0sKRv4oN
   zqRpu31kdwAeVL355/iTlz5n1oUoNrMiihgMG1oaw4E5jzJrpedK9E+HA
   XzRnR66rhg1VUEtlpDxVWhrYYH5SQG5+uRzAGBUqYEz4lcB/2JLsKvV4y
   hf4sjY+ioBW747GlgwTfZNc9qiPutw5XoUx1xeCthRjWm6nWMpObHBLrR
   CtW1n8VgYcWJEY2Ix9s35HJT2l47uJCaOK8VSJL8Hlkr4YnRId7GpWrOx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5129933"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="5129933"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 10:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="17038192"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 10:25:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 10:25:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 10:25:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 10:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHmnjF27XhBoCPg/n6DcCSmZjjueu6F0fyqMSXDzVtkySvoSH6nSAjHQvUw2f1W2WGpyVGcdHUW43rSvPYmbQcGPx5+BK0hcThHkzUfDdVZ1Eni9lzaTlUr1+G60LWBX706UGNrP33alGDJWWdrO/sL5z94bttpoW1kPMyUxtYy4l8iKRuo9bajDIs2AxiSYqNxljHTa580hMy2axpFDjZmk45YfvhTdMG/Jt7xnbvJ08VcyJDipmqXzreEz8W/kKpPl/x/Ly4zIS9drloRiEe9w3sOtqdvy4VjEtUX763yyeaSondregTVlidHXssPyzv/dUX3hRQMK/s2S9tE2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvUt7g/Yqq0jInuwiSAjHK7TsR+F8L5emrs7w3fcaCc=;
 b=k/y6qB63DE7l/pfD2aFeAL2tp/+KrZS1oHoEgqDMGvGgb8T8klCWvIbesFrmTbH8Ou8bXUFaZWd1QsU/DAATLyoKUc8pY2fU6vHeRNBhF88fEQpigAIvRtI1xOJHDQNP1QuhnHrvbYWi/tNyEXxODW3Z+mho5kvWOyNFCbSY8Ie0UDJqWgIMMmjlsBHHg6szXj3D5nHDMrcmXEpijgK3nKfIIMRC9zueUarICgdvxJWPsfJGkLpMF5jF073vmO7jgXB3oWfaFARZICWZBl4q8hjk1MHVTiSIaRUvoFECiZfnTQIkt4Ci6ACb3zojPmrtIz25VRkoZBta1JflNd4ZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 17:25:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 17:25:15 +0000
Date: Thu, 14 Mar 2024 10:25:11 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, <rostedt@goodmis.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/trace: Initialize cxl_poison region name to NULL
Message-ID: <65f332f7d1050_13f3a2944c@iweiny-mobl.notmuch>
References: <20240314044301.2108650-1-alison.schofield@intel.com>
 <65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>
 <ZfMuDlDbVHtlAL8z@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZfMuDlDbVHtlAL8z@aschofie-mobl2>
X-ClientProxiedBy: BY5PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e4a010-f3b7-4120-2045-08dc444bb64b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/Qp8UC36eyyyNmu/zBApglbaKN3S2WfjPj4FW/Qv/lzYDYTLiYNrd7r4U5iHZ/Dx0ZE9pZlPSCNA7BAaP6irW2lro6bGAb9gRr7SyFuWHSTTUkZVM8qhONrhGFYtCzCdxZvifSu6S6BDFJUErnR4viPITSRN1KKDjRQlUbReOY4d7nlrzBs3tjPvlcEyM0UW0u1tvDu6RLtQzSMecW9EdQJUph1yHVwUP9b82/ts+Ddbk19SOVGJAAwQg0RmcnreeNzQn5w8pD0KO36K0wvp+bwJ+KSkRGQ2iTZenac7cOqLdtrqpomx0cE7Mj2mnEL0+cRSUegarXfDu9HlmPl6j2S8y+4+Vre7dxh7n+9V8BFyzhmNQLHsP2ov5h1eW/F7V/x5jnXkaLTW+O1Hz/n29kPQnV/7la1vlCiqZxEOb0kIKT3PT5M3hO45CSzbv83L3TB7yrapIooAenImJzz0mPkG0gOuEhc3P7SgyIj3z+xYPnAW1zn0M2my78hGiAOP6dh4IrtOL3TGLCg+GUvrTAAzNqm8TCGCGiU3dCG4tALh69gN7cBrGMeJ0K4pndsh9y0kVbVLmWsEJyybgoXz4Z/iqX+mqE7u+G3kaqQVdC9RmsHc6RDv/zkX9+tHtSmrRyEkyOUxjCm9A964woFO38PzvZuz9VRkC4W+JZaF5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XfH/+J0APPDTH1s+3yv2jyq5twcdCOxUERKsV8clDDBqhU0S/N4A/InefgWE?=
 =?us-ascii?Q?zPo+wCXyC3rlulTwVO8K1b7UfDgXBvn8fJSHm4gF+Yb1W7Ag/XSIAXNfvZj+?=
 =?us-ascii?Q?JYNL2o5ph9BK3okRqcD31kGQQ2XRw8TXyGXSdVB5E6JbfEAv5Do28DAR4kkB?=
 =?us-ascii?Q?VA1d7DuZLGw62M3v5IZacy2IJTv36xE0VYg05UhyOREwkSAB4mNqKT7oW7fY?=
 =?us-ascii?Q?oVoU0PzGI5dEghPl7Lgp+Yyp7n+4TPbz2l3LRmdUls54BJTZXtH3KMBUGUEA?=
 =?us-ascii?Q?6k7/C91akyY5Co0sbqeaHaNrFw1yvGu6mEQ6iizOFTraW8CW6fr3Ttdd+/mp?=
 =?us-ascii?Q?RmWCoJ6cB08K73BfM/BJIqykQxxTQJFVBI2ciwhIIoPH+V7CXeAn9xH+eplz?=
 =?us-ascii?Q?V5V4j7Cb09L13gFe9hi8bv2gncz285B6Il3BvpM283CFtGLG278myHS+YA0p?=
 =?us-ascii?Q?nz/4zNiGPYloCqBk1D1SOfegj8F/9+k9Atj3KfkkxoC3NhQPPRxOMobtZN6D?=
 =?us-ascii?Q?vo5Fm4bBTVKMAGneZaymd52YOtesNqhOEQyWhGEbuopr8lq4fWmdfedcKmct?=
 =?us-ascii?Q?O4Dbzj4YdBpgGTCukNg2v6y0BGwUaLGuOPmch0y8bj32EQWmI8gJpuNXNj9c?=
 =?us-ascii?Q?W4Q3AOIOE+VoFq8x//DCqXxwIHwMYftdoespIgmUcaaCRFJtC+IhXgyAYJNN?=
 =?us-ascii?Q?yevbqYa1BInc+PhzkUkD+bQIk6zMOPK6vXEP1+T4aLOL9+uUhfgWEuXefduN?=
 =?us-ascii?Q?4SyDHw9klNgg9jlWkjxYCw6JvJcz/4TM/DU3vXL28caKyv+rlApIAnQAELRz?=
 =?us-ascii?Q?iIx3p8KoqPCohcY95gAVu/mIwJnPdtWghICKFB2MfGtDKLAbNOyEBUuMqnbY?=
 =?us-ascii?Q?hO+Tt6o6cvrg8+rN1eiArkXNnz7VXEejPoZLabQgbwW/2Oo75zr4VKCzNihv?=
 =?us-ascii?Q?VTk4os4VxDsERaqqpMH7ag/R4TN9ny93AFel30mXWgR0TQ8bOtdZSgj9FYkf?=
 =?us-ascii?Q?WI+6FaIf70UlVoiVpKQlXCBfRvGlE2GbNF5zTOBJ3KxMdtpe0czw0NhAYD2E?=
 =?us-ascii?Q?iz5OlNJOZ/+Qc4A9SP2+hJww80Ce8h/328THgRhVR7S5fVaD2A2l4qfHYYZ/?=
 =?us-ascii?Q?fFNqAUiXNDBIU7XKAnqxvpy5WxPoGJXOk2GRaBP4o8cJOGkewuDhT+I3F3uu?=
 =?us-ascii?Q?iopHzMOs04y4Ny/VQdaQrQ6/bmlZ0DMDhKHp7M0E3XbAmFC/MpNjHDAVaBRc?=
 =?us-ascii?Q?PCRdovRl0IQsrEMfHMm2zj0xYcMkNiaTSm2KEmQx2PgpfRN5byLXA5V6KcvK?=
 =?us-ascii?Q?zUJ7qFZn4Km/bLOwCBmw05zi7pKGNXUfKJrhHqhrdj8tyNivyARFl98cVlmW?=
 =?us-ascii?Q?2LBDvJj7hZyj0VcLmaO5h1OmpFQi6R3vAHWo7zWQiXnjKYj3IV4joaApsX6s?=
 =?us-ascii?Q?DazZBXagKnEfuqtB7ruAOxq6GPwXLip60yZPx54LAK4amh70tG7hmi3aHgZ0?=
 =?us-ascii?Q?HQXUVaRS1NaBAHVxPlvjG0f0qXVURqBFt/qIWyfAMvGbtR3tF9/ERl9I+hzz?=
 =?us-ascii?Q?ZFPs8zib2zONFrogVjAqHSSm8h1psEZ9apf/Vm+m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e4a010-f3b7-4120-2045-08dc444bb64b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 17:25:15.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDHFQutteQU+OIgauXgL8KG+OB4oK9ycoiyPLG9+RMpf8MYU/B6z98HT/WWBu+6uelMjLC8qxgGhxv6kFrQAAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Thu, Mar 14, 2024 at 06:53:47AM -0700, Ira Weiny wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > The TP_STRUCT__entry that gets assigned the region name, or an
> > > empty string if no region is present, is erroneously initialized
> > > to the cxl_region pointer. It needs to be initialized to NULL
> > > otherwise its length is wrong and garbage chars can appear in
> > > the kernel trace output: /sys/kernel/tracing/trace
> > > 
> > > Impact is that tooling depending on that trace data can miss
> > > picking up a valid event when searching by region name. The
> > > TP_printk() output, if enabled, does emit the correct region
> > > names in the dmesg log.
> > > 
> > > This was found during testing of the cxl-list option to report
> > > media-errors for a region.
> > > 
> > > Fixes: ddf49d57b841 ("cxl/trace: Add TRACE support for CXL media-error records")
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/cxl/core/trace.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > > index bdf117a33744..bc5ca4d530d1 100644
> > > --- a/drivers/cxl/core/trace.h
> > > +++ b/drivers/cxl/core/trace.h
> > > @@ -657,7 +657,7 @@ TRACE_EVENT(cxl_poison,
> > >  		__string(host, dev_name(cxlmd->dev.parent))
> > >  		__field(u64, serial)
> > >  		__field(u8, trace_type)
> > > -		__string(region, region)
> > > +		__string(region, NULL)
> > 
> > Couldn't this be "" instead of NULL then remove the __assign_str() if
> > region is NULL?
> > 
> > Ira
> 
> Thanks for the review Ira.
> 
> That doesn't work because it inits with too short of a length and the
> region names all get truncated.

Ah ok.  With that added detail.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Adding Steve to this thread. He has upcoming changes to this space, but
> I also should note that I think this fix may want to be applied
> backwards, ie to stable, so we cannot count on Steves upcoming changes.
> 
