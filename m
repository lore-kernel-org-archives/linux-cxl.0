Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056831A238C
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146596; cv=fail; b=P9xPg8/o2+Zm33fWP7mmr6GCv7gflF9JHHbEHQ3K+mxl6DfyUdWrvUSeSXjlBE63FBgG16eFmgTTmamjz7k5gbTqEQI3GivnN5z9EiA2gH9wE2SYJDQ/KC0AyLkzVQtCUNhHTS9tEGzs0ngXZ7v5L9jd9/2SMWrScrsQ3++yH90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146596; c=relaxed/simple;
	bh=tpIkS5Go6qOYv6p4nJb4XrsServpdnTI4vhuWQ6hvVo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eU+EibQSLdt2knkNahehQG0tKkSBprlr/1ZJuEWVDmla3cNU4+8fMV/VpT4JTr1NrDFQ1zfdVMhmSkkdwPRfKDOAy1GX/hSVMt5wDv3vHLoKhSIp62iv90+nOWTxUa1Ve00u/d7wQj3YnYU2tNXS+HylohcwxDcMAL4U342IHSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfAJDM/3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfAJDM/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737146595; x=1768682595;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tpIkS5Go6qOYv6p4nJb4XrsServpdnTI4vhuWQ6hvVo=;
  b=kfAJDM/3aelshpJm5VFDOBDtTYH7rgXL5ctPq/iWSHppgFoQHSunqWAs
   4YG9CJtDv9Cq0YHCVQzHA/GP0x+WVPWzx5zuSLJYIVO0sIzBUf2AQg0/k
   MLHmQdk8FbZfPK0zw5HeVFrdRuzw4Lbs/56xPvTVphfKZrwnohc28lNnX
   jjd7tAOPHJXg4ghZG7Zb5fJICbShyZo6bwtnnGKCM9s57sBXUsiSh3ZqU
   gBo355jbui50+RmjrICDz2+Esy5MJHbG/XyycupQ3cErutGjVFtCr10UQ
   wmgHau1YAMc3ulPFbbZ3zI7cOASLboR7aJZXzJpoOaVI+ZerXBhCGHTYk
   A==;
X-CSE-ConnectionGUID: jLTKLW/XRM2wLuzKaa0tyg==
X-CSE-MsgGUID: G/VNGApRSOiNlN5YedUUCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48182368"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="48182368"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 12:43:13 -0800
X-CSE-ConnectionGUID: kWE96tzGRLqeiiIQhSih5w==
X-CSE-MsgGUID: OIe9iKcER9qr6zbnNfn1eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111016004"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 12:43:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 12:43:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 12:43:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 12:43:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s41z8GVw25K8O1BmOP9bSGjIie8VSI2gP2OiGbGo/3odz3XrN5GRNA3IRk92eVKpQ9u/NKgfwZ8EAvmFPr22J7Eh9rIeRmhao4Cx+XlycQSmHRoemC2XknIr1PA3oW2RxMZ50ttpC/6cPugTA95+jHSzk8MMbX/RD1WDn8SGkz7qXPJcKIQwN+6qckIIiM38qFk0H57n+9f1GqUSZ3DB57JfuluANRqITRy5cBFXYdBlPzQP1RXYLsz3rQh434QoWkg+dY6b2gDWwsKeiKDy8uFolTAJhEFoCnf67a/cCssahCHOhOAm6rmDpJs8/6vASKkyD/7rz9VcR+IRoxeiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGLNfg8RnvZmQlZ95tF7zNR7NlXGRjUySLDdzcAoeF4=;
 b=XeXgoCdQgQ2K1R66wDPx7vFkjF39KK8+haIZYUbvDXjvain84XfEfD+M5/UBD2YlMbJ0+IFUvcr35zgb+b/yhJfe4L+IKtDqJZweYJiNX4tVZkxHdiBZL6IWiso89uliRP6HZps8b87WvWtbmD6rfBa1KYdIuirddtUa18S+mTEy6kEPuS9VB79+TtJCA+35TqQAinmosTletdFdzpGhJ8zBwdQ3w2vFvrcxW1g27nbcraKSyeDuVYycm0dNR1Q6dgEEg8oTDaxEJ//7B8BrdJx6ZqiXuKEIF6uaq+8FqMk77QTDlnKsCLc7QalfLOCVQ+GyRrURsZolVVjTWZhpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 20:42:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 20:42:57 +0000
