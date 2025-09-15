Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F92E3397;
	Mon, 15 Sep 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922958; cv=fail; b=ZCec38qsIml8X16HnD/zckhNBnJFx3moTGJC+ClUwA+cHg+RvX0g/AZFqUZgtKeLhL1bXytGkKwElSZvFqG/Emjo+8D6qDkA4aKKqv3vUBy0y4StWZXp9hJ1FEZjkVDPY9L4h/xWqEYDjfBUYgYpEMEeJFC/1vsbX+167J7N/to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922958; c=relaxed/simple;
	bh=fnwj7ZOBgA760MDoum+oO2baCz+8m6Vf0yvtkoVolQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F8BaGivDzakJ5L/LocvbSZcvdQuSjKGBJbQ9giioiJW6/cC72t2wS4R6E5GdsgoPA1CWz3vFIkUgq3CfG8N8qJUqlVrsjcRpFEfEYtPASpaZY7kbOlZMnl4zDXldqHYHXbjYoSaTBSvNyCy9nJL2Y104HDSmTN6f4kobsDwvIJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bk3bo8Lk; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bk3bo8Lk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOX87uWVlyw6nxd71ePsrmVGgwb5IZu0NvHL0V/bHFzlGg/INgqQ/oUP1M95nNqk91s4W3YJNW11O0vHEcGoH1QPK6Xcv1MQd7/O4nSzPyo5/xhCtLlVMChiUNA/gI3YrIw3v2s3yhaEzIkhAj9KWBZAVCXUkYr0aDR3wpaP6v0LC17gYRXEhj2eXwDRnV6eSPmjNsunbhXpDzi7AywtknB9j9f1yvKJAsSEts7HQ25SXfFrxVY1YoqbLBFtuCekH11fkQjP3fXmEhxW+ZwcJD2llBeTvQ7DwYDLQbv8zgRsdmbhef6t/knttfVw7YAyam763mHgVFc7wYa6r8gftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6xaqiM5pkzqwqh9UCSOk0mnYrkl6cK6WReD33q/utQ=;
 b=DLoAikGTXVP8Qs+/Fst69L/NPpbzAxWvuCiys4BIswruLV48IseGJ0tDXTooeVHB7hBBg+m78/dTAErigH1GsSAGNA6c8p4ZwE/SKI5jNrALHqeVAvDv98ZGmWVzLnCmC3fYv7lKMI0bR1C0CUOjk9DW/G6Btr0X02DyZXxZ9kVzOoRYdJPI/WzZVsS+Z0NgteBMATodqTfTRaCbmWxRwRTHDi1l95RoSYB2zsiXH7nHwu6LSEXQXJSg0BD7dB1lyczQrOgaSQ/iCfB3hnVrzxq3jAbz/4CEuUaLvTyumDO99kdBSnzB6Mka26+CfZEwk3foT4iI2SWGyPLhVcsw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6xaqiM5pkzqwqh9UCSOk0mnYrkl6cK6WReD33q/utQ=;
 b=bk3bo8Lkc7q5RRCEHOfW+n74TfRp4KWgL/ZDadE0a93ZBC6h/RmXcIlS1IYFtgHaX5DI5IP2j1TH20gQWVutt8bI/va/T4Yi9bzne9ixW2bylGTbNfAhEKC8NdBTMPZ3jW5B8f6QMoHe3gh9fEHqkUtCBUyWXfPF4UrnwwaDyC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 07:55:50 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 07:55:50 +0000
Date: Mon, 15 Sep 2025 09:55:44 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 07/11] cxl: Introduce callback to translate a
 decoder's HPA to the next parent port
