Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE792B9BA;
	Mon, 14 Sep 2026 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789356973; cv=fail; b=mKieq7im2ves0l2E1OIhUWXbF6avSVZ6lmDazV6iQxlqugj/0BzpzHj0PBSo1A8QvSd5jgBVcRvVCwtQRTC6gdO+vrKDqtPQWrIignRgqUQgwbMEFp+agEmv3qQ497pn0St1jagmQUE706E//JVkwk7LDEjlsiEEqwLJsq8ugYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789356973; c=relaxed/simple;
	bh=vES5dF/guY9XbxoCifSNqUzPaffoOVcIOe3tlf6xd00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yd2mHunHkdcvkzdJNDrcCfewvQyX3pFuK33QQVNn5VTCgLehOzSTxAPCp6Pf1L9TZAl0UHYmSw/CAT6a2iIZ/HLKj1VFdapXf0kmaFhFawr9sbLrh5G2AeZzgkYYsjcTYgXCwHmftqTyKSXffwyTa4jIPylCrgIf6U2ofFGHhsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fzc0hfEc reason="signature verification failed"; arc=fail smtp.client-ip=40.107.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fzc0hfEc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wbu6Ki7YN6/PhDqE96O0r/xaSqWr8rNh2u3eEqmmKReY0lVnmdkIESkjnREfNKPv5f3BaZIg9Jls/yPLGOdFBZuEtvdOc8g5RoOxIORhn+1l4vTUv0UvfF2+xQAHzkXn6VB8ZQRhnr8AYt23ZN2a4LjXUljmr4mpEhLqafeUXyPYAlXn3etw7ofD1mFK+mZHiVGIo65TwZC92ULrAjYcKgqLkBTsM2ifzyKQFKkfI3UbF+8cSj06JSznf0Fnxw1QdABftPza5Tps5nj1Jb5ZoM057WKQbKYEZZenfIM2wWDLDrplXH+a1tUsDRE2NrBk2rWph6huuPnWGBzuQEO+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mjfw7sB9q6L9cS8FTzJPWS9eS2qX/s0p98YfSjLNPtM=;
 b=iExiPEcvj5urS2Ac7dW6frw4IQZ8s39D3mdoWzcSnST0vZxauUrkeoFQ6+t2pcM8+TIMHjcs8qPIMlvMX4GEtZOhn8uHwCmtwsuodlUnqc2m0HIN6Png6TLeThY/6x2QAmJcBYN3OVUlwBJYsRa3G/ECtpu93z1iHfGd/TzV64WnTtxEUbat1JI2kTgSbt0sYW7XUZkDqgaoc4QFi4zQxYaLR9aLxCZrsh1+Uu7ho/uQQBQoRW85v88z5RGkyUSurieKfUB4NXtCDIf8sxmmOCVTnkRdQfNPTwcZreG5l5cax6FL1JsAoAtijGR3bwEjrjZsD47FaHXiGCB4brv4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mjfw7sB9q6L9cS8FTzJPWS9eS2qX/s0p98YfSjLNPtM=;
 b=fzc0hfEcv+9wPXLYKzCj8MZWqMgJfm60E5C6gISi3jBtva0egiCtkhFJ1SfX+bJEMG/LTdHu28+PybANjGe+UoCDv4x0ktFCCguJAgNtDmYXGyor9evffpjC++djO3zU15laI0eIWUk+gQhbuFUlXi+UnxjacdVjoKlwk+7uFcnctbxrN1A7k9KG8VinooUIAC8bLA6G+8WyclkYvIYsXq+99xRFGNk5jg1GXn1YLzSXO51fO4FHU6RMIa51jSwzcSmSk1+G1i36Sa8q78Yfgs7kQoztluG5TXm9GLji7LBL0kgL1pYRGTGcPl7cBrn/ozgESfY1v8OyuKlLOTNGIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 03:36:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 03:36:07 +0000
Date: Mon, 14 Sep 2026 11:36:02 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: jic23@kernel.org, dave@stgolabs.net, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com, iweiny@kernel.org, 
	ming.li@zohomail.com, kaihengf@nvidia.com, kobak@nvidia.com, vaslot@nvidia.com, 
	mochs@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v9 2/3] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <aqdqzYoyJtfrUpLn@MWDK4CY14F>
