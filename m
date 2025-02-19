Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218024BD11;
	Wed, 19 Feb 2025 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998002; cv=fail; b=oJ+C0ovl6ZTN+fsMMCkLAtQyOo7W9eS6uLNhWpAc7N40fbBeLfVvnG7AV40RJmPzpms7kQVgjF6N0GzW+ZsRkZJFtr6cSK2MYNrd7xEnokM4jukLa4Z5DkU0xGyeMifq5s6rmV+XT+2d0nMsOl/HuUvagJYmELpHEqdjHHEcW9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998002; c=relaxed/simple;
	bh=TdQ8lb6J600DWh9C4ALBEwYlQLss+zxA5pdXPGkJerA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RtdZbXVWyeIIjyr4ELOHKfAL61AcIvTMAOKabNK0vKsoXQzn97uegWt+BgP0eVTkAGTzAhU3qZYJ8aUXIQ3WusPv270y23Fp6gy2U3TNSACLPXMurnydoiTKWB0pymv25CVTJFqNqg8gJTl2YRjmXLTBhVyBSCGdbDYCi8lYIWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Odg+V3NM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Odg+V3NM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739998001; x=1771534001;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TdQ8lb6J600DWh9C4ALBEwYlQLss+zxA5pdXPGkJerA=;
  b=Odg+V3NMhCnDSGxjvuuUjUM/uK6FIuE8vo98KY/weTUOfgT0o9cT4xRL
   VTKikpMYQACTpkjRrwFvQT7z0FF5Us/IfnYHtCvQ8R4VQoeRAPeJs7OOA
   yABml9+inNNxU/SvN2U1zJhvpTfrWY1e04mc/1AA9Bw11L9teHaqAZGQ5
   AgKbgPb5P7vqWkWLHLtlMcrhFyTfLVJH2BMkhM7xOvmGEjmbLdo6K7U05
   KhDo5/FRzwrzbgvBiev/SWi7d8wXRcEDC41xuv4UlSxyVKBRP52O33fj6
   rk9RZBnWSFyhVtCwFZ3jwU62ytYy+BLcd7CrPl5c0oNuTPF58kivLzcRA
   Q==;
X-CSE-ConnectionGUID: outgpu0iQHuesfOPHrwkbw==
X-CSE-MsgGUID: FLfkHxEdRDG4JwYxbDJLHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="43584463"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="43584463"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:46:41 -0800
X-CSE-ConnectionGUID: 4iaCcliqQU2rEfp6vPHonw==
X-CSE-MsgGUID: Qi7FBDPkT6WKAUQpLTqkKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114660462"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:46:40 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 12:46:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 12:46:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 12:46:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRhz5tB/LGT5zGpFxaXxJ7ZyR5vJ40NtMZ3GCXWyl3wKm/rX6IzK/L86/W+7jkEoBlX6Psw0ZuHG34vqm4A6bXhsFdggFFWhIY5UOeoj9n9y7h1h7iDZnQCT6Nzlhhd5SeohO3+F62cUzrQoomOqKq8/GlQMVcTKZDJyaYfDlTJS0k8CPbozJb4Tu+4xqYXwnSziZE5p5kJgiuWwfqSsehSn04Zo/whQb5QbQ4ypYk9e6g4z1fUnWBLKqq8y1EA6YLG3KcHouOTg7DObFdqUCQiLG8mTtEO8zhY5ScX/1+BooQy+1Bxk9j8EIJjol/87V6OL1FfYB2Brv9gKB5o5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD7CW28WV4RL14Ht/QPt7ZRPbxKPLcw9NzYfmJv1yBQ=;
 b=MUCOxp81DBmpQW3wpQ3LmaFDop1E7ve3QxWg4+mtRNZZUvG5zqTkP2hvz0g+GuQEAjwpUS507uSPssXt3fFvFATxuFjr7oufBmo79UJi39rUPyJMm6/GMPe7jFP+Ck+u6S2veYaCbDUHG/2EcODj6TzaIzjSpnancZUIaiq4i9cvJSfoCPaBmVjFU+rGG0J7U6SfZqqXpH/nKfItyoRCmLvAKCT/zVGNjJn3MwFtVqtfXzNrxnVf0hChiWh7jkP/bzEjTR2yl+DLMzpC0xeELBpFblaJ9Khg0HY/wgS60Ss4d2he0sqZOMziqFWyHwoe5nP6hjC8Rf4FyKj190PCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 20:46:32 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 20:46:32 +0000
