Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4D38DF8
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8dSw407sz6K6DL;
	Wed, 10 Jan 2024 01:38:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B4E5140736;
	Wed, 10 Jan 2024 01:40:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 17:40:27 +0000
Date: Tue, 9 Jan 2024 17:40:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/4] hw/cxl: fix build error in cxl_type3_stubs.c
Message-ID: <20240109174026.00000760@Huawei.com>
In-Reply-To: <20231222090051.3265307-2-42.hyeyoo@gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
	<20231222090051.3265307-2-42.hyeyoo@gmail.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 22 Dec 2023 18:00:48 +0900
Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> Fix build errors in cxl_type3_stubs.c due to a the incorrect definition
> of the qmp_cxl_{add,release}_dynamic_capacity functions.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Fan, this one needs squashing into your
hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents
patch in the DCD series. I'll do that in my tree, but just wanted to
make sure you noticed this so we don't end up reintroducing it again by
accident!

Thanks Hyeonggon,

Jonathan

> ---
>  hw/mem/cxl_type3_stubs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 1b54ec028c..d913b11b4d 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -68,14 +68,14 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>      error_setg(errp, "CXL Type 3 support is not compiled in");
>  }
>  
> -void qmp_cxl_add_dynamic_capacity(const char *path,
> +void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
>                                    CXLDCExtentRecordList  *records,
>                                    Error **errp)
>  {
>      error_setg(errp, "CXL Type 3 support is not compiled in");
>  }
>  
> -void qmp_cxl_release_dynamic_capacity(const char *path,
> +void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
>                                        CXLDCExtentRecordList  *records,
>                                        Error **errp)
>  {

