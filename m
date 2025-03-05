Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531824BC1D;
	Wed,  5 Mar 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187397; cv=fail; b=DeUb2G6hQLUrYXTE+nJOuKetuR5bXWAfONiBtB0wHvgSwOSCxpjGByMwDMsSjZH4zWBOIqcLjEXMUvebvSIqxQdHrj/IP8d+L+HqBwaJCgKfjp9teEYTeCKAJ9Pvhl9ZsE4yWxxIkNjbuudnX5y4sRGiQdsm0gOtwJxo6PM5KvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187397; c=relaxed/simple;
	bh=hIj6rezoC63/GCPekDq9k/0oWS7L458VbBOOKjRINVY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IjnloArGsEpCGYSp3scqcgQELtBmDVj0piLJx91i41OXgLjwvx+KUjxL0hwDG3EpHY0a1hOcuyqsjUQsl8SHQuBfasX/D6KoWafQ/W7ThJnqoHzifGrrQTDNWDCx+s5bvV9+0Uf/4oKIArPaxgNMD+H1n21LokPbfb1vCJBH2WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFXa3ow4; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFXa3ow4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741187396; x=1772723396;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hIj6rezoC63/GCPekDq9k/0oWS7L458VbBOOKjRINVY=;
  b=AFXa3ow44CYr6kN3LjeP6lI2kTUlkmFAVKsAngw/VgY6au7QVX7mHYT9
   EzK+6xkkV1GRkuLwIxrm9ROvT9Lxf5MKoKCCX4ixxC/V+NE3NChdIGQ3l
   xAUoJ3su1X1CrUuBl73he/35iLo2s1Cr1iB0bn9Z8yY3O4yhhfUmz7CGI
   51xj7mEhxtIsVOz4eBCtdaNBlhBE3Caf94UT+V7+kL9B75ja/79JXtJ4Z
   /x5ny8wcF3iQNWwUqV4zAshcLmkxNeKyy1IoEoNpcelsf7PYST+5zRaEt
   R92hUmgnpsDJPpZK17FMxev/Au2FYJYJG0YkNFTiKxuFJ1v6rL5uzPsq7
   g==;