Date: Fri, 17 Jan 2025 14:42:53 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <678ac0cd60e0a_1f2d2b29481@iweiny-mobl.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: a2aa35dc-6e01-49b5-ed45-08dd3737861a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NgoFd2ZWchZ9yNCC+YhDy+A0KLWIi9qR2M+4ePusaoeL3hoUzOGnqfvPS/d1?=
 =?us-ascii?Q?OzFvA8YxwNBQF/7MT91l4uZAqvRZZz7doDglgozTjFgTXOvfc0h+els2LFfV?=
 =?us-ascii?Q?5fnKeTD0hRUExi1VXe751bvRjmvliGN5ULOb4qDY5YL3FsCd5wV9opyXOA5U?=
 =?us-ascii?Q?sK2P3NiRIDJBbSA5tQ3kVvDdM7zZ6Ibnr4udw8+i1yZS0hp0bkh+v6ReeLHa?=
 =?us-ascii?Q?OOmZOkkq/x8OoUEOT3fBogFHf5VnaypMSTydn8WlMa4g4KRugErfsoJ9mv+O?=
 =?us-ascii?Q?Y+hOWNKWYsaqM1MV5sJZ6L/CssA2pvOuFPc+MC7VGwgDKsWZPNwB2n+ctIwk?=
 =?us-ascii?Q?y8Y+amuVhSvC8QY+RV2mEmNe5hEIe7/5MzfmtbY43OvBpgKX9HyhFIo8nT1W?=
 =?us-ascii?Q?1srWHj50iMWxCsPYqlYHcnjm+99YfWxHzFvHRY/jlx8fFeQnNZqjjTlGB+j4?=
 =?us-ascii?Q?SfkkRtckk/GpKhq6mpepqMbRSa+u4+vJszQ6SBqEoxpmyjG4yM6Jk7VxmNkL?=
 =?us-ascii?Q?ea5upl0NvMVUWPc1tKngf7F+/fUE1if4FG9vwmluzBN4fKUYrSSpoGPvgoXB?=
 =?us-ascii?Q?JjzpKGbwvap9kKtm78yNYuGWziNithSNOB6RIJ3qCiwR8bbrfgoYcMfVh0UY?=
 =?us-ascii?Q?tiWLi/+aZ/OEFTQ2QGYCmqur415qtiuBcbdgGMast2Kz+KMe24TpD6QA3oP2?=
 =?us-ascii?Q?KFESPTQ3f+dZ/ZIntCTue3di8UOO3motqyIsaldCe29jzbbJJwGTObT9A8WM?=
 =?us-ascii?Q?1tfYkbc7MLtipwNf1ufclX4qeUu80HT0mJCBitaN8/nlAn2AiZ983RixiQn0?=
 =?us-ascii?Q?4fqwxF5KpLvy39YBFVAdNOmgSMamvicDJ+L6E7PZpIin3ga21Z9hZsz0d4zM?=
 =?us-ascii?Q?OdJOCIo1EB9h7pm+uQ0uJQnNfxjIWACIxBtzTALq8c3VNl+saqINu3oucdzY?=
 =?us-ascii?Q?anhG/yYsZafCPXN3kpFhqYQ4C27lke6JFU+wuA6cbH1EYpxnsNgvcZwj13fa?=
 =?us-ascii?Q?fVRo3TMecGVBdxVLO5/ELGeEw+mcseOngj3pS9Wx2UpR8V5eb9NIEQerO8FA?=
 =?us-ascii?Q?iq5PYfdjWqpWHxBNEUl9Nh+e2a9epU0GvkXih9wtL9Uuk4LcrNQR4DHQkqQt?=
 =?us-ascii?Q?NBNgnCT/27ssugFLvz0qb7yIRc9ahTn2l/DaaOldeINJ/YwBG2rQ76DNQFgb?=
 =?us-ascii?Q?EVW0Kej2UGCk6wQotKAoHM+s83xxLW0tRWqrQu+okYeLEtQu+nqEameuUIkA?=
 =?us-ascii?Q?1NC8N349pi+FWuwnF0isZIdg6gsRrAFB+sKoTcjm7nF7W++GziprOWtuW78A?=
 =?us-ascii?Q?hTTYTbKObqyWwkf3Mmrq9GBfN1LUXRSrsjIeogvzQoE8EXn1BUjIS24C1CNH?=
 =?us-ascii?Q?eW5T3SHbHw1l97PvKCQamLZXrmol?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pkae3UHgPGYipiCJdC9SEBU7+TNLA5IMltJSZOBh/UBrxb8A9TQKB+JezpjQ?=
 =?us-ascii?Q?znLFixXnqfu6+HjH3hT97fDGRnzvuW6AoXmcWwqpUuBdIBTxBmmPZbJp2xvF?=
 =?us-ascii?Q?OHpEmRnMQ85zNm6ixoD4yl3uhZryeyk01rMvIPnZDy99Osc6XhEPSA915vrz?=
 =?us-ascii?Q?NiT5IV4b1IhllpsZgGnMrj0YGv5bJAqmqHGXmpluA9o6XxBUuIKfoZf+ia/b?=
 =?us-ascii?Q?fJyRMqmtpnOZfAz+cPI9pY3hScTdKYaidwbqvbhXFv4j9+EmfGV2N+HL0/Cb?=
 =?us-ascii?Q?Oz899cBp47bS+C3Kx92iPEjDoB2uGnp14lvfgb6GOaRTOvZOw9dHnpeSxqew?=
 =?us-ascii?Q?DfFZ6yRlu7IczvYcB538PdHAC29fILVYv1IX7unBgGqDeb1MtwUN6FhQU8bR?=
 =?us-ascii?Q?QPKW1Kpck70ksLVFZRv+VuFFxY1EVNkFqXhhymKB5k8ol21vNyc4tAzXubPT?=
 =?us-ascii?Q?1WRYAkVD0r/QE1GS2Cm3j05uAH4jqgYgyjCqh1I4Pe7z/uaOdsa1DHrrtUKD?=
 =?us-ascii?Q?nU7g4HvJYliVNi2iaNldfFpp2KyAocRD+8t7VRhud7ELUG/Rktg9p8c1vTnl?=
 =?us-ascii?Q?YOX+DoyU7h38v55LaacMvOWMqfFt1Fwo4ys2idrjnwATx5Xedb56ajUSs30M?=
 =?us-ascii?Q?VGy+cAe+/wwzWccTC2eBYDMCqPF3iiiUXGc5MAYP7nWJMC+Ch0IViSB8PJeL?=
 =?us-ascii?Q?Sj5yEYb+2jfnUoAm5nwnl+Yf+Y3ooLVMX2OkNgd0BJeTv3S+TqJFNvHVbiru?=
 =?us-ascii?Q?xU9ij6ouP7ar+dfQyb+BBM1IIj2PHrLT08uVr1VELzNoJgJ/4WQQcd2Blxku?=
 =?us-ascii?Q?vqXsVWzkXgbcJb60mRbzDn1O6KrsgXjytsOj9iEA2jO5aYknKvT2R4+MKevq?=
 =?us-ascii?Q?lU+uv4pwWXaXbpEkV45ssVd+4pDkTRrx8+wlXbPXi/qu0EcK69DExzDEswGC?=
 =?us-ascii?Q?wU/WsvBhO7ql921yikHbzshc+YUo0yfR7XYKVB3fE3jKyN1Yhqxeyc2mG6qn?=
 =?us-ascii?Q?JUwjMcqU2ma2lLBIJ/T8HCEBU13Jg6KYcEjTi8WrUV06JzCRGOW+KoxE8azw?=
 =?us-ascii?Q?VCsJWFTxW9+vdb5e2BtwB5Hg8lU5RVaPvY7rM98mh1gP5gXYPVmHlb/n3MGE?=
 =?us-ascii?Q?ClPz6n2zk6YWVyhAclyCtI+hOWhFp1ibYYIxBSNlvK0c/ztDy7UO5UYyscoM?=
 =?us-ascii?Q?9qnuINUxQLGmUODR6sIhz3x0IeXZYbokR5GvfQ7/lIuvuLyuFDSHX8Sq2iRP?=
 =?us-ascii?Q?b1kVb8qVCWmgsfpQyHbFKX9elC+GU1ixpdpt3149cU4B+r3jzJYWiJLJZIFN?=
 =?us-ascii?Q?Gw0uXMZzvtV/CPtEEy5VmeWNJrXSXrS9TITr8UIqVKaP823VeStfvFxsFyen?=
 =?us-ascii?Q?FJ0BuRlgGDHRlIq6pS55LXCnmGpwgm2ONvUTmp+lclWmqscPkjkLlajJ0Ntz?=
 =?us-ascii?Q?8VLZnBNh+kJYw2LJKZBaRBZDxdzllvhNvY++o33vl7KrIqO+JZ+HA43PFRuL?=
 =?us-ascii?Q?r7E80zpayboc0WGkQpWlkuHZoJaymxegfb6V5CRzKk2+rB/+GMY9QwclwJ43?=
 =?us-ascii?Q?7+KNl0q9wVRvO24K1UsJ5RsR8Ap/kNWJujfI2c4l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2aa35dc-6e01-49b5-ed45-08dd3737861a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 20:42:57.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEpA3U6MTtsy6X9LtSs4umUlmeKofieTwxlA6f2UzT56jHvnMnPw+yLYXhKbG7Qi53MBlFWrYGA7rnPphpN8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
