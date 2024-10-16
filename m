Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34D1534E6;
	Wed, 16 Oct 2024 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729119749; cv=fail; b=ORHA0knjeDKOZ+rwUmhvdHM/GaABXb6jlOXj9+ixeEOZOKaksRghQxzARVOJyWHaMYign0RuRBHCJncDrJbdKRi765Ha5xl68gJ1rz0uAuzgQo8o0I9lBDUlHexAjNjRqIoAcV7TzaoGiKAAFetk6AZsZW+B+OXzvM8MoG0f9Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729119749; c=relaxed/simple;
	bh=n8YLeRX6HczjvtlhcQTvRVHnhzNiaG4LZ+d/5WkTuYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cl/ttSA05dMpk9M1CAkkBiFgvMmj9KYdexeh/TlSYPlXcudx5svLPRrPTLf3L2U2XQTdToj69k+COXR9w5hT5RQefxc1Y3Zujv6g4bNBEzlDIOUdJAgB7AFU6R8sl7wjD5p36vhn6fruhJR+l2wVKdHPjga9g4cvL6lx+ltTflI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8g4yA3n; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8g4yA3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729119748; x=1760655748;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=n8YLeRX6HczjvtlhcQTvRVHnhzNiaG4LZ+d/5WkTuYg=;
  b=b8g4yA3n6e9nXMXTzChO7weF9VvYjiLeqsVGpeb/BP5gWba1R55im/S7
   9ux0KHOycsbXJJFZMB0env82jxiMnjxcI+TKwB3GUozxDYHGFSe8u85mA
   nBkxyXVOiHmYzXlZF++ztadxBJygTWDjwH2r7KemavmY9755BIAgoSdmq
   Waj7h65WwkcP3BDFLqiAzq2lC3uXYtmbPnX4yrFAhj6ARTz2a1vXI+Hx/
   bsZjpkTC/uKruus0WmOUWYSvl3VWBo0tXy5RrbH6KFa40vnhWN2ScvUq6
   6Y8ZiOeTSkez+Ugf4VqxOkXHHE6Wj7yQHkVNZ92YNQ+ndqcoIgeXPbPNS
   A==;
X-CSE-ConnectionGUID: QpAPyQ8GTDGMebgojYSeeg==
X-CSE-MsgGUID: 0t1K+T9xSviixpkiKig89A==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="31455397"
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="31455397"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 16:02:27 -0700
X-CSE-ConnectionGUID: 91C/3xfPQh6hq+bap/Ar2Q==
X-CSE-MsgGUID: wDWW69BxRC671rVJ33BFjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="83136664"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 16:02:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 16:02:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 16:02:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 16:02:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmPBriLis/Ue8M9fG404a25PbobOpdhqQ0Ub6OfH1C9PfY51vL8ldfaUK9RuWvUaLtY5C21YlV/+BDDZydUMfeeJc+0wdV9Y9zByWo1zHkCC9KnrL+NNTristn59lFMGndnbixrwKHxAufNOS07uP1YnoS0x1RZLp31sKTsH/YAMT5hm5W3d57vjmPdLhohBWgo88k1V/EoiXRsipzdZS7t2xuhwDQASdxT/wrw0Cgcco/xLq0LRqKw+q2+SyZ1mlRNbItsb/o3zBiJW3umzjqRuTT+7Y4MRJhJrZqOYr1hDcZTfc38BVdMP3FGDV1kXxDOBE/re57x2EMLoq2JltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpUcbhVCyE/w2GrdRA4XFxP6mKF4dCdBkAX6sHwbiv8=;
 b=tbD47ydjKnEyyVyI39g6kWFCJ01wvIMlF2ah0//vLxQoPneTfOM2bOqBE94CMf/2U1fdOYZeuT4/HOOwizyBBna0F/hbjUZyO1q0uTX9817vGcn/IT55Q8MmqZiKX8l89ZpGCvn2MmviKtx1kkkrV2DHJMNhEDiJ1lkGuD98FcHQ+BERGZp6ka6zb2+k4ba134gtGK5DHDxnPFZxnQy3+N0hEVZFOlE3sabF561noZ7weVfvOv+grFVs533BFmHFP+gNxf2Ef2AXWixyWG0wJCUfLlIxj13mE/TtWCOrKUXGvJJXf1vtJTXPPfVjjm0m0HXNCZoABL8YdZXkHzqlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6160.namprd11.prod.outlook.com (2603:10b6:208:3c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 23:02:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 23:02:22 +0000
