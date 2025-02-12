Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED294205AA3;
	Wed, 12 Feb 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351313; cv=fail; b=flNTv+2GdgWdW2G1nBPzYokk3vO0JVm/r92bpnywm+Mvangg59JAWs8ZdHyM7aGE8YcGhjNReNoy3zmKJP2Va9xpYOm2xW/ON/Ktw5nYb3D7oMLofhOsbUc1/BHiOFXwBs92GX4JvwlmcgQ7+VlO5viA973GbqcfTazktOP0rMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351313; c=relaxed/simple;
	bh=Q8Vw3tFOJcHghZzeKtboCPyg0v0oiK5gp7AXx2yz6IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mf36Isz/omCJ+DIF6q7Tf/gcHuaBB/mG6y7uVfBfWjSYa1xiGx4SYG/ZcgRALg4zk6iDsvrMPckli5+ja2N5oUXUTWDwUgrH6hubmDtiycqADeTJNbc8YnqYUofpFw2QLrNlhQFguIaf8IhwYSxPsspwciZBSqBKGWWxjqPpMMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ngMm/Wgk; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ngMm/Wgk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkXGpgLQkiXxdz9gEWcJMnCA8yewfmajYHqJv5xeRHzCQ+MFFcyECRqegJRp/UI39bvqGtxil47opy2UZf+LkIlG3sYgOJK92KeFDhSteKRgQ6QcCnbxao5jCzvb/sgXAXyKe7u6u7nQEe8w0wg47F+I1J0rSQYBFUQ5FAm854x5HyFihv3Exzgm1sgKgHi2WEZ9lZJNspmii2D8HoSenwNGCZjwp6i+zI/EjT2vWQFDAOpCBAegUv8KadOypmAuWXHZYRn1Ce5k+CoU3TJ7W30JLnWplJCxnQjsVnfjozg+fCmSFAhKcH/Dgc1AL18OT2BFNGagtwEgP/AwiNWlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aw4ODieI7kma0vxmSFfrV8sRhXBbUexIUuG6fOfqsY=;
 b=bMcQtSPivH0neWycLgUPKH1IkW62E1+o6e+JT/tB9PDzgJKxjfdPLejPrrWzxvfkKmD2mrfs+sMrZZGK97ojk6W0P45AaQc2wFlNS+pO0W1QAgqfvoILQB1OjVziv5cNnR9XxfmUUVi5EqBhTK7O83kOcBkw9XSUdCUz/MZrWlme8maW2PFsbqq04zy5KTSiCgAqqMNwqsQqYffxv3ocB4+USM7IPCH1nZ7Dz0VTzwFwXn9U6Vuzq49uohOkvfPtjKeLzlB29ETg3VVTyIimKJ4lVieAf+Px7fLzcz5XLWzPPVR2zv5p+xYn3oe3qnp06TLugbneD7lEDK3m+EPz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aw4ODieI7kma0vxmSFfrV8sRhXBbUexIUuG6fOfqsY=;
 b=ngMm/WgkTlJsn4P+MJJB+YSNW70XZ48rwV8X9rbrkYg2EE3m3++ucxKruKIii4SojSKSLoOZyGlUI4JhYyGh64UuopIDWqLcfqnyy4Hu3vbr3h33VLvPIWppv94QC1qTXAi28TSnH5YrwRPnyPDQ9isAsZ2kkH5vHiWDj8ZbeuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 12 Feb
 2025 09:08:29 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 09:08:29 +0000
