Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AA3D8128
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787263105; cv=fail; b=Ge2uo4/rNlxXng+NkqJL4tssijGCmHw4H1AhTPk3AQ/cR0lJizbd7piMKvIV3Mnk1est0EuP4MXC3U/W3jRVpiQndIGMxdshzfvLYzeLga6eg2j1maNOEWdqdirhX0EM1QtgGsy4u39E3gqMEtqmq9Sj3NhZOAzHd8QASmAO0kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787263105; c=relaxed/simple;
	bh=GSZ2Q5hU1KeLsS8n7eyp7ABGmmoIyZblds4P669fNn0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RgYk8jnkgpd0E1iH20TDplw5zKX/6OEWqkPuCodQAKW7hzFs7EppSWkzH8oIaifskU1l8qkyD5/EqJKvU/+aqn5FSwEWBBx9kZtRFhQy5Ao4yTK72LTv+2EXtrJGPHrtRZmMi9+VMtxtmmz9Wg/18XSDBKsfXoSmUFL4NSQt1Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HERkvblK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HERkvblK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787263105; x=1818799105;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GSZ2Q5hU1KeLsS8n7eyp7ABGmmoIyZblds4P669fNn0=;
  b=HERkvblKWHhRRqlPZtmV/JTZjZOAfZGj28GEZScQBYpkEqFd4Hs5xA27
   sMBtuPy44V7hgtEJcwVCbfbpX2xo2MJcEeuN+Vuj9GduYwViZp3DCHvtJ
   CO+RU1rFCY1SDElT6UCrAKqmnSxTxI0VTWEVtUET7rQ7fB03nH00Jmls2
   WN/sWIktUJsib8yc2ra9wDHLcFcZ48HeXgAKtDAPGpN3SRXTxVp5zRX6u
   YRV3ZAfPK6pL4KPXeKScO8J9wj7iFLwbhFRpGiAm3KloQ4akNmE4cmEHA
   PNL1xlW7yD4KYC1FC/YvABUnOIpoq2vF/Y8XFu/h3jXtxmJnBIDEyDQ7m
   Q==;