Message-ID: <aMfGgKqVp1Ue0eQa@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-8-rrichter@amd.com>
 <7c132aed-e10e-499f-9442-aa8df110390d@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c132aed-e10e-499f-9442-aa8df110390d@intel.com>
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 845d3d2a-df69-4536-5005-08ddf42d4960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oxnwp7Tudyn1f2b+f9GL5n8P0BxZSjwXZyO8kaRl1w5C0HptTByCIUO6XcLw?=
 =?us-ascii?Q?XPsfey/M/FZsXsFRbbuxQzdlri+ESIiSM8abBWya+sVnS4fqq66o5uYplByq?=
 =?us-ascii?Q?0eG7M48SFWaosxAR37rotrJFeDGT4kzPqQxiXihoaMpLokDoVRzzsxHxooUh?=
 =?us-ascii?Q?zrnmS/ODErvodQqeIDeS/3dvVKcMVF9CO9RjkBhZhzqh0Rj5OB0p8HAGqM2z?=
 =?us-ascii?Q?b1gYMKhghUzOHwGAWhWxs8oB/YcUe0WEFPgFV49oLtpOnqR7ItP9HRi2zfJH?=
 =?us-ascii?Q?H2gp2tuhJwmjFX4sOsRTpft/2+q9VQp/tgzK61fyR+uaM5KG1Ai7v81B7VVw?=
 =?us-ascii?Q?DPCvb7jKUV/nqtNX52Jj8zFpO8hGTzF2GaWLLb0pbPfAbJYs1NsIxm9iPm6z?=
 =?us-ascii?Q?9m2A2ke8p/qJZ8GIvRNPAro+lEav2Pvc+GZXgzEqKFJ2N+qfODZFxLbRmuH2?=
 =?us-ascii?Q?77fehVJkPZSam+NZ+L/c6d7eYMdt06aQeBzHTeve5NJKEowUQIhrK5SAcaep?=
 =?us-ascii?Q?RR9XIRthYsI7JapJJ3Z1NQQFZ6VZPQg4y/fTNOHzghr0JsYZ+SEzGPZSaX5Z?=
 =?us-ascii?Q?Bh/BkocIZpfaHflJa/NgOG5iMkzyzfLuWVxWwbpamWD6nZAX6J0Q88Qb/s0e?=
 =?us-ascii?Q?3YYon6xYMqqHV+P9wx9+lOody/i64odkpJZOxc8TYWHgWobk4E29lJr+v+k4?=
 =?us-ascii?Q?WTm1By37ecQOKa1waRmxZMYjp0ISq3423UXh3v+qPRe6lP4OMfD6Y9nE4suN?=
 =?us-ascii?Q?NUCphbBHPWUMsLV4zr+MXO6GqviHDbf88Ljl/YJ4sDRWUZ4nNs25eHzrKf70?=
 =?us-ascii?Q?5C96jVDTQ6K0GSPcW6j25J87MDoQQ7732r9ylREuHQjIOHpCI0BCzBpzkt0D?=
 =?us-ascii?Q?tRQ5Djh6pXjUvnxuvyNmh82hu7mlXJcm2W971HzWnEDYHOv4DoE7yNFCfs+E?=
 =?us-ascii?Q?DU2JOU3hbuj0qwAnZ/YN3xXMkng71a8J4PFxDcrrzPcLS/oX85X5X++PCpy0?=
 =?us-ascii?Q?/hNJWOJTxfQipbo4kth5cXxUTZCkXC9TmUhJ+HqUOxiPdYk6xSmj8MeyUDyb?=
 =?us-ascii?Q?/MGOm/9vershG+O/SPAZ3a5+vHHz6mHs83JvAoCl5ZA5ZjX5xqvnPtTfewFr?=
 =?us-ascii?Q?ZDo4PjZkFUDqWqOpyChHMM3VglQsw08PvBxXJL2WvwTA4z37IzdvHZbTXp2F?=
 =?us-ascii?Q?OBHlrjqNfWeaQrvfI2sX9y7ySLVc58aBBvYlPgHQS88mpfxsK50HHp3PiPTK?=
 =?us-ascii?Q?5uBgP8/H4Ea4HA2EtuBQxA0WS2CSlDWsDXgscdzC9d8odFzDff9QMMPJ2TWu?=
 =?us-ascii?Q?s9OMcylRtMgf0GwnqQb+TcC1esOOtZpWEmJkW2QIVcG0gMRJ8xsz/Q+NJp0H?=
 =?us-ascii?Q?9VYqW67Sw3RpTTEadrZVt3btDcex6FXwexWvwf8F/d9VbXwKkidZOJpLiNnV?=
 =?us-ascii?Q?aV8aOgCqo+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Exp9ZSVqraLaLna8CwYwgQvl7rCFYVNL5xqcACpVIRLP6FSI7IGeuRfxygy/?=
 =?us-ascii?Q?IYUOMYPDSvNMzK707S9qrbWfxH9rMaCNYO2Su0m5ZRgdSxXsAIv8FG1T4084?=
 =?us-ascii?Q?wXZG29AWbEAAYiZZTrztMzj4H6N+jVgAa805JpB4mD5sth66eiFVCNNk9JEq?=
 =?us-ascii?Q?LaLVlhgmWy0XYNvc/gTvOH3e/2+TJhnkaJ+R3bhDg6NMUGvz9rF56LHxi83M?=
 =?us-ascii?Q?g6aPNhwXRS3ERRZH8beaA7jXEA40sfM618nPLpgRnilAdftCIgHzM9nLy9kh?=
 =?us-ascii?Q?itXq9WnIS4FQKKa34p1ocJDbqIieTzj83Nv5zCbslWZcYO9BI9aycQIkr1V6?=
 =?us-ascii?Q?EL/RZCD/aRgDGsGr3OKWbZB2nmY/hqwEK2vCUIfNoOzDIuZQY7VLx8UAs1yP?=
 =?us-ascii?Q?DKaqUBFXl6RrXInlLnCK9Ri00jnCmCKaJF1NT9Fpz5rmijPNJd3oKVh2nfz4?=
 =?us-ascii?Q?ugU+3ysnquGKUOOQgVxzGjZEl8zbjtb7trmQmUAMyk4sv8cEfw0v8YsJpoWz?=
 =?us-ascii?Q?UcI2LixGqlGvV9bCFuuWN46W491u/isz56dFkDd+GeaLYQmuvdwTrtd+5HWC?=
 =?us-ascii?Q?5PqpyYTNG2p6jh3acQV3icjYKlGUE6No9ZVWPNQXtuqxHX5UjuKHDCSsfGw9?=
 =?us-ascii?Q?kk7OP8Vx4gaQu+sGXNcArfPsSOk6uepYq/l1mSiagaDYfk3eWtD4dTP8hMya?=
 =?us-ascii?Q?kFNvxF1VC33Qld2kH3T2KpbN2UFRHLZoRTSsw2kFk7iTvNwZDVXwEZB9E8iQ?=
 =?us-ascii?Q?jZtL9veL0YKwLzac3zm4ttRSNNEuHpzfh1UaAwa5Fs5mCVnZQiukv777/gTy?=
 =?us-ascii?Q?b+Ymtns5Ui46+xqmrceyLWF/Hw9LCPOYiLwyfyQATc06SlECiXtNvJjvlk6g?=
 =?us-ascii?Q?fBHtkpU05OuhWZFXd3nFs3zWaU+Z//GUlO9Ia9OszL16t6OCXuLYY5cl5iC9?=
 =?us-ascii?Q?aS7Wm59qD6iBIoQSQloh8b7rGrI1Goko0SlWMZqYu/4UUT1mJENNNO39+rhO?=
 =?us-ascii?Q?4ICT2L0u8riRp8K+V0P3yfYf3XQFHtMH5R8rICibD5YUcq2oyR7oou256bKO?=
 =?us-ascii?Q?GJPnde6LPl3+e9jrzPEGz7dvC4W1uly57JhBAkDVaUzorguYD+W4/j9nhY5F?=
 =?us-ascii?Q?lEwiNlX8ntVYiafegg+T3SPss0YtGL7N5QfX/3nXAwW8uj8elAMDDVpnF+DW?=
 =?us-ascii?Q?mQofw1xMM2Yj3+8Gp1geaLTqf5K6ninmrak9Cpt77H7IrS7q6tvQaQe+eHLE?=
 =?us-ascii?Q?WXir9TQVpiL8rJrjCGnHd87nNeKfWAg1uQwIRFQ4RkkTnUK5ygZklUp48iaw?=
 =?us-ascii?Q?9qVEAyvE02vFJZs+JA1XQN8YRHx5PiAlGnO+2vPLVifAtBfRqkvUOD2P8CWl?=
 =?us-ascii?Q?MbPN7bI6mPt0jmOzZ8S5GARsFWp+k6mGD4leqsL8aI8+dhETzgASVVUIKV1m?=
 =?us-ascii?Q?xfU7BJj25rFgHwoLGWsVPs8yjtX2KHYgEGVgcVqO9LVrdK1ErWOlfcOczyCS?=
 =?us-ascii?Q?oZRC7DUOuRd9oeOrNeLAp3D0405SgqgPoi3IeKTXtMv6nG4J386262B8b95Z?=
 =?us-ascii?Q?R6TcTHmEhuZB8HzkL/09QAkheoFPwU85jo/LhmWR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845d3d2a-df69-4536-5005-08ddf42d4960
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:55:50.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjUXaaFNvbXqVHRAspNph/P9IhcNmlqeiQxdgCjQCZVH9bKXjIjNsW+eDeuGgPT6HHpxEEe69qAUP13cygUczg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352

