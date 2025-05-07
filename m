Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424C220F42;
	Wed,  7 May 2025 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602614; cv=fail; b=N6Jg8ZyKtGUq2On0iXHiEpJfGb9C3x1K8yfPCdOgEB2YQMEXAkBGvMqbS5mNzQ4OfC78mrUn/RuDg2ZoFhU/bYT9VHUDgiGk8du9pgoLng2yWgH/PLe50an8aBnWb+IuAwebikimEtpV/qoKPJMXy6kfNIGefUHhquROllgS+Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602614; c=relaxed/simple;
	bh=ytZHjCzqtxH1i/fodeugmEE/xMOFd7vXEf1twjVsa2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WLBrFMOfpysuMeNlhgbNeQ3jDmkGnmp525nMw+d7jZIFEbaC+SzXJPU1i9xIwiGQkjJVBnfpN5BuUPCSFLRD4YPFe4JvOe++chE+frENhhof6AaSzfRAoZHzVEB072k368f5sv67NIALnQ5304zc2IIZ4BC7uM+ho7zGEtGpPX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyVjGura; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyVjGura"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746602611; x=1778138611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ytZHjCzqtxH1i/fodeugmEE/xMOFd7vXEf1twjVsa2c=;
  b=kyVjGuraZCCY9BocgmJtYRMI/Il02mY2/8m+dQse95k34KWW4g0vydu9
   eN8i6vaAcXsiDeHUUYIygiOGOJ4RtlCRL670DPfudSK1EfMWlUrbyf1J8
   mUE9ZOepqH6q4jvf/pTRj/fn+HXatHCiOAP1fE3+ksdAFpptjE/Lz65qG
   JpCU4tH+qSti3a8hnccwDOFa879E8hYBQxWIsdVFgpIbIfPagbZ6ShHRs
   LF3wAyx4QlwYfJrjkOk6fhdSmhwGRMF6j8DE5eMnRbZLM1MXBmNdpEkYu
   XzucW+Qw1t9Pl/f7ojRpDw95eLntGcvISH0NhKFE+afuVkZJ8vl4QtneE
   A==;
X-CSE-ConnectionGUID: yJTs94d0TFa5+w58xiO4sA==
X-CSE-MsgGUID: CmwZ1tbvTT2wodzFRCTfPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47564254"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="47564254"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:28 -0700
X-CSE-ConnectionGUID: G1zdc9u+SNy0NClTONGM1Q==
X-CSE-MsgGUID: ubOBQUxGQUCejAu+fD+qIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="140985000"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:23:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 00:23:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 00:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCASi6wNR1E0XYBGDAiggKePzfmyL7G7pSp76C7k1C0LSToCcqBkFrWcs9OQLALbDr83FAI3y3Q+0NT6UyFZwOCSR30U8KS3kXFuhAhLKUG5hg8IdyhTsw95HvLoRF40XnvKJfglLIrAVq+nVsYxnKdepw7OHbAEN4zB5n3E/U3qYwn5hH3jBVJwAoAL5ELLytVMORKvk3u4ODv237W9jbMxO9RlyC+5KYozCoia7GrhtBrg8+Mll87Za/MhbNWLK0KvdckawOiKjb5BU7ltWBYazB7AtdtdBAr048lKJPiogce/MAOBI2vfMjtiM7/jQHlHfnI8RFsP26bPcx4GRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWdAX/GAwvuCibtDPSsvdl9HLosHKU61cN9RY0+NgHM=;
 b=i9vtJ1L2j7wXf7pLxJcWAD3vdxTipXJWvRtnj+rF5/ZAS2izXkBrG9znWryjw9r4bOUaw8gvx3mh11vU6JmEwJjxTQo5pLYnsCmadPpLoowttyQKIzh0nSJZtfYwIJN2r1QWq6fqKEVJ9NRzYSBMyxjKT/YXDU+71jPNL6UcfVj50btfNSEQjq5psbuRA9ksT6RXOf1dJ/yA+wKW4gpul8JkCvjwXVMTc4ySphH5RX/1qJTXeq1muBq9ADHp85LIt7UKol7Sl371L3W3E8Qgf+7QX6J9JX8AANrxJcbwRzGSfBRGvZ2bLcu/jyeNtfRPN2rrCQLqc9KuR9qGVK6a8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 7 May
 2025 07:21:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:21:55 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Fabio M. De
 Francesco" <fabio.maria.de.francesco@linux.intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 7/7] cleanup: Create an rwsem conditional acquisition class
