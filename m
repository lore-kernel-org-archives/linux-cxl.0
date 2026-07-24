Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF64749E8
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934537; cv=none; b=lSYcj+VJli9pQcvucaetttywxqTLj0Uy8rHBn2mLpnoQvqHyg2v16j/RR75MU+Ou47EOsjpX64j8nqUlXc+NlEYZykpf5i6Zd37jKbwxuT8Bgj//Bmo2VjABOpUxmRlkRT1SjfmLOJnma5OurAOiObgttuEGJy6gCMnQZcubm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934537; c=relaxed/simple;
	bh=zzz0lISZNVntjqe+EAErT59dRiLxoNvMxqtjxNNNHgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehspXZwvieFUi6L05OpXUn3n/XY67xqZ5h3eQscZHhQVFyil4q6C2sdANWIv/zfuDn/OOYdyM92pUkCdfpyeZyq3KDP6n4zsadLJYLs6eYOJ9zJosJzatpgjtK0gMraFSLo13GuJRRE4eEQaQ/r00IHiWY8l32jPkMAkbU3cpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqyA4/Mr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UjTqpDy/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqyA4/Mr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UjTqpDy/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OKwFW1167102
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 23:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zp2tfSR+bjxwjoNPBDl5LFXAazKI/qflQFGUbCSQV7A=; b=pqyA4/MrdLWTgopl
	PVab4LJwEeVARuk+OfvsUuVHHQByBfV8hSmZguPC5rkdP++quW9HbFWNl/srotEQ
	UiboXwO7h0c9vRo86r7neTqCjXWITWv4TOJ6NQfY3Jn1soxZAhU0OxKhprEKZYvK
	FV4yazkObOHrv9x+DHdz1v6+20C9Q79+hCtKjre9+uF4SHt4Vmb0Z+oZKrYGXe2O
	CEFa/pakLWYGQ4GnWnBZFCOzWdsTnYicZ7xw4SS5QqkwVdqoFzEvOvCTdbbj3Co3
	1ahE2t8MYMZMetCcCvYDzRUbuPij0fCxY35smNoBrLnn5cmm6du1AUtRc6s8ilwg
	LZB+mA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm9pd1xbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 23:08:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cceabd70f5so21918735ad.1
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 16:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784934531; x=1785539331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zp2tfSR+bjxwjoNPBDl5LFXAazKI/qflQFGUbCSQV7A=;
        b=UjTqpDy/mJjGOsb5LbuWulm50Q8xDupbo1GqCybyfZKV1OK+CvbP5KyJEeVAD55dzD
         A578WVVccPws0h0l8SCCB+b3wRnA/PHzkcOsMaVH5q88idBmlWZja1z5MOttqsz1rb3g
         7x3yKnSux5qy+OUicgRTK55mgm0/OzTu5azRW2dOr74HdSFNb2tX1lhT+2fM9MvUXCCO
         w3mg41aAhhlHpXIlyPWnGX/SB5kr9AR3c2aMw/+b3i4WagG1gPqQ6KC3y35LQ+yTSETz
         xGfgHEYtR3Hyg3W3Mj58s7YoYtQU9T6fEgi4Hybsxf9QEUEMudz1/jUQ60uRAcJ+VlMp
         iV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784934531; x=1785539331;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zp2tfSR+bjxwjoNPBDl5LFXAazKI/qflQFGUbCSQV7A=;
        b=A00tDHJakPMRBTwQR/6L+D6FkWGmEfLMjLmMIiQueteWe6b5v6PToqoSGki7xNe6HH
         R1tzRyRazB1r+cAzqQqo3Jm3tmmmkunG2YLIHKY4y0XAbucsGP2R56sKmLDEpkSIFt1f
         TFUKpHtkp9WoanJLfuVqdXc675MiFx0XFBLq5lB5vBIU/oGIQZzpuiP5IRDABTg3iBto
         DGqsI6U1F/CCIHS9RkU6F982sBlnUCiEeJwfMzx12BPYPM+4eeIKG4P7VZNMFkucOfY/
         qpnaclxYlEsblWYlLpzg9K4ouLc2qUh+CMYH/3Tmtx3RvpoGFMIUqqMjPjvPjjf6Jd76
         w/5A==