X-CSE-ConnectionGUID: vUJABAFTQ6i1MxBWfkUasA==
X-CSE-MsgGUID: 7ugeguE/R02Jd602XMdBmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52797561"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="52797561"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:09:55 -0800
X-CSE-ConnectionGUID: oSU9VAXASri6bXjUhUam5Q==
X-CSE-MsgGUID: hO39ux7/R12sAw40deLOcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123815377"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:09:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 07:09:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 07:09:48 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 07:09:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/l+sqYpdyzQ3PkKzDCtD3KPRzXIa7SNnw2WNx5NCalt/c7KmMX0eb8C7Jcx5tHd9/z0LsMIFZ03XQGo5xmFr4ceYL+fRCisIO2JV5/3dFOrhWPwqrcHccYMjUPcodZwzB2NKHw2UY6XGkah6qzHafyhJbeULGA+usg1ahfJCSbIUx2meFJD10DaNKq9o7H64bTSlxdohME+Npt681Qo8WJ+jBosNLJwJxkDPkvz50uQvN12nSCUdFIENEjzdVUFucKmiKViZvGZaJJcfMbpj75EPSCiKNh/+jGC1jDJHlbXG5r2BM8tCnnGN3FnTT6sN6/XLPz5/XpwUlGVAc7syQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buVapQgpO3hFADty0Tb8XbkuKIm8D0wR/pAoVhY346E=;
 b=KKDL/aTAZYzGYyoSDoYLbou0GFzJFO9yT2/2Gr4CJxFglbDMWEWPwHNIh46Tc4wrybT67wsg/P1LPLLOVjNXJfapzXJQI1yjwZCrwg0X0NHZz29U0MLsutSS869K3o9yjgWu46E/WRhyvYbk8G+pXLK0glV0BZ/4FAPFw5S0OJ3kqj4wV2RMHhTXFepG3mndknJI09dUkd1A9E7Zpy9TW7KvnAI7S/D652ZGWWoEGq7rmr3dU2mj5hS9RruNho8R4CN+0XGQA3fBq6+A4aa7XL94xSjfsBEgZtgm3U+4Hn2fpAEUTMpmQIDcnYouuhwvE5ybK9OZzTNf/sG7ks7Q2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6491.namprd11.prod.outlook.com (2603:10b6:208:3a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 15:09:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 15:09:46 +0000
Date: Wed, 5 Mar 2025 09:09:52 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>, Robert Richter
	<rrichter@amd.com>
Subject: Re: [PATCH 1/2] cxl/pci: Ignore downstream ports with duplicate port
 IDs
Message-ID: <67c869403a7d7_77ff42941b@iweiny-mobl.notmuch>
References: <20250305100123.3077031-1-rrichter@amd.com>
 <20250305100123.3077031-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305100123.3077031-2-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d337ff-7bf3-4f68-ee62-08dd5bf7c3d1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IownbLAN6fu8Mz4GPGpW7IPAPV21BqSWUgQ8OiKdtxLoIS30wL+GpMzLD7/7?=
 =?us-ascii?Q?5QNiS9keV4ii2nV/S36i8ZjSenFf2uB4WUGiFQ9BG1mbUFeN5Z/JFSkwpqGw?=
 =?us-ascii?Q?Bf0oPqU0njmmjE3xwl5sKfia5VTHLfyuzuEUonMZiDiiuuPRUIman6SdubKK?=
 =?us-ascii?Q?4ttWaZhBznn5nRDvJGm3aEZsndJKBRRV98U8lXBNz22RizsjRoCsENdGUpnr?=
 =?us-ascii?Q?s5itW8bpFP8Pb5HFy6w7K/ZU55JjestXvkh9l3Jip0i3RWJ41izYDT6Gke8n?=
 =?us-ascii?Q?H7yPnjLjDmWvyBZn3gxb73XU3534vNnHz6RrdmDHa0tG0olUQynXznJESMaQ?=
 =?us-ascii?Q?HwLd4/ZBkCPTGq6L2gB7fB7H/cqWhCcZO2i+DtqxSkp4uJpwxfv9vSrWdoMD?=
 =?us-ascii?Q?f+0lbHmeTVhjW1iYKbnjLPFbGdGq98nSzSRZN3QBjhwG+x0sB9ZQRgjUSG49?=
 =?us-ascii?Q?lrLT5iWVMSBvkXuQ2wmP/1I2BWO/XHun/Gp5VZij7oMXpCiu/s0SSc/2eyLZ?=
 =?us-ascii?Q?+HNybJurgbaopnVAMpbvU5Y9Lr1PI/ZGUwsHPkFIQjep+tvP1nSRQQcudH5B?=
 =?us-ascii?Q?Nv++mRAHOdYFma2FM0LjaH/y+BI09jUqoHPE3kqpF9P9xnQ1YfAxXnstJidO?=
 =?us-ascii?Q?d8o/2OaxYTo2bT/IIcYyY3NqYmuy4GqXotvBVqIQ6P5LaRuh4WoXQ6wb6R6/?=
 =?us-ascii?Q?ArwHNrQN3TfiHDoTZauW1T2Ji0R+uVcSWeHz2MS3hzPtWQE6VB/i9Xh1Kn/H?=
 =?us-ascii?Q?BM+3hFHjyIYMNbfMYZ6Qy0xB3xfvF0Fcrqo8R4/5B+pyNi66a8roP+5M93cT?=
 =?us-ascii?Q?CGsKh0w859qhLCg6TXpgyIlFIaZeddDnYh08BYNhvDzx4qAjHxU9lo9tF/bb?=
 =?us-ascii?Q?p/RPfo3r4QYYirfu2QETdqj07EXjUSFsQiDLfjYhh39mdRAMSzs5aV5H/yEQ?=
 =?us-ascii?Q?J8/BhELd2cJxtbVqi4Qz+rlmwhH2vxj9GAipgq4g812OkAXIAe6GEx9RyRgJ?=
 =?us-ascii?Q?5j8XGSp9cswuz1Fu6KSX1EWDOPPN3TlmBIreEvt/xJiJfNG0IdJj0STrd3zs?=
 =?us-ascii?Q?G8JPSqjuGoSlNn5/trmbcQQE/+qCyR/bP2HUKlEwXG3T/JclXZTDZBnnIS6W?=
 =?us-ascii?Q?AP1NTqhyBPlRBm5fEFpmN5h5wGcjdA2cfMZr1Gw/IqiBkK0JfrxHs8Y8SHL+?=
 =?us-ascii?Q?UdqaMuIUPzvnQiV2VIhPzJy30GtmO1px++FFgfnak9+IOkGBtEvBRwEyk7gW?=
 =?us-ascii?Q?ODCsba57/l69XLopeA1uXfKx8UiQgbhHnizw9EZ38ZsEZ3Djl8xrQnkjAUc/?=
 =?us-ascii?Q?NuLRW4nqKktj18X4cbmS+XRaYdnZY0AnKWxX8sle2E2TgaLDbNuGRJjtwzQc?=
 =?us-ascii?Q?h4rRWaXdaNHfqRZhNKOH7bUHkhOQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQe0KPEmxjxVxIBMCqCJd5hj7+/8AnCcIRARb/YXLW2YoePowKln05kTLdjk?=
 =?us-ascii?Q?a84HfhtprX1j5YdWPHYe6j+Qw6XSFZ/RE+xYiSbpH7lcy/LiGV5arQQSW1ZU?=
 =?us-ascii?Q?OSi18tIe3Gr0Hasf3F2yL+WtzVUNPJKSs9PQ6lj8Ka4fd+Ejxasb/mWcgtyW?=
 =?us-ascii?Q?iQ7v69pLR52KI4gsqj2IuXBH7/uRyZsvuYmyEZN5OkHEDdTCWXBqaGZIpED2?=
 =?us-ascii?Q?5ytC03qlxdAf+VEGVHLJxhzBdN0D5v9OvaZpXaBYb7PXBmkB+lmUpDR0I0Lw?=
 =?us-ascii?Q?i7zkbp+g9Z953MEp6Q1/NdfBD8jc6GhqJXNEFuqCr2EXhDChi3vp82pZJQuB?=
 =?us-ascii?Q?DIMTw5d71qGZHX700Daje6InipFNpYYtHe/HOODqoYUVLQbuHfNxxtlY9oDy?=
 =?us-ascii?Q?sDOHOrkg+WWGFH9nbNJRmudN8Vld/sSzOEs8M687Cw69OVd0J7XX5Aw6LYdS?=
 =?us-ascii?Q?Zq8M2rVeONTb3Ib0IrZLqosOvSes/fPaIwyscRZKPBVBuYjYilZuzD+nuE+M?=
 =?us-ascii?Q?EiVovTksrcDybnI6OFkKRKOCfzJzhaHrDAxJ/XbixEYnacARYDK9PL2snOVe?=
 =?us-ascii?Q?rI1gnLn6HNMB/zvo+PomIpNzhjDeGYmWt9jNZltUFH46we+IEaKqwSsv/oLE?=
 =?us-ascii?Q?ZVY46rY4syYOsYhOqYZue/TdiPea8abZ/pnRUSnUjis4b0a2CTd5tymi0xxP?=
 =?us-ascii?Q?xGLk9sIE+9J+cicgui0bB2oXNBIeijIctcGGLtlNS5QXmiiRpqWcrc/0zyKo?=
 =?us-ascii?Q?eYZt8NwrkAJy4Kz8NkV98pBJtHLV221jRMtTXCITNEOzC1ycLh0tSG0Zbncn?=
 =?us-ascii?Q?CO2EKqIJiB9XhZoU3WZH8tvMiyJf/p5ZvSID7WkELeIQxUnp+ANf2zh20pSZ?=
 =?us-ascii?Q?xnsqtIZo7Gsu8BVgGMDyppaHRQPSn4eGb/9cY+Gb+daBPtwvMrDVHycOGuFY?=
 =?us-ascii?Q?AAVo/U8o5iatEKwl4PGJitIm12KArXYINIxEW/rrTg8RukYvQ4iNTNH33G4J?=
 =?us-ascii?Q?olkURES2+ys8ko94+dkpA76Ds4y7b8B+7VC1iWKO6g+mVXmX9ogyMlNQbDrJ?=
 =?us-ascii?Q?XXjArETahg6sCRt+2CIVruyBAFrmjRr/gzUifyVXwR3jWBaQI3b761Evughn?=
 =?us-ascii?Q?kGKcMLraiAKcwfvRIg/VdBhwYfsga2HDCCnxc1sHCCgTZofrbNH/BC2JE0yD?=
 =?us-ascii?Q?lnxkT6yowWWFM2jcmXqQbu6eLshEf7Ymos37csGYs1INlqjTRuFBTBQN2pya?=
 =?us-ascii?Q?d9Saj0J545FOKt5gfoSgvUsoTKsPT/QWlNf9amFeJUV7bvu83yh9EW9HU9UM?=
 =?us-ascii?Q?1kEbi55rAh0cpWXIYN+izsJAa/4ZClwnvi9YtxkglRlKkkle7tWdzBrUZm84?=
 =?us-ascii?Q?Tjvf+3KSo+BbW0lLbssmjoVYH1Crvn2XtPLttyL5Ju/C1y2uKraVfcG5vvkt?=
 =?us-ascii?Q?RTJ8Q5BGgNIxF0HmGonOGqNUXuDBm8LIKyQtFHtsa0t8QiDs81v/qkIe8xpF?=
 =?us-ascii?Q?E1JvXvmNlmCTW7d2rrEqg3btMcijt7qMbZ8zRfyfYqMX878f0zXMJxInV76g?=
 =?us-ascii?Q?SjKQ0ZjIjtloaR6BT8qVXqpZ/t+paCrm4fZUBVar?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d337ff-7bf3-4f68-ee62-08dd5bf7c3d1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:09:45.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVi50nllOQHIZqBhQ5dLMtvhlJ6zFkvCy9ef/F55Oaih/qpAtUj1HYWEmavUxS+9IO0zJicqmawr1d2uMdqwBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6491
X-OriginatorOrg: intel.com

Robert Richter wrote:
> If a link is inactive, the port ID in the PCIe Link Capability
> Register of a downstream port may not be assigned yet. Another
> downstream port with an inactive link on the same Downstream Switch
> Port may have the same port ID.

Is it possible that an active link would have the same ID?

I'm not clear why failing with a duplicate port ID is a bad thing.

>
> In this case the port enumeration of
> the root or downstream port fails due to duplicate port IDs
> (devm_cxl_port_enumerate_dports()/add_dport()).
> 
> Relax the check and just ignore downstream ports with duplicate port
> IDs.

Ah.  So do not add the dport...

It may not matter but I __think__ this adds a subtle memory leak where the
dport object is allocated, not added to the xarray, and upon the port
being probed later a new dport object is allocated in it's place.  That
might be ok as the memory will be recovered when the switch device is
destroyed (via devm).  But could a series of unplug/hotplugs cause issues?

Ira

>
> Do not fail and continue to enumerate all downstream ports of a
> CXL Root Port or CXL Switch. Turn the related dev_err() messages into
> a dev_dbg().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c  | 10 ++++++++--
>  drivers/cxl/core/port.c |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index fbc50b1156b8..524b8749cc0b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -59,8 +59,14 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
>  	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
>  	if (IS_ERR(dport)) {
> -		ctx->error = PTR_ERR(dport);
> -		return PTR_ERR(dport);
> +		rc = PTR_ERR(dport);
> +		if (rc == -EBUSY) {
> +			dev_dbg(&port->dev, "failed to add dport %s, continuing\n",
> +				dev_name(&pdev->dev));
> +			return 0;
> +		}
> +		ctx->error = rc;
> +		return rc;
>  	}
>  	ctx->count++;
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 33607301c5d3..8038cbeffbf7 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1071,7 +1071,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>  	device_lock_assert(&port->dev);
>  	dup = find_dport(port, dport->port_id);
>  	if (dup) {
> -		dev_err(&port->dev,
> +		dev_dbg(&port->dev,
>  			"unable to add dport%d-%s non-unique port id (%s)\n",
>  			dport->port_id, dev_name(dport->dport_dev),
>  			dev_name(dup->dport_dev));
> -- 
> 2.39.5
> 


