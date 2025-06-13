Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96521EDA0B
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780659; cv=fail; b=bZZ7VpFfbpSKGM3gNmxzYEphQsJI5Ge5ewp9Z3bsX0eZMWlvgGYK5hdeqt5jFv5/Us/LbHNYTumibtlbiKVanc2fLQ/dzhj4r6AK45UHLixpakylVQ52Q8wE7goWZCaTf083nPHxfocYow7vv+o84H/wU6Wt5/kFH7CE+i6uDFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780659; c=relaxed/simple;
	bh=u0w4U/3Nk7CAVd5sKvbKLnWdko6yKXiuj8T41YhmA9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oy1ybYrxSNE4uDupXHOHYrQc/8VDH6mteY2+inX/tQYdn9AVFupeZCbyyuZoddTEV+PpnVDUP2LAevaY5bdHUBlEiPaAL7pcmpTlssPxBILWhQU/KKrB1+cL4ZAZwu9lKv+2qsk04e9RvrQsCpZNktdwQw7JA/bko2h7pS1DuQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gq5wVYET; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gq5wVYET"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749780658; x=1781316658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u0w4U/3Nk7CAVd5sKvbKLnWdko6yKXiuj8T41YhmA9I=;
  b=gq5wVYETDz/4jroufCdnisGHBdTHU3QjtzHB4gn+eRmTeufIwTFzX2cl
   tFgxBc87dN0mdilDxJaVfXSUunTEmSVGoUnsZS6rpF7+CY2v63r2spzZ5
   9ZKtVmbxt75HYW2aAikF0AaqL3kNswIO7Ye852yuZ59Oee2MrZATQn0KN
   RlLI62q9d+5iVeKk/PHkqGCsvXe5nH8Q0mKUt7FOvITDaitLhIX4EK3m3
   pYwqJRKnDV/sJ/BWyxJoRrP7zuMD8MhQ5uNQ3rmPNdKifNReN831vzhoI
   gEovSzEnhpNcHfrbKqXtrCaqXlwjZvYcCvLUzhP9j+ITkz1xHzLL5uTYF
   A==;
X-CSE-ConnectionGUID: Xp8h4Z7VTeuL1p4oCKRguA==
X-CSE-MsgGUID: tnrawtEIQK29QLhRRrps+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69489359"
X-IronPort-AV: E=Sophos;i="6.16,232,1744038000"; 
   d="scan'208";a="69489359"
