Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9F3D97F;
	Sat, 13 Jul 2024 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720856454; cv=fail; b=d2UMrDVop6+XuKI5CG+/mn0ygrSWdbUL2ewONmyNRAUnHc+SId0XBqCpQ4X/x/R4/pZFq+PyXMqB1Jkr0CC4nCA2DiwU8LQRNJ/GvDsmkkWO1aTXT7yukS3VciISXZ8PAdaXXbxhDBVQCgG5tbf8UPW5sVNAQwmIRNCq58N8Pek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720856454; c=relaxed/simple;
	bh=f+c2LSNdRFAJfHqL3h3/3TZkuCuxW9mDYyM/5ybV3/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NGtjLUDwqm0pEj6qyGJpci77dTBSSHL/vb0hJP0HOslAHSv25zZjYxBQ9ImDHTanEOh1DOlY/bG0Iizlu2wzBz7vZc2w6R+aM+tF38GBCUmzKmwpwptgb7zlyLCvBeDHhK9QHnFIt2YlZJ1RjjwbL6lIVl+RBWWqiDFyffyiySw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kamRlnV4; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kamRlnV4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgiXddxWFY62mq9hfXqdFeLnIP5gPpi8gvkfBuT/2tjt6VFWwdpud8qtKZY7L34J5QGIbUWldLG19z6cWWSSEFtC8xpEcxQH7HnPDIupAXVFaSKjIVFYBGMd7uMpeCFTYjP4N+Ms5cNIBUAvpPG6NxEw26FS2ueYwlhkOvYgIBDS7E2U0cqB3jo7lXtpKuwNsPiO/ZJhLDV24GTLKpnA6Rs2Efmb893ncRhoBNYIzxOkwNVntYV6Io+88wmKGoxmMr5Kjwj+tj/9zIb8jFGlYNEXuDuyN/D3YMMCzcOfJqXnTu+yXOKP3zETQOOEh7XQ/mFvPsRmeqPHJgXyimJmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/7+5khLNhD2E5DM/f1X9lnTCYqGkop+vLl+0ELRmDI=;
 b=sUJaJdmVntxdnu3ML93wR/mXQtCgeAnyQx/5fmLL9avp/IXkkQ9gBIGiCpC4rT9nMY1XBEDDZDftNcYyx97cIe/a7LNb9Vff3VgntNX9T/7h+J9D23XbJrj/0BIPY7r/y68M281+u5n0fk+IEyMyGCk95nw0iL1xWO+y3H4vd4dIAlE7aSf4LOnFJW+ffnXQSLZFKrJN0FUBA8n0iHm2p6a3r4APqkPKJjjtc4iXRj0yospK29L/nRY/whMB8GmjTGenUW8g2pSdoKzpAKd6rVMJeGFLN9Pu6ElwEDgQrwHISAWqbTnybtUC5dF5Dh3ZXgDaOXiwEArCgs8jhnanaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/7+5khLNhD2E5DM/f1X9lnTCYqGkop+vLl+0ELRmDI=;
 b=kamRlnV4fmNsahFjvn5/H5pRVG2hrJw8dH9yztER7GnK4iAgiKyS1Fr0cMVD3fW9J2prZpOYLvdz0QtEcXcbjeNYHh49HkKYPwkbCj/U0OtvbSIwS13gqFbM3n4mc1UkQo573ZcBvKN2pnsfda5Q470Djj9d8PU8iygZ0/duGp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Sat, 13 Jul
 2024 07:40:43 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.7762.016; Sat, 13 Jul 2024
 07:40:42 +0000
Date: Sat, 13 Jul 2024 09:40:39 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] cxl/hdm: Implement address translation for HDM
 decoding
