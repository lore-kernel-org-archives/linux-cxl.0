Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71535282E5
	for <linux-cxl@vger.kernel.org>; Thu, 22 Aug 2024 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290033; cv=fail; b=QIKBlqM5ahnAx6tSk58hkihkXwp+nDEu8gMv7lzKM4tZVtzNJuhb6Nm911Jo/3WTdbJ13trrblp2txJMXrXwExNYnnp6sU64fshIrG4KSrma0zIF1gDzfZgMH/4JO5c770VrtoQch3FluT6mM7G/Tz3ESIF6809sX/TC5VxR9yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290033; c=relaxed/simple;
	bh=bRSC9Q6kTmn+xh8DbjA2CR8i+JgGxVQ02rXQ5jm0ktM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W+Pa3I2qgUpkopCXajX3Oh1oskd4bcXB0QH7fKD99LjrgB3v+pw6ntkAUxi6RYJkoVkGqroADrf0NKKbXCjq4rUYEdca4GTuyw6a271CVydN6elPiojQ5OwZhpKK1GRwwIKpMszn45GDSSDfK63flgPsOLTjBRyETUBwG9DjuX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knTSZ6O7; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knTSZ6O7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724290031; x=1755826031;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bRSC9Q6kTmn+xh8DbjA2CR8i+JgGxVQ02rXQ5jm0ktM=;
  b=knTSZ6O7aeS0MYcbznkKh77eIfnQXN9/l2XT+j0uhS+IkPFVEm9h9CD0
   tQo8FQBqjR6STDAbEWzc2OIqbcaIMEax5g9NNID9d3fcOe+4PPW0DEYZr
   dyZxinuryHaDCYNfpSoSQcugEe70sOn0u11JdYDTgB0wc/wc/luCYsp03
   tai29+3FUXXMzN4LtrmWu9/uKtVxbPkXsgFnAYDFFIzIeesAlWS2TCEnz
   Djef74ZVA3ySFA+QwJ4svsq72kralvPwbEBlv6KH/Q/kAHiLo1At5Y0Sm
   nfGj/KV46CffWVn1vC32OptjQFiDC3TPIpFKroqZB3PI3fXzmiCO84DRs
   w==;
