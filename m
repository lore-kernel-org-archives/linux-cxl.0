Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CCA2D97BE
	for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625697; cv=fail; b=AwtwJpoGL/4ZL3xoAVySes78Wa1o8c5AIU2dqfTQN35Am3I/aW7ebcHLJpNcC51AUsqohGb3w1gTDHRIOXw0+0WLncSUSTK3lNa02X1pGMtxyD9tVM0BzhStRbhkEC8zKGbDraUnXkzYakpNUpnWmj4JRGkg3d5WpTCKB6OiReE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625697; c=relaxed/simple;
	bh=6ZdEzy7Wr+gYlxszRgFzF7XqP8Hdv85IEuzo1BJKeEM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aTKvMB34+ENSB8XY9Yl4mbB/Cc7RmlAZ/YAf8WRq/hNGnf9wlCAyeGHcTZYfdg2XJvV8pEcObnUn72OHGjhLz/OCzu2sNskWKu4gQrzxzNDoCpmbaSCsaL5wdhX0XhpTtIhUIh0SoxkQlmRV0C7MrZF0TzizorKZigMD9jkWbpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLu9Aswm; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLu9Aswm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771625696; x=1803161696;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6ZdEzy7Wr+gYlxszRgFzF7XqP8Hdv85IEuzo1BJKeEM=;
  b=WLu9Aswm6NgECpibtUANauFwPO7WNjMHTWVleso2n/EsM6L6+aPOQ5qG
   iehnWDovqFQyOlyype3voR/LM18DyrUR4N4w6xnUcv7Ta3IlRQe+No1CW
   EZpPyALzP3pOTeej7YmUIfQiZb2ABA9S8Gbq3Ws6RR1pSsvNhBoQj92g7
   2hgIzmclq6c5YXz6o3K3o8EaI6hHNEDZ36Zno5C8M5Zvu7gic60hYCJpk
   dQ1T03BCKRFCdH+lfRwYfTIh3tdbkZB9T28Q080spuZqWs2ePMxQyP3f5
   peoee55OSui1RufG+glvjfBC3g6laym4UfPAbBJc9SG0fAHr+r6LBMWf/
   Q==;
