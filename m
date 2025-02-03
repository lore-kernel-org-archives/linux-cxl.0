Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DF201002
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738577383; cv=fail; b=SBuChgkRqaQFtEOQpznxni2qRk90+yVIUYYPyX8yfyA+BcQGRN09Lg/mG6YSfIgy5YhvkEwNLkIih7N/ra/z+epuwkHFHTm33ib+11olDEZ8ClbjjSkonEe3xYzcwulaig8R/8C2BKSwWVA7JBIt7dg2XEdjWW80R9F4gIftPzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738577383; c=relaxed/simple;
	bh=QSL0Rndga6w4rlPVfUfHktnVDNlV+sOwm912fE7aO9o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mz2652WYEKvHxwgKBHp0mW6j3S8fXm+lE1YHWiMWMaE/UPIEYCVDg5xgX32vLAujnS30V5QQviI2szogq6sc2EPEWdanY9epud2NpTR4hmTxSu3sY40VPRhoEbnGUC9JQ8x2VgSP7kMcQRq9hLv1ZPxq6LJiei9ihQ1rUD+T2UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bKOlW7ZE; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bKOlW7ZE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1738577380; x=1770113380;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QSL0Rndga6w4rlPVfUfHktnVDNlV+sOwm912fE7aO9o=;
  b=bKOlW7ZEobD4FC/nKZeRSFYS/JRQeCbwO/1S80iKF4CxovLsxBb3z3QX
   JZ/E1hptOoar48SBT7V/txWknxYM8uJXjJp6uzZG10/EEi+dm3S4hNuU3
   fo/lRCpe8+REw8EQAMaFOLSqNE0yhGR15RhaSn/5KMjw9MmlvLgmGQtJ+
   BNqBZ0mkYwk2OMa4dL5w/4vQzLNCcGLyfGQilrM+BehHD/4hykMfjZqnM
   yW8VY22jpBe0JxjtaYJH8ZE0HyP76DR/O1ND9XnD5cjUSiypJ8ehdy/FX
   My2IwKxf2Dw1XnbT7MSS/ok2A6q7fmqyjhvGAz962JbK032d42ZBX4DXC
   g==;
X-CSE-ConnectionGUID: 3yEF5v2VTpe0Cbraw605oQ==
X-CSE-MsgGUID: 5YQzVF+oRB2//wZW+zHHww==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="145259574"
X-IronPort-AV: E=Sophos;i="6.13,255,1732546800"; 
   d="scan'208";a="145259574"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 19:08:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYWwb9Jyae4/Jp1cu4Xv0ALxUg0ZZv8U4tjwqkRSKL11sBA7Qtax0R6FwoGBU4yOVpF4HAckX8lVE/MMq22aQjnI/XaOvoczH82KGcaLjbnCTeDB6MRfTNHli6LOd2Bfgju92TgoafeP9XXgMBeu6UneTKY1H9aowLqDE9Nba5gVapcj0nDVRVGCYcArU7s9TM9ZYBF6M0wXgBuqR6boXo/DrDS9GuQ4wNABa6gjgW9x5RyG0dbCrBY3RG5oaKjTk7WefSk9bTZXaxB6av0nTwFoyEx799tK2eyHn9719BgIDWbMFeu8Hg28VmBdYbEr9zAhtvP26s4a56l7ERajTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgwV+fZWZG0AkmSAJpTeEX2NmzjTzZEBuVyQWl35qt4=;
 b=a+rvRAwsDYa4H8iXTBD0sfqXqVxhAEWjDll0w8y1zSQtks5FkuAqar3tmT65LOWXIxxHOYbD/n0xjJP6fuw+339Sgssgt7s2hvM0Qt5jdITNkpePp2qevhsiVQIXN9qZUP/B7z4vLQPdi2TTiyZvhphgw0tcMiIm3+CAYeOIP1qV9DNYYEj4B3LjY5KNxv/8MelZg9HoRpob3ypaDLRbR3LMG6l6DrUDQN1DM+n+pgeLL+6LI6h37VLUikFeGMswmdD4R2ks/hnEUYTHlQJvzvSdMXDgxZIQbKz78rZoSOML1F/Z4Buvn2stbMR0mfHRRa2kMRgkBvArZY1lPjo8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com (2603:1096:604:84::14)
 by OS3PR01MB5623.jpnprd01.prod.outlook.com (2603:1096:604:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 10:08:26 +0000
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e]) by OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e%6]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 10:08:25 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "'linux-cxl@vger.kernel.org'"
	<linux-cxl@vger.kernel.org>
