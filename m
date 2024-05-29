Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113E13DDB1
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982506; cv=fail; b=lwzLtcchboM/iXI76pSw+4pBa25J7ioqB07lOUH5pFksDKZ3mBrIZIzTYDNDQufaZo+KwVrm/AnSWRInMR+DVhz7Xf7oP6M1WJjcAxphcxmBh6FFXmCg/Whlj+hEvFKN3UaOUZFRJdN5xvY9HJ3Qf9ZusAd2P9t8v9jQcTUU0A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982506; c=relaxed/simple;
	bh=vzbIHbSNTc4l9bly6Eksqd7VAu6VCbiw3KP+n8SHpWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YzkV2AIMKmmcNDgMu7w3geUeMPmCDDVZuazJ6XKs+XLuoSfi9kJyB+0whfVIHzE1RW1/Oo7RaosxhWTQ7ctJSN/Uka5HpbKU5e9Z+B74YwYqIXcu9nB028tjMLrasAkcbJ9wy0tKGqyB/PtrKI6p00FRDGAhaXJtGtpOKvZ5ObM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GuOq2O7t; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GuOq2O7t"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1716982503; x=1748518503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vzbIHbSNTc4l9bly6Eksqd7VAu6VCbiw3KP+n8SHpWc=;
  b=GuOq2O7tPEag7CmiJni5Q9IdzXQ9x08hAOuWzecECv/mTgggo0XbMosD
   SyN4GULssD9O0BLC8uBqPp4sW/oKZ0wTimv/giUVSd+LiZ16y09D+dhDC
   N5wv7R5ISHmHpp4QKjLq/BvB6CZOqsfzsqO0ikbHlKI8RXv16O3RHgtBf
   ccKWYCRDV2dwaRHxs+wM4hNEuVgDhRaR16j5kVqrz6qddjOJl4xULMNUC
   1yeC4C0h+CFgOsizkYgRCP0G+ERD0vKY8QM42S11gUHN6whZQlHlXyOLe
   0a9JYWjPbRCf2iDoU2bAZRFKzVjiJIX4DV1g2aJbEXPBVZql4+0ZcBjLZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="120341230"
X-IronPort-AV: E=Sophos;i="6.08,198,1712588400"; 
   d="scan'208";a="120341230"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 20:33:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRy1PHJPRHGhg/6S2fmQ4MQJR6I7kiU2eCiioseQWibME2AwOvnLbRlA+1f5p7iOHHpw5K1339t6i9S6K2Yk/axP8CYAgEWoB6zFY3+7reOo9ZbD1npdSTl5SVn52PA7gO9Io4yZfSXfbOHYpvuPZpBK+yVok5S3Ou7h4GI0Crfabp9h/v8wsfAWqByrJj172HjtKL63pfTjU2AZzGkiILEp934sQxbin16bJ1Xs7Mtjyg1OKWOTYGc/PnNT6qB5O60X044PtYwEsVCW0jNiXqxdACsKtFfwOFoELyVIuE1IuYpuOwFZtt8KyqC2HpOkd+qH54Xx/TqDMQio+sQEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzbIHbSNTc4l9bly6Eksqd7VAu6VCbiw3KP+n8SHpWc=;
 b=ZUsYo59qz+8tK38LCy3q+l9cbMYkY3HQRynpox/sMb/UYIO3QqvOuyQMa5flL8auSUGnZoAGWx6hKWNB5Df2Y+Sr1Nioxy+3+U9d3cD27j5Fgsy7QDtNn3ilfvwqW2OvEmHv2qIyE03XHqPZYhbZIP/AHJWnqSLv4iOwuXVGg4KQzxaupKYlsrAL21Gmmspi+Q9yA1z9AIrR8Xuw1/XeM/o1DvBbn0ZugnnA8wEI9QcEJJZhPbhykbeCEDulO0siO+qSmy/PLiF0VBZ5PxCUeStWCmTgQDIjkJIZfWEajg2Q9b9bnJ7YsuB//38vkkhHUW0xUEj8kWHiUg8a03fFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TYCPR01MB10278.jpnprd01.prod.outlook.com (2603:1096:400:1d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 11:33:46 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::9a0b:13f0:812b:69f5]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::9a0b:13f0:812b:69f5%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 11:33:46 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: RE: CXL volatile memory: How to restore the previous
 region/Interleave set
