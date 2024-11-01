Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1214E2CF;
	Fri,  1 Nov 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487005; cv=fail; b=ovMvZngb7Gbklarh3xN4xq36XOOKV5adeEGiAyujp/TAVJk4LWwmtH2RQp8ugrffaYQLvoB1hLjFrUVi7s+pvlw7cRcqDxlEMbRncNx5sSTBn7elJ7r45dWd6EOyWwtGgfTp+HOBw4NAEyAqPP+yctKtfTeMlc8zrTMKoIFAZ+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487005; c=relaxed/simple;
	bh=l9E1H8MaYc+85GPUXqVgLqtd7eTB6neiRZ6zrr8Sy+U=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RSk+NUp8xfFpJL5BFhxZFugAknvta0tgJi8YRdx/5hAe0NcWc/2Q+HKZS30GOHIwOiWf/62HSG0ZWBc1amcEzndx4F+FVEI4l5Fzp6Fe2itS27e7IRH1VumSa9XHOeHn9Fl9zR2+SQr72rQDgzdPtYRUo7OHntBgcWvfe1nyfD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cplVkQfj; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cplVkQfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730487003; x=1762023003;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l9E1H8MaYc+85GPUXqVgLqtd7eTB6neiRZ6zrr8Sy+U=;
  b=cplVkQfjHh0ZDqmu5N+AROrL0hYsjA1B2RLiWVM+Xyph35BNPJNN+HB/
   fmhmeM0R5qKFJeyqT5Fu0PmJxizElM/G80/EMvQ1hKY/RqcsRrIhOSNfV
   whi5Sr+a8fkiDwtnYyz0GcNYNN9oxtevXhncWLxz2PaP+GzyWAWvtzlm0
   D1t4QclO9OI/sIxslarxQlt0xTt2k2ukRs17GEmg7Nl74wkuJ00HdEd6Q
   4kNnz/FtYcUrxd/xDt7UirDDAuyrd/LSHqwoe6SbRafasUJn6DkjpE+am
   2GvwpDnis0KLVzEaBEYBEHJjcBojWtFTdwm0yuWmJziD0cPr9f6mnl9pe
   w==;
