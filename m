Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002F4949E7
	for <linux-cxl@vger.kernel.org>; Mon, 18 May 2026 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123039; cv=none; b=m8aME8qlwJEjsUTBeZ2XcN1Hu9Kq/EEZPnWv8hDkRFPA+yFVaJJhjyu9d9VjJ3EsXsTKth0P9Mr2ULc2qtL+uY+GaQvS+6gZqsMHXZEW+EQdZZteweN84p78lmhd2+I3VdiuQfXKSH8+TFloT0Uxxqla9Hcmp26cJbby0W+QZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123039; c=relaxed/simple;
	bh=aaUWYtPeEv8HQr8zVANm4WhLlrEYrbyYhjvZvsnv7YM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmqqQ0T6B8nmS9oM5Ly7M+lzFq5XuJM861KZzaQKmYb2vrlAavGHrlzt2pSoxM9A96HrVX3sOmJMfbvNl7IrD82lHHHwAeqqH4mkcarC3deYyNeObaQ/gUSCtC4DuvIzBD7X5XSYawloh4L/GJ0/AfBsA7QCA4J68Gzlg9n/wSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDGwE0xx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDGwE0xx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45630C2BCB7;
	Mon, 18 May 2026 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779123039;
	bh=aaUWYtPeEv8HQr8zVANm4WhLlrEYrbyYhjvZvsnv7YM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lDGwE0xxmOCdfxkajvZCTvOJY5ijR4c2iLCTaguB0trkqs72SMqjtibhnxmWlbqF6
	 Ccyy2ARdftg5YySqpRf7X6TQaVwcJyP71r++QKBDQRTjk0GxJHOfir4caD7lcWLwcq
	 RxSyNUco+I7ejjDlqU2Ohm7XsH+VIhyP6A9Wf7MVA6b3b0uTrdygRGgeDC4IORtk0/
	 f3LoYDGd6ylSfPWXyl8EvHYJ2q7PcJzq7uGtXACtbvKY6SmIOXi+bXcRxz1GoNHxX5
	 PFS8z/+1cvqCjxuqsKfhZBXbjBfK9lauv7FIDKvTwZSz/yuEgSDrtKbIn4rBzD1gkp
	 geV9M+dl/Imqg==
Date: Mon, 18 May 2026 17:50:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jia Jia <physicalmtea@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 linux-cxl@vger.kernel.org, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v2] hw/cxl: bound Set Feature writes
Message-ID: <20260518175030.1ff9033a@jic23-huawei>
In-Reply-To: <20260429152750.2409174-1-physicalmtea@gmail.com>
References: <CAFEAcA_DnrvSCVY3f2q=3OnXt0+708BcwSJ=KhMn1t3sbbXQbg@mail.gmail.com>
	<20260429152750.2409174-1-physicalmtea@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 23:27:50 +0800
Jia Jia <physicalmtea@gmail.com> wrote:

Sorry I've taken so long to get to cxl qemu stuff.

> Commit c1c4d6b38b13 added offset + length checks for the
> patrol_scrub and ecs Set Feature branches, but the remaining
> branches still copy mailbox payload data into fixed-size
> write-attribute objects without the same validation.
> 
> A full mailbox payload can still reach rank_sparing and overrun
> CXLMemSparingWriteAttrs on current master. With an ASan build
> this aborts the host process with:
> 
>   ERROR: AddressSanitizer: heap-buffer-overflow
>   WRITE of size 2016
>       #0 __interceptor_memcpy
>       #1 cmd_features_set_feature ../hw/cxl/cxl-mailbox-utils.c:1908
>       #2 cxl_process_cci_message ../hw/cxl/cxl-mailbox-utils.c:4622
>       #3 mailbox_reg_write ../hw/cxl/cxl-device-utils.c:209
> 
> Fold the bounds checking into a small helper and use it for
> all Set Feature write-attribute branches, so oversized
> requests fail with CXL_MBOX_INVALID_PAYLOAD_LENGTH instead
> of overflowing the target buffers.
> 
> Add a qtest covering the rank_sparing path.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3458

