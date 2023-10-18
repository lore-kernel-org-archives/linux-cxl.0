Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340E3D39C
	for <linux-cxl@vger.kernel.org>; Wed, 18 Oct 2023 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2680FA
	for <linux-cxl@vger.kernel.org>; Wed, 18 Oct 2023 09:37:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S9bz81cLFz6J9TW;
	Thu, 19 Oct 2023 00:34:28 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 17:37:50 +0100
Date: Wed, 18 Oct 2023 17:37:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jeongtae Park <jtp.park@samsung.com>
CC: Adam Manzanares <a.manzanares@samsung.com>, Alison Schofield
	<alison.schofield@intel.com>, Ayush Mishra <ayush.m55@samsung.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Fan Ni <fan.ni@samsung.com>, <gourry.memverge@gmail.com>,
	<linux-cxl@vger.kernel.org>, Kyungsan Kim <ks0204.kim@samsung.com>, "Wonjae
 Lee" <wj28.lee@samsung.com>, Hojin Nam <hj96.nam@samsung.com>, Junhyeok Im
	<junhyeok.im@samsung.com>, Jehoon Park <jehoon.park@samsung.com>, "Youngshin
 Park" <yshin0.park@samsung.com>, Jeongtae Park <jeongtae.park@gmail.com>
Subject: Re: hw/cxl: avoid build error with lower(<=9) gcc versions
Message-ID: <20231018173749.00000e53@huawei.com>
In-Reply-To: <20231014120322.4145387-1-jtp.park@samsung.com>
References: <CGME20231014120038epcas2p388517f5719bcd6517ff83580aebe9f53@epcas2p3.samsung.com>
	<20231014120322.4145387-1-jtp.park@samsung.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 14 Oct 2023 21:03:22 +0900
Jeongtae Park <jtp.park@samsung.com> wrote:

> We are testing on the below branch[1] and getting the following build
> error when using gcc-9 or gcc-7 (gcc-11 is ok).
> 
> I was reported in private to Jonathan Cameron, and he will get rid of
> it soon.
> 
> This is just for your information and for keeping on list.
> 
> Thanks
> /jtpark
> 
> [1]: https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13/
> 
> Reported-by: Kyungsan Kim <ks0204.kim@samsung.com>
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
FWIW this affects CLANG as well. I have no idea why reducing the scope 
surrounding a _Static_assert() has the affect.  If anyone has any pointers
to why that would be great.  Same thing in a build issue report from Michael.

> ---
>  hw/cxl/cxl-component-utils.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index c022a90774..fd15d9a61e 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -325,9 +325,11 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>      case CXL2_ROOT_PORT:
>      case CXL2_UPSTREAM_PORT:
>      case CXL2_DOWNSTREAM_PORT:
> -        init_cap_reg(RAS, 2, 2);
> -        ras_init_common(reg_state, write_msk);
> -        break;
> +        {
> +            init_cap_reg(RAS, 2, 2);
> +            ras_init_common(reg_state, write_msk);
> +            break;
> +        }
>      default:
>          break;
>      }

