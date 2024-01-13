Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B6818647
	for <linux-cxl@vger.kernel.org>; Sat, 13 Jan 2024 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDjtsgHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705110879; x=1736646879;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zhasKlyccvMrc7eWAvhayuyT+u0WCnQfihip/29XCuk=;
  b=WDjtsgHJYLXFtuF0DvJC2trE4V0gOlq+Uxtb6b5jZkYvxen9VoK3Ylp3
   UdXTb2HaaPPD7u0k6B3a/r4Bd1V2tW0M3kkc9nkX0cdql/+8IUpfH9Mk/
   u+vniDjJvifiTVVXAo/XSz7GpPaZaCJoNRKg9kzZosqQXAv46mo7MRDQA
   jjJT7u8vA6TCAJNhV+v3HRhPwsfin6Q49ozoR0NPYzQ612OfsV6tq8xqv
   i+jWvZu2xcuTh4nPLcjZYNcb6eYvxjgmi+olK5xqqMb2KZrOc89E5tjYN
   tRcoIC0UcCwLfHt9AUSusEKRq6fUmqKvieNXmvo0Kg3E0DzAxP1DD+wq9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="398206062"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="398206062"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 17:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="783221398"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="783221398"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 17:54:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 17:54:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 17:54:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 17:54:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1858/GkeNuszeZ96zojR8Bw1q4DnHHPoQ4lruvJ3HHvsG5DR7rCC6OapaUZz5oyYe3IYXBXfOZbNmI1RiAivZDG34ScHnTup5zEHOVeUOkvFZk/t7dPkQ8atMA+DULI9fYutmMjdLPCOhFC+UqZjBguYEruvPxIJ9xaXZOS/V0VrAuJWXHSC70n+PTFVHCY0tNPDtO43DOlyrL4IGBr0uPcqs3jdCtpazVyPCvVviZWK9oDKeCOMZD4SIsYzZ4f4u4D2FhfzMy5ucpNLoQlUfrsljAfFZLytuchvzMUnZ1iq3F/qzX36lnvvtNG7XljsFRtWEbA/UjKOqLrsZeIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL6gjST3vOS3puT5eSWEzkuAvKtQJfIY3Q9A2XIGeXw=;
 b=LI9DLrGsAzxOzYTXFQyJFho5lbmD7qBjKhJbFHDRsklM+jDyC0kjPG7bblXGokYD1TIIij3XLPlUfSn+Oio4P3KXQob/1nztWN2FECzK8h8o/aj4Qrjk9DYpim0Qplb95twpK1f6CIGTrz6JhYRP3qdgHStpmi3ydgEDJOf2haV7C2IHM/3YzFQKwsvk9Geny2OwKypgHlI9ow/PN2cAnQ0c2rsHXWE6xEYtfwB15/7PTjsA+ClqjdZ+UcKJk5+CjOOkOV6S1z9AL3qJGZB9Z1Vw1ZRPlo+gsGAbpf7MJOf/kwF2CxPygB4VAy9NeDobMhcWY66RkO5GX0vBIc2Okw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7340.namprd11.prod.outlook.com (2603:10b6:930:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Sat, 13 Jan
 2024 01:54:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Sat, 13 Jan 2024
 01:54:33 +0000
Date: Fri, 12 Jan 2024 17:54:30 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>,
	<x86@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/numa: Fix the sort compare func used in
 numa_fill_memblks()
Message-ID: <65a1ed56d4bcd_29304294e0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1705085543.git.alison.schofield@intel.com>
 <99dcb3ae87e04995e9f293f6158dc8fa0749a487.1705085543.git.alison.schofield@intel.com>
 <65a1bb13f0262_3b8e29483@dwillia2-xfh.jf.intel.com.notmuch>
 <ZaHatrJJc8MqtBHP@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZaHatrJJc8MqtBHP@aschofie-mobl2>
X-ClientProxiedBy: MW4PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:303:6b::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ed451d-71de-4c35-2d10-08dc13da9693
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nCjdZzqPD3UKEie6ZmShnJWCcwzJHDg96jYttvXpz9ts9Ijr/kzxAm9ISLtnmXpG9eX39BZMBeBFrqbhTlQ7gBamTgVGQpSXeiFvxnsEBeTLuR61eNZABHGATjOXh1Bu47cLNymnJMS+arSCKUOUjnL2WSD/g/codbMSb/PaUHOw1X4rnQzA33Hpfo4kiVzgQFe08iEPzlQGfl+jG5B76Wu1u5HvBqPjQkrWtav0+haP/vatxxYd2dW+lPGQ9CsDGMcXP6iq3bAAjGtUjiGJIGqhO7XyRCDZRdFp12Tq0pNqu8BpqlCLBnpvjV33bOirI5O/GtEtkWWJ+A/bkv1ypfmUexpvHD/wE/SnKl9mFkPHJjoD4fXBuUiGwFBv1uRwqoeOXO7Xe8qPKX2RfxklBUPb17VnELHSx59JCKrT0yOuiRxZd+nnp2sH/lhRGJddppVRjYFeuvENXAhcLHJXKFSSgbXqbpKM3BphkebHJYvnqhTj5FydJ7Ax2Q7ITHHZ5ln0yXpOlm+twleUpknGb506nUVQaljvmmI5lwC58AK5Gkw7i3ModWO1csNhbN9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(83380400001)(86362001)(6506007)(478600001)(26005)(6486002)(9686003)(6512007)(4326008)(38100700002)(66556008)(66476007)(66946007)(8936002)(316002)(8676002)(54906003)(110136005)(2906002)(5660300002)(7416002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5yKBxpEiQhYJZ9rlovgAHVfyv012MeobVThXWD1IyZHoFveKgQUelkieBOI?=
 =?us-ascii?Q?sLS/8JikJWpSxXrBtUFNvesR86pI1p/oy0FddZ8tCsRtnkN1BL/x9Xx2z7cb?=
 =?us-ascii?Q?pTBrE/JAy85OZ36hA+QomM3qjksGDy1JlKDeetLuzv23o0I0d5eLYiDhUpWy?=
 =?us-ascii?Q?X2VbCJh8+c29Iace/YKTuYqmIvnG5mZBATFWji5md9pDkq2DTOmpbWyqTJ27?=
 =?us-ascii?Q?ie4l9Gzyt07gxn4HByFPrYIC0JhoydN6EDOC7ZKMCao92aKyP7wAtCGZE1TY?=
 =?us-ascii?Q?uyLISGcuPiT7V8Og1Hv+GqWLRJqhblbygVEMsDInavvTYORCnPi+qIlclwrD?=
 =?us-ascii?Q?cVhXbCbGigUhfvbWQabUhYz8dkvO0YKCFzm/0gKunEkkRaibO0FePweDfpCb?=
 =?us-ascii?Q?aqalkNHBY5kz7g2qj69begHg/E7Xcqi0F4AXBXjpLSHYdBl+fBCpKA9Ka09g?=
 =?us-ascii?Q?IbTCJJn1R2tBqaAP3oicHvS6cCa3DGUronBynqQtBFzOt664OlwPJtiamVj2?=
 =?us-ascii?Q?GIxundFOmIqono4SCyxbkYzvJyQ2mJHGk2hbHq9RtmQx8Oiqq/3soDCNpdPp?=
 =?us-ascii?Q?nL4ylsl2ogogcGOCZighJWsXCpvTu9ReA9FlceAIjt5kd+4dSnU81lNaWEO+?=
 =?us-ascii?Q?/GRhQQh5hWicYLPhUDKbIjoLKo59KWoeYKPLnMCvr/7jUxHTw30sVA1dX7+R?=
 =?us-ascii?Q?+RVNJ6qW0BmBLVUZ6+MQv3WGo0/XNWRW8R+lMGGKFTCcFT+b768FIqMaAUPf?=
 =?us-ascii?Q?J9aPPf6Y16ujzdq/cEuw5HY2zc+AnbzFE6hDXejw3fSP3wAlnuGzy8tfS0gT?=
 =?us-ascii?Q?gUmYCwgoi+eCpxMFset4vLqljgoLSx/nMG0FZcwNJKbz+X31TA/n/pJy1hPG?=
 =?us-ascii?Q?UjDmSjA8TbCwLOGyXKFOdnC6xkucxWLZkU0evZj3PHtEQgafS5lw703ygO43?=
 =?us-ascii?Q?AOEKmM0AQti6NUEm5WkRE6b0qyYofgAv7oePLd7DCEQg9QjBql19yRjYB0/T?=
 =?us-ascii?Q?Gvi5Hi9LHSXYrGJYaAMHdhjVCi+mVE0puHEfqY2I3NDaaXms3cQjZ90HZiz0?=
 =?us-ascii?Q?CDjDnhmJXaB/NJNsGNHbLT4K6CSr4ae9MSQTKTHMFu9Tr8EJ/9Xk8PKGCl5m?=
 =?us-ascii?Q?G7mJeoz1sKzYMbG0Cqu2ojPX2iMDuzW+TYE340RJceO+K2PnECpVArtB0eTT?=
 =?us-ascii?Q?4Wej5y1sCC89VUfUDbEaztFUSZBJFZWwYeye0/5fWcXw3yW46coCwWN8V9aS?=
 =?us-ascii?Q?19rNblBVQogooDUjJ9rbu+p2RpfFM/inBtNrKr5lMyRxRjWIwbdz9JmRAOoE?=
 =?us-ascii?Q?G1+m9mabArXSZIOgJJQQXRUoeh3hnF0mPk1I8ypQ1vHyO4A8/6d0KKQFnxnp?=
 =?us-ascii?Q?4v9rcFOM46Rp2FowHc1hxtrzYTKCr8uChSSnDNnQvbB8VPixebcQNZKK88Sz?=
 =?us-ascii?Q?Rr61c0zdefmxPMdu+GPGuVCzfvHlewbO2q099QDVXscS9kKJMtGe5gFS0g5O?=
 =?us-ascii?Q?rDCCRDlL08kGhRE/LqHhcQME/oUnaRkwmoUpdQzJ85Nw4ReWs+aRNN94txra?=
 =?us-ascii?Q?RjIa5OH9eTudLPDiQ5/7QJ/S5Udls1+fpo6Rdc07i1gAscmkIxpC8YXuyWcr?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ed451d-71de-4c35-2d10-08dc13da9693
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 01:54:33.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KC9qA+E++gGeY38RFuVRzhIob9R14nlOrREduueWqidv6FG2+MyaJAr3bArSey7KN4DnaSUQKTVvv6niIZPta5sfn472LQPK7OrA7hEI/38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7340
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Fri, Jan 12, 2024 at 02:20:04PM -0800, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > The compare function used to sort memblks into starting address
> > > order fails when the result of its u64 address subtraction gets
> > > truncated to an int upon return.
> > > 
> > > The impact of the bad sort is that memblks will be filled out
> > > incorrectly. Depending on the set of memblks, a user may see no
> > > errors at all but still have a bad fill, or see messages reporting
> > > a node overlap that leads to numa init failure:
> > > 
> > > [] node 0 [mem: ] overlaps with node 1 [mem: ]
> > > [] No NUMA configuration found
> > > 
> > > Replace with a comparison that can only result in: 1, 0, -1.
> > 
> > Good eye!
> > 
> > > Fixes: 8f012db27c95 ("x86/numa: Introduce numa_fill_memblks()")
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  arch/x86/mm/numa.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > index 8ada9bbfad58..65e9a6e391c0 100644
> > > --- a/arch/x86/mm/numa.c
> > > +++ b/arch/x86/mm/numa.c
> > > @@ -934,7 +934,7 @@ static int __init cmp_memblk(const void *a, const void *b)
> > >  	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> > >  	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
> > >  
> > > -	return ma->start - mb->start;
> > > +	return (ma->start > mb->start) - (ma->start < mb->start);
> > 
> > Maybe just do the less clever but obviously correct thing like 
> > other unsigned compares like ktime_compare():
> > 
> >     if (ma->start > mb->start)
> >         return 1;
> >     if (ma->start < mb->start)
> >         return -1;
> >     return 0;
> > 
> > ...but otherwise this looks good to me.
> 
> During the upstream march of the original set, I oversimplified and
> broke. For this fix, I surveyed the sort compare funcs and lifted this
> simple method from commit: 4ac19ead0dfb ("kvm: x86/pmu: Fix the compare
> function used by the pmu event filter"). 
> 
> Let me see what else I get to trigger a v2.

If nothing else comes in, then don't spin just for this.