Date: Wed, 7 May 2025 00:21:45 -0700
Message-ID: <20250507072145.3614298-8-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507072145.3614298-1-dan.j.williams@intel.com>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: a88a03eb-0fd5-4213-a410-08dd8d37d8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N9t08Whvu02l6TEWHTn8sCg/DdVdu8Ez1paBt/VH5YgmjhvIne+txvdPHIvT?=
 =?us-ascii?Q?Cl05MJcg27OucsFrIOHZKXS33gfQ2m7MyLWU8M3lmlP6uQiz9x5ywhGi/Imm?=
 =?us-ascii?Q?FWtX0OKh+ao8GVx4VUg51R8U/SN787kDLGFaImzegHp3de/Bc9+tSp27iDIB?=
 =?us-ascii?Q?Hbbblkw/v5UnF9B3xzLPaZfs4Vu2LhbpXLlGB042LP7U4UUn7HxREjxmFUy5?=
 =?us-ascii?Q?Xd3UW3SMrUYt+yjJ0XmpiwN8f9JvXb+POPYgDDR4yZDttr/0lLQhE7WhDN0K?=
 =?us-ascii?Q?5Cg6/lpPket/HsIUE0RzZ2zVw6GjrkfNFGFFFvYUPICS85my0jfqFTywGQqs?=
 =?us-ascii?Q?GjsZaNrfEl01fnhW9whbwz0CcC+YVzWjNIHPKNBxboRu0hE5ULu7GWdKpFuo?=
 =?us-ascii?Q?Dygj7wJM3E2g/J5ZFt5gcqKlIJNKTQfg6uz1eNih9fKeMI6fz4FyDVh5hsRh?=
 =?us-ascii?Q?WqfOOmruiU5nn+gRrKPfHU+iWArWijkBFb502YH6de/Q8elUP6PhY4f/DE/O?=
 =?us-ascii?Q?Htx6s0VOjaRWaK3h7Kwr8kR0e/1pPnAiundj+jX/pz3qnrmRH59oe8oNIFBx?=
 =?us-ascii?Q?QiRFFHKJEfzBGCbpIwmnwvS1Q+ixpIvBcWj8ZqyKMWZn9AxRnx6I81XZk4hG?=
 =?us-ascii?Q?boNGpnsEcHSPstgd8IYWqrTk5K3wyD/nC6Pk1GhIH85E4p5Yljk9DgQIu5ib?=
 =?us-ascii?Q?0QOu2NuX1M0RQBS4Yz0sSsIg/xJXzIqBg2rnFTAheIFtDMFovMeiTwj+KJOi?=
 =?us-ascii?Q?/5Uq3OElMDLF1B8DYggKRuUj4vs8Av5qY1B0lVj7J5INed2iCHQV4BFByMdP?=
 =?us-ascii?Q?JSoY3lTrQ/UnwmZcOHGhiEJpiEPBMFSG5f4xCwPQPTS96hFAgiPohx8ZoOXa?=
 =?us-ascii?Q?ebmUaHhuD5b8OH63Q+bhMNvBO+7RAIH8yO9jIc4/WwKK7ZAWn0jIkTZoDuMo?=
 =?us-ascii?Q?g2DP8/IFeQEYWcZeMRJQLLZRpk0Sx+EmXaIif6aqIbdWOLiei/nbI/cbhqi7?=
 =?us-ascii?Q?JgkuZlktmKBZBtVDQ0HjCUjGe1YuUSUmbvZf/sDbdsuh0my/3nXhcFib/6xt?=
 =?us-ascii?Q?hkYy90ZkJE4z2O32phes4hCh2GVd9pMercc1yOEdtKebWN6IqSup5aCSD0L2?=
 =?us-ascii?Q?ccbx/vyna2EMOAa+pt1ZDSeHxrX1vvi36Q96488BxuXKRdFlLuL8XkJocpMr?=
 =?us-ascii?Q?sHfwU9iXGXNXBluAEIPTgpCOh17o/jjhxYZ33ySMH9pZ4Pg3tH8C4uP+aokR?=
 =?us-ascii?Q?iPft0tsPqbLlyiD3DoHldrNxRfx5X65YnAX4k4lI3/orCzCeGAcgBk8IBm11?=
 =?us-ascii?Q?0sm7MR6W+OdOLTH3nymRTrXyDl9oGRl21ktMxzKSxUTU/sPNtdddFSP/KNok?=
 =?us-ascii?Q?q1pWjnVMxwBWDCL26bgc6fdl3iip6RtzrCwZ5dVbnjQi642TmbUR9AKcycEw?=
 =?us-ascii?Q?zggAEttlfEU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H/z/klBRtPOV3ceENODF0MYGv87HLh7FJ4ExkELe2/XqIq1m+zRiEYGl+jXX?=
 =?us-ascii?Q?zrDNBXf3XE9LgAsM/53TkfVrMxU4Skk2fsnHtZSfNC2BnZGHZHpcmc3ettd9?=
 =?us-ascii?Q?NKVoq2yL1D5iuf0975oO8Pkf6x7wASBHEB0Hyyxw8ffKAuHKQ0DI8g9EhX0A?=
 =?us-ascii?Q?VtkLyjtNkOKAiMsrYsLzNdJcvejxgwoMSCh7nHN/jJlFE7zQvmyw1qNH7oD2?=
 =?us-ascii?Q?YrObXp58dI5SrSLC4G5c93YakAlL9ydbDqnW5Tbfd5YNkoGaDMR/16CnCn2y?=
 =?us-ascii?Q?F5LOAI/1TihDWXruWZkUJQE7rY/haFHgEMYaG1gXlfcKiNcSdorVaOqYr9OA?=
 =?us-ascii?Q?fLAKSu7xAy2/4cTKes5LqlSTBm0SoCbUKBTyd2ZdCfX3W6uEO7/avheKdOj9?=
 =?us-ascii?Q?S1VA9+MGeGZO6Y973P8DEGJp7254V9HgytzjNCjwkU4hAeVZuROy1j3JbZJe?=
 =?us-ascii?Q?o1k6Gqc0szi5lWLZSm146e4eBcTmHXXcfrYnuMcNz+jdKNQuYrEIMMW1uz0S?=
 =?us-ascii?Q?RJJpEW7ycwHPtK/WA4aXjUjlB7PzFNkmhySaffkU5X2qeRGgttG9wwTYLoAY?=
 =?us-ascii?Q?zNIqRJl9gpcPvidMzc4LY6oqEwnQeSnFLfipWyubcbOAqu4m9TFsB7rWPAA8?=
 =?us-ascii?Q?mXDTIFKnwnIpF7OFpxxDPEtopD/3s7dEWJN/AecPBI0N1rnKcSWWbY/n8ETW?=
 =?us-ascii?Q?xYJSVh+98f9/429e8NgIiir+3jQjtDIx+toNyBTsRJ9YB8GUMRjiqTZN+PCH?=
 =?us-ascii?Q?wnyTY6Mfwv/CFliZH2aNkYsk757K20VKqFCnkIX8VkhmkhbZSJJbSHpT1n5v?=
 =?us-ascii?Q?/q4tdRhwCIG9CbuVAr8IH1ZJi64mN/+ZgVu0qgalZJLTySeLYJTpXexviCVY?=
 =?us-ascii?Q?/m/E2B0+LFi6/OMeQ+IsoAeMUwIKGLWtA9BHmwkkxILElSfHurEPTPg0eGMn?=
 =?us-ascii?Q?lS8y1nxg5gcyqu3rtxUD5bu5oAOJdRvXx36jXUlIh3eb5I2ueOqDcoqjZcoJ?=
 =?us-ascii?Q?jUaO9Ch9nOrb7I6U3n4ikSu8H6wgmQcEtls9z/aBdyK3BWGdOHuah38CGhpB?=
 =?us-ascii?Q?W4rsT0C1ulQHeW5UJGX7ORb2C7wMyPlRcvSrM05CiZFATs3+L1FUV8snFn9k?=
 =?us-ascii?Q?6H7w36nNIN+EzQ+8Y6ZAvKT73JQyHcZNz67tbg7bBV/ghqUMnwvZ8E9D7mon?=
 =?us-ascii?Q?t6hYaN+CmHhFBQ5DX5JngKhVnorj8SQsAn+1oqToSSNe6gCLOUB68OWu46Ec?=
 =?us-ascii?Q?0XaadRx5aA9FbXp0hsaI7/jZp0Vgjh73H4UmT8T/whJ6Iag2RLkr/18PCiSj?=
 =?us-ascii?Q?Y2Qkz0AIRpRM/ge2M5J4Pe/32Vu+GASlY3ZaVvDEKJUbwSYvmbCLDnaNLm4M?=
 =?us-ascii?Q?dp8EJIZFYYW/hknogpdRGBD2lIE7h7n5v+IAphb+vkbNziEWnTAUcrKRA02U?=
 =?us-ascii?Q?3g+SgIsANfpcIFDldIGwgUZq7HyMDYNr48b/zlW+YzyuhcP2VM7E8Hzs0Bwt?=
 =?us-ascii?Q?2iJoZ46KLDWqhDeI4rWiBX0bIyCK/LKM8HugNcBYNk00mA4ugcSA5K1KLLEd?=
 =?us-ascii?Q?/lzcqvamAgcr2Dnbuq8qFFvl+5bCPpAYzZx/5vFo1iXeDIjn+GTmJruY4zcW?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a88a03eb-0fd5-4213-a410-08dd8d37d8b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:21:55.7100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: te49GCt6SaNucNaGhts2jC1tQBjtwMqwa/CqOKrD217TavBjv7piEP2Hg21nZXWUJE9ywwWpyUdu3uo18YBQCiaa39GEktHOL09PqLXSPkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com

