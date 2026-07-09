Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F730E84A
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783634654; cv=none; b=gO6+jWKqGnkGuG5Dt9W3y+EhxD9id/dAeHlZPXGGAIjWQRfSdUL0ghdfoTqNSRh9N4xeoqWZvx6Kb5qPNM2nz85gND0Z3xDw/HhyGXzexkPO+nSyBHPvcg0cDj6gDkoTwv2IYrfOq8y0ghkwSYARB5ClKsI6cMjxVQV+Jvm8alg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783634654; c=relaxed/simple;
	bh=iPj4WcX4+OX9Rikgdp71m08tb5Afi5Ai1tOdSzgPOGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8qDltS5S6W8ltTs6r+iTAxtbnDRWzfkhwAyMtg9HJY0x+v5wZzq/5PAfYX6lFii3AiwJefWH1iiNgcvpnNeMZSltvrYehd9HMMAEW0fKSp+J/gO+v5DSmjvErw5mloz1dJyzR55cXqsrHKs7XP8p1fl01xeupZDUrJTJB2pxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fI7T/fPq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GF1Bf4kM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fI7T/fPq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GF1Bf4kM"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669JUpd82557051
	for <linux-cxl@vger.kernel.org>; Thu, 9 Jul 2026 22:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oliFN6INLRWkchr9o0ETL54bVAB74aP+d4p6eJYDfiU=; b=fI7T/fPqRx4DSNFy
	K3SP23qfxO22CgF7/w5RH6TeKivdYJQN1zrw+9O9X7dW91p7MFjb5wPYOPLnWJku
	Ib8++e4vv0bG1gyeZtVJjFdKimNiCoe7Th9AzyQdvlGhjl2jB//GXd0u1O6HDGUg
	xnE0uIhCVHCfEsH5EdUwjMlhzqS2hwzgG8PPf3+C6gQAvb5rQpcz5AtHMt9Z/39B
	rqN4Hfaiuwfwheqc+JcjdwdryrERwX21cbYAUKmjsX9oM9iZr1RvfFS7vzkBJ0m3
	ZrU4EaLINDoAFqcqgHaI0p2bGMPFMfTe1164N3ZvzIrSjJA9uJcnUmhDsbfr2cJf
	vjJTJw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8ggem-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 22:04:11 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84870e7f498so223189b3a.3
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 15:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783634651; x=1784239451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oliFN6INLRWkchr9o0ETL54bVAB74aP+d4p6eJYDfiU=;
        b=GF1Bf4kMLK6r7vYrEYqHhINkqoG8iySXsHlxpbQSJDYRA/xK89tDU6g7wO09k5az2K
         YI+lWIjm8I0RaYRQC2yfmEnqh4Vgceja+IZv2Kxk4v9kpFGWi05PG79I5jqTh+lrv6DC
         rg29h/CjCP6ooa1wZCLqji67OdL6xi5vVq0SFDM+tRWz6mTEy6qSMgBEl7FD6rhAMauk
         y/d6Hk1cUTp1fyl7bUw7kBnv6NvLCwMmshIeRl5vaqbnM4Pm0/cXNIkOKEHl0qSnzFn/
         xjKrNXPWFYhiXA7tnNIr3T70VCvCQM0bkCZQB8KsXJ5m55PhdLezzAoQa0gHRI6VRk0W
         nk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783634651; x=1784239451;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oliFN6INLRWkchr9o0ETL54bVAB74aP+d4p6eJYDfiU=;
        b=Ca7WET+o1aYaNSZVXGvv5xij9SfX4Sqr7boUO/KpSLx0BZKL/bZvRSURclu+JwqwEE
         ejWR0JC/7akbEX9xq/eobm2cOahQc3XE1A+j3L3vNFV5MVd3HMf/hsBetWiqvwXVQuaf
         glad7H+TMcEWKBxwV4NxTJTAFOCjd1122qqWIp5fvjYBpFjfseBtRUOIBF0A8j4xTAMa
         EWe8n0KN6ME2fFyMnjMDe5rpLyJ2dfnQbj1y6LHsyM/yMuh4naboqW1v8hBJhfZFsrge
         Fhs2qjQHNVdA7QZS6kKKIQ2Acm9DTvth23Kiw39dspPXDlKSRyvw7i5M87MIZJhGh2Kl
         XV3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrhFRVSPyn7cwKNgW/2GZ2ne8652e7LGqRBJMv/zFUVmsP67vxfuHsoVMejLzRZsqrIDBovzqM8j40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/IT3XrQksKN4YeYr2CUyhGxrBHfhGG45kO2EJShskReee/pM
	nfwFFNwy5Lv53sSmzZpOvdqDPb2xCd7JInFBfUb22kc+EmrG22KHRpyUKTfpdsCz0Z8uOdIlP0p
	tK25amCrIS6byr0tPwySArzl2+SCClLDdC+3NaKztjERKqNerhFV3QVyaf/j7/8k=
