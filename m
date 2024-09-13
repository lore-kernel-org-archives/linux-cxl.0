Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365083032A;
	Fri, 13 Sep 2024 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252881; cv=fail; b=k9tZFNZJQvK03FhuMUTx7cXpL/QBeu2LArd9Drw3JrSoeypi5Zu5ZBUi91hmLN8Aei+xk+4RnR+JRRLzAQymsh8g4y2+xGhYcl6nPH/MzYDzliafUbytNHeKj4DQlaB2Uois42v8MZfOplfsMj7HM9VXr4RD14GUHqCeWg3H0eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252881; c=relaxed/simple;
	bh=3E/UBee/hM5bfgmlXOeOgoU5gvSaXQc0Yx1AAGZQhq8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C+pHhAtO/yRfD4amApC/vEC50FOzvKdJjG6m5H4Zvkr6I33N+UlHf8FkmssJn/0Ib4nx30oiuD1LUhq5IW4MJ97JIEQMywYGpIKrymRkIXi+giI2oPHEb/iX5FzQ9gHdG6m9g3r7HDd5YKyKVnLoRBQYiFc7Anw2XNkZy4COpow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jxtn6B5u; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jxtn6B5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726252879; x=1757788879;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3E/UBee/hM5bfgmlXOeOgoU5gvSaXQc0Yx1AAGZQhq8=;
  b=Jxtn6B5um/qQQmm5xHmylN3o0vfnSDRQUjWWn+IVW7VlWWyJ6cM/iq/w
   hqiAUDGPvbagZYgINh7Xd5ZGrjvgQiIR6T++vKyIWs2dkpxVwQPkv6sfT
   70kOOtuaQ6Fu5oLqpIz5aiRYVg1NWyylJa6wtqecRb4Yrfc3suuqEiQjy
   kVey7JPZ4XyznrAr9EcDFgITmxy4NeO8Q8Gyr3DUN7bJv+ZMxDOQ55vmC
   bfINANmXTlcWGtHn6XlE25aF/f3hVF7veNUW72mI5QYYG6I+GCww3aCsh
   RQEM69juMqhM1Jk02je/6QMtEwZFLvfXtnjzXIUjRiKnOCsGorm9JJr6j
   Q==;
