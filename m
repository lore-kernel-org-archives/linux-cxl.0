Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071BA35942
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731876; cv=fail; b=QCPLFQX2nEUvAoiFydz5+Ixcj/DybvDCmUezR5lxFz1URdt+kHrntqTtibnaNs1rFmQYYNF+JXgfhaRDtj8EKWyQ0KjIumVITJsDqz4V2HVIIDRU37lsseI0NmmzurZz2hiGJBq+AXnrISfQCaW9cOOEcZU453lIbcDbHpuebcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731876; c=relaxed/simple;
	bh=TfvG9P+a3qX6se4QZXEWYmZZ3FH1gVwdTkhWICyhuAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qC7Sy+PQiS7Dpsht3Lhl5+AzIIwLDv1WNElx2eqrzhPa08Gm0161YQnrkpPqmjluAz4WKDwKBFN6lL7GbM5kd0O0HylIn/cAtWKpNKcRiGzIGCQ0akHya5GYFfGwFH3ja/g+qraiyjYubhFssYnnn+SZIyVDHp1ciWV+8qk4dME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sHTR+XqI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cBGqSF85; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sHTR+XqI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cBGqSF85"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NLgftb000477;
	Tue, 24 Jun 2025 02:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zUCcArbfOqvpXpiDNRWAxeN42VWtHpBQeDOWMTRop2c=; b=
	sHTR+XqI0JivxORhkw9RPmjk0nUiuhKGvkzu8Rr1R73XFO7MzXUAToaGRsMAyVHh
	C6Hc5kuurqhr5B//tm3/GBS+LoeEiLB50KHs1Okf6FvGgRabCF3QxLixzAQD3YYC
	K4OhhBIA+eMfjpKcV5XgvkSDnzDUWxSX8uvLgm9c13Ew1LEiBy0Z9s7USq4rPYFF
	mN9o/tnR2S4KMUzEr8/FAf4vdLw4KjwpN+kmywSnsBLfUSGC25WNESeG6XECNLeA
	qjAmampaMAhiTDVcGvs7TRsJYoa4ZNC2DtufR1bbdbaoWHhiy8YrI00Enk1uBqXo
	su40acD97nKtfGlOl1488A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1ayts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 02:24:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55O2L0KA024401;
	Tue, 24 Jun 2025 02:24:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkq2j8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 02:24:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFxVW58So3ZA3DRXu2xXwKET9a70vUatK0cQv49oewJxw1mQ77xt6qR5ZONC15iiTvP9VeP5TX742pxFyM2/9XqLFm2dycE/lNdGhTmrOkBbx5wP8oDgZCAHylCjmFDnNmLptbhhy6jPIL0eO7UV/CnloqNa5H1f+UwgtD6VhturXGyQsDmOj2apsraMgSAGMDUPEpF90ldYW4ejiY/YEh3MXqddfX0RzJfqot3X2ZzDtPGLLVjCM3ylzw0sDyl2pmcBLOOR5PBcCKHaOBXHhuaueHJU+wPMjd/IdPPK3LLlNsbBRg6SU17MgTkJwQ/pRDWQZZkpBDewi2A9MisdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUCcArbfOqvpXpiDNRWAxeN42VWtHpBQeDOWMTRop2c=;
 b=tf/eB4ns4E01FfBKgfWcSa69BfEDgzoNUyXQfhN4J0t33s3/mzY7Jflfo5g3VXqVZohYUdFFJCn15I4kETvuZqy3BrS32L2+UvJZ34QBWjFfQNycKwkKilXQmU2h8NYu91i1Ja/u/d1UbDwRnnm17rzKvvAu/rHG0YyGPowu3WATA0V+ELW3b84oRu1ysDNdUfq3/vMVJ2dhY5dFqpUrUN+xCFIBhrkC3KCNWiisnh/1XJvsyVDUpQ0p8samiz1LNnXGTKXoH6jHxDZBHX1D6dqNwTqVboln1ishYM5ByAdWmWxoRK6cW9KViwKsxo/SpKx3q/pEAhzPVLwonzC5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUCcArbfOqvpXpiDNRWAxeN42VWtHpBQeDOWMTRop2c=;
 b=cBGqSF85vTll1N9KFoo3LZowqBzDyo+fU2346REtmO2dEqjUFvxZvbGNTtOcy8QTfG+zmCyJO8//H5bTGpxuc/qBKiYZ78VKiOavAdIxHv92PIWsaZjCc8i/xVH3WwUteYHp7vTj+c6rVnn93RHgbN+2wGvdVi04kHclDSpIIiQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA1PR10MB7213.namprd10.prod.outlook.com (2603:10b6:208:3f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 02:24:20 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 02:24:19 +0000
