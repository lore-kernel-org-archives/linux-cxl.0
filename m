Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2325761;
	Fri, 31 Jan 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333158; cv=fail; b=gMJCDeyvHauT7wUsjIUw+qg+vKWVaS+J4j3g9HIN3tTsJr0jWgPye17EeypffcJNeKlVJoqcE/SOIA13nnwwrBNYWTqce4Xh5jlMrNJeYM2EQ9owED4YcuzfSZIi6VPKsBBMKvsDZDsx2A6urm8K7z1B0k8AGOV2hUGztT07C18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333158; c=relaxed/simple;
	bh=O4JFr5IK9Jjt/m3FFVdHpyAtMn9KhYGzYAAxbM3fQvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h2Uqe+0zo0rNzqG7YtXSrcgxi0mm3pI88C3kyIT5EkTD0BHXUWYce6B9/9xEAxnFJ+DR9yg1z9eBT+80R1m1qU8sAweMpV631EdlgJdqYvnDPhr6j3sbQp/k6+pztjBKcSlGx5S8cgUAAILkexH1W0X/2zdp+kNAe3rgMxs4rWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NvrwAMTp; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NvrwAMTp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeJ1rYsW2iF8uY6AhaSeRAvhpWFdcRovI0b7aZ96QF2MzMIWXLihCR2Z+OH4wB4h0smWOjNI2WS256phdPfojx0j1lguQnhsMU5uRMTFwUy3c+UfFEROi0d2eFGX9qhUqrdpCfN1RiZvLjuOOGvuJgbRsPDyfn77shgDPIZ2z7QQr2LIvKLLYH5aDarhe36JVZwRLpK8WA7/8L9pqiqyKRGVos1hQ0rSKXjfYce+y8mcgWLZgd4zxp4dNMTAY6NmpIEDnrMsJgr6bGqMPkfu3ESje3IKVivqq0+zq/8Si9UP90edm5VG+elOjo9FVVebRmFqfdjHxuEfIpFKWrhtAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRZjQh1LzV+XD0jNBY1wK7yrX5LC40oGrci4NeOdDjk=;
 b=d8vC0Uv5sfo52Pue4OTDYxZeHZAIoTGOT7KiJRzpL4UL2Yj2HPSMVzRUqDMbcKh6Q6BjDjnWGsVir+47mMCVQW5TqaY9TjNuRg6AhyWg9Bx9k+979Jpdfkz9qRKbAb39pFkbR6NiSf7l+0LS/BtASS27do81EtFN01gf4cnmwvvBNSr0cdi1vCLqSf9v+GKDbFpduwNj5WRj3xpwSCJ/IJ0q8ZYb6/AulLdlo7k8n53BJyJg53bkEr/3tCaL8ASEuLjk2I2afc5Joleuj9YEbmBeZ1M/zDDx7MlXIgJVzXS42UdaVSVZz1aoijQUB5eQ1xfsIpu7UAuq2sbtgsfELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRZjQh1LzV+XD0jNBY1wK7yrX5LC40oGrci4NeOdDjk=;
 b=NvrwAMTpX2XzAK6l7Nj67w3uWOLL8JfDkuTms03e7T54Ui6dbKQQgYdgLCqQmEEovlbGkaPsy/396jq+4kf3sDZU+aZ7W60jOP5wX6LZeIju5p8I4YgVnEFEvQwSp9bfrK/dX+ATk1c2nOITGlSGD2L++iJN/ch7LDJUI+nQJL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Fri, 31 Jan
 2025 14:19:11 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 14:19:11 +0000
Date: Fri, 31 Jan 2025 15:19:05 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 12/29] cxl: Modify address translation callback for
 generic use