Introduce 'struct rw_semaphore_acquire' with the following helpers:

[scoped_]guard(rwsem_read_acquire)(...)
[scoped_]guard(rwsem_write_acquire)(...)
CLASS(rwsem_read_intr_acquire, ...)
CLASS(rwsem_write_kill_acquire, ...)
CLASS(rwsem_read_try_acquire, ...)
CLASS(rwsem_write_try_acquire, ...)

...and convert the CXL 'struct rw_semaphore' instances to 'struct
rw_semaphore_acquire'.

Recall that the "_acquire" flavor of locking primitives do not support
explicit 'lock' and 'unlock' operations, only guard() and CLASS(). This
mandates some pre-work before this mechanism can be adopted in a subsystem.
Specifically, some explicit unlock patterns in the CXL subsystem
(mid-function unlock and "reverse" locking patterns) were refactored into
sequences that are amenable to scope-based unlock.

The result is easier to read (once CLASS() semantics are understood)
smaller code that avoids the re-indentation implied by scoped_cond_guard().

One nit though is that 'struct rw_semaphore_acquire' is not compatible with
lockdep APIs. So, for now, open-code the type-conversion back to the raw
'struct rw_semaphore'.

Cc: David Lechner <dlechner@baylibre.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/cdat.c   |   6 +-
 drivers/cxl/core/core.h   |  34 ++---
 drivers/cxl/core/hdm.c    |  38 +++--
 drivers/cxl/core/mbox.c   |   6 +-
 drivers/cxl/core/memdev.c |  62 ++++-----
 drivers/cxl/core/port.c   |  12 +-
 drivers/cxl/core/region.c | 286 +++++++++++++++-----------------------
 include/linux/rwsem.h     |  37 +++++
 8 files changed, 219 insertions(+), 262 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index edb4f41eeacc..dadfcf6fb84c 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -336,7 +336,7 @@ static int match_cxlrd_hb(struct device *dev, void *data)
 	cxlrd = to_cxl_root_decoder(dev);
 	cxlsd = &cxlrd->cxlsd;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read_acquire)(&cxl_region_rwsem);
 	for (int i = 0; i < cxlsd->nr_targets; i++) {
 		if (host_bridge == cxlsd->target[i]->dport_dev)
 			return 1;
@@ -987,7 +987,7 @@ void cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
 	bool is_root;
 	int rc;
 
-	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_dpa_rwsem.rw_semaphore);
 
 	struct xarray *usp_xa __free(free_perf_xa) =
 		kzalloc(sizeof(*usp_xa), GFP_KERNEL);
