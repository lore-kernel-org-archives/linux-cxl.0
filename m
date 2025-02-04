Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B2B208990
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664908; cv=none; b=HTEGjEelkD9pA/FFJgGtY4q26Z+T3LiRbGd0/iKByaMXr0YDmRqCGqzluWCDDq3pbaywm/lfe/CMyxw7HJBOrFaBcHYXtoX/TlHb+u2tOpLWudNBLQDErmeJJ6uNrs3aTU39t43T99lr9ijQq/Hcq4RdldgjdHmWdchGfZmBgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664908; c=relaxed/simple;
	bh=km8bdCj3rAbqxedw1X7goi0qwfEtapylHqBHD9aX8WM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTm3mh3hc9CK5uoLGXS++btgEfoqKUfbFzEVxRqmCyAs3MX6Ul1Wo45kCT2PyrGdILrbRouEmK94rNOK8hGksTOL2HyfrAdwG0iMzwCIQLeZ18arum9C1VeyQZN10U2HQ/mpiSIGBCnREYXreTY+xb5skn4exz1BvrELHFXUFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnKJW4srLz6L50m;
	Tue,  4 Feb 2025 18:25:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 84BAC140442;
	Tue,  4 Feb 2025 18:28:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 11:28:21 +0100
Date: Tue, 4 Feb 2025 10:28:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 1/3] hw/cxl/cxl-mailbox-utils.c: Added support for Get
 Log Capabilities (Opcode 0402h)
Message-ID: <20250204102820.000047fb@huawei.com>
In-Reply-To: <20250203055950.2126627-2-arpit1.kumar@samsung.com>
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
	<CGME20250203060051epcas5p350b7b24d3b5fcff25bc30e1acccd8121@epcas5p3.samsung.com>
	<20250203055950.2126627-2-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon,  3 Feb 2025 11:29:48 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

Please add some descriptive teext here.

> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>

Hi Arpit,

Whilst it is good to do internal reviews, I'd prefer to see feedback
on the mailing list if possible.  Hard for a maintainer to tell
what a RB tag given before posting means unfortunately so in most
cases preference is to not add RB tags based on internal review.
If your colleagues have greatly affected the code, a
Co-developed-by: and additional sign off may be a good way to
reflect that.

Great to have you working on these features. Some comments inline.
Main ones are around naming (always tricky!) and suggestion to
handle the arrays of log capabilities as static const pointers.

Thanks,

Jonathan


> ---
>  hw/cxl/cxl-mailbox-utils.c   | 55 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h  | 31 ++++++++++++++++++++
>  include/hw/cxl/cxl_mailbox.h |  5 ++++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c7ea5bc35..3d66a425a9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -76,6 +76,7 @@ enum {
>      LOGS        = 0x04,
>          #define GET_SUPPORTED 0x0
>          #define GET_LOG       0x1
> +        #define GET_LOG_CAPABILITIES   0x2
>      FEATURES    = 0x05,
>          #define GET_SUPPORTED 0x0
>          #define GET_FEATURE   0x1
> @@ -1075,6 +1076,45 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static int32_t valid_log_check(QemuUUID *uuid, CXLCCI *cci)

Perhaps find_log_index() or something like that?
I would return &ccx->supported_log_cap[i] / NULL if not found
as then can avoid long reference into array below.

> +{
> +    int32_t id = -1;
> +    for (int i = CEL; i < MAX_LOG_TYPE; i++) {
> +        if (qemu_uuid_is_equal(uuid,
> +            &cci->supported_log_cap[i].uuid)) {
> +            id = i;
> +            break;
> +        }
> +    }
> +    return id;
> +}
> +
> +/* CXL r3.1 Section 8.2.9.5.3: Get Log Capabilities (Opcode 0402h) */

For new documentation please use latest spec.
This is a bit different to many other spec where the request is the
earliest one. That is due to the consortium only making the latest
version available (currently r3.2)

> +static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
> +                                                uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out,
> +                                                CXLCCI *cci)
> +{
> +    int32_t cap_id;
> +    struct {
> +        QemuUUID uuid;
> +    } QEMU_PACKED QEMU_ALIGNED(8) * get_log_capabilities_in = (void *)payload_in;
> +
> +    CXLParamFlags *get_log_capabilities_out = (void *)payload_out;
> +
> +    cap_id = valid_log_check(&get_log_capabilities_in->uuid, cci);
    CXLLogCapabilities *cap;

    cap = find_log_cap(&get_log_capabilities_in->uuid, cci);
    if (!cap) {
        return CXL_MBOX_INVALID_LOG);
    }

    mempcy(get_log_capabilities_out, cap->param_flags.pflags,
           sizeof(cap->param_flags.pflags));
...

> +    if (cap_id == -1) {
> +        return CXL_MBOX_INVALID_LOG;
> +    }
> +
> +    memcpy(get_log_capabilities_out, &cci->supported_log_cap[cap_id].param_flags.pflags,
> +           sizeof(CXLParamFlags));
> +    *len_out = sizeof(*get_log_capabilities_out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* CXL r3.1 section 8.2.9.6: Features */
>  /*
>   * Get Supported Features output payload
> @@ -2840,6 +2880,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>                                0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> +    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
> +                                     cmd_logs_get_log_capabilities, 0x10, 0 },
>      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>                                    cmd_features_get_supported, 0x8, 0 },
>      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
> @@ -3084,10 +3126,23 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>      }
>  }
>  
> +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
> +    [CEL] = {.param_flags.pflags = CXL_LOG_CAP_CLEAR | CXL_LOG_CAP_POPULATE,
> +             .uuid = cel_uuid},
> +};
> +
> +static void cxl_init_get_log(CXLCCI *cci)
> +{
> +    for (int set = CEL; set < MAX_LOG_TYPE; set++) {
> +        cci->supported_log_cap[set] = cxl_get_log_cap[set];

As below. Can we just use a static const pointer in cci?
Seems relatively unlikely we'll have lots of different log combinations
depending on runtime configuration.  So may be better to just pick
between a few const arrays like cxl_get_log_cap.

Good to also store the length of that log or use a terminating entry
of some type so that we don't need to iterate over empty entries.

> +    }
> +}
> +
>  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>  {
>      cci->payload_max = payload_max;
>      cxl_rebuild_cel(cci);
> +    cxl_init_get_log(cci);
>  
>      cci->bg.complete_pct = 0;
>      cci->bg.starttime = 0;
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a64739be25..e7cb99a1d2 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -164,6 +164,18 @@ typedef enum {
>      CXL_MBOX_MAX = 0x20
>  } CXLRetCode;
>  
> +/* types of logs */
> +enum Logs {

For things in the header please prefix with CXL.  The chances
of a naming clash in future drivers that include this is too high
without that! 

Also QEMU tends to use typedefs for enums

typedef enum {
	CXL_LOG_CEL,
	CXL_LOG_VENDOR,
} CXLLogType;
or something like that.

Some of these abbreviations are a bit too compact and
don't line up with spec like CEL does.,




> +    CEL,
> +    VDL,
> +    CSDL,
CXL_LOG_COMPONENT_STATE_DUMP,
> +    ECSL,
CXL_LOG_ECS, //this one is standard acronym
> +    MTCL,
CXL_LOG_MEDIA_TEST_CAP
> +    MTRSL,
CXL_LOG_MEDIA_TEST_SHORT
> +    MTRLL,
CXL_LOG_MEDIA_TEST_LONG

perhaps?
> +    MAX_LOG_TYPE
> +};
> +
>  typedef struct CXLCCI CXLCCI;
>  typedef struct cxl_device_state CXLDeviceState;
>  struct cxl_cmd;
> @@ -194,6 +206,22 @@ typedef struct CXLEventLog {
>      QSIMPLEQ_HEAD(, CXLEvent) events;
>  } CXLEventLog;
>  
> +typedef struct CXLParamFlags {
> +    union {

Unless I'm reading this wrong this is a union of lots of flags
on top of each other.

Also, don't use bitfields. They don't play well with
different endian architectures. 
Defines for the various bits are a more reliable solution.
Similar to the ones you have below in cxl_mailbox.h


> +        uint32_t clear_log_supported:1;
> +        uint32_t populate_log_supported:1;
> +        uint32_t auto_populate_supported:1;
> +        uint32_t persistent_across_cold_reset:1;
> +        uint32_t reserved:28;
> +        uint32_t pflags;
> +    };
> +} CXLParamFlags;
> +
> +typedef struct CXLLogCapabilities {
> +    CXLParamFlags param_flags;
> +    QemuUUID uuid;
> +} CXLLogCapabilities;
> +
>  typedef struct CXLCCI {
>      struct cxl_cmd cxl_cmd_set[256][256];
>      struct cel_log {
> @@ -202,6 +230,9 @@ typedef struct CXLCCI {
>      } cel_log[1 << 16];
>      size_t cel_size;
>  
> +    /* get log capabilities */
> +    CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];
Perhaps a const pointer is appropriate?
> +
>      /* background command handling (times in ms) */
>      struct {
>          uint16_t opcode;
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 9008402d1c..f3502c3f68 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -16,4 +16,9 @@
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
>  
> +#define CXL_LOG_CAP_CLEAR 1
> +#define CXL_LOG_CAP_POPULATE (1 << 1)
> +#define CXL_LOG_CAP_AUTO_POPULATE (1 << 2)
> +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET (1 << 3)
> +
>  #endif

