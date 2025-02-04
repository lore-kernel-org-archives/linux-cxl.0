Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBD205E23;
	Tue,  4 Feb 2025 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738712331; cv=fail; b=qO2lb1GnFMuCXxwJFOSiZhy3dX8QWypZWHkkbpfqUPr0EBVtcJ0GV9Zfpx3B37W9RbpXjSV02i5akzbIYC/+GLWEl9sMOnmbtF4UE2QbgowpsQg1ZY51DRsxg7DyKM+ffqLnMN8CUEMzSVwlFbFDq9Xee6LKcrSJgv+lv8QiLhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738712331; c=relaxed/simple;
	bh=hmzyUYzYoy2UWIY8cfq575xJnCR/Zkh84F0FxyvkMPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H4uZjNkzydwcEMQ+XETzu0mccG5SdqzlSPKAGw9I3H8ep+6mmpRWBwhSjHKOISSfK9IbEa6hbldv3NnvqyP9v4jkYrZxPFtozeERZJVN3JDQ6q/5APk9InkGmgtOL3ZyVZWOvcTH6CRVx0IHMtxUuedh16z5r+7pxcLhOg6WwXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kd6mEka1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kd6mEka1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738712329; x=1770248329;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hmzyUYzYoy2UWIY8cfq575xJnCR/Zkh84F0FxyvkMPY=;
  b=Kd6mEka1Ekhv9+IfVb24b/Dbb5M3lpTxwhuZ1uQIMHEu7Zr370P+HBkp
   OMaL5hd3EGNnUUwE93StkL9FsmqnSyK+VgKKse6AEyvzQQupCm0gRpggV
   IYR7K6CeLLV09vme9LHPLD59xl+ODRPAZuXmSYNG3JrF33r9A6B7fwUmY
   tw0kCV9SsUATRqcp6NIjGJzF/YCcHL1VPOjNEtRVD/kuFwfq5aZnPWThJ
   KqVunFIJ+pgCdT7pPy+CLssaSM/H/LCajrtTvoLA9c/2Zcf7whgkSG1SI
   34uSnSMkOkp1QZ/ZXYVorwrSQb27jKTZDbbxks3VZjaaDys0E+nMleUVl
   w==;
X-CSE-ConnectionGUID: Wke3Rj4BTZCWO4V/tbvTNQ==
X-CSE-MsgGUID: oNzJ+fvaR5a1JT53lbw0Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42921457"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="42921457"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 15:38:48 -0800
X-CSE-ConnectionGUID: 20IwxL+dSdS2zGh5kAmeMA==
X-CSE-MsgGUID: NHb38MKcTtinpzjsNjYkAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115344905"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 15:38:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 15:38:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 15:38:46 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 15:38:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMKhmiY7dD9CDMBaFyI7CUyX+jfv7zxCxhSEBpqDmVNmGg/eJVTD+Who2h6q8azhs26j5Le2QCOgzSxiL9xZ6xDo6W7MG90R/NUFzkoq4C1v6LE0LujP543PxpeTaOi/RJGoAeWFBzfURm2UG9ukAIDmvp/WcH72Wr4ZW4H06SPcFZWEDwL5u1+MUD882PyhkKU+tw2hImDCzNHkzpHoL9sJMG9k9TNNRS4S+t5QFiZozO5BhfhCv7PTt7FYp05/eorrKwvdLz/70m46yBbTjduNeYjyE/bnd56m/DZpR13bnYo5/BZtRiCb56Ulz6S78YUJ6I70c0QG6cOth83Pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1+VeNRXeNvGQhL8DClo7EKTbvVQvxFNgfu3G4qj6Do=;
 b=E8yTv4DaADPsy1sVSOQO7oHgk3wbqmDcaMzc2k9b57MNDNg564PA03O7haG4sUySUEFbZBkdBgBvmGkh7je9pwSqao7zZL7ZpRAVij6rKdSK6hLkb5KJ2Ri1pWbqxHQpyJPkAC3529enJN3YYorQoGGYPXIyJWQBEy0H17bWZihyvvPUwou5O6+JzkGP/kGMGPMfXPQGFFnGvg0OjSGQ74hB5EILqZur0x9k3h6EjVO5ESQhtErW0OQ1OzSGwcMDqzk+L9hDxmvOrWrOlXtD8GzdSUpjzZfH7yUowQ5ugsqePceFoaZ4j8PjRVPzHAUthvoZrjH8Snu7zr9CZBOkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 23:38:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Tue, 4 Feb 2025
 23:38:03 +0000
