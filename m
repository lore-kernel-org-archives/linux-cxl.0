Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4772D595A;
	Mon, 15 Sep 2025 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921267; cv=fail; b=FbWlzRceytSUU0S20+LK1uvjM/R5HpNQvtSAlnyShvDOoQmcm6YPmWqyG82ir27IcaWNbZuLxhpj/+IjxUTnip66C11TFrTwPm82dklbt/xdn2yW+3xHzTt6Y6V3ktQ/r9/CzIiLFh4LcA7ZvIqlv9ucJw3byOHXQ66zoRFdLA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921267; c=relaxed/simple;
	bh=Orf080OC7XyPokmNSKAvhcPU9dgtcr8YTwNt8aDa484=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HHyphicYS5G7u/zrOyyu0gKxATO88CeSrzPox96b/GdUEBpG3MfEGPO6haHgmv+3fAqApbLa6VsFdBX2vxE9eZm52whxnQA/DvBk4+uK3m1XDgcPPPuVPipBazht6Qk6xTQsPc61hMMvHrcU4EFqXpu/f/MDK4qJK4a/oWBLvzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sh9mORS/; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sh9mORS/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcJ7G1A67f5R8ao7fdETaVCevydE8B3ibbQ/xdzoWTC19A2l3lyah2ykMW3rFhTs5IiVsaswBfBLHcWFzC68xjmTKSE5SF4de6ZWqqUpQK3fBv8O19kD4sNaGvQp7S/qwpydinNs4ua9SqTIZ5CZev4+F8tDais6EHx8GCAbPxNreoHULjem/3Oc7m1tMoEnI2KbW2MHQICJFwrp8upLlsi8EoZ/XaRXtGOdFTY4lXeCGE8L6XoNOG8AXW0iDI/zZP8sclpHOOz7mk+PsFzoAQ7kvnqHcJxWHznL6qBaDn8rP3e3l06QvL+yv76JAe8h0gJLMKGfXBOK1vp/REhCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYFiSYApH4XeF3pUdEuW4m353dfqWpLhj++oBy7Oun4=;
 b=qTDPkGe6VNZUs4k17aFJtgbrFNwRv82ssFdQcPBdDRMLXAGO9GE/Mcm1f8R/+cJ9UA52/4eyYKF50MPuonPel9hN1mcHSKWBPT9mMF4IyQns/LzA3BVHLMmvwM+Q6lDFGvSGG9aam5NTmOqbamJMhY+JwXqS5d4+TeWCEWkpybzQbS1n0BLF74VAfcNwUEJkxNRfsiaZrC4LngbIfgOYrprsRMnpO53/TWgO0MUDu87waPgIs0s9+I/8mD0/sdga5yYm0rV/96MMSXOzIY1PguiOeTBAzj+xyo7eb9bgueQjqYu19u4xsApQXm1VSsekToQJdm+NAc4r1f8Att84gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYFiSYApH4XeF3pUdEuW4m353dfqWpLhj++oBy7Oun4=;
 b=sh9mORS/DBGsKCKa0gyEcLJVHXSE8XBW+v1B83hlS6cmttTvJV2R5eAAwyy/No+SZfQqmFV2eASWUViCYB1NN4rkLVyULdFSmAhzKIXC86y1xNcDMwNYOdO4Ji/IdvtI5SuqMMfsL7StV0DaHClhg33gg2TcWFdjuNELiev5sg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 07:27:43 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 07:27:43 +0000
Date: Mon, 15 Sep 2025 09:27:36 +0200
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
Subject: Re: [PATCH v3 03/11] cxl/region: Rename misleading variable name
 @hpa to @range
Message-ID: <aMe_6Olzsx9iYxIO@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-4-rrichter@amd.com>
 <60f05a02-6a0a-4616-a2f2-d7ae5709d94e@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f05a02-6a0a-4616-a2f2-d7ae5709d94e@intel.com>
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: f214ce81-5ceb-4ac9-5f3b-08ddf4295bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hIA4r95pk+B6d2+FzP+s06fZacPNd2Xa5Ys4uv/DCbwt3cQEfTTAMjD7lrd+?=
 =?us-ascii?Q?+Y36f8G7yB8JpveNdtY+a1a4X6/IMOiBQ4Axz2u4M8pNWXqI44GqKxk1P423?=
 =?us-ascii?Q?dLnqay4w9Zdm128ujrDpAehqHA7TNljewnDhZrZsoUGRBUx2lRPnBEwGEAvh?=
 =?us-ascii?Q?41tEuduBflrrCHt1YWdGw3cc1ureUX2Uwp9ATR0SaCiQ6OT0JJ+UKIh/7UOp?=
 =?us-ascii?Q?cWlTgJeLWumGb8zpsfcVAYvrnxHHTSYSvrxRRLHjsPaiFXBLuOlGzGtLG7hi?=
 =?us-ascii?Q?JVvAPHNuZylWPUHrLNn45whEmnsl5uuzw1/n84luWyrqJD9CImwRAnq3LjrL?=
 =?us-ascii?Q?1437TmnsQGmFtMSui5D43pXysDJy+Qh45HBazJjRyUK/KI8fQiBB+mrO6j3t?=
 =?us-ascii?Q?cuAmNgF2fGFGpeLYJ6c4D06468mdtQENwo59rIM/42w16YiFlXujXHeBwQBe?=
 =?us-ascii?Q?vCpEK3HRZDcVvoyA/KJ+50zqf+O/HzkU7xCrILP9HF5ygBQyb2RoLfDiNukf?=
 =?us-ascii?Q?LzdXpeHBU+j1EIcQxllh6iBJVl9pWycm7T3QcHBDnPVAoTt0lbPQBVpRbuGU?=
 =?us-ascii?Q?KLz3U565FY8L6vV2cYT3ep6/CThhgIw6yvKT6JXsMDs40VBgNpMZtkUoBQ3M?=
 =?us-ascii?Q?Y6GvvpLmik1fEs07TzTTLd2jUCjxR1CGZFP//421Guk/YtGF2+Pf+jom6JUZ?=
 =?us-ascii?Q?TABYx+kvA1WGOL5qonCL7vQvAjxmDIfFVxRE6PeyR/wpF+VbJQkWC2n33McT?=
 =?us-ascii?Q?bS5RztzCq+M1C8NlTg9odqSMWoPHh0uB02mrL+qJTTlXm8Bf9m3Lf0R8jdyT?=
 =?us-ascii?Q?XO3qfo6rFtA9pOklUXLzJYzeIuHC6G7UqCRj+Xsqk+79kJ6LyHKM859/XgOz?=
 =?us-ascii?Q?vjlCg0MuzmnxfOXVTYQSUknI1OkR661G8Ac51tSwcNfk7T5MoY9assByHdww?=
 =?us-ascii?Q?AbvmBFdULceIC8O8GbkhcOHvJeCfgyZSBMfKJdsXrrBd5e4ctKCRcnPzwVru?=
 =?us-ascii?Q?rJm8EzB6ypTqjQEFEuDoIL/uDIXqp2e0K3BseAhNn4g9QUmNp9U1KsP474nW?=
 =?us-ascii?Q?ZTYFOubt9qhlBiQStekhQ7NYgIukjQhOtv0mXYm6lJ70OxzEWaHrwyRev9G9?=
 =?us-ascii?Q?a3uSGxOgtV2quZnH4Rj09PLHF7tHQs7EXGVgSkAGiIsf1I6mQ9oVpzWqeqM5?=
 =?us-ascii?Q?Hl0klSJAUXPimm/bqoFdp/6Y4rabsR1DK1J6zjT7O78AAKb4mu4F//jh1H/Z?=
 =?us-ascii?Q?81A23Po5Q2AzPHxlroZyNyBSlX4Af7Q9n8kCyYyo1erEDM6YI1BDajyxYdQ9?=
 =?us-ascii?Q?U61/Vf8aMKOpMJfbhFUbCN9VPgU7maZnOxa1EXBSyw43ETruLxEi42AfCYfo?=
 =?us-ascii?Q?Zob78OsjegfMIb9drSDriLmlJBpF4n5XywscYU/YjlO/axHwkRXcjpYU/QHX?=
 =?us-ascii?Q?zgZz96H+0Es=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yEFnGVMMRGs+6cJHCVFC7D660X1wbHHwdb4CIIzG7EYiplW2a+LY3rUY9RgI?=
 =?us-ascii?Q?/7lbSpXblmDMcwAfIPW/WfCYeLFSTQab/GDndDcv9t50nwq3DrDUDkdj5HIo?=
 =?us-ascii?Q?t0yKr0Eg0HVs4BYSZEZ3/3mC5XC8O7zAs+on55gTXK/Q6S/EQ6BFkwRPEfwY?=
 =?us-ascii?Q?HW/35P11u/CLtbsIP8bMeSFjxSGM4iwtkY3lR7w5ciIB0DUDh95bPV8xMkQz?=
 =?us-ascii?Q?9fSIHaXU/9k1J+V1HRZIzzwrUTfUO9VQQ8rS38RTOVe9zzZ0Aaq5fFgjRBU1?=
 =?us-ascii?Q?y+437rtH+TRfnLqpXqyZgkNYPybqKpIVs89t65C03wLcl+7uQHUbiDYvg2jj?=
 =?us-ascii?Q?fDJF2HxZBtUtUjh8yawqSwgLkybljJTbvZPGWNH3rTD4+nDvgeHugEdqrIZx?=
 =?us-ascii?Q?mWur43Hm3M2KkFiAukZNYrX9eRn8QM2PIaTvtAwxf1Bx4FfNNaY1pz2KGymr?=
 =?us-ascii?Q?bAibSlRFcNUR3QQbL5DYapwjMrtMOKpMo4z6W8pzdKQQ5ja2fdhhhBX9XtQ0?=
 =?us-ascii?Q?6hadN6CMvwcrpgN+2Bok15t0Ag23kOeWP2h/6wrHpZ6g6O2iU8Gnm+GlTJPO?=
 =?us-ascii?Q?kVuTVjywW0cGR8HrRMyeRCEtZpWuvo2fvS9H9iVkYslLvUjmsLMl2QMYKY5d?=
 =?us-ascii?Q?qqzrN1j6IIPe+TUjKrRhN5CTqUzdNucPG09J72S5/tWfgkkU4vVX1DdkeV9o?=
 =?us-ascii?Q?XruC2u5L2diympb6yauzENPh/ZH5oD5RCZ+FPRFRWrtc4uOhq1RQXKyGNrtC?=
 =?us-ascii?Q?hxkrpEwrU2XASEnoMZNjKIejnHrBobjIy7hJEX53lccg+oq8JiMu53Ae38c6?=
 =?us-ascii?Q?3E/Emm/gULSD+C21mQjrXNiPA0zgyWlY4nEdvCMFa3V5pf7SGYItW3M0PQ+9?=
 =?us-ascii?Q?J3dnZKuX6CP51pBxTX/bdjvzD7lD0HofQUXrveeEhJeho7C4lO/WBa18Zymz?=
 =?us-ascii?Q?bAJ/fZwwhcNo1rHa1HE0bDW4BgoZG7DkqFi7PWOiDFc4eKaXrlOjLy1nqKZw?=
 =?us-ascii?Q?6TCcHBeIwPpQONAfAag/XYVSTJWON8xal0E3hAL/LJjTEo4InLPd3WUiCJaV?=
 =?us-ascii?Q?bbgAf4zGFZtEdiKWyD2Qt1rcxMNKOPrGl6zoA9HulpPSWPaUwWNpCqrDVioW?=
 =?us-ascii?Q?2yuno5BW3C2GutMuhjaebvAuNrmouFu7wwe/mhn4ZN/TeOB3fb2/z1rUOXte?=
 =?us-ascii?Q?/YRyfsfLjRdyOPSLKV6HVSNjjPnhjgyI+Th1xHVkvfvrnr2JTpTKrcLISPeW?=
 =?us-ascii?Q?7GdlQeezCXwtAv2sxmh0kVLG7rZKkaLTjr7/lY3XqB7AUlZi7+SfSrOHjLMH?=
 =?us-ascii?Q?R1bngbE9qpI25fNDqMbV+JfHfaCtMqtemuqsIkWMmQrYpFCW/U4+h1uFq0++?=
 =?us-ascii?Q?36gk8FJLTWwfgEWICCP1zdDQl2K6gi82TLOU3dMCOiXF1ROq3+mgLllTliym?=
 =?us-ascii?Q?xJSaAKjomtOVCd8VUcH/D5bGQE00BYQGeaJOuhRGIHom2R3wE5qmLOEPqS2m?=
 =?us-ascii?Q?8qJuDmdFNRfTavt8p3j9vXdhq+8+Ulteycw/NA3/uTJmIGeplDyMWfVLEUwJ?=
 =?us-ascii?Q?1vvF+EcEi1wzmFMqSqQIYugyI9qAybNIewqQ3hWQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f214ce81-5ceb-4ac9-5f3b-08ddf4295bdd
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:27:43.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OYaqQkF4FTMWlTk0twww3tCmIc50PgooS8bYRTKlk6TrsBi0qGbGV2zSMDe8bmXhloWrfVgtwpNhXQez2pt3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468

On 12.09.25 10:33:30, Dave Jiang wrote:
> 
> 
> On 9/12/25 7:45 AM, Robert Richter wrote:
> > @hpa is actually a @range, rename variables accordingly.
> 
> it's a range of HPA right? May as well call it 'hpa_range' to distinguish from 'dpa_range' or 'spa_range'

To me this is ok as it is locally used only in the functions. I used
the short version to not hit the 80 char line limit in some of the
statements for readability. Range is most of the time HPA unless for
special cases, which use a prefix then. It also becomes clear viewed
in context, e.g.

	 range = &cxld->hpa_range;

Thus, I rather would like to not change that.

-Robert

> 
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 29 +++++++++++++++--------------
> >  1 file changed, 15 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 777d04870180..13113920aba7 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3367,9 +3367,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
> >  }
> >  
> >  static struct cxl_decoder *
> > -cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> > +cxl_port_find_switch_decoder(struct cxl_port *port, struct range *range)
> >  {
> > -	struct device *cxld_dev = device_find_child(&port->dev, hpa,
> > +	struct device *cxld_dev = device_find_child(&port->dev, range,
> >  						    match_decoder_by_range);
> >  
> >  	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
> > @@ -3382,14 +3382,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
> >  	struct cxl_port *port = cxled_to_port(cxled);
> >  	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> >  	struct cxl_decoder *root, *cxld = &cxled->cxld;
> > -	struct range *hpa = &cxld->hpa_range;
> > +	struct range *range = &cxld->hpa_range;
> >  
> > -	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
> > +	root = cxl_port_find_switch_decoder(&cxl_root->port, range);
> >  	if (!root) {
> >  		dev_err(cxlmd->dev.parent,
> >  			"%s:%s no CXL window for range %#llx:%#llx\n",
> >  			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> > -			cxld->hpa_range.start, cxld->hpa_range.end);
> > +			range->start, range->end);
> >  		return NULL;
> >  	}
> >  
> > @@ -3458,7 +3458,7 @@ static int __construct_region(struct cxl_region *cxlr,
> >  {
> >  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	struct range *hpa = &cxled->cxld.hpa_range;
> > +	struct range *range = &cxled->cxld.hpa_range;
> >  	struct cxl_region_params *p;
> >  	struct resource *res;
> >  	int rc;
> > @@ -3474,13 +3474,13 @@ static int __construct_region(struct cxl_region *cxlr,
> >  	}
> >  
> >  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
> > -	cxlr->hpa_range = *hpa;
> > +	cxlr->hpa_range = *range;
> >  
> >  	res = kmalloc(sizeof(*res), GFP_KERNEL);
> >  	if (!res)
> >  		return -ENOMEM;
> >  
> > -	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> > +	*res = DEFINE_RES_MEM_NAMED(range->start, range_len(range),
> >  				    dev_name(&cxlr->dev));
> >  
> >  	rc = cxl_extended_linear_cache_resize(cxlr, res);
> > @@ -3559,11 +3559,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >  }
> >  
> >  static struct cxl_region *
> > -cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> > +cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *range)
> >  {
> >  	struct device *region_dev;
> >  
> > -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> > +	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, range,
> >  				       match_region_by_range);
> >  	if (!region_dev)
> >  		return NULL;
> > @@ -3573,7 +3573,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> >  
> >  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
> >  {
> > -	struct range *hpa = &cxled->cxld.hpa_range;
> > +	struct range *range = &cxled->cxld.hpa_range;
> >  	struct cxl_region_params *p;
> >  	bool attach = false;
> >  	int rc;
> > @@ -3584,12 +3584,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
> >  		return -ENXIO;
> >  
> >  	/*
> > -	 * Ensure that if multiple threads race to construct_region() for @hpa
> > -	 * one does the construction and the others add to that.
> > +	 * Ensure that if multiple threads race to construct_region()
> > +	 * for the HPA range one does the construction and the others
> > +	 * add to that.
> >  	 */
> >  	mutex_lock(&cxlrd->range_lock);
> >  	struct cxl_region *cxlr __free(put_cxl_region) =
> > -		cxl_find_region_by_range(cxlrd, hpa);
> > +		cxl_find_region_by_range(cxlrd, range);
> >  	if (!cxlr)
> >  		cxlr = construct_region(cxlrd, cxled);
> >  	mutex_unlock(&cxlrd->range_lock);
> 
