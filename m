Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42564355034
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769813188; cv=fail; b=CpN/BGwO6tLzx7mQbPOooIy28NuuiC/G0BRL3MoGhbaewU2JPHibnoiB3LfsrXgaRiHt8Dc86dKeUEw1d5rcssOKs7lqQo+klTCz//KGIp/eEU4z6UcWYxP3aJ4nfnQeCqMCX6ngEFX6mTJpHJxo/eRWpoclVSaW0Dd6P9/W0DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769813188; c=relaxed/simple;
	bh=/fLr6rAesti5WLUr9txuhWrIuEsIJRxVXmtmpoYn7IY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=A0zp+gljqc+ZH5lcSL5JCiAnb62meGqU7NTh79f2y+WZvHRfpviGTdvuog0Ch8rPqlxDojH0wEG+dPzyJT3hdLDy3Ery0lPLarVVIHMT/gK3koToPHd7Dcrmi4uP5R8t5UH5SgslnXBwZThYyUShwhDtkIPUete19TA+03T83X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jADMi1wK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jADMi1wK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769813186; x=1801349186;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/fLr6rAesti5WLUr9txuhWrIuEsIJRxVXmtmpoYn7IY=;
  b=jADMi1wKw1IsehV9Xyofr2VzKw5sW0t3pgYDAIeWXVWb7/ykPxeJ6Nif
   LsGkKDPspZuQkgTiCD0gYhxvoN1ztIEP2JmTPdEtvAx0CJ+6JUwPsks9A
   qDmkDksGqYszYFT8sU+5pPE+55hvNXyls89SdF8H5zezFfKjuz+jtlF0B
   v6zc12m3d+HDTyro/sB1dswxmLiR2relIu56wlM1aSs03rdrTk7serVvU
   PvaZdROjZRRgLo8aLvX0alofUMijji3hOLE/LYRYZOLPyqtaX/YYCaS07
   Xl74kONpJSeyO+tiVUYuerbfBjiQZL9cqeJi4h4acFg06ZI08/F+d8u6y
   w==;
X-CSE-ConnectionGUID: cwXoH/f6SOuLSB1N7FgjTg==
X-CSE-MsgGUID: aw+n8zaGSg+EL5Sw4MJKKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71048248"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="71048248"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 14:46:25 -0800
X-CSE-ConnectionGUID: lHtx0dgYSr2KHmNCr+WSMw==
X-CSE-MsgGUID: n+WcojnKREyY87qPV1GbeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="208958575"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 14:46:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 14:46:24 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 14:46:24 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 14:46:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQk71DbyNrK+1VzmYN8ezcoQ0+rb6qphhnyADKGQ8fDSXUWOVykkB4cTXtk9pAU6hzaIoUqQtDB/XF+H9B4CrJKaO1kZibEenbvMAm6Zjd201d7ECag54aUGYM6DfxNI348cXYo9LkDGtZU9zGJvFlWsM2eBUQ5D+dw9LE8KgszWqwnMEQwo74W019Ha4gmy417au9sYiEm+FKO0aOjdUUJQOHQSg23eTAW3yDSxkGrTWQ3oxIVGS2TIvtE8wA6skD1ONEPkNBBU7OV6OutwdJimbz5syVeNcly1BRY0oYr/uHusrCVLHG9zhqJvSPo0vhR1v/+wlRg/W5UlMTYFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhSnc1IktB73q6fw/OZHBtF9GIUYhFi6+Tesw8uxXcc=;
 b=mvFOaPxOEcuxEUoIn4QWyVEylo5eyOq54Ft5XZlFGQwV5m5kgm1l/FDz7DpKNMbXB13CEiqtkDc8ntV6czD+a0EdPPMBI9HLHfMGwnVRZdHtxP5g9ABoKc0bRU6TmWrxrG6aKYBEnkBIVfE7V/YtQ2jBCCqNHfkm1y6fp1S1Kq5ivcBW4KLLaaguMTbpIeAAcYF+CaoCoMKR4aUMlr1K/YA33zDVB46KbsllkMVFr7kpdACONBcVGsv5xleHSZRpd9fqJ9fslSsIZK/yWGxRwIjGVExseZZQ95Vawc7uJ7Apupzdrs/3SfiL8TbGbcvpZPnp9u0LvD+OEWQdgkj5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPFEF920636F.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 22:46:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 22:46:22 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 30 Jan 2026 14:46:20 -0800