Thread-Topic: CXL volatile memory: How to restore the previous
 region/Interleave set
Thread-Index: AQHarax7vZq9IL+jF06rZcpjK4vT97GtbiqAgABxLGA=
Date: Wed, 29 May 2024 11:33:46 +0000
Message-ID:
 <TYWPR01MB10082738078CF843AF514F7E790F22@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
 <6656801ef0dea_1668729484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <6656801ef0dea_1668729484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MzA1ODA1Y2EtMGUwNC00YzQ4LThiMzYtYTllODdmMzAx?=
 =?utf-8?B?OGRmO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA1LTI5VDExOjI5OjMzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: d0ab7aea8bb646eab5a390cf4cfe9180
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TYCPR01MB10278:EE_
x-ms-office365-filtering-correlation-id: 6adb2c14-6ade-4c7d-fc07-08dc7fd333e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|366007|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1M5ZGQvYm9hRGpCenFmUDAwNEUrcVpxZkpnU09IL01OVjNLbTJQSW1yMVV2?=
 =?utf-8?B?b2lJVllkdjFKeVRQUXBRNVpjYnZBYkdoSU1neEhSaWRyRjU4SXVGelJlb09N?=
 =?utf-8?B?dXRGK0M3L0JxUE8vKy82T3B4NGkrWWxmOW1vLzhOamsrNnhvcHZGdzAxeFR6?=
 =?utf-8?B?MzUzRkRVU0RKb2labzBMZDU4dTIvL3dOeXBrUzVwOFp4NXdrckYxOUhXZ0lR?=
 =?utf-8?B?dEwxa3R0NmlLREptQTRDcWxaa1p3NXI2MG1QRERiTWg0RGhoOHpscFdQVFNV?=
 =?utf-8?B?QWFiMWhQME90NWVzUkxybjZrcmJKVFdPcGpjeXJvRUpCY3k1NERjd2twWmRI?=
 =?utf-8?B?bUhnck1sOVBLZ0Zkcnl6RnJHcjFEd2NkRGRrbnIrYnRjSGhRMTNiQUFtUXVY?=
 =?utf-8?B?N2lWbzB1bjNzUzNCRUJOc241SnMyNnlJNWxaOUVyTzlZY0paNkluSldtNk1C?=
 =?utf-8?B?dFhLcVJ1Tkk4L3RFK3RxWXU5eXo2cyt2Vk1xMUw1dWxzK3d4cURPekNjODZN?=
 =?utf-8?B?MzlHZEFZbDAxRzVzVzRJZkwwRVZ5b2x5RzY3ZDhReFlnc2NTSlVtR1VJTzR5?=
 =?utf-8?B?VlB2bUYydDRNRnIxVVJZekJKL1E0Y2gzbkx5TDJKK0sreUYwZFVPZndpVU1l?=
 =?utf-8?B?cFZPWFVkdmQ3N3IrTElwQnlySDRkTTlob3JKSmlqbVZDTkxXNXdvUEQ2L3dF?=
 =?utf-8?B?LzBrUEdTOTNKdmp0ZlFnUmQ3akNmSGxaNUhETVdjUU1zUVR0eU1kS0oyUjd5?=
 =?utf-8?B?VzlFdUhLQmR4MGcyczhwWTAvY0x6V1ZONFJwZE41cSs5SStDcnpUdFJQREp2?=
 =?utf-8?B?dEE5OS9UT1RsRG9pL2dyYkJheTlhc3dNelFpS25uT1VaUTdtbXBRdGxuUlpE?=
 =?utf-8?B?Q0VKNzhJT1k0NmJlQTJwQ2NDQ0pTRDZ3eE8wc3NTWWJBT01iZXM5WTJCdUY4?=
 =?utf-8?B?aHNBQ2NiMVZ2cmFQVW1iTG9NY08rUkZjWk9WdEVkWER1ZVNCczBVMjBDYTJW?=
 =?utf-8?B?UTdKMDZGb0pqVWs0aTIwSWkvTXY5dEVlNERtc3VhYlpGQ2xSTTR5K1lxSHJU?=
 =?utf-8?B?eVBCcVdDNC82ekxyalMrNW5hNGpYYjFIOG12cE9UczQ2RmF5aDVJOFlGTkxt?=
 =?utf-8?B?dTJvczdNYTMwOEI3c1lyOUVTeEJEQjl4azF0NWk1M3IvWjFTdkJ2OWNnemdq?=
 =?utf-8?B?SGJ4ditBK0xKQTBpQzhiV2wzaldLSnJWYVB0d1hueG1Wa2U4ZUJnUHV0SjRm?=
 =?utf-8?B?S3R3VTlnR2tJSThkNGsyMGtlUXhIRG1ubWdhRDlpcG1RTEJzSUgrdUJlbml1?=
 =?utf-8?B?anMzaW5RVjJhVTNSYmdFWGZJLzlIaUFGazVQN3BGK2orVWxxSm9NQVAvSlRB?=
 =?utf-8?B?TmVBNjFCV2QyNWpIc1ZpRXZLMm9zMmpROEFMbVJlcGhrZEhxWlZLZTVrQ2Zs?=
 =?utf-8?B?YXZRVHRkdS9KcHc3aExRTDE3MTV6eEk0Z0cvLys2TUFEdjFzL2dCeVhEUTlR?=
 =?utf-8?B?WkNLaUJ1WGVyOU9vdEhza0FjaU5KUnp6cHduZXhjWXhQeHBkYnNKcS9sTTlk?=
 =?utf-8?B?N1lkSzFLb3ptcEJ0Y1ZMWDRwZEJrRkkxd1J2NjJkSGE3ekRKTFZhNkdYZ01M?=
 =?utf-8?B?WldNZHdXNThkaHozSHVGR3RXTml4ZjZXUE9YbTVrSXRMcTUxQW0yaUx3L1M5?=
 =?utf-8?B?NFYrWXBSdHV5cGhYUnRoeTJ5ZnFTOFYycTN4VklKWFRoT3VxZm9sSHJOZzZv?=
 =?utf-8?B?aTJRQjhCb2JCbVlTRGhhemJOeVByZFE3dVh5VmwyNmYzd2ZlUGtEVUVVUm03?=
 =?utf-8?Q?vzfEbFxipN0f0k+1Irj/s+VE6N0H226lk3m4w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVJpUXlrN2I5ckJoMktXUnBBaGl4dnJ5QlVrYUY4YW5rZkxlYXBmdGdGSU5R?=
 =?utf-8?B?Y1ZyVC9VbzcwcytqUzZqU012YVR2STkraGJkTVc4dHZ4eUUvMEttZGFqUkl0?=
 =?utf-8?B?Z3cvSHFnbzUwS1pFa0VxMjJpaUZERnpoc3ZVUytYWU5nVWNaWHVMK1ZwcUN4?=
 =?utf-8?B?ekRGNFU0UFRVa0o5bDFQTWs5cFZBR1NCUUdvWndhSURweWRzcEw5Ymc0S3Bo?=
 =?utf-8?B?Zm5oZ0NKNHBBaEJDZVBzU1NZamdhQ0ZhMXFTZnZHcHZSdlNqZTNwdG9nL3I4?=
 =?utf-8?B?TVF3UXlENFpnZXl3TmFLRWlkcXNCNndIMU95UUh1MkhnL3pmeFZEdGtTbW9k?=
 =?utf-8?B?SkdhU2FCeDd6SnArRng5R0x0M1FGVzNoNmdxS29iN0hUN09xaDIvY0ZMVFN2?=
 =?utf-8?B?T2hTaGJpanlMRXc4RitZT00zUHVXRlhXL3NvMFBEdjZqOXRSSEFBaFdzVm5C?=
 =?utf-8?B?dVc4QlU1WkF3Z0tpK3N4dW45NURlY0NSZFhPcGdIM3RJbnBKUkdQdmhHQ3RW?=
 =?utf-8?B?QUFJdEdXc2FXQlgwQ1hhL2FoUlpscXNGZE5Oa2tOdlByL1Awck53c2FBbnl0?=
 =?utf-8?B?WFFMNHBHZWlTblFHMUtTdm1VVmYrL1NDQ2QwenVwNyswdXdZUE1zVFJsdmhJ?=
 =?utf-8?B?VDVkdldaWmJQeHUrQ3A0UGZYY2N0aWRaUzRqeEllM01VaUhTS2pTNFRGeXA1?=
 =?utf-8?B?NU5EZ0pyb1lOd21DbHBXclM2Yy9qUkdmc2JGT1BUYU4wZTdCSlY3TGJ1MzB3?=
 =?utf-8?B?ZjRZS0FwU0NtT2tTNEo2NmV5K0s4ZGRLcHdPTzlOUHBGZTVoQVU4SWx5eGlK?=
 =?utf-8?B?UThlTlpHSk1Vcy93SGRDcEFYanp2cGxoZllUM29rR2dSakdQWGIrNHhUQUlY?=
 =?utf-8?B?R2lic3gzZUptZ0xUZjBGVHlDUXRqSzZrS1NjVlBnUVhQMTBraE9kSG94cjBW?=
 =?utf-8?B?VGp0aFVYSmhsNnBxZnN1NjV1U0FaMU82eU1ER3k1SW9ENm9ZQlZ2azR3U2ZE?=
 =?utf-8?B?ME1DckVLbWdTbkpqNUhPTU1HMG1NYUhDd3V4YXFTQkd5WnlQWnovWE90dWhI?=
 =?utf-8?B?V0FNOUJWQjhYMnpTM3BySHVXTkNsNE1tbTdEd1dYQUlkUlJmM3kwOGpMenNp?=
 =?utf-8?B?Y1NseW5FSG5YRXJoRThwL2V4dHRuaVEzM2dWYWpXb3BpRHFZb1poLzU4Ujhu?=
 =?utf-8?B?aVF1YmNJUFN1UVRuN1RRdS8rMzdpZ0IweDV3TjRXRm9XYmF2NU9rOTZwRFJK?=
 =?utf-8?B?aCsybEN1ZkVpK1ZRbEt3ZXp3SVhMVDlZbDRQRzh1blQvN280SXBmZkFrU3ZZ?=
 =?utf-8?B?aHFYc09uUFVkbjZJbUJvTDROcnlYMGJ1ejc4MEdlUzFXOGJaQXg2R3J0cllS?=
 =?utf-8?B?YUExY1gzM25LNzd4T01Gc1ZQZHk2bHBXUzVLSFFMckFCc1VXWnNLYzFRbGlR?=
 =?utf-8?B?OHRua09GemIzR041M21DbEZxQmhCblg2ZjAzVXpEQmJBYWJpNitLWEpPQ0tO?=
 =?utf-8?B?UU9PNk9XNFplZ281cXFTclVTWWI3ek4yNjF0RDlvbDJ0U3FHWkN1RDZkbU9N?=
 =?utf-8?B?T3B5ZzdUNklkd0tCTkhtQU1CV21PcitYMUZhV1RLZjBZTEVFVlg2ZUdYRlIx?=
 =?utf-8?B?cml6aC9mSmFYUEdQUjB6blpjY1pnV1hGbE1XTm01WTBudElRM2xoYkRMRTNE?=
 =?utf-8?B?Nk5BbUFvLzdMUUxnTktEanhJL21HTGVvTGE3SWdwb1pDQ1dtUS9qa0VTeU1D?=
 =?utf-8?B?VjgrMW1XWFFpU1R1MHpISE0wdEpyZElMY0FUM2JlcFE1QTNQL3FQQ21obm1i?=
 =?utf-8?B?RUhJeURGTjRURjVGdkUyZFBVbWc2TnNjN2V6VkJqZ0luMFpUbTFvQ2M2M1lV?=
 =?utf-8?B?MVI5Y2JiTHRsZGZlNHFpZDRDS2tpL3lHdi81SEFLYWNLMlY2azY0ZEk4R3hx?=
 =?utf-8?B?RW1wTDczQjVReGd3RzdpUWlyelpXei83Wml1S2wvcWNYY1h0MmpFeU5IdXJ3?=
 =?utf-8?B?endIUDFKR3pkQkpkd2JONStzb1BUMnh0WlB3RmxtMVpaQS9zbmk3U1ljL1VM?=
 =?utf-8?B?OTBTVkxFV0gwbG54RTNzeU1ScTRYTjdlbmJ1WGg2WkN6bWF2V3pyemxoY08r?=
 =?utf-8?Q?WhJbk05hcwSOIczwKdvjiLhv8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f3Pij1pv8Qa1nDcWkKab5SbGZG7pIkOu0cUa3Qb0mzOXcc0AEVWXD/J85Ihud6Fl8yKgpC2CeV2idCQaEO/sxkI9Sn2CPoVqjApJt3xNki4KlOS3vDsvntvMhzdhAJm+xr7cqQKBLGBvTb/WFYNwMrLy2OzWvxrNwFAAgg9ofMH0FSN+yHeNsisyQU8cXg4dutiaMnXaUiKlI6U266N9bEBOS52ql4SguuhpTY4UF5vhpAH7H5vju/pk1aMmZwLO13Y4T5Mav/udkzHYGZi7smgCZJrzxZ7OO+XE1oXGdkTrsvRUGKkLJH+TCpbk+wcqg/60TmVlPwTtm+A+PJJ5aE3Ke8kUVhtegqx5cgcIdkJGaD1G8mXiv3qpCzppgWXj5NlGH+F5i9i92j+kiXOKVHttlOv8NyCDaBHFacEn7G/eq4AWtzJ3s4PUia7jBnKC3muMye8wAi5FvQQ21DjjWvrC07TBUllTnyhTiaAW869ZvD0eglHVue7PGDhCe17gmvGz6rnht2GSUuVneoHXyhwwt6wisOqqyDyaI+3Jj9L3TdmA/jbACyFFxEAwTTPVeh4l5WWFJ/pJvmN+5qlG6kFeg5ttI1XKZXS5OUfCiCQluATawjJ2Ab5tvBME9aN5
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adb2c14-6ade-4c7d-fc07-08dc7fd333e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 11:33:46.4914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzeiAEkkl4l7sdIkWSuhG1g3qo6eZfVW69foVOXl/5YAOGxp+7jR0LMFcdqaMNbQ83OZCBI+bfoVywM0c1BULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10278

