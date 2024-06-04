Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A583CD6;
	Tue,  4 Jun 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532528; cv=none; b=mDEALPP8mtZQkXBu/Q1xO42idklr6bjsTfG5kmARimhI8c7Dh02giQwftdtb5IqhLrog11nI+p48afj/OPYm8uuOlvdC4smVZwn3Ksm7Eo7XaVOuzGQGjvqftqTWhvUg1WxunRa8mnOsFHtH/mml8QlXT1s+ioGdmLeYVb9w9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532528; c=relaxed/simple;
	bh=rj8tuvfVT3pQXy2JtATqZMda5lX7uPjdNHpX+MjWHuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=syhLbrSiAA6tLa7tOrut+CkCIZkmSSEJNr56F+GPELs1ych2+J8eRyx0IDnE37nPE7tmy4BCxVJS50uxSyR8N4djs7x0h0j4T//Ws86bzieSoWTH+0HI3DRJYoP4StMYnEALOi4NPxVYkR7YjQ8hWdpLoQ4xRrwghQNH7v94ZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ApGpR4iA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ApGpR4iA"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454HIXuM005515;
	Tue, 4 Jun 2024 20:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	14uxE1rIsU28J32tiKle2lkHmGkT0MrPRwVsVv/GKAc=; b=ApGpR4iA0V5c7T58
	ivv/FVMC+4vAsgyUNmIa/DOCRnsouAKkx+Tp8xm5OaEXyZk1ctU0jcHOLpET7UPo
	C6NU9a7i8uk0lrjsg+g2Ze/Z6eYcQtmRkxiFHxDITkLlNGRyYUdJXBqA/xG+5W3N
	UwIaB45IetpFqN/nN1tABl5o08LiAVZSyJVQoLXbo89+qALmrZ4CT/gqpdWRj9fV
	0ernVGT0kbTFtj9wN5R5irjcwNnQGdcefSREgsIgULRFYbLAmCAJq0o/cKTpisNa
	8YYy1L1wRCBlDBJOdKGa8sxLcDxzpAgNV5yFW5/x4+/adtWcN+MP0VCig+tj/lgv
	ZWo2NQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj76wgcgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 20:21:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 454KLsaF013298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 20:21:54 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 13:21:53 -0700
Message-ID: <362fccea-707f-4430-8da3-8acc6ac5fbe9@quicinc.com>
Date: Tue, 4 Jun 2024 13:21:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma
	<vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240603-md-drivers-cxl-v1-1-f2940f5c0836@quicinc.com>
 <20240604170445.00005c67@Huawei.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240604170445.00005c67@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yfAKyCKxeS-gM4in7p3Eabdjkfl6f08i
X-Proofpoint-ORIG-GUID: yfAKyCKxeS-gM4in7p3Eabdjkfl6f08i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040164

On 6/4/2024 9:04 AM, Jonathan Cameron wrote:
> On Mon, 3 Jun 2024 21:48:53 -0700
> Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> 
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/core/cxl_core.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_mem.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_acpi.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pmem.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_port.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> This has been irritating me as well.  Need to do
> drivers/perf/cxl_pmu.c at somepoint as well but given that goes through
> a different maintainer makes sense to do separately.
> 
> Only comment I have is that we should probably strive for more consistency
> than you currently have.  Always expand CXL or never do, use
> colons consistently, use Support everywhere or nowhere.

I'm going through a bunch of these tree-wide, and usually just copy/paste
either from existing comments in the .c file or the description of any
associated Kconfig item.

>> ---
>>  drivers/cxl/acpi.c      | 1 +
>>  drivers/cxl/core/port.c | 1 +
>>  drivers/cxl/mem.c       | 1 +
>>  drivers/cxl/pci.c       | 1 +
>>  drivers/cxl/pmem.c      | 1 +
>>  drivers/cxl/port.c      | 1 +
>>  6 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 571069863c62..e51315ea4a6a 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -921,6 +921,7 @@ static void __exit cxl_acpi_exit(void)
>>  /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
>>  subsys_initcall(cxl_acpi_init);
>>  module_exit(cxl_acpi_exit);
>> +MODULE_DESCRIPTION("CXL ACPI: Platform Support");

From Kconfig:
config CXL_ACPI
        tristate "CXL ACPI: Platform Support"

>>  MODULE_LICENSE("GPL v2");
>>  MODULE_IMPORT_NS(CXL);
>>  MODULE_IMPORT_NS(ACPI);
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 887ed6e358fb..ccaa00cd0321 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -2356,5 +2356,6 @@ static void cxl_core_exit(void)
>>  
>>  subsys_initcall(cxl_core_init);
>>  module_exit(cxl_core_exit);
>> +MODULE_DESCRIPTION("CXL (Compute Express Link) Devices Support");
> 
> Why the expanded version for this one?
> 
> I'm not sure Devices really makes sense here, particularly as it
> likely a range of other driver will make some use of this core
> functionality over time.  Maybe "CXL core" is sufficient?
> 

From Kconfig:
menuconfig CXL_BUS
        tristate "CXL (Compute Express Link) Devices Support"

>>  MODULE_LICENSE("GPL v2");
>>  MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 0c79d9ce877c..1afb0e78082b 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -252,6 +252,7 @@ static struct cxl_driver cxl_mem_driver = {
>>  
>>  module_cxl_driver(cxl_mem_driver);
>>  
>> +MODULE_DESCRIPTION("CXL: Memory Expansion");
> 
> Why does this one get a colon? Also no Support at the end?

From Kconfig:
config CXL_MEM
        tristate "CXL: Memory Expansion"

> 
>>  MODULE_LICENSE("GPL v2");
>>  MODULE_IMPORT_NS(CXL);
>>  MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index e53646e9f2fb..2c17fcb1b4ee 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1066,5 +1066,6 @@ static void __exit cxl_pci_driver_exit(void)
>>  
>>  module_init(cxl_pci_driver_init);
>>  module_exit(cxl_pci_driver_exit);
>> +MODULE_DESCRIPTION("CXL PCI manageability");

Kconfig just has:
config CXL_PCI
        tristate "PCI manageability"

I added CXL

>>  MODULE_LICENSE("GPL v2");
>>  MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
>> index 2ecdaee63021..4ef93da22335 100644
>> --- a/drivers/cxl/pmem.c
>> +++ b/drivers/cxl/pmem.c
>> @@ -453,6 +453,7 @@ static __exit void cxl_pmem_exit(void)
>>  	cxl_driver_unregister(&cxl_nvdimm_bridge_driver);
>>  }
>>  
>> +MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");

From Kconfig:
config CXL_PMEM
        tristate "CXL PMEM: Persistent Memory Support"

>>  MODULE_LICENSE("GPL v2");
>>  module_init(cxl_pmem_init);
>>  module_exit(cxl_pmem_exit);
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 97c21566677a..5ceff1df60db 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -209,6 +209,7 @@ static struct cxl_driver cxl_port_driver = {
>>  };
>>  
>>  module_cxl_driver(cxl_port_driver);
>> +MODULE_DESCRIPTION("CXL Port Support");

This I just made up from the others since config CXL_PORT doesn't have a menu
description or help text and the .c file begins with:
 * DOC: cxl port


>>  MODULE_LICENSE("GPL v2");
>>  MODULE_IMPORT_NS(CXL);
>>  MODULE_ALIAS_CXL(CXL_DEVICE_PORT);

If you have specific edits you'd like me to make, I'm happy to make them.
I have no opinion on the content -- I just want to get rid of the warnings :)

/jeff

