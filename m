Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483C200A9
	for <linux-cxl@vger.kernel.org>; Mon, 27 May 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795842; cv=fail; b=B5VB8LTvh0UpwLx0iJG/K+neL4WKS9FmOePMCjgTcg7nOQfSUHWUJCUo6GzHAfjjfS1AnTdJO2tHJI1s9ZYTrcGmBeg7Q2MeUFjGz4UPE2isjf25mvtHnouxhaNgcahnfZHQmqFpHGJe4Sgdl3TgcWoOqsAz/TBCe/IdMWLAPAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795842; c=relaxed/simple;
	bh=plTbvpfUam507Eq5tXJQBAz3Hs2XwevJNV45ws7KG9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hz/LfWLaVgNJ2LIYSpKQ88J3dwEYtZgModt0KXtbmoWQLGm5FldhVAoMeRAV1EAR5D+0l1+u0UCuRGNA1nNsBKvFQLgRiglTolz3VoTIpF5nS3ZUywoeqoW5czvJU+x+L6luvgJyCtya+IJiTm77o2bsQQWknrqOKuQSW20QmKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SsYRyZXP; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SsYRyZXP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1716795840; x=1748331840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=plTbvpfUam507Eq5tXJQBAz3Hs2XwevJNV45ws7KG9A=;
  b=SsYRyZXPRAEUYe3uMF5ow5yYBV66qtRNzqKYnKMZhuupBI0KBagJhcxv
   VS0cjB1/gowTZvhnz4kLtM+6eCD1UUYA2RfLKnqC49DGsbbIZ2+lWe9LU
   KFhwJcIlo5oxMGYktejnSJQXcrjWMWLUGYLeAW9IdxP/QV4088V/hTu7S
   HqU9hCIFFffxJjnCdfhp9EjKdrjDAhjRb2khK5O1USXqKT2NqciEOVg1m
   M6/7WrfnjrYB7bN6YP53Vb/mm0Mq3hz8W5lVZPOSqZOw2u+lNw4Ni5DEy
   FP6HIwM6eUBw9TWzdNFoz0uRdL1i6owDcpzIe95aZrNZwa1ZcP6E0lkYO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="31689058"
X-IronPort-AV: E=Sophos;i="6.08,192,1712588400"; 
   d="scan'208";a="31689058"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 16:42:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYKqCjeWKMXoByl8ClhU3WDerSjlyDLrqU1y79npeYOOOmgGzo0/qqnpnLay/7JW7jy+EAU9gWLLfenudUP1MSfJKZy5xB9cP3pZKozGWVERejm7DuHiDoOZRtYIMoMsPSeibVTFtkNVHJg1iVK+TORrXOHHaaskSa1i3GB9NsbYL5PB5t8FFS3rSlTZsaGFHKdIeL7giqr/vc0/OEkNCNd8/no/+Q5yAqLMU7cJUAFWK2gFqQYGtVkNZsOj0/ZjFoskI8wU/QfXDDzAt7CwuHFK0Us4UT9Pa0Md7hehNxiBftAanlAcp3PUiq0gDez1kPF9xQrFY4F01LtEEOOTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plTbvpfUam507Eq5tXJQBAz3Hs2XwevJNV45ws7KG9A=;
 b=XklmFU4cTC+2I9aCCECRRXBcQOVk1OYsyGsc72J8mfVueYOcuwsANt6ego+hfRv7nXQNlTvNFj+WwHFohGYQiZHaQNtzO4V8iAolYvCkeyOlWIf+WMpmblnzpy2IiHQbQ04+9PwT1BgZC0O0ZLIlWEWHOTV1ahAK2Ijzv0Aarnrc1ohadCmuWMjYCJ364sasIrwRe2Wxq25fCBKc47t7+w6dfKHLTNHH5xnDnSK4rgNAbZCWydO6oXryIw0mBV9edQJiZzQeyKl9HehWZh7furMWPkPxrM9msd8iMy9btxt7i4aZqKGPUDxmRC9y7sFrUvKm1LHgLlCHKt8xgK3RkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB11802.jpnprd01.prod.outlook.com (2603:1096:400:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:42:39 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:42:39 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>, "Jorgen.Hansen@wdc.com"
	<Jorgen.Hansen@wdc.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	"armbru@redhat.com" <armbru@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v8 06/14] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Thread-Topic: [PATCH v8 06/14] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Thread-Index: AQHarTl8iwbyjacRdE67ScuWG8K5S7GquHCA
Date: Mon, 27 May 2024 07:42:39 +0000
Message-ID: <0e96b5a3-5bb5-4808-93f6-1601f38ae599@fujitsu.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
 <20240523174651.1089554-7-nifan.cxl@gmail.com>