Message-ID: <ZpIvbqx9UgZ5AqNF@rric.localdomain>
References: <20240701174754.967954-1-rrichter@amd.com>
 <20240701174754.967954-3-rrichter@amd.com>
 <669080d1753f1_5fffa2941@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <669080d1753f1_5fffa2941@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 25214c2d-e8f3-48d3-b126-08dca30f1966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YbWdu/giqgJ2OaaXc9kiswoCBDFAJEElyVbGLuZpfmup2AIUxi9+h8KANpWK?=
 =?us-ascii?Q?pMzPI68nqbMvaa/nccsDlgKT6r4/GET5qeb7YcUrrzIVui58yWd5w69efp9V?=
 =?us-ascii?Q?CvvFM5tmyDYeZU/noSOhY7t+xrlbxaa24rIzXHexn0VEz7tgX7rvKZ+xvEUc?=
 =?us-ascii?Q?SFne4HPdKt9LUfUL5nP1idrjJHwwb6tKN1T4stc3KyGked6Ls4LuOGU+SNss?=
 =?us-ascii?Q?z6la9J5CC1t480xNsQE/Cy41N36vA3E5fWPE4e3cCt9zp7TB2/b8aAU1X683?=
 =?us-ascii?Q?EZplckEKs/KgzDCa+aojh/PqSaxEg3SK9JAhFpngbE4DHYGtx5MwEkl75vCt?=
 =?us-ascii?Q?gHwAzEAZ+WjwexUzeSGU7Krs8zgg9Av/JNwQfSyF1vlEDpY27+2X0tnbSZbj?=
 =?us-ascii?Q?keUgMJmLIxHwiAVuP36yW0wMiZpMktjGZ/fpWMnUXtA8CBHftH2eCbtKWcTk?=
 =?us-ascii?Q?7RKk5DAGr/7GhN2QhRG21/sAAdadtc47anTCD1/+ooZs1oktlAINnDHlt2HX?=
 =?us-ascii?Q?EO5TmmqRU1ocHzKZLIFjqSvJM2Yy9lKsnxYMD6FaWZUW1s11DxZWg/jOXQ0F?=
 =?us-ascii?Q?Q4Yoq0CuGipm1z61I0pn8iMhlWcgo6Pp4QsHk6r08AmbL60iMZqJfagpxfi5?=
 =?us-ascii?Q?GKQBqCrtQarmQH7UxDvWvuPIuY7E/sdtX3Y7UIk/640F2TQ+fHd0AfsZCyIT?=
 =?us-ascii?Q?NvJS9sM+feyz6lBnBgZMNaUcv3CwHcONkzXBDxIOUpEwyxD7y21nOcUPs+sh?=
 =?us-ascii?Q?kGOTyDFhXvzOYWMkuEYCMHVwVUiFbzJoTrQwhK7WiF0qQhzsA2W4Lu6q6rMs?=
 =?us-ascii?Q?tum0C8ZDUnkErsSkZZlndBgPtmuVgjLmP0I1tnvesW83rqB1Pf4qI2sgUuo2?=
 =?us-ascii?Q?8AvlZAfE5KMMZq480/KuZqJCMB3W4sfYkR004KZ/XkmDAUSq/CCCb8QIzpIY?=
 =?us-ascii?Q?B5C/0A+jkAytRTY7CDvkqm/+rE/Zcyyd5lIu7YZ033EbJ3iA5dpeWsEMIuUY?=
 =?us-ascii?Q?YdCRyEI5yT3e0UjHsOf6knH8rdEvY/5itC0eBSosJZk/cldgEh1wLYraW9xz?=
 =?us-ascii?Q?3xDF9vpGb8qzjRt6fA/PcrrPZEVthIt0d9AQWEE9x+KubCeHwAeyWhMPCAqo?=
 =?us-ascii?Q?i7c+hOITDeSRSBXvbZlfsKn6pSczMALrPxaQ9aVOVryCM2Bod9QvgDuWD4+U?=
 =?us-ascii?Q?JC95Ww4nn11M4pus7wEIQVJ1ZobahyS8jvHlX8HPzQn77NATJvTTsP2Czfbh?=
 =?us-ascii?Q?7LZxUvby7Chf9bwvTT9WPoET2Ts8R9b0UCihU1OUX0P1nXJ60rwWujxAqMms?=
 =?us-ascii?Q?2Nk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Or4CulnBQUgeaLfBX6zyqkEKms+glYb9dy5S942l8TnhyC7zncBWNQcOWp5z?=
 =?us-ascii?Q?nc79xJsBtTgqWi5Li5pIGmiK9FTHJUnlAkrICXXmjPI8GAVidPGC2/JfZiFn?=
 =?us-ascii?Q?YimJOv6Zuz/X0uhbWB8rNeYBeJBU4u+TXl+ZCzqyMIBtmVIAWDtx1XutcwDG?=
 =?us-ascii?Q?miI976CtLwqAG/c9jvXIcEX0KItU24hqVp0jUpclqdfmkrT3VC07io76lqF1?=
 =?us-ascii?Q?kMUkzIh8rkSb5UwgMVf1fgQvuoRG0JmUn34Ns1i/Zt7iz23lk1Je3tzgMDZr?=
 =?us-ascii?Q?bqJCXlCDEMMiSUqyuWj8dLnimQWYckCPFCjJM5I2qojaWviyGMfQUKqU/fnV?=
 =?us-ascii?Q?aL8V7eYga3C3a7yxKS5Rwja1jhNJFHebAbonmi6i4j7A8WjrliEscIjAWlGu?=
 =?us-ascii?Q?55Zaz7ZoAKnFvOfpgu/TXhZ1zt9zVpBrd3dkJL+OZ0kjVjsBwXtbys3/JaPy?=
 =?us-ascii?Q?XS9Sle2Y4R8hYA2vA0rc7/x+UNw2le5FHX49aY50jO1XBcaxife5RwKbR3Yi?=
 =?us-ascii?Q?0E4ej01yAsMMJ/VXzup4wDimmPyrJ/k1pyF/g4fAvyU2AsmChvh8/ICCsIrF?=
 =?us-ascii?Q?aMq2ZMdVC+wvZ/AfifytCUp3OKl1UY4yBvfiIsGESCK55FJD4r1R8tL9/ERA?=
 =?us-ascii?Q?u2g3rts072rMg0QAmMamES7NoMKRiTKL1ze6hKNkXM+Ly/GUUt9cwCz84epr?=
 =?us-ascii?Q?CQI/KZ1/EFnq45D6pqjC5fgs67dwNiGgoFLd81W3mSJZ2lLZNDpsrXTNENH+?=
 =?us-ascii?Q?JfONleINRy4YbtNdn6uSsf/YTs8FKLbLbQbnagWGVGlyhmMtwXIWmyHhufyR?=
 =?us-ascii?Q?PwbTxQ3FVJreCn/G8BbdezlfvrYWGArGaYy2xhs/mz6ndYKEcSDBNlZL9Qb6?=
 =?us-ascii?Q?X8A8AwmsGhOi4xC4VP0ItoiciHn9dENq0w4rxkRz+3iLER1ROdaxDCdMujZh?=
 =?us-ascii?Q?/CNcqJsG73MfRNzrPIt0Y/wxYubrxyFGjS+6Bvss5FlqSz11lNe1LRg+O4XJ?=
 =?us-ascii?Q?mAj6Y4jInXV+myZHuye53c3ekQLfSh/GvSFva17mgObK3WFNCpIVI1ix2jvS?=
 =?us-ascii?Q?UOea5fNfuYkDVSSZ0e9VetPKk2xM4TDN9jaXo1F4eQfhl84bKcSs7+sFlIYw?=
 =?us-ascii?Q?2dNkvLPvaTWDOAKrLCjz7iHpN3Z/BuC3ggp27uXalxrZQdRw4CKdQ9DpaLoU?=
 =?us-ascii?Q?uqBdyUHPU+QK1b7PXpDvwnodGmY/O3MIVW6c/nbm5C7h8KRkWc3Gz2FVNxqF?=
 =?us-ascii?Q?1+Ud/SDYQo+l7shWJJJNU5lM/SY7bQOBkdYUfuKZF9K72DLL992HTKtDRhYy?=
 =?us-ascii?Q?OYP1aupFxTc9eNS3eyJUODxqDE8g7hFLQwZUj1SA+dX06Ake6XL23FK4MaKS?=
 =?us-ascii?Q?46xlWla4vbQ0bnLU5pUc55rlY1rg0fykInx/E0jWv8cBxSltz8ZhZD1na4Jb?=
 =?us-ascii?Q?9ddW+s4MtnAcg7Acb2ZMal9GLa9SzaLc4WCiNiA1XSvBTbK3PFSnxGVyHbst?=
 =?us-ascii?Q?CuAWNHUehe+x5Bh0RSs5zCK8AWAODjDVKZt9BZif/HDl5XlQBaiRM2PVBOXL?=
 =?us-ascii?Q?l61KVjYbSTPE25uCiR2bdgN9m+LCuLRg6jbe2SS5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25214c2d-e8f3-48d3-b126-08dca30f1966
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 07:40:42.8271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4yy6NGnwYwdKySLQpmJtjlZenl7nbYQTP9+hTHD+xEtMloxBfZ8+cHikwbSVndo13C/wNuSmNlOQnphM3RcZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244

