Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943D3859D3
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688087; cv=none; b=D6S+xoYungAohFeAtSTiTLJ29kf3IHj1r+xeHJEuYUERR6HUZOof463OW57yifDKewlx7ny62S3cfHOwmpAwWCgFUtktNtOSB7dCT/woLZ0hgs7xul8Xap2KXm2F7B/xEe7O9aMxtA5pZMUtP6cLyyd3dIdRuzthYcm8o1w2i6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688087; c=relaxed/simple;
	bh=4LcIv7YGKguKtRB0R0BnM4fWfW2MceVBatEnb/2l150=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diLMG7Wci2vhhKBAYPn18djwhJTwYirJrcQ+YeFGsMGQCRh9a3Z1QNkr4ZLW2PYjxiGm4BImXQi5Gv9T6I50r6DHHfAz299Xfu1kSZvzV2NRoX9W+VvQKazgQjnAokAyLF+FOEAAY3x0ze6UH4dr9JFoYHnekAK3TjWurHzs7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ISurssXt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SYU/17hb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ISurssXt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SYU/17hb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DAWDXF2321248
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 16:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9i2GVjQ/hbSIakHx6hShMfu9qm3Hf7l4LQl2CGZ9VTo=; b=ISurssXtH9oxiRpe
	98+ATJHGwlVl6mVeCRjEh8mTFXE+AANB9OHkDzuS96rEM/nqO0p61vH9RtvhBcp0
	qJZzQb0nnSw7iO5pOo74spoA7qzFcTb9tNfZgye2WKnW7tQDplGQi1AfBRQaazTM
	PeNgqBNaF5szf5aUnRHeBaw/wi66vZvbSDnm3EQ9Kul5qWbN9lc1zXDGHxmZSn15
	jD88I1DGRcwPcwvXCQIOuC0WNLrMYp62WP/3OMw88dDxhspyXWEFZOp8HANTuCH9
	TqLCv5laR8ke+U1skxBjAkmlKERQzsTTqBoBH+3a3tUszkDhcb93a1B91ILcJKBh
	gKtnwg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hguau2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 16:01:25 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-132d631edaaso20024760c88.0
        for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778688084; x=1779292884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9i2GVjQ/hbSIakHx6hShMfu9qm3Hf7l4LQl2CGZ9VTo=;
        b=SYU/17hbAx8/oX4JGq7t27SCKba0kBZFsGhZfXT9b6BRM8C//CMrahxcjatcNzwdTR
         dMt+bwPu4QpEB8bfwdSUR3IVon5RAUS7fnTM0svaRTYaeSkLO/mhFCQoYYeM7GYr+MGU
         zEILmFMsYe04tH2XwkrjDLDgIzWMfY/SXU5PO0TWkdWIS/EFeuCPuBgKXtC2/yNQ8jZO
         cvXLdMEdteIQy9dYVswzKubENuz+zVN8NPKyns8ZnK6q/3Tm8fFPO5O58VJ6I3ZQAQT3
         8NlQ9dMvbMEdkTLUoJBt5uPEKVmLiTJvBhLnk2prVZZMrR1KPdWwV32TaD8ZgISyoFtV
         Icpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688084; x=1779292884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9i2GVjQ/hbSIakHx6hShMfu9qm3Hf7l4LQl2CGZ9VTo=;
        b=ahIl0Q28z0eG09lLBdpDSRTPAEXOPWqi/QLWkUzHqdtkt+4G3T2+M519QrELsnqZxK
         iI+J6zanT2t07UR9QmPVjwqt/jedc9TQw0VB+as8CzdZQChPDZKUlteETnW9adrQRXM+
         atzViW52YEKTrByRzljggGNPFzETTTUTytv/3rwX5fmOcRrRiNZJl0M308iK8+e5kkh8
         VufVMRcU3IuoV0w627L1CFCrmfKR/cq+t2Vjjh59JeEj4MamS5mwtEKAci9YO2siQqL3
         RqMQz48/wS2VETmhoz/9ptUOlO/aL56JEHf9i6KrCScqq6F5pQrqVriLnk59EzcE/Dct
         dFsw==
X-Forwarded-Encrypted: i=1; AFNElJ8vfQ1utqRgtvsNSdzKFi41Khe6DoGsbZBZ5K6OMQcwg9nTFu+CWhBdrlhuYtmdEUaCtADJ3j2YqtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLE7rsrFC/0vP2dDcV2Nyzw6ba5/p9eva5eGF6qfCIjiLMgbxa
	2Y2Yq7aBXj/6HdsKopcmd1vpZWHA1QagVXBpOMAzA2xXEfi3kWd8oOJWPZVi7rgjKNovw+qussW
	oCPcwTpY/6KZ3tI5RuALLrnBje/p1dC1+bOeQep2Pn2rc0yjT07Zzehy+UgD5jOX6F3cMML5qco
	7u
X-Gm-Gg: Acq92OF9/nOe4i87TIdd9kDXvWq71f8BQeL/jXbNOlMisZpm+PZBTyY4neJR5AbWNBu
	K9WAh01K1HxFUq1uLbNRXxXgMCAwZ0cLVPfoq7nOUj8d2s7hvIJx8TpqXj31Jc91iicH3WG6q9b
	u4ibr9FFXfwX/IjRFkb8brYOlUnBOanPGhqQurDH1SPhGJEY3E4pU4M8mT1Eoko2gbvf7BBSok8
	alW86nENRILlVf16gSWTYjTBB3GnjLAKumvfygMx5Sr0/BigjRVMUJE4bySf2VCuW2+us+rWPA8
	Mj2y7Ge2pSVtq/woi8kkSe5bmFgztTA4griDR2hz6TfO/cHJHNRXg5wbAE1KNcQpo0eKWWrqAYX
	neJyt1GTB2V9UBIOyzIB4akJI7ANQHeg6dq6Fr7BUS18TEcBcoILY