X-CSE-ConnectionGUID: haYzfSXCT+qKpuSnRaauxQ==
X-CSE-MsgGUID: XXirKXfLQO+/s16Ovp/d5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87827670"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="87827670"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 14:58:24 -0700
X-CSE-ConnectionGUID: ecy5QPRJTLmkD5pL+GV/4g==
X-CSE-MsgGUID: D/il2OOvQaK0rVCL91gGqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="263514250"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 14:58:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 14:58:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 14:58:22 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 14:58:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/ByHu+7DZotBlX6afIyxHH89b26h9g5PKZ0UMk+oczxsdw5tlrKyn1RfMGhB9Dr7UsBWpzLkmQQt7gpmdXdrPQxppEMkxzU6RK7RiVKpEZUkDpJ4AxLPvdtDiJyHsD8zPSiGMCn2CuU1QYg+0+ON5em719W3GKYE5sBTJDdFhwZKNjyF61LILevWd+zfypYbKgxZfu+k5Te06cgUHZGwr1BQORD3HT5Y2RJHG2JzDzqlZ15jLdj7j2CPUleS0LT2Yxtq2dnWhndLFbxTT0a8TsFztdgSE/ntwfc7XMzyxHFSmW9kUTpXmS/cej4pvbtF8zQLqKO8+I5ZD1kwVFQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdnqbANx9t671tJsflhuOpDdDqbkyCt2LMwjjZOWRfY=;
 b=l0e5lvDin62HDPvl8e8uwMh99ybv928HlnVe2vwc/pwapwcKV0xJoMLZRnH1yl90SHpHdHMu3kRuhY0Yc12+82OreAY3Fn+Fv1lLjryS9IBAgTWmQAsLtVKIubRud3vKGmgxyR+Q2rvf6G4mocRc6Z5cGyd94EtZIs/2DJZ14kOt5Li8gNld+XlbHMwycoftgPs1Q8Z2qKF+xxNn3d56q+wT2BL7PMhoXpvS7nEvmf5DVqfHnZgr0SEkZNRFqo1qNykvlrUCWhtvc4FN9iHsHcNN+EabYeVdRh1sJxOI27yt8bwPDuooXOoFjAzEfUzJjVFwQkqiUCQDeCIrGNxbwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN2PR11MB4694.namprd11.prod.outlook.com (2603:10b6:208:266::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 21:58:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 21:58:12 +0000
Date: Thu, 20 Aug 2026 14:58:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] cxl/region: Factor port target calculations
Message-ID: <aod4bFCBtVhUwOAd@aschofie-mobl2.lan>
References: <cover.1785444498.git.alison.schofield@intel.com>
 <3fe2719ce4e5ab79d842107c575d326c5658b9a6.1785444498.git.alison.schofield@intel.com>
 <aoQV0mEURRUwZJmh@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoQV0mEURRUwZJmh@rric.localdomain>
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN2PR11MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: d509b9de-b177-43c9-b557-08deff0620d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: yssY/JYzxjA+aszED398QJ/PT//KVdw3rwidxJeTNWZlPuPACXojzJqyMV6S6q4Wr9Gz33rrJnpuQm1uOcV/DdgkZkCNMZqhkOtmYKfvXgJegfGJr9gtJ2AJbEIjrOIDCZsJB7fBfDUbprsbxmwL59GSSGWO3gX8A4OazGXTGYfuAi2JQS/270wFNs6rObtLPTbAzqUZWsSMBhEFDo6+9+nQepMIbE/9TZx7Pnu48FsQhRWSI2J63YR2YrNtP/tx8rhOfzUOwMj7Yp+27hJmB93182DSeLA7bGJtm8EGs70yjqsTNqo6uELOdfJGaoWdrSGPL5X0WPkUX2dFtOvVnKhW7nFyiS9lQu4uiN2AJUL5T5oKZiQEt3ZPzwUU6JJMBYKF7FfOkM2Ufblh8YejSWoxMZVEDXk0O/nx/PM80Psef6Lcy1DT6Rcb7fagbl6QSxv2vyXV2u1Jb5MInQVfCF4J2quhKiqVFoKyCGCC06idTYqga8W/S8uzXRGR+3p7FSzX7lXonqUZmgLx0ltwtBcGaG+yTx9Q47UEgdHlP5lkyJmss2bOw5cu4VEJhsm/TaQ1QKI+BWZDXMQ767EfKl1sjH2o9xFotMnnyp9Yk1EkMLNY9VLJl8DrRSG3b17gJ8NBwfPiHXrOSSo9rmNKiAMam6Kf+W1CiHsUnbCRlqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0IPJzSMs3z2wYeEJVEf6EN+Jp3FMcw3/lZTc9rDOOGYnZEfCOdeYFMArz1er?=
 =?us-ascii?Q?qDd1GFEXSy+ndcNTh51EmV05jONe0DS4YFyYse6I2jmOgBOMDZvUP32GH3CG?=
 =?us-ascii?Q?mt0RFib3jIjT+M5A0XFTHU/1T5YEeaO/y6rJbFFNInPG75vHBoNltcn2C/8M?=
 =?us-ascii?Q?2vpmNuZCbu0PtleVBLu1cVXSM2szYupWtO911GDa4Mxp6m06WuZLjAB5LNky?=
 =?us-ascii?Q?ciTLk2/t5/L0LogcQRNh2NHB3IIFG1kkRtfhikh7x01U+K2miFH185n88ILJ?=
 =?us-ascii?Q?P6cCKf4l56Stz9lz12ZlbKjyJ9PlLobNDzX/lEv+DUa/ZcDu5h9Yay0WAdpa?=
 =?us-ascii?Q?34jacuzgW644DEatMTzbxZ85f/oz+USvzd//Pk5Nn60U7kL8AcfLsdDaPYsi?=
 =?us-ascii?Q?OnMt/F+67DAKxpTwj7xnEGwNPsZj7jgPin6e9Pz7dcv9Cy/9KhNnvsfPts1z?=
 =?us-ascii?Q?zhRz+4TEudYdq9wv70XEWyh7FR2B/Dc9IGNE/QVuWW5OUXSskDuZ+4Q+rvGm?=
 =?us-ascii?Q?UEW0X9V56etajonVxyskwjzD4oHmoNLEAuzvcjslppbDVQGpq4P5Nfdbyv7q?=
 =?us-ascii?Q?PQkE1PFBL5YHC4cfij3wiXTBq/w+imrzY3v28nKL871phcRBXdSQsilchQ4l?=
 =?us-ascii?Q?KOkOF8tdD4y1xaLmhVtZY544c5hglT8hfoIqlOfkJr+UX4tTToijvonR+JiA?=
 =?us-ascii?Q?rDEtJsyansE72Gh+pEE3AmVDku6ioySUc+b7pePYnHzzEJfmbXUz3EeKzwvq?=
 =?us-ascii?Q?kl/GeMMWj9tW/eDVvC1gHwi68WgLedIOGiNVYwzUZnVQFGmVgRRMGfsdAktq?=
 =?us-ascii?Q?fBPi6bGhLZfnhjtN72rxIvTvVf3OjttG9QWOSqb30CMXXI0F31C9xDeBXTOl?=
 =?us-ascii?Q?GTwUC1yVYv4VeMQjVIHS9b1egp5PDKBuZ/j+5pABZrqeP+tY8K0SPFwByzFG?=
 =?us-ascii?Q?FFJvLZr5XfIXispKR1HI9bWdTCyowAJrIKVxiRSXAs0woUMMWz6ifDb3/6W1?=
 =?us-ascii?Q?Oe0C5r/RRa3/J8do3HcQNwBt6o2s68c0BnqSlV0eSN9M4HlGBl0aURapGsxL?=
 =?us-ascii?Q?iqCNNreV4c0iALg5qtixaA89isoIYdgH3pAPOAnW6wIPuqm82nt8PaMmotQJ?=
 =?us-ascii?Q?w/gWmSTlhLpX+zJnbiufJQJWJqrf4OBAslehiSEm3GR/RpFG1jJ5u58igt7U?=
 =?us-ascii?Q?fh6UJMQy1AUT3Huv/3rpHEfKc7ZBNKD4ZWaCbaDHyx21SIjgYUy96K28SSQ5?=
 =?us-ascii?Q?jb6qoLjNwnQK5YKxEMiQoTza0mNORogKIFoSJb48a7PDI89M9/onle+9xKxw?=
 =?us-ascii?Q?dOtnGV8H5R4ng+Qc9oSxylzDsK4InffUXyjbTFp/73mBHO9mJmqVldO28Z+4?=
 =?us-ascii?Q?R6Yp1xWga8HAkZwXa2kIQQqw7KB56xhRm7hAhABY3NXu64RL38hu9dUC1/83?=
 =?us-ascii?Q?nr/FspUs0b8BsGWqOG63v7YLC/daYVhupcdhXJw4f+Inm/E9D+NCXi34qkVH?=
 =?us-ascii?Q?s8VucLY4tPLAxODQOgRoRfAoAHvNJrpcVu06WhWDNs5XRrgSv09CtzLRq6ig?=
 =?us-ascii?Q?wcklX5hmd0VidPjDPCEhI/d3qBUvq7NQM8Uc9TcX/4rI3274tKDHePOU1sek?=
 =?us-ascii?Q?2qPh/Pgdi4q/7VICzjov0BTcRRxGyGVpEs8IayO3Elj8jjKlpS6NinJiFLcR?=
 =?us-ascii?Q?UdIxef7AWQDi0TLMi5CG2OadpS6elCQeUqFTf1lLZu2R2MczFuQGH+fUst13?=
 =?us-ascii?Q?bTIDeqj8Y+nNRazkQCU/M6m7CcdFzII=3D?=