X-CSE-ConnectionGUID: lOPp8q2ETBuGxbOOlpiTTQ==
X-CSE-MsgGUID: KOKgQvLNRPumBMT2BmbfYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="75333082"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="75333082"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 14:14:55 -0800
X-CSE-ConnectionGUID: xX2txIv7RhO6CXs1Qwkw4A==
X-CSE-MsgGUID: ARVhtwoRSEythYLMnherfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="215101372"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 14:14:55 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 14:14:54 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 14:14:54 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 14:14:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEZo4OO259QdqgiiteHuzH+50cftzQqXdsor5pmdtp7MlaUulV/i3HQwhjQ78WEDLnAs2wjg0VVAL0q9h0kvq3rUnnlG4/6H78E0fHDRn51TcdzCDbsPPBvM2IBoE8PYFUVC5VV+vmc3QuX7hXHDtx3Q7iEEQq3b2i1R9wP4xqlD13gtCZI60nkV6I0g/s0qco1G+IRj14EEawJ3d+zlKMdt3D/zrpCSdo2ocuhUs5ACvLOni5K8WYAmKOSN/OQbvyEu4NinacD49Rp4ypmZalmfAOVQ2arIS7YI0S1NzGyqeU1b9Hj3PPaMR+kqDL17DsfFkS4+JZCuswRi8PGeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYkisiygP6cVIucYAiL2+vmeXEa40kjzf3IYyGBQaKc=;
 b=wYhhQNaWyTuXU+m3fXhpafqvvd0ql+GMZLJIvhi5tB8FRCCGZ7td1u9RjGkbkDjuTIHKn1ql43nOT+xonAri0hcL9ikBm4rWmBzfrjVjuDwR4YQrbL+ilUlhTjQDU+SqcJCOhbAAJouIm0+NtmeD0OVC1jXtUhjqhbo4ZsWDQdkamE5jjtv3zbRFRKEQbTFrJgjC8VYJD6KZDNBaroakHrjOuLqI4OLJhP6tr+pYAbB9Qj5lBg0q7ryAQMS2wKAO7u36Pq/R5dRUDJyzxEupzk0pl0Z72nlf8QSGXuuw6wep5zg3ypp68QLPc0dRuWnSfg+WE0TtQeeLSokJKlr9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CO1PR11MB4883.namprd11.prod.outlook.com (2603:10b6:303:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 22:14:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 22:14:51 +0000
Date: Fri, 20 Feb 2026 14:14:47 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/mbox: return appropriate error in
 cxl_payload_from_user_allowed()
Message-ID: <aZjc1w1GMnwoJOzN@aschofie-mobl2.lan>
References: <20260220001618.963490-1-dave@stgolabs.net>
 <20260220001618.963490-3-dave@stgolabs.net>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220001618.963490-3-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CO1PR11MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 395d08b3-f120-419f-676e-08de70cd77ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEhIWHlBWURXT3VBMXNHL3NPcE1vazJFQ1pGVkp2TnlESEF6RFJTWWZRY0N0?=
 =?utf-8?B?OW1vTFZ5MWkxbjRGYTNtQUNSRXlOZUJpWCs1a1lLRFY4eFVLTHc5RFg2Vk45?=
 =?utf-8?B?Ti9EUFBJMjBmUmp0UEhNaXoyZ1doaFY5bXpwemFPVlpxU2NHSC9GcTVZMzNG?=
 =?utf-8?B?RzZFdlpZNytNNU5TVUtyT2o2VUdtZU1mcVlCQnVJM0ZtYTRwLzZWMVVBNXZ0?=
 =?utf-8?B?SGpYbFRqM2l4V3BUcnpIcFRpakRxNlUwenNQTVZWcEErYmUrL0VjZDhWMVRs?=
 =?utf-8?B?TEZSM3ZzTS9ndjByWE5zLzliR1pHZnZCU2dnWjc0cFV2T2lHK2ZGYmVJNXUx?=
 =?utf-8?B?MXFnRWwvSmJHdnIwZDlNUmJwc0E2OVBiODVaVnFNS0gvUHhLcEp3RTdJaWFa?=
 =?utf-8?B?eGtOSnBYQktOSnRTVE9FOSsrOEdCSjBvN1pFWDYzeGFMN3hBMU0reGNYRkk2?=
 =?utf-8?B?ZDB1UEpGMEQrUGZKNm5oT1M1QWhFMjJqc0t4Y2VsV1dYZXcvQmRlWFFsMHVo?=
 =?utf-8?B?MERkU3dEc2NXNzNrbXlDTkVKbWUyNnkvRS92byszOTFlZ0gvRnJyblR5RmdD?=
 =?utf-8?B?UmRJZ0NTbHA5b25seTZ4b3U4T2tYMStQaFlocTRZTWZGRko5bTlweGhNUXUz?=
 =?utf-8?B?elIyZUNlcjBWZEIxbER5eVBmQlkvaFoxaFd4Qm01M1RMc01MWnVCQThHTThT?=
 =?utf-8?B?SkdvaHV5QmpOZExDUUxmTWFpMjZYaVJKT2VtR1NPZkVNN2xHekU2aGx4Y1Uw?=
 =?utf-8?B?TEhqQ0FaQ1ljK1RvNkszSEhtVlkwUnV3dm54Q1hpemp6cGxCTUJURHl2cWtN?=
 =?utf-8?B?T3RVZjVuVjNUTEQ1N3JjU0ZvcjVEdUxHMTFuVDBFa1B2YUQzVGpKQXczNmkr?=
 =?utf-8?B?WHUzY2xKQXY0amdibEM2Y0RCNENpNE1HaURpQ2dTM3FFOEpuTnV0cEdjY2Yz?=
 =?utf-8?B?cEg3YWp4Sm5oV0EyTUU2QStIZVBUeis3eTFCMDhIUjZIb3NUdm1TWTRoZG5x?=
 =?utf-8?B?cUxCcEQ3d0ZIS1hqYVZhdTM3UmRvM3pZUEhrSDJSeG10UEpnRHFqelVEYkMy?=
 =?utf-8?B?bHVsQW1XM2dvTE1EbEQ0SUtWTEtORlN3Q29CUkZZaUtLMDRqL1hlRVJPZVNK?=
 =?utf-8?B?MmVDd2crOHlQTktyNS9QdGF0ZksvNldQb3RhN08wOEtjY3d4Nkc5ei9TSTlG?=
 =?utf-8?B?bzJlOU5vTFhuU2UvSzRVQWk1Tzh5UUFLazBQRGE4c0JDNjk2TzRNMHA4VEJs?=
 =?utf-8?B?Ly9ZNzdJRTNqV2FXd2ZXSU9nSXJXdStmVnRVRHR4UDRnZEljL2FvbDRDWHNz?=
 =?utf-8?B?T1E4N2JvbnN6c1VFdWE0eVJpTGpYYzB4ZURRQ01HVVpvM0xtWUdZU1dkb3dE?=
 =?utf-8?B?RmxzVVRUZXdZMTNJVHZBenNCMkNTejMxd2NsSzhDUWIyRkxFRFQ4YUVVSVQ4?=
 =?utf-8?B?SnY2NWF4ajI0bGF1cE5nTUxzeGx6K1pEMi82K1dRQS8yS2kwcFJrTGZ6L2ZL?=
 =?utf-8?B?MVdTTjN3U3FBcVoya2VqNFB5d1M2bWVXRUlDdmd5aDhTL0E4c0w0MC9VWXNW?=
 =?utf-8?B?NXhzTFRBYW1rN0krNmc4WDBJa0ltV1BxRW50Um1vNmltdDBtaUl5U3AxV2xR?=
 =?utf-8?B?VW84K0t5REVYUzE3Y3VNNWxyL3FaSEZJZFRtUlBveEVFZ3FuZ2JXbjBxd2Qv?=
 =?utf-8?B?RlJaUStyUkk0cldPWjNtVXMyeWN2cUhJMklVeWR4bS9JbWwzck10QmhFYUNm?=
 =?utf-8?B?NEtQK0NBeGd0aVFNRDdCUHM2SWFQVnFpYUVYYTFOaXhkTnlSam5IM0dHVmVF?=
 =?utf-8?B?UmNhN21oRDdDRDhUcDI4bkFhUXhpYjNKY0psK2tOZ3FNSVFxMkFLMS8yNFFB?=
 =?utf-8?B?WlhkVkhWZVp2bUJJb0dKNmV4dzJlTkNLMmZxOHRqWHozVG1mSDNtTEVlREdK?=
 =?utf-8?B?OXNhS1J6anM1b2VMRTgvaCtMYkpSVzBZR0xDdGNtMkRhVmdmZE83c3Z1L3BR?=
 =?utf-8?B?Z3dHSGE1R0luUVVudnZIV25jRlJOWUMwalRmNGFWRm9KQitBOVVwQmtOd3Nm?=
 =?utf-8?B?QisrTG1SR2NNYTA3M1VCRlc0RGVldmVmb3hBaVFPUFVwVm1tOXNMMXFWNG1G?=
 =?utf-8?Q?/QLI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXcrcEVKWmdxRktrWXBQMkdmZG42VjhFV0tpbS9PRlpuNTFjVnNxNWY4T01s?=
 =?utf-8?B?MXlDeVJOZ2ZkTFFKSXFYUXRHQS9LOVV5ZjFwUTBLTGgxTXViYWJuV0VYUjBs?=
 =?utf-8?B?Z3JEaVFIQ1dYNFphMG5XSDdHT0lod2wrZGxUSnFabWxXSlhmQ2c1R2xGd09l?=
 =?utf-8?B?Wll1UUtpV205c28zcVhFZG9ERFRZUTh0UHlrWkdFSWNCU25zaHRqZnBQSXpK?=
 =?utf-8?B?QitrZDlhYjNRd0RWOWNUQU5yS09CcmN4N09NR3FPZ3NTR21mbDVGeGtwaU1H?=
 =?utf-8?B?Uk5HNGZvRHZzTWpVcDR3OGs5dVVrdjVNelgzVmR1Z1B3bEZKczAvdmxoYWlx?=
 =?utf-8?B?MS9CdW1WUlQycGcrUGtwWnlPTVp6dDZwS2N0TnB0TUhUeGhVM01JUEUvTWNu?=
 =?utf-8?B?K2lXYkJLL0phSGRoQUxXc3hoL0JyWkVJRitYdDZpQWZqK2sxcXA0UzZFZ3JT?=
 =?utf-8?B?bjV0WkFpNTg5WEpTcHowazREYzZJSGRPVkVhUmtYd1ZGOVFGc3RZaHd4cmgy?=
 =?utf-8?B?aGpiY1RUZ2FURG1SZnZPaUxFTmtnTDdPRGZlRnJWWmUyeTRhVExRb1c2WjJo?=
 =?utf-8?B?Y29va2c0U2p0Y1BuL2pBMEQwMzRTNHZzSUN6aVZKczNtajhUKzgwU3R3S0Zo?=
 =?utf-8?B?QVRqbG1EWHhKQ0ZLdUl5R3Z4ZE01aHVGUE81eUxJMkd6N1pqSFM5RjFxd2lS?=
 =?utf-8?B?VlRzcXVhVmNYbW5MT2cxdUsxeUs3TkJWTnY5QzlSTlBuQ3l6bE9abmJtRkFE?=
 =?utf-8?B?MXp3c2lnL2c2UHNocWlqcVFCdWVyaHhYSjIwaXpITVFTZlU5L0NXMzVPc3Vh?=
 =?utf-8?B?bFM4dlYwR2czZFZoTU9FMzRaeWlDQTc3V2x1TzJUR0VnY3BUcmhURTJIVWxv?=
 =?utf-8?B?UHhYSkdocy9ocFJMRDEvV3JIRnZIejU2WDRRZWplb2FIcnNka3dyT0JRM2FE?=
 =?utf-8?B?QTk2VTlCOERpYjllS0hUbDBTZ296WG90S05ienpRT1ZldG9RYzhTT2R1T0tQ?=
 =?utf-8?B?a3QwMGk1VUpJWnRRZ2NneitIM1JLYjJkSjcydFUrNzc4eFhyOHVtR1BCMzFK?=
 =?utf-8?B?K3dkdFNXUGRMcjg5Z0xuZVNRTGlvaEljYitMdklJcXBZUUh2NDFVME52REpB?=
 =?utf-8?B?bmQvYmxCMlJnKzhHTVZXQ2laRmVDcERsd0NHaUdFUHZHZXRiMnVmOHZ6WkRC?=
 =?utf-8?B?QlEwSm1MSmVBWGN5N09lMWtuRm03cUdQZmdyRFhDNm5xL2lqNS9IWUlEOUI5?=
 =?utf-8?B?NjJ2NmkxYUR3dHRaWkNjazRWNGRTUzJCL0hjUTFnL0pvSVowNkZIU1ZQR3JI?=
 =?utf-8?B?ZFNiNmw3UG53WnljSHR4N29XYVY5WldzdEdLdmNxd05rQ2dFeGdLb1B1UE40?=
 =?utf-8?B?aHNrVm9naVlIeUFjVHQ2MDI5dGZEQjk0Z2RJQlhwZnhGd1VlSVQzTU9uTmdo?=
 =?utf-8?B?VUF3NHdaWThSRzZWY25GVzFXNE9aQVZiRWRsTjZHVVFPNndxK2t6UlVwbE9n?=
 =?utf-8?B?MGlCaDVjcEttMENQN3p2QXhuTDVlQXRqVVB6TVVvM1l6bFpGQzcxbkVLL1B1?=
 =?utf-8?B?UjhleUl3RnNrRHZWVWE2ak02YWcwTER6S1JkeGpKbXJJanFqejZkK0E2ZFZh?=
 =?utf-8?B?bnVkekYvaWhVU1dXTFQ5WFg0bitrMzlCRlZQWFhjV1hGM1E4a3JEWUxCenlU?=
 =?utf-8?B?R2xwU2NBMkNQejFhLzNrL2NIYVRRak1sWEVaOWM4c0NsN1lSTkZ1Sk1GQytC?=
 =?utf-8?B?M2VkNkFuTy84b3d5b3htOVcwRlNZbEtUeFZTYlJ6cmxPYjgxUnZhNnlCWG5G?=
 =?utf-8?B?eU5NOWFrd2cwVEQ3R3puNzRnNFBUNnpkT2REWUs3YTRsSG8xQkNRc0tDWnhx?=
 =?utf-8?B?MG1TcXRnOUwzallucmdFRlVjTFh5NzlzNE04Sk8zMVkxSnJKMkJlR1pNVklq?=
 =?utf-8?B?eXU0YXgxTEtLdVRnYVN1NFB5Qi9STUJCei9HQkl3ZXJFNXdGM0ZwdkJGSUNP?=
 =?utf-8?B?WjhXTXR1TlN6RXQ3alQ5TmttL1JoOGRMWHR0Z0NabzB3QnVaQnRWUTFBZU9h?=
 =?utf-8?B?YVpra0lrdUlXbkpEQmN2eXduTkRZZUJreFhmdDNLdzc1Snl3OGp4aEFla0cw?=
 =?utf-8?B?bVJZekU2R2lRRHhWRmc2dE5sQzI3aEVFZGRKZTIyNEp3c3JXZzRBSVBZVmhn?=
 =?utf-8?B?dE9uNytFYXgwT3RqT21KSjFYcStzSmUvdWdVRUFGRGEzTGpiZzR1SU4xUFlB?=
 =?utf-8?B?RnIrQndIRlpHZUtJMG5PdEdMUlFTbE5sM3d0TkkvTyswSFJwMjJua3lIeXdu?=
 =?utf-8?B?ZEN5eERjU1ZNbTJIQWhNL3dSby9XaGIwNGZrU3lWdjNnSUg3YzRCRUNPSHQ0?=
 =?utf-8?Q?ryKQkuKz0cwyJN1s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 395d08b3-f120-419f-676e-08de70cd77ea
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 22:14:51.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLEovuUeDDF9In1kccODGU/iRHQF8A2tirRu8qGnkvB9Cm6fQLkQmaKbDs4daAWx4vHOb76ZCJzTUSTSO4VLEvpde6azxA6RTUnw/iiywR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4883
X-OriginatorOrg: intel.com

On Thu, Feb 19, 2026 at 04:16:18PM -0800, Davidlohr Bueso wrote:
> Make cxl_payload_from_user_allowed() return int such that the it can
> distinguish between different errors. The payload size failure is not
> well represented by EBUSY (exclusive access by the kernel).

Hi David,

Patch 1's payload size check is obviously needed, but let's have an
ABI-ish discussion about changing externally visible errno.

My concern is preserving ABI simplicity and avoid implying that the
kernel validates RAW mailbox payloads in general, when it doesn't.
cxl_payload_from_user_allowed() is a limited safety gate. Before this
patchset, any payload rejection returned -EBUSY. Returning -EINVAL for
undersized payloads could be read as broader RAW validation than we
actually perform. If we want to keep the ABI surface simple, we could
treat undersized payloads as another “payload not allowed” case and
continue returning -EBUSY.

Conversely, if we are going to split errno values and distinguish -EINVAL
for undersized payloads, then for consistency we should also reconsider
whether -EBUSY is appropriate for the IMMEDIATE flag case. That is a
deliberate policy restriction (not a busy condition), so tightening errno
semantics in one place raises the question of whether we should do so
consistently. I’m not suggesting we expand scope here, just pointing out
the implication.

I say all this knowing that these RAW commands are meant for CXL hardware
or driver developers only (Kconfig:config CXL_MEM_RAW_COMMANDS), so this
may be way more attention than this topic requires.

-- Alison

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e7a6452bf544..164da335fa33 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -314,8 +314,9 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>   * @in_size: Size of @payload_in in bytes.
>   *
>   * Return:
> - *  * true	- payload_in passes check for @opcode.
> - *  * false	- payload_in contains invalid or unsupported values.
> + *  * %0	- payload_in passes check for @opcode.
> + *  * %-EINVAL	- payload_in is too small for the opcode.
> + *  * %-EBUSY	- payload_in contains unsupported values.
>   *
>   * The driver may inspect payload contents before sending a mailbox
>   * command from user space to the device. The intent is to reject
> @@ -326,40 +327,44 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>   *
>   * The specific checks are determined by the opcode.
>   */
> -static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in,
> -					  size_t in_size)
> +static int cxl_payload_from_user_allowed(u16 opcode, void *payload_in,
> +					 size_t in_size)
>  {
>  	switch (opcode) {
>  	case CXL_MBOX_OP_SET_PARTITION_INFO: {
>  		struct cxl_mbox_set_partition_info *pi = payload_in;
>  
>  		if (in_size < sizeof(*pi))
> -			return false;
> +			return -EINVAL;
>  		if (pi->flags & CXL_SET_PARTITION_IMMEDIATE_FLAG)
> -			return false;
> +			return -EBUSY;
>  		break;
>  	}
>  	case CXL_MBOX_OP_CLEAR_LOG: {
>  		const uuid_t *uuid = (uuid_t *)payload_in;
>  
>  		if (in_size < sizeof(uuid_t))
> -			return false;
> +			return -EINVAL;
>  		/*
> -		 * Restrict the ‘Clear log’ action to only apply to
> +		 * Restrict the 'Clear log' action to only apply to
>  		 * Vendor debug logs.
>  		 */
> -		return uuid_equal(uuid, &DEFINE_CXL_VENDOR_DEBUG_UUID);
> +		if (!uuid_equal(uuid, &DEFINE_CXL_VENDOR_DEBUG_UUID))
> +			return -EBUSY;
> +		break;
>  	}
>  	default:
>  		break;
>  	}
> -	return true;
> +	return 0;
>  }
>  
>  static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
>  			     struct cxl_mailbox *cxl_mbox, u16 opcode,
>  			     size_t in_size, size_t out_size, u64 in_payload)
>  {
> +	int rc;
> +
>  	*mbox_cmd = (struct cxl_mbox_cmd) {
>  		.opcode = opcode,
>  		.size_in = in_size,
> @@ -371,12 +376,13 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
>  		if (IS_ERR(mbox_cmd->payload_in))
>  			return PTR_ERR(mbox_cmd->payload_in);
>  
> -		if (!cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in,
> -						  in_size)) {
> +		rc = cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in,
> +						   in_size);
> +		if (rc) {
>  			dev_dbg(cxl_mbox->host, "%s: input payload not allowed\n",
>  				cxl_mem_opcode_to_name(opcode));
>  			kvfree(mbox_cmd->payload_in);
> -			return -EBUSY;
> +			return rc;
>  		}
>  	}
>  
> -- 
> 2.39.5
> 