Subject: RE: Assistance Needed with CXL Memory Region Creation
Thread-Topic: Assistance Needed with CXL Memory Region Creation
Thread-Index: AdtgqoH4aWCS14GjQ5iB7Jig2VQUVwHV4icwABCGhgAAGLHOwAKQfn+Q
Date: Mon, 3 Feb 2025 10:08:24 +0000
Message-ID:
 <OSYPR01MB5352179B0452A2537A2AB9B290F52@OSYPR01MB5352.jpnprd01.prod.outlook.com>
References:
 <OSYPR01MB53525FD64A9AFBAEEC1E19A390112@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <OSYPR01MB535212BCA854FDCC57DFFC1C901A2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <67894f4e5ed6_20fa2946@dwillia2-xfh.jf.intel.com.notmuch>
 <OSYPR01MB5352A1D6015146B092A7D591901B2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSYPR01MB5352A1D6015146B092A7D591901B2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 28c1feb671284101879160f6ac9e36cb
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=41774bc6-deb0-4c53-94de-4dd0a6fefb0b;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-01-17T06:13:26Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5352:EE_|OS3PR01MB5623:EE_
x-ms-office365-filtering-correlation-id: 5815c3d5-cf72-44f6-26e5-08dd443ab23f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?K1lOaWxydlRkWENWY2lIVGxPTUFwZUxoZU92RkkySUhYUjZIRVpIN3Jo?=
 =?iso-2022-jp?B?YzlDSWU2QjVqUDVFMTF0Tit1SFNyS3AvanNoclNoZ1NhWnZhcDRKVzF3?=
 =?iso-2022-jp?B?Qk00NDM0eDNWV3UzR01pS1E3VStTL1RaTXlzVWlzdkJGVXp5SittOEhX?=
 =?iso-2022-jp?B?cGIwNElkUzVkcUZLaFBXT2w2QmxKenB0RXhjSDUzR3lUVnRuYXpOTGdw?=
 =?iso-2022-jp?B?L1lSWDdCQmpDZHRyQmRIa1REWGU3RVRaSG9Yd0NuOTVhUXpVODhHVW1n?=
 =?iso-2022-jp?B?ZGtCcUdTTmtTdWo0K0hEc1B2ajhXc2h5RGNJK1ZIRFZvNEFiZ1NXeWFz?=
 =?iso-2022-jp?B?U3pDaGJvaG1lRWdpQTFtek5PTVYxQmRvVGVmTE9oY0NlMlZIdVFlcmkz?=
 =?iso-2022-jp?B?SnVHN0pCYzl2UkNtU2xUQzJUVnJROVZLdXI4MUcrSW9tcHA0MHd5RVd5?=
 =?iso-2022-jp?B?c2pFRWREbmlYV0hCRHArOVc0c3lLbGJtcTdHMTJPejVSUHRnNVVMNVZC?=
 =?iso-2022-jp?B?KzVxbUdWSlZ3ZXp0RkJMN1NRb01rZ3htOStlUzhzODBta3h0N2Y4Vytk?=
 =?iso-2022-jp?B?aVQxMU5wRzdhU0pyelVOQWtwOVYwd1NuMnFnSTEyUEluWTc2ejgvM0V3?=
 =?iso-2022-jp?B?dDJhMWVvMUlMWXkxRHJNRmxDdGhORTBlRE5tVG5qVlRjdG4rcUprSmJR?=
 =?iso-2022-jp?B?dmVhdURHM0dtUFJyWUg4aFlMYmJPRWxXYkdDTUhZVG1aQjdwMnBnVUtK?=
 =?iso-2022-jp?B?ZWRQMnpoNU1PRGwrNExkSUV5WllvVDl4c0htN3ZxcHQybDQ0bGtYZnNM?=
 =?iso-2022-jp?B?YzlEdUVMb0Y1cWZTS25NQ3RXZ1RUVnVlV24wTTBMb0NBc0lzLzBNdVBU?=
 =?iso-2022-jp?B?dVZTOFlwaG1yMG1nSkZyaHhQRkZrNzRSTjBPVlB0bHhVRW0rRHljTkVu?=
 =?iso-2022-jp?B?WXlQeXRuYzFmVmpWTVdqZE1RMklwWmlENEN1T0JrdnpNMTcvRUlreUJ2?=
 =?iso-2022-jp?B?cVZndUtXeW9DMFRKb0YyTEZPWkp2N2YrbzV5SFdnRU1sM2cwc1RVRktG?=
 =?iso-2022-jp?B?T3FFYXM0Q3NSYy94dVM4ejhINjlVM0xUWDI0RXNSQkVEblI2SFRxekdE?=
 =?iso-2022-jp?B?V05kZktBaEprN1BkclJoODdjcHFPYkR6dXEwL3JpV2t0azNpeWlrMk5j?=
 =?iso-2022-jp?B?RWFya3NPdlA4QTdpZ1RyRWkyU21LRzEyYnBDTXdYUkVIQUtvSGxTK0Rt?=
 =?iso-2022-jp?B?K3RqaGdVam84bmYvWG1lQnc1NzIzcWJGTVZOV3FjakdZOU5FN3AvMkwx?=
 =?iso-2022-jp?B?MVpiYlJvbmNzMHJhbnZpNlhOTjZRY1htMGthUjVUVjJkc1BRa1pRbjgv?=
 =?iso-2022-jp?B?b3VwMk1aTFVvaXB4YUp4bCt6ellITnAvVGlFeHEweGRZRTlFMkE5ejNy?=
 =?iso-2022-jp?B?QjNTeWRsVUh2a1k2aVdRM0JJSTFvRUVIakp0YmlaVk4vNGhYb1YxSWNZ?=
 =?iso-2022-jp?B?SFZVVlluanpoRjk4SHQxTjFBb3VRTUtHbk9aQ3A1RTBXdWpsUkgxUGpR?=
 =?iso-2022-jp?B?M3VFN0ZaSGJFU3V4RStSWlNzRmZJRGlWVkVJUkZMaDBQUW5yYjJvWGU2?=
 =?iso-2022-jp?B?UlB5cG5tcFF0SE9xNGY4dDB5TnpjdUFUcUFmRXEyZGVOV2tvZUV2NDVL?=
 =?iso-2022-jp?B?V1hldnA1NG1DUEo0QXhLQ1laSUpyekxBbEVjRythb1ZHb1hBNWg4S0tE?=
 =?iso-2022-jp?B?Y3FCdmdlYWkxSU8wUGg1NmlQM1puSXlvbHhUOEdFTy9qYU9ES0JNWVg1?=
 =?iso-2022-jp?B?MytUWURPSXMwYkxXa25qclhCcEs0NU5Zay8xemhneUNuaEdDcGxLWnRX?=
 =?iso-2022-jp?B?dTlPbWFEb0hFbE1MdzNTZTBLY2ZLL2s3OUk2bWhJOG01K3lGYUppbUdW?=
 =?iso-2022-jp?B?a2xuNkZadGJQaUc5YUFZZkJQWWhOT2hTcUZBb0tGRWttenNuU0R5QkNN?=
 =?iso-2022-jp?B?dEtvc3FJd3dnV2t3ZjVPdXhGQ3N0c1BrTUxqSUJzeVQzR2RIOEM1T0th?=
 =?iso-2022-jp?B?UE53MGlRcXA1cER2eXBRcStzTzJpMy9iOVkrM3R2UW92WUh5UnZobnBU?=
 =?iso-2022-jp?B?NzJna3BRcnJBeHpTZ0k4cGFhNDJxR09RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5352.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?VFpoNXQzY1NCVWtkRmkxdFVoOVd2eHVQNTVQdkZRejdjWHpWL2wwRVBS?=
 =?iso-2022-jp?B?QXAwcW8xRzhpQnpuYXBER0YxeTNqeGVkcTZpdjZwSm1jNDBqQXErd0ty?=
 =?iso-2022-jp?B?MUJveHcxU2tXMGI3MTRkVUtBVVZpU1l0TVdqdXo2NDlpaHo5OUdIR0VJ?=
 =?iso-2022-jp?B?QzcyNWcyRTR3cHFwbmRsOVRyTWoxYjVDUzRrZVJlN2hNRXk3ZlQ0Z3BD?=
 =?iso-2022-jp?B?ZXNMV0ZkN3VoYjhTajJvaTFXZWFHa1RoY1RMUDNuRENtaWlOUGQvTFFs?=
 =?iso-2022-jp?B?a3Y1K2hMNG1jZHlWZkp6aVd3NVVoRW1JTEdYK0J5Q2ltMFY2QmwzOWhU?=
 =?iso-2022-jp?B?QW9uTFVzQnBXVm1iMHk2dEJrZDBGMFk1WHZRZTJsUlNaQ1doZ2JGc0ho?=
 =?iso-2022-jp?B?bTRnSXVtK2ZqTFFMZFhwNjJsMDJwaERhVnpnVDlGajdtd0drS05DV2lh?=
 =?iso-2022-jp?B?M1FXaHRiRWs5dWl5STU5WGMrekRBNGZkb2hjZ3RFMVpzQlRqUFR3b2xW?=
 =?iso-2022-jp?B?VnBEZStnNTZJeXRkL3JpK2JEMURDUzB0VWwxMGwwZnNjLzhsenJZVkV4?=
 =?iso-2022-jp?B?R05ZR1JxaWk1WnM1c29TQjVwN1l1OW1hWWd5Qy9JUTJ2TndSWkR2NkF2?=
 =?iso-2022-jp?B?OThJZUszZHV6QWNFVXF4aHFmS3Q1VGQxL0ZBY3R2WnI3MTVmRm9mcUI3?=
 =?iso-2022-jp?B?TUxDcE1UUGNrVjhya0tSalFRNWlYSzBySkR0cVg2STB0d3NHL29RYzRx?=
 =?iso-2022-jp?B?T0RPMkpYeDg2RGpFdWI2S0RzcmMxeCtldXRmUE0zeEF6NDcvNjZGSDUw?=
 =?iso-2022-jp?B?TjZpTnhtSVdrMFFlMnJ2TG8zTERLVytDeFROR2F3VmF5Qlp0K29pNk5E?=
 =?iso-2022-jp?B?RGt6V0FYT010QXNNQTczNkF3M0JzUW9Hc2QrelFKR2xIMDJrYndUUG4r?=
 =?iso-2022-jp?B?b2x2aXE5a0xlYXdvZXF1N2dSSFFEVlh6MmlrZWhsMkJRZ3l1aDR2VXI0?=
 =?iso-2022-jp?B?blVYL1dSVjR4MEl6TGluam11K1p3ZEt1KzZFQlN3d1dDeHV5eURRdGRJ?=
 =?iso-2022-jp?B?NTNMbDIvR3QzbkVHcXhLdFJoRUw3M1lpYWpGSnRlblpwZUJ1bVpIRXVE?=
 =?iso-2022-jp?B?bktQWXllMFJLd0ZSVElJY3BQNE1zbzd6NWpJL0ZvaStvZlovRERSWmtI?=
 =?iso-2022-jp?B?bnlCdWxON2JJODdpSU9CakN1L1NQQ2RvYVh3cVBQdSsxVkthYjhiVkR1?=
 =?iso-2022-jp?B?ajZia1ZtOUpvb3VtM1pVaUtFalVXTzhFMVZ4TUQ3NjBZMUVTU3R6dS9R?=
 =?iso-2022-jp?B?RktMRzRRY2IrUjhNdHZ5TFpBWWEyRFQxWnIxdThXdnpxalZEKzViSXdQ?=
 =?iso-2022-jp?B?ZnRBYWszd0g4OFBMak1kSWxLREk1Q2VKcUFHZS9vSkc3TDhCNXpxUVRy?=
 =?iso-2022-jp?B?aFFTSDJwUmw2R2lPS3BkMndjMjRSMS9sSkp5UXdZN1Y2b1F2MG1SWktt?=
 =?iso-2022-jp?B?aFJSZW00R1FQSmQ3NURpcWllQXAxdUE0c1NsUlV3TEFIQWVhMWU0ODJ4?=
 =?iso-2022-jp?B?ZDh1Tmp3T1h2bEJkeWhMbEhJQTdLUjl0Z2k4TmxBV21hblE3QkIrc3VT?=
 =?iso-2022-jp?B?Z1RpM2o5M3NiQ2NTQk0xTkc1V28yeEYyWWwzMmhmVjQ3QlZXNUJUdGVZ?=
 =?iso-2022-jp?B?Mkpvb3NkcXFEeTZvRmRFcWhCMzBlVktEb3JZOUVNUmN2NUcwNjdJMnhX?=
 =?iso-2022-jp?B?UmZScWlGRzNhQWdlMjNjQ3p3Nm81eHpQcTMydHdaSERsditvakM5QTVa?=
 =?iso-2022-jp?B?WWJEVlBrNkpGdVpveG5hTVBGbFBSTldhbHVCVHMwRXVIN2hNSUJhZkt2?=
 =?iso-2022-jp?B?Z3JQOVpGTDJBZFUzSjk4ZC9QTzEvQU5CWlZGbWd6Q0QrRDRxR290akZT?=
 =?iso-2022-jp?B?aWFsSmg3d1ZyYzZBNEQ1NndOL01SVjhpM2VyQ1ZwNHBPM09WeEZlNHA2?=
 =?iso-2022-jp?B?d290Y1pUb2xhQVpXR1RSVnUxc2ZjdncvbWZBZ0tKVUFCQWxpakxtU0RJ?=
 =?iso-2022-jp?B?S0lFSTFLajFhY285ZW5xMUMwN3VMWjVlYmhOWlgxclBKa0xTYVM1M252?=
 =?iso-2022-jp?B?UWsrTjUxeXRQK3hmUTBKdDltZzIrZ1REMEZwcWpUSHJoZ3EyWWtFVWhz?=
 =?iso-2022-jp?B?bXRhalJQY1J5TXIzL0VvVzBvVTRqMzhwNjhDTURPMHF0dmRlSkQ0VXVa?=
 =?iso-2022-jp?B?VzNtWi90TkZKK0cycFFqTGxKVlBRNlB3bExQUzFoSnBBUkRtc3o5SjdJ?=
 =?iso-2022-jp?B?azM4ZA==?=
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
	lDmHtoHHtNsOB3C67dT4LVVIYIyKoN1ictsi0J5AjQ5ze549PodsUxI/cZr3SYxCZ6Utkdp1wsw2vbrGZ6+5KAMy01uAxJgDHt7EttZ89aN1lSPWOmLh9Giro9Bye+kiktT973LIdnoPF+oFFYGXe1Q4nVAEEbm13YncAA3H0UQ46kwD4GR/ivnJwKisGkC5aAkT+1Ivd5K2atCwpoTAcuRqjxY2h37T9akgakSRb12UcNgg6riXUQBtgVi1nmQbFaQeorDz0krBfn1cOLk46lgxg7OIhfi9Fbh3NRpPlkbOHVOUNCF1JcrBYJB8vYH4U+KBIGYkW/vvQAa0QT9BUki01F5f2x7bhwsGXAF3AAda8QvNNwn7/dNRqgIbtbpPQQS3LwFI2l76gxNkp9zWKyiIkJlw30Y7BPx66zKjwYvzHTlrRhobpVHTQRkdaQi1S8qsguFX4laQGFJ5S6Y3MV3qaGuT/xL6AB4HS8Aut6xeKt39APTgqBhk175G9hT0FwibB+lKfyxM68ejuJFMQJCCiniWDRRzH/OvlqPkaVg1SjUy+q69jmxgRmt1QY7KarJFgQYGT+1jh/v1Mof2oLcH0JYLDjzh8iLFKFSCRBOimT7EUyd+hLEg3RjxC8Nh
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5352.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5815c3d5-cf72-44f6-26e5-08dd443ab23f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 10:08:24.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8XX0c9DMqyJEHKsR5C+MJg7l1GBvRb0fEyXGuyk/fVpz8NJmYk7zNOgbbTeCNpxcK06rwj2qF1WzrgzYWxROw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5623

