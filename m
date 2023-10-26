Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCA163
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfLjpkNd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D59DC
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 17:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698279077; x=1729815077;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=qTSe1lGEc7jsy250yIlydnNDX+KfTJlrry01W+DLmWA=;
  b=IfLjpkNdj9KAA0Gl3AtIbSo7XgsG0F/f4g8tdt37qvwzDs2gBmAXvi/v
   CbWiwQh0Mm9EmhbqBcmHNMNNKGsjIf6sN/mwXrMfM81eD5tlL/wRHJZQa
   rxMgEkecalPLc3im+HqCp3ixBxtP57cTlUwY0b+QDNSDjiaJWLkJagwlC
   volG64Uf/4knL75wwtmLPYD2avGxGBqFgpSn8s5aNU9xPpj1tpT9x9Z3n
   /ZIpLgY7Po/Do8AjSalSiefNpxDl17nEl0oYhUOmpL0RCXO3ac9qWMR+0
   JiDAcHSJBprU5kWrizf2MG/2StNSGQYyteoCv0bSIWGjZNz6/J7S9SRAv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="213560"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="213560"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 17:11:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="301600"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 17:11:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 17:11:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 17:11:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 17:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrxpuCYwsHEWISRL8VT4YTHd6CgAgWZL4vteTeB7VtHGKk0lEg0493lRbSB3YdKe3eUDMqMxnBOb4rM66BJIu3FVcN3dEIcz9JzwlAjTglQc/4UdV4GlYUwnOcBY4qI9YGE87k2H4Jj5uTit8/hWaiyZpAYDNPYclpuMlkul/YHf0TBJckyjwbrKN6g9ZPfIPoLq944oyzC1ze6VjB8kb7WJBF3h8SadCA70dUS+ZJ9YGs+a9T6elO1KrMEE1U0lZM/KJ8QnuD4owI/hTmvTTk/IQDiZ8zDz+0uhnwgaaGcnZrQ2lZ6Pt4z6o4F542u8XZ0qPFJEmLjf0j/Ir1+OcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1So6j6L0gM87f+E0nXa4JLQXrhyTE4gP3ztKGaSF+s=;
 b=fnn6usg2onu+f+nytUoL7eGA87kEzICFwGehedOlsyg8LD72D+X0BupxtxamRgtC8PQ4xEZuG74b8/XFx2zib2s7FGlGHdE7BOsW+Luz583gLAPJhOXmKwGQvjMZckhj48aQWOtKoJhJpTm3L3vDmWzb275Ke7lMMalA1AuTJEqbGhe6P4tj69C/HBbW0Sxe2wJQvbiL7BCEbKbFjfz2uEnejA0+GN4ZKkBDNh4qOazrMDk2OBbac5fMqwKl0n880h61YdiJ/4G3xk2zlCcapdRw5VjQvqkiHNGn4wIWmmFsD8kvjxjw7LyEA7n2BcOy+XKJtdCCEFF1q4xCu2RyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5531.namprd11.prod.outlook.com (2603:10b6:408:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 00:11:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 00:11:08 +0000
Date: Wed, 25 Oct 2023 17:11:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jim Harris <jim.harris@samsung.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2] cxl/region: use region (not root decoder) granularity
 for calculations
Message-ID: <6539ae9a2b37a_780ef294ba@dwillia2-xfh.jf.intel.com.notmuch>
References: <169660931834.684402.2774329392272976121.stgit@bgt-140510-bm03.eng.stellus.in>
 <CGME20231025154855uscas1p2102cef0c09d3cd68e8f2040ca2264f00@uscas1p2.samsung.com>
 <169824893473.1403938.16110924262989774582.stgit@bgt-140510-bm03.eng.stellus.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169824893473.1403938.16110924262989774582.stgit@bgt-140510-bm03.eng.stellus.in>
