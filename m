Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48572BE48
	for <linux-cxl@vger.kernel.org>; Sat, 27 Jan 2024 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706324727; cv=fail; b=Rah7D6t4HwLTmVR2aU+2j8YR7K/muIT/WibzjnIw+4VWu1TNiDN+y6/xGZABnyUP2WQPiWJL7E5IGFO7mtXK1V6RxcgXBhiGCgm3/m+qhTzy8nyhLXPQj9y3Hp64TLnWx8sobFgffLz87EZFF4Pd2CTQec28/EvRggJNkvBx/iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706324727; c=relaxed/simple;
	bh=Li0w/CwGQK8U6YlR7F9kssPGE75cYsFIxF/me/jQ298=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y/PRGx0kmmufqL+JIsZU1uoBR1vWTUInw0YZiBYcQlpIsp/hIxnNMA5J5muj9kp4OI+wLXZW6aOa3DsWNqJu5EjW+SycYbQX+fb1phDI7jQ/5MNrKRyc/DienMh0xYMpj7rg6gi9A95U3dpAYUS0yW0F+DsU0Vr6AA/GgUijdaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hc7UCl85; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hc7UCl85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706324726; x=1737860726;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Li0w/CwGQK8U6YlR7F9kssPGE75cYsFIxF/me/jQ298=;
  b=hc7UCl85hOgdE3fAD8RkkdeScBG8uiNvb07WYZ9/0PPgaBy9enXxZQMY
   czNKOPZMcEt/H+0zJtoGOdqLzAO6TmxGhd+poKGSA9XP+KEpgfvV/Vb4C
   tRoVJ5mr8zMVOoZbVlUNsMNCOkiw+ZLnvqebOIfgitmbj9BL6Qge+szti
   TM0AGJ0egZGNkRpkr+13aKB8m//Up5X2vnCfR5eUBlY9pG8yUiIC7XZEe
   0rndjSDfAGmaARH1lWlpFfVlk2GNVJU1dNrYhuIUhO0Qgeoar8p90Q5qZ
   /Bl15Dbgh42ZzqCdeerEDBfeCEFK/xzAyN3rFfbQIKx5HQNKqvRvznDZo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9294764"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9294764"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 19:05:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736869852"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="736869852"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 19:05:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 19:05:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 19:05:24 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 19:05:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/I3116s4Am6ISUK0G85XKNn58fqbNVZLk542KFocBSYRMFU057oOqEsGYS2Ulv2jI1Lmw/67G/WIf7Imi8f7HozN9nMZg8/urGF0JO/W8u90yuqiRa++Fj1lSEPqI2N6KK9lAtFtWMQQMnEzvlmilA6nzI5oYGx0HppiMTrYkWmlqx3V45kut4Z0sS8R3ueeph1AR4vq9Q4gB0/yWqfF0gg68voa1iYWW3aLVQhus03wk4r+1cZrEDG5q8uKD6oebgAtZcGP6z32P6NnZZkOp61xRuq1i9LAppgn7B3/aUgsd0k2SFXAekvkDpk3ZUHzozWlbRmu4bAmByLSNH38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXUj7KOzgUaI8B24uwQlAfEX6bTHXTYDOqqlhWKXEYw=;
 b=OrzN1+joN51cStcWNaLzlhuGQGRidn6Lmvm+WWMVHCvLJaScUkgvxr8SAKSPOE2EbujXm82vhZ8DBRtxTw3DrzqnaQ617ocQaTRpDQghKg0M4bv6814sHif1NMgS+bq86xUpAVpnu6FyGinuyS1wImGWcAFPFM0BoqllvxAWdBI+SaPo5CI79jpzlgNHLmz4WP4tCXdHbsrbGjFimO/9lOtOM5Pay4gyTQ4QnNRkBzC85ajIxnI6KIK8uoo4fzboRBRBMeT3quP+qUKCNkYz37VHEZUIsSYRdqvqzOu0HWZyQHbkS0lWhR7+9RRgQwnv1VqHQVpLq+Nn4xGHwx2RzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Sat, 27 Jan
 2024 03:05:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.035; Sat, 27 Jan 2024
 03:05:16 +0000
Date: Fri, 26 Jan 2024 19:05:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Bowman, Terry" <kibowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Li Ming <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <terry.bowman@amd.com>, <rrichter@amd.com>, <Jonathan.Cameron@huawei.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH 1/1] cxl/pci: Skip to handle RAS errors if CXL.mem device
 is detached
Message-ID: <65b472e9e9be2_4e7f529475@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240125081414.2189572-1-ming4.li@intel.com>
 <65b3533821510_293042944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <c8f6d74c-bdbb-4c46-a535-b109c440a7fd@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8f6d74c-bdbb-4c46-a535-b109c440a7fd@amd.com>
