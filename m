Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BD23C3432
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786616; cv=none; b=oUU4ETDpUkVFItWp77s4uJ6b4Nm3MAZuNyvUL3F9Lm2qqSRDpZl+4Mq4HYEluAM9xGUGh3Ctkjd2QkAjxucUlZNqvC9NP0Oia20P09rApfMSe8OhRy42p087sOtdplG2LannGoctkiO9Phf97/t68b2qGvdzsWtkz0ge3h6UN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786616; c=relaxed/simple;
	bh=Mv5Dv0BX1Tn7H4sAvnpwQqDc/+CwzLwcGA/Zzs+i7ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9y2ksuNMwTFTWof9X6uhk/n405H0eMmdIPvPwUtfhHcwjV9Znj0/cCVyYmjl3zdITAKgTGFWC2RZIsOVDKPYPHlWgJXAuOTf/vcbW7fo1Px6YS+eP9r04CZOJgxUR9abyLdTbF5Kfiyg5rxaX1YjLjolzBnW8duVD594Pn/Rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7Poq4HJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kxPeYCt1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7Poq4HJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kxPeYCt1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N4vQ2J2850553
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 06:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7keMzPCxl7utQPpc2pLfDXAilcSK1raT403Yfw93ii0=; b=d7Poq4HJKISYMxdm
	5O/32Axjor1ficHyMI+yI8W2w3EULCSGmfRv/ipdHIh0w9HNKisQmVDCinRLMe2/
	8iVgvRt0fsSwkqcB/S2S0iZl8PRTyEram58aUBg+KiQy+XxMhzv6TodFbEAIK0sw
	pD9wmFl4ZjV1P7zRonlr+9xnzhmXJt39Xeloj2u0Vu79NOMYG6h9/40+oAHYHoWy
	JwTwsbMnG4Xo+wchEx0vR5IZQdWIki1xVUdfmnL1chbByBc6FBxZqxuGNla1ETvZ
	8dDNjqoTGFw+5P4lyy6inpc94yypmQ832A6sjGgCeTH9rt1j9W6C10Fkcelqh+mE
	oi3dLg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk275jk62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 06:03:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0f0a0760so8757211cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 23:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784786613; x=1785391413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7keMzPCxl7utQPpc2pLfDXAilcSK1raT403Yfw93ii0=;
        b=kxPeYCt1MBKInvWSu3qHiyw6ZCnz0PuBOiDtcWJ12tlSdlCkiqpBrBwpKPJ5Q9n0/E
         voFksrbMN/zohg4L+sU05bYyhhiBpNlcdnJTsZc/zaPQIMaCy4isKTb/FjoQmJCNuEDc
         YHWB6Ota9OVHrwVfCsHxORSQ78RIQdQjJk7Crm8XNeAdYWEE73ofEDVc6etMXc5Qmi/J
         vA3vEqzavWyKxOYTAnGcc37dcjjdmx65rReaK+anu4zOMWt5sUf1dfu7GBWxzrwjEaQW
         mJ3lXosic/8jujSL9jg8gNQ0L0/YRwjpr++mD8qo392onmXoSZeDE10xeZnCGU/MJpln
         2lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784786613; x=1785391413;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7keMzPCxl7utQPpc2pLfDXAilcSK1raT403Yfw93ii0=;
        b=XP5S30E1UBkQo8Q9CZ/1TwfeP/Q9kPIG6TVyF4T04OX6m1pQbSTKIztNqy5/ZAA+mq
         N+MBB20JlCdO00tHtoYYx3X3VoDq5QYsPs9PP8hhQYSkRl8QF8cUarz/PdoRMl/85NT9
         plAalFJiVEiXF5M0SDS8/wOgpGGIGEBktOzNzwqm2lBsOB+yZrdc9YiiCGLIqxNUzcc/
         KxfSGX63xMBNUnU+zuqwdAP4n8jFnGpZXiG2M1mU5GaumH+Pl5VEA7yrd0lozo2dYkTQ
         09Xdodqe3sdv9nyVGXI93wHFu6Kll16Vjxdx1uCUsB+v/Nqscf6zL55lwUyooPF1VHiP
         8Uuw==
X-Forwarded-Encrypted: i=1; AHgh+RoYY1hvwtNs/fzISmhAhONk65xM2QpThWtyNDZ8Eq5SYb0ROyJx5Re58utfMBzaUpCYlPLJDUu8rlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYbMqk4XWT3bBFuqv+O5KGKfU/clIjdJDxYNskJJCDD5TLNfU
	JNT1Z0/x2lzLR3qTfP99tRXlSPHWbZbijHiRwmXPX3DFmO4OIe/bRKSFneC42BayaG3wrDSfEzt
	NM2SS/VkFVcaUUsdQi+vFITIPTtmBbY1HcHw8Tw/8nh1xLXVdkbyHmptP6cYk3PY=
