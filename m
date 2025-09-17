Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C1303A21;
	Wed, 17 Sep 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096915; cv=fail; b=k1VDhY533Aw4eeBMHc6oKMaeO9GtKXkdBdIPdM2oe5D7BrmnlroiMLewKSczCUJs5l+65fc9XzIUPMtazNj+GZ80pW/I5okDXpkP8w01EZDOET3yC+r/fF+gWdgg0JUIFHbElbVI70S+TcD7zyoVXefjvAQSrFB1oFbvEpmybTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096915; c=relaxed/simple;
	bh=DiigP2xsds+y9mTTrqDXPsoQGKF8PCCkd4Cmw0pqFIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JidY8S6Z6UBfSlhpsJbRjUkb2VB3Sch727tOfLXxaPidke1KggwcQNlyst/rOMt+lyzvdDMaLmniY+3s616rt34n+ghZ9dfQB/r6gI8rSw2+C947i5dSvKQ7Uv10ZTrkr16tvmRrMiwgn7BAtF2FDt9MgE0urluSrhcWEJuvpCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZFPg4jHf; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZFPg4jHf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZekIESjnlAP3IXs6xWn2whQQE53VbkcYFYNCxa4+Cmt66IIAvpymL6EdEkom3gHUkZXca6JBiA9xSCJYpQTlcss/Zip6fmix4/WC7mOgx7Bli/Fxgxt5EYzXLSGHhUXelJNYqsVyQTCUWo2hwsWfkND4D9ePGL+5yNqrVA1GQqQvOr679xXueDlJbvyFqJCpQ8+FxU85m6riYuclEGh4F5K//pazJM481EUZ9sYsQ0ZMA/ixHZr+ml57G8VxYZkm95BnYGN5Rwrw9qi1Z0zvLkb8gKgZyL+hvA5c3BfBO7+ExQH908SPB9aQbAEfRiUo+8fIR6uGqHZ3bmeRPPm8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpZx5GvTmS8EOFYvsWFw+W1sc9oqJudafcMHcWEtCvc=;
 b=cq1VpVrYRFXMXHETwcuQxOypvE6nwFlT3DKdG8XF0WiREeApKA9R/kBjrS3+aLJlDOubAXVaEevpnVbk2/lCZvEe7Ad7AJPpw3aq5Qk1Pt2lsIPvMtj2S3RyAi8HyxmJglw2E2Yc4IEmwmw4IeU0oOpljtzOWFxL42pxk3/A9EW61whf7gp//SSUywIb3IYeBL8OvIlfBZycc4THWa5eS+LCBittpfVedX+5gCivoWyH0x9hpTc7zKlpsX/mcXobJLY/V9PQSOJqiCcYsQRKxttKY8FnKi0BAETsTiFIHHz3nqr8I12M4t6fKesdiZpXZAOCW4LJy0bGF+pPO3YR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpZx5GvTmS8EOFYvsWFw+W1sc9oqJudafcMHcWEtCvc=;
 b=ZFPg4jHf5P2wvJYP0EEBVo9MFglFt0UJnLbMOiv+yMfORecaeIIBS0wX/HCV9Le3j/5mAQnVspZAfz79522b7Em5+AsDRBcsIhsrDH8iE0Ohn16PuGBYZedDxv4MtMQCl6kVJfUUsMz+0GNFf7mLjodfEyZzKxGOzUi62AeSWUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 08:15:10 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 08:15:10 +0000
Date: Wed, 17 Sep 2025 10:15:03 +0200
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 02/11] cxl/region: Store HPA range in struct cxl_region
Message-ID: <aMpuBypN42be3ruR@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-3-rrichter@amd.com>
 <20250915112341.00000ec6@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915112341.00000ec6@huawei.com>
