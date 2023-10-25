Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923E2D610
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZBa01gj"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3973310C6
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 19:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698199921; x=1729735921;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=qOS6qdJldlR0/sFkC7LOlf+u1smZDyZjXozrUQsPj/o=;
  b=aZBa01gjJd84CpgczTs5OoViUe7IJtsFIFRalSbfDuJ5bCC17rapjWRd
   /V9tS/FUWXThjxFFLF29qNaoUG2MIMgyEQf/ObZHfopBjVcQITec3efk2
   5FATfkXMRyqWJmrgu3KyOu3ohddfZvvmqXfa1B0Hr7jLb37iOWyCX2DaF
   zbPn9+Yt6UKrSstnrsa2EWBnRDvBAFzSZpp/VuZUnsyrJHDVM9AJrPNku
   ut1gJBhVbFjM3jJVkNfdUK//+FqBITfQ7eXkW+kwIyI20Z3nmUP1L4hDd
   QaBPhEO+cCpAoA5atPezvLioy8fHCNi24qzrKEUfdLiyRU15wYLXdShiI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="377587423"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="377587423"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 19:12:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758708355"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="758708355"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 19:12:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:11:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 19:11:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 19:11:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgSde6zp6dUv2MvAGFtFeygIREZcSYEixGVnIfo+qZo+WZkVpsyQg27KkJ1wBXrtZ4XQqurfChL1dQapMxiJpcw3pBQmwrxsy1rXSw+Fs3mhlbdOKvS0X2A3eGej4SfEfVj3qPzb8axIdF5uRtnAnObVRoe2izqEOR5PVSNq6II8bhMxkBloLI6RBXxsKeeoeO7sqEAdvtAQayDMla24eMX62tfzCTogMXU/x6d0KpP85rbb8BanVgedmplKXnWNILTm+8my7Cmj1lJ6gnJ4Sa23/mkFqWJW5tfTYrgRsyolfguUlm4Y2/fghHTERBeK42xB6ymPbGpqO7lbtgBkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9Wx3g6vaRl+c0umfTPUXJo4KbpMiKXHxIRmBd4OAHI=;
 b=Ip8sR9e9x14NqlMfMsxSe4rjPIwYLTtmzyFiWtFnjefCU8l4wtt2HtXrjumkHklOtdOi23pZjhe9wlCGs51B6IQ1MxrsSejCgWfF/7G1Isx7BgqsKyOCSXxCYGcTaX2KJMgf5/1Fo90Z+gc1/ENECQQ7pJm5s96gbRgkvnUNu1o2Wvvi59VzixNTsrwZVaP7p6v6TwHrIeCG7kMQIeJHAd7bXWnlr53uPAqACSVRnts14jklyU5aqBOa1o5ce9e+w3yHNvytMRM1jCYOjZ03NrbvL4xDpmecwrkZALlu3Y51hrIKDmJGgyF6ekpUh1Sdtq7nqm4I87tcAnknVoxd7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8096.namprd11.prod.outlook.com (2603:10b6:610:155::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:11:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 02:11:58 +0000
Date: Tue, 24 Oct 2023 19:11:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jim Harris <jim.harris@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/region: use region (not root decoder) granularity
 for calculations
Message-ID: <6538796bcd4cf_72583294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
 <CGME20231006162159uscas1p2b3ca1cd7a8371c20ac30b38cd70d65e7@uscas1p2.samsung.com>
 <169660931834.684402.2774329392272976121.stgit@bgt-140510-bm03.eng.stellus.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169660931834.684402.2774329392272976121.stgit@bgt-140510-bm03.eng.stellus.in>
X-ClientProxiedBy: MW4PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:303:b6::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de42def-6316-4717-2e7b-08dbd4ffc426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9s//dCqk48M7cp1mNEHCzMbQUxTnenaKaE3ol/B8XanBhuFigy9ox4PW9w7gzaSY4M/r9dGfKKeKengnIHCsuuAPvvv+VM1IzVSs6d14NoPGIQAGUpGzjgAV+k21+KcJPlz4lEuBZM80mkIU/8s6/JwnioMCHM4OuFCny/Rx3gOUhMDz/1NA0kVm5w6QxiSB16Pn2t0yjcgdYfSOlgNVv7aCAzk8resKER7Aezr0Lau6agPt96NSmyjyur9n34+46Ks23Ielhb4f3CPp2ZewzKcOlIgqOKUAjNs91lJZ7TD7q7PZ3iDvWcV5EETbW1kztYQZJh2sNn1Q1ibZmX60WIuOA4mweUO+GrYNOjxnW3OvceAeQlH/RfIhJMFsG4ZU+01bQbddNsi/AxnCEqnvIC8EF1nIqRLaPc+OZyr9nYGx4geQqngxqALVGbdrSOUPS8dgXyXy4MSLt2BBlg0uptySnkj7516uOESShxxwRZxbDYw1E8e7VWft/D4lrLu9JUUOOeAPo2cqrfNp/SMkHR9cq0SRIawWCNK98MGpQtpoPmvvCO00sCEQX12pjMDu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(41300700001)(2906002)(38100700002)(82960400001)(110136005)(66476007)(66946007)(66556008)(478600001)(6506007)(6486002)(6666004)(6512007)(9686003)(5660300002)(86362001)(8676002)(316002)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whlynxcY2NUa8p4sEbD7VvN6MVrxwSCAFGaLedEF+DLnk9YFiJbWX2Nw/XGT?=
 =?us-ascii?Q?n0EDj8pAkwki4RFk1/lnz/PD4TUW4emaFastcFAeB4GcEsdlRTZQVGmorjvU?=
 =?us-ascii?Q?sEOL/jZHOyIpdHcKE9RMNhNCZAgeDk1WdxD2/VJqdnGPoJwSYLWhwFRuo3nt?=
 =?us-ascii?Q?QNI+eVObv1U1pY9LX931/Wy4nRDGYCkKgRGtnszWc8F6cZQt3SdqofaV8H94?=
 =?us-ascii?Q?oLIejJOMqWt437ChtG163rJKFpivYtszNQFNghTRrWMGjko4RMmDL4bFCELV?=
 =?us-ascii?Q?lR0F6qlPFwYU8+5FVckK/vHRTSdhiextxfmvUSSzOHXPWPh5z9Pkbj3i6E/C?=
 =?us-ascii?Q?GCM1Os3MrHWT6cHQZjaYIMyWw767lDH+BQQ8lWuFqdbs2d4sBIccwp0bSRwM?=
 =?us-ascii?Q?zwUse0UDHbULajJ+Ilvnm3yehwInaQb51T18J12uUbHXK4Rl0XPVPL4RxCoF?=
 =?us-ascii?Q?jLhO2VVfs6S0jdsnpWfkzw4Bmd2LdHKM2A8No4otG0/0eULEBtqxJKZWAKOr?=
 =?us-ascii?Q?0UWDnj5vTak5I8svfX0nWmY9Iivz8Iz6rmTGrz9fDTOIhq6D8nbM3yuUJrCb?=
 =?us-ascii?Q?K5ulmDqwCrNwFhocskZBx4aGNnUYVHUhzGLkI/3BYtEhaIhID5pQKwqFHoEW?=
 =?us-ascii?Q?V2rj3/X3KnHzaHOJcGz6lvoBquPr4sR0bgUu8DQFn16DeHYc/WR0HdY9OUOG?=
 =?us-ascii?Q?JEmxMPhFyew9LVyG5jRt1N6f/gIdnuFvw5eWeYYme4pUBqVoWyDA1XUidK/n?=
 =?us-ascii?Q?5qLm6p2nHgHmut2A9bvwSAhcH7COvaWbTfMfEMl+tkvs7foxkmH/TW+AIl2f?=
 =?us-ascii?Q?s4DmUZdJUkwg5buAJAblJ+1+Rr7cuBbRP3XmuUE0iu3Lz+4fjHaF89UZe+yJ?=
 =?us-ascii?Q?+/mIoio2nRj/Dc2pTQArBf2bjX8ajjOg3NrnoIJ7kNhmGASmYVM9xw0PKlK9?=
 =?us-ascii?Q?13zsc+wFHqJhhoYY2y9KviAMIidjo7VQhHME/EyMKMomfVsX6dFEJyAc0e44?=
 =?us-ascii?Q?ACMxVnQAPExhcnyvY53NZzvSocobxHhSs2o3MTMM+VW4k0v9jXlVZScgYPCV?=
 =?us-ascii?Q?ag8R5FrsWKZGsRelGXzxU23uQMdbiTuxEIqdTTuiagZBXk6rXxHotxf9I/FW?=
 =?us-ascii?Q?DKknIuxOqEuZjEP5UunLALEhalNW9nCrdGScGdD5qR7xqKXj97aONdeSzhnt?=
 =?us-ascii?Q?gARzTl+QXX4G0YKWM6jO5wt2NGhvChaA7sk5yG1o6jMpsVBwT/0rlwXDHea6?=
 =?us-ascii?Q?rb78F+T34ZWEO+ptFk0l7Ds1/TF8OlQ2/BHBj3a/nWGIGk5e2Zdu8vTdwfg4?=
 =?us-ascii?Q?LxsLMgqOQjazBhqJV1Xg1eNhMDbhz6tAZF+m2yBGcifhjNtQTKy2kPYNuwiC?=
 =?us-ascii?Q?zREU89864D2Q4iIfvGYiryH5kFUWcqQPx6dGvhuKboopJn9KPpWlMPbdRYJ9?=
 =?us-ascii?Q?hAiCvjyu2TTr9tPyg5HcT22RBKpJwC527WFerEb/Wz2dVD/pYx1VdLoDLW8X?=
 =?us-ascii?Q?3A/dSszEYkZ79kmpwu2kBJK68dYrdDYIARmi8be5/b4bw9RDheQR85ORqVps?=
 =?us-ascii?Q?84Ys6UzHymDHIMwxxfED7+xCaJrUsb/x1Bm9Bp/SOj31VNPlxEfqbjxCj4zQ?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de42def-6316-4717-2e7b-08dbd4ffc426
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:11:57.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRNEZW3kJ7ot7suB6bWIfJqVl+EvXTyiTkiNJSKaLN7VBn8/JDRG5lhGQCDhGfZejHJd1UjpkkI64im/OwcC8+Vea/OTVbBSQkwrMcJBfBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8096
X-OriginatorOrg: intel.com

Jim Harris wrote:
> Root decoder granularity must match value from CFWMS, which may not
> be the region's granularity for non-interleaved root decoders.
> 
> So when calculating granularities for host bridge decoders, use the
> region's granularity instead of the root decoder's granularity to ensure
> the correct granularities are set for the host bridge decoders and any
> downstream switch decoders.
[..]
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..70f7c66ee2ce 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1133,7 +1133,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	if (is_cxl_root(parent_port)) {
> -		parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
> +		parent_ig = p->interleave_granularity;
>  		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;

So the reason I went looking for the interleave_granularity_store()
version of the patch was only because this one when viewed in isolation
has the problem that the root-decoder granularity can only be overridden
to the region granularity when root-decoder interleave ways is 1. 

Is this assumed safe because interleave_granularity_store() is enforcing
that regions must match root-decoder granularity? If "yes", then this
likely wants a "/* See interleave_granularity_store() ... */" like
comment to describe why this override is safe, if "no" then I am missing
something.

What I liked about the idea of putting this in
interleave_granularity_store() is keeping all the simplification
shortcuts and commentary in one place, in case the region interleave !=
root-decoder interleave ban is lifted.

I don't mind doing this fixup in cxl_port_setup_targets(), but would
want the comment per above.
