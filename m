Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FCDEE3F31
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 21:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjILV03 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 17:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjILV02 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 17:26:28 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E210CA
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 14:26:25 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230912212624usoutp01c74e181be2e4e95ca344e4d54617bf51~EQ97RUayP1342113421usoutp01L;
        Tue, 12 Sep 2023 21:26:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230912212624usoutp01c74e181be2e4e95ca344e4d54617bf51~EQ97RUayP1342113421usoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694553984;
        bh=dG030Afgr7kI1bAa0mdYDuWl9G3i4mbEi6p4ncG1X4o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=OvrTVgzZNW0eKSf+Ywbmrj9xWGZdWQbCKOVAEcMdzXanw2jZQhg3kXZkr4Rhi/JYt
         vJgwnk9hPGM8I0IsQzCXTBvP+XaFzyIGScR+bcnyAeCwMlhy/lUtrztVfVzllFGXka
         rSD6R4N8abA2YPsCF/5vWeqHtEe2v9O0pu9EMHuA=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912212623uscas1p1620f0e2dc31cb7913e2947ec9c29a08b~EQ97Eme3c0565905659uscas1p1C;
        Tue, 12 Sep 2023 21:26:23 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id B2.BB.50148.F77D0056; Tue,
        12 Sep 2023 17:26:23 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912212623uscas1p126ccb3e11966c55997487662157329ab~EQ96zhNgo2039620396uscas1p1v;
        Tue, 12 Sep 2023 21:26:23 +0000 (GMT)
X-AuditID: cbfec36d-7bdff7000002c3e4-6b-6500d77f17e4
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 4A.14.28590.F77D0056; Tue,
        12 Sep 2023 17:26:23 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 12 Sep 2023 14:26:22 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        12 Sep 2023 14:26:22 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Li Zhijian" <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH 4/4] docs/cxl: Change to lowercase as others
Thread-Topic: [PATCH 4/4] docs/cxl: Change to lowercase as others
Thread-Index: AQHZ3zPxuQPHf7bpkUqEeXB14iYtR7AYNn4A
Date:   Tue, 12 Sep 2023 21:26:22 +0000
Message-ID: <20230912212622.GC2859961@sjcvldevvm72>
In-Reply-To: <20230904132806.6094-5-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B4BAD5E3404CD6439967AE212CA2AE9E@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djXc7r11xlSDXq26lmcuNnIZrFq4TU2
        i/OzTrFYHN54hsli3a3/rBb/f71itVizQtjieO8OFgcOj/8HJzF7tBx5y+qxeM9LJo871/aw
        eTy5tpnJ4/2+q2wenzfJBbBHcdmkpOZklqUW6dslcGXsnzuRqeCqcMWNvU8ZGxgn8XUxcnJI
        CJhI3Ln3h62LkYtDSGAlo8TPX/OYIJxWJomWT3vYYKp2N0xnhEisZZQ4f+M7M4TziVGipWs9
        C4SzjFFi9oPHjCAtbAKKEvu6toO1iwgYSby7MQkszixwjkmiYY0ZiC0s4CBxq2E3C0SNo8Sl
        67/h6ufuA9nAycEioCrx4HMfWJxXwFiibdtXsDgnUO+fWRvB4owCYhLfT61hgpgvLnHryXwm
        iLMFJRbN3sMMYYtJ/Nv1EOodRYn731+yQ9TrSdyYOoUNwraT+LhkNtQcbYllC18zQ+wVlDg5
        8wkLRK+kxMEVN8AelhB4wiFxY9lbqKEuEk9P/2aEsKUlrl6fCtTMAWQnS6z6yAURzpGYv2QL
        1BxriYV/1jNNYFSZheTsWUhOmoXkpFlITpqF5KQFjKyrGMVLi4tz01OLDfNSy/WKE3OLS/PS
        9ZLzczcxApPX6X+Hc3cw7rj1Ue8QIxMH4yFGCQ5mJRHekkN/U4R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzGtqeTBYSSE8sSc1OTS1ILYLJMnFwSjUwLZoZ67vz7D/RSBcjhsUFXUUedU/jpppe
        rj1746AGt6nE+jSNzafuNe5bKr/2zUKmAq0l7D2uap7yjuefiK0KUDR9s3GvUN8CthtXH+e3
        XzlUNNtYfiXvn9zgpniRqyeX9i2ZHvDfuSpkwb1ppVPP77vIcHPmUmXD2p6pzt6NhmkJYdle
        xyTEf66L7DJJ2HbL+U6Z6P0JC8Skzs232niguWWW8Lw5s3//W2aa+C3VaPaSGJOb00M3rtjQ
        eVlqV3WX66xHM5bkhP94afRr557Hq95mhre0r9zwj7nqWcjXtzH3U3/UcKj+1VtftllY5/r1
        Q5FV022dn09L33L0SmTd1qPR4v2v9xszPQuv+XowcKMSS3FGoqEWc1FxIgBn5/X7zQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWS2cA0Ubf+OkOqwc82GYsTNxvZLFYtvMZm
        cX7WKRaLwxvPMFmsu/Wf1eL/r1esFmtWCFsc793B4sDh8f/gJGaPliNvWT0W73nJ5HHn2h42
        jyfXNjN5vN93lc3j8ya5APYoLpuU1JzMstQifbsEroz9cycyFVwVrrix9yljA+Mkvi5GTg4J
        AROJ3Q3TGbsYuTiEBFYzSrz81g/lfGKUmDjjDAuEs4xRYt2BPjaQFjYBRYl9XdvBbBEBI4l3
        NyYxgtjMAueYJBrWmIHYwgIOErcadrNA1DhKXLr+G65+7r7vzCA2i4CqxIPPEDN5BYwl2rZ9
        ZYZYdpJRYtKPeawgCU6gQX9mbQQrYhQQk/h+ag0TxDJxiVtP5jNB/CAgsWTPeWYIW1Ti5eN/
        rBC2osT97y/ZIer1JG5MncIGYdtJfFwyG2qOtsSyha+ZIY4QlDg58wkLRK+kxMEVN1gmMErM
        QrJuFpJRs5CMmoVk1CwkoxYwsq5iFC8tLs5Nryg2zEst1ytOzC0uzUvXS87P3cQIjP3T/w5H
        7mA8euuj3iFGJg7GQ4wSHMxKIrwlh/6mCPGmJFZWpRblxxeV5qQWH2KU5mBREufdMeViipBA
        emJJanZqakFqEUyWiYNTqoHJ9Z30g9Xf6oRDdB3lXlXVHe86cJM38eRBBkXfW9xuCroKryzP
        7BKuiphk8MpuqqO95LHqtzs25xT7nr54+1X85A0LYtb16Om9bxH49HZNld4XiSvTvKZN/yx2
        RTKkdLrerIYVy2w/O52Q2Lh225mbTn1q7kqNn2bp+Gzj3FnwXD/J8dvs7L3H/Rcoz0jPXaWn
        Y5o4MeDiX12vO6fmmMWc4TTP0ePXfbive7mhfSb3KaGZZTuYNUMuZl0z47xicVH/+j6nO7c3
        FB3fuK5h0ZEfK8x2MBdvY8lNMF2mJL750rzGs4yqL8sy7PNvax/+JTRnXvAE59sPWrcve+3I
        wHhq2stHP47aSt1ruSOdbBOQp8RSnJFoqMVcVJwIAL/AZJBsAwAA
