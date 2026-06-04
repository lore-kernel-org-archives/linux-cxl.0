Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C94779A4
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589984; cv=fail; b=jbxAQcEEPvji1JwuaATRveszDaLcmbsnsIWcZhpah1NGKX/GkJTtwksd3+lbv9HUomldlsk5T0D8kjTNdZM7dwwHaLnzqiKIk6SA6v10rTsG82ZtJiBGqYJvY7qNXIhfS4RAJrPbbVcjIH97gx0cO2XM1ZCbtIKd3am/HgZYxKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589984; c=relaxed/simple;
	bh=ZIekeHQp3/mYJKUgk/FO+xY0w+xqjUTkfsdvpp+LSEk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YJ9yA23KbMG4xqCS/EsRkXWFlJCJ+7989+aC3dmyn13i6JmuUzCjBpU7jPhxb1DxwhpXCA+yCfgSQPTuItp+CBm0c9RGVToNGsMkHhGCXiBfGjiY23P16Slnny46M55qy0Ad6mjh3zohC6/8D74+1h71pA5EnjHwusOC2S5C6Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KsjAwzTO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KsjAwzTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780589983; x=1812125983;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZIekeHQp3/mYJKUgk/FO+xY0w+xqjUTkfsdvpp+LSEk=;
  b=KsjAwzTOhK3zurYLJEwOHiDvcuojnyct3uFdkz7uFuNftAO6SmkIIpFX
   3XB6DcvH7lg6aai2TwMOqqw77WUQLwY8pfu8nwiitScUD2NC3kXiwQCa7
   /ihPk9SBSrAXuCppYNfzwQbm2cJ91hEbiSLy/O2ewr7CVp5uNnW4Qb1p3
   crY6TvVsZVPOuvl9lTPr3fGxApPv2NS4x7nFfUpmSuRJJ3JJb17fXwtiv
   HYnfQzorpHLsq9I10+4XtJh0o5voX5vGdTSHgkEXtBN2E2MPqJVqVf+3N
   bkSaic57KkM+Fflncia7nLNY99XQ4oghdBfW6HChW3rlTjZL0KVXXQsG5
   A==;