X-Forwarded-Encrypted: i=1; AHgh+RrGSqXD5qxJz6rYn4xSQ7QuhuWfHpfpSYuGTIsRVgRGGOS4mw8C0GASrLT6mFO2FUP3kMQJMWWzwp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTmBpZspbKOKHd9CFvJwhETmvGbI+r9BMMhUz2HLT072UU2dgC
	k3Tpwf9Tm83Td73k28Mu9wzdlWnfyoMjYjCOQC2Cko1FTN8xUnu0XeHhIe88tGGrkTEhnZqZq3N
	KaDAdD96BnonsUefcpF7NL3dz1X0gSdk3Fx6OutMoev+7nn/xzi5J6QLLxWvzHS4=
X-Gm-Gg: AR+sD13BR01pF8Jdub62l/TWdCD1As+7hx0Mp9lJxasto9H763P4OBaSddK7xz/9i5H
	E8fI3Fi9mclXTnJ9bmi1saa4fCAxjBCyCjwIOpQD2WH96b7L9/0pPXCg99iE6O0e1/S2xXiPlpT
	xDbeiQO9MYCyFruhqQIK0kL4i9cSbz9JmEAeMm+7ROJ/zvjKKVn5n4EgDt6dr1eNK6u2ZjfnDl2
	OZwQ4NHkCfiUm/uHnFkyjIxYZnVpLuHDAv9Uo0O9feOEd65jY0bf+F5IJpmjOoBV0Cm57UNR6CP
	qaSzLnVAXoPHOyOCp6ACQHOs9+wrDvREAOLqEGI4eMxjSLQSkR2OMi4Kb98gJkoPb6AuLhUaiDL
	uKg8k2CYwOnHbAjkiTkmln/qPX67dbw==
X-Received: by 2002:a05:6a21:6817:b0:3b4:8bc6:138 with SMTP id adf61e73a8af0-3c67da72a1dmr346149637.23.1784934531403;
        Fri, 24 Jul 2026 16:08:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:6817:b0:3b4:8bc6:138 with SMTP id adf61e73a8af0-3c67da72a1dmr346121637.23.1784934530974;
        Fri, 24 Jul 2026 16:08:50 -0700 (PDT)
