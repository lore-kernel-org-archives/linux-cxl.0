Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0078513633F;
	Wed,  5 Mar 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178920; cv=fail; b=jsVuQWXvyr6MYQHlksqRIPVOYVf4vIuiC4dXLX3NMrvEAbQdQGveo9UkNTQ2Ps9LIWBRV5q7CvRwGxlUWZ8NyUcQNnctQR/xgYUKQwaP+tfUmWRKLdTWUGwemHyKeRiqi/IBFSJycj55aXzK3oq8SvDRez1Qr4rGa7kkxiGNowE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178920; c=relaxed/simple;
	bh=KR9HDO8OPTVYgH5HEzgI0stjaYaOJidEqZttlKQEjRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oo6je36sEWnexMo0JNlIsuIYVsteYkqBEyafwxO+0OCcGdGawHD8AmcKph4BwHyQoY9l5K5KquPZmm/LPX8c2DIXvdtQk0wvntajLu9GFAyYasfHh+2r9IEPBjgKjYje+dMHGXfm1UNiQdiDb1hrOro8PJWRi0stNaF1f9l+hcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=40UaXlpX; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="40UaXlpX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Orci2b3oQmFOBqtxav4Gg578pa2t8aNWNEvytwLpQ7N3Xwwp+HYY1k6TYgowWjowdd6MBEbciuS8PmiDN8loe5dU7RilIZ3HgFOoZt15a8rUou+8EdNJ9jWtfpIokiO5mwFvJZnxyt6JKh3kLU9msanVKOdkzdzO/RNYgb9X1MyxifvszGNWgXd8eWSOn4Iz007gjqDLAL1YaGt6NMo0ahZK7bBslgNtXCZDV805eWAjl+7mNnMFWwxOj9e1e20+fTHVPc/bhESFHPAwECyvlsUVS3TiEUfmJBBvIi8OX5OoRwipC56z+XMRnYB1NSgjX5RsePSBSWgs1zdgEF+7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOoc6MIaYCUkL2Qd6R/lwOBleMf+Fu8kZH114VIF2bU=;
 b=orvADNTaczdmkIFTPJWIxrXJbAXKoh0YFIpOJ6bFJ45AENS9p47GueRHWJCyrnkRLGM64daFR8TGqmGNp60DhOmc3k7NCEMGCwaTFC+mdsuABvPAIcaSV4GL8Juvu0ebDA6ImIpgUF1axhDHBjnKOe3ZdoEhPMQJZJvdvnDTnsT72Buh9t6k/+uUdzjWCe6V1J++kYeUfP80dzBrB6K2tZzRFYnHJ3inclaloJFoKm0WkO3/mn8AVB62BpERC3oRHw7YMBlyLxi9EIR/ivqG6/n9ZXOGD2d/qwJDVPJddqSpRNjz9bNw39pDwmNUlMtcDdOYQJOt3ELytZ3H+sLhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOoc6MIaYCUkL2Qd6R/lwOBleMf+Fu8kZH114VIF2bU=;
 b=40UaXlpXOLpmApSyL6tMkzrFnhBCOC1WZolrw2sbbc8JHvJhuChcGImZDoA1wjL5ZAB9uI7UE+dvkKMMRdLqehiT8WjrSv38uYbn/chk/T1T6wvd6Fq7zB4J3A+97ZJ3d1n28vJzOOwnC6X6Bn9P1trMT9m7rq8LTJBczNCJaTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 12:48:36 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 12:48:36 +0000
Date: Wed, 5 Mar 2025 13:48:29 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v3 06/18] cxl/region: Rename function to
 cxl_find_decoder_early()
