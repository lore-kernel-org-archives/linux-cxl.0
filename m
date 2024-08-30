Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84196171650
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016715; cv=none; b=u5JqdZpSKQ5KpFpLfwNJ+uWx2hQeU1ctGsx/bnqD5lEH5rKl/h1TspQe2VW8jrTY5SgGoaPElpqg2s0ajN5VXRim3URZKfAjwszEl0b4yZUskWl/MECEokd2R2gJuObsH80w9cB22UcKa40d6aA7Guct52yWZFzfz6qjE/APV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016715; c=relaxed/simple;
	bh=ULOZtCSxWo9KMqvVb7I8RYVZeN9EgrEXVhdI5ZJQzN8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLtUGkbR6nvoD+q7AsAp7gqY0LZSACIifYRKUypcZQ+54iTj8f+hruj5AlP1YZr7rUmvgL1F6+Wk0TvDutOmVH5RgtJ6adZtXohC61GrUPopywKDgsJ+zUKlKi1OtSWzkb9gZPb34yMoPM4dWDtzAGarn9kTHorHjfkKA0SGSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwFtR5t4sz6J7v8;
	Fri, 30 Aug 2024 19:15:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E469A140736;
	Fri, 30 Aug 2024 19:18:30 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 12:18:30 +0100
Date: Fri, 30 Aug 2024 12:18:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <quic_llindhol@quicinc.com>, <peter.maydell@linaro.org>,
	<marcin.juszkiewicz@linaro.org>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<chenbaozi@phytium.com.cn>, <wangyinfeng@phytium.com.cn>,
	<shuyiqi@phytium.com.cn>
Subject: Re: [RFC PATCH 0/2] Sbsa-ref CXL Enablement
Message-ID: <20240830121829.00005d79@Huawei.com>
In-Reply-To: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
References: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 30 Aug 2024 12:15:55 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> RFC because
> - Many contents are ported from Jonathan' patch on qemu virt design
> 
> - Bring plenty of PCDs values and modifying the original PCIE values
> 
> - Less experience and not particularly confident in ACPI area so this might be
>   stupidly broken in a way I've not considered.

Hi Yuquan,

So an opening question for you.  What do you want to use this for?
If the aim is to do full software stack verification, I'd be tempted to
make a slightly more complex setup from the start and have at least
2 CXL host bridges so that you can enable interleaving + probably 2 or
3 CFMWS so that you can test that interleaving.
Even then it won't meet my requirements which is to stress the software
stack but then that's not the aim of sbsa ref so fair enough.

What you have here looks good to me in general, just superficial
suggestions in the various patches.

Thanks,

Jonathan



