Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588B23EA93;
	Tue, 17 Mar 2026 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773713449; cv=fail; b=NqoZUI8qQFnsp17Z5j7j8sm8C6q//jA6vGtMJZsLKy1+c77HDr3gKLoalb+3Qk1Sn7XFmXckTC8ZaZT/F05vzHivZh4I1Q5GHpPIgUNOZw4ZLqlmQxAEUjz5G7FBO77wQ/Tl+pKnOGMVx0GFlP0fRsbn2CtutOvHjFSTqPWjafw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773713449; c=relaxed/simple;
	bh=fjnaSWMj3el6HQ3+yONq6McP3qsT9YNpB8+I5l+xtE4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ASSBZNHqMCaL+Bt5SfO6fcuLlrWgwv5zBjDE4g98mFti3T5LC2LU4adlWrBjBHFNMluI4yA/65vp0s2jcNR66n6iQH9b7xkwehgeyOdL0cd+x+E0cCdylGrPPsTKkz3YpX9TputgZ310cPnKyFCOwT5RC1tTX7LKzgF2cTaxWkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3COX+lb; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3COX+lb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773713447; x=1805249447;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=fjnaSWMj3el6HQ3+yONq6McP3qsT9YNpB8+I5l+xtE4=;
  b=O3COX+lbTZ0vLsNxSwsNc5URp+sQyqmQIkJ2DxEyDja+LDhAlExEXJuk
   cmIbssIQKUcv0q1e7p9WsWLOzZschtkqfmKpP0iPgGM+qxAKLDbwG47cl
   v2epVpQGSIu6HNkGVIK6nYpBbM1Oilfg66RRuZMs9QLCDH7uLJTVKjBFx
   PS/vq4J3dkRFNrmrH1v8jlcLMVmfdMlYK3WgWJfxYdtgIj6iIsbN+1m0d
   Y7EQ9VcpEaGtW1wDMwxFuvwRwvvZK8qKBboUgQpam32YLKyoyjEL5Msan
   oinU3HcvoY0BXbMMy3o9nAHoWosvRXm9lpi2tLxGHgja59su5dTwWUC2g
   Q==;