To: Gregory Price <gourry@gourry.net>, <dan.j.williams@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>
Message-ID: <697d34bca8bc8_1d6f1009f@dwillia2-mobl4.notmuch>
In-Reply-To: <aX0AfDapYz6-xRYX@gourry-fedora-PF4VCD3F>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <697c3a6155b46_1d6f100e1@dwillia2-mobl4.notmuch>
 <aXztmSYih24WZgsr@gourry-fedora-PF4VCD3F>
 <697cf7bed7112_1d6f100b0@dwillia2-mobl4.notmuch>
 <aX0AfDapYz6-xRYX@gourry-fedora-PF4VCD3F>
Subject: Re: [PATCH 1/2] cxl/region: Timeout auto region assembly waiting for
 endpoints
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPFEF920636F:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e8eeb8-bd52-443d-b363-08de605163fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWNlK3MvdG1wbHc0S2o5SnBuQ3dqLytnZzVsOWZrZ1JxbFFQSUR6KzBsVUR2?=
 =?utf-8?B?UFBaN09JSlgwZUF1bXpkUHFGbUpVenhxb3VUK1ZOSnN0R3BZWCt2Wm13b0tF?=
 =?utf-8?B?UWtUODJ2d0VISXR0MjZpeGFkYi9CQzd6SUJGekNDeHFzS2ZKT3dIZkttOFVa?=
 =?utf-8?B?WWJCZ3JkR0RvNk04elo4M05yU3dab1VLa1dGYUFvUTlHeGNoVXp3eEs0Z21x?=
 =?utf-8?B?czI3b2RZMmIxSkZ1VVR4RjF2K1I5aHVWODZCRUV0aWNLSlNIbjVTaWhnMnl2?=
 =?utf-8?B?c2NRS0RxNDcwd1VJTjBESzRlSG1wNlR2SmVkSUpUYWJ5OEhWOHhYWk9sZVY1?=
 =?utf-8?B?dVNwenBtQXZyMDdnYkowU2Fmc3F1WURNbWoxRENYSEY0S2RoUXpSVERIUjRz?=
 =?utf-8?B?VHkxbHkyUWg2bVR2dkJPR0ZSbGpBYlFUbXFtbmhEZ3IrWGVxN05CTE9FMU8v?=
 =?utf-8?B?ZkxldER1dkE5TUtjVXo4TUNkUXdjbmE3THdwUFl2TzBpanBrc0U0UWJzV3Zj?=
 =?utf-8?B?QVo4b2xPdU50MUV6RVZXalFCamxzUWlCMHorYnpaUkhVbEdzSGx0ejlIQk16?=
 =?utf-8?B?aTVtN0t4Ni95WFAyZk1mWFMrUlRFbXQrczI2Q0FCSkVucEJ6RXdSK0dlS2Z3?=
 =?utf-8?B?aU0zOVhyeXZ4S01xWEJCUXg1aGN2b2lFSXpLR2hPaVd0SWc5NnBlM2ZoUktG?=
 =?utf-8?B?RDZlcHRwOUR3N3V0VnBEUFM5Q2s0a3pYNWlVSVZhc3A2Q1p3amN3TitCUHdh?=
 =?utf-8?B?VW1qR1Q3NFZjNGluVmlBVXRRYnBjdk4wWVNRTGU0a3pYMWtEaVZjaWRQaEVC?=
 =?utf-8?B?QmZUR2dGUzFqTDJwMEVzaWsxQjJNaU51cTFvbXJmQVRKSTlLTWM5L2psMkJp?=
 =?utf-8?B?cVA2d3hUUmpuWlpMcXZwVlJaR2RENlZYWXpiNFV5ZkhrbGtuR25wL1czb2N2?=
 =?utf-8?B?anZaRkduQXdDSnlzSmNMNU0rb0ROaWlyUGQ1YnVCSEdsbDB4K21IWG5jVnBO?=
 =?utf-8?B?K2l3eHNVbGRaNWc5dnJIWlFQTmZiU016ejYreGQ5UTg3c3V1MlZMRWdkZkhE?=
 =?utf-8?B?eUZTaEkxNXdsdlgxSnJ6dWlDQ0JiQXBETW9DSFIwbXJzZnZtc3NZc1hEWTZE?=
 =?utf-8?B?YTlPTVZWU3owa0hJYjdCa21lWllQWG8wRHppQll6aEJwMG9INHpsdms4aUNM?=
 =?utf-8?B?azZMY0NaNTQ3NHV0OWF6YUM0ZzFzd2QyS2tZY2dqRGpTTWZUc0FJNzhIejNJ?=
 =?utf-8?B?RzF1bytxVVhzaGhWcVc2bXNTZEVTNFVLZExnODc1MTA5T0F3MG5Uc2pOZ0Za?=
 =?utf-8?B?NGEyRnVOWU9ZU3VnYTZ4cExRYkVJL1QvNW9TVGlwRDhOWG1qS3dzeGY0SVRq?=
 =?utf-8?B?V3B4YWM1QjRqdUZ0YzRZMTYxa0EvbHJmbW5pdXRWdnlyTmdZM3Jsa3RySkhW?=
 =?utf-8?B?NEQ5bmZ2US9aUzVSVWFFRkJYT1htdzVPUFlwZDZZOGpTUUI0WUZhOXNnU1Zm?=
 =?utf-8?B?cit0NjVyMGRCTkRmSjhONDQvVWNSVC9lR2hrcG1QK0t0ZDZudGdBUDArQ21i?=
 =?utf-8?B?MDQzQjhxbjVxSUZjVFRmQnpJVnE0OXh3NWphVkZMckMrc1VqOFJsWFdxbFRV?=
 =?utf-8?B?R1VHQzlFTCtuVGxqNGxXdk12SkticFpINnd6RmJwQXBPVTRxbGpTVFRsMVJl?=
 =?utf-8?B?dGFzYThENUQzeFYwTTRiKzdUMndmdTVycnNCMlliQWtrWk15d3hFUmQzQ2th?=
 =?utf-8?B?U3lLY1B1MGtlUWhsSnJ6eEx1ZnRlU2VocDE1VmtPc1YxVzhGSDdPd255ZFVm?=
 =?utf-8?B?c2twbnEyN2kzdzNOUUMrUVFoNWhMV1E3N2VxTEJ4SmlBRkN3dExLc1B2VnU1?=
 =?utf-8?B?eHpRVXdtNEdVTXAvdGNuY0FTeWNZcStPd1Y3azV3NEU3SFZyTSt5RDA0ZjVY?=
 =?utf-8?B?azllOUkrOU8vMTZFMWJVWGY3ZlpDNW9kRDl5N2ZreGNIa0hWMHM1STNVdnFy?=
 =?utf-8?B?L1VIU3dDTnNldFJqbFNJMHRLa3dzQ1NmRytOb2srd0ZVQWIrQUdjVmZIbzJl?=
 =?utf-8?B?UC9OcWFRUlF1YWRmK2xraDIya1BYVmViT1FRempnaEVpQ3dobjFkbGdtWGlV?=
 =?utf-8?Q?fIAo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFU3NytuN2JLZy9KLy9ZSnhaejVGamc2OEtLV0gxYzNQS0hmTm11NlRqQTdW?=
 =?utf-8?B?d2tZVS91Yms1Wi9rL2lmZ21melNuc1BJOEYzRXVuNzhNUkQvcHAyTk40ZjBE?=
 =?utf-8?B?cExwNlNSTkxycFZ4QU93SjhxZncxR2U0dmlKMU1Jc21HajJVbE9KS3JFZkdi?=
 =?utf-8?B?R0ZOOW55dlI2MGp6VnNRV0c1M013U2xpMWVmMmwvVEh0U0kyRzRudmo1cG81?=
 =?utf-8?B?dWo0VEI4dkMrYmM4dnl6S0tONGRwR25nRGVrVUZMSnV2ckZ4clp1bytVRTll?=
 =?utf-8?B?cW9LaUdISml0Z0NhVFI0YlVjZWpVM2JRcUNxNXFzQm8xZlNLTDBOc1RtUFQ5?=
 =?utf-8?B?ZXVwM0NqYzc3QUYxQzZuanVUN3BoRElKMlp4YzNlcTFSemtIY0FlM3I3anFF?=
 =?utf-8?B?RFdaRDd2a3FhUkNGcktPdkNTaEE1cHNzMUlyVCs3bE52T2FjZExXOUI2U2Qy?=
 =?utf-8?B?S3k2eExKL1llOEp6cXBUSTk2Si9wUE9WcjJ3ZFRqTGI0Ylp5YmlMZDVyUito?=
 =?utf-8?B?UGVxZ1BCK1ZqZmJrQnhBcDZoWlhNQmZ5R1FybXJIanBsQVp2N3lwak1tbG9F?=
 =?utf-8?B?TE0ybEx6S2Z5Yktzb2lCK3lFaUs5d3E4WDJMY2hwcWczMENMWjJXYjkxVnRs?=
 =?utf-8?B?MzNwSzRaNlVMSndyeGQ5RWZjUjN1NEsxSmRiZy9YUy9zZE1YSThTVEt4QWtN?=
 =?utf-8?B?aGg0SmpyL0NCNGREMktZaWFkME01bnZuZmszb25wMU11YXU5MnRkNmxVYkpB?=
 =?utf-8?B?Q3FKTGQ5N0djdld1YWtOUWZRZzlpM2l1aWtPeHYzN3RiTytFSy9hSldaVjN5?=
 =?utf-8?B?aEwrc2RaQVR5NzArVzNHc2R5dWlCVmJDQXgvd0pINmc2Nk80cG02N1RiUjJP?=
 =?utf-8?B?cUVjamJWTTRpQmZ2RlRNc3dFWWNCQUxMTUVnMnBPVVoxTDFSdklFTTNlZWVI?=
 =?utf-8?B?a0ZuMXNScktLVG1GS3lJZE1RaC9tYWViSFVHc0ZwRUlJTWdIUlkzTWhMUXgr?=
 =?utf-8?B?cW9wL0R6SHJBZXRsRzQyOXFSZDVBVmkwOXhhTkdad0d6bzI0QzMzWVpJZDFv?=
 =?utf-8?B?S2paTmR5ZnVBbmExWEdWRDZlYmdaTjIxa2RoMWczT0Y1OWpQSVBaNG9FMDcz?=
 =?utf-8?B?b1RWKzZuYUlLbkRneTZ5d1AwSm0xMW93K3BBbWc3cTFRWjJqSjZRd0krbVZ6?=
 =?utf-8?B?c016T0NGQlZpSVRFa3AwYlRxd1lXNHJhZ0Rmc3VBSW1XeGxyWENBeUQydG42?=
 =?utf-8?B?L3BZc0RCRUxUVExQaUVhRFJVeUUya1pwbUJzMG1LdDcxYlB6QVlTcmdFZzdp?=
 =?utf-8?B?Mm5qcDRtazR5UlgrTndsRzFCRnRaWTVRNXlWdjd4WnlqVUJ2UHRXMlN6VmMx?=
 =?utf-8?B?dWkvQ0xsUmR5cEwwL1RDMkh2c3FiUU9hdGtOT2Y3ZTNYRm16SXRIY3E0eExt?=
 =?utf-8?B?VndNYS8xRzN5TVRUSXVDbmtZbG5tdEE5M3ZPanQwOGROenpPMHBCOUNwQTFK?=
 =?utf-8?B?RmFWL0lTVDFKaEhFR1dpUFptWDBXbHUrL3B6V2QzQTlLTWxncTltbm5pTkMr?=
 =?utf-8?B?ZmtQS1ZUWmVNVWpHa2xNREFiVHRuTmJMYTYzTmFacnp0bFB1UGxyKzBvaXFu?=
 =?utf-8?B?VE9SSXE2czM0V3pML1JwUUdzVlk0MWk3eU9HK3lZYUhkaTErT2J0Q3dmUzNM?=
 =?utf-8?B?MzRyN0U3ZjJTajBubGU2WGJ3ZWRZMklUd0ExMmY4QWE0OGM3MHgvNENnZFdO?=
 =?utf-8?B?cVhhZ1UxNi9xQ24wdnFwOG9SOU5kOGdSb2JmVnhucFdXZ0FtMllvajFVK0c2?=
 =?utf-8?B?UXJqazlQb3Z4U1FDQ0h3akFrRENyRTI2S3NlcDJYTWw2ejM3cVhZR1BoTDl5?=
 =?utf-8?B?YjZKV1pVU1QxcjdJTEZDaHBQbDUyT2hGbFZnOWcyK0RqSGo5Q0NPd0wzdmR2?=
 =?utf-8?B?R0hIdnpJa0FzUS8wQ29rRnl1eVhJbllGa0IvcUs2aTZzVVlqdDRvZHc3Vzdj?=
 =?utf-8?B?UTVraVc2L081czVrejYzMGJISlQ1d3NiUklmOExQcHphWmZ6LzBraFZmOE5v?=
 =?utf-8?B?Nk5rWVNZdGtKVmhhN0Q3ZGo3cVQ3K2lZajloTGdQRklNOFBkbExpck5sTnY3?=
 =?utf-8?B?ZXRTNk9xWnd6WEtlaEh0aWVpOFpZY25jNTc3bHlKNHZOaWxpVGFNaGplUnNU?=
 =?utf-8?B?dUU5b0RJQW5MbFFEcElOMkVobWRvbCtvSDFFSzBDUzJ3VVdWOFNra0JKcjVs?=
 =?utf-8?B?b0hCdVNnTFA4OFpCSjNGMVNSZUFNSWNDWFFoR1RFRHNwdzgvbEZuVDRGa2Qw?=
 =?utf-8?B?OXFha2lzSW01MWRIR2NGT2U2SzlYNWtQb2EydmlPVkZpKzNSQlBqb3pQRmRY?=
 =?utf-8?Q?ohA870xoWThFPvyY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e8eeb8-bd52-443d-b363-08de605163fa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 22:46:22.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tx7LPrBFoTk9pNSlJPlLISA3FDz2mP6fsF1BNULDQwZ5si93xhmVs/hI3wFeIsep4+rRqfWUa/npOOHzJU58tjuAtC0mSWe/Y9Wt5PYGPlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEF920636F
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Fri, Jan 30, 2026 at 10:26:06AM -0800, dan.j.williams@intel.com wrote:
> > I do not see how we get into this situation. If dax_kmem comes up, then
> > there is nothing to clean up. Yes, these can race, but typical locking
> > should ensure full forward progress or cleanup.
> 
> yes as long as the watchdog checks for the region actually having come
> up or not before unbinding, it should be ok - but then it seems a little
> odd to push that to userland if the driver basically already has all
> that knowledge.

A couple observations:

1/ cxl-cli already knows that raw region unbind is problematic, hence
   the doom and gloom documentation around the --force option.

2/ The driver does not know the error recovery policy for region
   assembly. The mechanism being enabled is that, in the case of CXL
   assembly failing due to potential platform quirks, there is a chance
   that the default DAX fallback could recover operation.

If the fallback is always broken because of the insert_resource() in the
construct_region() path, then that constrained problem needs to be fixed
first. Once that mechanism is fixed the rest of this becomes a pure
policy problem and I argue is suitable for userspace to handle. The
incomplete region is the kernel telling the admin the unvarnished truth
about what it knows to about the CXL topology. Same as an incomplete
RAID array.