On 12.09.25 14:21:16, Dave Jiang wrote:
> 
> 
> On 9/12/25 7:45 AM, Robert Richter wrote:
> > To enable address translation, the endpoint decoder's HPA range must
> > be translated when crossing memory domains to the next parent port's
> > address ranges up to the root port. The root port's HPA range is
> > equivalent to the system's SPA range.
> > 
> > Introduce a callback to translate an address of the decoder's HPA
> > range to the address range of the parent port. The callback can be set
> > for ports that need to handle address translation.
> > 
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/cxl.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index f182982f1c14..eb837867d932 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -429,6 +429,17 @@ struct cxl_rd_ops {
> >  	u64 (*spa_to_hpa)(struct cxl_root_decoder *cxlrd, u64 spa);
> >  };
> >  
> > +/**
> > + * cxl_to_hpa_fn - type of a callback function to translate an HPA
> > + * @cxld: cxl_decoder to translate from
> > + * @hpa: HPA of the @cxld decoder's address range
> > + *
> > + * The callback translates a decoder's HPA to the address range of the
> > + * decoder's parent port. The return value is the translated HPA on
> > + * success or ULLONG_MAX otherwise.
> > + */
> > +typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
> 
> cxl_to_parent_hpa_fn()?

It is actually a translation from the decoder's address space to the
address space of the port this callback is attached to. Parent port
might be confusing here and maybe the comment needs a rework too.
Though, finally it is used in the context where the decoder's port is
child to the port with this callback.

Comment should be more precise, ok?

-Robert

> 
> DJ 
