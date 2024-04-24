Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2128.outbound.protection.outlook.com [40.107.223.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB013D25E
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989074; cv=fail; b=j3gRj2kE9ztpUwSuAB/wvJOPmUqHPPVTCyDBcqULfPUQ62hjgKZGvzA+xrGD15hGXDzsdUZkynTSeLD1fCwZPx91WndQhjTLVe+jKXi0jngA3pkgkmNIVBV4wQREKHFfbdFYRVeItifulOXOYWX+WAjPyTmuuL+ClXidk8F8oyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989074; c=relaxed/simple;
	bh=Mmf0qdxK449WcZGHC/bZlcgno9+Nn5fb0FgJIQKg1r8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=J+PyZMd8H2MUV9W4P8gsUaFqd/ovO1RTFc+XZXAk+GrZ+iDQlRsKDsREjqx1s+Jv5W5l3qklGAcemkbCq9mA9SyxZ3BuiuqtDfX60vxMNaUgZzmNfYFwAQlwBTj4wknZDhuYiV+ch3PcvxfQgj3wMTNHhFNTIdwUDf1RURrVca8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=ZjgdkOD0; arc=fail smtp.client-ip=40.107.223.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="ZjgdkOD0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsaZ+UD86ViIakYkvvO6M8TU7A+XDpWqCpmhphphwaNXpRyTuhCdGCqiv2SRZSZajAxXodvXiF/TWtNwft6hNV0+uYTv8AvIvKnW8aUdO0ves8qATkO9I9sHNYHxw9FtCMXU51V3lh57kB0zHJg0nYWbCMmTqWWvYcOCMglyJkzn2HvUy2UDgSbK2535aV0Hxr63gyKRtQ8t3MooPLLkWvkPcgQ9xZtIbGIdPdhzF24NK4CRxWOLmV4hc53752Hi2LyX7TvWswUwmuDXd5M6Zzyn2JqQnZgUdU79uGlFxmXJRdwcXxBrVm8QdQZodJm0QCT47phA1kw5TXZ7L8vl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCgoHLPds5uQj0aDjHRdIkKXNsoAoSa9JC+RkTC23FQ=;
 b=ZlT1IlnRXnvzRjj7cUQa/DKU+ndjgcjR8py074jZ8mnWvFkYlksEyxeyWdQsm7ZRTH6vyRwFQ1JNXNSOLTLEl++SQV2e9DtqCWY8dJRlhLynk/layKw9/VF9rrRppBn8BFlSh93Qgq1u3Yg3cA8k2tUQzmglMuMYBsvr5wM61XFgtJgYzJsbmFEtZzyMC/ssKJjAkLQsEVDggsGRpz8CIIarhHVvogkS3j0nC6mG+XNoG7jJeTfqu0icBdqnngzhNdW/3UTMasrTk0ydEEYcdU7rNCU8Oi17iSIelh0hcodA4p7R1ATV6jGkUE7Y0uCjE6RDfDmf33KVRzhKLb4WxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCgoHLPds5uQj0aDjHRdIkKXNsoAoSa9JC+RkTC23FQ=;
 b=ZjgdkOD0/IaPyy4o620dNohZXu5QO72Bnk3r7dJAjC7dNhikqa0A32IIikNrUs6l0WzsSvsMokls/aQDr5mFDJwFHJSZxgrm/2gpNRIx2QbUJLEVSwkp1ebFxPaxfnNiUBqMy1xdDYVYISHA6fAEfSCb4IhkG2ifZm1JN3rgas8=
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
Date: Wed, 24 Apr 2024 13:04:08 -0700
Subject: [PATCH RFC v2 3/3] mhsld: implement MHSLD device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-cxl-2024-04-22-pullahead-v2-3-a87fc4597795@memverge.com>
References: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
In-Reply-To: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
To: qemu-devel@nongnu.org
Cc: Svetly Todorov <svetly.todorov@memverge.com>, 
 Gregory Price <gregory.price@memverge.com>, jonathan.cameron@huawei.com, 
 linux-cxl@vger.kernel.org, nifan.cxl@gmail.com
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713989063; l=18941;
 i=svetly.todorov@memverge.com; s=20240312; h=from:subject:message-id;
 bh=Mmf0qdxK449WcZGHC/bZlcgno9+Nn5fb0FgJIQKg1r8=;
 b=pIssofizIzxeAbX4wsWnWB7QhAzcEGb2Q8d0ggfSU0xx3yDjK4utqNDINWCE+NAIu3fMw8EOz
 O8Mq+0wA5PnA+SME9PwBQxxGrQi31kaqYsUNH8oeAENgtgAzKSmS07O
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
X-MS-Office365-Filtering-Correlation-Id: 8e777ca6-ec33-4ae8-721f-08dc6499be29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTNxcE1FYWZxelNLWDNJKy9ya0Vqc2VEQ3VKbTJLTEUvNFYyR01Pa0lZS3kr?=
 =?utf-8?B?bTlLMFBsMWdsQ1dTdGc5cDZtRm5KeXYyTFRkTmZHR0lXY2J5ZXZCZG53VmMw?=
 =?utf-8?B?RlNmZ0YyRy9VUXJvMGpOYUxBb3ZBUEZMZjdWMmNsRElwNlpFcjVPaDRManM2?=
 =?utf-8?B?alBuWlY4QjgrUEI5TDlaMUJRUzd2RVdjQVVHU1ZYL2pQdWJsUktUZEpoQnU4?=
 =?utf-8?B?em03ZC94WS9TVjV6VE9GNFcvM1hOS0tUMStlUzJWdllhV2lUOG4zT01sMkJT?=
 =?utf-8?B?WVh0ZllNNlEwNWVOdzE3bWg4WGUvVnhqZGhUR2xWNjd4YllnblJZKzlVSEd3?=
 =?utf-8?B?MUJSK3JMTm9xTnJ3cWtCWCtHdzVBdkxsL2N0MDFZRmRpcUlCTTlRUHZNbDNJ?=
 =?utf-8?B?MVl6eGNZSzhNNDBtVVllaS9qNjluanF5djVSQUFpWTN6R0l4UWYwS3puOUJw?=
 =?utf-8?B?TXo2b0JxMGJDbk9nbksyalVTMEp5eHlNMEd4OEtVWVliQXhlRFMwdVNsRUFX?=
 =?utf-8?B?TkJ0TzNKbUIramhuRkhJNUJuTHZyRW84VW1VWlVPWEROdXlFeDNSb3ZxSWRw?=
 =?utf-8?B?LzlQLzNheDY2M29QRHB2WHY5MGxvMnBrcFcvT1gyUG43MDBrYXEzMXV4UEs4?=
 =?utf-8?B?Zk94ZGErNkRBYkUwZnVmTkIrZ1Z1ZjhvcGpqY3BESHFUU29UblVuVStPaHpp?=
 =?utf-8?B?SUZ2bGVBRWsxaXFpbjJwWHZtTDlXSG1LN0lQMzkrbEdRamVncXhzUVVBU3Fz?=
 =?utf-8?B?THNwY3lMbDVTMDZESkxXemZ3MkdGT1BIV0hCN09jblBhVmM0alZ4OHowYksz?=
 =?utf-8?B?WVVCM09iT3BhSjFseDdaRWVjaDdFN0NsVnFBNUZSaEVuZDdoejJNRUVDanEv?=
 =?utf-8?B?aW1zRmliQUhvNlZmUzBVSlNaeFdtTlVzd0R5MWhyVjVDVEhXb2pOZFVhb3dC?=
 =?utf-8?B?T3VxN2pUVFZ2T0ZDRVlwLzhrYzFyeHFSRzlZYlFuZ0d5RGZKVXEzeEtuY3Fr?=
 =?utf-8?B?K2VncW0rdEkvakdERjFHWE11YnkyNjE0MmNEeUNQcEhIYkFKK3VYbm5wejM1?=
 =?utf-8?B?Z01VcWFwR0JuR0NJbW92aDVPbzEvNmsvZ0xVMXR0aG1wSS9QdlBSaUhOSkRm?=
 =?utf-8?B?VG1YbXd6T2xRbFVtQ2dEUHh4VVFVRmJ1Q1FJS29LcnVINktWQVpyOS9OdW5G?=
 =?utf-8?B?dEh1c1htSm90NEJ1VHZmaDA2dnZ4ZCtRdWNTYlFPU3VRVElxbVZYSlJxT1JS?=
 =?utf-8?B?NFJDODZPcTZlb2MrOFdOMHJmS2syT1NzZ1VRT1kxN1pnSEhvY29FWEtsYXFx?=
 =?utf-8?B?Z2tFbUU0M0Q0RnB5WWNJZXZ2R0RpRkRLc3RzVEJYWC8xeXpUWEV4M0U2Sm95?=
 =?utf-8?B?MTRXSlB1Z2ZiMlprQndIZzYyaE4rVGs4UDNDUEh2VGx1bFpiTkRqVGlZZmMx?=
 =?utf-8?B?bGtKQ09RV0tCalR5bkNSZXQvUVV3bzhpTm5meDNVbWNpTzBmZVUzdmFNU0cz?=
 =?utf-8?B?OUdFeGw1cGxDUDdKa2VPdkc4YkZHVkloVVpKdit6NDE1cVFGV0ZzczFDY2gw?=
 =?utf-8?B?b1B0TURpckM1K2FKaGt3c2w0UFJadjVudUgzRVhqRHI2RmVMOXQzQjRCSWN0?=
 =?utf-8?B?UEZadmpSYVB5bWk0S08vREdUeDNaR3NxZ0dnSU1KS0JCWjRQUWc1aXNnMTE0?=
 =?utf-8?B?a2lqTzhLaVNqeWxoMlFCVHFJK2wvbUExRWc4RStLVXBtQXJPZFhwUDJ4UTRz?=
 =?utf-8?B?cUQyZW5RMTVaSnphd1gyVE9Za0d5ZzYrSU9EUThkTVFhTTRVOHBsMEVnY2tW?=
 =?utf-8?B?cmpxaVpLKzdwdGU3SENYZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR17MB6347.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0FhdFRMdkxlWUs5S015dlRBczQzNTRoektwenNwMnNORElWVGpZczE2YkJn?=
 =?utf-8?B?bWJKNWhmRW9pTWQxWC9wL002dG55dUFNQlpsSHRLODMwZzcyOTJtSS9jdWda?=
 =?utf-8?B?ZStod2s5eXhuYTRjQ3NLRVYxYk9vd0Z1Nnh6V05Nc0Q3cHFFQkhhL3FxVm1o?=
 =?utf-8?B?SkFKVllLbWdaMXd5UHBKazJNQUllYTlNNlpWZzhjTWxWY2cvN24wK2lwQnlY?=
 =?utf-8?B?UUh0cEc1TFdEeXR3NUZjdFNqOFlhUFBwTWU2Q3NYdjB4OFpQUE5yYkRKRG05?=
 =?utf-8?B?NXdvcnJlRVkzSWxaTEt5a2c4OFk2SnFkUUczUzBWRnhtanFuY0dob2UyZ3Zv?=
 =?utf-8?B?M1hOTHpMd3pRR0VpRHg2SmduRm0rcnd6Z1p5MWkyK1Avb0w3ZzM4blhhMGZy?=
 =?utf-8?B?Y0NpdGdMaE8yaEQ2aE5LTXh3dUhKbzlGVjNyS1FtcmlFcTM1cDZKVkNvTlp4?=
 =?utf-8?B?VXpZSmZXdnRNQWlOSHJGZ1lrUmV0Z3lVVGpHQXdySERUNkFCbDYzTFFlNE1a?=
 =?utf-8?B?aUxNbHcrd3dTS2MyWUt5SG8vL1ZWdHd1SG5sN3NGbDFhd0h5b0xNRXg1OFM0?=
 =?utf-8?B?SEFhQ1VTaGpwaTZnZnlURnNTbnR3SFNscVdwUXMwbXhSa3VCU0hPY2pObTMw?=
 =?utf-8?B?Vi9OMlJLN0NjSTFkVDRwV3REVXdBM3oyMHFNYUprckM5ZW5SMEtBenVYaURW?=
 =?utf-8?B?amtMMWNsZUdDN0t0bnpJY3BuZEFMZllDZDc4TkNiUEVBM3BDQlcxd1dwU3hy?=
 =?utf-8?B?TmFaMFlQcE83RlpjeFZWQ1FJdEZDMVdrMzZ1VmFVZFk5cXVCNmh2eGs0R0hF?=
 =?utf-8?B?aUNDTUFIbTB5RGl2OExiTTBVNzlxSWtzUTEybmNlbWpVTmxBWXNxMVYyNFBJ?=
 =?utf-8?B?QUdjQmZ6UmpKTllYVEZ4L3hIVnBEL3UydnRmU21Jeklpa1JmaTFUckRJY3Fj?=
 =?utf-8?B?VHpmSHhUR3hHMnlRNGM2eXR6cld0UklxOHYyTFpTVmdUSnE5aUpJK3RBQnZo?=
 =?utf-8?B?c29qVG96MnBPODdUMkYveFpDZzBIdDFyclRxekQzakR0MVJoWEFNU1o1VzBz?=
 =?utf-8?B?L1VBbE83Mm1FNTZ1Wmxpa2pzb0Z6WTlCZHFRWXBhN2J4Mm9YS2R0R1FHaUE0?=
 =?utf-8?B?QWZ6WFBKRG9kVjJGYlF0U0tzU0hHbTg2R09QVjVUNXUzeEc3N0hqTDBteWZ6?=
 =?utf-8?B?bFV0WkpaVTdndzczUnQzOUpBUFFwakNVeUN1dCtBWjF6SjBKd205aEYxTFk2?=
 =?utf-8?B?dHZPTmdBZDgydTZTTWZPaDN6THdhNGdTVGF2L042RGdlZERGTmR5WEp3U1E4?=
 =?utf-8?B?Ull6dks3NnNwV3N3OWRRR1NPUWZuUG1zWVZmZ0pTTlhTQm9nUmRJQnBwUHFS?=
 =?utf-8?B?OTNzZzk3aHpha0ZCSEpqdFZ0VjQza3M4dzVEeVZSSjVLVU5xK2tseWFGam5X?=
 =?utf-8?B?bTVjM2tiOVpKSXJiR2wzT3BleVJUVnpPRkwyOXQwcUowWjhXVUVET05kUTFi?=
 =?utf-8?B?NEZKVVZ4bXdhVStYSjFvK0YwTlgxSEV3Q1ZYYjhGMHNyQ2MzYXJyM3FDMFFi?=
 =?utf-8?B?QnZmUDBTbk54aUZveU1rVDByZU1BZ21tYkhiYmR5MWtJS1g0WWVpcXd1a2lp?=
 =?utf-8?B?WEVIbm9ubUlOVTNqVDVFZ29tS1NZYzBZTDBMTytGTE5TOTM3S2twbDdTc0hm?=
 =?utf-8?B?azd4Y1dRT3BKTjlJU3ZMNG1DYUMxRTIvUzlxbGhRcFpCZ2ttTHMyUTE0WE0v?=
 =?utf-8?B?eUdUalg3MTlYYVFJOWFUUjN1dWJ0QmVGMnhRTEZDam8wK2pVbE5zTGxQMVp6?=
 =?utf-8?B?UWgxMXYwUlpSeFFDMjZIclRSSGZ2elNkY1JWNGF2ajNvK2xrZHNJVkVOblVt?=
 =?utf-8?B?Z1ZQQzUzNTFsOTlvTzdKNDhyOC9wUnZ2RTNIWUY3MFpLSmczK3lUYmxVbUdy?=
 =?utf-8?B?a0VrVFdsZ25iODVwcWVWbFZHaEUzVjM2ajVyOGJCS3pjNWZLZy9lSy9tT2NB?=
 =?utf-8?B?dHVoQkpCa29peXhSNkY1VG9sMzVWa0VDNndDRzdMdGRFZTlYK2psOEtLSUIz?=
 =?utf-8?B?MEpLSEt1Y3hJaXVWK25VdExxVUk3UTZpRkZrSmRWYkUySm1LZzc2MXR2NUVr?=
 =?utf-8?B?WStrYlpOREZXOFVxTFRTMXNaMDM0bWJrQSs0OXRTMmV5UWNiSUNlYkVxRCtr?=
 =?utf-8?Q?XyOKoSM4Pe142n8eloXWZ6o=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e777ca6-ec33-4ae8-721f-08dc6499be29
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6347.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 20:04:26.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhY6yvbUR0byMcyc6wkR9pPKMtrPL7oO9XdY6GxJ7QmkMHdG0n7i8P82U40zAhVsjPayrkNZSHeimyQfByL756YS4e9zaImShupP5Eos0OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR17MB5846

Using a shared-memory bytemap, validates that DC adds, releases,
and reclamations happen on extents belonging to the appropriate
host.

The MHSLD device inherits from the CXL_TYPE3 class and adds the following
configuration options:
--mhd-head=<u32>
--mhd-state_file=<str>
--mhd-init=<bool>

--mhd-head specifies the head ID of the host on the given device.

--mhd-state_file is the name of the shared-memory-backed file used
to store the MHD state.

--mhd-init indicates whether this QEMU instance should initialize
the state_file; if so, the instance will create the file if it does
not exist, ftruncate it to the appropriate size, and initialize its
header. It is assumed that the --mhd-init instance is run and allowed
to completely finish configuration before any other guests access the
shared state.

The shared state file only needs to be intialized once. Even if a guest
dies without clearing the ownership bits associated with its head-ID,
future guests with that ID will clear those bits in cxl_mhsld_realize(),
regardless of whether mhd_init is true or false.

The following command line options create an MHSLD with 4GB of
backing memory, whose state is tracked in /dev/shm/mhd_metadata.
--mhd-init=true tells this instance to initialize the state as
described above.

./qemu-system_x86-64 \
[... other options ...] \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
-object memory-backend-ram,id=mem0,size=4G \
-device cxl-mhsld,bus=rp0,num-dc-regions=1,volatile-dc-memdev=mem0,id=cxl-mem0,sn=66667,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
-qmp unix:/tmp/qmp-sock-1,server,nowait

Once this guest completes setup, other guests looking to access the
device can be booted with the same configuration options, but with
--mhd-head != 0,
--mhd-init=false,
and a different QMP socket.
---
 hw/cxl/Kconfig           |   1 +
 hw/cxl/meson.build       |   1 +
 hw/cxl/mhsld/Kconfig     |   4 +
 hw/cxl/mhsld/meson.build |   3 +
 hw/cxl/mhsld/mhsld.c     | 456 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/cxl/mhsld/mhsld.h     |  75 ++++++++
 6 files changed, 540 insertions(+)

diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
index e603839a62..919e59b598 100644
--- a/hw/cxl/Kconfig
+++ b/hw/cxl/Kconfig
@@ -1,3 +1,4 @@
+source mhsld/Kconfig
 source vendor/Kconfig
 
 config CXL
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index e8c8c1355a..394750dd19 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -16,4 +16,5 @@ system_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c'))
 
 system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
 
+subdir('mhsld')
 subdir('vendor')
diff --git a/hw/cxl/mhsld/Kconfig b/hw/cxl/mhsld/Kconfig
new file mode 100644
index 0000000000..dc2be15140
--- /dev/null
+++ b/hw/cxl/mhsld/Kconfig
@@ -0,0 +1,4 @@
+config CXL_MHSLD
+    bool
+    depends on CXL_MEM_DEVICE
+    default y
diff --git a/hw/cxl/mhsld/meson.build b/hw/cxl/mhsld/meson.build
new file mode 100644
index 0000000000..c595558f8a
--- /dev/null
+++ b/hw/cxl/mhsld/meson.build
@@ -0,0 +1,3 @@
+if host_os == 'linux'
+	system_ss.add(when: 'CONFIG_CXL_MHSLD', if_true: files('mhsld.c',))
+endif
diff --git a/hw/cxl/mhsld/mhsld.c b/hw/cxl/mhsld/mhsld.c
new file mode 100644
index 0000000000..14f4b6f6c9
--- /dev/null
+++ b/hw/cxl/mhsld/mhsld.c
@@ -0,0 +1,456 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 MemVerge Inc.
+ *
+ */
+
+#include <sys/file.h>
+#include "qemu/osdep.h"
+#include "qemu/bitmap.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_mailbox.h"
+#include "hw/cxl/cxl_device.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
+#include "sysemu/hostmem.h"
+#include "mhsld.h"
+
+#define TYPE_CXL_MHSLD "cxl-mhsld"
+OBJECT_DECLARE_TYPE(CXLMHSLDState, CXLMHSLDClass, CXL_MHSLD)
+
+/*
+ * CXL r3.0 section 7.6.7.5.1 - Get Multi-Headed Info (Opcode 5500h)
+ *
+ * This command retrieves the number of heads, number of supported LDs,
+ * and Head-to-LD mapping of a Multi-Headed device.
+ */
+static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in, size_t len_in,
+                                   uint8_t *payload_out, size_t *len_out,
+                                   CXLCCI * cci)
+{
+    CXLMHSLDState *s = CXL_MHSLD(cci->d);
+    MHDGetInfoInput *input = (void *)payload_in;
+    MHDGetInfoOutput *output = (void *)payload_out;
+
+    uint8_t start_ld = input->start_ld;
+    uint8_t ldmap_len = input->ldmap_len;
+    uint8_t i;
+
+    if (start_ld >= s->mhd_state->nr_lds) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    output->nr_lds = s->mhd_state->nr_lds;
+    output->nr_heads = s->mhd_state->nr_heads;
+    output->resv1 = 0;
+    output->start_ld = start_ld;
+    output->resv2 = 0;
+
+    for (i = 0; i < ldmap_len && (start_ld + i) < output->nr_lds; i++) {
+        output->ldmap[i] = s->mhd_state->ldmap[start_ld + i];
+    }
+    output->ldmap_len = i;
+
+    *len_out = sizeof(*output) + output->ldmap_len;
+    return CXL_MBOX_SUCCESS;
+}
+
+static const struct cxl_cmd cxl_cmd_set_mhsld[256][256] = {
+    [MHSLD_MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
+        cmd_mhd_get_info, 2, 0},
+};
+
+static Property cxl_mhsld_props[] = {
+    DEFINE_PROP_UINT32("mhd-head", CXLMHSLDState, mhd_head, ~(0)),
+    DEFINE_PROP_STRING("mhd-state_file", CXLMHSLDState, mhd_state_file),
+    DEFINE_PROP_BOOL("mhd-init", CXLMHSLDState, mhd_init, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static int cxl_mhsld_state_open(const char *filename, int flags)
+{
+    char name[128];
+    snprintf(name, sizeof(name), "/%s", filename);
+    return shm_open(name, flags, 0666);
+}
+
+static int cxl_mhsld_state_unlink(const char *filename)
+{
+    char name[128];
+    snprintf(name, sizeof(name), "/%s", filename);
+    return shm_unlink(name);
+}
+
+static int cxl_mhsld_state_create(const char *filename, size_t size)
+{
+    int fd, rc;
+
+    fd = cxl_mhsld_state_open(filename, O_RDWR | O_CREAT);
+    if (fd == -1) {
+        return -1;
+    }
+
+    rc = ftruncate(fd, size);
+
+    if (rc) {
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
+
+static bool cxl_mhsld_state_set(CXLMHSLDState *s, size_t block_start,
+                                size_t block_count)
+{
+    uint8_t prev, val, *block;
+    size_t i;
+
+    val = (1 << s->mhd_head);
+
+    /*
+     * Try to claim all extents from start -> start + count;
+     * break early if a claimed extent is encountered
+     */
+    for (i = 0; i < block_count; ++i) {
+        block = &s->mhd_state->blocks[block_start + i];
+        prev = __sync_val_compare_and_swap(block, 0, val);
+        if (prev != 0) {
+            break;
+        }
+    }
+
+    if (prev == 0) {
+        return true;
+    }
+
+    /* Roll back incomplete claims */
+    for (;; --i) {
+        block = &s->mhd_state->blocks[block_start + i];
+        __sync_fetch_and_and(block, ~(1u << s->mhd_head));
+        if (i == 0) {
+            break;
+        }
+    }
+
+    return false;
+}
+
+static void cxl_mhsld_state_clear(CXLMHSLDState *s, size_t block_start,
+                                  size_t block_count)
+{
+    size_t i;
+    uint8_t *block;
+
+    for (i = 0; i < block_count; ++i) {
+        block = &s->mhd_state->blocks[block_start + i];
+        __sync_fetch_and_and(block, ~(1u << s->mhd_head));
+    }
+}
+
+static void cxl_mhsld_state_initialize(CXLMHSLDState *s, size_t dc_size)
+{
+    if (!s->mhd_init) {
+        cxl_mhsld_state_clear(s, 0, dc_size / MHSLD_BLOCK_SZ);
+        return;
+    }
+
+    memset(s->mhd_state, 0, s->mhd_state_size);
+    s->mhd_state->nr_heads = MHSLD_HEADS;
+    s->mhd_state->nr_lds = MHSLD_HEADS;
+    s->mhd_state->nr_blocks = dc_size / MHSLD_BLOCK_SZ;
+}
+
+/* Returns starting index of region in MHD map. */
+static inline size_t cxl_mhsld_find_dc_region_start(PCIDevice *d,
+                                                    CXLDCRegion *r)
+{
+    CXLType3Dev *dcd = CXL_TYPE3(d);
+    size_t start = 0;
+    uint8_t rid;
+
+    for (rid = 0; rid < dcd->dc.num_regions; ++rid) {
+        if (&dcd->dc.regions[rid] == r) {
+            break;
+        }
+        start += dcd->dc.regions[rid].len / dcd->dc.regions[rid].block_size;
+    }
+
+    return start;
+}
+
+static MHSLDSharedState *cxl_mhsld_state_map(CXLMHSLDState *s)
+{
+    void *map;
+    size_t size = s->mhd_state_size;
+    int fd = s->mhd_state_fd;
+
+    if (fd < 0) {
+        return NULL;
+    }
+
+    map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+    if (map == MAP_FAILED) {
+        return NULL;
+    }
+
+    return (MHSLDSharedState *)map;
+}
+
+/*
+ * Triggered during an add_capacity command to a CXL device:
+ * takes a list of extent records and preallocates them,
+ * in anticipation of a "dcd accept" response from the host.
+ *
+ * Extents that are not accepted by the host will be rolled
+ * back later.
+ */
+static bool cxl_mhsld_reserve_extents(PCIDevice *d,
+                                      CXLDCExtentRecordList *records,
+                                      uint8_t rid)
+{
+    uint64_t len, dpa;
+    bool rc;
+
+    CXLMHSLDState *s = CXL_MHSLD(d);
+    CXLDCExtentRecordList *list = records, *rollback = NULL;
+
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+    CXLDCRegion *region = &ct3d->dc.regions[rid];
+
+    for (; list; list = list->next) {
+        len = list->value->len / MHSLD_BLOCK_SZ;
+        dpa = (list->value->offset + region->base) / MHSLD_BLOCK_SZ;
+
+        rc = cxl_mhsld_state_set(s, dpa, len);
+
+        if (!rc) {
+            rollback = records;
+            break;
+        }
+    }
+
+    /* Setting the mhd state failed. Roll back the extents that were added */
+    for (; rollback; rollback = rollback->next) {
+        len = rollback->value->len / MHSLD_BLOCK_SZ;
+        dpa = (list->value->offset + region->base) / MHSLD_BLOCK_SZ;
+
+        cxl_mhsld_state_clear(s, dpa, len);
+
+        if (rollback == list) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static bool cxl_mhsld_reclaim_extents(PCIDevice *d,
+                                      CXLDCExtentGroupList *ext_groups,
+                                      CXLUpdateDCExtentListInPl *in)
+{
+    CXLMHSLDState *s = CXL_MHSLD(d);
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+    CXLDCExtentGroup *ext_group = QTAILQ_FIRST(ext_groups);
+    CXLDCExtent *ent;
+    CXLDCRegion *region;
+    g_autofree unsigned long *blk_bitmap = NULL;
+    uint64_t dpa, off, len, size, i;
+
+    /* Get the DCD region via the first requested extent */
+    ent = QTAILQ_FIRST(&ext_group->list);
+    dpa = ent->start_dpa;
+    len = ent->len;
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    size = region->len / MHSLD_BLOCK_SZ;
+    blk_bitmap = bitmap_new(size);
+
+    /* Set all requested extents to 1 in a bitmap */
+    QTAILQ_FOREACH(ent, &ext_group->list, node) {
+        off = ent->start_dpa - region->base;
+        len = ent->len;
+        bitmap_set(blk_bitmap, off / MHSLD_BLOCK_SZ, len / MHSLD_BLOCK_SZ);
+    }
+
+    /* Clear bits associated with accepted extents */
+    for (i = 0; i < in->num_entries_updated; i++) {
+        off = in->updated_entries[i].start_dpa - region->base;
+        len = in->updated_entries[i].len;
+        bitmap_clear(blk_bitmap, off / MHSLD_BLOCK_SZ, len / MHSLD_BLOCK_SZ);
+    }
+
+    /*
+     * Reclaim only the extents that belong to unaccepted extents,
+     * i.e. those whose bits are still raised in blk_bitmap
+     */
+    for (off = find_first_bit(blk_bitmap, size); off < size;) {
+        len = find_next_zero_bit(blk_bitmap, size, off) - off;
+        cxl_mhsld_state_clear(s, off, len);
+        off = find_next_bit(blk_bitmap, size, off + len);
+    }
+
+    return true;
+}
+
+static bool cxl_mhsld_release_extent(PCIDevice *d, uint64_t dpa, uint64_t len)
+{
+    cxl_mhsld_state_clear(CXL_MHSLD(d), dpa / MHSLD_BLOCK_SZ,
+        len / MHSLD_BLOCK_SZ);
+    return true;
+}
+
+static bool cxl_mhsld_access_valid(PCIDevice *d, uint64_t addr,
+                                   unsigned int size)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+    CXLMHSLDState *s = CXL_MHSLD(d);
+    CXLDCRegion *r = cxl_find_dc_region(ct3d, addr, size);
+    size_t i;
+
+    addr = addr / r->block_size;
+    size = size / r->block_size;
+
+    for (i = 0; i < size; ++i) {
+        if (s->mhd_state->blocks[addr + i] != (1 << s->mhd_head)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static void cxl_mhsld_realize(PCIDevice *pci_dev, Error **errp)
+{
+    CXLMHSLDState *s = CXL_MHSLD(pci_dev);
+    MemoryRegion *mr;
+    int fd = -1;
+    size_t dc_size;
+
+    ct3_realize(pci_dev, errp);
+
+    /* Get number of blocks from dcd size */
+    mr = host_memory_backend_get_memory(s->ct3d.dc.host_dc);
+    if (!mr) {
+        return;
+    }
+    dc_size = memory_region_size(mr);
+    if (!dc_size) {
+        error_setg(errp, "MHSLD does not have dynamic capacity to manage");
+        return;
+    }
+
+    s->mhd_state_size = (dc_size / MHSLD_BLOCK_SZ) + sizeof(MHSLDSharedState);
+
+    /* Sanity check the head idx */
+    if (s->mhd_head >= MHSLD_HEADS) {
+        error_setg(errp, "MHD Head ID must be between 0-7");
+        return;
+    }
+
+    /* Create the state file if this is the 'mhd_init' instance */
+    if (s->mhd_init) {
+        fd = cxl_mhsld_state_create(s->mhd_state_file, s->mhd_state_size);
+    } else {
+        fd = cxl_mhsld_state_open(s->mhd_state_file, O_RDWR);
+    }
+
+    if (fd < 0) {
+        error_setg(errp, "failed to open mhsld state errno %d", errno);
+        return;
+    }
+
+    s->mhd_state_fd = fd;
+
+    /* Map the state and initialize it as needed */
+    s->mhd_state = cxl_mhsld_state_map(s);
+    if (!s->mhd_state) {
+        error_setg(errp, "Failed to mmap mhd state file");
+        close(fd);
+        cxl_mhsld_state_unlink(s->mhd_state_file);
+        return;
+    }
+
+    cxl_mhsld_state_initialize(s, dc_size);
+
+    /* Set the LD ownership for this head to this system */
+    s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
+    return;
+}
+
+
+static void cxl_mhsld_exit(PCIDevice *pci_dev)
+{
+    CXLMHSLDState *s = CXL_MHSLD(pci_dev);
+
+    ct3_exit(pci_dev);
+
+    if (s->mhd_state_fd) {
+        munmap(s->mhd_state, s->mhd_state_size);
+        close(s->mhd_state_fd);
+        cxl_mhsld_state_unlink(s->mhd_state_file);
+        s->mhd_state = NULL;
+    }
+}
+
+static void cxl_mhsld_reset(DeviceState *d)
+{
+    CXLMHSLDState *s = CXL_MHSLD(d);
+
+    ct3d_reset(d);
+    cxl_add_cci_commands(&s->ct3d.cci, cxl_cmd_set_mhsld, 512);
+
+    cxl_mhsld_state_clear(s, 0, s->mhd_state->nr_blocks);
+}
+
+/*
+ * Example: DCD-add events need to validate that the requested extent
+ *          does not already have a mapping (or, if it does, it is
+ *          a shared extent with the right tagging).
+ *
+ * Since this operates on the shared state, we will need to serialize
+ * these callbacks across QEMU instances via a mutex in shared state.
+ */
+
+static void cxl_mhsld_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+
+    pc->realize = cxl_mhsld_realize;
+    pc->exit = cxl_mhsld_exit;
+    dc->reset = cxl_mhsld_reset;
+    device_class_set_props(dc, cxl_mhsld_props);
+
+    CXLType3Class *cvc = CXL_TYPE3_CLASS(klass);
+    cvc->mhd_get_info = cmd_mhd_get_info;
+    cvc->mhd_access_valid = cxl_mhsld_access_valid;
+    cvc->mhd_reserve_extents = cxl_mhsld_reserve_extents;
+    cvc->mhd_reclaim_extents = cxl_mhsld_reclaim_extents;
+    cvc->mhd_release_extent = cxl_mhsld_release_extent;
+}
+
+static const TypeInfo cxl_mhsld_info = {
+    .name = TYPE_CXL_MHSLD,
+    .parent = TYPE_CXL_TYPE3,
+    .class_size = sizeof(struct CXLMHSLDClass),
+    .class_init = cxl_mhsld_class_init,
+    .instance_size = sizeof(CXLMHSLDState),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CXL_DEVICE },
+        { INTERFACE_PCIE_DEVICE },
+        {}
+    },
+};
+
+static void cxl_mhsld_register_types(void)
+{
+    type_register_static(&cxl_mhsld_info);
+}
+
+type_init(cxl_mhsld_register_types)
diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
new file mode 100644
index 0000000000..e7ead1f0d2
--- /dev/null
+++ b/hw/cxl/mhsld/mhsld.h
@@ -0,0 +1,75 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 MemVerge Inc.
+ *
+ */
+
+#ifndef CXL_MHSLD_H
+#define CXL_MHSLD_H
+#include <stdint.h>
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_mailbox.h"
+#include "hw/cxl/cxl_device.h"
+#include "qemu/units.h"
+
+#define MHSLD_BLOCK_SZ (2 * MiB)
+
+/*
+ * We limit the number of heads to prevent the shared state
+ * region from becoming a major memory hog.  We need 512MB of
+ * memory space to track 8-host ownership of 4GB of memory in
+ * blocks of 2MB.  This can change if the block size is increased.
+ */
+#define MHSLD_HEADS  (8)
+
+/*
+ * The shared state cannot have 2 variable sized regions
+ * so we have to max out the ldmap.
+ */
+typedef struct MHSLDSharedState {
+    uint8_t nr_heads;
+    uint8_t nr_lds;
+    uint8_t ldmap[MHSLD_HEADS];
+    uint64_t nr_blocks;
+    uint8_t blocks[];
+} MHSLDSharedState;
+
+struct CXLMHSLDState {
+    CXLType3Dev ct3d;
+    bool mhd_init;
+    char *mhd_state_file;
+    int mhd_state_fd;
+    size_t mhd_state_size;
+    uint32_t mhd_head;
+    MHSLDSharedState *mhd_state;
+};
+
+struct CXLMHSLDClass {
+    CXLType3Class parent_class;
+};
+
+enum {
+    MHSLD_MHD = 0x55,
+        #define GET_MHD_INFO 0x0
+};
+
+/*
+ * MHD Get Info Command
+ * Returns information the LD's associated with this head
+ */
+typedef struct MHDGetInfoInput {
+    uint8_t start_ld;
+    uint8_t ldmap_len;
+} QEMU_PACKED MHDGetInfoInput;
+
+typedef struct MHDGetInfoOutput {
+    uint8_t nr_lds;
+    uint8_t nr_heads;
+    uint16_t resv1;
+    uint8_t start_ld;
+    uint8_t ldmap_len;
+    uint16_t resv2;
+    uint8_t ldmap[];
+} QEMU_PACKED MHDGetInfoOutput;
+#endif

-- 
2.34.1

