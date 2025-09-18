Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20F35947
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223746; cv=fail; b=RnRsOVL7Sjnxz4hijVNrHlZ3HSGhkQEqpocHvDQZRf+nYwP8jZ0xyIBjUu6C/8uHhKmGKmDtXP7SrX1gIJHjuK3XLf7YJMAz4L89iQWtouj5yZ+y0im4LqHtDHDTxKsPfTi04VZGpbO/ylNDdK+6S7TQIroHvaAj+H4pW3/uTqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223746; c=relaxed/simple;
	bh=W/mhKG17zd96PIyJoSeuIpfZQJKPMvr/mmJzM/OKflI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ID8Jk22qauXgUR16q7mfKWUxgso1tBxLgO7g3nnXXgBqoCLnQEp2DTKk3IPDzgwHj3E0jLNZklYiucpUmDmj+CaDbfTwyJe6OfGrwewkFnOTJidfbIop4Fyy/dOK5O5oFO3jeEfmiHnu9xh8drv20bLSyEzaVy0wEme9K2UCbzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQXlzR8L; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQXlzR8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758223745; x=1789759745;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W/mhKG17zd96PIyJoSeuIpfZQJKPMvr/mmJzM/OKflI=;
  b=eQXlzR8LNraQ+Y3xtNlf1PXtI59LlKU+ZGQPJE2iBxTURDHpqgPTl267
   pdJxZuwUTdgox2ecM/Sej3s4Ro+10i6Px5M4T+c0UPnDPcSzwgB19ImTK
   78mXYhWkxhC7vdBrHL5gyaMRaNOhV7lfSbdNwDQBaT1SiYCjJXgYYWnl4
   lZK7G7TTmnDZDBr04Uu//bZqRH3mEDyZynZZjaGYlUMwKGympDlh+EpI3
   I8bxWYMZnugOasXtLqjpXOHPO9OO8ME0HF9neqnsPxOdbNA7SCSUf2g1X
   nVZhHx9zn3BlfrDNGmoNzksaLYLq+VRUa5f4L+cyQZlVuhE8WEt0zg6od
   w==;
