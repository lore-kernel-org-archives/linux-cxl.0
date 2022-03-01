Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36994C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Mar 2022 18:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiCASOI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbiCASOH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Mar 2022 13:14:07 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC724BDA
        for <linux-cxl@vger.kernel.org>; Tue,  1 Mar 2022 10:13:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id r13so33175801ejd.5
        for <linux-cxl@vger.kernel.org>; Tue, 01 Mar 2022 10:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DQAbB6wKQQ6wxqSXqBT0TsbD3Jc00NpvT+qsB4Q96Hs=;
        b=YFeLIi1unrQPs1ShvQc4yilmZW5SrdZiYuXr60lU8CMZurn2vpdfXXjh9mE/S0eY7O
         hmx4bT+IfgTnl/e2vnn0XpbmkDaT9Q4xARzeHxtK0gPtRahLhQJrqJMr2x8m+wa32IlL
         bSHAkftEZP5ox1wrerLuuLGz+6wZOpjkQhj9TAW+V7/VvPZ1Eq7XTpc7dZDD1d203kEK
         +Qxy5NVDRGaTTbXZXCET+gzA+mqFInNC4EcK2N+jU6DVWKIwhiYK0dEjHnNxl6oUZ8GI
         tgijpFN++Fg81+mb2eZo+Jp/vKC24AwUxrA8QK1ytaEsOtBFwpQjrLc3J7cDbSnU+VEh
         VgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DQAbB6wKQQ6wxqSXqBT0TsbD3Jc00NpvT+qsB4Q96Hs=;
        b=1hzfJtRoeq1A6SrBiPGEn62JPvHCh0AMgcRuXcjBXyOIy5IeZ/8Ypp/WQC5uPjI4h7
         RqFOrtbV0qHzEdbXM/uA63O59fcZzH8HHKMx+oCXsrnGSQ2CVTE+Nip6/DmhR8mBL39e
         ZCNmK8fgy8NN7Dn4ha+dx68eMNnV9NgOXzNkv+cSTLrMeBg3tLifgA6pCFDksvJBXp4c
         PmIRbiC4XPJiMhyImlNATXOOCXdg/vyUM3sFUCKmrFtDOowg2oq8ksyBpZRRKDb8tugr
         /PADjx91fyAbS9J2isHKBOlU2GjVkym0OEn+oBjHqHNlqvoCgZYsPsbiUgO6EIKHHxIF
         w9HA==
X-Gm-Message-State: AOAM531IbYNdSWRLehXVrkTfAUdkZAJCypFW4QbfdBrgPiE1F6iOkRhA
        KVwqeiH90lDGcgUKbFvvMbtt/w==
X-Google-Smtp-Source: ABdhPJyLH7S1zDTjGNYhDfTUnqKe7lR5uP9D0hF4fjI/CEZd3sm+n3YQax/O8wNk74KaR8h1iEjuXQ==
X-Received: by 2002:a17:906:8549:b0:69f:25ee:b38e with SMTP id h9-20020a170906854900b0069f25eeb38emr19925030ejy.443.1646158404204;
        Tue, 01 Mar 2022 10:13:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id v5-20020a056402184500b00412e1a73c7bsm7370907edy.61.2022.03.01.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:13:22 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id E78D91FFB7;
        Tue,  1 Mar 2022 18:13:21 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-19-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.9; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 18/43] qtests/cxl: Add initial root port and CXL
 type3 tests
