Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFA18E29
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717645686; cv=fail; b=aQ6Co9umb6OGRl05iwV5Nxz9nVkO82zK2E57D6iTt0x6aF0OroNUH4F+hKzvuDJTNQJjXpbDZPHsSi7ERWlXFJ0NIsQqim+tj2ZMScnPHUtXxk5i3y14iswukYzzwzJWTg0fcIvdb91sBNak04cZ65n44qoZeZD4rx3RZt1k2YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717645686; c=relaxed/simple;
	bh=KjEFJv9xNIg61BV75oFnm8sib5PkQkWtDiLSOluzr4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jwhv9kUqJpJK/WJdGWXS0Jq9zCIK+5VmMGNgaR1BcpHCOsbjnZOmuVHfkTtrkJksi0fhAbzT3+EAka5QXHSvAXSVMgrcWtyQIysjaTjOJg/tdnyxwLSYtfxdnm1cVR8sIFpmnogPKwFRX9E6EAw163uHTFXujKyfBZ8OPiKrPWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LxE6WNT1; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LxE6WNT1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1717645683; x=1749181683;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KjEFJv9xNIg61BV75oFnm8sib5PkQkWtDiLSOluzr4Y=;
  b=LxE6WNT1UdaVr4nvZWLWfUq6tw9q7Hguabq9mCa0cq6y3qJ7mtG0OKCF
   ciGVawkQKdVaJzP9a6T6O5vMiKE+WM4V9Jgxu+FJrpL+Pgzzz8hGevnPu
   ATh0KSZmf9yE5NSIV+pgUthQDQqAcxLCNgHNuUhC7BwVsEX3eC8ZAQor2
   hfDrkbKXOK5/ItC0HdX00uVAdSffD5qpDT5Et0DgJYPkkg2gjewY5l8cQ
   c0ma8/wDezn7xZZLM+ZWmMzKWI/jsGSijKRYaoAe5X4nW10HenPy91WKZ
   F1phtlmi/Dpt3tTIK5Llx8UkNojyRA1t6b0QzywBBB+ftox2e8SVOuv2r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="32584088"
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="scan'208";a="32584088"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 12:46:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQNdXJ2/j5fCY+3RV8Z6eGVcje2wHf3nxAGAOwbXf1tABa0wDyXE8yZyNx5slwbnebnABeIxm+rNq7dMx7nFkf+ilfqw4p91ElRduJ38dL+uZ4+kPr/A0iwKk71luSKmEJOtu0kSpriEnCUUSEEcBEUC6iYEEpjRA9AuCzm5077HtZ4TrN5QlsNE5zyWKtUpLUS4N37YdK8qRObnTvHKQDvVmhbL0e0wgNK3On0IO6HLr2/umuTMjOmS7r4XV7v8LFiyOuet2vDmCszMqg8lxX/y50YUkfJIgT1gjVCz4iqrHXDlYJNHAXXJJViRE+G2/gKTW9Gdq05F5jKx80YMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtF6mKsJacDtInhK0VvdipBldtRxMMxezePJTsWcKS4=;
 b=IYE+bkS+Wfeum8DRJqDa2YlGkg7nijOq8fhLyYXUyZ+gV6Lv7VLE2cXfujWuO6JipkKLemmWFdZH7a1P5iITsw+3DZqUtyoZUkJqbBagWmCOAtXKRrFwzADkqcjM2O3gk8WhmaKTSXmXpqih4gJWoDdobCDgTWMbSP4i7vQvGnYj25ob4fe3O4GJ4/V0yNBv0Klbp/9Z8/Q41sUCx0UuARPbSwHsrhJkO0c7XlAO+zdLkxedX2Ymw1qY46gkKnSVvmWWKns+MgsxSwuZH2YfSIPKd8ZSkW5T1TE9AdRI/uMITQh3FD7SeuYoQ+Eeb0ZoHVeTriZEPgEogwfcx3WlRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB8551.jpnprd01.prod.outlook.com (2603:1096:400:150::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 03:46:43 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 03:46:43 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v5] cxl/region: check interleave capability
