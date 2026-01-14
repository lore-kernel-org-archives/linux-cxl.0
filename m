Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0E215077;
	Wed, 14 Jan 2026 03:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768363158; cv=fail; b=LHWvHBXOTEOrpx+tBI2OwdKknZdzRe6H0G1KMCuS/eeFd7VDvfaC1oIDur+DOU8bOwv8+0urTHKAOa34EfpYZZ25v0FF1kpFLnXXiv67wwd8GY4SkGoSgIOv/jUM5S811+YIze7Lr6O8hvYyaIy/PJDtYg1OYCHgShuCdUGzBOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768363158; c=relaxed/simple;
	bh=Qkf5NJJmtdLXTx/nQIT7Z/E1nFAbX7QuF0I2640QqDA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lHza1oIO/O2GweK8gq6VEfxl4C6NhHuW6ABPVdCyP73YwIFHQ4wCdWtPkEMmnGsG5J8jcO+cCddJjyWFvqjXoK2aliPxG5Zmvvoq9DHt54u8/K8VBOqp9pwxC3FudnNRwP3Lpn5wDSrpo85AZfHHmF3ZPkN4zpMbYUt5+R+q7YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5kYkzIt; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5kYkzIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768363157; x=1799899157;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qkf5NJJmtdLXTx/nQIT7Z/E1nFAbX7QuF0I2640QqDA=;
  b=I5kYkzItJDUkUIffQNhCug9byJGfdFyeLzRngOgKV0XS84Ej80vMt3OV
   B6l/mt1a7breTsMgEomWzM3xqLiInvhz61aoDIOTOX2vj+s0LiSH3J6jT
   W7EOTtXWYXt6fybMAP7XtfHJ9SlAG35uzv9oiKklKLn0IL0jy4FG19LjG
   ZbYh5paOeo3mCtxqV2qrC4XU5wLKpK9YWFZ7KmnvnFkNLKMnZlfbfRKwS
   +qJrlGV85Lrvv3/kg/CJwlx3gzCd97HM9WiryqoZO5qOgB3VZmxF4MOt4
   hCzdDof9SetOtRbWw5bJPmUAaoHLLLMlWaZrkXHhmVhdLc/LnqOKRnRXI
   A==;
X-CSE-ConnectionGUID: s4r0n8JVQ7WCWpJSQ5Cbng==
X-CSE-MsgGUID: fvYlUZOGSDuET+2cXRG3MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="79955994"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="79955994"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:59:17 -0800
X-CSE-ConnectionGUID: AWocl1HrRNmoT6E5V9f/EQ==
X-CSE-MsgGUID: CvppnRiQRG2OboedVZcDGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204202135"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:59:16 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:59:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 19:59:15 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:59:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hS1RHTF6aCYbVfLcRXwiPww5fYyPfe/916kSpndUljBdsM+jRkO1/ZOByJOSK5GLJic8zC1pVMQXwbcCdgHeqrAYHxrfoGIcJ8bcFVcMNCbz+SuUv7CxHDUxtiHM+ti97Y7co73j7QHcD1zwNr+HbBqjDbD8IxoeMg0rd5IdchO9GWa7PRJQsNhaHzhmw7/uH/x6YeSrdG4f493f7I+t5981eJPLjfFlD5ihHjyA8V2MeSeSVGWeTw+K4qP8Lzb1+IOv1Cqaj/vC4E77a99eqHo0zz2wCAVqLB8ZyGDiBiIxQh/gd68ihJUw29lYkB2FUFwrIdoLn1YqfzFPe6nAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1ExqXP8lMl5+Ft1TS2Tc8eK1UJQKplsG+QEUgxpfew=;
 b=N8S976K5KtfrKIunlNXn1TT5GMcTkuSBm/2Z9lFv5/heAbeq7lKl7roUB+hu/niy8uEzwLfqTwLa/snirF/ch+WC41ysb5/ynUiT+Bkgk6TI9/8JNQXUxIK4dhQuyyz2O0cw4jlyDkpi4LswR+SvbyulBJN/0nnVrZ+k0zycymvEJSWElgQ4+59U4CzDtiJO168pOWj84b57cW7L6/btBO9AsbDbVX3htZY13+vnaViuVMxWITTzlu8uomjxPD/TLodLWPY6K0gWUxLkRQSrMTl+njhYLX6lJfNPO5WtGix29KrPxsp35TMyO1VpreH8i2uzvuMRmLvjwijP9ycqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SA0PR11MB4718.namprd11.prod.outlook.com
 (2603:10b6:806:98::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 03:59:13 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 03:59:13 +0000
Date: Tue, 13 Jan 2026 19:59:05 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 13/13] cxl: Disable HPA/SPA translation handlers for
 Normalized Addressing
