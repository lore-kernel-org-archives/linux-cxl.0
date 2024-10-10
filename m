Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1014D6F9
	for <linux-cxl@vger.kernel.org>; Thu, 10 Oct 2024 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601747; cv=none; b=eXsQeFuFr4RRbiR5Bo2m88/w9oqXr/g7c457RTGjKlH7qInLU++4Hbh9arwWp57olaHhqhB2o/ECV2afXraAz95Q56Gx1TsN4iTJ8DxbCg7n/89q277w+tOBvwC++p+g0hEy10SWT4dBO/qB3q+hauKbZTuJ+BbtoZtlM9gZyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601747; c=relaxed/simple;
	bh=wGQOHx3WkJi2VOrbVET2u3x9MYzn10qlWr3u1U4UBL0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZx9oHN1F6vJL8vMCidYro8B+hjCXxFb/iP7T1esW1RAlmp109DwEPonP8Kmm3HZxtGr/YDeOegZSFiJ7JnDmnaaVU8NSJjV434WC+lRHwk7pfLaD0qlbNZ3qmVezChwRH0bZbqqt2F9VCQOXT7Pkl1ZdxYJ09ocVCzON8RmTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnY+BqdI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnY+BqdI"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so1638621b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 10 Oct 2024 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728601745; x=1729206545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoOIefwcl2zyGqbInaCBGQitWpP7kAS3EJcvu7ps+iU=;
        b=FnY+BqdICyeRwUhwKtIbJzp4bf896wOO2xJOEAHNkvULUEACB1MxOHeNuZPMYIwHPK
         DEre417J58eeRo+8bT3DizPw3yEMwSkIzi1O+uRK2tLqgsQeJJQ5AoQR+LU9RnNinXuq
         nJvnGS1oxpt9YqWlx0iaqtpSdiszPPsc9qbgAJlejEWOMfvOCI6biLPD5z5x5OIRdTVJ
         bTc4oxhVtKoCW3O7M0aeVh/Ru2Hnnq0lZrPQ5VFWx9+yYbNFjgeJlANTobQ/ugV9/ZwT
         BERclcp2oVgw4PYDoHtIpQfC/qxcE/ybbHLoTVl9QPldO2d65dKwSRlSSf2ERC09ZJRT
         NNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728601745; x=1729206545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoOIefwcl2zyGqbInaCBGQitWpP7kAS3EJcvu7ps+iU=;
        b=gyOsSh0tz2YVhRZNiNgomo/gXAjfb62+wXBAbm+IArSehW86RTHm2EIlnAQd7u7cmz
         ULwZEuNnI6WFmHT7Ae9e86nxPpchyciIMMu3uzPLOjdQYlLz3gQllUfGNM/vcHsiIbWR
         a/YmDVGEl2YpNhMh92bfMSsWqopa1nWJdE2aIUZpcirx0jiywQFg+LPLG/8wZi9P5FOi
         3QDyNORFcwaRwmiWfRkG6irLyv16LrP0TmuTLlD5eNfEsJTW2AhJJN7mlfoV/JHVU/KA
         /+K+j9e2RU4BsXqOnaYsYrSY3ARWrAUiDAJbHWO0a+POPjASjL3VYeXoxv+oVosVMAho
         ResQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj+21c5ZEVtm7Rc1nqvfeRe9PXvJvb10oYOY/e/p4dwtUyAFbHQVBofMNQOG4FPwJk5LZvtCt8bms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJhq6Q8FMeLciMYZ5auOVAaz5FbnW6hYsWjnXJ+MWSA4+bGQp
	XIv5wOU9aFmB+JW5hdBuuHeET6yGICKUx+ToteexcMtovO+UcNVo
X-Google-Smtp-Source: AGHT+IEnssj6iLPq8FvP3tyJbWCzWYVHNFcOJBhMOpVp2twnK6mEBduZuY76xG+FeTMmbAdxBpA6uA==
X-Received: by 2002:a05:6a20:7f9f:b0:1d7:86c:189e with SMTP id adf61e73a8af0-1d8ae0cfe7amr7855544637.12.1728601745487;
        Thu, 10 Oct 2024 16:09:05 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:c165:c800:4280:d79b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44907c42sm1531066a12.39.2024.10.10.16.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 16:09:05 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 10 Oct 2024 16:08:51 -0700
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH -qemu] hw/cxl: Support get/set mctp response payload size
Message-ID: <Zwheg1hFMG_MYggX@fan>
References: <20241010014157.175548-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010014157.175548-1-dave@stgolabs.net>

