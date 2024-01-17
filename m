Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2822EE0
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jan 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515601; cv=fail; b=CSqLdf1mH5IJd4DBNcK2pirwILn5AHoUxh+F8X2xHbkO8fqyMByi7Wm0c8BPzg9CWl+NbS5S+lhgMvntyUtBcmmMWO0CPW1yI/5YFtMA8nZ8/OmcJOCFXnI3auLC90rap5EPjZni9BXUEtesT7VTav6s96jaa8KtzGi2ooz8q8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515601; c=relaxed/simple;
	bh=ByImVtm7KbYGu/b3FvcqSDAfi+j2pkGtyUsXVyGMIt4=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=YxNBUSpFnq52bj244FHRmU9NudVdp9MHmUE8i4EY9d3cQYL3WxWy98p2OmljeRWUaKoe+rUO3Lv/w07zpNrIajX8OM2ZUcY+RAWA52iraiYTQO7/pC+9nqAkITi1eTGRFF2yTD2TFlYXD7bxLVk21lcH/b7lfnSMFT6R7+Gvjm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIzhYi+e; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIzhYi+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705515597; x=1737051597;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ByImVtm7KbYGu/b3FvcqSDAfi+j2pkGtyUsXVyGMIt4=;
  b=MIzhYi+eQX2FDuUrpFZVG0qKW8Cnk9hMsNew5nNMHrnAw0PoGTsd+xu/
   2R6djB1W2SL41KEMsv8oWLPTE64eEmjOe5PjT7vxd+/zGJutt/Z1MO2Q6
   BDIVwZefeLFNq7qnSpRbaA1CxRwPrEK9Ld0Oma8y7t+rVUcejivSjd9Fi
   UttMsjdeqX5fsa44C0a4EyyJvvcGT6VDduahgFavqGtaxtgvZW6xbPVZ0
   WfaJ5DYb2oFknH1vYAQyWyOqqvqpEDvRoFpQY4f/Lajadu2WV5HkMDjGs
   XIAXf/GBBd+A6PAOPJAggoWG/FzngOJ25KYJKiWQJO6vwph1jXiSfgWTe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="133850"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="133850"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 10:19:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="957586261"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="957586261"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 10:19:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 10:19:55 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 10:19:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 10:19:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 10:19:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjObYstaA7mw5bALab+aLCJruSiu71Xay9fsdEI45BAhg4Qrjx3EXK2zGC77b87C2OWvxd3ZJWEX/e6I11D6/X0AfE4uz/NeDqxotB205UZocSk+6g+77K4twyjGgtPm+8T8B/J2wQLSNWDkzunWMwY7VC3fDait2EyLu57hqyeUBlYKhPZCOKSqrVkFsOU1VqQ1rYEeRZ/YrdTE8oc/YmRGdTcA6yroWGd06z1ZXf/6Ub6j94BDpLbJbQ03+J7lZLTN+1W6gszb8Dq82XCMHkrAnbGOaTaMWXzjEINnkZHyLyeFNl6yhQLHDJNyDFrdjeqf8Prn7ASRoj2p4kAQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtvXO/thSSSxFt+CIJAupdJ0h8U1St6Ew1kMzP+UstQ=;
 b=OBKBnWifs0k2roGAsDqlMuPPN8wnRn/0RYpwLll8kagIQZ8qRyvgxBSxrIDluMptYvC1KqYkzfZ6o+wcHzS4KpS+oGx6mdepzAuFd2N1BR00BtalaZbY0wcTiscFmCh0RUpEqb25ZjwXq8WSx5vGhQtD123/CJ5F5tD/muEERQnwldmVKanrx2fEJtAupNm5UrAd/7tr1mPUZevECL0qk8JEeuxvk22zMOa4z+iaBo7KWC2ZS6W6ml4ibZVj17qZpRwCj5X2nt/QtoS/vJxRT0fDXUvUDXroQDlS3Fg6VHtoJzP0lo7uCWNxD9Pd7JvBVxaNcuRb9v+84E6VA75wQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8262.namprd11.prod.outlook.com (2603:10b6:806:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 18:19:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 17 Jan 2024
 18:19:47 +0000
Date: Wed, 17 Jan 2024 10:19:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/pci: Kill a goto in read_cdat_data()
Message-ID: <65a81a40cea43_3b8e294ee@dwillia2-xfh.jf.intel.com.notmuch>
References: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
 <ZafUwceT4N-bmS6F@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZafUwceT4N-bmS6F@rric.localdomain>
X-ClientProxiedBy: MW4PR04CA0369.namprd04.prod.outlook.com
 (2603:10b6:303:81::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed3f35e-e9d4-480e-795b-08dc1788e2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksXLq3/0pS436jC/2qONzLQomgT6i5TA8EVEAt5n7oOebWZROxm58o9OC8Sca1MyS/IN3/rVPwElz80sxdB2uOB1FNwTDr6+J0nfqtmCzcnwkVWLFd1gy6frLd32+4DbrRwQH83Ps5qFGt3cXsNzxQbL7SxAWKG6ktFbC2UNfhC8oL5f3itiTRRtiuVCiKw1+gWrfPztbVHDCIDbP0mNWtoBftM44SvShtlfjUMXjnqy0LUJ9IcwAbhbBItEAQuBdHXTdNn4O+wlJ8NEwFgr5zTv8LmQs9+mA5shhJwwXq+kKU1ldLIJuHpL4BrXTthIHZRmtDiWJdhujCi0lfws7Vsn1a1cFHxEfxHkJh3wi+vnR2lEqtQIHSmHW+GJly7ODtASQq4peLxMlpJwFVtHCkqvBd0OfBuF+COkmiXqUgYT+e61jXBUQvIyeW8mH6XQ/N/SnMHKEF0sc+5abL9eSr6fsjmDwm7Po+u1wpr2j1ejVSxRwtRv7jQtmdZ2gduHSF+bu+0FA2qnLFGSBh8R0EASIiBfCjRfEJfycUH7vVXyxwreft+6IEQNTZvEFflE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(83380400001)(107886003)(53546011)(6666004)(6512007)(9686003)(38100700002)(5660300002)(4326008)(8676002)(41300700001)(2906002)(8936002)(6486002)(478600001)(110136005)(316002)(66476007)(66556008)(66946007)(86362001)(6506007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cD+61ldricix2VFduqIr6OfsxPlQpji8As3H9Sq29ruZ+YPtz9S/hoJJB+xv?=
 =?us-ascii?Q?Xff4h84MSC/viR6wF9QPRsw+0U3kdx6PZ2YTXAl00AAmXP9Y0KilYeKnLlLS?=
 =?us-ascii?Q?FXVWRmkOBHJl202VYeHFBEtep1ay1tNiS0Wyhn8UFaSVPmr5ix7QAcv1V0mR?=
 =?us-ascii?Q?oxc6ZLh3RRuG5CEqs2UAfPpVTSR2bezcvGVI+D4H7DNQP6glImEY3lVakOky?=
 =?us-ascii?Q?QzRSMzWK/nOmY6Y2BPk1EvziBx3hR6qfG1F/lV2KK76ppzLxH1vG9hfoOre1?=
 =?us-ascii?Q?0AGbcay8tD2SoLyTtxLD2wnfU/p7xGqtUbIguZ7WqpMyldVHH718qOfEB1Lq?=
 =?us-ascii?Q?8fuGIUZo5EEExdlDMSMJYGdBcO/ykjlRx4cW8SNlXEc2en6fdm9gZmMspFWd?=
 =?us-ascii?Q?yCReMZVb9JDtoGFhvYGaLbZMkczKLxBnmxktAkjpw315fJUq9G0ajm2k4k40?=
 =?us-ascii?Q?r+Cb3giwMGG14y2010P1EEwB+HhdRNlISj0ee4B60XARkSr+XtovuyGo08Tc?=
 =?us-ascii?Q?q2GlcgTyuQizMB7oAjKcqf+TdMrn0erU5VW/qBWc9MvmwNc4ZmG4R8eQGNPI?=
 =?us-ascii?Q?LH2Udu+5+1LpfSQOi6kWgiVG9RrgZlqq64xmFbZewrj6jgEH/8OLGj0Kdph/?=
 =?us-ascii?Q?q+XUDdI9bL/a47711hUyOx3mfkSlG3aSSLIXkPP9nD7I94j6eRl4gCqoRAWc?=
 =?us-ascii?Q?LVOh6xgbp5/dknWL0sSnmWMvF/2xMewfDy7UVWVUaAPm9VKOMjgFz2X1V96H?=
 =?us-ascii?Q?WYS1jzJXasCkAkcDwgwFt5wmO9rO0FqFifRvF4TQ2DEXxdKOKPmgxg7h7jg8?=
 =?us-ascii?Q?QXeLS9uF7o8MTuTrZ8YgJYzeIyA5bNRnd/EcEhdRlIFsIcnjMo9yLpI1OJQ6?=
 =?us-ascii?Q?ojWI2EtvbBd2FWxug+1Ho/Qhy+vkRzo0MDRD9Ly7H/XONCQQWpKUFvnez6AY?=
 =?us-ascii?Q?fuk0KXR/23sc7uctl8uvlcY2JjolH3exwV1XfsEGre5vgfKpztCftS94kIRf?=
 =?us-ascii?Q?tLMH290nALqTTgjnqNso0mbpMH97prIT+yW2k/QyTwHOlbY4yJ0RTkwXz/e1?=
 =?us-ascii?Q?HT9mkcqOqHYOS8R9yzb+nPNn22dNpLq56Yn2gMUyar6bCRDqOPv+20XEeG1z?=
 =?us-ascii?Q?w8/DWFTz4fXyoahCqQJyMEb9dMPIx6pvxaLMc2+aaHvD4n1BTJHJTQEaWp7T?=
 =?us-ascii?Q?D4imgv4y8qjuX4jGnzeK6OngKLowAunMWJW9/W9HXQjMOD1jKtoKh/g8VbTX?=
 =?us-ascii?Q?X2FxgfArxSPaFCEpnnqTBxBcpgDEU64K2K61A2/TqhDALgMEpgvBL9h62CMx?=
 =?us-ascii?Q?vkHm/W0nK9VP79QRcK2D6EAa3llDM0YbYOdxwPy+ABY+yMvi5M9lR56ADk6N?=
 =?us-ascii?Q?aN96VuQB7V4Jv1QhdXYcFERmln0q28UdKXKWJE2KHrUfnMm6IzIp9kPccpgU?=
 =?us-ascii?Q?gT9LbzNdmjECXOzUO9tEfchVOW7/9PuNb9g5WFJ2zIV+h4AAbhobOK35P+YP?=
 =?us-ascii?Q?nabrhQIj7MNQPejw4Gh9cZ8bDiWmRJ3SNh1pPsEOzt3acABW+bKdyzP9Rioq?=
 =?us-ascii?Q?TEqopPKJzgmoin6N5Mio6KnpBlAploTEcPFTBU0+3ZzQFAEPKW+gz9Q5DUL7?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed3f35e-e9d4-480e-795b-08dc1788e2d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 18:19:47.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xM9/QSX7mIjAJQxWTcDOQdlbaWKqCwR3IXSkVvPbavj2RfUZs2chQKNEqjKPeVIfPlhJ9Uqr5xuAHWjsO6y5vCOtKhVSfYdO9kTCYv1U9Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8262
X-OriginatorOrg: intel.com

Robert Richter wrote:
> On 14.12.23 21:25:19, Dan Williams wrote:
> > Given there was already one bug here around passing the wrong value in
> > the cleanup path, remove the goto with the use of the __free() helper.
> > Note that since the cleanup helper only passes a single pointer as an
> > argument the auto @tbl variable needs to also include the @dev argument
> > to devm_kfree().
> > 
> > The open coded math to shift the port->cdat.table to the relevant part
> > of the response buffer is saved to a follow-on patch to cleanup.
> > 
> > The "devm_buf" scheme can maybe move to include/linux/device.h one day,
> > but the expectation of using devm_kfree() in an error path for the same
> > function that performed the allocation is a rare pattern. Many
> > devm_kfree() usages are at object mid-life or end-of-life time, not init
> > paths.
> > 
> > Cc: Robert Richter <rrichter@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/pci.c |   29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 37e1652afbc7..dd938a60a2de 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -606,6 +606,12 @@ static unsigned char cdat_checksum(void *buf, size_t size)
> >  	return sum;
> >  }
> >  
> > +struct devm_buf {
> > +	struct device *dev;
> > +	void *p;
> 
> Maybe just name that buf, the accessor would be rsp.buf then, better
> readable.
> 
> > +};
> > +DEFINE_FREE(devm, struct devm_buf, if (_T.p) devm_kfree(_T.dev, _T.p))
> > +
> >  /**
> >   * read_cdat_data - Read the CDAT data on this port
> >   * @port: Port to read data from
> > @@ -614,13 +620,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
> >   */
> >  void read_cdat_data(struct cxl_port *port)
> >  {
> > +	struct devm_buf rsp __free(devm) = { .dev = &port->dev };
> >  	struct device *uport = port->uport_dev;
> >  	struct device *dev = &port->dev;
> >  	struct pci_doe_mb *cdat_doe;
> >  	struct pci_dev *pdev = NULL;
> >  	struct cxl_memdev *cxlmd;
> >  	size_t cdat_length;
> > -	void *cdat_table, *cdat_buf;
> >  	int rc;
> >  
> >  	if (is_cxl_memdev(uport)) {
> > @@ -651,26 +657,19 @@ void read_cdat_data(struct cxl_port *port)
> >  		return;
> >  	}
> >  
> > -	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> > -	if (!cdat_buf)
> > +	rsp.p = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> > +	if (!rsp.p)
> >  		return;
> >  
> > -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
> > +	rc = cxl_cdat_read_table(dev, cdat_doe, rsp.p, &cdat_length);
> >  	if (rc)
> > -		goto err;
> > +		return;
> >  
> > -	cdat_table = cdat_buf + sizeof(__le32);
> > -	if (cdat_checksum(cdat_table, cdat_length))
> > -		goto err;
> > +	if (cdat_checksum(rsp.p + sizeof(__le32), cdat_length))
> > +		return;
> >  
> > -	port->cdat.table = cdat_table;
> > +	port->cdat.table = no_free_ptr(rsp.p) + sizeof(__le32);
> >  	port->cdat.length = cdat_length;
> > -	return;
> > -
> > -err:
> > -	/* Don't leave table data allocated on error */
> > -	devm_kfree(dev, cdat_buf);
> > -	dev_err(dev, "Failed to read/validate CDAT.\n");
> 
> An error message is misssing now. Could be implemented after calling
> read_cdat_data. But that duplicates code.
> 
> >  }
> >  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> 
> I am not sure if using __free() is more safe and better readable here
> at all, it introduces more complexity hidden behind macros and
> compiler behavior plus an additional struct and __free() ordering
> issues, just to remove some gotos.

The additional struct critique is a valid concern. I think that really
wants to wait until devm has native cleanup support.

> I gotos are 'bad', a helper function could be implemented
> alternatively. On the other side, the existing code look straight
> forward.

I took a look at elminating the struct, but it still turns out awkward
particularly because of the fact that the buffer to release is not
identical to the port->cdat.table pointer.

> See the 2 direct comments to the code I made. However, the
> implementation itself looks correct to me, so for that:
> 
> Reviewed-by: Robert Richter <rrichter@amd.com>
> 
> Should I rebase my other CDAT patches on top of this one and send a v3
> of it?

I would say keep the goto for now because your cleanup to eliminate the
awkward "cdat_buf + sizeof(__le32)" makes it easier to use cleanup.h
helpers as a follow-on.