SGkgRGFuLXNhbiwNCg0KPiA+IFEzLCBGb3IgQ1hMIHZvbGF0aWxlIG1lbW9yeSBkZXZpY2VzIHdp
dGhvdXQgTFNBIGluc3RhbGxlZCwgaWYgdXNlcnMNCj4gPiBleHBlY3QgdG8gcmVzdG9yZSB0aGUg
SW50ZXJsZWF2ZSBzZXQgdG8gdGhlIHByZXZpb3VzIGNvbmZpZ3VyYXRpb24NCj4gPiBhZnRlciBy
ZWJvb3QsIHRoZSBxdWVzdGlvbnMgYXJlOg0KPiA+IFEzLjEgV2hlcmUgc2hvdWxkIHRoZSBJbnRl
cmxlYXZlIFNldCBpbmZvcm1hdGlvbiBiZSBzdG9yZWQ/DQo+ID4gUTMuMiBXaGljaCBjb21wb25l
bnQgaXMgcmVzcG9uc2libGUgZm9yIHJlc3RvcmluZyB0aGUgSW50ZXJsZWF2ZSBTZXQ/DQo+IA0K
PiBUaGUgZXhwZWN0YXRpb24gaXMgdGhhdCBCSU9TLCBvciB0aGUgT1MgZm9yIGhvdHBsdWcgZGV2
aWNlcywgZGVwbG95cyBhIGRlZmF1bHQNCj4gcmVnaW9uIGNvbmZpZ3VyYXRpb24gcG9saWN5LiBU
aGF0IHBvbGljeSBpbiB0aGUgY29tbW9uIGlzIGxpa2VseSBvbmUgb2YgZWl0aGVyDQo+IG1heGlt
aXppbmcgcGVyZm9ybWFuY2UgKG1heGltaXplIGludGVybGVhdmUgYWNyb3NzIGhvc3QtYnJpZGdl
cyksIG9yDQo+IG1heGltaXppbmcgZXJyb3IgaXNvbGF0aW9uIChjcmVhdGUgYW4geDEtaW50ZXJs
ZWF2ZSByZWdpb24gcGVyIGVuZHBvaW50KS4NCg0KVG8gYmUgaG9uZXN0LCBJIGZlZWwgQ0ZNV1Mg
c2VlbXMgdG8gYmUgc29tZXRoaW5nIGluY29tcGxldGUgc3BlYy4uIA0KDQpXaGVuIEkgZmlyc3Qg
c2F3IHRoZSAiIENYTCogVHlwZSAzIE1lbW9yeSBEZXZpY2UgU29mdHdhcmUgR3VpZGUiLCBhbmQg
bm90aWNlZCBleGlzdGluZw0KQ0ZNV1MsIEkgdGhvdWdodCB0aGF0IHRoZSBmaXJtd2FyZSB3b3Vs
ZCBjcmVhdGUgaXQgYmFzZWQgb24gc29tZSBjb25maWd1cmF0aW9uLA0KYW5kIE9TIHdvdWxkIHJl
YWQgaXQgYW5kIGNyZWF0ZSByZWdpb24gZm9yIGVhY2ggd2luZG93IGluZm9ybWF0aW9uLg0KRXZl
biBpZiB1c2VyIHdvdWxkIGV4ZWN1dGUgY3hsIGNyZWF0ZS1yZWdpb24gY29tbWFuZCBhbmQgY29u
ZmlndXJlIGludGVybGVhdmVkIHJlZ2lvbiwNCkkgdGhvdWdodCBPUyB3b3VsZCB0ZWxsIGl0IHRv
IGZpcm13YXJlIChvciBzb21ldGhpbmcpLCBhbmQgQ0ZNV1Mgd291bGQgcmVmbGVjdCBpdCBvbiB0
aGUgbmV4dCBib290Lg0KDQpCdXQsIHJlYWxseSBpcyB0aGF0IHRoZSBhYm92ZSBzY2VuYXJpbyBp
cyBvbmx5IGZvciBwZXJzaXN0ZW50IG1lbW9yeSB3aXRoIExTQS4NCkV2ZW4gaWYgYSB1c2VyIGNv
bmZpZ3VyZXMgYSBuZXcgcmVnaW9uIGZvciB2b2xhdGlsZSBtZW1vcnksIGFuZCBJIGNvdWxkIG5v
dCBmaW5kIGFueSBzcGVjaWZpY2F0aW9uIHRvDQp0ZWxsIHRoZSBuZXcgY29uZmlndXJhdGlvbiB0
byB0aGUgRmlybXdhcmUuIA0KDQpDb3VsZCB5b3UgdGVsbCBtZSB3aHkgc3VjaCBpbnRlcmZhY2Ug
aXMgbm90IGRlZmluZWQgaW4gdGhlIENYTCBzcGVjaWZpY2F0aW9uPw0KSXMgaXQganVzdCBiZWNh
dXNlIHRoZXJlIGlzIG5vIHBsYWNlIHRvIHN0b3JlIHJlZ2lvbiBpbmZvcm1hdGlvbiBmb3Igdm9s
YXRpbGUgbWVtb3J5Pw0KDQpJTUhPLCB1c2VycyB3YW50IHRvIGtlZXAgcHJldmlvdXMgY29uZmln
dXJhdGlvbiBhZnRlciByZWJvb3QgZXZlbiBpZiBpdCBpcyB2b2xhdGlsZSBtZW1vcnkuDQpUaG91
Z2ggdXNlcnMgZG9uJ3QgY29uY2VybiBhYm91dCBjb250ZW50cyBvZiB2b2xhdGlsZSBtZW1vcnks
IHRoZXkgd2FudCB0byBrZWVwIHJlZ2lvbi9pbnRlcmxlYXZlDQpjb25maWd1cmF0aW9uIGFmdGVy
IHJlYm9vdC4gRXNwZWNpYWxseSwgaWYgcHJldmlvdXMgY29uZmlndXJhdGlvbiBpcyBzb21lIHll
YXJzIGFnbywgSSdsbCBiZXQNCnVzZXJzIHdpbGwgZm9yZ2V0IGhvdyB0aGV5IGNvbmZpZ3VyZWQg
cmVnaW9ucyBhZ2FpbnN0IGN4bCB2b2xhdGlsZSBtZW1vcnkuDQoNCg0KPiANCj4gV2hhdCBpcyBj
dXJyZW50bHkgbWlzc2luZyBvbiB0aGUgTGludXggT1Mgc2lkZSBpcyBhIGRlZmF1bHQgcG9saWN5
IGZvciB1bm1hcHBlZA0KPiB2b2xhdGlsZSBjYXBhY2l0eSBhZnRlciBhbGwgaW5pdGlhbCBkZXZp
Y2UgcHJvYmluZyBoYXMgY29tcGxldGVkLg0KPiANCj4gPiBPbmUgc2NlbmFyaW8gSSB1bmRlcnN0
YW5kIGlzIHRoYXQgaW4gY2x1c3RlcnMgdXNpbmcgYW4gT3JjaGVzdHJhdG9yLA0KPiA+IHN1Y2gg
YXMgSzhTLCB3aGVuIGEgbm9kZSAod29ya2VyKSByZXN0YXJ0cywgSzhTIGlzIGFibGUgdG8gcmVh
ZCB0aGUNCj4gPiBJbnRlcmxlYXZlIFNldCBmcm9tIHRoZSBkYXRhYmFzZSBhbmQgc2V0cyBpdCBm
b3IgdGhlIGNvcnJlc3BvbmRpbmcgbm9kZS4NCj4gDQo+IFllcywgZm9yIHNvcGhpc3RpY2F0ZWQg
ZW52aXJvbm1lbnRzIGEgY29uZmlndXJhdGlvbiBkYXRhYmFzZSBjb3VsZCBzdG9yZSBhbmQNCj4g
cmVwbGF5IHJlZ2lvbiBjb25maWd1cmF0aW9ucyBlYWNoIGJvb3QuDQoNCkp1c3QgYW4gaWRlYSwg
SSBzdXBwb3NlIHRoYXQgY3hsIGNvbW1hbmQgc2hvdWxkIGhhdmUgdHdvIGZlYXR1cmVzLg0KIC0g
c2F2ZSBjdXJyZW50IHJlZ2lvbnMgY29uZmlndXJhdGlvbiB0byBhIGZpbGUgd2hpY2ggaXMgc3Bl
Y2lmaWVkIGJ5IGl0cyBvcGVyYW5kLg0KIC0gcmVjb25maWd1cmUgcmVnaW9ucyBkZXBlbmRzIG9u
IHRoZSBzcGVjaWZpZWQgZmlsZS4NCiAgKElmIGhhcmR3YXJlIGNvbmRpdGlvbiBpcyBjaGFuZ2Vk
LCB0aGUgY29tbWFuZCByZXR1cm4gZXJyb3IgYW5kIGRpc3BsYXkgd2hhdCBpcyBjaGFuZ2VkLikN
Cg0KUHJvYmFibHksIGl0IG1heSBiZSBlbm91Z2ggZm9yIHRoZSBtb3N0IG9mIHVzZXJzLi4uLiBC
dXQgd2hhdCBkbyB5b3UgdGhpbmsgaXQ/DQoNClRoYW5rcywNCg0KPiANCj4gPiBIb3dldmVyLCBm
b3IgYSBzaW5nbGUtbm9kZSBtYWNoaW5lLCBob3cgY2FuIHRoZSBrZXJuZWwgcmVzdG9yZSB0aGlz
DQo+ID4gaW5mb3JtYXRpb24gaW1tZWRpYXRlbHkgYWZ0ZXIgc3RhcnR1cCAoYmVmb3JlIC9pbml0
IGV4ZWN1dGVzKSB3aXRob3V0IHVzZXINCj4gaW50ZXJ2ZW50aW9uPw0KPiANCj4gTGludXggbmVl
ZHMgYSBkZWZhdWx0IHBvbGljeS4gTGlrZWx5IHRoZSBiZXN0IHBsYWNlIHRvIGRvIHRoaXMgaXMg
d2l0aCBhIHVkZXYNCj4gc2NyaXB0IHRoYXQgd2FpdHMgZm9yIFBDSSBzY2FubmluZyB0byBxdWll
c2NlIGFuZCB0aGVuIGNyZWF0ZXMgdm9sYXRpbGUgcmVnaW9ucy4NCj4gDQo+IFVubGlrZSBhIFBN
RU0gcmVnaW9uIHdoZXJlIHRoZSBleGFjdCBjb25maWcgbmVlZHMgdG8gYmUgcmVwbGljYXRlZCBl
YWNoIGJvb3QsDQo+IGRldmljZXMgY2FuIGJlIHJlb3JkZXJlZCBhbmQgcmVwbGFjZWQgb3ZlciBy
ZWJvb3Qgd2l0aG91dCBuZWVkaW5nIHRvIHJld3JpdGUNCj4gbGFiZWxzIG9uIHRoZSBkZXZpY2Uo
cykuDQo+IA0KPiA+IERvZXMgdGhlIGN1cnJlbnQgU3BlY2lmaWNhdGlvbiBkZWZpbmUgdGhpcywg
b3IgZG8gb3RoZXIgQ1hMLXJlbGF0ZWQNCj4gPiBmaXJtd2FyZSwgc3VjaCBhcyBVRUZJL0FDUEkv
Q0ZNV1MvRmFicmljIE1hbmFnZXIsIGhhdmUgZW5vdWdoDQo+ID4gaW5mb3JtYXRpb24gdG8gcmVj
b25zdHJ1Y3QgdGhlIHByZXZpb3VzIGNvbmZpZ3VyYXRpb24/DQo+IA0KPiBUaGVyZSBpcyBhbHJl
YWR5IGVub3VnaCBpbmZvcm1hdGlvbiBmb3Igc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAgICAgY3hs
IGNyZWF0ZS1yZWdpb24gLS1jb250aW51ZQ0KPiANCj4gVGhhdCB3b3VsZCBhdXRvbWF0aWNhbGx5
IGNyZWF0ZSBtYXhpbWFsbHkgc2l6ZWQgcmVnaW9ucyB1bnRpbCBhbGwgYXZhaWxhYmxlDQo+IGNh
cGFjaXR5IGlzIG1hcHBlZC4gQXMgaXQgc3RhbmRzICJjeGwgY3JlYXRlLXJlZ2lvbiIgaXMgbm90
IHlldCBlbmxpZ2h0ZW5lZA0KPiBlbm91Z2ggdG8gZG8gaXRzIG93biBjYXBhY2l0eSBzZWFyY2gs
IGJ1dCBub3RoaW5nIG1vcmUgaXMgbmVlZGVkIGZyb20gdGhlDQo+IHNwZWNpZmljYXRpb24gc2lk
ZSB0byBlbmFibGUgdGhhdC4NCj4gDQo+ID4gUFMuDQo+ID4gSXQgc2VlbXMgdGhhdCBMU0EgUmVn
aW9uIExhYmVsIGhhcyBub3QgaW1wbGVtZW50ZWQgeWV0IGluIGxpbnV4IGtlcm5lbA0KPiA+IFJl
Z2lvbi9JbnRlcmxlYXZlIHNldCBhcmUgc2F2ZWQgaW4gdGhlIHJ1bm5pbmcga2VybmVsIG1lbW9y
eS9kZXZpY2UNCj4gPiByZWdpc3RlcnMsIHdpbGwgZ2V0IGxvc3QgYWZ0ZXIgcmVib290IGluIGxp
bnV4IGtlcm5lbC4NCj4gDQo+IEZvciBQTUVNIHJlZ2lvbnMgdGhlcmUgaXMgc3VwcG9ydCBmb3Ig
cm91dGluZyBsYWJlbCB1cGRhdGVzIGZyb20gdGhlIG52ZGltbQ0KPiBzdWJzeXN0ZW0gYmFjayB0
byB0aGUgbGFiZWwgYXJlYSBvZiBDWEwtUE1FTSBkZXZpY2VzLiBUaGUgZnVsbCBlbmQtdG8tZW5k
DQo+IHN1cHBvcnQgZm9yIHJlY292ZXJpbmcgUE1FTSByZWdpb25zIGZyb20gc3RvcmVkIGxhYmVs
cyB3YXMgZGVmZXJyZWQgZHVlIHRvDQo+IHRoZSBsYWNrIG9mIFBNRU0gQ1hMIGRldmljZXMgaW4g
dGhlIG1hcmtldC4gU28sIHNpbWlsYXIgdG8gVHlwZS0yIHN1cHBvcnQsIGl0DQo+IGF3YWl0cyBh
biBlbmRwb2ludCBpbXBsZW1lbnRhdGlvbiB0byBhcnJpdmUuDQo+IA0KPiBGb3Igdm9sYXRpbGUg
cmVnaW9ucyB0aGVyZSBpcyBubyBleHBlY3RhdGlvbiB0aGF0IHRoZSBkcml2ZXIgd291bGQgZXZl
ciBuZWVkIHRvDQo+IGNvbnNpZGVyIGxhYmVscyBiZWNhdXNlICJyZWNyZWF0ZSByZWdpb25zIGJ5
IHBvbGljeSIgaXMgcG9zc2libGUuDQoNCg==
