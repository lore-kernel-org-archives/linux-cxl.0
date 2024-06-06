Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F1182BD
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641341; cv=fail; b=EiOz9mmbC4rxqt65a8HPPmaoyKCRI2OS1+zrT5gxJh82U7MFzESa3dO2nCuw+S2/EY9h1B3KZNTmodn9h1sb59B/d/PAuqyv8YQLNVUwGCyN7KUqW4L330ChzFdcIgSJ2X4TRmFqYNF52dnMeQ6Ozstr1ZbL/RTn4QBuVEVqoUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641341; c=relaxed/simple;
	bh=kjmoim1eH7+HdhmxbdYbByDNu33++M6WY11q4xIONz4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cGyoTsrdvFnDDioq0VpI6s3DNh7KHfQorokb2q1q9RN49ZDKLehveEIVEYtT6ozZM0mBPcoTmP2n2EklnrYhO7zkV9bqrs3EGdX4xtl1FWlpdqXLR4goAAmYfaIHjJsqrGwft5jPfCnJCKbKXjVPlpyKiI9W9rR1dDeTyeaQfTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRRXRfCy; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRRXRfCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717641340; x=1749177340;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kjmoim1eH7+HdhmxbdYbByDNu33++M6WY11q4xIONz4=;
  b=jRRXRfCyIykMxQGzXm16RZMrUfP22/Ho1Vax3n25D4K0pmYODQ9O2jYd
   Hy0n5J4KAKRQy524eewH5Z3ioTWaLyHGXn3W+3XEtli/s/NisRQYPh5Qp
   wy1AYuGL/WorDairUfJUcifmxP129pZEimJMp5Da8Yn+odeak9ETdNwYV
   /CqwnP78geCvZMF0n0WVl/YQfhkP6REXOUN1JiJJMhWalB2uXdCSEC9k2
   5UqGUmSI0sGKSKs8NrRE/HqUj/PAjZV/3psb2UtLQfpp69c1pzvTuuYBb
   RM9kpcGU/APZc4Rzcn1qX0wKWQwK0C8eiJiOwgZTiEda7qCzEnfmnjV50
   Q==;
X-CSE-ConnectionGUID: 5U6Pox16SQCDx7R/1jtHCg==
X-CSE-MsgGUID: rRWAkN1hS7eKWfdgtpEshA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24944272"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="24944272"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 19:35:14 -0700
X-CSE-ConnectionGUID: pMPjKBdFRa+3enk8VdW7Dg==
X-CSE-MsgGUID: j8+aYi+RSvCwhbkNAWgeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="37683862"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 19:35:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 19:35:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 19:35:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 19:35:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhtqKfw9hxmPVqi4CJhXXHofb/Bv6UE55+6DqNNw+eMrX+tw9fHpSlm1AZYuMiKitOZBorhtwmwHBT3jwqWoigkDd1MF+J5mcivYztLWvuczPmzyNU93OoghAwYxWX87WPokhfnjlKeeDNMsxMWhHWTgxhQA4IdfNgK4GZ3WvcM82zW9k2IO1Z8vkJmUTBCiElV0mZLbg+44ddfAsRB57es/UUs2rlYICiAKoihfcqyys7bEOMXzaefFPhDwyROpM+YobZdNXeGnzW8lzXBGM9IpZW+ygYPiv22YSpw4YViaKKJG0dVC4BaJafwunGxuTSJTAmz0cVc8OcniiBLhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0mIBnWp90pPFOZDuHAigyxOxXWdl1UimJ8dBGR3BRY=;
 b=YmTC3pKswQpmmPhjI08k7mAQvocsrdNS8Kf48nDwobBb/2ZD3GQs3o3BAtN76Dz6HyKdGlzi3IQyBp35MhPNfJY4wCMf1wcJULSejtHsuVvJXroAHdSORuthnUtD3GQHdffTxeEiV7t9h00dbXsHUdsxPqgMmd9wZA7IHjNQie7U3N6Y8cyMzFTwh9b6V5bMTYRj04J0TomXrRP7DfB75+vB+57IjZMCnveda2cKbdE+CSm2ipI/Kn2Wgi/Yqdz8V09rT8F/ZAG/B/B5MUyA8e2Tw437CBYLnl4vGQOJDGi76IMgT5UpK1bowx46n64yLov440a0rggSL6j35lAYxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by PH7PR11MB7099.namprd11.prod.outlook.com (2603:10b6:510:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 6 Jun
 2024 02:35:11 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%3]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 02:35:11 +0000
Message-ID: <5cf7bb37-dd48-4544-82f6-d36c8a9d46db@intel.com>
Date: Thu, 6 Jun 2024 10:35:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/mem: Fix no cxl_nvd during pmem region
 auto-assembing