Date:   Tue, 01 Mar 2022 18:11:25 +0000
In-reply-to: <20220211120747.3074-19-Jonathan.Cameron@huawei.com>
Message-ID: <87h78hlewu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> At this stage we can boot configurations with host bridges,
> root ports and type 3 memory devices, so add appropriate
> tests.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  tests/qtest/cxl-test.c | 126 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index 1006c8ae4e..1436de40e2 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -8,6 +8,47 @@
>  #include "qemu/osdep.h"
>  #include "libqtest-single.h"
>=20=20
> +#define QEMU_PXB_CMD "-machine q35,cxl=3Don " \
> +                     "-device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D5=
2 "
> +
> +#define QEMU_2PXB_CMD "-machine q35,cxl=3Don " \
> +                      "-device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D=
52 "  \
> +                      "-device pxb-cxl,id=3Dcxl.1,bus=3Dpcie.0,bus_nr=3D=
53 "
> +
> +#define QEMU_RP "-device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,slot=3D=
0 "
> +
> +/* Dual ports on first pxb */
> +#define QEMU_2RP "-device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,slot=
=3D0 " \
> +                 "-device cxl-rp,id=3Drp1,bus=3Dcxl.0,chassis=3D0,slot=
=3D1 "
> +
> +/* Dual ports on each of the pxb instances */
> +#define QEMU_4RP "-device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,slot=
=3D0 " \
> +                 "-device cxl-rp,id=3Drp1,bus=3Dcxl.0,chassis=3D0,slot=
=3D1 " \
> +                 "-device cxl-rp,id=3Drp2,bus=3Dcxl.1,chassis=3D0,slot=
=3D2 " \
> +                 "-device cxl-rp,id=3Drp3,bus=3Dcxl.1,chassis=3D0,slot=
=3D3 "
> +
> +#define QEMU_T3D "-object memory-backend-file,id=3Dcxl-mem0,mem-path=3D%=
s,size=3D256M " \
> +                 "-device cxl-type3,bus=3Drp0,memdev=3Dcxl-mem0,id=3Dcxl=
-pmem0,size=3D256M "
> +
> +#define QEMU_2T3D "-object memory-backend-file,id=3Dcxl-mem0,mem-path=3D=
%s,size=3D256M "    \
> +                  "-device cxl-type3,bus=3Drp0,memdev=3Dcxl-mem0,id=3Dcx=
l-pmem0,size=3D256M " \
> +                  "-object memory-backend-file,id=3Dcxl-mem1,mem-path=3D=
%s,size=3D256M "    \
> +                  "-device cxl-type3,bus=3Drp1,memdev=3Dcxl-mem1,id=3Dcx=
l-pmem1,size=3D256M "
> +
> +#define QEMU_4T3D "-object memory-backend-file,id=3Dcxl-mem0,mem-path=3D=
%s,size=3D256M "    \
> +                  "-device cxl-type3,bus=3Drp0,memdev=3Dcxl-mem0,id=3Dcx=
l-pmem0,size=3D256M " \
> +                  "-object memory-backend-file,id=3Dcxl-mem1,mem-path=3D=
%s,size=3D256M "    \
> +                  "-device cxl-type3,bus=3Drp1,memdev=3Dcxl-mem1,id=3Dcx=
l-pmem1,size=3D256M " \
> +                  "-object memory-backend-file,id=3Dcxl-mem2,mem-path=3D=
%s,size=3D256M "    \
> +                  "-device cxl-type3,bus=3Drp2,memdev=3Dcxl-mem2,id=3Dcx=
l-pmem2,size=3D256M " \
> +                  "-object memory-backend-file,id=3Dcxl-mem3,mem-path=3D=
%s,size=3D256M "    \
> +                  "-device cxl-type3,bus=3Drp3,memdev=3Dcxl-mem3,id=3Dcx=
l-pmem3,size=3D256M "
> +
> +static void cxl_basic_hb(void)
> +{
> +    qtest_start("-machine q35,cxl=3Don");
> +    qtest_end();
> +}
>=20=20
>  static void cxl_basic_pxb(void)
>  {
> @@ -15,9 +56,94 @@ static void cxl_basic_pxb(void)
>      qtest_end();
>  }
>=20=20
> +static void cxl_pxb_with_window(void)
> +{
> +    qtest_start(QEMU_PXB_CMD);
> +    qtest_end();
> +}
> +
> +static void cxl_2pxb_with_window(void)
> +{
> +    qtest_start(QEMU_2PXB_CMD);
> +    qtest_end();
> +}
> +
> +static void cxl_root_port(void)
> +{
> +    qtest_start(QEMU_PXB_CMD QEMU_RP);
> +    qtest_end();
> +}
> +
> +static void cxl_2root_port(void)
> +{
> +    qtest_start(QEMU_PXB_CMD QEMU_2RP);
> +    qtest_end();
> +}
> +
> +static void cxl_t3d(void)
> +{
> +    GString *cmdline;
> +    char template[] =3D "/tmp/cxl-test-XXXXXX";
> +    const char *tmpfs;
> +
> +    tmpfs =3D mkdtemp(template);
> +
> +    cmdline =3D g_string_new(NULL);
> +    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D, tmpfs);
> +
> +    qtest_start(cmdline->str);
> +    qtest_end();
> +
> +    g_string_free(cmdline, TRUE);

For future reference you could do:

  g_autoptr(GString) cmdline =3D g_string_new(NULL);

and drop the free ;-)

> +}
> +
> +static void cxl_1pxb_2rp_2t3d(void)
> +{
> +    GString *cmdline;
> +    char template[] =3D "/tmp/cxl-test-XXXXXX";
> +    const char *tmpfs;
> +
> +    tmpfs =3D mkdtemp(template);
> +
> +    cmdline =3D g_string_new(NULL);
> +    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_2RP QEMU_2T3D, tmpfs, tmp=
fs);
> +
> +    qtest_start(cmdline->str);
> +    qtest_end();
> +
> +    g_string_free(cmdline, TRUE);
> +}
> +
> +static void cxl_2pxb_4rp_4t3d(void)
> +{
> +    GString *cmdline;
> +    char template[] =3D "/tmp/cxl-test-XXXXXX";
> +    const char *tmpfs;
> +
> +    tmpfs =3D mkdtemp(template);
> +
> +    cmdline =3D g_string_new(NULL);
> +    g_string_printf(cmdline, QEMU_2PXB_CMD QEMU_4RP QEMU_4T3D,
> +                    tmpfs, tmpfs, tmpfs, tmpfs);
> +
> +    qtest_start(cmdline->str);
> +    qtest_end();
> +
> +    g_string_free(cmdline, TRUE);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
>      qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> +    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
> +    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
> +    qtest_add_func("/pci/cxl/rp", cxl_root_port);
> +    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
> +    qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
> +    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> +    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp=
_4t3d);
>      return g_test_run();
>  }

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