Message-ID: <Z5zb2fYQJD1DPgFc@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-13-rrichter@amd.com>
 <Z312KLDlB7Hs1RB5@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z312KLDlB7Hs1RB5@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR5P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 862cce87-0d44-40ac-c9ee-08dd42023b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?92R9kbaVop+HH00SQdoQScrzVEeSVZlfaUUgrH3GFbqp3MrizB9y0e/GitWo?=
 =?us-ascii?Q?TAv40lCladC0+OLqhNKHcFTHc7o9YbyWnuw1zjSGRB7dhmub6SOSWwXtCfRl?=
 =?us-ascii?Q?z0l251CqhaWIGFMZ/pj692DG4g48mGvywNe92mp4rRkyz2HpQUmqQ2h6Kkgc?=
 =?us-ascii?Q?OxGn0I7X14WA0dZQVflQE46h0rjQDTRSIOSta90DgOUuxT/6xDNGMTbsMOAA?=
 =?us-ascii?Q?4WXgStrQ+iVFIgvzdGB1heslniNPn13tWJ0DjBu4xHMavhonzeXZYWISpgEb?=
 =?us-ascii?Q?tVbVTNedNGIzYDcq8aqEFBGup8lWN7ToHIG386hK9513LreQyHeUGhoTTy4L?=
 =?us-ascii?Q?9YJbeH/hO6+tZnOzZBNrs324ErfwFri+sPl3ibExmHjr6WgKVt4razB8cx1u?=
 =?us-ascii?Q?9+sZQkoDNw89UTmOwU9+GMwiPY4Zi29zkv6NgNCHe5R2FK6t+C0CYb1yIvqK?=
 =?us-ascii?Q?cVx9of0vN33IDadiMifDz2BABuyuBDfXs9p4lBnS5/GIPuH3VBo+irGTIdLu?=
 =?us-ascii?Q?p4gNLQAFF0Rt43/TXVHkLvEcJuceo7RQv4435YjBq1tUERr18nzWwURaXIDZ?=
 =?us-ascii?Q?x+n+kHoMqSAzhaybJDGfpZzoyBM00z5/70rRAKrjIthF3ezH8iTl+FxkPbeu?=
 =?us-ascii?Q?DDrOjFSG03qYQvMq00WsW4goOhduWTv6IC2hFN9oiYiUcI2WGP704FiVO5Mj?=
 =?us-ascii?Q?NHvZi3kKK7cJ5D3W9vzhhr9z6fKJIlJEjvvbMuP1Gu4MVHcgyt1BmBgjKceQ?=
 =?us-ascii?Q?3W4/tiO6HzzXJFVZG1Yl2P7tha6nAi7tKp6g4wr1fv0rWr2hudTye3CBJZaJ?=
 =?us-ascii?Q?kdMdaZN4dWBnC8e8Tmmc36oAvkeJDJhkmD+I9PMaQALaU325WtKKJqp75cYl?=
 =?us-ascii?Q?UX+bcl8+eaHy2Smlp3YhvX6YTEF9mnAkJWHBW/45dcIk+FuEaO72+nVLU8Nd?=
 =?us-ascii?Q?cv955ybPltltn/744hPa26x9FJ4FgL56sEjQ69nZLeFvDmJ8Qnx3KcMCchuo?=
 =?us-ascii?Q?wa46P2cLSDXAJ20tc4YNxmn0ArmIrPUC/AKJKqMTRup2FR/psB96bbN6AM/6?=
 =?us-ascii?Q?G/5KWtv0EsCvjg9sLiET2wrVyi4LeHTbA/oW3eh83/bs/xQgSuwfsGnxH+Sx?=
 =?us-ascii?Q?4rEU8B4CFa0jiGL6nimGW7t0AhW25ES+QbWK2JYuRBPUlDYSV2D0bfnJwIQZ?=
 =?us-ascii?Q?gfshXlq7ULqg0z7w95HVjWoFWS6SIpp0ARYgovCCS3PN+k5sSk5LaXSEWrTM?=
 =?us-ascii?Q?EYKUdZwRnMCmsJduP7gv2hOw3UIVMXfeptKY2KrIAdxNIiu1XWDaEI9rnnV+?=
 =?us-ascii?Q?7oxM+XVCuM1MF2VAtle81/xgTqggwGZxiI7amWmd9xVqiXnwc8d6PuDHeoJF?=
 =?us-ascii?Q?xD7bmGq4v2Q+KKMYzhyvJr57h37B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQ6Nl8SGVr0upr15o83yW7OJ3LVLGN7R6YdFgeLEcJsZ7Ycpu6NSxXarjdgE?=
 =?us-ascii?Q?Tr7rUGMDVbrjwEGBXnaLL4bOfdWo9Tecw/stNlQUiZupts1HxEovvqdoNOMN?=
 =?us-ascii?Q?xdOAyfjyguwTh9GVnN9ouljK6O2p++RRzDsNJ6g4NIXRq9aFi+euvU4kX3yF?=
 =?us-ascii?Q?8GIoELAu3JVm2q7mSxmhGb8G0IS4+/Tber6+yI/B7cBz+oIQ3RhE6xKkP2hE?=
 =?us-ascii?Q?Q6vbfAf0BIBPKbaci6K8doHvWKd/rGOLvnEW186w2wJsG/0YMQ9TuNpiQR8F?=
 =?us-ascii?Q?pdvYncx66XACPbwm9F05RWxncO71f843lvjdIo/QFiZNYAwaGVZEhqafObak?=
 =?us-ascii?Q?TuDjzOQP5/YeSFy3i0rqTodSKoxvtLP3k9pAFgOUeOIaNnXLAwOOukWM7nh4?=
 =?us-ascii?Q?+lZlyC8Hcp4/5XdxSyTj6WoKlsRtdnU6JSz2XOuxeWpi3VKYBbOsC9XRQRJK?=
 =?us-ascii?Q?rl3Db3a1hiM9pWF61ezcG80OnJvmL9ZnvHsJEwUnEz31bJWvnooIbevq3ZOV?=
 =?us-ascii?Q?+BX0JumfzFqbm5ckAk5beHXkwo6sCxpxXrasW1QHn4Ye42WOFJOGDyhFgCrE?=
 =?us-ascii?Q?Y3ipY/y0zK6euVQx8LQeyb62sticxBEJALLiWJPXP0k9edlbLOwKKUHhgoKv?=
 =?us-ascii?Q?a/a6mAAzZnMHkfHL+ZC6ySTO5l6gI4R03m/VN+08rxjthFVXiX4iPtTSZN4+?=
 =?us-ascii?Q?o36r+EYBgc6MIU0/SntidiKTQUoMSDq6RVHlOVzZ435+wZwfva8IYaityKeK?=
 =?us-ascii?Q?jwOyVfyKsiXdp0TZD4GuBW/nqyXuOBMCTcji1u3tOAJd9EdN1h4tBOPs3llE?=
 =?us-ascii?Q?rUIsI+XtC0gbxWjp3hgDJl1yZ4Eqr5XZBNVBcoJI8sdlzVjOA/zrMWKMgpbA?=
 =?us-ascii?Q?kIdJ1G2Yg/dPDw1cuBNcldXVL3IYUn5q5ZPV05iZTtPFGQ2j4l/lr4EqejYO?=
 =?us-ascii?Q?TnLTJt3M7SljfxNfngkso86Srhr+5DYzugwZDjIHXd5AbOjuGJuSW9mncRZg?=
 =?us-ascii?Q?he6Z8/7QekGgYsq2DGUA3EduZAStpw8XGuPrkDguBp7mqaRt9IzT1B4HpSIm?=
 =?us-ascii?Q?tgqNFCbPt54gxrYsAEb95cTz8QWa4ColwvNwkARVuj9z6YVCSHg1EhlAtL4L?=
 =?us-ascii?Q?N2qMVuKNOvJy5ne0dkL+NMMdtuwWavZ7W3eq893LPTfP4MsfG4z2D7ZVyKBf?=
 =?us-ascii?Q?LxlSTaZdp7nG7pgq4CQCCTNsl3aj3flLlNjrE9vQDHHQYYsip5AlL/YhO3zX?=
 =?us-ascii?Q?HvsQ2z8CkyElzxDfowhpxEsYCPhtWEmdfnUPyBqhmt5Wlhp7e+WhMYdsvLR6?=
 =?us-ascii?Q?XUdsHgIcwVo5C9ScgQIRA8wtaqXJOEPQOnA1DFR9bm3XXkTqdmZdGomTu/SU?=
 =?us-ascii?Q?uvEjhsUrfBeBUxakDO6YS1YAEBGlFwqjvR31B1isUnPHNEkFwcFWbk9+xVis?=
 =?us-ascii?Q?War7QGkqmAn6qKAU4yeW3ELGNGCPUmFzXz45hFCFDTQ3yo+6m5UiquJJL3HM?=
 =?us-ascii?Q?8mDYk7ZJufBXkd+QFi8K43tbuHBOwv6HDKKvDlXcUze7h4f89vNlZbsfltJN?=
 =?us-ascii?Q?7b4tE6odSRH/j0oIwBHXCusenDlkHljcnRmxXSOZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862cce87-0d44-40ac-c9ee-08dd42023b7a
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 14:19:11.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8GEZauE5AIS9r9N9Nma5GIlsZFh7BgoB+I5pm43vHmJx7EUBUgGMKGuuxeZwQj7d+/XKwBbIw733rOzm6oKTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155

On Tue, Jan 07, 2025 at 01:44:56PM -0500, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:09:58PM +0100, Robert Richter wrote:
> > The root decoder address translation callback could be reused for
> > other decoders too. For generic use of the callback, change the
> > function interface to use a decoder argument instead of the root
> > decoder.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/acpi.c        | 4 ++--
> >  drivers/cxl/core/region.c | 2 +-
> >  drivers/cxl/cxl.h         | 5 ++---
> >  3 files changed, 5 insertions(+), 6 deletions(-)
> > 
> ... snip ...
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index b3989dc58ed1..be7685fe8a23 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -443,8 +443,7 @@ struct cxl_switch_decoder {
> >  	struct cxl_dport *target[];
> >  };
> >  
> > -struct cxl_root_decoder;
> > -typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
> > +typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
> >  
> 
> changed from _to_spa to _to_hpa? Was the name wrong previously? Maybe at
> least comment on this in the changelog.

A root decoder's HPA is equal to its SPA, but else it may be
different. Thus, I changed the name of the function type to
cxl_to_hpa_fn.

-Robert