To: Alison Schofield <alison.schofield@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
References: <20240531070229.1596811-1-ming4.li@intel.com>
 <ZmCHfFJXtpx3NZW5@aschofie-mobl2>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <ZmCHfFJXtpx3NZW5@aschofie-mobl2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|PH7PR11MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 772ed4a3-0fe1-4216-7349-08dc85d14971
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckRwOEJjc0FYd1VBZncxTlp2bm5oOXlDWlNKR01Ed2VGdHJWTkY3SFk0UnFQ?=
 =?utf-8?B?aVNWQlBnZ2FObmY3Z1pLSzNVUnVyZkw4aWd3VVg0MTU1dncyVjBpbW1vRFVV?=
 =?utf-8?B?SUx2UlJVMnNRU0JHMnN2WFl6VU9lQ2hZWUhFTXVDTUdldXNuVVpwYzNEMzI3?=
 =?utf-8?B?a1pJYUV4bVpFQ0dCQkE3SmQwRy9XUE1WclZqMjdxUjk0RU9SeDhTT1hkZThR?=
 =?utf-8?B?azlnRzFJc0MxQTF0TDJOaW5rTnpjbER3VjRvbVJMY1VFa2thSXBndVhsYzBC?=
 =?utf-8?B?TDRuMC9mR2dGS1NicllVSW44OCtUajdha2tFNXRGa3ZIeUZ4NGpIOGRUaDM5?=
 =?utf-8?B?OTIwcW55bC84eHNMdlJXYS8rVU5LZW9aVmk5eFNjVld5aXdhejViYmVYa3lD?=
 =?utf-8?B?Z1l4K2g5Q3ZndmlwMHozL0xIYm91YUd2aUpNeGlqRnZjM3BkWEdRUmV4WThY?=
 =?utf-8?B?MDluWWt4YWM2MXprYzg0ZkJ3RFIwdjdpK2RuSTd3NVoyTlJ6R2k5UWZSanpZ?=
 =?utf-8?B?dCtnc0FjZlhrYWhFd1FGTmNrL2d0OGlrbUhyeldRNkM4YlRBb2l4RGFsS3ht?=
 =?utf-8?B?aWQzKzVNYjl3em5HTzd5dC9Na0Q5OU8xZlllcmRwYUIvWHpaWWFzZEJRc1Vj?=
 =?utf-8?B?MFNhbSsvOVNFYThQeTNJLzhudVR1ejhiNDFaMFhhT2tkRWlOL1BBUXpZVldr?=
 =?utf-8?B?YUtPMzRpSmU2cWlHWGk0cm9PSk5rUTVPdnRzTEpDNVdWeGVUY21LYjdBVUk4?=
 =?utf-8?B?NGloL0VqTE9hWjY3T3FYV05GMWVsQUFHZE94c3kwNS93VnpmTGJxZE8rV2Iz?=
 =?utf-8?B?VXp1M2QvNVNsT2oxK05NUWV0RERhK2d2UTVqbnlMMkRxNkhEaUV4NHNPbkRp?=
 =?utf-8?B?YzRjUXZhaGtjYnFuUnNValZLU3JWaTc0RFh3U0dHZEk5WEZVVUFwd3FFdmF5?=
 =?utf-8?B?dXVoWk96TFQwK0dWblliK3M2M2dtUnFCK1VqZXdTQTIrdWJXRm9lN3JjcXky?=
 =?utf-8?B?MWhtY1FlTTgzcnBodzF3cVNpNTJQRWU1QlF6UkFhbkNWemhPcUdNYXk4UWh2?=
 =?utf-8?B?b2NIeTFRUEcwQTJBV0hmT2xsTDMrR2UxVXk3N1gxU2ZmVzZYNVpjMmJsblNx?=
 =?utf-8?B?RkpKdkltTWN5NUl1anlEZVRNdEtZa21qUFlMTHBKSzdXL1F4bTBiVENpYUxa?=
 =?utf-8?B?S1E2ajhtbzNiRXJwcUdoeDBuR2MweXgrbTJIbW5sRGR5OFhqTVZTaU1jYVpU?=
 =?utf-8?B?NytSb0s1SjNtQW5lc0ZON3RkejRjN05TaUNhbCs2c0hpREVQU3NpWE54MUhX?=
 =?utf-8?B?Qld5RlFMRUpkTGFwUnZCWmp0VnJUZzFjUHFwVmpMUVpuZVpiWHVIWE1zWG01?=
 =?utf-8?B?OXhIdmthQmRvUG94OUhpQW5zbFYrQ3I1eFp3dEM5cDB0K3NaM3ZuWUtMZ2dy?=
 =?utf-8?B?SkVjVVZsV1QrYytERTJBc2gvWlZrMTFFR2g5WkpCcnAxZTAvUGlRbi8weHpT?=
 =?utf-8?B?QU9uZUNPeGdDVFYrVUo2enV6RGZrVzkvZ3FROWNyTHZ3cWkyTmtISHYwaS9D?=
 =?utf-8?B?R0FTVDJXYjBUSnU4eENZRXlqYnFmN3R2UjdmSjZLc3hhWjh0cTkrcGRmSEsz?=
 =?utf-8?B?YUEzWkNCTGV1NXRteTRBYnQvZlZXMjlRTGhuY3ZkNDVyeTZ0VEZ2eWtXUGcx?=
 =?utf-8?B?UUNiY3QwZXdESThiL0hZS0p6eEtFRFFGNkhvZlJhbHB6L21WODFOdktRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUpuVWwrcnNqNkdOUmVaTFFhamtqUlRMUU40cHNxMm1hc2RsRDQwOExMbnk4?=
 =?utf-8?B?YTJzeFNoODdjbTJ6ZWh3T0ZZVTJ2alRWYTNCbWhTOU9Va1BaZE4wMkgxT1pn?=
 =?utf-8?B?b0szUHlVcUpLM0VxbmtQUFpPeHRRb1JKbVY4Q3Z2U3F6U0VnV0lFTzJMMEg4?=
 =?utf-8?B?WUdjUWEvbmFkOHExVXM2cG13ak9VS0phK1dtb1l0K2tyL0lYdmpRV3Rnak8z?=
 =?utf-8?B?OXdNb1hYV05BTjhyMzc3YWwrR1lKZjNYN2xPd3VwSTVvMlBQakNPK3ZVcUhI?=
 =?utf-8?B?OTdJQ1RRdUdmYTdSU3NmTUlOTXpPY3YyZDlCMmxPdEYyNGZKYTdnNTd4cGQz?=
 =?utf-8?B?clJUOEdJd1RWbGdLYnRQMmVqTkZjNTFYTlV5VWM5d0JpRHpBSGp0SmZnOG5E?=
 =?utf-8?B?alhpUEhJU1ZPOHpuVlM3ZGY5dVMvdEVCQmdYZ2l1eGxOVTBkemRPaGNiUVU4?=
 =?utf-8?B?dUFXbVpuT0dSaGgyTFd4N0YzMG03RkpTTTMzY2x4T2QxSFNQMmhLb3UxOG9k?=
 =?utf-8?B?ekdkSDhCYWlSY0R0ckZPU1ljZ3Z1bERmRHAxYkh4OSt1TTZGWjR5Mm8yd0M5?=
 =?utf-8?B?R1VzUG1OcTA3eldhNGpkaXNROHpXK3BUREdkcDIwaWJTQ2F6OHRselFpTWdZ?=
 =?utf-8?B?dUQvUFUxOHhuV3FzOU5BNDQxN1ZLYlRsNTJFZlVzc2Q1VEZEcWZFTnJsRTd2?=
 =?utf-8?B?TUVJcUU0WkpUTE93WjFlZGJ2Rm1qQzZYdGlBQzZqWHZSM2tpazJ3OUlzV0Vy?=
 =?utf-8?B?dTdyczdicHNNY01rMVVkSXhnMzRRVFVnTjFGRzU1cTJ3bXpTUVRmcjg1TVFi?=
 =?utf-8?B?UktmOFpPL0dwdGxObGpPN3FFY1ZCN1JwZTJGUGc1bUxVY3dHMnc1bW1mUDZ1?=
 =?utf-8?B?NlRkTzJ3UmxGbHVVMktWU0xuYnliOTlPQWdjTkZPamRxcVQ3TzhMRFdBd0xl?=
 =?utf-8?B?NE5yWFExaEl4eCtYWm9OUDNJTTRRZnlsVHFJakQ3NFMrcGlzMTNmK0thL0ZN?=
 =?utf-8?B?eVpsTE5rbkRZL2ZiV28vUGRJZjV5SkNLVXRGUVM3cEF3aDBZSDgybUNOSmZh?=
 =?utf-8?B?RUd6blF6R1JNdDFZQjFKTXZCSHBTNllNZ3NIellYbDRkMERGSmhhZkRnUU4w?=
 =?utf-8?B?c255US8wRHN1MUxtQmJZVU9vQXNGRjZwSTBiOVlPYlJMYTNnc1NSZGVoWUl4?=
 =?utf-8?B?VE85ekQvM3FFckpubXBtYmN0dEJTN2wxWVUyMythR2pyZjNCaVJ2R29kZncz?=
 =?utf-8?B?aVVoaXFvYWNhQUVoSGgvVkxTV1hwQXlMSGhwMXVndEczdGlBU0tFYmRybzdL?=
 =?utf-8?B?cmxHb2luK25FV0JrNDVJaXJtYXU5bmwyaVFCTTdiSzhxRWVrNmlRQ1J1alRJ?=
 =?utf-8?B?a0RxZkpyVmlEdnhlck5ORmQwa0MzSm9IZ1oreGJUa1ZoVzFkSHZQRkExSFU2?=
 =?utf-8?B?dElqdjQvUTlSd3J3aG9WWXlZb0swZnAwemFEYkk1N0x6VkpzcWJVOTJhcjY0?=
 =?utf-8?B?elkxdUc2ZUhmdStPUFlOcXpSMlFBUUtMTDgzbUN0MjYyU0tYSmlqSHhzWE9k?=
 =?utf-8?B?ZWoyUTdzWWdCMXo5cEFxUEozRDVtd1ZHeDBZRXZwVzhWbVN2dlI3bnIvR3Bz?=
 =?utf-8?B?eGlrQWwyWE56S3NUa3hqbnRDR1VVVVJBSU5FeWlYYXZJNG1NZjJrZFJtTDVj?=
 =?utf-8?B?UlRycm9yYXBWVjgwcmdHUnlvdzh2MFduRzVia3JnSjlTNVhQNURSTFpnaW9w?=
 =?utf-8?B?SGcvdUFCeUwyTlNvQnJOemthT3VnckJHd3VnbUlOd1c0dldBOWhKMU4zU25G?=
 =?utf-8?B?TEJNYkhzMjNLc0s4SFZSSlpRcWxlalpBVGZIMkdTNkhzZ0R6cXhFM1phMXVZ?=
 =?utf-8?B?L2NFZ2RpMWMyd2dpSHlVZnV0eVFyV0hRTWNuVDNoR3lJRE9IU0xBZVVWUFRt?=
 =?utf-8?B?dG90MTBvaVRJVW05aEw0YUpvOW1aUkgxTFZQa3NzeFIxa0Vwc2I0MWltV05t?=
 =?utf-8?B?UUFEQm15Nk9UelJWR1VraG8ybFlJeWFGWnNTeGZtQjkrY1d3TSsxbjE5bzFF?=
 =?utf-8?B?Y2dleEo4dXZBV2JOajFQZkY0ZnJQMUZ2eGJydENHUG1TK1FJZEcvZCtwUmsz?=
 =?utf-8?Q?57DbKqx8+N+9AoZACeplv8Q9b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 772ed4a3-0fe1-4216-7349-08dc85d14971
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 02:35:10.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkW8qDtBnC+esDbr5c1rleVNvBKSMeFkvP+xix/KCof1dDRecAiFNHHmGmPXguO8KQ5Q4LjiKsvlyEpasOFcxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7099
X-OriginatorOrg: intel.com