Date: Tue, 4 Feb 2025 17:37:54 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Message-ID: <67a2a4d2519_2d383a29411@iweiny-mobl.notmuch>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
 <67a28921ca0b5_2d2c29434@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67a28921ca0b5_2d2c29434@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 617ba270-e8bb-4c6b-556c-08dd4574f751
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uXf/6GRzERIFc9io0YRKMAjf73wMi93hhm1NbX5paLbs1Ph9ho14LZtp84Mx?=
 =?us-ascii?Q?iCb175muqcdV7r8ll6G9jsNJsFG8xy4CNgZHH1oaJTg4DPCn7lDVK5H4aWWp?=
 =?us-ascii?Q?cH0xWaX1UVrmFAsLp5+e/h9XzjwbY/KEerxFlca/Rcy2K8WEUMGoETEljphg?=
 =?us-ascii?Q?fztORB6crwKAx8vhEi1xfL5dP6fjjOIwpBjzV2h0L+hnlXkC0CT92GPT3ssB?=
 =?us-ascii?Q?M5jq3NVhqLNTaN08x857mGG9kGLXCg92DN1PxMKzn9grUJAukEHD63teE8B1?=
 =?us-ascii?Q?o8j+4zLp1s5O7KEGJE52RtQlyfOWLr2SIIJ7aemRSiDFfAMdz8uk5YnmcLR/?=
 =?us-ascii?Q?pzE7pn84vNehB3bBtIvlNIrLja2oh5ZiMMwY2ZjLHOixMsCqSJZtoYbD/zR1?=
 =?us-ascii?Q?gb5VyHbNmmZHEe71wFFGiV5YwoUpOz2goyg1lcBCErz+29KgNPK3hGCjRDmU?=
 =?us-ascii?Q?W2bWfmq6+qUOMrrUQs7KsNnFjlWbNOHL6Ztl5w/VLEWypqNIiI9yvoEC23SC?=
 =?us-ascii?Q?scveNcL3mOqSDKsvGMAhlQpnV1bE5Qyvrfl9Ck4ddMNw+Fe90iT4SyFDRMOr?=
 =?us-ascii?Q?tG6+tMzyyDm6aDhFhWCdx4fwIB7e5KA1U0s54iSiGbzgC9aryg29WoVeUvPK?=
 =?us-ascii?Q?vpGmcK+zuKuLT1sR+TQ8D8nh+bzGX0ByHx4vm72gcKYDDvHV+/cp0zE/lcSg?=
 =?us-ascii?Q?vod3v1zdIe4TbWJNxZGeIlim/waqdFF2tudouM2p3jUf747JYxvyt6IRJzcH?=
 =?us-ascii?Q?jtuHPoxbWp1wDixfRQK36fD/sMvSsDHeXYuf+zIVxaxtaxqzuCAHxTwUp3ch?=
 =?us-ascii?Q?7FZXOBDvGFRplbmJTlizwL2aM1x3Yi+Vpg36d0kNCap+Fd+ILihQ6zBJz5ja?=
 =?us-ascii?Q?VO93LlCETncQWMLYCfIwvrXpvngd9sQgeqBC3/jvj23p4rBTd1ig7OWVQBve?=
 =?us-ascii?Q?ePAvZcdS2RDYncerxLl/xDG7aGTjV488bcNBweT8eE66FODjk9MqelL+BDZr?=
 =?us-ascii?Q?WRQdtEeFrZSGm6iN5wzvMZACgwFMf2fjrivYiqdQDahK3GBZaaPwqQIU6iMA?=
 =?us-ascii?Q?27SVQC5W5u+9J4K87Xsct0zFsgAh+NN1Jru5qwIV/SKKVL4iXOlUsxLK4wD+?=
 =?us-ascii?Q?ESlJUPrpNn87KJG7x6wLYXctW7H/rQwXqP5BLRejxpMDdsgjCpfhvJx37w71?=
 =?us-ascii?Q?ZUHAmkgXwvMPrYTaEgrKnkx3/CNPQgTNUW5bRDSMOTUmI3IoPtLmm29S5Brq?=
 =?us-ascii?Q?+UmAmIKTwHJ7046DWd/MQVSRFDR7X39jGwMuO0e+NQfZoktTgr46lR9ogQ5i?=
 =?us-ascii?Q?mQVqzvtq/tfwQ+1huojKw3hQBQW7TrSbtD9bOLW9Q77adsNJfO3KUPKqk/lL?=
 =?us-ascii?Q?CJnksVmabEOEKV+nqJ8Va7CRgWwe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fO7IbtEDsqg5uSeESxHeLcpI6FoJuCzXaYb/4uKJyVolho49Tvwm/MBAIxgs?=
 =?us-ascii?Q?OV8uOumLgwbRtJF1solAQb+ZF9b1ZoGUehfPgizMf/rwr1BnrJG/LwAmPnzo?=
 =?us-ascii?Q?v63+WtXoYO1EuqsbdS5RPQLxSxEJ2F7nzPuaRGERPfuzgTRWKI+FLBE53GQD?=
 =?us-ascii?Q?+NDBvfhDWw94pqOKurS6Ol0FEYlhzIfdptJ8CwhvdfQqFH+HBtCdByKV/FHZ?=
 =?us-ascii?Q?Ga0J5TZKigFOOdISY2GYNOt9JDyx1vDiWy8Z2BP1/HoCCKcutPf4FBsu4UHY?=
 =?us-ascii?Q?z3G2O+BMRxV2OV5Tb4Vx3zv1fKELG9p3m9LVR0JufyNgQuXajIEtrkVwWW3H?=
 =?us-ascii?Q?Z4bb275KuV0jIL7U1X5may/SXW0AinBEmUM6Pr+gSHoyrpHU2xWofcXdKNM0?=
 =?us-ascii?Q?6EpDyN1hbWpLesmO8eQELK+RReVOlMWF5SNbLRcATStKDcTiHTJNq4OiPnnl?=
 =?us-ascii?Q?sblp3U8aURGbRf6+VdO1NKfXcGd5Rsz/shfIPADrraDcKRUA4cM2q6adCxCW?=
 =?us-ascii?Q?RAr0DB+ZrPn5LaW+OaPT6X3755HJy3aaD0TcUe/k/nkOauQiPrxXu5NDINkY?=
 =?us-ascii?Q?O3O0xL4gHr9wXj3ERH2y5rKOu1LqJgKLHp85CRAnX8GFBWvRydX7J8b0RQd4?=
 =?us-ascii?Q?nK4zZe2efgcnHgctjFsdQqb6eXgm2msZEEpuRfF5khFG8rAJQ9+o8fRfEcsp?=
 =?us-ascii?Q?scjIHFqV2Uc0N2zFRUUl5yL2UP3mvFuINntEco3L0BzziwGe9e5BSrzHXLNK?=
 =?us-ascii?Q?ZVMVMSrk6TBWM+kbF+1zcxhUMnL3i4W/VhIOXuNS+9KVLkI9qmljvrHGqHh0?=
 =?us-ascii?Q?cOiu3uKCLPUHw4MiRxEuw2Izqmf1qAHavypmThaQ0xbtuweSvv25tY6o1mW/?=
 =?us-ascii?Q?+eVQth4USGzGz/z5uXJHQ2l25CQwZ9mktoi82sqBf6YIsTw80NEOquAXaZbS?=
 =?us-ascii?Q?96pch6o53QyGxP6/Pcgm2sLqpKg6t+uatt5vVwIAY9Y79sq6Fq1zkV51e8eB?=
 =?us-ascii?Q?hoRIIScagdSWWQ/coQRDwLqEVh6hVRy4Lv/t1Vqa3++BaWxMlICRvuS/NsnT?=
 =?us-ascii?Q?mp2rAmPC8UbpPrLe4OsPzGaIvfgVpfCYdZPAhUxdrnvkQQx8sFyGDj6po2n0?=
 =?us-ascii?Q?DcGdo9HBRNDIO7+QpaZxl1gtIgrB+sEPsyuMMll0UfeS5GB8DHoowwbPqR3h?=
 =?us-ascii?Q?v27VO3J3Cs0Q5WfDPPQ4mCPoK/rNgHp9sHrsfkEsY8D0cNsvBJfXRo9oZmAn?=
 =?us-ascii?Q?gOLnvjWV7MCP/sAMdGMeJXpC1IbLGL9Jdc56dpz2gPhJ99MCa6/5cWW6QKqL?=
 =?us-ascii?Q?TJMF61Wsjik3hK0Q1caLqOV2KG31CFespXVxWl+R3g34/9SrKszF2ZkcwhMn?=
 =?us-ascii?Q?vBNRd5aPsB0FSeaQSakb6RkTQMi2Aj8SzytILmbOt2hfao88r/DfX1JJlx+N?=
 =?us-ascii?Q?QT04Y8RqGiGazb/hiJEpDLBfe85M8hyeGJ5vjxUkKK9kR4ZYxa2gDH27gxgk?=
 =?us-ascii?Q?F+g66yHA9QusX4+/ExEns4JH8z/oFpXdV4BAg+gUtNMgIoflZAPmWGkehtLb?=
 =?us-ascii?Q?ru6bVPukGxOg34c7bAln4qX005L6P2TKX2vMefvX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 617ba270-e8bb-4c6b-556c-08dd4574f751
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 23:38:02.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r07TOfak/GyUMGB7+ZNZ8/41GdK15EQiMjMFerm9IYN7Zw//6O/duYnAIIpql0XuQ4SOIDnicvpXt0jNz12ORg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:

