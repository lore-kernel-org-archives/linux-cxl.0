Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1324B2E7F0E;
	Thu, 26 Jun 2025 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946932; cv=fail; b=sD1iiNPo+V64GxQXa21sFPL5aV9mKqHFy00FPt65ypVUeYjaMefibvbaMNMc9nzhNdUZm+P3CCgfO5ahZop/hXrnXxuU+UA8DiabwyN16Ym7lgf4kZe+1LgkV5OMLKw60rHrng+ACO79yjgxKjlnFH57lDpjHRgq7gBuH+vD/P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946932; c=relaxed/simple;
	bh=rmdPqJjdN9pSlsf3MzSSp289zKs463bl7noQg+xX/FA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uqmEYMSOtj7LgBUZeWfv/OEvnkk3LxAmQU7e7RrBg99MnNUWzozT/JCH5QMUaRFAuYiODAjWDlqcsqUb289aXYHNFwQTZdke1Ocgs9XJF5risdZAY7R1+C3wmVURXEs0MtwdX2mkeab/bkYB/xoHX8wh6gwfk4WI1cU9HnuQOIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e400SF+Q; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e400SF+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750946931; x=1782482931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rmdPqJjdN9pSlsf3MzSSp289zKs463bl7noQg+xX/FA=;
  b=e400SF+QmI0vDdHdESODqFhgwvdwyHP3RbANHX3hnuRNiPOa4K5dAXB6
   U3GiwzQaFN7PE2DMRqaBKUXX1F9rsz0tP3QL1cHx4vc0AWqEXAQwq+kT3
   VPZYw9BICO8cT+6sbLuhoJ3jJX7wrTLq6t/yfsYlsvNKpywNWMb89AG6x
   ExLSSOxrbIYUAV8xjPkvjnl6FlS5I9nBTSdow0ypBIF1u2cG6ZfBoetcE
   FNMSE6cVj8MpHRWUxD40uaxnx+GGobfLLwL1LB/XlSNFtlKwtPHuwt+ZL
   b+Nb2Wjb6/UcniJvzZQTqiJXnd8ovtp2SNoNYu3z/8ym52LxtJTjBr82j
   g==;
X-CSE-ConnectionGUID: WUK7zxxwTZW5FEQswhSbCg==
X-CSE-MsgGUID: vJo8rEjjTCCzEFTxtNLr1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53185541"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="53185541"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:08:50 -0700
X-CSE-ConnectionGUID: cMHin6CRTJuRjw+SklIp2w==
X-CSE-MsgGUID: qim9kSeXR1GVbydHxosorg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="156905117"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:08:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 07:08:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 07:08:49 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 07:08:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5rh/I2cyGcuS1PYUlTBJIXj717guiooIuoUE+IDAFYoBslDFLNORr+WbgQMauLMr/nN2i583kyugMiM0FtBlOR+jggZ+Wa9vKTqYwaqw6MeDxccnaxvEnOxzEtSeKYjBv8EzOx5JcMWwfP/E1kI0HLGsbXkZdNll9z09QA7OWnU//aRi2S6cy0szd3YKJAoqatJYl4ecd2XvE6Madbs4BAw0tfml0u3zMhNxgSER3i8LlmXBYDR8UGkhh0QbsS/hTFMpagdmNMliZxZ7dQzYZciU3Qobytuag0aZL2pc1D6G/NE/15Zt7wvd5fzFiP1g/HGmjBUZrOq0r7sSfxkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmdPqJjdN9pSlsf3MzSSp289zKs463bl7noQg+xX/FA=;
 b=rxorCx1IRqjS5KK7x9iEiQBFxmX/yjW2RRy9SzjCRrVGhEeOohZo8lpOMy79RbJG5YOJN08ZSAO8B9U7hw2iJ0GGzvgb+a3A/mIuHeJVts/li2BYRwlrHKkr6JO3p/lrr0U7lEYYjEmV+pSp5sH1B2x2Iurbl7RCld9kRenZq9Z7JSA3G/9HWKfvRr0dT8rJGjoyl0KZ7IF1gjWCpw6LAEz0nBoCribTXBj34YoYZQrWJR6SMlqW871U6kgBsp7krmU+f9APqvK7u7VUYYzvgTZFL3s6qs0N9/qNGd7rzOOVJjcC9+2AG2dZeodzhe9NCf7k3LKpcX0lvwAiQvNx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SJ5PPF89507EDE4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::83e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Thu, 26 Jun
 2025 14:08:46 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Thu, 26 Jun 2025
 14:08:46 +0000