X-Gm-Gg: AfdE7cmVv5Wt5r7aDwpS9KQhXxvoNc9GMzM1xf4MQRt25GFph0Pr36ISc0KXHtUlU7F
	Fz4IX2D+jm4UjkHGR+A/MrxIgbsBKyw+X2h6X/2EaMc2zvEctnC8NimSEbu6nsa4A1A0IFWfGPH
	HXMWJqdciZ0ZfTXMJZ+zUpaa3VmApXYOH+4FgfBGvwv3Ahm8pLd418HKTLD0OCrEMufhkRFye6l
	aIz4FKB4moCwTBcq5Cp43wu9nQ/1IkYZSChAq9c1pKZFambFsSKhoQ136jaCe6CSDrFQtVmrrZ3
	wDOyBZE11x3RMWVIAWg5vbtPd/YbBNASi+ji0HXWVo/yvPhtoTI+uBZXpdSHgper1C+qc+6C8rP
	AurEsazfUgiGTYryWX1eggQ93Y5PLc1h8hzaQn9hr3fqb6Ats18ie8XF67FvHtkrU6GM=
X-Received: by 2002:a05:6a21:a8a:b0:3bf:a412:ca11 with SMTP id adf61e73a8af0-3c0bd0fa3c0mr10541603637.48.1783634651191;
        Thu, 09 Jul 2026 15:04:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:a8a:b0:3bf:a412:ca11 with SMTP id adf61e73a8af0-3c0bd0fa3c0mr10541564637.48.1783634650596;
        Thu, 09 Jul 2026 15:04:10 -0700 (PDT)
Received: from [10.71.178.173] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm23994206eec.9.2026.07.09.15.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 15:04:10 -0700 (PDT)
Message-ID: <c5d02b17-b550-4f2b-b9d3-0b227568206e@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 15:04:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: Enforce CFMWS memory type policy at decoder
 commit time
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260709214712.1402933-1-mayank.rana@oss.qualcomm.com>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <20260709214712.1402933-1-mayank.rana@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ibL4wamDHA31sAaUkaUfNrTcLGAvcjsT
X-Proofpoint-ORIG-GUID: ibL4wamDHA31sAaUkaUfNrTcLGAvcjsT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIyMSBTYWx0ZWRfXyoppDg5wkVpy
 2nBJ5emkcv52KDe/V3UqnBQQs2TWIrpXhhatONQBVro2+Qzi0tDLy8CIz1Z6xnuegLtU12bPttK
 11iOSM/Z2v+EO3aAZyuBKGmTfg/e5vI=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a501adc cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=98GTowGNucI4IdNpqSUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIyMSBTYWx0ZWRfXw3F7lGVMYzpf
 f+K8g2xCbFDGakvCgZux+jzwmSz3vO0VHS/hsV9guco+PMB0FM/xSMqqNCsS9REszQvX0+1tA+D
 omD+m8aNtS2uZEh7jVX76ZTNjCnqvIL8b2sx57HOzvImOZhCgrsPb5Qq6q/kJp3V1Ym7g2iWbTw
 A+Km6y5ficXa/dtWsT8ADnH5160SfXjVDxVHIZRl1KRdr8ekPp1GTuVNzteNVnCwflQxmtp/f4r
 luUkCV3kJbLg0m6tRUVNYO6SmuUGqGveY8oWkSNbz6ENqIh4ZURu2d85l/W5kM4hL67K+DGvP/T
 HvZbdXuC5cUCR718A65mXJ7tiKs+J3O99Ucmb0aMIeVccSg7TZMGeQJbe5vpNyTMevq6OqT0/KG
 rhLd8VGXivYBPElAPW02ZSRs0lZ5YA8I3vA2+disMDKGr0O+2gx8CY/kf/hRO5ayljS/IjU2/Fl
 G9CmiT6knPa6Bwj8ZHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090221