Perhaps this would have been good to add to the commit message.

<quote>

The net-net of this change is to make partition set up 2 distinct steps.

	1) query the device for total, ram, and pmem partition size information
	2) create partitions using that information

While doing so it avoids storing the total, ram, pmem sizes tuple in favor of a
stack variable cxl_dev_info.

</quote>

[snip]

> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 998e1df36db673c47c4e87b957df9c29bf3f291a..44618746ad79b0459501bb3001518f6b7d2ceaba 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1068,6 +1068,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
> >  /**
> >   * cxl_mem_get_partition_info - Get partition info
> >   * @mds: The driver data for the operation
> > + * @dev_info: Device info results
> >   *
> >   * Retrieve the current partition info for the device specified.  The active
> >   * values are the current capacity in bytes.  If not 0, the 'next' values are
> > @@ -1075,9 +1076,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
> >   *
> >   * Return: 0 if no error: or the result of the mailbox command.
> >   *
> > - * See CXL @8.2.9.5.2.1 Get Partition Info
> > + * See CXL 3.1 @8.2.9.9.2.1 Get Partition Info
> >   */
> > -static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
> > +static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds,
> > +				      struct cxl_mem_dev_info *dev_info)
> 
> I was hoping this would get further away from new in/out arguments and
> look at centralizing all partition enumeration into one routine.

