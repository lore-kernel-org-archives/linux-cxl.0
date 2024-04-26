Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539C22092
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102647; cv=fail; b=n7wqE9AjAVbuccH0npmMiI/EqQnXDuFpNuC6duSRcXNfMrG3esmxC2a0CeXvMWzEq3OxprQM/0nYw0qDqt/CIoq6vPljpnCLCos0q9US392lVVBjcQ7hN3elgUOlWgTco69J7nD6uA05VnrFQkfj1f5hsxIpOh/bucK1dyhR42s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102647; c=relaxed/simple;
	bh=/rCuqmwdCOSsDP6z6161S3JVUDuvweSl0jStruIOLm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tO2QcJdqkr+NtOtCaoIeodZK91km0zOEvJoUoiYCLiKGdb97ZhZoKtEdeCiKvQ7o9p0sG6SgWE0lXTa97Qqs8qTda+3xlzEFVBaKzj5PLNxkuereEryoSDcecG3NQwupB8s+8hhnte1DdY3LaN0AbqI2cxB1LvYUDB8gVJh7ciE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lR/wRhXy; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lR/wRhXy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1714102644; x=1745638644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/rCuqmwdCOSsDP6z6161S3JVUDuvweSl0jStruIOLm0=;
  b=lR/wRhXycdcbBDOgNzixmu0zcBOfeCBvf0v9IVa7hAlngzKjrQqnGinv
   XjCz8qPbiVC74WyDJ1zqOghx7mCkgECwDXvFDnDqRB0Ti+Wo2FJBqYFbs
   NqDHVSPkIEBKuD4xbIZ8EtgWaI/LDM8ynYbQtu9mocLjlD20qq1WpFSaO
   7MUD5pdkkIAvCvNIvty8vskubDUPGaoKbZ1Urg+elvlSKvnm8V2WIniBP
   smwoudv/pu/zgzFgeAPqcG+s8szf+zNc7cmNtBHFRHzqs8Yu7vvl+sY8L
   sZJYTmfmw/42svB2WRzUDulsHOgifsJ5tTz7VoieQNLTqIwOMpA6ln2e1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="118765822"
X-IronPort-AV: E=Sophos;i="6.07,231,1708354800"; 
   d="scan'208";a="118765822"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:36:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUe9JiZgAKPq3pJtOcNfsZHq+93hAa2ut8DA55NNwebCoNLnd6i5aY7Ods25BFmDMJlIpM1RCV8/LkHHYEnnIMKNFnIomw/njgdfO8tyFA3Dt2tfR7zDP/nn6pqXzYvxrny0lFgVMFDaSjBvylc2cX9ANtjV0Un5PPBxDGjveWObG88IPP7Rby7YWtPEkZWbNCJ74Tk6x83fh1QeXTCAHpyiv7hTEB8gjB1XzM7Kwhp+Ssc0HDjyYsPLsYD9R77et50333QDyDXdkk3367q/7twonG33zvN70RFf4QR7TZcE7CWkq1l5CDl5ria3yzSR1cDkBsOWM0eWpO/FuQ6vVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rCuqmwdCOSsDP6z6161S3JVUDuvweSl0jStruIOLm0=;
 b=TUVopAypj92WpVkrKMWCe9swNuzCkt3qpzhHpNPZPHQS9pWKSCH1tGZA6dO3+BXRRbHf5M/JKnABDMxLHxnKiNywvAj9lhuXrLQBs2KBUst/OYvoVorUCqeSXz0BnEgmrcqxBzvijmu89GixV4ol8Xb53UkfWzZ8HK6eZ6l+9R4deAU/C00xTL4J2TLcanaHA3+SJzxShxqzTB5AEHwF6iR3hu7ce9f6Qnx/FhdkmMkWvUXACsrO1c+3L0fsSzKliMnOZptZZNcQ2yGy2lq4Tlo8Y4Z9PDJNeoustI0Wv1wmDdJMDQM0CnToSUTUejjgMw7NgFzrAVEzJQfSXBhLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB9328.jpnprd01.prod.outlook.com (2603:1096:604:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25; Fri, 26 Apr
 2024 03:36:08 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 03:36:08 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Fan Ni <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] hw/mem/cxl_type3: reset dvsecs in ct3d_reset()
