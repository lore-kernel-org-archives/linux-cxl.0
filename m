Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86501283FE6
	for <linux-cxl@vger.kernel.org>; Fri,  6 Jun 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749214586; cv=fail; b=P+yt2Lv07WKFIGnDsSkRdSPUYqgp4dRecFG/znCWS9Ql2NdKuye5floQDN8OoK6qtBmVts9rL5soeDCKBpY19go/toDWye3CM5NbdZ0WdGST4wT2QOfu5lk/E5jWUw12x/CD2IZX4zWjkSgiy+Uhv1ck21473DYztCr3eZCzqIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749214586; c=relaxed/simple;
	bh=ALKHLfy6WtsJZNA+un5PDEAyyOqSogfSyCcflt5Ttp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEqQNUSj1OnZmlhOFjMMxwti0C6vr+xOMnzqgPXqpbMNKeP7AyvLH67OulD334p0SfwTEXLkfdCtIoFIoYy9Um4VrpeJa560a+Hgec7OpJhNxV3sz7VPEn1xNTx5/KpyHM3wx7Oao9VXang4I1A/J4bf6eUqp0L4YkRfmn/sJWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hM+6WzRP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h50KDC2k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hM+6WzRP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h50KDC2k"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5565NDfn021672;
	Fri, 6 Jun 2025 12:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=12koHugNwmdb9464lin6/mhSttlEsrVRVBOF9REsdLM=; b=
	hM+6WzRP3xSgZ7akZtZSZEgIM2mw569CCh0zfZzI6fc3K6oaCXhUS4GQXyUvbKhG
	KvoSe2RoILGoOuoYF+meX3kvL6eIFklg/FnlVNJ3EhSlYEXIbavHA3tOUgrMplKb
	iyuQ+1JoZUQ4Z3iVQBtlP1a+Il7KHn0lBg/seYEFxc0WIut9EEn5IyC81Be1Akd3
	T7fUvmy9FBCpnEpWcp9lymMyZcUL8d6keMJyc30HjdntCYsOM7emfCaFIZqipvlm
	u44A4WTaT5D4bo++FW5ShvyVVFoalcTJO1UsGaXKmMchPWIKh4dCaug+YQ94jEkN
	HSXPsfruZd6fWZhnl4BLSQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8bqwdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 12:56:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 556Aq4vm034966;
	Fri, 6 Jun 2025 12:55:59 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012014.outbound.protection.outlook.com [40.93.200.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7d8dmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 12:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsaOGTB3kHPeiw6HW7Hy8tCSVBvUEOfPdsik5y/2cIL7BB96Jt9TANGQcfsygsBtX15k4nESHQ0YQ7uEtFTZ/k+2UU857XEXqmBc9gzZj/bZaGTP4ypwhRl/T5tvJutDbAgeGUCrVGCA8Yk0KwLeYsN0o5/TkIzMG3Gu7GYX3416/jZAo/VxsbtYVJgTnXwSHhlatE2rzBrRn1blt1Vm2U9pwO5zethCTN+ddhDgYeGc+vrf1InMWVACT2K72Kf/LaE8W+oWjiXAfUQx+GEFPKDScqaJNUQHT6fNoQO8Upv2DutzfhLShlibqtcEzAnrjbm79L1A9I91o6K9vh+W4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12koHugNwmdb9464lin6/mhSttlEsrVRVBOF9REsdLM=;
 b=vpImTrQfGvhxVisSHCy1iq5AJ7uYoiYqEVdtOG1j4DWG4y1iN2KR2iSj+IUHM1wn4XzI6EbJAo9QUSUFz+yKkw1pecl/lfs/4uc5fnshqXbywP1WXghhCKeViX0isl/fuTysc69JkIXz11u2Wh4YxuoLUJBG12lp7mrpGn+Di1sP0myL7ATQt4FUSTYFjXEzb80dsBWNO5ul0aiEUpNogM5TPc5x01u5x3JgqX95Ua6M0Kce+RCz2lWmj3acZyiqMT5hRG7bT3xpt4HypFPeqoBtbbW+rqtZtTClHC9bIpjOTkBHemrPPH2F5j7FzY/qsUhuNcBXScJ3iriI+FC0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12koHugNwmdb9464lin6/mhSttlEsrVRVBOF9REsdLM=;
 b=h50KDC2kks7JWPnNrG7WWjctbVF0RrEv0xr/sn+9Gge3jspBgBCAZzOkwRPSrU0cXP+T8IaIDuaifS92owyLCqGPQQBn5RHQ7Q5P1HbXDYzRsW25nsKqliJO+DW/FNDeR6xr1zGm7fy+FmUatgdHbPjfreGx5BFdTKFJZShrXbs=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ5PPF2BC420A1B.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::797) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 6 Jun
 2025 12:55:56 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8813.022; Fri, 6 Jun 2025
 12:55:56 +0000
