Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98493BB48
	for <linux-cxl@vger.kernel.org>; Thu, 14 Dec 2023 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQhCMySx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702589140; x=1734125140;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4KKgEkhq5gSRNXf5nnnG4lcXKnWoG5BiaXZ6KoDMhjI=;
  b=KQhCMySxbChmIpcL8PJpT4t8R/ERPNmZMjXvSxAv9S5pwckyMMkdyqyv
   IfB3iG+MLfJ5NUQvMgXdXr5eBzBPhK+aOSelQ/U+kin8YmFdVvPUWYzFW
   k36NI7TUUZm/ebhyvb9CTFLToJm3bWWfFix47BogafAHdMgdLhMeOUZqr
   kHky9NLilU09/Cjwb9hLU5n54KlF+6Rcp8nmP7s/cOfKRxhp+AQ1MA7b+
   OaW/Fw9TbXcYSZchpuKtsEpe11WAb7sqmPto0COi86mjayUh89VipdGx2
   5SupkDFYvXkknkMAON2WotfCEmDegBe8HsgSczN+6vjAK5a+GfAyICnWX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2041687"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="2041687"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 13:25:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1021702827"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="1021702827"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 13:25:37 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 13:25:36 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 13:25:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 13:25:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 13:25:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/D3EonM5n3C2r3pFbg8/3n42eZp3ZWiksEKeHlYXz7zBB2I7v9uc7UYxpquuXmwU0Cj1+UGzSGMp8g3UvXpwGKj7eHzRe9uMB6hJxknxaCInIevR0RKmk7+dHYLhD+f0pw+sKDzaxXR1YPtb6jQZYej+uUnOcHw7dSg61Qj3IdlVTfhaHfWi5T0SgBhnJRvs+Vg7obZrBwiNEt2Pv8rVAQp4Dxzj6ag1JwkzGRvVRlt4IRzC3LGxNADo/tMvLhgqw3Cy8mgLIr4fMePSNURGeTXqZZkuQhQsmFmqO8llQv1TZeJ0Lo45sJdfx+ML1N69CSBnhldxxC/+t2qcb+81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAaL3KBQODzArhcJWB8ucY744PABH54ve3VzI/VGLwE=;
 b=QFiZjddjiXFDdVe5kWYRm9bPiSRPXy6cypIYM5yTUFnTXK6L/K1bBhDHDUDftIw5gi65wjhNgkf1BzARmo+vVNlzd5fyGDve1RJRjU45YjCXwIsGbJo0SYqnhtawDgS6rnhMinpQpVzaixYWZG4aswRM3BU1mTOtVmotwnAeXYlpYkM4ajQCDNYaSE7jEJ4hQAT8asoca4w34msT5DBJyBd/0uLyJ+/fgH4m3ychA600AWaumNT9o+qxh2m9gHHTCZ+9mwp/sZAe/UmPhLS7KXrvoca5zMYMMxaJzyg2fn36v4nBg6Ef2BL2xNkbjc2EBkkjfQp1PfySucNoPTJYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5547.namprd11.prod.outlook.com (2603:10b6:408:104::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 21:25:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 21:25:34 +0000
Date: Thu, 14 Dec 2023 13:25:30 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH] cxl: Fix unregister_region() callback parameter
 assignment
