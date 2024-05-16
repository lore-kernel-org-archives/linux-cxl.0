Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CE61581EE;
	Thu, 16 May 2024 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715895188; cv=fail; b=tJrMdaexiKtLqmMsx16GWO/XvrnVtrzwAVxe2Q3gato3m1g/bCGgA0N/qkDzI9O58ZCQ0X61X6WJB1gJGYPlDTxettrr1Tfdl/ygEA8TSIdcM8k4S+8F9F1MKrnqqbv/nCinw3qekfyHFYgmeL4WgKFmF+hNR39AbCecqePy/aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715895188; c=relaxed/simple;
	bh=zvLW4325qIQaNOY71g2i9lmuYbZy2iekTp/wLjJrvkE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bt9yU1iQDBCjVLDrDRkfm1DdyjDKfzswRshE2wJq3nz2tlxfGcCVol+6QLoqKhWngR5kL53B0v+yRPKLZGx0c3mLQnqHywiSTiUuP//ljycEUQoWcBYFfdue7ptL3YkSlEZvGlu2n+jBVrd+bt/gXQ1XJP0CF3lDbTMdzJGihcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AF5MxXyP; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AF5MxXyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715895187; x=1747431187;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zvLW4325qIQaNOY71g2i9lmuYbZy2iekTp/wLjJrvkE=;
  b=AF5MxXyPg5uCT4h3snUoAHZY1iaovncmr4rsQAo5wVtdCpng4u2016Eq
   aMcsovc68hdYRmIJ2CGmaSSzaoPAphgeC9kKRA+7rX8Tx/HOnx6NS83SU
   rto0mRgwXvdHKZhSzNDIpn0HPT1q42zQmkd7p4OKHH5om4UW6mbZCxQLg
   fqADD4i/alPTsCwbr7s3A+tTJ88xiNms6w87tAAMwrZsySLEiSOLl09wt
   AtPfB5UOVHoG55v0fVfs0iytB6ONkDebjmrFPQaR95IK/9ewtwIRGsPQf
   7dthBHbDE2SchzvNvzEcTgWuqAWLtXvjyM8FCml/Fw0dAV4PBFMimV+p+
   w==;
