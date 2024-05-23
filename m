Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6A5B5B8
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455152; cv=fail; b=PD+Sb31kcEkzNA9GdOsMLTeBiROR8oh62tc0rvT5g4gRZENznvk/EHup/yTTWh6KN3NmoZnUXC4vUqURuRdfnKYCNYhubQbGRdhVBNTZ8SDwCOw5HQycanxC36SyIZYjr40HHD/Wggr/ck9fPhYUWfX9w4vSrS6TBxMcHu9+d+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455152; c=relaxed/simple;
	bh=PcBZ3G7g7kp2G8xWe/LSbYZ/Xg8YCijbcoXIpfJVmrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hf/szmD9yMpKL8PRpgw5kyKXfjqQoSqMLQPO7WruUARBP4gYA/ZsmRlOqN1SmmtlZZ3qGsMUQJD+5v5IxzzA43sB2dTSn54qct1L1G9gHoP4TStR490qsWxdDaK0vZKJHDsCYua5JArQ/FknYVMH5GvS/D6GswwXx0rtkPXLEns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=YbVo2Vcu; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="YbVo2Vcu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1716455149; x=1747991149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PcBZ3G7g7kp2G8xWe/LSbYZ/Xg8YCijbcoXIpfJVmrA=;
  b=YbVo2VcuJZCROrCzHED55lVQnivJinNXgVWC8M41oOZJeF5HjWotRGAN
   utiq+vbTqTh15dimjIEaCFQ+DlcyHDKmDiXsfUiMKLNJjc+XEN8aEQNqJ
   /wHFyoeK4/A8YRlKX2qBZTZDBR3+BDF9AnYVyJClfXkJrdW7XnbXFTrug
   C5t8eegb+HaL1D2OgHlL4ucDks41SuwU587hsiujc7hj421sQRY/6LXrz
   gDiR1gO7+EcAJrvbX+Jhn84RopwM5hp0jZ+VFwRXZobhea7xokP8vR7/x
   TczKjACh0sXbuONjpehMPzJ8cB1AR8FZAI2Ud7SlWxH/Gf5tMY9ujg1GI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="119812486"
X-IronPort-AV: E=Sophos;i="6.08,182,1712588400"; 
   d="scan'208";a="119812486"
Received: from mail-japaneastazlp17011005.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 18:05:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPm5x7Im2i9titEFKtUhNgPgwH58alwYmOnWOLJSXmcJpUkj7d9l1g3ZjnZ++LW29DoyDtBFuXA7HTZjhv1GYkd+b3vY1uyB9dm/9TEIeZ8ILi0H5TAXluZJR2kuTKO0YmbMU5IKPxKH2vW1jJGlqlFbGR/LqoXj7rliIXvvOF8XU6FBYurKRnG5K4kNE41qfUWSrHarfJ9hGEcZDfZVoc+eFaVOgYsK/y/zESt+4mv4WcLjmZc8gF5WHWYAMSKw2AEeBNC3f/sz4Jv8+eKzviMNX0sLHV+ByK2cnKPYViT0Y8ZB8woQzSEco5u4Wu8dbgEcbRhZr2E/TKSYLlfYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9koTyPGTVPNE2B207ZimatcmYT2mN9HkRhkphgkvheg=;
 b=IBVtoNNT4JTP6xyEysb5PNQvyzlefVNHmZCWr3q4FMggGOrHUCRCE7uR/dpq29/YHm31V8aPxmJKu3P8TNqaG77yJRY6uItf0N1lxiUiI7O3SIypIfr6aFoY5X4QnDWkjY7KPQ/OpVi4g5DqNPU924GCW+Wy04hvq8UKT2GEMQacqf2jenXKj3IYifLd2phFGb4WcLVW8U+k9mV5zkrcXAmvHfdi5+XAE8UuhsEyAbd2VzHDuqZexRMzp4Q2jwg1Q6YrcxPq1p8C22VvNyNOX48+H0yPCu0CG76pKcbzdRB3TNd+xf1h154hE3QmSkgznoidFpSPwLgIEIqxeyFwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB8242.jpnprd01.prod.outlook.com (2603:1096:604:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 09:05:39 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 09:05:39 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] cxl/region: check interleave capability
