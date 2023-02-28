Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45038C64EC7
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 04:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjB1EKO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 23:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1EKM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 23:10:12 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F00D1E5FD
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 20:10:10 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230228041008usoutp02ef203a4d1b456d97bcd0a59594ec7a09~H4ZMvO9NY0129701297usoutp02Y;
        Tue, 28 Feb 2023 04:10:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230228041008usoutp02ef203a4d1b456d97bcd0a59594ec7a09~H4ZMvO9NY0129701297usoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677557408;
        bh=3OfqJmIQkqUj6FXeIE7qWn6Eo7zKFRSZyQo733n/TQs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=gjOvEa0gUX7RXRlnmSHOVfZBTRg8UrfRrV3PlXcE7vmkFnFpEp+QQ3BiV9HgMS7ix
         GgNWbTbAeUCO+y82sMtVGKyX3ay11RlpCzLOPDPc5KnfLtTI69KA/Y0eN/L4BQLiQh
         a05bNKnaA9+U6NSfGIkTo0CYtiJEJR08/SLkjhCI=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230228041008uscas1p2b44e12079c3e82082c1a3eb06c2096e0~H4ZMmxb8r0602806028uscas1p2Q;
        Tue, 28 Feb 2023 04:10:08 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 9F.BB.06976.0AE7DF36; Mon,
        27 Feb 2023 23:10:08 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228041008uscas1p1296b02da63f7c8c81506d67dafe7ff75~H4ZMXMbol1390613906uscas1p1G;
        Tue, 28 Feb 2023 04:10:08 +0000 (GMT)
X-AuditID: cbfec36d-d99ff70000011b40-c3-63fd7ea0de0b
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 24.99.11378.F9E7DF36; Mon,
        27 Feb 2023 23:10:07 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 27 Feb 2023 20:10:07 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        27 Feb 2023 20:10:07 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 01/10] hw/mem/cxl_type3: Improve error handling in
 realize()
Thread-Topic: [PATCH v4 01/10] hw/mem/cxl_type3: Improve error handling in
        realize()
Thread-Index: AQHZSyqKTjA/cBi6uU2wPwT4M+lsnQ==
Date:   Tue, 28 Feb 2023 04:10:07 +0000
Message-ID: <20230228040957.GA1339780@bgt-140510-bm03>
In-Reply-To: <20230206172816.8201-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9A50D40D9E744345BDB3D9E4E68754E4@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djXc7oL6v4mG/y4xGvRPHkxo8WLP8+Z
        LPY/fc5isWrhNTaL87NOsVgc3niGyeL/r1esFmtWCFsc793B4sDpsXPWXXaPliNvWT0W73nJ
        5LFpVSebx51re9g8nlzbzOTxft9VNo/Pm+QCOKK4bFJSczLLUov07RK4Mn7uWMZeMJu/4tG7
        FYwNjO+4uxg5OSQETCTuT33N1sXIxSEksJJRYt3lB8wQTiuTxPW5f9lgqn7sOAdVtZZRYuXM
        bnYI5xOjxJVXb6Ayyxgldv2YzwTSwiagKLGvaztYu4iAkcS7G5MYQYqYBb4wSUy9u5EFJCEs
        ECqxp+UoM0RRmMTVg89YIGw9iRnb/oMNYhFQlbhy8gDYIF4BM4mjx6cC1XBwcAo4SBzZrggS
        ZhQQk/h+ag1YObOAuMStJxA3SAgISiyavYcZwhaT+LfrIdQ7ihL3v79kh6jXk7gxdQobhG0n
        sXDxRihbW2LZwtfMEGsFJU7OfMIC0SspcXDFDRaQXyQEmjklTuxuhxrqInF3xjQoW1ri6vWp
        zCB3SggkS6z6yAURzpGYv2QL1BxriYV/1jNNYFSZheTsWUhOmoXkpFlITpqF5KQFjKyrGMVL
        i4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAhPa6X+Hc3cw7rj1Ue8QIxMH4yFGCQ5mJRHehbf/
        JAvxpiRWVqUW5ccXleakFh9ilOZgURLnNbQ9mSwkkJ5YkpqdmlqQWgSTZeLglGpgYlM4tEW/
        9hZzGc/8aL/K+rm/b+b8fqbYNqtu2o90ucOem6zvCRyrsH/zasom3Qs8cl4MpZ8P+r7NjH+e
        fIJTcv+vkv8pLbXreA0FGzKWNc+bEbBRau5dFZWcbEYL05Lybu7VGw0X38lcprdhoaT9hOfn
        Pm/bLx+i8qZoYfK7z+3eudMvxJm1C7iLaMw6dVxeenJI9OVNEx4f44sx5ToZFv/GyH6F9kMb
        1h2lxW+vBayN4vNaf8Ig7bp8TNP+la92aanH5OucM+sNfjLxqAKzzCqHgo3F2Surt61+37i9
        y1Bw+btz7ktXqBzfmKqiotu67dartWJLsnhfds7QWCH9kq/dd+/uPw9drD3klXrPKbEUZyQa
        ajEXFScCAIZGTn3XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWS2cA0SXd+3d9kg873FhbNkxczWrz485zJ
        Yv/T5ywWqxZeY7M4P+sUi8XhjWeYLP7/esVqsWaFsMXx3h0sDpweO2fdZfdoOfKW1WPxnpdM
        HptWdbJ53Lm2h83jybXNTB7v911l8/i8SS6AI4rLJiU1J7MstUjfLoEr4+eOZewFs/krHr1b
        wdjA+I67i5GTQ0LAROLHjnNsILaQwGpGiZXvKroYuYDsT4wSm5Y8ZYVwljFKrD+0nwWkik1A
        UWJf13awDhEBI4l3NyYxghQxC3xhkrjx4TtYkbBAqMSelqPMEEVhEhevHmCBsPUkZmz7zwRi
        swioSlw5eQBsEK+AmcTR41NZIM4olbj+6BlQLwcHp4CDxJHtiiBhRgExie+n1oC1MguIS9x6
        Mp8J4gMBiSV7zjND2KISLx//Y4WwFSXuf3/JDlGvJ3Fj6hQ2CNtOYuHijVC2tsSyha+ZIU4Q
        lDg58wkLRK+kxMEVN1gmMErMQrJuFpJRs5CMmoVk1CwkoxYwsq5iFC8tLs5Nryg2zEst1ytO
        zC0uzUvXS87P3cQITAWn/x2O3MF49NZHvUOMTByMhxglOJiVRHgX3v6TLMSbklhZlVqUH19U
        mpNafIhRmoNFSZxXyHVivJBAemJJanZqakFqEUyWiYNTqoFpgvCMFQLOxbcsI5e53W3/MrNu
        nrvT0WcuHN8m+Zzs2qJTuaFw57Omr8I98z5s/1ZZuf3J6tW7XGbus+W7Kdf5/9o3nh6vOu7d
        F/a2fVZwfC/zQ9w0pO/3zMdrd/o/94lWYVMQCXa/zPjmCmuT3oPTDauPH3+701flDme4tv7c
        JHlRPraIUtW3k4wDz0/4lvLmWXTA2t3zOA1nhB3Wckx4MnmB9J4uR71dnOxxXzJXSoq1vdrW
        muwffuzh+fhvt1IPhU3qWx25iaNaRursiTWL2GMEVb9EPpx1YT7LTqaTr7zf3M5bvSBi97Xd
        175NbvuvsNxEPl2y4rGFxyv9Xa8OTT1xbedenS8bJ85Yu/HW7UQlluKMREMt5qLiRADQ6LaL
        dAMAAA==