@@ -1057,7 +1057,7 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 {
 	struct cxl_dpa_perf *perf;
 
-	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_dpa_rwsem.rw_semaphore);
 
 	perf = cxled_get_dpa_perf(cxled);
 	if (IS_ERR(perf))
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 44b09552f44e..23afbbd650b7 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -107,8 +107,8 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 #define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
 #define PCI_CAP_EXP_SIZEOF		0x3c
 
-extern struct rw_semaphore cxl_dpa_rwsem;
-extern struct rw_semaphore cxl_region_rwsem;
+extern struct rw_semaphore_acquire cxl_dpa_rwsem;
+extern struct rw_semaphore_acquire cxl_region_rwsem;
 
 DEFINE_CLASS(
 	cxl_decoder_detach, struct cxl_region *,
@@ -117,22 +117,24 @@ DEFINE_CLASS(
 		put_device(&_T->dev);
 	},
 	({
-		int rc = 0;
-
 		/* when the decoder is being destroyed lock unconditionally */
-		if (mode == DETACH_INVALIDATE)
-			down_write(&cxl_region_rwsem);
-		else
-			rc = down_write_killable(&cxl_region_rwsem);
-
-		if (rc)
-			cxlr = ERR_PTR(rc);
-		else {
-			cxlr = cxl_decoder_detach(cxlr, cxled, pos, mode);
-			get_device(&cxlr->dev);
+		if (mode == DETACH_INVALIDATE) {
+			scoped_guard(rwsem_write_acquire, &cxl_region_rwsem) {
+				cxlr = cxl_decoder_detach(cxlr, cxled, pos,
+							  mode);
+				if (!IS_ERR_OR_NULL(cxlr))
+					get_device(&cxlr->dev);
+			}
+		} else {
+			CLASS(rwsem_write_kill_acquire, rwsem)(&cxl_region_rwsem);
+			if (IS_ERR(rwsem))
+				cxlr = ERR_CAST(rwsem);
+			else
+				cxlr = cxl_decoder_detach(cxlr, cxled, pos,
+							  mode);
+			if (!IS_ERR_OR_NULL(cxlr))
+				get_device(&cxlr->dev);
 		}
-		up_write(&cxl_region_rwsem);
-
 		cxlr;
 	}),
 	struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled, int pos,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1c195f495a59..1624f066fde5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,7 +16,7 @@
  * for enumerating these registers and capabilities.
  */
 
-DECLARE_RWSEM(cxl_dpa_rwsem);
+DECLARE_RWSEM_ACQUIRE(cxl_dpa_rwsem);
 
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			   int *target_map)
@@ -213,7 +213,7 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 {
 	struct resource *p1, *p2;
 
-	guard(rwsem_read)(&cxl_dpa_rwsem);
+	guard(rwsem_read_acquire)(&cxl_dpa_rwsem);
 	for (p1 = cxlds->dpa_res.child; p1; p1 = p1->sibling) {
 		__cxl_dpa_debug(file, p1, 0);
 		for (p2 = p1->child; p2; p2 = p2->sibling)
@@ -265,7 +265,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	struct resource *res = cxled->dpa_res;
 	resource_size_t skip_start;
 
-	lockdep_assert_held_write(&cxl_dpa_rwsem);
+	lockdep_assert_held_write(&cxl_dpa_rwsem.rw_semaphore);
 
 	/* save @skip_start, before @res is released */
 	skip_start = res->start - cxled->skip;
@@ -280,7 +280,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 
 static void cxl_dpa_release(void *cxled)
 {
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write_acquire)(&cxl_dpa_rwsem);
 	__cxl_dpa_release(cxled);
 }
 
@@ -292,7 +292,7 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
 
-	lockdep_assert_held_write(&cxl_dpa_rwsem);
+	lockdep_assert_held_write(&cxl_dpa_rwsem.rw_semaphore);
 	devm_remove_action(&port->dev, cxl_dpa_release, cxled);
 	__cxl_dpa_release(cxled);
 }
@@ -360,7 +360,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct resource *res;
 	int rc;
 
-	lockdep_assert_held_write(&cxl_dpa_rwsem);
+	lockdep_assert_held_write(&cxl_dpa_rwsem.rw_semaphore);
 
 	if (!len) {
 		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
@@ -469,7 +469,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
 {
 	struct device *dev = cxlds->dev;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write_acquire)(&cxl_dpa_rwsem);
 
 	if (cxlds->nr_partitions)
 		return -EBUSY;
@@ -515,9 +515,8 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	int rc;
 
-	down_write(&cxl_dpa_rwsem);
-	rc = __cxl_dpa_reserve(cxled, base, len, skipped);
-	up_write(&cxl_dpa_rwsem);
+	scoped_guard(rwsem_write_acquire, &cxl_dpa_rwsem)
+		rc = __cxl_dpa_reserve(cxled, base, len, skipped);
 
 	if (rc)
 		return rc;
@@ -528,7 +527,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
 
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
 {
-	guard(rwsem_read)(&cxl_dpa_rwsem);
+	guard(rwsem_read_acquire)(&cxl_dpa_rwsem);
 	if (cxled->dpa_res)
 		return resource_size(cxled->dpa_res);
 
@@ -539,7 +538,7 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 {
 	resource_size_t base = -1;
 
-	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_dpa_rwsem.rw_semaphore);
 	if (cxled->dpa_res)
 		base = cxled->dpa_res->start;
 
@@ -551,7 +550,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct device *dev = &cxled->cxld.dev;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write_acquire)(&cxl_dpa_rwsem);
 	if (!cxled->dpa_res)
 		return 0;
 	if (cxled->cxld.region) {
@@ -581,7 +580,7 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	struct device *dev = &cxled->cxld.dev;
 	int part;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write_acquire)(&cxl_dpa_rwsem);
 	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
 		return -EBUSY;
 
@@ -613,7 +612,7 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long lon
 	struct resource *p, *last;
 	int part;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write_acquire)(&cxl_dpa_rwsem);
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder attached to %s\n",
 			dev_name(&cxled->cxld.region->dev));
