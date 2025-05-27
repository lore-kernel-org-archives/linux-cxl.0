Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF43F4ED
	for <linux-cxl@vger.kernel.org>; Tue, 27 May 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363330; cv=none; b=J2r2oyPDtk5K72DA5HzJNHF2mzd4XWrUM7CcgvFaiVT8Q53C3lYrIXFY9BNTFLpFBrPZW/TF7f/hi6taVWMg13HE7etItIOANyTPCsEnqwAQeUu7bC29DceOnzDiJ/M7WQFnjGn5+bUtUFakUj62xN5F0CK1VXyBrqmbVVp+IE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363330; c=relaxed/simple;
	bh=wI2hSjwhlWQyp6xZxbIbQ7qTU+46agQCTTfDy6XPt5s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7Gyzq/X5PsQszjcNR2iYKvHhAhgJj0x37zSI6axMZXaiih1jIPF8FMhsWOseSxxo6YcZF6b4lLdrKcS+6dgqML5BWtncaMJhVe8To1XJ28efCvfdxdg6PaHgtP6cw5+v/d8ijk3wC73KXrk1On1toxY6SoUerdwcXqUiiFGcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6HzZ1BNlz6L50R;
	Wed, 28 May 2025 00:25:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EB14814050D;
	Wed, 28 May 2025 00:28:44 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 May
 2025 18:28:44 +0200
Date: Tue, 27 May 2025 17:28:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
	<fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
	"mst@redhat.com" <mst@redhat.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Itaru Kitayama <itaru.kitayama@linux.dev>,
	Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v13 3/5] hw/cxl-host: Allow split of establishing memory
 address and mmio setup.
Message-ID: <20250527172843.000065a9@huawei.com>
In-Reply-To: <c9afd4d7-d755-4e6b-b541-ce29da885a13@fujitsu.com>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
	<20250513111455.128266-4-Jonathan.Cameron@huawei.com>
	<c9afd4d7-d755-4e6b-b541-ce29da885a13@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 16 May 2025 05:50:59 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 13/05/2025 19:14, Jonathan Cameron via wrote:
> >   
> > +hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
> > +{
> > +    GSList *cfmws_list, *iter;
> > +
> > +    struct cfmw_update_state cfmwss = {
> > +        .base = base,
> > +        .maxaddr = max_addr,
> > +        .update_mmio = false,
> > +    };
> > +    cfmws_list = cxl_fmws_get_all_sorted();
> > +    for (iter = cfmws_list; iter; iter = iter->next) {
> > +        cxl_fmws_update(iter->data, &cfmwss);
> > +    }
> > +    g_slist_free(cfmws_list);
> > +
> > +    return cfmwss.base;
> > +}
> > +
> >   hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
> >   {
> >       GSList *cfmws_list, *iter;
> > @@ -445,6 +466,7 @@ hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
> >       struct cfmw_update_state cfmwss = {
> >           .base = base,
> >           .maxaddr = max_addr,
> > +        .update_mmio = true,
> >       };
> >       cfmws_list = cxl_fmws_get_all_sorted();
> >       for (iter = cfmws_list; iter; iter = iter->next) {
> > @@ -455,6 +477,26 @@ hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
> >       return cfmwss.base;
> >   }
> >     
> 
> It seem we can share most of the code in cxl_fmws_set_memmap_and_update_mmio() and cxl_fmws_set_memmap()
> In addition, we can drop the cfmw_update_state::update_mmio if there is no other users. Just pass it
> to cxl_fmws_update() directly.
I'd like to keep the 'documentation' aspect of the function names, but
can reduce duplication with a do_cxl_fmws_set_mmemap_and_update_mmio() function that
has a shared implementation and takes the extra parameter as you suggestion.

Thanks

Jonathan

> 
> 
> Thanks
> Zhijian