X-CMS-MailID: 20230228041008uscas1p1296b02da63f7c8c81506d67dafe7ff75
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228041008uscas1p1296b02da63f7c8c81506d67dafe7ff75
References: <20230206172816.8201-1-Jonathan.Cameron@huawei.com>
        <20230206172816.8201-2-Jonathan.Cameron@huawei.com>
        <CGME20230228041008uscas1p1296b02da63f7c8c81506d67dafe7ff75@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 06, 2023 at 05:28:07PM +0000, Jonathan Cameron wrote:
> msix_init_exclusive_bar() can fail, so if it does cleanup the address spa=
ce.
>=20
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/mem/cxl_type3.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index dae4fd89ca..252822bd82 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -401,7 +401,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **e=
rrp)
>      MemoryRegion *mr =3D &regs->component_registers;
>      uint8_t *pci_conf =3D pci_dev->config;
>      unsigned short msix_num =3D 1;
> -    int i;
> +    int i, rc;
> =20
>      if (!cxl_setup_memory(ct3d, errp)) {
>          return;
> @@ -438,7 +438,10 @@ static void ct3_realize(PCIDevice *pci_dev, Error **=
errp)
>                       &ct3d->cxl_dstate.device_registers);
> =20
>      /* MSI(-X) Initailization */
> -    msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
> +    rc =3D msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
> +    if (rc) {
> +        goto err_address_space_free;
> +    }
>      for (i =3D 0; i < msix_num; i++) {
>          msix_vector_use(pci_dev, i);
>      }
> @@ -450,6 +453,11 @@ static void ct3_realize(PCIDevice *pci_dev, Error **=
errp)
>      cxl_cstate->cdat.free_cdat_table =3D ct3_free_cdat_table;
>      cxl_cstate->cdat.private =3D ct3d;
>      cxl_doe_cdat_init(cxl_cstate, errp);
> +    return;
> +
> +err_address_space_free:
> +    address_space_destroy(&ct3d->hostmem_as);
> +    return;
>  }
> =20
>  static void ct3_exit(PCIDevice *pci_dev)
> --=20
> 2.37.2
>=20
> =
