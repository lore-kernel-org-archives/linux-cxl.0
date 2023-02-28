Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F282C64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 04:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjB1EMX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 23:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1EMW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 23:12:22 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02FE23847
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 20:12:21 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230228041221usoutp023b1ad00848c27e11012ef15c8665e146~H4bINBP950127701277usoutp02k;
        Tue, 28 Feb 2023 04:12:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230228041221usoutp023b1ad00848c27e11012ef15c8665e146~H4bINBP950127701277usoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677557541;
        bh=z+EeJwvhXgPiB+2z2lB0k5mwKsj/ecXFn0Pfu4ps+3E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=E1giW0zPR9D9sVTkDcFwCvnLxqgkFNiWs+3rmR+JAf28zfikwQCOejfhAGIcxE/7f
         7w8lVZcgI3vwszDzT0bLM5/wGRm4QkyRcWSmgmWMpm1lGAA1I/qxtatUh/NdOw4CXk
         aLo6q4ci6mbYYVHYgMnqAoH7SRcfk3BT1eIpPOWo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228041220uscas1p150c5163096efb7cbcf78110cd7f859f9~H4bHsmdD02860128601uscas1p19;
        Tue, 28 Feb 2023 04:12:20 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 78.B8.49129.42F7DF36; Mon,
        27 Feb 2023 23:12:20 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228041219uscas1p140e49d902024e0eab1eb1cf3cba168fa~H4bG8q2kf2860228602uscas1p1m;
        Tue, 28 Feb 2023 04:12:19 +0000 (GMT)
