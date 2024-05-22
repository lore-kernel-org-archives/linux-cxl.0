Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD864C62
	for <linux-cxl@vger.kernel.org>; Wed, 22 May 2024 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360348; cv=fail; b=A04pTdj2ESfbA+i17Frppfa65ahFLLiUPbKUUvMws8kNsG7sh7Vb/95Yhoyu+AhpzLOyfROn2L55ZFOtw5Jxoqw6gTyxoRQje7zwPBMXzj/z9bHr4Der+brwuouw9aHAjhodSywc4jRpfJwyjBO9b2B0FnvwfudtvpRgwKr/NXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360348; c=relaxed/simple;
	bh=Pk4bgKp11al9L8yNCuGsHKa8iJyccSS4bb9S/2JM+Fs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ndSyFZfkjSVwalCQ/LFwJNb3g2bSE4iWNiYFNYyJ/BFQerLDYoZKAWvclKWmGNKCXbAMJFA8zc4sJfmFTOg39Fbdu8eIqepSP32anIbkKGwf8RixNVOfEp3WAXLJ1/vxrMslB0RHr/HKx4FA0AAloPqyMKzE/QQ0KS+Cz0IvQ2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwMjDlnD; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwMjDlnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716360346; x=1747896346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Pk4bgKp11al9L8yNCuGsHKa8iJyccSS4bb9S/2JM+Fs=;
  b=WwMjDlnDgFFVns9fBxyZHmRR+86ZtaiM7qdK630MpkUnNcJGUDP+L3PS
   61v/1oCQjfmwCcbNU+HsSbUt9h/+gzoPqjOXbtxdPrP2+gYwXySqpEhEI
   97obbYigL3uxspWboBLP5PKwII2umiLGmPZevEVqjfCV0OjQmsvInUJnj
   Tnw9b5TbF1qoTIiGjFun620E4nhmjt2+LF0dtgv28Y7Cpd+tlYRoO84nc
   UikwM1SJght6vq72skNVJnQCIPk2ds6ZZAWVIhWmyvBD5rt1JYvavX4pN
   REbQ6di1asSw5KVm0j8n92m092bKg78i6YkAe9FUZV296iITVQSFs3/TC
   A==;
X-CSE-ConnectionGUID: MXhJ4RzuSlqvZevJr4ShSQ==
X-CSE-MsgGUID: uMvJvtkYSpCgeG/4Tf6KfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16380121"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="16380121"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 23:45:45 -0700
X-CSE-ConnectionGUID: PwlkXpqrSsK4jut2cpZpSg==
X-CSE-MsgGUID: 6RqAT16aSgOMelyiZy7hSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="70588356"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 23:45:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 23:45:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 23:45:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 23:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+GYjm0HDGAPHvdFaREkv5kovAjEe5u8fEncxf5t00dySbt4pbyoZ0iHzz+/0p/PhNxo8geFWpZvm7In1iuR6BJoDRjPzqvtXoiDsbbOSbC+ox0qioirz4LzAymweoBFl3IWdJODM8/BkD1F4IUpi58Fmlo/CNEEmXfJa9wde+mxUYdUCzICPfeP97b0EjmDuRUfqSHBffOXkTH6MDLVTQ7zRVAuwPhocRmNQ0ZKqM6Sp5bGaYWdlJLgp7/krJT+JKYqRO1t5bg4w0J749Fy6/mOjqrgp3vQcZQhFdJpWXDySulKI8mlRGQc77GmCFt4TYY5eo3q6gUW6ewP0lgXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4BM69cSC1P1gWlraK7QA7svPFvzBtUyuLEpgOQKgSU=;
 b=bYt0Zqs+1SEyf9FjB1yMxee0jsgE3WhOPaINuxeJjLUU40MvyMSUOZo9QMc4elZ3jqCEiVRyCyzPmuQaTvwHG1vVyqVPJ1Pll6hUD8YJw8usmGn7I4Oru5huZ1yi8yfTTHaZJy/Ppf6Q1epnetVFRTvTaZxNavS7kDmnD8fKqSjp4F/V0/IkKG1PI50vPHMtwkoG5FalmWUrrwSEHut+nvsoz8qdLVVyXa//bQ5BWAYESAzHg+cgYlD94IGOm8aA5ZflIeFGIVjGsLVFaENqHS/USz31f9GQ+si/9aWVBKdfWQDF/lDaQviD695EhtCJdm1pX8MiIbwWCVox+cw3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 06:45:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 06:45:38 +0000
