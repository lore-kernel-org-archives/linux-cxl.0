Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD1E449B33
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589820; cv=none; b=WAvKOvWojXG2dRUfpiNtoOJthEIFvQ/wsRnr1PVfr8hzYfcPYvebGGVzOJg64iKN4E1laJRivAUgl/WNCigtuEr+V7fkOtWNIngHcjgiG+jFvLgqCM/NdOEtZR7MWkBSN+t0UgpN3GRMo4hbQutWOKp1FJSzFWwOo7rB1Fv4MoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589820; c=relaxed/simple;
	bh=nlQZW+wLZKIHea8WlZL1GF4BpE7tI7VA37Br0OMgzsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ohg8sFi27/v1eDSbfo4zf02ZUh5troSvidUNl6gXL78qpPI9yjVyOEvFObso9AUDfvBGdv6sGN/9k5Yvf777ziqLRCrJk0aGsf9CQOXSFDWdMz6CU6iQWQnAvy4d2HGB8p+AKYm6TJNRzGBzPaLhk8Iskti3XruTqIWJ4q/maoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e81E70sh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Um/3JdKy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e81E70sh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Um/3JdKy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9MLDk322870
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 10:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1xSDbn3cZFdnXvdFkKOC/kwamch70uFmA2Vgi07Oy0Q=; b=e81E70sh/lim001w
	tLykIACfUSchFrYn0895EwbHVa+U9NYPGOocVuErKXnZ0fnidiL9yeVwIQPcBef4
	I/cAB4j8/15KP5dn/NJjR0K3KA+sD0QddjKE+VsD4z0JbLMKJ/cRzQ3jhFLfxqXT
	UhCaCETIJ8IusN9wJMfrYV6BbxcGlodZvkDFwWK6Uur1lbZa1uKZ0hQNujJb5qCS
	Cqkz1tp4XbZwxb7l4E8vQy43ALt4JdN3Yh2hchYaPqsWmzxwvf0We0EBlsxMmO84
	Jb+cCZuhvEC5aTPijDpaSULwOCihOspDDtJyN12pGgmBwSoj0nOT2tNQSsQZGYjC
	IVHN8g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1mkg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 10:03:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5cd17531bceso347229e0c.2
        for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790589817; x=1791194617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1xSDbn3cZFdnXvdFkKOC/kwamch70uFmA2Vgi07Oy0Q=;
        b=Um/3JdKyYqku4DGZWOjAsjfHI16Gr2ML6+w4Ss2Q0a3HpX9G7PhsgwJi4rbbpfhfw4
         pOvWrO8cOOjlTFgrBqwCgmHY4lrHgSgZM6C9KTUhLj2qHH6iUycWyIeajHhlhsMpBMP6
         l7GcKHEzZveBb5ca31eU4Pu8UArG1sJ1s7sklLjw8zZiCbI5WNZU9/MkNWbhLg3jqYtk
         6OraElNojeAzdkQ2FayMG/vz0HuoBfKRJM7zj3qutfiHMNn6eDrEpCwrbGY+QNHW8WTP
         RQcofRALPlQGTCCx/zABg4S8HP9/91thlzKFiHGzci7txslMfiR3JySrI3xIJcApbyFQ
         ncwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790589817; x=1791194617;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xSDbn3cZFdnXvdFkKOC/kwamch70uFmA2Vgi07Oy0Q=;
        b=L/kOkJx1qASh/P3L2l4L31ooUAaIa0m7P2Gc5gZQK7Oyb6WfXL/7WKLg1DuEJS+gUA
         3ZO7xenjvmQEYVqWXiX8EgLv5E+uG2cRvVYc+3K1VR9AG42vOuU3HybmEkeFC44z/eBO
         MTBlMobBIPNoPP11g/qIhdfMyJmR8pvQ92k0444M6yL8jtzlQ0tikfdznu90YJYs0F66
         NZz5hlqufUB3tG5A4sBEf/uMfuBHvT7znW+g7zkQ1kAtPwZ7EtntvISRhidqymg8ku1v
         xb41/u9w/jjKtFs4hJ1y7W74S050fxq0NObobMcYuzL3C8X0jrsRl+FzKMw5+xObzgJC
         jNPQ==
X-Gm-Message-State: AFq9FYKjfRoX7+QVKW/BTGusBC5f/T8CNEj1EKeoGRvd/Hcd7+zqAJ7y
	fz2sKFpN/odrN0LjKWieZm3+uW19tx7brtSJ3zC+bpaBr9I3C/DZV8rEhEC0rtZAQgcOQ2JJZdi
	lvj/2d1h8/VEtBbUwgLGXslA5H7vSXBx+sm01PXCkmAgn6TGriGeG0VNRC0p2LtQ=
X-Gm-Gg: AYBFou2PpIDKhSTSSTA5yMjPDkEHTDKTvGEW62pd+xI3l4t7Fk6gJkmR4XSU584jBCm
	PNooapPlSY8DqivxaJT9Cogy8y/uy/UZJBeaZCOvEvlY2l2JPKal36KmxO0teCFI/8LSsbZc/0m
	bz8zxmGJ3RFwqGb4tDPgHEtQZ4TyByYe+C1T9oaiYeM9rLO5K5FhMVrtkMQUJrNJI/IQb2gjGip
	EaJNZIlvMv76AhUNlgseebhA4rehaw6HHfgo0C0WcwIGbjrMNBCfmO7KuSsSmC8D24JYIjB46Fj
	yZXDl+PrK0ck7zBikmHXIg6XghRcamaLnm47/rwmDu5WNj40AINy0NT6XSAaLxUYZR92RVmaeqQ
	V7opakRIVJ4D8P6lIn0imDgzE97EXDKa2Aw==
