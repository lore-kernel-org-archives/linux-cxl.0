Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F063939B9;
	Fri, 24 Jul 2026 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875838; cv=fail; b=riWH0XTJRzOmVzkes0Lt+reUGi6V3iIdap02GFsjZWwN/lfsEI8ykwngSaDHZsbAXrBkd0LD1A1d2mIHmNUmZiKErzGI0JrWJZtZuxMHoPZ4yC6kf1PLPIZXSIhkvXW81tjc2ZqWz1Mb/OqQVKxsAYPbNlNHMw6oDnyHRNelF9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875838; c=relaxed/simple;
	bh=wrFyEf9Ti9f4XXDqs9Em8fgbb4hON867Gtpm35RGA28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K/WWKjImYaBlDemqPt7y3SaxEiRjduTLjq5cCEZy5Aaxs89Jd3BmT63xZzeZdyfPXo2WN2lRd0nNttoqcEBvdvATduIm+cu/dJorofg18qOP+XjFKyHqlng4NaQpXFYc7eqwTS0TmV9J2DMXtf4rS64BwkCMyz8CzR0EytU1200=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pDqDHFJU reason="signature verification failed"; arc=fail smtp.client-ip=52.101.62.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pDqDHFJU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkjvoPq0WYJJIfmVZvmvdzkU8X2zGgAG+e2V9bUfOZbzuMs9DuYl4htKmQ0EDIM9UCTyqZGdsH6zi3BH0sXFsIe3/s60LUB0JHTXntN5lbX2wVP5iTteugHzQrdtMAKDW1k0SRWR+tOj9EDzM5qHg3+BnexKJPDM/YMJzq6VadXcsX0hv0Dm+qGqIuyxBETTAfU/sxrDyWK9s5rbBpYKzchZdTvWHRIUdhBv+WX2Ro4BJMtOtyqxrbrSddYi8kzbYqxZNNxu4fUVm+qGYDIuFG7GHO2ozWAUlyVm0m0ujWDgONTEsg5PdCA1gz0e1Z1RaFK9GfnwhCn7S3rOxfGLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiRCM0hv9BhTEWaoNiRRhm2lGWjBhV14xRmwZSs4RNQ=;
 b=N1h8T/GVvO5CY3m0E8TakBZCPfHv+fgG4LrZbrJe1KCKJfa1CwitxoFkPHrInbR9Sr1mEF3nQujKEU+QjYPiSjJCHCJ6Zw0oXAXpu9nkfgAfKXbTO//NpV9loTCxeu46oLNYPeB6ryRbJsYmCKuwH5GSWeb1bI5YNhKp2P1r+U+U/uQR0pDywgrCtQjRA+9Z0nIzLjQ4OV2lffZPiToWCCPbc5elNxGFtz4LayOOwg7O4wZwZbbgiX1ho/D3Ly+3rlBhsk0y53rV3mlvYaV2PC7TWiuWlU9gJVyhynD1or9qERxku1Axl7kzu/S3RY0fwulq7mj7fFE7+1v7Vfzq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiRCM0hv9BhTEWaoNiRRhm2lGWjBhV14xRmwZSs4RNQ=;
 b=pDqDHFJU5Y/WH0TdxU9W5Um4iVv3jDgcLUFmLSQX3Xmh1E/UNwLOkL6MNOjKPPFNJ0ODGtvihTdlZWXxq15OS/AIiFqr5tNvhx3TDI3v1kTXQeoLetDOaviHw+oeh6P/gz5y9L3Q8YnqyFBXA84dp8A8Rc3zSm1zyYE60yyzJewR6Kdad8vvOUx4DMBL2KS9WgMYJeNTb5+VPtAkzhr5u847NDPWJ/PeVR5CO2fFL6XERHPfzHdq6tiEwqL2pmDAjtTPDXiVP01zMDbknN7R+vbRdr9m0i9ivasbKEnaMFSMym6vESJxtzfbDFRtny9b95/0mgGfXI39v6HaiUyIEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 06:50:32 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:50:32 +0000
Date: Fri, 24 Jul 2026 14:50:27 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com, iweiny@kernel.org, 
	ming.li@zohomail.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, 
	Vishal Aslot <vaslot@nvidia.com>
Subject: Re: [PATCH v7 1/2 RESEND] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <amMIacsN91QDl9a7@MWDK4CY14F>
References: <20260721085715.39322-1-icheng@nvidia.com>
 <20260721085715.39322-2-icheng@nvidia.com>
 <20260722013822.57335034@jic23-huawei>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722013822.57335034@jic23-huawei>