Date: Tue, 21 May 2024 23:45:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
Message-ID: <664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
 <6628008c39e80_a96f29415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <b5eb1017-5f0a-4d68-bb63-41e628706a78@fujitsu.com>
 <b14ed74c-7fc5-461a-9c5f-fbb94df50e7d@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b14ed74c-7fc5-461a-9c5f-fbb94df50e7d@fujitsu.com>
X-ClientProxiedBy: MW2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:907::28)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d8c9bd-f66a-491b-d63e-08dc7a2aca3b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HXxLaQJDTGjDIt0qbJQaZTGOSCPTMJPZQDqNQelyvPwIBvlKbSOqRi0DkZNN?=
 =?us-ascii?Q?O9UeYvACdK1GBf7wlPChWD7ftrBRHr2GgVcpQ7Nd/nyp6IJlyOc2kdY1gU6I?=
 =?us-ascii?Q?qQhXS+34ikdRwyNN4X4hVq6+/86kClBMQBCrwXScSZ7dWEluIHZ+fzqGnJr+?=
 =?us-ascii?Q?6WAGoggkDdzLjhDHSBGol9q6Ya8Tj/UExz7ldEheQVJ4qZ3Z4Fjz/AXW/tTc?=
 =?us-ascii?Q?EBgsZcvDfPJ8vjw8gYbNorDriEuf1byHusCbjXV0wMghQT037JmotGsXHkM1?=
 =?us-ascii?Q?5bc07wCmf6MR5cYdzfZTgNo5mz/8STnfJcJ+0rbwjTFsjjYqFxa18OSRaQZc?=
 =?us-ascii?Q?aO26UvuhQuI4jCWYFcW9kVg8hlLQ/1PHTnW7JBGC6ZeUxoSOWcP7DjLnuZVV?=
 =?us-ascii?Q?zTTF84+F/QNw5azJGRL3Uzo22/F+wgQajiDPGo3kuP4ozS7Sw3UARcmtS9rD?=
 =?us-ascii?Q?1QyV2PeLa1/LtxzmsxVR9B/L5cBGEsjJxaviBfqrRhd/XuWW1VJnenI1JPDC?=
 =?us-ascii?Q?PbElWd5kMacNlgFI8zmewoZcREa9UQIJgz/gqqv5GU8ypzP+1qvM4b66J55O?=
 =?us-ascii?Q?+oH+5O2dAZD2WZjvooVOWQuPPtK4vE203BEf+kh4IfjG5TV6m5g2G3GeHzdI?=
 =?us-ascii?Q?TbUT4uzBqQNniBU2AJOw0897u6lPocRXO+Jq9yjNBsFdTnba1mDobTQlocM8?=
 =?us-ascii?Q?iY7cP39Rih6EBIBn4XbZPeskHGRs8sw3FO0gYibx+0D5ksc6HBtU3Ec1dSDE?=
 =?us-ascii?Q?kbp+httKhLEEev6eWSeANVmMUUwlY5+klMe3P8r+K8RGkWbL3bEgNiWPDV7C?=
 =?us-ascii?Q?ea4X+OPOhyJiunWcGo4RRj6TnMA63edc/+xvpqqVoc61wT8rq11RWhX1r0Q9?=
 =?us-ascii?Q?JMmpR/fbAbHwYIok15lqzX0QI02X2VB4iyJz6xM0CVh+JabxZep0dVGjIM0e?=
 =?us-ascii?Q?tj4QJkZEgNNw3iJmupoVHN59QcQc93lIu9BK53Nhv3SYi+SoSZkCuPpSEYln?=
 =?us-ascii?Q?UulY/QP0kkmhbQXVXdMn4+1bOyUv5Ae4H0GFRPb0fb4gCvozUj+6h9zUhQXw?=
 =?us-ascii?Q?v3LbMts3IYxg7QWNO5YlTh0+xfWJpdWbWoAhQkQeFGOLWEdvD3esyRpwgVob?=
 =?us-ascii?Q?Uwmo3FZxL4jBp7UGym3FkdsjYNWMue5nRcsfCwfgTNxjVgXwU/zsQ4XirgwJ?=
 =?us-ascii?Q?Og9g2srYlBHxLB6OawHXtmwTNaPbj/Ox/A5PjA0SNojg8pFRS8SNF7c4PybY?=
 =?us-ascii?Q?1z2G0P2Uz/8hFnfU/AGLKDSHQrRtKBncAWIZiEhYBw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZwSR+fpERxWiJUwaEC242mznJqDpecApKHdsNKXcCGf9EJjifcpLUGVSbcoY?=
 =?us-ascii?Q?CAUj3kgKh+FeTasVnCEXth0eHuPPrVfgZ3+ksoc6EvKn8xk9gr9wt/uhb7Eg?=
 =?us-ascii?Q?ASkBJIZ+XD7Yf44bDVaQmG07DC6HIwSdIbcAuvlXJrc1LNI9jUJOJR2z77ht?=
 =?us-ascii?Q?0XDKIckO+r0/tAwNfr/MeA0xojYPxK2KAF7RpAaqOOx5zWVW1ffPbf6M/Qvd?=
 =?us-ascii?Q?KXs7qPD3PpE3khTWhFI/16DV5Vzx7stpmcOdyY5R8OfVWFw7tdo+BasijO4T?=
 =?us-ascii?Q?He1iekxR1WUfwfboMhtmp+aJgntJaFjJzsRHuCuS+q7DhSGzjFMP8AoKr74I?=
 =?us-ascii?Q?J+RsrL74e8h1+qprsgLdGi69jvBvwGBNUiKOa0/0kheNWyLQVInxrDFOCKvp?=
 =?us-ascii?Q?o2qfFPydYlneUvM33JmS6F8FeTTaqf4f4FSB19golOBo7YLnNVbXW/GaMsRt?=
 =?us-ascii?Q?lyU3XSUR1BjC2JvW4jFcx4NxG9nyple7J9Jhc2A3FNVjBUkP8aGNco5ZNlpT?=
 =?us-ascii?Q?CkF6OzNj7EXqCbizGJLWFkL+8zC9ln6o6oQKUCMHfhuhZ6YT4hLaSusJ6Jvf?=
 =?us-ascii?Q?N+G8WY2eUohZFooLlZ4HIQHiZz/+3QuPEgJs3MBAQs7URTS4aK1b8fKX0idh?=
 =?us-ascii?Q?S/8ypHWisKYR6tXMjLTWYLYUEW76l0ToHpuC0+gdd4YjX97APpJP0+Wlt1iq?=
 =?us-ascii?Q?AY5h4S4kHb1ZG8hmttYJNRz8/SfeMkjK/Tvmbkxf4yvVjr7VDlqDSmHrq08C?=
 =?us-ascii?Q?OF/TJZ+GfMSSLq5TEj1Bv6Rkt2fjy+HvtkK0gEP1OP1CZDEw7c/jcqGaG+5F?=
 =?us-ascii?Q?sNMyqmJFuSf19yPijmENkq74Ac6c9BS7PA/9GTJcdtrpiTHthrSyFTRgWQti?=
 =?us-ascii?Q?3eeTTh9MY4m+7LrMHParhj/JF4bs58mfgsti48/9hdxiuZhHrklf/XX8rGab?=
 =?us-ascii?Q?p8GrFEApWZMrIW3kxPZAVfx3YyctAcxMRepSNWNzwag/dNgS1GrEG+aYS/JX?=
 =?us-ascii?Q?HWgPGTUJfnNijCj+IFrxVDzUKQLQMzWu9zS2iqyU7s4o0+A3b+QsELuROWIi?=
 =?us-ascii?Q?2Ii6dXC0Fm7+yAN4f89m417r12v2KnOPaVcdDjUEcTaBnnIS4ZR6bQUSGURY?=
 =?us-ascii?Q?BqAXh0jXhBjv2oRctgzBhl7w1GkSGnmYjkt1jn0OTXkJnwSHuzvD64g73Kev?=
 =?us-ascii?Q?vHZduPSAPLlovdrlu/ZbxiWMLKCEIDfxAAVp5+PDVeyAGKUi+jYNMmFrwcD7?=
 =?us-ascii?Q?wk3o7TLt37QRaX51sQZzT1wKztDULqh/Ig1I9tqXwEO/0zwZHygoMFePP/+t?=
 =?us-ascii?Q?BuCb2YP3iulhabXruojH0S7ENZW+ycxHjtfnX69gkX939IdphS6cSaSbDuPQ?=
 =?us-ascii?Q?ToucKcV018fNVMIKOQAhkyxFmuDp5srUpUlz4F7K6D1zMudDWl7kVyUqw7XW?=
 =?us-ascii?Q?MDGn2v7n9ApTN/2p1ally4ot+jROwi78b8KAF6tWxVTiffSNnyF5eL1m76z/?=
 =?us-ascii?Q?378998o+4Sr9tyPg3ljWFU8JRs9nhko0fY+BthSmCgHVHgA9ATps+7GKvSVs?=
 =?us-ascii?Q?jB20K2O+QzZEJmIhKLzCph5J9jGan2VFYpAGC2gQHj5phgpHfwI8C4b9T3E6?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d8c9bd-f66a-491b-d63e-08dc7a2aca3b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:45:38.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nePdgM/jduMblouTEJYmqL3JEpS/JwDqsIjR4UcHD3xHWLomEMUBubwGlX4aDcgYp/TI9FXlhjUUSpoA4MrSYIi7UqvKC6BdqCXeE5+04tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
