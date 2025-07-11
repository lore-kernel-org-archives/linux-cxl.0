Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3891625;
	Fri, 11 Jul 2025 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752212081; cv=fail; b=rdyq4KIhwfeqYrhrgEq+S+ApiIah5VRXSdbxikDWYJL0y+H/RTS4ketE5tirhh5PCBFHmA5w5sTCK1LOLF5VrsUJ1qGEQdaPDz8kBvCL8yL9MnN48XKiCx1VkB5RQ67a7XTfLeaGomx5PQoxZatPaUtRz6XnEJZtF4KZli0/8YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752212081; c=relaxed/simple;
	bh=fdac/UCXocHx3pdaUzC4WkEGhNRpClM39M6cS1mCvUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=efdVOsWyldVLkauwOYsuY4+21ArOt+bOEK1GwpmZBQ7GhjHcZQt+g0/3D3A0hf4zXwchQFg4Xrqm6KNkBkNNddHzoCPCCQqY81ORI3QVefUZux2IbAGwcqsxhnlBj0NabqAjyb5A7EgfOn9UJMWo9X8nhR60MB522+kS6vG1nMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=qo+S+fb7; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="qo+S+fb7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752212079; x=1783748079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fdac/UCXocHx3pdaUzC4WkEGhNRpClM39M6cS1mCvUA=;
  b=qo+S+fb7ZaswC0Wc4Mk8Hf9bGW+edNAGlstHmBN7tAeApkHfctLZeSmX
   bYxlyQaZa/C/chZozGDUwyyHLSdJZZOBY2FWotQkAfUMGbRl1qUtois1t
   S86AyjvCtyN3gDkVJ5gDvFNaIIwBALVr6m60MDDedWp+MAI0gTFNbJsc8
   w+N8aVS046n/o+1e2HOnwj5Z4vh96MAliSLD0M54/Qnly7SYTUth9C7La
   Sdo66pt1C6CMmOZ6+UpYnorkv1BD73B9twbYbg9pmk+r1Y0Ex2U9WpF4H
   CLsQmyAyRCBTjCRaANNWfH0THJ1jHEPWiwxL+vFeQaLs1FVihR1ab3azE
   A==;
X-CSE-ConnectionGUID: D5uZLJGySdOjzn6zE+eEnA==
X-CSE-MsgGUID: CfZGaJHJTEO7sjlMErZkgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="160798066"
X-IronPort-AV: E=Sophos;i="6.16,302,1744038000"; 
   d="scan'208";a="160798066"
Received: from mail-japanwestazon11010056.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 14:34:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsuzNuDxfjQQ4mKiFj2wMO6SAubReyB1turmdwX0ZvyLKH2UnFtZl7TR1pemKNk0wI07HeQiQcFDn/mvtyLrn989qufYpalca89ZF/5zasYBO8ekCHZdnaKxjHe0LzcnAqnilhTc1TUHCtRNItguF33OtcpzJOe6D4tugc1RgfLIyexlVg9j0gnoiZpKXcttW7kYpgDkoYDPFrHmkApVXoeRfKMNj5WXJgmv+NaLvoEKgoz673kLwXdeRQzovCiqXzA5T9U5fy4CEsiuapPYTnflO/f+nB9leA3RCkpRLf5EsWwQY8Bo8IdP8ahqGcem9oBLmn1wBdZVlfzAlKt+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdac/UCXocHx3pdaUzC4WkEGhNRpClM39M6cS1mCvUA=;
 b=mLRuq/SlxYFdUD5rc2nmuT6buswvbv4SzQCXw5Maj7MWiXXOIOZa+W71ZD152I0yZZO9HxDEjqIpBxCkduSBYWkhjIXuVpix3NDUgWoNzV6Ap7DtKwEze2R8IYAwb1Ql8iPqvnS1AxkHY7Vro7VMbvk6rQAvg0BXAAx/P+0/Vzgk2M+DYqLnsQevEyoU4jGeGr89sOC4Eg2yD1+qim/hvYbCM51QOA2xI/jfWV2a3biQD+62m4R4cgsXpdTYOn+qRStsfLAEo1ZYKYKImxp+FZu1sAs5sYETfLXOSBFGD5djipIx0A4r9XYGNeJxM/Ih05hlyQSW5oYPIr9aPrLUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com (2603:1096:604:3a3::6)
 by TYAPR01MB5402.jpnprd01.prod.outlook.com (2603:1096:404:8042::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 05:34:27 +0000
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0]) by OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 05:34:27 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>, "Koralahalli Channabasappa,
 Smita" <Smita.KoralahalliChannabasappa@amd.com>, "Bowman, Terry"
	<terry.bowman@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, Robert Richter
	<rrichter@amd.com>, Gregory Price <gourry@gourry.net>, Fan Ni
	<fan.ni@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] CXL/ACPI: Remove overlapping Soft Reserved regions before
 adding CFMW resources
