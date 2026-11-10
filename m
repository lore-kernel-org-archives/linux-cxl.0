Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270454;
	b=xV6+2p40LVg8rM5SY6TxOsJggbJsZtZeL8J3AwX1jg1gzQIEYqWx5X6YJlQAQXHkmciX
	 Bvep49nhr7E0QXhRcBvONhEUEVHS6CkRDep8w9CEU/HSDEJFnHj84S9hso/GTTda/54BR
	 bFGZZhieF1++e6bYsD1I2ASCER1sV5mavP1HT2u9VAzSCSzvP2+egPPJtntc5pejG4wIk
	 zavcq6pnQy87htn//Y42TPT8QXyjPStb8pp9ZzycoO3/8669UM2tgYDKS/LU0S5eswn+e
	 V0LtUyoPri/v1m/CcFv3Y+vXkqb8C1z3+6mAfwJZkTkGQNuw11T30esxDS3Wp1oGbwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270454;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=R0bTkl0ZeS10Rc1qvdgpvqwy+jnWQCRdinOmlNk+hTA=;
	b=4n0DaThA5Wahpa6Y9IUEAmx/maUo3ukQ51rU8hbmeiwKbsJOirH9qwBsJkJB805WFIZ+
	 kR5dC4tM4QGhqPNdbwvfvzMwUCW8uT4vRBdZP0ZnPz1GkJOj+I/pdZsKnxy69W9QPPueA
	 GMehmKURicb74FcDohOFz6Hi+4OGev5dtES6lWRjIT1ANcI4q+qMiC09PYjq0ohqgETAF
	 +qopHzUjEBetXN5ewx37W+9vOPu1KqAczB00g/j/CyLDcU7Oh6tAhJhL7P2TFgJxcCJOd
	 Ll3cdaVnQOnpmiQ8DMO/+pkOTvI2zyYgV49qYhmzH4JbSA1LPGNg3ZycnUve03MbMtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jOCviDoU;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=wHQRTdOf;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78289606A321
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 00:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78289606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jOCviDoU;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=wHQRTdOf
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9NaHVw2645309
	for <linux-cxl@vger.kernel.org>; Mon, 9 Nov 2026 19:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=R0bT
	kl0ZeS10Rc1qvdgpvqwy+jnWQCRdinOmlNk+hTA=; b=jOCviDoUV/d+SBS9+iko
	Dp+sdqHEyd8SiXDTjRw3mosnYhHzzqA94GjHpHpXbj2rXDHIWgTioMoMgs1G0vx4
	yYqCJ3+A5N6xVan0OOtxwO8f1H+vX/+MkPsPQJulZtzLXUWsW0C2Iie93T14f1Fx
	UTOxKmkFqDk68PQ6FgUd17ny5o83+WVj4trMpGfmWZwucNvgIbUr9sVuy0NEBT98
	CqbC/arbYfWLUWP3CaPG9vKS4HgBNz6ZZpWbS8gl+xVoa5F9YitxG9nKwg7xRjBF
	Uf6eDeUFBvgVzo7KYOjH7cW8NXmfp+RdKdjwggD8VbBFbCRBMlF4F3VV9d3EfhIR
	ww==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hupu50se0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 19:27:32 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-535066512b0so30361101cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 16:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794270451; x=1794875251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0bTkl0ZeS10Rc1qvdgpvqwy+jnWQCRdinOmlNk+hTA=;
        b=wHQRTdOfBfOICd1ZgKzFSqGDHIobHjUo5m64YIpARFvpzvNIzF3y1NHxYl3HX/Lp0J
         /zmPSXQ27B/7aPeJepNoRmtyXhgm7YJO65RPFaZOn3NY3kwZ/lSu1lpsZ3HWoLDc5/pK
         Qb9TnuxIS707O1LOqp4GvGAK/y21r7AeB/014Ru7rDHyjpuhQOw0qlHLNtsNzKM63eJx
         TUSmZdkjS+dgJAwWPxWD4FSxKTnNDhpyS1b758oPsDiPNMGqfMa/E7WEi5mpgtaCO6/G
         RsZQEIXLawrQQd3qp4QRAfWIUSKk7tqjFdboSnkuab0dAGtzUFd6p3MiDi/8Zs9f+PJ/
         H4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270451; x=1794875251;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0bTkl0ZeS10Rc1qvdgpvqwy+jnWQCRdinOmlNk+hTA=;
        b=yA1x9BSphzBSAmc70XlrDtfr6caCBf0zLhpekVsoC9bBJqAeYVBTJI2KWbGFEHJZgw
         YvW2P3j48uXypEKnBJuc4K6n/lJLEnSRDCpwzU0/XDY8OFRGXt1AgKvE+V0h+If4IO8+
         QBoD1dmwCkGy2ZvzseyaCns5Y1DgWwACgq5pg8Y6lEN66k7+kb5m559Uknyhb2xY+M75
         1/+4tQV1xYYFPTYPlNIXymliMPDTWYRPX1tLBDCdtPAQ0nISqbYPL/AGoLxm3V37XYBf
         zHYRsbZdVC06YACj1yymkLjrf12g7J7wJaFcQEFxB0eGIHTNhA7pwpG5sQru7b+pHWCq
         TksQ==
X-Forwarded-Encrypted: i=1; AL+hErGm1UDRdZwrOytW9x4S5X9hWcMgyar6/HMPMqsJS7XLC3w0pwcTawMVXSrLGT/z9zcLy9z1MkVLViA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aSHE5aBnStvgNbO0aNG3RMPme4c6WAgyzczkvrTEuT8zhsH2Z
	Kt3Dugidy50g7Nmaw3aPFa18RlQtqiHjdnW579pLssJ2U1hqSfMkUlf+RHRSPqW9vAA8sB51P4T
	s/blFpA6hr1DVqpHRv25tfoEEyUrOX2kXxzgUIlrvkJ2Ii93J5y8+cK4M/g==
