Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D998200B93
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262963; cv=fail; b=eZ+kjYGfh/aQhh6iJaXRf+SQnPaWlOz9oYzx+2fUZSjmfRI7MI2PrYIFJOwmUDXD9EbP0NUrg2mR4h9K/sLRuGMxefEYipiiuy9ARhCL9pmrHQEeTTCmaIB33guk+CoYDFm3SVhk30bBghh/ShN0mgoICVolZSWvJZVfIrgI8M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262963; c=relaxed/simple;
	bh=aZcvsC6R7ed4xfwIdthR58/I6XPFRhgMfRn6NPXhNfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fggurPIIqzEzsxAHgerhHPrN8s+g/CscgH33NYSGpJxsm9kFtuHmvfFaylPcBxs3mbOwmt+dCFtLj3316FdqvCtvpwdcJ6NW1nam7FSR7fBLpIeiLGiYjaPTI0zgNkUgCMtnVMSKHt+FHlPkVG7K3/NY6J1YM0qMAcZKiANPapo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B044wMzL; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B044wMzL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8wuIJdPVN8/WrImUHrQfsP7gF2B3+LCaa/oN7eIsjz+stMEik8yJHzZV03oUUKNgaKsPxM9R/lAZ+XREiQbEEWk9I011Af5O1H1qjOTpE3hnnHRVQNDg7zquZWNhSr3hGNMI8xFDM5mjX/kr5c7y5fZ7DrOLBlkADeCqItNXebZhlZCf2KuaM5a+F1A5rlf9bhjcCrIWX4Gy0a3UROyLsoka+scRDdC8LKEOIT/IsvDnciXgCgITCqRGAg2tS8xU9qsT22/X0ZNqDzg7OZXlOdadblCZ/n9FAuPI8FhY0uk0SzEW0kiIgUVMtkOPJIoUkiZTL++/eOftq3ilPLaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZcvsC6R7ed4xfwIdthR58/I6XPFRhgMfRn6NPXhNfg=;
 b=teCwuymUwy1M4Qh3tLN+8HjEXvHf/PT8gyYpFcfWSiNguYel3ttzvr1CwbmrocYBu0iBtHw/cEUkN2MAnssM9mLUMXaCXpZhgtO/n46gk1DZkPLj01nf4KmdHRScOmx5j50CTSrOxD1wpt+bpQh5VaFICBCZHgOvrAzr4nKfnm0tBKOzjvmV6lI9aJaO6yrcYkRwEXD/XVhbZ4grMYoTzumXkFTE1V640pSvaM+I/t4EZPMsBYoDbr5ZtWPkMOQgd7Pg34JyeIIZy/4aFlowNGM0wSKlBfe0kBuC2ERTtxBksro3FvGGOTdOJbqh43e0ML6pnwXv7ccdKLVwDg7mMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZcvsC6R7ed4xfwIdthR58/I6XPFRhgMfRn6NPXhNfg=;
 b=B044wMzLyzglQTGW+Tq7nM1WDZdLuM2wppFGfx/wXylfB3tk2EhQr96K19URKDLag1aLxf7dAG4FpP26SqyMK4QWKxaimOC0viAr3InB1Bg/y1H9LFIlqeOQcpDSbYHjQ0vMwjkbeP4A1KDF753+aTSszQhMkVk5rISIY0KZJwdAjIkxtTQdksKT+g7htsTlI/bxjihJmYErwFvc0aM/QaLS/cMnzUQj8sNzMZPlPAMa1IlBajFVJjasBuNPw676enGYMY8RCx/y9Qeq5kKCSKBy8vgtV36VvJcCl+OuYonFxTcoTDGr33YnH0zymhW9aTUpmOUVofHJWykMthf8rQ==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 18 Oct
 2024 14:49:16 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%4]) with mapi id 15.20.8048.017; Fri, 18 Oct 2024
 14:49:16 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, Alex
 Williamson <alex.williamson@redhat.com>, "Tarun Gupta (SW-GPU)"
	<targupta@nvidia.com>