Thread-Topic: [PATCH v2] hw/mem/cxl_type3: reset dvsecs in ct3d_reset()
Thread-Index: AQHailPEIC7L3k8DCk2WTXoG6ZPVp7Fi3noAgBcimoA=
Date: Fri, 26 Apr 2024 03:36:07 +0000
Message-ID: <96862201-fb35-4fa2-bb77-253773efbe03@fujitsu.com>
References: <20240409075846.85370-1-lizhijian@fujitsu.com>
 <20240411111816.0000343c@Huawei.com>
In-Reply-To: <20240411111816.0000343c@Huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB9328:EE_
x-ms-office365-filtering-correlation-id: 517174d1-f8c5-4e69-5ed4-08dc65a20263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|366007|376005|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjJPOE1lNysxejlreGp6THlZdFoxT1FhVEg5SkIxWmh4U1FkdWhhTTJTVXdU?=
 =?utf-8?B?ZFdxR2FLcEFVMUpIUFN6U0w2VlpBL2tNNDVERXhnQU5xWDByM20veWFIdEV0?=
 =?utf-8?B?WXd6U0lvenhaNTdVc2lJdTRpeE40ZkU1V0g5dmFwRGx5Zm8rekM1SnFYS2pO?=
 =?utf-8?B?dkNIblJQOVE0VlVUR2dKRjF5d1JFSHV2ZTl4YXFkM29zSlduN1RHOFUrQXVi?=
 =?utf-8?B?REVYdFl5bW55M3ZLbnRaVldMeEUwRStnYkdESGFURkhSNGE1Wk5PamlBUi9j?=
 =?utf-8?B?UWZvcEU0U0xBNEU3WTdKM0c3bTdmZUV3MzlUTGJNVENMQ0tEVkxGc2t2TFlr?=
 =?utf-8?B?KysvTTNnWVR4UjRia3RPeC9tT3Vob242UUxaTVE3aUxDWW1XNjh1OHVKWW9j?=
 =?utf-8?B?RzlkdmVSYzVUd2pnMW5hV1ZScVlNUmpxRHJXNWlBTGFWTUllMlFTdFlSU0xM?=
 =?utf-8?B?VUlra0xSbGNENk15dWdsVHNKZEh2Q01GTUN2T3dDM2I1NXJHY01LY1lzMy8x?=
 =?utf-8?B?a3dzNjVjUGE1N0c3L0xrVEZ1NjR3dnROaitUR0FTSmg5MEZsVHRzTkdvZXM5?=
 =?utf-8?B?VHZyUGQzdEwvRVdDTmxmbkNMNWlxbnhyV2VZSno3NEIxV3lKbDFRSTBqM0My?=
 =?utf-8?B?cVhlZFVoWk5aZWxJRExEeVdySFdFNExuOHJZalA2L0NNNm11ZmFBNGtRK2Fv?=
 =?utf-8?B?cDhpemFNTFk4YjlTRFRHUHFPNlF6d3lZTWlrVE93WU84WUczamhGYTUrZHNS?=
 =?utf-8?B?akc4MDNpNk0rcWtDY2RpSkVWNGNTZlZLemVPYUhTVVk4Z2lTOXFxUk9ERk1y?=
 =?utf-8?B?Z1NUZXVZT0R1ZnZiTS9FZG5mcEZ4amtGWmJkaW5oNng3SVpHbFJHWHFwc1hn?=
 =?utf-8?B?RENWaWk4b0tzMzhsS1ZDS1dTeEluZmtsbm5YS2R2M1g2SERIZnVjd2hxSXRZ?=
 =?utf-8?B?cTFqM2RQZG1BRS90cGtPZlFBT3hqVVlURnRYSThQMDNPUUc0OUlsVWJ3a241?=
 =?utf-8?B?SXdTdlRFTHoycEN0M1IvT1ZlbUwzL0NVV3pGbkNjRVJTUjJFcXlrendVcHBS?=
 =?utf-8?B?dzFkbmlVRzh5alpQajcwUmx3bkNoaXg1Zkp0Mmo0b2Fjb2w0NkJnbWxOZ2My?=
 =?utf-8?B?VHArY0Q1VDNjbnJrZHNvblNQVXBNanZWKzNOQjkySWpEdlNLUkx5dXp3SDE1?=
 =?utf-8?B?MWNsU3QxTm5LaTRVYmo1RHRpcDgwdjRSbVcvcEFwNmpUd29lY0daVWpYejFN?=
 =?utf-8?B?VzVsVnZYcXBJbG5pdVhVaG52aXlVbEhWREp4S1N0K0lHZENtT3BHRGJPNlU4?=
 =?utf-8?B?Vk1hRzk0VWYwWnY1c2pMNzNSdFFlUWs1cHYzUmZqaGp0b05wZ2ZoNXdqeWhk?=
 =?utf-8?B?Q2ErTDhXUExOdGNKd0hCU3VjanNjVjNzUDIzYUw3QUIyQUF5SkVEUEFxeDFE?=
 =?utf-8?B?SnEydnJ5b1JuTGNqL0VYREgxZ1F4R2lrQ1JjanU2NHNBcTlrOElvZ1QvSXFH?=
 =?utf-8?B?VEJjcjlDY0M3YjNHZ2dtdzdJbHNieTdUalJHMy83MUFINVpHa0ttMDc1a1Fq?=
 =?utf-8?B?SjBxYmxpUG51aUw1WHd5UGRKcGpEV1ZValcwSGRTTk5PRFFSaXV2Q1JCa2VP?=
 =?utf-8?B?eUxZVUJaZGZrQnIvd2hyZnFYNzViSEhiMnFCZzNFbzF3TFdxL1RNUTA5czBo?=
 =?utf-8?B?ZnlobTJHYzE2UkFTU2dWZ0s5ZkdFaE9kS3VMeEhYZ3ZLTGptaVJNTkFadU5x?=
 =?utf-8?B?bUN5MlBzRzBNZExHN3NuTGk4MDlWMDdVNU54S1BNRHZabDVJTURTRkMxQTZU?=
 =?utf-8?Q?9G+UbBkmQiBms5BP8zxxrYRjkpoDecxhHlG7I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2J2QkZOd1A1ZHBNQStXUStjUUlrOWUzS3hDQm5lWmtOQjNYb3drWWpPUnRR?=
 =?utf-8?B?K3FBajgzbW9LYkJBTkkzcG82QzRhNmlBVGh0dTZYR2xDOHZsSXZPeXcvUGVY?=
 =?utf-8?B?VWxJQng5RzQ0dEp1a2ZaSDhlUEVWOXRJcUhwQThibWs2UUY1ZitYYStwVHBT?=
 =?utf-8?B?cDlpUXh0QWVXNjREd2xqNkVqTDlBNUJzRS9MRDluN1h6UW1HZ0xKMjZ6b05S?=
 =?utf-8?B?OEhKSGErUndpa0Z5QU40ZkVMRlpXUUQ1bXlPRFdVai9CeGZpSk9qRWh0MEpM?=
 =?utf-8?B?b1ZLeXhSbnl0c2Z5N0p1MlIrU1U5UnNxRk1yWGYrTnRFdTB5dm5WckxaWDdp?=
 =?utf-8?B?TXMyNlB0MUI5S0tlSkFBK2NidnBOTmtnT2FIQ1B5aVk1UmhXM1k3TktuWU5q?=
 =?utf-8?B?NWlBL1doSFVLZTZ1Zll2Vno4d3NJU1AzSm01ZysrV0FqYmRyYnByUFdJSW1x?=
 =?utf-8?B?WG5QdHhtMXFyRklMTzVyRHRmTEtHSHNqUWs0QitNcFJYU2szRnUrNlY0Zjhh?=
 =?utf-8?B?WTBhRE5lMlVTOGpQQVVIdTRqaFpyT0RvUWcwTEg5eDFFbHNnMTA0RmdZVk11?=
 =?utf-8?B?bDByMU5Ub21PQTh3cm80RERjMzMzeldRdzBHVHNpZEo0K3BUREoyVGdLek1s?=
 =?utf-8?B?dE5BSCtmUnQxaEtGZ2JyOFFhWllhSFgxVnJaNEYyK1NUY1BLNXFNdG1CU0tL?=
 =?utf-8?B?UyszR1ZpcjlkMllnWThJN2ZFQVVsUFhZei9wZExKbXJGN1NCejNHOU5qWGN3?=
 =?utf-8?B?Q2ZNeGQ2aExGamxMTlA5d2tISTJoQ0syUFF3U2VYMkJQTldCNjFodUp1N3RQ?=
 =?utf-8?B?QkpZM1lrMHZUVElpb0lFYlkzckoyYkR4aXdHaUkwZkVNT1F5ZjJHVTIyejgw?=
 =?utf-8?B?cEkvNXduazFGeWdPc2FtT1IwTlJSWnhURmZHdGJ3NzZubmk2YWdVd2lVb3pp?=
 =?utf-8?B?TFZFdlp2MEJROVBGMGZuNTVzL1htOUJKdXlJWEtUWWlHMHZvdERZYnJjRUdE?=
 =?utf-8?B?OXBCRVVyaXcyeFRpdVUwQlF3RmpOdUMrNWhkdXdjcUJIZ29UMk01RkpiS2d5?=
 =?utf-8?B?ZThDcm5UYXJmc0NVaGNndGlKd3M5ZnMwNzRrT2FkMVNOMFlQeHVJUFdZUWFQ?=
 =?utf-8?B?cXhXMEhxNU5NK3p3QkdLY0lpcDJMUWtNQkQ2UWZDMmNZekNEbk1qVzVGUU9W?=
 =?utf-8?B?NlZKY3RreTJmbmFHS1FnUktYVUlwSGE3bFFPWHFiZlE3NytRSUZKNXZLQUhJ?=
 =?utf-8?B?ZEo1RlJEaWswVEh2bmIwZUE3OFdSK1Z3TEt6ZytSM1dkcTJ3cm44bnl5QklO?=
 =?utf-8?B?VnpnRFdhK2FFSUdzdnQ0RFh3cmFsVUVxU281bm00SndFSURrVmNLMkFHd21Z?=
 =?utf-8?B?NklwbHdYQ1dVWXlGT1V5Y092Z2xiNXlUU0FReGRDTklKb0d0c2lNY0doN2Nw?=
 =?utf-8?B?bkhCVzJmYVJOb2s1SjQ2VzFlaDVtNFFiUmpFNkFBMjY5WFA3czdVdnZyTkJU?=
 =?utf-8?B?UWtBVUwxT3dBNUJ5ZkZLZi8xLy9zVXdvQy9BQW1JQSticm5ncUJwWE5OUURr?=
 =?utf-8?B?VEg5T1IxVkxqR09lQ1NsK1d4c0hrVEFQdVNjSm1MSkMwQmZWa0t2a25Dc2R3?=
 =?utf-8?B?ZmRPdE41Q0NIdnpuTzhpYlZPc0wwQXY4UGVwNk1FT2c4ay83QVlkK09CMitS?=
 =?utf-8?B?cFZobVE4MXVnTGoyMmJLaHJHWFFXbnlSUlhpL2JXd2g3NUZic1JVdFptbU5i?=
 =?utf-8?B?NFR5Nk52b1VBUXcxS0xmTUVIdWZ0NjJaTXlwNDhqcWlwa0pyL1RaUTBYQnUv?=
 =?utf-8?B?RHFnR253N0hnaVBPaUpjeFpNV1M0V0Ryb1ZBYUJ0S2pnd1VoUTFuMTc5OU9p?=
 =?utf-8?B?V3huNmV5WGxPNFRib3ZZelpEWWpXdm9tdHBqc1Vob1JkVXhVYW9XM1JyZEs3?=
 =?utf-8?B?RmxRMHBZR1lQN1BuT3F4aktBc1R5cThkR1JZSzF3WUlFK2gvTmRGNkRXT0FE?=
 =?utf-8?B?RHFLZE5YbmcwS0lhczNPVnRoUTBLQUVVZXJFL0NubjVqdDBWdzVsNk1ZV1pl?=
 =?utf-8?B?bWVRT1FVSUU3U2dsS2o1eldMSjUvd2JSdEV2bUdwbGlsT0t4Z2pKSXMrRWxi?=
 =?utf-8?B?b3V5S2tHM1FVTmU0RlkzOXZhWXphTkw0bnNPTG10U2kxMFo1dEV6QmxRcUM5?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83B4FE38BF5754459CF29DAB826C0E82@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h0DJPEpKDrigZz2FKtnsF5kODdE09OlN3zeqNsaTQW9RIAibGHGR8Do7LJcA+hodxknIJYO/n+p0dQy3eFEd7r2bc3kke1wm317yBhMslb3Peh/60G31hcjPmrBAOk/tB9OfvYU/Jws5/lWOrHmv/A0agj70EdKicY8dliA5alTKIZiYH0Y5Opg7aIslZNttuNzHB1WYHgRXm3TaVjm9Rea2iAlQIlU0jPxt6AIbjXo50pepzgYwDnw1Fmn3penaiml3OCqmIwOWV/RA0nfc8Co8Ad9yOJWRX1Umj8O0mT18lOyxtwDBRRZ72krfYeD7Q8A/58H2opMNMU8iYVvfMReLlnUnNEvoFOpDPXUehigYkpwzh7FWAQ1i7+vz/NZaV153r2MO2H1xrFYBmHrlpsBssdMighv2Al7MANLE1LMUXEAHZgINOPHFzF7O+kPmTP8Tiz0Oqkp9lJ7B/QlAtg5+EydtuSda61ne+GUTBm7KXDtyK/CuARHwL0Wtga34FmpUnzSL6V5iBzG6FsA/di1nu3LLjRJzGlyhXhh8VZMDxEoePM8Uly7Tb8bqjqBo157XDeESZWSkxsT3KwASm4HW3xmrd6YyQsd4WzZD8U88hWiqDzMiq/1Hvd8IGAmT
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517174d1-f8c5-4e69-5ed4-08dc65a20263
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 03:36:07.8761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgU0tacnPEQ/QCHFuCozzPztWff0K+Cn36TTZsuF43/kUOOm81teTKgTRQGmrYol3xCIXFh80Ny3dPO+lsPJMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9328

cGluZw0KDQoNCg0KT24gMTEvMDQvMjAyNCAxODoxOCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToN
Cj4gT24gVHVlLCAgOSBBcHIgMjAyNCAxNTo1ODo0NiArMDgwMA0KPiBMaSBaaGlqaWFuIDxsaXpo
aWppYW5AZnVqaXRzdS5jb20+IHdyb3RlOg0KPiANCj4+IEFmdGVyIHRoZSBrZXJuZWwgY29tbWl0
DQo+PiAwY2FiNjg3MjA1OTggKCJjeGwvcGNpOiBGaXggZGlzYWJsaW5nIG1lbW9yeSBpZiBEVlNF
QyBDWEwgUmFuZ2UgZG9lcyBub3QgbWF0Y2ggYSBDRk1XUyB3aW5kb3ciKQ0KPj4gQ1hMIHR5cGUz
IGRldmljZXMgY2Fubm90IGJlIGVuYWJsZWQgYWdhaW4gYWZ0ZXIgdGhlIHJlYm9vdCBiZWNhdXNl
IHRoZQ0KPj4gY29udHJvbCByZWdpc3RlcihzZWUgOC4xLjMuMiBpbiBDWEwgc3BlY2lmaWN0aW9u
IDIuMCBmb3IgbW9yZSBkZXRhaWxzKSB3YXMNCj4+IG5vdCByZXNldC4NCj4+DQo+PiBUaGVzZSBy
ZWdpc3RlcnMgY291bGQgYmUgY2hhbmdlZCBieSB0aGUgZmlybXdhcmUgb3IgT1MsIGxldCB0aGVt
IGhhdmUNCj4+IHRoZWlyIGluaXRpYWwgdmFsdWUgaW4gcmVib290IHNvIHRoYXQgdGhlIE9TIGNh
biByZWFkIHRoZWlyIGNsZWFuIHN0YXR1cy4NCj4+DQo+PiBGaXhlczogZTE3MDZlYTgzZGEwICgi
aHcvY3hsL2RldmljZTogQWRkIGEgbWVtb3J5IGRldmljZSAoOC4yLjguNSkiKQ0KPj4gU2lnbmVk
LW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPiBIaSwNCj4gDQo+
IFdlIG5lZWQgdG8gaGF2ZSBhIGNsb3NlIGxvb2sgYXQgd2hhdCB0aGlzIGlzIGFjdHVhbGx5IGRv
aW5nIGJlZm9yZQ0KPiBjb25zaWRlcmluZyBhcHBseWluZyBpdC4gIEkgZG9uJ3QgaGF2ZSB0aW1l
IHRvIGdldCB0aGF0IHRoaXMgd2VlaywgYnV0DQo+IGhvcGVmdWxseSB3aWxsIGZpbmQgc29tZSB0
aW1lIGxhdGVyIHRoaXMgbW9udGguDQo+IA0KPiBJIGRvbid0IHdhbnQgYSBwYXJ0aWFsIGZpeCBm
b3Igb25lIHBhcnRpY3VsYXIgY2FzZSB0aGF0IGNhdXNlcw0KPiB1cyBwb3RlbnRpYWwgdHJvdWJs
ZSBpbiBvdGhlcnMuDQo+IA0KPiBKb25hdGhhbg0KPiANCj4+IC0tLQ0KPj4gcm9vdF9wb3J0LCB1
c3AgYW5kIGRzcCBoYXZlIHRoZSBzYW1lIGlzc3VlLCBpZiB0aGlzIHBhdGNoIGdldCBhcHByb3Zl
ZCwNCj4+IEkgd2lsbCBzZW5kIGFub3RoZXIgcGF0Y2ggdG8gZml4IHRoZW0gbGF0ZXIuDQo+Pg0K
Pj4gVjI6DQo+PiAgICAgQWRkIGZpeGVzIHRhZy4NCj4+ICAgICBSZXNldCBhbGwgZHZzZWNzIHJl
Z2lzdGVycyBpbnN0ZWFkIG9mIENUUkwgb25seQ0KPj4gLS0tDQo+PiAgIGh3L21lbS9jeGxfdHlw
ZTMuYyB8IDExICsrKysrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L21lbS9jeGxfdHlwZTMu
YyBiL2h3L21lbS9jeGxfdHlwZTMuYw0KPj4gaW5kZXggYjBhN2U5ZjExYjY0Li40ZjA5ZDBiOGZl
ZGMgMTAwNjQ0DQo+PiAtLS0gYS9ody9tZW0vY3hsX3R5cGUzLmMNCj4+ICsrKyBiL2h3L21lbS9j
eGxfdHlwZTMuYw0KPj4gQEAgLTMwLDYgKzMwLDcgQEANCj4+ICAgI2luY2x1ZGUgImh3L3BjaS9t
c2l4LmgiDQo+PiAgIA0KPj4gICAjZGVmaW5lIERXT1JEX0JZVEUgNA0KPj4gKyNkZWZpbmUgQ1Qz
RF9DQVBfU05fT0ZGU0VUIFBDSV9DT05GSUdfU1BBQ0VfU0laRQ0KPj4gICANCj4+ICAgLyogRGVm
YXVsdCBDREFUIGVudHJpZXMgZm9yIGEgbWVtb3J5IHJlZ2lvbiAqLw0KPj4gICBlbnVtIHsNCj4+
IEBAIC0yODQsNiArMjg1LDEwIEBAIHN0YXRpYyB2b2lkIGJ1aWxkX2R2c2VjcyhDWExUeXBlM0Rl
diAqY3QzZCkNCj4+ICAgICAgICAgICAgICAgIHJhbmdlMl9zaXplX2hpID0gMCwgcmFuZ2UyX3Np
emVfbG8gPSAwLA0KPj4gICAgICAgICAgICAgICAgcmFuZ2UyX2Jhc2VfaGkgPSAwLCByYW5nZTJf
YmFzZV9sbyA9IDA7DQo+PiAgIA0KPj4gKyAgICBjeGxfY3N0YXRlLT5kdnNlY19vZmZzZXQgPSBD
VDNEX0NBUF9TTl9PRkZTRVQ7DQo+PiArICAgIGlmIChjdDNkLT5zbiAhPSBVSTY0X05VTEwpIHsN
Cj4+ICsgICAgICAgIGN4bF9jc3RhdGUtPmR2c2VjX29mZnNldCArPSBQQ0lfRVhUX0NBUF9EU05f
U0laRU9GOw0KPj4gKyAgICB9DQo+PiAgICAgICAvKg0KPj4gICAgICAgICogVm9sYXRpbGUgbWVt
b3J5IGlzIG1hcHBlZCBhcyAoMHgwKQ0KPj4gICAgICAgICogUGVyc2lzdGVudCBtZW1vcnkgaXMg
bWFwcGVkIGF0ICh2b2xhdGlsZS0+c2l6ZSkNCj4+IEBAIC02NjQsMTAgKzY2OSw3IEBAIHN0YXRp
YyB2b2lkIGN0M19yZWFsaXplKFBDSURldmljZSAqcGNpX2RldiwgRXJyb3IgKiplcnJwKQ0KPj4g
ICANCj4+ICAgICAgIHBjaWVfZW5kcG9pbnRfY2FwX2luaXQocGNpX2RldiwgMHg4MCk7DQo+PiAg
ICAgICBpZiAoY3QzZC0+c24gIT0gVUk2NF9OVUxMKSB7DQo+PiAtICAgICAgICBwY2llX2Rldl9z
ZXJfbnVtX2luaXQocGNpX2RldiwgMHgxMDAsIGN0M2QtPnNuKTsNCj4+IC0gICAgICAgIGN4bF9j
c3RhdGUtPmR2c2VjX29mZnNldCA9IDB4MTAwICsgMHgwYzsNCj4+IC0gICAgfSBlbHNlIHsNCj4+
IC0gICAgICAgIGN4bF9jc3RhdGUtPmR2c2VjX29mZnNldCA9IDB4MTAwOw0KPj4gKyAgICAgICAg
cGNpZV9kZXZfc2VyX251bV9pbml0KHBjaV9kZXYsIENUM0RfQ0FQX1NOX09GRlNFVCwgY3QzZC0+
c24pOw0KPj4gICAgICAgfQ0KPj4gICANCj4+ICAgICAgIGN0M2QtPmN4bF9jc3RhdGUucGRldiA9
IHBjaV9kZXY7DQo+PiBAQCAtOTA3LDYgKzkwOSw3IEBAIHN0YXRpYyB2b2lkIGN0M2RfcmVzZXQo
RGV2aWNlU3RhdGUgKmRldikNCj4+ICAgDQo+PiAgICAgICBjeGxfY29tcG9uZW50X3JlZ2lzdGVy
X2luaXRfY29tbW9uKHJlZ19zdGF0ZSwgd3JpdGVfbXNrLCBDWEwyX1RZUEUzX0RFVklDRSk7DQo+
PiAgICAgICBjeGxfZGV2aWNlX3JlZ2lzdGVyX2luaXRfdDMoY3QzZCk7DQo+PiArICAgIGJ1aWxk
X2R2c2VjcyhjdDNkKTsNCj4+ICAgDQo+PiAgICAgICAvKg0KPj4gICAgICAgICogQnJpbmcgdXAg
YW4gZW5kcG9pbnQgdG8gdGFyZ2V0IHdpdGggTUNUUCBvdmVyIFZETS4NCj4g
