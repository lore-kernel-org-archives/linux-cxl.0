Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B443D3499
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154369; cv=none; b=FFjz53Z44j6ugSTJxBhZWLDHUT8+oQO84MPloRU3LVqMo2CU8uXenvTIQw2PRt/0cTRyoiv7hry+YUlXPEOxwTH4pDlcH2qrzTrPifGhKGPxlXZJk6waGkTwcv26G3u1LhdvMGjYikNEcgeBPDV4GWNNRTPve9hlS0xoOgjfF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154369; c=relaxed/simple;
	bh=OEcNvjwk6pc1GWy+0beqfMS3+K+DDDS1POR3nHWjm2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkUCpxXpboZIIG5U35LcIt44XCHhwc25FfKyYKvN0iBqiL5VfStTsDJNPZhkLeJ+xtp+bvL9ssU9+jxLKaAsHYLyjGYe0arFqAEDPD81cF4pEZAFzW637dPi6aS/rR1VWOUqRTyQiXXeZQ+RxTdSv2gmvw7A52aRfxfccq9k9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hiuYYeKY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F63Hi9Np; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hiuYYeKY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F63Hi9Np"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKPJbu1713997
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 22:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPE9hDY7OVlCjZI5zzGvMOmszedQ4sO74FdAg6irg6I=; b=hiuYYeKYGd1pkP4G
	ugPmm9bIbvq99F3YtqXnllNQoBgTu1gm2vL1KYRFoCPL9SjUov8byoUguLjoqEAo
	XLr6g/Onu66m80psEDaM/nmiStU99pXmuHZD09pe1oj6KBTJp+EpI4hJUtd6WGZx
	tR31AdhNTl1z1wZYEE3MX2WiTc+t+PhYumSlhrny453xvgc44TrRygYibD4X16ZP
	ku54PG7rPk9GfbpMiv98Eu+hKHYtiseMcPBkC+9u5c6uY5uQ4jP3cNFPm7smKPWC
	kjGqmoPtnQnta+/pW/YS0sBmxHrzS+dlvYuRy/r9ys+l+U8588FSdsgi7fySe7dk
	6ZsoOQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe68wudry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 22:26:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so9220029a12.3
        for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784154366; x=1784759166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPE9hDY7OVlCjZI5zzGvMOmszedQ4sO74FdAg6irg6I=;
        b=F63Hi9NpYAfxcN76JzXlLOVmaCt3A0nUp1TFEBXT1w15O+b0sBz2ZuZpI3yWFt1gds
         7b/lNT/py9o4kmGLSHKUVn9jyt0YDWeVqNXvmKQzOM9TB7Iz8J8HUMDzNfPwOzsoMwER
         iOVSCG4AmduaEdiJD8mj0cyuJf08gebvAO84Bs0VtjqN67gLHb1c+C96B2AT633eGoFr
         oBx6HXKIoxe1c3LsVIeNfMppsrDT8t5Vix7Xg5qDW7y5axxf1mZVdHNV9AIUohgw9Qd/
         jn4jzbfDwtWbXsS4BTuAZqbMyiX6esnEh4fIdn2tI+MCT7JRlu9FEMNX+0v67xvX+T6D
         tcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154366; x=1784759166;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPE9hDY7OVlCjZI5zzGvMOmszedQ4sO74FdAg6irg6I=;
        b=KqFz185FXuQ8xGrREk7yTNfPIt5fU28ip11fTHzaqh/ZOwGU46x0MqmH6VKAZOZqe+
         IRfE8wMPU/w8Ry/ZLoEG/l1qyMDi5gD6aOunx62ZJ5n0W6YVh1QWGCXAfzbB6tkoLteO
         U6l3Eo9Rg0VyIW/+sZeH8Kp+pHWyJYbDNgldU2uHX09BlRDb0I+frMDyoPbZfSzfxJZX
         e1QbfDgH28kmYrUqgNwrojz6ooIrFEzbwSsyRmnnn47QoSFHj0CCqegLyk4Wmfu+A0/a
         WoRmsLsWkBTlAIWpslC6KOBKaJQoQiA+ZD+igVovpQZzOWND/CXGP/8TPOK7+QOu3gtz
         NiAw==