References: <20260805055524.22311-1-icheng@nvidia.com>
 <20260805055524.22311-3-icheng@nvidia.com>
 <apr3jMIDDqYeZdK5@aschofie-mobl2.lan>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apr3jMIDDqYeZdK5@aschofie-mobl2.lan>
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e3a37d-4f5a-4998-1efd-08df12114f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|11063799006|5023799004|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mpjoJhMzu4K/ItOc/6ljuqGIMuJ3l0ycgLO3UYrpXhTUX4wKRKLsgTH20+rR7O1XMWkUixVzQt9GCBZKODNmq+7z8++0GpKn8SrUEsMe9FKPhX4XtOC8+RrMpla1DdJVhJeY0jrSxbPMSvTCYru19sUlUdGiXHjkPkU3vFimfvAWCl3AwLQ+ch61FqO82pWdckVlhwDKoTR6UkmvdeRR+G/8RGJ2/vQeTTe0GwkE7pdzWNLW576Bc3HiFCyZZaxLqDycvRUVHPiusqIOdc08otdRypjhOpQBQfoL8hIjwBOnlDyfRSzrPYX+adiaINhuTFtwFNTxEBj0v6UbWTpeppcMwumtfKzHjLqkyP1gPgKaQPmsjMJzvg7vOxFwgH2rTVKcmceFideHFgGTy7H6FLH/NMkNaJSMaEkAy0jZG8FE+FsmwLhtjUqwxS3CNH9RNxc0zcWXU6yu2ipBDRGk9iPVmeB0Rij05Y0AjjWw+MD/ClMTv4OnQ8BZRAOzeq4OTSwNvKtFXE3UvScc66OLVFTt7gG1cB44vAY//KMkRcJWys+0VmwOI5KpJVVeG+Z7RpyoM0vAGqAJlvmO9xJvc2BiTElKeQ8N2wLiSHmyGIY68rJlzcjuqM4/+/mHUdjhBLbxqDqxW4hHB6mAaQYzyAUQRoZOvmwRb037lT/7GJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?NPGQz1KjkPbrwyIpCuQzfS8rshy273I6VW6Th3cW28BMncHrVTKe5xqShV?=
 =?iso-8859-1?Q?2Uy4GUOGeesbeIvmXrBv+GgNCOpVYz5YuJvZoqCsWTW7ye0dETlAVwDtE2?=
 =?iso-8859-1?Q?hUKjn6T4ZPgSs/hH2UdtZG3/oB3vo819TUvn+UA5ORp9PzgYWpkUENTLXY?=
 =?iso-8859-1?Q?v8Z42dA8O7XFWvWmPCcyhWzZHuVsTHjNnp/jhD38f7F4x3FDf0sfe0DlIx?=
 =?iso-8859-1?Q?AlHAY55WmaSge6t3j5ZCTA3gUykuqIWvLXG9SDAbeH/FUg0gH7EUrIHcBy?=
 =?iso-8859-1?Q?EE3NehJRvJetpBiA0Al88jk6KlGbSERY6x5QSA8VeGcPny8YIhJrz6Qvx3?=
 =?iso-8859-1?Q?YXlIbqWvION/Q/FFr/D6VzrLcl3S3vOcsjqHlLWXwYzb1zLNSW4IDZUIZM?=
 =?iso-8859-1?Q?qPq8qAG2itUMbUFMtjkQyfqWoor8ab+4WJ3jb0Q0vXxzvvkjLnhUC0N7Oi?=
 =?iso-8859-1?Q?vgaLA97UnE+K0EMhzw/ndkdhokk90C9AOipjZpUWWueXrnKwnO300M+eSd?=
 =?iso-8859-1?Q?smpQzLExjhR+WCtVoAh1GVSqaJNZGrevlm+SNNv5sIdHJPOV+KCZbztu+X?=
 =?iso-8859-1?Q?3HxgjWFs8D3JhOzk3BuVBLEAIJOYUXGJIn74APpPqy6+sN0iKll7hMI1x3?=
 =?iso-8859-1?Q?KGoytZBHGiXJK7UHBGo/tWtfH5SPKNShxCwf2xX6Z29V5/QDv5SVn2OvIj?=
 =?iso-8859-1?Q?MkzFulmvVi2l5xta0qgW1xxRpgLgZtaPNB/i2SaeFgiPdg5WLpVTbwioQy?=
 =?iso-8859-1?Q?4p2JM68QEhNocZlDF4w7OU9+6mZ1KqQWWvG4grAB5DM/Kj6HIrFdaOUka6?=
 =?iso-8859-1?Q?GeE45/8MMPV8j+nziKJApG+E4r+il7QlmrRtCP/Uxm1fdCb48ALmiO0+yP?=
 =?iso-8859-1?Q?1PmRNu2QsjrDgOuhhYZKBcp77YQWW8Ia2wxufDqrdPeIoiiSmmfVLfWtGx?=
 =?iso-8859-1?Q?2ZasA9S6MD45RYOCbYgfOK+3NxaHcEUUfogh0mid/7FJNyoXbZPKSSJTkT?=
 =?iso-8859-1?Q?nbXVEs3u5JnWaY95icVcVSwp6KMtJIDJufcdnNQvRLCvcYKxOJHzuA9OKG?=
 =?iso-8859-1?Q?Gxb8voTc3kKK/fd9gCG+EiYIRfFYM3fqN8CDjyeGzzszDUVzP/2JA4+v3q?=
 =?iso-8859-1?Q?BeG0PnhDDr8l+eOOulVRsbol7E2aUSlorTiLKEhxopiQpzrwva/3M/lrhX?=
 =?iso-8859-1?Q?ac8vApQdgnsvXu7kDFWs/S+6uGzxueuVFbYXToGG3E74Rc8Kb2l8pHa28L?=
 =?iso-8859-1?Q?ZnvPBs03UdxIoQl2gN5GgYzP0Sx2sMO/eV+zKSVRMukzsLBJdYE0INfjLb?=
 =?iso-8859-1?Q?4VRov0qrD/m4LlNOJvCSkMbFQ5H7UzAXhHNCWZbh7tc5dVzQGNT/lyMT4H?=
 =?iso-8859-1?Q?M9fNYGwTTFG997vpthyCD4q42o4hhpsP9+qIYj686nkYhD5JvuCw+0uaf9?=
 =?iso-8859-1?Q?Ili5sSXZeWAEqClSUH0OnvuIyNi7c/R+otJIviDX+nXOrDI0oI++cuuExi?=
 =?iso-8859-1?Q?Bnzq+2ekAwEiSWjn8kA+LKxZcRAWfuETXIhYJi7S2qL1ylSnTUWp14eK5K?=
 =?iso-8859-1?Q?NoF35V9Aa7IWkBCcLXbQkoWYjcvZ8fksyVZ4sFY4K/rA+I/n5n/fXe2o8G?=
 =?iso-8859-1?Q?wB5p9GZ4psHOtzGZZXEuRynSJ30BJCDLCqI6YUlHMgPq2PpaRQhRG5VbcK?=
 =?iso-8859-1?Q?G3CJfPoMTKdJ2JrvtzPmw0wR43znLKvHfaL2wipwcCi4vpSJCz/C7mwyts?=
 =?iso-8859-1?Q?ZRjtRNvQgRHNCBgXIqDkqJCjEFbzOpveHY/GRs2VS1/h/XCqup5bw3qqoA?=
 =?iso-8859-1?Q?Yuh2VehGig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e3a37d-4f5a-4998-1efd-08df12114f89
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 03:36:07.2209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nvQG2ONf+oKP7BMUXmXfXMT6jSv5OpB3h8/HKF5pIUL5TOvNOWgKq30CH6luYlBwhJAhhv8ypeY6xxu02inaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023