Sorry for sending this patch as it was diff to previous v1.
Please disregard this patch. I will review again and send update v2.

Regards,
Mayank

On 7/9/2026 2:47 PM, Mayank Rana wrote:
> A CXL Fixed Memory Window Structure (CFMWS) in the ACPI CEDT table
> carries a restrictions field that describes the memory types a platform
> window supports.  cfmws_to_decoder_flags() translates this into
> CXL_DECODER_F_TYPE2 (HDM-DB permitted) and CXL_DECODER_F_TYPE3 (HDM-H
> permitted) flags on the root decoder.
> 
> However, nothing currently prevents a caller from committing an endpoint
> or switch decoder whose target_type conflicts with the CFMWS policy:
> 
>    - A decoder with target_type == CXL_DECODER_DEVMEM (HDM-DB) can be
>      committed on a window that lacks CXL_DECODER_F_TYPE2 (HDM-H only).
>      A dual-capable device will accept HOSTONLY=0 + COMMIT=1 without
>      asserting COMMIT_ERROR, silently violating platform policy.
> 
>    - Symmetrically, a decoder with target_type == CXL_DECODER_HOSTONLYMEM
>      (HDM-H) can be committed on a window that lacks CXL_DECODER_F_TYPE3
>      (HDM-DB only), again violating ACPI CFMWS restrictions.
> 
> Add a check in cxl_decoder_commit() that walks from the decoder's
> assigned region to the root decoder and rejects the commit with
> -EOPNOTSUPP if the decoder's target_type requires a capability flag that
> the CFMWS window does not advertise:
> 
>    - CXL_DECODER_DEVMEM      requires CXL_DECODER_F_TYPE2 on root decoder
>    - CXL_DECODER_HOSTONLYMEM requires CXL_DECODER_F_TYPE3 on the root
>      decoder
> 
> required_flag is initialized to zero so that any future target_type
> values not covered by the if/else-if chain leave the enforcement check
> a no-op via the leading required_flag && guard.
> 
> This makes the CFMWS restrictions field authoritative for memory type
> enforcement in both directions, regardless of individual device capability.
> The existing COMMIT_ERROR path in cxld_await_commit() remains as a
> secondary safeguard for devices that cannot support the requested mode.
> 
> Fixes: 3e23d17ce198 ("cxl/acpi: Use the ACPI CFMWS to create static decoder objects")
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
> ---
> Changes in v2:
>    - Extend enforcement to cover both directions: HDM-H commits on
>      HDM-DB-only windows are now rejected in addition to HDM-DB commits
>      on HDM-H-only windows (reported by Sashiko AI review)
>    - Generalize condition from single DEVMEM check to type-dispatch
>      selecting required_flag based on target_type
>    - Update commit message and subject to reflect bidirectional policy
>    - Initialize required_flag = 0 and use explicit else-if for
>      CXL_DECODER_HOSTONLYMEM; guard enforcement with required_flag &&
>      so unknown target_type values skip the check cleanly
> 
> Testing
> -------
> 
> The bug and fix were validated using QEMU with a modified CXL configuration
> on linux-next (v7.2-rc2).
> 
> Two test-only kernel changes were applied (not part of this patch):
> 
>    1. drivers/cxl/acpi.c: cfmws_to_decoder_flags() result overridden to
>       clear CXL_DECODER_F_TYPE2 and retain only CXL_DECODER_F_TYPE3,
>       simulating a CFMWS that restricts to HDM-H only (no HDM-DB).
> 
>    2. drivers/cxl/core/hdm.c: cxl_decoder_commit() forced to set
>       target_type = CXL_DECODER_DEVMEM for endpoint decoders before the
>       CFMWS check, simulating a dual-capable device committing HDM-DB.
> 
> Bug reproduction (without this patch):
> 
>    # cxl create-region -m mem0 -d decoder0.0 -t pmem
>    cxl region: cmd_create_region: created 1 region
> 
>    HDM-DB committed silently despite CFMWS advertising HDM-H only.
>    No error or warning in dmesg.
> 
> Fix validation (with this patch):
> 
>    # cxl create-region -m mem0 -d decoder0.0 -t pmem
>    cxl region: create_region: region0: failed to commit decode: Operation not supported
>    cxl region: cmd_create_region: created 0 regions
> 
>    dmesg:
>      cxl_port endpoint2: HDM-DB commit rejected on decoder2.0, \
>          CFMWS does not permit this memory type
> 
>    HDM-DB commit blocked with -EOPNOTSUPP as expected.
> 
> QEMU invocation:
> 
>    qemu-system-x86_64 \
>      -kernel bzImage \
>      -append "root=/dev/sda rw console=ttyS0" \
>      -drive file=rootfs.img,index=0,media=disk,format=raw \
>      -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>      -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M \
>      -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
>      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>      -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>      -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
>      -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
>      -nographic
> 
> drivers/cxl/core/hdm.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c26dab185dc8..127a187cdadb 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -836,14 +836,29 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>   	}
>   
>   	/*
> -	 * Enforce HDM-H: reject HDM-DB if CFMWS lacks CXL_DECODER_F_TYPE2.
> +	 * Enforce CFMWS memory type policy: reject commits where the decoder
> +	 * target_type conflicts with the root decoder's CFMWS restrictions.
> +	 * - HDM-DB (DEVMEM) requires CXL_DECODER_F_TYPE2 on the root decoder.
> +	 * - HDM-H (HOSTONLYMEM) requires CXL_DECODER_F_TYPE3 on the root decoder.
> +	 * - Unknown target_type values leave required_flag zero; skip enforcement.
>   	 */
> -	if (cxld->target_type == CXL_DECODER_DEVMEM && cxld->region) {
> +	if (cxld->region) {
> +		unsigned long required_flag = 0;
> +		const char *type_name;
> +
>   		cxlrd = to_cxl_root_decoder(cxld->region->dev.parent);
> -		if (!(cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_TYPE2)) {
> +		if (cxld->target_type == CXL_DECODER_DEVMEM) {
> +			required_flag = CXL_DECODER_F_TYPE2;
> +			type_name = "HDM-DB";
> +		} else if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
> +			required_flag = CXL_DECODER_F_TYPE3;
> +			type_name = "HDM-H";
> +		}
> +
> +		if (required_flag && !(cxlrd->cxlsd.cxld.flags & required_flag)) {
>   			dev_err(&port->dev,
> -				"HDM-DB commit rejected on %s, CFMWS restricts to HDM-H only\n",
> -				dev_name(&cxld->dev));
> +				"%s commit rejected on %s, CFMWS does not permit this memory type\n",
> +				type_name, dev_name(&cxld->dev));
>   			return -EOPNOTSUPP;
>   		}
>   	}

