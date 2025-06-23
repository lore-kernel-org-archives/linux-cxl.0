Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042162BD010;
	Mon, 23 Jun 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702347; cv=fail; b=ZVz3Evk1VZPwqVLv9xVWMzT9caazCNpugEn5yfDcdxnCwqH7vAQu85kXdxreJ4WesxJizARMAXLlMMbMnjqqMHr33wj9OmgCTG4mAbnPQF3m9Xyi/+V5H0gpZoHK4kceqF+xrp6ofNI6oVbE0z3R0lPoE7FICjV6gA7BsxYpnsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702347; c=relaxed/simple;
	bh=VdWiF5VRF8wyWj2MZgJnmt9AKIXXU0xoEJj/W105EM8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pi8cs936TrgihNasOsfUo0fYgUt5CBPSfN/gmhvPv9mdzmAi09p4bpfKODSnhT2r9iExpVRjZRoAASj2FuOKslm4BUyR8ml8jDzv8jlyeso+ejuxmkl6sXSvZ1h2iI7RW5aEfpnXyDKU/RoJSXvPCtLLBAqU8vrt7bNU/f7Db3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDbAVc7D; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDbAVc7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750702346; x=1782238346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VdWiF5VRF8wyWj2MZgJnmt9AKIXXU0xoEJj/W105EM8=;
  b=TDbAVc7DlSChzzj1/0byzQGqZaoil+Y1fU6H4hbr/HqoKXLyQ+1+GWKD
   UX/pnzdLGdHnMuaeTMBnU+6xIcQ7SrOL+2HFEAigkGAy5mZ3B9m8khsa2
   l50e/D6rQ3vjp8mIYkmrdOQ2asTOdi94UB9m+yUS8Fjz6Fpq2UdFQcXO8
   dr4ZdIipWmXgmDoNHNx29epwT4N1AJ6fqXHpVUqk9xSzmIvEFwVAzJTjs
   u9gZIzREiW1QZlzvVXkiCFSQd4gcGTgyPhCM8DtE9CumdWBYN6ogPQCOE
   QG7N0vThiRSjWZESsKp4F4q27CDy95VqPOy+LL3bb4D1WYb1qFJ9NTxqG
   g==;
X-CSE-ConnectionGUID: 40XO7wglSwe706mJJM560A==
X-CSE-MsgGUID: jEQSl8LPSXyn6FgWc+Po8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="70348458"
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="70348458"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 11:12:25 -0700
X-CSE-ConnectionGUID: adDYc+AJR2qhD7fdecrZgQ==
X-CSE-MsgGUID: 356gXNXmQQGE+ZZM37hRfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="156043277"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 11:12:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 11:12:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 11:12:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.48)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 11:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOAYVnaZAxfjAcr0fSJKI2+YvsJ4Y0PhLZDcWWRBDKHeMk1tkUqmlxcrIpWkIowbh2TWx+JAzzSC2YjUPYoDvbQaO8q2vH58oDIAf8dIiuLJ7nWtFdajKMBNguOiVQGuojbjfoxIvP9yKXfB0TvXywyojHauU3dk55SYR1S5NBqARpS4U+dkrQA36765hDQ4FhLR48GwygfV+awX+Ci9yrobIH0C7SVrw+pd/cXsMZwup5z2IKmFYHBz4UIhQK/tA71GVfAAJKs8/RjgxaqluTjJNTjkAgK/DBwuW3UTkJU6xi+N+S6eKVQnlVWsOznIdPA/BjAiW3BX3nLj6jKG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ubAMWFXzTb81rgP9gRdozJJaNTrHHxeB8yPFCVNFVE=;
 b=xDibxdW61C0cqVSACtjPdJYErvy7Srn257PZhYdHHAavTCV/N21ReGuY5cf+wOFo8Q/Qan56NaQmsw3m2FT+XI5nIW7efHDTIr2QxaRLdtXIP1J15tG7cV7UT+1a2TWhI37R9eJkAYVYO7BRfwtM3DjYmgfXLdfXNL+Q7cds+sXt12FjVI5Et+toRhiT/0IR+xEUy2Q0ijM+DIgbPSXVPmz2z167EofjUr2eBPYMiMLmhdrC5C0JBJvCxvt45ybw4zBhZuUSO8if9Fd0Wq7szoHDT3WEMhijt1gvHdT1mG6HEe+5baSs53jOK/CAnjz32Ny35doMwloMo97Sw14ZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by MW6PR11MB8365.namprd11.prod.outlook.com
 (2603:10b6:303:240::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 18:12:08 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Mon, 23 Jun 2025
 18:12:08 +0000
Date: Mon, 23 Jun 2025 13:13:27 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH 1/1] cxl/edac: Fix using wrong repair type to check dram
 event record