X-CSE-ConnectionGUID: 6dvTc9cnRialrCcAkf0/iw==
X-CSE-MsgGUID: CAgAYV1nTEiiL6DstlWbEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22207821"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22207821"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:27:11 -0700
X-CSE-ConnectionGUID: OcvPftf8Tf6WmOn4Z6LXdA==
X-CSE-MsgGUID: NDxtmH8QR2a5Z/CG50GRqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="65970646"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 18:27:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 18:27:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 18:27:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 18:27:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 18:27:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZbPwh1+VuXjFN+8JCfsUXklq5pQ3JkgtD4V0PTogICPaat3ORdws1El5AflnQsl6H7ouT8XLpTiO94AQWkWu14h7BojzFBBB4oFLilWSJG8g0MFU3JLCZrjaRLs532A7o3LmUkt72ayzsFbmUyHwa2N+T32RhK5oUH7bcTwzYhiGpDFzmZh4rGMs2HFZemF7LTM0vwMKY7qnBXpy8dxQaF0qsU+qiKBnU0853AqKoZx7hXUbnQfd8m6oSEi25g8Uuw92ybV6sZfPM+RfYjsM4ZnXwytew9J3By8XTbZ+waA18pfFQB3zb4wPWFMmy49OEc5nkI27Gzj2VBMAtiFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMyImzTcPjJ3Bjwn3J/GAwZ531aPQeHt0nDFTYCzJv0=;
 b=DMZ4X2oTmPr6eVPAczIPycnDQWFIhomEtG41mpWxvTYqF03Kzcqnxrol9JV33kawi0nkmJ03p+fxRrsdWVhbXd5uveVbRPQQm48kyumbEmbYXIWZU2tYESqsGIBElxtwY08wLw0/T5KNXf2bmhHEC9Ik0OXofY8ga5vfgfeT18ZpeoobaQgQc800DTlQwv9N+fOIUJfuV0s+mt4+CXc0SmE/sM7Kzc6ivYIB9io0hBDOIgdyNwp7cANoSDX16AedQ+NXdTdNEkjpTxdnZ6KCaDo/Pxsx9vHh+irhqAIY0w/a+kPUbzumFjpVDFraE6a9fBd1MZdDEH1dhGZAw/2ZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by MN2PR11MB4741.namprd11.prod.outlook.com (2603:10b6:208:26a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 01:27:02 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 01:27:02 +0000
Message-ID: <8ac82c61-7871-4914-b376-32431868622c@intel.com>
Date: Thu, 22 Aug 2024 09:26:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cxl/port: Use __free() to drop put_device() for
 cxl_port
To: Ira Weiny <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
References: <20240813070552.3353530-1-ming4.li@intel.com>
 <66c65e2917d00_1719d294ed@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <66c65e2917d00_1719d294ed@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|MN2PR11MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: d30524c0-4670-402a-c1d6-08dcc2498629
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M213WlJVeW1yVWJTaEZEbTFsZ00zRjlTMkRjd1piNGd5TFV3ZDNQdjh3VGNI?=
 =?utf-8?B?d0hiYUN4d3FKMUl3QlAvU0U3Q1U3UnpsQmFzaUJQaHlRbHgwU1pNY1ExL2Ix?=
 =?utf-8?B?eUc2TzE2c1ZkQmh1QkQxVlRvWWs3OTJqQjBPUmpWRHRUQzRHR3BqeWhhTHV2?=
 =?utf-8?B?cXc2YlN4WXl4dlQ2dlNyWFU0NW1MYmdGQ1h2Y0lGa2NKTERHMWdYT3NhTWRl?=
 =?utf-8?B?eHFIbnZHckU3VWNFeTVVL0p6SUhLc1dEak9VNFpoN3FnODVoQ1NLazZoTkV6?=
 =?utf-8?B?dGtkZ0ZXZ21pR2h6R0xwd054dzhlTWdsbkF2SVRCVzJ6Qk01NUxROVVIdnU4?=
 =?utf-8?B?VjkxRzkrNyt3SzVnSkxiTkVwT3IyY0U3eFA1dmVPUVB5NFdZSGloNnBsdmY0?=
 =?utf-8?B?NWFvMU5GZUpUbTFobEhTS1BNL0lUNi9hRkZxYUU4bFdFMWxnK256OVo1NTVM?=
 =?utf-8?B?MTJtZDF1TEp1WkRpYkhKOTJKcG5TdjV6RTZmNkx0blhsNHlvZGdhdjRrUEcx?=
 =?utf-8?B?VG5JeDFoZjRFREJwTGRmOThjZnNkek9uWTZrcTl2UDlvc1M5a0NmTFd4bkR3?=
 =?utf-8?B?Vk1OaWVrd1laTDFTRlNLcFNHTXhOT2xSampRZmhUbjhYaFlJN0ozQWpJRHVq?=
 =?utf-8?B?OWF6YnVRU2xYQ1VCT3RmbUJYMlZ4YWhqRTFNeXJxd1NGM1lBcC9nTXFHYkxI?=
 =?utf-8?B?UTR6SFVDQXVYZ3FQUE5XWDBENkJ1YTgzSUZKaDZTZGJJNE5HOFlSYUpyZnNq?=
 =?utf-8?B?dEcvYmtSZU9DMnIzaDV2N1ZIOHRUclVGMnJDcUdyVno5TmlIZ0dxTC8xZkRu?=
 =?utf-8?B?dWYrUzFYOERVd2FnMDF1dERpYTJrQW56TlZqMXQ4eFhwVU1hRTFHRC95Z1NZ?=
 =?utf-8?B?dktJNUxxWXJleVVEVWtiMXNBOERrQTdRMi9DNndLTHhiSk93djc4Q0EwQTZV?=
 =?utf-8?B?YU9NVldpRG5VL0UwZFdMbmFmQTZ5a3NqekUvL3RSZmtCMldlVW03UVlJMk5i?=
 =?utf-8?B?V1M1R29DemRqTExuM0wweW9aTkYzTDhReTNGSUpPYVRPem93ek5Kc1Rwa0dH?=
 =?utf-8?B?WFFEOVpJb1FlNHV2bUpQOW5UQ1Zhb2FmN1hMeUEyVDBDUGczMTF6VWxTWWZo?=
 =?utf-8?B?cU5oTXkxdWJYWjdVQUVId1N0MmJOV01OREROa2hmMU9JcXA2c1ZGeGN5QklX?=
 =?utf-8?B?dHR6SnRaQlBKelJWY2M0bFhyM3FaYmMvWnR4dHljbmFGcTRpQ3pqWENyTVVx?=
 =?utf-8?B?ZUVuaE9TUWR3c2tvZTZ4TFBwRk9ORUhVSXQwK1R1ajB1RXN0a0ltV0Mzd3U3?=
 =?utf-8?B?KzArZFplakkvWFBxUHAzWGRqODk2ekNxUnluT3FWK2krL0hLRXNvTm1FQjY1?=
 =?utf-8?B?ODU1a05zWjh2aytYWVltM01zL0U1aVdpN0d3eGk0czBHcUJzU010UHRCLzZs?=
 =?utf-8?B?bnFRUGxpMUJDdyt6MWZzR3h1TWdjbGhYK2RKVnBCL3N3NDBIZWoxYmFibW1w?=
 =?utf-8?B?dGhCWG5TM3lYRlphT3Z2dWhUelc0NDRRZzdiNjMxNndRUnpaY0J5a1h2dTNM?=
 =?utf-8?B?N0Z6cGJOeWFkNWNnRWFTbXduS3liR1FpZkNoaEJxMkxuOFgzNzlOMGh2eDFl?=
 =?utf-8?B?YUtVQnh1bzhjckh2dUpNOHRPZVgwZUxkM0xneVlGZSt0a0RYOUpCeVFVaGpX?=
 =?utf-8?B?ckZBNlVpUmpDMG10VTY0di91YW03S05jeWd3WkVlbGtjUUZyUDlXNENRaitD?=
 =?utf-8?B?b1ZtbjVOTThRYThOT0pJV05URDFGMWpyK08yVXE4dTlCbDhjdE1YMjRSb2hS?=
 =?utf-8?B?b3VDQVpQVGdqdnR6QnBqZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0ZJaGJwT1Z1R2ZPZ1dhVkE4c1JsRlNtMkdCUjlsTDdTMXM4OExtQi9QbitZ?=
 =?utf-8?B?Y2prVDZPVElMb1BUTzdQNkNZWEszUGZvWkU2Tk1xbjdSamdKV0hqUkxrZ1VT?=
 =?utf-8?B?MGxaRjFFZUtEZzhaVWRpS3ErLzhtbDhnbFYvSDFDSkNXS3JYSDBPdG5zM1A5?=
 =?utf-8?B?bFBsZS9tNTlsQk5NYjdUMi9aU1dYekJGZ25YVU1qUmJlQXNnZmlLSm9KSXJS?=
 =?utf-8?B?eElzLzhSSEpuSGNVNElYTTlRQW1kMGtRS0plRXFlSGNHb20wd0w4dG8vMjUx?=
 =?utf-8?B?OGc4UXVlemx5d29EQlhYZWFldTgvZXFyaE8vME0xaklvajBndkhTR0x3R0hF?=
 =?utf-8?B?UTlMR3RSbENFU29idUJuZ055WmQzcm13T1ZsYWZKZUlqdHU2L2dxUlVWVnEv?=
 =?utf-8?B?cUllV2IzaU9rdFkvTU0xdFZpOVh4c3ltVmI1c1NXM2gxR3REZC9GMnJKcFM1?=
 =?utf-8?B?dzFJdUR6NEtCQVNpWUJWSVUvZ1J6UXVOZ3ZTWVBmTmZIa2l4Q3lIeE9EeUxs?=
 =?utf-8?B?bml3YnJaWWtyekRzdjhkN3Q4N210ZlJ2RzZxNjJ3eDdtNng1QkU1RXpHSzh1?=
 =?utf-8?B?em1wOU1yYUVnc3YzSG9KR2p1RURJdER5VlF5bTdiVWp5UGhSc1hiNEo4aFd6?=
 =?utf-8?B?Rk1FUHVSQWI4TXBWZDE0elRjL0tzNXFuV0lOMVBpeTlQS1Rqd2hkb0FQeWt5?=
 =?utf-8?B?SVdnNHVadWZ1WTRHN0MvNWl3S29GVXB4UjIwUW1SV1hkckhHMldrOGVQR3NU?=
 =?utf-8?B?WWZVOVE5QkZ4dlB5amh4dEUwQzdaM2hyQlgyNStseWh0dG9vU21mcXpYKzZY?=
 =?utf-8?B?NUwxNHd1UURUZC8wOGkrL1NTbWpXU2dIWTRpcWVCSUY1M1FDUEhzelJFMlN4?=
 =?utf-8?B?WXFsUFVrWm42OWQzdkxJLzNoNlV6eWljSnd4OVprVldrRFZadkduZ1lSVEVD?=
 =?utf-8?B?cnVMVmZGZlpQSE1NcTk4K00vcjZzK0RpeUFGVVBxNlJJVUtGZGVwcDlRdmxF?=
 =?utf-8?B?elA4ZUlaZlFSZjZIbkNiMi83UGpjUXNOSEFMTmRKY0xDREd1YmtzMFhmaXds?=
 =?utf-8?B?L1VpY0ViZUJ1ZGJuUWxsd2pCL0dnWnpNQWtUUEEwbTAzZ09uU2c0bXJRMGpH?=
 =?utf-8?B?Z3JvNUxiQnhjNW02Y1VVZ29mTHJnTzV4bCs0ZDJOTWs5V3RHOCttb2hPVjZn?=
 =?utf-8?B?bC95YUg3VDZKMVQ3VGRPSkxZZ1lGSDRZZ21PVjJrY3NSQ2drdEdqL1lxbDNX?=
 =?utf-8?B?TlZjdm41aHNVamlESUNnQ0RNcGRCMFZ2N2tYWFBtZC9sU0VoeE5WWkRYRlhQ?=
 =?utf-8?B?SFViMEo1dmJ0OXpGL05PelY4bGtqQUdraW9MR1V4RUM1ejdyZUozMTQwY0Rr?=
 =?utf-8?B?RVF4U1lNN1ZwTjNndzBCVkRoeG5qRzJya28rVlFPci95eFR0RWwrN2ZYMzFP?=
 =?utf-8?B?Zm1yeUpoRTZnZ0Y1dTJ5N2tMMFhjVzRibCtTMnJ6Q0tZenl5cUwzM1JYeE41?=
 =?utf-8?B?UWx3TGFLNHRLc3YrdXNDRTVoN2RtRkhKOWNJd2RJNmk0cW1yTmJuZ1Z4VjYw?=
 =?utf-8?B?U2gzU1ErOVBYVTZWUzR6bGdhQ0RpRkt6d09YRDVvNGs1eXdWeEl6ZmxWYjZ5?=
 =?utf-8?B?b0xLU2VuOHZ0UTRFaldYclpSdGljSW9XOUN0U0xRV25JQllDR0NHMVYvSjVy?=
 =?utf-8?B?aVZGV3l2YU44TDh0R3ZFejFVcjA2M2dsdW9VZFdHWDNYUTZZU0FIWm5nR1l0?=
 =?utf-8?B?NW5RdUJtRlNiSVA4R1hISDdrcG9ndVMwNXdiV21zdUs1VFBYdGNmMUhOU1l3?=
 =?utf-8?B?cll1dElkTERkeElSQmNKTDg2NWh1UDg1MVFGaWxMNnhsNG4wMll1d0JRMlFK?=
 =?utf-8?B?YUtMUktNTi9mV2czN2pJbWhJOWRNTEFRL1B2dnVJVVNkSG5GNWQwSjVQMmov?=
 =?utf-8?B?SzlSMzBsa0I2MjI2Z0diN1RMVm5selFuYnBoRWRHQlp0TXZ0dHZwQWtWb0g5?=
 =?utf-8?B?L2xtMnA5U0E3Q3VId05UUUV2azVCQ2o4UkU2UmtreEpnNmJXZytSUlJrdUEw?=
 =?utf-8?B?VE5xQkZTODMrYkxXWDZqQlp4REIzUFEzdEJ1ZW9lQjdPQkJ0eFE4TWJ6QzBW?=
 =?utf-8?Q?t+TfeafR2GZdWS+YaF/1PwJdz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d30524c0-4670-402a-c1d6-08dcc2498629
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:27:02.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iam8Wajp5fqiXYQGUPnFUIZeBoFIdWHEjeWiWtws0p2IlxzVuhiI7LTsTb+u8ovOX6YdgnaxWNYUj0ZxIO1dHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4741
X-OriginatorOrg: intel.com

On 8/22/2024 5:37 AM, Ira Weiny wrote:
> Li Ming wrote:
>> Using scope-based resource management __free() marco with a new helper
>> called put_cxl_port() to drop open coded the put_device() used to
>> dereference the 'struct device' of a cxl_port.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> ---
>>  drivers/cxl/core/pci.c  |  6 ++----
>>  drivers/cxl/core/port.c | 25 +++++++++----------------
>>  drivers/cxl/cxl.h       |  2 ++
>>  drivers/cxl/mem.c       |  5 ++---
>>  drivers/cxl/pci.c       |  7 ++-----
>>  5 files changed, 17 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 51132a575b27..4725e37d90fb 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -915,15 +915,13 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>  	struct aer_capability_regs aer_regs;
>>  	struct cxl_dport *dport;
>> -	struct cxl_port *port;
>>  	int severity;
>>  
>> -	port = cxl_pci_find_port(pdev, &dport);
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>>  	if (!port)
>>  		return;
>>  
>> -	put_device(&port->dev);
> I don't think this is wrong but we are not holding the lock for the
> duration of the function where before we were not.
>
> It seems like this is somewhat an abuse of the cxl_pci_find_port() call in
> that we don't really need the cxl_port reference but rather the dport...  :-/

Thank you for the review.


Yes, seems like that, but CXL core does not provide a helper function to find a dport via pci device without getting the cxl_port reference yet.


>> -
>>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>  		return;
>>  
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 1d5007e3795a..6119cb3ad25c 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1472,7 +1472,7 @@ static void cxl_detach_ep(void *data)
>>  	struct cxl_memdev *cxlmd = data;
>>  
>>  	for (int i = cxlmd->depth - 1; i >= 1; i--) {
>> -		struct cxl_port *port, *parent_port;
>> +		struct cxl_port *parent_port;
>>  		struct detach_ctx ctx = {
>>  			.cxlmd = cxlmd,
>>  			.depth = i,
>> @@ -1485,7 +1485,7 @@ static void cxl_detach_ep(void *data)
>>  				      port_has_memdev);
>>  		if (!dev)
>>  			continue;
>> -		port = to_cxl_port(dev);
>> +		struct cxl_port *port __free(put_cxl_port) = to_cxl_port(dev);
> This threw me because 'to_cxl_port' does not take a reference...
>
> Seems ok though.

Yes, to_cxl_port() does not take a reference here, but the 'dev' is provided by a bus_find_device() which will take a reference for the 'dev'.

maybe I should use __free() for the 'dev' like below? I think it is clearer.

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..e4bff611e8fa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1481,8 +1481,8 @@ static void cxl_detach_ep(void *data)
                struct cxl_ep *ep;
                bool died = false;

-               dev = bus_find_device(&cxl_bus_type, NULL, &ctx,
-                                     port_has_memdev);
+               struct device *dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL,
+                                                                       &ctx, port_has_memdev);
                if (!dev)
                        continue;
                port = to_cxl_port(dev);
@@ -1512,7 +1512,6 @@ static void cxl_detach_ep(void *data)
                                dev_name(&port->dev));
                        delete_switch_port(port);
                }