Date: Wed, 12 Feb 2025 10:08:23 +0100
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
Subject: Re: [PATCH v1 28/29] cxl/region: Show message on broken target list
Message-ID: <Z6xlB5Gw-8vJjHe1@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-29-rrichter@amd.com>
 <20250114111641.00001cf5@huawei.com>
 <Z6UoXDqmh3ARH_10@rric.localdomain>
 <20250207175139.00007ad6@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207175139.00007ad6@huawei.com>
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c4409d-42df-46d1-c992-08dd4b44d131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8pURyQMHKmfoDW5cL8z0MB23ydbQuoyHJ/eRcvpooH9ZUEZNR4oBBZJMpYMT?=
 =?us-ascii?Q?Mk87CoeajChFV9kZCqPdV1uXiFOiKzNIbH92DA2LzK80TYv6SoPNyMKBs1wE?=
 =?us-ascii?Q?qTWbBtzepINpVlTl5+F9c6YVx1I9C5COpfNFBUXk1ciXy0hzV1hh7n1GhQ8b?=
 =?us-ascii?Q?+0Q6ofecHQCmHONYQTcj4HQFod8Lj6AANwMbgprH9zv1Z/QrhN6fdhiXBaTp?=
 =?us-ascii?Q?NH8xYmwNR/XIyLebENCopzLEBBK0wOyDPSsQXM11CmAosNrw3o8/L7H7njTm?=
 =?us-ascii?Q?h5K64bdgFTeyUIAeV9L2KG5IeKIXX+NthvXKO+SIRWpB/Sz8gbjmZ4vGbkNx?=
 =?us-ascii?Q?xbc56ZfWuqLv2W+LqZjkQssVCmIRssA0Eecc0TkEH/AnA0XUkYyWJ7/2BAEQ?=
 =?us-ascii?Q?xxLSvrAKELBrgtR6Vr+prRp42Xi50jdRYZbcvAIpbpkBM26umjwpQTD7RQzo?=
 =?us-ascii?Q?Tou6vnSz+B0urojJCumc6xo/H5sBWtv1LQj6V3V4QnxjoDqTuV/41NaqBsKJ?=
 =?us-ascii?Q?ywX3qqQizvwxtldCUIBe/jCTUT3vNJGhEQb16z7yGvZ8lORkv8ljvq+KkX98?=
 =?us-ascii?Q?SSXPTInSqrh5tyuPeXdMU9ISjFABHCJzIM8j318Dn7LIRLGFOqpYeIqgmuSC?=
 =?us-ascii?Q?W6rzSNr6jE0r/1sZih6zozbdI32JXgOR8BfZtep7itOeQV6+7Y0UXN9OI/po?=
 =?us-ascii?Q?n7OTfLU5xbXyfhZf46ecXDCc69u3rfMZKNbyF1aXnbSiVEek0Ay5EbWU88cb?=
 =?us-ascii?Q?vB6nmAgTOVUGlWL60QKU0UbW2z6/Qm0JSIgOFzpISwkqMzRi0AjlhvWupXgS?=
 =?us-ascii?Q?9WU7eVJ74s4R0x5ljZW6ztMSxhiTY3Uh8H4SC1Pa9AhKVkYkfOnasmB9d+n7?=
 =?us-ascii?Q?NN0wT8o9Yqk53rQa3tB289fckGdvl3iP8Cas2GaJQkdtSVQOr5E4aFwyYOBC?=
 =?us-ascii?Q?FaEAsNAoqx5U20Oxi6UxMzffU5dMTnd6cv5IuW5lUcIoHdIHnwY0QohM7J/j?=
 =?us-ascii?Q?i/jfi4iVL58dnjySd7BBgKrDuRQLkxiuSTEth7j6cVN0mlIYPlC/+OUJaFQc?=
 =?us-ascii?Q?ryNHqAfvYL7Ge0V0QisaFde5kssCQ099Y+ZwvTMOb3QGzByO+wF38vun9OwI?=
 =?us-ascii?Q?LHNYZn63cK4B6UGd1jM3NPO8fO2IMlwh951He+1O8mJQyZVm+2Nlvv0gA2JJ?=
 =?us-ascii?Q?Q3xNoivFwKissAYkZ9YTAkU4NaUr7F1i40UxF3FD4jkTwA0QVk1nlBDhpdwJ?=
 =?us-ascii?Q?/S9zvvhkXbbh+oxX/8dXslD86QMxTQZQcJqAgb2J/AgBDNpBM1BFOoUWJ2KK?=
 =?us-ascii?Q?1bj+8QsYie5rKJw5CDTZljtOm590mFei2Kxe/DXCtGXTIq1ohfTQ3H3Ik0nl?=
 =?us-ascii?Q?FLND9w+wuBvFx8c6Pnd9vJ8Cro/R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XBCpt9ONEKBR3dbCoqxpNweJoeIXilV6OPiVRHOGsggFZ7SssxPeg99UiFk9?=
 =?us-ascii?Q?7jUB/q2lkgY7HYWsTmStUjg4FoOumCZfDDwS+EehDz9vHwrVaf8haly4dNen?=
 =?us-ascii?Q?uUCRajnIN5DQk5tsMFS+y7PXQ/pBXj9RkSpBQrhqz+vQXh6TcXs4Q9Xg5YhD?=
 =?us-ascii?Q?rzSBWFIVnSiF4j0IdV2z4MoT91AGImInXKG19C7/a3H8nrbQ3+h2c9KGt86D?=
 =?us-ascii?Q?Q2GvnXrHHodRsP1T7fOz+sjvDCltN4N4iastVlPYZ+WqMuSt6pm6zz105krA?=
 =?us-ascii?Q?6hQ53sNcNJQqQ7LEh/+LpLvzyhUE/wTLmVkiM7Q1Eqnd2sBEXp+qE67tZYue?=
 =?us-ascii?Q?QRzHEVvyTQgneWdl/qSntzve9EGwQQpTSMcCnH6rJcSKP/S2C4gQY1nWT6ZW?=
 =?us-ascii?Q?hxVH4rKaAnElq6HGyHHJ70hGQ0kE/LbeBDxTn2CtrqB3iETs6CLvk7Yg19fo?=
 =?us-ascii?Q?2bqyV4B7fLpE4iZXxGISYsQKcShMT1zkKVJjpwsyz53QtcXXyWapN56qnM7d?=
 =?us-ascii?Q?nUgWgTA8gE2recwmrSMqkXkfYFEgu8+wdcUOnxq8LoZCD0uLm6LLYhMdzEV5?=
 =?us-ascii?Q?uplV0W4ofvE3VaFVTACM0ihCRiYAwgT97llo9hfCcOm+okRapFQyM5JBkgBA?=
 =?us-ascii?Q?CH6Ulkw1WNH+hnLY3ZoN71R2HIasXqHXWfRkZzC1RL437RZOAXDDdArYOes7?=
 =?us-ascii?Q?jj8gwTLv9eVb+E3JKWv/X63TG5XPeF2iqAICzbYQGk56T1Z0mB0CFSDI98m0?=
 =?us-ascii?Q?6x1qXQR27HTKj/XBrAX5FmpA3/ZtjjijrdjZKgTSHc2krLPMHus2a1LGphxA?=
 =?us-ascii?Q?9yTfi4FKQqpIIjfJMBVvEXSkLJasNqCzHRqHtKxyemko7ivlYifncrUVU8Sb?=
 =?us-ascii?Q?AeVBEraXG+rxSIWmJ1tVQ3NBmGGTYOJFI0t6w4VJ4dyZCu+e6EBVh+5iH/oK?=
 =?us-ascii?Q?Sk7DsOBthsLVxzWrzHSXjj3o/ARKJssSw6a+F/U9M33ILVMT3XVnuihN3KIU?=
 =?us-ascii?Q?MEmJG57HAruY1EfZFpCz+5LpUCaJIsZKeVHKXufuCVIS6xs13dugvKS7Bt2c?=
 =?us-ascii?Q?gg0OWX9T7n1iRwjDBk49L2Aa//Saq+vE8z6jh6t5w6LNaKVvc3F5gFcwNrM3?=
 =?us-ascii?Q?wo4KgJ6vWKz95g0TUG0ktOWaGsCgvrzbvkV1m3G1P4pnUf3i+Sr0gZDs+05W?=
 =?us-ascii?Q?df4FjnSkqxb18uSkBhQpYlyTD1llYdopfekkHGjE2hDVKIaoPavUiIL1az3F?=
 =?us-ascii?Q?oWAOBsG3G14nTHg4wR7Lxlq8nI03oPBI8/mHd5jK1imhpoQCGQhfSTzmSrii?=
 =?us-ascii?Q?CGZlin1B/JLYVzHWRrJ+WoKPaBIDOYLIxIWceH49dLXxyEMyiv5kWLhBTk0i?=
 =?us-ascii?Q?2Avkl9n5VLPpocikkBdX2MFzdbJtUk3SgqxCCGxBFV2rrrWhwUyG9S0vCpDD?=
 =?us-ascii?Q?ptJ4M/xC+oeGSocYJahHlTjQKATtJ10j4+IhVq1rq2hJtdpaxCkm+vwP/2aB?=
 =?us-ascii?Q?gEXp/JaIu2lgxm0X33eXVVeV805bZBC9KWi/A/gBe25JHfFo+GIVSGkbR3Ei?=
 =?us-ascii?Q?9rko+boGTFr6/uDvWwsElDBA8Ehc3bGhSBNo8aYb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c4409d-42df-46d1-c992-08dd4b44d131
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 09:08:29.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Jsu9NTVyjDt6Gt+una3vTB0UYudvSAxagK0FRCi98jzWfxTDHrkOga01ZJTk7GlNV8N6CTx0ZKH/HY5dAA1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