X-Received: by 2002:a05:701b:2513:b0:134:a701:de8 with SMTP id a92af1059eb24-134a7010fd6mr983177c88.5.1778688083936;
        Wed, 13 May 2026 09:01:23 -0700 (PDT)
X-Received: by 2002:a05:701b:2513:b0:134:a701:de8 with SMTP id a92af1059eb24-134a7010fd6mr983081c88.5.1778688081428;
        Wed, 13 May 2026 09:01:21 -0700 (PDT)
Received: from [192.168.0.31] ([212.5.153.243])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134b4e153dbsm2062086c88.12.2026.05.13.09.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 09:01:21 -0700 (PDT)
Message-ID: <fb932d7f-0ba7-415d-ab36-e948d2bbb537@oss.qualcomm.com>
Date: Wed, 13 May 2026 19:01:16 +0300
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/base/memory: set mem->altmap after successful
 device registration
To: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, osalvador@suse.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, djakov@kernel.org
References: <20260513130900.2204499-1-georgi.djakov@oss.qualcomm.com>
 <f25f1ef0-5359-4c00-920d-cdfc37cda968@kernel.org>
 <a3eea8f4-d693-41da-b8ab-764e6ce311ad@kernel.org>
Content-Language: en-US
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
In-Reply-To: <a3eea8f4-d693-41da-b8ab-764e6ce311ad@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04a055 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=douLNevBrtimd63D7eljNA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=h-BE1Ed2neb_JwLtZIQA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: hLd21eWyYfqBZu5wXTKORzMa5ArMDP2u
X-Proofpoint-ORIG-GUID: hLd21eWyYfqBZu5wXTKORzMa5ArMDP2u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2MyBTYWx0ZWRfXw0VrpmvMZdH7
 4ECNDn9bomGnZhJkU2NKtduD56UrcRdC2U7A1aO5Hc0M9yG4wW4dk9tF3zwEBUVKkArUpwJMFXm
 Lp0DCR3otrAQJFUWyFUwFONtcmYfARADOKa1BwrkHzvRkonHgexBrhSOEp7oToT7ia98mvqWc5R
 4cVLNRfDFgrVjQOgZ5SJYus7gYI/Ns47Nhl7QHhoqPHj+Fk02oaVIQo3IuSe7eqhUDzYl3NbL7p
 79kwYh2rhchfhGTRLdURWl7qsdhTCjKOqtBoAHj2IpPb13VRt1ffVvF0frSfjBbbUWiel/CGd0Y
 S6voZNrs2OhIAvH+xOrFxQ/qbhSMEZheLUEjUPmoIqtTzMhFT92oIeVFdX3Pm32TUukSmyhqAmy
 k8cOhg8VdsUzKumvnxoR53EECS3QTUF3Z95Xr0SvWL96MQWUPHpe61PaZ9gRAhjhq3Q5gQ+SRaI
 Ux9ePxYaPrBVZwgnthA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130163

Hi David,

On 5/13/2026 4:20 PM, David Hildenbrand (Arm) wrote:
> On 5/13/26 15:14, David Hildenbrand (Arm) wrote:
>> On 5/13/26 15:09, Georgi Djakov wrote:
>>> If __add_memory_block() fails at xa_store() (under memory pressure
>>> for example), device_unregister() is called, which eventually
>>> triggers memory_block_release() with mem->altmap still set, causing
>>> a WARN_ON(mem->altmap).
>>>
>>> WARNING: CPU: 1 PID: 76 at drivers/base/memory.c:96 memory_block_release+0x28/0x30
>>> Call trace:
>>>  memory_block_release+0x28/0x30 (P)
>>>  kobject_put+0xc8/0x1bc
>>>  device_unregister+0x2c/0x68
>>>  add_memory_block+0x1b4/0x214
>>>  create_memory_block_devices+0x9c/0xfc
>>>  create_altmaps_and_memory_blocks+0x130/0x1cc
>>>  add_memory_resource+0x10c/0x21c
>>>  add_memory_driver_managed+0xb8/0xe8
>>>  virtio_mem_add_memory+0xa4/0x194 [virtio_mem]
>>>  virtio_mem_sbm_plug_and_add_mb+0xc8/0x16c [virtio_mem]
>>>  virtio_mem_run_wq+0xea8/0x1088 [virtio_mem]
>>>  process_scheduled_works+0x18c/0x300
>>>  worker_thread+0x1dc/0x2b8
>>>  kthread+0x1ac/0x1f4
>>>  ret_from_fork+0x10/0x20
>>>
>>> Fix this by delaying the assignment of mem->altmap until after
>>> __add_memory_block() has succeeded.
>>
>> Something does not add up here. How do you get an altmap with virtio-mem?
> 
> That patch itself makes sense, but the callchain does not make sense.
> 
> virtio_mem does not set MHP_MEMMAP_ON_MEMORY, so it should never reach
> create_altmaps_and_memory_blocks()?

I have some out of tree virtio_mem patches on top that helped to trigger
this. Sorry for not mentioning it. Should i remove the callchain from the
commit text to avoid confusion?

Thanks,
Georgi

