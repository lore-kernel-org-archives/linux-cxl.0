Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004246D2D8
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652757; cv=fail; b=lgpTJG1gHCtPDizADGUo8JOfuKxjJORbXaTGUKf2UiNaQUkZ0sKzogGhpUT1CL+NC7FV5vOOGs8NezQgwI02CHyvJYceMV1aYc3CcPGRdJFujj3uzcjj0s+0WRBeKun8hyTZO3wA5QyPU+lYnfUVahwzv/mxJZ995jLWC5yNjy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652757; c=relaxed/simple;
	bh=WlJXO8t9tkXH/lYMaHdtNN0hr/AKx8nwWyEOgfMAfM4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fdd0kcGOfbQ9plyAHRu9ti25BR6TCrQW+XB7f0U7qBlItRqtyfbnE5+4BedRGVWeoJ5mkXar1JzvpfMTYvl+PjyecaoTUecRRhjRfqvCi5unnSEouWZ7rO+Vl0OQ8mFIljEQAfJ3cNrCc4vXr4Jzww9XAwdI/9JRpBBnZLBAf+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ha7p08ZB; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ha7p08ZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784652756; x=1816188756;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WlJXO8t9tkXH/lYMaHdtNN0hr/AKx8nwWyEOgfMAfM4=;
  b=ha7p08ZBN1iyqz91mV84bR4zTJA1kMoVyYzI1OT4emyqwa2qqm7ndzUs
   CU3guD8gxZeotQ0XYYfi6gQFoCkGEZZkYD5o7sT3OD5vpN3gpkW+joHyd
   Lduz3GRCQaiYUvgX+edpmzyaS4GBdsIeRF71OQxe7QWV6Stjrf7W5SU00
   52ZtM9Vm9Abuz0uxFeopXK9Qm3Q7ncC46k0LrK94tOskMM3XtTut55nsG
   mk0CKXcZO8rC7Q9/2HL8PQwgK4P1EFw2OUJi8vHu5O/U/9K9FXeROJpy8
   3dfBo52I52QuHhzTw2st5hAOT/O/38PxonwRMwd9fY59mECKpZJs9UVkf
   Q==;