X-ClientProxiedBy: MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b4ae58-9837-4016-62af-08dc1ee4c979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEruthS13G+v2d8h4brXLJWrczZ2gKXDgQUvm3UFiaeg3ABw6Th62TboLqttMDz1T8GRY0okgejPp7Lxp1nGQL6smLWQmaYb1tIp03HNcMOAMkxUOd0B0k73byy95aWmDS0xtj1J1eH1pkT5gUmoBgrI/4N6mieJLRNfOIlgx+srYu/UG48qIi9Q6Y2nRjftUwsguDYrSOZgQUjCt9FddWRAQ8a7ocTHJr+ZSx5rTAwSW0z1tkxxkbFoHnLFvfTzxF1KgfqEI7cYOiPlma4R+rGEisxgQNwnwr30XhVS9M6Ku1zB4R6TlTiEhNdVxF35nHbaVa2JOBJAupnlUAplD8uKpu838yWIq5J3vsN2NxlyXHntK5fmdlWrlXVPb92Ml/2uCYjXuOwgMJJQZMsUuhIivpBzTTq3FEyNBHgoH5ykIs7QDy4VnmhgBrBjVSeFfMDVLAfVnFrM+gy+J03HfWu1O/x2ggaOQqlQ0Nx4fUCor62EsYp+WtAufHqT4C56c1TMf9bGK2toZnpSFxDuQWv7SuXQdxPlAhTdPZB1G8BctFsS4DXAh2x54vam3XTe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(107886003)(82960400001)(86362001)(4326008)(9686003)(8676002)(5660300002)(8936002)(26005)(38100700002)(316002)(66946007)(110136005)(66476007)(66556008)(6506007)(478600001)(6512007)(2906002)(41300700001)(6486002)(6666004)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xn4/Ip3SoQzio/mi0FSyJFbqfjHlyP5cQ4y+8o4G218tzt/f59LZxAkYPnrX?=
 =?us-ascii?Q?7rSjH3CfsJk3RmbidzJWjtrSlQL72Lqf7rFS5rqoh5cdh5ZksJCitdhTdvMd?=
 =?us-ascii?Q?0sia7dJurBl7TtjyzCepd9b0aiwyJZ0/0ixRWPTboa9iTFRwlyHXwPShmwGW?=
 =?us-ascii?Q?DXoJma+cnqRwVIg8/EbF+ZXijKl/D9TBGdBNyYWZxceK4nGenwvQYPlSFgYz?=
 =?us-ascii?Q?5TUSIcrSARz/jwNhoFaOYTomZv7Sj2dbeFaKfG7s8xa6xyqAIYxEiVpLtodl?=
 =?us-ascii?Q?2bl821/J+cWTpei3OZyCberiq2CIbP60qJszqYMot44aZRvStbBi0ZkwTC8u?=
 =?us-ascii?Q?cQFBJEP9qo8ti/F5h6QLFdetkrWWc5i2qRVx5HeS5RWjivs6wWTvwUFauqP8?=
 =?us-ascii?Q?/aVNFtjVQgiIP3uvxBKuRT03p8Y1ijDNjWaLT/RCh/jbk89ecBZnL2DriGgI?=
 =?us-ascii?Q?d3XpqR2dZFnCIn2NEtybxzLSsY7dzqfP4qduLdrAMaOuSA5zHe8X8Hkytn3I?=
 =?us-ascii?Q?4NUcMepUtUTR2Y4uZBMS0PTR5UWqkzVs4RTBZGrCQDYpV2hVFwXUYk+kBqh7?=
 =?us-ascii?Q?zbIU8E3HTgL1CQRApm0kKmOauok4QhDFt9y3D2iI1TdyGmDRewaw9GliCt2C?=
 =?us-ascii?Q?QiNgVnMzT1ENAfH0oG8owbaokIpdRkTIkVjAMptRw5w2M63liEe4RPi025+i?=
 =?us-ascii?Q?hV/uIQEJPs8zr4WRb5pg2JNW8vY3m8RHUq6AmX8/GBJzC02cYeeW5s/IDoHk?=
 =?us-ascii?Q?2syScvgNy4lTgWlh/8PDSDIfD/yPQ6Gf1YfW5jvs397kJtQv6H3aD3jBvxtb?=
 =?us-ascii?Q?zE1pQfghyQyGA4npaXd3Cq4/UTyoFlMeWJruKdjg8sNdTWOoPfphDLW62gWI?=
 =?us-ascii?Q?lx8kSloeMiLuir9FsXVn+Iv/1z90mI9ChX6JCDGGAe2/u+9+6GPbThFesbw1?=
 =?us-ascii?Q?k1LCoLaSmBVS+z998oMfqPeK2pFymZU+EnG5B3qMO2KE6CNEkDPVuaTCsq3O?=
 =?us-ascii?Q?tP/2IfWIe9Uf8ktpHmUpToVi+mrFLyyWK5q5ccZSKWOM6cRO4yIz3dwqznYH?=
 =?us-ascii?Q?LMGWaxlgY8TIUOxwRCcEimGc7wc+jmY4Vq6UbYE/1KhAGmDOjKAP7Z0vyRdm?=
 =?us-ascii?Q?zSdhNvDhrftgPeNrBMS7e/ozpnjfjbDcYdEdaJD/Ijf1A3M+BXDqGXkpnAG8?=
 =?us-ascii?Q?OamyTAOQWHjNumiRQ/732eAyu5CDok1KynJOr8guhf+ayFj7p/xA3c6c372a?=
 =?us-ascii?Q?g9v9qR6J11PbdeyefRueWsVt/zGMOK6TsmS+fX4P56ioA+B80P9m+m7lDlJ1?=
 =?us-ascii?Q?BwAMj0+s8vjjaU14gr5G7GqziidZ8NdaZSUCLid7qDd/C6DIHY70iZuiMQWP?=
 =?us-ascii?Q?KVI6i15KxKI0XDRxoGiBB3F9ZONtVwA9W66pYONNYsKtebH1VHQz/jru3HO9?=
 =?us-ascii?Q?SbQHW6YNTV8/EuFgLsd86nEEjVv748ohOr0vy9x+S2UzKPsXwXecR0JAMMCy?=
 =?us-ascii?Q?hBTqKpbszX/6RBk19vCl8n0MfKiEVdi1VaTOVoBFUDf7yk9rf+rHf3OGWjvO?=
 =?us-ascii?Q?3P+ZTbBk0fX98FpBMlds0ouj7eXkQd6XvKzGtYGdQKBcBTj9YAG1T06cZLzZ?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b4ae58-9837-4016-62af-08dc1ee4c979
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 03:05:16.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7UzQBSFgrIa2/1IlEBhGS+tfZW3/F66zl71sTGMfCz0nZtuZyytP89DtzFvQ1vSPYbb9kpkTPpnVtSz0p2XsQ4xjVrgMwQmfqCbUMu2Gqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> Hi Li and Dan,
> 
> I added comment below.
> 
> On 1/26/2024 12:37 AM, Dan Williams wrote:
> > Li Ming wrote:
> >> CXL.mem protocol errors are logged in CXL RAS capability, if CXL.mem
> >> device is unbound from CXL.mem driver, will not expect any CXL.mem
> >> protocol errors happen on the endpoint or the dport connected to the
> >> endpoint. Giving up these unexpected errors to avoid error handler to
> >> access unmapped RCH dport's RAS capability. The error handler of CXL PCI
> >> device helps to handle RAS errors happened on RCH dport. The host of the
> >> RCH dport's RAS capability mapping is CXL.mem device, so the error
> >> handler will access unmapped RCH dport's RAS capability after CXL.mem
> >> device is unbound from the CXL.mem driver.
> > Thanks for this Li Ming!
> >
> > I am going to reword this to add more context:
> >
> > ---
> > The PCI AER model is an awkward fit for CXL error handling. While the
> > expectation is that a PCI device can escalate to link reset to recover
> > from an AER event, the same reset on CXL amounts to a suprise memory
> > hotplug of massive amounts of memory.
> >
> > At present, the CXL error handler attempts some optimisitic error
> > handling to unbind the device from the cxl_mem driver after reaping some
> > RAS register values. This results in a "hopeful" attempt to unplug the
> > memory, but there is no guarantee that will succeed.
> >
> > A subsequent AER notification after the memdev unbind event can no
> > longer assume the registers are mapped. Check for memdev bind before
> > reaping status register values to avoid crashes of the form:
> >
> >   RIP: 0010:__cxl_handle_ras+0x30/0x110 [cxl_core]
> >   Call Trace:
> >    <TASK>
> >    cxl_handle_rp_ras+0xbc/0xd0 [cxl_core]
> >    cxl_error_detected+0x6c/0xf0 [cxl_core]
> >    report_error_detected+0xc7/0x1c0
> >    ? __pfx_report_frozen_detected+0x10/0x10
> >    pci_walk_bus+0x73/0x90
> >    pcie_do_recovery+0x23f/0x330
> 
> report_error_detected() includes the same "if (dev->driver)" check
> before calling the device's err_handler(). The same check again in the
> CXL device error handler increases the chances of catching the
> surprise unbind case but not by much.

So report_error_detected() is checking if pdev->dev.driver is NULL, in
this case we are checking whether *cxlmd->dev.driver is NULL*, where
cxlmd->dev.parent == pdev.

In other words when cxl_pci sees an error it tries to keep the CXL.io up
and running while shutting down the CXL.mem side, but it's not clear if
that is just making a bad situation worse. So might need a follow-up to
just panic() rather than hope that unbinding the cxl_memdev does
anything useful.
