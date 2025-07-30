Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD691FFC55
	for <linux-cxl@vger.kernel.org>; Wed, 30 Jul 2025 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905629; cv=fail; b=riS13yO6jNj9BPCwCNeHQlrzkqwcX+w7oVmpRI5Plg4QiBi8wrJH9ZF7+75qUhpmVxKQr9HVnQF228hypj3gLR1gZqqOE3qSgr1rklpsJO1ryX+o5uXedVgaxlW4e5ppVBgKtErxCPWzZMn/lVa+MNV078MuhP+egpC1880rtfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905629; c=relaxed/simple;
	bh=rJE0eG+Kupx5/vSV76equfmd49auY67hxJzvJaInQK8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=U5ZfWNar5uDLwsDRwZCQUtNVzjXre2xaa9JCf7isLJFZi7+S0f7bxV/VSDpIGVXC7UIUipvbPbOWqZHE+Vo4M2AebxwEtK59GzQIwr7Ke7qZ1vZNZdNKB6VO6I9ayrfv29RpLzg2HmtUixhJ8tZxyTpQlcW8RWFVwt1NzYObyFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKID58bn; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKID58bn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905627; x=1785441627;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=rJE0eG+Kupx5/vSV76equfmd49auY67hxJzvJaInQK8=;
  b=OKID58bnY/K6aFBrgOjdPbISefyFNTu+to9BdZOwfbEz4o0JJ0ns2ClK
   Faw6B7Qf3PtttEqZbT76rZag67uE6Y8WywLW+c1dz5Ynion+Nks5cT+qk
   LhDFvJx+2jlGLNIBDefkCF8BMTxXzGOm5seUy36k6JUlWX7ktb9vqeSWm
   917xk8uI5mxAz7SSCY+70xfQI71Ji0yWAWl+uH7jJuLIcwZn83ya4xCQv
   a8+RFh9QW0iVt5hoIVbOHtYoXP5K9CI5NXM8wpMD6rn/weQfFG4HJc4cG
   vQVfp20O0TISwBBx9x2Cy+GQBdru/c/2Vl0agzYN344ebk6sMVKKLc9oL
   w==;