Message-ID: <Z8hIHQkMxrfhKlq6@rric.localdomain>
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-7-rrichter@amd.com>
 <20250214155808.00001e02@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214155808.00001e02@huawei.com>
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 870a8fa4-7dbb-4f5f-881e-08dd5be40b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c/xd16GXnnp4XvqlknUCQqX/30zdDms8mEps+8TRdmbY1MONnCbIfAiytTc4?=
 =?us-ascii?Q?T01PZqtS6PO9n8CfHBtgeVwmRjoxYL8GU8fyzRaZq/CjwdD70f02uIH5XMc5?=
 =?us-ascii?Q?W6CW8UgOD2MRiyVFjymCMblXVKzTAE+clSc9lQyhNDKdCtnxD26Ty90FLqCC?=
 =?us-ascii?Q?QAK7k1t5F/LsPII59LEgoxkc9AP895hm1qiA+2CtOvT6mX42KbKJwYxWvW50?=
 =?us-ascii?Q?NX5KQp3RxGTW+bAfwebDkBhNhrKBR9MZSw63HwTX7r/mouYKVWa2LM1w7Y6H?=
 =?us-ascii?Q?GSJllr9D8MpYcZnFk5Sh8+ViQsvjFAMEyiLeyIyFhj5zglh0mSMQ85IP4hes?=
 =?us-ascii?Q?Mu5HiO+vHc1OzWVrS0E+aVnuwq0o2BAvnRssw7BYv7etJUK0gwFtaSdxcKoQ?=
 =?us-ascii?Q?nXMuEPkh81i7KbE4blyLi33bkR/evInDCACmsPpw2R/zDfDBHyMiWsCYqq1+?=
 =?us-ascii?Q?0NUMkXDfWZxDaI9aPdhdZAfdQ9Mb/omvjGkFQUAY+jhhn1bO7q3zfeEttd+n?=
 =?us-ascii?Q?HBIEHpQWLaOzwhAPLOOPNAePrRyN17O5W2Z5J6+DZ8X5Br9oY5QOBkgnaBj1?=
 =?us-ascii?Q?dUZP6A6VSA57AuLkFi3oJRxqKndzr8ZzgvpX+f68n0ugX20AqNq0NThrQRUe?=
 =?us-ascii?Q?HiCh/I125De4g2Np1i7UcjoLuVbtkWlcpVDNPDi3K71P9qRFf0uJiBp1H+BO?=
 =?us-ascii?Q?ZQP4KCCQGBGELgXwFApFD89sxjJjrNc1GUfg2aEzsRjPjVLcIDKmjis0TgYD?=
 =?us-ascii?Q?Qc6v2m2phyTqGlvZGQfVhWr9GZ5Rmax5umtId1q9B9tk6tpK0DPly/a7SGEW?=
 =?us-ascii?Q?D94/B9ybsvmQDhIBnXj5FXSxGSZ3M12z97EJhjFyBQvHqrKO3QaObviRqQhe?=
 =?us-ascii?Q?VHTTB+5e0mx5TL+31yKliVkXBJyVSpixJsZWpZT0Zwqg5bVfTNyqYLEoDyMN?=
 =?us-ascii?Q?dWW2hqSSbOmb+FODW/76BdQEMMvVtYEsyZNc1CLXDzq4jsgYSsy0iBYEFw/H?=
 =?us-ascii?Q?ejGGlPINeE3A2ej0U5jI0ByXv7FZC0Eg+Umr0f2+zAwKwn10CLWU33fiNZ1M?=
 =?us-ascii?Q?1EYV1Gq77n1eaBbTyA1qRZ0vEqvOVO2Y/Bu0kIGpv2hPMF0ss5FKW1aYRXWg?=
 =?us-ascii?Q?dJfmzIUjrardzQW56kew5tD381ULxKpzj1yS1i/GWvRiJbZ/DQcb80/oV5Qz?=
 =?us-ascii?Q?r4xjxzOwH5Xh4pZpsakEjONQ8RmZLY0deeeuSZYsLw1qSPESheWXB2XR9rzW?=
 =?us-ascii?Q?YpcLp1nrxhHshksZFaIQzbokNbQ9Skra12Ech28N+9BXgH6/+WZ7RXp/qnEk?=
 =?us-ascii?Q?7xnL3kXWWqxYOUrUJkZyDXVzAtbxyccUfzXWQbeGPOhQSyU7sVKemVW9/71s?=
 =?us-ascii?Q?+jKkYFnreLUquNVrsxlAeZhhIxej?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IWOQ9ztmQbz2TQTR+NjHSN5jlmolJbsh3b2n7UYLIp9avMVpsr8uWjKJFv+g?=
 =?us-ascii?Q?BN7lVgMKwfoum+Y9xORyMwbUt+aFtse7hdqBdWODP3y92cW18ZiaBYBvkNTE?=
 =?us-ascii?Q?Ub7oZnRzMZkVlAlfaZP7XL/Z842v7hOxlCkB2C/dCfmycmJqeNHEigIvmguS?=
 =?us-ascii?Q?bMY7Pfk6mGbx9YzfEpbOCDbSOtamVGz0c95Hbwo7eIUcGpgFWnsd+KFSbuLs?=
 =?us-ascii?Q?RS5EOXmHHnvtHLc0SLa5qI8Ljt2HtBGSdvU3cnYrYV8DynInIycrWLhMctml?=
 =?us-ascii?Q?uPnhUWAyGDmNbipF+QWEPh0RweVSIWPuy9BIeLV644IHti+Vfn7BT6LyzE95?=
 =?us-ascii?Q?NNg0SaHz7EWcDESRO/snFRmbYa3jNQ0kpxLzWlZP8mTIbQ6d/ZyM4/dvgXNe?=
 =?us-ascii?Q?eKpB7FNKdc8XchDVTsGi0/p3zjICfHX6LuDzFK0yODPnEoFAu5t7juVLjeIT?=
 =?us-ascii?Q?Gqcc8fABEaJYxzSUey0PmQmyTe4PojvpyMZp0xRXuckrm6xXMNnmJ3ZIsVXJ?=
 =?us-ascii?Q?y07szQoia8448Y87exadBAdJix5vp6VxARr/59bS7WHl4K6uM6bwC672p9jv?=
 =?us-ascii?Q?Fa3aC78/3TzhOZDmGVDLVry/yIt+D4+yBHG2JQ+emK2m+ybcK/29AlMBebIW?=
 =?us-ascii?Q?Omd7JtuTh1KFHvJZGYFyhH0Dgo3ptc7UXKIWIVXC6tDmQScZY6PqcT/Y2ptb?=
 =?us-ascii?Q?v+O3k6h3DRjrnrjF1TgMPVDAk3vtsg1Zfz0oQtadNhtsZuKxD02YTa+TBpXm?=
 =?us-ascii?Q?gJEdA0SoEZ/DEmAD38gCqTcBeiQfhwopjHHhdzuDZzLba1G0Z78sy8U0V8ST?=
 =?us-ascii?Q?8xooiudwQGtvtTrtsPIZsMLQs1Wh1d8/p7bwfl/FniBlTSMLJcHuXamaZUBH?=
 =?us-ascii?Q?VbPLKQNf+ORnwYtrCDSDLkYoZMX8Qkqoxp/4bbjMEoTQiRURAkwZ85yfOAVP?=
 =?us-ascii?Q?D6i6yyrXgnjoZdxGIyVCeE6QT3IK8kMlQqR5Svjie8awo6HH03JK8e/6D0C4?=
 =?us-ascii?Q?WQX18s19NnMJ9bBIKunVW0WjPxDgjnSTIk7DrSSn+ki/93UQqCROmHUutsRb?=
 =?us-ascii?Q?pREHijscY5DLGbK202BTVX/G1jq0nCjjvtR4jBDMSQzbpRrMIkmYvBuOvISO?=
 =?us-ascii?Q?lTprqWXfvYc+xS9DU9Iweq/zrCMXi4PBJTBmr740AdyukSnuGu6Hv/8nhp65?=
 =?us-ascii?Q?nN9X15z7kZYTmKfbXVOH21vK8P99SIM4GIjNXgWTHR10ziVQ7RjuSz+y73Sp?=
 =?us-ascii?Q?LAYNabMvgrLpLDFTLzI2OIbauO0wTEIkRfhv4IwvQOYqyhPBLsud2rfxe/L7?=
 =?us-ascii?Q?LQiqN9FRDvgESJq7vyrl3Jykblfzf/O3R0BnEnzYrHRVsqD47e8y9h77NeNw?=
 =?us-ascii?Q?V7DOB8UAgRKBK++ta7IZ079UNI+3m/6m8O0i2QCkQ0fbJOKv/Q422/G7EdGy?=
 =?us-ascii?Q?uMw/MbmQr8p+WXF9bmY0m6f1Eqk8I98rtAa3lJcwHSvTm5AMZ5huahpn5CRq?=
 =?us-ascii?Q?Ml98OWhk5gokbde+Dc3DOT5I7N5iGsX6hWV/Y0QvB04S0zCzqnrvEJ/epqXi?=
 =?us-ascii?Q?HeJVDg8oD6YAOPb4WjVlZsyZ77qtIuo3jSImW/zU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870a8fa4-7dbb-4f5f-881e-08dd5be40b93
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 12:48:36.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMUu2M6lY7o3pt68h9Ag5B1dipPylM0UuKZhkqywOI+DeWx6qbBD+TidLwwG6lQBVB9WzLvdz9D4HPs+S4zIZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805

