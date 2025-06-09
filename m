Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72FDF59
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749431789; cv=fail; b=d0rYUA46Hxf/1PfTAjWDrwQH52VzNuTFox0K2wPQodXw9M9dhXfUDX08ow968e8CxAbORh3fACgPfHyYx73dqUoixnXkLzOBLUnmZwBkHP+kCgOp8cZEqDiwfel/Qe/DG+FiTbHINw29Iy1EbPdSbkPNMi4geK+FjvVKyRMaA3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749431789; c=relaxed/simple;
	bh=lMy378vckTNLmCEkTsvldC4QEhhHMViUxaabHCFC2KQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gwm7ewBv6YpwVnoZ973wdZvA4KJExrqbyQnJx8+Dca5VEofcI+jsVZbLZuIiVBbPEHFK21eIG/kLB+O1VGZekVS6XjIvXe2i73WaFtxP4MZ5MKBxY3shz9LG6OEZjwwtb65JGPugCGOZb51HrOgMY759OtWIodpTlGzIJ+96igo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Jx0lLlx+; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Jx0lLlx+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749431788; x=1780967788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lMy378vckTNLmCEkTsvldC4QEhhHMViUxaabHCFC2KQ=;
  b=Jx0lLlx+pkJEL02ClfwT4+CwqBDgxhDFRxkoME9dRPnM0B618a5uBABb
   9Vd/GJ/NPwnBTLcgVLS9bg+r3tMKsL2AWfYmsN3mMmbng+It7Pnes7agM
   RApZDYrt1XK7L2eehKniOyI2RdxIF89pe2ksxyK1gEKg+i2DSU6+HNH6Z
   UPfdWpkxlYy1+2bIooWZ58Igr92ZKS2+9j/wLExwjursxwIvpHSh4jFFr
   gxbJ8DCTTHilHZa/SC4uBvSOtjfnfZ3sC6VaVykrTWALVZsVbvejlhmJu
   h1xPKuavUFE6rBMA0PR8zmtrBrHCNyRQLDLtFqydY4R7Dz2oJxPKV/fUg
   A==;
X-CSE-ConnectionGUID: tb39yFv6RMOOshOU10iC8Q==
X-CSE-MsgGUID: enDGuhBFRd+UB3tSaaoUcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="164860620"
X-IronPort-AV: E=Sophos;i="6.16,221,1744038000"; 
   d="scan'208";a="164860620"
Received: from mail-japanwestazon11011055.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 10:15:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su9Wo5UG591qhx/rR5kTzOW4w1IYI3Aa54xZy74sbq3FQE3dBwuHeayrfiIQ+9KrC0nkzDFmJiAkgiNvEV6HIMihRIbs8xR0s8hI7SRP3oaku/S4t0w0P+C55QrnjUEsPjdq3uOn7fBPycmeMNvtNR7U7k23HnoX/Qjgsq/YqSGHegwrlxk2CZKDlsdflo5D+EiRn4VmEzS+RxFWFyRgS09tO9la0aVYPWNstxgRN2cjuv1aZ60MC0BbQ9CE4lLFIQidZxWc6SpSEIW+Rlvmrxg0R/0lCaenXh+vSLtLum/3znh8beJ4pWiF9Qc0B1hyQ2XnOrY6Jcs2QulAQ1mhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMy378vckTNLmCEkTsvldC4QEhhHMViUxaabHCFC2KQ=;
 b=TWqzODGxfy0IEwGV3VbStodPl5LO0BzDhgKZzYjtKj3s5rCnLRCYsi6RZUK8295kf838P8tcZmn8tqLdcfWaMKpIHzg+vQnmUrlgRnDgJ0Gz3SeL0Pf3M/TMHWaHuX2ClBlbvi6lmnJaBNpmIgWgICg4nJHdJZJzdc8GIcJe8tXtKHz8bn5BxUk/6h3ZSg24odH7/SPLDA3PTqujerOHR7Z65cSQknsBafZdJQRZuCCaZMjOXHSDlzackWDkv6Kjjfl4CaNtpJHLscPU+OySDMAzR+Aandy7akzfXFh9e05sce0oRIvsdPi2kmEYucYG0Enrm1KDxiw9FGpehs4erg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB1557.jpnprd01.prod.outlook.com (2603:1096:603:8::10)
 by TYWPR01MB8394.jpnprd01.prod.outlook.com (2603:1096:400:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 01:15:10 +0000
Received: from OSBPR01MB1557.jpnprd01.prod.outlook.com
 ([fe80::5178:3e63:18c:65e4]) by OSBPR01MB1557.jpnprd01.prod.outlook.com
 ([fe80::5178:3e63:18c:65e4%6]) with mapi id 15.20.8813.018; Mon, 9 Jun 2025
 01:15:10 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>
CC: "linuxarm@huawei.com" <linuxarm@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 3/5] hw/cxl-host: Allow split of establishing memory
 address and mmio setup.
