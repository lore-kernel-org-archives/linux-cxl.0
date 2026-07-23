Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1762EEE8D
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848693; cv=none; b=ZHyawaN2SF/klJ1UiAu8TQEnjkoDSoTJIzhxnco6uc10rzxfEAAghUyUVAVuxO/0qAmVt6B1ivlpJFTwnvd8jvyCTPrFC57gpKD1JfvnosrLN1smyygrT2HPYQ/ERsXMLxp3/5NtFqS/jAuV7J9YKn21OOl8VPQ9Hz3RauAh/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848693; c=relaxed/simple;
	bh=mRG5Q+bwQhOzc15TQoW9Na6Dx5/kSC1Qx5InPpubl+4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sQF4gJLqlfCN+UsYGrvHNYndTYgVACXJ/NlWO25arRnmuAAteVR4saRc8YpqkiNPVLGBlGdlsjAbTCaY1/AWtK0vqgS9eGukusdl2hOfzhh5I/2OFWKBtugm8758qdSDKXal6vkCT2KlgEY43GEBoXeXWQOCllNKOcp3iFftYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iSocWxD7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FJM5m7js; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iSocWxD7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FJM5m7js"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLfCmI1070799
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 23:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	URwVbTebyfSy3AMrazlDDmd7TkYbOHWRp0q3gMoMwL8=; b=iSocWxD79Zots23c
	aYAOi/YNyB9YR2O9/mB66N0pE6LU8scaLWfVmdQdOm0L/mMLKYgVdgZ7TPAquahd
	xSREW35SRWo1konP3esBYW7UmK3yJzPmQczhJGdhmwTtdi2M3h/VGaZ5xnkmw+kk
	BPKPOkpbli5KGvjKToUYWfeUJOG5fet5E5jNJCxvnDT10WS+R6Hg2sglCripMHpH
	/4nbJrsvyMPkLvilUytL7XdIsz3p03k/qcG66MAH8baRNfl43e/Ut1ZTPFXpOg+C
	P6/CCRLadbT7d+GqkAtMRowzAF3YKd6cENmAC8FyCxlxgA0tpBeVafQJ0EUGWnYg
	oNm3sg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkg523bdv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 23:18:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9c26587e67so999703a12.0
        for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 16:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784848688; x=1785453488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=URwVbTebyfSy3AMrazlDDmd7TkYbOHWRp0q3gMoMwL8=;
        b=FJM5m7jsvwcnZS27eZJK04TdwzOcz4JAaIrXaxbPMrqbpa3TbCqb9u2/1yT0cxpxNQ
         pNz4OFMbxV71uhutqiKv8J49GVI0LGqbTPpiP4AqcXjEIJmKMDceKS7RjYZ9+7pC3hHV
         Nu2NwecsC65r58eL10GovDmtbaKJShqyWeMbS4Eur3JelHInRbSxOyp8gxR0fc28SfHw
         H+ybzaBBrlDywf3G8O1/G0AYqUMpPZkcX1foKaevRYSX0PUgrekdGp5gDQLXSorFRbbV
         /f5hXoZZoxbohYZjhNoEMTZWY4No48LDaHIh5FGStxqyW66TPwq4j+YpcRYNY5eP00tE
         uFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784848688; x=1785453488;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=URwVbTebyfSy3AMrazlDDmd7TkYbOHWRp0q3gMoMwL8=;
        b=n+KWmgP1H4adthxe0dJP3X7C+yNtckBVEZmzMhJSfh4QNkySBuJhLjGyAZunuoNTcb
         KySoY+sLQ6MMk0z9Yd8n7Oyl2cZCQKvvVvX/qykuXmlwfDPS/EKadMI6tIIv8pAi5mCp
         hUClCQwjsj8mfiowiTeQiXPLQQzxHknE/JfCyesGvNTFV/9CR5BGaO6/JXKHdAQvb2vb
         txUkuInM8UpjXEhKPgpk/WD1ok63ge2+8gbVpkWcGTiEapWFux0H7LuQvxn3jXVy3fB0
         31kQy/awcl3TuftFIHvAIm4tMYgNH7S4eiDd+iyFtgAeQeNcTvWla9LNPIKJFpKziddI
         lORg==