X-Forwarded-Encrypted: i=1; AHgh+Robi1XsmPAVoTsFx9TxoNQDtK2Xz4NI6ANcgqSaWhYQARQiKSDAFW/ZGMwxb85Lg/nOEHLQFpss1P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGig1NHKmkbSRrxP6CLf/w9TAR0kvTXGG1zRmivaR264qvjNb
	JuC5dPj0iNzVAkwCloExUBqRDMJYPWfZvonQ+S7B6/qE/2BgGR5fbpuzuRahuOyCTyMaW2LwNdK
	vyr3WUkTGwMYZy/Eb+s4GOM6gWZC775ETRtIEexXqJ6XjbnyHULo86azPRytBr40=
X-Gm-Gg: AfdE7ckNRv1zTcfNpoN9nEmKRLfjvHoS7HeVyV5Bna3MVQyjcmHqALzGDaKL/hH8sRf
	Qi7NXmK2xDbxXrcs8fZMOx8m4jtta8XL6tC/8JsmNPLKGLS67PdpiGBlyVY+2wTRSafxDJEUlAP
	aAF8i3kWqpPxtvpAJSRgfjVbdJm7ZBhC+z9lnPlLvgJauHZcgE+4LYbTxnOmsMikOyTq8jHd1s5
	UESSNQtNexH2g27pSRt4NjujpkDflL5+25LMz8ADPSz2b03t8TUqfHTy8UcO3PcodTQ3/jpEpaT
	Obel4uy+aBzt1/kuHhIMrsSNNsJVQpfH6NK+me/QOKwYKiYfi7gQUl5FYjPmXWVX1Tp9Se3PbNg
	0RAT48HAVV0IvEnVErNs3aLiBSArt3IOM41SlHwT/2/gc4UgNvr+qsuoT
X-Received: by 2002:a05:6a20:9183:b0:3bf:d62f:44e1 with SMTP id adf61e73a8af0-3c36c35d250mr5223451637.53.1784154365921;
        Wed, 15 Jul 2026 15:26:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:9183:b0:3bf:d62f:44e1 with SMTP id adf61e73a8af0-3c36c35d250mr5223421637.53.1784154365394;
        Wed, 15 Jul 2026 15:26:05 -0700 (PDT)
Received: from [10.71.178.173] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd428b2d3sm4015017c88.5.2026.07.15.15.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 15:26:04 -0700 (PDT)
Message-ID: <115d2157-d4d2-4897-a9c8-fe42fec0bbf9@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 15:26:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: Enforce CFMWS memory type policy at decoder
 commit time
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, linux-kernel@vger.kernel.org
References: <20260711003341.2602368-1-mayank.rana@oss.qualcomm.com>
 <61531e60-0171-4d7e-b61b-ac0790a38ede@intel.com>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <61531e60-0171-4d7e-b61b-ac0790a38ede@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: W6Fkv32oVscyiqwnO3tlaKHBUnva9eh-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIyNCBTYWx0ZWRfXxmJYPEMO19bV
 XtnzLVXGwzvZdv6s+jV0FddbR2xXZsZq1yGZCLnGbmAD059G5WCVAQUTJlIcYoGihxJaxw6ztvT
 B8CZKoS+0RhL/Kr0uC8rPga/o0RIVQZCYCCtLIBK+tiRezw96Iwpo02DZ0uYuItcejJMFB9MtHD
 JWbC6e1nOr7gTgUdG4yHw3MOob4xhERgQKBFQHCBjgpHj9OeAd+N73Yx796QT3aYh9kvfqohXQA
 N1yZFn8WahoUUjKGOCrjGR/7tviZhgW0CgjLmy0/7jLd2qqmitAHN5f+y9rBf7jgghMGYX4X4tR
 KTf/RrHNoyDUC3CVH62GWegrLq5ANig174yk1RD/7AXX79tebVcQ2td3o5Ndi5/Un+JhjvuhHr/
 bJ+fiiNo/oJ2IfVjuRPUSfSAwino222kgHNeYKX/DBdrkS3qJRcnrbDiLPgQPHlP5pzry0TFFrV
 9yL79RPngTLyApoYuPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIyNCBTYWx0ZWRfX6qMMqZ3rQKzx
 vHlz8hbWg1UgZuwu7CE+CyEOg8H3EG0WhBSCT1wvNnSQgQfLXkEUSxLaSPdsoxzNqPSGOWzYOlM
 w0IPTBdLCErEH2k3TdOhSu7wm7EQQLI=