On 6/5/2024 11:42 PM, Alison Schofield wrote:
> On Fri, May 31, 2024 at 03:02:29PM +0800, Li Ming wrote:
>> When CXL subsystem is auto-assembling a pmem region during cxl
>> endpoint port probing, always output below calltrace.
>>
>>  BUG: kernel NULL pointer dereference, address: 0000000000000078
>>  #PF: supervisor read access in kernel mode
>>  #PF: error_code(0x0000) - not-present page
>>  RIP: 0010:cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>>  Call Trace:
>>   <TASK>
>>   ? __die+0x24/0x70
>>   ? page_fault_oops+0x82/0x160
>>   ? do_user_addr_fault+0x65/0x6b0
>>   ? exc_page_fault+0x7d/0x170
>>   ? asm_exc_page_fault+0x26/0x30
>>   ? cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>>   ? cxl_pmem_region_probe+0x1ac/0x360 [cxl_pmem]
>>   cxl_bus_probe+0x1b/0x60 [cxl_core]
>>   really_probe+0x173/0x410
>>   ? __pfx___device_attach_driver+0x10/0x10
>>   __driver_probe_device+0x80/0x170
>>   driver_probe_device+0x1e/0x90
>>   __device_attach_driver+0x90/0x120
>>   bus_for_each_drv+0x84/0xe0
>>   __device_attach+0xbc/0x1f0
>>   bus_probe_device+0x90/0xa0
>>   device_add+0x51c/0x710
>>   devm_cxl_add_pmem_region+0x1b5/0x380 [cxl_core]
>>   cxl_bus_probe+0x1b/0x60 [cxl_core]
>>
>> Because the cxl_nvd of the memdev is necessary during pmem region
>> probing, but the cxl_nvd can be registered only after endpoint port
>> probing done, that is a collision dependency, so adjust the sequence
>> between cxl_nvd registration and endpoint port registration to guarantee
>> there is a cxl_nvd in memdev during the pmem region auto-assembling.
>>
>> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
> 
> 
> I have a WIP cxl unit test for this case - auto assembly of pmem
> regions. It's far enough along that I'll offer the tested by tag,
> but not far enough along to post for upstream review.
> 
> Tested-by: Alison Schofield <alison.schofield@intel.com>

Hi Alison,

Thanks for your test.

> 
>> ---
>>
>>

