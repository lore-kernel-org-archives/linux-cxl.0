Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2AA55E62
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nr2A6Ghi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704747839; x=1736283839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+4orzPwYk6NWEVzcn/HcvKeT16TTn5LVJTANHKpp99I=;
  b=Nr2A6GhiUZoPIXJi+iwCR3HgHQbiDHbOLFFow0Yu0BUFgzeiOeeuDM0T
   trLUGuFh0LDRiI5tvhXIb1BV+bWqqvqjONJ5dyKJ+5jga8YzGbJUf1CXS
   sQQ4a+FOPy7IN52JLdTywGlJNs1dN46Ej3vzH5dJBcJrtDOfI/4sricht
   TAriurUMtSW/ZED+PRpEN/HVy9mRMDxCN6N0e91JakUoR2LwQgwAdgEvW
   nWtC0UwmnG5sZfAizg+VQvLm9e5t+ToH7hHH+pc1FTwxBWU/oxUwco/R4
   saVs9Wr2QDRfJoMQtgHQIs47vsDdmly2bTDiYj0BkF+G2TR+TeklFGfX7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="464401841"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="464401841"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 13:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="954767865"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="954767865"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 13:03:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 13:03:58 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 13:03:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 13:03:58 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 13:03:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oClQ0XfL9un4pQCD6++QET0wPcgz6W6d+2A0DKK/eTGFEWQ0BdHGUQfBJ4Z04wFwlSZyH/AKUCWW3wp8Tu1wI/lT/22yNWw3msKBe80nmNUYOVLNPOxcCw+tEzfHyK5NthP4EwTWfS4b7mhqgOZLb8xdLwhzMSRsoLz40uXUwCxswEcm+PItEzvqvOuu18Yd/Lim1yAKU2fldCqH7QNSNJnPrD0jR94gjy4TPc9ECcRavtW+iR7ezVr3K9tpBJRIbs7ozlVJYcsJ5OjJhV7hWN4iNuCelx+wCUzkDiMwaxDKF8cM5a7SwNR77ykdwYZnR22M08AuEOIAcTL51XvIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXp0u2BhxikLdaMKs3WztBZGXO8YyiJdF04pIgc1hU4=;
 b=lbLcStEh9KBQeWMhvCdoS4KmHg4BhWfmXDymOgcb4w1kqWMR24REeNNuRGaou0Q0R/Z48bCZJjUqUcC+6lcoX50GeI64jt7s1ppypW21OFa023sNTEbgT/JShW4AJ/G2FIrmDYc0fFpWQQATw8vGjAOqf8d3rAyplKRvGdoKD9J+lMvjhJ691n8/edbrIrEqz+7mTEFcwxSXHCshT+1Rjuy3lbjPwpeLG5HQCG3WMPGrkThj/mhRYcaByAPhgP3wDS9ZGRzD8X+PU+68ZSTdN/rBIECe9sQSaeTaGursD//BAHzCGTn/AiACoVRKmkubJQpkO1ToOh1F+LyefoKcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6720.namprd11.prod.outlook.com (2603:10b6:a03:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Mon, 8 Jan
 2024 21:03:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 21:03:54 +0000
Date: Mon, 8 Jan 2024 13:03:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: Re: [PATCH v6 3/5] cxl: Fix device reference leak in
 cxl_port_perf_data_calculate()
