Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052C13D411D
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137764; cv=none; b=qPjw1LtDs5B27FLFGUXCvtC/sHAvYfJoFqVfw43//v18Xtg6rqd0R1Wp6GSrG+gX3sSIheniAAkBYs+OAAexLtiu7am99femOCEnU6ucuGmNQhKFAaRbp2a6kLQdPDYiwEXGgyuoy+07DSZRtrHstmMJaSRP0FuywVqKiJR9aMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137764; c=relaxed/simple;
	bh=H2IgoZe1SUEieK2I11iz7qDtGUS/NZXz8GkFbB7Nn0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JchhmmP3WGiaJS/w/+L7jAGO5hijZMnQ3jCEJooDDpywZdN9ctgFprTxq9IAS1AdIFaWDgmPGjlYe+k4fmFk5CbaF9IyAGx5/Bx4bNxTIQDhB+s2ru0GckrSA9W1tYn1RSb/ArU2iYzr9NdMh7LFVjXCrR6uNm5knSu1N5pXV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GjKqcG0s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bn4J/EFo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GjKqcG0s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bn4J/EFo"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7SOw62532946
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QJpte5YIDNjq3iAIflT/M62g14G9xuea3VgFhoobUvs=; b=GjKqcG0ssHEfws+n
	WmXcnEhsnUmVKnyFAJShO+zgkcCx+RzTKzwfVz01f9PjUyEhztn4r5Yr1Fz5c0o9
	wV82z3Yfmmi11DoqXYuH6dC3NSxKepDGdJv2qbIfFPaG5nLjDLvpnzSqJyHuJbCZ
	+YFCk37Ca3M/QJ/Vpsf8wOnnwogDcTd/Ym5z0lu70ZUFVIBxnc/1OBqVE7Qkq11j
	sxZ5iVEFw+wdT0dK6ZXPTz6KGJCzZRdjSE0C7Gmk1ke8FlUZgO8UiRNtApXdNkAR
	gK5QJhO56l2c25WOC96SR84AAqtPW/bSwFm6SLksQsRLjHbQqeR/AeNLhbOxafoI
	T1Qnig==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpajmu0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:36:02 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8e934385db1so37613546d6.0
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 00:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785137761; x=1785742561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QJpte5YIDNjq3iAIflT/M62g14G9xuea3VgFhoobUvs=;
        b=Bn4J/EFoTLhgHmyGRinCMuzjiiRrc+jG1vghWdYybkEVPDtDTUrUb1o16z0jiGD5Tn
         jJseJCODLxBOtXyLlpbz8IP+rL6I7HKy1byRaHS+QIq8+HCliflzSFpoaf0XYt/ZJIvT
         9JdqVUHdRzMsCepHJCw2QZ7X9b0FwDgP38Y2K+6jNDhEbetma1MXANBXvo5PAP7mfgOo
         hT9u0uyhzLhP9Q6wrsgybRNI6Qk6fVjr/PppgvfidkrtoTuRDOr3TPJpMc9ptfmHTDkN
         iyW9WCC3WbHu5OKOZyaaUUa7/rmbHkMk1te0r/KIJQkEI1xeyTaGflgWU7h0xfH2DqXL
         882Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785137761; x=1785742561;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJpte5YIDNjq3iAIflT/M62g14G9xuea3VgFhoobUvs=;
        b=OHM2E6PmlPJ9jaWlyKAOG8LHuVB1aofuvDHfM45dJj9/O3bdAylc5z4LeX1JU0BYP3
         lOV5yyDJRCN9IDB5nLJ9PYg84gQZ3yM0CAxcfqu6eZcmDcmEYoipHS7o3vzhVvw3rjxp
         aM14KC73hEc+zNO6trNQjHCkw7jtW3BoUasGWTxv0QMGNingMJjE5xTt5OGxDWrrNHYv
         1MM3gtpbenJMU7lhIeynSWuXoNX3phC9YWV7BWl/pHFX95S0I3XvYB3Nd3mHchnWC5Ww
         QiuNliyj1T7+NT7IBbmIW4FfEVvWgBC90Sg7Q+J8htghmrydU6ei6CiewRR5AZTwS/ve
         aLXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr+N410yD5OAcLRoCpa2Yn3/4nxzfxMrxRoiQrBSBFtM3P35s9yXxcKmiYX+be2OnvnrQ5MYToJ98E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbjIZQVwYk3fquEkQhHNSxYTZUSialIGlkvtMM2m0+nysZ3KuB
	3Q+0C22ie9BG9ECJicYIoSVtDIv2ykCR4jisthsVueIlCI3DRPeFvqcw6AyAKjjfQqtrxVaWhGq
	t9b3R+2Bg0G4MQ2FyLnt4e1qLZ3c0M8yt4c3Fw35kV92QGqoVzy2cb+lJkESIBms=
