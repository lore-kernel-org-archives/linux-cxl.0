Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2128.outbound.protection.outlook.com [40.107.223.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C913C9C8
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989072; cv=fail; b=RerJd6Gkw25XLWj5tfL478xYYZlpvX3lHiR8FCn4jCFQV+UmJzPgqwCxghkL70IW8YUpJXDKqyzQDd/bvouf0mleCoOoAytrhojv5OAm2i2m+Q5eskQflpmySdRVRo0bG9A89PS0teSeEn6xj9kgD2GMlBl4uwza6cEeoBgIAjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989072; c=relaxed/simple;
	bh=a3chGYz40NH+1tOj9J+3vAQ33JJx6r5pMZAwyiD1jvw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AQKOyNUWQXTE95m2stjHzijtrYZ27AJr34P/rBQi1rDfj7b9YXCLv71EA8nm66qRKSniq3uW8OyXEkK13GOgcqrSlWCg2HVaMYXH2DwwQglm03hh6qFcsItlRX9Q9d9EGtaiX4Q8+B+AQx1kDoLHpCx6hYche9RQOgkq7IqHXZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=oFkMnGja; arc=fail smtp.client-ip=40.107.223.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="oFkMnGja"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g55Kk5uHkPEg9DU3RuzM0fiMyRbsuRWMwmddOqEUHYt2/ExqQoqNhtVVvzlqAFuf8nWDBzMK7zJCiPgSwraMrQAwnfOoE1ZR+g/v4pp4t+Nmm7TZcQj07sbrxdybeYOJswGdTYrVdn8R94tzr1W7YXzqQ7EePoYI+6v4YOR8f8aMjvHKNt6aosUj4hNklL12qNtNSzU2UxmgVQ7dt+D6pUMV0G/gu9zOV3zOt/BRWsF26ZZRVSacxX8FKUju0lrqTeK5XxwUpFZVl4EpUCxd+oazw1dYqDyeK6s+qgaB4UbBvSKUuohrRn5vS0QVYlZvmYGWrEyOjq3m5Jkm4Py6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5M1rRrfg/O/7uLkDuQ5P9LfaGKsdcr+uqSTJGUCooQ=;
 b=k6vimMy+JjBXNWZv6URmHqMt3UaGbxLwSHwXNZUzMlxlgW+KZcOdCW7flwAGFYlD1/2BwGOj3lq+J1sVnXn/FVHylt/Arw+d2EtcoVYyP/IyQoEf9e1CGfukCpkezaufanW8b+lcuBzu7/jX+ESkC6jp4HZdEXcBHBohGRr0FUnFnvceRUeyGX0ZXOSb5nTukLhE8Hk64pIBnS3R5sW/QGlM0ty016ZcXuOmujOEOxUJhaMvnSq5LPEJr4rPBC2/21wztfmKbIIbMd7eLwMKDMput0+MFr4bccFwOycHO8JNtFF8jve7ZZlKEmZx/w2R26F2dJt7mU5n44+i3LuxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5M1rRrfg/O/7uLkDuQ5P9LfaGKsdcr+uqSTJGUCooQ=;
 b=oFkMnGja1Qit5IPpbn5fSztELnfFyvTC+fpDQty/V3tTWrHWtbkeOFFYua3aEGqZgU4mJSype77lpPxE5DIvvZ4NjEmJP7ePqmqrBJsJUR4n/fsVUlvNIwYp35OjiBvomH8bB+GWHK0daJVsAAY3Rjbzyxnb85hiKorJmMnhAYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from IA0PR17MB6347.namprd17.prod.outlook.com (2603:10b6:208:435::22)
 by SN4PR17MB5846.namprd17.prod.outlook.com (2603:10b6:806:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 20:04:26 +0000
Received: from IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a]) by IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 20:04:26 +0000
From: Svetly Todorov <svetly.todorov@memverge.com>
Date: Wed, 24 Apr 2024 13:04:07 -0700
Subject: [PATCH RFC v2 2/3] cxl_type3: add MHD callbacks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-cxl-2024-04-22-pullahead-v2-2-a87fc4597795@memverge.com>
References: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
In-Reply-To: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
To: qemu-devel@nongnu.org
Cc: Svetly Todorov <svetly.todorov@memverge.com>, 
 Gregory Price <gregory.price@memverge.com>, jonathan.cameron@huawei.com, 
 linux-cxl@vger.kernel.org, nifan.cxl@gmail.com
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713989063; l=7417;
 i=svetly.todorov@memverge.com; s=20240312; h=from:subject:message-id;
 bh=a3chGYz40NH+1tOj9J+3vAQ33JJx6r5pMZAwyiD1jvw=;
 b=VpwbNRGlx9XMBlytQJuynsx3S9ft/AxXCRbQnomkFCz1/57Xjli6amTmUr5nbsFya0f7TpTL0
 aJftVMpL9wnAjmHyu6jsbWTqTE03Spk66dEWfiujGFuR+5YIlkjLUrb
