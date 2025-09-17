Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF131BCB7;
	Wed, 17 Sep 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099854; cv=fail; b=FdHAc9A76bhun6uC7nqLvH221jJhO/X9VRmKbM04NM88//4zj7yqo/ArEqG9gRE/h1SD5E2m4LgkJdk03VB1xcKK/cv3zBvOuCSd/ZXRxEr7d4VKQAZKuqTUDCmYwOg4ri41X0SohCZBsT/7VgIrM5+9Z0M0pZRAFeMrb7BjfhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099854; c=relaxed/simple;
	bh=1OSFfv1MbGjlc7ToYX0Ddxa62FymuskZPQCXfKGzH4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r3ItsQvtSX/l/Ef9i+mnPvzfhuLXPklGwOf6LE43D5VIgcIz1P4C11zj8Xc8Dby3zxBwEPUkWYU8fQKH0UOCJNVlbg2IYJhFiRkg4fMHOxnJgVo7qiqu/xQt0CDt7N10om3oQXr00ewpTejmXECbx+wyxfHlbENNb7svZpdIyyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=diAnWUF1; arc=fail smtp.client-ip=40.93.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="diAnWUF1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+pmvjIUVPNyaz3nAc/hkHbh2TI4Hn4PYbTlLnblCIRAHK87IGhFESsLEGHgITIW/mFLU2BNY9p9J6N+XXx1O2Af6WiJrI0TycaCyNIctOzl3heYzUHEsfZF31sCC2wt5Eyr+gHeLEWTxGJQYPK69lXEOXJQFYzya9JuyX+vInpyB5DJV6iZZGIt07KL/ihreFTlxUCmgcEw6c1SgeXvQ5+gimzCG15IMemqD1qknAiyaNg6AtKF/2iL+coiiYYM4gDKHbI9w+OXtYwgqPNuwIeZFIabEX6/weTFSuUG1p7gLFTMVicypRRol7AUbAvXP7UujCqBtSIh7d/25v50bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBISqZ6Tz1NyKnrqtUoXJd6ym4VMAMQreDpcy6wO+NY=;
 b=ej00k1DVXqM25kIk04QDCxP9o+wZx7/QA+iv+P5dqw7B+4xv91LolIg+CsaFO7epPu91cfiHrE1g+Dn67GUEugA/U3nyKZ8OpQnUvBoJr3nToTsICmdAfW2vunbH0Rey5UDu2aspfW3BLkC0WHVRclLeVg2sbt6SU05HAS/FMOS5inymurjg1+ye4eQnuU89NJjD0boqvWpfJGuzSgQL8ItTDdH9ICCIf4+QEORRr6SBh9aOc2bM1VBBtWqTVxhF5r34MVuPRbCWWFCQjSG1fmISSGRL/DctV/lia9phGN1OBggq5vwp/jFhjBKyRN8JjkQzjJ4LnZ1RY+DAGTspAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBISqZ6Tz1NyKnrqtUoXJd6ym4VMAMQreDpcy6wO+NY=;
 b=diAnWUF1OqagH3w/eTYHQJdFlCwCef2YuA6r1IRFah00M0kk9UyXq9TU8DYkQxwZ2bd7jyuL9oNqmalKqge4KNnSUyk4TPdSlX4PJr45+LjcMpJCKYOToDoNZP7GRVm77+OVlCVAyBX5D9lqL5TzwXtOYhe6dZWbHtPv5mgjOfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 09:04:09 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 09:04:09 +0000
Date: Wed, 17 Sep 2025 11:04:03 +0200
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
Subject: Re: [PATCH v3 08/11] cxl/region: Implement endpoint decoder address
 translation
