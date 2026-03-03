Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18DE26C38C;
	Tue,  3 Mar 2026 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528813; cv=fail; b=nA1CZoOpLGyrBfEiEmmE/8nw6bMo04nZobqZWAzMCF7OtAH47l6EdQ37D5baBTE+QDO5sdgVO5g0+oA85PaDCB1YQYk369UkxSkpduN2V3tguKzTgayNy4q8tYtjAOIyOOuIqV3tZGmaijCSoYMEzOzDSS4k+EBJccwho5LOYm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528813; c=relaxed/simple;
	bh=GU1TGeqwFO1neHeWhnfmBlmBkM/LLo6I0/eDz+ZjmJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fNCgieGMX77lDlOFTV8p/WlxIqpyUqHtcwo3LZrXuV5tPiK+iKDlni7N6cRn7pzGTt3RQnsQvjeDLzOIfESgos7xrw75QZURM9A5h8ZhdeP5e/2A6YxZ8hycEvfbA6N83qvO8JfQQeROtvUKC7g+040H6nbUuiLV0Xe+syTT3Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OMaGeIHo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fcQ0sehp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OMaGeIHo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fcQ0sehp"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62390X073764725;
	Tue, 3 Mar 2026 09:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EnJwj2Dckf+xcfdMi/3AWKPf2WEey/Mbg/HT4kVs6JE=; b=
	OMaGeIHohwqqCXGEsoSGWw0Y3MeVKxZYTibmFFdcx0xrbgahClgQUDVP/4mgVm8o
	QK4Na++V/Qfg5/LYm1ftJE+R7vQRIURtpUJ5VnfsW9Q2M5xEt/YrAXmoQS0emcdT
	imoOay8LOi1DSKIB7lgbzUL0EwQY3iT1Z9aHTp0mxpje+v67VQxyAWS4EWwflxMm
	imCcHMbXDC852bRI3u3ghO7HzL2t829ZecM9nJDR/EohfrFFEH1Og6dpw/VA+3Ww
	ovO0JZfR8VinS5xAJkkKV/mRWmiOuD/Gh5R1mx7ofB+aUi03zIhjo34f0uOs+Dty
	Ixzo7IHo+Jwm30aWhgywiQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnvmqr08q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 09:06:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6236jlUv023195;
	Tue, 3 Mar 2026 09:06:42 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptec2pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 09:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pw2L1FKWLIrxq7MF5HXLetKxUOuCMm+JibNvsjmtymnnmgHf8K1FH02AxkPAufAN/rZZhZOzTfxuathn9pJKaXIO/vkNfaKz+6kmrwVM0LjfIZ8VGvezlCaPNU6wdX/ztW17FQbhXG9Ze1kPNq7El/kd4W4fPD6Y7znF+u/pNnRTsROOvQV8n7gx+LwV9oA3ueMIEDxlZZZC9WXisW8dTF1hK7vlTACPXuq+oqEsbH7vZ7nGWknZ0OFXBhhMCKoQGcD2QApZHrD5PijzHIAsfQXOvwL9OhnoKLo7qgjK8V9vCGwfPZnY14v4I7gWwK51F+ClgmAfibvJIUBHOZAfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnJwj2Dckf+xcfdMi/3AWKPf2WEey/Mbg/HT4kVs6JE=;
 b=ZKISpDjwr/XTnKj2p+wzolY+SqOI+BfFyuk9h77LuwrXoMq+ZDAWsRIXAsNBrIa5XAn1C5vxwnLSO0T8M+455DGTAnHl2HhIC4+UUA0r0kz5D/K0Kvvv6GuFQj+JdjQcjUHQrtiotfzl1JRJnj4LOBYiu2hBo/00IRaYv7Baj6mfkwfOMK0QlodF0BbJpF4P9/dklXnQpoUmi45neurRFCJRNwBPWTo1pOxMJ1EV/H3Q9svGkBlylydXnGlVMLzOfJ7ptDS6gk4jo9I01TAyErR+vw4+qJuad3ydAABXoo4heUbgqKcUu4NoOUI2ALN+bDEDTLt+bgEb5umMJWU6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnJwj2Dckf+xcfdMi/3AWKPf2WEey/Mbg/HT4kVs6JE=;
 b=fcQ0sehplg1iIyWTy+cC9a+L3ph2pbf5Ii9rvoAanK6uoie8W7UJrOrDqLW/NgKazk8SUlzAwNb4YxszZs/sm/0sIaoAH1Rq0oPQtrvYv57b6ra/lFPqFrlfNLdi5Mr3YTJgtqCAs8ko4+pQi4wkP/ZU4cdXn+awRrm0pHACLpQ=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:06:38 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9654.014; Tue, 3 Mar 2026
 09:06:37 +0000