Message-ID: <2bdf06d2-64b4-4626-8782-882bc6c1e60e@oracle.com>
Date: Fri, 6 Jun 2025 18:25:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v3 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC
 Release
To: anisa.su887@gmail.com, qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-10-anisa.su887@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250605234227.970187-10-anisa.su887@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ5PPF2BC420A1B:EE_
X-MS-Office365-Filtering-Correlation-Id: d83a8f4f-66b0-4ddb-2b70-08dda4f979ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWszT0ZOKzI5alFLVG1JNkVEUmtHYUptelNBSjZpS1pFWkZWVmYyVTg2bnMv?=
 =?utf-8?B?OUtaMllEY0ZMZE1kOE5zZDEyNHFOZlpFNUhYVEhYaW4wdVJYTlV3TzVOMjB1?=
 =?utf-8?B?c1U0cnlqY0NoTVIrbVRIdkJhUFJmSWFtVytodTRmeXZRTlV1bDNob3FzWTBU?=
 =?utf-8?B?Mzc3eXJGUHd3dnRFSHhOeWxCeDhESWp2T3BtZGRLT1g1aWthMyt0amRJY205?=
 =?utf-8?B?YStJVzZDYXQ2d1J2bUlVSVFvRWlldXVoTEMwdnVJQVZ1Z1d4WFA5T0VJL3hl?=
 =?utf-8?B?cGJxOSsza2NoVVhFTjRDSjY3RVRVT2xLNjhXKzFQdURwMmZpTGNSNE0yNWky?=
 =?utf-8?B?MlpjTWNZaFBxMzdDOEVwR0lmZ1d6TjV0NzhRZXFhY1kzMS9oRWlVTFNOUkl2?=
 =?utf-8?B?L1UrWGF1c1ovWnlmUVVHYUZSbkJ0dDR3aThGMkJLeDNqRW40OVRHbW9VMStz?=
 =?utf-8?B?MDFWT1lxWlNkZUhncFFNb2daWExLOFpFLzNXNmhBaTUzaXZlQUVTU1hvMXI1?=
 =?utf-8?B?VXBpakl6OXBlRmpjOVdmT2RRelVPZTRIc2xyK25ZdlRFWnNMeGV1NTBhY1hE?=
 =?utf-8?B?ZXEzb2U4SU5nS0oxOXQ1MkRFS0owaG5ZVEdpNHM4d2p2SG0yajhXbmJuRUZY?=
 =?utf-8?B?cHZWZjVVcWI5VmJURlRnbzFjZUJWTTl5VlNlS3h4dk5VYkNYM2h4dXlVa2lQ?=
 =?utf-8?B?VXRub1J0S2tiVmhpWiswaTZRdzYzM0VwWTVzd1NJOWlzd00zWUlLa1N1OXFn?=
 =?utf-8?B?RzF4dTZUTjlIMUJTa1o3ZVo5VzFnV1BOSk80MHNOMHlJaC91VDQ4UkUxOHNi?=
 =?utf-8?B?M0VGcVZxNmpuOVZ2d0taM1pYYzNzUks1aHovUHpUV1pydmh5YVpUdnh1ZnJt?=
 =?utf-8?B?d0xtcGNEeC9FdjlBNkFJRk8rNXVvUnB0d2xPbnliMXhjWkxYTDg4UnBReTBs?=
 =?utf-8?B?U3NWYWE0ODdqQUh6Q1NhZWhYVmwydkRhZkJJbjZvWG5Mc2kxcTJCZU52N0o3?=
 =?utf-8?B?M0xxY1NOSHNzWDVET2F2ZHdlUGM2bXk5c2xIUkdQVW1UYnJpSmhwTnZIMmk5?=
 =?utf-8?B?M3Y2emJmcVNGVVRXTEo4ZUFMWS9nejFvUk1NMW42UlhaSHRkUWlnM3pta0Er?=
 =?utf-8?B?ZEo2MG80TE9YSE5Kbmt0SGczUjd3UUhvTnZrL0d4b3Z6SEFFUFdiSE01by9r?=
 =?utf-8?B?ODNjWnZDS0o5a2N1MlNnZXFLSjhuWkk3VWU2RkpmZWhPdm1aSG0rcU1EclFI?=
 =?utf-8?B?MnE5akwzSjY1RXloMHVkTmJoR2dONEx1RkhEVlNzalJydlcvelJteVhvRFdD?=
 =?utf-8?B?Q2VFT0l1NklBTE1DTVNJbjM0cDVjR1ovZHVWN3pFZ0RXZFd5dWR6RnV4WTc4?=
 =?utf-8?B?SlVvL0NpZzNzV25HUFZIN1FNZkpKZjhBdmNQK1dxRGRJR1pqbmpEQm53MWhF?=
 =?utf-8?B?OUJzTHorYm9lbnMxZW84WUF0ZjN2VWNBZWh6K0lKWjlZb1g5VVFJY2U2M3gx?=
 =?utf-8?B?aGRyNk1TVU5VTTdoaFBGSUtscm51R0loSWhWLzJmUDFaT1pPWTk4Z1RNbTJz?=
 =?utf-8?B?N1pEVkJUWDcvRzRLa3l2Q1NzSk00a0xMc0E3WW04VzNDWStYc1EybEZvRmJY?=
 =?utf-8?B?TFNYM1JnNXRKNjg5ZXFPRzJub01CRmFPRk9xZUtJUXloT3pUV1lhNU8zWUZY?=
 =?utf-8?B?eDN3Z3JJMmtpV3k2cDh6SzV6ek5KaFMzM2pQbnE0UUp4ODRwSmVtT3VpenFL?=
 =?utf-8?B?MVNxU1QzY3JyK3ZKMVFPRmxtVisyY2VRL3J6TFhXSHU2MGR4WnhRUVdPdTdo?=
 =?utf-8?B?aCtRcWVKSW8wQitGTXMveUtyTE41azRjbEhLMVlwOSs2d25Wa1A3TU96WnRW?=
 =?utf-8?B?TkFwOG1yZk9lUjFIVk5XL0dUcmhURCtQQ2FjaURTRXY2S0Q0RDFNNCtnU1o4?=
 =?utf-8?Q?4RRLO1w0dxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnBVNkp5VzgwbHZuNlBJVXB2ejFFM3BqVHVRcnhUdHZ6RVZVY2FmM1pTeFQv?=
 =?utf-8?B?dTlvNGFvZDVEc1FSU0lpYmFTRndKN1M3ZlZ0MmFoM1B5ajE3akFtWGtoUVo5?=
 =?utf-8?B?WHFKYk0wdG5vU2RqSzI4K0V2RDYrcXlTeXhmTU43ZkFBMlkwd2VxRnZGSVJH?=
 =?utf-8?B?V3pPZUMxR29XeXYzQkI5SG5ja1QyTkxWZFBIZUZIVGd0SGxpRXJCMHltd2sz?=
 =?utf-8?B?WklsL2VTeGNBNXRNRnpETzBOSlNJOGtBL1M5NE1DMDdJYTNidlY4cnVLSklz?=
 =?utf-8?B?OWJiUlhVN3YwMFZneFJyQ25peHBlU2g2eXFCNmtObnEyQWR6b3BzL1FMVTlH?=
 =?utf-8?B?U2hxcXNqb3oxMGdiZEFKZ3ZZOTdQUVdESGxXakZWTTkvTkxOdTRYTkQwRUlt?=
 =?utf-8?B?N0JvQzRwTFoxVnBZWWpiaGpCZ2FPaXJtS0F3NE8zMTFsdVpmaGF6TTF3SVhJ?=
 =?utf-8?B?OFNpTm1DRUxVNWxwdUZBM2p4UkJrTDBYWVN3TmtKeFZJeE0yUk1wR09ueGxZ?=
 =?utf-8?B?a3BjYnlWWkRlUTFFS1BHR2F1ZExHZHpOZTZaM2RrUzlMcTlwYTZ0SDJBREo1?=
 =?utf-8?B?MWZBMUp5SEptWkZRZEs0aGVqb2UvOFM4anYrVlUvYUYrR2FmK2ZoNFpsUW1B?=
 =?utf-8?B?YnJsSEd2SndzdXk1dVQyanBtTW1rREQxSERFaCtxTHhvZWxHQXlGS2l2b0ZO?=
 =?utf-8?B?Qk9FMUxodEg5ckozUXpYTEFoR1pnV29YbisrU0VzQitML1ZkZ0lpbmwwTWM5?=
 =?utf-8?B?dVlab2RxU09iaHU0dHBSa2ZYTmZxYVpPZVlySm1RbnNwUEdZR3c3Z2krVTB0?=
 =?utf-8?B?TzVVSm1sUERPVXVzeWxlc0R0SkNaREVkRHJncHZ3WmFxUWxxaDBwWlMweTNL?=
 =?utf-8?B?cWtrUVBwbEhZcmlXRVpjV0gwaE1kT1Z0eVltanRvQnVxTktnbUd1Um5IOExx?=
 =?utf-8?B?Smdoamx1U2VWQTYxMFYvcTE5RXJ5czVRUjRVM1Y2bUJpZE85ZFZQcEUvcWc1?=
 =?utf-8?B?Rko1QjBnTXF2VFQ1R1M0MTV3UWRkMW9RN05FZndtYTlpNnBmakNFYjJRRWFP?=
 =?utf-8?B?TnZDSTZ4TDExVnVLK0hKNU54cTFZMzJLTGhWK05nZ3ErZ3NXbDNlb2tmNFZk?=
 =?utf-8?B?SWxqVXVuNlFCcmNXeE10dVprb2Rna3ZMbHp1UmhpK3N4QS8wa1NHNEErMVgz?=
 =?utf-8?B?TUwzRjdtM2hWMGdkUnZDTGpHWDlONHdoSjFDT2NuOTF5RmZlRWJmalpYWWVZ?=
 =?utf-8?B?NTE5UHZxOCszWlZ6ZU5TRjJKa29lVm11WjdhZkc0WUEwY1VhY1BGamFQTHZE?=
 =?utf-8?B?Nm1SSnlNN05kRWN6dDlBYzRQNHVGMitEMFRuZ2plRG5CN0wybkkxSWxoNHVs?=
 =?utf-8?B?b2FFMnB2VlRoU3dPWnJoays5MWU4dHNMQkpRRk45clBwc2c3dThiNUYxOC80?=
 =?utf-8?B?WVVJaTJMaHlaVlJhejBMUW44N3lSdWhsKzhtNjcxRmFaT3RaUFlHTDdoOFlw?=
 =?utf-8?B?S1JTV0JNbjF6Qi9QOVphT3M3UHFUcjBpUFR0V3JtanpnV25vVjZHZ3BSTWpE?=
 =?utf-8?B?ekZJNW80djNCZjlsNDhuQTREbk9QT1puaDJKZW9lRGFVS1FXZXI1Yk90WllY?=
 =?utf-8?B?bmFRSUxGRnNKdTQrbXFDOGhNRzdlWmtaK3o2UmdjYWlmVDVLK05BM21tUSsy?=
 =?utf-8?B?WEdqREp5eG5LcHlRa0toREYyWDY4a2JVeUlyVXByRzl6UHVrTGVoc0xhbGRq?=
 =?utf-8?B?ZHJGRm9hclRpbjl0TTUyOG5zbEh2ZFBsSkwzWEtROHRGd3U0cHhKS2lZMCtL?=
 =?utf-8?B?WnZIdFhTNXcrYmJ6ZkRMQ1F2c3J5UXJCclpWNVZJV3k1MEduN0FFSFN3cll3?=
 =?utf-8?B?U2U1dGJoVmI1S2hWY3FGZ0hwMHM3c1RwTGpLb1N0b0VrMDZWajNIU3JDak0r?=
 =?utf-8?B?eU9aaTlOM0t4NURwcE5kQU1abEU1bnNxaklXbFpzcWJjaGVsL25EQXFhdlpr?=
 =?utf-8?B?THJvRkVmc3hPUWYxQ3JqaVBkd3YyYVliYmJzRDNJQlRpdWVKSmxoV3daUmZz?=
 =?utf-8?B?OFI4a1BRYnFpb3hXZnNkYlJsVHRWeTd3T3g5ejFvb1NoRlNjZGhQak5CNU94?=
 =?utf-8?B?c3JjZVQ4VHNkQVUxRkdESnQ4QjVvUzNkVlpEc0I4MTExSnBYV1NMdncvQ2ky?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h1en/1xXkPuQAs25eOOYEfXiD+fQy0v0jFbCY/GmCrIpVOiiAqYfiFn7Ny9EecezuR1dQGn2KLufOI2/kYt7Ir7Za5l90UQHq8zPDwVqR/1cpEl3eaIBDqYBUacloj8WTdULgQPNR+5S1Xc1pl9XQtEoPTUtWQPNlxiXMIHeUblONdYuMkw91GlFPdiAtROUDEEwH4NGH7OXz21xOAofcX5yqi/IubyG1DMMJSzf7LsMe09yeHPnAb6CWb+kuI7SuI76T/OKB9SzLZglOtprx2okKZc3T272WCHtq3fUhHs3QJIyTWH/KQSYpsM37s8RTF1gVm9vliHVLfNAx++22kNANocnx6FjtWZwTo1T1fYe9tm2I3z1sjDTlELqL6iBVGebQ+5fLqm4reg/kt6SI/SqAgusKDIpkjGtQ0h5ffWmmB1n8Bzhuw5zwOGVoCHK58aFKuVgNe6FCuEyNFH97GdJCIsXdXBcjzLRJCIgeergrLUoNpAYuShLQomxvhLTTqW5fXZlx2ZtsOJsb2wy6kzAgU2yJsmLIRkyO/trCNwXsd/842y6xloqWChoXpdof3Sukc9+KTMhNQt+TGYSnGbhs+3NKqlvjU5768z9SUY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83a8f4f-66b0-4ddb-2b70-08dda4f979ff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 12:55:56.1271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0ouhmILZNXwGJtSZ+EZNozowQu48CrO8bp/sFMzPqrT7b6EcCVy/26wcDbv3qMZrxWEtzAqe/y2CXPqKoL6Smalb03KTlw3xa9J8To4JiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BC420A1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506060117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDExNiBTYWx0ZWRfX6tuVDJQVtHAo 9+6+T6eflaLqorxOmWVzzek9YE8NbJ7MeehnWYdrly2XR5cLoTjliaScHPAH7GL7uf3JoMSyGZo JroKBPWRa8O3tRhuLp1M4DELPq1rzrFJuP7ofMZ12iVNPCrSpLCn3GWh9MlSSQH2e2Y+MJdIlQf
 +XNhzXhHCcbOZZapq43cnDXh9H4eUOs282Fbn5n0s2PMNaZPUw2oRTXNa3aNlGI4cdELiYbn6gk iAxTBviqQOZGoKa4TH3C0qM9XxpNmkYkw3spmvE9PK9Kvn8CtgLqEBP8Ko/h0TTWYxAymjoukY8 OSdSDZE89AuVi1TcQz4O2fDkELoEtRjLZ36KSYDtEWl5RYmGnGcz3VtWiDVlfLgQdc8ZeOaNcJ0
 TKU1pGE8SDPFhwfmVTzT9H+JT+p7HBnALARLn9x5OM9439bQUA3FLwQKfJ1/nfXGIAUwxUGZ
