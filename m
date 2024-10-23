Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96471155757;
	Wed, 23 Oct 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717701; cv=fail; b=IkyKb3wbFKVTS6ONn86zA4pI2YAtcL/0QUnDreU/xryDSPzZf2ikp30zkTofh3T059S4GYJU7iQGXt9ik+LBXATC7DYcpQQqaAbWpyjAs0eJ2zMAh6UP43N8xgrmhbc0NzWK4AYvyS3lUh4e9TnRAD8Ek0SQd8PckZbusMcYDBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717701; c=relaxed/simple;
	bh=ttonG6TrX8ouStYtr3W+PLaErcTh6wFbT4OT3zZhX5k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gvLSUzKu2l1Mi8Xp3DQHAV/VLOAcllSvpx7yUxjtbqhsTX28ZTNqcprNJ6vnRArhf9DGrrLjecl8/T12Y28bn4S++TxDu2AvUeJAibYB65dxK4mq1PFtgJf3asLr5m1hsLTxD1zGBFTgId4hDCr71fAfuk4cAfgckGgfV+/QCiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NB+/lPG4; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NB+/lPG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729717699; x=1761253699;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ttonG6TrX8ouStYtr3W+PLaErcTh6wFbT4OT3zZhX5k=;
  b=NB+/lPG4MKQpOm307mPGx7XJYUNvb79lstBtl5WNW3RU81KMSYCoPVzj
   4QWDzj1tr+2HViS7qsP0px1uE7u0vmI/OroUEmYCGvZ+WimQAiKuselPF
   2NydhTMfH9bWPo21YtViWIolivAykeUiXR6+CU/vHGuLgyPAcUnO8gmKX
   5G/gDKLBnw7kAgUeuPMJkkRQFFZIVAEJySfrwL8C+BS7sKKwlHAmkVs+x
   3KyIITHIHyc0SsQAPQbdgpif8lbAdiRpex0Bxuft7qDKwfgHoHx3mTUeW
   XSpLTINd1ws4DH4scCsOZqim4p1lyScqmVK+RmxgRwV+Y+zPcs0IN8Orf
   w==;