Thread-Topic: [RFC] CXL/ACPI: Remove overlapping Soft Reserved regions before
 adding CFMW resources
Thread-Index: AQHb8UKVhtYBJRdLLUKQA3EsUkYqtLQr3QQAgACLZAA=
Date: Fri, 11 Jul 2025 05:34:27 +0000
Message-ID: <e545b630-1a89-40b1-996c-c843a9e8fad7@fujitsu.com>
References: <ad410c59-bf0f-47ae-aa65-c0d845e6f264@fujitsu.com>
 <2296acdf-de5d-4591-a165-d59f9f432dee@amd.com>
In-Reply-To: <2296acdf-de5d-4591-a165-d59f9f432dee@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14468:EE_|TYAPR01MB5402:EE_
x-ms-office365-filtering-correlation-id: fe054975-76e9-4c5d-484b-08ddc03c9a39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|1580799027|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0doMUY0b05zQWNxUUUvUzNyUUNRRlRFK0lFTXV3TTVhRlFvc2c4VzdaSlZj?=
 =?utf-8?B?OW5uT3llVmxrWmZaNnpabHR0cWZyaGF1ekwvek9uS09hMDRHZ2JxMG9FeXpY?=
 =?utf-8?B?bXovVGtPVHB3L0paeEd2MjRMUVdoeXF5R0pyWVE0T2M0VTBjZldwcmlzVDJZ?=
 =?utf-8?B?SjNkd2xyRzRaLy9qVjBCUmtBdzd1ZEEzc3JXalJobFgrcG5mQ2VHdWsyb0ho?=
 =?utf-8?B?eWZsbVBRMXJsWmVXcmNBYjlkTk9Vakw5eGt2M2xoTStaZXNMdXVlZ3R0b05H?=
 =?utf-8?B?ZU4ydzlUVGQwT2duOFArNjdDSkkrbFhnQVo0Z0tzSTFCSkY2dUZsdzRuYVJE?=
 =?utf-8?B?NGFudEpKc0NMWmwwYVVZS2VKazB3NHE0VlR2MUphNWEwNy9IbTYxdElMRnRU?=
 =?utf-8?B?WUtDZVNTOUgzbGpqNVQ1YmJ0T1U0V05HNmo3N3RhVENVb1Z6U2QxVDNRWjNL?=
 =?utf-8?B?WCtXb3hKUEc1UkJiSFZRYnJmWWJybTlOc096L084WHlYcUp3cW9MeFI0SjhS?=
 =?utf-8?B?S1FjSDRZVkI3NUdhQk14UmE4aXRNemhiODFUc0FnT2YwbDJoM3BqVTFIbGV0?=
 =?utf-8?B?VWhJSFhGOUxkc2hTVWZHZHN1cTFwNTd5OGZnKzlUYTNMNWZ0UGovQ05NSkZO?=
 =?utf-8?B?eWsyRUl6YUZIT3V2R0xwb3RkYkJ6bnVEZzJ1RnUzMGwxVWxQUlk4eTVmS0xz?=
 =?utf-8?B?YUh5bXdZSUUzQkhWSiswM2JTMElpZjFqUkN1ZlRjZzVzcVhmOUNyei9Bc2VZ?=
 =?utf-8?B?Rnk4b0w3SUJDWTFHZlo0RXhSd3ViUEJrb05HenpmQTZ0ZU93ZmFWWUpaS2NK?=
 =?utf-8?B?L3l1elp4ME54WUg0RFJ3bWh1UlNVOWZpdHZ3WGlHdkExaFp5aGNPSU5kUmht?=
 =?utf-8?B?RnVieGtsK1pyRWM2VVg5NkxhQWt6QkMyaUxVcWNCMFhIa091eE5jazZHS1Ar?=
 =?utf-8?B?cG1MS2NhM3NtSExNUGxIQ213cnd4bmZicU01UlQzZkdGbGJIbmUreTk5QUoz?=
 =?utf-8?B?djhwam1CcXNYS2F2RTFrNFlraHJpb3owZlNRYUUxZ2dlSWZYeUZxek9MWm5L?=
 =?utf-8?B?K1pIZzJRY0QxUU1FUXc2UDZDWm1wbDJSNU04N21jK0ZIaDRNMlArNUtWK01B?=
 =?utf-8?B?U2t3SUlMaXRYb2RYeDVocXZVYzE3WTlGdGJqTUFrNWxzdzg1UTQ1c3ZXWUlI?=
 =?utf-8?B?bTM1SEg4TFRMQ2c3Uzlvb2xBTlIxYjVUVm5ldHFoQnZsVmFNNkNGQWh0RVlm?=
 =?utf-8?B?dDJsTnhTaC96V2paTk5oSG92dWNmQ1pYMVMwT3VlVHdLTi9MZHhBay93UGZU?=
 =?utf-8?B?UjdFbTBmazFSWkQrMTNFRndoZ3dSWHllMWRuWm9RWDkyQXRtMU0rN0ZqSkRi?=
 =?utf-8?B?ejdOMEpaMWpHRVUxekV5cU1VWG0vT2sxdDhXL2MzS0dDUG9KcDYvNVQ4bzBF?=
 =?utf-8?B?UVFJSmJlcFdyVXRqQ3VmUzdxb3BtbDYveDdqZWZNaTFmVUVDZUIwbjg1b3oy?=
 =?utf-8?B?M3RmNmFhWkt6YVcweHdtN3pFN2RzUEIvOHJxb0dXZVI0WWtIL3JKR08vSGVp?=
 =?utf-8?B?d1dXeWRZVzFGblJSRUcwRVFtV3VGV3dIbmhMN3JML0xNUnF2T2RMNnJTSDM2?=
 =?utf-8?B?VEFQOVpKaWFRM2dWMk5ieHZzTEN5WWxHR1BTbUxmZ2JrQW01MlozNjBha0hp?=
 =?utf-8?B?bG9TQnlOM3hMNldQR1hkVWpaU3o2TzlCOUR5cjVPYW5uUncydnFrMEwrdkRZ?=
 =?utf-8?B?STJYc1BaeDFBMFd1cHFCNllpTVA0QTc3UkVuZ2ZiVGQrM2RtajNtRXQyQUJI?=
 =?utf-8?B?cXRPM3kvamxHQkJhZUwrOWtocVNNSXdZYzNQRE5PaWhHTmJmV04rczAyaXdR?=
 =?utf-8?B?d2VtKzJ3QVQ1S0tZUE1ETkRHTkt6K3FIeVRVTzgrRSt5NHFqaTQ5UUVJbUVF?=
 =?utf-8?B?WUxmeVRQaGRNdGJnNTk3ZVVKL0JKc1ZEQ2pqRXhDYzlZbFRtQkJhK1FQZ3JE?=
 =?utf-8?B?cHhtbGQ3c2ZqUG1BWFJkYVczTTlScVJDYkd3V0NRa1hNOERsV3RJbHNqNm5z?=
 =?utf-8?B?M1FDSlJ4Y05oWEVQVjFCeHZaZVV2bXQ2WE9EZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14468.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(1580799027)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGVsV3RZbDMxZ2gyWHZXaUE1c0JFY24zbnd3bVRnYzRtMmpkWTNXYkpPSy9h?=
 =?utf-8?B?OE9vaFZJeDRPNFFhYUZjdjBZeTIyWlhWRGNPNTNuYkQ0RERCRGJUdFVYM0wx?=
 =?utf-8?B?T3dpd1B1Y0ZGQU1mMmRGMTdOb01IMGxNdDd3bHk5QmMxeXhuVC84dW5HSnE3?=
 =?utf-8?B?czJNNUtjUzlTNlJEZkMxS1A5OGoxSzJCcE5rZFJTbE0wNjd2U0M3bzdYM2M1?=
 =?utf-8?B?dC83c1RYcVlzUzFHZUJZL29PL1BJcmo0dytLVGVUU0h6cnVMV3JMZWZzdmQ0?=
 =?utf-8?B?cVlsQitoYWZYTXpEaU1mYit1YjJFWkJRQnZmREZkQjNiSHY3VEtYTUM1MTJU?=
 =?utf-8?B?bjdiVmFnYTVIemxUeHMrZmk4RTVEMW9jRXNybVBBdjAvS29BbWNHNTd1cmdj?=
 =?utf-8?B?V0VrOHphamFjU2Q0bHlnb0xRbnlpQ1lZcVlac2I2clE4ZWVYcEltdldiME9Z?=
 =?utf-8?B?NmxGVVVhUFJrUnM5dGNDcjB2cUxtWEswTDF4TGdmaytuZ016YlRNNWxPbDA3?=
 =?utf-8?B?cTg2VFJQTWhzNEJ5M3RvYUt3WnhxZ2E2eHlaTGdObUFRSUoyTmJjNHoxVGNr?=
 =?utf-8?B?bUVZUldPKzZSUTdicWFDZjA4bHp0bjVJYUUrZlQ5WFRGN1I4RUV2cWpuMFJk?=
 =?utf-8?B?TzdnRlFheTJLNjM1OHZQVzNVMWRYYmtUUlA1UmVFbGNqWmdocC8zN0FmTFlz?=
 =?utf-8?B?cTQzRUgvOGFDbERzMk81ZEUzOHN3UDkrRVdQZVJ5SlN3R3NSK05KUFNYaGpt?=
 =?utf-8?B?M0F0bUNCMjk3b2Nyb1dUVzhNS3Z4eTZuK1ZCUW15ZkRTZ1hOVkVWTDNPVkt4?=
 =?utf-8?B?MWk5anpmY0ZMbUJPdExLeFhOMGtNb0tjM1NUWFNNWnMvVFZhVmJwTUtWUFdG?=
 =?utf-8?B?VzdYTnVNNTBWelF0NEVSUjlmUDJ2QXZtcDMraXJFYllMRExXNVMvRDhoMEdU?=
 =?utf-8?B?T2FwZU15NStDeFRhSVNJZjEzaERzelJ5VXNnVUxDWXdpaUM1c0VkTVVYSXA1?=
 =?utf-8?B?Mnp2aGFleDNibE54VHRZWTl6UisvN2Z0ZHVWK0pJRTZ2SVhQZmdpR0JyMVNO?=
 =?utf-8?B?cjN1YVVCOEZqRm9WVFFud1dWWncyZFRXbEN3L2xwQTZQTjN0MUYxRUNOS2ls?=
 =?utf-8?B?UzNGdUxpRnlSb2J0ZExLTU9kUjVpcWlVWkpFTXRXRFVsOHN0UVljekJtWk5m?=
 =?utf-8?B?bytnZlh1dFZjd0Q5c1lHbGFhSUtZTmNUaGlTaW12bGVqdkFQeEx4RlVBdzFT?=
 =?utf-8?B?N0ZxR0ZhWm14dldnd2dXaXJlOXhDdnV5T3EzRGJEVDlnMGhZRllHSzVCVXRM?=
 =?utf-8?B?OEtRcUJtMnNsekV0ZXFmdVNnU0RwVjE1UWRCYy8vTktmREFsdUxpTmt3R1FS?=
 =?utf-8?B?UEtrWEVjV0xqand0OFFIUHBnVWQ5Nkp0YnlVUml6NGwyQ3RrOVJYaFVYTERk?=
 =?utf-8?B?eXU4QzdoOWxZalRqY0pneGtRc2d1cGxodFFreHMxMWVMV2ttQnFyTmxPL3FE?=
 =?utf-8?B?UnMwZ1oyQ3oyeXRTeVdZdWVmNUh0UUg0TS9oeDRyTGVsakllSXdFT3FNcVpT?=
 =?utf-8?B?dTNScTU3SXBUeGJwYTVtY2ZKMU9lVWo1Y3VraFVmeEJrWU9ZV1pCcHdBNFVs?=
 =?utf-8?B?NDdhNVM2YWZQNGxnc2cwS0szK2MwdWs1c3FReWZxRS9vRjIyYU1FRVdzcmxX?=
 =?utf-8?B?T041S3lTMHdFUklDeXArU0k4TXpmM3phQlAyekUwSUUzVnNodlVqRjNKY0J4?=
 =?utf-8?B?eGFIWlBjUVBUSEVwTWpUNTBOcyt3WmhGMzRzK0M0QS9UOThKeTFQNHJrK1Vy?=
 =?utf-8?B?M0x6OXFLKzdGOHF4ZFVNeU9YakFrSXA0c2JIMzlvS3RON01wN09ZbkNZU0d1?=
 =?utf-8?B?WXNISzZVd2s5d3FoNThJTzZXR2tWOGVEZnI3a0pqa1VkMmxwOWFOa2NsYmhv?=
 =?utf-8?B?dDZEVFd6QXl2WTY5QmNIajZ3bU9LaklqZmxXellOMk03QmswR1pvNnFZTmhY?=
 =?utf-8?B?cTNOdkpZamxqbHJNUUl3VmNqNVk1VXBFeWF1ajVOSG4zWHB4Y2ppTWVaZEFh?=
 =?utf-8?B?cXRKemhYTTJRYUUrY2NrMzhTc0Q1OCtLSjB3MURGL3Nma244R3dHSzcxbmFk?=
 =?utf-8?B?MldPa1c3bll2bmthQzJ2RVloMUZhNHF5aDNkYjFramNRcW02LzhBWFB2Y25m?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAD3B132C4EE564C8FC7A550B3BDA8FD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lRbSbayL0BOsGo0v8+A8Hhi0Kiz50hrNnDmXw53K2MBf7I7UZ3k89h+7QRAkUNlIBd/XxUI578Wc2MHyYcD/IWTjWmbvh8A3yMkAsnbMxrfrJ7cGcnHNHQEXEIr2PALcE4PPWcJsXYI+FAmW2zMt8UNBtBXrCzHTPlQTpr2UGwzkoIM6Cv8G9VbJcpjacLm1skGt2g6qK46Clh2np2EGgwITtmo+ZpflypBbZwzZyHzOD+IsVM8Q4Q0C6UC71oLqGFCHIpqdmksjKAOgu9ADPvGEp01J+1k4ymn85C4stzri8z+bbxV896K1nEEvsrBFYSJ4SXQ99/MIl9KnRrtyPTiJ+7FdwpQrT+4uDUCZNvuUsSkfe63ax/cW3XEbJ2MW3prg0H8XPfbDWdWrF86Mxcl7SlKi21WWNvM7/vVc6y148AqYkjM/Lj69aoOX0QQgE9cInybIE818GHSGVRjb82NgfHOII2ydc4/7i8SKh3v6FjGKIin0a53Q9EWV0Gf/7EPPgqfc0oAMBDBtRxsolyrkFrqMlg5/IN8OqgRx6B8Cw+M3nRk9JWfbipBmOEYmhSTI6yt8OCQjPAqN65gcDAIKm27dck1P+AcimsqVFlFaMN9opPr8wWyBQFAd9xri
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14468.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe054975-76e9-4c5d-484b-08ddc03c9a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 05:34:27.4158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0txlrwqM/XtRkqdsmDrvud0HPtgQiikDSjkIKoEtZpAL51+2BpvEdAcHvFglNLJG9EbLEDaZuJZFS+jOohYiDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5402