Thread-Topic: [PATCH v14 3/5] hw/cxl-host: Allow split of establishing memory
 address and mmio setup.
Thread-Index: AQHbz8EDxOINQqSn90SjGzdvWTuUKLP6GF+A
Date: Mon, 9 Jun 2025 01:15:10 +0000
Message-ID: <ce28ad6b-a76a-44d7-8135-9560e8e1d6f8@fujitsu.com>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
 <20250528110726.226389-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250528110726.226389-4-Jonathan.Cameron@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB1557:EE_|TYWPR01MB8394:EE_
x-ms-office365-filtering-correlation-id: 2c73baff-5e44-45a5-a1cf-08dda6f3147c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?elZudjZnYys1dmRLZ1FHRk1mSVhaUnlPbXZYUWlNYk1nRWVSTWQ4S0wvakx2?=
 =?utf-8?B?SFQ5cENKaVk0dG8zVlVRR3Jtc3l2T3RQSEc0TGQzamhrc0lRSHBKSnVSTUVu?=
 =?utf-8?B?TEJIdXkrekIrRUlLOUZYTWx4WFkxTTNGRnl0ZGIwMDRySWZoTW5YazhMcUNa?=
 =?utf-8?B?TGRYMExMamY0WnJ5UjYrV0kxeSt1RHQxUEpNcmVSV0NpVC9LQ3BQdzdVSGVk?=
 =?utf-8?B?eVA1ZGRNWExwNXJoQ1JhMC91dVdRbjRTdlFiR0lxMnpkdUptWnFtWHhDOTBE?=
 =?utf-8?B?ZE53aUZKUWQwT1RDaTNjSDR2YmVTekVGdGUyZ3RSb2xXQTducFY4VTZSalhC?=
 =?utf-8?B?ZSsxMzdWZFRZTmtJYWFQMzMzSkhGWmFKVHJlaWtsSVhrYW5GV1FaZXJqRFBs?=
 =?utf-8?B?ZzBCWTRMSTJHSFFhYUdDb3BwOUxyS2l4SVg2VU8za3pUZTBMZ1c1ZzdFajcw?=
 =?utf-8?B?SHhqa3FqSTRNODhHOUxGRjFIdktGVGJVK2NtbnBsSjJ3cTZvOFB4WGtDL2hI?=
 =?utf-8?B?TEFlQllQOE5IYmFtakZEeEJ1ekJFYUxUcDZkazI5RTFWL1pHU1Z2NmpjZmx4?=
 =?utf-8?B?S3JPRW5UTkhqL211S3NhNGNmTWFyRUF5N2hRb3cxdVdMWGpIdzV1eU8yWXJN?=
 =?utf-8?B?KzRXc29zaWFidHQzcFBiQk9sTG1TWndYVFl5TlRaZFU5Wm5TZ0FLNFYwdUtI?=
 =?utf-8?B?VDJzLzRGUW9jTW9lbEpDVHJreDcxVVdRNUpsTi8vQ2ZEV0RublRxc2dPZlBT?=
 =?utf-8?B?Mzgxek5ranVhQ2VudzJERSswMlVVMnF5bmw4aVgvNmZ2aEVQam50TDFRUmxZ?=
 =?utf-8?B?VmUzQ2UxR0dPTE5UM2NNb2liVWFrQ2J3amxvUDJYUzh1SkJxckhiL0hnbGdj?=
 =?utf-8?B?eDFOUWtUTVV4b0pERjVSV21CNVBBL3EvbUx0VW1Mb095MTlFNEdxUU1qaW5R?=
 =?utf-8?B?S0piNmY5VVFIbVEzUEExcXZaMjBsWlVBb3ZWVHpNRzdmdVlFYXVpZEsyWTJu?=
 =?utf-8?B?cUtMc2dmZ0xwbTZBZll2ckFxRmgwclZwNHJNYlJxRC9ZNzhhYnUvWWNlNXgz?=
 =?utf-8?B?VE4wYXRPU0N5dW5xODVKa3dLdU8vUEdheEZoeGVCaHh5VVl1OURvYWVaNWdV?=
 =?utf-8?B?ODI4MWgvWmtxNTZGckVFblphekxsM2dIaWhaTlR1T1pmd3ozMmxDejI3cFRn?=
 =?utf-8?B?K3I5alpNUU5HbXZxSFhZMkUzbFJTWmZINFdKOHhDNHN6eURVcm10U3EyZlZq?=
 =?utf-8?B?TVVJNEEwR2djbTg4UHVhL2dUTFpTQWxWd21XMVNTWEFMZERqNTJxY1ZYaXc1?=
 =?utf-8?B?Nm1zVXNZUUl4bFczay91eWlqTDNwQmx5M3Q1M0lFV0UrOUNHVDlQTUV2Y2tG?=
 =?utf-8?B?dmdCUzFGMnljOUl4QW44REdnR0tEalZYTi9OaTNEWC8yUzVQcUx1UlIwR0Yz?=
 =?utf-8?B?UFhRMXpvbDNTZU5YOWsvMzNJejJsdHZJdWRPR081MnZybFdUbjd0QVV5ckRt?=
 =?utf-8?B?VDB5SGs3NEhJZkkrczh0d2w5NUJUT2E2MjlkYVZ5T0ZzVXBHaHNWbFRxcHlC?=
 =?utf-8?B?cGVpOWZxY3l5eGRNMFNIVDNlTmRoTnhoN0t6ZGh3aVc5Y2pnbDlZY3U4aGcy?=
 =?utf-8?B?OEVScG85YkNCL1VOZUxuaWZBcnJCTjU3Q29WRHJQeEltcDFkd2tLRW5GVXpB?=
 =?utf-8?B?RkQ2L2didWJ2WnhzYlhxVW9NblJVNHRCU1NMcUVCZWs5L3FxRU5Ga29OcUlx?=
 =?utf-8?B?b09jSWIrL2hJUVF0ejB4MXlibldHVWM0cFBVbjVod3dZUGg0dkJjd2dXS1gy?=
 =?utf-8?B?U1dkRnVaUzRocTdhMkZPak53dllFN0hpbmhIeUhqVnluNlQwZlhkRENiVUxB?=
 =?utf-8?B?V241N1FTLzIwb2RqVUt3QVFERE9pc2xzakdYMVZDYmtKcWpkbkw4UzY1NUR3?=
 =?utf-8?B?c2svZkEyZnM5Rkg1dGgwLzVUM1g5ejF4Um0ydEdmOXFTRmkxT0cwVk9PZ3JI?=
 =?utf-8?B?SC8wZXBWSnZ2MDhhdzBlUUNjQm5CWDUzYXcrV05pdGd1cVhra3haUFNkQjRq?=
 =?utf-8?Q?ZMAwQV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB1557.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RU40cTJha2ExMG1GK0F4dVlNV1J4Z0pzVUt2ZFlTTks3MHc2SXhxYkJHOTly?=
 =?utf-8?B?THRjNFVra3BtRERVU2lIYWMzRjNTYmZYQVZVRWlFd2tKY2JRWTlQc2kzVDYr?=
 =?utf-8?B?YkhwTVA2TW9HV2hyQ0VwNXRJSXBjMEVwcG1nL2haZVJkcUw4WXM2bjlYWk13?=
 =?utf-8?B?N1ovcDNXY1RCYS9tWWJIdVFWaWxoeGhmQThnQjN4d2w4VkYvSXIrRUpWb1lK?=
 =?utf-8?B?R3RBUURhZ01xMU92VDlES0NsYmduRGtUcEZQb3BMbW1qaXM4cjhKdVJKdkpt?=
 =?utf-8?B?Mk9jSGhzdGYwZFZCa09KYis5RUVjRld6ZGc4Y3ZmZUtsSUlYTEVsbCtvWHJ0?=
 =?utf-8?B?bkRqbGZQbU9oc1k1ZktUa052Z21VT1NqUjVlVWZJRGlSZjArTm9xWDR5MVE0?=
 =?utf-8?B?OVU4VEZoT0NWLytMZmIwTjBuUDNGS0V3WHN1VHF1ZDFUaTI2dHBRL1pXT0M0?=
 =?utf-8?B?OWZsOThsZk8xZ0htTTlYWUUyeXMvR2tWOHBFTjJjR2FuNW9KVURVSE9RTy9i?=
 =?utf-8?B?NXloRzJzZXNMK2dSaFJ1aWh5dk5XZGJoQWhVS2t1V1Jremk2VHJjOVR4MHdQ?=
 =?utf-8?B?SEdkbDl3SVFBRXd6TkYvakJmTnMzUEZZRlZ2anZwYk1uTDY2eGtkOFhnbDB5?=
 =?utf-8?B?VVVZc3BsVkFhV3U4dUV0eEV1NWtCY1N4bEdhOTNpUG54VmNTc0kzNlNrT2lP?=
 =?utf-8?B?T0xjKzhFQ25xTm1vVVBmT2VHZmw4NDZvMDgyb2ZQSHFZd3FLT1Qwd2MrTjhw?=
 =?utf-8?B?YUVpUXcrSFppa21MeEVxUFRvOUd5QVlzQjRRdENNMWRjaVBEYXdKd1ZCN0p6?=
 =?utf-8?B?bFVVTWx3aWFCbkwzdnVnamlvd3IxNHpGbE5FZys5c0hHZHJDUGlzZjlJQ0RK?=
 =?utf-8?B?ZGJDRVNIMElMQ216Wmo2eGxneEtYZmJ5Mkd4UG1oZjRFWGRrd0xrN3FhanVU?=
 =?utf-8?B?eStqb3g5WXF3RGU3OUgxOURpcWNNZFZNckdrYk9TQlZ2VzQrdGVGTldOeGpk?=
 =?utf-8?B?Qi9GSGZiYVdwK2l2ay9yYkRubm9LMmRqM1dWR3F6Sng5QmYrYWZNSTkycCtB?=
 =?utf-8?B?b1FNVWhLaHU0ZXR3anE2d1d4ZFJldmluSG9adk1tVG9FNDduS1I5Vy9LeUgr?=
 =?utf-8?B?ZGFjL0ZzSGo0VTBNOGhvMkxjYVNXd3V4a3BSeCtkMEhuVW9GYTM1T3pmeDc2?=
 =?utf-8?B?NHh6SW1JRTdZVkdaQ3dZTVg0d21oLzV1bTFPeDBGOXc4NzBaTFU3RHRZcVhF?=
 =?utf-8?B?bVFvSEkyYzFNK3d0TGdoK1Z2SWpLR2xHSmovb0ZLWEd2cnBlZHcrdlVhSm96?=
 =?utf-8?B?eE9UZGtUbkluR0tUbDlURjJaYkpVWi9NZDlSa2pHMTlmcWFkMm1LK3ZrVjNp?=
 =?utf-8?B?QXVic0M3emxXby8zR1VweUVJVk1uYnZldGdMa0ZQTmpvM3BkOWJ1cDZsTyty?=
 =?utf-8?B?V0svUDlBaUM3NHJFN0hIelM5Tk1CN2lBaTczN0d6STZpMnNQeDliL2FYR0px?=
 =?utf-8?B?Zyt0bE9VOE1CRGlSNmVadldheWtvaVN1eDVqQWJ3MHZ5dlhFK3VjckgrYW5N?=
 =?utf-8?B?T2hVLzdTTkc4U2sxejZhanhjVzZmSVk1alUzWWZLOG9IWGFoSHgxVXRVUGlP?=
 =?utf-8?B?cmxJcXFXYUdSWG96NkhoQy9kTldXeTdWeTlHbkxoOEI0anV2V3ZHWXhwMWtQ?=
 =?utf-8?B?K1hSbVAxMndFWGc4S3hmWFlFUzJYbEJQQWl6RXl3TkNQY0ZWcUppalZqNklS?=
 =?utf-8?B?NGhWZldySjZTc1FNNmF0UlBPSjJaMlJFTVFjVDNiRE4zK09XYXo3aE5zalpa?=
 =?utf-8?B?ZGYwUVkxNVdhZDREKzRUZ2RpSjBGWG4vcWFlWThVK09nTG9Ca20zVXlYbktU?=
 =?utf-8?B?MTd0d21kczVuQnFSVWx2TElCdUhvdnRnTjZrSDBPc1lLZU5pMktLR1NGbnRl?=
 =?utf-8?B?ZkplT2ZZbTFFU1RFK0J5SytWVjU5VGhRL3M0QWFJUWtESG1RK0dLWm9mWEdu?=
 =?utf-8?B?RWo3UkdIKzVTQVJnYTZ0R2J5OGwwcFlGc2hLclNrYjFlV3ppdkN1TDRia3di?=
 =?utf-8?B?QmJTNW1EaHc2Z2xIVXR1czBQQjBWT1hEMisyQUpBQ3AyRVFZTTdhM2ZPdldm?=
 =?utf-8?B?OWtqN2dOY2pNd0Y0bFgwTmx5Y0JpZisvMHoyVm1KWHU2NXphNXVBbFV1UVhh?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <538D8732EB9985428C0741E495BBD79F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6zuSm9qN9evJsgdZdaQATsaEvz3eF0XHQB0bCSQZlq4aJP8h5/D2dvhYpRMqYyMN1BtTU3rxOVgo2+PCtZ8zR2IDkpKCq+IEGgdN4uqtm0jBZRK58rSQqmeKrcnzmL+D361h+Ec4mBNrEF19gPXhBmIsPUvInna30t9dVE5pZx5xi2Gz6DeuW5BCmvglGVkndYD0sknjckqSPsHg86Uy5CEUDzimMdTDL+lqzINHVQOjO09jycXXKQPaUV2+9OAzgUOxfjE7jtDBg1EfXvXbiHTCMvlSbTI/nAT+VqAdw+Zp4KxFNhBZh5EVibVItLq2OeTzCQ+21hphs2Duo0Ub72PJMcquR6xcahuAVD96KUY1qi/uuflxDoqHbHj7fxqnmsakrEvIUqLs86cpW9F+7Kap0WkG4yAcW/Ov2K6P8Y0PGrypjDVGYMJE2bKWWtU0OGYp0mAXGcHxB5lznqOqIBg9+R8wGb0y5JTzwE98Y8jgPBLbZt1QfyRT2iOeUaOMyrdClGun+g9SopfPLGHFIpRlLe5X3qHlKus5X3XzNwXDjkmwtWwMq4CKdl6gZsXQSDk4U7XjYHvvwooW66EpZoY6xcp607Vehdwn0argmQflUr4VrOKQ1+yG3mBRnU3O
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1557.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c73baff-5e44-45a5-a1cf-08dda6f3147c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 01:15:10.7255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEoV2kcvsFpot1H8pzRyLhrNnmul2XBbb/WCRHviLsVthA4wS4ZYVYerwGL0AZpdeUk7Eo6VXLeQfQAcnVpcGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8394