@@ -841,9 +840,8 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		}
 	}
 
-	down_read(&cxl_dpa_rwsem);
-	setup_hw_decoder(cxld, hdm);
-	up_read(&cxl_dpa_rwsem);
+	scoped_guard(rwsem_read_acquire, &cxl_dpa_rwsem)
+		setup_hw_decoder(cxld, hdm);
 
 	port->commit_end++;
 	rc = cxld_await_commit(hdm, cxld->id);
@@ -881,7 +879,7 @@ void cxl_port_commit_reap(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_region_rwsem.rw_semaphore);
 
 	/*
 	 * Once the highest committed decoder is disabled, free any other
@@ -1029,7 +1027,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
 
-		guard(rwsem_write)(&cxl_region_rwsem);
+		guard(rwsem_write_acquire)(&cxl_region_rwsem);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed out of order\n",
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index cec9dfb22567..9f17e9072e60 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -909,8 +909,8 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		 * translations. Take topology mutation locks and lookup
 		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
 		 */
-		guard(rwsem_read)(&cxl_region_rwsem);
-		guard(rwsem_read)(&cxl_dpa_rwsem);
+		guard(rwsem_read_acquire)(&cxl_region_rwsem);
+		guard(rwsem_read_acquire)(&cxl_dpa_rwsem);
 
 		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
@@ -1258,7 +1258,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	/* synchronize with cxl_mem_probe() and decoder write operations */
 	guard(device)(&cxlmd->dev);
 	endpoint = cxlmd->endpoint;
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read_acquire)(&cxl_region_rwsem);
 	/*
 	 * Require an endpoint to be safe otherwise the driver can not
 	 * be sure that the device is unmapped.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a16a5886d40a..8183f8099f89 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -231,15 +231,13 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	if (!port || !is_cxl_endpoint(port))
 		return -EINVAL;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_read_intr_acquire, region_rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(region_rwsem))
+		return PTR_ERR(region_rwsem);
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
-		return rc;
-	}
+	CLASS(rwsem_read_intr_acquire, dpa_rwsem)(&cxl_dpa_rwsem);
+	if (IS_ERR(dpa_rwsem))
+		return PTR_ERR(dpa_rwsem);
 
 	if (cxl_num_decoders_committed(port) == 0) {
 		/* No regions mapped to this memdev */
@@ -248,8 +246,6 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 		/* Regions mapped, collect poison by endpoint */
 		rc =  cxl_get_poison_by_endpoint(port);
 	}
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
@@ -291,19 +287,17 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_read_intr_acquire, region_rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(region_rwsem))
+		return PTR_ERR(region_rwsem);
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
-		return rc;
-	}
+	CLASS(rwsem_read_intr_acquire, dpa_rwsem)(&cxl_dpa_rwsem);
+	if (IS_ERR(dpa_rwsem))
+		return PTR_ERR(dpa_rwsem);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
+		return rc;
 
 	inject.address = cpu_to_le64(dpa);
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -313,7 +307,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	};
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -326,11 +320,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
-out:
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
 
@@ -346,19 +337,17 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_read_intr_acquire, region_rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(region_rwsem))
+		return PTR_ERR(region_rwsem);
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
-		return rc;
-	}
+	CLASS(rwsem_read_intr_acquire, dpa_rwsem)(&cxl_dpa_rwsem);
+	if (IS_ERR(dpa_rwsem))
+		return PTR_ERR(dpa_rwsem);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
+		return rc;
 
 	/*
 	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
@@ -377,7 +366,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -390,11 +379,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
-out:
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 20b65f13bded..a157aef2cd06 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -34,14 +34,14 @@
  * All changes to the interleave configuration occur with this lock held
  * for write.
  */
