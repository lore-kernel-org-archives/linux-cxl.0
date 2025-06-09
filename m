Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D910E3;
	Mon,  9 Jun 2025 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749473967; cv=fail; b=XNl0KhOKcHHS5fMgniS8ysAzf6e73y31ccH4Pa/iQpvtqW37ZpvCi/kpM0vzxGXLqqpW4ZxR51JaaFplKgPySYTKZ4l+FwqsHvHsCk7TDDVCqdxfMwAgb+s+yZo1jzTC/Lq0jvqDZzmthl2VVWjZhiOb1c5cYAZqpnnmd6Y7eRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749473967; c=relaxed/simple;
	bh=QuWCgcsOzb7rzU6mZbTLDmeeOs7o+Yo4NhnjqpQwugI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=anqgfKogO17nQm4u36sUNICfNtsEDv1dyaQFSJhSqbGeE8oEYoZUKUYGkqGm2cGsQQLgjrdy1bdfUZgHSCgkontr4ukK31GTkZCXxr3eRHzGt7wesR7hvpz+lYZJSxgpcsNnKpIIQarAneOsX0AKGD0XngP6RVvydZwGnlqKuiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TUF5sb4m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U/MKyE3v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TUF5sb4m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U/MKyE3v"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5593guhW005112;
	Mon, 9 Jun 2025 12:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AHvW1TJ+brjZJ+0LLJ2vlfcDRBwbW30+PrPHIuWSRgk=; b=
	TUF5sb4mKJmdwXEdQWvxkuQGg51I5PWF2VROh5WxHfW6/Q+d8bqAJ01RiVYbEjql
	a5Gu4HNgfZ9JWNwRi369PW0E94Yq7GfIrae0ZnnyCRvRtstj4+IwtV6hqaSE2eM5
	xKbUSxCkWBYjgEbR4ZnFqyLtCSBhPlC1sFRHd1t51JAteXT8/a3rOJ9DDhYU4KOl
	xQIWH0AgwWdLKAisBVSfT/X7AaH7FzRTYzt2v9aUfzkqxOeumAltBCV3aUq6qaAu
	xrF1xBC2Vu+4C3g4bmRr8wpNeJ5dtVbmCGnPYACiOnWnq2E7Qawrzry7bE/3DNbs
	PLdcH+/1+jquiAkdCY1EdA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywt1rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 12:59:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559Bik6Z003338;
	Mon, 9 Jun 2025 12:59:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7dfqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 12:59:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKf4GGOmD3mAwLQmwhxSwjuQ9mTE+rOGDjt5P+VwZ2WDqx+yQU+ZXsn2bnkfqsAzha8HQVBZH4quF1iSzOi6S6V4e2ZFijOiI5d6daUZrR9vvsBBLXFhH7XhjQ1XbRlGjfB2gOpruJK74SFxt1fSkRWouHMxTfFQdYBDCOkzkrg6RPTKmljm4RIlQN7YnDb00+TgEhc9BTZKdf/Nx9ch7/e8uEJivWIfQ8x/ZJOg5s3gzGJcnd9O6/ujcG+eHXROnWj9F7avw6jcBzdo+e8Ag4KlQ5/EokuKxs65lxdCqpy9SvSx/6lbrWLyTvbyrSvJwnvSriNWtaUfqS8YdaDDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHvW1TJ+brjZJ+0LLJ2vlfcDRBwbW30+PrPHIuWSRgk=;
 b=kvEoX2BcZK40Y24KufVpXEPXKEqC2ppLtqbCY1EBbJm4DQbgFZye4td1ZrUF9+c0wsOb+lHP3ieh/Pu2jndwoHnpVje64vF/v9Kw7BI45QVnZDVsh9iiMyLL0feVhbOgUnlP6S8lnrzxBltt8nukqvN8doOB9jmBx0J6T5GSM1HlOkE0/aA4nS5PGEcwZycDATQ0/VPk5ezE/aJRLUUFmtn8Fof7cWAv1XjNkShxgHfpMnKasPxr7Nmq3vGllHfbKbPSHQuMPiODRIch9AloKzx4qNFadZ+hBHoKFJgC2AU/Wo5oKarY83LsxdCx9AjLNEP8xqM6SDPjX76vS3unrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHvW1TJ+brjZJ+0LLJ2vlfcDRBwbW30+PrPHIuWSRgk=;
 b=U/MKyE3vYDFw7sUdL5rNOiaKuvOCIx+eP3gExfdOOatoPdYdMDcFIzeAvDVtAwSkTXeWNJ6lymSLmjoM0q7eq/i9lVJADoa9LPhcYrDlvdRHTFOCC8a8l9/7098nHwn1QPi8E0iawBPNdTXe03h+/rajTGQAXZkcic9etSdV24Q=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS4PPF18D5A7206.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Mon, 9 Jun
 2025 12:59:08 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 12:59:08 +0000
