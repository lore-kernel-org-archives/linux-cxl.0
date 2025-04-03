Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61E5D8F0;
	Thu,  3 Apr 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669165; cv=fail; b=JmqsU4N6AFWl4SUNbczGAX7aUTzRFtygKyQfSma8TGYRlSANOyuV9KNaktvoT9xrVppsRruunwbiyUuYA2uiqNJzg6PjB4EFnAn3Tudc9Zte9C5pdLMzsOaCHzBAAWK6Uf0JRhnCCpxmk1GDqTI2KyjPGjsders95ULj2LCYVac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669165; c=relaxed/simple;
	bh=G3EYLFIpv9QSlD1Ytg3Ht+v0x9y+TSsUVoplO3bz/Jw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Me/djKt9YqjLv4Tza+NI7ta/3BgQOwfxKhCDmrwUkEzOgT4v20IZv59FLsNGn41HCm6VR5sNVEpCGd1kK8LrJoRWsombLl6/oXkdpvF62EEV8iufMyhmo3OM5eeRQ6x4LLs5x3WzGqzKgszwBtByKJfaXbd8y3w4qD1gWRS2hNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=t5LfNtDy; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="t5LfNtDy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743669162; x=1775205162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G3EYLFIpv9QSlD1Ytg3Ht+v0x9y+TSsUVoplO3bz/Jw=;
  b=t5LfNtDy/7Z19fOMMr+ifjQUJmS8AFBXN/46/BfQN07/WpEbRLJDhI+n
   o3jR8d2fdsI1PYuiXtaM44QHQ7Dn0xiN+wdmFYnoqt2GSNSpJNYG8/pEw
   JijBLn59gfnYBYalGmg4JelrqBjANmC3wqB4YDvgNU5xF9cNuXvMRpxJJ
   7NX3ZMlSQ3ctpNjV2cMXx+Pc+dXfbILlpCSZajhF6Hm/BiR0PD86CZhyT
   jCEP1Wx8vlAgNaNrnL8UvKHJlmaHm7nNdQDznBd2iqesK3cS2znbRkmfu
   3xy+UVyD5sMgQrb3lE6XFrLjkbP3kDWvXVyYjwFXkG4I/JM88qmOzLU/c
   w==;