X-CSE-ConnectionGUID: WwWpdQEJQC2Z+K93jW+3TA==
X-CSE-MsgGUID: YgN97yoGQW+sZpWtxeRnrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85310528"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="85310528"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 09:19:43 -0700
X-CSE-ConnectionGUID: 3ZuIicknRnueDm0pn4vQjA==
X-CSE-MsgGUID: 7ynHEe02STCEh3pWOG2qtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="249512581"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 09:19:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 09:19:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 09:19:42 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 09:19:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFm4clsZcZq0ijqKOqJa7Bi7YYHxhYBk9GBkoROqHQcIHPCT9ppY4tM9ALQiH3Rg4/hjkpo1HM62cOnysFou9Ez9NIOxDtf/6CYkQfsdS5ExawxJkGfUHN/ezdmVXMe5X3aI7kcuWJ8k3OSrCRlx2StqbajeZ+LGu2YmE0Jb0Cfyn3b5FTp6SDVLBxOgcvFM+Os92H99TyWFaZh75kXHkZ+MRSIGvd8UMa3eTao6Uyj3Q9daC8zcpKq6+emArGw4y+kXLu0g6KD4PzS87Uzr9TVmpeS/RezlyLMIu2RKCAexsIvGOIqN2s5ZiuwxqT3xQ4ZMa5SwXRoxtgNckE4U1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIekeHQp3/mYJKUgk/FO+xY0w+xqjUTkfsdvpp+LSEk=;
 b=AGH4N6GytjbL8Lvqgf7k1AMUJJrPe482n5uApEsvl2yfSAHZ5a6f/5yOh3VrI9PsyrspKUuAetB168nWhTpQd22V/HeNzcISku8MIeB8n86RZX/0wwSfG7kdWKFrxVe6Fjxofho0xdtEh+uQpzh/+oJ96arAXgWkSVgzmEWzdTxfaYB2JTDfGBGdItDfs63Y1IvStoBrxjxBX+eyLgcxwUsK7dUwnFA8L9Yf+gtY3tdclrC3gwhJYpM0tROhgTPAOf1AukbAwJUnjkWZnoKVL1m6VXKSm5ekRFijwsQj1N+PkTgg3cWuIJHaaHl659OjkCrXqXxhKpae7vkDv2C9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPF1A07FAA60.namprd11.prod.outlook.com (2603:10b6:f:fc00::f0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 16:19:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 16:19:39 +0000
Date: Thu, 4 Jun 2026 09:19:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<djbw@kernel.org>
Subject: Re: [PATCH 0/2] cxl/pci: Fix the incorrect check of
 pci_config_read/write*() returns
Message-ID: <aiGlmKBaECxkxA2T@aschofie-mobl2.lan>
References: <20260603185752.4149725-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603185752.4149725-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPF1A07FAA60:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de9e266-c186-4209-e3d2-08dec25513f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZN9eRiRJSYIIruMJtrl7DiAi/ZOu8xEfHUPfIiumLLLuBq/fFrCXCCRceclwG7Xj1xUH5d4h02105ICCk419W+wROY9ls/hdvImRJ7bR6xuTQeGFmOs5xTXG5Sf81lduJ82y6qwqGdlT4YwBf37EGZGPonPS4r9lnrCGnpT7+M+d2jE+3cBDq+fwVOKdvr7jc1XCWv7knjKZbobJvXM380YH9wQSFCYVH00MocuzzqQIA6ti1pYZsie5bV6Aky6kvLczmdYPv+XK0hPmSnL7bhOPc1S34JsoQGPG2PP4CQ2UhJCA9dZ5D5EMfIxQypNvrcM/Vqnhm4Q9P8O3211fgvJR7XsVB+2OypzAiAvW14TFBC50jKeDQfRK0Lp+2/ue167GKkAiKWBtxWfRK9MVNbxGNQauOAE2ty1WUu3Bflb0QLq24gQsZJo8PACkyGZJ32LVtpVF73w9HcOZSSlN42aU5xhGxT55USWuXqsVtWBXQ/CVgfcC3rNtMjAZoDER/zk/8d8+HW/+g3MzhHig8kajrUUY0C+x6u+rIx2xxU5+Jt17MUDwU/er1mxLcuB16tHo0R1twG/cm02KWkDOQY6Sv62zBhw+UXC9xgg6qUc/v02IDo86B3dHw/7NnXFE7Xtfzz/AluWl19KUqi+8wsz4zTjMPjWRHtIONIKo5+Cm8hI/8rvx+F9/h0swOtCX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3SwLC1qkFQxd9COhRlxOM9Mv53l1/a9tFtSsEQ6M/J9V0EqxM16vlPpWTd1k?=
 =?us-ascii?Q?niy0Y+9p5Lzx8rPcDunzke1mPW2EuQW7eVRFPHGsyQFyePbo6GenwI8oxnoA?=
 =?us-ascii?Q?kEhpvmSdP8/OgotjrlZVsVXaX02dsAVZg97i5FVeefkQpF9bWqAVcZdXlFTp?=
 =?us-ascii?Q?sv3Ub4cyJ2FgSJXhi9qTNtp2UES9h92KPZ9UmL/8WPlTDUmzR9bv7wMo5M+U?=
 =?us-ascii?Q?4rQKc5p4BfPi3upKGZE5uomauphChKxrabNaLqgxj0oE7zTnsw2fBpZsndEE?=
 =?us-ascii?Q?Z6TYlnOEZAdcYN0XpOs8UQGuR98f7bV4j6uFgPJGZMNmB394oknfAtl91bO9?=
 =?us-ascii?Q?lrKAAbZmJXasfr+n/SaPUOPX3BX3zfG6d9gIVNg2krFR6ZABo9QEcwGxu5fK?=
 =?us-ascii?Q?3qNtOcOByM5zAkHi5Bh+Ne8LanUI3rXBYoJm5ty0xCjv/DaltThgPdpVn949?=
 =?us-ascii?Q?AEFkY7uALEBDYGW/aBN24eAhsT0h77rE5UGeJZqniGRWJ3T4bJyxl2H6IrOr?=
 =?us-ascii?Q?GkXyjgIO9ldcFBsL/18Zy3wuDgdIHRPZy2+fr/2u1rOZUPQ7JeMMAUaAzr2M?=
 =?us-ascii?Q?UKiOyYdChuJKYNr0XNcTr9rSFI0iTCvzP52hdveIS5hqouYSdl7iNMnyrR2d?=
 =?us-ascii?Q?tHVtSKHh3zrY9JfqZuccIk4TLD3AVq5wczL5XJmWvj6sw4UmRT2rFqAEvMe9?=
 =?us-ascii?Q?a4cHi0S3BizhEw3mRUnmSj+fIWYUNltetAawDcfdIp6HfZTTiDXFdkL8dkPk?=
 =?us-ascii?Q?EDmMi0bBSwhmgDoDBCFQUI7m5o2ol+HXn7zggjPaapw3GzuhdiNj/yGRUpy+?=
 =?us-ascii?Q?0DUWmvNwM6kTnj4dDBMrHYaJntUJp3dOV0TfkREorboo6pgoA+jfvmE35VRz?=
 =?us-ascii?Q?8fKC8QpiELJNL9p1UdWM49LS08L/qfmXkib0LGxHTt3DKrolw7hkyQjUH2oW?=
 =?us-ascii?Q?cfLpf7kWihMX7hyyJJxFTvLhCTtA9tIzsC5vfePnB62PDolsRBgZE05DeLiJ?=
 =?us-ascii?Q?k7l0rf1JbxQYohN1XY1q6+IbeJSqPQ9x6jNGcL+31GzsBgIz3F7GcVj6K1W/?=
 =?us-ascii?Q?UelTOoL7xpKbdUtsxcNSkbfux0oU7nejmfqP3K7cuxAb9royvTHLMHag1IMo?=
 =?us-ascii?Q?uYVsVP9g7Q7weL4s6QrgCiJ8L9uP/jynFfNVe5QanYfiUCOvWAa3tcTqoQem?=
 =?us-ascii?Q?fKTp3splfDNUxEIe9p3dRiU3959Gjb15bEDXsDLiaxWJkGXObQQINLJkN38y?=
 =?us-ascii?Q?fEQiRnUkNHBS3yfuWOGShlwy+YZ0X8dz4/5bcGZsw/zUqG9mAMS30lsgB8UU?=
 =?us-ascii?Q?g12U2wapSMHRi0JrVaAjFhr24ie6wRDU+S48z4FzrnRj4yKrW5DfMaUewvIX?=
 =?us-ascii?Q?mDxKsvRiADzaikeeJak23iwJfjKdwhtT4blcJMTo/HVKUB27b+UMDJAo0/GI?=
 =?us-ascii?Q?x9++gPed8lh381BpkinkqD36M1eRpxaNgg12LAZu7s9YSm6rxqhgjUctsyD4?=
 =?us-ascii?Q?FB2wD5BuzPpvKImYys17OeL7yXhvUQrdVgnysP99exCK3VywSlGCvFZoc3kV?=
 =?us-ascii?Q?G3LRHyaprx1TdQSOI2hTIkDY0rci5dVD/huP+q+MHiGpJiC/ocfPzQcyM54n?=
 =?us-ascii?Q?x08up8ivGBZJ4XoVr58xJz9B+ikmJLTffXmaMir9Qdql5DSKLoSuF6IE5qTk?=
 =?us-ascii?Q?ffuUusRhTish29c7kgICEXYtMXKXTHi6ELENaSDNU1OHsfOoAFOhi2hcLbH6?=
 =?us-ascii?Q?HdloijwSgrSGG4DzkQfd+OeKlTUsmLU=3D?=
X-Exchange-RoutingPolicyChecked: dXdbgLxGPffWvF7TnltcM0jldZYYAem8gXtqUmhBd/TF6g7S1pOchVIO1xloLPHYnENNG49wHTTfVg2nje0wT+pkzcByd8DjDZa6zmgj0a78Fqmkoxhk+xDk43g8Hf+ro64OVDGtO/LWf7Vmm62L0F1gNfcXTjXvTpEJC7nFO4QcEb019Ej5Q4RYtiQ7J1Rh1YfbBmnJojPNxyCGk8K1W2iF0K7LP+c9M+l7Ud8QHxAqVi33Uy1SbQW4JoLIM3Tdn51A88WRMKiPRIe4hB1HaG1ie+2xP7xtYzuV2jtARVs0X3Fjke3hQKbi1EYfaoZ8stRXTC2weNTQOtL9lRmpbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de9e266-c186-4209-e3d2-08dec25513f9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 16:19:39.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSRa4wBtQMU5uiLIyZiiuO8jpZEAKuVSzFc02+U9R8Wcw4E713pOA5KAX/g+YAmbwMJShu/orCEFIS82JoRgc/yD9PebvTzjHPoLs++zKj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1A07FAA60
X-OriginatorOrg: intel.com

On Wed, Jun 03, 2026 at 11:57:50AM -0700, Dave Jiang wrote:
> The patches are inspired by comments from Richard Cheng WRT pci config
> accessors return PCIBIOS errors that are positive integers rather than
> negative errnos. I went and audited the cxl PCI code and found a few
> locations that need to be fixed. There are other locations that may
> trigger issues, but at this point we'll fix them as they happen.

Feels like 'fix them as they happen' if OK for unrelated call sites,
but in Patch 2 partial fixups look incomplete. See Patch 2 reply.