X-CSE-ConnectionGUID: 8qQD0Mn9TxWanH9UEpORNw==
X-CSE-MsgGUID: De8K4YvVSdeK4+Q5ycDHPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85436362"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85436362"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 19:10:46 -0700
X-CSE-ConnectionGUID: XklULbuKTRSM8slRj44Hdw==
X-CSE-MsgGUID: oP8vD4TOQ7WrGX4GIoPz3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="227086226"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 19:10:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 19:10:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 19:10:45 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 19:10:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imQs4X5/ISyyf7LlaxlHT+SQQm8D90AeuMWd6EBW9XmOEMeouUYZr8zWaFX04Q5Dk4RjzrpbUoyE4ZmMR5kAhIqZ1ppGg42/+oRg3w++GtUaox4ttGQJWsZk2KeED6cs5kSIdcPOQyv1YKOlHJKyWrraARA8arfKbHEsXXHI5rDmf8J+JYSy5wgpwpLMX/gdHcO/xvmSekz9ofhu+olENjVtkgUZ65DAkkww6AxeG70nGadQTlvW34aNP5w00wq6esUoYNcz0yMEZ/zb9wA579rP/JAUFd/wDA7Oy8GOkO69yhKoGg9JgrIr98jh9Gv7MikgWe9bV3GohS8hXc/cGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpZIgbnJ1kuT0RyY0FSzJQllTfkPRp/M28t6OqtvjKg=;
 b=QFsGimmga8rFhKXFsJb2x0WaZ86G3NCXvTxp7GAfYpk5Y2rL5end/pqnP3b55ssAaX5iDYc/O9HKKCv3DYO7u57xX+HtE7IonlYkhL2VSK+lob086M3hYakyG0TUgkU0RzdJUvGZIdE5ZsKu/2FUPvSnn5FaEutqOYom1bHYQnjSkwdtT+MLkglTiMxY9c24Jp8Wys6/1l2fB5mLqd9ac29L6qGeIZOg25WgbDOiq2W2O5jZFHhxDZGXYeATxZybHDQrpX3c1plemchim4YPOJqyaOEnqBR2SxTIsbhjdVGnxvhGh0wlKPNnK4hPydeMBOpkaZhnmLlNT7SgPgTjSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7463.namprd11.prod.outlook.com (2603:10b6:806:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Tue, 17 Mar
 2026 02:10:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 02:10:31 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 16 Mar 2026 19:10:30 -0700
To: Li Ming <ming.li@zohomail.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Message-ID: <69b8b81621e16_452b100e@dwillia2-mobl4.notmuch>
In-Reply-To: <13a62481-256b-405d-b2da-dd30b8cc6689@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-3-94fe919a0b87@zohomail.com>
 <abCTsNbGoOpjAn5y@aschofie-mobl2.lan>
 <13a62481-256b-405d-b2da-dd30b8cc6689@zohomail.com>
Subject: Re: [PATCH 3/7] cxl/region: Hold memdev lock during region poison
 injection/clear
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: a48bc6b3-58b8-4819-1261-08de83ca5df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wIk47mhXvNQGi3ux44iNLLxA9gSVECKFGb26TZ9kmgVYcl8zvTCb69Lx7PfPLlt96XP9cZog0bjfrofmzlyDwqLtovCXfGfiGOPbb3q+ut6HaiMul7qpIJ9zKecY4OHPYl62cmxLpdEA60/F7Z6hxsle/T3Yh744Ei1i5rlWNanLlijx+t7s7SxhmkLy+atMtF6X/VS9oYv3Lq2RGZJ7qbLetFN5chG+ZarWbe3zDhQJ75ZfXKzaN09Mc7NLd9rr4jjuV1v8VCLLsdXIDdHKS1XfF+79X0RRKb8nNUdrLYshFsYTu1I73H6NOenurHBHZi4cw+59MOT8gKDNl/2vPuhK55L2epPxGLwZFlrzJ8HkWDT4NxQr9HhYseevCFNU9ZKhnUjQeCBAltINoJsXC4wAUWQ3hWSAbZIABS9JOf5fT7vrcEeobcs195FCgDoWxtC8MnDdpkqXch+FcIywWtU9Jxqa+KtYKrjLoIrKWEiaWv2mdbtGM9Q2dWZBaHAhaymy+rPnm2G3+fNTaethDsjg4uP5j/0Taio2FF2En9HzK3mlf06SJL0HNslu06NoEnZ3QS4kox4vN1HJn5PgzZYFKVniAfyujLoc5MAKXSPPJQXNLIy6EBD0/sYq7lu557sryvRIKFRPJSIPqx07tj7dgjvtsFOn9NY141NIUasjiLf4dQkeNN4Kl+dOplu1ah3PzfGt26MKBh7VV4a8y7Ck6gs7FZU4ARoY9Ndvco4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFZazNQNjB3L2lWTGRTNlFZRzV2TUNXYy9PWDRDZmxjK01xbWJRTDNZTlRa?=
 =?utf-8?B?RUQweWVKblkvZm9NSklzMEpqVVFLbSswQy9MSzJFVUxSUVg0emh6TEthTkRv?=
 =?utf-8?B?Z3ZOT3NqTURtSGpjbHNTRFVDVzF6VnpHN29rTUtSeHhUVzh1Sy9BNGtUc281?=
 =?utf-8?B?UGI2OWFDRDNIL2pzUFpLKzZkSjlLMlFqdHZ4Q0JtQ2hJUXNrQ2trb0Z0U3Jn?=
 =?utf-8?B?UUxPNTJYdWJtZ2Z2Y08rSTJ2dUl4NTdVU00vQXByNm5WTE50NmF1eFYyaGx2?=
 =?utf-8?B?WWxORUI1dFI3SlB4emwrTXdyRFNTakl1d0RtMU1scjZsOWxtUzVBcHM2bHpB?=
 =?utf-8?B?YWs5VCtyZFErbmQ5MkxrN29oSWhEVHVtNzFZak83RlYwVlNXcE1URGdZYXdF?=
 =?utf-8?B?emxGTHd6amplbU9XR0Nsekx0SDJibGJCUTNNT2tXS05DdUE3TXc4S0kvWVE3?=
 =?utf-8?B?ZURIdldTMkJsc2JwOHcyc2Q2Nmg5S3JPR3V3K2FmUk5pcDlkTFB2REVyWXFy?=
 =?utf-8?B?RG5WSm1MTGVseHY4eGJpOFhTY081aHRqSE9YT1V1ODdtVWcyTGZ5cmlMTklv?=
 =?utf-8?B?T1ZQT2JVMEVTSXp1Vm9ScjhlVXg2eWk2V0Y0TkpHblRPU2ttdmxVTVB5NG1h?=
 =?utf-8?B?dXVqS0NXSnRCSnl0RElqSmJLQmpraGtqYjFreG9DcXVlelVzeThCWU9aTllZ?=
 =?utf-8?B?N1lKeVhpakZCMlhXWVhPdGRBWmRVVEo3a05CRy9WWVlzQ0hMSS82clR6cXNY?=
 =?utf-8?B?aExjV1pmbkpRTENyL1RTOTB1TU43cS85QVhPQUsyQS9RQ3JxZDZzL09wU0t2?=
 =?utf-8?B?LzY4UzI5SFRubGN5dzUvTUpsVHFqbnZZS0lGbnBSNFBVWWg5OU9QcmVvSXFm?=
 =?utf-8?B?b2VzaDlycWpDK24xaW5LdURCdllqUlVMWk1YOFA4KzNDUUdvSTVmNDVXaXRs?=
 =?utf-8?B?SjhTSS83YlVnYUc2OW84STJWOWZsNmtSVzA1NHkrSU0zMU4wNTA5UVB0a0lw?=
 =?utf-8?B?WmNIb3FGMFFHNjE5SEFjMnBaRWo1UHJPR1lXeTlKTFgrdzNJMmtScDVPYkV6?=
 =?utf-8?B?aVZvcjB3K0c5M0xGZisrWVc3SlNWeDE2bDYvNERYdVVDbll1MHlVMW96WHRj?=
 =?utf-8?B?Z0NxNDhTdDZ0eFV3VU91WFgvZmd4bVVqYmdZMWQvU2dKSjh4S2xqaDdaajRG?=
 =?utf-8?B?NDQrUWo3SkZjQ3hYd1YyQjc4V2JSc0trTGQ0dGlzVXJ5MmxOVHVQZ1AyYzNC?=
 =?utf-8?B?NjlCeG4vZ3hMeWJ2Qk02Z0hkTFNOTUJzeXNSUXNsVTlaS25qZXVmN2lVa2Rl?=
 =?utf-8?B?K25sM1FMdmZPMG4vZ3JwR1JFYlVGWDEwaS9ueHRPYTNHVHFFZGZpZ2ZyT2p4?=
 =?utf-8?B?TlJMcGRJTnpwQkFWMWVDMmR5Q0xOY2dsWk9KcDY4bXRGYlI0clZBWlNDNWlu?=
 =?utf-8?B?RWtIb0lLcEZ6UXBpKzJZTjlxL1VLYUhPUEpPd2ZKejdTQ0JScy9paUQ2alhz?=
 =?utf-8?B?Yks4cG96cFN2dnduS1JYRTZ2WDJEZXdHeGo4OFYrZEhnTVpqUmxPUnczQXlF?=
 =?utf-8?B?YmNkcFp4S3Y4UjA1WlE1NStKZ05zd1ZvOGlib0ZWSUlRTHNGMUx4OHJSYnp3?=
 =?utf-8?B?bDhnNFJFZ1pUc0piUTNrOGRKNHNmSUVBWFlXWFpIcjljT0hkREJzeTUzNFNC?=
 =?utf-8?B?T3ZJR3RmRytpcXlILzZxRVlybnNsdEFJSllSUy9odlJJTDNEWEgyOFBRQzBF?=
 =?utf-8?B?Q1k4K05jS0Mzc2hEOXk3U3FQQjlBdnV0YWswMTRPKzhZWmtwNEZZSENWU2Vm?=
 =?utf-8?B?dHVZTU9Oby9DMERqcmtXc1dseVZrTjJVOVFQbkY2S3hza1JZYk1YY0xqRS96?=
 =?utf-8?B?a0t2VVpYUXl0WTFFMkVwY1hsbUtvYTZzWmRzN1N5VmZBMDdkYSs1M3NUNUhC?=
 =?utf-8?B?UXY4RDJ1bERRYXhlL0dGa2dLRkZMQkZXektyRDNCV3ljMmphU2VuRTQwUU1l?=
 =?utf-8?B?MDlmb3p0R0kzSm13YUhDUTdmeklBMnF2MHBmcHBSYktORms1R3Z6czRPc242?=
 =?utf-8?B?bzNBdmVtUHNHbDRoc2Zka24vcjFTRm9laEpOYWY1VVFqRmhvMXBDT0VGUURI?=
 =?utf-8?B?d2FPNTlHcDl4YjkwTXJMYU1JY0cvcnlXM205ZmZmQ2ZuR29QQmRVOVQ5eTZR?=
 =?utf-8?B?SGFUL1lFYjRHTFdvem1Yalh1ZXRwRHNjSWc2a3czUWExR2t3NFJadEZ3RGJQ?=
 =?utf-8?B?aWU3M0d1VFFaZEtnRW9UOW5MUWxZNElvNTl4TWVDeUFzdGhmL2VyN29SMW9z?=
 =?utf-8?B?bXNIaTBiSDlsTFUwMy9wS2dzV1dLa3BMaEZ5RWprZUFlWW1RL0RmR2tOM1d2?=
 =?utf-8?Q?gMWmSnkq+9C7du+E=3D?=
X-Exchange-RoutingPolicyChecked: ovK00/YnfsFLefnPtcl+arUC2YWvx37wze3PhHdj0G4M9aKVKjyXAc7jNRdl51s0pZP9fFYWyOIiRHhzyl/XyCFl0Om4vzZ3E6/1rTVsV6LC63Qa5JWMlRlhieKbVbKFd27Otr63yFDxJHo/zuZz3WYX3/271CGRzypzEOMPlBgQV1xsrjP3A8KXC7rUsuxEwr189uyEm4TaJnxiRlJsJ0CR+BkLoYd3TgXRrFwiCRbFw9OanUAzgFiv9Ly/dhCeZD74e/uKTHNQ4nhnpzxGeSqmRpcKZLe/XG3KLRVOmq3M9rcnJmzP3V+EEy3Nx5dbThpVhRrlEMLicK7bM1DirA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a48bc6b3-58b8-4819-1261-08de83ca5df1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 02:10:31.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAG2fNcR518cgCCX6LOJyH2v7eYGcB2jalsajCE8/OkrCwxhYNVHoFwfpZ3VfRbMKGqbKSSeBlEsS08ODNvURbC8T+sdxTX4zEb/OaSEpJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7463
X-OriginatorOrg: intel.com

Li Ming wrote:
>=20
> =E5=9C=A8 2026/3/11 05:57, Alison Schofield =E5=86=99=E9=81=93:
> > On Tue, Mar 10, 2026 at 11:57:55PM +0800, Li Ming wrote:
> >> cxl_dpa_to_region() will require callers holding the given CXL memdev
> >> lock for endpoint validity checking in the following patch. To prepare
> >> it, region poison injection/clearing debugfs interfaces need to ensure
> >> the correct CXL memdev lock is held at the beginning.
> >>
> >> To keep lock sequence(cxlmd.dev -> cxl_rwsem.region -> cxl_rwsem.dpa)
> >> for avoiding deadlock. the interfaces have to find out the correct CXL
> >> memdev at first, holding lock in the sequence then checking if the DPA
> >> data has been changed before holding locks.
> > This seems complicated, that this path needs to do needless work to
> > comply with a new locking scheme that this path doesn't really need.
> >
> > One thought, if in Patch 2 we lock at the debugfs callsite for
> > by memdev poison, then here, we don't need to think about following
> > unnecessary locking protocol. I say that because I think locking
> > down w dpa and region rwsem is enough here. Then there is nothing
> > new to do in this path. Might that work?
> >
> > Along w that can cxl_dpa_to_region() go back to safety checking as
> > opposed to the new device_lock_assert?
> >
> > I haven't gone thru every case in this set, so might be way off ;)
>=20
> Actually, my understanding is same as yours.
>=20
> I think we don't need this patch either if we remove the=20
> device_lock_assert() in cxl_dpa_to_region().(Just keep the=20
> cxlmd->dev.driver checking)
>=20
> Because region is created only when endpoint is ready. Detaching an=20
> endpoint from a region always holds cxl_rwsem.region.
>=20
> But we always hold device lock for the device driver bingding checking=20
> in CXL subsystem.
>=20
> I'm OK to remove this patch, Let see any inputs from other reviewers.

The question is can cxlmd->dev.driver be invalidated while userspace is
pending inside of a debugfs callback?

Yes, it can. Debugfs, unlike sysfs which uses kernfs_drain(), does not
flush active threads inside debugfs handlers. At least not as far as I
can see.

The next question is, are we protected by the fact that a region needs
to disconnect a decoder and it only does that under the rwsem held for
write?

I think the answer is "no".

If the protocol was to have a region in hand and then validate its
locked association to an endpoint decoder then, yes. In this case though
we have no idea if the cxlmd is associated with any region at all.  So I
think you can theoretically race injecting an error to an idle cxlmd
that is in the process of destroying its ->endpoint.

Now, maybe some other detail saves us, but I do not think it is worth
the mental gymnastics of just requiring that no driver detach
shenanigans are running concurrent with poison injection shenanigans.=
