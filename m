Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9002C95;
	Mon, 21 Oct 2024 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729482295; cv=fail; b=P8G9DDVQexKogxBlhb9y9jjtty6L6a1zxT2mX9sGbDVd0BXoyScvUxZtBNjTe9quUmFnh1oUzc0BVstenRGckIe6CziiagGxr5tFh8OrR1+2cAc054NQ31u4lezqB4YxcejAeVNIMF0NMIDmkiKjddb1z5+kCGj1uu6UDi9yUl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729482295; c=relaxed/simple;
	bh=p7NBUoh01mxRw7oIF1076DGbQuRTseZ1nT8LQaCUXdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bMcB9PqN6lZ4LoJ4ltGWtx7MRMLoQsgDmnqRa/pvoFNgo6FoWRAO1WbXohhQF1PlG7RNqYvqwpzDEtSASpVJyAKPKgSE61M747+dpy+qws+lvPSV+D2ckry3ZLul0EIIPiiENVOLrpk/IsDd98/UplYSlgOBvSueolc2U40wPeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=vqIlxQMg; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="vqIlxQMg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1729482293; x=1761018293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p7NBUoh01mxRw7oIF1076DGbQuRTseZ1nT8LQaCUXdQ=;
  b=vqIlxQMgUWEWjrDx8LK8ukFQfhwfvKQf/O/v4qDdhZXST94PjoDnHn2q
   3IwMOAyi5yKIeWqeg6SlXXBVE8dAXYEbcW9zYX7N6QHA3S3CzDJBVAd9K
   8rcPZJJv7bFEDDG84xDj4XxYDvLziWYamBHW84KuWtAqKpzmvLX9Bz3cZ
   K/9dS63SiaAvSgTzyMZmxtTlJER8gU+vrWY8RYNiksWDBiZnETxq7bStf
   dz/atmy5v/13sqJ4I2Jdkrha/8YNtM0Kvlh5R1dxkb5G13BoB54B4USFq
   ntANswsDPSX1u+pnuheA+cTtBGcGGfrLJGPvD5Lw368Ml++a+TzE/2e6J
   A==;
X-CSE-ConnectionGUID: U7hUuiWVR4OH/Rl9hS3Jog==
X-CSE-MsgGUID: 5shSuSiFQvCJMvxarhZPhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="133774248"
X-IronPort-AV: E=Sophos;i="6.11,219,1725289200"; 
   d="scan'208";a="133774248"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 12:43:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTI+jeAQU1ZleNxq/0FGmcGAvPMyCbqEWipKOLOg+AXd1EKzl36VbxXlgY3bRvbs5YWds1R6ES0rXmVzMwHhl8mCsC6s7cWE1DTv+G8rJhBgTfZKDpb1Uz6TcT6gIEuIlDCO0mAJXmZ3DhnOi/M2/fKSc6CjjdBxIfwiSW0tvjBa2oiIauBvsFDP6rS6oTGEsLEn6/onYrpz5r6/CwWAGS6g6ntCdXlErlubI5D9XCCHrqu8JYSRP+WzZqaA2+0n7JermKFprG7cGqV6turcqbQmVd1E+XtQO77jp/OHRz+9tiyBwnSPFfmUeU5oTdDSUzzlrQJk8jU8MaFp1lkPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7NBUoh01mxRw7oIF1076DGbQuRTseZ1nT8LQaCUXdQ=;
 b=yDVqtq5GzQUTx3BHNKLeOjNzV9IxGbg9qkIpK9mIpfPvKXz3vLXbkSVy3iauKCqJWHEXirxeg39JEpJ7qB+8iwHIfytyBLrAuQOj16OzUwoXE1MxEAlsAaoxrVMZ1+F6TF841CeI0BZE75HrQlCMg+F+IHx7uu9FwoiHojkFgB25UiBhFqtP0g2CpkpxYU81lGQn6S9LYl6HMFdQL81d/Nn3W8FEaWV7aE8Dzg1zjr72cJYS1j2g817gBAdgWFFZiuhmoQpzteo0NtSMUDM7wulu8UsczcDog1hjZSwnBbn3w3ny/g3LqDvIZDbEqbdie92mrSHI1SKGwqunVbhLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYVPR01MB11203.jpnprd01.prod.outlook.com (2603:1096:400:367::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 03:43:35 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%7]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 03:43:34 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] testing/cxl: Fix abused pci_bus_read_config_word() on
 platform device