Message-ID: <10391e21-a77b-4531-ab92-032304436448@oracle.com>
Date: Tue, 3 Mar 2026 14:36:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: fix CXL_ACPI=y + CXL_PMEM=m link failure
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
References: <20260302200429.803417-1-gourry@gourry.net>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260302200429.803417-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|CO6PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 616d98ad-5aca-4d4f-692b-08de79042d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	sX02cbNbv0t92NN+uTIz0aaG/9yaXoXV6PHpyQNeyBYI3KyTdnHA8SCBa9pbRfr+C9UN9NNTkkVDGUJluywI3grR8HkmRsi31IReF8BJP8NNbYwxJ7kCnAl8FCv4eT5kjaGApKkLdbX6BvRzWPwBEJ8qB7hfVP+naL31cECkzGMJ/gRR0IJ6jzhyKZBZY4DM7DNypiSPu5UQzeMRPdZJQDVYwnt84MFkvSluhnrhbtTN/RrUE7H4rmNxAfeLSS3JW0QneqyCsijp8mC7JX3+2nM+yp2BvI90VMFVnJQ4VnhGD2ukcQzgyzoWPb6MwdRWn6Ht28hxRfkvP+bLMW82ZJPTK03VL0r5SZmUGvjeVbiL26DGOQELZGsCD7TrndkD2G78TXD/e0LFa8cyTorqtuyWXGjm1aSCZS5dgKUc/8cReX4AqeRpfRPsA9I2DHY9KbOpjVYvY+PUzvvWMbVJvWJyAsr6K7idzt0CwZVD32DxmC2O9NtydcEAt/zgbiWTtl2zxdTNS1euUmvzwKHTH0cIO9cFio17Ha41I+sJnGLW9wC05hc0naW15qONNHPabAf5IiWiHLpaeo+0rLogRP7r4zyqS8VFBy6Zt4KWX3kDv4uLs/5zzjCH5wTWed1tvWLezehyHvy755ue87HNDLtyNBW5E3mtWhCFgzgYYisMKRZCPFQhtI77Zry/hkzCgADjQ5O3yxR9jdmlmM3sfsw8dOwZWZSrJsTD4OwF4oY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXhmaU4vUndIKzFxM2pOM0FZT21FUUJmY29nRnpEN2Q5Mlg3cGNjbWg5MmRL?=
 =?utf-8?B?NWtqZmprcmVwWGxlTnhTWHZlR1BvVEpQMG9ZS1cxR2RWM0tKK1c0RDNPSjVu?=
 =?utf-8?B?cHFqRHl5bVUwa0ZFSUVxRld3TG5OWFFnamJCNnN4QWc0SEpILzlUN1BZV1pK?=
 =?utf-8?B?clpZRW92eCtCVWw0MVhieGxYT0tFdHkyUmQ3RkVXM2ZMT2UwdVpsa2VFazNz?=
 =?utf-8?B?OU8zVXRSVG1oMGFiM1FrVVdTTkR2SnNlSzMvUWtxaERqUzJXVHV6TGFPQ1N2?=
 =?utf-8?B?SkQ1Rjg5WnRFSzJXVks4VUZUVGtyU05OK3JnTmJtV0FKOThpYVlBaG9lMEVt?=
 =?utf-8?B?RU9SODNCSksrelU1U2EzaTRHQXB4L2s2TElYRHRVWmlRenpKK3puL2tobjJR?=
 =?utf-8?B?dFNCZzF1QU55WFQ5ZVVmSWRDNmsvbE1zRTdpZXZHbnN0RDU5aFcxcjQ4WHAw?=
 =?utf-8?B?OWJoSW45OUpyQUl1SUtsQWU4cmV2MWFWYm5ZbXM0ZVVLUzBWd0dWWG5wQzEx?=
 =?utf-8?B?UnlRdjJjOWhrUzZ0L2VvZnJnYkRuNWc3UkI3cEgvWjlISlNMTzFrd2lJLzly?=
 =?utf-8?B?SmVPUDloS3AvK2x2ZjBaMFVSNTZHb0o4NHhmTEp0cmpveS9yOWp1R3VPRjl0?=
 =?utf-8?B?Z2hXOTNoY29kUFBRbFlLcUIwQzg0dmQ2dGlrYmxndDdPVWxiWFVZMFpzTEVy?=
 =?utf-8?B?d0tJczBVUEZDMG8wc0VwSTNkeG5MMENZdmJ3Rm9iRTRnZkd2VVZUeGxOM3hB?=
 =?utf-8?B?dGpDTWtkQXZNV21zWEVNWVVXWjRjbTMvYkk4RTJmU2lqYXhvdTVidVprQkNi?=
 =?utf-8?B?aGNnVjdHenhoYnZXaHpvTWliaG9WRlFwSjB0UThYb0xJM0FycGs0UEt0SkJu?=
 =?utf-8?B?T2t5RGZvTjJRWWJlak4vdm5PMjJLdHpDWWtXNWhqeThNWERRQ050OFZnM1Jn?=
 =?utf-8?B?SjFFSWF1eHdzWUo5c2xld21DVW9DQTdqaEdBRWdneTBwaTBkZTFld3YwOGp2?=
 =?utf-8?B?NFdQY1JHYXJjVUJlS2VqSTdEbWQ4bXdkWmZQbWJyUVJFQ0thU3lRRk92bzBK?=
 =?utf-8?B?N1Q0aWZlRXkzbHI5cHhTbVljckp4RFcyQi9KajIwOGY1ZXNXOGRyMjlzU0tL?=
 =?utf-8?B?YTFreUgzRkh2UjZIMytoK1JFMTdxVmtveDdZRXVFQXovVzFkZ3Q5N05ZM05Z?=
 =?utf-8?B?S2ZhNXBCbTNiTFlXNjVGQTkzbVMxM1hMNEUrUS9FMGF1RHhKRUU0Z2pmV2Rj?=
 =?utf-8?B?Zm5jWU9OVEpCRGdCRlpPUzVKenJXN24rVHFJOXZYS25PZWRuT2xYRkEzU05z?=
 =?utf-8?B?dzhhYndpc3o4a2ZHblRTNzF0bVN0Z3FiTXBxRUNIRjlCbTduT2F2VEt2VDQw?=
 =?utf-8?B?WlFkODBtWjRwbWZUVXM3SEVEOFUyZGo0VTBucmFVckdxWitNTVFhT0dHMjNn?=
 =?utf-8?B?MGdiZTNRVjh3endGWkNnSHlMVXRCakJIcHNoeENBT0tyYWIwTGNmM2VrbDFQ?=
 =?utf-8?B?cEViZFNtR0J0SmpWL0tzVWdZdDRsejYxNmZjRTc1SlZXSVE5NytPcTFIUzBt?=
 =?utf-8?B?eTdOWm8zRWJtMEVqU01xY1NrQTBnemJkQVovenJoSGtTaUx1cjNLaFlkWDkx?=
 =?utf-8?B?ZFZtQ2Uzem1rYkpDbFk5SkwxRkJWRXJFVktMeWxqOE5HbDh5ekg5UU02M1hj?=
 =?utf-8?B?L043VmhFSUMrZmh5VFk3YnBwZXRuUHoxaC9WQUZEbGhPMTgyQ3V6eTBBUHlH?=
 =?utf-8?B?UXdCV3R6MVJaQ21hZ0dncjBwT05YT3BqQXdYSnc2aXpaeXVDeVRyeWxUVU9G?=
 =?utf-8?B?a0c3Y0poM3ZqSkZFeSs2NTdMQlc1RDkwazR1VzNiYVk2Q1hLaUswOEZkM1Ay?=
 =?utf-8?B?aURvVUs4ZzBaVWRDR0pIY1BCTFdxa2xDd3phZ2k1czF3Um1WTHVLUStQc2dB?=
 =?utf-8?B?QVcrZTl0bDNaakN5SG52Y2o1VTRKaUhLZG5DUmVxM0JrbnlQL1hEamcxK1Fo?=
 =?utf-8?B?b3VFZjdRSGZ3K0pUZEFPUE5PdE8zQVpFOWRJWVB6aDZsZE9pY3pzT3lZT3k4?=
 =?utf-8?B?bmIzT2JrZVgvb05KbUVWTXplVzNiNklZNm1ybk9oT1A1SVhRSmc1ZmJNVzJw?=
 =?utf-8?B?VGZZWmg0MHNBUzJ4cnhrK2dNakNnblphbDM4UklFc1VRQXVQMVJFK3BiNDlJ?=
 =?utf-8?B?SzliOEhkU2RwZGtFWHVTZ3hDSk80VlRzWlFXNlZaT2tYNTdTSzYvWFVMQk5r?=
 =?utf-8?B?cTlIcjN1amI5N3BOR3dqQmcybTZWTHZ5OHo2L1ZCT05Pa3I1MGJLTGlkYTEx?=
 =?utf-8?B?TExpNGJ4UnRVSXJ6anNqS1pPTU93SENQbFl4SjRMT1BjUjA1YjUva3FJKzFx?=
 =?utf-8?Q?xI7o+EQ8C4QtPdk9fTo/WWWxWk+kKnR93pZuw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oVPfdmlZOvLaCiab0HCyXAvL+z/ANTGoYaPupPZ2eT7wMQho8YWMuzjPhs1TPXvWAUTengAaTsKRa77W3tluNn+wRwIVsZw4cq91m7JyuJ4OihbIKIRwAPgOAqjf+jDwpw2eU4DKcAXolhpnNu+dDYOFfzyerZjGfckg21QBqaOgEn4rNmdKOt9hRyeDF8MCWqUdLZrwshhdCRzWh/TmuOKanXobUjlXJb/6kNafyYoxb7nUEj+mvbQXN/khMQZj9hMCQNVPWU3VFirxToLNQI/rbR7WhMVW4gNyhD2v/G7UyyOY6GMQSkDRwTENGYCclqHbd4xMvCXZRFtzhpjPsmVg1nAlCn2dAE3iYILkCMkr0NnPYQx2zVCbWJNQLcpFweg32lpy03diTIRAU5IWM2NRT6sno5sdn/Bf5u0M5hSa8IqqzJpu3wS5Ae6fcaPi18S82UvO3UlerezjkCzeJ1FTxKmj8ixZbQkuSGPe9fnwStP2cPprC/ldhEM3VQCHGcVH70CWcWWT7c7gFXDYBMHPkHcAmmw/O8zCmxfrUkf6U6mkd6LGU76miOVYaHCXRJ98z8XZmwCXpqBpAvHVVD18BvpCYFT7LzR8wNfEgFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616d98ad-5aca-4d4f-692b-08de79042d19
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:06:37.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy6gk8Ra2gF8s/ordOsmQyIEena1wpNb4uPMRHwm/LI2Fk7ZYw1qdB3jgy5Vci5groRh0iRNP1WM/Xo0Apq74PfNe6B99UaraCtoWiMP16P09bFpYfoXlgtk4R4axTF0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030067
X-Proofpoint-GUID: 4kPPQ9U62Ppj_80MrCRtGoJ_-rjNUhlW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA2NiBTYWx0ZWRfXyKFKJ/eNUrOD
 JEvqVDrowWRr/1gOktv4wQCePP5OuE7qia9JdKRQbUxvlEMZ1cM5GZfzqYrFjI8O0dfmCfyjdqx
 DRZ10bXPZ/LMKzK79OnyFXQNrAOjuNxfl5IJYX2CzSpftTM+64hEotBMec0ZLBOnF1+T+eCyGpY
 r/M0HJfbqFr/7ytZNSAah4NW19gDeYj6g4aV1UNS3uPpbWMxhEn9ZApUG53bG16kipVOTVKH/44
 xZlkySt34INY4Xeg6/AWud4khr7aldCHGKsrbLftJGOYOgQcCo53T6BhpDg8KwRhg1qLt87k8mN
 HZhkfYFl27xJ30b9zOWi+wmxvsOBmP/qhgLViDCRSQKwqfj2WyQE7phCdDW3SBy13z9cjWE3ynM
 VG1PPpEkgglwhT82Tp27GEAZySuaAPX3oTMwqKx+5QkdlFVa7eOH/rCTTV6bKKJ0rTL/fSKIn4E
 rHvvmZ0s+kL3E9uoSye1lr2zL7Pb4ABf0hPA8Os4=
