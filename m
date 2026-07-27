Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F493CFF6F
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134493; cv=none; b=ayDlaF/bm4galSV8viAVE4sQuh/eXwyUBudRdz7JfV/oOPm0GIJ2swQ/62ZVSrvO7/RUh4DlIj5gKFMITPm3023zRkiP9UOsGeAp7nWivO/zdVpYOP/+G7I7aD6dfMMMsXyDi7y1Ck/Qr9i0uYm4Feir778CLczGTa11M8NzJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134493; c=relaxed/simple;
	bh=buWQ+7s5yxIpot2UG4szRWvLx7aPQGnIG80MZOyZac0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0WAumPyBaVwN6NyN2yNqQHdjC+E4gCBPFNRfISwAiFrDdXlMUYGJhXuvrAiWmJDDnOtuyPxBSAlB9Kx3hN2k5bTHUmp1HgmRbm6XRNinb7l4DhLpDj22QIp2v6ooqCa24Sc4Z+unPBneUb6bwJMcDDhiNo8SHF/KLP0IhOOg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PCFChmy+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4rUxSDe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PCFChmy+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4rUxSDe"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1fq5s2137825
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 06:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CLfTJ+AUmXoN1iLtFR3opWLp3SOwKPoN47tiw5eKqO4=; b=PCFChmy+O3NrZBtX
	IYEor4aOCsQL3emlVuVJkbKWXmfEIEFrtJQYa8PkREsiq8N2TNgL7gSdaH+B5pa/
	MVEv/cRTZ4bJuVRUDaY6c4oerwn9K8mH5KQDxxtjXhjItL0GP/ThbRrn19pIB7bI
	YxQZz5nabGdhUPJbR3mzAjyAHTlv8cxwGNTDFRJz/AuAtDtHQBHgbdTCd3Hde/kf
	4Ci4HlaSzdV3WykTdPStPd3Fo0iRQ6lMXnlk+bsfdoL6+lO2Us1Tm+Xde0qFuUGb
	/Yp+E70Pm68GkcDkByMxcMNxRCxETLsgTPIoXDVRokLELa1HuC1iVpJS1QYLLeML
	45EzoQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmnh7vtxn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 06:41:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5283df62d68so27163341cf.0
        for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785134490; x=1785739290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CLfTJ+AUmXoN1iLtFR3opWLp3SOwKPoN47tiw5eKqO4=;
        b=Q4rUxSDejPXRH5b4uTxu/GTndMRfL4FD3pySpB7slz4vNNUAighuFf6ufxff5IfptL
         90SwfFqzWA0+BzjLM4dLS7FJeoMIFnIDFcuWR0cPJpg4ocncnQRkS0DmJNiBvvDgcGp4
         bqGTmg+aRzXPDQm8EQQ/nBJ9yhYDHTo0XifvfbZpesgbAsl0PkeEJWVrB2S1qt2O9hfm
         tZeS0ThclrcysKjPNkIqBEz2jCFxFs5LPkS4ao0C/cLSyG/CZwykUAj5TkWUzEH/xHOB
         wap1pwGk801ZnH83hjj3745rIx/cn7ygepkNEsGg3j1sZxyxQnNPo6wvpoBlavDSHihs
         /VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785134490; x=1785739290;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CLfTJ+AUmXoN1iLtFR3opWLp3SOwKPoN47tiw5eKqO4=;
        b=BmIgYx+iN3m0MrL02Oiv3VubVXo/H0K9m9sQuhu6wOpNuTsgWRQeom2ENRbuHJSZfU
         ZeClIS4R34MsLqLE662e65Z0OGuL+mGa19+n3fNfMeei8yF0L4JyrAl7ua1aAXHygpgv
         +UcffCyxPVqNYStc/BpdBZzBX/wAPqreR534hlSMtiO7bIwGQ2CR47Ivn+y2dNrc5XE5
         S50Bo6qaNeSVTTEQNCFD4xihD+8mrLEymTAf0NxtADGeEqzAluXOhEJyxmR3rZ9HZ5Lh
         i5IMYMsPomZo6jFgNbA3vvEPwM1rq9YyGUIyWuOjLFCHki3dK/YRUYB0OjdZSCImut+N
         G6fQ==
