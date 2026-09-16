Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537383D6477
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592241; cv=fail; b=cLvnZYD/Wm09SS6heT4m28iiCR4AgcGKFqZpovmcp4quDfZXE7N0X021tu8O0TJSt0EIkp+oImmQJXsMDoEqiuDNa8WrSsYBWVyqsZlUMlWCYbbcmi8T5LhPXbybyCFbKzcVUcBuKb7BMCqaDhTfVRWtAdy1M/rsXUwdx2YJUbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592241; c=relaxed/simple;
	bh=gEdAuJ/p7MQ20aQjCpiYM49j3AadBasB5bRAl0y1e7w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J7foWOxjUCw78EhFnCdW62DoiH+T4ew8Jh+2NSZwEYGcnUuV1u3l1E1BHrfYHmQ7L0tqV7kzu2mcigKkYCOqhbcDwevRubozg0zyQTfGc6B7ynWnw/jzCqsyPRdZOugpSZ7HbPpj9hmc4R9KpaHKIHjaKIZDM++racPHAgro1kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERITtj9p; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERITtj9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789592227; x=1821128227;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gEdAuJ/p7MQ20aQjCpiYM49j3AadBasB5bRAl0y1e7w=;
  b=ERITtj9p8l0ENWSwn5lDKcUXpg9B8V9fOhRWP45RmikL/HECCfebW6h2
   Py+QCzT8b+Wpwb6yMvIfuPK1OvnmFNjMKnqFDw7jg/9K9e4tl56nmj+za
   XulNR/zZQjYXRz16uE2HUC3gV0cxsPlBZdjGv3dtm8Aq6FR6tIWHC3VwU
   YkvhBG2vxMhTll+FLZbsFeXqW0mKw/JRLxESOynhKUaSmrzbXgI9hKAAa
   3f/4vjTe//WxOlXITfyjqhIUcAxJ0xTP0B9pF4Ipz2cr+XjtI4XtID4QW
   lih6Mi7rl3I90nuxlEO8GpcOb6PRhcI0Z304XGA7YXCODb1LlE+aeBy3a
   g==;