Date: Wed, 19 Feb 2025 14:46:27 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v2 0/7] Use guard() instead of rwsem locking
Message-ID: <67b64323dc4b1_2b6e4c294c6@iweiny-mobl.notmuch>
References: <20250217144828.30651-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-1-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:303:85::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: 880f0933-95b9-478d-dd75-08dd51267e2f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xd8RGNSeN1k4aj8x++nbeZLyLuGPQ4C1+kGqC7YAJgWsmr1SOxDViZvwhpNk?=
 =?us-ascii?Q?LQGv2qcVs3fikwxKdgouW13Neug1rBXRDJvI1Bf8Uns990kbX5L38389Tpwo?=
 =?us-ascii?Q?765QTjSGF7hMz6CIS2Fglw2giZsR5yEiBTdnZq1mSAChKYWxPhKEAuAlVQTH?=
 =?us-ascii?Q?A6QlweURsxgOfK3iMUIO452B91HbAF5qm+bcb1ACo3qiVfvTyBSiRYhL/qpG?=
 =?us-ascii?Q?oDNtdNCAJPFdpI4VzL2d6z49/XIjp537WEF8ushWIlOQstwnZhzD3mmYIRaD?=
 =?us-ascii?Q?V925mcD8He+i+kL7L/vH8wcK2cvkvTR6exgvgJdXQ0souR9dBnZWUm1+9sL1?=
 =?us-ascii?Q?9GEePq3ftY1tfMJfeP6uUBq5+ZdNv+RafUHjfnIiKGP3bKeYbhx6uL/TIkkR?=
 =?us-ascii?Q?zoM/NgrvKPO5GyAjogPpZjXazGMau3462TetMZcWT/ykshtldOZX5AkFuSXG?=
 =?us-ascii?Q?5DsfDZLRXKumpUXww+AELrcVUMEG8/7IqKwk11zFEejaexEBEFQ9sF9OqKn5?=
 =?us-ascii?Q?Vs8MnIwb9xgSDx84d62CywSF0Np+2jU/ueMjEj+UOY/evl7GXKqT0aSW4UVk?=
 =?us-ascii?Q?HZUikoZ4jTPZPT9s5an+LTpDV9HCXY1PqWqs+1f6dM0rINfNPP2gXlQXitp3?=
 =?us-ascii?Q?2FdIu8IhqedNZv+2DeRT2aA1McGOxmL1gzEfLgY7W4j2UhgW0VBwiM5N+Eni?=
 =?us-ascii?Q?i9YFyAbxcGRPTJfyaCHa1W35KOCbEtrCNsED9kcFxw/BRv3yttnqNCNnUXn1?=
 =?us-ascii?Q?18WxnK5y3DPzd2P+OJGlfewhpdARrIXxSBFaTt7AHYa9gRheCaOV+MWfxcaC?=
 =?us-ascii?Q?JeSPaEy4j4pekiKZVd4OMwF+HMWeMmmzdOCUEKY45HVYEoCRhb2/Wq4W+Bu3?=
 =?us-ascii?Q?Q0eMvf7QVvLk0WZV2i7h/JcYRv2rU6DSOX+jGNElXrSqFsbw75RxSRmTIezf?=
 =?us-ascii?Q?DK6jc7yVZORUiB1D0RXJmgDZ7cKvtTeSq1r7KnP7TJU7iBcbRD97Z9Wb7mL+?=
 =?us-ascii?Q?d+4LKrlNZKNvup1of/mGMmSpct4LJyPA9LRZF6Wr09GeLwUZ4Wqxobda4Ixc?=
 =?us-ascii?Q?mLI1cTGKq1RK048wi2MJH4dAiGwXqic/+j8Mk6QModl+rTli7ArVNUolN6KS?=
 =?us-ascii?Q?pJtIWiGFKnJ/tqWG7LqfQMLIUkroK+coyWQM/jw2OUJqaDck0wxKcchf2tdN?=
 =?us-ascii?Q?OzS4nV6U2z4Jv/tqQmSB6Ynq9nE3t4E5CLtYQ/ZK2tnSU+9QHYwKHGP9wArJ?=
 =?us-ascii?Q?DCawoDfH+K/tn2IUZoYASARk2PBIp68a5yKkgmDRV0bSAXQbetk8OT4YuTOm?=
 =?us-ascii?Q?SiT7L1TQCLjwPK9xnwxM8mquVMY6pLJy6985zha4Q5tbDPEnjo2Ochu+k6ad?=
 =?us-ascii?Q?cu4bt/Eotnb1atz31l2YH8Vl6FSg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?it81WgfJucd0C7LR9qqowXz7nst+LhXJGbqeR3VZhi/Gx8r1sVXmTWKF9s41?=
 =?us-ascii?Q?KV5bu9oI/3bAs21iFGjEVUE3OPOdms7OBFPWUceh3E3hPqFVtfwvlMlrjCI7?=
 =?us-ascii?Q?5o/FXFXf1sxKt4bIjR3mkaciYWlnCOeTAuXOMslftJuXCuN669UEhKlEfYEm?=
 =?us-ascii?Q?AdBQ5oNvexRCHE2VLHCBDHCRuI0GXn0K5218RZVvgL68BXqE2XYrUaZMCWcF?=
 =?us-ascii?Q?zvkW519tvHzq8lOVrrg4Fi35PAmf8RV/tKm8wnu8h4awIXMOw+r/u1dnv+h7?=
 =?us-ascii?Q?/jYEXryEwzLk1AVvhvSe5TOuhXCXMkgLq962r8EqpoiK0gHVJboQqqM3tCHy?=
 =?us-ascii?Q?ZeDBqDXuOW6npKa8GdNfW/bkoM/DwDaSsaAFu29KcyCRkis4jqIL1dqZzj5r?=
 =?us-ascii?Q?c2gu8FyTa6+cPvbgcW0UFS+vKupSZmTghW+gicfHMucVF7kVLttwgFaTRQ3Z?=
 =?us-ascii?Q?D0TxkWK1CaQYvIAJ2Jplzlw5A0L+ZnKz7z/O+cdVYdJ5ak93hXnovEWpFi1s?=
 =?us-ascii?Q?orhYdwHP3sj4OwXzY9+d+papwj38MD8wpde3eflwkuQAILYjwq1ORr7MxgVp?=
 =?us-ascii?Q?UsOQL6gvLUBwVa2RDda1tOST81vSw1czYasyenTY5hTXY9dZIBGzDNJBal8g?=
 =?us-ascii?Q?qMyqvsWsTZbCIeyAlWSX1KmIORTWZw8goeNWetJy8zpVg52j7p2OHcmYFtut?=
 =?us-ascii?Q?lXrKBpFExnXS4fEUkODWZBGFWS+0n4rrhDCaa71FGvK3575bnjZM5Qt7NS0C?=
 =?us-ascii?Q?Zj4dt8oDf4u2+5XRoi0RA2AAfCYn2MJCtw80ihdukivFueERE2K3FnJ1sE6U?=
 =?us-ascii?Q?YCRgI6usMEX6RukqxLExufZy+IKSWRakdka2T3+1TxgGEaRym6R6yKO5PM/9?=
 =?us-ascii?Q?K/3br+mF5nxUDCWLbkOJR1ZH1iwaQyt/H8ZBa9bnPqGfHyANPuQ8Uz2WY6xR?=
 =?us-ascii?Q?GohqN7HEA0OQdMVr1VQIkCQ8ALuEStuYqaquDdRu+5JctYtg6UeUlQ3FGuoF?=
 =?us-ascii?Q?UKZ1Zg6Gxh5GQFIn59o7qojrV9UJwS8cgt5uGgFq1FDVEgfsaoDDtreZj0sg?=
 =?us-ascii?Q?VTq2uXU5dP8hvQcKyZVj7C9H4wBwAjQTE7N7d4w7yfyMrrDAzf1woEpKuXwZ?=
 =?us-ascii?Q?J/fdhITXk2pPIG95wF6Rmi1dUQKegXMdQwns2SuIJvnJgf6hQJuZ6GRX6Xpg?=
 =?us-ascii?Q?d60BGDBJ6iru33dqP2ftboa4HJ/OHRBb7VSAjhmtaRi62MTf1Y040yM5yXit?=
 =?us-ascii?Q?AfSvrSRmVZKL2Qa+Hsxlo2FfL2Rtr0BcbdCn4vUzchDDMozhzIfjoiqeyPnE?=
 =?us-ascii?Q?C2o1JQ/bP2FFywim58aIThegXJOzxQHLKV2zhraDRHyVQiHxnBnTaH79B1zz?=
 =?us-ascii?Q?3hwZr1Eh7puTOLQGCm7RhW1LHScqMlYWi8Vr+E2cL3alc/LZelLKZ7jUY5+G?=
 =?us-ascii?Q?YrsbhhVts4HKJvx4o1FGdT2EzE+dRbe9xmZb/M8HiZ3m6JtQdTUcZzftSlT1?=
 =?us-ascii?Q?f5oxXghuHKfzkJik85+dvfcyz5XW0G3NtIs+GqVkrNsqD8OdT6l0oZC3TbiA?=
 =?us-ascii?Q?k/PKC1nUk2r6h3w5MsHMPv6nFK0yOpTTt6rS/AWj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 880f0933-95b9-478d-dd75-08dd51267e2f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:46:32.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uvMzHZCD9odVPXhDaBaAOJ66qEh3XzXMobZ2ePjqMw1/kU4BPnx5c5pYNHf5hOpjR8pTlvtrNJB0pqehuu/BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com

