Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD799182D8
	for <linux-cxl@vger.kernel.org>; Sat, 10 Aug 2024 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723289785; cv=fail; b=E6GO9VY2EMUaQpYa4nuZSwpVjsWfAQFLYIfWCFv2mTqe2V95XycTlEDtdHbc4DMPw2SYBLIjpAxRhWrXh6V1MWwhc6z1xyuuhGpB2ReIBp6batEXCCPIXW37WDIzk5XwuwP2Hq1AbECBwDvJfHNpDnAcTYFLCoDDaybwbaY0dbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723289785; c=relaxed/simple;
	bh=b9+uj1Tf4fQmudAKyy1+lzwFPfm833LGizQiEz+bHr8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nd9E29K/WRyQsO8Gm98z6rfABRti1x/uDGcMW1sCgABiYon2eGBskDWh2LB2UmmXCtIa87MhNrp6HY4z9FxlM6d8h7UAEg5q7x5IpfUXV0gHtFG0IRF0xJHb1DK+SheH9BXhG7Mz6uY3LSdgnnLwpg8hW2Zk0lMNievYEMfs/vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIAbko8y; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIAbko8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723289783; x=1754825783;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b9+uj1Tf4fQmudAKyy1+lzwFPfm833LGizQiEz+bHr8=;
  b=FIAbko8yy1DwVuUNcxuM9CzaIKqTDgeXodoYPfKrss3UuIMTZzyjMyEu
   PStVvN5ZnTxLPgyqYeZ1GW4PIxA04bppaKumyP8hPSgMx5LnAxDk9hJwE
   Q8z3huE84lCLIJ0pRJrs23bye6LBojz2rJfJV7DkZOVeegHmTpQpkvFSO
   gzNjXrQBBVXCByqoq5GhgyNJiaNwC3rlPXYFUmPfdAH70uqowg6zYeoBp
   wKzTVX1a7EtaWJjDzbZ17Eag5mgYo3iE7TSYUdj86d/F0DbnhJGM5xO3n
   qC57+sD/RUMJfcNuzO1bXajkOJx9zceofpiDV8ywx5Im+Bn4R2WZwpQsd
   g==;
X-CSE-ConnectionGUID: VXdg3bfWS2yYGl70UkPMLA==
X-CSE-MsgGUID: /amdzxLAQPOwVb0b4sdAOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="38966432"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="38966432"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 04:36:22 -0700
X-CSE-ConnectionGUID: PAeONVcIS7adhScgPWo6yA==
X-CSE-MsgGUID: vUv+k7V5SqCnldNLMEYMyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="81036713"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Aug 2024 04:36:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 04:36:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 10 Aug 2024 04:36:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 Aug 2024 04:36:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crWFh1MEZd+sguuGtvefVWIB4NEgGyJtCgMUokGTrsa1qnz6R4gZVJdv8BAHJCQk4qMs3CYg2t3HwHR/z8aEmPRSd3igx6M727bHCxrqidAddPRNziHBYfnY0tQmVuQFA5hclvMBqo+L6QxwjFhcTZarcNyC9M3TUxVGIy0qdASUM1fJO2k6UVcYntG6JZj4wxvxvnk1t82RJHyWTQ1ItNDkix8eJFezzAejvdJVLHtocBtvnvf35oytYb4PBgUBLqo7CdPNzbRuhTJR4RQHs438QmKTOFrwRT39JH1FYk/5SZ5fida4yImTZgfKVdKgEWiu0jG5yyfcnXoxMOpOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzEoRpraigUnF5QPRPN/c3wMzfrauzgiOyHRxTJmM3Q=;
 b=sWTHdjt9mpWydpXjUVNC66BRXZldnL/tdElrHDeUJ0SKJewATN04YXeSPFG9sOce6x5iu9DTuNClM7FYLZ/f/c3XOXNFHnqTLvXyBxG1Nsm2mKoYYzs++Oye8wD6095m26ZShPgh4p/2dXXhcpj92TGoRp5ucSxH/GB71KxjgBOo3xTf9LbXh3S8KoauWF09McbEM7sD6QGBWOgRkJ9IZuxp8scNMxShqpLKyVu9aAyJD4GYDkEkB+pWOFQUVVGAafYdAbErc0YiJ3QR3IpZ6rX9hRvajJA7J5Ftru432PT1vLypOX3M5B/GS9nt54vug8xy8F5oozEqkkPd3L2qYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by CH0PR11MB8087.namprd11.prod.outlook.com (2603:10b6:610:187::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Sat, 10 Aug
 2024 11:36:19 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7828.029; Sat, 10 Aug 2024
 11:36:19 +0000
Message-ID: <a2fb9764-a182-4371-aef2-aea2e7e1136f@intel.com>
Date: Sat, 10 Aug 2024 19:36:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 2/4] cxl/pci: Don't set up decoders for disallowed DVSEC
 ranges
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <ming4.li@intel.com>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
 <20240809093442.646545-3-yanfei.xu@intel.com>
 <66b667ca7ad47_257529424@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <66b667ca7ad47_257529424@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To SA1PR11MB7110.namprd11.prod.outlook.com
 (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|CH0PR11MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 0028e089-c25e-4ae5-4b35-08dcb930a6dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2tZK2hQb0JlbEdVY243S1pOeExwc0ZwUDVFMXJibUhtSzdBa1pQRkV1NTdn?=
 =?utf-8?B?WFR1dXk4cExGUUM3elhlK0N3SGR2QUtJRmN6dGg1VTRLOVBwL1FHVHBhSEFZ?=
 =?utf-8?B?K2t5bnRuaWVXZlk2K0RUeEgxWEJFejMzdjhsRUoxc0ZuR3RlQUs3a3NKMjU2?=
 =?utf-8?B?T2ttUGpzT2JLKzlINWVlTDVBVENmeTRoQVpIWnA2WDNzRURyeENSVGVuVnVD?=
 =?utf-8?B?ZG1WVEFLVWRJa2FXUWtJUVFtNVRjT1ZEQ09HcktjYm5KUk1CRG9La0ZWMHVU?=
 =?utf-8?B?dzBEOHZIOWV3eTF4KzVrTXVRMnhsdmFMelJkYUlKZlNobTlxTENhQzk2REpx?=
 =?utf-8?B?cjVpTkNNQzBJVEtnMklNbVNncjQzWG52Q2UxRU9kM1dOendiT1dVSEVRZkpt?=
 =?utf-8?B?a0N5R2xUSnpoWjdiOWdVcVJrN3BBRUFlOGxqY0N5MW1ZUjlJOHp6cGVwTk13?=
 =?utf-8?B?NUZhMWJNMUlFUzJCSW5CdEFlVWZPbjI5WlByT2Y2MlFTTVVkMnVlWHRmeXkw?=
 =?utf-8?B?aWJqLzNONEJ5WkprdXI1a1BHWkVQVmtTU2hVdjkwVEh5UWhYRnVzb0dzWC9Z?=
 =?utf-8?B?NHZpN0NBYnFwZjg5NGs2UElrblFxRldUNFJxMHI3cTNsZmtISFk1Q0dqdGFX?=
 =?utf-8?B?dC8vUjk0QnlqbUZaMjVkMm41bDNzeEI1SC9idGt2dFp3NCsrSFNLVTNiRlRy?=
 =?utf-8?B?Um9XUWJRRjJUVVlMVC9zL0ZGcmFlN0RuREw5RjNPUHVNYmdjRHVSR1NtNlcw?=
 =?utf-8?B?dHZxWWluUFE1UTVvTVg5MXRLM3RTNGIvQ1hqR0lEMnY5NnJKUXUwam92Q2Uz?=
 =?utf-8?B?TDVKRE92K2lQVEF6OVhpRnBiMFFXRzBEM212QlM5cVgvd3JiV2szS2RDM3Ir?=
 =?utf-8?B?Wm9VMWt5QWlTSUFpY3B1VUZRRVpQNkMrczlFRzd4V3ByUVZLZXNaZnhxY2Jj?=
 =?utf-8?B?UVZyMFpiaDZMYUFwa1N0b0hmWk5Cb0pJRERtc0FHb0pwQXBJZXY2NnA5eHBW?=
 =?utf-8?B?Q2hDZXVRdEZBWE1ENEY4dlFyckhwSXdWN3ZqSjJNcTZuS1grWUZZeGJhL0wr?=
 =?utf-8?B?UlVtUHV1Y2p3UEJJYVhKWGxkUngwN0V4djRueXRidVp1VXJjZFZZSnYxODdm?=
 =?utf-8?B?SnkyNWdCK1hGd0dkWTJjNWN4Y2lpb09RTG5BeGk2OEFMby9xVEJDM3ZNTGJt?=
 =?utf-8?B?eWNyZW1RM3JzVHRtMncyNGFhOEhzMXBiSmVqSUpVNmJYRnVmeVE5VFgwcktS?=
 =?utf-8?B?VHJlNFFFRWFBYURDRGI3aHFKbVlNM2tTVEwyZkdDWjVWdzdDZ1kvZnFJaEtW?=
 =?utf-8?B?aVdxS1VLTnN6VWVXUzIzTCtwVWpUWGdiNm43QlkvdEZxbXdqOEdpdm9Temds?=
 =?utf-8?B?YmsrZU9PSXU2NHBlR0xHQXIzRVhHcWlSSUI0czZOREhkZjFhZ0JQTkVIdW1a?=
 =?utf-8?B?a1dacU5PMk9sdTRrTWI4M084NGR3MHMrcFVYQlBJZ0xrRFRCZE9xLzJJZ1RZ?=
 =?utf-8?B?NnBCL2p3WkpqS2JOV2dMREh4VkhnZHNaVitvV1liQTZ0a1ZHNFhyemRvQWdM?=
 =?utf-8?B?ZTRoa2loczBXdGV1aC9ZcmJEYVpuQUxRWTJHUlA3V3BHT1RvZFY3SjJHcmd2?=
 =?utf-8?B?bU14MG9MV2lyZ3huME44bUNWVGtVU3dIb1o1QjBtRzB3SlpUMGdRNjhFU1dH?=
 =?utf-8?B?bnVqcWhJV1dlSWVidVE0MmYybmVNVWJjc2dhY1FOSUlFUHhsZmRiQ3JEWktk?=
 =?utf-8?B?SERMNWMxdUZ1QVVuVzRSQW91aUVkblhKSUNSM25FWVV2ZFVNeHlzR2tlOXdR?=
 =?utf-8?B?SjhOdG5YWjJJQ3UrQytXQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YityYkVjclBmNEZRbm13ZkQwSTlyWXlMTms5NURaZjROZzZocmJQQmlWcmdE?=
 =?utf-8?B?bkxqUUI0TXNwdHBKRmQ1aFdjV2x5WWhoRlh0bmsyN01KeUxKRHV2UWdhb0xP?=
 =?utf-8?B?QTM1L2hTd0FpbGp4aG9OTlc5Q2d5STdKYXdnc1ByYU1ZWjdHOGlYZzM2eUZI?=
 =?utf-8?B?R0twcnQxc29tQThzRDJrV0NuLzl2Z0NpbjBXc3VCUnZsUXp0TVUzamxDcWRj?=
 =?utf-8?B?MUxPR29NNitWYkNhZy9kdGQrNWIrZEViem45NWlpeXpwWk44MkE0RzhmbW1v?=
 =?utf-8?B?ZzZCUGpVMmJQS3FvVm9DdkttNDYwYmJXRVJlbTI0Q0tMdDFEcGxSNG1hMnRP?=
 =?utf-8?B?ZjdnZnNLOEVEV0pONVdBNEtqZ0E0VkZOK21vVWxtYmFDUlQ1SkxCczFYU2dH?=
 =?utf-8?B?SHF2VXY3aXNTeUZZNHVWNTZ5Z25HeFE0VDlPNWJxZDduZGU3RGtiejZtNXEw?=
 =?utf-8?B?YkZrYmE5NU1wTXo4VnZXL3htNEVFa1c1bFdVdG9XWjhoY1FaamQzY3AyYjFv?=
 =?utf-8?B?R09URVd2cjN3QWc3T0Y3NENUbU1PRlV4N25IQW1PSGd2UXFwNzhTcW9NRlFF?=
 =?utf-8?B?Sm9YSkJ1UTRVVko2YW1RUy9RVVlmOW8rbnRweEFiU281NU1ycVpaaGZ2SWRh?=
 =?utf-8?B?ZTJkTjJ0UFdRYXExTm9RSFRHRGR6aVQ4L2lPNEt4NHEyY0kvTlJudWF2UWF1?=
 =?utf-8?B?Mjl2bzhTMFdRZDhxcXRoaTYreU5lSWFKckVLaUJKTVFSb1NSWksvczg1ZXZp?=
 =?utf-8?B?RDd6eVdQMmFwbWdOLzBNbGxZRDlJeHFzT1A3Mm95a2t6UFVxdmxqS2R4d2ZH?=
 =?utf-8?B?QTNPNERaZCtRSkx4V0p6ZkE4WGY5cG8zbzlZWlU4dnBOWENlUlpqS0loaWZJ?=
 =?utf-8?B?S0UvU1RDYm5ueU9yR3BJcncrQjZYZHZyRnhPU01Wd1U5ZU9CSlIycWxwVVEv?=
 =?utf-8?B?cE5kRVFERU83a1lxemxpbVdIeVU1RW5LUkVrOEVBRldQQmNMdEdNQUkweU1W?=
 =?utf-8?B?UkZGajh6SHlyZVZJTThMMFhEQ3YvTExqV3dxMVpCQXgwM09kVTRqNmlaNmM2?=
 =?utf-8?B?MnZlUHluTERBYjJVcTkzcVhNdElwLzR0THF5UERPaEFVdzNkaTE5V1VwamJJ?=
 =?utf-8?B?OVFEcFZid2hVWWovQzFyekovWnJjZm54K3ZtcFFYZGtwQUlrR0MvZG52QU9l?=
 =?utf-8?B?SlMzeDl3RlVBOGZ4d0RCMitTU1NCNWpaTnVYaEh1SjdPV1ZkZm93K0R4WWtk?=
 =?utf-8?B?RDVMQmNtUUpRdDM4cGFCMncwc1U5bFFjRHk4QTVoZmRmcFpDWXh0NVlLbng3?=
 =?utf-8?B?VFl0OUVNZmd0SmdZUjBHdVpNY1llSUpaNlF1QndySno1STEzRjNhVUpXSTNm?=
 =?utf-8?B?S2RrdkFKcUFBMjdIRXJIOXd1clJNUDhETjEzSkh1RnZSZ3BOUityTXdhaDNn?=
 =?utf-8?B?ZEJ6Um0rakROUEVqQkxGRnBDZ0czQnUvN05Qb2w5K3ljeVNYaTFMUklOVjhQ?=
 =?utf-8?B?WkV1bitzRlN6NGllclFuQVd3VFZDV0xLZXFzOTdPOWcraEdadWlWQlZwNmdw?=
 =?utf-8?B?MUo5c3VBbWtPUENjb3RpcUQ0azhrUnZ3N0ZNbkkzYmlaZE9YaUhod1ZrNmhI?=
 =?utf-8?B?QjlkTkptVDZwZnZqcG9UbkZlQktiSjU4V2dCSHZJUmxsblErbkVpYldQSWJa?=
 =?utf-8?B?Qkt6SDB5c2hBZzVUNWtGT0R1WTAwZ01KbEE2eWVhT2dNKzZmcG54a0FYQjZh?=
 =?utf-8?B?cFI4RW9Md0JLR0lod25jK2lOQTRYNjFpRjAxQ2NadTlLdVV3by9waWhvQTRu?=
 =?utf-8?B?WUpuYmdWaGZEeklsT1p3SG9GSS9RekpzSEl2SWRsZDhEMGt1RGZUc3RtTFBK?=
 =?utf-8?B?d3A5eFNGSkhWWXE2TFBoK1FTZlhQRUlTOGc0L0V2Z1hSUmNQdDAxekdqMlJK?=
 =?utf-8?B?R1pCekJpdFQzSzJscG9WVE1EM1RoMEx3eHlIY2RBMDVCYW01NDVFdnE4eGs0?=
 =?utf-8?B?SXNJNzJGU01JQ041MUFSMjFuVk5EWkVtSjM3OFFTeVJGOUZqZmZOc1dKNkVG?=
 =?utf-8?B?cVJ0NkpCaHJYcWYzSUJCdUJEZDZINDJGMmhlVHk1QlZkcEV2dXZZNTVMaGhH?=
 =?utf-8?Q?hk6QcA7sp/73QPZEBxKtX5wbp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0028e089-c25e-4ae5-4b35-08dcb930a6dd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 11:36:19.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48doJk2MaVkGwsQrRLfYfrQ1CNy0s9MbnNHfRWlo9+9MrY2O7ryLmsDXeU6AIK+iJRTXsHAo2rIlCpeVtKHQeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8087
X-OriginatorOrg: intel.com



On 8/10/2024 3:02 AM, Dan Williams wrote:
> Yanfei Xu wrote:
>> Since it shouldn't create and configure decoders for disallowed
>> ranges, move the check of dvsec_range_allowed() earlier into
>> cxl_dvsec_rr_decode() to filter the disallowed DVSEC ranges out
>> at firtst.
> 
> "Fixes" explain the user visible side effect of the problem. There is no
> problem being fixed with this. It is maybe a conceptual cleanup, but to
> me the risk and thrash is not worth the reward. Unless I am missing
> something this is just code movement for no value.

You are right, this is much like a cleanup as creating decoders for 
disallowed ranges doesn't have side effect for user. Will drop the "Fixes".

I just was aiming to avoid to create decoders for the disallowed ranges, 
since this kind of decoders don't take effect in practice. And we 
already checked and found that, why continued to create that? :)