On 14.02.25 15:58:08, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 10:53:36 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Current function cxl_region_find_decoder() is used to find a port's
> > decoder during region setup. The decoder is later used to attach the
> > port to a region.
> > 
> > Rename function to cxl_find_decoder_early() to emphasize its use only
> > during region setup in the early setup stage. Once a port is attached
> > to a region, the region reference can be used to lookup a region's
> > port and decoder configuration (see struct cxl_region_ref).
> 
> Early doesn't seem that well defined to me. Can we indicate what the state
> is more explicitly?

'early' is used here as common term in the kernel to run pre-init
code. Here that means, an endpoint is not yet attached to a region
(cxl_region_attach()).

> 
> Or does it actually matter?  Whilst there is a better way to get
> it later, does this function then return the wrong answer?

There region references are setup and should be used then.

> 
> Or if we have both cases of 'finding' it, can we just make this
> code do both?

No, there is no user.

I will update description and comment in the code to better explain
the 'early' state.

-Robert

> 
> Jonathan
> 
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Tested-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/cxl/core/region.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 54afdb0fa61c..13e3ba984a53 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -850,10 +850,17 @@ static int match_auto_decoder(struct device *dev, const void *data)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Use cxl_find_decoder_early() only during region setup in the early
> > + * setup stage. Once a port is attached to a region, the region
> > + * reference can be used to lookup a region's port and decoder
> > + * configuration (see struct cxl_region_ref).
> > +*/
> > +
> >  static struct cxl_decoder *
> > -cxl_region_find_decoder(struct cxl_port *port,
> > -			struct cxl_endpoint_decoder *cxled,
> > -			struct cxl_region *cxlr)
> > +cxl_find_decoder_early(struct cxl_port *port,
> > +		       struct cxl_endpoint_decoder *cxled,
> > +		       struct cxl_region *cxlr)
> >  {
> >  	struct device *dev;
> >  
> > @@ -917,7 +924,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
> >  		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> >  			struct cxl_decoder *cxld;
> >  
> > -			cxld = cxl_region_find_decoder(port, cxled, cxlr);
> > +			cxld = cxl_find_decoder_early(port, cxled, cxlr);
> >  			if (auto_order_ok(port, iter->region, cxld))
> >  				continue;
> >  		}
> > @@ -1005,7 +1012,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> >  {
> >  	struct cxl_decoder *cxld;
> >  
> > -	cxld = cxl_region_find_decoder(port, cxled, cxlr);
> > +	cxld = cxl_find_decoder_early(port, cxled, cxlr);
> >  	if (!cxld) {
> >  		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> >  			dev_name(&port->dev));
> 