On 11.07.24 18:03:13, Dan Williams wrote:
> Robert Richter wrote:
> > Default expectation of Linux is that HPA == SPA, which means that
> > hardware addresses in the decoders are the same as the kernel sees
> > them. However, there are platforms where this is not the case and an
> > address translation between decoder's (HPA) and the system's physical
> > addresses (SPA) is needed.
> > 
> > The CXL driver stores all internal hardware address ranges as SPA.
> > When accessing the HDM decoder's registers, hardware addresses must be
> > translated back and forth. This is needed for the base addresses in
> > the CXL Range Registers of the PCIe DVSEC for CXL Devices
> > (CXL_DVSEC_RANGE_BASE*) or the CXL HDM Decoder Capability Structure
> > (CXL_HDM_DECODER0_BASE*).
> > 
> > To handle address translation the kernel needs to keep track of the
> > system's base HPA the decoder bases on. The base can be different
> > between memory domains, each port may have its own domain. Thus, the
> > HPA base cannot be shared between CXL ports and its decoders, instead
> > the base HPA must be stored per port. Each port has its own struct
> > cxl_hdm to handle the sets of decoders and targets, that struct can
> > also be used for storing the base.
> > 
> > Add @base_hpa to struct cxl_hdm. Also Introduce helper functions for
> > the translation and use them to convert the HDM decoder base addresses
> > to or from an SPA.
> > 
> > While at this, rename len to size for the common base/size naming used
> > with ranges.
> > 
> > Link: https://lore.kernel.org/all/65c6b8c9a42e4_d2d4294f1@dwillia2-xfh.jf.intel.com.notmuch/
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/hdm.c | 69 ++++++++++++++++++++++++++++++++++--------
> >  drivers/cxl/cxlmem.h   |  1 +
> >  2 files changed, 57 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 605da9a55d89..50078013f4e3 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -125,6 +125,17 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> >  	return true;
> >  }
> >  
> > +static void setup_base_hpa(struct cxl_hdm *cxlhdm)
> > +{
> > +	/*
> > +	 * Address translation is not needed on platforms with HPA ==
> > +	 * SPA. HDM decoder addresses all base on system addresses,
> > +	 * there is no offset and the base is zero (cxlhdm->base_hpa
> > +	 * == 0). Nothing to do here as it is already pre-initialized
> > +	 * zero.
> > +	 */
> > +}
> 
> I am not grokking why this is per @cxlhdm? More on this concern below...