-DECLARE_RWSEM(cxl_region_rwsem);
+DECLARE_RWSEM_ACQUIRE(cxl_region_rwsem);
 
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
 int cxl_num_decoders_committed(struct cxl_port *port)
 {
-	lockdep_assert_held(&cxl_region_rwsem);
+	lockdep_assert_held(&cxl_region_rwsem.rw_semaphore);
 
 	return port->commit_end + 1;
 }
@@ -176,7 +176,7 @@ static ssize_t target_list_show(struct device *dev,
 	ssize_t offset;
 	int rc;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read_acquire)(&cxl_region_rwsem);
 	rc = emit_target_list(cxlsd, buf);
 	if (rc < 0)
 		return rc;
@@ -235,7 +235,7 @@ static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *at
 {
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
 
-	guard(rwsem_read)(&cxl_dpa_rwsem);
+	guard(rwsem_read_acquire)(&cxl_dpa_rwsem);
 	return sysfs_emit(buf, "%#llx\n", (u64)cxl_dpa_resource_start(cxled));
 }
 static DEVICE_ATTR_RO(dpa_resource);
@@ -560,7 +560,7 @@ static ssize_t decoders_committed_show(struct device *dev,
 {
 	struct cxl_port *port = to_cxl_port(dev);
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read_acquire)(&cxl_region_rwsem);
 	return sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
 }
 
@@ -1729,7 +1729,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 	if (xa_empty(&port->dports))
 		return -EINVAL;
 
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write_acquire)(&cxl_region_rwsem);
 	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 17e69f6cc772..65313a3548e4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -139,18 +139,13 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_read_intr_acquire, region_rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(region_rwsem))
+		return PTR_ERR(region_rwsem);
 	if (cxlr->mode != CXL_PARTMODE_PMEM)
-		rc = sysfs_emit(buf, "\n");
-	else
-		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%pUb\n", &p->uuid);
 }
 
 static int is_dup(struct device *match, void *data)
@@ -162,7 +157,7 @@ static int is_dup(struct device *match, void *data)
 	if (!is_cxl_region(match))
 		return 0;
 
-	lockdep_assert_held(&cxl_region_rwsem);
+	lockdep_assert_held(&cxl_region_rwsem.rw_semaphore);
 	cxlr = to_cxl_region(match);
 	p = &cxlr->params;
 
@@ -192,27 +187,22 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 	if (uuid_is_null(&temp))
 		return -EINVAL;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_write_kill_acquire, region_rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(region_rwsem))
+		return PTR_ERR(region_rwsem);
 
 	if (uuid_equal(&p->uuid, &temp))
-		goto out;
+		return len;
 
-	rc = -EBUSY;
 	if (p->state >= CXL_CONFIG_ACTIVE)
-		goto out;
+		return -EBUSY;
 
 	rc = bus_for_each_dev(&cxl_bus_type, NULL, &temp, is_dup);
 	if (rc < 0)
-		goto out;
+		return rc;
 
 	uuid_copy(&p->uuid, &temp);
-out:
-	up_write(&cxl_region_rwsem);
 
-	if (rc)
-		return rc;
 	return len;
 }
 static DEVICE_ATTR_RW(uuid);
@@ -353,22 +343,18 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 static int queue_reset(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	int rc;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_write_kill_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
 
 	/* Already in the requested state? */
 	if (p->state < CXL_CONFIG_COMMIT)
-		goto out;
+		return 0;
 
 	p->state = CXL_CONFIG_RESET_PENDING;
 
-out:
-	up_write(&cxl_region_rwsem);
-
-	return rc;
+	return 0;
 }
 
 static int __commit(struct cxl_region *cxlr)
@@ -376,19 +362,17 @@ static int __commit(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_write_kill_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
 
 	/* Already in the requested state? */
 	if (p->state >= CXL_CONFIG_COMMIT)
-		goto out;
+		return 0;
 
 	/* Not ready to commit? */
-	if (p->state < CXL_CONFIG_ACTIVE) {
-		rc = -ENXIO;
-		goto out;
-	}
+	if (p->state < CXL_CONFIG_ACTIVE)
+		return -ENXIO;
 
 	/*
 	 * Invalidate caches before region setup to drop any speculative
@@ -396,16 +380,15 @@ static int __commit(struct cxl_region *cxlr)
 	 */
 	rc = cxl_region_invalidate_memregion(cxlr);
 	if (rc)
-		goto out;
+		return rc;
 
 	rc = cxl_region_decode_commit(cxlr);
-	if (rc == 0)
-		p->state = CXL_CONFIG_COMMIT;
+	if (rc)
+		return rc;
 
-out:
-	up_write(&cxl_region_rwsem);
+	p->state = CXL_CONFIG_COMMIT;
 
-	return rc;
+	return 0;
 }
 
 static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
