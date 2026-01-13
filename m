Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44457316902
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296659; cv=none; b=rfAooBc5dLLpo63kZvHaXgCZ0AiPjE4+k59Q5dLZ8GuLQzJhRL+Gge8Ncr6WfZqA+BVAMD/Hcjfg0F8i2YkmthhJ83foRSHJ7O55y6H+NqlMBWN4qIXK+PrvnFAfUq68wxy/EhFcMiKNAAmTgPupzEVEbyToESMNptmqL8AwjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296659; c=relaxed/simple;
	bh=1Eiifu80j52RijGjXr0wmDrto47lICEqQroalzmp67M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NMStkX4tEp8vHEno9qtQh7nbxws4FflRTL/xg7Xgo/AjX/F69ljJIKljoIbQFWk3ZH8+hmmO6iMcN0FnC3OKF3OYPY9As7sXDyE0oNsbhjJ6AX7tEpuZtoqkNK2zklZ85rZueOfDAYKWCJSfFIyOxhBvIskeT7Wh43Y3iu5EbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YfF++4Xg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WmihbJdW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YfF++4Xg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WmihbJdW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D8Yv393727092
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Eiifu80j52RijGjXr0wmDrto47lICEqQroalzmp67M=; b=YfF++4XgPIGbz39f
	eSVF+zTnBwNCHcw/gGjlutnVpdpecUfbiB+jHVkJzzUHyQJXovhoff48zNCeAqg0
	fP/kOeiUSuscrgmJmjXMJBIgM4JvwJuCazXpyWb2VuDdte8CAdj6qw1d+SjT4FyC
	Fc9WNKzF9W57WqCcO2lof9P5BUI9YsfaSUogOnOGjBaNpvtn7QikbP6MBYb6YAIb
	XKXMw4y+z8vSYQlflYb5FvTMETvqXurmRqr69+yH76VftkKJC3gmSD/8/Zf9FLvn
	YR5qea1DHhH5hDHRgSgA+W0BF0kLEL06TzWONOLL2eUsPgnYs0N0ZQNq4BZDqt5Y
	LSwfOw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnjnu06bt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:30:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81f53036ac9so1731400b3a.3
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768296656; x=1768901456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Eiifu80j52RijGjXr0wmDrto47lICEqQroalzmp67M=;
        b=WmihbJdWpKQ3b+ufpRXm/vhDed1rreSWfg0S8jUUN8J2Fymuea2QRrPdecMiRs8+nO
         9dodtBhT9vMKccimDZDuRqBo4TsVhZYGoh1QadwHP8VtJ5yEwiXK3SdPLopQfHVtIzGX
         da93+Yya/svvY7wPFgTQ4HX0YSB+btbk6WqxZd3OcNiGUirKOW56yzjRB6PoDI20kanU
         o7DWO4+awTgXR5MEgZiGWYNGUb8fuA+XGnpVMyP/y+znl61JGIof0I2ym0uYmJhYf+Ey
         aKn7eiXWb0RAjg2/M8g95rx62JAqK2nT6fqD9DTroqqPLV0kUNuqn4u4wbW2T8sJJ78o
         YNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296656; x=1768901456;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Eiifu80j52RijGjXr0wmDrto47lICEqQroalzmp67M=;
        b=GIvRVvnKtQ7SMMWXMNeQqMsJ+y1K5y4JQNy/9W+SdNyuP70e5C6T+xqhCqkUc9evFu
         w9X0pvRTc7b1T8yAy1i1eAJxGXJOJrbvBEhABvE5dMHW4aSlw1HktqmSglqBfX4fbzl/
         WBYiQCsgCv6wBFmjHTNPVFmepM4m7V89sVn6LYEMtthzdKBkF+vofBUSviI/y7HJDJ11
         vsQr+N5Nnrf8MidQ/1ROKtUs0Wp0SUsRRSjvMSU97VOP9Bm/IsPoZk01wBZeDDS5ib1Y
         CW2tm9ybhoijcV3LnYPLffJriIcEfGWEiZbja+1jW2e5wBSQ4GEb0Q5E1pf2L1TlH2AO
         ESww==
X-Forwarded-Encrypted: i=1; AJvYcCVmhv9kDga5nfJz9e5YB0cSc22C9eqOWjyP/QOYAo1apjKGiR2JXf6vWHGrDjzIFNV6KpTLQSuL62s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaA/kl6UhhOlQmr0gbvhyb9GHc7sUdXqUBV2kIddM5PKE4CpfX
	xVKRgSt5VYtZ/WTitURXR+CFh88o45q+64sOgH7bXrVpS+zmZ8luq+mYdAW38uzCNxlepQjlNCs
	c3Sbrdyc3HbF3MQrdAgLvbS2hxfGUzjRgLH3FG35nsPMLB7eBMBVW2fKNehzdEK8=