X-Developer-Key: i=svetly.todorov@memverge.com; a=ed25519;
 pk=bo0spdkY5tAEf+QP9ZH+jA9biE/razmOR7VcBXnymUE=
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To IA0PR17MB6347.namprd17.prod.outlook.com
 (2603:10b6:208:435::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR17MB6347:EE_|SN4PR17MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: dc54affa-a2bf-4ed4-3a65-08dc6499bdaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGpyeDJsSTJUUThuOGNwWGJxcmdOcG9RcnBzaG15Nkgzbjkxc1BKRGxqMlYw?=
 =?utf-8?B?ZHZYdCthaDNkdnlNL3NNVzRJTWFNbHM5b3BYN3BMNWZTTEMvdVdQV0t5R3U4?=
 =?utf-8?B?OTNGbytzWURka1YxUVYzV3d1WUZNRXNSV1NaeDNSbGVKZEkzblNKaGlCRGlP?=
 =?utf-8?B?SnU4QWo1U1RxWnlMNENoVk1La1pnTEpsM0ZUV2gyOVAxS1ZPYkZiR3MydG80?=
 =?utf-8?B?Y0NsRHF3TXUwRUthTUVvdnhNNTJrcnRkNVFPcjVwR3hNQWxBUkdlMjA1SWhM?=
 =?utf-8?B?UzBZM2VyR3paTmpTR1Evb2JLbDBWSlNSaFdkaXlmWGdiSk5pbGpqRENNemVk?=
 =?utf-8?B?eGdISmZFSFBZbFdnNDA5djBHazZ3dm5FTDE2TmZ2bi9kQ2wxM2tiOHY1WkZB?=
 =?utf-8?B?VUw5YUZENmV6M1ZHcm8zdis5MHNNZytNcUJGY1BOWkIxZmUzWDBsSk5jMG5o?=
 =?utf-8?B?TkNTV3pycFd6Nlp2L3gxRzB2MVBUMm9zaXJSVUlsNWt0WFpBYTlOdWdtL21N?=
 =?utf-8?B?a05yVEh5aFViUXhHbUhZR0dYUGF2cXFnQnVCaDZKV2FTV1Uya0Zka202VHJM?=
 =?utf-8?B?SkV5Z0prenFSY2pGQnBSa1hGZXIrbnltcWdROFc2UmN6TDBybUlMSUNwU0tW?=
 =?utf-8?B?WTVxWSt3OVhVcjVqMWVxMWlabFBKbE9Ud0xZN3gzbTlReWErbFluT3dFZmdB?=
 =?utf-8?B?UkVYeUFJSG9Md1RMZm9JbWFnSTVVUHdxUC9aMllXdkVpajdlY0ttR1RJSFlG?=
 =?utf-8?B?SkxJR05WaW4rNENjb2ozQ1o1ZHlyL1dET28vSDBlNm5UNm05Ukthd3JNM3h6?=
 =?utf-8?B?U1dkb0t3SHpxRTV6WTlpMmk4dGZuWFJ4MTdpeUZkaFN2SGJhMXJDTEUyNnF4?=
 =?utf-8?B?M2hmOWoyaVc0Nm5ZQjJwemxBMHN4SUZEM2RRTi96N0M1bXc4OXZmVDRFK3g4?=
 =?utf-8?B?S3V6QStzNHV3MnJyOE44UEN6d0hNRm9YSVAya1BMZmhkNmY2eVVuVkxMR3pj?=
 =?utf-8?B?bU5jNS9aVk1WSGxHMkwxaWV4bE9vTTdNTTJRNDJmbkdzdVB0ejJ5ZXlRYkJ4?=
 =?utf-8?B?TldSMmtrcUEzQUxpeTZldFY4bmQ0ZTROdlNLS2JrUkhPWWxUMGlpRnI3ejEv?=
 =?utf-8?B?MCs0NWRFY2x0ZXA3bGo4L216Ly83UTFoamdaTUJaVjJrUVlQVFYwZnNSTlA4?=
 =?utf-8?B?Z1huNWNZMlN5Y3lDZG1SdkZ5cEI0dnhQUU94TnFWUTFLRGQ3d0s0WjF3eHdr?=
 =?utf-8?B?cXhPcFFvVWhWaVJXT0F2aWlYb1BXU1dhbXROZ2QvZVRweGpRY1BNNS9kbDBL?=
 =?utf-8?B?dUkrY3ZKMGNidGVhbWxWMXI5OFh4UzNPZ0hPeEtFR0hLcDZKYzYxY3FabHBI?=
 =?utf-8?B?Z1pZVVFQZHordXdqN0pGdUFZQ0ZIMlozQkw2aG5tanlPTnFHUk1QVXRoMzNM?=
 =?utf-8?B?Tkl2VU10OENlbWo0WUJLTzVvZlQ3cXVPcjF6c3RaT1dLeTRXcWlCSmlvQXQ1?=
 =?utf-8?B?US80ditBNzVqQTlVZ1RVUXF6S3JtMDRjRm5Tek1KRm9tdW9vNWFLbVh3QmR6?=
 =?utf-8?B?U0pQaC81bkFoa0kxaXh1K2tDSnJwWHdTVXdFQWZ1YzdnMkhHTTJkUXprQmF4?=
 =?utf-8?B?cWZQSHJ0bS9hdjVjZnpyZlJ0NjBCUGxoNGJMa0tYZEpSc3VocTVYMFdqNkw3?=
 =?utf-8?B?SWhkY0lTRG42MTdJWnBBU3cyZ3lsQXVlL21iZzFOalNhN29Ba1JLdU10TWJB?=
 =?utf-8?B?TWFZdjdLakNjM0JuUEdaRzU1NG0xaXBMczRuTVZZczVRcnFZN0E4N0FEbkp5?=
 =?utf-8?B?V2U3TE5WS0hEOCtwcGhHZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR17MB6347.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVlDUUE0Ym92bWlzblZLb25wRmg0d1NiUUZnamlkVlZ1N3ZVUGZ1UVRMeXJa?=
 =?utf-8?B?aUFJNk9BQi94YXNERVlaaEhMWW9ScUxrWW1LRzJjRXptajVVa0FJWlFlTEFk?=
 =?utf-8?B?djR0dExIeXpWaTdCalFLWmV6REltczJLR0M3b2k3ZnpxRTJlSVl2RUZFaGI5?=
 =?utf-8?B?cmMwOTVKeVFzOUNQOWdXVzNyRjMwWXNoSzZUSGdQZFRZMkJRNkxxNkdYdXR5?=
 =?utf-8?B?cnZzVXpoYXBuNERoLzZhM21OeFovTytVVFF6a2xMYXpxQVVFQk5rbGNUUUo0?=
 =?utf-8?B?MkdzaG43UStXcGRVaW5TQ1VXL2hSVXpuTHlUQXJXektib2tFZGlucTdjRHdH?=
 =?utf-8?B?Z1htTmR6OERmeDhBL2RhSzBldUhLVzljY2VLM1YwVzQzM3F5SWNkVVR3RVZE?=
 =?utf-8?B?ZmQ3Ym9DL05ydDRIL2ZlTEpUUnF0NnpPN1EzT1VhdFRMcDFPOUd6dlorM1Rr?=
 =?utf-8?B?b3RGNC9lT2hWWFR0SmlJQVFPbkNSQ1Bmb3RLQmptMU9xT1UvdjRBOTk1VTNV?=
 =?utf-8?B?ZnVCL0lWUDZSclgxTmNqY3daWUdZODJESDhOc3VpY081TzJ0VkJTNkdESGsy?=
 =?utf-8?B?akRnd0xRTUhxWVBCZlZRNFhSdkJUeWY3NnBiU1ZuWUlmTkxodit1anJNZzlH?=
 =?utf-8?B?YU1DVXNvTit3Y2dHOXJCdmwyUTh3YW02T3RGZjdZdHNnZGJNcjJxTE1oV1o2?=
 =?utf-8?B?UkZnaWVOSEw0ZEdxUTJMakVtVC9leUZDWjdmZkF5MUNPTGR4NHlKVHRXb3p4?=
 =?utf-8?B?QnZqRW91ZWIrSW5QVXcvVFZtclRDb09TNVZKZkptazhqNVZueXhQUlczaXN4?=
 =?utf-8?B?aDlDVStpaFpOMUE5VmMvWHVZNmdDSDlUOWVDVmxESHRSRUhBZGVaZnBkeklY?=
 =?utf-8?B?UUYvZGdrVG8vc3Z5dm1TeC84Sk40K3k3SXMwcHRJZGF1VGx0OTBKWVYwMmdl?=
 =?utf-8?B?RExuMHRpczFXZmpHMHVZNGhFamhkU3VPODEvbEw1THNTeW1JM1loMHZMdkhi?=
 =?utf-8?B?blF0NHV2Q0tpbzFNYWtGOWd2N0NEaG1VRGY1T2FkSkRRa3FMYXlma2J1RmU2?=
 =?utf-8?B?OStrQWtUNjA5Z2UxR3J0WVk4MXV2WkFwMTIvWHpwTDBUOFdqK0lxNGU3clBR?=
 =?utf-8?B?SG12azJ0cUs3bzlGOURSSkpsUkZtWE9rWFdBQkRLZFlBV1FUSy8yejAyLzNI?=
 =?utf-8?B?VmxPeWhONUFqREV6Wm5uTGlpazdzYjlNREdmSkZEYmsvUlpZeGMxNGhZZzVj?=
 =?utf-8?B?MGZlK2V6QVdoTW9QSUxIdm5zWUhjdEVlN05TQlNsanU3UW5TRU5wVk9ZcHpt?=
 =?utf-8?B?eDBhK2NWTGx4QjlFc1N4UkRDYklIbUEvQmNiTlBCaHVWSFlkV0hkN0NqdzZ4?=
 =?utf-8?B?ZU9NeDcwT25OYUVBREE5YWlqSUx0Ulk3S3VSWFFyV1MxSlJkaUFrVTdBTTAw?=
 =?utf-8?B?YkppbHU0QW9keHo3L2RFOEp0NmlqcU5oWHkyL2crY1JjNVRpUitvR3ZNcERY?=
 =?utf-8?B?MFVaSjVpcnpTODN3Zk4reUpOd3YvcENOOVgwNmdNR1pTZXZ6QWpaSVZ2TDFY?=
 =?utf-8?B?SWhGQjloa0JSeDBxdFh2eGpLVCtiMWtLZkVEM0krRmQxOUhDRkFRUWdGVzA4?=
 =?utf-8?B?c2RJZzd1TnFnTzE2eUhzY01xMnhFS21RUTR1Nm9WaWduOWFGbDZRUzJFckVi?=
 =?utf-8?B?R0gxTTFDSTZZMEY1U3F1WGZaWXdpdHlxa1lMS0VnbG4yQzVTUVh3YVlpcy9O?=
 =?utf-8?B?Wm9oQ1VaL0NleGhITnFLejhZUzJUODUvYU5yS3RKT3l2M3hUQmRzWW02c2JT?=
 =?utf-8?B?OHN3V3B2QU1jYVN6UXRWRkxTb2l1YnBTMzM1S3pKN3FoS0x1VHhhMndvekw2?=
 =?utf-8?B?a3FiNnFlMEFLcUVqRyt6NUJXendiZTM2SXFRcTVSME1QQ1RGdHlRTFcwcElR?=
 =?utf-8?B?NXhDVXpvbGFmL1lZclZEU2pVMUkyVldzbW1SNjVKSm94bXhabXRScVVUVkI1?=
 =?utf-8?B?b1Rsb0I1dlc4Vm00M2c0bjNLMDk4Q3MzMCtralZ4cXlhYVo0RUovUWJQQjdX?=
 =?utf-8?B?OE96MWJZb3FaSXkzZ0RNaHFFaFgwVmFJbTBNcFh1NXRlek5kOCtvd04xbXRI?=
 =?utf-8?B?eEJ6SjZ1Y25wVTA4WjFuV3pPbGNneDVZWjNadzJUN2owMUt0ek92TE0rMmJ6?=
 =?utf-8?Q?8yp5vTG7SW+3bI5dSpnrBXc=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc54affa-a2bf-4ed4-3a65-08dc6499bdaf
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6347.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 20:04:25.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3svedPsAYpIG2kKJDVLU9/qVtOEz7VlfvSMoKVVwaEOCCYL7aQHE/CSvPQyQn02VI/lH3IR0mLJ68TB903YAFPVTy6ep9oOm1rQ3hdbdQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR17MB5846

Introduce an API for validating DC adds, removes, and responses
against a multi-headed device.

mhd_reserve_extents() is called during a DC add request. This allows
a multi-headed device to check whether the requested extents belong
to another host. If not, then this function can claim those extents
in the MHD state and allow the cxl_type3 code to follow suit in the
host-local blk_bitmap.

mhd_reclaim_extents() is called during the DC add response. It allows
the MHD to reclaim extents that were preallocated to a host during the
request but rejected in the response.

mhd_release_extent() is called during the DC release response. It can
be invoked after a host frees an extent in its local bitmap, allowing
the MHD handler to release that same extent in the multi-host state.
---
 hw/cxl/cxl-mailbox-utils.c  | 28 +++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 17 +++++++++++++++++
 include/hw/cxl/cxl_device.h |  8 ++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index dc916f5bb3..0429bb4816 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2283,6 +2283,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 {
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDCExtentList *extent_list = &ct3d->dc.extents;
     uint32_t i;
     uint64_t dpa, len;
@@ -2317,6 +2318,11 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
         ct3d->dc.total_extent_count += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
     }
+
+    if (cvc->mhd_reclaim_extents)
+        cvc->mhd_reclaim_extents(&ct3d->parent_obj, &ct3d->dc.extents_pending,
+                in);
+
     /* Remove the first extent group in the pending list*/
     cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
 
@@ -2350,6 +2356,7 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         uint32_t *updated_list_size)
 {
     CXLDCExtent *ent, *ent_next;
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint64_t dpa, len;
     uint32_t i;
     int cnt_delta = 0;
@@ -2370,6 +2377,13 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
             goto free_and_exit;
         }
 
