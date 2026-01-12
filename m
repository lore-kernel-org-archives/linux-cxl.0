Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5C2147E6;
	Mon, 12 Jan 2026 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251589; cv=fail; b=bv9ooJb4L+0oxVF+6Mos82gbLrkB3nsLVs8ekw05B2nYdflpY9j9+wnuh6Qv9qLg1OCTukBPjQ6s5pT/qkTOpLy4WaslgtrydDYxXey9iWuZl2zUcKCPCP0ecIxrDxYl34Q9cI/7If7j72BlmVXwFY2x63CwhVXBYi9GryZdmfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251589; c=relaxed/simple;
	bh=Z72v7zkmWXHjJA1mReZxaTGyhSI4E4cIUgsS6MiU0mQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ewFsZ99H+NR9ydLWgm/5LQVB6r6r6VeV51Qsgj2UlUxskL7tdDCuWoQf9awj2kFSWlw0Kkac2YX72j5zRl236iVEY79OG2KYWsxR9NcwHmn41c2imrbWFfMmcq9HPRDT0qvn8ZDtN1GB+cE+J8NawAQ2t1ILTYVXA+KHlD9d1BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNIpR6YQ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNIpR6YQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768251588; x=1799787588;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Z72v7zkmWXHjJA1mReZxaTGyhSI4E4cIUgsS6MiU0mQ=;
  b=iNIpR6YQZtrZ9n/NPZNIPGA3yZ05iBGUuqRbES3sG2QKBtprkhoqxmhs
   lKGURHdWeSiJo5OXPEM6ylA5aO4CQ/ZfSrEA2A1sLXtWybl0smgbgYgtA
   nJmrxJ6gzJhnYhruWEQsJvWKl5mdh4+fIhBzpJx/fRahKq2c9u1eLdXb7
   v6ZqtfH99aZOH6kjKS++kCJmjWzeUUStY1QrY7QdsVz5HUMLxvnl8PRCv
   bmhs8a01tTjN4Q3k2YoiumFpSY19y9JgtvU7nZUDaQOvpTvciy4jkW+5v
   XeORyNt91qIbFDWzFb4ArFKnlxxDd2E0lclg4FLaw6t8WGacN7ENX3xYI
   Q==;
