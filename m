Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C69286D5D
	for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494199; cv=none; b=ZDdX+pPiLPq+yLnHrnOCR4DDbmldvP2oXoNqEUsCYBguTuZmwGJHfLqfnb6HqD/tSkcem42wlLr6ZIhwtb3dVJocQJWFZs692+DjteKlsGs+PYJyd+/4M8joR4tDRhqLdN7WJv7gF7KAT3brylk9WYyEbHHla8UbjmVForJ11uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494199; c=relaxed/simple;
	bh=khoEr+rTwzh2DwHRn+t3lt0Ki3ldA9KaqIBw+lOY2EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uY6yCBdhKHxmW4H+j2I2RqbTD7TfbdDPvG4vcn9+xziM8+VsZ+6ZV12fETSaHHHqV0Bbj9IVag96DF0ORqCBim0AxZN//ZODRvopY1208S6HeiJP1Yy6SdjwVQDDHlbAgp53bCu/R8JL/SFwh5uZUAkveVBi45gNr3wz3HpETaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fcctqHfN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JCTs2hVZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcctqHfN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JCTs2hVZ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68R3N3sB214807
	for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 07:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g21CMGMQYon1MnxNWkDMC2ijemIwzgaYkcd/tJ/Tan4=; b=fcctqHfNPEQd8UxX
	IzkpHXgZ0sRRnXzHQqOslGVyxhgIxcRgYTPA9YnE0vVc1sPudhIdHHz9LV3BsjXf
	j16HfculFUWazbl+lmYpUW7zDWfbQDATOIZ7mU4joBJ5z0p/uwAFbxQkhBBLnPK8
	OgiXqY0cxkEElv0nlZbfXjzkXtaED9WFnrCv6qu2F6Irl1bpxIJZk/8uJeXzjW1x
	736j0Bk5VVFMH250G6OQhugAr0PaYHEFVSS5ZG9OHmuu05OBdkxdTRt0bRgySK8t
	vbSDAaXT/2FXqn60f8TEAw7xKy5usRNTJW8s2/Ceq7iIwqxB9DE/CFiEU/pyQCoH
	n/ZysA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jtcgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 07:29:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ae8e7e546so437835085a.1
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790494196; x=1791098996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g21CMGMQYon1MnxNWkDMC2ijemIwzgaYkcd/tJ/Tan4=;
        b=JCTs2hVZ6xJ0h4YzqXgmoYt/nGtbdOipwTP6U/DPtZCWCs/m5AwDy7MaBXfUJa6K2v
         8vIGmVzmPcsD3Uj3j9Vb9jo78Fv1xdk6iO55/DoRl4FfTrxHjYX3J91IHrrN1PPSpeTF
         R//DsOM+29RVDpro0ya8Hg+Fj7VOv7wlGKvnOTMdK+z3Y7OiqrF83h9H+7V4got9JUYW
         wVfWi4GfayRNGwOVNB0hihxkr7YK2+ZS2CCCQCWC2YP5ohw0dhW3SVUfe9o3LjOL0Kh3
         IkmS5QWnWitPCdG6g4P8ssREQ6luRivrVnQ+wsqQGQhHe0R9uzzJWVp92lxDlkvh3M3m
         igEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790494196; x=1791098996;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g21CMGMQYon1MnxNWkDMC2ijemIwzgaYkcd/tJ/Tan4=;
        b=uTzFuD/FtvISMdbEJFv2ghAce//gSl+s4d1HvXQtiSnJM4IJIw8Tc/mCv1wO+PukAc
         E6FjPyHe2UjepcqAnEM/B+yAAVWT9VcIpbzUcOBqi+Cwoa/hA+mYVsPewGl2sW16a+E1
         YHNqW7UorxPCj1IG/WMKoaRuzrcgWaZ402DEG1fJZjuG2e9GdagkdzYvxUB2/yXoeyKG
         81hvsSNjjfe4H1Ny99kv0+qHWa6Xohl0uHa2iFBue2ScdftjMxkk5ojSl/8gx6TdsQu/
         T/kBPArHZCs9sYe+5llpfDMUlPE7NenpsWCxv8wB77fK21tyr4xKvbZOnlPEec6Xvwb/
         7Rrw==
X-Forwarded-Encrypted: i=1; AKwUvBx7/MzVga3bHsauQ/AUj/ndoIGgNzW8FiyFZZ3WyarrziNXPREPDOVbb1pKDXlbFdxJzSAgR6iCm24=@vger.kernel.org
X-Gm-Message-State: AFuF++mYhx73YkhF4WqOC+FOkzBXLPKCTKvH/52pLuNYNMnW8KdFFdCX
	TtaFJvPafqo5cCxyxt9O6aHrHZBifCEDNtJ6AmiZ9rxtofkmKd9k7CrDDr+dQoyxTCOSTA21/lm
	/S2iBL8aJoScyXji89vLSgaoKrtYSWOTST6DIUIN1Srl4B36tCXRtrtCG9A6IPUg=