X-Gm-Gg: AR+sD10vla9xV1cK5FLpXsyLTyTA/71T+P5ZyzRFxhZyfLGDbEEU3Sij6TbQOzA/CpT
	DyOHn2rY5TET0gALE6C6d77m9DI4P7gHGh3E4opidDWjZwui2kdj6XOwtTbouhen7o+U6IYTbky
	54UJrhcDWCosH0jDaqinmggl9XDjHpedn7vB2uCF35KcIP3NLrYaUaTIPCGBAr8d/pUdS7vOL6U
	IbdHgfOZV8K28YVJooY3AWdqL406DmufftfMaNlKqzzzT0AyLktEctSUdkou8NpQvkztt5GudbL
	Xs4uuO9toyZxGTTPWvX1UUCNbfhiq0FZ59lxxDoYOQ8OKP+X1B64nT7tI5lbRgNeje34ko+vFxi
	oPuXBHedr/jGW/a+rNOCEGZ5ksAXm0/oKtGQ8OcsQ0sp44/soDQE=
X-Received: by 2002:a05:622a:28f:b0:51c:8fb:fa45 with SMTP id d75a77b69052e-529a86f86aamr81553011cf.58.1785137761067;
        Mon, 27 Jul 2026 00:36:01 -0700 (PDT)
X-Received: by 2002:a05:622a:28f:b0:51c:8fb:fa45 with SMTP id d75a77b69052e-529a86f86aamr81552761cf.58.1785137760631;
        Mon, 27 Jul 2026 00:36:00 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5ed646sm218249865e9.0.2026.07.27.00.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 00:36:00 -0700 (PDT)
Message-ID: <b5c45dee-1bb5-4073-8079-3435225a48d9@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:35:57 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
        =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
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
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
 <20260726164738-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+fCyazpGfof9H0_n54FMy3LX6ujdmTcW=gAmhFz8Lk-w@mail.gmail.com>
 <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tqvdn7EaSuJqC-pbbiqG-uM-_5cK-gak
X-Authority-Analysis: v=2.4 cv=A8Bc+aWG c=1 sm=1 tr=0 ts=6a670a62 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=8wly15aAkipbUTg-oLQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: tqvdn7EaSuJqC-pbbiqG-uM-_5cK-gak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3NCBTYWx0ZWRfX1w5xwBYg4Ftw
 DUGhaIhIut1O5J/4465qgq0DJ5iGLlkbtq65gWpFjTgc8Z2gbqZi3vY8rPxoiGzt7Y1L0WdyIwz
 sqSi+yopENLEaAHuh9Bca2p9ZyDT+FjTqXr846VbrYGMnwHP8tvXLYRe3qkY+ug3rvkRz9hp72a
 hy+dDzSARh2RsFx5Jr9T3RM8YXu4mFWXg4VQIBOswMWAfMdoR6TPpo48Dp/+LfqZ7p15LSLTTL6
 KgTFZqOLjDIxykBMWm3ci2V7ky64RbfI4f7gm1AQF/Wp1drqKDRJuLjb02RzI0oSKBQH06bKiM6
 EoP22nYJdFSkUo9RKk07MKcvvO6Cx0ZVCp/LW64uXO1bSnj1X9PNq93Hl7JvosdcR0MBJxSeeln
 RPbrlX1RmLAyCOXJ1EzjEWmZu9/rhuDl75davLmTeI/zmo9Gfxljah92ygE4vkRQhoVt+DNu+Ws
 IO3IslAvSDWmvm/MUXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3NCBTYWx0ZWRfXzYsGW+58YoKB
 l/71e5Ta2E8Fkf4/yfJ1QkGUdUCeI1RkkWpOI/KXf7klDCMzA435heDYPHEHt66E6q6UFCSXjkO
 EZJU/0lQvN2dXSofY9K1Z06U5IktQGY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270074

On 27/7/26 06:40, Akihiko Odaki wrote:
> On 2026/07/27 6:09, Marc-André Lureau wrote:
>> On Mon, Jul 27, 2026 at 12:49 AM Michael S. Tsirkin <mst@redhat.com> 
>> wrote:
>>>
>>> On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-André Lureau wrote:
>>>> Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path 
>>>> for the non interleaved cases")
>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Not commit log really?
>>
>> SSIA, but I can make it longer if it helps.
> 
> I agree the subject is sufficient so:
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> That said, we can quote docs/devel/style.rst if desired:
> 
>  > * Variables declared with g_auto* MUST always be initialized,
>  >   otherwise the cleanup function will use uninitialized stack memory

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