X-CSE-ConnectionGUID: nhDJFWvmQSKX/B+ikS6U1Q==
X-CSE-MsgGUID: gPHKM7EOR0iQq2AaVDscTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11915159"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="11915159"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 14:33:06 -0700
X-CSE-ConnectionGUID: lZMz0JEPQMSn4Kq8a29+KQ==
X-CSE-MsgGUID: s+Ksx7w/SEK/Icd+eyBfdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="31501199"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 14:33:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 14:33:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 14:33:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 14:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbkzMbCD3XVE16kLKqiPuYn7Id3LIUVusRBHZqt3fh0O5mlsdC5wfk7Y/8fyH4Ku1bve13mSSOKbHcX+Rr+x9L0UB1tKP+kPCbLRNn3qZVDZI0+FlFjEkXykS9oRTRV8l/o1Kht/ei6cVRDJEZSd6JurRP1VnHJqwyWd6TpFB/KxFJKuMzBervB4EFZs/7vJ6oSLcC+rmtXCi7cNMyRoGHXshAFtDXuXFOI4FE7dReENpACV9cbQtZ5GXMqUIBZZdTJd9mMo65Wwy8L1i8X7woZO1Qyb7CZRom+U9FlE1LxyFHoTQ01E8Mlv5cQJgGVOiW508QoTnYqV6D2Z42u8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRDpf8zuGw84/I4wE99DEsI6IOTZTWaQ4OAJMrlqfLA=;
 b=lwbpXDLbw0Tjj83u73LlF9pUFtq5DveBgI9XYZHRmacXXmnYUO1s6g0N4QQ5L0uXKSOELtcx/ufC6ix5XDoxxH9w64rsnpR3pygK6VFSYPJfcLjoCt01eAbXlBNdRhXOqXpNSlXhTIk/EFgvXo2pMD+rROHzyZMNDqwnOKvupM1R7kzda4W0Gx0fp6O91zGgciV5h9srS289iEXUv9mtpa7bbTfk8kKAunh+oJbsJLVKqmwFJnn3RFacOwhkV2YQcUWTHAjDeTHlNvtCp97CL3sgxa1DxPItEpCS6VnNgJjVBZgCIf/bqM4qsOzFqxfTswFY/FlMwu+vk3BiMQn+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6557.namprd11.prod.outlook.com (2603:10b6:806:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 21:33:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 21:33:02 +0000
Date: Thu, 16 May 2024 16:32:59 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <66467b8b47170_8c79294b3@iweiny-mobl.notmuch>
References: <20240515190512.3480817-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240515190512.3480817-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fd3207-2ad8-4e6e-a02b-08dc75efc3a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+qDB7b0KtwTXsWuA6UyDTZUDqzaa0LBPy7+6XDj6Xa7XavKzGXmFurjxItmP?=
 =?us-ascii?Q?mebYILp6KnCYKkV005mxk4fxfT2fOSbPzeA71k663EmSGHdeE6NggxbJcCbW?=
 =?us-ascii?Q?fMnhPjK91i58y4qu1BUTb6ALkcJxvin0gohHjQg83JNP4e5T7ZBi+PyVto0w?=
 =?us-ascii?Q?rYHmu4B6+riEcINkuJtA7kza+SCEJulIDUnnkzJN+Ez7t7WEBeTslT6LMK/i?=
 =?us-ascii?Q?UE17+v/4GQe46p8bhomPbDoNpKhpmRktu+A5R4+pBx/O8zu4Htmoa/m6RyxS?=
 =?us-ascii?Q?lqTEboTCNy4bR0s9dJ+x1+I0S6kbichdsXIT3l2vPGfgjwpIh8hhLNDKNaH5?=
 =?us-ascii?Q?vf2e76yhU1lvIEUb/PhvcZG+EWCXmW7/uhN0W7jy0Emgk3eXoYZYIXTCx2bJ?=
 =?us-ascii?Q?05NBoK8F+NZEum5vhqF5gwLgc88D3KVlBQ+ARR0GyjUkpSTGqPgjDn67siHc?=
 =?us-ascii?Q?elgkuh0v4RIiCYQHrlFek4KtutNAgiMyZqGbPhmsm/3u2REqUCTv/6OyHOcf?=
 =?us-ascii?Q?8rMwUGb08YC3lAIWVlVyqeuHfI4vjO+au6Df03nztOU75kuohStraoCg0j6r?=
 =?us-ascii?Q?fzhkiqxi6ouiKb+C3SLXh4XQnR3KkOt2WnwU79GR/WSZzYhafLCX4fuH8Jfz?=
 =?us-ascii?Q?936WoQ6HVE3qtxYhkn6aGbf4QZ2ruT199HqGdk7MzOrFKduN5AU/qLJnslZ0?=
 =?us-ascii?Q?ku9jTxFK4p1iXw9D9TeMxvD/fZn64ZW554f+yebRvdGL2wz43DP0RKwrcPRb?=
 =?us-ascii?Q?VvgGqj6fH1mA60vbFi92xuuVN+8E0qoKQwWbOmxiIumRy5LzTiPO0sTQmq19?=
 =?us-ascii?Q?xUiWvMMify2YH6Zzjdr4Xblaiddm+LGdUBEIqqE2iC8CDhrj3GQ4OsggCUWz?=
 =?us-ascii?Q?LZgUEpvvzhtjLAbUIp+i2JTK9rvVN/+XAXHg3iTw4ZxlNzXvDkc9Eb60BOE8?=
 =?us-ascii?Q?UqsSiw0jRTcXeC4YPpJK7oYDopLYFOtE77qqzyg9IwEQwLdxldkVXl29o8Wb?=
 =?us-ascii?Q?kGgihxahStV3b9xngfrNM5tmHETn4cwd3/EA+9SqA/DybWEsEIAR/zwAiafg?=
 =?us-ascii?Q?Zj34Sqoq1H0Vh8TG+CU7fcTH5K/zCoaP3uRfnXCcKHm9ISYwIx77ne1LPDEM?=
 =?us-ascii?Q?93ja96x8L2jAcGzQbre/MVBl4Py/E+i/386QoiZOKnzihhqKUUF6XPLnnPL/?=
 =?us-ascii?Q?3cyTsWesW14cBfFhxhQXFu6H6CRPjdc3r7M1Po+oBKSIClic0zA4+c3S9jsS?=
 =?us-ascii?Q?GhLtH2/MlOlqxUaCBWLkXk4VBygRlAHpdh91mJPJ+AFmTTqyUX/wRvoBgE/p?=
 =?us-ascii?Q?T8Jba4dVDKJK8dOcW2MsAOH4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1h2pYJucsic2qfOGUtfwqQDoDEKzzx6NCsXDA65go3IvQyKGqHiUkAhFe9KK?=
 =?us-ascii?Q?BB3a+w+Plwdb6HZB2CVbQfE9a5uwhkfci1cmjnPtByV4wbEm7id6B9n/pWyo?=
 =?us-ascii?Q?qA71yCNXa7tkp59PKS3q/cmzC9mkp0LFzcgPqn4XIdKvbMSdfCuL6eh0L+2P?=
 =?us-ascii?Q?fCjPrYi5iJGGGUMJgB010NfLAG2Ic11YaPmaaehbv0Lr5Z1bwp3CQ9osZJLp?=
 =?us-ascii?Q?29ORxlcY6eFD2P7lHkxOo/0xCXTywuHPde2Gb/vUQgWZ8uDNlchAathBvgwx?=
 =?us-ascii?Q?j5H56SFRmef18IzTuq/4EeFT/+GSRkOTtceLHqIyFf/YcPsBHvuAZ+GsmwgF?=
 =?us-ascii?Q?PgSlzFZiek82t65mZcn4VbC48Uwe88uconYe9kwkwEqwP3dbubYA59XOy5QQ?=
 =?us-ascii?Q?eBGhrhPifLrz+jHLsnG9pivG8SWHfjZwLOF5HiOr97iMlwZ6wUSLQcUm67gA?=
 =?us-ascii?Q?+IQ/r8Gy3yAfy8Ntz2qN4IfCd4XkWoYVqMbsdXFhjxMmUvqtlV5IaHkjnrtz?=
 =?us-ascii?Q?E56EaIrcE7C2c83mq5RWINv9oZWaZrcrc5+RvkPf7qa5zlhGua4Y9LzIEVtA?=
 =?us-ascii?Q?AZR6SoJmXcdbC6ntQWpuMhMS6eJo1VhGEGombfU4Iw+eDu/kRUta6kafWlgu?=
 =?us-ascii?Q?6BdoGheIAB+WzJxV/u2hmOzdO+T5+rGw+or2hnrR03C1jvfQWjfI/AZnxJfc?=
 =?us-ascii?Q?cKRJGgMtHvrj9Fz7vkwp+j38NswObNAXXd5YO1Ab8uEBykzuoQrCOJtbjFRK?=
 =?us-ascii?Q?Q7O783Y3lJqtQ0KzA11unUYZAVqb7k7pP243x9MUOcp90WbUbsSLsm0Sin2z?=
 =?us-ascii?Q?ruO9x82AHGQVI7mrGhKl7Wu0bHxo+s/qDzBZ3+TrpS/3jBsCltRpwP+66Cms?=
 =?us-ascii?Q?8G4Savh2azzm5Tavo9FMhWRNx7bWjgEr9aPAY8NxR75NTTkonviDTvEKW0/p?=
 =?us-ascii?Q?UOweDRxTcyyYQ3uiejj05WOWK5WXkPz4ffm7fHbiOUmFes57fIrPqKDkb3+P?=
 =?us-ascii?Q?GfrFbJbnSBlBP4oCgUnSkk+M0mkaf/sIzNvel0MCZkhR3trz5uovrEYkTWG8?=
 =?us-ascii?Q?KOHvfg2MJWzwV9fNyD6E6C7UqHdyp6hQMHciXnNBoqlGxWp9/15xI5/WlriS?=
 =?us-ascii?Q?4/Gprfq81PQx59hKmF9C9DQWZco4Dgh8K5tgvs4xT5Cw0JwN/uSF5N5AU5Y7?=
 =?us-ascii?Q?WALfLfbFmG2zZVgspXMdLdpASpc6wI+s4gBZV4AogYezYAuDoPF/Gxdx+vfr?=
 =?us-ascii?Q?rufl7vFM9okkOmY3XtdgZxybRsQ9G8u1NSJ/Af2RbBW8SiWCgKtsmps9G3zr?=
 =?us-ascii?Q?lWmKHP4+ssgGv1YIK67pZNjGq83tKW7+Dc5+3N68B9tdJu8hl93EJKC0e00U?=
 =?us-ascii?Q?wx5geNLYSFWfduKF3bqSn0qbZjc/9TQ5eRBKderdlrmYtWM9zHRRc9ue2t3w?=
 =?us-ascii?Q?k/lZQ0EMzuwK4Dm7I6RJSpmdQd630HzOnt0cqbtjtwQ8k5I5LI+NW+lkHeZY?=
 =?us-ascii?Q?f2QtbhhAvyvup9BRQG82VsQEFxBAYBO16AHAv86Ji0Vdb10CJMiGClHavTLw?=
 =?us-ascii?Q?hr6OyQUA9W614oxirckPu3ZaDSoqc9kZXoBrwFg+REqvgl4OYUEcLkOioPhQ?=
 =?us-ascii?Q?rNl1c4RUJ2eD1qtwVssIfgw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fd3207-2ad8-4e6e-a02b-08dc75efc3a9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 21:33:02.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMkSP+NHBvkFwItQELuoxxycAILo4KmG6zzCNBXtHL+hYDu+oIJoRnE1CIIWeNQL2CdDl057dKi94bDDP5tigQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6557
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Use cxl_event_media as a common structure to record information about DRAM
> and General Media events because it simplifies handling the two events.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/mbox.c      |  6 ++--
>  drivers/cxl/core/trace.h     |  4 +--
>  include/linux/cxl-event.h    | 70 +++++++++++++++---------------------
>  tools/testing/cxl/test/mem.c |  4 +--
>  4 files changed, 36 insertions(+), 48 deletions(-)

Other than saving 12 lines of code what are we saving with this change?

The addition of media_common implies an additional event type which is not
in the specification.  (perhaps confusing future contributors?)  And the
code is more complex to follow.  The decode of the phys_addr field is not
simplified (which IIRC was the point of this idea.)

I'm probably being dense but I just don't see the need for the
struct_group complexity here.

Ira

> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..ad4d7b0f7f4d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -875,16 +875,16 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		guard(rwsem_read)(&cxl_region_rwsem);
>  		guard(rwsem_read)(&cxl_dpa_rwsem);
>  
> -		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
> +		dpa = le64_to_cpu(evt->media_common.phys_addr) & CXL_DPA_MASK;
>  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  		if (cxlr)
>  			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>  
>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> -						&evt->gen_media);
> +						&evt->media_general);
>  		else if (event_type == CXL_CPER_EVENT_DRAM)
> -			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
> +			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->media_dram);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 07a0394b1d99..2c7293761bb2 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -316,7 +316,7 @@ TRACE_EVENT(cxl_generic_event,
>  TRACE_EVENT(cxl_general_media,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_gen_media *rec),
> +		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_media *rec),
>  
>  	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
>  
> @@ -413,7 +413,7 @@ TRACE_EVENT(cxl_general_media,
>  TRACE_EVENT(cxl_dram,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
> +		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_media *rec),
>  
>  	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
>  
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 60b25020281f..e417556cc120 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -32,41 +32,38 @@ struct cxl_event_generic {
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
> -struct cxl_event_gen_media {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> -	u8 device[3];
> -	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> -	u8 reserved[46];
> -} __packed;
> -
>  /*
>   * DRAM Event Record - DER
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
>   */
>  #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
> -struct cxl_event_dram {
> +struct cxl_event_media {
>  	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> -	u8 nibble_mask[3];
> -	u8 bank_group;
> -	u8 bank;
> -	u8 row[3];
> -	u8 column[2];
> -	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> -	u8 reserved[0x17];
> +	struct_group_tagged(cxl_event_media_hdr, media_hdr,
> +		__le64 phys_addr;
> +		u8 descriptor;
> +		u8 type;
> +		u8 transaction_type;
> +		u8 validity_flags[2];
> +		u8 channel;
> +		u8 rank;
> +	);
> +	union {
> +		struct_group(general,
> +			u8 device[3];
> +			u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +			u8 gen_reserved[46];
> +		);
> +		struct_group(dram,
> +			u8 nibble_mask[3];
> +			u8 bank_group;
> +			u8 bank;
> +			u8 row[3];
> +			u8 column[2];
> +			u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> +			u8 dram_reserved[0x17];
> +		);
> +	};
>  } __packed;
>  
>  /*
> @@ -95,21 +92,12 @@ struct cxl_event_mem_module {
>  	u8 reserved[0x3d];
>  } __packed;
>  
> -/*
> - * General Media or DRAM Event Common Fields
> - * - provides common access to phys_addr
> - */
> -struct cxl_event_common {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -} __packed;
> -
>  union cxl_event {
>  	struct cxl_event_generic generic;
> -	struct cxl_event_gen_media gen_media;
> -	struct cxl_event_dram dram;
> +	struct cxl_event_media media_general;
> +	struct cxl_event_media media_dram;
>  	struct cxl_event_mem_module mem_module;
> -	struct cxl_event_common common;
> +	struct cxl_event_media media_common;
>  } __packed;
>  
>  /*
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 6584443144de..0a8fd145c391 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -378,7 +378,7 @@ struct cxl_event_record_raw hardware_replace = {
>  
>  struct cxl_test_gen_media {
>  	uuid_t id;
> -	struct cxl_event_gen_media rec;
> +	struct cxl_event_media rec;
>  } __packed;
>  
>  struct cxl_test_gen_media gen_media = {
> @@ -402,7 +402,7 @@ struct cxl_test_gen_media gen_media = {
>  
>  struct cxl_test_dram {
>  	uuid_t id;
> -	struct cxl_event_dram rec;
> +	struct cxl_event_media rec;
>  } __packed;
>  
>  struct cxl_test_dram dram = {
> -- 
> 2.45.0
> 