Thread-Topic: [PATCH v4 2/2] cxl/region: check interleave capability
Thread-Index: AQHalJWFMLLcyIwdlk22sjCGWvAyarF1CckAgAAXcpCAH0D5cIAQVQBQ
Date: Thu, 23 May 2024 09:05:39 +0000
Message-ID:
 <OSZPR01MB645378C98DFEA757101FD8EE8DF42@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
 <20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
 <662707ea3fb4_6910294cf@dwillia2-xfh.jf.intel.com.notmuch>
 <OSZPR01MB64533E9B5F137904A2CBA83E8D112@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <OSZPR01MB64530A99BD2ED390DF59F01D8DE12@OSZPR01MB6453.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSZPR01MB64530A99BD2ED390DF59F01D8DE12@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=40cf07f3-442a-4879-88ec-207896ca16d8;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-05-23T09:04:30Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB8242:EE_
x-ms-office365-filtering-correlation-id: 7b28614a-8294-46a1-7999-08dc7b07844b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|376005|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?a2pDamhSSCtENTBBTHVLRWZ6SmRoMStKWW9qN1pYVTFPVlFWRFNlSkIv?=
 =?iso-2022-jp?B?V0N6amZMRWVWQVk1ckhZQjdscWRSNjNmaEZPa0xaanZaaDh1aGxHV2tD?=
 =?iso-2022-jp?B?S2FYSjR2UUgrekJVRTRkTjBSR3RkVmNTK1JUV3o0TUJ4NWNFcENVaUNY?=
 =?iso-2022-jp?B?SExQcm1NVHI2OEc4a1RnUlhXWEIyS0Z6d082aFBWcy9MTVRHUVdwZUtu?=
 =?iso-2022-jp?B?K0l3UWZsRTQ0bU5Idks3V0dJOW5URXRqcnZPWXRxRVZzdEQyT3RMR0RG?=
 =?iso-2022-jp?B?NGJaem9ja01iQW55YTk4WmdESjE5eWo0SDNMUk5BR0hIOXh1czdpbkVK?=
 =?iso-2022-jp?B?SERpSVI3K0J0Ry8wVXlZUjRNdWRRMTVTNWpwU1J2UExibytlT2hRVTE0?=
 =?iso-2022-jp?B?L295VEEzQnlVRmpkRHFDdmkxcUxhU0FVZ2dFQVZELzY3NFJ0Sisvanow?=
 =?iso-2022-jp?B?Ni9lVWgrOGdhUjE4VGUyUW1MbWFBNnhKL3M2czYrS3kvOVhCR0J6bGFo?=
 =?iso-2022-jp?B?OUxxRXFjVVlVN1p0OUFyaXlKMjNrMmRCNEJ6SlJRWktBdDJWWnc0Y3o3?=
 =?iso-2022-jp?B?VUVVWXhON0lCT2xYV0J5eDl6YUJtaVdQWEhrM0ZFL1Q0dEM5Zis0QkR2?=
 =?iso-2022-jp?B?ZzFxWUIwTk5yZ1dqbUVxL3p2M2MrY2F2bjJuRGE0RU5ybFArT2xpdTBq?=
 =?iso-2022-jp?B?eHNkMG95L0VUaVI3dGZsaVloRHUwZ0ltWjQwUTVocWkxdloyMzJLSlRw?=
 =?iso-2022-jp?B?TGZzZWc3ZXRNV1k0cGhodDJ2bEJUR3kyRFZyOUt4YUs2N2VQaFlhQWgy?=
 =?iso-2022-jp?B?V0dhVWFqeHRPelJZSEl0SWNHajdmOXN5aW9OMkFGTFV3RjhaSzQ2Ymtt?=
 =?iso-2022-jp?B?K2VpVHJCVlJoUkhNR1hFQW1vdHo4UGhQRW8yWEhrVjZmUmpVaEVHL01U?=
 =?iso-2022-jp?B?MlI4a3dnWmNNS2hSWXBJRmxYak9HMU4xQit0WlQyekp4b0hTRFpoZEdR?=
 =?iso-2022-jp?B?SFhNT1A3ekdFb0xVNWZLNmRmZkV2U1RIWlJORzBpWWVsM0VTN2F3dmxR?=
 =?iso-2022-jp?B?MFpIVWtJWVlFTi83K1ZiT0N3L3ZTWStuMTdVTllkVVR3OGViMjdHdkZ0?=
 =?iso-2022-jp?B?M2R5QkU1aDBiamJ4UUIzYjZwYm85QWcyV0p5UVlOVGJ0b1Z6ZTI1eW5L?=
 =?iso-2022-jp?B?Zm1OYWNWaFl3cnQrcDJjYS80NlFrTVlqeW9DY0I1dGRENWJxeFFtWHp3?=
 =?iso-2022-jp?B?bVBnWTEvcDhVUGlleW5McWdLN0VzRWNWalNjbXZmaUtlQWVnOXBlci8x?=
 =?iso-2022-jp?B?SDA2QmJBbDRXRkhidCtwRWpDSmxWMkZ5d1RNZHRlanZ4NitLb2hyK0J5?=
 =?iso-2022-jp?B?WUpldmJMYjYyS2twQkFlNVUyMktZa3BZamVDRGFDSE1EZDl3T0hHWUdR?=
 =?iso-2022-jp?B?ZzdCV0gwN1paOFNERGc4QThpNmdWNUlWaEJnUmEyZU1KSTF5YmV6dG52?=
 =?iso-2022-jp?B?cE9QQUFRanppS3NVaTBRc1JSSkJwb2FqTW96RkFhYjlycEoreXU3UjJH?=
 =?iso-2022-jp?B?TGxmQ3hmVW8wZmRZTExIeVlhSllZSWNrVDdHWmtoaU1aZmZtekYwOUxO?=
 =?iso-2022-jp?B?WmNQRVVjelhHd3hXVDdQRVpHK3NBeXhwYnRqYXBad2lUczhSSEFBZDZW?=
 =?iso-2022-jp?B?MzB5WlJQTG5WcHM5RnErL0hDNXJDN28zZ0w4ZWN5QTYyb1Q0c0NpWW5R?=
 =?iso-2022-jp?B?S2JlUFdUbjY4QStISzNTemVwZ1F5anFPZlJ5Q2xvUGM3VGxSdXczeGFZ?=
 =?iso-2022-jp?B?YThTL1NWMGRRc05ZNmN4Mnl3VHJNMWdaeU4wWHZtUUxFRVc4VlRmNTQw?=
 =?iso-2022-jp?B?TlhXSlg3bnFJSkwyL3BVNmdnSFRaem5VbytqNVhqdnRJWVdIS0ZhU0JL?=
 =?iso-2022-jp?B?SUVVclN3U2lMZ3B2ZkFjQnNza1A5Mk5DMlo0TlUzZlUxWTk3RWd2Ulo2?=
 =?iso-2022-jp?B?QT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?eUxuQ2gzbkRpRTJVQXlUZXEwM2NRVGNXWCtSNytQcU8rS3V3d2xBYTVS?=
 =?iso-2022-jp?B?WCtlamFhZG8xNytnMStMaGt3cTBMbnM4RCtmRGdOMlVwTWx4TXVJWEp1?=
 =?iso-2022-jp?B?MTlJbmdndnQyYVJoaDFOcjBvVWR6emJwZ0orZVFuZzc3Y3pCcFpUQ2dx?=
 =?iso-2022-jp?B?Zjd4WHV5Wjl5eHJGeXhuQzRNczVtekI3d1lSd0UxSUJhWDZnR2pqTkxZ?=
 =?iso-2022-jp?B?dHZ6RTV1R1pRQnVkZkF0WUFIRUtuNlZPQjhONE5ob0MxQ2Z2Q1M5YnZD?=
 =?iso-2022-jp?B?YVRvaXFEZUQ4Nkh5bHFyY0FXMUFWR3Ywa21QZTlVS2dvTHV2VUxudWM2?=
 =?iso-2022-jp?B?VmVxaXZ6SUh3cVpzK3BuTW5yaGVuMlRYeGdlUXE0WHRjQnMzbUZDSDNL?=
 =?iso-2022-jp?B?clFOcXcrV1ZXYUJLNSttNEo5dHR0a1lVNFVUK1k2eGJlR0w1MFU3a0hN?=
 =?iso-2022-jp?B?MFBsSWFmSG1XeWFlVUtEUEo3eEdrZGszb1BkVmd3QkZScCtHZndDUE9a?=
 =?iso-2022-jp?B?MjJQT01CdXdmZ2RuZnJHdmptWjNTY2pGaW5xdEF5cXIrV1RBS1E4VFNI?=
 =?iso-2022-jp?B?UEF3bExEd2MzU1pYTkRUcEJCMG1rWFhRWUlWOXQzUk1uU3JrMUIwTXE1?=
 =?iso-2022-jp?B?RHNPSzk3T3dpZ0ZBeEorbWIyTXBOZkZBN1A4WUVESkp6VDNjYW5ZTVJk?=
 =?iso-2022-jp?B?S2ZJZ285OFlkdk4vVjE3aFZZSy9RQ2RhVmFXMVFtVFhmcGpaUGZRTWdS?=
 =?iso-2022-jp?B?T0Y1cUx0c2ZwUnNZbDRDNDFTN1hkeU41dHg1bGo2c3A4R3BPOG1XYWcr?=
 =?iso-2022-jp?B?blF2dzZjSVZTak1Kck5kS2tKemxoUUloakgyZW91dTBEMTdkVlRWNElo?=
 =?iso-2022-jp?B?SWZIM0NJTUtFRW5rSVFVZUcvZW9QWHVEclkwUVRmZHhvZEhSYjU2WlUy?=
 =?iso-2022-jp?B?L2xIY1pvZWt2ZVdyNGYwK3kvWlJxZjBNMDRuSmlRWUtpbEU1YkN1SlZ3?=
 =?iso-2022-jp?B?dUlmQW1iNW4wU3FHMDRVZ3l4a1g5N0QyUHo3VURJclNNZGFEVTJlLzNp?=
 =?iso-2022-jp?B?MWlZeDlHanVBZkhKNFU5SHREVlJjMGM1Q2NUY2JUS3ZhcUw1SklqNHRT?=
 =?iso-2022-jp?B?eWVrajNTay94WUlxcWhXeXpNdlRYMkF4Vjd3d2V5R2tjTlo1UkszanFj?=
 =?iso-2022-jp?B?S0s4WGN1L0VaZmZoUUl4dk81Y05pK1RGajJVTDAyWW1ncnpYd1RWMXRU?=
 =?iso-2022-jp?B?WVNRaW9QUU9hdDFjZ0UwK0Y1ODBVWFgyMHZmeDJNWjNnWVNDZjVNQXZz?=
 =?iso-2022-jp?B?YlRLdlFLcGJ3ZEZtQWNFaHYrMzBZVzZaNGJqZVFSVnVldmp1eTF5RFVO?=
 =?iso-2022-jp?B?akVhTkJZbmJiUGF4QTlKN2NzVlZiZmdSd0haR1h3bTU2UXNvbURjZkJZ?=
 =?iso-2022-jp?B?cmJyekltYk9kU0tRUGYzdGh6cU5ZeXg5RTFXaXZIUm43UzlISEg1dXZJ?=
 =?iso-2022-jp?B?M2lZcG40U2grdERhZndURUFiUlJtZEFpcVhXWlFXdmFnQS9pRjFFNlhP?=
 =?iso-2022-jp?B?a3NlTGRiUEJuWGtqWmowTE1YMFcyV2R3WC9MdTJ4ZS9xcnY0c0E1WlJU?=
 =?iso-2022-jp?B?Tk1kU0FvKzVzR3BCMFJ2UkU1MWpoQURsbmRUK0lCbEhreGM0ZHlHV2E3?=
 =?iso-2022-jp?B?N2hlUW1BaW1GY21XZVFpV1VaWWVZRC9kcHorMzU2K3lVSk5ZZkg0QlF0?=
 =?iso-2022-jp?B?aFZrV2p4RjBlYWpZMExHTEppSGdDWldNQkRXSC8vRnc0azBnZDZSUHIw?=
 =?iso-2022-jp?B?VlNmbFQ3Q3RyVVp6MzlEZEJvc3Vyc1VEU2REYlRoeXpBYWt6Z0pVaktY?=
 =?iso-2022-jp?B?ZloySmYyMTZOWjh6UXpnM24xMElxVFduZUFidWdHanFIMW5kNnhRVlNY?=
 =?iso-2022-jp?B?V0tpTXBDMHFPa0MzdFJaWURXQkd5S3drQnhrUzJJRVhLRGJJL2paUGhI?=
 =?iso-2022-jp?B?NS9ySUFZWmVYZ2NnWDZiNk4wdEJhcU5YZStSTE9rZ2g5MVRPaUdXL3dp?=
 =?iso-2022-jp?B?cjdZZzBTbGxRSHFFOENEM1pIM2lpbXRra3I5YktFZFR6cVpLamo3OTBO?=
 =?iso-2022-jp?B?NFV5Y3dpdzNlc2R5UkhhalhXOXJxRnlDU3ZWVkZtREI4S1luQS9VcjR5?=
 =?iso-2022-jp?B?Q2xEMjFDcDhpZHcwbTBHUVhHZXBoQXN3aEtZTnNwYjEybHBvWUIwQzBI?=
 =?iso-2022-jp?B?SWFqZzlKdFEvQXF0SHN3dGczbHZsRXpKVmhHbC93TDNFd1lmSGlPWi9B?=
 =?iso-2022-jp?B?dTVocQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sob4DpazT3LiT22GOttiK1Lo8+vVD0M5qeH58H31SDexo5qWp9ykqqgOxPbwukQWUSwK6h9gbQMlHDpNSD9JoFJ3bE6LgB8kGlvEonpzA0DQCdkAlJSdSGtEzsrUM/whWGniiZl6zjzCvNOhZWNYkxX+FFjslcQdZYbJ8vbWyRfbug7QLBDNcfdNiHtnGqwyUyxwHkzhNkHctsofrrE1DQi/uXyDdzkzJDgrb/uhTgitJTTNHyO7MAs7mfISMsmpzhy51Kkq9XJm+tEGfgrECZm4PpcqBm1bDsYAUroHG9e8VQFp6nxPO9Lt1aLW9iAFlU4DW7E0NVUqEUW8EX9aCovkXqXHjECn4zf3uxpGB3dBQUFi3291une9e7LoRRTyX1ze2pJMAvr0GkJn92og6S+I29W1hzeH6hDzdDZAx98vS7rgvplAL8PyU9xiJvb44/oFjUv2sIbjRZmLYwaPP1nrdxGFIkxD8ucrNfXcS40hTH2oF/kA4InOqcNCibbUJFO9jttnabdSEI5f1rHgAvMI4br8vN5R5X6D8AfHCWpLuvrYpzNoGjCkUKiBv0u0LQYva3kZ/ogRSQFaCm+Uuk7xOo+2fwUT6/1FNO0kj+WELlcZFMAlEaPwJJkJXcE/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b28614a-8294-46a1-7999-08dc7b07844b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 09:05:39.4064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8zczBk4x862IOuPT+ofCyUxeYdvK8CU0dgimoZJhm/RvH1+R0/Mj4ydvy017RSqnTe54tjkF8ROwKVkFpLaAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8242