X-CMS-MailID: 20230912212623uscas1p126ccb3e11966c55997487662157329ab
CMS-TYPE: 301P
X-CMS-RootMailID: 20230904133015uscas1p20abb7c3cb2dfc05225c31c8eb54ff02b
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
        <CGME20230904133015uscas1p20abb7c3cb2dfc05225c31c8eb54ff02b@uscas1p2.samsung.com>
        <20230904132806.6094-5-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 04, 2023 at 02:28:06PM +0100, Jonathan Cameron wrote:
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>=20
> Using the same style as elsewhere for topology / topo
>=20
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Link: https://urldefense.com/v3/__https://lore.kernel.org/r/2023051908580=
2.2106900-2-lizhijian@cn.fujitsu.com__;!!EwVzqGoTKBqv-0DWAJBm!TWHVrdL5Ys7OO=
FU_w1CJQ5DC6mxu649kYA9GYDJ182CNPuQqpVkWYsB5mlJpVd_BAAmhxCD4Si2CkMERZI7ZE03k=
Pz2c$=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  docs/system/devices/cxl.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index f12011e230..b742120657 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -157,7 +157,7 @@ responsible for allocating appropriate ranges from wi=
thin the CFMWs
>  and exposing those via normal memory configurations as would be done
>  for system RAM.
> =20
> -Example system Topology. x marks the match in each decoder level::
> +Example system topology. x marks the match in each decoder level::
> =20
>    |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
>    |    __________   __________________________________   __________    |
> @@ -187,8 +187,8 @@ Example system Topology. x marks the match in each de=
coder level::
>         ___________|___   __________|__   __|_________   ___|_________
>     (3)|  Root Port 0  | | Root Port 1 | | Root Port 2| | Root Port 3 |
>        |  Appears in   | | Appears in  | | Appears in | | Appear in   |
> -      |  PCI topology | | PCI Topology| | PCI Topo   | | PCI Topo    |
> -      |  As 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
> +      |  PCI topology | | PCI topology| | PCI topo   | | PCI topo    |
> +      |  as 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
>        |_______________| |_____________| |____________| |_____________|
>              |                  |               |              |
>              |                  |               |              |
> @@ -272,7 +272,7 @@ Example topology involving a switch::
>        |  Root Port 0  |
>        |  Appears in   |
>        |  PCI topology |
> -      |  As 0c:00.0   |
> +      |  as 0c:00.0   |
>        |___________x___|
>                    |
>                    |
> --=20
> 2.39.2
> =
