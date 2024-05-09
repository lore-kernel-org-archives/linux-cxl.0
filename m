Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9597624
	for <linux-cxl@vger.kernel.org>; Thu,  9 May 2024 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715238329; cv=fail; b=G+sYWZW7riOKcz1Rl6mREiFU3UTymc5b0QFDy7mmSB98F5H/iNBIDULZVxOF9EwADgH+K0LFZ3MNxAsIIlmDrJ5eQPaqm9PEUAnqxWFggPdyj549vWZQv76P4cW83J15bEb631df48uKWl48GEOKWIIEwNBQpol2yZ2R9t6QzT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715238329; c=relaxed/simple;
	bh=727g1iK80HXD7PMRuIYKbPwLkgL3d4QZB3+yvfZkxsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tQ5/1hWdUVzCA4Xq/zPz8JFoLE8KR6slGVzLbVQw6CQ1sxaLXdyTcn3B6HNPhGlqSrfBxyIGwL09IarYokx1j1InNcTXoHHmsJfjeoH1NZXoQKYtziZV7aNg7QtEJjtX9jlXXOBSTZNaC9Z0dkVJM0wDRaep2/E1GKlk+L5RbhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=f5hPrneW; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="f5hPrneW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715238327; x=1746774327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=727g1iK80HXD7PMRuIYKbPwLkgL3d4QZB3+yvfZkxsI=;
  b=f5hPrneWItVX2FGXCoYJpWzjAbnQWJ3pKdL6ZaKYRXgccww3phUsqQxA
   iLbiqJpvWopoyCwWDwtPeXIet3+mXyLW//057o+vOF0f2bVEag/ZJYFZy
   WVL9Rv/9+18A6PSPYFwFHoFPvxTnJFKJptuNATNUyJw8ny3cb8jSyHMGY
   TJJu6JUClVLH6H3ORUWOqlzrROmQxLHxM3RDlNelGgXUvBGcblZe+wYvu
   mc5AbPCqnr9AeTUSOhtIhliDVtdAtWmHmS7Nwvd3JTd+xm+G7/6mNMLQJ
   a7zpMtbuZu1GoaUfGRTjfq3zZR/gXQiwfHaabq7GCVv+ZEf87h8Lgiy27
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="123438006"
X-IronPort-AV: E=Sophos;i="6.08,147,1712588400"; 
   d="scan'208";a="123438006"