Thread-Topic: [PATCH v5] cxl/region: check interleave capability
Thread-Index: AQHarbykF6dW9BcSvE+L2hi4a5DvCbG5ZhqAgACuXfA=
Date: Thu, 6 Jun 2024 03:46:42 +0000
Message-ID:
 <OSZPR01MB6453A7CC146B904AE2C881C08DFA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240524092740.4260-1-yaoxt.fnst@fujitsu.com>
 <ZmCKcVZPS/5MztqD@aschofie-mobl2>
In-Reply-To: <ZmCKcVZPS/5MztqD@aschofie-mobl2>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=d011c02f-6f24-430a-8143-00229eb8bf56;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-06T02:19:39Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB8551:EE_
x-ms-office365-filtering-correlation-id: dfa19ce3-d790-4b17-257c-08dc85db47e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|366007|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?dUFwMEhkVy85bTNjQjJxSWFaV045bE0zTXNlUG5xMXZPYTd2UjdhbWVm?=
 =?iso-2022-jp?B?VW81L3pNejNUbk9tSkVVMkI5cFdXU1lDUVpqRm9oM08vM3p5ZGk1L0h5?=
 =?iso-2022-jp?B?TzdPbGwvYTRLdG5IQXZhREtvUWM4d1JoaVMrUzVyNlAvSzIyckRzQWw0?=
 =?iso-2022-jp?B?bDh6UnJ1amcvZFlTbU1MQkpySnAwUnlNbFo2ZDFnSUxMbHI2NzFjdXBC?=
 =?iso-2022-jp?B?cVRtV3lReXBXT05ONEMrMDExcnVwbDF0ZXNPeWEwSUMwYmRYQjlFWGxn?=
 =?iso-2022-jp?B?U043M01LR2xZNVUvNUNFbnd3UWtlQXRKQnVYRmRxdXVBbEJ5bS96aUJt?=
 =?iso-2022-jp?B?bjI2b2JNdjFETUR1aUF5ZXNhSnROZ2ZRTTNTOXN2VThpMWU4RnhtWDNQ?=
 =?iso-2022-jp?B?SkpjOTIyY3ZLYkpoa3JIWkpLSVBvRmt4amY4dkNnOUFRbTJZSnp4cU5P?=
 =?iso-2022-jp?B?TDdxalVnL2lpUWZlaGZpTWRmMWFPNFpocFVhQ2JWakF5VloxWXZOZFZI?=
 =?iso-2022-jp?B?QmppNUVtQXo5NUhwUnhxMHl5d3k3S0Z3ZGZzd3g5czlMeE00WFlGNUJ3?=
 =?iso-2022-jp?B?SXpnWnZVQnI2WGlTcEs3QUF5QnNjRlQ4bU5GZGlrQ256cGxWV25mSVFt?=
 =?iso-2022-jp?B?N2M1TWV4dW90blhqQncxYWdxa254Q2VUb0RUcTA2bW1ZQ2k1WW9JNVBW?=
 =?iso-2022-jp?B?WE1yMVlDaUVlUGVmZ1YzejduV21DMkZWNlVUdEo1cHB1M1F3ZlM3eWg4?=
 =?iso-2022-jp?B?Q09sMk5ESDh3L2c1dHQxMkoxSFQveHExc2xPVmw3UC84NzBRMDhyanha?=
 =?iso-2022-jp?B?SUk2enlBNG5aTFlUYkxzVlQxWVA3OGVybWZIVDRYRFEwR2xhMW5SQzI1?=
 =?iso-2022-jp?B?VGRqb3Bld1E5cXo0MU5PTWVkVkduUHN5WHdJZG1MQjdKMFU1OW1QSEhi?=
 =?iso-2022-jp?B?b09zcUdBMHBpSUxZWFlYKzlLZ1NQcyttUzhLdkFmdko3aDRwSTljZ2V1?=
 =?iso-2022-jp?B?a0FsOFQvOWFvdzJkbFN2eUZSZXN5TkR1bWpkUExHTUVON0RHUkx4UDJj?=
 =?iso-2022-jp?B?VHdDMEg3MjE0aFFUeFoxQUR4WUJnVnp3RFcwbFU4SnAwampxL0xDa0NG?=
 =?iso-2022-jp?B?YVg0bHR2dXEzT3RtSWxJU2pVY2ppdHFZayt0RkdsY280ZU1GYllLT0d2?=
 =?iso-2022-jp?B?L0ZZamhwb3FkZHVTUnpmYml4SUtrU0dVZG9MMFdESEdtT3FSUTZkdW9S?=
 =?iso-2022-jp?B?Ky8xTmt3dGNSdHI4Vkd1T3lpNVFPRnU4cGNuTnNPcUFRNG50YzBOcEtC?=
 =?iso-2022-jp?B?bTltNnhzbk5WSThVelZGMWJzemxjaTNUcDhyQmZvaDVnRXZGZm45Zldr?=
 =?iso-2022-jp?B?WlNpQWIrcWJ5ckNzMkNkVUk5aVowVXE3MVEydVpPeTBXditWRm1abG1D?=
 =?iso-2022-jp?B?SEhtNlZScDlDK3RMN2ZaM0V3V09Xa1gzNkc4WUVQYmdONDhUakdibks0?=
 =?iso-2022-jp?B?K1dDY0Q3ZDljc1dWZzhmQTc0ZkMzOWRrYnhZMC9UanFSUjY5d3BXUThO?=
 =?iso-2022-jp?B?VGdWVkUvZGN5NlZIK3lrQkdGVTF3QmtSbnRNU1paK2MrUmJOOFkvUFZk?=
 =?iso-2022-jp?B?dmRoYy9SY3pCWlcvQmx1T3BWY29QTnV2NDRlN2dtcWFqaFhWbVlqMkly?=
 =?iso-2022-jp?B?eTFhLzFhNHhmV2t6ejc4M0VZd0RIc0dWeGNHM1orZTFTYXVzQ3gva2Fz?=
 =?iso-2022-jp?B?VzVmSVdpc3BTNFF1QWMyTVpzSEVab1Y0dG9URVo4VnBwS3Y5YU5PaHo3?=
 =?iso-2022-jp?B?YStGU1lMcXQ1dDZ1MFd5UTBzSGpRNUo4ZFp5V3hsNjh1UkErMDdMVGVy?=
 =?iso-2022-jp?B?SjJDZUNxUmFpVGdoZm8xbXdrM3N5N0JjNDdYTGRhMWQxKzh6SHFZRWpP?=
 =?iso-2022-jp?B?M0d4MXdpRlJSaFNROERqMnNvNUhwOTNjbmNjRmUveURCRkIzc1JzaW5C?=
 =?iso-2022-jp?B?OD0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MWNCcU1PbmhKNDZNcEFZRzlnWWx1dlFJdnk0N0VneEcwRHhTSWMwMDZN?=
 =?iso-2022-jp?B?SXBZaWdVbnY5d3ROWkR2OUJGYjZSTENRYlk3dTJxM3JtRi9semNxZ011?=
 =?iso-2022-jp?B?U3MySWJidkMzTUxVV1VXdHlWRDFFVWVtT05QZktSQ2hhaFhNNDNIWmpX?=
 =?iso-2022-jp?B?T2l5Yzk1Qk5PZ2FkSzJBQVBHZmZJdmtMZVZsbFVWZG51MWt2cjlPbXMx?=
 =?iso-2022-jp?B?dzFPMllUenlDMVlMSEkvdG1aRjlob3NYMmxJUzZxTWJHWVl1Rm5wTHo1?=
 =?iso-2022-jp?B?MUpqV3VrS0Q0M0NFYkluakVINjAwaUNTczR3Q25sOHVQVHZRNkhuUzFn?=
 =?iso-2022-jp?B?OGZrWXpPMVg3ZjkrQktzamh6Nmxuckx5TmhLS21RYkp0dENJOXhBY2Yy?=
 =?iso-2022-jp?B?Qlo4dGhJYTU2M2tQaE9SVmozdmVNc0xCaUxlMnFmbm9ZUm90MW9oZUJV?=
 =?iso-2022-jp?B?U1pXSTh4L1B5cHQzUWsyQzBzRTVjM0Zrbk04bHVVU1hoN0tJZXk3QVRq?=
 =?iso-2022-jp?B?SEozb0o4dlh2aHlrZ0JtQ09zU3FudnpvR1cvQ0x5NUNtY1NGVVllRG9P?=
 =?iso-2022-jp?B?K2xBV1hNdzVqQU02SVNuVWkvWm4vTjBtSlhPWlhKcHhaUDV5Y2VaUWJJ?=
 =?iso-2022-jp?B?dGVUMWZsWU1zdDkvU1ZmOG1pdUtGTU5MVFZBTEZwNUExVFhZSDV1S0Ri?=
 =?iso-2022-jp?B?YXZmeURxcVhYUFNkejczUTRockg0cFlCTXZ4cGp1WWNBdG9WNTNnaU9S?=
 =?iso-2022-jp?B?TmM3VjdoOTI3R0lDNzVDUkhwYk85aGs4WjRFcGxpTC8vNnlTL0JCbGNS?=
 =?iso-2022-jp?B?eUErd21DWkRnbkdBSG9oKzV2RXZ3ZC9xeXplcngwUWFFam5vbjdyeHZP?=
 =?iso-2022-jp?B?TTRhTXZKWk9CRmowQlc5emJhM3d2NTBPYzUrWmhSbk5MTnNkL2c4eTVi?=
 =?iso-2022-jp?B?SktTY1RLYmRUcXhKNTlHTVptNTF2N3MwOEZlaG5jMHIxeXZ2cTRWc2k0?=
 =?iso-2022-jp?B?cUI3TlZBZHBLOUNTVURKTS9RdTlBZGMrZlg3aTV4V0VuaG9Zdm1EM3NU?=
 =?iso-2022-jp?B?Z3QzZStJdDN4dEwzT2xXNGs2b2pDNlh4dHF6Mjl1cW9WaGxONE5IYlRs?=
 =?iso-2022-jp?B?QSsyQUhDcmtDTzhtRkswa3U5bUs4alFUOFdSZTJDQmFJUm5mb2ZGSVpC?=
 =?iso-2022-jp?B?eDF5Q3hibkU0ME9NeFUvSnNFOHo5eHY0aEZCSnozSm5UcWRWQ1hIc1VC?=
 =?iso-2022-jp?B?Qmk3M1NlYVJEWWpuM2xtQW5hSG5PK2F5QlJySFFVRUNPNzBHaklOWTNT?=
 =?iso-2022-jp?B?dTlsTUg2d0JNYTdBV0VET0NqTHBSR25OclFjMHBzeTZLYlBuUDNzNmFX?=
 =?iso-2022-jp?B?UUQrdjR1am1QOHNJUXhid21ndHdueWdnbGszdGxZb2d5UGxXcmxjNi9R?=
 =?iso-2022-jp?B?bXExV21kRzN4elZiOVJDb1BWMW1vQUZVeGRlRFFrb0ZtanJxZEVaZ2J2?=
 =?iso-2022-jp?B?RVJ4NC9EYkgvck84TzArT2ZkdHlwc1dJRFI3aWhickgwQnFlWWVVYWdr?=
 =?iso-2022-jp?B?ZStDcktESHJNRkZtQXRsSHI5YzBtM3hOOU9xK001NytmNFd4dk9VRXRC?=
 =?iso-2022-jp?B?Rmw4QUh2cVJxRklxV3ErTldmaEV2cU4wQ25aQ3BsazdmRUFnUnUrR1F2?=
 =?iso-2022-jp?B?VnN6b3V0UC9xTEQ2T2dyNVlzY2Y0WTRMelowNHJBVFdySUp1OVdDUWx2?=
 =?iso-2022-jp?B?NUdyblhta2NQbHpFY2JPRW5sMG1Gc0V5WkY1TGJlVHVSNmlPMzNaVjNN?=
 =?iso-2022-jp?B?MjI5Y1ZqTU5kRFpiRW9MZEd6b0Zmd0dvTGVZNHQrcTRpMFNBWHJVekNn?=
 =?iso-2022-jp?B?ZnNYVi9NK3NqSFpkQktQbm9Mb3hvb3p0RWIxRzlkN3VsUjJndXIwYXIr?=
 =?iso-2022-jp?B?bkg1YnpHVSt6TXFoSVBlcVRIM204MW9kUFJ1UVpMQlFjTWZSRGZVWGpK?=
 =?iso-2022-jp?B?TkE4VWhyNkJ3bE5EM1Fxa2JZcHdxOEgyRVNVMy9vamEzN2VuUGN3TjNq?=
 =?iso-2022-jp?B?NmloYTNHVHVseTNua3Izb0FvK05MeWRpODZEY3U0NkFSOUhicGgwQTJB?=
 =?iso-2022-jp?B?TUFTczBQdFRtSkh6RDAwUFZ0dGtjSUNJN0g5ZVFqLzdHbzRoUVpoR3k4?=
 =?iso-2022-jp?B?dlFiV0drbGt0VlNJWEQvK0lMVjQyZkdLLzlZeUlQZks1OVVBdE0zWGxF?=
 =?iso-2022-jp?B?S0FpRjVaYTNGQzNBSExsTXRaMytaUTN4YmJmckh6M1ZkMk5WQ0VZQklm?=
 =?iso-2022-jp?B?MS94eg==?=
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
	MWrkgyHYPvCwtRZLE1zo+P5DynqdC5azi6XABkDPsU96pQ0GxyQ59rliaDVUg/HMezfr1ztZBg6AXiUVoubZt8+OGrSfITU1/3zMegmYC+vPU55Oe7o461Lz7q0007H5qcoYU5u6lEuBjL54V7koWacpSwiFXNEyeIliT99cJufXjLbTF+bF/9qPrijo13yxhl/45x/pVvPIQoBUQA3Fy9PQXDkwpEO8OXrY8BMXfJSpJtE70YJ5EVfmp0CbXQHdBsxdWL4NdJOEZ+i94oBuAPswRHqqpSAuyIm1f+dGbUrfUxsgSOaTReR4ELVITEQ2WEjMZh5cL86K7kDeezCfwckqpCHiwIBLFppB7kxNOyDB0c0iPDAb2/dUVWROkCzvNyCuIXF05vcLWcHbpnaEXK9/6VTztC+b2SsZ7GF/AsQHK9IswDsq8TTh2bZ/Blt4ENhtdojKyGDM9r6E3+PZRGHgSxbNZszwZWJ2Kpb6LW+Zj/pfqXENZ65yluD+SOpl0dhW3GJktKHIT7+e7X92mKEZfumZMFsF/t1NaZr1RQRG1bKaAJW8T42d114AiIyls3xpsOCnEtw1YpqFGD76Dt1Qwe0zXRhvOpj0+AzvlhJXiO20JCmQaW69kRuDU8cW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa19ce3-d790-4b17-257c-08dc85db47e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 03:46:42.9788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfk9lLEfZd1jQK0xmsC3X+qGczc+nVYsWg8W5nxvQ0RNjibOMNbsrbeQZiw6EI9Rm1UijM0lV5qzkaSfdasq+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8551