On 07.02.25 17:51:39, Jonathan Cameron wrote:
> On Thu, 6 Feb 2025 22:23:40 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > On 14.01.25 11:16:41, Jonathan Cameron wrote:
> > > On Tue, 7 Jan 2025 15:10:14 +0100
> > > Robert Richter <rrichter@amd.com> wrote:
> > >   
> > > > Broken target lists are hard to discover as the driver fails at a
> > > > later initialization stage. Add an error message for this.
> > > > 
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > ---
> > > >  drivers/cxl/core/region.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > > index 775450a1a887..2af3b6c14f46 100644
> > > > --- a/drivers/cxl/core/region.c
> > > > +++ b/drivers/cxl/core/region.c
> > > > @@ -1870,6 +1870,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> > > >  	}
> > > >  	put_device(dev);
> > > >  
> > > > +	if (rc)
> > > > +		dev_err(port->uport_dev,
> > > > +			"failed to find %s:%s in target list of %s\n",
> > > > +			dev_name(&port->dev),
> > > > +			dev_name(port->parent_dport->dport_dev),
> > > > +			dev_name(&cxlsd->cxld.dev));
> > > > +
> > > >  	return rc;
> > > >  }  
> > > This function would benefit from some __free() magic dust.
> > > Then we could return in the good path in the loop and not need the if (rc)
> > > check here.  
> > 
> > That does not really simplify the code. It would just this one
> > indentation. On the other side there is a central exit for the code
> > and we just need only that one put_device(). Plus, I like to have the
> > 'success' code path returning at the end of block.
> 
> Seems simpler to me to return early on finding a match.
> 
> static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> 			     int *pos, int *ways)
> {
> 	struct cxl_switch_decoder *cxlsd;
> 	struct cxl_port *parent;
> 
> 	parent = next_port(port);
> 	if (!parent)
> 		return -ENXIO;
> 
> 	struct device *dev __free(device) =
> 		device_find_child(&parent->dev, range,
> 				  match_switch_decoder_by_range);
> 	if (!dev) {
> 		dev_err(port->uport_dev,
> 			"failed to find decoder mapping %#llx-%#llx\n",
> 			range->start, range->end);
> 		return -ENODEV;
> 	}
> 	cxlsd = to_cxl_switch_decoder(dev);
> 	*ways = cxlsd->cxld.interleave_ways;
> 
> 	for (int i = 0; i < *ways; i++) {
> 		if (cxlsd->target[i] == port->parent_dport) {
> 			*pos = i;
> 			return 0;
> 		}
> 	}
> 	dev_err(port->uport_dev,
> 		"failed to find %s:%s in target list of %s\n",
> 		dev_name(&port->dev),
> 		dev_name(port->parent_dport->dport_dev),
> 		dev_name(&cxlsd->cxld.dev));
> 
> 	return -ENXIO;
> }
> 
> I don't mind that much though.  I'd also suggest returning -ENXIO
> doesn't seem the right choice for failing to find something.

Right now I just want to add the dev_err() here. I could consider
changing to __free() and the error code in a next cleanup series. I
rather want to avoid to add (those 2) more patches to the series as
that increases time for upstream acceptance.

Thanks,

-Robert
