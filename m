Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4493214229;
	Tue,  1 Apr 2025 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743542483; cv=fail; b=GtD6iHj9ynHk3Tv8QVq95Mh1p5hJiPoLZW6HAnzpYzk0+sKb3JQdJMEhWJQQkVF6jBPb3XKZojl5mjkfDnhM2uq5iYqQUz5la7xSRvgPIyIlkZXVkJSGULX0X9kPhO3uAtCzKSbVEvK29K7K3VZ3F9kzGfH/Gi4hP5wlkPOjwm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743542483; c=relaxed/simple;
	bh=6l3b6qIYWNrXBso3CxGEHoonY7hb4/QWlT6R9KH8WhI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VqPGOG7SDwQRckPSBnhA1EL5YiukfF7cgvI0d70vigCWqS7MeWCQYFCYM4aNI4stkg6APN5TXx3lsQizwgP8rtS7pNuK/b17GmM7fZjCkc0hIAknH8wIGWlyw7kJKw8SFwoAzKlE4WJ6FhqJZS0UYPRR+RgaBN4TyZOhSlIytSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqfCeln2; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqfCeln2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743542482; x=1775078482;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6l3b6qIYWNrXBso3CxGEHoonY7hb4/QWlT6R9KH8WhI=;
  b=OqfCeln24ADLrlJLEO3xjUh5LXfrU8tRhpZNtTJHzbOjLZrvER+ABuOd
   g6zMyobZl7Q8HGF96+4aNCh+vWstt8c2VQQ26QHtt2mAyXmZO4y2oVPzL
   r9/N+iUiWLk4jqy2dUrMXoJBuBp6Ol1QgBvKZ208+5zCYcxHfNRfYHv5a
   5qhx+K13OKETgyIpahhWuEB3RUinQ/lM9xCLE10vTgRvd0jwDjO283p+H
   WbL5pZELfFv7jYNRhXUUSu6UvsesehqyDGwb7HdKbzWcEP7X81dNpKINo
   FJFOMQMs67MoopQmLIX2cmFT+6zQ9DKjn+tUyorvVBl1/WqYWNpecn0//
   A==;
X-CSE-ConnectionGUID: E3zuq3YvRnW9XbTro56yCg==
X-CSE-MsgGUID: lOUfWS0uSOua0Cs0mNQz3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55545762"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="55545762"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 14:21:21 -0700
X-CSE-ConnectionGUID: AcDCWRAdTk6tLd+UELAWTw==
X-CSE-MsgGUID: YTxhJvviSgqC25yeE+1mPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="130613454"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 14:21:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Apr 2025 14:21:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 14:21:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 14:21:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BadCcAJeApC+mmZ+zcp9/NRfJGoa3zvHq+naaJG0qV95rzhrX93fcUB9Sn/FR84Qfhh113cHedftaW2PJgCN0y9lYwdJaxPcFOHP1lWcGeKVBfBQJSTt+TFAu4NodDJSC041lz3BG4DMn9MSnAClXbAY5Dt1XZW2OopncmkzBviLQyGSy7KqYarLYv3raXsISrFKBl6Vw7w+TMPN92wQbqigg0fIecftgA0IzD92hKKtXoRGkDAPrMK/9UrZoy4NIt59f/jZfbXSu9lMM55AEBvgvhR1X4F929iYYUbo1WF6srGe7QMHSULNlFrgtQHJErLdo7rNhrDK862ELUohHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN0NLvYKTCYouF5P+dif0lE1ScNeZQFy2YZozjaZwEs=;
 b=lIxZqUQ4ZhwgkXseTvHdsezTPLZ/4eY/mdR6p/sW+4AIHkBfMGrUy3TJyEodBy1zmD9+aQUnW2dKJt3MNMKfZh2LW5iTJW8wVf1l4yG0ZY7vaj0FYRKNuT5psZDwAIg4Bt+4WxyvEcW1Kwd4fzZTbm2rJBwy1/fGNTdEfqGxVQ85Y1JO4746+avriknts3ZOcJ3xkjYgisH3JFULyN0eF06Tu0ZzWNyBfhwR//iDt0ZaxNdeV1DHoxgUCMiNz5vz8pyWFeF+LSANT4gNSOFPDy0g7GrJ1pNfh7MTk+dw4cdWyK+JewX3UHl80UQQWZGJ/GGUfQY9scXmR6KZAUMJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8217.namprd11.prod.outlook.com (2603:10b6:208:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 21:21:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 21:21:15 +0000