> -----Original Message-----
> From: Alison Schofield <alison.schofield@intel.com>
> Sent: Wednesday, June 5, 2024 11:55 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: dave@stgolabs.net; jonathan.cameron@huawei.com; dave.jiang@intel.com;
> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v5] cxl/region: check interleave capability
>=20
> On Fri, May 24, 2024 at 05:27:40AM -0400, Yao Xingtao wrote:
> > Since interleave capability is not verified, if the interleave
> > capability of a target does not match the region need, committing decod=
er
> > should have failed at the device end.
> >
>=20
> What happens now if the driver tries to program a decoder with capabiliti=
es
> it does not support?
Sorry, Currently I have not a real cxl memory device to verify this capabil=
ity,
I use the qemu to emulate the cxl memory, and it will decode the HPA to a w=
rong DPA,
and then the memory access will fail.

>=20
> Can you offer me the changelog here?  Definately in the next revision
> but also right here in reply to remind me of prior discussions.
OK.

    V4 -> V5:
    1. update comment.
    2. add nr_targets check while attaching a port to switch.
    3. delete passthrough flag and allow all the capabilities for passthrou=
gh
       decoders.

    V3 -> V4:
    1. update comment.
    2. optimize the code.
    3. add a passthrough flag to mark the passthrough decoder.

    V2 -> V3:
    1. revert ig_cap_mask to interleave_mask.
    2. fix the interleave bits check logical.

    V1 -> V2:
    1. rename interleave_mask to ig_cap_mask.
    2. add a check for interleave granularity.
    3. update commit.
    4. move hdm caps init to parse_hdm_decoder_caps().