Received: from mail-japanwestazlp17011004.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 16:04:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSIsLMx+jLv6ZhI7jDWmwnEwLEQ3sN8PNf7Z9GIqSD3Gg9rYmrhsck8wHGpyqskywR6eFOPySnqYeYAoQvify60/1pSZ7B4SM5ngZ/AlHb4CKwnVamz5tJrypZaYOy3p1RqB46GWNjzqi20y/nD1whnGFh3o2WxkpivF41syHpf0jaZqPAkm4bq+WsoY/aRVzs+mo3H7hrgoCMoB2qrPRemxqM3GhlnlXfSJdQWkadyN4LnHcRouRn9ZDeK5X1GGkTnIPVJaL/mAqbqKdTfe08GNuC6QKyLZh1PdcbxATcHZuAg3RsYsfqQQrS/jFoY0dEfh1kwCCeOCIymdr+ZwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=727g1iK80HXD7PMRuIYKbPwLkgL3d4QZB3+yvfZkxsI=;
 b=WzSXk/ZQ/57Dp0ahTqExx+GY32eTnP5fG68KpxhaC53wzAbygJgmYcLBWCiK3ViNN+KCbZP9tjBppyg+OJ673YTEcDQE+R9iUGXp7D70T5CkFzQJFLbFzcGOcF8MWJSVX6amVVIFhgqQtdpUHUj84PyzCxouxBczBtL7jYQcNkxU/FJdSbYbapr9cjvSRoxHE35qohBgwtzJSBEDCIuWST3R02Xu+6aIggcZicHN2T5mE8lf+IbqENEaHs6EQ2lIjzyHxi1kQzbnC5XTzbf/Oih/y9qvBbIqEQuyoBAle5N8Mbra8lts/6uf4n3b8eg4fk6mEVkglODExkzGDIGi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB6582.jpnprd01.prod.outlook.com (2603:1096:604:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 07:04:09 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 07:04:09 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Convert cxl_pmem_region_alloc to scope-based
 resource management
Thread-Topic: [PATCH] cxl/region: Convert cxl_pmem_region_alloc to scope-based
 resource management
Thread-Index: AQHam0mf12draSMfUEeMEqfcvMd0C7GOh5eA
Date: Thu, 9 May 2024 07:04:09 +0000
Message-ID: <90342f2f-48ab-4f45-a63b-b75e024d5aa7@fujitsu.com>
References:
 <171451430965.1147997.15782562063090960666.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To:
 <171451430965.1147997.15782562063090960666.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB6582:EE_
x-ms-office365-filtering-correlation-id: 33f5aa0d-b367-4c68-246c-08dc6ff63928
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|366007|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1BJRG4vZG9kdU03aXRqQWdqZEcrTW1lc3pDbVcvT2ZZaTlpZ3dLZUtZTEN1?=
 =?utf-8?B?ZzhQaDdBenprV0ZyMHFOWVM4VlEzdDFtY2FxSkQwaTIvcEkwQ1RHMGEvYUhj?=
 =?utf-8?B?L1JiNE14U3pHdmZRTGJ0ZzVXQlZwcUdpRWp3S280WG4vS2poakV6K3hmL045?=
 =?utf-8?B?ZVgrZ1VtVHhMbXNEYkdWZjJSMXhicUEwc01sRWxWYzdWK2RSKy94dlZGWjFZ?=
 =?utf-8?B?bGNISlIzVEMwNURBUUdqeExrcENRdnNic0tiY1BrajZWbjdESitSaXhmQmpK?=
 =?utf-8?B?MjFlZFhDeThBTUhBU3MyeHFmZXV4MW5JaEdDdy8wRlp2dkZPUmVTeTNMcWpQ?=
 =?utf-8?B?N0p1TmUybVZCYkU4a0RCL3dtdkR1RWZ2OTEwbVFyL0dZbk1zT0pxb3cyR3Fx?=
 =?utf-8?B?S0FMTU44MElEaUozZW5HbU1EcmNxR3FFbVZBWjJqN0hLUGhmcTNIVHlUYUlG?=
 =?utf-8?B?dEVTZHl2L1BZamhjNVpEWXdpV1M4OGtQZG13bytYc1ljL1Ewb1JuRzlScER5?=
 =?utf-8?B?R25FYStuUVhnTVVHTkxZbmhyR0NJZDB0TmNGV2JnSVVuSzdBSzFJUFVxbUhC?=
 =?utf-8?B?cVRZb1JHd0Z6bFNLRllQaGV3SmFWYzZwM3cwSE9sTEZhOGx2Wm5ZNlVYMXJm?=
 =?utf-8?B?Ti9kRzhaeUZBalFiTVZsaXphM2JWenI3WGZwaDVycmZ0aElLME43Y0JxWmIz?=
 =?utf-8?B?Yi9BSXB4c2l6QnR1ckEydTlSUTFadFdQMjlUVnZsYVBDajJDSEJ4RnhvV0dF?=
 =?utf-8?B?bXdyVFFoNWdRUHJ0MUNoUGp4dGFHQUlnUlJwZjRxbkZ0TjlQSjk0M2FjK0pC?=
 =?utf-8?B?VHdEMVJwa0hoNExzYjRGNXdQd21ZYlBYNjRtYzNKd29rVk9JSUVuV3hudklG?=
 =?utf-8?B?aWZMaHhzdEliV0F6ZlFTRGhLd1E2ajNXTlV4TWdremdEYVFiaVlnWkNFTS9G?=
 =?utf-8?B?VUJUNjh1Wk5FQmgzMnBSaGJSMmFEeXdYd1U3RzFheTV4S1pLbEVNSTRDU0U1?=
 =?utf-8?B?RGltcGgzc2FNWlFQTFo0T0pHWWptZ0JMek8yd1o4ZkRxNnR4UlVTQkwzNWZZ?=
 =?utf-8?B?dXZJQ29YRXA2TnR6TDkvaFBUL2FlQm90MWIwNDgxRlE2Vk52YzQvVStPdi9B?=
 =?utf-8?B?cGpjL3FtMlpzbFdhTk1SVzBoUDBWVVN6dWpBcVJtMml0bFV6T2kvL1dkRXJ4?=
 =?utf-8?B?UEQ4bUdpWWZQRi9wL081ckUvLy9LV3VEdUxPTzJqYzJQRHhXN29YL1VkZUdD?=
 =?utf-8?B?S3VLV3YrVFFuQjhhdG0xVWN3WmFsZ1BiVkUvaWVTbHdYeWhsbFB2TTJrai8y?=
 =?utf-8?B?bTdWZ3ErTmJnSWlOaFNqT2xLLyt6ek02ZDF3dU85VVdSejdBV1NudnhqZXJt?=
 =?utf-8?B?ckpsU05Ta0U0L0R2RGo1aWFrSFU3N1B1STVhTmxpTmdnb1J4QVJJNzk5ZWxD?=
 =?utf-8?B?Mm5iLzNLdDNrNStUVHpZYlhMMERxUlMwR1dCSVM2NWVieGF0U2VJMGJjemRv?=
 =?utf-8?B?WEZWREVQSWtxVHJHWTNabXBzbzhmWnRBZ3VYRThaVTZQcndXeHAxU0JwWEl2?=
 =?utf-8?B?cXJmOThzSndMNk5ydnVNWFFuVXBwblN0T3dtTldSN3VUak0rS1hBbE5zZys3?=
 =?utf-8?B?NUdJUkV5TEpnMnYyZUVPU0RtZHVGV29FZWhqblZPOWxHaXN6T0QraWxSM0I2?=
 =?utf-8?B?Z1BUeDFrbWlYUk9BK2dsd0E4VWdmd0R1VWF0TDlyMDVYTFBKd0VwYTlMakZY?=
 =?utf-8?Q?YA6MRSV7tXCmRiYKQ2Ud3leJYZBfq6CO+ALPe24?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anVkRzkzQ3VnWEVpcWtMZHRhdkpQRDZJbUkrandZTnhHWlg5OFVDRCt6V29K?=
 =?utf-8?B?Q3hTMDZCVmNTMW5yWW5TY1FkTkdhaGJXdUgrUFlTYW9KeDd5d05jdkttOFpT?=
 =?utf-8?B?T1BKT3d4Q0pvWmRIRm5SYlhXQlNNd2FMRGcxT2NYcHl2RERTNVlMN05LdThK?=
 =?utf-8?B?Wi90TnoxLzRNT3pUQ0F3d25TbE00SXpuYVlhSmdiYUhyWEdEM1Q0ZXR6azdh?=
 =?utf-8?B?bE5DeDY5dnJBOStaczA1Z0txRFYwNW8vMjlTWkQ1eDJxMjhVNHlnZE1EbWpH?=
 =?utf-8?B?TjNNeEx2bTZKdWtmNlBwL1lyK3pveGFGc3J2M3AzNjNXRERscjF4bkJMQzlo?=
 =?utf-8?B?cGVWUVloQ0FTZzhQNVJJek9BaHZQeHozMzhOdlROZ3NDTnkzTXlRTjdLWnpG?=
 =?utf-8?B?dTFFNFpqbDdjOHB6Smt0ZmxmTlpzaWlrYUtxNDBnaGZiY0pZYkJMTUp5YSsw?=
 =?utf-8?B?KzNTa3NVdkdoS25FK0JyWW5USE8rbHEzc01BSXpqQWZCOWlhbFVpTW5tcEhp?=
 =?utf-8?B?RnAvN1I4RzFGZEhPTXYxNHNIMWFyNENOZlVOMFRDb0xFVTF4dnBhc2F1Z3Zh?=
 =?utf-8?B?QUpJVUpHNXlFbmZGL3ZNaFJyL1NCaWRoVjBxUGZTWTV3NGJSVE0zRDVRU2pj?=
 =?utf-8?B?QlZ4L0lvWHhXVzF1YlNBdVNVQkswa21aamp3clplbGxQNHRUdlc4Z3ZOdWhE?=
 =?utf-8?B?SXc1M1Q2eG52WWhOQ3duQzBRTXNKWFJGQUZTVVF4Z0tXajlwMVk5em5JOE1I?=
 =?utf-8?B?ZnpwWEptRG05aVZxbVRtNzk1Y0ZESjRXWUszRFBYZC9BajFnVzZLMlEwSGo4?=
 =?utf-8?B?Y3dsTEUvYTdKY3BEeHQ2R1l0TTdVSWo4cDBwMzJYd3haTVkwT3JTazZxb1BS?=
 =?utf-8?B?dzhsK05EZVN1ZGxvQlUxd24vMkRtT25VWjJJRmFObW96UjV0VzJoWmFvQzlB?=
 =?utf-8?B?V3RvWno2RllrYnBQZXRvSzE5OVdNOFBpRUY1cy96b29IOHlzM2JIWW1LMkR3?=
 =?utf-8?B?ZFY2bHdqaG52MW5JTDBlZ3RJTHkzUmVTdzNkUjZ1T3NZWXpRV2lUUzcwVHJr?=
 =?utf-8?B?aGVoQ1cweUlyUjdGbEpCQndkZjhycm9LdjZnTzk1NjdxNXgxbCtVQS9USkZR?=
 =?utf-8?B?cVZ5QXNORFM4OFBSSmlYWTcrUE0xNit0SXBaRGRkWjRNdkoyZEl3ZEJWaDh1?=
 =?utf-8?B?UFBpWStDS0pINFlJb2R3RFY2TW5vemVzTGdWYzdHbklGOUg5ZEdFYmI4MCtW?=
 =?utf-8?B?eHNZNDhmNmc4TjhBaVc4c0loQ1RwZnQ4TEc1WjhaWHFKZHBYYVI3dFI2aW5U?=
 =?utf-8?B?QkhhbERjK0NmTnMyMEVvYURsYm0wTmtpT1FsRXRVTHhkaEZSTFduTzBHNUtV?=
 =?utf-8?B?ZHh2Qjl3Z3djUWYzaDJteXdlcGE0WEtDYjZhdndBbEVoL3AwNUpsbm1EYVF5?=
 =?utf-8?B?T25yMkVzcS9YLzh4UTZZeEJhT1RDeU5FTHBTNHJFZFg3bWU0VlQ2aG1nKzRO?=
 =?utf-8?B?RE5tYUR1MTM4OU8zZUNVeDVEZnUzb2VyUjdMN0tOSXJpcHZBTFBCM0VlUUZs?=
 =?utf-8?B?b3BSN0xabkVVWHhKelllUVBQREJjTEFHZUJRelVGbXdHazFadkdCU1VDaG9r?=
 =?utf-8?B?a1RlVytwcUpZK09xWHlCTGloSDhBdzc2YzVVL1VYa3FUaENhcDFLcHlTRHBo?=
 =?utf-8?B?RmFqQ2xHODFPNGNVWWl5M1dKQzRJYUhTa0xXZjU1R3IrWldSajhKTnB5WTBk?=
 =?utf-8?B?dEMrdVZ3WFBId2QwcGVGZXRLRUJvT0NmY1NPeEVycU1hcVhLVm9aei9yaWpT?=
 =?utf-8?B?ZWdLakNueUtNZkkycGVGczZRNWV4WFpDZmpaS2tRd2x3RXAvenQvbGR4Uk5p?=
 =?utf-8?B?SWI4OTlDYkNyai9PUGk4Qmc2aEh4MGZ6a0dEQWluSmxveTRIQm9QKzEvblFS?=
 =?utf-8?B?UkYrSU94OThLMGlCcUN6SHRoZnNzV3c0cE1NTUNQckNUeXB1Y3EzelpPNmV3?=
 =?utf-8?B?Mitac3pZVWdlSzl6QkVjcC9LcnVMcFBTbmdENncvdVRFajR6a0VKR0JpRE9W?=
 =?utf-8?B?YTF2QjBicGpiVTBNVmd6ZW1LVG9ib0U2SjVoV1BDUkRhM0t2VG9DQ3VqU2o4?=
 =?utf-8?B?QzNTcmd5N0NBMmZnZkdLOUdqZENjelYwR0I5UTlRaW0xQVZ3T3RLWm0rNnBr?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9074C670E92BB0408895437A85EFE876@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MgifihJbkJGR3gY2ZQOU3sA3Xs+AxX+isFxwFY/d58Z/2Bh58yMLbHC9wJ6pgD96EuEwlxXHBN8Q7qcGyCeHM+5eI8NRhqczh4cr3Ju4iFQRTGBFMnDrvTVvxE2TyMZ4Ss7J0YzK5wSR9BEBakiyVU1xsRRsa+pHh02lCpaFANGmwr/h8y34UU+Dz0SE3cJrt/YSC11bO9KnnfEAqthifozzsrVbhFVoLYhwAXww+T8PGP8Yw8dYa+yWkDjqiCtkg2vl8KLWUjm/Wt1EQR7Dl+pWbYQa8FLaB2oK1CTv/sybQiW/7dFZ6l87OLaVHJKz/RNsR8y+n+/kJnpnECstN6NyHJhsUOtjhzxf9CcMmdmoyDZhvDCVrW2CULu4CV7ynv0FBL8gMz42mlMD8iAYEC09hnp/iKya1V5Z/mtTIt4COiWylzC0SuSqMHPSn+CKrAHJaSGXjkQrguj5UhiYameSCrL2VXgYXANtcKQAA90fZ+l2Ho5mOVytYFVB8C7Kpu7nVCWWC/AjOCKDB1xb6lmuTW7fG26Nn/tpda00xUQ1bsWz0hEbR7VwMr3ikdHRcJz3pPMNQ6grrZ+0SVSjt5c3gwXEZ1cgAJsyjyAKw7jrNzRvm1ZbxHL56WLuXmeU
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f5aa0d-b367-4c68-246c-08dc6ff63928
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 07:04:09.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQd4BAojgnNi4gF6cbYZfv4AVgPDp+ROkR0C03njRCDw4aJcg3yWwObSyPycyG7d4sWy6zaCMq0ORxMsppVTDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6582

DQoNCk9uIDAxLzA1LzIwMjQgMDU6NTksIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gQSByZWNlbnQg
YnVnZml4IHRvIGN4bF9wbWVtX3JlZ2lvbl9hbGxvYygpIHRvIGZpeCBhbg0KPiBlcnJvci11bndp
bmQtbWVtbGVhayBbMV0sIGhpZ2hsaWdodGVkIGEgdXNlIGNhc2UgZm9yIHNjb3BlLWJhc2VkIHJl
c291cmNlDQo+IG1hbmFnZW1lbnQuDQo+IA0KPiBEZWxldGUgdGhlIGdvdG8gZm9yIHJlbGVhc2lu
ZyBAY3hsX3JlZ2lvbl9yd3NlbSwgYW5kIHJldHVybiBlcnJvciBjb2Rlcw0KPiBkaXJlY3RseSBm
cm9tIGVycm9yIGNvbmRpdGlvbiBwYXRocy4NCj4gDQo+IFRoZSBjYWxsZXIsIGRldm1fY3hsX2Fk
ZF9wbWVtX3JlZ2lvbigpLCBpcyBubyBsb25nZXIgZ2l2ZW4gQGN4bHJfcG1lbQ0KPiBkaXJlY3Rs
eSBpdCBtdXN0IHJldHJpZXZlIGl0IGZyb20gQGN4bHItPmN4bHJfcG1lbS4gVGhpcyByZXRyaWV2
YWwgZnJvbQ0KPiBAY3hsciB3YXMgYWxyZWFkeSBpbiBwbGFjZSBmb3IgQGN4bHItPmN4bF9udmIs
IGFuZCBjb252ZXJ0aW5nDQo+IGN4bF9wbWVtX3JlZ2lvbl9hbGxvYygpIHRvIHJldHVybiBhbiBp
bnQgbWFrZXMgaXQgbGVzcyBhd2t3YXJkIHRvIGhhbmRsZQ0KPiBub19mcmVlX3B0cigpLg0KPiAN
Cj4gQ2M6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4gUmVwb3J0ZWQtYnk6
IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25ASHVhd2VpLmNvbT4NCj4gQ2xvc2Vz
OiBodHRwOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA0MzAxNzQ1NDAuMDAwMDM5Y2VASHVhd2Vp
LmNvbQ0KPiBMaW5rOiBodHRwOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA0MjgwMzA3NDguMzE4
OTg1LTEtbGl6aGlqaWFuQGZ1aml0c3UuY29tDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFt
cyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KDQpUaGFua3MsIExHVE0NCg0KUmV2aWV3ZWQt
Ynk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCmFuZA0KVGVzdGVkLWJ5OiBM
aSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0KDQo+IC0tLQ0KPiBIZXkgRGF2
ZSwgdGhpcyBhcHBsaWVzIG9uIHRvcCBvZiBMaSdzIGZpeC4NCj4gDQo+ICAgZHJpdmVycy9jeGwv
Y29yZS9yZWdpb24uYyB8ICAgNDMgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJp
dmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiBpbmRleCA4MTJiMjk0OGI2YzYuLmUwNTc3ZDk5YzRk
YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiArKysgYi9kcml2
ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+IEBAIC0yNjgxLDI2ICsyNjgxLDIxIEBAIGludCBjeGxf
Z2V0X3BvaXNvbl9ieV9lbmRwb2ludChzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQpDQo+ICAgDQo+ICAg
c3RhdGljIHN0cnVjdCBsb2NrX2NsYXNzX2tleSBjeGxfcG1lbV9yZWdpb25fa2V5Ow0KPiAgIA0K
PiAtc3RhdGljIHN0cnVjdCBjeGxfcG1lbV9yZWdpb24gKmN4bF9wbWVtX3JlZ2lvbl9hbGxvYyhz
dHJ1Y3QgY3hsX3JlZ2lvbiAqY3hscikNCj4gK3N0YXRpYyBpbnQgY3hsX3BtZW1fcmVnaW9uX2Fs
bG9jKHN0cnVjdCBjeGxfcmVnaW9uICpjeGxyKQ0KPiAgIHsNCj4gICAJc3RydWN0IGN4bF9yZWdp
b25fcGFyYW1zICpwID0gJmN4bHItPnBhcmFtczsNCj4gICAJc3RydWN0IGN4bF9udmRpbW1fYnJp
ZGdlICpjeGxfbnZiOw0KPiAtCXN0cnVjdCBjeGxfcG1lbV9yZWdpb24gKmN4bHJfcG1lbTsNCj4g
ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiAgIAlpbnQgaTsNCj4gICANCj4gLQlkb3duX3JlYWQo
JmN4bF9yZWdpb25fcndzZW0pOw0KPiAtCWlmIChwLT5zdGF0ZSAhPSBDWExfQ09ORklHX0NPTU1J
VCkgew0KPiAtCQljeGxyX3BtZW0gPSBFUlJfUFRSKC1FTlhJTyk7DQo+IC0JCWdvdG8gb3V0Ow0K
PiAtCX0NCj4gKwlndWFyZChyd3NlbV9yZWFkKSgmY3hsX3JlZ2lvbl9yd3NlbSk7DQo+ICsJaWYg
KHAtPnN0YXRlICE9IENYTF9DT05GSUdfQ09NTUlUKQ0KPiArCQlyZXR1cm4gLUVOWElPOw0KPiAg
IA0KPiAtCWN4bHJfcG1lbSA9IGt6YWxsb2Moc3RydWN0X3NpemUoY3hscl9wbWVtLCBtYXBwaW5n
LCBwLT5ucl90YXJnZXRzKSwNCj4gLQkJCSAgICBHRlBfS0VSTkVMKTsNCj4gLQlpZiAoIWN4bHJf
cG1lbSkgew0KPiAtCQljeGxyX3BtZW0gPSBFUlJfUFRSKC1FTk9NRU0pOw0KPiAtCQlnb3RvIG91
dDsNCj4gLQl9DQo+ICsJc3RydWN0IGN4bF9wbWVtX3JlZ2lvbiAqY3hscl9wbWVtIF9fZnJlZShr
ZnJlZSkgPSBremFsbG9jKA0KPiArCQlzdHJ1Y3Rfc2l6ZShjeGxyX3BtZW0sIG1hcHBpbmcsIHAt
Pm5yX3RhcmdldHMpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWN4bHJfcG1lbSkNCj4gKwkJcmV0
dXJuIC1FTk9NRU07DQo+ICAgDQo+ICAgCWN4bHJfcG1lbS0+aHBhX3JhbmdlLnN0YXJ0ID0gcC0+
cmVzLT5zdGFydDsNCj4gICAJY3hscl9wbWVtLT5ocGFfcmFuZ2UuZW5kID0gcC0+cmVzLT5lbmQ7
DQo+IEBAIC0yNzE4LDExICsyNzEzLDggQEAgc3RhdGljIHN0cnVjdCBjeGxfcG1lbV9yZWdpb24g
KmN4bF9wbWVtX3JlZ2lvbl9hbGxvYyhzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hscikNCj4gICAJCSAq
Lw0KPiAgIAkJaWYgKGkgPT0gMCkgew0KPiAgIAkJCWN4bF9udmIgPSBjeGxfZmluZF9udmRpbW1f
YnJpZGdlKGN4bG1kKTsNCj4gLQkJCWlmICghY3hsX252Yikgew0KPiAtCQkJCWtmcmVlKGN4bHJf
cG1lbSk7DQo+IC0JCQkJY3hscl9wbWVtID0gRVJSX1BUUigtRU5PREVWKTsNCj4gLQkJCQlnb3Rv
IG91dDsNCj4gLQkJCX0NCj4gKwkJCWlmICghY3hsX252YikNCj4gKwkJCQlyZXR1cm4gLUVOT0RF
VjsNCj4gICAJCQljeGxyLT5jeGxfbnZiID0gY3hsX252YjsNCj4gICAJCX0NCj4gICAJCW0tPmN4
bG1kID0gY3hsbWQ7DQo+IEBAIC0yNzMzLDE4ICsyNzI1LDE2IEBAIHN0YXRpYyBzdHJ1Y3QgY3hs
X3BtZW1fcmVnaW9uICpjeGxfcG1lbV9yZWdpb25fYWxsb2Moc3RydWN0IGN4bF9yZWdpb24gKmN4
bHIpDQo+ICAgCX0NCj4gICANCj4gICAJZGV2ID0gJmN4bHJfcG1lbS0+ZGV2Ow0KPiAtCWN4bHJf
cG1lbS0+Y3hsciA9IGN4bHI7DQo+IC0JY3hsci0+Y3hscl9wbWVtID0gY3hscl9wbWVtOw0KPiAg
IAlkZXZpY2VfaW5pdGlhbGl6ZShkZXYpOw0KPiAgIAlsb2NrZGVwX3NldF9jbGFzcygmZGV2LT5t
dXRleCwgJmN4bF9wbWVtX3JlZ2lvbl9rZXkpOw0KPiAgIAlkZXZpY2Vfc2V0X3BtX25vdF9yZXF1
aXJlZChkZXYpOw0KPiAgIAlkZXYtPnBhcmVudCA9ICZjeGxyLT5kZXY7DQo+ICAgCWRldi0+YnVz
ID0gJmN4bF9idXNfdHlwZTsNCj4gICAJZGV2LT50eXBlID0gJmN4bF9wbWVtX3JlZ2lvbl90eXBl
Ow0KPiAtb3V0Og0KPiAtCXVwX3JlYWQoJmN4bF9yZWdpb25fcndzZW0pOw0KPiArCWN4bHJfcG1l
bS0+Y3hsciA9IGN4bHI7DQo+ICsJY3hsci0+Y3hscl9wbWVtID0gbm9fZnJlZV9wdHIoY3hscl9w
bWVtKTsNCj4gICANCj4gLQlyZXR1cm4gY3hscl9wbWVtOw0KPiArCXJldHVybiAwOw0KPiAgIH0N
Cj4gICANCj4gICBzdGF0aWMgdm9pZCBjeGxfZGF4X3JlZ2lvbl9yZWxlYXNlKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gQEAgLTI4NjEsOSArMjg1MSwxMCBAQCBzdGF0aWMgaW50IGRldm1fY3hsX2Fk
ZF9wbWVtX3JlZ2lvbihzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hscikNCj4gICAJc3RydWN0IGRldmlj
ZSAqZGV2Ow0KPiAgIAlpbnQgcmM7DQo+ICAgDQo+IC0JY3hscl9wbWVtID0gY3hsX3BtZW1fcmVn
aW9uX2FsbG9jKGN4bHIpOw0KPiAtCWlmIChJU19FUlIoY3hscl9wbWVtKSkNCj4gLQkJcmV0dXJu
IFBUUl9FUlIoY3hscl9wbWVtKTsNCj4gKwlyYyA9IGN4bF9wbWVtX3JlZ2lvbl9hbGxvYyhjeGxy
KTsNCj4gKwlpZiAocmMpDQo+ICsJCXJldHVybiByYzsNCj4gKwljeGxyX3BtZW0gPSBjeGxyLT5j
eGxyX3BtZW07DQo+ICAgCWN4bF9udmIgPSBjeGxyLT5jeGxfbnZiOw0KPiAgIA0KPiAgIAlkZXYg
PSAmY3hscl9wbWVtLT5kZXY7DQo+IA==