I don't understand?  get partition info is only required if the partition align
bytes is not 0.  IOW if the device allows for partitions to be changed.
cxl_mem_get_partition_info() is only called IFF that extra query is required.
So this does centralize byte information queries into one routine.  It leaves
creating partitions to the device driver which moves us toward these being
mailbox only calls...

What I did fail to do is change mds to a mailbox.  So add this hunk to this
call with the corresponding change in the caller.

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 44618746ad79..873793dab68e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1067,7 +1067,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
 
 /**
  * cxl_mem_get_partition_info - Get partition info
- * @mds: The driver data for the operation
+ * @mbox: Mailbox to query
  * @dev_info: Device info results
  *
  * Retrieve the current partition info for the device specified.  The active
@@ -1078,10 +1078,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
  *
  * See CXL 3.1 @8.2.9.9.2.1 Get Partition Info
  */
-static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds,
+static int cxl_mem_get_partition_info(struct cxl_mailbox *mbox,
                                      struct cxl_mem_dev_info *dev_info)
 {
-       struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
        struct cxl_mbox_get_partition_info pi;
        struct cxl_mbox_cmd mbox_cmd;
        int rc;
@@ -1091,7 +1090,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds,
                .size_out = sizeof(pi),
                .payload_out = &pi,
        };
-       rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+       rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
        if (rc)
                return rc;
 

> That
> was the intent of cxl_mem_dpa_fetch() to capture all generic Memory
> Expander DPA boundary information.

The problem with cxl_mem_dpa_fetch() is it mixes in the partition info mailbox
call after you have already supposedly set up volatile/persistent byte
settings.

IOW I don't think it is clean to have the cxl_mem_get_partition_info() call
hidden away in cxl_mem_dpa_fetch().