Message-ID: <657b72cac2ec9_27c4df29484@iweiny-mobl.notmuch>
References: <170258123810.952211.3907381447996426480.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170258123810.952211.3907381447996426480.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: e67b8ce2-f1b3-410c-7509-08dbfceb3495
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8JTgu8YYTa2/cCZRDlO47GWFeBELJ3jq8Hid71uJWED0cd8wCh5pJG6xPopArisg1AxzAmK4y+AkovrpZpsze87sqtFUAhYGBTNFBW9empd46nAc3PDkTTB6yRqsruxzHZdmvokm/HopLwR6r/6x8IOOisYPn30uqMe+LSy/OfqenA1XrCJMNuCfN1n8qGnzD164Q6byZkpfrqxSyX7iLFz/E5drxykABgYsUv7cupffW07BF6qQMBw4l9lgqrAqC3cDS3cwdS6Tebor9FpvwvKlvODEiCW/BEd1nMef01M4OVsLmINychJkVPP9I6g1G3OV8Hyv2r3pWHvNjBaBbyUc0k+t6qmPWRAA9cDzDhRyHjPQPuMWricVkKQcZE6ma07RQDm2dAZl7OlDSRKH+b+WGgnJIAjZ5DfbgQ1fAKHyi7Dkj2JiLWuSAmmVdFObcJ2hHlX5+SNhO+rXE8nnM+HSmXcqZvkFQNDEWY1AdULf1bDRLuTUGScxsq3UN0lZydwCmj38H0UWOPazmey/Cc9LGeRZzm2XdcHWejHr+z5QZ6LzE7C5IKniRpR4sJf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(44832011)(478600001)(5660300002)(6666004)(82960400001)(6512007)(9686003)(2906002)(6486002)(4744005)(6506007)(26005)(86362001)(316002)(66556008)(66476007)(4326008)(66946007)(8676002)(8936002)(83380400001)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zRUXAaPYJNzlQc5qd3d/fXCHfC83PxZxfiA8sCzwjd7qYnjTylNV396rLLLu?=
 =?us-ascii?Q?DtiLSzEMcXCinQRKRhnRcL4yrKShSR1SVnxpzK7DKsdATKH/WDM9q6jA7o1y?=
 =?us-ascii?Q?XDufi1da9gHjOtTJ0nP7lwgI6JSZ+/LMcFaVkPQu3jomCawfVUydu7ofmI3X?=
 =?us-ascii?Q?TUdFTmVyVHFr9P1qtfhjFJdmLRbP9tb4yGooPa38ClarqcKe53uz2vGlgUB5?=
 =?us-ascii?Q?lJt2WXpQITmv2iuWv7ovldV8geW/J69ccaw4OmQRuRztFzCdANgoQC5nwuUd?=
 =?us-ascii?Q?1GNB6wK9VmFIh9PLrgv4dwKnKcEQfIY9Ymao9MTRtbDc1Wr60HoA/SaPGMg5?=
 =?us-ascii?Q?FXWBp/zJKfJv13c1X3KfgSSlcK063uAPM7Lnub1M9f00TjIgD2ArVtTNi9hp?=
 =?us-ascii?Q?Xkz87oUfHx5bnaLJl7ZdvcPSolP4Bb2jLiB4edngEJ6HIaLuDz8omjSzF5u1?=
 =?us-ascii?Q?Xq6TQ3zxE3c2QSuD5J0FbfGFbZox6najHJq9NUQ39qsK7xM9ZlTGd3uJbzjV?=
 =?us-ascii?Q?HfEIrNNN8wnF3RVjmBzcre2bpZGegzaAlr3AY2l9EIjhGLWU55d4BOQu7Sy6?=
 =?us-ascii?Q?XkuA+S/yt8IfI2WKvaIh4XnOubYD6YMTK3IfDO1Mi0/v7xwoRyL4TSTKj4lh?=
 =?us-ascii?Q?kQaVOkLJ8SHrHGj9oU55vRA3y33fCOj3SA8UA/s4e5wGa92G4mqqUclXslYs?=
 =?us-ascii?Q?0csh6gtXG1dP9EMwmliq+rjc+mworGxVCcyGIWeK6PbpfnDSc/ZYGI2NMzhx?=
 =?us-ascii?Q?tZO2QvhGdFScfQKsHkqn7Ki6th6giBXYRTQSjfq2Oo1RW6mGBsjEoYSZwxOC?=
 =?us-ascii?Q?dmrDrEwpELTG2BftiqYIJPnpG860BsKbNceJ2e77klmeoxQ/d7+cE9klpDoy?=
 =?us-ascii?Q?QSwgoKHyG4cURBRSQiv23rpMZnOCCZ4fOl9CXRUwZoNsKUrkIzr4Kd2ZXRZ8?=
 =?us-ascii?Q?xfRwrMPyVOFfnocXMTsxfgGRL5MoeYbdzBsMrMbIhpGhDy6Ac6vyforuosD0?=
 =?us-ascii?Q?4yfwwKE0B+sTo0Ui1XFlucO2MhFy0VnN5ZkX2Qe4LuKyx+xO3mV9PRYBJPFA?=
 =?us-ascii?Q?RvZCPVn5W1/ION5ll/zHZZrBFgl13XAXVDKPyai8kYrgvMK2ZT+lQCtwKCXc?=
 =?us-ascii?Q?akuYZM4TQzKY5igSSvKbiTikHmcdqxuOfxi6yrxfZ9w2I7QqfFYowEQS8PNE?=
 =?us-ascii?Q?umnxUmhyRhTexh74WqqS9z69T2FNlRiDMJwSrFeqpF/AQ6guVqvIa682QvLL?=
 =?us-ascii?Q?ngcY5QdMpIbeTYIOaM12bbKdmz5VcUqANTAuB/Tl3uWk98eJT8uEG2MzgdKd?=
 =?us-ascii?Q?HsA30oYtdjiEHbTpZLmqqWsF2wkink2hrQnvoFUD/nLXKBnGTdXmrniVwLqq?=
 =?us-ascii?Q?kDSnWI7tfVsBJMayVy8Fv9BC1XtQ0xlfNdjV75e8YcI5PgFs4LT1AP7gZXMl?=
 =?us-ascii?Q?kF1P0YSbf2L5QKQ0RAv3RViv/Bhaerj7MHVbWZP9rGLIVqTfBHkcjRc2TJfu?=
 =?us-ascii?Q?NI7wipXuCBJck6fzbAzPDvAghv2npVLzb671vycS6ThPepAVPuhavvNnBb7j?=
 =?us-ascii?Q?E6oNlZvgUO+Z1mNDs5XRYhLOsPg1ObwYvyXelDpi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e67b8ce2-f1b3-410c-7509-08dbfceb3495
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 21:25:33.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FltXUJ0qMAGY3Fd7e1SJNxWrQDbNlZwBLWlF1vO4/XxJfSGWYtLmLJfBULu+kiVzudvCQhQX3TswR77mMsfVFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5547
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> In devm_cxl_add_region(), devm_add_action_or_reset() is called by passing
> in unregister_region() with data ptr of 'cxlr'. However, in
> unregister_region(), the passed in parameter is incorrectly assumed to be
> a 'struct device' rather than the 'cxlr' pointer. The code has been
> working because 'struct device' is the first member of 'struct
> cxl_region'. Issue found by inspection. Fix the assignment so that cxlr is
> pointing directly to the passed in parameter.
> 
> Fixes: 23a22cd1c98b ("cxl/region: Allocate HPA capacity to regions")

Technically I think the essence of the bug existed in 

Fixes: 779dd20cfb56 ("cxl/region: Add region creation support") 

...because the region pointer was used as a device there too.

Other than that:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

[snip]
