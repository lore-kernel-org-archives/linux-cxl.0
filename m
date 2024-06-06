Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15355440C
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640437; cv=fail; b=k9PNXrDdriAanyhuNoCZI1c9alsXu7C7JEcMI6NOfu+ByCI8bERN45YxuUMYGyPbl7f+sm7zzvmKzjwelwSCMfzc1wuCa6AMZ6iDeR48VKAgq6yndVrtceqUoFSaabDKENMtp4PHUKy0RdT/Nk0UpldTxZR1jWpPRx8l/gozPMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640437; c=relaxed/simple;
	bh=Jr8SiLROVxvUVAw8Ku8ey11WAUf8JA8sokDUNWBHAcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DNYlR0JiaEQA/5ErIYBzoqJHh79YjyOWygSJuEuqyNFxAK1nh4E9ikSg4TxjiUsV2INrIf/XmxnJ15uMZ/RONZOkplwsnXZPXGZVPUGKzpIOb1j34DjPxrVc3voOYuIIwMX17QEOKpSVffXp09sn+0SAQpj+Yf9VpeKO8Y5Kl+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=vtoBkw6W; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="vtoBkw6W"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1717640434; x=1749176434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jr8SiLROVxvUVAw8Ku8ey11WAUf8JA8sokDUNWBHAcI=;
  b=vtoBkw6WG/A75ZkpFN8X82EDAKoGSTisAtJO+6z6cHEjJUBKHF5DFS7+
   jQ2bfUNhhzTbi+SLntoJOrRtodUJQ3VXYCifwfjzxzhhzEHUQiogq1Oax
   +szdoJjEXNK85cfunBha7vhgS3HrzkAsuzS+I8ZKRrJGR2YfJPUdLyEXa
   vwUcP6asnp1xz7q0SqMIpSscddaK+JxjnxZK27iSgwkleQ5Yp6XLx2Lk0
   6P4yuypZzBAqRMwJwScIqqdt2hafFBcgFnheZNbKj0RUz40p3b0f+p39d
   QWxlP7o7snXb8vZblesYXhgs/SRi0hZEY4ghi5mBAm8i+P1timeUKXvXh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="121335318"
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="scan'208";a="121335318"
Received: from mail-japanwestazlp17011004.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 11:19:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJRyBBE1orT0rYjYdOIXPOv87vyOTdP2vivVFWYbmiEAgqTMKI5j1JcAk4Q4xyScoy07xAkhqDtpyhv6m2+XTorqKgqLKO3aqJAvnOxs/s7kRDxXUeHNeAoaBcQgz988xfdnNL9oYXdA6bf1XlIkrFGo0zswT5qwcmDsZO+V4iTTD2FOuuFwnHOyOCPDfCJoqLSSsXDHsom9r22KgLJVwI7YF/SRLsq8lBsLV/U68AN3NEpjeOR4qfpkflEJRw5dRdEQ16X94zV/m7AjfnOzW6Nyx6esYddcUeyDI3z/Up/DoIs+1NWMu7R03/efxh6daJDpDk22kpQ3bB9ZCnZhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIh/I7aPoAoZUysPO+x+iQw9oLCaKUHfGn3+q48J2SM=;
 b=CIVGHSNoC05lkNCb2SmpMKbPiRcXr2vuxQt87kMSFCqpmnb0rHJ8CSCnhL1VQmxKQeoeqPSAJuaKJBs6axRYwWfjvvffvmE1tczNNTgQCX8aktC32L9m/+3NrDVTDxHVDTWfUDYESBWsq4g8QZUhRLo+s75a0ABxGmDAfWDE05j4Lbr2wGO2IVr+D1TWbA0ScLl1QF5YMnbM46KETGmqNt5ya+tovP7s38ecsL9Jz2QGHRqhCfZy2Tzgyw9zl67u/e82m7w5DqzzA2NAvvVO8R+q9Iq2J9CnUOmkzvS7+HbyCYoqTR+TYgaU76MvcBKNalEXiIcJOlbbuX5aS7GmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OSZPR01MB8467.jpnprd01.prod.outlook.com (2603:1096:604:16e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 02:19:09 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 02:19:09 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v5] cxl/region: check interleave capability
