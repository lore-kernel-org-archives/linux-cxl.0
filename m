Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DFF3AD531
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522373; cv=fail; b=qN9JhzKKpqLtgtlOtBudrBypOP3kQQXlqhmXzjOpDJpftSkocZXKanZ1xLIwEOcSiY2MZg0+iqU6+voTY962u9K+V+APby8HBaeBMXL4+AA6vMY2RQbg7VonR8sEQCFzqJ2hC/35tkWqRUKI5SQtiuUtaXxlf0sXCzRmu7up5sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522373; c=relaxed/simple;
	bh=A0ReZkPr3gTvMw8Z8i3DXsCX7a3lGs0kss8dHOF4HoE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oZPpaEc2T67ax3pr9wqSqxWzQQbp4YeqTC0Nkq/IdzjaP3r4M5sN4Ct0g7g1IvigYp5hR+0Ovcvhf0iCwEpkU2ay+wW8WpEKsgpvSpGBM8ZYpCcDOhcGfi02wxDpEtiLFiMOVvdgjMGKvzzzx/9X7hoxTpvYNhGIT8OBiG+Fnh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4QXKC9M; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4QXKC9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789522364; x=1821058364;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A0ReZkPr3gTvMw8Z8i3DXsCX7a3lGs0kss8dHOF4HoE=;
  b=H4QXKC9MfZ6Q9dt4JhnViUtoIQRb5hbzB04p09ePUe7LrYzck3w5PWGW
   /gZvmMu9dN3r6hZyVtcIEnfKLyvfV6zIyXb0EuTwtB+3b2qJz0hwpSFJg
   DkbvoNaTn8SwgpLS5xtwoBUN6fLfTC19rnBqejMGj3bshUNMnqXVjGxqf
   jFWpfHMe/FKC8SiveR93PlvlXRIfQr8RsRFZCv9NIBd/PcPuBKZUewVyV
   /t9JCzcybSbuxN3xgVaMYe2YGpOWRw9GojcWWb5YhYOfzoSLorzWjckMY
   5nn+72uCDzS3n7iz/FXig4OMdFJzHz4wBlL3alKohrtL0ocIxyTSWm24e
   g==;
X-CSE-ConnectionGUID: maa0loIWR0qkGrGjwk95Pg==
X-CSE-MsgGUID: Io28Dj9xQXC9j7zIHXTxDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101242328"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101242328"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:32:38 -0700
X-CSE-ConnectionGUID: uvNdL17dTI+4eXAz/G+DAw==
X-CSE-MsgGUID: ELmfZv+FSbqu7TwxeKUwJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1404532"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:32:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:32:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 18:32:37 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCeB0u3ROAvd9F7P5AuB+4cQtU5UcrnWCaiZbIned9ZIgicF/RaUoke3+3Gfjkv6QB/mOSsY4myn4w6PaCoGX+WACYomv+uwhNNZMCx0ebgbdaLqOp3xwm6FooHzLDTWHnIlTqx4FcfX/PWd9iXDEbSOm91ALlM/gezZc2oEGAnX+4/UeB4Ye/XwA//9OoQhA+X6Dq82dC2j2T7q1iOYYmiBbUjhJ7ekP/Qego4835XDI+DFEKumk8rtqraUlK91lGW7bYUz+J6RIio0GnwGdF9Gt+DtFKM3U8fdAVJvJk5Lz8F5bY+zCFX2foUWBmJ30cNaD62X2h4j/TF2APOJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVn1FSH7EtLRqJraslp9H7d7q9jPEFhS1DQsNkL1NHI=;
 b=bp705adbYdA50zvFLiLgVe57NdE0CiTMLUo9DS6c76sS49yW89gU2G2KYYtSJUWR8rPOac+Uckr0cdeinr2KInTe2pQ7Azi89I7ATMjvIAr0cUIP0l4agga1lP/mQLifgI88HTOwtFVFi/4g+HUU+gMRjlnOGNX6NQjZb6DDhkDxaociPW/ONpf/f8FQWDN/cG6J9nVdjjAxYaiXw8W5GxAO5PUOdciHGnVY7ELF6RoE1hgWU0NdVRzK8ZCiLWzXaUydIlaOSDWO+XMvcH6Yu9tNN7pYH0ng9BmhwF3f6gwfbKluRaNIIHqVf5bWs5JE/OnCRcK24/OQOq1DasosPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 01:32:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 01:32:29 +0000
Date: Tue, 15 Sep 2026 18:32:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <icheng@nvidia.com>, <ming.li@zohomail.com>,
	<vishal.l.verma@intel.com>, <dave@stgolabs.net>, <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Anisa Su
	<anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>, Junhee Park
	<jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>, Fan Ni
	<nifan.cxl@gmail.com>