X-Forwarded-Encrypted: i=1; AHgh+RqXaJanPaAMJMPc59b7G/xS12my7YlH12e9MEt9JE0uf2kc3ScFw3Bt/KYJ16uVAnRobFel8hN736I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2qYu8j58d5w+rzw8IzcgrpS9S/Io8e3FtDBumBJyGZjdoPviI
	bl9yYkjmC0f3UM7xWXZpgtkzYxUOJLmpoxw1KmdKE0QNu3W4XNTr4icXLitQtI/sf+eJQPy2z8i
	UhJ3xbYAUxbapUYLGCiY4v7tliI2Y76VaGfsz/EndDL+OcJBxYmVVvxeGKZtRhqw=
X-Gm-Gg: AR+sD11JNVt4ivoy7Hfacor91HTiuMkDhwD8J4/vFiT0m6SmSM8BflNLQKUr4x/Jooh
	j2Dtoc3zFI9+INeK/2u56CP6uXaZ3HVVeeqAPhH5NDlKa9xAockOVXdPRBqV75vcJNJ491Eg11+
	QvTnPA7FT4aQiwPUKOxrLO3EIdBRrpKV6M/jCv5/Zvi4mgLcjn7YzezJBvx3dIoPA9x8tWUNFa1
	c/hHTPVexv26l0ct2A5rzfhayMW9Mq5tBtjxyzHOOY3GI788oadw9RZYamp8F4eCjjbKwmyGiAb
	4iin9vMFrBMtIfr7rFEeVuwRHDI1RrqZAn+VoWOmuSoPScZ5+6jmm42dvyw6Wy0kWBy4NpS5Mw2
	Qg2aGZlI5ummMccgmyV5TbdMRamiv/6lzqaV5x0JG2nxp8z4ayvnPRcTI
X-Received: by 2002:a05:6a21:2d43:b0:3c3:6e84:ace8 with SMTP id adf61e73a8af0-3c44caf0a32mr5366471637.23.1784848688155;
        Thu, 23 Jul 2026 16:18:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d43:b0:3c3:6e84:ace8 with SMTP id adf61e73a8af0-3c44caf0a32mr5366438637.23.1784848687639;
        Thu, 23 Jul 2026 16:18:07 -0700 (PDT)
Received: from [10.71.178.173] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1a6adsm22456214eec.6.2026.07.23.16.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 16:18:06 -0700 (PDT)
Message-ID: <41540b44-8142-4b80-b876-0ff3f7ddd619@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 16:18:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: Enforce CFMWS memory type policy at decoder
 commit time
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, linux-kernel@vger.kernel.org
References: <20260711003341.2602368-1-mayank.rana@oss.qualcomm.com>
 <61531e60-0171-4d7e-b61b-ac0790a38ede@intel.com>
 <115d2157-d4d2-4897-a9c8-fe42fec0bbf9@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <115d2157-d4d2-4897-a9c8-fe42fec0bbf9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DtZmPm/+ c=1 sm=1 tr=0 ts=6a62a131 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=OvxQIU2IL3wE2Do5ZK0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIyNSBTYWx0ZWRfX49aWw03mqapo
 YRg5NI1+FVhiYSo7Zk/h1oIKLDrwOlZGmJdMe06k4ET9Pi/ye6heD5AU2WPRTmzaBscyxjP1S4y
 W0q+T07uKUPzD2AkLTS5rzNI/YmbLMU=