Date: Wed, 16 Oct 2024 16:02:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Zijun Hu
	<zijun_hu@icloud.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v6] cxl/region: Fix wrong logic for finding a free switch
 cxl decoder
Message-ID: <671045fc36835_3ee2294a5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241017-const_dfc_prepare-v6-1-fc842264a1cc@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017-const_dfc_prepare-v6-1-fc842264a1cc@quicinc.com>
X-ClientProxiedBy: MW2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:907:1::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: dadfdcdb-0016-4565-3e38-08dcee369814
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjVaRldHaWFhaERnejhpR1hRT3R5bXB5dVVMVnA2SVdEMU1zTGFKQ2VUK2gw?=
 =?utf-8?B?N2JYR2RBRHprNFFnVkp5b3NyaC9FRm1pNHBOanBkRTIvUVRQMVgrS0kyM1hH?=
 =?utf-8?B?aHdoSHlUTGlnL09FMEVxekd4VTRIek83ZVhIM1FlMFhBemxraVBuWmt2N3RU?=
 =?utf-8?B?NGJSaTcwcUN2bDZhVmcyYXJFSUs3clU1UDdjSm9uN1FrdW4zZll3eWZNNEZF?=
 =?utf-8?B?YXdnZVI1N3o4NmVaN2RqZVdsNTBQZnJlUXYwcTRUT0N0dlZZZmt1enp5Smtw?=
 =?utf-8?B?YjllSHhaSWsySDE2c1h5WTU5MXY0VVVvd1ZhTXV5cHZqUS9JdXdRZUJCNTgx?=
 =?utf-8?B?MWQ0c0xHd0FIWkEvR3BXd2dGOVN3T1I4a1JLN1VGSzZKZmFuQk5TWkQrcFo2?=
 =?utf-8?B?U1dBZE1ZSFZZbi9VWTdjWmVhWEpNcnlYNXVWc3JtWERmV0loRzdFUGRRZ2ww?=
 =?utf-8?B?VGRaZDcyL1ZodWprMUxFU2psU04xRFY0ZkFEa3hUSmIyQWxwc0UyN2wrdVRn?=
 =?utf-8?B?ODlmYUV5azA1dTFxSzRjYy9tUXdIa2QzenZKYVBiVmN5NWRVWDdMdE5YeEF3?=
 =?utf-8?B?U2R2RVJITXc2ODJjbEFzMXBwRUQwZklXd0Izd0IzTjMrdWlydml2Q1U0ZU5W?=
 =?utf-8?B?MVcrYzZuSWhMYk5YVmVFV2NnN0p4eGNQWERlUE9WZGNMTDF4TytQR0I5MGZ3?=
 =?utf-8?B?cVk4L0NpdUpqa0R4R3J0RmRSVHZjbmV6QnAvVkdBMUdaWnppajczZ3FmTG50?=
 =?utf-8?B?Q0xGUFhLNnJxZm5icFpjUkVtWTVsRjEwS29TWmxTUGtqNFFxZ3RZclEzRXlx?=
 =?utf-8?B?bTBQcjJUMFF5bUlIRmhFbCtTc3dUU1VzakF6aktESEhDRkl1VlAzNjhNSjNt?=
 =?utf-8?B?YVBpTkwxdlBEbjZGVkhTZVVmZnI5alNaQkltSWY1TTBvdWZUZVJobHpwRVY3?=
 =?utf-8?B?b1MyQVJhTy9jWThKOWpVODE3OFp5VVZka3h3eStkTk50OGJnOHoranB1SGxm?=
 =?utf-8?B?dEQ1RWNKano0V20zVDh6dVdUNDhGT1ZVVjRKb2V6RWFZdG5qR1NHV3VsY1Jv?=
 =?utf-8?B?NUxUL0hLL2NySnVKMjRZSFN4Z3ZNdHBKT3REVGluZklEYThKNVZaeERPbHdP?=
 =?utf-8?B?Y2lSMHhBVzU0SXUva2NNNWdkR3cwclJ5ano0cXVQSS9rOHVCRGRRaTFKUmhz?=
 =?utf-8?B?RkxiN09mTHZneTdOOEtXYlpYdkNEUG1vUkpROHFDaFhsNXJQdGhONTJuODlp?=
 =?utf-8?B?WmE3OWtVUC9MNzFIRmtYTEcvamE3SHNGUGtxdWpyeTlPOGE1NGVMSGNsNFhS?=
 =?utf-8?B?ais0ajVDSDlIRzk3SUlhVEtPa0cxNTJreEMvYnhHN1VMTURpR1Z3MzhXZDZj?=
 =?utf-8?B?OThFdTFGN0p3ZUM0aVJyaFVyK2lHNUpNaW0yRkVSOTZCNCtFUStzeHhUbDh4?=
 =?utf-8?B?a3FvejN2cVhhMHpXZzhzN2JFWUdpUTFtVFRIYU9BZklONlpTTjUvdHREeWFo?=
 =?utf-8?B?MzQzWDlYS05vT3drTzhOVWxvSXVYVjVoZTVWZ00vcmh1TTdmRkwzTXJ3NTNz?=
 =?utf-8?B?WW5Za3ZnKy9VdXo2Skd2ek5GdjFnTk40UjJJT0RKOFpISzZLcHRZc3RqMmFD?=
 =?utf-8?B?MHRpT29FRmZJQXJnUXJCM3RUZ0tia3VnSzJTRVlHUHMrMFRHMTV5VHNlMWxr?=
 =?utf-8?B?VGh3VVZtdUtscW9LeXJBK1B6UHZJSGF1ZWI2Nmh5OGRkSnZiSTlvVTZpdUha?=
 =?utf-8?Q?64Yn17MGN/1UnfkwCJH9dA4LWkBpSimPMWEPP8H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OElZTThPYVUrYWtnNmRWQlJyZXYxblBHVDAwV2FtTTV0NFBWNjIrVjBueS9o?=
 =?utf-8?B?Y2YzTTAvTnIyVkZiMlBlL0VvK3A5V2NtNHYrRWVhekprazRMbE5ZZXpFU3NH?=
 =?utf-8?B?Y3ZxWElBS3dvZmFXNTkwcW1TdmxKOVdIdHZ3akUxbUNLVmtoSXg1YWowRFhq?=
 =?utf-8?B?U05SSzBpb08zVlA4MmlzRXZLYjBDeS94bmpLVVVtQnBhV0tsOXptV21QYlNs?=
 =?utf-8?B?NlpWcS9oaXRkQnBhQzZhSU9BUzBqTXNuZnVrT0dsdFpjajRSZG9FSElvR0VQ?=
 =?utf-8?B?a0F1NmZiRzg0YjBVV1NCT0pBUnEvcEZyVWZkclQvUVQ4b1dtS0JLSHlBRGtw?=
 =?utf-8?B?eEtvWVlmNTU1ZXF4Q0lna3ZKVTNkeXRNa3lWdXZrb0tIc1dETGRQelNSU1BY?=
 =?utf-8?B?VzBoaS9OOHNrNlViQlpuVmlPYjNBM2R5VGdTVFdOdlBYd29ERDA4VkM1YSs4?=
 =?utf-8?B?ZHUwVEN6MHM5S3JEQkt0d1lDTWYycTF4cmRyOXdrM3IvdENGTkdQQ2FIL1VQ?=
 =?utf-8?B?djV4b3NoVTk1OXFOQ3Mvek1MM0FlSXVvRll5aFBhd0VPR3VzcWJBZkE5TnUw?=
 =?utf-8?B?b2VnZnlyaFJvU2tKaWlkUGVxamxVNjZ3VkxkQS9ZUkhMZGh4YXdSVGtRUGxO?=
 =?utf-8?B?WUk0N2hWZE1rSGVvZEk5REdNbE9pRXZaRTVjbFUxUFhUMXZEUnI0ejhlV2VL?=
 =?utf-8?B?Y0c1UjBLM2VYeHdiMjF5bXRKeThkZENNR3R2UkhzeForbHJjbHN4YkRHekJ5?=
 =?utf-8?B?UGxZNWhlYmFEbHgwK0NrZG9USXVJVzR1dXM2T0FTRzFwNmoyUzZiV0J1M0to?=
 =?utf-8?B?ZjZYS3AwUDZCdWVvVXZjQ2NEeTJLb3RlKzZkMW40LzNZK1daTWE2TkpybWM1?=
 =?utf-8?B?SmZocEFrbUxYMFpEQTFBeTdjU1VIcS90Zjg5cU96U1IzaGdsT3B0a1MybUJU?=
 =?utf-8?B?enZxTVMxZFNxUHE0VUVtbWVhWGJhczFsVStnQmVJbmdNem5jb01rVFd2clhj?=
 =?utf-8?B?ZjIxem9rODhQVHVOQkpldDRIWWx6QXVNMHhnbHNva3JnWUFJNFo5T001b3pV?=
 =?utf-8?B?czJJeFVHYUh2WEFsT05FTGZtbldqUi9BSk1hWE5uZUpsRFp6SjJpU0ZDWmNY?=
 =?utf-8?B?bU1vU3RXQk1KSVNLa0d4WnNCWGZMZ1doN05udkZlU3k5YUdlMjViTXlrTW10?=
 =?utf-8?B?MjNZb3JUTjJXQXVqeWtvVEpUZFJoZys5ZVd4ck9OM0hQZnNFRk1xaE5QM3pa?=
 =?utf-8?B?NmhPeDFqaEd0NmhSNDRTWHJ5QWR0dUoyRkphRlpZNFFoL3k5S1pBMlVyNEF3?=
 =?utf-8?B?YUx1U3dHTUhMNGxhWEZKUUxBd3k1QzB2TzVJYVpYUTdRMmpkVVBoVGdZcHJz?=
 =?utf-8?B?UDFmK2lMVmJuYVc3eVNFeUQ5RGpXYUliN2JUVmRMUGJUeUd1WTJuOHlaNW5v?=
 =?utf-8?B?bGEyZHNCRmFrUHFoUThWRmJhZU92Q1VUcjJKOGRiYVNxZzlmL3padVZ4eXY5?=
 =?utf-8?B?L3BsZ0hVbU9yVTdaSlE5aU1ZSHBUVDJFYXNvUmo0STNmT3NkVk5LeTFZaWpm?=
 =?utf-8?B?Nm9vcmlQZ3VMWk0vN2d4MjZBeXNIQWJJZWNvR2dqcnQwSk1yTFFsZWZGbzBs?=
 =?utf-8?B?TytqdXY4dHo4b05vakNLUVdjY1ZIMW04cWZsL3BvcFNUVEcxeWExNm9STzN0?=
 =?utf-8?B?WWt0ZVJRZWU1OFdCbGtLUkU1dDdmUWRwWGNHbHJvK3VVNEpuS3hJWXpSTDNZ?=
 =?utf-8?B?cU1NUWptQ3ZONmQzbkN6bzgzakhjNDhvM0l0a01YY2V6VVphRlNJTlBPZjlF?=
 =?utf-8?B?cXVVR081dG1aSXZPYWRPOGVQc2FMeWlpMjVRbFkwTmNIMU1yN29ZWkJwQ3Bl?=
 =?utf-8?B?NVk2Zy9TZERTVElTOEtWTGRFWHRpNE9IYlFpRjdGUkdremdWRzFJc3YzWHJN?=
 =?utf-8?B?Sit6dWxSYnBrYnRuNStDVDd1SERIUkJ2LzltRnpQd0pBNzIxYWUyRlZZSkxI?=
 =?utf-8?B?emc1VjdrK3NjQ3hrVUw2YTRnQ3lxdFV1ZjVSKy9qM0JSeW1vRzJIMWF5Ulg2?=
 =?utf-8?B?cVZCdEtOajIxNDduTGsyT0tneDdIaDVQNlZxeHdIMTVtbVhxM1ZnVmhYMCtK?=
 =?utf-8?B?YkVkbVVkbUYxMGloZmpyS2dwak02NHZrTjZlaDlJWHEwTHdtU3ZHY2NFeWhL?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dadfdcdb-0016-4565-3e38-08dcee369814
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 23:02:22.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3C1/BrJuC32/Nn1jrZ0S3t3eb4NIeNtycIwt4IFTif0KZuHJ+0cGXwNtmpCDOfuYDef5rKzOLq0hppjrlb0Dn4/YmtSDfK18Rqi6OxUIYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6160
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Provided that all child switch cxl decoders are sorted by ID in ascending
> order, then it is wrong for current match_free_decoder()'s logic to find
> a free cxl decoder as explained below:
> 
> Port
>  ├── cxld A        <---->  region A
>  ├── cxld B        // no region
>  ├── cxld C        <---->  region C
> 
> Current logic will find cxld B as a free one, but cxld B is not true
> free since region C has not been torn down, so current logic is wrong.
> 
> Fixed by verifying if cxl decoder with ID (@port->commit_end + 1) can
> be returned as finding result.
> 
> Link: https://lore.kernel.org/all/670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> This patch is incremental to below patch series with title "cxl: Initialization and shutdown fixes"
> http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com
> 
> This patch is based on Dan's recommendation shown by below link:
> https://lore.kernel.org/all/670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch/

...and Dan and already sent a patch he is happier with here:

http://lore.kernel.org/172895072669.39002.9296583943188706348.stgit@dwillia2-xfh.jf.intel.com