Date: Tue, 1 Apr 2025 14:21:12 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Rakie Kim <rakie.kim@sk.com>, <gourry@gourry.net>
CC: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<joshua.hahnjy@gmail.com>, <dan.j.williams@intel.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>,
	<Jonathan.Cameron@huawei.com>, <kernel_team@skhynix.com>,
	<honggyu.kim@sk.com>, <yunjeong.mun@sk.com>, <rakie.kim@sk.com>
Subject: Re: [PATCH v4 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <67ec58c8c637_1d472949b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250401090901.1050-1-rakie.kim@sk.com>
 <20250401090901.1050-2-rakie.kim@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250401090901.1050-2-rakie.kim@sk.com>
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fa0f87-33c7-4dd9-b573-08dd7163225f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vlc1AHTo1XvAf9bXVah1Lq4iTK9rEvnR4kDuzRB4d8YGFRrMOEuINUg7eiPt?=
 =?us-ascii?Q?7XniRTlKEV/7JueuFWKxY2ubC7Wa/LAEnupnef6x81z2Bwif/btFxL567cZ+?=
 =?us-ascii?Q?Jvfc+wUKUikYYHaSJLo2rUzEji3HVZr6yjE4xlOSUE1i7mlc/sG9KqP5EeK5?=
 =?us-ascii?Q?azDGFyKYDr+PO5TiDV+f8bSjNwJCkSe7D/1vnfKt4Vo+mXFr5MyvT0y8edq4?=
 =?us-ascii?Q?/Yxs2s+ZomFKYHa+5gBO7kqEiZpnpx1C4Q/+eKjPOhD5Y3blHTyhFtbUbrX9?=
 =?us-ascii?Q?XdNZgmzLT7v6k3vaVaLDyJoQeTB1B00WUEK2FPpTigO+uNYBr+BH6A1YKqGf?=
 =?us-ascii?Q?ADElX7e/IN7E8thxEOiB5udxYeLgYcQrHF6EUPnrMDpljOQDJ+DnUyGpFGtZ?=
 =?us-ascii?Q?mF3NvWEI+Z+nVmAUnHjd8gIHv8ByHpRnl90mvnVpOgMpy2uh6ByhM+F+P31S?=
 =?us-ascii?Q?BP9R/UrawUhk/MvYMaZTe4WLyOW/t4TTROjMgVo1+Ia9evkBwXnMTDdbhmQZ?=
 =?us-ascii?Q?tqWcjjV5NoIf6IQQUFZ0DXFEst0+kjQ9KYfcDIF+IFDHdn07uJ92f3K1j4IQ?=
 =?us-ascii?Q?JsUD6+TOjPDSEgfRCxeUF0ozbsskgWVwjYf7Ij/QXQH/beJjLWeR48icSBMh?=
 =?us-ascii?Q?EfpV898iF5Poxcl2kYtBKkkc8WJRjX8kjsHTUTv99KxWEDNGI9urq4GcVl8c?=
 =?us-ascii?Q?ffXNvHhqj6vKcWlXRMGB+XCIPx8P+SJ4Wco5GUq2uFgsdk8I2YVnCUPI6dJo?=
 =?us-ascii?Q?TzmliRymgJ2OwYUPe+CXDR11mC0k8xCOt7sROeQtYyqE7v/7x9Q6cfws7eXc?=
 =?us-ascii?Q?8CrJ4v1bXXHZHQ27FM/SWO6bh20BGp+McLOVpiFmogc/skQ42BvZGHWJCjYI?=
 =?us-ascii?Q?85baCcoNDRrhPJNbKsO+u8mZsnCG0SJSb84wX+9cYdUkHNMHYzGR4m3jYTc1?=
 =?us-ascii?Q?+R7S7eH0lqhp3P8x1qr1VyY8EBlv24Ztv8SdKA1FkXMMzHxQPDAvQMeWH+Dv?=
 =?us-ascii?Q?k3H+pzEQF5b6MCMyhy3VLqA/W8Kq8/uE0qL55KiAXtYqHTQDZ64/vIRh1Xnd?=
 =?us-ascii?Q?5AExyvYlJ0AvTUhEZTiIcs+4DGxzZvNwcMAqZ6YYt1sUR9DBOYabIUL9gAPk?=
 =?us-ascii?Q?uqgzNPzr0OXxLku/jqQhZc01up6KknbLtmfRUkw1ru65VgU4iPzmVI4Hh1KA?=
 =?us-ascii?Q?Rs/Ew5PHvlgmFsCRXOGR1a+cy0dVozf5fHCsAzU/QMnVXdsUyhT9CAmTP0Jv?=
 =?us-ascii?Q?68WQo9LnHnt3NAfMBM6+vS5Kt5EcQ6iy98B0PNWrgQKNEZrUpk9rg1iPimPA?=
 =?us-ascii?Q?Y0Z0Pk/rxW6bDOXJUSlDeIyCG8eapnEoVHdyPUErgjdKuZI1fhoj2Rxfs0y/?=
 =?us-ascii?Q?Nqqd02l8m6sB9bwmQ2+l6mCMZg6/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGm/15CEuOoAMtleiechi7qE0J6nWjdNxKQIsBnAr7/uXzdLfMLmihVPPxwJ?=
 =?us-ascii?Q?xuRPFJK31LrBhwEHy87zUKiUJooO/D4nBkMlwzeMXhWa61BMseJh7T9zSpNc?=
 =?us-ascii?Q?v216J+V+eLDtOajuPp8cTyVi2LLWGpy3xqm06/VVnHgKlFCbQ21zyJeLVrmW?=
 =?us-ascii?Q?BL+GmExgBN4Kn/p2d8B3gBOTY3EDoX5AMhsh7rvp+WYa84bGOjiU3Lv32uEJ?=
 =?us-ascii?Q?zLjrvdu6lJ4XJ0WM6iLGVU3+UzgZWsctEnFqhJXQVNNPaMdqyQVR/n13ClOf?=
 =?us-ascii?Q?ThcXkhMi9o1J2In72UezeniN53T1l3o+BxamAtwQwwBZd6M0t0JD+lVPsWVM?=
 =?us-ascii?Q?CTJbyowwPJbZaCg/BnuJkHxGy6IjPGcyvRGuDr57/LElDni1aieOmZNp7ja9?=
 =?us-ascii?Q?VCpm1u4VAQcHapKXpWpcyqA1XrX5Alo7uTCXnVruY3tB95gf9gYqKh0x6VY3?=
 =?us-ascii?Q?yArYMEfGJW3o+Mj5NfVoww+5yVw9s98QGTPBy47ShLZWoCPcZ6pZAr6RdLRf?=
 =?us-ascii?Q?XXYCJRN8mio5euvRXktbrfDZlML4f88/MTZp5eQzQVts2bnmAOf517QGsyg2?=
 =?us-ascii?Q?76GmeDOLRAuC7zApFj03AG7YlSDhER+RkAuRM3iA0D6jTZM4Y2w/ubZu6GkZ?=
 =?us-ascii?Q?zagKnO5MEyD7jJ6+AWN7nbbZnGM5Zz2NrO7Ai9nwoueg3q9211IDXhh51s3s?=
 =?us-ascii?Q?x8poh2Co/dFCPRxmEIZPaVKTlYuyv4T+FuZHE6z/z4oJSC3n41jBdAQvBgGV?=
 =?us-ascii?Q?V1v0dRa/TxT+GkluR08PJMMsgkJBIrqmOy+1k2lbzMXkrEq4/ys0UHLzoVVX?=
 =?us-ascii?Q?8s0QwSG44FLDrRtzyec0vp1kGlqLff+Asdx7uZZiy5sqG/5NH7Hu19mJ17GD?=
 =?us-ascii?Q?DisT1v+V2FYV0GL9N3ZQjpVBRGPn9CdHEcZSY3lKSEr2ESHna4Bo3zSPnInA?=
 =?us-ascii?Q?g/uMPsYqJkxm1MMAYyBOk7SOQ/OADC+ZNu+qoYhJr1at11uRDTGlrLX9m4Zk?=
 =?us-ascii?Q?9P2mGlIccfN+JBGqWEvAJdJ98XvfrpgsOWa4qeb16BMkWhFAgiIxV47uCFiB?=
 =?us-ascii?Q?MlUBPGPzkBBxEQ5Bvx56pCYPdNih3QOZq9zl/9dglfAe0oOln2YBhbHbT1IJ?=
 =?us-ascii?Q?zZ9TkjrqlZxJZGbFsFs4kvRL7pwD/rRHFDEhwvDMtE+fKd62cwb2EJc+QYne?=
 =?us-ascii?Q?m5auOiloqSTkLy+dI1FUhrPg+Rrp6RfryhrhKZ3GrhpsRh4u9DV5oJi1GefH?=
 =?us-ascii?Q?mCCbiWlViAJpnUAjjOcP8e+EvkxFldd+KOthIbjHjcyOoctAe/WLaj51nSaP?=
 =?us-ascii?Q?13rVC5KBsJmVWgoc7lwuaqZyWSUkJGXicDTow+8Rb7ZgX4O0JsaisyxU+v78?=
 =?us-ascii?Q?RdpgdtocVOQrC6VQemnkXBYm3S1mfPpslXBtbyIctQMQQ1/uaSAh1Tgit2lS?=
 =?us-ascii?Q?dGI3QfJ74J/zMmXN1XwIqlfk5GHxE5n7dldC6FVXYkU4H0Xtt29MFDn2eDIb?=
 =?us-ascii?Q?pRwGMm5MM0VCcAfnnnWs5XioDcDDYs/rT/GkXDENppg5TKH6fjyd86A624/V?=
 =?us-ascii?Q?6dUQ2ewo5bdviV4JcSekwblHm8FAFE1xCAEi7hg7bZ3GU+ONI3Jo8bAd82uj?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fa0f87-33c7-4dd9-b573-08dd7163225f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 21:21:15.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaE6PojPF+y/L9QOY/6CFDgsLbwN0IHok+W/D8+inLslBZRMBQtC8LN8+vs6LvDK8AOP8NC9fFL5IMEZWqVwOiS25hbnqLv6l9qzxPXIzQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8217
X-OriginatorOrg: intel.com

Rakie Kim wrote:
> Memory leaks occurred when removing sysfs attributes for weighted
> interleave. Improper kobject deallocation led to unreleased memory
> when initialization failed or when nodes were removed.
> 
> This patch resolves the issue by replacing unnecessary `kfree()`
> calls with `kobject_put()`, ensuring proper cleanup and preventing
> memory leaks.
> 
> By correctly using `kobject_put()`, the release function now
> properly deallocates memory without causing resource leaks,
> thereby improving system stability.
> 
> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 61 +++++++++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index bbaadbeeb291..5950d5d5b85e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3448,7 +3448,9 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
>  
>  	for (i = 0; i < nr_node_ids; i++)
>  		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> -	kobject_put(wi_kobj);
> +
> +	kfree(node_attrs);
> +	kfree(wi_kobj);
>  }
>  
>  static const struct kobj_type wi_ktype = {
> @@ -3494,15 +3496,22 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  	struct kobject *wi_kobj;
>  	int nid, err;
>  
> -	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> -	if (!wi_kobj)
> +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> +			     GFP_KERNEL);
> +	if (!node_attrs)
>  		return -ENOMEM;
>  
> +	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> +	if (!wi_kobj) {
> +		err = -ENOMEM;
> +		goto node_out;
> +	}
> +
>  	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
>  				   "weighted_interleave");

It would be nice if this could take advantage of scope-based cleanup to
avoid the new gotos. It would need a new:

DEFINE_FREE(kobject_put, struct kobject *, if (!IS_ERR_OR_NULL(_T)) kobject_put(_T))

...and a wrapper around kobject_init_and_add() to support auto cleanup:

struct kobject *kobject_init_and_add_or_errptr(struct kobject *kobj)
{
	int err = kobject_init_and_add(kobj...);

	if (err)
		return ERR_PTR(err);
	return kobj;
}

With those then you could do:

struct kobject *wi_kobj __free(kfree) = kzalloc(sizeof(struct kobject), GFP_KERNEL);
struct kobject *kobj __free(kobject_put) = kobject_init_and_add_or_errptr(no_free_ptr(wi_kobj), ...)

Otherwise, the patch does look good to me as is, but it seems like an
opportunity for further cleanups that might also help other
kobject_init_and_add() code paths.