On Fri, Sep 04, 2026 at 09:53:32AM +0800, Alison Schofield wrote:
> On Wed, Aug 05, 2026 at 01:55:23PM +0800, Richard Cheng wrote:
> > CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
> > ("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
> > with size 0. BIOS may commit and lock such decoders so the OS cannot
> > program regions through them, this is a design choice rather than a spec
> > requirement.
> > 
> > The kernel rejected these with -ENXIO during port enumeration and
> > aborted the whole port, so affected systems showed nothing under "cxl
> > list".
> > 
> > Treat empty decoders as first class instead of special casing them, back
> > them with a kmalloc'd resource, since the resource tree can't represent
> > an empty range, and keep the skip and hdm_end accounting intact. Guard
> > the paths an empty decoder can't serve, e.g. region attach, DPA free,
> > and poison queries.
> 
> Hi Richard,
> 
> I applied this set to 7.3-rc1 and retested w the new test case in
> cxl-topology.sh - all good.
> 
> I do have some comments though - see below 
> 
> snip...
> I'm snipping past a bunch of Reviewed-by tags a bit sheepishly.
> Maybe you'll quickly dispute my feedback?
> 
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b..3b3cfa0f2507 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -240,6 +240,18 @@ static resource_size_t __adjust_skip(struct cxl_dev_state *cxlds,
> >  }
> >  #define release_skip(c, b, l) __adjust_skip((c), (b), (l), NULL)
> >  
> > +static void cxl_dpa_release_region(struct resource *parent,
> > +				   struct resource *res)
> > +{
> > +	/* zero sized decoders are not tracked in the resource tree */
> > +	if (resource_size(res) == 0) {
> > +	}
> > +
> > +	__release_region(parent, res->start, resource_size(res));
> > +}
> > +
> >  /*
> >   * Must be called in a context that synchronizes against this decoder's
> >   * port ->remove() callback (like an endpoint decoder sysfs attribute)
> > @@ -256,7 +268,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >  
> >  	/* save @skip_start, before @res is released */
> >  	skip_start = res->start - cxled->skip;
> > -	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> > +	cxl_dpa_release_region(&cxlds->dpa_res, res);
> >  	if (cxled->skip)
> >  		release_skip(cxlds, skip_start, cxled->skip);
> >  	cxled->skip = 0;
> > @@ -336,6 +348,26 @@ static int request_skip(struct cxl_dev_state *cxlds,
> >  	return -EBUSY;
> >  }
> >  
> > +static struct resource *cxl_dpa_request_region(struct resource *parent,
> > +					       resource_size_t start,
> > +					       resource_size_t n,
> > +					       const char *name)
> > +{
> > +	if (!n) {
> > +		struct resource *res;
> > +
> > +		res = kmalloc_obj(*res);
> > +		if (!res)
> > +			return NULL;
> > +
> > +		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
> > +
> > +		return res;
> > +	}
> > +
> > +	return __request_region(parent, start, n, name, 0);
> > +}
> > +
> 
> 2 failures are now collapsing into one -EBUSY 
> 1) __request_region() returning NULL is a resource conflict.
> 2) kmalloc_obj() returning NULL is -ENOMEM
> 
> Can this preserve the -ENONMEM?  Maybe using ERR_PTR() or handle the
> zero size alloc in __cxl_dpa_reserve()?
>