DQpJbiBwYXRjaCAyLzUsIHdlIGludHJvZHVjZWQgYGN4bF9mbXdzX3NldF9tZW1tYXBfYW5kX3Vw
ZGF0ZV9tbWlvKClgLg0KDQpJbml0aWFsbHksIEkgYXNzdW1lZCBwYXRjaCAzLzUgd291bGQgc3Bs
aXQgYGN4bF9mbXdzX3NldF9tZW1tYXBfYW5kX3VwZGF0ZV9tbWlvKClgIGludG8gdHdvIHN0ZXBz
Og0KMS4gVHJhdmVyc2UgQ1hMRml4ZWRXaW5kb3cgYW5kIHVwZGF0ZSBgZnctPmJhc2VgLg0KMi4g
Q2FsbCBgc3lzYnVzX21taW9fbWFwKFNZU19CVVNfREVWSUNFKGZ3KSwgMCwgZnctPmJhc2UpYC4N
CkZvciBleGFtcGxlIChteSBwZXJzb25hbCBwcmVmZXJlbmNlKToNCmBgYGMNCmh3YWRkciBjeGxf
Zm13c19zZXRfbWVtbWFwX2FuZF91cGRhdGVfbW1pbyhod2FkZHIgYmFzZSwgaHdhZGRyIG1heF9h
ZGRyKQ0Kew0KICAgICBod2FkZHIgZW5kID0gY3hsX2Ztd3Nfc2V0X21lbW1hcChiYXNlLCBtYXhf
YWRkcik7DQogICAgIGN4bF9mbXdzX3VwZGF0ZV9tbWlvKCk7DQogICAgIHJldHVybiBlbmQ7DQp9
DQoNCg0KSWYgd2UgaGFkIGltcGxlbWVudGVkIHRoaXMgZGVzaWduIGluIHBhdGNoIDIvNSwgcGF0
Y2ggMy81IG1pZ2h0IG5vdCBiZSBuZWNlc3NhcnkuDQpUaGUgb25seSBwb3RlbnRpYWwgYmVuZWZp
dCBJIHNlZSBpbiB0aGUgY3VycmVudCBwYXRjaCAzLzUgaXMgZWZmaWNpZW5jeSBpbXByb3ZlbWVu
dHMNCmluIGN4bF9mbXdzX3NldF9tZW1tYXBfYW5kX3VwZGF0ZV9tbWlvKCksIGJ1dCBzaW5jZSB0
aGUgZnVuY3Rpb24gaXMgdHlwaWNhbGx5DQpjYWxsZWQgb25seSBvbmNlIGFuZCB0aGUgR0xpYiBs
aXN0IChnbGlzdCkgaXMgc21hbGwsIHRoZSBwcmFjdGljYWwgaW1wYWN0IHNob3VsZA0KYmUgbWlu
aW1hbC4NCg0KSSdtIGludGVyZXN0ZWQgaW4gb3RoZXJzJyBwZXJzcGVjdGl2ZXMgb24gdGhpcy4N
Cg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KT24gMjgvMDUvMjAyNSAxOTowNywgSm9uYXRoYW4gQ2Ft
ZXJvbiB2aWEgd3JvdGU6DQo+IE9uIGFybS92aXJ0IHRoZSBtZW1vcnkgbWFwIGlzIHNldCB1cCBi
ZWZvcmUgYW55IGRldmljZXMgYXJlIGJyb3VnaHQNCj4gdXAuICBUbyBlbmFibGUgdGhpcyBwcm92
aWRlIHNwbGl0IGZ1bmN0aW9ucyB0byBlc3RhYmxpc2ggdGhlIGZ3LT5iYXNlDQo+IGFuZCBsYXRl
ciB0byBhY3R1YWxseSBtYXAgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1l
cm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiB2MTQ6IFVwZGF0ZSB3
cnQgdG8gY2hhbmdlcyBpbiBwcmV2aW91cyBwYXRjaC4NCj4gICAgICAgQWRkIGEgZG9fY2Z3bXNf
c2V0X21lbW1hcF9hbmRfdXBkYXRlX21taW8oKSB1dGlsaXR5IGZ1bmN0aW9uDQo+ICAgICAgIHRv
IHJlZHVjZSBjb2RlIGR1cGxpY2F0aW9uLiAoWmhpamlhbikNCj4gLS0tDQo+ICAgaW5jbHVkZS9o
dy9jeGwvY3hsX2hvc3QuaCB8ICAyICsrDQo+ICAgaHcvY3hsL2N4bC1ob3N0LXN0dWJzLmMgICB8
ICAyICsrDQo+ICAgaHcvY3hsL2N4bC1ob3N0LmMgICAgICAgICB8IDQzICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2N4
bC9jeGxfaG9zdC5oIGIvaW5jbHVkZS9ody9jeGwvY3hsX2hvc3QuaA0KPiBpbmRleCA2ZGNlMmNk
ZTA3Li5hZWU5ZDU3M2Q2IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2N4bC9jeGxfaG9zdC5o
DQo+ICsrKyBiL2luY2x1ZGUvaHcvY3hsL2N4bF9ob3N0LmgNCj4gQEAgLTE2LDYgKzE2LDggQEAN
Cj4gICB2b2lkIGN4bF9tYWNoaW5lX2luaXQoT2JqZWN0ICpvYmosIENYTFN0YXRlICpzdGF0ZSk7
DQo+ICAgdm9pZCBjeGxfZm13c19saW5rX3RhcmdldHMoRXJyb3IgKiplcnJwKTsNCj4gICB2b2lk
IGN4bF9ob29rX3VwX3B4Yl9yZWdpc3RlcnMoUENJQnVzICpidXMsIENYTFN0YXRlICpzdGF0ZSwg
RXJyb3IgKiplcnJwKTsNCj4gK2h3YWRkciBjeGxfZm13c19zZXRfbWVtbWFwKGh3YWRkciBiYXNl
LCBod2FkZHIgbWF4X2FkZHIpOw0KPiArdm9pZCBjeGxfZm13c191cGRhdGVfbW1pbyh2b2lkKTsN
Cj4gICBod2FkZHIgY3hsX2Ztd3Nfc2V0X21lbW1hcF9hbmRfdXBkYXRlX21taW8oaHdhZGRyIGJh
c2UsIGh3YWRkciBtYXhfYWRkcik7DQo+ICAgR1NMaXN0ICpjeGxfZm13c19nZXRfYWxsX3NvcnRl
ZCh2b2lkKTsNCj4gICANCj4gZGlmZiAtLWdpdCBhL2h3L2N4bC9jeGwtaG9zdC1zdHVicy5jIGIv
aHcvY3hsL2N4bC1ob3N0LXN0dWJzLmMNCj4gaW5kZXggMTNlYjZiZjZhNC4uZDllMzg2MThkNiAx
MDA2NDQNCj4gLS0tIGEvaHcvY3hsL2N4bC1ob3N0LXN0dWJzLmMNCj4gKysrIGIvaHcvY3hsL2N4
bC1ob3N0LXN0dWJzLmMNCj4gQEAgLTExLDYgKzExLDggQEANCj4gICB2b2lkIGN4bF9mbXdzX2xp
bmtfdGFyZ2V0cyhFcnJvciAqKmVycnApIHt9Ow0KPiAgIHZvaWQgY3hsX21hY2hpbmVfaW5pdChP
YmplY3QgKm9iaiwgQ1hMU3RhdGUgKnN0YXRlKSB7fTsNCj4gICB2b2lkIGN4bF9ob29rX3VwX3B4
Yl9yZWdpc3RlcnMoUENJQnVzICpidXMsIENYTFN0YXRlICpzdGF0ZSwgRXJyb3IgKiplcnJwKSB7
fTsNCj4gK2h3YWRkciBjeGxfZm13c19zZXRfbWVtbWFwKGh3YWRkciBiYXNlLCBod2FkZHIgbWF4
X2FkZHIpIHsgcmV0dXJuIGJhc2U7IH07DQo+ICt2b2lkIGN4bF9mbXdzX3VwZGF0ZV9tbWlvKHZv
aWQpIHt9Ow0KPiAgIGh3YWRkciBjeGxfZm13c19zZXRfbWVtbWFwX2FuZF91cGRhdGVfbW1pbyho
d2FkZHIgYmFzZSwgaHdhZGRyIG1heF9hZGRyKQ0KPiAgIHsNCj4gICAgICAgcmV0dXJuIGJhc2U7
DQo+IGRpZmYgLS1naXQgYS9ody9jeGwvY3hsLWhvc3QuYyBiL2h3L2N4bC9jeGwtaG9zdC5jDQo+
IGluZGV4IDAxNmE0ZmRjNmEuLmExYjk5ODAwMzUgMTAwNjQ0DQo+IC0tLSBhL2h3L2N4bC9jeGwt
aG9zdC5jDQo+ICsrKyBiL2h3L2N4bC9jeGwtaG9zdC5jDQo+IEBAIC0zNzgsMTEgKzM3OCwxNCBA
QCB2b2lkIGN4bF9ob29rX3VwX3B4Yl9yZWdpc3RlcnMoUENJQnVzICpidXMsIENYTFN0YXRlICpz
dGF0ZSwgRXJyb3IgKiplcnJwKQ0KPiAgICAgICB9DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIHZv
aWQgY3hsX2Ztd3NfdXBkYXRlKENYTEZpeGVkV2luZG93ICpmdywgaHdhZGRyICpiYXNlLCBod2Fk
ZHIgbWF4X2FkZHIpDQo+ICtzdGF0aWMgdm9pZCBjeGxfZm13c191cGRhdGUoQ1hMRml4ZWRXaW5k
b3cgKmZ3LCBod2FkZHIgKmJhc2UsIGh3YWRkciBtYXhfYWRkciwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBib29sIHVwZGF0ZV9tbWlvKQ0KPiAgIHsNCj4gICAgICAgaWYgKCpiYXNl
ICsgZnctPnNpemUgPD0gbWF4X2FkZHIpIHsNCj4gICAgICAgICAgIGZ3LT5iYXNlID0gKmJhc2U7
DQo+IC0gICAgICAgIHN5c2J1c19tbWlvX21hcChTWVNfQlVTX0RFVklDRShmdyksIDAsIGZ3LT5i
YXNlKTsNCj4gKyAgICAgICAgaWYgKHVwZGF0ZV9tbWlvKSB7DQo+ICsgICAgICAgICAgICBzeXNi
dXNfbW1pb19tYXAoU1lTX0JVU19ERVZJQ0UoZncpLCAwLCBmdy0+YmFzZSk7DQo+ICsgICAgICAg
IH0NCj4gICAgICAgICAgICpiYXNlICs9IGZ3LT5zaXplOw0KPiAgICAgICB9DQo+ICAgfQ0KPiBA
QCAtNDIxLDE5ICs0MjQsNTEgQEAgR1NMaXN0ICpjeGxfZm13c19nZXRfYWxsX3NvcnRlZCh2b2lk
KQ0KPiAgICAgICByZXR1cm4gZ19zbGlzdF9zb3J0X3dpdGhfZGF0YShjeGxfZm13c19nZXRfYWxs
KCksIGNmbXdzX2NtcCwgTlVMTCk7DQo+ICAgfQ0KPiAgIA0KPiAtaHdhZGRyIGN4bF9mbXdzX3Nl
dF9tZW1tYXBfYW5kX3VwZGF0ZV9tbWlvKGh3YWRkciBiYXNlLCBod2FkZHIgbWF4X2FkZHIpDQo+
ICtzdGF0aWMgaHdhZGRyIGRvX2N4bF9mbXdzX3NldF9tZW1tYXBfYW5kX3VwZGF0ZV9tbWlvKGh3
YWRkciBiYXNlLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBod2FkZHIgbWF4X2FkZHIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgdXBkYXRlX21taW8pDQo+ICAgew0KPiAg
ICAgICBHU0xpc3QgKmNmbXdzX2xpc3QsICppdGVyOw0KPiAgIA0KPiAgICAgICBjZm13c19saXN0
ID0gY3hsX2Ztd3NfZ2V0X2FsbF9zb3J0ZWQoKTsNCj4gICAgICAgZm9yIChpdGVyID0gY2Ztd3Nf
bGlzdDsgaXRlcjsgaXRlciA9IGl0ZXItPm5leHQpIHsNCj4gLSAgICAgICAgY3hsX2Ztd3NfdXBk
YXRlKENYTF9GTVcoaXRlci0+ZGF0YSksICZiYXNlLCBtYXhfYWRkcik7DQo+ICsgICAgICAgIGN4
bF9mbXdzX3VwZGF0ZShDWExfRk1XKGl0ZXItPmRhdGEpLCAmYmFzZSwgbWF4X2FkZHIsIHVwZGF0
ZV9tbWlvKTsNCj4gICAgICAgfQ0KPiAgICAgICBnX3NsaXN0X2ZyZWUoY2Ztd3NfbGlzdCk7DQo+
ICAgDQo+ICAgICAgIHJldHVybiBiYXNlOw0KPiAgIH0NCj4gICANCj4gK2h3YWRkciBjeGxfZm13
c19zZXRfbWVtbWFwKGh3YWRkciBiYXNlLCBod2FkZHIgbWF4X2FkZHIpDQo+ICt7DQo+ICsgICAg
cmV0dXJuIGRvX2N4bF9mbXdzX3NldF9tZW1tYXBfYW5kX3VwZGF0ZV9tbWlvKGJhc2UsIG1heF9h
ZGRyLCBmYWxzZSk7DQo+ICt9DQo+ICsNCj4gK2h3YWRkciBjeGxfZm13c19zZXRfbWVtbWFwX2Fu
ZF91cGRhdGVfbW1pbyhod2FkZHIgYmFzZSwgaHdhZGRyIG1heF9hZGRyKQ0KPiArew0KPiArICAg
IHJldHVybiBkb19jeGxfZm13c19zZXRfbWVtbWFwX2FuZF91cGRhdGVfbW1pbyhiYXNlLCBtYXhf
YWRkciwgdHJ1ZSk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgY3hsX2Ztd3NfbW1pb19tYXAo
T2JqZWN0ICpvYmosIHZvaWQgKm9wYXF1ZSkNCj4gK3sNCj4gKyAgICBzdHJ1Y3QgQ1hMRml4ZWRX
aW5kb3cgKmZ3Ow0KPiArDQo+ICsgICAgaWYgKCFvYmplY3RfZHluYW1pY19jYXN0KG9iaiwgVFlQ
RV9DWExfRk1XKSkgew0KPiArICAgICAgICByZXR1cm4gMDsNCj4gKyAgICB9DQo+ICsgICAgZncg
PSBDWExfRk1XKG9iaik7DQo+ICsgICAgc3lzYnVzX21taW9fbWFwKFNZU19CVVNfREVWSUNFKGZ3
KSwgMCwgZnctPmJhc2UpOw0KPiArDQo+ICsgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3Zv
aWQgY3hsX2Ztd3NfdXBkYXRlX21taW8odm9pZCkNCj4gK3sNCj4gKyAgICAvKiBPcmRlcmluZyBp
cyBub3QgcmVxdWlyZWQgZm9yIHRoaXMgKi8NCj4gKyAgICBvYmplY3RfY2hpbGRfZm9yZWFjaF9y
ZWN1cnNpdmUob2JqZWN0X2dldF9yb290KCksIGN4bF9mbXdzX21taW9fbWFwLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRp
YyB2b2lkIGN4bF9mbXdfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+
ICAgew0KPiAgICAgICBDWExGaXhlZFdpbmRvdyAqZncgPSBDWExfRk1XKGRldik7