Message-ID: <9f31e00f-68e6-43a7-bf7b-e5077ecae268@oracle.com>
Date: Tue, 24 Jun 2025 07:54:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH] cxl/edac: Use correct format specifier
 for u32 val
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
        dave.jiang@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com
References: <20250622183919.4156343-1-alok.a.tiwari@oracle.com>
 <aFoBf6rD_svc51Fz@aschofie-mobl2.lan>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <aFoBf6rD_svc51Fz@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0260.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA1PR10MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb9727c-b6b7-41e7-0e63-08ddb2c639a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTUxUjhaMzBGTnE5NmloZkJETjBCeHBVdHVjcE51TTVIUWt0Q2ZmaVgxVFYv?=
 =?utf-8?B?UE5rWGNzM29SWEgvRW9CMzMvV3MzZHpocU5LNzJ2YnE2c3ZVM01aK1Nzb1pX?=
 =?utf-8?B?NWdXZklkRUx6WXMvaUlTY2s4TlloTk5tSkVYYjNzRjBiVlk5WTA1cUZZaDYy?=
 =?utf-8?B?cEs4ZWlwek0zanZEM2o0RnJETm9FTjJwVThPMlU4a0tnSVFuemxGTmdod2x2?=
 =?utf-8?B?cFlLTzFCYW5VTlZXTlFoamtwQjRlWlk1ckVLb1owWHhGUlM5aE5VUmFnaHB5?=
 =?utf-8?B?OUFQRHdnc2JkK1FqTFJydlBmRDlSbmpoeTlkOUJjRE5hQjc3QVRvN1prcG1H?=
 =?utf-8?B?ZlBVTW5IK3ljVEpacml0ZnkvWGtoZDlXaURCdHM1RElSQUtFQTQ1THgrRk9E?=
 =?utf-8?B?WlZUNUZPOGRGZlI1dlRydGN1Nko5aFNsVUtnTUNHbzlWQUZpRzE3UnlDU2lU?=
 =?utf-8?B?Ym4zTitRQ3lteUQzRUNGK3B2eDFWRktvcHJkUTd4bzFWaDJBOHZkVnZUbEo2?=
 =?utf-8?B?MENYQzJOaHBDWHg5SVJ1S09ySTkyRjRTS2ZSUmJCb09NUXZ0b2REMG45S25s?=
 =?utf-8?B?dEVRKzY1U0lOZ1JoVEFYa3hEbnFHcEduL2wvZEo5WW9IcU9Xd05ka2UrVjVB?=
 =?utf-8?B?ZHU0d1dIMkNFdUZsTUd4cTBCU1UwT0syV1UyMm5NTkJlT1lPMjhzaXFSMGNn?=
 =?utf-8?B?aWtYNktaR1BVY2xZemhjdE1jTnNMeWc0d1pheDl1aldKQmJPd0cycEF4d3E2?=
 =?utf-8?B?UENSazYwZWZhYkNOVXptNmxRUTdaZXVnWlFWU1dEMER1NnBmL3dVR0grZFJ3?=
 =?utf-8?B?dmtHRDdLdVZWejNCcDlQZkN1VDQ4dXVhRDRYT2RObmJlMFU5clFiOWRoRndN?=
 =?utf-8?B?eVFnaGd5NUFyMDF6eTM3NTlRR2c4SC9RTVhhNTlrdHhaSzdyVGdxRHQwTmhT?=
 =?utf-8?B?Uy9HK1lLQTVTSWpTdWVCci9WejhiTWRZTTBTcnBRdnFNbWU3b2xLWmlXQzY3?=
 =?utf-8?B?ZHkzNEVVMlJQRUcvVVdpR0lsc3BFY0pUOUJLeDRZZTN3Wmo3elVyaXRhMWZm?=
 =?utf-8?B?eWxmbHpWN2txUCtNc1dSellyYjhlMWZtZStjdzVoODY2Nm5od0I2QmpMUm1B?=
 =?utf-8?B?cHdkNUFuNUM1M2xwQzlCRnNnVnFkMjJrVzVZOG9pZlQ1WU1xdVZRaXV6ZzVh?=
 =?utf-8?B?c3BoOStDcEozRXVCWVMrVkg4OTRqYnRkcUhFcERmdEtFZitsdmIvRDVoT1BI?=
 =?utf-8?B?TWljVU1WcWNqdTFjQm1URS9mMTNwQkxFakRvK3J5TUgvaDkzWXA4NkNWcFJZ?=
 =?utf-8?B?N0hpZHdRQUFpaTRjNEkxYnQ5LzgrVldMVVVLWUk4OC9wRFhENzk1dHF1cEVo?=
 =?utf-8?B?aE1IUXNhU09qSVFreFVUa0Jla0pxUkF2d0dCZ3NZclhVZ29QczVMOWZ1bnN5?=
 =?utf-8?B?cW1PNkRCYkl6TmhmT2VRQWlMWndpRGZHejNnZTJ6ZGJNSXYxSXRDVUkwTzJm?=
 =?utf-8?B?RWxzdXZhMlA1TERyLzN2ZERyZmRhcmdQUTNiRjNRRHBYSGZlSGNvVDlveEpm?=
 =?utf-8?B?RG5DaUJPMXg1RjEyVnlYK0ZvdHg0L0hZb2Q4ZkQ1Z0FkZGZqOXdkM1A2cjR6?=
 =?utf-8?B?cDBGSWtIN2dkSDRURW10Smh6U3A3UVBSdUZYMGI0ZFg0WGtLd0tXWGk2a0RS?=
 =?utf-8?B?aTdBS1dQYjRWWTNkS2VUNjVrYUVWOWhpTjJLQWppWm8zakI5V2FSeW55Rit6?=
 =?utf-8?B?QTJCMmJFWEcxODFKb0V0RVpQSmpJSlZZMlUzdUtxYjFqalkwSXhVQmtmUTht?=
 =?utf-8?B?d1RtZ3B3Y2djY1FaRUhzUjdRMEhoRjBuT21qdE1FSVlhRXVaOXNLV1V5Nitr?=
 =?utf-8?B?Zm82TGs1djBKdHQzWGNwVW02ci9LSDlCR3EzM1V5d3p6QUE3cjAxeFBFdytj?=
 =?utf-8?Q?QI9Wh+bp2oc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU9xZ1k5S1plVmdBdFpOTFpOUDk1RVRhb1JnK2RWU3FPOEVNRWk3M1FkeHpM?=
 =?utf-8?B?Y1BXb1gvbVdWa0RMeE9id0dZVzMxMWhWemhsUmVubEJnL091N3IyWVFsMVg3?=
 =?utf-8?B?QzRuOURISFBxM1loU01zeHE3YkJjV0lDbVNRTXcva2s2QUpheFJtdmM4SVRI?=
 =?utf-8?B?K0NhMUFOVjFKeTVpUXJMYTVlZHhPMlFJVWVhemRuZ3RMU0tUYTlVaXVpakZR?=
 =?utf-8?B?L3ZlT0JwbGxBSWR5WDl1LzQ2Y1lmbGtxYmNGTWRIWElWZGllL1Flem9sQndE?=
 =?utf-8?B?ZzFhSzVZeDlJVGhGNjVQMkZnbE56YUxQQ2FEOVI3KzRWQ2RtcmgyT01MS2RO?=
 =?utf-8?B?b0ExQmlUMmZhU0ZnMEUrL21DejdlMnRqeFBmd2M4VU9va1VucWJJZnR0eSsv?=
 =?utf-8?B?YmtKQUdlS2lVT3p5VWI2TU10ZEEybGhURjFVRG0vTjgvOGs4RjBicWFyNlJy?=
 =?utf-8?B?T3M2U1ZocHVLOXRoSlMvSXNTL2N5MS9RUlJaQTJYRldIS1ZSR281WGpBNlBh?=
 =?utf-8?B?TXVVdFdjRFI0NHhTdEhGK05yQXhDbSszTXBCTS9LMTQrMDFBT3VSeUxGaWk1?=
 =?utf-8?B?RGljNnJZZ24rM01DYkJYTVI3aHpJb3FnaXlhQm9TQnJVYnNVVmx3Q05JdTlX?=
 =?utf-8?B?Ritidm94QkVNUk5HM0Y0LzZCTG9BakpXazRKMlhMdWUwUlZRazJaT3ppSVNv?=
 =?utf-8?B?NHNjYUQzOUoxeExCeS9sRUorN0dHT1p6dUJLSzdSUWFMaEJkaCsweThyRks0?=
 =?utf-8?B?VnFvb2NEK0NaZ0JwSm1uSHpDZEp3ajVCWjBBTVpOUnF2V1JpYkRYbTQ3YjZ1?=
 =?utf-8?B?TUIvZU5TMmRJVkhEYjFSQ0pPYllIOWo0TTF3UTZhTnRzNEtGaFlJM2grMUds?=
 =?utf-8?B?Kzk0UFBqOGpTNlk2OW9WQzBsT0lQVzdyUjZNK2IxUDUrak1MQkFQYXY3VFJB?=
 =?utf-8?B?bm1TMnNaVWJkeVgwWGROUjlsbGxYc1ZWZE1RTW9KNlZzMUJUZXNNSVlnZTBa?=
 =?utf-8?B?VFJjZzZCbnN6Skw1cVlyZUpmTWVlVi9nL1g3SGwwOXU3NGp6UHNyUXJVbDZx?=
 =?utf-8?B?VnloVDgxVW9EeGNqZTd3ZTFkWlF5cklwdkpsZDNHQlBjemt3QUVkL2xnQTNs?=
 =?utf-8?B?WkhDZWpLSTFBU0lJK05PdTA5MGtZMzlGbG9mVy92M2QvMDVDRnFpdXlVVUVW?=
 =?utf-8?B?bTJRdzhMSTE0cjNlMzlya3NSUEdvSEU0T3FycUUwemZ1ZVZzb0xVUWROdjBm?=
 =?utf-8?B?c1BuSlJsdGhMYnhKZ0JrM1J0alpaTVN1MDl1OWx2b084RUQwM05TZkd3TGNl?=
 =?utf-8?B?QUx1K3NOV3pMZDgvSFZ0WXlxRlc2ZVo5VWIzVG1RVXVTTHp5MEZtM05lVWRR?=
 =?utf-8?B?bWF0azBGNjhNanhpSldqV0h1VE5RQjNJdk5UeVRldVNRWUt2NzVFUFNDRnBj?=
 =?utf-8?B?RVNWL3BZV2VPSW5FOWw3YnJtRWVHQThscFZmM0xoblJlNi8yYUttY1huakZJ?=
 =?utf-8?B?ek16NmYveEhoY1FpNVFnTENnTGhpZ3FlRmVLakQ5NjNoVndtemhHaFE2eUFZ?=
 =?utf-8?B?M2x4c3pialZ1cEJGTGY4U1BXeUVScHF5c240bUcyWFc1QnhRK3hZNU8zTFZk?=
 =?utf-8?B?Mmt6U0NWUnl1Y1lTWnZwZjBBQW0vaDM5WWxiQ2h5T3JJc3FJQWpPN3MzWUVo?=
 =?utf-8?B?Ukx2MEtGOW5Gc3ZMbmxzWUJzUnczM2w5UFRtS0tCS09nZnRzSW91RHFkclND?=
 =?utf-8?B?STZRWjNyVEt0Y2xMMUVxVDZMeDBIY291bHZtZjlJZEhyQ0hhemtwZ1JzV09t?=
 =?utf-8?B?cTNTRXBTUWY2WDNSWXVraXRPVmZIbloyZ2tuYlVwRFJmTFI2eVY3Z2EvQkpQ?=
 =?utf-8?B?bWRmZGNCcEx0SWNYME5iQ29TaHNZby83ZDhMZlhlZmdYVWhOcExoem1LL2cw?=
 =?utf-8?B?NCtuWEtpazBqT2tlQWRrR3B4VEpBNCtnem5kRWp2T1JSbTIyZ09oMEdHZUoy?=
 =?utf-8?B?NGN3cmdnNk1xN3lDV0Y4dmNVMjJxZHZZaUI3YWlkWTUzeVpYVWNJandidjE0?=
 =?utf-8?B?MmlNbHlTTnB3c0RLL0dOMUNaL3N5WGJndVRkbDJxUytvNjJCSS9iVzl2NjFK?=
 =?utf-8?B?Mm1hQ2tNVVVkODBHTHl5YisyVVhMRmdoajFJV0dwbFRWLzB1KzBLYWpwRkd4?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LUC3/+aX32EQOMMqBr2OQHTM8IVPpUjCB1HgghqOTIlYyLAwQcxyhX6EjlzZ7x0oX9ofsO8g0YRLks8ETGuOYYv1xu8DLvm8nT/d8Vx2IOXTF2idD53SM4gn07FoFJBxvOQ+X37zUH3dMi2O3l659TC1D+oJMylk4uBl26Ry9KnXx1darQvB6oMer7Pk7L6tK15G/Hc0RGLwo8ubo4aHG48aTV2Gc1m7WeOpjPP9ndaKfk26um7bep9W8OXxt8fiEj+3BYKifQjKJ2+Fdd3cCoMpux1btYpfqWeAbQAy7Zp8pbuLjdq8XEbdRvAW08jTjqIjYW81pdOFCVVu0vFejyPqxjnC1xe7gyPrMJyHIihEhdHv26GzJ+kwy03m4/K8hJ+TYFy7PqntpVL2MBpzzpabqkveItRBBNXPvLIRUVTScmVLwoGihr1sBf6wMIi69TiWiLzCa2CuRCRnPW/zPrngEN78607/YoHJcMLOjxFcyvoCR+HXpXFfKA0tlnQrGQf3vHAntHYYdC4jRk+XD5SS77TuHMt8GaltWHum9gnJ4zNowFNkM/ttbu8l8tcgWl8Ady9f3M0pGS4TOrwUjO2tu85ptFyxqthUqfo/RRE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb9727c-b6b7-41e7-0e63-08ddb2c639a5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 02:24:19.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FgwA7dfsCZitKD75crgwUrSzEyBLvdSk/UH/EuiCTvEnHppqcSO/nlhmKAIlzx4IGNMWMdaoMMpsVWmdmcJ0ck4pnToWFP8efMrc5/YaAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240019