X-CSE-ConnectionGUID: +5A+jvHYS/2piVBw6ncuMg==
X-CSE-MsgGUID: mv4NpqOMTCOvOld4ROm2dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33134517"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="33134517"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:08:00 -0700
X-CSE-ConnectionGUID: FpJmvzKtQ9iKgKZMNdhkjg==
X-CSE-MsgGUID: TUWoCSU2SU2edFCTbV5pcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="81214982"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:08:00 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:07:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:07:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:07:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGOhw6tzvOv+Cn9rHqKpQpRfSIOHZpy0a4OHU1gOnZNhRG61CKxLb5d1WppeajThDAbyZl3fHFDaVBbnXX0Jp+Gctd2Q9iptP/WdtLuJaSbyHQgNS2qmNFJHRdp6Rh2dIAzM6iftvGj7dnMZ+i5nPRAieWKnVoEp6dndIqVeQtgLv5NUN8wwD+8PAC3sE9zx0+wCD0P1fZRPXCjW0Ubl5e9tSPAhikNM9VfxYgrd2mA7eABU2pPryzLhwXNLOv13UMfSO0cmxpozok2X0kRf/FQDyWgaNI2kd2nNyVn7sDmOCC1rphNFHYeK0eeWc/8U5IPiLGeGKhmjyFvhAKYQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m8QlFRJPEVMWes6OtBe4+naf92ZAsye3Ro4ewdI2oU=;
 b=yTTSVoxZ9JnizMAkNdGp1qLMEIRXbkJnIqDphYY/QH7Q4UCZRLRLOLM7duHBwBA34ZWUP2G26ICQZpIhLrSCG3iTI92xNVwf8RqLC7E2id8fmo3b4PVCa42Hq37efdEME/bxOxp0/yZTF3ISFS9yrXBCLtZWNKBMy1klWramMK7d1D15mRUzHKHYGSliYFLG389t/U3iT947nx9FkRTC9mWIeV6r2K7/yDcITrhUjz99NNFw1S61csrevNvQ8tETzRDA6y3XrEluAXACIMkWyqCSrwyHTxU1IawVJmv4I7h695PPTMROyWWIsXTEHs/LC8xvzr0+yv97cD2QL+iQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6053.namprd11.prod.outlook.com (2603:10b6:510:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 21:07:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 21:07:55 +0000
Date: Wed, 23 Oct 2024 14:07:52 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Huang, Ying"
	<ying.huang@intel.com>
CC: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
Message-ID: <671965a8b37a2_1bbc629489@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
X-ClientProxiedBy: MW4PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:303:86::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbf139f-0d5a-48ad-4f5d-08dcf3a6c3e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rtblx/8DanTeYyQrST8sBf8+IiAbdPpfy2UwUu3tzf+pb9Ib/GfD8eiozyTl?=
 =?us-ascii?Q?Pznfdh3HdRxxQx6l8b6rLhDxzQ3GwCIOZiAzDsW3K6e7LyOcAM+0QAGE8etX?=
 =?us-ascii?Q?8oqfbFqRoSoPO7JiAQl7xXZHj3uRvxRcBdP1TEesPjuBMeSppu1fgK4OjKcb?=
 =?us-ascii?Q?EfVJF0zrF+7/tIgCHzIdxVE2B5x07TruYZaHXjUexABnuz7BNao/o1sTwNFU?=
 =?us-ascii?Q?7R/E54wJqzt5uzPTLehNKyLDiMjggc0aC419mA88xSkqb1WJh7bQN5hmOYZd?=
 =?us-ascii?Q?kDWlMwhicNIvNc0RsrlpmQSfObFNol0qqnP2D8yqGJqI/gjNmG2HeCnT4SrH?=
 =?us-ascii?Q?NXLqBp3eF3zIgsBVPOun132Kc2kL+tgLFb5X3q5gCKiVZUI85m46cLJX+OnJ?=
 =?us-ascii?Q?pRpV3QTNbCUky25/fT/FIarZHc2N6MgpsWzBeEA/hYazZoSCud4sdLodI544?=
 =?us-ascii?Q?aObmrKxyNhJApSQ/ySTDUhX9JcfXaVIGP/nTW3h6KefP5/IufFwmu38U1gvX?=
 =?us-ascii?Q?1HacEi1Q71PwJttRt5o5sh0haxev5IzFrLvSIJpUZV9wx2y2u778nwTigzH2?=
 =?us-ascii?Q?bGU21AF4Y1RX5Qp1y7uVNzMhNZwQUPKIBun+h9rfc/l09XD/INBB3cFQhnds?=
 =?us-ascii?Q?rxOmIaBxaQP5vp8SGgAE4VMCLL757cPLutxJWvG1ER3MOFE8sjYWZ7IwQU6s?=
 =?us-ascii?Q?JAzKf5Uz/DdHADzJExPAkgYbJFv8tg4Y3zMq+Sq/SI1WKTAqkyn2RDiV8pQO?=
 =?us-ascii?Q?O+k8vy0I9D1ssg1xsF9Yw+ecHMmEctwgDmdGDdB8lv0IV2uWxk2MARuex7eQ?=
 =?us-ascii?Q?TZ8vvumOmwYkRfKcvFwVWu5e4ZvuhHlUQI6HLo2mCcXZ8NsthBYoX6hGpMOX?=
 =?us-ascii?Q?AHKuEwGgE1Winot7Uy6vNIFrgJenVGXbuMOmATlxCqTXnCZSm71Ln54YTwha?=
 =?us-ascii?Q?Wk6Pby/lIHRNZsxS9uxUNCmFqmNJwTuLO1zOx76w9ATXxH0ne5gGZM8hT6eO?=
 =?us-ascii?Q?RSG4KjEC6/gKbOKJBrWVz8G2XZPnv9Upoxvt4IC/zIWWDx9ITNWz4NxH52s0?=
 =?us-ascii?Q?640bYeY82lZYtLzkn9xjKgu+KP4w/qPCK8fkbNYvp5pGi6eeoa7aj+zKRGgi?=
 =?us-ascii?Q?NBLOfCVo/XhOjq/nm2R13QPGJqNh9Ic746E7TwqQ5345T2u840D4JQDKYMj3?=
 =?us-ascii?Q?CBD0dme05nJhyTzzBSy9/gGSQy2ZFQSe2SJB7QRD29gi3xrKlKOvykd57KKf?=
 =?us-ascii?Q?E4aBJGAIw9efkaNP1QuUqj+sW0TuV4JNfgplNKe2swIyS67X/2WXzzUTw0Lw?=
 =?us-ascii?Q?h+76nfnYlKnIjLQ+D5a1sFYX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0DmQug2hxNIgUrvYQWUSiLx+Gz+XVoY8C1hCAOkiidrbbh4CSQpap+Gs0JJ?=
 =?us-ascii?Q?+BZD9xhyTRXokw0F19Mc8fIvD4aky8evO/Vm7VhYtQALU52HZugdHzSt4ef5?=
 =?us-ascii?Q?yhb3kL32sJ7+gz1SHfLA2Rq+Gv2RZvrcgw6iew/Ax0a8JynEzV+cKLbLRXlt?=
 =?us-ascii?Q?3vtPgIeKQcSbrcX5UPKvfGoLV5mohd+aK9zejPQDzLMMGU6fbDj2u92vr3Ms?=
 =?us-ascii?Q?UQJb4XGgLetiNyZKZQpkpvRWrWb37VGz0nLK8nSflZtIo5ezy7uo4ffAyRkM?=
 =?us-ascii?Q?naXKZMMu4L8WQAgvdqgIeKJfb4fK/V4TNwGSn7v9Aa/7ZsvM0D4IQ6UxfLov?=
 =?us-ascii?Q?/KnrJnsjzqwx8rgihEUpCW/xVQ+5W5eHZKU8f3aI7up1DAK3hpJ/R/E8T8DD?=
 =?us-ascii?Q?3SeeYeNnDF2OfEVX2rbO6T72gpHd9658kYvQwj4XLcZg6Uej+FTKXXZ+F9kH?=
 =?us-ascii?Q?SB78EyloOB9KxUL/WMotOuPDYuugOJkvp2OIHGCXxdE8LovXgkzw3Yr+uwRv?=
 =?us-ascii?Q?po5vbEpccXVq0dQkgTHOyqQq19WQb0x+WemklizCjxJ4bSCVBE0gxjaRlodM?=
 =?us-ascii?Q?ZoFwSmZpUxwqUyXwAuDoRFzP7vqZp4j6Aj8oLyMFZuQ80pO21ZTgphoksCM6?=
 =?us-ascii?Q?9R11LuKxav9bVMHX7f6pZljF0s5l/GGiX/nzOGcmplETWOQz402ydPs3tryW?=
 =?us-ascii?Q?3Nnw0wzQiLWZ75Wp0KTLQFPwsE5clQQEhQ1/wZQbkKu4oN51OiufbaP+dK/6?=
 =?us-ascii?Q?vj98TJmivhrCRywBky6Xoro+lmFwsCJja9bWkeLj3LSkVG6unPvD9fk4t+kO?=
 =?us-ascii?Q?VO3gfSjpfgLo1UCesjY46/RZ/dve4pAwkiN1jfm/qBkB7EtQCngRpc9PITSd?=
 =?us-ascii?Q?P0AQaqQNUMlRW4PjabWLo08970SBKXfn7QvXY+CRv0CHtUAoVrW+Vs9SDtJJ?=
 =?us-ascii?Q?jEAt0fHCz52hl4tFuy/1aGjToIXJMgTHeVw0R/hVt4bQ3odKAbNEgaEMxPo1?=
 =?us-ascii?Q?DVArVO0f7MdOvYb8tf2DHkSX/cl3QMuR3GJ/Nv0wcrivvWjOOg+JWEPuwiZc?=
 =?us-ascii?Q?YJByFUIYzXG7zK6weFcmWPBqiBML6T1op1ncDBh0rSq+kgeUwUFt6qfs1X7i?=
 =?us-ascii?Q?F3BZ/Ek0u2cLl6REoqmx3V2zcOtl1kk+mMcFMWDUVH+PtraeXOcuwmkPQrW6?=
 =?us-ascii?Q?NnYl+4aj8eL07qdFxO5cSRcC9QkuDmeRBKnjlG1uy4YJgmYZQo5PAcSZI6ZU?=
 =?us-ascii?Q?6TT7huSIPoNPjBqkkO3yhhO1hgsDPykU0Wm/w/U3gYAVHpAJiqQMGpbcsevw?=
 =?us-ascii?Q?3MtQ4RKRaP7Qk8VL533IAcNF4hTtE2XUpflZ8WWuLmropy5L2y/2LhVDaonQ?=
 =?us-ascii?Q?suI+nbfD24LwfUeX9xZ8STDnJgWxpABqgec/sfDJr16YpmNAcnibw0oWoBmf?=
 =?us-ascii?Q?bz/8Zl79y6I8vhGPoNXqmHdSkU/+IpJ1/H76ye3QdL8gg/RgRAZTw4nDsjKL?=
 =?us-ascii?Q?UnUJ5V+SATcUDMh4xGoOXQg6mw2wOFgcjy8U+EJMfyIcmPX3ktTWU4S3boCC?=
 =?us-ascii?Q?fSFuG1cW3MmMHpNlWcEAXMfn5aXd1uyokAza05X2K+39eHzCrUd2oTmx4s6J?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbf139f-0d5a-48ad-4f5d-08dcf3a6c3e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:07:55.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hp5iCmiGA/u9+ESnq/uzx/K/LP3XqgAbJQ2A7WMzeQrC5G/HEYhI7S71NqQwNLCbmqpHOGEs58spa4SHl5uV8WY8Q5vnPQ+q0m7LC/VKWmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6053
X-OriginatorOrg: intel.com

[ I was sent here from 87msiw4j1m.fsf@yhuang6-desk2.ccr.corp.intel.com,
can we please just create a for_each_resource_descendant() as Ying has
proposed? ]

Andy Shevchenko wrote:
> On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
> > David Hildenbrand <david@redhat.com> writes:
> > > On 10.10.24 08:55, Huang Ying wrote:
> 
> ...
> 
> > > 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
> > 
> > Yes.  This can improve code readability.
> > 
> > A possible issue is that "_root" will be evaluated twice in above macro
> > definition.  IMO, this should be avoided.
> 
> Ideally, yes. But how many for_each type of macros you see that really try hard
> to achieve that? I believe we shouldn't worry right now about this and rely on
> the fact that root is the given variable. Or do you have an example of what you
> suggested in the other reply, i.e. where it's an evaluation of the heavy call?
> 
> > Do you have some idea about
> > how to do that?  Something like below?
> > 
> > #define for_each_resource_XXX(_root, _p)                                \
> > 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
> > 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))
> 
> This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
> solve (see above).

Using a local defined variable to avoid double evaluation is standard
practice. I do not understand "avoid ugliness as long as we have no problem to
solve", the problem to solve will be if someone accidentally does
something like "for_each_resource_descendant(root++, res)". *That* will
be a problem when someone finally realizes that the macro is hiding a
double evaluation.

So no, this proposal is not "ugly", it is a best practice. See the
definition of min_not_zero() for example.