In-Reply-To: <20240523174651.1089554-7-nifan.cxl@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB11802:EE_
x-ms-office365-filtering-correlation-id: 9be3b836-6f64-487c-c0e4-08dc7e2095cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFZXTks3RXduaFU4QTBMSlIwN21iTUJBL055eWNLZUtlMnVaZGJqODN3ZGJs?=
 =?utf-8?B?UVNBMjZhc1RUd0xkeW9yUXlXNGNGY3pYbVFQSnhwNnNXaUU2cU5pQk0xRU1v?=
 =?utf-8?B?VFpCNllLMTlvUXNTNm9FVWd1emdmcVZvbzdVaU9uaVQ1OCtDSDdKeFd3TXN0?=
 =?utf-8?B?U0lQTWRaQUhoT0NBRFhYNDF5dDRhNVBDR254amtFVmRBcWpQQ0Y1aFVsWkwr?=
 =?utf-8?B?bTl1RE1wWERQWDFzUlkrNVdyRXN6d1EycVZscWlkU0E0eEdQVmhVUzFZSUhz?=
 =?utf-8?B?RzlVbDZ2VlRHcys0dHVQcW1vQzJyK1gwYnNzTDJBQ1grTitrTi9FQ1dISDBU?=
 =?utf-8?B?VTMrdFVTMGVwWUozbjkxckp0Tm52SDVhTHVuNjZRcnBDdkY1dW9COVlyZzZT?=
 =?utf-8?B?Q2lZNnlvRE9ST0pRMi9mMzdZMFVvOHVQdGwrUFNxT2xjcDF4dmxMZjdXR2FY?=
 =?utf-8?B?U3lkbTZLVmFNUTRGWXV1Y3p6Z0J5dGV1VUVkU011NU1VOFUwNHpva1F4ekhM?=
 =?utf-8?B?RkZnSDVVNk5FV296aVhXcGJUZGZ0dERzQ25QajNPcEJ2YlpXYWswS0R5cDdI?=
 =?utf-8?B?cmxjTlE3YUpjZ2U5cldlZzVFSnJhZGlKTXNZZUg0dmRzSmZGTWRtdTdwamVP?=
 =?utf-8?B?YS9XVUxuVkVHREZzWTJPZUlzQU5qbzcyTXllMHloVTF5U29jaGUycTlHL3Vh?=
 =?utf-8?B?Unk5MnYwd0RaMHp3QlY4VFJjWHcxSkZrYS9vc0FCZUhNd1l0UDN5WjlmbVhU?=
 =?utf-8?B?aWNTVDFKZmlXMTQ2bnI0TmZudHdXOHRvWDVMNXU2NnJUNEZValo0c2t2UWpt?=
 =?utf-8?B?L2U1a3ZoQTZyMUdLU2FiZUl5Umx0Nys4Y3dGbWxhZ2RWV0xhK25SUkZjWitE?=
 =?utf-8?B?U0xJUjYxZElWQXo5QmNCb01jRzIwWHF2WmZ0K05NTnFCUmcyUzlKdmMvZ2Ez?=
 =?utf-8?B?RWgxUUZxRFF3NCtaaUk5N1lHcXE2Rms1YTBIN2JaV2VZTEJUaG5EYktoSkNS?=
 =?utf-8?B?ekx6WW44VEVSRkVWNUNlU21abzRwbDIybVhZdmFpNnFaM1dYQ0JUcUtIT1N2?=
 =?utf-8?B?R2xIRFFCZCtyZ1lNemVBZ0VaVU5XN3NpZjVQL1M4K2FMTUE2Q2VvQnE1RjVK?=
 =?utf-8?B?aVBWWDVPS2JXaEFkcElYQy81MHBHQVVLWkdXM2hjVnVCTGV0SkdwY1VtcmhR?=
 =?utf-8?B?bENqRng3Zjhrd3J1QTlaTGxPUVNxbTNQdkNiM0EvR1MrWk5JaW1xQmVXdUdV?=
 =?utf-8?B?SzNqRUVuOTlWcXR4V1JJWGJONFpXVmNsczNhdHBaM3BXVmZ6UWlnTFh0T2Ju?=
 =?utf-8?B?R2dSRHBrYmlabTZyck52ZUp1UTEvMTFneGxxdG52MXM5TlpROE4yeXVOU2dH?=
 =?utf-8?B?UUxSQTM1dE5HUUhINUZvR1U3Q0k4ZDBYOW9YYnF3aWRQN3lNNGkyc2dUU1dO?=
 =?utf-8?B?OFNMekhPSXdLcFh3b2IxU3NRdjRFSlhGbTlzV2hST1NLVDZKd1NDT29iYUls?=
 =?utf-8?B?YnlyZlBYclY2eG9WZ1lWREE0SGN6R0FTWHpvaHRhQUplN2JRdlRMSGQ3LzUz?=
 =?utf-8?B?d3JOcUJ6RXNzZEwvK29NL3RsVmNISEdGK0t2YWlTTmFzRlRjZ0VrczFaWnhr?=
 =?utf-8?B?WjR0UHVOTVZRZGRYNTFqdCtnaWdLcFptS0JsN3g5Ym1saU8ySytlZkxmdDlR?=
 =?utf-8?B?R2VudW8zRUI0WGRzRENzUWkraDYwUGZhalBrWlcxNGxaSldrRmpQQ1FoU0Uy?=
 =?utf-8?B?eFgzcyt1czN2Z0FibEFyT0lPeXZ6a2NiNGc1VXdUVkZzM2VQV2l3RGJZWFV5?=
 =?utf-8?Q?qQ9OS+3uHLPyNiYvABzEVkHsRaCND23lVZMzs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3BvcjhxZ1lmdkRaeTIyOFNublhVeURPMzhkdGZhMER6T09OMllFZERTb2tl?=
 =?utf-8?B?aWRaM1NyeUF6bmNSSjdsaG9OdGdyVjBJd09jV1ZCMmNHSFlzYkFUTXFHNjJJ?=
 =?utf-8?B?TjVNdnhQODhNRlBOTWdxNUNGVFFNQmUraE8rMG5XUlVqR2R4SHl4WWZLMjI1?=
 =?utf-8?B?MWkwWG9EU0Rjakp4cHp0T3ZqZ3g5L2tnbG5lL1BZa3JNa3N0czI2dVlzRGta?=
 =?utf-8?B?S21UMUs3RkpJWE81NjUwaDJqVzF5bVVwWUtWbGl4M2F3WExWZlRlU01sOUY4?=
 =?utf-8?B?NnMwaHRESHpxdE1KOEZtNzNrckkxRFMvVVZtT2JHUmloOWNvMjRJTFZEWkxF?=
 =?utf-8?B?Y2ZySjk5S051YmdqSzEyNlVWSHN3cG4va2tQNGF1MXR6SWU5OWhGQU92enRz?=
 =?utf-8?B?VE9MaEE1OFM5SHZVU3JOcVp2M05TQ1IvT0FuMmQ1ZjZONEl5NGw5cUFCMmpw?=
 =?utf-8?B?MHdiS3dRYk9pL0FFRTlIa3gzOHFRaHNSZ2FINzhkREpoR3FZajdLdG90WXRB?=
 =?utf-8?B?Ykc4OWx2VlNBc1pBdWF3THUwaHBQNGo0bW5xMEZ1eEJvNnlPcXd0WmJXeE1F?=
 =?utf-8?B?Yzh1eUZndkRNejRieGJjcUxkZWxIK25PeW5rVVBNcHF0dm9kNHNWNXdhSjhC?=
 =?utf-8?B?SUhzNS9PUDRFc08yMUxLRWRTcXZ1Y1JUa0JqWmF0eEFNdDlUYW5Kd0k3TVdK?=
 =?utf-8?B?a3J5NFhuQnM2Q2VmRTBHdFNNek9JQUQ0cnEyZ3d0LytJNXZ6WjZkdDZyVUwx?=
 =?utf-8?B?dkREdXlaMVlYeHpEKzBFOTN0OGNqUXBxOFc1SXR1c2JwUy9rWDVIdS95eTJ1?=
 =?utf-8?B?TUVWYWpHWTVqY01IOTVwZjdscTZLS2tZMUxTN0tsNUQ5SFBTRVZMTEZVN0dz?=
 =?utf-8?B?S2s5MllnakRvbkw4SitNWXVxb3owN1kzTzcwTDh0UjgwUDYwS08rQWc2Rmhv?=
 =?utf-8?B?MUVWckR0TE5WUmFlbjNqZXJrQXhMQWRVQnNqZDZDbEhqWXFBd3Z0T1lQaTQ3?=
 =?utf-8?B?cHI1MDNXL0p5Z3lPem8vMEVqWWJWTFdJTXhDZHNvL0J1SjFnSERocUUyTGpz?=
 =?utf-8?B?S3duc2o4aVdMUlJEajJHYW1HeGZhMEIzWEU0cExJT0Z1T1pDNDlRK2dSc1V4?=
 =?utf-8?B?eGdRY1VEZ3hoTkFmV1lhSlBUMjRmMlorWlNuQVhJS1I3QnBPYlU5cmVZZ3ow?=
 =?utf-8?B?dG9IWHB6RHpNT3lJRjBKVi8wL2hYY0MwV0JkSDhadTRocjhQdWRyNnZnSk43?=
 =?utf-8?B?NGpwQWtjOHNKMm1rZjI5QTZMTlk0M05XOExxQ1k3dkk0WUlKVktVU0ZTNCtw?=
 =?utf-8?B?ZmpYbGllV2Z3NEN3UUF3VkJYK3p0RjBYUjVYS0J3T0JQS2Z0S2pEN1F6SE1u?=
 =?utf-8?B?a1hoNmpNMEIxUXNCVGFPQ2JuNEtJeis1YUU3bzBBR2lMK2JhaStWclJ1bXdi?=
 =?utf-8?B?eUFqTlBjaS9meTVwVG5YbGFBU3VTdUY1VmVSU3gveWpxNDJPUkN2SFVsZlda?=
 =?utf-8?B?TklhcnB5M2lZcjVKTUlibk1vZlRTczhyL2F1Z2F5cnNCaXE5VFZERGJqaDRF?=
 =?utf-8?B?eHg3S1kvTlBSQW9NOE5ZanZGazJQQjE1ejl1RFJ6T1kzaklmNFZDK3NiMmZJ?=
 =?utf-8?B?Z3pBclJFRTBzdWVxYW14YmhpUjU4SU4rTGhKN3o4c1JDekpmejdZYVY2NUxB?=
 =?utf-8?B?R3ZRakV4anltbnNUSXVKanV4NXQrQ3ZRajYwVEhoSVE3MklNT2IvSFljYnJw?=
 =?utf-8?B?WStoZHByOWNmWm5icFM4ZStkYkNuUkRFOVlOKzdLeHN0LzJTdEtMa3dUN0Qw?=
 =?utf-8?B?U0dmN2pwT2NOSEhzazgrZzNkbUlTSVhVVWtjMHN4SWsyQVVSYlNWN041RVVU?=
 =?utf-8?B?N0ZxZVhSRGpqdG5jbk8yaDY1Z3ZEZUtERlNZTUw3ZVF3RFVqNmk0SGcrU1c4?=
 =?utf-8?B?TG9WSS9ja0dkMHJqd2VIMktxZjVrRDQrVTRkTmZFeGYyRFJtMEh1dDRLVW9a?=
 =?utf-8?B?SFFIdjRhb3BkODgra3FRcE0vRTdWRkRuL29WV3gxTEh1bnB2NENDRzY5UUJ3?=
 =?utf-8?B?bzNzWVRlRVdybkpQa3pqem5xSjduT21ZbExCTmFFQlBkdkNoZ1E1U2tHeFdH?=
 =?utf-8?B?U3RSSjJvRENzcVkvY3FEelpIc0hYd0FSVmplMVFKUFNZTDBLL01PaTdvMEFu?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D18297DD4A6E94C88E9BD740898676B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ct5GiYAj9tA0Qdf2wxZSlk070VZfmEW4zdIdKpomQpj2HgSPiSde+upAqnD2PTwjxa9Fi7nZduLs+LxCK840sn/2LSIxWj5EkoxXcCJlFwZnYNwxotk5k52K6YVbyopZA2a2PrDbNTsf6khsYv/J+Ej4P2mmMuZa+cW5djES4fv/6htV9Zy7ADZN0PdmA3hZgZzJoVQLPkkMKZQxHFfk28ImLAXdyU3PMqfqH+tOWhpjDc7/HNPweRbjsnhrNrEhUzOngVfNxDTOcUlYwYNIVzcYQS7a6LHj8nQi94Wmq+qjcBfwM6cyrYuriw+hjDIB/NShm1F9QeXsZkybEwO1pTMIvConVFjfvWCItk2QmgVL7L2xrzYNqEtKSAFILKf+xj8PPPTQS3YBbS+ODGBodCeIPbwRaaJxv8KE+6xpdsRZHm/53yNvFdMWqG0QhQt62FFu7PjimjcAhCp5WiCQ4YpU96duZj+yqOkBSOnqhbTee/zlYSRhIQY6wx8or8jid4McQ92q0Tzqvx2TVCuR9Wxs6kPyOmlBot8+ym+xlYGg74JbTsLyByb5FwlpR7YWnoDJgLSTYCFJKtf+V7MWJar0OYYsALzvigJyK5lprDbuYnzWU6hQQuabFSkLJ7uN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be3b836-6f64-487c-c0e4-08dc7e2095cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 07:42:39.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JS8D00Yjr70IHyX5uAsY3YlE6zH0JWm9eqN1kA6tH5tZvr8IGY4CWIEDuKm59AqWImU9a356jA6n/Yp/UXBiwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11802