Message-ID: <ee045330-c389-4661-b11e-c17d3e01f156@oracle.com>
Date: Mon, 9 Jun 2025 18:29:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: cxl: fix typos and improve clarity in
 memory-devices.rst
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, corbet@lwn.net, linux-cxl@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
References: <20250531075209.3334261-1-alok.a.tiwari@oracle.com>
 <20250609115817.00003017@huawei.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250609115817.00003017@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OSTP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:224::18) To BLAPR10MB5315.namprd10.prod.outlook.com
 (2603:10b6:208:324::8)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS4PPF18D5A7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b33770f-59d7-4b04-4b4d-08dda7556b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0xXdGVjQzZVclgyOHQwSkR5NFNzSUFMN09Cd25QOW96VTJkd3lqMXdnaFNO?=
 =?utf-8?B?L1JQbGdBQXgxYllOalA5L2c2OFZKTUROMEZwK3pzOGwweXVabHdCcHh5eWpG?=
 =?utf-8?B?ZmszRFllOStLbU52eDYzVTZzN0UyL3JzbXpTRHlqcWRJZ2xjb01oTCtVQnVN?=
 =?utf-8?B?dGJtS1M0R0xuSk94Z0hxTVJtZGJrMlNsRjlwb0pKUms4M3dmMlNrdGY5cFEw?=
 =?utf-8?B?blBPMmZOS3hCNjYzTFFpODRNcXpHVXlneVZyeExka1g5cU1QRTkySE9Va1hM?=
 =?utf-8?B?V3NTWlUvenpJNDY2cXZTSmJTM1pTalNaTThZalJqL3VtbjJJN3Fzc2s2NmZy?=
 =?utf-8?B?YXRhRUhOVHJIbTBKbjRTTXg1aTBrSnhhL0JCeUEvWWhWY2xlZXNvaXdjV1Vn?=
 =?utf-8?B?RjluNWtjVmR3YXg3eW0zY0hkcTF5U0ZaR1dkdTNJKzFwOFM3T3p1aHpUcVJN?=
 =?utf-8?B?YWYrdXBvQThOQUNZODA2V3JVZVdNS1puTmwydXZEWnAwbFFXa1dWQWNUakkw?=
 =?utf-8?B?SS81Z25zUVZCMWplWWJzZTMrWkNaRnhqWUloWmhhS3I3cDhZQ3VaTGpZTVk4?=
 =?utf-8?B?SFdKVkVuRCtKTXY0WHVlcjgzWlJ6ZG4wNVloY0NOSHhjVnA5NjFqWEt3MXQz?=
 =?utf-8?B?U3hOSFFZakc0WU02bWViREkzdFoxakR4VEloTDJCNllKdlY0bmI1NEJFemJK?=
 =?utf-8?B?d3VwOE5EaDVoOHFtRk9wRm9MOXh1YzFaYVJMS1RBamIwYWcvTHd5YnhyaWZl?=
 =?utf-8?B?bWpyMnpkOUEzeHFZUU44THhlMlYyWFl1V1RTckNNd3gzQXNIQk1XdFY0Rk9w?=
 =?utf-8?B?b0syTEs1NS9RSWNTbHRQTjlGZFA1RTJyWjNIL2ZwZlVnYnlYWkJlZCtONFhI?=
 =?utf-8?B?VEgyT01DNVdYTzlLeXJFQUQvTlVmZXZEbjZ4L2RDWHM1VFVRLzZIc0VJNXRX?=
 =?utf-8?B?dzNMMmlBRFlOSVhFWXMzblNOQVdOdU5TVEFjQjNxcnozV3VtUUZQZXVNcXF3?=
 =?utf-8?B?bDdSZHBUcmgzRm81UWxsbi9QS0Q1NElXZG1RMC9iU2RJdlVSM09Hb0tWR1FT?=
 =?utf-8?B?NGVsbXI1VEdhNjk5RnpRMFJVQkdKeXlQYlJvWkdVTE8vWEQ1R3VuMjVTWDFs?=
 =?utf-8?B?RVA1eWRIUXgySjJsN05KQ252c0dxSEdjTUh0WG9IZjFSMHVwRU1meHk3bkFN?=
 =?utf-8?B?R0FUeGxuOFlGQjhTOWJHbEhxYmpwSU1uUHJGZGc0VW1SeW01MkxxanppR1RH?=
 =?utf-8?B?YW0zK0JWd0QxUlZTTDg2WVQ3NldIR2x5OEtmSmkwWGNQYlYydTA5UWNFUHRm?=
 =?utf-8?B?bUI4WXdNaG1xWTVVMVN4NVRWbU5KbFMvVDNrVlUwZ2lXVHl1c1FyQS83V0wv?=
 =?utf-8?B?dW4yek5pZGxjT1orZloyWlNka0dadDA2Sm4vSFRJa203WCs3eVVlc2lDQnZr?=
 =?utf-8?B?c1NUeXB5em4wMmZ0VWI1dmlCY3dqaUV5OVFpN3VCNE5ibXFzbWVmT0FvRUZa?=
 =?utf-8?B?ZXFWdXV6N0hWMGF2TXBkRlhxa04rWXEwNE52UDZheTVDa2ZTSVJxNFAwK3pY?=
 =?utf-8?B?R0tJYUk3TEZjVTBoQjZSSVpYWFBJN09uUkRSMkxTK2ordXVSVzl5TkcvMXVQ?=
 =?utf-8?B?UFVxUWpTbjE0eHlNWmNVTHJSRG1vc3dYUXhlYmI1eU5nd2VIUFhjWGJhcXFo?=
 =?utf-8?B?cnA5Q2J6MGFzeW4yMlE5SWIza1RGWkRkS1QvTlZJa0dWQ1AwTlNsT1Zjb2dy?=
 =?utf-8?B?M2MyV2hsM3JGVG1OcWFVNWtROW9CcXFUbXBJeEQ3YXYyQTlpbkN2RmZiSStJ?=
 =?utf-8?B?SGo3dXFXWlJuZWtwK0JkYjNIZ1djRnJac0tTZ2hzcHc1UWZVd0xPUmJtM3Ir?=
 =?utf-8?B?dnJRNFRxNHZsVE54UjljZGxuYTNRR0FsVEc4U3dmVS9kWXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MElPcGRCNnBRaWVtK1Ira21vYy84U2JtajA3Z0Z2THpuWkdqQzFlcWczZG9r?=
 =?utf-8?B?dVVxejBaRE9XRXpBWUpVZWYwTy9WMlJ4MkNIeEdNSXVVaGdEMTJSa2JWOW9h?=
 =?utf-8?B?L2ppTDFhTVNCY1RRQ1FGaThJN3E3RHFxZG1UZThBbFdheHdXazkzNUN2bUJi?=
 =?utf-8?B?SlZXNXpVUTJ0Q0dqWURuaVMzYWVvZVRQTS9UdWVhSnpRMmRNbW03dTQ2NUFV?=
 =?utf-8?B?UG9YQlZneTU2bTFsTzdvMklkb3phUEJScFFqWWtiU2lLaVFndGRJUUtidXVJ?=
 =?utf-8?B?dUY3TE1PeCs5ZEI0elBvM1BQbHFDQ2pRUVJ6MDFqUm1JYkNGTWhSaGw3NlJk?=
 =?utf-8?B?RGk1Vi9talA3eDdhUDdqUHYxK1ljeXVJM0JUcWZtL3dIK1MyZzlWejJkN3g4?=
 =?utf-8?B?VGtHV3hWZ2cvZVlvSTFpUmpoN2pHLzBYYit6dzg2bnhoK0lGVXJpY2V1UHB3?=
 =?utf-8?B?MWRwMGRTRkRMb3FQaHNja1QwbjA5N0ptTzBJUFM3bC9yckMrVGxwMnIyZEtx?=
 =?utf-8?B?Tkt2eVRkc0J0RkZsVEJHMzV3MXFXUGRzTnAzaHBobGVUYlRIWW1WampmT2x3?=
 =?utf-8?B?dGlkbXZWeUEzMUIvUW55cUE1em4zM1J4VGZmS0xTZ0IwY3lLejNBUE9KTy8r?=
 =?utf-8?B?RU1iamw1YnRqUXRFdndndXVDVndRNlRQZ0t1ZjFKN3ZobW1MUExZbjJ2RVlv?=
 =?utf-8?B?MWxIZkhBN0wzSWJVMnU3S2t3ZlBlbXI2aWNLMmJjY3hzajNEWDlRUGFaeWQ5?=
 =?utf-8?B?ZmJuTHZhRVpFaTFYaVp6aG1SRW9BZG82WjRZWHpIS0FDYkphVm4xYnZJR2RN?=
 =?utf-8?B?aHhDVnNubU5DT3Q3VldWaXNMMUJjNkg5SDNEUVlTaGJicWZBQzF0RlBlVDUr?=
 =?utf-8?B?T3hZQnk4V0tjbWN0Ukc5OW13SjkycmlnNm9PTzIxNk5jcXRFNEtDMVVmSEZJ?=
 =?utf-8?B?U2llL3pqN2RqN3c4ZDdHcXk3T3Z4dkR3SlVqSXZXa3NnR1JNOWgyUzcrQi91?=
 =?utf-8?B?Mm5ML2E5NE9FUmx5QTk5bGpmMzRLY3pPSEd4alg0ZDlmVG1YK0c4YWEyWG5p?=
 =?utf-8?B?M0wrbTlHZjdhNlhUNXB3MlBQSFFSNGZVK2dTTG9IOWoydEFEVDU3Mm90bmI0?=
 =?utf-8?B?V0Q2N0VYZGdoV2NLZXgxZmUxdEh6NjVSQjJsRmowTWFjdG9pN2dSQ0hvVTlM?=
 =?utf-8?B?NkFkM3JhaThnaTk2MVFQSVQ0dDR3NHdGZHBhdFMyazFXWE50K3BYRG0vYUpK?=
 =?utf-8?B?cVl3WHdVODZtbEl6Z09Edi9VV25URDJrOEsvM3hPZmhpSEFUbkJWeVVTMER6?=
 =?utf-8?B?R1lobVVqUFJ1NmtsSUNOSjZlQ2hsTENKZC9PTHUvbWhOK1JWL3ZMbStvbzBt?=
 =?utf-8?B?WGpzZStGVlBmb3o0a1VTU09zYXRnMmQvd0U4KysvclBpQ1pHMitTUlBnOEYx?=
 =?utf-8?B?eVJlQU5oSHdQUzJXaUpNRS90RU1QM3lCaTFOVE5BdE5xWElZeEJVdkpsd3pZ?=
 =?utf-8?B?UzF6N2RKS3owSVBSMXNaUFJBNThhYlBoN09pN09kZ1lzb2l6SDFlRDM3UEtB?=
 =?utf-8?B?d25zUEp4WjhqWkFYN1NoVXRSV09rbE9hNi9PVDE2aFJpSWtySVY0WmJnd3ZP?=
 =?utf-8?B?ZGE0M0o5UHBSdmx3cTNuUzgyK0N5bnAvay9Hb1EzeUlZNTVHVFcrK3Izd3NJ?=
 =?utf-8?B?NE1IeFpGZ0o0WGlTSGdMaWhuZy9IS2VMeWh4VE9JT3lQeUtlTmJZcldnWURn?=
 =?utf-8?B?VlpFdDJzRi9QT3kxa1lWdXhTL0ViNkkzbmtudzI2eDdBVWZjTjF2alVselQz?=
 =?utf-8?B?V1FwczE0d3RuWERFU2JMbHlxVFBBU1dlSk5lZVhBRE1QaHE2UWp5dzI1MXAv?=
 =?utf-8?B?bWx4dzdTRDBRbm1uVktoRCtNSWF0MzI1V25UalQxV3FQczdIajFpOWEyTkNV?=
 =?utf-8?B?dEE1eTYwcmhzMnVOTVZEU2FxRWdvMWo0bU40aXFSWElGdVR3RkdvSjl2V1d4?=
 =?utf-8?B?SENseEZ0ZXpSUU81SVdHZWsxaGp6V2ZIbVZ0VjhTVktkTUd0cDBmaUF1cDFT?=
 =?utf-8?B?L1d6QjJzN05JWmRZRmNOdk10aTJYRE44M2FnSUhWbmFFSzBFMDd4L2pYRzNw?=
 =?utf-8?B?Z1pMZGx6RUZsa2s4a3diUFFOeWpPVWM2ajc5Mm5WK3NsWU1wd2lXRWZCSXhz?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EHojqmgNSoxmfDhEp6USrmEkWBbgalj+cHB4x3234eVN/t7iPe8Z8mXM3Qy31Xg2pzqa+8aMi8PhV6lT2kPOHOD1Jhc5L9vjX+W3SQTF5jwoKZlcg+k3DsZPwecRusHr5opHTr8icaVxpKtlWGSB2rxNkDXNBZTf2GKD00weYGWzaJRZt5mXM4jHShZb3QnGfkA+K8Bq3T1ZlmJkR3ATzXflQD27BSl8/DqNW/RQhQIX01fVHvrXY5vx1HuicNC3McRqcu2tAqi1zCy1x/vVS0wA/kaWv2WAibxrSgvhcW+cwYa+ok9soUKsQSS6O3BN4j2TxK+B9L2xeDs/2hbUfBCEVjjGjJCNnlyNDnXEtclcHolcBpWaLirbW8mtVzhv47l/AjxaqYYiVagEepqVZIAkZNAT02dbQiJwUPIcWgqBq5uyJtLSgOQL5uzC/Aw309yOClRBlfgpa2LBKKf3m2cRIK62V9CcF63HpBGzgnNPMH1cF+Etp28TtJTOZ7EhpBXq04x92FzrA5HT1891C2rta52p0GFBca+DDEX8PqWJ06EK0b7xaB7JNW1peNbsNho65ORChTDLSWJNvzZ9jtY4j5lGwgZj+IVtt0Vv8fw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b33770f-59d7-4b04-4b4d-08dda7556b97
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5315.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:59:08.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvMpDUtNXkly/Ldti4nImCM+BoSKtUidQM4YunjiJ1/+WMjFOgccveEYmNjYarMRxbY218/zi0PlQgWUM9NVoah931bSCPXotvqrOIGzrWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF18D5A7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090095
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=6846daa1 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=i0EeH86SAAAA:8 a=f6zqxb0sB_Mj2gTl5CwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: TMhZcFNJ__47gZSAV7n-H3pF5eOFcdfr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA5NSBTYWx0ZWRfXzHMC6jS+x3zb xYMAN+aVZx2EXoqyoJnuC/w4wvzlZxVFRk+Phe8xgTXJEjpNkfmQ1KdMx5Unp6j3p93yrmeK8Rp oSC/emUXFxzhLy4Gx6tBVrNceGXe5IqAza+Nc2873AIjZXQcA7Yh7IvJUQnfAcvaqobsQGstkPT
 N6Ns5vBDdjsuIbPFGq4swmB0iNu0sC7KBm5Lvf6boISLqeX71q2ug5aDt5MG7paaK3sEaO+smwP pebiExoyzARHbgGSfroxZkR+p1N5w3jc6wvxemshmM2HBLICGfDV2ZxPRQbGpKEr729L/tWtXPd KMCVKf0GLJvuHwathP7Szl1/+1JGTDshItVIZjHxAWsQ5EzGbeaq4OMNhazeyzgdE7MgP95+iOe
 jthvMu7ySAnnzOlgQ8rQsE/LW6CpL2kkaLs+ycR0Ae7JXtKhHqKr4UaPPl6W6rJsvFPjRHst