Hi,

> >
> > ...but that's just a fallback crutch. I would be interested to see
> > more details on why the kernel failed to assemble the region that the B=
IOS
> created in this case.
> >
> > The overall flow is:
> >
> > - BIOS creates ACPI CFMWS
> > - BIOS optionally creates regions within one more CFMWS ranges
> > - BIOS builds EFI memory map with the CXL regions marked
> EFI_MEMORY_SP
> > - Linux boots and sees EFI_MEMORY_SP + CXL overlap and waits for the
> CXL
> >   subsystem to assemble the region
> > - Region creation is only allowed with free capacity
> >
> > The known bugs are:
> > - Corner case CXL configurations that trip up the driver (memory side
> >   caching and CXL interleaved with DDR are current examples being
> >   worked)
> >   - Reliable fallback to "CXL unaware" behavior when region assembly
> >     fails, should be address by [1]. A temporary workaround is to
> >     disable the cxl_acpi driver so that hmem_register_device() skips CX=
L
> >     range deferral.
> > - Inability to delete regions that were created by the BIOS. Should als=
o
> >   be addressed by [1].
>=20
> Thank you for your information.
> I'll check BIOS implementation and investigate behaviors of the cxl devic=
es.

After investigation, we found the following two problems that caused the fa=
ilure of
region creation at boot time. (Thank you!)

