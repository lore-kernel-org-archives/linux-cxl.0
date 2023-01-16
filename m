Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9144C46467
	for <linux-cxl@archiver.kernel.org>; Mon, 16 Jan 2023 11:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjAPLEL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 16 Jan 2023 06:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjAPLEJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 16 Jan 2023 06:04:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC4F10E8
        for <linux-cxl@vger.kernel.org>; Mon, 16 Jan 2023 03:04:05 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NwTbX5Y7lz6H6mV;
        Mon, 16 Jan 2023 19:01:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 11:04:02 +0000
Date:   Mon, 16 Jan 2023 11:04:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mike Maslenkin <mike.maslenkin@gmail.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>, "Dave Jiang" <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 7/7] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
Message-ID: <20230116110402.00003294@Huawei.com>
In-Reply-To: <CAL77WPBFT5Ty56bOQR4aQqxi=GZYbwZELiZhkWzB4F-Wn0pZGg@mail.gmail.com>
References: <20230113161711.7885-1-Jonathan.Cameron@huawei.com>
        <20230113161711.7885-8-Jonathan.Cameron@huawei.com>
        <CAL77WPBFT5Ty56bOQR4aQqxi=GZYbwZELiZhkWzB4F-Wn0pZGg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Mike,

> > +static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
> > +{
> > +    switch (qmp_err) {
> > +    case CXL_UNCOR_ERROR_TYPE_CACHE_DATA_PARITY:
> > +        return CXL_RAS_UNC_ERR_CACHE_DATA_PARITY;
> > +    case CXL_UNCOR_ERROR_TYPE_CACHE_ADDRESS_PARITY:
> > +        return CXL_RAS_UNC_ERR_CACHE_ADDRESS_PARITY;
> > +    case CXL_UNCOR_ERROR_TYPE_CACHE_BE_PARITY:
> > +        return CXL_RAS_UNC_ERR_CACHE_BE_PARITY;
> > +    case CXL_UNCOR_ERROR_TYPE_CACHE_DATA_ECC:
> > +        return CXL_RAS_UNC_ERR_CACHE_DATA_ECC;
> > +    case CXL_UNCOR_ERROR_TYPE_MEM_DATA_PARITY:
> > +        return CXL_RAS_UNC_ERR_MEM_DATA_PARITY;
> > +    case CXL_UNCOR_ERROR_TYPE_MEM_ADDRESS_PARITY:
> > +        return CXL_RAS_UNC_ERR_MEM_ADDRESS_PARITY;
> > +    case CXL_UNCOR_ERROR_TYPE_MEM_BE_PARITY:
> > +        return CXL_RAS_UNC_ERR_MEM_BE_PARITY;
> > +    case CXL_UNCOR_ERROR_TYPE_MEM_DATA_ECC:
> > +        return CXL_RAS_UNC_ERR_MEM_DATA_ECC;
> > +    case CXL_UNCOR_ERROR_TYPE_REINIT_THRESHOLD:
> > +        return CXL_RAS_UNC_ERR_REINIT_THRESHOLD;
> > +    case CXL_UNCOR_ERROR_TYPE_RSVD_ENCODING:
> > +        return CXL_RAS_UNC_ERR_RSVD_ENCODING;
> > +    case CXL_UNCOR_ERROR_TYPE_POISON_RECEIVED:
> > +        return CXL_RAS_UNC_ERR_POISON_RECEIVED;
> > +    case CXL_UNCOR_ERROR_TYPE_RECEIVER_OVERFLOW:
> > +        return CXL_RAS_UNC_ERR_RECEIVER_OVERFLOW;
> > +    case CXL_UNCOR_ERROR_TYPE_INTERNAL:
> > +        return CXL_RAS_UNC_ERR_INTERNAL;
> > +    case CXL_UNCOR_ERROR_TYPE_CXL_IDE_TX:
> > +        return CXL_RAS_UNC_ERR_CXL_IDE_TX;
> > +    case CXL_UNCOR_ERROR_TYPE_CXL_IDE_RX:
> > +        return CXL_RAS_UNC_ERR_CXL_IDE_RX;
> > +    default:
> > +        return -EINVAL;
> > +    }
> > +}
> > +
> > +static int ct3d_qmp_cor_err_to_cxl(CxlUncorErrorType qmp_err)  
> 
> CxlCorErrorType type  is required.
> 
> Compiler warns here:
> ../hw/mem/cxl_type3.c:1263:44: error: implicit conversion from
> enumeration type 'CxlCorErrorType' (aka 'enum CxlCorErrorType') to
> different enumeration type 'CxlUncorErrorType' (aka 'enum
> CxlUncorErrorType') [-Werror,-Wenum-conversion]
> 
>     cxl_err_type = ct3d_qmp_cor_err_to_cxl(type);
> 
>                    ~~~~~~~~~~~~~~~~~~~~~~~ ^~~~
> 1 error generated.

Yikes. Not sure how I missed that!



> 
> > +{
> > +    switch (qmp_err) {
> > +    case CXL_COR_ERROR_TYPE_CACHE_DATA_ECC:
> > +        return CXL_RAS_COR_ERR_CACHE_DATA_ECC;
> > +    case CXL_COR_ERROR_TYPE_MEM_DATA_ECC:
> > +        return CXL_RAS_COR_ERR_MEM_DATA_ECC;
> > +    case CXL_COR_ERROR_TYPE_CRC_THRESHOLD:
> > +        return CXL_RAS_COR_ERR_CRC_THRESHOLD;
> > +    case CXL_COR_ERROR_TYPE_RETRY_THRESHOLD:
> > +        return CXL_RAS_COR_ERR_RETRY_THRESHOLD;
> > +    case CXL_COR_ERROR_TYPE_CACHE_POISON_RECEIVED:
> > +        return CXL_RAS_COR_ERR_CACHE_POISON_RECEIVED;
> > +    case CXL_COR_ERROR_TYPE_MEM_POISON_RECEIVED:
> > +        return CXL_RAS_COR_ERR_MEM_POISON_RECEIVED;
> > +    case CXL_COR_ERROR_TYPE_PHYSICAL:
> > +        return CXL_RAS_COR_ERR_PHYSICAL;
> > +    default:
> > +        return -EINVAL;
> > +    }
> > +}
> > +
> >  static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >                             unsigned size)
> >  {
> > @@ -341,6 +402,84 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >          should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
> >          which_hdm = 0;
> >          break;
> > +    case A_CXL_RAS_UNC_ERR_STATUS:
> > +    {
> > +        uint32_t capctrl = ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL);
> > +        uint32_t fe = FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER);
> > +        CXLError *cxl_err;
> > +        uint32_t unc_err;
> > +
> > +        /*
> > +         * If single bit written that corresponds to the first error
> > +         * pointer being cleared, update the status and header log.
> > +         */
> > +        if (!QTAILQ_EMPTY(&ct3d->error_list)) {
> > +            CXLError *cxl_err = QTAILQ_FIRST(&ct3d->error_list);  
> 
> Is it ok that "CXLError *cxl_err"  definition clobbers previous one above?

It isn't a bug as the external one is only used much later in a QTAILQ_FOREACH()
to build the resulting error status register, but it's certainly inelegant
and there is no need for the internal definition so I'll drop it.
I also moved the assignment to the else leg which is the only place that
specific assignment is used.

Thanks for quick review!  I'll hold off sending a v2 out for a day or two
to let any other early comments come in.

Jonathan