Subject: Re: [RESEND PATCH v13 5/8] cxl/pci: Factor out interrupt policy check
Message-ID: <aqnxqAjCh3ODGGlh@aschofie-mobl2.lan>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-7-anisa.su@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-7-anisa.su@samsung.com>
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9e0172-5c00-4ce4-378e-08df13925f0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: IIwKTOZV5SMEZy8w4WqMO5wIDTlZT4t1ZELyzEf/gNchcM2Yl8zF4hKs8YjqeQ6bAbiWkqqpc/KmYo0ajwN4Nx/vg+7zGADRtWyODW1CRf4zjD1mzF38o4icLrdINqjI0Rc53+ykoTEryyRykwpv3MB5VF9KNyI4oMZxuayFcLZ5QWTWcD0oU5alxoDWT6LwoQQTaqkaXSdu7cBCsjE/ZjavXNa+lHA+jkEIwY3ezoJ6G5td4RMv1W+wnHFnSg8tv/97qbx8w4XFnTU+ZyGYPABjheoeeXvQ3bfznN9fVrEqxNdsUoTfJuICj1noIkuMRiAdA/MQATlJiJw5TzrlQeAaNBKTnU24m49RgzLOnuFbOr98ELdSiLlJe8jUzQerS+WJQxBSy6lHb+JE16vwuaZ60Tw/p0YyydJIWzqDCJWrGYAyeTVjzvU0NMk66vCRvk38lkS4izE3i8oBt2NYSTi5BgMm+a6CETFzTGFpvlSLsm9gZExrlEQCePMUo33btioN3Ap7PY+eS004fypEqbb3rAJLyRW5xretByWGrzJcG0xgeVuMPpyj3H5uhm+YAanIiscQUUQjKzjcbhT2BHh1rA9j4i6JIjv0c1Q0kXdaIcQoR39QZvQLT32ZMlF2hsEsWrtwKkQo7yphuRA5E+oLenMjaJiBt2ZXh5y1dZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmfGXRh5HxOdIL16vHHgr8Um2FXocd4upT2U1I6lwJjwLDsoDlJ0UDEyS3nH?=
 =?us-ascii?Q?6VNxwtIBNBIROxzCPFS8dgc6grzvqsOwJ2PkysRl0zENbmSDHk42ZfHAjAEe?=
 =?us-ascii?Q?aeOBllsPxnrC3rVyQJjHkwTZWv7n/OtJlszaA+H3Am8xYFK045ElUkcj4VUe?=
 =?us-ascii?Q?2UCu7VyCr3ksTWQqjQB2UaoZGgZItevbKlkIWQAaQoWzuozPUTqP3cxstvil?=
 =?us-ascii?Q?nNqp3vDrzOkS2WvIkrlrgPIrI+vmeox9CN80D0gXu38Sj8EZ4VyStQo3XG7A?=
 =?us-ascii?Q?854mVhRStp/WOTc+ff4OUjosOAd2QymNVb6idLuWpFPVF1tNqAZEsoA1jHoD?=
 =?us-ascii?Q?86evJs5hnOhA6O/hIZQuqmIFC9H0lmZqN1y/sdxbNtAgzoV87qcM1bYyIS0x?=
 =?us-ascii?Q?beWTfvrp8dKfA+Lp9i8Oi12wWs8GZBTIJDyYn9tcEtjxeNkWzYAX9QolPpex?=
 =?us-ascii?Q?J6VMpa8WfcHp6MStK2CaCbxO4R4pDjaN/9kCtdnvpy7Kcvm3mQP+45KEGoKS?=
 =?us-ascii?Q?xVrBq9aU7dKgeV/9tRusI3adjF8EqReYNa+bHCTNQrOZ8tSIz7q2shSu43X3?=
 =?us-ascii?Q?mC5K+9lc9unGglN/lw59GM6SKr7+harR5jcNsXgeEIZy8pPl5lsiLLkyCh0/?=
 =?us-ascii?Q?18M0bFDTq2RcT1V/8taDnTrQgd/kYpnMxypgRqDVk2T13OO5OBvszIlf9yRb?=
 =?us-ascii?Q?Ga7PvbzxhOBgnIzg9LVNgCSitB5bU1PNtjWlpu8/hdiKKev0Y1oLExCDk4nO?=
 =?us-ascii?Q?6CK5QIC1yID4ct0c/BypsXAtly+ygQxyruGpWNA3iFUSixCitmqjJx3o6/Hk?=
 =?us-ascii?Q?4h1P/bfORjqb2U2yGQNMSJqBPv0vH85MwdyY9ueBAjPqXnXia7uVMqPFb0pj?=
 =?us-ascii?Q?LfiaAZRcyJ8vP83oH+ByQnIC8TF0/wNFUYw2aWgZLWfqsg08bqiJQaRqsIvA?=
 =?us-ascii?Q?KeNv+72vgOXv1jwrFD2TPUt9crtXGvkXq/uzQkktnV9w+Ibps1QYIDwN/SqY?=
 =?us-ascii?Q?DpcNtQaqbTOWVIAymz4xVvmbbwCMwfuF8hQurvkNBv0D86TibhJCkRSX193P?=
 =?us-ascii?Q?fzDuJss4yQqI0uuO+sFOOAwMX0k33WtMYTfJbNMIBJLqLtUaUJ2U8vCdLc3+?=
 =?us-ascii?Q?G7QXUzGkLW4jvqLdVmqww1xWdEo4D1chAgcJPmPbjEDa6IjJ0T5sL+Y0ejJl?=
 =?us-ascii?Q?nGuwtL+BwjiscDpt9buQeD0i1xgnFr5F+2XRKKJoNvYzNbc03XKBYlzT7+wN?=
 =?us-ascii?Q?Vukai56Tn04RO0iaLmLxUVWHDuBP51AGpgzTkuoXo2yjat4FajMLWutyyTa/?=
 =?us-ascii?Q?/jGMFPleJLg1F51vLg8gpzgvmIe4hdwRWtVoW2OQLFjf1a39MWqd6AdCWyHO?=
 =?us-ascii?Q?syC6jtPyIOv1fRp/B9/L/UdMTP5qhEj4YlrEMovQ2OyTFyXO1+tVjBc75g2Q?=
 =?us-ascii?Q?cYBDpmGbdbv7yrrn0Fi08QThG8PCYMwlHS1nuqzCw0FNN2Dgq7jgwYritZEq?=
 =?us-ascii?Q?5hrTzLT0zDLmcXIp97pcbOgLgoD4XczntLfUleBYTLo78EXtCzqLekKupWo9?=
 =?us-ascii?Q?fM6dOne5nWUaS+ASZJBwpYnsRn5DHet/OURJ8aiwHHhpwlBkv+cIg/hMr3rV?=
 =?us-ascii?Q?irOjK9fFFUsLOIsOmpxTduvKI/vcQL4TssBhrBbRuGRbfLMKkWlMx9KJ1yFi?=
 =?us-ascii?Q?4tpDmkhALUctTo9EUzn5aqB1Ap5x8o2aeabbWXIkk94Gnm/NCGApxcR/SuQy?=
 =?us-ascii?Q?XlU37JOYxWznHW+v/nzz48m6pqQ+k6Y=3D?=