X-Proofpoint-GUID: MyKdzqiKRHkCmIDXY1gbLN8OAgFVWDOu
X-Proofpoint-ORIG-GUID: MyKdzqiKRHkCmIDXY1gbLN8OAgFVWDOu
X-Authority-Analysis: v=2.4 cv=H+Dbw/Yi c=1 sm=1 tr=0 ts=6842e560 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=hD80L64hAAAA:8 a=r8ry419ZFL2ft1S7DNAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207



On 06-06-2025 05:12, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6

typo Managment

> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c | 62 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7ee5be00bc..6c57e0deac 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -124,6 +124,7 @@ enum {
>           #define SET_DC_REGION_CONFIG        0x2
>           #define GET_DC_REGION_EXTENT_LIST   0x3
>           #define INITIATE_DC_ADD             0x4
> +        #define INITIATE_DC_RELEASE         0x5
>   };
>   
>   /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3685,6 +3686,60 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>       return CXL_MBOX_SUCCESS;
>   }
>   
> +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x7
> +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
> +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t flags;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLUpdateDCExtentListInPl *list;
> +    CXLDCExtentList updated_list;
> +    uint32_t updated_list_size;
> +    int rc;
> +
> +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> +    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
> +        list = calloc(1, (sizeof(*list) +
> +                          in->ext_count * sizeof(*list->updated_entries)));
> +        convert_raw_extents(in->extents, list, in->ext_count);
> +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> +        if (rc) {
> +            return rc;
> +        }
> +        rc = cxl_dc_extent_release_dry_run(ct3d,
> +                                           list,
> +                                           &updated_list,
> +                                           &updated_list_size);
> +        if (rc) {
> +            return rc;

list free ?

> +        }
> +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> +                                                     DC_EVENT_RELEASE_CAPACITY,
> +                                                     in->extents,
> +                                                     in->ext_count);
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +            "CXL extent selection policy not supported.\n");
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;

unreachable

> +}
> +
>   static const struct cxl_cmd cxl_cmd_set[256][256] = {
>       [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>           cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3819,6 +3874,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>           CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
>           CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
>           CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> +        cmd_fm_initiate_dc_release, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>   };
>   
>   /*


Thanks,
Alok
