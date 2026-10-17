Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DECE555
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 01:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198970; cv=fail; b=Ao0cBhSElO7QYyzkkZzkv5ghYGa1mVJl72UYiPsT1wqwyGxY3kEKjI51eG7VqGtnqnRUZ0NifPa7MDR8P16V3Y6ESZZFvx7Bc+bew3Ox+Q9PPIE/RCU6jwRh4ap+LQw9BgxTpMyVnj2XfG5LOmc2LBQ0yaqOAJtMSazYqYU2dxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198970; c=relaxed/simple;
	bh=Z49J7SQ7C55bvEkuq/t30akCJNierULK6c3oB6l0i/4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qlI3pD3/8e4iVTsmSWBRsPr/ok/+XJBhVerJP0P5u7WjWRowewSWeU+Et2KVdJXquQ96QJ+lnAQvqugE8g58y4QhDjFRxSMD76XNeJFxoKet19kCHdn1SRrlujU3GRN8DJ5ziJ7fpVzvslJKLXXSRvnRpdiJEBpUiMdgUYQNkEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bd1LkJ5J; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bd1LkJ5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792198969; x=1823734969;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Z49J7SQ7C55bvEkuq/t30akCJNierULK6c3oB6l0i/4=;
  b=Bd1LkJ5JwkenwkD2ItURydYW97/BiSkgG6zx/WAXKdck+5WWrxPPsO9z
   qXq9SKM/mGmMAa2WXtOhMvOL9xq4G+BzVqcFnUPL6dHEGOx9Bntb4j96B
   fVhNCVVuPRhGeinSnEqmQOhFUz9lqy8JW8RrtwtN6Fe9T0QNUanfCyuiI
   OtQFQUaX6LoJm3SUqVMDZONri5c2sPNn9FhfpfDtqO1VFN4gV4RA/B2YZ
   TEQuiaSgsAyg9RUm08zrl9HcWUaZfN3ySlYd4XBi+GBHj7bdpzL4PYb+M
   2lGdmK4crwkSMh1ag6uUhROs3h6M0+E1WwWbTlxQRN8a0F+VyTzWyLxJC
   A==;
X-CSE-ConnectionGUID: wCFWtNgfRKaDn8K1ei34eQ==
X-CSE-MsgGUID: 8DjnX5dSQ1GgBGzpPiSqXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="886867"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="886867"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 18:02:49 -0700
X-CSE-ConnectionGUID: 4EltQ4hMQnmA+EAIB5XXVg==
X-CSE-MsgGUID: qtVyJfsJRCm5P5cZgPj6GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="1953622"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 18:02:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 18:02:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 18:02:47 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 18:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2gb1qnqT5sW4VvVpG7/UkX2PIKHbhJvCIAQ95o8UBG5Utxz8sP3XN9h+n1EbmwljGSOwAIMfDQl3hgeWgAsOv2PMQJLuRiWFdw2D2lWbSpGdugiFE+0vJ+MJ/ehpXiWV+V4NihfyqsIyDB59RD98QUe3TmMXGdnf5M1PYhSAPjttq5sQjgyZeGCbDH37SJ/Fs60O/YyxA87zSwOxKhuBcmYyDjjPy7FY/o1WZwJ7YOZfyr2c+ZiNeKNZL8pptBGxhG/ocu0w367/a6yuS7VR5+aFHtbOBC5yhuLWbi7S+1e+99By2MIGhR1prndrtJr+bT9bICEfQ1G7oUtQbaBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4X4ds0o3kdfy5GMUGnBo3Zeua+EMtRnou4VLy/JH3c=;
 b=aYn/FSMoSxS3wYfBR9FKe21hHvYTKJ0Fji4P0TWDM5ZaUEmTZQpfom/WAPwe4XAFEyRCzQYp6VR+x3ITm75QuS2wx1crLrdP2ulJhDBfoG0XJ4nvecB7/elvnoUQPcs+552XYWqaHi1ycldi3sw+9rQEKDgP4ep0oS3XX4dlITxDWDxRLY1ugpNIpaC6BeiVrIkKr9U9WpmJeL2Nd37LYks7b81YSBbVkH8X0itxUinlE32+I7GWEGBjwV21G7jJR/Gv2CRko9Aio0GxQDECdxlkBRzPUkccSpW4OKmZtYprLDZ2j/9AyMkjqyjkQoYtThKTEDkKxKK7NECZbpIfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CC6PR11MB964443.namprd11.prod.outlook.com (2603:10b6:170:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 01:02:45 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 01:02:45 +0000
Date: Fri, 16 Oct 2026 18:02:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] cxl/region: Factor out cxl_port_setup_decoder()
Message-ID: <atLJMqDeOskdl9zq@aschofie-mobl2.lan>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <b518a60cae9a472c6463195f0173800378990d2f.1791860305.git.alison.schofield@intel.com>
 <8322d18a-19ce-47a3-b926-ac0dcff59c70@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8322d18a-19ce-47a3-b926-ac0dcff59c70@zohomail.com>
