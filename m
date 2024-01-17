Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F92261D
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jan 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514276; cv=fail; b=Gvv0z87hTCO7fdHXHKs3yOR4ceMWZDpRoXnn8NliySeeFb2Zp/eXG4AIgcV2vQWCQyj6eEnma9yEPEegLf8DB3wgyI5qiAbWGzMTHcSg8BkiTSLRe8IW9llD4vTy25SD7IyP0sGjipcnvC82cUzc+xXNLzWy96cWpeRTx0XPpdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514276; c=relaxed/simple;
	bh=qu5rb41besC1sPer+62tOxYq3PGa+kvLJytH99Ny1U8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	b=o4smx0V4LxQi17kSPEwQIPJ18rdnpU3UG8qqvc+Ie9glxI6CDB+qqYRVCKEfl0c775uzzFtJe/gPLePTjGfXgLaUwd+ltpfZ1MGqQDzTNY60iqSgTIppR2c9fZd/IS38mkJf8kJCZGHVo+mpQ5q2qayDtr6ZGwhZmDk5RRdYpnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsE9nzOj; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsE9nzOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705514274; x=1737050274;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qu5rb41besC1sPer+62tOxYq3PGa+kvLJytH99Ny1U8=;
  b=dsE9nzOj+C+z+xJWr1oh8DiLtgoTpLjBe966rA+dgiUe2p4U9qoEtYjf
   CPUhfRpo0s54zrAgeQ8TgGAbuRRLAD/GkTxG6YPACY+xz2Q0MRacpNvTp
   6n+QhLglOe7wT9IQZGc3RDOQ54kzrYqccGibCEg4TExiBNSRnoVnO2HXq
   AsqP7IWMYE50SHTdIL3IsKX0kqh5BWPYIfck2rB5Q6rKIBqEwy4FS+UgC
   g7H1W9tU5HugB81MPOtUm+T/rQvaBl5HDOtTpxSWgADwGmzD9JKaK2tMt
   ZPfpKvcjB8rpyvWYoikoMy3n0NDxXlyIXLNcg3KQ7Kz2vL/d2beeMYhKE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="464518020"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="464518020"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 09:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1031411761"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="1031411761"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 09:57:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 09:57:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 09:57:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 09:57:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmPNLfmzSelUtRWiuFJrGg5SXiLyDjF1sAD6mPi8P+wKSA7kKDtAaOMsABdNcq+vSdQXe6tW9OrafYOEqPWuVqjvIFdBQzEaUPdP5KGd6L/6hdNX5yHnFzYHZYg5JJjwtNfkO7UkGqSPmhS6wZVyhr5kUx6jHcTSBzWIW26XzH1fcCMgCOqSrd2J3vMi02JUjf0UKYZuih8D31Dpj9KGF5F8ue7OxttWp9V07x/BBVpj+g4CTQOOfjKAX+VObvzocoiZqbWZh8OYz/0BY924MiUPVDS90KyK5Hl7bcFEwOeRMgsLcfZNDqdI/qxP4YXIgdEctUl6ChKdndAlHYrIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhUMLPAfZ6rlez5mQpOhzC978FbiEFR7WXG8x4SX3IU=;
 b=bNfD5N4t0tr+ZPJDFEtypgAhIiA1W1DE9GQXrEVhESgT5Gd8npS6rk9cNBTI1hgzk79FBW6jcPRjgb/w4NU5rgDX7ox8JKJnoDh2Kp2A5qXmEWZTFA0/PwbL65bV66G+4G9iJmBMh/t+SvCRtxxFByzpPUVvNDQfDbPfYM1z9daybpL7Birclz1Zi1hAmzl1Gh//tCbnqUBGX9coN6q9UeAAW9HpkWeUiEZNmQwearPCyFEPdrJP4DZbhUPAltwx6Y5CfVm+evjL6ap18zFt4SwUcy7Tu2xa4KFeT63v6RF0N7Hj50zyD7FbMHtZigjvmJJqKz+5so26MVNulW90EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 17:57:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 17:57:51 +0000