Li Ming wrote:
> Use scoped resource management to replace open-coded locking operation
> is recommended. CXL subsystem still remains some down_read()/up_read()
> and down_write()/up_write() which can be replaced by guard() simply.
> 
> This patchset includes simply using guard() instead of some
> down_read()/up_read() and down_write()/up_write() cases. Besides, it
> also includes some function code cleanup after using guard().
> 
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3 (tag: v6.14-rc2)

For the series.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> v2:
> - Drop some local variables. (Jonathan)
> - Rename __construct_region() to construct_auto_region(). (Jonathan and Dave)
> 
> Li Ming (7):
>   cxl/core: Use guard() to replace open-coded down_read/write()
>   cxl/core: cxl_mem_sanitize() cleanup
>   cxl/memdev: cxl_memdev_ioctl() cleanup
>   cxl/core: Use guard() to drop the goto pattern of cxl_dpa_free()
>   cxl/core: Use guard() to drop goto pattern of cxl_dpa_alloc()
>   cxl/region: Drop goto pattern in cxl_dax_region_alloc()
>   cxl/region: Drop goto pattern of construct_region()
> 
>  drivers/cxl/core/hdm.c    | 68 +++++++++++-----------------
>  drivers/cxl/core/mbox.c   | 10 ++---
>  drivers/cxl/core/memdev.c | 17 +++----
>  drivers/cxl/core/port.c   |  8 +---
>  drivers/cxl/core/region.c | 95 +++++++++++++++++++--------------------
>  5 files changed, 85 insertions(+), 113 deletions(-)
> 
> -- 
> 2.34.1
> 


