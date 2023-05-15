Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945EAC77B7D
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 14:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjEOOxf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbjEOOxd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 10:53:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE23198B
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 07:53:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKj4b0W0Qz67M5Q;
        Mon, 15 May 2023 22:51:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 15:53:27 +0100
Date:   Mon, 15 May 2023 15:53:26 +0100
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
Subject: Re: [RFC 6/7] Add qmp interfaces to add/release dynamic capacity
 extents
Message-ID: <20230515155326.0000093f@Huawei.com>
In-Reply-To: <20230511175609.2091136-7-fan.ni@samsung.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175642uscas1p27cf2915c8184225bfd581fb6f6dfb2d9@uscas1p2.samsung.com>
        <20230511175609.2091136-7-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023 17:56:40 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Since fabric manager emulation is not supported yet, the change implements
> the functions to add/release dynamic capacity extents as QMP interfaces.

This makes sense at least as a stop gap.

> 
> 1. Add dynamic capacity extents:
> 
> For example, the command to add two continuous extents (each is 128MB
> long) to region 0 (starting at dpa offset 0) looks like below:
> 
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-add-dynamic-capacity-event",
>     "arguments": {
> 	"path": "/machine/peripheral/cxl-pmem0",
> 	"region-id" : 0,
> 	"num-extent": 2,
What does num-extent mean? 
A multiple entry injection mechanism makes sense but this
doesn't seem be one.  Look at the error injection stuff done
to ensure we could inject multiple of those as one atomic operation
to trigger the various multi error handling paths.

> 	"dpa":0,
> 	"extent-len": 128
> 	}
> }
> 
> 2. Release dynamic capacity extents:
> 
> For example, the command to release an extent of size 128MB from region
> 0 (starting at dpa offset 0) look like below:
> 
> { "execute": "cxl-release-dynamic-capacity-event",
> 	"arguments": {
> 		 "path": "/machine/peripheral/cxl-pmem0",
> 		"region-id" : 0,
> 		 "num-extent": 1 ,
> 		"dpa":0,
> 		"extent-len": 128
> 	}
> }
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 127 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_events.h |  16 +++++
>  qapi/cxl.json               |  44 +++++++++++++
>  3 files changed, 187 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 23954711b5..70d47d43b9 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1651,6 +1651,133 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> +static const QemuUUID dynamic_capacity_uuid = {
> +	.data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> +			0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +};
> +
> +static void qmp_cxl_process_dynamic_capacity_event(const char *path, CxlEventLog log,
> +		uint8_t flags, uint8_t type, uint16_t hid, uint8_t rid, uint32_t extent_cnt,
> +		CXLDCExtent_raw *extents, Error **errp)
> +{
> +	Object *obj = object_resolve_path(path, NULL);
> +	CXLEventDynamicCapacity dCap;
> +	CXLEventRecordHdr *hdr = &dCap.hdr;
> +	CXLDeviceState *cxlds;
> +	CXLType3Dev *dcd;
> +	int i;
> +
> +	if (!obj) {
> +		error_setg(errp, "Unable to resolve path");
> +		return;
> +	}
> +	if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +		error_setg(errp, "Path not point to a valid CXL type3 device");
> +		return;
> +	}
> +
> +	dcd = CXL_TYPE3(obj);
> +	cxlds = &dcd->cxl_dstate;
> +	memset(&dCap, 0, sizeof(dCap));
> +
> +	if (!dcd->dc.num_regions) {
> +		error_setg(errp, "No dynamic capacity support from the device");
> +		return;
> +	}
> +
> +	/*
> +	 * 8.2.9.1.5
> +	 * All Dynamic Capacity event records shall set the Event Record
> +	 * Severity field in the Common Event Record Format to Informational
> +	 * Event. All Dynamic Capacity related events shall be logged in the
> +	 * Dynamic Capacity Event Log.
> +	 */
> +	assert(flags & (1<<CXL_EVENT_TYPE_INFO));

Given this requirement, why pass in those flags at all? Just set it in here instead
thus ensuring it's always right.

