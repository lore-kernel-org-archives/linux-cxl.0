Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DBC2C159E;
	Thu, 26 Mar 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542269; cv=fail; b=Zmw5G0OvGkClhdVyM+mQ3Hqvv9IdKU1wg1pz3wMt4g1okzCRYmlZz1gRh4Br0vEMTiFJcmr3+g3J6qWu1R3k9goea9czNN9tx34TA9OGGYyD1c4aC3tUjcvkiu40H+WmGrTgjd7p0122pstoK/4k3MXCXepnme732UPCNINjsDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542269; c=relaxed/simple;
	bh=QiNAangXY6bRtb8a5kP60cFYwJpcDOlDM7+J56BQSx0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q+j+6qRFMSTnYKTC26tY/jXIA4KlAvOYDGQNPm44OEJ1jO+s7xt58CEoRl4WfnNCIY537Qa2X2N4bcGPvgCkM1d31oAVKKS7xo71eyV5Va+E8SrOuPfbPmPFe+iaLgx22Sd4DuC9t6bb0g0KI+D78LcmaK6yst7a1eIKvGmLTLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ji9fu0pZ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ji9fu0pZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774542267; x=1806078267;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QiNAangXY6bRtb8a5kP60cFYwJpcDOlDM7+J56BQSx0=;
  b=Ji9fu0pZ9NrWBA1vr0FR4o25U+bIQSy14nNxS1Dhr8PE9fy0Y1Bhjzop
   5468xKoOAmZ3cnoU4q1x8o8wfPiLlI2QLXYtS1u86/pdoVJ6ski9N/DQn
   NtbgDLZxtZjsKw/lneNWGXwGIfI2wJTaRcpWeC24h2kd10DvU+ihWfqk7
   j9OcOs6pNqoQpIpJikjYrKhkiKq7BGxQ7vG+Ny6pQ1cne68LSDBlvIN2Y
   9R++z3sFDNlmWYmmLPdB/ZXxyFZXhIPC+U6JxOPEtr0TbpeqUtTCdazNF
   t6plCCu6dkJXBM0BRk1H93j1EbmLd1daqJ8Qe2uZhBVqhnAWDZ/MCvQ6f
   Q==;
X-CSE-ConnectionGUID: Zq4VEAe8S3KLEXW0yxjlEw==
X-CSE-MsgGUID: Kj+SwlNCQAmBjkZ0hdHqLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75675261"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75675261"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 09:24:26 -0700
X-CSE-ConnectionGUID: djiMntHLTO67vxbEPrDyHQ==
X-CSE-MsgGUID: EByqPdyFQQ6zOA3tph89Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="220196529"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 09:24:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 09:24:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 09:24:25 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 09:24:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaY6u4bvrZus93WPLQFeQIsKG/JDp78MLfGKbpF7+5FtVdQGnh1afh7nRyFW1hO1tQj7PQ2+LgKQDLqt6Xn1t6SBQ5uZxEE1gJx8S+km+4sn82aCNrfFqOeywSWoUXHAkDxodC2y//f3mEiaCDjLpPvpwogso250K03Tx3RsJJobjceGlzTbH51hrs5GFK3KdPBZu2RLfid8BnDhLLVqOUDEvxbDUfaV3QHuWlofey3nUcLBfVXjyH1e9Fw1+iV8hBOUYgBJYr4Pwl0AXFo0xoilAb4kqcBY8ZhMtgXeKQVqilDLAnC+ikaUklh1I1Ag9h3AEOJ639jrJpQ5EkHDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYaBUF+Ny0rEVzpNEj0jPUkGWQnHR9LVIJxAoAJY3Hk=;
 b=Td+q+V1CYByofl/GXpdKBn1WUy0Q18FgSILULPBBMI363Yc0bHv+QykL56eStugOil+iknQfORY801RK5TdCIJym1wp7x4SJaRaux1d3OtSlH49UtcxrNpiq254F6sEK7TnZ+5DiXaPACIFt9MHtC6ysrScx0i2WZKEbeeX9yCdyGtCnDYoCQtU6uKj18lUe0ajXGN8jUCLwXMjj+MQrKy7R0edrUv+SNj4lyEuW8Q5sgNzeDBrMZQUSbX2uPcw95B9bXhanXWbilGaRfpuHyz/BbEX/OQjT0prv1A58gEyAB9AsH3qNbgXlqIeUOKxsgjLBOr7KqaNYnb1Zqfl0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH7PR11MB6332.namprd11.prod.outlook.com
 (2603:10b6:510:1fc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 16:24:21 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::7d4b:a049:aed5:d2b0]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::7d4b:a049:aed5:d2b0%8]) with mapi id 15.20.9723.018; Thu, 26 Mar 2026
 16:24:21 +0000
