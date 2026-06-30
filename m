Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB53DCD8F
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840255; cv=fail; b=U32IsO+eMeYewXvptOcHuaqBqKU1ExSV3XhPN+oHD3Eg9UxFIpeKZbCf9u/cD9BD/7+6wooNnNG/ukIczUnqqZohXcDan2dKJQuH0qyRlfqT6ooXfZyOHaJAuM8mp9XdTdNowQ6LSWaEgTOfQomLMuGXprI6x/R/lJ1RXCLsBKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840255; c=relaxed/simple;
	bh=tzD2VEhU67gGZiec7wsUNmd8O7TnSxYjjSRizPSbfcY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t6CkDHplnhliyXLYS4dWwvU68KMUSEZTHhuDGht4jsFOpT2d1C1sZZsvgI44fY9Zdi1TGlsYj4xBfXW7sTXtZC5BYA0R4/EPS43JgMqp+//NV1xfWlVSJgrspba3TJDOTwpc9/i1HupZzkL9TSMguHoInq9Pfy4d/1IfxjrhXG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdPXFtbu; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdPXFtbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782840254; x=1814376254;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tzD2VEhU67gGZiec7wsUNmd8O7TnSxYjjSRizPSbfcY=;
  b=UdPXFtbugieI/hjnx9+KgRlzoD0BYBuZ3uI7R9hgvP1ncu+CfBYgzrbS
   NKfUph7OrcnT5wc2nWQJrCNvD5TUAQ2DnK3qRFpj+pzQOdYAf3tm9JRpn
   g1pJEJYMWLiNMp5yMIugRm+KbJ+UGPQa2QfbtwSPMfLfZP4hNFo3TUph6
   v5WHUIPGsNSwGSeuRuWZ/hUa3Jc5ASnpyMbknKaGd/iUH1iR+wRwKATJI
   ho7wN/qpTJV6CRis8nuqxOAWTyxzXeCnxMVVXfRbcu8yOW5+I6P3b/3E0
   klpHHHLaBfvjCJDer9U9gnT0bGPAVdwGpWU+9/cD8+/2gryAkxJsWfBX9
   Q==;
X-CSE-ConnectionGUID: Hfh1Vf+nT3Co9lNksFdeeA==
X-CSE-MsgGUID: EZu3eNI7SMeuh4ExkHYVFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94161299"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="94161299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 10:24:13 -0700
X-CSE-ConnectionGUID: OaVTjcxPS3utHsHcR7qGxw==
X-CSE-MsgGUID: 92UckkU0TByQlpc3RBZF/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="251910685"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 10:24:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 10:24:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 10:24:02 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 10:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2Q9pv9WyqRkcsc5xNEpV9nQO9IiLj0ofFqdzxkad2EQqIYb8woRtcmMRDfVwYT/HNuJKPHF6yAbKPLnDzjC7qVn9gs7t9D/wG1+/1uWGRT+SU5hXedTmgXuLLvO1VfJ5PsL8EJPIW7pGlJtKM+Ud3pW+g1Z6DiixUlQTl801vfELXg217vRMw1gWJ3WBiNn2p4Mh6ycLSXTsFXAuilaLpaWi2w7QXp8LlBIsPcXq/e2rId+qslseSFLqPwLcYG4Lj14bQByVmAeI1lRHxvQvF4WqdHHU5KsnokGzw/AjxByE72MmqTAjP6vFdJEL99ilpEO5Qb/wGft/F5oAy9oFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83vVlFb5CImZsHpQC0dwTLidSom8UKBArfUrdg+WI5A=;
 b=mEqBEFDZ2FbbHrpa1q2afDAalg8vDk7511EEnXDPZrSOttzkwq2YoXZ4oVLw5lO6ljINQRXGJx/7E3p8XolORJky5HMxyqfL+YxAbZj1AB70tJ5QUwbblL2Loxbm409+2Wke7rwlGdaI4sMc1q/jnLNgcCPNOHKZTAgm9He1jAlg95LPcY0B7nO9jvd7NCGc4ua84Zt2vDIC3py9ZYcW7wkg7GbgrHEfjC9NrMhcA4YaKgvnI0b7ugV4yiBMEFVoM8+qPw9slbMY/8dt2D6wzwghQRff/Z6TG1Y/h6OhWZTWjsnISVQ2FfEEsqAfac3jx360nLUnt4MUm1qQIqeq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL1PR11MB6027.namprd11.prod.outlook.com (2603:10b6:208:392::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 17:23:59 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 17:23:59 +0000
Date: Tue, 30 Jun 2026 10:23:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH v7 0/7] cxl: Add CXL type2 accelerator support for
 cxl_test