Message-ID: <659c6336f356f_127da2294a8@dwillia2-xfh.jf.intel.com.notmuch>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170449246681.3779673.2288926019977963333.stgit@djiang5-mobl3>
 <ZZiJMN4zjjDErSRF@rric.localdomain>
 <3d0a0ec2-1184-48dc-aa09-5d62b17d06a5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d0a0ec2-1184-48dc-aa09-5d62b17d06a5@intel.com>
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be73cd2-03ad-4040-7e59-08dc108d52a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIPRfTFQtJEnDYcqYgGgrrYz7wUXmULxBOD4O/WXSalWLDyEhpAdgJTGY0IuENMAqhvHCDIKJiWu8yZurSuk4/mXESrYnTkZtqMspPcGw/O+3k7uaHp/l9Y/Bw0PUsu3JH3EZ252QWXlgBi/56LyYCW5AqG6OP23Ij/ir4SGRSULlbgpKd/17Jn2RaD8QRK3n1qMGCNcBye0jt4QR9UurQ1wiRCiDlVhBKoNuGaBJ0R4ogoPsv9tj3eiQqCemedP8vBbI3XQ3bns/OZCGkEmNpsDNpx8XVRpL55wtEoyWqFUqJZnMAvci7/E1Fg9NLobkQQ4GNY5ZM/2HCJngKn4CJ5vBEMBmcEHpJdEohwPzbeJnHhiNGHHN+LeFhx91JgE503kM1wrDG1/g1z5oZ4HrAj5u27suvu3c2qNnCbZi6l7HfaDY20kidkAFnRPF9JBxr8Yx8smwRSrDU9vkgDy4J71ZECGsjH/cTU9DclsbZCUAFybM1QYqCaZbupOMmnUY/YQsNkmVNv5NvjrqyJTr3WClsEv4IlFzwf+C5/IzMa7BCunWMQF75Wz7GT+/yai
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(38100700002)(86362001)(83380400001)(5660300002)(6666004)(6506007)(6486002)(478600001)(9686003)(53546011)(6512007)(66476007)(66556008)(110136005)(66946007)(2906002)(41300700001)(8676002)(4326008)(8936002)(316002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQ72gaTQl3ZAY2IGQ2PtpFVqcsoOXknFCMQFm+7ZJ6cRksRPNauVVlCTw885?=
 =?us-ascii?Q?bKGa3DiX9kXYmwPZUrFKxqKtUBYIorjCC7KOv/qDvyfYyo/vZGPZeKuoZSvI?=
 =?us-ascii?Q?I5m8pagxes4QoXS4M/mEGKjeynvonaCNnxkCKPFw4eWl4pGd7ndvHscjbdF/?=
 =?us-ascii?Q?Wn2rLyGqFDq96j2BbigPj3t+CqCxE7HT0+amHTPJ5HTH3bZCkPMZpp8fB5t7?=
 =?us-ascii?Q?kl92B1FpDHm77fUZHtW2oMosSIwX0fopP743K7QU0WyHr6DO/6x8/upwZtGl?=
 =?us-ascii?Q?b/xDcZXw4LVFxzr/H1t9276cfoUlkQCKFpi8khaRlrK0abW/n9op6ndSNINO?=
 =?us-ascii?Q?jiXbCustzrDkkGxF4LpblGqg8229YqKtVkKxz2cDCoSMiLbtwzv0ZEC8pzAg?=
 =?us-ascii?Q?RCXJmNWx+PirwqLtnkH6sztfokF3ir29YIZcIeMRCRG44XaXOm46fBqq1az9?=
 =?us-ascii?Q?3vOl6dbHZYqLHheWJp+bNBYIZaoTEssWWnsrn3AgfIASasCR6Qj3ZxSufFUl?=
 =?us-ascii?Q?yvTbwEd9g7W6ykFGgaR8W2vLWJsN2Ma68asANAumca2mMaGNQYwgkU2sGJKW?=
 =?us-ascii?Q?OLDq38vBc/szfr+2Vh5oGe8GWMaY4gKCO74rrnfaSOuggvygz3QtxFFwk+UG?=
 =?us-ascii?Q?rKZF0LK3GTKG033OXDoNs1jsRBSm4AkaNUT/25iLY01/64PpPp3xZ3dA9R9s?=
 =?us-ascii?Q?jES5jnxkP+VMn3gDHQoPZ9OFhO+4R5sNT8aCYZHFWrn0uPLL/nWM4DDGDijY?=
 =?us-ascii?Q?LM1V5KGKUEmHrf5lMTih8jZr386xrhIyBjfzO0Atf7DEr+hRj3egLvY8DuYu?=
 =?us-ascii?Q?QkGNeppD/eq4+BOkZJbhw6VeS9HTAfESofEd2+mn5UbbmD7LD9u8mbkgHbQ6?=
 =?us-ascii?Q?+nGVkhv/oA5iIvrccmOO3MiUUpL7xKprgFc5w2n0LbWJAGmDuUT0RUqQcLNZ?=
 =?us-ascii?Q?irwtc8hu9Ck9ExjJKr1gXjNb7YC5hnEqAe0b1Dwd9E+pn0x8c/JRZtcmAC7y?=
 =?us-ascii?Q?WGbBSiIA5xOrG3aLip/BZPKM2JilMaYUR/6+t5zVcd6r2JyqlApYLPEw24dQ?=
 =?us-ascii?Q?eCQi8cLzSvAdz5cfIGX+5MCKfLknwiqJTwYYvZXwol6RFkfVx6yUcgTi9tL7?=
 =?us-ascii?Q?Uvc4RHw0heQ250r7eHDnp7uwbioaOvcUlGIUizyD2QE4nYJcpZJvy0FpMDn7?=
 =?us-ascii?Q?rTlfCiFUg3I30+MCIqCmEjqjDSqBzI1R95OifR2EWHDp1ThXfRwt/FT9DaQG?=
 =?us-ascii?Q?awIVrKiom6LPbVUqJyrRAF2mrPMpWOho6hgOUKyv+ehmgOiPHPTTJaCGu/8v?=
 =?us-ascii?Q?XCbps4UjCWShe6LL8oK1/mar45hkLz63iM4Vv9zkgecCB+0lhL7KKHr6DT5h?=
 =?us-ascii?Q?j7c5/EjK9nhqEpAx9giQVORZyTNdZUpWVsk6z+2fSQzVYwhtkfPV2NNFvJSS?=
 =?us-ascii?Q?v7OLEnIIZadowoq/9xktcybuEcqC34JSknycoK9IDrn1WFm/botPMFAQEMRJ?=
 =?us-ascii?Q?ctfIYZzktnwQm67Jr1tdp60Sb4JsDoY4gMqwHXknNjs+RiYhBo9HFPUCFU8c?=
 =?us-ascii?Q?9CF8UOBHBPtGNqoXVwjoK7MjFEP3GhSuxY+43L5qCDfmY/Vm9KSVmgqExOIt?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be73cd2-03ad-4040-7e59-08dc108d52a1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 21:03:54.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AsvhpuflksZmWCijh/RTYFFUMVTjBJsGoaJf5HDOV6pMnDFOMcaiqZhOr505/l4ycFSxH5soNSUzV/M4LHbn8/zJzL0ZWA9e8k4GueyB+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6720
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 1/5/24 15:56, Robert Richter wrote:
> > See inline.
> > 
> > On 05.01.24 15:07:46, Dave Jiang wrote:
> >> cxl_port_perf_data_calculate() calls find_cxl_root() and does not
> >> dereference the 'struct device' in the cxl_root->port. find_cxl_root()
> >> calls get_device() and takes a reference on the port 'struct device'
> >> member. Use the __free() macro to ensure the dereference happens.
> >>
> >> Fixes: 7a4f148dd8d5 ("cxl: Compute the entire CXL path latency and bandwidth data")
> >> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> >> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> >> index 0df5379cf02f..c6208aab452f 100644
> >> --- a/drivers/cxl/core/cdat.c
> >> +++ b/drivers/cxl/core/cdat.c
> >> @@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
> >>  					struct xarray *dsmas_xa)
> >>  {
> >>  	struct access_coordinate c;
> >> -	struct cxl_root *cxl_root;
> >>  	struct dsmas_entry *dent;
> >>  	int valid_entries = 0;
> >>  	unsigned long index;
> >> @@ -174,7 +173,11 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
> >>  		return rc;
> >>  	}
> >>  
> >> -	cxl_root = find_cxl_root(port);
> >> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> > 
> > I am not quite sure here, can a definition in the middle of a block?
> > At least this is uncommon.
> 
> From what I understand with the introduction of the scope-based
> resource management, this kind of declaration is ok for that purpose?
> Dan?

The relaxation of the "variables declared in the middle of a block" came
with the move to compiling with -std=gnu11:

e8c07082a810 Kbuild: move to -std=gnu11

...back in v5.18, and Peter took it further in his examples of using the
cleanup.h helpers to keep "get/put" in the same statement, which means
combining declaration and intialization, and means initialization may
need to happen after the initial variable declaration block.

I agree that it is a bit jarring to see given the legacy, but I think
this a good reason for an exception, along with some of the others like
declaring iterator variables in for () loops.
