Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057F55E52
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ER08n7wC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704747925; x=1736283925;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WdgfQz0OspjRPtMSLUZG8XuWaC9kMeRyjkId7EeAutk=;
  b=ER08n7wCNGpwj5fWK92VKv+D7w9Q524BW6FAk1MSbhDuJb7DnuFsOnwJ
   LqUpff4+Mux4xnqBsv5Ua99ZYJaJK1P0LPiJYVk631wvoEkM1lmnIIDzW
   Kdrb5H0nD9B6VXKtk/vsj+6eRLHjkQA1My596ccIWa1G7dF/IhFKeMNDT
   DxddPW+jUKz21ejbFbHmBCsRDntQ29DMPaGS9+ZI7q1uvfmO6mmifQ5kt
   4LOivI7RWCMDQD1bXH0hvattjUag3OQlWeoHN+ETrg5R1Xehv+rr80UZX
   rtKBvvwlayFTaLcNkBWH+jMI+Nyf1ptXwTz9AkeIdhQ7xgbJYjf0svz9j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="16600082"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="16600082"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 13:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="16038498"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 13:05:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 13:05:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 13:05:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 13:05:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPNiFLBsEuTcFArB4kTsJEzTp2AivIivLJm3nfta+YlQj63b9VGshYBF3UArIfCDUSl4GmBYfDaKILv+7YwLq3XeVMxEwlgf4tikGFHfNqlTYdnX/K83zPGCRvZdVqn+GwarVcPApFZLSAAmxRT8ocw2tHuMMsOuxGvR5La6X8a3MC4CxfevjcJayxQeZuyLwh9YwyTypNd/XOCtDzKDyaqJXJg1MRUIfkUyxzPno08uRbqSgxlt5nQo4P6h/FlZnk8SuLo9sby+477/QLxCZJaBDtqC5uK1RWXl6wwUACv7IdGEH2xa1qsBmzanjqIbHpOBh6a8P3e+nNt09e9uIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYJmlgX/8fFK8GYIwl0OimzaLr2/lSuOLyXy/Gshmjw=;
 b=IKAPEByrwfdZu9apImFKwfPtGIaADrG9F4QE/Q3s7ftFwOSCdmw6d75LqHVvNkzBPL36kXgvMyttztHBZ0Dr1jJRMh74vKXZeLf5owDbi0xCaUEdkWHpI/emEVnTLuqQrmjTJf/Y+Kouq4LYmvLkHt+1llqwjKSr/qxpmfa9YPtiyYPv2PRd4l8paLff9cxiSUxAfg1IxOwrt0/dMd/a4ArPmSpYiegYdgQYgBKyrI6zcLn1oyxqHUjx9kjDoApbKaeweI+pjvHn1HtQCHJ5jprsCUfgavouGyCbBaP0eVmclajNPxw7ZSCpxXkS7f6vNV5yWuNGzHrsFLF5qAV08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6720.namprd11.prod.outlook.com (2603:10b6:a03:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Mon, 8 Jan
 2024 21:05:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 21:05:14 +0000
Date: Mon, 8 Jan 2024 13:05:11 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v6 0/5] cxl: find_cxl_root() related cleanups
Message-ID: <659c6387945ba_127da229429@dwillia2-xfh.jf.intel.com.notmuch>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <65988422aafa8_127da2294dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20240108115326.00006844@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108115326.00006844@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:303:87::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: a569c4f7-bc99-4fe7-052e-08dc108d820c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cGFIbyqZVVPAmTUjYXaBPZolziWtydKZ7oDUjna6OUunOWbN5xPiPgdRCeRBgOsL7IgyMo4bJmgFGr/Njvpj5yrwnajlOsZSUtPKLdndGvYwQ9bqHYqiy2gO7SDqAVE0gPzkepyap1URWF2A8Xv/RCh4xYXT7qRfdsLe6grpdgAsdXJuXK9v+jeyjyhI5AdY5y4ZKXL8Zg50b7UscbPRvkR4JFHvvk/POUZ8frm5Z8gDzgZPLRB+sZLdQXZmGVqYt2YhXCTqRPylA51qjFToPqUsEATKPNXP0N/+BzrOFzFamurnxgOlGB10mXCw0d5D246L9q8xTbhVx2CoafN5+RC0TQ+utZY9YySHctpKmCGmvPWBsd+4cRFbH0H12HLYme1M+SDgzu7rfZr3CwhHRlrIyz0ROj+X2RNJDurYVc/tvHkwhon0iRTccJZnHvt91c6Tl7CPKzeBfarVrVCUQJY88Qoo7Y22i51Lx4zQFDepnXeRButu0UYg6yVR600zaSDLwA28Nw23VoISWhyWbEZ9Udxsa+wjXg/NN/n/Luic4RaEEGDj4S32FSdm5bC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(38100700002)(4744005)(86362001)(83380400001)(5660300002)(6666004)(6506007)(6486002)(478600001)(9686003)(6512007)(66476007)(66556008)(54906003)(110136005)(66946007)(2906002)(41300700001)(8676002)(4326008)(8936002)(316002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5idrDAv86daQdMLPnxBy5hh/XaYYx1zQ5TnS4Y3Wl6n4EF8i9wWYQh6AIOMj?=
 =?us-ascii?Q?+6VZ3oPnafGs9txtibRrJUcMpgXXST8YEYCr+44SCc1YYjiuJhuzooqZwGWE?=
 =?us-ascii?Q?2X/FxcNTuJtpsqPWaXXJzTFxYHkcthiTharRM5kXzIO2AGUqdyV5MQMpkbkw?=
 =?us-ascii?Q?2H6LA9UCcUUBCIhjKQooZJXVIvkpa+0buoDUZqZNgGLFQFgAeY85F+HLAZ4c?=
 =?us-ascii?Q?ZGEFOojLMWsDmR5kaSymP3fff+lflXQYNjhAtXDBDO4per6Y0UFbokQC36lA?=
 =?us-ascii?Q?4cpDh6QGpHYPWDYiI6NGdai3rHYgxo/B6N8IJBfnvO3TIT27h5mPRwHrfY0R?=
 =?us-ascii?Q?wS33qnUYbaEbzoT0eHUR8gQEKHskqNXqYDQwPBD3g2QhIdxbSbjqgAhgp+LC?=
 =?us-ascii?Q?FWMN25KcA6Rsyc775lvV10FwFyinB/pqB6tuNPDYNxY76+G38Q187r70Qbys?=
 =?us-ascii?Q?OsfXdVr7RO/3YTmm2A4tFFHk3L8aMYN3oAx4lQdP59CY78ZfkFFoBA+4NJWI?=
 =?us-ascii?Q?TSbM1b4u/X8B7UW+CUwXczjUThzQTSIBJd+I1siqYO99H0jLeecMBJp3eYyu?=
 =?us-ascii?Q?+YlGPaIlUj7K3DexNi+BRoEld59PorGuWUz7tWAkvghbpiLH8oFaB81sETz+?=
 =?us-ascii?Q?nDx0P23lbwfyx68uTiEz/2hs4hg6IMl1/lwJwxOVAhLD2/J+tjx1ScGvtj0u?=
 =?us-ascii?Q?1h1mEQfMif0k7y2Zmv4ybF9byieNNRqLNzvDvYSwoD9icVgK5/2oogr1raSf?=
 =?us-ascii?Q?GFhF7Xc05f2UmSN4r6kF4ZMAnkdhbrwSTu1XmVJAhLXEGqHSgA+YVuMTOZsy?=
 =?us-ascii?Q?S2KxW3SmiHKufu28ksMQR0ngdptmdqX8ml5RpNa+TIMc/bQZcY15Y4j2b2QY?=
 =?us-ascii?Q?0vDqGagWLOVuSfZZAfTroDovPCl+UtazqlHg/H6E3JjcdvJDz0iC5M4O43Di?=
 =?us-ascii?Q?GfKeekeRmxll0RIq2MmBV1OcnTTFkb+vsM/wjbnsqydsPumFfGnHNXnxR7Zh?=
 =?us-ascii?Q?mceK9dM5YMXjtTnXqv1QKcM5+aMbcxHlhyBP8kin+TvgMWsUD9g6lscA6xu3?=
 =?us-ascii?Q?4Fcehwx3h3KeitNg2kkMQqVUevDOzaPzwn5+TCKxM9v3TBvIDWGyNueeReBm?=
 =?us-ascii?Q?CVpp6xJhwYLCqNKvJXnzt4il+I1Wkm0DXaNE/PPcb4QVIvEXAza0ukkLwsZN?=
 =?us-ascii?Q?qDT3NJE4VkYarLbc4THhIEGdrZyfEYVnscKP0dnjJISNJP0oluk/QqyeWCsm?=
 =?us-ascii?Q?wWM267Blrr2/85Tk8bwH6ivtQllvAnL5oKd0GI2Pp39fI4nxr1BDpxkwD1ET?=
 =?us-ascii?Q?+Uj8YOimTF/lQp02o0q6AeYFIhCfrK5uM7S701XATfe+1LjLQ+cnGVFOxEI0?=
 =?us-ascii?Q?xxZ4WJx0I0FIGaqd+EkEFIPuuvgNkKdCZgb+v137t5irU0d6XMjTHBsnpYgK?=
 =?us-ascii?Q?T1e7XNCnd+6CUoV2yJwa04D9PuUqPGxwZYmwFf2caAjBpDFDi/LIJAEuqS83?=
 =?us-ascii?Q?sTeUD4HAhcfrzV5kbPpFsuQy/JDG+MfTVRFW25/cnH1dwLEvJ/a3B9Wy0ECK?=
 =?us-ascii?Q?QWYI8OSKU28p4Fh8P6WxA1wEnIyzaSJtc0RLM9s14BP52NILqbJe0+2GA5hZ?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a569c4f7-bc99-4fe7-052e-08dc108d820c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 21:05:13.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwfvaQ6QF8AxCs/yoK9Lvc3zri7qqpw8/0qSckktEda3986TsXEmuD5Gi4MjLY56FpJpi0gRcjZHYQ4tpiz5/U1kJeHDmhsmdHR6yU4SmjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6720
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 5 Jan 2024 14:35:14 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Dave Jiang wrote:
> > > v6:
> > > - Fix breakage in previous series for device_find_child() (Dan)
> > > - Move DEFINE_FREE() for put_cxl_root() to first patch (Dan)
> > > - Don't touch put_device() until final cleanup. (Dan)
> > > - Add review tag from Ira.
> > > 
> > > This series provides a number of small cleanups to make fix_cxl_root()
> > > and related code more readable and safer.  
> > 
> > Looks good, Dave! Thanks for the spins.
> > 
> Subject to Robert's note on removing the root variable in patch 5 as it
> now appears unused, this series looks fine to me (and I guess Dan can
> probably just fix that up in the tree)
> 
> FWIW given this is already queued in in cxl/next
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks Jonathan, will add that to the pull request.
