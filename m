Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793233027;
	b=RFltdqw+97s+OB7wz4RXA+akAlywdG4sdHwdqz+7XhpFqQJp5bhRjLh1OxRLIuFT3zLB
	 K8oNHS8kVgCotVfx6TOo56mgzAH/khl0Mn6ug8vLosRSnzOHQxfb1QNZplCd61CwWCCHt
	 r2QF/N0Vr8Hd4fvWUnmLYj3OQxcJ9wlIrHUWDpcrLu7tccehX/erw/3UfhhpEBnCcwnQD
	 TTd0C0xbfSThQmAu3xjgt30h3gMdQH2XzTqKdU/AbktbII327zttztko1AOfdPgo2gcZr
	 NHHRG5H0RfDSRG/3lkk2I0WwQ6JEkiEsVyu2rhQz8Hd5/gnXS2zT9j7jxj8IR+Xl+fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233027;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LmR0/DpPg5+UqVFjQsPDlBfqSEHeeRVE3qLnfxK/wSc=;
	b=Hp4EJIkBtNuhRuVMYgCwti9C/pWa7g/mLrbLkxF7cAF1pB38p+AeAcx9mdYSCAcVM8jv
	 NxzVda8S7jqvof94pSbg4lXx7tyFWJG441G5w+qNxfW8n0xLhas7ET8z5wc2z93rYEc5y
	 D/x8SLsJnYmJKfYtzcioVALuy2yj/McV3DbiUoiNrDT1a9krk4BpYv0lWEgzJP9vzyFJY
	 LSHixDCNmhv5DKasBDSiMIhLUtfTakRXaji4yZkWrZaJO+6R0AEIZmrbCIaoB9iTnNt/z
	 yWQUay6hSeYxtrxo6inxWVbmptFZKqMuOD/H6whcBWXRG1G6FiLm+4U7bDkHJI5fidA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=selector1 header.b=GljOCVLW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.64
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011064.outbound.protection.outlook.com [52.101.125.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB4606A31A
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 00:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ADB4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=selector1 header.b=GljOCVLW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rY8yJl3aO8P1AGfoP6MaJxriKs+bQxE9P09oW3MnkY8MtggPcpIq5SxMAeymwnylh5imf9jBoVDg4M48eUxOrDYxNnjeOMJaM+0dof9k4xEAy+C7rp2rsttDNGubmet4qGC4EUTXg+H3eiduA80BofjTSlZuxEEl7a6VRDeYHCF5RvtiR/u7lM1W3IxSuTg6aOtP62rGERyBTVmOO83lFPH3QvMHNFNynDW3UsdPDn0pvi1MoHDXCPRhObbuOyZYV1bNeero1P6CBPHnfYPb3dv2aNoBOozt6zGFG19miZXXfve5XbaNprLSW+mRbsniC5rhVrsv6hNSPbBVt0TlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmR0/DpPg5+UqVFjQsPDlBfqSEHeeRVE3qLnfxK/wSc=;
 b=n29bnf4JlS4Pb1aveuPy2Rc8yrAyVLCnM3QZcX3WAvP8c4qev33Pf6wCvL2GEJuqjw+uGvcCfeH3fa3Gn3bM7qcDK7IgSy/vQhCRFpUL5er1FCJR0PT5yJhHUyjWuUMrQ/r2EfrO5jcps2E8LFX2ume+ZsAbf9aOX1J3/kXY6RawjTHBG+e7SzpDXSMFma6sl1pQ/I0FiWvZOtzfZQGeskBGuWEK/Gmys/7K5lJgphZ71RhoBqtZyhpnEGz6CXRm3SRaVDXihMmmKzk2Y0PsLTtv2j1/tkS21ntqX84FUpbPuOPgUry3WV06b4c3L/D++WdFzTyAO1QUBnWpv34l7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmR0/DpPg5+UqVFjQsPDlBfqSEHeeRVE3qLnfxK/wSc=;
 b=GljOCVLW7d/GgU7+LiAXemzoZCuKmGZOJLjrK4ZG93ArggwHMZQsPykR6yxCeOisfwWTXlaBSj3zBvogsSwUa9Ttr9gHxSVVy+oQ+cKp1HwtjQTr4OZ/Iss9bFrY90/VDjS/vhgeUryFgxx2wm3eszve3lbHPN3tteeht/yk+8k4e/iXOWCvHaxTxBpTka4mGEgH2fEIcGKPT1qGrtCaDecNEqKDpj7yDR5XWj/iHDZ9qXrjqHYn6Fa/O+n7cIINpGHsyqxV89Zjw77b1cuFn0YtG3ucKhYwEPeybspVNP9HVG0ETWjGpr/x17YXFLGFD9CP4rH7eFJ8y/Xg5u3cFg==
Received: from TY4PR01MB17330.jpnprd01.prod.outlook.com
 (2603:1096:405:353::15) by OS7PR01MB11792.jpnprd01.prod.outlook.com
 (2603:1096:604:23a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 00:17:03 +0000
Received: from TY4PR01MB17330.jpnprd01.prod.outlook.com
 ([fe80::1f79:e5a6:ef42:4a81]) by TY4PR01MB17330.jpnprd01.prod.outlook.com
 ([fe80::1f79:e5a6:ef42:4a81%6]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 00:17:03 +0000
From: "Yukiya Takaki (Fujitsu)" <fj2110jc@fujitsu.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jonathan Cameron
	<jic23@kernel.org>, Junjie Cao <junjie.cao@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Tomasz Wolski
 (Fujitsu)" <tomasz.wolski@fujitsu.com>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, "Yasunori Goto (Fujitsu)" <y-goto@fujitsu.com>,
	"yukiya.takaki@gmail.com" <yukiya.takaki@gmail.com>
Subject: Re: [PATCH RFC 3/7] QEMU: hw/cxl: add helper to get HPA range for CXL
 Type 3
Thread-Topic: [PATCH RFC 3/7] QEMU: hw/cxl: add helper to get HPA range for
 CXL Type 3
Thread-Index: AQHdZSZl78ILHKkrVkCo2ScIJHxsILcSJ8cAgAGCEz0=
Date: Thu, 29 Oct 2026 00:17:03 +0000
Message-ID:
 <TY4PR01MB173303C46DA2AA6DC5170B72AD06E2@TY4PR01MB17330.jpnprd01.prod.outlook.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
 <22b52860497f643217fb52f029d87ebd8a6e6492.1793003983.git.fj2110jc@fujitsu.com>
 <auFLYiiwDiuXaHfZ@cxlqual>
In-Reply-To: <auFLYiiwDiuXaHfZ@cxlqual>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-10-29T00:17:01.788Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=1;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB17330:EE_|OS7PR01MB11792:EE_
x-ms-office365-filtering-correlation-id: a118265b-7c18-4443-0ce7-08df3551f585
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|1580799027|261028144727099003|56012099006|11063799006|4143699003|261026140227099003|261022075727099003|261026121527099003|10067099003|261021121427099003|261009223027099003|261022105027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info:
 bO1XqBFrCNafoU7gG/vpAUP4ivNPrkyJ8/AuVTpYVXC3AHMnNjM3qtTaMQAh/zF6oqOh2e2Z9xZOx5wexjApw8+NywMghUFZP2eWTLKcjoq2cIR4UJ7CYer7NwwcvyRG5ehaWM5dyE/qRZ+P06d9UhTWOiXX/DVE6gMMq3DuUhe75v/w89M/5WUlELlxQSBCcK9NcCzWlQvIYSO5CP3/wkl9J4ZRgQP8VxpaZzR6VN83hDu7CTv83tvzSdM4CeXYuJEYNc//iBC3PnIlrirhM7N2G4E5JMno/OGjUaGY2zRUAuuKHJ/94hRTNI1uosBGdlU1F9WVWa3i5tq/EvQii4zJ+K2OJv9PoOp0SA0FH2XnganpJg7MvpcuQkcA6EoJ0J0rudcI0IoojNusb8qlW995au4/BvSN9DaiHRD695o3UX2Ei4fqkv8wa9Maycf9oIfq5wczXSDlCuwWAY6kJFQK/Z/lhBB7BVa8ODXg19ebA9I4bipmc8bTVw5pnA2oDYDMY3+FFBPS7PIn5pCKzGUox3puNDZJ7UEJXhNuJRQsSnFVsJFKYxnslQupAljelRcWDtQ7N0YZgz/mZbMXY44fWatLGIuYOXxWKmHE14Ox0zrYafGJ+Zw5lLDjGRzaFL9o4KOPmRvHe6zkU20O87xLtjIM7o7FEWVN3C/7l6UuJlxMihSfaCfZVWjGmWdSSsc+vZzDOf0uEpcTtrNmom0YI5yjSh7ruXUdifGymvARPvwxVrD3BwJ86ppf2ldH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB17330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(1580799027)(261028144727099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261022075727099003)(261026121527099003)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(261021123027099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3dUTVFzN043R1M0Z2xndEZWSVBDa3hzalRtOXR6dnpOUjBPdThTWk9tamhE?=
 =?utf-8?B?WHc3TzNNZjlKaU5OQ2QzcHVaNG9PQ0hlTXF6U2dMTTl2VmhXSjRucUN0ckpB?=
 =?utf-8?B?UnIwQkpDZU5Ca01LT285R3pjcEZKZlVTT21uTGY2NWFWYzJqeGM5TGN4ZXR6?=
 =?utf-8?B?bGRTSXFhMndQREw3RmQzRUVIWHpUYlFLT3l2M0tUY3BjbmtPTE00NUhWQUZ2?=
 =?utf-8?B?bWRIVzdGSFp6SXNPYTZiUzdFQUUvTjF1ekMrcnU0QUN0KzVvZld4RkI5NTVJ?=
 =?utf-8?B?MkNMeFBXcVIrMFl4V3J5T3lIMlYxSERpeFk3ZzcwbUREbjNtd05WS3lOeVlm?=
 =?utf-8?B?SHFUUlpGTkNKbGhFNDM1RHJhNDI0YmJhb0JoMzVVMFQvZnNEK0NUQjhyYjF1?=
 =?utf-8?B?ejB2czNwcnRLMTc5NENEVE5LMUFxR1Jqd1Bmd0xQeEJ1WC9FNDdWSFlUNnA0?=
 =?utf-8?B?cGRnZWV2bGhDOFpUK2Q4bncrK2s3QTQyTUlGRmZXbitrTWg2SXliN1hFbVlL?=
 =?utf-8?B?WEZVV0VjcFhERHJJSUtCSlR5dVQzL2Y1WU9kSWxYaS9aeGNyOTZRK3BDWGZH?=
 =?utf-8?B?b3hVSW5qMjkvcFlnellaRG16SGZZN1hZSGdOUlF2T0xVZmttTS9LUWdmV3hq?=
 =?utf-8?B?aXhyaFphTys0dUNISHhYSHphZXJyOTNXUmc0Z1lIYTJ5eUg5MFVmeEViTjQ1?=
 =?utf-8?B?bU1MLzRaNloxNnZuMGRzdCtIL1NPMmE4cXZlUTMvM1ZtZ053cUNScm1SN3Vt?=
 =?utf-8?B?L3NTVUd1UHM4c0hjVzQ5aWptaENzQ3BSSWxoT1R5M2NnYzFZNWRmcXhYSDdk?=
 =?utf-8?B?UVgxNCtkbVp1UFFKV0p2enZiWmR2K0paSXZvUXA4VVJDTEhwSnA4WGxqT3dE?=
 =?utf-8?B?NTVvRDZVc3ZZdkN3OHVMMW5adUw5ZDA5UkxWeWZnVGptbnpmVW1mTzVhdU9m?=
 =?utf-8?B?Y2Njb2VlQTh3NTdDL2l4SUZYbnVITEVGcE5PcTBEWmFUTkgrUFhlelJBdkVH?=
 =?utf-8?B?OUhzaVhRZVFTTDBqbW8yVGNGa0cwTTE3TEVVTDNhMW9senYwSks0N0dwSFRo?=
 =?utf-8?B?TXQ5Tk11MzYxYUc2b2h6VkVlOVZYNDhXclE2UldOb0JNRk9MUWNTTy9OOC94?=
 =?utf-8?B?Ykw2ejloVlVlNkpCNnIzWEJjSEhobGc0dWdVa1REazdteHdpNmhsKzdjSTZP?=
 =?utf-8?B?ZDdpaGsvd3ZsdHBZNzVkMzhCd1ZWbjZLQ2ZUTnZOTmhSMVhZK09vUEp5UDAx?=
 =?utf-8?B?VVpaQ0xxYkJMQUg3S3Y4N1k1cEpvZWJCYU0rWFhiUktqSk5jZlJzRmxlSy9S?=
 =?utf-8?B?Z0Q5bG1QdXZDM3pEd1o2YWpaM29BVTBPMXlpT242MUZNZElkOStYdEdINmVJ?=
 =?utf-8?B?T3cwVGw0ZkdvNUIxUjZXa2l2Z1VJM04weXoxOHd2U2VnVXZJNHBua3NyRy9m?=
 =?utf-8?B?ZmFvM1FUZXZEZmRoaDM5T2Z4UEFKYXRxa0IyN0lpcG9ZSjNsRFgyYmVqMXhC?=
 =?utf-8?B?UDRBbFRJU1FUZWRkckM1L0RVdTY1WnNhbDZSbGwvS2JmeHUxUUdJaUNOblE5?=
 =?utf-8?B?bW1VbTRDZmlYOG91N091eTU1T3BhbzI1bXpTTUxXaHREL01lS25hOVBrSTVt?=
 =?utf-8?B?bTEwcy9RRGgyRHIwbFVZalUwUysxQ2R2aFJnYmhvYjBHaGhFT3VZTXlKRVgw?=
 =?utf-8?B?Yng4SFFHWnJINFFUcG9Cc2hPLzhFRStVZHVqck00d2JXbW52ZUNCQlNpKy9S?=
 =?utf-8?B?THc4WWU3UDBuZDFyajl6aTFZS0lXWkREVXNSK0dYQ2NxYmtBNE03QnR6TG54?=
 =?utf-8?B?RTh1OTAwWDd6clFlblZJaFhrck9vR0NBejU2UG9QMXVFVXZxZ1o2azN2Q2Qr?=
 =?utf-8?B?OHMxa013aFgvVlFqeEROa2FOb0tMa2dLTEhhSjhsbnRGd1FhSkhmYU05SU9L?=
 =?utf-8?B?aGlCakhNWkU4c2RDL2NtcmtwR0N5MHNEYUtjRDVyN01DSTFrWUI2a21tbXRS?=
 =?utf-8?B?RGk4cDgxNCtnVXFSVEg1RG5jMTF0WGFTRVFOSWpjRkU2d2N5WHhhM0N3Q20x?=
 =?utf-8?B?NTF6ZnM3RVRER2YyL0RhbjdRWVgzdTlUdHJ0ampZQ3dXU1E0Z0JNZkVBQmpj?=
 =?utf-8?B?a3NmekxHc3VERU5KOTVORFU3V25vUFg1UzArZVUwSjNWWDYrSzJNdFVQUlp5?=
 =?utf-8?B?eVNvdzNkT1FPbjJDZSt6UzM2STlHWjNBbFpLbFcvVUdBNTRpSW1xbHA2dG0w?=
 =?utf-8?B?VU85a04yUjREUHc2R211TzJoZm5WMHBJOEo4ZnRFMTAvRThvaG9MZHJydUps?=
 =?utf-8?B?WmhURmpYV0RFVFl5aWt4Uk9Md200bVVNZjNqRGpUZVFNQmxoT2xzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	n0+2LPj6xFi/VdJMNU3i9RNdongCwQ8wYjBG51VpZ9YGEc22iBL0foZ7qRuVS54326eSQOlpbH6jvZlaWeFe1eFNZZDXBUQIFzJUz3xqpNP17kgeoQQnj7sf+o8JVh1b0skg/v7y4jFyc60V5bVwPQxr1e+as0PK5jV7NTYB66E1yMDfRClz4Olg0o48cCJ5w2f5p1/eQGT8MAAVz2KLRTsX1D5ZCZ3ERK/H/ikNtP9g3EtkRa7d0duziq+Bkq4dZNMqwtPxeHz7qyNO/Ay34yPeKAfS7RcmFgI+b23coQblNnW7IRq9dc0VoOnJNsGGQPIppUUl5iSJgDcmUlSP8g==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB17330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a118265b-7c18-4443-0ce7-08df3551f585
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 00:17:03.7478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6R2RHztQS4CneIU5zw92aSoiJBaW/BAUc/hCubNujDqT5sxFTHSYMzT0uxf/wPswGlSlrm/o7fjx5WW8MgVq0dK8AYg3st55z2zXinAssA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11792

VGhhbmsgeW91IGZvciBwb2ludGluZyB0aGlzIG91dC4KTXkgaW50ZW50aW9uIHdpdGggdGhpcyBp
bXBsZW1lbnRhdGlvbiB3YXMgdG8gc3VwcG9ydCB2b2xhdGlsZSBtZW1vcnkgb25seSwgc2luY2Ug
SSBoYXZlIG5vdCBiZWVuIGFibGUgdG8gdmVyaWZ5IGhvdyBQTUVNIGlzIGV4cG9zZWQgdG8gdGhl
IE9TIGJ5IGZpcm13YXJlIG9uIHJlYWwgaGFyZHdhcmUuCkhvd2V2ZXIsIEkgYWdyZWUgdGhhdCB0
aGUgaW1wbGVtZW50YXRpb24gc2hvdWxkIGV4cGxpY2l0bHkgcmVqZWN0IHVuc3VwcG9ydGVkIFBN
RU0gY29uZmlndXJhdGlvbnMgcmF0aGVyIHRoYW4gZGVyZWZlcmVuY2luZyBhIE5VTEwgcG9pbnRl
ci4KSSB3aWxsIGFkZHJlc3MgdGhpcyBpc3N1ZSBpbiB2Mi4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KRnJvbTogQW5pc2EgU3UgPGFuaXNhLnN1ODg3QGdtYWlsLmNv
bT4KU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI4LCAyMDI2IDEwOjA5ClRvOiBUYWtha2ksIFl1
a2l5YS/pq5jmnKgg5YSq5biM55+iIDxmajIxMTBqY0BmdWppdHN1LmNvbT4KQ2M6IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgSm9uYXRoYW4gQ2FtZXJvbiA8
amljMjNAa2VybmVsLm9yZz47IEp1bmppZSBDYW8gPGp1bmppZS5jYW9AaW50ZWwuY29tPjsgbGlu
dXgtY3hsQHZnZXIua2VybmVsLm9yZyA8bGludXgtY3hsQHZnZXIua2VybmVsLm9yZz47IFdvbHNr
aSwgVG9tYXN6IDx0b21hc3oud29sc2tpQGZ1aml0c3UuY29tPjsgTGksIFpoaWppYW4v5p2OIOaZ
uuWdmiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPjsgR290bywgWWFzdW5vcmkv5LqU5bO2IOW6t+aW
hyA8eS1nb3RvQGZ1aml0c3UuY29tPjsgeXVraXlhLnRha2FraUBnbWFpbC5jb20gPHl1a2l5YS50
YWtha2lAZ21haWwuY29tPgpTdWJqZWN0OiBSZTogW1BBVENIIFJGQyAzLzddIFFFTVU6IGh3L2N4
bDogYWRkIGhlbHBlciB0byBnZXQgSFBBIHJhbmdlIGZvciBDWEwgVHlwZSAzCgoKT24gTW9uLCBP
Y3QgMjYsIDIwMjYgYXQgMDc6MDM6MjRQTSArMDkwMCwgWXVraXlhIFRha2FraSB3cm90ZToKPiBU
aGUgcHJldmlvdXNseSBhZGRlZCBgaHBhX29mZnNldGAgb24gQ1hMVHlwZTNEZXYgcmVjb3JkcyB0
aGUgb2Zmc2V0IG9mIGEKPiBkZXZpY2Ugd2l0aGluIGl0cyBDRk1XIHdpbmRvdywgYnV0IHRoZXJl
IGlzIG5vIHNpbXBsZSBoZWxwZXIgdG8gb2J0YWluIHRoZQo+IGZ1bGwgaG9zdCBwaHlzaWNhbCBh
ZGRyZXNzIChIUEEpIHJhbmdlIGZvciBhIGdpdmVuIFR5cGUgMyBkZXZpY2UuCj4KPiBUaGlzIHBh
dGNoIGFkZHMgYGN0M190eXBlM19nZXRfaHBtX3JhbmdlKClgLCB3aGljaCByZXR1cm5zIHRoZSBI
UEEgYmFzZSBhbmQKPiBzaXplIGZvciBhIENYTFR5cGUzRGV2IGJ5IGNvbWJpbmluZyB0aGUgQ0ZN
VyBiYXNlLCB0aGUgcGVy4oCRZGV2aWNlIG9mZnNldAo+IGFuZCB0aGUgZGV2aWNlIHNpemUuIFRo
ZSBoZWxwZXIgaXMgZGVjbGFyZWQgaW4gdGhlIGhlYWRlciBzbyB0aGF0IG90aGVyCj4gY29kZSBj
YW4gdXNlIGl0IHdoZW4gYnVpbGRpbmcgdGFibGVzIGFuZCByZWdpb25zLgo+Cj4gQ28tZGV2ZWxv
cGVkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogWXVraXlhIFRha2FraSA8ZmoyMTEwamNAZnVqaXRzdS5jb20+Cj4gLS0tCj7CoCBody9tZW0v
Y3hsX3R5cGUzLmPCoMKgwqDCoMKgwqDCoMKgwqAgfCA0MCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj7CoCBpbmNsdWRlL2h3L2N4bC9jeGxfZGV2aWNlLmggfMKgIDEgKwo+
wqAgMiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaHcv
bWVtL2N4bF90eXBlMy5jIGIvaHcvbWVtL2N4bF90eXBlMy5jCj4gaW5kZXggZDA4YTQyNTVjOS4u
ODExZjhlMjQ3ZCAxMDA2NDQKPiAtLS0gYS9ody9tZW0vY3hsX3R5cGUzLmMKPiArKysgYi9ody9t
ZW0vY3hsX3R5cGUzLmMKPiBAQCAtMTM1OCw2ICsxMzU4LDQ2IEBAIE1lbVR4UmVzdWx0IGN4bF90
eXBlM193cml0ZShQQ0lEZXZpY2UgKmQsIGh3YWRkciBob3N0X2FkZHIsIHVpbnQ2NF90IGRhdGEs
Cj7CoMKgwqDCoMKgIHJldHVybiBhZGRyZXNzX3NwYWNlX3dyaXRlKGFzLCBkcGFfb2Zmc2V0LCBh
dHRycywgJmRhdGEsIHNpemUpOwo+wqAgfQo+Cj4gK3N0YXRpYyB1aW50NjRfdCBjM3RfYWRkcl9z
aXplKERldmljZVN0YXRlICpkZXYpCj4gK3sKPiArwqDCoMKgIENYTFR5cGUzRGV2ICpjdDNkID0g
Q1hMX1RZUEUzKGRldik7Cj4gK8KgwqDCoCBNZW1vcnlSZWdpb24gKnZtciA9IGhvc3RfbWVtb3J5
X2JhY2tlbmRfZ2V0X21lbW9yeShjdDNkLT5ob3N0dm1lbSk7Cj4gKwpJIHRoaW5rIHRoZSByZWFz
b24gcHJvZ3JhbS1oZG0tZGVjb2Rlcj10cnVlIGZhaWxzIG9uIENYTCBQTUVNCnRvcG9sb2dpZXMg
YXMgeW91IG1lbnRpb25lZCBpbiB0aGUgY292ZXIgbGV0dGVyIGlzIGJlY2F1c2UgdGhpcyBmdW5j
dGlvbiBvbmx5CmNhbGN1bGF0ZXMgc2l6ZSBmcm9tIGN0M2QtPmhvc3R2bWVtLCB3aGljaCB3aWxs
IHBhc3MgTlVMTCB0bwptZW1vcnlfcmVnaW9uX3NpemUoKSBoZXJlLgoKUkFNIGFuZCBQTUVNIHNp
emUgaXMgYWxyZWFkeSBjYWxjdWxhdGVkIGluIGN4bF9zZXR1cF9tZW1vcnkoKSBpbgpjdDNkLT5j
eGxfZHN0YXRlLnN0YXRpY19tZW1fc2l6ZQoKSSB0aGluayB0aGlzIGhlbHBlciBjYW4gYmUgZGVs
ZXRlZCBieSBkaXJlY3RseSB1c2luZyBzdGF0aWNfbWVtX3NpemUgaW4KY3QzX3R5cGUzX2dldF9o
cG1fcmFuZ2UoKS4KCk9yIGlmIHlvdSBwcmVmZXIgbm90IHRvIHN1cHBvcnQgUE1FTSBmb3IgdGhp
cyBmZWF0dXJlIGF0IGFsbCwgeW91IGNhbgpyZWplY3QgaXQgaW4gcGF0Y2ggMjoKCnN0YXRpYyBi
b29sIGN4bF9zZXR1cF9tZW1vcnkoQ1hMVHlwZTNEZXYgKmN0M2QsIEVycm9yICoqZXJycCkgewou
Li4KaWYgKGN0M2QtPnByb2dyYW1faGRtX2RlY29kZXIgJiYKwqDCoMKgwqDCoMKgwqAgKCFjdDNk
LT5ob3N0dm1lbSB8fCBjdDNkLT5ob3N0cG1lbSB8fCBjdDNkLT5kYy5udW1fcmVnaW9ucykpIHsK
wqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAicHJvZ3JhbS1oZG0tZGVjb2RlciByZXF1
aXJlcyB2b2xhdGlsZS1tZW1kZXYgIgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgImFuZCBubyBwZXJzaXN0ZW50IG9yIGR5bmFtaWMgY2FwYWNpdHkiKTsK
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwrCoMKgwqAgfQoKfQo+ICvCoMKgwqAgcmV0dXJu
IG1lbW9yeV9yZWdpb25fc2l6ZSh2bXIpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdWludDY0X3QgYzN0
X2hwYV9iYXNlKERldmljZVN0YXRlICpkZXYpCj4gK3sKPiArwqDCoMKgIEdTTGlzdCAqY2Ztd3Nf
bGlzdCwgKml0ZXI7Cj4gKwo+ICvCoMKgwqAgY2Ztd3NfbGlzdCA9IGN4bF9mbXdzX2dldF9hbGxf
c29ydGVkKCk7Cj4gK8KgwqDCoCBmb3IgKGl0ZXIgPSBjZm13c19saXN0OyBpdGVyOyBpdGVyID0g
aXRlci0+bmV4dCkgewo+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgQ1hMRml4ZWRXaW5kb3cgKmZ3
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqAgaWYgKCFvYmplY3RfZHluYW1pY19jYXN0KGl0ZXItPmRh
dGEsIFRZUEVfQ1hMX0ZNVykpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsK
PiArwqDCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqDCoMKgwqDCoCBmdyA9IENYTF9GTVcoaXRlci0+
ZGF0YSk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBQWEJDWExEZXYgKnB4YiA9IGZ3LT50YXJnZXRf
aGJzWzBdOwo+ICvCoMKgwqDCoMKgwqDCoCBpZiAoY3QzZF90b19jeGxfcHhiKGRldikgIT0gcHhi
LT5jeGxfaG9zdF9icmlkZ2UpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsK
PiArwqDCoMKgwqDCoMKgwqAgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqAgZ19zbGlzdF9mcmVlKGNm
bXdzX2xpc3QpOwo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZnctPmJhc2U7Cj4gK8KgwqDCoCB9
Cj4gK8KgwqDCoCBnX3NsaXN0X2ZyZWUoY2Ztd3NfbGlzdCk7Cj4gKwo+ICvCoMKgwqAgcmV0dXJu
IDA7Cj4gK30KPiArCj4gK3ZvaWQgY3QzX3R5cGUzX2dldF9ocG1fcmFuZ2UoQ1hMVHlwZTNEZXYg
KmRldiwgdWludDY0X3QgKmJhc2UsIHVpbnQ2NF90ICpzaXplKQo+ICt7Cj4gK8KgwqDCoCAqYmFz
ZSA9IGMzdF9ocGFfYmFzZShERVZJQ0UoZGV2KSkgKyBkZXYtPmhwYV9vZmZzZXQ7Cj4gK8KgwqDC
oCAqc2l6ZSA9IGMzdF9hZGRyX3NpemUoREVWSUNFKGRldikpOwrCoMKgwqDCoMKgwqDCoCAqc2l6
ZSA9IGRldi0+Y3hsX2RzdGF0ZS5zdGF0aWNfbWVtX3NpemU7CgpUaGFua3MsCkFuaXNhCgo+ICt9
Cj4gKwo+wqAgc3RhdGljIHZvaWQgY3QzZF9yZXNldChEZXZpY2VTdGF0ZSAqZGV2KQo+wqAgewo+
wqDCoMKgwqDCoCBDWExUeXBlM0RldiAqY3QzZCA9IENYTF9UWVBFMyhkZXYpOwo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L2N4bC9jeGxfZGV2aWNlLmggYi9pbmNsdWRlL2h3L2N4bC9jeGxfZGV2
aWNlLmgKPiBpbmRleCBjM2E3MjlmOGM1Li4wNzY1NGY0YjYyIDEwMDY0NAo+IC0tLSBhL2luY2x1
ZGUvaHcvY3hsL2N4bF9kZXZpY2UuaAo+ICsrKyBiL2luY2x1ZGUvaHcvY3hsL2N4bF9kZXZpY2Uu
aAo+IEBAIC04NzgsNiArODc4LDcgQEAgdm9pZCBjdDNfY2xlYXJfcmVnaW9uX2Jsb2NrX2JhY2tl
ZChDWExUeXBlM0RldiAqY3QzZCwgdWludDY0X3QgZHBhLAo+wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2
NF90IGxlbik7Cj7CoCBib29sIGN0M190ZXN0X3JlZ2lvbl9ibG9ja19iYWNrZWQoQ1hMVHlwZTNE
ZXYgKmN0M2QsIHVpbnQ2NF90IGRwYSwKPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3QgbGVuKTsKPiAr
dm9pZCBjdDNfdHlwZTNfZ2V0X2hwbV9yYW5nZShDWExUeXBlM0RldiAqZGV2LCB1aW50NjRfdCAq
YmFzZSwgdWludDY0X3QgKnNpemUpOwo+wqAgdm9pZCBjeGxfYXNzaWduX2V2ZW50X2hlYWRlcihD
WExFdmVudFJlY29yZEhkciAqaGRyLAo+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IFFlbXVVVUlEICp1dWlkLCB1aW50MzJf
dCBmbGFncywKPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB1aW50OF90IGxlbmd0aCwgdWludDY0X3QgdGltZXN0YW1wLAo+IC0tCj4g
Mi41Mi4wCj4KCgo=