X-Proofpoint-GUID: ekFvx4aDbuc5hyYarIgUjBZlXp_YXkjA
X-Proofpoint-ORIG-GUID: ekFvx4aDbuc5hyYarIgUjBZlXp_YXkjA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIyNSBTYWx0ZWRfX/UOKddfBVfhn
 R4KJFMUdF37/sPmfH75N+0WeIfos5xXI6HK1x0BqvLs2+0UvydkWab9/iOuxesSkUgDPuygzeWs
 uvn+G8VrzIWT928R8UVU+Hz9S22nfKB7NC9+4swVztHU9p1BQjui9aYCvXvseUHMvL6o/noBWY9
 9NgO5TaRR7xUVa3ljRV4mP+cUWXDOERA8PmD4XPSfVc+XBB8rywEg/zDnHOYVTpuwt8E8Ai2OZn
 PylachokiSfQVZN4iydn9VGQegx+JBP41rpdsQt1NwTpi/sqcFtxyYoNmLVzmd2IE3M4qwNks57
 7jSRE+ajTwrSMXj99PzpsbPtrLPrR0aplI02ETBLrrxx3jYrfhIHIOO5bZ8oVdg+yP7Gu0047vC
 V570qn4IgaR0hW2zkcR1+Ukn2tOWjwH0zV8IV++gdSj5dLbzMBzQxj6iaYpIOa5Bkv2S7Ujc6AV
 nOah86GxClG8XPV8wHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230225

Hi Dave