[..]
> >> My expectation is MF_ACTION_REQUIRED is not appropriate for CXL event
> >> reported errors since action is only required for direct consumption
> >> events and those need not be reported through the device event queue.
> > Got it.
> 
> I'm not very sure about 'Host write/read' type.  In my opinion, these 
> two types of event should be sent from device when CPU is accessing a 
> bad memory address, they could be thought of a sync event which needs 

Hmm, no that's not my understanding of a sync event. I expect when error
notifications are synchronous the CPU is guaranteed not to make forward
progress past the point of encountering the error. MSI-signaled
component-events are always asynchronous by that definition because the
CPU is free running while the interrupt is in-flight.

> the 'MF_ACTION_REQUIRED' flag.  Then, we can determine the flag by the 
> types like this:
> - CXL_EVENT_TRANSACTION_READ | CXL_EVENT_TRANSACTION_WRITE
>                                                => MF_ACTION_REQUIRED
> - CXL_EVENT_TRANSACTION_INJECT_POISON         => MF_SW_SIMULATED
> - others                                      => 0

I doubt any reasonable policy can be inferred from the transaction type.
Consider that the CPU itself does not take a sychronous exception when
writes encounter poison. At most those are flagged via CMCI
(corrected machine check interrupt). The only events that cause
exceptions are CPU reads that consume poison. The device has no idea
whether read events are coming from a CPU or a DMA event.

MF_SW_SIMULATED is purely for software simulated poison events as
injected poison can stil cause system fatal damage if the poison is
ingested in an unrecoverable path.

So, I think all CXL poison notification events should trigger an action
optional memory_failure(). I expect this needs to make sure that
duplicates re not a problem. I.e. in the case of CPU consumption of CXL
poison, that causes a synchronous MF_ACTION_REQUIRED event via the MCE
path *and* it may trigger the device to send an error record for the
same page. As far as I can see, duplicate reports (MCE + CXL device) are
unavoidable.