@@ -441,7 +424,7 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	 * With the reset pending take cxl_region_rwsem unconditionally
 	 * to ensure the reset gets handled before returning.
 	 */
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write_acquire)(&cxl_region_rwsem);
 
 	/*
 	 * Revalidate that the reset is still pending in case another
@@ -460,15 +443,11 @@ static ssize_t commit_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	rc = sysfs_emit(buf, "%d\n", p->state >= CXL_CONFIG_COMMIT);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	CLASS(rwsem_read_intr_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
+	return sysfs_emit(buf, "%d\n", p->state >= CXL_CONFIG_COMMIT);
 }
 static DEVICE_ATTR_RW(commit);
 
@@ -492,15 +471,11 @@ static ssize_t interleave_ways_show(struct device *dev,
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	ssize_t rc;
-
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	rc = sysfs_emit(buf, "%d\n", p->interleave_ways);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	CLASS(rwsem_read_intr_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
+	return sysfs_emit(buf, "%d\n", p->interleave_ways);
 }
 
 static const struct attribute_group *get_cxl_region_target_group(void);
@@ -535,23 +510,21 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
+	CLASS(rwsem_write_kill_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
+
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
 
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-	if (rc)
+	if (rc) {
 		p->interleave_ways = save;
-out:
-	up_write(&cxl_region_rwsem);
-	if (rc)
 		return rc;
+	}
+
 	return len;
 }
 static DEVICE_ATTR_RW(interleave_ways);
@@ -562,15 +535,11 @@ static ssize_t interleave_granularity_show(struct device *dev,
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	rc = sysfs_emit(buf, "%d\n", p->interleave_granularity);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	CLASS(rwsem_read_intr_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
+	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
 static ssize_t interleave_granularity_store(struct device *dev,
@@ -603,19 +572,15 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
+	CLASS(rwsem_write_kill_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
+
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
 
 	p->interleave_granularity = val;
-out:
-	up_write(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+
 	return len;
 }
 static DEVICE_ATTR_RW(interleave_granularity);
@@ -626,17 +591,14 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
 	u64 resource = -1ULL;
-	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_read_intr_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
+
 	if (p->res)
 		resource = p->res->start;
-	rc = sysfs_emit(buf, "%#llx\n", resource);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	return sysfs_emit(buf, "%#llx\n", resource);
 }
 static DEVICE_ATTR_RO(resource);
 
@@ -664,7 +626,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	struct resource *res;
 	u64 remainder = 0;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_region_rwsem.rw_semaphore);
 
 	/* Nothing to do... */
 	if (p->res && resource_size(p->res) == size)