X-AuditID: cbfec36f-167fe7000001bfe9-49-63fd7f248e52
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 36.E8.17110.32F7DF36; Mon,
        27 Feb 2023 23:12:19 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 27 Feb 2023 20:12:18 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        27 Feb 2023 20:12:18 -0800
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
Subject: Re: [PATCH v4 05/10] tests/acpi: Allow update of q35/DSDT.cxl
Thread-Topic: [PATCH v4 05/10] tests/acpi: Allow update of q35/DSDT.cxl
Thread-Index: AQHZSyrZ4NvNbCkdmkq/SpOgF8iyFw==
Date:   Tue, 28 Feb 2023 04:12:18 +0000
Message-ID: <20230228041218.GE1339780@bgt-140510-bm03>
In-Reply-To: <20230206172816.8201-6-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6CABAB1D50384349BAC6A4CD41B80B57@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djXc7oq9X+TDa7PELdonryY0eLFn+dM
        FvufPmexWLXwGpvF+VmnWCwObzzDZPH/1ytWizUrhC2O9+5gceD02DnrLrtHy5G3rB6L97xk
        8ti0qpPN4861PWweT65tZvJ4v+8qm8fnTXIBHFFcNimpOZllqUX6dglcGf1PP7IV3GerOLZo
        HlsD4wPWLkZODgkBE4nbR++zdTFycQgJrGSUuD27hR3CaWWSmHy+jRmm6uTuYywQibWMEvMu
        HYNq+cQoseb2WWYIZxmQM/kmO0gLm4CixL6u7WwgtoiAkcS7G5MYQYqYBb4wSUy9u5EFJCEs
        4CbR+u0sM0SRu8TnBz9ZIWw9icez2oEaODhYBFQlNi5hATF5Bcwk+iZoglRwCjhIbNv2Hmw8
        o4CYxPdTa5hAbGYBcYlbT+YzQVwtKLFo9h6oD8Qk/u16yAZhK0rc//6SHaJeT+LG1ClsELad
        xO17fSwQtrbEsoWvwXp5geacnPmEBaJXUuLgihvgkJAQ+M8hsX7iDmhAukj077kOtUBa4u/d
        ZUwgN0sIJEus+sgFEc6RmL9kC9Qca4mFf9YzTWBUmYXk7FlITpqF5KRZSE6aheSkBYysqxjF
        S4uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQLT2el/h/N3MF6/9VHvECMTB+MhRgkOZiUR3oW3
        /yQL8aYkVlalFuXHF5XmpBYfYpTmYFES5zW0PZksJJCeWJKanZpakFoEk2Xi4JRqYGr6fvBf
        WPq9/+LfO/a9fd4WO+XYd/fE85y7jk84vvvAlUNHN5vbfmsP+3cufMGsL81XEm3K9v5QO3/n
        FUPLj5CpO6puXPv74tG6wsn3Qz4obFW/92W77f6G2b8X8rc+4QvRuL5a8JL8vbuBT77rHLbJ
        m8UmWztLWqzOjs2vSP7upKmB5p8nfIq8LcbHe5fjo7Mq9/7fl9L39bcobP2k2NPillLzNjth
        7iuRyr/ph+d8+SQwceF7rx9tj72KQmcc15a0cHddY/rs74ILCiKGa63b17U/v+Lafe6faOVs
        iezwoDNzjxcdWhg88fUUjmU3ufuMntnuO205zTjkY5zIeQuxtt03ko6d42sQu8yuELVonRJL
        cUaioRZzUXEiAKk0jInWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWS2cA0SVe5/m+ywad3ShbNkxczWrz485zJ
        Yv/T5ywWqxZeY7M4P+sUi8XhjWeYLP7/esVqsWaFsMXx3h0sDpweO2fdZfdoOfKW1WPxnpdM
        HptWdbJ53Lm2h83jybXNTB7v911l8/i8SS6AI4rLJiU1J7MstUjfLoEro//pR7aC+2wVxxbN
        Y2tgfMDaxcjJISFgInFy9zEWEFtIYDWjRMsK2S5GLiD7E6PEi5VXWSCcZYwSb1+2MYJUsQko
        Suzr2s4GYosIGEm8uzGJEaSIWeALk8SND9/BRgkLuEm0fjvLDFHkLvH5wU9WCFtP4vGsdqAG
        Dg4WAVWJjUtYQExeATOJvgmaEEeUSsw8Oh9sCqeAg8S2be/BVjEKiEl8P7WGCcRmFhCXuPVk
        PhPEAwISS/acZ4awRSVePv4H9ZiixP3vL9kh6vUkbkydwgZh20ncvtfHAmFrSyxb+Bqsl1dA
        UOLkzCcsEL2SEgdX3GCZwCgxC8m6WUhGzUIyahaSUbOQjFrAyLqKUby0uDg3vaLYKC+1XK84
        Mbe4NC9dLzk/dxMjMBGc/nc4egfj7Vsf9Q4xMnEwHmKU4GBWEuFdePtPshBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHel1ET44UE0hNLUrNTUwtSi2CyTBycUg1MPMITT/y70fiKT+xh90MXcxP7
        DTLT2650RmscPR4cJlUVWbJjpY1BsEmTy5mZ1RLsnd0PV7I1NBa0BxV2a0hu0vaO/nfy46zD
        RVPWfbp240xDfv8rjozHpmmXGQ6pPXro9XNHjbmcvGCmlZNU6w6XX1XzTE68fnM5+/KnGbxv
        u0q7ZL+cjJKO/m4c/Z+7z3iBo6n53w+qu7VWHg/LWC+yhX95y5RjXMecDQJ3pIsLmG6y8lDq
        l9jQmD5pXs5z1RMfE8KlQhbPvdv4buGRe7OeGmUbRvvx7o55vmixsYGR5aK5ske5reMrs6V2
        sdUu/3w97HPPdU/Pbp6re2eZeH48Hrd2h8cZRnFzow/zrs1XYinOSDTUYi4qTgQAp63kZnMD
        AAA=
X-CMS-MailID: 20230228041219uscas1p140e49d902024e0eab1eb1cf3cba168fa
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228041219uscas1p140e49d902024e0eab1eb1cf3cba168fa
References: <20230206172816.8201-1-Jonathan.Cameron@huawei.com>
        <20230206172816.8201-6-Jonathan.Cameron@huawei.com>
        <CGME20230228041219uscas1p140e49d902024e0eab1eb1cf3cba168fa@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 06, 2023 at 05:28:11PM +0000, Jonathan Cameron wrote:
> Next patch will drop duplicate _UID entry so allow update.
>=20
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..9ce0f596cc 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/DSDT.cxl",
> --=20
> 2.37.2
>=20
> =