X-CSE-ConnectionGUID: BK92+B0cRHODsDHMVq4n/Q==
X-CSE-MsgGUID: fCXoWxdWS8O0vDvLSYmJXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="24650683"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="24650683"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:41:15 -0700
X-CSE-ConnectionGUID: CTTgPOmYQBmvy00NABRxww==
X-CSE-MsgGUID: oneH6Z8aTUy8evO5wla3kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="99005596"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 11:41:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 11:41:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 11:41:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 11:41:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekQsZqZRbQeFiSsWrbzvKkMpgp6VEJccQlwSPTtUp1Khb8TeZQkpScf9+BPnPMsLWaSoPPN7WewHRx8Hb2RblqlvzzhDDTf8KkVrpbnohsD5ms14vEy2bYtfr/eINX8kWx260P6SPLIvQhNMaP1Io6Jctui3+Zk9wzcHV/gPDavh36Pqer02z1YvYbmOTlwTASzj6VAoauxPLNNa88g0smPJoaj16OHA8WavIwzaaXriNvoP4FGup4DuSmKeTKU7IBSF/KTfvHP3fr2vJk4/DO0T75PPjUUAUPVH0iOLyq9OK4uBUVsleBDg6Zm5S6qsFQPbXkL5iSzIJ7QodGPPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3awByt4jXE4e3GfMPYLY5svr76nKplkIpS6QaulgMw=;
 b=zQK3F14pnCz/kHeAfEGTa1U4ZJLAI+FS4r5l6Xb7rMYmZIjbduCV6faBjvgSVwYCe/MZo7qRWk6UAQ7AMaTafbaxuDbJg811WhcLTA3GoVDVAk4dU2GsPLWxO2QPP9XDqjCqL+s5ZcPvZzizYpH9RodWa7AhxOXtreNkZ2RiY/pHLjDq/IKQCdLShj1ei9e1I8/RltZJZ0vCtRBKeqkDg9XEG3UfSy+Wc/6epNLm7Z8hGc/CKCjvidAJWvhnxWd2sG97r97m15axgGrvVkFmiVuwonT0eHtTgnCVav8W9io4JqkquGaWG4hEeOv4O2vWsU4cdVG9Y3bMF9zDPksggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7507.namprd11.prod.outlook.com (2603:10b6:8:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 18:41:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7939.026; Fri, 13 Sep 2024
 18:41:12 +0000
Date: Fri, 13 Sep 2024 13:41:06 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Ying Huang <ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/region: Remove lock from memory notifier callback
Message-ID: <66e48742afe0f_e45da29448@iweiny-mobl.notmuch>
References: <20240904-fix-notifiers-v3-1-576b4e950266@intel.com>
 <20240913141322.000037e0@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240913141322.000037e0@Huawei.com>
X-ClientProxiedBy: MW2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:907:1::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4bedeb-23bc-4246-754d-08dcd423a3e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X4tt2GtGq3825v1CfKWDxoafOOz1RqGPRJW2lFTEDK6x1kbErC0a8TJpQ1vj?=
 =?us-ascii?Q?YIaUassF5jQSXJ5tT/Ch1yck/+xupyduQTwDX6AeAxeiYeTAgtxLwupjf9AY?=
 =?us-ascii?Q?wHYL4A3B6LSPUfeaEP3NA9cwE16KDulI77yYHfsc+ReTPTXFGA7RwsIafw2F?=
 =?us-ascii?Q?o6vpI0Vq247WTOU7qLKzJD0BjfYaEpx2J/x1YNfD3V6XSGGrlu51+jjdaV9+?=
 =?us-ascii?Q?gjUModOmi2Shyq8OhmRg5ZYbrMWuU+Or4zQjh3WwyXhrs8a1BB/Y16hIUSYp?=
 =?us-ascii?Q?mIub6QswAQC/SNi9g47PZBV5Bm1gIulRB4itUu7ELLKVowAlk5B7Wn7+SXIJ?=
 =?us-ascii?Q?jN1tDt3b92Es8Q9htuJy/XwVF9unxlNmtfR7L0WHfgk51+7GBH62WvCFsVdl?=
 =?us-ascii?Q?FwqkGdR3HBFp3nJ2gbCF2994nARuFC7bEAMEJa73wkYbn8fiLj70wGE3P0iL?=
 =?us-ascii?Q?I2FR3t43UVVZa1X72tYbijFRm6eArNW3wYE74qKOvLoOWNmuPWKZcgEpFlLI?=
 =?us-ascii?Q?NTxA3iP/g/mom1ReBqDuxitWjobQUxAmYqQ/IoSeSUJ7VWyVd7EicE0TYcYn?=
 =?us-ascii?Q?Yb2eOrjW1hioA6RlYn6dZ1uUr9g89k74A4L5dVDDDQx+9UIwS5tAoTOAzpUu?=
 =?us-ascii?Q?kaNcRryi4DQ84CBWb3Kp+jETlTvtb2cEq3Xq68ziR+W8Ys2oqZp2TWM9Hh1r?=
 =?us-ascii?Q?ZMw3nkKuOgQqXY1+5MdKO30tDYZOYSxQ3FqBy0TJZYj4xBehYrrS7Qwx3h1V?=
 =?us-ascii?Q?H7D68ghyDid0/Mitg5blE21A89Xl29DcHOji/Br4A56Jidi03rs7E3Xpak7b?=
 =?us-ascii?Q?RwCqnOZCQvChadFgzlunHl+tfs4wo1i63bT+xJvCJ/3SB/tkiZ0VKNmDnFtB?=
 =?us-ascii?Q?SJu4oNZyhYk18tgwJILnlMC11IMyaRJ4rbT/cqJUfeaxhUJWrkQyoOrVXIKw?=
 =?us-ascii?Q?VgkAGa4zu0l1aSTllFlhVnCJhgLUIMGAKlDgXfnbvwCPwjwzpKgkPz3w52f5?=
 =?us-ascii?Q?ZXcsOf7dcF/Q8OJNIBx2A1AV2FfaERVD27mWb7I6msSsdQEhDNHr0xMJLc+j?=
 =?us-ascii?Q?7HcnDSxNycmroWLWGQEl7Bh5J5tKRekTXjdCeL81xDEq62baTa1+rPcq4ysh?=
 =?us-ascii?Q?sFDgIYfW8e3gryf5XTyJIja0p6Xzj/lq6Z2P1Rrad9MnUhvqFrTXxNqPVZeA?=
 =?us-ascii?Q?hPsjwot5ytcfW+4+wfTeP+6y9U3AHsP7WBr6RR+EBlxAVG8AvqHdYXC1eLU/?=
 =?us-ascii?Q?DhecLeUKvLvzxEEve0wLNZ8VI+PeMRbhL6SQWqONRnBZPRwx37Bg0gYdS4Y8?=
 =?us-ascii?Q?X7RFKbOx99jZx+uSOimgklzQJimyF7s6HZ7fBsMnxB1SCw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?su9qldwKnVm4f9yvWtOMw+RGJ0wXFY/jrCn3wvHPRWGrmtNMz6hLwc7tDDUp?=
 =?us-ascii?Q?1EdanfaIWs42jG5zBTZRejARqRr8r+3e3vq+w1O2jKfp2+JsaIFTBzRvObu0?=
 =?us-ascii?Q?54l/tWoLD9WMlRkEbz1cRMpTo33i3MENigkguNy+ZqyQEho/VEpVqZYsvv5u?=
 =?us-ascii?Q?Rd76Qdz4e0McomFH/8bsSigxR+vH94p5g546c6akxJE0yTC87djoW139DTwJ?=
 =?us-ascii?Q?jydFL5/jCG+PaR60H8wab8QUK96Dfc9e0KO7pJoYckThW0RvgTd2KeYLWulI?=
 =?us-ascii?Q?9vO8/G2s+Vt3QEdwsD+GUcnzzs1oSIplpiiMlKMi/unEaCRVCZfTiyV/Gxd3?=
 =?us-ascii?Q?/7QMSpaU5wzUH3P+ccHwqsrMO0G6VU+Xt7tT15l+h+o+mGUZHmanhYnxA5UJ?=
 =?us-ascii?Q?hKYZu1Ti1l2fllek39bInsoNhDlyyEziWpjU0RNw649jxzaB1ijwpM70LB6y?=
 =?us-ascii?Q?SHY4T2d/VrPrDmJUI+x/w8EKs9RqKzrqtAgZ7dgth3fp80G7D3NRWq/Br9KX?=
 =?us-ascii?Q?84XQQp2/zpAYh+7/idjw5Nf/znsQ7WOMlbJjp27jFS2KjOJB+gG8tLkQ+0cO?=
 =?us-ascii?Q?e1GjPJqngaZityM80Jhvq8erL7/3aTQYsxhi+oPJJJEH6UjiztoaFhpSCul6?=
 =?us-ascii?Q?E0rdS69tmoLcIu5iu2KyRj8PZmaxQr64wJTHAawN3hlG5yVsevc3lkgWRjEq?=
 =?us-ascii?Q?hzRIFT5JirJOFNvy19ExeShIdXz9km9YQ2DpBUU7dKayfcgp/FkPQZmpje2T?=
 =?us-ascii?Q?e54NjD+EhAtcQEESah1vl5WmqLUg1o0J0TYIQLazsvJI+yGmt8hW9mTw1e5d?=
 =?us-ascii?Q?8+0Q7e67zsBd/sZ3+PrMzpZldlra82oZRQ64MbYPGmDLZ6CxJH8FzX8SlF7O?=
 =?us-ascii?Q?x0wtzCn9f6Vbwn65RdcpawYUr9M1FWJeyjxXiBV88Km9tWmFSz8ClGXfEz1D?=
 =?us-ascii?Q?pohNjiAhe98fFNCbiSpCk3dX8KdrsVVtEJZb80rcDD8sgStkCtIgmKiajgh+?=
 =?us-ascii?Q?EW9TaQvmYgli8RWbCrvXFnBxtgg2uyld72+w0WuUIYPnY3/N+awU/CI7cT3/?=
 =?us-ascii?Q?vUfnh6rSFCkxGU45LbJUu6Wdof+1ijWR18NW6yChhIcW65LBnTX5gOfkAHRw?=
 =?us-ascii?Q?F8YgYtJreykUgF7zeGx22TcDC7mGuagp+kciKVG7pLJ+F6mYj/c/3YcBiFMY?=
 =?us-ascii?Q?fYqzsoAKqNG2f2EEMoNKo37C7EMBW7/l/3AZ+4SKxXMolytY/UCSIElkB998?=
 =?us-ascii?Q?NtzL8/bUWVcOFdA09QGPe3zaChcpkpPUo8rC245sPAffceH7uWPtHZn8S5fX?=
 =?us-ascii?Q?enYzwlRdvZqnG43OvK8aI88hZZLRlip7IJd4Tv4mdKteKton3yANFMtPwMnn?=
 =?us-ascii?Q?wFR9E+AnyYZTVY9Y/fibdNWQXO3wZbCB0qom3MVEpO1s77OFx7CI5FBtngTG?=
 =?us-ascii?Q?8X76ieKEFTmHRLiWDU3UBMbQdBMaDM9on7qegtPEJGpI9zou6cc8cMMzfPEA?=
 =?us-ascii?Q?cfUGQZ8PDOBWMhDU9gJxjbzPyx3J64Jhk/L3WC9WsFJ4DMpAThIBrzLVMk2D?=
 =?us-ascii?Q?3vrDaEtg2Wg0PKp8nubmMQiz0nhPx9YAWvsLXHqa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4bedeb-23bc-4246-754d-08dcd423a3e3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 18:41:12.0635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOw908frQcPnBerifi+/CqzOWUlcS9SrCLd9i/vDR1gcuqyC9BV992lG4w5/SilxMf/IlXqYxaO3YjKV3mQq7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7507
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 04 Sep 2024 09:47:54 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

> > 
> > Link: https://lore.kernel.org/all/66b4cf539a79b_a36e829416@iweiny-mobl.notmuch/ [0]
> > Cc: Ying Huang <ying.huang@intel.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Ying Huang <ying.huang@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> A few comments on looking at this again, but all things that apply equally to old
> code so maybe things for another day.

Yea this was solely a move of existing code to fix the locking issue.  I
did not evaluate the original code.  However...

[snip]

> >  }
> >  
> > +static void shutdown_notifiers(void *_cxlr)
> > +{
> > +	struct cxl_region *cxlr = _cxlr;
> > +
> > +	unregister_memory_notifier(&cxlr->memory_notifier);
> > +	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
> Flip order.
> 
> Makes zero real difference, but if we later end up with more to do
> here for some reason there may be ordering requirements that will
> care that this doesn't tear down in reverse of setup.

Generally I agree with you however, the memory and adist notifiers are
unrelated.  So failing to unwind in reverse order is a matter of taste and
is not required even if some other logic was introduced between the
registrations I don't see how this backwards order would be an issue.

> 
> Mind you, see below.
> 
> > +}
> > +
> >  static int cxl_region_probe(struct device *dev)
> >  {
> >  	struct cxl_region *cxlr = to_cxl_region(dev);
> > @@ -3418,6 +3412,18 @@ static int cxl_region_probe(struct device *dev)
> >  out:
> >  	up_read(&cxl_region_rwsem);
> >  
> > +	if (rc)
> > +		return rc;
> > +
> > +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> > +	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
> > +	register_memory_notifier(&cxlr->memory_notifier);
> Can in theory fail.  Today that is EEXIST only but who knows in future.
> I think we should handle that and do two devm_add_action_or_reset() perhaps?
> 

First we should not fail the probe if this fails.

Second, nothing bad happens in unregister if the registration failed.
Therefore, register failing is benign and I don't see a need for the extra
action callback.

Ira

[snip]
