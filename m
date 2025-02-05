Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE59218E81;
	Wed,  5 Feb 2025 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751917; cv=fail; b=MLKQ//PpfF5pxjuxhmtiPkKUWtqYnTBxc/FAIqxZPv62OXTLsmDZl6vt6BfvMECteqDQINlf7uLzE6LbZaUq1X2n3Y90rNec3/EHOaNoHJK5aeMnUMY5P/bvzVepP5ztlbXetalkzRE24EILWeWFZiNlLiw5jsBlWUqBSTJfKeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751917; c=relaxed/simple;
	bh=iC38FCOmTA6II3EGebUysNTYbwZy1gxyzIpyxFIFDMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sjh5TXx7NWD2e2QojuwarhdrqOz4dFD3Y15vNTlBpvsv/Bx0SVUagppJoy477G9qhUvYjVxPNVisUX+b7JgmjxwK//yfODpcBsuZdAajKoEEKXw6uApKK+UBLxBr+sH/JgZr3QBHXTYgq0yB6UlnK6RKsZZqU+dfHwy9OtRAbRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ey4fYnK5; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ey4fYnK5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F87qnB847UQI3CyMrhsLJvExGE5MU6tstO1yxtpIAm6xV9nPA6kmfAP3WWZ1Cj1to2ctfvDGnDUgGnk1L1WB+ziGEcXhzy+mWQqhirpdOzAEcEDU1FVjT/kWiAf4xUlJlmXh7XqNZBW3ieUWetrZ5FNmClr8fFy61SJajl4jjFNJG4RyeWbIPjTtuy9NnjAQi9g57ueLZ657pS/1i2VAKiFXGBGIdxQ8VIzAkC8Z4qCytj/WBdIaCoutM3SjC0XAqNFVH7i6NinzMIDPSO4JrzIEBtJ0z4QzQu8aFT5qaH7JjdjNX5I8UMDSo4oFXz0S93AjqbiTVKgzvg6JNKkPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMte/59UlUy64nyOvmlCIRLSam2NHeoIy0UZLOfH7hg=;
 b=PMZxEU3pn2yqzPini2wL4Dlk+agHLLYAySqpK6BZiymphdAY8dpjfACy9MN7dSt7IcyFmPgpNWCqiJhY8f2KE/69ib8JCMMdA6LrUBlxsCO/aiJ9f2K2lLAMYB1a4oqym8H9FMdZUvOHxFA3M/by91rnUN9Y6/qXEMe0E1jPkw7wBUdMO079Q2rjQdCNaQmnniJE4cesVxEDGrP0eOyd5m9N0rga8bfrwddRbNhWTkrey04mocFkWnnxiLKsZNXO6OvDhMuHj5uh5gIi/680n6fgXIeD8vrOOiVbuRmM8x4ladKyAJo58YI4gK18gpE7Edk1oCfdsgFysnjgCfWZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMte/59UlUy64nyOvmlCIRLSam2NHeoIy0UZLOfH7hg=;
 b=ey4fYnK5cyrhwOabcJIgTGKlIurn4FE7BLgpMqloWskbJo7xhN7lnn+LWLNCf+KTxI1E8jYf6fZV2rw0GC3YlCtyHVC+Yvz84mO+VFP6QL/ilumb18dTG4hNzC5y9QBL5ljNG+L8rqdu0qva78ASzRwgNMA+mdZGGitUnGf78BM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 10:38:33 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 10:38:33 +0000
Date: Wed, 5 Feb 2025 11:38:27 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 16/29] cxl/region: Use translated HPA ranges to
 calculate the endpoint position