X-Forwarded-Encrypted: i=1; AHgh+Rore8mntcPj3CZjU+GgDty0smcL21gRQ9/iEbYjdnlYdpQK8o+jIzmkXxsa/w39wCd0mhV9PhTExiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4x1nY2QV+OAk1p849pDifJjEulx09NZcJWbndFZx9TFhAAMuf
	UcMB/JMDvwRHI/M0mqauBUl58JGfuLQxw8jr+tfxNNc4d+9YBDmYdyAnm00j6Nl2uU9dBZYx//A
	m9ixUiFtxZlx1j0uxvritp47tyComRaM10svPMYkmRteunHAxIFivkcwnzBVHPNM=
X-Gm-Gg: AR+sD104RmJZ3cjrixWRrEAUeYZarWOTbe7TOGqgO/0NpqTJOIkSDA+r45MPWzNXmyo
	XSjonMUCDVKkTdK9aNxmne4q7Ej8Y8ynK1+Yq55wQF3Ads8fVCbmXDV7VtxBO4zvNgFSo5AGBXW
	rQI3dgSKfavReUZr4BSAN1OyXs+WFD/exrxiqAoV5TxW8pHDzdszgTdPxc1oB8D1btH2K/+jpB+
	g0PbZdueR/P6kP1hcJjSEsvJNvWDpTGqbAKILlMd+9aULEW6EHqCQruTgPAy2hnT9C7/NGHscUF
	qWM3ViEpGzCWQcuW38kLl1Rx4RyV/cVhZtT7s0C5EY7AeGJvm7zEMRXU/MasObG1SCq/qqGEDzl
	9Ld1ZBioM8f89Uy9f4nWwzY+8EUUuGjPVbzcVcOT7Rmj8U+mwHMk=
X-Received: by 2002:ac8:5844:0:b0:527:2b06:2bd1 with SMTP id d75a77b69052e-529a8715e81mr79406451cf.62.1785134489947;
        Sun, 26 Jul 2026 23:41:29 -0700 (PDT)
X-Received: by 2002:ac8:5844:0:b0:527:2b06:2bd1 with SMTP id d75a77b69052e-529a8715e81mr79406181cf.62.1785134489563;
        Sun, 26 Jul 2026 23:41:29 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm192401725e9.12.2026.07.26.23.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 23:41:28 -0700 (PDT)
Message-ID: <f7e2f36c-265d-4fff-8fd6-31313daaef86@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 08:41:27 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/hexagon: fix machine->fdt leak in qom-test
Content-Language: en-US
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
        linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-4-5c9a6ce7b96a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260725-fix2-v1-4-5c9a6ce7b96a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O2WEqOPYziFPpwXrObtfBuv7IL6KiuOq
X-Proofpoint-GUID: O2WEqOPYziFPpwXrObtfBuv7IL6KiuOq
X-Authority-Analysis: v=2.4 cv=f/54wuyM c=1 sm=1 tr=0 ts=6a66fd9a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=CN8BiiQClkPCgTBgyyEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2NCBTYWx0ZWRfX66LeHiJJjxhj
 o3vHB570S71nidMLCj6AeupfZKqHA7fQwUDEpJOc0IazUJcxNHTBol+PCBsa5NGNRAPohYsy3WP
 eSn9IQAlZ+ZmcxnZiffE85D6kzxme7t6wu1DWHfLh7/N4SfEe8iWbCfbDT/1dTuYhinr3S3Lrza
 pEqf3NvAliaW25BJruL4hfd2VAvQ0KTap/sitP+0ChjxST9BT0+ktsVUKrNecr41GX4rHkmrD8j
 e55Bl5pW8xuYxrS9UjB2XCOLFnTouxXc0B0ft8Dq0LkTX8D2Qnz6jEBuJF5VnqWnQ8IyUhe0grN
 Kujk78vJz0kf7jyAhpL6pQF2AAGguLtufINLk2F0/T6XPcqFukjbSta2Cz5HHSdVHb1idJIwyDz
 Q6uNETcsAXTI5qz8qawj6pd0/5TUybpFBJa1zvRKdyOS/BUGs9e48sLi0/HdpMQ0ysxxkfQjl22
 TcDxNEcug1sA3YDQl2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2NCBTYWx0ZWRfX+Qy0yRiZPwhJ
 igf9FLi3ImpTIdRR6CyMrh+h9MjLexK+LckiIdGJ7XICjGnRTnw0bxB34eGLWmCod3Jzjsk9ffb
 QD5pBtbUYeyCoFBiLmV9bKXvzTJtNIc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270064

On 25/7/26 16:00, Marc-AndrÃ© Lureau wrote:
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
>   hw/hexagon/virt.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