The first issue has been resolved but we still need your opinion for the se=
cond one..

  1) HDM Decoder Capability indicated that the base address of the CXL memo=
ry was zero.=20
     We found a related configuration in the BIOS, and the issue was resolv=
ed when I changed it.
  2) There is a mismatch of Interleave granularity value between the CXL me=
mory device and=20
     others.
    =20
     Currently, my system has only one CXL memory device, so the interleave=
 way is only one.
     Therefore, its granularity is not important.
     Below is the debug log showing the error..
------------------------
 # dmesg | grep ig:
[    7.683843] cxl_port port1: decoder1.0: range: 0x0-0xffffffffffffffff iw=
: 1 ig: 256
[    7.691103] cxl_port port2: decoder2.0: range: 0x8a0000000-0x189fffffff =
iw: 1 ig: 256
[    7.719023] cxl_port port5: decoder5.0: range: 0x0-0xffffffffffffffff iw=
: 1 ig: 256
[    7.744093] cxl_port port6: decoder6.0: range: 0x0-0xffffffffffffffff iw=
: 1 ig: 256
[    8.452989] cxl_port endpoint9: decoder9.0: range: 0x8a0000000-0x189ffff=
fff iw: 1 ig: 1024  <----!!!!
[    8.454208] cxl_port endpoint9: decoder9.1: range: 0x0-0xfffffffffffffff=
f iw: 1 ig: 1024  <----!!!!
[    8.454273] cxl_pci 0000:01:00.0: mem0:decoder9.0: construct_region regi=
on0 res: [mem 0x8a0000000-0x189fffffff flags 0x200] iw: 1 ig: 1024 <---!!!
-----

    Other decoders show their granularities of 256, but the endpoint9 only =
shows a granularity of 1024.=20
    As a result, the cxl driver fails to initialize the device.
----
[    8.454308] cxl region0: pci0000:00:port2 cxl_port_setup_targets expecte=
d iw: 1 ig: 1024 [mem 0x8a0000000-0x189fffffff flags 0x200]
[    8.454310] cxl region0: pci0000:00:port2 cxl_port_setup_targets got iw:=
 1 ig: 256 state: enabled 0x8a0000000:0x189fffffff
-----

  I suspect my CXL memory is indicating an Interleave Granularity value of =
2(=3D1024 bytes),
  in the Control Register of the CXL HDM Decoder Capability Structure.
  I could not find a way to change this value to 256 through BIOS configura=
tion.

  Within our teams, there's an opinion that checking the granularity value =
is overkill since our interleave is 1-way.
  Another opinion suggests that the cxl driver should use a granularity val=
ue of 256 byte as the default when it's 1-way,
  considering the possibility of unusual hardware releases in the future.=20
 =20
  Could you share your thoughts on these opinions?
 =20
Thank you,
----
Yasunori Goto