On 7/15/2026 3:26 PM, Mayank Rana wrote:
> Hi Dave
> 
> Thank you for review comments.
> 
> On 7/13/2026 8:47 AM, Dave Jiang wrote:
>>
>>
>> On 7/10/26 5:33 PM, Mayank Rana wrote:
>>> A CXL Fixed Memory Window Structure (CFMWS) in the ACPI CEDT table
>>> carries a restrictions field that describes the memory types a platform
>>> window supports.  cfmws_to_decoder_flags() translates this into
>>> CXL_DECODER_F_TYPE2 (HDM-DB permitted) and CXL_DECODER_F_TYPE3 (HDM-H
>>> permitted) flags on the root decoder.
>>>
>>> However, nothing currently prevents a caller from committing an endpoint
>>> or switch decoder whose target_type conflicts with the CFMWS policy:
>>>
>>>    - A decoder with target_type == CXL_DECODER_DEVMEM (HDM-DB) can be
>>>      committed on a window that lacks CXL_DECODER_F_TYPE2 (HDM-H only).
>>>      A dual-capable device will accept HOSTONLY=0 + COMMIT=1 without
>>>      asserting COMMIT_ERROR, silently violating platform policy.
>>>
>>>    - Symmetrically, a decoder with target_type == 
>>> CXL_DECODER_HOSTONLYMEM
>>>      (HDM-H) can be committed on a window that lacks CXL_DECODER_F_TYPE3
>>>      (HDM-DB only), again violating ACPI CFMWS restrictions.
>>>
>>> Add a check in cxl_decoder_commit() that walks from the decoder's
>>> assigned region to the root decoder and rejects the commit with
>>> -EOPNOTSUPP if the decoder's target_type requires a capability flag that
>>> the CFMWS window does not advertise:
>>>
>>>    - CXL_DECODER_DEVMEM      requires CXL_DECODER_F_TYPE2 on root 
>>> decoder
>>>    - CXL_DECODER_HOSTONLYMEM requires CXL_DECODER_F_TYPE3 on the root
>>>      decoder
>>>
>>> required_flag is initialized to zero so that any future target_type
>>> values not covered by the if/else-if chain leave the enforcement check
>>> a no-op via the leading required_flag && guard.
>>>
>>> This makes the CFMWS restrictions field authoritative for memory type
>>> enforcement in both directions, regardless of individual device 
>>> capability.
>>> The existing COMMIT_ERROR path in cxld_await_commit() remains as a
>>> secondary safeguard for devices that cannot support the requested mode.
>>
>> Can you please trim the commit log? The AI generated verbiage is 
>> excessively wordy. A simple and more to the point short log that 
>> conveys all the information would be appreciated.
> ok. noted down.
>>>
>>> Fixes: 3e23d17ce198 ("cxl/acpi: Use the ACPI CFMWS to create static 
>>> decoder objects")
>>> Assisted-by: Claude:claude-sonnet-4-6
>>> Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
>>> ---
>>>    - Initialize required_flag = 0 and use explicit else-if for
>>>      CXL_DECODER_HOSTONLYMEM; guard enforcement with required_flag &&
>>>      so unknown target_type values skip the check cleanly
>>>
>>> Changes in v2:
>>>    - Extend enforcement to cover both directions: HDM-H commits on
>>>      HDM-DB-only windows are now rejected in addition to HDM-DB commits
>>>      on HDM-H-only windows (reported by Sashiko AI review)
>>>    - Generalize condition from single DEVMEM check to type-dispatch
>>>      selecting required_flag based on target_type
>>>    - Update commit message and subject to reflect bidirectional policy
>>>
>>> Testing
>>> -------
>>>
>>> The bug and fix were validated using QEMU with a modified CXL 
>>> configuration.
>>>
>>> Two test-only changes were applied (not part of this patch):
>>>
>>>    1. QEMU ACPI (hw/acpi/cxl.c): CFMWS restrictions field changed from
>>>       0x0f to 0x02 (ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM only, without
>>>       RESTRICT_DEVMEM).  This causes cfmws_to_decoder_flags() to set
>>>       CXL_DECODER_F_TYPE3 only on the root decoder, simulating a 
>>> platform
>>>       that does not permit HDM-DB.
>>>
>>>    2. Kernel (drivers/cxl/core/hdm.c): init_hdm_decoder() uncommitted
>>>       endpoint path changed to force CXL_DECODER_DEVMEM unconditionally,
>>>       simulating a dual-capable device (supports both HDM-H and HDM-DB).
>>>       QEMU's cxl-type3 device reports CXL_DEVTYPE_CLASSMEM and defaults
>>>       to HOSTONLYMEM; this override exercises the DEVMEM commit path 
>>> that
>>>       a real Type-2 or dual-capable Type-3 device would trigger.
>>>
>>> Bug reproduction (without this patch):
>>>
>>>    # cxl create-region -m mem0 -d decoder0.0 -t pmem
>>>    created 1 region
>>>
>>>    HDM-DB committed silently despite CFMWS advertising HDM-H only.
>>>    No error or warning in dmesg.
>>>
>>> Fix validation (with this patch):
>>>
>>>    # cxl create-region -m mem0 -d decoder0.0 -t pmem
>>>    cxl region: cmd_create_region: created 0 regions
>>>
>>>    dmesg:
>>>      cxl_core: cxl region0: mem0:decoder2.0 type mismatch: 2 vs 3
>>>      cxl_port endpoint2: failed to attach decoder2.0 to region0: -6
>>>
>>>    The decoder's target_type (2=DEVMEM) mismatches the region's required
>>>    type (3=HOSTONLYMEM) enforced by the CFMWS restriction -- commit 
>>> blocked.
>>>
>>> QEMU invocation:
>>>
>>>    qemu-system-x86_64 \
>>>      -kernel bzImage \
>>>      -append "root=/dev/sda rw console=ttyS0" \
>>>      -drive file=rootfs.img,index=0,media=disk,format=raw \
>>>      -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>>>      -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/ 
>>> cxltest.raw,size=256M \
>>>      -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/ 
>>> lsa.raw,size=256M \
>>>      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>>>      -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>>>      -device cxl-type3,bus=root_port13,persistent-memdev=cxl- 
>>> mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
>>>      -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
>>>      -nographic
>>>
>>>
>>> drivers/cxl/core/hdm.c | 29 +++++++++++++++++++++++++++++
>>>   1 file changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>> index 0c80b76a5f9b..127a187cdadb 100644
>>> --- a/drivers/cxl/core/hdm.c
>>> +++ b/drivers/cxl/core/hdm.c
>>> @@ -802,6 +802,7 @@ static int cxl_decoder_commit(struct cxl_decoder 
>>> *cxld)
>>>       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>>>       struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>>>       void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>>> +    struct cxl_root_decoder *cxlrd;
>>>       int id = cxld->id, rc;
>>>       if (cxld->flags & CXL_DECODER_F_ENABLE)
>>> @@ -834,6 +835,34 @@ static int cxl_decoder_commit(struct cxl_decoder 
>>> *cxld)
>>>           }
>>>       }
>>> +    /*
>>> +     * Enforce CFMWS memory type policy: reject commits where the 
>>> decoder
>>> +     * target_type conflicts with the root decoder's CFMWS 
>>> restrictions.
>>> +     * - HDM-DB (DEVMEM) requires CXL_DECODER_F_TYPE2 on the root 
>>> decoder.
>>> +     * - HDM-H (HOSTONLYMEM) requires CXL_DECODER_F_TYPE3 on the 
>>> root decoder.
>>> +     * - Unknown target_type values leave required_flag zero; skip 
>>> enforcement.
>>> +     */
>>> +    if (cxld->region) {
>>
>> I don't think we should gate the check based on whether cxld->region 
>> is valid or not. Can you please take a look at core/ 
>> region.c:271:cxl_region_decode_reset() and do something similar to 
>> acquire the root decoder by walking up the port hierachy? That should 
>> apply the policy check unconditionally. I would also suggest putting 
>> this entire block in a helper function.
> will refer suggested API, and rework upon this.
Thanks for the pointer -- I looked closely at cxl_region_decode_reset()
and want to flag something before sending v3, since a literal port-walk
doesn't fully replace the region lookup here.

cxl_region_decode_reset() doesn't derive the decoder from the port walk
alone: it's called with cxlr already known, and at each port level uses 
cxl_rr_load(iter, cxlr) -- keyed by the region -- to find the decoder 
assigned to that region at that port. The walk finds the *port*; cxlr 
still finds the *decoder*.

The reason that matters for this check specifically: a single CXL root
port can host multiple root decoders, one per CFMWS window, each with
its own restrictions. A pure walk up to is_cxl_root(port) would tell us 
this decoder's SPA range originates somewhere under that root port, but 
not *which* of its root decoders' CFMWS restrictions apply -- only the 
region (or the port's region_ref tracking, which is  also region-keyed) 
can disambiguate that.

So v3 keeps the region-based lookup (cxld->region->dev.parent ->
to_cxl_root_decoder()), but addresses what I take to be the actual 
concern -- silently skipping the policy check -- by making the check 
itself unconditional instead of gated:

if (dev_WARN_ONCE(&cxld->dev, !cxld->region,
                        "commit without region assignment\n"))
             return -ENXIO;

A decoder reaching commit() without a region assigned is now treated as
a bug (loud WARN + rejected commit) rather than something the check 
quietly steps around. By the time cxl_decoder_commit() runs, the region 
assignment has already happened during region assembly 
(cxl_rr_assign_decoder()), so this should not be reachable in practice. 
Also pulled the whole block into cxl_decoder_cfmws_check() as suggested.

v3 to follow shortly with this and the F_DEVMEM/F_HOSTONLY rename per
Davidlohr's BI series.

Thanks,
Mayank
>> DJ
>>
>>> +        unsigned long required_flag = 0;
>>> +        const char *type_name;
>>> +
>>> +        cxlrd = to_cxl_root_decoder(cxld->region->dev.parent);
>>> +        if (cxld->target_type == CXL_DECODER_DEVMEM) {
>>> +            required_flag = CXL_DECODER_F_TYPE2;
>>> +            type_name = "HDM-DB";
>>> +        } else if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
>>> +            required_flag = CXL_DECODER_F_TYPE3;
>>> +            type_name = "HDM-H";
>>> +        }
>>> +
>>> +        if (required_flag && !(cxlrd->cxlsd.cxld.flags & 
>>> required_flag)) {
>>> +            dev_err(&port->dev,
>>> +                "%s commit rejected on %s, CFMWS does not permit 
>>> this memory type\n",
>>> +                type_name, dev_name(&cxld->dev));
>>> +            return -EOPNOTSUPP;
>>> +        }
>>> +    }
>>> +
>>>       scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>>>           setup_hw_decoder(cxld, hdm);
>>
> Regards,
> Mayank
> 

