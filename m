Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4261FF610
	for <linux-cxl@vger.kernel.org>; Wed, 23 Jul 2025 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296885; cv=fail; b=D9HdADhI991+v+HcoOpiIXC5CDHzUTxJ7lA4LAszKP2FacB5r62esQOvWUyeFFCN+x9gWAPJF83x9B+P8JLpOdiESQBxtl6QX9kXDPl7ztoi2BKQscD+5haUiMQc8Am1/lILYX603nxMZYqJeakxKfc2PY68f5NE7FA2wkLqa/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296885; c=relaxed/simple;
	bh=ZpAVTEjbmOZ6kNuAy1jpLCmrVc8TEPCioJIqyyLV2wE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=qUO4XJKouQ+NcVZXrSImVDVThi/w7UE0/FvLdQpZfxq0zD0qA664/TJ9x+0t8Ff8M0Bax5WssauAVWwJYztXh7o/lAXFyI7NZ9b2IEEXVodhmE8mbIoHp/u0r4iuQgSDw7u/u2OhzeAE4ekMa/S5gK1eKmmJS5MgaGRt1E6sSIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OoMhzRHg; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OoMhzRHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753296884; x=1784832884;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ZpAVTEjbmOZ6kNuAy1jpLCmrVc8TEPCioJIqyyLV2wE=;
  b=OoMhzRHg5gUhP92JQrJSQvfotEHaILaaeHBbnVooScuRAgHh4mh0Hv+h
   RwG/Dl5p9a69ubAyPV1MydxwAImNRrkb8AN2Apu83WZqashYs1wuzsb+0
   ywYUzeNFgsU4aiAhiPt+254X5WS0vGP5kUywlAdDVbIj4VolRb48mxo0N
   LCJ8ZhqZs//vd4c1AlQ4Jd3Qvk+egsuHXtgql/ZqnwoBGzYK21wxy+s5L
   uO+zlHEsURCBIjxjsf3qKbxAma5epP3nkbf8BuE5AsCoEdF1dQB/DEI79
   +ygTNtfK9cx+z4yBcwfIDkHZPq9yJVmKEE/ITjzLa46yb2HxyuJEsLwFD
   g==;