X-CSE-ConnectionGUID: j3+YupBIS6yC2mXmA+euIg==
X-CSE-MsgGUID: ivjHzv73Q/yR3q9uSl7bcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60498116"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="60498116"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:29:03 -0700
X-CSE-ConnectionGUID: 9+67nisTQhmyRki/fj1ZAg==
X-CSE-MsgGUID: yLsCrSwvSZ+zrp/OAzKOlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="175559562"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:29:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 12:29:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 12:29:02 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 12:29:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2/qSGEBJVQw3tr9Bx2VlJFzyHWLUBtWmlOIrMxW0R/imwBTB/mWsSKYuesL4ZeKLzjNkjoIPzGpRBXLsVTx2YFys5c03ZUGb2668mBe9ko24EIh+O5chGUN1ssSdZioz6nZ/H2co0qqAi6oaE/2oFtkbFdITvknBgzpzG1EzbYvH473/v/FGjtIeCsN2Xd00PJAHqxEo4KE914B2eTxPM7fCO4Cecrc89WUNK+80cKuudMtVNkXvYB+zW8UakyFEJJUZkxgKXXF2jX9dno7LmotvOCUrikeCXMUdZ0MX9DpGYNg+rX48VQHOG0r4XiKB5abDlg814l/i3Yi1deKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ORLS56tTkUDKOQHf4g0eq5OW4esoAyxHkSJ/r/j+48=;
 b=K2xPJBMwyVbYUoWf9PpBk5DaP1NjzG66wnTAfDRcpXZZgvXDfLlRw62UjaCsAMyUqMcZhyiT8/cYMgMUmVTYqjaCdNyoreTLlVxGxVbGruzJKi2zRfT2rbWHqopdsBQqaKUb8DbPPDHRtHn9GBORaBdTIask+dhzdnu9RAK2IWYuM0f/wriyJS00KxftJxI5/r8+4yhlDbydJj8LOTTAhi+ztNMoJOe1C+eFPaTw99NywUoB/7ZpualpbJKNV1mpbMK1amhCHP03Ir+GqdLaysKlzQTlDdno6F2g7ZW7KWhGCaL5UUJYlKZEwMf6v1SgbMpxgpC/f+D9u7TNi2DIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9131.namprd11.prod.outlook.com (2603:10b6:208:55c::11)
 by SA3PR11MB9461.namprd11.prod.outlook.com (2603:10b6:806:47f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 19:29:00 +0000
Received: from IA4PR11MB9131.namprd11.prod.outlook.com
 ([fe80::7187:92a3:991:56e2]) by IA4PR11MB9131.namprd11.prod.outlook.com
 ([fe80::7187:92a3:991:56e2%5]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 19:29:00 +0000
Date: Thu, 18 Sep 2025 14:30:56 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>
Subject: Re: [PATCH] cxl: Move port register setup to when first dport appear
Message-ID: <68cc5df08dbe3_18f197294e6@iweiny-mobl.notmuch>
References: <20250911204406.2454689-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250911204406.2454689-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0239.namprd04.prod.outlook.com
 (2603:10b6:303:87::34) To IA4PR11MB9131.namprd11.prod.outlook.com
 (2603:10b6:208:55c::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9131:EE_|SA3PR11MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 23aedffd-ebbe-475b-d450-08ddf6e99e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?axAB163WFGufLZEw2fQr26F8Ni6hgCkQzo/XHn+TY0osxyFMJf9Xzq9H5ZH/?=
 =?us-ascii?Q?htQYSLnwk2R+g0IIqgKwuX1kDs3TDoJb1DSe7uRDmxaeUEpswqMyJt/2oajZ?=
 =?us-ascii?Q?GKXByW5wZw3LJ9MYTOCtWataVpJdJu8+3o2zgYavcPdYmDP9UstD/t+l52yI?=
 =?us-ascii?Q?qcniBATHg/dFGejV7kIb7SxAlfY//SBLvqhdhkwBSgcyhpUXpGpB/ScHF4uX?=
 =?us-ascii?Q?rdtLAtrPGRn2IZMb2ORxfrA0I5AkbRCKTEhcNThS6lpVWA0v9mPKTyOLzwTs?=
 =?us-ascii?Q?oSd43IFnTTuf7NxmyDmex1UBI6ZTxna+OzMueWaPZKTK51dW0Ops/F0GROty?=
 =?us-ascii?Q?03z/iRnzt5791JET1cnqhvT6CJIOv4DxbEyEKBggh2x9IyubCw4ejJTuAe84?=
 =?us-ascii?Q?KUa+f6u58BDTEnSmYFj15F5No66KKhvEgZ6J2VvhVux3xktJgAMIgWraS9Iv?=
 =?us-ascii?Q?D2PaJEaHsERHje4L7ALrI8KNgkQQND/BX9Ji+92KJojGTDvDxzxACWV++V1r?=
 =?us-ascii?Q?jYNR3usDDuX0oyvU1ZQLs3g9E3zlcgMmqjlxKFtBh2l8RZdkneKKxCND0PrM?=
 =?us-ascii?Q?k9dXl4Cm3j4VnhwT/o3Y9J278iZ3JMUSWkD6s1aFSrN6cIwqMYMQKRwb0xD1?=
 =?us-ascii?Q?+HHwsEwz+soQhob8ikrZhRGoCxFjiqbq1GG8rdhtUJkXfaQ+wNq+WmDSCuh1?=
 =?us-ascii?Q?54/RTBCb/pJlmCPhDY+X04q2KPV9+VF5MlcaS868J5JFzRGKLGjlhcp/mvdP?=
 =?us-ascii?Q?ofNmlNZGeUvjsu0d8bbx5FG4OE5Z238Ja79tcbEshhUfp4iH52o2JiMw0COs?=
 =?us-ascii?Q?Qjw0ynQZwtD+tVJ4VAiKopWoT7F+5Bh2Asf8vUi4iTdV+jLKu7/YdVKwm2Uc?=
 =?us-ascii?Q?C4tLzr65gM9ufB55u5YHBmW6jTv+yfhjsQhLNR/6JhWfdCZ7VrQUs54mWf9x?=
 =?us-ascii?Q?2lrwEu67pPzyPHXi/p9piYwd9rLIdtNtmQ/6ryquPxQcnyeu6b9tbBVi8U8U?=
 =?us-ascii?Q?O/pBDZsTc7F8dG1qbQEAMHPdFCcmRx2ta9w8bhscwFgYHHdzM1Vhlo49JlRQ?=
 =?us-ascii?Q?qFFLwxMOYz9btsZB92Pgpw8LTgCw2BaKTGaHI3FqMbGbLLQa9qPyd+YDWNrK?=
 =?us-ascii?Q?zQWcYe9I+jSPuPk/bvdneJHtrOmWe6GOqwVZwEBpk2SNlsd2u1xv+dIFrgdo?=
 =?us-ascii?Q?YQIZs4FcrpOvTpTpE1EbgkiidvhzUjd6WwcqppBaviTHPOiG3w/6fGOwXPlf?=
 =?us-ascii?Q?GRPdHqi5e53UFmFWyAnjdgtDQAEZ7sVjVWLzW4HQOirRkjB49SRDlJu7OCnl?=
 =?us-ascii?Q?uN61HqoHcQoSDwgJyrVv9kbKqdccdyzmdb7HKykjpsDuLLDZNFR4hixLrT8J?=
 =?us-ascii?Q?BKuCznsEpZSVJgnAe/odRENo+c2rmxtjq6Ow+BAwLFQc/u3LWr6UyspThnFW?=
 =?us-ascii?Q?ZPF/co/OPE8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR11MB9131.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dyL7c89m6Csn2K8nUFlxK7Li8y1ymwRJo2DlysslFeI3gKToUPgaqD7U3g1W?=
 =?us-ascii?Q?nBt1VjKMcik+dk4YfU/ZmxR290ec6iIk/DvWzk7DPhj/7tLdW56+V2KV5GQy?=
 =?us-ascii?Q?ucB963CRmXIB7hfG5jaD2Z12pEfdyjUL1m3kdKgPgm+hSqd5g11jULWUHOke?=
 =?us-ascii?Q?wnEG2Nd0aswKShtwGFcITfUxDGMj2BVdV6IGqzPHCSFyR/yExvilN4pcqzZq?=
 =?us-ascii?Q?7/t9g4+2Z1W8uWf7xJIdCQ++IeN9GVjTqx94B5U+SU25iLLSmKbj2wTRkekP?=
 =?us-ascii?Q?jbeLpIkuf0DyTCVQebG5eMu1jnQzmayiEP2Es1ki4/lhVKBG4UhKM+lEB9R2?=
 =?us-ascii?Q?1saR2A0BjrPZw2CYb/YWriBNtlGptophFtXDZqX5FQCFzUaW3/Sq8MHpWheP?=
 =?us-ascii?Q?Qx/YwTTrB/FwhHUtcUEQQWbuuJVEp1i4WaMTHHdwmfOG4qGLh8x9jOML94IV?=
 =?us-ascii?Q?+3Lh+v6LLmNIkZNZtBgUbg9gRaIwMtxPQrYOpJLp+ysLxNwqZdrEkq07aWkF?=
 =?us-ascii?Q?jaT+e2dxT4peYrofhvByaPRVtlOEl0HhEfeteype8PyPjWQfR8gqu7wYhuTQ?=
 =?us-ascii?Q?XqI2mIFkhv4+rSWD/NxIOJY5vdxTrlpoQZEcWKJRElrr+BGEG6Xq9Bt3FdYr?=
 =?us-ascii?Q?THytROtJLtmGkOjSUCgVeM0TCYUtCa3CDolXYI2/f5iFnXqzPFdOFiTrAyaK?=
 =?us-ascii?Q?IymohgjUc+jQuVlMvhqlZXjRtQm/2IUOZsLgGnCMy7eUjiytrDMxryzymGZ2?=
 =?us-ascii?Q?2RLutR0htGOx1KxEUrFj2Vf1JwziOUXBouXD+tCfpz0t7ArizhGljeJn/g0C?=
 =?us-ascii?Q?k2oZGXrPNkMQhhk8mUpbreagNzcATLz+FlpC/3JRJkhl3EY7Ppmp06Se0uqW?=
 =?us-ascii?Q?h0G2vZ0rl2jO+d5WzGuFWLKOrqnd+mu76ud+tTRWGAQOPT6fureZM6W1CNMs?=
 =?us-ascii?Q?Z2j6HBBCjXSlsYFL36YMOTI+VzYFqjPYFfFPi4WET4oumEHyonDdHOZ0oInU?=
 =?us-ascii?Q?jGutTJNmHT1InQg6PvU15iEtJTZ1qXb4gwU7CKMnIpdLKxR+wF5gTAjFuGU+?=
 =?us-ascii?Q?1ZnHZdysUSlV8TgS9T75axgYfOtZcUUxcdb2MHXJIzK6aWa1Xsjfri1WRlS5?=
 =?us-ascii?Q?H+3AzZ6E48cZ15xzag1lmWbrBCSMiUZFXaKkNkjGRM42xBolQPm5xeNhpCXu?=
 =?us-ascii?Q?lBKaN8wPTZBrpbgINzRIGouc0iFkIAJVTuMjUl0JshOq5i11cW0QLkZ4hHqI?=
 =?us-ascii?Q?kqb0zCWoIg+kTVfLpdfed+FYEIY1TeEIup9rL61+NMQBXMkW0rlD5yKUcF87?=
 =?us-ascii?Q?fbWncl+Gleq9PQH7XirrnRUpE5lo9YiJ96d2rDFE3pn/v1FpSyISgpmxBwsJ?=
 =?us-ascii?Q?+yyWrd1awFZroFHwb65g8PYSHm2M/7SODkLi0ikuMoEc2fKVx6O9uME7qB4v?=
 =?us-ascii?Q?corl/vYJWQYepksOtHf92C2I3zxVT0USX9sVmP8SUMdWi3ft/INHtKCygLmj?=
 =?us-ascii?Q?mE0nmAH8OB7Xro7X6EyOThX/mapjkY7HlDt4ccj00jalUnY4WM9KVVrounAv?=
 =?us-ascii?Q?Gsdluux4HcjvB1WXZZjhnp8+fwDlufhjQInfiBfI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23aedffd-ebbe-475b-d450-08ddf6e99e96
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9131.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 19:29:00.6976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1L61E2smuLMlyvnlJsv7S6B1akbOLPbMYQsnJl86wJvR1rTo98hG+0KyiqyyMZGsNopCvfVX54T1Th5+aJ36bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9461
X-OriginatorOrg: intel.com

Dave Jiang wrote:

[snip]

> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 76dd06d282df..416d45516d82 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -867,9 +867,7 @@ static int cxl_port_add(struct cxl_port *port,
>  		if (rc)
>  			return rc;
>  
> -		rc = cxl_port_setup_regs(port, component_reg_phys);
> -		if (rc)
> -			return rc;
> +		port->component_reg_phys = component_reg_phys;
>  	} else {
>  		rc = dev_set_name(dev, "root%d", port->id);
>  		if (rc)
> @@ -1200,6 +1198,18 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  
>  	cxl_debugfs_create_dport_dir(dport);
>  
> +	/*
> +	 * Setup port register if this is the first dport showed up. Having
> +	 * a dport also means that there is at least 1 active link.
> +	 */
> +	if (port->nr_dports == 1 &&
> +	    port->component_reg_phys != CXL_RESOURCE_NONE) {

Should this be
	    port->component_reg_phys == CXL_RESOURCE_NONE) {
	                             ^^
?

to match with 

        /* Note: endpoint port component registers are derived from @cxlds */
        endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
                                     parent_dport);

in the memdev probe path?

Ira

[snip]