X-CSE-ConnectionGUID: MWx4rFdsSi6C6cXKtInM1A==
X-CSE-MsgGUID: r2QqKOtASWm0lNPmS1Qkrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40806566"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40806566"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 11:50:02 -0700
X-CSE-ConnectionGUID: APj8x0QQSTqTLq28gkVe8A==
X-CSE-MsgGUID: u5BrXUBJTheEOtUw9et8OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83185011"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 11:50:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 11:50:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 11:50:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 11:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAMcMtm93uAR2Sv6quv3Hp05PcAVuCbqlVwdTPKwDqFYwir7ciF6OPN3v5DLdMuDO5ZNQ+Sp3qeaiQUCoY4nFA2cjcHEIjS6C9zncU/gqwv6R8Okbe4R3SXA3ieFcvm2rgzIBH9M2WDwjqc36WEKpjrW+yu9G+ti90zCm4t0VojEjN74ll+QQYRT5N51myeQi5CM1hQAc0Jorn6mj6W8rMUTNr75LsmU5f91Bjm/GmE4VlwMMEjeJvVAJj8iHsaD6gGr7HZt+d+qiIuhs50ers8SJvyHH7aPjDCdBOJX8VkX8HZyxe5QpVRDBtK26TVi1EptqGBtQBhZPRULjFEoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/4m4Qy0xgv1/PGPkYBEJCw1l6a92XCyfjf5jijYon0=;
 b=A16xv6GVlm7VU8lGxj6Kg3Y7OXZ2dBRB3y1j/S06almxlh2L7PQd7mDDUh2RfGHJsAz11OaKFGOoTaLwFt8suTm9Ltv3AViT60xaL4MNBZ6nIeUcKGUXoid43A0XT7lfCNsj82JJja4J32UXB/B3PgePpJaNitDsIVdiiWvGffXPnf3vJ8u6on+foH3wCbNI9BV49pHLdpnsJKgJNYaIT9qGC0+MMGFaohqwD1XRMhAC89GgkTq9YMbgPI1ClBYE5dUIh8Dc3UXdK6RCev47GF9WP7DilG3IfDYsEzLtUnHCZUDj08YAEn2R4wApKGNRkuEwWl/230pxGaSl4semNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV1PR11MB8851.namprd11.prod.outlook.com (2603:10b6:408:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Fri, 1 Nov
 2024 18:49:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 18:49:59 +0000
Date: Fri, 1 Nov 2024 13:49:54 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Huang, Ying"
	<ying.huang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>, Dan Williams
	<dan.j.williams@intel.com>, Shiju Jose <shiju.jose@huawei.com>, Gregory Price
	<gourry@gourry.net>, Zijun Hu <quic_zijuhu@quicinc.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.12-rc6
Message-ID: <672522d276c1f_9d3632949b@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR04CA0256.namprd04.prod.outlook.com
 (2603:10b6:303:88::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV1PR11MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: bb507cec-c606-4e56-7abe-08dcfaa5fc57
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E3Una+CccEJqM35TZNHzOZg2nQxPsxAIzdkDGI6A/oYP71uPAp+qkcifwwXP?=
 =?us-ascii?Q?vQ/8YFBd2OkcvaRW6eWCr5pGnRXVRShhPPr6RjnZKyBWKYJe3uvNnpZXQ/NX?=
 =?us-ascii?Q?t3NU11nPOV/F/ki5M9iqyz76vCBQBqaKj4slT7xKoXoao0H1WoM1NatSNiA2?=
 =?us-ascii?Q?mbDEe/XumV0cnbnWTfCX/BZaH5lPFk38Ah5gUYIWqYu8vMQGG8WqOw2+Vtkt?=
 =?us-ascii?Q?ySE6iTvHhpAwO7YhyXB0oMxPcCS2mH+LT/kIJ62qrrFy3AhAqxuXm6Y+oFXA?=
 =?us-ascii?Q?rSbrWcTnvicCr838F/cXQzV94fI7zFS3zTpCArBHwxY+XqQ2r3VufytlrbV+?=
 =?us-ascii?Q?uk3GOwttlJR2nTLuduq7xp0ukmYKDTzwnT+RPpYwemqWiuvnF17xOgvBd76A?=
 =?us-ascii?Q?Xzlywi54r8XNEj1n9SJRq0hUZ46Q6a5X8eKcZiVSVqmgtBjiTYOGr+8zNPvV?=
 =?us-ascii?Q?R+2rQd3hW02rDugqnvE7TOmfYIEVrDVxIVqlb/r0wb38mZ9RO9ESbzGKtG5c?=
 =?us-ascii?Q?ea37bpTDGSjvkMlajjc9vnopqPic5rSnYl4NAc3HCTK1eg0GgdbY4zcygkTE?=
 =?us-ascii?Q?uYeKWmyepApUGY7F8/3tlRSAnvZbSyJbNbLNWvj/fS+QlCNzp5vmcEE88ydk?=
 =?us-ascii?Q?9I5OeDYadtMFdFZ8nFyEWtoIfvFNN13SKuLjW1D3uwZrKJNv2aWzJWdn3oT8?=
 =?us-ascii?Q?xnRwU513SVeesClUPlqM8eDAwGVuIapOIU51WuYsX2rii4xZ94w896NSshe4?=
 =?us-ascii?Q?f6anVUrFrFlGm66VOx9gGAtqEz3NnVSgfJh7sgeSx2v5AWPgW/rfQCoqLMPE?=
 =?us-ascii?Q?1OyLQT4nVLAUk/jle2fseTcINS1NE8GyS0lwARy4NZxKWqwtlCfQMkeo3Efm?=
 =?us-ascii?Q?8YPU9FjxdrJEDq1d3YddXbLHKsery/Snbfy2oF3A1rGrKGzUXgiiisum9FEo?=
 =?us-ascii?Q?ub1hynkfwhFi0RJXoMFPGNkcaKp0pwnh20tsPb0LfIn5SdLb7FUFlKw3Leli?=
 =?us-ascii?Q?c4JnRXuD6ohK8W//A6j+TSRVFnyvLkpyGA+5q/mCNWi+emPm7gx5/4eVAYtO?=
 =?us-ascii?Q?Dp/EKlYgyUC02UQ0IDA7GelCEAz9sB7PccvjOOQzTGRJF3BD2CAEpQE4ny6F?=
 =?us-ascii?Q?DHFD++/9H4hhfmn50uXzQWvS4cZO865rveOTgOqBmeRIu0JLC8uPLQzYVcC6?=
 =?us-ascii?Q?5IPpXcb1FnhwIrb2JqlRsJZP8E/uv45mcQtvsfKJUau1ahhUuCTRvuLOZM1T?=
 =?us-ascii?Q?Nt1I7bmGpx+ur/ohUZBgiAhbb1TtKL/FZKaQl8xNRosZJr7POTJj9uCFWBKI?=
 =?us-ascii?Q?vFpBUYhAFWdIbDOf3QPFzuN3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SXOcU7g5GMqjNb0YxeiLwPWNkLB/PyeQLNJCUhGPnH0I5QUQYL/gfQhjMs8A?=
 =?us-ascii?Q?6EV8TgXNNQJ9Crbzth7juSP91bkpW1FumrWKuCq+AKLx5yuty47wjVXeLOuU?=
 =?us-ascii?Q?QjdHVqDrJdmuEpjAq+BlIoVbf1/P1mpNpFW9+/izJ26XqW/xhAUJF0LeTa3c?=
 =?us-ascii?Q?mI5lmjBuIzD+uspnOZfRHbqJsVJSJLAXtCmK4ECTddaozqKZtPasUyRlzZLy?=
 =?us-ascii?Q?Lf5HmsFQabHJKSkj/KyaO+41Qeu6534qmC14GHl+jwPqjf5I421Qe9DbS2I0?=
 =?us-ascii?Q?rOX2kBzbMOlwz5ExTuiquJ77enQrOp/aHvaNIqLYjGy0FlAqBiZcpEjLHp3y?=
 =?us-ascii?Q?a/UH26ig+bQRYzP59aq92V+VV1V5iE69J/CwvNZjyzPQeRTQdspos1OpjiAw?=
 =?us-ascii?Q?mL6j/N5F2gznd583gQNTKWQYg9oE5sjRBt/jH/L/xNJRoS55hWqRvorR6Xrq?=
 =?us-ascii?Q?GFCYWyR4Wpinjbmj0GgHgtfGErkRGA1sdoe0mMMdrwYzF9Aroz7wpHYTZT4A?=
 =?us-ascii?Q?TaC7bG9NYyAXN1IMaZdhx05tfNhkhzIDMN+vtFppRos6E5frLtix0UjvU4me?=
 =?us-ascii?Q?fBmXPmvwwYZtk5K8jPF6H14dIHkk8xk5qGLwpNcvNjPLTpgMfMfnwk3l9p+x?=
 =?us-ascii?Q?XIKjuKKUf+/AlHHhTf5obFJgVEFK1/lmUO9SaYauiozn2XAJM/oK5QBNGST/?=
 =?us-ascii?Q?U5olVlL6L9AUarz5VOr+og7nmbQHZNoqKv0Pab0RRdzi6b93IXVO3vBsWJin?=
 =?us-ascii?Q?W93Naumn0tOeWSeTJd/DfbvqFJxweHRXvBbKD+cJV24cZmWsC1xDPXgSdRhE?=
 =?us-ascii?Q?AYwfRg6+QxhB4AJM7e4KvRT6MPPoph5erQBndffFrx/Z1mktkDzUX/c3kLzz?=
 =?us-ascii?Q?LnRl/Gh1IaPSbaczzw6c6aCpnZ2wfDq1GvUILqCidCUP00ZnK4s/iChs88BW?=
 =?us-ascii?Q?l7p8s7QSofVevpW5fmV4ei3dVee/+vkeGMOBz6P6vUkfqCCQq3pfp2m1iELu?=
 =?us-ascii?Q?UPdXQvNLcBxBwhVPatFKNBtPpIJzPl2ifxbFwWdk4028oeZb58FdisAYRLNw?=
 =?us-ascii?Q?sioBEbQqA71QsHRtvd0BOvRgGeRt4dsqody1PAYl7vaHgKBmcYU4CghWCoCj?=
 =?us-ascii?Q?hZVFto0rSLo02cxPB8R7LyljYNTJ/t/5yaDXc7rwa5EquMVxwnqHiXD1hvNE?=
 =?us-ascii?Q?zVx652v0yOw9P3W6/50aXcYJcuNpqaRoVfO2ahwevV4G3pnxe8ITv3nSnacS?=
 =?us-ascii?Q?dTkaZMLhrBoWu0ZqVLbzbhYVeI5llLojOc0PuAwWuZIEScmg93KvrYu0j3bP?=
 =?us-ascii?Q?6WNzOP2251m2Ri6Nnamp6Tf2D84S7VvLxUMbL/1EJN/17V18aPM16jP1TUvs?=
 =?us-ascii?Q?eqvUOMmZzwB1Pzg3OC168PBx9v+vis9LvE3FKJHmVeViopW31Lk3Bjf/r+rL?=
 =?us-ascii?Q?H93oRq68gK+CaNrju1GhhnRCkHR+ZT3Iv1//1gYyCJy+dfTBk6cBYJzbzDUI?=
 =?us-ascii?Q?Zmag6CY1wS85N9VTwuYKuqsV6wsFtEh8BjpWdO7hs38ywKLhqNVCQXytvLcO?=
 =?us-ascii?Q?CsHf0Io6QpXMEEyBVEZMXn96TT8DDfONHRcDv9rD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb507cec-c606-4e56-7abe-08dcfaa5fc57
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 18:49:59.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fixtnqWKJy1y7NN1eROsvX2B/kyBH6fTtqYWlCmXzem3yqr682srOdjZy++Ytuq8b5oSb3KcyewcqIyV/pcFXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8851
X-OriginatorOrg: intel.com

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.12-rc6

The bulk of these fixes center around an initialization order bug reported by
Gregory Price and some additional fall out from the debugging effort.

In summary, cxl_acpi and cxl_mem race and previously worked because of a
bus_rescan_devices() while testing without modules built in.  Unfortunately
with modules built in the rescan would fail due to the cxl_port driver being
registered late via the build order.  Furthermore it was found
bus_rescan_devices() did not guarantee a probe barrier which CXL was expecting.
Additional fixes to cxl-test and decoder allocation came along as they were
found in this debugging effort.

The other fixes are pretty minor but one affects trace point data seen by user
space.

Apologies in advance for the later PR.  These fixes just missed rc5 last week.
I did get them pushed to our fixes branch last Friday 10/25 but they only
appeared in linux-next on the 30th.  So I've waited a couple more days to send
the PR.


---

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.12-rc6

for you to fetch changes up to 3a2b97b3210bd5758f66fad04c5171f85a016a04:

  cxl/test: Improve init-order fidelity relative to real-world systems (2024-10-25 16:07:04 -0500)

----------------------------------------------------------------
cxl fixes for v6.12-rc6

	- Fix crashes when running with cxl-test code
	- Fix Trace DRAM Event Record field decodes
	- Fix module/built in initialization order errors
	- Fix use after free on decoder shutdowns
	- Fix out of order decoder allocations
	- Improve cxl-test to better reflect real world systems

----------------------------------------------------------------
Dan Williams (6):
      cxl/port: Fix CXL port initialization order when the subsystem is built-in
      cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()
      cxl/acpi: Ensure ports ready at cxl_acpi_probe() return
      cxl/port: Fix use-after-free, permit out-of-order decoder shutdown
      cxl/port: Prevent out-of-order decoder allocation
      cxl/test: Improve init-order fidelity relative to real-world systems

Li Zhijian (1):
      cxl/core: Return error when cxl_endpoint_gather_bandwidth() handles a non-PCI device

Shiju Jose (1):
      cxl/events: Fix Trace DRAM Event Record

 drivers/base/core.c          |  35 ++++++++
 drivers/cxl/Kconfig          |   1 +
 drivers/cxl/Makefile         |  20 +++--
 drivers/cxl/acpi.c           |   7 ++
 drivers/cxl/core/cdat.c      |   3 +
 drivers/cxl/core/hdm.c       |  50 +++++++++--
 drivers/cxl/core/port.c      |  13 ++-
 drivers/cxl/core/region.c    |  91 ++++++++++----------
 drivers/cxl/core/trace.h     |  17 +++-
 drivers/cxl/cxl.h            |   3 +-
 drivers/cxl/port.c           |  17 +++-
 include/linux/device.h       |   3 +
 tools/testing/cxl/test/cxl.c | 200 +++++++++++++++++++++++--------------------
 tools/testing/cxl/test/mem.c |   1 +
 14 files changed, 302 insertions(+), 159 deletions(-)

