Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3099143871
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jul 2024 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079052; cv=fail; b=sNqtP+XEwM/6Epk7sMCMfvQwSx4WybeeG7mDuG93BCXixJVYJKCIcgG0AykGUnPpivsdwrGMP7dKgE99J9XE7soNOMYOze8kYG3OS45p+rWRl/DQsiDtVvP9gohRtCarOTbLouX2iUVgWxbZO2PwAet08sRHtqIQAIwj1ERK3V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079052; c=relaxed/simple;
	bh=e7y/qfVcl8JQMrvgorCDFPu3VehephdXJCjFnV9yKT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dIMxRPKGKGTLtkl1wuF5S73SMioguMerkkUUpXO/0S1GCpJIE4471WCwODZtX55oAP53GEwGI2P4UMDuQq9SysQTfV55ijZLiN+9YFtpIXma+FBy5cjJ4+dEz/sTm9sZdyil9VXUXzLW50eBSmho18YOBiFN9qcBxEhDUrJ/CX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=uY9Y6zzQ; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="uY9Y6zzQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720079049; x=1751615049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e7y/qfVcl8JQMrvgorCDFPu3VehephdXJCjFnV9yKT4=;
  b=uY9Y6zzQZisO/t6Dnzr7M9UaoVRX0BtDZYuwMJqSi3IVVZBNAMeBnFqa
   9R39Y2N2MsWDHByGMYo0weWBY6RGXyGXIIRYZLLSY6wn4ejW0yz8FmBvF
   vzi5GKb4J4pHy+xq0BJ8S53mL9XBlAPWsGonoCvYYHt1oEEO6JE3SuN7B
   kQ45k7EIG2lTv1ss6rZnkT6naKsezqIxnHqic6M/HwcY+vkXo968MRy/k
   f6r8OygDykNR27MXbkS+SUBvcsHxED2qA609TMOMgCd9IOy7Wa/qB10+n
   zyvygVdaMKM4a7M3nkBwrT7QZ36molZtRt/v9jv5WLIdLfE44whkjDcVy
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="124234400"
X-IronPort-AV: E=Sophos;i="6.09,183,1716217200"; 
   d="scan'208";a="124234400"
