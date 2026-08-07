Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896E3F8226
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146027; cv=fail; b=mE8qr8inKJusI1ryRVQW+OUVtjDoGfvJXHgKHhVjIyI7NlyWoKvC2zLVDFM8H5Wd1pxbioB5BluycPVHO0lzVGwmG0zQHRyjG1OAslS42PbZjrC98yt+9nb53jO2Hq3sN7KDnx4rBC3Jqzdt5s2V4cFz+O31UzXMllscfIgFEXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146027; c=relaxed/simple;
	bh=Q25PZqu0X9XNp8i44FB5H09jKSuWOr+CFQlSxp1Ib4M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cPTW4QTGndepJ2sHdBIYqjTP8doyU2KTaNlfIW5wdVpSRvu05B6vG81PTNIgfbDEalHiFHsx9ddsGeP2Y2/KVYTkDZck1HL2u9HDU7RfxDPviEf6I2fAuz4kzFZrpQw8rY2sOd6TwhA9FUIhOs6GO9L6I7sHNX9Cbg/nxVYCu48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLVNFcFw; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLVNFcFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786146024; x=1817682024;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q25PZqu0X9XNp8i44FB5H09jKSuWOr+CFQlSxp1Ib4M=;
  b=dLVNFcFwpuXyBp4SXsyJUTfojCQQn9JcFbQm1XvxoPFmI3mBlNG6xH3J
   xX1liJhAJyq8wOhNHz1v5tskF/3ZZUxsJzKS3Twwl6Yn8ugv65gRDzNpO
   /TJoQQBVacuEWqi2He+jZqr4n8GHqiQS6lT4p7t5UiPS0rlAD2CL7rR9N
   8Y5vJjR025MSucq3wI5wQr2vwa/jJ/6fGfvw+DnVK4HuJQ4fDiriWCZIg
   /Thg38g4PAKw/bf7F9I0CvP8nz1ev6hK477cSNqXNtTKz3FQFOjBiskMn
   upP030lFwA0bWzVXwODAkUBPrRIUC+RkPsl4w/TrYBruKoNzv/TSWTutX
   w==;
X-CSE-ConnectionGUID: 45XOX09fQ1ee6omKKK76wg==
X-CSE-MsgGUID: w8K6b+F/R1aGlLkJ8/CEvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="97360017"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="97360017"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:40:22 -0700
X-CSE-ConnectionGUID: sq9Ju10cQ4q+wckabqQaBQ==
X-CSE-MsgGUID: C7iwUyhZSmqsM0YxX1/iVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="262567846"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:40:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:40:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 16:40:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:40:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZORZbVsHs3eDWKKHWPtZE6wVro7zhCtEq9WwCWaA/ug7TSuOx3cVuXDa5YtJP+yAeZt8iSAKS7KlbD8iQ7Q0/P7o3syBqkcN5T3Si/fEgbk/EuhyP3X/FMvvvK2Gk0wUHjJdRA6LW+SLtvScXTRWnI7p/RN258ib7/qzxeEYFicaqCqiameGYFYGf+GRzzzvObyezfz+IP3NEJ0PQMlh47Au1FG7i17ny4H4xaEKb9dtjeNeZrAwe+CBcF1qqZUjzWJHzUZcFspxNDEZ7TdEyp6KUYtBJXquNPP32WIliVKgikTNXFnxTmsQj/xp8MhL4YmC1f8h2Po6pUhGVVdaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AUIGm+3aa7ZJQ5ERs6oUAgKO6xkmG0qlNBFXnYtlno=;
 b=toq+p1cCogoHRDTuRBrlvpCJ8X9K8cLpIuQM9ZuixyclEQohC5+lrz8n1d2x/n7GqgMOY4UHnKs4M8HlQTS3bBY5c2AMsiafnlpRY08dVbfE0IojXS2RKcw0B218T8Tzz9+zYpp1iIchWeApGpt/2BPdr7T5p7Gxu5qtIbf8z4KVjnIYedmpGa48g+zzCsFx2QbOtqZ7V3yvytE+EUXjytZQBzdVRC3Yk3rOqBc00E+Re3XJDybF2Aa+QUOafSuk+pFTEOcM9b6FThSktWNX+fdcf2xFqrIOq9qr9z7dOmKz6Y57kyRLQiBLT9zmZ1BUCCBJzGcY3vgGxXE6OK2nmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 23:40:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 23:40:18 +0000