DQoNCk9uIDI0LzA1LzIwMjQgMDE6NDQsIG5pZmFuLmN4bEBnbWFpbC5jb20gd3JvdGU6DQo+IEZy
b206IEZhbiBOaSA8ZmFuLm5pQHNhbXN1bmcuY29tPg0KPiANCj4gV2l0aCB0aGUgY2hhbmdlLCB3
aGVuIHNldHRpbmcgdXAgbWVtb3J5IGZvciB0eXBlMyBtZW1vcnkgZGV2aWNlLCB3ZSBjYW4NCj4g
Y3JlYXRlIERDIHJlZ2lvbnMuDQo+IEEgcHJvcGVydHkgJ251bS1kYy1yZWdpb25zJyBpcyBhZGRl
ZCB0byBjdDNfcHJvcHMgdG8gYWxsb3cgdXNlcnMgdG8gcGFzcyB0aGUNCj4gbnVtYmVyIG9mIERD
IHJlZ2lvbnMgdG8gY3JlYXRlLiBUbyBtYWtlIGl0IGVhc2llciwgb3RoZXIgcmVnaW9uIHBhcmFt
ZXRlcnMNCj4gbGlrZSByZWdpb24gYmFzZSwgbGVuZ3RoLCBhbmQgYmxvY2sgc2l6ZSBhcmUgaGFy
ZCBjb2RlZC4gSWYgbmVlZGVkLA0KPiB0aGVzZSBwYXJhbWV0ZXJzIGNhbiBiZSBhZGRlZCBlYXNp
bHkuDQo+IA0KPiBXaXRoIHRoZSBjaGFuZ2UsIHdlIGNhbiBjcmVhdGUgREMgcmVnaW9ucyB3aXRo
IHByb3BlciBrZXJuZWwgc2lkZQ0KPiBzdXBwb3J0IGxpa2UgYmVsb3c6DQo+IA0KPiByZWdpb249
JChjYXQgL3N5cy9idXMvY3hsL2RldmljZXMvZGVjb2RlcjAuMC9jcmVhdGVfZGNfcmVnaW9uKQ0K
PiBlY2hvICRyZWdpb24gPiAvc3lzL2J1cy9jeGwvZGV2aWNlcy9kZWNvZGVyMC4wL2NyZWF0ZV9k
Y19yZWdpb24NCj4gZWNobyAyNTYgPiAvc3lzL2J1cy9jeGwvZGV2aWNlcy8kcmVnaW9uL2ludGVy
bGVhdmVfZ3JhbnVsYXJpdHkNCj4gZWNobyAxID4gL3N5cy9idXMvY3hsL2RldmljZXMvJHJlZ2lv
bi9pbnRlcmxlYXZlX3dheXMNCj4gDQo+IGVjaG8gImRjMCIgPi9zeXMvYnVzL2N4bC9kZXZpY2Vz
L2RlY29kZXIyLjAvbW9kZQ0KPiBlY2hvIDB4NDAwMDAwMDAgPi9zeXMvYnVzL2N4bC9kZXZpY2Vz
L2RlY29kZXIyLjAvZHBhX3NpemUNCj4gDQo+IGVjaG8gMHg0MDAwMDAwMCA+IC9zeXMvYnVzL2N4
bC9kZXZpY2VzLyRyZWdpb24vc2l6ZQ0KPiBlY2hvICAiZGVjb2RlcjIuMCIgPiAvc3lzL2J1cy9j
eGwvZGV2aWNlcy8kcmVnaW9uL3RhcmdldDANCj4gZWNobyAxID4gL3N5cy9idXMvY3hsL2Rldmlj
ZXMvJHJlZ2lvbi9jb21taXQNCj4gZWNobyAkcmVnaW9uID4gL3N5cy9idXMvY3hsL2RyaXZlcnMv
Y3hsX3JlZ2lvbi9iaW5kDQo+IA0KPiBSZXZpZXdlZC1ieTogR3JlZ29yeSBQcmljZSA8Z3JlZ29y
eS5wcmljZUBtZW12ZXJnZS5jb20+DQo+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxK
b25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEZhbiBOaSA8ZmFu
Lm5pQHNhbXN1bmcuY29tPg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1
aml0c3UuY29tPg0K