Date: Thu, 26 Mar 2026 11:28:11 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 0/3] pull region-specific logic into new files
Message-ID: <69c55e9b11465_1400331005a@iweiny-mobl.notmuch>
References: <20260322131638.3636725-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260322131638.3636725-1-gourry@gourry.net>
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH7PR11MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 517cdb18-14d3-48a6-2553-08de8b5422c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: pNqNIuKblszem0aILPuyYaO421y4bfJQvRVkXz4m3pGtkN3I0vZEBiKqQi+XMCImhtzcBVuXyjJ0N/fIOJFdBjEXwBPo3O83CuJHcI0jtLWwh2dDFQ6PYXh8qgOLesfsZjU4wwRozdjJ3RY5cets9ILP7pBGlUznoNIyFMd1l6lP6wg5Q/pR2esSj1zsLwqClzdWE6LJ27MBJXbygAZcby8HukwqSI+7jfpTD6Xv7+TLTZx88+kzuZ8EeF6IJ16CiDWgLxUFGuLftG0dDalnRF/fTh4517IB67N6ILvd1ZzOzHfg3IEXiI2my1akph8PaaLA34CDv6pPqrh/9Y1MyLOkIC2QoKv4n4Ftio+e2WlRJ3wQIqIGmH+b7El+LqS6QYSLoG6zWau1DuPc/Bdii2sSSlmMhlbv19UkpA+Yt3w5nGJPmtFLxMX32Q1FHTmstnj9wDhFbnaZwOUPOMgmTQv5ranztXZL5S1OdJZcBizfJmRHEHrazu/xRA5TMIJwefXI2cYlGDJsdw6qOfERVgl6q44zZ9rceEbfiVOe2r4QZxgiuFrRgZYVIbE+uKWw5ktlLT7qAH50JY4Z0LAOGUHAfgetTnSl7CcIxdEOJXL66tRFuyoZfa2voAbZZJ+wS2YiV3e2B5rdmRVHdqzlkCFqPAsO91jQuS0KPVezWMOvASnc48hk21EOprvibYdY7DNKKIT/n6Uwfl88WA3OYUxavFIfDvON5h7usiEONS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?otrbNIPI3kAH427yvKUN4wgKiVyYHRDiUsZtDpDiEbLx7oyzTaEQl7/VKwhY?=
 =?us-ascii?Q?3fqujb6C17IE07bOTynilcMuW8WP/VK/D3ffFy/AVC7qBgL87UEFiTH46UlJ?=
 =?us-ascii?Q?4YXj90G9GJIES+C6Ylw58wsMtOeZv4APmtOSBmG82N9uWXkDmFKQyvTd/VT6?=
 =?us-ascii?Q?uS90LPMYD1Hv9NYGhtaNYIgG1mqOtjWDbVl3bhebKCHtWThe4WVGm5f2HUiF?=
 =?us-ascii?Q?m3ayLeBTPYSoQymldZmdOwzPf79EZyVzL8V0H6+AHmYDNlHIpyhSweZ3cr6M?=
 =?us-ascii?Q?XoyfvtbP4x+CwtyoEvviOSImtE+S+WfEX1H/lzSR9b3+mfrjHLbvnUDSgsSE?=
 =?us-ascii?Q?XqxpTvr1r7f/1jJCxC4rQ/Ty6KH8lEeHtqk+f7Zni74UShTpScJzprobmUqY?=
 =?us-ascii?Q?JVVBv6A5mILJHDIZTUOEPXmS+7nnlwsHPlRVZjeKG1jzeGV/npaSq/TogOZY?=
 =?us-ascii?Q?dBA9MbHQfUKUIqg3/XMxp5JarQlwHvnAca6exXO2COeNCcFVbvgkvIbTC0TN?=
 =?us-ascii?Q?0oFy309Apj584+XiwBCGYkBVaJL2ND1mZxiUPhH9GrBX9pZzc6r6rQEUlN9/?=
 =?us-ascii?Q?jwvsWJJWvPEDPdTbapl8e0DpSMtQLFLGlfoK6pILt3JOpdke9ScQyUeAm3+y?=
 =?us-ascii?Q?XFQ0LsZXRBzqnHApHER9j2fof0lLa/Agq0Uzd4dIAUECuLIR8CebFmAoq/kJ?=
 =?us-ascii?Q?Vrxz+lTsLHzEftX6bZ98LTbCEK1W3+cePBTvETjbAIdULmujnhfVmQeHH0SY?=
 =?us-ascii?Q?n7sQmMwWh8Cj98Z6UKDCMZqdNFy2U3rx9KaXpBboJ0EYPSWk1XPvVpalrJ38?=
 =?us-ascii?Q?aPfH8tuAHDn2Buva9Tv08clT0U+9JyipVC4nMGi92GI46rBno+PoSrq5XPm2?=
 =?us-ascii?Q?kckLDtiyFwv1r6YJ66Kx3ZsEj4CLv7zCdpVsgFGSHsWUrfgGhqDJazcrooTP?=
 =?us-ascii?Q?CK72JMwlGkyTADLs72X5CnABoixcb5RL08VVNWq5enDRlApIN0BL/DfUbO8j?=
 =?us-ascii?Q?gJ5wMEyt31mpMFzavOVkezd74YyZ6SFm1fd5j1NcKanVmylKerFvZ2L9CDyP?=
 =?us-ascii?Q?AuEHx/HeZKknlAoKTs7AZ1en9qJHArECKHzza7y5GA6xNpeN3n6S0UcAoPxE?=
 =?us-ascii?Q?2co/pLNjcoiF8nNuywoa4nZJB0MvIcUxzOmvBwOkRk6jUGtwWKRyFg6639Bq?=
 =?us-ascii?Q?HQY6I81x8VYKRZPC0Fg5CbY/nTQDtH+jW/vlXtXsvIbCr2ZgjL4ZJ7lTTS4i?=
 =?us-ascii?Q?vMWIOXENO4MUWkf8a4wf5NEQp50GZCLKyiaeE7hJVn2OgB3/9EVFc/eJYDsw?=
 =?us-ascii?Q?st02diKnpYEQ7PHQknRknBQYgQxYuG/DHmUrHU0H0oA8df6Lm4VYJD59MkF0?=
 =?us-ascii?Q?//FFxKBZ6qdBU8aNrGgpAdlPfFXFD8mK89L+1BH7S0mdqxEVra1DqHoihhPL?=
 =?us-ascii?Q?uAVphrJVNRmt10DGmseM2vUkfBoSvsYe806+904R1Hz6VartJbD4cgADcMBl?=
 =?us-ascii?Q?P2h7B2SVJGq7g/jkPqbzwRUxL2eA45aqrw1R93Lus+NgiCnLBacHiolEjsL7?=
 =?us-ascii?Q?fZ/TYzyMlAZxSmyipwp+un8gfFoWMZOfYfH5JMTF2QQeCZjuAu8mD13a7eUY?=
 =?us-ascii?Q?Mx4oU/gibI6M4JBgUwvmha9Eho9PcCNfhiQg8DEhhCztwshakFsxc9flQmTb?=
 =?us-ascii?Q?6SENBjb1RsSSgOZuAQdVXquA2fN/kfPUiQ8tKO7jeFtjdWEFMuzEKZ/02gX+?=
 =?us-ascii?Q?z598RO0IDQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: okbb3tUz/Vk8XUOt1EKelVQJ3y81a+0JRDN+gnTuo1UQvU39lQJfSsrmVIfxPKtNER0Qh7ddPp6OyY3Y0hPGTkqySVZAa3p7aQDVNJmqUoQqVsjHCAJPQVYLLEaINX3+l0uoNtLck3DimUTzLKvuuYycZQjFE1SWeWXp1iBVWygOn1OmQNy/x19uNINKshb35WfQj7TtuuwxWwvwNTe6BXtApDnTVF8LCnP90bI74AUNhX+M33wxiT54WcPOd4XXfPwZYYkvK+JqXxtO9tSJFqAv6w4o15FpCMy1/hYv0l8/DU6Z8aqm8Hl595Q81uxvw5Qe3emTETt7uFzDfQsBBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 517cdb18-14d3-48a6-2553-08de8b5422c1
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 16:24:21.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iu8ccvt76fKjdS/WLAGPmT6DoKSPC9M13Au8XMDQpPtaCq9sjnGFtb6b62FAsBntHxqfp+DSgWALvgYsEcojUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6332
X-OriginatorOrg: intel.com