X-ClientProxiedBy: MW4PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:303:8c::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5531:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a48cc42-5f1a-4f04-bece-08dbd5b80d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZj9AD0aXoltDARqx2Yfno3sQNI8ZionaEZ8GfhFaORm4fcEE5GCTTx9kC5Tc743dMApVJmcEfDYAG4oIQul/OJow3G1Yf2gkgYMYznTowe3i85Hb63pdXFVFzK4EAd6l8eiW75XH+2pRpdXoOC7xde5XOX0aYyRHOYX3LyZ/sqiAarkgNz9y/ekmILSNGtl7qcEAenwdmXXvvcV2784cD3xFgB5hqh+izqCXqug7sqTpQpZFukQnFRfqR9Dl3f87JaKpY+igWF1M5Rilpf4jPoj8Jj9CUtJQsBJRkIpG1g8VgFR76WNjmJC9VUVTnt8SCFurtt5yFpHJ0CNqkdOPcSyjTP8qgLZOD2qlyMrSX90yFFHoUeGaCEbtDrHvbVHYH/o4wrWyUc8LA5FUOYXVrVqE45GdEbUtiggrMuN3X1rYYqR8SoDeu6Mm3UWPzPvQ/3ZyibltJMLFGiJ/tgee7sdPh0ywiYXmomLLjE2F5aSI1zQGQpK359UzWFHvn5VNYvrBmWo8yoNRKBFVWiWthl6UUCPzE2JVjADH2Q6LJRVaAcHShDqqI07ddG/Zoit
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(8936002)(2906002)(8676002)(6486002)(82960400001)(9686003)(5660300002)(41300700001)(6512007)(6506007)(316002)(478600001)(110136005)(26005)(86362001)(66946007)(38100700002)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xInwXFFsfp2kdPTHlDu04A0AalCIhOc6zGBFPgLO7cX95jMTkdELvQEId6hr?=
 =?us-ascii?Q?H8IBDTko2B/o4MGcbmSFpJSHqY5Nm9bi5vefsrk5D8lf4Xtg6eu41aO1UBLh?=
 =?us-ascii?Q?TT6GbPbZJYKZRJhzFT+XsVRIayZLYbhOWtOu/XGaHnT5W4HDS2Vr0UnALBWZ?=
 =?us-ascii?Q?HG7aUHPnuunmaPY4+btQcTAg0ge2lIsZtyunnll99kvAJArivunPDQWYnwQ0?=
 =?us-ascii?Q?NMcwHdrs8ekx8RIMr+w+S2QLMLM8h+F8IpyO4n+Itex8jYdugvP3Q811FaZ3?=
 =?us-ascii?Q?/h1+1Oo4cksKvN5KoH3izyYpvKaqISzbBXj7P3ZaARI+91f/q774udSOMhAc?=
 =?us-ascii?Q?O/QWJUccW25z6MJT3xP4KuLT+bXkikRVtRO9+vG2EPkagEk0FKI0zRMW9Uir?=
 =?us-ascii?Q?E6m2ppwqkUyMMAcSd4vxaf6jt6CMwYbKJQV1qXksOHd5DLkUzXqtuPasyYt8?=
 =?us-ascii?Q?6xe6YrMEd1SvzYu6qjVhlR0ASnjzmz4lRGdv2hsEGW3a7FGeulOiHwzgAa00?=
 =?us-ascii?Q?KbyDSxulWLJjbcZ6enUZHVWMDgvtWHcywLlTgLAJb8uLiCdH0o0S0y1KeLW9?=
 =?us-ascii?Q?Zs3aNUdFCeXIC7sa3yYWnMJmwjkTIRFN2hQgWMWUiosah9hIm1KRlCeQEjk1?=
 =?us-ascii?Q?pyMdH811j1xa3BGF6/jtMvqJHUZ2sxRk5j5fdXHYs5A9+1Rh/oPUHWgYU4Ug?=
 =?us-ascii?Q?lvViLqEKu8g398nnFU2GjIvVpXFfQ5NVFXSDXirGpJVy7UfActI1JJMKJZZa?=
 =?us-ascii?Q?6FBeR6IKv7LOuOV4MtOgC6KVoGjwqN+7GXaMTfZubwUVxHQSXbB1rT56XjM8?=
 =?us-ascii?Q?c4FckzUdnHOxP8WnMAbfpeK8GKPALU/TvkHmsIySsar6/dX7mtgHWylMOLFG?=
 =?us-ascii?Q?pGgEM0AUE2s6jWJJThLiaribBG/tIMDWGjo24EpwYbY9Zrt9O8xHsp4HJ320?=
 =?us-ascii?Q?VRUQf1vMay7pHTAxpEdors9GD3Xx7mbQbvqITyi8/abqVnpFonMuV5EXmK8t?=
 =?us-ascii?Q?Omc0eGF1GQ9MCaIVrVr8IBlj66IOZwgeyhdzX9P2bic2yfUYH0BKIUNIDylw?=
 =?us-ascii?Q?mLHOiX4xH+vpFB2tA4sJv7gaiJLyViW85Nh1h2KA4rQc68kvHNel1h5qpDEV?=
 =?us-ascii?Q?KOmaAE0IaXdj+EUqKi2r4KDsAYKVn9TqQ4SzBPwY/sQWLFbwylw/yD4LuAI9?=
 =?us-ascii?Q?aYjI742CwGQrATpAITSPgbMUShwpcjjbLU40lK8H04KSDdmTUvNPy9vSLP2r?=
 =?us-ascii?Q?ncERJ4LRHTHMOt8S9b4pl6AuUAhZGvYywfiyO+3jbED8/Vw0jCKGGm8PXRyb?=
 =?us-ascii?Q?GSoNRNITjBC0lM2nilvWQdJyMTRk3r1pxGsAogQgio2TqibUNiBypHi/fIfo?=
 =?us-ascii?Q?p7ANBwWtNgEk6fPJa6s4IMPKKZy40QJT4aEkaeYxjrVA8ZcXFiyeDKy3LdNA?=
 =?us-ascii?Q?dn8mZAxYtoUgJu7ah9v3AixCSbs/VXhjIzNJl4eHgYI+KiENmyYoc1/g++OJ?=
 =?us-ascii?Q?DyIZ37FVE7K48XNiso/gdoxekAIcnKNsbsE3L5wAYHQRmBhRvgIBivlux4Bi?=
 =?us-ascii?Q?hrbnanjyW4D40f5vVHgS7RRnGIvZ/IN94uWQG8keBTQKyveHN4dgg+B5JFcT?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a48cc42-5f1a-4f04-bece-08dbd5b80d8e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 00:11:08.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kffeTOqKhOyjVl53fMI45eIz21T4Rb7gBr+R/K1dGkkrnsAj/A9qChaQ0G5u/+LZGpIk84F2abXgJEpR27urSV4sUEbcvYtXAEYBSt1dysc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5531
X-OriginatorOrg: intel.com

Jim Harris wrote:
> Root decoder granularity must match value from CFWMS, which may not
> be the region's granularity for non-interleaved root decoders.
> 
> So when calculating granularities for host bridge decoders, use the
> region's granularity instead of the root decoder's granularity to ensure
> the correct granularities are set for the host bridge decoders and any
> downstream switch decoders.
> 
> Test configuration is 1 host bridge * 2 switches * 2 endpoints per switch.
> 
> Region created with 2048 granularity using following command line:
> 
> cxl create-region -m -d decoder0.0 -w 4 mem0 mem2 mem1 mem3 \
> 		  -g 2048 -s 2048M
> 
> Use "cxl list -PDE | grep granularity" to get a view of the granularity
> set at each level of the topology.
> 
> Before this patch:
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":512,
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":512,
> "interleave_granularity":256,
> 
> After:
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":4096,
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":4096,
> "interleave_granularity":2048,
> 
> Signed-off-by: Jim Harris <jim.harris@samsung.com>

Applied, I did end up changing the subject to:

   "cxl/region: Fix x1 root-decoder granularity calculations"

...and added:

    Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
    Cc: <stable@vger.kernel.org>

Thanks, Jim!
