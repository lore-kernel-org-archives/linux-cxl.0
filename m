Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C26C152
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443556; cv=fail; b=VDKHkzbhImYdeVSQOgWmHoXqMB6VOM0YXe7FqOtQ8HjK6GHaaMdntVv//WXtlsDa+5umaPPbaTCyQAoqzVun0oSdmSaQBQlDw9qFUvFespYtJL5VU4xR+pIRTSnW0Z++dBJ5dYCxn+PJqEZE0AjGx9ggiLwS43G7qNhNFGJVC+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443556; c=relaxed/simple;
	bh=OQV6VK/ISRpprohCP3akXT4bXyT/S1xhpmrT4Wac2SE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=od1hAsuX9j7kxlewIHicDQNfhrKKiosPMJqKXhwxOZOODLTKmC2nmfuBf6CtExn9kGjLpXNDwGkl+WEt2l0nS+Jw+3YpFKg2ISDA1NizlpcqjyZLyUzLEouQiPTXUpShhOQ4IHK74bncLoy82mngIzs6UJU3+f5JeuWYrLA8UFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNIqH45+; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNIqH45+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714443555; x=1745979555;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OQV6VK/ISRpprohCP3akXT4bXyT/S1xhpmrT4Wac2SE=;
  b=TNIqH45+OMhjyWk0Ovfw4J23z2wEYwPIzjoCRdOpNdwjlzojD7M/lYAY
   l/MLL8Kp+Isbf0b7jGDTCxGDmWIoUz3rcMJYIQiVDsVETxxpKRY+OdhEJ
   5PFWnBqqFxN8KXzjDzMcRRSL1X/CewSUZWMeq2qf6F8JwoL2UBDaufTyb
   NsFOk178ezBiyy9cIaG8u0zFHN2P93HJQJ+SzZKopFSgUsv5SL0G8whTI
   oQq9K7oRZbi8NjHgg6CnPeh0TyEqSnadL/JoXabhj1+99dCDUfN+na/j6
   3T2k6feqMV5BCNyl8sB+lA20zOfF42+Z12x9LoYfVnUdiC1HXH47ze5yj
   A==;
X-CSE-ConnectionGUID: GrWaWYh1QTqyK/yr5Y9IwQ==
X-CSE-MsgGUID: FE/2SGaUT1iNzP4XafYIpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="32632221"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="32632221"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:19:14 -0700
X-CSE-ConnectionGUID: Q4Br2/TmQJGeDVmq92iMhA==
X-CSE-MsgGUID: 47cn5PibRtqLe1NC66DSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="31114319"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 19:19:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 19:19:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 19:19:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 19:19:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 19:19:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glQOBvCaqQYieKyAkhZ5MnsoD0Shi3dpXah3werbq9qpkUeIH5u6OCJXK0ssZ5eHrpS7kV9RrpGzIeYcWp7FJmK66yOwlTIyAmfgQvmY4Au3dUeKDNC1qlelNDFJ15tvSLAwUzVcbG3YvJyCjC7gnJciBlaMNZzFer1ohDoeIRstIV8/2d8DGudZBAReYYdAm2p8SRQr0ifgAWQe8XmwTUA8z9Dpy4A7MuhXfvvuB7yfiG/W7ciYvHqNvDN4IWymsCD+EpHTn0X5BHVjGfX+A+wj+7yEIUOHpD2cNFpfROnA1X78S4LFU46rG9kdeq5zRAEtlt++hkeAoQtFEkvBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJZ0lqSy/dvNR/MmvK1OvMCh6xokHI87TwdIYkD+WZI=;
 b=ayQfEN6LkeOxlmJZFk+Ja2U10cbUvd1PdV+7NVcrcBRBZ9Z3e9BT2fhBKDt2GOme9SXeAatpTTBVC/ISxB6NC2UUb43pxzg9UMU2LDQ6yXynC6PwHtS3zih3tplhzZJuGmHuqCnBeq+PNpzAvf3iR7AYdbS2ngLWsRIby0yFOF0L0LwC585b6kkPHgI3H5ixNXrbhyoszd7+O0t99X0sIJw+AyzBLmqcN5QfXaIIerid6a43Ybl53aM486Oq3C980JYaKW9+Z+5H+p3Jg11hPucNjcIENwfaoqgvEBZ2Rdx2BYZwE42ybADZL0bPJYsO4Cu/uQhCWyEnwqovBFm7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 02:19:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 02:19:05 +0000
Date: Mon, 29 Apr 2024 19:19:02 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Shiyang
 Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v5 4/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <66305516ba200_1b13712942b@iweiny-mobl.notmuch>