Yes, I was going to solve only this single use case. Moving that down
to the decoders as you suggested below would better generalize this
and code could be reused for other implementations or platforms where
conversion is needed.

> 
> > +	base = cxl_xlat_to_base(cxld->hpa_range.start, cxlhdm);
> 
> Would prefer this operation is called cxl_hpa_to_spa(), which is
> different than the cxldrd->hpa_to_spa() in Alison's patches. This is
> about an HPA domain per-host-bridge.
> 
> The cxlrd->hpa_to_spa() is after the address exits the host bridge there
> is a translation to a Window interleave. Both of those are "SPAs" in my
> mind.

I am going to align this with Alison's patches.

> 
> >  	size = range_len(&cxld->hpa_range);
> >  
> >  	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> > @@ -746,22 +776,27 @@ static int cxl_setup_hdm_decoder_from_dvsec(
> >  	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
> >  	int which, struct cxl_endpoint_dvsec_info *info)
> >  {
> > +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> >  	struct cxl_endpoint_decoder *cxled;
> > -	u64 len;
> > +	u64 base, size;
> 
> Please don't include renames like this s/@len/@size/ in the same patch
> that changes some logic.

I will separate all cleanups in this patch.

> 
> >  	int rc;
> >  
> >  	if (!is_cxl_endpoint(port))
> >  		return -EOPNOTSUPP;
> >  
> >  	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> > -	len = range_len(&info->dvsec_range[which]);
> > -	if (!len)
> > +	size = range_len(&info->dvsec_range[which]);
> > +	if (!size)
> >  		return -ENOENT;
> > +	base = cxl_xlat_to_hpa(info->dvsec_range[which].start, cxlhdm);
> 
> Wait, the dvsec_range addresses are read from the registers, they are
> already HPAs, shouldn't this be the "to SPA" flavor translation?

Yes, the naming is a little confusing at all.

The intention here was somehow "corrected" hpa, as it is later used in
cxld->"hpa"_range, and that is meant to be hpa == spa. That will
change anyway with a rework.

> 
> >  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> >  	cxld->commit = NULL;
> >  	cxld->reset = NULL;
> > -	cxld->hpa_range = info->dvsec_range[which];
> > +	cxld->hpa_range = (struct range) {
> > +		.start = base,
> > +		.end = base + size -1,
> > +	};
> 
> I think it is confusing to change the software tracking of 'struct
> cxl_decoder' to be in SPA, can this be kept as HPA tracking and then
> fixup the locations that compare against SPAs, like CFWMS values and the
> iomem_resource tree, to do the conversion?

In sysfs the addresses should be shown as SPA. If hpa_range is always
an SPA there is the advantage that only the access to the registers
needs translation. If that changes, the accessors of hpa_range need
conversion. Need to check impact of this.

Possibly we could maintain both ranges, e.g. another spa_range that
contains cached values with the translated addresses.

That said, regarding naming, an HPA is an address that can be
read/written from/to the HDM decoder cap regs or the range regs,
right?

> 
> >  
> >  	/*
> >  	 * Set the emulated decoder as locked pending additional support to
> > @@ -770,14 +805,14 @@ static int cxl_setup_hdm_decoder_from_dvsec(
> >  	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> >  	port->commit_end = cxld->id;
> >  
> > -	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
> > +	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, size, 0);
> >  	if (rc) {
> >  		dev_err(&port->dev,
> >  			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> > -			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
> > +			port->id, cxld->id, *dpa_base, *dpa_base + size - 1, rc);
> >  		return rc;
> >  	}
> > -	*dpa_base += len;
> > +	*dpa_base += size;
> >  	cxled->state = CXL_DECODER_STATE_AUTO;
> >  
> >  	return 0;
> > @@ -787,6 +822,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  			    int *target_map, void __iomem *hdm, int which,
> >  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
> >  {
> > +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> >  	struct cxl_endpoint_decoder *cxled = NULL;
> >  	u64 size, base, skip, dpa_size, lo, hi;
> >  	bool committed;
> > @@ -823,6 +859,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  
> >  	if (info)
> >  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> > +
> > +	base = cxl_xlat_to_hpa(base, cxlhdm);
> > +
> >  	cxld->hpa_range = (struct range) {
> >  		.start = base,
> >  		.end = base + size - 1,
> > @@ -1107,16 +1146,20 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  	}
> >  
> >  	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> > -		struct device *cxld_dev;
> > -
> > -		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
> > -					     dvsec_range_allowed);
> > +		u64 base = cxl_xlat_to_hpa(info->dvsec_range[i].start, cxlhdm);
> > +		u64 size = range_len(&info->dvsec_range[i]);
> > +		struct range hpa_range = {
> > +			.start = base,
> > +			.end = base + size -1,
> > +		};
> > +		struct device *cxld_dev __free(put_device) =
> > +			cxld_dev = device_find_child(&root->dev, &hpa_range,
> > +						     dvsec_range_allowed);
> >  		if (!cxld_dev) {
> >  			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
> >  			continue;
> >  		}
> >  		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
> > -		put_device(cxld_dev);
> 
> Jarring to see this cleanup in the same patch. It deserves to be its own
> standalone cleanup patch.

Ok.

> 
> >  		allowed++;
> >  	}
> >  
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 61d9f4e00921..849ea97385c9 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -856,6 +856,7 @@ struct cxl_hdm {
> >  	unsigned int decoder_count;
> >  	unsigned int target_count;
> >  	unsigned int interleave_mask;
> > +	u64 base_hpa;
> 
> So, per the concern above, each @cxlhdm instance exists within a port
> hierarchy. It is only the top of that port hiearchy that understands
> that everything underneath is within it's own CXL HPA address domain.
> 
> So I would expect that only place this value needs to be stored is in
> the cxl_port objects associated with host-bridges. The only place it
> would need to be considered is when comparing iomem_resource and region
> addresses with decoder addresses.
> 
> In other words, I think it is potentially mentally taxing to remember
> that 'struct cxl_decoder' stores translated addresses vs teaching paths
> that compare region address about the translation needed for endpoint
> decoders.

Yes, that could be moved from HDM down to the decoders and translated
addresses being kept there. That approach is more flexible to also
solve other needs, such as XOR math translations or those of other
platforms.

So will look into this.

Thanks for review.

-Robert
