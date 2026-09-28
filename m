Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1523397339
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589706; cv=none; b=X/tRq4SFRT1cP9p4265GS7qQE+wldsd5bYJmXcubcNwYdbhcecDBIA8jYYQjFVNJfC4jK51jz4PjLxir2GhqWQX25j8Yj+7IJIbZ9IFL5zMXw+kt2OPYzCsP+qwEHDehEwAsb+/yQN4RqTyU+jG8TKj/Kht7jgTWS9ewO/mAHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589706; c=relaxed/simple;
	bh=26AY0cLvLZAN0d6uuC7CvPN8sINkdSl35xd+Cdtjg7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptKTuHL8qR4/hMOVSAsNGMcgwfOEmTjD9N/x694psEbq+59RUL3mXxPIiF8o1IraWITnOs3p5aTTUGc7L+BYIbde00ho6ww4ujsls94W/XhMwK9zDl2BVVXoaLJmriK76tXTIA3IB4MTasm8NEWLbhjTjJoSuLuEucvKq3d7kZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JbfMW/VN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ae0qzHXm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JbfMW/VN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ae0qzHXm"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9M6E0246041
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 10:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TTwVBtxb7McqT+5+Byo4PYnFhMV578s9mn98FJl3OYg=; b=JbfMW/VNQt8Ii1RV
	loIGbQ+mTmlqWTXFxi64EF4Odgvif3pou/Zr5/sMV6RLr3jPPqyIzvtDeT73lPQv
	g3bL6HLw4YearXnkLYTIpwRFZEul9v3GmJM20zZrSmsEaGTAxNqFyhxYMyIXZ83a
	hVMOhM3MI/DXERbZUtdHf7uqUnfwwHXxsvodIYk8Seofhq4WxP/EoeWg0foPNpJU
	+sz2cKY7BCLF75tUMSoXvkMjFxt3bluO2bQHBCeBdsmL05VdFnZyaRI2yqugZ8Ad
	Oj0p282EIy/+zHKAbhS/GC0wgLRPah44OvpDRKOg3lhk/acfvcq7T8m9JKDNiUJQ
	ncffSQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt10umw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 10:01:44 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7b54c746641so198291137.3
        for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790589704; x=1791194504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TTwVBtxb7McqT+5+Byo4PYnFhMV578s9mn98FJl3OYg=;
        b=ae0qzHXmfzY7iRnXlMZ5l2E15Xz036wYHwEMaLej5+q+dGXVU7XLBTN+RtgjnmqQ4w
         z9IpIUNQUMUne5JdGCRM4R3ro34P8YkgNNJXQwbCi4dDNMm5TaSCguS4B2ZDppPgwZJD
         UJPRv+6P81WuIUgyi/QIZnzjss2TlZTKpyj7CSdlOOKCoQZS87bj2JXuTNCcw268/Csp
         PTkEqS/zBkKuPU0aCLzu8CxKh9bZwiDCL1AjoUg/3qO5RTqT07dVSEtEpazDy8Z+4C2a
         Qqp33W7HTzz4ILYWKL81Dc5V2Lh3pPn6I2C5GsJK2PunLtP6dPGK2TwORfbUbbOlAUHL
         OLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790589704; x=1791194504;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TTwVBtxb7McqT+5+Byo4PYnFhMV578s9mn98FJl3OYg=;
        b=xeEwr7Zfh4AnmIkTIpbzgZdLQ2FOwudPujR9y43E+Qx5DVoCA1/4uw7ug8uwwrBuzW
         2WdsCynhFzDnvlDhiKRzCIFBo0tpyligBIMl3RVXPTKUFrBGvBuidf9rDyxYx4xJcjXx
         /KFPKb66Ou1DIBFHBOyDkooqGTW5SqXFpUi2/OfwpFo8m198kz7h1UkUhPt3G9pZZRX7
         /Jz7DOATfipii38wrBpsRGxO8E3OM4AoEDyGJAXOqYZhOtT+J0RUCU53A3c+QxdwLId5
         9n2K8MCG7tEHphrH4E42hs5rsWOPpJXT5Yu0opSk20ScBoFZ60ygREJulT3np571GZIx
         nQlA==
