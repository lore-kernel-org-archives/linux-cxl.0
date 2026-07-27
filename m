Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0637E5D1
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165278; cv=none; b=G3m4qOptVS+fqcmM9+X0AS5acRh58lAzYG+qhz+YJhcSibUl6e9zOI7hbe0C1DA+IKJVJu5TSqEMEr7IHvZR0plRYNNUFfVr4LrJTAGq03HcftG3j490SghDp1mxdg3upJfWns9unTVRBqFVejliP/k6IjnR9j9ES1ssShbUbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165278; c=relaxed/simple;
	bh=KEBmdNdF00etJ3rtUfQ52D8Uf2w2nmWmjaRCd7nQs+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlGp4ZjqePIySOMwouws9njbv0EqGj298eZ9UErU9E84eORx0el91A1hX1eX3hQ/YFfj/as1Sp+MrnSU151o68lt//lvGgQ3soQUfg7b9nbk0Bhq6FPQAadcoxVJWLyQZxw3mI++pvGs0WU+eRD54bwjJwR54WgkmWiNOa77100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kdTh3e9Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eaqUuRVi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kdTh3e9Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eaqUuRVi"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlrfI3787448
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 15:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DDlh4kO1/iCNr1/HlzAm1sRq4HaEw6b8LhHFtObuOf8=; b=kdTh3e9QBqGfC39t
	weg2EiJ20AnIjsMJBCm4htHOyBOyQHPnhChquumqDbsZpObbfQ+1SrJMx0Ar+5hd
	pcaa2jTyXTLrbO4JAXp5zWtgc9x5/8OnJ/uUds+pbpArKCegLryKVZ9S7chf5aii
	nGIDU3+S6soFEz6YrqfNaj30FlPTHmbY9wb17vG0kYdGpfOrFg5zdnrzuI0lY7WL
	nnOqg4VfQwShEnhBzPHzDNB2G62+UMEVB2VGEyEpApIhjliujmNCcpAWUfVnDugi
	KyWOIlqQFImgE590v+ya6Sh2yUeRRptPMF3coheMSACVmqXOr+NdEbuaZZ9LofdB
	ugsMOg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2hm3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 15:14:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-520a00c7a03so51035891cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785165276; x=1785770076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDlh4kO1/iCNr1/HlzAm1sRq4HaEw6b8LhHFtObuOf8=;
        b=eaqUuRViEc+DskP2mzxJ12lNOgSVWWLq66RWgalgg3foxMs63FxgiORv5VPagtLjN0
         XPLIFhwfwgBEgv9ilGlDZmDjSHKmJD11gAKd6orE2bCr/QUzqpJkI+bPmeUPtU/WKFT5
         wt8ylhoiG0bOc2DnXESnvk/giALXOaQZ3hO0ld7LBUdfes7+CSaJbZOhjSZnAhoZAS83
         Z35HXKfJ3NzOJJfODF545AJM3x7Fud/Li5rbaji9N1y+4glW3WX2HoylmKEwjJ+vjvkX
         kgGgSbHGTtcsfwdUQRwONXLyffx3R54y/k2TFpY7HWB6y3cX+ciIW2GbI5fVVp+K5plh
         wEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785165276; x=1785770076;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDlh4kO1/iCNr1/HlzAm1sRq4HaEw6b8LhHFtObuOf8=;
        b=ee0mSTrL1ZMnmbNjcpRn1LGz3Zq1H174wWPElmhY8aB1iKyKrRDKPRdrscQwVDd0bo
         +zZBhBa8htBaiIgFviUp1bAbtz2qDC4e7jB0H4U/Oz+QWD6lqcmOIr6RDJ4wJIhg55ZY
         kowNf5ve+ZS4VIJX4dIenNWThGe6ejwn1JPJHrbhgciheKQJ+7n/lGuVEPd2AvLwpNHZ
         68Zeas68vpyYXH/NEUs0z1NXdfRP+VAySM8iqaFLUX/upxH7xRk0eNItXwNhKygMdcPu
         4pi7lRLq1y1XoeBEMVnsepMSwIcC8Tup3Zr2g/e/mx9+CoOctU4A3bWIa3IivZe65eF+
         Od5w==
X-Forwarded-Encrypted: i=1; AHgh+Rp2On5qXGbmcXteEcCQHwiwQ6bQu0tBvsvZDgRcmVJr5pYQ/DZ3+nNHxNHVvBJ0t7WVaQLgxGQ/zVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwxqNvYkfvtsZkcdG14RKIX0GG3Y9Qee07T3cLTrDOgKi3ot/
	0tTQd2xwlQ2CFm34E4nVG0BP7p2TFkRmIHxtyJgG026znU71ELBloozqdrxHsFd8P8kTrNE+qkq
	yJZkqzlhCRFNcSlGudrA6olcZpe9rexj8AHDC5UImmBrHHyic4/3zSyl0VQqaqEQ=