Date: Fri, 7 Aug 2026 16:40:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Dan
 Williams" <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v3 1/3] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <anZs26o19H6ztBV0@aschofie-mobl2.lan>
References: <cover.1784322343.git.alison.schofield@intel.com>
 <de61a8143c7de391f8463003d87a3845496f4af3.1784322343.git.alison.schofield@intel.com>
 <20260721190416.096286a9@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260721190416.096286a9@jic23-huawei>
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: b9df84c9-9c2f-4fae-dfc3-08def4dd3cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|10067099003|4143699003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: zjOYRqfX2R62WO3RmgVf/52EZA9vyOsitH4hNNOOxdCkwAoDBGDQWQjNYiZFDPpWvM7R0mVLfSaYsDYL39wyneWnjhsrHMUaawmy+iEEK/CwJVEckrQGoVoG9NpvxTdw7vne4uETdQ8nka220X8AcQ68ga+pyfXRh0Ouxt8Y4AcfV0F6ASVfdj0NRL4Bpcp2kSbteABm3Nz8wNxoGeqa/wrCMGi0aWcrKPL54OMgVD2xdIfw5Bwd/npOTlxegcRE6LmNxGfhhzPtRIzK0sQAzdPRs+kzAtN1V+2HGkbWAo5fAjSyM3gFeGMtHqlm7WB7ghwfh3XW8bgoScsmeKL9HmdLz7v7nWLaDGtXK9k3/QL+Bsr9PT2zdUjw7gZ7klNlWCOr4D8/tr9pcblWHlFceqjxXA067dsy3UFR7K/mkyKezU1q26kjTCwUEQu7WK663kyyMyvPcKvI0k0WGnkLt2AgE8CZpElPimHMRr4qupEbe3BV8Rxejpsf4qGNqfEuqQBZr43uyIiIeC94LuogGiKMaYdAt/SNjZP+apUf+ah6scZ0S59RCL/7dDyp+az5wPPyXDM+7fL0sgqsy5kzacBzm2dhDingfl368+9GIZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B3cuzLgICIWWSYreq4foiwoua59Q6yEqwqm51+z/xv75gIVfl84sQzeBcly8?=
 =?us-ascii?Q?zrM2zcPWdw3/yd1L9IRPO0smj0/YBsPO/onx/Pg4S56RXbLXPDfG289z+vRK?=
 =?us-ascii?Q?rSlcC+Awc7TVujbxdsIjpeK+MjYQKyibsRA5jKvPQRoElSBD6NhddZpJofly?=
 =?us-ascii?Q?m7ATQcFwwr51nNMAqiYyeSf4W8JZ+josGzQanLoaeNZ/OYLuWOKdjvxDcRr3?=
 =?us-ascii?Q?xN5lGWToBoDM2cvNWpbErOh7HcfNz0GjM1DPYA3QSJ6qoa2crl8RIO3XFIKO?=
 =?us-ascii?Q?RMAEP18BkOh2bDJ4RGLXAMfazDbxWDCNdnhrJmvF2lAUzZJJq8UZek/cwO6U?=
 =?us-ascii?Q?ato/3Zy6ZJp2/NEYjc+YF3SY3IzPGEwv+v5RhRoFxCTAb2VUtwPQ1i52peMJ?=
 =?us-ascii?Q?cWkUZ0pr1XpO6wjeLy1Q6LK1t29kNbkKHSxfyznED/HcFA1tsjNvl8RMi2Ib?=
 =?us-ascii?Q?fh4kxhtAO5dUgM5oJWCgvHK3pTdlzUSBNrAvejrZHBnlwBRcA4ME5LuRBQof?=
 =?us-ascii?Q?VBhAysRiEjFzwqXlC6Cbrb2DNGlGJ5/c1grJ8jGmCJgOCrT4Ui4HjEbwUy5D?=
 =?us-ascii?Q?DVb00nvgnFn8kbaPcEYqavt/J6HYAQZimXTblxe49zlu09RtVbC9nszCN9Dh?=
 =?us-ascii?Q?KD8MY7F7AxQVIm13I5vM3xVG/8kK7RkBGfxcjoL7dQ1KrxJ8I0R2iHTRu+2j?=
 =?us-ascii?Q?hGvwsVGmetGFxmH4Ru3joxs/hN5Eyp1rPigdHAE93eboDizdtF0HGbBvHXia?=
 =?us-ascii?Q?IRhCVsJVSVzu6BMpZ2xI9Zxykt7vBVn2+v65WpHxUEHpCTWPW8uKCcuKM1Ml?=
 =?us-ascii?Q?hj3gCgIMCHqxpYHldB7ehzQM4C8NSq4Vnk8eHePZ1Hd+gAAhiZMhrEnrqxW8?=
 =?us-ascii?Q?5qYjrTjVz7Hp7Vp07HvDUjReQyY1AAaB+384fEUoTJZPYSqt3FO8W6S+sReE?=
 =?us-ascii?Q?ll0IIjUAMvT406eZHkwnV1P5Khve7wYp4Tu7rXV/WdDH7LFE4b2MDKMmbuDy?=
 =?us-ascii?Q?AmDWhkXlRqPB9GsmpH02qwd8olj7ZhN2OT/xBYsv46AROsMANHd3R6FfcV3M?=
 =?us-ascii?Q?BB2vTG1pf6ls7RmZfXdYCgi77kzw2Chuz5hvNiJmJfHTFCBLgpaPxENdocH3?=
 =?us-ascii?Q?HP1hAeJgi4x1tJ5qNAsKfokUGpJQRDmLYk0Eqc3AgidaHMvIV+UrEmFbR/6x?=
 =?us-ascii?Q?WYrD4CNf0B80XxwW40HpmcSqYgVapq6/t5I91Num2c3BwOKDa9qtqG69UoGx?=
 =?us-ascii?Q?UCFiuXAdUPCcNdYF0EQIzlQE1PwQKczJ53vg8ZLJTUS7lr2TM4d/5OwLm5c8?=
 =?us-ascii?Q?I+QNmh+EyesR/IvWQi1Q5Zlkcx/v0Lxnv97J4GON7YpnH3zk/FtfYbjN2Fju?=
 =?us-ascii?Q?/kGCPPGby91KSGwmW7RUWe/1HlgxiFiam6uqfmI+d8NIOtqdZg7xJznbnBWg?=
 =?us-ascii?Q?748gp8VwkwQreDoRaYbGUPJD7eM+DZqlBUgD/6NkpCNNCBTvXgDuhHjMtsny?=
 =?us-ascii?Q?DK/DOs/X4zG+4SwaO1CrPfdvCuAbIvZhUuEOKpFwUbqZdlnlODuL3taiTYLP?=
 =?us-ascii?Q?Rshsdj7/n78UrsKjtHzqnfkOPNdct3J6ZXWKYrU9Py44UaLtQIptLa6/afMa?=
 =?us-ascii?Q?MdneGwpsB0f7PjX2WoPsWBOP8xA1s02JIH32U4dCm1y3SvrC1qJyiPt4B6oR?=
 =?us-ascii?Q?Rtffe8NsOOll129fO+UVTnjUchxaObPBwgmsqIWUGmnFatyvdmYH0lelS4VM?=
 =?us-ascii?Q?zeuI4PuvjaGt4Co+euXMqXchKIzVS3Q=3D?=