Message-ID: <akP7rNUA311jYu3Q@aschofie-mobl2.lan>
References: <20260629221104.3891733-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260629221104.3891733-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL1PR11MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 095eccdd-d3b4-4e49-2239-08ded6cc5f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|3023799007|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: b9QcBEI47+VEPlW45ZIlAHTSQ3+E39K4GxS2a/FMwKocejS4Ubqaj+oWjHqT6A+gd6eZznOcFdb+qtmry4ODim3hshzloO+GtPTSHaM60mvhNSZZQzXiO0CD2XBM84SX5GsrtjZg2VCiLbUbHsSHinK1X4MQHzQF84aEAEdIeUhsko7ENX4CyR0qdly+pqlIRq1FPpf3Np7OGdaEZlmf+xW0i9hc569M3zgrMoxpnuVFaO3gGXFkoJE0eREZqjG9xtUPMjeo3rJkfF9cblvxIn6JaUi0MvOTndyuPwxT8QZOYlm0FaMAZZYudSh8fa31jnrutqBKEvVPS6jTTIvEriGIT0imYqT6qPev+chpfyJiV7rOnJLJfFhzl9iLj3ReWk7uflOfbmzzaFZ/fNzUEdAXeVkhgzxHSONshOVJXs53RLZZmIdZ4RP36BYNc9lXoWj83hGdgrXn0ah1uOc2RRPBWrYXO/ZzXuLJ6/AWIkj9BFpY7VoQKmtx1XvBOsVVSYws0N2sliMhUmwpmdAppAT6f+JrOS/cMVKQN0IEzlpqWBwSKxeizNxfXJ2X6epicli6P8oE8u3hbrkhA53i8kWzSuo0zppeVnvXEvuLfFCPg+LJfgWfxdl6bpc/vmOBMRQ8Vai7Z7pGCIymH+z3Itd7OlBdqisemi4HfqBGAYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y39yci/7X2wmDI+HWQAfnke1CxWtWPQ1kbOThrfxj2XU2K5/6D+MV2dufCrG?=
 =?us-ascii?Q?i92fRJbnZssvx64KvEVhj9hkuL/n34NisskMFG9Tc3OJ5+LvlhJceVOZeyU4?=
 =?us-ascii?Q?rmz52lIriNjaSko2f3HoE5Ouj0YIw6ZZFfgNp464ZN2tZVTkXO6Jet+dOLTl?=
 =?us-ascii?Q?Q1ZHVEDVGVkFJJT8aex+GJWqlKQiJf5O6lXu2VPIOYd2fbK34lVdRvbZaEKI?=
 =?us-ascii?Q?xKlLwi1Y7W0zS6sg9jK0FZMterEv44p9WEbHmODKnX3U6oQZVSYyeePpYpap?=
 =?us-ascii?Q?ZTmpmUwEVJamvcFl9db48cZZNbNhYDvOJdqjdwZC9H0E26vUlexphX0PSppC?=
 =?us-ascii?Q?GPe4ssR07+ANJsOK1x6wNQYjrlGCOw1hGLnc6qpDhQy621DrmaNuViLXJxzu?=
 =?us-ascii?Q?9W93Z566C0HpoTpTyuqN/KAK3D56UCm5UuMueR6+8cD3/bB2Bk8Th0bglAMf?=
 =?us-ascii?Q?WL7xPSld4ov8VJi9m8UDMRE8wd7FPJZ+8HHcZqQFA9j525xfoOjIb6ZPNYzC?=
 =?us-ascii?Q?3zfCnMMXMxAn5iiS3uRo4Icycvzl1AM6eEX7+G0KYNzoXlxTbOCZXGwO3T9F?=
 =?us-ascii?Q?NJqSUB9qs9LCbMpQN1rou8Ptr+YWlRsl1IY2em5xD1KknCQyvcyGlVDHfWkd?=
 =?us-ascii?Q?gPsHgSAq4BWHZlOFCcQ0mQmP9ARswehPXPAb8EK5RAkZZxCx/xKfCKLRhhea?=
 =?us-ascii?Q?VQcDCPMsekCKkvwAZRD8+dwd/OBlDwH+QCFGt6IC5kKzi+6q43zgkhY4i2nB?=
 =?us-ascii?Q?keDRbMG9YfXV225cGyzgPc9eP0FByLqfh2LsFqKBm91+rux6rZL00D3dQsI3?=
 =?us-ascii?Q?ET7TuDmQhA8JVpdV5NXjRe10qMFiy88DEbk8HisztUW8CFKN+lcIVdEfWQcz?=
 =?us-ascii?Q?OplAsDAZrqipO3RDFZLQkUT416FHj4m/XDv1ciRKbuGah6QB2bivASNoL3hH?=
 =?us-ascii?Q?JZHfLWVG5EsjJO7PDMW5G4UlXiFC0zcUbZwJsbskqp8cVLKMQY9AEh9v30k6?=
 =?us-ascii?Q?0TJfVOdAwFdejojs35QEbRSe9wS1yM0YiRUBpKVEW1DnE6RP0xEqoxM6rkWg?=
 =?us-ascii?Q?5CxG3cDQI0JtX7h4F0/uoPIiQyjAzAaYyEP/T9SOT+059pAdBQdjaSZ+8eSk?=
 =?us-ascii?Q?DrbpFMO8/hk2TYNhQRoA3oTJiAu+3eJkTTC9HqosA37sRbVmn0W2S6QS2MGX?=
 =?us-ascii?Q?Ui6U7ijN2V7Zt/FHe+3J3MVJGqR79uXvAa9vQYRDT/YU876p03NqbDGhd4rh?=
 =?us-ascii?Q?2xi7bDwVErTzKbYJdM02WRrJNw/9ljaBruMOiDvOZUDDhPtKKv1Zyo5fJCPa?=
 =?us-ascii?Q?zwOagw6jLx4GuGwhDO1QKMFKLld7rvJSmTf6UN7nM1+8EFG47Y+fx6vZd5au?=
 =?us-ascii?Q?ilNjXsx7vXCTytr0LEhDwWgbYjAJFUdrk7b7kxU1UmOf+9emcfvLnWxqqMEE?=
 =?us-ascii?Q?xz9QyNm9A/KEcbeyijvvhi9asYW5HK3MRbb9GOPW6znUiOJGs1JouZLB6zpc?=
 =?us-ascii?Q?EcOWLRZp4kTKD3/mR+8hn5iTkE3IayS6CC1g4SJHFHZvT8CCiYNzisaIJu2P?=
 =?us-ascii?Q?sVlD4l2OYQcnSlCMqHB935XEyaNjy00fu/nBlYbh11k0epGEWkl8TsmjJonM?=
 =?us-ascii?Q?0Dh02r52MN+y/uB9f9a8vhUOrBtxrEag2pTZlUTiRWQD22eNgHdckKCTohOZ?=
 =?us-ascii?Q?/yRBDlDvAS5FAtnJqxqcIfGxB1iXaOo7d+wOcvbV8Bi3m67m/jZ7Gbuf+191?=
 =?us-ascii?Q?LsFQ0I67rJHkPGXzFZY5O8DxP63c948=3D?=