X-Gm-Gg: AR+sD11H24H+DYuaNIKLXyqYALPtPh10W19HxHhE+hcjKoSjuaxz0hI3La4TMmqoHjt
	im5Chy2XkQSte85Xr3WjNhSXEQB7szfk3XxOmCDX3Yk2leRDcaLVWFNZKJYg2lMq1kuQJBRg56H
	jsAElP+FUdOnkKjT0fWAOzcarCK2L1YzoVYwVZqk1pnLks5eoyWTuN5RSkntlv9GaHtXdESWzvg
	gFrOJL++bxbPgDwZL1JAoa24atScbkJYXU5TZxNlcgizfOfiQFEampRPQLquFqH/ztWY6y64nEh
	czKNDiiGc8xgyYtUfZxD0aZ4POo67ZMvXmAacdKKY16Is9wrFyYPcZ4cLy+vfKq9qyq3iV0OFsp
	wyBhjp1c72tlOllXiOcONu9QLnHqnv3s5iGxSKwS4ZDOGKmalDtA=
X-Received: by 2002:a05:622a:1c0d:b0:51c:7b11:419e with SMTP id d75a77b69052e-5283df78e1amr15704021cf.75.1784786612923;
        Wed, 22 Jul 2026 23:03:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0d:b0:51c:7b11:419e with SMTP id d75a77b69052e-5283df78e1amr15703811cf.75.1784786612505;
        Wed, 22 Jul 2026 23:03:32 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f25b6sm114370025e9.2.2026.07.22.23.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 23:03:31 -0700 (PDT)
Message-ID: <3e349615-c5fe-4571-bfc0-683b37126888@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 08:03:31 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/cxl: fix timer leak in cxl_destroy_cci()
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
References: <20260723011625.1117034-1-junjie.cao@intel.com>
 <20260723011625.1117034-2-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723011625.1117034-2-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Q53iJY2a c=1 sm=1 tr=0 ts=6a61aeb6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=69wJf7TsAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=nd1R-Y27xLvYdgTe2jcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA1OSBTYWx0ZWRfX8JtCT2mXV9Is
 tBTatHxUelBdFDba7SGMMtkQ1GzcFx2wmjGZXx1QA6AqLvdv1lsP6Q0i0lEbRH3J+AK1H4qgBkN
 gwHJDYYlMS+QvDQbJxtGAX4xQzLRczY=
X-Proofpoint-GUID: 0IRUgeCgXl00QbzIlCuLej5WxtHus7In
X-Proofpoint-ORIG-GUID: 0IRUgeCgXl00QbzIlCuLej5WxtHus7In
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA1OSBTYWx0ZWRfX+lQnZIHfDbQt
 4KfclH+dcOnQ5/ex/FTqWtVtq1ScELTirH52GGW+VbwD0Os2w+sabKoEsnxLR3ovz+ebDgHPYDL
 j3IhFJd57V7qQZEaBzNwkWXoDicptDZq2UInNKznrWfxySDM45VzPxqEGptqsvqW4Wm62BykWz/
 dDGLZv2n47y1iJ0X5b7RnYRJuKIsvi2R0G80PtwF6xsiA/0MPOBiO6eBQxFAIyFEZJTKeK3rpIw
 9AhO4H0OUotz4E1rlTUFcovpaWV5l0MvzfNxBRGn4OqEmlU0T62C+oz9e35CTyerOKN2xnIQJDk
 c6Rka8hn9/b6MGWCNptCnHp+nX/eerHLfULTpNGujolNcSqB7VHRpRvEBmc660DE4Hxy91attsm
 XpbDZkg9CQGsUh39/2JOdbt9bGx9jFhBF0UOnko/BC+neSRc3UMwY63tfdvGP6ing/SQYJusnt5
 aqZPOTkC4dRjOPhc5pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230059

On 23/7/26 03:16, Junjie Cao wrote:
> cxl_init_cci() allocates a QEMUTimer via timer_new_ms() but
> cxl_destroy_cci() never frees it.  This leaks a timer object on every
> device exit path and, more critically, on every device reset cycle since
> the secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) are destroyed
> and re-initialized each time ct3d_reset() runs.
> 
> Tear the CCI down in the reverse of cxl_init_cci()'s setup order:
> destroy the mutex, then free the timer.  timer_free() cancels any
> pending expiry via timer_del() internally and tolerates a NULL pointer;
> clear the field afterwards so that a repeated timer_free() on the same
> CCI is a safe no-op.
> (The function as a whole is still not idempotent: qemu_mutex_destroy()
> asserts on an already-destroyed mutex.  Callers must not invoke
> cxl_destroy_cci() twice; the .initialized guard added in the next patch
> enforces that.)
> 
> Fixes: 98cbac128f1c ("hw/cxl: Support aborting background commands")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
