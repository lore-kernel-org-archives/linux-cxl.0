Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C38F9DF
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711996464; cv=fail; b=ak/eWH8jtzhg/b3vPLr1OQ/10XY3VWH88EwhUxj0zicyYdeoUgajz62QjjXInzFvL9pY4pTqhs67lSXrPmOwMNEdh41X6nQr6ny9bOX6rKIgmNBWNzSH6VuHrtPMV58XG8dq4hCJQy/y+vmj7xyhGW1zKyKRx06Q7Q05ymZK7jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711996464; c=relaxed/simple;
	bh=vZDrxRvvvWTQqTc/3wRwOyUO0a1ezf0e7iXSDl8IvFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CeQd49VEhdVb7FrnKDid6S34tk67Apz3wjD6Z2cO5SYhBeCCQZvIB9P2mbAwXkxJq8UWQRRTmZfxAz8bhZy5ass9Dtzoxtce0Pe2Q0RDJwKmeEVzlLd+/HQ7530sD6PeIFpJwx1KOKiO3Ys8OisF4ascojP9JN6/BVLookdHV8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkAl4Dam; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkAl4Dam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711996463; x=1743532463;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vZDrxRvvvWTQqTc/3wRwOyUO0a1ezf0e7iXSDl8IvFc=;
  b=lkAl4DamFvFQY0Sqh1WH3ZGFwnXmYri6pHEje0OLr20rhndccN4mRoI4
   q6PQ1Jx3XSOJsSQMc5AmGeWtpIenk+iMnumYPWBwh31EVbbG+2wXgqrqi
   zzW3sMgSl/AHkF7zv6w9zby5zxFaNTKioMQTt8Z3mYkpAacfYCQzOuH2f
   vspOlHM4jTAw5FTUKqPWC4nGXOgksyH19AlYkmL1U/ORm1lGoYEc4xnPr
   72nhDaI+X3haGFgKOWwQ2Eflzf6tlzOtM7r2KjowbjeEEZatCp7Ol6K03
   ZvBmGeuODtgS/Y4BPR8I412wMwKmZMUc4EiDL8kP6l2d5FtjLNyUF0k7t
   w==;
X-CSE-ConnectionGUID: xBPBqnjXQcSSzATt32csOg==
X-CSE-MsgGUID: bEw1qDZVTDW1fDYaliP3Uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17860390"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17860390"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:34:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="18200093"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 11:34:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 11:34:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 11:34:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 11:34:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaD2Lg9RyVpq46vtl3iQ39R1lIHxony1nb3Nzx8SChwhK2wEUZWqMS2jDIQm1H5q8JPTgTnQmkogirk9XHu2caYUsmvkgsNf7fH4/X+VUFr9fmTjAX97vSeAdsahMBFTvZZf+CaOcYxb6YRQfrWNZf2s2udgyU2RYwhZw8erokSfcO6fAJGM0SEGYkaBx0N0yN0z8OebUPWg/FjocBwOksez2p3bvJ4UPYSOylAnwO8pHqjtAj6QchYI/gA335/55LTxDFCvmpHDr8vW9nMSgkHjduSH8KLuDX90S/Vz5+eDh76lRCbPZfEQd6qMrA6zCt4uZwBSGc4a1Y065AlFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sOBa83joB6qhaJQCrBMuGkKzj2oCOwU9n+6TrRV5+o=;
 b=SlzbBEaucY1Ws2Oq7HNVJp15ARUbaOLRi+h2OrpAyiiL4qCQ0Yz2K89gvezddMfHuz14KODYzQwbMMrYYw0zPrSWW6p9DmE+FwnnBc/jXEaN7/SzeSB2YkmbFuRT01i+L+4Xn31ls420LVcrek5QXZr5jrO91XXY/qu91GfKrMinkT761DCpr2ay/OEC4etU7+x62DMJwicVBKNt2jox0hGA/MZ1BzZfl6xsuRc7rO+cX/jn6BuDP6rxW12Jv0lUNOEztoaF2Pccx8rrx7xGy5y2W2ejd7aiya+7mCl2r4OqRCN17y8fx/Fsbl0isNV2c2D+/Ng2YqsQnVRy98hpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.20; Mon, 1 Apr
 2024 18:34:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Mon, 1 Apr 2024
 18:34:17 +0000