On Wed, Oct 09, 2024 at 06:41:57PM -0700, Davidlohr Bueso wrote:
> Add Get/Set Response Message Limit commands.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

The commit log may include the cxl spec reference. Otherwise,

Reviewed-by: Fan Ni <fan.ni@samsung.com>


> ---
>  hw/cxl/cxl-mailbox-utils.c | 68 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c2d776bc96eb..98416af794bb 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -7,6 +7,8 @@
>   * COPYING file in the top-level directory.
>   */
>  
> +#include <math.h>
> +
>  #include "qemu/osdep.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
> @@ -56,6 +58,8 @@ enum {
>      INFOSTAT    = 0x00,
>          #define IS_IDENTIFY   0x1
>          #define BACKGROUND_OPERATION_STATUS    0x2
> +        #define GET_RESPONSE_MSG_LIMIT   0x3
> +        #define SET_RESPONSE_MSG_LIMIT   0x4
>      EVENTS      = 0x01,
>          #define GET_RECORDS   0x0
>          #define CLEAR_RECORDS   0x1
> @@ -393,7 +397,7 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
>          uint16_t pcie_subsys_vid;
>          uint16_t pcie_subsys_id;
>          uint64_t sn;
> -    uint8_t max_message_size;
> +        uint8_t max_message_size;
>          uint8_t component_type;
>      } QEMU_PACKED *is_identify;
>      QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
> @@ -422,12 +426,58 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
>          is_identify->component_type = 0x3; /* Type 3 */
>      }
>  
> -    /* TODO: Allow this to vary across different CCIs */
> -    is_identify->max_message_size = 9; /* 512 bytes - MCTP_CXL_MAILBOX_BYTES */
> +    is_identify->max_message_size = (uint8_t)log2(cci->payload_max);
>      *len_out = sizeof(*is_identify);
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.1 section 8.2.9.1.3: Get Response Message Limit (Opcode 0003h) */
> +static CXLRetCode cmd_get_response_msg_limit(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t rsp_limit;
> +    } QEMU_PACKED *get_rsp_msg_limit = (void *)payload_out;
> +    QEMU_BUILD_BUG_ON(sizeof(*get_rsp_msg_limit) != 1);
> +
> +    get_rsp_msg_limit->rsp_limit = (uint8_t)log2(cci->payload_max);
> +
> +    *len_out = sizeof(*get_rsp_msg_limit);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* CXL r3.1 section 8.2.9.1.4: Set Response Message Limit (Opcode 0004h) */
> +static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t rsp_limit;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    QEMU_BUILD_BUG_ON(sizeof(*in) != 1);
> +    struct {
> +        uint8_t rsp_limit;
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    QEMU_BUILD_BUG_ON(sizeof(*out) != 1);
> +
> +    if (in->rsp_limit < 8 || in->rsp_limit > 10) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    cci->payload_max = 1 << in->rsp_limit;
> +    out->rsp_limit = in->rsp_limit;
> +
> +    *len_out = sizeof(*out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
>                                    void *private)
>  {
> @@ -3000,6 +3050,10 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>  
>  static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
>      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
> +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> +                                           cmd_get_response_msg_limit, 0, 0 },
> +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> +                                           cmd_set_response_msg_limit, 1, 0 },
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
>                                0 },
> @@ -3035,6 +3089,10 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>  
>  static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
>      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0,  0},
> +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> +                                           cmd_get_response_msg_limit, 0, 0 },
> +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> +                                           cmd_set_response_msg_limit, 1, 0 },
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
>                                0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> @@ -3055,6 +3113,10 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
>  
>  static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
>      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
> +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> +                                           cmd_get_response_msg_limit, 0, 0 },
> +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> +                                           cmd_set_response_msg_limit, 1, 0 },
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>                                0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> -- 
> 2.46.1
> 

-- 
Fan Ni
