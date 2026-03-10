Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8A346E73;
	Tue, 10 Mar 2026 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171246; cv=fail; b=ojtLiSBXI1JR1nQg9pejbnlDFWA4iRwwIPttssCMkcC9qrAIYQ/Uu8si32pMdY1TrpCUJgTZzOc0jyZzqaZvaWg8SfN3JQtsGaT8wAFavRwGU48+meOXb60HOlv7Tcpad7Qcu87Cc/Bzr/bMaEs77bEldgTKJLJaRdShhci7SpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171246; c=relaxed/simple;
	bh=JQPyY3do2L/MlF4Ma4vjHjTfg+OQB8JA/3c9cKvWdnA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=aMgxcRRTrH1r859lYxzFdZmk5Y8/gZ9bptI4KPBZL7/3oNDIUM3NYQL1WHyW5tB/R8Y+XvpCuR5dj3XzLM1otJwj6OWlmZmtWak0qPav89dUE6b1lVL/WA+cBWBqN+BpwFlyZseBBnsxlCTBE6BgRoRjNx+oc5kdAgJlEgf96II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qgv80+9j; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qgv80+9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773171246; x=1804707246;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=JQPyY3do2L/MlF4Ma4vjHjTfg+OQB8JA/3c9cKvWdnA=;
  b=Qgv80+9jUhnyMtamQ56l/0jUgwNqTCfUONmgrS8lRiG7GqI2TZG1PvGW
   1uDRISPnabjGEJtePSiRgqdTGK40RpsfYsjCDIQbABpdigB/N01xnHiUx
   86xN8mUSdcL9wcEX6DbUCswmnYEYXkNA39I9URCGgjPPeOJK14LDcpF0h
   TvxFLPxK3jPechNGGlbAFfxmt7EerlQT5yXs6+W/z0L9FIeo5bBXt/mAB
   5314RVidmKudHxavaFAdNCPH2NjJLrbiUkQMB8n9tp3Fsex2N9QmwEeRR
   Py4Aa5x2kmbUjCN4NJaaXgY+lzhYIIECsMqG4owQF2ZeqdWvGo1LwM0ab
   w==;
