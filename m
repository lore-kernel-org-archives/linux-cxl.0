Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4klck8y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F21F0
	for <linux-cxl@vger.kernel.org>; Mon,  4 Dec 2023 17:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701740806; x=1733276806;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1cLCx1km7KvHZf3eJIFULaSkyeF/hbQN8c7FnMyWhvc=;
  b=R4klck8yu+YBLwPs4n2iOr5Eeq0ztoURo+oVklPo0epD51ezb0u5wc3v
   Q5LSd2V+rNz6d2eHnvhWUHCRRdCx+zkNK9uNcznuoVMS6tpBHTa8G8gQi
   iXOPyL1wnb6ioBwNsxcWxeAhR2pKJi9oNi1gTE8wLIu3/An/i7Pc2/4mN
   iVPGiTAotp2RTlE5USDtwAbZWUWRctJaxABCAyCl59kgBA5DaaGtcBGNv
   RxfbBkvulAx8CmGdjvydFf7+tdE6TqeDggFX4TpnjMAI9DS/uxLOxCJHr
   O/bdVXx2Mg05NAoBj77i71JtxgfvFjRfyqNTqOmgCO8IXjD7QKGa7B7np
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="15374901"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="15374901"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:46:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861586371"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="861586371"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 17:46:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 17:46:36 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 17:46:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 17:46:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 17:46:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVT/wHnsoGOrqJ/Z6pDr8QSsgHsyFLKiKfG9G5VT/9SpKMhe5LQaiEb+K3VBSl3LN4issIWqchZOYptLotrFZK+AykdSOilAnRYPXReJHv8LmNoO7g3UfGg/vAOfd/KDR+hyQ8H2fzaUaLextKJIccBJV6re8rQk5vHaUGFHn6UvIq0+0Sv8EYorgFyAf8R8rymRagyFbVnMOa+S2iQh2WAcF9yPUDxItml3eDA0g0k266TIurFlkCd7Sws12Nsjds7f5FXn1CNnGRxJUSuuzZGeqYD9IYTNoncipFFJyfv4ye0bdl2jqypoYC87Q/kKsY1tAUDmHqFvvTAgalDBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FPyBO32E79mKz/dTa0QovDoZRe6Gr96mZ4VFYpnzgk=;
 b=WMkpjqJ/fkqbPKFbeOwWXc0btc/bnQODbEf+/drNMexYE7MGpomuQqhKsJw+uzRY1TpxLgT1phrO79CxlFz2EeiBEe4ripBYJtqV+XtjfjBRoVh3C/jN1r76fsfC0jLGmsbkkgf4pTt3X1xdchscYC+NZzKoJDJBZPz+Znf8ht1NH1qFpfPrhai2tJtQULQ9ekkd3UG61khaZDA7g2oZW8SL8RL3pYnlYNK0kNLvw4pBc1oj+Q0iTXIDZQf606Fu3DsQhN5Obx/35MN0V+MQNCkHjbSA8Mh0OVQpTz+/9yNo/JvjFRAfTYGZKrPjugQHFGC/O2pbKvNgF5kYJ5UxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5124.namprd11.prod.outlook.com (2603:10b6:303:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 01:46:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 01:46:33 +0000
Date: Mon, 4 Dec 2023 17:46:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2] cxl/region: Add dev_dbg() detail on failure to
 allocate HPA space
