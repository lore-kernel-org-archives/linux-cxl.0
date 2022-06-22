Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF3BC43334
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Jun 2022 10:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355315AbiFVKjH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Jun 2022 06:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355474AbiFVKjC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Jun 2022 06:39:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCD43BA54
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jun 2022 03:39:00 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LSfxN1Df9z68029;
        Wed, 22 Jun 2022 18:38:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 12:38:57 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 22 Jun
 2022 11:38:57 +0100
Date:   Wed, 22 Jun 2022 11:38:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
CC:     <shiju.jose@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [RFC PATCH] hw/cxl: Initial poison injection support.
Message-ID: <20220622113855.00004009@huawei.com>
In-Reply-To: <20220620173452.000026c5@huawei.com>
References: <20220620162056.16790-1-Jonathan.Cameron@huawei.com>
        <20220620173452.000026c5@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> > +/*
> > + * This is very inefficient, but good enough for now!
> > + * Also thed payload will always fit, so no need to handle the MORE flag and
> > + * make this stateful.
> > + */
> > +static ret_code cmd_media_get_poison_list(struct cxl_cmd *cmd,
> > +                                          CXLDeviceState *cxl_dstate,
> > +                                          uint16_t *len)
> > +{
> > +    struct get_poison_list_pl {
> > +        uint64_t pa;
> > +        uint64_t length;
> > +    } QEMU_PACKED;
> > +
> > +    struct get_poison_list_out_pl {
> > +        uint8_t flags;
> > +        uint8_t rsvd1;
> > +        uint64_t overflow_timestamp;
> > +        uint16_t count;
> > +        uint8_t rsvd2[0x14];
> > +        struct {
> > +            uint64_t addr;
> > +            uint32_t length;
> > +            uint32_t resv;
> > +        } QEMU_PACKED records[];
> > +    } QEMU_PACKED;
> > +
> > +    struct get_poison_list_pl *in = (void *)cmd->payload;
> > +    struct get_poison_list_out_pl *out = (void *)cmd->payload;
> > +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> > +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> > +    uint16_t record_count = 0, i = 0;
> > +    uint64_t query_start = in->pa;
> > +    uint64_t query_length = in->length;
> > +    CXLPoisonList *poison_list;
> > +    CXLPoison *ent;
> > +    uint16_t out_pl_len;
> > +
> > +    poison_list = cvc->get_poison_list(ct3d);
> > +
> > +    QLIST_FOREACH(ent, poison_list, node) {
> > +        /* Check for no overlap */
> > +        if (ent->start >= query_start + query_length ||
> > +            ent->start + ent->length <= query_start) {
> > +            continue;
> > +        }
> > +        if (record_count == 256) {
> > +            /* For now just return 256 max */
> > +            break;
> > +        }
> > +        record_count++;
> > +    }
> > +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> > +    assert(out_pl_len > CXL_MAILBOX_MAX_PAYLOAD_SIZE);
* embarrassed cough*.  Check is inverted.  Naught me tidied up a runtime
check into this but forgot to invert the sense + clearly didn't build
the right tree for final testing.

> > +
> > +    memset(out, 0, out_pl_len);
> > +    QLIST_FOREACH(ent, poison_list, node) {
> > +        uint64_t start, stop;
> > +
> > +        /* Check for no overlap */
> > +        if (ent->start >= query_start + query_length ||
> > +            ent->start + ent->length <= query_start) {
> > +            continue;
> > +        }
> > +        if (i == 256) {
> > +            break;
> > +        }
> > +        /* Deal with overlap */
> > +        start = MAX(ent->start & 0xffffffffffffffc0, query_start);
> > +        stop = MIN((ent->start & 0xffffffffffffffc0) + ent->length,
> > +                   query_start + query_length);
> > +        out->records[i].addr = start | 0x2; /* internal error */
> > +        out->records[i].length = (stop - start) / 64;
> > +        i++;
> > +    }
> > +    out->count = record_count;
> > +    *len = out_pl_len;
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
