Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265015820E
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759718; cv=fail; b=AHWhD3nYEhknsPkjS4kBxO6LOBqjwCsQGw0OuP5ZAhNu5giNWFlXhWZXxBcIKR35OEuWH2jOrqcIv6oeXtN+zwmxDOIc/sg1dSmvK+cYp8NopUSKIKm8CGlw2z4bSUvKmn8e3nWEUCbgGVtHgHTPYKfx0xfPemMk/dtQZDVo730=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759718; c=relaxed/simple;
	bh=uqQQpunaQJautNAkAZf7I6q3GWI/vFlHG2/MmnRsj2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OV1dztadlnH768KT79hN+WQY8wzHb4um6nqK+KPPNhqnM16iAURuKfw71MDvUJfArPL/pBit1phmL8jjyB6S16ivnve1ZDDYJl62ao6IHzja2ft70ajY3K4ukIGjH+gCoPTN+spraGN+LUTrGPujgNM/q70807pWEq/3B5beP6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6NgnHEC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6NgnHEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714759716; x=1746295716;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uqQQpunaQJautNAkAZf7I6q3GWI/vFlHG2/MmnRsj2c=;
  b=Q6NgnHECozkftRJOSaQR8PEy5UaWfcOOEEsTnKXykqyGYgYogr26kXPf
   kZa3fSZDJNuOT2YkU2gLkFpEJl61u1MGp6tp3B33smzkxgKlVvhhak96G
   W7gHibO7isamMEmNBOy2UbukKQtPeXqh3CwFMAFi9OpnKhmQHT5H8KYuO
   BxjaN14vpMyKj39YL9Uu8nauaEAbZEOPhyemgtpeIr51qgczWYfOwScX7
   fptZmuu2uDrZNiIRseeVlZIE5/MHGPdxtpXS1GIv6BNgnFKVo6fKkBjTv
   85AEY6hGeSwqI4BJCOO1YZKeCByQI0oKvkyrPtFJsSCaVOYdT2E2BeVo/
   Q==;
X-CSE-ConnectionGUID: lAVwyaEvTIqZaEf4/bk0OQ==
X-CSE-MsgGUID: PjgFrh4mSVSDRPAW7/5xSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14394655"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="14394655"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 11:08:36 -0700
X-CSE-ConnectionGUID: T/puNziMQIKgU/0IJA9qog==
X-CSE-MsgGUID: dx4PjqCcRu23NMLnwNrthA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="64963226"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 11:08:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 11:08:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 11:08:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 11:08:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 11:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRAd5YpUKGauL8zhD2aZOYbrsUoZNLs9Y1LIYJ5qA+0Zap/AxgBFzGItyFzpXdyCfLgcHMtcDC2W1/5U/eZkKZFypMo2DpVVwvnX1Tl5tA72SkkkzDNmHyTFdAAVgvTYuNhyVdN8heokqdNrDlo05aTz/evM60uezxMk8h+GD5s5+hTwEiZ+zkfGNYdCjT4H04Y6H1miSOtdr7viOOOuOaBe/9AMdHa8/s408ggf0vVJVNfWOZH2V0WMEIEAsDpaoCOggVzjoptvHw24XEbLv+180OMkKyN1s6eOwFYBZfiiQfZN5DpsTFvzusGKSadV5OIo7DHEi9WhiUdJoWuZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZz8X2EbPXrV4MN615k9bSU51/5aJnc8uxzncsD4BYc=;
 b=WixNDyR2+hUceJJKrsHwInKLsnI2hkIey0i+8vgpRKcR4Chl/JDV0yJe89xlZhe4AHn+QUtWmd+mJ4GV3+8OIhJDD+HrW3vkSI7Aent8rHCnbcx9Zu3JDwEm/O6hGjbr7IXm5eO2aek4TOOW4FKlZX+1UbCeXVnzUyaIhhVViwfOhzZkj+iqU4MOfcImpWAREZGFJ7SaXl7Odxiw4zN0SzooAUIW0PD4mFmGRHgo3C0wwfZStove4L4TKLbUOX2kiL02oUzRc4n7IBP2weL2Fz70ZNXbemciyoafjJgHJ4MUouvVruForl/H15uds3ti5RTS9D9TCsi6mq9CKQKVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 18:08:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 18:08:32 +0000