How about changing the dev_dbg() in below codes to dev_warn() when find 
disallowed ranges to let the user to know what happened.

         cxld_dev = device_find_child(&root->dev, &dvsec_range,
                             dvsec_range_allowed);
         if (!cxld_dev) {
             dev_dbg(dev, "DVSEC Range%d denied by platform\n", i+1);
             continue;
         }
         dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i+1);
         put_device(cxld_dev);

> 
> The "risk" is that I think this breaks cases where BIOS has enabled HDM
> decoders. I.e.
> 
>          /*
>           * If the HDM Decoder Capability is already enabled then assume
>           * that some other agent like platform firmware set it up.
>           */
>          if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
>                  return devm_cxl_enable_mem(&port->dev, cxlds);
> 
> ...the DVSEC range resgister values do not matter when HDM decoders are
> enabled.

It won't. Even no allowed range, it only keep 0 in info->ranges first. 
And the check for whether info->ranges is 0 is performed after the check 
you pasted.

     if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && 
info->mem_enabled))
         return devm_cxl_enable_mem(&port->dev, cxlds);
     else if (!hdm)
         return -ENODEV;
     ......

     if (!info->ranges) {
         dev_err(dev, "No available DVSEC register ranges.\n");
         return -ENXIO;
     }


Thanks,
Yanfei