Thread-Topic: [PATCH] testing/cxl: Fix abused pci_bus_read_config_word() on
 platform device
Thread-Index: AQHbH23uJdSf+OABWUWw3eaopYja57KLqOUAgAAP8gCABN8YgA==
Date: Mon, 21 Oct 2024 03:43:34 +0000
Message-ID: <627bb352-29dc-457f-a383-0dd399f55ab1@fujitsu.com>
References: <20241016015213.900985-1-lizhijian@fujitsu.com>
 <ZxGqYPGNaVWoLuP6@aschofie-mobl2.lan>
 <6711b7c0c0b53_3ee2294a6@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6711b7c0c0b53_3ee2294a6@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYVPR01MB11203:EE_
x-ms-office365-filtering-correlation-id: f0e67be8-f4a3-4b23-49df-08dcf1828a41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkFCQWtxdzk0Zk1ZUG9XU00xSUt0cDhEMFJpQU9XVlZSVFdJdnJlNENnOTJP?=
 =?utf-8?B?eEY2dmE1WHRlajBFN1RHWHhxSUlZU0MrcGliaHcwUjdyS3hUc3RUcUhtSVF5?=
 =?utf-8?B?N2daWlJkOTJRNlJCMlVQNmQweFU0eVV6eFpkank3cTl5NTNtUUpwaVBpcXJw?=
 =?utf-8?B?UEw3bmhtNFdqR2crYmRWaXBGcDJEbXNtWWxKNnllN2JCUGpScE5rUktkOVpG?=
 =?utf-8?B?TEJiWWVqZEY4WHUzYXZIVmp1Mml0ZThJeCt1Tk1rTkIwc3hjQzJqcTBITkda?=
 =?utf-8?B?TmpvbVZ4bDlHWGxNSmFueTZqcVJNYWlDeWF4SlhMYnVsRjZlV1grZXRINDFl?=
 =?utf-8?B?am9NZHNxUWtmd0ZWU2Q1UlVUSGV2N1J5b2tWRHBQYXppUE8wd0ZtMWdyOU5O?=
 =?utf-8?B?cnY4Q1M5N2NtdjR6ODBrSHBBeXZGY1VLamZDaEhXZE9wcDE3UVVtNDgwQ0tv?=
 =?utf-8?B?b2ltVi80SDdZSndWZm10K0Y3cFNWN2N4SkJCTjQzWndLRUZ2MlRaRFo5UExX?=
 =?utf-8?B?OVI2Z0huR3RLN3JPRm5DdnV0WDJzWHFHZG53WmNIK3VvYWh5RUN5ckozUTZR?=
 =?utf-8?B?MWIyTEdydlBVNTNRTjFPVmRid3JPNTVhV2R6SGNiUW8wd2VKOTZGRXNIL1kv?=
 =?utf-8?B?dlJmem5NTk5qRTdiZnAzUjQ4YU5UeWVXaENvYWxaYklhTzVINDVSNlM0eGJQ?=
 =?utf-8?B?RkpxYUdGM0pjNzdCOVpDQ2hvTlQxMWl5YUtiODhuTWRTNklmTTZCQmd0ejA1?=
 =?utf-8?B?dThIc3Y2QUhXUEJIc0plOFFkeDF6cUJZQk90QTY2UmRTcGhYQlNqZFExc2xR?=
 =?utf-8?B?YU84eWRPb2NCd3V1M3UwaWxMSEVkMjV4ek9waSt1dHBaNko1SVUwRUgybW5Z?=
 =?utf-8?B?blkyVXhIN3JPbFFtTUZnVGE3NHJJcUlDakhjbDErbU5xck15cEZiVnpzRm5z?=
 =?utf-8?B?VmNka041STN0M1N0eTZEbTdkU3VoRktCajY1RGpMSlJnWUVNSUR1ZFJIZ2Fz?=
 =?utf-8?B?dUx5eEZZcWpydHExL3p4Nm9oZ0I0Um94ZGtmTUY4NnloS0c1ZFdwQmc0VUdl?=
 =?utf-8?B?ZDNWYVZMdkxGNzZSL0VxV1pvQzhGMUdwOVdCTGVmSjZJWmpoRzRnTjBaemR2?=
 =?utf-8?B?ZTNjZ01BV0xzNGc1S0lmWGVvTDRuKzVibE11VGI1Z2hGbnNYWGUrblBXQmhF?=
 =?utf-8?B?RjNXV25IQy9aMTFJRDloTFN1UzdXQk1hR0hwRVVYK1c5L25vdWtidDM3Y3NY?=
 =?utf-8?B?RlRRS3F5MEJqK2VJd3BjOVZIMzZzTVUxRWw0WXlFdU4yaHhGb0VxMFFhdEdn?=
 =?utf-8?B?TGtuVUVFNWtSNDl0dmVJbjUrM2ZKZWxZbWdEWmpFbXVDUnhpU2REZGdhM2RY?=
 =?utf-8?B?blRnSHd2TU82aU96RFhVREo5TEwvMFFYSENXcU1xak5jbXVjUjhUZExjWXly?=
 =?utf-8?B?VklzL1JmSkdSaVZTTCtBTi8rL2p3MFhqakRFWWtxQnVVTk1idTM3dnN3RSsx?=
 =?utf-8?B?WElnWk1YMEc0UEEzRTNjdDlKUDExc29yNm4ySE1pRHFrR1NQZ2hTb3dCNWly?=
 =?utf-8?B?QTNINjdFQm55dTBRV0FUMkhQNlo3ZExjcmx0SUxVK28xR3l2Sk5oM3hJVm9y?=
 =?utf-8?B?R1dtK2VSMmdyQnJaNk83WldpMG91c2YyK1BsRnRTQ0xCMHlIRVk0UCtnWG0w?=
 =?utf-8?B?Tjg4V3FUelArN0xUZWh1NDRPYkI3RGxub3c0WHhhQnVyOWlXdG82L2k1SE93?=
 =?utf-8?B?anNpL09sYmk3VHU4RENpakcyL00yL1JlMUFtMENGKzB2NXprd2JsYjJiRmlk?=
 =?utf-8?B?djFrcmVudnRaM2s4bnJDejMrOG1EUndHT2RMNTNOcXphR1hyaStUYnpQNlZl?=
 =?utf-8?B?K3AvZ0tGYThvdXJPL1VzSWV5Y0dNVWpHa2Q2MXhKOHBIZUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3BEZHZtOG9sMnBJUlgvMGZQUmw4Q0lDK0xvK0ZrTnFrN3plN2RPTGhUVFE2?=
 =?utf-8?B?S1hnQnBkWG1yTHBzekNTOWpJRVhMT29LbmNTZ2gxN1h5c2p0cU1GT3UrQ3dW?=
 =?utf-8?B?Y2FkelNucllRYkZ0eGppb0ovZGw5cUs5bWUxbzk5THVVM1VReUpjZzVYLzZx?=
 =?utf-8?B?ZW52SjFkZHVra1pqOUdKNFZ4bEVJOGNMRU4zNGd6NjBQSy9uY2REUjgwN0hI?=
 =?utf-8?B?QnpSV1k2Ykx3OGhMTkNTK0hoek1yVzgyWmM5TnJCTGEwQWJOUWdHQ2FyUVNm?=
 =?utf-8?B?SVN0SzROWmNqZkhkOWNmbklZNmkwdFdWUkpTRlN2eWZkUU9BODJ3RVNTR2pa?=
 =?utf-8?B?NEF0bitTb2kwcmZpaTBjbkgvbkthMVFMTloyZ2RheUVHMEp5U1l4SkRISmZE?=
 =?utf-8?B?c2hlMnhqYjVmZmNtcjlKT3FvcTlXTS9KVGhnV21FNDdOaWFCb2FJSTMyMm81?=
 =?utf-8?B?UCtOamJMY0JWZmpZTFF0Sms5OFQxZGdrQkpnN2RTRDB3RGNTVkNXcHZXRmRJ?=
 =?utf-8?B?VUt3NXZkK2xQc0MrTTNHcVNTeFJNK0NXbzRFcFowTTBiZkt1amptam5va3h5?=
 =?utf-8?B?MldJc2cwY2w1M2l5eHpUdFoyNG0wbXZGSUIxWDQ1TDFtMk1iWXpoT21VWTJM?=
 =?utf-8?B?Rm4rZnovcUo4YmUxbVNNRFBYb3ZhWlhkWmdDVWljSWlQSEVTblU4VHZVTFR6?=
 =?utf-8?B?eDBWTGk1WjBwVDQ0ZlY1UzBMMmhSZVNpanJOZ1ZKSjhZQWk2OWQ0cWdoT3ls?=
 =?utf-8?B?bVBaeVh3UzlzdytDU1pPMTFNM0tBcEVoQlNLUUZHM29xSzkzU1hIVzhMTVZt?=
 =?utf-8?B?WnNXZTJubnMzRE1nR1ZucGRUMlJPbjZoeGF5eWJIcUhyUC9nY2VJUWNFQmVX?=
 =?utf-8?B?YUt4RTdFK1VZMG1ZTDRyNWE2QWQyaXZkbWsrZDNDOXNhVlo0QU9iQ2twTjly?=
 =?utf-8?B?K0ZQZUtLa0x0R3ZBb2RkQ1VKRERnV29iMGxuSVg1NEE0YVZERzZKRFJESzQ0?=
 =?utf-8?B?V2QyYnJaUDBPMlJUOFJBMmpkcmFoeElKb2M3RUVLTGxwWWhWQ3lqdjNnZTAx?=
 =?utf-8?B?MllRV1BDVDdKQ01UdUR4enArVmZ0KzdVVmkyc2xvQm9tOG5nUEtYNHhTSU9j?=
 =?utf-8?B?V0JucEV0UUJqTDM0UzdCeUcxbHcrQ1BGclppcTJQT0ppdEdQS3VVS00rWmdV?=
 =?utf-8?B?UDVudnFxYVJLTlBTRnFpWlZFeHdQam1GVjJ3RWRldVFjV1lVZnRBOUtQRDFI?=
 =?utf-8?B?bmU2aFJ6ZzJUbG5tRkVXL3Q0V2t6a3hQNlltYzROdjFTYmFiV1JNZFRhQ1lh?=
 =?utf-8?B?RTh6c255SXBnREpJSUxCM05EODdVM0M5T2JOYy94ZFNteXEyTXRwcEI3UjZG?=
 =?utf-8?B?dytadkQzWjN1TVRyV0VHZGkwdk9VNlNYRTgrVzRtWm1HSzhuV0wvcmtmRzFi?=
 =?utf-8?B?NDJVcmlwRGZ0VW12OURSY3I2ZUcveW1IQmN0eW8wQ1NXR0NPYUNNMFNxWnpE?=
 =?utf-8?B?c1c2VS83ODNNR3hzdDFMZFdvdS9DclhRVzE5WlBHVFAxNDAwV1RFb1NKVGpX?=
 =?utf-8?B?Wi9CakxVd2RMTlRZMENGclNjQzY2dGptdjJ1ekRJeU4xV2dGS0xhTkdzcGhX?=
 =?utf-8?B?N29yRGVQZHlOckZaNG8zTmR3WjAxMnJKaEF0bVQ3RVpqRVdvNmtCait5NUZY?=
 =?utf-8?B?R2tkZTBOQjVveEtjNCtvclVpTTArdXVsQndhNmJlbE5wNjAyMTZGd2hVSGF3?=
 =?utf-8?B?REN3Ykk0L3hoSU1VMkhSaDcvVzNUbEMwNHl5eU5GUUM2S3h0TEFSdlk3dFkz?=
 =?utf-8?B?dm45M1Y5WHZRMlN6bWl6THBUUXpMSTlFSTlxM1dNL2lIc3VoTW1Uc1BsVll6?=
 =?utf-8?B?OTRONVhPQk9oS284WVhEV3QzQkcvTG0vd3F0MFJwMW9GdC80VTdzZzZGZklW?=
 =?utf-8?B?Wjd5dmJlV3JKa3pZa3VtajhuZVZlY1EwcnROU0FLQWc3WUVTWkFtREwwNTJ6?=
 =?utf-8?B?Mnl4bmllOTBicVpHK1c4UlgxOUw1Z2FNdHpiQU1xMzBRNzlHRFQrUHg4TVZL?=
 =?utf-8?B?WFpHeFRScXdYMjlacFA0dnFpY3FNcERibC9PbTkzbjV3V01hNW40UytYMUVO?=
 =?utf-8?B?M0lRc3RWbE1kUnhQdzE3UmNySzRtTkx3RnBSajlDWXg0UVlwWStGK01DYWds?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41C71483130AB54AA52A22D2F68ADEAB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	98WZ+SsXvUO8r5T9Pgu/9jMBic4YXwHKK8KFWqZNAkaB4ZKsXszyDdyUULpdoeyLKYNUoeYKNtPXDtPJbGTbctKoJwHVrhNpuIgjbWwPEFaNpZMVIPibAreZDEkgaA4AsaK+OFwyBLDxttnjxftugVpvw9zP9BDtM1v2VodcGPe9mpNnKCDuiRX2+q3ffsN7hyAMhVmnHOm63WGEtWuPG69Jmu0EG7kRC3wmqIGPt8XnYDis3LQWzKqJCWwBJ0e95WJvU2xq5E9kMFIdziCoqO0OfwfEr3TO+CL85fbQR/T7kE2E5W7AnCu4VNo03vHnGXwS2KC0Df+6d+E7345ydaTfiI6HT0nU+bIIcmBArnLz35CMjttYoRKCiW2XOKkWqg3VOBWq4LWybhKIgmnfWK5+sPKIA2d4ssA4tRYGARorLHrxJ8YtnRoyr7NtoDUZRq48AUq4LG2I67VZ5yvURk9edh9S/3CtJJEJmPpmPvBGi33NrL0TrNZSZPAD8K9sTSJHrGt9dGbjlX+Bf6QI002308tWHbY3ddBWFAw9lCpQiCRc2T3y58/756Ogu30xkNVrESl+f5CLp6PP0B0dCc/CJwimNDCZagIpklnhty5eF250rMq9NvWkMq6yp3/+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e67be8-f4a3-4b23-49df-08dcf1828a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 03:43:34.6598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qgnaNV4iVABPpO63EjaR3VK26URZEZX/Q5/KOsXJ7vZzblp3LPlnILmLRMvh6/8OOm+8TRXI+efI2+w46ST9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11203