Message-ID: <aMp5gw2kSsavhdmg@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-9-rrichter@amd.com>
 <20250915114614.000053f1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915114614.000053f1@huawei.com>
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa5be9b-425c-489c-5df0-08ddf5c929d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9DPZ5pr7SgmUe5RsYbEHTZqrELjZq5ntvJhzjblxANC/G2MpIMS8aM/I1zA2?=
 =?us-ascii?Q?HCQyVn1AdvAor/P6nYqjPiinE6Ppkft2Ibg5oywR7qu97R7ulcf4foPosyqw?=
 =?us-ascii?Q?seJvgFz1SwEHspXcdWyR2Tj361OPnqOVD+qyAvY5g+Igb1HGyFU1N5eW9ldZ?=
 =?us-ascii?Q?0FZwh0TnnV9d9vYQbsU7znFYl9PX5JZPByMHRH+d07PZqkyyC7yZaMGp5Rqn?=
 =?us-ascii?Q?sEjnc7N/H6WjeUAcindCbLJLqIKAADuqdeW6rayRduAD1pDuY4pubVXk97sq?=
 =?us-ascii?Q?ipqxnIsBqAW3WZczydppbetDLV1hMmvEJG9KaV5AjOcrKo8x9B3w8LFM4Ea9?=
 =?us-ascii?Q?71tOVQKkKWsX8znuLE6ZKlhGLSPwsvdV2Jo6eZBXEiqOj1F9/KGXP8xfzUDf?=
 =?us-ascii?Q?u8BPQSVHTitt0ngIExaDn48jv14DzdcyIFaTDm4i3FsC8UOHOGt+K0wG+/6m?=
 =?us-ascii?Q?myponwB2I4viK+19tCoiKt1p66wUuuFmsHTQqU2qd9iijNfDtswLp1FcczLw?=
 =?us-ascii?Q?oRUEtjfkaZohMzUAIuOI+ceJNa2yJhSLdqYqsdyCZkXt2YtNGo+Gy79yvHPt?=
 =?us-ascii?Q?5vCi8qBW03BabmwIyLzbT/RT+UcW6oqqZ1nrqVH91YYmFlfIho+t/uYUf3jy?=
 =?us-ascii?Q?ni9NvuyrgX0Dv80QXUl4nwMG+m9L99YXxe8CuBiHVErhTF7wxdo7m0NeC79c?=
 =?us-ascii?Q?4zo4r/WE0dUmC2gd++pmw7o3oZ44QImOHc3KQfO3YGThL5Yej1nAsJ/PYm3s?=
 =?us-ascii?Q?uw+BzogHpVXF5rvFiDlNjjUEva1lLA9vGLs/yUXnhGhoIvuU8UIEHwSB5ewT?=
 =?us-ascii?Q?kj5dxJ6ybLV0cZcgnIA6TULwKdMpqui5SlZDD3JQqIRIYMJnLgpEJZcAbuj8?=
 =?us-ascii?Q?nobNNzmdhylecn4JZI4q6P+E/RUPYYSzP3yGvtLm9IYXT40lqPo+yYL/ykhD?=
 =?us-ascii?Q?5YQh8l8rlUp2TR/8HYT8+VFvyx2mZCDCtQzpnOa534PwzMw412U8u06rCABs?=
 =?us-ascii?Q?CAt5iCRviUHwQx+uCSw/IJ5m95RqzfSpiLWCq3pP4YhyK2arPvysyV2z54nB?=
 =?us-ascii?Q?sndn0+Xjza7Rcni3dZW9HIVr2Ar/UCcD2Blw+X25LSbgdLa8I3RTwD7aLaNz?=
 =?us-ascii?Q?PQuKXsXcq7Nocz0sXR7x5Xg4jg04PbawjXbkB+uV6w3nSi3tEG/UY/D7NTCn?=
 =?us-ascii?Q?Ei+WrJcqvMTE4srF385+yHEE21DL0awzK8XQJzPi2Me0vEHX/a9hmTwtnTUi?=
 =?us-ascii?Q?ZvynG4KSDOA5TEacHuRfsDKUpbozFJU+V3ky7lNtSXUjMc7Vn9Atf772IgnQ?=
 =?us-ascii?Q?VY2NmYZLuLYZV+DBapMM7PjeMdgVty9Yq9ZSMf0Mz0tJWWvfbMNgdVfmyfhj?=
 =?us-ascii?Q?Yyc6DLVU5vAtDCUCN3bi41InI3GJT3fDRXrfZIpG73tOYFlJf8XnGUymWr00?=
 =?us-ascii?Q?BSHRkEYSGLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G6uMRDE4U2OcJV/HWbeYi+wZ7hVP/RDLf3GgjD8bsd1+sjgzOD8/5gvt6wAB?=
 =?us-ascii?Q?sVzisBQgqH/Ts97L07Po0BkXjnjR1p7qhAJKCbYQnriBoYpkffTUE8VZvWpW?=
 =?us-ascii?Q?FWQlnR8ykZuqwRjxPzOvQQ6TMSEdF3ijczT2m+XESx5tZyZq3uiYSDqq1cSn?=
 =?us-ascii?Q?eB1+jBiuiTgI819T81zfYM7dSbXJrjx7uOPH4CV0IEgWuRop/K4BD6Ag563T?=
 =?us-ascii?Q?QaSXK8l+muEfixcdk/l7qsJLSDCmpqpnxKszyT3zKSiv9JM8JTe5X31MjO79?=
 =?us-ascii?Q?jeO47IWZVJLDSPczhrCemvWgAhEv1T6xo1R0lizwbsL1rOzX9aMO5UUSZhhN?=
 =?us-ascii?Q?32v7YgLEcuyD39DOvuqi4W25UxVP2JpYUpCpV3SrfFU7xqzUKM8zAMcz1l7A?=
 =?us-ascii?Q?O4qndsUyQKLhE7g3bcnRkC/So7a5lrQSXljLMIeFXVkswbKyU6RF6snR2HS2?=
 =?us-ascii?Q?6d+14hLQZFN1sCQbKuByWAK4bYfjZQtHGbMFu541HTVEMmfUjn5xOaE7lCz5?=
 =?us-ascii?Q?EvrraPpzBY93L1KMRqqubMTlx2oXJSRBwmc/fWkaYUEM0M1vhfMGkQYBlsZE?=
 =?us-ascii?Q?BK7LldshzXfOmeproqfVUrlN2vdCDx7kVmcIvbhH7Lyn+4w+4lzKQMt+TJz+?=
 =?us-ascii?Q?V9HMP1s+UK1Jhlpu14+xBgYnJ4FKchcvv0p5xxM7CYZ+waDD+eYy6M+RBgEi?=
 =?us-ascii?Q?zW04aIG7gkwQmCs6Vpbc0PBk51z58nqDGeWbLHcPnhPQLmLWwVk3w3+nM/0G?=
 =?us-ascii?Q?pv1c/NYR/+SP+s3gU/WkcO8pLetSNxpc3R369PZgaSW9AQ9cgyyz2g8aprMY?=
 =?us-ascii?Q?9DCmPNbONh2EXVmqNPJhr4K6Iodj3E+1vC9ZiujB6fJcXFb77lymZnm9I04q?=
 =?us-ascii?Q?wbv4chXHDtXI94Kt+SdmMvj8lN2kE7wcHywieMnmA6Q8f7/F7/fCIdi5lk+M?=
 =?us-ascii?Q?Y8MNBfGjLV+8/K/RJqZjdT8KK2Sp88B2/iWQDoz1IcQVNJq4IdZm9DbgcuHQ?=
 =?us-ascii?Q?ZgaAaObtF2EJNduD3AcvkM54/Zz5nwLygk/xcbgDzEDD5zkD3JPu4K0wt0L+?=
 =?us-ascii?Q?3Fltc3GFvacLhlm+e9vNk534pZ6sB3RSgoYBOBN7gzhQMNx5oY0bml7cojlu?=
 =?us-ascii?Q?sG48MvouEwZwbqKdrXPGJfl7fA+Od3b86Ofb6dkglAjR1AIuQLmYqSWqYkqO?=
 =?us-ascii?Q?3z8F9fN80eB/CwPJP0e1H4B2QvEhmnfTkEQM0yASEXx9WY94AEpw9YdR02sB?=
 =?us-ascii?Q?vMTl2t0YGFfeXJOE/gRoX4HJbszbWV68NfmQ+pUIbLZ/Pusi2Hvd8tFV+8HW?=
 =?us-ascii?Q?vW0oFYWy33kOQsRlEWAtbyeG4MB5iLcU0aGcPuoBWOoItAhhkw2bbkidbiYm?=
 =?us-ascii?Q?/KU2gJE2kUILiV17iWJ6R8Yu/VstuLjgImSKtedtmCQ4gYFJPs98MDrNMoTR?=
 =?us-ascii?Q?EvEvCVVp/Wg0xaPHGJmp7yweDkKBUthzzEb9oBruyu3Qz1IEs6ENgTu4Lxgz?=
 =?us-ascii?Q?nnvZLnYfgW4Z458gz/tW96B35rLaxWfWSNK3+60qvxfFAVD/F7Ozb4VrRKVp?=
 =?us-ascii?Q?aDyIwt7dDLnqhRFHGnoNVtltkec1I4tx0jAbcC1a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa5be9b-425c-489c-5df0-08ddf5c929d7
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:04:09.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8PHvN//ajm3raxqHcnOt1BeRHPXaLHeRuO5ah1K6AYFmYw5lujKfuXQYFCRrATKc2ocdEcR5uzJbUqC5APdiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073