X-ClientProxiedBy: FR4P281CA0297.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 4972d352-ce47-48b0-5b05-08ddf5c251d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mzIfQCHP/jjzDva8JAE8MEhJyIQPp/qgU1EqRGsS6hEXRbr+mBVfUVdvur9J?=
 =?us-ascii?Q?pYXxywJU5dVJa8E4v7OY/hfq96HR6DRb9pWZTFeKoF8LJxS2HY4gqCYPw4eM?=
 =?us-ascii?Q?x6hQBLBLhMx9in0AHcanMTasOKDPMF4jqky1Vv4DYSuU78TWcyO7eKBCmA8o?=
 =?us-ascii?Q?vi/sqg5YUIS/MHzTPvr/oYTWwlJCpt69C+xCTBh33tfsQ3n+CqyEw6M/2ee2?=
 =?us-ascii?Q?gIdr/ySq/g+N+mDphxrj2FroTJVeNjh7g8u4Sl0g0ewKLtLG95ep0AN74n1T?=
 =?us-ascii?Q?o+pkOxzqPSijKarv5yX6KEgNn5R6IJk6q4HNK8q0taQTQBodixrnlBjIaM7f?=
 =?us-ascii?Q?o2FKtZpsFr2z4641vAKm738P9Qn2JUPewLk0LTQUOyTa9VeQA4bLUXBDmt1V?=
 =?us-ascii?Q?Qolktvjk/ZNYp1ixF2bTBVt6q89gOgyWH6B4EdFOD2wV8j/Zg6Nn+3bH76ua?=
 =?us-ascii?Q?Ejuzj/Pa2gMkevIE7VNbyOQZ2Vj3+RPLSYR/4A+R1/e9CoxbtOmtmL6esNpN?=
 =?us-ascii?Q?wpTMthxpW7gnghN8eue0Sp6lFThASjaASTfVEmkK5OxED1RkYblQa9/fq4lf?=
 =?us-ascii?Q?m5+BUviJCKKy+mpclIaxW3SrtHuWnQ4Z1TG3dQWYzIL0t6uuRS5rv6MIIgd4?=
 =?us-ascii?Q?vLs78BJ395PzYwlNkLcfxYXndvTB919CQ1wuBtPaD+ihqJn3/O0Of7AFNKel?=
 =?us-ascii?Q?UHBuoYiZDmPYXRWqeGrh9v58p4iVJgi4Yo/D3hd2W7JhF/m6B1up8b0I8iJM?=
 =?us-ascii?Q?4yQcpA8KzMFa/lnCwBX/iSidheb8/JxI6LLss3+dqBKH3eRL/2sIZwBsdtLD?=
 =?us-ascii?Q?Kq2JYEe93GbWc/crmD15/cMsDLXugm3WVWP0REHmMmgXLBna8Y3eRUI7hfdX?=
 =?us-ascii?Q?VXuBEvAZRZI/7NXglDF+wxoARRnWwRYmD6wQMA4gHykWoE1QOyZTtjH3eu5y?=
 =?us-ascii?Q?E+ltAHQ3kFjWhd8wCwnC1qDcbYaUZifuVsG6Qc6TzcxrTMZkgsY0aIgrVtIV?=
 =?us-ascii?Q?JfDQJoYN3D3v5rDGvxU1wmwLsvsLQfYuSctDs4SYuCMeqIWvHxrSMSs4zdlg?=
 =?us-ascii?Q?D6HqoMD+5ioyJUgpvVHUDndtmZdE1d9ZGdRfjYidPvr8sA6Eg/24AvaJsXHK?=
 =?us-ascii?Q?VYEZQtclGdqTyeVInPPWL5iKpUOejYnrDiDhxLcYzv9yGUVDYpClBo0SMydD?=
 =?us-ascii?Q?GtYTAqSJzJD6QjJJWRN7sgoUY3HKpkxrUPop9p3rOHiPvKM/jIx1bzBauymY?=
 =?us-ascii?Q?7emlSipGl5l3DVnJCVavAWLWRHdRTTlIhRANyR0nx0UAAEs3XXRsCB66sw6v?=
 =?us-ascii?Q?8pSSJL5J9JRvdgUXBTZPBHddw+7+2ASw99ra6O46rZaolIGQV7N61fDgskUN?=
 =?us-ascii?Q?ABp2jTqO+lpDHdTnNb4KCrqbs1l1QinESR6SxVyjnp7dDNPGRS61O7Yy0842?=
 =?us-ascii?Q?fLqVIdd5ioY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Atn3oe68ZnsVGU2hVVpaN9qWmuxWNrpN6tLGNMWyAStEDkap8hYUBDjGPW62?=
 =?us-ascii?Q?/u9st0AolQE3VEonqYAFD32hBLPKQ1h6Vfn2wudUKUPaypZdBaPaoGDnU0w1?=
 =?us-ascii?Q?FevI8OOp/zpD/KQw8ISWWgD3XlViCXrcB6sF9+6Yfp8mWL5qAHYcsrlIjQnr?=
 =?us-ascii?Q?ZF/+4Sw0jmnXLix6B08Vg539SDHZsdt+/35GsK+JJ/KHp/GqylWXWbSFF1bR?=
 =?us-ascii?Q?lR5Nagg1yc9532sflwUR+1nhNoHI34PygRD4u1UT0QD307zDdE/PoSBvPaip?=
 =?us-ascii?Q?hUzWsu80izKBsDmBXU3DVcf1EbVB7WAbOdj3wGTBpKtVXnmPFLE3K/y0zHJ1?=
 =?us-ascii?Q?IdnOFdmeilbld0smkruJ3gsYeKb/V0lEHMJJvSadYBnIk+S9KQJXMrFE5IHg?=
 =?us-ascii?Q?+oTbgEyPT7ManCqpBmpvocd5DiJpenOt9v3cb6V4k4imHs50e08lJckDd1rc?=
 =?us-ascii?Q?k3EazhxuOplx0j/RmE4vT4XwLM3LfCYXzvq4f2dT06JcnZOm+Jw3slNVKqyU?=
 =?us-ascii?Q?m+gXI7SOVv9WaYvoURW7mF7vS57DzWM4V+4peZz8Xn0Dq2SEpCo09M8cg2QJ?=
 =?us-ascii?Q?GBqBeST4tToPDScL8SjV+uiBWGahbBTF/jWhw7vdBDguE7X8byvcrMO62OV+?=
 =?us-ascii?Q?eGGjtXCjdDAbciAQ/badRveabFYbdQCAQ2HtciQZit2vOmNW+W0gxtMfIQBR?=
 =?us-ascii?Q?nm3n8TSlrZ77OHLrYJ7seqmswa0zK8SGa0shNjFI+HCTqxYQC6S6v2vqGCM9?=
 =?us-ascii?Q?iCLrEbVa8qTTFvBpdQinSFibtbNtEQluvb31uVvuwr8xaCx5rEvzRPCvValL?=
 =?us-ascii?Q?uaY1jOCo7RWUEVKn3zQSRqzd7VcIBbNHKVOdHHlic7tMMr5McunU+xSjjmks?=
 =?us-ascii?Q?Ro/wDlrJAH50DROuM37/P0aK46ZsjKKCrBI+ryyZRg+EcXr8Kqa7tUAzvLsb?=
 =?us-ascii?Q?s7GwNKcJNCtSSEsmnOUC1/sNo3Yo+QT3/RcS43lke3Eq1fdrKtwAqMrrUBup?=
 =?us-ascii?Q?pbyiPB4wgWZR0Qa5dwuWAZzrPT0tYnwobAX82QRpn7gSR/tkqxIP8UcJpyO6?=
 =?us-ascii?Q?fZT5H4NJXzY4UiiqiHI7KHPoIkX0zXd/4znTv7aBtxic8h4G/tQ1y1q0aOuS?=
 =?us-ascii?Q?+s8DabOUocJMBwDAecAZKjfS54RENd7DjQj9Npj2qaYRcgRT9Bo29NnvUyLC?=
 =?us-ascii?Q?hYVG5XkXbsodP7bzfhmdZiBUsy9Gki5mtzd0hvigHlDEoW+J3ZA5Dmh/38u8?=
 =?us-ascii?Q?2OMn/cSX4Lt9Ed+AfUqncb5HEEu5D7yJRmSx19J+smdk7FOujgorB+nd0LEC?=
 =?us-ascii?Q?l78MI5ROxE5ptnRW82zO9ndAFGm+jcWX7M2Q9c0EJQU76OpalFx85eEfkHzT?=
 =?us-ascii?Q?n0Xm4vivwaaAb80hUEZ2XfNDI7C1A1SeJ1Xv52lvY/Xndko/jo0njBqhH7TQ?=
 =?us-ascii?Q?/cDiRC5Akq0zqs6GhjZfXTOiwBvGqdZVFH9I9PRfZuME264KWPhl7gPNnf4R?=
 =?us-ascii?Q?qnExYzMDmRAlrDFtSwAjRv2UA0tP9omptooCSAZArta/FrI9JjYeYkbMJtbM?=
 =?us-ascii?Q?dwTL0S0dFXKRjenRbG1ejAjSCZQaQYmajSL+24Ak?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4972d352-ce47-48b0-5b05-08ddf5c251d3
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:15:10.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewaIEM0Peaj8wQNQ2ZAmSSr0Mni+Q/WTfJGa5cLPdUblnOogUhy7MdLG6GKOmRKJCWRmxfIIig5qMI/lL8psUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789