X-Exchange-RoutingPolicyChecked: lRBF4YeADK2TLnwOxMGchQ5ObU5XbywDmR0m6jE8/7/nGVF+HKH0b2lgRhXfNzg0QFlIKvZOhA9iovXj7D+bFttglIXzL1Z0z5r+QJkXXPlWdjyYgU9DdQrI1/oAdEQBtdcdYqTgUzN+GdLC6Z49l9/5jA2CMuT7kesGDLmYmwx0MLO1hfTmvp0IMtLf9PS4M6FWKYQXvVqSixk1Qn7PhbuxKvPoHVMsV7V80sQaJ5vOYEr21p7sr3ZMPndYqvW1sY4BG79uq2g0AdSSCSo+rgIvwkUjc0nfnEG5pUZPq+chRCkoSdvjCZjYimt8FIrvcIoz63fl6om1h6bwSlc3vQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d509b9de-b177-43c9-b557-08deff0620d4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:58:12.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf/JE/CdnE2t/4+VsoRUkbAK/3lw4QA58bWKa71qZxYZvdNsPbEhQYCnbtMeR+VM4U8+WJfFuv1KQyoOTHJqdjYo1RXsJUgVEsSy5FHxY8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4694
X-OriginatorOrg: intel.com

On Tue, Aug 18, 2026 at 10:20:34AM +0200, Robert Richter wrote:
> On 30.07.26 15:20:21, Alison Schofield wrote:
> > cxl_port_setup_targets() calculates the interleave fan-out above a
> > port, the port decoder granularity, and the distance between
> > endpoints routed through the same downstream port.
> > 
> > Factor those calculations into helpers so the target setup path can
> > be extended. Validation of parent decoder values is dropped since
> > those values are validated where they are set, before this port's
> > setup runs. A configuration that is invalid in more than one way may
> > report a different error first.
> > 
> > Suggested-by: Originally-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 197 +++++++++++++++++++-------------------
> 
> Please split patch and move out changes in error handling, see also
> below.