Received: from [192.168.4.47] ([76.167.171.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc584433sm2956074eec.23.2026.07.24.16.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 16:08:50 -0700 (PDT)
Message-ID: <eba0e451-3d8f-4426-9033-373e0ac9a440@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 16:08:49 -0700
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
 <115d2157-d4d2-4897-a9c8-fe42fec0bbf9@oss.qualcomm.com>
 <41540b44-8142-4b80-b876-0ff3f7ddd619@oss.qualcomm.com>
 <e3021037-f674-4974-adbe-eb7564f0c4b4@intel.com>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <e3021037-f674-4974-adbe-eb7564f0c4b4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: geyRnxrCGXhYHfq3pMGZZ2NggwJ1xD7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDIwOCBTYWx0ZWRfXzJbBKDARk/EZ
 8cGeZTZuX9/RK33czVS/BfxGupi1teraiSXE1/K6P+3KkK6EKrb/rmm26Fv+KLvHOXsw3q7QlA8
 d6/KNZ+blPZ1wbaOgBg9jiFyz7PWWDZ8pDCFVhcKyrw2B6m+mBkkaAAmeSv/FlbkS1F5PpUJz3q
 WetEO4gg9D1UFFwiK6M3CyGBr73GWkdcFoZR2DWNB0PFISkKX0f7zYtybgrmLsVSCix5ceS+caX
 5GV5QabKqIfmunfrP/cpP92D3BbZ8bSzi6DuVrplZ7e+bGVagtam/Iuz18r9Cl16xa3hvL2luE2
 lmsoLVnmALAVqUfjofPhy2taMPy9sXO7/M4wMQssE6QcooLd87Itdf60Be65GbsTzX9WthB2KcT
 YFz/9Gfaq+YtXlFp9E7VLfSYYtz5nKU5mmjHDZs/YVPT+Wqu2CJXA/Dn4lM+YQjjBXksehbhsPv
 C69oUVn05MpwVyVNNHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDIwOCBTYWx0ZWRfX70A4uc37Z2FX
 2wHcz5Zkqtl2zRCihx64R1vaKvvOq4qXBatX158pSI77DkEe/YTGHTKzT9xSpNWDqeuk1j+MMgI
 hjvwIV6HpkC1c4Opg4hH9XQWmNpN67Y=
X-Authority-Analysis: v=2.4 cv=DLW/JSNb c=1 sm=1 tr=0 ts=6a63f085 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=aHhNPKUfMHGsajXC+q458A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=qlVHQRLn26njG4ZrRUEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: geyRnxrCGXhYHfq3pMGZZ2NggwJ1xD7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240208

Hi Dave

On 7/23/2026 4:47 PM, Dave Jiang wrote:
> 
> 
> On 7/23/26 4:18 PM, Mayank Rana wrote:
>> Hi Dave
>>
>> On 7/15/2026 3:26 PM, Mayank Rana wrote:
>>> Hi Dave
>>>
>>> Thank you for review comments.
>>>
>>> On 7/13/2026 8:47 AM, Dave Jiang wrote:
>>>>
>>>>
>>>> On 7/10/26 5:33 PM, Mayank Rana wrote:
>>>>> A CXL Fixed Memory Window Structure (CFMWS) in the ACPI CEDT table
>>>>> carries a restrictions field that describes the memory types a platform
>>>>> window supports.  cfmws_to_decoder_flags() translates this into
>>>>> CXL_DECODER_F_TYPE2 (HDM-DB permitted) and CXL_DECODER_F_TYPE3 (HDM-H
>>>>> permitted) flags on the root decoder.
>>>>>
>>>>> However, nothing currently prevents a caller from committing an endpoint
>>>>> or switch decoder whose target_type conflicts with the CFMWS policy:
>>>>>
>>>>>     - A decoder with target_type == CXL_DECODER_DEVMEM (HDM-DB) can be
>>>>>       committed on a window that lacks CXL_DECODER_F_TYPE2 (HDM-H only).
>>>>>       A dual-capable device will accept HOSTONLY=0 + COMMIT=1 without
>>>>>       asserting COMMIT_ERROR, silently violating platform policy.
>>>>>
>>>>>     - Symmetrically, a decoder with target_type == CXL_DECODER_HOSTONLYMEM
>>>>>       (HDM-H) can be committed on a window that lacks CXL_DECODER_F_TYPE3
>>>>>       (HDM-DB only), again violating ACPI CFMWS restrictions.
>>>>>
>>>>> Add a check in cxl_decoder_commit() that walks from the decoder's
>>>>> assigned region to the root decoder and rejects the commit with
>>>>> -EOPNOTSUPP if the decoder's target_type requires a capability flag that
>>>>> the CFMWS window does not advertise:
>>>>>
>>>>>     - CXL_DECODER_DEVMEM      requires CXL_DECODER_F_TYPE2 on root decoder
>>>>>     - CXL_DECODER_HOSTONLYMEM requires CXL_DECODER_F_TYPE3 on the root
>>>>>       decoder
>>>>>
>>>>> required_flag is initialized to zero so that any future target_type
>>>>> values not covered by the if/else-if chain leave the enforcement check
>>>>> a no-op via the leading required_flag && guard.
>>>>>
>>>>> This makes the CFMWS restrictions field authoritative for memory type
>>>>> enforcement in both directions, regardless of individual device capability.
>>>>> The existing COMMIT_ERROR path in cxld_await_commit() remains as a
>>>>> secondary safeguard for devices that cannot support the requested mode.
>>>>
>>>> Can you please trim the commit log? The AI generated verbiage is excessively wordy. A simple and more to the point short log that conveys all the information would be appreciated.
>>> ok. noted down.
>>>>>
>>>>> Fixes: 3e23d17ce198 ("cxl/acpi: Use the ACPI CFMWS to create static decoder objects")
>>>>> Assisted-by: Claude:claude-sonnet-4-6
>>>>> Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
>>>>> ---
>>>>>     - Initialize required_flag = 0 and use explicit else-if for
>>>>>       CXL_DECODER_HOSTONLYMEM; guard enforcement with required_flag &&
>>>>>       so unknown target_type values skip the check cleanly
>>>>>
>>>>> Changes in v2:
>>>>>     - Extend enforcement to cover both directions: HDM-H commits on
>>>>>       HDM-DB-only windows are now rejected in addition to HDM-DB commits
>>>>>       on HDM-H-only windows (reported by Sashiko AI review)
>>>>>     - Generalize condition from single DEVMEM check to type-dispatch
>>>>>       selecting required_flag based on target_type
>>>>>     - Update commit message and subject to reflect bidirectional policy
>>>>>
>>>>> Testing
>>>>> -------
>>>>>
>>>>> The bug and fix were validated using QEMU with a modified CXL configuration.
>>>>>
>>>>> Two test-only changes were applied (not part of this patch):
>>>>>
>>>>>     1. QEMU ACPI (hw/acpi/cxl.c): CFMWS restrictions field changed from
>>>>>        0x0f to 0x02 (ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM only, without
>>>>>        RESTRICT_DEVMEM).  This causes cfmws_to_decoder_flags() to set
>>>>>        CXL_DECODER_F_TYPE3 only on the root decoder, simulating a platform
>>>>>        that does not permit HDM-DB.
>>>>>
>>>>>     2. Kernel (drivers/cxl/core/hdm.c): init_hdm_decoder() uncommitted
>>>>>        endpoint path changed to force CXL_DECODER_DEVMEM unconditionally,
>>>>>        simulating a dual-capable device (supports both HDM-H and HDM-DB).
>>>>>        QEMU's cxl-type3 device reports CXL_DEVTYPE_CLASSMEM and defaults
>>>>>        to HOSTONLYMEM; this override exercises the DEVMEM commit path that
>>>>>        a real Type-2 or dual-capable Type-3 device would trigger.
>>>>>
>>>>> Bug reproduction (without this patch):
>>>>>
>>>>>     # cxl create-region -m mem0 -d decoder0.0 -t pmem
>>>>>     created 1 region
>>>>>
>>>>>     HDM-DB committed silently despite CFMWS advertising HDM-H only.
>>>>>     No error or warning in dmesg.
>>>>>
>>>>> Fix validation (with this patch):
>>>>>
>>>>>     # cxl create-region -m mem0 -d decoder0.0 -t pmem
>>>>>     cxl region: cmd_create_region: created 0 regions
>>>>>
>>>>>     dmesg:
>>>>>       cxl_core: cxl region0: mem0:decoder2.0 type mismatch: 2 vs 3
>>>>>       cxl_port endpoint2: failed to attach decoder2.0 to region0: -6
>>>>>
>>>>>     The decoder's target_type (2=DEVMEM) mismatches the region's required
>>>>>     type (3=HOSTONLYMEM) enforced by the CFMWS restriction -- commit blocked.
>>>>>
>>>>> QEMU invocation:
>>>>>
>>>>>     qemu-system-x86_64 \
>>>>>       -kernel bzImage \
>>>>>       -append "root=/dev/sda rw console=ttyS0" \
>>>>>       -drive file=rootfs.img,index=0,media=disk,format=raw \
>>>>>       -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>>>>>       -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/ cxltest.raw,size=256M \
>>>>>       -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/ lsa.raw,size=256M \
>>>>>       -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>>>>>       -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>>>>>       -device cxl-type3,bus=root_port13,persistent-memdev=cxl- mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
>>>>>       -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
>>>>>       -nographic
>>>>>
>>>>>
>>>>> drivers/cxl/core/hdm.c | 29 +++++++++++++++++++++++++++++
>>>>>    1 file changed, 29 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>>>> index 0c80b76a5f9b..127a187cdadb 100644
>>>>> --- a/drivers/cxl/core/hdm.c
>>>>> +++ b/drivers/cxl/core/hdm.c
>>>>> @@ -802,6 +802,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>>>>        struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>>>>>        struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>>>>>        void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>>>>> +    struct cxl_root_decoder *cxlrd;
>>>>>        int id = cxld->id, rc;
>>>>>        if (cxld->flags & CXL_DECODER_F_ENABLE)
>>>>> @@ -834,6 +835,34 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>>>>            }
>>>>>        }
>>>>> +    /*
>>>>> +     * Enforce CFMWS memory type policy: reject commits where the decoder
>>>>> +     * target_type conflicts with the root decoder's CFMWS restrictions.
>>>>> +     * - HDM-DB (DEVMEM) requires CXL_DECODER_F_TYPE2 on the root decoder.
>>>>> +     * - HDM-H (HOSTONLYMEM) requires CXL_DECODER_F_TYPE3 on the root decoder.
>>>>> +     * - Unknown target_type values leave required_flag zero; skip enforcement.
>>>>> +     */
>>>>> +    if (cxld->region) {
>>>>
>>>> I don't think we should gate the check based on whether cxld->region is valid or not. Can you please take a look at core/ region.c:271:cxl_region_decode_reset() and do something similar to acquire the root decoder by walking up the port hierachy? That should apply the policy check unconditionally. I would also suggest putting this entire block in a helper function.
>>> will refer suggested API, and rework upon this.
>> Thanks for the pointer -- I looked closely at cxl_region_decode_reset()
>> and want to flag something before sending v3, since a literal port-walk
>> doesn't fully replace the region lookup here.
>>
>> cxl_region_decode_reset() doesn't derive the decoder from the port walk
>> alone: it's called with cxlr already known, and at each port level uses cxl_rr_load(iter, cxlr) -- keyed by the region -- to find the decoder assigned to that region at that port. The walk finds the *port*; cxlr still finds the *decoder*.
>>
>> The reason that matters for this check specifically: a single CXL root
>> port can host multiple root decoders, one per CFMWS window, each with
>> its own restrictions. A pure walk up to is_cxl_root(port) would tell us this decoder's SPA range originates somewhere under that root port, but not *which* of its root decoders' CFMWS restrictions apply -- only the region (or the port's region_ref tracking, which is  also region-keyed) can disambiguate that.
>>
>> So v3 keeps the region-based lookup (cxld->region->dev.parent ->
>> to_cxl_root_decoder()), but addresses what I take to be the actual concern -- silently skipping the policy check -- by making the check itself unconditional instead of gated:
>>
>> if (dev_WARN_ONCE(&cxld->dev, !cxld->region,
>>                         "commit without region assignment\n"))
>>              return -ENXIO;
>>
> 
> ok sounds good
> 
>> A decoder reaching commit() without a region assigned is now treated as
>> a bug (loud WARN + rejected commit) rather than something the check quietly steps around. By the time cxl_decoder_commit() runs, the region assignment has already happened during region assembly (cxl_rr_assign_decoder()), so this should not be reachable in practice. Also pulled the whole block into cxl_decoder_cfmws_check() as suggested.
>>
>> v3 to follow shortly with this and the F_DEVMEM/F_HOSTONLY rename per
>> Davidlohr's BI series.
> 
> Davidlohr seems to indicate that with his code series, this patch may not be needed?
I review proposed Davidlohr fixes, and seeing that cxl_region_attach() 
will prevent this situation. Agree, this patch next version is not needed.

Thank you.

Regards,
Mayank>
> DJ
> 
>>
>> Thanks,
>> Mayank
>>>> DJ
>>>>
>>>>> +        unsigned long required_flag = 0;
>>>>> +        const char *type_name;
>>>>> +
>>>>> +        cxlrd = to_cxl_root_decoder(cxld->region->dev.parent);
>>>>> +        if (cxld->target_type == CXL_DECODER_DEVMEM) {
>>>>> +            required_flag = CXL_DECODER_F_TYPE2;
>>>>> +            type_name = "HDM-DB";
>>>>> +        } else if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
>>>>> +            required_flag = CXL_DECODER_F_TYPE3;
>>>>> +            type_name = "HDM-H";
>>>>> +        }
>>>>> +
>>>>> +        if (required_flag && !(cxlrd->cxlsd.cxld.flags & required_flag)) {
>>>>> +            dev_err(&port->dev,
>>>>> +                "%s commit rejected on %s, CFMWS does not permit this memory type\n",
>>>>> +                type_name, dev_name(&cxld->dev));
>>>>> +            return -EOPNOTSUPP;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>>        scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>>>>>            setup_hw_decoder(cxld, hdm);
>>>>
>>> Regards,
>>> Mayank
>>>
>>
> 