X-Gm-Gg: AYBFou1MtNThreI0d+rvsLyAy4pD7O26R5Cl8dxSgk58qshvYlP/IhY5dvgilWN3iAe
	9hvtmIZowVJcwxs0Lvg7bl538kjVbupoOl/0j0Vy3jEO+CVBquBoprxVNhK0JTiVNmX4r9YckDG
	foH8bm6Kv4LkNHCjV4JYrATGgyZzJNYEtZ5mC4wZi2v5SdOcb3M5C9tApGIDcBEuEzQlGiXCaRt
	8/+fFUkvt8raHy3z1yAsfcigxunOPkYzcy/IModUHy7JMKdsJRKa3TlJW6ZyjJkJ6IRI/VyqhFZ
	UCjvxWbA7e+a2uqsgdHswXsABTW42uUInxVEGyMytpE+2NB7VqzkJKM5HOwDThae1kpf5oahWSe
	LG6jSCZ8NCUcnz3YkM0gXmJm1BMygGHsQpA==
X-Received: by 2002:a05:620a:8810:b0:939:c303:c54a with SMTP id af79cd13be357-93c43c9db58mr1435862885a.31.1790494196507;
        Sun, 27 Sep 2026 00:29:56 -0700 (PDT)
X-Received: by 2002:a05:620a:8810:b0:939:c303:c54a with SMTP id af79cd13be357-93c43c9db58mr1435861085a.31.1790494196099;
        Sun, 27 Sep 2026 00:29:56 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b9aesm17387846f8f.5.2026.09.27.00.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 00:29:55 -0700 (PDT)
Message-ID: <d5d4bdc6-7b91-496c-bcf5-43ba95901851@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 09:29:54 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Anisa Su as a reviewer for CXL
Content-Language: en-US
To: Anisa Su <anisa.su887@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
Cc: jic23@kernel.org, mst@redhat.com, junjie.cao@intel.com, dave@stgolabs.net,
        Anisa Su <anisa.su@samsung.com>
References: <20260916002143.777233-1-anisa.su@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260916002143.777233-1-anisa.su@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX5mnkb/h4TjEs
 uG2j8gccjwDHHJenuh+uhwcCKjaypCwQeNdfCL0oluDN4TND0UNGypYzWs7WmH/tai1KGnPRuN5
 TvqAdlZPfxZ9tE6DuPD6Kecx8g1RWcQ=
X-Proofpoint-GUID: EVva1IMcfyaDIuH51evOOJncgVBR8yFh
X-Proofpoint-ORIG-GUID: EVva1IMcfyaDIuH51evOOJncgVBR8yFh
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab8c5f5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=R4ayLD03AAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=TBQXfmAMVPWdF26Y8UUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=qJlm0-shE6CLU_iKUWNr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX9TFbA3v0wMrK
 J1Attn8fAohmiwzL6quQERHnVQTmHyzXqeZopCCxU9fftVfgdjmXheusouHkTjRFcZNpgkwmvIO
 UINEwhvLV3xfO44KMZIm9FEmmr7lRmuJrD2XemRUZYlu8V2K8uOA1zqA9PWdoRI2xDJ6SZfOFmf
 EDbxr+gjIVufh0PjyDCPsqaj4xMnz1eg/Cekr18ygO1EXBJw8cx+v/lxCxz2oyp+S78Q3DfZHVm
 JZJhB1oGkyf6GueO9PnJ088srN5djOJKQkoyshQxq4BlYaARjDjL52CvciktpH+ki8GPKJFWR7c
 k1BcG+tVSS5efHyb2pqyVB1Db8iymqLx23+kQfRfrDOPVMYf6D7CL/XacADWw4tUAPkX1haFLkC
 ydIBfkCwAo9oZQfRKln0nzNR4nlI+YxjIpBEPKlkPo2bX4wlZVWNHo2p5cQ9kb2+eF88h0nZTdJ
 2roYTYw6/q2IFWugQmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029

On 16/9/26 02:21, Anisa Su wrote:
> I contributed the FMAPI DCD mailbox command support in hw/cxl and also
> work on the Linux driver side, which is developed and tested against QEMU's
> CXL emulation, so I would like to be Cc'd on incoming CXL changes to help
> with review.
> 
> Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

and queued, thanks!
