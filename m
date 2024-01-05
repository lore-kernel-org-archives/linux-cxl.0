Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587C36084
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSFGCWSV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704483332; x=1736019332;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ods6jFtXnTzL/9yLLcgsd6DmeZ8jxSe59i0EmPXbWag=;
  b=BSFGCWSV7KxTHKfHgpUtolotuQ3JWuFODq87EWjrIqy9msB5Es0KJsk/
   KmBEr/aVJJsOhVYpEGHwJRtzXeCJsX1KZOb8DFSufoYGiNbGQHI62UHVS
   6OVSbrOJXjXj8RnvrgFFnYBgtKiBLBazvwuKXCSNvp8WwJkTvjBlVE4ua
   7toH1L/AlmmxWQC6jAE/KhupyyKBC06cd15D9WCP9+mz09JiudR/rs4e9
   lBQBYQalT6vCmV2MZnBxVQwZGk9RjYH/Jq5sbA3HERbjGNlU1inD6PRV0
   aACSK3ONFY845lk98vuvVcFV0cFpghU6N5LUeOB6WBYJ5h9dGHHdSOsgN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="388019695"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="388019695"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 11:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="1027841394"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="1027841394"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 11:35:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 11:35:23 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 11:35:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 11:35:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 11:35:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND9LCh/hqBrPuUzqfdxeEaYnrMD/d7KfoB1d2+hJbej2OE0vZ7vbmDDd2ZhP/e20ihWgSoUEbHbXbKpzy39vex7U6ZqpRFNv8oT964n64mpIY9/zIEwUpuyOG5CYab8ANiizY/76W8/Vp35KoZsXwtlp0yv0e37asosHeW9WzhsetPLOnEvFgcwh9gMdnQXb6I1dxHYRUU9+caOj6Ktfi3GKJZKsiDkY2fQH/h1FapptOLkGg5RbEYQ0A2eAbHVa5oqCJ/s8laT2PLFAVy7hz+pCwt+GEY3c2uzAs289QJcXDG4LPJL8KmSrt9MySPotl8UI8Bi0u4Oy+sGKanNK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ods6jFtXnTzL/9yLLcgsd6DmeZ8jxSe59i0EmPXbWag=;
 b=U7iB9XW6qR8QyQKs8nd0aiKC7pURvlkWERCBS1QrJkSbsqB+Igp9oR86dQWygeJaiOBFmJ8AgP1zjHiyZFtEX+HNgReScNH7QiXbb02LDuyCLZL7Tj5Nh6Z0mClooNc4Gyb9xJo+yJt2lcOAewpHZ8tA4HyaeGv1ML0FwmRPBYVWT/Yzsvf4hK47L0S7lU2H6xElMR5tl6xn35WQSSvqZM/3zZzuvtuNIt/AnOprJ4LemrJWmKSbf7dZLaHEGhuflEnKdL4cQuWKdrrqaQ/J401FV3Fxdhfjc/RxaCeoKl+/rfaYLGY2qkPiDWYYt5Ax74S2Dyf1HIB8AIN9y5bDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7834.namprd11.prod.outlook.com (2603:10b6:8:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 19:35:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 19:35:18 +0000
Date: Fri, 5 Jan 2024 11:35:14 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>, <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: Re: [PATCH v5 0/5] cxl: find_cxl_root() related cleanups
Message-ID: <659859f2ded6e_5d3ae2946a@iweiny-mobl.notmuch>
References: <170447769575.3687480.11698914923419362733.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170447769575.3687480.11698914923419362733.stgit@djiang5-mobl3>
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f9fd0e-1eb7-4f35-c750-08dc0e257304
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqhUlue2xysv9efWQqBuMslKXMXrV7Y4xDFxgyitW4ZS0wRrOXQDjvJlnfPnujgXxH02H3Jq84YaR43cUZlvRZ+26kg2IwE/+JKYlEJc707mA/gvUCcv8qnc20i5UKiyVK8wfIy/3Oaa0C+MpiB/wGFaPBOKVQLyTWBdRguvZHUJKZl/RUNoMmWjWZWwrKd4kSbIHk+K4HI9BPbu7BlsvAInw6BaJU5XrMZY5GotufbyfbmVfepUqLB29S/4vI93J8ic9mxvy+kdkGD8kr1mBcV7hIIB5OFLszav9N3dzFbdNT4r62QcriP7UApV7RuE62d+AUjMyODrViyhwNBnSEpdcXuRPHC2rWW29YahX2aywl0pfyL9JQyi8O5NQpWvkQoH2UwvYqKCTniaN/ES4loUqtLNhyvkKY9MyNYTL0Tkn1zG4eKGqm9qdPXd2SE7y21qZlKYNR9iLf3utRojEm6F2ewob/aMwYSEVculh8b9TnTFDtKVCbZzvmFRBA5WkI5n0pI+cgtNH9aoCP8si07fUSuhmanVQgHgYZ5n/mKqaF8+Hymcoy+n4dmtmq+D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(6666004)(9686003)(6506007)(6512007)(86362001)(4326008)(8936002)(316002)(54906003)(2906002)(44832011)(5660300002)(6486002)(558084003)(8676002)(478600001)(66946007)(66476007)(66556008)(38100700002)(82960400001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kyUW48yXv2hGlOMv8hxQKDhdyDa2Ypk1ATDtILrBMZrT8GYnijmmkk8G1nzi?=
 =?us-ascii?Q?RhCshpku9TVlhpDcD2aGUS62W9lOuXJYjYHvfM1lrP4UU/XydM7BBL9bmHeB?=
 =?us-ascii?Q?Gtv1wz49JSzSbttDx3x5JLxLzujRsHd0NF5gWm/SUskmF4EXwPVmCdelVAGf?=
 =?us-ascii?Q?B+nRleW8ykCdctpMHhT0AqPVHatRSMKe28Kz5dYARZuC7ouM/Hz27F34UIGr?=
 =?us-ascii?Q?vrLXc3UNI7GC+nYBSpDkNrSmqZi87j9dVR/Iz5Mh3UBOqD2QQVOPh9H7zrns?=
 =?us-ascii?Q?T40fKQi6hj0T8KOY/lH8Md1e4JsRKvnbj6ZWQs4GeaMN9nxzM00eErPxt65x?=
 =?us-ascii?Q?4/hIO9B7CjU58abuOfLdR8rS/ZmVeDtWvcymNeHLUi0becHn+E4GkLRQcuV3?=
 =?us-ascii?Q?yhCGC4DrapMOzBgVJAXSawzeF1r0kPy0syIFIPNH5iXTEIYcEAO57iiJntyb?=
 =?us-ascii?Q?zcjsPBMi94u3wCLX+sASS4maUuMawo5bj18+FYM2zudL/wJtN47Qj/+5s9Cx?=
 =?us-ascii?Q?s7TBMNtP1pB9GShFlr23332tbicMWSz7jch9gzNpKoydXUFQ5hMZn6kHqTqh?=
 =?us-ascii?Q?LbLNQVXWMxptRG8tmDF15jevPAAcwbOzMh8O9ugmLCZqgpGtmtMLIYKuiz7q?=
 =?us-ascii?Q?yLd3c5S8uYRFIzuqTE01JRAhZKnCUr3mw/xHM0jOopcYKqcDw+kvUa41vR3O?=
 =?us-ascii?Q?eKa80NuFwClg4QvAOrX7IdNxrBQzJHcJUX1dlIzhRR8UFBzrF5io5uL/eyZ6?=
 =?us-ascii?Q?e9OzvKGiwrhzT0IqiXewJaTVpvnvYXHSrzZ/dKx5Zq71kPhkWBZIB5hTbIFk?=
 =?us-ascii?Q?GU7x7sIFhTuxC317oDBliuVM9JKGB+rQUeauuoWKYmpmrTxP0lU5dlVvrzmU?=
 =?us-ascii?Q?zj5tvxuu2Z209+lqtke4vd9eBd8kB3P11OoJ5Gt6Od4vbyYZTYmGXK1IDFlN?=
 =?us-ascii?Q?hcAakcBQPosWLe0UaHroR2jjHuHCbBWYwFH7cYBEa42KCwpiNHatpCbN6hQz?=
 =?us-ascii?Q?E3BpSuwr/5BC55QoI5wb+zMgcDbr4EKdSq++OF/XRX6DWHpL/ooc6BRGgCFf?=
 =?us-ascii?Q?JAFKB+kFteQ+tpLNpZIrPsQN/Dy+Yrtejj+DRl0T+guMn/Kh9ZEmcdYaXtOl?=
 =?us-ascii?Q?NI5qhOCdc7B/G0N/2iiSeJBRJQAvyqFs654QyFmGy5PicTBC+YfpZN4NJ2xD?=
 =?us-ascii?Q?KvmtYH66XCRnTFDoS11Te9TByJcJlV8M3cu3ogS6W4am6zPUI/TBIeMH65/N?=
 =?us-ascii?Q?uCh7h/zkdX2E8jI3YqmYixWmC89Dcrpr+qakAtDyMhFBPTWFEOxbH5jrpdQ9?=
 =?us-ascii?Q?UXov4fL4Cv8l7pbSh4Bg3hC7mERaOO+lfI5IbZfcyRzupPSL2PC+e3HQ2rTU?=
 =?us-ascii?Q?MidrZR8Pl+iZUPM92DKZ/P3Y4m2AjKX9Lx42RiDrd16w3K1gRL0EqWDWgKbM?=
 =?us-ascii?Q?wJOpn5fdrA/w8uqM/qH2o+TrzxQ5keQDLXnwflkOQCuZSkCmLlLC4qQqfUl3?=
 =?us-ascii?Q?YmwYa9mmcTlIbVL7vneqBoY+9bjwmsemGyDR1sFu63tgbf2VOQpt8h8M4ej8?=
 =?us-ascii?Q?idIxKqfHt/7nQ09pGSinkT8zQ/BgZVRFraoeIlv8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f9fd0e-1eb7-4f35-c750-08dc0e257304
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 19:35:18.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NED7B4Ol0ASgfeirp28TlNdDlyv2raa0C9GNJXDoyAnODfJlWmVKqqbRB4YZ/vYTHKzSGWOBl9lCFOPl1/NgMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7834
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> This series provides a number of small cleanups to make fix_cxl_root()
> and related code more readable and safer.

For the series

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