Message-ID: <aWcUiRJpUesoJL3G@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-14-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110114705.681676-14-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SA0PR11MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7ed688-ee56-4b9b-48ec-08de53214754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q3PeHBKxi3uPA3ExeGcomYQ0/7+Jc7osJyoT7aw67EsctSty65SMZPvRjVfE?=
 =?us-ascii?Q?1CvB+T9EQ3gH8IpUkKJC7rR1mnhPLJWhj/Gzr9We56tX23hvpwcf8Ci0gxlQ?=
 =?us-ascii?Q?A1M2MYaFjHxJqzR9IQHjIejrWN1Z8yfkIok3z/DLsb/p8+3vRUtTQWmHgcPz?=
 =?us-ascii?Q?+n5jQmnGjhicvaBxkGLOzz6oqMK1YdOIfZG6Nz5qE5xLBvXWe1m4bazvlbBN?=
 =?us-ascii?Q?grrPYU6gE7FKkYYNP6UECGSoN5VNhCOySDn6KcWArH+WatFdU8z68T3ricGj?=
 =?us-ascii?Q?NAZzBqvWwVccjSmdPCvb4UG2a3xbFndJvFOpxkS6eu9nSCsQXxx3Fsz3X6Aq?=
 =?us-ascii?Q?oD7Bt4LJP6Z/clpdbtDnvj1npLJWGTxxS12JUxPAJZiy9vowjtRpUIbjyaL6?=
 =?us-ascii?Q?7LnMtdKanax0s8tzJFiIL46GffDxh7dYLEokfHMqTDeZfdLOIQDeVjtE5hqT?=
 =?us-ascii?Q?Q5Qg9NI1+k4RIfREgBGOmdILnr2ftgVBzADpPHTueusHBRfGPF3B0Vb71xee?=
 =?us-ascii?Q?lN0kGeXEIV/hqF3fdkNTI6R+xZwDiN6jLelZ7SDD+xAixB11EbKDRxODLujT?=
 =?us-ascii?Q?p49EKxCFxcTTwNNSgPO1haN1Hp6pcc4GSCQf+cPXgo7qWifuBokcPTaBoDoS?=
 =?us-ascii?Q?EL8AzaMruf2U+pO8QU7VBZWHEkxEM2KYv5NvFyJhNJQ+7cDowTe8LGd49CKd?=
 =?us-ascii?Q?cPGrDQkHYXNzJ0W3JADOMHge2qPRzO9TRG8YG5fge9jtdanWdrlAvN+1drD+?=
 =?us-ascii?Q?RM/cvaVaDpkyisrkIiAA77FLMsUu/mxX9Fre6sQdiu6ycMpqJFsDSh6YXClo?=
 =?us-ascii?Q?Jm4aeyrOfVxQgRZBfSt9SeZyUtuDIDRvqqCaZUaCBpPXmffSoWhCndijsCll?=
 =?us-ascii?Q?mOHM5YY0giMaKABNS6nouhZQSLJYg6OH6yXjvKxiWGFxNZ70FezHbNzmR6T1?=
 =?us-ascii?Q?SfhEt6shpTCJ6fZzUKRG1T3HB9MgMVlKXb2p9RJrZG88dr/ukW8AtkKGLhlA?=
 =?us-ascii?Q?zkIka/EN3bvQbMY7yZwu9Hha4Eg1cdF3yUrUaXzX4VKb+7fKSKE86pNiEWVA?=
 =?us-ascii?Q?nwSjjJs7idz/W8E7FvntlY2+7nA0RlqNtY+3E7NWQaZYzFN/+wCFjacV3vKT?=
 =?us-ascii?Q?o+ZYQjeuJh8jSLLLapNbV9LBGJQyacDXPUSnHRqqQFd5kXaDajr5TaSQhm4H?=
 =?us-ascii?Q?JAM3yxvLhZL2EaxyuDjRO21efQpMt8LOW0oNx3m1BeL4XLzfqH+cJJ7+to40?=
 =?us-ascii?Q?uS8aWdMPUJ38I3vBL18nMqruD482owx/poyud+6GySZM0tGicVa2Y3IqYaYE?=
 =?us-ascii?Q?bzAt3seqLBukSGQzKqz36uUtrewzRIj1U2n0BLdfjlPAoXB2rxKKA8hvmVY/?=
 =?us-ascii?Q?eADn7p4op9ovR95ADtfbkJ2TjngkOyqAqXMnwJQcMcBfEDQTOnqcndeCy/n+?=
 =?us-ascii?Q?Ctxe9G5gdxR7W5vuilSQU0kd8l/01XEb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fmm7JbcVj10EsQT6mPGvl0XmJuL7RxvVHL2nkmgqzC5oHkNmM+h9EnfRatTf?=
 =?us-ascii?Q?GDNJc5KgD6ErrrysozVaZrACs9a+27Vmx9ZR25nANWE3fsCalbzOgBGos6ZJ?=
 =?us-ascii?Q?iOXJIP7vINDYG7n3+DnGHQp9GHImhzE8XSkbjlBMCx7LP7jTK+84ijNiYD/t?=
 =?us-ascii?Q?5MTeEkFwfkY6Y8ACi+mSzLrMZMjHZimMXmiEFOF8AXUF5q7IiwUcnwgakOum?=
 =?us-ascii?Q?ITMFJG3BXLpkIVwbhw3Ah83eFFMadnONcrJlsflyViv7Pzpyht5P8eOpGOQy?=
 =?us-ascii?Q?g49b6aM983036RP6n8sns3Jd08B7LSCVM1eccd137NOSTA7UrYuc0kirPR6f?=
 =?us-ascii?Q?1pna1jt0CQj/a9dz2k8qM2n7Lwk/DN0O3sfKcuP4ICc7oWXtv8mvjcZl0tQX?=
 =?us-ascii?Q?TCDsZtA6v/rGNCYEIF9MKt7m7Lfy5uGI32be9AWJ/BTf6KynohIvZAkaglLf?=
 =?us-ascii?Q?k7OM75HVVOZ9jMRRFKSeSYyFzgELmjrLOezDwX7dEh9ixmfsJsx0DxfBFPdt?=
 =?us-ascii?Q?sliGN5IrahGjHuFLDnGxj0whtMQmseMfMhvxx8eUpc6WiLPeisEXRI9V1uXX?=
 =?us-ascii?Q?zyBiMFSHezg1nGO7u14khZFtlbTQCQ89/rwP9JqtznyxJLHIy/MNUKP9LBue?=
 =?us-ascii?Q?FkPKVajC4AzGIuDInSfm1Am8Bj40FyzBrCH88zPHpBqmwzF9xwToaJqvnr2y?=
 =?us-ascii?Q?G81ERBrnFg6kCDaFOFEo8jrLUK47ZMVR/N3o5gDlTHhSFY+l2JWJy9J+xNQh?=
 =?us-ascii?Q?oqJbe6prmp78ZBIJP/mztKRM8gXOkXkrBinxRHS7HUj3nTjGIkk97yYMoXs4?=
 =?us-ascii?Q?a1ix3TD7CXZxtmrbm4DW4fSrRtqN87bRb6A8EancdH6Z/hl8AqAO/l4LhxiL?=
 =?us-ascii?Q?HPp2aSaPEu8oAZkuVOzhsOmcUlKwXOP9I1/eNwXf5REk7v6UFGArGxexR0+6?=
 =?us-ascii?Q?UhZStjIkQaq/hil4MuzZcaef+o4IQ8CYc/lplghG9YM+zhKwgWld1RvwzhNJ?=
 =?us-ascii?Q?0eqmymvYsxR3B7Vqw9onKG3BLGx01v0KtRnAexYZYAJ/uIuZx/43/8CV/As7?=
 =?us-ascii?Q?sPm6jh/hMSi/oxy24pO23UFl1q6WtpYilwJe58Z26aNLLM2Cyc4vTJhad1rF?=
 =?us-ascii?Q?ZogtQyliCEb1+jyCSUilbvjMUwqSkmAiJ55tsLz3VNAnNAI2F/5kBId34iww?=
 =?us-ascii?Q?oyg9qUYJnHt1AogaNZdpVYELu/DCiAhkou6nDhEZWRUztidpqGh69TWAFQAR?=
 =?us-ascii?Q?oj49WhVLvsYjKH2iY7Kf2Um9J6sYgUF55ZbQytuAIqpCBfWKHZ1EcwtT5V4j?=
 =?us-ascii?Q?Vu4rPJrVm00+Vqjos9oyPr2PsaUjiPkJdIl1laVN3jrkan1Uw0dpW9MHdM8g?=
 =?us-ascii?Q?pbM67sQyMeI5gRpkcoTwmbsSInGGKcbL5Erts68M0AVTjwYYrdi4yBU+tvA1?=
 =?us-ascii?Q?j6Yp87fgrjgnXX45oaxglUwDt6naBUtRlx1vK2d1fSa+e6g4FgHWomUkNGqF?=
 =?us-ascii?Q?IF7wybJGL+DuA3n7KcvOTSZtCRFWmPUoufZUDlc5CjIA4YQ8+F1kwulr3mcJ?=
 =?us-ascii?Q?4pgooIaCTntrLTBb7ZZ1afcHCri0Tg7pKvt5YqfMTzUb5IJHrW6VrvEuEWiG?=
 =?us-ascii?Q?GNBX1YdmUgml1lOBo3lw8CagymNq5tzJTOyJmx4/4qZmuWso4nqFdPllAg2T?=
 =?us-ascii?Q?jAy6KINgz0E25+nyPLNHnPcWHLsnYlWvh9n+VTaH4kwoDTgwNF6nptiJmzke?=
 =?us-ascii?Q?pFDT1jQB5YitTAnECryUkUsyVyWQQqY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7ed688-ee56-4b9b-48ec-08de53214754
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:59:13.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VByGYZlmsbv1wnLPYjof52hI5YdaeweL/iHyrHufby1L92uL5mwhy11BOnYlbxC7k89YNs9kpvzEolcGv7x85nhaF0amimVaHL4h8uAh9xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
X-OriginatorOrg: intel.com

