Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6ysiHc3"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4798198B
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 21:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702014925; x=1733550925;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vlZ1b7EM2yfmGqGreCvOScTufn8325fzXFgtbvEixGI=;
  b=b6ysiHc3pSjcZnwzDG3nS49kRUXTtxPd6u09+1KsCvopdggsUrbrO+Bu
   TGqN3rWfV1t6JPW7sIlqoyQo+EbBdEkwFZgmjKzem2n69/JvN4PxWV9dU
   K9CEGn1MNzvWkGS37fa6B37t5usdZUd50aKdaSqzwy6n8bEF/ir7fBQOT
   5xtuDtZjFIxoX7AJt7zgP0mnxGtqggwoMEVcMps+mz7ENYzsVI4GnXKdU
   KSCccjSD2vifVe+KwrRhwS2S7oR6tgzW9JPKD6BoxIaMwdMZmFMjz5f03
   9WdywsKeFbThH3MKAxYkmMLKm+7HA50mwKZw7qhatp439pflC+XlGJaHP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="379363729"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="379363729"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 21:55:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="19970774"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 21:55:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 21:55:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 21:55:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 21:55:24 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 21:55:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ8W5XRyMIyrJg5614y0gP/sgQJvF+Uz99pD4ITqyrzWMlEReTHrWbMKbj65ouNZB7sSeLqGYOOWjZm+Vu7SULWjPNA3sraINVYVsxQHL6TOdnhIpio9PN+4tYWIsT3BBSlYLzWTqXTNRi+IEdFyhLL6ydX+g7k8kDe4UbaH97IieEL/19hjDcI1w9Z/oV8raAJ97KZ8gLa+xQRKO7obxIWpQjzT5XkA1bPz+InYQN0+8XpaspfPMyXJRzK1AdW9YxZjzCvZx2gk6bryT0euJ1T4WKlZ404zL5A8HQscWPW+SWF6Q9Xp5PvBae3zYL0JR5fuPyuLKAIc5e3qoDrQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfZVWkDJet/B7FuQmYst27WXGzGkuVacqH9f9hM4fBo=;
 b=hA0ELOXuC11gUSvjks2g5zyotPnKrbZuMS6JIzLZnbosRiAU5Plpv/sXsfPa00RNjVBJGo2zSrUasGoY8mZNbj9rd6e7GbqlDBTr3cMdNwrmAkh1ydETHucnlx+KjhKOzdOSQ0RRna1Bb5bdzZYjLi959A4FVqDeIqscRg932z2F4LUG9xz5DwgZvn6086E2X/bfjm01HaaVgeRNguHGTGixXlJDkEowEQYSwPq+6/b7MxvsMx6PD1AXkt4AOL1mGxQpoTfYLObTw2EODm39Gi1Y8odysotriNw1l4MeYqMl730eZfvJNzd4Xx0AC/Cw/t7fkogcN/93FKriLwJj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4868.namprd11.prod.outlook.com (2603:10b6:303:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 05:55:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 05:55:21 +0000
Date: Thu, 7 Dec 2023 21:55:10 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, <tools@linux.kernel.org>
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Robert Richter
	<rrichter@amd.com>, <linux-cxl@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH b4] am: Build patch series when additional patches appear
 in a thread