X-CSE-ConnectionGUID: ojX3QAYyTr6sDrJ17QB9Tw==
X-CSE-MsgGUID: pHrRCC+wRzCh+BHqwgXVgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90113669"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90113669"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 13:57:04 -0700
X-CSE-ConnectionGUID: qphLfP9yRKeTMOZIAc7PsQ==
X-CSE-MsgGUID: NdTa9xOATHeCZ2Xsy5X8tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269191075"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 13:57:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 13:57:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 13:57:04 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 13:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1Mi9XgD2WfzC1gaF5rjNk+O3uRoN3zaMasVRE/AYCB9hB8xujANUumXZex6WqImShzFLATAJ4iv1ywOxtFrd7SwijojB+AkwRt0rfQhn9mlgtSL0WD0kl4cLBmgsEFdBhaep+ZA0U0AL6vwmdKeZt/iZuwVx/nr9Ke1lvqkuY7cx61AVzmM8vJSKvbyHKdhBXGyJh6VGVIYM3kKMzkVBP6cnddJpwNrTarjE9xd3yi/fYTljCf1pckFA5lpThFeT+JPWwVVa815Y+9tBz6y4G5RRhKApODGA1x3eJl8Mmr13XX2gKcjiFjz5j+RY4zVPjsbBanuWs0jwO0xOk6bJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh0hxNr29tJiB/rGMnE5OvdOHvY9mfNuyM7B9WNBra8=;
 b=su3pYMtxWOGV0LVkpmJ88lXTre7pCjuShGl4ux6zQk96pPtuCz6575osgaHiKx2GssE9mMi6jl80R4Ak4YQwNUTIoeZRg46un5Nt5jfPVehImfXzM6TgIdSj1aqnfc4wA7Lp6HPb9AtbnU0ciwwitTmsyQ743guV/M+Gh4GX9UmwiC11LRY3B/RABXjYFBLPg8WPm33oc1JJwISskNfDYHfg1EjuFyemjEZkf5UYcghSsDwFVG1dtPZfWiQOCR8xdxpVs/QFEozWYsyN7tfhLGud7pgwWEwLi9Q7OI1OwAT4bFMZXID9A54SOx2+dwCof5ibsjhWvRYIk15PGkklZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB9702.namprd11.prod.outlook.com (2603:10b6:510:396::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 20:57:01 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 20:57:01 +0000
Date: Wed, 16 Sep 2026 13:56:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Create node access attributes for CFMWS-only
 NUMA nodes
Message-ID: <aqsCl1JAwiemCjad@aschofie-mobl2.lan>
References: <20260916120338.369436-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260916120338.369436-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: BN1PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:408:e1::33) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 9675cc9d-04cd-4c96-0359-08df14350dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|10067099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: cdmnTZj1CJiiSPq4zCXC4pvLXSPVqT4xw2bjMwz5VeQdwcIfmQvP5ECaLUg/7kSyv/SnZPdX2jF30yhb8RAH+Yhoa+uLVIHMRiNMavkYHgaren2/Bf8hJcSu/5htMriVmInA35TSgUewQ4uJHP+TDGoHXcMi8vpiP11mN1ePKgcxe4cohf92f1ggRQtabKGccQ41g3w/b5i3H68AclecdJNisxgBKd00PC326HBla3sv4cMMkGOiPJr2SQWcZBhXT2/Rwa157NCPyAqJeg/n84/hATIklaaeOPxX7aO3fHjSR+BdlXVh0Uul/4BBhd+hO6Hcy4ePaV4sMeziVNZT2ee3QBPj3xV+4QZb9kWn7shqDfnJZ6mLvTxfOuzJ0IOoUpubvDKRKZPwyiCKyLsYpG9F2BJXkje7jRrWSTJZLjrY11H3NeZAYhhzbT2Dj4ZGouhMR2PmqK7ih4NcP0TGcrNgpoY9FkieKKKqrx14JSXR4LbUuBZLl23UYeil17wzIsBjwHfNxfCJRw7TF3DhmdyBjn9CMNlQq++P+zogglbiCCz7BBHK2TY0DG8+M8XfYzheBWgHgaTrW7YjQBz85hAMv8VWYXHDevnm+Nfwbdq1KfJIGgoiNpj0QJ2CjkLI00jh25otj0tEIL3D4T9vX7dLybLGyNwI+3mdfDDXkxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/jBBzXnn2DKYLcetGHtSJh7Jya2CiIaBLv7j1DxPsVDOPD8mf+7ceUZhKhsT?=
 =?us-ascii?Q?qe6x3bSjiahQX13YSE9PLAMCoZs/vBC1Bil57lhoI3C8X/XAtkU41KmU9FhI?=
 =?us-ascii?Q?E6ca74iUdFIG7XyGwPK8hqPuPM9yR6lTses91wHNmLSMDIh1u3bkc7hJxFRk?=
 =?us-ascii?Q?JRmJEzekn0Tfqmv/OR+boUNv7eJqFOnxeuseTCWxW/zWULiGWJIKqAYdqJNO?=
 =?us-ascii?Q?IXsbB3dF0qKRiR5ovARLGZNNgGsUwTIinqkIX7mbNArUoYV/9yKPMqzVI/p0?=
 =?us-ascii?Q?ZL+fLQeTpYc8EPSAXILmZVP31KS14tueY0CNHa1gx+jJiNZBklaLpFVeHugi?=
 =?us-ascii?Q?81+bJsoiJoTh6+XKQePU6iZCWajxBf4SjktEC4HTJPzzNlqnrpPyKCZWa0HI?=
 =?us-ascii?Q?6uySb9s+hj7Q/nP/ZXOs4vkvC4t5ASBHMHcgUTJlxMex4hBl/Ks7Focq8K7R?=
 =?us-ascii?Q?sbOWvNEFtixnfNOaJ3cQUio3WBOwZPuqi/tQQsR9Y1dpad5NOx1VXMSsROHu?=
 =?us-ascii?Q?aW3tVj8uNapoddcBDGUBBxXawRlvTXaYkwtfKW1x8HdDhnXp/+PvoCJvsdxF?=
 =?us-ascii?Q?NUfXrPqlppYlE/hWRHjeOR3eOE/Nk8OsCAsuOxh7tZnsfc4/zWuAbpcb1vRd?=
 =?us-ascii?Q?OhsdGUPofkKvNP/I9c/GAdrtHWzXZXxQv06F9XMppPH4iF5Zih+5w8Rz6iWh?=
 =?us-ascii?Q?RwqcfVwUFKqDcMGdhsik7a1jcAaCIAyQtVmjVq/gpPckfSmzWdN9EDMYc6zp?=
 =?us-ascii?Q?l3ISvQ5IosmuZRylcUybdIfvY9g8V+DxGenggOh53NDdzwfpHBABYxoTBdBl?=
 =?us-ascii?Q?sauAfMHjEMy9uRjHxN3ckR2nQtQlWQNwJTFy0N/B2drNcFhDRWzLsvi/0E2j?=
 =?us-ascii?Q?h0ZmBC3MzAMWOWBbzEZCxUT8I20nyB0XOPJBVMRbsx8qlO3No9azRpPKGzsp?=
 =?us-ascii?Q?R8y4Wdpkl6qVhOnn1sy1joZA/wvGbsO9htE2MXaQkW0YQMUx0CJ38rhWoRUV?=
 =?us-ascii?Q?UojKNm2szrtUUQG/XVzyoZja9AWkkLfC9ct4JNE+i7cHRaZ8omuZDg/oNaqW?=
 =?us-ascii?Q?tgp5VfHbCwW1Mn2A8E8a2zj9RUnzMresEKSlbTXoj2PNvhivJmFTh/gEBPep?=
 =?us-ascii?Q?y6Jg4HoHTHA8D+MhmT7YX9vVRDIfx3j5KESwxVItLJghtzu+atdSFkjVVN0S?=
 =?us-ascii?Q?FhFZZJ1MqtVzO/yGsZmmZFb6z1XdBMhn0MYDinVQRBBKlyNyZTygJnMEUn0e?=
 =?us-ascii?Q?ccVoYDFM5CaH3DVrsid3PhdScdWxKiGhKYdNjQOFFeheSM12ILYOLOvM78sh?=
 =?us-ascii?Q?e+W83UtVRDMwsGYqFFnR/o3oX79Ouypa4IyNLiwrdv+EZ/Y19rYEtxETJ3FH?=
 =?us-ascii?Q?5C4JnREJ8GVBD0CQVkbo6SUh05/7ykX7LrcAL0ZIsLoFAweyZxeYYVnz/N+n?=
 =?us-ascii?Q?Gjkmivewx0hTJ4hic9hdGjvLxTm19Re7h+7xP6IU45qtsRkau96AcS15k9dk?=
 =?us-ascii?Q?FDOKPy16Vz6imuNXaqnLVPhVoDzk+LQCHhrWkqIoyPJsoTM0syETVySH+pOQ?=
 =?us-ascii?Q?Q64RpMipWIU5aEwqwKD74jIM7zRJ3zL1R6Ox/9GyhtCCeeRKVCHnnLMe3SpY?=
 =?us-ascii?Q?MrWNyIb72GEs0XzL4f+CmeAjfENYx6i4YFDmgNyrd/x+skBDE/q0LOra6CoE?=
 =?us-ascii?Q?foa6vHoQSFpo4sRNnsF9VHMDln9bdq+YgN+2nCYCuzOHxqnok9PKZYZDh4hi?=
 =?us-ascii?Q?HS18YXzcnqHjbM92Il1hvEX/cl5Pua0=3D?=