X-ClientProxiedBy: TPYP295CA0046.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e10abc-068b-455c-02f3-08dee94fdaa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|4143699003|11063799006|5023799004|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GqsMzWz0XfT5yayBsKW1t4+JPcx7YeFWs/RDVbpNHkn7BYkzxRBDQxauvQsEzWi4iu7tEiJETre/prhjN+3Cx7B9ImhFcXdI2QMWty8/P6RfSBcmApiAHIeJIw9Y/YolbX3dzroiJRFMT203lkeXrMMPojRGL/KGkddYwgTGfv6nDPbKGYoAdlNa/6DzWXAO4XOjllE6QhNTdlyU22BVxWYhZeFncF4kOMcg3iOi8dyvwdu8eLHUrClH8arfRwV9ds/ZhBn0hcXXstmXM8rZ2vVjZ9D+pGn3vVehdgX910et7K9CJLg//4lIokmTaQOaGWgova0NnedDzef9Kt7Xxwnnupd5dDeUqBXPb7FGzFzzdA18k47pVw7rilZYh5Vhq2GHffkB3OP3nnXtg/zHzqFSg0NwGsEVU91x78rT8owv9U1QwLtRqtdPNK9yWj0DWYZmotc79PgO+wHvg/OqDnevsIlbfcfDNXmmyYXyogylTyJb+bbuAQkS+LXFN4owStmO/v45O1yAOBRBYuRnE5RNo509BPBlpnQYY6F6SYZ3McelJ8cNFlfiFXwCtoZ9EOjAJVCzuUCFDdw6cRsKzetGu2lsi2ldI/aorPric5loARqG4AmC5FfiCyTPQqq7/sRGHNnJnyu02AOW0DinAETMV5scHZBiWjNQDibeEnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?8urOXytfxyuj2rN1B2TZxtoCPzb6YhFbqbQeYdPb6DcJzaNJ6lhL0T07Y6?=
 =?iso-8859-1?Q?rh97YZ4PsFi8iknUl1+CDXMVUnR8bAkBTJya+KICnZa+fiTjRXj9d1EDx4?=
 =?iso-8859-1?Q?4kqNAtDAlCKTEZ7Kr1uurSfSa0Dr5SDtp/eArdDiagr6qkaKPRJxgTIHYK?=
 =?iso-8859-1?Q?e52DN50/f2sJPnZxyxqw35CUCHDRZ6ahSC+oPacwMRHWMiZZoIrx4NPBxT?=
 =?iso-8859-1?Q?2OSBR9SfJNEpBQ1MZCzwQ8sG/2gv0PMaoRPYO11SsLStRuV0+wZhJMEfX+?=
 =?iso-8859-1?Q?lGix7PuQYTtF+W3o7WXoRqcSlBj4jhQPtu/2DfjWPRJek6R9j2NpQO5DeP?=
 =?iso-8859-1?Q?R1cXBqH6D1cvxzjy0Qh6efDVdsOiQTBU6xzQuBG8YrmY1OTjbPlP5qs1RT?=
 =?iso-8859-1?Q?Lx5M/hDYa59sP91MmKHRUDjVIftMKH4LYVilmiZ8M4G47QUnwLqNIWeS9k?=
 =?iso-8859-1?Q?foaIhnR17iZTpCEhkWR8nQ9H77OafAIOAkSM5Gy7LWAebdeEj+LX+ds3dW?=
 =?iso-8859-1?Q?fj1UnFprTi349vSw9EjNMqTAtnypg3MF+Jzll09VH89c0biHKbMZbXlFUk?=
 =?iso-8859-1?Q?CS+bFhk95h6LLGa94Wa8btpkpcoMDL5YqcK1temg9Hi1u/0KxYqjHfMK8z?=
 =?iso-8859-1?Q?6F3GbmKqt5F+i8NLB8EPEhPNoSRF1tLAkN63ziQc0NBjtvuYLXpdOBbZqL?=
 =?iso-8859-1?Q?P80U70GmNoU2c1O/6udmJF19DprVy5OYq1qGZGZjS/HqfTYerPgLToFfv0?=
 =?iso-8859-1?Q?bojNdUOdrXn3Xr5ZcKyYQ7Kij1ucmrwThCiZDeGzHAjc/hiDGTWwPc/C8z?=
 =?iso-8859-1?Q?H0ar6VJ3fgOiIIC5x/F+lHJJhtk6QW2857FM1sDrW5S/rEUqsq2CR7amL7?=
 =?iso-8859-1?Q?agot+7fP7gpSXxsWNyJL1dsiy/Rh7tsqnSxsXHQjVe0FhoOLse3qu4lmyT?=
 =?iso-8859-1?Q?WN76pJCP1STw5nAsGDP66MmowNOLoHTJ6fRDYgmxHnWbpQzOdCbKqEIaSw?=
 =?iso-8859-1?Q?o+F/Vah8mBClWy3eEZvn8JgNAa34kBCImb6BTPLIF9NHGV7urFLFbgOWcQ?=
 =?iso-8859-1?Q?h7fGKV9sFIkGZ7cqgaF6dt2rvhVlucrsH//tFKkJvWCGZXtkvFB8n33PZk?=
 =?iso-8859-1?Q?i0gFQGUXsNxGzym2Y4qRQZERiDz6giAscqOBXUG70tzdop4otI7xmDGr62?=
 =?iso-8859-1?Q?NciHlBoSBhqCFMLsWEdJAXG36yJOZF1HPxNpTnrbIu4p3xvsM+M+LoIiz/?=
 =?iso-8859-1?Q?eLfZtgmrKfZrOaPuGtaQ0Lq+LUCRR3aP5E+BnmwadyPeuGDLz+Fm7A0h9H?=
 =?iso-8859-1?Q?UwaHB4YWyRdidIVCRzOi8Hq18dO5ewQZzYIGAcjNmGbZuhOGZyguhA6UY5?=
 =?iso-8859-1?Q?TqktU0cEKsZR5Jyhcw39fY+k5Bvh4HW4qSl9/7n5nWA4DjvSW6OHc/95vV?=
 =?iso-8859-1?Q?TCMDFZTR2Cahjjvee0jFmnXGvPfrqTJjUe7hgB50WSlJOha2Qebw3s0OSd?=
 =?iso-8859-1?Q?sSSclyinuEDUW74Ns7NX4x2ceY67uJu+DcutPxwUgxjMF/jh+I3dGUcN9+?=
 =?iso-8859-1?Q?P+P4e9PbbDLv1tQIHaOq9WYCpxAz6lI5oPM2IxAhA1f+u0cPPMxBGR/vHo?=
 =?iso-8859-1?Q?D4j6w5WgJ7rbuKLM7TGbBqWsN1uPH/diGjhGa77rOD6/WZzUlxKl/pocBD?=
 =?iso-8859-1?Q?GrgHLSxOUNNHwKDUUXc6Ws9UVmPStUnUDL9mwyCr1j0xWLgFDZqVAA14lp?=
 =?iso-8859-1?Q?vU496osKUBeyHf9Cl0KRD0X0tqMoKKWdTrMoQQz50TCtLQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e10abc-068b-455c-02f3-08dee94fdaa3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:50:32.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4jbe+iWlfCEg/KkHuwqVgYcSIa3P47V1Wtxy5HsQzwVZldHgel0xyW2gCAPL6zQjdKIXycSb1vm5UG9L7jpvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198

On Wed, Jul 22, 2026 at 01:38:22AM +0800, Jonathan Cameron wrote:
> On Tue, 21 Jul 2026 16:57:14 +0800
> Richard Cheng <icheng@nvidia.com> wrote:
> 
> Hi Richard,
> 
> > CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
> > ("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
> > with size 0. BIOS may commit and lock such decoders so the OS cannot
> > program regions through them, this is a design choice rather than a spec
> > requirement.
> 
> Trivial but consistency in commit message formatting is good. I'd always use a
> blank line between paragraphs.
>

Sure.
 
> > The kernel rejected these with -ENXIO during port enumeration and aborted
> > the whole port, so affected systems showed nothing under 'cxl list'.
> > 
> > Treat empty decoders as first class instead of special casing them, back
> > them with a kmalloc'd resource, since the resource tree can't represent
> > an empty range, and keep the skip and hdm_end accounting intact. Guard
> > the paths an empty decoder can't serve, e.g. region attach, DPA free, and
> > poison queries.
> > 
> > Suggested-by: Dan Williams <djbw@kernel.org>
> > Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > Reviewed-by: Dan Williams <djbw@kernel.org>
> 
> ...
> 
> Main comment is of the 'whilst you are here' variety. I'm fine
> if you want to ignore it.  I just found the existing code a little trickier
> to read than the ideal and some of it gets shuffled round in here.
> 
> Either way
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> > ---
> >  drivers/cxl/core/hdm.c    | 52 ++++++++++++++++++++++++++-------------
> >  drivers/cxl/core/mbox.c   |  3 +++
> >  drivers/cxl/core/region.c | 49 +++++++++++++++++++++++-------------
> >  drivers/cxl/cxl.h         | 10 ++++++++
> >  drivers/cxl/port.c        |  3 +++
> >  5 files changed, 83 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b..ccbab2e21f06 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> 
> ...
> 
> 
> >  
> > +static struct resource *cxl_dpa_request_region(struct resource *parent,
> > +					       resource_size_t start,
> > +					       resource_size_t n,
> > +					       const char *name)
> > +{
> > +	if (!n) {
> > +		struct resource *res = kmalloc_obj(*res);
> > +
> > +		if (!res)
> > +			return NULL;
> I'd format this a tiny bit differently but not that important.
> The advantage is to keep the allocation and error check closely coupled.
> 
> 		struct resource *res;
> 
> 		res = malloc_obj(*res);
> 		if (!res)
> 			return NULL;
> 
> 		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
> 
> 		return res;
> 
> > +		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
> > +		return res;
> > +	}
> > +
> > +	return __request_region(parent, start, n, name, 0);
> > +}
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1e211542b6b6..6c7d9a52707c 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2115,7 +2115,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -ENXIO;
> >  	}
> >  
> > -	if (!cxled->dpa_res) {
> > +	if (cxled_empty(cxled)) {
> >  		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
> >  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> >  		return -ENXIO;
> > @@ -2959,28 +2959,35 @@ static int poison_by_decoder(struct device *dev, void *arg)
> >  	if (!cxled->dpa_res)
> >  		return rc;
> 
> Whilst touching code can we just return 0 for this and the one above.
> 
> The return values from this function are unusual so nice if we can make
> them as obvious as possible!
> 

No problem.

> >  
> > -	cxlmd = cxled_to_memdev(cxled);
> > -	cxlds = cxlmd->cxlds;
> > -	mode = cxlds->part[cxled->part].mode;
> > +	/*
> > +	 * Handle the degenerate case of a device with only empty decoders. An
> > +	 * empty decoder can still map a non-zero skip range, so advance the
> > +	 * walk to commit_end either way.
> > +	 */
> > +	if (cxled->part >= 0) {
> > +		cxlmd = cxled_to_memdev(cxled);
> > +		cxlds = cxlmd->cxlds;
> > +		mode = cxlds->part[cxled->part].mode;
> > +
> > +		if (cxled->skip) {
> > +			offset = cxled->dpa_res->start - cxled->skip;
> > +			length = cxled->skip;
> > +			rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +			if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> 
> Maybe similar to below. 
> 
> > +				rc = 0;
> > +			if (rc)
> > +				return rc;
> > +		}
> >  
> > -	if (cxled->skip) {
> > -		offset = cxled->dpa_res->start - cxled->skip;
> > -		length = cxled->skip;
> > -		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +		offset = cxled->dpa_res->start;
> > +		length = cxled->dpa_res->end - offset + 1;
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> >  		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> >  			rc = 0;
> >  		if (rc)
> >  			return rc;
> 
> Maybe whilst we are here we can avoid the rc dance?
> 
> 		if (rc && !(rc == -EFAULT && mode == CXL_PARTMODE_RAM))
> 			return rc;
> 
> >  	}
> >  
> > -	offset = cxled->dpa_res->start;
> > -	length = cxled->dpa_res->end - offset + 1;
> > -	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> > -	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> > -		rc = 0;
> > -	if (rc)
> > -		return rc;
> > -
> >  	/* Iterate until commit_end is reached */
> >  	if (cxled->cxld.id == ctx->port->commit_end) {
> >  		ctx->offset = cxled->dpa_res->end + 1;

Thanks for the review, I think these suggestions are all reasonable, I'll make them
in v8.

1. Add missing blank line between paragraphs in commit message
2. for cxl_dpa_request_region(), I'll split the declaration from the allocation so
   the alloc and its error check sit together
3. for poison_by_decoder(), both early guards will return 0 explicitly rather than
   the zero rc, and I'll collapse the -EFAULT/RAM handling into the single condition
   you suggested, in both teh skip and mapped blocks

Best regards,
Richard Cheng.
