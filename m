Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9321B192
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053876; cv=fail; b=S7o1oWTggOzPWNdFBknFIqeNhbmnwx//eIRJBTHTHGWwhvL1snIWBXdQmf+fPJl8aq+HswD18NhxwGawDalgE1qiyUmPhwv5QubwDRyebkXPZsYKaOGmPUDpl3jTmxX0QGVqnCygcquBbCFkCwi7sn/x8+eAlLOWSxZogE1+O9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053876; c=relaxed/simple;
	bh=kkzJB+5ID+Y5hgT+8ugp1RwPPLw1T2mD2l2abVB0PaI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BBchD2iAh0HDWhwFhZl4/TvUewDpeJEWnxyKvl1ImhwLMT5bazwWftbJfOxl3E0RaLs82fpQv+MpQqUSFlP2vmVF49e/alYcwwHtpudRsP64wHFtp1VX1Sk+8opNEbsyCGJ8WI8VCOFEMpiAP+7M/6DL+l3v02cHyOePetsnYXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPAXR4B/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPAXR4B/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772053876; x=1803589876;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kkzJB+5ID+Y5hgT+8ugp1RwPPLw1T2mD2l2abVB0PaI=;
  b=cPAXR4B/sBLWeFmDFOoNA5+oSJZB49Qb3Avn55tZ3XJzqC9duG4QtLf3
   4ym6f2dRZ3WeE66pHhgDNOIvdDuArKt1dx4JcRp9hVsOpFN0XzkELNVly
   9AR8C2eXXxtUWn3pkanYsAX+sc7setwWEl6a30BPCviFN3USEYu6WMMNV
   /5yQ1zQ3lpTLdr5udNHNp2oizbL2o90ryt5r0k6yxUIpUdR/haW+lof42
   1mpsT7RviT5kYNs6syfHH9wgqu3jMe38594Wa9vcWrLW1PwIjlGgTbZfj
   b8NezgN/ZsVfa8Uz8k1tKPPzlOnlXVaolaO1C7F/I2VsikHGczu5uNKLH
   Q==;