X-CSE-ConnectionGUID: G3VxnGsRR1evmGOw6LPCRw==
X-CSE-MsgGUID: hNEq6XdiSgijjOi3W4VBeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="86949501"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="86949501"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 12:59:47 -0800
X-CSE-ConnectionGUID: UH6celdiQaKgBQNgNQs0BA==
X-CSE-MsgGUID: Q0VM8QbbT8OKdhDkCfXLTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="208712641"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 12:59:47 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 12:59:46 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 12:59:46 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 12:59:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx1GoEBEjzjjkB6U/3kQRWnbpGBzd2jOK/zRiGJYCu50m5zFmoD6J4mYRwruJXIq1u/ff3UqurdSUhDxaiA+LFZ7YkFvONJs6QIGH/ze/sJPJeuxQLInq1UkMxUW0ytDKRDuN7wJT6xIYnt7t6b8lxGyuIWXRGslDWl+OQ9hjlVbu88/ZyIVUeO4WPbASnbVaB58A8u13YkPER93Ov9wChIfzgO88eOzasGR0nTi+2MOvcvIX8fhkcYIDnD2ITiTov/nKUmkNRumvM1O/rzkolkhDq200ApAT7QABxJy0Q9XqHyMXAOmB/loHbgCkJXbWXaG9xyss1Qvdd4IXfubpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odCel4eEjQZP93BIeix+u/sFccKVYK+tP+wTyTz+3uE=;
 b=ROUEUZ0PZ2KisR/1pbtb5fKXjbvWVEyV4sKbH++icu0le7i3w21laFtCMTgmlh7iyz5KS1sJ3v6FDhUnKd+/69EvrWKmOkkCWqBXJRXj68SjAHWyf/8C3UfVw5FeEFENM3GgpmDabmlvvAWli7nCGWo4hAZIdgIgaXmTddqwU0dZFUhPsCWEe+uh3xKHpcxgmjdwDxVW2x2FzIl3tZWd3o7ARwSoS4YWGncS7KmUrNOpxwRRrqGKGgLbNzQ08R0SgPS6/es/y4KXmvogxgC71yah1dAeVbQMx3rAmPMQJxMoUmaYmk4g0wyMBJqHy3EpC5AR4voGD8yfkBBPYxm3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6053.namprd11.prod.outlook.com (2603:10b6:510:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 20:59:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 20:59:45 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 12 Jan 2026 12:59:44 -0800
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <696560c0979e0_20718100b8@dwillia2-mobl4.notmuch>
In-Reply-To: <20260112163514.2551809-2-gourry@gourry.net>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-2-gourry@gourry.net>
Subject: Re: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and region->memctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: da71259d-64da-4819-6615-08de521d8392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWtFU1QxUjRaU2FZYVU0VTI4L0hHL0NPWWljK0VLWDJFcndsTFRyUjRyR1Fk?=
 =?utf-8?B?M016YmdlUnlRajhWSUtOVmVhTHk1VTNGNTFyZXpTc0FCMVRTa3JCK1ZJNWhu?=
 =?utf-8?B?NlRpUmYyMVRpVnRZNE51MHZUZXhUUHJ5WmR4UnB3K1FveXFPZDIvOUFLU25m?=
 =?utf-8?B?bTRZdjQ3OUhHWWl4WCt6MGE3em5MVnptRU5ncHBDVEh1SElqOURtOE9sN3Rz?=
 =?utf-8?B?aGQ0ai9VSEVieEhRSnExNUtXMG81ZGkvK0xRV3VnUjg5WnNYTUF6UUhXYlZU?=
 =?utf-8?B?V1F6QUdZdVlRNHJZczV6SnU0YzJtenJPRHdmLzlGNk1ld25HSWdDdGVReDRE?=
 =?utf-8?B?TDVCT2hjMG00eXdIRDlOdGwxOVRSZVdGcVB5bzR6SVFyV2cwYkJBRUo2WGhN?=
 =?utf-8?B?UTBQOFF6a3EvMG11TGI0c3FwQzRtb3k1dS9ZQXE3V3JLZFZYM2l4djVJZTE0?=
 =?utf-8?B?L0NSVUNvVC91M2ppNVZzMGNQdm50dDM3MWF5a1JjRkg0dHIxaHBKWlMySzdC?=
 =?utf-8?B?VS9nOVZ1bkZYb0MwU2NSQUNIdkthYzMySEZCdEdGN01QOFRTRFl6NkhvdUZO?=
 =?utf-8?B?dXU3bjlGOFNIVnBoWlh0YXEzVGhaMTEreTZPbHVzNU14cmdIeUZacjlNeHM0?=
 =?utf-8?B?blJ6U3dxLzZ5T21JNnRHTCtRcUF4dzRvcjVodGhuQXo1STduSTdOSTltdzVL?=
 =?utf-8?B?VVNpRWh5clNWT3NsQ1pMSDVkNFBjT1AvY2haVzhhTUpSemZ2OFVPOGU3UXVG?=
 =?utf-8?B?eEk0OGRJbEIrT25uUFBwaVRQVWlEZmtxd3lDTFkxdVpLUTVkSXlZbzhuNmRv?=
 =?utf-8?B?QzlsSCtJQmhiUDlKMlpvZVFnMU53Rys3VDh2c1IwOGM2RXRsZWxwdStyTm1j?=
 =?utf-8?B?Q2lGd0ZpUmpDQUhBaU9SdmF4MTZ5elpUSXErS044ZDZ1ZkdCZjVtWHNpODR4?=
 =?utf-8?B?dU0xNGZqMkNzbWhTMVd4Z0FpMHc1cklyVWMySVU0VDVaNnRqZFVSdCtVczZQ?=
 =?utf-8?B?N3d3bWVuYjFydTdLMWdBN0EvbmxVQ3lKaGNSbEpMQVEyeWZ6SFEydm5jcFl4?=
 =?utf-8?B?SnpDdG9RbDkvOWZwNmpRMWR2YXR4MDY5UllKYkl0YUptYzdIOTVxQnM5U0E2?=
 =?utf-8?B?V0x0ZDBTODI3VVBtZEFRZElNQVFXUytLckVFTHE0QXgzWEY0Y2l2WEZhdFIw?=
 =?utf-8?B?UWZkd2Y0dEJBN0pmRzBxc3JGWEEzdDUyM3c2RURST2hLdVVrVFdYTVIvOW1I?=
 =?utf-8?B?ZkF3N3pDM2pTOEU1QTlIdklPdFltcmpqTHRmVStWb2NoOER0VExLSGlYNUs4?=
 =?utf-8?B?WjFUS3RRZHZ0NmdqV0dXK1Nsd0lYV3l0RS9WZ2hsaFZ6SDRhajJtM1FESmVi?=
 =?utf-8?B?K0p3ZCtjNEZnbTg0MWdSQVV0RVhYdEhtRFA0QkMrWXU5by8rUWVQQTFreExy?=
 =?utf-8?B?MjdnQjArN1lLaWZadmV3TnJPVk1WTmwralFzMnNiamxucU1lSHJPRVVkTVAv?=
 =?utf-8?B?eEdONnU2RlA1eVJLRTVqdU8xc00vNkxhYjVwbUxTMDNTK2FlZWExUU5ueEJK?=
 =?utf-8?B?MkREL1YxWlB6WGRIVTZoS2JsSi91eEVQMnpRUHZyYTY3dnhzREIwVTdNNU84?=
 =?utf-8?B?Q1REOG9CcWNNUzlEZFYwbHVCSDlkTHhuNUNrSkJzWDBXMlVOcjAvaW5VQjNk?=
 =?utf-8?B?TGFYYzhrME9RMStzeXcrdlRqd2c1R0ZWbW5WbXh4bUMwSlE1WG5lMGE1Wjhv?=
 =?utf-8?B?ZmxFNERqSGdwWGZJeEQ3elFYdFNYV2l2WHVtb0c4WFF6MGxoRzlDQkxvRXkr?=
 =?utf-8?B?TUpadG9TZVFNeExIekZyWEw0bS9lWWQzcDhGOTQxM01QcGIwYzhGTlh3NWNO?=
 =?utf-8?B?YmRxT0ZUY2xXYjZWTTBwajQ2N1JaQ3BNODYvbUpzUmpWejZhNzFIMEk2SG5z?=
 =?utf-8?Q?jjh3kY6hshDCB+buVMtiDcG+woPmAqfN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnJBcTc4N29ybWxnbFJTZVZ6QUdHdUdYS25CZ1FhY0IyTXZId09QSENtd2hj?=
 =?utf-8?B?TWtJd2FtUWgwSTcvZ1RHd3JnZlhPS2tYTWJaU2xOa20rL0lBMUxVTzFNWjVp?=
 =?utf-8?B?MnIzelhTNEtmRUV5STBMZzJlWCtTZU5jUlFTUzFaclVITnQ4Mit2dFNsbHRx?=
 =?utf-8?B?ZG5hZUE0OXNMWHRLYVlDRkFLS1puMVRYdkdJKzRTaE1ReVdOODY5KzFwT2Zo?=
 =?utf-8?B?a0VubjAyakF3a1A1c0hEZ3drYnAwdld3NmpJVjdXTGV5ZHVXQTVJY0l3TXNH?=
 =?utf-8?B?V1Znd05QTUtVNjdKOUg2amVQVktNNTlvT1Bva3ZIWFhUdDJLOGtJUEVOMVU4?=
 =?utf-8?B?OEJZR2RxUWpvWHMzQW40QTIxZ3lNaXY5QVVldnhaaGh5R0tORjd6eE50Y3JT?=
 =?utf-8?B?VVBMaUZRSFZsVExmZDhJVzVXZG1mRWNSdWtNUWhrQ2p3NnpBQVluVTFoSG8y?=
 =?utf-8?B?T253U3o2dnE1cGp4TmplVGxPRis4bnMwTHRuSDYyc0xRclRldXhla1preHJ2?=
 =?utf-8?B?M1NuMEdWaE5hTzFyQ2lxa2RBQjdPd01Pa2Y1TzkvOHNPaEZrcmw0cW12ZXdE?=
 =?utf-8?B?SHNma0ZJZkZSK2ZqVHh1TjlqbjdZM0ZQMzEyL1FVVWNzb0VSdVRwdlpRYlJq?=
 =?utf-8?B?WHE4SlNyOXFwbU9HOVBsblcweUJRVDNPQnk5V1Yrb291YmlvVWUrakViRFds?=
 =?utf-8?B?c1c1dkNxOHloa1QyYUZRclBhQ2Z6U1ltdzVJenVBQVh2QUdiNFFPVTFlSDEr?=
 =?utf-8?B?bzVZUXRFQ20xSmNqKzIvMTEyR0YyZFVMbTQ1b1RzSXZ1dHNpOVNhdFFmUWZa?=
 =?utf-8?B?MlB5STVxdmRqc29QUjNmTEdIWkJmdWdvRUNUWE9YT3NuQXRuTDZNaHZ0WkMy?=
 =?utf-8?B?MG15TnRVeXVQWXlmQnNHYld6d2FGT0NWbkFrZ2lRcXJxd1dYdFN2aEM0VDZ1?=
 =?utf-8?B?VFZZSE5FbUFaQng1WFNNcVBvOEVDR2czV1VyN0oxeUV3NzNkeW9sY3VBMEJL?=
 =?utf-8?B?V2pUTTZxakRLbEduMEJHNG9aaWlIVW94MW9JVEFmblRUdVd5SUJVdkNQV2hh?=
 =?utf-8?B?Qlo3dXNSeTYxNXl5SjhNY1czOVIxUEg4dWh6VS9tWUQrTFdDNENnTFhQZmg0?=
 =?utf-8?B?UHBpeENOL0kxM2g2U1phTEl5SjZTTERBVTJhNUpERk5HN3B3MXpQbThZUWRq?=
 =?utf-8?B?OWtlODNDL0FtcXdSaXRjNXo0OHN3SC94S3gzUENwMnN1cmtBZUpRdUhjRjZN?=
 =?utf-8?B?VDh4WFM3aDVVbHF4TFF5aTJibmp2N09XTnRlZWNDcitPbVV1TUl0T2JVZWhT?=
 =?utf-8?B?eFhRSlhXQ3FrUmVXVnc3QUhJMHZUKy9xdHhCNGlHSklxNDhaMVVkeEM4d2h1?=
 =?utf-8?B?V2djZ2oxT1d1cGQveVhiQ0ZZYy9ST0R3ekZ1aHVJTitoRkx0UEhuUWJ1UU5z?=
 =?utf-8?B?RFBvRGpUaHp3bEJKN2c5bDBrcXBRelo1STZVbVAvZ0ZhQnA3bk1qSUdqUU9x?=
 =?utf-8?B?ditqK3JzVTBCcHZscjUydExWZGIxb0Z5WXJTQ1lyR1oxWVNnbTNjSk1zSEw2?=
 =?utf-8?B?eXlQVnUxQzJqRHduVHluakI2MWxvK0w1SGhpWVNkRmVPTTh2ck5IZk1ad2RM?=
 =?utf-8?B?YjcrdWdUOEp2NVZyQlBNdXF1eStNcUFhQTlHQWlFbXNjL21NV1l3Um5zVlNq?=
 =?utf-8?B?ZmQ3QVl3WkRoNUJKL2ZHUVVnN2tBZGZKOEVEUGlBcnJ4U1hESHZQM1huTUpJ?=
 =?utf-8?B?aXZNME1Gdm00L2dNYkdKbmlwejR5K0NXL1hSRlVPZnFNMS9pQ0NEZUk2OElN?=
 =?utf-8?B?cDlaREg5YXkyaW9qSDhCRVRzTE5malRYYWI5VnRZc1dGZ2F3cUI4NTUyMjcz?=
 =?utf-8?B?bEY3RXg0VmZMWHBpZ2RseVRXeUl0TFQwSUNVVm4vQW9CdlhiWVRibDB5bERw?=
 =?utf-8?B?dkMwTG81a3RSZGZBNlRXRWRNbkdzMnZwSGFrRXlFSXRaMHdiYVBjQlFQUTkr?=
 =?utf-8?B?NlA1aC9GWk1qOUc0cE1QZ3haNGttalMzenB2WWd0QUJqTWFTS2M5UUJObElr?=
 =?utf-8?B?L25SRFh1SmpEWG82aVRLbG9jL1RMV2dRVXdJbk9DYkdwSDRRZzB5azNNOFNp?=
 =?utf-8?B?Qys3aTlrSlg4VzhPUTJ2UWZtMitCTG5hUTdOcERSY3FKM1NpaGxRaGtoRlNB?=
 =?utf-8?B?d25QSlIvV2ZJU2VJWU5rZWRlRDMxV3k3NUpXcEJ1NjVXajhCYTZBRVJqM0Jy?=
 =?utf-8?B?RTAya1VrWUk2UGNheFR4aXY4bG5nck1tZGFWTjNKREFQNW5STENpd3ZablJ3?=
 =?utf-8?B?MU5qckZsOXowZ0lGSXJlNVM4Wk9qczJSRHpka0kyaGpvUThzUm02MUpjUkhN?=
 =?utf-8?Q?H0D2HoY9UfH6d15A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da71259d-64da-4819-6615-08de521d8392
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 20:59:45.0936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3eIZx2SPjNMr02g2pFVErzvcg2DmR5TvHeAO1xLDcNK4Pz7qRqTEi21BJsOmDccLHkerz27qBEMwFaAljLabgguKSOWZzbb38lDkfQCO5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6053
X-OriginatorOrg: intel.com

Gregory Price wrote:
> The CXL driver presently hands policy management over to DAX subsystem
> for sysram regions, which makes building policy around the entire region
> clunky and at time difficult (e.g. multiple actions to offline and
> hot-unplug memory reliably).
> 
> To support multiple backend controllers for memory regions (for example
> dax vs direct hotplug), implement a memctrl field in cxl_region allows
> switching uncomitted regions between different "memory controllers".
> 
> CXL_CONTROL_NONE: No selected controller, probe will fail.
> CXL_CONTROL_AUTO: If memory is already online as SysRAM, no controller
>                   otherwise register a dax_region
> CXL_CONTROL_DAX : register a dax_region
> 
> Auto regions will either be static sysram (BIOS-onlined) and has no
> region controller associated with it - or if the SP bit was set a
> DAX device will be created.
> 
> Rather than default all regions to the auto-controller, only default
> auto-regions to the auto controller.
> 
> Non-auto regions will be defaulted to CXL_CONTROL_NONE, which will cause
> a failure to probe unless a controller is selected.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/Makefile             |   1 +
>  drivers/cxl/core/core.h               |   2 +
>  drivers/cxl/core/memctrl/Makefile     |   4 +
>  drivers/cxl/core/memctrl/dax_region.c |  79 +++++++++++++++
>  drivers/cxl/core/memctrl/memctrl.c    |  42 ++++++++
>  drivers/cxl/core/region.c             | 136 ++++++++++----------------
>  drivers/cxl/cxl.h                     |  14 +++
>  7 files changed, 192 insertions(+), 86 deletions(-)
>  create mode 100644 drivers/cxl/core/memctrl/Makefile
>  create mode 100644 drivers/cxl/core/memctrl/dax_region.c
>  create mode 100644 drivers/cxl/core/memctrl/memctrl.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 5ad8fef210b5..79de20e3f8aa 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -17,6 +17,7 @@ cxl_core-y += cdat.o
>  cxl_core-y += ras.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +include $(src)/memctrl/Makefile

Not sure this merits its own directory, but if it does just do the
canonical:

obj-y += memctrl/

...to add an object-sub-directory.
 
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1fb66132b777..1156a4bd0080 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -42,6 +42,8 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
> +int cxl_enable_memctrl(struct cxl_region *cxlr);

This is a "probe" operation not an "enable" in terms of runtime ABI and
presentation that starts decorating the region. In that respect it also
is not a "control" as much as an "operation model / driver". So no need
for a "control" concept, i.e.:

s/CXL_CONTROL_{NONE,AUTO,DAX}/CXL_DRIVER_{NONE,AUTO,DAX}/
s/enum cxl_memctrl_mode/enum cxl_region_driver/

...otherwise there is nothing in this proposal that makes me want to
abandon the traditional meaning of a "driver" probing a "resource" in a
certain way to make it usable with the rest of the kernel.

Rest of this looks fine. With that fixup if we are going to have a set
of different region driver modes then the directory can be:

drivers/cxl/core/region/
