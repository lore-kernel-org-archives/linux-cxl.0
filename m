Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4B17838D
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jul 2024 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049204; cv=fail; b=A+/qIVhuDzUcKOkWFtBNLo/TLYwG+abEKbU9FiQMzd9a0ancJUSyBnMRCRfVmIFT7OvrHCiJDoAcg23MX2/NttnM+myS2epURWn8nb6DwodAQyIuz6tXzsESbv+wcsul3fvhsZjLhUBoO+RXaMYb4RWwAVhVZNhT5D2+etCc8+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049204; c=relaxed/simple;
	bh=Qj8VKqdgOVxu5+dgou6+NQSb9YJfCFFxtxYqndTxF+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N9zJ1Ki5tX4GkOONlOM9S3S4yoesZ1Q4UNvQhw/L3Yqep2Bcvw6TpSzmptaEGU3i3Wl5RJAcwHm6auGno5kJiGJecB/7X0+xLbDa6n0e1HFgt/8uhv6MEQfz1//Vko3LcI/gIwzgmN835+4bUgO5ipKDHDAUkEPExuYaexYCAbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKr6eMgv; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKr6eMgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720049202; x=1751585202;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qj8VKqdgOVxu5+dgou6+NQSb9YJfCFFxtxYqndTxF+k=;
  b=eKr6eMgvD7AJqEkz6hDF0lNkHDGixdRaksrHf62t2ZLecLZmypNYI/Jr
   fc+Z5bgiXFbEOSpWxD9Qbb1NaTT/NdJ/F1Bej1mS8a5scTePqpuS6Httw
   LhlmKwQQfVi0NKrLF1Rfk1maUy2RjrfeTsaeZks3wKwBWEjicy4yZpK8k
   1ImM7K6bb7EiZg9pxrT+2YxFFksVf0Cz7HCERqeZXB7M20mf+ntgwurVb
   tvnWPMx1QuByPxQUnzHUQ71xAJR+3krGM+peCtXZArZV96f0d63NKk4XQ
   SoR/z1CRE9RIv5ev68a80xytsZH27H4HPNtDXfGUnx7pqnTewifIxS56N
   w==;
X-CSE-ConnectionGUID: 7qviQfilQ+GZ3bNili9cJQ==
X-CSE-MsgGUID: aPLHVaoZQGWiaLoO0DdI/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39823365"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="39823365"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 16:26:42 -0700
X-CSE-ConnectionGUID: 0U97Ev7aQce9831ME5QO+A==
X-CSE-MsgGUID: m5Faw6PGQ/OUOICd/VFAsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51579252"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 16:26:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 16:26:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 16:26:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 16:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgY2EWhFYdqhYtO7inqsqMOZPDoN5ESKAf3h8pJhJ8ym4LMXCkGGx45fKGER9XGv2/lwUc/vF8a9SuCLVDnBU4OL8Y47y8qTLzR/KaHa/cIajwLhT056pZsTZtiitFy6Z9kaA4qXIDK06FaDVbyf7yVzKk4I4hGmc6qawf9aMQUzQcF5pP3JT0sORWnLUrapH5cQKwaTaaiyOgG/HInkuUjeG/E/ziNT+Crn6gIr0qmrvx94ef7s98aODf3Q6OBBUXuPX0DvzHdsP4hdr1HK+iyrEI+iHZmjTVi4f7c1Hiw0A3e0NjzDIFsuXVjNF3fBiFtmD2xar9cy/kKwl5CDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8FwFWrQOSnPHVM6BQ6Ra4i2tggdFn0jjvW+yoA2tw0=;
 b=dCPlQeMCmdLKasjGdD2wDAFtLf6A7oItwS4HeUE8uf2pQXtR2GaPfkdMUCueuv7QD6472EHJB0c142JkP1dIEXRMCZD30f8gQpEW4STPGAJJyRuv4xGuyTHx0KL5MP3FeV9HCQDNCZqobP2tRAm7gsQ5nFRqFyUawl1DluZt7mR6MlygYWWf47iziwAmLFIWbsbfdcZBjL6h59tcCwltuhAFsbRcyJN+rCyJcTo7afY1biC8mpgQqdZ8PaR4mv66kL4pgmjkn93y0dJ7Y4Z+H705H5O7RFpb4Jjnu9u3u0ffYlfT7K2ISnpNqmbQqxICTjNstu7zNERKNlPToQ78lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 23:26:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7719.022; Wed, 3 Jul 2024
 23:26:38 +0000