On 15.09.25 11:23:41, Jonathan Cameron wrote:
> On Fri, 12 Sep 2025 16:45:04 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Each region has a known host physical address (HPA) range it is
> > assigned to. Endpoint decoders assigned to a region share the same HPA
> > range. The region's address range is the system's physical address
> > (SPA) range.
> > 
> > Endpoint decoders in systems that need address translation use HPAs
> > which are not SPAs. To make the SPA range accessible to the endpoint
> > decoders, store and track the region's SPA range in struct cxl_region.
> > Introduce the @hpa_range member to the struct. Now, the SPA range of
> > an endpoint decoder can be determined based on its assigned region.
> > 
> > Patch is a prerequisite to implement address translation which uses
> > struct cxl_region to store all relevant region and interleaving
> > parameters.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> Trivial comment inline.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/region.c | 17 +++++++++++++++++
> >  drivers/cxl/cxl.h         |  2 ++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 2c37c060d983..777d04870180 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -664,6 +664,11 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
> >  		return PTR_ERR(res);
> >  	}
> >  
> > +	cxlr->hpa_range = (struct range) {
> > +		.start = res->start,
> > +		.end = res->end,
> > +	};
> > +
> >  	p->res = res;
> >  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
> >  
> > @@ -700,8 +705,14 @@ static int free_hpa(struct cxl_region *cxlr)
> >  	if (p->state >= CXL_CONFIG_ACTIVE)
> >  		return -EBUSY;
> >  
> > +	cxlr->hpa_range = (struct range) {
> > +		.start = 0,
> > +		.end = -1,
> > +	};
> 
> There is DEFINE_RANGE() which you could use here
> 	cxlr->hpa_range = DEFINE_RANGE(0, -1);
> 
> Not sure if it is worth bothering though.

It is pretty new. Given the wide range of users of DEFINE_RES_*, let's
start using this one too.

-Robert