Message-ID: <656e80f2bb9f7_45e0129484@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231129003953.1252985-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231129003953.1252985-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:303:6b::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 2174029d-5998-446a-cbbe-08dbf5340243
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSNeWi5Y1vHvGhzLap6Qk2ge0B+ziFhm/olIoGnG6hzAKBJy+8KEuLjXgwOP4WxJuhXZY4bSanhOw9e1TtCsI9kJxUn56tV6EWj9VFAf2fv+QwxSuG7x/Yba0qDAdJRPOnbECRbdE5Whf35cYZFUfAyibnesPUjW6O5Bb1m8E7smGQznAfgSL/LuoxWt5pRkgnUzoN528ULKsl6sDmwJomyeRpD168zYGCypXd8V32IrzEPKBvuzgaB285rOZQUtxZmQSP3TvnDn7h+sYaWmfAHtHIRxIhXSt4YpbrFlG7sNXOEsHusF4CSI0kDUgQUTWF+BL+n+HD8O1n9IJu53e5UswC0grMaykyuXsQv+CX1Zq9J/2hKPIdgXcXaJPLFz6pEaY8HH0kkoqY9vL7bcsaZmb+2ufyjTMBiZ4mafZI3umWLqGwaAmp5sJAma3qCyompCDcAiLQS5irIdsfpzK4YwcjeOfl0aPEpboo4vJXdZmF86CuzHl298wo/iF9XGIonAmL+uWxwLN51SwqqIzT1fOs16KHvXHp1HuoBHq3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(110136005)(66946007)(66476007)(316002)(478600001)(6486002)(966005)(6666004)(38100700002)(5660300002)(41300700001)(2906002)(86362001)(4326008)(8936002)(8676002)(83380400001)(26005)(82960400001)(9686003)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKBU3VBAAhuTOVNe7RR6HUA6eOHlCZZVZxRCzgWsGOn1LW1cpoyAmZM6LmA8?=
 =?us-ascii?Q?2mMp8wg0EDeGlyyXhV3V3mgEU3EBRiF3ImhwfZRyOZvaIuMtARM4k8f5znPV?=
 =?us-ascii?Q?apqe3FcfncxzTswhd5ItSK3jzv1Py5TOUpyWuhC8WJ2flAR2Jy3NLE5k1FX/?=
 =?us-ascii?Q?1iBkzOOAcQiM8ENzztM8yl31TGJNVVo8ekQZ9YxH4h3RtK8qNbAUKEJzBvYE?=
 =?us-ascii?Q?HcNL2L8raY1wm2vxK+jdcM4cPGKygmaNVhB3gXXR7QMl0mbY4V/B2Hs861Yk?=
 =?us-ascii?Q?tAC7GjG5SFmIO31amNWIbjHpz+JQW702A6ET2pXqoKNlsNNg0L6siyvFFE+j?=
 =?us-ascii?Q?lu7A8O8iYq8dCGhSYABRKbc8aUirWZG39f6rYGzMzCeFj6ifT3ugX0IA2x8B?=
 =?us-ascii?Q?2Bgq0Rc7bIrJ8arkjplwr8XGfmJRFE5QLD22ubZpYQJLxcXLFd2J7Jy86Xut?=
 =?us-ascii?Q?cPQ7glEubz4DoTuqB6z2gVkySQDiUt33kbWN+j4l0d1yTqDehNjLFfdofR/e?=
 =?us-ascii?Q?kWB2tdD0grKGJXpb9CeuyvhLo1eUY+YwV9s3wvUMbx5fbgJjxbdw6Hjc8UO+?=
 =?us-ascii?Q?Wle6hj4JX8l2kxUx3vs1HhtStmOQai+qn5g5Ahe4Cqda2+nguSm2TCkesztQ?=
 =?us-ascii?Q?tzcT0VCJO2wB9BkhKxk1Rd8r7R/DEeYpVxT+IRq4BtRk9LHOsJt1kCEaAiDk?=
 =?us-ascii?Q?O8eOGkOZplUqCbULI4HjYOCy7L7+u5fPkL5UCNAhr1HG4hMP1EhdWdv0oQwq?=
 =?us-ascii?Q?0CptKCeHrNS1IM+8RX+b+ZCmhoUr0hzbxESd9AnHTcDX6csAPOXSBWJxcQ8+?=
 =?us-ascii?Q?lBMYy99loI1xv1uzRMet+OghaAR7drrZinlT+53Mizo2u2VhC8/JlsC+peUK?=
 =?us-ascii?Q?KqHn14sJXlaVXagMHol8uiUMWkWVIWhIWBTpcEyc2LDYMZewfKLR8kp1QBWa?=
 =?us-ascii?Q?OocwUvovvqKRmaNXtCWKC6D33jIAa7rRBtXHxruM+wJIzDklaWlfvM8/UNVS?=
 =?us-ascii?Q?gAbcseqklRuT4sFrWkEmwDZ1c11Vh2OVy6uBsI36Rj7KVzCZKSjJU/mxJGw2?=
 =?us-ascii?Q?JlCK3/9HqX2O2lYBexAQaEZfpW4Nz4NwO1a+jYl0bzD8IbJffWkvdOVj2yqU?=
 =?us-ascii?Q?mMtA72es3Bl0pzUKQvxVmONfPvTT6KPmlNVt7XZcvyW0EO7LkBLgdCXtVBVI?=
 =?us-ascii?Q?Ce0myeh97haZlruK59BI/yU3STv5TrkV/suKnU78vlGKpH2WfPY8DZqzF+BU?=
 =?us-ascii?Q?HxutlsDQqXFMEmX4CA+KNJBh8KoknSwkhlTbYuL/m4RM6n9dAsjDFwQmc/dP?=
 =?us-ascii?Q?PrSwOkyAaKy4a+2RRciqOiLV2zSSR3SOCmgV9Co4+Tk7lLCHTLho2sTBgk8p?=
 =?us-ascii?Q?lgHJEC7y0vKK85gFXxesbiOgQUq6suKYd4xiCe+gEdlr5JZTzL0R9cJZrUKQ?=
 =?us-ascii?Q?944dilnuNnOhg9ASFDA0P3QVrqq3RZ/7uDPmCkBNQqVW9ujns+6aNHofCSMs?=
 =?us-ascii?Q?J1Bc40h/20rtLID3jEcCn/Ed0PfI4hWsKU1cKraAc+v3Qs2kEG1bE9GCWnV4?=
 =?us-ascii?Q?3FVla+Mdf/njJBqbiXsjUuc+u+16p3fCSdbeK4Pf0Rec+DR80A4rE9QWHR+n?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2174029d-5998-446a-cbbe-08dbf5340243
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 01:46:33.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC1v/bDBDzxLTEL9T/wF4vUtJdeWN2UTvo+/DaTm5LuIaTwiKcCLZCFrs5S/0Zd9TIY/SBnVmbg6lR1BCwEfl9T0QQTx8FI/8AxK/Q1HhUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5124
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the region driver fails while allocating HPA space for a
> new region it can be because the parent resource, the CXL Window,
> has no more available space.
> 
> In that case, the debug user sees this message:
> cxl_core:alloc_hpa:555: cxl region2: failed to allocate HPA: -34
> 
> Expand the message like this:
> cxl_core:alloc_hpa:555: cxl region8: HPA allocation error:-34 for size:0x20000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]
> 
> Now the debug user can examine /proc/iomem and consider actions
> like removing other allocations in that space or reducing the
> size of their region request.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
> 
> Changes in v2:
> - Improve the message text (Vishal)
> - Add reviewed by tags (DaveJ, Vishal)
> - Link to v1:
> https://lore.kernel.org/linux-cxl/20231114040147.1124696-1-alison.schofield@intel.com/
> 
> 
>  drivers/cxl/core/region.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 56e575c79bb4..ec792af873c4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -552,8 +552,9 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  	res = alloc_free_mem_region(cxlrd->res, size, SZ_256M,
>  				    dev_name(&cxlr->dev));
>  	if (IS_ERR(res)) {
> -		dev_dbg(&cxlr->dev, "failed to allocate HPA: %ld\n",
> -			PTR_ERR(res));
> +		dev_dbg(&cxlr->dev,
> +			"HPA allocation error:%ld for size:%#llx in %s %pr\n",
> +			PTR_ERR(res), size, cxlrd->res->name, cxlrd->res);

I notice that this did not pick up Vishal's suggested "error (%d) ..."
style for conveying the error code.

   "HPA allocation error (%d) for size: %llx in %s ..."

I prefer that style as well.