Date: Wed, 3 Jul 2024 16:26:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Message-ID: <6685de2b88d78_4fe7f2944f@dwillia2-xfh.jf.intel.com.notmuch>
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
 <09ea58f3-b54f-2bc2-bf6f-9a05e9db361d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <09ea58f3-b54f-2bc2-bf6f-9a05e9db361d@amd.com>
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1616ac-ec68-4c09-7415-08dc9bb79602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ffzkERhVRjkBw4jq0wMngngQkvUSDLaBKOfarpX1tth1cj7Lc/F9JOUpR4H2?=
 =?us-ascii?Q?Ka0nev+bIjdFolTpyE53xWgSGmp5GIkUMVOJSjpjb1Gwy9jH0dXcEGJlLQ0x?=
 =?us-ascii?Q?XFUDf+5OjaoXfZCP3QiZ/c5PCVION4jS3R3rpd0Yq269HM5GM1b2PG8PxmWX?=
 =?us-ascii?Q?cin090qytLvQLS6TZhfv75oaZ0+uuDObrhqM2Wh97ZnuFXuVAFbEl/uE7vqi?=
 =?us-ascii?Q?SWXU8Mw7hsbVqrnCu3PZJdEaRWRyIFeQrwzf5ZKrjbat+3eb3x/Ps6D0IJRI?=
 =?us-ascii?Q?ECI2LTmnfJQQdlALMWh7+F+7vZaVIL/a7gN6NGKBcFB1//2OiEn+MM3OLpOO?=
 =?us-ascii?Q?wlWnpP4sz4S74WrCcT6XlLmKgLZBehXJSUmJdCe/ieWE1v5qJFRZlVbHmyJE?=
 =?us-ascii?Q?eKcRDcf71xHNgaIak8IkBfqrD5LmlJGfxgYaM54TiJ/lPaAwBH2+02FyzQ6T?=
 =?us-ascii?Q?ZHSV+aEmjBawRQeB2Qdi7TruZQZdkR5GvWf0YUC6KoMIaeD0A0W2g4734U9z?=
 =?us-ascii?Q?AjxqdZ83H5A4fA9+/YRsKQ78ZaaYnGS4Tq3i6mQ5c0dJbWfwn3fwRH49HZVn?=
 =?us-ascii?Q?K7Krcyu4zewFOMG+Mqj42B43YUomrGMOa7Ynq4t2n2uOCeVE7W9ixPnE825y?=
 =?us-ascii?Q?MpkOg9RFiQnvbKzLgl3gwNRwAUqqPDOLNFlVfiHtwrRgWnjYfuQkaGNmA+pY?=
 =?us-ascii?Q?o7ArhHsHxkyHQM7DwQGsIvB05Ve9LlgCW3WAq/Um62w3loL34QxOKXjub7rA?=
 =?us-ascii?Q?YzXvKmVJ5qKCermIIhQKSvZP9ULMuDw3RHMAUveB5/P2DtGnCDJSpJpwo/qA?=
 =?us-ascii?Q?K/jCTf50t/ltGRzGmv8oiWAYtUsZfIAHJrHDv7OgEf4khcd66W6XXv9k4jxW?=
 =?us-ascii?Q?SxP31nJv461qA+6lWaowGiaPfVnuDZWVO6t2kvwvYaZ2jdMsmpAFFLJpGCSr?=
 =?us-ascii?Q?0rb976Ut9Y5KoHAd0JRPJHA3WmJMvJdbK9oHOpvXgZ4RYyLRHXhg1df+zX3e?=
 =?us-ascii?Q?WGEYZ5Ilyg1jYE2AFsbo3JezDbrhzmg1GuE6ID7eC84v7RMi9bATF+vwDUZk?=
 =?us-ascii?Q?1jalB+9bP/ocCHyrmx+Vx850XU8kBUjSpdMWRwRfiPTwMVg3MHRSQLs6D4EA?=
 =?us-ascii?Q?aZvRMqtgiAUB3Mtt8+ZWLvEfNqDmDJghkgeBNHmHN9+PhGU7VE3kD8rRIVv1?=
 =?us-ascii?Q?DTKdOzl0YGW96QppoIoJ7+2y8htRzgmCYCzec8b+rlapBJkqMehVdId2kh+y?=
 =?us-ascii?Q?c96Nzv4ouv4YfZqefGHIDrSNORvligSuQPNvjfrOIGKylyrB3p7wGtiHwSbB?=
 =?us-ascii?Q?X7M77+qNx361rHC1x4LytnhyC34qirhqBL+g1f3WqofI1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bOU8uw5CYZKEKnK5MvtE0qtXVl0x0myuOhxy5cGMFljQqm5aDlX8EKdq1SX?=
 =?us-ascii?Q?aPlOkQ5ve7Erpcto2FvkKLnVnvph9MoX6TTbVC7UWeeDGVBtLaiQNx/iY/q1?=
 =?us-ascii?Q?2Boz4dyI0vZuypGM9CS6wPMlJ6WER7GkW0Y7Jt9sdE4Vn6bCsRC7lVJte7zL?=
 =?us-ascii?Q?kvk4RsnLVPb1bx8oWlMR6qyADqQsImnL8AAkdgZzjok1+vStzN65vwkESq3i?=
 =?us-ascii?Q?fjajuOIUCl+XaiN2CSCIppLWydnQ6Pt+yhMkdhq3yKOJmTmHI0S3H71f9Ekv?=
 =?us-ascii?Q?nOlC9bENJRZ+tH3JG58RRRgOdj9O/8xmol30YUZYDzggYwZnRnjwCIG34P8A?=
 =?us-ascii?Q?7icbFvqrZvT0APTpE4uiTOg5GsA44Z2IF5vmy3IK2vReGG/VCuC4K/TXWhQf?=
 =?us-ascii?Q?6C3Sl71whGrro4L9mBlEQlJRLAafpAAz36XtadvLLmPr42XNyYM0NOaf2ZWG?=
 =?us-ascii?Q?3m5O29eYjEC2BiRhq5hkXk6Llpuon0k8lZirQ1/cUZXuYxoGd9k4pd8TwOgb?=
 =?us-ascii?Q?6Dfqe4mP6O2xQ6BLv8ifAiklHd8b1a2F2MfyD9HaqQfu8/UVG0FcdfCH6GUf?=
 =?us-ascii?Q?gOZuD+ysx43ZYkHlEl3KAM4IL9320ALx4LPgkeNxKZde0TPEQLHGmnEpGs8I?=
 =?us-ascii?Q?0moQaQeIhrg7iIX4akgzKNcYP5iKg2glCDfuFweKO10vgRjsH3b+MB6ytf4u?=
 =?us-ascii?Q?a7pgslp5E+wtCLeF9pq8a8JE+ZulhYY5H6ImJOSXSSormyFkpqSVjRSjGXSM?=
 =?us-ascii?Q?2s1gkYhZIxcaYLBEeRnADSMu/276JgIz2pRCJEf59HUAdRmLH8SQQV+zYmSx?=
 =?us-ascii?Q?3g1GA+KK6HNZIINgCc0FBdO2P1HGCjDRylgR2eygcljGNkEgheiVdvc/R1TJ?=
 =?us-ascii?Q?VadLycWKczWatNcszKpjbuoCdqF+n/ckbEtDockC3Qb82JuZkFUerSd6ZU/w?=
 =?us-ascii?Q?tjsNp5gzJF+qVq3z2EYhSKVAsZ0zww0XeFxjTXAyzIFJQZjRBhou+RdUZP83?=
 =?us-ascii?Q?+AuBaDNU7wkZrrrngGGQG0h5qAs6eyTJovDQCS+eeaGf+IeqSwJ1nKvestcZ?=
 =?us-ascii?Q?xb0dZNy9qnya5P4jvPP+9ku2LGfrmbND5Su6yQ8zIaMRvkJtgsfhPKDaVCtB?=
 =?us-ascii?Q?FyvL88u6y4erNfGcHJjCrv0uzGtG0FLdORhMazfCR5Fo7TMaY0BoPxyYq/uC?=
 =?us-ascii?Q?ctDRJFf6qMPYVCNOV9WYb3KN+Xy5nuPAa9FkiOVCTDAD2PxYqHaPHR7g2xrs?=
 =?us-ascii?Q?srU7LPIez8lmYa/qEh/X9fXttj1RTg1f/V2P2KlAaA+d3Kf94x2J0tHc5uoe?=
 =?us-ascii?Q?xClX+KrtQbL9rxtrvoSjHzNgNTSCriBbnAEP8sbolHjQCTNE1vRnGJKXV39L?=
 =?us-ascii?Q?ZPSs8uefeoajR5yDvxyKmRs/GxZNIoilFyCiA8DLEB1+VK4af3xlejr8zWJQ?=
 =?us-ascii?Q?0+4BZBlVnU22hH1OuvbfQO8Fl9qkChfCpvW+ToJiiFzc64hF/GatzZEfoVOI?=
 =?us-ascii?Q?lhUqkyCmiuz4Vu2eMWqwyo4LVYwRkmElOl5Uj2SE4pGxnzOZBj2Fu1eoKUyP?=
 =?us-ascii?Q?PZAFN+RWqQJ+BIyXbOdNQ+m1ACPlcPJkLG1xq9kEysIyHWyiPC8iqCsRRmxR?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1616ac-ec68-4c09-7415-08dc9bb79602
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 23:26:37.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jsrdqpfAJfJv0VHK1XiZYEp+x2GSc3/+7xnQ3lrhK5rNcH0DP0SpIwRHlmx1w+n8x6u5thr+YUWl/zSyJdX/6HZYnHalKzn6vV9xm6ghvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> Apologies for the late answer.
> 
> 
> RAS is covered but what about how CXL/PCI devices are handled after a 
> slot reset?
> 
> I did expose my concern in that area when discussing the Type2 support 
> patchset, and if I'm not wrong this is not properly supported: nothing 
> for device detachment which should occur before the slot reset, nothing 
> for resume function after the slot reset. This is obviously more 
> important for Type2 devices and maybe not required for Type3.

Circling back to this as I go to post v2...

I think those type-2 RAS aspects are important, but it is not clear that
they are a concern of the CXL core. Endpoint drivers are enabled to get
pre and post reset notification via their registered 'struct
pci_error_handlers' operations. This maturity list is more targeted at
the CXL core infrastructure capabilities and type-2 drivers are going to
have their own localized maturity level.

I do need to go look more closely at your RAS assertions on that set. I
had otherwise been waiting a new posting with the sfc integration.
