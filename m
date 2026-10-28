Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793174307;
	b=yxxqcT7aTJqfGOKZ1ynzDwkl7tXqpirZ7+cwOwuNJhCEnrUUOGaVifmsd6MQHz1u5bAu
	 NG8iIKWlVuzrgQnJh5usJrMRac3otZsdn8Bd2P0MwaEc++eetnSTaO1Axf1ZbOGmxT5ym
	 DLvWzbpHrkUbU5hmuAvEqnbYU0o/dTWfhgx0/hjPLyphdEFTq+03S6OZnx4xxwJ1648gk
	 5n832QY7OEJFCIYDNCHYqg7H961HwI48PYIxVFKrnQU8oMIZS0kTKAczZ0YvImSgS0zXX
	 dlH1L7NbMz/DE5ZAuqUJuMTKfKlvNRRElsP31rUVVxB442O/BC+qCkktajOYnc7Iuvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793174307;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rhvGInK5zgI1eQ4J9LAjRQ2bzaVQYhPb/C5AQkVEQgo=;
	b=cq8PK+5ETSdBvYIthp5DOtEgqXxG64f+dcyBrzCU6qFoz2umqA5a/XWaMFD6WU/xye3n
	 eGsj40P0Dk63l1/CnCbQDZT0jL2hYunkAQKcV5zDKZmLHyR91TU1hXrTH293gDt4L2wFV
	 gTBl8jgUftvBpJOrUm/v/LNZzdYoqZp08nbPdMhzyo9BZ58/JQXYXtUPxK+clFNx4+Fld
	 1uMq3G9TjskjY4N2A+hKBqWaSJKeJXQ0TzJml24YL/1GtieHBDlXMwWqvI/G2gov1JknY
	 zD9qLucSgDKP9KQXRMH70yZOHhA19M29EpZp0CqghBW6xYiyHKRzgjnfvUP25qT3XIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRyuYSlQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=av3kTdIK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15CB606A31A
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 07:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C15CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRyuYSlQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=av3kTdIK
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4PUXw3381693
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 07:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rhvGInK5zgI1eQ4J9LAjRQ2bzaVQYhPb/C5AQkVEQgo=; b=gRyuYSlQFmBoGm1f
	faSRooSnfI3yO4w3BIFpy9cDdTlLeYuEfSJhLl3buQhgyJdhZfL0+dNdXrxB4Cuy
	gDKETFo5QavH+RqofMcKr9ofz9Co4ahulGJZwseamZakXHz0ZjyHuqrutcxAgajE
	SYVt+ONf14oZMfkOP9Zl+RJfbULMtnUXx2a8HtxvTr8mVW8t7fJKBAZlaz3Cc3ET
	vNopJJ+GDoQYBvZ4JGtyHMKPRI3/xJ31TmQuCseYwh2CvjrS8ZcemwmLku24IoU/
	V+YATyFtGzSfv2NhQOk5zVhr2BwbxhaH/K+RG1O8Q2quVdcKB2xfptlU8Ezs/iqA
	m4rTOQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6f91dfr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 07:58:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e49a1d3b1so133166085a.2
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793174304; x=1793779104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rhvGInK5zgI1eQ4J9LAjRQ2bzaVQYhPb/C5AQkVEQgo=;
        b=av3kTdIKQ3iod865qQR1ETnxxuW0Rtj8JTPsYVdlOM/3TqLZJkwPg5GNl1FgCSTjYS
         zlxBxfKIkS/PE0dkdg269aqknQDw4xNilo6Y0mUEqOygvNss2wWVrYnbeLgCfKs0WqDJ
         6j4EZI55DwN3g2/YRm57pQZIEPyu3UFUpRd11hGey5irBztUhFslMMpXeHO+I0H5Wtzx
         idVlV1KkpkJk8c1+1RTPoIUMUOCc4AXpmdiRdvbfIzkhMsq9SP+DJcuydVeKrld18rJA
         S4Rbz7S30zda61l6eSbiPNAWJTBb2SzQDR2ApALmLtIvstbNWTpngk4kwN5GcC/sDtng
         cBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793174304; x=1793779104;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rhvGInK5zgI1eQ4J9LAjRQ2bzaVQYhPb/C5AQkVEQgo=;
        b=qI2QWKV+4jFdMrdVIfARr2wQ/MTvH9SNgw420oq8U4MrLvfq7UwGqYKq7WACpsV3zt
         shbEyWMKRZtJ13aPfAsP9k/DPqOOf69BTQv7ssAkYqMydvM+QIlzIIAXc2DbZDOsieLZ
         LSquH/vqA/Ze3F5HHiusfAooxMUXfHLgJ/Ehi7lAjcLoHdS8bcjfut+S9VaKBIuZ20w7
         /8yY1ROQqaBeE9jGgexmD414cC0oFTowB9O+u7F7+ciTUofE89IOgbPGtjhNKZzKtrEl
         KQPrZhY9X2K68F/q2VMjOCPGyY4j0Ka02mfGlHarzENH0BWPVmtInR4CMuzZoMSkwWE4
         FQww==
X-Forwarded-Encrypted: i=1; AKwUvBz4TfDcAFsJ2VP4sMydO7+ktuGVqh+fJ+NEKP9JNUX76RRbvlIFUlmjujYL/yJxB6k6nBY68u4Z+y8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1hDYvl93Id3+FImz7tjuBGqJ19Z5zHNcKv/u1b8RfLSfuRxWj
	QmvrGNtlHtDDPp0Tx+c3Hnm2YmJ9zMvMJu6XoOQo88vMBLp5jo6U/ivlCLkO3FHNU7/hyxF/UwC
	wxPvL5jP7Mrg4n7SPBg4GLA/F7HhJSjDPUQMnNANHbDD9Bo1N/wiAMJ5y7VOmi4I=
