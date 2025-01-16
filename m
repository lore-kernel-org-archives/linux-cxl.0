Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E5C4502B
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026098; cv=fail; b=duNxc4dgpaJ7lb2BthtytDe8CFCzAlIayVFafFbjLh+F8gGl/GoRK3er/ckWq4dCUSNxfm53slqP4TNCTuiXxFpsLTm78OH889Ue1CVCFMMCYfXRJHJ5vdxeGiTig+jX44p2N0rXvAyuE+YsavZDI/RgTP9/PIgTZN7E89KnYKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026098; c=relaxed/simple;
	bh=sw61xqJ0RnI6tQQGP/BWtFiB1gW+jPJobKUTWcYEVHA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sqsl6Pk6NFks7tVjUpzwOviLFKCOIxi0dfWxhcSy4ZI4j5SKU0AhibQpEARrlNAkbKW2wuBe7oue4msXG+f6pCA7naG054HQ8mDbpj/1FyE0dyq2m8ET91Y5PgNxp2Xm7o3ZXTA7ofsh/zKgn70SQURbME1jKTqT/CoDy1EEKlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Bq6qswTv; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Bq6qswTv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1737026097; x=1768562097;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=sw61xqJ0RnI6tQQGP/BWtFiB1gW+jPJobKUTWcYEVHA=;
  b=Bq6qswTvFkFL4V1+xBSsikWsH0LJGYJ3aarxWfUSIWSYEQaZ4m8p3IOq
   C9MoYnNfKYC6Ep0bw/DvwlgfbrORK8TUKsu708EmD17xsEOflg42zTbrF
   jy5JajssdV6ot3R6k7tehBu7Ln2Zg3N8qY78P3HvO2urWYKGhAzpWKAqF
   CKTInh/ExJ49ra7kixmcdixewjmNfU2qWZ7/iMzAaL6VA/0iXK/u+E7oI
   0a/Jp1bIqkGGyMk5kGVhjDIVg+kD4zYmMKVp0fSLDoicbH789KWQIGOVP
   CDBy6Sb7UgMOcL743SZ9jmxFw3E3CUPM6d4sRZ4pAKtLnkQFK5ifkVInU
   A==;
X-CSE-ConnectionGUID: urN2WqK6QaKKwi55RcNvwg==
X-CSE-MsgGUID: g8iVScx1QV2dBF9t8ra9Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="143046061"
X-IronPort-AV: E=Sophos;i="6.13,209,1732546800"; 
   d="scan'208";a="143046061"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 20:13:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlcqvsHLAJCVGE333XIX/d5SS9vqqZOroIJN//eQhR2t9ZlI7WqDRK9KPuVFX4J14dh1Dkc4Y4W2vdOSvCswd9NG/X6JhuDmP7HYdakTREilvsAlkEV+VrjyZslt5w6VNJN4KMgw1meXdGEjgOojvsprwPf8NtYqhkDEIjpFNB73uI8bKhwfmCFmLClzZZS4c0DHGOFtMphrNML394dxuUWUXpo9kgIGPfkT2DOEvNM7mYuOYi8l7ltCgSP3OcW++686wqHycVHj/iF+jF4M0dPID5JSJwBL3lF1TRFErK0IcJsfin3iq5CJFBMZ8g55I4Bkbzt1J879PUnIKnoYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bULdydkByYzPABA3NchrMLQuNWqj4Y1qvxEQLzaO/5Y=;
 b=f/n/Nrms6NCADhPBzhIuUicjzOjulV51qL+wD8ad3Ojlm5Uv7BZEknQtpCMp7RKxONW5AcSPJT+ukal+gcb+1FL+XOSy0Bwu50iReAMG4WNl2gz6gmFZgJxXL+xnlhQOOeXEAPenIKjZqcFDrw+wGlRpvZMSIj6tKurtOXjzdhL88NIDsxPZ8tl7C42SdaEFZvYKOvGBPFhiJrsE6CObFPVIrKsehvL/aq1CzokosnN6DqYrRv6GuV7p9R9bbcT1B4sA5fYMBZPvFNMn2UN/N1ibce5Z/fzvFs6a5EnXu2Rw27d+P3iDceyWcbHqnWcGd9IJ7D5vi3Cn9PLkm1XlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com (2603:1096:604:84::14)
 by OS7PR01MB14987.jpnprd01.prod.outlook.com (2603:1096:604:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 11:13:41 +0000
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e]) by OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 11:13:41 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "'linux-cxl@vger.kernel.org'"
	<linux-cxl@vger.kernel.org>