X-Authority-Analysis: v=2.4 cv=LbgMLDfi c=1 sm=1 tr=0 ts=6a5808fe cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=2aGvtvhTeeNcsLIwH_MA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: W6Fkv32oVscyiqwnO3tlaKHBUnva9eh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150224

Hi Dave

Thank you for review comments.

On 7/13/2026 8:47 AM, Dave Jiang wrote:
> 
> 
> On 7/10/26 5:33 PM, Mayank Rana wrote:
>> A CXL Fixed Memory Window Structure (CFMWS) in the ACPI CEDT table
>> carries a restrictions field that describes the memory types a platform
>> window supports.  cfmws_to_decoder_flags() translates this into
>> CXL_DECODER_F_TYPE2 (HDM-DB permitted) and CXL_DECODER_F_TYPE3 (HDM-H
>> permitted) flags on the root decoder.
>>
>> However, nothing currently prevents a caller from committing an endpoint
>> or switch decoder whose target_type conflicts with the CFMWS policy:
>>
>>    - A decoder with target_type == CXL_DECODER_DEVMEM (HDM-DB) can be
>>      committed on a window that lacks CXL_DECODER_F_TYPE2 (HDM-H only).
>>      A dual-capable device will accept HOSTONLY=0 + COMMIT=1 without
>>      asserting COMMIT_ERROR, silently violating platform policy.
>>
>>    - Symmetrically, a decoder with target_type == CXL_DECODER_HOSTONLYMEM
>>      (HDM-H) can be committed on a window that lacks CXL_DECODER_F_TYPE3
>>      (HDM-DB only), again violating ACPI CFMWS restrictions.
>>
>> Add a check in cxl_decoder_commit() that walks from the decoder's
>> assigned region to the root decoder and rejects the commit with
>> -EOPNOTSUPP if the decoder's target_type requires a capability flag that
>> the CFMWS window does not advertise:
>>
>>    - CXL_DECODER_DEVMEM      requires CXL_DECODER_F_TYPE2 on root decoder
>>    - CXL_DECODER_HOSTONLYMEM requires CXL_DECODER_F_TYPE3 on the root
>>      decoder
>>
>> required_flag is initialized to zero so that any future target_type
>> values not covered by the if/else-if chain leave the enforcement check
>> a no-op via the leading required_flag && guard.
>>
>> This makes the CFMWS restrictions field authoritative for memory type
>> enforcement in both directions, regardless of individual device capability.
>> The existing COMMIT_ERROR path in cxld_await_commit() remains as a
>> secondary safeguard for devices that cannot support the requested mode.
> 
> Can you please trim the commit log? The AI generated verbiage is excessively wordy. A simple and more to the point short log that conveys all the information would be appreciated.
ok. noted down.
>>
>> Fixes: 3e23d17ce198 ("cxl/acpi: Use the ACPI CFMWS to create static decoder objects")
>> Assisted-by: Claude:claude-sonnet-4-6
>> Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
>> ---
>>    - Initialize required_flag = 0 and use explicit else-if for
>>      CXL_DECODER_HOSTONLYMEM; guard enforcement with required_flag &&
>>      so unknown target_type values skip the check cleanly
>>
>> Changes in v2:
>>    - Extend enforcement to cover both directions: HDM-H commits on
>>      HDM-DB-only windows are now rejected in addition to HDM-DB commits
>>      on HDM-H-only windows (reported by Sashiko AI review)
>>    - Generalize condition from single DEVMEM check to type-dispatch
>>      selecting required_flag based on target_type
>>    - Update commit message and subject to reflect bidirectional policy
>>
>> Testing
>> -------
>>
>> The bug and fix were validated using QEMU with a modified CXL configuration.
>>
>> Two test-only changes were applied (not part of this patch):
>>
>>    1. QEMU ACPI (hw/acpi/cxl.c): CFMWS restrictions field changed from
>>       0x0f to 0x02 (ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM only, without
>>       RESTRICT_DEVMEM).  This causes cfmws_to_decoder_flags() to set
>>       CXL_DECODER_F_TYPE3 only on the root decoder, simulating a platform
>>       that does not permit HDM-DB.
>>
>>    2. Kernel (drivers/cxl/core/hdm.c): init_hdm_decoder() uncommitted
>>       endpoint path changed to force CXL_DECODER_DEVMEM unconditionally,
>>       simulating a dual-capable device (supports both HDM-H and HDM-DB).
>>       QEMU's cxl-type3 device reports CXL_DEVTYPE_CLASSMEM and defaults
>>       to HOSTONLYMEM; this override exercises the DEVMEM commit path that
>>       a real Type-2 or dual-capable Type-3 device would trigger.
>>
>> Bug reproduction (without this patch):
>>
>>    # cxl create-region -m mem0 -d decoder0.0 -t pmem
>>    created 1 region
>>
>>    HDM-DB committed silently despite CFMWS advertising HDM-H only.
>>    No error or warning in dmesg.
>>
>> Fix validation (with this patch):
>>
>>    # cxl create-region -m mem0 -d decoder0.0 -t pmem
>>    cxl region: cmd_create_region: created 0 regions
>>
>>    dmesg:
>>      cxl_core: cxl region0: mem0:decoder2.0 type mismatch: 2 vs 3
>>      cxl_port endpoint2: failed to attach decoder2.0 to region0: -6
>>
>>    The decoder's target_type (2=DEVMEM) mismatches the region's required
>>    type (3=HOSTONLYMEM) enforced by the CFMWS restriction -- commit blocked.
>>
>> QEMU invocation:
>>
>>    qemu-system-x86_64 \
>>      -kernel bzImage \
>>      -append "root=/dev/sda rw console=ttyS0" \
>>      -drive file=rootfs.img,index=0,media=disk,format=raw \
>>      -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>>      -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M \
>>      -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
>>      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>>      -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>>      -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
>>      -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
>>      -nographic
>>
>>
>> drivers/cxl/core/hdm.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 0c80b76a5f9b..127a187cdadb 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -802,6 +802,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>   	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>>   	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>>   	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>> +	struct cxl_root_decoder *cxlrd;
>>   	int id = cxld->id, rc;
>>   
>>   	if (cxld->flags & CXL_DECODER_F_ENABLE)
>> @@ -834,6 +835,34 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * Enforce CFMWS memory type policy: reject commits where the decoder
>> +	 * target_type conflicts with the root decoder's CFMWS restrictions.
>> +	 * - HDM-DB (DEVMEM) requires CXL_DECODER_F_TYPE2 on the root decoder.
>> +	 * - HDM-H (HOSTONLYMEM) requires CXL_DECODER_F_TYPE3 on the root decoder.
>> +	 * - Unknown target_type values leave required_flag zero; skip enforcement.
>> +	 */
>> +	if (cxld->region) {
> 
> I don't think we should gate the check based on whether cxld->region is valid or not. Can you please take a look at core/region.c:271:cxl_region_decode_reset() and do something similar to acquire the root decoder by walking up the port hierachy? That should apply the policy check unconditionally. I would also suggest putting this entire block in a helper function.
will refer suggested API, and rework upon this.
> DJ
> 
>> +		unsigned long required_flag = 0;
>> +		const char *type_name;
>> +
>> +		cxlrd = to_cxl_root_decoder(cxld->region->dev.parent);
>> +		if (cxld->target_type == CXL_DECODER_DEVMEM) {
>> +			required_flag = CXL_DECODER_F_TYPE2;
>> +			type_name = "HDM-DB";
>> +		} else if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
>> +			required_flag = CXL_DECODER_F_TYPE3;
>> +			type_name = "HDM-H";
>> +		}
>> +
>> +		if (required_flag && !(cxlrd->cxlsd.cxld.flags & required_flag)) {
>> +			dev_err(&port->dev,
>> +				"%s commit rejected on %s, CFMWS does not permit this memory type\n",
>> +				type_name, dev_name(&cxld->dev));
>> +			return -EOPNOTSUPP;
>> +		}
>> +	}
>> +
>>   	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>>   		setup_hw_decoder(cxld, hdm);
>>   
> 
Regards,
Mayank