Hi Alison,

I agree with this, I'll fix it in the next version.

 
> 
> snip
> >  
> > @@ -545,7 +572,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
> >  	struct device *dev = &cxled->cxld.dev;
> >  
> >  	guard(rwsem_write)(&cxl_rwsem.dpa);
> > -	if (!cxled->dpa_res)
> > +	if (cxled_empty(cxled))
> >  		return 0;
> >  	if (cxled->cxld.region) {
> >  		dev_dbg(dev, "decoder assigned to: %s\n",
> 
> 
> Is cxled_empty() the right test above?
> 
> The old check only returns early when there is no DPA resource.
> cxled_empty() also returns true for a zero-sized decoder that does
> have a resource, so this can return success before reaching the
> CXL_DECODER_F_ENABLE check.
> 
> For a committed zero-sized decoder, that means echo 0 > dpa_size can
> report success even though the decoder can't actually be freed.
> 
> Can the original !cxled->dpa_res check should remain, or the empty
> case be handled after the existing state checks.
> 
> This also means I don't think "DPA free" belongs in the commit message's
> list of paths that need to be guarded.
> 
> -- Alison
> 

Hmm for this, from the first glance it would make the serie go back to
reject the zero-sized decoder, but I do agree we should seperate
the handling path when decoder state is different rather than return success
for all.

I'll look into it and see how it goes, they should be addressed in v10.
Thanks alot for the review.

Best regards,
Richard Cheng.

> snip 
