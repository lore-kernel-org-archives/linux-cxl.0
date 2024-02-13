Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1C5F866
	for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841938; cv=none; b=Jq2W8imLOxjn2T1/hV4JZNlNKTqXwTsBh4j0WA2xfh6RPXU6LqIhHbQllN9XJLFyfAIJS69HpXA3xovpusQz5aR56mobjB047vCAyQnlnGwnyY+t8lfl19Jhu/0kr1iS9iLgJaZggVPopvizXuXern5I0uRBFcNIcGja6IiiXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841938; c=relaxed/simple;
	bh=Qvq+LRtXRavtcJIo3DNo9zfx30LBOMgXMGmQ5lVcCc4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5B0BJJQ33eO9F79bjXkqmTkYdMQJLia+oucm73Y6NeVizFdYOysoOwFh05bV6LfNPwLr2ChzcoU7LgU0skz6YjyOf3cO9+M6fH0ZnodbWi6XZWxxdI8PSHSqlGSeoNe25bxg3hnIt9Bvg/Jv+60+8IID2BGjsL1YKZjX95JAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZ6G76J7pz67LyQ;
	Wed, 14 Feb 2024 00:28:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D5C82140B63;
	Wed, 14 Feb 2024 00:32:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 16:32:12 +0000
Date: Tue, 13 Feb 2024 16:32:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 2/2] hw/cxl/type3: send a GMER while injecting
 poison
Message-ID: <20240213163211.000063d5@Huawei.com>
In-Reply-To: <20240209115417.724638-3-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
	<20240209115417.724638-3-ruansy.fnst@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri,  9 Feb 2024 19:54:12 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> Send a signal to OS to let it able to handle the poison range.
> 
> TODO: This is an rough draft, will add more parameters for
> qmp_cxl_inject_poison() to set to GMER.

I wonder if that's the best plan or if we should think about
providing some default memory topology and perhaps a means
to override it.   Adding more parameters to the injection
commands works for qmp injection but not for mailbox based
injection from the host for example.

If we have a DPA to channel, rank, etc default mapping then
we should be able to fill them all in based on just the DPA
but allow them to be overridden from the existing GMER
injection (so other test cases can be poked).

One comment inline.

Jonathan

> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  hw/mem/cxl_type3.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index d8fb63b1de..813f7f2175 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1116,6 +1116,11 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>  
>      QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
>      ct3d->poison_list_cnt++;
> +
> +    /* Emit an GMER event, let os handle it */
> +    qmp_cxl_inject_general_media_event(path, CXL_EVENT_LOG_FAILURE, 0, start,
> +                                       0, 0, 4, false, 0, false, 0,
> +                                       false, 0, NULL, errp);

This results in some slightly messy duplication of effort. I'd like to see the
parts we need factored out of the qmp_cxl_inject_general_media_event()
so that we don't end up looking up the device twice and similar.
Pull the code we need in both places out to
cxl_inject_general_media_event(CXLType3 *ct3d, ...

helper in a precursor patch and reuse that code here.

  }
>  
>  /* For uncorrectable errors include support for multiple header recording */

