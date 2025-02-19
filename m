Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D962580C0
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000755; cv=fail; b=Iv9NbHKTOmy9b7/vkGwi5MNl3KAkcHCGpLwYE0b1z4jJroCMiLlxchNXXap2Okp6JYwoub9hbeHFj4Y1bPYIycSYTBYMGLcOYOQwa0xT0ydEDIXLSSMLdfpSb17MhGr1gXpWrF4Cr7VkmpEWAkghMSI9SKMuztcbLfRS0BsAbPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000755; c=relaxed/simple;
	bh=VEOXYL+jpOeUsQegbxfPTtpzHg3uxyau9kAmcuEmWf0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XjgdFves1eImc81OQ94y5ZniMZiD7NmY639dvkhjGD3v7ArFLRfkIXqJ9moc4N73t8P9Ki+JEqNkcDVq7gX55qcvBCGhDmZHHBkE/OfRIsG8BDwc9Cf+o1z4FQDF366s6gtrwmNysVYWwlXK+tPP6mKKP/GhGKX1W/XXMblyKgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUZ5NP4K; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUZ5NP4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740000753; x=1771536753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VEOXYL+jpOeUsQegbxfPTtpzHg3uxyau9kAmcuEmWf0=;
  b=iUZ5NP4Kbclg3mD2wOBvNKm4l5BQ5vzAqUavSkd/42O4a121QojBagNN
   hbj8o33diuaT8U2MS8U2zNq1XplepJdTwkGEuWteWJgtH4YcbbF/bLwfx
   Yhi89aqc4a1Q1bQ4Ktx7c9+phqh4ZQhmQ4bEiAief1y03FqHFuf6CIEuO
   KshhVvhuTuX6TjpSNPWEEu3AtNLpHWKOKO/LPUBZ39xnpKbsjhO0DUoK9
   KIqWV3sgKX3agcGbc+IzUdDhxLGVWRkgyvtsdXiWZRJc+d5XTDeggxK+h
   y5kAnuUfP2fYx37KLzSOtUxIZ+IpHvYlrcggxxiRS8mwa5gTsNbD82ZbL
   w==;