> 
> >  {
> >  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> >  	struct cxl_mbox_get_partition_info pi;
> > @@ -1093,9 +1095,9 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
> >  	if (rc)
> >  		return rc;
> >  
> > -	mds->active_volatile_bytes =
> > +	dev_info->volatile_bytes =
> >  		le64_to_cpu(pi.active_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> > -	mds->active_persistent_bytes =
> > +	dev_info->persistent_bytes =
> >  		le64_to_cpu(pi.active_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
> >  
> >  	return 0;
> > @@ -1104,18 +1106,24 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
> >  /**
> >   * cxl_dev_state_identify() - Send the IDENTIFY command to the device.
> >   * @mds: The driver data for the operation
> > + * @dev_info: Device info results
> >   *
> >   * Return: 0 if identify was executed successfully or media not ready.
> >   *
> > - * This will dispatch the identify command to the device and on success populate
> > - * structures to be exported to sysfs.
> > + * This will dispatch the identify and partition info commands to the device
> > + * and on success populate structures required for the memory device to
> > + * operate.
> > + *
> > + * See CXL 3.1 @8.2.9.9.1.1 Identify Memory Device
> >   */
> > -int cxl_dev_state_identify(struct cxl_memdev_state *mds)
> > +int cxl_dev_state_identify(struct cxl_memdev_state *mds,
> > +			   struct cxl_mem_dev_info *dev_info)
> 
> This function is tiny,

It's 47 lines long?

> and most of its work is just transfering
> parameters from device to an intermediate temporary object (@dev_info).

Yes, by design.

> I would say just subsume this function in its only caller and skip the
> @dev_info transfer step.

There are 2 callers including cxl_test.

Further clean up here would be to add the other values to the dev_info tuple
and make this a true mailbox call.  Or split out the lsa and other values
queries into another call.  But that seemed overkill at this point.  No one is
needing those to be separated out.

> 
> >  {
> >  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> > -	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
> > +	struct device *dev = cxl_mbox->host;
> >  	struct cxl_mbox_identify id;
> >  	struct cxl_mbox_cmd mbox_cmd;
> > +	u64 partition_align_bytes;
> >  	u32 val;
> >  	int rc;
> >  
> > @@ -1131,14 +1139,22 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
> >  	if (rc < 0)
> >  		return rc;
> >  
> > -	mds->total_bytes =
> > +	dev_info->total_bytes =
> >  		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
> > -	mds->volatile_only_bytes =
> > +	dev_info->volatile_bytes =
> >  		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> > -	mds->persistent_only_bytes =
> > +	dev_info->persistent_bytes =
> >  		le64_to_cpu(id.persistent_capacity) * CXL_CAPACITY_MULTIPLIER;
> > -	mds->partition_align_bytes =
> > +
> > +	partition_align_bytes =
> >  		le64_to_cpu(id.partition_align) * CXL_CAPACITY_MULTIPLIER;
> > +	if (partition_align_bytes != 0) {
> > +		rc = cxl_mem_get_partition_info(mds, dev_info);
> > +		if (rc) {
> > +			dev_err(dev, "Failed to query partition information\n");
> > +			return rc;
> > +		}
> > +	}
> >  
> >  	mds->lsa_size = le32_to_cpu(id.lsa_size);
> >  	memcpy(mds->firmware_version, id.fw_revision,
> > @@ -1237,7 +1253,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
> >  	return rc;
> >  }
> >  
> > -static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
> > +void cxl_add_partition(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
> >  {
> >  	int i = info->nr_partitions;
> >  
> > @@ -1251,40 +1267,7 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
> >  	info->part[i].mode = mode;
> >  	info->nr_partitions++;
> >  }
> > -
> > -int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> > -{
> > -	struct cxl_dev_state *cxlds = &mds->cxlds;
> > -	struct device *dev = cxlds->dev;
> > -	int rc;
> > -
> > -	if (!cxlds->media_ready) {
> > -		info->size = 0;
> > -		return 0;
> > -	}
> > -
> > -	info->size = mds->total_bytes;
> > -
> > -	if (mds->partition_align_bytes == 0) {
> > -		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> > -		add_part(info, mds->volatile_only_bytes,
> > -			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> > -		return 0;
> > -	}
> > -
> > -	rc = cxl_mem_get_partition_info(mds);
> > -	if (rc) {
> > -		dev_err(dev, "Failed to query partition information\n");
> > -		return rc;
> > -	}
> > -
> > -	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
> > -	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
> > -		 CXL_PARTMODE_PMEM);
> > -
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
> > +EXPORT_SYMBOL_NS_GPL(cxl_add_partition, "CXL");
> 
> I am not seeing the justification for both 'struct cxl_dpa_info' and
> 'struct cxl_mem_dev_info'.

cxl_mem_dev_info is a convenient way to pass the (total, ram, pmem) byte tuple
around and it gets declared on the stack so it is never stored.

I'm open to different names...

[snip]

> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index fa30e763a0ce4fd78441f486ce08c81e21207e29..b69ba756e7f722a327c42fb57f843635cf8367a2 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -903,6 +903,7 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > +	struct cxl_mem_dev_info dev_info = { 0 };
> >  	struct cxl_dpa_info range_info = { 0 };
> >  	struct cxl_memdev_state *mds;
> >  	struct cxl_dev_state *cxlds;
> > @@ -989,13 +990,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_dev_state_identify(mds);
> > +	rc = cxl_dev_state_identify(mds, &dev_info);
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_mem_dpa_fetch(mds, &range_info);
> > -	if (rc)
> > -		return rc;
> > +	if (cxlds->media_ready) {
> 
> Why does media_ready affect partition boundary enumeration?

We want the driver to load without any partitions so that the device can be
queried.

See:

   commit e764f12208b99ac7892c4e3f6bf88d71ca71036f
   Author: Dave Jiang <dave.jiang@intel.com>
   Date:   Thu May 18 16:38:20 2023 -0700
   
       cxl: Move cxl_await_media_ready() to before capacity info retrieval
   
       Move cxl_await_media_ready() to cxl_pci probe before driver starts issuing
       IDENTIFY and retrieving memory device information to ensure that the
       device is ready to provide the information. Allow cxl_pci_probe() to succeed
       even if media is not ready. Cache the media failure in cxlds and don't ask
       the device for any media information.
   
       The rationale for proceeding in the !media_ready case is to allow for
       mailbox operations to interrogate and/or remediate the device. After
       media is repaired then rebinding the cxl_pci driver is expected to
       restart the capacity scan.
   
       Suggested-by: Dan Williams <dan.j.williams@intel.com>
       Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
       Reviewed-by: Ira Weiny <ira.weiny@intel.com>
       Signed-off-by: Dave Jiang <dave.jiang@intel.com>
       Link: https://lore.kernel.org/r/168445310026.3251520.8124296540679268206.stgit@djiang5-mobl3      
       [djbw: fixup cxl_test]
       Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I explored getting rid of media_ready but I think that is a bigger fish to fry
than I have time for ATM.  And you have ideas there which I need to explore
more.

> 
> > +		range_info.size = dev_info.total_bytes;
> > +		cxl_add_partition(&range_info, 0, dev_info.volatile_bytes,
> > +				  CXL_PARTMODE_RAM);
> > +		cxl_add_partition(&range_info, dev_info.volatile_bytes,
> > +				  dev_info.persistent_bytes, CXL_PARTMODE_PMEM);
> > +	}
> 
> Why remove the cxl_mem_dpa_fetch() helper in favor of open-coding these
> cxl_add_partition() calls?

After removing the ugly hidden get partition info call in cxl_mem_dpa_fetch()
cxl_mem_dpa_fetch boiled down to 2 cxl_add_partition() calls.  That was very
tiny.

More importantly this exported a very clean cxl_add_parition() call for any
driver (ie type 2) to call without creating special structures to pass to the
cxl core.

I can put cxl_mem_dpa_fetch() back if you want...  I had changed it to
cxl_mem_create_partitions() to make it more clear what it was actually doing
before realizing it was so small it was probably best removed.

It would be used both here and cxl_test.

[snip]

> > @@ -1534,13 +1535,17 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  		return rc;
> >  
> >  	cxlds->media_ready = true;
> > -	rc = cxl_dev_state_identify(mds);
> > +	rc = cxl_dev_state_identify(mds, &dev_info);
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_mem_dpa_fetch(mds, &range_info);
> > -	if (rc)
> > -		return rc;
> > +	if (cxlds->media_ready) {
> > +		range_info.size = dev_info.total_bytes;
> > +		cxl_add_partition(&range_info, 0, dev_info.volatile_bytes,
> > +				  CXL_PARTMODE_RAM);
> > +		cxl_add_partition(&range_info, dev_info.volatile_bytes,
> > +				  dev_info.persistent_bytes, CXL_PARTMODE_PMEM);
> > +	}
> 
> ...and here is duplicated logic that goes away if this stays centralized
> in cxl_mem_dpa_fetch().

True but it was so little code.  And exporting cxl_add_partition() seemed much
cleaner as an example for type 2 devices.

Ira