X-CSE-ConnectionGUID: TCds8mRORHqv9zE1wq2uVA==
X-CSE-MsgGUID: /mn3kNdnQcybQdnBkDj5yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85279949"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85279949"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:52:36 -0700
X-CSE-ConnectionGUID: wdWK6zs2Q2yrhWYmm+WhLw==
X-CSE-MsgGUID: Zc40jpi5QuOpeLjLmFY0Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="296021945"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:52:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 09:52:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 09:52:35 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 09:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAEC3VxhALsc+RD5VNrbf130rrQn7YTLuK6DCvtIs3xS6ISOsPX2EKLwsAT6BQftEEKunZVL/TS3fsJhjN2ZWFY8Y3hos56FkCtFO+Hj7NZKU9fGTtrKygdp9yyCRoyV7W6X92avjJszjyLv+opmjd9oWrKT5wqSThp5KcCPNgk5gWVIrrX3FYsryXlq3A7FBmUZ15xh3/rEgviKbsTwRpUNXc/fFlMH/oeN9xgjEn7UJHzFrBdt10DWrwk1hUgdHBW8CaG7kSAYyFlre0mq7XEi0FVUr0yeYlzKBypsMIEv+ytaEuiV9FT8Ud1C3VkQo3fY9lInC7bGS5cz0dBC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YtsTIRmrtfHJUKy+YdNu1lvdnhF15TyjL/M2vMAz/E=;
 b=loGulsJYi/O1WfWO+wRsTLA54fQRlnJ9oksPdDtVNtOVhUgFKddLXsFtTMkwg4FVRTlXVe61FKi6ufYFhidiKDgffsswyyeKiN6CAQ1tSpGBnfCQn5VnhUbJpx2FGuL1ngUUmcMH3EgVw0Z1YhqhsNLjiDtKQDnTUOfH2zGdIshy+5xS2CBdXqztVPaLPrvSfdU8MHEnkQSAxpyv5hZnaVXp99UMM8lpOVIkmRMAXb2UMcA3zoB2BT8KXfsZzmh1cbowOtOvwfCs7+KgQ9YFOaCT+eIFvIr2YNPv1acg5BAkCYaDV+8ahTaIYVxMD33yZxpbKzA4bHVnk+d+R2q0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM6PR11MB4673.namprd11.prod.outlook.com (2603:10b6:5:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:52:33 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:52:33 +0000
Date: Tue, 21 Jul 2026 09:52:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan
 Williams <djbw@kernel.org>
Subject: Re: [PATCH] cxl/region: Fix use-after-free in find_pos_and_ways()
 error path
Message-ID: <al-jzWdbP0g20cJn@aschofie-mobl2.lan>
References: <20260711180755.1779002-1-alison.schofield@intel.com>
 <862754de-1e19-43ae-b212-f7a8c9ede739@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <862754de-1e19-43ae-b212-f7a8c9ede739@zohomail.com>
X-ClientProxiedBy: SJ2P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM6PR11MB4673:EE_
X-MS-Office365-Filtering-Correlation-Id: 28aa8c95-0d15-4585-81a5-08dee748754d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: WZlfOUlR8x9VIuZfle0b+eUEWjO7ddnCI+N5R/d2QzxgzxBSYgDzGZtBkCeDoulXqnwuSG8WZ6EHhY6rV+qQwmTaLCxrZAeRWg2fLaA8YwqpguLKXWh+5O0yyaRTpmuOt5GB6qivafQ0mzTAXWQdCzVSPOoBV7W3co1/NG5d2O6hGQnPZi5wDSncLZWv0/MC4IocJQQFA9BMRPgnC1auCe5HoZkiKHnmQAfU9NqSaGObfBEFaQlOhHoTfvYcnti6Y2LUrExUhtgAznKR7Zgt/pyfF1n2TCxzrsP7wFDsUINqaBtIF1MOnBieBESU4xCGfWLaX1UHklIcaE8ZC/sgvNqAp7hAQaS3lRxks5PHTxZbqUluHVAR5M5xt161XlShcb/PjT4vw0RNIkVUQbJFG7aA5q0yDRMoThoEWPxdNn7yFP6GTR8z9IJXgUb8JUGxWJR9RW0wifRD5D0ntVljkwr5eD12L2tZdMjX3VxQH7NEu+cTU7UH73+OyN88bl9j7wRLirzp4gbTJG1Dsi01cAc80zAyzL96s0OgV7X+I6op2qiqNa6ISUv9UacTb4OkhzsPvx00fYQW5FUWwiLfZbOhjhrjxqEFD+4uYwztZ2EsXiNt1h0cWraO3XiOo6G8g8GRnxdenMZn4hDpJkPxTGcBBYYxBnQBeMijARwt5BE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4rzrpNgaWgZMd4V9/xhGzLXOiRf5NML5YOyJOFTtakxg7te+KhslEtcmCyEV?=
 =?us-ascii?Q?2Kg0X2ZgKkDD++njoc/50TJIYX4vYwkBxtS/HrzJS3/RufiXOcxqrJQc0HQy?=
 =?us-ascii?Q?K+8H6PwYQCF7GLhmAfuArUOEEjOXQRvbbKn0e9hkULfdkRqBsK7Niq8vzvMe?=
 =?us-ascii?Q?hi+Ya54qyndfl5nHPBJAmBbBMrSZEXzb6uqTMI2TXurfQESZvplKjZ4VJ6If?=
 =?us-ascii?Q?aaIrB0Q6lTongXoLyZpCAXFk1g/AZPTpyeWnaGbhhUQKsi4o1ColYLozle5W?=
 =?us-ascii?Q?oGSiSJda2SlPvlcXr5/PD348A/gag6RSDiBMQpOiBGysMBJKlasfx1hnVEN2?=
 =?us-ascii?Q?etg3hpZxiGJzFnER2BezVEHSAAeVZ4ta2uZEQoCj+9UCYPDivmhOwx+H6w1S?=
 =?us-ascii?Q?eg+A2DA0FGDvl8HuRi2Q8KvTBwZFx4crG0RVQfmRF8ep1GZfCpc7t/IunyxH?=
 =?us-ascii?Q?LVR/p0vlcvYj+GSoBAigNCoo8u0ZRI05GeVKIWvBuBmKPrStDCRa0jyVA7wU?=
 =?us-ascii?Q?+wx3Lqo19AxUPWj3BT2R6lXk3fGh5JurrgkQIQbRt+f47a43nxna7PuWjT8R?=
 =?us-ascii?Q?lyFixW6o+zmGQJsuYjaJMFc8Tl/4Buiq8K0MzEKuJUbJQSOD6jb3hI8R97P/?=
 =?us-ascii?Q?pi5ojU/Hb1eZRJzkRKm2A06t56Ts2BAX2qoInVbx8hmSc+ifI+C7IcRevVhL?=
 =?us-ascii?Q?ufXuvURbm6etunHRBVMNOP3MmNuOG5QF9jDOyE6Md8HwPGMBEdrmxOncHfS8?=
 =?us-ascii?Q?ENiEBM301U1dCpU4cdMRL2knNYUntK30bZSHV/3eGJaG0B9C3AE+QwMZJWwz?=
 =?us-ascii?Q?gGcedq1/of20GDJDPK7p3DTEuIGbbk2VP6AAYeA4ACb3nSMHueheivk1xUK8?=
 =?us-ascii?Q?k9Xr4nA+UmeL21Vc/4WPicanC7cmLOWECHxQeVWj8kkl40LBuaXjKUDImSs3?=
 =?us-ascii?Q?NNjvr3UBLuc6T4dc3TfJ028zOP5rP+vmDmTekDTT+Y3rQ3Qg9gzMVm8P5gQ2?=
 =?us-ascii?Q?QjEdUBpkmux+VbHkOnBtc7RGDRNbZQ6BHQXTI1r07EbhCoAXoG3vf5PaiXpW?=
 =?us-ascii?Q?4hGmf0cc2cAGiBUkRNEq+5SNDxuXA2FlVdkrIGNNcWghanUumNrHKBidUfE7?=
 =?us-ascii?Q?KblCJJKEXkHqeI0yTNkxpT44AOxRA2le+QbhNWtPt4bNWvHgmoLdshGH9cv4?=
 =?us-ascii?Q?AWrib8rrbV3fxNMoGgO5Vu4gJK36xR/eAv3ysW1CYOCliv1NpFUQJR/bGZEZ?=
 =?us-ascii?Q?9Rkmx+cFDzAB4FD6+n1hcAJ0dmMCSOweWTrkFvkKWWMnkex4jQ4WXAX8nD8X?=
 =?us-ascii?Q?0XkXEXFeXWcDsEYisP9rk4RJu2mVaEl0MYBbVjfiSUhDGf1S2rdEQ8VoM4Jl?=
 =?us-ascii?Q?xGqGmZvO1X4w44yjzy8+cT3d5g0lZZFfuRQeDmCwuIA99R6A8R7mb/41iBel?=
 =?us-ascii?Q?4ZvSSy+p/qY2NmEyVegQvUf1E/lNBj0Js7wF46eLeJn5VmMN1ksiPQ0Xv0Py?=
 =?us-ascii?Q?5GHKvPA8/+a6H0PT5+61C7P86SWTHAfYdL1aBDoCMKt6+iFrUJabBBdIUiBd?=
 =?us-ascii?Q?PzYDRTUEH5v6R4Sp4Mt7TnMxw+WeQ78ki+8fvL9HH8n+QD0BRUtVdc2UmlC5?=
 =?us-ascii?Q?uZatwJy+K9/lvGy3wK227a3/rcO7jHObTynGwxnUe65/k09n1T/FG0Y5MsWd?=
 =?us-ascii?Q?nMrXFBmARk65sezRfGkIQjgRdwPMCvGgc6x4a+DcitI/znxs62VbISlgZNAL?=
 =?us-ascii?Q?CLu0cTsWiHPdnhuBkwiq8VBZ6aaeDvo=3D?=
X-Exchange-RoutingPolicyChecked: QH8j+BDgtAK2QMMRsIinrnDmiXIMdqerE/fgKWdOgQnKLe88B1FlolS/xq2W7VQbsy9yzAHYJYad0jhOVCLatLBfyLEY3LBRQn/jB2atfYGT/M/E3/WpGVW6U6UtF2c3cvtzce2yTn777dqM2U3OzWlJv91rY1tx7NZjl93WJce3XiGfQFQ9JG9chjJq4e5+rmHfHv7q1+5aIeO0RWgbbayOoT/44EKObbhcBccA2Ap4oD2le5P02o7hg25AbA76zLNpYixV5tTt6WL80S2H3RTN8ePgnvp65/fFmfgfOOMTK97slpGaBJTxASFcC7JGbGsUFALXtvh/GNFCsKf1NA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aa8c95-0d15-4585-81a5-08dee748754d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:52:32.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxdlg/VPtJ1/lFGeaOVGBoXMXhyid5oIUIF+MCGh59hMNcn4P+9oCCsD8RR8UE3L1/4Ru4z2RfMJuUIUIxKdRCngR9pZVbf8xPratiW2NUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4673
X-OriginatorOrg: intel.com

On Mon, Jul 13, 2026 at 10:48:52AM +0800, Li Ming wrote:
> On 7/12/2026 2:07 AM, Alison Schofield wrote:
> > The error path releases its reference to a switch decoder before
> > logging an error that includes the decoder name. If the released
> > reference is the last one, the decoder can be freed before the error
> > message accesses its name.
> >
> > Drop the reference after the error is reported.
> >
> > Found via inspection.
> >
> > Fixes: d90acdf49e18 ("cxl/region: Add a dev_err() on missing target list entries")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1e211542b6b6..c86dd9d55e93 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1938,8 +1938,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >  			break;
> >  		}
> >  	}
> > -	put_device(dev);
> > -
> >  	if (rc)
> >  		dev_err(port->uport_dev,
> >  			"failed to find %s:%s in target list of %s\n",
> > @@ -1947,6 +1945,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >  			dev_name(port->parent_dport->dport_dev),
> >  			dev_name(&cxlsd->cxld.dev));
> >  
> > +	put_device(dev);
> > +
> 
> Is it better to use a __free(put_device) instead of this open-coded?

Yes, but that is out of scope for this specific fix.

Using the __free version changes cleanup for the whole function.
(ie - doesn't just touch this one line above)
I do agree it's best I do that 'now' in series with this patch,
so I'll respin this as a 2 patch series.

-- Alison

> 
> Ming
> 
> >  	return rc;
> >  }
> >  
> >
> > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> 
> 
