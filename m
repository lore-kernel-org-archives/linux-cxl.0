Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206D265288
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631540; cv=fail; b=NEN906GdV4SEve7hHW0qnL37+CpOrI13zNah5GPHOQ6YqPR0uo5oUS185CO8xNPFwBcAiey4ba0a4owABvFAIuW0aQOTIkekNuT5VheFU2JBbUmTvvjGo0lPIyOQ+fVTXD6fXNADU/xTFSC/qTnolrs9TSDDUvPuBSFP+rkejak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631540; c=relaxed/simple;
	bh=bYcDzOMrWkDy/Vmi5oax5QjxLhYZS2eLb9D6rreUo9I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fYez57oN5++J4hT6K0eMCPhf4aQU5MN2shJQglAfL4VdUkYXNM1gthrJatEiA8GZeEnWFN49ZwjppYNBEfjzxLN2bCAIXCymoas5lSCu3opBZ4mIJ2ohJ9FsBKImNzlToHfRyK2aUengjfV69qvNTPNreLfumMX8R4bTMAaA1UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ol7kGJb4; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ol7kGJb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631539; x=1784167539;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bYcDzOMrWkDy/Vmi5oax5QjxLhYZS2eLb9D6rreUo9I=;
  b=Ol7kGJb4Eqck60cl6rb4bnQ7yqkfxuBFjAmUmLXiTrxss41/A0fwYiVt
   nZny/b56u2WmLDjdltsnA4qr5T2jP5IqkIzyAVoAMSbiFWRnygwoMuzXa
   Ioai3bxNfr8OjLbR46aIo/e0ZkXmlC7UNet3jARxKd5T4AzbuVgnGysn9
   nZ/n9ob+Uv8dtU0EtJXmFYRxQBVItiKvCFAEPTrrecX/96QbTqTKSZgJ1
   kQ5SF1eV2s+Lo/dKSjvMdSgISkM6Wc3hdWAaPkU/3OYIwJkhZQG+eaAim
   GblWtVD1PLs4oMbBA6nxNULp5pvzTE3D9HHSEEGqvpyUZB8p5SzZ42fNV
   A==;
X-CSE-ConnectionGUID: HC6AG029Sza7lKsP2/Gupw==
X-CSE-MsgGUID: AZh407Z8TRmtfFgqp75e/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54575523"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54575523"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:05:38 -0700
X-CSE-ConnectionGUID: h07NVotBTYOVr7T5IBx3jw==
X-CSE-MsgGUID: jQWhFIeUSTCT5+vSpYFGgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="158097473"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:05:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:05:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 19:05:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.88)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:05:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvaW+urVgGkBE+jxlAq/WMy0OMcogG2+LTujxDv/ZF02RJ+fO45u7H0KNw1FRUPMOR751H02eQqDrt/r13GUWRw+K8GXdtGbCIO96YzvpU3Yz3mp+TOJzaSYFBVpcW2ilkeypz7mtumvtf2TqTBVDlM6W28ZYCwGtEWEdfodQs3kQ5SLD1iSeC4QBEwNIxqshMR3qKIScaMqiNDLv/keP5TZ0Tr5bKFA4p3U0x7k/Vh4naHKjfxUcJB0oROZYO8VqtqdK0G/2WAKYmVgPq1BSbaGPYEvT3ht3aXoqX13ip7jQ8DTqZeHEvTDqjVS7VBzTywdRzK2Y2rg1WE2MHf3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFJFDGNtEcwOvcu7K813DVOIzxnVlLnq8puf9eF3QQo=;
 b=q/cmlNMzCxTkI3+L38bznhwBYk74nH7gaGv6ZBXfmxDGUpSik11BpdjI8kVUabuEXtur2HiSmqcqPL1Puib4EixVhJgANycEYUHY09jH331x9pDeDsH/nVRJrdT6tzQCQXTLFcPWnwkljeDhyIHnP5xLFdqFTktb+jC9/igdJEiiZ6OPx4kYe+wdLEI+wdGXHmYhwwJV+UO/SWuXtR4BIUJWVGSMrTgmzP0AhEQe3fvtdgUKuSOROOkMk4ZX2tsA6KKVcFFTBY8f5jKIXKdcztFkVkrF87F5YLZ0MOEH0M2HAyGTMs5oq6WsUqiIG8LX32MBiT4k4O6nbY2EdTOvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 02:05:26 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 16 Jul 2025
 02:05:26 +0000
Date: Tue, 15 Jul 2025 19:05:22 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Gregory Price
	<gourry@gourry.net>, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v7 07/10] cxl: Change sslbis handler to only handle
 single dport