X-Exchange-RoutingPolicyChecked: CvcWK4fPKh9vQ4jWKcAgiaAQOsihYEHaKI2IVmjoHXurGF18LZ59nQHXCqqk2Iw0yqF9woqaOlFImndFaB235Z9srgm+EoAOc1OWJYUTzXMN3skBl6Wd5UmkR/unJ+GFWPbiic2cWaNCID9ugE2dh8mBhoGcao+UzA6oTUiBYnbYIbgbQexiuxEc9kRM0tbV3yAwzwIdRTPJyNCjYiAykq000VTU/hRqQw143JH0Akb5aA/ffElZNNVnMIB7fBHTIa5VaDb37fm8mHUlGAJMDQzkT91WEAHoaEQqHH7BMpWUmTRuu9YqQ87F6H+YFQnvl0PbJG7F6qsEExz4jAN5hg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 095eccdd-d3b4-4e49-2239-08ded6cc5f64
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 17:23:59.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuqrml0uAbwG+oUmIR5Nry8pmW6kiTv2thAdAroCw41/nAAwV2k6A7EvUJxPEHyJmWES8wRsldqbwpRhUmo/3cysN3nxClXAUPEikep99r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6027
X-OriginatorOrg: intel.com

On Mon, Jun 29, 2026 at 03:10:57PM -0700, Dave Jiang wrote:


> Dave Jiang (7):
>   cxl/test: Add test for module parameters

With the fixup asked for in Patch 1, for the series you can add:

Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>


>   cxl/test: Add type2 support for mock CFMWS0
>   cxl/test: Refactor platform device enumerations
>   cxl/test: Add hierarchy enumeration support for type2 device
>   cxl/test: Propagate -ENOMEM on platform_device_alloc() failures
>   cxl/test: Fixup hdm init for auto region to support type2
>   cxl/test: Add cxl_test accelerator driver
> 
>  tools/testing/cxl/test/Kbuild      |   2 +
>  tools/testing/cxl/test/accel.c     |  66 +++
>  tools/testing/cxl/test/cxl.c       | 850 ++++++++++++++++++++++-------
>  tools/testing/cxl/test/hmem_test.c |   3 +-
>  tools/testing/cxl/test/mock.h      |   2 +
>  5 files changed, 720 insertions(+), 203 deletions(-)
>  create mode 100644 tools/testing/cxl/test/accel.c
> 
> 
> base-commit: 96ddf1af34f5f9e29891a5bfb7a18dd0a5bab9d6
> -- 
> 2.54.0
> 