Received: from mail-japaneastazlp17011024.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.24])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 16:44:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g49Iz19Hr2HhslsjN40ZXKCacne20YE1kJ6NYptbEdfFXgRuomnooP/2X32r2mNZ5uoHnN7mGV6ZEZB4CDElEaFVDQK8tB2qX3UNjszuaWSi2TdNqVicn/PFWg9PkqfdjUgjCTgA5FaNj7h6QX/dDp6cPVCFrK5r1lNM1TKGCRN1HpqmJnAyZzycgtFcVS78GKy9jnbdludpjlaYqSD/iyNbilFnl/v4OcP5cetrCp9GFNXNXyNqun+5t6v68ykFs9fY7hmu9ss0bplE9Ws1MnsxOWBfPNpW6ea3dsM7V7InVG++R/itcey0cX1T/hJMhnAWVz8S6jyXUXy5MMYO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7y/qfVcl8JQMrvgorCDFPu3VehephdXJCjFnV9yKT4=;
 b=GZE43t9iwmFB62hExWB1+YuZB8MOA6RrZ7JCewdqNyxrjb6OfNOxpokipTjfz40CMPYTJqmtgVU5Cvsi1oxgx3DO+TKHiy1Xb+UG/Ck5/eRjWDV0nWcruebz0clUiYBAlFX7MYr7ARBK/QyVQJI3b/5pcJkiH3hPw1oLzFys8mEeJvqt+6Prly2HinpIgxmViDFYHCuuddXNW51FeRCYrAN6Okbxn/njP0iZ6TNlQLj1Di9akHfpctXlBGTemDxihQzMT+JcwGZZzLPqwnZocYCJP1g96svgsAt3QVLp0UfI9Oh7F0WKh1GqzlKaagQSiEX0bpm6C4U3VVUG0qHiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB6494.jpnprd01.prod.outlook.com (2603:1096:400:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Thu, 4 Jul
 2024 07:43:56 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 07:43:55 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "david@redhat.com >> David Hildenbrand"
	<david@redhat.com>, Oscar Salvador <osalvador@suse.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Xingtao Yao
 (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Subject: Re: [BUG ?] Offline Memory gets stuck in offline_pages()
Thread-Topic: [BUG ?] Offline Memory gets stuck in offline_pages()
Thread-Index: AQHay1WPxUzjMyg7CkuuR0PTwAGqKbHmNSqA
Date: Thu, 4 Jul 2024 07:43:55 +0000
Message-ID: <5a4ef056-73c7-42e9-a839-43d42f8b7eab@fujitsu.com>
References: <6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com>
In-Reply-To: <6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB6494:EE_
x-ms-office365-filtering-correlation-id: fd4aaef3-7f17-4ce9-eab7-08dc9bfd0ea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?K3pnY2o3RFhlSE9DZ2pIZlJUdmZvSDd6Nk1LUWVnL1JHNSs2N2E0eUhsM3Z6?=
 =?utf-8?B?MGMzd2FoSU1YdGVuZG9BblRNWWR2c3hFdGlMV2lsekpvcFcvRS94dVhQMWx6?=
 =?utf-8?B?Um9OaWxsU3orSEpyY1RLbjNFbjZSUlJYRkszekg4cTlxYzhaQnBubWNxUDRs?=
 =?utf-8?B?bXFkT3lHdGVMMCtRVEM0ZkV1NHNrUmZCTU9vRUp3OG9CZW54SFMyVDZwUHgr?=
 =?utf-8?B?akw3Z0tDT0FGMHpHeFA4K1ZueC9xU20ycWNoUnlWM2dqUWJXRnNiNXpPQnlS?=
 =?utf-8?B?TXYwdDFkOFFqbnBIdzFydTVPejU4aEhUUENxNExWS0ROVmdDajB1dVQxeXA1?=
 =?utf-8?B?Mkx0VktVYkZGZkhKMFUydTRiTmNreXRxUGRmSGFuN3NaWlUrN3FlYlI0eE5D?=
 =?utf-8?B?cFZ4SHozMVVZNTRWeU9hbDRlV0x5VjlDdDJ5YlBxZ09MYlNkS29mbVYvYWZ1?=
 =?utf-8?B?RVIxL3hDQ1VUODdzWlU0NUd3b0NJU1BoVDhKWGJyTGY5L1puRlo5N3ZIb05F?=
 =?utf-8?B?ZS9SWWNhSytkK2FlQ2xYbG8wSTBFc3Y5R1Q2b3Z6SVVjWFhjM3N1R3ZPSEs5?=
 =?utf-8?B?UUFoUU91YzYzTFJCVUR0clVubjFiQm11WFkyU0hwdHAyeSswNEZGQWpjNEdI?=
 =?utf-8?B?bFhDTlpTQ3VjeWlCNEludldHZmJ6cm9xcWdoays5bDkwY1JiYzBqZVR2RnR1?=
 =?utf-8?B?bURzMzRRaXhKTFVqeGErOE9ZMUdCRTZGeWVUckRyTlcyLzhJUDAyVVp0ajBt?=
 =?utf-8?B?eEtIckh3VFh4T0NJK3NYQ1VnVmc2SFVQSksyNWRCNlRGMHQvM05heUFJSkk1?=
 =?utf-8?B?aUExdkNtY1diUlR2VDlOeEhnbGtOWGhKaXBuYlJvT3ZmMWZqTk9wdGk2QkRW?=
 =?utf-8?B?NHd2UlBsOEU1RWxkUVdiemdodi9kS2c3NmVpYWdhTFdVQ1hSNHVFZzh4akQr?=
 =?utf-8?B?enRpQnRvYVc0cHh4VDNhUUFaaDIzRVdVczBYZUtLb084Q3N3eGY3THpBY0tM?=
 =?utf-8?B?R0tPVFNxWGgzdzNJbGFhSi9URUhWSFFzL0ZzQnFzTG5aVEZ1Z21XQ2p6VzB2?=
 =?utf-8?B?QTluMFI3cjdtSnk5dDFSajl2NUk2cjcxSFI2RHZCMk5mT2pyRzRVUFhLZEJr?=
 =?utf-8?B?cms3bm1PSW8xVUQ4NTk3Q3BrNWl3YjVHSHI3NGJudHZaM2U3RXY0T0o3UEU3?=
 =?utf-8?B?RjBZKzV6Y3MvUjdUUVY1dGRycXlRNSttRjFYZWdvZ2t1cGpMMjljb0tkbmlL?=
 =?utf-8?B?NU9TdTlOaUpML1Z2ZzNOQWNFQk9WWFRrdGNDV0w4YkJsT3cxZGFCVUVhdHM1?=
 =?utf-8?B?WGtUbm9wZjF1QzNhTWZEaWUxRDVZTVVxU2pXQW42S2FkSHNEd001UFhmTEZL?=
 =?utf-8?B?cFBOYzdDdVpOQUdZcmgzNTdPUGxqaHdmbGtGZnJ0SStXZ3NIOVFXSmR4OC9j?=
 =?utf-8?B?Sm9IU2hvWDg2UVhRTWdTdk5BMTZacUNlYTg4eXovaXJDRmt5SCtVNGNTQ3A2?=
 =?utf-8?B?cllvYm51bFo5TlYwTWZEU2Z4OTRKSnZhenhKSThXYWhrdG9IUWlSV3FrUXJW?=
 =?utf-8?B?OVUxbnNjUlN0OWt4emRWREgvU2dpb1hXVjU4MFlZNFlZTXNEc0czM2RZRDlN?=
 =?utf-8?B?UXJ3YWNwamUycC9ueUpoQVhLcEExZnV1cTNxdXZPU05aWDlTT0ptbHF2Ykl3?=
 =?utf-8?B?a25EZGVkS3VyQ0xqNU5sRTI4aSt0UTgvbjRmWUxnOWNqZGpKemM3Q2xjU1h0?=
 =?utf-8?B?K2pWK1pkVGd6enhTNTY4MG1aVG52UFhQZTVDcDF5TkZWb3Z4MTJqeWw4K2l5?=
 =?utf-8?B?dEoxbVVyZjFZTFVKRFJwdTh5ODhlWFBtd3hheEx1M2o5YVZydXhxU3JQWHZw?=
 =?utf-8?B?SkhoaXBFakpBQmhMY0FpZVpRZnEyWnB4WHFoRCt0VWIrYnhNNVdTa0pqY3d6?=
 =?utf-8?Q?sGEdR/ISK3s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmR3dFlrdk90VDkxeXNEUWtQeXh6dlV4WWJvbFZCcVBkeVUxcGFtbVRVbHpv?=
 =?utf-8?B?TTUraEI3dTVteFlteXoxOVhwckxMcU8rM0pKNFE1SU9YUXY3ZVhwUmJrUHpJ?=
 =?utf-8?B?TlJUVThKWEVHckJZOXRVWnBpTjJkNDFZYzZtVnRSYUZ3WUcwYkNtUCtFOGRI?=
 =?utf-8?B?NG5FaVV0WEJTNjFWU0YvN1E0UFpqcm9xNDhRbjc4ZFNxK0I0Y1U3R2Z5dVIy?=
 =?utf-8?B?VUxMQzNieEVPS0F6SGpycDNhOVp6WllHbVp6enluYm94QzBWd3JoRWIvMWtX?=
 =?utf-8?B?QWdZZ05WMkc3ODRiWFRFNXBnQmJRdUZBRTJsbThxYWNtRFhNeDlBeS83RU1v?=
 =?utf-8?B?ZmtTSmZNUXNxY212cTEzUThLVFM4cFBQanhhQjNnR1RUcG5pL2gxUjZGc0Jx?=
 =?utf-8?B?amo2ZE5RMjd1WnRWOXR0UVFhbUhPTGl2TWVKQjZPdVkyT013a3NhWnkxV0dN?=
 =?utf-8?B?Tm5BS0QrMlpZejNUaTY3ek1YdlJ5Z2Q1dmt0NDNEbmpKaE9rY2lyY0IvM3do?=
 =?utf-8?B?dlp5Z0hjWWxuNXQrR0N4UnNXY0pUdi8zSCtKZTVTeVFlVGJaL0JSRnRKcWZh?=
 =?utf-8?B?Rnk3cGlrU1dQVzVCdnRJQUdlWkx4ZHRQKzB2ckRNclh2cEk0aEpFMUdNS3Mz?=
 =?utf-8?B?NDE1Vk9GTThTWVM3eVFhQ1JLZThhQmw2ZXlxNlVXZ0ltSmVoTVI4L29PaUd4?=
 =?utf-8?B?bTBnOFl6WEkzZTJNVnpVTEoyRGZ5elMzN1Q3R0hWUlIyRHBvdkNLQVAxVkEz?=
 =?utf-8?B?UmRReXJnMUw0MWFwU2J0U2dLc2VBSUcrT2pkMjFzMWlKTExYd015U1lFOFNB?=
 =?utf-8?B?QXp4bE9VMHhSY09KYnFXTXdsZUt3YWFpZktaK0VZc0xYckd2aW9TQlpXOFlX?=
 =?utf-8?B?ZXRjT2lwUlRMc2N0dXFyRVpkcFFJSWgvblN1TERtR1loTHRjeFRNYjVVODBY?=
 =?utf-8?B?V1ZwWG5vcytBRHdackVabU9VVExFblRYeTMvd3ZySktWUEY5T0NMbFEwZXpB?=
 =?utf-8?B?Vjdmb21SdE55ZUJsOEVVRlNMcktrL3BnOHB3ZkdrQzB0bmp0eHROeHNLeUcr?=
 =?utf-8?B?NFJxN1NjLzVZVk5rL0tVcytCU3ptbDZtT3loRnROMHJOQnFTbDRmNUdndlhU?=
 =?utf-8?B?dFdsQ0t4YUhrTjBPZi9VOTBFN2NBQzZ6RlNsTUozREVzbmJsK1MzS241dUtL?=
 =?utf-8?B?ZGtTWlBVd0JiTUQ2OXRHYWcwTnBmQXcxcUsrVXpQSFVjTldVRWhVZER1Skwx?=
 =?utf-8?B?Tk0rUzVJT3ExTERseHE0TkUvK25wU0NEdmx4ZnN4RjB2bisvRlZrQXc2eUkv?=
 =?utf-8?B?ZUovQ3gxVnQ1RGtVdUVDb2M3RUgzVlJVL3l3RW5oYXhWUC9tOTBRb2FVRk9m?=
 =?utf-8?B?R3NqY1l2NVhCUit1TlhZcUNwRVFNcTJycEcrUjUvMGcyMnlCdzRYYnZoQUdJ?=
 =?utf-8?B?dWFJWEVxcG9kTGgwaXpQRmhGRjVvMUxkQVRQUnN4bm1MdVpING9ZRmt0ZWk4?=
 =?utf-8?B?MFBmWWVpdjZGTUJQdnM2TElFSzNlWUcwdmZiWXhhR3JTQjFxY1NsZDVnZDBo?=
 =?utf-8?B?TVFSK3A5dWNxblNTelFhWGlBdzFtRzkzbVdBeWVUbVFpb2JnWFNBZ1lvUEpa?=
 =?utf-8?B?NHVrUlVUMXA1RXFjeXQrT0UzZnFrR3RwVHlUeloycVhBcU9tSC9rOWdHMHFT?=
 =?utf-8?B?YUd4WWlvOTlrTFlsdDNBNEVuS0xmRHl4aTNSTEk0WUt1RkdQSk5MNFBnL0RH?=
 =?utf-8?B?a2pGVGV0N3oxYldDMml5d3FmOEE0RUdLQWQxNkV0eGxJdnRhSVEyaHpST3F2?=
 =?utf-8?B?cVJkMEtlRGNaUm9YZTRsU1hzeEFYZmFKY0l4bFd1VW93UmhQRU90a0J2czRI?=
 =?utf-8?B?ZStjMDA0STNHRTlYeWVzU3B3YUN1cjNWRVJVUCtyd1Z5U1A3RDFsd3hPd1Er?=
 =?utf-8?B?ejZIdjUycTZDWVA3TkhlWFRxWDl6aW9GRUhhYXBuK3gyVE14OFgvbzcxUEd4?=
 =?utf-8?B?dFRUUUVmdWd3STk4SUZsUmpEY3pZY0hSRlFsUlZSdUFubVlaY3UzeWRlbWJR?=
 =?utf-8?B?aTd1T2hJb0RPajhhZ0RCVDFkZjdvSnc0UXpTRjdTNEN4a1htb1NxbVBBZmtG?=
 =?utf-8?B?Zjk3VHNlV01pQ1JKZHc3dGRyZVdDamRUTkhtcjVFNkYyNzNJOFNwajlzMEF0?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41C443E9EC722B429BB40608C95C1AAD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aHRq7gCkaHqhQOPtKO96QbpNECjH8jJqgb280C+MRWiS4Zxv8MP0GEHC3vo9Ra6KvZMmOimNfavQsa8tG8bPBltqqN6xKM2gN7gA5j4v73UeBJKLeve8WL1oI8XuPOItRRwiQHZtKcPtDBJWTAVGLdjPnPlfg9jvTksrXXExBsvBEgus+0khsQ4RrYrnZ/Zj9EG3tsXTr8HMYK0SkolyqpVrG2hAcGu0tYtv4TFqJuuBX3bX3QY97rq4QCEjVK7q6CXAP/4X7TQwg2vXihsWoLNIENFCzuhnnyLkY7pO5pEGvwHsbpuzYSup7Q38B/+DjYbLnQyxxtRr6OTZ20HoxAyf8XSYwXqQdTfuKtJc4t3eCaJdAaJ+wjYywnpKXF3PcLUP0RyhSD1j5hFmDWEydzcBlWXR75cP+BX193+baQh4JyPBA4Z8A50N+SuKiZN8p1Iu42NA8+g9VeqG+YgWfl4VndBw3kMhhyZpm3qhamdANE0xNqkjOiOeeiqfZAdvOILeKCAVV2w6pyp16nloKH0I4raX6a6IldPAS2FM748v9blfBWA8P58WC0BiZdrTAUD//9rlj47esTDc7E1WTgVKYZwXJMMy8jipHtILKnuZuVlZRqsN9CCngR80V2oZ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4aaef3-7f17-4ce9-eab7-08dc9bfd0ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 07:43:55.4524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oxd2oez1msKDJhTbusMYgI5pviRnePx7XcLlrNdhWIHEkmQAk7lqKr4sGE4q16TnSAl/0hu/OTOUqBeZ3Uyg5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6494

QWxsLA0KDQpTb21lIHByb2dyZXNzIHVwZGF0ZXMNCg0KV2hlbiBpc3N1ZSBvY2N1cnMsIGNhbGxp
bmcgX19kcmFpbl9hbGxfcGFnZXMoKSBjYW4gbWFrZSBvZmZsaW5lX3BhZ2VzKCkgZXNjYXBlIGZy
b20gdGhlIGxvb3AuDQoNCj4gDQo+IEp1biAyOCAxNToyOToyNiBsaW51eCBrZXJuZWw6IHBhZ2U6
IHJlZmNvdW50OjAgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAgaW5kZXg6MHgw
IHBmbjoweDc5ODBkZA0KPiBKdW4gMjggMTU6Mjk6MjYgbGludXgga2VybmVsOiBmbGFnczogMHg5
ZmZmZmZjMDAwMDAwMChub2RlPTJ8em9uZT0zfGxhc3RjcHVwaWQ9MHgxZmZmZmYpDQo+IEp1biAy
OCAxNToyOToyNiBsaW51eCBrZXJuZWw6IHJhdzogMDA5ZmZmZmZjMDAwMDAwMCBmZmZmZGZiZDll
NjAzNzg4IGZmZmZkNGYwZmZkOTdlZjAgMDAwMDAwMDAwMDAwMDAwMA0KPiBKdW4gMjggMTU6Mjk6
MjYgbGludXgga2VybmVsOiByYXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCAw
MDAwMDAwMGZmZmZmZmZmIDAwMDAwMDAwMDAwMDAwMDANCj4gSnVuIDI4IDE1OjI5OjI2IGxpbnV4
IGtlcm5lbDogcGFnZSBkdW1wZWQgYmVjYXVzZTogdHJvdWJsZSBwYWdlLi4uDQo+IA0KDQpXaXRo
IHRoaXMgcHJvYmxlbWF0aWMgcGFnZSBzdHJ1Y3R1cmUgY29udGVudHMsIGl0IHNlZW1zIHRoYXQg
dGhlDQpsaXN0X2hlYWQgPSB7ZmZmZmRmYmQ5ZTYwMzc4OCwgZmZmZmQ0ZjBmZmQ5N2VmMH0gaXMg
dmFsaWQuDQoNCkkgZ3Vlc3MgaXQgd2FzIGxpbmtpbmcgdG8gdGhlIHBjcF9saXN0LCBzbyBJIGR1
bXBlZCB0aGUgcGVyX2NwdV9wYWdlc1tjcHVdLmNvdW50DQppbiBldmVyeSBpbiBjcml0aWNhbCB0
aW1pbmdzLg0KDQpBbiBleGFtcGxlIGlzIGFzIGJlbG93LA0Kb2ZmbGluZV9wYWdlcygpDQp7DQoJ
Ly8gcGVyX2NwdV9wYWdlc1sxXS5jb3VudCA9IDANCgl6b25lX3BjcF9kaXNhYmxlKCkgLy8gd2ls
bCBjYWxsIF9fZHJhaW5fYWxsX3BhZ2VzKCkNCgkvLyBwZXJfY3B1X3BhZ2VzWzFdLmNvdW50ID0g
MTg4DQoJZG8gew0KCQlkbyB7DQoJCQlzY2FuX21vdmFibGVfcGFnZXMoKQ0KCQkJcmV0ID0gZG9f
bWlncmF0ZV9yYW5nZSgpDQoJCX0gd2hpbGUgKCFyZXQpDQoNCgkJcmV0ID0gdGVzdF9wYWdlc19p
c29sYXRlZCgpDQoNCgkJaWYoaXMgdGhlIDFzdCBpdGVyYXRpb24pDQoJCQkvLyBwZXJfY3B1X3Bh
Z2VzWzFdLmNvdW50ID0gMTgyDQoNCgkJaWYgKGlzc3VlIG9jY3VycykgeyAvKiBpZiB0aGUgbG9v
cCB0YWtlIGJleW9uZCAxMCBzZWNvbmRzICovDQoJCQkvLyBwZXJfY3B1X3BhZ2VzWzFdLmNvdW50
ID0gNjENCgkJCV9fZHJhaW5fYWxsX3BhZ2VzKCkNCgkJCS8vIHBlcl9jcHVfcGFnZXNbMV0uY291
bnQgPSAwDQoJCQkvKiB3aWxsIGVzY2FwZSBmcm9tIHRoZSBvdXRlciBsb29wIGluIGxhdGVyIGl0
ZXJhdGlvbnMgKi8NCgkJfQ0KCX0gd2hpbGUgKHJldCkNCn0NCg0KU29tZSBpbnRlcmVzdGluZyBw
b2ludHM6DQogIC0gQWZ0ZXIgdGhlIDFzdCBfX2RyYWluX2FsbF9wYWdlcygpLCBwZXJfY3B1X3Bh
Z2VzWzFdLmNvdW50IGluY3JlYXNlZCB0byAxODggZnJvbSAwLA0KICAgIGRvZXMgaXQgbWVhbiBp
dCdzIHJhY2luZyB3aXRoIHNvbWV0aGluZy4uLj8NCiAgLSBwZXJfY3B1X3BhZ2VzWzFdLmNvdW50
IHdpbGwgZGVjcmVhc2UgYnV0IG5vdCBkZWNyZWFzZSB0byAwIGR1cmluZyBpdGVyYXRpb25zDQog
IC0gd2hlbiBpc3N1ZSBvY2N1cnMsIGNhbGxpbmcgX19kcmFpbl9hbGxfcGFnZXMoKSB3aWxsIGRl
Y3JlYXNlIHBlcl9jcHVfcGFnZXNbMV0uY291bnQgdG8gMC4NCg0KU28gSSB3b25kZXIgaWYgaXQn
cyBmaW5lIHRvIGNhbGwgX19kcmFpbl9hbGxfcGFnZXMoKSBpbiB0aGUgbG9vcD8NCg0KTG9va2lu
ZyBmb3J3YXJkIHRvIHlvdXIgaW5zaWdodHMuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KT24g
MDEvMDcvMjAyNCAwOToyNSwgWmhpamlhbiBMaSAoRnVqaXRzdSkgd3JvdGU6DQo+IEhpIGFsbA0K
PiANCj4gDQo+IE92ZXJ2aWV3Og0KPiBEdXJpbmcgdGVzdGluZyB0aGUgQ1hMIG1lbW9yeSBob3Ry
ZW1vdmUsIHdlIG5vdGljZWQgdGhhdCBgZGF4Y3RsIG9mZmxpbmUtbWVtb3J5IGRheDAuMGANCj4g
d291bGQgZ2V0IHN0dWNrIGZvcmV2ZXIgc29tZXRpbWVzLiBkYXhjdGwgb2ZmbGluZS1tZW1vcnkg
ZGF4MC4wIHdpbGwgd3JpdGUgIm9mZmxpbmUiIHRvDQo+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vbWVt
b3J5L21lbW9yeU5OTi9zdGF0ZS4NCj4gDQo+IFdvcmthcm91bmQ6DQo+IFdoZW4gaXQgaGFwcGVu
cywgd2UgY2FuIHR5cGUgQ3RybC1DIHRvIGFib3J0IGl0IGFuZCB0aGVuIHJldHJ5IGFnYWluLg0K
PiBUaGVuIHRoZSBDWEwgbWVtb3J5IGlzIGFibGUgdG8gb2ZmbGluZSBzdWNjZXNzZnVsbHkuDQo+
IA0KPiBXaGVyZSB0aGUga2VybmVsIGdldHMgc3R1Y2s6DQo+IEFmdGVyIGRpZ2dpbmcgaW50byB0
aGUga2VybmVsLCB3ZSBmb3VuZCB0aGF0IHdoZW4gdGhlIGlzc3VlIG9jY3VycywgdGhlIGtlcm5l
bA0KPiBpcyBzdHVjayBpbiB0aGUgb3V0ZXIgbG9vcCBvZiBvZmZsaW5lX3BhZ2VzKCkuIEJlbG93
IGlzIGEgcGllY2Ugb2YgdGhlDQo+IGhpZ2hsaWdodGVkIG9mZmxpbmVfcGFnZXMoKToNCj4gDQo+
IGBgYA0KPiBpbnQgX19yZWYgb2ZmbGluZV9wYWdlcygpDQo+IHsNCj4gICAgIGRvIHsgLy8gb3V0
ZXIgbG9vcA0KPiAgICAgICBwZm4gPSBzdGFydF9wZm47DQo+ICAgICAgIGRvIHsNCj4gICAgICAg
ICByZXQgPSBzY2FuX21vdmFibGVfcGFnZXMocGZuLCBlbmRfcGZuLCAmcGZuKTsgIC8vIEl0IHJl
dHVybnMgLUVOT0VOVA0KPiAgICAgICAgIGlmICghcmV0KQ0KPiAgICAgICAgICAgIGRvX21pZ3Jh
dGVfcmFuZ2UocGZuLCBlbmRfcGZuKTsgICAgICAgICAgICAgLy8gTm90IHJlYWNoIGhlcmUNCj4g
ICAgICAgfSB3aGlsZSAoIXJldCk7DQo+ICAgICAgIHJldCA9IHRlc3RfcGFnZXNfaXNvbGF0ZWQo
c3RhcnRfcGZuLCBlbmRfcGZuLCBNRU1PUllfT0ZGTElORSk7DQo+ICAgICAgIH0gd2hpbGUgKHJl
dCk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyByZXQgaXMgLUVCVVNZDQo+
IH0NCj4gYGBgDQo+IA0KPiBJbiB0aGlzIGNhc2UsIHdlIGR1bXBlZCB0aGUgZmlyc3QgcGFnZSB0
aGF0IGNhbm5vdCBiZSBpc29sYXRlZCAoc2VlIGR1bXBfcGFnZSBiZWxvdyksIGl0J3MNCj4gY29u
dGVudCBkb2VzIG5vdCBjaGFuZ2UgaW4gZWFjaCBpdGVyYXRpb24uOg0KPiBgYGANCj4gSnVuIDI4
IDE1OjI5OjI2IGxpbnV4IGtlcm5lbDogcGFnZTogcmVmY291bnQ6MCBtYXBjb3VudDowIG1hcHBp
bmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDAgcGZuOjB4Nzk4MGRkDQo+IEp1biAyOCAxNToy
OToyNiBsaW51eCBrZXJuZWw6IGZsYWdzOiAweDlmZmZmZmMwMDAwMDAwKG5vZGU9Mnx6b25lPTN8
bGFzdGNwdXBpZD0weDFmZmZmZikNCj4gSnVuIDI4IDE1OjI5OjI2IGxpbnV4IGtlcm5lbDogcmF3
OiAwMDlmZmZmZmMwMDAwMDAwIGZmZmZkZmJkOWU2MDM3ODggZmZmZmQ0ZjBmZmQ5N2VmMCAwMDAw
MDAwMDAwMDAwMDAwDQo+IEp1biAyOCAxNToyOToyNiBsaW51eCBrZXJuZWw6IHJhdzogMDAwMDAw
MDAwMDAwMDAwMCAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwZmZmZmZmZmYgMDAwMDAwMDAwMDAw
MDAwMA0KPiBKdW4gMjggMTU6Mjk6MjYgbGludXgga2VybmVsOiBwYWdlIGR1bXBlZCBiZWNhdXNl
OiB0cm91YmxlIHBhZ2UuLi4NCj4gYGBgDQo+IA0KPiBFdmVyeSB0aW1lIHRoZSBpc3N1ZSBvY2N1
cnMsIHRoZSBjb250ZW50IG9mIHRoZSBwYWdlIHN0cnVjdHVyZSBpcyBzaW1pbGFyLg0KPiANCj4g
UXVlc3Rpb25zOg0KPiBRMS4gSXMgdGhpcyBiZWhhdmlvciBleHBlY3RlZD8gQXQgbGVhc3QgZm9y
IGFuIE9TIGFkbWluaXN0cmF0b3IsIGl0IHNob3VsZCByZXR1cm4NCj4gICAgICAgcHJvbXB0bHkg
KHN1Y2Nlc3Mgb3IgZmFpbHVyZSkgaW5zdGVhZCBvZiBoYW5naW5nIGluZGVmaW5pdGVseS4NCj4g
UTIuIFJlZ2FyZGluZyB0aGUgb2ZmbGluZV9wYWdlcygpIGZ1bmN0aW9uLCBlbmNvdW50ZXJpbmcg
c3VjaCBhIHBhZ2UgaW5kZWVkIGNhdXNlcw0KPiAgICAgICBhbiBlbmRsZXNzIGxvb3AuIFNob3Vs
ZG4ndCBhbm90aGVyIHBhcnQgb2YgdGhlIGtlcm5lbCB0aW1lbHkgY2hhbmdlZCB0aGUgc3RhdGUN
Cj4gICAgICAgb2YgdGhpcyBwYWdlPw0KPiANCj4gICAgICAgV2hlbiBJIHVzZSB0aGUgd29ya2Fy
b3VuZCBtZW50aW9uZWQgYWJvdmUgKEN0cmwtQyBhbmQgdHJ5IG9mZmxpbmUgYWdhaW4pLCBJIGZp
bmQNCj4gICAgICAgdGhhdCB0aGUgcGFnZSBzdGF0ZSBjaGFuZ2VzIChzZWUgZHVtcF9wYWdlIGJl
bG93KToNCj4gYGBgDQo+IEp1biAyOCAxNTozMzoxMiBsaW51eCBrZXJuZWw6IHBhZ2U6IHJlZmNv
dW50OjAgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAgaW5kZXg6MHgwIHBmbjow
eDc5ODBkZA0KPiBKdW4gMjggMTU6MzM6MTIgbGludXgga2VybmVsOiBmbGFnczogMHg5ZmZmZmZj
MDAwMDAwMChub2RlPTJ8em9uZT0zfGxhc3RjcHVwaWQ9MHgxZmZmZmYpDQo+IEp1biAyOCAxNToz
MzoxMiBsaW51eCBrZXJuZWw6IHJhdzogMDA5ZmZmZmZjMDAwMDAwMCBkZWFkMDAwMDAwMDAwMTAw
IGRlYWQwMDAwMDAwMDAxMjIgMDAwMDAwMDAwMDAwMDAwMA0KPiBKdW4gMjggMTU6MzM6MTIgbGlu
dXgga2VybmVsOiByYXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAw
MGZmZmZmZmZmIDAwMDAwMDAwMDAwMDAwMDANCj4gSnVuIDI4IDE1OjMzOjEyIGxpbnV4IGtlcm5l
bDogcGFnZSBkdW1wZWQgYmVjYXVzZTogcHJldmlvdXMgdHJvdWJsZSBwYWdlDQo+IGBgYA0KPiAN
Cj4gV2hhdCBvdXIgdGVzdCBkb2VzOg0KPiBXZSBoYXZlIGEgQ1hMIG1lbW9yeSBkZXZpY2UsIHdo
aWNoIGlzIGNvbmZpZ3VyZWQgYXMga21lbSBhbmQgb25saW5lIGludG8gdGhlIE1PVkFCTEUNCj4g
em9uZSBhcyBOVU1BIG5vZGUyLiBXZSBydW4gdHdvIHByb2Nlc3NlcywgY29uc3VtZS1tZW1vcnkg
YW5kIG9mZmxpbmUtbWVtb3J5LCBpbiBwYXJhbGxlbCwNCj4gc2VlIHRoZSBwc2V1ZG8gY29kZSBi
ZWxvdzoNCj4gDQo+IGBgYA0KPiBtYWluKCkNCj4gew0KPiAgICAgICBpZiAoZm9yaygpID09IDAp
DQo+ICAgICAgICAgICBudW1hY3RsIC1tIDIgLi9jb25zdW1lLW1lbW9yeQ0KPiAgICAgICBlbHNl
IHsNCj4gICAgICAgICAgIGRheGN0bCBvZmZsaW5lLW1lbW9yeSBkYXgwLjANCj4gICAgICAgICAg
IHdhaXQoKQ0KPiAgICAgICB9DQo+IH0NCj4gYGBgDQo+IA0KPiBBdHRhY2hlZCBpcyB0aGUgcHJv
Y2VzcyBpbmZvcm1hdGlvbiAod2hlbiBpdCBnZXRzIHN0dWNrKToNCj4gYGBgDQo+IHJvb3QgMjU3
MTYgMC4wIDAuMCAyNDYwIDE0MDggcHRzLzAgUysgMTU6MjggMDowMCAuL21haW4NCj4gcm9vdCAy
NTcxOSAwLjAgMC4wIDAgMCBwdHMvMCBaKyAxNToyOCAwOjAwIFtjb25zdW1lLW1lbW9yeV0gPGRl
ZnVuY3Q+DQo+IHJvb3QgMjU3MjAgOTguNiAwLjAgOTQ3NiAzNzQwIHB0cy8wIFIrIDE1OjI4IDA6
MjYgZGF4Y3RsIG9mZmxpbmUtbWVtb3J5IC9kZXYvZGF4MC4wDQo+IGBgYA0KPiANCj4gRmVlbCBm
cmVlIHRvIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIG1vcmUgZGV0YWlscy4NCj4gVGhhbmsgeW91
IGZvciB5b3VyIGF0dGVudGlvbiB0byB0aGlzIGlzc3VlLiBMb29raW5nIGZvcndhcmQgdG8geW91
ciBpbnNpZ2h0cy4NCj4gDQo+IFRoYW5rcw0KPiBaaGlqaWFu
