Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511F264A82
	for <linux-cxl@vger.kernel.org>; Fri, 14 Feb 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542138; cv=none; b=uvpW6V5o2H0j73zVi0o1oQZ9dFF7FA3yRaJE56NRdMNgdocfbHN96gQ4i83BhyWQCQEMXYPsGFrm0Z/1VGgyUm3RVA7MtdVciS+D3VqxzHPazqn6YCaiBFskZ5IWg6wrn7ZKA59ICrzQfa7AmI6+U5KtMxzijMVfDNDwJFBaT38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542138; c=relaxed/simple;
	bh=pGqKpNljXQx3s8UUx+st5V6+NqrumbfmXdSZETXocEQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cmx67AOpefekTUT4bDCgkkOjrywZiMoCoUCV4Z6QFbhqcOumeEuCd5MeIEheF1BfAB84vvcIxbyD6xpJBwFeBqzvmzasDN/RbXz5NjKYcmvuNpJocGl7DWnWM+7+IXwZjMvjpiyqoVC+QLcdTGMUErkvyI/s4bzb+ohPyKqfQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvYjk51knz6L59c;
	Fri, 14 Feb 2025 22:05:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C339140134;
	Fri, 14 Feb 2025 22:08:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 15:08:52 +0100
Date: Fri, 14 Feb 2025 14:08:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands (8.2.9.9.5.3)
Message-ID: <20250214140851.000073fe@huawei.com>
In-Reply-To: <20250213091558.2294806-2-vinayak.kh@samsung.com>
References: <20250213091558.2294806-1-vinayak.kh@samsung.com>
	<CGME20250213091629epcas5p1e5435929f701840a7e13f22a83edff22@epcas5p1.samsung.com>
	<20250213091558.2294806-2-vinayak.kh@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 13 Feb 2025 14:45:56 +0530
Vinayak Holikatti <vinayak.kh@samsung.com> wrote:

> CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.

Given the CXL consortium only makes the latest spec available,
generally we try to reference that.
It's move to 8.2.10.9.5.3 in r3.2

Otherwise mostly minor style comments inline.

Thanks,

Jonathan



> CXL devices supports media operations discovery command.
> 
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 136 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c7ea5bc35..fa38ecf507 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -89,6 +89,7 @@ enum {
>      SANITIZE    = 0x44,
>          #define OVERWRITE     0x0
>          #define SECURE_ERASE  0x1
> +        #define MEDIA_OPERATIONS 0x2
>      PERSISTENT_MEM = 0x45,
>          #define GET_SECURITY_STATE     0x0
>      MEDIA_AND_POISON = 0x43,
> @@ -1721,6 +1722,137 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +#define CXL_CACHELINE_SIZE 64

Already defined in include/hw/cxl/cxl.h

> +enum {
> +    MEDIA_OP_CLASS_GENERAL  = 0x0,
> +        #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
> +    MEDIA_OP_CLASS_SANITIZE = 0x1,
> +        #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
> +        #define MEDIA_OP_SAN_SUBC_ZERO 0x1
> +    MEDIA_OP_CLASS_MAX
> +};
> +
> +struct media_op_supported_list_entry {
> +    uint8_t media_op_class;
> +    uint8_t media_op_subclass;
> +};
> +
> +struct media_op_discovery_out_pl {
> +    uint64_t dpa_range_granularity;
> +    uint16_t total_supported_operations;
> +    uint16_t num_of_supported_operations;
> +    struct media_op_supported_list_entry entry[];
> +} QEMU_PACKED;
> +
> +static const struct media_op_supported_list_entry media_op_matrix[] = {
> +    {MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY},
> +    {MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE},
> +    {MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO}
Add trailing comma as we may well get more of these in future.
In general use a trailing comma whenever there isn't a definite reason
we will never get them.

Also I'd prefer space after { and before } to match local style.
    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO },

> +};
> +
> +static CXLRetCode media_operations_discovery(uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out)
Align to opening bracket (just after it)
> +{
> +    struct {
> +        uint8_t media_operation_class;
> +        uint8_t media_operation_subclass;
> +        uint8_t rsvd[2];
> +        uint32_t dpa_range_count; 
> +        struct {
> +            uint16_t start_index;
> +            uint16_t num_supported_ops;

I'd just call this num or num_ops


> +        } discovery_osa;
> +    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
> +    int count = 0;
> +
> +    if (len_in < sizeof(*media_op_in_disc_pl)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    struct media_op_discovery_out_pl *media_out_pl =
> +                                                  (void *)payload_out;
> +    int num_ops = media_op_in_disc_pl->discovery_osa.num_supported_ops;
> +    int start_index = media_op_in_disc_pl->discovery_osa.start_index;

Generally we don't mix declarations and code. So move these local variable
declarations up.


> +
> +    if (start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    media_out_pl->dpa_range_granularity = CXL_CACHELINE_SIZE;
> +    media_out_pl->total_supported_operations =
> +                                     ARRAY_SIZE(media_op_matrix);
> +    if (num_ops > 0) {
> +        for (int i = start_index; i < ARRAY_SIZE(media_op_matrix); i++) {

Given you already checked for going out of range, can just do 
i < start_index + num_ops
I think and avoid the need to break or keep a count.

Keep to local style and declare i outside the loop


> +            media_out_pl->entry[count].media_op_class =
> +                    media_op_matrix[i].media_op_class;
> +            media_out_pl->entry[count].media_op_subclass =
> +                        media_op_matrix[i].media_op_subclass;
> +            count++;
> +            if (count == num_ops) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    media_out_pl->num_of_supported_operations = count;
> +    *len_out = sizeof(struct media_op_discovery_out_pl) +
> +        (sizeof(struct media_op_supported_list_entry) * count);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload_in,

Alignment should be to opening bracket.

> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t media_operation_class;
> +        uint8_t media_operation_subclass;
> +        uint8_t rsvd[2];
> +        uint32_t dpa_range_count;
> +    } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
> +
> +    if (len_in < sizeof(*media_op_in_common_pl)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    uint8_t media_op_cl = media_op_in_common_pl->media_operation_class;
> +    uint8_t media_op_subclass =
> +                      media_op_in_common_pl->media_operation_subclass;
> +    uint32_t dpa_range_count = media_op_in_common_pl->dpa_range_count;

As above, traditional c style with declarations before code.

> +
> +    switch (media_op_cl) {
> +    case MEDIA_OP_CLASS_GENERAL:
> +        if (media_op_subclass != MEDIA_OP_GEN_SUBC_DISCOVERY) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        /*
> +         * As per spec CXL 3.1 8.2.9.9.5.3 dpa_range_count
> +         * should be zero for discovery sub class command
> +         */

I would move this into media_operations_discovery.

> +        if (dpa_range_count) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +
> +        return media_operations_discovery(payload_in, len_in, payload_out,
> +                                             len_out);
> +    case MEDIA_OP_CLASS_SANITIZE:

Easier to introduce this case in next patch.  Until then can just let
the default deal with it.

> +        switch (media_op_subclass) {
> +        default:
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +    default:
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +


