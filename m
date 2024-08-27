Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE56313CFA3
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735105; cv=fail; b=qtu8CFjhXVdeTN6c0YUvM+PW9Gdl/vGxBuSjNak9k9sbzpOvlIyg5iAhPx2VCwQbfPcOdnMFU+VKpdwn36gumX7FmeuS2suU4rtSJaBGhJniGT65//PpawSTJxfOqMcUJJ7u5hbmJsRIB0ISw28pfBniF2RGEPZW9oioutsA0GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735105; c=relaxed/simple;
	bh=pHaY7oYpZ0k8eSy7ex/N7PRw8s6XwXSUycAFJ/R3AUs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ob8nTxVJSdL+4DjoXy6UW5NMHXiF4LLuWXM3eFh7tAfTV6mytsSq2pSGWHdzqz2SUQ/maFd97ECPBlxHJdx4IqQRM4DOoWQd/vzHTe3FRUvgLJmRUav8notQYtsEEad4u/VxWmeUu2zB45W70fJlTkuGROImS6EVdOPU9RYmZf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bwua5w/w; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bwua5w/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724735104; x=1756271104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pHaY7oYpZ0k8eSy7ex/N7PRw8s6XwXSUycAFJ/R3AUs=;
  b=Bwua5w/wtsHaYn+/z3LiNGG4sr6tMlSrfxgtsii8Zr3ClDUcZxqGtb17
   5OBgI4IfbnX46zWvqW6ZtcpFqhQZ1xKWf34fVBnPRnFspJTLMc+F8I00i
   Wc7Jy1+8S9eJ9aQMLk4cg0xa2OG9PflqauKf3nZxcX3JulsXvg9OcEn7T
   vtvSLizkFDGKjBkuPeQaswxDWuVKz47yVmAah25htDp4mFk334LNRs/Dd
   x2cIJ45KVBX3D6j8c9og7JkbJA41IyZR8c+pfiRu2yoCOG5jegaY5kDNc
   h4D0lurx2rfJTWrL8y9LhWD2ZpK3kBHcusJNbKX0M0+Vs6myb3VAnnQgZ
   g==;
X-CSE-ConnectionGUID: UKQkj+e5RreJPXxk9DR63Q==
X-CSE-MsgGUID: D6EIsQLkRbSepL+xlwBr7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40694304"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="40694304"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:05:03 -0700
X-CSE-ConnectionGUID: 4ZuO9AfISwKYv+7MOz+xIQ==
X-CSE-MsgGUID: zXiyA3EhTvSu1YDzlLHcfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="63250784"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 22:05:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 22:05:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 22:05:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 22:05:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 22:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJdQHgzBOq/sXh3m4E+4p7+ycJKa98nIUYjsFA8pR0uXJuG0ijnaZCJ58kGDMoT9pF7VMOajxpcLd1L0nWPLpUnGOsoHKTBJa3cOuUkjyMiOVhXXQD5w+iT/Squ6I+GpUzvaudkeLUyIIyuGyQKzDFHwAyChCn1R4YhUAcBMp/3l464p8I9znHoOMuw9z58/9ojY/RLuM0UyGjo3M+kRlZbgAAqn3XMt2lHVzEnFCTV1Y3YWZoBAkqej7pTOjBgTWYz9S4mXvcLFS9OXhOfRl5JPFAlkYyL5HRI1AWmrtOowxVF8sPflCu/UG6ESm/r9dMKjn1GagCAdKo6LnGUj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0rgdiQA+VdYn61DEjlEfZ81xz4MRDb938VcOTb3zsg=;
 b=HEn9RUPHUPV3+/re3q/HzdHhVLxU+/kX3/Y2Y44GSZ/4ODORfT+FUXstw4dwtqTHNB8QkwfDASng6I/9jWalzI4XjUjpiM88scvXODqxr0uLlrsqIbJnCiONvP17kxDGOUPIlHYnkdzXFQNqzrY1FQZgJF8T/SwqENa0EJ5xHBFl7La3U/Gu40ZrWBxfOnCGW3M3jaOB8CAiKuHHyw5yFfNAbsNFJPrS/cvFBwCLJ5gUTfI2iy/+lEcSxYDFk4JNMr6RNvAukRNL4beWRmqovSbS9xHRUVCHkOR0yd5XEyZFeZwMUMWGmUADbtcDU1684KmKwUiepWtxyJhummncGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 05:04:59 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 05:04:59 +0000