Subject: Re: [PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
Thread-Topic: [PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
Thread-Index: AQHbILWack6lMwmTAEue5R+iehQETbKMmGKA
Date: Fri, 18 Oct 2024 14:49:16 +0000
Message-ID: <4085e18e-65bb-4b0e-bb72-f05e69996cbc@nvidia.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
 <5827f6e5-6de9-4ec1-83eb-b2e552092498@redhat.com>
In-Reply-To: <5827f6e5-6de9-4ec1-83eb-b2e552092498@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|MW6PR12MB9020:EE_
x-ms-office365-filtering-correlation-id: 1bf4f881-56ca-4a7c-2cbd-08dcef8409e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHVNQzhtWjIremV0Nm9EVEp4NnRQSXhBaHcxcFp4TkhXQW5iRkZUbzhKUWwy?=
 =?utf-8?B?SE5wb2M3dVRNZURrcXR4ZFgwNzlpZ0xFWFQyTThVWjJVK1hBY0pFblFvd3hG?=
 =?utf-8?B?S3pBY0FITThrQklIQ1hBakw2d3FlT0lvWmR1M0s2SG1BRUw4NU1nNUt1b0kz?=
 =?utf-8?B?Z1FKR0ZwMDBsdmh2VFRYZVlTMERpYng1Q2NMcTE4bzJaQUdrQk0xVjdVeCtU?=
 =?utf-8?B?cG9vbzNndFlxUytMbE9pYXVWV3pRUzZsVnFIdm1pMWNsSVg0VVRCd1dVcUVJ?=
 =?utf-8?B?QXdwZUkzcXlVZStxaVFFSlpsQ2U5ODNBN0t5dWxVM0hJb0FEUGVYcys1bEdp?=
 =?utf-8?B?Q21GYkYxYjBoOVhOVjFqaGJORExyQ2VhRlplckFGOHowY0NjbmpoTFFNME1B?=
 =?utf-8?B?blJtbm1iVjB5cWhzeGlPQkZpb3NvR1hYdHZiZnZZb2ZJVG55RVBtakllcjNP?=
 =?utf-8?B?Z2FiaW9DejlOUEZiZ25pczJnZDQxdXNiZ2tDKzhaT3VkdkdQMUsyU01lSmlw?=
 =?utf-8?B?WHROS0lNWDh6WlpDbTlXanFxRzV2UTFRTzRwUlVvakVCUHp3MXFUREI5MFBx?=
 =?utf-8?B?TENMOHZvaFlXclNFYjMrR2VhMHBxbmNzQnB0eHNER1dHbVVWdTE1ZFZOMnN5?=
 =?utf-8?B?Zk1xM3F6WDBMaS96Q0g5YkRJMi91NnNSMUwzeFJOd2NUbWVRQVU4T0lLV2hu?=
 =?utf-8?B?NzBHeEtIZzhINTFUUW9NM2FsTm9IbnZrSFlXbDl3cVI3ZTZFc3Jhcmk0N3RN?=
 =?utf-8?B?QzZ5Zkc3ZVpHM3FlQzBraDB3clY1YWFYaVNnYVdEbGZ2KytmeHRiNHMyZVYw?=
 =?utf-8?B?ckhtOVNkZGd2eW9sQXBid2hudXU0MytoRG51WFU3cGxra2tUQ0h6U3dQZlp4?=
 =?utf-8?B?RjFlcHM4a0RTTEdaZi9nYmJORFlQWjBUQWQ3MnM4Y3BrbkFGRHBvdHNibUVB?=
 =?utf-8?B?azVabHZrTWNDWUxrNi91Ny91dElxWWk4b3haay82bnhHVFdRRVBaTGl2M0dD?=
 =?utf-8?B?ZDdXSWhqdmtRR2I3VFF5NUoxWklGZHdBRTJaUDRJanFtanJyNjgrQm9vK2Rs?=
 =?utf-8?B?SjZQeGJVamlYOWVubnJwMVVRcE9uRWdRL1A0RlM0YnhXU0JjdnlhRzBkaWFt?=
 =?utf-8?B?SjMvangvTGlBeHVNMG93UFdWeVVuTG5ZNkw4MFlRYytDWi9RVnBMeS9mTGhH?=
 =?utf-8?B?bW5uM1lBN1IzQW1DVDBvMXhXbko0aUtKbHJGUVo0cTRXa2xyUmpjd0pmSTh2?=
 =?utf-8?B?MWlPU0ZBSHFDMnpBb3RQUkpqNnFvaUU1OUYvU2ZscjVZVmM4QjdzUnhlZTNX?=
 =?utf-8?B?WUw2ZmtZbXFXazQvUmh6QVM0dzgwMjFnUE10N1lncmZOWUF1cmZiNFJEbHlq?=
 =?utf-8?B?aDBLMURKUk1leVlKTWxGZzI4T0hJN1ZaVENiWUNmMzE0STZRMnRhcEtyMThZ?=
 =?utf-8?B?aVVvM24wV2k5bSt5VHhPVS9oRUlpSHdRRGdvd0V3cC9WblRVUFc3Q1M5TWVl?=
 =?utf-8?B?YXEzS2NzYVNqTmFBNWFsRXNZKzF6RFJWMkg4dEMxOXZZY0t6b0E4VFJTOUJ5?=
 =?utf-8?B?SU8wUEVMYmk0R0xUajZzNE1TNXltbjBrREJxSkZIbDI2ejBLc3lHZG4wUHZ5?=
 =?utf-8?B?RHFRbGdLL1loRTBBVThwTU10VVB1ZEFGM1JjYlk4MWxQRVZUbnZyTU4xZU1l?=
 =?utf-8?B?TjdvNSt6UzdwK3IvL3d3UGw5SktnYVVPaFlqMUxCR1RYMHpsREVNWjBOM0ww?=
 =?utf-8?B?ZktRU0xBNUh3MnREbFhoOFE3OCtzWGpsZlJRaVQvRTc3QnFKR3NMVEtFRzBE?=
 =?utf-8?B?UkNKZGZtREgxRC9CZlFjMTZBZnovM2JIejd5OXJaeXp5MzhuYWZMMGxqeDBR?=
 =?utf-8?Q?uBsrVA1dNIdyq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUFib0UvL1Mycmd2bk5mVFlYalozYnFsZjJWaklqN3QwVml0OTBiMURZTXdl?=
 =?utf-8?B?VWNzVUpRREpzZjVsd0JGVEp2am1tbDgybTVnUy9id3lnaG4rZ0ZQWXFIWWFU?=
 =?utf-8?B?RDV2QVBwTkloMjczdGtQdEQvZzZTOHJMYmZGWW5RU3BYVjIyVnNkTEtXaUdq?=
 =?utf-8?B?RVZrd1BiQ1VCSzBwTFJIVVRTaDloOEJoMW1haHFQTmNmZUlJN1F2NE1RU1Ew?=
 =?utf-8?B?Z2lsN2pTOEVxYVdsS1RXSkQyaDFwV2lWVm9SVm1pMlkzWmduSmpyY1BzQzVH?=
 =?utf-8?B?ckxjT3Z5Nm5uV3FSRVpac01TT0pzeDJteFV3QTZKY2JKdGI5T0RvLzVqVEt6?=
 =?utf-8?B?dXlqSnIvYkZrUUMwQURyaWxVV0NncUxQbUx0NTI5NVlCQjhFMXBXaE1XZGhl?=
 =?utf-8?B?Y0Z6Zm4weDI0MHA4WFNGR2N2R0RXazV6Tm1qbU5vT0cxaFlaYlF3UENBazJi?=
 =?utf-8?B?ZnZSd2g1YmQyTEpaUWpwdEdkNDNvclE4TENnT0dvSlBjTUlKdnRKb3lndyto?=
 =?utf-8?B?VWdBd1FyRU92V0xPeUF5eTJzRXJham5Sd2p2V3RndlpmOENWNnZaNTNndWZi?=
 =?utf-8?B?SnF3b09wa3VtbnF5b3BrUngxVlhtUzBWWDZscVJkYnN2Q3pvZ3N1SGF3Nm1W?=
 =?utf-8?B?QjdnT3R5YU1PUklUQjlFem5kY2QrYzBSK3ExMmFUWHN1SklnYVpwSWUvcVFz?=
 =?utf-8?B?YmR6VnNTWG4wQVZVM05hcU5SYjdMbGNJS0xIeEVNeGFvcnF2NTNRaUljcEtF?=
 =?utf-8?B?VkdYMWxvZ2FoNm5odlZpM0F3YVhjRk0reFB5U0lHaUcxNHB0ZjRRTDVPaC9H?=
 =?utf-8?B?d2VHV1NVcTNZSWdDZlVxUnRDN3NvQmRVRm1hNW53aGROa1dRcmFOcXNqYnM2?=
 =?utf-8?B?LzNDQ3JnenlXcDhOV3NlQXBPeWIra3Z4S2x6K3VVZXNSNE9yaGZhOFdVaFVL?=
 =?utf-8?B?bzVzUVk3WlF0a3FVeG0vcVFwNUlRU1VjNUZ0QWZJYUFibUdFL1JlK3BNTkEz?=
 =?utf-8?B?Tm5GaWt0cXgyQ3ZLRnpPRkdSWktmVDMvSWFTZkRBbjFKcFJXOEI4bDkvRUdZ?=
 =?utf-8?B?QTNqVFlKVkpRajBaUXBNM204empLVE1CSHJGV0J6WGpPRHpTSDc4U3lqb2pM?=
 =?utf-8?B?ODBSaXdOR1RtTVk3WEE0amhSZFJBRVlYOUgweUdqa0NQd0pJUml0SkJyZ1ZU?=
 =?utf-8?B?a3FRU0ZlTWhvd2VLNkN2RGVqd0drQUtUL1lHZ0NQQ1hNR010SE16dFMzenhs?=
 =?utf-8?B?K25Uc3NuUXg1RnY3LysxTnl3SHd6eU9GN0JSZTkydzlpalBtdlBjMURoZ2Vw?=
 =?utf-8?B?WGxJVURVcUNIdVR4Zm1XSTMwYzdBaGp4UTR6cDlFOGJyOEF1MGhzZFQySkVz?=
 =?utf-8?B?elNHMldUcGxOWHp5LzBCSnEyOUFMdUJPWktmbnZaUFJIaE10L0tIOVg2YVMv?=
 =?utf-8?B?RWM5eG9NTWREWGU4VTZOckw5aXRISDB1bTd6eDhVRzRPaDVjKzgzUmV4RmNV?=
 =?utf-8?B?YTBoTWxRUXNibUoraEhLcFB4NzB5YzVkY0ZpOUZSU3JYMHQzUDkvcXN1RHdt?=
 =?utf-8?B?Ulc3Y2FJQlc3ZytpV3BaME9ScWNDaUNVMWo2dHdESFNsMVUyTFJvMWVXazd3?=
 =?utf-8?B?TmxnSENYbWgweTZWR3B0WE1ZRHg1dm5qYWd3WjlHWFNhQzltSnFGdUJzNzFV?=
 =?utf-8?B?RGpOMkRtVzlUamdJb0lHVXZFbjVHRWp4K3RGRlpicWJaRm1BVmR2RU1pYWNv?=
 =?utf-8?B?anIxQThON2wvQm53Uzh5a2RML0QveUxuYkV6R3NGYkNGU2hRNi9mcE9Kb0ZH?=
 =?utf-8?B?dHEzbmgyT1N1eTJxVmFldXBqQUNnSGlFNk5jVm5ZbzRuM1ZiMlAwcXJRVmtF?=
 =?utf-8?B?NVYyOVg2eVB5bjgzSVptOTEzd0d4UC81dnIrNlNrZmJtdTdrbFpvdGVMbnBh?=
 =?utf-8?B?cnZyVGRMU2FyczlncTJ6SFFtYU5lb3JPd3hnVVdtaDFjZFhOUkIvUVpiT0ZJ?=
 =?utf-8?B?TTNsVGlQd1lyNGV6SUdlWmdLREhmbGJFUlVhODk2bWdtYVlrdzc3eXErUzhV?=
 =?utf-8?B?amZQRVpMcmVLWVpIL05NVlN2bzJFM3RwUGhuVzJSaTR2TWZTNkk4UnV0UDhV?=
 =?utf-8?Q?ZoDQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CD69057E8E4F949959E90777CFA2397@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf4f881-56ca-4a7c-2cbd-08dcef8409e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 14:49:16.0132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uiw59J9ti/0rCBtO2+DgAcuBc6zsakVahYUWRwKykEOW6kCR3FfC7mpa1ApkhW2m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

T24gMTcvMTAvMjAyNCAxOS41NywgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+IEV4dGVybmFs
IGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiAN
Cj4gSGVsbG8sDQo+IA0KPiBPbiA1LzE4LzIzIDA0OjQ1LCBJcmEgV2Vpbnkgd3JvdGU6DQo+PiBU
eXBlIDIgZGV2aWNlcyBhcmUgbm90IHlldCBhIHJlYWxpdHkuwqAgRGV2ZWxvcGluZyBjb3JlIGtl
cm5lbCBzdXBwb3J0DQo+PiBpcyBkaWZmaWN1bHQgd2l0aG91dCBzb21lIHRlc3QgZGV2aWNlIHRv
IG1vZGVsIGFnYWluc3QuDQo+Pg0KPj4gRGVmaW5lIGEgdHlwZSAyIGRldmljZSAnY3hsLWFjY2Vs
Jy7CoCBUaGlzIGRldmljZSBpcyBkZXJpdmVkIGZyb20gdGhlDQo+PiB0eXBlIDMgZGV2aWNlIGFu
ZCByZXRhaW5zIGFsbCB0aGF0IGZ1bmN0aW9uYWxpdHkgZm9yIG5vdy4NCj4+DQo+PiBNb2NrIHVw
IGEgY291cGxlIG9mIGFjY2VsZXJhdG9yIGZlYXR1cmVzIChCYWNrIEludmFsaWRhdGUgW0JJXSBh
bmQNCj4+IFVub3JkZXJlZCBJTyBbVUlPXSkgYXMgZXhhbXBsZXMgZm9yIHRoZSBSRkMuwqAgVGhl
c2UgaGF2ZSBubw0KPj4gZnVuY3Rpb25hbGl0eSBvdGhlciB0aGFuIHRvIHJlcG9ydCB0aGUgZmVh
dHVyZXMgYXMgcHJlc2VudCBmb3Igc29mdHdhcmUNCj4+IHRvIGtleSBvZmYgb2YuDQo+Pg0KPj4g
RGVmaW5pbmcgdGhlc2UgZGV2aWNlcyBpbiBxZW11IGNhbiBiZSBkb25lIHdpdGggdGhlIGZvbGxv
d2luZyBleGFtcGxlOg0KPj4NCj4+IC4uLg0KPj4gwqDCoCAtZGV2aWNlIA0KPj4gY3hsLWFjY2Vs
LGJ1cz1zdzBwMCx2b2xhdGlsZS1tZW1kZXY9Y3hsLWFjLW1lbTUsaWQ9Y3hsLWRldjUsc249MHhD
QUZFMDAwNQ0KPj4gLi4uDQo+Pg0KPj4gTk9URTogSSdtIGxlYXZpbmcgb2ZmIE1pY2hhZWwgVHNp
cmtpbiBmb3Igbm93IGJlY2F1c2UgdGhpcyBpcyByZWFsbHkNCj4+IHJvdWdoIGFuZCBJJ20gbWFp
bmx5IHNlbmRpbmcgaXQgb3V0IGJlY2F1c2UgaXQgd2FzIHRhbGtlZCBhYm91dCBpbiB0aGUNCj4+
IENYTCBjb21tdW5pdHkgY2FsbCBvbiA1LzE2Lg0KPj4NCj4+IE5vdC1ZZXQtU2lnbmVkLW9mZi1i
eTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiANCj4gDQo+IEEgcmVjZW50IHBy
b3Bvc2FsIHRvIGFkZCBzdXBwb3J0IGluIFZGSU8gZm9yIENYTCBwYXNzdGhyb3VnaCB1c2VzDQo+
IHRoaXMgZW11bGF0ZWQgZGV2aWNlIGFuZCBhIHNhbXBsZSBkcml2ZXIgZm9yIGEgcHJvb2Ygb2Yg
Y29uY2VwdC4NCj4gRm9yIHRoaXMgZWZmb3J0LCBpdCB3b3VsZCBiZSB2ZXJ5IHVzZWZ1bCB0byBo
YXZlIGEgUUVNVSBtb2RlbCBmb3INCj4gYSBDWEwgdHlwZTIgZGV2aWNlLCBldmVuIHBhcnRpYWxs
eSBpbXBsZW1lbnRlZC4NCj4gDQo+IEkgaGF2ZW4ndCBmb3VuZCBhbnkgdXBkYXRlcyBvZiB0aGlz
IHNlcmllcy4gV2hhdCBhcmUgdGhlIHBsYW5zIGZvcg0KPiB1cHN0cmVhbSB0b2RheSA/DQo+DQoN
Ckkgd2FzIGRpc2N1c3NpbmcgdGhpcyB3aXRoIElyYSBhbmQgSm9uYXRoYW4gaW4gdGhlIExQQyBh
bmQgQ1hMIGRpc2NvcmQgDQpncm91cHMuIChJcnEgYW5kIEpvbmF0aGFuLCBwbGVhc2UgZmVlbCBm
cmVlIHRvIGNvcnJlY3QgbWUpIEkgdGhpbmsgd2UgDQphbGwgdGhvdWdodCB0aGF0IGhhdmluZyB0
aGUgZW11bGF0ZWQgZGV2aWNlIHN1cHBvcnQgaW4gUUVNVSBhbmQgYSBzYW1wbGUgDQpDWEwgdHlw
ZS0yIGRyaXZlciBpbiB0aGUgdXBzdHJlYW0ga2VybmVsIGNvdWxkIGJlIHZhbHVhYmxlIGZvcg0K
DQoxKSBwZW9wbGUgd2hvIHdpc2ggdG8gY29udHJpYnV0ZSBhbmQgcHJvcG9zZSBjaGFuZ2VzLCBs
aWtlIHJlZmFjdG9yLCBhbmQgDQpjb2RlIHR3ZWFrcyByZWxhdGVkIHRvIENYTCB0eXBlLTIgc3Vw
cG9ydCBpbiB0aGUga2VybmVsLiBUaGV5IGNhbiANCnZhbGlkYXRlIHRoZWlyIHBhdGNoZXMgdG8g
Y2hlY2sgaWYgdGhleSBicmVhayBzb21ldGhpbmcgd2l0aG91dCBhIENYTCANCnR5cGUtMiBkZXZp
Y2UuDQoNCjIpIHBlb3BsZSB3aG8gd2lzaCB0byBjb250cmlidXRlIG9uIHNvbHZpbmcgcHJvYmxl
bXMgb2YgQ1hMIHR5cGUtMiANCmdlbmVyaWMgY29kZSwgZS5nLiBsb2FkaW5nIHNlcXVlbmNlcyBv
ZiBtb2R1bGVzLi4uIFRoZXkgY2FuIGdldCBpbnZvbHZlZCANCndpdGhvdXQgYSByZWFsIEhXLg0K
DQpNeSBndXQgZmVlbGluZyBpcyBJIGNhbiBzdGFydCB0byB3b3JrIHdpdGggZm9sa3MgdG8gZ2V0
IGl0IGludG8gdGhlIA0KbWFpbmxpbmUgdG9nZXRoZXIgd2l0aCB0aGUgc2FtcGxlIGRyaXZlciB3
aGVuIENYTCB0eXBlLTIgc3VwcG9ydCBpcyANCm1lcmdlZC4gU28gcGVvcGxlIGNhbiBwbGF5IHdp
dGggaXQuDQoNCjMpIHBlb3BsZSB3aG8gd291bGQgbGlrZSB0byB0cnkgb24gdmZpby1jeGwuDQoN
CldoYXQgd291bGQgYmUgbmljZSB0byBpbmNsdWRlIGluIHRoZSBwYXRjaHNldCBWMSBpbiBteSBt
aW5kOg0KDQooSXJhIGFuZCBKb25hdGhhbiBhbmQgZm9sa3MgcGxlYXNlIGZlZWwgZnJlZSB0byBj
b21tZW50KQ0KDQpNdXN0IGhhdmU6DQogIC0gSERNIGRlY29kZXIgc3VwcG9ydCAoPjEgSERNIGRl
Y29kZXIpLiAod2hpY2ggSSBoYXZlIGRvbmUgaXQgaW4gbXkgDQp0cmVlLCBzbyB0aGUgQ1hMIGNv
cmUgY2FuIGNyZWF0ZSBhIENYTCByZWdpb24pDQoNCk5pY2UgdG8gaGF2ZToNCiAgLSBDWExUeXBl
MiBkZXZpY2Ugc3lzdGVtIHJlc2V0IGhhbmRsZXIuIEFzIHdoYXQgbWVudGlvbmVkIGluIG15IGNv
dmVyIA0KbGV0dGVyLCBhIHN5c3RlbSByZXNldCBoYW5kbGVyIGlzIHJlcXVpcmVkIHRvIHJlc2V0
IHRoZSBkZXZpY2Ugc3RhdGUuIA0KTGludXgga2VybmVsIENYTCBjb3JlIGFzc3VtZXMgdGhlIEhX
IGlzIHByZS1jb25maWd1cmVkIGJ5IEZXIGlmIGl0IHNlZXMgDQpDWEwubWVtIGlzIGVuYWJsZWQg
d2hlbiBlbnVtZXJhdGluZyB0aGUgZGV2aWNlLiBTbyBJIGhhdmUgdG8ga2lsbCBRRU1VIA0KaW5z
dGVhZCBvZiByZXNldHRpbmcgdGhlIHZpcnR1YWwgbWFjaGluZSB3aGVuIGRlYnVnZ2luZy4NCg0K
ICAtIENYTFR5cGUyIGRldmljZSBpbiB0aGUgcGF0Y2ggc2hvdWxkIGJlIGRlcml2ZWQgZnJvbSBQ
Q0lEZXZpY2UgDQooY3VycmVudCBpdCBpcyBkZXJpdmVkIGZyb20gdGhlIENYTFR5cGUzIGRldmlj
ZSwgd2hpY2ggY2FycmllcyBxdWl0ZSANCnNvbWUgdW5uZWNlc3Nhcnkgc3R1ZmYgdG8gcHJlc2Vu
dCB0byB0aGUgZ3Vlc3QpDQoNCiAgLSBSZWZhY3RvciBvZiB0aGUgY3VycmVudCBRRU1VIEZXTVMg
Y29kZSB0byBkZWxpdmVyIHRoZSBndWVzdCBhY2Nlc3MgDQp0byB0aGUgdmlydHVhbCBtZW1vcnkg
YmFja2VuZCB0byB0aGUgY29ycmVjdCBlbXVsYXRlZCBDWEwgZGV2aWNlICh3aGljaCANCmlzIGN1
cnJlbnRseSBoYXJkY29kZWQgdG8gY29ubmVjdCB0byBjeGwtdHlwZTMgZGV2aWNlIGluIFFFTVUu
IFdpdGhvdXQgDQp0aGlzLCB0aGUgYWNjZXNzIHRvIHRoZSBDWEwgcmVnaW9uIGZyb20gdGhlIGd1
ZXN0IHNlZW1zIHByb2JsZW1hdGljIGJ1dCANCmNyZWF0aW5nIENYTCByZWdpb24gaXMgc3RpbGwg
ZmluZS4pDQoNClRoYW5rcywNClpoaS4NCg0KPiBGb3IgdmZpby1jeGwsIHNlZSA6DQo+IA0KPiAq
IFtSRkNdIHZmaW86IGludHJvZHVjZSB2ZmlvLWN4bCB0byBzdXBwb3J0IENYTCB0eXBlLTIgYWNj
ZWxlcmF0b3IgDQo+IHBhc3N0aHJvdWdoDQo+ICDCoCBodHRwczovL2xvcmUua2VybmVsLm9yZy9r
dm0vMjAyNDA5MjAyMjM0NDYuMTkwODY3My0xLXpoaXdAbnZpZGlhLmNvbQ0KPiAqIFtSRkNdIElu
dHJvZHVjZSB2ZmlvLWN4bCB0byBzdXBwb3J0IENYTCB0eXBlLTIgZGV2aWNlIHBhc3N0aHJvdWdo
DQo+ICDCoCBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA5MjEwNzE0NDAuMTkxNTg3
Ni0xLXpoaXdAbnZpZGlhLmNvbS8NCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4g
DQo+IA0KPj4gLS0tDQo+PiBJcmEgV2VpbnkgKDUpOg0KPj4gwqDCoMKgwqDCoMKgIGh3L2N4bDog
VXNlIGRlZmluZSBmb3IgYnVpbGQgYnVnIGRldGVjdGlvbg0KPj4gwqDCoMKgwqDCoMKgIGh3L2N4
bDogUmVmYWN0b3IgY29tcG9uZW50IHJlZ2lzdGVyIGluaXRpYWxpemF0aW9uDQo+PiDCoMKgwqDC
oMKgwqAgaHcvY3hsOiBEZXJpdmUgYSBDWEwgYWNjZWxlcmF0b3IgZGV2aWNlIGZyb20gVHlwZS0z
DQo+PiDCoMKgwqDCoMKgwqAgaHcvY3hsL2FjY2VsOiBBZGQgQmFjay1JbnZhbGlkYXRlIGRlY29k
ZXIgY2FwYmlsaXR5IHN0cnVjdHVyZQ0KPj4gwqDCoMKgwqDCoMKgIGh3L2N4bDogQWRkIFVJTyBI
RE0gZGVjb2RlciByZWdpc3RlciBmaWVsZHMNCj4+DQo+PiDCoCBkb2NzL3N5c3RlbS9kZXZpY2Vz
L2N4bC5yc3TCoMKgwqAgfCAxMSArKysrKysNCj4+IMKgIGh3L2N4bC9jeGwtY29tcG9uZW50LXV0
aWxzLmPCoMKgIHwgODAgDQo+PiArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4+IMKgIGh3L21lbS9jeGxfdHlwZTMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDM5ICsrKysrKysrKysrKysrKysrKysrDQo+PiDCoCBpbmNsdWRlL2h3L2N4bC9jeGxfY29tcG9u
ZW50LmggfCA1MSArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4+IMKgIGluY2x1ZGUvaHcv
Y3hsL2N4bF9kZXZpY2UuaMKgwqDCoCB8IDE2ICsrKysrKysrKw0KPj4gwqAgaW5jbHVkZS9ody9w
Y2kvcGNpX2lkcy5owqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+IMKgIDYgZmlsZXMgY2hhbmdlZCwg
MTQxIGluc2VydGlvbnMoKyksIDU3IGRlbGV0aW9ucygtKQ0KPj4gLS0tDQo+PiBiYXNlLWNvbW1p
dDogOGViMmEwMzI1ODMxM2Y0MDRjYTBjODYwOWE4ZjkwMDliOWI0MzE4Yw0KPj4gY2hhbmdlLWlk
OiAyMDIzMDUxNy1yZmMtdHlwZTItZGV2LWMyZDY2MWEyOWQ5Ng0KPj4NCj4+IEJlc3QgcmVnYXJk
cywNCj4gDQoNCg==