X-Received: by 2002:a05:6102:148c:b0:7b7:4b29:ffc with SMTP id ada2fe7eead31-7b74b298d0amr515801137.14.1790589817253;
        Mon, 28 Sep 2026 03:03:37 -0700 (PDT)
X-Received: by 2002:a05:6102:148c:b0:7b7:4b29:ffc with SMTP id ada2fe7eead31-7b74b298d0amr515794137.14.1790589816773;
        Mon, 28 Sep 2026 03:03:36 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff21d6209sm132228685e9.4.2026.09.28.03.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 03:03:36 -0700 (PDT)
Message-ID: <a28df37c-b0cf-45f8-9aca-d4cf9877b6ae@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:03:34 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/pci-bridge: split CXL PXB into separate file
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        qemu-arm@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Anisa Su <anisa.su@samsung.com>, Jonathan Cameron <jic23@kernel.org>
References: <20260928095646.3555447-1-berrange@redhat.com>
 <20260928095646.3555447-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260928095646.3555447-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hWaKU2CoNfzna6kHrMfkf9nKcxmiatBG
X-Proofpoint-GUID: hWaKU2CoNfzna6kHrMfkf9nKcxmiatBG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXwIYitz8jZNvy
 5ArWnoYFkLd2He6f1Z/9HykW75QWO5iqsNZBOZzo5SMtE2TFDlM9fnJdyOlMcnuJ8bCuBcyp5gb
 arHRTAJ1rUGg4FigX5KC0+45Vo1zJoc=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba3b7a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=g-K3LgQ6wbbBXodtW58A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX4uzIiww7kUOc
 lrF+qe4zE+ttXljj0qzBUhPAnmcw6gCpszxDhXQCXe7VPl6Hp976ejjH3rvUomrdMYODj97qu5o
 1n6UmoPE3Mc97D612v/awn/VtWFaksf2s6Ye1P6Sxm3Jj5c2Gj8r+IePuJegHhaI3ylYdygEALp
 EyI27S91tuTsLuZ+GrO1+MaDIgFcZfmb/UyC5w/sgyyVt++KYNq1Z9y47FEneho6+gyMWMkaDt5
 tBRVoCKr15XGSynfWa7wcIO4Ex7maIi0U7DFWs3+hWxJLoUMfvX/DLXI+A6n8Niwr2eJbRdnLiT
 gAl2eK9nYxfDTOhKzsdTCcM3OhvYMoEUOvkIdVDh5Z+a2xxxvWrmJyiMdIsN7ctkO0Ak2veJ34b
 3zza32MDAofJNRuDumDSqO5NlZ2t19TzkSwmrJu1JQKbpL/iosmsWOmEaJtyEhNA0fXSqORp+37
 rvO6hzrWJfpfyann8jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280039

On 28/9/26 11:56, Daniel P. BerrangÃ© wrote:
> If CONFIG_CXL=n is added to the Kconfig, the build fails to link
> the PXB device:
> 
> /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_realize':
> /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:202:(.text+0x330): undefined reference to `cxl_component_register_block_init'
> /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_dev_reset':
> /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:309:(.text+0x768): undefined reference to `cxl_component_register_init_common'
> 
> We cannot use CONFIG_CXL in pci_expander_bridge.c because the
> identifier is poisoned. Instead the CXL pieces must be split
> off into a separate source file which can be conditionally
> built.
> 
> With this change, the stubs file is no longer required, since
> the code referencing the stub was already protected by CONFIG_CXL.
> 
> Fixes: 6e4e3ae936 (hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142))
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/cxl/cxl-host.c                             |   2 +-
>   hw/pci-bridge/meson.build                     |   4 +-
>   hw/pci-bridge/pci_expander_bridge.c           | 194 +----------------
>   hw/pci-bridge/pci_expander_bridge_common.h    |  29 +++
>   hw/pci-bridge/pci_expander_bridge_cxl.c       | 201 ++++++++++++++++++
>   hw/pci-bridge/pci_expander_bridge_stubs.c     |  14 --
>   ...der_bridge.h => pci_expander_bridge_cxl.h} |   0
>   7 files changed, 242 insertions(+), 202 deletions(-)
>   create mode 100644 hw/pci-bridge/pci_expander_bridge_common.h
>   create mode 100644 hw/pci-bridge/pci_expander_bridge_cxl.c
>   delete mode 100644 hw/pci-bridge/pci_expander_bridge_stubs.c
>   rename include/hw/pci-bridge/{pci_expander_bridge.h => pci_expander_bridge_cxl.h} (100%)


> diff --git a/hw/pci-bridge/pci_expander_bridge_common.h b/hw/pci-bridge/pci_expander_bridge_common.h
> new file mode 100644
> index 00000000000..fc5d1ac8691
> --- /dev/null
> +++ b/hw/pci-bridge/pci_expander_bridge_common.h
> @@ -0,0 +1,29 @@
> +/*
> + * PCI Expander Bridge Device Emulation Common Code
> + *
> + * Copyright (C) 2015 Red Hat Inc
> + *
> + * Authors:
> + *   Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +enum BusType { PCI, PCIE, CXL };
> +
> +typedef struct PXBBus PXBBus;
> +
> +struct PXBBus {
> +    /*< private >*/
> +    PCIBus parent_obj;
> +    /*< public >*/

We updated our coding style to not use these private/public comments
anymore. I can remove them if MST is OK to merge via hw-misc tree.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +
> +    char bus_path[8];
> +};