Thanks for the reviews Robert!

I took another pass at this, including the broader complexity concern
you raised here and in the collab mtg.

Rather than further splitting the refactoring here, I reworked the
the series around the existing region setup flow. The selector walk
and the helper machinery introduced here are gone in v4, along with
the unrelated error-handling movement.

more below

> 
> >  1 file changed, 96 insertions(+), 101 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1e211542b6b6..1082db7b2cca 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1350,6 +1350,19 @@ static void cxl_port_detach_region(struct cxl_port *port,
> >  		free_region_ref(cxl_rr);
> >  }
> >  
> > +/**
> > + * check_last_peer() - Verify the previous endpoint routed to this dport
> > + * @cxled: endpoint decoder being placed
> > + * @ep: this endpoint's entry for the port
> > + * @cxl_rr: region reference for the port
> > + * @distance: distance to the previous endpoint routed to this dport
> > + *
> > + * Endpoints routed through the same dport recur at @distance intervals in
> > + * region-position order. Verify that the endpoint at ``pos - distance`` used
> > + * the same dport.
> > + *
> > + * Return: 0 on success, -ENXIO on a routing mismatch.
> > + */
> >  static int check_last_peer(struct cxl_endpoint_decoder *cxled,
> >  			   struct cxl_ep *ep, struct cxl_region_ref *cxl_rr,
> >  			   int distance)
> > @@ -1434,60 +1447,106 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * get_parent_fanout() - Calculate the switch fan-out above a port
> > + * @parent_port: first ancestor port
> > + * @cxlr: region under construction
> > + * @fanout: filled with the product of the ancestor switch ways
> > + *
> > + * Walk from @parent_port to the root and multiply the interleave ways of
> > + * each switch decoder. Root decoder ways are not included.
> > + *
> > + * Return: 0 on success.
> > + */
> 
> I don't think that static functions should be documented. They do not
> describe an interface, are short and also called only once. Instead,
> the function's purpose should be understandable from reading the code
> with small comments only where really helpful.
> 

These helpers are gone in v4. I also took your larger point here and
tried to make the resulting code readable without needing comments
to explain the implementation.


> > +static int get_parent_fanout(struct cxl_port *parent_port,
> > +			     struct cxl_region *cxlr, int *fanout)
> > +{
> > +	int distance = 1;
> > +	struct cxl_port *iter;
> > +
> > +	for (iter = parent_port; !is_cxl_root(iter);
> > +	     iter = to_cxl_port(iter->dev.parent)) {
> > +		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
> > +
> > +		distance *= cxl_rr_iter->nr_targets;
> > +	}
> > +
> > +	*fanout = distance;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * derive_port_granularity() - Calculate the granularity for a port decoder
> > + * @cxlr: region under construction
> > + * @fanout: product of the ancestor switch ways
> > + * @ig: filled with the port decoder granularity
> > + *
> > + * Preserve the existing parent-granularity times parent-ways recurrence in
> > + * terms of the region granularity and the fan-out above this port.
> > + *
> > + * Return: 0 on success.
> > + */
> > +static int derive_port_granularity(struct cxl_region *cxlr, int fanout,
> > +				   int *ig)
> > +{
> > +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > +	int root_iw = cxlrd->cxlsd.cxld.interleave_ways;
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int sel_distance;
> > +
> > +	sel_distance = is_power_of_2(root_iw) ? root_iw : root_iw / 3;
> > +	sel_distance *= fanout;
> > +	*ig = p->interleave_granularity * sel_distance;
> > +
> > +	return 0;
> 
> Always succeeds. Should directly return ig.

Agree. This helper is gone in v4.

> 
> > +}
> 
> I will review both functions again after reading the rest of the
> series.
> 
> > +
> >  static int cxl_port_setup_targets(struct cxl_port *port,
> >  				  struct cxl_region *cxlr,
> >  				  struct cxl_endpoint_decoder *cxled)
> >  {
> >  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> > +	int root_iw = cxlrd->cxlsd.cxld.interleave_ways;
> >  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> >  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> >  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> >  	struct cxl_region_params *p = &cxlr->params;
> >  	struct cxl_decoder *cxld = cxl_rr->decoder;
> > -	struct cxl_switch_decoder *cxlsd;
> > -	struct cxl_port *iter = port;
> > -	u16 eig, peig;
> > -	u8 eiw, peiw;
> > +	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > +	int ig, iw = cxl_rr->nr_targets;
> 
> The changes around here should be a separate patch only containing
> error handling changes and other related reworks.
> 

Agree. I dropped this unrelated rework rather than carrying as
part of this series.


> > +	int fanout, rc;
> > +	int pos = cxled->pos;
> > +	u16 eig;
> > +	u8 eiw;
> >  
> >  	/*
> >  	 * While root level decoders support x3, x6, x12, switch level
> >  	 * decoders only support powers of 2 up to x16.
> >  	 */
> > -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> > +	if (!is_power_of_2(iw)) {
> >  		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			cxl_rr->nr_targets);
> > +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> >  		return -EINVAL;
> >  	}
> >  
> > -	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > +	if (iw > 8 || iw > cxlsd->nr_targets) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s:%s:%s: ways: %d overflows targets: %d\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > +			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> > +		return -ENXIO;
> > +	}
> 
> Split patch: Moving of this check and other changes above should be in
> a separate patch.