On Sat, Jan 10, 2026 at 12:46:58PM +0100, Robert Richter wrote:
> The root decoder provides the callbacks hpa_to_spa and spa_to_hpa to
> perform Host Physical Address (HPA) and System Physical Address
> translations, respectively. The callbacks are required to convert
> addresses when HPA != SPA. XOR interleaving depends on this mechanism,
> and the necessary handlers are implemented.
> 
> The translation handlers are used for poison injection
> (trace_cxl_poison, cxl_poison_inject_fops) and error handling
> (cxl_event_trace_record).
> 
> In AMD Zen5 systems with Normalized Addressing, endpoint addresses are
> not SPAs, and translation handlers are required for these features to
> function correctly.
> 
> Now, as ACPI PRM translation could be expensive in tracing or error
> handling code paths, do not yet enable translations to avoid its
> intensive use. Instead, disable those features which are used only for
> debugging and enhanced logging.
> 
> Introduce the flag CXL_REGION_F_NORM_ADDR that indicates Normalized
> Addressing for a region and use it to disable poison injection and DPA
> to HPA conversion.
> 
> Note: Dropped unused CXL_DECODER_F_MASK macro.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

So not for the commit log, but for my closure ;) - 

A system with normalized addressing:

will still:
	support poison listings by memdev and by region
	support poison inject and clear by memdev

they'll be different, in that:
	if a DPA address maps into a region, the region SPA mapping will
	always be ULLONG_MAX. The region name will still be available and
	valid. That same difference applies for General Media and DRAM events.
	(This is the 'enhanced logging' referred to in the commit log.)

will not:
	support poison inject or clear by region.
	(This is the 'debugging' referred to in commit log.)