Gregory Price wrote:
> cxl/core/region.c presently contains logic to handle cxl_region,
> cxl_pmem_region, and cxl_dax_region.  The cxl_pmem_region and
> cxl_dax_region management code deserves new files to make it clear
> that this logic applies to a specific types of regions.
> 
> This also breaks up development space so fewer conflicts can occur, and
> it becomes clear where changes are actually happening.
> 
> I snuck in a cleanup.h fixup for devm_cxl_add_dax_region to tidy up some
> of the existing functions.
> 
> v3 -> v4:  address DJ's feedback on cleanup.h patch:
>            move __free() declaration to assignment point
>            restore local dev variable
> 
> v2 -> v3:  renamed from x_region to region_x because it's prettier
>            added cleanup.h
>            small nits asked for by Jonathan (commas)
> 
> Gregory Price (3):
>   cxl/core/region: move pmem region driver logic into region_pmem.c
>   cxl/core/region: move dax region device logic into region_dax.c

Through some other testing I found these moves to cause failures in the
test code builds due to the new files.

The 2 patches below fix it.

Ira

commit 0248a89b7c798cbd32cf3e9eeb97a3fafb5ac15e
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Mon Mar 23 15:48:52 2026 -0500

    cxl/testing: Fix testing build; include region_dax.o
    
    The cxl core testing module must have the same code as the cxl core.  To
    do this it uses the same source files in drivers/cxl/core.  Adding a new
    file there must be included in the test code.
    
    Include region_dax.o in test file.
    
    Signed-off-by: Ira Weiny <ira.weiny@intel.com>

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index da6ef2c1fe0b..a6f18e93cf0d 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -61,6 +61,7 @@ cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region_pmem.o
+cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region_dax.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o

commit a0dc872ac560b65f27eb41c003a02f67e3dc52e4
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Mon Mar 23 15:45:42 2026 -0500

    cxl/testing: Fix testing build; include region_pmem.o
    
    The cxl core testing module must have the same code as the cxl core.  To
    do this it uses the same source files in drivers/cxl/core.  Adding a new
    file there must be included in the test code.
    
    Include region_pmem.o in test file.
    
    Signed-off-by: Ira Weiny <ira.weiny@intel.com>

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 53d84a6874b7..da6ef2c1fe0b 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -60,6 +60,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
+cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region_pmem.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
