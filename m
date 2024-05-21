Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6A179BD;
	Tue, 21 May 2024 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276436; cv=fail; b=DjaTuoFA4Qgiq8FbQ0lWnz2daZfLMTrfHlWdb/CY+wDr8Bpfud1bLz4Y1qLfBZeqKPJuz8D8CHt6cMyu8haTJdRVmX7Z0AwYU1JRYt3rTi6idWaUz2O8Kn4tDyN+Fz33YTv3nQuBip0IY1HrKx58CbU/mS+ZS0J6btfCaSrhlxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276436; c=relaxed/simple;
	bh=BeQrBnssCrkW5vDCY3+K7acBZGBcQV7gJv4sZCPM4b4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y3749wl8JBsLSXO/fJWo2AUJsbf9toIAJsD4GbklPL/CECFbS2HvilVHc+y+llB9Lz2oy6UxPvMIOGT0YmzCQSUWKZFWqUrVLeEeEofRnfIenFcIbObArDr9NR4OmNr5L8kp31i7lP+7QMae8fEq5ERvGQFhwx6QZALWk+a/SN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bp7e4T6+; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bp7e4T6+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1716276435; x=1747812435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BeQrBnssCrkW5vDCY3+K7acBZGBcQV7gJv4sZCPM4b4=;
  b=bp7e4T6+LT+8bgLF3kCDJEYqWl2MhS3QhCJQM7qb9zU2t69RkMDN7Lp2
   njyLF8KQA6jhxpL2hk3p3cxmVzBvSAeaLwrfDPNMkHveEPaijc5akggB5
   2XF1Evrdvf0pVzwgBb08og/hVzhK8NQU9gT9FpJ+fE0F/4km/T4ZPiaGX
   ZfWi/cO86muNnJadhyVMQOZIaaI3sSgYQzRc8s+5ep3vJcCbthztjiOic
   kC/rppEIXoBaDiUV33GvI2dSXRclfTqINhmJ9BWXUGRh1/3BtRJzGdm5C
   TD5VI048agH4d7Xlpy5hd30YQXs2QLoKfzG6jxOqeWRSSKQUW3Vi2IM2f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="119556709"
X-IronPort-AV: E=Sophos;i="6.08,177,1712588400"; 
   d="scan'208";a="119556709"
Received: from mail-japanwestazlp17011004.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 16:26:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGZ98Y8+A6gTCs91bO78QtkqpcM3RJCUhdJTXIEd/q4AVzUAJ882QNTcNVZr+cD3kn8P2ozVQHmjwKjcsIA0XHoocIhGZFtqPZE3Nxuvo1M/8AP/2cRux9MjHNa8kKBBHk5WfxI39OydgljU2H2FJ6/lAJ00wgXTSgMj1GFBiZhd9UV0M78LN2AMA2+daCSwRbuqqMV0AokTeZn6s8AHj/8W5399U9l77+qmBXsEXNy68l6aNOHEwHteiWd0lId37jK9p0/m5G1pVnLtDx+TF4wTnycf29jjFaaAAoakneonVWHLeCOuvmcdMzElDeykia7bw7YVzFqYAREz6gbFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeQrBnssCrkW5vDCY3+K7acBZGBcQV7gJv4sZCPM4b4=;
 b=mNJc2mklLBUFXHSyG+uM/1IQvRCMd9na2c4YWUurPmPdC5o6QGw8oG+h3gVGIVj7UxPtE1wUhh6uu9zSq8BrdbybJw/YwZ2aEmKMEu35Ly2V5NXy0onVhqZZQlD7erK0IM1Hr6AhtoOmOD/5loAQmhCPICf6gd+3/ZeTfXQfnRPZA2zq7J2ybnD40O0r46iUk+jjGVZFYNuoDtc77OJIyy0KCXsD8gg1P/th1VVO4wnBSA40l1wmNhdG+huu1XJp2GzMJgrHOndfx3ug2/5tn1HJPVWQ9X7gdfY5+0K8SIeEMTF8LVoSbGlkCqZkDI5Zjc4GurHHbVvRGqMZ5Hdtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com (2603:1096:403:11::17)
 by OS3PR01MB5976.jpnprd01.prod.outlook.com (2603:1096:604:d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 07:25:55 +0000
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14]) by TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 07:25:55 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Fix memregion leaks in
 devm_cxl_add_region()
Thread-Topic: [PATCH v2] cxl/region: Fix memregion leaks in
 devm_cxl_add_region()