Date: Mon, 1 Apr 2024 11:34:15 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jim.harris@samsung.com>
CC: <linux-cxl@vger.kernel.org>, Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH] cxl/core/region: check interleave way capability
Message-ID: <660afe2726552_157862946f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240401075635.9333-1-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240401075635.9333-1-yaoxt.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:303:6a::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6124:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+CGvHQ6klHeRoLug3UP4jjJgO1TU3UZOCsdkYH8NVFqgMcs9F0CH4nuvLuRBmO6K6EaQEAikDcgl9BaaICEEIqpK3dToJoDCvrZxffmjm7mfkL1WXzhoynnCnLCdJVrLPDatkst/w6QZRee8v2Jb858IjsES4CdCEdB5vplSNHSEi7t/lQ+4envnIJ2qVm6rNWlrBsEQ/B40DoXw0wSZ8Fuciv6PpepobpUGr9SuPlg6qDTBJYpwn7LDrGznOcjxegblMZox6M04ORxXZk7sOZOpZUGpLAkBXb8C4Sc+bzjL3NasjOqIFFR1N/aoXVxb3+ZnehtaxoKwT791hMVQge/3h01b7Qa9BgdMYssDK9MOeI7PgRiQ/J7ZMUey7BxirYjx8ghTlp6CkiaU5zmSphqeQjx8DLS3hpeG2N2+F7/MJlu1ywcip9WlagBWwBlVjkThOCNjOrL1/dlbtsAj/1eO4ut3EzS9CWgFHHfmP73Jb/+dmCq6pTOhj2tfPzGYfDgsvLLB0TTmDMEfTxcbgwf4qLNPw9UwFE4F6e1bBA3Lu74hO4ITSoxNEeXFObrdJkukluzorZE5xqPDUTI00SIvVpkY6wUlaVd5Xsv5Bmo/yA5NDFgHwa8r9RN8mZK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rh5UT+qwBKCnY6bDrzitASV9VR9tXlxjG6YTLB89taNKo2a0C1FgiLceZZVt?=
 =?us-ascii?Q?IDSwj+bpjy6dcHxI6JVphKqNQpUe9RBtk8eqemZlh2Nv1hVsVSN+p3fGElS9?=
 =?us-ascii?Q?7j8SkQOzBcH6HjHcO3EWFcqKolZq+iObB68BcxMCfrP+Nkvx5nj0087Bd39j?=
 =?us-ascii?Q?k1Bv7eYqzxHUc4IX8BmBPOlOv1SD4JS8ilacwEdgmw3UNkX0B/BmsTIhAJ2R?=
 =?us-ascii?Q?3d5g+wB9KCmiY9buBnRA7IYEpLEZBqKiL2q3DRZTtfYmrW300PkK14uNvbGa?=
 =?us-ascii?Q?IFbnSN/ewC/yWB6XZlTZS8TcmQ/NJzmTrpY8ZN0QLKSlGKkB/bQIxNiSFQlU?=
 =?us-ascii?Q?bL4WQcl5MkOGN29BB1m215d5tO2sNKppXpff3Ou0F+yKY7MadebDUrdIOFas?=
 =?us-ascii?Q?YHDumqFUB1DrGLnXDudx+bH6/aGhxWxbbil+x1suB0hQApJ9czNNHAvHN1TZ?=
 =?us-ascii?Q?NPBiswZo5nUSU3rakTrvKNpZFTUHlfdt9cic6dYkzbMNLCHpeYV4OUN/4VB/?=
 =?us-ascii?Q?P2mMQGGwGJlc8F8HORhQ2LUrFUCCgn3Q6Ln5YP2TMQz+nqUd4UBqzNFI5f4H?=
 =?us-ascii?Q?GDXVf1qR6CrBLprnhmw4wb2iDn8TxuNxk5lIDtV0LPlYTryQJ8/H8f3NqUHE?=
 =?us-ascii?Q?BwE3gM+bca0ioiY8NLMJtnwsgk1YRC4Ebnrgl+e+QpkRXCIPmRUKs/vpNmlX?=
 =?us-ascii?Q?JRUJ5AmaKLx3+oiQRIydZF/NJMphxDpb5ma65jOwQYhz+8RGR3ruiZKq3ghc?=
 =?us-ascii?Q?IeRhyTwdX0BIPeTJo8iO9XvwIzXaMPqacqmheEbcNCkk19zokjrz01Ofwn/F?=
 =?us-ascii?Q?TeLS0l+3iSLZ6ecnvfuIvJgzO7VVS9WwN4pAGgozkQFDSJ/g6MMiqsVWx98X?=
 =?us-ascii?Q?GQQyDAImj9cctyDGyZ23mWimd0TrVWotxzwu0M8PMkYwYLFyklTrpq8GXFjg?=
 =?us-ascii?Q?1+M87/bVxDPL/RQMuPdvzLRInyLGp1oJbL8w5AqXBKgeRDn3W9OONBMi8+0v?=
 =?us-ascii?Q?cKlU0a+TkIf/K6m/8c5WcI0W5jGtiUH/0H0EnirBz4WwaDy5jsAm6hddHR+z?=
 =?us-ascii?Q?DQ3CFl7ZpzP/33sIFOlklJOV4ZuOhgcDiuUUHsIRBBcvA69QuQ8d0LXR5UVo?=
 =?us-ascii?Q?KDE2BzB9SV2UXWlFguAwpglcg5meP3MXISTPh3PBtu+Uq1CpgU7OW9TiZiB6?=
 =?us-ascii?Q?E4ZdC70GkOACcz60wFD18y9pygqaq7AyCy9Bu7RuTYn3hVDPzmzTsISy7HS3?=
 =?us-ascii?Q?oGqcU3hO46zPEWwfpeweGd7ZdJZ4KrYV0GQHbAdIeySAE9rQdfJndnXuK4b3?=
 =?us-ascii?Q?pPOL3fgPJ9Gal7uJxBYyVe7aswgySlsOAsuTJgEilZaiAH6Fkd80s5Z+KJ0I?=
 =?us-ascii?Q?obMUv+zTRkxSi8uZrj0LJj3kEqyQAAGHD7i8n+20OP5h7Pk/UOAqY622p0g/?=
 =?us-ascii?Q?x/rYqd+Cv9GgPA2vhIJmRYxs7IacSWeIsfA2QbA7XSMN0zaCFD3zE4mB6UED?=
 =?us-ascii?Q?39SJeIXE1JIM4hunax8dowr5m2QPlBhpd98BAblA3pw4NI8rpjAGAGyEoX3q?=
 =?us-ascii?Q?OyJDCA8ech5NfRU7AyM96um7F7CWKoXelfjt65/bv1zcot5autHi4Wer8E+F?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5072a30-64c8-4338-c771-08dc527a56c0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 18:34:17.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0EGdwbM+4j1YasvRsCt4kd9Ia2/g3+CuuGuXhxCCI+pPM8VLja5aeoVpUaZ3LK6vrxpiBedk5LdEEp08xMPhSKFmbxdcgrXgwWn+AyE97c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-OriginatorOrg: intel.com