DQoNCk9uIDExLzA3LzIwMjUgMDU6MTUsIE5hdGhhbiBGb250ZW5vdCB3cm90ZToNCj4+IE15IHBy
b3Bvc2FsIGlzIHRvIHJlbW92ZSB0aGUgIlNvZnQgUmVzZXJ2ZWQiIHJlc291cmNlIGF0IHRoZSBt
b21lbnQgd2UgYWRkIHRoZSByb290IGRlY29kZXIgcmVzb3VyY2UgKHRoZSBDRk1XKSBmcm9tIGBD
WExfQUNQSWAuDQo+IEEgY291cGxlIG9mIHRob3VnaHRzIG9uIHRoaXMgYXBwcm9hY2guDQo+IA0K
PiBJZiB0aGUgZGV2aWNlX2htZW0gZHJpdmVyIGxvYWRzIHByaW9yIHRvIHRoZSBjeGxfYWNwaSBk
cml2ZXIgdGhpcyBjb3VsZCBiZSBhbiBpc3N1ZS4gVGhlIGRldmljZQ0KPiBobWVtIGRyaXZlciBp
bml0IHJvdXRpbmUgbWFrZXMgYSBjb3B5IG9mIGFsbCBzb2Z0IHJlc2VydmUgcmVzb3VyY2VzIGlu
dG8gaG1lbV9hY3RpdmUuIEl0IGlzDQo+IHRoaXMgaG1lbV9hY3RpdmUgbGlzdCB0aGF0IGlzIHVz
ZWQgYnkgdGhlIGhtZW0gZHJpdmVyIHRvIGNyZWF0ZSBkYXggZGV2aWNlcywgdGhpcyBjb3VsZCBw
b3NzaWJseQ0KPiBjcmVhdGUgYSBkYXggZGV2aWNlIGZvciBhIHNvZnQgcmVzZXJ2ZSB0aGF0IG5v
IGxvbmdlciBleGlzdHMsIG9yIGhhcyBiZWVuIHNwbGl0IHVwLg0KPiANCj4gUGVyaGFwcyBtb3Zp
bmcgdGhlIE1PRFVMRV9TT0ZUREVQKCJwcmU6IGN4bF9hY3BpIikgZnJvbSBkYXgvaG1lbS9obWVt
LmMgdG8gZGF4L2htZW0vZGV2aWNlLmMNCj4gY291bGQgc29sdmUgdGhpcyB0byBlbnN1cmUgdGhl
IGN4bF9hY3BpIGNvZGUgcnVucyBwcmlvciB0byBidWlsZGluZyB0aGUgaG1lbV9hY3RpdmUgbGlz
dC4NCj4gDQo+IE9uZSBvdGhlciBhc3BlY3QgdGhhdCB0aGlzIGFwcHJvYWNoIHdvdWxkIHByZXZl
bnQgaXMgdGhlIGFiaWxpdHkgdG8gdXNlIHRoZSBtZW1vcnkgY292ZXJlZCBieQ0KPiBhIGN4bCBy
ZWdpb24gaWYgdGhlcmUgaXMgYW4gZXJyb3IgaW4gY3JlYXRpbmcgdGhhdCByZWdpb24uIA0KDQo+
IEluIHByZXZpb3VzIGFwcHJvYWNoZXMgZm9yIGluc3RhbmNlLA0KPiBpZiBkdXJpbmcgY3hsIHJl
Z2lvbiBkaXNjb3Zlcnkgd2UgZ2V0IGFuIGVycm9yIGFuZCBmYWlsIHRvIGNyZWF0ZSB0aGUgcmVn
aW9uLCB0aGUgc29mdCByZXNlcnZlDQo+IGludGVyc2VjdGluZyB0aGF0IGZhaWxlZCByZWdpb24g
d291bGQgc3RpbGwgZXhpc3QgYW5kIGJlIGF2YWlsYWJsZSBmb3IgdGhlIGRheCBkcml2ZXIgdG8g
Y29uc3VtZS4NCg0KSXQgc2VlbXMgdGhpcyBub3QgYWx3YXlzIHdvcmtzLg0KRm9yIGV4YW1wbGUs
IHdoZW4gdGhlcmUgaXMgYSBtaXNjb25maWd1cmVkIEhETSBkZWNvZGVyLCBzbyB0aGUgY3hsX3Jl
Z2lvbiB3aWxsIGJlIHJlZ2lzdGVyZWQoYnV0IG5vdCByZWFkaW5lc3MpLg0KSW4gdGhpcyBjYXNl
KHdpdGggeW91ciBWNCBwYXRjaCksIHdlIHdvdWxkIHNlZToNCmBgYA0KNWQwMDAwMDAwLTZjZmZm
ZmZmZiA6IENYTCBXaW5kb3cgMA0KICAgNWQwMDAwMDAwLTZjZmZmZmZmZiA6IHJlZ2lvbjANCmBg
YA0KQWN0dWFsbHksIGl0IGNhbm5vdCBiZSBjb25zdW1lZCBieSB0aGUgaG1lbS9kYXhfaG1lbSBu
ZWl0aGVyLg0KDQpUaGlzIG1hZGUgbWUgcmVhbGl6ZSB0aGF0IG15IGN1cnJlbnQgaWRlYSBpZ25v
cmVzIHRoZSBjYXNlIG9mIENYTF9BQ1BJPXkgJiYgQ1hMX1JFR0lPTj1uLiBJIHF1aWNrbHkgdGVz
dGVkIGl0KEkgd2lsbCB0YWtlIGEgZGVlcGVyIGxvb2sgbGF0ZXIpOg0KDQpBZnRlciB0aGUgT1Mg
Ym9vdHMsIHdlIGNhbiBzZWUgdGhpcyByZXNvdXJjZS4gQ2FuIGFueW9uZSB0ZWxsIG1lIGhvdyB0
byBjcmVhdGUgdGhlIGNvcnJlc3BvbmRpbmcgZGF4X3JlZ2lvbj8gQmVjYXVzZSBJIHRyaWVkIHVz
aW5nIGRheCBjcmVhdGUtZGV2aWNlIHdpdGhvdXQgc3VjY2Vzcy4NCmBgYA0KNWQwMDAwMDAwLTZj
ZmZmZmZmZiA6IENYTCBXaW5kb3cgMA0KICAgNWQwMDAwMDAwLTZjZmZmZmZmZiA6IFNvZnQgUmVz
ZXJ2ZWQNCmBgYA0KDQpUaGFua3MNClpoaWppYW4=