X-CSE-ConnectionGUID: e8twb6v/T4Kt1ZfBEVp2rA==
X-CSE-MsgGUID: psdAWRLQSx2asvDpIjrNYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73150668"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73150668"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:11:15 -0800
X-CSE-ConnectionGUID: bJYF6+3yROaBlGrOQLJFuQ==
X-CSE-MsgGUID: 5o7OO5rXQrOl4Er7dW5pSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="239349243"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:11:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 13:11:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 13:11:13 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 13:11:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxlLHr4yz21ki6XfC+456Jiagbozr0+mtyT3rkKyg7nCbFnW6QcpcWsfJFiLdu8KoiTlV4Rfhifutv4ndaziHIt6ISYPSqZh1tr4Hnep52MHxaF+7V9SQz96bU+v8BRoaa8iL6WIR/vbLsDLZTN+Kus0qWarpBUX63QqFG5khh15mPIWKt87b5sTcTrXHO8RmUs4CYdAFMa79BbzLOE+KYzfKmMDHy6DDJMxOeJX95+JrCQCWpYDfD/jn78h+Gk177BsjQkOTCQ+gJGl6Ronnxsy3I0CvXm9dlfnGwAiJw57QCohcci2v9Vi4pi2TRRwwX3oLBfC1iV/oPo9Uf+4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IHnV10Uh6XZNm0TlamnMTZJItTt3on8lDUmDzGvh28=;
 b=Ero+q58XNpDBSqVaVoBwYXQ0vQ3956Su/AGJcBS0BcuLsGYwTw/LRjmfGZDoxNuU3PSqYqAL7vXn9cf+k6qaECsfQWj++HMZBwuVUD8aP+h1xqKlrIuQZkFhrHt3SJ5ioP6YlYbMPa34yvl5L/Pnztd7+SytuPz/1ca7o0M8TLQRlSdai3Ejhnw+U8ajKDFJyLVshDKJnBx2qSjooNtycXcvRclsvmTr2CCINyx1MPU4ghzKBot/2jZ33J1WnMP/C57wAocMVQroK7ZGJVKiTnsL2KIpsuHWcnb+KD9Auz/j646N8gsplyQfT5TP/ZWbFUuJt7s0kGoYOyGFKphgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB9477.namprd11.prod.outlook.com (2603:10b6:8:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 21:11:11 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:11:11 +0000
Date: Wed, 25 Feb 2026 13:11:01 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
Message-ID: <aZ9lZfQ-YThgB77i@aschofie-mobl2.lan>
References: <20260224184120.1680624-1-alison.schofield@intel.com>
 <699e0136f09f0_1cc5100e3@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <699e0136f09f0_1cc5100e3@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c345f3-5297-4351-ded7-08de74b26692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: WfkKT7DTbiXqiDPdlThSSds9JzQMqUjd/Hu9RSIIQVzqvnoULZf+sz4l3aTUOQlRMUKQc+sN2lQQNTEz4kInrurRc/8d+mhmE0rqaiVSx6W2utbsLkVIzn2y6Nj0nt9F4Mn64XekbwSDSjrLPxJaI5u1zDauTdN00jvhvUwvz6C3dAdEvdfKbQRfTJfv7QojH9kGthFYA08G1gRjEkvlLUwzVt5OaN1+6h9Gm1ln0yuqCPkjUKOZxlpZIugNWqtSODsxxirHFuKC+4nDFvDu46dD7tUebKBXOG75MfkfKYmN+7DDbj1rIuWqddEfYxJ5PLdQGV7537Te4DR3I6OZmMcZlb+7Diwx/gpNuiaPnCkLRVBgLZ7ypGs5TUghLRdR9kkus6M6BxO3WBxLAptQR94PVQu3kDr0RU9CBV6UL8SCgkpBKJf2L3xxS6oD3LLxr3t6KOYlo2lxzM86yjNHU3dUTXi+x2vvV9f70J1i2rDkjtTEaTl7Dqmyl5VtYZkoFe9ZSpv5kVgVqmYwqyDgEZYFcLK3dBkVjr14VohjwftYplPDuTX3VY9dTAvvUoJvOZD6E66Lo2C8aLWJYq2JKHItRfOvmx6UXh5200JKbeUbkHlQiY1AeByLUeIi1r13JU6ucY90YbDEnbUgH/URvGOnUyRuUs8Q7v2M42qhA0bMPnPtwleX9wwuLBZD/L3NA2MvVUs8sc2kcufikH8aqMU+wWm8OgKdXO225NG/Y9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mhtTGdBJWhtG2ggyGe/9nAN1almlUOfSJM8P/Yo1/dM+CAtq7tFNP3fk5URq?=
 =?us-ascii?Q?FExLPt7Z+WwkPRCQsjwQTWGuPVMhtTxfqmxWfYQeMs2nZtqd+i7jrIzYG3YU?=
 =?us-ascii?Q?L853JXXtgiJHS5JeA7x4FpZkN4pl7evw7BNnWAfbLIIJxvX0IeOj2BmhwsKR?=
 =?us-ascii?Q?HQSEmN2/cjqafI3roTky9mS1w7TO4VAqkLSEGEMCqp9kFtvrZRtRvr6aCnkn?=
 =?us-ascii?Q?a885Y40EIgNVrkY3nBkmDbc1cv4zfdCsl/qemasKbFihSn1H3ua27ENiX7eX?=
 =?us-ascii?Q?yEHlb9BvrAH1UjhjszyLBPCaGwqqGFfJtt9SCqGzE/c9MEAZj04BFD8fIDd6?=
 =?us-ascii?Q?pnavQTQ4lgK0KtyuSsABbJsvaNpOxAgYNvGL19WutC4xXQKQTPHE1OBQtM7Y?=
 =?us-ascii?Q?KL4ugHm+/HLvI+ahdaBXYIjuaw7cUvh9nBfOWsO+Pspd9Xfj4J4xWEZR8kTX?=
 =?us-ascii?Q?aC2a9WMfR5qCaajteJF15gHqVRVCQb5xcInkQN3hZwxLgwmlUWQa0M3AzGez?=
 =?us-ascii?Q?eHDP5AyqJfwg3fwu9A9+MjB/gRhSWqMNcy9lEauIYFPMlytj9Yhn8o2Py2s7?=
 =?us-ascii?Q?Ig9GXmXcT0yu6aejH/geJzoa5ZfkpkcOiEdagMmZ13xpjEVs+HMJZZjfaRYT?=
 =?us-ascii?Q?S7qNQOrklyYoPKyrYMj9yoa73d+ubnb5CeHV0j3c2f2zmi8KSc7DLKhLS2kf?=
 =?us-ascii?Q?Dvw04HMdv09PnJweQhZ1vwx98+4omooanQ9ljZjnAn2b1k84NtpzMCz5+RuY?=
 =?us-ascii?Q?XWh02JFzFuBGnOr/wn+euLCxrSiErk3rsOOsHTVF0rPAbXqki/Ejpu9DFpaC?=
 =?us-ascii?Q?4IJgisDkRamvGienbljxCC+MZ1zFV6U0z5vDPTD0bTvjAystosrFpxmnMBqS?=
 =?us-ascii?Q?jfACxO6EpIQ7VIcAM9Q7Y7aRUUIReJirAP++m3bTAz2NkrKJ/Z/7T6pj8nbm?=
 =?us-ascii?Q?op/X8eJKewlYL+pwCWmOGxM0wdxj+zv9Le4bbYnS50EfMY6C5AOBgyVQhpqa?=
 =?us-ascii?Q?nntvTFVUYvwnWsP41gD1/611WMv3RjzOIaBbHMgKokvEl8kVs+dwW3dDA2Jd?=
 =?us-ascii?Q?qRctGRznmlFAnPIQfiJDYnguxwNp6p0RK4WU3aPdAe1WHvLRRfIw63+A0NMQ?=
 =?us-ascii?Q?Sx/sFlhS9RBi+/jtvCYz2ks/UK0/LMYp186espNeFhxjd9baF5EV03t0x9E4?=
 =?us-ascii?Q?IuzAzH8cnYSR9M5j0mcybCeIKcalLl01GhsibMxJfSHGsxdwAOVNgqy2uouX?=
 =?us-ascii?Q?1CfaKJTMV335W2k09bphUl2Dbe/RToSXhMh8Adlx5ihSiiS/Vsgzda9etnYQ?=
 =?us-ascii?Q?iXYRQRRFsHE+8QFYIadyezwAdJe7xiVqbay2WRdyMU8KhpU/moKjiuu4vyOA?=
 =?us-ascii?Q?yoidh5VgoKDeO64/FqhXXBmkjIY17V5MiTWc/EyLxD+TqPAQFKvVAeb1d8JZ?=
 =?us-ascii?Q?9peblf5B567rdmjQKafQMjkPCg1/VbroNXp4r6dE5Jewqz0+gFATRDYg4x0K?=
 =?us-ascii?Q?TX5jVn/DM0MNlJl4kWfY4Ce3g3UtVNOVmLsD7YeeXqJHsPqFWFPcue8bQekx?=
 =?us-ascii?Q?hcpG3uE2mNOqGNYeSB566b9B37uXCf/NQxyDsupZAslAUFDQsVo5HBZQcGzg?=
 =?us-ascii?Q?4FVuSHn63z/57bh5QStrf930A5YUrOjUr5uUQMXpqI4d11LZrNgZ5z/DUf3+?=
 =?us-ascii?Q?Cuoo1wKnuUAjMPl/zdInYfERyzM6hoUM5969eYEdPUO8ol9jFSw8wbdPtldd?=
 =?us-ascii?Q?/DnEerGn3pTYwtwi2+VM/ydX3FPQd+E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c345f3-5297-4351-ded7-08de74b26692
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:11:10.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuiqLHXPJS+9zII6H03tvLWcF8hkpdgLFndguIHYRkJ64SKeUEF4O0HIpWqqG1WC+RSvSkZzCrlt38sN4IJnMxDHk/TWtLvKQZH5CTLY1RQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9477
X-OriginatorOrg: intel.com

On Tue, Feb 24, 2026 at 11:51:18AM -0800, Dan Williams wrote:
> Alison Schofield wrote:
> > cxl_detach_ep() is called during bottom-up removal when all CXL memory
> > devices beneath a switch port have been removed. For each port in the
> > hierarchy it locks both the port and its parent, removes the endpoint,
> > and if the port is now empty, marks it dead and unregisters the port
> > by calling delete_switch_port(). There are two places during this work
> > where the parent_port may be used after freeing:
> > 
> > First, a concurrent detach may have already processed a port by the
> > time a second worker finds it via bus_find_device(). Without pinning
> > parent_port, it may already be freed when we discover port->dead and
> > attempt to unlock the parent_port. In a production kernel that's a
> > silent memory corruption, with lock debug, it looks like this:
> > 
> > []DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
> > []WARNING: kernel/locking/mutex.c:949 at __mutex_unlock_slowpath+0x1ee/0x310
> > []Call Trace:
> > []mutex_unlock+0xd/0x20
> > []cxl_detach_ep+0x180/0x400 [cxl_core]
> > []devm_action_release+0x10/0x20
> > []devres_release_all+0xa8/0xe0
> > []device_unbind_cleanup+0xd/0xa0
> > []really_probe+0x1a6/0x3e0
> > 
> > Fix this first case by adding a check for port->dead after acquiring
> > both locks. Unlock and release the parent reference before continuing.
> > 
> > Second, delete_switch_port() releases three devm actions registered
> > against parent_port. The last of those is unregister_port() and it
> > calls device_unregister() on the child port, which can cascade. If
> > parent_port is now also empty the device core may unregister and free
> > it too. So by the time delete_switch_port() returns, parent_port may
> > be free, and the subsequent device_unlock(&parent_port->dev) operates
> > on freed memory. The kernel log looks same as above, with a different
> > offset in cxl_detach_ep().
> > 
> > Fix this second issue by taking an extra reference on parent_port
> > before locking it, preventing the memory from being freed across
> > delete_switch_port(). Release it after device_unlock().
> > 
> > These easily reproduce with a reload of cxl_acpi in QEMU environment
> > with CXL devices present.
> 
> The analysis looks correct, but I worry this fix is too tightly scoped
> to this one problematic path.  Just make the rule be that parent ports
> have an elevated reference until child release rather than child
> unregister.
> 
> This would be a similar semantic to what happens for regions where
> cxl_region_alloc() takes a reference on the root decoder, and
> cxl_region_release() drops it.

Thanks for the review! I've removed the work in the detach path and
now refs are taken/released at port alloc/release. I wasn't sure that
would make dead ports in cxl_detach_ep go away entirely, but it seems
to have cleaned up the unregister cascade and already dead ports are
no longer an issue.  New revision WIP.