X-OriginatorOrg: intel.com

Dan Williams wrote:

[snip]

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7a85522294ad..7e1559b3ed88 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -342,6 +342,75 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int add_dpa_res(struct device *dev, struct resource *parent,
> +		       struct resource *res, resource_size_t start,
> +		       resource_size_t size, const char *type)
> +{
> +	int rc;
> +
> +	*res = (struct resource) {
> +		.name = type,
> +		.start = start,
> +		.end =  start + size - 1,
> +		.flags = IORESOURCE_MEM,
> +	};
> +	if (resource_size(res) == 0) {
> +		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
> +		return 0;
> +	}
> +	rc = request_resource(parent, res);
> +	if (rc) {
> +		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
> +			res, rc);
> +		return rc;
> +	}
> +
> +	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
> +
> +	return 0;
> +}
> +
> +/* if this fails the caller must destroy @cxlds, there is no recovery */
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> +{
> +	struct device *dev = cxlds->dev;
> +
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +
> +	if (cxlds->nr_partitions)
> +		return -EBUSY;
> +
> +	if (!info->size || !info->nr_partitions) {
> +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> +		cxlds->nr_partitions = 0;
> +		return 0;
> +	}
> +
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> +
> +	for (int i = 0; i < info->nr_partitions; i++) {
> +		const char *desc;
> +		int rc;
> +
> +		if (i == CXL_PARTITION_RAM)
> +			desc = "ram";
> +		else if (i == CXL_PARTITION_PMEM)
> +			desc = "pmem";
> +		else
> +			desc = "";
> +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> +				 info->range[i].start,
> +				 range_len(&info->range[i]), desc);
> +		if (rc)
> +			return rc;
> +		cxlds->nr_partitions++;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_dpa_setup);

Why put this in the middle of hdm.c where it splits up devm_cxl_dpa_reserve()
and __cxl_dpa_reserve()?

Ira

> +
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  				resource_size_t base, resource_size_t len,
>  				resource_size_t skipped)

[snip]