Please can we have a Fixes tag (possibly several) for where the bug was introduced.

This is great in general - comments are all about splitting it up
and minor things to make the test easier to understand.

Thanks

Jonathan


> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
> Hi Peter,
> 
> Thanks, that makes sense.
> 
> I've folded the repeated bounds checking into a small helper and respun
> the patch as v2.
> 
> Thanks
> 
> v2:
> - fold the repeated Set Feature bounds checks into a helper
> - use the helper for all Set Feature write-attribute branches
> 
>  hw/cxl/cxl-mailbox-utils.c | 94 ++++++++++++++++++++++++------
>  tests/qtest/cxl-test.c     | 99 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 169 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d8ba7e8625..4c7a083e4c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1702,6 +1702,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cxl_set_feature_copy(void *write_attrs,
> +                                       size_t write_attrs_size,
> +                                       uint16_t offset,
> +                                       const void *payload,
> +                                       uint16_t bytes_to_copy)
> +{
> +    if ((uint32_t)offset + bytes_to_copy > write_attrs_size) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    memcpy((uint8_t *)write_attrs + offset, payload, bytes_to_copy);
> +
> +    return CXL_MBOX_SUCCESS;
> +}

Ideally split the refactor part and existing usecases out as a precursor patch.
Then in a second patch add the missing checks.