X-Exchange-RoutingPolicyChecked: VE2MszCDt48N3AQvqBXeHb0dXqlLxejjK/moomZN73fziRCDa6E7D9pM8mfO+GeA7ekA6bCllcbAHuEO0/ONZyxNRP1ClcUC+9Bia7pDQ3vI3PS+sS9mIjN2sP5yZQrhStAejoCIX5G/HjDelL28QQdRZYrs72aLqvfqv6VxKTwOqDqDMQ6dD9MjTG4/DLU1MckxMXVzQMZDeIQMJotTXvLUwemAsTI/K7bZj6rYw4mifQDfffVwPSaoogXpe0mhRq8WLynfQwcpuCBiVPHpU2R9AxBhHqM0MXsnALLO3T6ftXPoHQ/01/TTGczhFoYtMxSoWpBcLmpxXYCAmwC4hw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9df84c9-9c2f-4fae-dfc3-08def4dd3cd3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 23:40:18.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3/dbOnCMNelZdadiq+3egjCejmeDuEJcod+3aWs870sV7kBlWn84x7MhQoAVSUMlUmRmnew+gm4o7N7pZSrV9Bd18UcawNe/m6lvuXyGtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com

On Tue, Jul 21, 2026 at 07:04:16PM +0100, Jonathan Cameron wrote:
> On Fri, 17 Jul 2026 14:42:46 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Switch decoder enumeration validates that the interleave ways encoding
> > is legal, but not that the resulting number of ways fits the available
> > targets. This can overrun the target arrays during enumeration.
> > 
> > Reject committed decoders whose interleave ways exceed either the
> > hardware target list capacity or the reported target count. Reject
> > switch decoders that report zero targets.
> > 
> > For uncommitted decoders, ignore the stale interleave ways value and
> > reset it to one until the decoder is committed.