SGV5IERhbiwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4uLg0KDQpJIHdhbnQgdG8gY29uZmly
bSB3aXRoIHlvdQ0KDQoNCk9uIDE4LzEwLzIwMjQgMDk6MjAsIERhbiBXaWxsaWFtcyB3cm90ZToN
Cj4gQWxpc29uIFNjaG9maWVsZCB3cm90ZToNCj4+IE9uIFdlZCwgT2N0IDE2LCAyMDI0IGF0IDA5
OjUyOjEzQU0gKzA4MDAsIExpIFpoaWppYW4gd3JvdGU6DQo+Pj4gVGhlIGN4bF9yZWdpb25fc2hh
cmVkX3Vwc3RyZWFtX2JhbmR3aWR0aF91cGRhdGUoKSBpbiBjbHhfY29yZSB3b3JrcyBvbg0KPj4+
IFBDSS9QQ0llIENYTCBkZXZpY2Ugb25seSB3aGlsZSBjeGxfdGVzdCB3YXMgaW1wbGVtZW5ldGVk
IGJ5IHBsYXRmb3JtDQo+Pj4gZGV2aWNlLg0KPj4+DQo+Pj4gTW9jayBhIGN4bF9yZWdpb25fc2hh
cmVkX3Vwc3RyZWFtX2JhbmR3aWR0aF91cGRhdGUoKSB3aGljaCBkb2VzIG5vdGhpbmcNCj4+PiBm
b3IgY3hsX2NvcmUgc28gdGhhdCB0aGUgY3hsX3Rlc3QgZ29lcyB3ZWxsLg0KPj4+DQo+Pj4gQWJ1
c2UgY3hsX3JlZ2lvbl9zaGFyZWRfdXBzdHJlYW1fYmFuZHdpZHRoX3VwZGF0ZSgpIG9uIHBsYXRm
b3JtIGRldmljZQ0KPj4+IHdpbGwgY2F1c2UgYSBrZXJuZWwgcGFuaWMgd2l0aCBjYWxsdHJhY2U6
DQo+Pg0KPj4gc25pcA0KPj4NCj4+PiAtLS0NCj4+PiAgIHRvb2xzL3Rlc3RpbmcvY3hsL0tidWls
ZCAgICAgIHwgMiArKw0KPj4+ICAgdG9vbHMvdGVzdGluZy9jeGwvbW9ja19jZGF0LmMgfCA4ICsr
KysrKysrDQo+Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4+PiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL2N4bC9tb2NrX2NkYXQuYw0KPj4+DQo+Pj4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3RpbmcvY3hsL0tidWlsZCBiL3Rvb2xzL3Rlc3RpbmcvY3hs
L0tidWlsZA0KPj4+IGluZGV4IGIxMjU2ZmVlMzU2Ny4uZWQ5ZjUwZGVlM2Y1IDEwMDY0NA0KPj4+
IC0tLSBhL3Rvb2xzL3Rlc3RpbmcvY3hsL0tidWlsZA0KPj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
Y3hsL0tidWlsZA0KPj4+IEBAIC0xNSw2ICsxNSw3IEBAIGxkZmxhZ3MteSArPSAtLXdyYXA9ZGV2
bV9jeGxfYWRkX3JjaF9kcG9ydA0KPj4+ICAgbGRmbGFncy15ICs9IC0td3JhcD1jeGxfcmNkX2Nv
bXBvbmVudF9yZWdfcGh5cw0KPj4+ICAgbGRmbGFncy15ICs9IC0td3JhcD1jeGxfZW5kcG9pbnRf
cGFyc2VfY2RhdA0KPj4+ICAgbGRmbGFncy15ICs9IC0td3JhcD1jeGxfZHBvcnRfaW5pdF9yYXNf
cmVwb3J0aW5nDQo+Pj4gK2xkZmxhZ3MteSArPSAtLXdyYXA9Y3hsX3JlZ2lvbl9zaGFyZWRfdXBz
dHJlYW1fYmFuZHdpZHRoX3VwZGF0ZQ0KPj4+ICAgDQo+Pj4gICBEUklWRVJTIDo9IC4uLy4uLy4u
L2RyaXZlcnMNCj4+PiAgIENYTF9TUkMgOj0gJChEUklWRVJTKS9jeGwNCj4+PiBAQCAtNjEsNiAr
NjIsNyBAQCBjeGxfY29yZS15ICs9ICQoQ1hMX0NPUkVfU1JDKS9wY2kubw0KPj4+ICAgY3hsX2Nv
cmUteSArPSAkKENYTF9DT1JFX1NSQykvaGRtLm8NCj4+PiAgIGN4bF9jb3JlLXkgKz0gJChDWExf
Q09SRV9TUkMpL3BtdS5vDQo+Pj4gICBjeGxfY29yZS15ICs9ICQoQ1hMX0NPUkVfU1JDKS9jZGF0
Lm8NCj4+PiArY3hsX2NvcmUteSArPSBtb2NrX2NkYXQubw0KPj4+ICAgY3hsX2NvcmUtJChDT05G
SUdfVFJBQ0lORykgKz0gJChDWExfQ09SRV9TUkMpL3RyYWNlLm8NCj4+PiAgIGN4bF9jb3JlLSQo
Q09ORklHX0NYTF9SRUdJT04pICs9ICQoQ1hMX0NPUkVfU1JDKS9yZWdpb24ubw0KPj4+ICAgY3hs
X2NvcmUteSArPSBjb25maWdfY2hlY2subw0KPj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L2N4bC9tb2NrX2NkYXQuYyBiL3Rvb2xzL3Rlc3RpbmcvY3hsL21vY2tfY2RhdC5jDQo+Pj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjk5OTc0MTUzYjNmNg0K
Pj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi90b29scy90ZXN0aW5nL2N4bC9tb2NrX2NkYXQu
Yw0KPj4+IEBAIC0wLDAgKzEsOCBAQA0KPj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vbmx5DQo+Pj4gKy8qIENvcHlyaWdodCAoYykgMjAyNCBGVUpJVFNVIExJTUlURUQu
IEFsbCByaWdodHMgcmVzZXJ2ZWQuICovDQo+Pj4gKw0KPj4+ICsjaW5jbHVkZSA8Y3hsLmg+DQo+
Pj4gKw0KPj4+ICt2b2lkIF9fd3JhcF9jeGxfcmVnaW9uX3NoYXJlZF91cHN0cmVhbV9iYW5kd2lk
dGhfdXBkYXRlKHN0cnVjdCBjeGxfcmVnaW9uICpjeGxyKQ0KPj4+ICt7DQo+Pj4gK30NCj4+DQo+
PiBUaGUgYWRkaXRpb24gb2YgZmlsZSBtb2NrX2NkYXQuYyBtYWRlIG1lIHdvbmRlciB3aHkgdGhp
cyB3cmFwcGVyIGNvdWxkbid0IGpvaW4NCj4+IGFsbCB0aGUgb3RoZXIgX193cmFwJ3MgZGVmaW5l
ZCBpbiB0ZXN0L21vY2suYy4gSSB0cmllZCwgYXMgeW91IHByb2JhYmx5IGRpZCwNCj4+IGFuZCBz
ZWUgdGhlIGNpcmN1bGFyIGRlcGVuZGVuY3kuIEkgbWVudGlvbiBpdCBoZXJlIGluIGNhc2UgYW55
b25lIGVsc2UgaGFzIGENCj4+IHdheSB0byBzaW1wbGlmeSB0aGlzLg0KPiANCj4gWWVhaCwgdW5m
b3J0dW5hdGVseSBzeW1ib2xzIGNhbiBvbmx5IGJlIG1vY2tlZCBhY3Jvc3MgRVhQT1JUX1NZTUJP
TCgpDQo+IGJvdW5kYXJpZXMsIGJ1dCBzaW5jZSB0aGUgY2FsbGVyIG9mIHRoaXMgaXMgaW50ZXJu
YWwgdG8gdGhlIENYTCBjb3JlIGl0DQo+IGlzIG5vdCBhbWVuYWJsZSB0byB0aGUgd3JhcCBhcHBy
b2FjaC4NCj4gDQo+IFNvLCB1bmZvcnR1bmF0ZWx5IHdoYXQgdGhpcyBwYXRjaCBkb2VzIGlzIGJy
ZWFrIHRoZSBleHBlY3RhdGlvbiB0aGF0DQo+IGN4bF90ZXN0IGNhbiBsaXZlIGFsb25nc2lkZSBh
bmQgbm90IHJlZ3Jlc3MgYW55IHByb2R1Y3Rpb24gZmxvd3MuIEkuZS4NCj4gd2hhdCB0aGlzIHBh
dGNoIGRvZXMgaXMgcmVwbGFjZQ0KPiBjeGxfcmVnaW9uX3NoYXJlZF91cHN0cmVhbV9iYW5kd2lk
dGhfdXBkYXRlKCkgZm9yIGFsbCB1c2UgY2FzZXMsIG5vdA0KPiBqdXN0IHBsYXRmb3JtIGRldmlj
ZXMuDQoNClllcywgdGhhdCdzIHRydWUuDQoNCg0KPiANCj4gQ29tcGFyZSB0aGF0IHRvIHRvb2xz
L3Rlc3RpbmcvY3hsL3Rlc3QvbW9jay5jIHdoaWNoIGFycmFuZ2VzIGZvciBhbGwgdGhlDQo+IG1v
Y2tlZCB1c2UgY2FzZXMgdG8gY2FsbCBiYWNrIGludG8gdGhlIHJlYWwgcm91dGluZXMgaW4gdGhl
IHJlYWwgZGV2aWNlDQo+IGNhc2UuDQo+IA0KPiBHaXZlbiB0aGF0IEkgdGhpbmsgdGhpcyBwdXRz
IHRoZSBkZXZpY2UgdHlwZSBjaGVjayBiYWNrIGluIHBsYXkuDQoNCkp1c3QgdG8gY29uZmlybSwg
ZG8geW91IG1lYW4gYWRkIGRldmljZSB0eXBlIGNoZWNrIHRvIGRyaXZlcnMvY3hsL2NvcmUvY2Rh
dC5jDQoNCi0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvY2RhdC5jDQorKysgYi9kcml2ZXJzL2N4bC9j
b3JlL2NkYXQuYw0KQEAgLTUsNiArNSw3IEBADQogICAjaW5jbHVkZSA8bGludXgvZndfdGFibGUu
aD4NCiAgICNpbmNsdWRlIDxsaW51eC9ub2RlLmg+DQogICAjaW5jbHVkZSA8bGludXgvb3ZlcmZs
b3cuaD4NCisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQogICAjaW5jbHVkZSAi
Y3hscGNpLmgiDQogICAjaW5jbHVkZSAiY3hsbWVtLmgiDQogICAjaW5jbHVkZSAiY29yZS5oIg0K
QEAgLTY0MSw5ICs2NDIsMTMgQEAgc3RhdGljIGludCBjeGxfZW5kcG9pbnRfZ2F0aGVyX2JhbmR3
aWR0aChzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciwNCiAgICAgICAgICB2b2lkICpwdHI7DQogICAg
ICAgICAgaW50IHJjOw0KDQorICAgICAgIGlmIChkZXZfaXNfcGNpKGN4bGRzLT5kZXYpKQ0KKyAg
ICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KKw0KICAgICAgICAgIGlmIChjeGxkcy0+cmNk
KQ0KICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQogICANCg0Kb3INCg0KdG9vbHMv
dGVzdGluZy9jeGwvbW9ja19jZGF0LmMNCg0KI2luY2x1ZGUgPGN4bC5oPg0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgDQp2b2lkIF9fd3JhcF9jeGxfcmVnaW9uX3NoYXJlZF91cHN0cmVhbV9iYW5k
d2lkdGhfdXBkYXRlKHN0cnVjdCBjeGxfcmVnaW9uICpjeGxyKQ0Kew0KICAgICAgICAgZm9yIChp
bnQgaSA9IDA7IGkgPCBjeGxyLT5wYXJhbXMubnJfdGFyZ2V0czsgaSsrKSB7DQogICAgICAgICAg
ICAgICAgIHN0cnVjdCBjeGxfZW5kcG9pbnRfZGVjb2RlciAqY3hsZWQgPSBjeGxyLT5wYXJhbXMu
dGFyZ2V0c1tpXTsNCiAgICAgICAgICAgICAgICAgc3RydWN0IGN4bF9tZW1kZXYgKmN4bG1kID0g
Y3hsZWRfdG9fbWVtZGV2KGN4bGVkKTsNCiAgICAgICAgICAgICAgICAgc3RydWN0IGN4bF9kZXZf
c3RhdGUgKmN4bGRzID0gY3hsbWQtPmN4bGRzOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQog
ICAgICAgICAgICAgICAgIGlmICghZGV2X2lzX3BjaShjeGxkcy0+ZGV2KSkNCiAgICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm47DQogICAgICAgICB9DQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICANCiAgICAgICAgIGN4bF9yZWdpb25fc2hhcmVkX3Vwc3RyZWFtX2JhbmR3aWR0aF91cGRhdGUo
Y3hscik7DQp9DQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gDQo+IEhvd2V2ZXIsIGluc3RlYWQg
b2YgY2hlY2tpbmcgImRldl9pc19wbGF0Zm9ybSgpIiBjaGVjayAiZGV2X2lzX3BjaSgpIiB0bw0K
PiBiZSBjb25zaXN0ZW50IHdpdGggYWxsIHRoZSBvdGhlciBDWEwgY29yZSBpbnRlcm5hbCBmdW5j
dGlvbnMgdGhhdCBleGl0DQo+IGVhcmx5IHdoZW4gcGFzc2VkIGN4bF90ZXN0IGRldmljZXMu
