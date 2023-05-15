Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E65C77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 14:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjEOOiD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEOOiC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 10:38:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8FF10A
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 07:37:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKhlc1k38z67nTp;
        Mon, 15 May 2023 22:37:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 15:37:56 +0100
Date:   Mon, 15 May 2023 15:37:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [RFC 5/7] hw/cxl/cxl-mailbox-utils: Add mailbox commands to
 support add/release dynamic capacity response
Message-ID: <20230515153755.00002bfc@Huawei.com>
In-Reply-To: <20230511175609.2091136-6-fan.ni@samsung.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175642uscas1p1a998a2d4a20c370f0172db93d537ed39@uscas1p1.samsung.com>
        <20230511175609.2091136-6-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023 17:56:40 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Per CXL spec 3.0, we implemented the two mailbox commands:
> Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.8.9.3, and
> Release Dynamic Capacity Response (Opcode 4803h) 8.2.9.8.9.4.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 223 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |   3 +-
>  2 files changed, 225 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ed2ac154cb..7212934627 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -84,6 +84,8 @@ enum {
>  	DCD_CONFIG = 0x48, /*8.2.9.8.9*/
>  		#define GET_DC_REGION_CONFIG   0x0
>  		#define GET_DYN_CAP_EXT_LIST   0x1
> +		#define ADD_DYN_CAP_RSP        0x2
> +		#define RELEASE_DYN_CAP        0x3
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -1069,6 +1071,221 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(struct cxl_cmd *cmd,
>  	return CXL_MBOX_SUCCESS;
>  }
>  
> +static inline int test_bits(const unsigned long *addr, int nr, int size)

Not obvious what this does from the name.  Please add some docs.

> +{
> +	unsigned long res = find_next_zero_bit(addr, size + nr, nr);
> +
> +	if (res >= nr + size)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static uint8_t find_region_id(struct CXLType3Dev *dev, uint64_t dpa

Operates only on things in dev->dc, so perhaps pass that instead.

> +		, uint64_t len)

comma on previous line.

> +{
> +	int8_t i = dev->dc.num_regions-1;
> +
> +	while (i > 0 && dpa < dev->dc.regions[i].base)
> +		i--;
> +
> +	if (dpa < dev->dc.regions[i].base
> +			|| dpa + len > dev->dc.regions[i].base + dev->dc.regions[i].len)
> +		return dev->dc.num_regions;
> +
> +	return i;
> +}
> +
> +static CXLRetCode detect_malformed_extent_list(CXLType3Dev *dev, void *data)
> +{
> +	struct updated_dc_extent_list_in_pl {
This is same as used in next function.  Pull it out of the functions and
use that type rather than mapping via a void *data pointer.  

> +		uint32_t num_entries_updated;
> +		uint8_t rsvd[4];
> +		struct {
> +			uint64_t start_dpa;
> +			uint64_t len;
> +			uint8_t rsvd[8];
> +		} QEMU_PACKED updated_entries[];
> +	} QEMU_PACKED;
> +
> +	struct updated_dc_extent_list_in_pl *in = data;
> +	unsigned long *blk_bitmap;
> +	uint64_t min_block_size = dev->dc.regions[0].block_size;
> +	struct CXLDCD_Region *region = &dev->dc.regions[0];
> +	uint32_t i;
> +	uint64_t dpa, len;
> +	uint8_t rid;
> +
> +	for (i = 1; i < dev->dc.num_regions; i++) {
> +		region = &dev->dc.regions[i];
> +		if (min_block_size > region->block_size)
> +			min_block_size = region->block_size;
> +	}
> +	blk_bitmap = bitmap_new((region->len + region->base
> +				- dev->dc.regions[0].base) / min_block_size);
> +	g_assert(blk_bitmap);

Abort in bitmap_new() anyway so no need for this.  Most qemu allocations
don't need to be checked as they fail hard anyway so we never get to the checks.

> +	bitmap_zero(blk_bitmap, (region->len + region->base
> +				- dev->dc.regions[0].base) / min_block_size);

bitmap_new() seems to use a g_malloc0 internally so no need to zero again here
I think.

> +
> +	for (i = 0; i < in->num_entries_updated; i++) {
> +		dpa = in->updated_entries[i].start_dpa;
> +		len = in->updated_entries[i].len;
> +
> +		rid = find_region_id(dev, dpa, len);
> +		if (rid == dev->dc.num_regions) {

Use a goto and single cleanup path having set ret or similar to
the particular issue.

> +			g_free(blk_bitmap);
> +			return CXL_MBOX_INVALID_PA;
> +		}
> +		region = &dev->dc.regions[rid];
> +		if (dpa % region->block_size || len % region->block_size) {
> +			g_free(blk_bitmap);
> +			return CXL_MBOX_INVALID_EXTENT_LIST;
goto from here as well.. etc.

> +		}
> +		/* the dpa range already covered by some other extents in the list */
> +		if (test_bits(blk_bitmap, dpa/min_block_size, len/min_block_size)) {
> +			g_free(blk_bitmap);
> +			return CXL_MBOX_INVALID_EXTENT_LIST;
> +		}
> +		bitmap_set(blk_bitmap, dpa/min_block_size, len/min_block_size);
> +	}
> +
> +	g_free(blk_bitmap);
> +	return CXL_MBOX_SUCCESS;
> +}
> +
> +/*
> + * cxl spec 3.0: 8.2.9.8.9.3
> + * Add Dynamic Capacity Response (opcode 4802h)
> + * Assuming extent list is updated when a extent is added, when receiving
> + * the response, verify and ensure the extent is utilized by the host, and
> + * update extent list  as needed.

Double space in middle of sentence

> + **/
> +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(struct cxl_cmd *cmd,
> +		CXLDeviceState *cxl_dstate,
> +		uint16_t *len_unused)
> +{
> +	struct add_dyn_cap_ext_list_in_pl {
> +		uint32_t num_entries_updated;
> +		uint8_t rsvd[4];
> +		struct {
> +			uint64_t start_dpa;
> +			uint64_t len;
> +			uint8_t rsvd[8];
> +		} QEMU_PACKED updated_entries[];

These extent list entries keep turning up in the code. Pull that out of here
to be a general 'Extent list element' or similar.

> +	} QEMU_PACKED;
> +
> +	struct add_dyn_cap_ext_list_in_pl *in = (void *)cmd->payload;
> +	struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +	CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +	CXLDCD_Extent *ent;
> +	uint32_t i;
> +	uint64_t dpa, len;
> +	CXLRetCode rs;
> +
> +	if (in->num_entries_updated == 0)
> +		return CXL_MBOX_SUCCESS;
> +
> +	rs = detect_malformed_extent_list(ct3d, in);
> +	if (rs != CXL_MBOX_SUCCESS)
> +		return rs;
> +
> +	for (i = 0; i < in->num_entries_updated; i++) {
> +		dpa = in->updated_entries[i].start_dpa;
> +		len = in->updated_entries[i].len;
> +
> +		/* Todo: check following
> +		 * One or more of the updated extent lists contain Starting DPA
> +		 * or Lengths that are out of range of a current extent list
> +		 * maintained by the device.
> +		 **/
> +
> +		QTAILQ_FOREACH(ent, extent_list, node) {

Add some comments here.  Is this a repeated entry test?

> +			if (ent->start_dpa == dpa && ent->len == len)
> +				return CXL_MBOX_INVALID_PA;
> +			if (ent->start_dpa <= dpa
> +				&& dpa + len <= ent->start_dpa + ent->len) {

Comment needed on this one. Why is it shrinking an existing entry?

> +				ent->start_dpa = dpa;
> +				ent->len = len;
> +				break;

If you break here I think it will only result in return CXL_MBOX_SUCCESS so
might as well do that here.

> +			} else if ((dpa < ent->start_dpa + ent->len
> +				&& dpa + len > ent->start_dpa + ent->len)

Above is new entry would contain existing one.

> +				|| (dpa < ent->start_dpa && dpa + len > ent->start_dpa))
> +				return CXL_MBOX_INVALID_EXTENT_LIST;
> +		}
> +		// a new extent added

Why?  This function generally need more documentation.

> +		if (!ent) {
> +			ent = g_new0(CXLDCD_Extent, 1);
> +			assert(ent);

No need.  g_new0 will already have blown up before you get here.

> +			ent->start_dpa = dpa;
> +			ent->len = len;
> +			memset(ent->tag, 0, 0x10);
Allocated empty just above, still empty so no need to set it again.
> +			ent->shared_seq = 0;
> +			QTAILQ_INSERT_TAIL(extent_list, ent, node);
> +		}
> +	}
> +
> +	return CXL_MBOX_SUCCESS;
> +}
> +
> +/*
> + * Spec 3.0: 8.2.9.8.9.4
> + * Release Dynamic Capacity (opcode 4803h)
> + **/
> +static CXLRetCode cmd_dcd_release_dcd_capacity(struct cxl_cmd *cmd,
> +		CXLDeviceState *cxl_dstate,
> +		uint16_t *len_unused)
> +{
> +	struct release_dcd_cap_in_pl {
> +		uint32_t num_entries_updated;
> +		uint8_t rsvd[4];
> +		struct {
> +			uint64_t start_dpa;
> +			uint64_t len;
> +			uint8_t rsvd[8];
> +		} QEMU_PACKED updated_entries[];
> +	} QEMU_PACKED;
> +
> +	struct release_dcd_cap_in_pl *in = (void *)cmd->payload;
> +	struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +	CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +	CXLDCD_Extent *ent;
> +	uint32_t i;
> +	uint64_t dpa, len;
> +	CXLRetCode rs;
> +
> +	if (in->num_entries_updated == 0)
> +		return CXL_MBOX_INVALID_INPUT;
> +
> +	rs = detect_malformed_extent_list(ct3d, in);
> +	if (rs != CXL_MBOX_SUCCESS)
> +		return rs;
> +
> +		/* Todo: check following
> +		 * One or more of the updated extent lists contain Starting DPA
> +		 * or Lengths that are out of range of a current extent list
> +		 * maintained by the device.
> +		 **/
> +
> +	for (i = 0; i < in->num_entries_updated; i++) {
> +		dpa = in->updated_entries[i].start_dpa;
> +		len = in->updated_entries[i].len;
> +
> +		QTAILQ_FOREACH(ent, extent_list, node) {
> +			if (ent->start_dpa == dpa && ent->len == len)

Do the remove here and comment on 'found entry' not needed.
Note I think you can release partial extents so that will need handling at some point.

> +				break;
> +			else if ((dpa < ent->start_dpa + ent->len
> +				&& dpa + len > ent->start_dpa + ent->len)
> +				|| (dpa < ent->start_dpa && dpa + len > ent->start_dpa))
Comment on this condition and why it's a problem.

> +				return CXL_MBOX_INVALID_EXTENT_LIST;
> +		}
> +		/* found the entry, release it */
> +		if (ent)
> +			QTAILQ_REMOVE(extent_list, ent, node);
> +	}
> +
> +	return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1112,6 +1329,12 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>  	[DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
>  		"DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
>  		8, 0 },
> +	[DCD_CONFIG][ADD_DYN_CAP_RSP] = {
> +		"ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> +		~0, IMMEDIATE_DATA_CHANGE },
> +	[DCD_CONFIG][RELEASE_DYN_CAP] = {
> +		"RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dcd_capacity,
> +		~0, IMMEDIATE_DATA_CHANGE },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 20ad5e7411..c0c8fcc24b 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -131,7 +131,8 @@ typedef enum {
>      CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
>      CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
>      CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
> -    CXL_MBOX_MAX = 0x17
> +	CXL_MBOX_INVALID_EXTENT_LIST = 0x17,

0x1e in the spec.

> +	CXL_MBOX_MAX = 0x18
>  } CXLRetCode;
>  
>  struct cxl_cmd;