Thread-Index: AQHaoEA8kfvygwx0pUalpY92klfrwLGhX7mA
Date: Tue, 21 May 2024 07:25:55 +0000
Message-ID: <b63a1690-0bdf-41e8-ad20-d97d0132b187@fujitsu.com>
References: <20240507053421.456439-1-lizhijian@fujitsu.com>
In-Reply-To: <20240507053421.456439-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1566:EE_|OS3PR01MB5976:EE_
x-ms-office365-filtering-correlation-id: 4ea67ef1-93c5-4df9-111e-08dc7967408b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGxNaThCZ1k2eUMwTWZ2aHI4MnhoV1hBVUdOWnQ5bWZXT3ZsLzh3WFMrc1Fn?=
 =?utf-8?B?SkI4OXp1OHh1MzgycllvOFBaZFVNNjVQMTlpd2NEMGFubkVJbncwNkZUd3JF?=
 =?utf-8?B?Q3Q0UnMwMkVFbDhnNUlIN2x2VUZIZWdrMzdxNXNNNnJ1VW9oZ09xSG1DVUNY?=
 =?utf-8?B?NWxTa1d3TGRka21KVis0STg5bGVZUW5kaWdOVUVkNnBBSnd2L2RDYkl5Ymlu?=
 =?utf-8?B?WkVqZ3dwdnd6elpaRmEvdTBSWkxUS2xpS1pmMHZiUG0vNXM5c1J5a2owOStR?=
 =?utf-8?B?R2FVczhvKzlYa2IzTWpBTUo1VGsvejBuZVh6SmtuR3lvSGNhdzlLNjllN25Q?=
 =?utf-8?B?bjdjUXdzaWp3NHRiS1JCOGY0enRDeEl4YW5uRFpvcTFqeFNVYlhGODFUNWM4?=
 =?utf-8?B?aWdJVTY4SzhBQThmM1grTUVCYmpoVUREYVRRZ2hTbVpRKzVhV2NWeUlKWlE1?=
 =?utf-8?B?cmdKdFVucWk4QUhyb0tQcGZabTdmMmNuWG9XODl1MGZPVC9Na09rVnhZRCta?=
 =?utf-8?B?aEo5T0VaNHRmOUFVank1Ry82bEk0aWh0S1RzaTNXaXpUWTZNL2VERTNwNTVk?=
 =?utf-8?B?MlM1Y3dUUmt5R1o5QlQwQUNCdkNIUTk1VUdKZ1JidzkwMkQ2amZDYkNjcFdW?=
 =?utf-8?B?L2FFZS84amdaWUFMK1V6akpKQy9sd1ZxNitvb2dldnZ1aFp0RENNU0R6eTV5?=
 =?utf-8?B?dFpobndHc0I0UldOWTFBY2R4MjhhME9ldHBlQ2tsZ3dnRCt5cVl1UzlxclU3?=
 =?utf-8?B?bWlvUks0VDQ3UWYrQzNKbFFOUHhRNFByYXdVNUp0Ymw2MzZRaGloTlJPSW5Q?=
 =?utf-8?B?WExBV05EZXdRK2dEQXpRYS9FVkFVNDgrbDMxa2JaSjRYSTBiS0hzZnUvL1cx?=
 =?utf-8?B?Y2s4STFqR0JTbUtLNTlKeGRJbnE0bUpkU1BHbVVjNGdrbm0rRzk4YnNibTF3?=
 =?utf-8?B?TGNyRkFvMkFQdlA2WmZxYzEvaE16dDZ0YWxaK05VWGpzcTFjckpOWHRUS2lL?=
 =?utf-8?B?YkhwTCtGSEZtQzhZNzJ2QjNDVWJxYTErTFlPMElLWEY5aXNYN3VqYjdNVGlG?=
 =?utf-8?B?T2FsRFRraERlTy80UG5hZG80b0pTeFEzemxEVWFCeStucC93M3J2N0lTb1lS?=
 =?utf-8?B?NG9RTHJ2eE5DNHRuUFViZGdjQXFha3Q1Lzd1WTZpQWs4Ylk1d3pkN3FjV1B0?=
 =?utf-8?B?OTEzQUpCK1BvZWRGQnVPL0pSQ2Z1cEtLak05VEc1eTVCQlF2NlN4Q3JjRzR6?=
 =?utf-8?B?MUFMUU9TM1JId1o1aUdaUnpsd0F3aHQ3MmtRVGllTENrTWYzKzdHd05YQTgy?=
 =?utf-8?B?TmpsR0ZDT1BOT1NCMTRpTXhZanV1OExYMWlZMlN6ZXh5U2F6eGxJT1hNdWs0?=
 =?utf-8?B?YXFnQWRsNGJVYmRIeHRoNG1FSVVTVmVMTER5MXdHMVdrWEd2N1NBcnVMY3hz?=
 =?utf-8?B?cStSaDhlN1d5eUpuWkRMRkFKTGxBUUl1aDM0ZnA5TThiTkZ6a0dNZ3MrRDY0?=
 =?utf-8?B?THI5Yyt5cFlScmpHdHkzR2lGOTIvdERwbEZTa1ZnWW15cVozVWtGalpmYW5T?=
 =?utf-8?B?cmd1b0dMNnU3T3F4UFAwN0dBOThiNGI5QnJnb3UxZUo1c0dpVk5taDFEOEpV?=
 =?utf-8?B?K3IxcHJjdDVrc0krMjhIUC9ON21YNjRiSVc4MEI3dGV3N3RYSHNVeVZmQ0FM?=
 =?utf-8?B?bmlNTk5PU3I5djhmOUdxNE9FY2JGcGhyMGlQQyt1U0xIdzhyUXF6OTBmQ2M3?=
 =?utf-8?B?ZWtURGYwamNGQkpwTW0wdTE1eDZoUU9qeXVFTlh5RnZKUWllWEdxOHhsY3BJ?=
 =?utf-8?Q?0c0xzCGydwOXj+O7Jo8Pbgdye6d1N1YCnpI9Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1566.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEMyUGZ4TEFsRDRLNVdtSWd5anY5WGVublNQbGxnVGVSaG1PeXhFWEcvVmor?=
 =?utf-8?B?OVk1NUNWUXJONjJZMU1TYU8zY0RrR3Z2YkkrMDNCZ3RNV1FaYVpUR3IySFZ3?=
 =?utf-8?B?MEk4NXpIV1grM1RCMjgzQ3ppQ2tFWEkyaURFQ0Q1bGdDVFNwanZDR0dLSHRL?=
 =?utf-8?B?QURXc3Rrb0ZFV3A1b253WkhWVEdVZjloYnl1bVFJN0l3WDRQR1BHVFdaclVi?=
 =?utf-8?B?UTN0cU1YZGl1bU9BZmRFMlVCdE9UNWZRYy9zTjlxMkx5Y1lXZ1ZrWHYwWERw?=
 =?utf-8?B?T0NHWHNMRXdTVVROTjZlWklXWDlzbXFaZVRTUWlxMHhoWU9La1VaQldaMFd3?=
 =?utf-8?B?TTNCRzArM1FXY0xZQzFXbEdWS2hJN013U3piMEJVSXYvZG9XZjFEMmdUT3hy?=
 =?utf-8?B?Z1lEL3pFdW1sdWEwbWt3WjZaNmNrVmFtYm84OVVCdnJwakJRdEt4b0JDR3BV?=
 =?utf-8?B?UEhOMnZ0clJCdDFSMmoyQkpoZ25sV1ZNOUs1MWoxSStZcXYxeGZXR1hnRTh3?=
 =?utf-8?B?MEVGaTFtWGJ5eHAvYUszdXlLemRJK25HUmI0T2VYOVJCdkU1M1J2QXVyY2F2?=
 =?utf-8?B?ZUgxS3VyQkViRU5DYmRYZTV0WlZaN1JLSEtOTGFZeTc3SlBYYWx3S3p2TjFn?=
 =?utf-8?B?MDhhajRZZTNsNzZKL25yRlQvRVl4anJ6bHo1N203dGJBaXBPK1ZIeTdyZ2x6?=
 =?utf-8?B?WGNhOVVoaHduTUQrQ0wwWnV5b2hOeUVvUkpVdXVNV2pJdHhNcDZHdFRFME82?=
 =?utf-8?B?ajdWZ0hhMWx0ME9RVGFlcGFoWlZTZ0N3bzRDcm45eWh5aE5SeVJuMWtvOW1o?=
 =?utf-8?B?ZlF3T041TS9QK2xtNEIwY0ZzS2E3OVF2Y25TaXdlQ2dDUDBad2g2S3VNVkNt?=
 =?utf-8?B?RGZRQjN2SllIdUdCN0NRcnFEWWR1eXhGdEFtU01UZFNzZFhMM05lS2pmR2cr?=
 =?utf-8?B?cE1pYjJxbzlEbXVtdS9pQ3FKaWVncDZhUGo2RCtsVGJMMVpzNFZqTlBsNC92?=
 =?utf-8?B?eUkrWFFlT1MxaUJDWDlMQnY2cW45UHpnQzh3bUYzUDZIVlRuQkVobkxISm9r?=
 =?utf-8?B?b2lTcnNPUkxvYjNrb2o2N2JOZjRma1YvenkzN0ZRUjZ3ajYrdWowZXA0QTBZ?=
 =?utf-8?B?MDRFR1pTenlVRUdvV2orK2IyZFEwa3BETlVpcHlGbk96cnZ4eElJcEZqeTR0?=
 =?utf-8?B?d2JKTFRmczFjYlBnVnp0YlZkVHpqVDY3YkRqWXNXaEVSWjZDOWRLRVNNaHB1?=
 =?utf-8?B?WDZIdHBIWWxSaTdvT21MbStVVDh5RUJNSG9vTGt1eVpod3lNRkJyODhKWkk4?=
 =?utf-8?B?NGgyNjBWMHZjbWU3ZDJlNmhyN2xlRVh6M0EzUE9YRE9UaUhZV21ZWXo1bjlz?=
 =?utf-8?B?R0VpMmZxSnZSUEtpME0rcXJRcVFSNnZGQUEzc1IxRklRVldNSkZIV2RiM09L?=
 =?utf-8?B?L1dYWGlEbmUxenhHZTdHSnI1OGRJUzB3UWthTlFDeEEyRWwxZ29mTnZPdXhF?=
 =?utf-8?B?TnVFa1M3bFk0WkpscHBkaTUzWHRieXdFY0lMdVd2OFhQVXppb1JhV1Uxb2Fl?=
 =?utf-8?B?Nm9rTXFiNjJpb0hFZk03amU5aGJzRVBQWXE2anhIRXppTklzQXEvVDZ1cDFE?=
 =?utf-8?B?ZWpQWTRnejBtMDFGaUZoS09BUS9ObVdaRzVMSGQ2TVZUSFUrd1ZFNTRvY0Za?=
 =?utf-8?B?YitlOVZSMXVQaEhPcENtWXN1Z3U3TXoxRE51U2ljcnVQQUxFamIrcXl0eFdt?=
 =?utf-8?B?alNXeVJ1QW1PNExnaFJhcDczNzdTaHB2QjA0WlRySWhTa2JCUy82TytCOXhU?=
 =?utf-8?B?TXc2Q21BUmpEZlgzVVN4V0JSOHZlaXpJOFk0OUs3Q05yN1B3cDJpRHdvbkpR?=
 =?utf-8?B?ZFZFN3BsdzduVnpZOE9vZlFDVFFDREpjeStQbldwNlpYQWUrMnZ6ZExDMjFV?=
 =?utf-8?B?MHZwNkxyUDJPQit4TnRkNHQ0T2dNV2srUld1RXVMTFJienhhNlhvUnY3cExU?=
 =?utf-8?B?Y3VtWWNEUkpaa2t4SFo5VUxXVEFIcitaSHdvUFBvSkZzdzEwMzlUQjYzMlIx?=
 =?utf-8?B?VG9Yak9URDZaNzJBZkw5YXpqMjZZTFFCMU8zdVJuSzlNZ0YzNm8ybkRXVUUr?=
 =?utf-8?B?K3hlTkRUdElodXZ5SnNSbi9WU3dZdXNSSVk5KzlDYTNFSDViUU5vMHZZSjhN?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1025AB77D07B3642869F2D28C825EF9F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ts5bTihmKcYkfuJIqcmHG0NnP6LyOjIpZ0yTjGgM//VMKcNtVNtye/kAoGPMnzTO/LuyxjrO9/m1kh8Z6sfUTnPW9JTbxPHFVS1VGdlUc8n/9Sxurho2o+ZdhZrlKS/An+juv/5g2Z+xkICQxFKPYee6Mxzl8+2EZEs5NL1ePl7hbiWj8uVpu9GWNQwb0TfOTYyjC9cAu4fR3ZGeALjXot/EHLNo5h2MubvskqYp7EfPNvZ6FrDZPCoRUtJNisZ6WB3mEs1f/zcgYQcao0srXu5J1x9mYyNmbOIIQrLCiqqsEaw+x7MEp5XWPZZJL4Oao0mzglZnzzsRooUCGc6SEZ8jor+f7Su9IGC2QezS1qVkW4egIojAAOKp3DNlgoyV9Pk+C+PHdsZ2gO8MbjscapVBtdspm8rb3GR80/Z1N0btB1RlS0LcWAgD6/I8iThdZ4cLsfMqQBXr0AFnRP5NtINiq1TvgCAbUnlYE7oKzk99Z+FORJiYpyR9GCog+v7UpfjGma9IDKtr2zoNneQ748yYPUWNklv4LgPVvnzC9ZEKh7R0WgysLHcRLO96bd3tBhtbp7pIGnhOcNIRruCN09/WeFZzNLVk4Uq0lMv+qRVIacifbEdhS4kswTYnq9VK
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1566.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea67ef1-93c5-4df9-111e-08dc7967408b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:25:55.0767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cGrEfjmW7LHeMB50oLIbX5++j1nQiN6W9TmRRja47IsFsQaFC8sinfwb8BD9gigkzX2EOC3hLUpfW4VsswYyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5976