X-CSE-ConnectionGUID: +MWr/jbeSJGI14T1eZnfMQ==
X-CSE-MsgGUID: 7bReLxNwQLO5FiMdAhX8sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73808171"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73808171"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:00:21 -0700
X-CSE-ConnectionGUID: IGNhlUflTcSnt9DwRaJrJA==
X-CSE-MsgGUID: tLzlsIpIST+7tNhMVXrOxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162956171"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:00:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:00:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:00:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.84) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:00:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6MscM1A9BkGLrmQVpL8n3hCP1i+ff1AGiPgJP/t7MjRkpzFoeJx5zodbJl1dnMWQHbtxQcM4Ktpgc13yMoKLBw6GrZQ5+ZL0u8IGVT6+jon2atTpsovSgPFB33TND1vYUloWGuLafgMfxO1ihJEi1FrRI7tq7Di9Sh0mucYvZwVSCA5dh2xjx2Xrynb3xlTMXmG+5OXLp6ulPIG0J7ngCUbpwOScwfg0tJPWrWehmT00najCMUwq9ZyQm4p6kLaTZs59FyFouj2yEqH/UltZK7ZTr7oiXgJ+yLIuB0Fc5qPsvscfIuzI+oWBHqF2l5znWMJDmdzE81HWd7q/Nbcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pb8t5UfWvpRbbTGerOs3mEiNseaZLdOnxZJKOczNfw=;
 b=q/fQ5ta66zmDDCMb4XDXQivZUIHnFcgxB1gT5ye863d+hMPlmUHOkxRONslqJDfAQdOzj3hWPPeohF0VhZBduogJ5br326wEzpv8dN8NZAtj2VieJGbLW8HDgaTNzN91e5auu5gdvnhYJRYZ+TR+ZgXwaacMwEKPpmO4LUDuT7Q+Xi3G8zjCr0IXdVW+i9/GN+lo0vt1kYA8puyW2LBydNWAaQ1t/4JEEfsdu0VAgjbDGdBv5GI7Ykt0QBJdwKquJci4gi/Yk2x0xQzneRvZ+xCWrVrefcURxAtBbzfmudSFjPqkm/h/MMM44WZ2BGk0m31a0kut5muUDS/DAHSzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8571.namprd11.prod.outlook.com (2603:10b6:510:2fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 19:59:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:59:30 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 30 Jul 2025 12:59:28 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>, Terry Bowman <terry.bowman@amd.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>
Message-ID: <688a79a0f0d09_55f091008@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250730152519.125601-1-dave.jiang@intel.com>
References: <20250730152519.125601-1-dave.jiang@intel.com>
Subject: Re: [PATCH v5] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8eadc7-1669-476e-d4cd-08ddcfa398d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MllmOWp6UHFuTDN5WnB5QTF0cGJTVTFvMnRkYzhEYU9sdGI0YjZLeG80azdX?=
 =?utf-8?B?bVdiZkkxdjgwMWRGNDIydTRsd3F3YW1lZ0w5cXNueGg1V0NGRkpraFN2TVRY?=
 =?utf-8?B?T3E4NDFBUE1tVVNXUnh4Wkx5RlVXUVRtSWMvWFJHVjRQSmJlMENmZ3FMSWg5?=
 =?utf-8?B?ZUdMN0V6TGJkS3B4Vkl6cUc2ak9YejhmU25Sem5Ra0xWd2U0cGNOM3lFaDlN?=
 =?utf-8?B?S3daN0R4eDZiZXBPNHRZZzVUR3dsbkFMelBxQ1ZXV2l2TXB4K0t1WS80dklI?=
 =?utf-8?B?bGJETnlqRXRySTBlS2hNYkQ4ajBLMmNKNlpkQjRiMi9Ic05QQUxEUjIyazZ1?=
 =?utf-8?B?dzBuMFpMNUdlWXg3NGdtVWxXQUpBUzllQS81R1BkZVpLbkRWT090ejRVMlBT?=
 =?utf-8?B?WEU3NTdLUmVMMDBJeHlWRFV2cm5XOXBGRVJvQVdjdUREZXlOazBmR2FEb3V4?=
 =?utf-8?B?TVhMdUQ3RlJGM0xPQlNHUHk0U3FsVWpXQzNWdDNqcVZzL2pqdy9YWEFKelZV?=
 =?utf-8?B?ZDNpNXMrbi8wUVdQaWVJRWNmR1h0Nk5tbG12YzRWd09uVWM4Mldmb2NxRDA0?=
 =?utf-8?B?NmZQMlduNXlmUjROMlVxUzNLRkIyT25SaW5CTW43UUhjZEdXWGRrNEdqVkRS?=
 =?utf-8?B?dFFZWDQ4Z3ZTcUlUcFZMTGs0UVlHTGh6QkYycDZpbDRUbmg4Mk9rTEJ3anZp?=
 =?utf-8?B?Um8xbnZocmtsUEFZYTQzT2Qxd21oQ3BmbnNnejF4Y2E4b010SXNXbDVaT1Z6?=
 =?utf-8?B?TU01Nlg5Y0YycFVRak9XWXJFM0FMMURYb1VlOHZGTnhuNTg2ZE84WC9jWnE4?=
 =?utf-8?B?Z0xCRnYyYXQwYkR2eUpIVnRrVEJLRzVrT05WYS9mZmFkR0tsN25XNFJtanEy?=
 =?utf-8?B?QmNoQ0FrOXhDSWhNTUxCRkVFa25IYVN1T3diV0IvNmtiZjhyZ2VuRGpnTDdy?=
 =?utf-8?B?UFdieTBwRFh4RFZmUHkwd1U0Q1BTNlJYQldRc3V5Z0NYL29xYVJDaDRtU09Q?=
 =?utf-8?B?ZWNhSmdGNTZCOFJNVk8wdXRwak02TE1ROVdORU1JY2hqVzh0cVJScEk1bXcz?=
 =?utf-8?B?ODQ0dGkxTU5mb3VYb1R6aWVVZEZucVJtTGJkUlhrWWZiL3hNVUtLQS9FYmdP?=
 =?utf-8?B?dU45V3czVFNZblIzdEtuanRIL3pWbkRTMTh1eWEvdVdCazFKcVZ2NXF2OFpz?=
 =?utf-8?B?M0RkaFRrd2JnVWtDSUc3Zkh1SXNjTWRkVmR0bkcyMWhWdWlGRVdIZ0J4WU9w?=
 =?utf-8?B?UXpLZGxUR000akI4WDRDLy8rQ2tSa1BUNVQyVzZMSUZGd0MzZ2kxL1pCNU5V?=
 =?utf-8?B?Qld1bTJiNDdiUXpubEp6b2hEb2ZoajU0VEZhRlBvUTJRQW8zSXBWUnY2STdQ?=
 =?utf-8?B?TTViSlh1MGJHVjFFMXlXSmFDSjdKUnZZUjY0Y1VENmJRelR0WUZxREVMK1Fp?=
 =?utf-8?B?UUJIME9hTG5ST0pMS3dnVXRYb1puWkZxTS82ZlFFWmwrZnVzaG1QZGhSeUxM?=
 =?utf-8?B?ZEFCdGphUG95LzkvSERjUnBPaHpLMHNranhJTWRtVnhiQUc2LzVYY3FNdXMr?=
 =?utf-8?B?ay8ydmVNcWswcEV2NDdlQ2QrL0xRVWRqYkp6eEVNcEZURmpLalBxMjI3all2?=
 =?utf-8?B?a0NEL1g2TzJpcXFyclEyak8wdzBhNDA4NWRKVk1wTEE5bUpjMERPcHB6UzR1?=
 =?utf-8?B?RDdLOGtYdCtBZER1MHRvcThmOVVSNzk3LzZIaUE2bmJUWHVJTklIVjNvUFVI?=
 =?utf-8?B?clFlUmJpN21FWGk2d1hMYnlGMTUyM080MzdvVHE1bmd4VDA0LzBaN3FvVDUz?=
 =?utf-8?B?YUZWdElqbStjS081MUVjajZnYzZWNS9qczdIT3gzMFBIV2tRbG5ZWTI1SWlj?=
 =?utf-8?B?V1N5bFF3T3dzNjVYWWZxUlU0emlLb1ZMNlV1cVY0enU5djRzd0t1UDRXL0pE?=
 =?utf-8?Q?smDjS5SgeRc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1llaXRaUXhHeStGUmxNV042OWljcHEwYnJBTmpYV0RvKzNzclFHZDNMWkls?=
 =?utf-8?B?ZXFPZ3YyQ05uc3VWVTdrQTQ3VDlrN1cvWWdONEVmV2NvakRiRkQzMHIwWDEv?=
 =?utf-8?B?bkMzQ21rWWljaWpocGs2dnhnSTJ1MTlvNnp2V3JaUTNKZXRod0hiYy8ySVFJ?=
 =?utf-8?B?aDJKOE9JMDBTT0JranMyNmVVdmxjckNuSUp5VTRtcURkNkQ0amNFcU9PL0hp?=
 =?utf-8?B?TGVHOXpBVk80dWlCakdDN2lkcGR2N2RodHBEMldOdEwvTENvemNiTmxDQ0ty?=
 =?utf-8?B?MkVDY1J3Z3hUVy8zZDdDZDNoaG5wVDRoa2lXU0c3RUUzUElXSnZRTEVwdUNz?=
 =?utf-8?B?c0ppL2VmK3dlaE9mUXZTNjRTSUlaNmt5RFdBbnBqdWkzSFZzb2NFVTl6RUNY?=
 =?utf-8?B?ODlCYVFTNG0wNEdMUDh1SU5BN1Y5d1hFL3pleXRnaFpwN29wSmlIYjdCV2dM?=
 =?utf-8?B?SERNYWt5a0Zrcm1mZWtadWE1RjYvSjhTd2ZRWlJ0UFhUMzJzWTZRVitPdGVR?=
 =?utf-8?B?QVVTT2pWaGlvbVRJM0ZsMVpJeGYvdFJjV2RReEQvamUxd01NU1B4MFo2VEd5?=
 =?utf-8?B?WlpMcDg0dzlncE16MjJ2Z3lFcngzTWdaSmpPcnBRMkYyZ25sTm9rVUF3dk9E?=
 =?utf-8?B?bEF2ZzA5ZnJzQ2twZ0ZDZ0NMSXBQTE1saTVEU0dWODhKbzMvQzltS3h6alRz?=
 =?utf-8?B?SDd1ZXZzaGJaQVVzMTJ4Nk42VElZdGhRQkhZc1QwTmxaNTRnMjM5b0J1WHYx?=
 =?utf-8?B?Q0Y0NkV6cU5UT2laRFdUVkd6a1UxSS9JMnhBTnlZYWR0bjJPaHE5cVNwWW8r?=
 =?utf-8?B?Zms0K1hPVTJ5cjZpa1FMODRxYm0xUHltNG85amxBYkZXQjRvM2tEM1RUS2NR?=
 =?utf-8?B?NzVyMGpEb3NnczhTM0tDRno4bHBCYlhJcGlZUWxlK1hWZGVNYlVXRXFsV0RV?=
 =?utf-8?B?KzJoOGFFM0RmcHFWd1ZSRlhjTmNEcXpWUkFDSUpaeUFpSzcwS0tOd1BKRnZC?=
 =?utf-8?B?ekhiR1BOVW1NK3BLM2hEMEMvc1piVlNTRTU0dEtsU2NleWZnV2k1aDZOU0Nl?=
 =?utf-8?B?ampMNjk5dDRwTm85emxLaXlHYzhvbkhiYVVXUVlwbXo1eC90QUhDSm1lMDlS?=
 =?utf-8?B?M1ZwZVhOUGZaRkN4TzdnbDNkNU5IcmZ1MTVRZjhxNTJBUkpvRW1hM2RzeFp1?=
 =?utf-8?B?ZjlBSXh1Z2VidDRTbFlJbDVCME9ETEJrS1c4K2l2T3cyMUZEb1ZuWThUeDNj?=
 =?utf-8?B?S0xrRzA0WGRrUjV0am1QRUVBcjd1MERpTG4vTzJ0NHVOOFRXYk9SSjZQd2Rn?=
 =?utf-8?B?Z1FibDVWcFZCckI1cWN5Z3I2TURlWG1HK3V0TEJJazYvaFcyNTJsaEVVb0dt?=
 =?utf-8?B?d0pjczMvWGJidWpYVHN2dmVIQldiTmhoOHl0UEpUWFZuVUE5YkFIQ0gzaEZF?=
 =?utf-8?B?bU1UMy9WVWs1TXp1MGdUay9mQzlpYmNBMjJmNS90SGY4OUZ1SkUwRm1TSmhs?=
 =?utf-8?B?bmM0V3NWcHN2eEt1ZExYWUp6V3A2S01BR0ZIaWZOcThxM1lYd05BbWN5NE5O?=
 =?utf-8?B?YVZMRnZqTStzSlo4eE94dzM2V3dZT3lLTWkxd3J0TU9TaG5SbXRQcFR6bGp4?=
 =?utf-8?B?NzJtNThhejB1RVVaazdMZCtiZFpCWEJSM1g0aHRPejJDRkFUdkU0ZlcwZ1p2?=
 =?utf-8?B?Nm1nUW9jWGdrTnFZTmJmNTdNNnllVCtySzlOakhXWjczMklVRWw5YS9ETjhI?=
 =?utf-8?B?WUdZR3dTTFhlcWZydG1lRDlVVnpTcjFFcHZRVTlpV0pSb0hCcTg0ekpQazR4?=
 =?utf-8?B?cU45VVV6U3V0am5qU1pEY2l3QmVNV0hqTGRiMkY2YU93QTRRM2tvUDRwTWcy?=
 =?utf-8?B?SXNIZU9PWEQ4TUxwa2dwUllreStFYktzVnJOUmJWaGdLMENyLzJCc1d3NnJq?=
 =?utf-8?B?ZS9WS3h6Z1VIMHRmKzNoVm1vdVUvaUtpNEtiWHFnMGc3dWRjUG9LaEpNNFRp?=
 =?utf-8?B?K3pUZ21YZW5XdFZidnllUytPNVB2THo3Q29FVTJwamxJdzM1dlNBZ1lEVWhq?=
 =?utf-8?B?QWN6OUg2RGp4Qjh3clB6dVVpY3RKTm9aaHIrZmpMcXluTXMzWS82QzJmVHpB?=
 =?utf-8?B?QmxtL2krTnJaYjg2T2RYU1ExWlhWMHIxSzlIQzBpeEVvbm5hKzhLZFhlMi85?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8eadc7-1669-476e-d4cd-08ddcfa398d7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:59:30.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADI5erfAsaQdeJfXv94i7iMUuahSCTXhealsyag74wzfMDqfg6MJ9G5yGXYZdrXm87zFPWka+3gP2aQikQ/VvPwdfsu0FVAB8vj20Nx6fek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8571
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
> the config. The config will depend on CPER or PCIE AER to build.
> Move the related RAS code from core/pci.c to core/ras.c.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