> -- Alison
>=20
>=20
> > In order to checkout this error as quickly as possible, driver needs
> > to check the interleave capability of target during attaching it to
> > region.
> >
> > According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
> > Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
> > Capability Register' indicate the capability to establish interleaving
> > in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
> > be attached to a region utilizing such interleave ways.
> >
> > Additionally, bits 8 and 9 in the same register represent the capabilit=
y
> > of the bits used for interleaving in the address, Linux tracks this in =
the
> > cxl_port interleave_mask.
> >
> > Regarding 'Decoder Protection':
> > If IW is less than 8 (for interleave ways of 1, 2, 4, 8, 16), the
> > interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1=
.
> >
> > If the IW is greater than or equal to 8 (for interleave ways of 3, 6, 1=
2),
> > the interleave bits start at bit position IG + 8 and end at IG + IW - 1=
.
> >
> > If the interleave mask is insufficient to cover the required interleave
> > bits, the target cannot be attached to the region.
> >
> > Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > ---
> >  drivers/cxl/core/hdm.c    | 10 +++++
> >  drivers/cxl/core/region.c | 83
> +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h         |  2 +
> >  drivers/cxl/cxlmem.h      |  1 +
> >  4 files changed, 96 insertions(+)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 7d97790b893d..5b7dff19bbfa 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -52,6 +52,11 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port
> *port)
> >  	struct cxl_dport *dport =3D NULL;
> >  	int single_port_map[1];
> >  	unsigned long index;
> > +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
> > +
> > +	/* allow all the interleave capabilities for passthrough decoder */
> > +	cxlhdm->interleave_mask =3D GENMASK(14, 8);
> > +	cxlhdm->iw_cap_mask =3D BIT(1) | BIT(2) | BIT(4) | BIT(8);
> >
> >  	cxlsd =3D cxl_switch_decoder_alloc(port, 1);
> >  	if (IS_ERR(cxlsd))
> > @@ -79,6 +84,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm
> *cxlhdm)
> >  		cxlhdm->interleave_mask |=3D GENMASK(11, 8);
> >  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
> >  		cxlhdm->interleave_mask |=3D GENMASK(14, 12);
> > +	cxlhdm->iw_cap_mask =3D BIT(1) | BIT(2) | BIT(4) | BIT(8);
> > +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY,
> hdm_cap))
> > +		cxlhdm->iw_cap_mask |=3D BIT(3) | BIT(6) | BIT(12);
> > +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> > +		cxlhdm->iw_cap_mask |=3D BIT(16);
> >  }
> >
> >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *in=
fo)
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5c186e0a39b9..6b7400313cb2 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1054,6 +1054,7 @@ static int cxl_port_attach_region(struct cxl_port=
 *port,
> >  	struct cxl_decoder *cxld;
> >  	unsigned long index;
> >  	int rc =3D -EBUSY;
> > +	struct cxl_switch_decoder *cxlsd;
> >
> >  	lockdep_assert_held_write(&cxl_region_rwsem);
> >
> > @@ -1101,6 +1102,23 @@ static int cxl_port_attach_region(struct cxl_por=
t *port,
> >  	}
> >  	cxld =3D cxl_rr->decoder;
> >
> > +	/*
> > +	 * the number of targets should not exceed the target_count
> > +	 * of the decoder
> > +	 */
> > +	if (is_switch_decoder(&cxld->dev)) {
> > +		cxlsd =3D to_cxl_switch_decoder(&cxld->dev);
> > +		if (cxl_rr->nr_targets > cxlsd->nr_targets) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s:%s %s add: %s:%s @ %d overflows
> targets: %d\n",
> > +				dev_name(port->uport_dev),
> dev_name(&port->dev),
> > +				dev_name(&cxld->dev),
> dev_name(&cxlmd->dev),
> > +				dev_name(&cxled->cxld.dev), pos,
> > +				cxlsd->nr_targets);
> > +			goto out_erase;
> > +		}
> > +	}
> > +
> >  	rc =3D cxl_rr_ep_add(cxl_rr, cxled);
> >  	if (rc) {
> >  		dev_dbg(&cxlr->dev,
> > @@ -1210,6 +1228,53 @@ static int check_last_peer(struct
> cxl_endpoint_decoder *cxled,
> >  	return 0;
> >  }
> >
> > +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int =
ig)
> > +{
> > +	struct cxl_port *port =3D to_cxl_port(cxld->dev.parent);
> > +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
> > +	unsigned int interleave_mask;
> > +	u8 eiw;
> > +	u16 eig;
> > +	int rc, high_pos, low_pos;
> > +
> > +	rc =3D ways_to_eiw(iw, &eiw);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
> > +		return -ENXIO;
> > +
> > +	rc =3D granularity_to_eig(ig, &eig);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/*
> > +	 * Per CXL specification (8.2.3.20.13 Decoder Protection in r3.1)
> > +	 * if eiw < 8, the interleave bits start at bit position eig + 8, and
> > +	 * end at eig + eiw + 8 - 1.
> > +	 * if eiw >=3D 8, the interleave bits start at bit position eig + 8, =
and
> > +	 * end at eig + eiw - 1.
> > +	 */
> > +	if (eiw >=3D 8)
> > +		high_pos =3D eiw + eig - 1;
> > +	else
> > +		high_pos =3D eiw + eig + 7;
> > +	low_pos =3D eig + 8;
> > +	/*
> > +	 * when the eiw is 0 or 8 (interlave way is 1 or 3), the num of
> > +	 * interleave bits is 0, there is no interleaving, the following
> > +	 * check is ignored.
> > +	 */
> > +	if (low_pos > high_pos)
> > +		return 0;
> > +
> > +	interleave_mask =3D GENMASK(high_pos, low_pos);
> > +	if (interleave_mask & ~cxlhdm->interleave_mask)
> > +		return -ENXIO;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_port_setup_targets(struct cxl_port *port,
> >  				  struct cxl_region *cxlr,
> >  				  struct cxl_endpoint_decoder *cxled)
> > @@ -1360,6 +1425,15 @@ static int cxl_port_setup_targets(struct cxl_por=
t *port,
> >  			return -ENXIO;
> >  		}
> >  	} else {
> > +		rc =3D check_interleave_cap(cxld, iw, ig);
> > +		if (rc) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s:%s iw: %d ig: %d is not supported\n",
> > +				dev_name(port->uport_dev),
> > +				dev_name(&port->dev), iw, ig);
> > +			return rc;
> > +		}
> > +
> >  		cxld->interleave_ways =3D iw;
> >  		cxld->interleave_granularity =3D ig;
> >  		cxld->hpa_range =3D (struct range) {
> > @@ -1796,6 +1870,15 @@ static int cxl_region_attach(struct cxl_region *=
cxlr,
> >  	struct cxl_dport *dport;
> >  	int rc =3D -ENXIO;
> >
> > +	rc =3D check_interleave_cap(&cxled->cxld, p->interleave_ways,
> > +				  p->interleave_granularity);
> > +	if (rc) {
> > +		dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
> > +			dev_name(&cxled->cxld.dev), p->interleave_ways,
> > +			p->interleave_granularity);
> > +		return rc;
> > +	}
> > +
> >  	if (cxled->mode !=3D cxlr->mode) {
> >  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> >  			dev_name(&cxled->cxld.dev), cxlr->mode,
> cxled->mode);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 036d17db68e0..dc8e46a1fe82 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -45,6 +45,8 @@
> >  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> >  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> >  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> > +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> > +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> >  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> >  #define   CXL_HDM_DECODER_ENABLE BIT(1)
> >  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 36cee9c30ceb..6b8cf20ff375 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -853,6 +853,7 @@ struct cxl_hdm {
> >  	unsigned int decoder_count;
> >  	unsigned int target_count;
> >  	unsigned int interleave_mask;
> > +	unsigned long iw_cap_mask;
> >  	struct cxl_port *port;
> >  };
> >
> > --
> > 2.37.3
> >
