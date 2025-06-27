Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA52E4256
	for <linux-cxl@vger.kernel.org>; Fri, 27 Jun 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034289; cv=fail; b=dFUQP7vJxCYrbI/UsKYklB1OPAcFCgRulhzEGcukn2ta1U9gLKqMtC/iWko17MBZDZyjNtze5F6F/RspWZzoFvT+i9S3d4/TmV0QWH1GHwIGQRXlE1RJjxRkVYj/jyIx0scO/41S9dCLG5t6Zjnn8CMaHDy1e0oBVF0gUwCIYLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034289; c=relaxed/simple;
	bh=RzokvUl0IOkGD6UuOxLwCvTHjjlMjgDUD9faJcPvnEM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WgMJTeRyNf0L4nCcJh5PGohLGFTU6D6olZSwY0cGM1exS6XWFvXlnhAf2mQBzBRXJ07st8vUQTtHFKGvqYmSvf3OjHCbweTVZZxlxlq5K8nd5sIFjz2so8YA0+TBnB4W5ni+TK/TOLB+xdzOedWPknJfWpCbAJfrUhfl9r6UYpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S1eji8aj; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S1eji8aj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+O9uo2LH6hcjD9/lMvO8Gl/lgS/Tk+LDYpzZ6qhprNIktwopK+bfsIdxMtnlTCCcPBz5Hvs4OMFCYjbetB6T/+GsmzgNJt33y5d5vS/sbtbQGvsB47yI7J44QHOl0QST017UCNh+edskQ4qUa2sVwBAX7KyGTar6tqaELCprmEfuAvcDlfFNgv4OFiCmY/S9pQTNA4EyXnRDm6y5ytjLzFPHgGR4u6LGzy0MkV6bqlI8hXN2t6hzAcUc7rUhzNtFrbmkzGM/cZIjbWuP3hxvQ1tWvRkSdu4oK5O8VJli60xyP9NImXHVftDRIkPYnjJgBVswBUi5jd3DeYyI81r6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbFgernxkoL+IF63MOSDMvxpnZc510Xk3ePvJpPm3oI=;
 b=KmvdjGpLVHXzTYyg8YpGDTbr8XuORjH+aYz2vThqlWnDgksNykvthQPMDqHk45uKZ5dy6ZJ18NdN/8P7SQs5zNVNheeBLNuUQFETXT2jt9oImq7yuSMdsGy1IUHk8fH7Zfia6pgjXJ6xZ8x8y1BGthAqOl4da5/fGS8w3iC51kPZYdol5k7IAFcmBL8mHvuHia+sef8Xkkto+rwAfDvl4Z0c298zE7Qlc1K4pab1ozMvLRyXSCmmYBQ1MBwaYLVLUI4cN/RyNbckwS8yeMdQ/gK4R+lAi0WOHDf1dgN3Xpzoc/xQTJt6YPOk2kT8mGudlSDc2PmIdQjWv9xrpO+/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbFgernxkoL+IF63MOSDMvxpnZc510Xk3ePvJpPm3oI=;
 b=S1eji8ajzwzw2A4ONqRJ5wWwwaYj9K4ijFtxRWBLjmaG20iUQTKfi+2H6eBK8QpiAw30IlHXus8HioQ8DN1XEdYRAlNCr0itDxivx2HFZBjKZND+T4+2Yp9PtzrQiIqgAahgTLz4HdWJlhXJlCkX17r3PVKYtB5s6m2BHhQ/9Pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 14:24:44 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8835.027; Fri, 27 Jun 2025
 14:24:43 +0000