Message-ID: <b48f51c4-4f9f-411d-acc0-ef71b912007a@intel.com>
Date: Tue, 27 Aug 2024 13:04:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 0/4] Fixes for hdm docoder initialization from DVSEC ranges
To: <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming4.li@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <20240813110532.870869-1-yanfei.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To SA1PR11MB7110.namprd11.prod.outlook.com
 (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|DM6PR11MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c87c32-0d60-4acb-a8c3-08dcc655ccf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHB6c0R5Q2RPSkl0bDFNSGd1bkEySlN6VW84M3VEVzBPc0x5VUZManE1TE5W?=
 =?utf-8?B?dlhja2xxS2xxN0RkUkFTSnkyMkppMUVSWjhQSVhVZmJZZHMxRDdrUXEwbzFL?=
 =?utf-8?B?U1g4b0h6am9wTVJBTUszTGRTRjdRWmthZzlGMG9sSTlNZkljMk1BckN5N3Fk?=
 =?utf-8?B?WGZncnE0b0Jjd3dJYXZHSFM1ZHA0MXNyKzMyd1NqLzlraWxWeTFSYWcrell0?=
 =?utf-8?B?T0ZxZDlVaVVVQ1NONGN0aVZNeEtyWFY0dWdPVnJYczI4UFg0SnVFRDNmTzNU?=
 =?utf-8?B?T0UwWWU0SEpvM1NNbW81Y20rMzFPeldjME1WMWt1UHZ2Ly9oQmJVV3RqdFJx?=
 =?utf-8?B?V3hGczI0UFNiaFZsVHV4OUpocEUveVhRMGlpVVFiSVZpZERrSW5TaGtGZjdT?=
 =?utf-8?B?RXZvUktXRndhRzVzcXFtWCtZTHU1c1hKdk13QW5RbFlJaExCeWZPRE52ZTM4?=
 =?utf-8?B?Z0hnZ1FuS0FEOVhXbUpoU2lRMVl0b2RQRm0yMXV6TSs1OG9DVVh3bDdHZ3Jx?=
 =?utf-8?B?aFFGbDdhQ25YRGt2UXNQZnVwWmxTd21hZDZVTDU4V2twM3FXVlZTRzBVYTho?=
 =?utf-8?B?WEgyeDZ5dFUvV3FmQWFkTFl6ZVdWTmNYQ2RaWFdXajZTU25xTFFsSUVPSWpC?=
 =?utf-8?B?U21aQXhsRWhxY1VqV0pPUkh1UE51ejM3RFpSRmp6UWlQWFJ3emk0MmNqNDFY?=
 =?utf-8?B?dzJRQm1KUmFEVStMQUVMOWw5LzMzSGhDWHVYaDhucUwxVldDS2g3RkNNaE9F?=
 =?utf-8?B?OWtxSE90KzNDUmNaVGRNYXUrRUh4aU8xS3J0Uktndmw5d3ltQnZjYkcyVUF1?=
 =?utf-8?B?MTBwRHlDcGhUOGwybkhHVU0zZFhtQzZMU1E4L2Y4WUt5dnpvSXpWdHcrQm9X?=
 =?utf-8?B?QUNLVWd0R0czaldjYXFLelVCMzhIZFpGV01RY1JqbEhtVG5mOVYxNGxNUjdW?=
 =?utf-8?B?ZTB1dnB6OVNUbUlwNzlkZTd6bDM4Um10YnoxRGhEcXFRQWlBVHpPVVhWQ2RO?=
 =?utf-8?B?WmZtVXJZdUlnelJYV2tVRm5KcU11UFI3Y0VUN1lXbFIvTVFKNHVjZTdmLy9z?=
 =?utf-8?B?bFVmMEtFMFhJK09WYyswcHNxdnVmOStocGk5NEt6WjNpWGMxQkVLbWVMdEhN?=
 =?utf-8?B?MnZ6OWtodjhDQWN0d2o3U3hhdjlnOG9HL0Y0RW5GampoMTRMeEgvOStJWVJy?=
 =?utf-8?B?d1pCRWttak12VjQvRlkyeEtkakFqaDVWYTB1MUxhMHk3eGw2Uzc0czhrK2RW?=
 =?utf-8?B?UFYzSSthQ0RwS3JhWUNkaHpMb1duUWpLbEYvaVphekpHVUlZeU8vcFlRU0s2?=
 =?utf-8?B?Y2xJQk5YYlFETE40QlZHTWlVOHZEZVBIQTVhcFZTM3IvTVU0SmRTZDRWUE0w?=
 =?utf-8?B?bW1WVUVnc0dTVmNhSFlPK01uNGZFVk9WbEFkT2xSaXBlaXhlTlgwcURYdjJI?=
 =?utf-8?B?YUFqeHNQYStjS3cvTjZ5RDA2OXoxVFhJVmVpaW1qZzdNODUxVko3UktZcGtp?=
 =?utf-8?B?NlN6MGhBWjBEM1FiNlZIR3hLcGt2cnRnK2w2RXJUWnJxWVFPc0J4aWNOS3NJ?=
 =?utf-8?B?elovV3lCaWwzQVVaMGVCZjRuK1h4bGVrRGRkeTBINlI3ZW5RU1F6b1lBYk15?=
 =?utf-8?B?dUcvSjZwMVdKUm9tTHl3cmlFa0VkMGttRTdKWFczODYvZXBIdEppbHgrS2JW?=
 =?utf-8?B?MkgzV1JqNTdIR3lERFRLU2pGbW1jQklscnY1b1pPMU9KK2xubDROWjRBV1VN?=
 =?utf-8?Q?xKZ2I/UPe69LTKSuvY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVE2bXVSdzVPNlk0c3l6dnAzcDR6ZjZHcjlHRGNLYVgzQm0zcmR1dzFoQTh3?=
 =?utf-8?B?NUs5TXJVVHRpSDVLZEtxMjk4Qk5ucXMxdWhnVlk3dUdnc041MGhNMzl2bmdD?=
 =?utf-8?B?akpNK1R1SXlIaVFERjFKLzB1TDRLVmhwVEVPQ0RUZk1NdXk4Y0NaZ3ZkVUVV?=
 =?utf-8?B?c2hlNU1FbzR0RTdFZ050WWYyNU5ISjVFYlgyNHBhZnRqYjdpTGtBNXZOSUps?=
 =?utf-8?B?NjhDQzdkWTJodG12YlJ0b1lNL0lnQTZWam5iZ1g3RU5WN0IzRkJObXR5K0RE?=
 =?utf-8?B?Mi91bHhmTjNIZkRRcVVFK2tDakllSUsycndsbUNYSUxuS09Xckd3T3pmTk5J?=
 =?utf-8?B?UFg3R2draHJEaDdhVG1VeTEvUFBaVFo5RnRxN09xV01vQStRUkx5N0R2SDE1?=
 =?utf-8?B?enhJU0RjZjA0anR5ZFNkMmxGeEtjMy9USnpGT0ZjSW41dlVwM0d6d05kZTFh?=
 =?utf-8?B?akNIVnlYR3htNTVValVtZWxaUXk2QTJqZ0wxRVcwVGw4Wlcwa1hobmhVNDJv?=
 =?utf-8?B?RWN1dXd2NlVBSUVobHZndjVieklIQnJjZWd4Ti96WnZIYjFHT2xNUlpYOXlu?=
 =?utf-8?B?YTN5WnpSNDNGZGp0R0dkVzdlRDM0K2JEVnRrR3lJcGNJRXlhMWZ2MVVHbVhC?=
 =?utf-8?B?VXFLdDNrSTZTVlR2Vlp4K2VJa0VKNnAzTmNHQlp5VE9QK2V4dkR6MmVyQUp6?=
 =?utf-8?B?MEp3dkNFYi95UzFrRUh3S1ZITzNtMUtSc2FKTnlCb2ljbVBZM3FnZVpCQ0dv?=
 =?utf-8?B?YmwxMnhvWFN1cktpYlJNbkUrOWpwZmVhQ1JKMnk0ay9raUg1UUdTZlVWc3Vx?=
 =?utf-8?B?MVJyMDllTGlhSE9PWUw4SDFBdVEvZjJ0Wm1zL3RqMVN4NjYvV3FzSHc5R1JM?=
 =?utf-8?B?YjQ0NDkxNStWaGVqYk9oYXJTR0N0WHR6bTVyK3pNbno1VXVCZGJuMkZjdStX?=
 =?utf-8?B?STZzS1hPb1QxYkRlTW5CdlBrblBZNERHZVF2R21DbUVJY0JSalhaR0NTczFE?=
 =?utf-8?B?RkxrSllqQU4zbDNKY3Q5UFdKb1plRUtjOFJ6bGFHWDJWL2d1RlBQU1dRSUlY?=
 =?utf-8?B?UUFnZGR6SS9NZ3BFT3VZbzhHWW50OXVEeHVwazJEWnlHamVQSHYzWjIxWW5I?=
 =?utf-8?B?cGdFdHVwczZTdWRwOUV0elpKWE1hbnpybmtwUkNYVkhNZlBOT2dJYU9COWk0?=
 =?utf-8?B?SHQ1Z01aWElXcFVTZHpURGRmWUVSYjZ3U1hCNVdBMkNncHN4Y1dpT0hwTzBJ?=
 =?utf-8?B?Y3Q3QldrZkVsZTNYSkF2NTlrUGJBNzlGL1V2c3A4VUo5MUR6MUpvM1FFRWRn?=
 =?utf-8?B?aXBZK21MQlZ5MUs4YldISzhYM1dQTEJLbkw4RXQ3YWxyNktvY24yNTJMb3I5?=
 =?utf-8?B?bUdpNHlWTnF0TVpyNjZ5cXJyRHNYbHhtY1lnSmNKeVdPOGZKYW9EY1VEb3pU?=
 =?utf-8?B?QmpCV0dESy9NT2tBSEpieDZraFBBdVpSLytBVGdjNk51QzJieGdFckNESjUz?=
 =?utf-8?B?dUtlYXlBTlBud0lRb0kwY2hTNjg1MnF1MVVtYU0xM1dFZ0lSZEpGVm53MVFO?=
 =?utf-8?B?bjFKbE9jUHltZmhJeFNSMWo5by9QcGo2QWNSeEN4RGpQOGsvaVZEdmRwQXNR?=
 =?utf-8?B?WjJTc3hJaDhmZTV1a3ByNDN5enhlbDdQaXBQOUVMcHdWNFRPMmxPVU1zVTZh?=
 =?utf-8?B?ZmlBRzQ0MU1PWm93M2NGODc0WWZ4bmR2SG9VY0p0d3RiR0FqbzRGQ1J3Uzhu?=
 =?utf-8?B?VXFUZk91VTYwZEZoeXhQRmpVN2N2TlNjN1RrT0dSaWFISk5pdUxPUDRRS0xa?=
 =?utf-8?B?TUpQQkU0VTA2S29KUlRqV3ZyYS9Rb2UwdTF6SXZXVFZwRFdheWFEWExxblhR?=
 =?utf-8?B?YXc2eExoRDBJMmNhNWNKQmxtY0xvYXZSOWRaY0Y0OERaMEhnMUVBTDhZMDZV?=
 =?utf-8?B?TnlmZ1VGSWxSY25WSW41ckJmOE92VGJKaUlIMG5rbThZVjNlRkh5b250TC8y?=
 =?utf-8?B?d2d0N3dycm8vSDRhSjFBK2VLMXMvdmpuNTBTMjltKzEvei8wWGJhdy9KQkxR?=
 =?utf-8?B?RHVOWjNJVWdZWVBEcGhsQlFUYjlBeHdUb3d0RW54T3VmSk1yVFhrdTczcUky?=
 =?utf-8?Q?dLhKx52n/Hun8yo88eLez+VoU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c87c32-0d60-4acb-a8c3-08dcc655ccf1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 05:04:59.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sRUWTLLa0mR5fW0Wts6ICA0k+D3N3pj1BTGCZ5t9o3vMb7XLC6nVahwm5INQ8U46HUMElI1g3oA1QwK+anE5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
X-OriginatorOrg: intel.com

gentle ping

On 8/13/2024 7:05 PM, Yanfei Xu wrote:
> The first and third patch are intended to fix potential issues regarding to
> retrieve and record DVSEC ranges. The second and fourth are cleanup.
> 
> v2->v3:
> - improved the commit message of patch1 to indicate potential impact of
>    the change.  (Dan)
> - Dropped un-appropriate "Fixes" tag. (Dan)
> - Dropped the patch2 which is a code movement in original patchset.
> - Separated the original patch3 into cleanup one and logic change one which
>    are corresponding to patch2 and patch3 in current patchset. (Dan)
> 
> v2:https://lore.kernel.org/linux-cxl/20240809093442.646545-1-yanfei.xu@intel.com/T/#t
> 
> Yanfei Xu (4):
>    cxl/pci: Fix to record only non-zero ranges
>    cxl/pci: Remove duplicated implementation of waiting for
>      memory_info_valid
>    cxl/pci: Check Mem_info_valid bit for each applicable DVSEC
>    cxl/pci: simplify the check of mem_enabled in cxl_hdm_decode_init()
> 
>   drivers/cxl/core/pci.c        | 74 +++++++++--------------------------
>   drivers/cxl/cxl.h             |  2 +-
>   drivers/cxl/port.c            |  2 +-
>   tools/testing/cxl/test/mock.c |  4 +-
>   4 files changed, 23 insertions(+), 59 deletions(-)
> 