X-Proofpoint-ORIG-GUID: 4kPPQ9U62Ppj_80MrCRtGoJ_-rjNUhlW
X-Authority-Analysis: v=2.4 cv=YsUChoYX c=1 sm=1 tr=0 ts=69a6a4a3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=tHa68p0SAAAA:8
 a=yPCof4ZbAAAA:8 a=WUGMxM0ijw6P3CnyK2cA:9 a=QEXdDO2ut3YA:10
 a=ufIsyHvWW7FwcMbVRpPq:22 cc=ntf awl=host:12262

Hi Gregory,

On 03/03/26 01:34, Gregory Price wrote:
> Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
> cxl_pmem.ko") moved devm_cxl_add_nvdimm_bridge() from cxl_core into
> cxl_pmem, creating a symbol dependency from cxl_acpi to cxl_pmem.
> 
> When CXL_ACPI=y and CXL_PMEM=m, the built-in cxl_acpi attempts to
> link against a non-built-in cxl_pmem, which the linker cannot resolve.
> 
> CXL_PMEM depends on LIBNVDIMM, so LIBNVDIMM=m constrains CXL_PMEM to
> at most =m.
> 
> Change IS_ENABLED() to IS_REACHABLE(), which returns false when a
> built-in caller references a modular target, preventing the link error.
> 
> The result is if the pmem/nvdimm symbols are not reachable at build
> time, then at runtime it will always return -ENODEV.
> 
> Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
> Signed-off-by: Gregory Price <gourry@gourry.net>

We have run into the same issue as we have CXL_PMEM=m and CXL_ACPI=y, 
and this fix looks good to me.

Reviewed-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

also, gave this patch a go with our config:

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>



Thanks,
Harshit

> ---
>   drivers/cxl/acpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..7065413eda9f 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -952,7 +952,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>   	if (rc < 0)
>   		return rc;
>   
> -	if (IS_ENABLED(CONFIG_CXL_PMEM))
> +	if (IS_REACHABLE(CONFIG_CXL_PMEM))
>   		rc = device_for_each_child(&root_port->dev, root_port,
>   					   add_root_nvdimm_bridge);
>   	if (rc < 0)