Message-ID: <7e2a7ebe-543d-48ef-b418-78b608b41c14@amd.com>
Date: Fri, 27 Jun 2025 09:24:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/17] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
To: Shiju Jose <shiju.jose@huawei.com>, "dave@stgolabs.net"
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
 <rrichter@amd.com>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>,
 "lukas@wunner.de" <lukas@wunner.de>,
 "Benjamin.Cheatham@amd.com" <Benjamin.Cheatham@amd.com>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-4-terry.bowman@amd.com>
 <b745b33288e540cea2d67286c9e49f8b@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <b745b33288e540cea2d67286c9e49f8b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::23) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: fa73b095-26c6-47b0-cf08-08ddb5865c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFBWYkRYYk9iQWZ1clppV2tsMDE4dElTbWRoeDYvZXBmWkV6dGs2WXNkYnlt?=
 =?utf-8?B?WGl6ai9sUTQvdW1WWDJUT2s2dnlOSXZFbHB1S1BQTWxnTkVyWTVFWWtmUXFt?=
 =?utf-8?B?V2t3b2V6MDdOV3VlbDlFaXQzWGgwRjhzbEh5N3ZCc0t0ZmVvWHpxSW10K202?=
 =?utf-8?B?VUxxdnlrTDBQMGJMMVBySWllTHVaeEFBWHJKdW0wYVc0ZGdtdW5XaVRIVjRv?=
 =?utf-8?B?QTdocHIzRGRVREx0MFFhcGxNOXRzMDVWVE5PS0dCdkt6d1ZsUjFJOHhvcEJk?=
 =?utf-8?B?M0xSTW1iN0pzUHo3R3VoTE14aXRRYUhOdFpMdzVoZlphTFhXWVV1S0JDVGR0?=
 =?utf-8?B?RzExSFIzZURqTmtXaVEwQ2I1ZVdKNWZsR3l1anY3U0ZQVzgwNndSZXRucXFI?=
 =?utf-8?B?SVRGNWdTT0lZV0FUOHZNOE9KTEpNekR6UFdoVDBiU2xTazVkcS9DYU05Z2RO?=
 =?utf-8?B?bldkTXJ4eUJXakVyMWlieG9sNGVzK05uSW90SzFhNmlaQklvWWdURjRKQUlR?=
 =?utf-8?B?eVJXZ3ZYVXpWbHdleXFEdmJZWU1XYkpwbStTRmNwY3VpOWlYcjVrMmE2Zmxq?=
 =?utf-8?B?VUFudEpJSzFnNDZGY2VjSTBPSGU4eVgwYXNmcDdOZzJWTzZxTDBmNGRoOWx4?=
 =?utf-8?B?VVM1S2hWQkIwb3JZZG5mMitGVTFaSUdHNDBBT25SbVV6VTc2QkswdFhIZkw5?=
 =?utf-8?B?K3dNYnE5Y2FZNCtUL0RycWFvcG12eE5CM0N3WW94QTBZQklLQkV2eVRiQnpH?=
 =?utf-8?B?Y1JmWXNyTHArKzgyUzRaN1pLSzNHU2p1cE4xWUh5QXVHd0FvVGlZcEluT2pB?=
 =?utf-8?B?NFppN0ozbmZsM21vd1VWc0JIOEpVSFlDallrcjlTdXR1OVpZa2wwZW9uYjU1?=
 =?utf-8?B?TUFSQUZueFc1eitVcmF4aWJtNXpub1k3RkJuSDRDTlFrNU1ZNDR3ZjBWbFc4?=
 =?utf-8?B?THdwR0orN0Nhb3VXQWwzSnQ5T2xKazNBYmU0OS9vMDBDRUpnN0xXTEdlNTc3?=
 =?utf-8?B?Sm45TUhFbGx3R210TnlTZG9YN0VtVGgzSlpBMi9KVWRqY1lHZEQ2VFNzWUlI?=
 =?utf-8?B?cjlBem9DMWZIS3VDWHBHeW5WNFFQSFpNTWR3UGx0ek5mZ3dzVXJCVk1VVTZi?=
 =?utf-8?B?V05VUGd6am8xSzVZZVF2eW52ajBCS0tFb0lScFF1NllRUEo0cW5GZzk3TkpV?=
 =?utf-8?B?K0FWTFUxUmp2T3RJL0pzN1dDa3J0eUJadUpmU1ppMlpJTWRsMXF6dEZmQTkz?=
 =?utf-8?B?QzVzOUNONmNlY0N2V2FVcTlxZnkzb3VJWExodGU4aWVmUW90b0JNRWlGOERz?=
 =?utf-8?B?dkZ0N0dlcFhxR0ZWeDBCL00rdDUxY3Vmbll6OFNERDJ2Rmw4VFdPQU9HaGtY?=
 =?utf-8?B?VVE0NStOMEsvL2tiZFl6cDVzRDdnWENNNGFCVmNGTXdqSFVYdWJzZXMySERB?=
 =?utf-8?B?RGhuMlVKREg4RmF0dGpTNFZLZUxISk1NZnoyTEptdUpIbjRYWnJhMTR0OUV2?=
 =?utf-8?B?eDE5aDUwUXhhS01JandzN0ZoeHZlTEYxS3REYURCZWlwcWo0eUx6a2IvRHBB?=
 =?utf-8?B?U056WE53bWlQYVdSVFVVbisvUVo2YWhsQnkxWEdiV0xzM0FOMUNUS055YlpK?=
 =?utf-8?B?TStBa2MvV3NXVldJdy9EUzV3ME5yV0F0djZUdHE3NU5FaUlNL1VFOHV5QmpT?=
 =?utf-8?B?bGNDUFV4ZmY1WUp4WHFhcUVWam1rdkdsYU9RVVRVd292Y3N2UzRoR1ExYkc1?=
 =?utf-8?B?WWhkNFVXWC9HUndYMldpcnZzVjNmNlo0eWVlUmQxQnpmeENuMlpiYmdLRXlz?=
 =?utf-8?B?TlYzY3BGNWVFTElVZkFIVHdpVkl1NmFiWDRlTkJVTkdndXAxcWtRNC96bU0r?=
 =?utf-8?B?YnFtYU5HWDhWcGxHQ1F6MEVkUHJmMDZ1TmVOQm9zNWpjVnBlUXh4eFJnVklu?=
 =?utf-8?B?R2pURFAxZ3RDaW9vdk1QczFydFpQUVltNDk1VXI2RHFERHhaaXBuWnYzaTB2?=
 =?utf-8?B?NlNhQ0M1QmhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtPVHVWaUpJOGp3UUQ4REtLVTUwdkpzRWxhUnRERE0yRDRBK2FnNHRlR2dm?=
 =?utf-8?B?NkhmZlcvMnZMcGlNYmZQVHVsU0JYUU80S1JqdUtoeWhtQkpyNVVkbWMxTzV1?=
 =?utf-8?B?YkoyaDNock9zK3A4NmVTRC9zWFhrOFFaNFQ4cEY0NlZlQUNoSHFiejd2Tm1s?=
 =?utf-8?B?cmFkUDJVR1M0eFdSY2pwQWZIT0MzbFV0TGVXNjhTalJnYWVvV09Sa2FNdzYx?=
 =?utf-8?B?NStPRkdvd0srVFBrQVNNMDlRdU14d3VTQ0ZzU1JWbWZaMWt2WE5iNGU4THJt?=
 =?utf-8?B?SXUrdW56Rzh1UGFIZ002OFM0bnVDZUZFbWpIL0Vqc0pBaHZvc3lYSDEzcG5a?=
 =?utf-8?B?cjJTTmlJVWxXTG04WUJrWXdlOHlKcURINFMzcldDdTZTYWFiWGMrY3U1dmgw?=
 =?utf-8?B?cVpzc1Zka3FhTy80Y1hqUmdkb2VMU2w2QUhjSXZOK3U0VkVNS0hWTEN2NHYr?=
 =?utf-8?B?NVVGVDR6cWxTSGZ0MXlvdjVFajVKclE3OTYvY0lSaWZ6bGxtZEsvU29Ib2k2?=
 =?utf-8?B?MmdtQUJJUk1DUDYra2FKVG9CV1lqY3EveTZpS2syaUhndWE3eTJRM3dHQnVQ?=
 =?utf-8?B?b2dJamRmbTlKVUlvNmU0aUVWb2pKdTRHYy9tSEljRk1QaWFDZ0RVL2w2VTNa?=
 =?utf-8?B?V2xGaWNoVVJDNmZoZ1dnRjRPbjNZOHI4SUQ2ZC9jdVo1R3NYRXY2aXNINnNC?=
 =?utf-8?B?bXZXdEQzc2wzc2crOVJsc3Ixc0RmVXZUM1k2SmQ2SEd1T0QrZ3RhZ1o4U1dY?=
 =?utf-8?B?QjhGaEp0bWMrYUpMdTVQdWkzRWs3NUJkem91ZnJrUWhxQWxiN3RYelhDNmxx?=
 =?utf-8?B?bCtUNGFNYmZIQWU2NW8vd2pmMk5xT1dLaUlCQVU4ZU91U1k1bzBFUjR6YmV1?=
 =?utf-8?B?cUNweTUwbmxTenlDQU5qRS9Wc3E5SjdadTBQV2NrMlVUMVBDVUNNL1B5SVRz?=
 =?utf-8?B?Q3FVcmV5eHVkdmI3Z1JBUHM2NVJ3V1MvRWgvbm42MUJRVEtPejkybGY2OS9V?=
 =?utf-8?B?OWpQVmNuLy9UVExpUVpXalZDTUM5K1NNUE9BUW8yd0RCTnRGQUtpZ0VxM2Fo?=
 =?utf-8?B?RCtFTTdRUTlmZXBJWi9YRzBPbHNZYmZJcHpCVHVKRU1CUGxGZnNVcm16TW83?=
 =?utf-8?B?UU5Fd05Ga08xdDlzTkNQWGVQWDlvd254WEhFeTVkSFA4VERWSGIwN0tiTGlr?=
 =?utf-8?B?VTRJcGVkZkF4Rlh5d0V2VXJnVUhSN1k3ek43Yk4zSzdLeXRJWlFZbTUrOFBn?=
 =?utf-8?B?dEh4ei9mTnJHQy9RTnBIUDZhQ0JCb3hzN3lmdHhnU3VuUURsK2FJUjlTUnBk?=
 =?utf-8?B?RTUzaTF0Qnd2Q21jUGthMnJNdFVCYTdwT0dHVlg2d2lwWGdrTEx0MCtrRVVo?=
 =?utf-8?B?VjRGZ0pXdVZHK2t3WGZ1eHdRTFRadXFWTUZJVlJyOHVETUJLQTJFSEZudmMy?=
 =?utf-8?B?a2F1RHVYMmNDaEtDMkJSamhjL1VMd1Y5VUNYd0NaN2dTR0N6WkxZUnVPTGt6?=
 =?utf-8?B?U2JGaXdZR0FqWTJ2SkFydEg4V0JnVVI2ZG1xYUZwczQ4WWJtdDhQaWxjdy9a?=
 =?utf-8?B?OWllNmpKRXNHc3QweS9mTXNGSTBZU0V0K1hJVHl4ZC8zMnBVS2EzL0I0YUxN?=
 =?utf-8?B?bkRKYUJwVlpKcGVYZ1RtdnZ4SG1QT3BRcWhVR1FRL3c4TFg3bzZxbDlMa20r?=
 =?utf-8?B?aGUycjdweGw4Y3cxeGYwVEdvSHdyNjFNbjB1cjIyazhacFhkdXpLUlBhMjBD?=
 =?utf-8?B?V2tENkhUbWRUbUx4SUt2dzdQQk9wSTg5QjNwYVZobXZmN2FiZDNQQ2h1S21z?=
 =?utf-8?B?L3RrUnE2Y1Zhck1paExKb084b2dUYURYQ2t5aDBRREp2QkVtR3NkMTJTYURB?=
 =?utf-8?B?VVNyRmRYZ2hldUVzMytDL0xYQ243RVBEV2hpeTJRTkM2S1pHSXRJbE5vU3Jn?=
 =?utf-8?B?cFlHSTlRQ21TL1FUa1FDR1R0RlF4UFloM3JZU1ZyR21JMlFZcFpCdnBBWXkr?=
 =?utf-8?B?MWlGU3BqZTFtWW5jclFYa2hvemdFci9hbE1vazlMSmI4RnRIc05xL1NKVm1E?=
 =?utf-8?B?aTRMcHU0aWZzZFBJNkpsVXRPWGt1bCtMRmRYQTFEWU9ib1hJc05WNUZlbEtP?=
 =?utf-8?Q?b2/WIhu2gqYofjQwW4efnTmao?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa73b095-26c6-47b0-cf08-08ddb5865c17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:24:43.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lm+1NFWpSee7RRV6f4B4EZTcxVETWr7p5A3KQ5ey5mYnYU7RqijqYpEkJU27jnS+3P2k33+8b8jSrxU0kISrLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163



