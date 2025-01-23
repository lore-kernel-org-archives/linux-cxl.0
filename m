Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA0714BF87
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658418; cv=fail; b=bOGKpB1d9drJp9cV7i5qRGGW/nQjfXs29BdfmvYrBL51hu96hjX4+eZfN8ohcrYXo3h49/qcduXQHaublsUxLC6SmvZxFh1zGwKwRcSMAL9NdGXAaeKX0auOkryoDGAL5yposzYziQ6G99LA0pLXm6mu+ISqX25UqGFSoKpB/Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658418; c=relaxed/simple;
	bh=rNk5eK3yTn1bcYF1hMz54tbSXY9AmMkQKy0FOqCSv98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j2Ml6eq+vjsMclWNFRnWDNsDNeCghqk1NJPTYTVCga9Ld4+5ZwYMNyJUMemFGt8sURHHoaOzZpAHiq/BgpOoTs/E9TknXcMmcrRSVUl936zMr5obDZZ1qYxv4f+3ckcvAGFYJdiWv73PbMQtOvL8iXysOjiZRPrnkvtGVsTEHi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kGmNOCBV; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kGmNOCBV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWQtBuhZwcfYulJ09oC/bS/FGZ2DckbmCdNFvxfNwcX3wsEyqrBJ1QI/5NqaxY+StTwIILDvI4H+amID6OKtdTsEuIqNGnLk3/dL559YZq87fjBSw73pgqTVcKzywkXvbSRWbljmH9kF9SPrTkf9+7KScuu3oTqfbtMS2BBn0JnNFMVYOOEkt75KSEbwXiWTlVIe/KxfKCSzQ+UB6nRU8w1RNBUQT9i8hT6kZfxIOOSULgOaQAprXLipmrkYxPNdqn4EoPJMaOllmRcP20WVS12ZF/WT8du4P14S0tGNUqoLLN6CjVgPkxNoMIhf80j9NQrC7dqAfdEQ7N2Lw9wiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2T/zkKqeTZVJ6JM8k0FhIgl+b/pICz7oGRW0JHDohk=;
 b=RCUpKhYXPyfu4fkLMekAfxh9770WM/TLaQwZhYMFbYsM4OgMF9muAlHooOWpRygzxKkx9J3GlyY+G1dw3r4V85dBYut01FV0GSmL5GKvaVTpR0jnxZCLQ4Qfog+4e9Dn9uDgZAF8gP0azW5MXwtBq5NvCMn7coF8qSpQVZCiFc4WXaioMFzBfFJPaI1PxzTXpoM5M8PIg62F9kcFsQcV0fMnBusO1Ywyh/dSa2TyhGlG8jyPQIFbs9VQeibPtjDSaZhLTjwsFo026erl0nmOcyDSl8bufc5wfXZHgaTi5sfADBocvlg6PEN65gdi6DLkiZR/W3gF4h7pd44TQHQ8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2T/zkKqeTZVJ6JM8k0FhIgl+b/pICz7oGRW0JHDohk=;
 b=kGmNOCBVxu75ZsoMQSGPq1jh2/x9LVhI9HisDoFF2o/ANLpO+bEBbkppSIYIpZ7u1i+LYAwOK3Ef2ceipGg9xQlMIpDloBN6pJETuJiTGrDDLiyBngTj5vGWYv4e+qJRawfmqt0oz1MyoXRLPweHbGESpo0n1qtX7HzvivyQfyRQHhq4sqsyH/nuWkSfODKlDSAiuQxRrmGf4tJQINK4vyoHf9zpTV/TdNgZcLFOPG1wXHUkU1OP8OdmC4/+kTlVKmcUuK2dIHLgA5KbLOc0pQ2KtxxHF7C4DsmMCjQ08BhpS4I6KE1hOByA1YXyEOKUOU7/a3luw+7of8Jb9u5pRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 18:53:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Thu, 23 Jan 2025
 18:53:32 +0000
Date: Thu, 23 Jan 2025 14:53:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [PATCH v1 10/19] cxl: Add FWCTL support to the CXL features
 driver
Message-ID: <20250123185331.GW5556@nvidia.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-11-dave.jiang@intel.com>
 <20250123180430.00006070@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123180430.00006070@huawei.com>
