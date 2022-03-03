Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C99C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Mar 2022 17:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiCCRyb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Mar 2022 12:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiCCRya (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Mar 2022 12:54:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B2149B88
        for <linux-cxl@vger.kernel.org>; Thu,  3 Mar 2022 09:53:43 -0800 (PST)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8dqJ4Yrwz67Zy6;
        Fri,  4 Mar 2022 01:52:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 18:53:40 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 3 Mar
 2022 17:53:39 +0000
Date:   Thu, 3 Mar 2022 17:53:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 18/43] qtests/cxl: Add initial root port and CXL
 type3 tests
Message-ID: <20220303175338.0000093d@Huawei.com>
In-Reply-To: <87h78hlewu.fsf@linaro.org>
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
        <20220211120747.3074-19-Jonathan.Cameron@huawei.com>
        <87h78hlewu.fsf@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 01 Mar 2022 18:11:25 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > At this stage we can boot configurations with host bridges,
> > root ports and type 3 memory devices, so add appropriate
> > tests.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  tests/qtest/cxl-test.c | 126 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 126 insertions(+)
> >
> > diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> > index 1006c8ae4e..1436de40e2 100644
> > --- a/tests/qtest/cxl-test.c
> > +++ b/tests/qtest/cxl-test.c
> > @@ -8,6 +8,47 @@
> >  #include "qemu/osdep.h"
> >  #include "libqtest-single.h"
> >  
> > +#define QEMU_PXB_CMD "-machine q35,cxl=on " \
> > +                     "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "
> > +
> > +#define QEMU_2PXB_CMD "-machine q35,cxl=on " \
> > +                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> > +                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "
> > +
> > +#define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
> > +
> > +/* Dual ports on first pxb */
> > +#define QEMU_2RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
> > +                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 "
> > +
> > +/* Dual ports on each of the pxb instances */
> > +#define QEMU_4RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
> > +                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 " \
> > +                 "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
> > +                 "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
> > +
> > +#define QEMU_T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> > +                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,id=cxl-pmem0,size=256M "
> > +
> > +#define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
> > +                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,id=cxl-pmem0,size=256M " \
> > +                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
> > +                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,id=cxl-pmem1,size=256M "
> > +
> > +#define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
> > +                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,id=cxl-pmem0,size=256M " \
> > +                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
> > +                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,id=cxl-pmem1,size=256M " \
> > +                  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
> > +                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,id=cxl-pmem2,size=256M " \
> > +                  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
> > +                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,id=cxl-pmem3,size=256M "
> > +
> > +static void cxl_basic_hb(void)
> > +{
> > +    qtest_start("-machine q35,cxl=on");
> > +    qtest_end();
> > +}
> >  
> >  static void cxl_basic_pxb(void)
> >  {
> > @@ -15,9 +56,94 @@ static void cxl_basic_pxb(void)
> >      qtest_end();
> >  }
> >  
> > +static void cxl_pxb_with_window(void)
> > +{
> > +    qtest_start(QEMU_PXB_CMD);
> > +    qtest_end();
> > +}
> > +
> > +static void cxl_2pxb_with_window(void)
> > +{
> > +    qtest_start(QEMU_2PXB_CMD);
> > +    qtest_end();
> > +}
> > +
> > +static void cxl_root_port(void)
> > +{
> > +    qtest_start(QEMU_PXB_CMD QEMU_RP);
> > +    qtest_end();
> > +}
> > +
> > +static void cxl_2root_port(void)
> > +{
> > +    qtest_start(QEMU_PXB_CMD QEMU_2RP);
> > +    qtest_end();
> > +}
> > +
> > +static void cxl_t3d(void)
> > +{
> > +    GString *cmdline;
> > +    char template[] = "/tmp/cxl-test-XXXXXX";
> > +    const char *tmpfs;
> > +
> > +    tmpfs = mkdtemp(template);
> > +
> > +    cmdline = g_string_new(NULL);
> > +    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D, tmpfs);
> > +
> > +    qtest_start(cmdline->str);
> > +    qtest_end();
> > +
> > +    g_string_free(cmdline, TRUE);  
> 
> For future reference you could do:
> 
>   g_autoptr(GString) cmdline = g_string_new(NULL);
> 
> and drop the free ;-)

nice. Done here and in later qtest patches.

Thanks,

Jonathan