Date: Wed, 17 Jan 2024 09:57:48 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/pci: Kill a goto in read_cdat_data()
Message-ID: <65a8151c31228_17a0bd29415@iweiny-mobl.notmuch>
References: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
 <ZafUwceT4N-bmS6F@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZafUwceT4N-bmS6F@rric.localdomain>
X-ClientProxiedBy: BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efe4e02-18c9-4251-a2af-08dc1785d28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rw2WDvE+gBXuH2sgcTpa6thjtcE95WmW1u+1IImWpnS+QTkx9PGp3qV0Xbxw/v+QpLp65KNGFf+xNkAlljlOMrS7yXTJ+Jtsambb05BKGgFqB1tYEVs9woeyVDYt8wEk2dceS7HTV3dJ2mrHMCB65gKDVv15eyJwocElCzaSISmdVMbEmVoWquxM2o+YmDtTU0YfxNZtDCaK0leGTCA6GVMfP8E0nHw53uemGPLZXvMCrSkZ6Nh+1WRgvpLbcQdgxFWV1wgSLlVekNsR9ALNFp5MEUE8Nc5g8N20q2WLbItkWGw84Nv7HkPVBlNlPq0LRRvlWZ/pwPQxWgpghYVRWT0+R7+aN1YKHswMBqKxvVbGkxWvM2xISHb+7DSXZK0CFdR1FXZp4lHY4N3aDxAw/KsO+9OzntdbC4hH4tvAdrGjo1rL2HRzPCuy2JE+vRNWYoMFTeq8Ww2sMvkNBCjGRzGjEHvH5su3L2aO4p914NkGIzgD0380rKMoZTdL7uaqWK2qOnLUVLZ4VVSCdmE5eVgt0U/yMScdvr6RBSfICQAUt/AmvVRtq43R06HMsfo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66946007)(53546011)(66556008)(66476007)(6636002)(478600001)(316002)(110136005)(6666004)(6506007)(6512007)(6486002)(9686003)(4326008)(26005)(8936002)(44832011)(8676002)(2906002)(86362001)(41300700001)(83380400001)(82960400001)(5660300002)(107886003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBemKek2zVd2GxHE2SZr5oAZ9EGOXopyIzAoU6nYxwI/8d1bv+6j/aFi4AHC?=
 =?us-ascii?Q?o67/HWhdP1Teim+ncHxgTZ1dWT60WEN6a1r2W6q0rBXFhQPIB016xw31CrSK?=
 =?us-ascii?Q?HoCrPtWX9pPejHl0Biyuc9ajkxiDvUeksJuptUabJJE+dtvjs+AdpGZ4LeSg?=
 =?us-ascii?Q?wkPB6ZAwUr1QUzML2fRbGsKuRAahlGdRJkMlDyWhAsCSumnxA33O4Rmy+ziN?=
 =?us-ascii?Q?AXB1JDBnUOPZj0BbQPFHmGZgRNMwn3cCdS2XrCbHgMOd2/l9OCgpVQoAz6D9?=
 =?us-ascii?Q?LmJqbyR5nMFGbzCEbO//wecun+ijwVeO2fctkkHy5NJ0XpuSkaUCgF7/TWgD?=
 =?us-ascii?Q?EKjyei0xIWLa00EK0M1n2LcCr43UjhI06K7TFJ1mUuhP4xmJ7WUp4Bvbj8i1?=
 =?us-ascii?Q?iFU68gd6dAmlT1h5EB4I+O3zl51iO8YV4z761FXQB9Oqt44l/7FAT4bE/4DA?=
 =?us-ascii?Q?bqbyY6g9lApr9HGotM82FJAoYx/ReUqumcBz693verddKo25vzTF1+aqXvrO?=
 =?us-ascii?Q?V4fNE9Vqb1s3PmLZ6n7kIUqBmoNl2/Ybjty6nuScgJRmUDMclqxpGEEQktsb?=
 =?us-ascii?Q?9+pESBASFrGkrCIulV/jCY6yPCVWzQf9gGHHpTDntqCgBoh27BkGQzEnM6FX?=
 =?us-ascii?Q?O4HGj0d9ZvWfnzqy2WMkkSSGGezWR+Ve7c8HT6SR5ECmu+Rv5cRtP5J+qrJA?=
 =?us-ascii?Q?XS++EwPUitKpQW711kdLqo/fcB5+Ws8EcVSZZKpnPt1eVLbBTAmG/vj7NhDW?=
 =?us-ascii?Q?JjfX3ws2BlUF9SbW1/tp0pvwdEiM5/78mmjLEAZ0X2HzuwIInvnsj8gB5ahO?=
 =?us-ascii?Q?cvvj6YGF5fLCDmkKeraepULJhHUiB058mx60/JRgZyPidnDIy/Eyk3qjs6y7?=
 =?us-ascii?Q?8H9g+nJvd/znbLw32yNKXm2CJd4iLwEi0e1kysLLbHXAGRNwFjAEyL8BNDcv?=
 =?us-ascii?Q?3h4QtJrxB5++pud4nIrPEJ7x5ec7DEWcQoOBhVvH/ADymOB7l1FxvK8IoeEy?=
 =?us-ascii?Q?C+zKDI9pwNlwJVFkl4vmvvKErr2DlRHUarwY7fq1wbC7PQjH2qAp5j4V39/7?=
 =?us-ascii?Q?md7qBj7oyjtQHQuqgivYTB2IYcu4+JVbGP8MDurldYLFDRPX6K6J302bvr5a?=
 =?us-ascii?Q?z3+3NPU8o0OnNYdI5sn1HmxG8RIxn2TjCxnMkwbY9yg0/DLzbdQK+iT8ZaNx?=
 =?us-ascii?Q?MdaW3HntWTWaWZUxsgdvfzMZvMIghNxXoSX82S+bhr9E5lMJJ0vn/RFnsCWJ?=
 =?us-ascii?Q?vCTs0SQJNT226U0JkGYJTUocIuz4WQUGyXGLYsY8ygXkuqF8JI1XpmKgLijL?=
 =?us-ascii?Q?yUB4hRa2vlM9lOpdYWAueHFBqIm18Rk4sFBni5rcbPckp5WLywPwu70c/17H?=
 =?us-ascii?Q?RVGvA8hNIPO6a8dIBe1LSILErv+Kvek9E7fNW78fiLBO6g+hbx3NcU0/+nkz?=
 =?us-ascii?Q?BQgxSzKI1E8/oGNGgsRYqV3ll4ItNSMCwz1q7yEHfOh7UREh6IQ/+Ah65RMj?=
 =?us-ascii?Q?8PpfJY/jqsPv38YBlImMyiSKJnMxeAvj8BJkU2mhndTsmlR53GSNeWUWouxx?=
 =?us-ascii?Q?YlIG0oeNrs500/lffxy2SPXeuZtI2zR2820l86k8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efe4e02-18c9-4251-a2af-08dc1785d28d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 17:57:51.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDL9xGgGem+q6kYUE/ikoEgcc+SD/Y8X2uPnTbDFE3v7qISBsIfbTQzQsdBfYHijV9ul3srdwICQIn0nVUU4cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com

Robert Richter wrote:
> On 14.12.23 21:25:19, Dan Williams wrote:

[snip]

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

FWIW I understand your sentiment.  I think it will take me a bit of time
to get used to reading code like this as well.

But I think the cleanup.h code style is a safer way of structuring code as
it is modified over time.  I think other modern languages have proven this
out.  Another example in the kernel is the devm_* functions, they do help
in the long run even though I've had to really change my way of thinking.

So, for me, I'm going to work at retraining my brain with this new stuff.

Ira