-               put_device(&port->dev);
                device_unlock(&parent_port->dev);
        }
 }


>
>>  
>>  		parent_port = to_cxl_port(port->dev.parent);
>>  		device_lock(&parent_port->dev);
>> @@ -1512,7 +1512,6 @@ static void cxl_detach_ep(void *data)
>>  				dev_name(&port->dev));
>>  			delete_switch_port(port);
>>  		}
>> -		put_device(&port->dev);
>>  		device_unlock(&parent_port->dev);
>>  	}
>>  }
>> @@ -1539,8 +1538,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			      struct device *uport_dev,
>>  			      struct device *dport_dev)
>>  {
>> +	struct cxl_port *port __free(put_cxl_port) = NULL;
>>  	struct device *dparent = grandparent(dport_dev);
>> -	struct cxl_port *port, *parent_port = NULL;
>>  	struct cxl_dport *dport, *parent_dport;
>>  	resource_size_t component_reg_phys;
>>  	int rc;
>> @@ -1556,7 +1555,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  		return -ENXIO;
>>  	}
>>  
>> -	parent_port = find_cxl_port(dparent, &parent_dport);
>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>> +		find_cxl_port(dparent, &parent_dport);
>>  	if (!parent_port) {
>>  		/* iterate to create this parent_port */
>>  		return -EAGAIN;
>> @@ -1596,10 +1596,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			 */
>>  			rc = -ENXIO;
>>  		}
>> -		put_device(&port->dev);
>>  	}
>>  
>> -	put_device(&parent_port->dev);
>>  	return rc;
>>  }
>>  
>> @@ -1630,7 +1628,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  		struct device *dport_dev = grandparent(iter);
>>  		struct device *uport_dev;
>>  		struct cxl_dport *dport;
>> -		struct cxl_port *port;
>>  
>>  		/*
>>  		 * The terminal "grandparent" in PCI is NULL and @platform_bus
>> @@ -1649,7 +1646,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
>>  			dev_name(iter), dev_name(dport_dev),
>>  			dev_name(uport_dev));
>> -		port = find_cxl_port(dport_dev, &dport);
>> +		struct cxl_port *port __free(put_cxl_port) =
> Does __free() get called before the next iteration of the loop?  I guess
> it does because it would be out of scope outside the loop?
>
> Ira

Yes, It will get called before the next iteration of the loop. I have validated it.


>
>> +			find_cxl_port(dport_dev, &dport);
>>  		if (port) {
>>  			dev_dbg(&cxlmd->dev,
>>  				"found already registered port %s:%s\n",
>> @@ -1664,18 +1662,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  			 * the parent_port lock as the current port may be being
>>  			 * reaped.
>>  			 */
>> -			if (rc && rc != -EBUSY) {
>> -				put_device(&port->dev);
>> +			if (rc && rc != -EBUSY)
>>  				return rc;
>> -			}
>>  
>>  			/* Any more ports to add between this one and the root? */
>> -			if (!dev_is_cxl_root_child(&port->dev)) {
>> -				put_device(&port->dev);
>> +			if (!dev_is_cxl_root_child(&port->dev))
>>  				continue;
>> -			}
>>  
>> -			put_device(&port->dev);
>>  			return 0;
>>  		}
>>  
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 9afb407d438f..cad297fba700 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -744,6 +744,8 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
>>  void put_cxl_root(struct cxl_root *cxl_root);
>>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
>>  
>> +DEFINE_FREE(put_cxl_port, struct cxl_port *,
>> +	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>>  void cxl_bus_rescan(void);
>>  void cxl_bus_drain(void);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 7de232eaeb17..ab9b8ab8df44 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -109,7 +109,6 @@ static int cxl_mem_probe(struct device *dev)
>>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  	struct device *endpoint_parent;
>> -	struct cxl_port *parent_port;
>>  	struct cxl_dport *dport;
>>  	struct dentry *dentry;
>>  	int rc;
>> @@ -146,7 +145,8 @@ static int cxl_mem_probe(struct device *dev)
>>  	if (rc)
>>  		return rc;
>>  
>> -	parent_port = cxl_mem_find_port(cxlmd, &dport);
>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>> +		cxl_mem_find_port(cxlmd, &dport);
>>  	if (!parent_port) {
>>  		dev_err(dev, "CXL port topology not found\n");
>>  		return -ENXIO;
>> @@ -179,7 +179,6 @@ static int cxl_mem_probe(struct device *dev)
>>  	rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>>  unlock:
>>  	device_unlock(endpoint_parent);
>> -	put_device(&parent_port->dev);
>>  	if (rc)
>>  		return rc;
>>  
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 4be35dc22202..26e75499abdd 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -473,7 +473,6 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
>>  static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>  				  struct cxl_register_map *map)
>>  {
>> -	struct cxl_port *port;
>>  	struct cxl_dport *dport;
>>  	resource_size_t component_reg_phys;
>>  
>> @@ -482,14 +481,12 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>  		.resource = CXL_RESOURCE_NONE,
>>  	};
>>  
>> -	port = cxl_pci_find_port(pdev, &dport);
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>>  	if (!port)
>>  		return -EPROBE_DEFER;
>>  
>>  	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> -
>> -	put_device(&port->dev);
>> -
>>  	if (component_reg_phys == CXL_RESOURCE_NONE)
>>  		return -ENXIO;
>>  
>> -- 
>> 2.40.1
>>
>