Message-ID: <aHcI4lQH-PBHGQ1W@aschofie-mobl2.lan>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-8-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-8-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:74::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: b40818ed-48f7-4e53-7dbb-08ddc40d3b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kZfLmpOTrd8/KD7JtrpYYYbsXF94wMQkEj4G5h+NkLz4MvOJKap/wiCmdNae?=
 =?us-ascii?Q?yb1kkGNwDquu4MblVipkve71YDNdEOh8BoqKEiqRGa23MBywU7fy6gvEzE4J?=
 =?us-ascii?Q?THZ7XPdcCypmvS3ULpDKkIrY+oUWVkv0yEptOkQOPHqkzJ8yJl4NjQ24XG/O?=
 =?us-ascii?Q?WF3r6APYPXrHEmbwAcGnXUhlI37FbugZfci4ECTm5vTrMo80QxBH/0GMveR0?=
 =?us-ascii?Q?KAeONc/IIOfae5fQurCYxZy1KWXMcH5T+Mk8N7SQ7klKMUEKilKpNErxiujz?=
 =?us-ascii?Q?4pGdKOdb99P2H3mWIdpfnjeR6QC4o7BbHPAinwmiVopLxjxD5Qob9A1/3vqo?=
 =?us-ascii?Q?xSkVUutsK8W+qOuPSrIGdntQs357Gcp+jcAxawvhQ7EErsO2+X8JMJNmH0Ow?=
 =?us-ascii?Q?g3m2fyRCKuzagHTa4sIHyaCX4ie/X8V/62seE7rUbTkq5/kMlzvkYAwCGcTK?=
 =?us-ascii?Q?6mcD6R01YAyMpn8YQOPJsaBh1kgF2Epgnm5w0/5jI7NL/JZYgULRDNgD0Bpa?=
 =?us-ascii?Q?eX9Yiyl/6YnXcwyY8Ne0hG0JNxjH0MOcwFxGEpUHqlNT1UcQy83vmkHzgE5Z?=
 =?us-ascii?Q?Zbuf66YMbsNZcd9kgQEL2YlMEZ+eA4ozmFVZd2xg4ZcC4N5a/0Ohuslvn36u?=
 =?us-ascii?Q?FU5NAIt66pnmo+7K0CH/44HINdqMWs/fmd1plgjnOpP2Xe4o2nT6WDFF7Ete?=
 =?us-ascii?Q?L5LiiYf1rl+WkvTqynTr0ZzkqWKiv8tRvmfnhe7XfjfnwoBQV3DLGDRhfUMh?=
 =?us-ascii?Q?bGkF3GtMaaB9b2fJmZmXdsJYLDtGP0feOpjrOq9Swba8c6WEKBn9+MQAoFds?=
 =?us-ascii?Q?StV1eZNb8R0TIqbGGN0psGOfzPUBT+7cJ8+CjqZ2H9i+SmgXDgblSCE7eNzr?=
 =?us-ascii?Q?GgUSk+yMYufJHAoeM7RNSsnQGykvMljPdCtjgYyjyzBEgd0RDq3RcMa/gmb7?=
 =?us-ascii?Q?NH+1lxKvDjkd6EbaBpX20iH5uATKxg6KQuAY5ANspBhxa2bROR2jUueN5nue?=
 =?us-ascii?Q?zsH1dDeOSpW+0FaBsjViriU6WDAXJmMJhcQlGbd/9XmY8F67kFri+BQ07uch?=
 =?us-ascii?Q?ywJqcTWfC6zXTmPIwHymjuiHYHhn0cjIChSjZd1dk8MIim672Xu8srwi66VW?=
 =?us-ascii?Q?g98DTurhSN4m/L8PUq3mCZ4pMABq5Qld9JE4kjigf+YWnGKHbYQ0BFhrPBGw?=
 =?us-ascii?Q?vzfW04J71L4j+tIRcID0JAhNSzwoC63wn4TJ85t1ZtoasIForJWaS3H38b0q?=
 =?us-ascii?Q?fF5hiHBhygFQnlGbnaIlq/riSNRezWdKU0vpJZMvK53xgYfDVzwArdABVK0R?=
 =?us-ascii?Q?xAR18kJD9RmAPNk5TOVIHi+vHmuEL8htI5C77gmMFh6oopkgBrDMabvSTKml?=
 =?us-ascii?Q?kSio3DAIdcvqcOK6ob+kHEV3BRJeSjKc8WyDIn/YRvWYR854zGckF/bR7EyA?=
 =?us-ascii?Q?5ndg83tGoI0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FNNjIZ2UTfyl7+cl8ez96RdHXTtZ1vzkQBVbXuVty5VFyeOq+RVWdSf5RgFF?=
 =?us-ascii?Q?FyazFvvJhbEEQfy6sjr0+QR44kbpS6T+XdSKQOfSX9A2/UxG3HrthM4/PgXl?=
 =?us-ascii?Q?tFAO9b9fjojONqHAxoPd6H6O1uRsmSrut/sJv/kg8X5pccoC7Y7XiEqQn7xl?=
 =?us-ascii?Q?CjTdHwtSzO4j5ngbUn6yHEDFLDNyg4upBBbZw9J0X4XDq6O5jifWG/KNLF3K?=
 =?us-ascii?Q?AF9NrUjqkCF8bibkDWrRoCOVvhS4gdPEHjXMbGu1BBrWE3ROewPRVaXQRNr0?=
 =?us-ascii?Q?S3Kl9dgGaMBIZ5jJg90e5qVC2SDRfnEgTUuzWQJzQtoRL8RHZT4fQv/xxcLB?=
 =?us-ascii?Q?y6JZQrafgE61spVcsN2bEBX7/xhklzVlvRH9sqxL6mCRkxFksM4mc0jq1GV4?=
 =?us-ascii?Q?N4PMO5N7veFw6U3wp+Mpzq8c/NFEyfe2YNptrL7tD/7UfGzb4khFYd2/xK5g?=
 =?us-ascii?Q?PQPAAvfiAcWN6GEHKOqnxypnnYotLbsdzuiC6duPZV6bDV77+wqJnZcE3UQq?=
 =?us-ascii?Q?FK6k8qdwDWFCi4qJGHcbAKnqETkNDaPmfeh4hHvgqvpnyLmNwECTuWGQkAiK?=
 =?us-ascii?Q?eBhTsyF0+/sMqsY87owl9jsReRvLQpW+0gQFav9n1B3naz0fu1HxM9eCV7Io?=
 =?us-ascii?Q?d0kOpfmO8ohZvzNzH5LJrNzgSogiWQGSrzMz2tpPd7qWklvklBFqtW7zODTQ?=
 =?us-ascii?Q?B1cGMZj6wXtx1CD3pPFoGgpkzsMwxl3pX39G849fwTkljF5yM/sJRAlcWPAV?=
 =?us-ascii?Q?us+ureBFfVeXVWRwpE9ykAzct0k2UA9fhzJ7Ws1Gyv7U8UnCz+OnmDmMB+KE?=
 =?us-ascii?Q?voTv8oy7gW/Cvnam/fkG8abGXU52W2bkmcaMb1wHBj0VwPRGMQHZUkjb/YoO?=
 =?us-ascii?Q?RrnLSbkZs9oQErJcSwoBAjiGeuhEHPMomISl0+phL3PNK8UXgr8QqfnvlO5Q?=
 =?us-ascii?Q?PBkkcsiaHGKz1uhRqpPIf6igt0EgvJR3w88qj8mOUep08ANL0B+4M+ntKHhE?=
 =?us-ascii?Q?8/+scrrNXnieLvwgo90U98PUXW3vik/t1w5ijYEZgtKynKDIr5y9EA6Fql82?=
 =?us-ascii?Q?fCishxQHRn4uYVtjFseKJstSzE7A3beeThhzWIh1ilDQvr6U+p5zry997sLB?=
 =?us-ascii?Q?lQI8ubxkxyLWNQ/e6DW26/oiU1XHxTBnFcn+A6JE3Y9pDYHooebQ5JLNNbH7?=
 =?us-ascii?Q?qQnDzP2T099m3No/Pfv+MU+CFT7AjBFOu7r5UVqXYDQrI36X4c/dKRHnoHBE?=
 =?us-ascii?Q?8xOBKXc6oDqiZf0Ic/sImD/2+8Y3vUY4NQNcfVkPg7fPEEqR1JLqKYk/fzWn?=
 =?us-ascii?Q?Oi42VIq+wlMnmvkZCvhep+nY7DHqkMoCSkGCwhyUND7Inprg3s9F9jfejBrd?=
 =?us-ascii?Q?7Y7/THkyDDgMjdl+fxCGLO8xvxG7ud9GbuI0P9ElI3ZpUQCfVImPwap10Ayr?=
 =?us-ascii?Q?3fSoH6PgwFT1a0g3oyG2OHinsVn1lbH+FjJx+Sr2zNKakMmYv+P9ialbkKBi?=
 =?us-ascii?Q?N+Hjf9ImYb8lxmVAEzQ7DzQcB2SKERxMSHM1K92uDpFy+MxOMDz7SbuDUQy+?=
 =?us-ascii?Q?PkTy5sy9TR76pljK5QLyRJq+gXUepJJJr3k5lJK8/y/junSsgfvfaio3zBDp?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b40818ed-48f7-4e53-7dbb-08ddc40d3b30
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:05:26.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeOeBT+wPHv+zyDZUVG06uWP3PRVl22qQm2VbpLFemTkn7FYp8c/DBM4KvvbhcVvw5DglPWnEPSo7RIlGNlqwSK0q7cq2K8Z3OUGEgsflFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com

On Mon, Jul 14, 2025 at 03:35:24PM -0700, Dave Jiang wrote:
> While cxl_switch_parse_cdat() is harmless to be run multiple times, it is
> not efficient in the current scheme where one dport is being updated at
> a time by the memdev probe path. Change the input parameter to the
> specific dport being updated to pick up the SSLBIS information for just
> that dport.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