X-Gm-Gg: AYBFou1mJDJhWFFfJYMMRdr8cZHFK5uOJuGBtj/5iB3L8ZB7h8Hog3Zv/hgjbf9Q+5e
	JCm5tEH61wPlh8TlmZvrAlKRqQI17taIVcUKPNQVlawZbID3+f+bTWgpJGsNX+nO2i9H4k0Nlei
	937NX+viu6clGqcjnIp0luRzhaUSzLxwf85PXrnLnHxJWyyt19Jva/l9ejMsg/V2ZsuhsId/dni
	svDmVfBWU4VWnusYKjtfHr4Ql0gDISntvLjSWKovWagMSVgRTRz2pKqoENhXWKk9M4NJV0FGTyx
	w+r5PLW1zKySX+ZkDTlcPkqHLVQPFLx2Svm8Gg1UhZUvtwKaebwK5+h/kzqU2FIYk8WKnxqHo5J
	uqp/k694pMRZ5GZP/IXN3F59lxZORDMWZTcu14es5QAWdXts4XLroZHkt1m/MOkDlJ1QVqBZETO
	Gi3Z1BVDC1UIm4Qzz/naTSl5zp5VmzoZf6PUj+h8ji6QXJ9T+7cD4+LW92q49OHtVID4R1C7I60
	1QCu5qowfXWoSNvg026urZrV8y5sze7GqubQ+1VZOUI+rZXbhmrULwZCJIc46a65jO6nFzpFdu7
	xWHXMpunJYcfIjW8qg+0IQ==
X-Received: by 2002:a05:622a:2a10:b0:536:e29:e774 with SMTP id d75a77b69052e-555293bb0e6mr16117051cf.77.1794270451583;
        Mon, 09 Nov 2026 16:27:31 -0800 (PST)
X-Received: by 2002:a05:622a:2a10:b0:536:e29:e774 with SMTP id d75a77b69052e-555293bb0e6mr16116841cf.77.1794270451295;
        Mon, 09 Nov 2026 16:27:31 -0800 (PST)
Received: from [192.168.0.76] (dyn-160-39-51-212.dyn.columbia.edu. [160.39.51.212])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555091eb801sm10414481cf.2.2026.11.09.16.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 16:27:30 -0800 (PST)
Message-ID: <0bf0a413-7f7e-4701-8907-cc44dba4509f@columbia.edu>
Date: Mon, 9 Nov 2026 19:27:30 -0500
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
Subject: Re: [PATCH] mm/memory_hotplug: don't offline a hwpoisoned page still
 in the page cache
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Vlastimil Babka <vbabka@kernel.org>, Gregory Price <gourry@gourry.net>,
        linux-mm@kvack.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261101-memhp-hwpoison-pagecache-v1-1-ed8785ca44eb@columbia.edu>
 <1b6a6d13-8a01-414b-9bbe-cd194af1f539@kernel.org>
 <a002901b-715a-4adc-bdcb-7a6fcda67711@columbia.edu>
 <a2ec6814-d3d3-425a-b379-f99b219aa55e@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <a2ec6814-d3d3-425a-b379-f99b219aa55e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwMSBTYWx0ZWRfX68XtlTMhr0NH
 GYDoQPkApG1fVETKSdIxqW6y9WqkrAEGB2U7KRs2aGCGH6IrFN4Oun671gJogYdyaQvCxMwRHgL
 nfnmqhu9sayKcMrLabZZ1LluntyxEGewYTd2eiJmJ6UosN2os1cy
X-Proofpoint-ORIG-GUID: Zm9ORPFlUnFpG8NmvdmLTQ3eF4rnAUaP
X-Proofpoint-GUID: Zm9ORPFlUnFpG8NmvdmLTQ3eF4rnAUaP
X-Authority-Analysis: v=2.4 cv=NvZE4MdJ c=1 sm=1 tr=0 ts=6af264f4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=l9izRfKDRJJ6Wn/vzKnQSA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=C_JoN6WlG-creS2BCkQA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwMSBTYWx0ZWRfX1TJDxrBklM6a
 5Z+3M6AdaH0KMcpt2VGavx+9XUycqgl9WT66iXTxGSJb35FkFCs6paIiOroOdtNIVJHXrjvIiyA
 j3bzVuAg2ooRicwF0DSBlKDZJvSJFExYnJd4S4yL0DPoXgxkRc1OJ/hE5w4f4XAIy35MTFM9G+9
 IcJG9Giaeh7LML1KxMMIDnefFsSA6c/fw8fuRR1MB46HMhr2M/ww6apAMtMZtMIqFO24IcFVj2V
 Fa3d0n/gSHz7k8BpOoR1tPt3QIguYolbijHQj5TOZzRB4aqQDomZcyoy+iQlXl5c0Cq5FXxeHa1
 SpjZa0kyT9J+OnLYdgIcvcSfNkDv7CMn9kEwlatPlGhtrlwjtxYm4Wko3ldiHD1aoGcjoUCw6Er
 t4PrQONcc5tQdw2IQ6gCTM4tSb0jPsm/HqluvNyLeulxJ7ZpwfTDz++NFX70UbEaO0Rx5W27F8h
 SzbI91QuWLyrQlC1c/w==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11961
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=10
 suspectscore=0 adultscore=0 lowpriorityscore=10 phishscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100001



On 11/7/26 2:41 PM, David Hildenbrand (Arm) wrote:
> 
> So the right fix is to fix that then.
> 
> We'd need to sync memory_failure() with memory offlining, correct?
> 


Yes, I'll rework it that way.
Also sorry for the early v2 :)


Mani