Thread-Topic: [PATCH v5] cxl/region: check interleave capability
Thread-Index: AQHarbykF6dW9BcSvE+L2hi4a5DvCbG5Oa+AgADUoNA=
Date: Thu, 6 Jun 2024 02:19:09 +0000
Message-ID:
 <OSZPR01MB6453B7063C3425B8824EDEA38DFA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240524092740.4260-1-yaoxt.fnst@fujitsu.com>
 <20240605141631.00006b54@Huawei.com>
In-Reply-To: <20240605141631.00006b54@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=fe9a717d-c382-403c-8aa8-4992dd239fed;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-06T01:57:37Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OSZPR01MB8467:EE_
x-ms-office365-filtering-correlation-id: b003b7b0-38be-4851-b03a-08dc85cf0c7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|366007|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?c2xUWWEvZE9Ybm1teERNTDlqcitNWWVENEZYeWJ5WGF3dGlIdHBGNWNo?=
 =?iso-2022-jp?B?cDNRNEpVMnVCQ2ZJeURFeHJJSmNRZ0xuMHRoVXZhNkhMdTVhWWd4Q0Ft?=
 =?iso-2022-jp?B?WVg3aGZFYVVpWmhpekVoYWNQaTg1WmxJdHdRYjdDZkdzUVlpSjVsWmR6?=
 =?iso-2022-jp?B?ek4zbytuMmc2SVBGamJ1S1RVOUd5aDBUWENjU09kUFdBbUpvZXBSUjMz?=
 =?iso-2022-jp?B?UHdndzZxbE53NTZ5a2hWWTNyTjRzMlcyc3JkcEd6UWU0VUU5TjZ0Z1M1?=
 =?iso-2022-jp?B?aDdEVjlXRmNyMW9pdkxsRW5ZQjhJOUM1QmlhV1dUV1V2cmhrcHhxd2NB?=
 =?iso-2022-jp?B?dTNBTTR3QWxjQTNac3RObUkwY1AwdmZaT1NsOEFlbFBrUUxCSENhUDVW?=
 =?iso-2022-jp?B?azVrVGowWStQanNETXh0WUVaSXZSdG44WlZWdlZNVjVIWmFMTmYzbWVZ?=
 =?iso-2022-jp?B?bVNkSisxcGtaWkQ5d2tSQm83d2ZhMTNhVWFiWk1OOVJoaXp5bXBqME02?=
 =?iso-2022-jp?B?ZjVQTnArSE0rUUJPZGoydXMwbU1IQmpHeUd6anVKWkhhTTlzeThWVHVx?=
 =?iso-2022-jp?B?eUp5djhYQ1dEcVFkMUpTcVplYU1ycHVteE5iUU1WMXVHNW1HUmcvSUsy?=
 =?iso-2022-jp?B?YmVDcjBCc2xHVjRkaDBtUWxwRkZ4TEJzTUU2cG5DSEY3M2hzZXMybDlV?=
 =?iso-2022-jp?B?ZDM1azBROU5XaFBoK1JVZ2lOS1pVaGNHbWhQUUFNeUhsbGZzMGZEbGRX?=
 =?iso-2022-jp?B?dThPSlA3YU9Cb2Jrc2hRTmhvVEVYa2xNd0FMa01WeDV1MGJ4VHlVdTJT?=
 =?iso-2022-jp?B?Z1hhNncwb0JKMVhSVGhZZVF6U3NqdE05YXZVMGJTL2NySERsVGcrWmFs?=
 =?iso-2022-jp?B?aXVqT0RtMFdGaTI3MnNwd204Y2w3ajBjWmFBTUljc1B6VTA1TFB1SWN2?=
 =?iso-2022-jp?B?eGVvWjUvUDFUZERjNjRoaUFUczlpL0dLUEFuR2FUMndKSG9kRzlNbThR?=
 =?iso-2022-jp?B?TVJzWEhNMy9WU1NIbWN2dXBEcUFsWlVXRFdnSjMrdXAybUhjYlFHTTJ0?=
 =?iso-2022-jp?B?QUdFZlpmek5QKzkxUVdsK3Zwb3Y4ME5MaHJQV1U3YmhQUG1QNHJ6cUp5?=
 =?iso-2022-jp?B?QXNocTQxc0kwTFRFZ0hXaFl6WXZyZ1VkRDRsQ3hvVGNCYWZuT1NmT01v?=
 =?iso-2022-jp?B?ZnozRXppQjgvR0QvQUJjbCtrV2tzU1hSN2doeXo1ek4yQ3QrT05kVnUy?=
 =?iso-2022-jp?B?UEhhY0pNWnFNblhYMUlST2dGVzJCbEwzMWdSLzlHS21MS1BMRUlOSjAz?=
 =?iso-2022-jp?B?Ukd3dHl4Q1luRTl4NmtSaGRYWUc0VjA1R3dmdnZBN01oc0M4RXhoMVpB?=
 =?iso-2022-jp?B?NFY0a0x1VEJBSElNZzFHdlliOHN5NjRTRXB4NVlIWHpHNFNVNitlU2RM?=
 =?iso-2022-jp?B?QmtaMDdPdjQxc2lBcC9RSGd4MzBtdnZJTzVMdEpIRGh3aHJxdXVEQnUw?=
 =?iso-2022-jp?B?QXoxRS96L2NkL1JBUkplSkhONlpJbjZXemxLS2U3M3BCd0p5U1BicjIz?=
 =?iso-2022-jp?B?R3lhRHV2aEJiM3QzVHBMZ3RyMEd1NEppbkZ4VUQwVzIyakdzZXptajFP?=
 =?iso-2022-jp?B?RGN3VVVGUjc2a01GZUt0TVF1U0RPUHVaTUZ2RHJDT010NkFvZ3JPQ1Bq?=
 =?iso-2022-jp?B?TGRXT0t1em9pZnd0cFQrSndycUI0cmdOZnlQR3gxV1dWWFpPVVNyc2VR?=
 =?iso-2022-jp?B?QzNLYlBVZ2x4d2twcVd2NVJaanAzUzR5Qjk3TlcwOUJ5UUtZMElJTU53?=
 =?iso-2022-jp?B?VXVSYVI3NU9Xd3o3Wk1RakJlZ3YzKzZidnVJS09GN0xJS2NkTzdLYWZE?=
 =?iso-2022-jp?B?N05aTWsrd1M2RHVjYTBZamh3UVpTTlF1eHNpSjhQT0c5cGpOQTlCOEhu?=
 =?iso-2022-jp?B?V0RiZlNDbjBkaGQ3Y2ZYNDBqQXl6MVE1eXlXNWJEN1MrRmw4THRPNmdz?=
 =?iso-2022-jp?B?NHFBQkRPaEtmZE8vYTZURHd0WFRpVSt0cEs5ZGdpa1FDeWRGUEZUNlZx?=
 =?iso-2022-jp?B?dGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ek5kUWNUNld6QUx4akc1cktZZnp2bGNsUWh5S2JPQ1VkTzEvZXYyRFhY?=
 =?iso-2022-jp?B?aGx5MDFuaXhQcjBJbHhKakJEUk9NS1dwWS9iNUg5eDNha2F6RnhHZGJK?=
 =?iso-2022-jp?B?cyt2eFRrcXJFVHRxeU9sQmpaWER6MTJGVk5CMjNodVBXbGs2ZmhTaW1m?=
 =?iso-2022-jp?B?U3dWUUdhakhvdnRrQk1UeGVzbDBKUVZ1dDFRL1lKM1k1ZXhjZEJKOFhD?=
 =?iso-2022-jp?B?UjlHNC80NDgvdU1lZjByM2MrVGZUTTFHaDZmWmRReHFmeWIwSk9BZGVF?=
 =?iso-2022-jp?B?bk00YTF1QlhNK2FUWDFXS3Z2QmZTcURtZVJmakYrQ1kxaDhQOEtVaHNs?=
 =?iso-2022-jp?B?UmJkTnFJa1Z0L2N4T2Jhbkk4WE9sTm8xYVZhWEZ0MDJIQVkraEZkSnRB?=
 =?iso-2022-jp?B?S3NxOVdHRjRXTWt1VzY5UHBEV0FpNmFPNFo0THErdWk3emQ5SUNUbGRI?=
 =?iso-2022-jp?B?QmdRTkFxQjNIRVhNTTh1ZCtyWFpjZFBmRk4yZDh4M21sM2YxQnlNOThy?=
 =?iso-2022-jp?B?V1gxZnFmRSs1NTgzWVVtUjFDOEZ1NS9YQlRlR3RRUk1icGdZc0pMUUVB?=
 =?iso-2022-jp?B?MXo5YmxscHBsUm1Sek0vNmtvQ3JEUU1WQTE0NnBYVnVtMWM5TmlhcUJr?=
 =?iso-2022-jp?B?ZVBWOEtCYjhMZXBPYzJNWmZuZ1g3LzBzNElUWVBNcTl1Tjg4cldrZU9s?=
 =?iso-2022-jp?B?dGg0SjBTTitackpZVjNEZ3Z1b2JmUkxwZk1WQ01KSUdRWERyWWw2cmlP?=
 =?iso-2022-jp?B?ckhaYnRHdVJEWXcvK1BNQ3NwQ1IwM0JRVGo4K0h3SWIrWFBmWGxSZGFn?=
 =?iso-2022-jp?B?L1pxUVE4V3RCU0o2c2RYVGFJYnJGbDNXY1JzYXNLT2hDV1lxNVF4cCtZ?=
 =?iso-2022-jp?B?ZW50TVNHRFo0b21ZUWgzZldScHduZGNoOFQzdEZUWkJhVzZqQ3ZUVlZ5?=
 =?iso-2022-jp?B?SW9sZ2tsNnVVTHNqaUtXSGR2RkdNYVhpcFY4RUtUQWF5MWhGNmNPVFdL?=
 =?iso-2022-jp?B?cjByTzRWWVkrNnhmOG1qdElyMnVwQ0NjbjNxNG9GcHd3TWlrOFdHWTFZ?=
 =?iso-2022-jp?B?ZXAyTVkvdFJnTm84aXlRMlo3TE1XK013Nlp4L0JpVzVyNWpMamRQQ29K?=
 =?iso-2022-jp?B?VkthQWNCTkp4Y3JYNWpwdGdlYjhUbm00YkVaRVFrdzA0eU5aTFMwMVoy?=
 =?iso-2022-jp?B?RHJjbmprREVyMkRvYkt0VEVrSFBVRzNUcVpZNXU0czg0YjBsdDBNOXBR?=
 =?iso-2022-jp?B?YlFkK0tkTzVaYjdyVWVlT0JmSjFVUDMvUmtoNzJ3dGNZTFR5ZzBtSGw1?=
 =?iso-2022-jp?B?ZWJPV0Q2NWVZNGpTSGdVZGNER3NCSlRsb3Ftdm00bTBMd0JTb1pocjVZ?=
 =?iso-2022-jp?B?UzB1dzh5Z1BlS2VUcXpGaTN0RFp3NTY2Nnpmc2FFanRwN29QVU1hYVI4?=
 =?iso-2022-jp?B?dS9qays0Nk9UN1N3b3QxcVpwbmVPRXVHQ2JwZ0k2UHJ1QUt0WS92T0Z6?=
 =?iso-2022-jp?B?UC9NbFNhUnZBekxYRjVsTG1jUFdaQ28yRDJVMEJwQjJDTlJndkxOWUV3?=
 =?iso-2022-jp?B?SWU2REF5aE5temdqaHRIeEdsVEN2RHJhK243REloYXNqd0xxa3JSRlA0?=
 =?iso-2022-jp?B?VXVrL0w4dW1WQW5acjNrTHdyV2NWdHhkVE5Ga201NFlyUFZ2c3hKZWVT?=
 =?iso-2022-jp?B?L2JFTk1TVUduQkdINVpUR0pOYngxNWJXbEMwYThVa1FiUTNqaVQyMng2?=
 =?iso-2022-jp?B?eFR5N0RkZVB2MEZDY3l6c0xNNldoZ0w3SXFvMHI1Nzc3aUZORWJ5aWx1?=
 =?iso-2022-jp?B?NFhQejNLOXdaclhnczExNUpmVmNaZURjQkRSQ0dsOFdna3FuQmpPcWJO?=
 =?iso-2022-jp?B?bEdXdC9IVm5ySllFdHVuL01BVFpNK3FyR0RsY0R4Yk4xcmRqOEV2YWYx?=
 =?iso-2022-jp?B?OGUzbHV1UDJ3dnlnbVlld1hjWkdQL1BGSlpLMHdzdWR0bzJESGhQcDBD?=
 =?iso-2022-jp?B?UWJnRE0rc0JVWWh6UEtJYkZ6ZkhvUUM1a0N1RUxOK3czVzlscFFldllk?=
 =?iso-2022-jp?B?OGx1NEdnczZiTndWK2Y0cmNpcEdGRDBkM3NZZzJNSG5rTjlXV2E0Y0Er?=
 =?iso-2022-jp?B?YTlMSVpNaU5NTWhhVFhqaXZRU0tPUHZWSkVPOFVPTDF0ekNJMzVXOE11?=
 =?iso-2022-jp?B?WjM5eU12OFVWYnFuekl3QmhablBRTjVRaGxRY2pEZFNod1FVRlN3ZENT?=
 =?iso-2022-jp?B?YW55bnhKSEVWb2d0YmNDYnIxdFJVZ3ozK29VWGxSdnIvOHZOWWYwUVBK?=
 =?iso-2022-jp?B?VGdjQg==?=
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
	Bz3a2B6DWCA4yf/WUCBAvW8onS7kRRJjqInsZm7FekGxfh9Dyno5eRnONeFG71WOwplS0Wt7JryDKYK4JdPNVW4TgyHzShVPV9yikPn3UB7Kd1BM+asK8vcgbqzqNUtEwfoHmqmNH6JwoIMVBF7ptuabdUpY8bFautn8wi72mBL8085/gzonRj78M6YkaprVJsRBsmlD5N1BXzSxJDjSrm1FGPbEhLnJegxquPr0Q8Wpd3dq62SJ2Hzyh9hmW6r99i+rWpb+ffh28FjDw9IPb6Mv1ufGUj1Uj4lsgGN/34nV/SQj2InKTFDi9vtGZYm7gt1NbiDXXlCGC40xFgs0A5mkIEZh/2L/N6zFih6S3ZJ/W4sc8y/oJWiwNpBoT4w0maxyTqgCik+5dEOgRRvoy0iRVe7Slt11dF8ywg9+RLy8cnJgMDWakqCs21CHYrfJfgFVSSAPFSeRhsVAoooYrgRw8rvZd+2M/KnviVI8bTOjfC6958QvJl0Z/0AsBJ+wfwcp16uEnuo0CgRUqrOgTitZ+QNAQtGnTM6RfXJ7jizKQUzquczyAT5gp3nQn+Ios12D9QbkhfHAXDVrCMv4rBWlxtozwDuetcthKsPJDWY0a1EUHpdO9oUFGBCY1JOn
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b003b7b0-38be-4851-b03a-08dc85cf0c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 02:19:09.3588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2TB7cOsQez+hLbwqp7PWtCAlixZ80LOJ3LMNWgJl1t0hePyHga6IXimbbH+4AxervMvfQEhPlx9fQqeaTHH1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8467



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Wednesday, June 5, 2024 9:17 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: dave@stgolabs.net; dave.jiang@intel.com; alison.schofield@intel.com;
> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v5] cxl/region: check interleave capability
>=20
> On Fri, 24 May 2024 05:27:40 -0400
> Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:
>=20
> > Since interleave capability is not verified, if the interleave
> > capability of a target does not match the region need, committing decod=
er
> > should have failed at the device end.
> >
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
> Hi Yao,
>=20
> A few comments inline.
> Jonathan
>=20
> > ---
> >  drivers/cxl/core/hdm.c    | 10 +++++
> >  drivers/cxl/core/region.c | 83
> +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h         |  2 +
> >  drivers/cxl/cxlmem.h      |  1 +
> >  4 files changed, 96 insertions(+)
>=20
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
> Could reduces scope of this...
OK, got it.
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
>=20
> 		struct cxl_switch_decoder *cxlsd =3D
> 			to_switch_decoder(&cxld->dev);
>=20
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
>=20
> set rc?
yes, it's a problem, will fix.
>=20
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
>=20
> 8.2.4.20.13 I think
yes, it's a mistake. thanks.
>=20
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
>=20
> interleave
also a mistake. thanks.
>=20
> > +	 * interleave bits is 0, there is no interleaving, the following
> > +	 * check is ignored.
>=20
> If the interleave is 3 there is no interleave?  That seems an odd stateme=
nt
> perhaps make that comment more detailed.
> My understanding is that it's just more complex and all bits are relevant=
.
yes, but it is difficult to describe the interleave bits.=20
In the SPCE " 8.2.4.20.13 Decoder Protection ",  only when IW < 8, it calle=
d=20
[IG + IW +7: IG+8] as IW bits.
but when IW >=3D 8, what is the IW bits definition?=20

In my opinion:
if IW =3D 8, all the bits of HPAOFFSET[51:0] is used,  so the IW bits is no=
ne.
if IW >8, the bits [IG+IW-1: IG+8] of HPAOFFSET is not used, so the IW bits=
 should be  [IG+IW-1: IG+8],

is it right?

>=20
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

