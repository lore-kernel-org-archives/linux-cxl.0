Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E66210EC
	for <linux-cxl@vger.kernel.org>; Mon,  9 Sep 2024 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923904; cv=fail; b=L/rv5BGAfmnsRmg4p+q+7Kol1hRuOcsslwqW/rGkwPBOOA/rhyD9h98nGNMkb3vc/8YXv0ey6y0V7RzS0OhgLSNsbEmT+f2/5l54pRe3nwSqCVDN9pGC3iMXkkARwlNHl3I95p/RKG6VFGk9Ad3duVAhRW3M4jAFzZ0j0ZGyWJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923904; c=relaxed/simple;
	bh=aTeAYNINbNdSUNwDGirln3RihlNZQvbYJh9pAfeXbDM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D+p8/v+j0gtWup1R3ZsTokQjr20wG9P+OQnFaA+jgd3100XoGG7mLJsa+DY58z6ed3S460in3AxzceFD/SffnRO/l/+BVBb6xtinvBMeYaGS6FCUVORRGVK88aYIyu+Aug8uXKC6JrPukTrbgZ1ZsN5bcNqR4+sQANd5ODiX3mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/J+HmOm; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/J+HmOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725923902; x=1757459902;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aTeAYNINbNdSUNwDGirln3RihlNZQvbYJh9pAfeXbDM=;
  b=j/J+HmOm2v1Qgr8eHmHnDPTijfepTZJBM2H/0p83gt5pGtVM6etx+m62
   spyTNh5s+oP0vay6y4tCZL0ust3pI5J7uPiVYP5RokweCJe3/rAOtEibC
   h0M7jcmgqvut8AIWg1E/MLr+ULkV/7gwD3pn95hrNDd3o6ooTjuOT9ush
   i5MUbPldwapucH4BAOIGkji4lsoPfD5l63T5+NhdxrQ1cb6MpoX7LsFgQ
   9ypk57W1LAcSJLRAc0fL/MyAwz+XLKMQbl6u6ZSkosDFLa2EjmPLjlGy6
   ewLWBgNLOBHic048NtOxPcK30ZR5PcIeMpPEyoeScv8M/GJAqMK4kEjBx
   g==;