+        /* In an MHD, check that this DPA range belongs to this host */
+        if (cvc->mhd_access_valid &&
+            !cvc->mhd_access_valid(&ct3d->parent_obj, dpa, len)) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+
         /* After this point, extent overflow is the only error can happen */
         while (len > 0) {
             QTAILQ_FOREACH(ent, updated_list, node) {
@@ -2442,9 +2456,11 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
 {
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDCExtentList updated_list;
     CXLDCExtent *ent, *ent_next;
-    uint32_t updated_list_size;
+    uint32_t updated_list_size, i;
+    uint64_t dpa, len;
     CXLRetCode ret;
 
     if (in->num_entries_updated == 0) {
@@ -2462,6 +2478,16 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
         return ret;
     }
 
+    /* Updated_entries contains the released extents. Free those in the MHD */
+    for (i = 0; cvc->mhd_release_extent && i < in->num_entries_updated; ++i) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        if (cvc->mhd_release_extent) {
+            cvc->mhd_release_extent(&ct3d->parent_obj, dpa, len);
+        }
+    }
+
     /*
      * If the dry run release passes, the returned updated_list will
      * be the updated extent list and we just need to clear the extents
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 88facd49ed..e69cb6f7b7 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -799,6 +799,7 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group, *group_next;
+    CXLType3Class *cvc = CXL_TYPE3_CLASS(ct3d);
     int i;
     CXLDCRegion *region;
 
@@ -817,6 +818,10 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
     for (i = 0; i < ct3d->dc.num_regions; i++) {
         region = &ct3d->dc.regions[i];
         g_free(region->blk_bitmap);
+        if (cvc->mhd_release_extent) {
+            cvc->mhd_release_extent(&ct3d->parent_obj, region->base,
+                    region->len);
+        }
     }
 }
 
@@ -2104,6 +2109,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     CXLEventDynamicCapacity dCap = {};
     CXLEventRecordHdr *hdr = &dCap.hdr;
     CXLType3Dev *dcd;
+    CXLType3Class *cvc;
     uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
     uint32_t num_extents = 0;
     CXLDCExtentRecordList *list;
@@ -2121,6 +2127,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     }
 
     dcd = CXL_TYPE3(obj);
+    cvc = CXL_TYPE3_GET_CLASS(dcd);
     if (!dcd->dc.num_regions) {
         error_setg(errp, "No dynamic capacity support from the device");
         return;
@@ -2193,6 +2200,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         num_extents++;
     }
 
+    /* If this is an MHD, attempt to reserve the extents */
+    if (type == DC_EVENT_ADD_CAPACITY && cvc->mhd_reserve_extents &&
+       !cvc->mhd_reserve_extents(&dcd->parent_obj, records, rid)) {
+        error_setg(errp, "mhsld is enabled and extent reservation failed");
+        return;
+    }
+
     /* Create extent list for event being passed to host */
     i = 0;
     list = records;
@@ -2336,6 +2350,9 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->set_cacheline = set_cacheline;
     cvc->mhd_get_info = NULL;
     cvc->mhd_access_valid = NULL;
+    cvc->mhd_reserve_extents = NULL;
+    cvc->mhd_reclaim_extents = NULL;
+    cvc->mhd_release_extent = NULL;
 }
 
 static const TypeInfo ct3d_info = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 5c60342556..f7ac0c34d2 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -14,6 +14,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/register.h"
 #include "hw/cxl/cxl_events.h"
+#include "qapi/qapi-commands-cxl.h"
 
 #include "hw/cxl/cxl_cpmu.h"
 /*
@@ -651,6 +652,13 @@ struct CXLType3Class {
                                size_t *len_out,
                                CXLCCI *cci);
     bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
+    bool (*mhd_reserve_extents)(PCIDevice *d,
+                                CXLDCExtentRecordList *records,
+                                uint8_t rid);
+    bool (*mhd_reclaim_extents)(PCIDevice *d,
+                                CXLDCExtentGroupList *groups,
+                                CXLUpdateDCExtentListInPl *in);
+    bool (*mhd_release_extent)(PCIDevice *d, uint64_t dpa, uint64_t len);
 };
 
 struct CSWMBCCIDev {

-- 
2.34.1