X-CSE-ConnectionGUID: TMsFpFhZRuCpJgZQjwZ3Wg==
X-CSE-MsgGUID: ji689l7ySQSIIYjTGcgwhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39945484"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="39945484"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:32:29 -0800
X-CSE-ConnectionGUID: a1H9LnO2ThSMe6WuEBNWMg==
X-CSE-MsgGUID: KPH0brWoQwSl+QYQG6sZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145716403"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:16:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 13:15:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 13:15:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 13:15:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBJccqUv4vYkPq/P7TUYm3fka0j05CwkgK+3Eo13NORX/ii0T99xlM9kdxn+E/uYssns3Op6oeSd1d41yaTgTFEPByrPp3G+97GRYaPP1tH4GzRBrd0rNt4W9pa9oiWc4lE/AGKlX/6AFrW+IScZjpcGsjv/YBfMiSFmsTG85S4KIFOwkyWGXiQZbQ0WxQzupssqgPZr7Db0vfyA7oU0q9T6d/VFgV3VShD/5nWoBYfFCBE9K1YdqBFkFEfv3uiYrbBRd3di+7A69Ka6NRlPrz4bwndqj4uwFKDcKQmfBjNzkUXMBrvDmcX/9FQ3ox+OxoHzKdS6/w1WF1SsubBn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5qqF/MumpsC5Z9syuubNYFcNL2wZPJ3LEHIUg8XeDs=;
 b=owmKfGeO6B2ZVdHCp0vW5ccVozaL8fJuMXsJSTT9zBCx7up8kbL/BPNoy75cOSET+Khvgxh0ZG2KDnDwNq7Y55aO45fvgkBqBvtos8Pfk4kQcm6rMjK7LuHlB006BT03O/Wny4wM6cVXjuFz33Y2e+41rVon9dDeKhJcX0sP5R1/QVBW6j823WT9jYs6C7QPn13QlxggJlfOh78AfojMdBvwVaet/TcEmaWvX8757MmnPkt/19V2B8q+c0xS+ZO2cip7G5GDu53fXksQ3b4jxMqZr8qnpU543La5qm3BwIPEitk0Ixkri5usHqSdpTRZLzjGqlSxLMgXmJtKj0ajkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB6125.namprd11.prod.outlook.com (2603:10b6:8:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 21:15:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:15:12 +0000
Date: Wed, 19 Feb 2025 15:15:09 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <anisa.su@samsung.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/4] cxl/pmem: Export dirty shutdown count via sysfs
Message-ID: <67b649dd702c4_2cf2f829436@iweiny-mobl.notmuch>
References: <20250219062832.237881-1-dave@stgolabs.net>
 <20250219062832.237881-4-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250219062832.237881-4-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6a2dd8-187e-459d-e51e-08dd512a7f08
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GZODvjEqLrnoPZP6aqYgnN2yXV2qoqMRjBB1K7AoJoXKYaMXWt+J95DvJ0Gi?=
 =?us-ascii?Q?ckRhs1Ly4O/p1bQb4oZ14PE5KIY0mHjHLD0QK5KN1I6NH5LwIhUaYzLW4uGU?=
 =?us-ascii?Q?gE4wJ1ttAJz4Hk6m+T50H3yNL0xV1uTTzpUrkIXjSka9GKpuxct0Hxs9wjhd?=
 =?us-ascii?Q?6X4EnLhtopmMj+Yi0ZLLy7KTgMVgEepZLXgadF0FIXaAJ1L+nQ8ErgOKgMsi?=
 =?us-ascii?Q?toPGmkpZRqCr6fme3hbKlEEkZ7v1aYVjAg7q5ajji/UdFolvRF6cPNaRhuUn?=
 =?us-ascii?Q?+DE3KeoVaqetKx7qObVNskpTXpYVwTRbx6I8mCe9OrtoqEvT3F4KNbvK2bEX?=
 =?us-ascii?Q?4VEaXnn0Ku2ze82spx2rlbFw1obFm2Ltyz7yEek2fuTR+5DqgX1mRaeD0S+e?=
 =?us-ascii?Q?/DMmTgNGOw1m10P+dV7CYry0fkZmDFCQcMy1IJFKI2mDsbxKR/SPj8Z+gm57?=
 =?us-ascii?Q?eDdhqd3VismM0qw1J3b/GX7b+gjQKRkjy4SGj4qPi9Jir4tTX0QDLZiTn4hn?=
 =?us-ascii?Q?PZT2eM1FqyAgLq/x3uqRwBLaOM78aYww66rjxApiuN7gP5TLgxxXMEMzr3fZ?=
 =?us-ascii?Q?UH61msSXnKw1kkHqgK5SSiT/TbkbHEf+r7mjpUEnO4nstBKtRTC2tT7t5qvq?=
 =?us-ascii?Q?Y4KE33En6qK/BpGd4vqGUOyx4L0sfumGKstYaPsJTv4YC/KI7YgQKKKOwMdq?=
 =?us-ascii?Q?qdDoxzNuBI6Bwq/cXOHUUbk8qFBJnc3oq7RwCub9YWiAm7ddahFt2Gh6vFgR?=
 =?us-ascii?Q?FcUsc62dA9YvsOGAxKDDDVDjggwmCkmD+/njDsazPJdBPitAFRgVusgsfJyN?=
 =?us-ascii?Q?8cTgwem+uUORiNSu4388SY1wDpb9xDdld/ygoQp91W58keOI07jk/kSZDyPA?=
 =?us-ascii?Q?1IMp/oiFOrMcD0OOSwfrM6KSrz+gc1zYO5T+qY3b5OewONQRIEDB6no5wXTP?=
 =?us-ascii?Q?o8HX6L1TuTe79QzmCQZo3lClCGqmMjnP2xFxPEEtlr8+S5bwzUhAI7zDL7XF?=
 =?us-ascii?Q?Dp3u/eVyaF088tpJHvr8RwxLvwqJqJiiOHeWAyyZ8fhYwK5rsmUofVueAFzY?=
 =?us-ascii?Q?MMGqZTYf2G8T/vFNSuliiPZeTuI4hx0NCB23xBhVRbEq5cZnGtoKaf5IC6CW?=
 =?us-ascii?Q?NtpgRovBOhnyx0gyNRPFAGcrM4EUpTWt68Qa2uUGMeO0pdYSnffO21h2aswa?=
 =?us-ascii?Q?U+w3tK1pnfDIHlQjwzGQWhuRa/Waw+cksqnuv68wRVhwmkyPlA3GzPcD9Uyl?=
 =?us-ascii?Q?YbF2pgoFb4rxYbUenWjsswW5wXgFvyBZtD8DuW9oE7txgt7hQKc90VE6x1RK?=
 =?us-ascii?Q?GCr+ypLWslluuTJsA0284X4YENjGZIGdbgcqabouQqCknpPVEih+/HiSiFsh?=
 =?us-ascii?Q?8xiqHzv5hwH0IGR0z7ZliHR56XJC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8wxWB20m2jFBBUAdr1A/xeRMLBraDqP+6iL2KgbpLOgvZ/aqnrNKb1i/ZSiq?=
 =?us-ascii?Q?jVc3PYz9DvBrJv83zlNV8sBu/gETKXroDwmX84lrlznMwNOhYZDSCZXD7RPp?=
 =?us-ascii?Q?yVUcpcM3uiKi7/FYvJunMsEYastLNdVxfP5fMpZ2vqy4fjPPeggU4Lu1x7/0?=
 =?us-ascii?Q?TFS4bWE/1QwDMTZGEx0M3TOsw9cpAZDhg5lwq6rY1UfsHcKDTY6wbYN4jbQn?=
 =?us-ascii?Q?UwlnWdLc16yS3AcyNr10xUPlt85LH4xNFlraDrxTlEd5nB01rhZjx6lF7tLS?=
 =?us-ascii?Q?AhZvP/HG4axTaViSaQWr+NcbKa/f5Ceusez5tbfbFJqlG3ivlfU+8QNjvX5R?=
 =?us-ascii?Q?raNcNlanBZqk2KAz0V6Evy81RHqfsRUUyQto+r6iYF0WqcG+LjeNvQWfKhWm?=
 =?us-ascii?Q?m3KNvyl688KmF9IEHzRvia5Gxeh1ayDcL2qYWZXqDjCt+890M4K+3FEAhpjj?=
 =?us-ascii?Q?AeJSLgO6IUCU1megr9DXCPKQUehOVO8oLCwpBI5vNbnvI/cWJuf/xvHIRtRy?=
 =?us-ascii?Q?kguzDymej3xbCqUzx9PmpF4LY1J+ntVFs00sKpF0wGt22dqyLlLDqp0Xm+R0?=
 =?us-ascii?Q?dbTdgNTyYXcVWSTScwDAy7Y4Qdc/oA5RYEf2U8PKEQTT+5mRwOKjpYJO6Lkl?=
 =?us-ascii?Q?wvGJCSOr9S7cCrrIi7cm3lCbZ5yWBYq9ySE8CPAalsj1SRK79a3HhoVciz13?=
 =?us-ascii?Q?xjzNu9rm9Kn0m7iEMpiI17a1DzLdK9OX1oHG87f7RoGyddezilimufM9xV1+?=
 =?us-ascii?Q?G4gqxSi2uJJk4mi2ykan1LEmr0z8AX74HnEyqkr3rmZzahKsHlEOakTDeQ9X?=
 =?us-ascii?Q?hHDbEPhkyx5D4zuD22BWilI7+IXopdarhBSQZhfrIU0bu1mhcEWy1PXBdiPH?=
 =?us-ascii?Q?eulqwoAxvANUEX9k9Xpp+9oo89wsPRXDsIppLJKfXRMzrh2pz4ru/EaS86Kh?=
 =?us-ascii?Q?2i2Un++r3sfZzI6qci9fkpWq2Tr2OmRuTpZFsT5XuJcFp3ItUO0HmGqPRe16?=
 =?us-ascii?Q?yEDa49BQVJ4sKvgx49VNNGgIe7S0cjSyax85syLdN6WMp4/V2noA5VgUiKP6?=
 =?us-ascii?Q?SFFL+VnamXXPeCkfoXU78+W+b99HdiGUdGHFeM/mt2L1MdGUtAAPsru7WEmq?=
 =?us-ascii?Q?okq5VMRFxHTBjurcuvICPHORANTTWPV76rjJ8aeeiSpYwaAaX7g3zIqWI9mJ?=
 =?us-ascii?Q?iKSur1m7529ecFiAOZ78EGXdY5esNqvwn0dNheWUgY9LVb89Dz3kVXItBjpY?=
 =?us-ascii?Q?YZxkYusYvGrFdw5ezqpmwSi5qci8xiQY6OdIVkpH7+ln7n2HF86laN+ih/ak?=
 =?us-ascii?Q?nZNLGwZulQ4RFjzRSnYXY1MLRD4aHNptctMSCOmvF0GeOleFTOvfLo336zt3?=
 =?us-ascii?Q?H/CgulSrVE+VrtE8791Tb/MNDHwu/ho2Lf4NF3OZPEWujqk8NZaXs3MQ4068?=
 =?us-ascii?Q?2ttlvcRSl1zF8lb239u/U9h6CimKSIdkyb7NylrUv5edBQq5OXSrpBc3W1VX?=
 =?us-ascii?Q?7K8QB3nXPrYQPRdOdMWWgk3GEYZCwBnkEjQecp8dnim95hRm1aokR/Kj1i54?=
 =?us-ascii?Q?1Oh7zJFvD7MHR0Vj8XFnoBIp0nGy9cA4fC1oqXpm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6a2dd8-187e-459d-e51e-08dd512a7f08
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:15:11.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1Z8+jIO9qq+IO8c2zFrMIaAqqZ9J67Nv4B4jq2Lc7U/IJ0DL6njQ6G3ZNQFr6RaIry39Vjan6i7S4Oa91qbyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6125
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:

[snip]

> +static ssize_t dirty_shutdown_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> +
> +	return sysfs_emit(buf, "%lld\n", cxl_nvd->dirty_shutdowns);
> +}
> +static DEVICE_ATTR_RO(dirty_shutdown);
> +
>  static struct attribute *cxl_dimm_attributes[] = {
>  	&dev_attr_id.attr,
>  	&dev_attr_provider.attr,
> +	&dev_attr_dirty_shutdown.attr,
>  	NULL
>  };
>  
> +#define CXL_INVALID_DIRTY_SHUTDOWN_COUNT -1

I think this should be defined as ULLONG_MAX.  Just for clarity since
dirty_shutdown is u64.

Ira

> +static umode_t cxl_dimm_visible(struct kobject *kobj,
> +				struct attribute *a, int n)
> +{
> +	if (a == &dev_attr_dirty_shutdown.attr) {
> +		struct device *dev = kobj_to_dev(kobj);
> +		struct nvdimm *nvdimm = to_nvdimm(dev);
> +		struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> +
> +		if (cxl_nvd->dirty_shutdowns ==
> +		    CXL_INVALID_DIRTY_SHUTDOWN_COUNT)
> +			return 0;
> +	}
> +
> +	return a->mode;
> +}
> +

[snip]