ping again.

> -----Original Message-----
> From: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Sent: Monday, May 13, 2024 7:44 AM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>; Da=
n Williams
> <dan.j.williams@intel.com>; dave@stgolabs.net; jonathan.cameron@huawei.co=
m;
> dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.co=
m;
> ira.weiny@intel.com; jim.harris@samsung.com
> Cc: linux-cxl@vger.kernel.org
> Subject: RE: [PATCH v4 2/2] cxl/region: check interleave capability
>=20
> ping.
>=20
> > >  static int cxl_port_setup_targets(struct cxl_port *port,
> > >  				  struct cxl_region *cxlr,
> > >  				  struct cxl_endpoint_decoder *cxled)
> > > @@ -1360,6 +1414,14 @@ static int cxl_port_setup_targets(struct cxl_p=
ort
> *port,
> > >  			return -ENXIO;
> > >  		}
> > >  	} else {
> > > +		rc =3D check_interleave_cap(cxld, iw, ig);
> >
> > This seems too late to be doing the check. check_interleave_cap() only
> > needs to operate on all the 'struct cxl_port' instances between the
> > endpoint and the root. That check can be done be walking ports at
> > cxl_region_attach() time, no need to wait until switch decoders are
> > being allocated.
>=20
> I think we could not get the info of iw and ig for switch decoders while =
walking ports
> from endpoint to root, they were set only in cxl_port_setup_targets().
>=20
> Is the above understanding correct? if so, the interleave capability chec=
k cannot be
> performed at the timing you specified.
