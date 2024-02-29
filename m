Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A07168AB
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166912; cv=fail; b=BCw0iSQBU5s4et3BJshqih6wTuO+YzUDueVsxo9Ivfyp6mAHoaz64ByiX5WyFAz3No9sQanrw6+k81q4WWBsROfb/gAiMM7nWf5MHKo9XJeTU7tCpqV5sS94OdlqeW3TgR8fmQkhEA9OF0WeTnmmZ0oyzl7BezOCuzZs58KZh4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166912; c=relaxed/simple;
	bh=H7pr+kwZVbiFQdNc0jCc+CK8tZhWisUhoiyNPizs+/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N+thjvyVfSMmz/r5kZtylHeeoDFrmzHKRrr3GZf1ah1RlJ068MbFmtJb1wpfOoyezNKFZ58zmty+nhnGj6qMqcAXH8ScuJTfArQ/A/4LVHhSQIxKG1zWVtN6VkPr5ZtT3ljQAVc0nMkv0q8CLGSdP1UyYUeEa0DWR4NQhWWZOPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuvoClR3; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuvoClR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709166910; x=1740702910;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H7pr+kwZVbiFQdNc0jCc+CK8tZhWisUhoiyNPizs+/s=;
  b=FuvoClR378OJH6Q/xIpAmn0B+sBEG8lhbdUXrUVtAYv25wC+M9NthSIl
   jz4Yx4+ao0wpIUKfkB8hNy6GXseEZwRPa2mDJc4WcaM78gMlnWwl4ykGq
   jb1fq5NPlIXn5jHZUn+1gg9Y9eWR2p4pIaA8f14PZKEigfHy+dF7eFiZ2
   5Hy1OI+nWwwD9RUSgcSUQBJhDzUiR7ZwOFQO1WjGcxe/zO18riHyHoMHn
   YnOfacA85xXqiyHBQFrAhcOj2bN74YZQJVowzniXM0XLzu/mYz2LFL5Tl
   wqzvau8qMdaJ8xp5H0Badfe9R22AYSFmVuY+bkAF79Uf2F20eBNOXy7IA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7439904"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7439904"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:35:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7561906"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 16:35:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 16:35:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 16:35:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 16:35:08 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 16:35:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wg8zkgX78SZh0m1R7iHOwWRyKCdHHOOTEkfrnuMA+nsEMhWJDWBvHCJ2vu1sVhA589g7LJ16BJgqYBD2FrDdUHGU0Is84bCGFbqaO1okX0KGzo2XfQFy+O7ff/c4c3QrQxBcrnulggbBvj4PsesNvLyCUenDmrF+prorqA4/x8pMzkAiEjFdEidGJA2n67yFvBRDBU6niM8WXjv0rIfb3qXbeEODrQF641e3oILJVg8voXHK7rG9iMDzxmEIUDCdYxNb9iUWC19Mepj2nFwBI8VJob1GJLEHJBmy8J6Cp0/YmB+29FFXJovnT+RWuPpehoG0iTMCKATYdWeRqsbCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7pr+kwZVbiFQdNc0jCc+CK8tZhWisUhoiyNPizs+/s=;
 b=Pa+/3xcQ0xSEDqK/1AxCdIP0X31Kk6W1FAoSvXPcpy8udRsRXa/0LGbCW4hBwL0gDxx9AJ0r9cfyti5lAt16din6olFDnF/UE9WFowRNZpBOOqKybGKl9jDfk7CPyfCRRzVbmCnU/C9c54i5N5V7fwqo6IoKxGfvJG6iFeNMi7jXSVhaLwfYoiV93ML75OQGshmSwyJHzqUs9R2xpnBZSXDAtn6tk82Y51m0VSG2glFud6FsUkJcUXzn+QYOhX5PqzeiPimbKI/1+OT6T1YkVppCK17BnDdsvzaSL/PAepQGXoNH5fycpJqfNyFii6VvWReRPWJY/GMj8c/sIZhyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7838.namprd11.prod.outlook.com (2603:10b6:208:402::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Thu, 29 Feb
 2024 00:35:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Thu, 29 Feb 2024
 00:35:06 +0000
Date: Wed, 28 Feb 2024 16:35:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH 2/2] cxl: Add checks to access_coordinate calculation to
 fail missing data
