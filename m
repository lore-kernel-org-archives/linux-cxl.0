Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C3158215;
	Tue, 23 Jul 2024 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759405; cv=none; b=X9oVkKbVbONDoW7O4YkXXF4phFuIVsMHSW/EKBoB9Bo1zPeymDmVyE/EYEc1LiJlHH21Du2tWUypMjba99Vg5rWAzWeBLt9rwpWVYXpLJc5jJ1J/ofwK9o3F2rFoo/lZCpvFmBDjz6G9p2ZkGdDbDO5eBJlztYTnFUN3WPWwQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759405; c=relaxed/simple;
	bh=M1c8J9MNr+ipuwKxbzX18E1Z1GCUzwhj0wbfmf3mvdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rWKxAFPcvaEG6Qx2hPFFPUB+vNUHgmMRgtOaFL2vEwBphvr/LGgdjSkHv5gl/xLN1NYYcDOUn6SrJEiun+oL2cVMBuEdQe97+c1Gwuhk0K6Ch3OtIZCxHkl7B7lkEcT6QTPJtbPO8hIzLwP8Y4B7aI66gfo0QIq8HuzGjeZXy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LVRXjE25; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LVRXjE25"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NAdlx4009355;
	Tue, 23 Jul 2024 18:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i/rjjL5o7SSk5LW63dKAFDIRubRpjc8u9o7O849qm/A=; b=LVRXjE25ZgOwNxTR
	QjxWFlIPBJqB6/DGACycZJD53VNhrbL9d3iGuAmTtfr9JIzwhrbVq4TAJVG2i8J8
	yv3W80YnWzHMFtDEovg0ltzwAbeNJkYYn/vrMrdUl6yMQuKB9gHWK3nmpakPiJxW
	+UEQZ3YOK+Tdv2xjqTIhDkh/HeUEWM5YRphnurmzbsh8AG1hTGAbYI1ItqHd0QF4
	nfoD1LuI64wxVCdWr7yqMzjAxUDJMoidAN7XyfK09Xsnkt2VEWRvsRtGK5/dfCnO
	/lFNQfMSAxqdRhapbSCDi2exxdC+UJUJW97nGD68QLsRAR+DJDkWUrQ+nBr0/BYr
	Bg0Thw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487fvwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:29:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NITmtC012070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:29:48 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:29:48 -0700
Message-ID: <cafa6bbf-446b-4b4c-9b6e-f4db6a19ae55@quicinc.com>
Date: Tue, 23 Jul 2024 11:29:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron
	<Jonathan.Cameron@Huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield
	<alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira
 Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20240607-md-drivers-cxl-v2-1-0c61d95ee7a7@quicinc.com>
 <20240607151046.00002ae2@Huawei.com>
 <aef7c12f-cefa-4823-b3a2-920c12990afa@quicinc.com>
 <73d13869-cb80-4226-b8fe-3e45fb7d2518@intel.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <73d13869-cb80-4226-b8fe-3e45fb7d2518@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5K_7Q8ZJwgKyhTlKBLhGLl9dw0NrwPx7
X-Proofpoint-GUID: 5K_7Q8ZJwgKyhTlKBLhGLl9dw0NrwPx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230128

On 6/26/2024 9:41 AM, Dave Jiang wrote:
> 
> 
> On 6/26/24 9:02 AM, Jeff Johnson wrote:
>> On 6/7/2024 7:10 AM, Jonathan Cameron wrote:
>>> On Fri, 7 Jun 2024 06:57:15 -0700
>>> Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>>
>>>> make allmodconfig && make W=1 C=1 reports:
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/core/cxl_core.o
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_mem.o
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_acpi.o
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pmem.o
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_port.o
>>>>
>>>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>>>
>>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> Thanks,
>>
>> Following up to see if anything else is needed from me. Hoping to see this in
>> linux-next so I can remove it from my tracking spreadsheet :)
> 
> I have it locally queued, but will probably push to linux-next after rc6 drops. 

Hi Dave,

I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff
