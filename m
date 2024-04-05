Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAAB16ABE2
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315336; cv=none; b=MB4ufAcMC5+3LjaVb0iAnOhn11TIibvCUKcbjyBHoz0j6q9PWtr9XnEbbAFn+TDwuDtMa63/Qk4pZXGli3xYTwMmcUJKQXTgGMDIBEoGjc51Y/xovvyGG7r23LxsyxeKoma3/bRz8xCRNK0MHpsYDgMUSJDy4XRfe1mf84YR87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315336; c=relaxed/simple;
	bh=byoGzGIpqUnSa6eWuGbTP3KKfzd49MR2rRIqCM3cUao=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGrKTjSuXBgzeQEL9KVLrshWfs6oGN0yIl/3mUvgoCW41CYFkkZyet8Vo5Zqcj+3H6uHFGO4lEgKU5Pnh3a1+y0dZ38HOjKVjFD8tGzqnirxR1ZvpoEFKZHJ5Tuor2Uuw3ERavD2gyirJ5TBKM+Nc/fmNCiCiY7rNgwlsejTHnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9wgP0Y3Bz6J6DN;
	Fri,  5 Apr 2024 19:07:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 88BEA14065C;
	Fri,  5 Apr 2024 19:08:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 12:08:51 +0100
Date: Fri, 5 Apr 2024 12:08:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 07/12] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Message-ID: <20240405120850.00001d93@Huawei.com>
In-Reply-To: <20240325190339.696686-8-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
	<20240325190339.696686-8-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 25 Mar 2024 12:02:25 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Add dynamic capacity extent list representative to the definition of
> CXLType3Dev and implement get DC extent list mailbox command per
> CXL.spec.3.1:.8.2.9.9.9.2.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

One really minor comment inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    struct {
> +        uint32_t extent_cnt;
> +        uint32_t start_extent_id;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    struct {
> +        uint32_t count;
> +        uint32_t total_extents;
> +        uint32_t generation_num;
> +        uint8_t rsvd[4];
> +        CXLDCExtentRaw records[];
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    uint32_t start_extent_id = in->start_extent_id;
> +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> +    uint16_t record_count = 0, i = 0, record_done = 0;
> +    uint16_t out_pl_len, size;
> +    CXLDCExtent *ent;
> +
> +    if (start_extent_id > ct3d->dc.total_extent_count) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(in->extent_cnt,
> +                       ct3d->dc.total_extent_count - start_extent_id);
> +    size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
> +    if (size / sizeof(out->records[0]) < record_count) {
> +        record_count = size / sizeof(out->records[0]);
> +    }

Could use another min for this I think?
	record_count = MIN(record_count, size / sizeof(out->records[0]);

> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +
> +    stl_le_p(&out->count, record_count);
> +    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
> +
> +    if (record_count > 0) {
> +        CXLDCExtentRaw *out_rec = &out->records[record_done];
> +
> +        QTAILQ_FOREACH(ent, extent_list, node) {
> +            if (i++ < start_extent_id) {
> +                continue;
> +            }
> +            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
> +            stq_le_p(&out_rec->len, ent->len);
> +            memcpy(&out_rec->tag, ent->tag, 0x10);
> +            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
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

