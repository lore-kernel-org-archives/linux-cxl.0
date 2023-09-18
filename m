Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD67CD13DE
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Sep 2023 11:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbjIRLLr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 18 Sep 2023 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241551AbjIRLLh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 18 Sep 2023 07:11:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4553C8F
        for <linux-cxl@vger.kernel.org>; Mon, 18 Sep 2023 04:11:32 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rq2B46Qp9z6HJn9;
        Mon, 18 Sep 2023 19:09:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 12:11:29 +0100
Date:   Mon, 18 Sep 2023 12:11:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <fan.ni@samsung.com>, <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <ayush.m55@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 4/4] hw/cxl: Add get scan media results cmd support
Message-ID: <20230918121128.00004d1e@Huawei.com>
In-Reply-To: <fdylnvbildmd5oxl5datqz63awg2nqacwavif5yhlvbq7qnnoi@bdikubr3uky3>
References: <20230908073152.4386-1-dave@stgolabs.net>
        <20230908073152.4386-5-dave@stgolabs.net>
        <20230912130425.0000569b@Huawei.com>
        <kbznhylcg6qqltagnwrsidsvyetsdvmg4dftbsm2btjlwhqx2c@yy245lt2z6zd>
        <20230913143028.00003fec@Huawei.com>
        <fdylnvbildmd5oxl5datqz63awg2nqacwavif5yhlvbq7qnnoi@bdikubr3uky3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 15 Sep 2023 17:11:27 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 13 Sep 2023, Jonathan Cameron wrote:
> 
> >https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13
> >
> >Fresh and tasty.  Includes 3 series that I've posted with the hope
> >of them merging soon and another one I'll post in a few mins to
> >deal with over long lines...  
> 
> fyi I'm getting the below:
> 
> /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_reset':
> /home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:477: undefined reference to `ct3d_reset'
> /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_exit':
> /home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:466: undefined reference to `ct3_exit'
> /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_realize':
> /home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:428: undefined reference to `ct3_realize'
> /usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_reset':
> /home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:478: undefined reference to `cxl_add_cci_commands'

Thanks.  I'd not noticed the niagara stuff doesn't have it's own kconfig with dependencies.
Gregory, want to send a proper fix defining the various Kconfigs down to the actual build directory?

I'd guess the lazy approach of making CXL_VENDOR
depends on CXL_MEM_DEVICE
should work in meantime.

Jonathan