X-Exchange-RoutingPolicyChecked: bElw5Dojfe+HpCvS18G+iaPRqj1EYbEPh7NwMlt0DLlycyy7kjJz7OKgBCS+ungWzz4X4QHt6/tnPge7p5IEYVfmf33187hzawjN9uffU12iVzQM6VnKB1Tz7UwM4hKqtUuC0OPABrWWNywU0hlA4fmBqWSbTigmi13ZDZtT3eWHgpBg1JXFQ7NXHDa2ViH1zTzh6e6TBpDPgBIzxDkER+6M5093Q5oANrRGI0ro1HnVDFAkR1k92FxqwJR0Jy1VNazI/QRTf+Oyv/mswdBk9pAocRZlu70yCPyRdk15PJbGs35az1iEB8mfqAR6yjRVedNlOUv3izS1PH/QevgTLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9675cc9d-04cd-4c96-0359-08df14350dda
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 20:57:01.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfZnkLd/7tt+IqlDvDFykoGB1BZpUTkynsTiAr48b17g7IwxspbTq2TOhGXLliuLChNQq0bOhDe9DIDEdygkJWQJxOcuO/709fs6qYLdzGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9702
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 08:03:38PM +0800, Guixin Liu wrote:
> A NUMA node that only backs a CXL fixed memory window and is not
> enumerated by SRAT has no memory_target in the HMAT code. When the
> first memory of such a node comes online, hmat_callback() exits early
> at find_mem_target() without creating anything, and
> node_update_perf_attrs() only updates attributes that already exist,
> so the node never gets its accessN sysfs attributes at all:
> /sys/devices/system/node/nodeX/accessN/initiators/* stays missing even
> though the region's own sysfs reports the coordinates.
> 
> Commit debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated
> by SRAT") handled this by having the CXL region notifier call
> node_set_perf_attrs() directly for such nodes, but
> 
>   commit 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates
>   directly instead of through HMAT")
> 
> replaced that call with node_update_perf_attrs() on the assumption
> that the HMAT callback has already created the attributes. That
> assumption does not hold for CFMWS-only nodes.
> 
> Restore the distinction: when the node is not backed by a real SRAT
> pxm, create the attributes with node_set_perf_attrs() instead of
> only trying to update them.
> 
> Tested on a QEMU CXL topology with a CFMWS window whose memory is not
> described by SRAT or HMAT: after the region's first memory block comes
> online, node1 has no accessN directory before this patch; with it,
> node1/access0/initiators/{read,write}_{bandwidth,latency} appear with
> the calculated coordinates.


The detailed analysis establishes that this is a regression in the existing
CFMWS-only NUMA node support, but I think that gets a little lost in the
forensics.

Could you make that more explicit up front? In particular, the user-visible
impact is that a NUMA node which the kernel already supports creating from
CFMWS no longer gets its accessN attributes.

Gregory's point about whether QEMU should also provide SRAT is a
separate issue, like he notes. The kernel already supports the
CFMWS-only path, so I think we should continue to handle it correctly.

-- Alison

> 
> Fixes: 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> checkpatch reports one "Prefer a maximum 75 chars per line" warning:
> the 2e454fb8056d reference line above is 84 columns because checkpatch
> requires the quoted title to match the git subject exactly, and that
> subject is 62 characters long. Wrapping it instead produces a
> GIT_COMMIT_ID error, so the long line is the lesser evil.
>  drivers/cxl/core/cdat.c   | 5 +++++
>  drivers/cxl/core/core.h   | 1 +
>  drivers/cxl/core/region.c | 5 ++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> ---
>  drivers/cxl/core/cdat.c   | 5 +++++
>  drivers/cxl/core/core.h   | 1 +
>  drivers/cxl/core/region.c | 5 ++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f07262513..e28c40159d94 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -1072,3 +1072,8 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
>  	}
>  }
> +
> +bool cxl_need_node_perf_attrs_update(int nid)
> +{
> +	return !acpi_node_backed_by_real_pxm(nid);
> +}
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..19a5b8edbfda 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -229,4 +229,5 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> +bool cxl_need_node_perf_attrs_update(int nid);
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..636435733754 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2630,7 +2630,10 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		if (cxlr->coord[i].read_bandwidth) {
> -			node_update_perf_attrs(nid, &cxlr->coord[i], i);
> +			if (cxl_need_node_perf_attrs_update(nid))
> +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
> +			else
> +				node_update_perf_attrs(nid, &cxlr->coord[i], i);
>  			cset++;
>  		}
>  	}
> -- 
> 2.43.7
> 