X-ClientProxiedBy: BN9PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:408:f7::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: e64fb8f9-a033-420a-efdd-08dd3bdf3be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tEqXFw15RYhiqG6P7ixKsCmPtKTLFTAsuIWI7s0ES+1BEklJKf1HNqgzXP23?=
 =?us-ascii?Q?o9VuFS/RcAP/hhdZdfJUBPbYWgiuP4zos0zsOT/zraQQZTbvXlxbmTvKH88w?=
 =?us-ascii?Q?d0Fpd7R8DFZvbXh3FX+liOOiTpUTEt4LLIDzC9OXHvDvRdo5e+yWsRtzMwVg?=
 =?us-ascii?Q?fPHG8Q5h6Dx5aBs0TU1eYdH5SOv4eb4h8PIABK1PFjyRhokQlf3TKA2lyJ1z?=
 =?us-ascii?Q?OQCTN9kREt/KmecZwGwllPtAsVKBBMuzAusR1NPgQ27VpdSm0QmJ8WSoxUFu?=
 =?us-ascii?Q?ypkFC/Iqpp76wvVovVX8mu+OtKSsvPF1COSJMNhGOXYq5bgHJAZYjzTrwQyS?=
 =?us-ascii?Q?V5xwk2jKTQv5gqHAf0OH5DJALwFg2Ewx9fNyGFc6NMVubeWdIC+BWsliNuH+?=
 =?us-ascii?Q?vMI/z0xGr7quUZ8CCq59Vn6M5twXMESKRFaXlPLLlFPT+SO+2fJHn+FYhN0x?=
 =?us-ascii?Q?ea8njO3xkMgNXIf1LjujYDSUIQkG+lhZqPj6MFjJj4Xo0tMWYpWeSd+P358N?=
 =?us-ascii?Q?TxS7pVu3ZrmN+Ttl4sMUevdsyXy9kEA/C/qi3LNulzlymbsle5luK8EPwPeo?=
 =?us-ascii?Q?xyZXEst36LJ/P58FIGNbGmJ1Yeq0YidwfXtXtqXzQ9AoR5WepmJs5sEG/jiu?=
 =?us-ascii?Q?b6oKNattYFhmJ6A7IcokAmr9dQ5Hjwfsh34ELvs9hlN2MR1DvDwGvzrsEMzG?=
 =?us-ascii?Q?VgEUNnSDen6qhPMXixN2Xn0iet1gBVHiMr1Hm8XXD5rhMNqujoiXjjl39cKE?=
 =?us-ascii?Q?jfaUaQf063IlwsdVoUuZMyNSqGXw/Rew1tONF0FaBMn0BFgpo2wvYYx8JKke?=
 =?us-ascii?Q?mAF1Wy2GXaOkd+W3rk/NfyQiWByo92g0YaQIJoxPz93zSknKsZph9fwqcDz5?=
 =?us-ascii?Q?zkCd4BrgbdRoitbgewHLoaiS9Xhz507EVbYYUaRPAlTA0o81rcieobqY0OO5?=
 =?us-ascii?Q?udzTxMONaZNxAKrRA5NMf4FgeB9Mfsumi1wYrDC6NpPZjerqw0SmiYqSeClL?=
 =?us-ascii?Q?2vsq4Blyizs7rp8dJ72LR4Lzsq890X79sX63D2MvP0X262jSIxVKggrC2jjC?=
 =?us-ascii?Q?bBGKgI5hRxL1WHwh1HcjhW2tbWg1qnNhWvGRLsK8xcPjf//h93Sylez4aagr?=
 =?us-ascii?Q?06/gP1abbXh0FOfLislfX+o0jzaxSwm1anZQtw5CPWfW5n7Aek7ylzDzZKTU?=
 =?us-ascii?Q?VqdSJqN1P8e+4aAJIK+ONlAxDaZrzRrbIDCXdvvRwQv2JOJ+KnIdse5R1MxI?=
 =?us-ascii?Q?FvVkYVUw/lWew21fet5NFInsE4SJLYo4NnId2iuL/I9D/+2BWmUH9OPMkF2V?=
 =?us-ascii?Q?NLMVCObSVYKg9dteOEpH61a9O2UV2wZBSLwIYcvW67SGNHrs9IDk02Cbk95b?=
 =?us-ascii?Q?rvQa6NVoaPFkD3AxXTKiBqGWgeP/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J89ELUnq8GLvRn9rfYuKK9oSrxS+PHKFZHJ9YoiShJoF1l8B/OXpt0tgtMp3?=
 =?us-ascii?Q?Y61JmDKztggA7NenNm3wMcPUOjoMajy7xALOdB/5nsGLsrgtEjyzIdmdc71H?=
 =?us-ascii?Q?+NQ4Cj/kWAIocY2sJaKSI18yF3lMxQi5SeAZPVjJpSO2G427xNZi6FV+z0Zm?=
 =?us-ascii?Q?/fIIyX1K9miU6pKDunEMyWwfxFXaf9jeCEBH+GG8OVSAHSMEXPBK7G8Eozhv?=
 =?us-ascii?Q?LMTnkrvd513Fa5NFCIroR0OVhx6WYJ43DZbFqU/k7rA4lxFB+UCPPO9cW6Ek?=
 =?us-ascii?Q?z9ZkevgwxMiydKblT+SCJabBWQzcvVT5n2Lk3GoIGV1m/uCkw/+kwVuHxA4f?=
 =?us-ascii?Q?hfuzUImeAgCWffrJ2+8aBxfJLVGmeZhxZmuEXCA5FXRlXu49fTB/IeKN3ppM?=
 =?us-ascii?Q?ONr8s3/2jyOm7So05WNjmCc+ntaWPhM8GzMHPptjGi323ndoUOiD/ZRN8FdG?=
 =?us-ascii?Q?cPhBLFP2yevqk2vj3XPOlqODm1f/OvbBFTgUQK1hvjpaI+4AwcRRe4FSKo95?=
 =?us-ascii?Q?H1rSU3sNpmBt6wD4ffCR5jg3bt2aahCpmdsecdcnDNPg0Cf03DFQfl1gD+/i?=
 =?us-ascii?Q?MdsRHhildwM8tyagmnV/dYlIVLHij5+0IB+e7vnm5Z5L2aR3+MzTSL/sglbE?=
 =?us-ascii?Q?25LxB7joTbMqogCxiLB0R/+OgvyYZBrNEl1s2sJ7f0khf/IBFCAHYq0vXMQ5?=
 =?us-ascii?Q?ysU0MUwEl6rB7kAipy6q7Q+iQkmxdVMCjcoQfOHhVqrfZtUZlJr08/Hkb1Cq?=
 =?us-ascii?Q?eSxX4JW+s/h25gk1MoIMcgyWn2IvmB7cjlqdkVDM4ZDi3/nIbev9zWnGRsDM?=
 =?us-ascii?Q?CrcU3lGoNX+HXljbU3K9H+RcweVGQJNZC3yIK4Enxt5ga0oL279iVdefUPEu?=
 =?us-ascii?Q?ay7ByY7Ry3hbGFy7XsZyg6DFc7NL/yBEm6mFFiQE90DKX+iASSsB+sn9Nfug?=
 =?us-ascii?Q?iCpq7TQvq153b4Al8sR6Vi10Wm0g2nmZfwV0mlUiJ/3QMH3kaABObVjKTDmF?=
 =?us-ascii?Q?uWFnG8dR59nLb01QR8edcStIrmnEhxU09xZcxkutP4Be3VlKebWoxM6NlxaT?=
 =?us-ascii?Q?DhXo1hzca2FP33AEoH7lsDyKTOaeVvLVqXaAmOuqVXjhO6fFsKZpa86ETkgI?=
 =?us-ascii?Q?8OyEoKAXq+AGOnVJ5EUinrH1/f4R2ueM3PsWUAJpEtLLp25wWFMoTFYnTL+f?=
 =?us-ascii?Q?5SkIeCOM0UKN+FzTwPHUmDcPIvIWd/Xfrrd4LFqOUEsfnIf+Eu7UhWoy696l?=
 =?us-ascii?Q?Qhs7neP7FkBvP9oj5W4Aj2VKhHzFOB3xWthZR8hnoEkF/JrOel+004iqAimP?=
 =?us-ascii?Q?3iZ2PtyOD8RJiziXBpFfYc3+tnNFfCdiljzk69HfPdD+eamMQYGaJjYcEvrE?=
 =?us-ascii?Q?R4lrMtfYo2Up9PwyELpyQlTSZn7IKPyGaldeWQDiI3rODDOgEE9GTrsAbaIS?=
 =?us-ascii?Q?Nde3xxhVlfLUO3cBjBckW1K3q7uzAbhwf+j+VtelA6M9o2bP/jKQ5Ehrsoea?=
 =?us-ascii?Q?/KDK4fpLt6QtOchV7mQBGCURch5z0Auyk9yZn/O3nVIKcmQy4894gN4I11LX?=
 =?us-ascii?Q?HSPKvnGNXQzQGdjyBNx/D/TH/ZwYTllKvlu0ZJEs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64fb8f9-a033-420a-efdd-08dd3bdf3be6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 18:53:32.6606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlicl9VmRhvAC18MHIdIPJN8w5ASMG6j/T6tV4RLbiY/UqGQ6q/ZUR2E+Kc1tYv7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014

On Thu, Jan 23, 2025 at 06:04:30PM +0000, Jonathan Cameron wrote:
> > diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> > index f9b27fb5c161..2c3817592308 100644
> > --- a/include/uapi/fwctl/fwctl.h
> > +++ b/include/uapi/fwctl/fwctl.h
> > @@ -43,6 +43,7 @@ enum {
> >  enum fwctl_device_type {
> >  	FWCTL_DEVICE_TYPE_ERROR = 0,
> >  	FWCTL_DEVICE_TYPE_MLX5 = 1,
> > +	FWCTL_DEVICE_TYPE_CXL,
> Seems we are giving explicit numbers but not for CXL?
> I don't greatly care either way but we should be consistent.  Jason?

Please write out the numbers in the enum, it aids backporters in the
long run.

Jason