X-Gm-Gg: AYBFou21csrTlj+M9bgEkVlwf94V5kqeVsMihNVXNr0/lxVh/5pTfPXk9ZmulnhZt3+
	eK2e8Mk3WLkd9zQ5EaAYnsc3zGi7TdBOPWuHlM0yq+ZCXepKMpFFfFesdWFFOXwSR1yCPSB0/oB
	WMTa6KuvGd1h2sh+t6xX9K+OqNo79jiuRgF5PY3qJyUCmBUqnFRuFs0ss6pZuY/t3hVTNBqUdob
	5dM4ag4PHJB8wiElkG+0IxB+x4zi18BqI3fcxK4nzL/1aB3/6oVUmKao+y9XXKoj+GPFM7874jp
	bsbHyWQ6Zgm6MZJ05y+DlJ1hu2kQysVskbk0KuAzqjG6kwBDIG0UoDWq6OJ+9A7/GUNCcM8ux3I
	UP8zIk6EW4KK41bh8IjALfOU/vY9uwjBTTfmtYwx2g0ptERSjDyeE70frtMv/RMXXeioyHhCqD8
	fefaOhYnszV1rEtdtUTzDOpJc=
X-Received: by 2002:a05:620a:31a7:b0:940:f53d:5f7 with SMTP id af79cd13be357-94408debc40mr205401685a.69.1793174304132;
        Wed, 28 Oct 2026 00:58:24 -0700 (PDT)
X-Received: by 2002:a05:620a:31a7:b0:940:f53d:5f7 with SMTP id af79cd13be357-94408debc40mr205400585a.69.1793174303684;
        Wed, 28 Oct 2026 00:58:23 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net. [82.67.153.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc4d76sm27424057f8f.12.2026.10.28.00.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 00:58:23 -0700 (PDT)
Message-ID: <f81a624d-73d3-4de2-a17e-2bfad705a677@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 08:58:22 +0100
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Junjie Cao's email address
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Junjie Cao <junjie.cao@linux.dev>
Cc: qemu-devel@nongnu.org, jic23@kernel.org, anisa.su@samsung.com,
        linux-cxl@vger.kernel.org, junjie.cao@intel.com
References: <02d394e6-eafe-4a3d-9f63-61b639267aa8@oss.qualcomm.com>
 <20261028021551.498530-1-junjie.cao@linux.dev>
 <20261028032407-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261028032407-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=frhJ914f c=1 sm=1 tr=0 ts=6ae1ab21 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=Zq7r3Ef6Bm_1TbWsCMMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzMSBTYWx0ZWRfX26F6MbRj0MxY
 ClAm4K0mZW+pX+KFm2UzadaF42FKnq22Wrv6PP+JpIQe8SdHc+kSpekmlgQvFJcluVZHWMYAGpa
 OSgKdehpmtNA0k6cRPa+/d2vvIqrIao=
X-Proofpoint-GUID: My4-It_U7HCTHN3OvpryhJec1lMehpge
X-Proofpoint-ORIG-GUID: My4-It_U7HCTHN3OvpryhJec1lMehpge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzMSBTYWx0ZWRfX7uiCktOi425f
 nT7LoYRxKlyUId+yFYrz6HJeVgTCsNtn6KeQJp8W1pxKLzCUqnOORk7DZQ31Ot6fsUzc7Yp9REi
 k3k8DR3cHnapGxILkyqP0zRoq1EhY4Ds9lhISiZNu5fnEs89lAuRSINGhEhiD06IkZRdbCQD1RF
 rMJNvIwswVVPHuvIZSLtVt4Atd033uWdkaLHAV0e7VL/LpfYITN82K0mF6YY64U9LZ789VdjFHw
 NgNityWUJC9Gbbul7OogLysM+U3Yak7eyd3Y10r/ag8tq6TDG1cUVwBC7A9mmvsUNCzTyzj0Vrs
 //xZEaeDVhlU2ZzvjpUzIlyF/EN7lxzVFyA+D5Ldlhf+fAL5PU+icWDMq+ftXtwBZui7ZT6nEq1
 kHVkuzKwZy4r2y0YG5z+ZbNrV9VO1gGZGmwpzpjTJ0Sc6zDxi7GHvJyyC6yj+v/HoQfsUAKJjTO
 AQ8BrWoehUk/uLLhDsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280031

On 28/10/26 08:24, Michael S. Tsirkin wrote:
> On Tue, Oct 27, 2026 at 09:15:51PM -0500, Junjie Cao wrote:
>> Hi Philippe,
>>
>> On Tue, 27 Oct 2026 19:20:21 +0100, Philippe Mathieu-Daudé wrote:
>>> On 21/10/26 15:43, Junjie Cao wrote:
>>>> -R: Junjie Cao <junjie.cao@intel.com>
>>>
>>> Could you Ack from your other email?
>>
>> Sorry, I've already completed my handover at Intel and no longer have
>> access to that mailbox.
>>
>> If it helps, this aw99706 kernel driver patch from August is
>> DKIM-signed by intel.com and has linux.dev as author and SoB:
>> https://lore.kernel.org/all/20260804030255.1934470-2-junjie.cao@intel.com/raw
> 
> ok, will apply then.

LGTM now:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