Received: from mail-japaneastazon11010045.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.45])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 11:09:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAwfeFpDocO1J+4EtehVZbygiPdsEC1ZeTRxjuZR0JZLiUhoZ3ZbaUX53j4bHVaOWYjM4+VLS/vVotCkROd4EvICIQxwBkhvHCb1gx2j/Ur2x2/9knJ3U7wT7+oxkqVqjAkyrv7pl55FIGRvdA8s0MUgi1RiNDKNiMe+DPV7MnB3z9B4x9xes9VKd2B4MELxpAQC/leI3CWI9BM8LqVrt8D3e/9htCQOzkMYtov7Hx44CmrisvdQ9PlufmLpzHTkNG7CiOBwsz3iqCykS3EuQ1+/yJ+GqwHK8LFi3CdRdnSXtYJdDdx+7q+Rupx4dsiJwhr4PitjZ0Pt9+5klw5tNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0w4U/3Nk7CAVd5sKvbKLnWdko6yKXiuj8T41YhmA9I=;
 b=J6H3F7Xgd+WmflmZ57O6luoftPhj1YfMA4HuUrZinI4JmEQWGhw23c9FmerQJYIljwQU64cTPtmeRYVxqrwPW7mBeKnvnqyJMoTtUyfv/OsrlHpAsv8dX1Th15rMGOEUXm92NAqKgRXQipHXXPL+JmBfvWzWxXFdR7hOyhopJOMfVleScnBxIfvpS6f4FFygxdibXv0ZAmWyyMkgGOB7psX+K2RaDcYl/Ox2Fdc57Pf4dYOXYh+DTcKzjvKOKpRqa9h3CqyY5MBgtwSOT9qlPmdpYGJC1ByuLwSj6cF82DhTYcVXpvpWvZzBST85wdpsH2FrX9NS+HJVZs/ydRkTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSCPR01MB15814.jpnprd01.prod.outlook.com (2603:1096:604:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 02:09:39 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:09:39 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>, Itaru Kitayama
	<itaru.kitayama@linux.dev>
CC: "linuxarm@huawei.com" <linuxarm@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Alireza
 Sanaee <alireza.sanaee@huawei.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
	<alex.bennee@linaro.org>
Subject: Re: [PATCH v15 2/4] hw/cxl: Make the CXL fixed memory windows
 devices.
Thread-Topic: [PATCH v15 2/4] hw/cxl: Make the CXL fixed memory windows
 devices.
Thread-Index: AQHb26As1Q7yrsb8EUeuG+1+s+FSkLQAWSyA
Date: Fri, 13 Jun 2025 02:09:39 +0000
Message-ID: <b010e914-d38b-47d8-a8cf-442f25b60610@fujitsu.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSCPR01MB15814:EE_
x-ms-office365-filtering-correlation-id: 911a12d4-30bb-47be-71d8-08ddaa1f5a5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WjJmMC9nRWtnQ3I4WkFrekxZRHJhZm5OVFZFeG13aEZOTTdQcDkrZkYzU2tI?=
 =?utf-8?B?MDI4bzF5cHh6RTQyanViWjJmdU1RSjVreEVOdFlmbjN3a0ZjdklWL1NWdUQv?=
 =?utf-8?B?Q2lRdzE3SElYTFlidlJXaU1oemlGQm9KMzA3VU1JbUxGVy9sTHh6TE9PNDll?=
 =?utf-8?B?eHVOMzZPR0VZcnVMQm4zUXYxd1d4bWJNa2tZMmRHUGxaalRuMHVmZThwcTBU?=
 =?utf-8?B?SnlTYU1OWEZOS0VlcVNydGMrdTJuaXNtRmhqaHFWQ0N5Nmt5QTZ0QjhHQkha?=
 =?utf-8?B?RnRva3FTa0YyRElmRWM2VDdXOTQ0Q0xKYVk1R3krL1lvSHVKSVZzdzFnNi9x?=
 =?utf-8?B?UDJMSUxmSy9HNTRwdlJsOGJKcFg3MDNYc09vNmhKcW5XbDArZWlTcWlUU2hC?=
 =?utf-8?B?L3d4MHY5S25tZzRaWnJFdW5MN3VXc216SHozN2RHMjlIeW9OZW9NaUx0Z25P?=
 =?utf-8?B?MFNEMityVzQ4cDkwbzJpVFZGdUttd0FCMFFrbml0SGlEd3lUdVRoQkNFNmUr?=
 =?utf-8?B?RmhvMFFrMUU5S0pGQkxFUndBN3llOEJRRHIxSHJZTUNCVUk2c0Rmb2U0ZWo5?=
 =?utf-8?B?RUpkdm9pU01pemFRdktqblBoS2lXajV3VjlnbFluS2dldGxPUnRmT0tsYUgr?=
 =?utf-8?B?WEhxc2o4UTJtT0dtN0k2eXdDeUI4cmJxOG5uUW1LbnFOcGFiWFZncW5tTTRY?=
 =?utf-8?B?bjFEWklmZmNQZWs1MmdBSWtSQmx5YXFOQXNjVWdnZmlZLzErZkRvNEhZQmR5?=
 =?utf-8?B?TFRlMHJzb0hBSFluVmp6c1A2dTZiRm1WUVBwTlpYQ1NRQ3dRYzlDQlc2Zy9T?=
 =?utf-8?B?b3ZkK0lQcE9KeURnRjk5dUJrdFRBNG9ZMFpTb0dSanZudVZYT1JNcGh5ejNy?=
 =?utf-8?B?SjNJRlN2ZG1kcVJCbDExOHdXRk5pQkhYdm5QNlVOeTFCMWJReTl5TCtyb0FR?=
 =?utf-8?B?LzFiV2FrN01wQWxmeUtsOURQUEk3bFEwZ2lJM0RWWlFjaU5iUUc0S0ZrTzNK?=
 =?utf-8?B?TUJJMWJmaGhEUis5ajQ2cVB6RDdCMC9jMXVvUENsc1Q1b0M2S3BzYXJHR3hm?=
 =?utf-8?B?YjNFcHhtRUNId3E5dHF5bzhCY3ZPcTNSRnpta0VjU2QwcUxiWHduS0Nobm94?=
 =?utf-8?B?QTJFSmVRWjFmTVE4RTBTZ0x2YWZjYklraDhxa1ZGVEQ0UUtXbjhRSUxkSktm?=
 =?utf-8?B?U3hldUltbUI2WE9DZ0x0aWFuVVRoOTI2U1dETk5vSmFzRjZ6WkxDUVFBeFpK?=
 =?utf-8?B?N05aa2RSTnVVNVZVZTVWVmw4RWlhbGEvbFBManVMcXVDWXJlclZ3WkZWSFFS?=
 =?utf-8?B?TWsvMHlGMU52ZUxRSEg1UEtkeHdMT05UcUtPdXVsb01IazJrVDJXN0JhcnZI?=
 =?utf-8?B?eWZBYVpjRWtSdU1QZC9QbVl4VHJEYlQ5VXZPUkRtNG9iZDhLeFpKS0prbk1R?=
 =?utf-8?B?RTVIcWlWN25tdTRUMXRGNWJTbGd2Y2tiR3hHU1YycGF5OWtnc3RVZm11cXls?=
 =?utf-8?B?VjBaVFBPeVdrMlFuVm03bWxIWVliMlhsOElJa1h3eFJOS1VpK09RUHZhcU5U?=
 =?utf-8?B?eWhQU1RXQWdndzl5YnJsUHRrazRHQytEaytSSlFnSzQwVitVWjEza2xCUXlh?=
 =?utf-8?B?MUZjY1ZnWTZJOXFqVVAzUktMeDZiOU9SbDlkSG5GRnJIU0FUUy9wSytWYmVu?=
 =?utf-8?B?QmsvUU9iSnl6RWtKUmE2SVFYVzM3NHZzMjcrRnhDMGNBTlRSSFM2VXZSUHNG?=
 =?utf-8?B?UUxwbnVEYmJEYmZKdStSMHlvZkFvSkFQcm1oTmJkTVNNSTNhOEdVcGhtOVhL?=
 =?utf-8?B?dFkyR3Q1UXhEQWpnWk1QQmUza2tsQ1ZFc0V0UmhHKzBNMlZwaXkvQmpTOUVk?=
 =?utf-8?B?c2RvUytxejB0WlB6SDZNYWtsU2c3RzZrUEtxbDBmVGRsRUpHRjA2VDFzbitO?=
 =?utf-8?B?WmUwS3FWNXRzMUtTd1JISjFuM1NCR3BTL1pzdk8zc3NhNlRNYkdjS3VFSEdV?=
 =?utf-8?B?djR0alpOMWJnU0RuZldUaUV2bDFjTGFnNTVVNHYySStDUHdTVFlreWZDTFZH?=
 =?utf-8?Q?sOL1Mp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVNXNEVTNVZHaXBiZllrR0ZKdVF5Q3ZTL2tkZEdEcXdsQ2U5aEhBTUpGRmpi?=
 =?utf-8?B?Vk1zcVcwVzNDNDlpenlNTjdLeVo4cmlVNVVuVmhESWhiVllQQjlvb0FJM09H?=
 =?utf-8?B?WlJCQXVGU0VtQ0hqcFg0MmF6aEtaa0ZhV2Rjc3RFcVE1L1JuY0d1Q1l0bXdI?=
 =?utf-8?B?TUlqOCtQSkVKQ3Y1VVNUMWFrcmNxcVJqaHVOQVErL1Fwa3JSVEMrK1VGNW9k?=
 =?utf-8?B?Q3FEa2oraU9EWXJQd2c5djh5RTNvelBYQUpKTE9DRktRelEvemZtMnRCZ29E?=
 =?utf-8?B?Vk82dXg3MUlReU5SanZzTHNIcDZINU5rcnRmRThnaWNPNms3UWREWlFlaDlo?=
 =?utf-8?B?WG0vNDVVZVJmV3dwaUtUdExqNVB0ZXRaZVRlMWxVQnVDN0llZXd3Z0VoZEFH?=
 =?utf-8?B?TkE4VWVvQ2Fnc283Qys1ZUcxWS9EZEhFa290cllXNzZ5cllZUWNSNStqQXpw?=
 =?utf-8?B?YzNmNHRZOW4wM1E3b1BwdGt5NDBGSDdva0ZBdHplSTZ2aEY1MGNldjNvMjZK?=
 =?utf-8?B?RlVFSjRXK29VRjgreWI0dDNhZ1g4c1ZScllGemMwNGtab2IwTm5ma3MwQW1w?=
 =?utf-8?B?eS9HZ25mU2NxT1NobUsrU0lXUVF6WE5SbVkvTE9SWmQzdlZzdWdDd1hqV2Zw?=
 =?utf-8?B?S0x5dUt1T2djVCtVWTRKTXJIVGpZU2Vkcmc2S1dNKzdVbzZQNTlaRjRMcEVP?=
 =?utf-8?B?dGZVVnV6V2ZVMmYwVVgvL0FJcFgvMlhaTjZmL2ZaL3hhOGV3RE1SZkJDWjYw?=
 =?utf-8?B?YW5SNTJ3blZ4NnRKTm16MTBjNDFVUXBtcndmTmJtUU8zbTZsandDQkNqTE02?=
 =?utf-8?B?VHFXc3gyYVA3TXU5R2FBRElCZ1g0aHpuQk1jb1BBdklqNlh4UzBNUVEzQWpE?=
 =?utf-8?B?VTJwSFNmSUUwMlNZbVBOcUo1VUhKcE5KU2V4TklybEtTbUZ6L3U1YUp2RWRq?=
 =?utf-8?B?NkFoYjhzS0xVTlpjTDJEOW9NeFJ2em9OclpRTFE5YVFnVUJsamV0ZnlZNEVt?=
 =?utf-8?B?YUZtUWpaamJLZzNTN1pOcUxOdzVZWUtrajBoTTZVY3BFditnMzNvcVNpUzVT?=
 =?utf-8?B?amo0TzExbGsvSWdQMUdRbXdKZEFIVmFoaUFURHBKR0tvejlDRVdFZnliZmpK?=
 =?utf-8?B?czZ6TDVJRDJDbE01c0hEWWNrZFJhZlNrbkp6anpDdENsZFg3ODBobGVpYlpI?=
 =?utf-8?B?dGxtMG1rdU5aN3M5aVZDRnE0MlhQSlpGdE1jUndrS0NyOTA4VFZxaVN5dFp6?=
 =?utf-8?B?OHZKcytlL3pibVRXVnFaN0F6Z1FyRUVFbDN6b1B6WGE1ZkVDTnJ5ZmVZNUpS?=
 =?utf-8?B?SXVJV0tNd2RVdSsweWNyWVVLcHVBbktvUDlpWUdYbDRpVlJRVTJPb2NBMlVO?=
 =?utf-8?B?aFdzSTNiUENHVGpQZGdnemozcmFKTE9RbVBONGl1Yi9sVEFSU25ZN0dTc3ZI?=
 =?utf-8?B?UjFzbzZkd3FmY0pEc2huUjBUT2gxeHA5MTVIUHJCNk5RNGNMeEZ1TVppdjZu?=
 =?utf-8?B?ajNYNDd4R2JsMnZOaWVWVERhM0lWaDdyTEZSc1hvMkJGY09PR3BFMG5pNDlQ?=
 =?utf-8?B?Y1V0cEIvNitndkt6cm80NDRhWllwVWZnYlJvTTIrU3YyS1hzWTFzb0N5N3Q2?=
 =?utf-8?B?RUw5SVZFZEVGQzFkVmFabVAzb3ZHTjRSZ1N4UVpyUEVkaHB6dzVmaS84Nlcw?=
 =?utf-8?B?VGhzQXN1ZDNTaWV2V1JhSE56bGtNdW5SZDU1WlBYRHdtSEVzSkdwS0FOZUZh?=
 =?utf-8?B?b3c0cmZMRXdaUEdnSkx2LzdKWWd2WXhlREkwbVYzWU5XOEpudUZoS0JKWmtZ?=
 =?utf-8?B?S29XK3NRNWVNMEhvNGhidCt5ZDA3LzlJQ3hkcm4rS0R6dVk5OGErU3hLNllE?=
 =?utf-8?B?ZERMV3dGSmtndkZJaG9LZ29FVVNFMDNHTWo3QmFpWC8zRG1JWXMyMEcxMzJy?=
 =?utf-8?B?dXl6MUtlWTM0K3Z0dnNJWmZSVU1KZmlCeTlBaVBHYmhqbHZBMHgvYTkyaEdw?=
 =?utf-8?B?SVNFZURlZlhqdHpiTS81YlozQWdjQnd2QmZoOW9nVWpwd2haTWk2UE8raWxU?=
 =?utf-8?B?NkVEalNUenBEU1R2N0twaEpwaDdWcVlIbFM5Q3FsNGh4Q3JaaWIzNktJblZY?=
 =?utf-8?B?UHZkSVNFRlRzZm1vNjJqMm0wMUVwUWZFSDBvcDRZaEZWRnRLNUlJNDBzZklm?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F580EB380EFCE8429706A1267CB3F1A3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PBuvB+uDa5uj1HF2Yod61fUeWy1v4widNfIP1m9ZTYIQ0lB34V/j/GFvbfYRCWOuZjdFJ3Si72OD6PxkkT20OQFBFYlTLSrQrkJem5hiIkOiCgw+oglZyF7LHvJQSa3+IaZn+NBpf+atRzhWaGy91dIQzuP7bOlppAbaGMVlgRGcAaiLBp/3XDa5V09+3A6Hz0TSV1igaR29pNObUoGYo524Vnz2X5WShPWYLELnw8mnNILuPTv+foQRhLzdGvIiz37ESgEuj1TX4f3JWrAtaoRemvu9V6g86LSgdX9b1xMr26JUqDi5+r6cBOEqf9Tb/LDLApSaDzYPKj9TjEEd8ERuD25HI35p1XN8hN3/h9YsfhzvtUNJTXgW8+IahzgVHOyiMIUnPqENQEAdHwHlXdK5UIlvWffg9pEYkfzlCL8WK/SFRsyAMkfFI4/q11XIOOLsGbPLQy0ifoGiBV3QyHIWjZnqLHLhybPWvTNkqfkUiIctDhzKhg5QwQuT7Ck9yJFYZfbzJL6ZRR2rV8LUtgGR7DkRT2D5QnPfpjX+evkYQnmBjm6h43gKZlAqysl6C1H5Qb1PKEeyjWh9W5AD0Is/KPFFMcqOL7JpWqim0+/IsdtmOV6zpVoQ9bs7kuuG
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911a12d4-30bb-47be-71d8-08ddaa1f5a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 02:09:39.3224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZkKeIkipeaof/L3ipt0Sg2J+4QY5++4/JC5ap0ZKt5JsUqP+YNQSB2jmiMk8TeAfyYjQOS158OLZ9kipASULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15814

DQoNCk9uIDEyLzA2LzIwMjUgMjE6NDMsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IFByZXZp
b3VzbHkgdGhlc2Ugc29tZXdoYXQgZGV2aWNlIGxpa2Ugc3RydWN0dXJlcyB3ZXJlIHRyYWNrZWQg
dXNpbmcgYSBsaXN0DQo+IGluIHRoZSBDWExTdGF0ZSBpbiBlYWNoIG1hY2hpbmUuIFRoaXMgaXMg
cHJvdmluZyByZXN0cmljdGl2ZSBpbiBhIGZldw0KPiBjYXNlcyB3aGVyZSB3ZSBuZWVkIHRvIGl0
ZXJhdGUgdGhyb3VnaCB0aGVzZSB3aXRob3V0IGJlaW5nIGF3YXJlIG9mIHRoZQ0KPiBtYWNoaW5l
IHR5cGUuIEp1c3QgbWFrZSB0aGVtIHN5c2J1cyBkZXZpY2VzLg0KPiANCj4gUmVzdHJpY3QgdGhl
bSB0byBub3QgdXNlciBjcmVhdGVkIGFzIHRoZXkgbmVlZCB0byBiZSB2aXNpYmxlIHRvIGVhcmx5
DQo+IHN0YWdlcyBvZiBtYWNoaW5lIGluaXQgZ2l2ZW4gZWZmZWN0cyBvbiB0aGUgbWVtb3J5IG1h
cC4NCj4gDQo+IFRoaXMgY2hhbmdlIGJvdGggc2ltcGxpZmllcyBzdGF0ZSB0cmFja2luZyBhbmQg
ZW5hYmxlcyBmZWF0dXJlcyBuZWVkZWQNCj4gZm9yIHBlcmZvcm1hbmNlIG9wdGltaXphdGlvbiBh
bmQgaG90bmVzcyB0cmFja2luZyBieSBtYWtpbmcgaXQgcG9zc2libGUNCj4gdG8gcmV0cmlldmUg
dGhlIGZpeGVkIG1lbW9yeSB3aW5kb3cgb24gYWN0aW9ucyBlbHNld2hlcmUgaW4gdGhlIHRvcG9s
b2d5Lg0KPiANCj4gSW4gc29tZSBjYXNlcyB0aGUgb3JkZXJpbmcgb2YgdGhlIEZpeGVkIE1lbW9y
eSBXaW5kb3dzIG1hdHRlcnMuDQo+IEZvciB0aG9zZSB1dGlsaXR5IGZ1bmN0aW9ucyBwcm92aWRl
IGEgR1NMaXN0IHNvcnRlZCBieSB0aGUgd2luZG93IGluZGV4Lg0KPiBUaGlzIGVuc3VyZXMgdGhh
dCB3ZSBnZXQgY29uc2lzdGVuY3kgYWNyb3NzOg0KPiAtIG9yZGVyaW5nIGluIHRoZSBjb21tYW5k
IGxpbmUNCj4gLSBvcmRlcmluZyBvZiB0aGUgaG9zdCBQQSByYW5nZXMNCj4gLSBvcmRlcmluZyBv
ZiBBQ1BJIENFRFQgc3RydWN0dXJlcyBkZXNjcmliaW5nIHRoZSBDRk1XUy4NCj4gDQo+IE90aGVy
IGFzcGVjdHMgZG9uJ3QgaGF2ZSB0aGlzIGNvbnN0cmFpbnQuIEZvciB0aG9zZSBkaXJlY3QgaXRl
cmF0aW9uDQo+IG9mIHRoZSB1bmRlcmx5aW5nIGhhc2ggc3RydWN0dXJlcyBpcyBmaW5lLg0KPiAN
Cj4gSW4gdGhlIHNldHVwIHBhdGggZm9yIHRoZSBtZW1vcnkgbWFwIGluIHBjX21lbW9yeV9pbml0
KCkgc3BsaXQgdGhlDQo+IG9wZXJhdGlvbnMgaW50byB0d28gY2FsbHMuIFRoZSBmaXJzdCwgY3hs
X2Ztd3Nfc2V0X21tZW1hcCgpLCBsb29wcyBvdmVyDQo+IGZpeGVkIG1lbW9yeSB3aW5kb3dzIGlu
IG9yZGVyIGFuZCBhc3NpZ25zIHRoZWlyIGFkZHJlc3Nlcy4gIFRoZSBzZWNvbmQsDQo+IGN4bF9m
bXdzX3VwZGF0ZV9tbWlvKCkgYWN0dWFsbHkgc2V0cyB1cCB0aGUgbW1pbyBmb3IgZWFjaCB3aW5k
b3cuDQo+IFRoaXMgaXMgb2J2aW91c2x5IGxlc3MgZWZmaWNpZW50IHRoYW4gYSBzaW5nbGUgbG9v
cCBidXQgdGhpcyBzcGxpdCBkZXNpZ24NCj4gaXMgbmVlZGVkIHRvIHB1dCB0aGUgbG9naWMgaW4g
dHdvIGRpZmZlcmVudCBwbGFjZXMgaW4gdGhlIGFybTY0IHN1cHBvcnQNCj4gYW5kIGl0IGlzIG5v
dCBhIGhvdCBlbm91Z2ggcGF0aCB0byBqdXN0aWZ5IGFuIHg4NiBvbmx5IGltcGxlbWVudGF0aW9u
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbjxKb25hdGhhbi5DYW1lcm9u
QGh1YXdlaS5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWpp
dHN1LmNvbT4NClRlc3RlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K
DQo+IC0tLQ0KPiB2MTU6IERyb3AgdGhlIGxlZnQgb3ZlciBHTGlzdCAqZml4ZWRfd2luZG93cyBm
cm9tIENYTFN0YXRlLg0KPiAgICAgICBTcGl0IGN4bF9mbXdzX3NldF9tZW1tYXBfYW5kX3VwZGF0
ZV9tbWlvKCkgaW4gdG8gcmVtb3ZlDQo+ICAgICAgIG5lZWQgdG8gZG8gdGhpcyBpbiBuZXh0IHBh
dGNoLiBQYXRjaCBkZXNjcmlwdGlvbiBub3cgaGFzIGENCj4gICAgICAgcGFyYWdyYXBoIGp1c3Rp
ZnlpbmcgdGhpcyBkZXNpZ24gZGVjaXNpb24uICh0aGFua3MgWmhpamlhbiBMaQ0KPiAgICAgICBm
b3Igc3VnZ2VzdGluZyBpdCkuDQo+ICAgICAgIERyb3BwZWQgdGFncyBhcyB0aGlzIGlzIGEgbm9u
IHRyaXZpYWwgY2hhbmdlLg0KDQpbc25pcF0=