On 6/27/2025 6:32 AM, Shiju Jose wrote:
>> -----Original Message-----
>> From: Terry Bowman <terry.bowman@amd.com>
>> Sent: 26 June 2025 23:43
>> To: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>> dave.jiang@intel.com; alison.schofield@intel.com; dan.j.williams@intel.com;
>> bhelgaas@google.com; Shiju Jose <shiju.jose@huawei.com>;
>> ming.li@zohomail.com; Smita.KoralahalliChannabasappa@amd.com;
>> rrichter@amd.com; dan.carpenter@linaro.org;
>> PradeepVineshReddy.Kodamati@amd.com; lukas@wunner.de;
>> Benjamin.Cheatham@amd.com;
>> sathyanarayanan.kuppuswamy@linux.intel.com; terry.bowman@amd.com;
>> linux-cxl@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
>> Subject: [PATCH v10 03/17] PCI/AER: Report CXL or PCIe bus error type in trace
>> logging
>>
>> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
>> for all errors. Update the driver and aer_event tracing to log 'CXL Bus Type' for
>> CXL device errors.
>>
>> This requires the AER can identify and distinguish between PCIe errors and CXL
>> errors.
>>
>> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
>> aer_get_device_error_info() and pci_print_aer().
>>
>> Update the aer_event trace routine to accept a bus type string parameter.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> ---
>> drivers/pci/pci.h       |  6 ++++++
>> drivers/pci/pcie/aer.c  | 21 +++++++++++++++------  include/ras/ras_event.h |  9
>> ++++++---
>> 3 files changed, 27 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
>> 12215ee72afb..a0d1e59b5666 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -608,6 +608,7 @@ struct aer_err_info {
>> 	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
>> 	int error_dev_num;
>> 	const char *level;		/* printk level */
>> +	bool is_cxl;
>>
>> 	unsigned int id:16;
>>
>> @@ -628,6 +629,11 @@ struct aer_err_info {  int
>> aer_get_device_error_info(struct aer_err_info *info, int i);  void
>> aer_print_error(struct aer_err_info *info, int i);
>>
>> +static inline const char *aer_err_bus(struct aer_err_info *info) {
>> +	return info->is_cxl ? "CXL" : "PCIe";
>> +}
>> +
>> int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>> 		      unsigned int tlp_len, bool flit,
>> 		      struct pcie_tlp_log *log);
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
>> 70ac66188367..a2df9456595a 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -837,6 +837,7 @@ void aer_print_error(struct aer_err_info *info, int i)
>> 	struct pci_dev *dev;
>> 	int layer, agent, id;
>> 	const char *level = info->level;
>> +	const char *bus_type = aer_err_bus(info);
>>
>> 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
>> 		return;
>> @@ -845,23 +846,23 @@ void aer_print_error(struct aer_err_info *info, int i)
>> 	id = pci_dev_id(dev);
>>
>> 	pci_dev_aer_stats_incr(dev, info);
>> -	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
>> +	trace_aer_event(pci_name(dev), bus_type, (info->status & ~info->mask),
>> 			info->severity, info->tlp_header_valid, &info->tlp);
>>
>> 	if (!info->ratelimit_print[i])
>> 		return;
>>
>> 	if (!info->status) {
>> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible,
>> (Unregistered Agent ID)\n",
>> -			aer_error_severity_string[info->severity]);
>> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible,
>> (Unregistered Agent ID)\n",
>> +			bus_type, aer_error_severity_string[info->severity]);
>> 		goto out;
>> 	}
>>
>> 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>> 	agent = AER_GET_AGENT(info->severity, info->status);
>>
>> -	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>> -		   aer_error_severity_string[info->severity],
>> +	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
>> +		   bus_type, aer_error_severity_string[info->severity],
>> 		   aer_error_layer[layer], aer_agent_string[agent]);
>>
>> 	aer_printk(level, dev, "  device [%04x:%04x] error
>> status/mask=%08x/%08x\n", @@ -895,6 +896,7 @@
>> EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>> void pci_print_aer(struct pci_dev *dev, int aer_severity,
>> 		   struct aer_capability_regs *aer)
>> {
>> +	const char *bus_type;
>> 	int layer, agent, tlp_header_valid = 0;
>> 	u32 status, mask;
>> 	struct aer_err_info info = {
>> @@ -915,9 +917,12 @@ void pci_print_aer(struct pci_dev *dev, int
>> aer_severity,
>>
>> 	info.status = status;
>> 	info.mask = mask;
>> +	info.is_cxl = pcie_is_cxl(dev);
>> +
>> +	bus_type = aer_err_bus(&info);
>>
>> 	pci_dev_aer_stats_incr(dev, &info);
>> -	trace_aer_event(pci_name(dev), (status & ~mask),
>> +	trace_aer_event(pci_name(dev), bus_type, (status & ~mask),
>> 			aer_severity, tlp_header_valid, &aer->header_log);
>>
>> 	if (!aer_ratelimit(dev, info.severity)) @@ -939,6 +944,9 @@ void
>> pci_print_aer(struct pci_dev *dev, int aer_severity,
>> 	if (tlp_header_valid)
>> 		pcie_print_tlp_log(dev, &aer->header_log, info.level,
>> 				   dev_fmt("  "));
>> +
>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>> +			aer_severity, tlp_header_valid, &aer->header_log);
> Hi Terry,
>
> It looks like an extra trace_aer_event() is called here along with the above
> trace_aer_event(pci_name(dev),...? 
>
> Thanks,
> Shiju

Indeed. I'll remove the trace_aer_event() call immediately above your comment (at end of function).

-Terry

>> }
>> EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>>
>> @@ -1371,6 +1379,7 @@ int aer_get_device_error_info(struct aer_err_info
>> *info, int i)
>> 	/* Must reset in this function */
>> 	info->status = 0;
>> 	info->tlp_header_valid = 0;
>> +	info->is_cxl = pcie_is_cxl(dev);
>>
>> 	/* The device might not support AER */
>> 	if (!aer)
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h index
>> 14c9f943d53f..080829d59c36 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>>
>> TRACE_EVENT(aer_event,
>> 	TP_PROTO(const char *dev_name,
>> +		 const char *bus_type,
>> 		 const u32 status,
>> 		 const u8 severity,
>> 		 const u8 tlp_header_valid,
>> 		 struct pcie_tlp_log *tlp),
>>
>> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>> +	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>>
>> 	TP_STRUCT__entry(
>> 		__string(	dev_name,	dev_name	)
>> +		__string(	bus_type,	bus_type	)
>> 		__field(	u32,		status		)
>> 		__field(	u8,		severity	)
>> 		__field(	u8, 		tlp_header_valid)
>> @@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>>
>> 	TP_fast_assign(
>> 		__assign_str(dev_name);
>> +		__assign_str(bus_type);
>> 		__entry->status		= status;
>> 		__entry->severity	= severity;
>> 		__entry->tlp_header_valid = tlp_header_valid; @@ -325,8
>> +328,8 @@ TRACE_EVENT(aer_event,
>> 		}
>> 	),
>>
>> -	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>> -		__get_str(dev_name),
>> +	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
>> +		__get_str(dev_name), __get_str(bus_type),
>> 		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>> 			__entry->severity == AER_FATAL ?
>> 			"Fatal" : "Uncorrected, non-fatal",
>> --
>> 2.34.1