> +
>  /* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
>  static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                             uint8_t *payload_in,
> @@ -1713,6 +1728,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>      CXLSetFeatureInHeader *hdr = (void *)payload_in;
>      CXLSetFeatureInfo *set_feat_info;
>      uint16_t bytes_to_copy = 0;
> +    CXLRetCode ret;
>      uint8_t data_transfer_flag;
>      CXLType3Dev *ct3d;
>      uint16_t count;
> @@ -1760,13 +1776,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        if ((uint32_t)hdr->offset + bytes_to_copy >
> -            sizeof(ct3d->patrol_scrub_wr_attrs)) {
> -            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> -        }
> -        memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
> -               ps_write_attrs,
> -               bytes_to_copy);
> +        ret = cxl_set_feature_copy(&ct3d->patrol_scrub_wr_attrs,
> +                                   sizeof(ct3d->patrol_scrub_wr_attrs),
> +                                   hdr->offset, ps_write_attrs,
> +                                   bytes_to_copy);
> +        if (ret) {
> +            return ret;
> +        }
>          set_feat_info->data_size += bytes_to_copy;
>  
>          if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> @@ -1787,13 +1803,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        if ((uint32_t)hdr->offset + bytes_to_copy >
> -            sizeof(ct3d->ecs_wr_attrs)) {
> -            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> -        }
> -        memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
> -               ecs_write_attrs,
> -               bytes_to_copy);
> +        ret = cxl_set_feature_copy(&ct3d->ecs_wr_attrs,
> +                                   sizeof(ct3d->ecs_wr_attrs),
> +                                   hdr->offset, ecs_write_attrs,
> +                                   bytes_to_copy);
> +        if (ret) {
> +            return ret;
> +        }
>          set_feat_info->data_size += bytes_to_copy;
>  
>          if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> @@ -1813,8 +1829,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
> -               sppr_write_attrs, bytes_to_copy);
> +        ret = cxl_set_feature_copy(&ct3d->soft_ppr_wr_attrs,
> +                                   sizeof(ct3d->soft_ppr_wr_attrs),
> +                                   hdr->offset, sppr_write_attrs,
> +                                   bytes_to_copy);
> +        if (ret) {
> +            return ret;
> +        }
>          set_feat_info->data_size += bytes_to_copy;
>  
>          if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> @@ -1832,8 +1853,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
> -               hppr_write_attrs, bytes_to_copy);
> +        ret = cxl_set_feature_copy(&ct3d->hard_ppr_wr_attrs,
> +                                   sizeof(ct3d->hard_ppr_wr_attrs),
> +                                   hdr->offset, hppr_write_attrs,
> +                                   bytes_to_copy);
> +        if (ret) {
> +            return ret;
> +        }
>          set_feat_info->data_size += bytes_to_copy;
>  
>          if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> @@ -1851,8 +1877,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
> -               mem_sparing_write_attrs, bytes_to_copy);
> +        ret = cxl_set_feature_copy(&ct3d->cacheline_sparing_wr_attrs,
> +                                   sizeof(ct3d->cacheline_sparing_wr_attrs),
> +                                   hdr->offset, mem_sparing_write_attrs,
> +                                   bytes_to_copy);
> +        if (ret) {
> +            return ret;
> +        }
>          set_feat_info->data_size += bytes_to_copy;
>  
>          if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> @@ -1869,8 +1900,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
> -               mem_sparing_write_attrs, bytes_to_copy);
> +        ret = cxl_set_feature_copy(&ct3d->row_sparing_wr_attrs,
> +                                   sizeof(ct3d->row_sparing_wr_attrs),
> +                                   hdr->offset, mem_sparing_write_attrs,
> +                                   bytes_to_copy);
> +        if (ret) {
> +            return ret;
> +        }
>          set_feat_info->data_size += bytes_to_copy;
>  
>          if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> @@ -1887,8 +1923,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
> -               mem_sparing_write_attrs, bytes_to_copy);
> +        ret = cxl_set_feature_copy(&ct3d->bank_sparing_wr_attrs,
> +                                   sizeof(ct3d->bank_sparing_wr_attrs),
> +                                   hdr->offset, mem_sparing_write_attrs,
> +                                   bytes_to_copy);
> +        if (ret) {
> +            return ret;
> +        }
>          set_feat_info->data_size += bytes_to_copy;
>  
>          if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> @@ -1905,8 +1946,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
> -               mem_sparing_write_attrs, bytes_to_copy);
> +        ret = cxl_set_feature_copy(&ct3d->rank_sparing_wr_attrs,
> +                                   sizeof(ct3d->rank_sparing_wr_attrs),
> +                                   hdr->offset, mem_sparing_write_attrs,
> +                                   bytes_to_copy);
> +        if (ret) {
> +            return ret;
> +        }
>          set_feat_info->data_size += bytes_to_copy;
>  
>          if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
>              data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index 8fb7e58d4f..a9fcd98736 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c

Test should be a 3rd patch.  We may not want to backport this one.
Great to have it though!

> @@ -7,6 +7,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "libqtest-single.h"
> +#include "hw/cxl/cxl_device.h"
>  
>  #define QEMU_PXB_CMD \
>      "-machine q35,cxl=on " \
> @@ -59,6 +60,12 @@
>      "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
>      "-device cxl-type3,bus=rp0,volatile-memdev=cxl-mem0,lsa=lsa0,id=mem0 "
>  
> +#define QEMU_T3D_DIRECT_PMEM \
> +    "-machine q35,cxl=on -nodefaults " \
> +    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> +    "-object memory-backend-file,id=lsa0,mem-path=%s,size=1M " \
> +    "-device cxl-type3,bus=pcie.0,persistent-memdev=cxl-mem0,lsa=lsa0,id=pmem0 "
> +
>  #define QEMU_2T3D \
>      "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
>      "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
> @@ -81,6 +88,17 @@
>      "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
>      "-device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3,id=pmem3 "
>  
> +#define CXL_T3D_DEVFN 0x08
> +#define CXL_T3D_BAR2_ADDR 0x10000000ULL
Can we add some info on why that address?
> +
> +typedef struct QEMU_PACKED CXLSetFeatureInHeaderTest {
> +    uint8_t uuid[16];
> +    uint32_t flags;
> +    uint16_t offset;
> +    uint8_t version;
> +    uint8_t rsvd[9];
> +} CXLSetFeatureInHeaderTest;
> +
>  static void cxl_basic_hb(void)
>  {
>      qtest_start("-machine q35,cxl=on");
> @@ -118,6 +136,85 @@ static void cxl_2root_port(void)
>  }
>  
>  #ifdef CONFIG_POSIX
> +static uint32_t cxl_test_pci_config_addr(uint8_t devfn, uint8_t offset)
> +{
> +    return 0x80000000U | (devfn << 8) | offset;

Can we have a define for that enable bit?

Given this file includes both x86 and arm virt tests can we add
something to names of these functions to make it clear they are x86 only?

> +}
> +
> +static void cxl_test_t3d_enable_bar2(void)
> +{
> +    outl(0xcf8, cxl_test_pci_config_addr(CXL_T3D_DEVFN, 0x18));
> +    outl(0xcfc, CXL_T3D_BAR2_ADDR);
> +    outl(0xcf8, cxl_test_pci_config_addr(CXL_T3D_DEVFN, 0x1c));
> +    outl(0xcfc, 0);
> +    outl(0xcf8, cxl_test_pci_config_addr(CXL_T3D_DEVFN, 0x04));
> +    outl(0xcfc, 0x2);
Can we express that 0x2 in terms of the fields in the register?

> +}
> +
> +static uint64_t cxl_test_t3d_mailbox_base(void)
> +{
> +    return CXL_T3D_BAR2_ADDR + CXL_MAILBOX_REGISTERS_OFFSET;
> +}
> +
> +static uint64_t cxl_test_t3d_payload_base(void)
> +{
> +    return cxl_test_t3d_mailbox_base() + A_CXL_DEV_CMD_PAYLOAD;
> +}
> +
> +static void cxl_test_t3d_submit_set_feature(const void *payload, size_t len)
> +{
> +    memwrite(cxl_test_t3d_payload_base(), payload, len);
> +    writeq(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_CMD,
> +           ((uint64_t)len << 16) | (0x05 << 8) | 0x02);
> +    writel(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_CTRL, 1);
> +}
> +
> +static uint16_t cxl_test_t3d_mailbox_errno(void)
> +{
> +    return (readq(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_STS) >>
> +            32) & 0xffff;
> +}
> +
> +static void cxl_test_fill_set_feature_header(CXLSetFeatureInHeaderTest *hdr,
> +                                             const uint8_t uuid[16],
> +                                             uint16_t offset,
> +                                             uint8_t version)
> +{
> +    memset(hdr, 0, sizeof(*hdr));
> +    memcpy(hdr->uuid, uuid, 16);
> +    hdr->offset = cpu_to_le16(offset);
> +    hdr->version = version;
> +}
> +
> +static void cxl_t3d_set_feature_rejects_oversized_rank_sparing(void)

Would be nice to expand the tests to cover more cases, ideally including one
that works!

> +{
> +    static const uint8_t rank_sparing_uuid[16] = {
> +        0x34, 0xdb, 0xaf, 0xf5, 0x05, 0x52, 0x42, 0x81,
> +        0x8f, 0x76, 0xda, 0x0b, 0x5e, 0x7a, 0x76, 0xa7,
> +    };
> +    g_autoptr(GString) cmdline = g_string_new(NULL);
> +    g_autofree const char *tmpfs = NULL;
> +    uint8_t payload[CXL_MAILBOX_MAX_PAYLOAD_SIZE] = { 0 };
> +    CXLSetFeatureInHeaderTest *hdr = (void *)payload;
> +
> +    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
> +    g_string_printf(cmdline, QEMU_T3D_DIRECT_PMEM, tmpfs, tmpfs);
> +
> +    qtest_start(cmdline->str);
> +    cxl_test_t3d_enable_bar2();
> +
> +    cxl_test_fill_set_feature_header(hdr, rank_sparing_uuid, 0,
> +                                     CXL_MEMDEV_SPARING_SET_FEATURE_VERSION);
> +    memset(payload + sizeof(*hdr), 0x41,
> +           sizeof(payload) - sizeof(*hdr));

I think that fits on one line.

> +    cxl_test_t3d_submit_set_feature(payload, sizeof(payload));
> +    g_assert_cmphex(cxl_test_t3d_mailbox_errno(), ==,
> +                    CXL_MBOX_INVALID_PAYLOAD_LENGTH);
> +
> +    qtest_end();
> +    rmdir(tmpfs);
> +}