On 15.09.25 11:46:14, Jonathan Cameron wrote:
> On Fri, 12 Sep 2025 16:45:10 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Systems that need address translation have the endpoint decoders
> > programmed for a different address space. Host physical addresses
> > (HPA) are different from their system physical addresses (SPA). The
> > decoder's address range and interleaving configuration of such
> > endpoints cannot be used to determine the region parameters. The
> > region's address range must be SPA which the decoder does not
> > provide. In addition, an endpoint's incoming HPA is already converted
> > to the devices physical address (DPA). Thus it has interleaving
> > disabled.
> > 
> > Address translation may provide different ways to determine an
> > endpoint's SPA, e.g. it may support a firmware call. This allows the
> > determination of the region's parameters without inspecting the
> > endpoint decoders.
> > 
> > Implement the setup of address translation given there is a function
> > to convert an endpoint's HPA (which is identical to its DPA) to an
> > SPA. Use the previously introduced cxl_to_hpa_fn callback for this.
> > Convert the decoder's address range and ensure it is 256MB aligned.
> > 
> > Identify the region's interleaving ways by inspecting the address
> > ranges. Also determine the interleaving granularity using the address
> > translation callback. Note that the position of the chunk from one
> > interleaving block to the next may vary and thus cannot be considered
> > constant. Address offsets larger than the interleaving block size
> > cannot be used to calculate the granularity. Thus, probe the
> > granularity using address translation for various HPAs in the same
> > interleaving block.
> > 
> > Note that this patch does not yet enable address translation as
> > callbacks have not been initialized.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 95 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 94 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 57697504410b..9fb1e9508213 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3422,16 +3422,109 @@ struct cxl_region_context {
> >  	int interleave_granularity;
> >  };
> >  
> > +static int setup_address_translation(struct cxl_endpoint_decoder *cxled,
> > +				     struct cxl_region_context *ctx)
> > +{
> > +	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent->parent);
> 
> When there is a parent->parent it always makes me nervous that I haven't
> reasoned out what port this actually is. A comment would help or
> a more specific macro where the name lets us know what we are getting.