Message-ID: <Z6M_o38RAphRep_x@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-17-rrichter@amd.com>
 <Z32kMmH25_qfHhZ5@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z32kMmH25_qfHhZ5@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 51beb4f5-b4a9-488a-65dc-08dd45d13d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4GJR22Tq8vKjVijnzO0mCrPfLJuYiAJNe2gz7jL1EqUKcz7mGKpTodsBNSIX?=
 =?us-ascii?Q?vBtukdwEqg/GAi6PkreN+eGqN1RzWCXCVP28ijljUMGZsVwPWGY4UQsbDcYN?=
 =?us-ascii?Q?A1VP5ve64hmB4mF8t0Ud/8roNRLEqTS9WPFMVW9ZUWIqelytvJAOzMxjJRCW?=
 =?us-ascii?Q?ggUu9Zsv4S2/SI0B+GoKlHBbl7DibUfsQcrCBhXe5HYA0wd+Q7bNMG/W8lHw?=
 =?us-ascii?Q?5TbxOWSaEzQIwckkT4IToT0jvHHmnMEBy3SlAxrgZcGWVMCwrFR2CG8zPAMk?=
 =?us-ascii?Q?kNj1OkBoQxe6IMe4X6VxvDdECEIICGk9Q0vNmJumdFn/Bis2LRAE/5FPtDct?=
 =?us-ascii?Q?52g6d8nNcz+oO4+A8+HjrBnqQgAt9JQ/m8rcnUy6mPMdROFvO1KbIKp5JnaA?=
 =?us-ascii?Q?/clEAXoD324GZTr6VNk7lqAAJdSF6kIeQiYTIuXES5OwfOwLP+Griku7VCxX?=
 =?us-ascii?Q?+ffnseLvJ4DvbMCBTrZYqn4xYNMexKooLNGbwVnycB9lC7zeo5MygwxWBnoi?=
 =?us-ascii?Q?0lK3lpWQFe2dmlccy2uztXYN4zJXDwBlbBxI8Tpr/NguSyMQp75MRoIEuHQw?=
 =?us-ascii?Q?uUj/NIcj60vmdygBllvt/15a+5l4lRm/uOZzHFW45dhyhvVdTrqdet7gZDLf?=
 =?us-ascii?Q?e2Kvk04AuF0yRLNDLMQcbI3r951srZsLx3emD0oUEojkeWQ4JY+iKpUw/bUC?=
 =?us-ascii?Q?ekhprXzXdsP4KOH7F0HbwE9v5kzYtt+ejHvg8igA512ttuLUBIj6aMDSPdq5?=
 =?us-ascii?Q?gg0Xxchs11ysdkcz0eyymS5qksEvb4Ey911gR9cmfTjyXThyXNP2jSeX5re9?=
 =?us-ascii?Q?XfODlaIyCZnatk/BXiE47oH2JXqjD/NYPY8YQOCjcLyFEso6tjzRrCQCM6+u?=
 =?us-ascii?Q?DsYoASENGtypbn6puLbvVJKOl8XFXZUz4+OKN+LheelgM0JCMrLrJdGtvBf3?=
 =?us-ascii?Q?Jp74jXtTmyfOrEvkxUfVcMDpnOQSz4n4kdZQ5CAd5BzpE8U/IEG361xaQHdk?=
 =?us-ascii?Q?bQKeBbClHyddpejUVqnKpPjLpEEI3vSGiNy2KG+EPuFlvEbAxpIkZ+IKBT4i?=
 =?us-ascii?Q?WtuN1X9svAjxp+ukWEdxxni8834VyH/NvlC2sVuqyrAox6tr6ztKITwYmRQi?=
 =?us-ascii?Q?EtlzIe2Sj5bFE1SWh3ol4/167IoOtis6lBFjbdhUDW8QeOvP6Nj7gLpDx/YO?=
 =?us-ascii?Q?nzukP/CP3kJBLAO18dZ34cI6MDRAanZrSH70QpuCT4UoYYqikDHoCosEG2ND?=
 =?us-ascii?Q?khn/TiNp8BVBLmyDakiVxECxsRjWWQARgzPncOhBfl5TjJYnBsaQc4j3+rfl?=
 =?us-ascii?Q?SRtAF0GGYgZ1yzCSvseidtUsV9FJqPvCO7hG4B/QZ0LEro+qOzEmqE2w9Z++?=
 =?us-ascii?Q?1vInJJccZm///1rioR0q6osUn0hi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I/cPnMC1Me61kEx6csBukJ6li42pO/c+BZ1MSMtlPSfKPU5Rop24h/WXMK8I?=
 =?us-ascii?Q?2SlGg1jG069rDZ9N2C6GwGmdWKSpRiIc29MVnZGeL9F/6jNMjJ+aZK8KaHha?=
 =?us-ascii?Q?dMjtdwY60ITwgtYPKItYay/6DoiSDv1pDFV4WTwB/bd9Vj+hYI7TlYTqyfti?=
 =?us-ascii?Q?+a3ya+s/WCX/6R9hGu5BY+9/BmWyhEIf/i7c2JwF2HnmguDobjLs+YCjF+hp?=
 =?us-ascii?Q?q3NyLLaobRgqpXpEtuvdgmU9ySBBBrPVMkkoynP7n4QHciBBvefud9GhxXv4?=
 =?us-ascii?Q?mGwcC8wA76Wi+uYAZrJotQDaVWheHjlkvNIuG36OJW5Ga5yp0+t1dkEgG8+Q?=
 =?us-ascii?Q?XYv5Kfxx2Ap7YywSMCu4eYPiH8XsyLadJ7ILcP6avik/KW5pxhU8H8PA+nT5?=
 =?us-ascii?Q?zxelaVfrvBDFKsb81M4q9GYxgiv3HrosvC6MLrrv1S5TjG2fhh0+UAm2Dt/+?=
 =?us-ascii?Q?c0oddEBajol2w4sEUzbLWzvhwgNrznZQyAtMWn8Q3yCGPnSKoTYcsI7lk4PP?=
 =?us-ascii?Q?Q7GBJurOPW4PX00rKu3cAAnKXAuEM5uZZba5RH9x3E3bHHOicBzHHcyHAldj?=
 =?us-ascii?Q?rtvDrl8gJWerq5Lms51kPuCEAk4vdxesMlfAf7X3Wuapfq/k6xvCPWhK8XoC?=
 =?us-ascii?Q?dLOI5qixBzlsN0bb5IQtj1fZWMnPRxFS2JozUjEo+8DVNWuEcamrTEFmjw92?=
 =?us-ascii?Q?yU7XWiR2yUQZCdz78UOHoHwzyOfbReujFmSAzcMZnsXihKKcZ8ZyBKf3BMW7?=
 =?us-ascii?Q?lUpHqtPgm5P5NGA86cXGJLBbzqidQBrXvdMfwT7QK2ohlzMgOcBKRB4dexn5?=
 =?us-ascii?Q?CUwqjj92jE71EF+N5v0DQKwCM6f5EgYrOZJA5nvyE9SRkkGdmMlePNnpR+Pc?=
 =?us-ascii?Q?evfXCfDPB7VGTpzdT7X9UWaLEhnb9IJY3WkcMIJ3ODfGblpKbTMBmVllAPZ5?=
 =?us-ascii?Q?Rg6zeaI/dcmIVvpV3EH0+d4NSaP5zg73h3iC7QZ9WPBOiTMxeCNxBDULXKQR?=
 =?us-ascii?Q?/eZE/riPeeTA8g5F8vUQifOBPL+vkZj4zWb4wE1kOoVDF92sq3YvO1oI+I2r?=
 =?us-ascii?Q?/YRPSlCc80j7n9nqojH3xNzs0Ot0tQhimhRkXNfohH/dpCrvYzGoKLOkYF/B?=
 =?us-ascii?Q?mgFOKuOK4rhShHwWf1q8UF7igu51LFB80N6za8lFEERlGRxD47DUjyZDY2Ua?=
 =?us-ascii?Q?Z6Jag/agogLvxkES54HZa80BLP7A9O5mU7XsoPxG6AzU+lLI2yWy6zSHLY3E?=
 =?us-ascii?Q?V7wBZcrH4PEw0svOh9+CA2lNfSDh/HkJGMUl6ZWibWXGqMHJShkaai28kmeX?=
 =?us-ascii?Q?/O71hMHI7kOH/6nq5rWyC8WhwRtbERkJ6MBi9B4JICH9EYNNhY1rhyNTVSJq?=
 =?us-ascii?Q?NdB6QahnYQkdPwrpegMc05RwcNtH1837/vJ6+trAmfdx4dZk+lICD948S/6j?=
 =?us-ascii?Q?Nk9DkkIrcxMoWdVoT4uCIFx14gKwKwcmvld3G72xX8H8Ai61Ue29IZo0m5yn?=
 =?us-ascii?Q?rbRCh6UAD9mWOM9IfLONj3Xxc6hXfgbEZdr05pKCVRNGTVyRuq9eijZiFgmI?=
 =?us-ascii?Q?h9IldV0uSQ1kbDZX0A4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51beb4f5-b4a9-488a-65dc-08dd45d13d0d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:38:33.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AKrxXxvcjaytLVkxfMGceunmBjAXyqRT0tf42S0djlDsbZ+SjBg0Q4bn+FSHoodtFqkJrwZmmQb58Jd7/K44g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587

