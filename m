Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906736B93D
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759812; cv=fail; b=bSB35Ygg17yL5/JK2Nn0AOun6VkvtKK53ZMu59mMn0q3J8ezVYTsUFxBDQrLkpJ7YMR3Syhy7NpgqEoPotNl7V9bnh0bsAw6tRzgfcrLv5QV925/q3DMIcu+nW5wa2XcGKqvVJPvv3c4wYUTyDCSVNQBZMQJW7Rw9iB7EvR/aU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759812; c=relaxed/simple;
	bh=3TuMXVDcawM1Ln1blMPNe/ECULDbj+GN9LVrc5lEHC4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=okkg8ABW0D5tgtEBt5jMH1nlowKd+PErI74ms8VV9Vi4w2QSYEYZHQ85lJtkAwZ82YI5pbcOtKT5c+6sKKGy3NuK4fJ5plBO3U5Z6j7rXtjzqV1zN+yQATCmWGzGqSIYWjsPnFt5Sf+06hR4Du08wiBf8NgSfBGow9Knq1NfBRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S18AswvG; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S18AswvG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789759809; x=1821295809;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3TuMXVDcawM1Ln1blMPNe/ECULDbj+GN9LVrc5lEHC4=;
  b=S18AswvG58GURAnTDLyHK3yb6aulYJwcNalbBDs/u3hEpQO9j7N+X+2O
   lNHklmBNArNhRrpI/GPi2g3Fc/N3DQNxR3WS0w5yO2N+qWf68wXqrMBgi
   anho/Gq75XzvrptNHxcRpifXCUaIg70gjLthrci+yWwwdSaeKIF1qEtee
   OiYfuq4fwZc9ilFMpKdLQYTNGB5NtRuHShmp18A8F3NLYvTXZY/1Fj7uu
   3yP4PBxAzylarHlFK+HMgX4rIDeGjc5H++J/eSIlCIvH81NK1ZyEIL1vN
   v6z+hgnkbJgCRUaq141cAvvcIWQJkU+ag6VoTdNr5ZLoZgYpg2KgrXDyK
   w==;