Thanks for the review Jonathan. I'm responding as I'm about to send v5,
with all this considered and fixed up.

> 
> Note on this below.  Why 1?  If it is invalid can we use a nonsense
> value like 0 so that any use of it will cause an obvious bug and
> make it easy to spot? (hopefully)

replied below


> 
> > 
> > Add a clarifying comment that target_count is a direct count, not
> > 0-based like decoder_count.
> > 
> > Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> > Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c | 33 +++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h      |  2 ++
> >  2 files changed, 35 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b..d81df45d8005 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> >  
> >  	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> >  	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> > +
> > +	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
> >  	cxlhdm->target_count =
> >  		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> >  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> > @@ -1084,6 +1086,37 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  		cxld->interleave_ways, cxld->interleave_granularity);
> >  
> >  	if (!cxled) {
> > +		struct cxl_switch_decoder *cxlsd =
> > +			to_cxl_switch_decoder(&cxld->dev);
> 
> Trivial but I'd go long and have that on one line. It's only just over 80 chars!

Done.

> 

snip

> > +
> > +		if (!committed) {
> > +			/* Ignore interleave ways until commit */
> 
> Dumb question but why is = 1 equivalent to ignore? Can we make it explicit
> either by gating at all use of interleave_ways, or using an invalid value
> to mean we don't care yet.  I like 0 as that's clearly nonsense for interleave
> ways.
> 
> > +			cxld->interleave_ways = 1;
> > +			return 0;
> > +		}

0 is no usable because cxl_decoder_acc_locked() reject ways < 1, so
every uncommitted switch decoder would fail to add. And 1 was wrong for
a different reason that Davidlohr caught on v4/patch 2 - ways is a
sysfs attribute that reports what the register field holds, so changing
that changes what usersspace sees. In v5 we leave the uncommitted read
path alone.


> > +
> > +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
> 
> This feels a bit belt and braces.  Should we be verifying that nr_targets meets
> this constraint before setting it instead and only having the below test here?
> 

Yes, done in v5. The target count is now bounded where it is established
rather than at each use, so...
- devm_cxl_enumerate_decoders() rejects an HDM capability whose reported
  target count is outside 1..CXL_HDM_DECODER0_TL_TARGETS, once per port.
- cxl_switch_decoder_init() rejects nr_targets < 1 (Ming asked for that
  one).

init_hdm_decoder() is left with the ways > nr_targets test only.


snip

> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index c0e5308e4d1b..291ada46b646 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -67,6 +67,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
> >  #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> >  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> >  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> > +/* Two registers with one target ID per byte */
> > +#define CXL_HDM_DECODER0_TL_TARGETS 8
> 
> Whilst the comment is true, perhaps better to refer to IW definition
> and 8 being max allowed for anything that isn't a end point.

Done like this:
	/* Target list capacity, i.e. max interleave ways for a non-endpoint decoder */
        #define CXL_HDM_DECODER0_TL_TARGETS 8


> 
> Maybe the spec would provide 2 registers and then only allow 6 decoders :)
> Also comment doesn't say how big registers are.  Anyhow, to me the IW
> reference is crisper.
> 
> >  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> >  #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> >  
> 