References: <cover.1714435815.git.alison.schofield@intel.com>
 <ff90c45820c502c5f39c671fb159cc7b2ca8123b.1714435815.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ff90c45820c502c5f39c671fb159cc7b2ca8123b.1714435815.git.alison.schofield@intel.com>
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 73319607-73fa-477d-4bcf-08dc68bbe8ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oc2YK38XLQWp0WriyaO1lmweBlFvwyTbU2kDNxR6gEDKCtyixu1I9+x7qLFb?=
 =?us-ascii?Q?ZP4FLJUIr2qdzYKutNV/2pWMIP9fLAddVancTwWkAr/ooPWzyWfmfacWX6ss?=
 =?us-ascii?Q?oVDoufMvo82dpsnIFk59C2LfK8/LWM1oUghkx1Z1yv3PHUic1xkkvPwg/0sw?=
 =?us-ascii?Q?GjVPw83xYAE35VblmuVBZlUgISWUMekAYlmAVXeEbIEwBmf1fw9WlJol7RsB?=
 =?us-ascii?Q?hm6NormUDZ3HJWXM2TAdt8kr2wxQ/Rw3KC6w6jYg9gO69VyEJVn44whuZU3V?=
 =?us-ascii?Q?B6dtpmru0k6rqmF6Bf8wpNCoHosZ5UjV2Mgs0hFFiYpvb8DLRRZkebK9sBM1?=
 =?us-ascii?Q?2H5jnx7qoHeZn4wCJ7TBIldXpV5bHiSaUrvrFeFoggWkOxlXO2gXdx3/2+pe?=
 =?us-ascii?Q?vIDgHeenjXVwxzn3CdAqwvgVJ6wFOCpnowxqfSi/XR/mpii0qZNd+NSUNS28?=
 =?us-ascii?Q?YjOFOLZ9+C/N8ufwwfs9Y/R+8Pj4IeHr4XoglWMSLFIxkuacCILwJqTLzbgz?=
 =?us-ascii?Q?0Il9dxbj9eIbW5YenPKsho0W1vxXP8ouyT1G1EKSv07U2Vos7JcXZCHkssLe?=
 =?us-ascii?Q?l1x02oECEDMYwCtmZnJL5yF3S9nlnybJc6ycNGVBxXOgjrLQnG6eii/zoI05?=
 =?us-ascii?Q?QffqDtmM9MBWV/rL0tAzqL4NyD+rpbHMByJhdmWHnq0lCR9t6qaXQoJSmzjx?=
 =?us-ascii?Q?YW9pT7xPO3VH8sQXMxw8XPjkfKNifx1hQV5300leG92io4gyLtdMjBUeCxhk?=
 =?us-ascii?Q?o8aroqGDAAUliQbieUA1Q0zsaXjdMsp9TMgdkmWsDugIhs79NuimuX29w63b?=
 =?us-ascii?Q?OJTDTfV55XEh3txRAPXtPLxOBWjEhJRuuX5IEZqOClXCd9cl6I/aRLffHc+5?=
 =?us-ascii?Q?XVQdlExmL/Yypsgp6WvwShLb5TyLG6SUjjABoErERb6sBZ6lsNmeGS59n6u8?=
 =?us-ascii?Q?wP9FLaXlZEyIGPclSX0jxkt7JQWQoQXO/Zb2YeyyxKqLwgi39kleq/4CBWOo?=
 =?us-ascii?Q?7HOXrYXZQg4zko/Gs4mmNv9IaP0t1/vhzRierwvB413gvWR+gla5K4PMaPhM?=
 =?us-ascii?Q?n90bOpbaNBo0ZL4769onQr2ogTzQg3x8KzkMjeFICy8keglxdbbB8dIyl6SA?=
 =?us-ascii?Q?lbAkgFaGLmr2jh4nxFgbXfw5mE+5WNqqyc3dc2GfU+y1ISBy58ii1eKdPsfV?=
 =?us-ascii?Q?6f505mCN8CC3QjvL6k+hz5uGtmtlSR9zpX+NV6ePRc+U285K8Ov27STduVkX?=
 =?us-ascii?Q?lf+6MDf97SHqKcMUp+OWaRMcZI4yZCkXUakMDa4BRQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L8upbXKhSKyjECT7W4ATDxVOuH73A/ZW4oi3vxbIU56PW7iQOOcjRPgNGds4?=
 =?us-ascii?Q?T4keIbDzUfrXXRzFL2clx056kpLml+PLuw9QpWzQogTGYhZtuYLXP2YHin0L?=
 =?us-ascii?Q?ZUY0thf5UQGZmIFmcYdOqhjTcyVou6RDLStcIo7GKRhjTwgAYdSW2tr0FUei?=
 =?us-ascii?Q?ZdA0cpxtK8NhvsygqmjUlo4guQdPleOKuKSzbAfV1ajsj4GUqP5Djjlt2m/i?=
 =?us-ascii?Q?qB90pCMeIWQ4nL0goiNxskyqaiiZIrxhEXnSoMruFhjvGuLB3dW+PQ1cNq6s?=
 =?us-ascii?Q?YBAMXR3S7FGFA7J16V9LtsfsdhMMRXXK3+WDCBfy9KBCoDfXP69EYGipgsKl?=
 =?us-ascii?Q?TPr3c7Cs12MBHrbvwPdMz2Y/w8MdGKscyBE7YAI7bmaQCA/JPX6Au5Nus5+c?=
 =?us-ascii?Q?9d4DnDm78ZdqrQyvvwdG+MaLhJQ5Z56/m27pMXVkdxgKcUblDHVuO7GbtJVJ?=
 =?us-ascii?Q?q15jkurpSzEDAoiMixJVcdBM2r/0c0XuVUf5VuZVHi22D/8A76Q0aLgBP33L?=
 =?us-ascii?Q?bYPNivUJDeGJS8X0Rx1xMFRS1boVZ0E+JyeSCrgTms+Wd8Y2SUTEmKPlYiH0?=
 =?us-ascii?Q?mPAI7PuR1SyGnS19LP/5YyP0aE/b2vvJiRbXOEnZ1CO5PpbYgYLYmmESHmBA?=
 =?us-ascii?Q?lryJQEwrfNZ6Hqak4+IAcToSjWz7aagIs4hW2X+BVX6FKz4w3fupe7cRL2ez?=
 =?us-ascii?Q?pLJgV47CTmiMDXW/3rIOtWbjOryoX9AG/tfYWUPKit29Gj0by3z9wcyny42X?=
 =?us-ascii?Q?vX1pjjJjBvRiywELjy4JF6mWvvRNHZLCGlkQJzYwG/4nQbejbpstPEdZT2p0?=
 =?us-ascii?Q?D1E2yxpqFOlcrjWMHBltUIvwRwHZ+/ZZkE3WIhBtHjtYysVUgnqiEDUijONv?=
 =?us-ascii?Q?t2zhpsmefuzuNOdiVAZRTquLPgE3Ad5xLHsoaPjhGesnidFa2t2EhvgDYx/U?=
 =?us-ascii?Q?c1GRs+3ACDSjHiXLm7x83z2eo4h94oIabhWgLcZVl7UzHWdd/+AQEWC6h5fD?=
 =?us-ascii?Q?P4BRT3m8tDI88/o1xSNhc9Ya1pYCRJ37hsKgL5RlOz+EenbaD/rTvfXg56UA?=
 =?us-ascii?Q?a3wDEBdY0rhGsMl6y52QHEbFzluPBK8EiO/skSX+IdAG8V9cz/LmzGThU6GI?=
 =?us-ascii?Q?lrKBSYLErf6c1nxEeGXbUdb7nulDrUlqQmATQgSHUsnIaW4fufSOoNxy7rdh?=
 =?us-ascii?Q?ou4XObIBlk9caiFvQZFQ4YkyD5X0ZOc5kGpIVYjSLEodZO9aIhfJZEe3VyrO?=
 =?us-ascii?Q?ehM4yKVOWZmC5zi0t1+NPeYDiQx92xU7ntCQuCtmHSwU6VD6P9psOLnZEG8T?=
 =?us-ascii?Q?cWNzWJCGaj24KOayUk7I2RcYTYKyfr/m5rIDwKBKJfshUNzLv8/38Cawgivt?=
 =?us-ascii?Q?kcMwn2Pb+KmH6j4In/radQVx/q1qkDZGzk48NfAzSJn36xWTDOisdrF9cQ3Y?=
 =?us-ascii?Q?HinWfeLXkdmAzXtOgDkaS6X66nwCXslH2G9p2xgDy4t4HEWXKMi9RLREUXrI?=
 =?us-ascii?Q?WBfLaVVB6BA6J8l0I3kOs37DL8ug0DAyqc3oD1llzHHz/Nm9IfLgYxaANgqN?=
 =?us-ascii?Q?jbeiitK9/ziLYsk+R4b3KBsrBSByfizB3/PEYjXE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73319607-73fa-477d-4bcf-08dc68bbe8ef
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 02:19:05.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7ug6bOM7wFdgChLbaA+VSS5PYENjEmQTwGP0+xl30r0CkSfFvmUs1kvmuzIOQU85SpnQTNUZjX1eWnqrH67ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 

[snip]

> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 03fa6d50d46f..5342755777cc 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -91,11 +91,21 @@ struct cxl_event_mem_module {
>  	u8 reserved[0x3d];
>  } __packed;
>  
> +/*
> + * General Media or DRAM Event Common Fields
> + * - provides common access to phys_addr
> + */
> +struct cxl_event_common {
> +	struct cxl_event_record_hdr hdr;
> +	__le64 phys_addr;
> +} __packed;

Was this left over from a previous version?

I don't see it used.  Nor is it a defined event in the spec AFAIK.

The rest looks good.

Ira

> +
>  union cxl_event {
>  	struct cxl_event_generic generic;
>  	struct cxl_event_gen_media gen_media;
>  	struct cxl_event_dram dram;
>  	struct cxl_event_mem_module mem_module;
> +	struct cxl_event_common common;
>  } __packed;
>  
>  /*
> -- 
> 2.37.3
> 