Message-ID: <6572afbef7dd_269bd29422@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231207-series-from-non-reply-reply-v1-1-cb02de53857c@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207-series-from-non-reply-reply-v1-1-cb02de53857c@intel.com>
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c7965a-c16e-4bc5-483f-08dbf7b24350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHnwvaCkwBrPhdxFx+J/hhwndMqObFilHzmrPEK3oNG6nLz3GvUeeMEoPAVJHMNoDpQf40x/FsCZUQqOQXjy+C1v0pKxutY2oevlW/4wB15AbLUU1J/THOuIM/sf1sarc4dhQzeE2NbepsHQFuyIbgn8Uo5l51sMMvhSTDz9uC0K5JI/z8wg9baO7PGD+KXtvhUN06aG/mRaJlLI3Sa+naOXHKcCeLggVUDVg9B8CzlCCYv+qA2OaGBUTwAip6T72Ee7OGHLnLLjhsBRB3DTEoBMAswGtpAllJuTbiEnoSTTWFgmKQu1dgkRhllpPHhVm/VjwutEDdZ4gR5ymkEMY8ipiNNlK37IY1asKRwjxlt3aX0M7bfXUoqRh+imy2mFaa8Wn3XyVr58hHQ8AB+SM94xep0Op21XUxR66h8PE4xV4sDmk4UHk8hS0MBSuZBkghdE2lnhgNbtbRIyM2GoN4efLXM/IZWpA6OEWM/Qbw5L0hqZ0DtwJ9xAkbMAPblBVHo1HZIU00yrBhJ6mSml/+6sFZQyC3lZMJ1VQH4UuC/2Eq7K6oPugpPhhjSStbW3ZiBwvrml9/eK4SMIJ4JXpQmxOYiLcI+1W9yTBwTBPrF/QH+kF3+yAzINSd83HFh8zpdCpu3nM8vPLZtcEV8IBPcqTdjMxs/cntNbftlwsyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(6506007)(6666004)(107886003)(38100700002)(26005)(41300700001)(6512007)(84970400001)(82960400001)(9686003)(83380400001)(66946007)(66556008)(54906003)(66476007)(316002)(966005)(6486002)(478600001)(86362001)(2906002)(5660300002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFFbFlvUjFhaDMyRDZERFBHa1gzNVhEN2RqVGdjUU1hVXc1QnZoVWNzZXlB?=
 =?utf-8?B?MldyQzBPeCtBcks5YlNvcmNKcFFPMWtaVXhMaGUvNE5BWVFNdWNhcmFLaUhF?=
 =?utf-8?B?bVQ2NndWLzl2aXpvNk1vRjR1Q3c4K2VBd1UxQTFPeXVLaklDSFN3ZEl3Y1B6?=
 =?utf-8?B?bDdWa2J6UUQrLzQ2dEV3Qk9uQlE1UjRmQVI2YzRUZVJkMlg4TkR2WS91OG9q?=
 =?utf-8?B?MkJZNkFMSGw4aGl0THlpT09HTk9GODhDeGw3akZkVlFaVzNYeHVVaUtOK05N?=
 =?utf-8?B?N3I0WGdlOUZmNXhzRTl2S3RibTExY1FWMnp6NzRmMFNqUnRCb291NjRmS0F5?=
 =?utf-8?B?RlpCUEkzdUNtdE41UXhWcWNLUFMxOTRaMXhZb2JHaFVTSTBtNVVBOTdNVWtm?=
 =?utf-8?B?SXE2azNoNzlENEw1RzRhOE14SCtuV05TemJXNkJKZmNwOWZZQmtwTGFVWmhx?=
 =?utf-8?B?RW15bEJBdHRtQnJrQm9UbURQSWt1ZitTakgwSTUrTCtaTlVQWTRCTzR4MHE1?=
 =?utf-8?B?Q05lcEV1T21WVEZ5MDltRXVkWHN6OHB5ZXFFRVFkY2RTY3YzRnRnMG5ZRzBu?=
 =?utf-8?B?QU9pNVJCbEVrRWZlalBhM2M3L2pVMFE3bzM0K1czeTVWa2hFYnRHRUhCNmRp?=
 =?utf-8?B?cFdrZWdQTFRXZGJjY3ZnUWUzanE2QW41U0orZjh2MTdQemFsNWZKcnNjcSt2?=
 =?utf-8?B?WExHeUpuNExxM01RbTV4MDBUSXVUc3NuUmxVUHhWSUtnN3E1aEdaODJRK2hk?=
 =?utf-8?B?U2F5YkVwWkE0d0RRM0o5bUhlL0FSU2Y2NUlDeTk3eXdOdmpaQ3NVQ3pTaXhL?=
 =?utf-8?B?V3pIZ0xESDloMXdaSzkzSnBZNmhqVFYrUFMrL2NqQ0pPcU40OFdEQVlld1du?=
 =?utf-8?B?NDA0bmZucFdUVUJpVkh1N2QzNEF2WkFBdDJLZXUzYm1vQVNyRGtSendMY0Vj?=
 =?utf-8?B?OW8yMEo0SlJvNFdRa25zQjYwa2t4Nng1Q1h5WlRwLzdpcDhCb205UUE1cmZ6?=
 =?utf-8?B?d3N3V2xaTmZnaGVZZEd5OS95TjlhSEtxTkhIeXhDYnl0cU5XVXEwaDNia0pT?=
 =?utf-8?B?eks4c1h3bE04R2R3a1RUL2lnMTdxQU5WczZVUWZieXV2aFRpSnk3aHNWblAv?=
 =?utf-8?B?eWxnQnlwb2RMOEJvaG9EYUhIR2tvaG4xdVVOUVhERGIwcnRHbWUxbjloakJo?=
 =?utf-8?B?aU1QYVFJbTlEZWQ1dm8zekRoek5nQnJUaVpneTlvenNrVyt2NXl3dS9zMm1k?=
 =?utf-8?B?ajB6VVJPdDcvWE5JMkt3TWx5QzVWRUZOVCt4SnhkSC9sQjdJaXV5UUpucG1X?=
 =?utf-8?B?UnZUR3orRXZ2OTlhRzlmcW1mUHNSVkZzeHBOWHRJbGEyWHVRMld2VzM2aEtj?=
 =?utf-8?B?b25MS3g2U09qSVFSdTI4d0srL2NiMTJjT2xqNmRoaXdXVUhZem1tN1RITyt1?=
 =?utf-8?B?aW1lR1BRUU5ZaG9xSTNuQVg4bXpIN2owdC9WKzdzQk13STZndjdVQnZ2RFhR?=
 =?utf-8?B?ZVpkWEVhR1hYN1hvakVEbW10VkNqbExzVU91MTNld29IWDdvSXh1cjU2OHRO?=
 =?utf-8?B?blNjOEFRZENSUUwyTmhyMGVsR2hQVXEwcWZIdEprWUdzcm9QQndLWnBFZ0Rn?=
 =?utf-8?B?Wk9BZU54WlpHYlRYb1poWWZ1VkZuVmhNMGpqRi8yaEtOaWRRQzFQajZiT2Jl?=
 =?utf-8?B?UldvdFNXRVgzS20zNkdhNGoxWGJJQkZUNzhyc1d2SUtoUjNrTjAzU2EzNTFx?=
 =?utf-8?B?WTA2UGNoczduMXRPbG5POERRajlIdnJGSWdsYXhOYTZWQ0Q3Tk1kUEEvVW1y?=
 =?utf-8?B?WUN0Z01WOEdrM3ZMTm0vZlRHd25FOThId3RSYnZvdmVzckFkUXhodklYcERQ?=
 =?utf-8?B?MzFOaEp1VTZGYVkrd09VUGErRm14aXRBV0o5bWt1dzh6Qm1DNXRpZE15VkRa?=
 =?utf-8?B?NHJtY0tuSVptdkkvN0x5YnBhWVc0bXUrZ2tTS0h3cVlaYTV2T1lpQ2pPNWI1?=
 =?utf-8?B?WmRZaUg5aUxRUnNPM09RZU53TVlGYzg5cXdZSDFoYjgrNUwyT2JsSlU1c1Nh?=
 =?utf-8?B?TWVEeFlKeEs0WmJ2cVdpYWR3U09HQTVRQ1RqL3ptcm1sd2tyeXFQb293T1ls?=
 =?utf-8?B?aEJDQ0dzTmE5TDdwT0tOejU0VDg5UDdRdmVib2ErUWNBeksvcGFqNW1jOUk0?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c7965a-c16e-4bc5-483f-08dbf7b24350
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 05:55:20.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZplTg5fU3EPVkk9MY9xnVEpRUkOhal4z6KT91iwVwbbKbmmFoAnBfloNFGL/nsjv69nhcryBKPLEY6vnNoGwz8gHC2OqR/B7yKgt7FQuwBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4868
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan reported that am/shazam cherry-pick was failing with a particular
> CXL series.[1]
> 
> 	$ b4 shazam -S -P _ 20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com
> 	Grabbing thread from lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/t.mbox.gz
> 	Checking for newer revisions
> 	Grabbing search results from lore.kernel.org
> 	Analyzing 8 messages in the thread
> 	Specified msgid is not present in the series, cannot cherrypick
> 
> The reason is series processing failed to detect that a non reply follow
> on message containing a patch was not a replacement for the original.
> The way this patch was submitted (without a 'Re:' subject prefix) is
> actually a good thing.  This is because a reply would have implied a v2
> to the original patch rather than a follow on patch as intended.
> 
> Teach b4 to interpret a thread like this by adding the additional patch
> to the series with a warning.  The series can then be applied as normal
> or with a cherry-pick as was necessary in this case.
> 
> A run after the fix looks like this:
> 
> 	$ b4 shazam -S -P _ 20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com
> 	Grabbing thread from lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/t.mbox.gz
> 	Checking for newer revisions
> 	Grabbing search results from lore.kernel.org
> 	Analyzing 8 messages in the thread
> 	WARNING: duplicate messages found at index 1
> 	   Subject 1: cxl/cdat: Free correct buffer on checksum error
> 	   Subject 2: cxl/pci: Get rid of pointer arithmetic reading CDAT table
> 	  2 is not a reply... assume additional patch
> 	Checking attestation on all messages, may take a moment...
> 	---
> 	  ✓ [PATCH] cxl/cdat: Free correct buffer on checksum error
> 	    ✗ No key: ed25519/ira.weiny@intel.com
> 	    ✓ Signed: DKIM/intel.com
> 	    + Reviewed-by: Robert Richter <rrichter@amd.com> (✓ DKIM/amd.com)
> 	    + Reviewed-by: Fan Ni <fan.ni@samsung.com> (✗ DKIM/gmail.com)
> 	    + Reviewed-by: Dave Jiang <dave.jiang@intel.com> (✓ DKIM/intel.com)
> 	---
> 	Total patches: 1 (cherrypicked: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>)
> 	---
> 	 Base: using specified base-commit 7475e51b87969e01a6812eac713a1c8310372e8a
> 	Applying: cxl/cdat: Free correct buffer on checksum error
> 
> [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Tested-by: Dan Williams <dan.j.williams@intel.com>

Thanks!
