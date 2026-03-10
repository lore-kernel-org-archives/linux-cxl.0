Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE443D905F;
	Tue, 10 Mar 2026 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172474; cv=fail; b=uB7f5sYX/qA/f8kX6wI0Mwbcpb+jO3MmssEpGIeVolINUoItv+L9BTEUIc1KKS5HvDFxNYnQvRlFxuN5ct4OXvB62RAZm9EwmcO884kVmo3GLcUogp16OxZTfifCccExTxOrs55wxCEgzjwJPbwwmUxKgl+XbaD4OcztVD7g7NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172474; c=relaxed/simple;
	bh=8Q+kfwHmKnjxKv0NP4lbaawXNSJjHXqvOBfEaE2oUdo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=HCx8LffS7lXqyPo6vwZ0ph/RKTP7JE2AH7GnYdp7ptD42oDcV6t8sAKYlCazmZPAmeBLc6pmWFepvtekuPPJT44DKuakSXD9uPYRkdnW5RYqkHxnlxzpAVle2tE3HwOiA6XqzgOtDZ8IN3KIBM5/+UDBrXGoAXzPlTLlXd9ysu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjbd992q; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjbd992q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773172468; x=1804708468;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=8Q+kfwHmKnjxKv0NP4lbaawXNSJjHXqvOBfEaE2oUdo=;
  b=cjbd992qakkxqkqh2uaoM8GB0pGK2p2JbLQpChQpSyqDmAOwgKQhI0m1
   IyI+okEHf9UX3DCJ13pkwHcFNUfmph8B9ghE6uDo8tfjbQKCXTsGiUbjw
   QQOtPiQ7f/EMMOSYpbPmpOA1BlKwT77Xn+fTOl75SJR3O9zRioa0D02db
   NqzpxoqMAD0Jxj0mndJhNBiu95uSWzpEPFFdWoSF5L+wxPA6aXK3Luf2D
   NUbPg2l5AYYqFkbR79dBsV/ypiSyyXNvQF4HaGc3rM6bHaJPrVtnDV0ZN
   tyx2uFmLiF7gxHQkkI3DKF0BprrSwZ7y57zG+YsbM0X9LXYEg5rMhhCyX
   w==;
X-CSE-ConnectionGUID: d6/Be52PSc6DZOnGad914Q==
X-CSE-MsgGUID: Ww1CJ9b7Qlm1Gn7zct3NKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85586503"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85586503"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:54:27 -0700
X-CSE-ConnectionGUID: iB+IeJVtR6O0BxpUUYU+eA==
X-CSE-MsgGUID: ihr8JuEJR7Cl1xFNH+bQ2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224680918"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:54:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:54:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 12:54:26 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:54:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgMZt3TXGxSj/n4ibBZ285wWjF/bqeV1yJHFfpud0Vm0kZ2MI7JxGvcCyh4PGnQP7AEmHfgvIREcZ1DIwpBdZJCTMk4QPkyKBpTm+coMk8iF6UYta2gV+O8LZhLnXVSOxweE8u4zV/2W7yK4WyvmPIyeofU+Lrb4FHZ4ZpdpnlHctX02PYIu79BscOK+OOP8pLOKjEj0k/n02C2EG7CxaSocsfZCPfUsEQOy6zsdACZOeBhqgsIPlse5YuDBjDN2uKzVmHN3nRTDrj7sSQzTTugPCTyReYMUlw86VbuyQH7wCwbdIJCeWJekIe7oQTwLZC0A8lROIVbL2lLRw85L0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q+kfwHmKnjxKv0NP4lbaawXNSJjHXqvOBfEaE2oUdo=;
 b=vd4mhx4RLMhPzBIn+i2P4tXHvEk4AnYb4Gx3zoKxrn1DurVTRUKvvHEk6w2sMYmrz5WAmwl9ZI7Gi4GbvRneJt7XfSA4cJLD988BLpQ8LwbBtUTcFs0r71YU/MN72zr+oDQviPW6R9chev0CFKtUGCkAUGU80B+Ib9B/kAxG1aGGIgQw2OjvVdG27lUxS+zJpiByC2HFZ/xbY6RPjnjVOnSMvkdP1Itvur+lrynhE08hxjlgRMmmIVqdkACWUSEMO4L3bOX2xMNpcsL9dIqhyI5wSg2oqaGTPpNSwrGRTW7QomOFMUkIVTunimjemC/+yVmCG0qts0rg06aaL0aEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 19:54:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 19:54:23 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 12:54:21 -0700