X-CSE-ConnectionGUID: V6cj0LL5S5ezJR3C7zabWQ==
X-CSE-MsgGUID: WEgvq8l3Remxg8WSpu5jYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="101638502"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101638502"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:30:08 -0700
X-CSE-ConnectionGUID: SidS1N9dR0eF8jQj5i13vg==
X-CSE-MsgGUID: L+HYWtynQya2bphDvG8ZsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270835970"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:30:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 12:30:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 12:30:07 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 12:30:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGnm8TmmhPSJU7FRaid5Coqho1SRH/hYWTTqDC0vO7cUjHBHKNFYfGOcXdQ7JvWPRl+3ssNTA5NM8C61591THvWRVDIAD0OJzvFRnYtyTHDhpYAKZ5L1F6ppjBpkTXp8Odk11nBP0zneWSjF6DNlkS+xL0OWo5gwpC1VyhGwz5q/NngZrVViat5bFYhqa/h7CKWd5cGXid0B/DHd7dAbel4iDDR/y68gVlFAzmRxfKq4gV+ge3yvCMKqaSjUi4da90wfgvkACDcFHr2UNoo3kROsHaMEbAW8pndaWsIQ6L6pf31dmeOSVTJlRGyfykIkC+TPZ1HE+0pyZK0L5F4ztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZjZGdOiIQEekmBbhFB0HVJoqm5Qa4fCjEj3mU+Zm+0=;
 b=RunIoenekHNNcXKHxNVbuP9XTbBA9ivr3r5FifoZSvGC0T66JyjoP2gE8LiZ/QDtXfSt9/ZkK1IQswMndTyB0dqq9CNPbR404vKDVaxeqJwSeb+LwFkQED33ganwjsm0aHiEdQnqz3iJyM0HXvFAmrQ9ZkdzIt+4hknHD5S6aJCM85WRKYvPui/dbJJBEcXhoaNS0GrjPyPzmo5M+A2hJCfWgx2yCvTCbWZmpkRiRuc9A3k6nJAFaMBvEmKsPO87Yv/9ZL/vBd3GFDaoSAKu+D69O69VoFg7vPKYQkNtwSiQw0J8mQYXFUf+oWFcs7ZrxcWaWUI1XYf2K/ois+hSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6957.namprd11.prod.outlook.com (2603:10b6:303:22a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Fri, 18 Sep
 2026 19:30:05 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 19:30:05 +0000
Date: Fri, 18 Sep 2026 12:30:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>, <linux-cxl@vger.kernel.org>,
	<driver-core@lists.linux.dev>
Subject: Re: [PATCH v4 2/2] cxl/memdev: Fix deadlock between poison debugfs
 and cxl_mem unbind
Message-ID: <aq2ROFJl-PHXIKL5@aschofie-mobl2.lan>
References: <20260916025453.3532614-1-kanie@linux.alibaba.com>
 <20260916025453.3532614-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260916025453.3532614-3-kanie@linux.alibaba.com>
X-ClientProxiedBy: SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfe315c-8547-481c-c315-08df15bb3dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099006|4143699003|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: BxQmxd1nVSmTTZW+ahR9i7n+MpKWmQGaGembFLhLnjTlBRDymozvICIN8sd4Wzjt9Ehnk7xmz9cZTmhz6uYTR7LPKL4p356JoLZbPYKk9RHJs5msaJr5XAAn/4wQuF0dlbMZhzoldoBWFkFasPGsN8yi6hFWSprDzwxWz56liVlty13QUBJI33v3FMiFlQTOPFu3QCJDiBDJDxx1DdSJJpOmBdm3EBu/oMNxbq8tLHry9tCJwjhN34A6dMhGdzhhx2fccqjJuvDqX/7r0b1K+/0yIm2IVK5IwPTr3ywVkoGRj+8aFmx0jYgUQ2spTxKxJTQecn8ww+UJX4QMuxFHBSX6HKYXkwiRklmKjTIVqNu5o1R+I7vZdsKXuaPO0wLAxzZv7go8Hyn079KvXcPsLwalwY2n7gpufCq4QuXyrC2o+ckA/jpIM3qvmfdIn9EduS1flOOd3iF+lR/6RSOfD9G513srffM63HuQjzJsTV6aJAK3gB76/lpt+NEypl7G2ytGZthP16iAKgKAPxvYMhDvk8nf01yC/NF6wtwcUD9+gq2FEfYAmlJ2YuE+aWfYyt1A+Om4U/3kaQCXgHwXIHy8xCf25AGXgEfTv6wX37v8YIlb2v7SWATZ/GWGZ7iPZJFKtyS5aQIGXu+a8OKy1qKrmRX04hsWzNMckYbMLEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATbsOzMbjctfnZejwMfkMxPVQk8IubroKOrjXDgTxghQ9hhRLuGiNlKS8RmI?=
 =?us-ascii?Q?sZnudbQMuwLoWJ8xYAxooVitpbeoMkwPSHVo52N6Vqx+wgeLRjdr8DnKkJ5o?=
 =?us-ascii?Q?t/e1DuxK8egGV8IfaZH/I6FPQYXU4C3lku+AwzepAjcgPGyNw0Veco1EWASw?=
 =?us-ascii?Q?EStx2nh2EKTq+gVO9ZbeTtDxn3JgroloWZ0FPEuZ+dptadpZJ1HPPD+gtN/8?=
 =?us-ascii?Q?ucBn9tQNSvudQ2yCxgHYGwK9C2ICc4JeEoVUY1Xvu5gTwyCt9anxgyRBO1I7?=
 =?us-ascii?Q?kpaf9PdJpTHwPRhpUXBEeMkoy6gYzfW6dmN5bXKU8IoOYbFoAzB6zchZ+4sN?=
 =?us-ascii?Q?et/P0CdGPikmrotTI1q1l9ifxrTynCHQJSWzBlCY9MBT87XtXofyqN2fWpF0?=
 =?us-ascii?Q?FcOYIyYZNUeGT/Z/oE38KdTq5qLCam02O14WVxmVlRvHl0dCQIx1Uqj2YtNB?=
 =?us-ascii?Q?8H5fzK5TWbzHRgdZBo7Kh6pOu9rg3nXEC/QKbxmoTielqMa8s63dHpVUyte5?=
 =?us-ascii?Q?gp0dGQHpujAiherDfuBVPqidq8f6ZJcGO4MtOunXfCWigLpcRwjDCbZOmGs1?=
 =?us-ascii?Q?YlKJd6zkGzSRqw+CzJIxS0xfmgyMV+mpFy1yTUGYZPDPu0J5kLpcJWXeR/2/?=
 =?us-ascii?Q?NhwnnBa7K+ziMD4yq1D3k1+1UoNIPMCV+b9MkLi7G04OROp4EwqWzaGdEZ8i?=
 =?us-ascii?Q?voITfPlKVJeesAHquYbqRlie5AIHwz9tlqnqsBy+EMZHpgsPBRAdGg+yiSFm?=
 =?us-ascii?Q?WlNbA/OzSB8qSLwXy+iVczz89dWen3JmErUjBad3awuJEDRt/oOOXT1QZVZt?=
 =?us-ascii?Q?Bj11vRrb0fQzeHAColmRW3ATbzZdF0kz+9prRcgQ6n5gj/X1xFj5qMcsd3TN?=
 =?us-ascii?Q?/TuTucNRyr9g8LoXl3vvXW0ol2QN2YxEzxx+YiIkNn4d9Rp35wEqsfscrpbJ?=
 =?us-ascii?Q?xLn+UofF7Q5TQrG5FS1StVO1FFRfHrTOY2KFIDGJk9ZYwFLZgXxAse3rNEYZ?=
 =?us-ascii?Q?GV+K4xmI+iYynKbMqy3bZ8XE+JKSqULZDceW/Ajf/stHQi4diUH1KBZHsewF?=
 =?us-ascii?Q?us7gaa0eXda6QTSV2ZFB/ejNKq1DzgNRSq/hANtVN0O6/S/Yp0GWbGa0KW1O?=
 =?us-ascii?Q?kCPutLmI055GqJeB7sO5wIroCo1TngqdCneFepESSoJFhXKXYNjuTNUyyjES?=
 =?us-ascii?Q?j0kEjKEJMrOE0dMD6+GTB5hVegwnJkyB73m9viCA9ENI3ga9iB/qljMJCvTa?=
 =?us-ascii?Q?Ei+NzYch26aas2CRROxlmMAbocP0g7JYb1nUwk4hnsoZGyE1lW4F28/Ou6mk?=
 =?us-ascii?Q?R1nCzSpzXfcKjM5A7mpjICZrCZFz8SB8CeKYOfb8kZnTbqvZldDR0U1pT1O8?=
 =?us-ascii?Q?Z2YksKwpReJZzFwi5hF/sTQtyGr7OO180wYJXCleFWLoJaMCRMMfMFp/KzOd?=
 =?us-ascii?Q?eLCvZKkseoyuCY//emMPJuA43S2v7WsZQZcBisZhihoFmoO2YtPaxheIs/Nh?=
 =?us-ascii?Q?SaTpTVE8ITrgkyY201liX2CGnYESRThGc661YinumdbdtB0ZDjZVlFhgYf7r?=
 =?us-ascii?Q?m4up9pgt/C4ChucfUIZDsk2H17mo6nhx3iWnnuA1YiW/S2nPoVItntFGW6Ct?=
 =?us-ascii?Q?ahJy5CQZevhRRxbz5dEzkUSXE30Q7PXZYEvCJ9opDHrViaoN3QWtAf4H9t7u?=
 =?us-ascii?Q?+sqCz1GLq6Lep05OWt3ysptw3yHTIPzXd94U2MK2S3EOmPb39rLOsYMNdtbq?=
 =?us-ascii?Q?JMOtlmBYWDnhRk24hB/OYAsKNaPsCyI=3D?=
X-Exchange-RoutingPolicyChecked: mNUY2uw+efhsSViOGzQX91BjYECW8NHcvSikKJhSxFTEULArv92Hv6qWdFs92vZBmyRii4E1mtyCfXPqf0GlJta3Ykp9Ro+n7kc0ujyUWgaRQ4d6wIvwiQNkYDPgqS6ygqCXLWcDJgD50FSfDO/6MzX3bPY2V1CWBrmf9A/n6DuWJez4mKRwb8On3eZekADiXxYJ1RiwmX9o8X/EK2gkl2N/TuP0Fad0BtMsbjQKgRF1XWgy6e1Dxm0y681iKQgxRGnDY2eVaXixY0AdtubkXQKqSzC8U5RJip6C05ajTqbbK3Yw3OMIW94hWUm5prjQ4uJEcTCuWZFFJw6l0C/QZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfe315c-8547-481c-c315-08df15bb3dc0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 19:30:05.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkJ+p/3oTF73s9aFwqVwi+5LFpOfbZCQbq+3W7riZ0cky4YIwEy224Y9OdNJxzkDzbsFHDqqneCgzn961/6JvrW3CB0uI/1jH9ibiH4G6Lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6957
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 10:54:53AM +0800, Guixin Liu wrote:
> The poison debugfs handlers take the memdev device lock so that the
> region lookup sees a stable cxlmd->dev.driver. debugfs holds a
> reference on the file across the handler, and cxl_mem unbind removes
> that file while holding the very same device lock, so a handler that
> waits for the lock deadlocks against a concurrent unbind.
> 
> The trigger is any teardown that detaches cxl_mem from the memdev
> while a poison write is in flight: unbinding or unloading cxl_mem or
> cxl_pci, or removing the endpoint PCI device, including hot-remove.
> 
> Both tasks then hang. The unbind side is uninterruptible, and it also
> blocks the memdev detach work, which runs on an ordered workqueue and so
> stalls every other CXL bus work item.
> 
> Take the lock with the trylock guard and return -EBUSY instead of
> waiting. An unbind that wins the race removes the file first and the
> write fails with -ENOENT.
> 
> The poison inject and clear files are a debug ABI for expert users,
> mostly device vendors, to test the poison capabilities of their
> devices. Mixing a poison write with cxl_mem teardown is not a supported
> use of the interface, but when it happens anyway the cost should be a
> failed write, not a hung kernel.
> 
> Found by code inspection. Reproduced by writing inject_poison in a loop
> while unbinding and rebinding cxl_mem, and confirmed fixed by the same
> test. Also reproduced the same deadlock with those writes racing a
> pciehp hot-remove of the memdev; with this patch the hot-remove flow
> completes normally.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