Date: Fri, 3 May 2024 11:08:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Shiyang
 Ruan <ruansy.fnst@fujitsu.com>, Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: Re: [PATCH v6 4/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <6635281e2beb0_1aefb2946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1714496730.git.alison.schofield@intel.com>
 <dd8d708b7a7ebfb64a27020a5eb338091336b34d.1714496730.git.alison.schofield@intel.com>
 <66352769c2394_1aefb29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66352769c2394_1aefb29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:303:8c::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f9ffa4-e910-41d5-0277-08dc6b9c0b43
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zxDyR3hN6HclVP3UptyYKOXPxmlmXqaN7IGywo1UFsMLt0vzQnB9V0tx0bfl?=
 =?us-ascii?Q?yJshOyyuQeXi32rSluVoOYnGhp0CpJSJ+FehzyTTAq/Czy3mtnmtFb3i2ru1?=
 =?us-ascii?Q?YmRS91Z3VyvvCNNLmjau8LEuPP6Qt1+g/PI9q0hqjS//JMHWxqFQkMWasShL?=
 =?us-ascii?Q?6gGXOt33bQ6MtRkEExF6odu00S3WMRvdlrHW9yE8dKcSZzqnve2IVPHqueYC?=
 =?us-ascii?Q?ZdHg4f5jWsc3tOZ3lm2NaUkqPuxA0Nz7SnJfQkno0n7bn1+jEJBwMS4y1w/b?=
 =?us-ascii?Q?j5QUb2Ryu/Q8BbnDoMzIGdeCFjt6BbthML6XaImFv+4oQ8cvU3vgWjlJaOao?=
 =?us-ascii?Q?XWMWzG1RTzJp8HAIdW/rKjaWOPSNATSgclsICFH/+jtWYdstr3Be3/gZcSi8?=
 =?us-ascii?Q?6tI6Xb32AjDBQWyB7rQfkRmQBV4RYdKHk1XfjFosCW80aqVMKIxnhY7w36xs?=
 =?us-ascii?Q?w46f52cC8D90IUwN/OoYoO+9AU1RAs7cVwCtZqvFjOK2i2ytP5DYB6v8IYlG?=
 =?us-ascii?Q?Q+U2o9Vk633Aa9Vzyl2vkNME1nPMinNDDWv3UfPVZ6arZCD0J+wm7uPEWPlX?=
 =?us-ascii?Q?/nuKTs80EpMNmPoBMbA9qlJ3D3rE9V0G63tMXYS+LJPNgYDXZG23fGrGoNZt?=
 =?us-ascii?Q?nTjRu40DWBZkZyNQgoMeF0qUH+uPuA316Bz3W5D+kz3H5mtW8Ulb79PUxqQT?=
 =?us-ascii?Q?AlZS806tRx8hs4nOTdb/7Od9P9ERgyD51hB9p2wRujE9t0h3g/JDYhJ3lLFH?=
 =?us-ascii?Q?0XBGkX5Oy6oSQsYsbhf/YJppNCXXRZ9PnABLJuycjjMoMrUjgwgxbGoZmrG1?=
 =?us-ascii?Q?B4abpI2wKXwSW5XYJ28v6QvQZT1kH1QwOdOtI94aE2P8w5DJR8fEDYE/voXb?=
 =?us-ascii?Q?EruB7XghJVjOW+/Ws4MqjkAhC86MKWGw0udb0CVd0KwBj6KZW7zpeec8ulVF?=
 =?us-ascii?Q?PJitHyb/hR7onFWzVj349/2ORYPd2lazyeHPcCD5PeFDvpV8Z0R7ba64pb80?=
 =?us-ascii?Q?rTaevDiYn8MzOWi2tVsEM9MykY7pySIVzQBiwLJg0ouM9RqGQZIufYBXQuFX?=
 =?us-ascii?Q?SkcFSc028JP7I9hthxrTSqjP6QwM+B/EP9tFv1y7lAeidI4tYqgCW2b9w6tb?=
 =?us-ascii?Q?U7f666W432c50PduZsUpv1b++LuvvOgmQ2blG28HPaJjP9fTyMwGxOpYBV7T?=
 =?us-ascii?Q?DdUZ3KfqCfgnj9gwHn7v7zj1N4ghKk6oDwq21cGUuohVwEZu7vnV3wiS7IXI?=
 =?us-ascii?Q?t+Dv7EhTsKGVwrn22HSzcXIRQmAtO/sP4q5+mN+uGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZ5g71TRZegrPedDdJelUtWRkAfhzEBBu/nIE5sCljJZ3e0biH8Op4Z+KDCv?=
 =?us-ascii?Q?+JpWnZ/Kodluscd3DeGoSWH7DcDHa8dJpxiPehVKMp0gCfSP1yVTW05jT8ph?=
 =?us-ascii?Q?XSjpqPP4PXqlEWjDZU46oX3VcssrnzRgiJ1URH2klBCYQDIoz7rB7Z7+jUgR?=
 =?us-ascii?Q?9L7mEzfRbC6R5zXioy3NRTjdNYu3qiN+CsirbsMlaeoXpLZwi+o8TGy2TqR5?=
 =?us-ascii?Q?5XiwXd1F4HTDaj9Y9yCpBwT6mf1/ThxUl4MWlV4rliK0z9x7wEEZXV1gtEvC?=
 =?us-ascii?Q?jInH3SnaoqxbnV6SZz9kPG56mrfmGy+hi1LDHDKUidxt1G5MN1OxVAkyzO5e?=
 =?us-ascii?Q?So35+887B0Tio9eiMcbe3Jn/poQTjt5+cSiLRqBjf5KVuDae3aBhPFqwwUfy?=
 =?us-ascii?Q?Vw32xWozw244FiGRu7/PdsPEVL7rTYTXh5pNuasOGvaoltcv/ss4r9CPadIF?=
 =?us-ascii?Q?tEi9Vaayb6dE+9Wbhf9Rpu0LHcK+gHAQcaJPSTVGbEyT6Lf0bNMPS6pjc+My?=
 =?us-ascii?Q?BZoSPKavC6ZwgpvMxtgreGn4JFDcgJXdm4B3P0upTmCNuc0GdsKNZADLoGfR?=
 =?us-ascii?Q?HCytZlMwd5y6iHkGOgUdjgNk2DfKQC/SHRk0/Y/piX6keOHaKpAQSxyjCBzm?=
 =?us-ascii?Q?ZoQbV5zqKiS+IWt64uhsbq18g+NnoFu8gO5a58F0Aszssg1gHmGyfJmOxCZP?=
 =?us-ascii?Q?aweSt4JLr+4Ovj5q43GE1oJS+FxsLM/3Jnxtmas3To04/OYFR80zpuT7OFzD?=
 =?us-ascii?Q?30V89E7VPJQZ2bPGjpwBn2/O5HuTjXNKl/vQ2C7HBE1k5qiswdZqqEbATj2i?=
 =?us-ascii?Q?k+7yXA3XQhPqvrrfMl8KTuJmHDq5BAUiZky8QdWA0nXqUD8AGXJlvjeuuNX4?=
 =?us-ascii?Q?8VvbrPBd85+q4HN8U95cfRsSEddeR7skbNFeSpH52I9OeGiyG2cpXkVoZpXb?=
 =?us-ascii?Q?3mV2dzifu7ZSfTFfeqznjeyS1C5+zFfOoMVy1x60Xztv2Xl8Qm7XmdfXgVrD?=
 =?us-ascii?Q?iLrZcVe+mI1FSK3NE0VKlLwG4Ny7xwV88C3xI+XGASUKFnWQiSjYKZKg5/Bs?=
 =?us-ascii?Q?+mvk3Z6bau3SjwpdwfMLtXlu8THuy0lIYDBmq3Fb49ia65M6qFfxmHhzhfIH?=
 =?us-ascii?Q?IpB3ew11/FfnrVOpfkc07E+kjPP3YORSfqmNoAnVldGgH82gxQ6okzMPZ5gI?=
 =?us-ascii?Q?1SPs4ErDOtLHWxAqBaWeVBA/DVXusZEClG5bjy0rOTh40aItqMhK0+hW9zwC?=
 =?us-ascii?Q?FXEh53/LGVVBbXpHSuawwl3DsfYQFwv33+0v0WXKe2Ue7de4SUH2litZP7Q/?=
 =?us-ascii?Q?WgmjddcVqOIFKo3GH39WX0n6Nz5z+SoC+R4/k0hyLGbQuOlTNrcX2ipNFBCW?=
 =?us-ascii?Q?QClNvYlWQ9gkOBaUkiq28EnRQTp+ciO8f7Z3dOwJRBUWdlqv1pweRoql6BW0?=
 =?us-ascii?Q?Jr2/B71QeDb4dHAae8g+mp40nh7BgKufslWWdoAU4Kgz3ufV04jwvqsUzmL+?=
 =?us-ascii?Q?D3oavmfTxd1me8kk3CD/ZGBHBsUhRQ4wWdV9a2nCMEfLrd54nFxMpshyBdjy?=
 =?us-ascii?Q?nJWyhaq+zClH9b+HgDFZVCwlqNKjFBW/EoWJ+Od60tpZHUiXJL3hLPngP5cI?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f9ffa4-e910-41d5-0277-08dc6b9c0b43
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 18:08:32.9124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfKDnc3jOCfWFyLbtN7vsBzNqavgnFL41ojn32FL5OlXqFQwUT3Ee5G/IOg/2i3sxSC60pN3DoXKdicXOB+ykaMV+r+CoAZWgjqalZKmuQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com

Dan Williams wrote:
[..]
> The "maximum" would be to combine these definitions into one common
> flexible format to maximize shared definitions, something like the
> below, but the thrash it would cause is probably on the same order as
> just adding a 'struct cxl_event_media_hdr media_hdr' member to existing
> 'struct cxl_event_gen_media' and 'struct cxl_event_dram', fixup all the
> users and call it a day,
> 
> struct cxl_event_media {
>         struct cxl_event_record_hdr hdr;
>         struct_group_tagged(cxl_event_media_hdr, media_hdr,
>                 __le64 phys_addr,
>                 u8 descriptor,
>                 u8 type,
>                 u8 transaction_type,
>                 u8 validity_flags[2],
>                 u8 channel,
>                 u8 rank,
>         };
>         union { 
>                 struct_group(general,
>                         u8 device[3],
>                         u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE],
>                         u8 gen_reserved[46],
>                 );
>                 struct_group(media,

...should be "dram", but you get the idea.

>                         u8 nibble_mask[3],
>                         u8 bank_group,
>                         u8 bank,
>                         u8 row[3],
>                         u8 column[2],
>                         u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE],
>                         u8 dram_reserved[0x17],
>                 );
>         };
> } __packed;