Subject: RE: Assistance Needed with CXL Memory Region Creation
Thread-Topic: Assistance Needed with CXL Memory Region Creation
Thread-Index: AdtgqoH4aWCS14GjQ5iB7Jig2VQUVwHV4icw
Date: Thu, 16 Jan 2025 11:13:41 +0000
Message-ID:
 <OSYPR01MB535212BCA854FDCC57DFFC1C901A2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
References:
 <OSYPR01MB53525FD64A9AFBAEEC1E19A390112@OSYPR01MB5352.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSYPR01MB53525FD64A9AFBAEEC1E19A390112@OSYPR01MB5352.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=cbcaba8f-a6a8-414c-9e62-39cbe14c497c;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-01-06T10:39:21Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 6fdf3a4f58f54feaa05a50ff236094c9
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5352:EE_|OS7PR01MB14987:EE_
x-ms-office365-filtering-correlation-id: abc9d3cf-0685-4e98-2014-08dd361ed575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?cUthU0NEbzBXRVNIdVBSY0NVMzg5R2JyZ0tLS3BQcE9wRWxwVWJXY1dx?=
 =?iso-2022-jp?B?VEg1Sm1sSEZ4cmI0Nmd6QmE5TW9QT1F1S1NvZ0dtRTl4V2dTVHBWQkEx?=
 =?iso-2022-jp?B?QzFSTHdPaXovaVdPUjEwZDkrbmw1b3p1NE9KTkMwYStYekVJVkxjQzBK?=
 =?iso-2022-jp?B?YUhBTWltVXMrOHZXdjN6WUsyZi9oYW5McDRNR1l5eFNVT0U0WXhSN1FX?=
 =?iso-2022-jp?B?bncvUmNFVGk4SmYwQktaTTdJVVJaQitvZ3ExdXV1M3B6MnJncmkxaTZz?=
 =?iso-2022-jp?B?bnV0eC9hV28ydUw3ZjlWaDlOZXh6Zk9lNXUya3NCRlppd3hNQXlqTEVh?=
 =?iso-2022-jp?B?TDhxRDZHTmNYbGU0VmlGMmVpZWlud1haZllCenFiMXkycjduRm9TRkJG?=
 =?iso-2022-jp?B?Vit6Y3hvNGhMT0Q4aXNGNUo2Vkx2cU01ZkE4Y2JEZTNPV3lucXgzNlpq?=
 =?iso-2022-jp?B?b2RGb2YxUVR0WUNJcEVSOVpRYnBJK21ueGJVRU9BWE9ycnExdTZlNllB?=
 =?iso-2022-jp?B?OWZsK2dyR1NsUkFMMnI0V0VJWG1YT0xvQXJtRTZ4OG5yYlRoaHpIN2Jw?=
 =?iso-2022-jp?B?L2VHZEJSU0NhSTZtdlNmbFZ5UWZaaTlUdjIyU3lhOW1HbTVHY2pnNElR?=
 =?iso-2022-jp?B?b1NkbFVGVUhHaHMxblBUdWplK0Y0T29ObnF1Mjh6Ykp5VE5ES3BtT1Yz?=
 =?iso-2022-jp?B?aUtVOEVPTlJGN25HeldZZDMxU3hkVDRhaVNCcC9ReXgvSkRCbmx4amJh?=
 =?iso-2022-jp?B?YWtSZ2oyV1NrdTVQUUNERDl6QlpiZFV2aUR5S0RBam9JWXhuYUN6RWVZ?=
 =?iso-2022-jp?B?MzFYd3prdGdqL0hhWkp0Uis2V2F5MjhKQmU3MVJobXpvRkVJQUNzSm9h?=
 =?iso-2022-jp?B?cHZscGJuS3FsbC91cy9SdFowRGZqakVoWStDY2Q4UGlGeFZqcXM5N3dj?=
 =?iso-2022-jp?B?VWF6d0piOEEzTmpjOW53N0ZPUTc5dFVrdTBLbE5FeHRTSHl4a0M3KzZ2?=
 =?iso-2022-jp?B?MlZ2RDdRRFgwSm9TRVFjc0dJSGFDejluOVlUalpibVVXM0E3VGhJd1c0?=
 =?iso-2022-jp?B?L3NBRXFnQjBzcUw3SjJpcUdkelU1Y2lXOGFkVTlaUW04QVZIemo5NWQ5?=
 =?iso-2022-jp?B?azZaTnUyZTVYWTgzdlZKQTFvNS9hU2dad3E2YUwzYjlzK3hJNHhBTnJH?=
 =?iso-2022-jp?B?TnA1elp4NVo5WFZ4d0txYUI3ZWhMR3R5UkJEOGU2czV5MGpUcFh1YXE3?=
 =?iso-2022-jp?B?NEE0ZGMzTXhkSWNZL25yU05BcWRtT3hFTHZuUmlDSDhVdlYvU2c3Vlly?=
 =?iso-2022-jp?B?LzZRRWxGOUZYUGlnOWZJOTNrOVd3MUZrbDBsV1JiWlVXTGMvVDJDcU1h?=
 =?iso-2022-jp?B?MDI1Q3R0Z2NKa0pmSjUvS1VuR3FFYk1UWkg1cXExNWJIb0dISWpXN2w0?=
 =?iso-2022-jp?B?WW15ekZ5d25zU1pseXA2WlA3a1VzQ1pseTJkRVZYTDNnaFduSDQxaWcz?=
 =?iso-2022-jp?B?aTZjemF2NEdLMG42MTFqdFphUENhdVpleWdEQzlWdzVtczlRK3JZdjha?=
 =?iso-2022-jp?B?ZDZvbHFWS3RVbTNDYVJGbVA2WFNELzhzSU1IN2JMdUIrQko4a2ZFcHF2?=
 =?iso-2022-jp?B?OUdJamFuRFB0TnJSMFhJclhqTmxPVlJPcG45bnUzdVp0S3BVQVZHSDF1?=
 =?iso-2022-jp?B?M1RtcHZIdkdmRFI2enFOamRBVzhmTXE3aTR3S0N2ejE5ZEhxa1lYS1Ax?=
 =?iso-2022-jp?B?YlRUamFrbU9yRWhNYlM1cTc5N2c1TjNESVZxWU81eC8rRFFtcnF1QU1s?=
 =?iso-2022-jp?B?dWZ3TkdyamJYZTdLMDE1WktiMDQyQjVUMkpoT0tacllzbzZNUVdPMGxh?=
 =?iso-2022-jp?B?ZjN4K1hxT1JXdlg2bHZ3STV1UFRBWjV6SkNHWWZvZXNhbHJkVTJJMzlp?=
 =?iso-2022-jp?B?K2ZpNFVyZEdnditiVkpsbkx2MG5mdTc2N0RhTGZFTzI2RVh1N2V4OXZk?=
 =?iso-2022-jp?B?R2ZQd2pmQk9iRnpjZjZIMVZBTkROeUhwTXM2V0EwZzNsd05XNUNqRmxl?=
 =?iso-2022-jp?B?SmlMY2pPOXFKWmlLOEkwN01CN1lzWGc9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5352.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SWg2ZjZ6akxtUkNlaCtyb0hjT0JBVG9iRUFmTjN0Vmw3cVN5OVpqQlYr?=
 =?iso-2022-jp?B?dUtZOHpqWk14dlNnbVc2TGY2clNudlhQTkNXV2VEZE9GdW42NkRoK1Bj?=
 =?iso-2022-jp?B?amtDb0ZoMEZweVlYajNPTkk1YWN3N3IyenZhd2pMMXhWN2M4aktyOWhz?=
 =?iso-2022-jp?B?eTgzYWJvTXEyUERsTEJzT2YvbjQ2b2I3aENiZ3RNT1MyRHdIL25EUk4v?=
 =?iso-2022-jp?B?QmhDUHhEbVlDaCtwYUhwMU1nN3l0RGxLdXhxbmlEL1dJRUFGcTM3MitT?=
 =?iso-2022-jp?B?a254VUVFQy95ckxwUnpJc0VhZFM3SC9raTFQYllkWFJRTFkzN1RuMzlx?=
 =?iso-2022-jp?B?cXFaRmRPZ2EyNXFMd1NMMVdLejdPUHFwbTVvYU1vQXpudEE4TnpBY0Jk?=
 =?iso-2022-jp?B?ZlRrR2JJTjU4a2dwMW1BOVdNUVpESmVXbVJKSzNsdzk5c001aGNFQTdQ?=
 =?iso-2022-jp?B?TDdTQzdwQndSU0NaVEtpWVZ4bXRRVDArQUdiWTVCeDQvWWVYYXRJRU9J?=
 =?iso-2022-jp?B?YXpmUWx1blZwWjVTK28yZ1ZhaUlYVjJrQjNDTytVajZVUmtaRjdMMGlX?=
 =?iso-2022-jp?B?QTVTOVdmNmZrM0dlNTBBNk1KVDV0WjlQRGZIV3NTUGNLTHErT2lQeGIz?=
 =?iso-2022-jp?B?bmN2YUZTaU0rSWJ1M0gvUytMVUJ1SG1WUFMrTjI3Qm1tUzZ5N0s3ZDJ5?=
 =?iso-2022-jp?B?dCtiRHVaUHpkbFAvazBwVThBNXJjbkdLM1cvVTdhNlhEVlJwTjV2ekVh?=
 =?iso-2022-jp?B?YXVrVGw5K1grOER2a1VsRWxNcTYySjFKMzdmWmtkb3ROL3FuOUU1Ulhk?=
 =?iso-2022-jp?B?TmpJTE1rTHNkVDhMYW8yUDc5MWtMdEtDZ1JINUdJUUswRnZMY3QybHdQ?=
 =?iso-2022-jp?B?M2Y3L0NEVnBhdFlnQjVYeUd2MTlFbmxiQ0R2em1WN29QbzM1VXdCNXZL?=
 =?iso-2022-jp?B?emQ1YzVCNW9zektkRklvSFhvTnl2QUhYdkhNUGRQeHhNb3NCem13cTFv?=
 =?iso-2022-jp?B?V0RpamNJYUMvMDFYN1o2K2JFVTdQejlpbzhOcmc0SWgxblRHdkF3Wmd2?=
 =?iso-2022-jp?B?NVl3VmNETlRQMWdpWTlRS3N5NmJaUkVyaTZJNEozeTUwRldPSDhMWnVZ?=
 =?iso-2022-jp?B?OGxOOU5sYk9BTnlCOEhjcW1Rc21Ib1BnVDBhUWFUTWtvMjNsQ3dERGtZ?=
 =?iso-2022-jp?B?d3dnRGZMWWhZQS9HMjhUV2E5NUR4aE1hNVVNek5MbW5KYllyenRsdjRj?=
 =?iso-2022-jp?B?MUpiOGtadzBrZTJPY0pmVEZXV1AwWHpnVzVPcSs5ZzJiMndZU2Vrem0w?=
 =?iso-2022-jp?B?ZTN0U1NxSS9SaGQ1Ni90bGIwRENEclJmTWNsTkF5OGtteVJ3eUx5NlB0?=
 =?iso-2022-jp?B?bU9leWxlVzZ5TTBtN1RiUGFpajNqYmY1cFAvT29jUGdyblRmRGJhQUYw?=
 =?iso-2022-jp?B?bnUreTJrektwelBRUjA3TUxoK0NyQnlLWnpqSGRHMWs4V041L2pCVnh2?=
 =?iso-2022-jp?B?U1p4bmN2bC8xcEkyOHY3M1J5U0dDdjFKaHEyWlZBOUoyN3lLVFVSYVFB?=
 =?iso-2022-jp?B?bkJrYW5lSFlzN0lkT05TUTNzVVBsdnJDb25TN0g5UE0rY3BWQnVPYS94?=
 =?iso-2022-jp?B?WDIyQlZRdzVmTldzSVIxbng4N0UzcmpVSFZxdWRDSjBBRDl1cFVzT0dW?=
 =?iso-2022-jp?B?Sjk4ajJiMTdEbDhjRVArRloxOWdzRllPZjlmNWJNMzlDVHhsU2RkYkZm?=
 =?iso-2022-jp?B?YkJrRHhEbC84RDQ0WG1Gb3l5R1ZhQXRtcjRlOThGb3JuWDJzNTA2aTNm?=
 =?iso-2022-jp?B?NlBhMnc2ZEJ6aW55ZnhSMDkwL1NQZm1DYUg3dUw3c1lQQi95RGo2cGRm?=
 =?iso-2022-jp?B?aS91TXEyTURYblN5Z0YzL1hJYlp5VUxnamYzSnZGZWxTL3lDQjdSa1Nz?=
 =?iso-2022-jp?B?ZmNiMmd3b0FlUTIya0ZxV29iRk9iMTJjbDQ2eEx4S21iVXJETmNrUEZy?=
 =?iso-2022-jp?B?UDU0dmFnSmZlQ09CSzhzZllmakEzSVhXL3laTUtUSXpxaFRhNGZpNnBO?=
 =?iso-2022-jp?B?SlBOUVAwZCtDNlM5cDdwOTZ1YUFPZUFFYWpURGt6OGU4QlhHcDJVWjM2?=
 =?iso-2022-jp?B?ekVlNnVHZkZ0ZXhXakc4N0Y3UFZtbTErRXhlVmo3ODJtV0FXQlpvMkgv?=
 =?iso-2022-jp?B?NHBiT1pxN1NMUVhpeWswRWxPZ01VdXczcUlJSU9NRlZ3RTRYZ3Zhc0t5?=
 =?iso-2022-jp?B?VVF6RnNUUDNPYTRhN0hCSGVnNXIrT0tGMFg5SFJJTVJCYlczcGxwMVF0?=
 =?iso-2022-jp?B?dDRzbg==?=
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
	wxiAvTe8zd9IYMLc1bmlVzq6Bk1iHa+dBHLk6dKCuRZq1BdXccoag3dNUf84fldK7iR/ioyIVY40CyuF2ZZHgHc+TvqeAkoP3sxTX7V88yKKsAWQv3kIiv43EHwgMD10617V8ntLTs7K17DPV20OWKb31wFUSth4CynGL2uEaBsdhq3rG3ToUkgoLhWHo3mZft7c4Y3cQ3kyck2OQR2r3aBfAQBPnrL7T2IHFo21cM+Jj0lmK9ufRAC2otWf8fZ+wOT3boM8UBt9GGzrB96cI4uKw4fXtocUVWo1o44KAKrX1PNdeWhLiL/agIwCQr3uKx4KYH+mp7iRmPXHcTICvGu/yo4mXyj04DP8vKTnDd1c85wicTlq/f9jvBbb2zqqS8/34RpxJhnbDIPknB+xHS5Xi+xCyqCSsNp/vsffuJ5/us+7NCcz3EXSa8OVVnnoNxQto31UeL3XMpJZWU8KHPcV2syAFxa914A7SNRds6NWt0t0551GBnp1xjEBLTwsAeAF2CbCa1AoXnZ/uUvwxeedfIyNgQomwUs8IAplaMxOYyU+AUiGnNfnmZIwv/rl4UHST/ZPiAHI9ceXIRMu66F6dS1DA5Z3rmZuU8okX2gZItx2aHRME7gwLtZy13om
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5352.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc9d3cf-0685-4e98-2014-08dd361ed575
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 11:13:41.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8d7vME5dbcw88uXB6xWD1lIY/m3lrr9RCwHggMAnX7Y0OF1CnBxc02MIubvAvwNpQ9b3XbfhBHMHWkm22PdfuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14987