@@ -706,7 +668,7 @@ static void cxl_region_iomem_release(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 
 	if (device_is_registered(&cxlr->dev))
-		lockdep_assert_held_write(&cxl_region_rwsem);
+		lockdep_assert_held_write(&cxl_region_rwsem.rw_semaphore);
 	if (p->res) {
 		/*
 		 * Autodiscovered regions may not have been able to insert their
@@ -723,7 +685,7 @@ static int free_hpa(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_region_rwsem.rw_semaphore);
 
 	if (!p->res)
 		return 0;
@@ -747,15 +709,14 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		return rc;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_write_kill_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
 
 	if (val)
 		rc = alloc_hpa(cxlr, val);
 	else
 		rc = free_hpa(cxlr);
-	up_write(&cxl_region_rwsem);
 
 	if (rc)
 		return rc;
@@ -769,17 +730,13 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
 	u64 size = 0;
-	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_read_intr_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
 	if (p->res)
 		size = resource_size(p->res);
-	rc = sysfs_emit(buf, "%#llx\n", size);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	return sysfs_emit(buf, "%#llx\n", size);
 }
 static DEVICE_ATTR_RW(size);
 
@@ -803,28 +760,21 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled;
-	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_read_intr_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
 
 	if (pos >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
 			p->interleave_ways);
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
 	cxled = p->targets[pos];
 	if (!cxled)
-		rc = sysfs_emit(buf, "\n");
-	else
-		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
-out:
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
 }
 
 static int check_commit_order(struct device *dev, void *data)
@@ -1127,7 +1077,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 	unsigned long index;
 	int rc = -EBUSY;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_region_rwsem.rw_semaphore);
 
 	cxl_rr = cxl_rr_load(port, cxlr);
 	if (cxl_rr) {
@@ -1228,7 +1178,7 @@ static void cxl_port_detach_region(struct cxl_port *port,
 	struct cxl_region_ref *cxl_rr;
 	struct cxl_ep *ep = NULL;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_region_rwsem.rw_semaphore);
 
 	cxl_rr = cxl_rr_load(port, cxlr);
 	if (!cxl_rr)
@@ -2137,7 +2087,7 @@ struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
 {
 	struct cxl_region_params *p;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_region_rwsem.rw_semaphore);
 
 	if (!cxled) {
 		p = &cxlr->params;
@@ -2199,20 +2149,17 @@ static int attach_target(struct cxl_region *cxlr,
 			 struct cxl_endpoint_decoder *cxled, int pos,
 			 unsigned int state)
 {
-	int rc = 0;
-
-	if (state == TASK_INTERRUPTIBLE)
-		rc = down_write_killable(&cxl_region_rwsem);
-	else
-		down_write(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	if (state == TASK_INTERRUPTIBLE) {
+		CLASS(rwsem_write_kill_acquire, rwsem)(&cxl_region_rwsem);
+		if (IS_ERR(rwsem))
+			return PTR_ERR(rwsem);
+		guard(rwsem_read_acquire)(&cxl_dpa_rwsem);
+		return cxl_region_attach(cxlr, cxled, pos);
+	}
 
-	down_read(&cxl_dpa_rwsem);
-	rc = cxl_region_attach(cxlr, cxled, pos);
-	up_read(&cxl_dpa_rwsem);
-	up_write(&cxl_region_rwsem);
-	return rc;
+	guard(rwsem_write_acquire)(&cxl_region_rwsem);
+	guard(rwsem_read_acquire)(&cxl_dpa_rwsem);
+	return cxl_region_attach(cxlr, cxled, pos);
 }
 
 static int detach_target(struct cxl_region *cxlr, int pos)
@@ -2644,19 +2591,14 @@ static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
-	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	CLASS(rwsem_read_intr_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem))
+		return PTR_ERR(rwsem);
 
 	if (cxld->region)
-		rc = sysfs_emit(buf, "%s\n", dev_name(&cxld->region->dev));
-	else
-		rc = sysfs_emit(buf, "\n");
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+		return sysfs_emit(buf, "%s\n", dev_name(&cxld->region->dev));
+	return sysfs_emit(buf, "\n");
 }
 DEVICE_ATTR_RO(region);
 
@@ -2995,7 +2937,7 @@ static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
 	struct device *dev;
 	int i;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read_acquire)(&cxl_region_rwsem);
 	if (p->state != CXL_CONFIG_COMMIT)
 		return -ENXIO;
 
@@ -3084,7 +3026,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read_acquire)(&cxl_region_rwsem);
 	if (p->state != CXL_CONFIG_COMMIT)
 		return ERR_PTR(-ENXIO);
 
@@ -3255,7 +3197,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 	cxlr = to_cxl_region(dev);
 	p = &cxlr->params;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read_acquire)(&cxl_region_rwsem);
 	if (p->res && p->res->start == r->start && p->res->end == r->end)
 		return 1;
 
@@ -3315,7 +3257,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	struct resource *res;
 	int rc;
 
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write_acquire)(&cxl_region_rwsem);
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
@@ -3453,10 +3395,10 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
-	down_read(&cxl_region_rwsem);
-	p = &cxlr->params;
-	attach = p->state == CXL_CONFIG_COMMIT;
-	up_read(&cxl_region_rwsem);
+	scoped_guard(rwsem_read_acquire, &cxl_region_rwsem) {
+		p = &cxlr->params;
+		attach = p->state == CXL_CONFIG_COMMIT;
+	}
 
 	if (attach) {
 		/*
@@ -3484,7 +3426,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 	if (!endpoint)
 		return ~0ULL;
 
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write_acquire)(&cxl_region_rwsem);
 
 	xa_for_each(&endpoint->regions, index, iter) {
 		struct cxl_region_params *p = &iter->region->params;
@@ -3524,32 +3466,24 @@ static void shutdown_notifiers(void *_cxlr)
 static int cxl_region_can_probe(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc) {
+	CLASS(rwsem_read_intr_acquire, rwsem)(&cxl_region_rwsem);
+	if (IS_ERR(rwsem)) {
 		dev_dbg(&cxlr->dev, "probe interrupted\n");
-		return rc;
+		return PTR_ERR(rwsem);
 	}
 
 	if (p->state < CXL_CONFIG_COMMIT) {
 		dev_dbg(&cxlr->dev, "config state: %d\n", p->state);
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
 	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
 		dev_err(&cxlr->dev,
 			"failed to activate, re-commit region and retry\n");
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
-out:
-	up_read(&cxl_region_rwsem);
-
-	if (rc)
-		return rc;
 	return 0;
 }
 
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c8b543d428b0..4c44a50d47d6 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -242,9 +242,46 @@ DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
 DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
 DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
 
+struct rw_semaphore_acquire {
+	struct rw_semaphore rw_semaphore;
+};
+
+#define DECLARE_RWSEM_ACQUIRE(name)                               \
+	struct rw_semaphore_acquire name = { __RWSEM_INITIALIZER( \
+		name.rw_semaphore) }
+
+DEFINE_GUARD(rwsem_read_acquire, struct rw_semaphore_acquire *,
+	     down_read(&_T->rw_semaphore), up_read(&_T->rw_semaphore))
+DEFINE_GUARD(rwsem_write_acquire, struct rw_semaphore_acquire *,
+	     down_write(&_T->rw_semaphore), up_write(&_T->rw_semaphore))
+DEFINE_ACQUIRE(rwsem_read_intr_acquire, rw_semaphore, up_read,
+	       down_read_interruptible)
+DEFINE_ACQUIRE(rwsem_write_kill_acquire, rw_semaphore, up_write,
+	       down_write_killable)
+
+static inline int down_read_try_or_busy(struct rw_semaphore *rwsem)
+{
+	int ret[] = { -EBUSY, 0 };
+
+	return ret[down_read_trylock(rwsem)];
+}
+
+DEFINE_ACQUIRE(rwsem_read_try_acquire, rw_semaphore, up_read,
+	       down_read_try_or_busy)
+
 DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
 DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
 
+static inline int down_write_try_or_busy(struct rw_semaphore *rwsem)
+{
+	int ret[] = { -EBUSY, 0 };
+
+	return ret[down_write_trylock(rwsem)];
+}
+
+DEFINE_ACQUIRE(rwsem_write_try_acquire, rw_semaphore, up_write,
+	       down_write_try_or_busy)
+
 /*
  * downgrade write lock to read lock
  */
-- 
2.49.0

