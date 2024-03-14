Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20166FE28
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449402; cv=fail; b=Qq0u5vWEapT7SMHWgdaguTOkE3mZ4BOmzlgeqvDO+h0jS76H/7Rmyt277cBHcVzdO3KY9e8BbXcBKthqcl8saw2CaVdkTLLll1srFR42jFe6Vnff5gBP4b7x1rtU5vFDcKYf7Rtx+UTd1+NB6yMDuBb42qPO67DBise7ff8RjQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449402; c=relaxed/simple;
	bh=vI5YyYdwmMDwzLpnrU5nU4NOKoOdQvVSQXTzr2dQKzw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VsiEyFUZkIQFpJPHdhQ/4K/6K3N0oM6AgfnmfkPDGZluiKJgkEGZONbciN/TN1xdUQ+wYTW6HWgWrDezO5N7sAin11xU4g/K3r8Fl7T14UYg2mml6Q9bhUg45NQdri2W+hx8ww3YqSz9Od0vKBXHZ8mmCluOv2mqU8XypHFZtrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGRpByka; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGRpByka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710449400; x=1741985400;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vI5YyYdwmMDwzLpnrU5nU4NOKoOdQvVSQXTzr2dQKzw=;
  b=QGRpBykaFzdfq533q9ecSHDEow1DsE/1VK8GtHgsbfr6i1BSgQb5ifQX
   mhf5ieB1zErBsDxHNKO8n34YZQDzL3N/BseZVwCMZO/qQcEO3lVuYrqI3
   xyqeu0ivuaSNsHGgncFvxeQECuDCc+6/DNntbfUtYO3YVZMTcT2MA6rLx
   exjmIJfbH+FJSKZDxVn/0dYhWjww++986ge6DiSzqEcuS1Wgptu/UxyOo
   OV6Hknz0Yn8wF8pmk6wse2Lao8NPp1NqKzVfgoN1WON2wX+GitrD7dk0o
   z7OrS22BHAMU63QMXdmqCFptnrPOBecoSL7EXPayyMPskgf9dUek6CxL8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5498150"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="5498150"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 13:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="35556384"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 13:49:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 13:49:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 13:49:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 13:49:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 13:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnkHk2eklG7Ea/sMNYePPWNj0OxIeC2pjZeGsFquCTAD+V05mAR1waanrKJEOmC3e/2sPjaw5NidyjqqpRat70A0nIfRkVwMjtLq16R3I7sIDT3NMizyyg0rCQNzRzFtcUtLmogyHr+WOOZjKiFKQ5dZw0zKbq3GTR1VfxzXJIRPjTXZE9mgIzbuopNXbQT/ag7dPNujPcF+txHISHIjnW5dowPKX0TU2IH9wXjeF4emIpkloQ/HjQ5phk1ZR4b0S/U3vk+Yn5dkNzphKiDX2BTl4j3w3L7nSCq7NgIP/xE3wwotTmAHE7p4BgfBMjF7lICpWBbwYMRRKI45JfIaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TGTT+SSr3MeTsR/hqz2JIe4CCmR2cwgxsfcjEhuF0E=;
 b=HJSPgD9LzHLbIPcJ+q9IU+hLerSUhNo72YyhVjXLhzgTppDXmOZU+fCAK7FmYDaEP54fSAdZJCIo5WiNbalC9jTNtTGdE350PnIAPSKlabeRZuLKR0pzf0GMKl71cjFSHQmR6EfyG4c+v5+C9xMf2pGHjx0ebEmm/aOW23v1EGVJ70MNC8tLUT6umKr4Wu7xQ5rj2fWq1J70eQvgZ3vGREbD4aEQWoF5ywaR2CsF2O60tQK6JHjmHLr8iwtp1g3ipYmnZ53prz2/DsO5fzmNtGcNm7f1ho0UAsCidmJ+lHweJmYY5C4mIvO3U4Bi8xlSeMnpOJgH5zJQWQG8Ym5/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5149.namprd11.prod.outlook.com (2603:10b6:a03:2d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.14; Thu, 14 Mar
 2024 20:49:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 20:49:55 +0000
Date: Thu, 14 Mar 2024 13:49:51 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, Alison Schofield
	<alison.schofield@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/trace: Initialize cxl_poison region name to NULL
Message-ID: <65f362eef27ee_221412947f@iweiny-mobl.notmuch>
References: <20240314044301.2108650-1-alison.schofield@intel.com>
 <65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>
 <ZfMuDlDbVHtlAL8z@aschofie-mobl2>
 <20240314144405.2ae1d16a@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240314144405.2ae1d16a@gandalf.local.home>
X-ClientProxiedBy: BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 356c7fd0-2724-475e-2d17-08dc44684d9a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVqiYZCwamGGh7hZmFpxEVW2uGx/3eiUCuqR8bIu0/vEcGo3x9z6c57aIMcsBowBDvIChToRGMpheOKwTrLaEsqTReOEqqTnCJKpp8PGshUMMCEjSwB6nRCelFbDKkXpOyRkfENKkq/dEwJqeYau0rZEjD6vGh19/AD0huOFfhppr7pjDzsdTtWA/rexB8IO9mo52n0gJXIGZYBQTqHv5TGkw+462dnjDEvJrHE4L3tARTao0UTFenT2pnKVccILHrAnAfeDxXfHsAnHZwc8X5PUtOviGU3uFOIXUP9iDiNcOSMs1j6jqPt8bX9tmb7yi6choI5wZQ8nrTJWfP1QUFx9z5zoQUu+6rbtyjNFKhT2AhT2T6SCzi499LJKfZsXHKHQuqI5F1TCrnJJncj30g4QoxJGqjrIgQaMtvjqsl7EJqCFwf0L+caCwZQqBGSXmMMpgebkOzFLpHJNbRz3TxhKIn9atBBNWQgF5kNq+wrR+/zBo/9CLjauvVHL2va2cUZ0zIi2JYlb8jfS+TetxuCIm1yjzQU3ykVmFxcwDO8IAi4dV8oeKaW2YoD3QESlJKaq2Ck6ZzTn3LD8i1EPlo35AH+loScAaixtBLJ29mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X2C8qO7jiYVhbqJPccJS/y2iarEydbSlBuEj4kvxafVtwW6wIn7yyh//zT+p?=
 =?us-ascii?Q?YbTXeh/aSDr/NVH+5BPlXF5+3eMfyIuuF1i1rcBhbJFB5vfrLb2AyVGfhjNa?=
 =?us-ascii?Q?2G3o5fUqB3t66EQk4iTe6bejovxBB4WFK9KKaNSM/NBfubfQ/m/lm+o8YGLo?=
 =?us-ascii?Q?4ZxiUSJTne45I44uUw1YUrZcdW9xDZX9shpMyFU/aFPV/JLmCVTLAeTNC6Tu?=
 =?us-ascii?Q?cjY1wNWtf8t+3jtGUEpravhK4HC/Wyvre43YzMrW+6xqgDZQHJQDqwlz5H4G?=
 =?us-ascii?Q?AttimYFtXCR/XP5hc/2TnA+aq3mSoFBY9ZWhztamLfTDGmENCCQMU1yOYOI3?=
 =?us-ascii?Q?zHXmXO2Q49ZEtQPDwk2q/k83BxoQ5iQegexARdQi5pZL0AYsuzN4NMmUuUxr?=
 =?us-ascii?Q?n+2NkAJPwtgIgiM7NUNJMkxA+sgyv+9FILAJIzAQ+AG6pCDVVi+QnV5u7s76?=
 =?us-ascii?Q?0YxK1VI9SVFsZOXXnmpWko+gWNriC50enWp7xTgd3AOOroLB83yHEh/wk2MY?=
 =?us-ascii?Q?iD94wuUhETVkx2JUefsBfZcJleyjjMudN4/n9nMRcf66dlZz8uouLjBSm/Bj?=
 =?us-ascii?Q?uWacLccuagtwX/kUms5bNobgh/Ckp3HLkWOE9N6meez6QkWg/SUrOzPE//58?=
 =?us-ascii?Q?0Js2Xi4m9M51TO2r93F4AwiFnbD10sJXWvqziazJdZ/dQDqBy5Wihi9f7dF4?=
 =?us-ascii?Q?21TpVaXIgDl6j9E25RQpJAoBdpca1pbhqgX6THPgFecefqLp+vwaSCirrRJB?=
 =?us-ascii?Q?cKjrGQ9nUal/yYVRDsf2YVEdTKxvGBOJxIl8WmOmNoH7rx6JlqLvBAxMGcwW?=
 =?us-ascii?Q?SWIwZMXf77kH/TfEWrbeJpq96IzYz9o/cxC87Rv/7LuCrxwWD1JAs7QfE1Im?=
 =?us-ascii?Q?X6Xs8A+09qRfOkgXf8UI7uuUxt/cycdDS6RxVtHV+nZi4x3zMOb19aKLxhds?=
 =?us-ascii?Q?XROJKlOPLgGP76VU8+y8OXEXWJE7miVY+NGQQfQKOPxx3ny9lUn/SD7PzEdq?=
 =?us-ascii?Q?Zzl/QdS8yvuqiLufvtTFvBr5pVB1KqVL1dKleQNF7LGgD93Azm3MvsGXrtbA?=
 =?us-ascii?Q?XP/AuE8Vm1YtgY/RLmhfFZADplIi75/IwnkU89P0nQ7cIFkti1ORqdq+5ayc?=
 =?us-ascii?Q?EmHfFeCxZ2sJ10WiLUdihNuIJN8qPRx0wqsjdJDfPkpSGij3BqLTYIuy8Si0?=
 =?us-ascii?Q?CbWxsDlr0ZzsfRKotTfLkrRctqEvwV093iNTjXMz8SBY28RILU7oAFpsWx+L?=
 =?us-ascii?Q?DY9qTpl7rnW04xqb40RxLMuSlBhWpH4Iv/dzoGS5gSXp2zUlqqSb5uhBfbAg?=
 =?us-ascii?Q?+tOIPnf7yRPO9lAovCIVNjVC2HMx/EchvtbL77Qyh13+eMK8B7DDzzNJo/Dw?=
 =?us-ascii?Q?kSc1L2wIIfAKB4+pTn64ed9XZ5sma0YUGpmI9jF5hUziIkTiFqDZt7pT4FY8?=
 =?us-ascii?Q?r29WVk0kDTy2g85lfu4Z9zfdLWCVppFhp9AXHZDhBeh6UlhFDAS1CyKXNFhw?=
 =?us-ascii?Q?ZnCxYHWSiwoAPt7yT3WLi9jrc7V8pQfA9LSjcPC2FZWLHOPRJNmF+/YYFuuk?=
 =?us-ascii?Q?hxXsvNZGPrN8PH/v3wPbFY2I2K860qQU+6bArT5xQB+cMw9m/d9zFwUnFgDX?=
 =?us-ascii?Q?dinEcX3AFoTkIEmZ9jOUFTgo47DWQyCPQxsL6liBFvB3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 356c7fd0-2724-475e-2d17-08dc44684d9a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 20:49:55.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHY0fMIs5wXUm0ttu2Gn1YveauerFyCn6j4qjk1UR6auMwG1sj3QFjcfN+Hodn0hg0d1HLM97OqQ+DmB4OCfug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5149
X-OriginatorOrg: intel.com

Steven Rostedt wrote:
> On Thu, 14 Mar 2024 10:04:14 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > On Thu, Mar 14, 2024 at 06:53:47AM -0700, Ira Weiny wrote:
> > > alison.schofield@ wrote:  
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > > 
> > > > The TP_STRUCT__entry that gets assigned the region name, or an
> > > > empty string if no region is present, is erroneously initialized
> > > > to the cxl_region pointer. It needs to be initialized to NULL
> > > > otherwise its length is wrong and garbage chars can appear in
> > > > the kernel trace output: /sys/kernel/tracing/trace
> > > > 
> > > > Impact is that tooling depending on that trace data can miss
> > > > picking up a valid event when searching by region name. The
> > > > TP_printk() output, if enabled, does emit the correct region
> > > > names in the dmesg log.
> > > > 
> > > > This was found during testing of the cxl-list option to report
> > > > media-errors for a region.
> > > > 
> > > > Fixes: ddf49d57b841 ("cxl/trace: Add TRACE support for CXL media-error records")
> > > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > > ---
> > > >  drivers/cxl/core/trace.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > > > index bdf117a33744..bc5ca4d530d1 100644
> > > > --- a/drivers/cxl/core/trace.h
> > > > +++ b/drivers/cxl/core/trace.h
> > > > @@ -657,7 +657,7 @@ TRACE_EVENT(cxl_poison,
> > > >  		__string(host, dev_name(cxlmd->dev.parent))
> > > >  		__field(u64, serial)
> > > >  		__field(u8, trace_type)
> > > > -		__string(region, region)
> > > > +		__string(region, NULL)  
> > > 
> > > Couldn't this be "" instead of NULL then remove the __assign_str() if
> > > region is NULL?
> 
> That will not work either.
> 
> 	__string() allocates the space on the ring buffer.

Ah!  Thanks, good to know.

> 
> Getting rid of __assign_str() still leaves the buffer allocated with garbage.
> 
> As I said in the other email thread [1], __string() and __assign_str() are
> tightly coupled and are the equivalent of:
> 
>   #define __string(buf, str)		len = strlen(str); buf = malloc(len)
>   #define __assign_str(buf, str)	strcpy(buf, str)
> 
> I also mentioned that __string() does much more. It can handle NULL
> pointers, so it's more like:
> 
>   #define __string(buf, str)     len = str ? strlen(str) : strlen("null"); buf = malloc(len)
>   #define __assign_str(buf, str)  if (str) strcpy(buf, str); else strcpy(buf, "null")
> 
> So if the string is NULL, then you want to copy it. That said, looking at
> this trace-event, it's still broken, because region isn't a string, so you
> are basically doing:
> 
> 	len = strlen(region);
> 
> Which doesn't make sense. What you want is:
> 
> 	__string(region, region ? dev_name(&region->dev) : NULL)

Yea this looks much cleaner.

Thanks!
Ira

> 
> and then you can add the __assign_str(region, NULL) to the else path.
> 
> -- Steve
> 
> 
> [1] https://lore.kernel.org/all/20240314143406.6289a060@gandalf.local.home/
> 