X-CSE-ConnectionGUID: x+oFcVwNTpWmOpS2I/VyuQ==
X-CSE-MsgGUID: Fqb84OZXTCinU+/RPma4iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35788083"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="35788083"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 16:18:22 -0700
X-CSE-ConnectionGUID: 9EoK5WX7QrKIAktYnASpPA==
X-CSE-MsgGUID: oA87hF+FR/udz/QFtxgzPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="67117363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 16:18:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 16:18:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 16:18:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 16:18:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woeTrt/IPiEqawBBrjeebLtcAKjriSpBtUuladhXfm4+Nbn8ndoAux6D9lfzAHI6bcHRkOVkf9d4T/ZcB8v73i26236Qdb8X083gTkj54FvsZwa7RkaPmDU2NxxfVfwKyVs65Np1tO8xF7QAexPrgV9bqiDUSAIol+WD4pSL4wQ0KDYhn7iAWDKX6jL6IngHV9tP/kS/D4dlI4peqKlxSWFw7nU/TQL3nsltSuv4sy97LYlSOBd9sXItk8CgQTLy0UoYler3YXRYn+kVQgPp8YfKAnK0HEJMTwQCEEUPsWWETv1czZuQ2HUAF/aZg/0cCbsGayAnOXDrPMZExN+OsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AQsA9CqgEKi734jUUYDoi/WHoOzaK8TRI3flv0uv1Q=;
 b=WE7KwVy/JK/LhZGLpdJgKtuWM+O7rgHCzOYEHWjGhWIQLBMYiaqPQACpw+Q/lh5Sf9R+Uf99BgkOQA2iaWLTD+7qYqaSJlBGXeSkgkL2gJsWWGCAci3T/pRKG400hM57fIWlEoklGPOYEmEmSwjvauyUT78cwEbvqriaVoQpclkGbVN32o1nKkBoz2ieuXnQlCckpoB1/Z6oKB+ykz5AxavybSMtnvc30NTfXINBPQeaCsB5BYvTOQB7LgPhVshniRUvSuBdL6Z5Pv6ci0z1GCdTme2Dex7gZgRBSbI92mo+0GPFxepPF/7d4+SV86EtjcIdK7+IY9LL60luGp+dxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6505.namprd11.prod.outlook.com (2603:10b6:208:38c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 23:18:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 23:18:15 +0000
Date: Mon, 9 Sep 2024 18:18:10 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <alejandro.lucero-palau@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <fan.ni@samsung.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v4 2/3] cxl: Move mailbox related bits to the same context
Message-ID: <66df8232cec82_3c80f229462@iweiny-mobl.notmuch>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
 <20240905223711.1990186-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905223711.1990186-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:303:2b::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: c4930036-7421-4542-0b74-08dcd125ae99
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FR+Hl0IDB89+qAEmdvugMDFj7PFRYaCNWh1Q+Hl6bnX5dpYLhZC1xp/k6Kig?=
 =?us-ascii?Q?k6PAPM2Nl5sziO9ZZkzKF8+male0xN3F5znogrNi2cr8PDu5F/o108n78Nca?=
 =?us-ascii?Q?Y9A2mVftbbXUyBkr9ls9yyOZ4nfpHd2rW7kGmo8Uja6D/837Ur11mmEkTG03?=
 =?us-ascii?Q?PCW0eZvkxixr55t+ENFoOkhyDBHAErnRumUMxWMzD1Ommsw9VcC1zNA4nuAH?=
 =?us-ascii?Q?QP9BLv6JQrShNn07fP4xx+e1S8QXqbi0cohNbhXOi6AO16ioHzO3LIPPUQZG?=
 =?us-ascii?Q?mWOQdaBd/tuHaVlOgJOuvr1rlOvGSrPUyKH+RNvj2FSR0S/Y8CyuIYznIIqB?=
 =?us-ascii?Q?SM3pO4OLBZj6K/KlW0El4tOeTQANhUxbsx4cA45wuSMd7S5YeBL4PBCz8kQR?=
 =?us-ascii?Q?RpNqS4Wqvq6mWbYYLnVQpBlZUTe9ZNc44belTR7gzubvOblCL8odGcNmuXDE?=
 =?us-ascii?Q?d0S6EvOh9mnZZKdlahjPFMAUWr4I0AwtGaNaWtFcnPHVevOlx3Xkt30gnbx+?=
 =?us-ascii?Q?96DMZ3R1QI79uFv1814LihRBvM1VV5RRmSViRkkG1mgu8m9OMNk7zvKrH/ip?=
 =?us-ascii?Q?9lrRS7v7PmY/lkvc2MB7Zz6gpzECG2Ydt9xAjxxU5M1uh5gBPoqrtFqdbQBT?=
 =?us-ascii?Q?RWvcI5PovGNOClvurWN4AKb8PuODL7PtUElVkLtHd8HAgbJ4kQ7xV1WcHrLO?=
 =?us-ascii?Q?Ewzw+tFNTk7WpYbOEt8bip9arfIrpsay+38Hcd8hdlkSwsBe+8rD6o0elfdA?=
 =?us-ascii?Q?AnZWI32BBXDfRTKJYXE2cfZ8iYbBv3AVJVtZI2pg2VwP6uUkBlMqOvRC8e08?=
 =?us-ascii?Q?B+P24YH8+92EgHv6M/Asa/B+zuf6A9lRY8bi/+GpD3gZXWk8RxJkOSs3jGvy?=
 =?us-ascii?Q?c2jnZSK4OisfIK5TzUBtQuI/jphtq7S7PDQZyGs3OlwgtNHTi2K1cvD3FIvg?=
 =?us-ascii?Q?vzzGEiP1XNZzXnexsSdYH9f40uTu+TB90LDqMMDgXxI/ke1Fb/u1yPHtlTw7?=
 =?us-ascii?Q?wBCkMW9jkE07c59hY0MGRiu3Y0YTFr0EyfnbC4tH05wH7HZ10Tkly6Odywzu?=
 =?us-ascii?Q?si81yV8DUt94onXDYDlhRZLz/fpjIqAQeOFMdy+ncKR30STZ7xA/DK2Jh7Ob?=
 =?us-ascii?Q?/5ZpWHWvniuYdPBgXZR/5PdDAGzGLDDuMZ2ohun9U81iwlkTczKsVhtQHkf3?=
 =?us-ascii?Q?PQTsA5DuPbfJtyBq7eou+viERLvLGgVfoZ9J/Fgvf/RS+VMMQDCLvp9nsZBL?=
 =?us-ascii?Q?OzW7qhHIAQwRAvQUOi8rTgSGDSFMrhgO9Q2p1ry8NcI8ynCdgP7tMXhM0Yns?=
 =?us-ascii?Q?8kk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pbJiktBLvmwWRenblVxh/sUZVHmOoJWe13C6jBKRE0ot1NItXxCZ92MJfZEK?=
 =?us-ascii?Q?FIr2ostOoYXgQhgo564z6/XSDv95QU8xOpkufCQ+UEAqWeaUl5Z227MY0vG+?=
 =?us-ascii?Q?IkOUIYnnAwdPeRYzncQSTFX8hgGrq5A/gaB/LosHt1Gl30ATtigyR2Xh/ch1?=
 =?us-ascii?Q?D5ohdbA3Q+PZMKleFM9g9vevWIj5bvXNb5fTDOo2dKXZRNlsnQNaM9hpboLV?=
 =?us-ascii?Q?iJVrfhwVWGpg+LLFRtLLe5Y26f/C9lbjAIWh7/nTJmJ3ajfUxkt5XtkCc5yh?=
 =?us-ascii?Q?YIUem7wUtxPUMoX3FvvAH9EZT2Tqj3xrH215OVcZg7Uc8eQBwS4dNvVpoy21?=
 =?us-ascii?Q?yf17u2KuceBth94ubLXEDJW//ZnPU3SVNXSb+vmDb76EuteLs3J6jJnghMTS?=
 =?us-ascii?Q?8hGl9KT2aVN58GvL7EunGku6IsYZ7oO+lBmkLa+IjR5DZFDCJRbfmZI8oqYU?=
 =?us-ascii?Q?YM9aQ+cspKvwxhV9aZ3nNvCJRLs0D60llBgfrQMjkDCycsgulQyBu3VJoAA/?=
 =?us-ascii?Q?cnmRxuGa5e5ccMMQxKGnjfrQia5rI9aC1npaj9Ng2+Pv3klEbcBjZQJcRFSu?=
 =?us-ascii?Q?NUq0agETySURvtO8RmqCNdgv9lv7rBn+nLXz2vmrOTQQahSKY5ykn0cxO7Gd?=
 =?us-ascii?Q?ixEgU7PD54BTR8vAgTIiuMRXZDG/Noc032A7QLAO5ULAjIi11MDrU7BYmcho?=
 =?us-ascii?Q?pBnd3n2abl5+It+X6MpSQrjVTCRRExEqRPtPom75S7wG3xvyG+YKumHTIZ6A?=
 =?us-ascii?Q?UizVNnbcnRPW3tVgi9HKRF11vu4KDhqjss/jnFni7KvOqazGqhyV4hFFWpH2?=
 =?us-ascii?Q?wfP1ZP+N56DDxY16G3v6mjtGXWatGuTcw/K6rnXE02GI8l0XiMg3BHFOUgNN?=
 =?us-ascii?Q?8TFZgQgzy694uPX1y5aRVvmfJno2frQatC+d2v5YKHRdBFdNiAJdFLYLlj2q?=
 =?us-ascii?Q?UeUvrvClJWA2C7zVEw41eYKIUIQkW/NbcVe3VVgGmRzi+dnT7yJX8F/gVSdS?=
 =?us-ascii?Q?9MYhzO3z0RN2bD8sO+AnyF3vQzftMyv1ykMRPXfWOXH8SzurgacS6CABu3QO?=
 =?us-ascii?Q?xRmiJUR01G8rbHCAAmRSwKHEIaCorgI9XpK3pNxAnHv7bkT+LV5v3iThUVRr?=
 =?us-ascii?Q?qs8JqnHpqGXKPEvgOQ3Ws+U1AdMn9SoY/smAvdS7JEOXH6Bo5mGh6nZkJHsW?=
 =?us-ascii?Q?6vkRCsstG7a+lSBOB3NKNrm2xyFE9nOOMF9UCRs9WW+4UFwyEgybwJD1aS1/?=
 =?us-ascii?Q?U0lBXgmfQig58WXUvA6CCKumBNM/O1p6I6EOFcG+SItefEOJMOU8ZC8DjEFP?=
 =?us-ascii?Q?kt0p5tj6v6V+I/4YSjU52fPFQE+cF8ALBIJaNgzq8d7NXk8EpiOZFHYCf5co?=
 =?us-ascii?Q?bx0InN8DiJIk2rbd9ZztCESqeOR2IQARPiS2IHgV5ftGziDEBWVNFMwyFMxa?=
 =?us-ascii?Q?wPY2Q3ssgWHgCB3MrV+fE377rAPpLivHAD7Z1Lhy0HyUvjOjiRx0t7PW/8wD?=
 =?us-ascii?Q?CocAIbME4fVFCHL/d2YUDrQ9gfW+IvH9mzJSbNiDSVfZtz3Uhqsd5cpRxjpa?=
 =?us-ascii?Q?ouwNsw71cTV6WqIo2V0E4XQorJcOIYGz5OKlnecP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4930036-7421-4542-0b74-08dcd125ae99
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 23:18:15.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19OCMqHhAS6zeQMOZBZzjECfWfI/XcUEuK+hZZ6xGq8afOFm6GcObe0Dd0sFjEnOzHJ4qRL5zoRXGZjrVyKCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6505
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> it. This allows isolation of all CXL mailbox data in order to export
> some of the calls to external kernel callers and avoid exporting of CXL
> driver specific bits such has device states. The allocation of
> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the

						cxl_mailbox_init()?