Yao Xingtao wrote:
> I used qemu to emulaute the cxl.mem and attmpted to create a 6-way
> region, the region was created successfully, but I could not access the
> memory properly:
> $ numactl -m 2 ls
> Segmentation fault (core dumped)
> 
> I found the root cause is that the logic of converting HPA to DPA for
> 3-way, 6-way and 12-way were not implimented on qemu side.
> 
> But qemu has already disable the capability, so we should not create
> region in such ways.
> 
> So I think we should check whether the interleave way is supported by
> the target while attaching it to region.

Good find!

Not only does this need to happen for 3, 6, 12, but it also needs to be
checked to make sure the device can support interleaves on address bits
11to8 and 14to12 (CXL_HDM_DECODER_INTERLEAVE_11_8,
CXL_HDM_DECODER_INTERLEAVE_14_12).

As it stands the 'struct cxl_hdm' 'interleave_mask' attribute is unused,
and IIRC was meant to support this capabilty check.

> Link: https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fujitsu.com/T/#r

This can be trimmed to:

Link: http://lore.kernel.org/r/20240327014653.26623-1-yaoxt.fnst@fujitsu.com

> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/region.c | 25 +++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..dde66b7c9e3f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1786,6 +1786,24 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static bool check_iw_capability(struct cxl_endpoint_decoder *cxled, u8 iw)
> +{
> +	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	u32 cap;
> +
> +	cap = readl(hdm + CXL_HDM_DECODER_CAP_OFFSET);
> +	if (!FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, cap) &&
> +	    (iw == 3 || iw == 6 || iw == 12))
> +		return false;
> +
> +	if (!FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, cap) && iw == 16)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1796,6 +1814,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_dport *dport;
>  	int rc = -ENXIO;
>  
> +	if (!check_iw_capability(cxled, p->interleave_ways)) {
> +		dev_dbg(&cxlr->dev,
> +			"%s with region interleave ways: %d is not supported\n",
> +			dev_name(&cxled->cxld.dev), p->interleave_ways);
> +		return -EOPNOTSUPP;
> +	}

In order to validate the address-bit capabilities of the endpoint this
routine will also need the 'interleave_granularity' argument.