On 07.01.25 17:01:22, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:10:02PM +0100, Robert Richter wrote:
> > To enable address translation, the calculation of the endpoint
> > position must use translated HPA ranges. The function
> > cxl_endpoint_initialize() already uses translation which could be
> > reused to calculate the endpoint position.
> > 
> > Use translated HPA address ranges for the calculation of endpoint
> > position by moving it to cxl_endpoint_initialize(). Create a function
> > cxl_port_calc_pos() for use in the iterator there, but keep a
> > simplified version of cxl_calc_interleave_pos() for the
> > non-auto-discovery code path without address translation since it is
> > not support there.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> 
> just one inline question
> 
> > +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_port *iter, *port = cxled_to_port(cxled);
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct range *range = &cxled->cxld.hpa_range;
> > +	int pos = 0;
> > +
> > +	/*
> > +	 * Address translation is only supported for auto-discovery of
> > +	 * decoders. There is no need to support address translation
> > +	 * here.
> > +	 */
> 
> Just clarifying - it's only supported for discovery of already
> programmed decoders (programmed in BIOS)? i.e. driver-programmed
> decoders shouldn't need this translation / won't support this type of
> interleaving?

Right now only translation from endpoint to root is
supported/implemented, not the other direction root to endpoint. That
is, only address ranges of firmware programmed decoders can be
translated.

However, support could be added but that is not the focus of this
series. Current implementation can determine the endpoints base SPA,
so it might be feasible to add support of driver-programmed decoders
using only endpoint-to-root translation, but I haven't tried that yet.

Another use case is RAS to translate endpoint addresses to SPA.

-Robert