X-Gm-Message-State: AFq9FYLhYgpEvXX4r6Xv7wvl41TaFQWKXG1zpDp9ZV8uPYctFiDVO5jM
	LKu/F7Dqz55iAZorYlnzZtMHb5Sm830T4LBfxS+55xyNUfF+TYluz8FsxXqxGwdOCtN2IWLKJkJ
	PrN77BLYInpWNF+FAvJgJrEib5FE3jV7Qcotp1+d8dN/9v0PXM0TLHmB+L3fme+Y=
X-Gm-Gg: AYBFou0aQhjGlLalNJ8TTFtKJcNdPIe9XPL2SqEDuPiNBXD8NPzHSVxYwgfwt6eQNkU
	Hsc0KqA8Ecgm1j9nRbkC3ucJ8RrF146R3dhKBSAWgqPalb/TEr7BxxIpjwT6DyPsBYxg+WlrMrf
	WBYk3oxvSLWIYXtb9iSMMPqI81izLLAhijUdB+bcEZDwZOUTD7TrDXDG4Q1d3mEIqLc10aWIIab
	xQqx/akfiGrSrDl/LEVeXLkYhRW3p4VfkJMM3nM3iHQZeoOgW0dfIGudMGUNOLmIsqXSM9uGEqD
	eVByUOFCGdfAQW27ucxsgNzPgWN0jOPoDbKxfa05BPLRAhc7V13r0p2lSJod/euc3fCGO4a+g66
	+UjtGMz9hwpHQJYuaVX8R9oeVlG6IVyVdCA==
X-Received: by 2002:a05:6102:c03:b0:7a7:196a:84e6 with SMTP id ada2fe7eead31-7b390445334mr1291642137.30.1790589703616;
        Mon, 28 Sep 2026 03:01:43 -0700 (PDT)
X-Received: by 2002:a05:6102:c03:b0:7a7:196a:84e6 with SMTP id ada2fe7eead31-7b390445334mr1291634137.30.1790589703066;
        Mon, 28 Sep 2026 03:01:43 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff21c38a4sm137451295e9.2.2026.09.28.03.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 03:01:42 -0700 (PDT)
Message-ID: <07f12ce6-0d93-47ae-8b2d-e18b60ccc914@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:01:41 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/arm: remove pci-bridge/pci_expander_bridge.h
 from virt.c
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        qemu-arm@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Anisa Su <anisa.su@samsung.com>, Jonathan Cameron <jic23@kernel.org>
References: <20260928095646.3555447-1-berrange@redhat.com>
 <20260928095646.3555447-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260928095646.3555447-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXzG3VmgIrslG0
 2T+Nqbr7Y/xlJg2Jurg1IcIURJpnU1K63pNBhWCAoJUjVnAFA7RrDBLbLAV+mK4ZAZ8Zq2VuqSr
 5+38w2cwl4JVnGOj8s54ruhfyGkT15jjwSeRtlYZ31UhJ8T9JL5F9ks5HYbGrDpA1UPDr5ZYxGo
 V53qTPv0uO0LYHUd+tPFm4le7mcEbaPuaVhkbfQKUSPRRAAwf6hE/7GKlriqI3bJbMYDhAxvmXo
 RV4Tzrwg653pqVhUONXb8XfSsXfqyZMhb7/W4l0OKWlEUqFhrqH4Swar4gKIRmkVjikETKBd2tn
 DuIbs2OdSs4os76M7r3NghJSH3s7wB76uA/84iT8YxN7IdYtwRW0TgNUAz1cQUGfJ/M7oOtQNbQ
 FkCqQstvXegm8u5WLQ51YBtcqDCYqmnjb6m/srs58cRpULd6P1mjy57J13vCecQkGGY+Ovb7Gxq
 TgEMsn1U6on4MgyDskQ==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba3b08 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: eUQ-s600R7Dajm_VwYBl-uSNFUfh9Bi-
X-Proofpoint-GUID: eUQ-s600R7Dajm_VwYBl-uSNFUfh9Bi-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX96BDHCGzLVYG
 sQGMujIcvvdfLJd6HkSO0fSNDbtT51RedO+RqRm43bvKdP813p689bw6avZ0SqVFm0AxfP8iVn3
 W7Y3OoTNYE29eJzMIDlpT0AjWxkJLOI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039

On 28/9/26 11:56, Daniel P. BerrangÃ© wrote:
> This include is redundant as the function is declares is not
> referenced.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/arm/virt.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