> +	cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap));
> +
> +	/*
> +	 * 00h: add capacity
> +	 * 01h: release capacity

Enum for these so the input is typed.

> +	 * 02h: forced capacity release
> +	 * 03h: region configuration updated
> +	 * 04h: Add capacity response
> +	 * 05h: capacity released
> +	 **/
> +	dCap.type = type;
> +	stw_le_p(&dCap.host_id, hid);
> +	dCap.updated_region_id = rid;
> +	for (i = 0; i < extent_cnt; i++) {
> +		extents[i].start_dpa += dcd->dc.regions[rid].base;

Mixture of handling endian conversion and not.  Whilst we still have
a bunch of cleanup to do around this, new code should handle endian
conversions always.  If touching code with problems, a precursor patch
to fix that code up before adding new stuff would be great as well.

> +		memcpy(&dCap.dynamic_capacity_extent, &extents[i]
> +				, sizeof(CXLDCExtent_raw));

comma on previous line.

> +
> +		if (cxl_event_insert(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP,
> +					(CXLEventRecordRaw *)&dCap)) {
> +			;

?  Failure here indicates a bug or an overflow of the event log.
Both want handling.

> +		}
> +		cxl_event_irq_assert(dcd);
> +	}
> +}
> +
> +#define MEM_BLK_SIZE_MB 128
> +void qmp_cxl_add_dynamic_capacity_event(const char *path, uint8_t region_id,
> +		uint32_t num_exent, uint64_t dpa, uint64_t extent_len_MB, Error **errp)
> +{
> +	uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;

As above, no point in handling flags out here if they always have same value.
Push them to where it matters.

> +	CXLDCExtent_raw *extents;
> +	int i;
> +
> +	if (extent_len_MB < MEM_BLK_SIZE_MB) {
> +		error_setg(errp,
> +			"extent size cannot be smaller than memory block size (%dMB)",
> +			MEM_BLK_SIZE_MB);
> +		return;
> +	}
> +
> +	extents = g_new0(CXLDCExtent_raw, num_exent);

Ah. Raw extents used in here. Either combine the different definitions or bring
that one forwards to this patch.

> +	for (i = 0; i < num_exent; i++) {
> +		extents[i].start_dpa = dpa;
> +		extents[i].len = extent_len_MB*1024*1024;
> +		memset(extents[i].tag, 0, 0x10);
> +		extents[i].shared_seq = 0;
> +		dpa += extents[i].len;
> +	}
> +
> +	qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONAL,
> +			flags, 0x0, 0, region_id, num_exent, extents, errp);
> +
> +	g_free(extents);
> +}
> +
> +void qmp_cxl_release_dynamic_capacity_event(const char *path, uint8_t region_id,
> +		uint32_t num_exent, uint64_t dpa, uint64_t extent_len_MB, Error **errp)
> +{
> +	uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +	CXLDCExtent_raw *extents;
> +	int i;
> +
> +	if (extent_len_MB < MEM_BLK_SIZE_MB) {
> +		error_setg(errp,
> +			"extent size cannot be smaller than memory block size (%dMB)",
> +			MEM_BLK_SIZE_MB);
> +		return;
> +	}
> +
> +	extents = g_new0(CXLDCExtent_raw, num_exent);
> +	for (i = 0; i < num_exent; i++) {
> +		extents[i].start_dpa = dpa;
> +		extents[i].len = extent_len_MB*1024*1024;
> +		memset(extents[i].tag, 0, 0x10);
> +		extents[i].shared_seq = 0;
> +		dpa += extents[i].len;
> +	}
> +
> +	qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONAL,
> +			flags, 0x1, 0, region_id, num_exent, extents, errp);
> +
> +	g_free(extents);
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 089ba2091f..dd00458d1d 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -165,4 +165,20 @@ typedef struct CXLEventMemoryModule {
>      uint8_t reserved[0x3d];
>  } QEMU_PACKED CXLEventMemoryModule;
>  
> +/*
> + * Dynamic Capacity Event Record
> + * CXL Rev 3.0 Section 8.2.9.2.1.5: Table 8-47
> + * All fields little endian.
> + */
> +typedef struct CXLEventDynamicCapacity {
> +	CXLEventRecordHdr hdr;
> +	uint8_t type;
> +	uint8_t reserved1;
> +	uint16_t host_id;
> +	uint8_t updated_region_id;
> +	uint8_t reserved2[3];
> +	uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
> +	uint8_t reserved[0x20];
> +} QEMU_PACKED CXLEventDynamicCapacity;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 8b3d30cd71..c9a9a45ce4 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -264,3 +264,47 @@
>              'type': 'CxlCorErrorType'
>    }
>  }
> +
> +##
> +# @cxl-add-dynamic-capacity-event:
> +#
> +# Command to add dynamic capacity extent event
> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: region id
> +# @num-extent: number of extents to add, test only
Moving towards 
> +# @dpa: start dpa for the operation
> +# @extent-len: extent size in MB
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-add-dynamic-capacity-event',
> +  'data': { 'path': 'str',
> +           'region-id': 'uint8',
> +           'num-extent': 'uint32',

Look at how cxl-inject-uncorrectable-errors is done
as that handles a set of records all in one command and
we want similar here - so that we generate what it would
look like if the fm-api was used.

> +           'dpa':'uint64',
> +           'extent-len': 'uint64'
> +  }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity-event:
> +#
> +# Command to add dynamic capacity extent event
> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: region id
> +# @num-extent: number of extents to add, test only
> +# @dpa: start dpa for the operation
> +# @extent-len: extent size in MB
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-release-dynamic-capacity-event',
> +  'data': { 'path': 'str',
> +           'region-id': 'uint8',
> +           'num-extent': 'uint32',
> +           'dpa':'uint64',
> +           'extent-len': 'uint64'
> +  }
> +}