Date: Thu, 26 Jun 2025 09:10:07 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenbaozi@phytium.com.cn>, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: Re: [PATCH] cxl: Add CONFIG_CXL_DEBUG to drivers/cxl
Message-ID: <685d54bf6ff69_2cdbad29439@iweiny-mobl.notmuch>
References: <20250626095442.1254840-1-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250626095442.1254840-1-wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SJ5PPF89507EDE4:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bc2aad-5d77-4b19-69bc-08ddb4baf711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iKYX8G1qKrKpDKKhHaR04jFso9FSCiODy1JJx8dLPOf9YZGpsBnKLQlRmPVD?=
 =?us-ascii?Q?ub7o2mUgqftCHoSYYslRaFbbLeUW64+7eUL3gch0ypyeAA58HrIp466wDqm+?=
 =?us-ascii?Q?5Ai7mPsf9YPbhAvopkYJemhhQs0nGXk9PZVoSURzRtIY8ofpMXirQfXlXknN?=
 =?us-ascii?Q?DB/WPfpmm68wcN5jn5oF3l6H6cWLWGgERCFH4lfaz4tgyVHobMjeSDP2HKab?=
 =?us-ascii?Q?EeYU7gJb5ii//VQGIIVMwl/BwueWcfr4eLRltor+Xc7HDr/ZOwPMa7iVeIr7?=
 =?us-ascii?Q?J0mE2uBqrhOqSPD+mbAA2/eRz2RiVuequtQUk8kA9nK5g8PNgj5w7pa0VGg/?=
 =?us-ascii?Q?27F8fNAzoNCtb5dDXp3o6urMM5jFNUOYQy05A0g8tNru4mig7Q2snpXrEAIO?=
 =?us-ascii?Q?t+ytEM/lHLE99uL4BD0vUf/zBBZ8MQ4YqpFXOCfhMvc+e0vDBQjCHIxHbuA+?=
 =?us-ascii?Q?eaKX10mqzGZbOJST9spnXX4j14Q1Ws8X12CE/LkMQt7jU3BVnrfCVLn1s3YR?=
 =?us-ascii?Q?3RPCJd6BGpKwLD5F/DN5y2eKDHo0ermr6xITTMw2tMBUgpdCNYe4Jv3gf4Be?=
 =?us-ascii?Q?lOC1XsAt5SR81yO0eRCk1WfrCAQBDE730ZLA5hqaxksGmsIGkZSHsCVLoCC9?=
 =?us-ascii?Q?zusDXdDoGQAqP9yfc65gJ6mRfzXNVzLPid3X3i4IR2Ok9z7hMoXX5su+nBgg?=
 =?us-ascii?Q?V2RkqayUfnczR7A93/NCp22o7IvTCESPKXoxpmZTB3enquyb+geHnKZObs3V?=
 =?us-ascii?Q?J+Km1uNANXjvxc3SaKwTbb4d4uP2yE5btNNK09HjAqyA/f+vcCF/OHVEOGzS?=
 =?us-ascii?Q?cDJaVn0K8frAwAFeT3Tep5uR4FSzLtaoWXwIgyhFYvXWHWB+MuXX+HclCAc8?=
 =?us-ascii?Q?9sIl5/Tl4D7sJ1lOrORxJw3gKWl7xj2ByyK9909ql1wawe/2pFuxx6cBX2pV?=
 =?us-ascii?Q?prr3kTACX08i/W2TLw3TVn5bVFvTOB1oLX1mSUrJxM9mwpfECPGzlTvVqeC0?=
 =?us-ascii?Q?tJorkAI/7h01zous6xEzDGzgPci8Po9a2vKNLJEf2xEmGvQ2KYqK/cQ6CHX4?=
 =?us-ascii?Q?7VDsVwH8AnD7eQpEeyi4VtMyjo+XKf90nNa6eqPOBT8kqE1Ssm8KuCY3ADHl?=
 =?us-ascii?Q?WvglH6sCOcG+jwZ9QmyZUCjsVmVgeFIDfB5S0yqRpAzduv+iTlULe85tz0Au?=
 =?us-ascii?Q?9eIhPdSuHDqPkt2L0mrHInisfTn3kFokcTtpOmNFGzF1KRQkfqnpBhNR9p5B?=
 =?us-ascii?Q?w169/Q/I4B3VR1bYiQUIQ79erITzUoIcGG72JAjMXOM0W3REPuva0brzMveJ?=
 =?us-ascii?Q?lZmhw3A2lyb7hM4eFN7Kl1ggnUasLwZy+Makt9v7HAYXzeCrqJMTrNKq/L7j?=
 =?us-ascii?Q?UMED5+6frkJtYlQnsc4E0f2vTAy9G49vTH02QKfM7s/8C9OYp8S1qZ1GYRFd?=
 =?us-ascii?Q?wueCH3YNPEA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QAX7RTEOa+YMbJ1KwsEeS9XYruGAU0MiAaMF67fPWK1eAm5t9HOoAe1etZH1?=
 =?us-ascii?Q?gB81gqcC0seImSVddpMYyzd5lqmfxUWoES8ZBY6TLLoDAEZHHSLKMVLL7J8E?=
 =?us-ascii?Q?xqjCDnxhRK6f1/mDObgpvxFw8Ux4qg2kg+U35PStaxLzPk4qugMuDaKs2rAc?=
 =?us-ascii?Q?VJ9LIhmztisfKEZQD5by5gaZBbv3uVC9NFMwIT32fDhtZXaIRQU1TcJSM1NB?=
 =?us-ascii?Q?SlQD3gKlWHOIsD+d+CFNXUqpdAdjpWp+gHdaRHvmtMNKeTUPTX2usT649KJw?=
 =?us-ascii?Q?Fu0J0xNicvOT2gRg2Lm8B0FFNVXYWSb/ITNPo3IYth1DJKEy8Gn+kXrRybvT?=
 =?us-ascii?Q?KKLvT0p/+gaKicO45y8e1vXzUmsXKsF29eUQlkV6wqGHEUfT5Ak+4r0/TvbI?=
 =?us-ascii?Q?k6HPzi56WTxuZa9WbJ/siE/FQQKChTPmJqQo/lR2aMc5Xz1ZAfv1FrvTIeKA?=
 =?us-ascii?Q?meUaP+Vkfb9UuAWqK+gdCwy9k5Aliso5UVR4IsI2+Jls6c9J3ti+sCu0WwEr?=
 =?us-ascii?Q?FlcOd1KxQo468ib/jigfU/XMOaj9kKqU5JEUAD2Ao2SByR96aOpWwOgnXteb?=
 =?us-ascii?Q?Kl8oM1uskv6Oa4dRASRCREZhD/+idF0Hl2u+YO0GpNlymcjjjRElKP8iSg0W?=
 =?us-ascii?Q?zB20Mft0MK/m3cu2N8Qab1JWfMTWXdxYph6pNbAvXCBNwetgiqH8dGd9URlx?=
 =?us-ascii?Q?BMn5evXaBbxAJSTbNlTWlMVaA9IdMm/s+D9+eNDqsox3zWLlYwSEaDjYlw9z?=
 =?us-ascii?Q?wF4HT8vzJ0UwlF9ciO1pPzsfZF/iL009C468+imHSX2q6P3TVaoFagpHefOg?=
 =?us-ascii?Q?miwkCW8q2kPjbHolRnNHEgFLRdPg2+ZBajzQPJDkw/34p85h3GD/QCELa/Oa?=
 =?us-ascii?Q?k588JSKSOUFdfFVprfYVI7VmmsqRCghbBTorYB7vsAsrGxV3obP1CwTzI+w3?=
 =?us-ascii?Q?zsJPkyGH4ZK0hkdSDZsdthrEmMcb1q5rf77MRHZ6VPjQK+XDygsW+t6gqAcz?=
 =?us-ascii?Q?vnM5hI4v1vUz0TpyeCmqKHT4SVweH/E2eQO18yoYRwPVFtVu4Quh+dygkKpL?=
 =?us-ascii?Q?kU6Pzvh4LrOtaouUUZzuL1dInZNVnCR4wzuVXCZi86T5rd2YzJ1R7m2zn9Hf?=
 =?us-ascii?Q?bktoqwHkyDniws2fZuW3/9FNBgMLTvwY9hr1PF9v+QG7rnsjbZy3C+A5BmkD?=
 =?us-ascii?Q?QLs4B43pSH1XNXfTK0ABjPC+8dND5yZCsVk/EfHcZxPRgO8FxDbilg3b/YHN?=
 =?us-ascii?Q?hwZoQ7PiqgNz8wexeYGp6FriV4e9A1L+ma4PMwy0t23rVrmJquKXxgxxXw//?=
 =?us-ascii?Q?hMN3KSOAKD/4jqAzExrVDzZa6W3X1I3jYXg9lHzpMv6f6CB5W92BfnOMqEHe?=
 =?us-ascii?Q?pQ1/VoFvsa7UVP0zrcmq1hJNlyQk4+wJd2361ZntBK96X+ozBmFMCYkWVeNH?=
 =?us-ascii?Q?pvKHBMj6N9fYiTYcwWusQvAClBv9+plnpxsLNB6c/tTL2Iu7AyXqKsmQHaKP?=
 =?us-ascii?Q?BRwjsLZ0dGO7wzVLmNeA6bbeBG050rEPr53gq4VE+GQwRHjANDgP+9WeqOj+?=
 =?us-ascii?Q?7YmsIRyGwwcoCo+SEeJY+j2vrOHzltESJocYlxtD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bc2aad-5d77-4b19-69bc-08ddb4baf711
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 14:08:46.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDs6OtLIFVvrDyrqW2vkvOzRygU+/89tuwRJlqrLCx5g58DdDL1Uqm+VjYC9wI7g6+RwihsGU8ZeWfjwNkAWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF89507EDE4
X-OriginatorOrg: intel.com

Yuquan Wang wrote:
> CONFIG_CXL_DEBUG=y adds -DDEBUG to CFLAGS, which enables pr_debug()
> and dev_dbg(). Users can use this config to open all cxl debug
> messages.

There is no need for this.

Dynamic debugging can be turned on at run time.[1]

For example here is what run_qemu[2] adds to the cmdline to debug cxl with
cxl-test.

cxl_acpi.dyndbg=+fplm cxl_pci.dyndbg=+fplm cxl_core.dyndbg=+fplm
cxl_mem.dyndbg=+fplm cxl_pmem.dyndbg=+fplm cxl_port.dyndbg=+fplm
cxl_region.dyndbg=+fplm cxl_test.dyndbg=+fplm cxl_mock.dyndbg=+fplm
cxl_mock_mem.dyndbg=+fplm

Ira

[1] https://www.kernel.org/doc/html/v4.14/admin-guide/dynamic-debug-howto.html
[2] https://github.com/pmem/run_qemu

[snip]