Message-ID: <65dfd137a1406_1138c7294dd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240229002542.634982-1-dave.jiang@intel.com>
 <20240229002542.634982-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240229002542.634982-2-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc6b257-5375-46cf-582d-08dc38be46ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTmR2BxsqzS3ixbP9AFlbSTqqXSIkwsrg7swOf0nOlgRqv2peUOSbmXw09FCHBsZpGXwNdYTxQN4MbEPQmK/+iOGIudp8mIcky8QnCHVQn2Fv5S1e3to8s3mittuKIJGu2n9n2QNhiq0F+27o84ufWnffjMDoqJD3CA6KsRuk0xc+7OzEMiQ1CL1wiNeoz9xpdzecrMNzlQM13V4+UUjhGz0HaKBIku5rP68wTuDu9+5pY/AHlFLq5Lol9onxioQnYrsKuFc8EoWqgqUbLW8vn1Mu4wtCqY6EZfiEHeHIDp0T3ETzNyC+BRspVMmdXvnIYxEqsoFd4Q7DOcCn8m13sLOHTzIdTeO5mUXl9o6nBIsJXITF1DmGRxFOY4GebAhJ8YTY4g5mJx2oOS25TJesV8YB5WNj+pJ+6pt/QUZWWRCXSV70yJKv7byzDQB7dqgwzDS0Y+4+WnukKKmoS2ATJUAR80hLabS8DihCNh9dvo4o/UDDMERGczaHNSnmXUYWaEIcJ5+WLjL3HmkwbYQsppMBnzVhZbpQZrMXybWzzLaB2Fw0UUaXWUnWVTOPidl0B6KgxQD8BpOWlp8Qpk4+BpDF8Pvf4cTPWS77ezBngKRbHcmjsW1HRu2fB2tby1/cT386HAEnk0RvdgBFM0jkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pHHeFPUzR+KL1A9cvJW86C+tfm4wBqK85u3JKoe14VIZ6aCfEcQlpvvBNUq4?=
 =?us-ascii?Q?0c73w3VB9laEVuWY9G5j1ZR5l45G2cXXUaC/mGyzIUoN4dAH5LE9i2JG7fiS?=
 =?us-ascii?Q?YfVf9klcxrNfo6qpKif+BJ0sVSxOzfVqRIPvYEHJ62jN3fkOmRiQ/6yHq48i?=
 =?us-ascii?Q?XI/exn0QOTEIW00NhLc2SbwJ4INM7RAkv6q5H9Sj9JOzDlU1sQeZn6z10BOp?=
 =?us-ascii?Q?YGsR6eu8opMeJXgpiPsxoP2hso8snqgVueMFxuhQtEHNH1B4L5BQ7smJ/Hyz?=
 =?us-ascii?Q?k3RoKOgPmo7Y3Ewyi6rcOI08bb68nx8KDdm0Y9+YNalL0w6fi/odS4MwXO7+?=
 =?us-ascii?Q?HScNK66jihpfyxH3BUvbIOvwiTKgiSHfRz4E2IZIGvziHYDjF4tfwhI+BHgF?=
 =?us-ascii?Q?RUnO5pmT3kaGf+BQT9z29hj01J7j/Pro4zd87vDMNTTTrb79/HP5NCOgl3Ix?=
 =?us-ascii?Q?w9eCJsQI21JuzOMrdMD5A7+BZLvuhI6aU1onBcwDu7/AxglXiCzpGltj/RvI?=
 =?us-ascii?Q?IkQdIbqGoNcxevaA14ZCnzu2Ixxg/3ZlCQyZf0rfKbzFF/mqqOmI4sRGT6Fg?=
 =?us-ascii?Q?Nnbb4K2dv681LU/JSujOjpoHRQO2W6iRxKFOjY5S9utqKoIkymP+I6u7ZfqQ?=
 =?us-ascii?Q?B6nUaMGJ4HGKSaYdS6GInaFJ2SctQ9IbNct3GRObbGC4r+M2Nrw2k9KMA4Ye?=
 =?us-ascii?Q?I3e2Jy6gfSoPL+uceYEnBJRnKRWz4w7Jz4E+Ha7vx7qducFL9fPtG33i3gO5?=
 =?us-ascii?Q?4CLaNVNcOj3Nua+L55hDCDFLVyXuDI41Er/7z1mksYwYBnytCJ6x/3lJDYrn?=
 =?us-ascii?Q?jddiB7sA39TArcfRuYpN3ODopdlZJ9WXVwelgPdniB2clMTJfagEmjVtg2wC?=
 =?us-ascii?Q?kGCBPaSnAMAG4P8D94xsT4tTurXfBOB3lsKVDrUqBTRsr/scqqzj93w3Oreh?=
 =?us-ascii?Q?B9zftMqT/UV579YJJPT3OTaF5BFvCITwoFl1DEu0yMVmYIkF/McuwcdhmsZF?=
 =?us-ascii?Q?LfRKJ5/jdGVCZeJvBlRQwvxtzH+YwUklyOGx98GXnacFHvO1bsMYPHFiHAxb?=
 =?us-ascii?Q?08xdgpToDpRMLlLNVrCHvkWXBdGB3DNospW+GHmd23YIR22YvHxzIadx5jvF?=
 =?us-ascii?Q?2EcYCXAtZgFy89oLu9xOkeePg8jtYysJMJdqJj2ARPAzaHg8FHgUn+91x9w4?=
 =?us-ascii?Q?wVDoXVDE+PSzV6jT8ElAoypjgyF/uq0RPy25uTlXzhnWnsYWXslkbqon50E6?=
 =?us-ascii?Q?SMcAGEjk8V+VXHoJnjQGyQdYFD61G61yzDue5bwtvMZUWfdMK56gaTLJHk2x?=
 =?us-ascii?Q?mpiigcYlb91ORIS7f/l7RcuTnRYZ13ArKaI1bPCShmJiT9nGfz4v0AEd2tSZ?=
 =?us-ascii?Q?5eIzCFNXilHu2yvBHxYdm63TUBJZfkUiqcnRvR6Qe8iQtPBw+7zjpkh/NBBr?=
 =?us-ascii?Q?4G9MmpJge2U2KWIDnzZQjDQaCyoiMu+vR8WrYlbeXwZjdR0YqKXgoT5E3ewK?=
 =?us-ascii?Q?bYJX6zjzshvGBaVkHZjWvZjMh6ozBr6+v3ZcBe3Mgkoz9s/6oN2L8U2IBHQo?=
 =?us-ascii?Q?8RkhLbSgLKpwoLg0berJnD9mrPvlM64uhQnvRHjZJCnpIUH/n7BcRcgl641k?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc6b257-5375-46cf-582d-08dc38be46ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 00:35:06.3834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4e9St9EB3N1fYwC6szPzdUy9XW9+0YARSowDdZMPFOjR7auyKLah5MQEPjcsCj9wJoQSI1G0I53NzxsKk+20LT3p0zyzSAw/AA5Ivrtv3a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7838
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Jonathan noted that when the coordinates for host bridge and switches
> can be 0s if no actual data are retrieved and the calculation continues.
> The resulting number would be inaccurate. Add checks to ensure that the
> calculation would complete only if the numbers are valid.

Similar comment as patch1. This smells like a fix, is this an urgent
thing to get into v6.8, i.e. most configurations are busted without
this, or is a nice to have fixup for a QEMU effect that may or may not
show up in physical systems?
