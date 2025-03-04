Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DD1FECA5;
	Tue,  4 Mar 2025 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081557; cv=fail; b=KiLwEwecVO0CzSxZEvJx1GaxlZBlEdZUpW2/DMmvnPp+9rT0qN1JL3tOWiLiHHqGDxpJarO7LHl1QjPvvmGs7RBVMokFpevy7NJoFROs8g2YAWcybqfQm1uPXm2Yqjw4CWVZjKX1QWg4+6qqjKtXIw4vl9izQn6GuxCyxWnneQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081557; c=relaxed/simple;
	bh=Kzj3IkT+4vOLLZ3wdHidpS0vwxxOI1vNXCGrRKlCboI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QM4sbSjf7b63TE4dzKgrMX4MTG+/W8AYPb6G9sPe1xl1MtlX/9EIDByxoaSH6eeWi7eiWSNuHL1Cqy0AKZUc5N8LUr60UmPQHsNHdZQaCrpd2jqios3584WjQWdmT9ThEtjnuEZatbwx197RL93n3aknAU4xF/hRkc2BRTwgPwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bS0mCgyu; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bS0mCgyu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741081555; x=1772617555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kzj3IkT+4vOLLZ3wdHidpS0vwxxOI1vNXCGrRKlCboI=;
  b=bS0mCgyuE2KQuCzXhBkk1amL4BqKufahPmW8U62/LnRqROGs42QW6EPT
   3zDSFv1ot+d8347HMmPXazskBZuw//ChrtaHizohLRWWVJXKZQit0FfFe
   17mtd3C99B2u5eYVY8ZbZfGLlvnPRpsNGd2q82aQgge9tA2qZxkAg2b5G
   tM4NoKvkJj6AFRnyBt59PCszlzNHJCl5PPQcxeLYOAM2rwdVv9hCGrSoL
   QGM06j24OGfw89lpzmxhUurdoKYEQzcQ4yVkkHQksRcQA9feozJ8xAv4M
   SKrDXqDUQqyUpRCk3c4oxNLpyRsuZK3QLnemalFz/5qE6JRyT8RG6qMEz
   g==;
X-CSE-ConnectionGUID: C/FpJF62RFGP4kOuSr9u4g==
X-CSE-MsgGUID: n/X1jBeaS8SPD3cl2QGWqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="148097938"
X-IronPort-AV: E=Sophos;i="6.13,331,1732546800"; 
   d="scan'208";a="148097938"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:44:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPzuvJk95Cu3aq/6BCMf6uIn6gHLbf07DUEFYok7pq6J450zblMPVsOl+UtVcvGS2rJgAFH6+uP7j+yib/qbN0IUeS2U4A3yZ41iCY3Fc4ZADUJxFlPVr6F+wKjIwCN0E0RWhApSMEkfj6f7BYKJFdCrQmLDSuKXZxtcgkxm59wXKSadUA+cTb9QK6Eh2kQd67MYHaw6iJNDcOOhmZvtFRrbfnkQYZNOhc3FBW/BGeWO5SBaLrR/y8z8t1GNvR02ij2bZpCcJtOnuIgROS0Df8168+4z0M+kqQqFDmqoG7svsK4WH2j4Y7LkhINEv7AqnA+r8j5/0qKDY7EoPsFrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kzj3IkT+4vOLLZ3wdHidpS0vwxxOI1vNXCGrRKlCboI=;
 b=LfTlEEmAg3+UJW44qQ+f55r28SzosmCBeQqTHhwlJSHcES8Obfq+hiJEH6R+jCUDPsbnMKWFfSQ22y0o3jgE+0e4vjRp31iVungU1iM7S8sCIAxvF7CIbxGqw8hrEcJQ0RMd1p80FFmui+h5veGVp253unpL13tWRFJVNeKvsANR0trSTYGqC2HkLYfYpf7WOQa3ObvmRLzVSPDIKiUJ51Z/22YwhPmpCMQIGFj19AS2i7GRA/jdrzy3sKSw7SOBPjFvhnhXRV7N1vTTc/czan5IxsAQQ6KjDsEfG97JuQgpohTD443WeCHIoOS/WCVJiEVdWKBzRwqQSO+axsnN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB9575.jpnprd01.prod.outlook.com (2603:1096:400:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 09:44:38 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 09:44:38 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] resource: Fix resource leak in get_free_mem_region()