X-Gm-Gg: AR+sD12eMl8rMy2eK58agOETjr2bUWAG2wyLgbPmWL5PP9VMOOibQpCn8kD7eXkqEJB
	NZsUmLGiymzpCqjvowU6SEghBFzwgatLPvT6+MAAOSb7234CFR69KnDxRv2VqEtNixyurgHdPge
	ncCvVtnyAZEcLWM3HAFaeznrFMom1ap2EL+DS1x1A2IFj7++Nv8WoMF1ttkGPTjuxG2jtIh2AVs
	L0WQNmoRtJ3kfdX3k7X6YJD8iYCbVGwJ4gbBZ1314rc5shT7oP8/l8vxr3csTtHJ5ycIdNWr8eh
	/etRb2sxEIU8bSXweh/ydVKkhGzJVAtOQmBP+RDSzckXbiA9U/oxiRIxp7ZW6irC0ifBoNswnRx
	Bz0Zu6+zFQEFKinPoEZX3Rj0wz8chD7xeA83Zotp6luOpYn8+4v76HXrVU6dMrakI
X-Received: by 2002:ac8:7c4c:0:b0:528:223c:9649 with SMTP id d75a77b69052e-529a888587amr92406101cf.74.1785165275716;
        Mon, 27 Jul 2026 08:14:35 -0700 (PDT)
X-Received: by 2002:ac8:7c4c:0:b0:528:223c:9649 with SMTP id d75a77b69052e-529a888587amr92405731cf.74.1785165275206;
        Mon, 27 Jul 2026 08:14:35 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a27f68f3sm56829801cf.9.2026.07.27.08.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 08:14:34 -0700 (PDT)
Message-ID: <ca200df0-1f09-4ab4-be20-351286be0cbb@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 10:14:31 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/hexagon: fix machine->fdt leak in qom-test
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
        Jonathan Cameron <jic23@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
        Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
        Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
        linux-cxl@vger.kernel.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-4-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260725-fix2-v1-4-5c9a6ce7b96a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MyBTYWx0ZWRfXxRwt0rqyw8mC
 HkcZtaSKSqLuVIAN6FxI+9cGpdS3tXR0ija2sfCCa2rVJvDNQ4w1brPlmcPn/PMRkSP4ZFUn+u4
 yZyB+xiIg3F+kEcjCygW67Mm4rHg1Tc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MyBTYWx0ZWRfX+ebdYEPg0uzk
 C6FoJQaWw+CAtLw0B0GFcMGqJjOiIK7cdmL8dj3Oqk+P59iAvLpDZGuY4DXpl03Zpr3tKjjHgjf
 IHIL1YaBDMD4xGwrsEwqCRPb9qP187rPuk07lQp8kJ8C1wQsiCh6gKe1IwbxkkR6brog0v6ddKy
 RR7u0FkKSEKt/qG1tki3DsXuhRI5Zky/2U0b1p3+8gXHokA0plOaG39jL4wf1MK4lSUFmjczvt5
 UnwDsS5sFHigU0BC2tLsg0tNu8pD2R4qQ4BOl2sQTPVeg4A2OOcLgHnO5bRukDh4SHw7SH4qUAB
 zJrmM6An/Hk2OViNgHNW+Xr9sqv16KG37HjfHaB+yNyFDS01XkiF9mLfT7H+clsw/obfeE6i/VV
 65CFun/+LJOO3rp4tHX6s/j/JIkdN8SW8qQh8q9PJNOhFW6UepPMM6Cd5eqH+iBtFrks8CDBXN/
 GTXrt5VIGdXQwFYCC+g==
X-Proofpoint-GUID: wCDvFAevRECY_eT68UxsLUbHeiUX5g-B
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a6775dc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=vonYgpfw9pO0NH89MCAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: wCDvFAevRECY_eT68UxsLUbHeiUX5g-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270143


On 7/25/2026 9:00 AM, Marc-André Lureau wrote:
> virt_instance_init() built the FDT unconditionally at QOM
> instance-init time, so simply instantiating the object (e.g. via
> qom-test's introspection, without ever realizing the machine) leaked
> the 1MB FDT blob: machine_finalize() does not free machine->fdt.
>
> Other boards (arm/virt, riscv/virt, ...) build the FDT lazily from
> their MachineClass::init callback, which only runs when the machine
> is actually selected to boot. Do the same here by moving create_fdt()
> into virt_init().
>
> Fixes: 88a8bc7f43ff ("hw/hexagon: Define hexagon "virt" machine")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   hw/hexagon/virt.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> index a3638998b873..b75047250260 100644
> --- a/hw/hexagon/virt.c
> +++ b/hw/hexagon/virt.c
> @@ -175,13 +175,6 @@ static void fdt_add_cpu_nodes(const HexagonVirtMachineState *vms)
>   
>   
>   
> -static void virt_instance_init(Object *obj)
> -{
> -    HexagonVirtMachineState *vms = HEXAGON_VIRT_MACHINE(obj);
> -
> -    create_fdt(vms);
> -}
> -
>   void hexagon_load_fdt(const HexagonVirtMachineState *vms)
>   {
>       MachineState *ms = MACHINE(vms);
> @@ -242,6 +235,7 @@ static void virt_init(MachineState *ms)
>       DeviceState *cpu0;
>       int32_t clk_phandle;
>   
> +    create_fdt(vms);
>       qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs", ms->kernel_cmdline);
>   
>       vms->sys = get_system_memory();
> @@ -341,7 +335,6 @@ static const TypeInfo virt_machine_types[] = { {
>       .parent = TYPE_HEXAGON_COMMON_MACHINE,
>       .instance_size = sizeof(HexagonVirtMachineState),
>       .class_init = virt_class_init,
> -    .instance_init = virt_instance_init,
>   } };
>   
>   DEFINE_TYPES(virt_machine_types)
>