X-CSE-ConnectionGUID: FSacNMhQQ+uizA1wbzOSsA==
X-CSE-MsgGUID: qCA2mRf1Q8aY/D8vViaw7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73930427"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="73930427"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:34:05 -0700
X-CSE-ConnectionGUID: 1rNnC6KBQb+Yb598GqxFrQ==
X-CSE-MsgGUID: QtbBqi8hQPSdHLxKN7Etug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="216555966"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:34:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:34:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 12:34:03 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3sU+RTnbMfW1VU9CkIoHh9mBwSWJ/j6lZa/zFSzhvu5iHC9UWQVSY2eu213aZtz3w4PkoL8u7C+z9yRyqdUn7LTn6GR9cLQwxpQ1LdfpkHGXB1RgmKxkC3C5Z+o/YLtv1m69SvXo7KzIzzw5nMEmbEa6xx2DI6/u23whHBgZPCfKS8EGJsk3OCIFa6WEwmcqY3Ic5xwYAxdCmMl4mYlslmsoPzYrKY2niCQRE0rOUwXR6P6gMi2NuB2p3D8/OizNz0ir80X5zc1zlpgvuhGGsHlhqk+NLNB6Pj6VQDxiaLaTIx6FpLPMV8vW48efee4wYGn4Shh2TRtwfSifmcAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQPyY3do2L/MlF4Ma4vjHjTfg+OQB8JA/3c9cKvWdnA=;
 b=I7rD3elk8yFlnBnnX5tXSKNZnLhrmqEPtIoWN8P9iYfb+Z1M3sISQpYWsuI7RAUnPipf+nz+1phboykNsmRn911uUeS3rmOkK9gkugdctKd28JXVFMrnQSrzZTD0nUSjZB980H7q45RVDbpBh/aPIiB7N/1zuNSwmFJCRL5qa0AT0Q9N9Z+03RR9BFReFz+9Eikgng9xFUgwecxU+8ybelt7u1qyPuAN8yKpFEaCdsDGTgLTWR1NqS3kfZ0dnN5htNmRFEKTrAfCtye2k8IRrCuCx1p130/PN5ikhGVinzonKl2yfl/W7Ky3IMyMgs6d7B2JVwFMg4eYiGB7h29IUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8104.namprd11.prod.outlook.com (2603:10b6:208:46c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 19:34:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 19:34:00 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 12:33:59 -0700
To: Li Ming <ming.li@zohomail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Message-ID: <69b0722764c48_490a1007f@dwillia2-mobl4.notmuch>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-4-94fe919a0b87@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-4-94fe919a0b87@zohomail.com>
Subject: Re: [PATCH 4/7] cxl/pci: Hold memdev lock in cxl_event_trace_record()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:a03:54::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c156da-0ec4-4944-1e79-08de7edbfac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: SOdvVC30Oi5RFTiOzTk9PJDY0/2bM1L8gkSNy2qMHgN6T5FH8i19QOo6Tr582V1NwrJSGvnsZ4pqoIKKW6534Lz3KRWpZo6WnlzMyB7KRQTbF7NpZyS+GJbyiEeb0hu/M1oa6vhC4FFC3we1GTIJI549/XAVWqKiG3UEQk9A4L9KRw7dCj0DgL/ksvZMYdeW4uS/R7uvoDZ4FRAeRR49A+9sygLXqdzABoSHhDE+W9C+GCaywoH1x7jKOEqFUYVonbidSG4lrmvYYZto7zHEU2U+0GIUaNBgiy0ygiZB1Pk5bzYpjw61vHUSKDvzh9dW2mlhjOjapQ6B8qlz8JRkFTIHZzoDXy/18Uss5/FU22XTKqqI6nGznoC37NlQH+X2ppv/w//PMT4q2MwxJ0a3okmn0CQXYzlKehR+a8mTu3OK9mpQ5QPPgigGYuEJNmcn190d6uj4l/BFTtZLgHr5CDNF9a3K2Bm069EU3EaRZPMmHL8pM2kVVp+KF6RFDxBY/QQ6hZ0/IVzgWW80LgWOmAMSheQHV8647nV4UmMje+lkXSiXxdG9jT+3BZGfj5Je35v7naailEenMDmMtRGJJrNOvEc6GeWq9EEOREvT0OxDWRPuU8rJK/lLdOf9XglFXj6vDR+8eNjUM56qIXX8OEkwnbSc3jBIYnqj2VuEiVkJVg+Upa3W4CA6PYymsoKM+nJ9WIP3WFXboCU02DcXoozfOwhLi4dN8EPX30m4v+mF/bTW6XO48OBIiRkPqDqxIkEFHrsbKeawhH0ASpI2bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk40L2lUS3VDVlpSMXYzM1gxRWNCU1lZajB4NWdNOVJzcVJqbW84ZXZmcVVD?=
 =?utf-8?B?Y3BDMFkrVW5icUNSdEhDWUd2MSt3clFRQTdNVXJiMkNydmpLZkFPWVloNElq?=
 =?utf-8?B?cTV3YXNSS1ZsZ0NGdkM3cDh0Q0R4UDZkZTBpcnYzTy9HZEhCSHFwQVVrdFMx?=
 =?utf-8?B?dzVzMlVLSE12MHczcFAwRlcrMEd1dzdsbXlaS2J6WGtDRmV6SHJzWkRENzlK?=
 =?utf-8?B?SmVNbUR3YU9SYi82RGZ6SS9mejk3dGJvSEVSdjZPOTJJME5mb0dWcWtVZU95?=
 =?utf-8?B?Qmszdm40dEVObm5tODQrSm4yZWE4TjNtVmY3dk5ZVWZ4bHpjaHVXdWJtMXN5?=
 =?utf-8?B?VW5mbDE0M1hHN1NKcnpqb3NXSjZZWU5nMHN6M0lBNVR5MkJjRytGZ21ITUdH?=
 =?utf-8?B?N0FRS0YwSnJQNnVKTVdCTXoxMENhNmtaRmxjRDJ6c28vOHI1clp4eXFNWnRl?=
 =?utf-8?B?QmdYYTlyaE41OTNEV3A3VGdnU0ZhNHFFTEZKalA5OW9HMmY2bm8zdTFjMzJj?=
 =?utf-8?B?UUZkS0k0dy9ET2UzeFA2SmZDUEQxRWNUYjArenVDaUJOa1h6WjN2TnoxM3FJ?=
 =?utf-8?B?VWxoSHYzY201U2Vjc0huV2lIbE9leUFPcFBKVkJPMWZYeUJtditkZklzVXg3?=
 =?utf-8?B?N01UVXc0UldvTXp3bHJYaUtMckFIWVkxeSs4cDZweTVUL1ovVGoydmNKSHM2?=
 =?utf-8?B?SGdSeTNhOHlsZ0JmU2E2cUVlbGN0dm9OWS9ORzhNcFdGaWNNclRob3hsTXVm?=
 =?utf-8?B?LzN4QjAzV1VOTHk1RTVxaStyY2gwdjJwcWJOdmFsclVxWEl3RDY3czdaR3Vm?=
 =?utf-8?B?NHFYdFpJN0FKUG85bTBlWHF1SHgwNG9nREdVNWQ2NE1CeWZscEdDZmR6aEVv?=
 =?utf-8?B?dEl5bXlUbHlYdTlPQnZ2a2RmQjVLNStWT2o1cWp6MlRPQ09lWC9PUDJhYnVY?=
 =?utf-8?B?VzlydWdCaDRuTnd4bHJ5Zk5lSjBETGdDZ3hZL085WkhrMGl6MkRjNjNnaVF1?=
 =?utf-8?B?RzhYWiszZ3lJdHNSbklFUG52SUV6QUU2RnlkaFpDd0N6Y0xvb3IwZHZxbHY1?=
 =?utf-8?B?M0JoZjVPOU5tN3k1dTJEV3dzSElGM0xJa0VadXpoanlKdEgrRVlMT2FPMDFi?=
 =?utf-8?B?MFEvR1FTOVBKWCtuYnR4N1JlZmgyUlRkRVVINmcyYkZLcjBSOXh6dnk0eG91?=
 =?utf-8?B?Z0dvZVlrRGUzZEdBeGxrMEFhMFhSYWxWYU11RmxkOEVpWFdpNWpLckpGaXZG?=
 =?utf-8?B?OTJMQUh3RDJ4LzFpM2R0MXRNV0NkM1VKb2FFYTVoaFFRL2U3bWVUVFlWQmJu?=
 =?utf-8?B?cDVFZXlLQjZEUjFWakhzOGdWTC9kK1F5NnZRK1FiZGc3V3ZCTkNqaHlpM1Ix?=
 =?utf-8?B?WWl6dlBRT3B1Zyszbmd6VDdUWmh3ampHYm1WN2pHTDZUZEtlSkxYaVZRL3ps?=
 =?utf-8?B?TWVoTTA3cVVqV0FVNlNkVXpSdWZNeGtHWldFdjZTRGgycDM4UTJBKzJjTDls?=
 =?utf-8?B?QjFSNmkvSlZsYWtMSmR2ZGM0NWFCU3JnVHZucXdjLzBna1hPNzRYY3VOTXZU?=
 =?utf-8?B?K0Q0N2tuWHNpR29NWWxnV2ZrOVUvZ25FRXRJZlk3ZTdJM0xWL2JuN2I3a0Rh?=
 =?utf-8?B?M0xVdVFRTEFKNXhORGpNNU5yRTYxazhNY1oyYWo1MEhaY2w0UVRQWk1XbWd4?=
 =?utf-8?B?dUFEQ2c0cVVwQkpWVmxyU0JncWdEYXNORDRtb3lLeXlBcktDQ2V4TXJCZnRO?=
 =?utf-8?B?S01SQklob0t6Y01XT3RBeHRaZmtNcVZHK0dTbGltRzUvbmQ4eHJqVTJqSkxl?=
 =?utf-8?B?VWNReGRNR3ZHczB0dENXZ0ZOU3E1dEU0b3g3eXJKL3MzMGRxeVZvUWtWUXZB?=
 =?utf-8?B?OWZ5UldwVEtMdnJ4S0hmUEhNbHBUcnQyWWIwZ3liOHJCSFRtUEluc1h0QTBK?=
 =?utf-8?B?MW1VSjdFUUR1dlNJNVUzSjhuWHo2d3VybnlMdEF6UHhFcjNCSFBFWWhCdUIz?=
 =?utf-8?B?YWkwNENkWEM2bWN3U3JIR1hLZzUrTlF5eGN0ZXRBWkhWWW9jVDhLRUlRemJU?=
 =?utf-8?B?QWdUNWp0Y3VRK0hKRGc0Unl5THN0UmpjQVBtZ1pwdUlGSEVjSDNDcVdoZjYx?=
 =?utf-8?B?cTdnSGR0K0hWTUUxekx5RGk2d3kvLzlDUm45RWZNZ2lTczRFTFY4WmVJOGto?=
 =?utf-8?B?NnBZSVFyeWg2RFFUSHJBLzNycTFDSFJjMWhyVjF4aDVBZVA5TWQzRzVIN0gx?=
 =?utf-8?B?eFpFTDNlaEVjaloreWRic1FXOERkT25sM3hVQStzVExUOTQ2ZUFMODhlTUlp?=
 =?utf-8?B?dUp4Q3RaTHU1NE82UUNhOUx1WW1tT2xNcVFSNFNXbTZHdzRYL3N1WFNwdElS?=
 =?utf-8?Q?V1GfDnA2PPbzI188=3D?=
X-Exchange-RoutingPolicyChecked: F1/KieMPeihgU3cpRx+mCuPFzfUBh5CZ04AS4qx6Y8h3OUEie0M8CDvaYInfragbpHDS0R61YT+GadXH8kOr12X9OZ3++61e0Bl0B/quS6DmWDBDD9SGhPg8NYpVV0rt44qTCikjkymYqbs2tC6w8q9R5dYd84gy7z8w6Krvo0PlimbCSjIjEIPNLKOxxmLkhxHhfaohy0SIOoji+ShkDezvII22fNg7Re+JLFOvKzIhiFmbds9MePBokh3ap1eX7rY2d+j1CXhdS3imT0FxWG99cz3q0d87OECdVfa8SC0Mz29V1WgDdEFmskdX8e74m/zdguZ7ZOD8g4eIkRrIWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c156da-0ec4-4944-1e79-08de7edbfac5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 19:34:00.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LhF1WlkotBYF8Khtq9DlbXZWDRiq2yRe6LmaIgzL/ptx6orHyRPOrPDXnpYWSaOy++Gdqv+nrpNxcNxBkTcDmOnBqmJlj0JMHQcpOBtCbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8104
X-OriginatorOrg: intel.com

Li Ming wrote:
> This is a preparatory patch for the following changes.

It is a preparatory patch that does not stand alone though.

I would squash with the next patch, but you can add to that combo:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