Thread-Topic: [PATCH] resource: Fix resource leak in get_free_mem_region()
Thread-Index: AQHbjL63FHyI9x6BU06Tyq8i9FtW9LNitF2AgAAGOgA=
Date: Tue, 4 Mar 2025 09:44:38 +0000
Message-ID: <7e01507e-deb2-4acb-a2b7-530beb0d92dc@fujitsu.com>
References: <20250304043415.610286-1-lizhijian@fujitsu.com>
 <20250304092219.GH3713119@black.fi.intel.com>
In-Reply-To: <20250304092219.GH3713119@black.fi.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB9575:EE_
x-ms-office365-filtering-correlation-id: f4a16e1a-33ab-47fb-35d4-08dd5b012e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mmp1Z08vcFhzWlZmQ2NQQmEvRkhKaGpGcnFDdGh3cmYvUVprUys0Y2RPKzVs?=
 =?utf-8?B?ak94eEI0L1Y2NFFrVjVVR0dDczNrdC9NV05KQlNYQytDdk5hQU82TlRoTGty?=
 =?utf-8?B?TlRBMkVVR29JK2x4QWR5SmNhd3BzZ3NVczNWcUlhNHZhZlRTU1pISVUwK0l1?=
 =?utf-8?B?Y0dwK2t3SDhvc1IyZkNvemFxY2d1enVmSXBTdFA3WmtDeWhoSFBZalFFbjdW?=
 =?utf-8?B?STFhV2phd3BPZW95ZjN4NEd4d3pmcUpXR3NNTm40Z1F2SzlqclNFUTBFdVFI?=
 =?utf-8?B?Q1p0VmI0OEV3eXVpcWowelJvNHMxb0lFUVJJd1ZjQnNyaUFwMDR6S2V3cnM4?=
 =?utf-8?B?ekU3SlpNdVo3SHlqWld6c1BYbTdQMlFtbTNkZlVFUjlBZUMrRitoYUNVdWty?=
 =?utf-8?B?WjJPcmdybEJFTm9LQWsyUjY0TmRGOXA4b0puZmFBUTVxemN1RlBPU0FvL1Yv?=
 =?utf-8?B?Yzdrb0xuUFJnQTVYUzE1TENjWHhBRFNFVDcvWnhSTXFjeEdjMGJaNUNoR2tU?=
 =?utf-8?B?WTZlUzUwS2pEUGNZd1l1aFBCRjNUdkVKZGdyelBoNWpBY1dEUkRGaUwvUVJx?=
 =?utf-8?B?UGdDdkNWeDRhTWZsR05EbW1sZllYRWR1aHpQMzh0dURzT3lhMUtuSlU2cU9r?=
 =?utf-8?B?THF3cE5PcnlJQjQ2TFVTWC9EbXJjVWhSUlFkU1NXbHJHdFJ5UjhrNVpNZnBJ?=
 =?utf-8?B?KzFnTmdEWXUyeWJhZ1RwVi9MRHFWeEJyMnpaQk4veG0yM2lNTEVhQkxBOXhv?=
 =?utf-8?B?UElVMnFkc3NGVGoxUXVaOTVhWWVtMlUxcFNyZElZZ1hubjZxZklNWnJ4RVZm?=
 =?utf-8?B?bmRiR2IzRWM4RHE3UVNxTTVqS0F2RnRRNWlDZ1V0UmZqSFlQaVFCR2tOZ0ZZ?=
 =?utf-8?B?T3ZObkJVa0F1a2srTkNORGxHYnVZREpYdUkzcEJlaUtDTXNXcmxPVlhmQ1hK?=
 =?utf-8?B?eVpEelFLR243MGFmdGZwcTZtR05IREt6ZXlHL0lwa0ZYZWl5S1cxeElROWNZ?=
 =?utf-8?B?dnFYWHNOSVAxYmxlL2orQWVNNHdneWNOV1BBUVMyV080elFBTVprUlg3bC9Y?=
 =?utf-8?B?WmxHV0lRZWFUNk1RN3VLdXNEQ1JOdFZqcXl5V2lJeXRXL3hWSDY4VG4vejdE?=
 =?utf-8?B?VkhzcE9nZlVVbmE3eVZNdElzVGdUeTgrNDM3MDByenJQMkdMS2lsWjFNdmNm?=
 =?utf-8?B?U2c4UzhHN3BSS3lWb1Z1d2ZnNmY1UUNNMWtZUXpHbmRLVVhiMzBqYjhsY1FU?=
 =?utf-8?B?U2g2MExrMWZlc1Z5ZWhjQ3d0SzhYMWh1ZE9oMTl5MzVmTjlsZ3Z3ZVFOK3Vv?=
 =?utf-8?B?ZWd3Q2xVTWlkRzBlMWJNZ2dYVGNYVG1aQVoxY2luanpFUks0RG9CVWJCU2Ja?=
 =?utf-8?B?OXZIcENxK2J6NllpQ0IzSlRjalQ4aCtRZ2hBRSt0QUxQMUR1RVlBR0Y2d1hr?=
 =?utf-8?B?d0xmck42MEh0Y3RudVdzRTZkMCtuWkVkbEJ5dk9rV1hCTmQ4Z1Z5MWhjTkt3?=
 =?utf-8?B?SG1BZy9MQzBMR1ZiQlJDeUpuQXY4VnVoNlNyK1RzenlyZG1lTFd1TkNFK0Ux?=
 =?utf-8?B?ZjNGREdWOVlrMlFqYkdoa24rSXFISVoxSzJZWlFRbllWWk5Zb3c4UDFTY1BU?=
 =?utf-8?B?d0hVbmErSU55UE9oMnlXNlE4V2NEbzQ3SWRJeHF3dkdBOHRPY1JNMmtleVNG?=
 =?utf-8?B?ZmZkRGpEbEdOM1Q0NEx4VmhZcEJ4ZUFST1FrNXB3SmoyOGdjSm5KTFZqTzBY?=
 =?utf-8?B?TkFhakdlWmJOSFcyWWc0VnZJN3VTYUY0V2FXRXFKNVpqTFduenF2ZUZPTWh6?=
 =?utf-8?B?YUx3aEp1M3M1ajdNakErTEF5RENEK1Rtd3dCNXdBVVhGSTJTaFpjb0tSbDJp?=
 =?utf-8?B?VVYySGdMWStVVXppNnlYT3hKcEJHQWlzMk45Y29OTTAwOEFqd0V1Z1VVNEFG?=
 =?utf-8?B?dmVtVXh5d01PSEpVTkw1VjUvOUZVR1lqMnZWcTJJWFhaRDVLV0ZyQjVhZ3Fl?=
 =?utf-8?B?SnZZellmNmR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YW5LOVlDTGtRUjdIUlZGYlJ1MFh0ZlJMbjRQU3U0K0lSNE9VN1pPZzVxRUgx?=
 =?utf-8?B?bmhucHlScmZEOE5ydC9yekZaa3I5QU85SStHbWt1QWpxaW5TVS9McVh0dmVv?=
 =?utf-8?B?aTJha3NqUkVOQm40cGJwK1VVcHE0VktvcFFBZlN3S1dKQSt5Vi9GWXB5Y0Ix?=
 =?utf-8?B?cjRHNm5wVWdyZGl4ZTFoUjF6Y0o2SGhjMlhjeWdYNlNBUWxWV1h4MzVycml2?=
 =?utf-8?B?NGFLTE5kS3E4MDFhaEo3ZzRrTnJEU3BjUEk2STBkNnZSVjFUMnpMblEwVkNq?=
 =?utf-8?B?cncxb3VEeXlmTnRoVXQwMnlsVElhUUdVNEpkdUdMTUo2Wm1RYS9kTWdibVVp?=
 =?utf-8?B?UGVFOTdmMm43ckx0b2tEMEh1cHRIUWQzVHQyazV4SitxYWxrV1VPeVp0V2RH?=
 =?utf-8?B?d2djc2RTdi9WUUU2WjEvSHFoZ0hNYUIyUTFYMHJQcjhoQkhhcWNQR3hKRkpp?=
 =?utf-8?B?dXRoVC9GcVhzaTAxSGRVeFRNMmNhVHlxMC92Yno2U1FObFN4RTFHcGxrVXhk?=
 =?utf-8?B?by9TeXo4dmpud3FZd215UWtPZk5wc1BJTWlsMUx0RVJqZFdoSnN1ZHJuV0Qr?=
 =?utf-8?B?ZS9LV1J3WXh2VVkvKzY3Z2ttSlUwRnkwR2tTdzB2a0Y5ZkE3bE1CRFdwSVBD?=
 =?utf-8?B?bVg4VFZKY2RtM2MxT1ZQMGRWY2JzblpQTU5SalhqS0czUDdLK1cydzgyVVR0?=
 =?utf-8?B?T0JXaUplTXB0OUpLakQ2UStKSk8zRXgxc3FhTmgrZ0RmZnNHVnNhQ01ZM3NO?=
 =?utf-8?B?bFZ1Mmx1Zm5hQTBTY2Z3TnhQa2J0OXVUUURVZ2RxMTN2djA5ZWFVMk1YMkpk?=
 =?utf-8?B?Y1cxRVhPLzByVHFtLzFsdHZQVFZKekNmcVp3eGtGRHkyNW81Y1FuN2V6d2tn?=
 =?utf-8?B?ZklSaktFNkNuNkdkdlRFNXRhdUFuMmc5Z3ZnRVhTWEdKTDJ0R2tPN3lBY3BO?=
 =?utf-8?B?aE9kOTR0U0hDWHdvQ1R0SjRpOElZTWNPRWNCYndYN0krQ0RGN3hRT3lYSk5C?=
 =?utf-8?B?VGpTZTFDeURLd1p3UEFlem5ndjN0Vm9HZ2xwR3VML2k1SUdrWkJSVmk5clAy?=
 =?utf-8?B?aERxNloyRVFHa1UyWGJoMXlZbUFkWFQwdWdsUjdZT1VCYUFuajIzTUxWZ2R6?=
 =?utf-8?B?WTFDUlhVNWdlZDkyV1dIZ28wdVc1bmdxYWs0SFFlZmJzMzI5cW8rZEJKSWtR?=
 =?utf-8?B?MWh5ZmRNZCtnb0IxSXFuc0U2cXl2dUNGZE82VkhCOU9Pc0JmeUpFRy9jOTZ1?=
 =?utf-8?B?anZ4MGZtSmJRRWtmaVlNemllT21BRU53RisxcHBrTW9nYnZVTVlxajUwc090?=
 =?utf-8?B?UFNtc1N2Njl0Z2t0c05qMGtSdjdOdWQxdzRFdkVvTm5KeW5NZ0NBQUtHSFBw?=
 =?utf-8?B?ZE1wQWFhZUFlZk9KaHpVYVZxVE9mc21sSXliRkFjanlaWTNNdlZETGMwdmRF?=
 =?utf-8?B?Yk83eWxIdFMveW9YMW9FSGNUV0FGZGN0N2VPM0xPY2JYZURZYktZTmxyQi9P?=
 =?utf-8?B?NUFBOTRCR3hacFRWYnduZDc0TEU4TElaLzg5WTlPdTZxVTROUkVrL2VtMnJ1?=
 =?utf-8?B?bVIxV04yd1FSbzhDZ1VMN3c1THRJWksrUytGRlVrMnMzNXBJd1haUVlEKzhJ?=
 =?utf-8?B?TU1FbDBrOXlreEhRL2g3SldxTHVkVGZDZlRiR0pvZ0Q4YjVyeXM1WjZUSVBG?=
 =?utf-8?B?UVhybTJxbUdvZEhWeldQMlRtbkpOTC9NMG1SWlhDTFJnMUxVaWtjelBqWGkx?=
 =?utf-8?B?VjE4djZkdHNOd0ZqbjgzV1F2RzdOditYY0cvSy9GdlhLL1U2bFlNS01sckVN?=
 =?utf-8?B?ZlB1UkZHQ2F3UWJGdnM0bk4zYUQ3Z0ZWcG1ZejJERDhUNWg5dTFPdUxBWTVZ?=
 =?utf-8?B?ZlVmTnpHZTNYbVlYZ3Vhdi9tV3EwV0w5NGtKTVpRS1JoU3NxclFaSTZTQjEv?=
 =?utf-8?B?emhJcGUwVWhQdlBNVWgvOEJ5b3BwN3hka0J4WE4xTy95T1cybmpZaVNkckdx?=
 =?utf-8?B?N1VVWFJPaHpYOFBHcTVVOUtQYkhvV0FzODA4dENLWnRqeHNQYTJjM0ZBUzNr?=
 =?utf-8?B?SjRvaU5iRTZzUTNFYzdad2FNWU5uckl1ZHhHZ29lL2dvUGlpUExkSko4MVFi?=
 =?utf-8?B?MktDSmI5bVIxcXR2T0o5akFPREF1T2c3QVVYQVNSazNqUDVXNE9KaWx5NTQ1?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <253DD3CE9B89BC468ACD33B1A8F6E3DA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L1Ezj353EO3/ESCVZ2qE2+JG+5hsQ38FY7NSdPNxVn5SDwgoYyEHtySCRBdkrslMCbhFcXMj8PIvqA7sFPqTtV1kzGXX1ffKhCW0BsrSYAPal9NmtYqeL3gBm14buLmAiDHiy0L3e3cM1Js4ACa/ohu6WzSwY2IxXKg9ERfjlnMMA3eYug1EJdGZhVqVLEaSvEjw9w4BSU/TA7ybsZpBGjYK3HflZHdqsgPt2YNbWW/jWdsXXEMCswZEUGkYOlVQ97u6Hu5TBsGVPZSY+7lH+r6d9Mg7elwwxxnWUlZIJ3KkynGImZGlJh8il9axGuxw7jEbnNeVf3fm8IsA7jPfFhw+iHGrd5+leGR0l51ol6ubVqYdpQUXqkpOw58TveEcaw2zhNJNoyjSdwlDNTH9hQm/j6kWauzuYrDREVzcItKlZlrzqwoe8yZiYsAtZmRV5wrBB5XK46C2+Zxim8fx+9+WodvYFUkQ+I5FQ2ap9b3NmUQbPbxQDG5NmmjrjzRgmo+58YLOBSwheYAIZGlxhWpLzjemVV2QqN+m5ojAdtQXS641yLy7AK0aesTtGaKMngF/dEiLPD34o60e9IlRinY+QE08Kc7Et6luqR4ZRaUkXR14g5ufH1BxuJpUeQgi
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a16e1a-33ab-47fb-35d4-08dd5b012e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 09:44:38.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xj9Kck4GM954Y9XLRddw6nfxN1XyUE/V9nMib67y/wNKl3MdcF3sysRrd84L4sHsAftNxCo4vqt9rPPPuFcxYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9575

