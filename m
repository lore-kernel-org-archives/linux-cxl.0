Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E7293C63
	for <linux-cxl@vger.kernel.org>; Fri, 27 Jun 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017746; cv=none; b=qB9IlavrnQ1jsJQiPx30sDql8ll2Wzl1/rJv2FwXP6ORO+4sI9NccqsEwTf6Hb1NrxYKOE63DL+M3IYl/I/b/0ks4rVEsgYQfs9ibWEvPwG7aUawB0q379Jxtp8V9aG5xG1XniLWZqIr8RzCzyK3e6nN+iHgJ36oWXjH0mE3Xk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017746; c=relaxed/simple;
	bh=1z93C/xvv8I5NACXStaDhESr9HXN7W0adNSoPr4f3Qw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ur2jIJa2M5NAWSf5rQawgDMD+kig44v4N8aCYkrw5ITnzZtwFhPZxJ1y31Cc9vt3n5I6TKTs4Ww+cvYkO1tYyBeLERPKqgvL3qiL+SjjxguI5JcL3tZxU9mriahP33HAJ6ffa2Ev35FUV3tdiyDVq883Fp1O/6gOX1lzqJDE1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT9g33btfz6L5FJ;
	Fri, 27 Jun 2025 17:46:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F7A1140277;
	Fri, 27 Jun 2025 17:49:01 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 11:49:00 +0200
Date: Fri, 27 Jun 2025 10:48:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [HACK QEMU PATCH v1 1/1] hw/cxl: Fix MCTP Binding Check
Message-ID: <20250627104859.00003cbe@huawei.com>
In-Reply-To: <20250626235102.1902427-2-anisa.su887@gmail.com>
References: <20250626235102.1902427-1-anisa.su887@gmail.com>
	<20250626235102.1902427-2-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 23:41:15 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> Per the spec, FMAPI commands (0x51-0x59) must be bound with
> MCTP_MT_CXL_FMAPI. Fix the conditions ensuring this in i2c_mctp_cxl.c
> and dev-mctp.c
> 
> Move the opcode enum from cxl-mailbox-utils.c to cxl_mailbox.h to
> allow i2c_mctp_cxl.c and dev-mctp.c to use the enum instead of
> hardcoding the values.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
Why HACK in the patch title?

In general this seems reasonable - the complexity is how I merge it
into my tree given the code being modified slips in at various different
points. I'll sort that out though.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 74 +-----------------------------------
>  hw/cxl/i2c_mctp_cxl.c        |  6 ++-
>  hw/usb/dev-mctp.c            |  6 ++-
>  include/hw/cxl/cxl_mailbox.h | 73 +++++++++++++++++++++++++++++++++++
>  4 files changed, 82 insertions(+), 77 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4c01b25110..7f84e147f7 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -37,7 +37,7 @@
>  
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
> - *  1. Add the command set and cmd to the enum.
> + *  1. Add the command set and cmd to the enum in cxl_mailbox.h.
>   *     FOO    = 0x7f,
>   *          #define BAR 0
>   *  2. Implement the handler
> @@ -60,78 +60,6 @@
>   *  a register interface that already deals with it.
>   */
>  
> -enum {
> -    INFOSTAT    = 0x00,
> -        #define IS_IDENTIFY   0x1
> -        #define BACKGROUND_OPERATION_STATUS    0x2
> -        #define GET_RESPONSE_MSG_LIMIT         0x3
> -        #define SET_RESPONSE_MSG_LIMIT         0x4
> -        #define BACKGROUND_OPERATION_ABORT     0x5
> -    EVENTS      = 0x01,
> -        #define GET_RECORDS   0x0
> -        #define CLEAR_RECORDS   0x1
> -        #define GET_INTERRUPT_POLICY   0x2
> -        #define SET_INTERRUPT_POLICY   0x3
> -    FIRMWARE_UPDATE = 0x02,
> -        #define GET_INFO      0x0
> -        #define TRANSFER      0x1
> -        #define ACTIVATE      0x2
> -    TIMESTAMP   = 0x03,
> -        #define GET           0x0
> -        #define SET           0x1
> -    LOGS        = 0x04,
> -        #define GET_SUPPORTED 0x0
> -        #define GET_LOG       0x1
> -        #define GET_LOG_CAPABILITIES   0x2
> -        #define CLEAR_LOG     0x3
> -        #define POPULATE_LOG  0x4
> -    FEATURES    = 0x05,
> -        #define GET_SUPPORTED 0x0
> -        #define GET_FEATURE   0x1
> -        #define SET_FEATURE   0x2
> -    IDENTIFY    = 0x40,
> -        #define MEMORY_DEVICE 0x0
> -    CCLS        = 0x41,
> -        #define GET_PARTITION_INFO     0x0
> -        #define GET_LSA       0x2
> -        #define SET_LSA       0x3
> -    HEALTH_INFO_ALERTS = 0x42,
> -        #define GET_ALERT_CONFIG 0x1
> -        #define SET_ALERT_CONFIG 0x2
> -    SANITIZE    = 0x44,
> -        #define OVERWRITE     0x0
> -        #define SECURE_ERASE  0x1
> -        #define MEDIA_OPERATIONS 0x2
> -    PERSISTENT_MEM = 0x45,
> -        #define GET_SECURITY_STATE     0x0
> -    MEDIA_AND_POISON = 0x43,
> -        #define GET_POISON_LIST        0x0
> -        #define INJECT_POISON          0x1
> -        #define CLEAR_POISON           0x2
> -        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> -        #define SCAN_MEDIA             0x4
> -        #define GET_SCAN_MEDIA_RESULTS 0x5
> -    DCD_CONFIG  = 0x48,
> -        #define GET_DC_CONFIG          0x0
> -        #define GET_DYN_CAP_EXT_LIST   0x1
> -        #define ADD_DYN_CAP_RSP        0x2
> -        #define RELEASE_DYN_CAP        0x3
> -    PHYSICAL_SWITCH = 0x51,
> -        #define IDENTIFY_SWITCH_DEVICE      0x0
> -        #define GET_PHYSICAL_PORT_STATE     0x1
> -    TUNNEL = 0x53,
> -        #define MANAGEMENT_COMMAND     0x0
> -    MHD = 0x55,
> -        #define GET_MHD_INFO 0x0
> -    FMAPI_DCD_MGMT = 0x56,
> -        #define GET_DCD_INFO    0x0
> -        #define GET_HOST_DC_REGION_CONFIG   0x1
> -        #define SET_DC_REGION_CONFIG        0x2
> -        #define GET_DC_REGION_EXTENT_LIST   0x3
> -        #define INITIATE_DC_ADD             0x4
> -        #define INITIATE_DC_RELEASE         0x5
> -};
> -
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
>  typedef struct CXLCCIMessage {
>      uint8_t category;
> diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
> index 1714f36e8e..3f17779562 100644
> --- a/hw/cxl/i2c_mctp_cxl.c
> +++ b/hw/cxl/i2c_mctp_cxl.c
> @@ -29,6 +29,7 @@
>  #include "hw/pci/pcie_port.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/registerfields.h"
> +#include "hw/cxl/cxl_mailbox.h"
>  
>  #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
>  
> @@ -198,9 +199,10 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
>           */
>  
>          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> -              msg->command_set < 0x51) &&
> +              msg->command_set < PHYSICAL_SWITCH) &&
>              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> +              msg->command_set >= PHYSICAL_SWITCH &&
> +              msg->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
>              buf->rc = CXL_MBOX_UNSUPPORTED;
>              st24_le_p(buf->pl_length, len_out);
>              s->len = s->pos;
> diff --git a/hw/usb/dev-mctp.c b/hw/usb/dev-mctp.c
> index aafb9e7e96..b82a269561 100644
> --- a/hw/usb/dev-mctp.c
> +++ b/hw/usb/dev-mctp.c
> @@ -25,6 +25,7 @@
>  #include "hw/usb.h"
>  #include "hw/usb/desc.h"
>  #include "net/mctp.h"
> +#include "hw/cxl/cxl_mailbox.h"
>  
>  /* TODO: Move to header */
>  
> @@ -504,9 +505,10 @@ static void usb_cxl_mctp_handle_data(USBDevice *dev, USBPacket *p)
>           * onwards.
>           */
>          if (!(req->message_type == MCTP_MT_CXL_TYPE3 &&
> -              req->command_set < 0x51) &&
> +              req->command_set < PHYSICAL_SWITCH) &&
>              !(req->message_type == MCTP_MT_CXL_FMAPI &&
> -              req->command_set >= 0x51 && req->command_set < 0x56)) {
> +              req->command_set >= PHYSICAL_SWITCH &&
> +              req->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
>              len_out = 0;
>              usb_pkt_len = sizeof(MCTPUSBPacket) + sizeof(CXLMCTPMessage) +
>                  len_out;
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 820c411cbb..209a11ecbc 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -27,4 +27,77 @@
>  #define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
>  #define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
>  
> +enum {
> +    INFOSTAT    = 0x00,
> +        #define IS_IDENTIFY   0x1
> +        #define BACKGROUND_OPERATION_STATUS    0x2
> +        #define GET_RESPONSE_MSG_LIMIT         0x3
> +        #define SET_RESPONSE_MSG_LIMIT         0x4
> +        #define BACKGROUND_OPERATION_ABORT     0x5
> +    EVENTS      = 0x01,
> +        #define GET_RECORDS   0x0
> +        #define CLEAR_RECORDS   0x1
> +        #define GET_INTERRUPT_POLICY   0x2
> +        #define SET_INTERRUPT_POLICY   0x3
> +    FIRMWARE_UPDATE = 0x02,
> +        #define GET_INFO      0x0
> +        #define TRANSFER      0x1
> +        #define ACTIVATE      0x2
> +    TIMESTAMP   = 0x03,
> +        #define GET           0x0
> +        #define SET           0x1
> +    LOGS        = 0x04,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_LOG       0x1
> +        #define GET_LOG_CAPABILITIES   0x2
> +        #define CLEAR_LOG     0x3
> +        #define POPULATE_LOG  0x4
> +    FEATURES    = 0x05,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_FEATURE   0x1
> +        #define SET_FEATURE   0x2
> +    IDENTIFY    = 0x40,
> +        #define MEMORY_DEVICE 0x0
> +    CCLS        = 0x41,
> +        #define GET_PARTITION_INFO     0x0
> +        #define GET_LSA       0x2
> +        #define SET_LSA       0x3
> +    HEALTH_INFO_ALERTS = 0x42,
> +        #define GET_ALERT_CONFIG 0x1
> +        #define SET_ALERT_CONFIG 0x2
> +    SANITIZE    = 0x44,
> +        #define OVERWRITE     0x0
> +        #define SECURE_ERASE  0x1
> +        #define MEDIA_OPERATIONS 0x2
> +    PERSISTENT_MEM = 0x45,
> +        #define GET_SECURITY_STATE     0x0
> +    MEDIA_AND_POISON = 0x43,
> +        #define GET_POISON_LIST        0x0
> +        #define INJECT_POISON          0x1
> +        #define CLEAR_POISON           0x2
> +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> +        #define SCAN_MEDIA             0x4
> +        #define GET_SCAN_MEDIA_RESULTS 0x5
> +    DCD_CONFIG  = 0x48,
> +        #define GET_DC_CONFIG          0x0
> +        #define GET_DYN_CAP_EXT_LIST   0x1
> +        #define ADD_DYN_CAP_RSP        0x2
> +        #define RELEASE_DYN_CAP        0x3
> +    PHYSICAL_SWITCH = 0x51,
> +        #define IDENTIFY_SWITCH_DEVICE      0x0
> +        #define GET_PHYSICAL_PORT_STATE     0x1
> +    TUNNEL = 0x53,
> +        #define MANAGEMENT_COMMAND     0x0
> +    MHD = 0x55,
> +        #define GET_MHD_INFO 0x0
> +    FMAPI_DCD_MGMT = 0x56,
> +        #define GET_DCD_INFO    0x0
> +        #define GET_HOST_DC_REGION_CONFIG   0x1
> +        #define SET_DC_REGION_CONFIG        0x2
> +        #define GET_DC_REGION_EXTENT_LIST   0x3
> +        #define INITIATE_DC_ADD             0x4
> +        #define INITIATE_DC_RELEASE         0x5
> +    GLOBAL_MEM_ACCESS_EP_MGMT = 0X59,
> +};
> +
>  #endif

