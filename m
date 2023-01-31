Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B320C636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 08:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjAaIzP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 03:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjAaIyk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 03:54:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53924A1DF
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 00:50:08 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5dsf3NFwz6J7dj;
        Tue, 31 Jan 2023 16:45:10 +0800 (CST)
Received: from localhost (10.45.154.62) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 08:49:23 +0000
Date:   Tue, 31 Jan 2023 08:49:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <qemu-devel@nongnu.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 5/8] hw/i386/acpi: Drop duplicate _UID entry for CXL
 root bridge
Message-ID: <20230131084922.00006e7a@Huawei.com>
In-Reply-To: <20230127213645-mutt-send-email-mst@kernel.org>
References: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
        <20230112102644.27830-6-Jonathan.Cameron@huawei.com>
        <20230127213645-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.154.62]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 27 Jan 2023 21:38:20 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jan 12, 2023 at 10:26:41AM +0000, Jonathan Cameron wrote:
> > Noticed as this prevents iASL disasembling the DSDT table.
> > 
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> This needed but it looks like you did not bother updating
> expected files for the tests. Did you run make check?

Sorry, that was sloppy of me.

v3 with table update dance for q35/DSDT.cxl sent out.

(I failed to send this email yesterday).

> 
> > ---
> >  hw/i386/acpi-build.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 127c4e2d50..a584b62ae2 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1482,7 +1482,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >                  aml_append(pkg, aml_eisaid("PNP0A03"));
> >                  aml_append(dev, aml_name_decl("_CID", pkg));
> >                  aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > -                aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> >                  build_cxl_osc_method(dev);
> >              } else if (pci_bus_is_express(bus)) {
> >                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> > -- 
> > 2.37.2  
> 