X-CSE-ConnectionGUID: 4LGF/53uQ6aQYUz9L14sgQ==
X-CSE-MsgGUID: XKgydTjnQNKjtQLuBBcjog==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="151708205"
X-IronPort-AV: E=Sophos;i="6.15,184,1739804400"; 
   d="scan'208";a="151708205"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 17:31:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/DYeZ9zkITsjuSHttWq/qt9DPvzJtqOaJNZprKmA7SEvuT0XzxbGoLEyygzuRicqUOVvu3K0hCO6YvasJWOXe5ES3xj6Y2DbUppY4IoKPxHyvBseNYVJwCdIBlfCUsU0JUBR5J8btjVfJxsyLOSTQ+u1itR+lkRav4kRNb9RdKSJv+jTZ7DtkppT/pXhqJxSLKqThpy0qkakqNYqe66x9slrU6tP+lLK8vDA1W01eGECO3wqPp7XzfEMUGL5uyOWGCjwpwrZ3o4NC6VEu9U3EeT9KZgc36XL1SUHNf7vzb9xz9BHOzUwbgdrrR/W7q+8WZCYUefbOa9WpCzMxI5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3EYLFIpv9QSlD1Ytg3Ht+v0x9y+TSsUVoplO3bz/Jw=;
 b=uw5ZtqvGQDMR81mlfgEJGEcVk1+lAaT7YxW3VZjHF5yJrmu6+4HYpdJT6dLBTimInBsgrjkcLbNMgx3+TxlMCJgQ2yJTit8MRm4WxT86KF5PVVS0q78nHd99NsSoyn859igypw6R7YBV2fe4+w1BPJFQq2lkd9Yo3x7u20eM7Y+NikWq6aR0CxL5fVi0IyebUn7/G50MTtxUYKsdhVRgZsPIrPe07TehP+VXRKAoOwqWeQ6eZvfnBU0hakiz3gAvW+1vrL3HyrWATgjoFLwJRe0hAroau6rl4hrmcRoV5IUInEgv+5WoOo5WXbc2jVCR9mmyxjN6H5yXDzWHFIQeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYRPR01MB15122.jpnprd01.prod.outlook.com (2603:1096:405:227::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 08:31:23 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 08:31:22 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, Gregory Price
	<gourry@gourry.net>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Thread-Topic: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Thread-Index: AQHbpCaxQHh+ea79DEe/ckQgeqDMvbORIosAgAA64oCAAD/SAA==
Date: Thu, 3 Apr 2025 08:31:22 +0000
Message-ID: <e4a51edf-2188-4a49-b807-20ab10eadad1@fujitsu.com>
References: <20250402232552.999634-1-gourry@gourry.net>
 <2ce69e60-8a13-4e9f-b28f-1b30162a1ada@fujitsu.com>
 <67ee11cf28f2e_464ec2949a@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67ee11cf28f2e_464ec2949a@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYRPR01MB15122:EE_
x-ms-office365-filtering-correlation-id: b47b30fa-e652-4773-eee0-08dd7289ea4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlVWQjNMRGUvWU5HQUZlSUxMdHVKLzlGL2pQeVlpa2VKM2x1UHJyWlEyMDVR?=
 =?utf-8?B?eGtwMzR3OVdtNXc4WFpPM1ViSE0zY25HOVlKZmkrZW9nSlQ5OVlwM0phRnA1?=
 =?utf-8?B?WlpObmxKQVZOZnFINzhIR1BWY3NoRTFpTmlFUzVXRVl2ZjczSWk3R3VHeWJY?=
 =?utf-8?B?S0gwcXVQdW5WRFpXYTJrelRSTTJVd05tUTVoYlhHL05TcHlKcDlTeHpWb1Qw?=
 =?utf-8?B?S041YWdYdll5V1FnRlZzYi9GR3pBYkQwQXJ5YWlBTzhhK2tNQVN6eEFlUm02?=
 =?utf-8?B?MWN4eHZiL3pVNEo1LzUwOVZvdFhCNGFET3ltTUxLOVZoaEtNMFNGcHp6Y2pj?=
 =?utf-8?B?aTdmR0ZxVWYxUUFHTWVxcmNyNHZtWUtiUUFtSG9ZNnRiamNtYUlJaTBYb1VG?=
 =?utf-8?B?TmlrWXVJNXNRaHgwV09zZy9qMGZnNzRXbFA4L2hYQ2liSkF4elk2SzJHalkw?=
 =?utf-8?B?NzNwQ1lySHNCajNjbXpLcVQxK2k1d3JNYjFZK1dsamNqSjBGTkpkSUxaVnBX?=
 =?utf-8?B?aDlhdG1BaUlxZHJUdHl0QTZQVHkrQjZGN2lKRHRlUmlNUFYwekJDUVd2ajds?=
 =?utf-8?B?T1JTanR2YjhpQm5TbjZ2dFZ0YWVNVDhRSG14OW9iU2prdjBzSU92UGt0cXND?=
 =?utf-8?B?aWtFVkFLY1VrMUNTY3BsM0VJT2t0VXI4eml0T3RQRzFDU1YxSCtTYnZ3UHhi?=
 =?utf-8?B?QmdST1ZWNVJkdjRQMjR1Z0NmTVE4bmRyRzdUYktWaEtlby9BK2FYbnFuWERI?=
 =?utf-8?B?NFB5Vytya1JJd1AwTHRET2JOa2dsM29KVlZVK0tMN3R1V1ZIYnBuOUQ4aitE?=
 =?utf-8?B?UGw4S0F2Wm8wQWlKSnM3QVdvUTlyR0hWOTVhTy9WZUh4SklEY3hUMkhyQWxS?=
 =?utf-8?B?SjA0SkV1UElNdEpyQjVodkpVTzE2Y2k1Wks1L3RGTUZZZXRsOU5LN3FGbnNM?=
 =?utf-8?B?a1F5c2VXMlBBNG1nQ1kzd2FtUW50cVJVVG9la2ZzWmdxTU9LTkk4bWhqUTZw?=
 =?utf-8?B?WkIvTHpTVkkxTDFMUm5WcEp5ZDVCUlFxRkFOSXdYSUpVSlFNNU9NQnhFbXF5?=
 =?utf-8?B?Skt5TnFmQ21wZEh1a1BtZ3g2a285VjVRNlJ2eW1lUERPT2xGczNmL1FzdTdv?=
 =?utf-8?B?cEcvNjZNc1ltM0Nldk5INEZyUnRGWmNxM1pSS3dQMzVBTzhMSU9LWk05OWpC?=
 =?utf-8?B?aE9mT29BMDM0UGk2T1RCOWFxeWR5STYvS29ncTJld3pyN2FPMG1xcVMwUVhX?=
 =?utf-8?B?cW1rODdYYzFmOFZvSkVCWkxIcVdleTY1b0xUSWtPU0dCQ1h0WnRYSlpxdFU5?=
 =?utf-8?B?bjhiV1htR3Z4TDJ5cThRTmZWcEpGVkZYYmNGTFE1NjdodUZvTUJqNFNwbDBS?=
 =?utf-8?B?UnhpOFVFZDU1N254QU56N0lpQjI1SFh2amFhNXFZMWkrNzhOSktJZTVRRlRm?=
 =?utf-8?B?SmFZcWt2WVpRZlNLaG0vT3ZCOWxUOG5BV0JFRGhnR3NjYTlHVTV0aDNjb2kx?=
 =?utf-8?B?NnE0M1dDeE9DUEpBYkdGUE5COW5tVXB0WnhLa1d6eGhpdVJwVzF4QUQvOEJ1?=
 =?utf-8?B?SFQ5SzRNRkhzTVVkS3lmSzJIY3Q4QWpvZUFyWVBNdGtMeUxRVTl5OGV3K1VH?=
 =?utf-8?B?QS9iWWNnUi8zWFdQUEI1Rmd6WUFHS0N5Z055WFp3MGFFb1ZFbnRndXFnQlhJ?=
 =?utf-8?B?SU1DbXkyUEZGSWN6UjVqZ0MvOWVwOGpWbEg1SDBOVE96Z1VmaUYyb3ZCQjNz?=
 =?utf-8?B?TXd4Q0xTL2IrYWNLVVM5ZGhHZ1JkZkg0RFBNaE5GU2h4YWFRVXNJR09Nd3lu?=
 =?utf-8?B?Wkd4VWJEeXhXYUVtdG1Cd1A5Nk41R0h3MGpRTnFyYUZ4RTJmRVpFaUt2MEpr?=
 =?utf-8?B?Vmw0aXU5cm9KSHBKb3d3VkJWSXpHdkxZVWQ5RVk5TVdlenBIMVJLZmRtRnRR?=
 =?utf-8?B?S3dPNDV3bHVJd2VTNU4zTUxmeHp2SGxrN1o0V0o2QXVmNzJldU5HRzEyamlS?=
 =?utf-8?B?ZGsxMmlqekVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjFwVEN1WGdkWVFYRWJPelJYQlhKVVd4VDF2ZytVb0FKM1FGYU56N08xSkVQ?=
 =?utf-8?B?dmlwU00wWHE0b1NSZW1ocE1wN3NhMTBIUEhEUjZVMUF2U0pVSUhadmxwcmJa?=
 =?utf-8?B?Z1d2QVovWS90UjJ6OE9oOVdTVDdJM21JY2Q4T29JcEJJejEwejZpNE1GUThn?=
 =?utf-8?B?ME5PRVppaytUdDEveVQ0NE1YUVBJTjZOZnliem9jekZJQnVQcTdaWngzY3NE?=
 =?utf-8?B?bHVDdCsxODBSeW5QWklIYTJuY3lVZktQYi9xWUk5RnhYaWNhQWorS2F1ZnFX?=
 =?utf-8?B?eVZVYWhKQVM2cUtWemVtc1RQUUFrUzBXaVlrSVVnWEExR3JHcW9zUkIyeTlB?=
 =?utf-8?B?QTdMRUM0ZFdSa2VER2xRY2R0TFRIcjRCTWd4TW5xVEVDQlc0d3ZOME9Ba2FB?=
 =?utf-8?B?VFQ1WnkzMUd2QlNmOXhJaU9pR282aVBVN05iMnR3Mkw0bnhqeHFpR2QySkYx?=
 =?utf-8?B?QmtLWHE4d2hqQlJXdUdQeS95S1h0blJKZmFDL3Rua205V2RETXBvMWRqa1RI?=
 =?utf-8?B?MGJSNjU5dG5hWFlpWmN4T2Y1MFBuWitrVWp6cWNsa3lidENaVHJXVFEwcFhV?=
 =?utf-8?B?a0ZUb1dnc0VHVHhDTmg5OGc4a0NHTldxK3VjaDB3ckdTeVJ1ZWZXdzZYZkdm?=
 =?utf-8?B?bUU2TDdCSjF3VGFBamtUMzdweVlhU2JBUlM4RG9wQ0lJeW5Kc1pvbFJ1VlBy?=
 =?utf-8?B?Zy9PazB1M0t3V0t4elI2TW5KelhtaGJyNWVNK3d5OTE0NjhOVWxlUkkvZXlI?=
 =?utf-8?B?Q2M5a0VrVXRiY0NYc3MyYlRIaHNOcmNna0h3UTBjZ1g0OVdLVkducUNIcUxX?=
 =?utf-8?B?ODlyaEZ5YmduYW1yVTFiRDlRd2dTTjdVeHR1NHJRM3hzWEE1aXFnMWJKQllx?=
 =?utf-8?B?NXBjU0pSZnFIUlo4TnlPM0xFTDdCcmtZR0JreWV2NkhIS2pHbDVoVEloRlJD?=
 =?utf-8?B?TmhvL00xdWNyOGNwVVZZYUEwKytzaTBRWmRjdFBpOHV0WHRYdW41UUVUcW5p?=
 =?utf-8?B?SmJSc0VlMC9nazROTE5zeW95bXZWNm9xaktYeURsTDVRd2htS0VMYmZUbUpF?=
 =?utf-8?B?RlRNcDJSMnNHb2lBYzhDQTBQYnlXVGJRRWdlZWYzOFVUTldkWmxuNG9sSzdF?=
 =?utf-8?B?UzFMdWlTTVpzMG4yWU5PbTV6amVZUnVNTjdkTzl3alhqOFlaSnV4cVF0Nzht?=
 =?utf-8?B?T0VaakJDRHBINkZWSkttRkc4TklLZmxtQTVseGo5SXltMERkYVlWaGNOSFM1?=
 =?utf-8?B?Z3hpVjJuVXllQnNOU1duRHRiVUprYmxPUEkvWC96SVhIVFVPMVY0ZGx1NUk1?=
 =?utf-8?B?eHJvNUVBcTk4UzJkWkM5Vksyd0tpWmR0dFdrYWN3dG9ucEhSdkdYVHBybTN6?=
 =?utf-8?B?WWpXU1BBdm50S1ladUFIYWhNWitYSU9JNmtocEk3dUZiWkFiYzVyUXF2aGkw?=
 =?utf-8?B?a1k4SkxyZ0NnMTdDSzJPOGQvNkl1OStTQWF1RnNCTEwvTjEwVDNrYVZxSXgx?=
 =?utf-8?B?cUpHWk82OUcwaG9kMTR4MlVsdVBDLzdMYW1VWXdyUjEwMHhHR2FaWC9pcDFD?=
 =?utf-8?B?UXI2aEFyeDJ3WkZpc0h3VTNsU01KM2FtSkZwUU5FRHFEM0duSnRrRmFDSFZU?=
 =?utf-8?B?N2liaFZwRVNadmpHckp5cVRDRUhjYXJvSFo4TWozTTA0ekozMDhvWUt4RWVX?=
 =?utf-8?B?elZsOGhWUStJelVublFVQ29hYUNRVTltVFFYR2hZZ2NFYWgzSUt4U3RNcVU5?=
 =?utf-8?B?UllmZkszM0Vxclg4ME9LeFYxdURVSTBQcTR4akJzeVpxbnZJN2JpNW1wM2FU?=
 =?utf-8?B?M3dhY0NGUWxIN0pkRUltcFdXcXNJRjRLS0FkOVJaTU1pSGtCTGI3M2h0SGJW?=
 =?utf-8?B?bXdmT0lIU2JETVAxeVkyb1ZiT2VSN1lSZnp4WlYxZjdqMnVSTEkxbGNlYndh?=
 =?utf-8?B?WkhzNkowT2kybmhSTlJtU2Q2YmN1NklkVzQyVXZnRG9QM2NnVC9mdlZNL05Z?=
 =?utf-8?B?UlNHK296d280R05DTFhQRFpDa1pEemJmTWxzUzFBeENUaFZmNXRrR2VCRi9W?=
 =?utf-8?B?WHNOQndjU0llR1IwdmI5cWk4WGo2YW5JNm9TL2tBQTlCTEc2WnFtcENSaWxT?=
 =?utf-8?B?eDhlUytQVFFvSEhBWDJ1OGJlZFFSRElNV21CdjlFYWJJRDZXZXRBU2l4OUsv?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC44A30BE0CEE479FD7FF8962369263@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RZqgFKDY7XfedQC6gZvpa4Rt6JgR4mnwOGElZ/MaLoQoi/CltOtZP96myPqRpKTQuxn8aHlOId9QWczoodQeZl9lHFK7WxF8RA3DB92DZv7j716fwbBe+oMj+EiqXk3PEs2jbBP4GJte4HJlb9lWg/9yEkaKJsCBzH5ijVug/qSE/gX7x04tHisD2yx5TOGTISltYphUC3iDdOVkbrcfY3gHWVzbSKBx2pABREcGW69vyiwItXWOEq3XCKsjt/OX4XChSOZr/fjq7VPTaksdJPL1aaOtI6y6UJq9yzQuF3T3uqBAdSey2M7aGSKI/czqzxgeRo8z+2bfsqKxv8k2rK8OVmzvIyZ/jTuNJIAKm/PbmFjTa1UxqP8cVX3G4CEwP78S4F2R/wDMQ6DU2ON71Y4Gh4lgoN7197aYi4p/HPlxzR70zwUQLN13brt03ZycKgzbPH5167HmUlwpfRHRZhiAxrgG+g5TMs975RYu8e4wyInBddlogDCeNnaUgW4+xCOiqY8Hzrj20/z6TXG35fV5K0HIEgytA1iPmGN0Ab/9kN9Q+g96J7aL+Sa2YB5Vhg5yUj6ystnuge1j59zfw/KLUU8a8e52M2bsLHJMoU7lTANIvGLE13bnhC3txbT3
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47b30fa-e652-4773-eee0-08dd7289ea4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 08:31:22.2886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QMIVAstY1oN6Id40E/dzmFkomzaLA+YnLthoHod4Pjm0J29Z/WMm8tsqwryEXP7PLKuOkqLpdeBWVPIpOYQrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15122

SGkgRGFuDQoNCkkgYW0gZ3JhdGVmdWwgZm9yIHlvdXIgcHJvbXB0IHJlc3BvbnNlLg0KDQoNCk9u
IDAzLzA0LzIwMjUgMTI6NDIsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gWmhpamlhbiBMaSAoRnVq
aXRzdSkgd3JvdGU6DQo+PiBIaSBHcmVnb3J5IGFuZCBDWEwgY29tbXVuaXR5DQo+PiBDYyBHb3Rv
LXNhbg0KPj4NCj4+ICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8DQo+PiAgICAgICAgICAgIGRlY29kZXI5LjAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkZWNvZGVyMTAuMA0KPj4gICAgICAgICAgIElXOjEgSUc6MTAyNCAgICAgICAgICAgICAg
ICAgICAgICAgICAgSVc6MSBJRzoxMDI0DQo+IA0KPiBXaHkgMTAyND8gWWVzLCB0aGUgdmFsdWUg
ZG9lcyBub3QgbWF0dGVyLCBidXQgYXR0ZW1wdGluZyAxMDI0IGZlZWxzIG1vcmUNCj4gbGlrZSBh
IHVuaXQgdGVzdCB0aGFuIGEgcHJvZHVjdGlvbiB1c2UgY2FzZS4NCg0KSSBhbSB1bmNlcnRhaW4s
IGl0IGFwcGVhcnMgdG8gYmUgdGhpcyB3YXkgd2hlbiB3ZSBnZXQgdGhlIGRldmljZS4NCkkgcHJl
c3VtZSBpdCBzaG91bGQgbm90IGJlIGEgc2lkZSBlZmZlY3QgaW4gbm8taW50ZXJsZWF2aW5nIGNh
c2UuDQoNCg0KVGhhbmsgeW91IGZvciB5b3VyIGFuc3dlcnMgdG8gdGhlc2UgcXVlc3Rpb25zLiBZ
b3VyIHJlcGx5IGhhcyB0cnVseQ0KY2xlYXJlZCB1cCBteSBjb25mdXNpb24uIE9uY2UgYWdhaW4s
IHRoYW5rIHlvdSENCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4+DQo+PiBNeSBxdWVzdGlvbiBhcmU6
DQo+PiBRMTogd2hldGhlciAiZ3JhbnVsYXJpdHkgaXMgYSBkb24ndCBjYXJlIGlmIG5vdCBpbnRl
cmxlYXZpbmciIGlzIGFwcGxpZWQgdG8NCj4+IGFsbCBIRE0gZGVjb2RlcnMoaW5jbHVkaW5nIHJv
b3QgZGVjb2RlciBhbmQgSERNIGRlY29kZXIpDQo+IA0KPiBBbGwgZGVjb2RlcnMuPiANCj4+IElu
IGN1cnJlbnQgY3hsIGNsaSAsIGl0IHdpbGwgbm90IHNob3cgYW55IGludGVybGVhdmVfZ3JhbnVs
YXJpdHkgYXQgYWxsIHdoZW4gd2F5cz09MShuby1pbnRlcmxlYXZpbmcpDQo+PiAkIGN4bCBsaXN0
IC1QREUgfCBncmVwIGdyYW51bGFyaXR5ICAjIHNob3cgbm90aGluZyB3aGVuIHdheXM9PTENCj4g
DQo+IFJpZ2h0LCBiZWNhdXNlIHRoZSB2YWx1ZSB0aGVvcmV0aWNhbGx5IGhhcyBubyBmdW5jdGlv
bmFsIGltcGFjdCBpbiB0aGUNCj4gd2F5cz09MSBjYXNlLiBIb3dldmVyLCBpdCBlcnJhbnRseSBl
bmRzIHVwIGhhdmluZyBwcmFjdGljYWwgaW1wYWN0IGluDQo+IHRoZXNlIGNvcm5lcnMgY2FzZXMg
d2hlcmUgY29kZSBwZXJmb3JtcyBncmFudWxhcml0eSBjb21wYXJpc29ucyB3aXRob3V0DQo+IGNv
bnNpZGVyaW5nIHRoYXQgd2F5cyBtYXkgYmUgMS4NCj4gDQo+PiBQZXIgdGhlIENYTCBTcGVjIHIz
LjENCj4+IElHOiAiVGhlIG51bWJlciBvZiBjb25zZWN1dGl2ZSBieXRlcyB0aGF0IGFyZSBhc3Np
Z25lZCB0byBlYWNoIHRhcmdldCBpbiB0aGUgVGFyZ2V0IExpc3QuIg0KPj4gUTI6IERvZXMgdGhp
cyBpbXBseSBhIGNvbmZpZ3VyYXRpb24gd2hlcmUgdGhlIG51bWJlciBvZiB3YXlzPjE/DQo+IA0K
PiBSaWdodCwgdGhlIGdyYW51bGFyaXR5IGlzIHRoZSBib3VuZGFyeSBhdCB3aGljaCB0aGUgZGVj
b2RlciBzd2l0Y2hlcyB0bw0KPiB0aGUgbmV4dCB0YXJnZXQgaW4gdGhlIHRhcmdldCBsaXN0LiBX
aGVuIHdheXM9MSBncmFudWxhcml0eSBjYW4gYmUNCj4gaW5maW5pdHkgb3IgemVybyBieSB0aGF0
IGRlZmluaXRpb24uDQo+IA0KPj4gUTM6IERvZXMgdGhlIElHIGFsc28gcmVwcmVzZW50IHRoZSBk
ZXZpY2UncyBjYXBhYmlsaXRpZXM/IFdoZW4gcHJvZ3JhbW1pbmcsIHNob3VsZCBvbmUgYWxzbw0K
Pj4gY29uc2lkZXIgd2hldGhlciB0aGUgZGV2aWNlIHN1cHBvcnRzIGl0Pw0KPiANCj4gWWVzLCBz
ZWUgYml0cyBbOTo4XSBpbiB0aGUgQ1hMIEhETSBEZWNvZGVyIENhcGFiaWxpdHkgUmVnaXN0ZXIg
KENYTCAzLjINCj4gOC4yLjQuMjAuMSkuIFNvIGV2ZW4gdGhvdWdoIHRoZSBtYXRoIHNob3VsZCBu
b3QgbWF0dGVyLCBJIHdvdWxkIHN0aWxsDQo+IGV4cGVjdCB0aGUgZHJpdmVyIHRvIHRyeSB0byBi
ZSBjYXJlZnVsIHRvIG1ha2Ugc3VyZSB0aGF0IElHKzggaXMgbGVzcw0KPiB0aGFuIHRoZSBhZGRy
ZXNzLWJpdCBtYXguDQoNCj4gDQo+PiBJZiAiZ3JhbnVsYXJpdHkgaXMgYSBkb24ndCBjYXJlIGlm
IG5vdCBpbnRlcmxlYXZpbmciIGlzIHRydWUsIGhvdyBhYm91dCBiZWxvdyBjaGFuZ2VzDQo+IA0K
PiBQYXJ0IG9mIG1lIHNheXMsICJ5ZXMsIHRoYXQgc2hvdWxkIGJlIG9rIiwgYW5vdGhlciBwYXJ0
IG9mIG1lIHNheXMgIndoYXQNCj4gaXMgdGhlIHByYWN0aWNhbCBiZW5lZml0IG9mIGFsbG93aW5n
IGFueSBncmFudWxhcml0eSB0byBiZSBzcGVjaWZpZWQ/Ii4NCj4gDQo+IFNvIHRoZSBmaXggZnJv
bSBHcmVnb3J5IGlzIGxpbWl0ZWQgdG8gdGhlIGNhc2Ugb2YgIndob29wcywgdGhlIHBsYXRmb3Jt
DQo+IEJJT1MgdGhvdWdodCB0aGlzIHdhcyBhIGdvb2QgaWRlYSBldmVuIHRob3VnaCBpdCBkb2Vz
IG5vdCBtYXR0ZXIgaW4NCj4gcHJhY3RpY2UsIHRlYWNoIExpbnV4IHRvIGJlIGxlbmllbnQgaW4g
dGhpcyBjYXNlLiIuDQo+IA0KPiBUaGUgcHJvcG9zYWwgdG8gYWNjZXB0IHRoYXQgaW4gYWxsIGNh
c2UgYWxsb3dzIHVzZXItY3JlYXRlZCByZWdpb25zIHRvDQo+IGhhdmUgb2RkIGxhcmdlIGdyYW51
bGFyaXR5IHNpemVzIGluIHRoZSBpdz0xIGNhc2UsIGFuZCBJIGFtIHNrZXB0aWNhbA0KPiBpdCBp
cyB3b3J0aCBzdXBwb3J0aW5nIHRoYXQgbm93Lg==