X-CSE-ConnectionGUID: KkiHdLQqTsaH/GNsu3E0YQ==
X-CSE-MsgGUID: y3TyaflWSvulrsR8O1oF4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="81038409"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="81038409"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 11:54:43 -0700
X-CSE-ConnectionGUID: Kup1L65QSPGGj3Q6QbMWKg==
X-CSE-MsgGUID: 3i5PR1cCQ9uv87u5B/NH0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="158965005"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 11:54:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 11:54:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 11:54:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 11:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTiualbyfyTa7MOIjZaCMjfA2lCdBzEKrc9cBqx8s+Gf4uiwVXHagGfaXCB6Dig5G9o5iWPcCTDgPFZ8GEtcL0K5paK1Ob2jH/YRiY5a6LarVWYYSqEluYoK3AjzKu0UvLhR6IGBo9Fdo4YoB+9MQ5i7pUFbPwcE8xoonqPk9n0vVp1u/GqhGOWIElRxgwwLbHpeiCrucHenAlRW8emCJDG1BEmwqPw4YEtsbUEVgw9ZxK002TwsU6e6eI5rAyDQoJqDLkFZFHLkgq+qtbrZGBWY+xbwLyVD2JzDVhQhURtyKmZSoXntxZhABpnxzWEpn9lkWlGMzIYBGCjgAjW2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaiCQdgHPigqMJ770cV9bz6wa6JEOLVUm9xtVGSCtco=;
 b=Lf0aIMnNmbTPPG/5HBEZFhxaOK+Q1C/6Zs+391ohPdTnOx7GbVF+PIKrCu+cjQYVy6r1uf7Ed2WgvkgF+LmWxTzAFjj08qGBDTnwRWt4A8roRtAMt1AuIbtYU42rFtM/+/GUV9rM3x5enmnBJWpLzcCzivB8aoFSqBuLF3zEI6TD7txpf2diAFVPWZ8ndu/AKnTCyRPogA0Kgu+DybxvuOU6kRxXBXAHb6rh/X2zolLpPfYvjTZzK/Cv3+YoB6CW/wMtKbmVznb68cGWH/kdQ3/4eGfenPPPKzNgBdOYCSEYryPoe1lQoexEEA/MANBcrPlbQCy2CHetCFHlfnYC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9135.namprd11.prod.outlook.com (2603:10b6:208:579::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 18:53:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 18:53:53 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 11:53:52 -0700
To: Dave Jiang <dave.jiang@intel.com>, "Bowman, Terry" <terry.bowman@amd.com>,
	<linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>
Message-ID: <68812fc03518d_14c35610053@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <baea9af7-d76e-4d17-9a7d-2363d4f6626b@intel.com>
References: <20250721170415.285961-1-dave.jiang@intel.com>
 <12646336-9be3-4bc2-adf9-bfd59c589251@amd.com>
 <f1ddcc99-56d1-4887-ad91-714d59b9e9a3@intel.com>
 <400534e9-7763-4364-afb3-5ab9d11cde1c@amd.com>
 <baea9af7-d76e-4d17-9a7d-2363d4f6626b@intel.com>
Subject: Re: [PATCH v2] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf755bf-6e7c-4cf3-ab02-08ddca1a454b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGhKdDJLbnhYVW9wUDdSUDhEeVU4N0w0TlpkdnhibTVldDJlVm02UnN3VFFK?=
 =?utf-8?B?N3pzZnhpc3hJVE5GSG1YTXhlRUtzRURQRE5LbmJUMS90SjhyeHBvRjNHTUI0?=
 =?utf-8?B?SXYwMjZNak9jbGptZ0xTRi9DdjRzSHZFVlB5Ty9QcG9iamhrcm54VkZPTVhR?=
 =?utf-8?B?K0MrdlNiaDZBVjdqYThQU1pWQ3ZpK2ZaTVpwUWhWU2YrTEJtc2k1bU9XQUpN?=
 =?utf-8?B?TWFQMkdOYTkxdmg3RWRXcytabjBVMThlclFYRytUR1RyUm9xcWxDMTNaZEI1?=
 =?utf-8?B?Q2MySlhHRDBMUnRndWlyaHQ4QVhFczlMcjFxWlhENHdHVCtuSWpib1NOL1ZB?=
 =?utf-8?B?VFFDSXhMRzJ6Y3o4VzMrK24wNGQ4SGZjR2huSG1mc0dpdzh1RDdJSzRPZmNY?=
 =?utf-8?B?dGZaSktYZmM4UUFTUVNHa05sc3JVeFFOSlRRQ3dmYkpPaVIyY2c4clRCb09i?=
 =?utf-8?B?SjViNWcySS9UeUVJYldpNmVBWndQa1dORjZKRUpWL0lwZEhRRlVpVnUzVWk5?=
 =?utf-8?B?cXBQQ2JvSm9peVZTRkdOWmc4eHdsODA4alRLaUVaR211SE5yRk5BWUF2N3cr?=
 =?utf-8?B?WkVPR3NaS05TNHlnT0ZndHVteXdGV1BrL3BYK0xIbnV4NVFZN2wvSlovR0lW?=
 =?utf-8?B?ajA4a3ordnNGOHk1U2RQcVIvUUVXY2ZacngzSDJjd0xpZjN2N0pOdFVrNUdU?=
 =?utf-8?B?cm53RnRiUFVzSlcrQlAvVjR4dDArd3N2M3QyWVdtbzFpM25GQVhyNGwvdEVn?=
 =?utf-8?B?TVpLbTR6WjRMMWxpQkRFUnY2ckl4bXpFLzUxcUt5TkFKSDlGMzZaWVlSWHY2?=
 =?utf-8?B?bUlGbHZTNzh2SENxSm9jbEM2T1VScnZzR3IwRXBGZEF6TE1UUGZicnJyeFpQ?=
 =?utf-8?B?TjBXWnMvQ2FmU0lRVDN0TkR5YUtmdzRQYzdvNTJKUGlXM21UMlRXbHBQTDFX?=
 =?utf-8?B?VUdKaHhoNUtobEMvNXd6SjZ0NUZaYlkrdTFYT3pQQThXa0VEYUwvMUtkRmV5?=
 =?utf-8?B?clNhSFFaTlI1anM1VCtFYmtkME00MlgrVjhmMklONVB2RU9nTm9kenNuOXlG?=
 =?utf-8?B?dlRuVmNsUlJzOWZwQ1pNanBabmxtNm9Ba0Jqbk9VWUwwbExKbVRRYXUzaEJP?=
 =?utf-8?B?V1VZYTBya294MkZSSm4yTW5HSSsvcFFEdCtKak1CKzlrRkM4bzY4a21zcWtR?=
 =?utf-8?B?RU5EWmFyZm02SksxVDBSenVqRWF1MVZxVEJxdE5hMzVQRkFlbi94aDJRTkxN?=
 =?utf-8?B?OVgvWC9zZVRHY2dIcTFaam1LVkFMK1BGUER1QWdoRkhYQ290VHlPcDQ3QTQx?=
 =?utf-8?B?bjBKc2hNb0EwM3k1NDd4R0RuTDQ2QjEwV1FXRVZiNHR4QVM3QmRROGZxdzda?=
 =?utf-8?B?SFBBcE1XaVg5MzgxdlRuWkErNXByMkszRW5RbHROMU1pV3BjNUM4U2FSMDR6?=
 =?utf-8?B?NUJvbnI4SjBDQ0hXZVVJSk0rZDBwaVJ2TlNhankrM0VobDI3RzF6ZUdTdTkv?=
 =?utf-8?B?dStVY3NJQjY2OWNHRmhuaWJmZ3F5T01aYlhKb2hxallWanArWGhBb3VWTXcy?=
 =?utf-8?B?SnJCd2RncHIzSndQUWt4bDRlL3BUaVpCUG1udlVTbVdRcmQzaWZFSTlDMnRt?=
 =?utf-8?B?eXJVUnRsTnlnaDV4WUxOb2dOR3ZPb0xlZFJ6WGgvNSt2TDV4ZXJDaGdNVFVa?=
 =?utf-8?B?U05nREN3QzFRUzVoMlZjUVJnY1dGMmhETkNLU1pVa3E0S0hxK1RJNzVxTERu?=
 =?utf-8?B?djZ1elBMMU1NcnlIcVlIQkhiN29ybWhQRExYekl4UlJqUWZaTWdmNm03RVVY?=
 =?utf-8?B?elZLOWNLRGJkMWxNZ1psZGxOQXY3RlpWNE5Hc0E2bXlnMXE1OEJUZ002NDZG?=
 =?utf-8?B?OHJVeUlZR2Jxd3JoNnNEZ0JIWWFFZEZ3SjJ6dTFad1ZMclBxb0hmc0gzbUVC?=
 =?utf-8?Q?vw8X0NhD4RY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFDSHFlZjZPR1pFUzYxQnowTTRZUTZrNVY1R0hUeWpjNUduWjBSbHFHeDRh?=
 =?utf-8?B?UzNrODJPbTVNaTU4VXZDT0FWN0dBYk0zYWJoLzlYM3FpN1JiS3FCSmxVWHhn?=
 =?utf-8?B?NXZmeWtjZ1VFT0UvbzI3bEs0U1hwbTByYkFPRnFYbjlLUkNRQW9obTN1YnJR?=
 =?utf-8?B?dDVwQ2FGNWhzc1RYNXZXMzBDUlNvYzFZT2g5TTlpR1NMc2VHYjQ0L2dsS01V?=
 =?utf-8?B?N01TQU1ncnZ2ekY5WklpQkN1Q1ZBdnhrK25lQlYwSlNTNWdDS1pxQVh5ODNn?=
 =?utf-8?B?UkRwMmtaTHc5N2N5MnBvU0lHSUpxcHpWK1BXNjEwR04wbTUraTBWRnFLU2xD?=
 =?utf-8?B?ZmxzR1lyUkRWdUcxUkdSWGhab1dZMEcrWjJQSDZKSHB6NzM5Ulk3LzdaRFpr?=
 =?utf-8?B?LzJML0RESmFQQVE3UEx3elRTRnJTbk5kdytzdklNMGs1MmhiYXJSOG9Nb2h3?=
 =?utf-8?B?NlNaTkZJTDBoenBhT1d3dFo0eUhjYlpXd0t2ZEpuZFJFZlEzRk9WZXJrOVhs?=
 =?utf-8?B?VUZtWWhkeU03T1NlOGVpNlp3eXZzd3BBMjQxU1Z6d1J4UncvRE1EVkpEOHdx?=
 =?utf-8?B?VW8rWFhjZkR1dU5xVjdDN2tkZ2JqMFJldDl1ZWhXY3c3KzZHYW1hcWR5eHFx?=
 =?utf-8?B?QW5NbzRKa0diS0gwdEdERnRLaGdqZTNIeFozZVNoVnozOTRWQkN1NGJYRWlI?=
 =?utf-8?B?dldTT0FidmtFVEM0YU9vczdvY0x0R2NPVkh6SE1JYm5xais2aWZCbVVjYXRE?=
 =?utf-8?B?bk54TmJRcUY1b3pyNk51cUo4aDFST1JkWFZBOUJyM2RPMkhNa2tEUkRhbDFL?=
 =?utf-8?B?UjBvMFc1VHZDczIyZ0UyWFBQQld6ZVc4aXpVTWZGenQ3S0RRMUVYY3FwZXNa?=
 =?utf-8?B?eENuR1ZRTmNCWEVGbFRqaHFQZDJBU1MwUk01eXJoMXJBeVRab0RtVUpLdjdR?=
 =?utf-8?B?VUpJckR1eXlEbjZYL1M4a0VGYXFvbEYrWGtaU2UwZVppbUtOamdKaWd4ZzlG?=
 =?utf-8?B?S1gvRTgxajV2UzdOWGsxQ1FzK2JqVVRnKy9jOVdLRE9mM1RxWkhHcWhBMURW?=
 =?utf-8?B?MjdTb3lWR0lXRnhtNlB0Rzc0K3pKVUpuVHFIOTZMbHIxV2Vzd04vemhEMnpE?=
 =?utf-8?B?NnVEamwyVERtejJUNml1clJncVBkbmJTeHZoa2ljS3JNeWR2K1NWcWlpdnZU?=
 =?utf-8?B?M0xMbjNST1ZzYnZzTnViUzE4ZU5xcHowOEM1OEtIK05WU0ZvSHpmUTdMVm1F?=
 =?utf-8?B?Zkc1WXVWdjB4QmZ0OTR6R1NjWGZBVnN3RzdGVThKSG9Ic1YxMWIydTB0a1VX?=
 =?utf-8?B?Q3Q0THRMRXNXelVyTnFUN211TTFQVXd2UkhKV0h3eitiZCt4N2ZaYU1wZVpz?=
 =?utf-8?B?aEkyU0twa1dJZzZLanYvL1Z2M0pFcnkwb1JUditDT1VEdkNod2Vhc3RwSDV6?=
 =?utf-8?B?eTY0WVF4RjEzV1RKdGFNVDBXT0ZYL21oTTlUYTA2dUJJa1VCMDEwSlhhWHZM?=
 =?utf-8?B?RTk0bFFERUZSVlFpRXNNbzdkdmFEbEVDRHBBaFY3M0xHVTdqUWliMzdXV0xq?=
 =?utf-8?B?OXNSNkthalB4VnBPYUJnWEFlYVB2VEtWbnlGWDJaSFBQZVZqemtpK2RyOUVS?=
 =?utf-8?B?d3oxTVpRWGlQKy9UUk9zZUhIeDNPZ3hac0RsZG8vNjN5dkNiZzZseVdJam1W?=
 =?utf-8?B?QjZJTURmTGFIN1hiYXhlU0ZCWWJoVGFOMXBrZHdTMDVvQWtCQ3FOdElvcWk0?=
 =?utf-8?B?TnFhZmJ2K2JlZ0MrbjdWcGc3bHRMNHdlQVJsVUQ4cEE2SEN2Ni9FaGNoK2tz?=
 =?utf-8?B?ZmxLcW9KaElJN2IweUxTcFYzZmRrYlVQbU5qOWhrc0JqaGZoaHBjaXZVQnYx?=
 =?utf-8?B?RllNYzZVS0hLaW90M3VaTVlUL0pQcUJEL3YwUTZ2WFhzdUpJaW5Cbm9OK2cv?=
 =?utf-8?B?M0lRSE9sWFZHSHMwZnJZa09ReTMvZ3d6QVd1bDNoemx0dEN2U2VkanJJTFVK?=
 =?utf-8?B?UDdtbkJWZngzZzJGbG10T3VreTVhdkd3ZG00VWxkMEdrTHEzZjNKREo4VHhz?=
 =?utf-8?B?ZzdTU21LeTdxcWduRVhMTUdpVlF6YXc3Z1dmcUpYTjZ0cnVrU21xYWJHV3pS?=
 =?utf-8?B?cmo5eVhHdlVxT3BqMUoyRUNIcVlyVy9CZys0YkQrMDQ0eVFKUXhLRmtxMGlx?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf755bf-6e7c-4cf3-ab02-08ddca1a454b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:53:53.8427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1Kwgc2nDkphA4l0pIWyucl1D7Gk/RuaA80MpvH8JV0WUpiIom5Npu+tsCzz+rpPYYvtoHPJl+SSMOiFEJTzXYc+7jHSKKYUiOI6iPtoywI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9135
X-OriginatorOrg: intel.com

Dave Jiang wrote:
[..]
> > I don't think we want to combine the os-first and fw-first code in a
> > single file. The separation leveraging the Makefile conditional
> > compile is good because fw-first doesn't use PCIEAER_CXL while
> > os-first does.  I think core/ras.c is good as-is.
> > 
> > cxl_aer.c is in the drivers/pci/pcie directory and is logically part
> > of the AER service driver. This file includes the kfifo and logic
> > for offloading CXL RAS errors to the CXL driver. I think the
> > cxl_aer.c naming is fine but understand it could be argued to use
> > cxl_ras.c instead. My concern was in the CXL driver AER-RAS naming
> > but the same rules could be applied here as well. 
> > 
> > To improve the original situation mentioned I recommend we use 'ras'
> > in what is named pci_aer.c here?  Maybe 'pci_ras.c' instead? It's
> > not perfect but would be more precise. This feels somewhat nitpicky
> > on my part and will not be an issue if we leave as-is. Thanks for
> > considering.
> 
> Thanks for the detailed explanation. I'll rename it to pci_ras.c.

Hey guys, please trim your responses.

Between RAS, AER, and EDAC there is significant overlap. You could say
that pci_ras.c is also misnamed because the error details being reported
are CXL not PCI. I am ok with "RAS" for anything that handles decorating
an AER notification with extra information, and "EDAC" for all the other
error notification / reporting / and management flows that handled
separately from AER.
