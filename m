Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0EF19539B;
	Fri,  7 Jun 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768649; cv=none; b=kpUR8ONV9quqgFqxEIC/JBQSteaiQqeMmtg5AcHwMZkRqVZfBmu0eKSvHW0/5EXShVBBckvbY6+MvI6aZ6MEJ5+SI7gdfBbT8j3cHD7J1+J2VrsvcsHjZm/pIHE9md7KVbMuUvxELIE7G4hzuec/RLUlXN8TKu0cKFY0Pe3XjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768649; c=relaxed/simple;
	bh=gPkFO12pflIO62MXs5IidQzGEJi5GKXY93ITDmPV6hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P94YO/cehcDjhb4m+RfimXOxSQX45Bf/Bacv/GGw14OIGTNQ/sr1S0tx+We9jdPOsRtlb/2OU2UvreP/l3x55s1U8hkPeV+j/l9wftliNgBRnym2HRBAZ2R4E8umo0qnCbMpdHXqqDerZT538IGGtDoQ9ojNIcfTEmhfMDxzpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aihjWv3s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aihjWv3s"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457DcGKX031633;
	Fri, 7 Jun 2024 13:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j/EI6cwmhxs545M9v6xg6gT7cbzw9onACkmJMBPoTuw=; b=aihjWv3sSld+mdwZ
	jginh28cowewCAjx79ToXkw7TfmB2LA0pDkdRpMpbTTQ03xUvh2YhKNv8ne6VUxo
	NyiacbgFfbxm4DR9TaxzebxKL8X0QSKngXmA/8p54eOGyJrQz9Mz7XBJhegU/XjE
	zMGlYNJqz6Gm8T0c2KzQWOEZAwCY26Je6Mdc72ROCXUwLETfGRQiGSbv9Nn5h4wn
	zTLU7U548hAd7GXlsfw1V4mTfa8YBXfUc6Ce7f7jChDANaU5uDyogTj/NqbMYNAb
	TaCUn4vbmiZ4jz78Eqr0JHs3wQBwUQZ9hWcfzv4yRGlMmSs5SgazuMtQD5931nFu
	p0QDmw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk8tcbqe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 13:57:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457DvAd0031618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 13:57:10 GMT
Received: from [10.48.242.185] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 06:57:08 -0700
Message-ID: <2740b286-30cc-4067-9080-6cdc752ffb1a@quicinc.com>
Date: Fri, 7 Jun 2024 06:57:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams
	<dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma
	<vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240603-md-drivers-cxl-v1-1-f2940f5c0836@quicinc.com>
 <20240604170445.00005c67@Huawei.com>
 <362fccea-707f-4430-8da3-8acc6ac5fbe9@quicinc.com>
 <20240606151521.000018fd@Huawei.com>
 <b3405ab7-b322-4ce9-9dfa-efb52438383a@quicinc.com>
 <6662497490e90_2177294e4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240607093006.00004335@Huawei.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240607093006.00004335@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pLe3atpFAPu7Pnf6agUBCgbc3aghaIbP
X-Proofpoint-GUID: pLe3atpFAPu7Pnf6agUBCgbc3aghaIbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_07,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=706 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406070100

On 6/7/2024 1:30 AM, Jonathan Cameron wrote:
> On Thu, 6 Jun 2024 16:42:44 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
>> Jeff Johnson wrote:
>> [..]
>>>>> This I just made up from the others since config CXL_PORT doesn't have a menu
>>>>> description or help text and the .c file begins with:
>>>>>  * DOC: cxl port  
>>>>
>>>> "CXL: Port Support"
>>>>
>>>> Not that informative, but I can't immediately think of better text.  
>>
>> How about "CXL: Port enumeration and services"
>>
> 
> LGTM

Thanks, will update in v2