X-Proofpoint-GUID: TMhZcFNJ__47gZSAV7n-H3pF5eOFcdfr




I really appreciate your review, thanks a lot!

On 09-06-2025 16:28, Jonathan Cameron wrote:
>> These changes improve readability and accuracy of the documentation.
>>
>> Signed-off-by: Alok Tiwari<alok.a.tiwari@oracle.com>
> One additional comment given you are touching this text.
> 
> Reviewed-by: Jonathan Cameron<jonathan.cameron@huawei.com>
>> ---
>>   Documentation/driver-api/cxl/memory-devices.rst | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
>> index d732c42526df..e9e2952a967d 100644
>> --- a/Documentation/driver-api/cxl/memory-devices.rst
>> +++ b/Documentation/driver-api/cxl/memory-devices.rst
>> @@ -29,8 +29,8 @@ Platform firmware enumerates a menu of interleave options at the "CXL root port"
>>   (Linux term for the top of the CXL decode topology). From there, PCIe topology
>>   dictates which endpoints can participate in which Host Bridge decode regimes.
>>   Each PCIe Switch in the path between the root and an endpoint introduces a point
>> -at which the interleave can be split. For example platform firmware may say at a
>> -given range only decodes to 1 one Host Bridge, but that Host Bridge may in turn
>> +at which the interleave can be split. For example, platform firmware may say at a
> Should probably be "platform firmware may say that a given range"

"We addressed these parts based on Gregory Price's comments and 
submitted version 2 of the patch."
use phrase -> "platform firmware may say a given range only"

> 
>> +given range only decodes to one Host Bridge, but that Host Bridge may in turn
>>   interleave cycles across multiple Root Ports. An intervening Switch between a
>>   port and an endpoint may interleave cycles across multiple Downstream Switch
>>   Ports, etc.
>> @@ -187,7 +187,7 @@ decodes them to "ports", "ports" decode to "endpoints", and "endpoints"
>>   represent the decode from SPA (System Physical Address) to DPA (Device Physical
>>   Address).


Thanks,
Alok
