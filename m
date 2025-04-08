Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63202AE74;
	Tue,  8 Apr 2025 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090718; cv=fail; b=BME0swS0ziLhWFBs6bNYDHqpvAVZKMuDdtDvne97HKfLzSHF5Hh2Rf+/mJLqhnlboKcMZaK2C1hES7+ia9uaL48jcV/dgL8f0K+GsIsdFTitoeXmNnVspcyXIcegETsLMgnGp42PrBEAqzVx2g/RlizfZvNa89D+prExQx2Da4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090718; c=relaxed/simple;
	bh=iQ9P2G4KO69VxplDyJPPZ2eUwe7CIFpz6V45a100YFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOAUpLd+Xg/9PeZSbThoZ0JI2FIiSQ1oeLKbXmfYQzVXd95A5S4FCbDZNafwxpi+e1GARLcRLX22o0D9axJ88icLtkDQHe8nvWUw+ws+/gJBsGz/fDr6WUgcuLtta4Y6EP4RGurSO8ZwySTLwkIFPzT4gs8zyM54qqrfBAwD2G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Y4UWQlQI; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Y4UWQlQI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744090716; x=1775626716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iQ9P2G4KO69VxplDyJPPZ2eUwe7CIFpz6V45a100YFE=;
  b=Y4UWQlQIYfe6DwRR6WwWFU9c/5bHcFW2yB3O/j3dSEkYK45KQ4oNq+Pw
   OlspMkZqnrkRKnOHlS1/tVSMA7rbNoFIjUdulilQAI5jzGi6WiBzSn4sP
   pqJ9R76qdgDII+pJj9+SGH7jHcw4cjfy+M4m8YEZg9sjwjwLRlVucbO+9
   BhZOFFAWEL4LGVZ5/YsUeQPdyMJFp+trLs+5Iva/aapL4HYcS1ULUrXhl
   KWcAFZrUT1jMp3HHD3b34Po0wwKB3RRcdH+/xyCOdC1YAP7g9Vn0YjSpo
   v+Rxa9oFm8Ldhue9QDkBv4FjLdkDPszXZLFNX2AOWR8sBXOJmKU9fEw48
   Q==;
