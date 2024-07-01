Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072F443D
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719797212; cv=fail; b=Oae7zuqAk85uoNcQaB/Fk+poAIIP24xTLVajwMXDsrHm9/xwVWFdndlYsrImnIp7VWQ1qq2IyhHiurGrYOcZSaiR1wjFOWLhQK/3sXc0CXcnQgDH58hHkCeZAqqla20YaZ22es72p2hG0NxppUJl6jXvulHLFFvTQYOqF7fqs3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719797212; c=relaxed/simple;
	bh=6a5wwkukWSBybj2UJQat1QWvshz3LiBo9Letk4nUIpA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X44s7HaWrwTtN51+5pFMBX9vBO7zg0jLK/X5VlHgZqmUtYiK1YuGkkDbUZ3dh6HUyD+xBF/0Ugyc9AHQ635iD2RbGpS6lUmFCfmUm1bxVVQX3ReYiYreHVfSe0DgJtoIkFrtlDVkYbMarLw//4fxmRsi8Uj9i+gEswKyYsq66qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=msy+JcLR; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="msy+JcLR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1719797209; x=1751333209;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=6a5wwkukWSBybj2UJQat1QWvshz3LiBo9Letk4nUIpA=;
  b=msy+JcLRwy86vENdZ368ZR3LDSxCZtjJuJ8kBtJSwewGwvVGlilwFoz6
   Q+WHXppdoebUb7XMM5wK/0+bKjD15uT3+Fv8AaRojCmwawoAy/8LMOLOO
   CVSwzsb96dnPwURqYhe0tg/kucKym4+P7gZqilsb9fthOTDYzvGvkO70M
   LefDcZ5N51rg2LopB2Kkbz9B/YB5vdhceQfmTbCeztuUywMARXrUVmdlr
   W3jmB4mN22S2dWyCskUKFP+pLZOjd6aKdEEaw8oCV1ql94ZBHVGTT48cU
   kjKLH2P+hLIvmcPG9d5I9dCmVpTlhxAK7JTjf8UAhvcmBWd41SqSIr/Bb
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="34952824"
X-IronPort-AV: E=Sophos;i="6.09,175,1716217200"; 
   d="scan'208";a="34952824"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:25:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Clgb6i99uChNbsG9K76tblC1Mp6CrtxYMZUPuSuRFMjtnOyt5SNNPyUUXy6H4fqyC9ZMKP/4/GmmGDWNimnfb68CKrIUmjf05FFTZYlcpQywMepKg0RYLTUgDggrck+HNHvGyUv2zK2E3ZTfpMBvTpN6Qhy/4sDdt4YsmOZ0drhJD+uoD37X7a2fUMDCoPEJr8Cku8ds64adJu0WcJqmvIJXHMa5TSlxilcIqoqL5WFpHI56u8XVxp4GOTtjnD/44SQTHa1yE/LIuwjwJSy8ICoNKdJD9T+h0Yjqg+WeAfvmjIcNCRi2TpI78LD80xUjCXof4V1FzPzoTpJ/ZaUkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a5wwkukWSBybj2UJQat1QWvshz3LiBo9Letk4nUIpA=;
 b=fYoogmTQLFHdJlSLXhZpQFA8ym0XJujM/4+M+p3u2o10vagBTG+iCWNHAAh/VuhW4ZVgl9HDbI7rby16MuvCO2RvebnpbWwSMhA5EUsD4yaB4OVeZW9YhDKZkYEx7pxk7c/Sv7R/yz7C7exBOMi72BjLeXQfTpkA7l59DHWbY5u2JHlITfi4Iw857LwZXayfFAuhIviWM+2z9eWC6DX0S5WK2FJcQemi16ey7RDVg1Ik/1Jp4OnMbHo4Dt1xaPxRsL91gtYbQlXhjOUhv+x/WlfqHos2oAJWm8eYFR74dsJHJGe6rxQDdLLdmyDU0kcvFp/JRgEyF2wR6fgUKdh6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB8061.jpnprd01.prod.outlook.com (2603:1096:400:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 01:25:32 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 01:25:31 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "david@redhat.com >> David Hildenbrand"
	<david@redhat.com>, Oscar Salvador <osalvador@suse.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [BUG ?] Offline Memory gets stuck in offline_pages()
Thread-Topic: [BUG ?] Offline Memory gets stuck in offline_pages()
Thread-Index: AQHay1WPxUzjMyg7CkuuR0PTwAGqKQ==
Date: Mon, 1 Jul 2024 01:25:30 +0000
Message-ID: <6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB8061:EE_
x-ms-office365-filtering-correlation-id: 14fe8e2c-e973-4d93-41c4-08dc996cb27b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?MHNYOStlaFpXck0rNEMzbUptRlk0TkVua1d6bnF2WHVmd21IOGN5aGcrZkVq?=
 =?utf-8?B?Z3NHcFFsS2RXclJwL09MYWtLNURnL0l4TVdXVG5hcjhEM1JMNzVnREtsOTZw?=
 =?utf-8?B?RGd5N2FuUWE4MHdpQVcwVlEzVUtnTllUTE5UeXRNREk4QlV6NWhkSXlZMUxP?=
 =?utf-8?B?eit2MmhsaWhSUDVyeWJPMmIxcVA4cUJXb3E1TVd1aDNRMy9sMU9ZTkV0SmhU?=
 =?utf-8?B?USs3bDVxaGROUEhJb1NmY3V4QlhIUy8wSit5L29FZ0JINWFFNGlhb3RVTUZN?=
 =?utf-8?B?T1owTm9HZVpZeUwwc3IrMUdzT25lV0ZhZDRObWlRRkdYVHU1UEtBZFV4TlBa?=
 =?utf-8?B?ZkdlOG10dVRpcU14alZCQVE3cUlONGFUbVZ2SlhwalNoVnUwVnpnM1djVmtt?=
 =?utf-8?B?SEYrL0VCa2JnaERRSGhic25YcTdWV0VSYVZtcjJud0ppbXFsYS9YZTVqWUNB?=
 =?utf-8?B?TXE4bWJMbVNzWCtHQWViTG5qSWxpNlppc0w3N0J5NlRYaVQ3WFN3R2xIU2l5?=
 =?utf-8?B?NFNtUWRpbWlHSUxRMVZBcnhZd0dQTEJGbWJzdmlTeGRNM2ZYVTltVlRaUGx6?=
 =?utf-8?B?aXdIRzBwVGg4RmVNc005UkFhV0d6UmVxUmdSVmxwRDV5elFHQTRITDM4Ty81?=
 =?utf-8?B?S1FsL3JxcHpOZEVmazk0SzlvS25pamlQdmtPVWFyUVV5c1FpZkVtcDYvbE9o?=
 =?utf-8?B?Z1VQQ2ZYUFRxZTBQejYva2Z2ZVFNQ3dhK3dKRnFJQ1dVTHJWZjEzKzMxMFJX?=
 =?utf-8?B?Y2J0Wjl6L29mN01VK0tGZzBLOVdkTHNMUDJLVnhoT3hwWkNqQmFmQ0h5QTN1?=
 =?utf-8?B?YlQwRFNqM1QxaTBmRzFLOUt1bG11Q3RPQUNYVmZwMFhKd3JrV25pdTNmcnZM?=
 =?utf-8?B?YnFGSHdKcVhXMHcweU14cWl2T1VuMGpUOFFmNXdYY2ZpUSs5Z0Jkc2hha3NK?=
 =?utf-8?B?SzZROXl0Sk1qWTVoVkFiMjY2R0tMRjc0WDI3NkVEd0R2bkVsZnBzWGI1Y21s?=
 =?utf-8?B?Zmc3QmV6MVl4WmhYQTg2bW0yK1R3c3ppdWU2QmJUaVQ3ZXBJSzhXSmNQaDZK?=
 =?utf-8?B?aGhUSWJ6OWJQZCsxTG1WZ2VnRXA3QmFjR2RaVXMyZ3RmQTQwWnc3dTBYQXhM?=
 =?utf-8?B?OXpMbk40YUFlbEFhbThuSndXZExobk8vcTRrcHAxSHp5MFFET2E0UjJVZXlX?=
 =?utf-8?B?Qm9Qa0ZDQWExZjZUeGRmbk56Zjg4TlRteG53aEN5Y05hRlk5MFcrSFdzZDBK?=
 =?utf-8?B?aTdpSTlFV2FHRU5mcXhrVVJOWCttRVRhRlZTbkI3M1h0ZnN2MlBqQXdTa0k0?=
 =?utf-8?B?L2NWSTYyWnpvZ2Z3dXJXaXJoeHRQL0YwSlV1U2I3SS8vQ0NQdDNUU0R0a3Ry?=
 =?utf-8?B?WU5ySnYxTWY1ZGRoV3I0eFlxTm1NTUp4QVpZSEF6TEI0SjJYTzQxdjR2UDdQ?=
 =?utf-8?B?a2VzY3hvUUZUMGIwcnAyZWVMTGcrbFd2dFFpTzNSOHhCMWNOK0d4bFEwSlNL?=
 =?utf-8?B?SWwrRFdRaUFIeU5ZWWNNS295cjZyaDkrU24zUUNnWHNlRkx2TTdVajF2QlBq?=
 =?utf-8?B?eTNXWGZqOEdjQzRDV2hveHhjQVV0dThnOU5RVzJnOWRLVkU0WGFIVGc3b0RN?=
 =?utf-8?B?OTlLNFhGOUhBK2xPZjMzUGRPUy9rdkNSZ1ZkTEMwZjVUbEF6TVlYMUMwWkhn?=
 =?utf-8?B?OXBHMW0rRzh3VVVuWUpFZXh0VDBoc2xtNFQ4UFR6cS9ZMWUvUURpOTB5Q0F3?=
 =?utf-8?B?aWMyWW9rVmc5N01BYi9oK1o2QVJhZXdyWlFmZHVHcW1HR0gyL1c2S2RXZTZI?=
 =?utf-8?B?THRJL2xnYy9jaHdEZmNWN0d0SXlVVUkzNTNMS08va1hlU1V2THE1cDBGNlYx?=
 =?utf-8?B?OURhekpGZ1ZMRGxQZ3UrQTd4WWtGeGI4bURsNWV6aXlmcGVmaWoxbnc5WUtZ?=
 =?utf-8?Q?S3S6BHzSXI0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGNHTXlkVzRGQ0hzS2FCbFVLUzE5ejdZNnBaR3Q3d2w5REp3RjdMZFNtYXpS?=
 =?utf-8?B?VDBWWjc2OG44MVBvckE4ak5wNll1UEdla1d6bXNyVjN0Q3lCMEE2TlFMRnN5?=
 =?utf-8?B?Q1FuSW1CNFRRRTJnc2xuOTZ1aGwxSTdjYmpyeDMzUkpEcnd5Q3gwcG5JMXhI?=
 =?utf-8?B?dC85L1pjKzZRWWh3V2ZZdi9rU2JINTRxQnhFK01rQVd2emt5cDl0QWwrS1lD?=
 =?utf-8?B?ZVdHRTZYbEpQNFE4cFl1d1hFd1prUlNsbC9oWUk3MlozaGJBb1pKcC8wUVg5?=
 =?utf-8?B?ZzNrNXVkS3lIVU9BdWptcnlmUXM1ZG9QamwwSjlvUHV3cTB3U0pOakRTV05S?=
 =?utf-8?B?WUljUnZxVUI3YTVkbEpMc1h1eUoyTmFGb3A3ZzdNaGNJeXpOK2x4VnFQRmZK?=
 =?utf-8?B?NU9Ka0dyd1E3OTR6Z004Z25nam9VRVI5TmViZ1MxRWdIVmVLZkJyU1hRTm1D?=
 =?utf-8?B?RlRML3lOM3M2aVN1M3VVNmpKYnk4SVRocm1BS3gwQmhpSEJ1V1pUdDhrT1Qz?=
 =?utf-8?B?bkRKL3dCZC9iR3hld2JxWE1WYnUwNFpPdU9RQ2dpMXN0T1BxV0xJYjYvYlJo?=
 =?utf-8?B?RFY3cVhFc3hwWWlPNTBUcXRjUlpMQ0FuMjRIdmlOOUVUQUVNMk9XREEyV0d3?=
 =?utf-8?B?bVY5SUNGV1FMci9UdCtPSXNMRTg2eGIyUHc1NFNGY2JCT3AxcVNTN0V0emJq?=
 =?utf-8?B?bXFmRHNmY3Fhclp3cTR3clVZZEpCemN4NmUxQVh1Mk9DUjlYTDg5cENQL2ox?=
 =?utf-8?B?MlFDM3FicWFvc0czRjFlSnRZNEFuekdTQjVhMFZEajBIMGt4RHNHcnc2M3Ro?=
 =?utf-8?B?cU1kK1gxOW50QWhYb0ZTcnNqbjhVRm9BZW55dE9La0tVdXlZcXhwZUl2T2Y1?=
 =?utf-8?B?UG85RVhrdlpBbG1STE9lRjAwOTVORWswSXVFTldYd1dYcVRJTHNkM3pLSXdK?=
 =?utf-8?B?bG50YlBQUnQxWUpGWnFuMW5IYk1MZFNtU0prM2lON2ZDc0FudlZmYzlTckZs?=
 =?utf-8?B?QURvcWFDYlE4cUlhT2VlOGZUcXdYSTBPQWVUY3BkRGpWWEwxZDY1SUlrOCt2?=
 =?utf-8?B?QWkwYUJxZHBHQjB0eGlZL3puMWNJMmYyZ1lsUXVlREgyWVhyc3hVZGZLMGN1?=
 =?utf-8?B?d1FhYXFBSXdaUThtbmlsVHdTb0YyYVlCa24rMUFNaXlJbGt1Z21OUUgrVDY4?=
 =?utf-8?B?ZlA5VTZXWjVyTVRyaHRGOWJkaUpldExnSi9MN2tpME1YWkQrTzhLeTJlb2Qz?=
 =?utf-8?B?VC9sb01YS2RMM3A2cUs4clV4aWtVSU84UWRsbkRBb2RuWUFXU0lSN00vc0h0?=
 =?utf-8?B?ZDdZOEVWT2dhUHFtS1QyVUpLM3FhRVZQK3dTdk5OdlcvRlVLeVVLcFJ5Y29z?=
 =?utf-8?B?NERZd2Y1NmpEZlRQUk9vRmlCcE1yU1FSK0RSdnJGWHZtL0cxSVhkVmJ1NUV4?=
 =?utf-8?B?OFdGakdubkhGWFBVN2xGcjNYWnV3ZFl3cHBNU0s0ZVIzdVNKU1gya2psejR2?=
 =?utf-8?B?OTNGR0ZkeUxsSE1sQUNQUExDVjdpNnpMR2JzYzl4YjhCL09idEFWODNSTXFP?=
 =?utf-8?B?enp6RzkrOG9QV0FLdVFhS3ZSWlFvelNHbzIwR29vby80WEt3QUcwb1BrTGo2?=
 =?utf-8?B?Z2hZSk9HQ1dlWFJpc3lqdXhhTGY3L2NqNVJuUThVWHhtekV5UUJJTG5TajBs?=
 =?utf-8?B?MDEzQXdDNHovNEI5dG1CeW5WckdvVExpRHFZbmVyRXh1dE9iMEVjOGFrdFQ0?=
 =?utf-8?B?WWRqbDFHRy9BN3JGbjdJQ0owaEhDNlNTU1ZhTFFvd29nc0lyWE5NdEgxbW9X?=
 =?utf-8?B?TzRHMnF0MGFVMW53NHpHMmxFY0Q3dXJQVXc2U28xTjBQKzA2VGZERm5EbkRZ?=
 =?utf-8?B?UE1TMzNWd1UwV1VwV2pmdE9MY2tkR2pXRlZIUlRHWVVXN3hOT3BlN2hic0w5?=
 =?utf-8?B?cXN0N0ZKRWVMdE9jblZqbDlJc1FCWFpZNmRzMmZSbUk0K2VkT3FBbXdJN1Vi?=
 =?utf-8?B?eVM5RzlyL3kyWGliT3k1MGRHa1hOZ1lwTi9HZXFWU2o4SHFCNXQ4QjA4WEho?=
 =?utf-8?B?Z2VFZ0NNa3NpVFJsSm95aTJZWG1kZmdKSWxYbmJLaHN0SzNLUERnaHJ4ZktZ?=
 =?utf-8?B?NnpNaWdCcGJpbG56VFo4OXpRRE82VlVwU0xBdW00MEhBUlBlV0E4MTJxR0RR?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74363A9E561E96408F34E8EB63602FF5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rgqeM0Rs4lRzgBaaB8I64CIrv17u9jyIgZW8iWHIznOBqOF+wV2ZbA+/7iOrUettgVmscTJUp4d88rr27yNxdhQdt/FZNvIRknd38JXB11qj0D2S9KRzWDocn83QzD5TUNlgtA8Gb+kHlwqhFj4b2NubFMHehuQD+bpIp5SFn9pLX7qAZM6k6KSGuPNIBvNIAESlVQvRrgyyFBr4vwzG7Z7L7KnT7O+KBonr0S+02pIFl7DzKZhUaw2T++Prz9ZiahmnRgFahG7YX2kgz0v9kuqk88q5kEgYdepABPpWTyKz5hBOaYCBTbQtykzPmuapaDN6zDwV0FP5LyrA/531PU8jTAdi2fFH2m7JGYAEWFi8Qgi59ZcFWwj7arbKoxuks6gDRYrtQh8swRPMCgjWcT5cKScX6ch+Gcgxe/6bhYl9YOEGU3cQhy1gj3RAxErCmVUKfvufvvGSv05G/Dj/zEU0/kErKJo52BSHENwpykwyMO5hcGTtCvvK+r842L6bd+MoA28aX/zXi7FvGoZAYaNbZD32ir2rpYbKajfbfouN6J7FwhUpZTzyTpk/BppT5mSiRVTpY0tKQdPSIzuDdobJrrg/g20R4xneeuUAr5bLw+E62SjN7ilMGYCh1UBW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fe8e2c-e973-4d93-41c4-08dc996cb27b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 01:25:30.9083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaLcQvClC9xarIR2I+UZ6RBL1/9spnOQHH0r78pBKGZaFqS8cSTPfISDMBLmoFOoex0vTQdQf2aDzK0kDTjN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8061

SGkgYWxsDQoNCg0KT3ZlcnZpZXc6DQpEdXJpbmcgdGVzdGluZyB0aGUgQ1hMIG1lbW9yeSBob3Ry
ZW1vdmUsIHdlIG5vdGljZWQgdGhhdCBgZGF4Y3RsIG9mZmxpbmUtbWVtb3J5IGRheDAuMGANCndv
dWxkIGdldCBzdHVjayBmb3JldmVyIHNvbWV0aW1lcy4gZGF4Y3RsIG9mZmxpbmUtbWVtb3J5IGRh
eDAuMCB3aWxsIHdyaXRlICJvZmZsaW5lIiB0bw0KL3N5cy9kZXZpY2VzL3N5c3RlbS9tZW1vcnkv
bWVtb3J5Tk5OL3N0YXRlLg0KDQpXb3JrYXJvdW5kOg0KV2hlbiBpdCBoYXBwZW5zLCB3ZSBjYW4g
dHlwZSBDdHJsLUMgdG8gYWJvcnQgaXQgYW5kIHRoZW4gcmV0cnkgYWdhaW4uDQpUaGVuIHRoZSBD
WEwgbWVtb3J5IGlzIGFibGUgdG8gb2ZmbGluZSBzdWNjZXNzZnVsbHkuDQoNCldoZXJlIHRoZSBr
ZXJuZWwgZ2V0cyBzdHVjazoNCkFmdGVyIGRpZ2dpbmcgaW50byB0aGUga2VybmVsLCB3ZSBmb3Vu
ZCB0aGF0IHdoZW4gdGhlIGlzc3VlIG9jY3VycywgdGhlIGtlcm5lbA0KaXMgc3R1Y2sgaW4gdGhl
IG91dGVyIGxvb3Agb2Ygb2ZmbGluZV9wYWdlcygpLiBCZWxvdyBpcyBhIHBpZWNlIG9mIHRoZQ0K
aGlnaGxpZ2h0ZWQgb2ZmbGluZV9wYWdlcygpOg0KDQpgYGANCmludCBfX3JlZiBvZmZsaW5lX3Bh
Z2VzKCkNCnsNCiAgIGRvIHsgLy8gb3V0ZXIgbG9vcA0KICAgICBwZm4gPSBzdGFydF9wZm47DQog
ICAgIGRvIHsNCiAgICAgICByZXQgPSBzY2FuX21vdmFibGVfcGFnZXMocGZuLCBlbmRfcGZuLCAm
cGZuKTsgIC8vIEl0IHJldHVybnMgLUVOT0VOVA0KICAgICAgIGlmICghcmV0KQ0KICAgICAgICAg
IGRvX21pZ3JhdGVfcmFuZ2UocGZuLCBlbmRfcGZuKTsgICAgICAgICAgICAgLy8gTm90IHJlYWNo
IGhlcmUNCiAgICAgfSB3aGlsZSAoIXJldCk7DQogICAgIHJldCA9IHRlc3RfcGFnZXNfaXNvbGF0
ZWQoc3RhcnRfcGZuLCBlbmRfcGZuLCBNRU1PUllfT0ZGTElORSk7DQogICAgIH0gd2hpbGUgKHJl
dCk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyByZXQgaXMgLUVCVVNZDQp9
DQpgYGANCg0KSW4gdGhpcyBjYXNlLCB3ZSBkdW1wZWQgdGhlIGZpcnN0IHBhZ2UgdGhhdCBjYW5u
b3QgYmUgaXNvbGF0ZWQgKHNlZSBkdW1wX3BhZ2UgYmVsb3cpLCBpdCdzDQpjb250ZW50IGRvZXMg
bm90IGNoYW5nZSBpbiBlYWNoIGl0ZXJhdGlvbi46DQpgYGANCkp1biAyOCAxNToyOToyNiBsaW51
eCBrZXJuZWw6IHBhZ2U6IHJlZmNvdW50OjAgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAw
MDAwMDAgaW5kZXg6MHgwIHBmbjoweDc5ODBkZA0KSnVuIDI4IDE1OjI5OjI2IGxpbnV4IGtlcm5l
bDogZmxhZ3M6IDB4OWZmZmZmYzAwMDAwMDAobm9kZT0yfHpvbmU9M3xsYXN0Y3B1cGlkPTB4MWZm
ZmZmKQ0KSnVuIDI4IDE1OjI5OjI2IGxpbnV4IGtlcm5lbDogcmF3OiAwMDlmZmZmZmMwMDAwMDAw
IGZmZmZkZmJkOWU2MDM3ODggZmZmZmQ0ZjBmZmQ5N2VmMCAwMDAwMDAwMDAwMDAwMDAwDQpKdW4g
MjggMTU6Mjk6MjYgbGludXgga2VybmVsOiByYXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAw
MDAwMDAwMCAwMDAwMDAwMGZmZmZmZmZmIDAwMDAwMDAwMDAwMDAwMDANCkp1biAyOCAxNToyOToy
NiBsaW51eCBrZXJuZWw6IHBhZ2UgZHVtcGVkIGJlY2F1c2U6IHRyb3VibGUgcGFnZS4uLg0KYGBg
DQoNCkV2ZXJ5IHRpbWUgdGhlIGlzc3VlIG9jY3VycywgdGhlIGNvbnRlbnQgb2YgdGhlIHBhZ2Ug
c3RydWN0dXJlIGlzIHNpbWlsYXIuDQoNClF1ZXN0aW9uczoNClExLiBJcyB0aGlzIGJlaGF2aW9y
IGV4cGVjdGVkPyBBdCBsZWFzdCBmb3IgYW4gT1MgYWRtaW5pc3RyYXRvciwgaXQgc2hvdWxkIHJl
dHVybg0KICAgICBwcm9tcHRseSAoc3VjY2VzcyBvciBmYWlsdXJlKSBpbnN0ZWFkIG9mIGhhbmdp
bmcgaW5kZWZpbml0ZWx5Lg0KUTIuIFJlZ2FyZGluZyB0aGUgb2ZmbGluZV9wYWdlcygpIGZ1bmN0
aW9uLCBlbmNvdW50ZXJpbmcgc3VjaCBhIHBhZ2UgaW5kZWVkIGNhdXNlcw0KICAgICBhbiBlbmRs
ZXNzIGxvb3AuIFNob3VsZG4ndCBhbm90aGVyIHBhcnQgb2YgdGhlIGtlcm5lbCB0aW1lbHkgY2hh
bmdlZCB0aGUgc3RhdGUNCiAgICAgb2YgdGhpcyBwYWdlPw0KDQogICAgIFdoZW4gSSB1c2UgdGhl
IHdvcmthcm91bmQgbWVudGlvbmVkIGFib3ZlIChDdHJsLUMgYW5kIHRyeSBvZmZsaW5lIGFnYWlu
KSwgSSBmaW5kDQogICAgIHRoYXQgdGhlIHBhZ2Ugc3RhdGUgY2hhbmdlcyAoc2VlIGR1bXBfcGFn
ZSBiZWxvdyk6DQpgYGANCkp1biAyOCAxNTozMzoxMiBsaW51eCBrZXJuZWw6IHBhZ2U6IHJlZmNv
dW50OjAgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAgaW5kZXg6MHgwIHBmbjow
eDc5ODBkZA0KSnVuIDI4IDE1OjMzOjEyIGxpbnV4IGtlcm5lbDogZmxhZ3M6IDB4OWZmZmZmYzAw
MDAwMDAobm9kZT0yfHpvbmU9M3xsYXN0Y3B1cGlkPTB4MWZmZmZmKQ0KSnVuIDI4IDE1OjMzOjEy
IGxpbnV4IGtlcm5lbDogcmF3OiAwMDlmZmZmZmMwMDAwMDAwIGRlYWQwMDAwMDAwMDAxMDAgZGVh
ZDAwMDAwMDAwMDEyMiAwMDAwMDAwMDAwMDAwMDAwDQpKdW4gMjggMTU6MzM6MTIgbGludXgga2Vy
bmVsOiByYXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMGZmZmZm
ZmZmIDAwMDAwMDAwMDAwMDAwMDANCkp1biAyOCAxNTozMzoxMiBsaW51eCBrZXJuZWw6IHBhZ2Ug
ZHVtcGVkIGJlY2F1c2U6IHByZXZpb3VzIHRyb3VibGUgcGFnZQ0KYGBgDQoNCldoYXQgb3VyIHRl
c3QgZG9lczoNCldlIGhhdmUgYSBDWEwgbWVtb3J5IGRldmljZSwgd2hpY2ggaXMgY29uZmlndXJl
ZCBhcyBrbWVtIGFuZCBvbmxpbmUgaW50byB0aGUgTU9WQUJMRQ0Kem9uZSBhcyBOVU1BIG5vZGUy
LiBXZSBydW4gdHdvIHByb2Nlc3NlcywgY29uc3VtZS1tZW1vcnkgYW5kIG9mZmxpbmUtbWVtb3J5
LCBpbiBwYXJhbGxlbCwNCnNlZSB0aGUgcHNldWRvIGNvZGUgYmVsb3c6DQoNCmBgYA0KbWFpbigp
DQp7DQogICAgIGlmIChmb3JrKCkgPT0gMCkNCiAgICAgICAgIG51bWFjdGwgLW0gMiAuL2NvbnN1
bWUtbWVtb3J5DQogICAgIGVsc2Ugew0KICAgICAgICAgZGF4Y3RsIG9mZmxpbmUtbWVtb3J5IGRh
eDAuMA0KICAgICAgICAgd2FpdCgpDQogICAgIH0NCn0NCmBgYA0KDQpBdHRhY2hlZCBpcyB0aGUg
cHJvY2VzcyBpbmZvcm1hdGlvbiAod2hlbiBpdCBnZXRzIHN0dWNrKToNCmBgYA0Kcm9vdCAyNTcx
NiAwLjAgMC4wIDI0NjAgMTQwOCBwdHMvMCBTKyAxNToyOCAwOjAwIC4vbWFpbg0Kcm9vdCAyNTcx
OSAwLjAgMC4wIDAgMCBwdHMvMCBaKyAxNToyOCAwOjAwIFtjb25zdW1lLW1lbW9yeV0gPGRlZnVu
Y3Q+DQpyb290IDI1NzIwIDk4LjYgMC4wIDk0NzYgMzc0MCBwdHMvMCBSKyAxNToyOCAwOjI2IGRh
eGN0bCBvZmZsaW5lLW1lbW9yeSAvZGV2L2RheDAuMA0KYGBgDQoNCkZlZWwgZnJlZSB0byBsZXQg
bWUga25vdyBpZiB5b3UgbmVlZCBtb3JlIGRldGFpbHMuDQpUaGFuayB5b3UgZm9yIHlvdXIgYXR0
ZW50aW9uIHRvIHRoaXMgaXNzdWUuIExvb2tpbmcgZm9yd2FyZCB0byB5b3VyIGluc2lnaHRzLg0K
DQpUaGFua3MNClpoaWppYW4=