Yes, will improve that. Since the implemenatation will be changed to
be more specific to only translate cxled -> host_bridge, this section
will become more readable as well.

> 
> > +	struct cxl_decoder *cxld = &cxled->cxld;
> > +	struct range range = ctx->hpa_range;
> > +	u64 spa_len, len = range_len(&range);
> > +	u64 addr, base = range.start;
> > +	int ways, gran;
> > +
> > +	if (!len || !port->to_hpa)
> > +		return 0;
> > +
> > +	if (!IS_ALIGNED(range.start, SZ_256M) ||
> > +	    !IS_ALIGNED(range.end + 1, SZ_256M)) {
> > +		dev_warn(&port->dev,
> > +			"CXL address translation: Unaligned decoder HPA range: %#llx-%#llx(%s)\n",
> > +			range.start, range.end, dev_name(&cxld->dev));
> > +		return -ENXIO;
> > +	}
> > +
> > +	/* Translate HPA range to SPA. */
> > +	range.start = port->to_hpa(cxld, range.start);
> 
> This is where the generic naming as 'range' gets really confusing.
> hpa_range etc with separate struct range for each would definitely help
> 
> For the checks and inputs maybe just use ctx->hpa_range directly.
> 
> 
> > +	range.end = port->to_hpa(cxld, range.end);
> Perhaps use the DEFINE_RANGE macro or 
> 	range = (struct range) {
> 		.start = ...
> style as per earlier patches.

Ok.


> 
> > +
> > +	if (range.start == ULLONG_MAX || range.end == ULLONG_MAX) {
> > +		dev_warn(&port->dev,
> > +			"CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
> > +			range.start, range.end, ctx->hpa_range.start,
> > +			ctx->hpa_range.end, dev_name(&cxld->dev));
> > +		return -ENXIO;
> > +	}
> > +
> > +	/*
> > +	 * Since translated addresses include the interleaving
> > +	 * offsets, align the range to 256 MB.
> 
> So we pass in an HPA range without interleaving offsets and get back
> one with them?  Is that unavoidable, or can we potentially push
> this bit into the callback?  Probably with separate callbacks to
> get the interleave details.

While the translation is used here to get the HPA range for whole
region regardless of the specific endpoint, the call should also
provide translated addresses of the endpoint, esp. for a later use in
tracing and error reporting. As this function extracts the range, do
the alignment here too and not in the callback.

> 
> Overall I'm not really following what is going on here.  Maybe
> some ascii art would help?

Uh, how about this:

   ___ Start of region
  /                                                  End of region ___
 /                                                                    \
|----------------------------------------------------------------------|
| chunk 1 | chunk 2 | ... |  ................ | chunk1 | chunk 2 | ... |
|----------------------------------------------------------------------|
\          \                                 /        /
 \          \___ Start HPA EP2              /        /
  \___  Start HPA EP1                      /        /
                          End HPA EP1 ____/        /
                                  End HPA EP2 ____/

As regions are aligned 256MB, use that instead of the gran * ways
blocksize.

> 
> > +	 */
> > +	range.start = ALIGN_DOWN(range.start, SZ_256M);
> > +	range.end = ALIGN(range.end, SZ_256M) - 1;
> > +
> > +	spa_len = range_len(&range);
> > +	if (!len || !spa_len || spa_len % len) {
> > +		dev_warn(&port->dev,
> > +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
> > +			range.start, range.end, ctx->hpa_range.start,
> > +			ctx->hpa_range.end, dev_name(&cxld->dev));
> > +		return -ENXIO;
> > +	}
> > +
> > +	ways = spa_len / len;
> > +	gran = SZ_256;
> > +
> > +	/*
> > +	 * Determine interleave granularity
> > +	 *
> > +	 * Note: The position of the chunk from one interleaving block
> > +	 * to the next may vary and thus cannot be considered
> > +	 * constant. Address offsets larger than the interleaving
> > +	 * block size cannot be used to calculate the granularity.
> > +	 */
> > +	while (ways > 1 && gran <= SZ_16M) {
> > +		addr = port->to_hpa(cxld, base + gran);
> > +		if (addr != base + gran)
> > +			break;
> > +		gran <<= 1;
> > +	}
> > +
> > +	if (gran > SZ_16M) {
> > +		dev_warn(&port->dev,
> > +			"CXL address translation: Cannot determine granularity: %#llx-%#llx:%#llx-%#llx(%s)\n",
> > +			range.start, range.end, ctx->hpa_range.start,
> > +			ctx->hpa_range.end, dev_name(&cxld->dev));
> > +		return -ENXIO;
> > +	}
> > +
> > +	ctx->hpa_range = range;
> > +	ctx->interleave_ways = ways;
> > +	ctx->interleave_granularity = gran;
> > +
> > +	dev_dbg(&cxld->dev,
> > +		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
> > +		dev_name(ctx->cxlmd->dev.parent), base, len, range.start,
> > +		spa_len, ways, gran);
> > +
> > +	return 0;
> > +}
> > +
> >  static int setup_region_params(struct cxl_endpoint_decoder *cxled,
> >  			       struct cxl_region_context *ctx)
> >  {
> > +	int rc;
> > +
> >  	ctx->cxled = cxled;
> >  	ctx->cxlmd = cxled_to_memdev(cxled);
> >  	ctx->hpa_range = cxled->cxld.hpa_range;
> >  	ctx->interleave_ways = cxled->cxld.interleave_ways;
> >  	ctx->interleave_granularity = cxled->cxld.interleave_granularity;
> >  
> > -	return 0;
> > +	rc = setup_address_translation(cxled, ctx);
> 
> A quick search suggested nothing new gets added after this. As such
> 	return setup_address_translation(...);
> is probably appropriate here.
> 
> 
> > +	if (rc)
> > +		return rc;
> > +
> > +	return rc;

Considered a tail call here too but dropped that idea. That would
suggest the function should not be extended. But function is open to
extend the setup, maybe Low Memory Hole or so. However, there are
advantages for both and can change that.

Thanks for review,

-Robert

> >  }
> >  
> >  static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> 