cGluZw0KDQoNCk9uIDA3LzA1LzIwMjQgMTM6MzQsIExpIFpoaWppYW4gd3JvdGU6DQo+IE1vdmUg
dGhlIG1vZGUgdmVyaWZpY2F0aW9uIHRvIF9fY3JlYXRlX3JlZ2lvbigpIGJlZm9yZSBhbGxvY2F0
aW5nIHRoZQ0KPiBtZW1yZWdpb24gdG8gYXZvaWQgdGhlIG1lbXJlZ2lvbiBsZWFrcy4NCj4gDQo+
IEZpeGVzOiA2ZTA5OTI2NDE4NWQgKCJjeGwvcmVnaW9uOiBBZGQgdm9sYXRpbGUgcmVnaW9uIGNy
ZWF0aW9uIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5A
ZnVqaXRzdS5jb20+DQo+IC0tLQ0KPiBWMjogTW92ZSB0aGUgbW9kZSB2ZXJpZmljYXRpb24gdG8g
X19jcmVhdGVfcmVnaW9uKCkgIyBEYW4NCj4gLS0tDQo+ICAgZHJpdmVycy9jeGwvY29yZS9yZWdp
b24uYyB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwv
Y29yZS9yZWdpb24uYyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gaW5kZXggODEyYjI5
NDhiNmM2Li4xOGI5NTE0OTY0MGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvcmVn
aW9uLmMNCj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiBAQCAtMjM1MiwxNSAr
MjM1Miw2IEBAIHN0YXRpYyBzdHJ1Y3QgY3hsX3JlZ2lvbiAqZGV2bV9jeGxfYWRkX3JlZ2lvbihz
dHJ1Y3QgY3hsX3Jvb3RfZGVjb2RlciAqY3hscmQsDQo+ICAgCXN0cnVjdCBkZXZpY2UgKmRldjsN
Cj4gICAJaW50IHJjOw0KPiAgIA0KPiAtCXN3aXRjaCAobW9kZSkgew0KPiAtCWNhc2UgQ1hMX0RF
Q09ERVJfUkFNOg0KPiAtCWNhc2UgQ1hMX0RFQ09ERVJfUE1FTToNCj4gLQkJYnJlYWs7DQo+IC0J
ZGVmYXVsdDoNCj4gLQkJZGV2X2VycigmY3hscmQtPmN4bHNkLmN4bGQuZGV2LCAidW5zdXBwb3J0
ZWQgbW9kZSAlZFxuIiwgbW9kZSk7DQo+IC0JCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiAt
CX0NCj4gLQ0KPiAgIAljeGxyID0gY3hsX3JlZ2lvbl9hbGxvYyhjeGxyZCwgaWQpOw0KPiAgIAlp
ZiAoSVNfRVJSKGN4bHIpKQ0KPiAgIAkJcmV0dXJuIGN4bHI7DQo+IEBAIC0yNDE1LDYgKzI0MDYs
MTUgQEAgc3RhdGljIHN0cnVjdCBjeGxfcmVnaW9uICpfX2NyZWF0ZV9yZWdpb24oc3RydWN0IGN4
bF9yb290X2RlY29kZXIgKmN4bHJkLA0KPiAgIHsNCj4gICAJaW50IHJjOw0KPiAgIA0KPiArCXN3
aXRjaCAobW9kZSkgew0KPiArCWNhc2UgQ1hMX0RFQ09ERVJfUkFNOg0KPiArCWNhc2UgQ1hMX0RF
Q09ERVJfUE1FTToNCj4gKwkJYnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJZGV2X2VycigmY3hs
cmQtPmN4bHNkLmN4bGQuZGV2LCAidW5zdXBwb3J0ZWQgbW9kZSAlZFxuIiwgbW9kZSk7DQo+ICsJ
CXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiArCX0NCj4gKw0KPiAgIAlyYyA9IG1lbXJlZ2lv
bl9hbGxvYyhHRlBfS0VSTkVMKTsNCj4gICAJaWYgKHJjIDwgMCkNCj4gICAJCXJldHVybiBFUlJf
UFRSKHJjKTs=