To: Li Ming <ming.li@zohomail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Message-ID: <69b076eda4655_490a1000@dwillia2-mobl4.notmuch>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-3-94fe919a0b87@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-3-94fe919a0b87@zohomail.com>
Subject: Re: [PATCH 3/7] cxl/region: Hold memdev lock during region poison
 injection/clear
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e5b55d-6176-45f5-ae83-08de7eded395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: yy47Wly1feodlEZNV8R2/kEo59S+wh1nPCT+NyRWzQpu9CTmOB/P7iMsDAGZ/dkD9gFEHxAVPNz1p5e3s/QAy75Kril9Boen1KQAAYQqGUXOUOowUFuePrS4jIQLGc1Q7JQEtbTwrObd2GNGdH2s9IJQGxA8ahv8xUr/ZQVAjCJhPvlqebKzN6HSkaw95HN+CXwZtzbGV/9L0HWtul7aWriWvtMgTIWn12Bm6GUVnZ/o3zzUFQOYeG046KkE9DsHqAK5hwCOkAvlOxZQBpNk/5PY4z6486hLq6INPdY7hSZHNzrjIY81AeatHd8SlHqS3JHo5+NflRM36HvQeNBmgHqyEstiAfTdkkDuDHq0o6dLB2rNQaJfarW3fdEvs9gh09eo4DQa2F2K74DfoHGjIiyxiTPZtYKWCnhkRmNaySTLoMJUYs4CJJQZ8yuTVEa4ryNmZUP3Dpg9OWc/BJpcezbNn8jJe7s0PglDu6It/YfcqzLgRadOFJKVYdbim9XmZ5dCa5SVfTYbdnSaRYAw8sXKaxwGtBnE+511BZL+RvFfQC7RoOzRcpEQgyE5YQ0p/b6aJoxUJnr0gx+365DVeCcMlQ3HPQrcVzJbMcLnG/h4Yksp0/cxKrquYbchRVzUi5mdrmbXKe4GkNq21woyMQUkVByP31N2kRI03XB8C0DtvabIl7iiTjoxPgWbVITJUlGiUUhjkN/Ts0JodlmwpiJ6znc508dbqY/L4O6xncQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFWREF1SzNrMStWZWVDc3g2TnBZNk0xdG9LaCsyUzFzbWh1MFJ3bk9OcmxM?=
 =?utf-8?B?QmtZYWdCOTlzcFpRRnhnZkorMDgyNnFaaEMvWGRXWlVCZUgybGRQbHBSdVlL?=
 =?utf-8?B?MWFSd1dOTUg0M25JMHZCV2NuNzY3WTc4cXJsQkpPU3lWSlV6RUdLMWR5V1Uz?=
 =?utf-8?B?a0NHWHdBT05GTldYaUtBdEQxc2JXdHJuZnpHSk1vYjJ1dWcxWEVGd0wxcjBG?=
 =?utf-8?B?bEZJK0Y3WUlmQW9zQlhWdVdQZjFCMWJYcll3UVljTFRjSE1UbXQwL2k2NWtu?=
 =?utf-8?B?NWdqNmNuN0E3eFkyZC9qTm11UHJiTHh0UWlNVnRVMEZoVlp4Z2tkY2FhY056?=
 =?utf-8?B?S1J1L3EzczRRaTNNT0U2YUxJZTFnL1IzdVMxclEzT29oTGtMRFBJQnZoYjVY?=
 =?utf-8?B?NG1KNFJPeVY5K0RtbUZmeVVrc0QvNW51Ykp4VXNsbW9Sb0cvMGVWSTZYeDV1?=
 =?utf-8?B?OGl0YW1QeXlBQUxYaXFkT3REQkNTN2VZQTl5eFdsV0p2dTNGSlZObzJjWXp5?=
 =?utf-8?B?M1QvbG5EQVlvbEdHeFBPVmtDbXJ6QTBoRnduUE5aQS9TRXJBeDVJblBaTklF?=
 =?utf-8?B?VkpZcUVCTGpITGl0YU5uR0c3ZjFJUklINmdOWnNTWHgvVTI3UEkxQ1p0b0Rv?=
 =?utf-8?B?QTRmNHdTWG5KMUlVanlhbTB5c0ZuTmVRU0lrSHJlUzRaZXBtUktFUWkxOVo3?=
 =?utf-8?B?Zm1xdzZDdVo0VG1WS3hJUGFuRDN1VWxaT0ttd2tlZ0tWSnZvczhwT2V1S3Ra?=
 =?utf-8?B?YmlIWGtqMzY5Rk5ocHliUmczUFFpU2lBa3ZHc3NvdVFHMWFmOE02Y0pRL0t4?=
 =?utf-8?B?b01ZNFE5S05DZ2orYkU5M3Z5UFl4L05ZbEtyUU9DbmhZNXVZbHBxR2s2cjhz?=
 =?utf-8?B?dEI3WjJGZCtzeFAyL21hWTRYM0pDQnQxU3RVQkZTeUtXdGxIZ2lnSkpEckhG?=
 =?utf-8?B?K3ZIOGV2dFhEc2dGSldOZ3pWd2RiQ2ZpUzVJZ0hZUVkxaEZOM25WZFFHeG1v?=
 =?utf-8?B?TXdRTVllem5jQnFnSS95QmJyRURKZWR2WnR2UGlGRzlxRFFFN1ZsZFMxRVRx?=
 =?utf-8?B?aWV4cFU5dkpzeFpSWENabEtJaFkvWVFhekVmOEIwQ3VKdzVYaXB6SnV1WHAv?=
 =?utf-8?B?aHJIV1Qzc2NvMTBBOEFKTVNJQ0d6R1JyNEVBWHgzNGlkSDFBMGhxVzBnVWR2?=
 =?utf-8?B?L2FSaEhvQUF5NjZ2ZEN1b296bE5vODBzVEYwam1vRVZvc1k5bFNrK3lmdjlH?=
 =?utf-8?B?dElFb0dUc2JyR2V5RXM4MGV1ZnR6N3IyMzdJUWlwRjIxNEtERkxVLzdQaGpC?=
 =?utf-8?B?Y3dGQXJWdE1vbkNMek8vbnNvd2g5NWxCb2w1ZEFhNWtiYTREbXorNEZ3R0Mv?=
 =?utf-8?B?cGkvZnBNc01ycXJGTGh5RlJwM1hUeWJsN3lESVluOTduZ2JoZUFJMjUvYlN5?=
 =?utf-8?B?VEZHQlN0Rk54eWlkRENsVzNmeC94aCtYNUVPY0tvbThuMm9SaGdNdlUvRzlJ?=
 =?utf-8?B?ZEllOUhpd1UrU0F2MnB6bjlNaEc0LzFxNnZHc0ZpTTNvakU1cER3MU5EbXlR?=
 =?utf-8?B?eURuVDMwVkZKUytUazlMMmxqaDlDbitzUEhuVUtHRjFnb0g2OTg3bFRUV1Zw?=
 =?utf-8?B?L1QxWlBKR2FmbkZ0REhrb1p2aEsrcE1VSlJXOU9rOUtGYU1iTDR2M05Dd1FQ?=
 =?utf-8?B?dWtOcGpJbkR2aE9FTzFkaXZWdlMzWlBxM2FtRmF1cm9QSVdtMUhkV1JyOU4r?=
 =?utf-8?B?MjhrY1V0QVJKSEFkVnMrWUhOajJteVVIY3JVL0ZQejByR2Q4Z20vWFdGZWdC?=
 =?utf-8?B?RExUeURxL2prNnh4bXJ2U3AwRXJGak0zdGorNFR1RWpCNEgzckxYb1ZuNzBZ?=
 =?utf-8?B?aFRZYm1Ha2d4N3VKYzNYK2J4ZlBIM1pVeG9NZ0MzQ296YTZjY3lPU1FZTFZk?=
 =?utf-8?B?Z01ONUNyYzJVTnN2cm9TcDNKWWxyUWZYclAxcXR3eW1TdE4wMjRkSWlBOElm?=
 =?utf-8?B?QWZnTlZvOHV2VzRUSG9kWU1acWQ4UnVCdXQvb0crNXlJbVpFUXBNUW5jMTU4?=
 =?utf-8?B?ZGdUanY2QzF1akpRT3NBbENiNEVTSW1xT2dHNXByZ1JMK0hBZ2p1b3A5OGlT?=
 =?utf-8?B?dlJ0MVJuaWpwY0VoMGxLVkNhUGllVzlmK0YwOUhjZ0w2eXorQmJaY1ZXTTlj?=
 =?utf-8?B?UXRPTXVHWnRoa0RlWlM0c3lzeEFYaTdNQW1XS0dScHhIVmxabWhtNHNvc3Nu?=
 =?utf-8?B?LytOV29UdER1YlJOSHJnUW5rbFpRa1ZYT3pWQlZLNzJXV0lQUmZNM2RRQy9R?=
 =?utf-8?B?RzYzZVBsTGFYLzZvVUZLQmRMK2M2ZCtiVEFvN1ZpVzE1aXdYbmQwdmlTR1Bk?=
 =?utf-8?Q?bQQNSTe6FYx6LysA=3D?=