X-ClientProxiedBy: MW4PR04CA0253.namprd04.prod.outlook.com
 (2603:10b6:303:88::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CC6PR11MB964443:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a98829f-7511-4cd6-c1cb-08df2bea5acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: eE6Qcin21UriQ3zaMky3hvvHeyJ+4BoaMYBWFNgqNEQZlu3HSjpaPPoJ8jlo7OOf7Fs9IuBFsnOo0f0hHLHq7r5l+YyPm/AxyR8cGOBZT15C0SUdVcwNlwRE71tdphBgdKobNk/RTVyrrJSpxuw9K6bjH99Lr9QnE7LC3a5LwsYwG3j2K6vxwYXqIbxZ07JoakTsNUU1mLVhfx7+1JU7z3OwZGLIZIxbKIo4z8YMuIpMjdN5T0ju6I3Z0mtEuklll0Jg7wN+2AuyxGz6suEtcap3nfI25DkxyEAWjdM++tcWMiLl9/sq7hB3+Mg49oTBytVuoMiMQzEK0gvGgfklnjHUrfaOVUoI5672GP6Deu/8JQYhfa8Tkr8c5QSZhfVe6k5Sl1aGWOcNLGtunQHaLtSQtkJ8GaIopn1P/8MtkeTSbgDoFbUT9eZPvU62lk0AfpTTLC4hU9hcMo22yfrD8ZoHJTaTdeX29baW3BuEKWEjAhkYEMRTWU0hedHp0n22R9vgISNJeS1jzzFaZf5aBEmx1JQSrf14sEsDoTE35qX04EIwtdO0yhpJc04c79fFn5qzdsYLn5aj6Hs/HKRCnpcu0caB02pO5C5sb0JhOUooplnzfntYpOpSjkWgGIOlDn/TMMNUQmkWg4DULVSqQ93ThcpACgERi7FirrAucgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjYyU3BXRExJbjc5UkhzcHlSd1g5cjQrSHpjMkZZNzVQYnZGbXN2TCtxSVhp?=
 =?utf-8?B?aGRJM0VPdHMrN0tKcWZSYmQ2YnE0aWNVSzFna3hBZThOeldlVUprUXd2b3Rq?=
 =?utf-8?B?L2FLVDhpWm8xUEhBSEIwUUVWZ0JVSDlTRW4zUDkvbG1LZDhxc1ZuSzZPaE93?=
 =?utf-8?B?UzZ2LytlNzhaYUY5V0g3d0p6M25vNTAzMWh5NisrOGNkRWdGdmsxTFR4NUZ0?=
 =?utf-8?B?dGFhUWZWRmhxTWIzdmZVUXQ1VmppL2U0cXNGUkQ0QzZwblBiSVZUN3FmUzV5?=
 =?utf-8?B?Q21nK2dNbE5SS1p6TUpyOFVwM1VUSGhDMDZmYTVwTS9LRnV2MXphMTlRM2sr?=
 =?utf-8?B?a1p5UkRBNnJLSjhaK0pGemFzejl0ZzRUSnNuSVRIZWhjVElmQWFoSENTY294?=
 =?utf-8?B?QXcwRWF5SHJMYnEwMjBLa0JmZDZTM0UvNGErdGRDV1lLZGx5TGY3UEtJK3Rh?=
 =?utf-8?B?NFpWM1J0eHZsMlFmc0ovdXo2b0xseFVHWnBBNFJhSllnbERXYXN6Qy83dUY1?=
 =?utf-8?B?dFpEUU4wVlFDV25Ed0dONlFjTXFJcFdpVExYQktreGYzS3BPTnJwRTRXK3dU?=
 =?utf-8?B?QkNxUUpwL3ZlSzVGRk16b1FESWVDY0ppNnhPc01oNzJmaldYQXkvUUNxWDZL?=
 =?utf-8?B?WXAvYytkTjBmVVd6UThQaFFwMFlUWGZUZzMrREV5ZTlqUGdIak84V2lHc1NT?=
 =?utf-8?B?bjM5SVR6ZGYxQTJRc25pMnBHTHlsSml1ZkNkZ1RPbE5LQzh1b002NHpSSklH?=
 =?utf-8?B?d3dwZkJhTS90eXI0aURod0J2T3l3cjhTVVI5bHBMQ1RkS2FVNmNRMXRZSlpM?=
 =?utf-8?B?RXdLa3J4ZkdDRFJMc0Y3cWI5S0RFNnlPMHdoZE9qQWZHVGtKQzVRTHhlZ1Jl?=
 =?utf-8?B?RmxGL25DNmNxRjNyb3R3MGZlSko1bzNNRi8rZjFKTHhFQlp6SE9xRkJWVnFm?=
 =?utf-8?B?M29acC9SaUxjc281MWx2RnRlRDI1TzBWYUkrRW1OTkpjTlhKMGNIZmR1S1Ur?=
 =?utf-8?B?YjRNU0Z3VmxGckZIT1JRbTVyOXAzakg4b1M0R1FsemtXeUFoSm9VK3JtR05G?=
 =?utf-8?B?UEVRbHc3ZmpoRUJEbG9hQy9tZFpjYXo0cmJEdnQ0K3ZpYys4OUpGSndwL1NI?=
 =?utf-8?B?SW1tbWI4Szh2bS80VGRTc0R5MnJLZDFQUnRreEkxRHVtalg4TmJEY05aYlNo?=
 =?utf-8?B?MVpCSmQ1MVVxWnp1LzF6aHNGMG91WVZMSVdqSThKMDZlWWltMUo4enp5alM2?=
 =?utf-8?B?SFhyVkp2VVozL2M5Uy9VdnMySSs5eWJVSUdkc1ZqUDhzZWdlamlqTHZySkF0?=
 =?utf-8?B?YWJKWU9kNktYbVhaakduaTdxcEsyNGJ0TSs3bjBKRXdXamF2ZUtUNUR4cWlY?=
 =?utf-8?B?SHQ0Zy9hN1J4MmljQkVuRHVpeWpqU0h0UHQvQ0NuaXlxRC9mNzhKUlVacERv?=
 =?utf-8?B?QWg4RTR0Qk5KNHFwZWpTRGxWOEdvS3BlWmhwYzZPV01MY2Vnb0VNak92S1BD?=
 =?utf-8?B?aFB0VHRGeTByZnBnRlN6MjI4aEFWK3lTcTNiWi9IZ05EYm54dXpGLzc2RzRi?=
 =?utf-8?B?NVMvaWxoNHJUdmxIN0pUbXArY1l4MWR1R0pjMW1UbDUvY01PYkpkTzVVQTJ2?=
 =?utf-8?B?QVBDcmw2YVE5bXBsZmJPaU84MlVDWmZTL3FlY0V2djE4ak9IZ2VWWnZrS0po?=
 =?utf-8?B?Z2xEVHl4OEtHUnRFK0ZRYk1zRGpQMUdrZ2sxbHZTSVBmcWVuM2pFL3NqRFhi?=
 =?utf-8?B?R05tY0lSZHB0a2ZqOUdUTkR0ZVVYVkVtdC9QU2duZkpDTld3cm9Fb3hGL09q?=
 =?utf-8?B?RDk3VVNTZVE2RVBxMmRkNU0wN2oxL2FEdVFjQmd5WTRmNUcyeWNiV2ZwN1Yx?=
 =?utf-8?B?d3EzdEFweGhNV3RBVkhXdWZlVXZKd21qUVA0QjNJUDZaVEtoWkkyaHRkV3Z1?=
 =?utf-8?B?MndodUtsRnd6OTNJeTRMYTJtTHZwZERQUTc5ZEhCK1c4V0ZPd25wN1d5YXN4?=
 =?utf-8?B?dXlmbXV1cUNONXBtRFpubW01UlBzandVME85MFBxbXA4ODZLRnMxOEhGTjFo?=
 =?utf-8?B?NXVTSzNzMkl5cGpHWXZRQ3NUS2VHTU8yVHBDWkN6UWNIZ1licmxMWUZaQlI4?=
 =?utf-8?B?eno1aFBORDlGRlNHUlJ5aVJ4VE5PeVlkbnZPM1dyRGtCWFZrWGx4ZjEyUDhT?=
 =?utf-8?B?QzBrUUNucXFYUzFJdjBLNFZ1R0tJRmJPVDhRUWZpVHFSUjhkTnpuWTFyZ3Fq?=
 =?utf-8?B?SDlYNmdBeEliVURNenJnRGhLOElnaW1BSE5DS3N4SWFoSVBrUXZ6NzVka0Zw?=
 =?utf-8?B?YkxVS2lRbi9rcmt1akdCaDRsSU5KOGdyVUVqM2plSWJWdEZRa0JLRy9yMC9S?=
 =?utf-8?Q?hlkPybiQjcHeBWR4=3D?=
X-Exchange-RoutingPolicyChecked: EvDvOPZYPDUMnQs0AGX/Cv4/Udy9gE2HcmuvB7iEHqIEyb5y+FalNnNvp1MRC/7hyfuntxjCXVV4+6o9BaXSKqsCOcKv7f0dV/DkSgS+8MjjL+ALsZnJVI5DQYAOQqafsVgHuM4An08UBK8MfLVc5SA6sAl/V0pBtd/Gd6IJ2I/+yIOCoKTL9zV5CKzhko+DgSYq3CjZb3pbwAYYZOOwX84MJ7J0AIjkRzgR0MLKENnT7awQ1V/yLKtlHZvZw4vxRJLgEZfsqmqC5R5I6aon1vUUNnmYhlBDwdjM02U5GFwQ5Ua/GUdaTXAkYKWpThjQZns1DdFJgt36E0woMSThIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a98829f-7511-4cd6-c1cb-08df2bea5acc
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 01:02:45.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtHbHNPPNhwSHzkBnKTGwpYmhxX7gm1LdRz2jPjGRiTx7wzlLpuKf7ZCj7ZDFTfo+97h/9bTkpa0u9i/opir0Sk47YlC2rTcukrYc8V8pSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR11MB964443
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 02:55:39PM +0800, Li Ming wrote:
> 
> 在 2026/10/13 12:26, Alison Schofield 写道:
> > Once cxl_switch_port_setup_targets() has calculated the interleave for a
> > port's decoder, it either checks that interleave against the decoder
> > settings found for an auto region, or checks the decoder's interleave
> > capabilities and programs the decoder for a user created region. Both paths
> > are open coded in cxl_switch_port_setup_targets().
> > 
> > Move both paths to a new helper, cxl_port_setup_decoder().
> > 
> > No functional change.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> 
> 
> See my comment in patch #7.

Got it, done!


> 
> > ---
> >   drivers/cxl/core/region.c | 88 ++++++++++++++++++++++-----------------
> >   1 file changed, 50 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index ee9e615a9a4c..229372123271 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1561,46 +1561,11 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
> >   	return 0;
> >   }
> > -static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> > -					 struct cxl_endpoint_decoder *cxled)
> > +static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> > +				  struct cxl_decoder *cxld, int iw, int ig)
> >   {
> > -	int iw, ig, rc, pos = cxled->pos;
> > -	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> > -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> >   	struct cxl_region_params *p = &cxlr->params;
> > -	struct cxl_decoder *cxld = cxl_rr->decoder;
> > -	struct cxl_switch_decoder *cxlsd;
> > -
> > -	/*
> > -	 * While root level decoders support x3, x6, x12, switch level
> > -	 * decoders only support powers of 2 up to x16.
> > -	 */
> > -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			cxl_rr->nr_targets);
> > -		return -EINVAL;
> > -	}
> > -
> > -	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > -	if (cxl_rr->nr_targets_set) {
> > -		int distance = cxl_port_peer_distance(port, cxlr);
> > -
> > -		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> > -			if (ep->dport == cxlsd->target[i]) {
> > -				rc = check_last_peer(cxled, ep, cxl_rr,
> > -						     distance);
> > -				if (rc)
> > -					return rc;
> > -				goto out_target_set;
> > -			}
> > -		goto add_target;
> > -	}
> > -
> > -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> > -	if (rc)
> > -		return rc;
> > +	int rc;
> >   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> >   		if (cxld->interleave_ways != iw ||
> > @@ -1639,6 +1604,53 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
> >   	}
> >   	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
> >   		dev_name(&port->dev), iw, ig);
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> > +					 struct cxl_endpoint_decoder *cxled)
> > +{
> > +	int iw, ig, rc, pos = cxled->pos;
> > +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> > +	struct cxl_decoder *cxld = cxl_rr->decoder;
> > +	struct cxl_switch_decoder *cxlsd;
> > +
> > +	/*
> > +	 * While root level decoders support x3, x6, x12, switch level
> > +	 * decoders only support powers of 2 up to x16.
> > +	 */
> > +	if (!is_power_of_2(cxl_rr->nr_targets)) {
> > +		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > +			cxl_rr->nr_targets);
> > +		return -EINVAL;
> > +	}
> > +
> > +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > +	if (cxl_rr->nr_targets_set) {
> > +		int distance = cxl_port_peer_distance(port, cxlr);
> > +
> > +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> > +			if (ep->dport == cxlsd->target[i]) {
> > +				rc = check_last_peer(cxled, ep, cxl_rr,
> > +						     distance);
> > +				if (rc)
> > +					return rc;
> > +				goto out_target_set;
> > +			}
> > +		goto add_target;
> > +	}
> > +
> > +	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> > +	if (rc)
> > +		return rc;
> >   add_target:
> >   	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> >   		dev_dbg(&cxlr->dev,