X-Exchange-RoutingPolicyChecked: o61QwRccVxreo4MpNEzsdvfTcyjlJccTWnmcSvm/rerUEzCnzv3VVdL3g5AeDNEoW7+y4wjzT/+PnimVaYo8wfI081b+FodF574tm7jnzyU5jfjr7S4UOooy1dAu1Qj9jag6lsTGiHJybkc6YlwZ070oqfKhJNPdmp4QOwYlZ6dPt3YcyfXdXA2M6a0VStHQDSxRfrnIud5xtwc1BAbr57KRy/NC2nIWeBAT09EoKc2QB1uR5daDqM74swLAZZeaziK41XEDGWVaAgdSE2+YgwTP7KfFbRuEk5Vvg+bKciG/30irMgk/i9X+7w+IQvNmMuQ8vbUzLfTRgW6KMWMR9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9e0172-5c00-4ce4-378e-08df13925f0f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 01:32:29.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G3/DYvjTI5sG7AgUXSjifgDi82msv1ni8D6ZZ78j6i337KkH2VR7sQwwDJj6Cj5u7R1rTXGtdRbpnflsCxfhYzn9gUnspRzTyhZCAh5+c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7736
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 03:15:09AM -0700, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
> 
> Factor out check for firmware ownership of memory event logs.

Thanks for the rename - LGTM,

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
> Suggested-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> 
> ---
> Changes:
> 1. pci.c: rename cxl_event_validate_mem_policy() to
>    cxl_event_fw_owns_mem_logs() and invert it. It never validated the
>    policy, it reported whether firmware still owns the standard memory
>    event logs despite _OSC granting the OS control, so the name now
>    states that condition and true means firmware owns them. The dev_err
>    moves to the caller. Commit message reworded to reflect changes.
> ---
>  drivers/cxl/pci.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4867657f5526..7b754af2168d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -640,6 +640,14 @@ static bool cxl_event_int_is_fw(u8 setting)
>  	return mode == CXL_INT_FW;
>  }
>  
> +static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy)
> +{
> +	return cxl_event_int_is_fw(policy->info_settings) ||
> +	       cxl_event_int_is_fw(policy->warn_settings) ||
> +	       cxl_event_int_is_fw(policy->failure_settings) ||
> +	       cxl_event_int_is_fw(policy->fatal_settings);
> +}
> +
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> @@ -662,10 +670,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	if (cxl_event_int_is_fw(policy.info_settings) ||
> -	    cxl_event_int_is_fw(policy.warn_settings) ||
> -	    cxl_event_int_is_fw(policy.failure_settings) ||
> -	    cxl_event_int_is_fw(policy.fatal_settings)) {
> +	if (cxl_event_fw_owns_mem_logs(&policy)) {
>  		dev_err(mds->cxlds.dev,
>  			"FW still in control of Event Logs despite _OSC settings\n");
>  		return -EBUSY;
> -- 
> 2.43.0
> 