Message-ID: <6859994711092_2b363e294f9@iweiny-mobl.notmuch>
References: <20250620052924.138892-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250620052924.138892-1-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|MW6PR11MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: b73ffa2f-0028-4c25-92cb-08ddb28177c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O5r1sEa5/MBhnmVUdWNG3w+j5XtV8ffP0TwEBY4TqxdMQ3dzT7mx78nAz/Sp?=
 =?us-ascii?Q?oh7eOJucQCgW1OXQht/WBcHdjuDvVsR7ZHgG/nQAa8KesT5x56dDQG1rOrhk?=
 =?us-ascii?Q?eWrxp/3AZtil4C377ouDKsC6yqYmQy0DaPTyBG5+2HXkNDLLnFjOb/0zoFsM?=
 =?us-ascii?Q?JWITCx1h+xUFxejA+RgDJTteoURY6sdp+ARJHeq1AJgL++ZkWcrln/nRfQN+?=
 =?us-ascii?Q?X/NnGhDjZLEFKrWwk7hKX79AiKyRsnhaVfj1iSLFwgSWjN4+i2YbbU78RKFc?=
 =?us-ascii?Q?3+KElc5EDIthEeKcuyYd6MeHrzVfFJG18ivLxkwaQ3Phwvml9ePdTxJ9Di8G?=
 =?us-ascii?Q?R/R2wd0CiDkohMr1v9wns7fNeWcon/ywC5uopvHmBKIoX3V38VtNBz7OaVRU?=
 =?us-ascii?Q?CtwStF4MgHib9dxGntTNXo+yLYqU1WCvA02lUERdAEB6XBRzHPl6lRC1xMic?=
 =?us-ascii?Q?bZ86Ea1tokZaTzeVkkL6FB+PnUpSkk/3zAgOqOKau6zSrLJxp2C8m6ZhSs8F?=
 =?us-ascii?Q?tAXwx1tKaB4uGLvtiZOuO2duZY2cnvFW1D8RGa2SxyfCw/0NLVcVvqlPq1pf?=
 =?us-ascii?Q?bDa/RyObkHDSvQGxInzkc4bQkgG13Ksg2DMCC4G6huELIFqa21ExbdAtWw1w?=
 =?us-ascii?Q?BRr8SP5NA3oQtJIbR5LBxp0x+rsRhUzWparCSEY/gyMqziaIFsbZxvACOHZA?=
 =?us-ascii?Q?fsEqo+Tnoi7hpS9jAOQfEOJdFiXtsCb3S7Kp0vp3O4iEBIbsjxXB865gfleC?=
 =?us-ascii?Q?KfEphpraPhpbmoSlDZrwXU6YShlbieuSiuLXYsOG5+v21Noey+CgfsBkYgL6?=
 =?us-ascii?Q?TpdR+MSHw6ybA7h/SnCRnRqCspjGmcBXogbd5iNme8s+0qXYs/jD5FGRdIpU?=
 =?us-ascii?Q?0qzzTwIUdg/Er83eXrlGxTYaquUi7jdSRK2h3UTIJ5o7u4qOJZjUN3BcOnv1?=
 =?us-ascii?Q?R9M1tirBJzqaySqei+gOklHJXH9XrNCNNwS8BMj0tmh7TTq5hVdOlehaRnXk?=
 =?us-ascii?Q?IFO7qVPvx3S7sBsmhsPybUqwD1XF+t4iWtHtHD1FIt8XK+JVFmnu7SMQpoUv?=
 =?us-ascii?Q?G9EfB6AiX2RfX822mF80reW69oRvA0yJsgCmgKP/fQDTsmcSTQAUy9PLGYVf?=
 =?us-ascii?Q?gD7LQuBtl4TXiRNtRahZpY63pOIzsF1hWYcFP7ydbI6C/5NRaFYKOzWL7AON?=
 =?us-ascii?Q?iaaW530N7am7XpRJq+EGKDnLc0i3YCxE7i5P3Es8DubtZfo40ORjFadKLXK7?=
 =?us-ascii?Q?/B7AgejA4UoSpRLxNrd6qkVefyvzFdB94hGv9I7Ep+14lVwve/WaZOHvQRY1?=
 =?us-ascii?Q?+fQAgJKGzxO3OG7hxTSV03pbhtnXVuqijp2tibbJsrDIIKUqpQjEeEr2s4b3?=
 =?us-ascii?Q?OvG4GTBat1vfRvO68BfJOGDel4UjLIFa9XFwVHwH4N7ZF7l7Jb529aw3zxle?=
 =?us-ascii?Q?2rpwDDMuNDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jggpV0IAyK/uuapW8B3btIG0nlnN7rGlaIu1MwfINN4XL3IGRWp22S0BVf4+?=
 =?us-ascii?Q?PSlSWK8nwVWantNxWyUsfKL2PynLr1pgWLStrveS0LMFZvgDZ3sefun9hwv9?=
 =?us-ascii?Q?pZS5qmnI8KuPLlQ5ClYhpOZf6IABdmgWuOp5IUlLFfz41AfI0zz0lQ3qZym6?=
 =?us-ascii?Q?kQ8Dn1rKOg6l62z4g5qFqmmUCzqumxNmmeBunBe5cMSDJEn5ZTiJtdxVLLHQ?=
 =?us-ascii?Q?0RxeeWB/9gtIGTdDwrq794rY2P7iL+3diF9vOKrVu5gJilarJHnS11kW0xEM?=
 =?us-ascii?Q?Eas5jG7XOidyNr+U2Uu7iOSmn9tANjrfoHd0XpzmAmhps+BF3zn/p7AMiBm3?=
 =?us-ascii?Q?fyCuWQOBeuhdhqF+wUwaqgsVwt3oTYusONaMhyJcUjXMRpC41YDXEyyB57TX?=
 =?us-ascii?Q?SkcffYJcO+HWVYwONIM1+mj7hjolZyZM9A8v4j2LzyC/+7EI7zXVYfAuB6fD?=
 =?us-ascii?Q?RoSIs+WABMKjBG2a96y49GAZHFYLWqqlzOXovvfb/eGeImixJsK68acPEyxe?=
 =?us-ascii?Q?iH9TEDGNi/wxno0daE1znbVkG6StISumgKGrktG9ojF5meZc+yBZleSGpxxe?=
 =?us-ascii?Q?irvBMKaPqsaET7vw1OCvhogE/K1pfrbkJ2CMOlqPg7uzDe061YPx7Lvlb4j3?=
 =?us-ascii?Q?RahUDa5KGE6h0W+SCEjTsPs13USqGjvm0VwPJU8Cl2bmxTx0YMHd2+tLLVHr?=
 =?us-ascii?Q?e9Q5alZ3dDTnLz5Bi2qwgw1RIk7T00A+BJ4NQOp2++Brp+Hdv5rZfY2jrk6r?=
 =?us-ascii?Q?NLIWggcp7gGgekuy24ifuSdpgaAc6Fw1gGFl7kRJI8PzeCufMxJbjXtvl06Y?=
 =?us-ascii?Q?nzzD2dcUpc2E7s3zlDU/PKmoJmP7yzzPID4eV/eW6PAYfmnGDzoRVC0lKY0w?=
 =?us-ascii?Q?LBDB3jL7PCHqpUdPPuGM157HoypKLdWiUFQyALGkTXKUG8KHR8HnK/eVKvlg?=
 =?us-ascii?Q?TpXLNxlesvc5nDY2MmgAQRiYiUHD0XzJc2YDFml4pzAtfwD/4z1YcfBfq98R?=
 =?us-ascii?Q?3SrcW3ahXz7p9qNy/TcrjB9ILLd0xV4/ZJv9L4RYEo5HOjMBowHOcoeYS/a1?=
 =?us-ascii?Q?2TeBvY1lnXKd3Vh2Zy06Wabesg7BqTFt6GswrB6cym8rI/cGAQMiPl8xu/bn?=
 =?us-ascii?Q?1nPEUcnxfxIiMRVTgeni5EbUglYdjGxlTYwgagkArOgupkiYGePN5JEYDPXI?=
 =?us-ascii?Q?cjNJEvIp9Pzq/FGbY29Ibbape20FPRVBNdBQFzJTQod8Roba6JPOQ3J6spNd?=
 =?us-ascii?Q?UWBcAv6N3VW0as6TeKyghOhmdzBtMlny8m7ASI3ourrNuWDIKbu4KyqRU9OM?=
 =?us-ascii?Q?IXy+OJ/DzXOpa10U+Pa6ZYa12G+cYyWdgfDxEqKPhT5Nm7XVJXjO6gh1DGeX?=
 =?us-ascii?Q?mYOCHv6v1UF8K8tSTdrHzF7jPZF/AK3jCsM3HhvUPn5Aw+Sd0JGWyFXGHfSt?=
 =?us-ascii?Q?cWjuu1eVY/chrd1fqfccPJUH+GeIAedPQcY1BPAvqJFfYv9AbChoQs0bF4s/?=
 =?us-ascii?Q?UPvylPbg/9uuaB8x84qMD/1rse4womINYTSbAVAyvioroulX915fyXYekOK3?=
 =?us-ascii?Q?Rnq2SAztnysRKsPN+k2RU/mW4E11Ek03g6miofPu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b73ffa2f-0028-4c25-92cb-08ddb28177c0
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 18:12:08.8348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtPZMVPZsXiaSHZhwCc+PpRMOXMNvn0Q3slchFCiicIBwLDk6nPwiA5f6ZMjuA/fmYqI26SjBcWUIollcNnjHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8365
X-OriginatorOrg: intel.com

Li Ming wrote:
> cxl_find_rec_dram() is used to find a DRAM event record based on the
> inputted attributes. Different repair_type of the inputted attributes
> will check the DRAM event record in different ways.
> When EDAC driver is performing a memory rank sparing, it should use
> CXL_RANK_SPARING rather than CXL_BANK_SPARING as repair_type for DRAM
> event record checking.
> 
> Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