X-Gm-Gg: AY/fxX7s+FTOrKe887ypn975aQM3U3A5I0lGqrQhFt769aX+Jwx3sbjowpWaBM5qdLE
	DS7NIgM8yidGhxxpKjiG31tGxOQy6KQIXHMDdPv9KIPdOTUYSwPEDvBmOIXkX5X54AfeV/uB2y+
	2lAK/Yie2DFRDGpvCNsN7uX8OvKmSf+ADn0EioSQpWd1dBDiDcbtONKzsIB/HVW4Og3Cp2+Y/Gp
	OoqVQA7j9nBIrLAcS4/TQBxE+UkPImc98Nf9GkEPOsHWX9WSh1PTm5PxTAqPDFGxNuU9HJm06ui
	vxZ/PwtOl6TcIWTLVWJGPwh3XlnzKUGPYxMfpfMOGmPqQym/ILHi9ID04W4LughZdQJbcivOHgU
	JLUSma+E29Lti4sh/OZ8vW/qZOSWMYiWei9BytaiTEQ==
X-Received: by 2002:a05:6a00:3018:b0:7a2:710d:43e7 with SMTP id d2e1a72fcca58-81b7ef0bb9emr17349006b3a.24.1768296656226;
        Tue, 13 Jan 2026 01:30:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2N3I1HNLXa81G+Nxk9wRLz1YLh513Pjh3sJ7JFqYDVnyvy2PqTNvo+R990+0YE7pSjEfJsg==
X-Received: by 2002:a05:6a00:3018:b0:7a2:710d:43e7 with SMTP id d2e1a72fcca58-81b7ef0bb9emr17348979b3a.24.1768296655747;
        Tue, 13 Jan 2026 01:30:55 -0800 (PST)
Received: from [10.218.5.175] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81df6b3bd16sm11616850b3a.25.2026.01.13.01.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 01:30:55 -0800 (PST)
Message-ID: <0fe751c5-3816-4666-b0b2-c1427662e369@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 15:00:45 +0530
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: akinobu.mita@gmail.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com,
        axelrasmussen@google.com, bingjiao@google.com, byungchul@sk.com,
        david@kernel.org, gourry@gourry.net, hannes@cmpxchg.org,
        jonathan.cameron@huawei.com, joshua.hahnjy@gmail.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
        matthew.brost@intel.com, mhocko@kernel.org,
        pratyush.brahma@oss.qualcomm.com, rakie.kim@sk.com, rppt@kernel.org,
        shakeel.butt@linux.dev, surenb@google.com, vbabka@suse.cz,
        weixugc@google.com, ying.huang@linux.alibaba.com, yuanchu@google.com,
        zhengqi.arch@bytedance.com, ziy@nvidia.com
References: <20260113081453.8293-2-akinobu.mita@gmail.com>
Subject: Re: [PATCH v4 1/3] mm: memory-tiers, numa_emu: enable to create
 memory tiers using fake numa nodes
Content-Language: en-US
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
In-Reply-To: <20260113081453.8293-2-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XQ3sw0PMdzEVu-jnoh5w261IbL_xt3_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4MCBTYWx0ZWRfX/TAZ33fkm+QF
 VD60W/ylljUUpw9bCoPwlksgf5riwpooOLPAeMHc6/IVT8amkEx4B+d4IWtf8B4uq5si8SPICCf
 xt5UCJ8KXuI6NFW1r9Kd2U8Te93tHGJaSgs8ukw44WEz1KoqfOqS6IpmxOt+07zyOCYmH6uKPTZ
 s/FCwfSOuNMUSIULHL+GuHA8XH/Nlv87pelMfS8MCBjnqrVpjb7L8mQ7aZSUKgA4o2GtvF65/ku
 5i40h0IYRjL+fjJdhpx7J45QvQ0QQYnJxhWP1vu+odOMNJquv2cRJd914ZfLv9mG02S4cIPMYsK
 DqJOazep7ZcQ7XM4tL+qLh4L/RCr0sr6Yvnxy4iAcmGqh9lxjCZFke9uDMP0qq8fvOd7QWcrCjQ
 +CtYKIP6ltgWtcJEBak76zSO0ok1wNCAsj1aJZNsRFzROJ5Hz3tBAi865+ZjXoftXOY2mG9xdNN
 PEqLkc+yWD5GEOgwfIQ==
X-Authority-Analysis: v=2.4 cv=RMu+3oi+ c=1 sm=1 tr=0 ts=696610d0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=UdPnmgDXQIG4_xgNs28A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: XQ3sw0PMdzEVu-jnoh5w261IbL_xt3_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130080

Reviewed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

