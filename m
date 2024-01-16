Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479A1CF9A
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jan 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432889; cv=fail; b=bvDVo1lvZTKO54nxxl/wVhT46xcShnzEstGaW2bGIbdIeQWdVky+cxAozqv/GCtv0dThiuC/0Dybp3Bcf9LVjXKSS4LVFS7azsqPxlUsOpbkCbR/6SMsSyUOahgd58mV3GPNQfUONX5kQlFzTrXTRqpVI/F+fY95o07GFA0FxTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432889; c=relaxed/simple;
	bh=ZBK4TEttpXwchJgX1/8hLSu9B29q3FVKA9o6yw3Cc0c=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=k30/NZNi1pbRB82tFrX2wL4juFTrm6JV9t3VqB6Yn8YCiLmX/v/TORb8QdJ1XssUEhhiQaGEhULK55aZ6+T3DJ0t/CgAuskQMJV+9yBRPdbeoZNeMUQLoatoSNNhRKLHt21ik6iZ/Eqpv5M+mjkkyVK52qBN74Lux5V4xWlbkOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aleSaJXg; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aleSaJXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705432889; x=1736968889;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZBK4TEttpXwchJgX1/8hLSu9B29q3FVKA9o6yw3Cc0c=;
  b=aleSaJXgdUqy5kZNUo3Ek1hNSln5290oQ2kyRiEFsSWfkIgqYr+eZMFr
   +/NP88MnXZSyUGUS5d141LHgEnMPKcYlw9hECbvHObLri1A9KlIL3hoiq
   5nuD2dlu52htj74q3sMDpoSPI2eLKvPffsoXULStOL2Gq7bR1oO191DAM
   WadTERB8G/YoJjvwYKO0wvDkr0Ah7TzMd3R76k1DRsZcq/IdXEl96lUni
   jTqoOpi6dXgDwfPZaYb/B22ATNSbecjTPhVrFNgXqwy3UBa9D9j6cDe0e
   jlJVSKoPKrByH2qlao7lws2DOvaM1cD+sckU/3HYO5SCeomlypZ0qW52y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="7054378"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7054378"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 11:21:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="874563060"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="874563060"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 11:21:26 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 11:21:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 11:21:25 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 11:21:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzDRV3IFTn79TenzIT02iu2nSkZniOvh/UDkcFveMiPN1tGyNfzmpaUni0m6Z91svu9PK6TnG3upV6lDuQmLBnXLt/zenQ1XVmQAhZWkQIe1D9nzEFi0MxHGu69RceFDX4iBEP87+bQEWQwXxGw8sfR0v+klFakaJZkXB4RlDFrlzScQcyPuql58heLjLEpGXRWg8TjbGQ5sYR2mYm+uAhQDLPaj1DViXfrk64+hen4pH1Gnpt9C1zLb9cS7DjBJHmYh+8NtXRDduTdWrsTiodqtkx2XpxxI39WRyVsfU6LxtmY3thIx3WlncYFdQWAzUOTPlwUXQQ9RYz2mo0Vbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPCFk/ZZ11qSD4vyozUGcsew6/iWQ7d6DuTXttwjAsM=;
 b=YBVnL3gwYsllMJuNTeJTAU13OU6KhDHAA2hNiC1eVoE5cVoalhG5PA9cdcrs8v6OafUYrSDn1bk3e1wSK6gy2NE9orxKJRzEkJydvXcl3PZbbiiV5w03YbkdMXuIJyhReWfPRUm5TdsFUVKktcpqhxLSX0p9K2D5l9AMEo2fZFR2wlp04t5Esz/0jwn7/WF5/4JLBUzM4QRTl0rE20w4tHYlAgU95wPeA161Vcwp9VO/m/9wDnaQz+mv0kVHf1rZ+D7+gMVZ0oMh3JmY7SYWEH/kvewOB8tkDZlEl1yMpzbKMMNIQCOCk0cd47m+i8cUKFNvWZ9n5gAwq96fNZslvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6494.namprd11.prod.outlook.com (2603:10b6:8:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 19:21:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 16 Jan 2024
 19:21:23 +0000
Date: Tue, 16 Jan 2024 11:21:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, Dan J Williams
	<dan.j.williams@intel.com>, Adam Manzanares <a.manzanares@samsung.com>,
	<vhache@rambus.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<mhocko@suse.com>
CC: <linux-cxl@vger.kernel.org>
Subject: RE: [RFC] Do we need dedicated LSF/MM/BPF 2024 session for CXL
 memory?
Message-ID: <65a6d730e467e_3b8e2949@dwillia2-xfh.jf.intel.com.notmuch>
References: <42978BEA-D194-41F4-A619-BAF02CE8F4FF@dubeyko.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <42978BEA-D194-41F4-A619-BAF02CE8F4FF@dubeyko.com>
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 4274cf98-9ecb-4e61-abbe-08dc16c8539e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQo5ckJkc/qpebPphmTcuerajQdr05xgT8F6ub19KwI3ZxSvKJQR7qBAz11t2B/EL4u3hSt3lpT3R5VPqv4B6Hh6Tzk/QhaOFW2+q70ZRPy9DWUqICSTy6iLfsaLCWqrLqpLEy7Hqm7KmjqE/EZJKRCTX5+sEhYlXFfjkrupeLplUgJIR68u1XzBo/dKnJaG3J3J5zs3MW50VmCIdN9uzJlxg7TCVEneDKj697LubzN1x3nLsNV9rNO++NXpFXo9AiiuZ+47zRPZ0c1defnIuN7d/4wH8qyBrMsnVsaZwM/kIXRXDNXVtTK8Y6wrgu55D6XtJUf7urtLhmsPurbTWM62g5GV01URNef7PEEtoFZIl3THQqYsCDLEFyJshq71Oo/GNJn7XXxmJUFM5k12P5wbWk8146ImyIkkepeItAqjPIPk1lBH9vw1ZxOlhqYxpNfVEmIFcqCNEWlNjzJ3eDxJmpJpJi2aiPiRglTI8NzWFfM1M0wI36VVBbTiiE3qbJEOutG8uV6e8nhi1oeTGRpNRS6NcCcsRZO8pEbD/9iFM4Rx2F1L4NzbHg9vG/+s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82960400001)(38100700002)(86362001)(26005)(41300700001)(478600001)(6512007)(9686003)(66556008)(316002)(66946007)(66476007)(110136005)(6486002)(2906002)(5660300002)(4326008)(8936002)(4744005)(8676002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kNC5QWHSXoFKt2R0Gu9fgVm079XHn24kb0IJ0GA3m3Wkg49Ch6sD/p7Dr7pc?=
 =?us-ascii?Q?+ENQzIGP8FxCeJR8kJT55JSWF7PDzifXx91aqA70lbW4cbYLp4OXNtHlRP+p?=
 =?us-ascii?Q?z1EJ9RWbdECppyD1EZIGHfc4Pn0Xtro1X6gMPc0g5HtbBJAZgYJO7idq/pYB?=
 =?us-ascii?Q?eilBzstFpqs38v0wXduYPBrkS9BBINnMi7PSfvRDHnBAy95ZQuhamVI3h5u1?=
 =?us-ascii?Q?F5kozmIRDfgShMDOVa4dA4d96a/ehaa4daFczz4s77TnKNWTagA4zdQb4t7T?=
 =?us-ascii?Q?bTzE39Eq3lJMi+CKvJpOxTDNCUWmaGhIHRGbNNr8UEesOAfEVhlFgcdnfdio?=
 =?us-ascii?Q?6kLkjU94AiarfRsBXVxQcMcD6sx9XASApBjGvLyyVRU7Tgc44qCic067RJdF?=
 =?us-ascii?Q?0kZorR6gIRoxvvREGoPubhRdKRuGUgC1ktHQ5T0KzbJHq9MaufaWRmwPA7fd?=
 =?us-ascii?Q?0gy005bXQA7VXDbrSITApJoa1LNzvAOWnLw5sFQYiBV/aZePjGY/ZLsOucP7?=
 =?us-ascii?Q?w4aPFmlbP6gEL1x88X5vzcHe1pPAz6rDHWG0RpOyDewNvfGzZ7ZbUSWdi4Iv?=
 =?us-ascii?Q?dwi8IeEHGaVv0COD5Wp7CYivV69Fsr4oombYrr2yK8pTcF5VWs4L8h5z+iT6?=
 =?us-ascii?Q?NnePb8tvzNsdRAcypFw2Ms4CW+ujuUkezMxAr2WMSRcjEw5YwPNT0UkqOI1q?=
 =?us-ascii?Q?2YKI7u8iT/6WpuUR4QqX7MO31d3R37zz8iWFzi3ZgRPU+NMgxKl9LlyNj6+S?=
 =?us-ascii?Q?4v0FomkpUREV7PZzkoVYzMMdkEE7BFLGRa2IQvQ2BkOHyMCFtsGhcVhXbLeR?=
 =?us-ascii?Q?wLjF0qTCjPjO6/xOiAs3eCqRnjMoA7v5XCrXyEXAU6eIyN4JrPwQ0178ahXe?=
 =?us-ascii?Q?IQxt7lLrBdpVtOK8GC6ng8iRhVYNAZwcoh8provuZi2tay5uCX9Te4427wuo?=
 =?us-ascii?Q?7B0iVRCw+wIet9TVQp4V4Zss9rTDarR+DifQvJsn3LyoaearAIcqu9m4iBVa?=
 =?us-ascii?Q?IZeY2l1r2YoiMIytKqwiTCxGxOPmOhEISWbY2zWvyobe3fQImcOfoZIYkRHu?=
 =?us-ascii?Q?OBgLpfC/seONcxi3IYZ5PEkrtlHu1p+PML2dWmb7AhE+d5neB+fdII60JSN8?=
 =?us-ascii?Q?j68LIKEiLa09fz6U8gd8dq+364rYAuiu/JS4NiAIJl/U+bqeMq4C1/cZgFId?=
 =?us-ascii?Q?oDGbLUL4sWcZMhK6ud+G7PsD41fK/1BRw2yc68Fy5FU1iKry19z8a7Ct3zwL?=
 =?us-ascii?Q?mKzlXkkBzNtx0R2ZBKv5WINk7OSCZDrqjGqYMeBdUMOUzF9w5dTKQJzJUqYM?=
 =?us-ascii?Q?kmwEzcDEL9QSPtSf/GDo2QaSc2wdvZSa5dAMuT40KUYaXTBs5izFT5h6pofX?=
 =?us-ascii?Q?VKcwilwWQLe0xqdFE+hqPWSumYgSSWaNUGXM9lR7HaJq+eeWm3onvd4CcRAG?=
 =?us-ascii?Q?QSV29sOM2WuSKUF3i9OYWQHm7x/gOynjL/uiVbTWJDAJd+OM9r40naK2HeeS?=
 =?us-ascii?Q?OZGlkEZGobH9iZisghWUO2EuD1cl1JBr1agDw97mtJeVoCNG1gPfsFdaVK+9?=
 =?us-ascii?Q?lRhWGYgFv9QvdmDCnr601EJCk3U9AbS4LE6NucgFFkKeGTAU7SDrsC9Muvlf?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4274cf98-9ecb-4e61-abbe-08dc16c8539e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 19:21:23.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeBjTvyc7ZfacgdRN7sF5LuCmLtM7XffEXNahdv7aY/YF93/QLX//fwR8v8DZJFHUsnAl+tPzU4wn9bwE0kBiR31grDcfKxWf1XZHUQvW/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6494
X-OriginatorOrg: intel.com

Viacheslav Dubeyko wrote:
> Hello,
> 
> Do we need dedicated LSF/MM/BPF 2024 session for CXL memory?

Last year we handled this on the fly in terms of identifying topics that
have the highest level of cross appeal with core-mm folks. My
observation is that some of the sessions were useful for the "mm" track,
like tiering policy and ABI, while other topics were likely more
suitable for the "storage" track, like fabric manager topics.

I expect to do the same this year and not have a dedicated CXL session.
I.e. prefer CXL topics that intersect mm-policy or ABI for the "mm"
track and find a space for the more hardware-centric topics on an as
needed basis.