> mailbox can be created independently.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Link: https://patch.msgid.link/20240724185649.2574627-2-dave.jiang@intel.com
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v4:
> - cxl_mbox could be NULL in cxl_mailbox_init. (Alison)
> - rework after headers moves
> ---
>  drivers/cxl/core/mbox.c      | 57 +++++++++++++++++++--------
>  drivers/cxl/core/memdev.c    | 18 +++++----
>  drivers/cxl/cxlmem.h         | 21 +++++-----
>  drivers/cxl/pci.c            | 76 ++++++++++++++++++++++++------------
>  drivers/cxl/pmem.c           |  4 +-
>  include/cxl/mailbox.h        | 28 +++++++++++++
>  tools/testing/cxl/test/mem.c | 44 +++++++++++++++------
>  7 files changed, 176 insertions(+), 72 deletions(-)
>  create mode 100644 include/cxl/mailbox.h
> 

[snip]

>  
> +int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
> +{
> +	if (!cxl_mbox || !host)
> +		return -EINVAL;
> +
> +	cxl_mbox->host = host;
> +	mutex_init(&cxl_mbox->mbox_mutex);
> +	rcuwait_init(&cxl_mbox->mbox_wait);

I would have expected a few more things in here from
cxl_pci_setup_mailbox().  For example is irq setup needed?  Perhaps
deferred for now?

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, CXL);
> +
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  {
>  	struct cxl_memdev_state *mds;
> @@ -1418,7 +1444,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	mutex_init(&mds->mbox_mutex);
>  	mutex_init(&mds->event.log_lock);
>  	mds->cxlds.dev = dev;
>  	mds->cxlds.reg_map.host = dev;

[snip]

>  
> +static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +
> +	/*
> +	 * Fail the init if there's no mailbox. For a type3 this is out of spec.
> +	 */
> +	if (!cxlds->reg_map.device_map.mbox.valid)
> +		return -ENODEV;

This seems like new functionality.  I don't think it is wrong but it was
not checked before right?  If I missed the check are we not checking 2x?

> +
> +	rc = cxl_mailbox_init(&cxlds->cxl_mbox, cxlds->dev);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -846,6 +868,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	rc = cxl_pci_type3_init_mailbox(cxlds);
> +	if (rc)
> +		return rc;
> +

I feel like this should be just before cxl_pci_setup_mailbox() after alloc
irq.  Because we are removing some of the setup from
cxl_pci_setup_mailbox() and putting it into cxl_pci_type3_init_mailbox()
it just flows better in my mind.  I don't think there is a requirement to
put it there though.

Ira

[snip]