Ping....
Is there anyone who can provide information to help resolve this issue?
I met this issue at kernel 6.13-rc4. Are there any fix for this issue?=20
Otherwise, are there any kernel version which can create region under the s=
pecial purpose memory?

I'll add some more information below...

> Hello,
>=20
> I hope this message finds you well. I have a question regarding the use o=
f CXL
> memory based on the v2.0 specification, and I would appreciate any assist=
ance
> you can provide.
>=20
> I recently acquired a real machine equipped with actual CXL memory, and I=
'm
> attempting to create a region using the "cxl create-region" command.
> However, I encountered an issue where the command returns an ERANGE error=
.
> Upon investigation, I discovered that the get_free_mem_region() function =
in
> kernel/resource.c is returning this error.

When get_free_mem_region() returns the ERANGE error, __region_intersects() =
does not return REGION_DISJOINT.
As a result, the following "if" statement evaluates to true, causing the fo=
r loop to continue through the entire CXL memory window.

------------------------
static struct resource *
get_free_mem_region(struct device *dev, struct resource *base,
  :
  :
        for (addr =3D gfr_start(base, size, align, flags);
             gfr_continue(base, addr, align, flags);
             addr =3D gfr_next(addr, align, flags)) {
                if (__region_intersects(base, addr, size, 0, IORES_DESC_NON=
E) !=3D
                    REGION_DISJOINT) =20
                        continue;  <----  !!!!!
----
On the other hand, in the CXL emulation environment, there is no EFI_MEMORY=
_SP area.
Therefore, __region_intersects() returns REGION_DISJOINT, allowing the code
in the following "}else{" block to be executed.
-----
                } else {
                        res->start =3D addr;
                        res->end =3D addr + size - 1;
                        res->name =3D name;
                        res->desc =3D desc;
                        res->flags =3D IORESOURCE_MEM;  <-----!!!!
=20
                        /*
                         * Only succeed if the resource hosts an exclusive
                         * range after the insert
                         */
                        if (__insert_resource(base, res) || res->child)
                                break;
=20
                        write_unlock(&resource_lock);
                }
------

I think cxl create-region should succeed in the special purpose memory area=
, but I cannot
understand why the above code results in an ERANGE error...

>=20
> It seems that the function is unable to allocate an area from CXL Window =
0 due
> to it being "Soft Reserved."
> Below is the relevant section from /proc/iomem:
> =3D=3D=3D=3D
> 89d500000-89fffffff : Reserved
> 8a0000000-189fffffff : CXL Window 0
>   8a0000000-189fffffff : Soft Reserved  ------!!!!
> fd00000000-fd03ffffff : Reserved
> =3D=3D=3D=3D=3D
>=20
> In contrast, when using a QEMU CXL emulation environment, there are no
> resources under CXL Window 0, allowing get_free_mem_region() to succeed
> and enabling region creation:
> =3D=3D=3D=3D=3D
> 100000000-47fffffff : System RAM
> a90000000-e8fffffff : CXL Window 0 <--- there is no resource.
> ec0000000-bfffffffff : PCI Bus 0000:00
> c000000000-c00000ffff : PCI Bus 0000:0c
> =3D=3D=3D=3D=3D
>=20
> From my understanding, the Soft Reserved area originates from
> EFI_MEMORY_SP.
> Additionally, the CXL Memory Device SW Guide Rev1.1(*) says the following=
s
> ---
> The only cases where it is recommended to omit the EFI_MEMORY_SP
> attribute are those where the system contains exclusively CXL memory, or
> where CXL memory is interleaved with DDR memory or where the CXL memory
> is required to boot.
> ----
> Therefore I think this /proc/iomem map is natural for the real machine.
> And, I expected a region to be created from the Soft Reserved area, but t=
he
> actual behavior differs.
>=20
> I'm confused why the kernel/driver rejects creating a region in the Soft
> Reserved area, and I have many questions.
>=20
> 1. Is this behavior is intended?
> 2. If so, what steps are necessary to create a region in the Soft Reserve=
d area?
> 3. Alternatively, is the Soft Reserved area not meant for region creation=
?
>=20
> (*)https://cdrdv2-public.intel.com/643805/643805_CXL_Memory_Device_SW
> _Guide_Rev1_1.pdf


Thanks,
---
Yasunori Goto
