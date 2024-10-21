Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19428F7
	for <linux-cxl@vger.kernel.org>; Mon, 21 Oct 2024 04:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729486323; cv=fail; b=DtA7WVX9k6Oh6QqnHMtNSl/3tVpxuW40AhRce8Jg8QKrBWxFHycV1AODa9WkiKh7oW/dZzcqalKW2/wgy9ppvCE67ftRsyJAclvbyICUODkFxvYCo9XQ1QUGmNzExbR81U4YlcVZtWbQAblvXwWgzofGC51gKthK2lTi513jdr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729486323; c=relaxed/simple;
	bh=Bn3RWLJBPpM3gafXyDWl3CSMKUOoEMu48Dl1cnEYCDM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VwdM6IB7DOuzCMnTIz4fWVcFUkfd/W4zUSrsGOS8MhP5mDZIQlURnstf2pUftKWnJNO/1UcrC0wWnEs+jA3cSC8sg00ma7yfe2ULIAZ5f1V5Eb6s8UObjbWe3Sry4FAaX/nXabg4XVE4nMBLJZ0HS4a7dCgnXMDwvCQ0evFBwrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=AtHu3gPd; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="AtHu3gPd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1729486320; x=1761022320;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Bn3RWLJBPpM3gafXyDWl3CSMKUOoEMu48Dl1cnEYCDM=;
  b=AtHu3gPdYmt3aMFovgJ1Ey0gvZsBJPh5MZCLZoSVwjMWYDr9myH9R8of
   ieIGl9eSNXaJoJT1ynkm3nDEoFyXt4eFxLD56r2pWvhaDhQZXwH8rS+kd
   Oy+uCaTGTOdTSAqecPnRYGDfIeWX9m2M27AZcOS6MVSQAdVNe89eINzZm
   0m+70O7e+zZOIvmZNxCHD1ihi3uYT3zuK8KEvGlyoGtfJJiSTQU31G0V4
   TqA3UccOQECFOp9n0QIJ+bylnB9axNerjDeguUzvjtahvt9cZsrlWgUni
   MT0EXUfkMEaScb5jPvdiyQd+4F2KGvtu1qkqcem7Dq9fY8kzd0E0KeGRf
   A==;
X-CSE-ConnectionGUID: UxQ3yyetRAeUhxU5chwYEw==
X-CSE-MsgGUID: OVt20tVDTBOAhmnYMyyKJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="135096661"
X-IronPort-AV: E=Sophos;i="6.11,219,1725289200"; 
   d="scan'208";a="135096661"