DQoNCk9uIDA0LzAzLzIwMjUgMTc6MjIsIE1pa2EgV2VzdGVyYmVyZyB3cm90ZToNCj4gT24gVHVl
LCBNYXIgMDQsIDIwMjUgYXQgMTI6MzQ6MTVQTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+
IFRoZSBsZWFrIGlzIGRldGVjdGVkIGJ5IHRoZSBrZXJuZWwgbWVtb3J5IGxlYWsgZGV0ZWN0b3Ig
KGBrbWVtbGVha2ApDQo+PiBmb2xsb3dpbmcgYSBgY3hsIGNyZWF0ZS1yZWdpb25gIGZhaWx1cmU6
DQo+Pg0KPj4gICBjeGxfYWNwaSBBQ1BJMDAxNzowMDogZGVjb2RlcjAuMDogY3JlYXRlZCByZWdp
b24yDQo+PiAgIGN4bCByZWdpb24yOiBIUEEgYWxsb2NhdGlvbiBlcnJvciAoLTM0KSBmb3Igc2l6
ZToweDAwMDAwMDAxMDAwMDAwMDAgaW4gQ1hMIFdpbmRvdyAwIFttZW0gMHhhOTAwMDAwMDAtMHgx
YThmZmZmZmZmIGZsYWdzIDB4MjAwXQ0KPj4gICBrbWVtbGVhazogMSBuZXcgc3VzcGVjdGVkIG1l
bW9yeSBsZWFrcyAoc2VlIC9zeXMva2VybmVsL2RlYnVnL2ttZW1sZWFrKQ0KPj4NCj4+ICAgICAg
X19rbWFsbG9jX2NhY2hlX25vcHJvZisweDI4Yy8weDM1MA0KPj4gICAgICBnZXRfZnJlZV9tZW1f
cmVnaW9uKzB4NDUvMHgzODANCj4+ICAgICAgYWxsb2NfZnJlZV9tZW1fcmVnaW9uKzB4MWQvMHgz
MA0KPj4gICAgICBzaXplX3N0b3JlKzB4MTgwLzB4MjkwIFtjeGxfY29yZV0NCj4+ICAgICAga2Vy
bmZzX2ZvcF93cml0ZV9pdGVyKzB4MTNmLzB4MWUwDQo+PiAgICAgIHZmc193cml0ZSsweDM3Yy8w
eDU0MA0KPj4gICAgICBrc3lzX3dyaXRlKzB4NjgvMHhlMA0KPj4gICAgICBkb19zeXNjYWxsXzY0
KzB4NmUvMHgxOTANCj4+ICAgICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzYv
MHg3ZQ0KPj4NCj4+IEZpeGVzOiAxNGI4MDU4MmM0M2UgKCJyZXNvdXJjZTogSW50cm9kdWNlIGFs
bG9jX2ZyZWVfbWVtX3JlZ2lvbigpIikNCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxp
emhpamlhbkBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBrZXJuZWwvcmVzb3VyY2UuYyB8IDIg
KysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9rZXJuZWwvcmVzb3VyY2UuYyBiL2tlcm5lbC9yZXNvdXJjZS5jDQo+PiBpbmRleCAxMjAw
NDQ1MmQ5OTkuLmFhMGIxZGExNDNlYiAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9yZXNvdXJjZS5j
DQo+PiArKysgYi9rZXJuZWwvcmVzb3VyY2UuYw0KPj4gQEAgLTIwMDAsNiArMjAwMCw4IEBAIGdl
dF9mcmVlX21lbV9yZWdpb24oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcmVzb3VyY2UgKmJh
c2UsDQo+PiAgIAkJZGV2cmVzX2ZyZWUoZHIpOw0KPj4gICAJfSBlbHNlIGlmIChkZXYpDQo+PiAg
IAkJZGV2bV9yZWxlYXNlX2FjdGlvbihkZXYsIHJlbW92ZV9mcmVlX21lbV9yZWdpb24sIHJlcyk7
DQo+PiArCWVsc2UNCj4+ICsJCWZyZWVfcmVzb3VyY2UocmVzKTsNCj4gDQo+IEl0IHNob3VsZCB1
c2Uge30gYXMgcGVyIGNvZGluZyBzdHlsZToNCg0KDQpUaGUgc2NyaXB0L2NoZWNrcGF0Y2gucGwg
aXMgaGFwcHkgd2l0aCBib3RoIG9mIHRoZXNlIDIgc3R5bGVzIGluIHByYWN0aWNlLg0KDQpUaGFu
a3MNClpoaWppYW4NCg0KPiANCj4gCX0gZWxzZSB7DQo+IAkJZnJlZV9yZXNvdXJjZShyZXMpOw0K
PiAJfQ0KPiANCj4gKHByb2JhYmx5IHNob3VsZCBhZGQgdGhhdCB0byB0aGUgcHJldmlvdXMgYnJh
bmNoIHRvbykuDQo=
