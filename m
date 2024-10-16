Received: from qs51p00im-qukt01072301.me.com (qs51p00im-qukt01072301.me.com [17.57.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA81D1747
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729121749; cv=none; b=G3R1h2dDOGSKGRTJYCsDoSB12UKkxr+ZeEk6FOw/hfsUsqyNwtHstHGscbog+xWMwTjTkMtQ5SAzwWcjuFvnNeUH6iHYKxpKsOtzgEsXQXiLeZZY8QIJ45yz8itVvJ4iqZDEHGcQRDfK3rHYHaOhxIYRxMqjQKuNtP9a+IlX/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729121749; c=relaxed/simple;
	bh=gdwTVAwWb9VdzRsGZopWrMq8IXjxY6qHdy0/H1n9jUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqzzkmjuGtx6tD+Sw5jbFddsLi0p61r9NVJyAeE/poDBnnBUWmPNFohd+KVpTTj1eA/it8Lnzy7hunIzM1N9jp3zlAhug39Nn0WRPspJ549WsvbRpT6MqmuUHdnE3zQ8YM87st8qrHjO2KUu1Wm5GsRs3n08fLsec36/jZficuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ES2hMIB9; arc=none smtp.client-ip=17.57.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ES2hMIB9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729121746;
	bh=4O6bY24xBTUD4eTJn/i/gevB4jlr+Frj2BgzgIvn6KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=ES2hMIB9tySlH6IMhVQCgZUVmRksEFP5mEsyf6eNA3wzVfI9tmyaTEfQef+cNxjMi
	 Rw0VpHOiiLxr6NAIW4GL5gskIJkkDslzaXOK6v8lncCATlFyMCNavFOFjnZE/loekz
	 5qFEEGtAEnfbExLtVVsru6RqtJTN5z6KnfAQjFxCTpfpozIDMlnrfefbH/6wE5PnT8
	 KZ51LKH1ozLY2Iagtfehz1V8pjFM5L1ThkIZuTPuUXtDTtCQORQ/y93gYu9gfPR9yx
	 RpHStDzfeeJMbrwCl8VWKW8mwHwVe1LNV1+sZeoXyTgBpTocJgz0X8aIBx4USZlIfP
	 +PYVryk3c1P+A==
Received: from [192.168.1.26] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072301.me.com (Postfix) with ESMTPSA id 03DF425401B2;
	Wed, 16 Oct 2024 23:35:41 +0000 (UTC)
Message-ID: <4be42749-5444-4847-9396-820667d5a9e2@icloud.com>
Date: Thu, 17 Oct 2024 07:35:37 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cxl/region: Fix wrong logic for finding a free switch
 cxl decoder
To: Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241017-const_dfc_prepare-v6-1-fc842264a1cc@quicinc.com>
 <671045fc36835_3ee2294a5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <671045fc36835_3ee2294a5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: V1NzOHRLfubtklamPbYDlgBRgqGYis2j
X-Proofpoint-ORIG-GUID: V1NzOHRLfubtklamPbYDlgBRgqGYis2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_17,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410160151

On 2024/10/17 07:02, Dan Williams wrote:
> Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Provided that all child switch cxl decoders are sorted by ID in ascending
>> order, then it is wrong for current match_free_decoder()'s logic to find
>> a free cxl decoder as explained below:
>>
>> Port
>>  ├── cxld A        <---->  region A
>>  ├── cxld B        // no region
>>  ├── cxld C        <---->  region C
>>
>> Current logic will find cxld B as a free one, but cxld B is not true
>> free since region C has not been torn down, so current logic is wrong.
>>
>> Fixed by verifying if cxl decoder with ID (@port->commit_end + 1) can
>> be returned as finding result.
>>
>> Link: https://lore.kernel.org/all/670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch/
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> This patch is incremental to below patch series with title "cxl: Initialization and shutdown fixes"
>> http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com
>>
>> This patch is based on Dan's recommendation shown by below link:
>> https://lore.kernel.org/all/670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch/
> 
> ...and Dan and already sent a patch he is happier with here:
> 
> http://lore.kernel.org/172895072669.39002.9296583943188706348.stgit@dwillia2-xfh.jf.intel.com

this is a optimized one based your recommendation, namely, above link.
please don't hesitate to use it as your V2 if you like this one.

you maybe also have below change when you send V2
Reported-by: Zijun Hu <zijun_hu@icloud.com>
to
Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>

So let us close discussion for this mail thread and go to your above thread.




