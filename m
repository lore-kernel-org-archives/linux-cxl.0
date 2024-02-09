Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDEB56B62
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707456310; cv=fail; b=WeBHBMfsEP7IW494zCzvKi06Fzr7eoYeIWXOs8FN8wJ7GZtkCJK2RDfKtY3xG/DEoBjlYlMa8M58bh8pNKEeJ6uIeJA16VU+s1zWLHw8keJaoIHADPJ0syEUO2jKycQPCtlYpPkdU7hWN/UePbhVQGblcnwnaVvrNS7b+KqgK6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707456310; c=relaxed/simple;
	bh=v02TcvFRPr6H9sIWQeelQCfxGu6zrhu7Q+oPVAleo0Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DYFZaBr0A4Ju2gb4BU2eIIq51u3DchvNVlHL9ZfTcvijJigyRh/3qwPnT8W/9eMT41gppkOtKAe0MTpQ+oiDWLIl80VKC1KViKEeDQ/dSFzDUEds8HvNoJImmhQSyqiw0M678XQhZXZfXSClVlSKHA4N93bo0Ba5A465I70ZdxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npLkPxy5; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npLkPxy5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707456308; x=1738992308;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v02TcvFRPr6H9sIWQeelQCfxGu6zrhu7Q+oPVAleo0Y=;
  b=npLkPxy507b4dViXiOoLjs+kRdUj9nGq7gnJACNL0hj7ifZmWfaQOmth
   7bWCmj9yY14c/Up29cy79OkK/FG6cw+/h1kia39nfAj0kWz/2YJVwQdpO
   4XQGnV3E7pzDhXr/QEHECnVrcCyRmelmXMldal0FDfjWu1U7TOX6mZpc7
   fPMiagyzX7XWkYtKlMgmbIYHOyeWihuEgAreDBp2z0CoV/CKk/q5bLU5h
   g1wWxHwqYJaQnLIStIZT/yUsZ3W7TnIw3koJypMGq3Ok9o1o/JhR9jneD
   /JJnw89bYZy6/1vZ1WBX3ZdY/+r+WXxQZzOtnj92VyTKoLcW69IW2Ga3u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="395799250"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="395799250"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 21:25:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1857612"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 21:25:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 21:25:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 21:25:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 21:25:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 21:25:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+qK2fWXJ3hnY+a8E7fkPAzj8ZLHfuAVMN9sUexQiQruWiteSH7qyR7yI+sDXCBc4fP2OkLmga/MABDpBiPIfULY2gc9UkDxw7ERBCrzRIAx//SpRK+8TU4GU2IjZWwMpLidXQWVS+Fgsd9KMs5xL6Vwx/mQyuJhr6ZxnDQPwFTUnJcaa+2020IWB/aGcpGJOMsoLZiLi9tc3Lszi8Ynj5LQp4bFnZejcb+Z8eXEwz4V1Q8TriZ2bd6E1E2aocjo+/O3SrBbacySpabtck+ekkuYgNGYaVR/bgv9Dx+tjB7hB5QMBtdCnCahE0Hh/veEJxRfgwSRAfNnWL/iSnMMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD4nlehli7yNsICmF6erTuY4gajuLUlUKT1aW+GqQAg=;
 b=XydZDnwOEaqgwmbrGErbsNgM4yo9DbMYDBy03v0KiVZV3zTsK4OPKOYnT73YfjrBzN2urkgEwwmoAJu8yj7IYXT5lh7gi9SKvHY/wLIYgncMvaZe/uh8sY+Ccd38Jqh/iwyuVgsOiG6ZfZQn8bUOk3ezsorPYmzMDV2nv1SlNKTK5/VIWi5h1yO+5+96p53wR/ojEM1fmPagA1njWo94AgF/kn02UcMKsPm7giPYWU7J+r+3q8GAs2mtu4Z0HfASgCyhopXqyM9KUMCFLIgOJy0L+7piqhzOKqexSDCp+A54Ju69hklrol96WHH10Amcn6Jxb8l2/gCO6Mn9ZPfs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7887.namprd11.prod.outlook.com (2603:10b6:8:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 05:25:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 05:25:04 +0000
Date: Thu, 8 Feb 2024 21:25:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, Wonjae Lee <wj28.lee@samsung.com>
Subject: Re: [RFC PATCH] cxl/region: Allow out of order assembly of
 autodiscovered regions
Message-ID: <65c5b72d902a0_5a7f2945c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240113050421.1622533-1-alison.schofield@intel.com>
 <65a980249f50f_3b8e294a3@dwillia2-xfh.jf.intel.com.notmuch>
 <ZcU+9BxBD8IRsnTu@aschofie-mobl2>
 <65c55c67ec60f_afa4294cc@dwillia2-xfh.jf.intel.com.notmuch>
 <ZcVwmvubGa/3CweX@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZcVwmvubGa/3CweX@aschofie-mobl2>
X-ClientProxiedBy: MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c31705-f2c3-407a-f1a4-08dc292f788d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGn6CTS/JGQw3HCHiSGK0gXGKa76JsBuTdeYHp6P75zOwr5AxY3vBxe+hXikMHzRE8db+sCkT69uFllRiLuzRzUq61vx7DuR9WEQfmjh6Z7aqY8owM/NXP1RzXGsAWUy4aK6kkyRxQPD5FC9SWP7sMoPu9JgXhmVKV6iAUM7CRs1qAckXQI48+ZwuDkYIzzN8UnFABsh37+IdjyK721v6/erCZZp75do6sQLY/3p7OcuM7KQHjEPSqUg9U4I2gXGUtU7Mf76o1D+LN4sap5mS3B0vFMldFIHqQWlSyviha+AI2StGxi+yynBPvERfCKFLKCtABZGYRTJyt34zINLQDnhGz6VQv2aWZ14HY5oMZPhizGmWRCc/TixsZ0xIWxn0FykrQrGybvf/gVyJ0AcEETbyCTsZxkOfkHyy+7zy1PzjuJXJrOJfNsS9WLuPfwSznl27CtHX4XQhrLqMYT0irTkttPAbu126/qehPXlaLcDjm75VeJfEbIa14gjDvnfocERi8de7wdT1g8vI6HoLS++MT8Djk4kqrvzTpRz3qBeerpuubwVPYxiw/d/511Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(5660300002)(41300700001)(82960400001)(83380400001)(38100700002)(26005)(86362001)(6666004)(54906003)(9686003)(6512007)(66476007)(66946007)(110136005)(6486002)(66556008)(478600001)(8676002)(6506007)(4326008)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?brsWqF/y8pBz4jFLl3/uutll6IEN5lRif7Up/nuU5rogVaXAq0LfPHFQ0TS4?=
 =?us-ascii?Q?hqLYvcNY2fLLvg10KMfwdlBUsKeOtLyO04l2ve/DTP+lFY6sM5+NI6d1UkIc?=
 =?us-ascii?Q?cbYMc7JRuDn61R2kVyQIfgYZf4HxDPRFUnsWnq6WujWlU9tCdB66KXjv+ENi?=
 =?us-ascii?Q?2ML77FnJiqeDTlVEuCMRPmm6MFoerRnzW1weX273V46H7EUI6nDY+880+pnu?=
 =?us-ascii?Q?6HDFj/FrMStqCt5OvdgZhYc/9yjYP48aRLXofXuPmsQQn5i3uZXGhRunyviV?=
 =?us-ascii?Q?u/mwkIJFzCJkqARKSkgHFUQ3oy9jcMfwwFoTJjyM9BMrfpiF/gDb9iyYeJCd?=
 =?us-ascii?Q?xHeC8aA81qRzme5Ygqz6RBgVl/86+9eXkpBIgRQ/RhBGcYa8ou79fCHWpFWM?=
 =?us-ascii?Q?VX/OvXBvGISKIjLIsGhdaIPywgiVwWJLmR68Cbpxfzv0NQWOz8HdJB0st2ii?=
 =?us-ascii?Q?hwfA4PdY/o8I/U0oIrQKHIv6EF/qb9kMzOEA2PhH5iv9ffxQhKkCjCLJoxJf?=
 =?us-ascii?Q?qAILFO3/xspb1cpCADXhgj6bcc7hMqsN8UZaeIJVhssAFwPdUnw+j6GInTtP?=
 =?us-ascii?Q?sTUsm5LiNokOB+J5R7z6h7nypp0kmqMOa27Sme3CsTTWONNrJBSZjvPQJC/l?=
 =?us-ascii?Q?q87/8y53NzLFzg7pqUApYqmEiDKp+zAau7XqByQkC+ia/GiuLX3W3kjYAqCF?=
 =?us-ascii?Q?M0xIcjHUwAam3HREzhjG5Qudx8iG+woHnL74LLf209z29PdRWbiyWooOEClQ?=
 =?us-ascii?Q?eqafrhWuxQYBzB1J2S+fopdKJYDG4VUBM/okCYlS/Wn12BR1T8B6CqnbfQe6?=
 =?us-ascii?Q?uXqba/cY/OKNTHgLwbZ13C8FIJDlU/lT95KrPnYH+1qQ+dQF0h+jDLivA9od?=
 =?us-ascii?Q?ZPEfnJsyoXKaWIg2IH8g/bO6NSupFPIRbzEXN8n1NGisn2MLDn7ZORd2AExS?=
 =?us-ascii?Q?BjYYSp5V+ixuWLIFRRsqQnzvY0XUEwwthb9uzOyuLgpxYWNlPM11YCGUjDVf?=
 =?us-ascii?Q?3A+RQe26/TnB93Wjx/dG0WY+tVIoH3FvJCEiAs9t2Xh2hiRBmZUAdI7K1MCQ?=
 =?us-ascii?Q?Tm6/STuKHJJ75CcM13E0/5auyofZnLIUPYPhcNUlfhW0Zmg1hFytocB59ZQT?=
 =?us-ascii?Q?cC+IJwJP2cyPjURY/UFDx4jAHZnQJ1TWA5LN8tdhA1MthLl3U7B07OqLkj3m?=
 =?us-ascii?Q?Ab/eoSxhQ4EGkDoRK8K1SMg1pF0hN704Z8vWuLZ5va6q2/UPaMakEo7stX0R?=
 =?us-ascii?Q?r14lQQNdc/ustKdWPellO44mAE/fg2Bq1Aoaur13PfIWoAOJqWMqbuok3WBo?=
 =?us-ascii?Q?Jj+CfKsLQqqTZcZ2iIgZPAh6DERsp35rDy4t2y4M+ymqq9sHQojLCm/tUW+V?=
 =?us-ascii?Q?2HJ38dHnUVd7Q73oH1K6M70NIDnUKGhM7DcAMvhr/+ulephN49BnBjTCWen+?=
 =?us-ascii?Q?cSWjFNnHeQAG7H8vB0zLxVbP8RvjQkt2l4SwD3XhVU/I8nIO1NEwNq1/dvil?=
 =?us-ascii?Q?KpETrQl7rymm5/q4tvFawPc38PMuhppeVjTIMiqRoPC84jSS688mXh6HrWmM?=
 =?us-ascii?Q?YvhdDAB18sXHKt58ndJ0RNhImsqhNtTnV0TnVR/7cX/ID372SoHhkBSz7hVe?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c31705-f2c3-407a-f1a4-08dc292f788d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 05:25:04.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PX4PEf52pUu1vcojRM8RpcrCAlkCjoHGBJ/D12qxk/OKUtblhq478A7Xh9Ukdmlfj1RR7wI0X6DDPnW/Ki5Ux08PbmpFjbLDKTgp59C4ABg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7887
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> > I can see it being an alternate way, but not sure how to weigh one
> > approach vs the other. Is the dynamic update getting in the way of a
> > test case you are thinking about? Otherwise it seemed easy to reason
> > that the registry is always on, but only takes effect when
> > registry_reset_disable is set, and cxl_acpi rebinds the test device.
> 
> The constant work of updating the registry caught my attention, but
> no impact that I know of. The dynamic approach is more intrusive and
> impacts the normal path needlessly. A snapshot approach limits much
> of the impact to users of the new feature.
> 

It does mean more infrastructure to walk the entire topology and save
off all of the decoders. However, this is straightforward because
decoders are devices on the CXL bus.

I am not worried about the intrusiveness as much as how easy it is to
conceptualize new tests. I do think it is easier to conceptualize that
the flow is

"get the decoders the way you want them, snapshot them, ..., rebind",

...rather than the current:

"get the decoders the way you want them, disable-reset, rebind"

Notice the "..." in the first flow where it is a bit more forgiving if
you do some decoder operations between the snapshot step and the rebind
step. Where the latter flow requires that you know the side effects of
how rebind tries to reset the decoder state.

It still ends up with the all same complexity on the read side, but
should be easier to craft new static configurations without needing to
worry about the write side of the registry.