X-CSE-ConnectionGUID: V5W76cD8TU+PifF6IuHZUw==
X-CSE-MsgGUID: lRqrpqJARcuLdQK74rMn6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="152077252"
X-IronPort-AV: E=Sophos;i="6.15,197,1739804400"; 
   d="scan'208";a="152077252"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 14:37:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjWvzqxCN3P4BuiuR4zlhLSn8PF8/ImjvR0gXhFDKbCywFD17n00lBKqEZHFTewvwgjXu5tGEk3tfb43Z7V8EfNpZKBd0/HtnocGexYyRkxjVrpL+Wr12TiArIKOQATn9EyfsG80aiampMRTMH7xVCaECNmUgPGYqOT05pMCIL7CxyAnTaqe2HIFaDVRUmiHFDkDhdNAFi+xc7BcIKCCtFLjBU00u1C+MI+S+vQgeLnCWV4QJ8/is+bDNpN9/nkkyLFwjjPGb/ZBbvCKeZswKUlK8OVtIFwudtJkC2Z8H0xcuGk7BHz3tjbMwrjA4VVFTLGyX1Q+obCyOqdxre1uYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ9P2G4KO69VxplDyJPPZ2eUwe7CIFpz6V45a100YFE=;
 b=fwpujL5TDvK3kSkJ213AfeHLfUSUS42v/t7HfVYVQsnNAkao0FF4Dtfd+6PXJx4hjX7EAU77fACNaSrdrWidWORQd5/12Lvwr3TJDSbsXqUD5JqHRAFk0Lp63X3c2Awx9anvBuOU7ZhH3bz10HOhoQYIwytoHh7x7wDdkrJNa1PxCMqXQAEMVXuBVXtDvoihD7xUMSyvMmpX1Zee4bH0eQoMMb7ja1ylVJgnyK4vtE3oiKE3d/qwc9ho5wac9XH0K5/WIIDUoiGMNBA/ZjfrnohJrv61Z/pQB2SS7baH68ak/4RAWydvb8K2HiMLN3cTLVZ0BPL3xzg9CCgg2pHy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY4PR01MB12733.jpnprd01.prod.outlook.com (2603:1096:405:1ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 05:37:17 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 05:37:16 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Gregory Price <gourry@gourry.net>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Thread-Topic: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Thread-Index: AQHbjvNia1PhMmp5z06r6vu5ANRYCrOQF8EAgAB+mQCACLNIgIAAEfCAgAAXGIA=
Date: Tue, 8 Apr 2025 05:37:16 +0000
Message-ID: <ed9880a0-0dd5-4ae0-a9d0-d871fae200ac@fujitsu.com>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
 <Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F>
 <cf7b97d8-4393-424c-89fc-aa810d907a67@fujitsu.com>
 <Z-1HPqufU7MnQ6ii@gourry-fedora-PF4VCD3F>
 <fb2e8912-9a64-4053-bb8c-dcaceb669731@fujitsu.com>
 <Z_Siq6JrfST1T7la@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z_Siq6JrfST1T7la@gourry-fedora-PF4VCD3F>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY4PR01MB12733:EE_
x-ms-office365-filtering-correlation-id: 47b38687-5627-4e46-ff1b-08dd765f6bf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?UEZDV2VBS1dYZmhPeWpNRUlhS05JYXh3MjUyZUVNVmVmaXV2NUo1SFRDRG1a?=
 =?utf-8?B?dTRueDlrdUZoZkhkWjlGUWtvOTltck1ZOHk2bVdYRSs2Wm1SMWt5V2hJY3hD?=
 =?utf-8?B?UVdLTGxNbUUyZ1RyQ01GMC83dlg4NUV5SVJ0N3NrclNaL2RsQTUyY0NMM3dn?=
 =?utf-8?B?M2N4cml3SUk4NXNXQ0xtdE53T3ViL3B6T01GemFSSlZsVWtZb2pxRjByUTBE?=
 =?utf-8?B?UG1COTl6MGF5UWErK005WGZoaWR2S2w5M1ExRnJPMWFIU3M0QmVCSHF6cUdC?=
 =?utf-8?B?RGxuM3hIV1VqSndoSmJmeVprcU5zOXZsTkkyRmp5bW9LU3NGdHR5aUNMWWZK?=
 =?utf-8?B?NDRER3l6dy9DSWxQUitrMFFucDg5VUx5a1J1dTh2a1ZjMXJrbVJMdS83N3BW?=
 =?utf-8?B?c3dxQWViTWU5R2FGSXNSRTBHSzJvRU9OT0tmYlVvZ0Q2WWtkTktqa0Y4ZEhi?=
 =?utf-8?B?ZmFuQ01ocTNwaHM2bFJ6eFJkWjlFZzlPalN1RXB1TXFEVHc3bWVrSWFmYkZQ?=
 =?utf-8?B?Z05BSEZ2RTRKODhFbDIzTEtOTkpITnUvcTcxRmxCMUpESjlBazZSQ05OSktX?=
 =?utf-8?B?dVVzOHJlcXdDTEZGcDljQnliSkRWL2UweUNBbEs1NVRoRS9vRHZRc21WQUpq?=
 =?utf-8?B?Y1IxRTJkeDJDY1VKb3lrQTlNK0VadC9PLy9tNzFwQmtraU9VZGJpbWk1cUgr?=
 =?utf-8?B?aERmNGM2MVB3VmEycUoyOWN6dFZtSHZzaWwyWTd0eG0wNFRUZ2plOTU2cDYz?=
 =?utf-8?B?VkYwZ3lMZVNPZHRleUZ3bVk3aXFhN1p6elg3dmNZNXc5R2xia1QvVjR4VHp3?=
 =?utf-8?B?Tmt6eUlQUFV2WVA2ampWdDJ3aC92ekRlMXByYlRBejdKeFpiWm1RZHBnb1ha?=
 =?utf-8?B?Y0N1dXcvRHNTU3R0TmlLVjRVc0JicGlYRDdINmZEWEhNM2VudUozSnNHM01Y?=
 =?utf-8?B?NGxYd2lWWmgzbmQ5RGhJSFpKbGY0Zk1nZW1DZ3hQUGZYSEs0eC9PTms4d2V1?=
 =?utf-8?B?UXJZanpmYmxpL05NZVE3a3VCVjdMZDJkNFhWQ2F6MDFTVE0weFFyNm1mQkR6?=
 =?utf-8?B?UkpOTjBsam4raG9FUUdZZWM0QUY2N1NxMFY4RzdlSVArQU5TM0R6NXE3VEo5?=
 =?utf-8?B?S2haZHVMOUJ0R1I4cDQrcUhiVzdTSXBOYmtjZVNOcnltdURrK3p3OVU4U1VF?=
 =?utf-8?B?UDkxYmw2aGtMQVJsemJYN3UzalJjZmRPQ1J4NjhJb21zdHhwSUVrSW5uV2RS?=
 =?utf-8?B?MzE2YkEwVEsyaTdqcGFJalFkSTFXSWJxOGUvczdpalJUd3B1K01FMFdHRkdk?=
 =?utf-8?B?ajZ5RWZBQnBEeStCWEo2Nk1yOFRMS1hGUDdVUDhGT0JUQnVQMk44ZysvRVFG?=
 =?utf-8?B?dUxhUW1zUTE1RHYwaW9TNXJXTUpCVWJmd3gwVHd3KzBBZzhNeE8wcFI2MWh6?=
 =?utf-8?B?NXk0dHpzV2FHOTNka2wrL2h5QXo4UmZWOW92MjhRTjJVaGlnU3VsMHNkdzBW?=
 =?utf-8?B?ZFRWdkpVQmlmdzFrMi9FcEVEYW1XdndCQStCRHlDR1VmTmJXVkpia2c2Z1ZS?=
 =?utf-8?B?VmhFZm43a0pMRG5QZXF0VWdNeUk1OG1SQXFmM25FUktYNFArRHRpWEg4cndU?=
 =?utf-8?B?bGd4byt1emVlTFZBR0FMblJtcU9xQUxtZTA1NVVhS0ptc3FkWXh0Um8ybUNz?=
 =?utf-8?B?YUlwTFFpYm1XdWoyRy84cy9WU2ZXMmVMWnBjdG1xcEhWenVMUzkvNkhoY1hT?=
 =?utf-8?B?NlROOFZselFKZmhjZE5LT0dBNENFTW9uaE5VNTBHWUdXamphY1A0ZkRwRm5k?=
 =?utf-8?B?Rk1GNklGYTNRaW56Y050VUZxeEJHRGNQMytveVN1eUhneDVpZHovVXBiaG02?=
 =?utf-8?B?eGZPdUVZMDRQKzBsTnIwbGhONStMRzBrVllmYmI4QUd4VGxkNFM1dUxRdUNh?=
 =?utf-8?B?d0tpWUR3NWxlTFEwbXRmT3YvQVoycTRGN2E0M2xlblZ3cXNsR3gvNEZzMy9l?=
 =?utf-8?B?b0o2S1Z0RG53PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmVSc01FU1Q3R2s4d2xhaWRPSG53cEQ5bDF5dHZBNTlTa2NTK2tua20zQXhy?=
 =?utf-8?B?bzlEK3YzM29xOTA4aERZVmJtd0l2dFQ3NjczdENSWnJxeGRJSEdqcHUzRHRw?=
 =?utf-8?B?MTNYVVRTMjZUTXMvcHBQbzBMTEhhVCtmMDA2NVlWMG1oam5lNlI5RllLbHNI?=
 =?utf-8?B?cXh6Q0VaanhuSWhJQXFIM0VmUTZocWVFaGJldmExSy9vSmEvUzJPRWVQM3dW?=
 =?utf-8?B?QkZKT0RWUUswK0NmckxNa1FIQ2FEQkdiRnhVWDA3MytrQStySldhM0pVelFr?=
 =?utf-8?B?ak8xbGVVVGYvWHBWNEJ1ektVa2Uvdmo0cDhmcExieC9Lcmh1QmVtLzJKZitu?=
 =?utf-8?B?azZwekFWTmxReEQ4T2xsdEVESUljMmUyN2ZNblludHVKWHFwMzZJQi9QR2h1?=
 =?utf-8?B?RGpZbDk3NnlCblo4cFBXNmNrT1lCem4rVFNucENMTmNpV3Vhd1gzWUFxS0M2?=
 =?utf-8?B?dmVzMFBqL3cwMVRQRkdqenhtYWxYMVovc1NsK3h0VjJodEdQc3JuM29MTFNH?=
 =?utf-8?B?eG1QY2NQSTgrYWo0cjNEcFBLRDQwTkVvU3VMVkh4WitvNGFSclh4MWl2TVZq?=
 =?utf-8?B?S2JXMENrK3VhdEdMbTlKQWptdWRTUjg5RnRKTkNBVjZoYUYrdC9abEZBQXZm?=
 =?utf-8?B?L2FNbHlHdTBuaTV3NGlIaEdzNGFHRC9kQmNINm5nbHFZS0hqbHU2SW8zY2h1?=
 =?utf-8?B?ZDBkQ2lFdFNvZ3BwaE9YSU9kUHZ2Zmh3NDVndmllbUE0YzNRcDFLU0NzcC9t?=
 =?utf-8?B?c1dic2xkNHQ0V1pKY0FGT2JaYjB3Y1R3OWxWcWNCYzMvQVIzbG5ubCtDb2li?=
 =?utf-8?B?QzVsL3RxMWdVZEhLSFo2R2lGaUx2WUVMWVdFdDNqdnlqaVZRdzZQYzNVSTVH?=
 =?utf-8?B?bkMyNS9WVWJLN2RUSVJVOTVENFo5M25taldvYjFxVnBBNlkzTVBWTkNmRnE5?=
 =?utf-8?B?UHRHNVFZSkxPS2FSajZUaU9PNGxteVBOOWtYaVU2dVdqYXZNcEw5VGdaUzM2?=
 =?utf-8?B?b1lpeWZTZk05a3U1UFhRZGpZUGZjK0htei9pVnZXS1FEa2xlL0NkRUYvdlVa?=
 =?utf-8?B?bkhVZ0pyRUY2aklVWkh0TmJ6R3BhT2xvVkFkQVJTTTNiNW82TFNlamxwK3NC?=
 =?utf-8?B?bmU5K0VrS216SW53YTFPZVFLeXR2Z2hKMHR4a0h2WGwxRW1BeDlMT3FSVHBB?=
 =?utf-8?B?QllFRStmMHZxZVRwQ2hiaHdjVDErWmRGYnhvenlXdjg2eEhhVWgxUG9aTDNo?=
 =?utf-8?B?bE8xTFJKc1daMkhIOXpWQm0wMjZQRlpxakpXS1BSazJ4eXQ3ZnAxYStqTnUw?=
 =?utf-8?B?ZTJBSUpyNStEUWJpR3E5VHRTcXRBak85NHUxSGZKT0dvckgzTHVuREJ3aEVn?=
 =?utf-8?B?eHI1N2l1ZElpMzlJUHpPYUQwSldLT2Z0WHhmdXFsWGNReVJtQ1VQOEUvbGx6?=
 =?utf-8?B?V0lMMkRjeldHOW5tS3FkNjF6Mmd4MXFjaHc1ZzBZbkIvNC9tWStHckRyUXk3?=
 =?utf-8?B?V2krOXMvZnJ0bjdJVWFIb2U5VE1UdkFaZXJ6NmF5USs4ejhYNUMyYVZKVGdJ?=
 =?utf-8?B?QS96SEcybjNGdDBXMEQ1QWlLeDdRRDVkUzhhTHg4a3FqL2Z4S2ZGNGQ4WktH?=
 =?utf-8?B?MTkvR3czRUVXWFFnY2xHVTBOMStNMmZEMkY3ZnhMbGtzaG5FQ1gwd3FoQ3NZ?=
 =?utf-8?B?SkhMSmV0WUxtRmkvQ2hmSTZodW5pR0JvT0oxMGJxOG9KNjNPU3hLWXJ5UENL?=
 =?utf-8?B?aGFpUzJKUStBSGNYdzluYVBpTlFTMmdqODZsQmRkdkJDeEg1TENOTnBqMVNp?=
 =?utf-8?B?SDd1R0ozaktvc1V4M2kwdDB0TDMrT0xBQmxyZEVna1JxdVRUdVFWd0gxR0ZZ?=
 =?utf-8?B?NWZxSjRGdWJVUVZsMVQwSk5CT2hoY3NlMmxINlB6Wlc2OFFmdU4vK1ludXY0?=
 =?utf-8?B?NHRiSWY5NkZUN0loelMzL2JSeHlYOVVQai9YQmNpWXpZZmhJd1ZNeTVIcWpY?=
 =?utf-8?B?ZzVMSVRTNUZScFFVUFoyYVNwQ2JrMk5UN282U3VwZGVmNVJSWmxlb2Nac0Iz?=
 =?utf-8?B?ckEyTDUvTEJaNVJzdk42dTRkR2dqNm5KS3BqVzdhOU9Na2VFbWREbUM2cmVX?=
 =?utf-8?B?RGp6V1ZuNi92NmdycEJSaUtCK1NNaEpqNEk4TzJYR3FYcFRvNmhlOU5RT3FZ?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D80A90760E4F54F940B6CF18C025748@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NTxJ6MF2LUTiifi6NlXz9p4i3InrD+HRPPrRbaSYssUELgR8wpuPf5L+rdpAqoNpjhp43L+0AgH2JZELUfUbIM7PlJABUelc65KYJpR6P2jl35/BnzYlOMjYh2aW92NHh2VjX0EzBztZ+fJQPmpmZ9/AKcwlHvBO9LczMnfOuhDyRKaTH9jdB0gTzem0ff6i7jZ5r+4hOzmyLMEWb2dFCOQmt/ZtNVAO1YJgIzfInfzvj2NbQpIyt0tRhYdvoJBKf59W1OSFCuHCSUpqwTU+3vTtsO7DQcBqBuve6GaMcQ+lw3IihTUOD23iwpyyicWPXRME6WcB8AJ1KBz/R4q2dpltc6CoCLAY6s8QhHqGLNAz/uSqE1h9UtsOh4tyYpEoMpUcYzn+78XPiF9ZyHrq+Pq7q0U8LhweVZPoAOh6pF9A9QT2XAQKTeR0odc+bbi4OUNjfQIEAWJGjFWo4K91qz8XW/ItkbeR/cdkUkKkF1jF73/uoHPrW6n8pSTrUWqV6KkyHGsZyFGMuL3nsaiojN4n3mqMn/Ect+QNudIYHoK6OODUjg0Nv1ZlS2ilORL2yb4eH5t6hxBKC4f3gCg10kQR9X75OJR0OvwT558ERDxPiPL5jE9tP4u1ap9jJUe0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b38687-5627-4e46-ff1b-08dd765f6bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 05:37:16.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eePbA50bJTWkV5yJSfiWZ69l8SHyNxq1jUfuMNmtbe2bYMyJl45bJ/7iCafB4oN+ou+mvbPOH4Q9TN2PhX9Gng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12733

R3JlZ29yeSwNCg0KDQpPbiAwOC8wNC8yMDI1IDEyOjE0LCBHcmVnb3J5IFByaWNlIHdyb3RlOg0K
PiBNeSByZWFkaW5nIG9mIHRoZSAzLjEgc3BlYyBzdWdnZXN0cyB0aGlzIGlzIGFsc28gZGVmaW5l
ZCBieSBpbXBsaWNhdGlvbg0KPiBvZiB0aGUgIkltcGxlbWVudGF0aW9uIE5vdGVzIiBhdCB0aGUg
ZW5kIG9mIHNlY3Rpb24NCj4gDQo+IDguMi40LjIwIENYTCBIRE0gRGVjb2RlciBDYXBhYmlsaXR5
IFN0cnVjdHVyZQ0KPiANCj4gSU1QTEVNRU5UQVRJT04gTk9URQ0KPiBDWEwgSG9zdCBCcmlkZ2Ug
YW5kIFVwc3RyZWFtIFN3aXRjaCBQb3J0IERlY29kZSBGbG93DQo+IA0KPiBJTVBMRU1FTlRBVElP
TiBOT1RFDQo+IERldmljZSBEZWNvZGUgTG9naWMNCg0KR3JlYXQsIEkgYW0gZ3JhdGVmdWwgZm9y
IHlvdXIgZW5saWdodGVuaW5nIGd1aWRhbmNlLg0KDQpNYW55IG1hbnkgdGhhbmtzIGFnYWluLg==