X-Proofpoint-GUID: 3XEiHP19tOHCD6HtzC1ZCEGXVY-EsdkC
X-Proofpoint-ORIG-GUID: 3XEiHP19tOHCD6HtzC1ZCEGXVY-EsdkC
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685a0c57 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=7em8pr5sdDmwPin4ovkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDAxOCBTYWx0ZWRfX9QdAbRipBh6N YYO6UUxEbo5E4yGNtcnWUIa9jnTIRbZZLCnJPBaBjH0u5rY2nb3B31vLln5hTwgBLquEbwXeH7k T14N5rIo9ZIjQVor3x4h55fUiYhM9CkOXqgWWEhmCOUt30o83E32gr3WS+fLkWhB6W7z7Pm/S1E
 Z1lpCc+dejoiBDLnb34mcE8jiy7w4BcFaXdJNvSaourukYNwYTChvZL4n18w3NrNrA5kLuFRdKC j/JruGDp2q/V8gv8J/G5zCDxXzzq+M27hTDNYc5WWKsEWh0ugYcbWZCH9HYcSvAInMJbw4j/rDI bXn+cHI0jZGqJgAtXtwiJT13VsOy7IHrXfalZV8XigL9hDFGb4V/d6OIHpTItQHVWZXlvUhUMrS
 F8LOrH9PizHlgoMbB+rQlVjJfW42/vsoPo9r9kWc88xs1VSBhCKAJGEAYQFXBa0XsEg/HyeL



On 6/24/2025 7:08 AM, Alison Schofield wrote:
> On Sun, Jun 22, 2025 at 11:39:16AM -0700, Alok Tiwari wrote:
>> The dev_dbg() message in cxl_set_ecs_threshold() used %d for
>> an unsigned value, which could lead to incorrect logging.
>> Update the format specifier to %u to match variable type.
> Reviewed-by: Alison Schofield <alison.schofield@intel.com?
> 
> Alok, Not asking to rev this patch, but for future patches,
> the text can be more specific.
> 
> 'Use correct format specifier for u32 val' can be precise
> like 'Replace %d printk specifier with %u for a u32 value'
> 
> Then in the commit log, a bit of detail makes it interesting
> and shows how it matters. Using %d for the u32 value will
> display negative numbers when the u32 value is greater than
> INT_MAX.
> 
> Adding that detail also saves your reviewers time, because
> then folks like me don't go looking up what will happen in
> this case. The commit log explains it all.
> 
> Thanks,

Thanks, noted — will make commit messages more specific and include 
context in future patches.

Thanks,
Alok
