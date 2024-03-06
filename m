Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0880025
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743079; cv=none; b=la56XlqWGSiF8rU/yISBZIQmMQYPDCjhmhvQWdpzvN1S1mukBZuytt6KMPVxOgDmtm+rzM235LFLxlkrzlzCWFkuKqTIUz/KZ6H7GMVkhMXHcfsOhof+vjrBIdauN9WhCarAsD1kYdqYkvZtkxBbdYsXIIN+V3PbEtAfbQioKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743079; c=relaxed/simple;
	bh=3WzV55BMCcVRM9CTG4xvIwjdIcjuLpphA44r0pHmjfo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIhlTLrLuIOp3pPP90OBAI4KeJ59gI3eMP8xpnDZXulxs+aFl1dbddD72o5Y4TFaX0PcgSNgM2IrUagAZ0UlCSCbwTqJzDk6SqGMWOiG13gURJMqZ8cAXoQW7rUaT4KLNlHYarrHeOPilInX+JVKLj1FPRweJtA5b57jfhOfW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqdKw4CW7z6K8L5;
	Thu,  7 Mar 2024 00:33:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AE2751400D7;
	Thu,  7 Mar 2024 00:37:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 16:37:53 +0000
Date: Wed, 6 Mar 2024 16:37:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 07/13] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Message-ID: <20240306163752.00001fa1@Huawei.com>
In-Reply-To: <20240304194331.1586191-8-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-8-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  4 Mar 2024 11:34:02 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Add dynamic capacity extent list representative to the definition of
> CXLType3Dev and add get DC extent list mailbox command per
> CXL.spec.3.1:.8.2.9.9.9.2.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Hi Fan,

A small thing in here around the assert to ensure we don't overflow
the mailbox.  We don't need that, just check what fits and return
fewer extents than asked for if they won't fit.

>  
> +/*
> + * CXL r3.1 section 8.2.9.9.9.2:
> + * Get Dynamic Capacity Extent List (Opcode 4801h)
> + */
> +static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> +                                               uint8_t *payload_in,
> +                                               size_t len_in,
> +                                               uint8_t *payload_out,
> +                                               size_t *len_out,
> +                                               CXLCCI *cci)

> +    uint16_t record_count = 0, i = 0, record_done = 0;
> +    uint16_t out_pl_len;
> +    uint32_t start_extent_id = in->start_extent_id;

> +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCExtent *ent;
> +
> +    if (start_extent_id > ct3d->dc.total_extent_count) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(in->extent_cnt,
> +                       ct3d->dc.total_extent_count - start_extent_id);
Should clamp this using the length so that it fits in the mailbox...
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
and get rid of this nasty assert.

The command is not obliged to even try to return as many as requested,
it can return any smaller number (1 or more) with the assumption the driver
just asks for the next ones..

> +
> +    stl_le_p(&out->count, record_count);
> +    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
> +
> +    if (record_count > 0) {
> +        QTAILQ_FOREACH(ent, extent_list, node) {
> +            if (i++ < start_extent_id) {
> +                continue;
> +            }
> +            stq_le_p(&out->records[record_done].start_dpa, ent->start_dpa);

Maybe a local variable for out->records[record_done]?

            CXLDCExtentRaw *out_rec = &out->records[record]done];
            stq_le_p(&out_rec->len, ent->len);
etc

> +            stq_le_p(&out->records[record_done].len, ent->len);
> +            memcpy(&out->records[record_done].tag, ent->tag, 0x10);
> +            stw_le_p(&out->records[record_done].shared_seq, ent->shared_seq);
> +
> +            record_done++;
> +            if (record_done == record_count) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}