Agree. This movement is gone in v4.

> 
> > +
> > +	rc = get_parent_fanout(parent_port, cxlr, &fanout);
> 
> I am not a "fan" of that term. :-) IMO, target_count or target_total
> would fit better here.

:) No more fanout in v4.

> 
> > +	if (rc)
> > +		return rc;
> > +
> >  	if (cxl_rr->nr_targets_set) {
> 
> The check can be dropped now as it is done with the for loop already.

Agree. This rework is gone in v4 as well.

snip

> > @@ -1495,84 +1554,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		goto add_target;
> >  	}
> >  
> > -	if (is_cxl_root(parent_port)) {
> > -		/*
> > -		 * Root decoder IG is always set to value in CFMWS which
> > -		 * may be different than this region's IG.  We can use the
> > -		 * region's IG here since interleave_granularity_store()
> > -		 * does not allow interleaved host-bridges with
> > -		 * root IG != region IG.
> > -		 */
> > -		parent_ig = p->interleave_granularity;
> > -		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
> > -		/*
> > -		 * For purposes of address bit routing, use power-of-2 math for
> > -		 * switch ports.
> > -		 */
> > -		if (!is_power_of_2(parent_iw))
> > -			parent_iw /= 3;
> > -	} else {
> > -		struct cxl_region_ref *parent_rr;
> > -		struct cxl_decoder *parent_cxld;
> > -
> > -		parent_rr = cxl_rr_load(parent_port, cxlr);
> > -		parent_cxld = parent_rr->decoder;
> > -		parent_ig = parent_cxld->interleave_granularity;
> > -		parent_iw = parent_cxld->interleave_ways;
> > -	}
> > -
> > -	rc = granularity_to_eig(parent_ig, &peig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> > -			dev_name(parent_port->uport_dev),
> > -			dev_name(&parent_port->dev), parent_ig);
> > -		return rc;
> > -	}
> > -
> > -	rc = ways_to_eiw(parent_iw, &peiw);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
> > -			dev_name(parent_port->uport_dev),
> > -			dev_name(&parent_port->dev), parent_iw);
> > +	rc = derive_port_granularity(cxlr, fanout, &ig);
> 
> I still think, the granularity should be determined just by
> calculating the bit position of the ways bit within the HPA. But let's
> see next patches.


Agree with the direction here. I ended up dropping the selector walk as
well, though, and deriving the decoder granularity directly from the parent
interleave geometry. More on that in the following patches.


> 
> > +	if (rc)
> >  		return rc;
> > -	}
> >  
> > -	iw = cxl_rr->nr_targets;
> >  	rc = ways_to_eiw(iw, &eiw);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> > -		return rc;
> > -	}
> > -
> > -	/*
> > -	 * Interleave granularity is a multiple of @parent_port granularity.
> > -	 * Multiplier is the parent port interleave ways.
> > -	 */
> > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > +	if (!rc)
> > +		rc = granularity_to_eig(ig, &eig);
> 
> Same here, separate the combination of those two checks in a separate
> patch.
> 
> With a patch split the actual change will be much better readable.


Agree. Rather than splitting this version further, I dropped this rework
and substantially simplified the target setup in v4.


> 
> Thanks,
> 
> -Robert
> 

snip