Received: from mail-japanwestazlp17011026.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 13:50:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un+r2ARDWebn5dKzUUEGURaAkNWs/pT0L9TYwR5yXlBbaIMQUNAbl1SvgJZafzrdx1RQf7tnp00rFbzQ3mgDehEBpWA4rww3HszjtMIdMh2f5mn/TqkjwC996crssCQ33OZDKNTnzkCWto1+qBB6bOCOn9ju3JH5UGS3UbDgwJf8fgctIimO0j5tXfY9hl2j+8l2NRO1vPXyH8U4ByhHcu8FTMac1e+NwoAoa/KSGDr6wuPkkXJ4CGOQk5u1U8UI/syFZdPWgnEvDi0QgfqulA/oxGsL3MP4WS8YdHE8vKYNIfAGkmL/+cW7B5c1dDfFyhOR0ckft0QK7T41+ubkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn3RWLJBPpM3gafXyDWl3CSMKUOoEMu48Dl1cnEYCDM=;
 b=DtNGwNuF46CnelrK1uXvrzY8WCHK1eioWtRbad7HLVmwy2xquuADdb4l7zVlowHD0TMwsC/UdEpGE3JXrySzbTc+kfxjpS3PMdnnncCRcDgNej2wW+rrTQrW8h1mFnG6s5ap8UaRwMmxL8GNd4KXBaWkncI4dMWjsYhlbyDXmN9vuXu/6V9I26OvhXpegxgGxJlnh5Y+t7tZE3uNVHvgajOB6O0Yn+UDwljvgb6S592iCd6EZxaP+Lj8ixskYxXCnsv7RMx1cy4xL7Ps51meNUQWyFeqI0LlvBykLidRUC8gyhjQzhNL5WsbQ2HDWNbARZAKVo6mJvJWnNuGJchL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYRPR01MB12335.jpnprd01.prod.outlook.com
 (2603:1096:405:105::12) by TYVPR01MB11169.jpnprd01.prod.outlook.com
 (2603:1096:400:36b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 04:50:44 +0000
Received: from TYRPR01MB12335.jpnprd01.prod.outlook.com
 ([fe80::18b4:fae4:bd97:f2b7]) by TYRPR01MB12335.jpnprd01.prod.outlook.com
 ([fe80::18b4:fae4:bd97:f2b7%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 04:50:44 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Why does cxl zero-label command fail on my QEMU CXL environment?
Thread-Topic: Why does cxl zero-label command fail on my QEMU CXL environment?
Thread-Index: Adsjc7cNDaeOWzIhTh2tIzh5mef73A==
Date: Mon, 21 Oct 2024 04:50:44 +0000
Message-ID:
 <TYRPR01MB123355935A2E90A320934E3ED90432@TYRPR01MB12335.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=e54f927f-f93b-4d3f-b1b4-ee3858961dfb;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-10-21T04:49:09Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: f604cec9ef0e4281b71d6f92cacf77de
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB12335:EE_|TYVPR01MB11169:EE_
x-ms-office365-filtering-correlation-id: 00039f6e-4a90-4056-3dfc-08dcf18bec21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?b1NrVy9UWGhyV2R4WEtNOXVWc2ExaUVaazkxT243Z3UzaTBBUmJWL0Vx?=
 =?iso-2022-jp?B?OGJFRVBOK29PcmZSNThzSnplYXJHQ0E1NitQOGRnZlpSMWYwWmErRFIy?=
 =?iso-2022-jp?B?SllieG42Qi9EUlJPQkF6YnNNS0E1VDhSK2FBUmxsQjJ0UXdUMW03Y0dw?=
 =?iso-2022-jp?B?KzFIZUtJWTlRekExRmJvZC96Yk9NM0Y5TGtZQjMrQkMydVNHMmowZ3ho?=
 =?iso-2022-jp?B?RjViV3oremdFUEFPck5EaHlENjVHRFduOHRORGZxUWQ2bnZhb25Zd2FH?=
 =?iso-2022-jp?B?dWRrNHBjeDkwc0JKeTlwMWhocE5DUFBPQ25yZnNPczB1enlKQmN3Qnh2?=
 =?iso-2022-jp?B?NFR0LzhjRERxWVBQNnZFOU95Ty9GdEFZaFZzbmdJdEFzdHJiVFdld0E0?=
 =?iso-2022-jp?B?V3N6OXQrZDJ1L2QvekViUkNySjdlUUZuK3o1R0E2amlLN1JYMTlCc2Fp?=
 =?iso-2022-jp?B?MGtZS2tQNWkxSUV3Z0gyOVVZa0xIYkRWN1lheUdXSlpQQzRtK0dNdHd0?=
 =?iso-2022-jp?B?WnQ2QzFwTXFiRjYxZFhkZDhTdTJWU2lUZ0MrdlA5MW4yYVpaOHlYUTJ0?=
 =?iso-2022-jp?B?eXRJclFqdHJ1QjhWRHRBU0ordXh5aDhjQmhuaW51OGM5YTRDbE0yd2pS?=
 =?iso-2022-jp?B?MEVyZlhqc2lKbHkwM3E1UE5GNmU1OTlubWVYSFF2cjQvM1ZsUC93RHQ1?=
 =?iso-2022-jp?B?RytuTzF1dytHeW1CWXp2SzlVWTh5S1VaTGdVdnBRVXMrS3FWbkZjdWI2?=
 =?iso-2022-jp?B?WGxOZzFnZjF3ZTF6L2greDVpV1JENEwxeVRrNWY0ZnFuTkdVM3lwUVcx?=
 =?iso-2022-jp?B?Q2JjcG9Ub0EwUTlHckpIeDNtMW1HMWxtT2dsYnViVEV4aHV6S3RQUnJ0?=
 =?iso-2022-jp?B?Zm5kV1ZncVpoMmFIQjdLUXZaRlpuRU4vQ2gyWCt0L1VWQXdaUEFWcWxw?=
 =?iso-2022-jp?B?bTRiLzRKdU5wYUp4UE1iTG1JdTZsZFRqb2VNVXFNTFlxZS9Rd2J3NlZC?=
 =?iso-2022-jp?B?T2ZhQlBnK295REZZUzg5Smh0RTd2WGJ4SEhhTmk2aE9OeVlsckcveDBP?=
 =?iso-2022-jp?B?QXdqVlU2WjFDd1J4ZWdwTWRDRjF5SzBLMlRma0J0VWc1MjgrNk4yWDF5?=
 =?iso-2022-jp?B?bW5uaVVmRTlDUFJHQVdUR3RnLzhkVEN0MWFXNCtPYy9vZ0gzb1pzbGNw?=
 =?iso-2022-jp?B?N1ZObEloMzVpN3o3bDJ5MVo4WTJYdmVybERzb2VDdTNMMm0vZE91alQr?=
 =?iso-2022-jp?B?eHRpcDRlc3IxRkhNSDlFNUpLZDl2NFR6WWJiWnBKNVp4YWxXekdpbUVJ?=
 =?iso-2022-jp?B?a2hWcUpTRnBxYXdVM2R1Snd6WHRYOWNWTUJBWUlCZlR2dFRSNVZoTFRy?=
 =?iso-2022-jp?B?aXJ5L21qUk11WXBQS2VJVEt1WFFTejVWb0NFUVpzazJmb2JCRU8vUkZC?=
 =?iso-2022-jp?B?dDNTcDd3emtkTkxqeCt6cWQwTlVlak5tazZXZXZXN0taaVdaZFhiRkNY?=
 =?iso-2022-jp?B?d2R4allqcjJ0ZVZFS2pQTndsZ3dnUjBGZXgrREF2eTVTUG0vK0o4bUhu?=
 =?iso-2022-jp?B?UnNOb1JJL3YwcnRZSFowbGtjVmhZQmNyMDBzQ0ErS2dSQVpobjdzc3Fi?=
 =?iso-2022-jp?B?T2hEZ3AyTGZHL3FiUHN0MXVNTWZyNzRDNUQwbW04c2d6MjdSM2Z6Vmdq?=
 =?iso-2022-jp?B?QzMyMG1Ob2k1c0Y3WHFIQUk5L0srRjlOWk9kSGdwZ08rdS9ROWQyTSsw?=
 =?iso-2022-jp?B?eVpQUHM1bHdjczlCWjZ5blRXdFMzVVpiWTZoQU9oSklHYmRZWDJ6UzBl?=
 =?iso-2022-jp?B?UDFvQnBpUHpzUFRiTGY1elUxMmdwN1p3SE5QeStlUXZrL1ZUWGpab08z?=
 =?iso-2022-jp?B?di92ZmxBUUN2SmhoL00rSWl6WEV6K1RrZXJzWEpPVzZkUFVUVWltcmF0?=
 =?iso-2022-jp?B?ekVKV05GR2ZKMGZxVlpOQW5kZnIxN05qc3c5OTB5eFpjNmhSRzVpR2R1?=
 =?iso-2022-jp?B?TWRnN05wdWhISFJ6UjQ3VWlyQTVUNzRFeTREL1V2TDlJNVhzbFlLQ3hS?=
 =?iso-2022-jp?B?YVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB12335.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cytGY05xNjlEaWtYWG5PbElCQWZxemFsVUJKcmxRdjBsUVhvTEFLeGph?=
 =?iso-2022-jp?B?eTM4NlJRTzJkQjV3ZnN1VjdxTFV1eEdEcXBoTkpkZFo3U3owbnFsa0dm?=
 =?iso-2022-jp?B?am5QbmdqaHhqdXU2TFFBVXNzb3h3TnFXRHlaUFJIdytEODVtNUFYZk9H?=
 =?iso-2022-jp?B?WnNYQmNuTWZDdXhnZG1LQVRVV2JncFdDRys3SkZZUFNENWdSZDZkZEZ2?=
 =?iso-2022-jp?B?bG1rQjRKRDgzVFFoZWFBTTRnU1JIRHZzcHpjWUZLbkltTVBwUlREN09R?=
 =?iso-2022-jp?B?QzMzSGhOcmtnZ2pWT0lCMGhTKzRzMzloS1ZMNE1Yc20weVR3RUZhR2d2?=
 =?iso-2022-jp?B?dnJ4dUlFZmVLTHNuZWo4MTVWYlM0cUlVa1RPbWVaaWZ0QlZHNzhHSi9s?=
 =?iso-2022-jp?B?YlE1RnV6aXE1NWd5YW9CaXdoZzd2eHFzVmEvTFpCRE1BbFJxOFVjTmo3?=
 =?iso-2022-jp?B?REhvWXpnc09ObzFFbW5vTFpKWUJCdVRocUlKc0dUTXE2RXMzcURuakl1?=
 =?iso-2022-jp?B?MjNWZmxpSUdsbWhNR0gycnBNZDBoUkoxMFpLMnMxTjFDZWhtTG1FWDdY?=
 =?iso-2022-jp?B?MHZMaXl5NmRKNkxiV2V2b3FPSmFmUWZvOHdrNUJ1ZTJIQ1IzWTIzRHBB?=
 =?iso-2022-jp?B?cW5DTXl4aW5oRlVQUDcxZ0lEb1ZLSXJKMmdML3Y1UFg4dTZNZk0yUlNI?=
 =?iso-2022-jp?B?WHYybExEWEpScU4xb0xCcU93NEZwQUtDYitxWEdiakFTT2dRNEFSd0NR?=
 =?iso-2022-jp?B?RUQxdDFibXJGVGVGSjVwaGZQYUlHNTM1dlZYUXNkWVgzdkRtRnd4Uk9L?=
 =?iso-2022-jp?B?ZUhGZW1iTGFPUzRobkNtMWU1ei90d1VWenV0SkEvbklxVUFML2tBVjJ6?=
 =?iso-2022-jp?B?Z3pvd09IeVpheXBIanZyRHE5WFU3Z0YvMVhDSkdjOFdqWFlJSGV2SGhr?=
 =?iso-2022-jp?B?LzR4WDdENk5nNFZBY2Q4Rk1aZDhpUkhoUWdFek82cWZNOUxWTUdwZFBY?=
 =?iso-2022-jp?B?ZjlOblZHV2ZEaU5oY3BKOWtQNllaTmpUZUZzRUozYW45N0Z4SFpsbzU0?=
 =?iso-2022-jp?B?Yk0yU09KOXpCZC9kTmIvSk9IWE9DV3VtalJSU0NvclhTNWlWR3VncUVm?=
 =?iso-2022-jp?B?OEx1U04vTWlOS1RPRWpUS2JqaUxDTFZLZENqL2ZTMFBQdUZxaEhuTmxk?=
 =?iso-2022-jp?B?ZlNnR0VQNWJ4Z2UybHZEZGppdlUxLzhQUWdsZzVJNzdYM0tHbC9kZDN6?=
 =?iso-2022-jp?B?djVNMGN5ZXRlRHJlYU1ONzV1MUh4Q204WGRjVmpVWWJIVGNBNDhhWE5j?=
 =?iso-2022-jp?B?NlI4bUxCQW0wREc5L0RqRGF5ZnR2R3p0V2ZFVHd5VzJlY3F1NzhHbmJh?=
 =?iso-2022-jp?B?UktGallBNFI1bjczOEVPYnRRaXhxU2p1dkdRclhFZXVrM3JnekJwbHRU?=
 =?iso-2022-jp?B?NGduYTVlOTlyajJTbnp4OU45K0xBbW95a2RjTTlZVXBVdC9WQWZmTnhv?=
 =?iso-2022-jp?B?ZDh0RDNkd3J4Mjl6WmIvWkhXVzMyOWpoZjA2TjRwcS9zeWQwUlg3OGJp?=
 =?iso-2022-jp?B?TkxkTzdPcmVPSUpscnZjVld4OGhkY0RqeVdIVXpYb3NicHVkelkyVWd0?=
 =?iso-2022-jp?B?aUZjcnpBUWRYUUFFTWFHc1hXclNqK0M5MTJ3WVZIV01KTGtVL3hQdmky?=
 =?iso-2022-jp?B?M3d2RkhGWWFUU1NGNEVJdGlPV3dFM2E3RUpiTUpxWTNieis0cHY4RGY2?=
 =?iso-2022-jp?B?cW1QWVczeGJLQnhXSmMwT1ZWU2owbVdzQ29kT0wwRS9CRjV5eEI5cmpQ?=
 =?iso-2022-jp?B?QS9uWGE1Wi9XY1N0R0JTaDk0OXNsWkxxVnJEUURoZ001SzJLb1NwQjRm?=
 =?iso-2022-jp?B?T0dRNlJodGlTazJEUUd1WXFMZFYxelRROU1uVys1VG5sOUEzN0FDSjNQ?=
 =?iso-2022-jp?B?dGRycUVKYzFEcGhibmhRaGJvcHNuV3NIdEphcTA5dlBPVlNZZzEweTFH?=
 =?iso-2022-jp?B?cWpaREMyWW1mZzlxckdVSzQySzUxSlZneGdiYmtYWFlGcGludDh2NjFZ?=
 =?iso-2022-jp?B?NjREKzRRcHlKSEpDMEJrcTBLdkFzOUpWdzRWNDZuVmJCNWtScE91bEUy?=
 =?iso-2022-jp?B?RTBLdERxTlBFZnZsM0EvUUhKOHlLL1ZoQ0N6SDAvNTdMR3prb3QyRmNM?=
 =?iso-2022-jp?B?SWIxeWhmWFlwU0RvaFYraGMxV0dST0lTQXVJVWRML2U3REtQWm5SNHRR?=
 =?iso-2022-jp?B?VG04bG1wNm9vZ3Y2aUNTbVNRSU12TGQvejlvU3I0TE1xMWp0elU4ejZV?=
 =?iso-2022-jp?B?azRJMQ==?=
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
	DRSAH/SOykEcaujFCcOkvPOKcS2/1OOjjHCT1GkgaFCx4wY+TTVPaFX+GMnXFA4y72bYdE7DLKLjzHhL9Fdh6T3zaZpmIM4p+wKgse4abTIMy7OPop8ulPLMcOPUxhMIH2YjY3FzSd67t416KdDxrquWO5GKSf2An1apAVHGLfBozU7uOdqc8hAPm80YWU6E6+Z+98pOKCJFJCnSbSrM+/QFRybNKVjCRVb0uiMSjMmyCmfKIZ6ObR21C7VHOlOykF7B73a1slLgb60uxbB4knVB5KpJjmeepamk1/jpyZ3XbUDL01w5CEvoafM8FHh6bFuNS1GjlHniTewumP+TUyiT3KIhrHRz1c5GSGqSvfSLmC2+DClXMdvg6HnPsE4T7417JjZ+O61N1TDPFUgMcxM+qdiZR4emSvUHhfMOUPAHQ3ap8dwSDZQVvNZMNYucWmVhsk0YRiIDXyO7Esjaj8CmByol49nX0V/axlojeqLwKWBUutJP7NZwgkp6EKlOf73fuuAQxAnDVCs+6pLQeDgdrxlcjPMoaLDlv9MnvQi2tFhs6U7/ZO3Qo3wnxyiByhFP1XRuAhJjz3l+pccPH8G6/9pUqgFovyR1aAqyEdWxz088vliTlq0DAHfOKtUj
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB12335.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00039f6e-4a90-4056-3dfc-08dcf18bec21
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 04:50:44.4023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2ZqJCFuC8GqV0WC0jo+iZJKbahTz/PZKCscfmZdIyik+RtKmdYuWZ36bwOv7kZvoLSfrummmgZMQAw75/Axfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11169

Hello,

I'm trying to execute the cxl zero-labels command for a CXL persistent memo=
ry
on my QEMU CXL emulation environment, but it fails with the following error=
.
----
# cxl zero-labels mem0
cxl memdev: action_zero: mem0: has active nvdimm bridge, abort label write
cxl memdev: cmd_zero_labels: zeroed 0 mem
----

In constrast, ndctl zero-labels seems to work correctly.

----
# ndctl zero-labels nmem0
zeroed 1 nmem
----

Can anyone identify the problem?

My QEMU options are shown below.
(I suspected the nvdimm option might be causing the issue, so I specified=20
 nvdimm=3Doff. However, the result was the same.)

----bash
sudo /home/goto/qemu/build/qemu-system-x86_64 -drive file=3D/var/lib/libvir=
t/images/goto-fedora/Fedora-Cloud-Base-39-1.5.x86_64.qcow2,format=3Dqcow2,i=
ndex=3D0,media=3Ddisk,id=3Dhd \
-m 16G,slots=3D8,maxmem=3D64G \
-machine type=3Dq35,accel=3Dtcg,cxl=3Don,nvdimm=3Doff \
-smp 16 \
-nographic \
-net nic \
-net bridge,br=3Dvirbr0 \
-device e1000,netdev=3Dnet0 \
-netdev user,id=3Dnet0,hostfwd=3Dtcp::2222-:22 \
-drive file=3D/var/lib/libvirt/images/goto-fedora/cxl-test-home.qcow2,forma=
t=3Dqcow2,index=3D1,id=3Dhd2 \
-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/tmp/cxltes=
t.raw,size=3D2G \
-object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/lsa.ra=
w,size=3D256M \
-device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
-device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D2 \
-device cxl-type3,bus=3Droot_port13,persistent-memdev=3Dcxl-mem1,lsa=3Dcxl-=
lsa1,id=3Dcxl-pmem0 \
-M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D32G
----

Thanks,
---
Yasunori Goto