X-Exchange-RoutingPolicyChecked: C4yOn5iWEiA9XCXmtmB9DXMVqhjwSWraK/Bv2amThE9Ywuzlhp2IFsG0loiIgPGmd4tFidSDyxgnSaKtyqvDBj9Z/YSHS4s0HkvmJ25Ld6McAtI0ts5E8jJY+eBjXCg16UnSIQWQ0bRi5vtMPAo74Z1Ub0VRplxlcoNbQukYHT+1fBES6FVd44fVSypIE6iZJiiqwPJ6Xxf2NpcACrrn5Iq9R1irAAAPm3UY+393euoW0iZ6reBtFVD/NvfzAdPCLXojRbvfYZZheBT5zyw/DkKGDeM6vLfyYvO09dxihCQ/0H5nBTG6HyiOEQLGrRxie+D5bomSSA10tBKVf8QLsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e5b55d-6176-45f5-ae83-08de7eded395
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 19:54:23.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0n4ApSL/NMyXo1u1u730Numr8ORJeoUwuwkHD5STFEfeFw7dkV2TMk6ZIXEqBsnCC5icRY6lgqjNrMHWMwDkjvej57EhhlPHgkLoFfOD2iU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-OriginatorOrg: intel.com

Li Ming wrote:
> cxl_dpa_to_region() will require callers holding the given CXL memdev
> lock for endpoint validity checking in the following patch.

So, the justification for this is not that cxl_dpa_to_region() is going
to start enforcing lock holding, it is that cxl_dpa_to_region() has
expectations that ->endpoint remains valid for the duration of the call.

> To prepare
> it, region poison injection/clearing debugfs interfaces need to ensure
> the correct CXL memdev lock is held at the beginning.

My RFC [1] suggestion was "if there is a problem, here is locking
changes to fix it". That "if there is a problem" is what needed more thought
and time. Before we act on that RFC I want to see some plausible
analysis of how not holding this lock can cause a failure in theory
(better in practice), or how it makes the code hard to reason about.

In other words the justification is not "future patch adds a lockdep
assert so all code paths need to get more complicated". The
justification is identifying a theoretical race window and how the
locking solves it, and how the previous fix [2] did not handle all the
potential races.

[1]: http://lore.kernel.org/69813ac070f79_55fa1005c@dwillia2-mobl4.notmuch
[2]: 0066688dbcdc cxl/port: Hold port host lock during dport adding.
