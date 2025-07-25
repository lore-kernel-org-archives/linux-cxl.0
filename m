Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947419475
	for <linux-cxl@vger.kernel.org>; Fri, 25 Jul 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753450289; cv=none; b=bsA5j8PdGvcsZzmFnPoUss2K7xOFexUGillUjWpex3RdiOl/M6C0H6RrRp2q9YtvFsadbNpjADG0IwDQeHeNMN3rbd89MV9FAq3NlnJUJr5PbBQbDncWVkrqkauLQErdot3SUiSxP9sYgs7lmJYkdhIElHlo+GCm+4JdNRT9r8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753450289; c=relaxed/simple;
	bh=H4iTCFz70KF0p6KZSaTigiGt0tPzjLZNBZtYpeEhSaI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjrEKNZX2ozergOoRzI7DMHlS2p+mfa+ym1YER222dudaP5EzZ40c9OSq39F9cjx/9x0srwKtVpTJNLRG5cLZN+eaEZ+ewQO1KvzqqV8tqf0Bo6pRzH2CC+GFBq6a+v4KkNQd+ADtFb/5n/ohv7o2otNob64bbKUfGZ4qJl3vx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpTHp5BNcz6L59B;
	Fri, 25 Jul 2025 21:29:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 54C8A140133;
	Fri, 25 Jul 2025 21:31:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 15:31:21 +0200
Date: Fri, 25 Jul 2025 14:31:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<fan.ni@samsung.com>, <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 7/7] hw/cxl: Add emulation for memory sparing
 control feature
Message-ID: <20250725143120.00000eef@huawei.com>
In-Reply-To: <20250721172228.2118-8-shiju.jose@huawei.com>
References: <20250721172228.2118-1-shiju.jose@huawei.com>
	<20250721172228.2118-8-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 21 Jul 2025 18:22:28 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Memory sparing is defined as a repair function that replaces a portion of
> memory with a portion of functional memory at that same DPA. The
> subclasses for this operation vary in terms of the scope of the sparing
> being performed. The Cacheline sparing subclass refers to a sparing
> action that can replace a full cacheline. Row sparing is provided as an
> alternative to PPR sparing functions and its scope is that of a single
> DDR row. Bank sparing allows an entire bank to be replaced. Rank sparing
> is defined as an operation in which an entire DDR rank is replaced.
> 
> Memory sparing maintenance operations may be supported by CXL devices
> that implement CXL.mem protocol. A sparing maintenance operation requests
> the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support memory sparing
> features may implement sparing Maintenance operations.
> 
> The host may issue a query command by setting Query Resources flag in the
> Input Payload (CXL Spec 3.2 Table 8-120) to determine availability of
> sparing resources for a given address. In response to a query request,
> the device shall report the resource availability by producing the Memory
> Sparing Event Record (CXL Spec 3.2 Table 8-60) in which the Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields are a copy
> of the values specified in the request.
> 
> During the execution of a sparing maintenance operation, a CXL memory
> device:
> - May or may not retain data
> - May or may not be able to process CXL.mem requests correctly.
> These CXL memory device capabilities are specified by restriction flags
> in the memory sparing feature readable attributes.
> 
> When a CXL device identifies error on a memory component, the device
> may inform the host about the need for a memory sparing maintenance
> operation by using DRAM event record, where the 'maintenance needed' flag
> may set. The event record contains some of the DPA, Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that
> should be repaired. The userspace tool requests for maintenance operation
> if the 'maintenance needed' flag set in the CXL DRAM error record.
> 
> CXL spec 3.2 section 8.2.10.7.2.3 describes the memory sparing feature
> discovery and configuration.
> 
> CXL spec 3.2 section 8.2.10.7.1.4 describes the device's memory sparing
> maintenance operation feature.
> 
> Add emulation for CXL memory device memory sparing control feature
> and memory sparing maintenance operation command.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>


> +    } else if (qemu_uuid_is_equal(&hdr->uuid, &rank_sparing_uuid)) {
> +        CXLMemSparingSetFeature *mem_sparing_set_feature = (void *)payload_in;
> +        CXLMemSparingWriteAttrs *mem_sparing_write_attrs =
> +                            &mem_sparing_set_feature->feat_data;
> +
> +        if (hdr->version != CXL_MEMDEV_SPARING_SET_FEATURE_VERSION) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
> +               mem_sparing_write_attrs,
> +               bytes_to_copy);

Trivial but no need for the wrap.  There were some of these in previous patch as
well.

> +        set_feat_info->data_size += bytes_to_copy;
> +
> +        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> +            data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
> +            ct3d->rank_sparing_attrs.op_mode =
> +                             ct3d->rank_sparing_wr_attrs.op_mode;
> +        }


